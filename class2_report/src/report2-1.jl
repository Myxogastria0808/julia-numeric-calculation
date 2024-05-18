module QuadraticEquation
    using Polynomials

    struct Term
        c::Float64
        b::Float64
        a::Float64
    end

    struct Solution
        true_value::Array{Float64}
        approximation_value::Array{Float64}
    end

    function approximation_func(term::Term)::Array{Float64}
        return [(-term.b - sqrt(term.b^2.0 -4.0*term.a*term.c))/(2.0*term.a), (-term.b + sqrt(term.b^2.0 -4.0*term.a*term.c))/(2.0*term.a)]
    end

    function true_func(term::Term)::Array{Float64}
        coefficient::Array{Float64} = [term.c, term.b, term.a]
        return roots(Polynomial(coefficient))
    end

    function absolute_error_func(solution::Solution)::Array{Float64}
        return [
            abs(solution.true_value[1] - solution.approximation_value[1]),
            abs(solution.true_value[2] - solution.approximation_value[2])
        ]
    end

    function relative_error_func(solution::Solution)::Array{Float64}
        return [
            abs(solution.approximation_value[1] - solution.true_value[1]) / abs(solution.true_value[1]),
            abs(solution.approximation_value[2] - solution.true_value[2]) / abs(solution.true_value[2]),
        ]
    end

    function quadratic_equation(term::Term, x::Float64)::Float64
        return term.a*x^2 + term.b*x + term.c
    end

    function rest_func(term::Term, solution::Solution)::Array{Float64}
        return [
            abs(quadratic_equation(term, solution.approximation_value[1]) - quadratic_equation(term, solution.true_value[1])),
            abs(quadratic_equation(term, solution.approximation_value[2]) - quadratic_equation(term, solution.true_value[2])),
        ]
    end

    function make_graph_func(term::Term)
        const true_value::Array{Float64} = true_func(values)

    end
end

import .QuadraticEquation

values::QuadraticEquation.Term = QuadraticEquation.Term(1.0, -124.0, 1.0)

println("===解の公式を使って解を求める===")
approximation_value::Array{Float64} = QuadraticEquation.approximation_func(values)
println(approximation_value)

println("===正確な解を求める===")
true_value::Array{Float64} = QuadraticEquation.true_func(values)
println(true_value)

solution::QuadraticEquation.Solution = QuadraticEquation.Solution(true_value, approximation_value)

println("===絶対誤差===")
absolute_error::Array{Float64} = QuadraticEquation.absolute_error_func(solution)
println(absolute_error)

println("===相対誤差===")
relative_error::Array{Float64} = QuadraticEquation.relative_error_func(solution)
println(relative_error)

true_result_1 = QuadraticEquation.quadratic_equation(values, solution.true_value[1])
true_result_2 = QuadraticEquation.quadratic_equation(values, solution.true_value[2])
approximation_result_1 = QuadraticEquation.quadratic_equation(values, solution.approximation_value[1])
approximation_result_2 = QuadraticEquation.quadratic_equation(values, solution.approximation_value[2])
println("===2次方程式の解を求める===")
println("x = $(solution.true_value[1]) のとき、")
println("$(values.a)*x^2 + $(values.b)*x + $(values.c) = $true_result_1")
println("x = $(solution.true_value[2]) のとき、")
println("$(values.a)*x^2 + $(values.b)*x + $(values.c) = $true_result_2")
println("x = $(solution.approximation_value[1]) のとき、")
println("$(values.a)*x^2 + $(values.b)*x + $(values.c) = $approximation_result_1")
println("x = $(solution.approximation_value[2]) のとき、")
println("$(values.a)*x^2 + $(values.b)*x + $(values.c) = $approximation_result_2")

println("===残差===")
rest_value = QuadraticEquation.rest_func(values, solution)
println(rest_value)
