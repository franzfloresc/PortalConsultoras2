USE BelcorpPeru
GO

IF (OBJECT_ID ( 'dbo.ValidarDesactivaRevistaGana', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.ValidarDesactivaRevistaGana AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.ValidarDesactivaRevistaGana
@CampaniaID INT,  
@Codigo VARCHAR(15)  
AS  
BEGIN
	SET NOCOUNT ON

	SELECT COUNT(1) AS CUENTA  
	FROM dbo.DesactivaRevistaGana (NOLOCK)   
	WHERE CampaniaID = @CampaniaID  
	AND CodigoZona = @Codigo  

	SET NOCOUNT OFF
END
GO

USE BelcorpMexico
GO

IF (OBJECT_ID ( 'dbo.ValidarDesactivaRevistaGana', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.ValidarDesactivaRevistaGana AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.ValidarDesactivaRevistaGana
@CampaniaID INT,  
@Codigo VARCHAR(15)  
AS  
BEGIN
	SET NOCOUNT ON

	SELECT COUNT(1) AS CUENTA  
	FROM dbo.DesactivaRevistaGana (NOLOCK)   
	WHERE CampaniaID = @CampaniaID  
	AND CodigoZona = @Codigo  

	SET NOCOUNT OFF
END
GO

USE BelcorpColombia
GO

IF (OBJECT_ID ( 'dbo.ValidarDesactivaRevistaGana', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.ValidarDesactivaRevistaGana AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.ValidarDesactivaRevistaGana
@CampaniaID INT,  
@Codigo VARCHAR(15)  
AS  
BEGIN
	SET NOCOUNT ON

	SELECT COUNT(1) AS CUENTA  
	FROM dbo.DesactivaRevistaGana (NOLOCK)   
	WHERE CampaniaID = @CampaniaID  
	AND CodigoZona = @Codigo  

	SET NOCOUNT OFF
END
GO

USE BelcorpSalvador
GO

IF (OBJECT_ID ( 'dbo.ValidarDesactivaRevistaGana', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.ValidarDesactivaRevistaGana AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.ValidarDesactivaRevistaGana
@CampaniaID INT,  
@Codigo VARCHAR(15)  
AS  
BEGIN
	SET NOCOUNT ON

	SELECT COUNT(1) AS CUENTA  
	FROM dbo.DesactivaRevistaGana (NOLOCK)   
	WHERE CampaniaID = @CampaniaID  
	AND CodigoZona = @Codigo  

	SET NOCOUNT OFF
END
GO

USE BelcorpPuertoRico
GO

IF (OBJECT_ID ( 'dbo.ValidarDesactivaRevistaGana', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.ValidarDesactivaRevistaGana AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.ValidarDesactivaRevistaGana
@CampaniaID INT,  
@Codigo VARCHAR(15)  
AS  
BEGIN
	SET NOCOUNT ON

	SELECT COUNT(1) AS CUENTA  
	FROM dbo.DesactivaRevistaGana (NOLOCK)   
	WHERE CampaniaID = @CampaniaID  
	AND CodigoZona = @Codigo  

	SET NOCOUNT OFF
END
GO

USE BelcorpPanama
GO

IF (OBJECT_ID ( 'dbo.ValidarDesactivaRevistaGana', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.ValidarDesactivaRevistaGana AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.ValidarDesactivaRevistaGana
@CampaniaID INT,  
@Codigo VARCHAR(15)  
AS  
BEGIN
	SET NOCOUNT ON

	SELECT COUNT(1) AS CUENTA  
	FROM dbo.DesactivaRevistaGana (NOLOCK)   
	WHERE CampaniaID = @CampaniaID  
	AND CodigoZona = @Codigo  

	SET NOCOUNT OFF
END
GO

USE BelcorpGuatemala
GO

IF (OBJECT_ID ( 'dbo.ValidarDesactivaRevistaGana', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.ValidarDesactivaRevistaGana AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.ValidarDesactivaRevistaGana
@CampaniaID INT,  
@Codigo VARCHAR(15)  
AS  
BEGIN
	SET NOCOUNT ON

	SELECT COUNT(1) AS CUENTA  
	FROM dbo.DesactivaRevistaGana (NOLOCK)   
	WHERE CampaniaID = @CampaniaID  
	AND CodigoZona = @Codigo  

	SET NOCOUNT OFF
END
GO

USE BelcorpEcuador
GO

IF (OBJECT_ID ( 'dbo.ValidarDesactivaRevistaGana', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.ValidarDesactivaRevistaGana AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.ValidarDesactivaRevistaGana
@CampaniaID INT,  
@Codigo VARCHAR(15)  
AS  
BEGIN
	SET NOCOUNT ON

	SELECT COUNT(1) AS CUENTA  
	FROM dbo.DesactivaRevistaGana (NOLOCK)   
	WHERE CampaniaID = @CampaniaID  
	AND CodigoZona = @Codigo  

	SET NOCOUNT OFF
END
GO

USE BelcorpDominicana
GO

IF (OBJECT_ID ( 'dbo.ValidarDesactivaRevistaGana', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.ValidarDesactivaRevistaGana AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.ValidarDesactivaRevistaGana
@CampaniaID INT,  
@Codigo VARCHAR(15)  
AS  
BEGIN
	SET NOCOUNT ON

	SELECT COUNT(1) AS CUENTA  
	FROM dbo.DesactivaRevistaGana (NOLOCK)   
	WHERE CampaniaID = @CampaniaID  
	AND CodigoZona = @Codigo  

	SET NOCOUNT OFF
END
GO

USE BelcorpCostaRica
GO

IF (OBJECT_ID ( 'dbo.ValidarDesactivaRevistaGana', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.ValidarDesactivaRevistaGana AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.ValidarDesactivaRevistaGana
@CampaniaID INT,  
@Codigo VARCHAR(15)  
AS  
BEGIN
	SET NOCOUNT ON

	SELECT COUNT(1) AS CUENTA  
	FROM dbo.DesactivaRevistaGana (NOLOCK)   
	WHERE CampaniaID = @CampaniaID  
	AND CodigoZona = @Codigo  

	SET NOCOUNT OFF
END
GO

USE BelcorpChile
GO

IF (OBJECT_ID ( 'dbo.ValidarDesactivaRevistaGana', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.ValidarDesactivaRevistaGana AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.ValidarDesactivaRevistaGana
@CampaniaID INT,  
@Codigo VARCHAR(15)  
AS  
BEGIN
	SET NOCOUNT ON

	SELECT COUNT(1) AS CUENTA  
	FROM dbo.DesactivaRevistaGana (NOLOCK)   
	WHERE CampaniaID = @CampaniaID  
	AND CodigoZona = @Codigo  

	SET NOCOUNT OFF
END
GO

USE BelcorpBolivia
GO

IF (OBJECT_ID ( 'dbo.ValidarDesactivaRevistaGana', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.ValidarDesactivaRevistaGana AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.ValidarDesactivaRevistaGana
@CampaniaID INT,  
@Codigo VARCHAR(15)  
AS  
BEGIN
	SET NOCOUNT ON

	SELECT COUNT(1) AS CUENTA  
	FROM dbo.DesactivaRevistaGana (NOLOCK)   
	WHERE CampaniaID = @CampaniaID  
	AND CodigoZona = @Codigo  

	SET NOCOUNT OFF
END
GO

