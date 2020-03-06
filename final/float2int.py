def float2int(floatNum):
    exp = floatNum >> 10
    mantissa = (floatNum & 0b1111111111) | 0b10000000000
    if exp < 14:
        return 0
    bit2shift = exp - 25
    if bit2shift < 0:
        bit2shift = -bit2shift
        # roundup = 0
        # while bit2shift > 0:
        #     if bit2shift > 1:
        #         roundup |= (mantissa & 1)
        #     else:
        #         roundup += (mantissa & 1)
        #     mantissa >>= 1
        #     bit2shift -= 1
        # if mantissa & 1:
        #     roundup += 1
        integerPart = mantissa >> bit2shift
        firstFracBit = mantissa << (16 - bit2shift) >> 15
        if firstFracBit == 1:
            if integerPart << 15 >> 15 == 1:
                integerPart += 1
            elif mantissa << (16-bit2shift) >> (17-bit2shift) != 0:
                integerPart += 1
        return integerPart
    else:
        mantissa <<= bit2shift
    return mantissa


print(float2int(0b0011100000000000))
