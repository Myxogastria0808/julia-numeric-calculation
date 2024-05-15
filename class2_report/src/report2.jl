module report2

using Polynomials

c = [1, -124, 1]  # 係数リスト
p = Polynomial(c) # 多項式形式(c[1] + c[2]*x+ c[3]*x^2)
x = roots(p)      # 解

println("x = $x")

function quadratic_formula(c::Float64, b::Float64, a::Float64)
    return [(-b + sqrt(b^2.0 -4.0*a*c))/(2.0*a), (-b - sqrt(b^2.0 -4.0*a*c))/(2.0*a)]
end

hello = quadratic_formula(1.0, 2.0, 1.0)

println(hello)

end
