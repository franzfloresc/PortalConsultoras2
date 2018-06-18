USE [BelcorpPeru_BPT]
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ObtenerCuvFaltante]') 
	AND type in (N'FN',N'TF')
) 
	DROP FUNCTION [dbo].[ObtenerCuvFaltante]
GO
