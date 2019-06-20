USE BelcorpPeru
GO

IF EXISTS (SELECT name FROM sysobjects WHERE name = 'UsuarioOpciones' AND type = 'U')
	DROP TABLE [dbo].[UsuarioOpciones]
GO
create table UsuarioOpciones(
CodigoUsuario varchar(20) foreign key references Usuario(CodigoUsuario),
OpcionesUsuarioId tinyint foreign key references OpcionesUsuario(OpcionesUsuarioId),
Activo bit,
FechaModificacion datetime,
primary key (CodigoUsuario,OpcionesUsuarioId)
)
GO

USE BelcorpMexico
GO

IF EXISTS (SELECT name FROM sysobjects WHERE name = 'UsuarioOpciones' AND type = 'U')
	DROP TABLE [dbo].[UsuarioOpciones]
GO
create table UsuarioOpciones(
CodigoUsuario varchar(20) foreign key references Usuario(CodigoUsuario),
OpcionesUsuarioId tinyint foreign key references OpcionesUsuario(OpcionesUsuarioId),
Activo bit,
FechaModificacion datetime,
primary key (CodigoUsuario,OpcionesUsuarioId)
)
GO

USE BelcorpColombia
GO

IF EXISTS (SELECT name FROM sysobjects WHERE name = 'UsuarioOpciones' AND type = 'U')
	DROP TABLE [dbo].[UsuarioOpciones]
GO
create table UsuarioOpciones(
CodigoUsuario varchar(20) foreign key references Usuario(CodigoUsuario),
OpcionesUsuarioId tinyint foreign key references OpcionesUsuario(OpcionesUsuarioId),
Activo bit,
FechaModificacion datetime,
primary key (CodigoUsuario,OpcionesUsuarioId)
)
GO

USE BelcorpSalvador
GO

IF EXISTS (SELECT name FROM sysobjects WHERE name = 'UsuarioOpciones' AND type = 'U')
	DROP TABLE [dbo].[UsuarioOpciones]
GO
create table UsuarioOpciones(
CodigoUsuario varchar(20) foreign key references Usuario(CodigoUsuario),
OpcionesUsuarioId tinyint foreign key references OpcionesUsuario(OpcionesUsuarioId),
Activo bit,
FechaModificacion datetime,
primary key (CodigoUsuario,OpcionesUsuarioId)
)
GO

USE BelcorpPuertoRico
GO

IF EXISTS (SELECT name FROM sysobjects WHERE name = 'UsuarioOpciones' AND type = 'U')
	DROP TABLE [dbo].[UsuarioOpciones]
GO
create table UsuarioOpciones(
CodigoUsuario varchar(20) foreign key references Usuario(CodigoUsuario),
OpcionesUsuarioId tinyint foreign key references OpcionesUsuario(OpcionesUsuarioId),
Activo bit,
FechaModificacion datetime,
primary key (CodigoUsuario,OpcionesUsuarioId)
)
GO

USE BelcorpPanama
GO

IF EXISTS (SELECT name FROM sysobjects WHERE name = 'UsuarioOpciones' AND type = 'U')
	DROP TABLE [dbo].[UsuarioOpciones]
GO
create table UsuarioOpciones(
CodigoUsuario varchar(20) foreign key references Usuario(CodigoUsuario),
OpcionesUsuarioId tinyint foreign key references OpcionesUsuario(OpcionesUsuarioId),
Activo bit,
FechaModificacion datetime,
primary key (CodigoUsuario,OpcionesUsuarioId)
)
GO

USE BelcorpGuatemala
GO

IF EXISTS (SELECT name FROM sysobjects WHERE name = 'UsuarioOpciones' AND type = 'U')
	DROP TABLE [dbo].[UsuarioOpciones]
GO
create table UsuarioOpciones(
CodigoUsuario varchar(20) foreign key references Usuario(CodigoUsuario),
OpcionesUsuarioId tinyint foreign key references OpcionesUsuario(OpcionesUsuarioId),
Activo bit,
FechaModificacion datetime,
primary key (CodigoUsuario,OpcionesUsuarioId)
)
GO

USE BelcorpEcuador
GO

IF EXISTS (SELECT name FROM sysobjects WHERE name = 'UsuarioOpciones' AND type = 'U')
	DROP TABLE [dbo].[UsuarioOpciones]
GO
create table UsuarioOpciones(
CodigoUsuario varchar(20) foreign key references Usuario(CodigoUsuario),
OpcionesUsuarioId tinyint foreign key references OpcionesUsuario(OpcionesUsuarioId),
Activo bit,
FechaModificacion datetime,
primary key (CodigoUsuario,OpcionesUsuarioId)
)
GO

USE BelcorpDominicana
GO

IF EXISTS (SELECT name FROM sysobjects WHERE name = 'UsuarioOpciones' AND type = 'U')
	DROP TABLE [dbo].[UsuarioOpciones]
GO
create table UsuarioOpciones(
CodigoUsuario varchar(20) foreign key references Usuario(CodigoUsuario),
OpcionesUsuarioId tinyint foreign key references OpcionesUsuario(OpcionesUsuarioId),
Activo bit,
FechaModificacion datetime,
primary key (CodigoUsuario,OpcionesUsuarioId)
)
GO

USE BelcorpCostaRica
GO

IF EXISTS (SELECT name FROM sysobjects WHERE name = 'UsuarioOpciones' AND type = 'U')
	DROP TABLE [dbo].[UsuarioOpciones]
GO
create table UsuarioOpciones(
CodigoUsuario varchar(20) foreign key references Usuario(CodigoUsuario),
OpcionesUsuarioId tinyint foreign key references OpcionesUsuario(OpcionesUsuarioId),
Activo bit,
FechaModificacion datetime,
primary key (CodigoUsuario,OpcionesUsuarioId)
)
GO

USE BelcorpChile
GO

IF EXISTS (SELECT name FROM sysobjects WHERE name = 'UsuarioOpciones' AND type = 'U')
	DROP TABLE [dbo].[UsuarioOpciones]
GO
create table UsuarioOpciones(
CodigoUsuario varchar(20) foreign key references Usuario(CodigoUsuario),
OpcionesUsuarioId tinyint foreign key references OpcionesUsuario(OpcionesUsuarioId),
Activo bit,
FechaModificacion datetime,
primary key (CodigoUsuario,OpcionesUsuarioId)
)
GO

USE BelcorpBolivia
GO

IF EXISTS (SELECT name FROM sysobjects WHERE name = 'UsuarioOpciones' AND type = 'U')
	DROP TABLE [dbo].[UsuarioOpciones]
GO
create table UsuarioOpciones(
CodigoUsuario varchar(20) foreign key references Usuario(CodigoUsuario),
OpcionesUsuarioId tinyint foreign key references OpcionesUsuario(OpcionesUsuarioId),
Activo bit,
FechaModificacion datetime,
primary key (CodigoUsuario,OpcionesUsuarioId)
)
GO



