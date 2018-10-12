------------------------------------------------
-- Creacion de stores para configuracion Home
------------------------------------------------
USE BelcorpPeru
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionOfertasHomeList]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionOfertasHomeList
GO

CREATE PROCEDURE [dbo].[ConfiguracionOfertasHomeList]
	@CampaniaId int
AS
/*
ConfiguracionOfertasHomeList 201713
ConfiguracionOfertasHomeList 0
*/
BEGIN
	SET NOCOUNT ON;
	
	select
		ConfiguracionOfertasHomeID,ConfiguracionPaisID,CampaniaID,DesktopOrden,MobileOrden,DesktopImagenFondo,MobileImagenFondo,
		DesktopTitulo,MobileTitulo,DesktopSubTitulo,MobileSubTitulo,DesktopTipoPresentacion,MobileTipoPresentacion,
		DesktopTipoEstrategia,MobileTipoEstrategia,DesktopCantidadProductos,MobileCantidadProductos,DesktopActivo,
		MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT
	from ConfiguracionOfertasHome with(nolock)
	where
		@CampaniaId = 0 or CampaniaId = @CampaniaId
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionOfertasHomeGet]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionOfertasHomeGet
GO

CREATE PROCEDURE [dbo].[ConfiguracionOfertasHomeGet]
	@ConfiguracionOfertasHomeID int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT
		ConfiguracionOfertasHomeID,ConfiguracionPaisID,CampaniaID,DesktopOrden,MobileOrden,DesktopImagenFondo,MobileImagenFondo,
		DesktopTitulo,MobileTitulo,DesktopSubTitulo,MobileSubTitulo,DesktopTipoPresentacion,MobileTipoPresentacion,
		DesktopTipoEstrategia,MobileTipoEstrategia,DesktopCantidadProductos,MobileCantidadProductos,DesktopActivo,
		MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT
	FROM ConfiguracionOfertasHome AS P with(nolock)
	WHERE 
		P.ConfiguracionOfertasHomeID = @ConfiguracionOfertasHomeID
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionOfertasHomeUpdate]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionOfertasHomeUpdate
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

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionOfertasHomeList]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionOfertasHomeList
GO

CREATE PROCEDURE [dbo].[ConfiguracionOfertasHomeList]
	@CampaniaId int
AS
/*
ConfiguracionOfertasHomeList 201713
ConfiguracionOfertasHomeList 0
*/
BEGIN
	SET NOCOUNT ON;
	
	select
		ConfiguracionOfertasHomeID,ConfiguracionPaisID,CampaniaID,DesktopOrden,MobileOrden,DesktopImagenFondo,MobileImagenFondo,
		DesktopTitulo,MobileTitulo,DesktopSubTitulo,MobileSubTitulo,DesktopTipoPresentacion,MobileTipoPresentacion,
		DesktopTipoEstrategia,MobileTipoEstrategia,DesktopCantidadProductos,MobileCantidadProductos,DesktopActivo,
		MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT
	from ConfiguracionOfertasHome with(nolock)
	where
		@CampaniaId = 0 or CampaniaId = @CampaniaId
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionOfertasHomeGet]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionOfertasHomeGet
GO

CREATE PROCEDURE [dbo].[ConfiguracionOfertasHomeGet]
	@ConfiguracionOfertasHomeID int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT
		ConfiguracionOfertasHomeID,ConfiguracionPaisID,CampaniaID,DesktopOrden,MobileOrden,DesktopImagenFondo,MobileImagenFondo,
		DesktopTitulo,MobileTitulo,DesktopSubTitulo,MobileSubTitulo,DesktopTipoPresentacion,MobileTipoPresentacion,
		DesktopTipoEstrategia,MobileTipoEstrategia,DesktopCantidadProductos,MobileCantidadProductos,DesktopActivo,
		MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT
	FROM ConfiguracionOfertasHome AS P with(nolock)
	WHERE 
		P.ConfiguracionOfertasHomeID = @ConfiguracionOfertasHomeID
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionOfertasHomeUpdate]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionOfertasHomeUpdate
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

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionOfertasHomeList]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionOfertasHomeList
GO

CREATE PROCEDURE [dbo].[ConfiguracionOfertasHomeList]
	@CampaniaId int
AS
/*
ConfiguracionOfertasHomeList 201713
ConfiguracionOfertasHomeList 0
*/
BEGIN
	SET NOCOUNT ON;
	
	select
		ConfiguracionOfertasHomeID,ConfiguracionPaisID,CampaniaID,DesktopOrden,MobileOrden,DesktopImagenFondo,MobileImagenFondo,
		DesktopTitulo,MobileTitulo,DesktopSubTitulo,MobileSubTitulo,DesktopTipoPresentacion,MobileTipoPresentacion,
		DesktopTipoEstrategia,MobileTipoEstrategia,DesktopCantidadProductos,MobileCantidadProductos,DesktopActivo,
		MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT
	from ConfiguracionOfertasHome with(nolock)
	where
		@CampaniaId = 0 or CampaniaId = @CampaniaId
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionOfertasHomeGet]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionOfertasHomeGet
GO

CREATE PROCEDURE [dbo].[ConfiguracionOfertasHomeGet]
	@ConfiguracionOfertasHomeID int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT
		ConfiguracionOfertasHomeID,ConfiguracionPaisID,CampaniaID,DesktopOrden,MobileOrden,DesktopImagenFondo,MobileImagenFondo,
		DesktopTitulo,MobileTitulo,DesktopSubTitulo,MobileSubTitulo,DesktopTipoPresentacion,MobileTipoPresentacion,
		DesktopTipoEstrategia,MobileTipoEstrategia,DesktopCantidadProductos,MobileCantidadProductos,DesktopActivo,
		MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT
	FROM ConfiguracionOfertasHome AS P with(nolock)
	WHERE 
		P.ConfiguracionOfertasHomeID = @ConfiguracionOfertasHomeID
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionOfertasHomeUpdate]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionOfertasHomeUpdate
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

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionOfertasHomeList]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionOfertasHomeList
GO

CREATE PROCEDURE [dbo].[ConfiguracionOfertasHomeList]
	@CampaniaId int
AS
/*
ConfiguracionOfertasHomeList 201713
ConfiguracionOfertasHomeList 0
*/
BEGIN
	SET NOCOUNT ON;
	
	select
		ConfiguracionOfertasHomeID,ConfiguracionPaisID,CampaniaID,DesktopOrden,MobileOrden,DesktopImagenFondo,MobileImagenFondo,
		DesktopTitulo,MobileTitulo,DesktopSubTitulo,MobileSubTitulo,DesktopTipoPresentacion,MobileTipoPresentacion,
		DesktopTipoEstrategia,MobileTipoEstrategia,DesktopCantidadProductos,MobileCantidadProductos,DesktopActivo,
		MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT
	from ConfiguracionOfertasHome with(nolock)
	where
		@CampaniaId = 0 or CampaniaId = @CampaniaId
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionOfertasHomeGet]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionOfertasHomeGet
GO

CREATE PROCEDURE [dbo].[ConfiguracionOfertasHomeGet]
	@ConfiguracionOfertasHomeID int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT
		ConfiguracionOfertasHomeID,ConfiguracionPaisID,CampaniaID,DesktopOrden,MobileOrden,DesktopImagenFondo,MobileImagenFondo,
		DesktopTitulo,MobileTitulo,DesktopSubTitulo,MobileSubTitulo,DesktopTipoPresentacion,MobileTipoPresentacion,
		DesktopTipoEstrategia,MobileTipoEstrategia,DesktopCantidadProductos,MobileCantidadProductos,DesktopActivo,
		MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT
	FROM ConfiguracionOfertasHome AS P with(nolock)
	WHERE 
		P.ConfiguracionOfertasHomeID = @ConfiguracionOfertasHomeID
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionOfertasHomeUpdate]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionOfertasHomeUpdate
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

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionOfertasHomeList]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionOfertasHomeList
GO

CREATE PROCEDURE [dbo].[ConfiguracionOfertasHomeList]
	@CampaniaId int
AS
/*
ConfiguracionOfertasHomeList 201713
ConfiguracionOfertasHomeList 0
*/
BEGIN
	SET NOCOUNT ON;
	
	select
		ConfiguracionOfertasHomeID,ConfiguracionPaisID,CampaniaID,DesktopOrden,MobileOrden,DesktopImagenFondo,MobileImagenFondo,
		DesktopTitulo,MobileTitulo,DesktopSubTitulo,MobileSubTitulo,DesktopTipoPresentacion,MobileTipoPresentacion,
		DesktopTipoEstrategia,MobileTipoEstrategia,DesktopCantidadProductos,MobileCantidadProductos,DesktopActivo,
		MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT
	from ConfiguracionOfertasHome with(nolock)
	where
		@CampaniaId = 0 or CampaniaId = @CampaniaId
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionOfertasHomeGet]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionOfertasHomeGet
GO

CREATE PROCEDURE [dbo].[ConfiguracionOfertasHomeGet]
	@ConfiguracionOfertasHomeID int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT
		ConfiguracionOfertasHomeID,ConfiguracionPaisID,CampaniaID,DesktopOrden,MobileOrden,DesktopImagenFondo,MobileImagenFondo,
		DesktopTitulo,MobileTitulo,DesktopSubTitulo,MobileSubTitulo,DesktopTipoPresentacion,MobileTipoPresentacion,
		DesktopTipoEstrategia,MobileTipoEstrategia,DesktopCantidadProductos,MobileCantidadProductos,DesktopActivo,
		MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT
	FROM ConfiguracionOfertasHome AS P with(nolock)
	WHERE 
		P.ConfiguracionOfertasHomeID = @ConfiguracionOfertasHomeID
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionOfertasHomeUpdate]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionOfertasHomeUpdate
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

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionOfertasHomeList]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionOfertasHomeList
GO

CREATE PROCEDURE [dbo].[ConfiguracionOfertasHomeList]
	@CampaniaId int
AS
/*
ConfiguracionOfertasHomeList 201713
ConfiguracionOfertasHomeList 0
*/
BEGIN
	SET NOCOUNT ON;
	
	select
		ConfiguracionOfertasHomeID,ConfiguracionPaisID,CampaniaID,DesktopOrden,MobileOrden,DesktopImagenFondo,MobileImagenFondo,
		DesktopTitulo,MobileTitulo,DesktopSubTitulo,MobileSubTitulo,DesktopTipoPresentacion,MobileTipoPresentacion,
		DesktopTipoEstrategia,MobileTipoEstrategia,DesktopCantidadProductos,MobileCantidadProductos,DesktopActivo,
		MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT
	from ConfiguracionOfertasHome with(nolock)
	where
		@CampaniaId = 0 or CampaniaId = @CampaniaId
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionOfertasHomeGet]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionOfertasHomeGet
GO

CREATE PROCEDURE [dbo].[ConfiguracionOfertasHomeGet]
	@ConfiguracionOfertasHomeID int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT
		ConfiguracionOfertasHomeID,ConfiguracionPaisID,CampaniaID,DesktopOrden,MobileOrden,DesktopImagenFondo,MobileImagenFondo,
		DesktopTitulo,MobileTitulo,DesktopSubTitulo,MobileSubTitulo,DesktopTipoPresentacion,MobileTipoPresentacion,
		DesktopTipoEstrategia,MobileTipoEstrategia,DesktopCantidadProductos,MobileCantidadProductos,DesktopActivo,
		MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT
	FROM ConfiguracionOfertasHome AS P with(nolock)
	WHERE 
		P.ConfiguracionOfertasHomeID = @ConfiguracionOfertasHomeID
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionOfertasHomeUpdate]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionOfertasHomeUpdate
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

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionOfertasHomeList]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionOfertasHomeList
GO

CREATE PROCEDURE [dbo].[ConfiguracionOfertasHomeList]
	@CampaniaId int
AS
/*
ConfiguracionOfertasHomeList 201713
ConfiguracionOfertasHomeList 0
*/
BEGIN
	SET NOCOUNT ON;
	
	select
		ConfiguracionOfertasHomeID,ConfiguracionPaisID,CampaniaID,DesktopOrden,MobileOrden,DesktopImagenFondo,MobileImagenFondo,
		DesktopTitulo,MobileTitulo,DesktopSubTitulo,MobileSubTitulo,DesktopTipoPresentacion,MobileTipoPresentacion,
		DesktopTipoEstrategia,MobileTipoEstrategia,DesktopCantidadProductos,MobileCantidadProductos,DesktopActivo,
		MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT
	from ConfiguracionOfertasHome with(nolock)
	where
		@CampaniaId = 0 or CampaniaId = @CampaniaId
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionOfertasHomeGet]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionOfertasHomeGet
GO

CREATE PROCEDURE [dbo].[ConfiguracionOfertasHomeGet]
	@ConfiguracionOfertasHomeID int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT
		ConfiguracionOfertasHomeID,ConfiguracionPaisID,CampaniaID,DesktopOrden,MobileOrden,DesktopImagenFondo,MobileImagenFondo,
		DesktopTitulo,MobileTitulo,DesktopSubTitulo,MobileSubTitulo,DesktopTipoPresentacion,MobileTipoPresentacion,
		DesktopTipoEstrategia,MobileTipoEstrategia,DesktopCantidadProductos,MobileCantidadProductos,DesktopActivo,
		MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT
	FROM ConfiguracionOfertasHome AS P with(nolock)
	WHERE 
		P.ConfiguracionOfertasHomeID = @ConfiguracionOfertasHomeID
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionOfertasHomeUpdate]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionOfertasHomeUpdate
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

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionOfertasHomeList]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionOfertasHomeList
GO

CREATE PROCEDURE [dbo].[ConfiguracionOfertasHomeList]
	@CampaniaId int
AS
/*
ConfiguracionOfertasHomeList 201713
ConfiguracionOfertasHomeList 0
*/
BEGIN
	SET NOCOUNT ON;
	
	select
		ConfiguracionOfertasHomeID,ConfiguracionPaisID,CampaniaID,DesktopOrden,MobileOrden,DesktopImagenFondo,MobileImagenFondo,
		DesktopTitulo,MobileTitulo,DesktopSubTitulo,MobileSubTitulo,DesktopTipoPresentacion,MobileTipoPresentacion,
		DesktopTipoEstrategia,MobileTipoEstrategia,DesktopCantidadProductos,MobileCantidadProductos,DesktopActivo,
		MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT
	from ConfiguracionOfertasHome with(nolock)
	where
		@CampaniaId = 0 or CampaniaId = @CampaniaId
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionOfertasHomeGet]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionOfertasHomeGet
GO

CREATE PROCEDURE [dbo].[ConfiguracionOfertasHomeGet]
	@ConfiguracionOfertasHomeID int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT
		ConfiguracionOfertasHomeID,ConfiguracionPaisID,CampaniaID,DesktopOrden,MobileOrden,DesktopImagenFondo,MobileImagenFondo,
		DesktopTitulo,MobileTitulo,DesktopSubTitulo,MobileSubTitulo,DesktopTipoPresentacion,MobileTipoPresentacion,
		DesktopTipoEstrategia,MobileTipoEstrategia,DesktopCantidadProductos,MobileCantidadProductos,DesktopActivo,
		MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT
	FROM ConfiguracionOfertasHome AS P with(nolock)
	WHERE 
		P.ConfiguracionOfertasHomeID = @ConfiguracionOfertasHomeID
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionOfertasHomeUpdate]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionOfertasHomeUpdate
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

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionOfertasHomeList]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionOfertasHomeList
GO

CREATE PROCEDURE [dbo].[ConfiguracionOfertasHomeList]
	@CampaniaId int
AS
/*
ConfiguracionOfertasHomeList 201713
ConfiguracionOfertasHomeList 0
*/
BEGIN
	SET NOCOUNT ON;
	
	select
		ConfiguracionOfertasHomeID,ConfiguracionPaisID,CampaniaID,DesktopOrden,MobileOrden,DesktopImagenFondo,MobileImagenFondo,
		DesktopTitulo,MobileTitulo,DesktopSubTitulo,MobileSubTitulo,DesktopTipoPresentacion,MobileTipoPresentacion,
		DesktopTipoEstrategia,MobileTipoEstrategia,DesktopCantidadProductos,MobileCantidadProductos,DesktopActivo,
		MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT
	from ConfiguracionOfertasHome with(nolock)
	where
		@CampaniaId = 0 or CampaniaId = @CampaniaId
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionOfertasHomeGet]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionOfertasHomeGet
GO

CREATE PROCEDURE [dbo].[ConfiguracionOfertasHomeGet]
	@ConfiguracionOfertasHomeID int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT
		ConfiguracionOfertasHomeID,ConfiguracionPaisID,CampaniaID,DesktopOrden,MobileOrden,DesktopImagenFondo,MobileImagenFondo,
		DesktopTitulo,MobileTitulo,DesktopSubTitulo,MobileSubTitulo,DesktopTipoPresentacion,MobileTipoPresentacion,
		DesktopTipoEstrategia,MobileTipoEstrategia,DesktopCantidadProductos,MobileCantidadProductos,DesktopActivo,
		MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT
	FROM ConfiguracionOfertasHome AS P with(nolock)
	WHERE 
		P.ConfiguracionOfertasHomeID = @ConfiguracionOfertasHomeID
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionOfertasHomeUpdate]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionOfertasHomeUpdate
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

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionOfertasHomeList]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionOfertasHomeList
GO

CREATE PROCEDURE [dbo].[ConfiguracionOfertasHomeList]
	@CampaniaId int
AS
/*
ConfiguracionOfertasHomeList 201713
ConfiguracionOfertasHomeList 0
*/
BEGIN
	SET NOCOUNT ON;
	
	select
		ConfiguracionOfertasHomeID,ConfiguracionPaisID,CampaniaID,DesktopOrden,MobileOrden,DesktopImagenFondo,MobileImagenFondo,
		DesktopTitulo,MobileTitulo,DesktopSubTitulo,MobileSubTitulo,DesktopTipoPresentacion,MobileTipoPresentacion,
		DesktopTipoEstrategia,MobileTipoEstrategia,DesktopCantidadProductos,MobileCantidadProductos,DesktopActivo,
		MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT
	from ConfiguracionOfertasHome with(nolock)
	where
		@CampaniaId = 0 or CampaniaId = @CampaniaId
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionOfertasHomeGet]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionOfertasHomeGet
GO

CREATE PROCEDURE [dbo].[ConfiguracionOfertasHomeGet]
	@ConfiguracionOfertasHomeID int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT
		ConfiguracionOfertasHomeID,ConfiguracionPaisID,CampaniaID,DesktopOrden,MobileOrden,DesktopImagenFondo,MobileImagenFondo,
		DesktopTitulo,MobileTitulo,DesktopSubTitulo,MobileSubTitulo,DesktopTipoPresentacion,MobileTipoPresentacion,
		DesktopTipoEstrategia,MobileTipoEstrategia,DesktopCantidadProductos,MobileCantidadProductos,DesktopActivo,
		MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT
	FROM ConfiguracionOfertasHome AS P with(nolock)
	WHERE 
		P.ConfiguracionOfertasHomeID = @ConfiguracionOfertasHomeID
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionOfertasHomeUpdate]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionOfertasHomeUpdate
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

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionOfertasHomeList]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionOfertasHomeList
GO

CREATE PROCEDURE [dbo].[ConfiguracionOfertasHomeList]
	@CampaniaId int
AS
/*
ConfiguracionOfertasHomeList 201713
ConfiguracionOfertasHomeList 0
*/
BEGIN
	SET NOCOUNT ON;
	
	select
		ConfiguracionOfertasHomeID,ConfiguracionPaisID,CampaniaID,DesktopOrden,MobileOrden,DesktopImagenFondo,MobileImagenFondo,
		DesktopTitulo,MobileTitulo,DesktopSubTitulo,MobileSubTitulo,DesktopTipoPresentacion,MobileTipoPresentacion,
		DesktopTipoEstrategia,MobileTipoEstrategia,DesktopCantidadProductos,MobileCantidadProductos,DesktopActivo,
		MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT
	from ConfiguracionOfertasHome with(nolock)
	where
		@CampaniaId = 0 or CampaniaId = @CampaniaId
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionOfertasHomeGet]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionOfertasHomeGet
GO

CREATE PROCEDURE [dbo].[ConfiguracionOfertasHomeGet]
	@ConfiguracionOfertasHomeID int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT
		ConfiguracionOfertasHomeID,ConfiguracionPaisID,CampaniaID,DesktopOrden,MobileOrden,DesktopImagenFondo,MobileImagenFondo,
		DesktopTitulo,MobileTitulo,DesktopSubTitulo,MobileSubTitulo,DesktopTipoPresentacion,MobileTipoPresentacion,
		DesktopTipoEstrategia,MobileTipoEstrategia,DesktopCantidadProductos,MobileCantidadProductos,DesktopActivo,
		MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT
	FROM ConfiguracionOfertasHome AS P with(nolock)
	WHERE 
		P.ConfiguracionOfertasHomeID = @ConfiguracionOfertasHomeID
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionOfertasHomeUpdate]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionOfertasHomeUpdate
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

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionOfertasHomeList]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionOfertasHomeList
GO

CREATE PROCEDURE [dbo].[ConfiguracionOfertasHomeList]
	@CampaniaId int
AS
/*
ConfiguracionOfertasHomeList 201713
ConfiguracionOfertasHomeList 0
*/
BEGIN
	SET NOCOUNT ON;
	
	select
		ConfiguracionOfertasHomeID,ConfiguracionPaisID,CampaniaID,DesktopOrden,MobileOrden,DesktopImagenFondo,MobileImagenFondo,
		DesktopTitulo,MobileTitulo,DesktopSubTitulo,MobileSubTitulo,DesktopTipoPresentacion,MobileTipoPresentacion,
		DesktopTipoEstrategia,MobileTipoEstrategia,DesktopCantidadProductos,MobileCantidadProductos,DesktopActivo,
		MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT
	from ConfiguracionOfertasHome with(nolock)
	where
		@CampaniaId = 0 or CampaniaId = @CampaniaId
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionOfertasHomeGet]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionOfertasHomeGet
GO

CREATE PROCEDURE [dbo].[ConfiguracionOfertasHomeGet]
	@ConfiguracionOfertasHomeID int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT
		ConfiguracionOfertasHomeID,ConfiguracionPaisID,CampaniaID,DesktopOrden,MobileOrden,DesktopImagenFondo,MobileImagenFondo,
		DesktopTitulo,MobileTitulo,DesktopSubTitulo,MobileSubTitulo,DesktopTipoPresentacion,MobileTipoPresentacion,
		DesktopTipoEstrategia,MobileTipoEstrategia,DesktopCantidadProductos,MobileCantidadProductos,DesktopActivo,
		MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT
	FROM ConfiguracionOfertasHome AS P with(nolock)
	WHERE 
		P.ConfiguracionOfertasHomeID = @ConfiguracionOfertasHomeID
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionOfertasHomeUpdate]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionOfertasHomeUpdate
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

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionOfertasHomeList]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionOfertasHomeList
GO

CREATE PROCEDURE [dbo].[ConfiguracionOfertasHomeList]
	@CampaniaId int
AS
/*
ConfiguracionOfertasHomeList 201713
ConfiguracionOfertasHomeList 0
*/
BEGIN
	SET NOCOUNT ON;
	
	select
		ConfiguracionOfertasHomeID,ConfiguracionPaisID,CampaniaID,DesktopOrden,MobileOrden,DesktopImagenFondo,MobileImagenFondo,
		DesktopTitulo,MobileTitulo,DesktopSubTitulo,MobileSubTitulo,DesktopTipoPresentacion,MobileTipoPresentacion,
		DesktopTipoEstrategia,MobileTipoEstrategia,DesktopCantidadProductos,MobileCantidadProductos,DesktopActivo,
		MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT
	from ConfiguracionOfertasHome with(nolock)
	where
		@CampaniaId = 0 or CampaniaId = @CampaniaId
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionOfertasHomeGet]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionOfertasHomeGet
GO

CREATE PROCEDURE [dbo].[ConfiguracionOfertasHomeGet]
	@ConfiguracionOfertasHomeID int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT
		ConfiguracionOfertasHomeID,ConfiguracionPaisID,CampaniaID,DesktopOrden,MobileOrden,DesktopImagenFondo,MobileImagenFondo,
		DesktopTitulo,MobileTitulo,DesktopSubTitulo,MobileSubTitulo,DesktopTipoPresentacion,MobileTipoPresentacion,
		DesktopTipoEstrategia,MobileTipoEstrategia,DesktopCantidadProductos,MobileCantidadProductos,DesktopActivo,
		MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT
	FROM ConfiguracionOfertasHome AS P with(nolock)
	WHERE 
		P.ConfiguracionOfertasHomeID = @ConfiguracionOfertasHomeID
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionOfertasHomeUpdate]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionOfertasHomeUpdate
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