module Exp

  using Plots

  function myexp(n::Int64, x::Float64)::Float64
    xn::Float64 = 1.0
    P::Float64 = 1.0
    if n == 0
    else
      for k = 0:(n-1)
        r = x / (k+1)
        xn = xn * r
        P = P + xn
      end
    end
    return P
  end

  function myexp2(n::Int64, x::Float64)::Float64
    P::Float64 = 0.0
    if x > 0
      P = myexp(n, x)
    else
      P = (1 / myexp(n, -x))
    end
    return P
  end

  function myexp3(n::Int64, x::Float64)::Float64
    #整数部
    x_int::Int64 = convert(Int, floor(x))
    #小数部
    x_decimal::Float64 = x - x_int
    #整数部の計算
    #result_int::Float64=exp(x_int)
    result_int::Float64 = 1.0
    if x_int > 0
      for i=1:x_int
        result_int = result_int * ℯ
      end
    elseif x_int == 0
    else
      for i=1:-x_int
         result_int = result_int * ℯ
      end
      result_int = 1 / result_int
    end
    #小数部の計算
    P::Float64 = myexp(n, x_decimal)
    return (result_int * P)
  end

  function exp_relative_error_data(n::Int64, start_point::Float64, end_point::Float64, point_quantity::Int64)::Tuple{Array{Float64}, Array{Float64}, Array{Float64}}
    myexp_arrary::Array{Float64} = zeros(Float64, 0) 
    myexp2_arrary::Array{Float64} = zeros(Float64, 0) 
    myexp3_arrary::Array{Float64} = zeros(Float64, 0) 
    for x in range(start_point, end_point, point_quantity)
      correct_point::Float64 = exp(x)
      exp_relative_error::Float64 = abs(myexp(n, x) - correct_point) / abs(correct_point)
      exp2_relative_error::Float64 = abs(myexp2(n, x) - correct_point) / abs(correct_point)
      exp3_relative_error::Float64 = abs(myexp3(n, x) - correct_point) / abs(correct_point)

      push!(myexp_arrary, exp_relative_error)
      push!(myexp2_arrary, exp2_relative_error)
      push!(myexp3_arrary, exp3_relative_error)
    end
    return tuple(myexp_arrary, myexp2_arrary, myexp3_arrary)
  end

  function exp_graph(n::Int64, start_point::Float64, end_point::Float64, point_quantity::Int64)
    myexp_arrary::Array{Float64}, myexp2_arrary::Array{Float64}, myexp3_arrary::Array{Float64} = exp_relative_error_data(n, start_point, end_point, point_quantity) 

    display(Plots.plot(range(start_point, end_point, point_quantity), myexp_arrary, ylim=[10^(-20), 1.0], yaxis=:log))
    display(Plots.plot!(range(start_point, end_point, point_quantity), myexp2_arrary, ylim=[10^(-20), 1.0], yaxis=:log))
    display(Plots.plot!(range(start_point, end_point, point_quantity), myexp3_arrary, ylim=[10^(-20), 1.0], yaxis=:log))
  end

end

import .Exp

hello::Float64 = Exp.myexp(10, -3.14)

println("答え: $(exp(-3.14)), マクローリン: $hello")

hello2::Float64 = Exp.myexp2(10, -3.14)

println("答え: $(exp(-3.14)), マクローリン: $hello2")

hello3::Float64 = Exp.myexp3(10, -3.14)

println("答え: $(exp(-3.14)), マクローリン: $hello3")

a, b, c = Exp.exp_relative_error_data(200, -50.0, 50.0, 101)

println("myexp = $a, myexp2 = $b, myexp3 = $c")

Exp.exp_graph(200, -50.0, 50.0, 10000)

const _ = Base.prompt("Press Anykey")

