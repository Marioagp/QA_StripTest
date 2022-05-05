//AREA DE FUNCIONES (PUEDE ESTAR AL FINAL)

function Datos_de_la_Imag(Acelerador,fecha,RTImageLabel) {
// Mostrar la informacion de la prueba de la cual proviene la imagen
if (RTImageLabel==" MV_187_1a")
{
   print("Test 1.1 Picket Fence RapidArc");
};
else {
    if (RTImageLabel==" MV_62_1a"){
      print("Test 1.2 Picket Fence Error");
     } ;
    else {
      exit("ELEGIR UNA IMAGEN PROVENIENTE DE LAS PRUEBAS: Test 1.1 Picket Fence RapidArc o Test 1.2 Picket Fence Error"); 
     };
};
print(""); print("Acelerador: "+Acelerador); print("Fecha del estudio: "+ fecha);print("");
print(" - - - - - - - - - - - - - - - - - - - - - - ");
};



function Resalta_A_Error(color, lineWidth, x, y) {
setColor(color);
setLineWidth(lineWidth);
Overlay.drawEllipse(x, y, 20, 20);
}



function Dibuja_Circulo(color, lineWidth, x, y) {
		setColor(color);
		setLineWidth(lineWidth);
		Overlay.drawEllipse(x-1, y-1, 2, 2);
}



function Dibuja_Punto(color, lineWidth, x0, y0, x1, y1) {
		setColor(color);
		setLineWidth(lineWidth);
		Overlay.drawLine(x0, y0, x1, y1);
		
}



function encuntra_vecindad(valor_central, Arreglo) { 
// function description
valores_vecinos = newArray(31);// se toman solo 31 valores pq da el ancho perfecto y para q el cntro sea el max
// se obtienen los 30 valores con centro en valor_central
for (i = 0; i < 31; i++) {
     valores_vecinos[i] = Arreglo [valor_central-15+i];    
};
return valores_vecinos;
};



function cento_del_GaussianAdjust(vecindad,x_centro_real) { 
// function description
X = newArray(lengthOf(vecindad));
for (i = 0; i < lengthOf(vecindad); i++) {
	    	X[i]=i;
	    	};
    Fit.doFit("Gaussian", X, vecindad);  //ajuste gaussiano      
    // para ver los resultados
    x_centro = Fit.p(2); //obtine el centro de la curva gaussiana
    //x_centro= Math.round(x_centro);
   return x_centro_real - 16 + x_centro        
    };



function skewness(datos,mean,StDv) { 
n = lengthOf(datos);
//skewnees_v=-1;
for (i = 0; i < n; i++) {
	skewnees_v+=Math.pow((datos[i]-mean), 3);
}    
 //return (skewnees_v*n)/((n-1)*(n-2)*(Math.pow(StDv,3))); //con ajuste 
 return skewnees_v/(n*(Math.pow(StDv,3))); // sin ajuste    
 
};




function kurtosis(datos,mean,StDv) { 
n = lengthOf(datos);
for (i = 0; i < n; i++) {
	kurtosis_v+=Math.pow((datos[i]-mean), 4);
};    
 //return (kurtosis_v*n*(n+1))/((n-1)*(n-2)*(n-3)*(Math.pow(StDv,4)))-3*(Math.pow((n-1),2))/((n-3)*(n-2));//con ajuste
 return kurtosis_v/(n*(Math.pow(StDv,4)));  
};



function mediana(array_vec) {
// mediana de un arreglo	
  array_vec=Array.sort(array_vec);
  n = lengthOf(array_vec);
  if(n%2 == 0)
  {
  	return (array_vec[(n/2)-1]+array_vec[(n/2)])/2
  	};
  else {
  	return array_vec[(n/2)]
  };
};


function cover595to56(valores595) { 
// function description
    valores56 = newArray(56);
	//vecindad_laminaGra = newArray(14);
	//vecindad_laminaPeq = newArray(7);
	ini = 4;
	//laminas de 1 cm las 12 primeras y las 12 ultimas
	for (lamina = 0; lamina < 56; lamina++) {
		if (lamina < 12 ) {
			vecindad_laminaGra = Array.slice(valores595,ini,ini+14);
			Array.getStatistics(vecindad_laminaGra, min, max, mean, stdDev);		
			valores56[lamina]=mean;
			//print("ini: "+ini+"valor de mean " + mean + "\n");
			ini += 14;							
		};
		
		if (11 < lamina && lamina < 44){
			vecindad_laminaPeq = Array.slice(valores595,ini,ini+8);
			Array.getStatistics(vecindad_laminaPeq, min, max, mean, stdDev);		
			valores56[lamina]=mean;
			//print("ini: "+ini+"valor de mean " + mean + "\n");
			ini +=8; 
			};
			
		if (lamina > 43) {
			vecindad_laminaGra = Array.slice(valores595,ini,ini+14);
			Array.getStatistics(vecindad_laminaGra, min, max, mean, stdDev);		
			valores56[lamina]=mean;
			//print("ini: "+ini+"valor de mean " + mean + "\n");
			ini +=14; 
		};

	};
	return valores56;
	
};

function cover595to56_gap(valores595) { 
// function description
    valores56 = newArray(56);
	//vecindad_laminaGra = newArray(14);
	//vecindad_laminaPeq = newArray(7);
	ini = 4;
	//laminas de 1 cm las 12 primeras y las 12 ultimas
	for (lamina = 0; lamina < 56; lamina++) {
		if (lamina < 12 ) {
			vecindad_laminaGra = Array.slice(valores595,ini,ini+10);
			Array.getStatistics(vecindad_laminaGra, min, max, mean, stdDev);		
			valores56[lamina]=mean;
			//print("ini: "+ini+"valor de mean " + mean + "\n");
			Dibuja_Punto("red",1,(mean),ini,(mean),ini+10);
			//Overlay.show;
			ini += 15;	
			if (lamina==11) {
				ini = ini -2;
			}
						
		};
		
		if (11 < lamina && lamina < 44){
			vecindad_laminaPeq = Array.slice(valores595,ini,ini+4);
			Array.getStatistics(vecindad_laminaPeq, min, max, mean, stdDev);		
			valores56[lamina]=mean;
			//print("ini: "+ini+"valor de mean " + mean + "\n");
			Dibuja_Punto("red",1,(mean),ini,(mean),ini+4);
			//Overlay.show;
			ini +=7.5; 
			};
			
		if (lamina > 43) {
			vecindad_laminaGra = Array.slice(valores595,ini,ini+10);
			Array.getStatistics(vecindad_laminaGra, min, max, mean, stdDev);		
			valores56[lamina]=mean;
			Dibuja_Punto("red",1,(mean),ini,(mean),ini+10);
			//Overlay.show;
			
			//print("ini: "+ini+"valor de mean " + mean + "\n");
			ini +=14; 
		};
		
      

	};
	return valores56;
	
};


   //******************************************************************************************************

//main()
close("*")
print("\\Clear");
print("Prueba 1.0.0 QA_StripTest");
print("");
//run("Close")


//seleccion de la carpeta de trabajo
title = "Abrir";
msg = "Seleccionar la carpeta donde se encuentren las imágenes\n de la prueba \"Strip Test\" Prueba de bandas";
waitForUser(title, msg);
dir = getDirectory("Selecciona Carpeta");
list=getFileList(dir);
l=list.length
 

//seleccionar la primera imagen de la carpeta
path=dir+list[0];open(path);
name = File.getName(path); //obtiene el valor del nombre de la imagen

//obtiene datos de la imagen DICOM

Acelerador=getInfo("0008,1010");
fecha=getInfo("0008,0022");	
RTImageLabel = getInfo("3002,0002"); // para identificar si es una prueba con o sin ERROR INTENCIONADO 
tamanodelaImag=getInfo("0028,0011");


tamanodelaImag=parseInt(tamanodelaImag) // String to number

//invertir imagen si es esta tomada en fondo blanco
//obtengo los valores de las esquinas
X_00=getPixel(0, 0)
X_01=getPixel(0, tamanodelaImag-1)
X_10=getPixel(tamanodelaImag-1, 0)
X_11=getPixel(tamanodelaImag-1, tamanodelaImag-1)
//promedio de la estos valores
prom=(X_00 + X_01 + X_10 + X_11)/4
getStatistics(area, mean, min, max, std, histogram)
//si los valores de las esquinas son mayores que el promedio de la imagen invierto
if (prom > mean ) {
	run("Invert");
};

//Rotando la imagen
run("Rotate... ", "angle=-"+0.2+" grid=1 interpolation=Bilinear");


//RECORTANDO LA IMAGEN SE USA LA UN CUADRADO DE MITAD DE AREA

run("Specify...", "width="+tamanodelaImag/2+" height="+tamanodelaImag/2+" x="+tamanodelaImag/2+" y="+tamanodelaImag/2+" constrain centered");
run("Crop");
run("Median...", "radius=2"); //elimnado ruido aleatorio
saveAs("Tiff", getDirectory("temp")+"tmp_cropped.tif");	// saves image to revert to later
run("Enhance Contrast...", "saturated=0.5");// equalize");
//run("Find Edges");

// Almacenando los datos de la imagen en un array
n = tamanodelaImag/2;
ValoresImg = newArray(n*n);
ValoresImg_Filas = newArray(n);
max_c = newArray;
max_c_una_franja = newArray;
prom_c_franjas = newArray;
max_1 = newArray(n);
est_1_1 = newArray(n);
est_2_1 = newArray(n);
est_3_1 = newArray(n);
dif = newArray(n);
prod = newArray(n);
skewness_valo_1 = newArray (n);
kurtosis_valo_1 = newArray (n);


for (i=0;i<n;i++) {
	for (j=0;j<n;j++){
		ValoresImg[(n*i)+j]= getPixel(j,i);	// se almacena todos los valores de imagem n*n	
		ValoresImg_Filas[j]= getPixel(j,i);	// se almacenan los valores de la fila en curso (numero de fila i)
		};
		
		maxLocs_Filas= Array.findMaxima(ValoresImg_Filas, 0.01);//encuantra los valores maximos de la fila i
		maxLocs_Filas=Array.sort(maxLocs_Filas);//los ordeno de menor a mayor o izq a derech
		max_1[i]= maxLocs_Filas[0]; //para plotear despues y comprobar
		
		
		
	if (i==0) {
		Nume_Lineas_H = lengthOf(maxLocs_Filas); //Numero de maximos en la primera fila, para determiar cuatos arreglos de maxi 
			                                     //tengo que crear	
	     };
	     
		prod[i] = 1; // inicializacion en uo para la operacion despues 
		dif[i] = 1;

		
	     //Trabajado para una fila
	     //graficar loa max
	     //encontar la vecindad y los valores HOS  
	     
	    
	     
	for (t = 0; t < Nume_Lineas_H; t++) {
		max_c[t+i*Nume_Lineas_H]=maxLocs_Filas[t]; //array con todos las pisiciones de los maximos
		
		
	     //Dibuja_Punto("red",1,round(maxLocs_Filas[t]),i,round(maxLocs_Filas[t]),i); //ValoresImg_Filas[maxLocs_Filas[0]] cetro de cada franja	
	     	     
	     // probando multiplicar cada maximo en cada fila para graficar depues y ver si da buenos resultados
	     prod[i] *= maxLocs_Filas[t] ;	
	     	     
	     // vecindad
	     vecindad = encuntra_vecindad(maxLocs_Filas[t],ValoresImg_Filas);		     		     
	     Array.getStatistics(vecindad, min, max, mean, stdDev);
	     //vecindad_ordenada = vecindad;
	     //m = mediana(vecindad_ordenada); //NO SE PQ ME ORDENA EL ARREGLE VECINDAD
	     
	     // Diferencia entre el centro de la Gaussiana y el centro de intensidad
	     c = cento_del_GaussianAdjust(vecindad,maxLocs_Filas[t]);
	     //print(i+"  centro del max: "+ maxLocs_Filas[t]+" Centro de Gauss: "+c+" Resta " + (maxLocs_Filas[t]-c));
	     
	     //calculando kurtosis y skewness para la franja t		     
	     if (t == 4) {		     
	     skewness_valo_1 [i]  = skewness(vecindad,mean,stdDev) ;
	     kurtosis_valo_1 [i] = kurtosis(vecindad,mean,stdDev);	
	     		     	     
	     // almacendo la dif para una franja t
	     dif[i]=Math.abs(maxLocs_Filas[t]-c);		     
	     };     		
		     		
         };		
		Overlay.show;
		
		 
};	

// buscando el centro y los limites reales de las franjas
max_c=Array.sort(max_c);
//Array.print(max_c);

for (i = 0; i < Nume_Lineas_H+1; i++) {
	max_c_una_franja = Array.slice(max_c,i*595,(i+1)*595);
	Array.getStatistics(max_c_una_franja, min, max, mean, stdDev);
	pos_56 = newArray;
	pos_56=cover595to56_gap(max_c_una_franja);
	prom_c_franjas = round(mean);
	Dibuja_Punto("green",1,prom_c_franjas-1.5,0,prom_c_franjas-1.5,595); // porque 1 mm equivale a 3 pixeles aprox
	Dibuja_Punto("green",1,prom_c_franjas+1.5,0,prom_c_franjas+1.5,595);
	
		
	Overlay.show;
		
}

	//convirtiendo de pixeles a cm
	//reduzco la matriz de 595 a 60 valores
	//normalizar la matriz prod
	Array.getStatistics(prod, min, max, mean, stdDev);
	l = lengthOf(prod);
	for (i = 0; i < l; i++) {
		prod[i] = prod[i]/ max;
	};
	
	prom_56=cover595to56(prod);
	dif_56 = cover595to56(dif);

	dif_56_mm = newArray;
	for (i = 0; i < lengthOf(dif_56); i++) {
		dif_56_mm[i]= dif_56[i]*(1/3);
	}


	//dif_56_mm = dif_56*(1/3);
	
	//Graficar el producto
Plot.create("Producto", "X-axis Label", "Y-axis Label")
Plot.add("line",prod);
Plot.show()
//Array.show(prod);

//Graficar el skewness
//Array.show(skewness_valo_1);
Plot.create("Skewness", "X-axis Label", "Y-axis Label");
Plot.add("line", skewness_valo_1);
Plot.show()
//Array.show(kurtosis_valo_1);

//Graficar el kurtosis
Plot.create("Kurtosis", "X-axis Label", "Y-axis Label");
Plot.add("line", kurtosis_valo_1);
Plot.show()



//grafica diferencia para linea igual a t	
Plot.create("Diferencia", "X-axis Label", "Y-axis Label");
Plot.add("line",dif);
Plot.show()
//Plot.add("error bars",dif);
//Graficar el producto
//Plot.create("Producto", "X-axis Label", "Y-axis Label", prod)
//Array.show(prod);

//grafica de los proemdios por cada lamina 60 valores
Plot.create("prod 56", "X-axis Label", "Y-axis Label");
Plot.add("line",prom_56);
Plot.add("separated bar",prom_56);
Plot.show()

//grafica de las diferencias entre el cetro de la gauss y el max de intensidad por cada lamina 60 valores
Plot.create("Dif 56", "lamina", "diefencia en pixel");
Plot.add("line",dif_56);
Plot.add("separated bar",dif_56);
Plot.show()


//grafica de las diferencias entre el cetro de la gauss y el max de intensidad por cada lamina 60 valores
Plot.create("Dif 56 mm", "lamina", "diferencia en mm");
//Plot.add("line",dif_56);
Plot.add("separated bar",dif_56_mm);
Plot.show()


//Dibujar las areas determinadas como errores
x0=100;
x1=200;
y0=100;
y1=200;

//Resalta_A_Error("red",2,x0,y0);
//Resalta_A_Error("red",2,x1,y1);
//Overlay.show;

//makeSelection("freehand", newArray(100,100,125,125,100), newArray(100,125,125,100,100));
//setKeyDown("shift");
//makeSelection("freehand", newArray(200,200,225,225,200), newArray(200,225,225,200,200));

//Plot.create("Title", "X-axis Label", "Y-axis Label",ValoresImg)

//Datos_de_la_Imag(Acelerador,fecha,RTImageLabel);
print("return 0");
	





