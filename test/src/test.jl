module test

  using Plots
  x=range(-10, 10, 10000)
  display( Plots.plot(x, (sin^3*x)) )

end # module test
