module Task1LU

using LinearAlgebra

function Pij(i, j, alpha, n)
  In = Matrix{Float64}(I, n, n)  # n次元の単位行列の作成
  P = In + alpha * In[:, i] * In[:, j]'
  return P
end

function make_m(a::Matrix{Float64})::Vector{Matrix{Float64}}
  P_vec::Vector{Matrix{Float64}} = []
  for j = 1:(size(a)[2]-1)     #列
    m = Pij((j + 1), j, -(a[(j+1), j] / a[j, j]), (size(a)[1]))
    for i = (j+2):(size(a)[1]) #行
      m = Pij(i, j, -(a[i, j] / a[j, j]), (size(a)[1])) * m
    end
    a = m * a
    push!(P_vec, m)
  end
  return P_vec
end

function make_u(a::Matrix{Float64})::Matrix{Float64}
  m::Vector{Matrix{Float64}} = make_m(a)
  for i = eachindex(m)
    a = m[i] * a
  end
  return a
end

function make_l(a::Matrix{Float64})::Matrix{Float64}
  m::Vector{Matrix{Float64}} = make_m(a)
  l::Matrix{Float64} = inv(m[length(m)])
  for i = 1:(length(m)-1)
    l = inv(m[length(m)-i]) * l
  end
  return l
end

end

using .Task1LU

a = [
  4.0 3.0 2.0 1.0
  3.0 4.0 3.0 2.0
  2.0 3.0 4.0 3.0
  1.0 2.0 3.0 4.0
]

#(1.1)
m = Task1LU.make_m(a)
for i = eachindex(m)
  println("M($i) = $(m[i])")
end

println("===================")

u = Task1LU.make_u(a)
println("U = $u")

l = Task1LU.make_l(a)
println("L = $l")

println("L * U = $(l * u)")

