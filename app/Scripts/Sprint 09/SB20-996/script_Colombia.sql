Use BelcorpColombia
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('dbo.OfertaFinalConsultora_log') and SYSCOLUMNS.NAME = N'TipoRegistro') = 0
	ALTER TABLE dbo.OfertaFinalConsultora_log ADD TipoRegistro int
go

update OfertaFinalConsultora_log set TipoRegistro = 1 where TipoRegistro is null

go

ALTER PROCEDURE [dbo].registrarLogOfertaFinal_SB2
	@CampaniaID int,
	@CodigoConsultora varchar(20),
	@CUV varchar(20),
	@Cantidad int,
	@TipoOfertaFinal varchar(4),
	@GAP decimal(18,2),
	@TipoRegistro int = 1
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

	INSERT INTO dbo.OfertaFinalConsultora_Log(campaniaID, codigoConsultora, CUV, cantidad, Fecha, TipoOfertaFinal, GAP, TipoRegistro)
	VALUES(@CampaniaID, @CodigoConsultora, @CUV, @CantidadInsertar, GETDATE(), @TipoOfertaFinal, @GAP, @TipoRegistro)
END

go
