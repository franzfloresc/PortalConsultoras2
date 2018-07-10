USE BelcorpPeru
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'GetUsuarioVerificacionAutenticidad')
BEGIN
	DROP PROC [dbo].[GetUsuarioVerificacionAutenticidad]
END
GO
CREATE PROCEDURE [dbo].[GetUsuarioVerificacionAutenticidad]
	@CodigoUsuario VARCHAR(20),
	@PaisID	INT
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

	IF (@PaisID = 3 OR @PaisID = 4 OR @PaisID = 6)
	BEGIN

		If Exists (Select 1 From Usuario U WITH(NOLOCK)
		inner join ods.Consultora C WITH(NOLOCK) ON U.CodigoConsultora = C.Codigo Where U.DOCUMENTOIDENTIDAD = @CodigoUsuario 
		And C.IdEstadoActividad = 8 And U.VerificacionEstadoActividad = 7)
		begin
			Update Usuario set VerificacionEstadoActividad = 1 Where DOCUMENTOIDENTIDAD = @CodigoUsuario 
		end

		SELECT TOP 1
			@Cantidad = 1,
			@PrimerNombre = substring(ISNULL(CO.PrimerNombre, ''),1,1) + lower(substring(ISNULL(CO.PrimerNombre, ''),2, Len(CO.PrimerNombre))),
			@IdEstadoActividad = IsNull(CO.IdEstadoActividad, ''),
			@Celular = IsNull(U.Celular, ''),
			@Correo = IsNull(U.EMail, ''),
			@RegionID = IsNull(RegionID,0),
			@ZonaID = IsNull(CO.ZonaID, 0)
		FROM dbo.Usuario U WITH(NOLOCK)
		LEFT JOIN ods.Consultora CO WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE U.DOCUMENTOIDENTIDAD = @CodigoUsuario
		And CO.IdEstadoActividad != IsNull(U.VerificacionEstadoActividad, 0)
		ORDER BY U.EMailActivo DESC		
	END
	ELSE
	BEGIN

		If Exists (Select 1 From Usuario U WITH(NOLOCK)
		inner join ods.Consultora C WITH(NOLOCK) ON U.CodigoConsultora = C.Codigo Where (U.CODIGOCONSULTORA = @CodigoUsuario OR U.DOCUMENTOIDENTIDAD = @CodigoUsuario)
		And C.IdEstadoActividad = 8 And U.VerificacionEstadoActividad = 7)
		begin
			Update Usuario set VerificacionEstadoActividad = 1 Where CODIGOCONSULTORA = @CodigoUsuario OR DOCUMENTOIDENTIDAD = @CodigoUsuario
		end

		SELECT TOP 1
			@Cantidad = 1,
			@PrimerNombre = substring(ISNULL(CO.PrimerNombre, ''),1,1) + lower(substring(ISNULL(CO.PrimerNombre, ''),2, Len(CO.PrimerNombre))),
			@IdEstadoActividad = IsNull(CO.IdEstadoActividad, ''),
			@Celular = IsNull(U.Celular, ''),
			@Correo = IsNull(U.EMail, ''),
			@RegionID = IsNull(RegionID,0),
			@ZonaID = Isnull(CO.ZonaID, 0)
		FROM dbo.Usuario U WITH(NOLOCK)
		LEFT JOIN ods.Consultora co WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE (U.CODIGOCONSULTORA = @CodigoUsuario OR U.DOCUMENTOIDENTIDAD = @CodigoUsuario)
		And CO.IdEstadoActividad != IsNull(U.VerificacionEstadoActividad, 0)
		ORDER BY U.EMailActivo DESC
	END

	SELECT
			@Cantidad as Cantidad,
			@PrimerNombre as PrimerNombre,
			@IdEstadoActividad as IdEstadoActividad,
			@Celular as Celular,
			@Correo as Correo,
			@RegionID as RegionID,
			@ZonaID as ZonaID
	SET NOCOUNT OFF
END
GO

USE BelcorpMexico
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'GetUsuarioVerificacionAutenticidad')
BEGIN
	DROP PROC [dbo].[GetUsuarioVerificacionAutenticidad]
END
GO
CREATE PROCEDURE [dbo].[GetUsuarioVerificacionAutenticidad]
	@CodigoUsuario VARCHAR(20),
	@PaisID	INT
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

	IF (@PaisID = 3 OR @PaisID = 4 OR @PaisID = 6)
	BEGIN

		If Exists (Select 1 From Usuario U WITH(NOLOCK)
		inner join ods.Consultora C WITH(NOLOCK) ON U.CodigoConsultora = C.Codigo Where U.DOCUMENTOIDENTIDAD = @CodigoUsuario 
		And C.IdEstadoActividad = 8 And U.VerificacionEstadoActividad = 7)
		begin
			Update Usuario set VerificacionEstadoActividad = 1 Where DOCUMENTOIDENTIDAD = @CodigoUsuario 
		end

		SELECT TOP 1
			@Cantidad = 1,
			@PrimerNombre = substring(ISNULL(CO.PrimerNombre, ''),1,1) + lower(substring(ISNULL(CO.PrimerNombre, ''),2, Len(CO.PrimerNombre))),
			@IdEstadoActividad = IsNull(CO.IdEstadoActividad, ''),
			@Celular = IsNull(U.Celular, ''),
			@Correo = IsNull(U.EMail, ''),
			@RegionID = IsNull(RegionID,0),
			@ZonaID = IsNull(CO.ZonaID, 0)
		FROM dbo.Usuario U WITH(NOLOCK)
		LEFT JOIN ods.Consultora CO WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE U.DOCUMENTOIDENTIDAD = @CodigoUsuario
		And CO.IdEstadoActividad != IsNull(U.VerificacionEstadoActividad, 0)
		ORDER BY U.EMailActivo DESC		
	END
	ELSE
	BEGIN

		If Exists (Select 1 From Usuario U WITH(NOLOCK)
		inner join ods.Consultora C WITH(NOLOCK) ON U.CodigoConsultora = C.Codigo Where (U.CODIGOCONSULTORA = @CodigoUsuario OR U.DOCUMENTOIDENTIDAD = @CodigoUsuario)
		And C.IdEstadoActividad = 8 And U.VerificacionEstadoActividad = 7)
		begin
			Update Usuario set VerificacionEstadoActividad = 1 Where CODIGOCONSULTORA = @CodigoUsuario OR DOCUMENTOIDENTIDAD = @CodigoUsuario
		end

		SELECT TOP 1
			@Cantidad = 1,
			@PrimerNombre = substring(ISNULL(CO.PrimerNombre, ''),1,1) + lower(substring(ISNULL(CO.PrimerNombre, ''),2, Len(CO.PrimerNombre))),
			@IdEstadoActividad = IsNull(CO.IdEstadoActividad, ''),
			@Celular = IsNull(U.Celular, ''),
			@Correo = IsNull(U.EMail, ''),
			@RegionID = IsNull(RegionID,0),
			@ZonaID = Isnull(CO.ZonaID, 0)
		FROM dbo.Usuario U WITH(NOLOCK)
		LEFT JOIN ods.Consultora co WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE (U.CODIGOCONSULTORA = @CodigoUsuario OR U.DOCUMENTOIDENTIDAD = @CodigoUsuario)
		And CO.IdEstadoActividad != IsNull(U.VerificacionEstadoActividad, 0)
		ORDER BY U.EMailActivo DESC
	END

	SELECT
			@Cantidad as Cantidad,
			@PrimerNombre as PrimerNombre,
			@IdEstadoActividad as IdEstadoActividad,
			@Celular as Celular,
			@Correo as Correo,
			@RegionID as RegionID,
			@ZonaID as ZonaID
	SET NOCOUNT OFF
END
GO

USE BelcorpColombia
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'GetUsuarioVerificacionAutenticidad')
BEGIN
	DROP PROC [dbo].[GetUsuarioVerificacionAutenticidad]
END
GO
CREATE PROCEDURE [dbo].[GetUsuarioVerificacionAutenticidad]
	@CodigoUsuario VARCHAR(20),
	@PaisID	INT
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

	IF (@PaisID = 3 OR @PaisID = 4 OR @PaisID = 6)
	BEGIN

		If Exists (Select 1 From Usuario U WITH(NOLOCK)
		inner join ods.Consultora C WITH(NOLOCK) ON U.CodigoConsultora = C.Codigo Where U.DOCUMENTOIDENTIDAD = @CodigoUsuario 
		And C.IdEstadoActividad = 8 And U.VerificacionEstadoActividad = 7)
		begin
			Update Usuario set VerificacionEstadoActividad = 1 Where DOCUMENTOIDENTIDAD = @CodigoUsuario 
		end

		SELECT TOP 1
			@Cantidad = 1,
			@PrimerNombre = substring(ISNULL(CO.PrimerNombre, ''),1,1) + lower(substring(ISNULL(CO.PrimerNombre, ''),2, Len(CO.PrimerNombre))),
			@IdEstadoActividad = IsNull(CO.IdEstadoActividad, ''),
			@Celular = IsNull(U.Celular, ''),
			@Correo = IsNull(U.EMail, ''),
			@RegionID = IsNull(RegionID,0),
			@ZonaID = IsNull(CO.ZonaID, 0)
		FROM dbo.Usuario U WITH(NOLOCK)
		LEFT JOIN ods.Consultora CO WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE U.DOCUMENTOIDENTIDAD = @CodigoUsuario
		And CO.IdEstadoActividad != IsNull(U.VerificacionEstadoActividad, 0)
		ORDER BY U.EMailActivo DESC		
	END
	ELSE
	BEGIN

		If Exists (Select 1 From Usuario U WITH(NOLOCK)
		inner join ods.Consultora C WITH(NOLOCK) ON U.CodigoConsultora = C.Codigo Where (U.CODIGOCONSULTORA = @CodigoUsuario OR U.DOCUMENTOIDENTIDAD = @CodigoUsuario)
		And C.IdEstadoActividad = 8 And U.VerificacionEstadoActividad = 7)
		begin
			Update Usuario set VerificacionEstadoActividad = 1 Where CODIGOCONSULTORA = @CodigoUsuario OR DOCUMENTOIDENTIDAD = @CodigoUsuario
		end

		SELECT TOP 1
			@Cantidad = 1,
			@PrimerNombre = substring(ISNULL(CO.PrimerNombre, ''),1,1) + lower(substring(ISNULL(CO.PrimerNombre, ''),2, Len(CO.PrimerNombre))),
			@IdEstadoActividad = IsNull(CO.IdEstadoActividad, ''),
			@Celular = IsNull(U.Celular, ''),
			@Correo = IsNull(U.EMail, ''),
			@RegionID = IsNull(RegionID,0),
			@ZonaID = Isnull(CO.ZonaID, 0)
		FROM dbo.Usuario U WITH(NOLOCK)
		LEFT JOIN ods.Consultora co WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE (U.CODIGOCONSULTORA = @CodigoUsuario OR U.DOCUMENTOIDENTIDAD = @CodigoUsuario)
		And CO.IdEstadoActividad != IsNull(U.VerificacionEstadoActividad, 0)
		ORDER BY U.EMailActivo DESC
	END

	SELECT
			@Cantidad as Cantidad,
			@PrimerNombre as PrimerNombre,
			@IdEstadoActividad as IdEstadoActividad,
			@Celular as Celular,
			@Correo as Correo,
			@RegionID as RegionID,
			@ZonaID as ZonaID
	SET NOCOUNT OFF
END
GO

USE BelcorpSalvador
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'GetUsuarioVerificacionAutenticidad')
BEGIN
	DROP PROC [dbo].[GetUsuarioVerificacionAutenticidad]
END
GO
CREATE PROCEDURE [dbo].[GetUsuarioVerificacionAutenticidad]
	@CodigoUsuario VARCHAR(20),
	@PaisID	INT
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

	IF (@PaisID = 3 OR @PaisID = 4 OR @PaisID = 6)
	BEGIN

		If Exists (Select 1 From Usuario U WITH(NOLOCK)
		inner join ods.Consultora C WITH(NOLOCK) ON U.CodigoConsultora = C.Codigo Where U.DOCUMENTOIDENTIDAD = @CodigoUsuario 
		And C.IdEstadoActividad = 8 And U.VerificacionEstadoActividad = 7)
		begin
			Update Usuario set VerificacionEstadoActividad = 1 Where DOCUMENTOIDENTIDAD = @CodigoUsuario 
		end

		SELECT TOP 1
			@Cantidad = 1,
			@PrimerNombre = substring(ISNULL(CO.PrimerNombre, ''),1,1) + lower(substring(ISNULL(CO.PrimerNombre, ''),2, Len(CO.PrimerNombre))),
			@IdEstadoActividad = IsNull(CO.IdEstadoActividad, ''),
			@Celular = IsNull(U.Celular, ''),
			@Correo = IsNull(U.EMail, ''),
			@RegionID = IsNull(RegionID,0),
			@ZonaID = IsNull(CO.ZonaID, 0)
		FROM dbo.Usuario U WITH(NOLOCK)
		LEFT JOIN ods.Consultora CO WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE U.DOCUMENTOIDENTIDAD = @CodigoUsuario
		And CO.IdEstadoActividad != IsNull(U.VerificacionEstadoActividad, 0)
		ORDER BY U.EMailActivo DESC		
	END
	ELSE
	BEGIN

		If Exists (Select 1 From Usuario U WITH(NOLOCK)
		inner join ods.Consultora C WITH(NOLOCK) ON U.CodigoConsultora = C.Codigo Where (U.CODIGOCONSULTORA = @CodigoUsuario OR U.DOCUMENTOIDENTIDAD = @CodigoUsuario)
		And C.IdEstadoActividad = 8 And U.VerificacionEstadoActividad = 7)
		begin
			Update Usuario set VerificacionEstadoActividad = 1 Where CODIGOCONSULTORA = @CodigoUsuario OR DOCUMENTOIDENTIDAD = @CodigoUsuario
		end

		SELECT TOP 1
			@Cantidad = 1,
			@PrimerNombre = substring(ISNULL(CO.PrimerNombre, ''),1,1) + lower(substring(ISNULL(CO.PrimerNombre, ''),2, Len(CO.PrimerNombre))),
			@IdEstadoActividad = IsNull(CO.IdEstadoActividad, ''),
			@Celular = IsNull(U.Celular, ''),
			@Correo = IsNull(U.EMail, ''),
			@RegionID = IsNull(RegionID,0),
			@ZonaID = Isnull(CO.ZonaID, 0)
		FROM dbo.Usuario U WITH(NOLOCK)
		LEFT JOIN ods.Consultora co WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE (U.CODIGOCONSULTORA = @CodigoUsuario OR U.DOCUMENTOIDENTIDAD = @CodigoUsuario)
		And CO.IdEstadoActividad != IsNull(U.VerificacionEstadoActividad, 0)
		ORDER BY U.EMailActivo DESC
	END

	SELECT
			@Cantidad as Cantidad,
			@PrimerNombre as PrimerNombre,
			@IdEstadoActividad as IdEstadoActividad,
			@Celular as Celular,
			@Correo as Correo,
			@RegionID as RegionID,
			@ZonaID as ZonaID
	SET NOCOUNT OFF
END
GO

USE BelcorpPuertoRico
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'GetUsuarioVerificacionAutenticidad')
BEGIN
	DROP PROC [dbo].[GetUsuarioVerificacionAutenticidad]
END
GO
CREATE PROCEDURE [dbo].[GetUsuarioVerificacionAutenticidad]
	@CodigoUsuario VARCHAR(20),
	@PaisID	INT
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

	IF (@PaisID = 3 OR @PaisID = 4 OR @PaisID = 6)
	BEGIN

		If Exists (Select 1 From Usuario U WITH(NOLOCK)
		inner join ods.Consultora C WITH(NOLOCK) ON U.CodigoConsultora = C.Codigo Where U.DOCUMENTOIDENTIDAD = @CodigoUsuario 
		And C.IdEstadoActividad = 8 And U.VerificacionEstadoActividad = 7)
		begin
			Update Usuario set VerificacionEstadoActividad = 1 Where DOCUMENTOIDENTIDAD = @CodigoUsuario 
		end

		SELECT TOP 1
			@Cantidad = 1,
			@PrimerNombre = substring(ISNULL(CO.PrimerNombre, ''),1,1) + lower(substring(ISNULL(CO.PrimerNombre, ''),2, Len(CO.PrimerNombre))),
			@IdEstadoActividad = IsNull(CO.IdEstadoActividad, ''),
			@Celular = IsNull(U.Celular, ''),
			@Correo = IsNull(U.EMail, ''),
			@RegionID = IsNull(RegionID,0),
			@ZonaID = IsNull(CO.ZonaID, 0)
		FROM dbo.Usuario U WITH(NOLOCK)
		LEFT JOIN ods.Consultora CO WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE U.DOCUMENTOIDENTIDAD = @CodigoUsuario
		And CO.IdEstadoActividad != IsNull(U.VerificacionEstadoActividad, 0)
		ORDER BY U.EMailActivo DESC		
	END
	ELSE
	BEGIN

		If Exists (Select 1 From Usuario U WITH(NOLOCK)
		inner join ods.Consultora C WITH(NOLOCK) ON U.CodigoConsultora = C.Codigo Where (U.CODIGOCONSULTORA = @CodigoUsuario OR U.DOCUMENTOIDENTIDAD = @CodigoUsuario)
		And C.IdEstadoActividad = 8 And U.VerificacionEstadoActividad = 7)
		begin
			Update Usuario set VerificacionEstadoActividad = 1 Where CODIGOCONSULTORA = @CodigoUsuario OR DOCUMENTOIDENTIDAD = @CodigoUsuario
		end

		SELECT TOP 1
			@Cantidad = 1,
			@PrimerNombre = substring(ISNULL(CO.PrimerNombre, ''),1,1) + lower(substring(ISNULL(CO.PrimerNombre, ''),2, Len(CO.PrimerNombre))),
			@IdEstadoActividad = IsNull(CO.IdEstadoActividad, ''),
			@Celular = IsNull(U.Celular, ''),
			@Correo = IsNull(U.EMail, ''),
			@RegionID = IsNull(RegionID,0),
			@ZonaID = Isnull(CO.ZonaID, 0)
		FROM dbo.Usuario U WITH(NOLOCK)
		LEFT JOIN ods.Consultora co WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE (U.CODIGOCONSULTORA = @CodigoUsuario OR U.DOCUMENTOIDENTIDAD = @CodigoUsuario)
		And CO.IdEstadoActividad != IsNull(U.VerificacionEstadoActividad, 0)
		ORDER BY U.EMailActivo DESC
	END

	SELECT
			@Cantidad as Cantidad,
			@PrimerNombre as PrimerNombre,
			@IdEstadoActividad as IdEstadoActividad,
			@Celular as Celular,
			@Correo as Correo,
			@RegionID as RegionID,
			@ZonaID as ZonaID
	SET NOCOUNT OFF
END
GO

USE BelcorpPanama
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'GetUsuarioVerificacionAutenticidad')
BEGIN
	DROP PROC [dbo].[GetUsuarioVerificacionAutenticidad]
END
GO
CREATE PROCEDURE [dbo].[GetUsuarioVerificacionAutenticidad]
	@CodigoUsuario VARCHAR(20),
	@PaisID	INT
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

	IF (@PaisID = 3 OR @PaisID = 4 OR @PaisID = 6)
	BEGIN

		If Exists (Select 1 From Usuario U WITH(NOLOCK)
		inner join ods.Consultora C WITH(NOLOCK) ON U.CodigoConsultora = C.Codigo Where U.DOCUMENTOIDENTIDAD = @CodigoUsuario 
		And C.IdEstadoActividad = 8 And U.VerificacionEstadoActividad = 7)
		begin
			Update Usuario set VerificacionEstadoActividad = 1 Where DOCUMENTOIDENTIDAD = @CodigoUsuario 
		end

		SELECT TOP 1
			@Cantidad = 1,
			@PrimerNombre = substring(ISNULL(CO.PrimerNombre, ''),1,1) + lower(substring(ISNULL(CO.PrimerNombre, ''),2, Len(CO.PrimerNombre))),
			@IdEstadoActividad = IsNull(CO.IdEstadoActividad, ''),
			@Celular = IsNull(U.Celular, ''),
			@Correo = IsNull(U.EMail, ''),
			@RegionID = IsNull(RegionID,0),
			@ZonaID = IsNull(CO.ZonaID, 0)
		FROM dbo.Usuario U WITH(NOLOCK)
		LEFT JOIN ods.Consultora CO WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE U.DOCUMENTOIDENTIDAD = @CodigoUsuario
		And CO.IdEstadoActividad != IsNull(U.VerificacionEstadoActividad, 0)
		ORDER BY U.EMailActivo DESC		
	END
	ELSE
	BEGIN

		If Exists (Select 1 From Usuario U WITH(NOLOCK)
		inner join ods.Consultora C WITH(NOLOCK) ON U.CodigoConsultora = C.Codigo Where (U.CODIGOCONSULTORA = @CodigoUsuario OR U.DOCUMENTOIDENTIDAD = @CodigoUsuario)
		And C.IdEstadoActividad = 8 And U.VerificacionEstadoActividad = 7)
		begin
			Update Usuario set VerificacionEstadoActividad = 1 Where CODIGOCONSULTORA = @CodigoUsuario OR DOCUMENTOIDENTIDAD = @CodigoUsuario
		end

		SELECT TOP 1
			@Cantidad = 1,
			@PrimerNombre = substring(ISNULL(CO.PrimerNombre, ''),1,1) + lower(substring(ISNULL(CO.PrimerNombre, ''),2, Len(CO.PrimerNombre))),
			@IdEstadoActividad = IsNull(CO.IdEstadoActividad, ''),
			@Celular = IsNull(U.Celular, ''),
			@Correo = IsNull(U.EMail, ''),
			@RegionID = IsNull(RegionID,0),
			@ZonaID = Isnull(CO.ZonaID, 0)
		FROM dbo.Usuario U WITH(NOLOCK)
		LEFT JOIN ods.Consultora co WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE (U.CODIGOCONSULTORA = @CodigoUsuario OR U.DOCUMENTOIDENTIDAD = @CodigoUsuario)
		And CO.IdEstadoActividad != IsNull(U.VerificacionEstadoActividad, 0)
		ORDER BY U.EMailActivo DESC
	END

	SELECT
			@Cantidad as Cantidad,
			@PrimerNombre as PrimerNombre,
			@IdEstadoActividad as IdEstadoActividad,
			@Celular as Celular,
			@Correo as Correo,
			@RegionID as RegionID,
			@ZonaID as ZonaID
	SET NOCOUNT OFF
END
GO

USE BelcorpGuatemala
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'GetUsuarioVerificacionAutenticidad')
BEGIN
	DROP PROC [dbo].[GetUsuarioVerificacionAutenticidad]
END
GO
CREATE PROCEDURE [dbo].[GetUsuarioVerificacionAutenticidad]
	@CodigoUsuario VARCHAR(20),
	@PaisID	INT
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

	IF (@PaisID = 3 OR @PaisID = 4 OR @PaisID = 6)
	BEGIN

		If Exists (Select 1 From Usuario U WITH(NOLOCK)
		inner join ods.Consultora C WITH(NOLOCK) ON U.CodigoConsultora = C.Codigo Where U.DOCUMENTOIDENTIDAD = @CodigoUsuario 
		And C.IdEstadoActividad = 8 And U.VerificacionEstadoActividad = 7)
		begin
			Update Usuario set VerificacionEstadoActividad = 1 Where DOCUMENTOIDENTIDAD = @CodigoUsuario 
		end

		SELECT TOP 1
			@Cantidad = 1,
			@PrimerNombre = substring(ISNULL(CO.PrimerNombre, ''),1,1) + lower(substring(ISNULL(CO.PrimerNombre, ''),2, Len(CO.PrimerNombre))),
			@IdEstadoActividad = IsNull(CO.IdEstadoActividad, ''),
			@Celular = IsNull(U.Celular, ''),
			@Correo = IsNull(U.EMail, ''),
			@RegionID = IsNull(RegionID,0),
			@ZonaID = IsNull(CO.ZonaID, 0)
		FROM dbo.Usuario U WITH(NOLOCK)
		LEFT JOIN ods.Consultora CO WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE U.DOCUMENTOIDENTIDAD = @CodigoUsuario
		And CO.IdEstadoActividad != IsNull(U.VerificacionEstadoActividad, 0)
		ORDER BY U.EMailActivo DESC		
	END
	ELSE
	BEGIN

		If Exists (Select 1 From Usuario U WITH(NOLOCK)
		inner join ods.Consultora C WITH(NOLOCK) ON U.CodigoConsultora = C.Codigo Where (U.CODIGOCONSULTORA = @CodigoUsuario OR U.DOCUMENTOIDENTIDAD = @CodigoUsuario)
		And C.IdEstadoActividad = 8 And U.VerificacionEstadoActividad = 7)
		begin
			Update Usuario set VerificacionEstadoActividad = 1 Where CODIGOCONSULTORA = @CodigoUsuario OR DOCUMENTOIDENTIDAD = @CodigoUsuario
		end

		SELECT TOP 1
			@Cantidad = 1,
			@PrimerNombre = substring(ISNULL(CO.PrimerNombre, ''),1,1) + lower(substring(ISNULL(CO.PrimerNombre, ''),2, Len(CO.PrimerNombre))),
			@IdEstadoActividad = IsNull(CO.IdEstadoActividad, ''),
			@Celular = IsNull(U.Celular, ''),
			@Correo = IsNull(U.EMail, ''),
			@RegionID = IsNull(RegionID,0),
			@ZonaID = Isnull(CO.ZonaID, 0)
		FROM dbo.Usuario U WITH(NOLOCK)
		LEFT JOIN ods.Consultora co WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE (U.CODIGOCONSULTORA = @CodigoUsuario OR U.DOCUMENTOIDENTIDAD = @CodigoUsuario)
		And CO.IdEstadoActividad != IsNull(U.VerificacionEstadoActividad, 0)
		ORDER BY U.EMailActivo DESC
	END

	SELECT
			@Cantidad as Cantidad,
			@PrimerNombre as PrimerNombre,
			@IdEstadoActividad as IdEstadoActividad,
			@Celular as Celular,
			@Correo as Correo,
			@RegionID as RegionID,
			@ZonaID as ZonaID
	SET NOCOUNT OFF
END
GO

USE BelcorpEcuador
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'GetUsuarioVerificacionAutenticidad')
BEGIN
	DROP PROC [dbo].[GetUsuarioVerificacionAutenticidad]
END
GO
CREATE PROCEDURE [dbo].[GetUsuarioVerificacionAutenticidad]
	@CodigoUsuario VARCHAR(20),
	@PaisID	INT
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

	IF (@PaisID = 3 OR @PaisID = 4 OR @PaisID = 6)
	BEGIN

		If Exists (Select 1 From Usuario U WITH(NOLOCK)
		inner join ods.Consultora C WITH(NOLOCK) ON U.CodigoConsultora = C.Codigo Where U.DOCUMENTOIDENTIDAD = @CodigoUsuario 
		And C.IdEstadoActividad = 8 And U.VerificacionEstadoActividad = 7)
		begin
			Update Usuario set VerificacionEstadoActividad = 1 Where DOCUMENTOIDENTIDAD = @CodigoUsuario 
		end

		SELECT TOP 1
			@Cantidad = 1,
			@PrimerNombre = substring(ISNULL(CO.PrimerNombre, ''),1,1) + lower(substring(ISNULL(CO.PrimerNombre, ''),2, Len(CO.PrimerNombre))),
			@IdEstadoActividad = IsNull(CO.IdEstadoActividad, ''),
			@Celular = IsNull(U.Celular, ''),
			@Correo = IsNull(U.EMail, ''),
			@RegionID = IsNull(RegionID,0),
			@ZonaID = IsNull(CO.ZonaID, 0)
		FROM dbo.Usuario U WITH(NOLOCK)
		LEFT JOIN ods.Consultora CO WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE U.DOCUMENTOIDENTIDAD = @CodigoUsuario
		And CO.IdEstadoActividad != IsNull(U.VerificacionEstadoActividad, 0)
		ORDER BY U.EMailActivo DESC		
	END
	ELSE
	BEGIN

		If Exists (Select 1 From Usuario U WITH(NOLOCK)
		inner join ods.Consultora C WITH(NOLOCK) ON U.CodigoConsultora = C.Codigo Where (U.CODIGOCONSULTORA = @CodigoUsuario OR U.DOCUMENTOIDENTIDAD = @CodigoUsuario)
		And C.IdEstadoActividad = 8 And U.VerificacionEstadoActividad = 7)
		begin
			Update Usuario set VerificacionEstadoActividad = 1 Where CODIGOCONSULTORA = @CodigoUsuario OR DOCUMENTOIDENTIDAD = @CodigoUsuario
		end

		SELECT TOP 1
			@Cantidad = 1,
			@PrimerNombre = substring(ISNULL(CO.PrimerNombre, ''),1,1) + lower(substring(ISNULL(CO.PrimerNombre, ''),2, Len(CO.PrimerNombre))),
			@IdEstadoActividad = IsNull(CO.IdEstadoActividad, ''),
			@Celular = IsNull(U.Celular, ''),
			@Correo = IsNull(U.EMail, ''),
			@RegionID = IsNull(RegionID,0),
			@ZonaID = Isnull(CO.ZonaID, 0)
		FROM dbo.Usuario U WITH(NOLOCK)
		LEFT JOIN ods.Consultora co WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE (U.CODIGOCONSULTORA = @CodigoUsuario OR U.DOCUMENTOIDENTIDAD = @CodigoUsuario)
		And CO.IdEstadoActividad != IsNull(U.VerificacionEstadoActividad, 0)
		ORDER BY U.EMailActivo DESC
	END

	SELECT
			@Cantidad as Cantidad,
			@PrimerNombre as PrimerNombre,
			@IdEstadoActividad as IdEstadoActividad,
			@Celular as Celular,
			@Correo as Correo,
			@RegionID as RegionID,
			@ZonaID as ZonaID
	SET NOCOUNT OFF
END
GO

USE BelcorpDominicana
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'GetUsuarioVerificacionAutenticidad')
BEGIN
	DROP PROC [dbo].[GetUsuarioVerificacionAutenticidad]
END
GO
CREATE PROCEDURE [dbo].[GetUsuarioVerificacionAutenticidad]
	@CodigoUsuario VARCHAR(20),
	@PaisID	INT
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

	IF (@PaisID = 3 OR @PaisID = 4 OR @PaisID = 6)
	BEGIN

		If Exists (Select 1 From Usuario U WITH(NOLOCK)
		inner join ods.Consultora C WITH(NOLOCK) ON U.CodigoConsultora = C.Codigo Where U.DOCUMENTOIDENTIDAD = @CodigoUsuario 
		And C.IdEstadoActividad = 8 And U.VerificacionEstadoActividad = 7)
		begin
			Update Usuario set VerificacionEstadoActividad = 1 Where DOCUMENTOIDENTIDAD = @CodigoUsuario 
		end

		SELECT TOP 1
			@Cantidad = 1,
			@PrimerNombre = substring(ISNULL(CO.PrimerNombre, ''),1,1) + lower(substring(ISNULL(CO.PrimerNombre, ''),2, Len(CO.PrimerNombre))),
			@IdEstadoActividad = IsNull(CO.IdEstadoActividad, ''),
			@Celular = IsNull(U.Celular, ''),
			@Correo = IsNull(U.EMail, ''),
			@RegionID = IsNull(RegionID,0),
			@ZonaID = IsNull(CO.ZonaID, 0)
		FROM dbo.Usuario U WITH(NOLOCK)
		LEFT JOIN ods.Consultora CO WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE U.DOCUMENTOIDENTIDAD = @CodigoUsuario
		And CO.IdEstadoActividad != IsNull(U.VerificacionEstadoActividad, 0)
		ORDER BY U.EMailActivo DESC		
	END
	ELSE
	BEGIN

		If Exists (Select 1 From Usuario U WITH(NOLOCK)
		inner join ods.Consultora C WITH(NOLOCK) ON U.CodigoConsultora = C.Codigo Where (U.CODIGOCONSULTORA = @CodigoUsuario OR U.DOCUMENTOIDENTIDAD = @CodigoUsuario)
		And C.IdEstadoActividad = 8 And U.VerificacionEstadoActividad = 7)
		begin
			Update Usuario set VerificacionEstadoActividad = 1 Where CODIGOCONSULTORA = @CodigoUsuario OR DOCUMENTOIDENTIDAD = @CodigoUsuario
		end

		SELECT TOP 1
			@Cantidad = 1,
			@PrimerNombre = substring(ISNULL(CO.PrimerNombre, ''),1,1) + lower(substring(ISNULL(CO.PrimerNombre, ''),2, Len(CO.PrimerNombre))),
			@IdEstadoActividad = IsNull(CO.IdEstadoActividad, ''),
			@Celular = IsNull(U.Celular, ''),
			@Correo = IsNull(U.EMail, ''),
			@RegionID = IsNull(RegionID,0),
			@ZonaID = Isnull(CO.ZonaID, 0)
		FROM dbo.Usuario U WITH(NOLOCK)
		LEFT JOIN ods.Consultora co WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE (U.CODIGOCONSULTORA = @CodigoUsuario OR U.DOCUMENTOIDENTIDAD = @CodigoUsuario)
		And CO.IdEstadoActividad != IsNull(U.VerificacionEstadoActividad, 0)
		ORDER BY U.EMailActivo DESC
	END

	SELECT
			@Cantidad as Cantidad,
			@PrimerNombre as PrimerNombre,
			@IdEstadoActividad as IdEstadoActividad,
			@Celular as Celular,
			@Correo as Correo,
			@RegionID as RegionID,
			@ZonaID as ZonaID
	SET NOCOUNT OFF
END
GO

USE BelcorpCostaRica
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'GetUsuarioVerificacionAutenticidad')
BEGIN
	DROP PROC [dbo].[GetUsuarioVerificacionAutenticidad]
END
GO
CREATE PROCEDURE [dbo].[GetUsuarioVerificacionAutenticidad]
	@CodigoUsuario VARCHAR(20),
	@PaisID	INT
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

	IF (@PaisID = 3 OR @PaisID = 4 OR @PaisID = 6)
	BEGIN

		If Exists (Select 1 From Usuario U WITH(NOLOCK)
		inner join ods.Consultora C WITH(NOLOCK) ON U.CodigoConsultora = C.Codigo Where U.DOCUMENTOIDENTIDAD = @CodigoUsuario 
		And C.IdEstadoActividad = 8 And U.VerificacionEstadoActividad = 7)
		begin
			Update Usuario set VerificacionEstadoActividad = 1 Where DOCUMENTOIDENTIDAD = @CodigoUsuario 
		end

		SELECT TOP 1
			@Cantidad = 1,
			@PrimerNombre = substring(ISNULL(CO.PrimerNombre, ''),1,1) + lower(substring(ISNULL(CO.PrimerNombre, ''),2, Len(CO.PrimerNombre))),
			@IdEstadoActividad = IsNull(CO.IdEstadoActividad, ''),
			@Celular = IsNull(U.Celular, ''),
			@Correo = IsNull(U.EMail, ''),
			@RegionID = IsNull(RegionID,0),
			@ZonaID = IsNull(CO.ZonaID, 0)
		FROM dbo.Usuario U WITH(NOLOCK)
		LEFT JOIN ods.Consultora CO WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE U.DOCUMENTOIDENTIDAD = @CodigoUsuario
		And CO.IdEstadoActividad != IsNull(U.VerificacionEstadoActividad, 0)
		ORDER BY U.EMailActivo DESC		
	END
	ELSE
	BEGIN

		If Exists (Select 1 From Usuario U WITH(NOLOCK)
		inner join ods.Consultora C WITH(NOLOCK) ON U.CodigoConsultora = C.Codigo Where (U.CODIGOCONSULTORA = @CodigoUsuario OR U.DOCUMENTOIDENTIDAD = @CodigoUsuario)
		And C.IdEstadoActividad = 8 And U.VerificacionEstadoActividad = 7)
		begin
			Update Usuario set VerificacionEstadoActividad = 1 Where CODIGOCONSULTORA = @CodigoUsuario OR DOCUMENTOIDENTIDAD = @CodigoUsuario
		end

		SELECT TOP 1
			@Cantidad = 1,
			@PrimerNombre = substring(ISNULL(CO.PrimerNombre, ''),1,1) + lower(substring(ISNULL(CO.PrimerNombre, ''),2, Len(CO.PrimerNombre))),
			@IdEstadoActividad = IsNull(CO.IdEstadoActividad, ''),
			@Celular = IsNull(U.Celular, ''),
			@Correo = IsNull(U.EMail, ''),
			@RegionID = IsNull(RegionID,0),
			@ZonaID = Isnull(CO.ZonaID, 0)
		FROM dbo.Usuario U WITH(NOLOCK)
		LEFT JOIN ods.Consultora co WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE (U.CODIGOCONSULTORA = @CodigoUsuario OR U.DOCUMENTOIDENTIDAD = @CodigoUsuario)
		And CO.IdEstadoActividad != IsNull(U.VerificacionEstadoActividad, 0)
		ORDER BY U.EMailActivo DESC
	END

	SELECT
			@Cantidad as Cantidad,
			@PrimerNombre as PrimerNombre,
			@IdEstadoActividad as IdEstadoActividad,
			@Celular as Celular,
			@Correo as Correo,
			@RegionID as RegionID,
			@ZonaID as ZonaID
	SET NOCOUNT OFF
END
GO

USE BelcorpChile
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'GetUsuarioVerificacionAutenticidad')
BEGIN
	DROP PROC [dbo].[GetUsuarioVerificacionAutenticidad]
END
GO
CREATE PROCEDURE [dbo].[GetUsuarioVerificacionAutenticidad]
	@CodigoUsuario VARCHAR(20),
	@PaisID	INT
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

	IF (@PaisID = 3 OR @PaisID = 4 OR @PaisID = 6)
	BEGIN

		If Exists (Select 1 From Usuario U WITH(NOLOCK)
		inner join ods.Consultora C WITH(NOLOCK) ON U.CodigoConsultora = C.Codigo Where U.DOCUMENTOIDENTIDAD = @CodigoUsuario 
		And C.IdEstadoActividad = 8 And U.VerificacionEstadoActividad = 7)
		begin
			Update Usuario set VerificacionEstadoActividad = 1 Where DOCUMENTOIDENTIDAD = @CodigoUsuario 
		end

		SELECT TOP 1
			@Cantidad = 1,
			@PrimerNombre = substring(ISNULL(CO.PrimerNombre, ''),1,1) + lower(substring(ISNULL(CO.PrimerNombre, ''),2, Len(CO.PrimerNombre))),
			@IdEstadoActividad = IsNull(CO.IdEstadoActividad, ''),
			@Celular = IsNull(U.Celular, ''),
			@Correo = IsNull(U.EMail, ''),
			@RegionID = IsNull(RegionID,0),
			@ZonaID = IsNull(CO.ZonaID, 0)
		FROM dbo.Usuario U WITH(NOLOCK)
		LEFT JOIN ods.Consultora CO WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE U.DOCUMENTOIDENTIDAD = @CodigoUsuario
		And CO.IdEstadoActividad != IsNull(U.VerificacionEstadoActividad, 0)
		ORDER BY U.EMailActivo DESC		
	END
	ELSE
	BEGIN

		If Exists (Select 1 From Usuario U WITH(NOLOCK)
		inner join ods.Consultora C WITH(NOLOCK) ON U.CodigoConsultora = C.Codigo Where (U.CODIGOCONSULTORA = @CodigoUsuario OR U.DOCUMENTOIDENTIDAD = @CodigoUsuario)
		And C.IdEstadoActividad = 8 And U.VerificacionEstadoActividad = 7)
		begin
			Update Usuario set VerificacionEstadoActividad = 1 Where CODIGOCONSULTORA = @CodigoUsuario OR DOCUMENTOIDENTIDAD = @CodigoUsuario
		end

		SELECT TOP 1
			@Cantidad = 1,
			@PrimerNombre = substring(ISNULL(CO.PrimerNombre, ''),1,1) + lower(substring(ISNULL(CO.PrimerNombre, ''),2, Len(CO.PrimerNombre))),
			@IdEstadoActividad = IsNull(CO.IdEstadoActividad, ''),
			@Celular = IsNull(U.Celular, ''),
			@Correo = IsNull(U.EMail, ''),
			@RegionID = IsNull(RegionID,0),
			@ZonaID = Isnull(CO.ZonaID, 0)
		FROM dbo.Usuario U WITH(NOLOCK)
		LEFT JOIN ods.Consultora co WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE (U.CODIGOCONSULTORA = @CodigoUsuario OR U.DOCUMENTOIDENTIDAD = @CodigoUsuario)
		And CO.IdEstadoActividad != IsNull(U.VerificacionEstadoActividad, 0)
		ORDER BY U.EMailActivo DESC
	END

	SELECT
			@Cantidad as Cantidad,
			@PrimerNombre as PrimerNombre,
			@IdEstadoActividad as IdEstadoActividad,
			@Celular as Celular,
			@Correo as Correo,
			@RegionID as RegionID,
			@ZonaID as ZonaID
	SET NOCOUNT OFF
END
GO

USE BelcorpBolivia
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'GetUsuarioVerificacionAutenticidad')
BEGIN
	DROP PROC [dbo].[GetUsuarioVerificacionAutenticidad]
END
GO
CREATE PROCEDURE [dbo].[GetUsuarioVerificacionAutenticidad]
	@CodigoUsuario VARCHAR(20),
	@PaisID	INT
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

	IF (@PaisID = 3 OR @PaisID = 4 OR @PaisID = 6)
	BEGIN

		If Exists (Select 1 From Usuario U WITH(NOLOCK)
		inner join ods.Consultora C WITH(NOLOCK) ON U.CodigoConsultora = C.Codigo Where U.DOCUMENTOIDENTIDAD = @CodigoUsuario 
		And C.IdEstadoActividad = 8 And U.VerificacionEstadoActividad = 7)
		begin
			Update Usuario set VerificacionEstadoActividad = 1 Where DOCUMENTOIDENTIDAD = @CodigoUsuario 
		end

		SELECT TOP 1
			@Cantidad = 1,
			@PrimerNombre = substring(ISNULL(CO.PrimerNombre, ''),1,1) + lower(substring(ISNULL(CO.PrimerNombre, ''),2, Len(CO.PrimerNombre))),
			@IdEstadoActividad = IsNull(CO.IdEstadoActividad, ''),
			@Celular = IsNull(U.Celular, ''),
			@Correo = IsNull(U.EMail, ''),
			@RegionID = IsNull(RegionID,0),
			@ZonaID = IsNull(CO.ZonaID, 0)
		FROM dbo.Usuario U WITH(NOLOCK)
		LEFT JOIN ods.Consultora CO WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE U.DOCUMENTOIDENTIDAD = @CodigoUsuario
		And CO.IdEstadoActividad != IsNull(U.VerificacionEstadoActividad, 0)
		ORDER BY U.EMailActivo DESC		
	END
	ELSE
	BEGIN

		If Exists (Select 1 From Usuario U WITH(NOLOCK)
		inner join ods.Consultora C WITH(NOLOCK) ON U.CodigoConsultora = C.Codigo Where (U.CODIGOCONSULTORA = @CodigoUsuario OR U.DOCUMENTOIDENTIDAD = @CodigoUsuario)
		And C.IdEstadoActividad = 8 And U.VerificacionEstadoActividad = 7)
		begin
			Update Usuario set VerificacionEstadoActividad = 1 Where CODIGOCONSULTORA = @CodigoUsuario OR DOCUMENTOIDENTIDAD = @CodigoUsuario
		end

		SELECT TOP 1
			@Cantidad = 1,
			@PrimerNombre = substring(ISNULL(CO.PrimerNombre, ''),1,1) + lower(substring(ISNULL(CO.PrimerNombre, ''),2, Len(CO.PrimerNombre))),
			@IdEstadoActividad = IsNull(CO.IdEstadoActividad, ''),
			@Celular = IsNull(U.Celular, ''),
			@Correo = IsNull(U.EMail, ''),
			@RegionID = IsNull(RegionID,0),
			@ZonaID = Isnull(CO.ZonaID, 0)
		FROM dbo.Usuario U WITH(NOLOCK)
		LEFT JOIN ods.Consultora co WITH(NOLOCK) ON u.CodigoConsultora = co.Codigo
		WHERE (U.CODIGOCONSULTORA = @CodigoUsuario OR U.DOCUMENTOIDENTIDAD = @CodigoUsuario)
		And CO.IdEstadoActividad != IsNull(U.VerificacionEstadoActividad, 0)
		ORDER BY U.EMailActivo DESC
	END

	SELECT
			@Cantidad as Cantidad,
			@PrimerNombre as PrimerNombre,
			@IdEstadoActividad as IdEstadoActividad,
			@Celular as Celular,
			@Correo as Correo,
			@RegionID as RegionID,
			@ZonaID as ZonaID
	SET NOCOUNT OFF
END
GO

