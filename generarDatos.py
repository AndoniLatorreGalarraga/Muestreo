import random, csv, math

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
        edadGenerada = random.choices([k for k in range(40,100)], [1/(1.07**i) for i in range(100-40)])[0]
    
    #generar variable sexo
    
    coefGrado = {'Biologia': 0.4, 'Bioquimica y Biologia Molecular': 0.45, 'Biotecnologia': 0.5, 'Ciencia y Tecnologia de los Alimentos': 0.2, 'Ciencias Ambientales': 0.55, 'Fisica': 0.8, 'Geologia': 0.2, 'Matematicas': 0.7, 'Quimica': 0.65}

    coef = coefGrado[grado]*math.sqrt(edad)/10
    l = len(grado)*math.sqrt(edad)/10

    sexo = random.choices(['Hombre', 'Mujer'], [coef, 1-coef])[0]

    #generar curso
    
    curso = random.choices([1, 2, 3, 4], [l/1.05**(coef*i) for i in range(4)])[0]

    #generar horas
    horas = random.normalvariate(7*(1+coef), l/10)
    horas = max(0, horas) #las horas son no negativas
    
    #generar nota de bachi y sele
    nota = random.normalvariate(7*(1+coef), math.sqrt(l))
    nota = min(14,max(0,nota)) #0<=nota<=14

    #resultado
    return [grado, edadGenerada, sexo, curso, horas, nota]

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
    writer.writerow(['Grado', 'Edad', 'Sexo', 'Curso', 'Horas', 'Nota'])
    writer.writerows(datos)