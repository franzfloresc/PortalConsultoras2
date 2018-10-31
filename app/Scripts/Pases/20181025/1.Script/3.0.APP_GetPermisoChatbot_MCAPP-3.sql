USE BelcorpPeru
GO

/* ELIMINAMOS GetPermisoChatbot */
IF (OBJECT_ID ('GetPermisoChatbot') IS NOT NULL)
    DROP FUNCTION [dbo].[GetPermisoChatbot];
GO

/* FUNCTION GetPermisoChatbot */
CREATE FUNCTION [dbo].[GetPermisoChatbot] (
	@CodigoConsultora VARCHAR(20)
)
RETURNS INT
BEGIN
	DECLARE @resultado INT = 0
	DECLARE @consultoraDigital BIT = 0

	SELECT @consultoraDigital = C.IndicadorConsultoraDigital
	FROM ods.Consultora C WITH(NOLOCK) 
	WHERE C.Codigo = @CodigoConsultora;
	
	SELECT TOP 1 
		@resultado = 1
	FROM TablaLogicaDatos TL
	WHERE TL.TablaLogicaDatosID = 14901 
		  AND @consultoraDigital IS NOT NULL
		  AND ( TL.Valor IN ('1','11') 
				OR ( @consultoraDigital = 1 AND TL.Valor = '10' ) 
				OR ( @consultoraDigital = 0 AND  TL.Valor ='01' ) 
		  );
		  
	RETURN @resultado
END;
GO

USE BelcorpMexico
GO

/* ELIMINAMOS GetPermisoChatbot */
IF (OBJECT_ID ('GetPermisoChatbot') IS NOT NULL)
    DROP FUNCTION [dbo].[GetPermisoChatbot];
GO

/* FUNCTION GetPermisoChatbot */
CREATE FUNCTION [dbo].[GetPermisoChatbot] (
	@CodigoConsultora VARCHAR(20)
)
RETURNS INT
BEGIN
	DECLARE @resultado INT = 0
	DECLARE @consultoraDigital BIT = 0

	SELECT @consultoraDigital = C.IndicadorConsultoraDigital
	FROM ods.Consultora C WITH(NOLOCK) 
	WHERE C.Codigo = @CodigoConsultora;
	
	SELECT TOP 1 
		@resultado = 1
	FROM TablaLogicaDatos TL
	WHERE TL.TablaLogicaDatosID = 14901 
		  AND @consultoraDigital IS NOT NULL
		  AND ( TL.Valor IN ('1','11') 
				OR ( @consultoraDigital = 1 AND TL.Valor = '10' ) 
				OR ( @consultoraDigital = 0 AND  TL.Valor ='01' ) 
		  );
		  
	RETURN @resultado
END;
GO

USE BelcorpColombia
GO

/* ELIMINAMOS GetPermisoChatbot */
IF (OBJECT_ID ('GetPermisoChatbot') IS NOT NULL)
    DROP FUNCTION [dbo].[GetPermisoChatbot];
GO

/* FUNCTION GetPermisoChatbot */
CREATE FUNCTION [dbo].[GetPermisoChatbot] (
	@CodigoConsultora VARCHAR(20)
)
RETURNS INT
BEGIN
	DECLARE @resultado INT = 0
	DECLARE @consultoraDigital BIT = 0

	SELECT @consultoraDigital = C.IndicadorConsultoraDigital
	FROM ods.Consultora C WITH(NOLOCK) 
	WHERE C.Codigo = @CodigoConsultora;
	
	SELECT TOP 1 
		@resultado = 1
	FROM TablaLogicaDatos TL
	WHERE TL.TablaLogicaDatosID = 14901 
		  AND @consultoraDigital IS NOT NULL
		  AND ( TL.Valor IN ('1','11') 
				OR ( @consultoraDigital = 1 AND TL.Valor = '10' ) 
				OR ( @consultoraDigital = 0 AND  TL.Valor ='01' ) 
		  );
		  
	RETURN @resultado
END;
GO

USE BelcorpSalvador
GO

/* ELIMINAMOS GetPermisoChatbot */
IF (OBJECT_ID ('GetPermisoChatbot') IS NOT NULL)
    DROP FUNCTION [dbo].[GetPermisoChatbot];
GO

/* FUNCTION GetPermisoChatbot */
CREATE FUNCTION [dbo].[GetPermisoChatbot] (
	@CodigoConsultora VARCHAR(20)
)
RETURNS INT
BEGIN
	DECLARE @resultado INT = 0
	DECLARE @consultoraDigital BIT = 0

	SELECT @consultoraDigital = C.IndicadorConsultoraDigital
	FROM ods.Consultora C WITH(NOLOCK) 
	WHERE C.Codigo = @CodigoConsultora;
	
	SELECT TOP 1 
		@resultado = 1
	FROM TablaLogicaDatos TL
	WHERE TL.TablaLogicaDatosID = 14901 
		  AND @consultoraDigital IS NOT NULL
		  AND ( TL.Valor IN ('1','11') 
				OR ( @consultoraDigital = 1 AND TL.Valor = '10' ) 
				OR ( @consultoraDigital = 0 AND  TL.Valor ='01' ) 
		  );
		  
	RETURN @resultado
END;
GO

USE BelcorpPuertoRico
GO

/* ELIMINAMOS GetPermisoChatbot */
IF (OBJECT_ID ('GetPermisoChatbot') IS NOT NULL)
    DROP FUNCTION [dbo].[GetPermisoChatbot];
GO

/* FUNCTION GetPermisoChatbot */
CREATE FUNCTION [dbo].[GetPermisoChatbot] (
	@CodigoConsultora VARCHAR(20)
)
RETURNS INT
BEGIN
	DECLARE @resultado INT = 0
	DECLARE @consultoraDigital BIT = 0

	SELECT @consultoraDigital = C.IndicadorConsultoraDigital
	FROM ods.Consultora C WITH(NOLOCK) 
	WHERE C.Codigo = @CodigoConsultora;
	
	SELECT TOP 1 
		@resultado = 1
	FROM TablaLogicaDatos TL
	WHERE TL.TablaLogicaDatosID = 14901 
		  AND @consultoraDigital IS NOT NULL
		  AND ( TL.Valor IN ('1','11') 
				OR ( @consultoraDigital = 1 AND TL.Valor = '10' ) 
				OR ( @consultoraDigital = 0 AND  TL.Valor ='01' ) 
		  );
		  
	RETURN @resultado
END;
GO

USE BelcorpPanama
GO

/* ELIMINAMOS GetPermisoChatbot */
IF (OBJECT_ID ('GetPermisoChatbot') IS NOT NULL)
    DROP FUNCTION [dbo].[GetPermisoChatbot];
GO

/* FUNCTION GetPermisoChatbot */
CREATE FUNCTION [dbo].[GetPermisoChatbot] (
	@CodigoConsultora VARCHAR(20)
)
RETURNS INT
BEGIN
	DECLARE @resultado INT = 0
	DECLARE @consultoraDigital BIT = 0

	SELECT @consultoraDigital = C.IndicadorConsultoraDigital
	FROM ods.Consultora C WITH(NOLOCK) 
	WHERE C.Codigo = @CodigoConsultora;
	
	SELECT TOP 1 
		@resultado = 1
	FROM TablaLogicaDatos TL
	WHERE TL.TablaLogicaDatosID = 14901 
		  AND @consultoraDigital IS NOT NULL
		  AND ( TL.Valor IN ('1','11') 
				OR ( @consultoraDigital = 1 AND TL.Valor = '10' ) 
				OR ( @consultoraDigital = 0 AND  TL.Valor ='01' ) 
		  );
		  
	RETURN @resultado
END;
GO

USE BelcorpGuatemala
GO

/* ELIMINAMOS GetPermisoChatbot */
IF (OBJECT_ID ('GetPermisoChatbot') IS NOT NULL)
    DROP FUNCTION [dbo].[GetPermisoChatbot];
GO

/* FUNCTION GetPermisoChatbot */
CREATE FUNCTION [dbo].[GetPermisoChatbot] (
	@CodigoConsultora VARCHAR(20)
)
RETURNS INT
BEGIN
	DECLARE @resultado INT = 0
	DECLARE @consultoraDigital BIT = 0

	SELECT @consultoraDigital = C.IndicadorConsultoraDigital
	FROM ods.Consultora C WITH(NOLOCK) 
	WHERE C.Codigo = @CodigoConsultora;
	
	SELECT TOP 1 
		@resultado = 1
	FROM TablaLogicaDatos TL
	WHERE TL.TablaLogicaDatosID = 14901 
		  AND @consultoraDigital IS NOT NULL
		  AND ( TL.Valor IN ('1','11') 
				OR ( @consultoraDigital = 1 AND TL.Valor = '10' ) 
				OR ( @consultoraDigital = 0 AND  TL.Valor ='01' ) 
		  );
		  
	RETURN @resultado
END;
GO

USE BelcorpEcuador
GO

/* ELIMINAMOS GetPermisoChatbot */
IF (OBJECT_ID ('GetPermisoChatbot') IS NOT NULL)
    DROP FUNCTION [dbo].[GetPermisoChatbot];
GO

/* FUNCTION GetPermisoChatbot */
CREATE FUNCTION [dbo].[GetPermisoChatbot] (
	@CodigoConsultora VARCHAR(20)
)
RETURNS INT
BEGIN
	DECLARE @resultado INT = 0
	DECLARE @consultoraDigital BIT = 0

	SELECT @consultoraDigital = C.IndicadorConsultoraDigital
	FROM ods.Consultora C WITH(NOLOCK) 
	WHERE C.Codigo = @CodigoConsultora;
	
	SELECT TOP 1 
		@resultado = 1
	FROM TablaLogicaDatos TL
	WHERE TL.TablaLogicaDatosID = 14901 
		  AND @consultoraDigital IS NOT NULL
		  AND ( TL.Valor IN ('1','11') 
				OR ( @consultoraDigital = 1 AND TL.Valor = '10' ) 
				OR ( @consultoraDigital = 0 AND  TL.Valor ='01' ) 
		  );
		  
	RETURN @resultado
END;
GO

USE BelcorpDominicana
GO

/* ELIMINAMOS GetPermisoChatbot */
IF (OBJECT_ID ('GetPermisoChatbot') IS NOT NULL)
    DROP FUNCTION [dbo].[GetPermisoChatbot];
GO

/* FUNCTION GetPermisoChatbot */
CREATE FUNCTION [dbo].[GetPermisoChatbot] (
	@CodigoConsultora VARCHAR(20)
)
RETURNS INT
BEGIN
	DECLARE @resultado INT = 0
	DECLARE @consultoraDigital BIT = 0

	SELECT @consultoraDigital = C.IndicadorConsultoraDigital
	FROM ods.Consultora C WITH(NOLOCK) 
	WHERE C.Codigo = @CodigoConsultora;
	
	SELECT TOP 1 
		@resultado = 1
	FROM TablaLogicaDatos TL
	WHERE TL.TablaLogicaDatosID = 14901 
		  AND @consultoraDigital IS NOT NULL
		  AND ( TL.Valor IN ('1','11') 
				OR ( @consultoraDigital = 1 AND TL.Valor = '10' ) 
				OR ( @consultoraDigital = 0 AND  TL.Valor ='01' ) 
		  );
		  
	RETURN @resultado
END;
GO

USE BelcorpCostaRica
GO

/* ELIMINAMOS GetPermisoChatbot */
IF (OBJECT_ID ('GetPermisoChatbot') IS NOT NULL)
    DROP FUNCTION [dbo].[GetPermisoChatbot];
GO

/* FUNCTION GetPermisoChatbot */
CREATE FUNCTION [dbo].[GetPermisoChatbot] (
	@CodigoConsultora VARCHAR(20)
)
RETURNS INT
BEGIN
	DECLARE @resultado INT = 0
	DECLARE @consultoraDigital BIT = 0

	SELECT @consultoraDigital = C.IndicadorConsultoraDigital
	FROM ods.Consultora C WITH(NOLOCK) 
	WHERE C.Codigo = @CodigoConsultora;
	
	SELECT TOP 1 
		@resultado = 1
	FROM TablaLogicaDatos TL
	WHERE TL.TablaLogicaDatosID = 14901 
		  AND @consultoraDigital IS NOT NULL
		  AND ( TL.Valor IN ('1','11') 
				OR ( @consultoraDigital = 1 AND TL.Valor = '10' ) 
				OR ( @consultoraDigital = 0 AND  TL.Valor ='01' ) 
		  );
		  
	RETURN @resultado
END;
GO

USE BelcorpChile
GO

/* ELIMINAMOS GetPermisoChatbot */
IF (OBJECT_ID ('GetPermisoChatbot') IS NOT NULL)
    DROP FUNCTION [dbo].[GetPermisoChatbot];
GO

/* FUNCTION GetPermisoChatbot */
CREATE FUNCTION [dbo].[GetPermisoChatbot] (
	@CodigoConsultora VARCHAR(20)
)
RETURNS INT
BEGIN
	DECLARE @resultado INT = 0
	DECLARE @consultoraDigital BIT = 0

	SELECT @consultoraDigital = C.IndicadorConsultoraDigital
	FROM ods.Consultora C WITH(NOLOCK) 
	WHERE C.Codigo = @CodigoConsultora;
	
	SELECT TOP 1 
		@resultado = 1
	FROM TablaLogicaDatos TL
	WHERE TL.TablaLogicaDatosID = 14901 
		  AND @consultoraDigital IS NOT NULL
		  AND ( TL.Valor IN ('1','11') 
				OR ( @consultoraDigital = 1 AND TL.Valor = '10' ) 
				OR ( @consultoraDigital = 0 AND  TL.Valor ='01' ) 
		  );
		  
	RETURN @resultado
END;
GO

USE BelcorpBolivia
GO

/* ELIMINAMOS GetPermisoChatbot */
IF (OBJECT_ID ('GetPermisoChatbot') IS NOT NULL)
    DROP FUNCTION [dbo].[GetPermisoChatbot];
GO

/* FUNCTION GetPermisoChatbot */
CREATE FUNCTION [dbo].[GetPermisoChatbot] (
	@CodigoConsultora VARCHAR(20)
)
RETURNS INT
BEGIN
	DECLARE @resultado INT = 0
	DECLARE @consultoraDigital BIT = 0

	SELECT @consultoraDigital = C.IndicadorConsultoraDigital
	FROM ods.Consultora C WITH(NOLOCK) 
	WHERE C.Codigo = @CodigoConsultora;
	
	SELECT TOP 1 
		@resultado = 1
	FROM TablaLogicaDatos TL
	WHERE TL.TablaLogicaDatosID = 14901 
		  AND @consultoraDigital IS NOT NULL
		  AND ( TL.Valor IN ('1','11') 
				OR ( @consultoraDigital = 1 AND TL.Valor = '10' ) 
				OR ( @consultoraDigital = 0 AND  TL.Valor ='01' ) 
		  );
		  
	RETURN @resultado
END;
GO

