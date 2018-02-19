USE BelcorpPeru
GO

IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ActualizarTonoEstrategias') AND type IN ( N'P', N'PC' ) ) 
	DROP PROCEDURE dbo.ActualizarTonoEstrategias
GO

CREATE PROCEDURE ActualizarTonoEstrategias
@EstrategiaID INT,
@CodigoEstrategia VARCHAR(100),
@TieneVariedad INT,
@Retorno INT OUT
AS
BEGIN
	BEGIN TRY
		UPDATE Estrategia 
		SET CodigoEstrategia	= @CodigoEstrategia,
			TieneVariedad		= @TieneVariedad
		WHERE EstrategiaID = @EstrategiaID
		SET @Retorno = @EstrategiaID
	END TRY
	BEGIN CATCH
		SET @Retorno = 0
	END CATCH
END
GO

USE BelcorpMexico
GO

IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ActualizarTonoEstrategias') AND type IN ( N'P', N'PC' ) ) 
	DROP PROCEDURE dbo.ActualizarTonoEstrategias
GO

CREATE PROCEDURE ActualizarTonoEstrategias
@EstrategiaID INT,
@CodigoEstrategia VARCHAR(100),
@TieneVariedad INT,
@Retorno INT OUT
AS
BEGIN
	BEGIN TRY
		UPDATE Estrategia 
		SET CodigoEstrategia	= @CodigoEstrategia,
			TieneVariedad		= @TieneVariedad
		WHERE EstrategiaID = @EstrategiaID
		SET @Retorno = @EstrategiaID
	END TRY
	BEGIN CATCH
		SET @Retorno = 0
	END CATCH
END
GO

USE BelcorpColombia
GO

IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ActualizarTonoEstrategias') AND type IN ( N'P', N'PC' ) ) 
	DROP PROCEDURE dbo.ActualizarTonoEstrategias
GO

CREATE PROCEDURE ActualizarTonoEstrategias
@EstrategiaID INT,
@CodigoEstrategia VARCHAR(100),
@TieneVariedad INT,
@Retorno INT OUT
AS
BEGIN
	BEGIN TRY
		UPDATE Estrategia 
		SET CodigoEstrategia	= @CodigoEstrategia,
			TieneVariedad		= @TieneVariedad
		WHERE EstrategiaID = @EstrategiaID
		SET @Retorno = @EstrategiaID
	END TRY
	BEGIN CATCH
		SET @Retorno = 0
	END CATCH
END
GO

USE BelcorpVenezuela
GO

IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ActualizarTonoEstrategias') AND type IN ( N'P', N'PC' ) ) 
	DROP PROCEDURE dbo.ActualizarTonoEstrategias
GO

CREATE PROCEDURE ActualizarTonoEstrategias
@EstrategiaID INT,
@CodigoEstrategia VARCHAR(100),
@TieneVariedad INT,
@Retorno INT OUT
AS
BEGIN
	BEGIN TRY
		UPDATE Estrategia 
		SET CodigoEstrategia	= @CodigoEstrategia,
			TieneVariedad		= @TieneVariedad
		WHERE EstrategiaID = @EstrategiaID
		SET @Retorno = @EstrategiaID
	END TRY
	BEGIN CATCH
		SET @Retorno = 0
	END CATCH
END
GO

USE BelcorpSalvador
GO

IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ActualizarTonoEstrategias') AND type IN ( N'P', N'PC' ) ) 
	DROP PROCEDURE dbo.ActualizarTonoEstrategias
GO

CREATE PROCEDURE ActualizarTonoEstrategias
@EstrategiaID INT,
@CodigoEstrategia VARCHAR(100),
@TieneVariedad INT,
@Retorno INT OUT
AS
BEGIN
	BEGIN TRY
		UPDATE Estrategia 
		SET CodigoEstrategia	= @CodigoEstrategia,
			TieneVariedad		= @TieneVariedad
		WHERE EstrategiaID = @EstrategiaID
		SET @Retorno = @EstrategiaID
	END TRY
	BEGIN CATCH
		SET @Retorno = 0
	END CATCH
END
GO

USE BelcorpPuertoRico
GO

IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ActualizarTonoEstrategias') AND type IN ( N'P', N'PC' ) ) 
	DROP PROCEDURE dbo.ActualizarTonoEstrategias
GO

CREATE PROCEDURE ActualizarTonoEstrategias
@EstrategiaID INT,
@CodigoEstrategia VARCHAR(100),
@TieneVariedad INT,
@Retorno INT OUT
AS
BEGIN
	BEGIN TRY
		UPDATE Estrategia 
		SET CodigoEstrategia	= @CodigoEstrategia,
			TieneVariedad		= @TieneVariedad
		WHERE EstrategiaID = @EstrategiaID
		SET @Retorno = @EstrategiaID
	END TRY
	BEGIN CATCH
		SET @Retorno = 0
	END CATCH
END
GO

USE BelcorpPanama
GO

IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ActualizarTonoEstrategias') AND type IN ( N'P', N'PC' ) ) 
	DROP PROCEDURE dbo.ActualizarTonoEstrategias
GO

CREATE PROCEDURE ActualizarTonoEstrategias
@EstrategiaID INT,
@CodigoEstrategia VARCHAR(100),
@TieneVariedad INT,
@Retorno INT OUT
AS
BEGIN
	BEGIN TRY
		UPDATE Estrategia 
		SET CodigoEstrategia	= @CodigoEstrategia,
			TieneVariedad		= @TieneVariedad
		WHERE EstrategiaID = @EstrategiaID
		SET @Retorno = @EstrategiaID
	END TRY
	BEGIN CATCH
		SET @Retorno = 0
	END CATCH
END
GO

USE BelcorpGuatemala
GO

IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ActualizarTonoEstrategias') AND type IN ( N'P', N'PC' ) ) 
	DROP PROCEDURE dbo.ActualizarTonoEstrategias
GO

CREATE PROCEDURE ActualizarTonoEstrategias
@EstrategiaID INT,
@CodigoEstrategia VARCHAR(100),
@TieneVariedad INT,
@Retorno INT OUT
AS
BEGIN
	BEGIN TRY
		UPDATE Estrategia 
		SET CodigoEstrategia	= @CodigoEstrategia,
			TieneVariedad		= @TieneVariedad
		WHERE EstrategiaID = @EstrategiaID
		SET @Retorno = @EstrategiaID
	END TRY
	BEGIN CATCH
		SET @Retorno = 0
	END CATCH
END
GO

USE BelcorpEcuador
GO

IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ActualizarTonoEstrategias') AND type IN ( N'P', N'PC' ) ) 
	DROP PROCEDURE dbo.ActualizarTonoEstrategias
GO

CREATE PROCEDURE ActualizarTonoEstrategias
@EstrategiaID INT,
@CodigoEstrategia VARCHAR(100),
@TieneVariedad INT,
@Retorno INT OUT
AS
BEGIN
	BEGIN TRY
		UPDATE Estrategia 
		SET CodigoEstrategia	= @CodigoEstrategia,
			TieneVariedad		= @TieneVariedad
		WHERE EstrategiaID = @EstrategiaID
		SET @Retorno = @EstrategiaID
	END TRY
	BEGIN CATCH
		SET @Retorno = 0
	END CATCH
END
GO

USE BelcorpDominicana
GO

IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ActualizarTonoEstrategias') AND type IN ( N'P', N'PC' ) ) 
	DROP PROCEDURE dbo.ActualizarTonoEstrategias
GO

CREATE PROCEDURE ActualizarTonoEstrategias
@EstrategiaID INT,
@CodigoEstrategia VARCHAR(100),
@TieneVariedad INT,
@Retorno INT OUT
AS
BEGIN
	BEGIN TRY
		UPDATE Estrategia 
		SET CodigoEstrategia	= @CodigoEstrategia,
			TieneVariedad		= @TieneVariedad
		WHERE EstrategiaID = @EstrategiaID
		SET @Retorno = @EstrategiaID
	END TRY
	BEGIN CATCH
		SET @Retorno = 0
	END CATCH
END
GO

USE BelcorpCostaRica
GO

IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ActualizarTonoEstrategias') AND type IN ( N'P', N'PC' ) ) 
	DROP PROCEDURE dbo.ActualizarTonoEstrategias
GO

CREATE PROCEDURE ActualizarTonoEstrategias
@EstrategiaID INT,
@CodigoEstrategia VARCHAR(100),
@TieneVariedad INT,
@Retorno INT OUT
AS
BEGIN
	BEGIN TRY
		UPDATE Estrategia 
		SET CodigoEstrategia	= @CodigoEstrategia,
			TieneVariedad		= @TieneVariedad
		WHERE EstrategiaID = @EstrategiaID
		SET @Retorno = @EstrategiaID
	END TRY
	BEGIN CATCH
		SET @Retorno = 0
	END CATCH
END
GO

USE BelcorpChile
GO

IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ActualizarTonoEstrategias') AND type IN ( N'P', N'PC' ) ) 
	DROP PROCEDURE dbo.ActualizarTonoEstrategias
GO

CREATE PROCEDURE ActualizarTonoEstrategias
@EstrategiaID INT,
@CodigoEstrategia VARCHAR(100),
@TieneVariedad INT,
@Retorno INT OUT
AS
BEGIN
	BEGIN TRY
		UPDATE Estrategia 
		SET CodigoEstrategia	= @CodigoEstrategia,
			TieneVariedad		= @TieneVariedad
		WHERE EstrategiaID = @EstrategiaID
		SET @Retorno = @EstrategiaID
	END TRY
	BEGIN CATCH
		SET @Retorno = 0
	END CATCH
END
GO

USE BelcorpBolivia
GO

IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ActualizarTonoEstrategias') AND type IN ( N'P', N'PC' ) ) 
	DROP PROCEDURE dbo.ActualizarTonoEstrategias
GO

CREATE PROCEDURE ActualizarTonoEstrategias
@EstrategiaID INT,
@CodigoEstrategia VARCHAR(100),
@TieneVariedad INT,
@Retorno INT OUT
AS
BEGIN
	BEGIN TRY
		UPDATE Estrategia 
		SET CodigoEstrategia	= @CodigoEstrategia,
			TieneVariedad		= @TieneVariedad
		WHERE EstrategiaID = @EstrategiaID
		SET @Retorno = @EstrategiaID
	END TRY
	BEGIN CATCH
		SET @Retorno = 0
	END CATCH
END
GO

