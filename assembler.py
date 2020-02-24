
print('Running Lab3:')

filenames = ["int2float_v2.txt", "float_add_v2.txt"]
out_files = ["int2float_machine.txt", "float_add_machine.txt"]
labels = {}

for i in range(2):

    #w_file is the file we are writing to
    w_file = open(out_files[i], "w")
    cur_file = []
      
    with open(filenames[i], 'r') as f:
        i = 0
        for line in f:
            cur_file.append(line)

            if ":" in line:
                line_length = len(line)
                labels[line[0:line_length-2]] = i
            i += 1
    print(labels)
    i = 0
    for line in cur_file:
        # skip empty line, labels and comments
        if line == "" or line == "\n":
            i += 1
            continue
        elif ":" in line:
            i += 1
            continue
        elif line[0:2] == "//":
            i += 1
            continue

        print(line)

        str_array = line.split()
        instruction = str_array[0]
        first_val = str_array[1]
        second_val = ''

        first_machine = ''
        second_machine = ''     

        if instruction == "jmp":
            opcode = "11"
            delta = labels[first_val] - i
            if delta < 0:
                delta = 0b1111111 - abs(delta) + 1
            machine = '{0:07b}'.format(delta)
            return_rtype = opcode + machine
            w_file.write(return_rtype + '\n' )
            i += 1
            continue

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
            second_val = str_array[2]
        elif instruction == "sr":
            opcode = "0100"
            second_val = str_array[2] 
        elif instruction == "lw": 
            opcode = "0101"
            first_val = "reg"
            second_val = str_array[1] # only one register
        elif instruction == "sw":
            opcode = "0110"
            first_val = "reg"
            second_val = str_array[1] # only one register
        elif instruction == "invert":
            opcode = "0111" 
            first_val = "reg"
            second_val = str_array[1] # only one register
        elif instruction == "mov":
            opcode = "1000"
            first_machine = first_val[0]
            first_val = "reg" # the second value only stores registers
            second_val = str_array[2]
        elif instruction == "assign":
            opcode = "1001"
            first_val = "imm"
            second_val = str_array[1] # only one immediate
        elif instruction == "bge":
            opcode = "1010"
            second_val = str_array[2]
        elif instruction == "bne":
            opcode = "1011"
            second_val = str_array[2]
        else:
            opcode = "error: undefined opcode"
            print("error: undefined opcode")
        
        # translate first value
        if first_val == "0,":
            first_machine = "0"
        elif first_val == "1,":
            first_machine = "1"
        elif instruction == "mov":
            first_machine = first_machine
        else:
            first_machine = ""

        # translate second value
        if first_val == "0," or first_val == "reg":
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
        elif first_val == "1," or first_val == "imm":
            second_machine = '{0:04b}'.format(int(second_val))
            
        return_rtype = opcode + first_machine + second_machine
        w_file.write(return_rtype + line+'\n' )
        i += 1

    w_file.close()