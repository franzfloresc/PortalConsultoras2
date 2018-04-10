USE BelcorpPeru
GO

BEGIN
	DECLARE @ConfiguracionPaisID INT
	DECLARE @CampaniID INT
	SET @CampaniID = 201805

	SELECT @ConfiguracionPaisID = ConfiguracionPaisID 
	FROM [dbo].[ConfiguracionPais] 
	WHERE Codigo = 'LAN'

	IF EXISTS (SELECT 1 FROM [dbo].[ConfiguracionOfertasHome] WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND [CampaniaID] = @CampaniID)
		DELETE FROM [dbo].[ConfiguracionOfertasHome] WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND [CampaniaID] = @CampaniID

	INSERT INTO [dbo].[ConfiguracionOfertasHome]
			   ([ConfiguracionPaisID]
			   ,[CampaniaID]
			   ,[DesktopOrden]
			   ,[MobileOrden]
			   ,[DesktopImagenFondo]
			   ,[MobileImagenFondo]
			   ,[DesktopTitulo]
			   ,[MobileTitulo]
			   ,[DesktopSubTitulo]
			   ,[MobileSubTitulo]
			   ,[DesktopTipoPresentacion]
			   ,[MobileTipoPresentacion]
			   ,[DesktopTipoEstrategia]
			   ,[MobileTipoEstrategia]
			   ,[DesktopCantidadProductos]
			   ,[MobileCantidadProductos]
			   ,[DesktopActivo]
			   ,[MobileActivo]
			   ,[UrlSeccion]
			   ,[DesktopOrdenBpt]
			   ,[MobileOrdenBpt]
			   ,[DesktopColorFondo]
			   ,[MobileColorFondo]
			   ,[DesktopUsarImagenFondo]
			   ,[MobileUsarImagenFondo]
			   ,[DesktopColorTexto]
			   ,[MobileColorTexto])
		 VALUES
			   (@ConfiguracionPaisID
			   ,@CampaniID
			   ,2
			   ,2
			   ,NULL
			   ,NULL
			   ,'Lo nuevo, nuevo'
			   ,'Lo nuevo, nuevo'
			   ,NULL
			   ,NULL
			   ,8
			   ,8
			   ,'005'
			   ,'005'
			   ,0
			   ,0
			   ,1
			   ,1
			   ,NULL
			   ,2
			   ,2
			   ,NULL
			   ,NULL
			   ,0
			   ,0
			   ,NULL
			   ,NULL)
END
GO

USE BelcorpMexico
GO

BEGIN
	DECLARE @ConfiguracionPaisID INT
	DECLARE @CampaniID INT
	SET @CampaniID = 201805

	SELECT @ConfiguracionPaisID = ConfiguracionPaisID 
	FROM [dbo].[ConfiguracionPais] 
	WHERE Codigo = 'LAN'

	IF EXISTS (SELECT 1 FROM [dbo].[ConfiguracionOfertasHome] WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND [CampaniaID] = @CampaniID)
		DELETE FROM [dbo].[ConfiguracionOfertasHome] WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND [CampaniaID] = @CampaniID

	INSERT INTO [dbo].[ConfiguracionOfertasHome]
			   ([ConfiguracionPaisID]
			   ,[CampaniaID]
			   ,[DesktopOrden]
			   ,[MobileOrden]
			   ,[DesktopImagenFondo]
			   ,[MobileImagenFondo]
			   ,[DesktopTitulo]
			   ,[MobileTitulo]
			   ,[DesktopSubTitulo]
			   ,[MobileSubTitulo]
			   ,[DesktopTipoPresentacion]
			   ,[MobileTipoPresentacion]
			   ,[DesktopTipoEstrategia]
			   ,[MobileTipoEstrategia]
			   ,[DesktopCantidadProductos]
			   ,[MobileCantidadProductos]
			   ,[DesktopActivo]
			   ,[MobileActivo]
			   ,[UrlSeccion]
			   ,[DesktopOrdenBpt]
			   ,[MobileOrdenBpt]
			   ,[DesktopColorFondo]
			   ,[MobileColorFondo]
			   ,[DesktopUsarImagenFondo]
			   ,[MobileUsarImagenFondo]
			   ,[DesktopColorTexto]
			   ,[MobileColorTexto])
		 VALUES
			   (@ConfiguracionPaisID
			   ,@CampaniID
			   ,2
			   ,2
			   ,NULL
			   ,NULL
			   ,'Lo nuevo, nuevo'
			   ,'Lo nuevo, nuevo'
			   ,NULL
			   ,NULL
			   ,8
			   ,8
			   ,'005'
			   ,'005'
			   ,0
			   ,0
			   ,1
			   ,1
			   ,NULL
			   ,2
			   ,2
			   ,NULL
			   ,NULL
			   ,0
			   ,0
			   ,NULL
			   ,NULL)
END
GO

USE BelcorpColombia
GO

BEGIN
	DECLARE @ConfiguracionPaisID INT
	DECLARE @CampaniID INT
	SET @CampaniID = 201805

	SELECT @ConfiguracionPaisID = ConfiguracionPaisID 
	FROM [dbo].[ConfiguracionPais] 
	WHERE Codigo = 'LAN'

	IF EXISTS (SELECT 1 FROM [dbo].[ConfiguracionOfertasHome] WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND [CampaniaID] = @CampaniID)
		DELETE FROM [dbo].[ConfiguracionOfertasHome] WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND [CampaniaID] = @CampaniID

	INSERT INTO [dbo].[ConfiguracionOfertasHome]
			   ([ConfiguracionPaisID]
			   ,[CampaniaID]
			   ,[DesktopOrden]
			   ,[MobileOrden]
			   ,[DesktopImagenFondo]
			   ,[MobileImagenFondo]
			   ,[DesktopTitulo]
			   ,[MobileTitulo]
			   ,[DesktopSubTitulo]
			   ,[MobileSubTitulo]
			   ,[DesktopTipoPresentacion]
			   ,[MobileTipoPresentacion]
			   ,[DesktopTipoEstrategia]
			   ,[MobileTipoEstrategia]
			   ,[DesktopCantidadProductos]
			   ,[MobileCantidadProductos]
			   ,[DesktopActivo]
			   ,[MobileActivo]
			   ,[UrlSeccion]
			   ,[DesktopOrdenBpt]
			   ,[MobileOrdenBpt]
			   ,[DesktopColorFondo]
			   ,[MobileColorFondo]
			   ,[DesktopUsarImagenFondo]
			   ,[MobileUsarImagenFondo]
			   ,[DesktopColorTexto]
			   ,[MobileColorTexto])
		 VALUES
			   (@ConfiguracionPaisID
			   ,@CampaniID
			   ,2
			   ,2
			   ,NULL
			   ,NULL
			   ,'Lo nuevo, nuevo'
			   ,'Lo nuevo, nuevo'
			   ,NULL
			   ,NULL
			   ,8
			   ,8
			   ,'005'
			   ,'005'
			   ,0
			   ,0
			   ,1
			   ,1
			   ,NULL
			   ,2
			   ,2
			   ,NULL
			   ,NULL
			   ,0
			   ,0
			   ,NULL
			   ,NULL)
END
GO

USE BelcorpSalvador
GO

BEGIN
	DECLARE @ConfiguracionPaisID INT
	DECLARE @CampaniID INT
	SET @CampaniID = 201805

	SELECT @ConfiguracionPaisID = ConfiguracionPaisID 
	FROM [dbo].[ConfiguracionPais] 
	WHERE Codigo = 'LAN'

	IF EXISTS (SELECT 1 FROM [dbo].[ConfiguracionOfertasHome] WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND [CampaniaID] = @CampaniID)
		DELETE FROM [dbo].[ConfiguracionOfertasHome] WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND [CampaniaID] = @CampaniID

	INSERT INTO [dbo].[ConfiguracionOfertasHome]
			   ([ConfiguracionPaisID]
			   ,[CampaniaID]
			   ,[DesktopOrden]
			   ,[MobileOrden]
			   ,[DesktopImagenFondo]
			   ,[MobileImagenFondo]
			   ,[DesktopTitulo]
			   ,[MobileTitulo]
			   ,[DesktopSubTitulo]
			   ,[MobileSubTitulo]
			   ,[DesktopTipoPresentacion]
			   ,[MobileTipoPresentacion]
			   ,[DesktopTipoEstrategia]
			   ,[MobileTipoEstrategia]
			   ,[DesktopCantidadProductos]
			   ,[MobileCantidadProductos]
			   ,[DesktopActivo]
			   ,[MobileActivo]
			   ,[UrlSeccion]
			   ,[DesktopOrdenBpt]
			   ,[MobileOrdenBpt]
			   ,[DesktopColorFondo]
			   ,[MobileColorFondo]
			   ,[DesktopUsarImagenFondo]
			   ,[MobileUsarImagenFondo]
			   ,[DesktopColorTexto]
			   ,[MobileColorTexto])
		 VALUES
			   (@ConfiguracionPaisID
			   ,@CampaniID
			   ,2
			   ,2
			   ,NULL
			   ,NULL
			   ,'Lo nuevo, nuevo'
			   ,'Lo nuevo, nuevo'
			   ,NULL
			   ,NULL
			   ,8
			   ,8
			   ,'005'
			   ,'005'
			   ,0
			   ,0
			   ,1
			   ,1
			   ,NULL
			   ,2
			   ,2
			   ,NULL
			   ,NULL
			   ,0
			   ,0
			   ,NULL
			   ,NULL)
END
GO

USE BelcorpPuertoRico
GO

BEGIN
	DECLARE @ConfiguracionPaisID INT
	DECLARE @CampaniID INT
	SET @CampaniID = 201805

	SELECT @ConfiguracionPaisID = ConfiguracionPaisID 
	FROM [dbo].[ConfiguracionPais] 
	WHERE Codigo = 'LAN'

	IF EXISTS (SELECT 1 FROM [dbo].[ConfiguracionOfertasHome] WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND [CampaniaID] = @CampaniID)
		DELETE FROM [dbo].[ConfiguracionOfertasHome] WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND [CampaniaID] = @CampaniID

	INSERT INTO [dbo].[ConfiguracionOfertasHome]
			   ([ConfiguracionPaisID]
			   ,[CampaniaID]
			   ,[DesktopOrden]
			   ,[MobileOrden]
			   ,[DesktopImagenFondo]
			   ,[MobileImagenFondo]
			   ,[DesktopTitulo]
			   ,[MobileTitulo]
			   ,[DesktopSubTitulo]
			   ,[MobileSubTitulo]
			   ,[DesktopTipoPresentacion]
			   ,[MobileTipoPresentacion]
			   ,[DesktopTipoEstrategia]
			   ,[MobileTipoEstrategia]
			   ,[DesktopCantidadProductos]
			   ,[MobileCantidadProductos]
			   ,[DesktopActivo]
			   ,[MobileActivo]
			   ,[UrlSeccion]
			   ,[DesktopOrdenBpt]
			   ,[MobileOrdenBpt]
			   ,[DesktopColorFondo]
			   ,[MobileColorFondo]
			   ,[DesktopUsarImagenFondo]
			   ,[MobileUsarImagenFondo]
			   ,[DesktopColorTexto]
			   ,[MobileColorTexto])
		 VALUES
			   (@ConfiguracionPaisID
			   ,@CampaniID
			   ,2
			   ,2
			   ,NULL
			   ,NULL
			   ,'Lo nuevo, nuevo'
			   ,'Lo nuevo, nuevo'
			   ,NULL
			   ,NULL
			   ,8
			   ,8
			   ,'005'
			   ,'005'
			   ,0
			   ,0
			   ,1
			   ,1
			   ,NULL
			   ,2
			   ,2
			   ,NULL
			   ,NULL
			   ,0
			   ,0
			   ,NULL
			   ,NULL)
END
GO

USE BelcorpPanama
GO

BEGIN
	DECLARE @ConfiguracionPaisID INT
	DECLARE @CampaniID INT
	SET @CampaniID = 201805

	SELECT @ConfiguracionPaisID = ConfiguracionPaisID 
	FROM [dbo].[ConfiguracionPais] 
	WHERE Codigo = 'LAN'

	IF EXISTS (SELECT 1 FROM [dbo].[ConfiguracionOfertasHome] WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND [CampaniaID] = @CampaniID)
		DELETE FROM [dbo].[ConfiguracionOfertasHome] WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND [CampaniaID] = @CampaniID

	INSERT INTO [dbo].[ConfiguracionOfertasHome]
			   ([ConfiguracionPaisID]
			   ,[CampaniaID]
			   ,[DesktopOrden]
			   ,[MobileOrden]
			   ,[DesktopImagenFondo]
			   ,[MobileImagenFondo]
			   ,[DesktopTitulo]
			   ,[MobileTitulo]
			   ,[DesktopSubTitulo]
			   ,[MobileSubTitulo]
			   ,[DesktopTipoPresentacion]
			   ,[MobileTipoPresentacion]
			   ,[DesktopTipoEstrategia]
			   ,[MobileTipoEstrategia]
			   ,[DesktopCantidadProductos]
			   ,[MobileCantidadProductos]
			   ,[DesktopActivo]
			   ,[MobileActivo]
			   ,[UrlSeccion]
			   ,[DesktopOrdenBpt]
			   ,[MobileOrdenBpt]
			   ,[DesktopColorFondo]
			   ,[MobileColorFondo]
			   ,[DesktopUsarImagenFondo]
			   ,[MobileUsarImagenFondo]
			   ,[DesktopColorTexto]
			   ,[MobileColorTexto])
		 VALUES
			   (@ConfiguracionPaisID
			   ,@CampaniID
			   ,2
			   ,2
			   ,NULL
			   ,NULL
			   ,'Lo nuevo, nuevo'
			   ,'Lo nuevo, nuevo'
			   ,NULL
			   ,NULL
			   ,8
			   ,8
			   ,'005'
			   ,'005'
			   ,0
			   ,0
			   ,1
			   ,1
			   ,NULL
			   ,2
			   ,2
			   ,NULL
			   ,NULL
			   ,0
			   ,0
			   ,NULL
			   ,NULL)
END
GO

USE BelcorpGuatemala
GO

BEGIN
	DECLARE @ConfiguracionPaisID INT
	DECLARE @CampaniID INT
	SET @CampaniID = 201805

	SELECT @ConfiguracionPaisID = ConfiguracionPaisID 
	FROM [dbo].[ConfiguracionPais] 
	WHERE Codigo = 'LAN'

	IF EXISTS (SELECT 1 FROM [dbo].[ConfiguracionOfertasHome] WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND [CampaniaID] = @CampaniID)
		DELETE FROM [dbo].[ConfiguracionOfertasHome] WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND [CampaniaID] = @CampaniID

	INSERT INTO [dbo].[ConfiguracionOfertasHome]
			   ([ConfiguracionPaisID]
			   ,[CampaniaID]
			   ,[DesktopOrden]
			   ,[MobileOrden]
			   ,[DesktopImagenFondo]
			   ,[MobileImagenFondo]
			   ,[DesktopTitulo]
			   ,[MobileTitulo]
			   ,[DesktopSubTitulo]
			   ,[MobileSubTitulo]
			   ,[DesktopTipoPresentacion]
			   ,[MobileTipoPresentacion]
			   ,[DesktopTipoEstrategia]
			   ,[MobileTipoEstrategia]
			   ,[DesktopCantidadProductos]
			   ,[MobileCantidadProductos]
			   ,[DesktopActivo]
			   ,[MobileActivo]
			   ,[UrlSeccion]
			   ,[DesktopOrdenBpt]
			   ,[MobileOrdenBpt]
			   ,[DesktopColorFondo]
			   ,[MobileColorFondo]
			   ,[DesktopUsarImagenFondo]
			   ,[MobileUsarImagenFondo]
			   ,[DesktopColorTexto]
			   ,[MobileColorTexto])
		 VALUES
			   (@ConfiguracionPaisID
			   ,@CampaniID
			   ,2
			   ,2
			   ,NULL
			   ,NULL
			   ,'Lo nuevo, nuevo'
			   ,'Lo nuevo, nuevo'
			   ,NULL
			   ,NULL
			   ,8
			   ,8
			   ,'005'
			   ,'005'
			   ,0
			   ,0
			   ,1
			   ,1
			   ,NULL
			   ,2
			   ,2
			   ,NULL
			   ,NULL
			   ,0
			   ,0
			   ,NULL
			   ,NULL)
END
GO

USE BelcorpEcuador
GO

BEGIN
	DECLARE @ConfiguracionPaisID INT
	DECLARE @CampaniID INT
	SET @CampaniID = 201805

	SELECT @ConfiguracionPaisID = ConfiguracionPaisID 
	FROM [dbo].[ConfiguracionPais] 
	WHERE Codigo = 'LAN'

	IF EXISTS (SELECT 1 FROM [dbo].[ConfiguracionOfertasHome] WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND [CampaniaID] = @CampaniID)
		DELETE FROM [dbo].[ConfiguracionOfertasHome] WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND [CampaniaID] = @CampaniID

	INSERT INTO [dbo].[ConfiguracionOfertasHome]
			   ([ConfiguracionPaisID]
			   ,[CampaniaID]
			   ,[DesktopOrden]
			   ,[MobileOrden]
			   ,[DesktopImagenFondo]
			   ,[MobileImagenFondo]
			   ,[DesktopTitulo]
			   ,[MobileTitulo]
			   ,[DesktopSubTitulo]
			   ,[MobileSubTitulo]
			   ,[DesktopTipoPresentacion]
			   ,[MobileTipoPresentacion]
			   ,[DesktopTipoEstrategia]
			   ,[MobileTipoEstrategia]
			   ,[DesktopCantidadProductos]
			   ,[MobileCantidadProductos]
			   ,[DesktopActivo]
			   ,[MobileActivo]
			   ,[UrlSeccion]
			   ,[DesktopOrdenBpt]
			   ,[MobileOrdenBpt]
			   ,[DesktopColorFondo]
			   ,[MobileColorFondo]
			   ,[DesktopUsarImagenFondo]
			   ,[MobileUsarImagenFondo]
			   ,[DesktopColorTexto]
			   ,[MobileColorTexto])
		 VALUES
			   (@ConfiguracionPaisID
			   ,@CampaniID
			   ,2
			   ,2
			   ,NULL
			   ,NULL
			   ,'Lo nuevo, nuevo'
			   ,'Lo nuevo, nuevo'
			   ,NULL
			   ,NULL
			   ,8
			   ,8
			   ,'005'
			   ,'005'
			   ,0
			   ,0
			   ,1
			   ,1
			   ,NULL
			   ,2
			   ,2
			   ,NULL
			   ,NULL
			   ,0
			   ,0
			   ,NULL
			   ,NULL)
END
GO

USE BelcorpDominicana
GO

BEGIN
	DECLARE @ConfiguracionPaisID INT
	DECLARE @CampaniID INT
	SET @CampaniID = 201805

	SELECT @ConfiguracionPaisID = ConfiguracionPaisID 
	FROM [dbo].[ConfiguracionPais] 
	WHERE Codigo = 'LAN'

	IF EXISTS (SELECT 1 FROM [dbo].[ConfiguracionOfertasHome] WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND [CampaniaID] = @CampaniID)
		DELETE FROM [dbo].[ConfiguracionOfertasHome] WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND [CampaniaID] = @CampaniID

	INSERT INTO [dbo].[ConfiguracionOfertasHome]
			   ([ConfiguracionPaisID]
			   ,[CampaniaID]
			   ,[DesktopOrden]
			   ,[MobileOrden]
			   ,[DesktopImagenFondo]
			   ,[MobileImagenFondo]
			   ,[DesktopTitulo]
			   ,[MobileTitulo]
			   ,[DesktopSubTitulo]
			   ,[MobileSubTitulo]
			   ,[DesktopTipoPresentacion]
			   ,[MobileTipoPresentacion]
			   ,[DesktopTipoEstrategia]
			   ,[MobileTipoEstrategia]
			   ,[DesktopCantidadProductos]
			   ,[MobileCantidadProductos]
			   ,[DesktopActivo]
			   ,[MobileActivo]
			   ,[UrlSeccion]
			   ,[DesktopOrdenBpt]
			   ,[MobileOrdenBpt]
			   ,[DesktopColorFondo]
			   ,[MobileColorFondo]
			   ,[DesktopUsarImagenFondo]
			   ,[MobileUsarImagenFondo]
			   ,[DesktopColorTexto]
			   ,[MobileColorTexto])
		 VALUES
			   (@ConfiguracionPaisID
			   ,@CampaniID
			   ,2
			   ,2
			   ,NULL
			   ,NULL
			   ,'Lo nuevo, nuevo'
			   ,'Lo nuevo, nuevo'
			   ,NULL
			   ,NULL
			   ,8
			   ,8
			   ,'005'
			   ,'005'
			   ,0
			   ,0
			   ,1
			   ,1
			   ,NULL
			   ,2
			   ,2
			   ,NULL
			   ,NULL
			   ,0
			   ,0
			   ,NULL
			   ,NULL)
END
GO

USE BelcorpCostaRica
GO

BEGIN
	DECLARE @ConfiguracionPaisID INT
	DECLARE @CampaniID INT
	SET @CampaniID = 201805

	SELECT @ConfiguracionPaisID = ConfiguracionPaisID 
	FROM [dbo].[ConfiguracionPais] 
	WHERE Codigo = 'LAN'

	IF EXISTS (SELECT 1 FROM [dbo].[ConfiguracionOfertasHome] WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND [CampaniaID] = @CampaniID)
		DELETE FROM [dbo].[ConfiguracionOfertasHome] WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND [CampaniaID] = @CampaniID

	INSERT INTO [dbo].[ConfiguracionOfertasHome]
			   ([ConfiguracionPaisID]
			   ,[CampaniaID]
			   ,[DesktopOrden]
			   ,[MobileOrden]
			   ,[DesktopImagenFondo]
			   ,[MobileImagenFondo]
			   ,[DesktopTitulo]
			   ,[MobileTitulo]
			   ,[DesktopSubTitulo]
			   ,[MobileSubTitulo]
			   ,[DesktopTipoPresentacion]
			   ,[MobileTipoPresentacion]
			   ,[DesktopTipoEstrategia]
			   ,[MobileTipoEstrategia]
			   ,[DesktopCantidadProductos]
			   ,[MobileCantidadProductos]
			   ,[DesktopActivo]
			   ,[MobileActivo]
			   ,[UrlSeccion]
			   ,[DesktopOrdenBpt]
			   ,[MobileOrdenBpt]
			   ,[DesktopColorFondo]
			   ,[MobileColorFondo]
			   ,[DesktopUsarImagenFondo]
			   ,[MobileUsarImagenFondo]
			   ,[DesktopColorTexto]
			   ,[MobileColorTexto])
		 VALUES
			   (@ConfiguracionPaisID
			   ,@CampaniID
			   ,2
			   ,2
			   ,NULL
			   ,NULL
			   ,'Lo nuevo, nuevo'
			   ,'Lo nuevo, nuevo'
			   ,NULL
			   ,NULL
			   ,8
			   ,8
			   ,'005'
			   ,'005'
			   ,0
			   ,0
			   ,1
			   ,1
			   ,NULL
			   ,2
			   ,2
			   ,NULL
			   ,NULL
			   ,0
			   ,0
			   ,NULL
			   ,NULL)
END
GO

USE BelcorpChile
GO

BEGIN
	DECLARE @ConfiguracionPaisID INT
	DECLARE @CampaniID INT
	SET @CampaniID = 201805

	SELECT @ConfiguracionPaisID = ConfiguracionPaisID 
	FROM [dbo].[ConfiguracionPais] 
	WHERE Codigo = 'LAN'

	IF EXISTS (SELECT 1 FROM [dbo].[ConfiguracionOfertasHome] WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND [CampaniaID] = @CampaniID)
		DELETE FROM [dbo].[ConfiguracionOfertasHome] WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND [CampaniaID] = @CampaniID

	INSERT INTO [dbo].[ConfiguracionOfertasHome]
			   ([ConfiguracionPaisID]
			   ,[CampaniaID]
			   ,[DesktopOrden]
			   ,[MobileOrden]
			   ,[DesktopImagenFondo]
			   ,[MobileImagenFondo]
			   ,[DesktopTitulo]
			   ,[MobileTitulo]
			   ,[DesktopSubTitulo]
			   ,[MobileSubTitulo]
			   ,[DesktopTipoPresentacion]
			   ,[MobileTipoPresentacion]
			   ,[DesktopTipoEstrategia]
			   ,[MobileTipoEstrategia]
			   ,[DesktopCantidadProductos]
			   ,[MobileCantidadProductos]
			   ,[DesktopActivo]
			   ,[MobileActivo]
			   ,[UrlSeccion]
			   ,[DesktopOrdenBpt]
			   ,[MobileOrdenBpt]
			   ,[DesktopColorFondo]
			   ,[MobileColorFondo]
			   ,[DesktopUsarImagenFondo]
			   ,[MobileUsarImagenFondo]
			   ,[DesktopColorTexto]
			   ,[MobileColorTexto])
		 VALUES
			   (@ConfiguracionPaisID
			   ,@CampaniID
			   ,2
			   ,2
			   ,NULL
			   ,NULL
			   ,'Lo nuevo, nuevo'
			   ,'Lo nuevo, nuevo'
			   ,NULL
			   ,NULL
			   ,8
			   ,8
			   ,'005'
			   ,'005'
			   ,0
			   ,0
			   ,1
			   ,1
			   ,NULL
			   ,2
			   ,2
			   ,NULL
			   ,NULL
			   ,0
			   ,0
			   ,NULL
			   ,NULL)
END
GO

USE BelcorpBolivia
GO

BEGIN
	DECLARE @ConfiguracionPaisID INT
	DECLARE @CampaniID INT
	SET @CampaniID = 201805

	SELECT @ConfiguracionPaisID = ConfiguracionPaisID 
	FROM [dbo].[ConfiguracionPais] 
	WHERE Codigo = 'LAN'

	IF EXISTS (SELECT 1 FROM [dbo].[ConfiguracionOfertasHome] WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND [CampaniaID] = @CampaniID)
		DELETE FROM [dbo].[ConfiguracionOfertasHome] WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND [CampaniaID] = @CampaniID

	INSERT INTO [dbo].[ConfiguracionOfertasHome]
			   ([ConfiguracionPaisID]
			   ,[CampaniaID]
			   ,[DesktopOrden]
			   ,[MobileOrden]
			   ,[DesktopImagenFondo]
			   ,[MobileImagenFondo]
			   ,[DesktopTitulo]
			   ,[MobileTitulo]
			   ,[DesktopSubTitulo]
			   ,[MobileSubTitulo]
			   ,[DesktopTipoPresentacion]
			   ,[MobileTipoPresentacion]
			   ,[DesktopTipoEstrategia]
			   ,[MobileTipoEstrategia]
			   ,[DesktopCantidadProductos]
			   ,[MobileCantidadProductos]
			   ,[DesktopActivo]
			   ,[MobileActivo]
			   ,[UrlSeccion]
			   ,[DesktopOrdenBpt]
			   ,[MobileOrdenBpt]
			   ,[DesktopColorFondo]
			   ,[MobileColorFondo]
			   ,[DesktopUsarImagenFondo]
			   ,[MobileUsarImagenFondo]
			   ,[DesktopColorTexto]
			   ,[MobileColorTexto])
		 VALUES
			   (@ConfiguracionPaisID
			   ,@CampaniID
			   ,2
			   ,2
			   ,NULL
			   ,NULL
			   ,'Lo nuevo, nuevo'
			   ,'Lo nuevo, nuevo'
			   ,NULL
			   ,NULL
			   ,8
			   ,8
			   ,'005'
			   ,'005'
			   ,0
			   ,0
			   ,1
			   ,1
			   ,NULL
			   ,2
			   ,2
			   ,NULL
			   ,NULL
			   ,0
			   ,0
			   ,NULL
			   ,NULL)
END
GO

