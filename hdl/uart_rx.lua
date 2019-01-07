require('hdl');
require('adder');
local memoize = require('memoize');

hdlRegisterAdder(adc);

makeUART_Rx = memoize(function (CLKS_PER_BIT)
  local moduleName = "UART Rx (" .. tostring(CLKS_PER_BIT) .. ")";
  local counterType = bit[bit_length(CLKS_PER_BIT)];

  return module(moduleName)(function ()
    -- States
    local s_IDLE         = const(bit[3], 0);
    local s_RX_START_BIT = const(bit[3], 1);
    local s_RX_DATA_BITS = const(bit[3], 2);
    local s_RX_STOP_BIT  = const(bit[3], 3);
    local s_CLEANUP      = const(bit[3], 4);

    -- Inputs
    i_Clock     = input(bit, "clk");
    i_Rx_Serial = input(bit, "Din");
    i_rst_n     = input(bit, "rst_n");

    -- Registers
    r_Clock_Count = register(counterType, i_Clock, i_rst_n);
    r_Bit_Index   = register(bit[3], i_Clock, i_rst_n);
    r_SM_Main     = register(bit[3], i_Clock, i_rst_n);
    r_Rx_DV       = register(bit, i_Clock, i_rst_n);

    -- Common control signals
    clockEnd    = eq(r_Clock_Count, CLKS_PER_BIT-1);
    clockMiddle = eq(r_Clock_Count, (CLKS_PER_BIT-1)//2);
    lastBit     = eq(r_Bit_Index, 7);

    switch(r_SM_Main) {
      case(s_IDLE) {
        assign(r_Clock_Count, 0),
        assign(r_Bit_Index, 0),
        assign(r_SM_Main, when(i_Rx_Serial, s_IDLE, s_RX_START_BIT))
      },
      case(s_RX_START_BIT) {
        assign(r_Rx_DV, 0),
        assign(r_Clock_Count, when(clockMiddle, when(i_Rx_Serial, r_Clock_Count, const(counterType, 0)), r_Clock_Count + 1)),
        assign(r_SM_Main,     when(clockMiddle, when(i_Rx_Serial, s_IDLE, s_RX_DATA_BITS), s_RX_START_BIT))
      },
      case(s_RX_DATA_BITS) {
        assign(r_Clock_Count, when(clockEnd, const(counterType, 0), r_Clock_Count + 1)),
        assign(r_SM_Main,     when(clockEnd, when(lastBit, s_RX_STOP_BIT, s_RX_DATA_BITS), s_RX_DATA_BITS)),
        assign(r_Bit_Index,   when(clockEnd, when(lastBit, const(bit[3], 0), r_Bit_Index + 1), r_Bit_Index))
      },
      case(s_RX_STOP_BIT) {
        assign(r_Clock_Count, when(clockEnd, const(counterType, 0), r_Clock_Count + 1)),
        assign(r_SM_Main, when(clockEnd, s_CLEANUP, s_RX_STOP_BIT)),
        assign(r_Rx_DV, clockEnd)
      },
      case(s_CLEANUP) {
        assign(r_SM_Main, s_IDLE),
      },
      default() {
        assign(r_SM_Main, s_IDLE),
        assign(r_Clock_Count, 0),
        assign(r_Bit_Index, 0)
      }
    }

    writeEnableRxByte = eq(r_SM_Main, s_RX_DATA_BITS) & clockEnd;
    r_Rx_Byte = {};
    for i=1,8 do
      r_Rx_Byte[i] = register(bit, i_Clock, i_rst_n);
      assign(r_Rx_Byte[i], when(writeEnableRxByte & eq(r_Bit_Index, const(bit[3], i - 1)), i_Rx_Serial, r_Rx_Byte[i]));
    end

    Dout = output(bits(r_Rx_Byte));
    valid = output(r_Rx_DV);
  end);
end);
