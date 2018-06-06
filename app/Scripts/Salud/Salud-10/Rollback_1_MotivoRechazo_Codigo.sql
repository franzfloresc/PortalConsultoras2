USE BelcorpPeru
GO

IF EXISTS (SELECT * FROM SYS.INDEXES WHERE NAME='MotivoRechazo_Codigo' 
	AND OBJECT_ID = OBJECT_ID('[GPR].[MotivoRechazo]'))
BEGIN

DROP INDEX [MotivoRechazo_Codigo] ON [GPR].[MotivoRechazo]

END

GO

USE BelcorpMexico
GO

IF EXISTS (SELECT * FROM SYS.INDEXES WHERE NAME='MotivoRechazo_Codigo' 
	AND OBJECT_ID = OBJECT_ID('[GPR].[MotivoRechazo]'))
BEGIN

DROP INDEX [MotivoRechazo_Codigo] ON [GPR].[MotivoRechazo]

END

GO

USE BelcorpColombia
GO

IF EXISTS (SELECT * FROM SYS.INDEXES WHERE NAME='MotivoRechazo_Codigo' 
	AND OBJECT_ID = OBJECT_ID('[GPR].[MotivoRechazo]'))
BEGIN

DROP INDEX [MotivoRechazo_Codigo] ON [GPR].[MotivoRechazo]

END

GO

USE BelcorpSalvador
GO

IF EXISTS (SELECT * FROM SYS.INDEXES WHERE NAME='MotivoRechazo_Codigo' 
	AND OBJECT_ID = OBJECT_ID('[GPR].[MotivoRechazo]'))
BEGIN

DROP INDEX [MotivoRechazo_Codigo] ON [GPR].[MotivoRechazo]

END

GO

USE BelcorpPuertoRico
GO

IF EXISTS (SELECT * FROM SYS.INDEXES WHERE NAME='MotivoRechazo_Codigo' 
	AND OBJECT_ID = OBJECT_ID('[GPR].[MotivoRechazo]'))
BEGIN

DROP INDEX [MotivoRechazo_Codigo] ON [GPR].[MotivoRechazo]

END

GO

USE BelcorpPanama
GO

IF EXISTS (SELECT * FROM SYS.INDEXES WHERE NAME='MotivoRechazo_Codigo' 
	AND OBJECT_ID = OBJECT_ID('[GPR].[MotivoRechazo]'))
BEGIN

DROP INDEX [MotivoRechazo_Codigo] ON [GPR].[MotivoRechazo]

END

GO

USE BelcorpGuatemala
GO

IF EXISTS (SELECT * FROM SYS.INDEXES WHERE NAME='MotivoRechazo_Codigo' 
	AND OBJECT_ID = OBJECT_ID('[GPR].[MotivoRechazo]'))
BEGIN

DROP INDEX [MotivoRechazo_Codigo] ON [GPR].[MotivoRechazo]

END

GO

USE BelcorpEcuador
GO

IF EXISTS (SELECT * FROM SYS.INDEXES WHERE NAME='MotivoRechazo_Codigo' 
	AND OBJECT_ID = OBJECT_ID('[GPR].[MotivoRechazo]'))
BEGIN

DROP INDEX [MotivoRechazo_Codigo] ON [GPR].[MotivoRechazo]

END

GO

USE BelcorpDominicana
GO

IF EXISTS (SELECT * FROM SYS.INDEXES WHERE NAME='MotivoRechazo_Codigo' 
	AND OBJECT_ID = OBJECT_ID('[GPR].[MotivoRechazo]'))
BEGIN

DROP INDEX [MotivoRechazo_Codigo] ON [GPR].[MotivoRechazo]

END

GO

USE BelcorpCostaRica
GO

IF EXISTS (SELECT * FROM SYS.INDEXES WHERE NAME='MotivoRechazo_Codigo' 
	AND OBJECT_ID = OBJECT_ID('[GPR].[MotivoRechazo]'))
BEGIN

DROP INDEX [MotivoRechazo_Codigo] ON [GPR].[MotivoRechazo]

END

GO

USE BelcorpChile
GO

IF EXISTS (SELECT * FROM SYS.INDEXES WHERE NAME='MotivoRechazo_Codigo' 
	AND OBJECT_ID = OBJECT_ID('[GPR].[MotivoRechazo]'))
BEGIN

DROP INDEX [MotivoRechazo_Codigo] ON [GPR].[MotivoRechazo]

END

GO

USE BelcorpBolivia
GO

IF EXISTS (SELECT * FROM SYS.INDEXES WHERE NAME='MotivoRechazo_Codigo' 
	AND OBJECT_ID = OBJECT_ID('[GPR].[MotivoRechazo]'))
BEGIN

DROP INDEX [MotivoRechazo_Codigo] ON [GPR].[MotivoRechazo]

END

GO

