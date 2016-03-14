bit32 = bit;
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
