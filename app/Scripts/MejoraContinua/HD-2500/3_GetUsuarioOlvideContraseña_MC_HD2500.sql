USE BelcorpPeru
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'GetUsuarioOlvideContrasenia')
BEGIN
	DROP PROC [dbo].[GetUsuarioOlvideContrasenia]
END
GO
-- [dbo].[GetUsuarioOlvideContrasenia] '0012329',2
CREATE PROCEDURE [dbo].[GetUsuarioOlvideContrasenia]
	@ValorIngresado VARCHAR(20),
	@PaisID	INT
AS
BEGIN	
	SET NOCOUNT ON

	DECLARE @Cantidad int = 0
	DECLARE @CodigoUsuario varchar(20)
	DECLARE @CodigoConsultora varchar(20)
	DECLARE @PrimerNombre varchar(30)
	DECLARE @IdEstadoActividad int
	DECLARE @Celular varchar(20)
	DECLARE @Correo	varchar(80)	
	DECLARE @ZonaID int

	IF (@PaisID = 3 OR @PaisID = 4 OR @PaisID = 6)
	BEGIN
		SELECT TOP 1
			@Cantidad = 1,
			@CodigoUsuario = IsNull(U.CodigoUsuario, ''),
			@CodigoConsultora = IsNull(CO.Codigo, ''),
			@PrimerNombre = substring(ISNULL(CO.PrimerNombre, ''),1,1) + lower(substring(ISNULL(CO.PrimerNombre, ''),2, Len(CO.PrimerNombre))),
			@IdEstadoActividad = IsNull(CO.IdEstadoActividad, ''),
			@Celular = IsNull(U.Celular, ''),
			@Correo = IsNull(U.EMail, ''),
			@ZonaID = IsNull(CO.ZonaID, 0)
		FROM dbo.Usuario U WITH(NOLOCK)
		LEFT JOIN ods.Consultora CO WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE U.DOCUMENTOIDENTIDAD = @ValorIngresado
		ORDER BY U.EMailActivo DESC		
	END
	ELSE
	BEGIN
		SELECT TOP 1
			@Cantidad = 1,
			@CodigoUsuario = IsNull(U.CodigoUsuario, ''),
			@CodigoConsultora = IsNull(CO.Codigo, ''),
			@PrimerNombre = substring(ISNULL(CO.PrimerNombre, ''),1,1) + lower(substring(ISNULL(CO.PrimerNombre, ''),2, Len(CO.PrimerNombre))),
			@IdEstadoActividad = IsNull(CO.IdEstadoActividad, ''),
			@Celular = IsNull(U.Celular, ''),
			@Correo = IsNull(U.EMail, ''),
			@ZonaID = Isnull(CO.ZonaID, 0)
		FROM dbo.Usuario U WITH(NOLOCK)
		LEFT JOIN ods.Consultora co WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE U.CODIGOCONSULTORA = @ValorIngresado OR U.DOCUMENTOIDENTIDAD = @ValorIngresado
		ORDER BY U.EMailActivo DESC
	END

	SELECT
			@Cantidad as Cantidad,
			@CodigoUsuario as CodigoUsuario,
			@CodigoConsultora as CodigoConsultora,
			@PrimerNombre as PrimerNombre,
			@IdEstadoActividad as IdEstadoActividad,
			@Celular as Celular,
			@Correo as Correo,
			@ZonaID as ZonaID
	SET NOCOUNT OFF
END
GO

USE BelcorpMexico
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'GetUsuarioOlvideContrasenia')
BEGIN
	DROP PROC [dbo].[GetUsuarioOlvideContrasenia]
END
GO
-- [dbo].[GetUsuarioOlvideContrasenia] '0012329',2
CREATE PROCEDURE [dbo].[GetUsuarioOlvideContrasenia]
	@ValorIngresado VARCHAR(20),
	@PaisID	INT
AS
BEGIN	
	SET NOCOUNT ON

	DECLARE @Cantidad int = 0
	DECLARE @CodigoUsuario varchar(20)
	DECLARE @CodigoConsultora varchar(20)
	DECLARE @PrimerNombre varchar(30)
	DECLARE @IdEstadoActividad int
	DECLARE @Celular varchar(20)
	DECLARE @Correo	varchar(80)	
	DECLARE @ZonaID int

	IF (@PaisID = 3 OR @PaisID = 4 OR @PaisID = 6)
	BEGIN
		SELECT TOP 1
			@Cantidad = 1,
			@CodigoUsuario = IsNull(U.CodigoUsuario, ''),
			@CodigoConsultora = IsNull(CO.Codigo, ''),
			@PrimerNombre = substring(ISNULL(CO.PrimerNombre, ''),1,1) + lower(substring(ISNULL(CO.PrimerNombre, ''),2, Len(CO.PrimerNombre))),
			@IdEstadoActividad = IsNull(CO.IdEstadoActividad, ''),
			@Celular = IsNull(U.Celular, ''),
			@Correo = IsNull(U.EMail, ''),
			@ZonaID = IsNull(CO.ZonaID, 0)
		FROM dbo.Usuario U WITH(NOLOCK)
		LEFT JOIN ods.Consultora CO WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE U.DOCUMENTOIDENTIDAD = @ValorIngresado
		ORDER BY U.EMailActivo DESC		
	END
	ELSE
	BEGIN
		SELECT TOP 1
			@Cantidad = 1,
			@CodigoUsuario = IsNull(U.CodigoUsuario, ''),
			@CodigoConsultora = IsNull(CO.Codigo, ''),
			@PrimerNombre = substring(ISNULL(CO.PrimerNombre, ''),1,1) + lower(substring(ISNULL(CO.PrimerNombre, ''),2, Len(CO.PrimerNombre))),
			@IdEstadoActividad = IsNull(CO.IdEstadoActividad, ''),
			@Celular = IsNull(U.Celular, ''),
			@Correo = IsNull(U.EMail, ''),
			@ZonaID = Isnull(CO.ZonaID, 0)
		FROM dbo.Usuario U WITH(NOLOCK)
		LEFT JOIN ods.Consultora co WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE U.CODIGOCONSULTORA = @ValorIngresado OR U.DOCUMENTOIDENTIDAD = @ValorIngresado
		ORDER BY U.EMailActivo DESC
	END

	SELECT
			@Cantidad as Cantidad,
			@CodigoUsuario as CodigoUsuario,
			@CodigoConsultora as CodigoConsultora,
			@PrimerNombre as PrimerNombre,
			@IdEstadoActividad as IdEstadoActividad,
			@Celular as Celular,
			@Correo as Correo,
			@ZonaID as ZonaID
	SET NOCOUNT OFF
END
GO

USE BelcorpColombia
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'GetUsuarioOlvideContrasenia')
BEGIN
	DROP PROC [dbo].[GetUsuarioOlvideContrasenia]
END
GO
-- [dbo].[GetUsuarioOlvideContrasenia] '0012329',2
CREATE PROCEDURE [dbo].[GetUsuarioOlvideContrasenia]
	@ValorIngresado VARCHAR(20),
	@PaisID	INT
AS
BEGIN	
	SET NOCOUNT ON

	DECLARE @Cantidad int = 0
	DECLARE @CodigoUsuario varchar(20)
	DECLARE @CodigoConsultora varchar(20)
	DECLARE @PrimerNombre varchar(30)
	DECLARE @IdEstadoActividad int
	DECLARE @Celular varchar(20)
	DECLARE @Correo	varchar(80)	
	DECLARE @ZonaID int

	IF (@PaisID = 3 OR @PaisID = 4 OR @PaisID = 6)
	BEGIN
		SELECT TOP 1
			@Cantidad = 1,
			@CodigoUsuario = IsNull(U.CodigoUsuario, ''),
			@CodigoConsultora = IsNull(CO.Codigo, ''),
			@PrimerNombre = substring(ISNULL(CO.PrimerNombre, ''),1,1) + lower(substring(ISNULL(CO.PrimerNombre, ''),2, Len(CO.PrimerNombre))),
			@IdEstadoActividad = IsNull(CO.IdEstadoActividad, ''),
			@Celular = IsNull(U.Celular, ''),
			@Correo = IsNull(U.EMail, ''),
			@ZonaID = IsNull(CO.ZonaID, 0)
		FROM dbo.Usuario U WITH(NOLOCK)
		LEFT JOIN ods.Consultora CO WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE U.DOCUMENTOIDENTIDAD = @ValorIngresado
		ORDER BY U.EMailActivo DESC		
	END
	ELSE
	BEGIN
		SELECT TOP 1
			@Cantidad = 1,
			@CodigoUsuario = IsNull(U.CodigoUsuario, ''),
			@CodigoConsultora = IsNull(CO.Codigo, ''),
			@PrimerNombre = substring(ISNULL(CO.PrimerNombre, ''),1,1) + lower(substring(ISNULL(CO.PrimerNombre, ''),2, Len(CO.PrimerNombre))),
			@IdEstadoActividad = IsNull(CO.IdEstadoActividad, ''),
			@Celular = IsNull(U.Celular, ''),
			@Correo = IsNull(U.EMail, ''),
			@ZonaID = Isnull(CO.ZonaID, 0)
		FROM dbo.Usuario U WITH(NOLOCK)
		LEFT JOIN ods.Consultora co WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE U.CODIGOCONSULTORA = @ValorIngresado OR U.DOCUMENTOIDENTIDAD = @ValorIngresado
		ORDER BY U.EMailActivo DESC
	END

	SELECT
			@Cantidad as Cantidad,
			@CodigoUsuario as CodigoUsuario,
			@CodigoConsultora as CodigoConsultora,
			@PrimerNombre as PrimerNombre,
			@IdEstadoActividad as IdEstadoActividad,
			@Celular as Celular,
			@Correo as Correo,
			@ZonaID as ZonaID
	SET NOCOUNT OFF
END
GO

USE BelcorpSalvador
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'GetUsuarioOlvideContrasenia')
BEGIN
	DROP PROC [dbo].[GetUsuarioOlvideContrasenia]
END
GO
-- [dbo].[GetUsuarioOlvideContrasenia] '0012329',2
CREATE PROCEDURE [dbo].[GetUsuarioOlvideContrasenia]
	@ValorIngresado VARCHAR(20),
	@PaisID	INT
AS
BEGIN	
	SET NOCOUNT ON

	DECLARE @Cantidad int = 0
	DECLARE @CodigoUsuario varchar(20)
	DECLARE @CodigoConsultora varchar(20)
	DECLARE @PrimerNombre varchar(30)
	DECLARE @IdEstadoActividad int
	DECLARE @Celular varchar(20)
	DECLARE @Correo	varchar(80)	
	DECLARE @ZonaID int

	IF (@PaisID = 3 OR @PaisID = 4 OR @PaisID = 6)
	BEGIN
		SELECT TOP 1
			@Cantidad = 1,
			@CodigoUsuario = IsNull(U.CodigoUsuario, ''),
			@CodigoConsultora = IsNull(CO.Codigo, ''),
			@PrimerNombre = substring(ISNULL(CO.PrimerNombre, ''),1,1) + lower(substring(ISNULL(CO.PrimerNombre, ''),2, Len(CO.PrimerNombre))),
			@IdEstadoActividad = IsNull(CO.IdEstadoActividad, ''),
			@Celular = IsNull(U.Celular, ''),
			@Correo = IsNull(U.EMail, ''),
			@ZonaID = IsNull(CO.ZonaID, 0)
		FROM dbo.Usuario U WITH(NOLOCK)
		LEFT JOIN ods.Consultora CO WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE U.DOCUMENTOIDENTIDAD = @ValorIngresado
		ORDER BY U.EMailActivo DESC		
	END
	ELSE
	BEGIN
		SELECT TOP 1
			@Cantidad = 1,
			@CodigoUsuario = IsNull(U.CodigoUsuario, ''),
			@CodigoConsultora = IsNull(CO.Codigo, ''),
			@PrimerNombre = substring(ISNULL(CO.PrimerNombre, ''),1,1) + lower(substring(ISNULL(CO.PrimerNombre, ''),2, Len(CO.PrimerNombre))),
			@IdEstadoActividad = IsNull(CO.IdEstadoActividad, ''),
			@Celular = IsNull(U.Celular, ''),
			@Correo = IsNull(U.EMail, ''),
			@ZonaID = Isnull(CO.ZonaID, 0)
		FROM dbo.Usuario U WITH(NOLOCK)
		LEFT JOIN ods.Consultora co WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE U.CODIGOCONSULTORA = @ValorIngresado OR U.DOCUMENTOIDENTIDAD = @ValorIngresado
		ORDER BY U.EMailActivo DESC
	END

	SELECT
			@Cantidad as Cantidad,
			@CodigoUsuario as CodigoUsuario,
			@CodigoConsultora as CodigoConsultora,
			@PrimerNombre as PrimerNombre,
			@IdEstadoActividad as IdEstadoActividad,
			@Celular as Celular,
			@Correo as Correo,
			@ZonaID as ZonaID
	SET NOCOUNT OFF
END
GO

USE BelcorpPuertoRico
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'GetUsuarioOlvideContrasenia')
BEGIN
	DROP PROC [dbo].[GetUsuarioOlvideContrasenia]
END
GO
-- [dbo].[GetUsuarioOlvideContrasenia] '0012329',2
CREATE PROCEDURE [dbo].[GetUsuarioOlvideContrasenia]
	@ValorIngresado VARCHAR(20),
	@PaisID	INT
AS
BEGIN	
	SET NOCOUNT ON

	DECLARE @Cantidad int = 0
	DECLARE @CodigoUsuario varchar(20)
	DECLARE @CodigoConsultora varchar(20)
	DECLARE @PrimerNombre varchar(30)
	DECLARE @IdEstadoActividad int
	DECLARE @Celular varchar(20)
	DECLARE @Correo	varchar(80)	
	DECLARE @ZonaID int

	IF (@PaisID = 3 OR @PaisID = 4 OR @PaisID = 6)
	BEGIN
		SELECT TOP 1
			@Cantidad = 1,
			@CodigoUsuario = IsNull(U.CodigoUsuario, ''),
			@CodigoConsultora = IsNull(CO.Codigo, ''),
			@PrimerNombre = substring(ISNULL(CO.PrimerNombre, ''),1,1) + lower(substring(ISNULL(CO.PrimerNombre, ''),2, Len(CO.PrimerNombre))),
			@IdEstadoActividad = IsNull(CO.IdEstadoActividad, ''),
			@Celular = IsNull(U.Celular, ''),
			@Correo = IsNull(U.EMail, ''),
			@ZonaID = IsNull(CO.ZonaID, 0)
		FROM dbo.Usuario U WITH(NOLOCK)
		LEFT JOIN ods.Consultora CO WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE U.DOCUMENTOIDENTIDAD = @ValorIngresado
		ORDER BY U.EMailActivo DESC		
	END
	ELSE
	BEGIN
		SELECT TOP 1
			@Cantidad = 1,
			@CodigoUsuario = IsNull(U.CodigoUsuario, ''),
			@CodigoConsultora = IsNull(CO.Codigo, ''),
			@PrimerNombre = substring(ISNULL(CO.PrimerNombre, ''),1,1) + lower(substring(ISNULL(CO.PrimerNombre, ''),2, Len(CO.PrimerNombre))),
			@IdEstadoActividad = IsNull(CO.IdEstadoActividad, ''),
			@Celular = IsNull(U.Celular, ''),
			@Correo = IsNull(U.EMail, ''),
			@ZonaID = Isnull(CO.ZonaID, 0)
		FROM dbo.Usuario U WITH(NOLOCK)
		LEFT JOIN ods.Consultora co WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE U.CODIGOCONSULTORA = @ValorIngresado OR U.DOCUMENTOIDENTIDAD = @ValorIngresado
		ORDER BY U.EMailActivo DESC
	END

	SELECT
			@Cantidad as Cantidad,
			@CodigoUsuario as CodigoUsuario,
			@CodigoConsultora as CodigoConsultora,
			@PrimerNombre as PrimerNombre,
			@IdEstadoActividad as IdEstadoActividad,
			@Celular as Celular,
			@Correo as Correo,
			@ZonaID as ZonaID
	SET NOCOUNT OFF
END
GO

USE BelcorpPanama
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'GetUsuarioOlvideContrasenia')
BEGIN
	DROP PROC [dbo].[GetUsuarioOlvideContrasenia]
END
GO
-- [dbo].[GetUsuarioOlvideContrasenia] '0012329',2
CREATE PROCEDURE [dbo].[GetUsuarioOlvideContrasenia]
	@ValorIngresado VARCHAR(20),
	@PaisID	INT
AS
BEGIN	
	SET NOCOUNT ON

	DECLARE @Cantidad int = 0
	DECLARE @CodigoUsuario varchar(20)
	DECLARE @CodigoConsultora varchar(20)
	DECLARE @PrimerNombre varchar(30)
	DECLARE @IdEstadoActividad int
	DECLARE @Celular varchar(20)
	DECLARE @Correo	varchar(80)	
	DECLARE @ZonaID int

	IF (@PaisID = 3 OR @PaisID = 4 OR @PaisID = 6)
	BEGIN
		SELECT TOP 1
			@Cantidad = 1,
			@CodigoUsuario = IsNull(U.CodigoUsuario, ''),
			@CodigoConsultora = IsNull(CO.Codigo, ''),
			@PrimerNombre = substring(ISNULL(CO.PrimerNombre, ''),1,1) + lower(substring(ISNULL(CO.PrimerNombre, ''),2, Len(CO.PrimerNombre))),
			@IdEstadoActividad = IsNull(CO.IdEstadoActividad, ''),
			@Celular = IsNull(U.Celular, ''),
			@Correo = IsNull(U.EMail, ''),
			@ZonaID = IsNull(CO.ZonaID, 0)
		FROM dbo.Usuario U WITH(NOLOCK)
		LEFT JOIN ods.Consultora CO WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE U.DOCUMENTOIDENTIDAD = @ValorIngresado
		ORDER BY U.EMailActivo DESC		
	END
	ELSE
	BEGIN
		SELECT TOP 1
			@Cantidad = 1,
			@CodigoUsuario = IsNull(U.CodigoUsuario, ''),
			@CodigoConsultora = IsNull(CO.Codigo, ''),
			@PrimerNombre = substring(ISNULL(CO.PrimerNombre, ''),1,1) + lower(substring(ISNULL(CO.PrimerNombre, ''),2, Len(CO.PrimerNombre))),
			@IdEstadoActividad = IsNull(CO.IdEstadoActividad, ''),
			@Celular = IsNull(U.Celular, ''),
			@Correo = IsNull(U.EMail, ''),
			@ZonaID = Isnull(CO.ZonaID, 0)
		FROM dbo.Usuario U WITH(NOLOCK)
		LEFT JOIN ods.Consultora co WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE U.CODIGOCONSULTORA = @ValorIngresado OR U.DOCUMENTOIDENTIDAD = @ValorIngresado
		ORDER BY U.EMailActivo DESC
	END

	SELECT
			@Cantidad as Cantidad,
			@CodigoUsuario as CodigoUsuario,
			@CodigoConsultora as CodigoConsultora,
			@PrimerNombre as PrimerNombre,
			@IdEstadoActividad as IdEstadoActividad,
			@Celular as Celular,
			@Correo as Correo,
			@ZonaID as ZonaID
	SET NOCOUNT OFF
END
GO

USE BelcorpGuatemala
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'GetUsuarioOlvideContrasenia')
BEGIN
	DROP PROC [dbo].[GetUsuarioOlvideContrasenia]
END
GO
-- [dbo].[GetUsuarioOlvideContrasenia] '0012329',2
CREATE PROCEDURE [dbo].[GetUsuarioOlvideContrasenia]
	@ValorIngresado VARCHAR(20),
	@PaisID	INT
AS
BEGIN	
	SET NOCOUNT ON

	DECLARE @Cantidad int = 0
	DECLARE @CodigoUsuario varchar(20)
	DECLARE @CodigoConsultora varchar(20)
	DECLARE @PrimerNombre varchar(30)
	DECLARE @IdEstadoActividad int
	DECLARE @Celular varchar(20)
	DECLARE @Correo	varchar(80)	
	DECLARE @ZonaID int

	IF (@PaisID = 3 OR @PaisID = 4 OR @PaisID = 6)
	BEGIN
		SELECT TOP 1
			@Cantidad = 1,
			@CodigoUsuario = IsNull(U.CodigoUsuario, ''),
			@CodigoConsultora = IsNull(CO.Codigo, ''),
			@PrimerNombre = substring(ISNULL(CO.PrimerNombre, ''),1,1) + lower(substring(ISNULL(CO.PrimerNombre, ''),2, Len(CO.PrimerNombre))),
			@IdEstadoActividad = IsNull(CO.IdEstadoActividad, ''),
			@Celular = IsNull(U.Celular, ''),
			@Correo = IsNull(U.EMail, ''),
			@ZonaID = IsNull(CO.ZonaID, 0)
		FROM dbo.Usuario U WITH(NOLOCK)
		LEFT JOIN ods.Consultora CO WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE U.DOCUMENTOIDENTIDAD = @ValorIngresado
		ORDER BY U.EMailActivo DESC		
	END
	ELSE
	BEGIN
		SELECT TOP 1
			@Cantidad = 1,
			@CodigoUsuario = IsNull(U.CodigoUsuario, ''),
			@CodigoConsultora = IsNull(CO.Codigo, ''),
			@PrimerNombre = substring(ISNULL(CO.PrimerNombre, ''),1,1) + lower(substring(ISNULL(CO.PrimerNombre, ''),2, Len(CO.PrimerNombre))),
			@IdEstadoActividad = IsNull(CO.IdEstadoActividad, ''),
			@Celular = IsNull(U.Celular, ''),
			@Correo = IsNull(U.EMail, ''),
			@ZonaID = Isnull(CO.ZonaID, 0)
		FROM dbo.Usuario U WITH(NOLOCK)
		LEFT JOIN ods.Consultora co WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE U.CODIGOCONSULTORA = @ValorIngresado OR U.DOCUMENTOIDENTIDAD = @ValorIngresado
		ORDER BY U.EMailActivo DESC
	END

	SELECT
			@Cantidad as Cantidad,
			@CodigoUsuario as CodigoUsuario,
			@CodigoConsultora as CodigoConsultora,
			@PrimerNombre as PrimerNombre,
			@IdEstadoActividad as IdEstadoActividad,
			@Celular as Celular,
			@Correo as Correo,
			@ZonaID as ZonaID
	SET NOCOUNT OFF
END
GO

USE BelcorpEcuador
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'GetUsuarioOlvideContrasenia')
BEGIN
	DROP PROC [dbo].[GetUsuarioOlvideContrasenia]
END
GO
-- [dbo].[GetUsuarioOlvideContrasenia] '0012329',2
CREATE PROCEDURE [dbo].[GetUsuarioOlvideContrasenia]
	@ValorIngresado VARCHAR(20),
	@PaisID	INT
AS
BEGIN	
	SET NOCOUNT ON

	DECLARE @Cantidad int = 0
	DECLARE @CodigoUsuario varchar(20)
	DECLARE @CodigoConsultora varchar(20)
	DECLARE @PrimerNombre varchar(30)
	DECLARE @IdEstadoActividad int
	DECLARE @Celular varchar(20)
	DECLARE @Correo	varchar(80)	
	DECLARE @ZonaID int

	IF (@PaisID = 3 OR @PaisID = 4 OR @PaisID = 6)
	BEGIN
		SELECT TOP 1
			@Cantidad = 1,
			@CodigoUsuario = IsNull(U.CodigoUsuario, ''),
			@CodigoConsultora = IsNull(CO.Codigo, ''),
			@PrimerNombre = substring(ISNULL(CO.PrimerNombre, ''),1,1) + lower(substring(ISNULL(CO.PrimerNombre, ''),2, Len(CO.PrimerNombre))),
			@IdEstadoActividad = IsNull(CO.IdEstadoActividad, ''),
			@Celular = IsNull(U.Celular, ''),
			@Correo = IsNull(U.EMail, ''),
			@ZonaID = IsNull(CO.ZonaID, 0)
		FROM dbo.Usuario U WITH(NOLOCK)
		LEFT JOIN ods.Consultora CO WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE U.DOCUMENTOIDENTIDAD = @ValorIngresado
		ORDER BY U.EMailActivo DESC		
	END
	ELSE
	BEGIN
		SELECT TOP 1
			@Cantidad = 1,
			@CodigoUsuario = IsNull(U.CodigoUsuario, ''),
			@CodigoConsultora = IsNull(CO.Codigo, ''),
			@PrimerNombre = substring(ISNULL(CO.PrimerNombre, ''),1,1) + lower(substring(ISNULL(CO.PrimerNombre, ''),2, Len(CO.PrimerNombre))),
			@IdEstadoActividad = IsNull(CO.IdEstadoActividad, ''),
			@Celular = IsNull(U.Celular, ''),
			@Correo = IsNull(U.EMail, ''),
			@ZonaID = Isnull(CO.ZonaID, 0)
		FROM dbo.Usuario U WITH(NOLOCK)
		LEFT JOIN ods.Consultora co WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE U.CODIGOCONSULTORA = @ValorIngresado OR U.DOCUMENTOIDENTIDAD = @ValorIngresado
		ORDER BY U.EMailActivo DESC
	END

	SELECT
			@Cantidad as Cantidad,
			@CodigoUsuario as CodigoUsuario,
			@CodigoConsultora as CodigoConsultora,
			@PrimerNombre as PrimerNombre,
			@IdEstadoActividad as IdEstadoActividad,
			@Celular as Celular,
			@Correo as Correo,
			@ZonaID as ZonaID
	SET NOCOUNT OFF
END
GO

USE BelcorpDominicana
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'GetUsuarioOlvideContrasenia')
BEGIN
	DROP PROC [dbo].[GetUsuarioOlvideContrasenia]
END
GO
-- [dbo].[GetUsuarioOlvideContrasenia] '0012329',2
CREATE PROCEDURE [dbo].[GetUsuarioOlvideContrasenia]
	@ValorIngresado VARCHAR(20),
	@PaisID	INT
AS
BEGIN	
	SET NOCOUNT ON

	DECLARE @Cantidad int = 0
	DECLARE @CodigoUsuario varchar(20)
	DECLARE @CodigoConsultora varchar(20)
	DECLARE @PrimerNombre varchar(30)
	DECLARE @IdEstadoActividad int
	DECLARE @Celular varchar(20)
	DECLARE @Correo	varchar(80)	
	DECLARE @ZonaID int

	IF (@PaisID = 3 OR @PaisID = 4 OR @PaisID = 6)
	BEGIN
		SELECT TOP 1
			@Cantidad = 1,
			@CodigoUsuario = IsNull(U.CodigoUsuario, ''),
			@CodigoConsultora = IsNull(CO.Codigo, ''),
			@PrimerNombre = substring(ISNULL(CO.PrimerNombre, ''),1,1) + lower(substring(ISNULL(CO.PrimerNombre, ''),2, Len(CO.PrimerNombre))),
			@IdEstadoActividad = IsNull(CO.IdEstadoActividad, ''),
			@Celular = IsNull(U.Celular, ''),
			@Correo = IsNull(U.EMail, ''),
			@ZonaID = IsNull(CO.ZonaID, 0)
		FROM dbo.Usuario U WITH(NOLOCK)
		LEFT JOIN ods.Consultora CO WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE U.DOCUMENTOIDENTIDAD = @ValorIngresado
		ORDER BY U.EMailActivo DESC		
	END
	ELSE
	BEGIN
		SELECT TOP 1
			@Cantidad = 1,
			@CodigoUsuario = IsNull(U.CodigoUsuario, ''),
			@CodigoConsultora = IsNull(CO.Codigo, ''),
			@PrimerNombre = substring(ISNULL(CO.PrimerNombre, ''),1,1) + lower(substring(ISNULL(CO.PrimerNombre, ''),2, Len(CO.PrimerNombre))),
			@IdEstadoActividad = IsNull(CO.IdEstadoActividad, ''),
			@Celular = IsNull(U.Celular, ''),
			@Correo = IsNull(U.EMail, ''),
			@ZonaID = Isnull(CO.ZonaID, 0)
		FROM dbo.Usuario U WITH(NOLOCK)
		LEFT JOIN ods.Consultora co WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE U.CODIGOCONSULTORA = @ValorIngresado OR U.DOCUMENTOIDENTIDAD = @ValorIngresado
		ORDER BY U.EMailActivo DESC
	END

	SELECT
			@Cantidad as Cantidad,
			@CodigoUsuario as CodigoUsuario,
			@CodigoConsultora as CodigoConsultora,
			@PrimerNombre as PrimerNombre,
			@IdEstadoActividad as IdEstadoActividad,
			@Celular as Celular,
			@Correo as Correo,
			@ZonaID as ZonaID
	SET NOCOUNT OFF
END
GO

USE BelcorpCostaRica
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'GetUsuarioOlvideContrasenia')
BEGIN
	DROP PROC [dbo].[GetUsuarioOlvideContrasenia]
END
GO
-- [dbo].[GetUsuarioOlvideContrasenia] '0012329',2
CREATE PROCEDURE [dbo].[GetUsuarioOlvideContrasenia]
	@ValorIngresado VARCHAR(20),
	@PaisID	INT
AS
BEGIN	
	SET NOCOUNT ON

	DECLARE @Cantidad int = 0
	DECLARE @CodigoUsuario varchar(20)
	DECLARE @CodigoConsultora varchar(20)
	DECLARE @PrimerNombre varchar(30)
	DECLARE @IdEstadoActividad int
	DECLARE @Celular varchar(20)
	DECLARE @Correo	varchar(80)	
	DECLARE @ZonaID int

	IF (@PaisID = 3 OR @PaisID = 4 OR @PaisID = 6)
	BEGIN
		SELECT TOP 1
			@Cantidad = 1,
			@CodigoUsuario = IsNull(U.CodigoUsuario, ''),
			@CodigoConsultora = IsNull(CO.Codigo, ''),
			@PrimerNombre = substring(ISNULL(CO.PrimerNombre, ''),1,1) + lower(substring(ISNULL(CO.PrimerNombre, ''),2, Len(CO.PrimerNombre))),
			@IdEstadoActividad = IsNull(CO.IdEstadoActividad, ''),
			@Celular = IsNull(U.Celular, ''),
			@Correo = IsNull(U.EMail, ''),
			@ZonaID = IsNull(CO.ZonaID, 0)
		FROM dbo.Usuario U WITH(NOLOCK)
		LEFT JOIN ods.Consultora CO WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE U.DOCUMENTOIDENTIDAD = @ValorIngresado
		ORDER BY U.EMailActivo DESC		
	END
	ELSE
	BEGIN
		SELECT TOP 1
			@Cantidad = 1,
			@CodigoUsuario = IsNull(U.CodigoUsuario, ''),
			@CodigoConsultora = IsNull(CO.Codigo, ''),
			@PrimerNombre = substring(ISNULL(CO.PrimerNombre, ''),1,1) + lower(substring(ISNULL(CO.PrimerNombre, ''),2, Len(CO.PrimerNombre))),
			@IdEstadoActividad = IsNull(CO.IdEstadoActividad, ''),
			@Celular = IsNull(U.Celular, ''),
			@Correo = IsNull(U.EMail, ''),
			@ZonaID = Isnull(CO.ZonaID, 0)
		FROM dbo.Usuario U WITH(NOLOCK)
		LEFT JOIN ods.Consultora co WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE U.CODIGOCONSULTORA = @ValorIngresado OR U.DOCUMENTOIDENTIDAD = @ValorIngresado
		ORDER BY U.EMailActivo DESC
	END

	SELECT
			@Cantidad as Cantidad,
			@CodigoUsuario as CodigoUsuario,
			@CodigoConsultora as CodigoConsultora,
			@PrimerNombre as PrimerNombre,
			@IdEstadoActividad as IdEstadoActividad,
			@Celular as Celular,
			@Correo as Correo,
			@ZonaID as ZonaID
	SET NOCOUNT OFF
END
GO

USE BelcorpChile
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'GetUsuarioOlvideContrasenia')
BEGIN
	DROP PROC [dbo].[GetUsuarioOlvideContrasenia]
END
GO
-- [dbo].[GetUsuarioOlvideContrasenia] '0012329',2
CREATE PROCEDURE [dbo].[GetUsuarioOlvideContrasenia]
	@ValorIngresado VARCHAR(20),
	@PaisID	INT
AS
BEGIN	
	SET NOCOUNT ON

	DECLARE @Cantidad int = 0
	DECLARE @CodigoUsuario varchar(20)
	DECLARE @CodigoConsultora varchar(20)
	DECLARE @PrimerNombre varchar(30)
	DECLARE @IdEstadoActividad int
	DECLARE @Celular varchar(20)
	DECLARE @Correo	varchar(80)	
	DECLARE @ZonaID int

	IF (@PaisID = 3 OR @PaisID = 4 OR @PaisID = 6)
	BEGIN
		SELECT TOP 1
			@Cantidad = 1,
			@CodigoUsuario = IsNull(U.CodigoUsuario, ''),
			@CodigoConsultora = IsNull(CO.Codigo, ''),
			@PrimerNombre = substring(ISNULL(CO.PrimerNombre, ''),1,1) + lower(substring(ISNULL(CO.PrimerNombre, ''),2, Len(CO.PrimerNombre))),
			@IdEstadoActividad = IsNull(CO.IdEstadoActividad, ''),
			@Celular = IsNull(U.Celular, ''),
			@Correo = IsNull(U.EMail, ''),
			@ZonaID = IsNull(CO.ZonaID, 0)
		FROM dbo.Usuario U WITH(NOLOCK)
		LEFT JOIN ods.Consultora CO WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE U.DOCUMENTOIDENTIDAD = @ValorIngresado
		ORDER BY U.EMailActivo DESC		
	END
	ELSE
	BEGIN
		SELECT TOP 1
			@Cantidad = 1,
			@CodigoUsuario = IsNull(U.CodigoUsuario, ''),
			@CodigoConsultora = IsNull(CO.Codigo, ''),
			@PrimerNombre = substring(ISNULL(CO.PrimerNombre, ''),1,1) + lower(substring(ISNULL(CO.PrimerNombre, ''),2, Len(CO.PrimerNombre))),
			@IdEstadoActividad = IsNull(CO.IdEstadoActividad, ''),
			@Celular = IsNull(U.Celular, ''),
			@Correo = IsNull(U.EMail, ''),
			@ZonaID = Isnull(CO.ZonaID, 0)
		FROM dbo.Usuario U WITH(NOLOCK)
		LEFT JOIN ods.Consultora co WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE U.CODIGOCONSULTORA = @ValorIngresado OR U.DOCUMENTOIDENTIDAD = @ValorIngresado
		ORDER BY U.EMailActivo DESC
	END

	SELECT
			@Cantidad as Cantidad,
			@CodigoUsuario as CodigoUsuario,
			@CodigoConsultora as CodigoConsultora,
			@PrimerNombre as PrimerNombre,
			@IdEstadoActividad as IdEstadoActividad,
			@Celular as Celular,
			@Correo as Correo,
			@ZonaID as ZonaID
	SET NOCOUNT OFF
END
GO

USE BelcorpBolivia
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'GetUsuarioOlvideContrasenia')
BEGIN
	DROP PROC [dbo].[GetUsuarioOlvideContrasenia]
END
GO
-- [dbo].[GetUsuarioOlvideContrasenia] '0012329',2
CREATE PROCEDURE [dbo].[GetUsuarioOlvideContrasenia]
	@ValorIngresado VARCHAR(20),
	@PaisID	INT
AS
BEGIN	
	SET NOCOUNT ON

	DECLARE @Cantidad int = 0
	DECLARE @CodigoUsuario varchar(20)
	DECLARE @CodigoConsultora varchar(20)
	DECLARE @PrimerNombre varchar(30)
	DECLARE @IdEstadoActividad int
	DECLARE @Celular varchar(20)
	DECLARE @Correo	varchar(80)	
	DECLARE @ZonaID int

	IF (@PaisID = 3 OR @PaisID = 4 OR @PaisID = 6)
	BEGIN
		SELECT TOP 1
			@Cantidad = 1,
			@CodigoUsuario = IsNull(U.CodigoUsuario, ''),
			@CodigoConsultora = IsNull(CO.Codigo, ''),
			@PrimerNombre = substring(ISNULL(CO.PrimerNombre, ''),1,1) + lower(substring(ISNULL(CO.PrimerNombre, ''),2, Len(CO.PrimerNombre))),
			@IdEstadoActividad = IsNull(CO.IdEstadoActividad, ''),
			@Celular = IsNull(U.Celular, ''),
			@Correo = IsNull(U.EMail, ''),
			@ZonaID = IsNull(CO.ZonaID, 0)
		FROM dbo.Usuario U WITH(NOLOCK)
		LEFT JOIN ods.Consultora CO WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE U.DOCUMENTOIDENTIDAD = @ValorIngresado
		ORDER BY U.EMailActivo DESC		
	END
	ELSE
	BEGIN
		SELECT TOP 1
			@Cantidad = 1,
			@CodigoUsuario = IsNull(U.CodigoUsuario, ''),
			@CodigoConsultora = IsNull(CO.Codigo, ''),
			@PrimerNombre = substring(ISNULL(CO.PrimerNombre, ''),1,1) + lower(substring(ISNULL(CO.PrimerNombre, ''),2, Len(CO.PrimerNombre))),
			@IdEstadoActividad = IsNull(CO.IdEstadoActividad, ''),
			@Celular = IsNull(U.Celular, ''),
			@Correo = IsNull(U.EMail, ''),
			@ZonaID = Isnull(CO.ZonaID, 0)
		FROM dbo.Usuario U WITH(NOLOCK)
		LEFT JOIN ods.Consultora co WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE U.CODIGOCONSULTORA = @ValorIngresado OR U.DOCUMENTOIDENTIDAD = @ValorIngresado
		ORDER BY U.EMailActivo DESC
	END

	SELECT
			@Cantidad as Cantidad,
			@CodigoUsuario as CodigoUsuario,
			@CodigoConsultora as CodigoConsultora,
			@PrimerNombre as PrimerNombre,
			@IdEstadoActividad as IdEstadoActividad,
			@Celular as Celular,
			@Correo as Correo,
			@ZonaID as ZonaID
	SET NOCOUNT OFF
END
GO

