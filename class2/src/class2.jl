module class2

println("Hello World!")

arr_1 = [1, 2, 3]
println("arr_1の値: $arr_1")

#*display関数
# 変数のより詳細な情報が得られる場合がある。
arr_2 = [5, 6, 7]
display(arr_2)

#*パッケージの利用
using LinearAlgebra
arr_3 = [1, 2, 3]
println(norm(arr_3))

#*配列
# 添え字は、1から始まる
# 配列の要素の方は全て同じになる

#*演算や関数を配列要素全てに適用する（ブロードキャスト）
# ex) 配列の全要素に対して1を足したい
arr_4 = [1, 2, 3]
arr_5 = arr_4 .+ 1
println(arr_5)

#*演算や関数を配列要素全てに適用する（ブロードキャスト）
# sinやcosなどの初等関数も通常は配列に適用できない。
# 配列の全要素にこれらの関数を適用したい場合は、
# 関数名の直後に.をつけて利用する。
arr_6 = [0, pi/4, pi/2]
arr_7 = cos.(arr_6)
println(arr_7)

# Juliaではベクトルや行列に対して線形代数で定義されている演算では通常の演算子（+,-,*など）が使える
arr_8 = [1, 2, 3]; arr_9 = [4, 5, 6]
arr_10 = arr_8 + arr_9 # .(ドット)がなくてもOK
println(arr_10)

# ただし配列同士の要素ごとの積や商を計算する場合は.*や./を使う
arr_8 = [1, 2, 3]; arr_9 = [4, 5, 6]
arr_11 = arr_8 .* arr_9
println(arr_11)

#*ベクトル
arr_12 = [1, 2, 3]
display(arr_12)

#*行列
# 行列（2次元配列）を作る方法：列方向の要素の間は空白、行の間は;（セミコロン）で区切る
# セミコロンの代わりに改行しても良い
arr_13 = [
    1 2 3;
    4 5 6;
    7 8 9;
]
display(arr_13)

#* 配列の代入とコピー
# Juliaでは配列に対する=は配列要素の値のコピーではなく、メモリ上の配列データが保存されている場所のアドレスを複製する。
arr_14 = [1, 2, 3]
println("A = $arr_14")
arr_15 = arr_14
arr_15[1] = 0
println("arr_15 = $arr_15")
println("arr_14 = $arr_14 <- arr_14も書き変わっている")

# 配列の全要素の値をコピーして新しい配列変数を作りたい場合はcopy関数を使う。
arr_16 = [1, 2, 3]
println("A = $arr_16")
arr_17 = copy(arr_16)
arr_17[1] = 0
println("arr_17 = $arr_17")
println("arr_16 = $arr_16 <- arr_16はそのまま")

# 同じサイズの配列がすでにあり、それに全要素の値をコピーしたい場合は.=を使う。
#arr_18とarr_19の長さが同じ
arr_18 = [1, 2, 3]
arr_19 = [4, 5, 6]
println("arr_18 = $arr_18")
println("arr_19 = $arr_19")

arr_19 .= arr_18 #全要素の値のコピー
arr_19[1] = 0 #arr_18の値に変化はないはず
println("arr_18 = $arr_18 <- arr_18はそのまま")
println("arr_19 = $arr_19")

# 定数と変数の積では*を省略することができる
cons_sample = 1.5
println(2cons_sample)
println(3π) # πにも初めから円周率が入っている

#*for文
# パターン1
for i = 1:3
    println(i)
end
# パターン2
for i in 1:3
    println(i^2)
end
#パターン3
#range関数を使うとrange(a, b, n)でaからbの区間に等間隔にn個数値をとることができる
for el_1 = range(1.5, 3.5, 6)
    println(el_1)
end

#*while文
# while文で条件式を満たす間endまでのコードブロックを繰り返す
i = 0
while i < 3
    global i
    println(i)
    i = i + 1
end

var_1 = 1
if var_1 > 0
    println("var_1は正の値です。")
end

var_2 = 0
if var_2 > 0
    println("var_2は正の値です。")
elseif var_2 < 0
    println("var_2は負の値です。")
else
    println("var_2は0です。")
end

#*break
println("break")
var_3 = 1
while var_3 < 10
    global var_3
    println(var_3)
    if var_3 > 2
        break
    end
    var_3 += 1
end

#*continue
println("continue")
var_4 = 0
while var_4 < 6
    global var_4
    var_4 += 1
    if var_4 % 2 == 0
        continue
    end
    println(var_4)
end

#*関数
function my_func_1(x)
    if x > 0
        x
    else
        0
    end
end

println("my_func_1()")
println(my_func_1(5))
println(my_func_1(-1))

# 自作関数でもブロードキャストを利用することによって配列の全要素に関数を適用できる
arr_20 = [1, -2, 3, -4, 5]
arr_21 = my_func_1.(arr_20) # .(ドット)をつけてブロードキャスト
println(arr_21)

# 関数の中で引数にとった配列の要素を書き換えると、呼び出し側の配列も書き換わるため注意
# ※ Juliaではこのように、引数の変数を書き換える働きをする関数（破壊的な関数とも呼ばれる）の名前の末尾に!マークをつける慣習がある。
# 引数が配列であることを想定した関数
function my_func_2!(arr)
    arr .= 1
end

arr_22 = [1, 2, 3]
println("arr_22 = $arr_22")
my_func_2!(arr_22)
println("arr_22 = $arr_22")

end # module class2
