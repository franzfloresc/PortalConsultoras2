USE BelcorpBolivia
GO

IF EXISTS (
		SELECT 1
		FROM sys.columns
		WHERE Name = N'GrupoID'
			AND Object_ID = Object_ID(N'dbo.CdrWebDetalle')
		)
BEGIN
	ALTER TABLE dbo.CdrWebDetalle

	DROP COLUMN GrupoID
END
GO

USE BelcorpChile
GO

IF EXISTS (
		SELECT 1
		FROM sys.columns
		WHERE Name = N'GrupoID'
			AND Object_ID = Object_ID(N'dbo.CdrWebDetalle')
		)
BEGIN
	ALTER TABLE dbo.CdrWebDetalle

	DROP COLUMN GrupoID
END
GO

USE BelcorpColombia
GO

IF EXISTS (
		SELECT 1
		FROM sys.columns
		WHERE Name = N'GrupoID'
			AND Object_ID = Object_ID(N'dbo.CdrWebDetalle')
		)
BEGIN
	ALTER TABLE dbo.CdrWebDetalle

	DROP COLUMN GrupoID
END
GO

USE BelcorpCostaRica
GO

IF EXISTS (
		SELECT 1
		FROM sys.columns
		WHERE Name = N'GrupoID'
			AND Object_ID = Object_ID(N'dbo.CdrWebDetalle')
		)
BEGIN
	ALTER TABLE dbo.CdrWebDetalle

	DROP COLUMN GrupoID
END
GO

USE BelcorpDominicana
GO

IF EXISTS (
		SELECT 1
		FROM sys.columns
		WHERE Name = N'GrupoID'
			AND Object_ID = Object_ID(N'dbo.CdrWebDetalle')
		)
BEGIN
	ALTER TABLE dbo.CdrWebDetalle

	DROP COLUMN GrupoID
END
GO

USE BelcorpEcuador
GO

IF EXISTS (
		SELECT 1
		FROM sys.columns
		WHERE Name = N'GrupoID'
			AND Object_ID = Object_ID(N'dbo.CdrWebDetalle')
		)
BEGIN
	ALTER TABLE dbo.CdrWebDetalle

	DROP COLUMN GrupoID
END
GO

USE BelcorpGuatemala
GO

IF EXISTS (
		SELECT 1
		FROM sys.columns
		WHERE Name = N'GrupoID'
			AND Object_ID = Object_ID(N'dbo.CdrWebDetalle')
		)
BEGIN
	ALTER TABLE dbo.CdrWebDetalle

	DROP COLUMN GrupoID
END
GO

USE BelcorpMexico
GO

IF EXISTS (
		SELECT 1
		FROM sys.columns
		WHERE Name = N'GrupoID'
			AND Object_ID = Object_ID(N'dbo.CdrWebDetalle')
		)
BEGIN
	ALTER TABLE dbo.CdrWebDetalle

	DROP COLUMN GrupoID
END
GO

USE BelcorpPanama
GO

IF EXISTS (
		SELECT 1
		FROM sys.columns
		WHERE Name = N'GrupoID'
			AND Object_ID = Object_ID(N'dbo.CdrWebDetalle')
		)
BEGIN
	ALTER TABLE dbo.CdrWebDetalle

	DROP COLUMN GrupoID
END
GO

USE BelcorpPeru
GO

IF EXISTS (
		SELECT 1
		FROM sys.columns
		WHERE Name = N'GrupoID'
			AND Object_ID = Object_ID(N'dbo.CdrWebDetalle')
		)
BEGIN
	ALTER TABLE dbo.CdrWebDetalle

	DROP COLUMN GrupoID
END
GO

USE BelcorpPuertoRico
GO

IF EXISTS (
		SELECT 1
		FROM sys.columns
		WHERE Name = N'GrupoID'
			AND Object_ID = Object_ID(N'dbo.CdrWebDetalle')
		)
BEGIN
	ALTER TABLE dbo.CdrWebDetalle

	DROP COLUMN GrupoID
END
GO

USE BelcorpSalvador
GO

IF EXISTS (
		SELECT 1
		FROM sys.columns
		WHERE Name = N'GrupoID'
			AND Object_ID = Object_ID(N'dbo.CdrWebDetalle')
		)
BEGIN
	ALTER TABLE dbo.CdrWebDetalle

	DROP COLUMN GrupoID
END
GO


