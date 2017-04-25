
USE BelcorpBolivia
GO

IF EXISTS(SELECT 1 FROM sys.columns
WHERE Name = N'DocumentoIdentidad' AND OBJECT_ID = OBJECT_ID(N'Usuario'))
BEGIN
	ALTER TABLE Usuario
	DROP COLUMN DocumentoIdentidad
END
GO

ALTER TABLE dbo.Usuario
ADD DocumentoIdentidad VARCHAR(20);
GO

/*end*/

USE BelcorpChile
GO

IF EXISTS(SELECT 1 FROM sys.columns
WHERE Name = N'DocumentoIdentidad' AND OBJECT_ID = OBJECT_ID(N'Usuario'))
BEGIN
	ALTER TABLE Usuario
	DROP COLUMN DocumentoIdentidad
END
GO

ALTER TABLE dbo.Usuario
ADD DocumentoIdentidad VARCHAR(20);
GO
/*end*/

USE BelcorpColombia
GO

IF EXISTS(SELECT 1 FROM sys.columns
WHERE Name = N'DocumentoIdentidad' AND OBJECT_ID = OBJECT_ID(N'Usuario'))
BEGIN
	ALTER TABLE Usuario
	DROP COLUMN DocumentoIdentidad
END
GO

ALTER TABLE dbo.Usuario
ADD DocumentoIdentidad VARCHAR(20);
GO
/*end*/

USE BelcorpCostaRica
GO

IF EXISTS(SELECT 1 FROM sys.columns
WHERE Name = N'DocumentoIdentidad' AND OBJECT_ID = OBJECT_ID(N'Usuario'))
BEGIN
	ALTER TABLE Usuario
	DROP COLUMN DocumentoIdentidad
END
GO

ALTER TABLE dbo.Usuario
ADD DocumentoIdentidad VARCHAR(20);
GO
/*end*/

USE BelcorpDominicana
GO

IF EXISTS(SELECT 1 FROM sys.columns
WHERE Name = N'DocumentoIdentidad' AND OBJECT_ID = OBJECT_ID(N'Usuario'))
BEGIN
	ALTER TABLE Usuario
	DROP COLUMN DocumentoIdentidad
END
GO

ALTER TABLE dbo.Usuario
ADD DocumentoIdentidad VARCHAR(20);
GO
/*end*/

USE BelcorpEcuador
GO

IF EXISTS(SELECT 1 FROM sys.columns
WHERE Name = N'DocumentoIdentidad' AND OBJECT_ID = OBJECT_ID(N'Usuario'))
BEGIN
	ALTER TABLE Usuario
	DROP COLUMN DocumentoIdentidad
END
GO

ALTER TABLE dbo.Usuario
ADD DocumentoIdentidad VARCHAR(20);
GO
/*end*/

USE BelcorpGuatemala
GO

IF EXISTS(SELECT 1 FROM sys.columns
WHERE Name = N'DocumentoIdentidad' AND OBJECT_ID = OBJECT_ID(N'Usuario'))
BEGIN
	ALTER TABLE Usuario
	DROP COLUMN DocumentoIdentidad
END
GO

ALTER TABLE dbo.Usuario
ADD DocumentoIdentidad VARCHAR(20);
GO
/*end*/

USE BelcorpMexico
GO

IF EXISTS(SELECT 1 FROM sys.columns
WHERE Name = N'DocumentoIdentidad' AND OBJECT_ID = OBJECT_ID(N'Usuario'))
BEGIN
	ALTER TABLE Usuario
	DROP COLUMN DocumentoIdentidad
END
GO

ALTER TABLE dbo.Usuario
ADD DocumentoIdentidad VARCHAR(20);
GO
/*end*/

USE BelcorpPanama
GO

IF EXISTS(SELECT 1 FROM sys.columns
WHERE Name = N'DocumentoIdentidad' AND OBJECT_ID = OBJECT_ID(N'Usuario'))
BEGIN
	ALTER TABLE Usuario
	DROP COLUMN DocumentoIdentidad
END
GO

ALTER TABLE dbo.Usuario
ADD DocumentoIdentidad VARCHAR(20);
GO
/*end*/

USE BelcorpPeru
GO

IF EXISTS(SELECT 1 FROM sys.columns
WHERE Name = N'DocumentoIdentidad' AND OBJECT_ID = OBJECT_ID(N'Usuario'))
BEGIN
	ALTER TABLE Usuario
	DROP COLUMN DocumentoIdentidad
END
GO

ALTER TABLE dbo.Usuario
ADD DocumentoIdentidad VARCHAR(20);
GO
/*end*/

USE BelcorpPuertoRico
GO

IF EXISTS(SELECT 1 FROM sys.columns
WHERE Name = N'DocumentoIdentidad' AND OBJECT_ID = OBJECT_ID(N'Usuario'))
BEGIN
	ALTER TABLE Usuario
	DROP COLUMN DocumentoIdentidad
END
GO

ALTER TABLE dbo.Usuario
ADD DocumentoIdentidad VARCHAR(20);
GO
/*end*/

USE BelcorpSalvador
GO

IF EXISTS(SELECT 1 FROM sys.columns
WHERE Name = N'DocumentoIdentidad' AND OBJECT_ID = OBJECT_ID(N'Usuario'))
BEGIN
	ALTER TABLE Usuario
	DROP COLUMN DocumentoIdentidad
END
GO

ALTER TABLE dbo.Usuario
ADD DocumentoIdentidad VARCHAR(20);
GO
/*end*/

USE BelcorpVenezuela
GO

IF EXISTS(SELECT 1 FROM sys.columns
WHERE Name = N'DocumentoIdentidad' AND OBJECT_ID = OBJECT_ID(N'Usuario'))
BEGIN
	ALTER TABLE Usuario
	DROP COLUMN DocumentoIdentidad
END
GO

ALTER TABLE dbo.Usuario
ADD DocumentoIdentidad VARCHAR(20);
GO
