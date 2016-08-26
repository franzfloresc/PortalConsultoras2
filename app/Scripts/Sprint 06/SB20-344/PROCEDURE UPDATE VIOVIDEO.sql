CREATE PROCEDURE setUsuarioVideoIntroductorio_SB2
@codigoUsuario VARCHAR(25)
AS
BEGIN
	UPDATE Usuario
	SET VioVideo = 1
	WHERE CodigoUsuario = @codigoUsuario
	SELECT 1
END