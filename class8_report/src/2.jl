
module Task2LU

using LinearAlgebra

function Pij(i, j, alpha, n)
  In = Matrix{Float64}(I, n, n)  # n次元の単位行列の作成
  P = In + alpha * In[:, i] * In[:, j]'
  return P
end

function make_u(a::Matrix{Float64})
  for j = 1:(size(a)[2]-1)#列
    for i = (j+1):(size(a)[1]) #行
      a = Pij(i, j, -(a[i, j] / a[j, j]), (size(a)[1])) * a
    end
  end
  return a
end

function make_l(a::Matrix{Float64}, u::Matrix{Float64})
  return (a * inv(u))
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
result = Task2LU.Pij(2, 1, -(3 / 4), size(a)[1]) * a
println("result = $result")

#(2.2)
#Uの生成
u = Task2LU.make_u(a)
println("U = $u")

#(2.3)
#Lの生成
l = Task2LU.make_l(a, u)
println("L = $l")

# A = LU
println("L * U = $(l * u)")

