modul test

using Random
using Plots    for i = 1:n
        r[i] = x[i]^2 + y[i]^2
    end

    m = 0

    for i = 1:n
        if r[i] <= 1
            m = m + 1
        end
    end

    p[i] = 4*m/n
end

n = zeros(100)

for i = 1:100
    global i
    n[i] = i
end

println("n = $n")
println("p = $p")

display(plot(p, n, xaxis=:log))

_ = Base.prompt("何かキーを入力すると終了します")

end
