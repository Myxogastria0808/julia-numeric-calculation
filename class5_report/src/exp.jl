module Exp

  function myexp(x::Float64)
    //整数部
    x_int::Int64 = Int64(floor(x));
    //小数部
    x_decimal::Float64 = mod1(x, x);
    
  end

end

import .Exp



