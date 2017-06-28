USE BelcorpPeru
GO

--------------------------------------------------------------------------------------------------
-- RECUPECAION DE DATOS DE LA TABLA CONFIGURACION PAIS
--------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ConfiguracionPais_GetAll]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ConfiguracionPais_GetAll]
GO

CREATE PROCEDURE [dbo].[ConfiguracionPais_GetAll]
(
	@Codigo varchar(100) = ''
	,@CodigoRegion  varchar(100) = ''
	,@CodigoZona  varchar(100) = ''
	,@CodigoSeccion  varchar(100) = ''
	,@CodigoConsultora  varchar(100) = ''
)
AS
BEGIN

	SET NOCOUNT ON;
	IF(@Codigo IS NULL OR @Codigo = 'NULL') SET @Codigo = '';
	SELECT c.ConfiguracionPaisID
		,c.Codigo
		,c.Excluyente
		,c.Descripcion
		,c.Estado
	FROM ConfiguracionPais c
		INNER JOIN ConfiguracionPaisDetalle d ON c.ConfiguracionPaisID = d.ConfiguracionPaisID
	WHERE c.Estado = '1' AND d.Estado = '1' AND (@Codigo = '' OR c.Codigo = @Codigo)
		AND Excluyente = 1 AND (d.CodigoRegion != @CodigoRegion OR d.CodigoZona != @CodigoZona OR d.CodigoSeccion != @CodigoSeccion OR d.CodigoConsultora != @CodigoConsultora)	
	UNION 
	SELECT c.ConfiguracionPaisID
		,c.Codigo
		,c.Excluyente
		,c.Descripcion
		,c.Estado
	FROM ConfiguracionPais c
	INNER JOIN ConfiguracionPaisDetalle d ON c.ConfiguracionPaisID = d.ConfiguracionPaisID
	WHERE c.Estado = '1' AND d.Estado = '1' AND (@Codigo = '' OR c.Codigo = @Codigo)
		AND Excluyente = 0 AND (d.CodigoRegion = @CodigoRegion OR d.CodigoZona = @CodigoZona OR d.CodigoSeccion = @CodigoSeccion OR d.CodigoConsultora = @CodigoConsultora)
END
GO
/*end*/

USE BelcorpMexico
GO

--------------------------------------------------------------------------------------------------
-- RECUPECAION DE DATOS DE LA TABLA CONFIGURACION PAIS
--------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ConfiguracionPais_GetAll]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ConfiguracionPais_GetAll]
GO

CREATE PROCEDURE [dbo].[ConfiguracionPais_GetAll]
(
	@Codigo varchar(100) = ''
	,@CodigoRegion  varchar(100) = ''
	,@CodigoZona  varchar(100) = ''
	,@CodigoSeccion  varchar(100) = ''
	,@CodigoConsultora  varchar(100) = ''
)
AS
BEGIN

	SET NOCOUNT ON;
	IF(@Codigo IS NULL OR @Codigo = 'NULL') SET @Codigo = '';
	SELECT c.ConfiguracionPaisID
		,c.Codigo
		,c.Excluyente
		,c.Descripcion
		,c.Estado
	FROM ConfiguracionPais c
		INNER JOIN ConfiguracionPaisDetalle d ON c.ConfiguracionPaisID = d.ConfiguracionPaisID
	WHERE c.Estado = '1' AND d.Estado = '1' AND (@Codigo = '' OR c.Codigo = @Codigo)
		AND Excluyente = 1 AND (d.CodigoRegion != @CodigoRegion OR d.CodigoZona != @CodigoZona OR d.CodigoSeccion != @CodigoSeccion OR d.CodigoConsultora != @CodigoConsultora)	
	UNION 
	SELECT c.ConfiguracionPaisID
		,c.Codigo
		,c.Excluyente
		,c.Descripcion
		,c.Estado
	FROM ConfiguracionPais c
	INNER JOIN ConfiguracionPaisDetalle d ON c.ConfiguracionPaisID = d.ConfiguracionPaisID
	WHERE c.Estado = '1' AND d.Estado = '1' AND (@Codigo = '' OR c.Codigo = @Codigo)
		AND Excluyente = 0 AND (d.CodigoRegion = @CodigoRegion OR d.CodigoZona = @CodigoZona OR d.CodigoSeccion = @CodigoSeccion OR d.CodigoConsultora = @CodigoConsultora)
END
GO
/*end*/

USE BelcorpColombia
GO

--------------------------------------------------------------------------------------------------
-- RECUPECAION DE DATOS DE LA TABLA CONFIGURACION PAIS
--------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ConfiguracionPais_GetAll]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ConfiguracionPais_GetAll]
GO

CREATE PROCEDURE [dbo].[ConfiguracionPais_GetAll]
(
	@Codigo varchar(100) = ''
	,@CodigoRegion  varchar(100) = ''
	,@CodigoZona  varchar(100) = ''
	,@CodigoSeccion  varchar(100) = ''
	,@CodigoConsultora  varchar(100) = ''
)
AS
BEGIN

	SET NOCOUNT ON;
	IF(@Codigo IS NULL OR @Codigo = 'NULL') SET @Codigo = '';
	SELECT c.ConfiguracionPaisID
		,c.Codigo
		,c.Excluyente
		,c.Descripcion
		,c.Estado
	FROM ConfiguracionPais c
		INNER JOIN ConfiguracionPaisDetalle d ON c.ConfiguracionPaisID = d.ConfiguracionPaisID
	WHERE c.Estado = '1' AND d.Estado = '1' AND (@Codigo = '' OR c.Codigo = @Codigo)
		AND Excluyente = 1 AND (d.CodigoRegion != @CodigoRegion OR d.CodigoZona != @CodigoZona OR d.CodigoSeccion != @CodigoSeccion OR d.CodigoConsultora != @CodigoConsultora)	
	UNION 
	SELECT c.ConfiguracionPaisID
		,c.Codigo
		,c.Excluyente
		,c.Descripcion
		,c.Estado
	FROM ConfiguracionPais c
	INNER JOIN ConfiguracionPaisDetalle d ON c.ConfiguracionPaisID = d.ConfiguracionPaisID
	WHERE c.Estado = '1' AND d.Estado = '1' AND (@Codigo = '' OR c.Codigo = @Codigo)
		AND Excluyente = 0 AND (d.CodigoRegion = @CodigoRegion OR d.CodigoZona = @CodigoZona OR d.CodigoSeccion = @CodigoSeccion OR d.CodigoConsultora = @CodigoConsultora)
END
GO
/*end*/

USE BelcorpVenezuela
GO

--------------------------------------------------------------------------------------------------
-- RECUPECAION DE DATOS DE LA TABLA CONFIGURACION PAIS
--------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ConfiguracionPais_GetAll]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ConfiguracionPais_GetAll]
GO

CREATE PROCEDURE [dbo].[ConfiguracionPais_GetAll]
(
	@Codigo varchar(100) = ''
	,@CodigoRegion  varchar(100) = ''
	,@CodigoZona  varchar(100) = ''
	,@CodigoSeccion  varchar(100) = ''
	,@CodigoConsultora  varchar(100) = ''
)
AS
BEGIN

	SET NOCOUNT ON;
	IF(@Codigo IS NULL OR @Codigo = 'NULL') SET @Codigo = '';
	SELECT c.ConfiguracionPaisID
		,c.Codigo
		,c.Excluyente
		,c.Descripcion
		,c.Estado
	FROM ConfiguracionPais c
		INNER JOIN ConfiguracionPaisDetalle d ON c.ConfiguracionPaisID = d.ConfiguracionPaisID
	WHERE c.Estado = '1' AND d.Estado = '1' AND (@Codigo = '' OR c.Codigo = @Codigo)
		AND Excluyente = 1 AND (d.CodigoRegion != @CodigoRegion OR d.CodigoZona != @CodigoZona OR d.CodigoSeccion != @CodigoSeccion OR d.CodigoConsultora != @CodigoConsultora)	
	UNION 
	SELECT c.ConfiguracionPaisID
		,c.Codigo
		,c.Excluyente
		,c.Descripcion
		,c.Estado
	FROM ConfiguracionPais c
	INNER JOIN ConfiguracionPaisDetalle d ON c.ConfiguracionPaisID = d.ConfiguracionPaisID
	WHERE c.Estado = '1' AND d.Estado = '1' AND (@Codigo = '' OR c.Codigo = @Codigo)
		AND Excluyente = 0 AND (d.CodigoRegion = @CodigoRegion OR d.CodigoZona = @CodigoZona OR d.CodigoSeccion = @CodigoSeccion OR d.CodigoConsultora = @CodigoConsultora)
END
GO
/*end*/

USE BelcorpSalvador
GO

--------------------------------------------------------------------------------------------------
-- RECUPECAION DE DATOS DE LA TABLA CONFIGURACION PAIS
--------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ConfiguracionPais_GetAll]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ConfiguracionPais_GetAll]
GO

CREATE PROCEDURE [dbo].[ConfiguracionPais_GetAll]
(
	@Codigo varchar(100) = ''
	,@CodigoRegion  varchar(100) = ''
	,@CodigoZona  varchar(100) = ''
	,@CodigoSeccion  varchar(100) = ''
	,@CodigoConsultora  varchar(100) = ''
)
AS
BEGIN

	SET NOCOUNT ON;
	IF(@Codigo IS NULL OR @Codigo = 'NULL') SET @Codigo = '';
	SELECT c.ConfiguracionPaisID
		,c.Codigo
		,c.Excluyente
		,c.Descripcion
		,c.Estado
	FROM ConfiguracionPais c
		INNER JOIN ConfiguracionPaisDetalle d ON c.ConfiguracionPaisID = d.ConfiguracionPaisID
	WHERE c.Estado = '1' AND d.Estado = '1' AND (@Codigo = '' OR c.Codigo = @Codigo)
		AND Excluyente = 1 AND (d.CodigoRegion != @CodigoRegion OR d.CodigoZona != @CodigoZona OR d.CodigoSeccion != @CodigoSeccion OR d.CodigoConsultora != @CodigoConsultora)	
	UNION 
	SELECT c.ConfiguracionPaisID
		,c.Codigo
		,c.Excluyente
		,c.Descripcion
		,c.Estado
	FROM ConfiguracionPais c
	INNER JOIN ConfiguracionPaisDetalle d ON c.ConfiguracionPaisID = d.ConfiguracionPaisID
	WHERE c.Estado = '1' AND d.Estado = '1' AND (@Codigo = '' OR c.Codigo = @Codigo)
		AND Excluyente = 0 AND (d.CodigoRegion = @CodigoRegion OR d.CodigoZona = @CodigoZona OR d.CodigoSeccion = @CodigoSeccion OR d.CodigoConsultora = @CodigoConsultora)
END
GO
/*end*/

USE BelcorpPuertoRico
GO

--------------------------------------------------------------------------------------------------
-- RECUPECAION DE DATOS DE LA TABLA CONFIGURACION PAIS
--------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ConfiguracionPais_GetAll]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ConfiguracionPais_GetAll]
GO

CREATE PROCEDURE [dbo].[ConfiguracionPais_GetAll]
(
	@Codigo varchar(100) = ''
	,@CodigoRegion  varchar(100) = ''
	,@CodigoZona  varchar(100) = ''
	,@CodigoSeccion  varchar(100) = ''
	,@CodigoConsultora  varchar(100) = ''
)
AS
BEGIN

	SET NOCOUNT ON;
	IF(@Codigo IS NULL OR @Codigo = 'NULL') SET @Codigo = '';
	SELECT c.ConfiguracionPaisID
		,c.Codigo
		,c.Excluyente
		,c.Descripcion
		,c.Estado
	FROM ConfiguracionPais c
		INNER JOIN ConfiguracionPaisDetalle d ON c.ConfiguracionPaisID = d.ConfiguracionPaisID
	WHERE c.Estado = '1' AND d.Estado = '1' AND (@Codigo = '' OR c.Codigo = @Codigo)
		AND Excluyente = 1 AND (d.CodigoRegion != @CodigoRegion OR d.CodigoZona != @CodigoZona OR d.CodigoSeccion != @CodigoSeccion OR d.CodigoConsultora != @CodigoConsultora)	
	UNION 
	SELECT c.ConfiguracionPaisID
		,c.Codigo
		,c.Excluyente
		,c.Descripcion
		,c.Estado
	FROM ConfiguracionPais c
	INNER JOIN ConfiguracionPaisDetalle d ON c.ConfiguracionPaisID = d.ConfiguracionPaisID
	WHERE c.Estado = '1' AND d.Estado = '1' AND (@Codigo = '' OR c.Codigo = @Codigo)
		AND Excluyente = 0 AND (d.CodigoRegion = @CodigoRegion OR d.CodigoZona = @CodigoZona OR d.CodigoSeccion = @CodigoSeccion OR d.CodigoConsultora = @CodigoConsultora)
END
GO
/*end*/

USE BelcorpPanama
GO

--------------------------------------------------------------------------------------------------
-- RECUPECAION DE DATOS DE LA TABLA CONFIGURACION PAIS
--------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ConfiguracionPais_GetAll]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ConfiguracionPais_GetAll]
GO

CREATE PROCEDURE [dbo].[ConfiguracionPais_GetAll]
(
	@Codigo varchar(100) = ''
	,@CodigoRegion  varchar(100) = ''
	,@CodigoZona  varchar(100) = ''
	,@CodigoSeccion  varchar(100) = ''
	,@CodigoConsultora  varchar(100) = ''
)
AS
BEGIN

	SET NOCOUNT ON;
	IF(@Codigo IS NULL OR @Codigo = 'NULL') SET @Codigo = '';
	SELECT c.ConfiguracionPaisID
		,c.Codigo
		,c.Excluyente
		,c.Descripcion
		,c.Estado
	FROM ConfiguracionPais c
		INNER JOIN ConfiguracionPaisDetalle d ON c.ConfiguracionPaisID = d.ConfiguracionPaisID
	WHERE c.Estado = '1' AND d.Estado = '1' AND (@Codigo = '' OR c.Codigo = @Codigo)
		AND Excluyente = 1 AND (d.CodigoRegion != @CodigoRegion OR d.CodigoZona != @CodigoZona OR d.CodigoSeccion != @CodigoSeccion OR d.CodigoConsultora != @CodigoConsultora)	
	UNION 
	SELECT c.ConfiguracionPaisID
		,c.Codigo
		,c.Excluyente
		,c.Descripcion
		,c.Estado
	FROM ConfiguracionPais c
	INNER JOIN ConfiguracionPaisDetalle d ON c.ConfiguracionPaisID = d.ConfiguracionPaisID
	WHERE c.Estado = '1' AND d.Estado = '1' AND (@Codigo = '' OR c.Codigo = @Codigo)
		AND Excluyente = 0 AND (d.CodigoRegion = @CodigoRegion OR d.CodigoZona = @CodigoZona OR d.CodigoSeccion = @CodigoSeccion OR d.CodigoConsultora = @CodigoConsultora)
END
GO
/*end*/

USE BelcorpGuatemala
GO

--------------------------------------------------------------------------------------------------
-- RECUPECAION DE DATOS DE LA TABLA CONFIGURACION PAIS
--------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ConfiguracionPais_GetAll]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ConfiguracionPais_GetAll]
GO

CREATE PROCEDURE [dbo].[ConfiguracionPais_GetAll]
(
	@Codigo varchar(100) = ''
	,@CodigoRegion  varchar(100) = ''
	,@CodigoZona  varchar(100) = ''
	,@CodigoSeccion  varchar(100) = ''
	,@CodigoConsultora  varchar(100) = ''
)
AS
BEGIN

	SET NOCOUNT ON;
	IF(@Codigo IS NULL OR @Codigo = 'NULL') SET @Codigo = '';
	SELECT c.ConfiguracionPaisID
		,c.Codigo
		,c.Excluyente
		,c.Descripcion
		,c.Estado
	FROM ConfiguracionPais c
		INNER JOIN ConfiguracionPaisDetalle d ON c.ConfiguracionPaisID = d.ConfiguracionPaisID
	WHERE c.Estado = '1' AND d.Estado = '1' AND (@Codigo = '' OR c.Codigo = @Codigo)
		AND Excluyente = 1 AND (d.CodigoRegion != @CodigoRegion OR d.CodigoZona != @CodigoZona OR d.CodigoSeccion != @CodigoSeccion OR d.CodigoConsultora != @CodigoConsultora)	
	UNION 
	SELECT c.ConfiguracionPaisID
		,c.Codigo
		,c.Excluyente
		,c.Descripcion
		,c.Estado
	FROM ConfiguracionPais c
	INNER JOIN ConfiguracionPaisDetalle d ON c.ConfiguracionPaisID = d.ConfiguracionPaisID
	WHERE c.Estado = '1' AND d.Estado = '1' AND (@Codigo = '' OR c.Codigo = @Codigo)
		AND Excluyente = 0 AND (d.CodigoRegion = @CodigoRegion OR d.CodigoZona = @CodigoZona OR d.CodigoSeccion = @CodigoSeccion OR d.CodigoConsultora = @CodigoConsultora)
END
GO
/*end*/

USE BelcorpEcuador
GO

--------------------------------------------------------------------------------------------------
-- RECUPECAION DE DATOS DE LA TABLA CONFIGURACION PAIS
--------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ConfiguracionPais_GetAll]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ConfiguracionPais_GetAll]
GO

CREATE PROCEDURE [dbo].[ConfiguracionPais_GetAll]
(
	@Codigo varchar(100) = ''
	,@CodigoRegion  varchar(100) = ''
	,@CodigoZona  varchar(100) = ''
	,@CodigoSeccion  varchar(100) = ''
	,@CodigoConsultora  varchar(100) = ''
)
AS
BEGIN

	SET NOCOUNT ON;
	IF(@Codigo IS NULL OR @Codigo = 'NULL') SET @Codigo = '';
	SELECT c.ConfiguracionPaisID
		,c.Codigo
		,c.Excluyente
		,c.Descripcion
		,c.Estado
	FROM ConfiguracionPais c
		INNER JOIN ConfiguracionPaisDetalle d ON c.ConfiguracionPaisID = d.ConfiguracionPaisID
	WHERE c.Estado = '1' AND d.Estado = '1' AND (@Codigo = '' OR c.Codigo = @Codigo)
		AND Excluyente = 1 AND (d.CodigoRegion != @CodigoRegion OR d.CodigoZona != @CodigoZona OR d.CodigoSeccion != @CodigoSeccion OR d.CodigoConsultora != @CodigoConsultora)	
	UNION 
	SELECT c.ConfiguracionPaisID
		,c.Codigo
		,c.Excluyente
		,c.Descripcion
		,c.Estado
	FROM ConfiguracionPais c
	INNER JOIN ConfiguracionPaisDetalle d ON c.ConfiguracionPaisID = d.ConfiguracionPaisID
	WHERE c.Estado = '1' AND d.Estado = '1' AND (@Codigo = '' OR c.Codigo = @Codigo)
		AND Excluyente = 0 AND (d.CodigoRegion = @CodigoRegion OR d.CodigoZona = @CodigoZona OR d.CodigoSeccion = @CodigoSeccion OR d.CodigoConsultora = @CodigoConsultora)
END
GO
/*end*/

USE BelcorpDominicana
GO

--------------------------------------------------------------------------------------------------
-- RECUPECAION DE DATOS DE LA TABLA CONFIGURACION PAIS
--------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ConfiguracionPais_GetAll]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ConfiguracionPais_GetAll]
GO

CREATE PROCEDURE [dbo].[ConfiguracionPais_GetAll]
(
	@Codigo varchar(100) = ''
	,@CodigoRegion  varchar(100) = ''
	,@CodigoZona  varchar(100) = ''
	,@CodigoSeccion  varchar(100) = ''
	,@CodigoConsultora  varchar(100) = ''
)
AS
BEGIN

	SET NOCOUNT ON;
	IF(@Codigo IS NULL OR @Codigo = 'NULL') SET @Codigo = '';
	SELECT c.ConfiguracionPaisID
		,c.Codigo
		,c.Excluyente
		,c.Descripcion
		,c.Estado
	FROM ConfiguracionPais c
		INNER JOIN ConfiguracionPaisDetalle d ON c.ConfiguracionPaisID = d.ConfiguracionPaisID
	WHERE c.Estado = '1' AND d.Estado = '1' AND (@Codigo = '' OR c.Codigo = @Codigo)
		AND Excluyente = 1 AND (d.CodigoRegion != @CodigoRegion OR d.CodigoZona != @CodigoZona OR d.CodigoSeccion != @CodigoSeccion OR d.CodigoConsultora != @CodigoConsultora)	
	UNION 
	SELECT c.ConfiguracionPaisID
		,c.Codigo
		,c.Excluyente
		,c.Descripcion
		,c.Estado
	FROM ConfiguracionPais c
	INNER JOIN ConfiguracionPaisDetalle d ON c.ConfiguracionPaisID = d.ConfiguracionPaisID
	WHERE c.Estado = '1' AND d.Estado = '1' AND (@Codigo = '' OR c.Codigo = @Codigo)
		AND Excluyente = 0 AND (d.CodigoRegion = @CodigoRegion OR d.CodigoZona = @CodigoZona OR d.CodigoSeccion = @CodigoSeccion OR d.CodigoConsultora = @CodigoConsultora)
END
GO
/*end*/

USE BelcorpCostaRica
GO

--------------------------------------------------------------------------------------------------
-- RECUPECAION DE DATOS DE LA TABLA CONFIGURACION PAIS
--------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ConfiguracionPais_GetAll]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ConfiguracionPais_GetAll]
GO

CREATE PROCEDURE [dbo].[ConfiguracionPais_GetAll]
(
	@Codigo varchar(100) = ''
	,@CodigoRegion  varchar(100) = ''
	,@CodigoZona  varchar(100) = ''
	,@CodigoSeccion  varchar(100) = ''
	,@CodigoConsultora  varchar(100) = ''
)
AS
BEGIN

	SET NOCOUNT ON;
	IF(@Codigo IS NULL OR @Codigo = 'NULL') SET @Codigo = '';
	SELECT c.ConfiguracionPaisID
		,c.Codigo
		,c.Excluyente
		,c.Descripcion
		,c.Estado
	FROM ConfiguracionPais c
		INNER JOIN ConfiguracionPaisDetalle d ON c.ConfiguracionPaisID = d.ConfiguracionPaisID
	WHERE c.Estado = '1' AND d.Estado = '1' AND (@Codigo = '' OR c.Codigo = @Codigo)
		AND Excluyente = 1 AND (d.CodigoRegion != @CodigoRegion OR d.CodigoZona != @CodigoZona OR d.CodigoSeccion != @CodigoSeccion OR d.CodigoConsultora != @CodigoConsultora)	
	UNION 
	SELECT c.ConfiguracionPaisID
		,c.Codigo
		,c.Excluyente
		,c.Descripcion
		,c.Estado
	FROM ConfiguracionPais c
	INNER JOIN ConfiguracionPaisDetalle d ON c.ConfiguracionPaisID = d.ConfiguracionPaisID
	WHERE c.Estado = '1' AND d.Estado = '1' AND (@Codigo = '' OR c.Codigo = @Codigo)
		AND Excluyente = 0 AND (d.CodigoRegion = @CodigoRegion OR d.CodigoZona = @CodigoZona OR d.CodigoSeccion = @CodigoSeccion OR d.CodigoConsultora = @CodigoConsultora)
END
GO
/*end*/

USE BelcorpChile
GO

--------------------------------------------------------------------------------------------------
-- RECUPECAION DE DATOS DE LA TABLA CONFIGURACION PAIS
--------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ConfiguracionPais_GetAll]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ConfiguracionPais_GetAll]
GO

CREATE PROCEDURE [dbo].[ConfiguracionPais_GetAll]
(
	@Codigo varchar(100) = ''
	,@CodigoRegion  varchar(100) = ''
	,@CodigoZona  varchar(100) = ''
	,@CodigoSeccion  varchar(100) = ''
	,@CodigoConsultora  varchar(100) = ''
)
AS
BEGIN

	SET NOCOUNT ON;
	IF(@Codigo IS NULL OR @Codigo = 'NULL') SET @Codigo = '';
	SELECT c.ConfiguracionPaisID
		,c.Codigo
		,c.Excluyente
		,c.Descripcion
		,c.Estado
	FROM ConfiguracionPais c
		INNER JOIN ConfiguracionPaisDetalle d ON c.ConfiguracionPaisID = d.ConfiguracionPaisID
	WHERE c.Estado = '1' AND d.Estado = '1' AND (@Codigo = '' OR c.Codigo = @Codigo)
		AND Excluyente = 1 AND (d.CodigoRegion != @CodigoRegion OR d.CodigoZona != @CodigoZona OR d.CodigoSeccion != @CodigoSeccion OR d.CodigoConsultora != @CodigoConsultora)	
	UNION 
	SELECT c.ConfiguracionPaisID
		,c.Codigo
		,c.Excluyente
		,c.Descripcion
		,c.Estado
	FROM ConfiguracionPais c
	INNER JOIN ConfiguracionPaisDetalle d ON c.ConfiguracionPaisID = d.ConfiguracionPaisID
	WHERE c.Estado = '1' AND d.Estado = '1' AND (@Codigo = '' OR c.Codigo = @Codigo)
		AND Excluyente = 0 AND (d.CodigoRegion = @CodigoRegion OR d.CodigoZona = @CodigoZona OR d.CodigoSeccion = @CodigoSeccion OR d.CodigoConsultora = @CodigoConsultora)
END
GO
/*end*/

USE BelcorpBolivia
GO

--------------------------------------------------------------------------------------------------
-- RECUPECAION DE DATOS DE LA TABLA CONFIGURACION PAIS
--------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ConfiguracionPais_GetAll]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ConfiguracionPais_GetAll]
GO

CREATE PROCEDURE [dbo].[ConfiguracionPais_GetAll]
(
	@Codigo varchar(100) = ''
	,@CodigoRegion  varchar(100) = ''
	,@CodigoZona  varchar(100) = ''
	,@CodigoSeccion  varchar(100) = ''
	,@CodigoConsultora  varchar(100) = ''
)
AS
BEGIN

	SET NOCOUNT ON;
	IF(@Codigo IS NULL OR @Codigo = 'NULL') SET @Codigo = '';
	SELECT c.ConfiguracionPaisID
		,c.Codigo
		,c.Excluyente
		,c.Descripcion
		,c.Estado
	FROM ConfiguracionPais c
		INNER JOIN ConfiguracionPaisDetalle d ON c.ConfiguracionPaisID = d.ConfiguracionPaisID
	WHERE c.Estado = '1' AND d.Estado = '1' AND (@Codigo = '' OR c.Codigo = @Codigo)
		AND Excluyente = 1 AND (d.CodigoRegion != @CodigoRegion OR d.CodigoZona != @CodigoZona OR d.CodigoSeccion != @CodigoSeccion OR d.CodigoConsultora != @CodigoConsultora)	
	UNION 
	SELECT c.ConfiguracionPaisID
		,c.Codigo
		,c.Excluyente
		,c.Descripcion
		,c.Estado
	FROM ConfiguracionPais c
	INNER JOIN ConfiguracionPaisDetalle d ON c.ConfiguracionPaisID = d.ConfiguracionPaisID
	WHERE c.Estado = '1' AND d.Estado = '1' AND (@Codigo = '' OR c.Codigo = @Codigo)
		AND Excluyente = 0 AND (d.CodigoRegion = @CodigoRegion OR d.CodigoZona = @CodigoZona OR d.CodigoSeccion = @CodigoSeccion OR d.CodigoConsultora = @CodigoConsultora)
END
GO
