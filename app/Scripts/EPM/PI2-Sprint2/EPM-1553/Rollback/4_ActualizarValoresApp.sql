
USE BelcorpBolivia
GO

ALTER PROCEDURE [dbo].[ActualizarValoresApp]
AS
BEGIN
	UPDATE EP
	SET 
		EP.NombreComercial = EPT.NombreComercial,
		EP.Descripcion =  EPT.Descripcion,
		EP.Volumen = EPT.Volumen,
		EP.ImagenProducto = EPT.Imagen,
		EP.ImagenBulk = EPT.ImagenBulk,
		EP.NombreBulk = EPT.NombreBulk
	FROM EstrategiaProducto EP
	INNER JOIN EstrategiaProductoTemporalApp EPT ON 
		EP.Campania = EPT.Campania AND EP.SAP = EPT.CodigoSap
END
GO

USE BelcorpChile
GO

ALTER PROCEDURE [dbo].[ActualizarValoresApp]
AS
BEGIN
	UPDATE EP
	SET 
		EP.NombreComercial = EPT.NombreComercial,
		EP.Descripcion =  EPT.Descripcion,
		EP.Volumen = EPT.Volumen,
		EP.ImagenProducto = EPT.Imagen,
		EP.ImagenBulk = EPT.ImagenBulk,
		EP.NombreBulk = EPT.NombreBulk
	FROM EstrategiaProducto EP
	INNER JOIN EstrategiaProductoTemporalApp EPT ON 
		EP.Campania = EPT.Campania AND EP.SAP = EPT.CodigoSap
END
GO

USE BelcorpColombia
GO

ALTER PROCEDURE [dbo].[ActualizarValoresApp]
AS
BEGIN
	UPDATE EP
	SET 
		EP.NombreComercial = EPT.NombreComercial,
		EP.Descripcion =  EPT.Descripcion,
		EP.Volumen = EPT.Volumen,
		EP.ImagenProducto = EPT.Imagen,
		EP.ImagenBulk = EPT.ImagenBulk,
		EP.NombreBulk = EPT.NombreBulk
	FROM EstrategiaProducto EP
	INNER JOIN EstrategiaProductoTemporalApp EPT ON 
		EP.Campania = EPT.Campania AND EP.SAP = EPT.CodigoSap
END
GO

USE BelcorpCostaRica
GO

ALTER PROCEDURE [dbo].[ActualizarValoresApp]
AS
BEGIN
	UPDATE EP
	SET 
		EP.NombreComercial = EPT.NombreComercial,
		EP.Descripcion =  EPT.Descripcion,
		EP.Volumen = EPT.Volumen,
		EP.ImagenProducto = EPT.Imagen,
		EP.ImagenBulk = EPT.ImagenBulk,
		EP.NombreBulk = EPT.NombreBulk
	FROM EstrategiaProducto EP
	INNER JOIN EstrategiaProductoTemporalApp EPT ON 
		EP.Campania = EPT.Campania AND EP.SAP = EPT.CodigoSap
END
GO

USE BelcorpDominicana
GO

ALTER PROCEDURE [dbo].[ActualizarValoresApp]
AS
BEGIN
	UPDATE EP
	SET 
		EP.NombreComercial = EPT.NombreComercial,
		EP.Descripcion =  EPT.Descripcion,
		EP.Volumen = EPT.Volumen,
		EP.ImagenProducto = EPT.Imagen,
		EP.ImagenBulk = EPT.ImagenBulk,
		EP.NombreBulk = EPT.NombreBulk
	FROM EstrategiaProducto EP
	INNER JOIN EstrategiaProductoTemporalApp EPT ON 
		EP.Campania = EPT.Campania AND EP.SAP = EPT.CodigoSap
END
GO

USE BelcorpEcuador
GO

ALTER PROCEDURE [dbo].[ActualizarValoresApp]
AS
BEGIN
	UPDATE EP
	SET 
		EP.NombreComercial = EPT.NombreComercial,
		EP.Descripcion =  EPT.Descripcion,
		EP.Volumen = EPT.Volumen,
		EP.ImagenProducto = EPT.Imagen,
		EP.ImagenBulk = EPT.ImagenBulk,
		EP.NombreBulk = EPT.NombreBulk
	FROM EstrategiaProducto EP
	INNER JOIN EstrategiaProductoTemporalApp EPT ON 
		EP.Campania = EPT.Campania AND EP.SAP = EPT.CodigoSap
END
GO

USE BelcorpGuatemala
GO

ALTER PROCEDURE [dbo].[ActualizarValoresApp]
AS
BEGIN
	UPDATE EP
	SET 
		EP.NombreComercial = EPT.NombreComercial,
		EP.Descripcion =  EPT.Descripcion,
		EP.Volumen = EPT.Volumen,
		EP.ImagenProducto = EPT.Imagen,
		EP.ImagenBulk = EPT.ImagenBulk,
		EP.NombreBulk = EPT.NombreBulk
	FROM EstrategiaProducto EP
	INNER JOIN EstrategiaProductoTemporalApp EPT ON 
		EP.Campania = EPT.Campania AND EP.SAP = EPT.CodigoSap
END
GO

USE BelcorpMexico
GO

ALTER PROCEDURE [dbo].[ActualizarValoresApp]
AS
BEGIN
	UPDATE EP
	SET 
		EP.NombreComercial = EPT.NombreComercial,
		EP.Descripcion =  EPT.Descripcion,
		EP.Volumen = EPT.Volumen,
		EP.ImagenProducto = EPT.Imagen,
		EP.ImagenBulk = EPT.ImagenBulk,
		EP.NombreBulk = EPT.NombreBulk
	FROM EstrategiaProducto EP
	INNER JOIN EstrategiaProductoTemporalApp EPT ON 
		EP.Campania = EPT.Campania AND EP.SAP = EPT.CodigoSap
END
GO

USE BelcorpPanama
GO

ALTER PROCEDURE [dbo].[ActualizarValoresApp]
AS
BEGIN
	UPDATE EP
	SET 
		EP.NombreComercial = EPT.NombreComercial,
		EP.Descripcion =  EPT.Descripcion,
		EP.Volumen = EPT.Volumen,
		EP.ImagenProducto = EPT.Imagen,
		EP.ImagenBulk = EPT.ImagenBulk,
		EP.NombreBulk = EPT.NombreBulk
	FROM EstrategiaProducto EP
	INNER JOIN EstrategiaProductoTemporalApp EPT ON 
		EP.Campania = EPT.Campania AND EP.SAP = EPT.CodigoSap
END
GO

USE BelcorpPeru
GO

ALTER PROCEDURE [dbo].[ActualizarValoresApp]
AS
BEGIN
	UPDATE EP
	SET 
		EP.NombreComercial = EPT.NombreComercial,
		EP.Descripcion =  EPT.Descripcion,
		EP.Volumen = EPT.Volumen,
		EP.ImagenProducto = EPT.Imagen,
		EP.ImagenBulk = EPT.ImagenBulk,
		EP.NombreBulk = EPT.NombreBulk
	FROM EstrategiaProducto EP
	INNER JOIN EstrategiaProductoTemporalApp EPT ON 
		EP.Campania = EPT.Campania AND EP.SAP = EPT.CodigoSap
END
GO

USE BelcorpPuertoRico
GO

ALTER PROCEDURE [dbo].[ActualizarValoresApp]
AS
BEGIN
	UPDATE EP
	SET 
		EP.NombreComercial = EPT.NombreComercial,
		EP.Descripcion =  EPT.Descripcion,
		EP.Volumen = EPT.Volumen,
		EP.ImagenProducto = EPT.Imagen,
		EP.ImagenBulk = EPT.ImagenBulk,
		EP.NombreBulk = EPT.NombreBulk
	FROM EstrategiaProducto EP
	INNER JOIN EstrategiaProductoTemporalApp EPT ON 
		EP.Campania = EPT.Campania AND EP.SAP = EPT.CodigoSap
END
GO

USE BelcorpSalvador
GO

ALTER PROCEDURE [dbo].[ActualizarValoresApp]
AS
BEGIN
	UPDATE EP
	SET 
		EP.NombreComercial = EPT.NombreComercial,
		EP.Descripcion =  EPT.Descripcion,
		EP.Volumen = EPT.Volumen,
		EP.ImagenProducto = EPT.Imagen,
		EP.ImagenBulk = EPT.ImagenBulk,
		EP.NombreBulk = EPT.NombreBulk
	FROM EstrategiaProducto EP
	INNER JOIN EstrategiaProductoTemporalApp EPT ON 
		EP.Campania = EPT.Campania AND EP.SAP = EPT.CodigoSap
END
GO
