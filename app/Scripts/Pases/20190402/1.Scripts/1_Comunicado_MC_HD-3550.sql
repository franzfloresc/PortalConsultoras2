﻿USE BelcorpBolivia
GO

IF NOT EXISTS (
		SELECT 1
		FROM sys.columns
		WHERE Name = N'TipoComunicado'
			AND Object_ID = Object_ID(N'dbo.Comunicado')
		)
BEGIN
	ALTER TABLE dbo.Comunicado ADD TipoComunicado INT NULL
END
GO

USE BelcorpChile
GO

IF NOT EXISTS (
		SELECT 1
		FROM sys.columns
		WHERE Name = N'TipoComunicado'
			AND Object_ID = Object_ID(N'dbo.Comunicado')
		)
BEGIN
	ALTER TABLE dbo.Comunicado ADD TipoComunicado INT NULL
END
GO

USE BelcorpColombia
GO

IF NOT EXISTS (
		SELECT 1
		FROM sys.columns
		WHERE Name = N'TipoComunicado'
			AND Object_ID = Object_ID(N'dbo.Comunicado')
		)
BEGIN
	ALTER TABLE dbo.Comunicado ADD TipoComunicado INT NULL
END
GO

USE BelcorpCostaRica
GO

IF NOT EXISTS (
		SELECT 1
		FROM sys.columns
		WHERE Name = N'TipoComunicado'
			AND Object_ID = Object_ID(N'dbo.Comunicado')
		)
BEGIN
	ALTER TABLE dbo.Comunicado ADD TipoComunicado INT NULL
END
GO

USE BelcorpDominicana
GO

IF NOT EXISTS (
		SELECT 1
		FROM sys.columns
		WHERE Name = N'TipoComunicado'
			AND Object_ID = Object_ID(N'dbo.Comunicado')
		)
BEGIN
	ALTER TABLE dbo.Comunicado ADD TipoComunicado INT NULL
END
GO

USE BelcorpEcuador
GO

IF NOT EXISTS (
		SELECT 1
		FROM sys.columns
		WHERE Name = N'TipoComunicado'
			AND Object_ID = Object_ID(N'dbo.Comunicado')
		)
BEGIN
	ALTER TABLE dbo.Comunicado ADD TipoComunicado INT NULL
END
GO

USE BelcorpGuatemala
GO

IF NOT EXISTS (
		SELECT 1
		FROM sys.columns
		WHERE Name = N'TipoComunicado'
			AND Object_ID = Object_ID(N'dbo.Comunicado')
		)
BEGIN
	ALTER TABLE dbo.Comunicado ADD TipoComunicado INT NULL
END
GO

USE BelcorpMexico
GO

IF NOT EXISTS (
		SELECT 1
		FROM sys.columns
		WHERE Name = N'TipoComunicado'
			AND Object_ID = Object_ID(N'dbo.Comunicado')
		)
BEGIN
	ALTER TABLE dbo.Comunicado ADD TipoComunicado INT NULL
END
GO

USE BelcorpPanama
GO

IF NOT EXISTS (
		SELECT 1
		FROM sys.columns
		WHERE Name = N'TipoComunicado'
			AND Object_ID = Object_ID(N'dbo.Comunicado')
		)
BEGIN
	ALTER TABLE dbo.Comunicado ADD TipoComunicado INT NULL
END
GO

USE BelcorpPeru
GO

IF NOT EXISTS (
		SELECT 1
		FROM sys.columns
		WHERE Name = N'TipoComunicado'
			AND Object_ID = Object_ID(N'dbo.Comunicado')
		)
BEGIN
	ALTER TABLE dbo.Comunicado ADD TipoComunicado INT NULL
END
GO

USE BelcorpPuertoRico
GO

IF NOT EXISTS (
		SELECT 1
		FROM sys.columns
		WHERE Name = N'TipoComunicado'
			AND Object_ID = Object_ID(N'dbo.Comunicado')
		)
BEGIN
	ALTER TABLE dbo.Comunicado ADD TipoComunicado INT NULL
END
GO

USE BelcorpSalvador
GO

IF NOT EXISTS (
		SELECT 1
		FROM sys.columns
		WHERE Name = N'TipoComunicado'
			AND Object_ID = Object_ID(N'dbo.Comunicado')
		)
BEGIN
	ALTER TABLE dbo.Comunicado ADD TipoComunicado INT NULL
END
GO

