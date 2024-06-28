def f(x):
 return x**3 - x

def f_prime(x):
 return 3*x**2 - 1

def newton_method(initial_value):
 x = initial_value
 while True:
   x_next = x - f(x) / f_prime(x)
   if abs(x_next - x) < 0.0001: # 収束判定条件
     return x_next
   x = x_next

# 初期値の範囲と刻み幅
initial_values = [i/10 for i in range(1, 21)]

# 各初期値に対してニュートン法を適用し、解を表示
for initial_value in initial_values:
 solution = newton_method(initial_value)
 print(f"Initial value: {initial_value}, Solution: {solution}")

