x = 0b0011010100100100 # 9.75
# x = 0b0100101111100000 # 15.75
y = 0b0101111010000001 # 0.5625

x_exp = (x & 0b0111110000000000) >> 10
y_exp = (y & 0b0111110000000000) >> 10 

x_mantissa = (x & 0b0000001111111111) | 0b0000010000000000
y_mantissa = (y & 0b0000001111111111) | 0b0000010000000000

delta = 0
res_exp = x_exp
if x_exp > y_exp:
    delta = x_exp - y_exp
    y_mantissa = y_mantissa >> delta
elif x_exp < y_exp:
    delta = y_exp - x_exp
    x_mantissa = x_mantissa >> delta
    res_exp = y_exp

res_mantissa = x_mantissa + y_mantissa
if res_mantissa >= 0b100000000000: # 0b10_0000000000
    res_mantissa = res_mantissa >> 1
    res_exp = res_exp + 1

res_mantissa = res_mantissa - 0b10000000000

result = (res_exp << 10) + res_mantissa

print(bin(result))
