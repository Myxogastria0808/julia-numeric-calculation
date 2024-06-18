module Sin

  using Plots

  function mysin(n::Int64, x::Float64)::Float64
    xn = x
    P  = x
    k  = ceil(n / 2) - 1
    for i = 1:k
      r  = ((-1) / ( (2*i) * (2*i + 1))) * x^2
      xn = xn * r
      P  = P + xn
    end
    return P
  end

  function sin_maclaurin(power_start::Int64, power_end::Int64, x::Float64)
    p_array::Array{Float64} = zeros(Float64, 0)
    correct::Float64 = sin(x)
    for n=range(power_start, power_end, (power_end - power_start + 1))
      p::Float64 = mysin(Int64(n), x)
      #相対誤差の配列
      push!(p_array, abs(p - correct) / abs(correct))
    end
    display(Plots.plot(power_start:power_end, p_array))
  end

  function sin_maclaurin_data(start_point::Float64, end_point::Float64, step_point::Int64, n::Int64)::Array{Float64}
    sin_array::Array{Float64} = zeros(Float64, 0)
    for x=range(start_point, end_point, step_point)
      sin_point::Float64 = mysin(n, x)
      push!(sin_array, sin_point)
    end
    return sin_array 
  end

  function sin_maclaurin_graph(start_point::Float64, end_point::Float64, step_point::Int64, n_array::Array{Int64})
    for n=1:length(n_array)
      sin_array = sin_maclaurin_data(start_point, end_point, step_point, n_array[n])
      if n == 1
        display(Plots.plot(1:step_point, sin_array))
      else
        display(Plots.plot!(1:step_point, sin_array))
      end
    end
  end



end

using .Sin
using Plots

#(3.1)
# x = pi / 4ついて
const x::Float64 = pi / 4

Sin.sin_maclaurin(1, 15, x)

const _ = Base.prompt("Press Anykey")

#(3.2)
#n=1,3,5,7
#x=0:pi/180:pi
hello::Array{Float64} = Sin.sin_maclaurin_data(0.0, Float64(pi), 180, 15)

display(
  Plots.plot(1:180, hello)
)

const _ = Base.prompt("Press Anykey")

Sin.sin_maclaurin_graph(0.0, Float64(pi), 180, [1, 3, 5, 7])

const _ = Base.prompt("Press Anykey")

