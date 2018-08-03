USE BelcorpDominicana

UPDATE certificadodigitalconfig 
	SET ciudad = 'Rep�blica Dominicana', 
	asunto = 'Certificado Paz y Salvo', 
	descripcionestado = 'se encuentra a PAZ Y SALVO con la Compa��a', 
	razonsocial = 'TRANSBEL S.R.L', 
	ruc = '', 
	telefono = 'Tel 1- 809 200-5235 y 809- 620-5235', 
	urlfirma = 'http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/Matriz/DO/FirmaGiselleHernandez.JPG', 
	responsable = 'Giselle Hern�ndez', 
	cargo = 'Supervisor Cobranzas', 
	documento = 'http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/Matriz/DO/SELLO-RECTANGULO.JPG' 
WHERE  configid = 1 

UPDATE certificadodigitalconfig 
	SET ciudad = 'Santo Domingo', 
	asunto = 'Certificado comercial', 
	descripcionestado = 'Rep�blica Dominicana', 
	razonsocial = 'TRANSBEL S.R.L', 
	ruc = '', 
	telefono = '1-809 200-5235 y 809-620-5235', 
	urlfirma = 'http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/Matriz/DO/FirmaGiselleHernandez.JPG' , 
	responsable = 'Giselle Hern�ndez', 
	cargo = 'Rep�blica Dominicana', 
	documento = 'http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/Matriz/DO/SELLO-RECTANGULO.JPG' 
WHERE  configid = 2 

-----------

USE BelcorpPuertoRico

UPDATE certificadodigitalconfig 
	SET ciudad = 'Puerto Rico', 
	asunto = 'Certificado Paz y Salvo', 
	descripcionestado = 'se encuentra a PAZ Y SALVO con', 
	razonsocial = 'Ventura Corporation Limited', 
	ruc = '', 
	telefono = 'Tel. 787-641-3235 Ext. 1091', 
	urlfirma = 'http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/Matriz/DO/FirmaGiselleHernandez.JPG', 
	responsable = 'Giselle Hern�ndez', 
	cargo = 'Supervisor Cobranzas', 
	documento = 'http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/Matriz/PR/SELLO-REDONDO.JPG' 
WHERE  configid = 1 

UPDATE certificadodigitalconfig 
	SET ciudad = '', 
	asunto = 'Certificado comercial', 
	descripcionestado = '', 
	razonsocial = 'TRANSBEL S.R.L', 
	ruc = '', 
	telefono = '1- 866-366-3235 y 787-622-3235', 
	urlfirma = 'http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/Matriz/DO/FirmaGiselleHernandez.JPG' , 
	responsable = 'Giselle Hern�ndez', 
	cargo = 'Puerto Rico', 
	documento = 'http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/Matriz/PR/SELLO-REDONDO.JPG' 
WHERE  configid = 2