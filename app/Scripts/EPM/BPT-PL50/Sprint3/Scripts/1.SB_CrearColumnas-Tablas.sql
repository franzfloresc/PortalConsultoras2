
-- CREANDO COLUMNAS EN LA TABLA ESTRATEGIA PRODUCTO --
IF NOT EXISTS(SELECT 1 FROM sys.columns WHERE Name = N'NombreBulk' AND Object_ID = Object_ID(N'dbo.EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	ADD NombreComercial VARCHAR(MAX),
		Descripcion VARCHAR(MAX),
		Volumen VARCHAR(50),
		ImagenBulk VARCHAR(200),
		NombreBulk VARCHAR(200);
	PRINT 'COLUMNAS ESTRATEGIA PRODUCTO CREADO'
	SELECT TOP 100 * FROM EstrategiaProducto
END

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='EstrategiaTemporalApp' AND xtype='U')
BEGIN
    CREATE TABLE EstrategiaProductoTemporalApp (
		ID INT IDENTITY(1,1) PRIMARY KEY,
		IsoPais VARCHAR(5),
		Campania INT,
		CodigoSap VARCHAR(20),
		NombreComercial VARCHAR(MAX),
		Descripcion VARCHAR(MAX),
		Volumen VARCHAR(50),
		ImagenBulk VARCHAR(200),
		NombreBulk VARCHAR(200)
    )
END
GO