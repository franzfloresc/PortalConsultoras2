USE BelcorpPeru
GO

Declare @TablaLogicaID int = 231;

IF(NOT EXISTS(SELECT TablaLogicaID FROM TablaLogica WHERE TablaLogicaID=@TablaLogicaID))
BEGIN
	INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES(@TablaLogicaID, 'Registro de Historias')

	
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES(cast(@TablaLogicaID as varchar(3)) + '01', @TablaLogicaID, 'MatrizAppConsultora', 'AppConsultora,Historia,Icono', NULL);

	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES(cast(@TablaLogicaID as varchar(3)) + '02', @TablaLogicaID, 'CodigoHistoriasResumen', 'HISTORIAS_RESUMEN', NULL);

	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES(cast(@TablaLogicaID as varchar(3)) + '03', @TablaLogicaID, 'CodigoHist', 'HIST', NULL);

	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES(cast(@TablaLogicaID as varchar(3)) + '04', @TablaLogicaID, 'HistAnchoAlto', '315,315', NULL);

	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES(cast(@TablaLogicaID as varchar(3)) + '05', @TablaLogicaID, 'HistAnchoAltoDetalle', '1200,1920', NULL);

	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES(cast(@TablaLogicaID as varchar(3)) + '06', @TablaLogicaID, 'HistUrlMiniatura', '{0}/AppConsultora/{1}/Historia/Icono/', NULL);

	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES(cast(@TablaLogicaID as varchar(3)) + '07', @TablaLogicaID, 'HistLimitDetMensaje', 'Tener en cuenta el límite de Historias, su número máximo es de {0}, si supera el límite se desactiva la primera Historia.', NULL);
END

GO

USE BelcorpMexico
GO

Declare @TablaLogicaID int = 231;

IF(NOT EXISTS(SELECT TablaLogicaID FROM TablaLogica WHERE TablaLogicaID=@TablaLogicaID))
BEGIN
	INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES(@TablaLogicaID, 'Registro de Historias')

	
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES(cast(@TablaLogicaID as varchar(3)) + '01', @TablaLogicaID, 'MatrizAppConsultora', 'AppConsultora,Historia,Icono', NULL);

	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES(cast(@TablaLogicaID as varchar(3)) + '02', @TablaLogicaID, 'CodigoHistoriasResumen', 'HISTORIAS_RESUMEN', NULL);

	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES(cast(@TablaLogicaID as varchar(3)) + '03', @TablaLogicaID, 'CodigoHist', 'HIST', NULL);

	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES(cast(@TablaLogicaID as varchar(3)) + '04', @TablaLogicaID, 'HistAnchoAlto', '315,315', NULL);

	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES(cast(@TablaLogicaID as varchar(3)) + '05', @TablaLogicaID, 'HistAnchoAltoDetalle', '1200,1920', NULL);

	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES(cast(@TablaLogicaID as varchar(3)) + '06', @TablaLogicaID, 'HistUrlMiniatura', '{0}/AppConsultora/{1}/Historia/Icono/', NULL);

	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES(cast(@TablaLogicaID as varchar(3)) + '07', @TablaLogicaID, 'HistLimitDetMensaje', 'Tener en cuenta el límite de Historias, su número máximo es de {0}, si supera el límite se desactiva la primera Historia.', NULL);
END

GO

USE BelcorpColombia
GO

Declare @TablaLogicaID int = 231;

IF(NOT EXISTS(SELECT TablaLogicaID FROM TablaLogica WHERE TablaLogicaID=@TablaLogicaID))
BEGIN
	INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES(@TablaLogicaID, 'Registro de Historias')

	
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES(cast(@TablaLogicaID as varchar(3)) + '01', @TablaLogicaID, 'MatrizAppConsultora', 'AppConsultora,Historia,Icono', NULL);

	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES(cast(@TablaLogicaID as varchar(3)) + '02', @TablaLogicaID, 'CodigoHistoriasResumen', 'HISTORIAS_RESUMEN', NULL);

	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES(cast(@TablaLogicaID as varchar(3)) + '03', @TablaLogicaID, 'CodigoHist', 'HIST', NULL);

	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES(cast(@TablaLogicaID as varchar(3)) + '04', @TablaLogicaID, 'HistAnchoAlto', '315,315', NULL);

	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES(cast(@TablaLogicaID as varchar(3)) + '05', @TablaLogicaID, 'HistAnchoAltoDetalle', '1200,1920', NULL);

	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES(cast(@TablaLogicaID as varchar(3)) + '06', @TablaLogicaID, 'HistUrlMiniatura', '{0}/AppConsultora/{1}/Historia/Icono/', NULL);

	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES(cast(@TablaLogicaID as varchar(3)) + '07', @TablaLogicaID, 'HistLimitDetMensaje', 'Tener en cuenta el límite de Historias, su número máximo es de {0}, si supera el límite se desactiva la primera Historia.', NULL);
END

GO

USE BelcorpSalvador
GO

Declare @TablaLogicaID int = 231;

IF(NOT EXISTS(SELECT TablaLogicaID FROM TablaLogica WHERE TablaLogicaID=@TablaLogicaID))
BEGIN
	INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES(@TablaLogicaID, 'Registro de Historias')

	
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES(cast(@TablaLogicaID as varchar(3)) + '01', @TablaLogicaID, 'MatrizAppConsultora', 'AppConsultora,Historia,Icono', NULL);

	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES(cast(@TablaLogicaID as varchar(3)) + '02', @TablaLogicaID, 'CodigoHistoriasResumen', 'HISTORIAS_RESUMEN', NULL);

	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES(cast(@TablaLogicaID as varchar(3)) + '03', @TablaLogicaID, 'CodigoHist', 'HIST', NULL);

	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES(cast(@TablaLogicaID as varchar(3)) + '04', @TablaLogicaID, 'HistAnchoAlto', '315,315', NULL);

	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES(cast(@TablaLogicaID as varchar(3)) + '05', @TablaLogicaID, 'HistAnchoAltoDetalle', '1200,1920', NULL);

	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES(cast(@TablaLogicaID as varchar(3)) + '06', @TablaLogicaID, 'HistUrlMiniatura', '{0}/AppConsultora/{1}/Historia/Icono/', NULL);

	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES(cast(@TablaLogicaID as varchar(3)) + '07', @TablaLogicaID, 'HistLimitDetMensaje', 'Tener en cuenta el límite de Historias, su número máximo es de {0}, si supera el límite se desactiva la primera Historia.', NULL);
END

GO

USE BelcorpPuertoRico
GO

Declare @TablaLogicaID int = 231;

IF(NOT EXISTS(SELECT TablaLogicaID FROM TablaLogica WHERE TablaLogicaID=@TablaLogicaID))
BEGIN
	INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES(@TablaLogicaID, 'Registro de Historias')

	
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES(cast(@TablaLogicaID as varchar(3)) + '01', @TablaLogicaID, 'MatrizAppConsultora', 'AppConsultora,Historia,Icono', NULL);

	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES(cast(@TablaLogicaID as varchar(3)) + '02', @TablaLogicaID, 'CodigoHistoriasResumen', 'HISTORIAS_RESUMEN', NULL);

	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES(cast(@TablaLogicaID as varchar(3)) + '03', @TablaLogicaID, 'CodigoHist', 'HIST', NULL);

	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES(cast(@TablaLogicaID as varchar(3)) + '04', @TablaLogicaID, 'HistAnchoAlto', '315,315', NULL);

	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES(cast(@TablaLogicaID as varchar(3)) + '05', @TablaLogicaID, 'HistAnchoAltoDetalle', '1200,1920', NULL);

	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES(cast(@TablaLogicaID as varchar(3)) + '06', @TablaLogicaID, 'HistUrlMiniatura', '{0}/AppConsultora/{1}/Historia/Icono/', NULL);

	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES(cast(@TablaLogicaID as varchar(3)) + '07', @TablaLogicaID, 'HistLimitDetMensaje', 'Tener en cuenta el límite de Historias, su número máximo es de {0}, si supera el límite se desactiva la primera Historia.', NULL);
END

GO

USE BelcorpPanama
GO

Declare @TablaLogicaID int = 231;

IF(NOT EXISTS(SELECT TablaLogicaID FROM TablaLogica WHERE TablaLogicaID=@TablaLogicaID))
BEGIN
	INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES(@TablaLogicaID, 'Registro de Historias')

	
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES(cast(@TablaLogicaID as varchar(3)) + '01', @TablaLogicaID, 'MatrizAppConsultora', 'AppConsultora,Historia,Icono', NULL);

	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES(cast(@TablaLogicaID as varchar(3)) + '02', @TablaLogicaID, 'CodigoHistoriasResumen', 'HISTORIAS_RESUMEN', NULL);

	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES(cast(@TablaLogicaID as varchar(3)) + '03', @TablaLogicaID, 'CodigoHist', 'HIST', NULL);

	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES(cast(@TablaLogicaID as varchar(3)) + '04', @TablaLogicaID, 'HistAnchoAlto', '315,315', NULL);

	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES(cast(@TablaLogicaID as varchar(3)) + '05', @TablaLogicaID, 'HistAnchoAltoDetalle', '1200,1920', NULL);

	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES(cast(@TablaLogicaID as varchar(3)) + '06', @TablaLogicaID, 'HistUrlMiniatura', '{0}/AppConsultora/{1}/Historia/Icono/', NULL);

	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES(cast(@TablaLogicaID as varchar(3)) + '07', @TablaLogicaID, 'HistLimitDetMensaje', 'Tener en cuenta el límite de Historias, su número máximo es de {0}, si supera el límite se desactiva la primera Historia.', NULL);
END

GO

USE BelcorpGuatemala
GO

Declare @TablaLogicaID int = 231;

IF(NOT EXISTS(SELECT TablaLogicaID FROM TablaLogica WHERE TablaLogicaID=@TablaLogicaID))
BEGIN
	INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES(@TablaLogicaID, 'Registro de Historias')

	
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES(cast(@TablaLogicaID as varchar(3)) + '01', @TablaLogicaID, 'MatrizAppConsultora', 'AppConsultora,Historia,Icono', NULL);

	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES(cast(@TablaLogicaID as varchar(3)) + '02', @TablaLogicaID, 'CodigoHistoriasResumen', 'HISTORIAS_RESUMEN', NULL);

	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES(cast(@TablaLogicaID as varchar(3)) + '03', @TablaLogicaID, 'CodigoHist', 'HIST', NULL);

	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES(cast(@TablaLogicaID as varchar(3)) + '04', @TablaLogicaID, 'HistAnchoAlto', '315,315', NULL);

	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES(cast(@TablaLogicaID as varchar(3)) + '05', @TablaLogicaID, 'HistAnchoAltoDetalle', '1200,1920', NULL);

	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES(cast(@TablaLogicaID as varchar(3)) + '06', @TablaLogicaID, 'HistUrlMiniatura', '{0}/AppConsultora/{1}/Historia/Icono/', NULL);

	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES(cast(@TablaLogicaID as varchar(3)) + '07', @TablaLogicaID, 'HistLimitDetMensaje', 'Tener en cuenta el límite de Historias, su número máximo es de {0}, si supera el límite se desactiva la primera Historia.', NULL);
END

GO

USE BelcorpEcuador
GO

Declare @TablaLogicaID int = 231;

IF(NOT EXISTS(SELECT TablaLogicaID FROM TablaLogica WHERE TablaLogicaID=@TablaLogicaID))
BEGIN
	INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES(@TablaLogicaID, 'Registro de Historias')

	
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES(cast(@TablaLogicaID as varchar(3)) + '01', @TablaLogicaID, 'MatrizAppConsultora', 'AppConsultora,Historia,Icono', NULL);

	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES(cast(@TablaLogicaID as varchar(3)) + '02', @TablaLogicaID, 'CodigoHistoriasResumen', 'HISTORIAS_RESUMEN', NULL);

	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES(cast(@TablaLogicaID as varchar(3)) + '03', @TablaLogicaID, 'CodigoHist', 'HIST', NULL);

	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES(cast(@TablaLogicaID as varchar(3)) + '04', @TablaLogicaID, 'HistAnchoAlto', '315,315', NULL);

	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES(cast(@TablaLogicaID as varchar(3)) + '05', @TablaLogicaID, 'HistAnchoAltoDetalle', '1200,1920', NULL);

	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES(cast(@TablaLogicaID as varchar(3)) + '06', @TablaLogicaID, 'HistUrlMiniatura', '{0}/AppConsultora/{1}/Historia/Icono/', NULL);

	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES(cast(@TablaLogicaID as varchar(3)) + '07', @TablaLogicaID, 'HistLimitDetMensaje', 'Tener en cuenta el límite de Historias, su número máximo es de {0}, si supera el límite se desactiva la primera Historia.', NULL);
END

GO

USE BelcorpDominicana
GO

Declare @TablaLogicaID int = 231;

IF(NOT EXISTS(SELECT TablaLogicaID FROM TablaLogica WHERE TablaLogicaID=@TablaLogicaID))
BEGIN
	INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES(@TablaLogicaID, 'Registro de Historias')

	
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES(cast(@TablaLogicaID as varchar(3)) + '01', @TablaLogicaID, 'MatrizAppConsultora', 'AppConsultora,Historia,Icono', NULL);

	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES(cast(@TablaLogicaID as varchar(3)) + '02', @TablaLogicaID, 'CodigoHistoriasResumen', 'HISTORIAS_RESUMEN', NULL);

	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES(cast(@TablaLogicaID as varchar(3)) + '03', @TablaLogicaID, 'CodigoHist', 'HIST', NULL);

	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES(cast(@TablaLogicaID as varchar(3)) + '04', @TablaLogicaID, 'HistAnchoAlto', '315,315', NULL);

	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES(cast(@TablaLogicaID as varchar(3)) + '05', @TablaLogicaID, 'HistAnchoAltoDetalle', '1200,1920', NULL);

	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES(cast(@TablaLogicaID as varchar(3)) + '06', @TablaLogicaID, 'HistUrlMiniatura', '{0}/AppConsultora/{1}/Historia/Icono/', NULL);

	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES(cast(@TablaLogicaID as varchar(3)) + '07', @TablaLogicaID, 'HistLimitDetMensaje', 'Tener en cuenta el límite de Historias, su número máximo es de {0}, si supera el límite se desactiva la primera Historia.', NULL);
END

GO

USE BelcorpCostaRica
GO

Declare @TablaLogicaID int = 231;

IF(NOT EXISTS(SELECT TablaLogicaID FROM TablaLogica WHERE TablaLogicaID=@TablaLogicaID))
BEGIN
	INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES(@TablaLogicaID, 'Registro de Historias')

	
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES(cast(@TablaLogicaID as varchar(3)) + '01', @TablaLogicaID, 'MatrizAppConsultora', 'AppConsultora,Historia,Icono', NULL);

	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES(cast(@TablaLogicaID as varchar(3)) + '02', @TablaLogicaID, 'CodigoHistoriasResumen', 'HISTORIAS_RESUMEN', NULL);

	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES(cast(@TablaLogicaID as varchar(3)) + '03', @TablaLogicaID, 'CodigoHist', 'HIST', NULL);

	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES(cast(@TablaLogicaID as varchar(3)) + '04', @TablaLogicaID, 'HistAnchoAlto', '315,315', NULL);

	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES(cast(@TablaLogicaID as varchar(3)) + '05', @TablaLogicaID, 'HistAnchoAltoDetalle', '1200,1920', NULL);

	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES(cast(@TablaLogicaID as varchar(3)) + '06', @TablaLogicaID, 'HistUrlMiniatura', '{0}/AppConsultora/{1}/Historia/Icono/', NULL);

	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES(cast(@TablaLogicaID as varchar(3)) + '07', @TablaLogicaID, 'HistLimitDetMensaje', 'Tener en cuenta el límite de Historias, su número máximo es de {0}, si supera el límite se desactiva la primera Historia.', NULL);
END

GO

USE BelcorpChile
GO

Declare @TablaLogicaID int = 231;

IF(NOT EXISTS(SELECT TablaLogicaID FROM TablaLogica WHERE TablaLogicaID=@TablaLogicaID))
BEGIN
	INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES(@TablaLogicaID, 'Registro de Historias')

	
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES(cast(@TablaLogicaID as varchar(3)) + '01', @TablaLogicaID, 'MatrizAppConsultora', 'AppConsultora,Historia,Icono', NULL);

	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES(cast(@TablaLogicaID as varchar(3)) + '02', @TablaLogicaID, 'CodigoHistoriasResumen', 'HISTORIAS_RESUMEN', NULL);

	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES(cast(@TablaLogicaID as varchar(3)) + '03', @TablaLogicaID, 'CodigoHist', 'HIST', NULL);

	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES(cast(@TablaLogicaID as varchar(3)) + '04', @TablaLogicaID, 'HistAnchoAlto', '315,315', NULL);

	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES(cast(@TablaLogicaID as varchar(3)) + '05', @TablaLogicaID, 'HistAnchoAltoDetalle', '1200,1920', NULL);

	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES(cast(@TablaLogicaID as varchar(3)) + '06', @TablaLogicaID, 'HistUrlMiniatura', '{0}/AppConsultora/{1}/Historia/Icono/', NULL);

	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES(cast(@TablaLogicaID as varchar(3)) + '07', @TablaLogicaID, 'HistLimitDetMensaje', 'Tener en cuenta el límite de Historias, su número máximo es de {0}, si supera el límite se desactiva la primera Historia.', NULL);
END

GO

USE BelcorpBolivia
GO

Declare @TablaLogicaID int = 231;

IF(NOT EXISTS(SELECT TablaLogicaID FROM TablaLogica WHERE TablaLogicaID=@TablaLogicaID))
BEGIN
	INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES(@TablaLogicaID, 'Registro de Historias')

	
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES(cast(@TablaLogicaID as varchar(3)) + '01', @TablaLogicaID, 'MatrizAppConsultora', 'AppConsultora,Historia,Icono', NULL);

	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES(cast(@TablaLogicaID as varchar(3)) + '02', @TablaLogicaID, 'CodigoHistoriasResumen', 'HISTORIAS_RESUMEN', NULL);

	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES(cast(@TablaLogicaID as varchar(3)) + '03', @TablaLogicaID, 'CodigoHist', 'HIST', NULL);

	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES(cast(@TablaLogicaID as varchar(3)) + '04', @TablaLogicaID, 'HistAnchoAlto', '315,315', NULL);

	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES(cast(@TablaLogicaID as varchar(3)) + '05', @TablaLogicaID, 'HistAnchoAltoDetalle', '1200,1920', NULL);

	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES(cast(@TablaLogicaID as varchar(3)) + '06', @TablaLogicaID, 'HistUrlMiniatura', '{0}/AppConsultora/{1}/Historia/Icono/', NULL);

	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES(cast(@TablaLogicaID as varchar(3)) + '07', @TablaLogicaID, 'HistLimitDetMensaje', 'Tener en cuenta el límite de Historias, su número máximo es de {0}, si supera el límite se desactiva la primera Historia.', NULL);
END

GO