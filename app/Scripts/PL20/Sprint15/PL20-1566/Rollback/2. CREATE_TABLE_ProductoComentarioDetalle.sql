
USE BelcorpPeru
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
		WHERE TABLE_NAME = N'ProductoComentarioDetalle')
BEGIN
  DROP TABLE dbo.ProductoComentarioDetalle
END
GO

