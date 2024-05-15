module report2

using Polynomials

#テスト
values::Vector{Float64} = [1.0, -124.0, 1.0]

#解の公式を求める関数
#f(x) = a*x^2 + b*x + c = 0
function approximation_func(c::Float64, b::Float64, a::Float64)
    return [(-b - sqrt(b^2.0 -4.0*a*c))/(2.0*a), (-b + sqrt(b^2.0 -4.0*a*c))/(2.0*a)]
end

println("===解の公式を求める===")
approximation_value::Vector{Float64} = approximation_func(values[1], values[2], values[3])
println(approximation_value)

#正確な解を求める関数
#f(x) = a*x^2 + b*x + c = 0
function true_func(c::Float64, b::Float64, a::Float64)
    coefficient::Vector{Float64} = [c, b, a]
    return roots(Polynomial(coefficient))
end

println("===正確な解を求める===")
true_value::Vector{Float64} = true_func(values[1], values[2], values[3])
println(true_value)

#絶対誤差を求める関数
function absolute_error_func(true_value::Vector{Float64}, approximation_value::Vector{Float64})
    return [
        abs(true_value[1] - approximation_value[1]),
        abs(true_value[2] - approximation_value[2])
    ]
end

println("===絶対誤差===")
absolute_error::Vector{Float64} = absolute_error_func(true_value, approximation_value)
println(absolute_error)

#相対誤差を求める関数
function relative_error_func(true_value::Vector{Float64}, approximation_value::Vector{Float64})
    return [
        abs(approximation_value[1] - true_value[1]) / abs(true_value[1]),
        abs(approximation_value[2] - true_value[2]) / abs(true_value[2]),
    ]
end

println("===相対誤差===")
relative_error::Vector{Float64} = relative_error_func(true_value, approximation_value)
println(relative_error)

#2次方程式の解を求める関数
function quadratic_equation(c::Float64, b::Float64, a::Float64, x::Float64)
    return a*x^2 + b*x + c
end

true_result_1 = quadratic_equation(1.0, 2.0, 1.0, true_value[1])
true_result_2 = quadratic_equation(1.0, 2.0, 1.0, true_value[2])
approximation_result_1 = quadratic_equation(1.0, 2.0, 1.0, approximation_value[1])
approximation_result_2 = quadratic_equation(1.0, 2.0, 1.0, approximation_value[2])
println("===2次方程式の解を求める===")
println("true_result_1 =  $true_result_1")
println("true_result_2 =  $true_result_2")
println("approximation_result_1 =  $approximation_result_1")
println("approximation_result_2 =  $approximation_result_2")

#残差を求める関数
function rest_func(c::Float64, b::Float64, a::Float64, true_value::Vector{Float64}, approximation_value::Vector{Float64})
    return [
        abs(quadratic_equation(c, b, a, approximation_value[1]) - quadratic_equation(c, b, a, true_value[1])),
        abs(quadratic_equation(c, b, a, approximation_value[2]) - quadratic_equation(c, b, a, true_value[2])),
    ]
end

println("===残差===")
rest_value = rest_func(values[1], values[2], values[3], true_value, approximation_value)
println(rest_value)

#桁落ちを防いだ関数
function prevent_digit_loss_func(c::Float64, b::Float64, a::Float64)
    alpha::Float64 = (-b + sqrt(b^2.0 -4.0*a*c))/(2.0*a)
    beta::Float64 = c / (alpha * a)
    return [beta, alpha]
end

println("==========桁落ちを防いだパターン==========")
prevent_digit_loss::Vector{Float64} = prevent_digit_loss_func(values[1], values[2], values[3])
println(prevent_digit_loss)

println("===絶対誤差===")
absolute_error::Vector{Float64} = absolute_error_func(true_value, prevent_digit_loss)
println(absolute_error)

println("===相対誤差===")
relative_error::Vector{Float64} = relative_error_func(true_value, prevent_digit_loss)
println(relative_error)

prevent_digit_loss_result_1 = quadratic_equation(1.0, 2.0, 1.0, prevent_digit_loss[1])
prevent_digit_loss_result_2 = quadratic_equation(1.0, 2.0, 1.0, prevent_digit_loss[2])
println("===2次方程式の解を求める===")
println("prevent_digit_loss_result_1 =  $prevent_digit_loss_result_1")
println("prevent_digit_loss_result_2 =  $prevent_digit_loss_result_2")

println("===残差===")
rest_value = rest_func(values[1], values[2], values[3], true_value, prevent_digit_loss)
println(rest_value)

end