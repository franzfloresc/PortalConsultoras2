
USE BelcorpBolivia
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'MuestraPopup' AND OBJECT_ID = OBJECT_ID(N'OfertaFinalConsultora_Log'))
BEGIN
	ALTER TABLE OfertaFinalConsultora_Log
	ADD MuestraPopup BIT NULL;
END 
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'MontoInicial' AND OBJECT_ID = OBJECT_ID(N'OfertaFinalConsultora_Log'))
BEGIN
	ALTER TABLE OfertaFinalConsultora_Log
	ADD MontoInicial DECIMAL(18,2) NULL;
END 
GO

USE BelcorpChile
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'MuestraPopup' AND OBJECT_ID = OBJECT_ID(N'OfertaFinalConsultora_Log'))
BEGIN
	ALTER TABLE OfertaFinalConsultora_Log
	ADD MuestraPopup BIT NULL;
END 
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'MontoInicial' AND OBJECT_ID = OBJECT_ID(N'OfertaFinalConsultora_Log'))
BEGIN
	ALTER TABLE OfertaFinalConsultora_Log
	ADD MontoInicial DECIMAL(18,2) NULL;
END 
GO

USE BelcorpColombia
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'MuestraPopup' AND OBJECT_ID = OBJECT_ID(N'OfertaFinalConsultora_Log'))
BEGIN
	ALTER TABLE OfertaFinalConsultora_Log
	ADD MuestraPopup BIT NULL;
END 
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'MontoInicial' AND OBJECT_ID = OBJECT_ID(N'OfertaFinalConsultora_Log'))
BEGIN
	ALTER TABLE OfertaFinalConsultora_Log
	ADD MontoInicial DECIMAL(18,2) NULL;
END 
GO

USE BelcorpCostaRica
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'MuestraPopup' AND OBJECT_ID = OBJECT_ID(N'OfertaFinalConsultora_Log'))
BEGIN
	ALTER TABLE OfertaFinalConsultora_Log
	ADD MuestraPopup BIT NULL;
END 
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'MontoInicial' AND OBJECT_ID = OBJECT_ID(N'OfertaFinalConsultora_Log'))
BEGIN
	ALTER TABLE OfertaFinalConsultora_Log
	ADD MontoInicial DECIMAL(18,2) NULL;
END 
GO

USE BelcorpDominicana
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'MuestraPopup' AND OBJECT_ID = OBJECT_ID(N'OfertaFinalConsultora_Log'))
BEGIN
	ALTER TABLE OfertaFinalConsultora_Log
	ADD MuestraPopup BIT NULL;
END 
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'MontoInicial' AND OBJECT_ID = OBJECT_ID(N'OfertaFinalConsultora_Log'))
BEGIN
	ALTER TABLE OfertaFinalConsultora_Log
	ADD MontoInicial DECIMAL(18,2) NULL;
END 
GO

USE BelcorpEcuador
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'MuestraPopup' AND OBJECT_ID = OBJECT_ID(N'OfertaFinalConsultora_Log'))
BEGIN
	ALTER TABLE OfertaFinalConsultora_Log
	ADD MuestraPopup BIT NULL;
END 
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'MontoInicial' AND OBJECT_ID = OBJECT_ID(N'OfertaFinalConsultora_Log'))
BEGIN
	ALTER TABLE OfertaFinalConsultora_Log
	ADD MontoInicial DECIMAL(18,2) NULL;
END 
GO

USE BelcorpGuatemala
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'MuestraPopup' AND OBJECT_ID = OBJECT_ID(N'OfertaFinalConsultora_Log'))
BEGIN
	ALTER TABLE OfertaFinalConsultora_Log
	ADD MuestraPopup BIT NULL;
END 
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'MontoInicial' AND OBJECT_ID = OBJECT_ID(N'OfertaFinalConsultora_Log'))
BEGIN
	ALTER TABLE OfertaFinalConsultora_Log
	ADD MontoInicial DECIMAL(18,2) NULL;
END 
GO

USE BelcorpMexico
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'MuestraPopup' AND OBJECT_ID = OBJECT_ID(N'OfertaFinalConsultora_Log'))
BEGIN
	ALTER TABLE OfertaFinalConsultora_Log
	ADD MuestraPopup BIT NULL;
END 
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'MontoInicial' AND OBJECT_ID = OBJECT_ID(N'OfertaFinalConsultora_Log'))
BEGIN
	ALTER TABLE OfertaFinalConsultora_Log
	ADD MontoInicial DECIMAL(18,2) NULL;
END 
GO

USE BelcorpPanama
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'MuestraPopup' AND OBJECT_ID = OBJECT_ID(N'OfertaFinalConsultora_Log'))
BEGIN
	ALTER TABLE OfertaFinalConsultora_Log
	ADD MuestraPopup BIT NULL;
END 
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'MontoInicial' AND OBJECT_ID = OBJECT_ID(N'OfertaFinalConsultora_Log'))
BEGIN
	ALTER TABLE OfertaFinalConsultora_Log
	ADD MontoInicial DECIMAL(18,2) NULL;
END 
GO

USE BelcorpPeru
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'MuestraPopup' AND OBJECT_ID = OBJECT_ID(N'OfertaFinalConsultora_Log'))
BEGIN
	ALTER TABLE OfertaFinalConsultora_Log
	ADD MuestraPopup BIT NULL;
END 
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'MontoInicial' AND OBJECT_ID = OBJECT_ID(N'OfertaFinalConsultora_Log'))
BEGIN
	ALTER TABLE OfertaFinalConsultora_Log
	ADD MontoInicial DECIMAL(18,2) NULL;
END 
GO

USE BelcorpPuertoRico
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'MuestraPopup' AND OBJECT_ID = OBJECT_ID(N'OfertaFinalConsultora_Log'))
BEGIN
	ALTER TABLE OfertaFinalConsultora_Log
	ADD MuestraPopup BIT NULL;
END 
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'MontoInicial' AND OBJECT_ID = OBJECT_ID(N'OfertaFinalConsultora_Log'))
BEGIN
	ALTER TABLE OfertaFinalConsultora_Log
	ADD MontoInicial DECIMAL(18,2) NULL;
END 
GO

USE BelcorpSalvador
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'MuestraPopup' AND OBJECT_ID = OBJECT_ID(N'OfertaFinalConsultora_Log'))
BEGIN
	ALTER TABLE OfertaFinalConsultora_Log
	ADD MuestraPopup BIT NULL;
END 
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'MontoInicial' AND OBJECT_ID = OBJECT_ID(N'OfertaFinalConsultora_Log'))
BEGIN
	ALTER TABLE OfertaFinalConsultora_Log
	ADD MontoInicial DECIMAL(18,2) NULL;
END 
GO
