USE BelcorpPeru
GO

/* InsMetaConsultora */
IF (OBJECT_ID('InsMetaConsultora') IS NOT NULL)
  DROP PROCEDURE [dbo].[InsMetaConsultora]
GO

CREATE PROCEDURE [dbo].[InsMetaConsultora] (
	@CodigoUsuario VARCHAR(20),
	@CodigoMeta VARCHAR(20),
	@ValorMeta VARCHAR(256) )
AS
BEGIN
	
	SELECT TOP 1 @CodigoUsuario = U.CODIGOUSUARIO
	FROM dbo.Usuario U WITH(NOLOCK)
		WHERE (U.CODIGOCONSULTORA = @CodigoUsuario OR U.DOCUMENTOIDENTIDAD = @CodigoUsuario OR U.CODIGOUSUARIO = @CodigoUsuario)

	IF EXISTS(SELECT 1 FROM dbo.MetaConsultora (NOLOCK) WHERE CodigoUsuario = @CodigoUsuario AND CodigoMeta = @CodigoMeta)
	BEGIN
		UPDATE dbo.MetaConsultora
		SET ValorMeta = @ValorMeta,
			FechaActualizacion = GETDATE()
		WHERE CodigoUsuario = @CodigoUsuario AND CodigoMeta = @CodigoMeta
	END
	ELSE
	BEGIN
		INSERT INTO dbo.MetaConsultora( CodigoUsuario, CodigoMeta, ValorMeta, FechaActualizacion)
		VALUES( @CodigoUsuario, @CodigoMeta, @ValorMeta, GETDATE() )
	END
END
GO

USE BelcorpMexico
GO

/* InsMetaConsultora */
IF (OBJECT_ID('InsMetaConsultora') IS NOT NULL)
  DROP PROCEDURE [dbo].[InsMetaConsultora]
GO

CREATE PROCEDURE [dbo].[InsMetaConsultora] (
	@CodigoUsuario VARCHAR(20),
	@CodigoMeta VARCHAR(20),
	@ValorMeta VARCHAR(256) )
AS
BEGIN
	
	SELECT TOP 1 @CodigoUsuario = U.CODIGOUSUARIO
	FROM dbo.Usuario U WITH(NOLOCK)
		WHERE (U.CODIGOCONSULTORA = @CodigoUsuario OR U.DOCUMENTOIDENTIDAD = @CodigoUsuario OR U.CODIGOUSUARIO = @CodigoUsuario)

	IF EXISTS(SELECT 1 FROM dbo.MetaConsultora (NOLOCK) WHERE CodigoUsuario = @CodigoUsuario AND CodigoMeta = @CodigoMeta)
	BEGIN
		UPDATE dbo.MetaConsultora
		SET ValorMeta = @ValorMeta,
			FechaActualizacion = GETDATE()
		WHERE CodigoUsuario = @CodigoUsuario AND CodigoMeta = @CodigoMeta
	END
	ELSE
	BEGIN
		INSERT INTO dbo.MetaConsultora( CodigoUsuario, CodigoMeta, ValorMeta, FechaActualizacion)
		VALUES( @CodigoUsuario, @CodigoMeta, @ValorMeta, GETDATE() )
	END
END
GO

USE BelcorpColombia
GO

/* InsMetaConsultora */
IF (OBJECT_ID('InsMetaConsultora') IS NOT NULL)
  DROP PROCEDURE [dbo].[InsMetaConsultora]
GO

CREATE PROCEDURE [dbo].[InsMetaConsultora] (
	@CodigoUsuario VARCHAR(20),
	@CodigoMeta VARCHAR(20),
	@ValorMeta VARCHAR(256) )
AS
BEGIN
	
	SELECT TOP 1 @CodigoUsuario = U.CODIGOUSUARIO
	FROM dbo.Usuario U WITH(NOLOCK)
		WHERE (U.CODIGOCONSULTORA = @CodigoUsuario OR U.DOCUMENTOIDENTIDAD = @CodigoUsuario OR U.CODIGOUSUARIO = @CodigoUsuario)

	IF EXISTS(SELECT 1 FROM dbo.MetaConsultora (NOLOCK) WHERE CodigoUsuario = @CodigoUsuario AND CodigoMeta = @CodigoMeta)
	BEGIN
		UPDATE dbo.MetaConsultora
		SET ValorMeta = @ValorMeta,
			FechaActualizacion = GETDATE()
		WHERE CodigoUsuario = @CodigoUsuario AND CodigoMeta = @CodigoMeta
	END
	ELSE
	BEGIN
		INSERT INTO dbo.MetaConsultora( CodigoUsuario, CodigoMeta, ValorMeta, FechaActualizacion)
		VALUES( @CodigoUsuario, @CodigoMeta, @ValorMeta, GETDATE() )
	END
END
GO

USE BelcorpSalvador
GO

/* InsMetaConsultora */
IF (OBJECT_ID('InsMetaConsultora') IS NOT NULL)
  DROP PROCEDURE [dbo].[InsMetaConsultora]
GO

CREATE PROCEDURE [dbo].[InsMetaConsultora] (
	@CodigoUsuario VARCHAR(20),
	@CodigoMeta VARCHAR(20),
	@ValorMeta VARCHAR(256) )
AS
BEGIN
	
	SELECT TOP 1 @CodigoUsuario = U.CODIGOUSUARIO
	FROM dbo.Usuario U WITH(NOLOCK)
		WHERE (U.CODIGOCONSULTORA = @CodigoUsuario OR U.DOCUMENTOIDENTIDAD = @CodigoUsuario OR U.CODIGOUSUARIO = @CodigoUsuario)

	IF EXISTS(SELECT 1 FROM dbo.MetaConsultora (NOLOCK) WHERE CodigoUsuario = @CodigoUsuario AND CodigoMeta = @CodigoMeta)
	BEGIN
		UPDATE dbo.MetaConsultora
		SET ValorMeta = @ValorMeta,
			FechaActualizacion = GETDATE()
		WHERE CodigoUsuario = @CodigoUsuario AND CodigoMeta = @CodigoMeta
	END
	ELSE
	BEGIN
		INSERT INTO dbo.MetaConsultora( CodigoUsuario, CodigoMeta, ValorMeta, FechaActualizacion)
		VALUES( @CodigoUsuario, @CodigoMeta, @ValorMeta, GETDATE() )
	END
END
GO

USE BelcorpPuertoRico
GO

/* InsMetaConsultora */
IF (OBJECT_ID('InsMetaConsultora') IS NOT NULL)
  DROP PROCEDURE [dbo].[InsMetaConsultora]
GO

CREATE PROCEDURE [dbo].[InsMetaConsultora] (
	@CodigoUsuario VARCHAR(20),
	@CodigoMeta VARCHAR(20),
	@ValorMeta VARCHAR(256) )
AS
BEGIN
	
	SELECT TOP 1 @CodigoUsuario = U.CODIGOUSUARIO
	FROM dbo.Usuario U WITH(NOLOCK)
		WHERE (U.CODIGOCONSULTORA = @CodigoUsuario OR U.DOCUMENTOIDENTIDAD = @CodigoUsuario OR U.CODIGOUSUARIO = @CodigoUsuario)

	IF EXISTS(SELECT 1 FROM dbo.MetaConsultora (NOLOCK) WHERE CodigoUsuario = @CodigoUsuario AND CodigoMeta = @CodigoMeta)
	BEGIN
		UPDATE dbo.MetaConsultora
		SET ValorMeta = @ValorMeta,
			FechaActualizacion = GETDATE()
		WHERE CodigoUsuario = @CodigoUsuario AND CodigoMeta = @CodigoMeta
	END
	ELSE
	BEGIN
		INSERT INTO dbo.MetaConsultora( CodigoUsuario, CodigoMeta, ValorMeta, FechaActualizacion)
		VALUES( @CodigoUsuario, @CodigoMeta, @ValorMeta, GETDATE() )
	END
END
GO

USE BelcorpPanama
GO

/* InsMetaConsultora */
IF (OBJECT_ID('InsMetaConsultora') IS NOT NULL)
  DROP PROCEDURE [dbo].[InsMetaConsultora]
GO

CREATE PROCEDURE [dbo].[InsMetaConsultora] (
	@CodigoUsuario VARCHAR(20),
	@CodigoMeta VARCHAR(20),
	@ValorMeta VARCHAR(256) )
AS
BEGIN
	
	SELECT TOP 1 @CodigoUsuario = U.CODIGOUSUARIO
	FROM dbo.Usuario U WITH(NOLOCK)
		WHERE (U.CODIGOCONSULTORA = @CodigoUsuario OR U.DOCUMENTOIDENTIDAD = @CodigoUsuario OR U.CODIGOUSUARIO = @CodigoUsuario)

	IF EXISTS(SELECT 1 FROM dbo.MetaConsultora (NOLOCK) WHERE CodigoUsuario = @CodigoUsuario AND CodigoMeta = @CodigoMeta)
	BEGIN
		UPDATE dbo.MetaConsultora
		SET ValorMeta = @ValorMeta,
			FechaActualizacion = GETDATE()
		WHERE CodigoUsuario = @CodigoUsuario AND CodigoMeta = @CodigoMeta
	END
	ELSE
	BEGIN
		INSERT INTO dbo.MetaConsultora( CodigoUsuario, CodigoMeta, ValorMeta, FechaActualizacion)
		VALUES( @CodigoUsuario, @CodigoMeta, @ValorMeta, GETDATE() )
	END
END
GO

USE BelcorpGuatemala
GO

/* InsMetaConsultora */
IF (OBJECT_ID('InsMetaConsultora') IS NOT NULL)
  DROP PROCEDURE [dbo].[InsMetaConsultora]
GO

CREATE PROCEDURE [dbo].[InsMetaConsultora] (
	@CodigoUsuario VARCHAR(20),
	@CodigoMeta VARCHAR(20),
	@ValorMeta VARCHAR(256) )
AS
BEGIN
	
	SELECT TOP 1 @CodigoUsuario = U.CODIGOUSUARIO
	FROM dbo.Usuario U WITH(NOLOCK)
		WHERE (U.CODIGOCONSULTORA = @CodigoUsuario OR U.DOCUMENTOIDENTIDAD = @CodigoUsuario OR U.CODIGOUSUARIO = @CodigoUsuario)

	IF EXISTS(SELECT 1 FROM dbo.MetaConsultora (NOLOCK) WHERE CodigoUsuario = @CodigoUsuario AND CodigoMeta = @CodigoMeta)
	BEGIN
		UPDATE dbo.MetaConsultora
		SET ValorMeta = @ValorMeta,
			FechaActualizacion = GETDATE()
		WHERE CodigoUsuario = @CodigoUsuario AND CodigoMeta = @CodigoMeta
	END
	ELSE
	BEGIN
		INSERT INTO dbo.MetaConsultora( CodigoUsuario, CodigoMeta, ValorMeta, FechaActualizacion)
		VALUES( @CodigoUsuario, @CodigoMeta, @ValorMeta, GETDATE() )
	END
END
GO

USE BelcorpEcuador
GO

/* InsMetaConsultora */
IF (OBJECT_ID('InsMetaConsultora') IS NOT NULL)
  DROP PROCEDURE [dbo].[InsMetaConsultora]
GO

CREATE PROCEDURE [dbo].[InsMetaConsultora] (
	@CodigoUsuario VARCHAR(20),
	@CodigoMeta VARCHAR(20),
	@ValorMeta VARCHAR(256) )
AS
BEGIN
	
	SELECT TOP 1 @CodigoUsuario = U.CODIGOUSUARIO
	FROM dbo.Usuario U WITH(NOLOCK)
		WHERE (U.CODIGOCONSULTORA = @CodigoUsuario OR U.DOCUMENTOIDENTIDAD = @CodigoUsuario OR U.CODIGOUSUARIO = @CodigoUsuario)

	IF EXISTS(SELECT 1 FROM dbo.MetaConsultora (NOLOCK) WHERE CodigoUsuario = @CodigoUsuario AND CodigoMeta = @CodigoMeta)
	BEGIN
		UPDATE dbo.MetaConsultora
		SET ValorMeta = @ValorMeta,
			FechaActualizacion = GETDATE()
		WHERE CodigoUsuario = @CodigoUsuario AND CodigoMeta = @CodigoMeta
	END
	ELSE
	BEGIN
		INSERT INTO dbo.MetaConsultora( CodigoUsuario, CodigoMeta, ValorMeta, FechaActualizacion)
		VALUES( @CodigoUsuario, @CodigoMeta, @ValorMeta, GETDATE() )
	END
END
GO

USE BelcorpDominicana
GO

/* InsMetaConsultora */
IF (OBJECT_ID('InsMetaConsultora') IS NOT NULL)
  DROP PROCEDURE [dbo].[InsMetaConsultora]
GO

CREATE PROCEDURE [dbo].[InsMetaConsultora] (
	@CodigoUsuario VARCHAR(20),
	@CodigoMeta VARCHAR(20),
	@ValorMeta VARCHAR(256) )
AS
BEGIN
	
	SELECT TOP 1 @CodigoUsuario = U.CODIGOUSUARIO
	FROM dbo.Usuario U WITH(NOLOCK)
		WHERE (U.CODIGOCONSULTORA = @CodigoUsuario OR U.DOCUMENTOIDENTIDAD = @CodigoUsuario OR U.CODIGOUSUARIO = @CodigoUsuario)

	IF EXISTS(SELECT 1 FROM dbo.MetaConsultora (NOLOCK) WHERE CodigoUsuario = @CodigoUsuario AND CodigoMeta = @CodigoMeta)
	BEGIN
		UPDATE dbo.MetaConsultora
		SET ValorMeta = @ValorMeta,
			FechaActualizacion = GETDATE()
		WHERE CodigoUsuario = @CodigoUsuario AND CodigoMeta = @CodigoMeta
	END
	ELSE
	BEGIN
		INSERT INTO dbo.MetaConsultora( CodigoUsuario, CodigoMeta, ValorMeta, FechaActualizacion)
		VALUES( @CodigoUsuario, @CodigoMeta, @ValorMeta, GETDATE() )
	END
END
GO

USE BelcorpCostaRica
GO

/* InsMetaConsultora */
IF (OBJECT_ID('InsMetaConsultora') IS NOT NULL)
  DROP PROCEDURE [dbo].[InsMetaConsultora]
GO

CREATE PROCEDURE [dbo].[InsMetaConsultora] (
	@CodigoUsuario VARCHAR(20),
	@CodigoMeta VARCHAR(20),
	@ValorMeta VARCHAR(256) )
AS
BEGIN
	
	SELECT TOP 1 @CodigoUsuario = U.CODIGOUSUARIO
	FROM dbo.Usuario U WITH(NOLOCK)
		WHERE (U.CODIGOCONSULTORA = @CodigoUsuario OR U.DOCUMENTOIDENTIDAD = @CodigoUsuario OR U.CODIGOUSUARIO = @CodigoUsuario)

	IF EXISTS(SELECT 1 FROM dbo.MetaConsultora (NOLOCK) WHERE CodigoUsuario = @CodigoUsuario AND CodigoMeta = @CodigoMeta)
	BEGIN
		UPDATE dbo.MetaConsultora
		SET ValorMeta = @ValorMeta,
			FechaActualizacion = GETDATE()
		WHERE CodigoUsuario = @CodigoUsuario AND CodigoMeta = @CodigoMeta
	END
	ELSE
	BEGIN
		INSERT INTO dbo.MetaConsultora( CodigoUsuario, CodigoMeta, ValorMeta, FechaActualizacion)
		VALUES( @CodigoUsuario, @CodigoMeta, @ValorMeta, GETDATE() )
	END
END
GO


USE BelcorpChile
GO

/* InsMetaConsultora */
IF (OBJECT_ID('InsMetaConsultora') IS NOT NULL)
  DROP PROCEDURE [dbo].[InsMetaConsultora]
GO

CREATE PROCEDURE [dbo].[InsMetaConsultora] (
	@CodigoUsuario VARCHAR(20),
	@CodigoMeta VARCHAR(20),
	@ValorMeta VARCHAR(256) )
AS
BEGIN
	
	SELECT TOP 1 @CodigoUsuario = U.CODIGOUSUARIO
	FROM dbo.Usuario U WITH(NOLOCK)
		WHERE (U.CODIGOCONSULTORA = @CodigoUsuario OR U.DOCUMENTOIDENTIDAD = @CodigoUsuario OR U.CODIGOUSUARIO = @CodigoUsuario)

	IF EXISTS(SELECT 1 FROM dbo.MetaConsultora (NOLOCK) WHERE CodigoUsuario = @CodigoUsuario AND CodigoMeta = @CodigoMeta)
	BEGIN
		UPDATE dbo.MetaConsultora
		SET ValorMeta = @ValorMeta,
			FechaActualizacion = GETDATE()
		WHERE CodigoUsuario = @CodigoUsuario AND CodigoMeta = @CodigoMeta
	END
	ELSE
	BEGIN
		INSERT INTO dbo.MetaConsultora( CodigoUsuario, CodigoMeta, ValorMeta, FechaActualizacion)
		VALUES( @CodigoUsuario, @CodigoMeta, @ValorMeta, GETDATE() )
	END
END
GO

USE BelcorpBolivia
GO

/* InsMetaConsultora */
IF (OBJECT_ID('InsMetaConsultora') IS NOT NULL)
  DROP PROCEDURE [dbo].[InsMetaConsultora]
GO

CREATE PROCEDURE [dbo].[InsMetaConsultora] (
	@CodigoUsuario VARCHAR(20),
	@CodigoMeta VARCHAR(20),
	@ValorMeta VARCHAR(256) )
AS
BEGIN
	
	SELECT TOP 1 @CodigoUsuario = U.CODIGOUSUARIO
	FROM dbo.Usuario U WITH(NOLOCK)
		WHERE (U.CODIGOCONSULTORA = @CodigoUsuario OR U.DOCUMENTOIDENTIDAD = @CodigoUsuario OR U.CODIGOUSUARIO = @CodigoUsuario)

	IF EXISTS(SELECT 1 FROM dbo.MetaConsultora (NOLOCK) WHERE CodigoUsuario = @CodigoUsuario AND CodigoMeta = @CodigoMeta)
	BEGIN
		UPDATE dbo.MetaConsultora
		SET ValorMeta = @ValorMeta,
			FechaActualizacion = GETDATE()
		WHERE CodigoUsuario = @CodigoUsuario AND CodigoMeta = @CodigoMeta
	END
	ELSE
	BEGIN
		INSERT INTO dbo.MetaConsultora( CodigoUsuario, CodigoMeta, ValorMeta, FechaActualizacion)
		VALUES( @CodigoUsuario, @CodigoMeta, @ValorMeta, GETDATE() )
	END
END
GO

