module class3
#整数の範囲でindexを指定した場合
a = 0
while a < 10
    global a
    a = a + 1
    println(a)
end

println("============")

#indexに小数を使う
#*余分に1回ループが回ってしまう
b = 0
while b < 1
    global b
    b = b + 0.1
    println(b)
end

println("============")

#多項式の計算

using Polynomials

p = Polynomial([3, 5, 2])
#p(x) = 2x^2 + 5x + 3
println(p)

#x=2でp(x)を計算
x = 2
y = p(x)
println(y)

println("============")
#複数の点での関数値の計算
x = [1, 2, 3]
y = p.(x)
println(y)

z = roots(p)
#z = p(x) = 2x^2 + 5x + 3 = 0を意味する
println(z)

end # module class3

