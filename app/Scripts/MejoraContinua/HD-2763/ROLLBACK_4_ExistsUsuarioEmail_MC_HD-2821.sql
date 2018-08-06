USE [BelcorpPeru]  
GO
ALTER PROCEDURE dbo.ExistsUsuarioEmail

	@Email varchar(50), 
	@codigoUsuario  varchar(50)
AS
BEGIN
	set nocount on;
	set @Email = upper(@Email);
	select iif(exists(select 1 from usuario where upper(email) = @Email),1,0);
END
GO

USE [BelcorpBolivia]
GO
ALTER PROCEDURE dbo.ExistsUsuarioEmail

	@Email varchar(50), 
	@codigoUsuario  varchar(50)
AS
BEGIN
	set nocount on;
	set @Email = upper(@Email);
	select iif(exists(select 1 from usuario where upper(email) = @Email),1,0);
END
GO

USE [BelcorpChile]
GO
ALTER PROCEDURE dbo.ExistsUsuarioEmail

	@Email varchar(50), 
	@codigoUsuario  varchar(50)
AS
BEGIN
	set nocount on;
	set @Email = upper(@Email);
	select iif(exists(select 1 from usuario where upper(email) = @Email),1,0);
END
GO

USE [BelcorpColombia]
GO
ALTER PROCEDURE dbo.ExistsUsuarioEmail

	@Email varchar(50), 
	@codigoUsuario  varchar(50)
AS
BEGIN
	set nocount on;
	set @Email = upper(@Email);
	select iif(exists(select 1 from usuario where upper(email) = @Email),1,0);
END
GO

USE [BelcorpCostaRica]
GO
ALTER PROCEDURE dbo.ExistsUsuarioEmail

	@Email varchar(50), 
	@codigoUsuario  varchar(50)
AS
BEGIN
	set nocount on;
	set @Email = upper(@Email);
	select iif(exists(select 1 from usuario where upper(email) = @Email),1,0);
END
GO

USE [BelcorpDominicana]
GO
ALTER PROCEDURE dbo.ExistsUsuarioEmail

	@Email varchar(50), 
	@codigoUsuario  varchar(50)
AS
BEGIN
	set nocount on;
	set @Email = upper(@Email);
	select iif(exists(select 1 from usuario where upper(email) = @Email),1,0);
END
GO

USE [BelcorpEcuador]
GO
ALTER PROCEDURE dbo.ExistsUsuarioEmail

	@Email varchar(50), 
	@codigoUsuario  varchar(50)
AS
BEGIN
	set nocount on;
	set @Email = upper(@Email);
	select iif(exists(select 1 from usuario where upper(email) = @Email),1,0);
END
GO

USE [BelcorpGuatemala]
GO
ALTER PROCEDURE dbo.ExistsUsuarioEmail

	@Email varchar(50), 
	@codigoUsuario  varchar(50)
AS
BEGIN
	set nocount on;
	set @Email = upper(@Email);
	select iif(exists(select 1 from usuario where upper(email) = @Email),1,0);
END
GO

USE [BelcorpMexico]
GO
ALTER PROCEDURE dbo.ExistsUsuarioEmail

	@Email varchar(50), 
	@codigoUsuario  varchar(50)
AS
BEGIN
	set nocount on;
	set @Email = upper(@Email);
	select iif(exists(select 1 from usuario where upper(email) = @Email),1,0);
END
GO

USE [BelcorpPanama]
GO
ALTER PROCEDURE dbo.ExistsUsuarioEmail

	@Email varchar(50), 
	@codigoUsuario  varchar(50)
AS
BEGIN
	set nocount on;
	set @Email = upper(@Email);
	select iif(exists(select 1 from usuario where upper(email) = @Email),1,0);
END
GO

USE [BelcorpPuertoRico]
GO
ALTER PROCEDURE dbo.ExistsUsuarioEmail

	@Email varchar(50), 
	@codigoUsuario  varchar(50)
AS
BEGIN
	set nocount on;
	set @Email = upper(@Email);
	select iif(exists(select 1 from usuario where upper(email) = @Email),1,0);
END
GO

USE [BelcorpSalvador]
GO
ALTER PROCEDURE dbo.ExistsUsuarioEmail

	@Email varchar(50), 
	@codigoUsuario  varchar(50)
AS
BEGIN
	set nocount on;
	set @Email = upper(@Email);
	select iif(exists(select 1 from usuario where upper(email) = @Email),1,0);
END
GO
