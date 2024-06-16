module class5

#多項式回帰
#参考サイト
#https://r-de-r.github.io/stats/Julia-stats8.html
#Polynomials.fit()
#fit(x, y, 次数)で計算できる

using Plots
using Polynomials

#以下のデータを用意する
x = [-2.1, -1.5, -0.7, 0.5, 1.4,  2.3,  3.5, 4.2]
y = [-7.5, -2.0,  3.8, 5.6, 3.7, -1.7, -2.6, 2.3]

display(
    scatter(x, y)
)

_ = Base.prompt("Hello, World")



f2 = Polynomials.fit(x, y, 2); # 2次式で予測
# 0.9313226293358072 - 0.5231411796668045∙x + 0.06976795086638117∙x2

f3 = Polynomials.fit(x, y, 3); # 3次式で予測
# 0.9917995957122127 - 0.7993193261190567∙x + 0.22096036680739517∙x2 - 0.02015898879213521∙x3

f4 = Polynomials.fit(x, y, 4); # 4次式で予測
# 0.9995995032131947 - 0.9293177844687606∙x + 0.360708709533328∙x2 - 0.06565844921453219∙x3 + 0.004549946042239714∙x4

f5 = Polynomials.fit(x, y, 5); # 最高次数 = length(x) - 1 = 5次式で予測
# 1.0 - 0.9762026083107394∙x + 0.4413086878778398∙x2 - 0.11144858183923873∙x3 + 0.015062986695871163∙x4 - 0.0008410432522905108∙x5


display(
    plot(f2)
)

_ = Base.prompt("Hello, World")

end # module class5

