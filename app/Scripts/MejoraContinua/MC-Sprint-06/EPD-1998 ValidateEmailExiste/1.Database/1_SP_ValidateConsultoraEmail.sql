USE BelcorpBolivia
go
alter procedure dbo.ValidateConsultoraEmail
	@Email varchar(50),
	@CodigoUsuario varchar(20)
as
begin
	select count(1) as Contador
	from usuario
	where 
		upper(email) = upper(@Email) and EMailActivo = 1
		and
		CodigoUsuario  <> @CodigoUsuario;
end
go
/*end*/

USE BelcorpChile
go
alter procedure dbo.ValidateConsultoraEmail
	@Email varchar(50),
	@CodigoUsuario varchar(20)
as
begin
	select count(1) as Contador
	from usuario
	where 
		upper(email) = upper(@Email) and EMailActivo = 1
		and
		CodigoUsuario  <> @CodigoUsuario;
end
go
/*end*/

USE BelcorpCostaRica
go
alter procedure dbo.ValidateConsultoraEmail
	@Email varchar(50),
	@CodigoUsuario varchar(20)
as
begin
	select count(1) as Contador
	from usuario
	where 
		upper(email) = upper(@Email) and EMailActivo = 1
		and
		CodigoUsuario  <> @CodigoUsuario;
end
go
/*end*/

USE BelcorpDominicana
go
alter procedure dbo.ValidateConsultoraEmail
	@Email varchar(50),
	@CodigoUsuario varchar(20)
as
begin
	select count(1) as Contador
	from usuario
	where 
		upper(email) = upper(@Email) and EMailActivo = 1
		and
		CodigoUsuario  <> @CodigoUsuario;
end
go
/*end*/

USE BelcorpEcuador
go
alter procedure dbo.ValidateConsultoraEmail
	@Email varchar(50),
	@CodigoUsuario varchar(20)
as
begin
	select count(1) as Contador
	from usuario
	where 
		upper(email) = upper(@Email) and EMailActivo = 1
		and
		CodigoUsuario  <> @CodigoUsuario;
end
go
/*end*/

USE BelcorpGuatemala
go
alter procedure dbo.ValidateConsultoraEmail
	@Email varchar(50),
	@CodigoUsuario varchar(20)
as
begin
	select count(1) as Contador
	from usuario
	where 
		upper(email) = upper(@Email) and EMailActivo = 1
		and
		CodigoUsuario  <> @CodigoUsuario;
end
go
/*end*/

USE BelcorpPanama
go
alter procedure dbo.ValidateConsultoraEmail
	@Email varchar(50),
	@CodigoUsuario varchar(20)
as
begin
	select count(1) as Contador
	from usuario
	where 
		upper(email) = upper(@Email) and EMailActivo = 1
		and
		CodigoUsuario  <> @CodigoUsuario;
end
go
/*end*/

USE BelcorpPuertoRico
go
alter procedure dbo.ValidateConsultoraEmail
	@Email varchar(50),
	@CodigoUsuario varchar(20)
as
begin
	select count(1) as Contador
	from usuario
	where 
		upper(email) = upper(@Email) and EMailActivo = 1
		and
		CodigoUsuario  <> @CodigoUsuario;
end
go
/*end*/

USE BelcorpSalvador
go
alter procedure dbo.ValidateConsultoraEmail
	@Email varchar(50),
	@CodigoUsuario varchar(20)
as
begin
	select count(1) as Contador
	from usuario
	where 
		upper(email) = upper(@Email) and EMailActivo = 1
		and
		CodigoUsuario  <> @CodigoUsuario;
end
go
/*end*/

USE BelcorpVenezuela
go
alter procedure dbo.ValidateConsultoraEmail
	@Email varchar(50),
	@CodigoUsuario varchar(20)
as
begin
	select count(1) as Contador
	from usuario
	where 
		upper(email) = upper(@Email) and EMailActivo = 1
		and
		CodigoUsuario  <> @CodigoUsuario;
end
go
/*end*/

USE BelcorpColombia
go
alter procedure dbo.ValidateConsultoraEmail
	@Email varchar(50),
	@CodigoUsuario varchar(20)
as
begin
	select count(1) as Contador
	from usuario
	where 
		upper(email) = upper(@Email) and EMailActivo = 1
		and
		CodigoUsuario  <> @CodigoUsuario;
end
go
/*end*/

USE BelcorpMexico
go
alter procedure dbo.ValidateConsultoraEmail
	@Email varchar(50),
	@CodigoUsuario varchar(20)
as
begin
	select count(1) as Contador
	from usuario
	where 
		upper(email) = upper(@Email) and EMailActivo = 1
		and
		CodigoUsuario  <> @CodigoUsuario;
end
go
/*end*/

USE BelcorpPeru
go
alter procedure dbo.ValidateConsultoraEmail
	@Email varchar(50),
	@CodigoUsuario varchar(20)
as
begin
	select count(1) as Contador
	from usuario
	where 
		upper(email) = upper(@Email) and EMailActivo = 1
		and
		CodigoUsuario  <> @CodigoUsuario;
end
go