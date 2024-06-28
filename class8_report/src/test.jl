module test

using Plots

function p(z)
  return z^3 - 1
end

display(
  Plots.plot(p)
)

const _ = Base.prompt("Press Anykey")

end
