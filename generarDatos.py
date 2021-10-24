import random, csv

#funcion generadora de variables
def generar(grado, edad):

    #generar edad
    if edad >= 18 and edad <=29:
        edadGenerada = edad
    elif edad == 30:
        edadGenerada = random.choice([k for k in range(30, 35)])
    elif edad == 35:
        edadGenerada = random.choice([k for k in range(35, 40)])
    elif edad == 40:
        edadGenerada = random.choice([k for k in range(40,100)])

    #generar variable 1
    if grado == 'Biologia':
        var1 = random.normalvariate(3,2)
    elif grado == 'Matematicas':
        var1 = random.normalvariate(3.5,1)
    
    #generar variable 2
    if grado == 'Biologia':
        var2 = random.choices(['Hombre', 'Mujer'], [0.4, 0.6])[0]
    elif grado == 'Matematicas':
        var2 = random.choices(['Hombre', 'Mujer'], [0.7, 0.3])[0]
    
    #resultado
    return [grado, edadGenerada, var1, var2]

random.seed(0) #asegura que los resultados sean los mismos cada vez que se ejecuta

datos = []

with open('test.csv') as csvFile:
    csvReader = csv.reader(csvFile, delimiter = ',')
    linea = 0
    for fila in csvReader:
        if linea != 0: #se salta la primera fila
            for i in range(int(fila[2])):
                datos.append(generar(fila[0], int(fila[1])))
        linea += 1

#datos -> datos.csv
with open('datos.csv', 'w', encoding='UTF8', newline='') as f:
    writer = csv.writer(f)
    writer.writerow(['Grado', 'Edad', 'Horas', 'Sexo'])
    writer.writerows(datos)