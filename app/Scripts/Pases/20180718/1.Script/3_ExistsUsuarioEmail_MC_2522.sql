USE BelcorpBolivia
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'ExistsUsuarioEmail' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.ExistsUsuarioEmail
END
GO
CREATE PROCEDURE dbo.ExistsUsuarioEmail
	@Email varchar(50)
AS
BEGIN
	set nocount on;
	set @Email = upper(@Email);

	select iif(
		exists(select 1 from usuario where upper(email) = @Email),
		1,
		0
	);
END
GO
/*end*/

USE BelcorpChile
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'ExistsUsuarioEmail' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.ExistsUsuarioEmail
END
GO
CREATE PROCEDURE dbo.ExistsUsuarioEmail
	@Email varchar(50)
AS
BEGIN
	set nocount on;
	set @Email = upper(@Email);

	select iif(
		exists(select 1 from usuario where upper(email) = @Email),
		1,
		0
	);
END
GO
/*end*/

USE BelcorpColombia
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'ExistsUsuarioEmail' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.ExistsUsuarioEmail
END
GO
CREATE PROCEDURE dbo.ExistsUsuarioEmail
	@Email varchar(50)
AS
BEGIN
	set nocount on;
	set @Email = upper(@Email);

	select iif(
		exists(select 1 from usuario where upper(email) = @Email),
		1,
		0
	);
END
GO
/*end*/

USE BelcorpCostaRica
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'ExistsUsuarioEmail' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.ExistsUsuarioEmail
END
GO
CREATE PROCEDURE dbo.ExistsUsuarioEmail
	@Email varchar(50)
AS
BEGIN
	set nocount on;
	set @Email = upper(@Email);

	select iif(
		exists(select 1 from usuario where upper(email) = @Email),
		1,
		0
	);
END
GO
/*end*/

USE BelcorpDominicana
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'ExistsUsuarioEmail' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.ExistsUsuarioEmail
END
GO
CREATE PROCEDURE dbo.ExistsUsuarioEmail
	@Email varchar(50)
AS
BEGIN
	set nocount on;
	set @Email = upper(@Email);

	select iif(
		exists(select 1 from usuario where upper(email) = @Email),
		1,
		0
	);
END
GO
/*end*/

USE BelcorpEcuador
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'ExistsUsuarioEmail' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.ExistsUsuarioEmail
END
GO
CREATE PROCEDURE dbo.ExistsUsuarioEmail
	@Email varchar(50)
AS
BEGIN
	set nocount on;
	set @Email = upper(@Email);

	select iif(
		exists(select 1 from usuario where upper(email) = @Email),
		1,
		0
	);
END
GO
/*end*/

USE BelcorpGuatemala
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'ExistsUsuarioEmail' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.ExistsUsuarioEmail
END
GO
CREATE PROCEDURE dbo.ExistsUsuarioEmail
	@Email varchar(50)
AS
BEGIN
	set nocount on;
	set @Email = upper(@Email);

	select iif(
		exists(select 1 from usuario where upper(email) = @Email),
		1,
		0
	);
END
GO
/*end*/

USE BelcorpMexico
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'ExistsUsuarioEmail' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.ExistsUsuarioEmail
END
GO
CREATE PROCEDURE dbo.ExistsUsuarioEmail
	@Email varchar(50)
AS
BEGIN
	set nocount on;
	set @Email = upper(@Email);

	select iif(
		exists(select 1 from usuario where upper(email) = @Email),
		1,
		0
	);
END
GO
/*end*/

USE BelcorpPanama
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'ExistsUsuarioEmail' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.ExistsUsuarioEmail
END
GO
CREATE PROCEDURE dbo.ExistsUsuarioEmail
	@Email varchar(50)
AS
BEGIN
	set nocount on;
	set @Email = upper(@Email);

	select iif(
		exists(select 1 from usuario where upper(email) = @Email),
		1,
		0
	);
END
GO
/*end*/

USE BelcorpPeru
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'ExistsUsuarioEmail' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.ExistsUsuarioEmail
END
GO
CREATE PROCEDURE dbo.ExistsUsuarioEmail
	@Email varchar(50)
AS
BEGIN
	set nocount on;
	set @Email = upper(@Email);

	select iif(
		exists(select 1 from usuario where upper(email) = @Email),
		1,
		0
	);
END
GO
/*end*/

USE BelcorpPuertoRico
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'ExistsUsuarioEmail' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.ExistsUsuarioEmail
END
GO
CREATE PROCEDURE dbo.ExistsUsuarioEmail
	@Email varchar(50)
AS
BEGIN
	set nocount on;
	set @Email = upper(@Email);

	select iif(
		exists(select 1 from usuario where upper(email) = @Email),
		1,
		0
	);
END
GO
/*end*/

USE BelcorpSalvador
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'ExistsUsuarioEmail' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.ExistsUsuarioEmail
END
GO
CREATE PROCEDURE dbo.ExistsUsuarioEmail
	@Email varchar(50)
AS
BEGIN
	set nocount on;
	set @Email = upper(@Email);

	select iif(
		exists(select 1 from usuario where upper(email) = @Email),
		1,
		0
	);
END
GO