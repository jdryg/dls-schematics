require('hdl');
require('adder');
local memoize = require('memoize');

hdlRegisterAdder(adc);

makeUART_Tx = memoize(function (CLKS_PER_BIT)
  local moduleName = "UART Rx (" .. tostring(CLKS_PER_BIT) .. ")";
  local counterType = bit[bit_length(CLKS_PER_BIT)];

  return module(moduleName)(function ()
    -- States
    local s_IDLE         = const(bit[3], 0);
    local s_TX_START_BIT = const(bit[3], 1);
    local s_TX_DATA_BITS = const(bit[3], 2);
    local s_TX_STOP_BIT  = const(bit[3], 3);
    local s_CLEANUP      = const(bit[3], 4);

    -- Inputs
    i_Clock   = input(bit, "clk");
    i_Tx_DV   = input(bit, "valid");
    i_Tx_Byte = input(bit[8], "Din");
    i_rst_n   = input(bit, "rst_n");

    -- Registers
    r_SM_Main     = register(bit[3], i_Clock, i_rst_n);
    r_Clock_Count = register(bit[8], i_Clock, i_rst_n);
    r_Bit_Index   = register(bit[3], i_Clock, i_rst_n);
    r_Tx_Data     = register(bit[8], i_Clock, i_rst_n);
    r_Tx_Done     = register(bit, i_Clock, i_rst_n);
    r_Tx_Active   = register(bit, i_Clock, i_rst_n);
    r_Tx_Serial   = register(bit, i_Clock, i_rst_n);

    -- Common control signals
    clockEnd    = eq(r_Clock_Count, CLKS_PER_BIT-1);
    lastBit     = eq(r_Bit_Index, 7);

    switch(r_SM_Main) {
      case(s_IDLE) {
        assign(r_Tx_Done, 0),
        assign(r_Clock_Count, 0),
        assign(r_Bit_Index, 0),
        assign(r_Tx_Active, i_Tx_DV),
        assign(r_Tx_Data, when(i_Tx_DV, i_Tx_Byte, r_Tx_Data)),
        assign(r_SM_Main, when(i_Tx_DV, s_TX_START_BIT, s_IDLE)),
      },
      case(s_TX_START_BIT) {
        assign(r_Clock_Count, when(clockEnd, const(bit[8], 0), r_Clock_Count + 1)),
        assign(r_SM_Main, when(clockEnd, s_TX_DATA_BITS, s_TX_START_BIT)),
      },
      case(s_TX_DATA_BITS) {
        assign(r_Clock_Count, when(clockEnd, const(bit[8], 0), r_Clock_Count + 1)),
        assign(r_SM_Main, when(clockEnd, when(lastBit, s_TX_STOP_BIT, s_TX_DATA_BITS), s_TX_DATA_BITS)),
        assign(r_Bit_Index, when(clockEnd, when(lastBit, const(bit[3], 0), r_Bit_Index + 1), r_Bit_Index))
      },
      case(s_TX_STOP_BIT) {
        assign(r_Tx_Done, clockEnd),
        assign(r_Clock_Count, when(clockEnd, const(bit[8], 0), r_Clock_Count + 1)),
        assign(r_SM_Main, when(clockEnd, s_CLEANUP, s_TX_STOP_BIT)),
        assign(r_Tx_Active, ~clockEnd)
      },
      case(s_CLEANUP) {
        assign(r_SM_Main, s_IDLE)
      }
    }

    selectedBit = mux8(
      r_Tx_Data[1], 
      r_Tx_Data[2], 
      r_Tx_Data[3], 
      r_Tx_Data[4], 
      r_Tx_Data[5], 
      r_Tx_Data[6], 
      r_Tx_Data[7], 
      r_Tx_Data[8], 
      r_Bit_Index
    );
    assign(r_Tx_Serial, when(eq(r_SM_Main, s_TX_DATA_BITS), selectedBit, ~eq(r_SM_Main, s_TX_START_BIT)));

    Dout = output(r_Tx_Serial);
    active = output(r_Tx_Active);
    done = output(r_Tx_Done);
  end);
end);
