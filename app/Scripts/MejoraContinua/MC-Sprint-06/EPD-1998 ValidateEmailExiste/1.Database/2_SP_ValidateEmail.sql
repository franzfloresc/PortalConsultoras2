USE BelcorpBolivia
go
alter procedure dbo.ValidateEmail
	@Email varchar(50),
	@PaisID int
as
begin
	declare @CodigoUsuario varchar(20);
	declare @Nombre varchar(80);
	declare @Cantidad int;

	select top 1
		@Cantidad = 1,
		@CodigoUsuario = CodigoUsuario,
		@Nombre = Nombre
	from dbo.Usuario
	where upper(EMail) = upper(@Email)
	order by EMailActivo desc;

	select
		isnull(@Cantidad,0) as Cantidad,
		isNull(@CodigoUsuario, '') as CodigoUsuario,
		(select CodigoISO from Pais where PaisID = 11) as CodigoISO,
		isNull((select top(1) Descripcion from FormularioDato where TipoFormularioID = 1103 and PaisID = 11), '') as Descripcion,
		isNull(@Nombre, '') as Nombre;
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
	declare @CodigoUsuario varchar(20);
	declare @Nombre varchar(80);
	declare @Cantidad int;

	select top 1
		@Cantidad = 1,
		@CodigoUsuario = CodigoUsuario,
		@Nombre = Nombre
	from dbo.Usuario
	where upper(EMail) = upper(@Email)
	order by EMailActivo desc;

	select
		isnull(@Cantidad,0) as Cantidad,
		isNull(@CodigoUsuario, '') as CodigoUsuario,
		(select CodigoISO from Pais where PaisID = 11) as CodigoISO,
		isNull((select top(1) Descripcion from FormularioDato where TipoFormularioID = 1103 and PaisID = 11), '') as Descripcion,
		isNull(@Nombre, '') as Nombre;
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
	declare @CodigoUsuario varchar(20);
	declare @Nombre varchar(80);
	declare @Cantidad int;

	select top 1
		@Cantidad = 1,
		@CodigoUsuario = CodigoUsuario,
		@Nombre = Nombre
	from dbo.Usuario
	where upper(EMail) = upper(@Email)
	order by EMailActivo desc;

	select
		isnull(@Cantidad,0) as Cantidad,
		isNull(@CodigoUsuario, '') as CodigoUsuario,
		(select CodigoISO from Pais where PaisID = 11) as CodigoISO,
		isNull((select top(1) Descripcion from FormularioDato where TipoFormularioID = 1103 and PaisID = 11), '') as Descripcion,
		isNull(@Nombre, '') as Nombre;
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
	declare @CodigoUsuario varchar(20);
	declare @Nombre varchar(80);
	declare @Cantidad int;

	select top 1
		@Cantidad = 1,
		@CodigoUsuario = CodigoUsuario,
		@Nombre = Nombre
	from dbo.Usuario
	where upper(EMail) = upper(@Email)
	order by EMailActivo desc;

	select
		isnull(@Cantidad,0) as Cantidad,
		isNull(@CodigoUsuario, '') as CodigoUsuario,
		(select CodigoISO from Pais where PaisID = 11) as CodigoISO,
		isNull((select top(1) Descripcion from FormularioDato where TipoFormularioID = 1103 and PaisID = 11), '') as Descripcion,
		isNull(@Nombre, '') as Nombre;
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
	declare @CodigoUsuario varchar(20);
	declare @Nombre varchar(80);
	declare @Cantidad int;

	select top 1
		@Cantidad = 1,
		@CodigoUsuario = CodigoUsuario,
		@Nombre = Nombre
	from dbo.Usuario
	where upper(EMail) = upper(@Email)
	order by EMailActivo desc;

	select
		isnull(@Cantidad,0) as Cantidad,
		isNull(@CodigoUsuario, '') as CodigoUsuario,
		(select CodigoISO from Pais where PaisID = 11) as CodigoISO,
		isNull((select top(1) Descripcion from FormularioDato where TipoFormularioID = 1103 and PaisID = 11), '') as Descripcion,
		isNull(@Nombre, '') as Nombre;
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
	declare @CodigoUsuario varchar(20);
	declare @Nombre varchar(80);
	declare @Cantidad int;

	select top 1
		@Cantidad = 1,
		@CodigoUsuario = CodigoUsuario,
		@Nombre = Nombre
	from dbo.Usuario
	where upper(EMail) = upper(@Email)
	order by EMailActivo desc;

	select
		isnull(@Cantidad,0) as Cantidad,
		isNull(@CodigoUsuario, '') as CodigoUsuario,
		(select CodigoISO from Pais where PaisID = 11) as CodigoISO,
		isNull((select top(1) Descripcion from FormularioDato where TipoFormularioID = 1103 and PaisID = 11), '') as Descripcion,
		isNull(@Nombre, '') as Nombre;
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
	declare @CodigoUsuario varchar(20);
	declare @Nombre varchar(80);
	declare @Cantidad int;

	select top 1
		@Cantidad = 1,
		@CodigoUsuario = CodigoUsuario,
		@Nombre = Nombre
	from dbo.Usuario
	where upper(EMail) = upper(@Email)
	order by EMailActivo desc;

	select
		isnull(@Cantidad,0) as Cantidad,
		isNull(@CodigoUsuario, '') as CodigoUsuario,
		(select CodigoISO from Pais where PaisID = 11) as CodigoISO,
		isNull((select top(1) Descripcion from FormularioDato where TipoFormularioID = 1103 and PaisID = 11), '') as Descripcion,
		isNull(@Nombre, '') as Nombre;
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
	declare @CodigoUsuario varchar(20);
	declare @Nombre varchar(80);
	declare @Cantidad int;

	select top 1
		@Cantidad = 1,
		@CodigoUsuario = CodigoUsuario,
		@Nombre = Nombre
	from dbo.Usuario
	where upper(EMail) = upper(@Email)
	order by EMailActivo desc;

	select
		isnull(@Cantidad,0) as Cantidad,
		isNull(@CodigoUsuario, '') as CodigoUsuario,
		(select CodigoISO from Pais where PaisID = 11) as CodigoISO,
		isNull((select top(1) Descripcion from FormularioDato where TipoFormularioID = 1103 and PaisID = 11), '') as Descripcion,
		isNull(@Nombre, '') as Nombre;
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
	declare @CodigoUsuario varchar(20);
	declare @Nombre varchar(80);
	declare @Cantidad int;

	select top 1
		@Cantidad = 1,
		@CodigoUsuario = CodigoUsuario,
		@Nombre = Nombre
	from dbo.Usuario
	where upper(EMail) = upper(@Email)
	order by EMailActivo desc;

	select
		isnull(@Cantidad,0) as Cantidad,
		isNull(@CodigoUsuario, '') as CodigoUsuario,
		(select CodigoISO from Pais where PaisID = 11) as CodigoISO,
		isNull((select top(1) Descripcion from FormularioDato where TipoFormularioID = 1103 and PaisID = 11), '') as Descripcion,
		isNull(@Nombre, '') as Nombre;
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
	declare @CodigoUsuario varchar(20);
	declare @Nombre varchar(80);
	declare @Cantidad int;

	select top 1
		@Cantidad = 1,
		@CodigoUsuario = CodigoUsuario,
		@Nombre = Nombre
	from dbo.Usuario
	where upper(EMail) = upper(@Email)
	order by EMailActivo desc;

	select
		isnull(@Cantidad,0) as Cantidad,
		isNull(@CodigoUsuario, '') as CodigoUsuario,
		(select CodigoISO from Pais where PaisID = 11) as CodigoISO,
		isNull((select top(1) Descripcion from FormularioDato where TipoFormularioID = 1103 and PaisID = 11), '') as Descripcion,
		isNull(@Nombre, '') as Nombre;
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
	declare @CodigoUsuario varchar(20);
	declare @Nombre varchar(80);
	declare @Cantidad int;

	select top 1
		@Cantidad = 1,
		@CodigoUsuario = CodigoUsuario,
		@Nombre = Nombre
	from dbo.Usuario
	where upper(EMail) = upper(@Email)
	order by EMailActivo desc;

	select
		isnull(@Cantidad,0) as Cantidad,
		isNull(@CodigoUsuario, '') as CodigoUsuario,
		(select CodigoISO from Pais where PaisID = 11) as CodigoISO,
		isNull((select top(1) Descripcion from FormularioDato where TipoFormularioID = 1103 and PaisID = 11), '') as Descripcion,
		isNull(@Nombre, '') as Nombre;
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
	declare @CodigoUsuario varchar(20);
	declare @Nombre varchar(80);
	declare @Cantidad int;

	select top 1
		@Cantidad = 1,
		@CodigoUsuario = CodigoUsuario,
		@Nombre = Nombre
	from dbo.Usuario
	where upper(EMail) = upper(@Email)
	order by EMailActivo desc;

	select
		isnull(@Cantidad,0) as Cantidad,
		isNull(@CodigoUsuario, '') as CodigoUsuario,
		(select CodigoISO from Pais where PaisID = 11) as CodigoISO,
		isNull((select top(1) Descripcion from FormularioDato where TipoFormularioID = 1103 and PaisID = 11), '') as Descripcion,
		isNull(@Nombre, '') as Nombre;
end
go