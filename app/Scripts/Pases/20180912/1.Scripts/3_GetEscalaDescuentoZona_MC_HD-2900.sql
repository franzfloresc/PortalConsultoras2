USE [BelcorpPeru]  
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetEscalaDescuentoZona]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetEscalaDescuentoZona
GO
CREATE PROC [dbo].GetEscalaDescuentoZona
@CampaniaId			VARCHAR(6),
@CodRegion			VARCHAR(2),
@CodZona			VARCHAR(4)
AS
BEGIN
	
	SELECT 
		CampaniaId		,
		CodRegion 		,
		CodZona 		,
		MontoHasta 		,
		PorDescuento	,
		FechaCarga 		
	FROM  ods.escaladescuentoZona 
	WHERE CampaniaId	= @CampaniaId
		  AND  LTRIM(RTRIM(CodRegion))	= @CodRegion
		  AND  LTRIM(RTRIM(CodZona))	= @CodZona;
END
GO

USE [BelcorpBolivia]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetEscalaDescuentoZona]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetEscalaDescuentoZona
GO
CREATE PROC [dbo].GetEscalaDescuentoZona
@CampaniaId			VARCHAR(6),
@CodRegion			VARCHAR(2),
@CodZona			VARCHAR(4)
AS
BEGIN
	
	SELECT 
		CampaniaId		,
		CodRegion 		,
		CodZona 		,
		MontoHasta 		,
		PorDescuento	,
		FechaCarga 		
	FROM  ods.escaladescuentoZona 
	WHERE CampaniaId	= @CampaniaId
		  AND  LTRIM(RTRIM(CodRegion))	= @CodRegion
		  AND  LTRIM(RTRIM(CodZona))	= @CodZona;
END
GO

USE [BelcorpChile]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetEscalaDescuentoZona]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetEscalaDescuentoZona
GO
CREATE PROC [dbo].GetEscalaDescuentoZona
@CampaniaId			VARCHAR(6),
@CodRegion			VARCHAR(2),
@CodZona			VARCHAR(4)
AS
BEGIN
	
	SELECT 
		CampaniaId		,
		CodRegion 		,
		CodZona 		,
		MontoHasta 		,
		PorDescuento	,
		FechaCarga 		
	FROM  ods.escaladescuentoZona 
	WHERE CampaniaId	= @CampaniaId
		  AND  LTRIM(RTRIM(CodRegion))	= @CodRegion
		  AND  LTRIM(RTRIM(CodZona))	= @CodZona;
END
GO

USE [BelcorpColombia]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetEscalaDescuentoZona]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetEscalaDescuentoZona
GO
CREATE PROC [dbo].GetEscalaDescuentoZona
@CampaniaId			VARCHAR(6),
@CodRegion			VARCHAR(2),
@CodZona			VARCHAR(4)
AS
BEGIN
	
	SELECT 
		CampaniaId		,
		CodRegion 		,
		CodZona 		,
		MontoHasta 		,
		PorDescuento	,
		FechaCarga 		
	FROM  ods.escaladescuentoZona 
	WHERE CampaniaId	= @CampaniaId
		  AND  LTRIM(RTRIM(CodRegion))	= @CodRegion
		  AND  LTRIM(RTRIM(CodZona))	= @CodZona;
END
GO

USE [BelcorpCostaRica]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetEscalaDescuentoZona]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetEscalaDescuentoZona
GO
CREATE PROC [dbo].GetEscalaDescuentoZona
@CampaniaId			VARCHAR(6),
@CodRegion			VARCHAR(2),
@CodZona			VARCHAR(4)
AS
BEGIN
	
	SELECT 
		CampaniaId		,
		CodRegion 		,
		CodZona 		,
		MontoHasta 		,
		PorDescuento	,
		FechaCarga 		
	FROM  ods.escaladescuentoZona 
	WHERE CampaniaId	= @CampaniaId
		  AND  LTRIM(RTRIM(CodRegion))	= @CodRegion
		  AND  LTRIM(RTRIM(CodZona))	= @CodZona;
END
GO

USE [BelcorpDominicana]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetEscalaDescuentoZona]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetEscalaDescuentoZona
GO
CREATE PROC [dbo].GetEscalaDescuentoZona
@CampaniaId			VARCHAR(6),
@CodRegion			VARCHAR(2),
@CodZona			VARCHAR(4)
AS
BEGIN
	
	SELECT 
		CampaniaId		,
		CodRegion 		,
		CodZona 		,
		MontoHasta 		,
		PorDescuento	,
		FechaCarga 		
	FROM  ods.escaladescuentoZona 
	WHERE CampaniaId	= @CampaniaId
		  AND  LTRIM(RTRIM(CodRegion))	= @CodRegion
		  AND  LTRIM(RTRIM(CodZona))	= @CodZona;
END
GO

USE [BelcorpEcuador]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetEscalaDescuentoZona]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetEscalaDescuentoZona
GO
CREATE PROC [dbo].GetEscalaDescuentoZona
@CampaniaId			VARCHAR(6),
@CodRegion			VARCHAR(2),
@CodZona			VARCHAR(4)
AS
BEGIN
	
	SELECT 
		CampaniaId		,
		CodRegion 		,
		CodZona 		,
		MontoHasta 		,
		PorDescuento	,
		FechaCarga 		
	FROM  ods.escaladescuentoZona 
	WHERE CampaniaId	= @CampaniaId
		  AND  LTRIM(RTRIM(CodRegion))	= @CodRegion
		  AND  LTRIM(RTRIM(CodZona))	= @CodZona;
END
GO

USE [BelcorpGuatemala]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetEscalaDescuentoZona]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetEscalaDescuentoZona
GO
CREATE PROC [dbo].GetEscalaDescuentoZona
@CampaniaId			VARCHAR(6),
@CodRegion			VARCHAR(2),
@CodZona			VARCHAR(4)
AS
BEGIN
	
	SELECT 
		CampaniaId		,
		CodRegion 		,
		CodZona 		,
		MontoHasta 		,
		PorDescuento	,
		FechaCarga 		
	FROM  ods.escaladescuentoZona 
	WHERE CampaniaId	= @CampaniaId
		  AND  LTRIM(RTRIM(CodRegion))	= @CodRegion
		  AND  LTRIM(RTRIM(CodZona))	= @CodZona;
END
GO

USE [BelcorpMexico]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetEscalaDescuentoZona]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetEscalaDescuentoZona
GO
CREATE PROC [dbo].GetEscalaDescuentoZona
@CampaniaId			VARCHAR(6),
@CodRegion			VARCHAR(2),
@CodZona			VARCHAR(4)
AS
BEGIN
	
	SELECT 
		CampaniaId		,
		CodRegion 		,
		CodZona 		,
		MontoHasta 		,
		PorDescuento	,
		FechaCarga 		
	FROM  ods.escaladescuentoZona 
	WHERE CampaniaId	= @CampaniaId
		  AND  LTRIM(RTRIM(CodRegion))	= @CodRegion
		  AND  LTRIM(RTRIM(CodZona))	= @CodZona;
END
GO

USE [BelcorpPanama]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetEscalaDescuentoZona]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetEscalaDescuentoZona
GO
CREATE PROC [dbo].GetEscalaDescuentoZona
@CampaniaId			VARCHAR(6),
@CodRegion			VARCHAR(2),
@CodZona			VARCHAR(4)
AS
BEGIN
	
	SELECT 
		CampaniaId		,
		CodRegion 		,
		CodZona 		,
		MontoHasta 		,
		PorDescuento	,
		FechaCarga 		
	FROM  ods.escaladescuentoZona 
	WHERE CampaniaId	= @CampaniaId
		  AND  LTRIM(RTRIM(CodRegion))	= @CodRegion
		  AND  LTRIM(RTRIM(CodZona))	= @CodZona;
END
GO

USE [BelcorpPuertoRico]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetEscalaDescuentoZona]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetEscalaDescuentoZona
GO
CREATE PROC [dbo].GetEscalaDescuentoZona
@CampaniaId			VARCHAR(6),
@CodRegion			VARCHAR(2),
@CodZona			VARCHAR(4)
AS
BEGIN
	
	SELECT 
		CampaniaId		,
		CodRegion 		,
		CodZona 		,
		MontoHasta 		,
		PorDescuento	,
		FechaCarga 		
	FROM  ods.escaladescuentoZona 
	WHERE CampaniaId	= @CampaniaId
		  AND  LTRIM(RTRIM(CodRegion))	= @CodRegion
		  AND  LTRIM(RTRIM(CodZona))	= @CodZona;
END
GO

USE [BelcorpSalvador]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetEscalaDescuentoZona]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetEscalaDescuentoZona
GO
CREATE PROC [dbo].GetEscalaDescuentoZona
@CampaniaId			VARCHAR(6),
@CodRegion			VARCHAR(2),
@CodZona			VARCHAR(4)
AS
BEGIN
	
	SELECT 
		CampaniaId		,
		CodRegion 		,
		CodZona 		,
		MontoHasta 		,
		PorDescuento	,
		FechaCarga 		
	FROM  ods.escaladescuentoZona 
	WHERE CampaniaId	= @CampaniaId
		  AND  LTRIM(RTRIM(CodRegion))	= @CodRegion
		  AND  LTRIM(RTRIM(CodZona))	= @CodZona;
END
GO