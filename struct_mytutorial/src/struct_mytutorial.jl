module struct_mytutorial

struct A
    x::Int64
    y::Int64
    # A() = new()
end

a = A(1, 2)

#構造体名の取得
println(
    typeof(a)
)

#フィールド名の取得
println(
    fieldnames(A)
)

#各フィールドの値の取得
println(
    getproperty(a, :x)
)

#構造体を自作の型のように使う
function A_func(input_A::A)::A
    x::Int64 = input_A.x
    y::Int64 = input_A.y
    result::A = A(x, y)
    return result
end

nyoki::A = A_func(a)

println(nyoki)

end # module struct_mytutorial
