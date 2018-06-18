USE BelcorpPeru
GO

IF NOT EXISTS (SELECT * FROM SYS.INDEXES WHERE NAME='MotivoRechazo_Codigo' 
	AND OBJECT_ID = OBJECT_ID('[GPR].[MotivoRechazo]'))
BEGIN
CREATE NONCLUSTERED INDEX [MotivoRechazo_Codigo] ON [GPR].[MotivoRechazo]
(
	[Codigo] 
)
INCLUDE
 ( 
	[Descripcion],
	[CodigoSomosBelcorp],
	[RequiereGestion]
  )

END

go

USE BelcorpMexico
GO

IF NOT EXISTS (SELECT * FROM SYS.INDEXES WHERE NAME='MotivoRechazo_Codigo' 
	AND OBJECT_ID = OBJECT_ID('[GPR].[MotivoRechazo]'))
BEGIN
CREATE NONCLUSTERED INDEX [MotivoRechazo_Codigo] ON [GPR].[MotivoRechazo]
(
	[Codigo] 
)
INCLUDE
 ( 
	[Descripcion],
	[CodigoSomosBelcorp],
	[RequiereGestion]
  )

END

go

USE BelcorpColombia
GO

IF NOT EXISTS (SELECT * FROM SYS.INDEXES WHERE NAME='MotivoRechazo_Codigo' 
	AND OBJECT_ID = OBJECT_ID('[GPR].[MotivoRechazo]'))
BEGIN
CREATE NONCLUSTERED INDEX [MotivoRechazo_Codigo] ON [GPR].[MotivoRechazo]
(
	[Codigo] 
)
INCLUDE
 ( 
	[Descripcion],
	[CodigoSomosBelcorp],
	[RequiereGestion]
  )

END

go

USE BelcorpSalvador
GO

IF NOT EXISTS (SELECT * FROM SYS.INDEXES WHERE NAME='MotivoRechazo_Codigo' 
	AND OBJECT_ID = OBJECT_ID('[GPR].[MotivoRechazo]'))
BEGIN
CREATE NONCLUSTERED INDEX [MotivoRechazo_Codigo] ON [GPR].[MotivoRechazo]
(
	[Codigo] 
)
INCLUDE
 ( 
	[Descripcion],
	[CodigoSomosBelcorp],
	[RequiereGestion]
  )

END

go

USE BelcorpPuertoRico
GO

IF NOT EXISTS (SELECT * FROM SYS.INDEXES WHERE NAME='MotivoRechazo_Codigo' 
	AND OBJECT_ID = OBJECT_ID('[GPR].[MotivoRechazo]'))
BEGIN
CREATE NONCLUSTERED INDEX [MotivoRechazo_Codigo] ON [GPR].[MotivoRechazo]
(
	[Codigo] 
)
INCLUDE
 ( 
	[Descripcion],
	[CodigoSomosBelcorp],
	[RequiereGestion]
  )

END

go

USE BelcorpPanama
GO

IF NOT EXISTS (SELECT * FROM SYS.INDEXES WHERE NAME='MotivoRechazo_Codigo' 
	AND OBJECT_ID = OBJECT_ID('[GPR].[MotivoRechazo]'))
BEGIN
CREATE NONCLUSTERED INDEX [MotivoRechazo_Codigo] ON [GPR].[MotivoRechazo]
(
	[Codigo] 
)
INCLUDE
 ( 
	[Descripcion],
	[CodigoSomosBelcorp],
	[RequiereGestion]
  )

END

go

USE BelcorpGuatemala
GO

IF NOT EXISTS (SELECT * FROM SYS.INDEXES WHERE NAME='MotivoRechazo_Codigo' 
	AND OBJECT_ID = OBJECT_ID('[GPR].[MotivoRechazo]'))
BEGIN
CREATE NONCLUSTERED INDEX [MotivoRechazo_Codigo] ON [GPR].[MotivoRechazo]
(
	[Codigo] 
)
INCLUDE
 ( 
	[Descripcion],
	[CodigoSomosBelcorp],
	[RequiereGestion]
  )

END

go

USE BelcorpEcuador
GO

IF NOT EXISTS (SELECT * FROM SYS.INDEXES WHERE NAME='MotivoRechazo_Codigo' 
	AND OBJECT_ID = OBJECT_ID('[GPR].[MotivoRechazo]'))
BEGIN
CREATE NONCLUSTERED INDEX [MotivoRechazo_Codigo] ON [GPR].[MotivoRechazo]
(
	[Codigo] 
)
INCLUDE
 ( 
	[Descripcion],
	[CodigoSomosBelcorp],
	[RequiereGestion]
  )

END

go

USE BelcorpDominicana
GO

IF NOT EXISTS (SELECT * FROM SYS.INDEXES WHERE NAME='MotivoRechazo_Codigo' 
	AND OBJECT_ID = OBJECT_ID('[GPR].[MotivoRechazo]'))
BEGIN
CREATE NONCLUSTERED INDEX [MotivoRechazo_Codigo] ON [GPR].[MotivoRechazo]
(
	[Codigo] 
)
INCLUDE
 ( 
	[Descripcion],
	[CodigoSomosBelcorp],
	[RequiereGestion]
  )

END

go

USE BelcorpCostaRica
GO

IF NOT EXISTS (SELECT * FROM SYS.INDEXES WHERE NAME='MotivoRechazo_Codigo' 
	AND OBJECT_ID = OBJECT_ID('[GPR].[MotivoRechazo]'))
BEGIN
CREATE NONCLUSTERED INDEX [MotivoRechazo_Codigo] ON [GPR].[MotivoRechazo]
(
	[Codigo] 
)
INCLUDE
 ( 
	[Descripcion],
	[CodigoSomosBelcorp],
	[RequiereGestion]
  )

END

go

USE BelcorpChile
GO

IF NOT EXISTS (SELECT * FROM SYS.INDEXES WHERE NAME='MotivoRechazo_Codigo' 
	AND OBJECT_ID = OBJECT_ID('[GPR].[MotivoRechazo]'))
BEGIN
CREATE NONCLUSTERED INDEX [MotivoRechazo_Codigo] ON [GPR].[MotivoRechazo]
(
	[Codigo] 
)
INCLUDE
 ( 
	[Descripcion],
	[CodigoSomosBelcorp],
	[RequiereGestion]
  )

END

go

USE BelcorpBolivia
GO

IF NOT EXISTS (SELECT * FROM SYS.INDEXES WHERE NAME='MotivoRechazo_Codigo' 
	AND OBJECT_ID = OBJECT_ID('[GPR].[MotivoRechazo]'))
BEGIN
CREATE NONCLUSTERED INDEX [MotivoRechazo_Codigo] ON [GPR].[MotivoRechazo]
(
	[Codigo] 
)
INCLUDE
 ( 
	[Descripcion],
	[CodigoSomosBelcorp],
	[RequiereGestion]
  )

END

go

