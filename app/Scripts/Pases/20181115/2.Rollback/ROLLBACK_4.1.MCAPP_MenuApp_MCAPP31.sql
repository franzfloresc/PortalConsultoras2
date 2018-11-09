USE BelcorpPeru
GO

/* PROCEDURE GetMenusApp */
IF (OBJECT_ID ( 'dbo.GetMenusApp', 'P' ) IS NULL)
    EXEC('CREATE PROCEDURE dbo.GetMenusApp AS SET NOCOUNT ON;')
GO

/* PROCEDURE GetMenusApp */
CREATE PROCEDURE [dbo].[GetMenusApp]  
	@RevistaDigitalSuscripcion SMALLINT = 1,  
	@VersionMenu SMALLINT = 1,
	@CodigoConsultora VARCHAR(20) = NULL,
	@ZonaID INT = 0,  
	@CampaniaID INT = 0
AS  
BEGIN  
	SET NOCOUNT ON  
	
	DECLARE @IndicadorPermisoFIC INT = 0
	DECLARE @IndicadorPermisoCaminoExito INT = 0
	DECLARE @IndicadorChatbot INT = 0
	  
	IF @CodigoConsultora IS NOT NULL
	BEGIN
		SET @IndicadorPermisoFIC = dbo.GetPermisoFIC(@CodigoConsultora, @ZonaID, @CampaniaID);  
		SELECT @IndicadorPermisoCaminoExito = 1 
		FROM [ods].Zona (NOLOCK)  
		WHERE zonaid = @ZonaID AND [codigo] IN ('0826', '0823', '0803', '0830');
		SET @IndicadorChatbot = dbo.GetPermisoChatbot(@CodigoConsultora);
	END
	
	SELECT   
		MenuAppId,   
		Codigo,   
		CASE WHEN (Codigo = 'MEN_TOP_OFERTAS' OR Codigo = 'MEN_LAT_OFERTAS') AND (@RevistaDigitalSuscripcion = 2 OR @RevistaDigitalSuscripcion = 3) THEN Descripcion2  
			WHEN (Codigo = 'MEN_TOP_OFERTAS' OR Codigo = 'MEN_LAT_OFERTAS') AND (@RevistaDigitalSuscripcion = 4 OR @RevistaDigitalSuscripcion = 5) THEN Descripcion3  
			WHEN (Codigo = 'MEN_LAT_CATALOGOS') AND (@RevistaDigitalSuscripcion = 2 OR @RevistaDigitalSuscripcion = 3 OR @RevistaDigitalSuscripcion = 4) THEN Descripcion2  
			ELSE Descripcion END AS Descripcion,   
		Orden,   
		CodigoMenuPadre,   
		Posicion,  
		Visible  
	FROM dbo.MenuApp (NOLOCK)  
	WHERE VersionMenu = @VersionMenu 
		AND (Codigo NOT IN ('MEN_LAT_PEDIDOFIC', 'MEN_TOP_PEDIDOFIC') OR (Codigo IN ('MEN_LAT_PEDIDOFIC', 'MEN_TOP_PEDIDOFIC') AND @IndicadorPermisoFIC = 1))
		AND (Codigo NOT IN ('MEN_LAT_CAM_EXITO', 'MEN_TOP_CAM_EXITO') OR (Codigo IN ('MEN_LAT_CAM_EXITO', 'MEN_TOP_CAM_EXITO') AND @IndicadorPermisoCaminoExito = 1))
		AND (Codigo NOT IN ('MEN_LAT_CHAT_BOT', 'MEN_TOP_CHAT_BOT') OR (Codigo IN ('MEN_LAT_CHAT_BOT', 'MEN_TOP_CHAT_BOT') AND @IndicadorChatbot = 1))
	SET NOCOUNT OFF  
END
GO

USE BelcorpMexico
GO

/* PROCEDURE GetMenusApp */
IF (OBJECT_ID ( 'dbo.GetMenusApp', 'P' ) IS NULL)
    EXEC('CREATE PROCEDURE dbo.GetMenusApp AS SET NOCOUNT ON;')
GO

/* PROCEDURE GetMenusApp */
CREATE PROCEDURE [dbo].[GetMenusApp]  
	@RevistaDigitalSuscripcion SMALLINT = 1,  
	@VersionMenu SMALLINT = 1,
	@CodigoConsultora VARCHAR(20) = NULL,
	@ZonaID INT = 0,  
	@CampaniaID INT = 0
AS  
BEGIN  
	SET NOCOUNT ON  
	
	DECLARE @IndicadorPermisoFIC INT = 0
	DECLARE @IndicadorPermisoCaminoExito INT = 0
	DECLARE @IndicadorChatbot INT = 0
	  
	IF @CodigoConsultora IS NOT NULL
	BEGIN
		SET @IndicadorPermisoFIC = dbo.GetPermisoFIC(@CodigoConsultora, @ZonaID, @CampaniaID);  
		SELECT @IndicadorPermisoCaminoExito = 1 
		FROM [ods].Zona (NOLOCK)  
		WHERE zonaid = @ZonaID AND [codigo] IN ('0826', '0823', '0803', '0830');
		SET @IndicadorChatbot = dbo.GetPermisoChatbot(@CodigoConsultora);
	END
	
	SELECT   
		MenuAppId,   
		Codigo,   
		CASE WHEN (Codigo = 'MEN_TOP_OFERTAS' OR Codigo = 'MEN_LAT_OFERTAS') AND (@RevistaDigitalSuscripcion = 2 OR @RevistaDigitalSuscripcion = 3) THEN Descripcion2  
			WHEN (Codigo = 'MEN_TOP_OFERTAS' OR Codigo = 'MEN_LAT_OFERTAS') AND (@RevistaDigitalSuscripcion = 4 OR @RevistaDigitalSuscripcion = 5) THEN Descripcion3  
			WHEN (Codigo = 'MEN_LAT_CATALOGOS') AND (@RevistaDigitalSuscripcion = 2 OR @RevistaDigitalSuscripcion = 3 OR @RevistaDigitalSuscripcion = 4) THEN Descripcion2  
			ELSE Descripcion END AS Descripcion,   
		Orden,   
		CodigoMenuPadre,   
		Posicion,  
		Visible  
	FROM dbo.MenuApp (NOLOCK)  
	WHERE VersionMenu = @VersionMenu 
		AND (Codigo NOT IN ('MEN_LAT_PEDIDOFIC', 'MEN_TOP_PEDIDOFIC') OR (Codigo IN ('MEN_LAT_PEDIDOFIC', 'MEN_TOP_PEDIDOFIC') AND @IndicadorPermisoFIC = 1))
		AND (Codigo NOT IN ('MEN_LAT_CAM_EXITO', 'MEN_TOP_CAM_EXITO') OR (Codigo IN ('MEN_LAT_CAM_EXITO', 'MEN_TOP_CAM_EXITO') AND @IndicadorPermisoCaminoExito = 1))
		AND (Codigo NOT IN ('MEN_LAT_CHAT_BOT', 'MEN_TOP_CHAT_BOT') OR (Codigo IN ('MEN_LAT_CHAT_BOT', 'MEN_TOP_CHAT_BOT') AND @IndicadorChatbot = 1))
	SET NOCOUNT OFF  
END
GO

USE BelcorpColombia
GO

/* PROCEDURE GetMenusApp */
IF (OBJECT_ID ( 'dbo.GetMenusApp', 'P' ) IS NULL)
    EXEC('CREATE PROCEDURE dbo.GetMenusApp AS SET NOCOUNT ON;')
GO

/* PROCEDURE GetMenusApp */
CREATE PROCEDURE [dbo].[GetMenusApp]  
	@RevistaDigitalSuscripcion SMALLINT = 1,  
	@VersionMenu SMALLINT = 1,
	@CodigoConsultora VARCHAR(20) = NULL,
	@ZonaID INT = 0,  
	@CampaniaID INT = 0
AS  
BEGIN  
	SET NOCOUNT ON  
	
	DECLARE @IndicadorPermisoFIC INT = 0
	DECLARE @IndicadorPermisoCaminoExito INT = 0
	DECLARE @IndicadorChatbot INT = 0
	  
	IF @CodigoConsultora IS NOT NULL
	BEGIN
		SET @IndicadorPermisoFIC = dbo.GetPermisoFIC(@CodigoConsultora, @ZonaID, @CampaniaID);  
		SELECT @IndicadorPermisoCaminoExito = 1 
		FROM [ods].Zona (NOLOCK)  
		WHERE zonaid = @ZonaID AND [codigo] IN ('0826', '0823', '0803', '0830');
		SET @IndicadorChatbot = dbo.GetPermisoChatbot(@CodigoConsultora);
	END
	
	SELECT   
		MenuAppId,   
		Codigo,   
		CASE WHEN (Codigo = 'MEN_TOP_OFERTAS' OR Codigo = 'MEN_LAT_OFERTAS') AND (@RevistaDigitalSuscripcion = 2 OR @RevistaDigitalSuscripcion = 3) THEN Descripcion2  
			WHEN (Codigo = 'MEN_TOP_OFERTAS' OR Codigo = 'MEN_LAT_OFERTAS') AND (@RevistaDigitalSuscripcion = 4 OR @RevistaDigitalSuscripcion = 5) THEN Descripcion3  
			WHEN (Codigo = 'MEN_LAT_CATALOGOS') AND (@RevistaDigitalSuscripcion = 2 OR @RevistaDigitalSuscripcion = 3 OR @RevistaDigitalSuscripcion = 4) THEN Descripcion2  
			ELSE Descripcion END AS Descripcion,   
		Orden,   
		CodigoMenuPadre,   
		Posicion,  
		Visible  
	FROM dbo.MenuApp (NOLOCK)  
	WHERE VersionMenu = @VersionMenu 
		AND (Codigo NOT IN ('MEN_LAT_PEDIDOFIC', 'MEN_TOP_PEDIDOFIC') OR (Codigo IN ('MEN_LAT_PEDIDOFIC', 'MEN_TOP_PEDIDOFIC') AND @IndicadorPermisoFIC = 1))
		AND (Codigo NOT IN ('MEN_LAT_CAM_EXITO', 'MEN_TOP_CAM_EXITO') OR (Codigo IN ('MEN_LAT_CAM_EXITO', 'MEN_TOP_CAM_EXITO') AND @IndicadorPermisoCaminoExito = 1))
		AND (Codigo NOT IN ('MEN_LAT_CHAT_BOT', 'MEN_TOP_CHAT_BOT') OR (Codigo IN ('MEN_LAT_CHAT_BOT', 'MEN_TOP_CHAT_BOT') AND @IndicadorChatbot = 1))
	SET NOCOUNT OFF  
END
GO

USE BelcorpSalvador
GO

/* PROCEDURE GetMenusApp */
IF (OBJECT_ID ( 'dbo.GetMenusApp', 'P' ) IS NULL)
    EXEC('CREATE PROCEDURE dbo.GetMenusApp AS SET NOCOUNT ON;')
GO

/* PROCEDURE GetMenusApp */
CREATE PROCEDURE [dbo].[GetMenusApp]  
	@RevistaDigitalSuscripcion SMALLINT = 1,  
	@VersionMenu SMALLINT = 1,
	@CodigoConsultora VARCHAR(20) = NULL,
	@ZonaID INT = 0,  
	@CampaniaID INT = 0
AS  
BEGIN  
	SET NOCOUNT ON  
	
	DECLARE @IndicadorPermisoFIC INT = 0
	DECLARE @IndicadorPermisoCaminoExito INT = 0
	DECLARE @IndicadorChatbot INT = 0
	  
	IF @CodigoConsultora IS NOT NULL
	BEGIN
		SET @IndicadorPermisoFIC = dbo.GetPermisoFIC(@CodigoConsultora, @ZonaID, @CampaniaID);  
		SELECT @IndicadorPermisoCaminoExito = 1 
		FROM [ods].Zona (NOLOCK)  
		WHERE zonaid = @ZonaID AND [codigo] IN ('0826', '0823', '0803', '0830');
		SET @IndicadorChatbot = dbo.GetPermisoChatbot(@CodigoConsultora);
	END
	
	SELECT   
		MenuAppId,   
		Codigo,   
		CASE WHEN (Codigo = 'MEN_TOP_OFERTAS' OR Codigo = 'MEN_LAT_OFERTAS') AND (@RevistaDigitalSuscripcion = 2 OR @RevistaDigitalSuscripcion = 3) THEN Descripcion2  
			WHEN (Codigo = 'MEN_TOP_OFERTAS' OR Codigo = 'MEN_LAT_OFERTAS') AND (@RevistaDigitalSuscripcion = 4 OR @RevistaDigitalSuscripcion = 5) THEN Descripcion3  
			WHEN (Codigo = 'MEN_LAT_CATALOGOS') AND (@RevistaDigitalSuscripcion = 2 OR @RevistaDigitalSuscripcion = 3 OR @RevistaDigitalSuscripcion = 4) THEN Descripcion2  
			ELSE Descripcion END AS Descripcion,   
		Orden,   
		CodigoMenuPadre,   
		Posicion,  
		Visible  
	FROM dbo.MenuApp (NOLOCK)  
	WHERE VersionMenu = @VersionMenu 
		AND (Codigo NOT IN ('MEN_LAT_PEDIDOFIC', 'MEN_TOP_PEDIDOFIC') OR (Codigo IN ('MEN_LAT_PEDIDOFIC', 'MEN_TOP_PEDIDOFIC') AND @IndicadorPermisoFIC = 1))
		AND (Codigo NOT IN ('MEN_LAT_CAM_EXITO', 'MEN_TOP_CAM_EXITO') OR (Codigo IN ('MEN_LAT_CAM_EXITO', 'MEN_TOP_CAM_EXITO') AND @IndicadorPermisoCaminoExito = 1))
		AND (Codigo NOT IN ('MEN_LAT_CHAT_BOT', 'MEN_TOP_CHAT_BOT') OR (Codigo IN ('MEN_LAT_CHAT_BOT', 'MEN_TOP_CHAT_BOT') AND @IndicadorChatbot = 1))
	SET NOCOUNT OFF  
END
GO

USE BelcorpPuertoRico
GO

/* PROCEDURE GetMenusApp */
IF (OBJECT_ID ( 'dbo.GetMenusApp', 'P' ) IS NULL)
    EXEC('CREATE PROCEDURE dbo.GetMenusApp AS SET NOCOUNT ON;')
GO

/* PROCEDURE GetMenusApp */
CREATE PROCEDURE [dbo].[GetMenusApp]  
	@RevistaDigitalSuscripcion SMALLINT = 1,  
	@VersionMenu SMALLINT = 1,
	@CodigoConsultora VARCHAR(20) = NULL,
	@ZonaID INT = 0,  
	@CampaniaID INT = 0
AS  
BEGIN  
	SET NOCOUNT ON  
	
	DECLARE @IndicadorPermisoFIC INT = 0
	DECLARE @IndicadorPermisoCaminoExito INT = 0
	DECLARE @IndicadorChatbot INT = 0
	  
	IF @CodigoConsultora IS NOT NULL
	BEGIN
		SET @IndicadorPermisoFIC = dbo.GetPermisoFIC(@CodigoConsultora, @ZonaID, @CampaniaID);  
		SELECT @IndicadorPermisoCaminoExito = 1 
		FROM [ods].Zona (NOLOCK)  
		WHERE zonaid = @ZonaID AND [codigo] IN ('0826', '0823', '0803', '0830');
		SET @IndicadorChatbot = dbo.GetPermisoChatbot(@CodigoConsultora);
	END
	
	SELECT   
		MenuAppId,   
		Codigo,   
		CASE WHEN (Codigo = 'MEN_TOP_OFERTAS' OR Codigo = 'MEN_LAT_OFERTAS') AND (@RevistaDigitalSuscripcion = 2 OR @RevistaDigitalSuscripcion = 3) THEN Descripcion2  
			WHEN (Codigo = 'MEN_TOP_OFERTAS' OR Codigo = 'MEN_LAT_OFERTAS') AND (@RevistaDigitalSuscripcion = 4 OR @RevistaDigitalSuscripcion = 5) THEN Descripcion3  
			WHEN (Codigo = 'MEN_LAT_CATALOGOS') AND (@RevistaDigitalSuscripcion = 2 OR @RevistaDigitalSuscripcion = 3 OR @RevistaDigitalSuscripcion = 4) THEN Descripcion2  
			ELSE Descripcion END AS Descripcion,   
		Orden,   
		CodigoMenuPadre,   
		Posicion,  
		Visible  
	FROM dbo.MenuApp (NOLOCK)  
	WHERE VersionMenu = @VersionMenu 
		AND (Codigo NOT IN ('MEN_LAT_PEDIDOFIC', 'MEN_TOP_PEDIDOFIC') OR (Codigo IN ('MEN_LAT_PEDIDOFIC', 'MEN_TOP_PEDIDOFIC') AND @IndicadorPermisoFIC = 1))
		AND (Codigo NOT IN ('MEN_LAT_CAM_EXITO', 'MEN_TOP_CAM_EXITO') OR (Codigo IN ('MEN_LAT_CAM_EXITO', 'MEN_TOP_CAM_EXITO') AND @IndicadorPermisoCaminoExito = 1))
		AND (Codigo NOT IN ('MEN_LAT_CHAT_BOT', 'MEN_TOP_CHAT_BOT') OR (Codigo IN ('MEN_LAT_CHAT_BOT', 'MEN_TOP_CHAT_BOT') AND @IndicadorChatbot = 1))
	SET NOCOUNT OFF  
END
GO

USE BelcorpPanama
GO

/* PROCEDURE GetMenusApp */
IF (OBJECT_ID ( 'dbo.GetMenusApp', 'P' ) IS NULL)
    EXEC('CREATE PROCEDURE dbo.GetMenusApp AS SET NOCOUNT ON;')
GO

/* PROCEDURE GetMenusApp */
CREATE PROCEDURE [dbo].[GetMenusApp]  
	@RevistaDigitalSuscripcion SMALLINT = 1,  
	@VersionMenu SMALLINT = 1,
	@CodigoConsultora VARCHAR(20) = NULL,
	@ZonaID INT = 0,  
	@CampaniaID INT = 0
AS  
BEGIN  
	SET NOCOUNT ON  
	
	DECLARE @IndicadorPermisoFIC INT = 0
	DECLARE @IndicadorPermisoCaminoExito INT = 0
	DECLARE @IndicadorChatbot INT = 0
	  
	IF @CodigoConsultora IS NOT NULL
	BEGIN
		SET @IndicadorPermisoFIC = dbo.GetPermisoFIC(@CodigoConsultora, @ZonaID, @CampaniaID);  
		SELECT @IndicadorPermisoCaminoExito = 1 
		FROM [ods].Zona (NOLOCK)  
		WHERE zonaid = @ZonaID AND [codigo] IN ('0826', '0823', '0803', '0830');
		SET @IndicadorChatbot = dbo.GetPermisoChatbot(@CodigoConsultora);
	END
	
	SELECT   
		MenuAppId,   
		Codigo,   
		CASE WHEN (Codigo = 'MEN_TOP_OFERTAS' OR Codigo = 'MEN_LAT_OFERTAS') AND (@RevistaDigitalSuscripcion = 2 OR @RevistaDigitalSuscripcion = 3) THEN Descripcion2  
			WHEN (Codigo = 'MEN_TOP_OFERTAS' OR Codigo = 'MEN_LAT_OFERTAS') AND (@RevistaDigitalSuscripcion = 4 OR @RevistaDigitalSuscripcion = 5) THEN Descripcion3  
			WHEN (Codigo = 'MEN_LAT_CATALOGOS') AND (@RevistaDigitalSuscripcion = 2 OR @RevistaDigitalSuscripcion = 3 OR @RevistaDigitalSuscripcion = 4) THEN Descripcion2  
			ELSE Descripcion END AS Descripcion,   
		Orden,   
		CodigoMenuPadre,   
		Posicion,  
		Visible  
	FROM dbo.MenuApp (NOLOCK)  
	WHERE VersionMenu = @VersionMenu 
		AND (Codigo NOT IN ('MEN_LAT_PEDIDOFIC', 'MEN_TOP_PEDIDOFIC') OR (Codigo IN ('MEN_LAT_PEDIDOFIC', 'MEN_TOP_PEDIDOFIC') AND @IndicadorPermisoFIC = 1))
		AND (Codigo NOT IN ('MEN_LAT_CAM_EXITO', 'MEN_TOP_CAM_EXITO') OR (Codigo IN ('MEN_LAT_CAM_EXITO', 'MEN_TOP_CAM_EXITO') AND @IndicadorPermisoCaminoExito = 1))
		AND (Codigo NOT IN ('MEN_LAT_CHAT_BOT', 'MEN_TOP_CHAT_BOT') OR (Codigo IN ('MEN_LAT_CHAT_BOT', 'MEN_TOP_CHAT_BOT') AND @IndicadorChatbot = 1))
	SET NOCOUNT OFF  
END
GO

USE BelcorpGuatemala
GO

/* PROCEDURE GetMenusApp */
IF (OBJECT_ID ( 'dbo.GetMenusApp', 'P' ) IS NULL)
    EXEC('CREATE PROCEDURE dbo.GetMenusApp AS SET NOCOUNT ON;')
GO

/* PROCEDURE GetMenusApp */
CREATE PROCEDURE [dbo].[GetMenusApp]  
	@RevistaDigitalSuscripcion SMALLINT = 1,  
	@VersionMenu SMALLINT = 1,
	@CodigoConsultora VARCHAR(20) = NULL,
	@ZonaID INT = 0,  
	@CampaniaID INT = 0
AS  
BEGIN  
	SET NOCOUNT ON  
	
	DECLARE @IndicadorPermisoFIC INT = 0
	DECLARE @IndicadorPermisoCaminoExito INT = 0
	DECLARE @IndicadorChatbot INT = 0
	  
	IF @CodigoConsultora IS NOT NULL
	BEGIN
		SET @IndicadorPermisoFIC = dbo.GetPermisoFIC(@CodigoConsultora, @ZonaID, @CampaniaID);  
		SELECT @IndicadorPermisoCaminoExito = 1 
		FROM [ods].Zona (NOLOCK)  
		WHERE zonaid = @ZonaID AND [codigo] IN ('0826', '0823', '0803', '0830');
		SET @IndicadorChatbot = dbo.GetPermisoChatbot(@CodigoConsultora);
	END
	
	SELECT   
		MenuAppId,   
		Codigo,   
		CASE WHEN (Codigo = 'MEN_TOP_OFERTAS' OR Codigo = 'MEN_LAT_OFERTAS') AND (@RevistaDigitalSuscripcion = 2 OR @RevistaDigitalSuscripcion = 3) THEN Descripcion2  
			WHEN (Codigo = 'MEN_TOP_OFERTAS' OR Codigo = 'MEN_LAT_OFERTAS') AND (@RevistaDigitalSuscripcion = 4 OR @RevistaDigitalSuscripcion = 5) THEN Descripcion3  
			WHEN (Codigo = 'MEN_LAT_CATALOGOS') AND (@RevistaDigitalSuscripcion = 2 OR @RevistaDigitalSuscripcion = 3 OR @RevistaDigitalSuscripcion = 4) THEN Descripcion2  
			ELSE Descripcion END AS Descripcion,   
		Orden,   
		CodigoMenuPadre,   
		Posicion,  
		Visible  
	FROM dbo.MenuApp (NOLOCK)  
	WHERE VersionMenu = @VersionMenu 
		AND (Codigo NOT IN ('MEN_LAT_PEDIDOFIC', 'MEN_TOP_PEDIDOFIC') OR (Codigo IN ('MEN_LAT_PEDIDOFIC', 'MEN_TOP_PEDIDOFIC') AND @IndicadorPermisoFIC = 1))
		AND (Codigo NOT IN ('MEN_LAT_CAM_EXITO', 'MEN_TOP_CAM_EXITO') OR (Codigo IN ('MEN_LAT_CAM_EXITO', 'MEN_TOP_CAM_EXITO') AND @IndicadorPermisoCaminoExito = 1))
		AND (Codigo NOT IN ('MEN_LAT_CHAT_BOT', 'MEN_TOP_CHAT_BOT') OR (Codigo IN ('MEN_LAT_CHAT_BOT', 'MEN_TOP_CHAT_BOT') AND @IndicadorChatbot = 1))
	SET NOCOUNT OFF  
END
GO

USE BelcorpEcuador
GO

/* PROCEDURE GetMenusApp */
IF (OBJECT_ID ( 'dbo.GetMenusApp', 'P' ) IS NULL)
    EXEC('CREATE PROCEDURE dbo.GetMenusApp AS SET NOCOUNT ON;')
GO

/* PROCEDURE GetMenusApp */
CREATE PROCEDURE [dbo].[GetMenusApp]  
	@RevistaDigitalSuscripcion SMALLINT = 1,  
	@VersionMenu SMALLINT = 1,
	@CodigoConsultora VARCHAR(20) = NULL,
	@ZonaID INT = 0,  
	@CampaniaID INT = 0
AS  
BEGIN  
	SET NOCOUNT ON  
	
	DECLARE @IndicadorPermisoFIC INT = 0
	DECLARE @IndicadorPermisoCaminoExito INT = 0
	DECLARE @IndicadorChatbot INT = 0
	  
	IF @CodigoConsultora IS NOT NULL
	BEGIN
		SET @IndicadorPermisoFIC = dbo.GetPermisoFIC(@CodigoConsultora, @ZonaID, @CampaniaID);  
		SELECT @IndicadorPermisoCaminoExito = 1 
		FROM [ods].Zona (NOLOCK)  
		WHERE zonaid = @ZonaID AND [codigo] IN ('0826', '0823', '0803', '0830');
		SET @IndicadorChatbot = dbo.GetPermisoChatbot(@CodigoConsultora);
	END
	
	SELECT   
		MenuAppId,   
		Codigo,   
		CASE WHEN (Codigo = 'MEN_TOP_OFERTAS' OR Codigo = 'MEN_LAT_OFERTAS') AND (@RevistaDigitalSuscripcion = 2 OR @RevistaDigitalSuscripcion = 3) THEN Descripcion2  
			WHEN (Codigo = 'MEN_TOP_OFERTAS' OR Codigo = 'MEN_LAT_OFERTAS') AND (@RevistaDigitalSuscripcion = 4 OR @RevistaDigitalSuscripcion = 5) THEN Descripcion3  
			WHEN (Codigo = 'MEN_LAT_CATALOGOS') AND (@RevistaDigitalSuscripcion = 2 OR @RevistaDigitalSuscripcion = 3 OR @RevistaDigitalSuscripcion = 4) THEN Descripcion2  
			ELSE Descripcion END AS Descripcion,   
		Orden,   
		CodigoMenuPadre,   
		Posicion,  
		Visible  
	FROM dbo.MenuApp (NOLOCK)  
	WHERE VersionMenu = @VersionMenu 
		AND (Codigo NOT IN ('MEN_LAT_PEDIDOFIC', 'MEN_TOP_PEDIDOFIC') OR (Codigo IN ('MEN_LAT_PEDIDOFIC', 'MEN_TOP_PEDIDOFIC') AND @IndicadorPermisoFIC = 1))
		AND (Codigo NOT IN ('MEN_LAT_CAM_EXITO', 'MEN_TOP_CAM_EXITO') OR (Codigo IN ('MEN_LAT_CAM_EXITO', 'MEN_TOP_CAM_EXITO') AND @IndicadorPermisoCaminoExito = 1))
		AND (Codigo NOT IN ('MEN_LAT_CHAT_BOT', 'MEN_TOP_CHAT_BOT') OR (Codigo IN ('MEN_LAT_CHAT_BOT', 'MEN_TOP_CHAT_BOT') AND @IndicadorChatbot = 1))
	SET NOCOUNT OFF  
END
GO

USE BelcorpDominicana
GO

/* PROCEDURE GetMenusApp */
IF (OBJECT_ID ( 'dbo.GetMenusApp', 'P' ) IS NULL)
    EXEC('CREATE PROCEDURE dbo.GetMenusApp AS SET NOCOUNT ON;')
GO

/* PROCEDURE GetMenusApp */
CREATE PROCEDURE [dbo].[GetMenusApp]  
	@RevistaDigitalSuscripcion SMALLINT = 1,  
	@VersionMenu SMALLINT = 1,
	@CodigoConsultora VARCHAR(20) = NULL,
	@ZonaID INT = 0,  
	@CampaniaID INT = 0
AS  
BEGIN  
	SET NOCOUNT ON  
	
	DECLARE @IndicadorPermisoFIC INT = 0
	DECLARE @IndicadorPermisoCaminoExito INT = 0
	DECLARE @IndicadorChatbot INT = 0
	  
	IF @CodigoConsultora IS NOT NULL
	BEGIN
		SET @IndicadorPermisoFIC = dbo.GetPermisoFIC(@CodigoConsultora, @ZonaID, @CampaniaID);  
		SELECT @IndicadorPermisoCaminoExito = 1 
		FROM [ods].Zona (NOLOCK)  
		WHERE zonaid = @ZonaID AND [codigo] IN ('0826', '0823', '0803', '0830');
		SET @IndicadorChatbot = dbo.GetPermisoChatbot(@CodigoConsultora);
	END
	
	SELECT   
		MenuAppId,   
		Codigo,   
		CASE WHEN (Codigo = 'MEN_TOP_OFERTAS' OR Codigo = 'MEN_LAT_OFERTAS') AND (@RevistaDigitalSuscripcion = 2 OR @RevistaDigitalSuscripcion = 3) THEN Descripcion2  
			WHEN (Codigo = 'MEN_TOP_OFERTAS' OR Codigo = 'MEN_LAT_OFERTAS') AND (@RevistaDigitalSuscripcion = 4 OR @RevistaDigitalSuscripcion = 5) THEN Descripcion3  
			WHEN (Codigo = 'MEN_LAT_CATALOGOS') AND (@RevistaDigitalSuscripcion = 2 OR @RevistaDigitalSuscripcion = 3 OR @RevistaDigitalSuscripcion = 4) THEN Descripcion2  
			ELSE Descripcion END AS Descripcion,   
		Orden,   
		CodigoMenuPadre,   
		Posicion,  
		Visible  
	FROM dbo.MenuApp (NOLOCK)  
	WHERE VersionMenu = @VersionMenu 
		AND (Codigo NOT IN ('MEN_LAT_PEDIDOFIC', 'MEN_TOP_PEDIDOFIC') OR (Codigo IN ('MEN_LAT_PEDIDOFIC', 'MEN_TOP_PEDIDOFIC') AND @IndicadorPermisoFIC = 1))
		AND (Codigo NOT IN ('MEN_LAT_CAM_EXITO', 'MEN_TOP_CAM_EXITO') OR (Codigo IN ('MEN_LAT_CAM_EXITO', 'MEN_TOP_CAM_EXITO') AND @IndicadorPermisoCaminoExito = 1))
		AND (Codigo NOT IN ('MEN_LAT_CHAT_BOT', 'MEN_TOP_CHAT_BOT') OR (Codigo IN ('MEN_LAT_CHAT_BOT', 'MEN_TOP_CHAT_BOT') AND @IndicadorChatbot = 1))
	SET NOCOUNT OFF  
END
GO

USE BelcorpCostaRica
GO

/* PROCEDURE GetMenusApp */
IF (OBJECT_ID ( 'dbo.GetMenusApp', 'P' ) IS NULL)
    EXEC('CREATE PROCEDURE dbo.GetMenusApp AS SET NOCOUNT ON;')
GO

/* PROCEDURE GetMenusApp */
CREATE PROCEDURE [dbo].[GetMenusApp]  
	@RevistaDigitalSuscripcion SMALLINT = 1,  
	@VersionMenu SMALLINT = 1,
	@CodigoConsultora VARCHAR(20) = NULL,
	@ZonaID INT = 0,  
	@CampaniaID INT = 0
AS  
BEGIN  
	SET NOCOUNT ON  
	
	DECLARE @IndicadorPermisoFIC INT = 0
	DECLARE @IndicadorPermisoCaminoExito INT = 0
	DECLARE @IndicadorChatbot INT = 0
	  
	IF @CodigoConsultora IS NOT NULL
	BEGIN
		SET @IndicadorPermisoFIC = dbo.GetPermisoFIC(@CodigoConsultora, @ZonaID, @CampaniaID);  
		SELECT @IndicadorPermisoCaminoExito = 1 
		FROM [ods].Zona (NOLOCK)  
		WHERE zonaid = @ZonaID AND [codigo] IN ('0826', '0823', '0803', '0830');
		SET @IndicadorChatbot = dbo.GetPermisoChatbot(@CodigoConsultora);
	END
	
	SELECT   
		MenuAppId,   
		Codigo,   
		CASE WHEN (Codigo = 'MEN_TOP_OFERTAS' OR Codigo = 'MEN_LAT_OFERTAS') AND (@RevistaDigitalSuscripcion = 2 OR @RevistaDigitalSuscripcion = 3) THEN Descripcion2  
			WHEN (Codigo = 'MEN_TOP_OFERTAS' OR Codigo = 'MEN_LAT_OFERTAS') AND (@RevistaDigitalSuscripcion = 4 OR @RevistaDigitalSuscripcion = 5) THEN Descripcion3  
			WHEN (Codigo = 'MEN_LAT_CATALOGOS') AND (@RevistaDigitalSuscripcion = 2 OR @RevistaDigitalSuscripcion = 3 OR @RevistaDigitalSuscripcion = 4) THEN Descripcion2  
			ELSE Descripcion END AS Descripcion,   
		Orden,   
		CodigoMenuPadre,   
		Posicion,  
		Visible  
	FROM dbo.MenuApp (NOLOCK)  
	WHERE VersionMenu = @VersionMenu 
		AND (Codigo NOT IN ('MEN_LAT_PEDIDOFIC', 'MEN_TOP_PEDIDOFIC') OR (Codigo IN ('MEN_LAT_PEDIDOFIC', 'MEN_TOP_PEDIDOFIC') AND @IndicadorPermisoFIC = 1))
		AND (Codigo NOT IN ('MEN_LAT_CAM_EXITO', 'MEN_TOP_CAM_EXITO') OR (Codigo IN ('MEN_LAT_CAM_EXITO', 'MEN_TOP_CAM_EXITO') AND @IndicadorPermisoCaminoExito = 1))
		AND (Codigo NOT IN ('MEN_LAT_CHAT_BOT', 'MEN_TOP_CHAT_BOT') OR (Codigo IN ('MEN_LAT_CHAT_BOT', 'MEN_TOP_CHAT_BOT') AND @IndicadorChatbot = 1))
	SET NOCOUNT OFF  
END
GO

USE BelcorpChile
GO

/* PROCEDURE GetMenusApp */
IF (OBJECT_ID ( 'dbo.GetMenusApp', 'P' ) IS NULL)
    EXEC('CREATE PROCEDURE dbo.GetMenusApp AS SET NOCOUNT ON;')
GO

/* PROCEDURE GetMenusApp */
CREATE PROCEDURE [dbo].[GetMenusApp]  
	@RevistaDigitalSuscripcion SMALLINT = 1,  
	@VersionMenu SMALLINT = 1,
	@CodigoConsultora VARCHAR(20) = NULL,
	@ZonaID INT = 0,  
	@CampaniaID INT = 0
AS  
BEGIN  
	SET NOCOUNT ON  
	
	DECLARE @IndicadorPermisoFIC INT = 0
	DECLARE @IndicadorPermisoCaminoExito INT = 0
	DECLARE @IndicadorChatbot INT = 0
	  
	IF @CodigoConsultora IS NOT NULL
	BEGIN
		SET @IndicadorPermisoFIC = dbo.GetPermisoFIC(@CodigoConsultora, @ZonaID, @CampaniaID);  
		SELECT @IndicadorPermisoCaminoExito = 1 
		FROM [ods].Zona (NOLOCK)  
		WHERE zonaid = @ZonaID AND [codigo] IN ('0826', '0823', '0803', '0830');
		SET @IndicadorChatbot = dbo.GetPermisoChatbot(@CodigoConsultora);
	END
	
	SELECT   
		MenuAppId,   
		Codigo,   
		CASE WHEN (Codigo = 'MEN_TOP_OFERTAS' OR Codigo = 'MEN_LAT_OFERTAS') AND (@RevistaDigitalSuscripcion = 2 OR @RevistaDigitalSuscripcion = 3) THEN Descripcion2  
			WHEN (Codigo = 'MEN_TOP_OFERTAS' OR Codigo = 'MEN_LAT_OFERTAS') AND (@RevistaDigitalSuscripcion = 4 OR @RevistaDigitalSuscripcion = 5) THEN Descripcion3  
			WHEN (Codigo = 'MEN_LAT_CATALOGOS') AND (@RevistaDigitalSuscripcion = 2 OR @RevistaDigitalSuscripcion = 3 OR @RevistaDigitalSuscripcion = 4) THEN Descripcion2  
			ELSE Descripcion END AS Descripcion,   
		Orden,   
		CodigoMenuPadre,   
		Posicion,  
		Visible  
	FROM dbo.MenuApp (NOLOCK)  
	WHERE VersionMenu = @VersionMenu 
		AND (Codigo NOT IN ('MEN_LAT_PEDIDOFIC', 'MEN_TOP_PEDIDOFIC') OR (Codigo IN ('MEN_LAT_PEDIDOFIC', 'MEN_TOP_PEDIDOFIC') AND @IndicadorPermisoFIC = 1))
		AND (Codigo NOT IN ('MEN_LAT_CAM_EXITO', 'MEN_TOP_CAM_EXITO') OR (Codigo IN ('MEN_LAT_CAM_EXITO', 'MEN_TOP_CAM_EXITO') AND @IndicadorPermisoCaminoExito = 1))
		AND (Codigo NOT IN ('MEN_LAT_CHAT_BOT', 'MEN_TOP_CHAT_BOT') OR (Codigo IN ('MEN_LAT_CHAT_BOT', 'MEN_TOP_CHAT_BOT') AND @IndicadorChatbot = 1))
	SET NOCOUNT OFF  
END
GO

USE BelcorpBolivia
GO

/* PROCEDURE GetMenusApp */
IF (OBJECT_ID ( 'dbo.GetMenusApp', 'P' ) IS NULL)
    EXEC('CREATE PROCEDURE dbo.GetMenusApp AS SET NOCOUNT ON;')
GO

/* PROCEDURE GetMenusApp */
CREATE PROCEDURE [dbo].[GetMenusApp]  
	@RevistaDigitalSuscripcion SMALLINT = 1,  
	@VersionMenu SMALLINT = 1,
	@CodigoConsultora VARCHAR(20) = NULL,
	@ZonaID INT = 0,  
	@CampaniaID INT = 0
AS  
BEGIN  
	SET NOCOUNT ON  
	
	DECLARE @IndicadorPermisoFIC INT = 0
	DECLARE @IndicadorPermisoCaminoExito INT = 0
	DECLARE @IndicadorChatbot INT = 0
	  
	IF @CodigoConsultora IS NOT NULL
	BEGIN
		SET @IndicadorPermisoFIC = dbo.GetPermisoFIC(@CodigoConsultora, @ZonaID, @CampaniaID);  
		SELECT @IndicadorPermisoCaminoExito = 1 
		FROM [ods].Zona (NOLOCK)  
		WHERE zonaid = @ZonaID AND [codigo] IN ('0826', '0823', '0803', '0830');
		SET @IndicadorChatbot = dbo.GetPermisoChatbot(@CodigoConsultora);
	END
	
	SELECT   
		MenuAppId,   
		Codigo,   
		CASE WHEN (Codigo = 'MEN_TOP_OFERTAS' OR Codigo = 'MEN_LAT_OFERTAS') AND (@RevistaDigitalSuscripcion = 2 OR @RevistaDigitalSuscripcion = 3) THEN Descripcion2  
			WHEN (Codigo = 'MEN_TOP_OFERTAS' OR Codigo = 'MEN_LAT_OFERTAS') AND (@RevistaDigitalSuscripcion = 4 OR @RevistaDigitalSuscripcion = 5) THEN Descripcion3  
			WHEN (Codigo = 'MEN_LAT_CATALOGOS') AND (@RevistaDigitalSuscripcion = 2 OR @RevistaDigitalSuscripcion = 3 OR @RevistaDigitalSuscripcion = 4) THEN Descripcion2  
			ELSE Descripcion END AS Descripcion,   
		Orden,   
		CodigoMenuPadre,   
		Posicion,  
		Visible  
	FROM dbo.MenuApp (NOLOCK)  
	WHERE VersionMenu = @VersionMenu 
		AND (Codigo NOT IN ('MEN_LAT_PEDIDOFIC', 'MEN_TOP_PEDIDOFIC') OR (Codigo IN ('MEN_LAT_PEDIDOFIC', 'MEN_TOP_PEDIDOFIC') AND @IndicadorPermisoFIC = 1))
		AND (Codigo NOT IN ('MEN_LAT_CAM_EXITO', 'MEN_TOP_CAM_EXITO') OR (Codigo IN ('MEN_LAT_CAM_EXITO', 'MEN_TOP_CAM_EXITO') AND @IndicadorPermisoCaminoExito = 1))
		AND (Codigo NOT IN ('MEN_LAT_CHAT_BOT', 'MEN_TOP_CHAT_BOT') OR (Codigo IN ('MEN_LAT_CHAT_BOT', 'MEN_TOP_CHAT_BOT') AND @IndicadorChatbot = 1))
	SET NOCOUNT OFF  
END
GO

