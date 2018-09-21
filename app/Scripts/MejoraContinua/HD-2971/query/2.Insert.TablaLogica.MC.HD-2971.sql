USE BelcorpBolivia
GO

DECLARE @IDtablalogicaDestopk		INT = 72;
DECLARE @IDtablalogicaMobile		INT = 73;
DECLARE @IDTablaLogicaDatosDestopk	INT = 14514;
DECLARE @IDTablaLogicaDatosMobile	INT = 14515;

IF (SELECT COUNT(1) FROM dbo.TablaLogica WHERE TablaLogicaID = @IDtablalogicaDestopk) = 0
BEGIN
	INSERT INTO dbo.tablalogica(TablaLogicaID,Descripcion) values (@IDtablalogicaDestopk,'Camino al Exito Destokp');
	INSERT INTO dbo.tablalogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion,Valor) values (@IDTablaLogicaDatosDestopk,@IDtablalogicaDestopk,'01','Activar camino al Exito Destokp','0');
END

IF (SELECT COUNT(1) FROM dbo.TablaLogica WHERE TablaLogicaID = @IDtablalogicaMobile) = 0
BEGIN
	INSERT INTO dbo.tablalogica(TablaLogicaID,Descripcion) values (@IDtablalogicaMobile,'Camino al Exito Mobile');
	INSERT INTO dbo.tablalogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion,Valor) values (@IDTablaLogicaDatosMobile,@IDtablalogicaMobile,'01','Activar camino al Exito Mobile','0');
END

USE BelcorpChile
GO

DECLARE @IDtablalogicaDestopk		INT = 72;
DECLARE @IDtablalogicaMobile		INT = 73;
DECLARE @IDTablaLogicaDatosDestopk	INT = 14514;
DECLARE @IDTablaLogicaDatosMobile	INT = 14515;

IF (SELECT COUNT(1) FROM dbo.TablaLogica WHERE TablaLogicaID = @IDtablalogicaDestopk) = 0
BEGIN
	INSERT INTO dbo.tablalogica(TablaLogicaID,Descripcion) values (@IDtablalogicaDestopk,'Camino al Exito Destokp');
	INSERT INTO dbo.tablalogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion,Valor) values (@IDTablaLogicaDatosDestopk,@IDtablalogicaDestopk,'01','Activar camino al Exito Destokp','0');
END

IF (SELECT COUNT(1) FROM dbo.TablaLogica WHERE TablaLogicaID = @IDtablalogicaMobile) = 0
BEGIN
	INSERT INTO dbo.tablalogica(TablaLogicaID,Descripcion) values (@IDtablalogicaMobile,'Camino al Exito Mobile');
	INSERT INTO dbo.tablalogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion,Valor) values (@IDTablaLogicaDatosMobile,@IDtablalogicaMobile,'01','Activar camino al Exito Mobile','0');
END

USE BelcorpColombia
GO

DECLARE @IDtablalogicaDestopk		INT = 72;
DECLARE @IDtablalogicaMobile		INT = 73;
DECLARE @IDTablaLogicaDatosDestopk	INT = 14514;
DECLARE @IDTablaLogicaDatosMobile	INT = 14515;

IF (SELECT COUNT(1) FROM dbo.TablaLogica WHERE TablaLogicaID = @IDtablalogicaDestopk) = 0
BEGIN
	INSERT INTO dbo.tablalogica(TablaLogicaID,Descripcion) values (@IDtablalogicaDestopk,'Camino al Exito Destokp');
	INSERT INTO dbo.tablalogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion,Valor) values (@IDTablaLogicaDatosDestopk,@IDtablalogicaDestopk,'01','Activar camino al Exito Destokp','0');
END

IF (SELECT COUNT(1) FROM dbo.TablaLogica WHERE TablaLogicaID = @IDtablalogicaMobile) = 0
BEGIN
	INSERT INTO dbo.tablalogica(TablaLogicaID,Descripcion) values (@IDtablalogicaMobile,'Camino al Exito Mobile');
	INSERT INTO dbo.tablalogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion,Valor) values (@IDTablaLogicaDatosMobile,@IDtablalogicaMobile,'01','Activar camino al Exito Mobile','0');
END

USE BelcorpCostaRica
GO

DECLARE @IDtablalogicaDestopk		INT = 72;
DECLARE @IDtablalogicaMobile		INT = 73;
DECLARE @IDTablaLogicaDatosDestopk	INT = 14514;
DECLARE @IDTablaLogicaDatosMobile	INT = 14515;

IF (SELECT COUNT(1) FROM dbo.TablaLogica WHERE TablaLogicaID = @IDtablalogicaDestopk) = 0
BEGIN
	INSERT INTO dbo.tablalogica(TablaLogicaID,Descripcion) values (@IDtablalogicaDestopk,'Camino al Exito Destokp');
	INSERT INTO dbo.tablalogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion,Valor) values (@IDTablaLogicaDatosDestopk,@IDtablalogicaDestopk,'01','Activar camino al Exito Destokp','1');
END

IF (SELECT COUNT(1) FROM dbo.TablaLogica WHERE TablaLogicaID = @IDtablalogicaMobile) = 0
BEGIN
	INSERT INTO dbo.tablalogica(TablaLogicaID,Descripcion) values (@IDtablalogicaMobile,'Camino al Exito Mobile');
	INSERT INTO dbo.tablalogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion,Valor) values (@IDTablaLogicaDatosMobile,@IDtablalogicaMobile,'01','Activar camino al Exito Mobile','1');
END

USE BelcorpDominicana
GO

DECLARE @IDtablalogicaDestopk		INT = 72;
DECLARE @IDtablalogicaMobile		INT = 73;
DECLARE @IDTablaLogicaDatosDestopk	INT = 14514;
DECLARE @IDTablaLogicaDatosMobile	INT = 14515;

IF (SELECT COUNT(1) FROM dbo.TablaLogica WHERE TablaLogicaID = @IDtablalogicaDestopk) = 0
BEGIN
	INSERT INTO dbo.tablalogica(TablaLogicaID,Descripcion) values (@IDtablalogicaDestopk,'Camino al Exito Destokp');
	INSERT INTO dbo.tablalogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion,Valor) values (@IDTablaLogicaDatosDestopk,@IDtablalogicaDestopk,'01','Activar camino al Exito Destokp','0');
END

IF (SELECT COUNT(1) FROM dbo.TablaLogica WHERE TablaLogicaID = @IDtablalogicaMobile) = 0
BEGIN
	INSERT INTO dbo.tablalogica(TablaLogicaID,Descripcion) values (@IDtablalogicaMobile,'Camino al Exito Mobile');
	INSERT INTO dbo.tablalogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion,Valor) values (@IDTablaLogicaDatosMobile,@IDtablalogicaMobile,'01','Activar camino al Exito Mobile','0');
END

USE BelcorpEcuador
GO

DECLARE @IDtablalogicaDestopk		INT = 72;
DECLARE @IDtablalogicaMobile		INT = 73;
DECLARE @IDTablaLogicaDatosDestopk	INT = 14514;
DECLARE @IDTablaLogicaDatosMobile	INT = 14515;

IF (SELECT COUNT(1) FROM dbo.TablaLogica WHERE TablaLogicaID = @IDtablalogicaDestopk) = 0
BEGIN
	INSERT INTO dbo.tablalogica(TablaLogicaID,Descripcion) values (@IDtablalogicaDestopk,'Camino al Exito Destokp');
	INSERT INTO dbo.tablalogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion,Valor) values (@IDTablaLogicaDatosDestopk,@IDtablalogicaDestopk,'01','Activar camino al Exito Destokp','0');
END

IF (SELECT COUNT(1) FROM dbo.TablaLogica WHERE TablaLogicaID = @IDtablalogicaMobile) = 0
BEGIN
	INSERT INTO dbo.tablalogica(TablaLogicaID,Descripcion) values (@IDtablalogicaMobile,'Camino al Exito Mobile');
	INSERT INTO dbo.tablalogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion,Valor) values (@IDTablaLogicaDatosMobile,@IDtablalogicaMobile,'01','Activar camino al Exito Mobile','0');
END

USE BelcorpGuatemala
GO

DECLARE @IDtablalogicaDestopk		INT = 72;
DECLARE @IDtablalogicaMobile		INT = 73;
DECLARE @IDTablaLogicaDatosDestopk	INT = 14514;
DECLARE @IDTablaLogicaDatosMobile	INT = 14515;

IF (SELECT COUNT(1) FROM dbo.TablaLogica WHERE TablaLogicaID = @IDtablalogicaDestopk) = 0
BEGIN
	INSERT INTO dbo.tablalogica(TablaLogicaID,Descripcion) values (@IDtablalogicaDestopk,'Camino al Exito Destokp');
	INSERT INTO dbo.tablalogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion,Valor) values (@IDTablaLogicaDatosDestopk,@IDtablalogicaDestopk,'01','Activar camino al Exito Destokp','0');
END

IF (SELECT COUNT(1) FROM dbo.TablaLogica WHERE TablaLogicaID = @IDtablalogicaMobile) = 0
BEGIN
	INSERT INTO dbo.tablalogica(TablaLogicaID,Descripcion) values (@IDtablalogicaMobile,'Camino al Exito Mobile');
	INSERT INTO dbo.tablalogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion,Valor) values (@IDTablaLogicaDatosMobile,@IDtablalogicaMobile,'01','Activar camino al Exito Mobile','0');
END

USE BelcorpMexico
GO

DECLARE @IDtablalogicaDestopk		INT = 72;
DECLARE @IDtablalogicaMobile		INT = 73;
DECLARE @IDTablaLogicaDatosDestopk	INT = 14514;
DECLARE @IDTablaLogicaDatosMobile	INT = 14515;

IF (SELECT COUNT(1) FROM dbo.TablaLogica WHERE TablaLogicaID = @IDtablalogicaDestopk) = 0
BEGIN
	INSERT INTO dbo.tablalogica(TablaLogicaID,Descripcion) values (@IDtablalogicaDestopk,'Camino al Exito Destokp');
	INSERT INTO dbo.tablalogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion,Valor) values (@IDTablaLogicaDatosDestopk,@IDtablalogicaDestopk,'01','Activar camino al Exito Destokp','0');
END

IF (SELECT COUNT(1) FROM dbo.TablaLogica WHERE TablaLogicaID = @IDtablalogicaMobile) = 0
BEGIN
	INSERT INTO dbo.tablalogica(TablaLogicaID,Descripcion) values (@IDtablalogicaMobile,'Camino al Exito Mobile');
	INSERT INTO dbo.tablalogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion,Valor) values (@IDTablaLogicaDatosMobile,@IDtablalogicaMobile,'01','Activar camino al Exito Mobile','0');
END

USE BelcorpPanama
GO

DECLARE @IDtablalogicaDestopk		INT = 72;
DECLARE @IDtablalogicaMobile		INT = 73;
DECLARE @IDTablaLogicaDatosDestopk	INT = 14514;
DECLARE @IDTablaLogicaDatosMobile	INT = 14515;

IF (SELECT COUNT(1) FROM dbo.TablaLogica WHERE TablaLogicaID = @IDtablalogicaDestopk) = 0
BEGIN
	INSERT INTO dbo.tablalogica(TablaLogicaID,Descripcion) values (@IDtablalogicaDestopk,'Camino al Exito Destokp');
	INSERT INTO dbo.tablalogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion,Valor) values (@IDTablaLogicaDatosDestopk,@IDtablalogicaDestopk,'01','Activar camino al Exito Destokp','0');
END

IF (SELECT COUNT(1) FROM dbo.TablaLogica WHERE TablaLogicaID = @IDtablalogicaMobile) = 0
BEGIN
	INSERT INTO dbo.tablalogica(TablaLogicaID,Descripcion) values (@IDtablalogicaMobile,'Camino al Exito Mobile');
	INSERT INTO dbo.tablalogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion,Valor) values (@IDTablaLogicaDatosMobile,@IDtablalogicaMobile,'01','Activar camino al Exito Mobile','0');
END

USE BelcorpPeru
GO

DECLARE @IDtablalogicaDestopk		INT = 72;
DECLARE @IDtablalogicaMobile		INT = 73;
DECLARE @IDTablaLogicaDatosDestopk	INT = 14514;
DECLARE @IDTablaLogicaDatosMobile	INT = 14515;

IF (SELECT COUNT(1) FROM dbo.TablaLogica WHERE TablaLogicaID = @IDtablalogicaDestopk) = 0
BEGIN
	INSERT INTO dbo.tablalogica(TablaLogicaID,Descripcion) values (@IDtablalogicaDestopk,'Camino al Exito Destokp');
	INSERT INTO dbo.tablalogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion,Valor) values (@IDTablaLogicaDatosDestopk,@IDtablalogicaDestopk,'01','Activar camino al Exito Destokp','0');
END

IF (SELECT COUNT(1) FROM dbo.TablaLogica WHERE TablaLogicaID = @IDtablalogicaMobile) = 0
BEGIN
	INSERT INTO dbo.tablalogica(TablaLogicaID,Descripcion) values (@IDtablalogicaMobile,'Camino al Exito Mobile');
	INSERT INTO dbo.tablalogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion,Valor) values (@IDTablaLogicaDatosMobile,@IDtablalogicaMobile,'01','Activar camino al Exito Mobile','0');
END

USE BelcorpPuertoRico
GO

DECLARE @IDtablalogicaDestopk		INT = 72;
DECLARE @IDtablalogicaMobile		INT = 73;
DECLARE @IDTablaLogicaDatosDestopk	INT = 14514;
DECLARE @IDTablaLogicaDatosMobile	INT = 14515;

IF (SELECT COUNT(1) FROM dbo.TablaLogica WHERE TablaLogicaID = @IDtablalogicaDestopk) = 0
BEGIN
	INSERT INTO dbo.tablalogica(TablaLogicaID,Descripcion) values (@IDtablalogicaDestopk,'Camino al Exito Destokp');
	INSERT INTO dbo.tablalogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion,Valor) values (@IDTablaLogicaDatosDestopk,@IDtablalogicaDestopk,'01','Activar camino al Exito Destokp','0');
END

IF (SELECT COUNT(1) FROM dbo.TablaLogica WHERE TablaLogicaID = @IDtablalogicaMobile) = 0
BEGIN
	INSERT INTO dbo.tablalogica(TablaLogicaID,Descripcion) values (@IDtablalogicaMobile,'Camino al Exito Mobile');
	INSERT INTO dbo.tablalogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion,Valor) values (@IDTablaLogicaDatosMobile,@IDtablalogicaMobile,'01','Activar camino al Exito Mobile','0');
END

USE BelcorpSalvador
GO

DECLARE @IDtablalogicaDestopk		INT = 72;
DECLARE @IDtablalogicaMobile		INT = 73;
DECLARE @IDTablaLogicaDatosDestopk	INT = 14514;
DECLARE @IDTablaLogicaDatosMobile	INT = 14515;

IF (SELECT COUNT(1) FROM dbo.TablaLogica WHERE TablaLogicaID = @IDtablalogicaDestopk) = 0
BEGIN
	INSERT INTO dbo.tablalogica(TablaLogicaID,Descripcion) values (@IDtablalogicaDestopk,'Camino al Exito Destokp');
	INSERT INTO dbo.tablalogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion,Valor) values (@IDTablaLogicaDatosDestopk,@IDtablalogicaDestopk,'01','Activar camino al Exito Destokp','0');
END

IF (SELECT COUNT(1) FROM dbo.TablaLogica WHERE TablaLogicaID = @IDtablalogicaMobile) = 0
BEGIN
	INSERT INTO dbo.tablalogica(TablaLogicaID,Descripcion) values (@IDtablalogicaMobile,'Camino al Exito Mobile');
	INSERT INTO dbo.tablalogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion,Valor) values (@IDTablaLogicaDatosMobile,@IDtablalogicaMobile,'01','Activar camino al Exito Mobile','0');
END
