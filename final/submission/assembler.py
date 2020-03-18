print('Running Lab3:')
print("label jump-to    ", "current address    ", "label address")

filenames = ["int2float.txt", "float2int.txt", "float_add.txt"]
out_files = ["int2float_machine.txt", "float2int_machine.txt", "float_add_machine.txt"]

for i in range(3):
    print("\n")
    print("filename: ", filenames[i])

    #w_file is the file we are writing to
    w_file = open(out_files[i], "w")
    cur_file = []
    labels = {}
    lut = []

      
    with open(filenames[i], 'r') as f:
        i = 0
        num_of_label = 0
        for line in f:
            cur_file.append(line)

            if ":" in line:
                line_length = len(line)
                labels[line[0:line_length-2]] = (num_of_label, i)
                lut.append(i)
                num_of_label += 1
                continue
            elif line == "" or line == "\n":
                continue 
            elif line[0:2] == "//":
                continue
            else:
                i += 1
    for i in range(len(lut)):
        print("5'b{:05b}:    Target = 10'b{:010b};".format(i, lut[i]))
    i = 0
    for line in cur_file:
        # skip empty line, labels and comments
        if line == "" or line == "\n":
            continue
        elif ":" in line:
            continue
        elif line[0:2] == "//":
            continue

        str_array = line.split()
        instruction = str_array[0]    

        if instruction == "jmp":
            opcode = "1111"
            value = labels[str_array[1]]
            machine = '{0:05b}'.format(value[0])
            return_rtype = opcode + machine
            w_file.write(return_rtype + '\n' )
            # label / current address / label address
            # print(str_array[1], "    ", machine, "    ", '{0:010b}'.format(labels[str_array[1]]))
            # delta = labels[first_val] - i
            # if delta < 0:
            #     delta = 0b1111111 - abs(delta) + 1
            # machine = '{0:07b}'.format(delta)
            i += 1
            continue
        elif instruction == "assign":
            opcode = "1001"
            machine = '{0:05b}'.format(int(str_array[1]))
            return_rtype = opcode + machine
            w_file.write(return_rtype + '\n' )
            i += 1
            continue
        elif instruction == "clrsc":
            opcode = "1100"
            machine = "00000"
            return_rtype = opcode + machine
            w_file.write(return_rtype + '\n' )
            i += 1
            continue
        elif instruction == "done":
            opcode = "1110"
            machine = "00000"
            return_rtype = opcode + machine
            w_file.write(return_rtype + '\n' )
            i += 1
            continue

        first_val = str_array[1]
        second_val = ''
        first_machine = ''
        second_machine = '' 

        if instruction == "add":
            opcode = "0000"
            second_val = str_array[2]
        elif instruction == "sub":
            opcode = "0001" 
            second_val = str_array[2]
        elif instruction == "beq":
            opcode = "0010"
            second_val = str_array[2]
        elif instruction == "sl":
            opcode = "0011"
            first_val = "reg"
            second_val = str_array[1] # only one register
        elif instruction == "sr":
            opcode = "0100"
            first_val = "reg"
            second_val = str_array[1] # only one register
        elif instruction == "lw": 
            opcode = "0101"
            first_val = "reg"
            second_val = str_array[1] # only one register
        elif instruction == "sw":
            opcode = "0110"
            first_val = "reg"
            second_val = str_array[1] # only one register
        elif instruction == "and":
            opcode = "0111" 
            second_val = str_array[2]
        elif instruction == "mov":
            opcode = "1000"
            first_machine = first_val[0]
            first_val = "reg" # the second value only stores registers
            second_val = str_array[2]
        elif instruction == "bge":
            opcode = "1010"
            second_val = str_array[2]
        elif instruction == "bne":
            opcode = "1011"
            second_val = str_array[2]
        elif instruction == "or":
            opcode = "1101" 
            second_val = str_array[2]
        else:
            opcode = "error: undefined opcode"
            print("error: undefined opcode")
        
        # translate first value
        if first_val == "0," or first_val == "0":
            first_machine = "0"
        elif first_val == "1," or first_val == "1":
            first_machine = "1"
        elif instruction == "mov":
            first_machine = first_machine
        elif first_val == "reg":
            first_machine = "0"
        else:
            first_machine = ""

        # translate second value
        if first_val == "0," or first_val == "0" or first_val == "reg":
            if second_val == "$r0":
                second_machine = "0000"
            elif second_val == "$r1":
                second_machine = "0001"
            elif second_val == "$r2":
                second_machine = "0010"
            elif second_val == "$r3":
                second_machine = "0011"
            elif second_val == "$r4":
                second_machine = "0100"
            elif second_val == "$r5":
                second_machine = "0101"
            elif second_val == "$r6":
                second_machine = "0110"
            elif second_val == "$r7":
                second_machine = "0111"
            elif second_val == "$r8":
                second_machine = "1000"
            elif second_val == "$r9":
                second_machine = "1001"
            elif second_val == "$r10":
                second_machine = "1010"
            elif second_val == "$r11":
                second_machine = "1011"
            elif second_val == "$r12":
                second_machine = "1100"
            elif second_val == "$r13":
                second_machine = "1101"
            elif second_val == "$r14":
                second_machine = "1110"
            elif second_val == "$r15":
                second_machine = "1111"
        elif first_val == "1," or first_val == "1":
            second_machine = '{0:04b}'.format(int(second_val))
            
        return_rtype = opcode + first_machine + second_machine
        w_file.write(return_rtype + '\n' )
        i += 1

    w_file.close()