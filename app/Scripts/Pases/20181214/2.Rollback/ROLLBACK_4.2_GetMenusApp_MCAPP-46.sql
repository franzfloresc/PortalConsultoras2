USE BelcorpBolivia;
GO

/* GetMenusApp */
IF (OBJECT_ID ( 'dbo.GetMenusApp', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.GetMenusApp AS SET NOCOUNT ON;')
GO

/* PROCEDURE GetMenusApp */
ALTER PROCEDURE [dbo].[GetMenusApp]  
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
	DECLARE @IndicadorCliente INT = 1
	  
	IF @CodigoConsultora IS NOT NULL
	BEGIN
		SET @IndicadorPermisoFIC = dbo.GetPermisoFIC(@CodigoConsultora, @ZonaID, @CampaniaID);  
		SELECT @IndicadorPermisoCaminoExito = 1 
		FROM [ods].Zona (NOLOCK)  
		WHERE zonaid = @ZonaID AND [codigo] IN ('0826', '0823', '0803', '0830');
		IF @CodigoConsultora <> ''
		BEGIN
			SET @IndicadorChatbot = dbo.GetPermisoChatbot(@CodigoConsultora);
			SELECT @IndicadorCliente = 0
			FROM dbo.MenuApp (NOLOCK)
			WHERE VersionMenu = @VersionMenu  AND Codigo = 'MEN_TOP_CHAT_BOT' AND Visible = 1 AND @IndicadorChatbot = 1;
		END
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
		AND (Codigo != 'MEN_TOP_CLIENTES' OR (Codigo = 'MEN_TOP_CLIENTES' AND @IndicadorCliente = 1)) 
	SET NOCOUNT OFF  
END
GO

GO
USE BelcorpChile;
GO

/* GetMenusApp */
IF (OBJECT_ID ( 'dbo.GetMenusApp', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.GetMenusApp AS SET NOCOUNT ON;')
GO

/* PROCEDURE GetMenusApp */
ALTER PROCEDURE [dbo].[GetMenusApp]  
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
	DECLARE @IndicadorCliente INT = 1
	  
	IF @CodigoConsultora IS NOT NULL
	BEGIN
		SET @IndicadorPermisoFIC = dbo.GetPermisoFIC(@CodigoConsultora, @ZonaID, @CampaniaID);  
		SELECT @IndicadorPermisoCaminoExito = 1 
		FROM [ods].Zona (NOLOCK)  
		WHERE zonaid = @ZonaID AND [codigo] IN ('0826', '0823', '0803', '0830');
		IF @CodigoConsultora <> ''
		BEGIN
			SET @IndicadorChatbot = dbo.GetPermisoChatbot(@CodigoConsultora);
			SELECT @IndicadorCliente = 0
			FROM dbo.MenuApp (NOLOCK)
			WHERE VersionMenu = @VersionMenu  AND Codigo = 'MEN_TOP_CHAT_BOT' AND Visible = 1 AND @IndicadorChatbot = 1;
		END
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
		AND (Codigo != 'MEN_TOP_CLIENTES' OR (Codigo = 'MEN_TOP_CLIENTES' AND @IndicadorCliente = 1)) 
	SET NOCOUNT OFF  
END
GO

GO
USE BelcorpColombia;
GO

/* GetMenusApp */
IF (OBJECT_ID ( 'dbo.GetMenusApp', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.GetMenusApp AS SET NOCOUNT ON;')
GO

/* PROCEDURE GetMenusApp */
ALTER PROCEDURE [dbo].[GetMenusApp]  
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
	DECLARE @IndicadorCliente INT = 1
	  
	IF @CodigoConsultora IS NOT NULL
	BEGIN
		SET @IndicadorPermisoFIC = dbo.GetPermisoFIC(@CodigoConsultora, @ZonaID, @CampaniaID);  
		SELECT @IndicadorPermisoCaminoExito = 1 
		FROM [ods].Zona (NOLOCK)  
		WHERE zonaid = @ZonaID AND [codigo] IN ('0826', '0823', '0803', '0830');
		IF @CodigoConsultora <> ''
		BEGIN
			SET @IndicadorChatbot = dbo.GetPermisoChatbot(@CodigoConsultora);
			SELECT @IndicadorCliente = 0
			FROM dbo.MenuApp (NOLOCK)
			WHERE VersionMenu = @VersionMenu  AND Codigo = 'MEN_TOP_CHAT_BOT' AND Visible = 1 AND @IndicadorChatbot = 1;
		END
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
		AND (Codigo != 'MEN_TOP_CLIENTES' OR (Codigo = 'MEN_TOP_CLIENTES' AND @IndicadorCliente = 1)) 
	SET NOCOUNT OFF  
END
GO

GO
USE BelcorpCostaRica;
GO

/* GetMenusApp */
IF (OBJECT_ID ( 'dbo.GetMenusApp', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.GetMenusApp AS SET NOCOUNT ON;')
GO

/* PROCEDURE GetMenusApp */
ALTER PROCEDURE [dbo].[GetMenusApp]  
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
	DECLARE @IndicadorCliente INT = 1
	  
	IF @CodigoConsultora IS NOT NULL
	BEGIN
		SET @IndicadorPermisoFIC = dbo.GetPermisoFIC(@CodigoConsultora, @ZonaID, @CampaniaID);  
		SELECT @IndicadorPermisoCaminoExito = 1 
		FROM [ods].Zona (NOLOCK)  
		WHERE zonaid = @ZonaID AND [codigo] IN ('0826', '0823', '0803', '0830');
		IF @CodigoConsultora <> ''
		BEGIN
			SET @IndicadorChatbot = dbo.GetPermisoChatbot(@CodigoConsultora);
			SELECT @IndicadorCliente = 0
			FROM dbo.MenuApp (NOLOCK)
			WHERE VersionMenu = @VersionMenu  AND Codigo = 'MEN_TOP_CHAT_BOT' AND Visible = 1 AND @IndicadorChatbot = 1;
		END
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
		AND (Codigo != 'MEN_TOP_CLIENTES' OR (Codigo = 'MEN_TOP_CLIENTES' AND @IndicadorCliente = 1)) 
	SET NOCOUNT OFF  
END
GO

GO
USE BelcorpDominicana;
GO

/* GetMenusApp */
IF (OBJECT_ID ( 'dbo.GetMenusApp', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.GetMenusApp AS SET NOCOUNT ON;')
GO

/* PROCEDURE GetMenusApp */
ALTER PROCEDURE [dbo].[GetMenusApp]  
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
	DECLARE @IndicadorCliente INT = 1
	  
	IF @CodigoConsultora IS NOT NULL
	BEGIN
		SET @IndicadorPermisoFIC = dbo.GetPermisoFIC(@CodigoConsultora, @ZonaID, @CampaniaID);  
		SELECT @IndicadorPermisoCaminoExito = 1 
		FROM [ods].Zona (NOLOCK)  
		WHERE zonaid = @ZonaID AND [codigo] IN ('0826', '0823', '0803', '0830');
		IF @CodigoConsultora <> ''
		BEGIN
			SET @IndicadorChatbot = dbo.GetPermisoChatbot(@CodigoConsultora);
			SELECT @IndicadorCliente = 0
			FROM dbo.MenuApp (NOLOCK)
			WHERE VersionMenu = @VersionMenu  AND Codigo = 'MEN_TOP_CHAT_BOT' AND Visible = 1 AND @IndicadorChatbot = 1;
		END
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
		AND (Codigo != 'MEN_TOP_CLIENTES' OR (Codigo = 'MEN_TOP_CLIENTES' AND @IndicadorCliente = 1)) 
	SET NOCOUNT OFF  
END
GO

GO
USE BelcorpEcuador;
GO

/* GetMenusApp */
IF (OBJECT_ID ( 'dbo.GetMenusApp', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.GetMenusApp AS SET NOCOUNT ON;')
GO

/* PROCEDURE GetMenusApp */
ALTER PROCEDURE [dbo].[GetMenusApp]  
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
	DECLARE @IndicadorCliente INT = 1
	  
	IF @CodigoConsultora IS NOT NULL
	BEGIN
		SET @IndicadorPermisoFIC = dbo.GetPermisoFIC(@CodigoConsultora, @ZonaID, @CampaniaID);  
		SELECT @IndicadorPermisoCaminoExito = 1 
		FROM [ods].Zona (NOLOCK)  
		WHERE zonaid = @ZonaID AND [codigo] IN ('0826', '0823', '0803', '0830');
		IF @CodigoConsultora <> ''
		BEGIN
			SET @IndicadorChatbot = dbo.GetPermisoChatbot(@CodigoConsultora);
			SELECT @IndicadorCliente = 0
			FROM dbo.MenuApp (NOLOCK)
			WHERE VersionMenu = @VersionMenu  AND Codigo = 'MEN_TOP_CHAT_BOT' AND Visible = 1 AND @IndicadorChatbot = 1;
		END
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
		AND (Codigo != 'MEN_TOP_CLIENTES' OR (Codigo = 'MEN_TOP_CLIENTES' AND @IndicadorCliente = 1)) 
	SET NOCOUNT OFF  
END
GO

GO
USE BelcorpGuatemala;
GO

/* GetMenusApp */
IF (OBJECT_ID ( 'dbo.GetMenusApp', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.GetMenusApp AS SET NOCOUNT ON;')
GO

/* PROCEDURE GetMenusApp */
ALTER PROCEDURE [dbo].[GetMenusApp]  
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
	DECLARE @IndicadorCliente INT = 1
	  
	IF @CodigoConsultora IS NOT NULL
	BEGIN
		SET @IndicadorPermisoFIC = dbo.GetPermisoFIC(@CodigoConsultora, @ZonaID, @CampaniaID);  
		SELECT @IndicadorPermisoCaminoExito = 1 
		FROM [ods].Zona (NOLOCK)  
		WHERE zonaid = @ZonaID AND [codigo] IN ('0826', '0823', '0803', '0830');
		IF @CodigoConsultora <> ''
		BEGIN
			SET @IndicadorChatbot = dbo.GetPermisoChatbot(@CodigoConsultora);
			SELECT @IndicadorCliente = 0
			FROM dbo.MenuApp (NOLOCK)
			WHERE VersionMenu = @VersionMenu  AND Codigo = 'MEN_TOP_CHAT_BOT' AND Visible = 1 AND @IndicadorChatbot = 1;
		END
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
		AND (Codigo != 'MEN_TOP_CLIENTES' OR (Codigo = 'MEN_TOP_CLIENTES' AND @IndicadorCliente = 1)) 
	SET NOCOUNT OFF  
END
GO

GO
USE BelcorpMexico;
GO

/* GetMenusApp */
IF (OBJECT_ID ( 'dbo.GetMenusApp', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.GetMenusApp AS SET NOCOUNT ON;')
GO

/* PROCEDURE GetMenusApp */
ALTER PROCEDURE [dbo].[GetMenusApp]  
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
	DECLARE @IndicadorCliente INT = 1
	  
	IF @CodigoConsultora IS NOT NULL
	BEGIN
		SET @IndicadorPermisoFIC = dbo.GetPermisoFIC(@CodigoConsultora, @ZonaID, @CampaniaID);  
		SELECT @IndicadorPermisoCaminoExito = 1 
		FROM [ods].Zona (NOLOCK)  
		WHERE zonaid = @ZonaID AND [codigo] IN ('0826', '0823', '0803', '0830');
		IF @CodigoConsultora <> ''
		BEGIN
			SET @IndicadorChatbot = dbo.GetPermisoChatbot(@CodigoConsultora);
			SELECT @IndicadorCliente = 0
			FROM dbo.MenuApp (NOLOCK)
			WHERE VersionMenu = @VersionMenu  AND Codigo = 'MEN_TOP_CHAT_BOT' AND Visible = 1 AND @IndicadorChatbot = 1;
		END
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
		AND (Codigo != 'MEN_TOP_CLIENTES' OR (Codigo = 'MEN_TOP_CLIENTES' AND @IndicadorCliente = 1)) 
	SET NOCOUNT OFF  
END
GO

GO
USE BelcorpPanama;
GO

/* GetMenusApp */
IF (OBJECT_ID ( 'dbo.GetMenusApp', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.GetMenusApp AS SET NOCOUNT ON;')
GO

/* PROCEDURE GetMenusApp */
ALTER PROCEDURE [dbo].[GetMenusApp]  
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
	DECLARE @IndicadorCliente INT = 1
	  
	IF @CodigoConsultora IS NOT NULL
	BEGIN
		SET @IndicadorPermisoFIC = dbo.GetPermisoFIC(@CodigoConsultora, @ZonaID, @CampaniaID);  
		SELECT @IndicadorPermisoCaminoExito = 1 
		FROM [ods].Zona (NOLOCK)  
		WHERE zonaid = @ZonaID AND [codigo] IN ('0826', '0823', '0803', '0830');
		IF @CodigoConsultora <> ''
		BEGIN
			SET @IndicadorChatbot = dbo.GetPermisoChatbot(@CodigoConsultora);
			SELECT @IndicadorCliente = 0
			FROM dbo.MenuApp (NOLOCK)
			WHERE VersionMenu = @VersionMenu  AND Codigo = 'MEN_TOP_CHAT_BOT' AND Visible = 1 AND @IndicadorChatbot = 1;
		END
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
		AND (Codigo != 'MEN_TOP_CLIENTES' OR (Codigo = 'MEN_TOP_CLIENTES' AND @IndicadorCliente = 1)) 
	SET NOCOUNT OFF  
END
GO

GO
USE BelcorpPeru;
GO

/* GetMenusApp */
IF (OBJECT_ID ( 'dbo.GetMenusApp', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.GetMenusApp AS SET NOCOUNT ON;')
GO

/* PROCEDURE GetMenusApp */
ALTER PROCEDURE [dbo].[GetMenusApp]  
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
	DECLARE @IndicadorCliente INT = 1
	  
	IF @CodigoConsultora IS NOT NULL
	BEGIN
		SET @IndicadorPermisoFIC = dbo.GetPermisoFIC(@CodigoConsultora, @ZonaID, @CampaniaID);  
		SELECT @IndicadorPermisoCaminoExito = 1 
		FROM [ods].Zona (NOLOCK)  
		WHERE zonaid = @ZonaID AND [codigo] IN ('0826', '0823', '0803', '0830');
		IF @CodigoConsultora <> ''
		BEGIN
			SET @IndicadorChatbot = dbo.GetPermisoChatbot(@CodigoConsultora);
			SELECT @IndicadorCliente = 0
			FROM dbo.MenuApp (NOLOCK)
			WHERE VersionMenu = @VersionMenu  AND Codigo = 'MEN_TOP_CHAT_BOT' AND Visible = 1 AND @IndicadorChatbot = 1;
		END
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
		AND (Codigo != 'MEN_TOP_CLIENTES' OR (Codigo = 'MEN_TOP_CLIENTES' AND @IndicadorCliente = 1)) 
	SET NOCOUNT OFF  
END
GO

GO
USE BelcorpPuertoRico;
GO

/* GetMenusApp */
IF (OBJECT_ID ( 'dbo.GetMenusApp', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.GetMenusApp AS SET NOCOUNT ON;')
GO

/* PROCEDURE GetMenusApp */
ALTER PROCEDURE [dbo].[GetMenusApp]  
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
	DECLARE @IndicadorCliente INT = 1
	  
	IF @CodigoConsultora IS NOT NULL
	BEGIN
		SET @IndicadorPermisoFIC = dbo.GetPermisoFIC(@CodigoConsultora, @ZonaID, @CampaniaID);  
		SELECT @IndicadorPermisoCaminoExito = 1 
		FROM [ods].Zona (NOLOCK)  
		WHERE zonaid = @ZonaID AND [codigo] IN ('0826', '0823', '0803', '0830');
		IF @CodigoConsultora <> ''
		BEGIN
			SET @IndicadorChatbot = dbo.GetPermisoChatbot(@CodigoConsultora);
			SELECT @IndicadorCliente = 0
			FROM dbo.MenuApp (NOLOCK)
			WHERE VersionMenu = @VersionMenu  AND Codigo = 'MEN_TOP_CHAT_BOT' AND Visible = 1 AND @IndicadorChatbot = 1;
		END
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
		AND (Codigo != 'MEN_TOP_CLIENTES' OR (Codigo = 'MEN_TOP_CLIENTES' AND @IndicadorCliente = 1)) 
	SET NOCOUNT OFF  
END
GO

GO
USE BelcorpSalvador;
GO

/* GetMenusApp */
IF (OBJECT_ID ( 'dbo.GetMenusApp', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.GetMenusApp AS SET NOCOUNT ON;')
GO

/* PROCEDURE GetMenusApp */
ALTER PROCEDURE [dbo].[GetMenusApp]  
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
	DECLARE @IndicadorCliente INT = 1
	  
	IF @CodigoConsultora IS NOT NULL
	BEGIN
		SET @IndicadorPermisoFIC = dbo.GetPermisoFIC(@CodigoConsultora, @ZonaID, @CampaniaID);  
		SELECT @IndicadorPermisoCaminoExito = 1 
		FROM [ods].Zona (NOLOCK)  
		WHERE zonaid = @ZonaID AND [codigo] IN ('0826', '0823', '0803', '0830');
		IF @CodigoConsultora <> ''
		BEGIN
			SET @IndicadorChatbot = dbo.GetPermisoChatbot(@CodigoConsultora);
			SELECT @IndicadorCliente = 0
			FROM dbo.MenuApp (NOLOCK)
			WHERE VersionMenu = @VersionMenu  AND Codigo = 'MEN_TOP_CHAT_BOT' AND Visible = 1 AND @IndicadorChatbot = 1;
		END
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
		AND (Codigo != 'MEN_TOP_CLIENTES' OR (Codigo = 'MEN_TOP_CLIENTES' AND @IndicadorCliente = 1)) 
	SET NOCOUNT OFF  
END
GO

GO
