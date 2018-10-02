
USE BelcorpBolivia
GO

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'MontoPedidoFinal' AND OBJECT_ID = OBJECT_ID(N'OfertaFinalMontoMeta'))
BEGIN
	ALTER TABLE OfertaFinalMontoMeta
	DROP COLUMN MontoPedidoFinal;
END 
GO

USE BelcorpChile
GO

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'MontoPedidoFinal' AND OBJECT_ID = OBJECT_ID(N'OfertaFinalMontoMeta'))
BEGIN
	ALTER TABLE OfertaFinalMontoMeta
	DROP COLUMN MontoPedidoFinal;
END 
GO

USE BelcorpColombia
GO

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'MontoPedidoFinal' AND OBJECT_ID = OBJECT_ID(N'OfertaFinalMontoMeta'))
BEGIN
	ALTER TABLE OfertaFinalMontoMeta
	DROP COLUMN MontoPedidoFinal;
END 
GO

USE BelcorpCostaRica
GO

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'MontoPedidoFinal' AND OBJECT_ID = OBJECT_ID(N'OfertaFinalMontoMeta'))
BEGIN
	ALTER TABLE OfertaFinalMontoMeta
	DROP COLUMN MontoPedidoFinal;
END 
GO

USE BelcorpDominicana
GO

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'MontoPedidoFinal' AND OBJECT_ID = OBJECT_ID(N'OfertaFinalMontoMeta'))
BEGIN
	ALTER TABLE OfertaFinalMontoMeta
	DROP COLUMN MontoPedidoFinal;
END 
GO

USE BelcorpEcuador
GO

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'MontoPedidoFinal' AND OBJECT_ID = OBJECT_ID(N'OfertaFinalMontoMeta'))
BEGIN
	ALTER TABLE OfertaFinalMontoMeta
	DROP COLUMN MontoPedidoFinal;
END 
GO

USE BelcorpGuatemala
GO

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'MontoPedidoFinal' AND OBJECT_ID = OBJECT_ID(N'OfertaFinalMontoMeta'))
BEGIN
	ALTER TABLE OfertaFinalMontoMeta
	DROP COLUMN MontoPedidoFinal;
END 
GO

USE BelcorpMexico
GO

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'MontoPedidoFinal' AND OBJECT_ID = OBJECT_ID(N'OfertaFinalMontoMeta'))
BEGIN
	ALTER TABLE OfertaFinalMontoMeta
	DROP COLUMN MontoPedidoFinal;
END 
GO

USE BelcorpPanama
GO

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'MontoPedidoFinal' AND OBJECT_ID = OBJECT_ID(N'OfertaFinalMontoMeta'))
BEGIN
	ALTER TABLE OfertaFinalMontoMeta
	DROP COLUMN MontoPedidoFinal;
END 
GO

USE BelcorpPeru
GO

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'MontoPedidoFinal' AND OBJECT_ID = OBJECT_ID(N'OfertaFinalMontoMeta'))
BEGIN
	ALTER TABLE OfertaFinalMontoMeta
	DROP COLUMN MontoPedidoFinal;
END 
GO

USE BelcorpPuertoRico
GO

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'MontoPedidoFinal' AND OBJECT_ID = OBJECT_ID(N'OfertaFinalMontoMeta'))
BEGIN
	ALTER TABLE OfertaFinalMontoMeta
	DROP COLUMN MontoPedidoFinal;
END 
GO

USE BelcorpSalvador
GO

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'MontoPedidoFinal' AND OBJECT_ID = OBJECT_ID(N'OfertaFinalMontoMeta'))
BEGIN
	ALTER TABLE OfertaFinalMontoMeta
	DROP COLUMN MontoPedidoFinal;
END 
GO


