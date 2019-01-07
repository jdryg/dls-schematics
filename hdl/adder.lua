require('hdl');

-- Full adder
FullAdder = module[[FullAdder]](
function()
  x = input(bit);
  y = input(bit);
  ci = input(bit);
  p = x ~ y;
  g = x & y;
  s = output(p ~ ci);
  co = output(g | (p & ci));
end);

-- Wrapper function for the FullAdder module
function add3(x, y, c)
  local adder = FullAdder{x=x, y=y, ci=c};
  return adder.s, adder.co;
end

-- N-bit ripple carry adder.
function adc(x, y, c)
  c = c or 0;
  local s = {};
  local si;
  for xi, yi in _zip(x, y) do
    si, c = add3(xi, yi, c);
    s[#s + 1] = si;
  end
  return bits(s), c;
end

-- Helper function:
-- https://stackoverflow.com/a/36096338
function _zip(...)
  local arrays, ans = {...}, {};
  local index = 0;
  return function()
    index = index + 1;
    for i,t in ipairs(arrays) do
      if(type(t) == 'function') then
        ans[i] = t();
      elseif(type(t) == "number" and math.type(t) == "integer") then
        ans[i] = (t >> (index - 1)) & 1;
      else
        ans[i] = t[index];
      end
      if(ans[i] == nil) then
        return;
      end
    end
    return table.unpack(ans);
  end
end
