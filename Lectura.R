######

Datos<-read.csv("D:/Proyectos Uni/UPV/Muestreo/datos.csv")

#Vamos a estudiar primero algunos aspectos básicos para conocer nuestra población

#A la hora de calcular intervalos de confianza, trabajaremos en general con una confianza del 99%, pues la muestra es muy grande y por tanto los intervalos de confianza son pequeños. Para intentar lograr intervalos de confianza mayores, subiremos el nivel de confianza. Así, además, tendremos conclusiones más certeras.

#Estas son las proporciones de hombres y mujeres que hay en cada grado, y los intervalos de confianza para la proporción de hombres/total en la población, por grado:

#BIOLOGÍA
prop.table(table(Datos$Sexo[Datos$Grado=="Biologia"], Datos$Grado[Datos$Grado=="Biologia"]))
           
biologia<-subset(Datos, Grado=="Biologia")
prop.test(length(biologia$Sexo[biologia$Sexo=="Hombre"]), length(biologia$Sexo), conf.level=0.99)

#BIOQUÍMICA Y BIOLOGÍA MOLECULAR
prop.table(table(Datos$Sexo[Datos$Grado=="Bioquimica y Biologia Molecular"], Datos$Grado[Datos$Grado=="Bioquimica y Biologia Molecular"]))

bioquimica<-subset(Datos, Grado=="Bioquimica y Biologia Molecular")
prop.test(length(bioquimica$Sexo[bioquimica$Sexo=="Hombre"]), length(bioquimica$Sexo), conf.level=0.99)

#BIOTECNOLOGÍA
prop.table(table(Datos$Sexo[Datos$Grado=="Biotecnologia"], Datos$Grado[Datos$Grado=="Biotecnologia"]))

biotecnologia<-subset(Datos, Grado=="Biotecnologia")
prop.test(length(biotecnologia$Sexo[biotecnologia$Sexo=="Hombre"]), length(biotecnologia$Sexo), conf.level=0.99)

#CIENCIA Y TECNOLOGÍA DE LOS ALIMENTOS
prop.table(table(Datos$Sexo[Datos$Grado=="Ciencia y Tecnologia de los Alimentos"], Datos$Grado[Datos$Grado=="Ciencia y Tecnologia de los Alimentos"]))

tecalimentos<-subset(Datos, Grado=="Ciencia y Tecnologia de los Alimentos")
prop.test(length(tecalimentos$Sexo[tecalimentos$Sexo=="Hombre"]), length(tecalimentos$Sexo), conf.level=0.99)

#CIENCIAS AMBIENTALES
prop.table(table(Datos$Sexo[Datos$Grado=="Ciencias Ambientales"], Datos$Grado[Datos$Grado=="Ciencias Ambientales"]))

cienciasambientales<-subset(Datos, Grado=="Ciencias Ambientales")
prop.test(length(cienciasambientales$Sexo[cienciasambientales$Sexo=="Hombre"]), length(cienciasambientales$Sexo), conf.level=0.99)

#FÍSICA
prop.table(table(Datos$Sexo[Datos$Grado=="Fisica"], Datos$Grado[Datos$Grado=="Fisica"]))

fisica<-subset(Datos, Grado=="Fisica")
prop.test(length(fisica$Sexo[fisica$Sexo=="Hombre"]), length(fisica$Sexo), conf.level=0.99)

#GEOLOGÍA
prop.table(table(Datos$Sexo[Datos$Grado=="Geologia"], Datos$Grado[Datos$Grado=="Geologia"]))

geologia<-subset(Datos, Grado=="Geologia")
prop.test(length(geologia$Sexo[geologia$Sexo=="Hombre"]), length(geologia$Sexo), conf.level=0.99)

#MATEMÁTICAS
prop.table(table(Datos$Sexo[Datos$Grado=="Matematicas"], Datos$Grado[Datos$Grado=="Matematicas"]))

matematicas<-subset(Datos, Grado=="Matematicas")
prop.test(length(matematicas$Sexo[matematicas$Sexo=="Hombre"]), length(matematicas$Sexo), conf.level=0.99)

#QUÍMICA
prop.table(table(Datos$Sexo[Datos$Grado=="Quimica"], Datos$Grado[Datos$Grado=="Quimica"]))

quimica<-subset(Datos, Grado=="Quimica")
prop.test(length(quimica$Sexo[quimica$Sexo=="Hombre"]), length(quimica$Sexo), conf.level=0.99)


#y más generalmente:

prop.table(table(Datos$Sexo))

prop.test(length(Datos$Sexo[Datos$Sexo=="Hombre"]), length(Datos$Sexo), conf.level=0.99)

###VER CÓMO DE BIEN COINCIDE CON LA GENERACIÓN DE DATOS



#Análogamente, la proporción por edades coincidirá con la proporción muestral, y los intervalos de confianza serán pequeños, pues la muestra es grande. Como no tiene mayor interés calcular el intervalo de confianza de estas proporciones para cada edad, calculamos el general:
prop.table(table(Datos$Edad))



################################################################################
#Procedemos ahora con el estudio de algunas variables:




#Vamos a relacionar las horas de estudio con el sexo:
#Veamos primero la cantidad de horas de estudio de los hombres:

hombres<-subset(Datos, Sexo=="Hombre")
#El intervalo de confianza para la media de horas de estudio de los hombres es:
t.test(hombres$Estudio, alternative='two.sided',conf.level=.99)

#Veamos en las mujeres:
mujeres<-subset(Datos, Sexo=="Mujer")
#El intervalo de confianza para la media de horas de estudio de las mujeres es:
t.test(mujeres$Estudio, alternative='two.sided',conf.level=.99)

#El intervalo de confianza para la media general es:
t.test(Datos$Estudio, alternative='two.sided',conf.level=.99)

#CONCLUSIÓN: La cantidad media de horas de estudio de los hombres está por encima de la media general, y la de las mujeres, por debajo. 

#Veamos la diferencia de las medias (hombres y mujeres):
#Debemos ver primero si las varianzas se asemejan o no:
var.test(hombres$Estudio,mujeres$Estudio,conf.level=0.99)

#CONCLUSIÓN: El 1 está en el intervalo, por tanto afirmamos que las varianzas son iguales. Veamos pues la diferencia de medias prometida:
t.test(hombres$Estudio, mujeres$Estudio, conf.level=0.99,var.equal=TRUE)

#CONCLUSIÓN: Como el 0 no pertenece al intervalo, podemos concluir, con un 99% de confianza, que la media de horas de estudio de los hombres es superior a la media de horas de estudio de las mujeres. LOS HOMBRES ESTUDIAN MÁS, EN GENERAL.




################################################################################




#Veamos la relación entre horas de estudio y horas libres.
#La relación entre estas dos variables es relativamente evidente, por tanto veremos si la generación de datos ha sido racional
plot(Datos$Libres, Datos$Estudio)

#CONCLUSIÓN: Este gráfico nos muestra que la generación de datos tiene sentido. La relación entre horas de estudio y horas libres es inversamente proporcional, lo que tiene sentido.

#Vamos a parear estos datos:
t.test(Datos$Estudio, Datos$Libres, conf.level=0.99, paired=TRUE)

#CONCLUSIÓN: Los estudiantes universitarios estudian más horas que horas dedican al tiempo libre, con una diferencia de 6,713h

#Veamos este resultado, pero teniendo en cuenta el sexo:

#HOMBRES:
t.test(hombres$Estudio, hombres$Libres, conf.level=0.99, paired=TRUE)

#MUJERES:
t.test(mujeres$Estudio, mujeres$Libres, conf.level=0.99, paired=TRUE)

#CONCLUSIÓN: Las mujeres dedican más tiempo al ocio respecto al tiempo que estudian, pues la media de la diferencia es 5.039471 h, significativamente menor que la media de la diferencia de los hombres: 6.71343h




################################################################################




#Para contextualizar esta diferencia, resulta interesante considerar cuánto tiempo libre tienen los hombres y las mujeres:
#Haremos un proceso similar al realizado al calcular la diferencia de las medias entre las horas de estudio de hombres y de mujeres:

#El intervalo de confianza para la media de horas libres de los hombres es:
t.test(hombres$Libres, alternative='two.sided',conf.level=.99)

#El intervalo de confianza para la media de horas libres de las mujeres es:
t.test(mujeres$Libres, alternative='two.sided',conf.level=.99)

#El intervalo de confianza para la media general es:
t.test(Datos$Libres, alternative='two.sided',conf.level=.99)

#CONCLUSIÓN: La cantidad media de horas libres de los hombres está por debajo de la media general, y la de las mujeres, por encima.

#Veamos la diferencia de las medias (hombres y mujeres):
#Debemos ver primero si las varianzas se asemejan o no:
var.test(hombres$Libres,mujeres$Libres,conf.level=0.99)

#CONCLUSIÓN: Como el 1 no está en el intervalo, afirmamos que las varianzas son distintas.Veamos pues la diferencia de medias prometida:
t.test(hombres$Libres, mujeres$Libres, conf.level=0.99, var.equal=FALSE)

#CONCLUSIÓN: El 0 no está en el intervalo y los valores del intervalo son negativos, por tanto, la media de horas libres de los hombres es menor que la media de horas libres de las mujeres. LAS MUJERES DISFRUTAN DE MÁS TIEMPO LIBRE QUE LOS HOMBRES.




################################################################################







################################################################################
#Algunos gráficos que muestran relaciones interesantes:

plot(Datos$Sele, Datos$Estudio)

#Nos muestra que, a mayor nota en selectividad, mayor es la cantidad de horas dedicadas al estudio.

