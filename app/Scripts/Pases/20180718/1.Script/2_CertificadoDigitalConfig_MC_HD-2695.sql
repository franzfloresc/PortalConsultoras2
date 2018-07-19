USE BelcorpDominicana

UPDATE certificadodigitalconfig 
	SET ciudad = 'República Dominicana', 
	asunto = 'Certificado Paz y Salvo', 
	descripcionestado = 'se encuentra a PAZ Y SALVO con la Compañía', 
	razonsocial = 'TRANSBEL S.R.L', 
	ruc = '', 
	telefono = 'Tel 1- 809 200-5235 y 809- 620-5235', 
	urlfirma = 'https://cdn1-prd.somosbelcorp.com/Matriz/DO/FirmaGiselleHernandez.JPG', 
	responsable = 'Giselle Hernández', 
	cargo = 'Supervisor Cobranzas', 
	documento = 'https://cdn1-prd.somosbelcorp.com/Matriz/DO/SELLO-RECTANGULO.JPG' 
WHERE  configid = 1 

UPDATE certificadodigitalconfig 
	SET ciudad = 'Santo Domingo', 
	asunto = 'Certificado comercial', 
	descripcionestado = 'República Dominicana', 
	razonsocial = 'TRANSBEL S.R.L', 
	ruc = '', 
	telefono = '1-809 200-5235 y 809-620-5235', 
	urlfirma = 'https://cdn1-prd.somosbelcorp.com/Matriz/DO/FirmaGiselleHernandez.JPG' , 
	responsable = 'Giselle Hernández', 
	cargo = 'República Dominicana', 
	documento = 'https://cdn1-prd.somosbelcorp.com/Matriz/DO/SELLO-RECTANGULO.JPG' 
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
	urlfirma = 'https://cdn1-prd.somosbelcorp.com/Matriz/DO/FirmaGiselleHernandez.JPG', 
	responsable = 'Giselle Hernández', 
	cargo = 'Supervisor Cobranzas', 
	documento = 'https://cdn1-prd.somosbelcorp.com/Matriz/PR/SELLO-REDONDO.JPG' 
WHERE  configid = 1 

UPDATE certificadodigitalconfig 
	SET ciudad = '', 
	asunto = 'Certificado comercial', 
	descripcionestado = '', 
	razonsocial = 'TRANSBEL S.R.L', 
	ruc = '', 
	telefono = '1- 866-366-3235 y 787-622-3235', 
	urlfirma = 'https://cdn1-prd.somosbelcorp.com/Matriz/DO/FirmaGiselleHernandez.JPG' , 
	responsable = 'Giselle Hernández', 
	cargo = 'Puerto Rico', 
	documento = 'https://cdn1-prd.somosbelcorp.com/Matriz/PR/SELLO-REDONDO.JPG' 
WHERE  configid = 2
