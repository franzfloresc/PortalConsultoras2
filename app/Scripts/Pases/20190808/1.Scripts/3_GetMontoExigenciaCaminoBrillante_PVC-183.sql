USE BelcorpPeru
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'P' and id = OBJECT_ID('dbo.GetMontoExigenciaCaminoBrillante'))
	DROP PROC dbo.GetMontoExigenciaCaminoBrillante
GO
-- GetMontoExigenciaCaminoBrillante 3897, 201902, 201913, 4
CREATE PROC dbo.GetMontoExigenciaCaminoBrillante
(
	@CodigoCampania VARCHAR(8),
	@CodigoRegion VARCHAR(8),
	@CodigoZona VARCHAR(8)
)
AS
BEGIN
   SELECT TOP 1 [MontoID]
      ,[CodigoCampania]
      ,[CodigoRegion]
      ,[CodigoZona]
      ,[Monto]
      ,[AlcansoIncentivo]
  FROM [IncentivosMontoExigencia] WITH(NOLOCK)
  WHERE ([CodigoCampania] = @CodigoCampania OR [CodigoCampania] IS NULL OR [CodigoCampania] = '') 
		AND  ([CodigoRegion] = @CodigoRegion OR [CodigoRegion] IS NULL OR [CodigoRegion] = '')
		AND  ([CodigoZona] = @CodigoZona OR [CodigoZona] IS NULL OR [CodigoZona] = '')
  ORDER BY [CodigoCampania] DESC, [CodigoRegion] DESC, [CodigoZona] DESC
END
GO

USE BelcorpMexico
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'P' and id = OBJECT_ID('dbo.GetMontoExigenciaCaminoBrillante'))
	DROP PROC dbo.GetMontoExigenciaCaminoBrillante
GO
-- GetMontoExigenciaCaminoBrillante 3897, 201902, 201913, 4
CREATE PROC dbo.GetMontoExigenciaCaminoBrillante
(
	@CodigoCampania VARCHAR(8),
	@CodigoRegion VARCHAR(8),
	@CodigoZona VARCHAR(8)
)
AS
BEGIN
   SELECT TOP 1 [MontoID]
      ,[CodigoCampania]
      ,[CodigoRegion]
      ,[CodigoZona]
      ,[Monto]
      ,[AlcansoIncentivo]
  FROM [IncentivosMontoExigencia] WITH(NOLOCK)
  WHERE ([CodigoCampania] = @CodigoCampania OR [CodigoCampania] IS NULL OR [CodigoCampania] = '') 
		AND  ([CodigoRegion] = @CodigoRegion OR [CodigoRegion] IS NULL OR [CodigoRegion] = '')
		AND  ([CodigoZona] = @CodigoZona OR [CodigoZona] IS NULL OR [CodigoZona] = '')
  ORDER BY [CodigoCampania] DESC, [CodigoRegion] DESC, [CodigoZona] DESC
END
GO

USE BelcorpColombia
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'P' and id = OBJECT_ID('dbo.GetMontoExigenciaCaminoBrillante'))
	DROP PROC dbo.GetMontoExigenciaCaminoBrillante
GO
-- GetMontoExigenciaCaminoBrillante 3897, 201902, 201913, 4
CREATE PROC dbo.GetMontoExigenciaCaminoBrillante
(
	@CodigoCampania VARCHAR(8),
	@CodigoRegion VARCHAR(8),
	@CodigoZona VARCHAR(8)
)
AS
BEGIN
   SELECT TOP 1 [MontoID]
      ,[CodigoCampania]
      ,[CodigoRegion]
      ,[CodigoZona]
      ,[Monto]
      ,[AlcansoIncentivo]
  FROM [IncentivosMontoExigencia] WITH(NOLOCK)
  WHERE ([CodigoCampania] = @CodigoCampania OR [CodigoCampania] IS NULL OR [CodigoCampania] = '') 
		AND  ([CodigoRegion] = @CodigoRegion OR [CodigoRegion] IS NULL OR [CodigoRegion] = '')
		AND  ([CodigoZona] = @CodigoZona OR [CodigoZona] IS NULL OR [CodigoZona] = '')
  ORDER BY [CodigoCampania] DESC, [CodigoRegion] DESC, [CodigoZona] DESC
END
GO

USE BelcorpSalvador
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'P' and id = OBJECT_ID('dbo.GetMontoExigenciaCaminoBrillante'))
	DROP PROC dbo.GetMontoExigenciaCaminoBrillante
GO
-- GetMontoExigenciaCaminoBrillante 3897, 201902, 201913, 4
CREATE PROC dbo.GetMontoExigenciaCaminoBrillante
(
	@CodigoCampania VARCHAR(8),
	@CodigoRegion VARCHAR(8),
	@CodigoZona VARCHAR(8)
)
AS
BEGIN
   SELECT TOP 1 [MontoID]
      ,[CodigoCampania]
      ,[CodigoRegion]
      ,[CodigoZona]
      ,[Monto]
      ,[AlcansoIncentivo]
  FROM [IncentivosMontoExigencia] WITH(NOLOCK)
  WHERE ([CodigoCampania] = @CodigoCampania OR [CodigoCampania] IS NULL OR [CodigoCampania] = '') 
		AND  ([CodigoRegion] = @CodigoRegion OR [CodigoRegion] IS NULL OR [CodigoRegion] = '')
		AND  ([CodigoZona] = @CodigoZona OR [CodigoZona] IS NULL OR [CodigoZona] = '')
  ORDER BY [CodigoCampania] DESC, [CodigoRegion] DESC, [CodigoZona] DESC
END
GO

USE BelcorpPuertoRico
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'P' and id = OBJECT_ID('dbo.GetMontoExigenciaCaminoBrillante'))
	DROP PROC dbo.GetMontoExigenciaCaminoBrillante
GO
-- GetMontoExigenciaCaminoBrillante 3897, 201902, 201913, 4
CREATE PROC dbo.GetMontoExigenciaCaminoBrillante
(
	@CodigoCampania VARCHAR(8),
	@CodigoRegion VARCHAR(8),
	@CodigoZona VARCHAR(8)
)
AS
BEGIN
   SELECT TOP 1 [MontoID]
      ,[CodigoCampania]
      ,[CodigoRegion]
      ,[CodigoZona]
      ,[Monto]
      ,[AlcansoIncentivo]
  FROM [IncentivosMontoExigencia] WITH(NOLOCK)
  WHERE ([CodigoCampania] = @CodigoCampania OR [CodigoCampania] IS NULL OR [CodigoCampania] = '') 
		AND  ([CodigoRegion] = @CodigoRegion OR [CodigoRegion] IS NULL OR [CodigoRegion] = '')
		AND  ([CodigoZona] = @CodigoZona OR [CodigoZona] IS NULL OR [CodigoZona] = '')
  ORDER BY [CodigoCampania] DESC, [CodigoRegion] DESC, [CodigoZona] DESC
END
GO

USE BelcorpPanama
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'P' and id = OBJECT_ID('dbo.GetMontoExigenciaCaminoBrillante'))
	DROP PROC dbo.GetMontoExigenciaCaminoBrillante
GO
-- GetMontoExigenciaCaminoBrillante 3897, 201902, 201913, 4
CREATE PROC dbo.GetMontoExigenciaCaminoBrillante
(
	@CodigoCampania VARCHAR(8),
	@CodigoRegion VARCHAR(8),
	@CodigoZona VARCHAR(8)
)
AS
BEGIN
   SELECT TOP 1 [MontoID]
      ,[CodigoCampania]
      ,[CodigoRegion]
      ,[CodigoZona]
      ,[Monto]
      ,[AlcansoIncentivo]
  FROM [IncentivosMontoExigencia] WITH(NOLOCK)
  WHERE ([CodigoCampania] = @CodigoCampania OR [CodigoCampania] IS NULL OR [CodigoCampania] = '') 
		AND  ([CodigoRegion] = @CodigoRegion OR [CodigoRegion] IS NULL OR [CodigoRegion] = '')
		AND  ([CodigoZona] = @CodigoZona OR [CodigoZona] IS NULL OR [CodigoZona] = '')
  ORDER BY [CodigoCampania] DESC, [CodigoRegion] DESC, [CodigoZona] DESC
END
GO

USE BelcorpGuatemala
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'P' and id = OBJECT_ID('dbo.GetMontoExigenciaCaminoBrillante'))
	DROP PROC dbo.GetMontoExigenciaCaminoBrillante
GO
-- GetMontoExigenciaCaminoBrillante 3897, 201902, 201913, 4
CREATE PROC dbo.GetMontoExigenciaCaminoBrillante
(
	@CodigoCampania VARCHAR(8),
	@CodigoRegion VARCHAR(8),
	@CodigoZona VARCHAR(8)
)
AS
BEGIN
   SELECT TOP 1 [MontoID]
      ,[CodigoCampania]
      ,[CodigoRegion]
      ,[CodigoZona]
      ,[Monto]
      ,[AlcansoIncentivo]
  FROM [IncentivosMontoExigencia] WITH(NOLOCK)
  WHERE ([CodigoCampania] = @CodigoCampania OR [CodigoCampania] IS NULL OR [CodigoCampania] = '') 
		AND  ([CodigoRegion] = @CodigoRegion OR [CodigoRegion] IS NULL OR [CodigoRegion] = '')
		AND  ([CodigoZona] = @CodigoZona OR [CodigoZona] IS NULL OR [CodigoZona] = '')
  ORDER BY [CodigoCampania] DESC, [CodigoRegion] DESC, [CodigoZona] DESC
END
GO

USE BelcorpEcuador
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'P' and id = OBJECT_ID('dbo.GetMontoExigenciaCaminoBrillante'))
	DROP PROC dbo.GetMontoExigenciaCaminoBrillante
GO
-- GetMontoExigenciaCaminoBrillante 3897, 201902, 201913, 4
CREATE PROC dbo.GetMontoExigenciaCaminoBrillante
(
	@CodigoCampania VARCHAR(8),
	@CodigoRegion VARCHAR(8),
	@CodigoZona VARCHAR(8)
)
AS
BEGIN
   SELECT TOP 1 [MontoID]
      ,[CodigoCampania]
      ,[CodigoRegion]
      ,[CodigoZona]
      ,[Monto]
      ,[AlcansoIncentivo]
  FROM [IncentivosMontoExigencia] WITH(NOLOCK)
  WHERE ([CodigoCampania] = @CodigoCampania OR [CodigoCampania] IS NULL OR [CodigoCampania] = '') 
		AND  ([CodigoRegion] = @CodigoRegion OR [CodigoRegion] IS NULL OR [CodigoRegion] = '')
		AND  ([CodigoZona] = @CodigoZona OR [CodigoZona] IS NULL OR [CodigoZona] = '')
  ORDER BY [CodigoCampania] DESC, [CodigoRegion] DESC, [CodigoZona] DESC
END
GO


USE BelcorpDominicana
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'P' and id = OBJECT_ID('dbo.GetMontoExigenciaCaminoBrillante'))
	DROP PROC dbo.GetMontoExigenciaCaminoBrillante
GO
-- GetMontoExigenciaCaminoBrillante 3897, 201902, 201913, 4
CREATE PROC dbo.GetMontoExigenciaCaminoBrillante
(
	@CodigoCampania VARCHAR(8),
	@CodigoRegion VARCHAR(8),
	@CodigoZona VARCHAR(8)
)
AS
BEGIN
   SELECT TOP 1 [MontoID]
      ,[CodigoCampania]
      ,[CodigoRegion]
      ,[CodigoZona]
      ,[Monto]
      ,[AlcansoIncentivo]
  FROM [IncentivosMontoExigencia] WITH(NOLOCK)
  WHERE ([CodigoCampania] = @CodigoCampania OR [CodigoCampania] IS NULL OR [CodigoCampania] = '') 
		AND  ([CodigoRegion] = @CodigoRegion OR [CodigoRegion] IS NULL OR [CodigoRegion] = '')
		AND  ([CodigoZona] = @CodigoZona OR [CodigoZona] IS NULL OR [CodigoZona] = '')
  ORDER BY [CodigoCampania] DESC, [CodigoRegion] DESC, [CodigoZona] DESC
END
GO

USE BelcorpCostaRica
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'P' and id = OBJECT_ID('dbo.GetMontoExigenciaCaminoBrillante'))
	DROP PROC dbo.GetMontoExigenciaCaminoBrillante
GO
-- GetMontoExigenciaCaminoBrillante 3897, 201902, 201913, 4
CREATE PROC dbo.GetMontoExigenciaCaminoBrillante
(
	@CodigoCampania VARCHAR(8),
	@CodigoRegion VARCHAR(8),
	@CodigoZona VARCHAR(8)
)
AS
BEGIN
   SELECT TOP 1 [MontoID]
      ,[CodigoCampania]
      ,[CodigoRegion]
      ,[CodigoZona]
      ,[Monto]
      ,[AlcansoIncentivo]
  FROM [IncentivosMontoExigencia] WITH(NOLOCK)
  WHERE ([CodigoCampania] = @CodigoCampania OR [CodigoCampania] IS NULL OR [CodigoCampania] = '') 
		AND  ([CodigoRegion] = @CodigoRegion OR [CodigoRegion] IS NULL OR [CodigoRegion] = '')
		AND  ([CodigoZona] = @CodigoZona OR [CodigoZona] IS NULL OR [CodigoZona] = '')
  ORDER BY [CodigoCampania] DESC, [CodigoRegion] DESC, [CodigoZona] DESC
END
GO

USE BelcorpChile
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'P' and id = OBJECT_ID('dbo.GetMontoExigenciaCaminoBrillante'))
	DROP PROC dbo.GetMontoExigenciaCaminoBrillante
GO
-- GetMontoExigenciaCaminoBrillante 3897, 201902, 201913, 4
CREATE PROC dbo.GetMontoExigenciaCaminoBrillante
(
	@CodigoCampania VARCHAR(8),
	@CodigoRegion VARCHAR(8),
	@CodigoZona VARCHAR(8)
)
AS
BEGIN
   SELECT TOP 1 [MontoID]
      ,[CodigoCampania]
      ,[CodigoRegion]
      ,[CodigoZona]
      ,[Monto]
      ,[AlcansoIncentivo]
  FROM [IncentivosMontoExigencia] WITH(NOLOCK)
  WHERE ([CodigoCampania] = @CodigoCampania OR [CodigoCampania] IS NULL OR [CodigoCampania] = '') 
		AND  ([CodigoRegion] = @CodigoRegion OR [CodigoRegion] IS NULL OR [CodigoRegion] = '')
		AND  ([CodigoZona] = @CodigoZona OR [CodigoZona] IS NULL OR [CodigoZona] = '')
  ORDER BY [CodigoCampania] DESC, [CodigoRegion] DESC, [CodigoZona] DESC
END
GO

USE BelcorpBolivia
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'P' and id = OBJECT_ID('dbo.GetMontoExigenciaCaminoBrillante'))
	DROP PROC dbo.GetMontoExigenciaCaminoBrillante
GO
-- GetMontoExigenciaCaminoBrillante 3897, 201902, 201913, 4
CREATE PROC dbo.GetMontoExigenciaCaminoBrillante
(
	@CodigoCampania VARCHAR(8),
	@CodigoRegion VARCHAR(8),
	@CodigoZona VARCHAR(8)
)
AS
BEGIN
   SELECT TOP 1 [MontoID]
      ,[CodigoCampania]
      ,[CodigoRegion]
      ,[CodigoZona]
      ,[Monto]
      ,[AlcansoIncentivo]
  FROM [IncentivosMontoExigencia] WITH(NOLOCK)
  WHERE ([CodigoCampania] = @CodigoCampania OR [CodigoCampania] IS NULL OR [CodigoCampania] = '') 
		AND  ([CodigoRegion] = @CodigoRegion OR [CodigoRegion] IS NULL OR [CodigoRegion] = '')
		AND  ([CodigoZona] = @CodigoZona OR [CodigoZona] IS NULL OR [CodigoZona] = '')
  ORDER BY [CodigoCampania] DESC, [CodigoRegion] DESC, [CodigoZona] DESC
END
