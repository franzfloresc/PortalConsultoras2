USE BelcorpPeru
GO

IF EXISTS (SELECT 1 FROM sysobjects WHERE name = 'OpcionesUsuario' AND type = 'U')
begin
	IF EXISTS (SELECT 1 FROM sysobjects WHERE name = 'UsuarioOpciones' AND type = 'U') 	
		DROP TABLE [dbo].[UsuarioOpciones]

	DROP TABLE [dbo].[OpcionesUsuario]
end
GO
create table OpcionesUsuario(
OpcionesUsuarioId tinyint primary key,
Opcion varchar(100) NOT NULL,
Codigo varchar(50) NOT NULL,
Marcacion bit NULL,
Orden int NULL,
Descripcion varchar(200) NULL,
Activo bit NOT NULL
)
GO

USE BelcorpMexico
GO

IF EXISTS (SELECT 1 FROM sysobjects WHERE name = 'OpcionesUsuario' AND type = 'U')
begin
	IF EXISTS (SELECT 1 FROM sysobjects WHERE name = 'UsuarioOpciones' AND type = 'U') 	
		DROP TABLE [dbo].[UsuarioOpciones]

	DROP TABLE [dbo].[OpcionesUsuario]
end
GO
create table OpcionesUsuario(
OpcionesUsuarioId tinyint primary key,
Opcion varchar(100) NOT NULL,
Codigo varchar(50) NOT NULL,
Marcacion bit NULL,
Orden int NULL,
Descripcion varchar(200) NULL,
Activo bit NOT NULL
)
GO

USE BelcorpColombia
GO

IF EXISTS (SELECT 1 FROM sysobjects WHERE name = 'OpcionesUsuario' AND type = 'U')
begin
	IF EXISTS (SELECT 1 FROM sysobjects WHERE name = 'UsuarioOpciones' AND type = 'U') 	
		DROP TABLE [dbo].[UsuarioOpciones]

	DROP TABLE [dbo].[OpcionesUsuario]
end
GO
create table OpcionesUsuario(
OpcionesUsuarioId tinyint primary key,
Opcion varchar(100) NOT NULL,
Codigo varchar(50) NOT NULL,
Marcacion bit NULL,
Orden int NULL,
Descripcion varchar(200) NULL,
Activo bit NOT NULL
)
GO

USE BelcorpSalvador
GO

IF EXISTS (SELECT 1 FROM sysobjects WHERE name = 'OpcionesUsuario' AND type = 'U')
begin
	IF EXISTS (SELECT 1 FROM sysobjects WHERE name = 'UsuarioOpciones' AND type = 'U') 	
		DROP TABLE [dbo].[UsuarioOpciones]

	DROP TABLE [dbo].[OpcionesUsuario]
end
GO
create table OpcionesUsuario(
OpcionesUsuarioId tinyint primary key,
Opcion varchar(100) NOT NULL,
Codigo varchar(50) NOT NULL,
Marcacion bit NULL,
Orden int NULL,
Descripcion varchar(200) NULL,
Activo bit NOT NULL
)
GO

USE BelcorpPuertoRico
GO

IF EXISTS (SELECT 1 FROM sysobjects WHERE name = 'OpcionesUsuario' AND type = 'U')
begin
	IF EXISTS (SELECT 1 FROM sysobjects WHERE name = 'UsuarioOpciones' AND type = 'U') 	
		DROP TABLE [dbo].[UsuarioOpciones]

	DROP TABLE [dbo].[OpcionesUsuario]
end
GO
create table OpcionesUsuario(
OpcionesUsuarioId tinyint primary key,
Opcion varchar(100) NOT NULL,
Codigo varchar(50) NOT NULL,
Marcacion bit NULL,
Orden int NULL,
Descripcion varchar(200) NULL,
Activo bit NOT NULL
)
GO

USE BelcorpPanama
GO

IF EXISTS (SELECT 1 FROM sysobjects WHERE name = 'OpcionesUsuario' AND type = 'U')
begin
	IF EXISTS (SELECT 1 FROM sysobjects WHERE name = 'UsuarioOpciones' AND type = 'U') 	
		DROP TABLE [dbo].[UsuarioOpciones]

	DROP TABLE [dbo].[OpcionesUsuario]
end
GO
create table OpcionesUsuario(
OpcionesUsuarioId tinyint primary key,
Opcion varchar(100) NOT NULL,
Codigo varchar(50) NOT NULL,
Marcacion bit NULL,
Orden int NULL,
Descripcion varchar(200) NULL,
Activo bit NOT NULL
)
GO

USE BelcorpGuatemala
GO

IF EXISTS (SELECT 1 FROM sysobjects WHERE name = 'OpcionesUsuario' AND type = 'U')
begin
	IF EXISTS (SELECT 1 FROM sysobjects WHERE name = 'UsuarioOpciones' AND type = 'U') 	
		DROP TABLE [dbo].[UsuarioOpciones]

	DROP TABLE [dbo].[OpcionesUsuario]
end
GO
create table OpcionesUsuario(
OpcionesUsuarioId tinyint primary key,
Opcion varchar(100) NOT NULL,
Codigo varchar(50) NOT NULL,
Marcacion bit NULL,
Orden int NULL,
Descripcion varchar(200) NULL,
Activo bit NOT NULL
)
GO

USE BelcorpEcuador
GO

IF EXISTS (SELECT 1 FROM sysobjects WHERE name = 'OpcionesUsuario' AND type = 'U')
begin
	IF EXISTS (SELECT 1 FROM sysobjects WHERE name = 'UsuarioOpciones' AND type = 'U') 	
		DROP TABLE [dbo].[UsuarioOpciones]

	DROP TABLE [dbo].[OpcionesUsuario]
end
GO
create table OpcionesUsuario(
OpcionesUsuarioId tinyint primary key,
Opcion varchar(100) NOT NULL,
Codigo varchar(50) NOT NULL,
Marcacion bit NULL,
Orden int NULL,
Descripcion varchar(200) NULL,
Activo bit NOT NULL
)
GO

USE BelcorpDominicana
GO

IF EXISTS (SELECT 1 FROM sysobjects WHERE name = 'OpcionesUsuario' AND type = 'U')
begin
	IF EXISTS (SELECT 1 FROM sysobjects WHERE name = 'UsuarioOpciones' AND type = 'U') 	
		DROP TABLE [dbo].[UsuarioOpciones]

	DROP TABLE [dbo].[OpcionesUsuario]
end
GO
create table OpcionesUsuario(
OpcionesUsuarioId tinyint primary key,
Opcion varchar(100) NOT NULL,
Codigo varchar(50) NOT NULL,
Marcacion bit NULL,
Orden int NULL,
Descripcion varchar(200) NULL,
Activo bit NOT NULL
)
GO

USE BelcorpCostaRica
GO

IF EXISTS (SELECT 1 FROM sysobjects WHERE name = 'OpcionesUsuario' AND type = 'U')
begin
	IF EXISTS (SELECT 1 FROM sysobjects WHERE name = 'UsuarioOpciones' AND type = 'U') 	
		DROP TABLE [dbo].[UsuarioOpciones]

	DROP TABLE [dbo].[OpcionesUsuario]
end
GO
create table OpcionesUsuario(
OpcionesUsuarioId tinyint primary key,
Opcion varchar(100) NOT NULL,
Codigo varchar(50) NOT NULL,
Marcacion bit NULL,
Orden int NULL,
Descripcion varchar(200) NULL,
Activo bit NOT NULL
)
GO

USE BelcorpChile
GO

IF EXISTS (SELECT 1 FROM sysobjects WHERE name = 'OpcionesUsuario' AND type = 'U')
begin
	IF EXISTS (SELECT 1 FROM sysobjects WHERE name = 'UsuarioOpciones' AND type = 'U') 	
		DROP TABLE [dbo].[UsuarioOpciones]

	DROP TABLE [dbo].[OpcionesUsuario]
end
GO
create table OpcionesUsuario(
OpcionesUsuarioId tinyint primary key,
Opcion varchar(100) NOT NULL,
Codigo varchar(50) NOT NULL,
Marcacion bit NULL,
Orden int NULL,
Descripcion varchar(200) NULL,
Activo bit NOT NULL
)
GO

USE BelcorpBolivia
GO

IF EXISTS (SELECT 1 FROM sysobjects WHERE name = 'OpcionesUsuario' AND type = 'U')
begin
	IF EXISTS (SELECT 1 FROM sysobjects WHERE name = 'UsuarioOpciones' AND type = 'U') 	
		DROP TABLE [dbo].[UsuarioOpciones]

	DROP TABLE [dbo].[OpcionesUsuario]
end
GO
create table OpcionesUsuario(
OpcionesUsuarioId tinyint primary key,
Opcion varchar(100) NOT NULL,
Codigo varchar(50) NOT NULL,
Marcacion bit NULL,
Orden int NULL,
Descripcion varchar(200) NULL,
Activo bit NOT NULL
)
GO

