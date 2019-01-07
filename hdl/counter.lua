require('hdl');
require('adder');
local memoize = require("memoize");

hdlRegisterAdder(adc);

makeCounter = memoize(function (numBits, maxValue)
  local counterName = tostring(numBits) .. "-bit Counter";
  maxValue = maxValue or ((1 << numBits) - 1);

  return module(counterName)(function ()
    clk = input(bit);
    rst_n = input(bit);
    en = input(bit);

    cnt = register(bit[numBits], clk, rst_n);
    if(maxValue ~= ((1 << numBits) - 1)) then
      assign(cnt, when(en, when(eq(cnt, maxValue), 0, cnt + 1), cnt));
    else
      assign(cnt, when(en, cnt + 1, cnt));
    end

    o = output(cnt);
  end);
end);
