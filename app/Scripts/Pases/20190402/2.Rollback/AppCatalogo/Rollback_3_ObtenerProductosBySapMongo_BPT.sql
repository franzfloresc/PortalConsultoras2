
GO

USE [AppCatalogo]

GO
IF EXISTS (
		SELECT 1
		FROM sys.procedures
		WHERE name = N'ObtenerProductosBySapMongo'
		)
BEGIN
	DROP PROCEDURE [dbo].[ObtenerProductosBySapMongo]
END

GO