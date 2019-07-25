GO
USE BelcorpPeru
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetUsuarioCambioClave]')
		   AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[GetUsuarioCambioClave]
GO

CREATE PROCEDURE GetUsuarioCambioClave
(
	@CodigoUsuario VARCHAR(20)
)
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


	SELECT TOP 1
			@Cantidad = 1,
			@PrimerNombre = substring(ISNULL(CO.PrimerNombre, ''),1,1) + lower(substring(ISNULL(CO.PrimerNombre, ''),2, Len(CO.PrimerNombre))),
			@IdEstadoActividad = IsNull(CO.IdEstadoActividad, ''),
			@Celular = IsNull(U.Celular, ''),
			@Correo = IsNull(U.EMail, ''),
			@RegionID = IsNull(RegionID,0),
			@ZonaID = Isnull(CO.ZonaID, 0),
			@CambioClave = Isnull(U.CambioClave, 0)
		FROM dbo.Usuario U WITH(NOLOCK)
		LEFT JOIN ods.Consultora co WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE (U.CODIGOCONSULTORA = @CodigoUsuario OR U.DOCUMENTOIDENTIDAD = @CodigoUsuario)
		--And CO.IdEstadoActividad != IsNull(U.VerificacionEstadoActividad, 0)
		And CO.IdEstadoActividad in (1) AND Co.ConsecutivoNueva = 0
		AND U.TipoUsuario != 2
		AND U.CambioClave = 0
		ORDER BY U.EMailActivo DESC


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
go


GO
USE BelcorpMexico
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetUsuarioCambioClave]')
		   AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[GetUsuarioCambioClave]
GO

CREATE PROCEDURE GetUsuarioCambioClave
(
	@CodigoUsuario VARCHAR(20)
)
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


	SELECT TOP 1
			@Cantidad = 1,
			@PrimerNombre = substring(ISNULL(CO.PrimerNombre, ''),1,1) + lower(substring(ISNULL(CO.PrimerNombre, ''),2, Len(CO.PrimerNombre))),
			@IdEstadoActividad = IsNull(CO.IdEstadoActividad, ''),
			@Celular = IsNull(U.Celular, ''),
			@Correo = IsNull(U.EMail, ''),
			@RegionID = IsNull(RegionID,0),
			@ZonaID = Isnull(CO.ZonaID, 0),
			@CambioClave = Isnull(U.CambioClave, 0)
		FROM dbo.Usuario U WITH(NOLOCK)
		LEFT JOIN ods.Consultora co WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE (U.CODIGOCONSULTORA = @CodigoUsuario OR U.DOCUMENTOIDENTIDAD = @CodigoUsuario)
		--And CO.IdEstadoActividad != IsNull(U.VerificacionEstadoActividad, 0)
		And CO.IdEstadoActividad in (1) AND Co.ConsecutivoNueva = 0
		AND U.TipoUsuario != 2
		AND U.CambioClave = 0
		ORDER BY U.EMailActivo DESC


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
go


GO
USE BelcorpColombia
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetUsuarioCambioClave]')
		   AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[GetUsuarioCambioClave]
GO

CREATE PROCEDURE GetUsuarioCambioClave
(
	@CodigoUsuario VARCHAR(20)
)
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


	SELECT TOP 1
			@Cantidad = 1,
			@PrimerNombre = substring(ISNULL(CO.PrimerNombre, ''),1,1) + lower(substring(ISNULL(CO.PrimerNombre, ''),2, Len(CO.PrimerNombre))),
			@IdEstadoActividad = IsNull(CO.IdEstadoActividad, ''),
			@Celular = IsNull(U.Celular, ''),
			@Correo = IsNull(U.EMail, ''),
			@RegionID = IsNull(RegionID,0),
			@ZonaID = Isnull(CO.ZonaID, 0),
			@CambioClave = Isnull(U.CambioClave, 0)
		FROM dbo.Usuario U WITH(NOLOCK)
		LEFT JOIN ods.Consultora co WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE (U.CODIGOCONSULTORA = @CodigoUsuario OR U.DOCUMENTOIDENTIDAD = @CodigoUsuario)
		--And CO.IdEstadoActividad != IsNull(U.VerificacionEstadoActividad, 0)
		And CO.IdEstadoActividad in (1) AND Co.ConsecutivoNueva = 0
		AND U.TipoUsuario != 2
		AND U.CambioClave = 0
		ORDER BY U.EMailActivo DESC


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
go


GO
USE BelcorpSalvador
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetUsuarioCambioClave]')
		   AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[GetUsuarioCambioClave]
GO

CREATE PROCEDURE GetUsuarioCambioClave
(
	@CodigoUsuario VARCHAR(20)
)
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


	SELECT TOP 1
			@Cantidad = 1,
			@PrimerNombre = substring(ISNULL(CO.PrimerNombre, ''),1,1) + lower(substring(ISNULL(CO.PrimerNombre, ''),2, Len(CO.PrimerNombre))),
			@IdEstadoActividad = IsNull(CO.IdEstadoActividad, ''),
			@Celular = IsNull(U.Celular, ''),
			@Correo = IsNull(U.EMail, ''),
			@RegionID = IsNull(RegionID,0),
			@ZonaID = Isnull(CO.ZonaID, 0),
			@CambioClave = Isnull(U.CambioClave, 0)
		FROM dbo.Usuario U WITH(NOLOCK)
		LEFT JOIN ods.Consultora co WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE (U.CODIGOCONSULTORA = @CodigoUsuario OR U.DOCUMENTOIDENTIDAD = @CodigoUsuario)
		--And CO.IdEstadoActividad != IsNull(U.VerificacionEstadoActividad, 0)
		And CO.IdEstadoActividad in (1) AND Co.ConsecutivoNueva = 0
		AND U.TipoUsuario != 2
		AND U.CambioClave = 0
		ORDER BY U.EMailActivo DESC


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
go


GO
USE BelcorpPuertoRico
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetUsuarioCambioClave]')
		   AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[GetUsuarioCambioClave]
GO

CREATE PROCEDURE GetUsuarioCambioClave
(
	@CodigoUsuario VARCHAR(20)
)
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


	SELECT TOP 1
			@Cantidad = 1,
			@PrimerNombre = substring(ISNULL(CO.PrimerNombre, ''),1,1) + lower(substring(ISNULL(CO.PrimerNombre, ''),2, Len(CO.PrimerNombre))),
			@IdEstadoActividad = IsNull(CO.IdEstadoActividad, ''),
			@Celular = IsNull(U.Celular, ''),
			@Correo = IsNull(U.EMail, ''),
			@RegionID = IsNull(RegionID,0),
			@ZonaID = Isnull(CO.ZonaID, 0),
			@CambioClave = Isnull(U.CambioClave, 0)
		FROM dbo.Usuario U WITH(NOLOCK)
		LEFT JOIN ods.Consultora co WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE (U.CODIGOCONSULTORA = @CodigoUsuario OR U.DOCUMENTOIDENTIDAD = @CodigoUsuario)
		--And CO.IdEstadoActividad != IsNull(U.VerificacionEstadoActividad, 0)
		And CO.IdEstadoActividad in (1) AND Co.ConsecutivoNueva = 0
		AND U.TipoUsuario != 2
		AND U.CambioClave = 0
		ORDER BY U.EMailActivo DESC


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
go


GO
USE BelcorpPanama
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetUsuarioCambioClave]')
		   AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[GetUsuarioCambioClave]
GO

CREATE PROCEDURE GetUsuarioCambioClave
(
	@CodigoUsuario VARCHAR(20)
)
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


	SELECT TOP 1
			@Cantidad = 1,
			@PrimerNombre = substring(ISNULL(CO.PrimerNombre, ''),1,1) + lower(substring(ISNULL(CO.PrimerNombre, ''),2, Len(CO.PrimerNombre))),
			@IdEstadoActividad = IsNull(CO.IdEstadoActividad, ''),
			@Celular = IsNull(U.Celular, ''),
			@Correo = IsNull(U.EMail, ''),
			@RegionID = IsNull(RegionID,0),
			@ZonaID = Isnull(CO.ZonaID, 0),
			@CambioClave = Isnull(U.CambioClave, 0)
		FROM dbo.Usuario U WITH(NOLOCK)
		LEFT JOIN ods.Consultora co WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE (U.CODIGOCONSULTORA = @CodigoUsuario OR U.DOCUMENTOIDENTIDAD = @CodigoUsuario)
		--And CO.IdEstadoActividad != IsNull(U.VerificacionEstadoActividad, 0)
		And CO.IdEstadoActividad in (1) AND Co.ConsecutivoNueva = 0
		AND U.TipoUsuario != 2
		AND U.CambioClave = 0
		ORDER BY U.EMailActivo DESC


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
go


GO
USE BelcorpGuatemala
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetUsuarioCambioClave]')
		   AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[GetUsuarioCambioClave]
GO

CREATE PROCEDURE GetUsuarioCambioClave
(
	@CodigoUsuario VARCHAR(20)
)
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


	SELECT TOP 1
			@Cantidad = 1,
			@PrimerNombre = substring(ISNULL(CO.PrimerNombre, ''),1,1) + lower(substring(ISNULL(CO.PrimerNombre, ''),2, Len(CO.PrimerNombre))),
			@IdEstadoActividad = IsNull(CO.IdEstadoActividad, ''),
			@Celular = IsNull(U.Celular, ''),
			@Correo = IsNull(U.EMail, ''),
			@RegionID = IsNull(RegionID,0),
			@ZonaID = Isnull(CO.ZonaID, 0),
			@CambioClave = Isnull(U.CambioClave, 0)
		FROM dbo.Usuario U WITH(NOLOCK)
		LEFT JOIN ods.Consultora co WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE (U.CODIGOCONSULTORA = @CodigoUsuario OR U.DOCUMENTOIDENTIDAD = @CodigoUsuario)
		--And CO.IdEstadoActividad != IsNull(U.VerificacionEstadoActividad, 0)
		And CO.IdEstadoActividad in (1) AND Co.ConsecutivoNueva = 0
		AND U.TipoUsuario != 2
		AND U.CambioClave = 0
		ORDER BY U.EMailActivo DESC


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
go


GO
USE BelcorpEcuador
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetUsuarioCambioClave]')
		   AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[GetUsuarioCambioClave]
GO

CREATE PROCEDURE GetUsuarioCambioClave
(
	@CodigoUsuario VARCHAR(20)
)
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


	SELECT TOP 1
			@Cantidad = 1,
			@PrimerNombre = substring(ISNULL(CO.PrimerNombre, ''),1,1) + lower(substring(ISNULL(CO.PrimerNombre, ''),2, Len(CO.PrimerNombre))),
			@IdEstadoActividad = IsNull(CO.IdEstadoActividad, ''),
			@Celular = IsNull(U.Celular, ''),
			@Correo = IsNull(U.EMail, ''),
			@RegionID = IsNull(RegionID,0),
			@ZonaID = Isnull(CO.ZonaID, 0),
			@CambioClave = Isnull(U.CambioClave, 0)
		FROM dbo.Usuario U WITH(NOLOCK)
		LEFT JOIN ods.Consultora co WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE (U.CODIGOCONSULTORA = @CodigoUsuario OR U.DOCUMENTOIDENTIDAD = @CodigoUsuario)
		--And CO.IdEstadoActividad != IsNull(U.VerificacionEstadoActividad, 0)
		And CO.IdEstadoActividad in (1) AND Co.ConsecutivoNueva = 0
		AND U.TipoUsuario != 2
		AND U.CambioClave = 0
		ORDER BY U.EMailActivo DESC


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
go


GO
USE BelcorpDominicana
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetUsuarioCambioClave]')
		   AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[GetUsuarioCambioClave]
GO

CREATE PROCEDURE GetUsuarioCambioClave
(
	@CodigoUsuario VARCHAR(20)
)
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


	SELECT TOP 1
			@Cantidad = 1,
			@PrimerNombre = substring(ISNULL(CO.PrimerNombre, ''),1,1) + lower(substring(ISNULL(CO.PrimerNombre, ''),2, Len(CO.PrimerNombre))),
			@IdEstadoActividad = IsNull(CO.IdEstadoActividad, ''),
			@Celular = IsNull(U.Celular, ''),
			@Correo = IsNull(U.EMail, ''),
			@RegionID = IsNull(RegionID,0),
			@ZonaID = Isnull(CO.ZonaID, 0),
			@CambioClave = Isnull(U.CambioClave, 0)
		FROM dbo.Usuario U WITH(NOLOCK)
		LEFT JOIN ods.Consultora co WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE (U.CODIGOCONSULTORA = @CodigoUsuario OR U.DOCUMENTOIDENTIDAD = @CodigoUsuario)
		--And CO.IdEstadoActividad != IsNull(U.VerificacionEstadoActividad, 0)
		And CO.IdEstadoActividad in (1) AND Co.ConsecutivoNueva = 0
		AND U.TipoUsuario != 2
		AND U.CambioClave = 0
		ORDER BY U.EMailActivo DESC


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
go


GO
USE BelcorpCostaRica
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetUsuarioCambioClave]')
		   AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[GetUsuarioCambioClave]
GO

CREATE PROCEDURE GetUsuarioCambioClave
(
	@CodigoUsuario VARCHAR(20)
)
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


	SELECT TOP 1
			@Cantidad = 1,
			@PrimerNombre = substring(ISNULL(CO.PrimerNombre, ''),1,1) + lower(substring(ISNULL(CO.PrimerNombre, ''),2, Len(CO.PrimerNombre))),
			@IdEstadoActividad = IsNull(CO.IdEstadoActividad, ''),
			@Celular = IsNull(U.Celular, ''),
			@Correo = IsNull(U.EMail, ''),
			@RegionID = IsNull(RegionID,0),
			@ZonaID = Isnull(CO.ZonaID, 0),
			@CambioClave = Isnull(U.CambioClave, 0)
		FROM dbo.Usuario U WITH(NOLOCK)
		LEFT JOIN ods.Consultora co WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE (U.CODIGOCONSULTORA = @CodigoUsuario OR U.DOCUMENTOIDENTIDAD = @CodigoUsuario)
		--And CO.IdEstadoActividad != IsNull(U.VerificacionEstadoActividad, 0)
		And CO.IdEstadoActividad in (1) AND Co.ConsecutivoNueva = 0
		AND U.TipoUsuario != 2
		AND U.CambioClave = 0
		ORDER BY U.EMailActivo DESC


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
go


GO
USE BelcorpChile
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetUsuarioCambioClave]')
		   AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[GetUsuarioCambioClave]
GO

CREATE PROCEDURE GetUsuarioCambioClave
(
	@CodigoUsuario VARCHAR(20)
)
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


	SELECT TOP 1
			@Cantidad = 1,
			@PrimerNombre = substring(ISNULL(CO.PrimerNombre, ''),1,1) + lower(substring(ISNULL(CO.PrimerNombre, ''),2, Len(CO.PrimerNombre))),
			@IdEstadoActividad = IsNull(CO.IdEstadoActividad, ''),
			@Celular = IsNull(U.Celular, ''),
			@Correo = IsNull(U.EMail, ''),
			@RegionID = IsNull(RegionID,0),
			@ZonaID = Isnull(CO.ZonaID, 0),
			@CambioClave = Isnull(U.CambioClave, 0)
		FROM dbo.Usuario U WITH(NOLOCK)
		LEFT JOIN ods.Consultora co WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE (U.CODIGOCONSULTORA = @CodigoUsuario OR U.DOCUMENTOIDENTIDAD = @CodigoUsuario)
		--And CO.IdEstadoActividad != IsNull(U.VerificacionEstadoActividad, 0)
		And CO.IdEstadoActividad in (1) AND Co.ConsecutivoNueva = 0
		AND U.TipoUsuario != 2
		AND U.CambioClave = 0
		ORDER BY U.EMailActivo DESC


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
go


GO
USE BelcorpBolivia
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetUsuarioCambioClave]')
		   AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[GetUsuarioCambioClave]
GO

CREATE PROCEDURE GetUsuarioCambioClave
(
	@CodigoUsuario VARCHAR(20)
)
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


	SELECT TOP 1
			@Cantidad = 1,
			@PrimerNombre = substring(ISNULL(CO.PrimerNombre, ''),1,1) + lower(substring(ISNULL(CO.PrimerNombre, ''),2, Len(CO.PrimerNombre))),
			@IdEstadoActividad = IsNull(CO.IdEstadoActividad, ''),
			@Celular = IsNull(U.Celular, ''),
			@Correo = IsNull(U.EMail, ''),
			@RegionID = IsNull(RegionID,0),
			@ZonaID = Isnull(CO.ZonaID, 0),
			@CambioClave = Isnull(U.CambioClave, 0)
		FROM dbo.Usuario U WITH(NOLOCK)
		LEFT JOIN ods.Consultora co WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE (U.CODIGOCONSULTORA = @CodigoUsuario OR U.DOCUMENTOIDENTIDAD = @CodigoUsuario)
		--And CO.IdEstadoActividad != IsNull(U.VerificacionEstadoActividad, 0)
		And CO.IdEstadoActividad in (1) AND Co.ConsecutivoNueva = 0
		AND U.TipoUsuario != 2
		AND U.CambioClave = 0
		ORDER BY U.EMailActivo DESC


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
go


GO
