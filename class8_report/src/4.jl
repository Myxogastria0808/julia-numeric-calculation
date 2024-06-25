module NewtonMethod

setprecision(BigFloat, 512)

function p(z::BigFloat)::BigFloat
  return z^3.0 - 1.0
end

function poly_p()

end

function newton_p(z::BigFloat)
  println("z: $z")
  while abs(p(z)) > 10.0^(-5)
    z = z - (z^3.0 - 1.0 / 3.0 * z^2.0)
    println("z: $(z)")
  end
  println("Finish!!!!!!!!!!!!!!!")
end

end

using .NewtonMethod

NewtonMethod.newton_p(big(3.0))

