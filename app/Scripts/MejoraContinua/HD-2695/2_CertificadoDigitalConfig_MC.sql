USE BelcorpDominicana

UPDATE certificadodigitalconfig 
	SET ciudad = 'Rep. Dom.', 
	asunto = 'Certificado Paz y Salvo', 
	descripcionestado = 'se encuentra a PAZ Y SALVO con la Compañía', 
	razonsocial = 'TRANSBEL S.R.L', 
	ruc = '', 
	telefono = 'Tel.809-542-5353 Ext. 1091', 
	urlfirma = 'http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/Matriz/DO/FirmaGiselleHernandez.JPG', 
	responsable = '', 
	cargo = 'Supervisor Cobranzas', 
	documento = 'https://image.ibb.co/bFPexT/SELLO_RECTANGULO.jpg' 
WHERE  configid = 1 

UPDATE certificadodigitalconfig 
	SET ciudad = 'Santo Domingo', 
	asunto = 'Certificado comercial', 
	descripcionestado = 'República Dominicana', 
	razonsocial = 'TRANSBEL S.R.L', 
	ruc = '', 
	telefono = '1-809 200-5235 y 809-620-5235', 
	urlfirma = 'http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/Matriz/DO/FirmaGiselleHernandez.JPG' , 
	responsable = 'Giselle Hernández', 
	cargo = 'Rep. Dom.', 
	documento = 'https://image.ibb.co/bFPexT/SELLO_RECTANGULO.jpg' 
WHERE  configid = 2 

-----------

USE BelcorpPuertoRico

UPDATE certificadodigitalconfig 
	SET ciudad = 'Puerto Rico', 
	asunto = 'Certificado Paz y Salvo', 
	descripcionestado = 'se encuentra a PAZ Y SALVO con', 
	razonsocial = 'Ventura Corporation Limited', 
	ruc = '', 
	telefono = 'Te.809-542-5353 Ext. 1091', 
	urlfirma = 'http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/Matriz/DO/FirmaGiselleHernandez.JPG', 
	responsable = '', 
	cargo = 'Supervisor Cobranzas', 
	documento = 'https://image.ibb.co/dVC4Wo/SELLO_REDONDO.jpg' 
WHERE  configid = 1 

UPDATE certificadodigitalconfig 
	SET ciudad = '', 
	asunto = 'Certificado comercial', 
	descripcionestado = '', 
	razonsocial = 'TRANSBEL S.R.L', 
	ruc = '', 
	telefono = '1- 866-366-3235 y 787-622-3235', 
	urlfirma = 'http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/Matriz/DO/FirmaGiselleHernandez.JPG' , 
	responsable = 'Giselle Hernández', 
	cargo = 'Puerto Rico', 
	documento = 'https://image.ibb.co/dVC4Wo/SELLO_REDONDO.jpg' 
WHERE  configid = 2
