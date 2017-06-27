
USE BelcorpPeru
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
		WHERE TABLE_NAME = N'ProductoComentario')
BEGIN
  DROP TABLE dbo.ProductoComentario
END
GO

CREATE TABLE dbo.ProductoComentario
(
	ProdComentarioId INT PRIMARY KEY IDENTITY(1,1) NOT NULL, 	
	CodigoSap VARCHAR(20) NOT NULL,
	CodigoGenerico VARCHAR(20) NOT NULL,
	CantComentarios INT NOT NULL,
	CantAprobados INT NOT NULL,
	CantRecomendados INT NOT NULL,
	FechaRegistro DATETIME NOT NULL,
	Estado TINYINT NOT NULL
)
GO

CREATE NONCLUSTERED INDEX IX_ProdComentario_CodigoSap   
ON ProductoComentario (CodigoSap); 
