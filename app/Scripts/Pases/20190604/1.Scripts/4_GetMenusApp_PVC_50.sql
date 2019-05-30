USE [BelcorpBolivia]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
	DECLARE @IndicadorPermisoCaminoBrillante INT = 0
	DECLARE @GETDATE DATE
​
	SET @GETDATE= CAST(GETDATE() AS DATE)
 
	IF @CodigoConsultora IS NOT NULL
	BEGIN
		SET @IndicadorPermisoFIC = dbo.GetPermisoFIC(@CodigoConsultora, @ZonaID, @CampaniaID); 
		SELECT @IndicadorPermisoCaminoExito = 1 
		FROM [ods].Zona (NOLOCK) 
		WHERE zonaid = @ZonaID AND [codigo] IN ('0826', '0823', '0803', '0830');
		SET @IndicadorPermisoCaminoBrillante = dbo.GetPermisoCaminoBrillante(@CodigoConsultora);		
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
		Visible,
		IIF(VigenciaNueva > @GETDATE,1,0) FlagMenuNuevo
	FROM dbo.MenuApp (NOLOCK) 
	WHERE VersionMenu = @VersionMenu 
		AND (Codigo NOT IN ('MEN_LAT_PEDIDOFIC', 'MEN_TOP_PEDIDOFIC') OR (Codigo IN ('MEN_LAT_PEDIDOFIC', 'MEN_TOP_PEDIDOFIC') AND @IndicadorPermisoFIC = 1))
		AND (Codigo NOT IN ('MEN_LAT_CAM_EXITO', 'MEN_TOP_CAM_EXITO') OR (Codigo IN ('MEN_LAT_CAM_EXITO', 'MEN_TOP_CAM_EXITO') AND @IndicadorPermisoCaminoExito = 1))
		AND (Codigo NOT IN ('MEN_LAT_CAMINOBRILLANTE', 'MEN_TOP_CAMINOBRILLANTE') OR (Codigo IN ('MEN_LAT_CAMINOBRILLANTE', 'MEN_TOP_CAMINOBRILLANTE') AND @IndicadorPermisoCaminoBrillante = 1))
		
	SET NOCOUNT OFF 
END
GO 

USE [BelcorpChile]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
	DECLARE @IndicadorPermisoCaminoBrillante INT = 0
	DECLARE @GETDATE DATE
​
	SET @GETDATE= CAST(GETDATE() AS DATE)
 
	IF @CodigoConsultora IS NOT NULL
	BEGIN
		SET @IndicadorPermisoFIC = dbo.GetPermisoFIC(@CodigoConsultora, @ZonaID, @CampaniaID); 
		SELECT @IndicadorPermisoCaminoExito = 1 
		FROM [ods].Zona (NOLOCK) 
		WHERE zonaid = @ZonaID AND [codigo] IN ('0826', '0823', '0803', '0830');
		SET @IndicadorPermisoCaminoBrillante = dbo.GetPermisoCaminoBrillante(@CodigoConsultora);		
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
		Visible,
		IIF(VigenciaNueva > @GETDATE,1,0) FlagMenuNuevo
	FROM dbo.MenuApp (NOLOCK) 
	WHERE VersionMenu = @VersionMenu 
		AND (Codigo NOT IN ('MEN_LAT_PEDIDOFIC', 'MEN_TOP_PEDIDOFIC') OR (Codigo IN ('MEN_LAT_PEDIDOFIC', 'MEN_TOP_PEDIDOFIC') AND @IndicadorPermisoFIC = 1))
		AND (Codigo NOT IN ('MEN_LAT_CAM_EXITO', 'MEN_TOP_CAM_EXITO') OR (Codigo IN ('MEN_LAT_CAM_EXITO', 'MEN_TOP_CAM_EXITO') AND @IndicadorPermisoCaminoExito = 1))
		AND (Codigo NOT IN ('MEN_LAT_CAMINOBRILLANTE', 'MEN_TOP_CAMINOBRILLANTE') OR (Codigo IN ('MEN_LAT_CAMINOBRILLANTE', 'MEN_TOP_CAMINOBRILLANTE') AND @IndicadorPermisoCaminoBrillante = 1))
		
	SET NOCOUNT OFF 
END
GO 

USE [BelcorpColombia]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
	DECLARE @IndicadorPermisoCaminoBrillante INT = 0
	DECLARE @GETDATE DATE
​
	SET @GETDATE= CAST(GETDATE() AS DATE)
 
	IF @CodigoConsultora IS NOT NULL
	BEGIN
		SET @IndicadorPermisoFIC = dbo.GetPermisoFIC(@CodigoConsultora, @ZonaID, @CampaniaID); 
		SELECT @IndicadorPermisoCaminoExito = 1 
		FROM [ods].Zona (NOLOCK) 
		WHERE zonaid = @ZonaID AND [codigo] IN ('0826', '0823', '0803', '0830');
		SET @IndicadorPermisoCaminoBrillante = dbo.GetPermisoCaminoBrillante(@CodigoConsultora);		
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
		Visible,
		IIF(VigenciaNueva > @GETDATE,1,0) FlagMenuNuevo
	FROM dbo.MenuApp (NOLOCK) 
	WHERE VersionMenu = @VersionMenu 
		AND (Codigo NOT IN ('MEN_LAT_PEDIDOFIC', 'MEN_TOP_PEDIDOFIC') OR (Codigo IN ('MEN_LAT_PEDIDOFIC', 'MEN_TOP_PEDIDOFIC') AND @IndicadorPermisoFIC = 1))
		AND (Codigo NOT IN ('MEN_LAT_CAM_EXITO', 'MEN_TOP_CAM_EXITO') OR (Codigo IN ('MEN_LAT_CAM_EXITO', 'MEN_TOP_CAM_EXITO') AND @IndicadorPermisoCaminoExito = 1))
		AND (Codigo NOT IN ('MEN_LAT_CAMINOBRILLANTE', 'MEN_TOP_CAMINOBRILLANTE') OR (Codigo IN ('MEN_LAT_CAMINOBRILLANTE', 'MEN_TOP_CAMINOBRILLANTE') AND @IndicadorPermisoCaminoBrillante = 1))
		
	SET NOCOUNT OFF 
END
GO 

USE [BelcorpCostaRica]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
	DECLARE @IndicadorPermisoCaminoBrillante INT = 0
	DECLARE @GETDATE DATE
​
	SET @GETDATE= CAST(GETDATE() AS DATE)
 
	IF @CodigoConsultora IS NOT NULL
	BEGIN
		SET @IndicadorPermisoFIC = dbo.GetPermisoFIC(@CodigoConsultora, @ZonaID, @CampaniaID); 
		SELECT @IndicadorPermisoCaminoExito = 1 
		FROM [ods].Zona (NOLOCK) 
		WHERE zonaid = @ZonaID AND [codigo] IN ('0826', '0823', '0803', '0830');
		SET @IndicadorPermisoCaminoBrillante = dbo.GetPermisoCaminoBrillante(@CodigoConsultora);		
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
		Visible,
		IIF(VigenciaNueva > @GETDATE,1,0) FlagMenuNuevo
	FROM dbo.MenuApp (NOLOCK) 
	WHERE VersionMenu = @VersionMenu 
		AND (Codigo NOT IN ('MEN_LAT_PEDIDOFIC', 'MEN_TOP_PEDIDOFIC') OR (Codigo IN ('MEN_LAT_PEDIDOFIC', 'MEN_TOP_PEDIDOFIC') AND @IndicadorPermisoFIC = 1))
		AND (Codigo NOT IN ('MEN_LAT_CAM_EXITO', 'MEN_TOP_CAM_EXITO') OR (Codigo IN ('MEN_LAT_CAM_EXITO', 'MEN_TOP_CAM_EXITO') AND @IndicadorPermisoCaminoExito = 1))
		AND (Codigo NOT IN ('MEN_LAT_CAMINOBRILLANTE', 'MEN_TOP_CAMINOBRILLANTE') OR (Codigo IN ('MEN_LAT_CAMINOBRILLANTE', 'MEN_TOP_CAMINOBRILLANTE') AND @IndicadorPermisoCaminoBrillante = 1))
		
	SET NOCOUNT OFF 
END
GO 

USE [BelcorpDominicana]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
	DECLARE @IndicadorPermisoCaminoBrillante INT = 0
	DECLARE @GETDATE DATE
​
	SET @GETDATE= CAST(GETDATE() AS DATE)
 
	IF @CodigoConsultora IS NOT NULL
	BEGIN
		SET @IndicadorPermisoFIC = dbo.GetPermisoFIC(@CodigoConsultora, @ZonaID, @CampaniaID); 
		SELECT @IndicadorPermisoCaminoExito = 1 
		FROM [ods].Zona (NOLOCK) 
		WHERE zonaid = @ZonaID AND [codigo] IN ('0826', '0823', '0803', '0830');
		SET @IndicadorPermisoCaminoBrillante = dbo.GetPermisoCaminoBrillante(@CodigoConsultora);		
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
		Visible,
		IIF(VigenciaNueva > @GETDATE,1,0) FlagMenuNuevo
	FROM dbo.MenuApp (NOLOCK) 
	WHERE VersionMenu = @VersionMenu 
		AND (Codigo NOT IN ('MEN_LAT_PEDIDOFIC', 'MEN_TOP_PEDIDOFIC') OR (Codigo IN ('MEN_LAT_PEDIDOFIC', 'MEN_TOP_PEDIDOFIC') AND @IndicadorPermisoFIC = 1))
		AND (Codigo NOT IN ('MEN_LAT_CAM_EXITO', 'MEN_TOP_CAM_EXITO') OR (Codigo IN ('MEN_LAT_CAM_EXITO', 'MEN_TOP_CAM_EXITO') AND @IndicadorPermisoCaminoExito = 1))
		AND (Codigo NOT IN ('MEN_LAT_CAMINOBRILLANTE', 'MEN_TOP_CAMINOBRILLANTE') OR (Codigo IN ('MEN_LAT_CAMINOBRILLANTE', 'MEN_TOP_CAMINOBRILLANTE') AND @IndicadorPermisoCaminoBrillante = 1))
		
	SET NOCOUNT OFF 
END
GO 

USE [BelcorpEcuador]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
	DECLARE @IndicadorPermisoCaminoBrillante INT = 0
	DECLARE @GETDATE DATE
​
	SET @GETDATE= CAST(GETDATE() AS DATE)
 
	IF @CodigoConsultora IS NOT NULL
	BEGIN
		SET @IndicadorPermisoFIC = dbo.GetPermisoFIC(@CodigoConsultora, @ZonaID, @CampaniaID); 
		SELECT @IndicadorPermisoCaminoExito = 1 
		FROM [ods].Zona (NOLOCK) 
		WHERE zonaid = @ZonaID AND [codigo] IN ('0826', '0823', '0803', '0830');
		SET @IndicadorPermisoCaminoBrillante = dbo.GetPermisoCaminoBrillante(@CodigoConsultora);		
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
		Visible,
		IIF(VigenciaNueva > @GETDATE,1,0) FlagMenuNuevo
	FROM dbo.MenuApp (NOLOCK) 
	WHERE VersionMenu = @VersionMenu 
		AND (Codigo NOT IN ('MEN_LAT_PEDIDOFIC', 'MEN_TOP_PEDIDOFIC') OR (Codigo IN ('MEN_LAT_PEDIDOFIC', 'MEN_TOP_PEDIDOFIC') AND @IndicadorPermisoFIC = 1))
		AND (Codigo NOT IN ('MEN_LAT_CAM_EXITO', 'MEN_TOP_CAM_EXITO') OR (Codigo IN ('MEN_LAT_CAM_EXITO', 'MEN_TOP_CAM_EXITO') AND @IndicadorPermisoCaminoExito = 1))
		AND (Codigo NOT IN ('MEN_LAT_CAMINOBRILLANTE', 'MEN_TOP_CAMINOBRILLANTE') OR (Codigo IN ('MEN_LAT_CAMINOBRILLANTE', 'MEN_TOP_CAMINOBRILLANTE') AND @IndicadorPermisoCaminoBrillante = 1))
		
	SET NOCOUNT OFF 
END
GO

USE [BelcorpGuatemala]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
	DECLARE @IndicadorPermisoCaminoBrillante INT = 0
	DECLARE @GETDATE DATE
​
	SET @GETDATE= CAST(GETDATE() AS DATE)
 
	IF @CodigoConsultora IS NOT NULL
	BEGIN
		SET @IndicadorPermisoFIC = dbo.GetPermisoFIC(@CodigoConsultora, @ZonaID, @CampaniaID); 
		SELECT @IndicadorPermisoCaminoExito = 1 
		FROM [ods].Zona (NOLOCK) 
		WHERE zonaid = @ZonaID AND [codigo] IN ('0826', '0823', '0803', '0830');
		SET @IndicadorPermisoCaminoBrillante = dbo.GetPermisoCaminoBrillante(@CodigoConsultora);		
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
		Visible,
		IIF(VigenciaNueva > @GETDATE,1,0) FlagMenuNuevo
	FROM dbo.MenuApp (NOLOCK) 
	WHERE VersionMenu = @VersionMenu 
		AND (Codigo NOT IN ('MEN_LAT_PEDIDOFIC', 'MEN_TOP_PEDIDOFIC') OR (Codigo IN ('MEN_LAT_PEDIDOFIC', 'MEN_TOP_PEDIDOFIC') AND @IndicadorPermisoFIC = 1))
		AND (Codigo NOT IN ('MEN_LAT_CAM_EXITO', 'MEN_TOP_CAM_EXITO') OR (Codigo IN ('MEN_LAT_CAM_EXITO', 'MEN_TOP_CAM_EXITO') AND @IndicadorPermisoCaminoExito = 1))
		AND (Codigo NOT IN ('MEN_LAT_CAMINOBRILLANTE', 'MEN_TOP_CAMINOBRILLANTE') OR (Codigo IN ('MEN_LAT_CAMINOBRILLANTE', 'MEN_TOP_CAMINOBRILLANTE') AND @IndicadorPermisoCaminoBrillante = 1))
		
	SET NOCOUNT OFF 
END
GO 

USE [BelcorpMexico]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
	DECLARE @IndicadorPermisoCaminoBrillante INT = 0
	DECLARE @GETDATE DATE
​
	SET @GETDATE= CAST(GETDATE() AS DATE)
 
	IF @CodigoConsultora IS NOT NULL
	BEGIN
		SET @IndicadorPermisoFIC = dbo.GetPermisoFIC(@CodigoConsultora, @ZonaID, @CampaniaID); 
		SELECT @IndicadorPermisoCaminoExito = 1 
		FROM [ods].Zona (NOLOCK) 
		WHERE zonaid = @ZonaID AND [codigo] IN ('0826', '0823', '0803', '0830');
		SET @IndicadorPermisoCaminoBrillante = dbo.GetPermisoCaminoBrillante(@CodigoConsultora);		
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
		Visible,
		IIF(VigenciaNueva > @GETDATE,1,0) FlagMenuNuevo
	FROM dbo.MenuApp (NOLOCK) 
	WHERE VersionMenu = @VersionMenu 
		AND (Codigo NOT IN ('MEN_LAT_PEDIDOFIC', 'MEN_TOP_PEDIDOFIC') OR (Codigo IN ('MEN_LAT_PEDIDOFIC', 'MEN_TOP_PEDIDOFIC') AND @IndicadorPermisoFIC = 1))
		AND (Codigo NOT IN ('MEN_LAT_CAM_EXITO', 'MEN_TOP_CAM_EXITO') OR (Codigo IN ('MEN_LAT_CAM_EXITO', 'MEN_TOP_CAM_EXITO') AND @IndicadorPermisoCaminoExito = 1))
		AND (Codigo NOT IN ('MEN_LAT_CAMINOBRILLANTE', 'MEN_TOP_CAMINOBRILLANTE') OR (Codigo IN ('MEN_LAT_CAMINOBRILLANTE', 'MEN_TOP_CAMINOBRILLANTE') AND @IndicadorPermisoCaminoBrillante = 1))
		
	SET NOCOUNT OFF 
END

GO 

USE [BelcorpPanama]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
	DECLARE @IndicadorPermisoCaminoBrillante INT = 0
	DECLARE @GETDATE DATE
​
	SET @GETDATE= CAST(GETDATE() AS DATE)
 
	IF @CodigoConsultora IS NOT NULL
	BEGIN
		SET @IndicadorPermisoFIC = dbo.GetPermisoFIC(@CodigoConsultora, @ZonaID, @CampaniaID); 
		SELECT @IndicadorPermisoCaminoExito = 1 
		FROM [ods].Zona (NOLOCK) 
		WHERE zonaid = @ZonaID AND [codigo] IN ('0826', '0823', '0803', '0830');
		SET @IndicadorPermisoCaminoBrillante = dbo.GetPermisoCaminoBrillante(@CodigoConsultora);		
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
		Visible,
		IIF(VigenciaNueva > @GETDATE,1,0) FlagMenuNuevo
	FROM dbo.MenuApp (NOLOCK) 
	WHERE VersionMenu = @VersionMenu 
		AND (Codigo NOT IN ('MEN_LAT_PEDIDOFIC', 'MEN_TOP_PEDIDOFIC') OR (Codigo IN ('MEN_LAT_PEDIDOFIC', 'MEN_TOP_PEDIDOFIC') AND @IndicadorPermisoFIC = 1))
		AND (Codigo NOT IN ('MEN_LAT_CAM_EXITO', 'MEN_TOP_CAM_EXITO') OR (Codigo IN ('MEN_LAT_CAM_EXITO', 'MEN_TOP_CAM_EXITO') AND @IndicadorPermisoCaminoExito = 1))
		AND (Codigo NOT IN ('MEN_LAT_CAMINOBRILLANTE', 'MEN_TOP_CAMINOBRILLANTE') OR (Codigo IN ('MEN_LAT_CAMINOBRILLANTE', 'MEN_TOP_CAMINOBRILLANTE') AND @IndicadorPermisoCaminoBrillante = 1))
		
	SET NOCOUNT OFF 
END
GO 

USE [BelcorpPeru]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
	DECLARE @IndicadorPermisoCaminoBrillante INT = 0
	DECLARE @GETDATE DATE
​
	SET @GETDATE= CAST(GETDATE() AS DATE)
 
	IF @CodigoConsultora IS NOT NULL
	BEGIN
		SET @IndicadorPermisoFIC = dbo.GetPermisoFIC(@CodigoConsultora, @ZonaID, @CampaniaID); 
		SELECT @IndicadorPermisoCaminoExito = 1 
		FROM [ods].Zona (NOLOCK) 
		WHERE zonaid = @ZonaID AND [codigo] IN ('0826', '0823', '0803', '0830');
		SET @IndicadorPermisoCaminoBrillante = dbo.GetPermisoCaminoBrillante(@CodigoConsultora);		
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
		Visible,
		IIF(VigenciaNueva > @GETDATE,1,0) FlagMenuNuevo
	FROM dbo.MenuApp (NOLOCK) 
	WHERE VersionMenu = @VersionMenu 
		AND (Codigo NOT IN ('MEN_LAT_PEDIDOFIC', 'MEN_TOP_PEDIDOFIC') OR (Codigo IN ('MEN_LAT_PEDIDOFIC', 'MEN_TOP_PEDIDOFIC') AND @IndicadorPermisoFIC = 1))
		AND (Codigo NOT IN ('MEN_LAT_CAM_EXITO', 'MEN_TOP_CAM_EXITO') OR (Codigo IN ('MEN_LAT_CAM_EXITO', 'MEN_TOP_CAM_EXITO') AND @IndicadorPermisoCaminoExito = 1))
		AND (Codigo NOT IN ('MEN_LAT_CAMINOBRILLANTE', 'MEN_TOP_CAMINOBRILLANTE') OR (Codigo IN ('MEN_LAT_CAMINOBRILLANTE', 'MEN_TOP_CAMINOBRILLANTE') AND @IndicadorPermisoCaminoBrillante = 1))
		
	SET NOCOUNT OFF 
END
GO

USE [BelcorpPuertoRico]
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
	DECLARE @IndicadorPermisoCaminoBrillante INT = 0
	DECLARE @GETDATE DATE
​
	SET @GETDATE= CAST(GETDATE() AS DATE)
 
	IF @CodigoConsultora IS NOT NULL
	BEGIN
		SET @IndicadorPermisoFIC = dbo.GetPermisoFIC(@CodigoConsultora, @ZonaID, @CampaniaID); 
		SELECT @IndicadorPermisoCaminoExito = 1 
		FROM [ods].Zona (NOLOCK) 
		WHERE zonaid = @ZonaID AND [codigo] IN ('0826', '0823', '0803', '0830');
		SET @IndicadorPermisoCaminoBrillante = dbo.GetPermisoCaminoBrillante(@CodigoConsultora);		
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
		Visible,
		IIF(VigenciaNueva > @GETDATE,1,0) FlagMenuNuevo
	FROM dbo.MenuApp (NOLOCK) 
	WHERE VersionMenu = @VersionMenu 
		AND (Codigo NOT IN ('MEN_LAT_PEDIDOFIC', 'MEN_TOP_PEDIDOFIC') OR (Codigo IN ('MEN_LAT_PEDIDOFIC', 'MEN_TOP_PEDIDOFIC') AND @IndicadorPermisoFIC = 1))
		AND (Codigo NOT IN ('MEN_LAT_CAM_EXITO', 'MEN_TOP_CAM_EXITO') OR (Codigo IN ('MEN_LAT_CAM_EXITO', 'MEN_TOP_CAM_EXITO') AND @IndicadorPermisoCaminoExito = 1))
		AND (Codigo NOT IN ('MEN_LAT_CAMINOBRILLANTE', 'MEN_TOP_CAMINOBRILLANTE') OR (Codigo IN ('MEN_LAT_CAMINOBRILLANTE', 'MEN_TOP_CAMINOBRILLANTE') AND @IndicadorPermisoCaminoBrillante = 1))
		
	SET NOCOUNT OFF 
END
GO

USE [BelcorpSalvador]
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
	DECLARE @IndicadorPermisoCaminoBrillante INT = 0
	DECLARE @GETDATE DATE
​
	SET @GETDATE= CAST(GETDATE() AS DATE)
 
	IF @CodigoConsultora IS NOT NULL
	BEGIN
		SET @IndicadorPermisoFIC = dbo.GetPermisoFIC(@CodigoConsultora, @ZonaID, @CampaniaID); 
		SELECT @IndicadorPermisoCaminoExito = 1 
		FROM [ods].Zona (NOLOCK) 
		WHERE zonaid = @ZonaID AND [codigo] IN ('0826', '0823', '0803', '0830');
		SET @IndicadorPermisoCaminoBrillante = dbo.GetPermisoCaminoBrillante(@CodigoConsultora);		
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
		Visible,
		IIF(VigenciaNueva > @GETDATE,1,0) FlagMenuNuevo
	FROM dbo.MenuApp (NOLOCK) 
	WHERE VersionMenu = @VersionMenu 
		AND (Codigo NOT IN ('MEN_LAT_PEDIDOFIC', 'MEN_TOP_PEDIDOFIC') OR (Codigo IN ('MEN_LAT_PEDIDOFIC', 'MEN_TOP_PEDIDOFIC') AND @IndicadorPermisoFIC = 1))
		AND (Codigo NOT IN ('MEN_LAT_CAM_EXITO', 'MEN_TOP_CAM_EXITO') OR (Codigo IN ('MEN_LAT_CAM_EXITO', 'MEN_TOP_CAM_EXITO') AND @IndicadorPermisoCaminoExito = 1))
		AND (Codigo NOT IN ('MEN_LAT_CAMINOBRILLANTE', 'MEN_TOP_CAMINOBRILLANTE') OR (Codigo IN ('MEN_LAT_CAMINOBRILLANTE', 'MEN_TOP_CAMINOBRILLANTE') AND @IndicadorPermisoCaminoBrillante = 1))
		
	SET NOCOUNT OFF 
END