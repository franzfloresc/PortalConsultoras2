USE BelcorpBolivia
GO

IF EXISTS (
		SELECT 1
		FROM sys.columns
		WHERE Name = N'TipoComunicado'
			AND Object_ID = Object_ID(N'dbo.Comunicado')
		)
BEGIN
	ALTER TABLE dbo.Comunicado

	DROP COLUMN TipoComunicado
END
GO

USE BelcorpChile
GO

IF EXISTS (
		SELECT 1
		FROM sys.columns
		WHERE Name = N'TipoComunicado'
			AND Object_ID = Object_ID(N'dbo.Comunicado')
		)
BEGIN
	ALTER TABLE dbo.Comunicado

	DROP COLUMN TipoComunicado
END
GO

USE BelcorpColombia
GO

IF EXISTS (
		SELECT 1
		FROM sys.columns
		WHERE Name = N'TipoComunicado'
			AND Object_ID = Object_ID(N'dbo.Comunicado')
		)
BEGIN
	ALTER TABLE dbo.Comunicado

	DROP COLUMN TipoComunicado
END
GO

USE BelcorpCostaRica
GO

IF EXISTS (
		SELECT 1
		FROM sys.columns
		WHERE Name = N'TipoComunicado'
			AND Object_ID = Object_ID(N'dbo.Comunicado')
		)
BEGIN
	ALTER TABLE dbo.Comunicado

	DROP COLUMN TipoComunicado
END
GO

USE BelcorpDominicana
GO

IF EXISTS (
		SELECT 1
		FROM sys.columns
		WHERE Name = N'TipoComunicado'
			AND Object_ID = Object_ID(N'dbo.Comunicado')
		)
BEGIN
	ALTER TABLE dbo.Comunicado

	DROP COLUMN TipoComunicado
END
GO

USE BelcorpEcuador
GO

IF EXISTS (
		SELECT 1
		FROM sys.columns
		WHERE Name = N'TipoComunicado'
			AND Object_ID = Object_ID(N'dbo.Comunicado')
		)
BEGIN
	ALTER TABLE dbo.Comunicado

	DROP COLUMN TipoComunicado
END
GO

USE BelcorpGuatemala
GO

IF EXISTS (
		SELECT 1
		FROM sys.columns
		WHERE Name = N'TipoComunicado'
			AND Object_ID = Object_ID(N'dbo.Comunicado')
		)
BEGIN
	ALTER TABLE dbo.Comunicado

	DROP COLUMN TipoComunicado
END
GO

USE BelcorpMexico
GO

IF EXISTS (
		SELECT 1
		FROM sys.columns
		WHERE Name = N'TipoComunicado'
			AND Object_ID = Object_ID(N'dbo.Comunicado')
		)
BEGIN
	ALTER TABLE dbo.Comunicado

	DROP COLUMN TipoComunicado
END
GO

USE BelcorpPanama
GO

IF EXISTS (
		SELECT 1
		FROM sys.columns
		WHERE Name = N'TipoComunicado'
			AND Object_ID = Object_ID(N'dbo.Comunicado')
		)
BEGIN
	ALTER TABLE dbo.Comunicado

	DROP COLUMN TipoComunicado
END
GO

USE BelcorpPeru
GO

IF EXISTS (
		SELECT 1
		FROM sys.columns
		WHERE Name = N'TipoComunicado'
			AND Object_ID = Object_ID(N'dbo.Comunicado')
		)
BEGIN
	ALTER TABLE dbo.Comunicado

	DROP COLUMN TipoComunicado
END
GO

USE BelcorpPuertoRico
GO

IF EXISTS (
		SELECT 1
		FROM sys.columns
		WHERE Name = N'TipoComunicado'
			AND Object_ID = Object_ID(N'dbo.Comunicado')
		)
BEGIN
	ALTER TABLE dbo.Comunicado

	DROP COLUMN TipoComunicado
END
GO

USE BelcorpSalvador
GO

IF EXISTS (
		SELECT 1
		FROM sys.columns
		WHERE Name = N'TipoComunicado'
			AND Object_ID = Object_ID(N'dbo.Comunicado')
		)
BEGIN
	ALTER TABLE dbo.Comunicado

	DROP COLUMN TipoComunicado
END
GO





