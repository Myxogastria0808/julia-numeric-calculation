module plot_test
using Plots

result = [
  [1,2,3,2],
  [1,2,3,1],
  [3,4,5,1],
  [1,2,3,2],
]

x_1 = [1,2]
y_1 = [1,2]

x_2 = [1,2]
y_2 = [2,1]

function plot_scatter(x_1, y_1, x_2, y_2)
  Plots.scatter(x_1, y_1, markerstrokewidth = 0, mc=:red, legend=false)
  Plots.scatter!(x_2, y_2, markerstrokewidth = 0, mc=:green, legend=false)
end

end
###########################################
using .plot_test

display(
  plot_test.plot_scatter(plot_test.x_1, plot_test.y_1, plot_test.x_2, plot_test.y_2)
)

Base.prompt("Press Anykey")
