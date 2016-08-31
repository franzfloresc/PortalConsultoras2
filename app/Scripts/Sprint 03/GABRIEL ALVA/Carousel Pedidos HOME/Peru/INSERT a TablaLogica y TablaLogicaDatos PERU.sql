  IF NOT EXISTS (SELECT TablaLogicaID FROM TablaLogica WHERE TablaLogicaID = 87)
  BEGIN
	INSERT INTO TablaLogica (TablaLogicaID, Descripcion) VALUES (87, 'Carousel Liquidaciones Home')
  END

  IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 8701)
  BEGIN
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion) VALUES (8701, 87, 1, 'Cantidad de productos a cargar')
  END
  GO