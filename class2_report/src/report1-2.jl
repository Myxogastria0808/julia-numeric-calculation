module MonteCarlo
    using Random
    Random.seed!(0)
    function monte_carlo_func(n::Int64)::Float64
        x::Array{Float64} = zeros(Float64, n)
        y::Array{Float64} = zeros(Float64, n)
        for i::Int64 = 1:n
            x[i] = rand()
            y[i] = rand()
        end
        r::Array{Float64} = zeros(Float64, n)
        for i::Int64 = 1:n
            r[i] = x[i]^2 + y[i]^2
        end
        m::Int64 = 0
        for i::Int64 = 1:n
            if r[i] <= 1
                m = m + 1
            end
        end
        p::Float64 = 4*m/n
        return p
    end

    struct MonteCarloData
        n_vec::Array{Float64}
        result_vec::Array{Float64}
    end

    function monte_carlo_data_func(size::Int64)::MonteCarloData
        n_vec::Array{Int64} = zeros(Int64, size)
        result_vec::Array{Float64} = zeros(Float64, size)
        for i::Int64 = range(1, size, size)
            n::Int64 = 10^i
            result::Float64 = monte_carlo_func(n)
            n_vec[i] = n
            result_vec[i] = abs(result - pi)
        end
        data::MonteCarloData = MonteCarloData(n_vec, result_vec)
        return data
    end
end

using .MonteCarlo
using Plots

data::MonteCarlo.MonteCarloData = MonteCarlo.monte_carlo_data_func(6)

#plotしたものを表示
display(plot(data.n_vec, data.result_vec, xaxis=:log))
_ = Base.prompt("abc")

#plotしたものを画像に保存
# plot(n_vec, result_vec, xaxis=:log)
# savefig("report1-2.png")
