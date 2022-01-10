rows, columns = 10, 10

outputFile = "salida.txt"

string = ""
for i in range(rows):
    for j in range(columns):
        string += f"t{i}{j} "

string += "- tile\n"

for i in range(rows):
    for j in range(columns):
        string += f"(= (x t{i}{j}) {i})\n(= (y t{i}{j}) {j})\n"
        
with open(outputFile, "w") as f:

    f.write(string)