USE BelcorpPeru
GO

If Not Exists(select 1 from SYSOBJECTS where type = 'U' and id = OBJECT_ID('dbo.BeneficioCaminoBrillante'))
Begin
CREATE TABLE [dbo].[BeneficioCaminoBrillante](
	[BeneficioID] [int] IDENTITY(1,1) NOT NULL,
	[CodigoNivel] [varchar](3) NULL,
	[CodigoBeneficio] [varchar](15) NOT NULL,
	[NombreBeneficio] [varchar](100) NOT NULL,
	[Descripcion] [varchar](300) NULL,
	[UrlIcono] [varchar](500) NULL,
	[Orden] [int] NULL,
	[FechaRegistro] [datetime] NOT NULL,
	[FechaActualizacion] [datetime] NULL
)
end
GO

USE BelcorpMexico
GO

If Not Exists(select 1 from SYSOBJECTS where type = 'U' and id = OBJECT_ID('dbo.BeneficioCaminoBrillante'))
Begin
CREATE TABLE [dbo].[BeneficioCaminoBrillante](
	[BeneficioID] [int] IDENTITY(1,1) NOT NULL,
	[CodigoNivel] [varchar](3) NULL,
	[CodigoBeneficio] [varchar](15) NOT NULL,
	[NombreBeneficio] [varchar](100) NOT NULL,
	[Descripcion] [varchar](300) NULL,
	[UrlIcono] [varchar](500) NULL,
	[Orden] [int] NULL,
	[FechaRegistro] [datetime] NOT NULL,
	[FechaActualizacion] [datetime] NULL
)
end
GO

USE BelcorpColombia
GO

If Not Exists(select 1 from SYSOBJECTS where type = 'U' and id = OBJECT_ID('dbo.BeneficioCaminoBrillante'))
Begin
CREATE TABLE [dbo].[BeneficioCaminoBrillante](
	[BeneficioID] [int] IDENTITY(1,1) NOT NULL,
	[CodigoNivel] [varchar](3) NULL,
	[CodigoBeneficio] [varchar](15) NOT NULL,
	[NombreBeneficio] [varchar](100) NOT NULL,
	[Descripcion] [varchar](300) NULL,
	[UrlIcono] [varchar](500) NULL,
	[Orden] [int] NULL,
	[FechaRegistro] [datetime] NOT NULL,
	[FechaActualizacion] [datetime] NULL
)
end
GO

USE BelcorpSalvador
GO

If Not Exists(select 1 from SYSOBJECTS where type = 'U' and id = OBJECT_ID('dbo.BeneficioCaminoBrillante'))
Begin
CREATE TABLE [dbo].[BeneficioCaminoBrillante](
	[BeneficioID] [int] IDENTITY(1,1) NOT NULL,
	[CodigoNivel] [varchar](3) NULL,
	[CodigoBeneficio] [varchar](15) NOT NULL,
	[NombreBeneficio] [varchar](100) NOT NULL,
	[Descripcion] [varchar](300) NULL,
	[UrlIcono] [varchar](500) NULL,
	[Orden] [int] NULL,
	[FechaRegistro] [datetime] NOT NULL,
	[FechaActualizacion] [datetime] NULL
)
end
GO

USE BelcorpPuertoRico
GO

If Not Exists(select 1 from SYSOBJECTS where type = 'U' and id = OBJECT_ID('dbo.BeneficioCaminoBrillante'))
Begin
CREATE TABLE [dbo].[BeneficioCaminoBrillante](
	[BeneficioID] [int] IDENTITY(1,1) NOT NULL,
	[CodigoNivel] [varchar](3) NULL,
	[CodigoBeneficio] [varchar](15) NOT NULL,
	[NombreBeneficio] [varchar](100) NOT NULL,
	[Descripcion] [varchar](300) NULL,
	[UrlIcono] [varchar](500) NULL,
	[Orden] [int] NULL,
	[FechaRegistro] [datetime] NOT NULL,
	[FechaActualizacion] [datetime] NULL
)
end
GO

USE BelcorpPanama
GO

If Not Exists(select 1 from SYSOBJECTS where type = 'U' and id = OBJECT_ID('dbo.BeneficioCaminoBrillante'))
Begin
CREATE TABLE [dbo].[BeneficioCaminoBrillante](
	[BeneficioID] [int] IDENTITY(1,1) NOT NULL,
	[CodigoNivel] [varchar](3) NULL,
	[CodigoBeneficio] [varchar](15) NOT NULL,
	[NombreBeneficio] [varchar](100) NOT NULL,
	[Descripcion] [varchar](300) NULL,
	[UrlIcono] [varchar](500) NULL,
	[Orden] [int] NULL,
	[FechaRegistro] [datetime] NOT NULL,
	[FechaActualizacion] [datetime] NULL
)
end
GO

USE BelcorpGuatemala
GO

If Not Exists(select 1 from SYSOBJECTS where type = 'U' and id = OBJECT_ID('dbo.BeneficioCaminoBrillante'))
Begin
CREATE TABLE [dbo].[BeneficioCaminoBrillante](
	[BeneficioID] [int] IDENTITY(1,1) NOT NULL,
	[CodigoNivel] [varchar](3) NULL,
	[CodigoBeneficio] [varchar](15) NOT NULL,
	[NombreBeneficio] [varchar](100) NOT NULL,
	[Descripcion] [varchar](300) NULL,
	[UrlIcono] [varchar](500) NULL,
	[Orden] [int] NULL,
	[FechaRegistro] [datetime] NOT NULL,
	[FechaActualizacion] [datetime] NULL
)
end
GO

USE BelcorpEcuador
GO

If Not Exists(select 1 from SYSOBJECTS where type = 'U' and id = OBJECT_ID('dbo.BeneficioCaminoBrillante'))
Begin
CREATE TABLE [dbo].[BeneficioCaminoBrillante](
	[BeneficioID] [int] IDENTITY(1,1) NOT NULL,
	[CodigoNivel] [varchar](3) NULL,
	[CodigoBeneficio] [varchar](15) NOT NULL,
	[NombreBeneficio] [varchar](100) NOT NULL,
	[Descripcion] [varchar](300) NULL,
	[UrlIcono] [varchar](500) NULL,
	[Orden] [int] NULL,
	[FechaRegistro] [datetime] NOT NULL,
	[FechaActualizacion] [datetime] NULL
)
end
GO

USE BelcorpDominicana
GO

If Not Exists(select 1 from SYSOBJECTS where type = 'U' and id = OBJECT_ID('dbo.BeneficioCaminoBrillante'))
Begin
CREATE TABLE [dbo].[BeneficioCaminoBrillante](
	[BeneficioID] [int] IDENTITY(1,1) NOT NULL,
	[CodigoNivel] [varchar](3) NULL,
	[CodigoBeneficio] [varchar](15) NOT NULL,
	[NombreBeneficio] [varchar](100) NOT NULL,
	[Descripcion] [varchar](300) NULL,
	[UrlIcono] [varchar](500) NULL,
	[Orden] [int] NULL,
	[FechaRegistro] [datetime] NOT NULL,
	[FechaActualizacion] [datetime] NULL
)
end
GO

USE BelcorpCostaRica
GO

If Not Exists(select 1 from SYSOBJECTS where type = 'U' and id = OBJECT_ID('dbo.BeneficioCaminoBrillante'))
Begin
CREATE TABLE [dbo].[BeneficioCaminoBrillante](
	[BeneficioID] [int] IDENTITY(1,1) NOT NULL,
	[CodigoNivel] [varchar](3) NULL,
	[CodigoBeneficio] [varchar](15) NOT NULL,
	[NombreBeneficio] [varchar](100) NOT NULL,
	[Descripcion] [varchar](300) NULL,
	[UrlIcono] [varchar](500) NULL,
	[Orden] [int] NULL,
	[FechaRegistro] [datetime] NOT NULL,
	[FechaActualizacion] [datetime] NULL
)
end
GO

USE BelcorpChile
GO

If Not Exists(select 1 from SYSOBJECTS where type = 'U' and id = OBJECT_ID('dbo.BeneficioCaminoBrillante'))
Begin
CREATE TABLE [dbo].[BeneficioCaminoBrillante](
	[BeneficioID] [int] IDENTITY(1,1) NOT NULL,
	[CodigoNivel] [varchar](3) NULL,
	[CodigoBeneficio] [varchar](15) NOT NULL,
	[NombreBeneficio] [varchar](100) NOT NULL,
	[Descripcion] [varchar](300) NULL,
	[UrlIcono] [varchar](500) NULL,
	[Orden] [int] NULL,
	[FechaRegistro] [datetime] NOT NULL,
	[FechaActualizacion] [datetime] NULL
)
end
GO

USE BelcorpBolivia
GO

If Not Exists(select 1 from SYSOBJECTS where type = 'U' and id = OBJECT_ID('dbo.BeneficioCaminoBrillante'))
Begin
CREATE TABLE [dbo].[BeneficioCaminoBrillante](
	[BeneficioID] [int] IDENTITY(1,1) NOT NULL,
	[CodigoNivel] [varchar](3) NULL,
	[CodigoBeneficio] [varchar](15) NOT NULL,
	[NombreBeneficio] [varchar](100) NOT NULL,
	[Descripcion] [varchar](300) NULL,
	[UrlIcono] [varchar](500) NULL,
	[Orden] [int] NULL,
	[FechaRegistro] [datetime] NOT NULL,
	[FechaActualizacion] [datetime] NULL
)
end
GO