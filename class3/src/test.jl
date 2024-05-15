module test

using Polynomials

#(2.1)
# f(x) = x^3 -2*x^2 + 0*x + 1
f = Polynomial([1, 0, -2, 1])

ans_2_1_1 = f(1)
println("2.1-1: $ans_2_1_1")

ans_2_1_2 = f(2)
println("2.1-2: $ans_2_1_2")

ans_2_1_3 = f(3)
println("2.1-3: $ans_2_1_3")

#(2.2)
ans_2_2 = roots(f)
println(ans_2_2)

end
