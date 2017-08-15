
USE BelcorpBolivia
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.DelUsuarioPostulante'))
BEGIN
    DROP PROCEDURE dbo.DelUsuarioPostulante
END
GO

CREATE PROCEDURE [dbo].[DelUsuarioPostulante]
(
	@NumeroDocumento VARCHAR(20)
)
AS

BEGIN
	IF EXISTS(SELECT 1 FROM dbo.Usuario WHERE CodigoUsuario = @NumeroDocumento AND Activo = 1 AND TipoUsuario = 2)
	BEGIN
		DELETE FROM dbo.Usuario 
		WHERE CodigoUsuario = @NumeroDocumento 
		AND Activo = 1
		AND TipoUsuario = 2

		DELETE FROM dbo.UsuarioRol
		WHERE CodigoUsuario = @NumeroDocumento 
		AND RolID = 1 
		AND Activo = 1
	END

	UPDATE UsuarioPostulante
	SET Estado = 0
	WHERE CodigoUsuario = @NumeroDocumento
	AND Estado = 1
END
GO

/*end*/

USE BelcorpChile
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.DelUsuarioPostulante'))
BEGIN
    DROP PROCEDURE dbo.DelUsuarioPostulante
END
GO

CREATE PROCEDURE [dbo].[DelUsuarioPostulante]
(
	@NumeroDocumento VARCHAR(20)
)
AS

BEGIN
	IF EXISTS(SELECT 1 FROM dbo.Usuario WHERE CodigoUsuario = @NumeroDocumento AND Activo = 1 AND TipoUsuario = 2)
	BEGIN
		DELETE FROM dbo.Usuario 
		WHERE CodigoUsuario = @NumeroDocumento 
		AND Activo = 1
		AND TipoUsuario = 2

		DELETE FROM dbo.UsuarioRol
		WHERE CodigoUsuario = @NumeroDocumento 
		AND RolID = 1 
		AND Activo = 1
	END

	UPDATE UsuarioPostulante
	SET Estado = 0
	WHERE CodigoUsuario = @NumeroDocumento
	AND Estado = 1
END
GO
/*end*/

USE BelcorpColombia
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.DelUsuarioPostulante'))
BEGIN
    DROP PROCEDURE dbo.DelUsuarioPostulante
END
GO

CREATE PROCEDURE [dbo].[DelUsuarioPostulante]
(
	@NumeroDocumento VARCHAR(20)
)
AS

BEGIN
	IF EXISTS(SELECT 1 FROM dbo.Usuario WHERE CodigoUsuario = @NumeroDocumento AND Activo = 1 AND TipoUsuario = 2)
	BEGIN
		DELETE FROM dbo.Usuario 
		WHERE CodigoUsuario = @NumeroDocumento 
		AND Activo = 1
		AND TipoUsuario = 2

		DELETE FROM dbo.UsuarioRol
		WHERE CodigoUsuario = @NumeroDocumento 
		AND RolID = 1 
		AND Activo = 1
	END

	UPDATE UsuarioPostulante
	SET Estado = 0
	WHERE CodigoUsuario = @NumeroDocumento
	AND Estado = 1
END
GO
/*end*/

USE BelcorpCostaRica
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.DelUsuarioPostulante'))
BEGIN
    DROP PROCEDURE dbo.DelUsuarioPostulante
END
GO

CREATE PROCEDURE [dbo].[DelUsuarioPostulante]
(
	@NumeroDocumento VARCHAR(20)
)
AS

BEGIN
	IF EXISTS(SELECT 1 FROM dbo.Usuario WHERE CodigoUsuario = @NumeroDocumento AND Activo = 1 AND TipoUsuario = 2)
	BEGIN
		DELETE FROM dbo.Usuario 
		WHERE CodigoUsuario = @NumeroDocumento 
		AND Activo = 1
		AND TipoUsuario = 2

		DELETE FROM dbo.UsuarioRol
		WHERE CodigoUsuario = @NumeroDocumento 
		AND RolID = 1 
		AND Activo = 1
	END

	UPDATE UsuarioPostulante
	SET Estado = 0
	WHERE CodigoUsuario = @NumeroDocumento
	AND Estado = 1
END
GO
/*end*/

USE BelcorpDominicana
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.DelUsuarioPostulante'))
BEGIN
    DROP PROCEDURE dbo.DelUsuarioPostulante
END
GO

CREATE PROCEDURE [dbo].[DelUsuarioPostulante]
(
	@NumeroDocumento VARCHAR(20)
)
AS

BEGIN
	IF EXISTS(SELECT 1 FROM dbo.Usuario WHERE CodigoUsuario = @NumeroDocumento AND Activo = 1 AND TipoUsuario = 2)
	BEGIN
		DELETE FROM dbo.Usuario 
		WHERE CodigoUsuario = @NumeroDocumento 
		AND Activo = 1
		AND TipoUsuario = 2

		DELETE FROM dbo.UsuarioRol
		WHERE CodigoUsuario = @NumeroDocumento 
		AND RolID = 1 
		AND Activo = 1
	END

	UPDATE UsuarioPostulante
	SET Estado = 0
	WHERE CodigoUsuario = @NumeroDocumento
	AND Estado = 1
END
GO
/*end*/

USE BelcorpEcuador
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.DelUsuarioPostulante'))
BEGIN
    DROP PROCEDURE dbo.DelUsuarioPostulante
END
GO

CREATE PROCEDURE [dbo].[DelUsuarioPostulante]
(
	@NumeroDocumento VARCHAR(20)
)
AS

BEGIN
	IF EXISTS(SELECT 1 FROM dbo.Usuario WHERE CodigoUsuario = @NumeroDocumento AND Activo = 1 AND TipoUsuario = 2)
	BEGIN
		DELETE FROM dbo.Usuario 
		WHERE CodigoUsuario = @NumeroDocumento 
		AND Activo = 1
		AND TipoUsuario = 2

		DELETE FROM dbo.UsuarioRol
		WHERE CodigoUsuario = @NumeroDocumento 
		AND RolID = 1 
		AND Activo = 1
	END

	UPDATE UsuarioPostulante
	SET Estado = 0
	WHERE CodigoUsuario = @NumeroDocumento
	AND Estado = 1
END
GO
/*end*/

USE BelcorpGuatemala
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.DelUsuarioPostulante'))
BEGIN
    DROP PROCEDURE dbo.DelUsuarioPostulante
END
GO

CREATE PROCEDURE [dbo].[DelUsuarioPostulante]
(
	@NumeroDocumento VARCHAR(20)
)
AS

BEGIN
	IF EXISTS(SELECT 1 FROM dbo.Usuario WHERE CodigoUsuario = @NumeroDocumento AND Activo = 1 AND TipoUsuario = 2)
	BEGIN
		DELETE FROM dbo.Usuario 
		WHERE CodigoUsuario = @NumeroDocumento 
		AND Activo = 1
		AND TipoUsuario = 2

		DELETE FROM dbo.UsuarioRol
		WHERE CodigoUsuario = @NumeroDocumento 
		AND RolID = 1 
		AND Activo = 1
	END

	UPDATE UsuarioPostulante
	SET Estado = 0
	WHERE CodigoUsuario = @NumeroDocumento
	AND Estado = 1
END
GO
/*end*/

USE BelcorpMexico
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.DelUsuarioPostulante'))
BEGIN
    DROP PROCEDURE dbo.DelUsuarioPostulante
END
GO

CREATE PROCEDURE [dbo].[DelUsuarioPostulante]
(
	@NumeroDocumento VARCHAR(20)
)
AS

BEGIN
	IF EXISTS(SELECT 1 FROM dbo.Usuario WHERE CodigoUsuario = @NumeroDocumento AND Activo = 1 AND TipoUsuario = 2)
	BEGIN
		DELETE FROM dbo.Usuario 
		WHERE CodigoUsuario = @NumeroDocumento 
		AND Activo = 1
		AND TipoUsuario = 2

		DELETE FROM dbo.UsuarioRol
		WHERE CodigoUsuario = @NumeroDocumento 
		AND RolID = 1 
		AND Activo = 1
	END

	UPDATE UsuarioPostulante
	SET Estado = 0
	WHERE CodigoUsuario = @NumeroDocumento
	AND Estado = 1
END
GO
/*end*/

USE BelcorpPanama
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.DelUsuarioPostulante'))
BEGIN
    DROP PROCEDURE dbo.DelUsuarioPostulante
END
GO

CREATE PROCEDURE [dbo].[DelUsuarioPostulante]
(
	@NumeroDocumento VARCHAR(20)
)
AS

BEGIN
	IF EXISTS(SELECT 1 FROM dbo.Usuario WHERE CodigoUsuario = @NumeroDocumento AND Activo = 1 AND TipoUsuario = 2)
	BEGIN
		DELETE FROM dbo.Usuario 
		WHERE CodigoUsuario = @NumeroDocumento 
		AND Activo = 1
		AND TipoUsuario = 2

		DELETE FROM dbo.UsuarioRol
		WHERE CodigoUsuario = @NumeroDocumento 
		AND RolID = 1 
		AND Activo = 1
	END

	UPDATE UsuarioPostulante
	SET Estado = 0
	WHERE CodigoUsuario = @NumeroDocumento
	AND Estado = 1
END
GO
/*end*/

USE BelcorpPeru
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.DelUsuarioPostulante'))
BEGIN
    DROP PROCEDURE dbo.DelUsuarioPostulante
END
GO

CREATE PROCEDURE [dbo].[DelUsuarioPostulante]
(
	@NumeroDocumento VARCHAR(20)
)
AS

BEGIN
	IF EXISTS(SELECT 1 FROM dbo.Usuario WHERE CodigoUsuario = @NumeroDocumento AND Activo = 1 AND TipoUsuario = 2)
	BEGIN
		DELETE FROM dbo.Usuario 
		WHERE CodigoUsuario = @NumeroDocumento 
		AND Activo = 1
		AND TipoUsuario = 2

		DELETE FROM dbo.UsuarioRol
		WHERE CodigoUsuario = @NumeroDocumento 
		AND RolID = 1 
		AND Activo = 1
	END

	UPDATE UsuarioPostulante
	SET Estado = 0
	WHERE CodigoUsuario = @NumeroDocumento
	AND Estado = 1
END
GO
/*end*/

USE BelcorpPuertoRico
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.DelUsuarioPostulante'))
BEGIN
    DROP PROCEDURE dbo.DelUsuarioPostulante
END
GO

CREATE PROCEDURE [dbo].[DelUsuarioPostulante]
(
	@NumeroDocumento VARCHAR(20)
)
AS

BEGIN
	IF EXISTS(SELECT 1 FROM dbo.Usuario WHERE CodigoUsuario = @NumeroDocumento AND Activo = 1 AND TipoUsuario = 2)
	BEGIN
		DELETE FROM dbo.Usuario 
		WHERE CodigoUsuario = @NumeroDocumento 
		AND Activo = 1
		AND TipoUsuario = 2

		DELETE FROM dbo.UsuarioRol
		WHERE CodigoUsuario = @NumeroDocumento 
		AND RolID = 1 
		AND Activo = 1
	END

	UPDATE UsuarioPostulante
	SET Estado = 0
	WHERE CodigoUsuario = @NumeroDocumento
	AND Estado = 1
END
GO
/*end*/

USE BelcorpSalvador
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.DelUsuarioPostulante'))
BEGIN
    DROP PROCEDURE dbo.DelUsuarioPostulante
END
GO

CREATE PROCEDURE [dbo].[DelUsuarioPostulante]
(
	@NumeroDocumento VARCHAR(20)
)
AS

BEGIN
	IF EXISTS(SELECT 1 FROM dbo.Usuario WHERE CodigoUsuario = @NumeroDocumento AND Activo = 1 AND TipoUsuario = 2)
	BEGIN
		DELETE FROM dbo.Usuario 
		WHERE CodigoUsuario = @NumeroDocumento 
		AND Activo = 1
		AND TipoUsuario = 2

		DELETE FROM dbo.UsuarioRol
		WHERE CodigoUsuario = @NumeroDocumento 
		AND RolID = 1 
		AND Activo = 1
	END

	UPDATE UsuarioPostulante
	SET Estado = 0
	WHERE CodigoUsuario = @NumeroDocumento
	AND Estado = 1
END
GO
/*end*/

USE BelcorpVenezuela
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.DelUsuarioPostulante'))
BEGIN
    DROP PROCEDURE dbo.DelUsuarioPostulante
END
GO

CREATE PROCEDURE [dbo].[DelUsuarioPostulante]
(
	@NumeroDocumento VARCHAR(20)
)
AS

BEGIN
	IF EXISTS(SELECT 1 FROM dbo.Usuario WHERE CodigoUsuario = @NumeroDocumento AND Activo = 1 AND TipoUsuario = 2)
	BEGIN
		DELETE FROM dbo.Usuario 
		WHERE CodigoUsuario = @NumeroDocumento 
		AND Activo = 1
		AND TipoUsuario = 2

		DELETE FROM dbo.UsuarioRol
		WHERE CodigoUsuario = @NumeroDocumento 
		AND RolID = 1 
		AND Activo = 1
	END

	UPDATE UsuarioPostulante
	SET Estado = 0
	WHERE CodigoUsuario = @NumeroDocumento
	AND Estado = 1
END
GO