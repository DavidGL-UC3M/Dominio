
for i in (3,6,10):
    outputFile = f"salida{i}x{i}.txt"

    string = ""
    for i in range(i):
        for j in range(i):
            string += f"t{i}{j} "

    string += "- tile\n\n"

    for i in range(i):
        for j in range(i):
            string += f"(= (x t{i}{j}) {i}) (= (y t{i}{j}) {j})"
            
    with open(outputFile, "w") as f:

        f.write(string)