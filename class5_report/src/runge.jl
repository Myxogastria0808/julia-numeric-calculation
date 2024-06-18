module Runge

  using Plots
  using Polynomials

  function f(x::Float64)
    return 1 / (25*x^2 + 5*x + 2)
  end

  function runge_graph(start_point::Float64, end_point::Float64, cos_start_point::Float64, cos_end_point::Float64, point_quantity::Int64)
    x_r::Array{Float64} = range(start_point, end_point, point_quantity)
    range_r_poly = Polynomials.fit(x_r, f.(x_r))

    x_cos::Array{Float64} = cos.(range(cos_start_point, cos_end_point, point_quantity));
    range_cos_poly = Polynomials.fit(x_cos, f.(x_cos));

    correct_plot = Plots.plot(f, xlim=[-1.0, 1.0], label="correct function", legend=:bottomright)
    r_poly_plot = Plots.plot!(correct_plot, range_r_poly, xlim=[-1.0, 1.0], label="Value taken at equal intervals in the interval [-1,1]", legend=:bottomright)
    Plots.plot!(r_poly_plot, range_cos_poly, xlim=[-1.0, 1.0], label="Value of cos(θi) when θi is taken equally spaced in the interval [0,π]", legend=:bottomright)
    Plots.savefig("runge.png")
  end

end

using .Runge

Runge.runge_graph(-1.0, 1.0, 0.0, Float64(pi), 10)
