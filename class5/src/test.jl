module test

using Plots
using Polynomials
# p(x) = c0 + c1*x + c2*x^2 + c3*x^3 + c4*x^4

#(1.1)
x::Array{Float64} = [
  (-0.3 + (4.3 / 4.0) * 0.0),
  (-0.3 + (4.3 / 4.0) * 1.0),
  (-0.3 + (4.3 / 4.0) * 2.0),
  (-0.3 + (4.3 / 4.0) * 3.0),
  (-0.3 + (4.3 / 4.0) * 4.0)
]

function f(x::Float64)
  return exp(-x)*sin(x)
end

y::Array{Float64} = [
  f((-0.3 + (4.3 / 4.0) * 0.0)),
  f((-0.3 + (4.3 / 4.0) * 1.0)),
  f((-0.3 + (4.3 / 4.0) * 2.0)),
  f((-0.3 + (4.3 / 4.0) * 3.0)),
  f((-0.3 + (4.3 / 4.0) * 4.0))
]

println("(1.1)")
p = Polynomials.fit(x, y, 4)
#p(x) = -0.0214908 + 0.972825*x - 0.869898*x^2 + 0.261807*x^3 - 0.0262536*x^4
println(p)

#(1.2)
x_12::Array{Float64} = [0.5, 1.5, 2.5, 3.5]
result_12::Array{Float64} = zeros(4)


for i=range(1, 4)
  x::Float64 = x_12[i]
  result_12[i] = abs(p(x) - f(x))
end

println("(1.2)")
for i=range(1, 4)
  println("x=$(x_12[i]), |p(x)-f(x)|=$(result_12[i])")
end

println("(2.1)")
function my_vandermonde(x)
  n = length(x)
  V = zeros(n, n)
  for i = 1:n
    V[:, i] = x.^(i-1)
  end
  return V
end

println("(2.2)")
x_22::Array{Float64} = [-1.5, -0.5, 0.5, 1.5]
y_22::Array{Float64} = [6.75, 5.25, -6.25, -15.75]

result_22 = Polynomials.fit(x_22, y_22, 3)

println(result_22)

end
