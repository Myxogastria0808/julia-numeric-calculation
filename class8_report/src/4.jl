module NewtonMethod

using Polynomials
using Plots

function p(z::ComplexF64)::ComplexF64
  return z^3.0 - 1.0
end

function pd(z::ComplexF64)::ComplexF64
  return 3.0 * z^2.0
end

function newton_p(inital_value::ComplexF64)::Vector{ComplexF64}
  result_array::Vector{ComplexF64} = zeros(ComplexF64, 0)
  z = inital_value
  push!(result_array, z)
  while true
    z_next = z - (p(z) / pd(z))
    push!(result_array, z_next)
    if abs(z_next - z) < 10.0^(-5)
      return result_array
    end
    z = z_next
  end
end

function poly_p()::Vector{ComplexF64}
  p = Polynomials.Polynomial([-1, 0, 0, 1])
  return Polynomials.roots(p)
end

function newton_plot(newton_p_vec::Vector{ComplexF64}, poly_p_vec::Vector{ComplexF64})
  newton_plot = Plots.plot(newton_p_vec, markershape=:circle, la=0.0, label="Newton Method")
  Plots.plot!(newton_plot, poly_p_vec, markershape=:square, la=0.0, label="Answer")
  savefig("newton.png")
end

function newton_error(newton_p_vec::Vector{ComplexF64})
  result_vec::Vector{Float64} = zeros(Float64, 0)
  index_vec::Vector{Int64} = range(1, length(newton_p_vec), length(newton_p_vec))
  for i = eachindex(newton_p_vec)
    push!(result_vec, abs(newton_p_vec[i]))
  end
  Plots.plot(index_vec, result_vec, yaxis=:log, markershape=:square, la=0.0, label="Error by Newton Method")
  savefig("newton_error.png")
end

end

using .NewtonMethod

#(4.1) (4.2)
poly = NewtonMethod.poly_p()
println("correct answer 1 = $(poly[1])")
println("correct answer 2 = $(poly[2])")
println("correct answer 3 = $(poly[3])")

#newton method
newton = NewtonMethod.newton_p(complex(2.0,2.0))
println("newton = $newton")

#polynomials
poly= NewtonMethod.poly_p()

#plot graph
NewtonMethod.newton_plot(newton, poly)

#(4.3)
NewtonMethod.newton_error(newton)
