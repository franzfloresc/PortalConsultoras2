USE BelcorpPeru
GO

IF NOT EXISTS (SELECT name FROM sys.indexes WHERE name = N'IX_LogGPRValidacion_ConsultoraIDRechazadoVisualizado')   
BEGIN
	CREATE NONCLUSTERED INDEX IX_LogGPRValidacion_ConsultoraIDRechazadoVisualizado 
	ON [GPR].[LogGPRValidacion] ([ConsultoraID],[Rechazado],[Visualizado]) 
END
GO

USE BelcorpMexico
GO

IF NOT EXISTS (SELECT name FROM sys.indexes WHERE name = N'IX_LogGPRValidacion_ConsultoraIDRechazadoVisualizado')   
BEGIN
	CREATE NONCLUSTERED INDEX IX_LogGPRValidacion_ConsultoraIDRechazadoVisualizado 
	ON [GPR].[LogGPRValidacion] ([ConsultoraID],[Rechazado],[Visualizado]) 
END
GO

USE BelcorpColombia
GO

IF NOT EXISTS (SELECT name FROM sys.indexes WHERE name = N'IX_LogGPRValidacion_ConsultoraIDRechazadoVisualizado')   
BEGIN
	CREATE NONCLUSTERED INDEX IX_LogGPRValidacion_ConsultoraIDRechazadoVisualizado 
	ON [GPR].[LogGPRValidacion] ([ConsultoraID],[Rechazado],[Visualizado]) 
END
GO

USE BelcorpVenezuela
GO

IF NOT EXISTS (SELECT name FROM sys.indexes WHERE name = N'IX_LogGPRValidacion_ConsultoraIDRechazadoVisualizado')   
BEGIN
	CREATE NONCLUSTERED INDEX IX_LogGPRValidacion_ConsultoraIDRechazadoVisualizado 
	ON [GPR].[LogGPRValidacion] ([ConsultoraID],[Rechazado],[Visualizado]) 
END
GO

USE BelcorpSalvador
GO

IF NOT EXISTS (SELECT name FROM sys.indexes WHERE name = N'IX_LogGPRValidacion_ConsultoraIDRechazadoVisualizado')   
BEGIN
	CREATE NONCLUSTERED INDEX IX_LogGPRValidacion_ConsultoraIDRechazadoVisualizado 
	ON [GPR].[LogGPRValidacion] ([ConsultoraID],[Rechazado],[Visualizado]) 
END
GO

USE BelcorpPuertoRico
GO

IF NOT EXISTS (SELECT name FROM sys.indexes WHERE name = N'IX_LogGPRValidacion_ConsultoraIDRechazadoVisualizado')   
BEGIN
	CREATE NONCLUSTERED INDEX IX_LogGPRValidacion_ConsultoraIDRechazadoVisualizado 
	ON [GPR].[LogGPRValidacion] ([ConsultoraID],[Rechazado],[Visualizado]) 
END
GO

USE BelcorpPanama
GO

IF NOT EXISTS (SELECT name FROM sys.indexes WHERE name = N'IX_LogGPRValidacion_ConsultoraIDRechazadoVisualizado')   
BEGIN
	CREATE NONCLUSTERED INDEX IX_LogGPRValidacion_ConsultoraIDRechazadoVisualizado 
	ON [GPR].[LogGPRValidacion] ([ConsultoraID],[Rechazado],[Visualizado]) 
END
GO

USE BelcorpGuatemala
GO

IF NOT EXISTS (SELECT name FROM sys.indexes WHERE name = N'IX_LogGPRValidacion_ConsultoraIDRechazadoVisualizado')   
BEGIN
	CREATE NONCLUSTERED INDEX IX_LogGPRValidacion_ConsultoraIDRechazadoVisualizado 
	ON [GPR].[LogGPRValidacion] ([ConsultoraID],[Rechazado],[Visualizado]) 
END
GO

USE BelcorpEcuador
GO

IF NOT EXISTS (SELECT name FROM sys.indexes WHERE name = N'IX_LogGPRValidacion_ConsultoraIDRechazadoVisualizado')   
BEGIN
	CREATE NONCLUSTERED INDEX IX_LogGPRValidacion_ConsultoraIDRechazadoVisualizado 
	ON [GPR].[LogGPRValidacion] ([ConsultoraID],[Rechazado],[Visualizado]) 
END
GO

USE BelcorpDominicana
GO

IF NOT EXISTS (SELECT name FROM sys.indexes WHERE name = N'IX_LogGPRValidacion_ConsultoraIDRechazadoVisualizado')   
BEGIN
	CREATE NONCLUSTERED INDEX IX_LogGPRValidacion_ConsultoraIDRechazadoVisualizado 
	ON [GPR].[LogGPRValidacion] ([ConsultoraID],[Rechazado],[Visualizado]) 
END
GO

USE BelcorpCostaRica
GO

IF NOT EXISTS (SELECT name FROM sys.indexes WHERE name = N'IX_LogGPRValidacion_ConsultoraIDRechazadoVisualizado')   
BEGIN
	CREATE NONCLUSTERED INDEX IX_LogGPRValidacion_ConsultoraIDRechazadoVisualizado 
	ON [GPR].[LogGPRValidacion] ([ConsultoraID],[Rechazado],[Visualizado]) 
END
GO

USE BelcorpChile
GO

IF NOT EXISTS (SELECT name FROM sys.indexes WHERE name = N'IX_LogGPRValidacion_ConsultoraIDRechazadoVisualizado')   
BEGIN
	CREATE NONCLUSTERED INDEX IX_LogGPRValidacion_ConsultoraIDRechazadoVisualizado 
	ON [GPR].[LogGPRValidacion] ([ConsultoraID],[Rechazado],[Visualizado]) 
END
GO

USE BelcorpBolivia
GO

IF NOT EXISTS (SELECT name FROM sys.indexes WHERE name = N'IX_LogGPRValidacion_ConsultoraIDRechazadoVisualizado')   
BEGIN
	CREATE NONCLUSTERED INDEX IX_LogGPRValidacion_ConsultoraIDRechazadoVisualizado 
	ON [GPR].[LogGPRValidacion] ([ConsultoraID],[Rechazado],[Visualizado]) 
END
GO

