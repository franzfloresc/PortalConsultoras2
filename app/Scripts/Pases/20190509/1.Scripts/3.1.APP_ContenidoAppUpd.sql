USE BelcorpPeru
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContenidoAppUpd]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ContenidoAppUpd]
GO

CREATE PROCEDURE [dbo].[ContenidoAppUpd]
@IdContenido INT,
@UrlMiniatura VARCHAR(100),
@DesdeCampania INT
AS
BEGIN
		UPDATE ContenidoApp 
		SET
		UrlMiniatura = @UrlMiniatura,
		DesdeCampania = @DesdeCampania
		WHERE 
		IdContenido = @IdContenido;
END

GO

USE BelcorpMexico
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContenidoAppUpd]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ContenidoAppUpd]
GO

CREATE PROCEDURE [dbo].[ContenidoAppUpd]
@IdContenido INT,
@UrlMiniatura VARCHAR(100),
@DesdeCampania INT
AS
BEGIN
		UPDATE ContenidoApp 
		SET
		UrlMiniatura = @UrlMiniatura,
		DesdeCampania = @DesdeCampania
		WHERE 
		IdContenido = @IdContenido;
END

GO

USE BelcorpColombia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContenidoAppUpd]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ContenidoAppUpd
GO

CREATE PROCEDURE [dbo].[ContenidoAppUpd]
@IdContenido INT,
@UrlMiniatura VARCHAR(100),
@DesdeCampania INT
AS
BEGIN
		UPDATE ContenidoApp 
		SET
		UrlMiniatura = @UrlMiniatura,
		DesdeCampania = @DesdeCampania
		WHERE 
		IdContenido = @IdContenido;
END

GO

USE BelcorpSalvador
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContenidoAppUpd]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ContenidoAppUpd
GO

CREATE PROCEDURE [dbo].[ContenidoAppUpd]
@IdContenido INT,
@UrlMiniatura VARCHAR(100),
@DesdeCampania INT
AS
BEGIN
		UPDATE ContenidoApp 
		SET
		UrlMiniatura = @UrlMiniatura,
		DesdeCampania = @DesdeCampania
		WHERE 
		IdContenido = @IdContenido;
END

GO

USE BelcorpPuertoRico
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContenidoAppUpd]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ContenidoAppUpd
GO

CREATE PROCEDURE [dbo].[ContenidoAppUpd]
@IdContenido INT,
@UrlMiniatura VARCHAR(100),
@DesdeCampania INT
AS
BEGIN
		UPDATE ContenidoApp 
		SET
		UrlMiniatura = @UrlMiniatura,
		DesdeCampania = @DesdeCampania
		WHERE 
		IdContenido = @IdContenido;
END

GO

USE BelcorpPanama
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContenidoAppUpd]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ContenidoAppUpd
GO

CREATE PROCEDURE [dbo].[ContenidoAppUpd]
@IdContenido INT,
@UrlMiniatura VARCHAR(100),
@DesdeCampania INT
AS
BEGIN
		UPDATE ContenidoApp 
		SET
		UrlMiniatura = @UrlMiniatura,
		DesdeCampania = @DesdeCampania
		WHERE 
		IdContenido = @IdContenido;
END

GO

USE BelcorpGuatemala
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContenidoAppUpd]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ContenidoAppUpd
GO

CREATE PROCEDURE [dbo].[ContenidoAppUpd]
@IdContenido INT,
@UrlMiniatura VARCHAR(100),
@DesdeCampania INT
AS
BEGIN
		UPDATE ContenidoApp 
		SET
		UrlMiniatura = @UrlMiniatura,
		DesdeCampania = @DesdeCampania
		WHERE 
		IdContenido = @IdContenido;
END

GO

USE BelcorpEcuador
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContenidoAppUpd]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ContenidoAppUpd
GO

CREATE PROCEDURE [dbo].[ContenidoAppUpd]
@IdContenido INT,
@UrlMiniatura VARCHAR(100),
@DesdeCampania INT
AS
BEGIN
		UPDATE ContenidoApp 
		SET
		UrlMiniatura = @UrlMiniatura,
		DesdeCampania = @DesdeCampania
		WHERE 
		IdContenido = @IdContenido;
END

GO

USE BelcorpDominicana
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContenidoAppUpd]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ContenidoAppUpd
GO

CREATE PROCEDURE [dbo].[ContenidoAppUpd]
@IdContenido INT,
@UrlMiniatura VARCHAR(100),
@DesdeCampania INT
AS
BEGIN
		UPDATE ContenidoApp 
		SET
		UrlMiniatura = @UrlMiniatura,
		DesdeCampania = @DesdeCampania
		WHERE 
		IdContenido = @IdContenido;
END

GO

USE BelcorpCostaRica
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContenidoAppUpd]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ContenidoAppUpd
GO

CREATE PROCEDURE [dbo].[ContenidoAppUpd]
@IdContenido INT,
@UrlMiniatura VARCHAR(100),
@DesdeCampania INT
AS
BEGIN
		UPDATE ContenidoApp 
		SET
		UrlMiniatura = @UrlMiniatura,
		DesdeCampania = @DesdeCampania
		WHERE 
		IdContenido = @IdContenido;
END

GO

USE BelcorpChile
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContenidoAppUpd]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ContenidoAppUpd
GO

CREATE PROCEDURE [dbo].[ContenidoAppUpd]
@IdContenido INT,
@UrlMiniatura VARCHAR(100),
@DesdeCampania INT
AS
BEGIN
		UPDATE ContenidoApp 
		SET
		UrlMiniatura = @UrlMiniatura,
		DesdeCampania = @DesdeCampania
		WHERE 
		IdContenido = @IdContenido;
END

GO

USE BelcorpBolivia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContenidoAppUpd]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ContenidoAppUpd
GO

CREATE PROCEDURE [dbo].[ContenidoAppUpd]
@IdContenido INT,
@UrlMiniatura VARCHAR(100),
@DesdeCampania INT
AS
BEGIN
		UPDATE ContenidoApp 
		SET
		UrlMiniatura = @UrlMiniatura,
		DesdeCampania = @DesdeCampania
		WHERE 
		IdContenido = @IdContenido;
END

GO

