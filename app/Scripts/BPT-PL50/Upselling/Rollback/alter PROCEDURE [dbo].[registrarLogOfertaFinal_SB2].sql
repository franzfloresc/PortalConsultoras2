
USE belcorpBolivia
GO
IF (OBJECT_ID('dbo.registrarLogOfertaFinal_SB2', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.registrarLogOfertaFinal_SB2 AS SET NOCOUNT ON;')
GO
alter PROCEDURE [dbo].[registrarLogOfertaFinal_SB2]

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
go


USE belcorpChile
GO
IF (OBJECT_ID('dbo.registrarLogOfertaFinal_SB2', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.registrarLogOfertaFinal_SB2 AS SET NOCOUNT ON;')
GO
alter PROCEDURE [dbo].[registrarLogOfertaFinal_SB2]

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
go


USE belcorpColombia
GO
IF (OBJECT_ID('dbo.registrarLogOfertaFinal_SB2', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.registrarLogOfertaFinal_SB2 AS SET NOCOUNT ON;')
GO
alter PROCEDURE [dbo].[registrarLogOfertaFinal_SB2]

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
go


USE belcorpCostaRica
GO
IF (OBJECT_ID('dbo.registrarLogOfertaFinal_SB2', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.registrarLogOfertaFinal_SB2 AS SET NOCOUNT ON;')
GO
alter PROCEDURE [dbo].[registrarLogOfertaFinal_SB2]

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
go


USE belcorpDominicana
GO
IF (OBJECT_ID('dbo.registrarLogOfertaFinal_SB2', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.registrarLogOfertaFinal_SB2 AS SET NOCOUNT ON;')
GO
alter PROCEDURE [dbo].[registrarLogOfertaFinal_SB2]

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
go


USE belcorpEcuador
GO
IF (OBJECT_ID('dbo.registrarLogOfertaFinal_SB2', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.registrarLogOfertaFinal_SB2 AS SET NOCOUNT ON;')
GO
alter PROCEDURE [dbo].[registrarLogOfertaFinal_SB2]

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
go


USE belcorpGuatemala
GO
IF (OBJECT_ID('dbo.registrarLogOfertaFinal_SB2', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.registrarLogOfertaFinal_SB2 AS SET NOCOUNT ON;')
GO
alter PROCEDURE [dbo].[registrarLogOfertaFinal_SB2]

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
go


USE belcorpMexico
GO
IF (OBJECT_ID('dbo.registrarLogOfertaFinal_SB2', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.registrarLogOfertaFinal_SB2 AS SET NOCOUNT ON;')
GO
alter PROCEDURE [dbo].[registrarLogOfertaFinal_SB2]

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
go


USE belcorpPanama
GO
IF (OBJECT_ID('dbo.registrarLogOfertaFinal_SB2', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.registrarLogOfertaFinal_SB2 AS SET NOCOUNT ON;')
GO
alter PROCEDURE [dbo].[registrarLogOfertaFinal_SB2]

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
go


USE belcorpPeru
GO
IF (OBJECT_ID('dbo.registrarLogOfertaFinal_SB2', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.registrarLogOfertaFinal_SB2 AS SET NOCOUNT ON;')
GO
alter PROCEDURE [dbo].[registrarLogOfertaFinal_SB2]

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
go


USE belcorpPuertoRico
GO
IF (OBJECT_ID('dbo.registrarLogOfertaFinal_SB2', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.registrarLogOfertaFinal_SB2 AS SET NOCOUNT ON;')
GO
alter PROCEDURE [dbo].[registrarLogOfertaFinal_SB2]

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
go


USE belcorpSalvador
GO
IF (OBJECT_ID('dbo.registrarLogOfertaFinal_SB2', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.registrarLogOfertaFinal_SB2 AS SET NOCOUNT ON;')
GO
alter PROCEDURE [dbo].[registrarLogOfertaFinal_SB2]

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
go

