USE BelcorpPeru
GO

IF EXISTS (SELECT name FROM sysobjects WHERE name = 'GetUsuarioOpciones' AND type = 'P')
	DROP PROCEDURE [dbo].[GetUsuarioOpciones]
GO
CREATE PROCEDURE GetUsuarioOpciones
@CodigoUsuario varchar(20)
as
begin
	select 
		ou.Opcion, 
		ou.Codigo,
		ou.OpcionesUsuarioId,
		case 
			when uo.Activo IS NULL then ou.Marcacion
			else uo.Activo 
		end CheckBox,
		ou.Descripcion
	from OpcionesUsuario ou
	left join UsuarioOpciones uo on ou.OpcionesUsuarioId = uo.OpcionesUsuarioId and uo.CodigoUsuario = @CodigoUsuario
	where ou.Activo = 1	
	Order By Orden Asc
end
GO

USE BelcorpMexico
GO

IF EXISTS (SELECT name FROM sysobjects WHERE name = 'GetUsuarioOpciones' AND type = 'P')
	DROP PROCEDURE [dbo].[GetUsuarioOpciones]
GO
CREATE PROCEDURE GetUsuarioOpciones
@CodigoUsuario varchar(20)
as
begin
	select 
		ou.Opcion, 
		ou.Codigo,
		ou.OpcionesUsuarioId,
		case 
			when uo.Activo IS NULL then ou.Marcacion
			else uo.Activo 
		end CheckBox,
		ou.Descripcion
	from OpcionesUsuario ou
	left join UsuarioOpciones uo on ou.OpcionesUsuarioId = uo.OpcionesUsuarioId and uo.CodigoUsuario = @CodigoUsuario
	where ou.Activo = 1	
	Order By Orden Asc
end
GO

USE BelcorpColombia
GO

IF EXISTS (SELECT name FROM sysobjects WHERE name = 'GetUsuarioOpciones' AND type = 'P')
	DROP PROCEDURE [dbo].[GetUsuarioOpciones]
GO
CREATE PROCEDURE GetUsuarioOpciones
@CodigoUsuario varchar(20)
as
begin
	select 
		ou.Opcion, 
		ou.Codigo,
		ou.OpcionesUsuarioId,
		case 
			when uo.Activo IS NULL then ou.Marcacion
			else uo.Activo 
		end CheckBox,
		ou.Descripcion
	from OpcionesUsuario ou
	left join UsuarioOpciones uo on ou.OpcionesUsuarioId = uo.OpcionesUsuarioId and uo.CodigoUsuario = @CodigoUsuario
	where ou.Activo = 1	
	Order By Orden Asc
end
GO

USE BelcorpSalvador
GO

IF EXISTS (SELECT name FROM sysobjects WHERE name = 'GetUsuarioOpciones' AND type = 'P')
	DROP PROCEDURE [dbo].[GetUsuarioOpciones]
GO
CREATE PROCEDURE GetUsuarioOpciones
@CodigoUsuario varchar(20)
as
begin
	select 
		ou.Opcion, 
		ou.Codigo,
		ou.OpcionesUsuarioId,
		case 
			when uo.Activo IS NULL then ou.Marcacion
			else uo.Activo 
		end CheckBox,
		ou.Descripcion
	from OpcionesUsuario ou
	left join UsuarioOpciones uo on ou.OpcionesUsuarioId = uo.OpcionesUsuarioId and uo.CodigoUsuario = @CodigoUsuario
	where ou.Activo = 1	
	Order By Orden Asc
end
GO

USE BelcorpPuertoRico
GO

IF EXISTS (SELECT name FROM sysobjects WHERE name = 'GetUsuarioOpciones' AND type = 'P')
	DROP PROCEDURE [dbo].[GetUsuarioOpciones]
GO
CREATE PROCEDURE GetUsuarioOpciones
@CodigoUsuario varchar(20)
as
begin
	select 
		ou.Opcion, 
		ou.Codigo,
		ou.OpcionesUsuarioId,
		case 
			when uo.Activo IS NULL then ou.Marcacion
			else uo.Activo 
		end CheckBox,
		ou.Descripcion
	from OpcionesUsuario ou
	left join UsuarioOpciones uo on ou.OpcionesUsuarioId = uo.OpcionesUsuarioId and uo.CodigoUsuario = @CodigoUsuario
	where ou.Activo = 1	
	Order By Orden Asc
end
GO

USE BelcorpPanama
GO

IF EXISTS (SELECT name FROM sysobjects WHERE name = 'GetUsuarioOpciones' AND type = 'P')
	DROP PROCEDURE [dbo].[GetUsuarioOpciones]
GO
CREATE PROCEDURE GetUsuarioOpciones
@CodigoUsuario varchar(20)
as
begin
	select 
		ou.Opcion, 
		ou.Codigo,
		ou.OpcionesUsuarioId,
		case 
			when uo.Activo IS NULL then ou.Marcacion
			else uo.Activo 
		end CheckBox,
		ou.Descripcion
	from OpcionesUsuario ou
	left join UsuarioOpciones uo on ou.OpcionesUsuarioId = uo.OpcionesUsuarioId and uo.CodigoUsuario = @CodigoUsuario
	where ou.Activo = 1	
	Order By Orden Asc
end
GO

USE BelcorpGuatemala
GO

IF EXISTS (SELECT name FROM sysobjects WHERE name = 'GetUsuarioOpciones' AND type = 'P')
	DROP PROCEDURE [dbo].[GetUsuarioOpciones]
GO
CREATE PROCEDURE GetUsuarioOpciones
@CodigoUsuario varchar(20)
as
begin
	select 
		ou.Opcion, 
		ou.Codigo,
		ou.OpcionesUsuarioId,
		case 
			when uo.Activo IS NULL then ou.Marcacion
			else uo.Activo 
		end CheckBox,
		ou.Descripcion
	from OpcionesUsuario ou
	left join UsuarioOpciones uo on ou.OpcionesUsuarioId = uo.OpcionesUsuarioId and uo.CodigoUsuario = @CodigoUsuario
	where ou.Activo = 1	
	Order By Orden Asc
end
GO

USE BelcorpEcuador
GO

IF EXISTS (SELECT name FROM sysobjects WHERE name = 'GetUsuarioOpciones' AND type = 'P')
	DROP PROCEDURE [dbo].[GetUsuarioOpciones]
GO
CREATE PROCEDURE GetUsuarioOpciones
@CodigoUsuario varchar(20)
as
begin
	select 
		ou.Opcion, 
		ou.Codigo,
		ou.OpcionesUsuarioId,
		case 
			when uo.Activo IS NULL then ou.Marcacion
			else uo.Activo 
		end CheckBox,
		ou.Descripcion
	from OpcionesUsuario ou
	left join UsuarioOpciones uo on ou.OpcionesUsuarioId = uo.OpcionesUsuarioId and uo.CodigoUsuario = @CodigoUsuario
	where ou.Activo = 1	
	Order By Orden Asc
end
GO

USE BelcorpDominicana
GO

IF EXISTS (SELECT name FROM sysobjects WHERE name = 'GetUsuarioOpciones' AND type = 'P')
	DROP PROCEDURE [dbo].[GetUsuarioOpciones]
GO
CREATE PROCEDURE GetUsuarioOpciones
@CodigoUsuario varchar(20)
as
begin
	select 
		ou.Opcion, 
		ou.Codigo,
		ou.OpcionesUsuarioId,
		case 
			when uo.Activo IS NULL then ou.Marcacion
			else uo.Activo 
		end CheckBox,
		ou.Descripcion
	from OpcionesUsuario ou
	left join UsuarioOpciones uo on ou.OpcionesUsuarioId = uo.OpcionesUsuarioId and uo.CodigoUsuario = @CodigoUsuario
	where ou.Activo = 1	
	Order By Orden Asc
end
GO

USE BelcorpCostaRica
GO

IF EXISTS (SELECT name FROM sysobjects WHERE name = 'GetUsuarioOpciones' AND type = 'P')
	DROP PROCEDURE [dbo].[GetUsuarioOpciones]
GO
CREATE PROCEDURE GetUsuarioOpciones
@CodigoUsuario varchar(20)
as
begin
	select 
		ou.Opcion, 
		ou.Codigo,
		ou.OpcionesUsuarioId,
		case 
			when uo.Activo IS NULL then ou.Marcacion
			else uo.Activo 
		end CheckBox,
		ou.Descripcion
	from OpcionesUsuario ou
	left join UsuarioOpciones uo on ou.OpcionesUsuarioId = uo.OpcionesUsuarioId and uo.CodigoUsuario = @CodigoUsuario
	where ou.Activo = 1	
	Order By Orden Asc
end
GO

USE BelcorpChile
GO

IF EXISTS (SELECT name FROM sysobjects WHERE name = 'GetUsuarioOpciones' AND type = 'P')
	DROP PROCEDURE [dbo].[GetUsuarioOpciones]
GO
CREATE PROCEDURE GetUsuarioOpciones
@CodigoUsuario varchar(20)
as
begin
	select 
		ou.Opcion, 
		ou.Codigo,
		ou.OpcionesUsuarioId,
		case 
			when uo.Activo IS NULL then ou.Marcacion
			else uo.Activo 
		end CheckBox,
		ou.Descripcion
	from OpcionesUsuario ou
	left join UsuarioOpciones uo on ou.OpcionesUsuarioId = uo.OpcionesUsuarioId and uo.CodigoUsuario = @CodigoUsuario
	where ou.Activo = 1	
	Order By Orden Asc
end
GO

USE BelcorpBolivia
GO

IF EXISTS (SELECT name FROM sysobjects WHERE name = 'GetUsuarioOpciones' AND type = 'P')
	DROP PROCEDURE [dbo].[GetUsuarioOpciones]
GO
CREATE PROCEDURE GetUsuarioOpciones
@CodigoUsuario varchar(20)
as
begin
	select 
		ou.Opcion, 
		ou.Codigo,
		ou.OpcionesUsuarioId,
		case 
			when uo.Activo IS NULL then ou.Marcacion
			else uo.Activo 
		end CheckBox,
		ou.Descripcion
	from OpcionesUsuario ou
	left join UsuarioOpciones uo on ou.OpcionesUsuarioId = uo.OpcionesUsuarioId and uo.CodigoUsuario = @CodigoUsuario
	where ou.Activo = 1	
	Order By Orden Asc
end
GO

