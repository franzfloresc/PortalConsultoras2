------------------------------------------------
-- Creacion de stores para configuracion Home
------------------------------------------------
USE BelcorpPeru
GO

CREATE PROCEDURE [dbo].[ConfiguracionOfertasHomeList]
	@CampaniaId int
AS
BEGIN
	SET NOCOUNT ON;
	IF(@CampaniaId = 0)
		SELECT * FROM ConfiguracionOfertasHome;
	ELSE 
		SELECT * FROM ConfiguracionOfertasHome WHERE CampaniaID = @CampaniaId;
END
GO

CREATE PROCEDURE [dbo].[ConfiguracionOfertasHomeGet] 
	@ConfiguracionOfertasHomeID int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT * FROM ConfiguracionOfertasHome AS P WHERE 
	P.ConfiguracionOfertasHomeID = @ConfiguracionOfertasHomeID
END
GO

CREATE PROCEDURE [dbo].[ConfiguracionOfertasHomeUpdate] 
	@ConfiguracionOfertasHomeID int,
	@ConfiguracionPaisID int,
	@CampaniaID int,
	@DesktopOrden int,
	@MobileOrden int,
	@DesktopImagenFondo varchar(250),
	@MobileImagenFondo varchar(250),
	@DesktopTitulo varchar(250),
	@MobileTitulo varchar(250),
	@DesktopSubTitulo varchar(250),
	@MobileSubTitulo varchar(250),
	@DesktopTipoPresentacion int,
	@MobileTipoPresentacion int,
	@DesktopTipoEstrategia varchar(250),
	@MobileTipoEstrategia varchar(250),
	@DesktopCantidadProductos int,
	@MobileCantidadProductos int,
	@DesktopActivo bit,
	@MobileActivo bit,
	@UrlSeccion varchar(250)
	AS 
BEGIN
SET NOCOUNT ON
DECLARE @InsertedId int = 0;
IF(@ConfiguracionOfertasHomeID = 0)
	BEGIN
		INSERT INTO ConfiguracionOfertasHome (ConfiguracionPaisID,
				CampaniaID,
				DesktopOrden,
				MobileOrden,
				DesktopImagenFondo,
				MobileImagenFondo,
				DesktopTitulo,
				MobileTitulo,
				DesktopSubTitulo,
				MobileSubTitulo,
				DesktopTipoPresentacion,
				MobileTipoPresentacion,
				DesktopTipoEstrategia,
				MobileTipoEstrategia,
				DesktopCantidadProductos,
				MobileCantidadProductos,
				DesktopActivo,
				MobileActivo,
				UrlSeccion)
		VALUES (@ConfiguracionPaisID,
				@CampaniaID,
				@DesktopOrden,
				@MobileOrden,
				@DesktopImagenFondo,
				@MobileImagenFondo,
				@DesktopTitulo,
				@MobileTitulo,
				@DesktopSubTitulo,
				@MobileSubTitulo,
				@DesktopTipoPresentacion,
				@MobileTipoPresentacion,
				@DesktopTipoEstrategia,
				@MobileTipoEstrategia,
				@DesktopCantidadProductos,
				@MobileCantidadProductos,
				@DesktopActivo,
				@MobileActivo,
				@UrlSeccion);
		set @insertedId = scope_identity();
	END
ELSE 
	BEGIN
		UPDATE ConfiguracionOfertasHome SET
			ConfiguracionPaisID = @ConfiguracionPaisID,
			CampaniaID = @CampaniaID,
			DesktopOrden = @DesktopOrden,
			MobileOrden = @MobileOrden,
			DesktopImagenFondo = @DesktopImagenFondo,
			MobileImagenFondo = @MobileImagenFondo,
			DesktopTitulo = @DesktopTitulo,
			MobileTitulo = @MobileTitulo,
			DesktopSubTitulo = @DesktopSubTitulo,
			MobileSubTitulo = @MobileSubTitulo,
			DesktopTipoPresentacion = @DesktopTipoPresentacion,
			MobileTipoPresentacion = @MobileTipoPresentacion,
			DesktopTipoEstrategia = @DesktopTipoEstrategia,
			MobileTipoEstrategia = @MobileTipoEstrategia,
			DesktopCantidadProductos = @DesktopCantidadProductos,
			MobileCantidadProductos = @MobileCantidadProductos,
			DesktopActivo = @DesktopActivo,
			MobileActivo = @MobileActivo,
			UrlSeccion = @UrlSeccion
		WHERE ConfiguracionOfertasHomeID = @ConfiguracionOfertasHomeID;
		set @insertedId = @ConfiguracionPaisID;
	END
END
GO
/*end*/

USE BelcorpMexico
GO

CREATE PROCEDURE [dbo].[ConfiguracionOfertasHomeList]
	@CampaniaId int
AS
BEGIN
	SET NOCOUNT ON;
	IF(@CampaniaId = 0)
		SELECT * FROM ConfiguracionOfertasHome;
	ELSE 
		SELECT * FROM ConfiguracionOfertasHome WHERE CampaniaID = @CampaniaId;
END
GO

CREATE PROCEDURE [dbo].[ConfiguracionOfertasHomeGet] 
	@ConfiguracionOfertasHomeID int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT * FROM ConfiguracionOfertasHome AS P WHERE 
	P.ConfiguracionOfertasHomeID = @ConfiguracionOfertasHomeID
END
GO

CREATE PROCEDURE [dbo].[ConfiguracionOfertasHomeUpdate] 
	@ConfiguracionOfertasHomeID int,
	@ConfiguracionPaisID int,
	@CampaniaID int,
	@DesktopOrden int,
	@MobileOrden int,
	@DesktopImagenFondo varchar(250),
	@MobileImagenFondo varchar(250),
	@DesktopTitulo varchar(250),
	@MobileTitulo varchar(250),
	@DesktopSubTitulo varchar(250),
	@MobileSubTitulo varchar(250),
	@DesktopTipoPresentacion int,
	@MobileTipoPresentacion int,
	@DesktopTipoEstrategia varchar(250),
	@MobileTipoEstrategia varchar(250),
	@DesktopCantidadProductos int,
	@MobileCantidadProductos int,
	@DesktopActivo bit,
	@MobileActivo bit,
	@UrlSeccion varchar(250)
	AS 
BEGIN
SET NOCOUNT ON
DECLARE @InsertedId int = 0;
IF(@ConfiguracionOfertasHomeID = 0)
	BEGIN
		INSERT INTO ConfiguracionOfertasHome (ConfiguracionPaisID,
				CampaniaID,
				DesktopOrden,
				MobileOrden,
				DesktopImagenFondo,
				MobileImagenFondo,
				DesktopTitulo,
				MobileTitulo,
				DesktopSubTitulo,
				MobileSubTitulo,
				DesktopTipoPresentacion,
				MobileTipoPresentacion,
				DesktopTipoEstrategia,
				MobileTipoEstrategia,
				DesktopCantidadProductos,
				MobileCantidadProductos,
				DesktopActivo,
				MobileActivo,
				UrlSeccion)
		VALUES (@ConfiguracionPaisID,
				@CampaniaID,
				@DesktopOrden,
				@MobileOrden,
				@DesktopImagenFondo,
				@MobileImagenFondo,
				@DesktopTitulo,
				@MobileTitulo,
				@DesktopSubTitulo,
				@MobileSubTitulo,
				@DesktopTipoPresentacion,
				@MobileTipoPresentacion,
				@DesktopTipoEstrategia,
				@MobileTipoEstrategia,
				@DesktopCantidadProductos,
				@MobileCantidadProductos,
				@DesktopActivo,
				@MobileActivo,
				@UrlSeccion);
		set @insertedId = scope_identity();
	END
ELSE 
	BEGIN
		UPDATE ConfiguracionOfertasHome SET
			ConfiguracionPaisID = @ConfiguracionPaisID,
			CampaniaID = @CampaniaID,
			DesktopOrden = @DesktopOrden,
			MobileOrden = @MobileOrden,
			DesktopImagenFondo = @DesktopImagenFondo,
			MobileImagenFondo = @MobileImagenFondo,
			DesktopTitulo = @DesktopTitulo,
			MobileTitulo = @MobileTitulo,
			DesktopSubTitulo = @DesktopSubTitulo,
			MobileSubTitulo = @MobileSubTitulo,
			DesktopTipoPresentacion = @DesktopTipoPresentacion,
			MobileTipoPresentacion = @MobileTipoPresentacion,
			DesktopTipoEstrategia = @DesktopTipoEstrategia,
			MobileTipoEstrategia = @MobileTipoEstrategia,
			DesktopCantidadProductos = @DesktopCantidadProductos,
			MobileCantidadProductos = @MobileCantidadProductos,
			DesktopActivo = @DesktopActivo,
			MobileActivo = @MobileActivo,
			UrlSeccion = @UrlSeccion
		WHERE ConfiguracionOfertasHomeID = @ConfiguracionOfertasHomeID;
		set @insertedId = @ConfiguracionPaisID;
	END
END
GO
/*end*/

USE BelcorpColombia
GO

CREATE PROCEDURE [dbo].[ConfiguracionOfertasHomeList]
	@CampaniaId int
AS
BEGIN
	SET NOCOUNT ON;
	IF(@CampaniaId = 0)
		SELECT * FROM ConfiguracionOfertasHome;
	ELSE 
		SELECT * FROM ConfiguracionOfertasHome WHERE CampaniaID = @CampaniaId;
END
GO

CREATE PROCEDURE [dbo].[ConfiguracionOfertasHomeGet] 
	@ConfiguracionOfertasHomeID int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT * FROM ConfiguracionOfertasHome AS P WHERE 
	P.ConfiguracionOfertasHomeID = @ConfiguracionOfertasHomeID
END
GO

CREATE PROCEDURE [dbo].[ConfiguracionOfertasHomeUpdate] 
	@ConfiguracionOfertasHomeID int,
	@ConfiguracionPaisID int,
	@CampaniaID int,
	@DesktopOrden int,
	@MobileOrden int,
	@DesktopImagenFondo varchar(250),
	@MobileImagenFondo varchar(250),
	@DesktopTitulo varchar(250),
	@MobileTitulo varchar(250),
	@DesktopSubTitulo varchar(250),
	@MobileSubTitulo varchar(250),
	@DesktopTipoPresentacion int,
	@MobileTipoPresentacion int,
	@DesktopTipoEstrategia varchar(250),
	@MobileTipoEstrategia varchar(250),
	@DesktopCantidadProductos int,
	@MobileCantidadProductos int,
	@DesktopActivo bit,
	@MobileActivo bit,
	@UrlSeccion varchar(250)
	AS 
BEGIN
SET NOCOUNT ON
DECLARE @InsertedId int = 0;
IF(@ConfiguracionOfertasHomeID = 0)
	BEGIN
		INSERT INTO ConfiguracionOfertasHome (ConfiguracionPaisID,
				CampaniaID,
				DesktopOrden,
				MobileOrden,
				DesktopImagenFondo,
				MobileImagenFondo,
				DesktopTitulo,
				MobileTitulo,
				DesktopSubTitulo,
				MobileSubTitulo,
				DesktopTipoPresentacion,
				MobileTipoPresentacion,
				DesktopTipoEstrategia,
				MobileTipoEstrategia,
				DesktopCantidadProductos,
				MobileCantidadProductos,
				DesktopActivo,
				MobileActivo,
				UrlSeccion)
		VALUES (@ConfiguracionPaisID,
				@CampaniaID,
				@DesktopOrden,
				@MobileOrden,
				@DesktopImagenFondo,
				@MobileImagenFondo,
				@DesktopTitulo,
				@MobileTitulo,
				@DesktopSubTitulo,
				@MobileSubTitulo,
				@DesktopTipoPresentacion,
				@MobileTipoPresentacion,
				@DesktopTipoEstrategia,
				@MobileTipoEstrategia,
				@DesktopCantidadProductos,
				@MobileCantidadProductos,
				@DesktopActivo,
				@MobileActivo,
				@UrlSeccion);
		set @insertedId = scope_identity();
	END
ELSE 
	BEGIN
		UPDATE ConfiguracionOfertasHome SET
			ConfiguracionPaisID = @ConfiguracionPaisID,
			CampaniaID = @CampaniaID,
			DesktopOrden = @DesktopOrden,
			MobileOrden = @MobileOrden,
			DesktopImagenFondo = @DesktopImagenFondo,
			MobileImagenFondo = @MobileImagenFondo,
			DesktopTitulo = @DesktopTitulo,
			MobileTitulo = @MobileTitulo,
			DesktopSubTitulo = @DesktopSubTitulo,
			MobileSubTitulo = @MobileSubTitulo,
			DesktopTipoPresentacion = @DesktopTipoPresentacion,
			MobileTipoPresentacion = @MobileTipoPresentacion,
			DesktopTipoEstrategia = @DesktopTipoEstrategia,
			MobileTipoEstrategia = @MobileTipoEstrategia,
			DesktopCantidadProductos = @DesktopCantidadProductos,
			MobileCantidadProductos = @MobileCantidadProductos,
			DesktopActivo = @DesktopActivo,
			MobileActivo = @MobileActivo,
			UrlSeccion = @UrlSeccion
		WHERE ConfiguracionOfertasHomeID = @ConfiguracionOfertasHomeID;
		set @insertedId = @ConfiguracionPaisID;
	END
END
GO
/*end*/

USE BelcorpVenezuela
GO

CREATE PROCEDURE [dbo].[ConfiguracionOfertasHomeList]
	@CampaniaId int
AS
BEGIN
	SET NOCOUNT ON;
	IF(@CampaniaId = 0)
		SELECT * FROM ConfiguracionOfertasHome;
	ELSE 
		SELECT * FROM ConfiguracionOfertasHome WHERE CampaniaID = @CampaniaId;
END
GO

CREATE PROCEDURE [dbo].[ConfiguracionOfertasHomeGet] 
	@ConfiguracionOfertasHomeID int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT * FROM ConfiguracionOfertasHome AS P WHERE 
	P.ConfiguracionOfertasHomeID = @ConfiguracionOfertasHomeID
END
GO

CREATE PROCEDURE [dbo].[ConfiguracionOfertasHomeUpdate] 
	@ConfiguracionOfertasHomeID int,
	@ConfiguracionPaisID int,
	@CampaniaID int,
	@DesktopOrden int,
	@MobileOrden int,
	@DesktopImagenFondo varchar(250),
	@MobileImagenFondo varchar(250),
	@DesktopTitulo varchar(250),
	@MobileTitulo varchar(250),
	@DesktopSubTitulo varchar(250),
	@MobileSubTitulo varchar(250),
	@DesktopTipoPresentacion int,
	@MobileTipoPresentacion int,
	@DesktopTipoEstrategia varchar(250),
	@MobileTipoEstrategia varchar(250),
	@DesktopCantidadProductos int,
	@MobileCantidadProductos int,
	@DesktopActivo bit,
	@MobileActivo bit,
	@UrlSeccion varchar(250)
	AS 
BEGIN
SET NOCOUNT ON
DECLARE @InsertedId int = 0;
IF(@ConfiguracionOfertasHomeID = 0)
	BEGIN
		INSERT INTO ConfiguracionOfertasHome (ConfiguracionPaisID,
				CampaniaID,
				DesktopOrden,
				MobileOrden,
				DesktopImagenFondo,
				MobileImagenFondo,
				DesktopTitulo,
				MobileTitulo,
				DesktopSubTitulo,
				MobileSubTitulo,
				DesktopTipoPresentacion,
				MobileTipoPresentacion,
				DesktopTipoEstrategia,
				MobileTipoEstrategia,
				DesktopCantidadProductos,
				MobileCantidadProductos,
				DesktopActivo,
				MobileActivo,
				UrlSeccion)
		VALUES (@ConfiguracionPaisID,
				@CampaniaID,
				@DesktopOrden,
				@MobileOrden,
				@DesktopImagenFondo,
				@MobileImagenFondo,
				@DesktopTitulo,
				@MobileTitulo,
				@DesktopSubTitulo,
				@MobileSubTitulo,
				@DesktopTipoPresentacion,
				@MobileTipoPresentacion,
				@DesktopTipoEstrategia,
				@MobileTipoEstrategia,
				@DesktopCantidadProductos,
				@MobileCantidadProductos,
				@DesktopActivo,
				@MobileActivo,
				@UrlSeccion);
		set @insertedId = scope_identity();
	END
ELSE 
	BEGIN
		UPDATE ConfiguracionOfertasHome SET
			ConfiguracionPaisID = @ConfiguracionPaisID,
			CampaniaID = @CampaniaID,
			DesktopOrden = @DesktopOrden,
			MobileOrden = @MobileOrden,
			DesktopImagenFondo = @DesktopImagenFondo,
			MobileImagenFondo = @MobileImagenFondo,
			DesktopTitulo = @DesktopTitulo,
			MobileTitulo = @MobileTitulo,
			DesktopSubTitulo = @DesktopSubTitulo,
			MobileSubTitulo = @MobileSubTitulo,
			DesktopTipoPresentacion = @DesktopTipoPresentacion,
			MobileTipoPresentacion = @MobileTipoPresentacion,
			DesktopTipoEstrategia = @DesktopTipoEstrategia,
			MobileTipoEstrategia = @MobileTipoEstrategia,
			DesktopCantidadProductos = @DesktopCantidadProductos,
			MobileCantidadProductos = @MobileCantidadProductos,
			DesktopActivo = @DesktopActivo,
			MobileActivo = @MobileActivo,
			UrlSeccion = @UrlSeccion
		WHERE ConfiguracionOfertasHomeID = @ConfiguracionOfertasHomeID;
		set @insertedId = @ConfiguracionPaisID;
	END
END
GO
/*end*/

USE BelcorpSalvador
GO

CREATE PROCEDURE [dbo].[ConfiguracionOfertasHomeList]
	@CampaniaId int
AS
BEGIN
	SET NOCOUNT ON;
	IF(@CampaniaId = 0)
		SELECT * FROM ConfiguracionOfertasHome;
	ELSE 
		SELECT * FROM ConfiguracionOfertasHome WHERE CampaniaID = @CampaniaId;
END
GO

CREATE PROCEDURE [dbo].[ConfiguracionOfertasHomeGet] 
	@ConfiguracionOfertasHomeID int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT * FROM ConfiguracionOfertasHome AS P WHERE 
	P.ConfiguracionOfertasHomeID = @ConfiguracionOfertasHomeID
END
GO

CREATE PROCEDURE [dbo].[ConfiguracionOfertasHomeUpdate] 
	@ConfiguracionOfertasHomeID int,
	@ConfiguracionPaisID int,
	@CampaniaID int,
	@DesktopOrden int,
	@MobileOrden int,
	@DesktopImagenFondo varchar(250),
	@MobileImagenFondo varchar(250),
	@DesktopTitulo varchar(250),
	@MobileTitulo varchar(250),
	@DesktopSubTitulo varchar(250),
	@MobileSubTitulo varchar(250),
	@DesktopTipoPresentacion int,
	@MobileTipoPresentacion int,
	@DesktopTipoEstrategia varchar(250),
	@MobileTipoEstrategia varchar(250),
	@DesktopCantidadProductos int,
	@MobileCantidadProductos int,
	@DesktopActivo bit,
	@MobileActivo bit,
	@UrlSeccion varchar(250)
	AS 
BEGIN
SET NOCOUNT ON
DECLARE @InsertedId int = 0;
IF(@ConfiguracionOfertasHomeID = 0)
	BEGIN
		INSERT INTO ConfiguracionOfertasHome (ConfiguracionPaisID,
				CampaniaID,
				DesktopOrden,
				MobileOrden,
				DesktopImagenFondo,
				MobileImagenFondo,
				DesktopTitulo,
				MobileTitulo,
				DesktopSubTitulo,
				MobileSubTitulo,
				DesktopTipoPresentacion,
				MobileTipoPresentacion,
				DesktopTipoEstrategia,
				MobileTipoEstrategia,
				DesktopCantidadProductos,
				MobileCantidadProductos,
				DesktopActivo,
				MobileActivo,
				UrlSeccion)
		VALUES (@ConfiguracionPaisID,
				@CampaniaID,
				@DesktopOrden,
				@MobileOrden,
				@DesktopImagenFondo,
				@MobileImagenFondo,
				@DesktopTitulo,
				@MobileTitulo,
				@DesktopSubTitulo,
				@MobileSubTitulo,
				@DesktopTipoPresentacion,
				@MobileTipoPresentacion,
				@DesktopTipoEstrategia,
				@MobileTipoEstrategia,
				@DesktopCantidadProductos,
				@MobileCantidadProductos,
				@DesktopActivo,
				@MobileActivo,
				@UrlSeccion);
		set @insertedId = scope_identity();
	END
ELSE 
	BEGIN
		UPDATE ConfiguracionOfertasHome SET
			ConfiguracionPaisID = @ConfiguracionPaisID,
			CampaniaID = @CampaniaID,
			DesktopOrden = @DesktopOrden,
			MobileOrden = @MobileOrden,
			DesktopImagenFondo = @DesktopImagenFondo,
			MobileImagenFondo = @MobileImagenFondo,
			DesktopTitulo = @DesktopTitulo,
			MobileTitulo = @MobileTitulo,
			DesktopSubTitulo = @DesktopSubTitulo,
			MobileSubTitulo = @MobileSubTitulo,
			DesktopTipoPresentacion = @DesktopTipoPresentacion,
			MobileTipoPresentacion = @MobileTipoPresentacion,
			DesktopTipoEstrategia = @DesktopTipoEstrategia,
			MobileTipoEstrategia = @MobileTipoEstrategia,
			DesktopCantidadProductos = @DesktopCantidadProductos,
			MobileCantidadProductos = @MobileCantidadProductos,
			DesktopActivo = @DesktopActivo,
			MobileActivo = @MobileActivo,
			UrlSeccion = @UrlSeccion
		WHERE ConfiguracionOfertasHomeID = @ConfiguracionOfertasHomeID;
		set @insertedId = @ConfiguracionPaisID;
	END
END
GO
/*end*/

USE BelcorpPuertoRico
GO

CREATE PROCEDURE [dbo].[ConfiguracionOfertasHomeList]
	@CampaniaId int
AS
BEGIN
	SET NOCOUNT ON;
	IF(@CampaniaId = 0)
		SELECT * FROM ConfiguracionOfertasHome;
	ELSE 
		SELECT * FROM ConfiguracionOfertasHome WHERE CampaniaID = @CampaniaId;
END
GO

CREATE PROCEDURE [dbo].[ConfiguracionOfertasHomeGet] 
	@ConfiguracionOfertasHomeID int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT * FROM ConfiguracionOfertasHome AS P WHERE 
	P.ConfiguracionOfertasHomeID = @ConfiguracionOfertasHomeID
END
GO

CREATE PROCEDURE [dbo].[ConfiguracionOfertasHomeUpdate] 
	@ConfiguracionOfertasHomeID int,
	@ConfiguracionPaisID int,
	@CampaniaID int,
	@DesktopOrden int,
	@MobileOrden int,
	@DesktopImagenFondo varchar(250),
	@MobileImagenFondo varchar(250),
	@DesktopTitulo varchar(250),
	@MobileTitulo varchar(250),
	@DesktopSubTitulo varchar(250),
	@MobileSubTitulo varchar(250),
	@DesktopTipoPresentacion int,
	@MobileTipoPresentacion int,
	@DesktopTipoEstrategia varchar(250),
	@MobileTipoEstrategia varchar(250),
	@DesktopCantidadProductos int,
	@MobileCantidadProductos int,
	@DesktopActivo bit,
	@MobileActivo bit,
	@UrlSeccion varchar(250)
	AS 
BEGIN
SET NOCOUNT ON
DECLARE @InsertedId int = 0;
IF(@ConfiguracionOfertasHomeID = 0)
	BEGIN
		INSERT INTO ConfiguracionOfertasHome (ConfiguracionPaisID,
				CampaniaID,
				DesktopOrden,
				MobileOrden,
				DesktopImagenFondo,
				MobileImagenFondo,
				DesktopTitulo,
				MobileTitulo,
				DesktopSubTitulo,
				MobileSubTitulo,
				DesktopTipoPresentacion,
				MobileTipoPresentacion,
				DesktopTipoEstrategia,
				MobileTipoEstrategia,
				DesktopCantidadProductos,
				MobileCantidadProductos,
				DesktopActivo,
				MobileActivo,
				UrlSeccion)
		VALUES (@ConfiguracionPaisID,
				@CampaniaID,
				@DesktopOrden,
				@MobileOrden,
				@DesktopImagenFondo,
				@MobileImagenFondo,
				@DesktopTitulo,
				@MobileTitulo,
				@DesktopSubTitulo,
				@MobileSubTitulo,
				@DesktopTipoPresentacion,
				@MobileTipoPresentacion,
				@DesktopTipoEstrategia,
				@MobileTipoEstrategia,
				@DesktopCantidadProductos,
				@MobileCantidadProductos,
				@DesktopActivo,
				@MobileActivo,
				@UrlSeccion);
		set @insertedId = scope_identity();
	END
ELSE 
	BEGIN
		UPDATE ConfiguracionOfertasHome SET
			ConfiguracionPaisID = @ConfiguracionPaisID,
			CampaniaID = @CampaniaID,
			DesktopOrden = @DesktopOrden,
			MobileOrden = @MobileOrden,
			DesktopImagenFondo = @DesktopImagenFondo,
			MobileImagenFondo = @MobileImagenFondo,
			DesktopTitulo = @DesktopTitulo,
			MobileTitulo = @MobileTitulo,
			DesktopSubTitulo = @DesktopSubTitulo,
			MobileSubTitulo = @MobileSubTitulo,
			DesktopTipoPresentacion = @DesktopTipoPresentacion,
			MobileTipoPresentacion = @MobileTipoPresentacion,
			DesktopTipoEstrategia = @DesktopTipoEstrategia,
			MobileTipoEstrategia = @MobileTipoEstrategia,
			DesktopCantidadProductos = @DesktopCantidadProductos,
			MobileCantidadProductos = @MobileCantidadProductos,
			DesktopActivo = @DesktopActivo,
			MobileActivo = @MobileActivo,
			UrlSeccion = @UrlSeccion
		WHERE ConfiguracionOfertasHomeID = @ConfiguracionOfertasHomeID;
		set @insertedId = @ConfiguracionPaisID;
	END
END
GO
/*end*/

USE BelcorpPanama
GO

CREATE PROCEDURE [dbo].[ConfiguracionOfertasHomeList]
	@CampaniaId int
AS
BEGIN
	SET NOCOUNT ON;
	IF(@CampaniaId = 0)
		SELECT * FROM ConfiguracionOfertasHome;
	ELSE 
		SELECT * FROM ConfiguracionOfertasHome WHERE CampaniaID = @CampaniaId;
END
GO

CREATE PROCEDURE [dbo].[ConfiguracionOfertasHomeGet] 
	@ConfiguracionOfertasHomeID int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT * FROM ConfiguracionOfertasHome AS P WHERE 
	P.ConfiguracionOfertasHomeID = @ConfiguracionOfertasHomeID
END
GO

CREATE PROCEDURE [dbo].[ConfiguracionOfertasHomeUpdate] 
	@ConfiguracionOfertasHomeID int,
	@ConfiguracionPaisID int,
	@CampaniaID int,
	@DesktopOrden int,
	@MobileOrden int,
	@DesktopImagenFondo varchar(250),
	@MobileImagenFondo varchar(250),
	@DesktopTitulo varchar(250),
	@MobileTitulo varchar(250),
	@DesktopSubTitulo varchar(250),
	@MobileSubTitulo varchar(250),
	@DesktopTipoPresentacion int,
	@MobileTipoPresentacion int,
	@DesktopTipoEstrategia varchar(250),
	@MobileTipoEstrategia varchar(250),
	@DesktopCantidadProductos int,
	@MobileCantidadProductos int,
	@DesktopActivo bit,
	@MobileActivo bit,
	@UrlSeccion varchar(250)
	AS 
BEGIN
SET NOCOUNT ON
DECLARE @InsertedId int = 0;
IF(@ConfiguracionOfertasHomeID = 0)
	BEGIN
		INSERT INTO ConfiguracionOfertasHome (ConfiguracionPaisID,
				CampaniaID,
				DesktopOrden,
				MobileOrden,
				DesktopImagenFondo,
				MobileImagenFondo,
				DesktopTitulo,
				MobileTitulo,
				DesktopSubTitulo,
				MobileSubTitulo,
				DesktopTipoPresentacion,
				MobileTipoPresentacion,
				DesktopTipoEstrategia,
				MobileTipoEstrategia,
				DesktopCantidadProductos,
				MobileCantidadProductos,
				DesktopActivo,
				MobileActivo,
				UrlSeccion)
		VALUES (@ConfiguracionPaisID,
				@CampaniaID,
				@DesktopOrden,
				@MobileOrden,
				@DesktopImagenFondo,
				@MobileImagenFondo,
				@DesktopTitulo,
				@MobileTitulo,
				@DesktopSubTitulo,
				@MobileSubTitulo,
				@DesktopTipoPresentacion,
				@MobileTipoPresentacion,
				@DesktopTipoEstrategia,
				@MobileTipoEstrategia,
				@DesktopCantidadProductos,
				@MobileCantidadProductos,
				@DesktopActivo,
				@MobileActivo,
				@UrlSeccion);
		set @insertedId = scope_identity();
	END
ELSE 
	BEGIN
		UPDATE ConfiguracionOfertasHome SET
			ConfiguracionPaisID = @ConfiguracionPaisID,
			CampaniaID = @CampaniaID,
			DesktopOrden = @DesktopOrden,
			MobileOrden = @MobileOrden,
			DesktopImagenFondo = @DesktopImagenFondo,
			MobileImagenFondo = @MobileImagenFondo,
			DesktopTitulo = @DesktopTitulo,
			MobileTitulo = @MobileTitulo,
			DesktopSubTitulo = @DesktopSubTitulo,
			MobileSubTitulo = @MobileSubTitulo,
			DesktopTipoPresentacion = @DesktopTipoPresentacion,
			MobileTipoPresentacion = @MobileTipoPresentacion,
			DesktopTipoEstrategia = @DesktopTipoEstrategia,
			MobileTipoEstrategia = @MobileTipoEstrategia,
			DesktopCantidadProductos = @DesktopCantidadProductos,
			MobileCantidadProductos = @MobileCantidadProductos,
			DesktopActivo = @DesktopActivo,
			MobileActivo = @MobileActivo,
			UrlSeccion = @UrlSeccion
		WHERE ConfiguracionOfertasHomeID = @ConfiguracionOfertasHomeID;
		set @insertedId = @ConfiguracionPaisID;
	END
END
GO
/*end*/

USE BelcorpGuatemala
GO

CREATE PROCEDURE [dbo].[ConfiguracionOfertasHomeList]
	@CampaniaId int
AS
BEGIN
	SET NOCOUNT ON;
	IF(@CampaniaId = 0)
		SELECT * FROM ConfiguracionOfertasHome;
	ELSE 
		SELECT * FROM ConfiguracionOfertasHome WHERE CampaniaID = @CampaniaId;
END
GO

CREATE PROCEDURE [dbo].[ConfiguracionOfertasHomeGet] 
	@ConfiguracionOfertasHomeID int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT * FROM ConfiguracionOfertasHome AS P WHERE 
	P.ConfiguracionOfertasHomeID = @ConfiguracionOfertasHomeID
END
GO

CREATE PROCEDURE [dbo].[ConfiguracionOfertasHomeUpdate] 
	@ConfiguracionOfertasHomeID int,
	@ConfiguracionPaisID int,
	@CampaniaID int,
	@DesktopOrden int,
	@MobileOrden int,
	@DesktopImagenFondo varchar(250),
	@MobileImagenFondo varchar(250),
	@DesktopTitulo varchar(250),
	@MobileTitulo varchar(250),
	@DesktopSubTitulo varchar(250),
	@MobileSubTitulo varchar(250),
	@DesktopTipoPresentacion int,
	@MobileTipoPresentacion int,
	@DesktopTipoEstrategia varchar(250),
	@MobileTipoEstrategia varchar(250),
	@DesktopCantidadProductos int,
	@MobileCantidadProductos int,
	@DesktopActivo bit,
	@MobileActivo bit,
	@UrlSeccion varchar(250)
	AS 
BEGIN
SET NOCOUNT ON
DECLARE @InsertedId int = 0;
IF(@ConfiguracionOfertasHomeID = 0)
	BEGIN
		INSERT INTO ConfiguracionOfertasHome (ConfiguracionPaisID,
				CampaniaID,
				DesktopOrden,
				MobileOrden,
				DesktopImagenFondo,
				MobileImagenFondo,
				DesktopTitulo,
				MobileTitulo,
				DesktopSubTitulo,
				MobileSubTitulo,
				DesktopTipoPresentacion,
				MobileTipoPresentacion,
				DesktopTipoEstrategia,
				MobileTipoEstrategia,
				DesktopCantidadProductos,
				MobileCantidadProductos,
				DesktopActivo,
				MobileActivo,
				UrlSeccion)
		VALUES (@ConfiguracionPaisID,
				@CampaniaID,
				@DesktopOrden,
				@MobileOrden,
				@DesktopImagenFondo,
				@MobileImagenFondo,
				@DesktopTitulo,
				@MobileTitulo,
				@DesktopSubTitulo,
				@MobileSubTitulo,
				@DesktopTipoPresentacion,
				@MobileTipoPresentacion,
				@DesktopTipoEstrategia,
				@MobileTipoEstrategia,
				@DesktopCantidadProductos,
				@MobileCantidadProductos,
				@DesktopActivo,
				@MobileActivo,
				@UrlSeccion);
		set @insertedId = scope_identity();
	END
ELSE 
	BEGIN
		UPDATE ConfiguracionOfertasHome SET
			ConfiguracionPaisID = @ConfiguracionPaisID,
			CampaniaID = @CampaniaID,
			DesktopOrden = @DesktopOrden,
			MobileOrden = @MobileOrden,
			DesktopImagenFondo = @DesktopImagenFondo,
			MobileImagenFondo = @MobileImagenFondo,
			DesktopTitulo = @DesktopTitulo,
			MobileTitulo = @MobileTitulo,
			DesktopSubTitulo = @DesktopSubTitulo,
			MobileSubTitulo = @MobileSubTitulo,
			DesktopTipoPresentacion = @DesktopTipoPresentacion,
			MobileTipoPresentacion = @MobileTipoPresentacion,
			DesktopTipoEstrategia = @DesktopTipoEstrategia,
			MobileTipoEstrategia = @MobileTipoEstrategia,
			DesktopCantidadProductos = @DesktopCantidadProductos,
			MobileCantidadProductos = @MobileCantidadProductos,
			DesktopActivo = @DesktopActivo,
			MobileActivo = @MobileActivo,
			UrlSeccion = @UrlSeccion
		WHERE ConfiguracionOfertasHomeID = @ConfiguracionOfertasHomeID;
		set @insertedId = @ConfiguracionPaisID;
	END
END
GO
/*end*/

USE BelcorpEcuador
GO

CREATE PROCEDURE [dbo].[ConfiguracionOfertasHomeList]
	@CampaniaId int
AS
BEGIN
	SET NOCOUNT ON;
	IF(@CampaniaId = 0)
		SELECT * FROM ConfiguracionOfertasHome;
	ELSE 
		SELECT * FROM ConfiguracionOfertasHome WHERE CampaniaID = @CampaniaId;
END
GO

CREATE PROCEDURE [dbo].[ConfiguracionOfertasHomeGet] 
	@ConfiguracionOfertasHomeID int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT * FROM ConfiguracionOfertasHome AS P WHERE 
	P.ConfiguracionOfertasHomeID = @ConfiguracionOfertasHomeID
END
GO

CREATE PROCEDURE [dbo].[ConfiguracionOfertasHomeUpdate] 
	@ConfiguracionOfertasHomeID int,
	@ConfiguracionPaisID int,
	@CampaniaID int,
	@DesktopOrden int,
	@MobileOrden int,
	@DesktopImagenFondo varchar(250),
	@MobileImagenFondo varchar(250),
	@DesktopTitulo varchar(250),
	@MobileTitulo varchar(250),
	@DesktopSubTitulo varchar(250),
	@MobileSubTitulo varchar(250),
	@DesktopTipoPresentacion int,
	@MobileTipoPresentacion int,
	@DesktopTipoEstrategia varchar(250),
	@MobileTipoEstrategia varchar(250),
	@DesktopCantidadProductos int,
	@MobileCantidadProductos int,
	@DesktopActivo bit,
	@MobileActivo bit,
	@UrlSeccion varchar(250)
	AS 
BEGIN
SET NOCOUNT ON
DECLARE @InsertedId int = 0;
IF(@ConfiguracionOfertasHomeID = 0)
	BEGIN
		INSERT INTO ConfiguracionOfertasHome (ConfiguracionPaisID,
				CampaniaID,
				DesktopOrden,
				MobileOrden,
				DesktopImagenFondo,
				MobileImagenFondo,
				DesktopTitulo,
				MobileTitulo,
				DesktopSubTitulo,
				MobileSubTitulo,
				DesktopTipoPresentacion,
				MobileTipoPresentacion,
				DesktopTipoEstrategia,
				MobileTipoEstrategia,
				DesktopCantidadProductos,
				MobileCantidadProductos,
				DesktopActivo,
				MobileActivo,
				UrlSeccion)
		VALUES (@ConfiguracionPaisID,
				@CampaniaID,
				@DesktopOrden,
				@MobileOrden,
				@DesktopImagenFondo,
				@MobileImagenFondo,
				@DesktopTitulo,
				@MobileTitulo,
				@DesktopSubTitulo,
				@MobileSubTitulo,
				@DesktopTipoPresentacion,
				@MobileTipoPresentacion,
				@DesktopTipoEstrategia,
				@MobileTipoEstrategia,
				@DesktopCantidadProductos,
				@MobileCantidadProductos,
				@DesktopActivo,
				@MobileActivo,
				@UrlSeccion);
		set @insertedId = scope_identity();
	END
ELSE 
	BEGIN
		UPDATE ConfiguracionOfertasHome SET
			ConfiguracionPaisID = @ConfiguracionPaisID,
			CampaniaID = @CampaniaID,
			DesktopOrden = @DesktopOrden,
			MobileOrden = @MobileOrden,
			DesktopImagenFondo = @DesktopImagenFondo,
			MobileImagenFondo = @MobileImagenFondo,
			DesktopTitulo = @DesktopTitulo,
			MobileTitulo = @MobileTitulo,
			DesktopSubTitulo = @DesktopSubTitulo,
			MobileSubTitulo = @MobileSubTitulo,
			DesktopTipoPresentacion = @DesktopTipoPresentacion,
			MobileTipoPresentacion = @MobileTipoPresentacion,
			DesktopTipoEstrategia = @DesktopTipoEstrategia,
			MobileTipoEstrategia = @MobileTipoEstrategia,
			DesktopCantidadProductos = @DesktopCantidadProductos,
			MobileCantidadProductos = @MobileCantidadProductos,
			DesktopActivo = @DesktopActivo,
			MobileActivo = @MobileActivo,
			UrlSeccion = @UrlSeccion
		WHERE ConfiguracionOfertasHomeID = @ConfiguracionOfertasHomeID;
		set @insertedId = @ConfiguracionPaisID;
	END
END
GO
/*end*/

USE BelcorpDominicana
GO

CREATE PROCEDURE [dbo].[ConfiguracionOfertasHomeList]
	@CampaniaId int
AS
BEGIN
	SET NOCOUNT ON;
	IF(@CampaniaId = 0)
		SELECT * FROM ConfiguracionOfertasHome;
	ELSE 
		SELECT * FROM ConfiguracionOfertasHome WHERE CampaniaID = @CampaniaId;
END
GO

CREATE PROCEDURE [dbo].[ConfiguracionOfertasHomeGet] 
	@ConfiguracionOfertasHomeID int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT * FROM ConfiguracionOfertasHome AS P WHERE 
	P.ConfiguracionOfertasHomeID = @ConfiguracionOfertasHomeID
END
GO

CREATE PROCEDURE [dbo].[ConfiguracionOfertasHomeUpdate] 
	@ConfiguracionOfertasHomeID int,
	@ConfiguracionPaisID int,
	@CampaniaID int,
	@DesktopOrden int,
	@MobileOrden int,
	@DesktopImagenFondo varchar(250),
	@MobileImagenFondo varchar(250),
	@DesktopTitulo varchar(250),
	@MobileTitulo varchar(250),
	@DesktopSubTitulo varchar(250),
	@MobileSubTitulo varchar(250),
	@DesktopTipoPresentacion int,
	@MobileTipoPresentacion int,
	@DesktopTipoEstrategia varchar(250),
	@MobileTipoEstrategia varchar(250),
	@DesktopCantidadProductos int,
	@MobileCantidadProductos int,
	@DesktopActivo bit,
	@MobileActivo bit,
	@UrlSeccion varchar(250)
	AS 
BEGIN
SET NOCOUNT ON
DECLARE @InsertedId int = 0;
IF(@ConfiguracionOfertasHomeID = 0)
	BEGIN
		INSERT INTO ConfiguracionOfertasHome (ConfiguracionPaisID,
				CampaniaID,
				DesktopOrden,
				MobileOrden,
				DesktopImagenFondo,
				MobileImagenFondo,
				DesktopTitulo,
				MobileTitulo,
				DesktopSubTitulo,
				MobileSubTitulo,
				DesktopTipoPresentacion,
				MobileTipoPresentacion,
				DesktopTipoEstrategia,
				MobileTipoEstrategia,
				DesktopCantidadProductos,
				MobileCantidadProductos,
				DesktopActivo,
				MobileActivo,
				UrlSeccion)
		VALUES (@ConfiguracionPaisID,
				@CampaniaID,
				@DesktopOrden,
				@MobileOrden,
				@DesktopImagenFondo,
				@MobileImagenFondo,
				@DesktopTitulo,
				@MobileTitulo,
				@DesktopSubTitulo,
				@MobileSubTitulo,
				@DesktopTipoPresentacion,
				@MobileTipoPresentacion,
				@DesktopTipoEstrategia,
				@MobileTipoEstrategia,
				@DesktopCantidadProductos,
				@MobileCantidadProductos,
				@DesktopActivo,
				@MobileActivo,
				@UrlSeccion);
		set @insertedId = scope_identity();
	END
ELSE 
	BEGIN
		UPDATE ConfiguracionOfertasHome SET
			ConfiguracionPaisID = @ConfiguracionPaisID,
			CampaniaID = @CampaniaID,
			DesktopOrden = @DesktopOrden,
			MobileOrden = @MobileOrden,
			DesktopImagenFondo = @DesktopImagenFondo,
			MobileImagenFondo = @MobileImagenFondo,
			DesktopTitulo = @DesktopTitulo,
			MobileTitulo = @MobileTitulo,
			DesktopSubTitulo = @DesktopSubTitulo,
			MobileSubTitulo = @MobileSubTitulo,
			DesktopTipoPresentacion = @DesktopTipoPresentacion,
			MobileTipoPresentacion = @MobileTipoPresentacion,
			DesktopTipoEstrategia = @DesktopTipoEstrategia,
			MobileTipoEstrategia = @MobileTipoEstrategia,
			DesktopCantidadProductos = @DesktopCantidadProductos,
			MobileCantidadProductos = @MobileCantidadProductos,
			DesktopActivo = @DesktopActivo,
			MobileActivo = @MobileActivo,
			UrlSeccion = @UrlSeccion
		WHERE ConfiguracionOfertasHomeID = @ConfiguracionOfertasHomeID;
		set @insertedId = @ConfiguracionPaisID;
	END
END
GO
/*end*/

USE BelcorpCostaRica
GO

CREATE PROCEDURE [dbo].[ConfiguracionOfertasHomeList]
	@CampaniaId int
AS
BEGIN
	SET NOCOUNT ON;
	IF(@CampaniaId = 0)
		SELECT * FROM ConfiguracionOfertasHome;
	ELSE 
		SELECT * FROM ConfiguracionOfertasHome WHERE CampaniaID = @CampaniaId;
END
GO

CREATE PROCEDURE [dbo].[ConfiguracionOfertasHomeGet] 
	@ConfiguracionOfertasHomeID int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT * FROM ConfiguracionOfertasHome AS P WHERE 
	P.ConfiguracionOfertasHomeID = @ConfiguracionOfertasHomeID
END
GO

CREATE PROCEDURE [dbo].[ConfiguracionOfertasHomeUpdate] 
	@ConfiguracionOfertasHomeID int,
	@ConfiguracionPaisID int,
	@CampaniaID int,
	@DesktopOrden int,
	@MobileOrden int,
	@DesktopImagenFondo varchar(250),
	@MobileImagenFondo varchar(250),
	@DesktopTitulo varchar(250),
	@MobileTitulo varchar(250),
	@DesktopSubTitulo varchar(250),
	@MobileSubTitulo varchar(250),
	@DesktopTipoPresentacion int,
	@MobileTipoPresentacion int,
	@DesktopTipoEstrategia varchar(250),
	@MobileTipoEstrategia varchar(250),
	@DesktopCantidadProductos int,
	@MobileCantidadProductos int,
	@DesktopActivo bit,
	@MobileActivo bit,
	@UrlSeccion varchar(250)
	AS 
BEGIN
SET NOCOUNT ON
DECLARE @InsertedId int = 0;
IF(@ConfiguracionOfertasHomeID = 0)
	BEGIN
		INSERT INTO ConfiguracionOfertasHome (ConfiguracionPaisID,
				CampaniaID,
				DesktopOrden,
				MobileOrden,
				DesktopImagenFondo,
				MobileImagenFondo,
				DesktopTitulo,
				MobileTitulo,
				DesktopSubTitulo,
				MobileSubTitulo,
				DesktopTipoPresentacion,
				MobileTipoPresentacion,
				DesktopTipoEstrategia,
				MobileTipoEstrategia,
				DesktopCantidadProductos,
				MobileCantidadProductos,
				DesktopActivo,
				MobileActivo,
				UrlSeccion)
		VALUES (@ConfiguracionPaisID,
				@CampaniaID,
				@DesktopOrden,
				@MobileOrden,
				@DesktopImagenFondo,
				@MobileImagenFondo,
				@DesktopTitulo,
				@MobileTitulo,
				@DesktopSubTitulo,
				@MobileSubTitulo,
				@DesktopTipoPresentacion,
				@MobileTipoPresentacion,
				@DesktopTipoEstrategia,
				@MobileTipoEstrategia,
				@DesktopCantidadProductos,
				@MobileCantidadProductos,
				@DesktopActivo,
				@MobileActivo,
				@UrlSeccion);
		set @insertedId = scope_identity();
	END
ELSE 
	BEGIN
		UPDATE ConfiguracionOfertasHome SET
			ConfiguracionPaisID = @ConfiguracionPaisID,
			CampaniaID = @CampaniaID,
			DesktopOrden = @DesktopOrden,
			MobileOrden = @MobileOrden,
			DesktopImagenFondo = @DesktopImagenFondo,
			MobileImagenFondo = @MobileImagenFondo,
			DesktopTitulo = @DesktopTitulo,
			MobileTitulo = @MobileTitulo,
			DesktopSubTitulo = @DesktopSubTitulo,
			MobileSubTitulo = @MobileSubTitulo,
			DesktopTipoPresentacion = @DesktopTipoPresentacion,
			MobileTipoPresentacion = @MobileTipoPresentacion,
			DesktopTipoEstrategia = @DesktopTipoEstrategia,
			MobileTipoEstrategia = @MobileTipoEstrategia,
			DesktopCantidadProductos = @DesktopCantidadProductos,
			MobileCantidadProductos = @MobileCantidadProductos,
			DesktopActivo = @DesktopActivo,
			MobileActivo = @MobileActivo,
			UrlSeccion = @UrlSeccion
		WHERE ConfiguracionOfertasHomeID = @ConfiguracionOfertasHomeID;
		set @insertedId = @ConfiguracionPaisID;
	END
END
GO
/*end*/

USE BelcorpChile
GO

CREATE PROCEDURE [dbo].[ConfiguracionOfertasHomeList]
	@CampaniaId int
AS
BEGIN
	SET NOCOUNT ON;
	IF(@CampaniaId = 0)
		SELECT * FROM ConfiguracionOfertasHome;
	ELSE 
		SELECT * FROM ConfiguracionOfertasHome WHERE CampaniaID = @CampaniaId;
END
GO

CREATE PROCEDURE [dbo].[ConfiguracionOfertasHomeGet] 
	@ConfiguracionOfertasHomeID int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT * FROM ConfiguracionOfertasHome AS P WHERE 
	P.ConfiguracionOfertasHomeID = @ConfiguracionOfertasHomeID
END
GO

CREATE PROCEDURE [dbo].[ConfiguracionOfertasHomeUpdate] 
	@ConfiguracionOfertasHomeID int,
	@ConfiguracionPaisID int,
	@CampaniaID int,
	@DesktopOrden int,
	@MobileOrden int,
	@DesktopImagenFondo varchar(250),
	@MobileImagenFondo varchar(250),
	@DesktopTitulo varchar(250),
	@MobileTitulo varchar(250),
	@DesktopSubTitulo varchar(250),
	@MobileSubTitulo varchar(250),
	@DesktopTipoPresentacion int,
	@MobileTipoPresentacion int,
	@DesktopTipoEstrategia varchar(250),
	@MobileTipoEstrategia varchar(250),
	@DesktopCantidadProductos int,
	@MobileCantidadProductos int,
	@DesktopActivo bit,
	@MobileActivo bit,
	@UrlSeccion varchar(250)
	AS 
BEGIN
SET NOCOUNT ON
DECLARE @InsertedId int = 0;
IF(@ConfiguracionOfertasHomeID = 0)
	BEGIN
		INSERT INTO ConfiguracionOfertasHome (ConfiguracionPaisID,
				CampaniaID,
				DesktopOrden,
				MobileOrden,
				DesktopImagenFondo,
				MobileImagenFondo,
				DesktopTitulo,
				MobileTitulo,
				DesktopSubTitulo,
				MobileSubTitulo,
				DesktopTipoPresentacion,
				MobileTipoPresentacion,
				DesktopTipoEstrategia,
				MobileTipoEstrategia,
				DesktopCantidadProductos,
				MobileCantidadProductos,
				DesktopActivo,
				MobileActivo,
				UrlSeccion)
		VALUES (@ConfiguracionPaisID,
				@CampaniaID,
				@DesktopOrden,
				@MobileOrden,
				@DesktopImagenFondo,
				@MobileImagenFondo,
				@DesktopTitulo,
				@MobileTitulo,
				@DesktopSubTitulo,
				@MobileSubTitulo,
				@DesktopTipoPresentacion,
				@MobileTipoPresentacion,
				@DesktopTipoEstrategia,
				@MobileTipoEstrategia,
				@DesktopCantidadProductos,
				@MobileCantidadProductos,
				@DesktopActivo,
				@MobileActivo,
				@UrlSeccion);
		set @insertedId = scope_identity();
	END
ELSE 
	BEGIN
		UPDATE ConfiguracionOfertasHome SET
			ConfiguracionPaisID = @ConfiguracionPaisID,
			CampaniaID = @CampaniaID,
			DesktopOrden = @DesktopOrden,
			MobileOrden = @MobileOrden,
			DesktopImagenFondo = @DesktopImagenFondo,
			MobileImagenFondo = @MobileImagenFondo,
			DesktopTitulo = @DesktopTitulo,
			MobileTitulo = @MobileTitulo,
			DesktopSubTitulo = @DesktopSubTitulo,
			MobileSubTitulo = @MobileSubTitulo,
			DesktopTipoPresentacion = @DesktopTipoPresentacion,
			MobileTipoPresentacion = @MobileTipoPresentacion,
			DesktopTipoEstrategia = @DesktopTipoEstrategia,
			MobileTipoEstrategia = @MobileTipoEstrategia,
			DesktopCantidadProductos = @DesktopCantidadProductos,
			MobileCantidadProductos = @MobileCantidadProductos,
			DesktopActivo = @DesktopActivo,
			MobileActivo = @MobileActivo,
			UrlSeccion = @UrlSeccion
		WHERE ConfiguracionOfertasHomeID = @ConfiguracionOfertasHomeID;
		set @insertedId = @ConfiguracionPaisID;
	END
END
GO
/*end*/

USE BelcorpBolivia
GO

CREATE PROCEDURE [dbo].[ConfiguracionOfertasHomeList]
	@CampaniaId int
AS
BEGIN
	SET NOCOUNT ON;
	IF(@CampaniaId = 0)
		SELECT * FROM ConfiguracionOfertasHome;
	ELSE 
		SELECT * FROM ConfiguracionOfertasHome WHERE CampaniaID = @CampaniaId;
END
GO

CREATE PROCEDURE [dbo].[ConfiguracionOfertasHomeGet] 
	@ConfiguracionOfertasHomeID int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT * FROM ConfiguracionOfertasHome AS P WHERE 
	P.ConfiguracionOfertasHomeID = @ConfiguracionOfertasHomeID
END
GO

CREATE PROCEDURE [dbo].[ConfiguracionOfertasHomeUpdate] 
	@ConfiguracionOfertasHomeID int,
	@ConfiguracionPaisID int,
	@CampaniaID int,
	@DesktopOrden int,
	@MobileOrden int,
	@DesktopImagenFondo varchar(250),
	@MobileImagenFondo varchar(250),
	@DesktopTitulo varchar(250),
	@MobileTitulo varchar(250),
	@DesktopSubTitulo varchar(250),
	@MobileSubTitulo varchar(250),
	@DesktopTipoPresentacion int,
	@MobileTipoPresentacion int,
	@DesktopTipoEstrategia varchar(250),
	@MobileTipoEstrategia varchar(250),
	@DesktopCantidadProductos int,
	@MobileCantidadProductos int,
	@DesktopActivo bit,
	@MobileActivo bit,
	@UrlSeccion varchar(250)
	AS 
BEGIN
SET NOCOUNT ON
DECLARE @InsertedId int = 0;
IF(@ConfiguracionOfertasHomeID = 0)
	BEGIN
		INSERT INTO ConfiguracionOfertasHome (ConfiguracionPaisID,
				CampaniaID,
				DesktopOrden,
				MobileOrden,
				DesktopImagenFondo,
				MobileImagenFondo,
				DesktopTitulo,
				MobileTitulo,
				DesktopSubTitulo,
				MobileSubTitulo,
				DesktopTipoPresentacion,
				MobileTipoPresentacion,
				DesktopTipoEstrategia,
				MobileTipoEstrategia,
				DesktopCantidadProductos,
				MobileCantidadProductos,
				DesktopActivo,
				MobileActivo,
				UrlSeccion)
		VALUES (@ConfiguracionPaisID,
				@CampaniaID,
				@DesktopOrden,
				@MobileOrden,
				@DesktopImagenFondo,
				@MobileImagenFondo,
				@DesktopTitulo,
				@MobileTitulo,
				@DesktopSubTitulo,
				@MobileSubTitulo,
				@DesktopTipoPresentacion,
				@MobileTipoPresentacion,
				@DesktopTipoEstrategia,
				@MobileTipoEstrategia,
				@DesktopCantidadProductos,
				@MobileCantidadProductos,
				@DesktopActivo,
				@MobileActivo,
				@UrlSeccion);
		set @insertedId = scope_identity();
	END
ELSE 
	BEGIN
		UPDATE ConfiguracionOfertasHome SET
			ConfiguracionPaisID = @ConfiguracionPaisID,
			CampaniaID = @CampaniaID,
			DesktopOrden = @DesktopOrden,
			MobileOrden = @MobileOrden,
			DesktopImagenFondo = @DesktopImagenFondo,
			MobileImagenFondo = @MobileImagenFondo,
			DesktopTitulo = @DesktopTitulo,
			MobileTitulo = @MobileTitulo,
			DesktopSubTitulo = @DesktopSubTitulo,
			MobileSubTitulo = @MobileSubTitulo,
			DesktopTipoPresentacion = @DesktopTipoPresentacion,
			MobileTipoPresentacion = @MobileTipoPresentacion,
			DesktopTipoEstrategia = @DesktopTipoEstrategia,
			MobileTipoEstrategia = @MobileTipoEstrategia,
			DesktopCantidadProductos = @DesktopCantidadProductos,
			MobileCantidadProductos = @MobileCantidadProductos,
			DesktopActivo = @DesktopActivo,
			MobileActivo = @MobileActivo,
			UrlSeccion = @UrlSeccion
		WHERE ConfiguracionOfertasHomeID = @ConfiguracionOfertasHomeID;
		set @insertedId = @ConfiguracionPaisID;
	END
END
GO