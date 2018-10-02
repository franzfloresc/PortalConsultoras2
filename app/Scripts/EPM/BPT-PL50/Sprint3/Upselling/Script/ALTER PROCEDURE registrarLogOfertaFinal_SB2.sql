
USE BelcorpBolivia
GO

ALTER PROCEDURE [dbo].[registrarLogOfertaFinal_SB2] @CampaniaID INT
	,@CodigoConsultora VARCHAR(20)
	,@CUV VARCHAR(20)
	,@Cantidad INT
	,@TipoOfertaFinal VARCHAR(4)
	,@GAP DECIMAL(18, 2)
	,@TipoRegistro INT = 1
	,@DesTipoRegistro VARCHAR(150) = NULL
	,@MuestraPopup BIT = NULL
	,@MontoInicial DECIMAL(18,2) = NULL
AS
BEGIN
	DECLARE @CantidadInsertar INT

	IF @Cantidad = 0
	BEGIN
		SET @CantidadInsertar = NULL
	END
	ELSE
	BEGIN
		SET @CantidadInsertar = @Cantidad
	END

	INSERT INTO dbo.OfertaFinalConsultora_Log (
		campaniaID
		,codigoConsultora
		,CUV
		,cantidad
		,Fecha
		,TipoOfertaFinal
		,GAP
		,TipoRegistro
		,DesTipoRegistro
		,MuestraPopup 
		,MontoInicial
		)
	VALUES (
		@CampaniaID
		,@CodigoConsultora
		,@CUV
		,@CantidadInsertar
		,GETDATE()
		,@TipoOfertaFinal
		,@GAP
		,@TipoRegistro
		,@DesTipoRegistro
		,@MuestraPopup
		,@MontoInicial
		)
END
GO

USE BelcorpChile
GO

ALTER PROCEDURE [dbo].[registrarLogOfertaFinal_SB2] @CampaniaID INT
	,@CodigoConsultora VARCHAR(20)
	,@CUV VARCHAR(20)
	,@Cantidad INT
	,@TipoOfertaFinal VARCHAR(4)
	,@GAP DECIMAL(18, 2)
	,@TipoRegistro INT = 1
	,@DesTipoRegistro VARCHAR(150) = NULL
	,@MuestraPopup BIT = NULL
	,@MontoInicial DECIMAL(18,2) = NULL
AS
BEGIN
	DECLARE @CantidadInsertar INT

	IF @Cantidad = 0
	BEGIN
		SET @CantidadInsertar = NULL
	END
	ELSE
	BEGIN
		SET @CantidadInsertar = @Cantidad
	END

	INSERT INTO dbo.OfertaFinalConsultora_Log (
		campaniaID
		,codigoConsultora
		,CUV
		,cantidad
		,Fecha
		,TipoOfertaFinal
		,GAP
		,TipoRegistro
		,DesTipoRegistro
		,MuestraPopup 
		,MontoInicial
		)
	VALUES (
		@CampaniaID
		,@CodigoConsultora
		,@CUV
		,@CantidadInsertar
		,GETDATE()
		,@TipoOfertaFinal
		,@GAP
		,@TipoRegistro
		,@DesTipoRegistro
		,@MuestraPopup
		,@MontoInicial
		)
END
GO

USE BelcorpColombia
GO

ALTER PROCEDURE [dbo].[registrarLogOfertaFinal_SB2] @CampaniaID INT
	,@CodigoConsultora VARCHAR(20)
	,@CUV VARCHAR(20)
	,@Cantidad INT
	,@TipoOfertaFinal VARCHAR(4)
	,@GAP DECIMAL(18, 2)
	,@TipoRegistro INT = 1
	,@DesTipoRegistro VARCHAR(150) = NULL
	,@MuestraPopup BIT = NULL
	,@MontoInicial DECIMAL(18,2) = NULL
AS
BEGIN
	DECLARE @CantidadInsertar INT

	IF @Cantidad = 0
	BEGIN
		SET @CantidadInsertar = NULL
	END
	ELSE
	BEGIN
		SET @CantidadInsertar = @Cantidad
	END

	INSERT INTO dbo.OfertaFinalConsultora_Log (
		campaniaID
		,codigoConsultora
		,CUV
		,cantidad
		,Fecha
		,TipoOfertaFinal
		,GAP
		,TipoRegistro
		,DesTipoRegistro
		,MuestraPopup 
		,MontoInicial
		)
	VALUES (
		@CampaniaID
		,@CodigoConsultora
		,@CUV
		,@CantidadInsertar
		,GETDATE()
		,@TipoOfertaFinal
		,@GAP
		,@TipoRegistro
		,@DesTipoRegistro
		,@MuestraPopup
		,@MontoInicial
		)
END
GO

USE BelcorpCostaRica
GO

ALTER PROCEDURE [dbo].[registrarLogOfertaFinal_SB2] @CampaniaID INT
	,@CodigoConsultora VARCHAR(20)
	,@CUV VARCHAR(20)
	,@Cantidad INT
	,@TipoOfertaFinal VARCHAR(4)
	,@GAP DECIMAL(18, 2)
	,@TipoRegistro INT = 1
	,@DesTipoRegistro VARCHAR(150) = NULL
	,@MuestraPopup BIT = NULL
	,@MontoInicial DECIMAL(18,2) = NULL
AS
BEGIN
	DECLARE @CantidadInsertar INT

	IF @Cantidad = 0
	BEGIN
		SET @CantidadInsertar = NULL
	END
	ELSE
	BEGIN
		SET @CantidadInsertar = @Cantidad
	END

	INSERT INTO dbo.OfertaFinalConsultora_Log (
		campaniaID
		,codigoConsultora
		,CUV
		,cantidad
		,Fecha
		,TipoOfertaFinal
		,GAP
		,TipoRegistro
		,DesTipoRegistro
		,MuestraPopup 
		,MontoInicial
		)
	VALUES (
		@CampaniaID
		,@CodigoConsultora
		,@CUV
		,@CantidadInsertar
		,GETDATE()
		,@TipoOfertaFinal
		,@GAP
		,@TipoRegistro
		,@DesTipoRegistro
		,@MuestraPopup
		,@MontoInicial
		)
END
GO

USE BelcorpDominicana
GO

ALTER PROCEDURE [dbo].[registrarLogOfertaFinal_SB2] @CampaniaID INT
	,@CodigoConsultora VARCHAR(20)
	,@CUV VARCHAR(20)
	,@Cantidad INT
	,@TipoOfertaFinal VARCHAR(4)
	,@GAP DECIMAL(18, 2)
	,@TipoRegistro INT = 1
	,@DesTipoRegistro VARCHAR(150) = NULL
	,@MuestraPopup BIT = NULL
	,@MontoInicial DECIMAL(18,2) = NULL
AS
BEGIN
	DECLARE @CantidadInsertar INT

	IF @Cantidad = 0
	BEGIN
		SET @CantidadInsertar = NULL
	END
	ELSE
	BEGIN
		SET @CantidadInsertar = @Cantidad
	END

	INSERT INTO dbo.OfertaFinalConsultora_Log (
		campaniaID
		,codigoConsultora
		,CUV
		,cantidad
		,Fecha
		,TipoOfertaFinal
		,GAP
		,TipoRegistro
		,DesTipoRegistro
		,MuestraPopup 
		,MontoInicial
		)
	VALUES (
		@CampaniaID
		,@CodigoConsultora
		,@CUV
		,@CantidadInsertar
		,GETDATE()
		,@TipoOfertaFinal
		,@GAP
		,@TipoRegistro
		,@DesTipoRegistro
		,@MuestraPopup
		,@MontoInicial
		)
END
GO

USE BelcorpEcuador
GO

ALTER PROCEDURE [dbo].[registrarLogOfertaFinal_SB2] @CampaniaID INT
	,@CodigoConsultora VARCHAR(20)
	,@CUV VARCHAR(20)
	,@Cantidad INT
	,@TipoOfertaFinal VARCHAR(4)
	,@GAP DECIMAL(18, 2)
	,@TipoRegistro INT = 1
	,@DesTipoRegistro VARCHAR(150) = NULL
	,@MuestraPopup BIT = NULL
	,@MontoInicial DECIMAL(18,2) = NULL
AS
BEGIN
	DECLARE @CantidadInsertar INT

	IF @Cantidad = 0
	BEGIN
		SET @CantidadInsertar = NULL
	END
	ELSE
	BEGIN
		SET @CantidadInsertar = @Cantidad
	END

	INSERT INTO dbo.OfertaFinalConsultora_Log (
		campaniaID
		,codigoConsultora
		,CUV
		,cantidad
		,Fecha
		,TipoOfertaFinal
		,GAP
		,TipoRegistro
		,DesTipoRegistro
		,MuestraPopup 
		,MontoInicial
		)
	VALUES (
		@CampaniaID
		,@CodigoConsultora
		,@CUV
		,@CantidadInsertar
		,GETDATE()
		,@TipoOfertaFinal
		,@GAP
		,@TipoRegistro
		,@DesTipoRegistro
		,@MuestraPopup
		,@MontoInicial
		)
END
GO

USE BelcorpGuatemala
GO

ALTER PROCEDURE [dbo].[registrarLogOfertaFinal_SB2] @CampaniaID INT
	,@CodigoConsultora VARCHAR(20)
	,@CUV VARCHAR(20)
	,@Cantidad INT
	,@TipoOfertaFinal VARCHAR(4)
	,@GAP DECIMAL(18, 2)
	,@TipoRegistro INT = 1
	,@DesTipoRegistro VARCHAR(150) = NULL
	,@MuestraPopup BIT = NULL
	,@MontoInicial DECIMAL(18,2) = NULL
AS
BEGIN
	DECLARE @CantidadInsertar INT

	IF @Cantidad = 0
	BEGIN
		SET @CantidadInsertar = NULL
	END
	ELSE
	BEGIN
		SET @CantidadInsertar = @Cantidad
	END

	INSERT INTO dbo.OfertaFinalConsultora_Log (
		campaniaID
		,codigoConsultora
		,CUV
		,cantidad
		,Fecha
		,TipoOfertaFinal
		,GAP
		,TipoRegistro
		,DesTipoRegistro
		,MuestraPopup 
		,MontoInicial
		)
	VALUES (
		@CampaniaID
		,@CodigoConsultora
		,@CUV
		,@CantidadInsertar
		,GETDATE()
		,@TipoOfertaFinal
		,@GAP
		,@TipoRegistro
		,@DesTipoRegistro
		,@MuestraPopup
		,@MontoInicial
		)
END
GO

USE BelcorpMexico
GO

ALTER PROCEDURE [dbo].[registrarLogOfertaFinal_SB2] @CampaniaID INT
	,@CodigoConsultora VARCHAR(20)
	,@CUV VARCHAR(20)
	,@Cantidad INT
	,@TipoOfertaFinal VARCHAR(4)
	,@GAP DECIMAL(18, 2)
	,@TipoRegistro INT = 1
	,@DesTipoRegistro VARCHAR(150) = NULL
	,@MuestraPopup BIT = NULL
	,@MontoInicial DECIMAL(18,2) = NULL
AS
BEGIN
	DECLARE @CantidadInsertar INT

	IF @Cantidad = 0
	BEGIN
		SET @CantidadInsertar = NULL
	END
	ELSE
	BEGIN
		SET @CantidadInsertar = @Cantidad
	END

	INSERT INTO dbo.OfertaFinalConsultora_Log (
		campaniaID
		,codigoConsultora
		,CUV
		,cantidad
		,Fecha
		,TipoOfertaFinal
		,GAP
		,TipoRegistro
		,DesTipoRegistro
		,MuestraPopup 
		,MontoInicial
		)
	VALUES (
		@CampaniaID
		,@CodigoConsultora
		,@CUV
		,@CantidadInsertar
		,GETDATE()
		,@TipoOfertaFinal
		,@GAP
		,@TipoRegistro
		,@DesTipoRegistro
		,@MuestraPopup
		,@MontoInicial
		)
END
GO

USE BelcorpPanama
GO

ALTER PROCEDURE [dbo].[registrarLogOfertaFinal_SB2] @CampaniaID INT
	,@CodigoConsultora VARCHAR(20)
	,@CUV VARCHAR(20)
	,@Cantidad INT
	,@TipoOfertaFinal VARCHAR(4)
	,@GAP DECIMAL(18, 2)
	,@TipoRegistro INT = 1
	,@DesTipoRegistro VARCHAR(150) = NULL
	,@MuestraPopup BIT = NULL
	,@MontoInicial DECIMAL(18,2) = NULL
AS
BEGIN
	DECLARE @CantidadInsertar INT

	IF @Cantidad = 0
	BEGIN
		SET @CantidadInsertar = NULL
	END
	ELSE
	BEGIN
		SET @CantidadInsertar = @Cantidad
	END

	INSERT INTO dbo.OfertaFinalConsultora_Log (
		campaniaID
		,codigoConsultora
		,CUV
		,cantidad
		,Fecha
		,TipoOfertaFinal
		,GAP
		,TipoRegistro
		,DesTipoRegistro
		,MuestraPopup 
		,MontoInicial
		)
	VALUES (
		@CampaniaID
		,@CodigoConsultora
		,@CUV
		,@CantidadInsertar
		,GETDATE()
		,@TipoOfertaFinal
		,@GAP
		,@TipoRegistro
		,@DesTipoRegistro
		,@MuestraPopup
		,@MontoInicial
		)
END
GO

USE BelcorpPeru
GO

ALTER PROCEDURE [dbo].[registrarLogOfertaFinal_SB2] @CampaniaID INT
	,@CodigoConsultora VARCHAR(20)
	,@CUV VARCHAR(20)
	,@Cantidad INT
	,@TipoOfertaFinal VARCHAR(4)
	,@GAP DECIMAL(18, 2)
	,@TipoRegistro INT = 1
	,@DesTipoRegistro VARCHAR(150) = NULL
	,@MuestraPopup BIT = NULL
	,@MontoInicial DECIMAL(18,2) = NULL
AS
BEGIN
	DECLARE @CantidadInsertar INT

	IF @Cantidad = 0
	BEGIN
		SET @CantidadInsertar = NULL
	END
	ELSE
	BEGIN
		SET @CantidadInsertar = @Cantidad
	END

	INSERT INTO dbo.OfertaFinalConsultora_Log (
		campaniaID
		,codigoConsultora
		,CUV
		,cantidad
		,Fecha
		,TipoOfertaFinal
		,GAP
		,TipoRegistro
		,DesTipoRegistro
		,MuestraPopup 
		,MontoInicial
		)
	VALUES (
		@CampaniaID
		,@CodigoConsultora
		,@CUV
		,@CantidadInsertar
		,GETDATE()
		,@TipoOfertaFinal
		,@GAP
		,@TipoRegistro
		,@DesTipoRegistro
		,@MuestraPopup
		,@MontoInicial
		)
END
GO

USE BelcorpPuertoRico
GO

ALTER PROCEDURE [dbo].[registrarLogOfertaFinal_SB2] @CampaniaID INT
	,@CodigoConsultora VARCHAR(20)
	,@CUV VARCHAR(20)
	,@Cantidad INT
	,@TipoOfertaFinal VARCHAR(4)
	,@GAP DECIMAL(18, 2)
	,@TipoRegistro INT = 1
	,@DesTipoRegistro VARCHAR(150) = NULL
	,@MuestraPopup BIT = NULL
	,@MontoInicial DECIMAL(18,2) = NULL
AS
BEGIN
	DECLARE @CantidadInsertar INT

	IF @Cantidad = 0
	BEGIN
		SET @CantidadInsertar = NULL
	END
	ELSE
	BEGIN
		SET @CantidadInsertar = @Cantidad
	END

	INSERT INTO dbo.OfertaFinalConsultora_Log (
		campaniaID
		,codigoConsultora
		,CUV
		,cantidad
		,Fecha
		,TipoOfertaFinal
		,GAP
		,TipoRegistro
		,DesTipoRegistro
		,MuestraPopup 
		,MontoInicial
		)
	VALUES (
		@CampaniaID
		,@CodigoConsultora
		,@CUV
		,@CantidadInsertar
		,GETDATE()
		,@TipoOfertaFinal
		,@GAP
		,@TipoRegistro
		,@DesTipoRegistro
		,@MuestraPopup
		,@MontoInicial
		)
END
GO

USE BelcorpSalvador
GO

ALTER PROCEDURE [dbo].[registrarLogOfertaFinal_SB2] @CampaniaID INT
	,@CodigoConsultora VARCHAR(20)
	,@CUV VARCHAR(20)
	,@Cantidad INT
	,@TipoOfertaFinal VARCHAR(4)
	,@GAP DECIMAL(18, 2)
	,@TipoRegistro INT = 1
	,@DesTipoRegistro VARCHAR(150) = NULL
	,@MuestraPopup BIT = NULL
	,@MontoInicial DECIMAL(18,2) = NULL
AS
BEGIN
	DECLARE @CantidadInsertar INT

	IF @Cantidad = 0
	BEGIN
		SET @CantidadInsertar = NULL
	END
	ELSE
	BEGIN
		SET @CantidadInsertar = @Cantidad
	END

	INSERT INTO dbo.OfertaFinalConsultora_Log (
		campaniaID
		,codigoConsultora
		,CUV
		,cantidad
		,Fecha
		,TipoOfertaFinal
		,GAP
		,TipoRegistro
		,DesTipoRegistro
		,MuestraPopup 
		,MontoInicial
		)
	VALUES (
		@CampaniaID
		,@CodigoConsultora
		,@CUV
		,@CantidadInsertar
		,GETDATE()
		,@TipoOfertaFinal
		,@GAP
		,@TipoRegistro
		,@DesTipoRegistro
		,@MuestraPopup
		,@MontoInicial
		)
END
GO