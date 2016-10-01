IF NOT EXISTS(SELECT 1 FROM TablaLogica 
          WHERE TablaLogicaID = 88) 
BEGIN
	INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES (88, 'Configuracion Ofertas Revista')
END

IF NOT EXISTS(SELECT 1 FROM TablaLogicaDatos 
          WHERE TablaLogicaDatosID = 9091) 
BEGIN
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (9091, 88, '003', '2')
END
