USE BelcorpBolivia
go
alter procedure dbo.ValidateEmail
	@Email varchar(50),
	@PaisID int
as
begin
	select count(*) Cantidad,
	IsNull((select CodigoUsuario from dbo.Usuario where EMail = @Email), '') CodigoUsuario,
	(select CodigoISO from Pais where PaisID = @PaisID) CodigoISO,
	IsNull((select Top(1) Descripcion from FormularioDato where TipoFormularioID = 1103 and PaisID = @PaisID), '') Descripcion,
	IsNull((select Nombre from dbo.Usuario where EMail = @Email), '') Nombre
	from dbo.Usuario
	where EMail = @Email;
end
go
/*end*/

USE BelcorpChile
go
alter procedure dbo.ValidateEmail
	@Email varchar(50),
	@PaisID int
as
begin
	select count(*) Cantidad,
	IsNull((select CodigoUsuario from dbo.Usuario where EMail = @Email), '') CodigoUsuario,
	(select CodigoISO from Pais where PaisID = @PaisID) CodigoISO,
	IsNull((select Top(1) Descripcion from FormularioDato where TipoFormularioID = 1103 and PaisID = @PaisID), '') Descripcion,
	IsNull((select Nombre from dbo.Usuario where EMail = @Email), '') Nombre
	from dbo.Usuario
	where EMail = @Email;
end
go
/*end*/

USE BelcorpCostaRica
go
alter procedure dbo.ValidateEmail
	@Email varchar(50),
	@PaisID int
as
begin
	select count(*) Cantidad,
	IsNull((select CodigoUsuario from dbo.Usuario where EMail = @Email), '') CodigoUsuario,
	(select CodigoISO from Pais where PaisID = @PaisID) CodigoISO,
	IsNull((select Top(1) Descripcion from FormularioDato where TipoFormularioID = 1103 and PaisID = @PaisID), '') Descripcion,
	IsNull((select Nombre from dbo.Usuario where EMail = @Email), '') Nombre
	from dbo.Usuario
	where EMail = @Email;
end
go
/*end*/

USE BelcorpDominicana
go
alter procedure dbo.ValidateEmail
	@Email varchar(50),
	@PaisID int
as
begin
	select count(*) Cantidad,
	IsNull((select CodigoUsuario from dbo.Usuario where EMail = @Email), '') CodigoUsuario,
	(select CodigoISO from Pais where PaisID = @PaisID) CodigoISO,
	IsNull((select Top(1) Descripcion from FormularioDato where TipoFormularioID = 1103 and PaisID = @PaisID), '') Descripcion,
	IsNull((select Nombre from dbo.Usuario where EMail = @Email), '') Nombre
	from dbo.Usuario
	where EMail = @Email;
end
go
/*end*/

USE BelcorpEcuador
go
alter procedure dbo.ValidateEmail
	@Email varchar(50),
	@PaisID int
as
begin
	select count(*) Cantidad,
	IsNull((select CodigoUsuario from dbo.Usuario where EMail = @Email), '') CodigoUsuario,
	(select CodigoISO from Pais where PaisID = @PaisID) CodigoISO,
	IsNull((select Top(1) Descripcion from FormularioDato where TipoFormularioID = 1103 and PaisID = @PaisID), '') Descripcion,
	IsNull((select Nombre from dbo.Usuario where EMail = @Email), '') Nombre
	from dbo.Usuario
	where EMail = @Email;
end
go
/*end*/

USE BelcorpGuatemala
go
alter procedure dbo.ValidateEmail
	@Email varchar(50),
	@PaisID int
as
begin
	select count(*) Cantidad,
	IsNull((select CodigoUsuario from dbo.Usuario where EMail = @Email), '') CodigoUsuario,
	(select CodigoISO from Pais where PaisID = @PaisID) CodigoISO,
	IsNull((select Top(1) Descripcion from FormularioDato where TipoFormularioID = 1103 and PaisID = @PaisID), '') Descripcion,
	IsNull((select Nombre from dbo.Usuario where EMail = @Email), '') Nombre
	from dbo.Usuario
	where EMail = @Email;
end
go
/*end*/

USE BelcorpPanama
go
alter procedure dbo.ValidateEmail
	@Email varchar(50),
	@PaisID int
as
begin
	select count(*) Cantidad,
	IsNull((select CodigoUsuario from dbo.Usuario where EMail = @Email), '') CodigoUsuario,
	(select CodigoISO from Pais where PaisID = @PaisID) CodigoISO,
	IsNull((select Top(1) Descripcion from FormularioDato where TipoFormularioID = 1103 and PaisID = @PaisID), '') Descripcion,
	IsNull((select Nombre from dbo.Usuario where EMail = @Email), '') Nombre
	from dbo.Usuario
	where EMail = @Email;
end
go
/*end*/

USE BelcorpPuertoRico
go
alter procedure dbo.ValidateEmail
	@Email varchar(50),
	@PaisID int
as
begin
	select count(*) Cantidad,
	IsNull((select CodigoUsuario from dbo.Usuario where EMail = @Email), '') CodigoUsuario,
	(select CodigoISO from Pais where PaisID = @PaisID) CodigoISO,
	IsNull((select Top(1) Descripcion from FormularioDato where TipoFormularioID = 1103 and PaisID = @PaisID), '') Descripcion,
	IsNull((select Nombre from dbo.Usuario where EMail = @Email), '') Nombre
	from dbo.Usuario
	where EMail = @Email;
end
go
/*end*/

USE BelcorpSalvador
go
alter procedure dbo.ValidateEmail
	@Email varchar(50),
	@PaisID int
as
begin
	select count(*) Cantidad,
	IsNull((select CodigoUsuario from dbo.Usuario where EMail = @Email), '') CodigoUsuario,
	(select CodigoISO from Pais where PaisID = @PaisID) CodigoISO,
	IsNull((select Top(1) Descripcion from FormularioDato where TipoFormularioID = 1103 and PaisID = @PaisID), '') Descripcion,
	IsNull((select Nombre from dbo.Usuario where EMail = @Email), '') Nombre
	from dbo.Usuario
	where EMail = @Email;
end
go
/*end*/

USE BelcorpVenezuela
go
alter procedure dbo.ValidateEmail
	@Email varchar(50),
	@PaisID int
as
begin
	select count(*) Cantidad,
	IsNull((select CodigoUsuario from dbo.Usuario where EMail = @Email), '') CodigoUsuario,
	(select CodigoISO from Pais where PaisID = @PaisID) CodigoISO,
	IsNull((select Top(1) Descripcion from FormularioDato where TipoFormularioID = 1103 and PaisID = @PaisID), '') Descripcion,
	IsNull((select Nombre from dbo.Usuario where EMail = @Email), '') Nombre
	from dbo.Usuario
	where EMail = @Email;
end
go
/*end*/

USE BelcorpMexico
go
alter procedure dbo.ValidateEmail
	@Email varchar(50),
	@PaisID int
as
begin
	select count(*) Cantidad,
	IsNull((select CodigoUsuario from dbo.Usuario where EMail = @Email), '') CodigoUsuario,
	(select CodigoISO from Pais where PaisID = @PaisID) CodigoISO,
	IsNull((select Top(1) Descripcion from FormularioDato where TipoFormularioID = 1103 and PaisID = @PaisID), '') Descripcion,
	IsNull((select Nombre from dbo.Usuario where EMail = @Email), '') Nombre
	from dbo.Usuario
	where EMail = @Email;
end
go
/*end*/

USE BelcorpPeru
go
alter procedure dbo.ValidateEmail
	@Email varchar(50),
	@PaisID int
as
begin
	select count(*) Cantidad,
	IsNull((select CodigoUsuario from dbo.Usuario where EMail = @Email), '') CodigoUsuario,
	(select CodigoISO from Pais where PaisID = @PaisID) CodigoISO,
	IsNull((select Top(1) Descripcion from FormularioDato where TipoFormularioID = 1103 and PaisID = @PaisID), '') Descripcion,
	IsNull((select Nombre from dbo.Usuario where EMail = @Email), '') Nombre
	from dbo.Usuario
	where EMail = @Email;
end
go