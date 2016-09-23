IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[registrarLogOfertaFinal_SB2]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].registrarLogOfertaFinal_SB2
GO

CREATE PROCEDURE [dbo].registrarLogOfertaFinal_SB2
	@CampaniaID int,
	@CodigoConsultora varchar(20),
	@CUV varchar(20),
	@Cantidad int,
	@TipoOfertaFinal varchar(4),
	@GAP decimal(18,2)
AS	
BEGIN		
	INSERT INTO dbo.OfertaFinalConsultora_Log(campaniaID, codigoConsultora, CUV, cantidad, Fecha, TipoOfertaFinal, GAP)
	VALUES(@CampaniaID, @CodigoConsultora, @CUV, @Cantidad, GETDATE(), @TipoOfertaFinal, @GAP)
END
GO