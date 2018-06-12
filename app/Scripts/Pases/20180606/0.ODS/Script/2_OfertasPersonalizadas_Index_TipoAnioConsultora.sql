GO
USE ODS_PE
GO
GO

IF EXISTS (
	SELECT * FROM sys.indexes
	WHERE object_id =
	OBJECT_ID(N'[dbo].[OfertasPersonalizadas]')
	AND name='IDX_OfertasPersonalizadas_TipoAnioConsultora'
)
	DROP INDEX [dbo].[OfertasPersonalizadas].IDX_OfertasPersonalizadas_TipoAnioConsultora
GO

CREATE NONCLUSTERED INDEX IDX_OfertasPersonalizadas_TipoAnioConsultora
ON [dbo].[OfertasPersonalizadas] ([TipoPersonalizacion],[AnioCampanaVenta],[CodConsultora])
INCLUDE ([CUV],[Orden],[FlagRevista])
GO

GO
USE ODS_MX
GO
GO

IF EXISTS (
	SELECT * FROM sys.indexes
	WHERE object_id =
	OBJECT_ID(N'[dbo].[OfertasPersonalizadas]')
	AND name='IDX_OfertasPersonalizadas_TipoAnioConsultora'
)
	DROP INDEX [dbo].[OfertasPersonalizadas].IDX_OfertasPersonalizadas_TipoAnioConsultora
GO

CREATE NONCLUSTERED INDEX IDX_OfertasPersonalizadas_TipoAnioConsultora
ON [dbo].[OfertasPersonalizadas] ([TipoPersonalizacion],[AnioCampanaVenta],[CodConsultora])
INCLUDE ([CUV],[Orden],[FlagRevista])
GO

GO
USE ODS_CO
GO
GO

IF EXISTS (
	SELECT * FROM sys.indexes
	WHERE object_id =
	OBJECT_ID(N'[dbo].[OfertasPersonalizadas]')
	AND name='IDX_OfertasPersonalizadas_TipoAnioConsultora'
)
	DROP INDEX [dbo].[OfertasPersonalizadas].IDX_OfertasPersonalizadas_TipoAnioConsultora
GO

CREATE NONCLUSTERED INDEX IDX_OfertasPersonalizadas_TipoAnioConsultora
ON [dbo].[OfertasPersonalizadas] ([TipoPersonalizacion],[AnioCampanaVenta],[CodConsultora])
INCLUDE ([CUV],[Orden],[FlagRevista])
GO

GO
USE ODS_VE
GO
GO

IF EXISTS (
	SELECT * FROM sys.indexes
	WHERE object_id =
	OBJECT_ID(N'[dbo].[OfertasPersonalizadas]')
	AND name='IDX_OfertasPersonalizadas_TipoAnioConsultora'
)
	DROP INDEX [dbo].[OfertasPersonalizadas].IDX_OfertasPersonalizadas_TipoAnioConsultora
GO

CREATE NONCLUSTERED INDEX IDX_OfertasPersonalizadas_TipoAnioConsultora
ON [dbo].[OfertasPersonalizadas] ([TipoPersonalizacion],[AnioCampanaVenta],[CodConsultora])
INCLUDE ([CUV],[Orden],[FlagRevista])
GO

GO
USE ODS_SV
GO
GO

IF EXISTS (
	SELECT * FROM sys.indexes
	WHERE object_id =
	OBJECT_ID(N'[dbo].[OfertasPersonalizadas]')
	AND name='IDX_OfertasPersonalizadas_TipoAnioConsultora'
)
	DROP INDEX [dbo].[OfertasPersonalizadas].IDX_OfertasPersonalizadas_TipoAnioConsultora
GO

CREATE NONCLUSTERED INDEX IDX_OfertasPersonalizadas_TipoAnioConsultora
ON [dbo].[OfertasPersonalizadas] ([TipoPersonalizacion],[AnioCampanaVenta],[CodConsultora])
INCLUDE ([CUV],[Orden],[FlagRevista])
GO

GO
USE ODS_PR
GO
GO

IF EXISTS (
	SELECT * FROM sys.indexes
	WHERE object_id =
	OBJECT_ID(N'[dbo].[OfertasPersonalizadas]')
	AND name='IDX_OfertasPersonalizadas_TipoAnioConsultora'
)
	DROP INDEX [dbo].[OfertasPersonalizadas].IDX_OfertasPersonalizadas_TipoAnioConsultora
GO

CREATE NONCLUSTERED INDEX IDX_OfertasPersonalizadas_TipoAnioConsultora
ON [dbo].[OfertasPersonalizadas] ([TipoPersonalizacion],[AnioCampanaVenta],[CodConsultora])
INCLUDE ([CUV],[Orden],[FlagRevista])
GO

GO
USE ODS_PA
GO
GO

IF EXISTS (
	SELECT * FROM sys.indexes
	WHERE object_id =
	OBJECT_ID(N'[dbo].[OfertasPersonalizadas]')
	AND name='IDX_OfertasPersonalizadas_TipoAnioConsultora'
)
	DROP INDEX [dbo].[OfertasPersonalizadas].IDX_OfertasPersonalizadas_TipoAnioConsultora
GO

CREATE NONCLUSTERED INDEX IDX_OfertasPersonalizadas_TipoAnioConsultora
ON [dbo].[OfertasPersonalizadas] ([TipoPersonalizacion],[AnioCampanaVenta],[CodConsultora])
INCLUDE ([CUV],[Orden],[FlagRevista])
GO

GO
USE ODS_GT
GO
GO

IF EXISTS (
	SELECT * FROM sys.indexes
	WHERE object_id =
	OBJECT_ID(N'[dbo].[OfertasPersonalizadas]')
	AND name='IDX_OfertasPersonalizadas_TipoAnioConsultora'
)
	DROP INDEX [dbo].[OfertasPersonalizadas].IDX_OfertasPersonalizadas_TipoAnioConsultora
GO

CREATE NONCLUSTERED INDEX IDX_OfertasPersonalizadas_TipoAnioConsultora
ON [dbo].[OfertasPersonalizadas] ([TipoPersonalizacion],[AnioCampanaVenta],[CodConsultora])
INCLUDE ([CUV],[Orden],[FlagRevista])
GO

GO
USE ODS_EC
GO
GO

IF EXISTS (
	SELECT * FROM sys.indexes
	WHERE object_id =
	OBJECT_ID(N'[dbo].[OfertasPersonalizadas]')
	AND name='IDX_OfertasPersonalizadas_TipoAnioConsultora'
)
	DROP INDEX [dbo].[OfertasPersonalizadas].IDX_OfertasPersonalizadas_TipoAnioConsultora
GO

CREATE NONCLUSTERED INDEX IDX_OfertasPersonalizadas_TipoAnioConsultora
ON [dbo].[OfertasPersonalizadas] ([TipoPersonalizacion],[AnioCampanaVenta],[CodConsultora])
INCLUDE ([CUV],[Orden],[FlagRevista])
GO

GO
USE ODS_DO
GO
GO

IF EXISTS (
	SELECT * FROM sys.indexes
	WHERE object_id =
	OBJECT_ID(N'[dbo].[OfertasPersonalizadas]')
	AND name='IDX_OfertasPersonalizadas_TipoAnioConsultora'
)
	DROP INDEX [dbo].[OfertasPersonalizadas].IDX_OfertasPersonalizadas_TipoAnioConsultora
GO

CREATE NONCLUSTERED INDEX IDX_OfertasPersonalizadas_TipoAnioConsultora
ON [dbo].[OfertasPersonalizadas] ([TipoPersonalizacion],[AnioCampanaVenta],[CodConsultora])
INCLUDE ([CUV],[Orden],[FlagRevista])
GO

GO
USE ODS_CR
GO
GO

IF EXISTS (
	SELECT * FROM sys.indexes
	WHERE object_id =
	OBJECT_ID(N'[dbo].[OfertasPersonalizadas]')
	AND name='IDX_OfertasPersonalizadas_TipoAnioConsultora'
)
	DROP INDEX [dbo].[OfertasPersonalizadas].IDX_OfertasPersonalizadas_TipoAnioConsultora
GO

CREATE NONCLUSTERED INDEX IDX_OfertasPersonalizadas_TipoAnioConsultora
ON [dbo].[OfertasPersonalizadas] ([TipoPersonalizacion],[AnioCampanaVenta],[CodConsultora])
INCLUDE ([CUV],[Orden],[FlagRevista])
GO

GO
USE ODS_CL
GO
GO

IF EXISTS (
	SELECT * FROM sys.indexes
	WHERE object_id =
	OBJECT_ID(N'[dbo].[OfertasPersonalizadas]')
	AND name='IDX_OfertasPersonalizadas_TipoAnioConsultora'
)
	DROP INDEX [dbo].[OfertasPersonalizadas].IDX_OfertasPersonalizadas_TipoAnioConsultora
GO

CREATE NONCLUSTERED INDEX IDX_OfertasPersonalizadas_TipoAnioConsultora
ON [dbo].[OfertasPersonalizadas] ([TipoPersonalizacion],[AnioCampanaVenta],[CodConsultora])
INCLUDE ([CUV],[Orden],[FlagRevista])
GO

GO
USE ODS_BO
GO
GO

IF EXISTS (
	SELECT * FROM sys.indexes
	WHERE object_id =
	OBJECT_ID(N'[dbo].[OfertasPersonalizadas]')
	AND name='IDX_OfertasPersonalizadas_TipoAnioConsultora'
)
	DROP INDEX [dbo].[OfertasPersonalizadas].IDX_OfertasPersonalizadas_TipoAnioConsultora
GO

CREATE NONCLUSTERED INDEX IDX_OfertasPersonalizadas_TipoAnioConsultora
ON [dbo].[OfertasPersonalizadas] ([TipoPersonalizacion],[AnioCampanaVenta],[CodConsultora])
INCLUDE ([CUV],[Orden],[FlagRevista])
GO

GO
