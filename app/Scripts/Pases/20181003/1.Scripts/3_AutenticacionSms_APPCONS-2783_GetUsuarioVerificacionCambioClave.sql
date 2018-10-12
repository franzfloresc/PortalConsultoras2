USE BelcorpPeru
GO

/* GetUsuarioVerificacionCambioClave */
IF (OBJECT_ID('GetUsuarioVerificacionCambioClave') IS NOT NULL)
  DROP PROCEDURE [dbo].[GetUsuarioVerificacionCambioClave]
GO

CREATE PROCEDURE [dbo].[GetUsuarioVerificacionCambioClave]
	@CodigoUsuario VARCHAR(20)
AS
BEGIN	
	SET NOCOUNT ON
	
	DECLARE @Cantidad int = 0
	DECLARE @PrimerNombre varchar(30)
	DECLARE @IdEstadoActividad int
	DECLARE @Celular varchar(20)
	DECLARE @Correo	varchar(80)
	DECLARE @RegionID int	
	DECLARE @ZonaID int
	DECLARE @CambioClave int = -1

	SELECT TOP 1 @CodigoUsuario = U.CODIGOUSUARIO
	FROM dbo.Usuario U WITH(NOLOCK)
		WHERE (U.CODIGOCONSULTORA = @CodigoUsuario OR U.DOCUMENTOIDENTIDAD = @CodigoUsuario OR U.CODIGOUSUARIO = @CodigoUsuario)

	IF EXISTS (SELECT 1 FROM [dbo].[MetaConsultora] M WITH(NOLOCK)	
				WHERE M.CodigoUsuario = @CodigoUsuario AND M.CodigoMeta = 'VF_CAMBIO_CLAVE' AND M.ValorMeta = '1')
	BEGIN
		SELECT TOP 1
			@PrimerNombre = substring(ISNULL(CO.PrimerNombre, ''),1,1) + lower(substring(ISNULL(CO.PrimerNombre, ''),2, Len(CO.PrimerNombre))),
			@IdEstadoActividad = IsNull(CO.IdEstadoActividad, ''),
			@Celular = IsNull(U.Celular, ''),
			@Correo = IsNull(U.EMail, ''),
			@RegionID = IsNull(RegionID,0),
			@ZonaID = IsNull(CO.ZonaID, 0),
			@CambioClave = Isnull(U.CambioClave, 0)
		FROM dbo.Usuario U WITH(NOLOCK)
		LEFT JOIN ods.Consultora co WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE (U.CODIGOCONSULTORA = @CodigoUsuario OR U.DOCUMENTOIDENTIDAD = @CodigoUsuario)
			And U.CODIGOUSUARIO = @CodigoUsuario
		ORDER BY U.EMailActivo DESC
	END

	SELECT
		@Cantidad as Cantidad,
		@PrimerNombre as PrimerNombre,
		@IdEstadoActividad as IdEstadoActividad,
		@Celular as Celular,
		@Correo as Correo,
		@RegionID as RegionID,
		@ZonaID as ZonaID,
		@CambioClave as OpcionCambioClave
	SET NOCOUNT OFF
END
GO

USE BelcorpMexico
GO

/* GetUsuarioVerificacionCambioClave */
IF (OBJECT_ID('GetUsuarioVerificacionCambioClave') IS NOT NULL)
  DROP PROCEDURE [dbo].[GetUsuarioVerificacionCambioClave]
GO

CREATE PROCEDURE [dbo].[GetUsuarioVerificacionCambioClave]
	@CodigoUsuario VARCHAR(20)
AS
BEGIN	
	SET NOCOUNT ON
	
	DECLARE @Cantidad int = 0
	DECLARE @PrimerNombre varchar(30)
	DECLARE @IdEstadoActividad int
	DECLARE @Celular varchar(20)
	DECLARE @Correo	varchar(80)
	DECLARE @RegionID int	
	DECLARE @ZonaID int
	DECLARE @CambioClave int = -1

	SELECT TOP 1 @CodigoUsuario = U.CODIGOUSUARIO
	FROM dbo.Usuario U WITH(NOLOCK)
		WHERE (U.CODIGOCONSULTORA = @CodigoUsuario OR U.DOCUMENTOIDENTIDAD = @CodigoUsuario OR U.CODIGOUSUARIO = @CodigoUsuario)

	IF EXISTS (SELECT 1 FROM [dbo].[MetaConsultora] M WITH(NOLOCK)	
				WHERE M.CodigoUsuario = @CodigoUsuario AND M.CodigoMeta = 'VF_CAMBIO_CLAVE' AND M.ValorMeta = '1')
	BEGIN
		SELECT TOP 1
			@PrimerNombre = substring(ISNULL(CO.PrimerNombre, ''),1,1) + lower(substring(ISNULL(CO.PrimerNombre, ''),2, Len(CO.PrimerNombre))),
			@IdEstadoActividad = IsNull(CO.IdEstadoActividad, ''),
			@Celular = IsNull(U.Celular, ''),
			@Correo = IsNull(U.EMail, ''),
			@RegionID = IsNull(RegionID,0),
			@ZonaID = IsNull(CO.ZonaID, 0),
			@CambioClave = Isnull(U.CambioClave, 0)
		FROM dbo.Usuario U WITH(NOLOCK)
		LEFT JOIN ods.Consultora co WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE (U.CODIGOCONSULTORA = @CodigoUsuario OR U.DOCUMENTOIDENTIDAD = @CodigoUsuario)
			And U.CODIGOUSUARIO = @CodigoUsuario
		ORDER BY U.EMailActivo DESC
	END

	SELECT
		@Cantidad as Cantidad,
		@PrimerNombre as PrimerNombre,
		@IdEstadoActividad as IdEstadoActividad,
		@Celular as Celular,
		@Correo as Correo,
		@RegionID as RegionID,
		@ZonaID as ZonaID,
		@CambioClave as OpcionCambioClave
	SET NOCOUNT OFF
END
GO

USE BelcorpColombia
GO

/* GetUsuarioVerificacionCambioClave */
IF (OBJECT_ID('GetUsuarioVerificacionCambioClave') IS NOT NULL)
  DROP PROCEDURE [dbo].[GetUsuarioVerificacionCambioClave]
GO

CREATE PROCEDURE [dbo].[GetUsuarioVerificacionCambioClave]
	@CodigoUsuario VARCHAR(20)
AS
BEGIN	
	SET NOCOUNT ON
	
	DECLARE @Cantidad int = 0
	DECLARE @PrimerNombre varchar(30)
	DECLARE @IdEstadoActividad int
	DECLARE @Celular varchar(20)
	DECLARE @Correo	varchar(80)
	DECLARE @RegionID int	
	DECLARE @ZonaID int
	DECLARE @CambioClave int = -1

	SELECT TOP 1 @CodigoUsuario = U.CODIGOUSUARIO
	FROM dbo.Usuario U WITH(NOLOCK)
		WHERE (U.CODIGOCONSULTORA = @CodigoUsuario OR U.DOCUMENTOIDENTIDAD = @CodigoUsuario OR U.CODIGOUSUARIO = @CodigoUsuario)

	IF EXISTS (SELECT 1 FROM [dbo].[MetaConsultora] M WITH(NOLOCK)	
				WHERE M.CodigoUsuario = @CodigoUsuario AND M.CodigoMeta = 'VF_CAMBIO_CLAVE' AND M.ValorMeta = '1')
	BEGIN
		SELECT TOP 1
			@PrimerNombre = substring(ISNULL(CO.PrimerNombre, ''),1,1) + lower(substring(ISNULL(CO.PrimerNombre, ''),2, Len(CO.PrimerNombre))),
			@IdEstadoActividad = IsNull(CO.IdEstadoActividad, ''),
			@Celular = IsNull(U.Celular, ''),
			@Correo = IsNull(U.EMail, ''),
			@RegionID = IsNull(RegionID,0),
			@ZonaID = IsNull(CO.ZonaID, 0),
			@CambioClave = Isnull(U.CambioClave, 0)
		FROM dbo.Usuario U WITH(NOLOCK)
		LEFT JOIN ods.Consultora co WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE (U.CODIGOCONSULTORA = @CodigoUsuario OR U.DOCUMENTOIDENTIDAD = @CodigoUsuario)
			And U.CODIGOUSUARIO = @CodigoUsuario
		ORDER BY U.EMailActivo DESC
	END

	SELECT
		@Cantidad as Cantidad,
		@PrimerNombre as PrimerNombre,
		@IdEstadoActividad as IdEstadoActividad,
		@Celular as Celular,
		@Correo as Correo,
		@RegionID as RegionID,
		@ZonaID as ZonaID,
		@CambioClave as OpcionCambioClave
	SET NOCOUNT OFF
END
GO

USE BelcorpSalvador
GO

/* GetUsuarioVerificacionCambioClave */
IF (OBJECT_ID('GetUsuarioVerificacionCambioClave') IS NOT NULL)
  DROP PROCEDURE [dbo].[GetUsuarioVerificacionCambioClave]
GO

CREATE PROCEDURE [dbo].[GetUsuarioVerificacionCambioClave]
	@CodigoUsuario VARCHAR(20)
AS
BEGIN	
	SET NOCOUNT ON
	
	DECLARE @Cantidad int = 0
	DECLARE @PrimerNombre varchar(30)
	DECLARE @IdEstadoActividad int
	DECLARE @Celular varchar(20)
	DECLARE @Correo	varchar(80)
	DECLARE @RegionID int	
	DECLARE @ZonaID int
	DECLARE @CambioClave int = -1

	SELECT TOP 1 @CodigoUsuario = U.CODIGOUSUARIO
	FROM dbo.Usuario U WITH(NOLOCK)
		WHERE (U.CODIGOCONSULTORA = @CodigoUsuario OR U.DOCUMENTOIDENTIDAD = @CodigoUsuario OR U.CODIGOUSUARIO = @CodigoUsuario)

	IF EXISTS (SELECT 1 FROM [dbo].[MetaConsultora] M WITH(NOLOCK)	
				WHERE M.CodigoUsuario = @CodigoUsuario AND M.CodigoMeta = 'VF_CAMBIO_CLAVE' AND M.ValorMeta = '1')
	BEGIN
		SELECT TOP 1
			@PrimerNombre = substring(ISNULL(CO.PrimerNombre, ''),1,1) + lower(substring(ISNULL(CO.PrimerNombre, ''),2, Len(CO.PrimerNombre))),
			@IdEstadoActividad = IsNull(CO.IdEstadoActividad, ''),
			@Celular = IsNull(U.Celular, ''),
			@Correo = IsNull(U.EMail, ''),
			@RegionID = IsNull(RegionID,0),
			@ZonaID = IsNull(CO.ZonaID, 0),
			@CambioClave = Isnull(U.CambioClave, 0)
		FROM dbo.Usuario U WITH(NOLOCK)
		LEFT JOIN ods.Consultora co WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE (U.CODIGOCONSULTORA = @CodigoUsuario OR U.DOCUMENTOIDENTIDAD = @CodigoUsuario)
			And U.CODIGOUSUARIO = @CodigoUsuario
		ORDER BY U.EMailActivo DESC
	END

	SELECT
		@Cantidad as Cantidad,
		@PrimerNombre as PrimerNombre,
		@IdEstadoActividad as IdEstadoActividad,
		@Celular as Celular,
		@Correo as Correo,
		@RegionID as RegionID,
		@ZonaID as ZonaID,
		@CambioClave as OpcionCambioClave
	SET NOCOUNT OFF
END
GO

USE BelcorpPuertoRico
GO

/* GetUsuarioVerificacionCambioClave */
IF (OBJECT_ID('GetUsuarioVerificacionCambioClave') IS NOT NULL)
  DROP PROCEDURE [dbo].[GetUsuarioVerificacionCambioClave]
GO

CREATE PROCEDURE [dbo].[GetUsuarioVerificacionCambioClave]
	@CodigoUsuario VARCHAR(20)
AS
BEGIN	
	SET NOCOUNT ON
	
	DECLARE @Cantidad int = 0
	DECLARE @PrimerNombre varchar(30)
	DECLARE @IdEstadoActividad int
	DECLARE @Celular varchar(20)
	DECLARE @Correo	varchar(80)
	DECLARE @RegionID int	
	DECLARE @ZonaID int
	DECLARE @CambioClave int = -1

	SELECT TOP 1 @CodigoUsuario = U.CODIGOUSUARIO
	FROM dbo.Usuario U WITH(NOLOCK)
		WHERE (U.CODIGOCONSULTORA = @CodigoUsuario OR U.DOCUMENTOIDENTIDAD = @CodigoUsuario OR U.CODIGOUSUARIO = @CodigoUsuario)

	IF EXISTS (SELECT 1 FROM [dbo].[MetaConsultora] M WITH(NOLOCK)	
				WHERE M.CodigoUsuario = @CodigoUsuario AND M.CodigoMeta = 'VF_CAMBIO_CLAVE' AND M.ValorMeta = '1')
	BEGIN
		SELECT TOP 1
			@PrimerNombre = substring(ISNULL(CO.PrimerNombre, ''),1,1) + lower(substring(ISNULL(CO.PrimerNombre, ''),2, Len(CO.PrimerNombre))),
			@IdEstadoActividad = IsNull(CO.IdEstadoActividad, ''),
			@Celular = IsNull(U.Celular, ''),
			@Correo = IsNull(U.EMail, ''),
			@RegionID = IsNull(RegionID,0),
			@ZonaID = IsNull(CO.ZonaID, 0),
			@CambioClave = Isnull(U.CambioClave, 0)
		FROM dbo.Usuario U WITH(NOLOCK)
		LEFT JOIN ods.Consultora co WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE (U.CODIGOCONSULTORA = @CodigoUsuario OR U.DOCUMENTOIDENTIDAD = @CodigoUsuario)
			And U.CODIGOUSUARIO = @CodigoUsuario
		ORDER BY U.EMailActivo DESC
	END

	SELECT
		@Cantidad as Cantidad,
		@PrimerNombre as PrimerNombre,
		@IdEstadoActividad as IdEstadoActividad,
		@Celular as Celular,
		@Correo as Correo,
		@RegionID as RegionID,
		@ZonaID as ZonaID,
		@CambioClave as OpcionCambioClave
	SET NOCOUNT OFF
END
GO

USE BelcorpPanama
GO

/* GetUsuarioVerificacionCambioClave */
IF (OBJECT_ID('GetUsuarioVerificacionCambioClave') IS NOT NULL)
  DROP PROCEDURE [dbo].[GetUsuarioVerificacionCambioClave]
GO

CREATE PROCEDURE [dbo].[GetUsuarioVerificacionCambioClave]
	@CodigoUsuario VARCHAR(20)
AS
BEGIN	
	SET NOCOUNT ON
	
	DECLARE @Cantidad int = 0
	DECLARE @PrimerNombre varchar(30)
	DECLARE @IdEstadoActividad int
	DECLARE @Celular varchar(20)
	DECLARE @Correo	varchar(80)
	DECLARE @RegionID int	
	DECLARE @ZonaID int
	DECLARE @CambioClave int = -1

	SELECT TOP 1 @CodigoUsuario = U.CODIGOUSUARIO
	FROM dbo.Usuario U WITH(NOLOCK)
		WHERE (U.CODIGOCONSULTORA = @CodigoUsuario OR U.DOCUMENTOIDENTIDAD = @CodigoUsuario OR U.CODIGOUSUARIO = @CodigoUsuario)

	IF EXISTS (SELECT 1 FROM [dbo].[MetaConsultora] M WITH(NOLOCK)	
				WHERE M.CodigoUsuario = @CodigoUsuario AND M.CodigoMeta = 'VF_CAMBIO_CLAVE' AND M.ValorMeta = '1')
	BEGIN
		SELECT TOP 1
			@PrimerNombre = substring(ISNULL(CO.PrimerNombre, ''),1,1) + lower(substring(ISNULL(CO.PrimerNombre, ''),2, Len(CO.PrimerNombre))),
			@IdEstadoActividad = IsNull(CO.IdEstadoActividad, ''),
			@Celular = IsNull(U.Celular, ''),
			@Correo = IsNull(U.EMail, ''),
			@RegionID = IsNull(RegionID,0),
			@ZonaID = IsNull(CO.ZonaID, 0),
			@CambioClave = Isnull(U.CambioClave, 0)
		FROM dbo.Usuario U WITH(NOLOCK)
		LEFT JOIN ods.Consultora co WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE (U.CODIGOCONSULTORA = @CodigoUsuario OR U.DOCUMENTOIDENTIDAD = @CodigoUsuario)
			And U.CODIGOUSUARIO = @CodigoUsuario
		ORDER BY U.EMailActivo DESC
	END

	SELECT
		@Cantidad as Cantidad,
		@PrimerNombre as PrimerNombre,
		@IdEstadoActividad as IdEstadoActividad,
		@Celular as Celular,
		@Correo as Correo,
		@RegionID as RegionID,
		@ZonaID as ZonaID,
		@CambioClave as OpcionCambioClave
	SET NOCOUNT OFF
END
GO

USE BelcorpGuatemala
GO

/* GetUsuarioVerificacionCambioClave */
IF (OBJECT_ID('GetUsuarioVerificacionCambioClave') IS NOT NULL)
  DROP PROCEDURE [dbo].[GetUsuarioVerificacionCambioClave]
GO

CREATE PROCEDURE [dbo].[GetUsuarioVerificacionCambioClave]
	@CodigoUsuario VARCHAR(20)
AS
BEGIN	
	SET NOCOUNT ON
	
	DECLARE @Cantidad int = 0
	DECLARE @PrimerNombre varchar(30)
	DECLARE @IdEstadoActividad int
	DECLARE @Celular varchar(20)
	DECLARE @Correo	varchar(80)
	DECLARE @RegionID int	
	DECLARE @ZonaID int
	DECLARE @CambioClave int = -1

	SELECT TOP 1 @CodigoUsuario = U.CODIGOUSUARIO
	FROM dbo.Usuario U WITH(NOLOCK)
		WHERE (U.CODIGOCONSULTORA = @CodigoUsuario OR U.DOCUMENTOIDENTIDAD = @CodigoUsuario OR U.CODIGOUSUARIO = @CodigoUsuario)

	IF EXISTS (SELECT 1 FROM [dbo].[MetaConsultora] M WITH(NOLOCK)	
				WHERE M.CodigoUsuario = @CodigoUsuario AND M.CodigoMeta = 'VF_CAMBIO_CLAVE' AND M.ValorMeta = '1')
	BEGIN
		SELECT TOP 1
			@PrimerNombre = substring(ISNULL(CO.PrimerNombre, ''),1,1) + lower(substring(ISNULL(CO.PrimerNombre, ''),2, Len(CO.PrimerNombre))),
			@IdEstadoActividad = IsNull(CO.IdEstadoActividad, ''),
			@Celular = IsNull(U.Celular, ''),
			@Correo = IsNull(U.EMail, ''),
			@RegionID = IsNull(RegionID,0),
			@ZonaID = IsNull(CO.ZonaID, 0),
			@CambioClave = Isnull(U.CambioClave, 0)
		FROM dbo.Usuario U WITH(NOLOCK)
		LEFT JOIN ods.Consultora co WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE (U.CODIGOCONSULTORA = @CodigoUsuario OR U.DOCUMENTOIDENTIDAD = @CodigoUsuario)
			And U.CODIGOUSUARIO = @CodigoUsuario
		ORDER BY U.EMailActivo DESC
	END

	SELECT
		@Cantidad as Cantidad,
		@PrimerNombre as PrimerNombre,
		@IdEstadoActividad as IdEstadoActividad,
		@Celular as Celular,
		@Correo as Correo,
		@RegionID as RegionID,
		@ZonaID as ZonaID,
		@CambioClave as OpcionCambioClave
	SET NOCOUNT OFF
END
GO

USE BelcorpEcuador
GO

/* GetUsuarioVerificacionCambioClave */
IF (OBJECT_ID('GetUsuarioVerificacionCambioClave') IS NOT NULL)
  DROP PROCEDURE [dbo].[GetUsuarioVerificacionCambioClave]
GO

CREATE PROCEDURE [dbo].[GetUsuarioVerificacionCambioClave]
	@CodigoUsuario VARCHAR(20)
AS
BEGIN	
	SET NOCOUNT ON
	
	DECLARE @Cantidad int = 0
	DECLARE @PrimerNombre varchar(30)
	DECLARE @IdEstadoActividad int
	DECLARE @Celular varchar(20)
	DECLARE @Correo	varchar(80)
	DECLARE @RegionID int	
	DECLARE @ZonaID int
	DECLARE @CambioClave int = -1

	SELECT TOP 1 @CodigoUsuario = U.CODIGOUSUARIO
	FROM dbo.Usuario U WITH(NOLOCK)
		WHERE (U.CODIGOCONSULTORA = @CodigoUsuario OR U.DOCUMENTOIDENTIDAD = @CodigoUsuario OR U.CODIGOUSUARIO = @CodigoUsuario)

	IF EXISTS (SELECT 1 FROM [dbo].[MetaConsultora] M WITH(NOLOCK)	
				WHERE M.CodigoUsuario = @CodigoUsuario AND M.CodigoMeta = 'VF_CAMBIO_CLAVE' AND M.ValorMeta = '1')
	BEGIN
		SELECT TOP 1
			@PrimerNombre = substring(ISNULL(CO.PrimerNombre, ''),1,1) + lower(substring(ISNULL(CO.PrimerNombre, ''),2, Len(CO.PrimerNombre))),
			@IdEstadoActividad = IsNull(CO.IdEstadoActividad, ''),
			@Celular = IsNull(U.Celular, ''),
			@Correo = IsNull(U.EMail, ''),
			@RegionID = IsNull(RegionID,0),
			@ZonaID = IsNull(CO.ZonaID, 0),
			@CambioClave = Isnull(U.CambioClave, 0)
		FROM dbo.Usuario U WITH(NOLOCK)
		LEFT JOIN ods.Consultora co WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE (U.CODIGOCONSULTORA = @CodigoUsuario OR U.DOCUMENTOIDENTIDAD = @CodigoUsuario)
			And U.CODIGOUSUARIO = @CodigoUsuario
		ORDER BY U.EMailActivo DESC
	END

	SELECT
		@Cantidad as Cantidad,
		@PrimerNombre as PrimerNombre,
		@IdEstadoActividad as IdEstadoActividad,
		@Celular as Celular,
		@Correo as Correo,
		@RegionID as RegionID,
		@ZonaID as ZonaID,
		@CambioClave as OpcionCambioClave
	SET NOCOUNT OFF
END
GO

USE BelcorpDominicana
GO

/* GetUsuarioVerificacionCambioClave */
IF (OBJECT_ID('GetUsuarioVerificacionCambioClave') IS NOT NULL)
  DROP PROCEDURE [dbo].[GetUsuarioVerificacionCambioClave]
GO

CREATE PROCEDURE [dbo].[GetUsuarioVerificacionCambioClave]
	@CodigoUsuario VARCHAR(20)
AS
BEGIN	
	SET NOCOUNT ON
	
	DECLARE @Cantidad int = 0
	DECLARE @PrimerNombre varchar(30)
	DECLARE @IdEstadoActividad int
	DECLARE @Celular varchar(20)
	DECLARE @Correo	varchar(80)
	DECLARE @RegionID int	
	DECLARE @ZonaID int
	DECLARE @CambioClave int = -1

	SELECT TOP 1 @CodigoUsuario = U.CODIGOUSUARIO
	FROM dbo.Usuario U WITH(NOLOCK)
		WHERE (U.CODIGOCONSULTORA = @CodigoUsuario OR U.DOCUMENTOIDENTIDAD = @CodigoUsuario OR U.CODIGOUSUARIO = @CodigoUsuario)

	IF EXISTS (SELECT 1 FROM [dbo].[MetaConsultora] M WITH(NOLOCK)	
				WHERE M.CodigoUsuario = @CodigoUsuario AND M.CodigoMeta = 'VF_CAMBIO_CLAVE' AND M.ValorMeta = '1')
	BEGIN
		SELECT TOP 1
			@PrimerNombre = substring(ISNULL(CO.PrimerNombre, ''),1,1) + lower(substring(ISNULL(CO.PrimerNombre, ''),2, Len(CO.PrimerNombre))),
			@IdEstadoActividad = IsNull(CO.IdEstadoActividad, ''),
			@Celular = IsNull(U.Celular, ''),
			@Correo = IsNull(U.EMail, ''),
			@RegionID = IsNull(RegionID,0),
			@ZonaID = IsNull(CO.ZonaID, 0),
			@CambioClave = Isnull(U.CambioClave, 0)
		FROM dbo.Usuario U WITH(NOLOCK)
		LEFT JOIN ods.Consultora co WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE (U.CODIGOCONSULTORA = @CodigoUsuario OR U.DOCUMENTOIDENTIDAD = @CodigoUsuario)
			And U.CODIGOUSUARIO = @CodigoUsuario
		ORDER BY U.EMailActivo DESC
	END

	SELECT
		@Cantidad as Cantidad,
		@PrimerNombre as PrimerNombre,
		@IdEstadoActividad as IdEstadoActividad,
		@Celular as Celular,
		@Correo as Correo,
		@RegionID as RegionID,
		@ZonaID as ZonaID,
		@CambioClave as OpcionCambioClave
	SET NOCOUNT OFF
END
GO

USE BelcorpCostaRica
GO

/* GetUsuarioVerificacionCambioClave */
IF (OBJECT_ID('GetUsuarioVerificacionCambioClave') IS NOT NULL)
  DROP PROCEDURE [dbo].[GetUsuarioVerificacionCambioClave]
GO

CREATE PROCEDURE [dbo].[GetUsuarioVerificacionCambioClave]
	@CodigoUsuario VARCHAR(20)
AS
BEGIN	
	SET NOCOUNT ON
	
	DECLARE @Cantidad int = 0
	DECLARE @PrimerNombre varchar(30)
	DECLARE @IdEstadoActividad int
	DECLARE @Celular varchar(20)
	DECLARE @Correo	varchar(80)
	DECLARE @RegionID int	
	DECLARE @ZonaID int
	DECLARE @CambioClave int = -1

	SELECT TOP 1 @CodigoUsuario = U.CODIGOUSUARIO
	FROM dbo.Usuario U WITH(NOLOCK)
		WHERE (U.CODIGOCONSULTORA = @CodigoUsuario OR U.DOCUMENTOIDENTIDAD = @CodigoUsuario OR U.CODIGOUSUARIO = @CodigoUsuario)

	IF EXISTS (SELECT 1 FROM [dbo].[MetaConsultora] M WITH(NOLOCK)	
				WHERE M.CodigoUsuario = @CodigoUsuario AND M.CodigoMeta = 'VF_CAMBIO_CLAVE' AND M.ValorMeta = '1')
	BEGIN
		SELECT TOP 1
			@PrimerNombre = substring(ISNULL(CO.PrimerNombre, ''),1,1) + lower(substring(ISNULL(CO.PrimerNombre, ''),2, Len(CO.PrimerNombre))),
			@IdEstadoActividad = IsNull(CO.IdEstadoActividad, ''),
			@Celular = IsNull(U.Celular, ''),
			@Correo = IsNull(U.EMail, ''),
			@RegionID = IsNull(RegionID,0),
			@ZonaID = IsNull(CO.ZonaID, 0),
			@CambioClave = Isnull(U.CambioClave, 0)
		FROM dbo.Usuario U WITH(NOLOCK)
		LEFT JOIN ods.Consultora co WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE (U.CODIGOCONSULTORA = @CodigoUsuario OR U.DOCUMENTOIDENTIDAD = @CodigoUsuario)
			And U.CODIGOUSUARIO = @CodigoUsuario
		ORDER BY U.EMailActivo DESC
	END

	SELECT
		@Cantidad as Cantidad,
		@PrimerNombre as PrimerNombre,
		@IdEstadoActividad as IdEstadoActividad,
		@Celular as Celular,
		@Correo as Correo,
		@RegionID as RegionID,
		@ZonaID as ZonaID,
		@CambioClave as OpcionCambioClave
	SET NOCOUNT OFF
END
GO

USE BelcorpChile
GO

/* GetUsuarioVerificacionCambioClave */
IF (OBJECT_ID('GetUsuarioVerificacionCambioClave') IS NOT NULL)
  DROP PROCEDURE [dbo].[GetUsuarioVerificacionCambioClave]
GO

CREATE PROCEDURE [dbo].[GetUsuarioVerificacionCambioClave]
	@CodigoUsuario VARCHAR(20)
AS
BEGIN	
	SET NOCOUNT ON
	
	DECLARE @Cantidad int = 0
	DECLARE @PrimerNombre varchar(30)
	DECLARE @IdEstadoActividad int
	DECLARE @Celular varchar(20)
	DECLARE @Correo	varchar(80)
	DECLARE @RegionID int	
	DECLARE @ZonaID int
	DECLARE @CambioClave int = -1

	SELECT TOP 1 @CodigoUsuario = U.CODIGOUSUARIO
	FROM dbo.Usuario U WITH(NOLOCK)
		WHERE (U.CODIGOCONSULTORA = @CodigoUsuario OR U.DOCUMENTOIDENTIDAD = @CodigoUsuario OR U.CODIGOUSUARIO = @CodigoUsuario)

	IF EXISTS (SELECT 1 FROM [dbo].[MetaConsultora] M WITH(NOLOCK)	
				WHERE M.CodigoUsuario = @CodigoUsuario AND M.CodigoMeta = 'VF_CAMBIO_CLAVE' AND M.ValorMeta = '1')
	BEGIN
		SELECT TOP 1
			@PrimerNombre = substring(ISNULL(CO.PrimerNombre, ''),1,1) + lower(substring(ISNULL(CO.PrimerNombre, ''),2, Len(CO.PrimerNombre))),
			@IdEstadoActividad = IsNull(CO.IdEstadoActividad, ''),
			@Celular = IsNull(U.Celular, ''),
			@Correo = IsNull(U.EMail, ''),
			@RegionID = IsNull(RegionID,0),
			@ZonaID = IsNull(CO.ZonaID, 0),
			@CambioClave = Isnull(U.CambioClave, 0)
		FROM dbo.Usuario U WITH(NOLOCK)
		LEFT JOIN ods.Consultora co WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE (U.CODIGOCONSULTORA = @CodigoUsuario OR U.DOCUMENTOIDENTIDAD = @CodigoUsuario)
			And U.CODIGOUSUARIO = @CodigoUsuario
		ORDER BY U.EMailActivo DESC
	END

	SELECT
		@Cantidad as Cantidad,
		@PrimerNombre as PrimerNombre,
		@IdEstadoActividad as IdEstadoActividad,
		@Celular as Celular,
		@Correo as Correo,
		@RegionID as RegionID,
		@ZonaID as ZonaID,
		@CambioClave as OpcionCambioClave
	SET NOCOUNT OFF
END
GO

USE BelcorpBolivia
GO

/* GetUsuarioVerificacionCambioClave */
IF (OBJECT_ID('GetUsuarioVerificacionCambioClave') IS NOT NULL)
  DROP PROCEDURE [dbo].[GetUsuarioVerificacionCambioClave]
GO

CREATE PROCEDURE [dbo].[GetUsuarioVerificacionCambioClave]
	@CodigoUsuario VARCHAR(20)
AS
BEGIN	
	SET NOCOUNT ON
	
	DECLARE @Cantidad int = 0
	DECLARE @PrimerNombre varchar(30)
	DECLARE @IdEstadoActividad int
	DECLARE @Celular varchar(20)
	DECLARE @Correo	varchar(80)
	DECLARE @RegionID int	
	DECLARE @ZonaID int
	DECLARE @CambioClave int = -1

	SELECT TOP 1 @CodigoUsuario = U.CODIGOUSUARIO
	FROM dbo.Usuario U WITH(NOLOCK)
		WHERE (U.CODIGOCONSULTORA = @CodigoUsuario OR U.DOCUMENTOIDENTIDAD = @CodigoUsuario OR U.CODIGOUSUARIO = @CodigoUsuario)

	IF EXISTS (SELECT 1 FROM [dbo].[MetaConsultora] M WITH(NOLOCK)	
				WHERE M.CodigoUsuario = @CodigoUsuario AND M.CodigoMeta = 'VF_CAMBIO_CLAVE' AND M.ValorMeta = '1')
	BEGIN
		SELECT TOP 1
			@PrimerNombre = substring(ISNULL(CO.PrimerNombre, ''),1,1) + lower(substring(ISNULL(CO.PrimerNombre, ''),2, Len(CO.PrimerNombre))),
			@IdEstadoActividad = IsNull(CO.IdEstadoActividad, ''),
			@Celular = IsNull(U.Celular, ''),
			@Correo = IsNull(U.EMail, ''),
			@RegionID = IsNull(RegionID,0),
			@ZonaID = IsNull(CO.ZonaID, 0),
			@CambioClave = Isnull(U.CambioClave, 0)
		FROM dbo.Usuario U WITH(NOLOCK)
		LEFT JOIN ods.Consultora co WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE (U.CODIGOCONSULTORA = @CodigoUsuario OR U.DOCUMENTOIDENTIDAD = @CodigoUsuario)
			And U.CODIGOUSUARIO = @CodigoUsuario
		ORDER BY U.EMailActivo DESC
	END

	SELECT
		@Cantidad as Cantidad,
		@PrimerNombre as PrimerNombre,
		@IdEstadoActividad as IdEstadoActividad,
		@Celular as Celular,
		@Correo as Correo,
		@RegionID as RegionID,
		@ZonaID as ZonaID,
		@CambioClave as OpcionCambioClave
	SET NOCOUNT OFF
END
GO

