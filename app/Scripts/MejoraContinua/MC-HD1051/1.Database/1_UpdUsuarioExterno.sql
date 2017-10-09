GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'UpdUsuarioExterno' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.UpdUsuarioExterno
END
GO
CREATE PROCEDURE UpdUsuarioExterno
(	
	@CodigoUsuario	VARCHAR(20),
	@FotoPerfil		VARCHAR(255)
)
AS
BEGIN	
	UPDATE usuarioexterno
	SET FotoPerfil = @FotoPerfil
	where codigousuario = @CodigoUsuario
END