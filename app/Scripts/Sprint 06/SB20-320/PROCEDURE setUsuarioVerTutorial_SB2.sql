CREATE PROCEDURE setUsuarioVerTutorial_SB2
@codigoUsuario VARCHAR(25)
AS
BEGIN
	UPDATE Usuario
	SET VioTutorial = 1
	WHERE CodigoUsuario = @codigoUsuario
	SELECT 1
END