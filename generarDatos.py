import random, csv, math

#funcion generadora de variables
def generar(grado, edad):
    #coeficientes ocultos
    sDict = { #Proporcion de hombres
        'Biologia': 0.4,
        'Bioquimica y Biologia Molecular':0.45,
        'Biotecnologia': 0.5,
        'Ciencia y Tecnologia de los Alimentos': 0.2,
        'Ciencias Ambientales': 0.55,
        'Fisica': 0.8,
        'Geologia': 0.2,
        'Matematicas': 0.7,
        'Quimica': 0.65}
    s = sDict[grado]
    nDict = { #nota de corte
        'Biologia': 11.895,
        'Bioquimica y Biologia Molecular': 13.265,
        'Biotecnologia': 12.872,
        'Ciencia y Tecnologia de los Alimentos': 8.083,
        'Ciencias Ambientales': 9.774,
        'Fisica': 12.694,
        'Geologia': 9.477,
        'Matematicas': 12.664,
        'Quimica': 11.080}
    n = nDict[grado]
    i = random.uniform(0,1) #poco esfuerzo/dificultades 0 --- 0.5 --- 1 mucho esfuerzo/facilidades

    #generar edad
    if edad >= 18 and edad <=29:
        edadGenerada = edad
    elif edad == 30:
        edadGenerada = random.choice([k for k in range(30, 35)])
    elif edad == 35:
        edadGenerada = random.choice([k for k in range(35, 40)])
    elif edad == 40:
        edadGenerada = random.choices([k for k in range(40,100)], [1/(1.07**i) for i in range(100-40)])[0] #P
    
    #generar variable sexo
    sexo = random.choices(['Hombre', 'Mujer'], [s, 1-s])[0]

    #generar variable curso
    if edad == 18:
        curso = 1
    elif edad == 19:
        curso = random.choices([1,2],[1,2])[0] #P
    elif edad == 20:
        curso = random.choices([1,2,3],[1,1,4])[0] #P
    elif edad == 21:
        curso = random.choices([1,2,3,4],[1,1,1,6])[0] #P
    else:
        curso = random.choice([1,2,3,4])
    
    #generar variable media de selctividad
    mu = n + (14-n)*i
    sigma = 0.1 #P
    sele = max(n,min(14,random.normalvariate(mu,sigma)))

    #generar variable horas de estudio
    mu = curso + 10*(n/10.5)*(1+i) #P
    sigma = 3 #P
    est = max(0, random.normalvariate(mu,sigma))

    #generar variable horas libres
    mu = 5 + 3*((20-n)) - est #P
    sigma = 3 #P
    libre = max(0, random.normalvariate(mu, sigma))

    #generar variable actividades extra
    m = (libre + est)
    t = (m-libre)*(m-est) #P
    d = libre*(m-est) #P
    o = libre*(m-est) #P
    extra = random.choices(['Trabajo', 'Deporte', 'Otro', 'NO'], [t, d, o, 1+(t+d+o)/3])[0] #P

    return [grado, edad, sexo, curso, round(sele,2), round(est,2), round(libre,2), extra]

random.seed(0) #asegura que los resultados sean los mismos cada vez que se ejecuta

datos = []
hist = {}

with open('test.csv') as csvFile:
    csvReader = csv.reader(csvFile, delimiter = ',')
    linea = 0
    for fila in csvReader:
        if linea != 0: #se salta la primera fila
            for i in range(int(fila[2])):
                datos.append(generar(fila[0], int(fila[1])))
                hist.setdefault(fila[0], 0)
                hist[fila[0]] += 1
        linea += 1

print(hist)

#datos -> datos.csv
with open('datos.csv', 'w', encoding='UTF8', newline='') as f:
    writer = csv.writer(f)
    writer.writerow(['Grado', 'Edad', 'Sexo', 'Curso', 'Sele', 'Estudio', 'Libres', 'Extra'])
    writer.writerows(datos)