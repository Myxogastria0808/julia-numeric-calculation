module test

using Random
using Plots

Random.seed!(0)

p = zeros(100)

for n = 1:100

    x = zeros(n) # n次元ベクトルを全要素の値0で生成
    y = zeros(n)

    for i = 1:n
        x[i] = rand()
        y[i] = rand()
    end

    r = zeros(n)

    for i = 1:n
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