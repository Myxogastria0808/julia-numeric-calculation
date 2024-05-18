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

    function prevent_digit_loss_func(term::Term)::Array{Float64}
        alpha::Float64 = (-term.b + sqrt(term.b^2.0 -4.0*term.a*term.c))/(2.0*term.a)
        beta::Float64 = term.c / (alpha * term.a)
        return [beta, alpha]
    end

end

import .QuadraticEquation

values::QuadraticEquation.Term = QuadraticEquation.Term(1.0, -124.0, 1.0)

println("===桁落ちを防いで解を求める===")
prevent_digit_loss::Array{Float64} = QuadraticEquation.prevent_digit_loss_func(values)
println(prevent_digit_loss)

println("===正確な解を求める===")
true_value::Array{Float64} = QuadraticEquation.true_func(values)
println(true_value)

prevent_digit_loss_solution::QuadraticEquation.Solution = QuadraticEquation.Solution(true_value, prevent_digit_loss)

println("===絶対誤差===")
prevent_digit_loss_absolute_error::Array{Float64} = QuadraticEquation.absolute_error_func(prevent_digit_loss_solution)
println(prevent_digit_loss_absolute_error)

println("===相対誤差===")
prevent_digit_loss_relative_error::Array{Float64} = QuadraticEquation.relative_error_func(prevent_digit_loss_solution)
println(prevent_digit_loss_relative_error)

true_result_1 = QuadraticEquation.quadratic_equation(values, true_value[1])
true_result_2 = QuadraticEquation.quadratic_equation(values, true_value[2])
prevent_digit_loss_result_1 = QuadraticEquation.quadratic_equation(values, prevent_digit_loss[1])
prevent_digit_loss_result_2 = QuadraticEquation.quadratic_equation(values, prevent_digit_loss[2])
println("===2次方程式の解を求める===")
println("x = $(true_value[1]) のとき、")
println("$(values.a)*x^2 + $(values.b)*x + $(values.c) = $true_result_1")
println("x = $(true_value[2]) のとき、")
println("$(values.a)*x^2 + $(values.b)*x + $(values.c) = $true_result_2")
println("x = $(prevent_digit_loss[1]) のとき、")
println("$(values.a)*x^2 + $(values.b)*x + $(values.c) =  $prevent_digit_loss_result_1")
println("x = $(prevent_digit_loss[2]) のとき、")
println("$(values.a)*x^2 + $(values.b)*x + $(values.c) =  $prevent_digit_loss_result_2")

println("===残差===")
prevent_digit_loss_rest_value = QuadraticEquation.rest_func(values, prevent_digit_loss_solution)
println(prevent_digit_loss_rest_value)
