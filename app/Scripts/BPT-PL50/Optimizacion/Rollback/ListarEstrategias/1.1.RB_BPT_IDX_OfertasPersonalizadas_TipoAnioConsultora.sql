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