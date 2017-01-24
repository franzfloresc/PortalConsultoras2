
USE BelcorpBolivia
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetListBrothersByCUV'))
BEGIN
    DROP PROCEDURE dbo.GetListBrothersByCUV
END

GO

CREATE PROCEDURE [dbo].[GetListBrothersByCUV]
(
	@CodCampania INT,
	@CUV VARCHAR(10)
)

AS

DECLARE @CodigoGenerico VARCHAR(30), 
	@CodigoTipoOferta VARCHAR(6)

SELECT TOP 1
	@CodigoGenerico = sp.CodigoGenerico, 
	@CodigoTipoOferta = pc.CodigoTipoOferta 
FROM ods.ProductoComercial pc
INNER JOIN ods.SAP_PRODUCTO sp ON sp.CodigoSap = pc.CodigoProducto
WHERE pc.CampaniaID = (SELECT CampaniaID FROM ods.Campania WHERE Codigo = @CodCampania)
AND pc.CUV = @CUV

IF (ISNULL(@CodigoGenerico,'') <> '')
BEGIN
	SELECT pc.CUV, pc.Descripcion 
	FROM ods.ProductoComercial pc
	INNER JOIN ods.SAP_PRODUCTO sp ON sp.CodigoSap = pc.CodigoProducto 
		AND sp.CodigoGenerico = @CodigoGenerico
	WHERE pc.CampaniaID = (SELECT CampaniaID FROM ods.Campania WHERE Codigo = @CodCampania)
	AND pc.CodigoTipoOferta = @CodigoTipoOferta
END


GO
/*end*/

USE BelcorpChile
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetListBrothersByCUV'))
BEGIN
    DROP PROCEDURE dbo.GetListBrothersByCUV
END

GO

CREATE PROCEDURE [dbo].[GetListBrothersByCUV]
(
	@CodCampania INT,
	@CUV VARCHAR(10)
)

AS

DECLARE @CodigoGenerico VARCHAR(30), 
	@CodigoTipoOferta VARCHAR(6)

SELECT TOP 1
	@CodigoGenerico = sp.CodigoGenerico, 
	@CodigoTipoOferta = pc.CodigoTipoOferta 
FROM ods.ProductoComercial pc
INNER JOIN ods.SAP_PRODUCTO sp ON sp.CodigoSap = pc.CodigoProducto
WHERE pc.CampaniaID = (SELECT CampaniaID FROM ods.Campania WHERE Codigo = @CodCampania)
AND pc.CUV = @CUV

IF (ISNULL(@CodigoGenerico,'') <> '')
BEGIN
	SELECT pc.CUV, pc.Descripcion 
	FROM ods.ProductoComercial pc
	INNER JOIN ods.SAP_PRODUCTO sp ON sp.CodigoSap = pc.CodigoProducto 
		AND sp.CodigoGenerico = @CodigoGenerico
	WHERE pc.CampaniaID = (SELECT CampaniaID FROM ods.Campania WHERE Codigo = @CodCampania)
	AND pc.CodigoTipoOferta = @CodigoTipoOferta
END


GO
/*end*/

USE BelcorpColombia
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetListBrothersByCUV'))
BEGIN
    DROP PROCEDURE dbo.GetListBrothersByCUV
END

GO

CREATE PROCEDURE [dbo].[GetListBrothersByCUV]
(
	@CodCampania INT,
	@CUV VARCHAR(10)
)

AS

DECLARE @CodigoGenerico VARCHAR(30), 
	@CodigoTipoOferta VARCHAR(6)

SELECT TOP 1
	@CodigoGenerico = sp.CodigoGenerico, 
	@CodigoTipoOferta = pc.CodigoTipoOferta 
FROM ods.ProductoComercial pc
INNER JOIN ods.SAP_PRODUCTO sp ON sp.CodigoSap = pc.CodigoProducto
WHERE pc.CampaniaID = (SELECT CampaniaID FROM ods.Campania WHERE Codigo = @CodCampania)
AND pc.CUV = @CUV

IF (ISNULL(@CodigoGenerico,'') <> '')
BEGIN
	SELECT pc.CUV, pc.Descripcion 
	FROM ods.ProductoComercial pc
	INNER JOIN ods.SAP_PRODUCTO sp ON sp.CodigoSap = pc.CodigoProducto 
		AND sp.CodigoGenerico = @CodigoGenerico
	WHERE pc.CampaniaID = (SELECT CampaniaID FROM ods.Campania WHERE Codigo = @CodCampania)
	AND pc.CodigoTipoOferta = @CodigoTipoOferta
END


GO
/*end*/

USE BelcorpCostaRica
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetListBrothersByCUV'))
BEGIN
    DROP PROCEDURE dbo.GetListBrothersByCUV
END

GO

CREATE PROCEDURE [dbo].[GetListBrothersByCUV]
(
	@CodCampania INT,
	@CUV VARCHAR(10)
)

AS

DECLARE @CodigoGenerico VARCHAR(30), 
	@CodigoTipoOferta VARCHAR(6)

SELECT TOP 1
	@CodigoGenerico = sp.CodigoGenerico, 
	@CodigoTipoOferta = pc.CodigoTipoOferta 
FROM ods.ProductoComercial pc
INNER JOIN ods.SAP_PRODUCTO sp ON sp.CodigoSap = pc.CodigoProducto
WHERE pc.CampaniaID = (SELECT CampaniaID FROM ods.Campania WHERE Codigo = @CodCampania)
AND pc.CUV = @CUV

IF (ISNULL(@CodigoGenerico,'') <> '')
BEGIN
	SELECT pc.CUV, pc.Descripcion 
	FROM ods.ProductoComercial pc
	INNER JOIN ods.SAP_PRODUCTO sp ON sp.CodigoSap = pc.CodigoProducto 
		AND sp.CodigoGenerico = @CodigoGenerico
	WHERE pc.CampaniaID = (SELECT CampaniaID FROM ods.Campania WHERE Codigo = @CodCampania)
	AND pc.CodigoTipoOferta = @CodigoTipoOferta
END


GO
/*end*/

USE BelcorpDominicana
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetListBrothersByCUV'))
BEGIN
    DROP PROCEDURE dbo.GetListBrothersByCUV
END

GO

CREATE PROCEDURE [dbo].[GetListBrothersByCUV]
(
	@CodCampania INT,
	@CUV VARCHAR(10)
)

AS

DECLARE @CodigoGenerico VARCHAR(30), 
	@CodigoTipoOferta VARCHAR(6)

SELECT TOP 1
	@CodigoGenerico = sp.CodigoGenerico, 
	@CodigoTipoOferta = pc.CodigoTipoOferta 
FROM ods.ProductoComercial pc
INNER JOIN ods.SAP_PRODUCTO sp ON sp.CodigoSap = pc.CodigoProducto
WHERE pc.CampaniaID = (SELECT CampaniaID FROM ods.Campania WHERE Codigo = @CodCampania)
AND pc.CUV = @CUV

IF (ISNULL(@CodigoGenerico,'') <> '')
BEGIN
	SELECT pc.CUV, pc.Descripcion 
	FROM ods.ProductoComercial pc
	INNER JOIN ods.SAP_PRODUCTO sp ON sp.CodigoSap = pc.CodigoProducto 
		AND sp.CodigoGenerico = @CodigoGenerico
	WHERE pc.CampaniaID = (SELECT CampaniaID FROM ods.Campania WHERE Codigo = @CodCampania)
	AND pc.CodigoTipoOferta = @CodigoTipoOferta
END


GO
/*end*/

USE BelcorpEcuador
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetListBrothersByCUV'))
BEGIN
    DROP PROCEDURE dbo.GetListBrothersByCUV
END

GO

CREATE PROCEDURE [dbo].[GetListBrothersByCUV]
(
	@CodCampania INT,
	@CUV VARCHAR(10)
)

AS

DECLARE @CodigoGenerico VARCHAR(30), 
	@CodigoTipoOferta VARCHAR(6)

SELECT TOP 1
	@CodigoGenerico = sp.CodigoGenerico, 
	@CodigoTipoOferta = pc.CodigoTipoOferta 
FROM ods.ProductoComercial pc
INNER JOIN ods.SAP_PRODUCTO sp ON sp.CodigoSap = pc.CodigoProducto
WHERE pc.CampaniaID = (SELECT CampaniaID FROM ods.Campania WHERE Codigo = @CodCampania)
AND pc.CUV = @CUV

IF (ISNULL(@CodigoGenerico,'') <> '')
BEGIN
	SELECT pc.CUV, pc.Descripcion 
	FROM ods.ProductoComercial pc
	INNER JOIN ods.SAP_PRODUCTO sp ON sp.CodigoSap = pc.CodigoProducto 
		AND sp.CodigoGenerico = @CodigoGenerico
	WHERE pc.CampaniaID = (SELECT CampaniaID FROM ods.Campania WHERE Codigo = @CodCampania)
	AND pc.CodigoTipoOferta = @CodigoTipoOferta
END


GO
/*end*/

USE BelcorpGuatemala
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetListBrothersByCUV'))
BEGIN
    DROP PROCEDURE dbo.GetListBrothersByCUV
END

GO

CREATE PROCEDURE [dbo].[GetListBrothersByCUV]
(
	@CodCampania INT,
	@CUV VARCHAR(10)
)

AS

DECLARE @CodigoGenerico VARCHAR(30), 
	@CodigoTipoOferta VARCHAR(6)

SELECT TOP 1
	@CodigoGenerico = sp.CodigoGenerico, 
	@CodigoTipoOferta = pc.CodigoTipoOferta 
FROM ods.ProductoComercial pc
INNER JOIN ods.SAP_PRODUCTO sp ON sp.CodigoSap = pc.CodigoProducto
WHERE pc.CampaniaID = (SELECT CampaniaID FROM ods.Campania WHERE Codigo = @CodCampania)
AND pc.CUV = @CUV

IF (ISNULL(@CodigoGenerico,'') <> '')
BEGIN
	SELECT pc.CUV, pc.Descripcion 
	FROM ods.ProductoComercial pc
	INNER JOIN ods.SAP_PRODUCTO sp ON sp.CodigoSap = pc.CodigoProducto 
		AND sp.CodigoGenerico = @CodigoGenerico
	WHERE pc.CampaniaID = (SELECT CampaniaID FROM ods.Campania WHERE Codigo = @CodCampania)
	AND pc.CodigoTipoOferta = @CodigoTipoOferta
END


GO
/*end*/

USE BelcorpMexico
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetListBrothersByCUV'))
BEGIN
    DROP PROCEDURE dbo.GetListBrothersByCUV
END

GO

CREATE PROCEDURE [dbo].[GetListBrothersByCUV]
(
	@CodCampania INT,
	@CUV VARCHAR(10)
)

AS

DECLARE @CodigoGenerico VARCHAR(30), 
	@CodigoTipoOferta VARCHAR(6)

SELECT TOP 1
	@CodigoGenerico = sp.CodigoGenerico, 
	@CodigoTipoOferta = pc.CodigoTipoOferta 
FROM ods.ProductoComercial pc
INNER JOIN ods.SAP_PRODUCTO sp ON sp.CodigoSap = pc.CodigoProducto
WHERE pc.CampaniaID = (SELECT CampaniaID FROM ods.Campania WHERE Codigo = @CodCampania)
AND pc.CUV = @CUV

IF (ISNULL(@CodigoGenerico,'') <> '')
BEGIN
	SELECT pc.CUV, pc.Descripcion 
	FROM ods.ProductoComercial pc
	INNER JOIN ods.SAP_PRODUCTO sp ON sp.CodigoSap = pc.CodigoProducto 
		AND sp.CodigoGenerico = @CodigoGenerico
	WHERE pc.CampaniaID = (SELECT CampaniaID FROM ods.Campania WHERE Codigo = @CodCampania)
	AND pc.CodigoTipoOferta = @CodigoTipoOferta
END


GO
/*end*/

USE BelcorpPanama
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetListBrothersByCUV'))
BEGIN
    DROP PROCEDURE dbo.GetListBrothersByCUV
END

GO

CREATE PROCEDURE [dbo].[GetListBrothersByCUV]
(
	@CodCampania INT,
	@CUV VARCHAR(10)
)

AS

DECLARE @CodigoGenerico VARCHAR(30), 
	@CodigoTipoOferta VARCHAR(6)

SELECT TOP 1
	@CodigoGenerico = sp.CodigoGenerico, 
	@CodigoTipoOferta = pc.CodigoTipoOferta 
FROM ods.ProductoComercial pc
INNER JOIN ods.SAP_PRODUCTO sp ON sp.CodigoSap = pc.CodigoProducto
WHERE pc.CampaniaID = (SELECT CampaniaID FROM ods.Campania WHERE Codigo = @CodCampania)
AND pc.CUV = @CUV

IF (ISNULL(@CodigoGenerico,'') <> '')
BEGIN
	SELECT pc.CUV, pc.Descripcion 
	FROM ods.ProductoComercial pc
	INNER JOIN ods.SAP_PRODUCTO sp ON sp.CodigoSap = pc.CodigoProducto 
		AND sp.CodigoGenerico = @CodigoGenerico
	WHERE pc.CampaniaID = (SELECT CampaniaID FROM ods.Campania WHERE Codigo = @CodCampania)
	AND pc.CodigoTipoOferta = @CodigoTipoOferta
END


GO
/*end*/

USE BelcorpPeru
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetListBrothersByCUV'))
BEGIN
    DROP PROCEDURE dbo.GetListBrothersByCUV
END

GO

CREATE PROCEDURE [dbo].[GetListBrothersByCUV]
(
	@CodCampania INT,
	@CUV VARCHAR(10)
)

AS

DECLARE @CodigoGenerico VARCHAR(30), 
	@CodigoTipoOferta VARCHAR(6)

SELECT TOP 1
	@CodigoGenerico = sp.CodigoGenerico, 
	@CodigoTipoOferta = pc.CodigoTipoOferta 
FROM ods.ProductoComercial pc
INNER JOIN ods.SAP_PRODUCTO sp ON sp.CodigoSap = pc.CodigoProducto
WHERE pc.CampaniaID = (SELECT CampaniaID FROM ods.Campania WHERE Codigo = @CodCampania)
AND pc.CUV = @CUV

IF (ISNULL(@CodigoGenerico,'') <> '')
BEGIN
	SELECT pc.CUV, pc.Descripcion 
	FROM ods.ProductoComercial pc
	INNER JOIN ods.SAP_PRODUCTO sp ON sp.CodigoSap = pc.CodigoProducto 
		AND sp.CodigoGenerico = @CodigoGenerico
	WHERE pc.CampaniaID = (SELECT CampaniaID FROM ods.Campania WHERE Codigo = @CodCampania)
	AND pc.CodigoTipoOferta = @CodigoTipoOferta
END


GO
/*end*/

USE BelcorpPuertoRico
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetListBrothersByCUV'))
BEGIN
    DROP PROCEDURE dbo.GetListBrothersByCUV
END

GO

CREATE PROCEDURE [dbo].[GetListBrothersByCUV]
(
	@CodCampania INT,
	@CUV VARCHAR(10)
)

AS

DECLARE @CodigoGenerico VARCHAR(30), 
	@CodigoTipoOferta VARCHAR(6)

SELECT TOP 1
	@CodigoGenerico = sp.CodigoGenerico, 
	@CodigoTipoOferta = pc.CodigoTipoOferta 
FROM ods.ProductoComercial pc
INNER JOIN ods.SAP_PRODUCTO sp ON sp.CodigoSap = pc.CodigoProducto
WHERE pc.CampaniaID = (SELECT CampaniaID FROM ods.Campania WHERE Codigo = @CodCampania)
AND pc.CUV = @CUV

IF (ISNULL(@CodigoGenerico,'') <> '')
BEGIN
	SELECT pc.CUV, pc.Descripcion 
	FROM ods.ProductoComercial pc
	INNER JOIN ods.SAP_PRODUCTO sp ON sp.CodigoSap = pc.CodigoProducto 
		AND sp.CodigoGenerico = @CodigoGenerico
	WHERE pc.CampaniaID = (SELECT CampaniaID FROM ods.Campania WHERE Codigo = @CodCampania)
	AND pc.CodigoTipoOferta = @CodigoTipoOferta
END


GO
/*end*/

USE BelcorpSalvador
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetListBrothersByCUV'))
BEGIN
    DROP PROCEDURE dbo.GetListBrothersByCUV
END

GO

CREATE PROCEDURE [dbo].[GetListBrothersByCUV]
(
	@CodCampania INT,
	@CUV VARCHAR(10)
)

AS

DECLARE @CodigoGenerico VARCHAR(30), 
	@CodigoTipoOferta VARCHAR(6)

SELECT TOP 1
	@CodigoGenerico = sp.CodigoGenerico, 
	@CodigoTipoOferta = pc.CodigoTipoOferta 
FROM ods.ProductoComercial pc
INNER JOIN ods.SAP_PRODUCTO sp ON sp.CodigoSap = pc.CodigoProducto
WHERE pc.CampaniaID = (SELECT CampaniaID FROM ods.Campania WHERE Codigo = @CodCampania)
AND pc.CUV = @CUV

IF (ISNULL(@CodigoGenerico,'') <> '')
BEGIN
	SELECT pc.CUV, pc.Descripcion 
	FROM ods.ProductoComercial pc
	INNER JOIN ods.SAP_PRODUCTO sp ON sp.CodigoSap = pc.CodigoProducto 
		AND sp.CodigoGenerico = @CodigoGenerico
	WHERE pc.CampaniaID = (SELECT CampaniaID FROM ods.Campania WHERE Codigo = @CodCampania)
	AND pc.CodigoTipoOferta = @CodigoTipoOferta
END


GO
/*end*/

USE BelcorpVenezuela
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetListBrothersByCUV'))
BEGIN
    DROP PROCEDURE dbo.GetListBrothersByCUV
END

GO

CREATE PROCEDURE [dbo].[GetListBrothersByCUV]
(
	@CodCampania INT,
	@CUV VARCHAR(10)
)

AS

DECLARE @CodigoGenerico VARCHAR(30), 
	@CodigoTipoOferta VARCHAR(6)

SELECT TOP 1
	@CodigoGenerico = sp.CodigoGenerico, 
	@CodigoTipoOferta = pc.CodigoTipoOferta 
FROM ods.ProductoComercial pc
INNER JOIN ods.SAP_PRODUCTO sp ON sp.CodigoSap = pc.CodigoProducto
WHERE pc.CampaniaID = (SELECT CampaniaID FROM ods.Campania WHERE Codigo = @CodCampania)
AND pc.CUV = @CUV

IF (ISNULL(@CodigoGenerico,'') <> '')
BEGIN
	SELECT pc.CUV, pc.Descripcion 
	FROM ods.ProductoComercial pc
	INNER JOIN ods.SAP_PRODUCTO sp ON sp.CodigoSap = pc.CodigoProducto 
		AND sp.CodigoGenerico = @CodigoGenerico
	WHERE pc.CampaniaID = (SELECT CampaniaID FROM ods.Campania WHERE Codigo = @CodCampania)
	AND pc.CodigoTipoOferta = @CodigoTipoOferta
END


GO

