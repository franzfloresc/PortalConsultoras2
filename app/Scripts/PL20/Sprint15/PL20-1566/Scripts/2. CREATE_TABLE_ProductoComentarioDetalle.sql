
USE BelcorpPeru
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
		WHERE TABLE_NAME = N'ProductoComentarioDetalle')
BEGIN
  DROP TABLE dbo.ProductoComentarioDetalle
END
GO

CREATE TABLE dbo.ProductoComentarioDetalle
(
	ProdComentarioDetalleId BIGINT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	ProdComentarioId INT NOT NULL,
	Valorizado TINYINT NOT NULL,
	Recomendado BIT NOT NULL,
	Comentario VARCHAR(400) NOT NULL,
	CodigoConsultora VARCHAR(20) NOT NULL,
	CampaniaID INT NOT NULL,
	FechaRegistro DATETIME NOT NULL,
	FechaAprobacion DATETIME NULL,
	CodTipoOrigen INT NULL,
	Estado TINYINT NOT NULL,
	CONSTRAINT FK_ProdComentarioId FOREIGN KEY (ProdComentarioId)
    REFERENCES ProductoComentario(ProdComentarioId)
)
GO