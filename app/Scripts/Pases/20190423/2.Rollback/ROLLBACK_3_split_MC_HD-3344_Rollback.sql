IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[Split]') 
	AND type in (N'TF')
) 
	DROP FUNCTION [dbo].[Split]
GO
