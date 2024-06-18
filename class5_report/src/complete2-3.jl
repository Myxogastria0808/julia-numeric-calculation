module Complete

  using Plots
  using LinearAlgebra

  function make_a(temp::Array{Int64}, n::Int64)::Matrix{Float64}
    linage::Int64 = length(temp)
    a::Matrix{Float64} = [temp[i]^b for i in 1:linage, b in Float64(0):Float64(n)]
    return a
  end

  function gen_a_b(a::Matrix{Float64}, resistivity::Array{Float64})::Vector{Float64}
    Q0::LinearAlgebra.QRCompactWYQ{Float64, Matrix{Float64}, Matrix{Float64}}, R::Matrix{Float64} = LinearAlgebra.qr(a)
    Q::Matrix{Float64} = Matrix(Q0)
    c::Vector{Float64} = inv(R) * Q' * resistivity
    return c
  end

  function complete_graph(temp::Array{Int64}, resistivity::Array{Float64}, a::Matrix{Float64})
    c::Vector{Float64} = gen_a_b(a, resistivity)
    function f(x)
      return c[2] * x + c[1]
    end
    true_graph = Plots.plot(temp, resistivity, markershape=:x, la=0.0,  label="(x, y) = (temparature, resistivity)")
    Plots.plot!(true_graph, f)
    savefig("complete.png")
  end

end

using .Complete

temp::Array{Int64} = [-195, 0, 20, 100, 200, 300, 497, 700, 977]
resistivity::Array{Float64} = [0.2,	1.55,	1.694, 2.33, 2.93, 3.6, 4.6, 6.7, 8.1]

a::Matrix{Float64} = Complete.make_a(temp, 1)

Complete.complete_graph(temp, resistivity, a)

