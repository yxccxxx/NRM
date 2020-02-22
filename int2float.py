def twos_comp(val, bits):
    """compute the 2's complement of int value val"""
    if (val & (1 << (bits - 1))) != 0: # if sign bit is set e.g., 8bit: 128-255
        val = val - (1 << bits)        # compute negative value
    return val 

init = twos_comp(263, 16)
a = init
print(bin(a))
result = 0

# exp
count = 0
while a != 1:   # !(MSB == 0 && LSB == 1)
                # MSB != 0 || LSB != 1
    a = a >> 1
    count += 1
exp = count + 15
exp = exp << 10
result |= exp
print(bin(result))

# mantissa
mantissa = init << (16 - count)

mantissa = mantissa >> 6
print(bin(mantissa))
result |= mantissa

print("2's complement", init, "the floating point is", bin(result))




