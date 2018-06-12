USE BelcorpPeru
GO

IF (OBJECT_ID ( 'dbo.ValidarLoginJsonWebToken', 'P' ) IS NOT NULL)
	DROP PROCEDURE dbo.ValidarLoginJsonWebToken
GO
CREATE PROCEDURE dbo.ValidarLoginJsonWebToken
@Documento VARCHAR(50)  
AS  
BEGIN  
	SET NOCOUNT ON  
  
	DECLARE @Result TINYINT,
			 @Mensaje VARCHAR(100),
			 @CodigoUsuarioReal VARCHAR(20),
			 @CodigoConsultora VARCHAR(20),
			 @PaisID INT,
			 @TipoUsuario TINYINT,
			 @RolID INT
   
	SET @Result = 0  

	SELECT  
		@CodigoUsuarioReal = ISNULL(u.CodigoUsuario,''),  
		@CodigoConsultora = ISNULL(u.CodigoConsultora,''),  
		@PaisID = ISNULL(u.PaisID,0),  
		@TipoUsuario = ISNULL(u.TipoUsuario,0)
	FROM dbo.Usuario u (NOLOCK)   
	WHERE u.Activo = 1 
	AND RIGHT('000000000000000' + u.DocumentoIdentidad ,15) = RIGHT('000000000000000' + @Documento,15)

	SELECT
		@RolID = ISNULL(ur.RolID,0)
	FROM dbo.UsuarioRol ur (NOLOCK)
	WHERE ur.Activo = 1 
	AND ur.CodigoUsuario = @CodigoUsuarioReal
   
	-- validar si es usuario postulante  
	IF (@TipoUsuario = 2 AND ISNULL(@CodigoUsuarioReal,'') != '')  
	BEGIN  
		IF EXISTS(  
				SELECT 1 FROM dbo.UsuarioPostulante (NOLOCK)  
				WHERE CodigoUsuario = @CodigoUsuarioReal  
				AND Estado = 1 AND ISNULL(UsuarioReal,'0') = '0'  
				)  
		BEGIN  
			SET @CodigoConsultora = @CodigoUsuarioReal  
		END  
	END  
  
	IF (ISNULL(@CodigoConsultora,'') != '' AND @PaisID != 0)  
	BEGIN  
		SELECT 
			@Result = Result, 
			@Mensaje = Mensaje   
		FROM dbo.fnGetAccesoUsuario(@PaisID,@CodigoUsuarioReal,@CodigoConsultora,@TipoUsuario,@RolID)  
	END  
	ELSE  
	BEGIN  
		SET @Result = 4   
		SET @Mensaje = 'Nro de documento no exite'  
	END  
   
	SELECT 
		@Result AS Result,   
		@Mensaje AS Mensaje,   
		@CodigoUsuarioReal AS CodigoUsuario,  
		@TipoUsuario AS TipoUsuario  
  
	SET NOCOUNT OFF  
END  
GO

USE BelcorpMexico
GO

IF (OBJECT_ID ( 'dbo.ValidarLoginJsonWebToken', 'P' ) IS NOT NULL)
	DROP PROCEDURE dbo.ValidarLoginJsonWebToken
GO
CREATE PROCEDURE dbo.ValidarLoginJsonWebToken
@Documento VARCHAR(50)  
AS  
BEGIN  
	SET NOCOUNT ON  
  
	DECLARE @Result TINYINT,
			 @Mensaje VARCHAR(100),
			 @CodigoUsuarioReal VARCHAR(20),
			 @CodigoConsultora VARCHAR(20),
			 @PaisID INT,
			 @TipoUsuario TINYINT,
			 @RolID INT
   
	SET @Result = 0  

	SELECT  
		@CodigoUsuarioReal = ISNULL(u.CodigoUsuario,''),  
		@CodigoConsultora = ISNULL(u.CodigoConsultora,''),  
		@PaisID = ISNULL(u.PaisID,0),  
		@TipoUsuario = ISNULL(u.TipoUsuario,0)
	FROM dbo.Usuario u (NOLOCK)   
	WHERE u.Activo = 1 
	AND RIGHT('000000000000000' + u.DocumentoIdentidad ,15) = RIGHT('000000000000000' + @Documento,15)

	SELECT
		@RolID = ISNULL(ur.RolID,0)
	FROM dbo.UsuarioRol ur (NOLOCK)
	WHERE ur.Activo = 1 
	AND ur.CodigoUsuario = @CodigoUsuarioReal
   
	-- validar si es usuario postulante  
	IF (@TipoUsuario = 2 AND ISNULL(@CodigoUsuarioReal,'') != '')  
	BEGIN  
		IF EXISTS(  
				SELECT 1 FROM dbo.UsuarioPostulante (NOLOCK)  
				WHERE CodigoUsuario = @CodigoUsuarioReal  
				AND Estado = 1 AND ISNULL(UsuarioReal,'0') = '0'  
				)  
		BEGIN  
			SET @CodigoConsultora = @CodigoUsuarioReal  
		END  
	END  
  
	IF (ISNULL(@CodigoConsultora,'') != '' AND @PaisID != 0)  
	BEGIN  
		SELECT 
			@Result = Result, 
			@Mensaje = Mensaje   
		FROM dbo.fnGetAccesoUsuario(@PaisID,@CodigoUsuarioReal,@CodigoConsultora,@TipoUsuario,@RolID)  
	END  
	ELSE  
	BEGIN  
		SET @Result = 4   
		SET @Mensaje = 'Nro de documento no exite'  
	END  
   
	SELECT 
		@Result AS Result,   
		@Mensaje AS Mensaje,   
		@CodigoUsuarioReal AS CodigoUsuario,  
		@TipoUsuario AS TipoUsuario  
  
	SET NOCOUNT OFF  
END  
GO

USE BelcorpColombia
GO

IF (OBJECT_ID ( 'dbo.ValidarLoginJsonWebToken', 'P' ) IS NOT NULL)
	DROP PROCEDURE dbo.ValidarLoginJsonWebToken
GO
CREATE PROCEDURE dbo.ValidarLoginJsonWebToken
@Documento VARCHAR(50)  
AS  
BEGIN  
	SET NOCOUNT ON  
  
	DECLARE @Result TINYINT,
			 @Mensaje VARCHAR(100),
			 @CodigoUsuarioReal VARCHAR(20),
			 @CodigoConsultora VARCHAR(20),
			 @PaisID INT,
			 @TipoUsuario TINYINT,
			 @RolID INT
   
	SET @Result = 0  

	SELECT  
		@CodigoUsuarioReal = ISNULL(u.CodigoUsuario,''),  
		@CodigoConsultora = ISNULL(u.CodigoConsultora,''),  
		@PaisID = ISNULL(u.PaisID,0),  
		@TipoUsuario = ISNULL(u.TipoUsuario,0)
	FROM dbo.Usuario u (NOLOCK)   
	WHERE u.Activo = 1 
	AND RIGHT('000000000000000' + u.DocumentoIdentidad ,15) = RIGHT('000000000000000' + @Documento,15)

	SELECT
		@RolID = ISNULL(ur.RolID,0)
	FROM dbo.UsuarioRol ur (NOLOCK)
	WHERE ur.Activo = 1 
	AND ur.CodigoUsuario = @CodigoUsuarioReal
   
	-- validar si es usuario postulante  
	IF (@TipoUsuario = 2 AND ISNULL(@CodigoUsuarioReal,'') != '')  
	BEGIN  
		IF EXISTS(  
				SELECT 1 FROM dbo.UsuarioPostulante (NOLOCK)  
				WHERE CodigoUsuario = @CodigoUsuarioReal  
				AND Estado = 1 AND ISNULL(UsuarioReal,'0') = '0'  
				)  
		BEGIN  
			SET @CodigoConsultora = @CodigoUsuarioReal  
		END  
	END  
  
	IF (ISNULL(@CodigoConsultora,'') != '' AND @PaisID != 0)  
	BEGIN  
		SELECT 
			@Result = Result, 
			@Mensaje = Mensaje   
		FROM dbo.fnGetAccesoUsuario(@PaisID,@CodigoUsuarioReal,@CodigoConsultora,@TipoUsuario,@RolID)  
	END  
	ELSE  
	BEGIN  
		SET @Result = 4   
		SET @Mensaje = 'Nro de documento no exite'  
	END  
   
	SELECT 
		@Result AS Result,   
		@Mensaje AS Mensaje,   
		@CodigoUsuarioReal AS CodigoUsuario,  
		@TipoUsuario AS TipoUsuario  
  
	SET NOCOUNT OFF  
END  
GO

USE BelcorpSalvador
GO

IF (OBJECT_ID ( 'dbo.ValidarLoginJsonWebToken', 'P' ) IS NOT NULL)
	DROP PROCEDURE dbo.ValidarLoginJsonWebToken
GO
CREATE PROCEDURE dbo.ValidarLoginJsonWebToken
@Documento VARCHAR(50)  
AS  
BEGIN  
	SET NOCOUNT ON  
  
	DECLARE @Result TINYINT,
			 @Mensaje VARCHAR(100),
			 @CodigoUsuarioReal VARCHAR(20),
			 @CodigoConsultora VARCHAR(20),
			 @PaisID INT,
			 @TipoUsuario TINYINT,
			 @RolID INT
   
	SET @Result = 0  

	SELECT  
		@CodigoUsuarioReal = ISNULL(u.CodigoUsuario,''),  
		@CodigoConsultora = ISNULL(u.CodigoConsultora,''),  
		@PaisID = ISNULL(u.PaisID,0),  
		@TipoUsuario = ISNULL(u.TipoUsuario,0)
	FROM dbo.Usuario u (NOLOCK)   
	WHERE u.Activo = 1 
	AND RIGHT('000000000000000' + u.DocumentoIdentidad ,15) = RIGHT('000000000000000' + @Documento,15)

	SELECT
		@RolID = ISNULL(ur.RolID,0)
	FROM dbo.UsuarioRol ur (NOLOCK)
	WHERE ur.Activo = 1 
	AND ur.CodigoUsuario = @CodigoUsuarioReal
   
	-- validar si es usuario postulante  
	IF (@TipoUsuario = 2 AND ISNULL(@CodigoUsuarioReal,'') != '')  
	BEGIN  
		IF EXISTS(  
				SELECT 1 FROM dbo.UsuarioPostulante (NOLOCK)  
				WHERE CodigoUsuario = @CodigoUsuarioReal  
				AND Estado = 1 AND ISNULL(UsuarioReal,'0') = '0'  
				)  
		BEGIN  
			SET @CodigoConsultora = @CodigoUsuarioReal  
		END  
	END  
  
	IF (ISNULL(@CodigoConsultora,'') != '' AND @PaisID != 0)  
	BEGIN  
		SELECT 
			@Result = Result, 
			@Mensaje = Mensaje   
		FROM dbo.fnGetAccesoUsuario(@PaisID,@CodigoUsuarioReal,@CodigoConsultora,@TipoUsuario,@RolID)  
	END  
	ELSE  
	BEGIN  
		SET @Result = 4   
		SET @Mensaje = 'Nro de documento no exite'  
	END  
   
	SELECT 
		@Result AS Result,   
		@Mensaje AS Mensaje,   
		@CodigoUsuarioReal AS CodigoUsuario,  
		@TipoUsuario AS TipoUsuario  
  
	SET NOCOUNT OFF  
END  
GO

USE BelcorpPuertoRico
GO

IF (OBJECT_ID ( 'dbo.ValidarLoginJsonWebToken', 'P' ) IS NOT NULL)
	DROP PROCEDURE dbo.ValidarLoginJsonWebToken
GO
CREATE PROCEDURE dbo.ValidarLoginJsonWebToken
@Documento VARCHAR(50)  
AS  
BEGIN  
	SET NOCOUNT ON  
  
	DECLARE @Result TINYINT,
			 @Mensaje VARCHAR(100),
			 @CodigoUsuarioReal VARCHAR(20),
			 @CodigoConsultora VARCHAR(20),
			 @PaisID INT,
			 @TipoUsuario TINYINT,
			 @RolID INT
   
	SET @Result = 0  

	SELECT  
		@CodigoUsuarioReal = ISNULL(u.CodigoUsuario,''),  
		@CodigoConsultora = ISNULL(u.CodigoConsultora,''),  
		@PaisID = ISNULL(u.PaisID,0),  
		@TipoUsuario = ISNULL(u.TipoUsuario,0)
	FROM dbo.Usuario u (NOLOCK)   
	WHERE u.Activo = 1 
	AND RIGHT('000000000000000' + u.DocumentoIdentidad ,15) = RIGHT('000000000000000' + @Documento,15)

	SELECT
		@RolID = ISNULL(ur.RolID,0)
	FROM dbo.UsuarioRol ur (NOLOCK)
	WHERE ur.Activo = 1 
	AND ur.CodigoUsuario = @CodigoUsuarioReal
   
	-- validar si es usuario postulante  
	IF (@TipoUsuario = 2 AND ISNULL(@CodigoUsuarioReal,'') != '')  
	BEGIN  
		IF EXISTS(  
				SELECT 1 FROM dbo.UsuarioPostulante (NOLOCK)  
				WHERE CodigoUsuario = @CodigoUsuarioReal  
				AND Estado = 1 AND ISNULL(UsuarioReal,'0') = '0'  
				)  
		BEGIN  
			SET @CodigoConsultora = @CodigoUsuarioReal  
		END  
	END  
  
	IF (ISNULL(@CodigoConsultora,'') != '' AND @PaisID != 0)  
	BEGIN  
		SELECT 
			@Result = Result, 
			@Mensaje = Mensaje   
		FROM dbo.fnGetAccesoUsuario(@PaisID,@CodigoUsuarioReal,@CodigoConsultora,@TipoUsuario,@RolID)  
	END  
	ELSE  
	BEGIN  
		SET @Result = 4   
		SET @Mensaje = 'Nro de documento no exite'  
	END  
   
	SELECT 
		@Result AS Result,   
		@Mensaje AS Mensaje,   
		@CodigoUsuarioReal AS CodigoUsuario,  
		@TipoUsuario AS TipoUsuario  
  
	SET NOCOUNT OFF  
END  
GO

USE BelcorpPanama
GO

IF (OBJECT_ID ( 'dbo.ValidarLoginJsonWebToken', 'P' ) IS NOT NULL)
	DROP PROCEDURE dbo.ValidarLoginJsonWebToken
GO
CREATE PROCEDURE dbo.ValidarLoginJsonWebToken
@Documento VARCHAR(50)  
AS  
BEGIN  
	SET NOCOUNT ON  
  
	DECLARE @Result TINYINT,
			 @Mensaje VARCHAR(100),
			 @CodigoUsuarioReal VARCHAR(20),
			 @CodigoConsultora VARCHAR(20),
			 @PaisID INT,
			 @TipoUsuario TINYINT,
			 @RolID INT
   
	SET @Result = 0  

	SELECT  
		@CodigoUsuarioReal = ISNULL(u.CodigoUsuario,''),  
		@CodigoConsultora = ISNULL(u.CodigoConsultora,''),  
		@PaisID = ISNULL(u.PaisID,0),  
		@TipoUsuario = ISNULL(u.TipoUsuario,0)
	FROM dbo.Usuario u (NOLOCK)   
	WHERE u.Activo = 1 
	AND RIGHT('000000000000000' + u.DocumentoIdentidad ,15) = RIGHT('000000000000000' + @Documento,15)

	SELECT
		@RolID = ISNULL(ur.RolID,0)
	FROM dbo.UsuarioRol ur (NOLOCK)
	WHERE ur.Activo = 1 
	AND ur.CodigoUsuario = @CodigoUsuarioReal
   
	-- validar si es usuario postulante  
	IF (@TipoUsuario = 2 AND ISNULL(@CodigoUsuarioReal,'') != '')  
	BEGIN  
		IF EXISTS(  
				SELECT 1 FROM dbo.UsuarioPostulante (NOLOCK)  
				WHERE CodigoUsuario = @CodigoUsuarioReal  
				AND Estado = 1 AND ISNULL(UsuarioReal,'0') = '0'  
				)  
		BEGIN  
			SET @CodigoConsultora = @CodigoUsuarioReal  
		END  
	END  
  
	IF (ISNULL(@CodigoConsultora,'') != '' AND @PaisID != 0)  
	BEGIN  
		SELECT 
			@Result = Result, 
			@Mensaje = Mensaje   
		FROM dbo.fnGetAccesoUsuario(@PaisID,@CodigoUsuarioReal,@CodigoConsultora,@TipoUsuario,@RolID)  
	END  
	ELSE  
	BEGIN  
		SET @Result = 4   
		SET @Mensaje = 'Nro de documento no exite'  
	END  
   
	SELECT 
		@Result AS Result,   
		@Mensaje AS Mensaje,   
		@CodigoUsuarioReal AS CodigoUsuario,  
		@TipoUsuario AS TipoUsuario  
  
	SET NOCOUNT OFF  
END  
GO

USE BelcorpGuatemala
GO

IF (OBJECT_ID ( 'dbo.ValidarLoginJsonWebToken', 'P' ) IS NOT NULL)
	DROP PROCEDURE dbo.ValidarLoginJsonWebToken
GO
CREATE PROCEDURE dbo.ValidarLoginJsonWebToken
@Documento VARCHAR(50)  
AS  
BEGIN  
	SET NOCOUNT ON  
  
	DECLARE @Result TINYINT,
			 @Mensaje VARCHAR(100),
			 @CodigoUsuarioReal VARCHAR(20),
			 @CodigoConsultora VARCHAR(20),
			 @PaisID INT,
			 @TipoUsuario TINYINT,
			 @RolID INT
   
	SET @Result = 0  

	SELECT  
		@CodigoUsuarioReal = ISNULL(u.CodigoUsuario,''),  
		@CodigoConsultora = ISNULL(u.CodigoConsultora,''),  
		@PaisID = ISNULL(u.PaisID,0),  
		@TipoUsuario = ISNULL(u.TipoUsuario,0)
	FROM dbo.Usuario u (NOLOCK)   
	WHERE u.Activo = 1 
	AND RIGHT('000000000000000' + u.DocumentoIdentidad ,15) = RIGHT('000000000000000' + @Documento,15)

	SELECT
		@RolID = ISNULL(ur.RolID,0)
	FROM dbo.UsuarioRol ur (NOLOCK)
	WHERE ur.Activo = 1 
	AND ur.CodigoUsuario = @CodigoUsuarioReal
   
	-- validar si es usuario postulante  
	IF (@TipoUsuario = 2 AND ISNULL(@CodigoUsuarioReal,'') != '')  
	BEGIN  
		IF EXISTS(  
				SELECT 1 FROM dbo.UsuarioPostulante (NOLOCK)  
				WHERE CodigoUsuario = @CodigoUsuarioReal  
				AND Estado = 1 AND ISNULL(UsuarioReal,'0') = '0'  
				)  
		BEGIN  
			SET @CodigoConsultora = @CodigoUsuarioReal  
		END  
	END  
  
	IF (ISNULL(@CodigoConsultora,'') != '' AND @PaisID != 0)  
	BEGIN  
		SELECT 
			@Result = Result, 
			@Mensaje = Mensaje   
		FROM dbo.fnGetAccesoUsuario(@PaisID,@CodigoUsuarioReal,@CodigoConsultora,@TipoUsuario,@RolID)  
	END  
	ELSE  
	BEGIN  
		SET @Result = 4   
		SET @Mensaje = 'Nro de documento no exite'  
	END  
   
	SELECT 
		@Result AS Result,   
		@Mensaje AS Mensaje,   
		@CodigoUsuarioReal AS CodigoUsuario,  
		@TipoUsuario AS TipoUsuario  
  
	SET NOCOUNT OFF  
END  
GO

USE BelcorpEcuador
GO

IF (OBJECT_ID ( 'dbo.ValidarLoginJsonWebToken', 'P' ) IS NOT NULL)
	DROP PROCEDURE dbo.ValidarLoginJsonWebToken
GO
CREATE PROCEDURE dbo.ValidarLoginJsonWebToken
@Documento VARCHAR(50)  
AS  
BEGIN  
	SET NOCOUNT ON  
  
	DECLARE @Result TINYINT,
			 @Mensaje VARCHAR(100),
			 @CodigoUsuarioReal VARCHAR(20),
			 @CodigoConsultora VARCHAR(20),
			 @PaisID INT,
			 @TipoUsuario TINYINT,
			 @RolID INT
   
	SET @Result = 0  

	SELECT  
		@CodigoUsuarioReal = ISNULL(u.CodigoUsuario,''),  
		@CodigoConsultora = ISNULL(u.CodigoConsultora,''),  
		@PaisID = ISNULL(u.PaisID,0),  
		@TipoUsuario = ISNULL(u.TipoUsuario,0)
	FROM dbo.Usuario u (NOLOCK)   
	WHERE u.Activo = 1 
	AND RIGHT('000000000000000' + u.DocumentoIdentidad ,15) = RIGHT('000000000000000' + @Documento,15)

	SELECT
		@RolID = ISNULL(ur.RolID,0)
	FROM dbo.UsuarioRol ur (NOLOCK)
	WHERE ur.Activo = 1 
	AND ur.CodigoUsuario = @CodigoUsuarioReal
   
	-- validar si es usuario postulante  
	IF (@TipoUsuario = 2 AND ISNULL(@CodigoUsuarioReal,'') != '')  
	BEGIN  
		IF EXISTS(  
				SELECT 1 FROM dbo.UsuarioPostulante (NOLOCK)  
				WHERE CodigoUsuario = @CodigoUsuarioReal  
				AND Estado = 1 AND ISNULL(UsuarioReal,'0') = '0'  
				)  
		BEGIN  
			SET @CodigoConsultora = @CodigoUsuarioReal  
		END  
	END  
  
	IF (ISNULL(@CodigoConsultora,'') != '' AND @PaisID != 0)  
	BEGIN  
		SELECT 
			@Result = Result, 
			@Mensaje = Mensaje   
		FROM dbo.fnGetAccesoUsuario(@PaisID,@CodigoUsuarioReal,@CodigoConsultora,@TipoUsuario,@RolID)  
	END  
	ELSE  
	BEGIN  
		SET @Result = 4   
		SET @Mensaje = 'Nro de documento no exite'  
	END  
   
	SELECT 
		@Result AS Result,   
		@Mensaje AS Mensaje,   
		@CodigoUsuarioReal AS CodigoUsuario,  
		@TipoUsuario AS TipoUsuario  
  
	SET NOCOUNT OFF  
END  
GO

USE BelcorpDominicana
GO

IF (OBJECT_ID ( 'dbo.ValidarLoginJsonWebToken', 'P' ) IS NOT NULL)
	DROP PROCEDURE dbo.ValidarLoginJsonWebToken
GO
CREATE PROCEDURE dbo.ValidarLoginJsonWebToken
@Documento VARCHAR(50)  
AS  
BEGIN  
	SET NOCOUNT ON  
  
	DECLARE @Result TINYINT,
			 @Mensaje VARCHAR(100),
			 @CodigoUsuarioReal VARCHAR(20),
			 @CodigoConsultora VARCHAR(20),
			 @PaisID INT,
			 @TipoUsuario TINYINT,
			 @RolID INT
   
	SET @Result = 0  

	SELECT  
		@CodigoUsuarioReal = ISNULL(u.CodigoUsuario,''),  
		@CodigoConsultora = ISNULL(u.CodigoConsultora,''),  
		@PaisID = ISNULL(u.PaisID,0),  
		@TipoUsuario = ISNULL(u.TipoUsuario,0)
	FROM dbo.Usuario u (NOLOCK)   
	WHERE u.Activo = 1 
	AND RIGHT('000000000000000' + u.DocumentoIdentidad ,15) = RIGHT('000000000000000' + @Documento,15)

	SELECT
		@RolID = ISNULL(ur.RolID,0)
	FROM dbo.UsuarioRol ur (NOLOCK)
	WHERE ur.Activo = 1 
	AND ur.CodigoUsuario = @CodigoUsuarioReal
   
	-- validar si es usuario postulante  
	IF (@TipoUsuario = 2 AND ISNULL(@CodigoUsuarioReal,'') != '')  
	BEGIN  
		IF EXISTS(  
				SELECT 1 FROM dbo.UsuarioPostulante (NOLOCK)  
				WHERE CodigoUsuario = @CodigoUsuarioReal  
				AND Estado = 1 AND ISNULL(UsuarioReal,'0') = '0'  
				)  
		BEGIN  
			SET @CodigoConsultora = @CodigoUsuarioReal  
		END  
	END  
  
	IF (ISNULL(@CodigoConsultora,'') != '' AND @PaisID != 0)  
	BEGIN  
		SELECT 
			@Result = Result, 
			@Mensaje = Mensaje   
		FROM dbo.fnGetAccesoUsuario(@PaisID,@CodigoUsuarioReal,@CodigoConsultora,@TipoUsuario,@RolID)  
	END  
	ELSE  
	BEGIN  
		SET @Result = 4   
		SET @Mensaje = 'Nro de documento no exite'  
	END  
   
	SELECT 
		@Result AS Result,   
		@Mensaje AS Mensaje,   
		@CodigoUsuarioReal AS CodigoUsuario,  
		@TipoUsuario AS TipoUsuario  
  
	SET NOCOUNT OFF  
END  
GO

USE BelcorpCostaRica
GO

IF (OBJECT_ID ( 'dbo.ValidarLoginJsonWebToken', 'P' ) IS NOT NULL)
	DROP PROCEDURE dbo.ValidarLoginJsonWebToken
GO
CREATE PROCEDURE dbo.ValidarLoginJsonWebToken
@Documento VARCHAR(50)  
AS  
BEGIN  
	SET NOCOUNT ON  
  
	DECLARE @Result TINYINT,
			 @Mensaje VARCHAR(100),
			 @CodigoUsuarioReal VARCHAR(20),
			 @CodigoConsultora VARCHAR(20),
			 @PaisID INT,
			 @TipoUsuario TINYINT,
			 @RolID INT
   
	SET @Result = 0  

	SELECT  
		@CodigoUsuarioReal = ISNULL(u.CodigoUsuario,''),  
		@CodigoConsultora = ISNULL(u.CodigoConsultora,''),  
		@PaisID = ISNULL(u.PaisID,0),  
		@TipoUsuario = ISNULL(u.TipoUsuario,0)
	FROM dbo.Usuario u (NOLOCK)   
	WHERE u.Activo = 1 
	AND RIGHT('000000000000000' + u.DocumentoIdentidad ,15) = RIGHT('000000000000000' + @Documento,15)

	SELECT
		@RolID = ISNULL(ur.RolID,0)
	FROM dbo.UsuarioRol ur (NOLOCK)
	WHERE ur.Activo = 1 
	AND ur.CodigoUsuario = @CodigoUsuarioReal
   
	-- validar si es usuario postulante  
	IF (@TipoUsuario = 2 AND ISNULL(@CodigoUsuarioReal,'') != '')  
	BEGIN  
		IF EXISTS(  
				SELECT 1 FROM dbo.UsuarioPostulante (NOLOCK)  
				WHERE CodigoUsuario = @CodigoUsuarioReal  
				AND Estado = 1 AND ISNULL(UsuarioReal,'0') = '0'  
				)  
		BEGIN  
			SET @CodigoConsultora = @CodigoUsuarioReal  
		END  
	END  
  
	IF (ISNULL(@CodigoConsultora,'') != '' AND @PaisID != 0)  
	BEGIN  
		SELECT 
			@Result = Result, 
			@Mensaje = Mensaje   
		FROM dbo.fnGetAccesoUsuario(@PaisID,@CodigoUsuarioReal,@CodigoConsultora,@TipoUsuario,@RolID)  
	END  
	ELSE  
	BEGIN  
		SET @Result = 4   
		SET @Mensaje = 'Nro de documento no exite'  
	END  
   
	SELECT 
		@Result AS Result,   
		@Mensaje AS Mensaje,   
		@CodigoUsuarioReal AS CodigoUsuario,  
		@TipoUsuario AS TipoUsuario  
  
	SET NOCOUNT OFF  
END  
GO

USE BelcorpChile
GO

IF (OBJECT_ID ( 'dbo.ValidarLoginJsonWebToken', 'P' ) IS NOT NULL)
	DROP PROCEDURE dbo.ValidarLoginJsonWebToken
GO
CREATE PROCEDURE dbo.ValidarLoginJsonWebToken
@Documento VARCHAR(50)  
AS  
BEGIN  
	SET NOCOUNT ON  
  
	DECLARE @Result TINYINT,
			 @Mensaje VARCHAR(100),
			 @CodigoUsuarioReal VARCHAR(20),
			 @CodigoConsultora VARCHAR(20),
			 @PaisID INT,
			 @TipoUsuario TINYINT,
			 @RolID INT
   
	SET @Result = 0  

	SELECT  
		@CodigoUsuarioReal = ISNULL(u.CodigoUsuario,''),  
		@CodigoConsultora = ISNULL(u.CodigoConsultora,''),  
		@PaisID = ISNULL(u.PaisID,0),  
		@TipoUsuario = ISNULL(u.TipoUsuario,0)
	FROM dbo.Usuario u (NOLOCK)   
	WHERE u.Activo = 1 
	AND RIGHT('000000000000000' + u.DocumentoIdentidad ,15) = RIGHT('000000000000000' + @Documento,15)

	SELECT
		@RolID = ISNULL(ur.RolID,0)
	FROM dbo.UsuarioRol ur (NOLOCK)
	WHERE ur.Activo = 1 
	AND ur.CodigoUsuario = @CodigoUsuarioReal
   
	-- validar si es usuario postulante  
	IF (@TipoUsuario = 2 AND ISNULL(@CodigoUsuarioReal,'') != '')  
	BEGIN  
		IF EXISTS(  
				SELECT 1 FROM dbo.UsuarioPostulante (NOLOCK)  
				WHERE CodigoUsuario = @CodigoUsuarioReal  
				AND Estado = 1 AND ISNULL(UsuarioReal,'0') = '0'  
				)  
		BEGIN  
			SET @CodigoConsultora = @CodigoUsuarioReal  
		END  
	END  
  
	IF (ISNULL(@CodigoConsultora,'') != '' AND @PaisID != 0)  
	BEGIN  
		SELECT 
			@Result = Result, 
			@Mensaje = Mensaje   
		FROM dbo.fnGetAccesoUsuario(@PaisID,@CodigoUsuarioReal,@CodigoConsultora,@TipoUsuario,@RolID)  
	END  
	ELSE  
	BEGIN  
		SET @Result = 4   
		SET @Mensaje = 'Nro de documento no exite'  
	END  
   
	SELECT 
		@Result AS Result,   
		@Mensaje AS Mensaje,   
		@CodigoUsuarioReal AS CodigoUsuario,  
		@TipoUsuario AS TipoUsuario  
  
	SET NOCOUNT OFF  
END  
GO

USE BelcorpBolivia
GO

IF (OBJECT_ID ( 'dbo.ValidarLoginJsonWebToken', 'P' ) IS NOT NULL)
	DROP PROCEDURE dbo.ValidarLoginJsonWebToken
GO
CREATE PROCEDURE dbo.ValidarLoginJsonWebToken
@Documento VARCHAR(50)  
AS  
BEGIN  
	SET NOCOUNT ON  
  
	DECLARE @Result TINYINT,
			 @Mensaje VARCHAR(100),
			 @CodigoUsuarioReal VARCHAR(20),
			 @CodigoConsultora VARCHAR(20),
			 @PaisID INT,
			 @TipoUsuario TINYINT,
			 @RolID INT
   
	SET @Result = 0  

	SELECT  
		@CodigoUsuarioReal = ISNULL(u.CodigoUsuario,''),  
		@CodigoConsultora = ISNULL(u.CodigoConsultora,''),  
		@PaisID = ISNULL(u.PaisID,0),  
		@TipoUsuario = ISNULL(u.TipoUsuario,0)
	FROM dbo.Usuario u (NOLOCK)   
	WHERE u.Activo = 1 
	AND RIGHT('000000000000000' + u.DocumentoIdentidad ,15) = RIGHT('000000000000000' + @Documento,15)

	SELECT
		@RolID = ISNULL(ur.RolID,0)
	FROM dbo.UsuarioRol ur (NOLOCK)
	WHERE ur.Activo = 1 
	AND ur.CodigoUsuario = @CodigoUsuarioReal
   
	-- validar si es usuario postulante  
	IF (@TipoUsuario = 2 AND ISNULL(@CodigoUsuarioReal,'') != '')  
	BEGIN  
		IF EXISTS(  
				SELECT 1 FROM dbo.UsuarioPostulante (NOLOCK)  
				WHERE CodigoUsuario = @CodigoUsuarioReal  
				AND Estado = 1 AND ISNULL(UsuarioReal,'0') = '0'  
				)  
		BEGIN  
			SET @CodigoConsultora = @CodigoUsuarioReal  
		END  
	END  
  
	IF (ISNULL(@CodigoConsultora,'') != '' AND @PaisID != 0)  
	BEGIN  
		SELECT 
			@Result = Result, 
			@Mensaje = Mensaje   
		FROM dbo.fnGetAccesoUsuario(@PaisID,@CodigoUsuarioReal,@CodigoConsultora,@TipoUsuario,@RolID)  
	END  
	ELSE  
	BEGIN  
		SET @Result = 4   
		SET @Mensaje = 'Nro de documento no exite'  
	END  
   
	SELECT 
		@Result AS Result,   
		@Mensaje AS Mensaje,   
		@CodigoUsuarioReal AS CodigoUsuario,  
		@TipoUsuario AS TipoUsuario  
  
	SET NOCOUNT OFF  
END  
GO

