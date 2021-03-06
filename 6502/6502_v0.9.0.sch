SCHM  INPL   PBTNa��C  \C   reset     CLKP  �C   B   clk    INPP  �C  �B   mult �   OUTL   DISP���D�ӁD   Screen@  �    GATE   EXTG  D  �C   EXTG  D  �C    BUS_��D��C SCRP  D   B
   Clock mult�  bit32 = bit;

dt = 30;

function init(component)
  component.addInput("clk", 1);
  component.addInput("mult", 8);
  component.addOutput("clk", 1);

  CLK_prevClockLevel = 0;
end

function simulate(inputs)
  local gateOutput = {};
  local clk = inputs[1];
  local mult = inputs[2];

  if(mult == 0 or mult == V_UNDEFINED or mult == V_ERROR) then
    mult = 1;
  end

  if(clk ~= V_UNDEFINED and CLK_prevClockLevel ~= V_UNDEFINED) then
    if(bit32.bxor(CLK_prevClockLevel, clk)) then
      -- Tick N-1 times...
      local curTime = 0;
      local goid = 1;
      for i=0, mult - 2, 1 do
        gateOutput[goid + 0] = { t = curTime, outputs = { clk }};
        gateOutput[goid + 1] = { t = curTime + dt, outputs = {bit32.band(clk + 1, 1)}};
        curTime = curTime + (2 * dt);
        goid = goid + 2;
      end

      gateOutput[goid] = { t = curTime, outputs = {clk}};
    end
  end

  CLK_prevClockLevel = clk;

  return gateOutput;
end
SCRPJ D�o*C   6502��  bit32 = bit;
ENABLE_LOGGING = false;

-- Addressing modes
ADDR_IMPLIED = 0;
ADDR_ACCUMULATOR = 1;
ADDR_IMMEDIATE = 2;
ADDR_ZERO_PAGE = 3;
ADDR_ZERO_PAGE_X = 4;
ADDR_ZERO_PAGE_Y = 5;
ADDR_RELATIVE = 6;
ADDR_ABSOLUTE = 7;
ADDR_ABSOLUTE_X = 8;
ADDR_ABSOLUTE_Y = 9;
ADDR_INDIRECT = 10;
ADDR_INDIRECT_X = 11;
ADDR_INDIRECT_Y = 12;

-- Status flags
F_CARRY = 0;
F_ZERO = 1;
F_IRQ_DISABLE = 2;
F_DECIMAL = 3;
F_BREAK = 4;
F_OVERFLOW = 6;
F_NEGATIVE = 7;

-- Instructions
I_INVALID = 0;
I_ADC = 1;
I_AND = 2;
I_ASL = 3;
I_BCC = 4;
I_BCS = 5;
I_BEQ = 6;
I_BIT = 7;
I_BMI = 8;
I_BNE = 9;
I_BPL = 10;
I_BRK = 11;
I_BVC = 12;
I_BVS = 13;
I_CLC = 14;
I_CLD = 15;
I_CLI = 16;
I_CLV = 17;
I_CMP = 18;
I_CPX = 19;
I_CPY = 20;
I_DEC = 21;
I_DEX = 22;
I_DEY = 23;
I_EOR = 24;
I_INC = 25;
I_INX = 26;
I_INY = 27;
I_JMP = 28;
I_JSR = 29;
I_LDA = 30;
I_LDX = 31;
I_LDY = 32;
I_LSR = 33;
I_NOP = 34;
I_ORA = 35;
I_PHA = 36;
I_PHP = 37;
I_PLA = 38;
I_PLP = 39;
I_ROL = 40;
I_ROR = 41;
I_RTI = 42;
I_RTS = 43;
I_SBC = 44;
I_SEC = 45;
I_SED = 46;
I_SEI = 47;
I_STA = 48;
I_STX = 49;
I_STY = 50;
I_TAX = 51;
I_TAY = 52;
I_TYA = 53;
I_TSX = 54;
I_TXA = 55;
I_TXS = 56;

-- CPU state
S_RESET = 0;
S_RUNNING = 1;

InstrInfo = {
  { mnemonic = I_BRK, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_ORA, numBytes = 2, addrMode = ADDR_INDIRECT_X },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_ORA, numBytes = 2, addrMode = ADDR_ZERO_PAGE },
  { mnemonic = I_ASL, numBytes = 2, addrMode = ADDR_ZERO_PAGE },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_PHP, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_ORA, numBytes = 2, addrMode = ADDR_IMMEDIATE },
  { mnemonic = I_ASL, numBytes = 1, addrMode = ADDR_ACCUMULATOR },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_ORA, numBytes = 3, addrMode = ADDR_ABSOLUTE },
  { mnemonic = I_ASL, numBytes = 3, addrMode = ADDR_ABSOLUTE },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_BPL, numBytes = 2, addrMode = ADDR_RELATIVE },
  { mnemonic = I_ORA, numBytes = 2, addrMode = ADDR_INDIRECT_Y },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_ORA, numBytes = 2, addrMode = ADDR_ZERO_PAGE_X },
  { mnemonic = I_ASL, numBytes = 2, addrMode = ADDR_ZERO_PAGE_X },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_CLC, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_ORA, numBytes = 3, addrMode = ADDR_ABSOLUTE_Y },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_ORA, numBytes = 3, addrMode = ADDR_ABSOLUTE_X },
  { mnemonic = I_ASL, numBytes = 3, addrMode = ADDR_ABSOLUTE_X },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_JSR, numBytes = 3, addrMode = ADDR_ABSOLUTE },
  { mnemonic = I_AND, numBytes = 2, addrMode = ADDR_INDIRECT_X },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_BIT, numBytes = 2, addrMode = ADDR_ZERO_PAGE },
  { mnemonic = I_AND, numBytes = 2, addrMode = ADDR_ZERO_PAGE },
  { mnemonic = I_ROL, numBytes = 2, addrMode = ADDR_ZERO_PAGE },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_PLP, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_AND, numBytes = 2, addrMode = ADDR_IMMEDIATE },
  { mnemonic = I_ROL, numBytes = 1, addrMode = ADDR_ACCUMULATOR },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_BIT, numBytes = 3, addrMode = ADDR_ABSOLUTE },
  { mnemonic = I_AND, numBytes = 3, addrMode = ADDR_ABSOLUTE },
  { mnemonic = I_ROL, numBytes = 3, addrMode = ADDR_ABSOLUTE },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_BMI, numBytes = 2, addrMode = ADDR_RELATIVE },
  { mnemonic = I_AND, numBytes = 2, addrMode = ADDR_INDIRECT_Y },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_AND, numBytes = 2, addrMode = ADDR_ZERO_PAGE_X },
  { mnemonic = I_ROL, numBytes = 2, addrMode = ADDR_ZERO_PAGE_X },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_SEC, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_AND, numBytes = 3, addrMode = ADDR_ABSOLUTE_Y },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_AND, numBytes = 3, addrMode = ADDR_ABSOLUTE_X },
  { mnemonic = I_ROL, numBytes = 3, addrMode = ADDR_ABSOLUTE_X },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_RTI, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_EOR, numBytes = 2, addrMode = ADDR_INDIRECT_X },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_EOR, numBytes = 2, addrMode = ADDR_ZERO_PAGE },
  { mnemonic = I_LSR, numBytes = 2, addrMode = ADDR_ZERO_PAGE },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_PHA, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_EOR, numBytes = 2, addrMode = ADDR_IMMEDIATE },
  { mnemonic = I_LSR, numBytes = 1, addrMode = ADDR_ACCUMULATOR },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_JMP, numBytes = 3, addrMode = ADDR_ABSOLUTE },
  { mnemonic = I_EOR, numBytes = 3, addrMode = ADDR_ABSOLUTE },
  { mnemonic = I_LSR, numBytes = 3, addrMode = ADDR_ABSOLUTE },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_BVC, numBytes = 2, addrMode = ADDR_RELATIVE },
  { mnemonic = I_EOR, numBytes = 2, addrMode = ADDR_INDIRECT_Y },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_EOR, numBytes = 2, addrMode = ADDR_ZERO_PAGE_X },
  { mnemonic = I_LSR, numBytes = 2, addrMode = ADDR_ZERO_PAGE_X },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_CLI, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_EOR, numBytes = 3, addrMode = ADDR_ABSOLUTE_Y },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_EOR, numBytes = 3, addrMode = ADDR_ABSOLUTE_X },
  { mnemonic = I_LSR, numBytes = 3, addrMode = ADDR_ABSOLUTE_X },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_RTS, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_ADC, numBytes = 2, addrMode = ADDR_INDIRECT_X },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_ADC, numBytes = 2, addrMode = ADDR_ZERO_PAGE },
  { mnemonic = I_ROR, numBytes = 2, addrMode = ADDR_ZERO_PAGE },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_PLA, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_ADC, numBytes = 2, addrMode = ADDR_IMMEDIATE },
  { mnemonic = I_ROR, numBytes = 1, addrMode = ADDR_ACCUMULATOR },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_JMP, numBytes = 3, addrMode = ADDR_INDIRECT },
  { mnemonic = I_ADC, numBytes = 3, addrMode = ADDR_ABSOLUTE },
  { mnemonic = I_ROR, numBytes = 3, addrMode = ADDR_ABSOLUTE },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_BVS, numBytes = 2, addrMode = ADDR_RELATIVE },
  { mnemonic = I_ADC, numBytes = 2, addrMode = ADDR_INDIRECT_Y },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_ADC, numBytes = 2, addrMode = ADDR_ZERO_PAGE_X },
  { mnemonic = I_ROR, numBytes = 2, addrMode = ADDR_ZERO_PAGE_X },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_SEI, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_ADC, numBytes = 3, addrMode = ADDR_ABSOLUTE_Y },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_ADC, numBytes = 3, addrMode = ADDR_ABSOLUTE_X },
  { mnemonic = I_ROR, numBytes = 3, addrMode = ADDR_ABSOLUTE_X },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_STA, numBytes = 2, addrMode = ADDR_INDIRECT_X },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_STY, numBytes = 2, addrMode = ADDR_ZERO_PAGE },
  { mnemonic = I_STA, numBytes = 2, addrMode = ADDR_ZERO_PAGE },
  { mnemonic = I_STX, numBytes = 2, addrMode = ADDR_ZERO_PAGE },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_DEY, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_TXA, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_STY, numBytes = 3, addrMode = ADDR_ABSOLUTE },
  { mnemonic = I_STA, numBytes = 3, addrMode = ADDR_ABSOLUTE },
  { mnemonic = I_STX, numBytes = 3, addrMode = ADDR_ABSOLUTE },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_BCC, numBytes = 2, addrMode = ADDR_RELATIVE },
  { mnemonic = I_STA, numBytes = 2, addrMode = ADDR_INDIRECT_Y },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_STY, numBytes = 2, addrMode = ADDR_ZERO_PAGE_X },
  { mnemonic = I_STA, numBytes = 2, addrMode = ADDR_ZERO_PAGE_X },
  { mnemonic = I_STX, numBytes = 2, addrMode = ADDR_ZERO_PAGE_Y },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_TYA, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_STA, numBytes = 3, addrMode = ADDR_ABSOLUTE_Y },
  { mnemonic = I_TXS, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_STA, numBytes = 3, addrMode = ADDR_ABSOLUTE_X },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_LDY, numBytes = 2, addrMode = ADDR_IMMEDIATE },
  { mnemonic = I_LDA, numBytes = 2, addrMode = ADDR_INDIRECT_X },
  { mnemonic = I_LDX, numBytes = 2, addrMode = ADDR_IMMEDIATE },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_LDY, numBytes = 2, addrMode = ADDR_ZERO_PAGE },
  { mnemonic = I_LDA, numBytes = 2, addrMode = ADDR_ZERO_PAGE },
  { mnemonic = I_LDX, numBytes = 2, addrMode = ADDR_ZERO_PAGE },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_TAY, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_LDA, numBytes = 2, addrMode = ADDR_IMMEDIATE },
  { mnemonic = I_TAX, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_LDY, numBytes = 3, addrMode = ADDR_ABSOLUTE },
  { mnemonic = I_LDA, numBytes = 3, addrMode = ADDR_ABSOLUTE },
  { mnemonic = I_LDX, numBytes = 3, addrMode = ADDR_ABSOLUTE },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_BCS, numBytes = 2, addrMode = ADDR_RELATIVE },
  { mnemonic = I_LDA, numBytes = 2, addrMode = ADDR_INDIRECT_Y },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_LDY, numBytes = 2, addrMode = ADDR_ZERO_PAGE_X },
  { mnemonic = I_LDA, numBytes = 2, addrMode = ADDR_ZERO_PAGE_X },
  { mnemonic = I_LDX, numBytes = 2, addrMode = ADDR_ZERO_PAGE_Y },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_CLV, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_LDA, numBytes = 3, addrMode = ADDR_ABSOLUTE_Y },
  { mnemonic = I_TSX, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_LDY, numBytes = 3, addrMode = ADDR_ABSOLUTE_X },
  { mnemonic = I_LDA, numBytes = 3, addrMode = ADDR_ABSOLUTE_X },
  { mnemonic = I_LDX, numBytes = 3, addrMode = ADDR_ABSOLUTE_Y },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_CPY, numBytes = 2, addrMode = ADDR_IMMEDIATE },
  { mnemonic = I_CMP, numBytes = 2, addrMode = ADDR_INDIRECT_X },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_CPY, numBytes = 2, addrMode = ADDR_ZERO_PAGE },
  { mnemonic = I_CMP, numBytes = 2, addrMode = ADDR_ZERO_PAGE },
  { mnemonic = I_DEC, numBytes = 2, addrMode = ADDR_ZERO_PAGE },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_INY, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_CMP, numBytes = 2, addrMode = ADDR_IMMEDIATE },
  { mnemonic = I_DEX, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_CPY, numBytes = 3, addrMode = ADDR_ABSOLUTE },
  { mnemonic = I_CMP, numBytes = 3, addrMode = ADDR_ABSOLUTE },
  { mnemonic = I_DEC, numBytes = 3, addrMode = ADDR_ABSOLUTE },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_BNE, numBytes = 2, addrMode = ADDR_RELATIVE },
  { mnemonic = I_CMP, numBytes = 2, addrMode = ADDR_INDIRECT_Y },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_CMP, numBytes = 2, addrMode = ADDR_ZERO_PAGE_X },
  { mnemonic = I_DEC, numBytes = 2, addrMode = ADDR_ZERO_PAGE_X },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_CLD, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_CMP, numBytes = 3, addrMode = ADDR_ABSOLUTE_Y },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_CMP, numBytes = 3, addrMode = ADDR_ABSOLUTE_X },
  { mnemonic = I_DEC, numBytes = 3, addrMode = ADDR_ABSOLUTE_X },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_CPX, numBytes = 2, addrMode = ADDR_IMMEDIATE },
  { mnemonic = I_SBC, numBytes = 2, addrMode = ADDR_INDIRECT_X },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_CPX, numBytes = 2, addrMode = ADDR_ZERO_PAGE },
  { mnemonic = I_SBC, numBytes = 2, addrMode = ADDR_ZERO_PAGE },
  { mnemonic = I_INC, numBytes = 2, addrMode = ADDR_ZERO_PAGE },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_INX, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_SBC, numBytes = 2, addrMode = ADDR_IMMEDIATE },
  { mnemonic = I_NOP, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_CPX, numBytes = 3, addrMode = ADDR_ABSOLUTE },
  { mnemonic = I_SBC, numBytes = 3, addrMode = ADDR_ABSOLUTE },
  { mnemonic = I_INC, numBytes = 3, addrMode = ADDR_ABSOLUTE },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_BEQ, numBytes = 2, addrMode = ADDR_RELATIVE },
  { mnemonic = I_SBC, numBytes = 2, addrMode = ADDR_INDIRECT_Y },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_SBC, numBytes = 2, addrMode = ADDR_ZERO_PAGE_X },
  { mnemonic = I_INC, numBytes = 2, addrMode = ADDR_ZERO_PAGE_X },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_SED, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_SBC, numBytes = 3, addrMode = ADDR_ABSOLUTE_Y },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
  { mnemonic = I_SBC, numBytes = 3, addrMode = ADDR_ABSOLUTE_X },
  { mnemonic = I_INC, numBytes = 3, addrMode = ADDR_ABSOLUTE_X },
  { mnemonic = I_INVALID, numBytes = 1, addrMode = ADDR_IMPLIED },
};

function init(component)
  -- Clock
  component.addInput("clk", 1);
  
  -- Reset
  component.addInput("reset", 1);
  
  -- Data input (from memory to the processor)
  component.addInput("Di", 8);
  
  -- Address bus
  component.addOutput("ADL", 8);
  component.addOutput("ADH", 8);
  
  -- Data output (from the processor to memory)
  component.addOutput("Do", 8);
  
  -- R/W line. When HIGH, the processor executes a READ operation, otherwise it's going to write data to memory.
  component.addOutput("re", 1); -- re = ReadEnable

  CPU_init();
end

function simulate(inputs) 
  local clk = inputs[1];
  local reset = inputs[2];
  local dataIn = inputs[3];

  local res = { 
    V_UNDEFINED, -- ADL
    V_UNDEFINED, -- ADH
    V_UNDEFINED, -- Do
    V_UNDEFINED  -- re
  };
  
  if(clk == V_ERROR or reset == V_ERROR) then
    res[1] = V_ERROR;
    res[2] = V_ERROR;
    res[3] = V_ERROR;
    res[4] = V_ERROR;
  elseif(clk ~= V_UNDEFINED and reset ~= V_UNDEFINED) then
    CPU_tick(clk, reset, dataIn);

    res[1] = bit32.band(CPU_addressBus, 0x000000FF);
    res[2] = bit32.band(bit32.rshift(CPU_addressBus, 8), 0x000000FF);
    res[3] = CPU_dataOut;
    res[4] = CPU_readEnable;
  end

  return {
      { t = 1, outputs = res }
  };
end

function CPU_init()
  CPU_addressBus = V_UNDEFINED;
  CPU_dataOut = V_UNDEFINED;
  CPU_readEnable = V_UNDEFINED;
  CPU_registers = {
    A = V_UNDEFINED,
    X = V_UNDEFINED,
    Y = V_UNDEFINED,
    SP = V_UNDEFINED,
    PC = V_UNDEFINED,
    status = V_UNDEFINED,
    
    -- Internal
    ADL = V_UNDEFINED,
    ADH = V_UNDEFINED,
    BAL = V_UNDEFINED,
    BAH = V_UNDEFINED,
    IAL = V_UNDEFINED,
    IAH = V_UNDEFINED,
    RMWData = V_UNDEFINED,
    branchOffset = V_UNDEFINED
  };

  CPU_instrTime = 0;
  CPU_instruction = null;
  CPU_prevClockLevel = V_UNDEFINED;
  CPU_PCDelta = 0;
  CPU_status = S_RUNNING;
  CPU_instrOffset = 0;
end

function CPU_tick(clk, reset, dataIn) 
  if(reset == 1) then
    CPU_registers.A = 0;
    CPU_registers.X = 0;
    CPU_registers.Y = 0;
    CPU_registers.SP = 0;
    CPU_registers.PC = 0xFFFC; -- Read the reset vector.
    CPU_registers.status = 0;
    CPU_registers.ADL = 0;
    CPU_registers.ADH = 0;
    CPU_registers.BAL = 0;
    CPU_registers.BAH = 0;
    CPU_registers.IAL = 0;
    CPU_registers.IAH = 0;
    CPU_registers.RMWData = 0;
    CPU_registers.branchOffset = 0;
    CPU_instruction = nil;
    CPU_prevClockLevel = V_UNDEFINED;

    CPU_stepInstruction(1, 0, 1, CPU_registers.PC);
    CPU_status = S_RESET;
  else
    if(CPU_prevClockLevel == 0 and clk == 1) then
      -- Rising edge of the clock. 
      if(CPU_status == S_RUNNING) then
        if(CPU_instrTime == 0) then
          -- Opcode
          CPU_instruction = InstrInfo[dataIn + 1];
          CPU_stepInstruction(1, 1, 1, CPU_registers.PC + 1);
        else
          -- We already have the opcode. Execute the instruction
          local mnemonic = CPU_instruction.mnemonic;
          if(mnemonic == I_ADC) then
            CPU_execInternalOnMemoryData(CPU_instruction.addrMode, dataIn, CPU_ADC, "ADC");
          elseif(mnemonic == I_AND) then
            CPU_execInternalOnMemoryData(CPU_instruction.addrMode, dataIn, CPU_AND, "AND");
          elseif(mnemonic == I_ASL) then
            if(CPU_instruction.addrMode == ADDR_ACCUMULATOR) then
              CPU_execSingleByteInstruction(function () CPU_registers.A = CPU_ASL(CPU_registers.A); end, "ASL A");
            else
              CPU_execRMWOp(CPU_instruction.addrMode, dataIn, CPU_ASL, "ASL");
            end
          elseif(mnemonic == I_BCC) then
            CPU_execBranch(dataIn, not CPU_getStatusBit(F_CARRY), "BCC");
          elseif(mnemonic == I_BCS) then
            CPU_execBranch(dataIn, CPU_getStatusBit(F_CARRY), "BCS");
          elseif(mnemonic == I_BEQ) then
            CPU_execBranch(dataIn, CPU_getStatusBit(F_ZERO), "BEQ");
          elseif(mnemonic == I_BIT) then
            CPU_execInternalOnMemoryData(CPU_instruction.addrMode, dataIn, CPU_BIT, "BIT");
          elseif(mnemonic == I_BMI) then
            CPU_execBranch(dataIn, CPU_getStatusBit(F_NEGATIVE), "BMI");
          elseif(mnemonic == I_BNE) then
            CPU_execBranch(dataIn, not CPU_getStatusBit(F_ZERO), "BNE");
          elseif(mnemonic == I_BPL) then
            CPU_execBranch(dataIn, not CPU_getStatusBit(F_NEGATIVE), "BPL");
          elseif(mnemonic == I_BRK) then
            -- TODO: 
          elseif(mnemonic == I_BVC) then
            CPU_execBranch(dataIn, not CPU_getStatusBit(F_OVERFLOW), "BVC");
          elseif(mnemonic == I_BVS) then
            CPU_execBranch(dataIn, CPU_getStatusBit(F_OVERFLOW), "BVS");
          elseif(mnemonic == I_CLC) then
            CPU_execSingleByteInstruction(CPU_CLC, "CLC");
          elseif(mnemonic == I_CLD) then
            CPU_execSingleByteInstruction(CPU_CLD, "CLD");
          elseif(mnemonic == I_CLI) then
            CPU_execSingleByteInstruction(CPU_CLI, "CLI");
          elseif(mnemonic == I_CLV) then
            CPU_execSingleByteInstruction(CPU_CLV, "CLV");
          elseif(mnemonic == I_CMP) then
            CPU_execInternalOnMemoryData(CPU_instruction.addrMode, dataIn, CPU_CMP, "CMP");
          elseif(mnemonic == I_CPX) then
            CPU_execInternalOnMemoryData(CPU_instruction.addrMode, dataIn, CPU_CPX, "CPX");
          elseif(mnemonic == I_CPY) then
            CPU_execInternalOnMemoryData(CPU_instruction.addrMode, dataIn, CPU_CPY, "CPY");
          elseif(mnemonic == I_DEC) then
            CPU_execRMWOp(CPU_instruction.addrMode, dataIn, CPU_DEC, "DEC");
          elseif(mnemonic == I_DEX) then
            CPU_execSingleByteInstruction(CPU_DEX, "DEX");
          elseif(mnemonic == I_DEY) then
            CPU_execSingleByteInstruction(CPU_DEY, "DEY");
          elseif(mnemonic == I_EOR) then
            CPU_execInternalOnMemoryData(CPU_instruction.addrMode, dataIn, CPU_EOR, "EOR");
          elseif(mnemonic == I_INC) then
            CPU_execRMWOp(CPU_instruction.addrMode, dataIn, CPU_INC, "INC");
          elseif(mnemonic == I_INX) then
            CPU_execSingleByteInstruction(CPU_INX, "INX");
          elseif(mnemonic == I_INY) then
            CPU_execSingleByteInstruction(CPU_INY, "INY");
          elseif(mnemonic == I_JMP) then
            CPU_execJMP(CPU_instruction.addrMode, dataIn);
          elseif(mnemonic == I_JSR) then
            CPU_execJSR(dataIn);
          elseif(mnemonic == I_LDA) then
            CPU_execInternalOnMemoryData(CPU_instruction.addrMode, dataIn, CPU_LDA, "LDA");
          elseif(mnemonic == I_LDX) then
            CPU_execInternalOnMemoryData(CPU_instruction.addrMode, dataIn, CPU_LDX, "LDX");
          elseif(mnemonic == I_LDY) then
            CPU_execInternalOnMemoryData(CPU_instruction.addrMode, dataIn, CPU_LDY, "LDY");
          elseif(mnemonic == I_LSR) then
            if(CPU_instruction.addrMode == ADDR_ACCUMULATOR) then
              CPU_execSingleByteInstruction(function () CPU_registers.A = CPU_LSR(CPU_registers.A); end, "LSR A");
            else
              CPU_execRMWOp(CPU_instruction.addrMode, dataIn, CPU_LSR, "LSR");
            end
          elseif(mnemonic == I_NOP) then
            CPU_execSingleByteInstruction(CPU_NOP, "NOP");
          elseif(mnemonic == I_ORA) then
            CPU_execInternalOnMemoryData(CPU_instruction.addrMode, dataIn, CPU_ORA, "ORA");
          elseif(mnemonic == I_PHA) then
            CPU_execStackPush(CPU_registers.A, "PHA");
          elseif(mnemonic == I_PHP) then
            CPU_execStackPush(CPU_registers.status, "PHP");
          elseif(mnemonic == I_PLA) then
            CPU_registers.A = CPU_execStackPull(dataIn, CPU_registers.A, "PLA");
          elseif(mnemonic == I_PLP) then
            CPU_registers.status = CPU_execStackPull(dataIn, CPU_registers.status, "PLP");
          elseif(mnemonic == I_ROL) then
            if(CPU_instruction.addrMode == ADDR_ACCUMULATOR) then
              CPU_execSingleByteInstruction(function () CPU_registers.A = CPU_ROL(CPU_registers.A); end, "ROL A");
            else
              CPU_execRMWOp(CPU_instruction.addrMode, dataIn, CPU_ROL, "ROL");
            end
          elseif(mnemonic == I_ROR) then
            if(CPU_instruction.addrMode == ADDR_ACCUMULATOR) then
              CPU_execSingleByteInstruction(function () CPU_registers.A = CPU_ROR(CPU_registers.A); end, "ROR A");
            else
              CPU_execRMWOp(CPU_instruction.addrMode, dataIn, CPU_ROR, "ROR");
            end
          elseif(mnemonic == I_RTI) then
            -- TODO: 
          elseif(mnemonic == I_RTS) then
            CPU_execRTS(dataIn);
          elseif(mnemonic == I_SBC) then
            CPU_execInternalOnMemoryData(CPU_instruction.addrMode, dataIn, CPU_SBC, "SBC");
          elseif(mnemonic == I_SEC) then
            CPU_execSingleByteInstruction(CPU_SEC, "SEC");
          elseif(mnemonic == I_SED) then
            CPU_execSingleByteInstruction(CPU_SED, "SED");
          elseif(mnemonic == I_SEI) then
            CPU_execSingleByteInstruction(CPU_SEI, "SEI");
          elseif(mnemonic == I_STA) then
            CPU_execStoreOp(CPU_instruction.addrMode, dataIn, CPU_registers.A, "STA");
          elseif(mnemonic == I_STX) then
            CPU_execStoreOp(CPU_instruction.addrMode, dataIn, CPU_registers.X, "STX");
          elseif(mnemonic == I_STY) then
            CPU_execStoreOp(CPU_instruction.addrMode, dataIn, CPU_registers.Y, "STY");
          elseif(mnemonic == I_TAX) then
            CPU_execSingleByteInstruction(CPU_TAX, "TAX");
          elseif(mnemonic == I_TAY) then
            CPU_execSingleByteInstruction(CPU_TAY, "TAY");
          elseif(mnemonic == I_TYA) then
            CPU_execSingleByteInstruction(CPU_TYA, "TYA");
          elseif(mnemonic == I_TSX) then
            CPU_execSingleByteInstruction(CPU_TSX, "TSX");
          elseif(mnemonic == I_TXA) then
            CPU_execSingleByteInstruction(CPU_TXA, "TXA");
          elseif(mnemonic == I_TXS) then
            CPU_execSingleByteInstruction(CPU_TXS, "TXS");
          else
            -- Unknown opcode
          end
        end
      elseif(CPU_status == S_RESET) then
        CPU_execJMP(ADDR_ABSOLUTE, dataIn);
        if(CPU_instrTime == 0) then
          -- Reset completed.
          CPU_status = S_RUNNING;
        end
      end
      
--      print(string.format("0x%X: din=0x%X, A=0x%X, X=0x%X, Y=0x%X, SP=0x%X, flags=0x%X", CPU_registers.PC, dataIn, CPU_registers.A, CPU_registers.X, CPU_registers.Y, CPU_registers.SP, CPU_registers.status));
    elseif (CPU_prevClockLevel == 1 and clk == 0) then
      -- Falling edge of the clock.
      -- Increment PC
      CPU_registers.PC = CPU_registers.PC + CPU_PCDelta;
      CPU_PCDelta = 0;
    end

    CPU_prevClockLevel = clk;
  end
end


function CPU_getStatusBit(bit) 
  return CPU_getBitValue(CPU_registers.status, bit);
end

function CPU_setStatusBit(bit, set)
  CPU_registers.status = CPU_setBitValue(CPU_registers.status, bit, set);
end

function CPU_getBitValue(bitfield, bit)
  return bit32.band(bit32.rshift(bitfield, bit), 1) == 1;
end

function CPU_setBitValue(bitfield, bit, set)
  if(set) then
    bitfield = bit32.bor(bitfield, bit32.lshift(1, bit));
  else
    bitfield = bit32.band(bitfield, bit32.bnot(bit32.lshift(1, bit)));
  end

  return bitfield;
end

-- Section A.1: Single byte instructions
function CPU_execSingleByteInstruction(instructionFunc, opcodeStr)
--  if(ENABLE_LOGGING) then
--    print(CPU_instrOffset.toString(16), ": ", opcodeStr);
--  end

  instructionFunc();
  CPU_stepInstruction(0, 0, 1, CPU_registers.PC); -- NOTE: PC has been already moved to point to the next byte from timestep T0.
end

-- Section A.2: Internal execution on memory data
function CPU_execInternalOnMemoryData(addrMode, dataIn, instructionFunc, opcodeStr) 
  if(addrMode == ADDR_IMMEDIATE) then
--    if(ENABLE_LOGGING) {
--      print(CPU_instrOffset.toString(16), ": ", opcodeStr, " #$", dataIn.toString(16));
--    }

    instructionFunc(dataIn);
    CPU_stepInstruction(0, 1, 1, CPU_registers.PC + 1);
  elseif(addrMode == ADDR_ZERO_PAGE) then
    if(CPU_instrTime == 1) then
      CPU_registers.ADL = dataIn;
      CPU_stepInstruction(2, 0, 1, bit32.band(CPU_registers.ADL, 0x000000FF));
    elseif(CPU_instrTime == 2) then
--      if(ENABLE_LOGGING) {
--        print(CPU_instrOffset.toString(16), ": ", opcodeStr, " $", CPU_registers.ADL.toString(16));
--      }

      instructionFunc(dataIn);
      CPU_stepInstruction(0, 1, 1, CPU_registers.PC + 1);
    end
  elseif(addrMode == ADDR_ZERO_PAGE_X) then
    if(CPU_instrTime == 1) then
      CPU_registers.BAL = dataIn;
      CPU_stepInstruction(2, 0, 1, bit32.band(CPU_registers.BAL, 0x000000FF));
    elseif(CPU_instrTime == 2) then
      -- dataIn discarded
      CPU_stepInstruction(3, 0, 1, bit32.band(CPU_registers.BAL + CPU_registers.X, 0x000000FF));
    elseif(CPU_instrTime == 3) then
--      if(ENABLE_LOGGING) {
--        print(CPU_instrOffset.toString(16), ": ", opcodeStr, " $", CPU_registers.BAL.toString(16), ", X");
--      }

      instructionFunc(dataIn);
      CPU_stepInstruction(0, 1, 1, CPU_registers.PC + 1);
    end
  elseif(addrMode == ADDR_ABSOLUTE) then
    if(CPU_instrTime == 1) then
      CPU_registers.ADL = dataIn;
      CPU_stepInstruction(2, 1, 1, CPU_registers.PC + 1);
    elseif(CPU_instrTime == 2) then
      CPU_registers.ADH = dataIn;
      CPU_stepInstruction(3, 0, 1, bit32.bor(CPU_registers.ADL, bit32.lshift(CPU_registers.ADH, 8)));
    elseif(CPU_instrTime == 3) then
      instructionFunc(dataIn);
      CPU_stepInstruction(0, 1, 1, CPU_registers.PC + 1);
    end
  elseif(addrMode == ADDR_ABSOLUTE_X) then
    if(CPU_instrTime == 1) then
      CPU_registers.BAL = dataIn;
      CPU_stepInstruction(2, 1, 1, CPU_registers.PC + 1);
    elseif(CPU_instrTime == 2) then
      CPU_registers.BAH = dataIn;
      CPU_stepInstruction(3, 0, 1, bit32.band((bit32.bor(CPU_registers.BAL, bit32.lshift(CPU_registers.BAH, 8)) + CPU_registers.X), 0x0000FFFF));
    elseif(CPU_instrTime == 3) then
      -- TODO: Page boundary crossing affects next instruction timestep.
      -- Assume that the page boundary hasn't been crossed. Bypass T4 and execute the instruction in this cycle.
      instructionFunc(dataIn);
      CPU_stepInstruction(0, 1, 1, CPU_registers.PC + 1);
    end
  elseif(addrMode == ADDR_ABSOLUTE_Y) then
    if(CPU_instrTime == 1) then
      CPU_registers.BAL = dataIn;
      CPU_stepInstruction(2, 1, 1, CPU_registers.PC + 1);
    elseif(CPU_instrTime == 2) then
      CPU_registers.BAH = dataIn;
      CPU_stepInstruction(3, 0, 1, bit32.band((bit32.bor(CPU_registers.BAL, bit32.lshift(CPU_registers.BAH, 8)) + CPU_registers.Y), 0x0000FFFF));
    elseif(CPU_instrTime == 3) then
      -- TODO: Page boundary crossing affects next instruction timestep.
      -- Assume that the page boundary hasn't been crossed. Bypass T4 and execute the instruction in this cycle.
      instructionFunc(dataIn);
      CPU_stepInstruction(0, 1, 1, CPU_registers.PC + 1);
    end
  elseif(addrMode == ADDR_INDIRECT_X) then
    if(CPU_instrTime == 1) then
      CPU_registers.BAL = dataIn;
      CPU_stepInstruction(2, 0, 1, CPU_registers.BAL);
    elseif(CPU_instrTime == 2) then
      -- dataIn = discarded
      CPU_stepInstruction(3, 0, 1, bit32.band((CPU_registers.BAL + CPU_registers.X), 0x000000FF));
    elseif(CPU_instrTime == 3) then
      CPU_registers.ADL = dataIn;
      CPU_stepInstruction(4, 0, 1, bit32.band((CPU_registers.BAL + CPU_registers.X + 1), 0x000000FF));
    elseif(CPU_instrTime == 4) then
      -- dataIn = ADH
      CPU_registers.ADH = dataIn;
      CPU_stepInstruction(5, 0, 1, bit32.bor(CPU_registers.ADL, bit32.lshift(CPU_registers.ADH, 8)));
    elseif(CPU_instrTime == 5) then
      instructionFunc(dataIn);
      CPU_stepInstruction(0, 1, 1, CPU_registers.PC + 1);
    end
  elseif(addrMode == ADDR_INDIRECT_Y) then
    if(CPU_instrTime == 1) then
      CPU_registers.IAL = dataIn;
      CPU_stepInstruction(2, 0, 1, CPU_registers.IAL);
    elseif(CPU_instrTime == 2) then
      CPU_registers.BAL = dataIn;
      CPU_stepInstruction(3, 0, 1, bit32.band((CPU_registers.IAL + 1), 0x000000FF));
    elseif(CPU_instrTime == 3) then
      CPU_registers.BAH = dataIn;
      CPU_stepInstruction(4, 0, 1, bit32.band((bit32.bor(CPU_registers.BAL, bit32.lshift(CPU_registers.BAH, 8)) + CPU_registers.Y), 0x0000FFFF));
    elseif(CPU_instrTime == 4) then
      -- TODO: Assume no page boundary crossed.
--      if(ENABLE_LOGGING) {
--        print(CPU_instrOffset.toString(16), ": ", opcodeStr, " ($", CPU_registers.IAL.toString(16), "), Y");
--      }

      instructionFunc(dataIn);
      CPU_stepInstruction(0, 1, 1, CPU_registers.PC + 1);
    end
  end
end

-- Section A.3: Store operations
function CPU_execStoreOp(addrMode, dataIn, dataOut, opcodeStr) 
  if(addrMode == ADDR_ZERO_PAGE) then
    if(CPU_instrTime == 1) then
      CPU_registers.ADL = dataIn;
      CPU_stepInstruction(2, 0, 0, CPU_registers.ADL, dataOut);
    elseif(CPU_instrTime == 2) then
--      if(ENABLE_LOGGING) {
--        print(CPU_instrOffset.toString(16), ": ", opcodeStr, " $", CPU_registers.ADL.toString(16));
--      }

      CPU_stepInstruction(0, 1, 1, CPU_registers.PC + 1);
    end
  elseif(addrMode == ADDR_ZERO_PAGE_X) then
    if(CPU_instrTime == 1) then
      CPU_registers.BAL = dataIn;
      CPU_stepInstruction(2, 0, 1, CPU_registers.BAL);
    elseif(CPU_instrTime == 2) then
      -- data discarded
      CPU_stepInstruction(3, 0, 0, bit32.band((CPU_registers.BAL + CPU_registers.X), 0x000000FF), dataOut);
    elseif(CPU_instrTime == 3) then
--      if(ENABLE_LOGGING) {
--        print(CPU_instrOffset.toString(16), ": ", opcodeStr, " $", CPU_registers.BAL.toString(16), ", X");
--      }

      CPU_stepInstruction(0, 1, 1, CPU_registers.PC + 1);
    end
  elseif(addrMode == ADDR_ZERO_PAGE_Y) then
    if(CPU_instrTime == 1) then
      CPU_registers.BAL = dataIn;
      CPU_stepInstruction(2, 0, 1, CPU_registers.BAL);
    elseif(CPU_instrTime == 2) then
      -- data discarded
      CPU_stepInstruction(3, 0, 0, bit32.band((CPU_registers.BAL + CPU_registers.Y), 0x000000FF), dataOut);
    elseif(CPU_instrTime == 3) then
--      if(ENABLE_LOGGING) {
--        print(CPU_instrOffset.toString(16), ": ", opcodeStr, " $", CPU_registers.BAL.toString(16), ", Y");
--      }

      CPU_stepInstruction(0, 1, 1, CPU_registers.PC + 1);
    end
  elseif(addrMode == ADDR_ABSOLUTE) then
    if(CPU_instrTime == 1) then
      CPU_registers.ADL = dataIn;
      CPU_stepInstruction(2, 1, 1, CPU_registers.PC + 1);
    elseif(CPU_instrTime == 2) then
      CPU_registers.ADH = dataIn;
      CPU_stepInstruction(3, 0, 0, bit32.bor(CPU_registers.ADL, bit32.lshift(CPU_registers.ADH, 8)), dataOut);
    elseif(CPU_instrTime == 3) then
      CPU_stepInstruction(0, 1, 1, CPU_registers.PC + 1);
    end
  elseif(addrMode == ADDR_ABSOLUTE_X) then
    if(CPU_instrTime == 1) then
      CPU_registers.BAL = dataIn;
      CPU_stepInstruction(2, 1, 1, CPU_registers.PC + 1);
    elseif(CPU_instrTime == 2) then
      CPU_registers.BAH = dataIn;
      CPU_stepInstruction(3, 0, 1, bit32.band((bit32.bor(CPU_registers.BAL, bit32.lshift(CPU_registers.BAH, 8)) + CPU_registers.X), 0x0000FFFF));
    elseif(CPU_instrTime == 3) then
      -- data discarded
      CPU_stepInstruction(4, 0, 0, bit32.band((bit32.bor(CPU_registers.BAL, bit32.lshift(CPU_registers.BAH, 8)) + CPU_registers.X), 0x0000FFFF), dataOut);
    elseif(CPU_instrTime == 4) then
      CPU_stepInstruction(0, 1, 1, CPU_registers.PC + 1);
    end
  elseif(addrMode == ADDR_ABSOLUTE_Y) then
    if(CPU_instrTime == 1) then
      CPU_registers.BAL = dataIn;
      CPU_stepInstruction(2, 1, 1, CPU_registers.PC + 1);
    elseif(CPU_instrTime == 2) then
      CPU_registers.BAH = dataIn;
      CPU_stepInstruction(3, 0, 1, bit32.band((bit32.bor(CPU_registers.BAL, bit32.lshift(CPU_registers.BAH, 8)) + CPU_registers.Y), 0x0000FFFF));
    elseif(CPU_instrTime == 3) then
      -- data discarded
      CPU_stepInstruction(4, 0, 0, bit32.band((bit32.bor(CPU_registers.BAL, bit32.lshift(CPU_registers.BAH, 8)) + CPU_registers.Y), 0x0000FFFF), dataOut);
    elseif(CPU_instrTime == 4) then
      CPU_stepInstruction(0, 1, 1, CPU_registers.PC + 1);
    end
  elseif(addrMode == ADDR_INDIRECT_X) then
    if(CPU_instrTime == 1) then
      CPU_registers.BAL = dataIn;
      CPU_stepInstruction(2, 0, 1, CPU_registers.BAL);
    elseif(CPU_instrTime == 2) then
      CPU_stepInstruction(3, 0, 1, bit32.band((CPU_registers.BAL + CPU_registers.X), 0x000000FF));
    elseif(CPU_instrTime == 3) then
      CPU_registers.ADL = dataIn;
      CPU_stepInstruction(4, 0, 1, bit32.band((CPU_registers.BAL + CPU_registers.X + 1), 0x000000FF));
    elseif(CPU_instrTime == 4) then
      CPU_registers.ADH = dataIn;
      CPU_stepInstruction(5, 0, 0, bit32.bor(CPU_registers.ADL, bit32.lshift(CPU_registers.ADH, 8)), dataOut);
    elseif(CPU_instrTime == 5) then
--      if(ENABLE_LOGGING) {
--        print(CPU_instrOffset.toString(16), ": ", opcodeStr, " ($", CPU_registers.BAL.toString(16), ", X)");
--      }

      CPU_stepInstruction(0, 1, 1, CPU_registers.PC + 1);
    end
  elseif(addrMode == ADDR_INDIRECT_Y) then
    if(CPU_instrTime == 1) then
      CPU_registers.IAL = dataIn;
      CPU_stepInstruction(2, 0, 1, CPU_registers.IAL);
    elseif(CPU_instrTime == 2) then
      CPU_registers.BAL = dataIn;
      CPU_stepInstruction(3, 0, 1, bit32.band((CPU_registers.IAL + 1), 0x000000FF));
    elseif(CPU_instrTime == 3) then
      CPU_registers.BAH = dataIn;
      CPU_stepInstruction(4, 0, 1, bit32.bor(bit32.band((CPU_registers.BAL + CPU_registers.Y), 0x000000FF), bit32.lshift(CPU_registers.BAH, 8)));
    elseif(CPU_instrTime == 4) then
      -- data discarded
      CPU_stepInstruction(5, 0, 0, bit32.bor(bit32.band((CPU_registers.BAL + CPU_registers.Y), 0x000000FF), bit32.lshift(CPU_registers.BAH, 8)), dataOut);
    elseif(CPU_instrTime == 5) then
--      if(ENABLE_LOGGING) {
--        print(CPU_instrOffset.toString(16), ": ", opcodeStr, " ($", CPU_registers.IAL.toString(16), "), Y");
--      }

      CPU_stepInstruction(0, 1, 1, CPU_registers.PC + 1);
    end
  end
end

-- Section A.4: Read-Modify-Write operations
function CPU_execRMWOp(addrMode, dataIn, instructionFunc, opcodeStr)
  if(addrMode == ADDR_ZERO_PAGE) then
    if(CPU_instrTime == 1) then
      CPU_registers.ADL = dataIn;
      CPU_stepInstruction(2, 0, 1, CPU_registers.ADL);
    elseif(CPU_instrTime == 2) then
      CPU_registers.RMWData = dataIn;
      CPU_stepInstruction(3, 0, 0, CPU_registers.ADL, CPU_registers.RMWData);
    elseif(CPU_instrTime == 3) then
      CPU_registers.RMWData = instructionFunc(CPU_registers.RMWData);
      CPU_stepInstruction(4, 0, 0, CPU_registers.ADL, CPU_registers.RMWData);
    elseif(CPU_instrTime == 4) then
--      if(ENABLE_LOGGING) {
--        print(CPU_instrOffset.toString(16), ": ", opcodeStr, " $", CPU_registers.ADL.toString(16));
--      }

      CPU_stepInstruction(0, 1, 1, CPU_registers.PC + 1);
    end
  elseif(addrMode == ADDR_ABSOLUTE) then
    if(CPU_instrTime == 1) then
      CPU_registers.ADL = dataIn;
      CPU_stepInstruction(2, 1, 1, CPU_registers.PC + 1);
    elseif(CPU_instrTime == 2) then
      CPU_registers.ADH = dataIn;
      CPU_stepInstruction(3, 0, 1, bit32.bor(CPU_registers.ADL, bit32.lshift(CPU_registers.ADH, 8)));
    elseif(CPU_instrTime == 3) then
      CPU_registers.RMWData = dataIn;
      CPU_stepInstruction(4, 0, 0, bit32.bor(CPU_registers.ADL, bit32.lshift(CPU_registers.ADH, 8)), CPU_registers.RMWData);
    elseif(CPU_instrTime == 4) then
      CPU_registers.RMWData = instructionFunc(CPU_registers.RMWData);
      CPU_stepInstruction(5, 0, 0, bit32.bor(CPU_registers.ADL, bit32.lshift(CPU_registers.ADH, 8)), CPU_registers.RMWData);
    elseif(CPU_instrTime == 5) then
      CPU_stepInstruction(0, 1, 1, CPU_registers.PC + 1);
    end
  elseif(addrMode == ADDR_ZERO_PAGE_X) then
    if(CPU_instrTime == 1) then
      CPU_registers.BAL = dataIn;
      CPU_stepInstruction(2, 0, 1, CPU_registers.BAL);
    elseif(CPU_instrTime == 2) then
      -- data discarded.
      CPU_stepInstruction(3, 0, 1, bit32.band((CPU_registers.BAL + CPU_registers.X), 0x000000FF));
    elseif(CPU_instrTime == 3) then
      CPU_registers.RMWData = dataIn;
      CPU_stepInstruction(4, 0, 0, bit32.band((CPU_registers.BAL + CPU_registers.X), 0x000000FF), CPU_registers.RMWData);
    elseif(CPU_instrTime == 4) then
      CPU_registers.RMWData = instructionFunc(CPU_registers.RMWData);
      CPU_stepInstruction(5, 0, 0, bit32.band((CPU_registers.BAL + CPU_registers.X), 0x000000FF), CPU_registers.RMWData);
    elseif(CPU_instrTime == 5) then
--      if(ENABLE_LOGGING) {
--        print(CPU_instrOffset.toString(16), ": ", opcodeStr, " $", CPU_registers.BAL.toString(16), ", X");
--      }

      CPU_stepInstruction(0, 1, 1, CPU_registers.PC + 1);
    end
  elseif(addrMode == ADDR_ABSOLUTE_X) then
    if(CPU_instrTime == 1) then
      CPU_registers.BAL = dataIn;
      CPU_stepInstruction(2, 1, 1, CPU_registers.PC + 1);
    elseif(CPU_instrTime == 2) then
      CPU_registers.BAH = dataIn;
      CPU_stepInstruction(3, 0, 1, bit32.band((bit32.bor(CPU_registers.BAL, bit32.lshift(CPU_registers.BAH, 8)) + CPU_registers.X), 0x0000FFFF));
    elseif(CPU_instrTime == 3) then
      -- data discarded.
      CPU_stepInstruction(4, 0, 1, bit32.band((bit32.bor(CPU_registers.BAL, bit32.lshift(CPU_registers.BAH, 8)) + CPU_registers.X), 0x0000FFFF));
    elseif(CPU_instrTime == 4) then
      CPU_registers.RMWData = dataIn;
      CPU_stepInstruction(5, 0, 0, bit32.band((bit32.bor(CPU_registers.BAL, bit32.lshift(CPU_registers.BAH, 8)) + CPU_registers.X), 0x0000FFFF), CPU_registers.RMWData);
    elseif(CPU_instrTime == 5) then
      CPU_registers.RMWData = instructionFunc(CPU_registers.RMWData);
      CPU_stepInstruction(6, 0, 0, bit32.band((bit32.bor(CPU_registers.BAL, bit32.lshift(CPU_registers.BAH, 8)) + CPU_registers.X), 0x0000FFFF), CPU_registers.RMWData);
    elseif(CPU_instrTime == 6) then
      CPU_stepInstruction(0, 1, 1, CPU_registers.PC + 1);
    end
  end
end

-- Section A.5.1: PHP/PHA
function CPU_execStackPush(data, opcodeStr)
  if(CPU_instrTime == 1) then
    CPU_stepInstruction(2, 0, 0, bit32.bor(0x00000100, CPU_registers.SP), data);
  elseif(CPU_instrTime == 2) then
--    if(ENABLE_LOGGING) {
--      print(CPU_instrOffset.toString(16), ": ", opcodeStr);
--    }

    CPU_registers.SP = CPU_registers.SP - 1;
    CPU_stepInstruction(0, 0, 1, CPU_registers.PC);
  end
end

-- Secion A.5.2: PLP/PLA
function CPU_execStackPull(dataIn, regValue, opcodeStr)
  if(CPU_instrTime == 1) then
    -- data discarded
    CPU_stepInstruction(2, 0, 1, bit32.bor(0x00000100, CPU_registers.SP));
  elseif(CPU_instrTime == 2) then
    -- data discarded
    CPU_stepInstruction(3, 0, 1, bit32.bor(0x00000100, (CPU_registers.SP + 1)));
  elseif(CPU_instrTime == 3) then
--    if(ENABLE_LOGGING) {
--      print(CPU_instrOffset.toString(16), ": ", opcodeStr);
--    }

    CPU_registers.SP = CPU_registers.SP + 1;
    regValue = dataIn;
    CPU_stepInstruction(0, 0, 1, CPU_registers.PC);
  end

  return regValue;
end

-- Section A.5.3: Jump to Subroutine
function CPU_execJSR(dataIn)
  if(CPU_instrTime == 1) then
    CPU_registers.ADL = dataIn;
    CPU_stepInstruction(2, 0, 1, bit32.bor(0x00000100, CPU_registers.SP));
  elseif(CPU_instrTime == 2) then
    -- data discarded
    local jsrAddrHi = bit32.band(bit32.rshift(CPU_registers.PC, 8), 0x000000FF);
    CPU_stepInstruction(3, 0, 0, bit32.bor(0x00000100, CPU_registers.SP), jsrAddrHi);
  elseif(CPU_instrTime == 3) then
    -- data discarded
    local jsrAddrLo = bit32.band(CPU_registers.PC, 0x000000FF);
    CPU_stepInstruction(4, 0, 0, bit32.bor(0x00000100, (CPU_registers.SP - 1)), jsrAddrLo);
  elseif(CPU_instrTime == 4) then
    -- data discarded
    CPU_stepInstruction(5, 1, 1, CPU_registers.PC + 1);
    CPU_registers.SP = CPU_registers.SP - 2;
  elseif(CPU_instrTime == 5) then
    CPU_registers.ADH = dataIn;
    CPU_registers.PC = bit32.bor(CPU_registers.ADL, bit32.lshift(CPU_registers.ADH, 8));

    CPU_stepInstruction(0, 0, 1, CPU_registers.PC);
  end
end

-- Section A.5.6: Jump operation
function CPU_execJMP(addrMode, dataIn)
  if(addrMode == ADDR_ABSOLUTE) then
    if(CPU_instrTime == 1) then
      CPU_registers.ADL = dataIn;
      CPU_stepInstruction(2, 1, 1, CPU_registers.PC + 1);
    elseif(CPU_instrTime == 2) then
      CPU_registers.ADH = dataIn;
      CPU_registers.PC = bit32.bor(CPU_registers.ADL, bit32.lshift(CPU_registers.ADH, 8));
      CPU_stepInstruction(0, 0, 1, CPU_registers.PC);
    end
  elseif(addrMode == ADDR_INDIRECT) then
    if(CPU_instrTime == 1) then
      CPU_registers.IAL = dataIn;
      CPU_stepInstruction(2, 1, 1, CPU_registers.PC + 1);
    elseif(CPU_instrTime == 2) then
      CPU_registers.IAH = dataIn;
      CPU_stepInstruction(3, 0, 1, bit32.bor(CPU_registers.IAL, bit32.lshift(CPU_registers.IAH, 8)));
    elseif(CPU_instrTime == 3) then
      CPU_registers.ADL = dataIn;
      CPU_stepInstruction(4, 0, 1, bit32.bor(bit32.band((CPU_registers.IAL + 1), 0x000000FF), bit32.lshift(CPU_registers.IAH, 8)));
    elseif(CPU_instrTime == 4) then
      CPU_registers.ADH = dataIn;
      CPU_registers.PC = bit32.bor(CPU_registers.ADL, bit32.lshift(CPU_registers.ADH, 8));     
      CPU_stepInstruction(0, 0, 1, CPU_registers.PC);
    end
  end
end

-- Section A.5.7: Return from Subroutine
function CPU_execRTS(dataIn)
  if(CPU_instrTime == 1) then
    -- data discarded.
    CPU_stepInstruction(2, 0, 1, bit32.bor(0x00000100, CPU_registers.SP));
  elseif(CPU_instrTime == 2) then
    -- data discarded.
--    if(ENABLE_LOGGING) {
--      print("RTS T2: PC: ", CPU_registers.PC);
--    }

    CPU_stepInstruction(3, 0, 1, bit32.bor(0x00000100, (CPU_registers.SP + 1)));
  elseif(CPU_instrTime == 3) then
    CPU_registers.PC = bit32.bor(bit32.band(CPU_registers.PC, 0x0000FF00), dataIn);
--    if(ENABLE_LOGGING) {
--      print("RTS T3: dataIn: ", dataIn, " PC: ", CPU_registers.PC);
--    }
    
    CPU_stepInstruction(4, 0, 1, bit32.bor(0x00000100, (CPU_registers.SP + 2)));
  elseif(CPU_instrTime == 4) then
    CPU_registers.PC = bit32.bor(bit32.band(CPU_registers.PC, 0x000000FF), bit32.lshift(dataIn, 8));
    CPU_registers.PC = bit32.band((CPU_registers.PC + 1), 0x0000FFFF);
    CPU_registers.SP = CPU_registers.SP + 2;
--    if(ENABLE_LOGGING) {
--     print("RTS T4: dataIn: ", dataIn, " PC: ", CPU_registers.PC);
--   }
    
    CPU_stepInstruction(5, 0, 1, CPU_registers.PC);
  elseif(CPU_instrTime == 5) then
    -- data discarded.
--    if(ENABLE_LOGGING) {
--      print(CPU_instrOffset.toString(16), ": RTS", " (to ", (CPU_registers.PC + 1).toString(16), ")");
--    }
    CPU_stepInstruction(0, 1, 1, CPU_registers.PC + 1);
  end
end

-- Section A.5.8: Branch operation
function CPU_execBranch(dataIn, takeBranch, opcodeStr) 
  if(CPU_instrTime == 1) then
    -- Sign-extend input byte because... JS.
    CPU_registers.branchOffset = dataIn;
    if(bit32.band(dataIn, 0x00000080) == 0x00000080) then
      CPU_registers.branchOffset = bit32.bor(CPU_registers.branchOffset, 0xFFFFFF00);
    end
    
--    if(ENABLE_LOGGING) {
--      print(CPU_instrOffset.toString(16), ": ", opcodeStr, " $", (CPU_registers.PC + 1 + CPU_registers.branchOffset).toString(16));
--    }

    if(takeBranch) then
      -- TODO: branch crosses page boundary.
      CPU_stepInstruction(2, 1 + CPU_registers.branchOffset, 1, CPU_registers.PC + 1 + CPU_registers.branchOffset);
    else
      CPU_stepInstruction(0, 1, 1, CPU_registers.PC + 1);
    end
  elseif(CPU_instrTime == 2) then
    -- data discarded
    CPU_stepInstruction(0, 0, 1, CPU_registers.PC);
  end
end

function CPU_stepInstruction(nextTime, pcDelta, readEnable, addressBus, dataOut)
  if(CPU_instrTime == 0) then
    CPU_instrOffset = CPU_registers.PC;
  end

  CPU_instrTime = nextTime;
  CPU_PCDelta = pcDelta;
  CPU_readEnable = readEnable;
  CPU_addressBus = addressBus;
  
  if(dataOut ~= nil) then
    CPU_dataOut = dataOut;
  else 
    CPU_dataOut = V_UNDEFINED;
  end
end

function CPU_ADC(data)
  local carry = 0;
  if(CPU_getStatusBit(F_CARRY)) then
    carry = 1;
  end
  
  local a = bit32.band((CPU_registers.A + data + carry), 0x000001FF); -- keep 9 bits for the carry flag.

  if(CPU_getStatusBit(F_DECIMAL)) then
    CPU_setStatusBit(F_CARRY, a > 99);
  else 
    CPU_setStatusBit(F_CARRY, a > 255);
  end

  CPU_registers.A = bit32.band(a, 0x000000FF); -- mask at 8-bits.

  local overflow = bit32.rshift(bit32.band(bit32.band(bit32.bxor(CPU_registers.A, a), bit32.bxor(data, a)), 0x80), 7);
  
  CPU_setStatusBit(F_OVERFLOW, overflow ~= 0);
  CPU_setStatusBit(F_NEGATIVE, CPU_getBitValue(CPU_registers.A, 7));
  CPU_setStatusBit(F_ZERO, CPU_registers.A == 0);
end

function CPU_SBC(data)
  local onesComplementData = bit32.band((255 - data), 0x000000FF);
  local carry = 0;
  if(CPU_getStatusBit(F_CARRY)) then
    carry = 1;
  end

  local a = bit32.band((CPU_registers.A + onesComplementData + carry), 0x000001FF); -- keep 9 bits for the carry flag.
  local overflow = bit32.rshift(bit32.band(bit32.band(bit32.bxor(CPU_registers.A, a), bit32.bxor(onesComplementData, a)), 0x80), 7);
  
  CPU_registers.A = bit32.band(a, 0x000000FF); -- mask at 8-bits.

  CPU_setStatusBit(F_CARRY, bit32.band(a, 0x00000100) ~= 0);
  CPU_setStatusBit(F_OVERFLOW, overflow ~= 0);
  CPU_setStatusBit(F_NEGATIVE, CPU_getBitValue(CPU_registers.A, 7));
  CPU_setStatusBit(F_ZERO, CPU_registers.A == 0);
end

function CPU_AND(data)
  CPU_registers.A = bit32.band(CPU_registers.A, data);

  CPU_setStatusBit(F_NEGATIVE, CPU_getBitValue(CPU_registers.A, 7));
  CPU_setStatusBit(F_ZERO, CPU_registers.A == 0);
end

function CPU_ORA(data)
  CPU_registers.A = bit32.bor(CPU_registers.A, data);

  CPU_setStatusBit(F_NEGATIVE, CPU_getBitValue(CPU_registers.A, 7));
  CPU_setStatusBit(F_ZERO, CPU_registers.A == 0);
end

function CPU_EOR(data)
  CPU_registers.A = bit32.bxor(CPU_registers.A, data);

  CPU_setStatusBit(F_NEGATIVE, CPU_getBitValue(CPU_registers.A, 7));
  CPU_setStatusBit(F_ZERO, CPU_registers.A == 0);
end

function CPU_BIT(data)
  CPU_setStatusBit(F_NEGATIVE, CPU_getBitValue(data, 7));
  CPU_setStatusBit(F_OVERFLOW, CPU_getBitValue(data, 6));
  CPU_setStatusBit(F_ZERO, bit32.band(CPU_registers.A, data) == 0);
end

function CPU_CMP(data)
  CPU_setStatusBit(F_CARRY, CPU_registers.A >= data); -- TODO: Absolute value of X?  
  CPU_setStatusBit(F_ZERO, CPU_registers.A == data);
  CPU_setStatusBit(F_NEGATIVE, CPU_getBitValue(bit32.band((CPU_registers.A - data), 0x000000FF), 7));
end

function CPU_CPX(data)
  CPU_setStatusBit(F_CARRY, CPU_registers.X >= data); -- TODO: Absolute value of X?  
  CPU_setStatusBit(F_ZERO, CPU_registers.X == data);
  CPU_setStatusBit(F_NEGATIVE, CPU_getBitValue(bit32.band((CPU_registers.X - data), 0x000000FF), 7));
end

function CPU_CPY(data)
  CPU_setStatusBit(F_CARRY, CPU_registers.Y >= data); -- TODO: Absolute value of X?  
  CPU_setStatusBit(F_ZERO, CPU_registers.Y == data);
  CPU_setStatusBit(F_NEGATIVE, CPU_getBitValue(bit32.band((CPU_registers.Y - data), 0x000000FF), 7));
end

function CPU_LDA(data)
  CPU_registers.A = data;

  CPU_setStatusBit(F_ZERO, CPU_registers.A == 0);
  CPU_setStatusBit(F_NEGATIVE, CPU_getBitValue(CPU_registers.A, 7));
end

function CPU_LDX(data)
  CPU_registers.X = data;

  CPU_setStatusBit(F_ZERO, CPU_registers.X == 0);
  CPU_setStatusBit(F_NEGATIVE, CPU_getBitValue(CPU_registers.X, 7));
end

function CPU_LDY(data)
  CPU_registers.Y = data;

  CPU_setStatusBit(F_ZERO, CPU_registers.Y == 0);
  CPU_setStatusBit(F_NEGATIVE, CPU_getBitValue(CPU_registers.Y, 7));
end

function CPU_CLC()
  CPU_setStatusBit(F_CARRY, false);
end

function CPU_CLD()
  CPU_setStatusBit(F_DECIMAL, false);
end

function CPU_CLI()
  CPU_setStatusBit(F_IRQ_DISABLE, false);
end

function CPU_CLV()
  CPU_setStatusBit(F_OVERFLOW, false);
end

function CPU_DEX()
  CPU_registers.X = bit32.band(CPU_registers.X - 1, 0x000000FF);

  CPU_setStatusBit(F_NEGATIVE, CPU_getBitValue(CPU_registers.X, 7));
  CPU_setStatusBit(F_ZERO, CPU_registers.X == 0);
end

function CPU_DEY()
  CPU_registers.Y = bit32.band(CPU_registers.Y - 1, 0x000000FF);

  CPU_setStatusBit(F_NEGATIVE, CPU_getBitValue(CPU_registers.Y, 7));
  CPU_setStatusBit(F_ZERO, CPU_registers.Y == 0);
end

function CPU_INX()
  CPU_registers.X = bit32.band(CPU_registers.X + 1, 0x000000FF);
  
  CPU_setStatusBit(F_NEGATIVE, CPU_getBitValue(CPU_registers.X, 7));
  CPU_setStatusBit(F_ZERO, CPU_registers.X == 0);
end

function CPU_INY()
  CPU_registers.Y = bit32.band(CPU_registers.Y + 1, 0x000000FF);
  
  CPU_setStatusBit(F_NEGATIVE, CPU_getBitValue(CPU_registers.Y, 7));
  CPU_setStatusBit(F_ZERO, CPU_registers.Y == 0);
end

function CPU_NOP()
end

function CPU_SEC()
  CPU_setStatusBit(F_CARRY, true);
end

function CPU_SED()
  CPU_setStatusBit(F_DECIMAL, true);
end

function CPU_SEI()
  CPU_setStatusBit(F_IRQ_DISABLE, true);
end

function CPU_TAX()
  CPU_registers.X = CPU_registers.A;
  
  CPU_setStatusBit(F_NEGATIVE, CPU_getBitValue(CPU_registers.X, 7));
  CPU_setStatusBit(F_ZERO, CPU_registers.X == 0);
end

function CPU_TXA()
  CPU_registers.A = CPU_registers.X;
  
  CPU_setStatusBit(F_NEGATIVE, CPU_getBitValue(CPU_registers.A, 7));
  CPU_setStatusBit(F_ZERO, CPU_registers.A == 0);
end

function CPU_TAY()
  CPU_registers.Y = CPU_registers.A;
  
  CPU_setStatusBit(F_NEGATIVE, CPU_getBitValue(CPU_registers.Y, 7));
  CPU_setStatusBit(F_ZERO, CPU_registers.Y == 0);
end

function CPU_TYA()
  CPU_registers.A = CPU_registers.Y;
  
  CPU_setStatusBit(F_NEGATIVE, CPU_getBitValue(CPU_registers.A, 7));
  CPU_setStatusBit(F_ZERO, CPU_registers.A == 0);
end

function CPU_TXS()
  CPU_registers.SP = CPU_registers.X;
end

function CPU_TSX()
  CPU_registers.X = CPU_registers.SP;

  CPU_setStatusBit(F_NEGATIVE, CPU_getBitValue(CPU_registers.X, 7));
  CPU_setStatusBit(F_ZERO, CPU_registers.X == 0);
end

function CPU_ASL(data)
  CPU_setStatusBit(F_CARRY, CPU_getBitValue(data, 7));

  data = bit32.lshift(data, 1);

  CPU_setStatusBit(F_NEGATIVE, CPU_getBitValue(data, 7));
  CPU_setStatusBit(F_ZERO, data == 0);
  
  return data;
end

function CPU_LSR(data)
  CPU_setStatusBit(F_CARRY, CPU_getBitValue(data, 0));
  
  data = bit32.rshift(data, 1);
  
  CPU_setStatusBit(F_NEGATIVE, false);
  CPU_setStatusBit(F_ZERO, data == 0);

  return data;
end

function CPU_DEC(data)
  data = bit32.band(data - 1, 0x000000FF);
  
  CPU_setStatusBit(F_NEGATIVE, CPU_getBitValue(data, 7));
  CPU_setStatusBit(F_ZERO, data == 0);

  return data;
end

function CPU_INC(data)
  data = bit32.band(data + 1, 0x000000FF);
  
  CPU_setStatusBit(F_NEGATIVE, CPU_getBitValue(data, 7));
  CPU_setStatusBit(F_ZERO, data == 0);
  
  return data;
end

function CPU_ROL(data)
  local carry = 0;
  if(CPU_getStatusBit(F_CARRY)) then
    carry = 1;
  end
  
  CPU_setStatusBit(F_CARRY, CPU_getBitValue(data, 7));
  
  data = bit32.bor(bit32.lshift(data, 1), carry);
  
  CPU_setStatusBit(F_NEGATIVE, CPU_getBitValue(data, 7));
  CPU_setStatusBit(F_ZERO, data == 0);
  
  return data;
end

function CPU_ROR(data)
  local carry = 0;
  if(CPU_getStatusBit(F_CARRY)) then
    carry = 1;
  end
  
  CPU_setStatusBit(F_CARRY, CPU_getBitValue(data, 0));
  
  data = bit32.bor(bit32.rshift(data, 1), bit32.lshift(carry, 7));
  
  CPU_setStatusBit(F_NEGATIVE, carry ~= 0);
  CPU_setStatusBit(F_ZERO, data == 0);
  
  return data;
end
SCRP7�QD��<C   Mem controller�
  bit32 = bit;

function init(component)
  component.addInput("ADL", 8);
  component.addInput("ADH", 8);
  component.addInput("read", 1);
  
  component.addOutput("relADL", 8);
  component.addOutput("relADH", 8);
  component.addOutput("kernal", 1);
  component.addOutput("ram", 1);
  component.addOutput("basic", 1);
  component.addOutput("io", 1);
  component.addOutput("video", 1);
end

function simulate(inputs)
  local res = { V_UNDEFINED, V_UNDEFINED, V_UNDEFINED, V_UNDEFINED, V_UNDEFINED, V_UNDEFINED, V_UNDEFINED };
  local adl = inputs[1];
  local adh = inputs[2];
  local read = inputs[3];
  
  if(adl == V_ERROR or adh == V_ERROR) then
    res[0] = V_ERROR;
    res[1] = V_ERROR;
    res[2] = V_ERROR;
    res[3] = V_ERROR;
    res[4] = V_ERROR;
    res[5] = V_ERROR;
    res[6] = V_ERROR;
  elseif(adl ~= V_UNDEFINED and adh ~= V_UNDEFINED) then
    local adx = bit32.bor(adl, bit32.lshift(adh, 8));
    if(adx >= 0x0400 and adx < 0x07FF) then
      -- Video memory
      local relAddr = adx - 0x0400;
      res[1] = bit32.band(relAddr, 0x000000FF);
      res[2] = bit32.band(bit32.rshift(relAddr, 8), 0x000000FF);
      res[3] = 0;
      res[4] = 0;
      res[5] = 0;
      res[6] = 0;
      res[7] = 1;
    elseif(adx >= 0xD000 and adx < 0xE000) then
      -- IO 
      local relAddr = adx - 0xD000;
      res[1] = bit32.band(relAddr, 0x000000FF);
      res[2] = bit32.band(bit32.rshift(relAddr, 8), 0x000000FF);
      res[3] = 0;
      res[4] = 0;
      res[5] = 0;
      res[6] = 1;
      res[7] = 0;
    else
      if(read == 0) then
        -- Redirect all other writes to RAM
        res[1] = adl;
        res[2] = adh;
        res[3] = 0;
        res[4] = 1;
        res[5] = 0;
        res[6] = 0;
        res[7] = 0;
      else
        if(adx >= 0xA000 and adx < 0xC000) then
          -- BASIC ROM
          local relAddr = adx - 0xA000;
          res[1] = bit32.band(relAddr, 0x000000FF);
          res[2] = bit32.band(bit32.rshift(relAddr, 8), 0x000000FF);
          res[3] = 0;
          res[4] = 0;
          res[5] = 1;
          res[6] = 0;
          res[7] = 0;
        elseif(adx >= 0xE000 and adx < 0x10000) then
          -- Kernal ROM
          local relAddr = adx - 0xE000;
          res[1] = bit32.band(relAddr, 0x000000FF);
          res[2] = bit32.band(bit32.rshift(relAddr, 8), 0x000000FF);
          res[3] = 1;
          res[4] = 0;
          res[5] = 0;
          res[6] = 0;
          res[7] = 0;
        else
          -- RAM
          res[1] = adl;
          res[2] = adh;
          res[3] = 0;
          res[4] = 1;
          res[5] = 0;
          res[6] = 0;
          res[7] = 0;
        end
      end
    end
  end

  return {
    { t = 1, outputs = res }
  };
end
SCRPCםDHB   RAM�  bit32 = bit;

ENABLE_LOGGING = false;

function init(component)
  component.addInput("ADL", 8);
  component.addInput("ADH", 8);
  component.addInput("Din", 8);
  component.addInput("re", 1);
  component.addInput("clk", 1);
  component.addInput("ce", 1);
  component.addOutput("Dout", 8);

  RAM_prevClockLevel = UNDEFINED_VALUE; 
  RAM_buffer = ArrayBuffer.new(65536);
end

function simulate(inputs)
  local res = { UNDEFINED_VALUE };
  local adl = inputs[1];
  local adh = inputs[2];
  local din = inputs[3];
  local re = inputs[4];
  local clk = inputs[5];
  local ce = inputs[6];
  
  if(adl == V_ERROR or adh == V_ERROR or re == V_ERROR or din == V_ERROR) then
    res[1] = V_ERROR;
  elseif(adl ~= UNDEFINED_VALUE and adh ~= UNDEFINED_VALUE and re ~= UNDEFINED_VALUE and clk ~= UNDEFINED_VALUE) then
    local adx = bit32.bor(adl, bit32.lshift(adh, 8));

    if(adx < #RAM_buffer) then
      if(RAM_prevClockLevel == 0 and clk == 1) then
        if(re == 0 and ce == 1 and din ~= UNDEFINED_VALUE) then
          RAM_buffer[adx] = din;
        end
      end

      res[1] = RAM_buffer[adx];
    else
      res[1] = V_UNDEFINED;
    end
  end
  
  RAM_prevClockLevel = clk;

  return {
    { t = 1, outputs = res }
  };
end
SCRP�u�D���C	   IO Memory&  bit32 = bit;

ENABLE_LOGGING = false;

function init(component)
  component.addInput("ADL", 8);
  component.addInput("ADH", 8);
  component.addInput("Din", 8);
  component.addInput("re", 1);
  component.addInput("clk", 1);
  component.addInput("ce", 1);
  
  component.addOutput("Dout", 8);

  IO_prevClockLevel = V_UNDEFINED; 
  IO_buffer = ArrayBuffer.new(4096);
  IO_rasterTicks = 0;
end

function simulate(inputs)
  local res = { V_UNDEFINED };
  local adl = inputs[1];
  local adh = bit32.band(inputs[2], 0x0000000F);
  local din = inputs[3];
  local re = inputs[4];
  local clk = inputs[5];
  local ce = inputs[6];

  if(adl == V_ERROR or adh == V_ERROR or re == V_ERROR or din == V_ERROR) then
    res[1] = V_ERROR;
  elseif(adl ~= V_UNDEFINED and adh ~= V_UNDEFINED and re ~= V_UNDEFINED and clk ~= V_UNDEFINED) then
    local adx = bit32.bor(adl, bit32.lshift(adh, 8));
    if(adx < #IO_buffer) then
      if(IO_prevClockLevel == 0 and clk == 1) then
        -- TODO/HACK: Update raster register
        IO_rasterTicks = IO_rasterTicks + 1;
        if(IO_rasterTicks == 8) then
          local raster = bit32.bor(IO_buffer[0x12], bit32.lshift(bit32.band(IO_buffer[0x11], 0x00000080), 8));
          raster = bit32.band((raster + 1), 0x000001FF);
          IO_buffer[0x12] = bit32.band(raster, 0x000000FF);
          IO_buffer[0x11] = bit32.bor(bit32.band(IO_buffer[0x11], 0x0000007F), bit32.lshift(bit32.band(bit32.rshift(raster, 8), 0x00000001), 7));

          IO_rasterTicks = 0;
        end
        
        if(re == 0 and ce == 1 and din ~= V_UNDEFINED) then
          IO_buffer[adx] = din; -- Write
        end
      end

      res[1] = IO_buffer[bit32.bor(adl, bit32.lshift(adh, 8))];
    else
      res[1] = V_UNDEFINED;
    end
  end

  IO_prevClockLevel = clk;

  return {
    { t = 1, outputs = res }
  };
end
SCRP`לD��4D   Video Memory�"  bit32 = bit;

ENABLE_LOGGING = false;

CharROM_b64 = "PGZubmBiPAAYPGZ+ZmZmAHxmZnxmZnwAPGZgYGBmPAB4bGZmZmx4AH5gYHhgYH4AfmBgeGBgYAA8ZmBuZmY8AGZmZn5mZmYAPBgYGBgYPAAeDAwMDGw4AGZseHB4bGYAYGBgYGBgfgBjd39rY2NjAGZ2fn5uZmYAPGZmZmZmPAB8ZmZ8YGBgADxmZmZmPA4AfGZmfHhsZgA8ZmA8BmY8AH4YGBgYGBgAZmZmZmZmPABmZmZmZjwYAGNjY2t/d2MAZmY8GDxmZgBmZmY8GBgYAH4GDBgwYH4APDAwMDAwPAAMEjB8MGL8ADwMDAwMDDwAABg8fhgYGBgAEDB/fzAQAAAAAAAAAAAAGBgYGAAAGABmZmYAAAAAAGZm/2b/ZmYAGD5gPAZ8GABiZgwYMGZGADxmPDhnZj8ABgwYAAAAAAAMGDAwMBgMADAYDAwMGDAAAGY8/zxmAAAAGBh+GBgAAAAAAAAAGBgwAAAAfgAAAAAAAAAAABgYAAADBgwYMGAAPGZudmZmPAAYGDgYGBh+ADxmBgwwYH4APGYGHAZmPAAGDh5mfwYGAH5gfAYGZjwAPGZgfGZmPAB+ZgwYGBgYADxmZjxmZjwAPGZmPgZmPAAAABgAABgAAAAAGAAAGBgwDhgwYDAYDgAAAH4AfgAAAHAYDAYMGHAAPGYGDBgAGAAAAAD--wAAAAgcPn9/HD4AGBgYGBgYGBgAAAD--wAAAAAA--8AAAAAAP--AAAAAAAAAAAA--8AADAwMDAwMDAwDAwMDAwMDAwAAADg8DgYGBgYHA8HAAAAGBg48OAAAADAwMDAwMD--8DgcDgcDgcDAwcOHDhw4MD--8DAwMDAwP--AwMDAwMDADx+fn5+PAAAAAAAAP--ADZ/f38+HAgAYGBgYGBgYGAAAAAHDxwYGMPnfjw8fufDADx+ZmZ+PAAYGGZmGBg8AAYGBgYGBgYGCBw+fz4cCAAYGBj--xgYGMDAMDDAwDAwGBgYGBgYGBgAAAM+djY2AP9/Px8PBwMBAAAAAAAAAADw8PDw8PDw8AAAAAD//////wAAAAAAAAAAAAAAAAAA/8DAwMDAwMDAzMwzM8zMMzMDAwMDAwMDAwAAAADMzDMz--78+PDgwIADAwMDAwMDAxgYGB8fGBgYAAAAAA8PDw8YGBgfHwAAAAAAAPj4GBgYAAAAAAAA--8AAAAfHxgYGBgYGP--AAAAAAAA--8YGBgYGBj4+BgYGMDAwMDAwMDA4ODg4ODg4OAHBwcHBwcHB///AAAAAAAA////AAAAAAAAAAAAAP///wMDAwMDA///AAAAAPDw8PAPDw8PAAAAABgYGPj4AAAA8PDw8AAAAADw8PDwDw8PD8OZkZGfmcP/58OZgZmZmf+DmZmDmZmD/8OZn5+fmcP/h5OZmZmTh/+Bn5+Hn5+B/4Gfn4efn5--w5mfkZmZw/+ZmZmBmZmZ/8Pn5+fn58P/4fPz8/OTx/+Zk4ePh5OZ/5+fn5+fn4H/nIiAlJycnP+ZiYGBkZmZ/8OZmZmZmcP/g5mZg5+fn--DmZmZmcPx/4OZmYOHk5n/w5mfw/mZw/+B5+fn5+fn/5mZmZmZmcP/mZmZmZnD5/+cnJyUgIic/5mZw+fDmZn/mZmZw+fn5/+B+fPnz5+B/8PPz8/Pz8P/8+3Pg8+dA--D8/Pz8/PD///nw4Hn5+fn/+/PgIDP7////////////+fn5+f//+f/mZmZ//////+ZmQCZAJmZ/+fBn8P5g+f/nZnz58+Zuf/DmcPHmJnA--nz5///////8+fPz8/n8--P5/Pz8+fP//+ZwwDDmf///+fngefn/////////+fnz////4H////////////n5////Pnz58+f/8OZkYmZmcP/5+fH5+fngf/Dmfnzz5+B/8OZ+eP5mcP/+fHhmYD5+f+Bn4P5+ZnD/8OZn4OZmcP/gZnz5+fn5--DmZnDmZnD/8OZmcH5mcP////n///n/////+f//+fnz/Hnz5/P5/H///+B/4H///+P5/P58+eP/8OZ+fPn/+f/////AAD////348GAgOPB/+fn5+fn5+fn////AAD//////wAA//////8AAP///////////wAA///Pz8/Pz8/Pz/Pz8/Pz8/Pz////Hw/H5+fn5+Pw+P///+fnxw8f////Pz8/Pz8/AAA/H4/H4/H4/Pz48ePHjx8/AAA/Pz8/Pz8AAPz8/Pz8/P/DgYGBgcP///////8AAP/JgICAweP3/5+fn5+fn5+f////+PDj5+c8GIHDw4EYPP/DgZmZgcP/5+eZmefnw--5+fn5+fn5+ffjwYDB4/f/5+fnAADn5+c/P8/PPz/Pz+fn5+fn5+fn///8wYnJyf8AgMDg8Pj8/v//////////Dw8PDw8PDw//////AAAAAAD//////////////////wA/Pz8/Pz8/PzMzzMwzM8zM/Pz8/Pz8/Pz/////MzPMzAABAwcPHz9--Pz8/Pz8/Pzn5+fg4Ofn5//////w8PDw5+fn4OD///////8HB+fn5////////wAA////4ODn5+fn5+cAAP///////wAA5+fn5+fnBwfn5+c/Pz8/Pz8/Px8fHx8fHx8f+Pj4+Pj4+PgAAP///////wAAAP////////////8AAAD8/Pz8/PwAAP////8PDw8P8PDw8P/////n5+cHB////w8PDw//////Dw8PD/Dw8PA8Zm5uYGI8AAAAPAY+Zj4AAGBgfGZmfAAAADxgYGA8AAAGBj5mZj4AAAA8Zn5gPAAADhg+GBgYAAAAPmZmPgZ8AGBgfGZmZgAAGAA4GBg8AAAGAAYGBgY8AGBgbHhsZgAAOBgYGBg8AAAAZn9/a2MAAAB8ZmZmZgAAADxmZmY8AAAAfGZmfGBgAAA+ZmY+BgYAAHxmYGBgAAAAPmA8BnwAABh+GBgYDgAAAGZmZmY+AAAAZmZmPBgAAABja38+NgAAAGY8GDxmAAAAZmZmPgx4AAB+DBgwfgA8MDAwMDA8AAwSMHwwYvwAPAwMDAwMPAAAGDx+GBgYGAAQMH9/MBAAAAAAAAAAAAAYGBgYAAAYAGZmZgAAAAAAZmb/Zv9mZgAYPmA8BnwYAGJmDBgwZkYAPGY8OGdmPwAGDBgAAAAAAAwYMDAwGAwAMBgMDAwYMAAAZjz/PGYAAAAYGH4YGAAAAAAAAAAYGDAAAAB+AAAAAAAAAAAAGBgAAAMGDBgwYAA8Zm52ZmY8ABgYOBgYGH4APGYGDDBgfgA8ZgYcBmY8AAYOHmZ/BgYAfmB8BgZmPAA8ZmB8ZmY8AH5mDBgYGBgAPGZmPGZmPAA8ZmY+BmY8AAAAGAAAGAAAAAAYAAAYGDAOGDBgMBgOAAAAfgB+AAAAcBgMBgwYcAA8ZgYMGAAYAAAAAP--AAAAGDxmfmZmZgB8ZmZ8ZmZ8ADxmYGBgZjwAeGxmZmZseAB+YGB4YGB+AH5gYHhgYGAAPGZgbmZmPABmZmZ+ZmZmADwYGBgYGDwAHgwMDAxsOABmbHhweGxmAGBgYGBgYH4AY3d/a2NjYwBmdn5+bmZmADxmZmZmZjwAfGZmfGBgYAA8ZmZmZjwOAHxmZnx4bGYAPGZgPAZmPAB+GBgYGBgYAGZmZmZmZjwAZmZmZmY8GABjY2Nrf3djAGZmPBg8ZmYAZmZmPBgYGAB+BgwYMGB+ABgYGP--GBgYwMAwMMDAMDAYGBgYGBgYGDMzzMwzM8zMM5nMZjOZzGYAAAAAAAAAAPDw8PDw8PDwAAAAAP//////AAAAAAAAAAAAAAAAAAD/wMDAwMDAwMDMzDMzzMwzMwMDAwMDAwMDAAAAAMzMMzPMmTNmzJkzZgMDAwMDAwMDGBgYHx8YGBgAAAAADw8PDxgYGB8fAAAAAAAA+PgYGBgAAAAAAAD--wAAAB8fGBgYGBgY--8AAAAAAAD--xgYGBgYGPj4GBgYwMDAwMDAwMDg4ODg4ODg4AcHBwcHBwcH--8AAAAAAAD///8AAAAAAAAAAAAA////AQMGbHhwYAAAAAAA8PDw8A8PDw8AAAAAGBgY+PgAAADw8PDwAAAAAPDw8PAPDw8Pw5mRkZ+Zw////8P5wZnB//+fn4OZmYP////Dn5+fw///+fnBmZnB////w5mBn8P///Hnwefn5////8GZmcH5g/+fn4OZmZn//+f/x+fnw///+f/5+fn5w/+fn5OHk5n--8fn5+fnw////5mAgJSc////g5mZmZn////DmZmZw////4OZmYOfn///wZmZwfn5//+DmZ+fn////8Gfw/mD///ngefn5/H///+ZmZmZwf///5mZmcPn////nJSAwcn///+Zw+fDmf///5mZmcHzh///gfPnz4H/w8/Pz8/Pw--z7c+Dz50D/8Pz8/Pz88P//+fDgefn5+f/78+AgM/v////////////5+fn5///5/+ZmZn//////5mZAJkAmZn/58Gfw/mD5/+dmfPnz5m5/8OZw8eYmcD/+fPn///////z58/Pz+fz/8/n8/Pz58///5nDAMOZ////5+eB5+f/////////5+fP////gf///////////+fn///8+fPnz5--w5mRiZmZw--n58fn5+eB/8OZ+fPPn4H/w5n54/mZw--58eGZgPn5/4Gfg/n5mcP/w5mfg5mZw/+BmfPn5+fn/8OZmcOZmcP/w5mZwfmZw////+f//+f/////5///5+fP8efPn8/n8f///4H/gf///4/n8/nz54--w5n58+f/5/////8AAP///+fDmYGZmZn/g5mZg5mZg--DmZ+fn5nD/4eTmZmZk4f/gZ+fh5+fgf+Bn5+Hn5+f/8OZn5GZmcP/mZmZgZmZmf/D5+fn5+fD/+Hz8/Pzk8f/mZOHj4eTmf+fn5+fn5+B/5yIgJScnJz/mYmBgZGZmf/DmZmZmZnD/4OZmYOfn5--w5mZmZnD8f+DmZmDh5OZ/8OZn8P5mcP/gefn5+fn5/+ZmZmZmZnD/5mZmZmZw+f/nJyclICInP+ZmcPnw5mZ/5mZmcPn5+f/gfnz58+fgf/n5+cAAOfn5z8/z88/P8/P5+fn5+fn5+fMzDMzzMwzM8xmM5nMZjOZ//////////8PDw8PDw8PD/////8AAAAAAP//////////////////AD8/Pz8/Pz8/MzPMzDMzzMz8/Pz8/Pz8/P////8zM8zMM2bMmTNmzJn8/Pz8/Pz8/Ofn5+Dg5+fn//////Dw8PDn5+fg4P///////wcH5+fn////////AAD////g4Ofn5+fn5wAA////////AADn5+fn5+cHB+fn5z8/Pz8/Pz8/Hx8fHx8fHx/4+Pj4+Pj4+AAA////////AAAA/////////////wAAAP78+ZOHj5///////w8PDw/w8PDw/////+fn5wcH////Dw8PD/////8PDw8P8PDw8A==";

function init(component)
  component.addInput("ADL", 8);
  component.addInput("ADH", 8);
  component.addInput("Din", 8);
  component.addInput("re", 1);
  component.addInput("clk", 1);
  component.addInput("ce", 1);

  component.addOutput("Dout", 8);
  component.addOutput("char", 8);
  component.addOutput("DispL", 8);
  component.addOutput("DispH", 5);
  component.addOutput("dclk", 1);

  VID_prevClockLevel = V_UNDEFINED; 
  VID_buffer = ArrayBuffer.new(1024);
  VID_charROM = base64.decode(CharROM_b64);
end

function simulate(inputs)
  local gateOutput = {};

  local adl = inputs[1];
  local adh = inputs[2];
  local din = inputs[3];
  local re = inputs[4];
  local clk = inputs[5];
  local ce = inputs[6];

  if(adl == V_ERROR or adh == V_ERROR or re == V_ERROR or din == V_ERROR) then
    res[1] = V_ERROR;
  elseif(adl ~= V_UNDEFINED and adh ~= V_UNDEFINED and re ~= V_UNDEFINED and clk ~= V_UNDEFINED) then
    local adx = bit32.bor(adl, bit32.lshift(bit32.band(adh, 0x00000003), 8));

    if(adx < #VID_buffer) then
      if(VID_prevClockLevel == 0 and clk == 1) then
        if(re == 0 and ce == 1 and din ~= V_UNDEFINED) then
          -- Write.
          VID_buffer[adx] = din;

          -- Generate the 8 clock ticks required to write the char on screen.
          local charROMAddr = bit32.lshift(din, 3); -- 8 bytes/char

          -- Where should the character start?
          local y = math.floor(adx / 40);
          local x = adx - y * 40;
          local dispAddr = x + y * 320;

          local curTime = 1;
          for i=0,7,1 do
            local goid = 1 + (i * 2);

            gateOutput[goid + 0] = {
              t = curTime,
              outputs = {
                VID_buffer[adx],
                revBits8(VID_charROM[charROMAddr]),
                bit32.band(dispAddr, 0x000000FF),
                bit32.band(bit32.rshift(dispAddr, 8), 0x000000FF),
                0
              }
            };

            gateOutput[goid + 1] = {
              t = curTime + 1,
              outputs = {
                VID_buffer[adx],
                revBits8(VID_charROM[charROMAddr]),
                bit32.band(dispAddr, 0x000000FF),
                bit32.band(bit32.rshift(dispAddr, 8), 0x000000FF),
                1
              }
            };
          
            curTime = curTime + 2;
            charROMAddr = charROMAddr + 1;
            dispAddr = dispAddr + 40; -- 40 char/row
          end
        else
          gateOutput[1] = {
            t = 1,
            outputs = {
              VID_buffer[adx],
              0, 0, 0, 0
            }
          };
        end
      else
        gateOutput[1] = {
          t = 1,
          outputs = {
            VID_buffer[adx],
            0, 0, 0, 0
          }
        };
      end
    else
      gateOutput[1] = {
        t = 1,
        outputs = {
          V_UNDEFINED, V_UNDEFINED, V_UNDEFINED, V_UNDEFINED, V_UNDEFINED
        }
      };
    end
  end

  VID_prevClockLevel = clk;

  return gateOutput;
end

function revBits8(v)
  local r = v; -- r will be reversed bits of v; first get LSB of v
  local s = 7; -- extra shift needed at end

  v = bit32.rshift(v, 1);
  while(v ~= 0) do
    r = bit32.lshift(r, 1);
    r = bit32.bor(r, bit32.band(v, 1));
    v = bit32.rshift(v, 1);
    s = s - 1;
  end
  
  r = bit32.lshift(r, s);
  return r;
endEXTGr�D�7��   EXTG��D SjA   EXTG��DӕC   EXTG���D��C   EXTGL��D"/D   CUST5��DLa��COMP     Kernal ROM (patched)INPL      ADL %      ADH M   OUTL      D GATE   ROMX�V ��aɈ� Ժ ̼�i���8�H��i�a�a�i���V�p S� ���Ġ� Y� �oh ��`�q�r ʻ�W (� ]�W� L(��q�r ǻ�q�g�qȘ��r�q�r (��q�ri�ȅq�r g��\� �g��`�5Dz h(�F  +�07�  ���"�#��"�bȱ"�d��"�cȱ"�eL�ੋ�  ������ (����� g��e�b�e�b�c�d�c�d� �f�a�p���a ׸��� LԻ����8�7Lc����L7� ����` ����` ���` ����` ����` �� ����H�FH�H���(l ���h�` ��-�.�+ ����`�,� �
 ��
�+�, ���W�
�� ��)��z���d��L�` ��)���L7��{���-�.�v�� �L*� �� 3�Lw� � ���` �I ����L��  ����  �� � W� �  � �I �� �  ⊨�IL�� �L�� y �hh` �� y ��L��  �� � ���I���  �� �  �J� �I��� �� �  ⊨�J�I �� � � �� ���"�#L����� g� ����n � � ̼� �o S���� P��fH I��f0	�I�� ����� g�h �����LC� ʻ� � k�N�  ��W�  ��� �f� ��N� L�HL��Iڢ�Iڢ    ��-�(����h��#5�ᆥ]�(�Iڢ�fH ���aHɁ����� ��>�� C�hɁ���� P�hL��`v����y���{���|g�|�S��}dpL}��Qz}c0�~~�D�:~L̑�����     ��� � z�X��l �0L:�Lt� S� �� "������z��{�`��:�
� ��8�08��`�O�RX�L�T��H��������������������s����S� �h���������8 ���+�,8 ���7�8�3�4� ��+�+��,`�+�, ��s�� ��78�+��8�, ͽ�`�� �LD��ヤ|��䧆���G� ��`  BASIC BYTES FREE �    **** COMMODORE 64 BASIC V2 **** 64K RAM SYSTEM   �H ���h��`���������������������������������`����`i����š��`&D�p�7� i � ��`�(�`��ք� l�֤�` �� ���ϩH���덐�
������������̭ͅ�	��� ���i(��������٢ ����� �ӄ֦֥Ӵ�0i(���� ��'��0i(����L$����L��`� ��Lf���� ���/��������`�w� �x�w������ƘX` �ƅ̍���x����ή�� �� � ��Ƀ��	x�ƽ��v�������ȤՄб�� ����ȄȠ ���ӄԥ�0�� ������ʅ��Ȑ
�+�H�H���ӱх�)?�$�	�����p	@�� ������ �Щ�������� ���h�h��������`�"���I�ԩ"`	@���	�����خ� � ��h����F�h�hX` ���ӥ��Ӱ?�O�2���Lg���� ���֦��V���	���ʥ�i(�յ�0���L���� |� ��`�����hhНʆ� l�Մ�`H�׊H�H� �Фӥ�L����L��� ��`�)��)? ��L����L����.�� �Ls� �舄� $�ȱш��ȱ������� �ѭ���M���L�������� f���� ��ӈ�Ր	�� |� ��L�����i(����Ր������(����� |�L�� ��LD�)���^� �L����L����?��7�ձ�� �����O�$ e�� $ꈱ�ȑш��ȑ����� �ѭ�����L����	@L�������7�֥�8�(���* l��%��� ������	 �舄�L�� �L���� D�L��	� ��LO�Fɦ���� �����Ll� �؆ǆԆ� |�L��� ���i(���`��`��'���i(���`������`�������`��`��������������H��H��H��H������Υ� ������셬�� ��0� �� ��)��	��������	���������� ܭ����� �(�� ��������Ʀ�h��h��h��h��`���������� �讥���L�楬H��H��H��H�� �������셬�� ��0� ������)��	�����쮥 ��LX�)��� ��'���ѱ����` $ꥬ����)	؅�`���ѵ�)���`�' �� $� �� �ш�`ꨩ�� $꘤ӑъ��`�х��)	؅�` �����)���%��ͤ�FϮ��Ѱ�υ� $������I� �)�
� ���	 �����)� ���h�h�h@� ���@�ˍ ܮ����a����������� ܢH������J�H�����������h��A����8h*� ���hl��˱���������6),�0pI��)��� �����5���Ό�+΋�&����ƈ�˄Ŭ������������w�Ʃ� �`����͎�0��I��Lv�
�����y���z��L������x�����3WA4ZSE5RD6CFTX7YG8BHUV9IJ0MKON+PL-.:@,\*;=^/1_2 Q���������#��$���%��&����'��(����)��0��������>[�<��]�=�?!_"�у��������������������������������)��0��������>[�<��]�=�?�_���������	�	Ɏ���)���L�������0	�	��-���L��������������	
���� �����������                 �7           LOADRUN (Px���@h���0X���� Hp��	@,	  ��H$�
8f� @�F�F�h��x ���?� �� �	� �x �� �� ��x �� ��d ��$�
 ��� ��� ��� ����� �� ���
�?f�� ��� �� ������ �)�	� �ƥ�ԩ�ܩ�ܭܭ�)�
 ���X`��,� �X�J�� 6�� �)�� �`�� 6�x �� �� �� ��0�X`$�08f��H @�h��`x �� �	� ݩ_,�? � �튢
���� ��L��x� �� �� �����ܩ�� ��ܭ�)� ��0�����L�� �� ��@ ���ʩ��� �� ���
�f�� �� ���
0�ƥ�� ��$�P X`� �)� �`� �	� �`� �)ߍ �`� �	 � �`� �� ���
`�������`���G0?F�� �ʊE���ƴ��)��`� ,��0p����ƴ���ƴ���������p�P�洢��˭�J�,�P� ����������̞������`�@,�������M�	�����`�	� ,���P��`���3ƨ�60��E���F�f�`ƨ���g��
�e��祖��������L;不��L�䬛�̜�*��������	�J������ ,��0���E��p�,P��,�,��,����L~索���셚��J�)�,�� ��)��,�p���	��,�p0��@��` (��̝���������J���ݭ��ݭ��ݩ� ;� ���`����J�()�$�,���"��J����)��ݭ�)����L;ﭡ)��`����̛�)������`	��� `H�����)����ݩ ��h`I/O ERROR �SEARCHING�FOR�PRESS PLAY ON TAP�PRESS RECORD & PLAY ON TAP�LOADIN�SAVING�VERIFYIN�FOUND�OK�$����) ���(�`������xL������ ��`����Ӆʥօ�L2���	�ХՅ�L2�8��?�� ��H ����@ �Ʀ��h`�h���` �� A��� ����`����`L� N��� ��)`����H����hL�hL��Jh���H�H�# �� d���� ��Ȅ�����h�h����� ` �L�� ��L� �������LM��`�L
���`� 	��� ��LH� ��$��L� ��L� ��L������L�惡�`�ꅚ`� ��� ��� ��$��L� ��` �H���P��L�G��h �� �� '����ȥ��ȩ ����L}���)�# ��� 8 �� d��h� `���b�� j�L�� B�h�Ƙ�����Y�Y�c�c�m�m`� ������0�Y��`�Y���c���m��`� ���䚰 ��䙰 �톚� ��`���L
� ��L�����
�L��春��Y��	`���m���c�Z��V� ��O��L	� ���L���)� ��6 �����
 ����(L� ,�� ��� 8��� j������`�� ������`��0������ ���� ���	� ����hhL����� �� ���ķ��LT� ��ķ�
�������� J��)�
����	������L@�����䌖����
 .���J�	��
� ������� '�����������������8��L-���ݩ�ݍݩ ݍ ݠ ��`�Ä�l0��� �����L�����{���L��� ���`�� �� 	��� �� ��JJ�P ���Å��ą� ����%��� ���L3� �JJ�芤��� Ѯ�� �,�����$�P� �� B��yL�J�L� ���L� ��h �����	 ����Z�� ,��S�ӥ�)8�J����ݠ����ȱ��İ�������񲪠�����eÅ��eą��Å��ą� �� J�$����`��� /��� /��� �� ���ķ��`�I����YL+񆮄��� �����l2���L�����_�a�����L� �� ���� ��� ���  ���� ���� �� ����� �� ��� B�� 8` ���� ��$�0�� ���)�	� �� ��`J�L� ���� 8��% �����)��� j�� g����)�� j�$`����Q /�L��� �����8���������O��������������0��� ܮ������ �����`x������x������X`���� ����(`�,�,�,�,�,�,�,�,�	H ��� $�P
 /�hH	0 ��h8`��H A�h���2� ����*�������$��c /��� �������� ����`�� ���^��H��H��H��H��� ���������ȥ���ȥ�ȥ���ȥ���Ȅ�� ����ķ����������� ���i�� k��h��h��h��h�`�����` �����i������i ��` ,������ ��ķ�����Ѳ���柤���` ��榤���` .��� /� �� .����jL/�$�$` .����.�ݩ ���� �� ��x� ���������������� ����� 8��lx�����܍ܭ�	��)��� ���)�Э����� ����� ���)�������������X���� �� ��L�� ��� ��8hh� ��`����

e�e���� $�0*�*�*������e��܊m܍ܭ��܍���)�	��H�*HLC�X`�ܠ�������򆱪�܌ܩ�ܭ܍��屆�Jf�Jf���i<ű�J���L`���0� i0e�ű��i&e�ű�i,e�ű�L�������橰Ʃ8��e�����I���+�ץ��"��)����� ������00��� ����йL�����0ư,氩 ������Р��0���������E�������ƣ0�F�f��� ��L����������0L��F���8�e�
� ��朥�����&��� �����܅������	� ����ܥ��������L�� ������ ��������$��������� ��� ��L��p1���������J��0��)��ƪ�ݩ@�� ��� ���Щ����ʥ��
� �� LJ� ���LH�����-���� ��Ѭ�������K�=䞐>�������� �膞L:�����5��� �.����'�查����� Ѭ�Ȅ����� ��	�������� ���C����x��ܮܦ��0��Ƨ����'���# �� ��� ����E��� �� ����E���  �L��������`���� ��������`��J�`���� �܎ܭܩ�ܥI�)`8f�0<����� ���/樥�)LW����	 ����� �����I�����I��)E���L��F�ƣ���:� ��X���� ��ƥ����	����� ���
Б步ׅ��ʠ ����Eׅ� ��л��I��L��ƾ� ���P���x ����x ����Ƨ�� ��ƫآ
 ��X櫥��0 ���	����Ѓx��	�� ����� �����	����(` ��𗽓������`�	 �`8��宥��`���`��x�� ��l ��� �� P� � [�Xl ����������`���80�0���ÄĠ���ÑÙ��`1�f�G�J���P�3�W�����>�/�f������ �� � � ����<�����������±���U�����*������������䘪�� -�������`j���1�,���܍ݍ ܩ�܍ݍ܍ݢ �܎ݎ�ʎܩ� ݩ?�ݩ��/� ���
�%�ܩ@L�����ܩB��Ln�������`������`������H� ��h`�������`��`���������`���������`xlH�H�H��ݬ�0 ��l� �� ��� � �� �l��-��)�(� �)��� ݭ��݊)�)� ��L�� � ��L���)� ��L���)� �����h�h�h@�'>�t�E�F� q ��)�����m��ݭ�m��ݩ�ݭ��ݩ��ݍ�LYﭕ�ݭ��ݩ�ݩM������ݍݮ���`���*��iȍ��i ��`��h)�HH�H�H��)�ll ������)��L�����ܭ�)�	��L��L[�L��LP�L�L�L�L��L��L%�L4�L��L!�L�L��L��L��L�L	�L�L �L��llll l"l$l&L��L��L��L��l(l*l,L��L�L
�L �RRBYC���H�BUSSBUSSBUSMWIRE   ����           ����                                                                                                                                  	            
                                                  ����    CSCHSCHM  INPL   INPP  �C  �C   ADL %   INPP�˻C�nD   ADH M   OUTL   OUTP�X�D��C   D GATE   ROMX\��DQ��C�V ��aɈ� Ժ ̼�i���8�H��i�a�a�i���V�p S� ���Ġ� Y� �oh ��`�q�r ʻ�W (� ]�W� L(��q�r ǻ�q�g�qȘ��r�q�r (��q�ri�ȅq�r g��\� �g��`�5Dz h(�F  +�07�  ���"�#��"�bȱ"�d��"�cȱ"�eL�ੋ�  ������ (����� g��e�b�e�b�c�d�c�d� �f�a�p���a ׸��� LԻ����8�7Lc����L7� ����` ����` ���` ����` ����` �� ����H�FH�H���(l ���h�` ��-�.�+ ����`�,� �
 ��
�+�, ���W�
�� ��)��z���d��L�` ��)���L7��{���-�.�v�� �L*� �� 3�Lw� � ���` �I ����L��  ����  �� � W� �  � �I �� �  ⊨�IL�� �L�� y �hh` �� y ��L��  �� � ���I���  �� �  �J� �I��� �� �  ⊨�J�I �� � � �� ���"�#L����� g� ����n � � ̼� �o S���� P��fH I��f0	�I�� ����� g�h �����LC� ʻ� � k�N�  ��W�  ��� �f� ��N� L�HL��Iڢ�Iڢ    ��-�(����h��#5�ᆥ]�(�Iڢ�fH ���aHɁ����� ��>�� C�hɁ���� P�hL��`v����y���{���|g�|�S��}dpL}��Qz}c0�~~�D�:~L̑�����     ��� � z�X��l �0L:�Lt� S� �� "������z��{�`��:�
� ��8�08��`�O�RX�L�T��H��������������������s����S� �h���������8 ���+�,8 ���7�8�3�4� ��+�+��,`�+�, ��s�� ��78�+��8�, ͽ�`�� �LD��ヤ|��䧆���G� ��`  BASIC BYTES FREE �    **** COMMODORE 64 BASIC V2 **** 64K RAM SYSTEM   �H ���h��`���������������������������������`����`i����š��`&D�p�7� i � ��`�(�`��ք� l�֤�` �� ���ϩH���덐�
������������̭ͅ�	��� ���i(��������٢ ����� �ӄ֦֥Ӵ�0i(���� ��'��0i(����L$����L��`� ��Lf���� ���/��������`�w� �x�w������ƘX` �ƅ̍���x����ή�� �� � ��Ƀ��	x�ƽ��v�������ȤՄб�� ����ȄȠ ���ӄԥ�0�� ������ʅ��Ȑ
�+�H�H���ӱх�)?�$�	�����p	@�� ������ �Щ�������� ���h�h��������`�"���I�ԩ"`	@���	�����خ� � ��h����F�h�hX` ���ӥ��Ӱ?�O�2���Lg���� ���֦��V���	���ʥ�i(�յ�0���L���� |� ��`�����hhНʆ� l�Մ�`H�׊H�H� �Фӥ�L����L��� ��`�)��)? ��L����L����.�� �Ls� �舄� $�ȱш��ȱ������� �ѭ���M���L�������� f���� ��ӈ�Ր	�� |� ��L�����i(����Ր������(����� |�L�� ��LD�)���^� �L����L����?��7�ձ�� �����O�$ e�� $ꈱ�ȑш��ȑ����� �ѭ�����L����	@L�������7�֥�8�(���* l��%��� ������	 �舄�L�� �L���� D�L��	� ��LO�Fɦ���� �����Ll� �؆ǆԆ� |�L��� ���i(���`��`��'���i(���`������`�������`��`��������������H��H��H��H������Υ� ������셬�� ��0� �� ��)��	��������	���������� ܭ����� �(�� ��������Ʀ�h��h��h��h��`���������� �讥���L�楬H��H��H��H�� �������셬�� ��0� ������)��	�����쮥 ��LX�)��� ��'���ѱ����` $ꥬ����)	؅�`���ѵ�)���`�' �� $� �� �ш�`ꨩ�� $꘤ӑъ��`�х��)	؅�` �����)���%��ͤ�FϮ��Ѱ�υ� $������I� �)�
� ���	 �����)� ���h�h�h@� ���@�ˍ ܮ����a����������� ܢH������J�H�����������h��A����8h*� ���hl��˱���������6),�0pI��)��� �����5���Ό�+΋�&����ƈ�˄Ŭ������������w�Ʃ� �`����͎�0��I��Lv�
�����y���z��L������x�����3WA4ZSE5RD6CFTX7YG8BHUV9IJ0MKON+PL-.:@,\*;=^/1_2 Q���������#��$���%��&����'��(����)��0��������>[�<��]�=�?!_"�у��������������������������������)��0��������>[�<��]�=�?�_���������	�	Ɏ���)���L�������0	�	��-���L��������������	
���� �����������                 �7           LOADRUN (Px���@h���0X���� Hp��	@,	  ��H$�
8f� @�F�F�h��x ���?� �� �	� �x �� �� ��x �� ��d ��$�
 ��� ��� ��� ����� �� ���
�?f�� ��� �� ������ �)�	� �ƥ�ԩ�ܩ�ܭܭ�)�
 ���X`��,� �X�J�� 6�� �)�� �`�� 6�x �� �� �� ��0�X`$�08f��H @�h��`x �� �	� ݩ_,�? � �튢
���� ��L��x� �� �� �����ܩ�� ��ܭ�)� ��0�����L�� �� ��@ ���ʩ��� �� ���
�f�� �� ���
0�ƥ�� ��$�P X`� �)� �`� �	� �`� �)ߍ �`� �	 � �`� �� ���
`�������`���G0?F�� �ʊE���ƴ��)��`� ,��0p����ƴ���ƴ���������p�P�洢��˭�J�,�P� ����������̞������`�@,�������M�	�����`�	� ,���P��`���3ƨ�60��E���F�f�`ƨ���g��
�e��祖��������L;不��L�䬛�̜�*��������	�J������ ,��0���E��p�,P��,�,��,����L~索���셚��J�)�,�� ��)��,�p���	��,�p0��@��` (��̝���������J���ݭ��ݭ��ݩ� ;� ���`����J�()�$�,���"��J����)��ݭ�)����L;ﭡ)��`����̛�)������`	��� `H�����)����ݩ ��h`I/O ERROR �SEARCHING�FOR�PRESS PLAY ON TAP�PRESS RECORD & PLAY ON TAP�LOADIN�SAVING�VERIFYIN�FOUND�OK�$����) ���(�`������xL������ ��`����Ӆʥօ�L2���	�ХՅ�L2�8��?�� ��H ����@ �Ʀ��h`�h���` �� A��� ����`����`L� N��� ��)`����H����hL�hL��Jh���H�H�# �� d���� ��Ȅ�����h�h����� ` �L�� ��L� �������LM��`�L
���`� 	��� ��LH� ��$��L� ��L� ��L������L�惡�`�ꅚ`� ��� ��� ��$��L� ��` �H���P��L�G��h �� �� '����ȥ��ȩ ����L}���)�# ��� 8 �� d��h� `���b�� j�L�� B�h�Ƙ�����Y�Y�c�c�m�m`� ������0�Y��`�Y���c���m��`� ���䚰 ��䙰 �톚� ��`���L
� ��L�����
�L��春��Y��	`���m���c�Z��V� ��O��L	� ���L���)� ��6 �����
 ����(L� ,�� ��� 8��� j������`�� ������`��0������ ���� ���	� ����hhL����� �� ���ķ��LT� ��ķ�
�������� J��)�
����	������L@�����䌖����
 .���J�	��
� ������� '�����������������8��L-���ݩ�ݍݩ ݍ ݠ ��`�Ä�l0��� �����L�����{���L��� ���`�� �� 	��� �� ��JJ�P ���Å��ą� ����%��� ���L3� �JJ�芤��� Ѯ�� �,�����$�P� �� B��yL�J�L� ���L� ��h �����	 ����Z�� ,��S�ӥ�)8�J����ݠ����ȱ��İ�������񲪠�����eÅ��eą��Å��ą� �� J�$����`��� /��� /��� �� ���ķ��`�I����YL+񆮄��� �����l2���L�����_�a�����L� �� ���� ��� ���  ���� ���� �� ����� �� ��� B�� 8` ���� ��$�0�� ���)�	� �� ��`J�L� ���� 8��% �����)��� j�� g����)�� j�$`����Q /�L��� �����8���������O��������������0��� ܮ������ �����`x������x������X`���� ����(`�,�,�,�,�,�,�,�,�	H ��� $�P
 /�hH	0 ��h8`��H A�h���2� ����*�������$��c /��� �������� ����`�� ���^��H��H��H��H��� ���������ȥ���ȥ�ȥ���ȥ���Ȅ�� ����ķ����������� ���i�� k��h��h��h��h�`�����` �����i������i ��` ,������ ��ķ�����Ѳ���柤���` ��榤���` .��� /� �� .����jL/�$�$` .����.�ݩ ���� �� ��x� ���������������� ����� 8��lx�����܍ܭ�	��)��� ���)�Э����� ����� ���)�������������X���� �� ��L�� ��� ��8hh� ��`����

e�e���� $�0*�*�*������e��܊m܍ܭ��܍���)�	��H�*HLC�X`�ܠ�������򆱪�܌ܩ�ܭ܍��屆�Jf�Jf���i<ű�J���L`���0� i0e�ű��i&e�ű�i,e�ű�L�������橰Ʃ8��e�����I���+�ץ��"��)����� ������00��� ����йL�����0ư,氩 ������Р��0���������E�������ƣ0�F�f��� ��L����������0L��F���8�e�
� ��朥�����&��� �����܅������	� ����ܥ��������L�� ������ ��������$��������� ��� ��L��p1���������J��0��)��ƪ�ݩ@�� ��� ���Щ����ʥ��
� �� LJ� ���LH�����-���� ��Ѭ�������K�=䞐>�������� �膞L:�����5��� �.����'�查����� Ѭ�Ȅ����� ��	�������� ���C����x��ܮܦ��0��Ƨ����'���# �� ��� ����E��� �� ����E���  �L��������`���� ��������`��J�`���� �܎ܭܩ�ܥI�)`8f�0<����� ���/樥�)LW����	 ����� �����I�����I��)E���L��F�ƣ���:� ��X���� ��ƥ����	����� ���
Б步ׅ��ʠ ����Eׅ� ��л��I��L��ƾ� ���P���x ����x ����Ƨ�� ��ƫآ
 ��X櫥��0 ���	����Ѓx��	�� ����� �����	����(` ��𗽓������`�	 �`8��宥��`���`��x�� ��l ��� �� P� � [�Xl ����������`���80�0���ÄĠ���ÑÙ��`1�f�G�J���P�3�W�����>�/�f������ �� � � ����<�����������±���U�����*������������䘪�� -�������`j���1�,���܍ݍ ܩ�܍ݍ܍ݢ �܎ݎ�ʎܩ� ݩ?�ݩ��/� ���
�%�ܩ@L�����ܩB��Ln�������`������`������H� ��h`�������`��`���������`���������`xlH�H�H��ݬ�0 ��l� �� ��� � �� �l��-��)�(� �)��� ݭ��݊)�)� ��L�� � ��L���)� ��L���)� �����h�h�h@�'>�t�E�F� q ��)�����m��ݭ�m��ݩ�ݭ��ݩ��ݍ�LYﭕ�ݭ��ݩ�ݩM������ݍݮ���`���*��iȍ��i ��`��h)�HH�H�H��)�ll ������)��L�����ܭ�)�	��L��L[�L��LP�L�L�L�L��L��L%�L4�L��L!�L�L��L��L��L�L	�L�L �L��llll l"l$l&L��L��L��L��l(l*l,L��L�L
�L �RRBYC���H�BUSS   D  4C BUSS   D  �C BUSM  RD  4C WIRE                        D  �C  D  �C                    D  %D  D  %D                   9D  HC  CD  HC                 9D  pC  CD  pC                 9D  �C  CD  �C                 9D  �C  CD  �C                 9D  �C  CD  �C                 9D  �C  CD  �C                 9D  �C  CD  �C                 9D  �C  CD  �C                  9D  D  CD  D         	        9D  D  CD  D         
        9D  D  CD  D                 9D   D  CD   D                 9D  *D  CD  *D                    kD  �C  uD  �C                     �D  �C  �D  �CTEST    CUST�ߜD +�CCOMP  	   BASIC ROMINPL      ADL %      ADH M   OUTL      D GATE   ROMX��{�CBMBASIC0�A���������������p�'����Ѩ:�.�J�,�g�U�dᲳ#����V���]���)����z�A�9�̼X�}���q������d�k����|�e������ �,�7�yi�yR�{*�{�z�P�F�}��ZӮd�EN�FO�NEX�DAT�INPUT�INPU�DI�REA�LE�GOT�RU�I�RESTOR�GOSU�RETUR�RE�STO�O�WAI�LOA�SAV�VERIF�DE�POK�PRINT�PRIN�CON�LIS�CL�CM�SY�OPE�CLOS�GE�NE�TAB�T�F�SPC�THE�NO�STEЫ����AN�OҾ��SG�IN�AB�US�FR�PO�SQ�RN�LO�EX�CO�SI�TA�AT�PEE�LE�STR�VA�AS�CHR�LEFT�RIGHT�MID�G� TOO MANY FILE�FILE OPE�FILE NOT OPE�FILE NOT FOUN�DEVICE NOT PRESEN�NOT INPUT FIL�NOT OUTPUT FIL�MISSING FILE NAM�ILLEGAL DEVICE NUMBE�NEXT WITHOUT FO�SYNTA�RETURN WITHOUT GOSU�OUT OF DAT�ILLEGAL QUANTIT�OVERFLO�OUT OF MEMOR�UNDEF'D STATEMEN�BAD SUBSCRIP�REDIM'D ARRA�DIVISION BY ZER�ILLEGAL DIREC�TYPE MISMATC�STRING TOO LON�FILE DAT�FORMULA TOO COMPLE�CAN'T CONTINU�UNDEF'D FUNCTIO�VERIF�LOAĞ�����¡С�����%�5�;�O�Z�j�r����������Ȣբ��� ���$���OK   ERROR  IN  
READY.
 
BREAK ������Ɂ�!�J�
��I��J���I���i���` ��1�28�Z�_�"��[�`���#�Z8�"�Z��[8�X�"�X��Y��Z�X����Z�X�[�Y���`
i>�5�"��"�.`�4�(��3�"H�	�H�W�� &���h�a�0�h�h�4���3�`�l �
��&��"�'��# ��� � ת E�� �"H) G��h� z��i�� ��:�� ½�v�� ��� ��l `��z�{ s �����:� y�L� k� y�� ��D��_�#�-�"�`�%�_��_e-�-�$�.i��.�`�8�_�-����%e"��#�"�$����#�%��� Y� 3�� ���-�Ze�X�.�[�ȄY ���������1�2�-�.�����_�� Y� 3�L���+�,�"�#��"��ȱ"��Șe"�� �"�#i ȑ"�"�#��`�  ���� ��Y��L7�Lʪl�z��� ���>���� �7��"�V$p-�?����%�0��<��q� ���z��� 8�����ɀ�0�q�ș����68�:��I��8�UП�� �����ș����z�ȹ������д� ����{���z`�+�,��_�`�_��ȥ�_����	���_��
��_���_��`��� ��+ȑ+�+i�-�,i �. ��� �- ���7�8�3�4�-�.�/�0�1�2 ���h�h���H�H� �>�`�+i��z�,i��{`��ɫ�� k� � y �ɫЎ s  k�Іhh���������_�C ,� תȱ_�ȱ_�����,�I ͽ� �I) G��"��I�����_���_�ȱ_�_�`еL��l�����$0�8���I����ȹ���0�ȹ��0� G������ �� ����i��hh�	 �� ��ezH�{i H�:H�9H�� �� �� ���f	%b�b�����"�#LC����� �� y ɩ� s  �� +� 8��JH�IH��H ,��z�{����=�>� �z�C��z�LK�ȱz�9ȱz�:�ez�z��{l s  ��L���<逐�#�
���H��HLs L���:��L��K�� s �� ��L��8�+��,���A�B` ����<�z�{�:���=�>�9�:�;�<hh�����Li�L�����>�L7��=�z�{�;�<�9�:`�  ��(�LY� `�L��� ���{H�zH�:H�9H��H y  ��L�� k� 	�8�9��:���8ez�{���+�, ���_��z�`� �{`�����J ���ɍ��,�L7�L�hh�9h�:h�zh�{ ��ez�z��{`�:,� �� ������z�������"���� �� y ɉ��� ���a� 	�� y �L��L�� ��Hɍ�ɉБ�e�hL� s  k��,��h`� �����/���"��ԥ
&"
&"e��"e�&�e��� s Lq� ���I�J�� ���H�H ��h* ���h � ��� �d�Iȥe�I`Lлh�J���L ����=� �a�f�q � ��q�q � ���� ���q���� � ���d�c�eL���" � �LH��/L~���d�4����d�3��e�.���d�-��d�eLh�� �d u��P�Q�o�p z��a� �P�Q ۶� �P�IȱP�IȱP�I` ��L�� ����, ��� �(L�� !� y �5�Cɣ�Pɦ�K�,�7�;�^ ��$0� ݽ �� !� ;��ө � ������ G�$�
 G�I�`8 ���8�
��I�i�8 ���	 ���)�Y(���	����� s L�� ;��� �� ���� ���" G����� �L(���� ,�,�? �)�`��0����?�@�9�:L����L7���� ��=�>�z�{` ���#� s  ���, ��� ��� ��@ ���` ���, ��� � Ϋ� ��� �`�"� ���; �� !� ���,�� ���� ��)� ��L��� ���� �L���� E� ;�L`��A�B��,� ��C�D ���I�J�z�{�K�L�C�D�z�{ y � $P $� ����0u�� E� ���z�{ s $1$P	�z� ����"��:��,��z�{i �� �� � کL�� � © y ��,�LM��z�{�C�D�K�L�z�{ y �- ��L� �Ȫ��ȱz�lȱz�?ȱzȅ@ �� y �����LQ��C�D�L'�� �C�������L�`?EXTRA IGNORED ?REDO FROM START �� � ���I�J ����
L7���iHi�$h� ����	�f�I�J g� л� ]��8�	���9��:��z��{L���i�� y �,�� s  $� ��$8$0�`���L7��z��{�z� $H�H� �� ��� �M y 8鱐���*IEM�M�a�M s L���M�,�{i�we�L=�i��"
e"�hـ��g ��H  �h�K��V�_F�*�z��{�z��M��ـ��H�ٹ��H���H 3��ML��L��f����h�"�"h�#�H ��eH�dH�cH�bH�aHl" ��h�#�d� ���KhJ�h�ih�jh�kh�lh�mh�nEf�o�a`l
� � s �L� ��L(�������� ��Ls �Iڡ�.��ɫ�Xɪ���"��z�{i �� ��L�ɨ���; ���eI���dI�L��ɥ�L��ɴ�L�� �� ���),�(,�,� �z�Ls �L7��hhL��8�d� �e預���d���e` ���d�e�E�F��&� �p ���T���� ���^��q��]�$ h�Lo�`$� �d�ȱd��L�� ��-�T��I�% �����LO� ���d�c�e� �b`�S�
�T� ��L<��d�eL��
H� s ���  �� �� �� ��h��eH�dH�H ��h��HL֯ �h��ꟅU�럅V T L����,� � ���dE��eE� �� ���eE%E��dE%EL�� ����n	%j�j�i�  [��La�� ��M ���a�b�c�l�m ���l�m�8�a����a���f�������f0��l�b������*%���L<� ��� �� y ��`�  y ��E y  ��L�� �� s � ��� s �� ����$������%���Щ��E�E�	�� s �F8�(�Lѱ� ��-�.�`�_�0��/�"�E�_��F��_�}��_i������A��[8�`hH�*����`�E�F�T������I�L��S��T���/�0�_�`�1�2�Z�[i�ȅX�Y ���X�Yȅ/�0� �E�_ȥF�_� ȑ_ȑ_ȑ_ȑ_ȑ_�_i�`�ȅG�H`�
ie_�`�ȅX�Y`��    ���d�e` s  �� ���f0�aɐ�	���� [��zL���H�H� �H�FH�EH ��h�Eh�Fh���H�H�d��e�� y �,�҄ ��h�h�)��/�0�_�`�2��1�9� �_��E��F�_�ȱ_e_�ȱ_e`�ע,�L7����� �����_��L� �� �� �r��E�_�ȥF�_�ʆq���ȑ_�� $Phi�hi ȑ_Ȋ�_ L��q�r�"���eY�]�Y��eX���R ��1�2� �r�q���X���Y�r���Y8�1�_��_�2��`�_��bȱ_�� �q�r�h��dh�e�_��Ȋ�_�LE�L5�ȥrq�
 L��ed���"ee�q��ʅr��EʥF�ʆ(�  U��eX�G�eY�H��G`�"�_�(��_�)��]� � �
��*���q&r��e(��e)����]��`�� �� &�8�3�1��4�2� ��b�c��LD�8 ��� ��:�Р�,�L7� � �� ����� �� �� ���� ��H�HH�GH�{H�zH ��LO��� ��	�� ���N�OL�� ᳥OH�NH � ��h�Nh�O��N�G�ȱN�HȱGH���H Ի�{H�zH�N�zȱN�{�HH�GH ��h�Nh�O y �L�h�zh�{� h�NhȑNhȑNhȑNhȑN` ���  ߽hh��� ��d�e�P�Q ���b�c�a`�"���o�p�b�c��ȱo�������"��a�eo�q�p��r�p���� u��o�p ����"��L7��a� �b��c�� �d�e�p������`FHI�8e3�4���2���1��3�4�5�6�h`��0� &����h�Ц7�8�3�4� �O�N�1�2�_�`�� �"�#�� ǵ����S�-�.�"�#�0��/� ����X�Y��S�X�Y�2��1�L��"�#� �"�ȱ"ȱ"eX�Xȱ"eY�Y(ӊ0�ȱ"� 
ie"�"��#�#�Y��X� ǵ��"05ȱ"0ȱ"�+ȱ"�ȱ"�4���3��`���_��_�`�"�#�N�O�S�U�Se"�"��#�#� `�ON���U)J��U�Ne_�Z�`i �[�3�4�X�Y ���UȥX�N��Y�YȑNL*��eH�dH �� ��h�oh�p� �oqd��L7� u� z��P�Q �� ���o�p �� ʴL��� �oHȱo�ȱo�h�"�#��
H��"�5���he5�5��6` ���d�e�"�# ۶� �"Hȱ"�ȱ"�h(��4��3�He3�3��4h�"�#`�������� ` ���H� }�h� �bhhLʴ a��P���P��H�H }��P�Q ��h�he"�"��#� ��Lʴ a��PI�L����e y �)� �� �� a��KʊH� �P��I��e���e�� ��h�h�Uhhh�h�Ph�Q�UH�H� �` ��L�� ��� ��` ���� �"�L��LH� s  �� ���d��eLy  ���L���z�{�q�r�"�ze"�$�#�{��%� �$H��$ y  �h� �$�q�r�z�{` �� �� ��L���f0��aɑ�� ���d�e��`�H�H ��� ��h�h�L�� 뷊� �` 뷆I�  y � �J� �EJ%I��`���Lg� ���fI��fEn�o�aLj� ���< ���L���p�V�i�i���8�a�$��a�n�fI�i � �V�a�� �p��0Ǩ�pV ��$oW�a�i��i8I�eV�p� ��e� ��d� ��c� ��b� G�� ��b�J�c�b�d�c�e�d�p�e�pi� �� �a�f`eV�p�eem�e�del�d�cek�c�bej�bL6�ip&e&d&c&b�8�a��I�i�a��a�Bfbfcfdfefp`�fI��f�bI��b�cI��c�dI��d�eI��e�pI��p�p��e�
�d��c��b`�L7��%��p�������h�i0������p���vvvvvj���`�    ^V�y��d�v8��8�; �5�4�5�4��   �1r� +��LH��a�H���a�֠� g��۠� ����� P����� C�࠹ g�h ~��堹 ���L�� ��� �&�'�(�)�p Y��e Y��d Y��c Y��b ^�L���L��J	����)em�)�(el�(�'ek�'�&ej�&f&f'f(f)fp�J��`�"�#��"�m��"�l��"�k��"�nEf�o�n	��j��"�i�a`�i�ea�0,i��a�L���o�f`�fI�0hhL��L~� ���i�� �o w��a��`�     ������ �o ��L� ���v �� 8�a�a ���a����j�b��k�c�
�l�d��m�e*�	�)�24�(�m&l&k&j��0�⨥m�e�m�l�d�l�k�c�k�j�b�j�LO��@��





�p(L���L7��&�b�'�c�(�d�)�eL׸�"�#��"�e��"�d��"�c��"�f	��b��"�a�p`�\,�W� ��I�J ��"�#��e�"��d�"��c�"��f	%b�"��a�"�p`�n�f��h�`����p` ���`�h����p`�a��p�� o���L8��a�	�f*����` +��b� �c���bI�*� �e�d�a�p�fLҸFf`�$�%� �$Ȫ�ı$Ef0��a�!�$	��b�ȱ$�c�ȱ$�d�ȩ�p�$�e�(�f�I�L1��a�J8�$f	����h M���a�� ���h`��f)�Fbb�b ���h`�aɠ�  ���p�f�fI�*���a�e�LҸ�b�c�d�e�`� �
�]����-��g��+� s �[�.�.�E�0 s �ɫ��-�
ɪ��+��f` s �\$`� 8�^LI�f_$_På^8�]�^�	 ���^��� ��^���g0`L��H$_�] �h8�0 ~�L
�H �h <��nEf�o�aLj��^�
�	�d$`0L~�

e^
� qz8�0�^L0��>���nk'��nk( �q�� ڽ�:�9�b�c��8 I� ߽L��� $f�-�� �f�qȩ0�a�L�� ����	���� (����]���� [������ [�� ��]�� ���]�� I� ����]i
0	��i���8��^�]���q�.ș� ���0ș� �q� ���ey��e�dy��d�cy��c�by��b��00ڊ�I�i
i/���ȄG�qȪ)�� �]��.ș� �q�G�I�)���$��<Ц�q�� ��0���.�ȩ+�^�.� 8�^��-��E� ��/8��
��i:���� ���� � � � �`�    �
  ������ ������  �����   
������
� K���s`  ����   <쪪���������������������������� ���� ���p�i�L���N�  Ի�n ̼�N�  [���� ���H 깩N�  (� ��hJ�
�a��fI��f`�8�;)q4X>Vt~�w/��z�*|cYX
~u��ƀ1r�    ���� (��piP� #�L �BUSSBUSSBUSMWIRE   ����           ����                                                                                                                                  	            
                                                  ����    CSCHSCHM  INPL   INPP  �C  �C   ADL %   INPP�˻C�nD   ADH M   OUTL   OUTP�X�D��C   D GATE   ROMX\��DQ��C��{�CBMBASIC0�A���������������p�'����Ѩ:�.�J�,�g�U�dᲳ#����V���]���)����z�A�9�̼X�}���q������d�k����|�e������ �,�7�yi�yR�{*�{�z�P�F�}��ZӮd�EN�FO�NEX�DAT�INPUT�INPU�DI�REA�LE�GOT�RU�I�RESTOR�GOSU�RETUR�RE�STO�O�WAI�LOA�SAV�VERIF�DE�POK�PRINT�PRIN�CON�LIS�CL�CM�SY�OPE�CLOS�GE�NE�TAB�T�F�SPC�THE�NO�STEЫ����AN�OҾ��SG�IN�AB�US�FR�PO�SQ�RN�LO�EX�CO�SI�TA�AT�PEE�LE�STR�VA�AS�CHR�LEFT�RIGHT�MID�G� TOO MANY FILE�FILE OPE�FILE NOT OPE�FILE NOT FOUN�DEVICE NOT PRESEN�NOT INPUT FIL�NOT OUTPUT FIL�MISSING FILE NAM�ILLEGAL DEVICE NUMBE�NEXT WITHOUT FO�SYNTA�RETURN WITHOUT GOSU�OUT OF DAT�ILLEGAL QUANTIT�OVERFLO�OUT OF MEMOR�UNDEF'D STATEMEN�BAD SUBSCRIP�REDIM'D ARRA�DIVISION BY ZER�ILLEGAL DIREC�TYPE MISMATC�STRING TOO LON�FILE DAT�FORMULA TOO COMPLE�CAN'T CONTINU�UNDEF'D FUNCTIO�VERIF�LOAĞ�����¡С�����%�5�;�O�Z�j�r����������Ȣբ��� ���$���OK   ERROR  IN  
READY.
 
BREAK ������Ɂ�!�J�
��I��J���I���i���` ��1�28�Z�_�"��[�`���#�Z8�"�Z��[8�X�"�X��Y��Z�X����Z�X�[�Y���`
i>�5�"��"�.`�4�(��3�"H�	�H�W�� &���h�a�0�h�h�4���3�`�l �
��&��"�'��# ��� � ת E�� �"H) G��h� z��i�� ��:�� ½�v�� ��� ��l `��z�{ s �����:� y�L� k� y�� ��D��_�#�-�"�`�%�_��_e-�-�$�.i��.�`�8�_�-����%e"��#�"�$����#�%��� Y� 3�� ���-�Ze�X�.�[�ȄY ���������1�2�-�.�����_�� Y� 3�L���+�,�"�#��"��ȱ"��Șe"�� �"�#i ȑ"�"�#��`�  ���� ��Y��L7�Lʪl�z��� ���>���� �7��"�V$p-�?����%�0��<��q� ���z��� 8�����ɀ�0�q�ș����68�:��I��8�UП�� �����ș����z�ȹ������д� ����{���z`�+�,��_�`�_��ȥ�_����	���_��
��_���_��`��� ��+ȑ+�+i�-�,i �. ��� �- ���7�8�3�4�-�.�/�0�1�2 ���h�h���H�H� �>�`�+i��z�,i��{`��ɫ�� k� � y �ɫЎ s  k�Іhh���������_�C ,� תȱ_�ȱ_�����,�I ͽ� �I) G��"��I�����_���_�ȱ_�_�`еL��l�����$0�8���I����ȹ���0�ȹ��0� G������ �� ����i��hh�	 �� ��ezH�{i H�:H�9H�� �� �� ���f	%b�b�����"�#LC����� �� y ɩ� s  �� +� 8��JH�IH��H ,��z�{����=�>� �z�C��z�LK�ȱz�9ȱz�:�ez�z��{l s  ��L���<逐�#�
���H��HLs L���:��L��K�� s �� ��L��8�+��,���A�B` ����<�z�{�:���=�>�9�:�;�<hh�����Li�L�����>�L7��=�z�{�;�<�9�:`�  ��(�LY� `�L��� ���{H�zH�:H�9H��H y  ��L�� k� 	�8�9��:���8ez�{���+�, ���_��z�`� �{`�����J ���ɍ��,�L7�L�hh�9h�:h�zh�{ ��ez�z��{`�:,� �� ������z�������"���� �� y ɉ��� ���a� 	�� y �L��L�� ��Hɍ�ɉБ�e�hL� s  k��,��h`� �����/���"��ԥ
&"
&"e��"e�&�e��� s Lq� ���I�J�� ���H�H ��h* ���h � ��� �d�Iȥe�I`Lлh�J���L ����=� �a�f�q � ��q�q � ���� ���q���� � ���d�c�eL���" � �LH��/L~���d�4����d�3��e�.���d�-��d�eLh�� �d u��P�Q�o�p z��a� �P�Q ۶� �P�IȱP�IȱP�I` ��L�� ����, ��� �(L�� !� y �5�Cɣ�Pɦ�K�,�7�;�^ ��$0� ݽ �� !� ;��ө � ������ G�$�
 G�I�`8 ���8�
��I�i�8 ���	 ���)�Y(���	����� s L�� ;��� �� ���� ���" G����� �L(���� ,�,�? �)�`��0����?�@�9�:L����L7���� ��=�>�z�{` ���#� s  ���, ��� ��� ��@ ���` ���, ��� � Ϋ� ��� �`�"� ���; �� !� ���,�� ���� ��)� ��L��� ���� �L���� E� ;�L`��A�B��,� ��C�D ���I�J�z�{�K�L�C�D�z�{ y � $P $� ����0u�� E� ���z�{ s $1$P	�z� ����"��:��,��z�{i �� �� � کL�� � © y ��,�LM��z�{�C�D�K�L�z�{ y �- ��L� �Ȫ��ȱz�lȱz�?ȱzȅ@ �� y �����LQ��C�D�L'�� �C�������L�`?EXTRA IGNORED ?REDO FROM START �� � ���I�J ����
L7���iHi�$h� ����	�f�I�J g� л� ]��8�	���9��:��z��{L���i�� y �,�� s  $� ��$8$0�`���L7��z��{�z� $H�H� �� ��� �M y 8鱐���*IEM�M�a�M s L���M�,�{i�we�L=�i��"
e"�hـ��g ��H  �h�K��V�_F�*�z��{�z��M��ـ��H�ٹ��H���H 3��ML��L��f����h�"�"h�#�H ��eH�dH�cH�bH�aHl" ��h�#�d� ���KhJ�h�ih�jh�kh�lh�mh�nEf�o�a`l
� � s �L� ��L(�������� ��Ls �Iڡ�.��ɫ�Xɪ���"��z�{i �� ��L�ɨ���; ���eI���dI�L��ɥ�L��ɴ�L�� �� ���),�(,�,� �z�Ls �L7��hhL��8�d� �e預���d���e` ���d�e�E�F��&� �p ���T���� ���^��q��]�$ h�Lo�`$� �d�ȱd��L�� ��-�T��I�% �����LO� ���d�c�e� �b`�S�
�T� ��L<��d�eL��
H� s ���  �� �� �� ��h��eH�dH�H ��h��HL֯ �h��ꟅU�럅V T L����,� � ���dE��eE� �� ���eE%E��dE%EL�� ����n	%j�j�i�  [��La�� ��M ���a�b�c�l�m ���l�m�8�a����a���f�������f0��l�b������*%���L<� ��� �� y ��`�  y ��E y  ��L�� �� s � ��� s �� ����$������%���Щ��E�E�	�� s �F8�(�Lѱ� ��-�.�`�_�0��/�"�E�_��F��_�}��_i������A��[8�`hH�*����`�E�F�T������I�L��S��T���/�0�_�`�1�2�Z�[i�ȅX�Y ���X�Yȅ/�0� �E�_ȥF�_� ȑ_ȑ_ȑ_ȑ_ȑ_�_i�`�ȅG�H`�
ie_�`�ȅX�Y`��    ���d�e` s  �� ���f0�aɐ�	���� [��zL���H�H� �H�FH�EH ��h�Eh�Fh���H�H�d��e�� y �,�҄ ��h�h�)��/�0�_�`�2��1�9� �_��E��F�_�ȱ_e_�ȱ_e`�ע,�L7����� �����_��L� �� �� �r��E�_�ȥF�_�ʆq���ȑ_�� $Phi�hi ȑ_Ȋ�_ L��q�r�"���eY�]�Y��eX���R ��1�2� �r�q���X���Y�r���Y8�1�_��_�2��`�_��bȱ_�� �q�r�h��dh�e�_��Ȋ�_�LE�L5�ȥrq�
 L��ed���"ee�q��ʅr��EʥF�ʆ(�  U��eX�G�eY�H��G`�"�_�(��_�)��]� � �
��*���q&r��e(��e)����]��`�� �� &�8�3�1��4�2� ��b�c��LD�8 ��� ��:�Р�,�L7� � �� ����� �� �� ���� ��H�HH�GH�{H�zH ��LO��� ��	�� ���N�OL�� ᳥OH�NH � ��h�Nh�O��N�G�ȱN�HȱGH���H Ի�{H�zH�N�zȱN�{�HH�GH ��h�Nh�O y �L�h�zh�{� h�NhȑNhȑNhȑNhȑN` ���  ߽hh��� ��d�e�P�Q ���b�c�a`�"���o�p�b�c��ȱo�������"��a�eo�q�p��r�p���� u��o�p ����"��L7��a� �b��c�� �d�e�p������`FHI�8e3�4���2���1��3�4�5�6�h`��0� &����h�Ц7�8�3�4� �O�N�1�2�_�`�� �"�#�� ǵ����S�-�.�"�#�0��/� ����X�Y��S�X�Y�2��1�L��"�#� �"�ȱ"ȱ"eX�Xȱ"eY�Y(ӊ0�ȱ"� 
ie"�"��#�#�Y��X� ǵ��"05ȱ"0ȱ"�+ȱ"�ȱ"�4���3��`���_��_�`�"�#�N�O�S�U�Se"�"��#�#� `�ON���U)J��U�Ne_�Z�`i �[�3�4�X�Y ���UȥX�N��Y�YȑNL*��eH�dH �� ��h�oh�p� �oqd��L7� u� z��P�Q �� ���o�p �� ʴL��� �oHȱo�ȱo�h�"�#��
H��"�5���he5�5��6` ���d�e�"�# ۶� �"Hȱ"�ȱ"�h(��4��3�He3�3��4h�"�#`�������� ` ���H� }�h� �bhhLʴ a��P���P��H�H }��P�Q ��h�he"�"��#� ��Lʴ a��PI�L����e y �)� �� �� a��KʊH� �P��I��e���e�� ��h�h�Uhhh�h�Ph�Q�UH�H� �` ��L�� ��� ��` ���� �"�L��LH� s  �� ���d��eLy  ���L���z�{�q�r�"�ze"�$�#�{��%� �$H��$ y  �h� �$�q�r�z�{` �� �� ��L���f0��aɑ�� ���d�e��`�H�H ��� ��h�h�L�� 뷊� �` 뷆I�  y � �J� �EJ%I��`���Lg� ���fI��fEn�o�aLj� ���< ���L���p�V�i�i���8�a�$��a�n�fI�i � �V�a�� �p��0Ǩ�pV ��$oW�a�i��i8I�eV�p� ��e� ��d� ��c� ��b� G�� ��b�J�c�b�d�c�e�d�p�e�pi� �� �a�f`eV�p�eem�e�del�d�cek�c�bej�bL6�ip&e&d&c&b�8�a��I�i�a��a�Bfbfcfdfefp`�fI��f�bI��b�cI��c�dI��d�eI��e�pI��p�p��e�
�d��c��b`�L7��%��p�������h�i0������p���vvvvvj���`�    ^V�y��d�v8��8�; �5�4�5�4��   �1r� +��LH��a�H���a�֠� g��۠� ����� P����� C�࠹ g�h ~��堹 ���L�� ��� �&�'�(�)�p Y��e Y��d Y��c Y��b ^�L���L��J	����)em�)�(el�(�'ek�'�&ej�&f&f'f(f)fp�J��`�"�#��"�m��"�l��"�k��"�nEf�o�n	��j��"�i�a`�i�ea�0,i��a�L���o�f`�fI�0hhL��L~� ���i�� �o w��a��`�     ������ �o ��L� ���v �� 8�a�a ���a����j�b��k�c�
�l�d��m�e*�	�)�24�(�m&l&k&j��0�⨥m�e�m�l�d�l�k�c�k�j�b�j�LO��@��





�p(L���L7��&�b�'�c�(�d�)�eL׸�"�#��"�e��"�d��"�c��"�f	��b��"�a�p`�\,�W� ��I�J ��"�#��e�"��d�"��c�"��f	%b�"��a�"�p`�n�f��h�`����p` ���`�h����p`�a��p�� o���L8��a�	�f*����` +��b� �c���bI�*� �e�d�a�p�fLҸFf`�$�%� �$Ȫ�ı$Ef0��a�!�$	��b�ȱ$�c�ȱ$�d�ȩ�p�$�e�(�f�I�L1��a�J8�$f	����h M���a�� ���h`��f)�Fbb�b ���h`�aɠ�  ���p�f�fI�*���a�e�LҸ�b�c�d�e�`� �
�]����-��g��+� s �[�.�.�E�0 s �ɫ��-�
ɪ��+��f` s �\$`� 8�^LI�f_$_På^8�]�^�	 ���^��� ��^���g0`L��H$_�] �h8�0 ~�L
�H �h <��nEf�o�aLj��^�
�	�d$`0L~�

e^
� qz8�0�^L0��>���nk'��nk( �q�� ڽ�:�9�b�c��8 I� ߽L��� $f�-�� �f�qȩ0�a�L�� ����	���� (����]���� [������ [�� ��]�� ���]�� I� ����]i
0	��i���8��^�]���q�.ș� ���0ș� �q� ���ey��e�dy��d�cy��c�by��b��00ڊ�I�i
i/���ȄG�qȪ)�� �]��.ș� �q�G�I�)���$��<Ц�q�� ��0���.�ȩ+�^�.� 8�^��-��E� ��/8��
��i:���� ���� � � � �`�    �
  ������ ������  �����   
������
� K���s`  ����   <쪪���������������������������� ���� ���p�i�L���N�  Ի�n ̼�N�  [���� ���H 깩N�  (� ��hJ�
�a��fI��f`�8�;)q4X>Vt~�w/��z�*|cYX
~u��ƀ1r�    ���� (��piP� #�L �BUSS   D  4C BUSS   D  �C BUSM  RD  4C WIRE                        D  �C  D  �C                    D  %D  D  %D                   9D  HC  CD  HC                 9D  pC  CD  pC                 9D  �C  CD  �C                 9D  �C  CD  �C                 9D  �C  CD  �C                 9D  �C  CD  �C                 9D  �C  CD  �C                 9D  �C  CD  �C                  9D  D  CD  D         	        9D  D  CD  D         
        9D  D  CD  D                 9D   D  CD   D                 9D  *D  CD  *D                    kD  �C  uD  �C                     �D  �C  �D  �CTEST    WIRE3                       �C  pB  �C  pB                   �C  �B  �C  �B  �C  �B                    �C  pC  �C  pC                   *D  HC  CD  HC                 *D  pC  CD  pC                   zD  HC  D  HC  D  pB  �D  pB                 zD  pC  zD  pC  �D  pC  �D  �B  �D  �B                   zD  HC  zD  HC  D  HC  D  �C  �D  �C                 zD  pC  zD  pC  zD  pC  �D  pC  �D  �C  �D  �C                  *D  �C  *D  �C ��D  �C ��D  D  �D  D                   zD  HC  zD  HC  zD  HC  D  HC  D  9D  �D  9D       
           ��D  pB  �D  pB                  �D  �C ��D  �C  �D  �C  �D  �C                  ��D  �C  �D  �C                  ��D  9D  �D  9D                  �D  9D ��D  9D  �D  4D  �D  �C       	           ��D  p�  �D  p�                   zD  HC  D  HC  D   �  �D  p�  �D  p�                 zD  pC  �D  pC  �D     ��D  ��  �D  ��                  ��D  �C  �D  �C                   zD  HC  zD  HC  zD  HC  D  HC  D  �C  �D  �C                 zD  pC  zD  pC  zD  pC  zD  pC  �D  pC  �D  �C  �D  �C	                   �D  p� ��D  p�  �D   �  �D  �C
                  �D  pB  �D  pB ��D  �B ��D  �C  �D  �C                  �D  �C ��D  �C ��D  uD  �D  zD  �C  zD  �C  uD  �C  �C  �C  �C                 zD  �C  �D  �C ��D  �C ��D   D  �D  %D  �D  %D                 zD  �C  zD  �C  �D  �C ��D  �C ��D  *D  �D  /D  �D  /D ��D  *D ��D  �C  �D  �C ��D  �C            	     zD  �C ��D  �C ��D  �C  �D  �C ��D  �C  �D  �C  �D  �C ��D  �C ��D  �C      	      
     zD  �C ��D  �C  �D  �C  �D   B ��D  �A ��D  �A  �D      �D  �� ��D  �� ��D  ��                 zD  �C ��D  �C  �D  �C  �D  �C  �D  �C      
           zD  �C ��D  �C  �D  �C  �D  �C ��D  �C ��D  �A  �D     ��D                      *D  �C  *D  �C  *D  �C  *D  �C ��D  �C ��D  \D  �D  aD                  *D  �C  *D  �C ��D  �C ��D  pC  �D  \C                  �D  �C ��D  �C  �D  �C  �D  �C ��D  �C  �D  �C                   �C  �C  �C  �C  �C  �C  �C  �C                 *D  �C  4D  �C  9D  �C  9D  �C  CD  �C                 zD  �C  zD  fD  D  kD  �D  kD                 zD  �C  zD  pD  D  uD ��D  uD ��D  4D ��D  *D ��D  *D            	     zD  pC  zD  pC  zD  pC  zD  pC  zD  pC  �D  pC  �D  >D ��D  CD  �D  CD                   *D  pB  /D  �B  /D  �B  *D  C  �C  C  �C   C  �C  4C  �C  HC                    *D  pB  /D  �B  /D  �C  *D  �C                 *D  �C  4D  �C  4D   C  9D  C  �D  C                 *D  �C  4D  �C  4D   C  9D  C  �D  C  �D  D  �D  D                 *D  �C  4D  �C  4D   C  9D  C  �D  C  �D  MD  �D  MD                 *D  �C  4D  �C  9D  �C  9D  4C  >D   C ��D   C  �D  4C                 *D  �C  4D  �C  9D  �C  9D  4C  >D   C ��D   C ��D  D  �D  D            	     *D  �C  4D  �C  9D  �C  9D  4C  >D   C ��D   C ��D  RD  �D  WD  �D  WD                 ��D  aD ��D  �D  �D ��D  �D ��D                 ��D  WD  �D  \D  �D  �D ��D ��D  �D ��D                  ��D  MD  �D  MD ��D  RD ��D ��D  �D ��D                 ��D  CD ��D  CD  �D  HD  �D  �D ��D ��D  �D ��DTEST�  print("Booting into BASIC (16x mult)");
local startTime = time();

set("mult", 16);
set("reset", 1);
simulate();
set("reset", 0);
for i=0,7756 do
  tick("clk");
end

local endTime = time();
print("Completed in ", 1000.0 * (endTime - startTime), "ms");

print("Booting into BASIC (255x mult)");
local startTime = time();

set("mult", 255);
set("reset", 1);
simulate();
set("reset", 0);
for i=0,474 do
  tick("clk");
end

local endTime = time();
print("Completed in ", 1000.0 * (endTime - startTime), "ms");
