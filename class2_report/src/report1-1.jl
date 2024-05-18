module MonteCarloModule
    using Random
    Random.seed!(0)
    function MonteCarlo(n::Int64)::Float64
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

    function monte_carlo_func(n::Int64)::Float64
        if n <= 0
            throw("n have to larger than 0.")
        end
        return MonteCarlo(n)
    end
end

using .MonteCarloModule

p_1::Float64 = MonteCarloModule.monte_carlo_func(1)
println("p_1 = $p_1")

p_100::Float64 = MonteCarloModule.monte_carlo_func(100)
println("p_100 = $p_100")

p_0::Float64 = MonteCarloModule.monte_carlo_func(0)
println("p_0 = $p_0")
