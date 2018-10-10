GO
USE BelcorpPeru
GO
GO

ALTER PROCEDURE [dbo].[registrarLogOfertaFinal_SB2]
	@CampaniaID int,
	@CodigoConsultora varchar(20),
	@CUV varchar(20),
	@Cantidad int,
	@TipoOfertaFinal varchar(4),
	@GAP decimal(18,2),
	@TipoRegistro int = 1,
	@DesTipoRegistro varchar(150) = null
AS
BEGIN
	declare @CantidadInsertar int
	if @Cantidad = 0
	begin
		set @CantidadInsertar = null
	end
	else
	begin
		set @CantidadInsertar = @Cantidad
	end

	INSERT INTO dbo.OfertaFinalConsultora_Log(campaniaID, codigoConsultora, CUV, cantidad, Fecha, TipoOfertaFinal, GAP, TipoRegistro, DesTipoRegistro)
	VALUES(@CampaniaID, @CodigoConsultora, @CUV, @CantidadInsertar, GETDATE(), @TipoOfertaFinal, @GAP, @TipoRegistro, @DesTipoRegistro)
END
GO


GO
USE BelcorpMexico
GO
GO

ALTER PROCEDURE [dbo].[registrarLogOfertaFinal_SB2]
	@CampaniaID int,
	@CodigoConsultora varchar(20),
	@CUV varchar(20),
	@Cantidad int,
	@TipoOfertaFinal varchar(4),
	@GAP decimal(18,2),
	@TipoRegistro int = 1,
	@DesTipoRegistro varchar(150) = null
AS
BEGIN
	declare @CantidadInsertar int
	if @Cantidad = 0
	begin
		set @CantidadInsertar = null
	end
	else
	begin
		set @CantidadInsertar = @Cantidad
	end

	INSERT INTO dbo.OfertaFinalConsultora_Log(campaniaID, codigoConsultora, CUV, cantidad, Fecha, TipoOfertaFinal, GAP, TipoRegistro, DesTipoRegistro)
	VALUES(@CampaniaID, @CodigoConsultora, @CUV, @CantidadInsertar, GETDATE(), @TipoOfertaFinal, @GAP, @TipoRegistro, @DesTipoRegistro)
END
GO


GO
USE BelcorpColombia
GO
GO

ALTER PROCEDURE [dbo].[registrarLogOfertaFinal_SB2]
	@CampaniaID int,
	@CodigoConsultora varchar(20),
	@CUV varchar(20),
	@Cantidad int,
	@TipoOfertaFinal varchar(4),
	@GAP decimal(18,2),
	@TipoRegistro int = 1,
	@DesTipoRegistro varchar(150) = null
AS
BEGIN
	declare @CantidadInsertar int
	if @Cantidad = 0
	begin
		set @CantidadInsertar = null
	end
	else
	begin
		set @CantidadInsertar = @Cantidad
	end

	INSERT INTO dbo.OfertaFinalConsultora_Log(campaniaID, codigoConsultora, CUV, cantidad, Fecha, TipoOfertaFinal, GAP, TipoRegistro, DesTipoRegistro)
	VALUES(@CampaniaID, @CodigoConsultora, @CUV, @CantidadInsertar, GETDATE(), @TipoOfertaFinal, @GAP, @TipoRegistro, @DesTipoRegistro)
END
GO


GO
USE BelcorpSalvador
GO
GO

ALTER PROCEDURE [dbo].[registrarLogOfertaFinal_SB2]
	@CampaniaID int,
	@CodigoConsultora varchar(20),
	@CUV varchar(20),
	@Cantidad int,
	@TipoOfertaFinal varchar(4),
	@GAP decimal(18,2),
	@TipoRegistro int = 1,
	@DesTipoRegistro varchar(150) = null
AS
BEGIN
	declare @CantidadInsertar int
	if @Cantidad = 0
	begin
		set @CantidadInsertar = null
	end
	else
	begin
		set @CantidadInsertar = @Cantidad
	end

	INSERT INTO dbo.OfertaFinalConsultora_Log(campaniaID, codigoConsultora, CUV, cantidad, Fecha, TipoOfertaFinal, GAP, TipoRegistro, DesTipoRegistro)
	VALUES(@CampaniaID, @CodigoConsultora, @CUV, @CantidadInsertar, GETDATE(), @TipoOfertaFinal, @GAP, @TipoRegistro, @DesTipoRegistro)
END
GO


GO
USE BelcorpPuertoRico
GO
GO

ALTER PROCEDURE [dbo].[registrarLogOfertaFinal_SB2]
	@CampaniaID int,
	@CodigoConsultora varchar(20),
	@CUV varchar(20),
	@Cantidad int,
	@TipoOfertaFinal varchar(4),
	@GAP decimal(18,2),
	@TipoRegistro int = 1,
	@DesTipoRegistro varchar(150) = null
AS
BEGIN
	declare @CantidadInsertar int
	if @Cantidad = 0
	begin
		set @CantidadInsertar = null
	end
	else
	begin
		set @CantidadInsertar = @Cantidad
	end

	INSERT INTO dbo.OfertaFinalConsultora_Log(campaniaID, codigoConsultora, CUV, cantidad, Fecha, TipoOfertaFinal, GAP, TipoRegistro, DesTipoRegistro)
	VALUES(@CampaniaID, @CodigoConsultora, @CUV, @CantidadInsertar, GETDATE(), @TipoOfertaFinal, @GAP, @TipoRegistro, @DesTipoRegistro)
END
GO


GO
USE BelcorpPanama
GO
GO

ALTER PROCEDURE [dbo].[registrarLogOfertaFinal_SB2]
	@CampaniaID int,
	@CodigoConsultora varchar(20),
	@CUV varchar(20),
	@Cantidad int,
	@TipoOfertaFinal varchar(4),
	@GAP decimal(18,2),
	@TipoRegistro int = 1,
	@DesTipoRegistro varchar(150) = null
AS
BEGIN
	declare @CantidadInsertar int
	if @Cantidad = 0
	begin
		set @CantidadInsertar = null
	end
	else
	begin
		set @CantidadInsertar = @Cantidad
	end

	INSERT INTO dbo.OfertaFinalConsultora_Log(campaniaID, codigoConsultora, CUV, cantidad, Fecha, TipoOfertaFinal, GAP, TipoRegistro, DesTipoRegistro)
	VALUES(@CampaniaID, @CodigoConsultora, @CUV, @CantidadInsertar, GETDATE(), @TipoOfertaFinal, @GAP, @TipoRegistro, @DesTipoRegistro)
END
GO


GO
USE BelcorpGuatemala
GO
GO

ALTER PROCEDURE [dbo].[registrarLogOfertaFinal_SB2]
	@CampaniaID int,
	@CodigoConsultora varchar(20),
	@CUV varchar(20),
	@Cantidad int,
	@TipoOfertaFinal varchar(4),
	@GAP decimal(18,2),
	@TipoRegistro int = 1,
	@DesTipoRegistro varchar(150) = null
AS
BEGIN
	declare @CantidadInsertar int
	if @Cantidad = 0
	begin
		set @CantidadInsertar = null
	end
	else
	begin
		set @CantidadInsertar = @Cantidad
	end

	INSERT INTO dbo.OfertaFinalConsultora_Log(campaniaID, codigoConsultora, CUV, cantidad, Fecha, TipoOfertaFinal, GAP, TipoRegistro, DesTipoRegistro)
	VALUES(@CampaniaID, @CodigoConsultora, @CUV, @CantidadInsertar, GETDATE(), @TipoOfertaFinal, @GAP, @TipoRegistro, @DesTipoRegistro)
END
GO


GO
USE BelcorpEcuador
GO
GO

ALTER PROCEDURE [dbo].[registrarLogOfertaFinal_SB2]
	@CampaniaID int,
	@CodigoConsultora varchar(20),
	@CUV varchar(20),
	@Cantidad int,
	@TipoOfertaFinal varchar(4),
	@GAP decimal(18,2),
	@TipoRegistro int = 1,
	@DesTipoRegistro varchar(150) = null
AS
BEGIN
	declare @CantidadInsertar int
	if @Cantidad = 0
	begin
		set @CantidadInsertar = null
	end
	else
	begin
		set @CantidadInsertar = @Cantidad
	end

	INSERT INTO dbo.OfertaFinalConsultora_Log(campaniaID, codigoConsultora, CUV, cantidad, Fecha, TipoOfertaFinal, GAP, TipoRegistro, DesTipoRegistro)
	VALUES(@CampaniaID, @CodigoConsultora, @CUV, @CantidadInsertar, GETDATE(), @TipoOfertaFinal, @GAP, @TipoRegistro, @DesTipoRegistro)
END
GO


GO
USE BelcorpDominicana
GO
GO

ALTER PROCEDURE [dbo].[registrarLogOfertaFinal_SB2]
	@CampaniaID int,
	@CodigoConsultora varchar(20),
	@CUV varchar(20),
	@Cantidad int,
	@TipoOfertaFinal varchar(4),
	@GAP decimal(18,2),
	@TipoRegistro int = 1,
	@DesTipoRegistro varchar(150) = null
AS
BEGIN
	declare @CantidadInsertar int
	if @Cantidad = 0
	begin
		set @CantidadInsertar = null
	end
	else
	begin
		set @CantidadInsertar = @Cantidad
	end

	INSERT INTO dbo.OfertaFinalConsultora_Log(campaniaID, codigoConsultora, CUV, cantidad, Fecha, TipoOfertaFinal, GAP, TipoRegistro, DesTipoRegistro)
	VALUES(@CampaniaID, @CodigoConsultora, @CUV, @CantidadInsertar, GETDATE(), @TipoOfertaFinal, @GAP, @TipoRegistro, @DesTipoRegistro)
END
GO


GO
USE BelcorpCostaRica
GO
GO

ALTER PROCEDURE [dbo].[registrarLogOfertaFinal_SB2]
	@CampaniaID int,
	@CodigoConsultora varchar(20),
	@CUV varchar(20),
	@Cantidad int,
	@TipoOfertaFinal varchar(4),
	@GAP decimal(18,2),
	@TipoRegistro int = 1,
	@DesTipoRegistro varchar(150) = null
AS
BEGIN
	declare @CantidadInsertar int
	if @Cantidad = 0
	begin
		set @CantidadInsertar = null
	end
	else
	begin
		set @CantidadInsertar = @Cantidad
	end

	INSERT INTO dbo.OfertaFinalConsultora_Log(campaniaID, codigoConsultora, CUV, cantidad, Fecha, TipoOfertaFinal, GAP, TipoRegistro, DesTipoRegistro)
	VALUES(@CampaniaID, @CodigoConsultora, @CUV, @CantidadInsertar, GETDATE(), @TipoOfertaFinal, @GAP, @TipoRegistro, @DesTipoRegistro)
END
GO


GO
USE BelcorpChile
GO
GO

ALTER PROCEDURE [dbo].[registrarLogOfertaFinal_SB2]
	@CampaniaID int,
	@CodigoConsultora varchar(20),
	@CUV varchar(20),
	@Cantidad int,
	@TipoOfertaFinal varchar(4),
	@GAP decimal(18,2),
	@TipoRegistro int = 1,
	@DesTipoRegistro varchar(150) = null
AS
BEGIN
	declare @CantidadInsertar int
	if @Cantidad = 0
	begin
		set @CantidadInsertar = null
	end
	else
	begin
		set @CantidadInsertar = @Cantidad
	end

	INSERT INTO dbo.OfertaFinalConsultora_Log(campaniaID, codigoConsultora, CUV, cantidad, Fecha, TipoOfertaFinal, GAP, TipoRegistro, DesTipoRegistro)
	VALUES(@CampaniaID, @CodigoConsultora, @CUV, @CantidadInsertar, GETDATE(), @TipoOfertaFinal, @GAP, @TipoRegistro, @DesTipoRegistro)
END
GO


GO
USE BelcorpBolivia
GO
GO

ALTER PROCEDURE [dbo].[registrarLogOfertaFinal_SB2]
	@CampaniaID int,
	@CodigoConsultora varchar(20),
	@CUV varchar(20),
	@Cantidad int,
	@TipoOfertaFinal varchar(4),
	@GAP decimal(18,2),
	@TipoRegistro int = 1,
	@DesTipoRegistro varchar(150) = null
AS
BEGIN
	declare @CantidadInsertar int
	if @Cantidad = 0
	begin
		set @CantidadInsertar = null
	end
	else
	begin
		set @CantidadInsertar = @Cantidad
	end

	INSERT INTO dbo.OfertaFinalConsultora_Log(campaniaID, codigoConsultora, CUV, cantidad, Fecha, TipoOfertaFinal, GAP, TipoRegistro, DesTipoRegistro)
	VALUES(@CampaniaID, @CodigoConsultora, @CUV, @CantidadInsertar, GETDATE(), @TipoOfertaFinal, @GAP, @TipoRegistro, @DesTipoRegistro)
END
GO


GO
