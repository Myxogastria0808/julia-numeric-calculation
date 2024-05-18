module test

using Polynomials

# for n = range(1, 6, 6)
#     n = 10^n
#     println("10^$n = $n")
# end
println(
    roots(Polynomial([1.0, -124.0, 1.0]))[2]
)

end