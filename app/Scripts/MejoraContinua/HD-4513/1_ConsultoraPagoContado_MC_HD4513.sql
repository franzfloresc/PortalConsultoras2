GO
USE BelcorpPeru
GO
if not exists (select 1 from sysobjects where name='LogConsultoraPagoContado' and xtype='U')
begin
CREATE TABLE [dbo].[LogConsultoraPagoContado](
	[LogConsultoraPagoContadoID] [int] IDENTITY(1,1) NOT NULL,
	[CampaniaID] [int] NULL,
	[ConsultoraID] [int] NULL,
	[TotalAtendido] [float] NULL,
	[TotalDescuento] [float] NULL,
	[TotalFlete] [float] NULL,
	[PagoTotalSinDeuda] [float] NULL,
	[TotalDeuda] [varchar](50) NULL,
	[PagoTotal] [float] NULL,
	[Activo] [bit] NULL,
	[FechaActualizacion] [datetime] NULL CONSTRAINT [df_LogConsultoraPagoContado_FechaActualizacion]  DEFAULT (getdate())
)

end

GO
USE BelcorpMexico
GO
if not exists (select 1 from sysobjects where name='LogConsultoraPagoContado' and xtype='U')
begin
CREATE TABLE [dbo].[LogConsultoraPagoContado](
	[LogConsultoraPagoContadoID] [int] IDENTITY(1,1) NOT NULL,
	[CampaniaID] [int] NULL,
	[ConsultoraID] [int] NULL,
	[TotalAtendido] [float] NULL,
	[TotalDescuento] [float] NULL,
	[TotalFlete] [float] NULL,
	[PagoTotalSinDeuda] [float] NULL,
	[TotalDeuda] [varchar](50) NULL,
	[PagoTotal] [float] NULL,
	[Activo] [bit] NULL,
	[FechaActualizacion] [datetime] NULL CONSTRAINT [df_LogConsultoraPagoContado_FechaActualizacion]  DEFAULT (getdate())
)

end

GO
USE BelcorpColombia
GO
if not exists (select 1 from sysobjects where name='LogConsultoraPagoContado' and xtype='U')
begin
CREATE TABLE [dbo].[LogConsultoraPagoContado](
	[LogConsultoraPagoContadoID] [int] IDENTITY(1,1) NOT NULL,
	[CampaniaID] [int] NULL,
	[ConsultoraID] [int] NULL,
	[TotalAtendido] [float] NULL,
	[TotalDescuento] [float] NULL,
	[TotalFlete] [float] NULL,
	[PagoTotalSinDeuda] [float] NULL,
	[TotalDeuda] [varchar](50) NULL,
	[PagoTotal] [float] NULL,
	[Activo] [bit] NULL,
	[FechaActualizacion] [datetime] NULL CONSTRAINT [df_LogConsultoraPagoContado_FechaActualizacion]  DEFAULT (getdate())
)

end

GO
USE BelcorpSalvador
GO
if not exists (select 1 from sysobjects where name='LogConsultoraPagoContado' and xtype='U')
begin
CREATE TABLE [dbo].[LogConsultoraPagoContado](
	[LogConsultoraPagoContadoID] [int] IDENTITY(1,1) NOT NULL,
	[CampaniaID] [int] NULL,
	[ConsultoraID] [int] NULL,
	[TotalAtendido] [float] NULL,
	[TotalDescuento] [float] NULL,
	[TotalFlete] [float] NULL,
	[PagoTotalSinDeuda] [float] NULL,
	[TotalDeuda] [varchar](50) NULL,
	[PagoTotal] [float] NULL,
	[Activo] [bit] NULL,
	[FechaActualizacion] [datetime] NULL CONSTRAINT [df_LogConsultoraPagoContado_FechaActualizacion]  DEFAULT (getdate())
)

end

GO
USE BelcorpPuertoRico
GO
if not exists (select 1 from sysobjects where name='LogConsultoraPagoContado' and xtype='U')
begin
CREATE TABLE [dbo].[LogConsultoraPagoContado](
	[LogConsultoraPagoContadoID] [int] IDENTITY(1,1) NOT NULL,
	[CampaniaID] [int] NULL,
	[ConsultoraID] [int] NULL,
	[TotalAtendido] [float] NULL,
	[TotalDescuento] [float] NULL,
	[TotalFlete] [float] NULL,
	[PagoTotalSinDeuda] [float] NULL,
	[TotalDeuda] [varchar](50) NULL,
	[PagoTotal] [float] NULL,
	[Activo] [bit] NULL,
	[FechaActualizacion] [datetime] NULL CONSTRAINT [df_LogConsultoraPagoContado_FechaActualizacion]  DEFAULT (getdate())
)

end

GO
USE BelcorpPanama
GO
if not exists (select 1 from sysobjects where name='LogConsultoraPagoContado' and xtype='U')
begin
CREATE TABLE [dbo].[LogConsultoraPagoContado](
	[LogConsultoraPagoContadoID] [int] IDENTITY(1,1) NOT NULL,
	[CampaniaID] [int] NULL,
	[ConsultoraID] [int] NULL,
	[TotalAtendido] [float] NULL,
	[TotalDescuento] [float] NULL,
	[TotalFlete] [float] NULL,
	[PagoTotalSinDeuda] [float] NULL,
	[TotalDeuda] [varchar](50) NULL,
	[PagoTotal] [float] NULL,
	[Activo] [bit] NULL,
	[FechaActualizacion] [datetime] NULL CONSTRAINT [df_LogConsultoraPagoContado_FechaActualizacion]  DEFAULT (getdate())
)

end

GO
USE BelcorpGuatemala
GO
if not exists (select 1 from sysobjects where name='LogConsultoraPagoContado' and xtype='U')
begin
CREATE TABLE [dbo].[LogConsultoraPagoContado](
	[LogConsultoraPagoContadoID] [int] IDENTITY(1,1) NOT NULL,
	[CampaniaID] [int] NULL,
	[ConsultoraID] [int] NULL,
	[TotalAtendido] [float] NULL,
	[TotalDescuento] [float] NULL,
	[TotalFlete] [float] NULL,
	[PagoTotalSinDeuda] [float] NULL,
	[TotalDeuda] [varchar](50) NULL,
	[PagoTotal] [float] NULL,
	[Activo] [bit] NULL,
	[FechaActualizacion] [datetime] NULL CONSTRAINT [df_LogConsultoraPagoContado_FechaActualizacion]  DEFAULT (getdate())
)

end

GO
USE BelcorpEcuador
GO
if not exists (select 1 from sysobjects where name='LogConsultoraPagoContado' and xtype='U')
begin
CREATE TABLE [dbo].[LogConsultoraPagoContado](
	[LogConsultoraPagoContadoID] [int] IDENTITY(1,1) NOT NULL,
	[CampaniaID] [int] NULL,
	[ConsultoraID] [int] NULL,
	[TotalAtendido] [float] NULL,
	[TotalDescuento] [float] NULL,
	[TotalFlete] [float] NULL,
	[PagoTotalSinDeuda] [float] NULL,
	[TotalDeuda] [varchar](50) NULL,
	[PagoTotal] [float] NULL,
	[Activo] [bit] NULL,
	[FechaActualizacion] [datetime] NULL CONSTRAINT [df_LogConsultoraPagoContado_FechaActualizacion]  DEFAULT (getdate())
)

end

GO
USE BelcorpDominicana
GO
if not exists (select 1 from sysobjects where name='LogConsultoraPagoContado' and xtype='U')
begin
CREATE TABLE [dbo].[LogConsultoraPagoContado](
	[LogConsultoraPagoContadoID] [int] IDENTITY(1,1) NOT NULL,
	[CampaniaID] [int] NULL,
	[ConsultoraID] [int] NULL,
	[TotalAtendido] [float] NULL,
	[TotalDescuento] [float] NULL,
	[TotalFlete] [float] NULL,
	[PagoTotalSinDeuda] [float] NULL,
	[TotalDeuda] [varchar](50) NULL,
	[PagoTotal] [float] NULL,
	[Activo] [bit] NULL,
	[FechaActualizacion] [datetime] NULL CONSTRAINT [df_LogConsultoraPagoContado_FechaActualizacion]  DEFAULT (getdate())
)

end

GO
USE BelcorpCostaRica
GO
if not exists (select 1 from sysobjects where name='LogConsultoraPagoContado' and xtype='U')
begin
CREATE TABLE [dbo].[LogConsultoraPagoContado](
	[LogConsultoraPagoContadoID] [int] IDENTITY(1,1) NOT NULL,
	[CampaniaID] [int] NULL,
	[ConsultoraID] [int] NULL,
	[TotalAtendido] [float] NULL,
	[TotalDescuento] [float] NULL,
	[TotalFlete] [float] NULL,
	[PagoTotalSinDeuda] [float] NULL,
	[TotalDeuda] [varchar](50) NULL,
	[PagoTotal] [float] NULL,
	[Activo] [bit] NULL,
	[FechaActualizacion] [datetime] NULL CONSTRAINT [df_LogConsultoraPagoContado_FechaActualizacion]  DEFAULT (getdate())
)

end

GO
USE BelcorpChile
GO
if not exists (select 1 from sysobjects where name='LogConsultoraPagoContado' and xtype='U')
begin
CREATE TABLE [dbo].[LogConsultoraPagoContado](
	[LogConsultoraPagoContadoID] [int] IDENTITY(1,1) NOT NULL,
	[CampaniaID] [int] NULL,
	[ConsultoraID] [int] NULL,
	[TotalAtendido] [float] NULL,
	[TotalDescuento] [float] NULL,
	[TotalFlete] [float] NULL,
	[PagoTotalSinDeuda] [float] NULL,
	[TotalDeuda] [varchar](50) NULL,
	[PagoTotal] [float] NULL,
	[Activo] [bit] NULL,
	[FechaActualizacion] [datetime] NULL CONSTRAINT [df_LogConsultoraPagoContado_FechaActualizacion]  DEFAULT (getdate())
)

end

GO
USE BelcorpBolivia
GO
if not exists (select 1 from sysobjects where name='LogConsultoraPagoContado' and xtype='U')
begin
CREATE TABLE [dbo].[LogConsultoraPagoContado](
	[LogConsultoraPagoContadoID] [int] IDENTITY(1,1) NOT NULL,
	[CampaniaID] [int] NULL,
	[ConsultoraID] [int] NULL,
	[TotalAtendido] [float] NULL,
	[TotalDescuento] [float] NULL,
	[TotalFlete] [float] NULL,
	[PagoTotalSinDeuda] [float] NULL,
	[TotalDeuda] [varchar](50) NULL,
	[PagoTotal] [float] NULL,
	[Activo] [bit] NULL,
	[FechaActualizacion] [datetime] NULL CONSTRAINT [df_LogConsultoraPagoContado_FechaActualizacion]  DEFAULT (getdate())
)

end

GO
