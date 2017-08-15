USE [BelcorpBolivia]
GO
----------------------------------------------------------------------------
IF EXISTS(SELECT 1 FROM SYS.PROCEDURES WHERE NAME ='UpdatePostulanteMensajes')
BEGIN
	DROP PROCEDURE UpdatePostulanteMensajes
END
GO

CREATE PROCEDURE UpdatePostulanteMensajes 
	@CodigoUsuario INT,
	@Tipo  INT
AS
IF(@Tipo = 1)
BEGIN	
	UPDATE usuariopostulante SET MensajeDesktop = 1 WHERE CodigoUsuario = @CodigoUsuario
END
ELSE IF (@Tipo = 2)
BEGIN	
	UPDATE usuariopostulante SET MensajeMobile = 1 WHERE CodigoUsuario = @CodigoUsuario
END
GO

/*end*/

USE [BelcorpChile]
GO
----------------------------------------------------------------------------
IF EXISTS(SELECT 1 FROM SYS.PROCEDURES WHERE NAME ='UpdatePostulanteMensajes')
BEGIN
	DROP PROCEDURE UpdatePostulanteMensajes
END
GO

CREATE PROCEDURE UpdatePostulanteMensajes 
	@CodigoUsuario INT,
	@Tipo  INT
AS
IF(@Tipo = 1)
BEGIN	
	UPDATE usuariopostulante SET MensajeDesktop = 1 WHERE CodigoUsuario = @CodigoUsuario
END
ELSE IF (@Tipo = 2)
BEGIN	
	UPDATE usuariopostulante SET MensajeMobile = 1 WHERE CodigoUsuario = @CodigoUsuario
END
GO

/*end*/

USE [BelcorpColombia]
GO
----------------------------------------------------------------------------
IF EXISTS(SELECT 1 FROM SYS.PROCEDURES WHERE NAME ='UpdatePostulanteMensajes')
BEGIN
	DROP PROCEDURE UpdatePostulanteMensajes
END
GO

CREATE PROCEDURE UpdatePostulanteMensajes 
	@CodigoUsuario INT,
	@Tipo  INT
AS
IF(@Tipo = 1)
BEGIN	
	UPDATE usuariopostulante SET MensajeDesktop = 1 WHERE CodigoUsuario = @CodigoUsuario
END
ELSE IF (@Tipo = 2)
BEGIN	
	UPDATE usuariopostulante SET MensajeMobile = 1 WHERE CodigoUsuario = @CodigoUsuario
END
GO

/*end*/

USE [BelcorpCostaRica]
GO
----------------------------------------------------------------------------
IF EXISTS(SELECT 1 FROM SYS.PROCEDURES WHERE NAME ='UpdatePostulanteMensajes')
BEGIN
	DROP PROCEDURE UpdatePostulanteMensajes
END
GO

CREATE PROCEDURE UpdatePostulanteMensajes 
	@CodigoUsuario INT,
	@Tipo  INT
AS
IF(@Tipo = 1)
BEGIN	
	UPDATE usuariopostulante SET MensajeDesktop = 1 WHERE CodigoUsuario = @CodigoUsuario
END
ELSE IF (@Tipo = 2)
BEGIN	
	UPDATE usuariopostulante SET MensajeMobile = 1 WHERE CodigoUsuario = @CodigoUsuario
END
GO

/*end*/

USE [BelcorpDominicana]
GO
----------------------------------------------------------------------------
IF EXISTS(SELECT 1 FROM SYS.PROCEDURES WHERE NAME ='UpdatePostulanteMensajes')
BEGIN
	DROP PROCEDURE UpdatePostulanteMensajes
END
GO

CREATE PROCEDURE UpdatePostulanteMensajes 
	@CodigoUsuario INT,
	@Tipo  INT
AS
IF(@Tipo = 1)
BEGIN	
	UPDATE usuariopostulante SET MensajeDesktop = 1 WHERE CodigoUsuario = @CodigoUsuario
END
ELSE IF (@Tipo = 2)
BEGIN	
	UPDATE usuariopostulante SET MensajeMobile = 1 WHERE CodigoUsuario = @CodigoUsuario
END
GO

/*end*/

USE [BelcorpEcuador]
GO
----------------------------------------------------------------------------
IF EXISTS(SELECT 1 FROM SYS.PROCEDURES WHERE NAME ='UpdatePostulanteMensajes')
BEGIN
	DROP PROCEDURE UpdatePostulanteMensajes
END
GO

CREATE PROCEDURE UpdatePostulanteMensajes 
	@CodigoUsuario INT,
	@Tipo  INT
AS
IF(@Tipo = 1)
BEGIN	
	UPDATE usuariopostulante SET MensajeDesktop = 1 WHERE CodigoUsuario = @CodigoUsuario
END
ELSE IF (@Tipo = 2)
BEGIN	
	UPDATE usuariopostulante SET MensajeMobile = 1 WHERE CodigoUsuario = @CodigoUsuario
END
GO

/*end*/

USE [BelcorpGuatemala]
GO
----------------------------------------------------------------------------
IF EXISTS(SELECT 1 FROM SYS.PROCEDURES WHERE NAME ='UpdatePostulanteMensajes')
BEGIN
	DROP PROCEDURE UpdatePostulanteMensajes
END
GO

CREATE PROCEDURE UpdatePostulanteMensajes 
	@CodigoUsuario INT,
	@Tipo  INT
AS
IF(@Tipo = 1)
BEGIN	
	UPDATE usuariopostulante SET MensajeDesktop = 1 WHERE CodigoUsuario = @CodigoUsuario
END
ELSE IF (@Tipo = 2)
BEGIN	
	UPDATE usuariopostulante SET MensajeMobile = 1 WHERE CodigoUsuario = @CodigoUsuario
END
GO

/*end*/

USE [BelcorpMexico]
GO
----------------------------------------------------------------------------
IF EXISTS(SELECT 1 FROM SYS.PROCEDURES WHERE NAME ='UpdatePostulanteMensajes')
BEGIN
	DROP PROCEDURE UpdatePostulanteMensajes
END
GO

CREATE PROCEDURE UpdatePostulanteMensajes 
	@CodigoUsuario INT,
	@Tipo  INT
AS
IF(@Tipo = 1)
BEGIN	
	UPDATE usuariopostulante SET MensajeDesktop = 1 WHERE CodigoUsuario = @CodigoUsuario
END
ELSE IF (@Tipo = 2)
BEGIN	
	UPDATE usuariopostulante SET MensajeMobile = 1 WHERE CodigoUsuario = @CodigoUsuario
END
GO

/*end*/

USE [BelcorpPanama]
GO
----------------------------------------------------------------------------
IF EXISTS(SELECT 1 FROM SYS.PROCEDURES WHERE NAME ='UpdatePostulanteMensajes')
BEGIN
	DROP PROCEDURE UpdatePostulanteMensajes
END
GO

CREATE PROCEDURE UpdatePostulanteMensajes 
	@CodigoUsuario INT,
	@Tipo  INT
AS
IF(@Tipo = 1)
BEGIN	
	UPDATE usuariopostulante SET MensajeDesktop = 1 WHERE CodigoUsuario = @CodigoUsuario
END
ELSE IF (@Tipo = 2)
BEGIN	
	UPDATE usuariopostulante SET MensajeMobile = 1 WHERE CodigoUsuario = @CodigoUsuario
END
GO

/*end*/

USE [BelcorpPeru]
GO
----------------------------------------------------------------------------
IF EXISTS(SELECT 1 FROM SYS.PROCEDURES WHERE NAME ='UpdatePostulanteMensajes')
BEGIN
	DROP PROCEDURE UpdatePostulanteMensajes
END
GO

CREATE PROCEDURE UpdatePostulanteMensajes 
	@CodigoUsuario INT,
	@Tipo  INT
AS
IF(@Tipo = 1)
BEGIN	
	UPDATE usuariopostulante SET MensajeDesktop = 1 WHERE CodigoUsuario = @CodigoUsuario
END
ELSE IF (@Tipo = 2)
BEGIN	
	UPDATE usuariopostulante SET MensajeMobile = 1 WHERE CodigoUsuario = @CodigoUsuario
END
GO

/*end*/

USE [BelcorpPuertoRico]
GO
----------------------------------------------------------------------------
IF EXISTS(SELECT 1 FROM SYS.PROCEDURES WHERE NAME ='UpdatePostulanteMensajes')
BEGIN
	DROP PROCEDURE UpdatePostulanteMensajes
END
GO

CREATE PROCEDURE UpdatePostulanteMensajes 
	@CodigoUsuario INT,
	@Tipo  INT
AS
IF(@Tipo = 1)
BEGIN	
	UPDATE usuariopostulante SET MensajeDesktop = 1 WHERE CodigoUsuario = @CodigoUsuario
END
ELSE IF (@Tipo = 2)
BEGIN	
	UPDATE usuariopostulante SET MensajeMobile = 1 WHERE CodigoUsuario = @CodigoUsuario
END
GO

/*end*/

USE [BelcorpSalvador]
GO
----------------------------------------------------------------------------
IF EXISTS(SELECT 1 FROM SYS.PROCEDURES WHERE NAME ='UpdatePostulanteMensajes')
BEGIN
	DROP PROCEDURE UpdatePostulanteMensajes
END
GO

CREATE PROCEDURE UpdatePostulanteMensajes 
	@CodigoUsuario INT,
	@Tipo  INT
AS
IF(@Tipo = 1)
BEGIN	
	UPDATE usuariopostulante SET MensajeDesktop = 1 WHERE CodigoUsuario = @CodigoUsuario
END
ELSE IF (@Tipo = 2)
BEGIN	
	UPDATE usuariopostulante SET MensajeMobile = 1 WHERE CodigoUsuario = @CodigoUsuario
END
GO

/*end*/

USE [BelcorpVenezuela]
GO
----------------------------------------------------------------------------
IF EXISTS(SELECT 1 FROM SYS.PROCEDURES WHERE NAME ='UpdatePostulanteMensajes')
BEGIN
	DROP PROCEDURE UpdatePostulanteMensajes
END
GO

CREATE PROCEDURE UpdatePostulanteMensajes 
	@CodigoUsuario INT,
	@Tipo  INT
AS
IF(@Tipo = 1)
BEGIN	
	UPDATE usuariopostulante SET MensajeDesktop = 1 WHERE CodigoUsuario = @CodigoUsuario
END
ELSE IF (@Tipo = 2)
BEGIN	
	UPDATE usuariopostulante SET MensajeMobile = 1 WHERE CodigoUsuario = @CodigoUsuario
END
GO

