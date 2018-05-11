
USE BelcorpPeru
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'ValidarValorRestauracionClave')
BEGIN
	DROP PROC [dbo].[ValidarValorRestauracionClave]
END
GO
-- [dbo].[ValidarValorRestauracionClave] '041541709', 11
CREATE PROCEDURE [dbo].[ValidarValorRestauracionClave] 
	@CodigoEntrante	VARCHAR(50),
	@PaisID	INT
AS
BEGIN	
	SET NOCOUNT ON

	DECLARE @CodigoUsuario varchar(20)
	DECLARE @Nombre			varchar(80)
	DECLARE @Cantidad		int
	DECLARE @Correo			varchar(80)
	DECLARE @ClaveSecreta   varchar(200)
	DECLARE @TipoUsuario	TINYINT
	DECLARE @RolID			INT
	DECLARE @Celular		varchar(20)
	DECLARE @PrimerNombre	varchar(30)

	DECLARE @CantidadHr int = 0
	DECLARE @CantidadRegistros int = 0

	IF (@PaisID = 3 OR @PaisID = 4 OR @PaisID = 6)
	BEGIN
		SELECT TOP 1
			@Cantidad = 1,
			@CodigoUsuario = U.CodigoUsuario,
			@Nombre = STUFF (lower(U.Nombre), 1, 1, UPPER(left(lower(U.Nombre), 1))),
			@Correo = U.EMail,
			@ClaveSecreta = U.ClaveSecreta,
			@TipoUsuario = ISNULL(u.TipoUsuario,0),
			@RolID = ISNULL(ur.RolID,0),
			@Celular = ISNULL(U.Celular,''),
			@PrimerNombre = substring(ISNULL(co.PrimerNombre, ''),1,1) + lower(substring(ISNULL(co.PrimerNombre, ''),2, Len(co.PrimerNombre)))
		FROM dbo.Usuario U WITH(NOLOCK)
		INNER JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario AND u.Activo = 1
		LEFT JOIN ods.Consultora co WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE U.DOCUMENTOIDENTIDAD = @CodigoEntrante
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
			@RolID = ISNULL(ur.RolID,0),
			@Celular = ISNULL(U.Celular,''),
			@PrimerNombre = substring(ISNULL(co.PrimerNombre, ''),1,1) + lower(substring(ISNULL(co.PrimerNombre, ''),2, Len(co.PrimerNombre)))
		FROM dbo.Usuario U WITH(NOLOCK)
		INNER JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario AND u.Activo = 1
		LEFT JOIN ods.Consultora co WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE U.CODIGOCONSULTORA = @CodigoEntrante OR U.DOCUMENTOIDENTIDAD = @CodigoEntrante
		ORDER BY U.EMailActivo DESC
	END

	SELECT
		ISNULL(@Cantidad,0) AS Cantidad,
		ISNULL(@CodigoEntrante, '') AS CodigoEntrante, 
		ISNULL(@CodigoUsuario, '') AS CodigoUsuario,
		(SELECT CodigoISO FROM dbo.Pais (NOLOCK) WHERE PaisID = @PaisID) AS CodigoISO,
		ISNULL((SELECT TOP(1) Descripcion FROM dbo.FormularioDato (NOLOCK) WHERE TipoFormularioID = 1103 and PaisID = @PaisID), '') AS Descripcion,
		ISNULL(@Nombre, '') AS NombreCompleto,
		@PrimerNombre AS PrimerNombre,
		ISNULL(@Correo, '') AS Correo,
		--@Celular as Celular,
		--'' AS Correo,
		'' AS Celular,
		@ClaveSecreta AS ClaveSecreta,
		@TipoUsuario AS TipoUsuario,
		@RolID AS RolID,
		3 as Telefono_Cantidad,
		'955898074|955898074|955898074' as Telefono_Central,
		'' as Telefono_Capital,
		'' as Telefono_Provincias

	SET NOCOUNT OFF
END
GO

USE BelcorpMexico
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'ValidarValorRestauracionClave')
BEGIN
	DROP PROC [dbo].[ValidarValorRestauracionClave]
END
GO
-- [dbo].[ValidarValorRestauracionClave] '041541709', 11
CREATE PROCEDURE [dbo].[ValidarValorRestauracionClave] 
	@CodigoEntrante	VARCHAR(50),
	@PaisID	INT
AS
BEGIN	
	SET NOCOUNT ON

	DECLARE @CodigoUsuario varchar(20)
	DECLARE @Nombre			varchar(80)
	DECLARE @Cantidad		int
	DECLARE @Correo			varchar(80)
	DECLARE @ClaveSecreta   varchar(200)
	DECLARE @TipoUsuario	TINYINT
	DECLARE @RolID			INT
	DECLARE @Celular		varchar(20)
	DECLARE @PrimerNombre	varchar(30)

	DECLARE @CantidadHr int = 0
	DECLARE @CantidadRegistros int = 0

	IF (@PaisID = 3 OR @PaisID = 4 OR @PaisID = 6)
	BEGIN
		SELECT TOP 1
			@Cantidad = 1,
			@CodigoUsuario = U.CodigoUsuario,
			@Nombre = STUFF (lower(U.Nombre), 1, 1, UPPER(left(lower(U.Nombre), 1))),
			@Correo = U.EMail,
			@ClaveSecreta = U.ClaveSecreta,
			@TipoUsuario = ISNULL(u.TipoUsuario,0),
			@RolID = ISNULL(ur.RolID,0),
			@Celular = ISNULL(U.Celular,''),
			@PrimerNombre = substring(ISNULL(co.PrimerNombre, ''),1,1) + lower(substring(ISNULL(co.PrimerNombre, ''),2, Len(co.PrimerNombre)))
		FROM dbo.Usuario U WITH(NOLOCK)
		INNER JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario AND u.Activo = 1
		LEFT JOIN ods.Consultora co WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE U.DOCUMENTOIDENTIDAD = @CodigoEntrante
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
			@RolID = ISNULL(ur.RolID,0),
			@Celular = ISNULL(U.Celular,''),
			@PrimerNombre = substring(ISNULL(co.PrimerNombre, ''),1,1) + lower(substring(ISNULL(co.PrimerNombre, ''),2, Len(co.PrimerNombre)))
		FROM dbo.Usuario U WITH(NOLOCK)
		INNER JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario AND u.Activo = 1
		LEFT JOIN ods.Consultora co WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE U.CODIGOCONSULTORA = @CodigoEntrante OR U.DOCUMENTOIDENTIDAD = @CodigoEntrante
		ORDER BY U.EMailActivo DESC
	END

	SELECT
		ISNULL(@Cantidad,0) AS Cantidad,
		ISNULL(@CodigoEntrante, '') AS CodigoEntrante, 
		ISNULL(@CodigoUsuario, '') AS CodigoUsuario,
		(SELECT CodigoISO FROM dbo.Pais (NOLOCK) WHERE PaisID = @PaisID) AS CodigoISO,
		ISNULL((SELECT TOP(1) Descripcion FROM dbo.FormularioDato (NOLOCK) WHERE TipoFormularioID = 1103 and PaisID = @PaisID), '') AS Descripcion,
		ISNULL(@Nombre, '') AS NombreCompleto,
		@PrimerNombre AS PrimerNombre,
		ISNULL(@Correo, '') AS Correo,
		--@Celular as Celular,
		--'' AS Correo,
		'' AS Celular,
		@ClaveSecreta AS ClaveSecreta,
		@TipoUsuario AS TipoUsuario,
		@RolID AS RolID,
		3 as Telefono_Cantidad,
		'955898074|955898074|955898074' as Telefono_Central,
		'' as Telefono_Capital,
		'' as Telefono_Provincias

	SET NOCOUNT OFF
END
GO

USE BelcorpColombia
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'ValidarValorRestauracionClave')
BEGIN
	DROP PROC [dbo].[ValidarValorRestauracionClave]
END
GO
-- [dbo].[ValidarValorRestauracionClave] '041541709', 11
CREATE PROCEDURE [dbo].[ValidarValorRestauracionClave] 
	@CodigoEntrante	VARCHAR(50),
	@PaisID	INT
AS
BEGIN	
	SET NOCOUNT ON

	DECLARE @CodigoUsuario varchar(20)
	DECLARE @Nombre			varchar(80)
	DECLARE @Cantidad		int
	DECLARE @Correo			varchar(80)
	DECLARE @ClaveSecreta   varchar(200)
	DECLARE @TipoUsuario	TINYINT
	DECLARE @RolID			INT
	DECLARE @Celular		varchar(20)
	DECLARE @PrimerNombre	varchar(30)

	DECLARE @CantidadHr int = 0
	DECLARE @CantidadRegistros int = 0

	IF (@PaisID = 3 OR @PaisID = 4 OR @PaisID = 6)
	BEGIN
		SELECT TOP 1
			@Cantidad = 1,
			@CodigoUsuario = U.CodigoUsuario,
			@Nombre = STUFF (lower(U.Nombre), 1, 1, UPPER(left(lower(U.Nombre), 1))),
			@Correo = U.EMail,
			@ClaveSecreta = U.ClaveSecreta,
			@TipoUsuario = ISNULL(u.TipoUsuario,0),
			@RolID = ISNULL(ur.RolID,0),
			@Celular = ISNULL(U.Celular,''),
			@PrimerNombre = substring(ISNULL(co.PrimerNombre, ''),1,1) + lower(substring(ISNULL(co.PrimerNombre, ''),2, Len(co.PrimerNombre)))
		FROM dbo.Usuario U WITH(NOLOCK)
		INNER JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario AND u.Activo = 1
		LEFT JOIN ods.Consultora co WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE U.DOCUMENTOIDENTIDAD = @CodigoEntrante
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
			@RolID = ISNULL(ur.RolID,0),
			@Celular = ISNULL(U.Celular,''),
			@PrimerNombre = substring(ISNULL(co.PrimerNombre, ''),1,1) + lower(substring(ISNULL(co.PrimerNombre, ''),2, Len(co.PrimerNombre)))
		FROM dbo.Usuario U WITH(NOLOCK)
		INNER JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario AND u.Activo = 1
		LEFT JOIN ods.Consultora co WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE U.CODIGOCONSULTORA = @CodigoEntrante OR U.DOCUMENTOIDENTIDAD = @CodigoEntrante
		ORDER BY U.EMailActivo DESC
	END

	SELECT
		ISNULL(@Cantidad,0) AS Cantidad,
		ISNULL(@CodigoEntrante, '') AS CodigoEntrante, 
		ISNULL(@CodigoUsuario, '') AS CodigoUsuario,
		(SELECT CodigoISO FROM dbo.Pais (NOLOCK) WHERE PaisID = @PaisID) AS CodigoISO,
		ISNULL((SELECT TOP(1) Descripcion FROM dbo.FormularioDato (NOLOCK) WHERE TipoFormularioID = 1103 and PaisID = @PaisID), '') AS Descripcion,
		ISNULL(@Nombre, '') AS NombreCompleto,
		@PrimerNombre AS PrimerNombre,
		ISNULL(@Correo, '') AS Correo,
		--@Celular as Celular,
		--'' AS Correo,
		'' AS Celular,
		@ClaveSecreta AS ClaveSecreta,
		@TipoUsuario AS TipoUsuario,
		@RolID AS RolID,
		3 as Telefono_Cantidad,
		'955898074|955898074|955898074' as Telefono_Central,
		'' as Telefono_Capital,
		'' as Telefono_Provincias

	SET NOCOUNT OFF
END
GO

USE BelcorpSalvador
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'ValidarValorRestauracionClave')
BEGIN
	DROP PROC [dbo].[ValidarValorRestauracionClave]
END
GO
-- [dbo].[ValidarValorRestauracionClave] '041541709', 11
CREATE PROCEDURE [dbo].[ValidarValorRestauracionClave] 
	@CodigoEntrante	VARCHAR(50),
	@PaisID	INT
AS
BEGIN	
	SET NOCOUNT ON

	DECLARE @CodigoUsuario varchar(20)
	DECLARE @Nombre			varchar(80)
	DECLARE @Cantidad		int
	DECLARE @Correo			varchar(80)
	DECLARE @ClaveSecreta   varchar(200)
	DECLARE @TipoUsuario	TINYINT
	DECLARE @RolID			INT
	DECLARE @Celular		varchar(20)
	DECLARE @PrimerNombre	varchar(30)

	DECLARE @CantidadHr int = 0
	DECLARE @CantidadRegistros int = 0

	IF (@PaisID = 3 OR @PaisID = 4 OR @PaisID = 6)
	BEGIN
		SELECT TOP 1
			@Cantidad = 1,
			@CodigoUsuario = U.CodigoUsuario,
			@Nombre = STUFF (lower(U.Nombre), 1, 1, UPPER(left(lower(U.Nombre), 1))),
			@Correo = U.EMail,
			@ClaveSecreta = U.ClaveSecreta,
			@TipoUsuario = ISNULL(u.TipoUsuario,0),
			@RolID = ISNULL(ur.RolID,0),
			@Celular = ISNULL(U.Celular,''),
			@PrimerNombre = substring(ISNULL(co.PrimerNombre, ''),1,1) + lower(substring(ISNULL(co.PrimerNombre, ''),2, Len(co.PrimerNombre)))
		FROM dbo.Usuario U WITH(NOLOCK)
		INNER JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario AND u.Activo = 1
		LEFT JOIN ods.Consultora co WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE U.DOCUMENTOIDENTIDAD = @CodigoEntrante
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
			@RolID = ISNULL(ur.RolID,0),
			@Celular = ISNULL(U.Celular,''),
			@PrimerNombre = substring(ISNULL(co.PrimerNombre, ''),1,1) + lower(substring(ISNULL(co.PrimerNombre, ''),2, Len(co.PrimerNombre)))
		FROM dbo.Usuario U WITH(NOLOCK)
		INNER JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario AND u.Activo = 1
		LEFT JOIN ods.Consultora co WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE U.CODIGOCONSULTORA = @CodigoEntrante OR U.DOCUMENTOIDENTIDAD = @CodigoEntrante
		ORDER BY U.EMailActivo DESC
	END

	SELECT
		ISNULL(@Cantidad,0) AS Cantidad,
		ISNULL(@CodigoEntrante, '') AS CodigoEntrante, 
		ISNULL(@CodigoUsuario, '') AS CodigoUsuario,
		(SELECT CodigoISO FROM dbo.Pais (NOLOCK) WHERE PaisID = @PaisID) AS CodigoISO,
		ISNULL((SELECT TOP(1) Descripcion FROM dbo.FormularioDato (NOLOCK) WHERE TipoFormularioID = 1103 and PaisID = @PaisID), '') AS Descripcion,
		ISNULL(@Nombre, '') AS NombreCompleto,
		@PrimerNombre AS PrimerNombre,
		ISNULL(@Correo, '') AS Correo,
		--@Celular as Celular,
		--'' AS Correo,
		'' AS Celular,
		@ClaveSecreta AS ClaveSecreta,
		@TipoUsuario AS TipoUsuario,
		@RolID AS RolID,
		3 as Telefono_Cantidad,
		'955898074|955898074|955898074' as Telefono_Central,
		'' as Telefono_Capital,
		'' as Telefono_Provincias

	SET NOCOUNT OFF
END
GO

USE BelcorpPuertoRico
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'ValidarValorRestauracionClave')
BEGIN
	DROP PROC [dbo].[ValidarValorRestauracionClave]
END
GO
-- [dbo].[ValidarValorRestauracionClave] '041541709', 11
CREATE PROCEDURE [dbo].[ValidarValorRestauracionClave] 
	@CodigoEntrante	VARCHAR(50),
	@PaisID	INT
AS
BEGIN	
	SET NOCOUNT ON

	DECLARE @CodigoUsuario varchar(20)
	DECLARE @Nombre			varchar(80)
	DECLARE @Cantidad		int
	DECLARE @Correo			varchar(80)
	DECLARE @ClaveSecreta   varchar(200)
	DECLARE @TipoUsuario	TINYINT
	DECLARE @RolID			INT
	DECLARE @Celular		varchar(20)
	DECLARE @PrimerNombre	varchar(30)

	DECLARE @CantidadHr int = 0
	DECLARE @CantidadRegistros int = 0

	IF (@PaisID = 3 OR @PaisID = 4 OR @PaisID = 6)
	BEGIN
		SELECT TOP 1
			@Cantidad = 1,
			@CodigoUsuario = U.CodigoUsuario,
			@Nombre = STUFF (lower(U.Nombre), 1, 1, UPPER(left(lower(U.Nombre), 1))),
			@Correo = U.EMail,
			@ClaveSecreta = U.ClaveSecreta,
			@TipoUsuario = ISNULL(u.TipoUsuario,0),
			@RolID = ISNULL(ur.RolID,0),
			@Celular = ISNULL(U.Celular,''),
			@PrimerNombre = substring(ISNULL(co.PrimerNombre, ''),1,1) + lower(substring(ISNULL(co.PrimerNombre, ''),2, Len(co.PrimerNombre)))
		FROM dbo.Usuario U WITH(NOLOCK)
		INNER JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario AND u.Activo = 1
		LEFT JOIN ods.Consultora co WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE U.DOCUMENTOIDENTIDAD = @CodigoEntrante
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
			@RolID = ISNULL(ur.RolID,0),
			@Celular = ISNULL(U.Celular,''),
			@PrimerNombre = substring(ISNULL(co.PrimerNombre, ''),1,1) + lower(substring(ISNULL(co.PrimerNombre, ''),2, Len(co.PrimerNombre)))
		FROM dbo.Usuario U WITH(NOLOCK)
		INNER JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario AND u.Activo = 1
		LEFT JOIN ods.Consultora co WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE U.CODIGOCONSULTORA = @CodigoEntrante OR U.DOCUMENTOIDENTIDAD = @CodigoEntrante
		ORDER BY U.EMailActivo DESC
	END

	SELECT
		ISNULL(@Cantidad,0) AS Cantidad,
		ISNULL(@CodigoEntrante, '') AS CodigoEntrante, 
		ISNULL(@CodigoUsuario, '') AS CodigoUsuario,
		(SELECT CodigoISO FROM dbo.Pais (NOLOCK) WHERE PaisID = @PaisID) AS CodigoISO,
		ISNULL((SELECT TOP(1) Descripcion FROM dbo.FormularioDato (NOLOCK) WHERE TipoFormularioID = 1103 and PaisID = @PaisID), '') AS Descripcion,
		ISNULL(@Nombre, '') AS NombreCompleto,
		@PrimerNombre AS PrimerNombre,
		ISNULL(@Correo, '') AS Correo,
		--@Celular as Celular,
		--'' AS Correo,
		'' AS Celular,
		@ClaveSecreta AS ClaveSecreta,
		@TipoUsuario AS TipoUsuario,
		@RolID AS RolID,
		3 as Telefono_Cantidad,
		'955898074|955898074|955898074' as Telefono_Central,
		'' as Telefono_Capital,
		'' as Telefono_Provincias

	SET NOCOUNT OFF
END
GO

USE BelcorpPanama
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'ValidarValorRestauracionClave')
BEGIN
	DROP PROC [dbo].[ValidarValorRestauracionClave]
END
GO
-- [dbo].[ValidarValorRestauracionClave] '041541709', 11
CREATE PROCEDURE [dbo].[ValidarValorRestauracionClave] 
	@CodigoEntrante	VARCHAR(50),
	@PaisID	INT
AS
BEGIN	
	SET NOCOUNT ON

	DECLARE @CodigoUsuario varchar(20)
	DECLARE @Nombre			varchar(80)
	DECLARE @Cantidad		int
	DECLARE @Correo			varchar(80)
	DECLARE @ClaveSecreta   varchar(200)
	DECLARE @TipoUsuario	TINYINT
	DECLARE @RolID			INT
	DECLARE @Celular		varchar(20)
	DECLARE @PrimerNombre	varchar(30)

	DECLARE @CantidadHr int = 0
	DECLARE @CantidadRegistros int = 0

	IF (@PaisID = 3 OR @PaisID = 4 OR @PaisID = 6)
	BEGIN
		SELECT TOP 1
			@Cantidad = 1,
			@CodigoUsuario = U.CodigoUsuario,
			@Nombre = STUFF (lower(U.Nombre), 1, 1, UPPER(left(lower(U.Nombre), 1))),
			@Correo = U.EMail,
			@ClaveSecreta = U.ClaveSecreta,
			@TipoUsuario = ISNULL(u.TipoUsuario,0),
			@RolID = ISNULL(ur.RolID,0),
			@Celular = ISNULL(U.Celular,''),
			@PrimerNombre = substring(ISNULL(co.PrimerNombre, ''),1,1) + lower(substring(ISNULL(co.PrimerNombre, ''),2, Len(co.PrimerNombre)))
		FROM dbo.Usuario U WITH(NOLOCK)
		INNER JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario AND u.Activo = 1
		LEFT JOIN ods.Consultora co WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE U.DOCUMENTOIDENTIDAD = @CodigoEntrante
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
			@RolID = ISNULL(ur.RolID,0),
			@Celular = ISNULL(U.Celular,''),
			@PrimerNombre = substring(ISNULL(co.PrimerNombre, ''),1,1) + lower(substring(ISNULL(co.PrimerNombre, ''),2, Len(co.PrimerNombre)))
		FROM dbo.Usuario U WITH(NOLOCK)
		INNER JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario AND u.Activo = 1
		LEFT JOIN ods.Consultora co WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE U.CODIGOCONSULTORA = @CodigoEntrante OR U.DOCUMENTOIDENTIDAD = @CodigoEntrante
		ORDER BY U.EMailActivo DESC
	END

	SELECT
		ISNULL(@Cantidad,0) AS Cantidad,
		ISNULL(@CodigoEntrante, '') AS CodigoEntrante, 
		ISNULL(@CodigoUsuario, '') AS CodigoUsuario,
		(SELECT CodigoISO FROM dbo.Pais (NOLOCK) WHERE PaisID = @PaisID) AS CodigoISO,
		ISNULL((SELECT TOP(1) Descripcion FROM dbo.FormularioDato (NOLOCK) WHERE TipoFormularioID = 1103 and PaisID = @PaisID), '') AS Descripcion,
		ISNULL(@Nombre, '') AS NombreCompleto,
		@PrimerNombre AS PrimerNombre,
		ISNULL(@Correo, '') AS Correo,
		--@Celular as Celular,
		--'' AS Correo,
		'' AS Celular,
		@ClaveSecreta AS ClaveSecreta,
		@TipoUsuario AS TipoUsuario,
		@RolID AS RolID,
		3 as Telefono_Cantidad,
		'955898074|955898074|955898074' as Telefono_Central,
		'' as Telefono_Capital,
		'' as Telefono_Provincias

	SET NOCOUNT OFF
END
GO

USE BelcorpGuatemala
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'ValidarValorRestauracionClave')
BEGIN
	DROP PROC [dbo].[ValidarValorRestauracionClave]
END
GO
-- [dbo].[ValidarValorRestauracionClave] '041541709', 11
CREATE PROCEDURE [dbo].[ValidarValorRestauracionClave] 
	@CodigoEntrante	VARCHAR(50),
	@PaisID	INT
AS
BEGIN	
	SET NOCOUNT ON

	DECLARE @CodigoUsuario varchar(20)
	DECLARE @Nombre			varchar(80)
	DECLARE @Cantidad		int
	DECLARE @Correo			varchar(80)
	DECLARE @ClaveSecreta   varchar(200)
	DECLARE @TipoUsuario	TINYINT
	DECLARE @RolID			INT
	DECLARE @Celular		varchar(20)
	DECLARE @PrimerNombre	varchar(30)

	DECLARE @CantidadHr int = 0
	DECLARE @CantidadRegistros int = 0

	IF (@PaisID = 3 OR @PaisID = 4 OR @PaisID = 6)
	BEGIN
		SELECT TOP 1
			@Cantidad = 1,
			@CodigoUsuario = U.CodigoUsuario,
			@Nombre = STUFF (lower(U.Nombre), 1, 1, UPPER(left(lower(U.Nombre), 1))),
			@Correo = U.EMail,
			@ClaveSecreta = U.ClaveSecreta,
			@TipoUsuario = ISNULL(u.TipoUsuario,0),
			@RolID = ISNULL(ur.RolID,0),
			@Celular = ISNULL(U.Celular,''),
			@PrimerNombre = substring(ISNULL(co.PrimerNombre, ''),1,1) + lower(substring(ISNULL(co.PrimerNombre, ''),2, Len(co.PrimerNombre)))
		FROM dbo.Usuario U WITH(NOLOCK)
		INNER JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario AND u.Activo = 1
		LEFT JOIN ods.Consultora co WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE U.DOCUMENTOIDENTIDAD = @CodigoEntrante
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
			@RolID = ISNULL(ur.RolID,0),
			@Celular = ISNULL(U.Celular,''),
			@PrimerNombre = substring(ISNULL(co.PrimerNombre, ''),1,1) + lower(substring(ISNULL(co.PrimerNombre, ''),2, Len(co.PrimerNombre)))
		FROM dbo.Usuario U WITH(NOLOCK)
		INNER JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario AND u.Activo = 1
		LEFT JOIN ods.Consultora co WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE U.CODIGOCONSULTORA = @CodigoEntrante OR U.DOCUMENTOIDENTIDAD = @CodigoEntrante
		ORDER BY U.EMailActivo DESC
	END

	SELECT
		ISNULL(@Cantidad,0) AS Cantidad,
		ISNULL(@CodigoEntrante, '') AS CodigoEntrante, 
		ISNULL(@CodigoUsuario, '') AS CodigoUsuario,
		(SELECT CodigoISO FROM dbo.Pais (NOLOCK) WHERE PaisID = @PaisID) AS CodigoISO,
		ISNULL((SELECT TOP(1) Descripcion FROM dbo.FormularioDato (NOLOCK) WHERE TipoFormularioID = 1103 and PaisID = @PaisID), '') AS Descripcion,
		ISNULL(@Nombre, '') AS NombreCompleto,
		@PrimerNombre AS PrimerNombre,
		ISNULL(@Correo, '') AS Correo,
		--@Celular as Celular,
		--'' AS Correo,
		'' AS Celular,
		@ClaveSecreta AS ClaveSecreta,
		@TipoUsuario AS TipoUsuario,
		@RolID AS RolID,
		3 as Telefono_Cantidad,
		'955898074|955898074|955898074' as Telefono_Central,
		'' as Telefono_Capital,
		'' as Telefono_Provincias

	SET NOCOUNT OFF
END
GO

USE BelcorpEcuador
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'ValidarValorRestauracionClave')
BEGIN
	DROP PROC [dbo].[ValidarValorRestauracionClave]
END
GO
-- [dbo].[ValidarValorRestauracionClave] '041541709', 11
CREATE PROCEDURE [dbo].[ValidarValorRestauracionClave] 
	@CodigoEntrante	VARCHAR(50),
	@PaisID	INT
AS
BEGIN	
	SET NOCOUNT ON

	DECLARE @CodigoUsuario varchar(20)
	DECLARE @Nombre			varchar(80)
	DECLARE @Cantidad		int
	DECLARE @Correo			varchar(80)
	DECLARE @ClaveSecreta   varchar(200)
	DECLARE @TipoUsuario	TINYINT
	DECLARE @RolID			INT
	DECLARE @Celular		varchar(20)
	DECLARE @PrimerNombre	varchar(30)

	DECLARE @CantidadHr int = 0
	DECLARE @CantidadRegistros int = 0

	IF (@PaisID = 3 OR @PaisID = 4 OR @PaisID = 6)
	BEGIN
		SELECT TOP 1
			@Cantidad = 1,
			@CodigoUsuario = U.CodigoUsuario,
			@Nombre = STUFF (lower(U.Nombre), 1, 1, UPPER(left(lower(U.Nombre), 1))),
			@Correo = U.EMail,
			@ClaveSecreta = U.ClaveSecreta,
			@TipoUsuario = ISNULL(u.TipoUsuario,0),
			@RolID = ISNULL(ur.RolID,0),
			@Celular = ISNULL(U.Celular,''),
			@PrimerNombre = substring(ISNULL(co.PrimerNombre, ''),1,1) + lower(substring(ISNULL(co.PrimerNombre, ''),2, Len(co.PrimerNombre)))
		FROM dbo.Usuario U WITH(NOLOCK)
		INNER JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario AND u.Activo = 1
		LEFT JOIN ods.Consultora co WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE U.DOCUMENTOIDENTIDAD = @CodigoEntrante
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
			@RolID = ISNULL(ur.RolID,0),
			@Celular = ISNULL(U.Celular,''),
			@PrimerNombre = substring(ISNULL(co.PrimerNombre, ''),1,1) + lower(substring(ISNULL(co.PrimerNombre, ''),2, Len(co.PrimerNombre)))
		FROM dbo.Usuario U WITH(NOLOCK)
		INNER JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario AND u.Activo = 1
		LEFT JOIN ods.Consultora co WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE U.CODIGOCONSULTORA = @CodigoEntrante OR U.DOCUMENTOIDENTIDAD = @CodigoEntrante
		ORDER BY U.EMailActivo DESC
	END

	SELECT
		ISNULL(@Cantidad,0) AS Cantidad,
		ISNULL(@CodigoEntrante, '') AS CodigoEntrante, 
		ISNULL(@CodigoUsuario, '') AS CodigoUsuario,
		(SELECT CodigoISO FROM dbo.Pais (NOLOCK) WHERE PaisID = @PaisID) AS CodigoISO,
		ISNULL((SELECT TOP(1) Descripcion FROM dbo.FormularioDato (NOLOCK) WHERE TipoFormularioID = 1103 and PaisID = @PaisID), '') AS Descripcion,
		ISNULL(@Nombre, '') AS NombreCompleto,
		@PrimerNombre AS PrimerNombre,
		ISNULL(@Correo, '') AS Correo,
		--@Celular as Celular,
		--'' AS Correo,
		'' AS Celular,
		@ClaveSecreta AS ClaveSecreta,
		@TipoUsuario AS TipoUsuario,
		@RolID AS RolID,
		3 as Telefono_Cantidad,
		'955898074|955898074|955898074' as Telefono_Central,
		'' as Telefono_Capital,
		'' as Telefono_Provincias

	SET NOCOUNT OFF
END
GO

USE BelcorpDominicana
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'ValidarValorRestauracionClave')
BEGIN
	DROP PROC [dbo].[ValidarValorRestauracionClave]
END
GO
-- [dbo].[ValidarValorRestauracionClave] '041541709', 11
CREATE PROCEDURE [dbo].[ValidarValorRestauracionClave] 
	@CodigoEntrante	VARCHAR(50),
	@PaisID	INT
AS
BEGIN	
	SET NOCOUNT ON

	DECLARE @CodigoUsuario varchar(20)
	DECLARE @Nombre			varchar(80)
	DECLARE @Cantidad		int
	DECLARE @Correo			varchar(80)
	DECLARE @ClaveSecreta   varchar(200)
	DECLARE @TipoUsuario	TINYINT
	DECLARE @RolID			INT
	DECLARE @Celular		varchar(20)
	DECLARE @PrimerNombre	varchar(30)

	DECLARE @CantidadHr int = 0
	DECLARE @CantidadRegistros int = 0

	IF (@PaisID = 3 OR @PaisID = 4 OR @PaisID = 6)
	BEGIN
		SELECT TOP 1
			@Cantidad = 1,
			@CodigoUsuario = U.CodigoUsuario,
			@Nombre = STUFF (lower(U.Nombre), 1, 1, UPPER(left(lower(U.Nombre), 1))),
			@Correo = U.EMail,
			@ClaveSecreta = U.ClaveSecreta,
			@TipoUsuario = ISNULL(u.TipoUsuario,0),
			@RolID = ISNULL(ur.RolID,0),
			@Celular = ISNULL(U.Celular,''),
			@PrimerNombre = substring(ISNULL(co.PrimerNombre, ''),1,1) + lower(substring(ISNULL(co.PrimerNombre, ''),2, Len(co.PrimerNombre)))
		FROM dbo.Usuario U WITH(NOLOCK)
		INNER JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario AND u.Activo = 1
		LEFT JOIN ods.Consultora co WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE U.DOCUMENTOIDENTIDAD = @CodigoEntrante
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
			@RolID = ISNULL(ur.RolID,0),
			@Celular = ISNULL(U.Celular,''),
			@PrimerNombre = substring(ISNULL(co.PrimerNombre, ''),1,1) + lower(substring(ISNULL(co.PrimerNombre, ''),2, Len(co.PrimerNombre)))
		FROM dbo.Usuario U WITH(NOLOCK)
		INNER JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario AND u.Activo = 1
		LEFT JOIN ods.Consultora co WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE U.CODIGOCONSULTORA = @CodigoEntrante OR U.DOCUMENTOIDENTIDAD = @CodigoEntrante
		ORDER BY U.EMailActivo DESC
	END

	SELECT
		ISNULL(@Cantidad,0) AS Cantidad,
		ISNULL(@CodigoEntrante, '') AS CodigoEntrante, 
		ISNULL(@CodigoUsuario, '') AS CodigoUsuario,
		(SELECT CodigoISO FROM dbo.Pais (NOLOCK) WHERE PaisID = @PaisID) AS CodigoISO,
		ISNULL((SELECT TOP(1) Descripcion FROM dbo.FormularioDato (NOLOCK) WHERE TipoFormularioID = 1103 and PaisID = @PaisID), '') AS Descripcion,
		ISNULL(@Nombre, '') AS NombreCompleto,
		@PrimerNombre AS PrimerNombre,
		ISNULL(@Correo, '') AS Correo,
		--@Celular as Celular,
		--'' AS Correo,
		'' AS Celular,
		@ClaveSecreta AS ClaveSecreta,
		@TipoUsuario AS TipoUsuario,
		@RolID AS RolID,
		3 as Telefono_Cantidad,
		'955898074|955898074|955898074' as Telefono_Central,
		'' as Telefono_Capital,
		'' as Telefono_Provincias

	SET NOCOUNT OFF
END
GO

USE BelcorpCostaRica
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'ValidarValorRestauracionClave')
BEGIN
	DROP PROC [dbo].[ValidarValorRestauracionClave]
END
GO
-- [dbo].[ValidarValorRestauracionClave] '041541709', 11
CREATE PROCEDURE [dbo].[ValidarValorRestauracionClave] 
	@CodigoEntrante	VARCHAR(50),
	@PaisID	INT
AS
BEGIN	
	SET NOCOUNT ON

	DECLARE @CodigoUsuario varchar(20)
	DECLARE @Nombre			varchar(80)
	DECLARE @Cantidad		int
	DECLARE @Correo			varchar(80)
	DECLARE @ClaveSecreta   varchar(200)
	DECLARE @TipoUsuario	TINYINT
	DECLARE @RolID			INT
	DECLARE @Celular		varchar(20)
	DECLARE @PrimerNombre	varchar(30)

	DECLARE @CantidadHr int = 0
	DECLARE @CantidadRegistros int = 0

	IF (@PaisID = 3 OR @PaisID = 4 OR @PaisID = 6)
	BEGIN
		SELECT TOP 1
			@Cantidad = 1,
			@CodigoUsuario = U.CodigoUsuario,
			@Nombre = STUFF (lower(U.Nombre), 1, 1, UPPER(left(lower(U.Nombre), 1))),
			@Correo = U.EMail,
			@ClaveSecreta = U.ClaveSecreta,
			@TipoUsuario = ISNULL(u.TipoUsuario,0),
			@RolID = ISNULL(ur.RolID,0),
			@Celular = ISNULL(U.Celular,''),
			@PrimerNombre = substring(ISNULL(co.PrimerNombre, ''),1,1) + lower(substring(ISNULL(co.PrimerNombre, ''),2, Len(co.PrimerNombre)))
		FROM dbo.Usuario U WITH(NOLOCK)
		INNER JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario AND u.Activo = 1
		LEFT JOIN ods.Consultora co WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE U.DOCUMENTOIDENTIDAD = @CodigoEntrante
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
			@RolID = ISNULL(ur.RolID,0),
			@Celular = ISNULL(U.Celular,''),
			@PrimerNombre = substring(ISNULL(co.PrimerNombre, ''),1,1) + lower(substring(ISNULL(co.PrimerNombre, ''),2, Len(co.PrimerNombre)))
		FROM dbo.Usuario U WITH(NOLOCK)
		INNER JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario AND u.Activo = 1
		LEFT JOIN ods.Consultora co WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE U.CODIGOCONSULTORA = @CodigoEntrante OR U.DOCUMENTOIDENTIDAD = @CodigoEntrante
		ORDER BY U.EMailActivo DESC
	END

	SELECT
		ISNULL(@Cantidad,0) AS Cantidad,
		ISNULL(@CodigoEntrante, '') AS CodigoEntrante, 
		ISNULL(@CodigoUsuario, '') AS CodigoUsuario,
		(SELECT CodigoISO FROM dbo.Pais (NOLOCK) WHERE PaisID = @PaisID) AS CodigoISO,
		ISNULL((SELECT TOP(1) Descripcion FROM dbo.FormularioDato (NOLOCK) WHERE TipoFormularioID = 1103 and PaisID = @PaisID), '') AS Descripcion,
		ISNULL(@Nombre, '') AS NombreCompleto,
		@PrimerNombre AS PrimerNombre,
		ISNULL(@Correo, '') AS Correo,
		--@Celular as Celular,
		--'' AS Correo,
		'' AS Celular,
		@ClaveSecreta AS ClaveSecreta,
		@TipoUsuario AS TipoUsuario,
		@RolID AS RolID,
		3 as Telefono_Cantidad,
		'955898074|955898074|955898074' as Telefono_Central,
		'' as Telefono_Capital,
		'' as Telefono_Provincias

	SET NOCOUNT OFF
END
GO

USE BelcorpChile
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'ValidarValorRestauracionClave')
BEGIN
	DROP PROC [dbo].[ValidarValorRestauracionClave]
END
GO
-- [dbo].[ValidarValorRestauracionClave] '041541709', 11
CREATE PROCEDURE [dbo].[ValidarValorRestauracionClave] 
	@CodigoEntrante	VARCHAR(50),
	@PaisID	INT
AS
BEGIN	
	SET NOCOUNT ON

	DECLARE @CodigoUsuario varchar(20)
	DECLARE @Nombre			varchar(80)
	DECLARE @Cantidad		int
	DECLARE @Correo			varchar(80)
	DECLARE @ClaveSecreta   varchar(200)
	DECLARE @TipoUsuario	TINYINT
	DECLARE @RolID			INT
	DECLARE @Celular		varchar(20)
	DECLARE @PrimerNombre	varchar(30)

	DECLARE @CantidadHr int = 0
	DECLARE @CantidadRegistros int = 0

	IF (@PaisID = 3 OR @PaisID = 4 OR @PaisID = 6)
	BEGIN
		SELECT TOP 1
			@Cantidad = 1,
			@CodigoUsuario = U.CodigoUsuario,
			@Nombre = STUFF (lower(U.Nombre), 1, 1, UPPER(left(lower(U.Nombre), 1))),
			@Correo = U.EMail,
			@ClaveSecreta = U.ClaveSecreta,
			@TipoUsuario = ISNULL(u.TipoUsuario,0),
			@RolID = ISNULL(ur.RolID,0),
			@Celular = ISNULL(U.Celular,''),
			@PrimerNombre = substring(ISNULL(co.PrimerNombre, ''),1,1) + lower(substring(ISNULL(co.PrimerNombre, ''),2, Len(co.PrimerNombre)))
		FROM dbo.Usuario U WITH(NOLOCK)
		INNER JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario AND u.Activo = 1
		LEFT JOIN ods.Consultora co WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE U.DOCUMENTOIDENTIDAD = @CodigoEntrante
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
			@RolID = ISNULL(ur.RolID,0),
			@Celular = ISNULL(U.Celular,''),
			@PrimerNombre = substring(ISNULL(co.PrimerNombre, ''),1,1) + lower(substring(ISNULL(co.PrimerNombre, ''),2, Len(co.PrimerNombre)))
		FROM dbo.Usuario U WITH(NOLOCK)
		INNER JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario AND u.Activo = 1
		LEFT JOIN ods.Consultora co WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE U.CODIGOCONSULTORA = @CodigoEntrante OR U.DOCUMENTOIDENTIDAD = @CodigoEntrante
		ORDER BY U.EMailActivo DESC
	END

	SELECT
		ISNULL(@Cantidad,0) AS Cantidad,
		ISNULL(@CodigoEntrante, '') AS CodigoEntrante, 
		ISNULL(@CodigoUsuario, '') AS CodigoUsuario,
		(SELECT CodigoISO FROM dbo.Pais (NOLOCK) WHERE PaisID = @PaisID) AS CodigoISO,
		ISNULL((SELECT TOP(1) Descripcion FROM dbo.FormularioDato (NOLOCK) WHERE TipoFormularioID = 1103 and PaisID = @PaisID), '') AS Descripcion,
		ISNULL(@Nombre, '') AS NombreCompleto,
		@PrimerNombre AS PrimerNombre,
		ISNULL(@Correo, '') AS Correo,
		--@Celular as Celular,
		--'' AS Correo,
		'' AS Celular,
		@ClaveSecreta AS ClaveSecreta,
		@TipoUsuario AS TipoUsuario,
		@RolID AS RolID,
		3 as Telefono_Cantidad,
		'955898074|955898074|955898074' as Telefono_Central,
		'' as Telefono_Capital,
		'' as Telefono_Provincias

	SET NOCOUNT OFF
END
GO

USE BelcorpBolivia
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'ValidarValorRestauracionClave')
BEGIN
	DROP PROC [dbo].[ValidarValorRestauracionClave]
END
GO
-- [dbo].[ValidarValorRestauracionClave] '041541709', 11
CREATE PROCEDURE [dbo].[ValidarValorRestauracionClave] 
	@CodigoEntrante	VARCHAR(50),
	@PaisID	INT
AS
BEGIN	
	SET NOCOUNT ON

	DECLARE @CodigoUsuario varchar(20)
	DECLARE @Nombre			varchar(80)
	DECLARE @Cantidad		int
	DECLARE @Correo			varchar(80)
	DECLARE @ClaveSecreta   varchar(200)
	DECLARE @TipoUsuario	TINYINT
	DECLARE @RolID			INT
	DECLARE @Celular		varchar(20)
	DECLARE @PrimerNombre	varchar(30)

	DECLARE @CantidadHr int = 0
	DECLARE @CantidadRegistros int = 0

	IF (@PaisID = 3 OR @PaisID = 4 OR @PaisID = 6)
	BEGIN
		SELECT TOP 1
			@Cantidad = 1,
			@CodigoUsuario = U.CodigoUsuario,
			@Nombre = STUFF (lower(U.Nombre), 1, 1, UPPER(left(lower(U.Nombre), 1))),
			@Correo = U.EMail,
			@ClaveSecreta = U.ClaveSecreta,
			@TipoUsuario = ISNULL(u.TipoUsuario,0),
			@RolID = ISNULL(ur.RolID,0),
			@Celular = ISNULL(U.Celular,''),
			@PrimerNombre = substring(ISNULL(co.PrimerNombre, ''),1,1) + lower(substring(ISNULL(co.PrimerNombre, ''),2, Len(co.PrimerNombre)))
		FROM dbo.Usuario U WITH(NOLOCK)
		INNER JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario AND u.Activo = 1
		LEFT JOIN ods.Consultora co WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE U.DOCUMENTOIDENTIDAD = @CodigoEntrante
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
			@RolID = ISNULL(ur.RolID,0),
			@Celular = ISNULL(U.Celular,''),
			@PrimerNombre = substring(ISNULL(co.PrimerNombre, ''),1,1) + lower(substring(ISNULL(co.PrimerNombre, ''),2, Len(co.PrimerNombre)))
		FROM dbo.Usuario U WITH(NOLOCK)
		INNER JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario AND u.Activo = 1
		LEFT JOIN ods.Consultora co WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE U.CODIGOCONSULTORA = @CodigoEntrante OR U.DOCUMENTOIDENTIDAD = @CodigoEntrante
		ORDER BY U.EMailActivo DESC
	END

	SELECT
		ISNULL(@Cantidad,0) AS Cantidad,
		ISNULL(@CodigoEntrante, '') AS CodigoEntrante, 
		ISNULL(@CodigoUsuario, '') AS CodigoUsuario,
		(SELECT CodigoISO FROM dbo.Pais (NOLOCK) WHERE PaisID = @PaisID) AS CodigoISO,
		ISNULL((SELECT TOP(1) Descripcion FROM dbo.FormularioDato (NOLOCK) WHERE TipoFormularioID = 1103 and PaisID = @PaisID), '') AS Descripcion,
		ISNULL(@Nombre, '') AS NombreCompleto,
		@PrimerNombre AS PrimerNombre,
		ISNULL(@Correo, '') AS Correo,
		--@Celular as Celular,
		--'' AS Correo,
		'' AS Celular,
		@ClaveSecreta AS ClaveSecreta,
		@TipoUsuario AS TipoUsuario,
		@RolID AS RolID,
		3 as Telefono_Cantidad,
		'955898074|955898074|955898074' as Telefono_Central,
		'' as Telefono_Capital,
		'' as Telefono_Provincias

	SET NOCOUNT OFF
END
GO

