use [BelcorpBolivia]
go
ALTER PROCEDURE [dbo].[ValidateConsultoraEmail]
(
	@Email varchar(50),
	@CodigoUsuario varchar(20)
)
as
begin
	select count(*) as Contador
		from usuario
	where upper(email) = upper(@Email)
		  and CodigoUsuario  <> @CodigoUsuario	
		  and EMailActivo = 1
end
go


use [BelcorpChile]
go
ALTER PROCEDURE [dbo].[ValidateConsultoraEmail]
(
	@Email varchar(50),
	@CodigoUsuario varchar(20)
)
as
begin
	select count(*) as Contador
		from usuario
	where upper(email) = upper(@Email)
		  and CodigoUsuario  <> @CodigoUsuario	
		  and EMailActivo = 1
end
go



use [BelcorpColombia]
go
ALTER PROCEDURE [dbo].[ValidateConsultoraEmail]
(
	@Email varchar(50),
	@CodigoUsuario varchar(20)
)
as
begin
	select count(*) as Contador
		from usuario
	where upper(email) = upper(@Email)
		  and CodigoUsuario  <> @CodigoUsuario	
		  and EMailActivo = 1
end
go



use [BelcorpCostaRica]
go
ALTER PROCEDURE [dbo].[ValidateConsultoraEmail]
(
	@Email varchar(50),
	@CodigoUsuario varchar(20)
)
as
begin
	select count(*) as Contador
		from usuario
	where upper(email) = upper(@Email)
		  and CodigoUsuario  <> @CodigoUsuario	
		  and EMailActivo = 1
end
go



use [BelcorpDominicana]
go
ALTER PROCEDURE [dbo].[ValidateConsultoraEmail]
(
	@Email varchar(50),
	@CodigoUsuario varchar(20)
)
as
begin
	select count(*) as Contador
		from usuario
	where upper(email) = upper(@Email)
		  and CodigoUsuario  <> @CodigoUsuario	
		  and EMailActivo = 1
end
go



use [BelcorpEcuador]
go
ALTER PROCEDURE [dbo].[ValidateConsultoraEmail]
(
	@Email varchar(50),
	@CodigoUsuario varchar(20)
)
as
begin
	select count(*) as Contador
		from usuario
	where upper(email) = upper(@Email)
		  and CodigoUsuario  <> @CodigoUsuario	
		  and EMailActivo = 1
end
go



use [BelcorpGuatemala]
go
ALTER PROCEDURE [dbo].[ValidateConsultoraEmail]
(
	@Email varchar(50),
	@CodigoUsuario varchar(20)
)
as
begin
	select count(*) as Contador
		from usuario
	where upper(email) = upper(@Email)
		  and CodigoUsuario  <> @CodigoUsuario	
		  and EMailActivo = 1
end
go



use [BelcorpMexico]
go
ALTER PROCEDURE [dbo].[ValidateConsultoraEmail]
(
	@Email varchar(50),
	@CodigoUsuario varchar(20)
)
as
begin
	select count(*) as Contador
		from usuario
	where upper(email) = upper(@Email)
		  and CodigoUsuario  <> @CodigoUsuario	
		  and EMailActivo = 1
end
go



use [BelcorpPanama]
go
ALTER PROCEDURE [dbo].[ValidateConsultoraEmail]
(
	@Email varchar(50),
	@CodigoUsuario varchar(20)
)
as
begin
	select count(*) as Contador
		from usuario
	where upper(email) = upper(@Email)
		  and CodigoUsuario  <> @CodigoUsuario	
		  and EMailActivo = 1
end
go



use [BelcorpPeru]
go
ALTER PROCEDURE [dbo].[ValidateConsultoraEmail]
(
	@Email varchar(50),
	@CodigoUsuario varchar(20)
)
as
begin
	select count(*) as Contador
		from usuario
	where upper(email) = upper(@Email)
		  and CodigoUsuario  <> @CodigoUsuario	
		  and EMailActivo = 1
end
go



use [BelcorpPuertoRico]
go
ALTER PROCEDURE [dbo].[ValidateConsultoraEmail]
(
	@Email varchar(50),
	@CodigoUsuario varchar(20)
)
as
begin
	select count(*) as Contador
		from usuario
	where upper(email) = upper(@Email)
		  and CodigoUsuario  <> @CodigoUsuario	
		  and EMailActivo = 1
end
go



use [BelcorpSalvador]
go
ALTER PROCEDURE [dbo].[ValidateConsultoraEmail]
(
	@Email varchar(50),
	@CodigoUsuario varchar(20)
)
as
begin
	select count(*) as Contador
		from usuario
	where upper(email) = upper(@Email)
		  and CodigoUsuario  <> @CodigoUsuario	
		  and EMailActivo = 1
end
go



use [BelcorpVenezuela]
go
ALTER PROCEDURE [dbo].[ValidateConsultoraEmail]
(
	@Email varchar(50),
	@CodigoUsuario varchar(20)
)
as
begin
	select count(*) as Contador
		from usuario
	where upper(email) = upper(@Email)
		  and CodigoUsuario  <> @CodigoUsuario	
		  and EMailActivo = 1
end
go


