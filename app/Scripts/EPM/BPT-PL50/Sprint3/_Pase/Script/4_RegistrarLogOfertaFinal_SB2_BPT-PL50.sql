GO
USE BelcorpPeru
GO

GO

ALTER PROCEDURE [dbo].[registrarLogOfertaFinal_SB2]
	@CampaniaID INT
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


GO
USE BelcorpMexico
GO

GO

ALTER PROCEDURE [dbo].[registrarLogOfertaFinal_SB2]
	@CampaniaID INT
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


GO
USE BelcorpColombia
GO

GO

ALTER PROCEDURE [dbo].[registrarLogOfertaFinal_SB2]
	@CampaniaID INT
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


GO
USE BelcorpSalvador
GO

GO

ALTER PROCEDURE [dbo].[registrarLogOfertaFinal_SB2]
	@CampaniaID INT
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


GO
USE BelcorpPuertoRico
GO

GO

ALTER PROCEDURE [dbo].[registrarLogOfertaFinal_SB2]
	@CampaniaID INT
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


GO
USE BelcorpPanama
GO

GO

ALTER PROCEDURE [dbo].[registrarLogOfertaFinal_SB2]
	@CampaniaID INT
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


GO
USE BelcorpGuatemala
GO

GO

ALTER PROCEDURE [dbo].[registrarLogOfertaFinal_SB2]
	@CampaniaID INT
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


GO
USE BelcorpEcuador
GO

GO

ALTER PROCEDURE [dbo].[registrarLogOfertaFinal_SB2]
	@CampaniaID INT
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


GO
USE BelcorpDominicana
GO

GO

ALTER PROCEDURE [dbo].[registrarLogOfertaFinal_SB2]
	@CampaniaID INT
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


GO
USE BelcorpCostaRica
GO

GO

ALTER PROCEDURE [dbo].[registrarLogOfertaFinal_SB2]
	@CampaniaID INT
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


GO
USE BelcorpChile
GO

GO

ALTER PROCEDURE [dbo].[registrarLogOfertaFinal_SB2]
	@CampaniaID INT
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


GO
USE BelcorpBolivia
GO

GO

ALTER PROCEDURE [dbo].[registrarLogOfertaFinal_SB2]
	@CampaniaID INT
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


GO
