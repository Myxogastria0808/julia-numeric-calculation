module NewtonMethodAdvanced
using Polynomials
using Plots

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
  display(Plots.plot!(newton_plot, poly_p_vec, markershape=:square, la=0.0, label="Answer"))
end

function newton_error(newton_p_vec::Vector{ComplexF64})
  result_vec::Vector{Float64} = zeros(Float64, 0)
  index_vec::Vector{Int64} = range(1, length(newton_p_vec), length(newton_p_vec))
  for i = eachindex(newton_p_vec)
    push!(result_vec, abs(newton_p_vec[i]))
  end
  display(Plots.plot(index_vec, result_vec, yaxis=:log, markershape=:square, la=0.0, label="Error by Newton Method"))
end
end

using .NewtonMethod

function search_true_solution(newton_p_vec::Vector{ComplexF64}, poly_p_vec::Vector{ComplexF64})::Int64
    approximate_solution::ComplexF64 = newton_p_vec[length(newton_p_vec)]
    #初期値
    divergence::Float64 = abs(poly_p_vec[1] - approximate_solution)
    after_divergence::Float64 = 0.0
    #結果
    result::Int64 = 1
    for i=2:length(poly_p_vec)
        after_divergence = abs(poly_p_vec[i] - approximate_solution)
        if divergence > after_divergence
            divergence = after_divergence
            result = i
        end
    end
    return result
end

function newton_advanced_data(x_min::Float64, x_max::Float64, y_min::Float64, y_max::Float64, m::Int64)::Vector{Vector{Int64}}
    initial_value::ComplexF64 = 0.0
    newton_p_vec::Vector{ComplexF64} = zeros(ComplexF64, 0)
    poly_p_vec::Vector{ComplexF64} = NewtonMethod.poly_p()
    #結果の格納
    result_array::Array{Array{Int64}} = zeros(Int64, 0)
    inner_array::Array{ComplexF64} =zeros(ComplexF64, 0)
    for x=range(x_min, x_max, m)
        inner_array = zeros(ComplexF64, 0)
        for y=range(y_min, y_max, m)
            #x+yi
            initial_value = complex(x, y)
            #Newton Method
            newton_p_vec = NewtonMethod.newton_p(initial_value)
            #search index
            index = search_true_solution(newton_p_vec, poly_p_vec)
            #push
            push!(inner_array, index)
        end
        #push
        push!(result_array, inner_array)
    end
    return result_array
end

function newton_advanced_plot(x_min::Float64, x_max::Float64, y_min::Float64, y_max::Float64, m::Int64)
  #元データ
  data::Vector{Vector{Int64}} = newton_advanced_data(x_min, x_max, y_min, y_max, m)
  #各インデックスのデータ
  x_1::Vector{Int64} = zeros(Int64, 0)
  y_1::Vector{Int64} = zeros(Int64, 0)
  x_2::Vector{Int64} = zeros(Int64, 0)
  y_2::Vector{Int64} = zeros(Int64, 0)
  x_3::Vector{Int64} = zeros(Int64, 0)
  y_3::Vector{Int64} = zeros(Int64, 0)
  for y=eachindex(data)
    for x=eachindex(data[y])
      if data[y][x] == 1
        push!(x_1, x)
        push!(y_1, y)
        println("uooooooo one")
      elseif data[y][x] == 2
        push!(x_2, x)
        push!(y_2, y)
        println("uooooooo two")
      elseif data[y][x] == 3
        push!(x_3, x)
        push!(y_3, y)
        println("uooooooo three")
      end
      println("x = $x, y = $y")
    end
  end
  display(Plots.scatter(x_1, y_1, markerstrokewidth = 0, mc=:red, legend=false))
  display(Plots.scatter!(x_2, y_2, markerstrokewidth = 0, mc=:green, legend=false))
  display(Plots.scatter!(x_3, y_3, markerstrokewidth = 0, mc=:blue, legend=false))
end

end

using .NewtonMethodAdvanced

#newton method
newton = NewtonMethodAdvanced.NewtonMethod.newton_p(complex(2.0,2.0))
#polynomials
poly= NewtonMethodAdvanced.NewtonMethod.poly_p()

index = NewtonMethodAdvanced.search_true_solution(newton, poly)
println("index = $index")
println("true solution = $(poly[index])")

result = NewtonMethodAdvanced.newton_advanced_data(-4.0, 4.0, -5.0, 5.0, 300)
println("result = $result")

NewtonMethodAdvanced.newton_advanced_plot(-4.0, 4.0, -5.0, 5.0, 300)
Base.prompt("Press Anykey")
