rows, columns = 4, 4

outputFile = "salida.txt"

string = ""
for i in range(rows):
    for j in range(columns):
        string += f"t{i}{j} "

string += "- tile\n\n"

for i in range(rows):
    for j in range(columns):
        string += f"(= (x t{i}{j}) {i}) (= (y t{i}{j}) {j})"
        
with open(outputFile, "w") as f:

    f.write(string)