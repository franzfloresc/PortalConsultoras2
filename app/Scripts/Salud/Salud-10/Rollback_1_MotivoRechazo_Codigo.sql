USE BelcorpPeru
GO

IF NOT EXISTS (SELECT * FROM SYS.INDEXES WHERE NAME='MotivoRechazo_Codigo' 
	AND OBJECT_ID = OBJECT_ID('[GPR].[MotivoRechazo]'))
BEGIN

DROP INDEX [MotivoRechazo_Codigo] ON [GPR].[MotivoRechazo]

END

GO

USE BelcorpMexico
GO

IF NOT EXISTS (SELECT * FROM SYS.INDEXES WHERE NAME='MotivoRechazo_Codigo' 
	AND OBJECT_ID = OBJECT_ID('[GPR].[MotivoRechazo]'))
BEGIN

DROP INDEX [MotivoRechazo_Codigo] ON [GPR].[MotivoRechazo]

END

GO

USE BelcorpColombia
GO

IF NOT EXISTS (SELECT * FROM SYS.INDEXES WHERE NAME='MotivoRechazo_Codigo' 
	AND OBJECT_ID = OBJECT_ID('[GPR].[MotivoRechazo]'))
BEGIN

DROP INDEX [MotivoRechazo_Codigo] ON [GPR].[MotivoRechazo]

END

GO

USE BelcorpSalvador
GO

IF NOT EXISTS (SELECT * FROM SYS.INDEXES WHERE NAME='MotivoRechazo_Codigo' 
	AND OBJECT_ID = OBJECT_ID('[GPR].[MotivoRechazo]'))
BEGIN

DROP INDEX [MotivoRechazo_Codigo] ON [GPR].[MotivoRechazo]

END

GO

USE BelcorpPuertoRico
GO

IF NOT EXISTS (SELECT * FROM SYS.INDEXES WHERE NAME='MotivoRechazo_Codigo' 
	AND OBJECT_ID = OBJECT_ID('[GPR].[MotivoRechazo]'))
BEGIN

DROP INDEX [MotivoRechazo_Codigo] ON [GPR].[MotivoRechazo]

END

GO

USE BelcorpPanama
GO

IF NOT EXISTS (SELECT * FROM SYS.INDEXES WHERE NAME='MotivoRechazo_Codigo' 
	AND OBJECT_ID = OBJECT_ID('[GPR].[MotivoRechazo]'))
BEGIN

DROP INDEX [MotivoRechazo_Codigo] ON [GPR].[MotivoRechazo]

END

GO

USE BelcorpGuatemala
GO

IF NOT EXISTS (SELECT * FROM SYS.INDEXES WHERE NAME='MotivoRechazo_Codigo' 
	AND OBJECT_ID = OBJECT_ID('[GPR].[MotivoRechazo]'))
BEGIN

DROP INDEX [MotivoRechazo_Codigo] ON [GPR].[MotivoRechazo]

END

GO

USE BelcorpEcuador
GO

IF NOT EXISTS (SELECT * FROM SYS.INDEXES WHERE NAME='MotivoRechazo_Codigo' 
	AND OBJECT_ID = OBJECT_ID('[GPR].[MotivoRechazo]'))
BEGIN

DROP INDEX [MotivoRechazo_Codigo] ON [GPR].[MotivoRechazo]

END

GO

USE BelcorpDominicana
GO

IF NOT EXISTS (SELECT * FROM SYS.INDEXES WHERE NAME='MotivoRechazo_Codigo' 
	AND OBJECT_ID = OBJECT_ID('[GPR].[MotivoRechazo]'))
BEGIN

DROP INDEX [MotivoRechazo_Codigo] ON [GPR].[MotivoRechazo]

END

GO

USE BelcorpCostaRica
GO

IF NOT EXISTS (SELECT * FROM SYS.INDEXES WHERE NAME='MotivoRechazo_Codigo' 
	AND OBJECT_ID = OBJECT_ID('[GPR].[MotivoRechazo]'))
BEGIN

DROP INDEX [MotivoRechazo_Codigo] ON [GPR].[MotivoRechazo]

END

GO

USE BelcorpChile
GO

IF NOT EXISTS (SELECT * FROM SYS.INDEXES WHERE NAME='MotivoRechazo_Codigo' 
	AND OBJECT_ID = OBJECT_ID('[GPR].[MotivoRechazo]'))
BEGIN

DROP INDEX [MotivoRechazo_Codigo] ON [GPR].[MotivoRechazo]

END

GO

USE BelcorpBolivia
GO

IF NOT EXISTS (SELECT * FROM SYS.INDEXES WHERE NAME='MotivoRechazo_Codigo' 
	AND OBJECT_ID = OBJECT_ID('[GPR].[MotivoRechazo]'))
BEGIN

DROP INDEX [MotivoRechazo_Codigo] ON [GPR].[MotivoRechazo]

END

GO

