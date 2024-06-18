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
    Plots.plot(power_start:power_end, p_array, label="|mysin(n, π/4) - sin(π/4)| / |sin(π/4)|")
    savefig("mysin.png")
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
        Plots.plot(1:step_point, sin_array, label="n=$n")
      else
        Plots.plot!(1:step_point, sin_array, label="n=$n")
      end
    end
    savefig("sin_maclaurin.png")
  end

end

using .Sin
using Plots

#(3.1)
const x::Float64 = pi / 4

Sin.sin_maclaurin(1, 15, x)

#(3.2)
Sin.sin_maclaurin_graph(0.0, Float64(pi), 180, [1, 3, 5, 7])
