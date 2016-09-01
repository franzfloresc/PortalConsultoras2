IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[UsuarioContrasenia]') AND (type = 'U') )
 DROP TABLE [dbo].[UsuarioContrasenia]
GO

CREATE TABLE [dbo].[UsuarioContrasenia] (
	CodigoUsuario varchar(20),
	Contrasenia varchar(200),
	CONSTRAINT PK_UsuarioContrasenia PRIMARY KEY CLUSTERED (CodigoUsuario ASC)
)
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdUsuarioContrasenia]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[UpdUsuarioContrasenia]
GO

CREATE PROCEDURE [dbo].[UpdUsuarioContrasenia] (
	@CodigoUsuario varchar(20),
	@Contrasenia varchar(200)
)
AS
BEGIN

SET NOCOUNT ON;

IF EXISTS(SELECT 1 FROM dbo.UsuarioContrasenia  where CodigoUsuario = @CodigoUsuario)
BEGIN
	UPDATE dbo.UsuarioContrasenia SET Contrasenia = @Contrasenia WHERE CodigoUsuario = @CodigoUsuario
END
ELSE
BEGIN
	INSERT INTO dbo.UsuarioContrasenia (CodigoUsuario, Contrasenia) VALUES (@CodigoUsuario, @Contrasenia)
END

END
GO



