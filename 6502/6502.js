var ENABLE_LOGGING = false;

// Addressing modes
var ADDR_IMPLIED = 0;
var ADDR_ACCUMULATOR = 1;
var ADDR_IMMEDIATE = 2;
var ADDR_ZERO_PAGE = 3;
var ADDR_ZERO_PAGE_X = 4;
var ADDR_ZERO_PAGE_Y = 5;
var ADDR_RELATIVE = 6;
var ADDR_ABSOLUTE = 7;
var ADDR_ABSOLUTE_X = 8;
var ADDR_ABSOLUTE_Y = 9;
var ADDR_INDIRECT = 10;
var ADDR_INDIRECT_X = 11;
var ADDR_INDIRECT_Y = 12;

// Status flags
var F_CARRY = 0;
var F_ZERO = 1;
var F_IRQ_DISABLE = 2;
var F_DECIMAL = 3;
var F_BREAK = 4;
var F_OVERFLOW = 6;
var F_NEGATIVE = 7;

// Instructions
var I_INVALID = 0;
var I_ADC = 1;
var I_AND = 2;
var I_ASL = 3;
var I_BCC = 4;
var I_BCS = 5;
var I_BEQ = 6;
var I_BIT = 7;
var I_BMI = 8;
var I_BNE = 9;
var I_BPL = 10;
var I_BRK = 11;
var I_BVC = 12;
var I_BVS = 13;
var I_CLC = 14;
var I_CLD = 15;
var I_CLI = 16;
var I_CLV = 17;
var I_CMP = 18;
var I_CPX = 19;
var I_CPY = 20;
var I_DEC = 21;
var I_DEX = 22;
var I_DEY = 23;
var I_EOR = 24;
var I_INC = 25;
var I_INX = 26;
var I_INY = 27;
var I_JMP = 28;
var I_JSR = 29;
var I_LDA = 30;
var I_LDX = 31;
var I_LDY = 32;
var I_LSR = 33;
var I_NOP = 34;
var I_ORA = 35;
var I_PHA = 36;
var I_PHP = 37;
var I_PLA = 38;
var I_PLP = 39;
var I_ROL = 40;
var I_ROR = 41;
var I_RTI = 42;
var I_RTS = 43;
var I_SBC = 44;
var I_SEC = 45;
var I_SED = 46;
var I_SEI = 47;
var I_STA = 48;
var I_STX = 49;
var I_STY = 50;
var I_TAX = 51;
var I_TAY = 52;
var I_TYA = 53;
var I_TSX = 54;
var I_TXA = 55;
var I_TXS = 56;

// CPU state
var S_RESET = 0;
var S_RUNNING = 1;

var InstrInfo = [
  { mnemonic: I_BRK, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_ORA, numBytes: 2, addrMode: ADDR_INDIRECT_X },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_ORA, numBytes: 2, addrMode: ADDR_ZERO_PAGE },
  { mnemonic: I_ASL, numBytes: 2, addrMode: ADDR_ZERO_PAGE },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_PHP, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_ORA, numBytes: 2, addrMode: ADDR_IMMEDIATE },
  { mnemonic: I_ASL, numBytes: 1, addrMode: ADDR_ACCUMULATOR },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_ORA, numBytes: 3, addrMode: ADDR_ABSOLUTE },
  { mnemonic: I_ASL, numBytes: 3, addrMode: ADDR_ABSOLUTE },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_BPL, numBytes: 2, addrMode: ADDR_RELATIVE },
  { mnemonic: I_ORA, numBytes: 2, addrMode: ADDR_INDIRECT_Y },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_ORA, numBytes: 2, addrMode: ADDR_ZERO_PAGE_X },
  { mnemonic: I_ASL, numBytes: 2, addrMode: ADDR_ZERO_PAGE_X },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_CLC, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_ORA, numBytes: 3, addrMode: ADDR_ABSOLUTE_Y },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_ORA, numBytes: 3, addrMode: ADDR_ABSOLUTE_X },
  { mnemonic: I_ASL, numBytes: 3, addrMode: ADDR_ABSOLUTE_X },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_JSR, numBytes: 3, addrMode: ADDR_ABSOLUTE },
  { mnemonic: I_AND, numBytes: 2, addrMode: ADDR_INDIRECT_X },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_BIT, numBytes: 2, addrMode: ADDR_ZERO_PAGE },
  { mnemonic: I_AND, numBytes: 2, addrMode: ADDR_ZERO_PAGE },
  { mnemonic: I_ROL, numBytes: 2, addrMode: ADDR_ZERO_PAGE },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_PLP, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_AND, numBytes: 2, addrMode: ADDR_IMMEDIATE },
  { mnemonic: I_ROL, numBytes: 1, addrMode: ADDR_ACCUMULATOR },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_BIT, numBytes: 3, addrMode: ADDR_ABSOLUTE },
  { mnemonic: I_AND, numBytes: 3, addrMode: ADDR_ABSOLUTE },
  { mnemonic: I_ROL, numBytes: 3, addrMode: ADDR_ABSOLUTE },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_BMI, numBytes: 2, addrMode: ADDR_RELATIVE },
  { mnemonic: I_AND, numBytes: 2, addrMode: ADDR_INDIRECT_Y },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_AND, numBytes: 2, addrMode: ADDR_ZERO_PAGE_X },
  { mnemonic: I_ROL, numBytes: 2, addrMode: ADDR_ZERO_PAGE_X },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_SEC, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_AND, numBytes: 3, addrMode: ADDR_ABSOLUTE_Y },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_AND, numBytes: 3, addrMode: ADDR_ABSOLUTE_X },
  { mnemonic: I_ROL, numBytes: 3, addrMode: ADDR_ABSOLUTE_X },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_RTI, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_EOR, numBytes: 2, addrMode: ADDR_INDIRECT_X },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_EOR, numBytes: 2, addrMode: ADDR_ZERO_PAGE },
  { mnemonic: I_LSR, numBytes: 2, addrMode: ADDR_ZERO_PAGE },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_PHA, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_EOR, numBytes: 2, addrMode: ADDR_IMMEDIATE },
  { mnemonic: I_LSR, numBytes: 1, addrMode: ADDR_ACCUMULATOR },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_JMP, numBytes: 3, addrMode: ADDR_ABSOLUTE },
  { mnemonic: I_EOR, numBytes: 3, addrMode: ADDR_ABSOLUTE },
  { mnemonic: I_LSR, numBytes: 3, addrMode: ADDR_ABSOLUTE },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_BVC, numBytes: 2, addrMode: ADDR_RELATIVE },
  { mnemonic: I_EOR, numBytes: 2, addrMode: ADDR_INDIRECT_Y },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_EOR, numBytes: 2, addrMode: ADDR_ZERO_PAGE_X },
  { mnemonic: I_LSR, numBytes: 2, addrMode: ADDR_ZERO_PAGE_X },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_CLI, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_EOR, numBytes: 3, addrMode: ADDR_ABSOLUTE_Y },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_EOR, numBytes: 3, addrMode: ADDR_ABSOLUTE_X },
  { mnemonic: I_LSR, numBytes: 3, addrMode: ADDR_ABSOLUTE_X },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_RTS, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_ADC, numBytes: 2, addrMode: ADDR_INDIRECT_X },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_ADC, numBytes: 2, addrMode: ADDR_ZERO_PAGE },
  { mnemonic: I_ROR, numBytes: 2, addrMode: ADDR_ZERO_PAGE },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_PLA, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_ADC, numBytes: 2, addrMode: ADDR_IMMEDIATE },
  { mnemonic: I_ROR, numBytes: 1, addrMode: ADDR_ACCUMULATOR },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_JMP, numBytes: 3, addrMode: ADDR_INDIRECT },
  { mnemonic: I_ADC, numBytes: 3, addrMode: ADDR_ABSOLUTE },
  { mnemonic: I_ROR, numBytes: 3, addrMode: ADDR_ABSOLUTE },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_BVS, numBytes: 2, addrMode: ADDR_RELATIVE },
  { mnemonic: I_ADC, numBytes: 2, addrMode: ADDR_INDIRECT_Y },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_ADC, numBytes: 2, addrMode: ADDR_ZERO_PAGE_X },
  { mnemonic: I_ROR, numBytes: 2, addrMode: ADDR_ZERO_PAGE_X },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_SEI, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_ADC, numBytes: 3, addrMode: ADDR_ABSOLUTE_Y },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_ADC, numBytes: 3, addrMode: ADDR_ABSOLUTE_X },
  { mnemonic: I_ROR, numBytes: 3, addrMode: ADDR_ABSOLUTE_X },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_STA, numBytes: 2, addrMode: ADDR_INDIRECT_X },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_STY, numBytes: 2, addrMode: ADDR_ZERO_PAGE },
  { mnemonic: I_STA, numBytes: 2, addrMode: ADDR_ZERO_PAGE },
  { mnemonic: I_STX, numBytes: 2, addrMode: ADDR_ZERO_PAGE },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_DEY, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_TXA, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_STY, numBytes: 3, addrMode: ADDR_ABSOLUTE },
  { mnemonic: I_STA, numBytes: 3, addrMode: ADDR_ABSOLUTE },
  { mnemonic: I_STX, numBytes: 3, addrMode: ADDR_ABSOLUTE },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_BCC, numBytes: 2, addrMode: ADDR_RELATIVE },
  { mnemonic: I_STA, numBytes: 2, addrMode: ADDR_INDIRECT_Y },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_STY, numBytes: 2, addrMode: ADDR_ZERO_PAGE_X },
  { mnemonic: I_STA, numBytes: 2, addrMode: ADDR_ZERO_PAGE_X },
  { mnemonic: I_STX, numBytes: 2, addrMode: ADDR_ZERO_PAGE_Y },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_TYA, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_STA, numBytes: 3, addrMode: ADDR_ABSOLUTE_Y },
  { mnemonic: I_TXS, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_STA, numBytes: 3, addrMode: ADDR_ABSOLUTE_X },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_LDY, numBytes: 2, addrMode: ADDR_IMMEDIATE },
  { mnemonic: I_LDA, numBytes: 2, addrMode: ADDR_INDIRECT_X },
  { mnemonic: I_LDX, numBytes: 2, addrMode: ADDR_IMMEDIATE },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_LDY, numBytes: 2, addrMode: ADDR_ZERO_PAGE },
  { mnemonic: I_LDA, numBytes: 2, addrMode: ADDR_ZERO_PAGE },
  { mnemonic: I_LDX, numBytes: 2, addrMode: ADDR_ZERO_PAGE },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_TAY, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_LDA, numBytes: 2, addrMode: ADDR_IMMEDIATE },
  { mnemonic: I_TAX, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_LDY, numBytes: 3, addrMode: ADDR_ABSOLUTE },
  { mnemonic: I_LDA, numBytes: 3, addrMode: ADDR_ABSOLUTE },
  { mnemonic: I_LDX, numBytes: 3, addrMode: ADDR_ABSOLUTE },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_BCS, numBytes: 2, addrMode: ADDR_RELATIVE },
  { mnemonic: I_LDA, numBytes: 2, addrMode: ADDR_INDIRECT_Y },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_LDY, numBytes: 2, addrMode: ADDR_ZERO_PAGE_X },
  { mnemonic: I_LDA, numBytes: 2, addrMode: ADDR_ZERO_PAGE_X },
  { mnemonic: I_LDX, numBytes: 2, addrMode: ADDR_ZERO_PAGE_Y },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_CLV, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_LDA, numBytes: 3, addrMode: ADDR_ABSOLUTE_Y },
  { mnemonic: I_TSX, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_LDY, numBytes: 3, addrMode: ADDR_ABSOLUTE_X },
  { mnemonic: I_LDA, numBytes: 3, addrMode: ADDR_ABSOLUTE_X },
  { mnemonic: I_LDX, numBytes: 3, addrMode: ADDR_ABSOLUTE_Y },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_CPY, numBytes: 2, addrMode: ADDR_IMMEDIATE },
  { mnemonic: I_CMP, numBytes: 2, addrMode: ADDR_INDIRECT_X },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_CPY, numBytes: 2, addrMode: ADDR_ZERO_PAGE },
  { mnemonic: I_CMP, numBytes: 2, addrMode: ADDR_ZERO_PAGE },
  { mnemonic: I_DEC, numBytes: 2, addrMode: ADDR_ZERO_PAGE },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_INY, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_CMP, numBytes: 2, addrMode: ADDR_IMMEDIATE },
  { mnemonic: I_DEX, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_CPY, numBytes: 3, addrMode: ADDR_ABSOLUTE },
  { mnemonic: I_CMP, numBytes: 3, addrMode: ADDR_ABSOLUTE },
  { mnemonic: I_DEC, numBytes: 3, addrMode: ADDR_ABSOLUTE },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_BNE, numBytes: 2, addrMode: ADDR_RELATIVE },
  { mnemonic: I_CMP, numBytes: 2, addrMode: ADDR_INDIRECT_Y },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_CMP, numBytes: 2, addrMode: ADDR_ZERO_PAGE_X },
  { mnemonic: I_DEC, numBytes: 2, addrMode: ADDR_ZERO_PAGE_X },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_CLD, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_CMP, numBytes: 3, addrMode: ADDR_ABSOLUTE_Y },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_CMP, numBytes: 3, addrMode: ADDR_ABSOLUTE_X },
  { mnemonic: I_DEC, numBytes: 3, addrMode: ADDR_ABSOLUTE_X },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_CPX, numBytes: 2, addrMode: ADDR_IMMEDIATE },
  { mnemonic: I_SBC, numBytes: 2, addrMode: ADDR_INDIRECT_X },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_CPX, numBytes: 2, addrMode: ADDR_ZERO_PAGE },
  { mnemonic: I_SBC, numBytes: 2, addrMode: ADDR_ZERO_PAGE },
  { mnemonic: I_INC, numBytes: 2, addrMode: ADDR_ZERO_PAGE },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_INX, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_SBC, numBytes: 2, addrMode: ADDR_IMMEDIATE },
  { mnemonic: I_NOP, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_CPX, numBytes: 3, addrMode: ADDR_ABSOLUTE },
  { mnemonic: I_SBC, numBytes: 3, addrMode: ADDR_ABSOLUTE },
  { mnemonic: I_INC, numBytes: 3, addrMode: ADDR_ABSOLUTE },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_BEQ, numBytes: 2, addrMode: ADDR_RELATIVE },
  { mnemonic: I_SBC, numBytes: 2, addrMode: ADDR_INDIRECT_Y },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_SBC, numBytes: 2, addrMode: ADDR_ZERO_PAGE_X },
  { mnemonic: I_INC, numBytes: 2, addrMode: ADDR_ZERO_PAGE_X },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_SED, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_SBC, numBytes: 3, addrMode: ADDR_ABSOLUTE_Y },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
  { mnemonic: I_SBC, numBytes: 3, addrMode: ADDR_ABSOLUTE_X },
  { mnemonic: I_INC, numBytes: 3, addrMode: ADDR_ABSOLUTE_X },
  { mnemonic: I_INVALID, numBytes: 1, addrMode: ADDR_IMPLIED },
];

function init(component) 
{
  // Clock
  component.addInput("clk", 1);
  
  // Reset
  component.addInput("reset", 1);
  
  // Data input (from memory to the processor)
  component.addInput("Di", 8);
  
  // Address bus
  component.addOutput("ADL", 8);
  component.addOutput("ADH", 8);
  
  // Data output (from the processor to memory)
  component.addOutput("Do", 8);
  
  // R/W line. When HIGH, the processor executes a READ operation, otherwise it's going to write data to memory.
  component.addOutput("re", 1); // re = ReadEnable

  this.CPU = new CPU();  
}

function simulate(inputs) 
{
  var clk = inputs[0];
  var reset = inputs[1];
  var dataIn = inputs[2];

  var res = [ 
    UNDEFINED_VALUE, // ADL
    UNDEFINED_VALUE, // ADH
    UNDEFINED_VALUE, // Do
    UNDEFINED_VALUE  // re
  ];
  
  if(clk === ERROR_VALUE || reset === ERROR_VALUE) {
    res[0] = ERROR_VALUE;
    res[1] = ERROR_VALUE;
    res[2] = ERROR_VALUE;
    res[3] = ERROR_VALUE;
  } else if(clk != UNDEFINED_VALUE && reset != UNDEFINED_VALUE) {
      this.CPU.tick(clk, reset, dataIn);
      
      res[0] = this.CPU.addressBus & 0x000000FF;
      res[1] = (this.CPU.addressBus >>> 8) & 0x000000FF;
      res[2] = this.CPU.dataOut;
      res[3] = this.CPU.readEnable;
  }

  return [
      { t: 1, outputs: res }
  ];
}

function CPU()
{
  this.addressBus = UNDEFINED_VALUE;
  this.dataOut = UNDEFINED_VALUE;
  this.readEnable = UNDEFINED_VALUE;
  this.registers = {
    A: UNDEFINED_VALUE,
    X: UNDEFINED_VALUE,
    Y: UNDEFINED_VALUE,
    SP: UNDEFINED_VALUE,
    PC: UNDEFINED_VALUE,
    status: UNDEFINED_VALUE,
    
    // Internal
    ADL: UNDEFINED_VALUE,
    ADH: UNDEFINED_VALUE,
    BAL: UNDEFINED_VALUE,
    BAH: UNDEFINED_VALUE,
    IAL: UNDEFINED_VALUE,
    IAH: UNDEFINED_VALUE,
    RMWData: UNDEFINED_VALUE,
    branchOffset: UNDEFINED_VALUE
  };

  this.instrTime = 0;
  this.instruction = null;
  this.prevClockLevel = UNDEFINED_VALUE;
  this.PCDelta = 0;
  this.status = S_RUNNING;
  this.instrOffset = 0;
};

CPU.prototype.tick = function (clk, reset, dataIn) 
{
  if(reset === 1) {
    this.registers.A = 0;
    this.registers.X = 0;
    this.registers.Y = 0;
    this.registers.SP = 0;
    this.registers.PC = 0xFFFC; // Read the reset vector.
    this.registers.status = 0;
    this.registers.ADL = 0;
    this.registers.ADH = 0;
    this.registers.BAL = 0;
    this.registers.BAH = 0;
    this.registers.IAL = 0;
    this.registers.IAH = 0;
    this.registers.RMWData = 0;
    this.registers.branchOffset = 0;
    this.instruction = null;
    this.prevClockLevel = UNDEFINED_VALUE;

    this.stepInstruction(1, 0, 1, this.registers.PC);
    this.status = S_RESET;
  } else {
    if(this.prevClockLevel === 0 && clk === 1) {
      // Rising edge of the clock. 
      if(this.status === S_RUNNING) {
        if(this.instrTime === 0) {
          // Opcode
          this.instruction = InstrInfo[dataIn];
          this.stepInstruction(1, 1, 1, this.registers.PC + 1);
        } else {
          // We already have the opcode. Execute the instruction
          var mnemonic = this.instruction.mnemonic;
          switch(mnemonic) {
            case I_ADC:
              this.execInternalOnMemoryData(this.instruction.addrMode, dataIn, this.ADC, "ADC");
              break;
            case I_AND:
              this.execInternalOnMemoryData(this.instruction.addrMode, dataIn, this.AND, "AND");
              break;
            case I_ASL:
              if(this.instruction.addrMode === ADDR_ACCUMULATOR) {
                this.execSingleByteInstruction(function () {
                  this.registers.A = this.ASL(this.registers.A);
                }, "ASL A");
              } else {
                this.execRMWOp(this.instruction.addrMode, dataIn, this.ASL, "ASL");
              }
              break;
            case I_BCC:
              this.execBranch(dataIn, !this.getStatusBit(F_CARRY), "BCC");
              break;
            case I_BCS:
              this.execBranch(dataIn, this.getStatusBit(F_CARRY), "BCS");
              break;
            case I_BEQ:
              this.execBranch(dataIn, this.getStatusBit(F_ZERO), "BEQ");
              break;
            case I_BIT:
              this.execInternalOnMemoryData(this.instruction.addrMode, dataIn, this.BIT, "BIT");
              break;
            case I_BMI:
              this.execBranch(dataIn, this.getStatusBit(F_NEGATIVE), "BMI");
              break;
            case I_BNE:
              this.execBranch(dataIn, !this.getStatusBit(F_ZERO), "BNE");
              break;
            case I_BPL:
              this.execBranch(dataIn, !this.getStatusBit(F_NEGATIVE), "BPL");
              break;
            case I_BRK:
              // TODO: 
              break;
            case I_BVC:
              this.execBranch(dataIn, !this.getStatusBit(F_OVERFLOW), "BVC");
              break;
            case I_BVS:
              this.execBranch(dataIn, this.getStatusBit(F_OVERFLOW), "BVS");
              break;
            case I_CLC:
              this.execSingleByteInstruction(this.CLC, "CLC");
              break;
            case I_CLD:
              this.execSingleByteInstruction(this.CLD, "CLD");
              break;
            case I_CLI:
              this.execSingleByteInstruction(this.CLI, "CLI");
              break;
            case I_CLV:
              this.execSingleByteInstruction(this.CLV, "CLV");
              break;
            case I_CMP:
              this.execInternalOnMemoryData(this.instruction.addrMode, dataIn, this.CMP, "CMP");
              break;
            case I_CPX:
              this.execInternalOnMemoryData(this.instruction.addrMode, dataIn, this.CPX, "CPX");
              break;
            case I_CPY:
              this.execInternalOnMemoryData(this.instruction.addrMode, dataIn, this.CPY, "CPY");
              break;
            case I_DEC:
              this.execRMWOp(this.instruction.addrMode, dataIn, this.DEC, "DEC");
              break;
            case I_DEX:
              this.execSingleByteInstruction(this.DEX, "DEX");
              break;
            case I_DEY:
              this.execSingleByteInstruction(this.DEY, "DEY");
              break;
            case I_EOR:
              this.execInternalOnMemoryData(this.instruction.addrMode, dataIn, this.EOR, "EOR");
              break;
            case I_INC:
              this.execRMWOp(this.instruction.addrMode, dataIn, this.INC, "INC");
              break;
            case I_INX:
              this.execSingleByteInstruction(this.INX, "INX");
              break;
            case I_INY:
              this.execSingleByteInstruction(this.INY, "INY");
              break;
            case I_JMP:
              this.execJMP(this.instruction.addrMode, dataIn);
              break;
            case I_JSR:
              this.execJSR(dataIn);
              break;
            case I_LDA:
              this.execInternalOnMemoryData(this.instruction.addrMode, dataIn, this.LDA, "LDA");
              break;
            case I_LDX:
              this.execInternalOnMemoryData(this.instruction.addrMode, dataIn, this.LDX, "LDX");
              break;
            case I_LDY:
              this.execInternalOnMemoryData(this.instruction.addrMode, dataIn, this.LDY, "LDY");
              break;
            case I_LSR:
              if(this.instruction.addrMode === ADDR_ACCUMULATOR) {
                this.execSingleByteInstruction(function () {
                  this.registers.A = this.LSR(this.registers.A);
                }, "LSR A");
              } else {
                this.execRMWOp(this.instruction.addrMode, dataIn, this.LSR, "LSR");
              }
              break;
            case I_NOP:
              this.execSingleByteInstruction(this.NOP, "NOP");
              break;
            case I_ORA:
              this.execInternalOnMemoryData(this.instruction.addrMode, dataIn, this.ORA, "ORA");
              break;
            case I_PHA:
              this.execStackPush(this.registers.A, "PHA");
              break;
            case I_PHP:
              this.execStackPush(this.registers.status, "PHP");
              break;
            case I_PLA:
              this.registers.A = this.execStackPull(dataIn, this.registers.A, "PLA");
              break;
            case I_PLP:
              this.registers.status = this.execStackPull(dataIn, this.registers.status, "PLP");
              break;
            case I_ROL:
              if(this.instruction.addrMode === ADDR_ACCUMULATOR) {
                this.execSingleByteInstruction(function () {
                  this.registers.A = this.ROL(this.registers.A);
                }, "ROL A");
              } else {
                this.execRMWOp(this.instruction.addrMode, dataIn, this.ROL, "ROL");
              }
              break;
            case I_ROR:
              if(this.instruction.addrMode === ADDR_ACCUMULATOR) {
                this.execSingleByteInstruction(function () {
                  this.registers.A = this.ROR(this.registers.A);
                }, "ROR A");
              } else {
                this.execRMWOp(this.instruction.addrMode, dataIn, this.ROR, "ROR");
              }
              break;
            case I_RTI:
              // TODO: 
              break;
            case I_RTS:
              this.execRTS(dataIn);
              break;
            case I_SBC:
              this.execInternalOnMemoryData(this.instruction.addrMode, dataIn, this.SBC, "SBC");
              break;
            case I_SEC:
              this.execSingleByteInstruction(this.SEC, "SEC");
              break;
            case I_SED:
              this.execSingleByteInstruction(this.SED, "SED");
              break;
            case I_SEI:
              this.execSingleByteInstruction(this.SEI, "SEI");
              break;
            case I_STA:
              this.execStoreOp(this.instruction.addrMode, dataIn, this.registers.A, "STA");
              break;
            case I_STX:
              this.execStoreOp(this.instruction.addrMode, dataIn, this.registers.X, "STX");
              break;
            case I_STY:
              this.execStoreOp(this.instruction.addrMode, dataIn, this.registers.Y, "STY");
              break;
            case I_TAX:
              this.execSingleByteInstruction(this.TAX, "TAX");
              break;
            case I_TAY:
              this.execSingleByteInstruction(this.TAY, "TAY");
              break;
            case I_TYA:
              this.execSingleByteInstruction(this.TYA, "TYA");
              break;
            case I_TSX:
              this.execSingleByteInstruction(this.TSX, "TSX");
              break;
            case I_TXA:
              this.execSingleByteInstruction(this.TXA, "TXA");
              break;
            case I_TXS:
              this.execSingleByteInstruction(this.TXS, "TXS");
              break;
            default:
              // Unknown opcode
              break;
          }
        }
      } else if(this.status === S_RESET) {
        this.execJMP(ADDR_ABSOLUTE, dataIn);
        if(this.instrTime === 0) {
          // Reset completed.
          this.status = S_RUNNING;
        }
      }
    } else if(this.prevClockLevel === 1 && clk === 0) {
      // Falling edge of the clock.
      // Increment PC
      this.registers.PC += this.PCDelta;
      this.PCDelta = 0;
    }

    this.prevClockLevel = clk;
  }
};

CPU.prototype.getStatusBit = function (bit) 
{
  return this.getBitValue(this.registers.status, bit);
};

CPU.prototype.setStatusBit = function (bit, set)
{
  this.registers.status = this.setBitValue(this.registers.status, bit, set);
};

CPU.prototype.getBitValue = function (bitfield, bit)
{
  return (bitfield >>> bit) & 0x00000001;
};

CPU.prototype.setBitValue = function (bitfield, bit, set)
{
  if(set) {
    bitfield |= (1 << bit);
  } else {
    bitfield &= ~(1 << bit);
  }
  
  return bitfield;
};

// Section A.1: Single byte instructions
CPU.prototype.execSingleByteInstruction = function (instructionFunc, opcodeStr)
{
  if(ENABLE_LOGGING) {
    print(this.instrOffset.toString(16), ": ", opcodeStr);
  }

  instructionFunc.call(this);
  this.stepInstruction(0, 0, 1, this.registers.PC); // NOTE: PC has been already moved to point to the next byte from timestep T0.
};

// Section A.2: Internal execution on memory data
CPU.prototype.execInternalOnMemoryData = function (addrMode, dataIn, instructionFunc, opcodeStr) 
{
  if(addrMode === ADDR_IMMEDIATE) {
    if(ENABLE_LOGGING) {
      print(this.instrOffset.toString(16), ": ", opcodeStr, " #$", dataIn.toString(16));
    }

    instructionFunc.call(this, dataIn);
    this.stepInstruction(0, 1, 1, this.registers.PC + 1);
  } else if(addrMode === ADDR_ZERO_PAGE) {
    if(this.instrTime === 1) {
      this.registers.ADL = dataIn;
      this.stepInstruction(2, 0, 1, (this.registers.ADL & 0x000000FF));
    } else if(this.instrTime === 2) {
      if(ENABLE_LOGGING) {
        print(this.instrOffset.toString(16), ": ", opcodeStr, " $", this.registers.ADL.toString(16));
      }

      instructionFunc.call(this, dataIn);
      this.stepInstruction(0, 1, 1, this.registers.PC + 1);
    }
  } else if(addrMode === ADDR_ZERO_PAGE_X) {
    if(this.instrTime === 1) {
      this.registers.BAL = dataIn;
      this.stepInstruction(2, 0, 1, (this.registers.BAL & 0x000000FF));
    } else if(this.instrTime === 2) {
      // dataIn discarded
      this.stepInstruction(3, 0, 1, (this.registers.BAL + this.registers.X) & 0x000000FF);
    } else if(this.instrTime === 3) {
      if(ENABLE_LOGGING) {
        print(this.instrOffset.toString(16), ": ", opcodeStr, " $", this.registers.BAL.toString(16), ", X");
      }

      instructionFunc.call(this, dataIn);
      this.stepInstruction(0, 1, 1, this.registers.PC + 1);
    }
  } else if(addrMode === ADDR_ABSOLUTE) {
    if(this.instrTime === 1) {
      this.registers.ADL = dataIn;
      this.stepInstruction(2, 1, 1, this.registers.PC + 1);
    } else if(this.instrTime === 2) {
      this.registers.ADH = dataIn;
      this.stepInstruction(3, 0, 1, this.registers.ADL | (this.registers.ADH << 8));
    } else if(this.instrTime === 3) {
      if(ENABLE_LOGGING) {
        print(this.instrOffset.toString(16), ": ", opcodeStr, " $", (this.registers.ADL | (this.registers.ADH << 8)).toString(16));
      }

      instructionFunc.call(this, dataIn);
      this.stepInstruction(0, 1, 1, this.registers.PC + 1);
    }
  } else if(addrMode === ADDR_ABSOLUTE_X) {
    if(this.instrTime === 1) {
      this.registers.BAL = dataIn;
      this.stepInstruction(2, 1, 1, this.registers.PC + 1);
    } else if(this.instrTime === 2) {
      this.registers.BAH = dataIn;
      this.stepInstruction(3, 0, 1, ((this.registers.BAL | (this.registers.BAH << 8)) + this.registers.X) & 0x0000FFFF);
    } else if(this.instrTime === 3) {
      // TODO: Page boundary crossing affects next instruction timestep.
      // Assume that the page boundary hasn't been crossed. Bypass T4 and execute the instruction in this cycle.
      if(ENABLE_LOGGING) {
        print(this.instrOffset.toString(16), ": ", opcodeStr, " $", (this.registers.BAL | (this.registers.BAH << 8)).toString(16), ", X");
      }

      instructionFunc.call(this, dataIn);
      this.stepInstruction(0, 1, 1, this.registers.PC + 1);
    }
  } else if(addrMode === ADDR_ABSOLUTE_Y) {
    if(this.instrTime === 1) {
      this.registers.BAL = dataIn;
      this.stepInstruction(2, 1, 1, this.registers.PC + 1);
    } else if(this.instrTime === 2) {
      this.registers.BAH = dataIn;
      this.stepInstruction(3, 0, 1, ((this.registers.BAL | (this.registers.BAH << 8)) + this.registers.Y) & 0x0000FFFF);
    } else if(this.instrTime === 3) {
      // TODO: Page boundary crossing affects next instruction timestep.
      // Assume that the page boundary hasn't been crossed. Bypass T4 and execute the instruction in this cycle.
      if(ENABLE_LOGGING) {
        print(this.instrOffset.toString(16), ": ", opcodeStr, " $", (this.registers.BAL | (this.registers.BAH << 8)).toString(16), ", Y");
      }

      instructionFunc.call(this, dataIn);
      this.stepInstruction(0, 1, 1, this.registers.PC + 1);
    }
  } else if(addrMode === ADDR_INDIRECT_X) {
    if(this.instrTime === 1) {
      this.registers.BAL = dataIn;
      this.stepInstruction(2, 0, 1, this.registers.BAL);
    } else if(this.instrTime === 2) {
      // dataIn = discarded
      this.stepInstruction(3, 0, 1, (this.registers.BAL + this.registers.X) & 0x000000FF);
    } else if(this.instrTime === 3) {
      this.registers.ADL = dataIn;
      this.stepInstruction(4, 0, 1, (this.registers.BAL + this.registers.X + 1) & 0x000000FF);
    } else if(this.instrTime === 4) {
      // dataIn = ADH
      this.registers.ADH = dataIn;
      this.stepInstruction(5, 0, 1, this.registers.ADL | (this.registers.ADH << 8));
    } else if(this.instrTime === 5) {
      if(ENABLE_LOGGING) {
        print(this.instrOffset.toString(16), ": ", opcodeStr, " ($", (this.registers.ADL | (this.registers.ADH << 8)).toString(16), ", X)");
      }

      instructionFunc.call(this, dataIn);
      this.stepInstruction(0, 1, 1, this.registers.PC + 1);
    }
  } else if(addrMode === ADDR_INDIRECT_Y) {
    if(this.instrTime === 1) {
      this.registers.IAL = dataIn;
      this.stepInstruction(2, 0, 1, this.registers.IAL);
    } else if(this.instrTime === 2) {
      this.registers.BAL = dataIn;
      this.stepInstruction(3, 0, 1, (this.registers.IAL + 1) & 0x000000FF);
    } else if(this.instrTime === 3) {
      this.registers.BAH = dataIn;
      this.stepInstruction(4, 0, 1, ((this.registers.BAL | (this.registers.BAH << 8)) + this.registers.Y) & 0x0000FFFF);
    } else if(this.instrTime === 4) {
      // TODO: Assume no page boundary crossed.
      if(ENABLE_LOGGING) {
        print(this.instrOffset.toString(16), ": ", opcodeStr, " ($", this.registers.IAL.toString(16), "), Y");
      }

      instructionFunc.call(this, dataIn);
      this.stepInstruction(0, 1, 1, this.registers.PC + 1);
    }
  }
};

// Section A.3: Store operations
CPU.prototype.execStoreOp = function (addrMode, dataIn, dataOut, opcodeStr) 
{
  if(addrMode === ADDR_ZERO_PAGE) {
    if(this.instrTime === 1) {
      this.registers.ADL = dataIn;
      this.stepInstruction(2, 0, 0, this.registers.ADL, dataOut);
    } else if(this.instrTime === 2) {
      if(ENABLE_LOGGING) {
        print(this.instrOffset.toString(16), ": ", opcodeStr, " $", this.registers.ADL.toString(16));
      }

      this.stepInstruction(0, 1, 1, this.registers.PC + 1);
    }
  } else if(addrMode === ADDR_ZERO_PAGE_X) {
    if(this.instrTime === 1) {
      this.registers.BAL = dataIn;
      this.stepInstruction(2, 0, 1, this.registers.BAL);
    } else if(this.instrTime === 2) {
      // data discarded
      this.stepInstruction(3, 0, 0, (this.registers.BAL + this.registers.X) & 0x000000FF, dataOut);
    } else if(this.instrTime === 3) {
      if(ENABLE_LOGGING) {
        print(this.instrOffset.toString(16), ": ", opcodeStr, " $", this.registers.BAL.toString(16), ", X");
      }

      this.stepInstruction(0, 1, 1, this.registers.PC + 1);
    }
  } else if(addrMode === ADDR_ZERO_PAGE_Y) {
    if(this.instrTime === 1) {
      this.registers.BAL = dataIn;
      this.stepInstruction(2, 0, 1, this.registers.BAL);
    } else if(this.instrTime === 2) {
      // data discarded
      this.stepInstruction(3, 0, 0, (this.registers.BAL + this.registers.Y) & 0x000000FF, dataOut);
    } else if(this.instrTime === 3) {
      if(ENABLE_LOGGING) {
        print(this.instrOffset.toString(16), ": ", opcodeStr, " $", this.registers.BAL.toString(16), ", Y");
      }

      this.stepInstruction(0, 1, 1, this.registers.PC + 1);
    }
  } else if(addrMode === ADDR_ABSOLUTE) {
    if(this.instrTime === 1) {
      this.registers.ADL = dataIn;
      this.stepInstruction(2, 1, 1, this.registers.PC + 1);
    } else if(this.instrTime === 2) {
      this.registers.ADH = dataIn;
      this.stepInstruction(3, 0, 0, this.registers.ADL | (this.registers.ADH << 8), dataOut);
    } else if(this.instrTime === 3) {
      if(ENABLE_LOGGING) {
        print(this.instrOffset.toString(16), ": ", opcodeStr, " $", (this.registers.ADL | (this.registers.ADH << 8)).toString(16));
      }

      this.stepInstruction(0, 1, 1, this.registers.PC + 1);
    }
  } else if(addrMode === ADDR_ABSOLUTE_X) {
    if(this.instrTime === 1) {
      this.registers.BAL = dataIn;
      this.stepInstruction(2, 1, 1, this.registers.PC + 1);
    } else if(this.instrTime === 2) {
      this.registers.BAH = dataIn;
      this.stepInstruction(3, 0, 1, ((this.registers.BAL | (this.registers.BAH << 8)) + this.registers.X) & 0x0000FFFF);
    } else if(this.instrTime === 3) {
      // data discarded
      this.stepInstruction(4, 0, 0, ((this.registers.BAL | (this.registers.BAH << 8)) + this.registers.X) & 0x0000FFFF, dataOut);
    } else if(this.instrTime === 4) {
      if(ENABLE_LOGGING) {
        print(this.instrOffset.toString(16), ": ", opcodeStr, " $", (this.registers.BAL | (this.registers.BAH << 8)).toString(16), ", X");
      }

      this.stepInstruction(0, 1, 1, this.registers.PC + 1);
    }
  } else if(addrMode === ADDR_ABSOLUTE_Y) {
    if(this.instrTime === 1) {
      this.registers.BAL = dataIn;
      this.stepInstruction(2, 1, 1, this.registers.PC + 1);
    } else if(this.instrTime === 2) {
      this.registers.BAH = dataIn;
      this.stepInstruction(3, 0, 1, ((this.registers.BAL | (this.registers.BAH << 8)) + this.registers.Y) & 0x0000FFFF);
    } else if(this.instrTime === 3) {
      // data discarded
      this.stepInstruction(4, 0, 0, ((this.registers.BAL | (this.registers.BAH << 8)) + this.registers.Y) & 0x0000FFFF, dataOut);
    } else if(this.instrTime === 4) {
      if(ENABLE_LOGGING) {
        print(this.instrOffset.toString(16), ": ", opcodeStr, " $", (this.registers.BAL | (this.registers.BAH << 8)).toString(16), ", Y");
      }

      this.stepInstruction(0, 1, 1, this.registers.PC + 1);
    }
  } else if(addrMode === ADDR_INDIRECT_X) {
    if(this.instrTime === 1) {
      this.registers.BAL = dataIn;
      this.stepInstruction(2, 0, 1, this.registers.BAL);
    } else if(this.instrTime === 2) {
      this.stepInstruction(3, 0, 1, (this.registers.BAL + this.registers.X) & 0x000000FF);
    } else if(this.instrTime === 3) {
      this.registers.ADL = dataIn;
      this.stepInstruction(4, 0, 1, (this.registers.BAL + this.registers.X + 1) & 0x000000FF);
    } else if(this.instrTime === 4) {
      this.registers.ADH = dataIn;
      this.stepInstruction(5, 0, 0, this.registers.ADL | (this.registers.ADH << 8), dataOut);
    } else if(this.instrTime === 5) {
      if(ENABLE_LOGGING) {
        print(this.instrOffset.toString(16), ": ", opcodeStr, " ($", this.registers.BAL.toString(16), ", X)");
      }

      this.stepInstruction(0, 1, 1, this.registers.PC + 1);
    }
  } else if(addrMode === ADDR_INDIRECT_Y) {
    if(this.instrTime === 1) {
      this.registers.IAL = dataIn;
      this.stepInstruction(2, 0, 1, this.registers.IAL);
    } else if(this.instrTime === 2) {
      this.registers.BAL = dataIn;
      this.stepInstruction(3, 0, 1, (this.registers.IAL + 1) & 0x000000FF);
    } else if(this.instrTime === 3) {
      this.registers.BAH = dataIn;
      this.stepInstruction(4, 0, 1, ((this.registers.BAL + this.registers.Y) & 0x000000FF) | (this.registers.BAH << 8));
    } else if(this.instrTime === 4) {
      // data discarded
      this.stepInstruction(5, 0, 0, ((this.registers.BAL + this.registers.Y) & 0x000000FF) | (this.registers.BAH << 8), dataOut);
    } else if(this.instrTime === 5) {
      if(ENABLE_LOGGING) {
        print(this.instrOffset.toString(16), ": ", opcodeStr, " ($", this.registers.IAL.toString(16), "), Y");
      }

      this.stepInstruction(0, 1, 1, this.registers.PC + 1);
    }
  }
};

// Section A.4: Read-Modify-Write operations
CPU.prototype.execRMWOp = function (addrMode, dataIn, instructionFunc, opcodeStr)
{
  if(addrMode === ADDR_ZERO_PAGE) {
    if(this.instrTime === 1) {
      this.registers.ADL = dataIn;
      this.stepInstruction(2, 0, 1, this.registers.ADL);
    } else if(this.instrTime === 2) {
      this.registers.RMWData = dataIn;
      this.stepInstruction(3, 0, 0, this.registers.ADL, this.registers.RMWData);
    } else if(this.instrTime === 3) {
      this.registers.RMWData = instructionFunc.call(this, this.registers.RMWData);
      this.stepInstruction(4, 0, 0, this.registers.ADL, this.registers.RMWData);
    } else if(this.instrTime === 4) {
      if(ENABLE_LOGGING) {
        print(this.instrOffset.toString(16), ": ", opcodeStr, " $", this.registers.ADL.toString(16));
      }

      this.stepInstruction(0, 1, 1, this.registers.PC + 1);
    }
  } else if(addrMode === ADDR_ABSOLUTE) {
    if(this.instrTime === 1) {
      this.registers.ADL = dataIn;
      this.stepInstruction(2, 1, 1, this.registers.PC + 1);
    } else if(this.instrTime === 2) {
      this.registers.ADH = dataIn;
      this.stepInstruction(3, 0, 1, this.registers.ADL | (this.registers.ADH << 8));
    } else if(this.instrTime === 3) {
      this.registers.RMWData = dataIn;
      this.stepInstruction(4, 0, 0, this.registers.ADL | (this.registers.ADH << 8), this.registers.RMWData);
    } else if(this.instrTime === 4) {
      this.registers.RMWData = instructionFunc.call(this, this.registers.RMWData);
      this.stepInstruction(5, 0, 0, this.registers.ADL | (this.registers.ADH << 8), this.registers.RMWData);
    } else if(this.instrTime === 5) {
      if(ENABLE_LOGGING) {
        print(this.instrOffset.toString(16), ": ", opcodeStr, " $", (this.registers.ADL | (this.registers.ADH << 8)).toString(16));
      }

      this.stepInstruction(0, 1, 1, this.registers.PC + 1);
    }
  } else if(addrMode === ADDR_ZERO_PAGE_X) {
    if(this.instrTime === 1) {
      this.registers.BAL = dataIn;
      this.stepInstruction(2, 0, 1, this.registers.BAL);
    } else if(this.instrTime === 2) {
      // data discarded.
      this.stepInstruction(3, 0, 1, (this.registers.BAL + this.registers.X) & 0x000000FF);
    } else if(this.instrTime === 3) {
      this.registers.RMWData = dataIn;
      this.stepInstruction(4, 0, 0, (this.registers.BAL + this.registers.X) & 0x000000FF, this.registers.RMWData);
    } else if(this.instrTime === 4) {
      this.registers.RMWData = instructionFunc.call(this, this.registers.RMWData);
      this.stepInstruction(5, 0, 0, (this.registers.BAL + this.registers.X) & 0x000000FF, this.registers.RMWData);
    } else if(this.instrTime === 5) {
      if(ENABLE_LOGGING) {
        print(this.instrOffset.toString(16), ": ", opcodeStr, " $", this.registers.BAL.toString(16), ", X");
      }

      this.stepInstruction(0, 1, 1, this.registers.PC + 1);
    }
  } else if(addrMode === ADDR_ABSOLUTE_X) {
    if(this.instrTime === 1) {
      this.registers.BAL = dataIn;
      this.stepInstruction(2, 1, 1, this.registers.PC + 1);
    } else if(this.instrTime === 2) {
      this.registers.BAH = dataIn;
      this.stepInstruction(3, 0, 1, ((this.registers.BAL | (this.registers.BAH << 8)) + this.registers.X) & 0x0000FFFF);
    } else if(this.instrTime === 3) {
      // data discarded.
      this.stepInstruction(4, 0, 1, ((this.registers.BAL | (this.registers.BAH << 8)) + this.registers.X) & 0x0000FFFF);
    } else if(this.instrTime === 4) {
      this.registers.RMWData = dataIn;
      this.stepInstruction(5, 0, 0, ((this.registers.BAL | (this.registers.BAH << 8)) + this.registers.X) & 0x0000FFFF, this.registers.RMWData);
    } else if(this.instrTime === 5) {
      this.registers.RMWData = instructionFunc.call(this, this.registers.RMWData);
      this.stepInstruction(6, 0, 0, ((this.registers.BAL | (this.registers.BAH << 8)) + this.registers.X) & 0x0000FFFF, this.registers.RMWData);
    } else if(this.instrTime === 6) {
      if(ENABLE_LOGGING) {
        print(this.instrOffset.toString(16), ": ", opcodeStr, " $", (this.registers.BAL | (this.registers.BAH << 8)).toString(16), ", X");
      }

      this.stepInstruction(0, 1, 1, this.registers.PC + 1);
    }
  }
};

// Section A.5.1: PHP/PHA
CPU.prototype.execStackPush = function (data, opcodeStr)
{
  if(this.instrTime === 1) {
    this.stepInstruction(2, 0, 0, 0x00000100 | this.registers.SP, data);
  } else if(this.instrTime === 2) {
    if(ENABLE_LOGGING) {
      print(this.instrOffset.toString(16), ": ", opcodeStr);
    }

    this.registers.SP--;
    this.stepInstruction(0, 0, 1, this.registers.PC);
  }
};

// Secion A.5.2: PLP/PLA
CPU.prototype.execStackPull = function (dataIn, regValue, opcodeStr)
{
  if(this.instrTime === 1) {
    // data discarded
    this.stepInstruction(2, 0, 1, 0x00000100 | this.registers.SP);
  } else if(this.instrTime === 2) {
    // data discarded
    this.stepInstruction(3, 0, 1, 0x00000100 | (this.registers.SP + 1));
  } else if(this.instrTime === 3) {
    if(ENABLE_LOGGING) {
      print(this.instrOffset.toString(16), ": ", opcodeStr);
    }

    this.registers.SP++;
    regValue = dataIn;
    this.stepInstruction(0, 0, 1, this.registers.PC);
  }

  return regValue;
};

// Section A.5.3: Jump to Subroutine
CPU.prototype.execJSR = function (dataIn)
{
  if(this.instrTime === 1) {
    this.registers.ADL = dataIn;
    this.stepInstruction(2, 0, 1, 0x00000100 | this.registers.SP);
  } else if(this.instrTime === 2) {
    // data discarded
    var jsrAddrHi = (this.registers.PC >>> 8) & 0x000000FF;
    this.stepInstruction(3, 0, 0, 0x00000100 | this.registers.SP, jsrAddrHi);
  } else if(this.instrTime === 3) {
    // data discarded
    var jsrAddrLo = this.registers.PC & 0x000000FF;
    this.stepInstruction(4, 0, 0, 0x00000100 | (this.registers.SP - 1), jsrAddrLo);
  } else if(this.instrTime === 4) {
    // data discarded
    this.stepInstruction(5, 1, 1, this.registers.PC + 1);
    this.registers.SP -= 2;
  } else if(this.instrTime === 5) {
    this.registers.ADH = dataIn;
    this.registers.PC = this.registers.ADL | (this.registers.ADH << 8);

    if(ENABLE_LOGGING) {
      print(this.instrOffset.toString(16), ": JSR $", (this.registers.ADL | (this.registers.ADH << 8)).toString(16));
    }

    this.stepInstruction(0, 0, 1, this.registers.PC);
  }
};

// Section A.5.6: Jump operation
CPU.prototype.execJMP = function (addrMode, dataIn)
{
  if(addrMode === ADDR_ABSOLUTE) {
    if(this.instrTime === 1) {
      this.registers.ADL = dataIn;
      this.stepInstruction(2, 1, 1, this.registers.PC + 1);
    } else if(this.instrTime === 2) {
      this.registers.ADH = dataIn;
      this.registers.PC = this.registers.ADL | (this.registers.ADH << 8);

      if(ENABLE_LOGGING) {
        print(this.instrOffset.toString(16), ": JMP $", (this.registers.ADL | (this.registers.ADH << 8)).toString(16));
      }

      this.stepInstruction(0, 0, 1, this.registers.PC);
    }
  } else if(addrMode === ADDR_INDIRECT) {
    if(this.instrTime === 1) {
      this.registers.IAL = dataIn;
      this.stepInstruction(2, 1, 1, this.registers.PC + 1);
    } else if(this.instrTime === 2) {
      this.registers.IAH = dataIn;
      this.stepInstruction(3, 0, 1, this.registers.IAL | (this.registers.IAH << 8));
    } else if(this.instrTime === 3) {
      this.registers.ADL = dataIn;
      this.stepInstruction(4, 0, 1, ((this.registers.IAL + 1) & 0x000000FF) | (this.registers.IAH << 8));
    } else if(this.instrTime === 4) {
      this.registers.ADH = dataIn;
      this.registers.PC = this.registers.ADL | (this.registers.ADH << 8);
      
      if(ENABLE_LOGGING) {
        print(this.instrOffset.toString(16), ": JMP ($", (this.registers.IAL | (this.registers.IAH << 8)).toString(16), ")");
      }
     
      this.stepInstruction(0, 0, 1, this.registers.PC);
    }
  }
};

// Section A.5.7: Return from Subroutine
CPU.prototype.execRTS = function (dataIn)
{
  if(this.instrTime === 1) {
    // data discarded.
    this.stepInstruction(2, 0, 1, 0x00000100 | this.registers.SP);
  } else if(this.instrTime === 2) {
    // data discarded.
    if(ENABLE_LOGGING) {
      print("RTS T2: PC: ", this.registers.PC);
    }

    this.stepInstruction(3, 0, 1, 0x00000100 | (this.registers.SP + 1));
  } else if(this.instrTime === 3) {
    this.registers.PC = (this.registers.PC & 0x0000FF00) | dataIn;
    if(ENABLE_LOGGING) {
      print("RTS T3: dataIn: ", dataIn, " PC: ", this.registers.PC);
    }
    
    this.stepInstruction(4, 0, 1, 0x00000100 | (this.registers.SP + 2));
  } else if(this.instrTime === 4) {
    this.registers.PC = (this.registers.PC & 0x000000FF) | (dataIn << 8);
    this.registers.PC = (this.registers.PC + 1) & 0x0000FFFF;
    this.registers.SP += 2;
    if(ENABLE_LOGGING) {
      print("RTS T4: dataIn: ", dataIn, " PC: ", this.registers.PC);
    }
    
    this.stepInstruction(5, 0, 1, this.registers.PC);
  } else if(this.instrTime === 5) {
    // data discarded.
    if(ENABLE_LOGGING) {
      print(this.instrOffset.toString(16), ": RTS", " (to ", (this.registers.PC + 1).toString(16), ")");
    }
    this.stepInstruction(0, 1, 1, this.registers.PC + 1);
  }
};

// Section A.5.8: Branch operation
CPU.prototype.execBranch = function (dataIn, takeBranch, opcodeStr) 
{
  if(this.instrTime === 1) {
    // Sign-extend input byte because... JS.
    this.registers.branchOffset = dataIn | (((dataIn & 0x00000080) === 0x00000080) ? 0xFFFFFF00 : 0);
    
    if(ENABLE_LOGGING) {
      print(this.instrOffset.toString(16), ": ", opcodeStr, " $", (this.registers.PC + 1 + this.registers.branchOffset).toString(16));
    }

    if(takeBranch) {
      // TODO: branch crosses page boundary.
      this.stepInstruction(2, 1 + this.registers.branchOffset, 1, this.registers.PC + 1 + this.registers.branchOffset);
    } else {
      this.stepInstruction(0, 1, 1, this.registers.PC + 1);
    }
  } else if(this.instrTime === 2) {
    // data discarded
    this.stepInstruction(0, 0, 1, this.registers.PC);
  }
};

CPU.prototype.stepInstruction = function (nextTime, pcDelta, readEnable, addressBus, dataOut)
{
  if(this.instrTime === 0) {
    this.instrOffset = this.registers.PC;
  }
  
  if(ENABLE_LOGGING && nextTime === 0) {
    print("A: ", this.registers.A.toString(16), ", X: ", this.registers.X.toString(16), ", Y: ", this.registers.Y.toString(16), ", P: ", this.registers.status.toString(2));
  }

  this.instrTime = nextTime;
  this.PCDelta = pcDelta;
  this.readEnable = readEnable;
  this.addressBus = addressBus;
  this.dataOut = dataOut !== undefined ? dataOut : UNDEFINED_VALUE;
};

CPU.prototype.ADC = function (data)
{
  var a = (this.registers.A + data + this.getStatusBit(F_CARRY)) & 0x000001FF; // keep 9 bits for the carry flag.

  if(this.getStatusBit(F_DECIMAL)) {
    this.setStatusBit(F_CARRY, a > 99);
  } else {
    this.setStatusBit(F_CARRY, a > 255);
  }

  this.registers.A = a & 0x000000FF; // mask at 8-bits.

  var overflow = (((this.registers.A ^ a) & (data ^ a)) & 0x80) >>> 7;
  
  this.setStatusBit(F_OVERFLOW, overflow);
  this.setStatusBit(F_NEGATIVE, this.getBitValue(this.registers.A, 7));
  this.setStatusBit(F_ZERO, this.registers.A === 0);
};

CPU.prototype.SBC = function (data)
{
  var onesComplementData = (255 - data) & 0x000000FF;
  var a = (this.registers.A + onesComplementData + this.getStatusBit(F_CARRY)) & 0x000001FF; // keep 9 bits for the carry flag.
  var overflow = (((this.registers.A ^ a) & (onesComplementData ^ a)) & 0x80) >>> 7;
  
  this.registers.A = a & 0x000000FF; // mask at 8-bits.

  this.setStatusBit(F_CARRY, a & 0x00000100 ? 1 : 0);
  this.setStatusBit(F_OVERFLOW, overflow);
  this.setStatusBit(F_NEGATIVE, this.getBitValue(this.registers.A, 7));
  this.setStatusBit(F_ZERO, this.registers.A === 0);
};

CPU.prototype.AND = function (data)
{
  this.registers.A = this.registers.A & data;

  this.setStatusBit(F_NEGATIVE, this.getBitValue(this.registers.A, 7));
  this.setStatusBit(F_ZERO, this.registers.A === 0);
};

CPU.prototype.ORA = function (data)
{
  this.registers.A = this.registers.A | data;

  this.setStatusBit(F_NEGATIVE, this.getBitValue(this.registers.A, 7));
  this.setStatusBit(F_ZERO, this.registers.A === 0);
};

CPU.prototype.EOR = function (data)
{
  this.registers.A = this.registers.A ^ data;

  this.setStatusBit(F_NEGATIVE, this.getBitValue(this.registers.A, 7));
  this.setStatusBit(F_ZERO, this.registers.A === 0);
};

CPU.prototype.BIT = function (data)
{
  this.setStatusBit(F_NEGATIVE, this.getBitValue(data, 7));
  this.setStatusBit(F_OVERFLOW, this.getBitValue(data, 6));
  this.setStatusBit(F_ZERO, (this.registers.A & data) === 0);
};

CPU.prototype.CMP = function (data)
{
  this.setStatusBit(F_CARRY, this.registers.A >= data); // TODO: Absolute value of X?  
  this.setStatusBit(F_ZERO, this.registers.A === data);
  this.setStatusBit(F_NEGATIVE, this.getBitValue((this.registers.A - data) & 0x000000FF, 7));
};

CPU.prototype.CPX = function (data)
{
  this.setStatusBit(F_CARRY, this.registers.X >= data); // TODO: Absolute value of X?  
  this.setStatusBit(F_ZERO, this.registers.X === data);
  this.setStatusBit(F_NEGATIVE, this.getBitValue((this.registers.X - data) & 0x000000FF, 7));
};

CPU.prototype.CPY = function (data)
{
  this.setStatusBit(F_CARRY, this.registers.Y >= data); // TODO: Absolute value of X?  
  this.setStatusBit(F_ZERO, this.registers.Y === data);
  this.setStatusBit(F_NEGATIVE, this.getBitValue((this.registers.Y - data) & 0x000000FF, 7));
};

CPU.prototype.LDA = function (data)
{
  this.registers.A = data;

  this.setStatusBit(F_ZERO, this.registers.A === 0);
  this.setStatusBit(F_NEGATIVE, this.getBitValue(this.registers.A, 7));
};

CPU.prototype.LDX = function (data)
{
  this.registers.X = data;

  this.setStatusBit(F_ZERO, this.registers.X === 0);
  this.setStatusBit(F_NEGATIVE, this.getBitValue(this.registers.X, 7));
};

CPU.prototype.LDY = function (data)
{
  this.registers.Y = data;

  this.setStatusBit(F_ZERO, this.registers.Y === 0);
  this.setStatusBit(F_NEGATIVE, this.getBitValue(this.registers.Y, 7));
};

CPU.prototype.CLC = function ()
{
  this.setStatusBit(F_CARRY, 0);
};

CPU.prototype.CLD = function ()
{
  this.setStatusBit(F_DECIMAL, 0);
};

CPU.prototype.CLI = function ()
{
  this.setStatusBit(F_IRQ_DISABLE, 0);
};

CPU.prototype.CLV = function ()
{
  this.setStatusBit(F_OVERFLOW, 0);
};

CPU.prototype.DEX = function ()
{
  this.registers.X = (this.registers.X - 1) & 0x000000FF;

  this.setStatusBit(F_NEGATIVE, this.getBitValue(this.registers.X, 7));
  this.setStatusBit(F_ZERO, this.registers.X === 0);
};

CPU.prototype.DEY = function ()
{
  this.registers.Y = (this.registers.Y - 1) & 0x000000FF;

  this.setStatusBit(F_NEGATIVE, this.getBitValue(this.registers.Y, 7));
  this.setStatusBit(F_ZERO, this.registers.Y === 0);
};

CPU.prototype.INX = function ()
{
  this.registers.X = (this.registers.X + 1) & 0x000000FF;
  
  this.setStatusBit(F_NEGATIVE, this.getBitValue(this.registers.X, 7));
  this.setStatusBit(F_ZERO, this.registers.X === 0);
};

CPU.prototype.INY = function ()
{
  this.registers.Y = (this.registers.Y + 1) & 0x000000FF;
  
  this.setStatusBit(F_NEGATIVE, this.getBitValue(this.registers.Y, 7));
  this.setStatusBit(F_ZERO, this.registers.Y === 0);
};

CPU.prototype.NOP = function ()
{
};

CPU.prototype.SEC = function ()
{
  this.setStatusBit(F_CARRY, 1);
};

CPU.prototype.SED = function ()
{
  this.setStatusBit(F_DECIMAL, 1);
};

CPU.prototype.SEI = function ()
{
  this.setStatusBit(F_IRQ_DISABLE, 1);
};

CPU.prototype.TAX = function ()
{
  this.registers.X = this.registers.A;
  
  this.setStatusBit(F_NEGATIVE, this.getBitValue(this.registers.X, 7));
  this.setStatusBit(F_ZERO, this.registers.X === 0);
};

CPU.prototype.TXA = function ()
{
  this.registers.A = this.registers.X;
  
  this.setStatusBit(F_NEGATIVE, this.getBitValue(this.registers.A, 7));
  this.setStatusBit(F_ZERO, this.registers.A === 0);
};

CPU.prototype.TAY = function ()
{
  this.registers.Y = this.registers.A;
  
  this.setStatusBit(F_NEGATIVE, this.getBitValue(this.registers.Y, 7));
  this.setStatusBit(F_ZERO, this.registers.Y === 0);
};

CPU.prototype.TYA = function ()
{
  this.registers.A = this.registers.Y;
  
  this.setStatusBit(F_NEGATIVE, this.getBitValue(this.registers.A, 7));
  this.setStatusBit(F_ZERO, this.registers.A === 0);
};

CPU.prototype.TXS = function ()
{
  this.registers.SP = this.registers.X;
};

CPU.prototype.TSX = function ()
{
  this.registers.X = this.registers.SP;

  this.setStatusBit(F_NEGATIVE, this.getBitValue(this.registers.X, 7));
  this.setStatusBit(F_ZERO, this.registers.X === 0);
};

CPU.prototype.ASL = function (data)
{
  this.setStatusBit(F_CARRY, this.getBitValue(data, 7));
  
  data <<= 1;
  
  this.setStatusBit(F_NEGATIVE, this.getBitValue(data, 7));
  this.setStatusBit(F_ZERO, data === 0);
  
  return data;
};

CPU.prototype.LSR = function (data)
{
  this.setStatusBit(F_CARRY, this.getBitValue(data, 0));
  
  data >>>= 1;
  
  this.setStatusBit(F_NEGATIVE, 0);
  this.setStatusBit(F_ZERO, data === 0);

  return data;
};

CPU.prototype.DEC = function (data)
{
  data = (data - 1) & 0x000000FF;
  
  this.setStatusBit(F_NEGATIVE, this.getBitValue(data, 7));
  this.setStatusBit(F_ZERO, data === 0);

  return data;
};

CPU.prototype.INC = function (data)
{
  data = (data + 1) & 0x000000FF;
  
  this.setStatusBit(F_NEGATIVE, this.getBitValue(data, 7));
  this.setStatusBit(F_ZERO, data === 0);
  
  return data;
};

CPU.prototype.ROL = function (data)
{
  var carry = this.getStatusBit(F_CARRY);
  
  this.setStatusBit(F_CARRY, this.getBitValue(data, 7));
  
  data <<= 1;
  data |= carry;
  
  this.setStatusBit(F_NEGATIVE, this.getBitValue(data, 7));
  this.setStatusBit(F_ZERO, data === 0);
  
  return data;
};

CPU.prototype.ROR = function (data)
{
  var carry = this.getStatusBit(F_CARRY);
  
  this.setStatusBit(F_CARRY, this.getBitValue(data, 0));
  
  data >>>= 1;
  data |= (carry << 7);
  
  this.setStatusBit(F_NEGATIVE, carry);
  this.setStatusBit(F_ZERO, data === 0);
  
  return data;
};
