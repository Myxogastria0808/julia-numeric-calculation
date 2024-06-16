module graph

using Plots

x_1 = range(-4*pi, 4*pi, 200)
y_1 = sin.(x_1)
display(plot(x_1, y_1))

_ = Base.prompt("何かキーを入力すると終了します")

display(plot!(x_1, y_1,
  xlabel="X axis", # X軸のラベル
  ylabel="Y axis", # Y軸のラベル
  xlims=(-1, 1), # X軸の描画範囲
  ylims=(-1, 1), # Y軸の描画範囲
  tickfontsize=20, # 目盛りのフォントサイズ
  linecolor=:green, # 線の色
  linewidth=3 # 線の太さ
))

_ = Base.prompt("何かキーを入力すると終了します")

# プロットの重ね描き
x_2 = range(-4*pi, 4*pi, 200)
y_21 = sin.(x_2)
y_22 = cos.(x_2)
display(plot(x_2, y_21, label = "Sine wave"))
display(plot!(x_2, y_22, label="Cosine wave")) # !マークがあることに注意

_ = Base.prompt("何かキーを入力すると終了します")

# 対数グラフ
# 対数グラフ1
x_3 = range(1, 10, 200)
y_3 = x_3.^(-1.5)
display(plot(x_3, y_3, yaxis=:log))

_ = Base.prompt("何かキーを入力すると終了します")

# 対数グラフ
# 対数グラフ2
x_4 = round.(10 .^range(2, 6, 10))
y_4 = x_4 .^(-3)
display(plot(x_4, y_4, xaxis=:log, yaxis=:log))

_ = Base.prompt("何かキーを入力すると終了します")

x_5 = range(-4*pi, 4*pi, 200)
y_5 = cos.(x_5)
plot(x_5, y_5)
savefig("nyoki.png")

end
