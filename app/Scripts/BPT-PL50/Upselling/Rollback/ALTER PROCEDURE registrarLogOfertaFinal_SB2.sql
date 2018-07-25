
USE BelcorpBolivia
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

USE BelcorpChile
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

USE BelcorpColombia
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

USE BelcorpCostaRica
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

USE BelcorpDominicana
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

USE BelcorpEcuador
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

USE BelcorpGuatemala
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

USE BelcorpMexico
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


USE BelcorpPanama
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

USE BelcorpPeru
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

USE BelcorpPuertoRico
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

USE BelcorpSalvador
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
