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