Declare @TablaLogicaID int = 231;
INSERT INTO TablaLogica (TablaLogicaID, Descripcion)VALUES(@TablaLogicaID, 'Registro de Historias');

INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)VALUES(cast(@TablaLogicaID as varchar(3)) + '01', @TablaLogicaID, 'MatrizAppConsultora', 'AppConsultora,Historia,Icono', NULL);
INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)VALUES(cast(@TablaLogicaID as varchar(3)) + '02', @TablaLogicaID, 'CodigoHistoriasResumen', 'HISTORIAS_RESUMEN', NULL);
INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)VALUES(cast(@TablaLogicaID as varchar(3)) + '03', @TablaLogicaID, 'CodigoHist', 'HIST', NULL);
INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)VALUES(cast(@TablaLogicaID as varchar(3)) + '04', @TablaLogicaID, 'HistAnchoAlto', '315,315', NULL);
INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)VALUES(cast(@TablaLogicaID as varchar(3)) + '05', @TablaLogicaID, 'HistAnchoAltoDetalle', '1920,1080', NULL);
INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)VALUES(cast(@TablaLogicaID as varchar(3)) + '06', @TablaLogicaID, 'HistUrlMiniatura', '{0}/AppConsultora/{1}/Historia/Icono/', NULL);
INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)VALUES(cast(@TablaLogicaID as varchar(3)) + '07', @TablaLogicaID, 'HistLimitDetMensaje', 'Tener en cuenta el l�mite de Historias, su n�mero m�ximo es de {0}, si supera el l�mite se desactiva la primera Historia.', NULL);
