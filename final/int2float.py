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
i = 0
while(i < 2):
    exp = exp << 1
    i += 1
print(bin(exp))

# mantissa
shifts = 16 - count
while shifts > 0:
    init = init << 1
    shifts -= 1
init -= 0b10000000000000000
print(bin(init))

init = init >> 6
print(bin(init))
result = (exp << 8) + init

print("2's complement", a, "the floating point is", bin(result))




