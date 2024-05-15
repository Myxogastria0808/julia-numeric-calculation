module monte_carlo
    using Random
    Random.seed!(0)
    function MonteCarlo(n::Int64)
        x::Vector{Float64} = zeros(Float64, n)
        y::Vector{Float64} = zeros(Float64, n)
        for i::Int64 = 1:n
            x[i] = rand()
            y[i] = rand()
        end
        r::Vector{Float64} = zeros(Float64, n)
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

    function MonteCarloData(size::Int64)
        n_vec::Vector{Int64} = zeros(Int64, size)
        result_vec::Vector{Float64} = zeros(Float64, size)
        for i::Int64 = range(1, size, size)
            n::Int64 = 10^i
            result::Float64 = MonteCarlo(n)
            n_vec[i] = n
            result_vec[i] = abs(result - pi)
        end
        return n_vec, result_vec
    end
end

using .monte_carlo
using Plots

n_vec::Vector{Int64}, result_vec::Vector{Float64} = monte_carlo.MonteCarloData(6)

plot(n_vec, result_vec, xaxis=:log)

savefig("report1-2.png")
