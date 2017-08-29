CREATE PROCEDURE ValidarValorRestauracionClave
	@CodigoUsuario	VARCHAR(50),
	@PaisID	INT
AS
BEGIN	
	SET NOCOUNT ON

	DECLARE @Nombre			varchar(80)
	DECLARE @Cantidad		int
	DECLARE @Correo			varchar(80)
	DECLARE @ClaveSecreta   varchar(200)
	DECLARE @TipoUsuario	TINYINT
	DECLARE @RolID			INT

	IF (@PaisID = 3 OR @PaisID = 4 OR @PaisID = 6)
	BEGIN
		SELECT TOP 1
			@Cantidad = 1,
			@CodigoUsuario = U.CodigoUsuario,
			@Nombre = STUFF (lower(U.Nombre), 1, 1, UPPER(left(lower(U.Nombre), 1))),
			@Correo = U.EMail,
			@ClaveSecreta = U.ClaveSecreta,
			@TipoUsuario = ISNULL(u.TipoUsuario,0),
			@RolID = ISNULL(ur.RolID,0)
		FROM dbo.Usuario U WITH(NOLOCK)
		INNER JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario AND u.Activo = 1
		WHERE U.DOCUMENTOIDENTIDAD = @CodigoUsuario
		ORDER BY U.EMailActivo DESC		
	END
	ELSE
	BEGIN
		SELECT TOP 1
			@Cantidad = 1,
			@CodigoUsuario = U.CodigoUsuario,
			@Nombre = STUFF (lower(U.Nombre), 1, 1, UPPER(left(lower(U.Nombre), 1))),
			@Correo = U.EMail,
			@ClaveSecreta = U.ClaveSecreta,
			@TipoUsuario = ISNULL(u.TipoUsuario,0),
			@RolID = ISNULL(ur.RolID,0)
		FROM dbo.Usuario U WITH(NOLOCK)
		INNER JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario AND u.Activo = 1
		WHERE U.CODIGOCONSULTORA = @CodigoUsuario OR U.DOCUMENTOIDENTIDAD = @CodigoUsuario
		ORDER BY U.EMailActivo DESC
	END

	SELECT
		ISNULL(@Cantidad,0) AS Cantidad,
		ISNULL(@CodigoUsuario, '') AS CodigoUsuario,
		(SELECT CodigoISO FROM dbo.Pais (NOLOCK) WHERE PaisID = @PaisID) AS CodigoISO,
		ISNULL((SELECT TOP(1) Descripcion FROM dbo.FormularioDato (NOLOCK) WHERE TipoFormularioID = 1103 and PaisID = @PaisID), '') AS Descripcion,
		ISNULL(@Nombre, '') AS Nombre,
		ISNULL(@Correo, '') AS Correo,
		@ClaveSecreta AS ClaveSecreta,
		@TipoUsuario AS TipoUsuario,
		@RolID AS RolID,
		3 as Telefono_Cantidad,
		'955898074|955898074|955898074' as Telefono_Central,
		'' as Telefono_Capital,
		'' as Telefono_Provincias
				
	SET NOCOUNT OFF
END

