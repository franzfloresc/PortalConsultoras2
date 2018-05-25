USE BelcorpPeru
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ValidarLoginJsonWebToken]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ValidarLoginJsonWebToken]
GO
-- EXEC ValidarLogin '042412058' , '042412058'
-- EXEC ValidarLoginJsonWebToken  '44459457'

CREATE PROCEDURE [dbo].[ValidarLoginJsonWebToken]
(
	 @Documento VARCHAR(50)
)
AS
BEGIN
	--DECLARE @Documento VARCHAR(50) = '44459457'
	SET NOCOUNT ON

	DECLARE @Result TINYINT
	DECLARE @Mensaje VARCHAR(100)
	SET @Result = 0
	DECLARE @CodigoUsuarioReal VARCHAR(20)
	DECLARE @CodigoConsultora VARCHAR(20)
	DECLARE @PaisID INT
	DECLARE @TipoUsuario TINYINT
	DECLARE @RolID INT
	
	
	SELECT
		@CodigoUsuarioReal = ISNULL(u.CodigoUsuario,''),
		@CodigoConsultora = ISNULL(u.CodigoConsultora,''),
		@PaisID = ISNULL(u.PaisID,0),
		@TipoUsuario = ISNULL(u.TipoUsuario,0),
		@RolID = ISNULL(ur.RolID,0)
	FROM Usuario u WITH(NOLOCK) 
	INNER JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario AND ur.Activo = 1
	WHERE u.Activo = 1 AND  right('000000000000000' +u.DocumentoIdentidad ,15) = right('000000000000000' +@Documento,15)
	
	-- validar si es usuario postulante
	
	IF (@TipoUsuario = 2 AND ISNULL(@CodigoUsuarioReal,'') != '')
	BEGIN
		IF EXISTS(
			SELECT 1 FROM UsuarioPostulante WITH(NOLOCK)
			WHERE CodigoUsuario = @CodigoUsuarioReal
			AND Estado = 1 AND ISNULL(UsuarioReal,'0') = '0'
		)
		BEGIN
			SET @CodigoConsultora = @CodigoUsuarioReal
		END
	END
	
	print @PaisID
	print @CodigoConsultora

	IF (ISNULL(@CodigoConsultora,'') != '' AND @PaisID != 0)
	BEGIN
		SELECT @Result = Result, @Mensaje = Mensaje 
		FROM dbo.fnGetAccesoUsuario(@PaisID,@CodigoUsuarioReal,@CodigoConsultora,@TipoUsuario,@RolID)
	END
	ELSE
	BEGIN
		SET @Result = 4 
		SET @Mensaje = 'Nro de documento no exite'
	END
	
	
	SELECT @Result AS Result, 
		@Mensaje AS Mensaje, 
		@CodigoUsuarioReal AS CodigoUsuario,
		@TipoUsuario AS TipoUsuario

	SET NOCOUNT OFF

END

