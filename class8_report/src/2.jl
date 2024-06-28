module Task2LU

using LinearAlgebra

function Pij(i, j, alpha, n)
  In = Matrix{Float64}(I, n, n)  # n次元の単位行列の作成
  P = In + alpha * In[:, i] * In[:, j]'
  return P
end

function make_u(a::Matrix{Float64})::Matrix{Float64}
  u::Matrix{Float64} = deepcopy(a)
  for i = 1:(size(u)[1]-1)
    for j = (i+1):(size(a)[2])
      u[j, :] = -1 * (u[i, j] / u[i, i]) * u[i, :] + u[j, :]
    end
  end
  return u
end

function make_lu(a::Matrix{Float64})::Tuple{Matrix{Float64}, Matrix{Float64}}
  #aのサイズ
  a_size::Tuple{Int64, Int64} = size(a)
  u::Matrix{Float64} = deepcopy(a)
  l::Matrix{Float64} = Matrix{Float64}(I, a_size[1], a_size[2])
  alpha::Float64 = 1.0
  for i = 1:(size(u)[1]-1)
    for j = (i+1):(size(a)[2])
      alpha = -1.0 * (u[i, j] / u[i, i])
      u[j, :] = alpha * u[i, :] + u[j, :]
      l[:, i] = -1.0 * alpha * l[:, j] + l[:, i]
      println("i: $i j: $j alpha: $alpha")
      println("l: $l")
    end
  end
  return (l, u)
end

end

using .Task2LU

a = [
  4.0 3.0 2.0 1.0
  3.0 4.0 3.0 2.0
  2.0 3.0 4.0 3.0
  1.0 2.0 3.0 4.0
]

#(2.1)
a[2, :] = (-3 / 4 * a[1, :]) + a[2, :]
println("(2.1): $a")

a = [
  4.0 3.0 2.0 1.0
  3.0 4.0 3.0 2.0
  2.0 3.0 4.0 3.0
  1.0 2.0 3.0 4.0
]

#(2.2)
#Uの生成
u = Task2LU.make_u(a)
println("U = $u")

#(2.3)
#ULの生成
l, u = Task2LU.make_lu(a)
println("L = $l")
println("U = $u")

# A = LU
println("L * U = $(l * u)")
