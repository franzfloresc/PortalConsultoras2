USE BELCORPPERU
GO

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[OfertaFinalConsultora_Log]') AND (type = 'U') )
	DROP TABLE [dbo].[OfertaFinalConsultora_Log]
GO

CREATE TABLE dbo.OfertaFinalConsultora_Log
(
	OfertaFinalConsultoraID INT PRIMARY KEY IDENTITY(1,1),
	campaniaID INT,
	codigoConsultora VARCHAR(20),
	CUV VARCHAR(20),
	cantidad INT,
	Fecha DATETIME,
	TipoOfertaFinal VARCHAR(4),
	GAP DECIMAL(18,2)
)

go