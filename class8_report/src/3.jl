module BackwardSubstitution
using LinearAlgebra

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
        for i = (j+1):(size(a)[1]) #行
            push!(P_vec, Pij(i, j, -(a[i, j] / a[j, j]), (size(a)[1])))
        end
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


module Task2LU
using LinearAlgebra

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
    end
  end
  return (l, u)
end
end


using .Task1LU
using .Task2LU

function ly_b(l::Matrix{Float64}, b::Vector{Float64})::Vector{Float64}
  #結果の列ベクトル
  result_vec::Vector{Float64} = zeros(Float64, 0)
  l_size::Tuple{Int64, Int64} = size(l)
  term::Float64 = 0.0
  #初期値
  x::Float64 = b[1] / l[1, 1]
  push!(result_vec, x)
  for i = 2:(l_size[1])
    term = 0.0
    for n = 1:(i-1)
      term += l[i,n] / l[i,i] * result_vec[n]
    end
    x = b[i] / l[i,i] - term
    push!(result_vec, x)
  end
  return result_vec
end

function ux_y(u::Matrix{Float64}, y::Vector{Float64})::Vector{Float64}
    #結果の列ベクトル
    result_vec::Vector{Float64} = zeros(Float64, 0)
    u_size::Tuple{Int64,Int64} = size(u)
    term::Float64 = 0.0
    result_vec_counter::Int64 = 1
    #初期値
    x::Float64 = y[u_size[1]] / u[u_size[1], u_size[2]]
    pushfirst!(result_vec, x)
    for i = 2:(u_size[1])
        term = 0.0
        result_vec_counter = 1
        for n = (u_size[1]-(i-2)):u_size[1]
            term += (u[(u_size[1]-(i-1)), n] / u[(u_size[1]-(i-1)), (u_size[2]-(i-1))]) * result_vec[result_vec_counter]
            result_vec_counter += 1
        end
        x = (y[u_size[1]-i+1] / u[(u_size[1]-i+1), (u_size[2]-i+1)]) - term
        pushfirst!(result_vec, x)
    end
    return result_vec
end

function calc_solution(l::Matrix{Float64}, u::Matrix{Float64}, b::Vector{Float64})::Vector{Float64}
  y::Vector{Float64} = ly_b(l, b)
  x::Vector{Float64} = ux_y(u, y)
  return x
end


function solution_error(a::Matrix{Float64}, x::Vector{Float64}, b::Vector{Float64})
  return b - a*x
end

end

using .BackwardSubstitution


a = [
    4.0 3.0 2.0 1.0
    3.0 4.0 3.0 2.0
    2.0 3.0 4.0 3.0
    1.0 2.0 3.0 4.0
]

b = [
    1.0
    1.0
    1.0
    1.0
]

#課題1のパターン
u1 = BackwardSubstitution.Task1LU.make_u(a)
l1 = BackwardSubstitution.Task1LU.make_l(a)
kadai1_solution = BackwardSubstitution.calc_solution(l1, u1, b)
println("課題1の関数を用いて計算したときの解")
println(kadai1_solution)

kadai1_error = BackwardSubstitution.solution_error(a, kadai1_solution, b)
println("課題1の関数を用いて計算したときの解の誤差")
println(kadai1_error)

a = [
    4.0 3.0 2.0 1.0
    3.0 4.0 3.0 2.0
    2.0 3.0 4.0 3.0
    1.0 2.0 3.0 4.0
]

b = [
    1.0
    1.0
    1.0
    1.0
]

#課題2のパターン
l2, u2 = BackwardSubstitution.Task2LU.make_lu(a)
kadai2_solution = BackwardSubstitution.calc_solution(l2, u2, b)
println("課題2の関数を用いて計算したときの解")
println(kadai2_solution)

kadai2_error = BackwardSubstitution.solution_error(a, kadai2_solution, b)
println("課題2の関数を用いて計算したときの解の誤差")
println(kadai2_error)
