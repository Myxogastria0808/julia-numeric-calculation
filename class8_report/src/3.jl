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

using .Task1LU
using .Task2LU
function task1_bs(u::Matrix{Float64}, b::Vector{Float64})::Vector{Float64}
    #結果の行ベクトル
    result_vec::Vector{Float64} = zeros(Float64, 0)
    u_size::Tuple{Int64,Int64} = size(u)
    #初期値
    x::Float64 = b[1] / u[u_size[1], u_size[2]]
    pushfirst!(result_vec, x)
    for i = 2:(u_size[1])
        term::Float64 = 0.0
        result_vec_counter::Int64 = 1
        for n=(u_size[1] - (i-2)):u_size[1]
            term += ( u[(u_size[1] - (i-1)), n] / u[(u_size[1] - (i-1)), (u_size[2] - (i-1))] ) * result_vec[result_vec_counter]
            result_vec_counter += 1
        end
        x = (b[u_size[1]-i+1] / u[(u_size[1]-i+1), (u_size[2]-i+1)]) - term
        pushfirst!(result_vec, x)
    end
    return result_vec
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
]

hhhh::Matrix{Float64} = [ 1.0 1.0 1.0 ]

#課題1のパターン
u1::Matrix{Float64} = BackwardSubstitution.Task1LU.make_u(a)
hello1 = BackwardSubstitution.task1_bs(u1, b)
println("hello1 = $hello1")

#課題2のパターン
u2::Matrix{Float64} = BackwardSubstitution.Task2LU.make_u(a)
hello2 = BackwardSubstitution.task1_bs(u2, b)
println("hello2 = $hello2")

