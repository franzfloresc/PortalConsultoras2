USE BelcorpBolivia
GO

DECLARE @IDtablalogicaDestopk		INT = 72;
DECLARE @IDtablalogicaMobile		INT = 73;
DECLARE @IDTablaLogicaDatosDestopk	INT = 7201;
DECLARE @IDTablaLogicaDatosMobile	INT = 7301;

IF (SELECT COUNT(1) FROM dbo.TablaLogica WHERE TablaLogicaID = @IDtablalogicaDestopk) > 0
BEGIN
	DELETE FROM dbo.tablalogicaDatos WHERE TablaLogicaDatosID = @IDTablaLogicaDatosDestopk;
	DELETE FROM dbo.tablalogica WHERE TablaLogicaID = @IDtablalogicaDestopk;
END

IF (SELECT COUNT(1) FROM dbo.TablaLogica WHERE TablaLogicaID = @IDtablalogicaMobile) > 0
BEGIN
	DELETE FROM dbo.tablalogicaDatos WHERE TablaLogicaDatosID = @IDTablaLogicaDatosMobile;
	DELETE FROM dbo.tablalogica WHERE TablaLogicaID = @IDtablalogicaMobile;
END

USE BelcorpChile
GO

DECLARE @IDtablalogicaDestopk		INT = 72;
DECLARE @IDtablalogicaMobile		INT = 73;
DECLARE @IDTablaLogicaDatosDestopk	INT = 7201;
DECLARE @IDTablaLogicaDatosMobile	INT = 7301;

IF (SELECT COUNT(1) FROM dbo.TablaLogica WHERE TablaLogicaID = @IDtablalogicaDestopk) > 0
BEGIN
	DELETE FROM dbo.tablalogicaDatos WHERE TablaLogicaDatosID = @IDTablaLogicaDatosDestopk;
	DELETE FROM dbo.tablalogica WHERE TablaLogicaID = @IDtablalogicaDestopk;
END

IF (SELECT COUNT(1) FROM dbo.TablaLogica WHERE TablaLogicaID = @IDtablalogicaMobile) > 0
BEGIN
	DELETE FROM dbo.tablalogicaDatos WHERE TablaLogicaDatosID = @IDTablaLogicaDatosMobile;
	DELETE FROM dbo.tablalogica WHERE TablaLogicaID = @IDtablalogicaMobile;
END

USE BelcorpColombia
GO

DECLARE @IDtablalogicaDestopk		INT = 72;
DECLARE @IDtablalogicaMobile		INT = 73;
DECLARE @IDTablaLogicaDatosDestopk	INT = 7201;
DECLARE @IDTablaLogicaDatosMobile	INT = 7301;

IF (SELECT COUNT(1) FROM dbo.TablaLogica WHERE TablaLogicaID = @IDtablalogicaDestopk) > 0
BEGIN
	DELETE FROM dbo.tablalogicaDatos WHERE TablaLogicaDatosID = @IDTablaLogicaDatosDestopk;
	DELETE FROM dbo.tablalogica WHERE TablaLogicaID = @IDtablalogicaDestopk;
END

IF (SELECT COUNT(1) FROM dbo.TablaLogica WHERE TablaLogicaID = @IDtablalogicaMobile) > 0
BEGIN
	DELETE FROM dbo.tablalogicaDatos WHERE TablaLogicaDatosID = @IDTablaLogicaDatosMobile;
	DELETE FROM dbo.tablalogica WHERE TablaLogicaID = @IDtablalogicaMobile;
END

USE BelcorpCostaRica
GO

DECLARE @IDtablalogicaDestopk		INT = 72;
DECLARE @IDtablalogicaMobile		INT = 73;
DECLARE @IDTablaLogicaDatosDestopk	INT = 7201;
DECLARE @IDTablaLogicaDatosMobile	INT = 7301;

IF (SELECT COUNT(1) FROM dbo.TablaLogica WHERE TablaLogicaID = @IDtablalogicaDestopk) > 0
BEGIN
	DELETE FROM dbo.tablalogicaDatos WHERE TablaLogicaDatosID = @IDTablaLogicaDatosDestopk;
	DELETE FROM dbo.tablalogica WHERE TablaLogicaID = @IDtablalogicaDestopk;
END

IF (SELECT COUNT(1) FROM dbo.TablaLogica WHERE TablaLogicaID = @IDtablalogicaMobile) > 0
BEGIN
	DELETE FROM dbo.tablalogicaDatos WHERE TablaLogicaDatosID = @IDTablaLogicaDatosMobile;
	DELETE FROM dbo.tablalogica WHERE TablaLogicaID = @IDtablalogicaMobile;
END

USE BelcorpDominicana
GO

DECLARE @IDtablalogicaDestopk		INT = 72;
DECLARE @IDtablalogicaMobile		INT = 73;
DECLARE @IDTablaLogicaDatosDestopk	INT = 7201;
DECLARE @IDTablaLogicaDatosMobile	INT = 7301;

IF (SELECT COUNT(1) FROM dbo.TablaLogica WHERE TablaLogicaID = @IDtablalogicaDestopk) > 0
BEGIN
	DELETE FROM dbo.tablalogicaDatos WHERE TablaLogicaDatosID = @IDTablaLogicaDatosDestopk;
	DELETE FROM dbo.tablalogica WHERE TablaLogicaID = @IDtablalogicaDestopk;
END

IF (SELECT COUNT(1) FROM dbo.TablaLogica WHERE TablaLogicaID = @IDtablalogicaMobile) > 0
BEGIN
	DELETE FROM dbo.tablalogicaDatos WHERE TablaLogicaDatosID = @IDTablaLogicaDatosMobile;
	DELETE FROM dbo.tablalogica WHERE TablaLogicaID = @IDtablalogicaMobile;
END

USE BelcorpEcuador
GO

DECLARE @IDtablalogicaDestopk		INT = 72;
DECLARE @IDtablalogicaMobile		INT = 73;
DECLARE @IDTablaLogicaDatosDestopk	INT = 7201;
DECLARE @IDTablaLogicaDatosMobile	INT = 7301;

IF (SELECT COUNT(1) FROM dbo.TablaLogica WHERE TablaLogicaID = @IDtablalogicaDestopk) > 0
BEGIN
	DELETE FROM dbo.tablalogicaDatos WHERE TablaLogicaDatosID = @IDTablaLogicaDatosDestopk;
	DELETE FROM dbo.tablalogica WHERE TablaLogicaID = @IDtablalogicaDestopk;
END

IF (SELECT COUNT(1) FROM dbo.TablaLogica WHERE TablaLogicaID = @IDtablalogicaMobile) > 0
BEGIN
	DELETE FROM dbo.tablalogicaDatos WHERE TablaLogicaDatosID = @IDTablaLogicaDatosMobile;
	DELETE FROM dbo.tablalogica WHERE TablaLogicaID = @IDtablalogicaMobile;
END
USE BelcorpGuatemala
GO

DECLARE @IDtablalogicaDestopk		INT = 72;
DECLARE @IDtablalogicaMobile		INT = 73;
DECLARE @IDTablaLogicaDatosDestopk	INT = 7201;
DECLARE @IDTablaLogicaDatosMobile	INT = 7301;

IF (SELECT COUNT(1) FROM dbo.TablaLogica WHERE TablaLogicaID = @IDtablalogicaDestopk) > 0
BEGIN
	DELETE FROM dbo.tablalogicaDatos WHERE TablaLogicaDatosID = @IDTablaLogicaDatosDestopk;
	DELETE FROM dbo.tablalogica WHERE TablaLogicaID = @IDtablalogicaDestopk;
END

IF (SELECT COUNT(1) FROM dbo.TablaLogica WHERE TablaLogicaID = @IDtablalogicaMobile) > 0
BEGIN
	DELETE FROM dbo.tablalogicaDatos WHERE TablaLogicaDatosID = @IDTablaLogicaDatosMobile;
	DELETE FROM dbo.tablalogica WHERE TablaLogicaID = @IDtablalogicaMobile;
END

USE BelcorpMexico
GO

DECLARE @IDtablalogicaDestopk		INT = 72;
DECLARE @IDtablalogicaMobile		INT = 73;
DECLARE @IDTablaLogicaDatosDestopk	INT = 7201;
DECLARE @IDTablaLogicaDatosMobile	INT = 7301;

IF (SELECT COUNT(1) FROM dbo.TablaLogica WHERE TablaLogicaID = @IDtablalogicaDestopk) > 0
BEGIN
	DELETE FROM dbo.tablalogicaDatos WHERE TablaLogicaDatosID = @IDTablaLogicaDatosDestopk;
	DELETE FROM dbo.tablalogica WHERE TablaLogicaID = @IDtablalogicaDestopk;
END

IF (SELECT COUNT(1) FROM dbo.TablaLogica WHERE TablaLogicaID = @IDtablalogicaMobile) > 0
BEGIN
	DELETE FROM dbo.tablalogicaDatos WHERE TablaLogicaDatosID = @IDTablaLogicaDatosMobile;
	DELETE FROM dbo.tablalogica WHERE TablaLogicaID = @IDtablalogicaMobile;
END

USE BelcorpPanama
GO

DECLARE @IDtablalogicaDestopk		INT = 72;
DECLARE @IDtablalogicaMobile		INT = 73;
DECLARE @IDTablaLogicaDatosDestopk	INT = 7201;
DECLARE @IDTablaLogicaDatosMobile	INT = 7301;

IF (SELECT COUNT(1) FROM dbo.TablaLogica WHERE TablaLogicaID = @IDtablalogicaDestopk) > 0
BEGIN
	DELETE FROM dbo.tablalogicaDatos WHERE TablaLogicaDatosID = @IDTablaLogicaDatosDestopk;
	DELETE FROM dbo.tablalogica WHERE TablaLogicaID = @IDtablalogicaDestopk;
END

IF (SELECT COUNT(1) FROM dbo.TablaLogica WHERE TablaLogicaID = @IDtablalogicaMobile) > 0
BEGIN
	DELETE FROM dbo.tablalogicaDatos WHERE TablaLogicaDatosID = @IDTablaLogicaDatosMobile;
	DELETE FROM dbo.tablalogica WHERE TablaLogicaID = @IDtablalogicaMobile;
END
USE BelcorpPeru
GO

DECLARE @IDtablalogicaDestopk		INT = 72;
DECLARE @IDtablalogicaMobile		INT = 73;
DECLARE @IDTablaLogicaDatosDestopk	INT = 7201;
DECLARE @IDTablaLogicaDatosMobile	INT = 7301;

IF (SELECT COUNT(1) FROM dbo.TablaLogica WHERE TablaLogicaID = @IDtablalogicaDestopk) > 0
BEGIN
	DELETE FROM dbo.tablalogicaDatos WHERE TablaLogicaDatosID = @IDTablaLogicaDatosDestopk;
	DELETE FROM dbo.tablalogica WHERE TablaLogicaID = @IDtablalogicaDestopk;
END

IF (SELECT COUNT(1) FROM dbo.TablaLogica WHERE TablaLogicaID = @IDtablalogicaMobile) > 0
BEGIN
	DELETE FROM dbo.tablalogicaDatos WHERE TablaLogicaDatosID = @IDTablaLogicaDatosMobile;
	DELETE FROM dbo.tablalogica WHERE TablaLogicaID = @IDtablalogicaMobile;
END

USE BelcorpPuertoRico
GO

DECLARE @IDtablalogicaDestopk		INT = 72;
DECLARE @IDtablalogicaMobile		INT = 73;
DECLARE @IDTablaLogicaDatosDestopk	INT = 7201;
DECLARE @IDTablaLogicaDatosMobile	INT = 7301;

IF (SELECT COUNT(1) FROM dbo.TablaLogica WHERE TablaLogicaID = @IDtablalogicaDestopk) > 0
BEGIN
	DELETE FROM dbo.tablalogicaDatos WHERE TablaLogicaDatosID = @IDTablaLogicaDatosDestopk;
	DELETE FROM dbo.tablalogica WHERE TablaLogicaID = @IDtablalogicaDestopk;
END

IF (SELECT COUNT(1) FROM dbo.TablaLogica WHERE TablaLogicaID = @IDtablalogicaMobile) > 0
BEGIN
	DELETE FROM dbo.tablalogicaDatos WHERE TablaLogicaDatosID = @IDTablaLogicaDatosMobile;
	DELETE FROM dbo.tablalogica WHERE TablaLogicaID = @IDtablalogicaMobile;
END

USE BelcorpSalvador
GO

DECLARE @IDtablalogicaDestopk		INT = 72;
DECLARE @IDtablalogicaMobile		INT = 73;
DECLARE @IDTablaLogicaDatosDestopk	INT = 7201;
DECLARE @IDTablaLogicaDatosMobile	INT = 7301;

IF (SELECT COUNT(1) FROM dbo.TablaLogica WHERE TablaLogicaID = @IDtablalogicaDestopk) > 0
BEGIN
	DELETE FROM dbo.tablalogicaDatos WHERE TablaLogicaDatosID = @IDTablaLogicaDatosDestopk;
	DELETE FROM dbo.tablalogica WHERE TablaLogicaID = @IDtablalogicaDestopk;
END

IF (SELECT COUNT(1) FROM dbo.TablaLogica WHERE TablaLogicaID = @IDtablalogicaMobile) > 0
BEGIN
	DELETE FROM dbo.tablalogicaDatos WHERE TablaLogicaDatosID = @IDTablaLogicaDatosMobile;
	DELETE FROM dbo.tablalogica WHERE TablaLogicaID = @IDtablalogicaMobile;
END
