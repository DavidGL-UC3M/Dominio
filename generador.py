
for i in (3,6,10):
    outputFile = f"salida{i}x{i}.txt"

    string = ""
    for j in range(i):
        for k in range(i):
            string += f"t{j}{k} "

    string += "- tile\n\n"

    for j in range(i):
        for k in range(i):
            string += f"(= (x t{j}{k}) {j}) (= (y t{j}{k}) {k})"
            
    with open(outputFile, "w") as f:

        f.write(string)