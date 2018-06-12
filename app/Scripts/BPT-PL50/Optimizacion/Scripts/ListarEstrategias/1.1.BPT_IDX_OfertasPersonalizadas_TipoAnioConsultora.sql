USE [ODS_PE_BPT]
GO

IF EXISTS (
	SELECT * FROM sys.indexes
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[OfertasPersonalizadas]') 
	AND name='IDX_OfertasPersonalizadas_TipoAnioConsultora'
) 
	DROP INDEX [dbo].[OfertasPersonalizadas].IDX_OfertasPersonalizadas_TipoAnioConsultora
GO


CREATE NONCLUSTERED INDEX IDX_OfertasPersonalizadas_TipoAnioConsultora
ON [dbo].[OfertasPersonalizadas] ([TipoPersonalizacion],[AnioCampanaVenta],[CodConsultora])
INCLUDE ([CUV],[Orden],[FlagRevista])
GO