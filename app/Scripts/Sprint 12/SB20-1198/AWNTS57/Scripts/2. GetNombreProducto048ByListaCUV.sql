
USE BelcorpBolivia
GO

CREATE PROCEDURE dbo.GetNombreProducto048ByListaCUV
@CampaniaID INT,
@ListaCUV VARCHAR(MAX)
AS

BEGIN

--DECLARE @NombreProducto VARCHAR(200) = ''

SELECT pc.CUV AS Cuv, COALESCE(pd.Descripcion, pc.Descripcion) AS NombreComercial
FROM ods.ProductoComercial pc
LEFT JOIN ProductoDescripcion pd ON
	pc.AnoCampania = pd.CampaniaID 
	AND pc.CUV = pd.CUV
WHERE 
	pc.AnoCampania = @CampaniaID
	AND pc.CUV IN (SELECT splitdata FROM dbo.fnSplitString(@ListaCUV,'|'))

--SELECT @NombreProducto AS NombreProducto

END

GO

/*end*/


USE BelcorpChile
GO

CREATE PROCEDURE dbo.GetNombreProducto048ByListaCUV
@CampaniaID INT,
@ListaCUV VARCHAR(MAX)
AS

BEGIN

--DECLARE @NombreProducto VARCHAR(200) = ''

SELECT pc.CUV AS Cuv, COALESCE(pd.Descripcion, pc.Descripcion) AS NombreComercial
FROM ods.ProductoComercial pc
LEFT JOIN ProductoDescripcion pd ON
	pc.AnoCampania = pd.CampaniaID 
	AND pc.CUV = pd.CUV
WHERE 
	pc.AnoCampania = @CampaniaID
	AND pc.CUV IN (SELECT splitdata FROM dbo.fnSplitString(@ListaCUV,'|'))

--SELECT @NombreProducto AS NombreProducto

END

GO

/*end*/

USE BelcorpCostaRica
GO

CREATE PROCEDURE dbo.GetNombreProducto048ByListaCUV
@CampaniaID INT,
@ListaCUV VARCHAR(MAX)
AS

BEGIN

--DECLARE @NombreProducto VARCHAR(200) = ''

SELECT pc.CUV AS Cuv, COALESCE(pd.Descripcion, pc.Descripcion) AS NombreComercial
FROM ods.ProductoComercial pc
LEFT JOIN ProductoDescripcion pd ON
	pc.AnoCampania = pd.CampaniaID 
	AND pc.CUV = pd.CUV
WHERE 
	pc.AnoCampania = @CampaniaID
	AND pc.CUV IN (SELECT splitdata FROM dbo.fnSplitString(@ListaCUV,'|'))

--SELECT @NombreProducto AS NombreProducto

END

GO

/*end*/

USE BelcorpDominicana
GO

CREATE PROCEDURE dbo.GetNombreProducto048ByListaCUV
@CampaniaID INT,
@ListaCUV VARCHAR(MAX)
AS

BEGIN

--DECLARE @NombreProducto VARCHAR(200) = ''

SELECT pc.CUV AS Cuv, COALESCE(pd.Descripcion, pc.Descripcion) AS NombreComercial
FROM ods.ProductoComercial pc
LEFT JOIN ProductoDescripcion pd ON
	pc.AnoCampania = pd.CampaniaID 
	AND pc.CUV = pd.CUV
WHERE 
	pc.AnoCampania = @CampaniaID
	AND pc.CUV IN (SELECT splitdata FROM dbo.fnSplitString(@ListaCUV,'|'))

--SELECT @NombreProducto AS NombreProducto

END

GO

/*end*/

USE BelcorpEcuador
GO

CREATE PROCEDURE dbo.GetNombreProducto048ByListaCUV
@CampaniaID INT,
@ListaCUV VARCHAR(MAX)
AS

BEGIN

--DECLARE @NombreProducto VARCHAR(200) = ''

SELECT pc.CUV AS Cuv, COALESCE(pd.Descripcion, pc.Descripcion) AS NombreComercial
FROM ods.ProductoComercial pc
LEFT JOIN ProductoDescripcion pd ON
	pc.AnoCampania = pd.CampaniaID 
	AND pc.CUV = pd.CUV
WHERE 
	pc.AnoCampania = @CampaniaID
	AND pc.CUV IN (SELECT splitdata FROM dbo.fnSplitString(@ListaCUV,'|'))

--SELECT @NombreProducto AS NombreProducto

END

GO

/*end*/

USE BelcorpGuatemala
GO

CREATE PROCEDURE dbo.GetNombreProducto048ByListaCUV
@CampaniaID INT,
@ListaCUV VARCHAR(MAX)
AS

BEGIN

--DECLARE @NombreProducto VARCHAR(200) = ''

SELECT pc.CUV AS Cuv, COALESCE(pd.Descripcion, pc.Descripcion) AS NombreComercial
FROM ods.ProductoComercial pc
LEFT JOIN ProductoDescripcion pd ON
	pc.AnoCampania = pd.CampaniaID 
	AND pc.CUV = pd.CUV
WHERE 
	pc.AnoCampania = @CampaniaID
	AND pc.CUV IN (SELECT splitdata FROM dbo.fnSplitString(@ListaCUV,'|'))

--SELECT @NombreProducto AS NombreProducto

END

GO

/*end*/

USE BelcorpPanama
GO

CREATE PROCEDURE dbo.GetNombreProducto048ByListaCUV
@CampaniaID INT,
@ListaCUV VARCHAR(MAX)
AS

BEGIN

--DECLARE @NombreProducto VARCHAR(200) = ''

SELECT pc.CUV AS Cuv, COALESCE(pd.Descripcion, pc.Descripcion) AS NombreComercial
FROM ods.ProductoComercial pc
LEFT JOIN ProductoDescripcion pd ON
	pc.AnoCampania = pd.CampaniaID 
	AND pc.CUV = pd.CUV
WHERE 
	pc.AnoCampania = @CampaniaID
	AND pc.CUV IN (SELECT splitdata FROM dbo.fnSplitString(@ListaCUV,'|'))

--SELECT @NombreProducto AS NombreProducto

END

GO

/*end*/

USE BelcorpPuertoRico
GO

CREATE PROCEDURE dbo.GetNombreProducto048ByListaCUV
@CampaniaID INT,
@ListaCUV VARCHAR(MAX)
AS

BEGIN

--DECLARE @NombreProducto VARCHAR(200) = ''

SELECT pc.CUV AS Cuv, COALESCE(pd.Descripcion, pc.Descripcion) AS NombreComercial
FROM ods.ProductoComercial pc
LEFT JOIN ProductoDescripcion pd ON
	pc.AnoCampania = pd.CampaniaID 
	AND pc.CUV = pd.CUV
WHERE 
	pc.AnoCampania = @CampaniaID
	AND pc.CUV IN (SELECT splitdata FROM dbo.fnSplitString(@ListaCUV,'|'))

--SELECT @NombreProducto AS NombreProducto

END

GO

/*end*/

USE BelcorpSalvador
GO

CREATE PROCEDURE dbo.GetNombreProducto048ByListaCUV
@CampaniaID INT,
@ListaCUV VARCHAR(MAX)
AS

BEGIN

--DECLARE @NombreProducto VARCHAR(200) = ''

SELECT pc.CUV AS Cuv, COALESCE(pd.Descripcion, pc.Descripcion) AS NombreComercial
FROM ods.ProductoComercial pc
LEFT JOIN ProductoDescripcion pd ON
	pc.AnoCampania = pd.CampaniaID 
	AND pc.CUV = pd.CUV
WHERE 
	pc.AnoCampania = @CampaniaID
	AND pc.CUV IN (SELECT splitdata FROM dbo.fnSplitString(@ListaCUV,'|'))

--SELECT @NombreProducto AS NombreProducto

END

GO

/*end*/

USE BelcorpVenezuela
GO

CREATE PROCEDURE dbo.GetNombreProducto048ByListaCUV
@CampaniaID INT,
@ListaCUV VARCHAR(MAX)
AS

BEGIN

--DECLARE @NombreProducto VARCHAR(200) = ''

SELECT pc.CUV AS Cuv, COALESCE(pd.Descripcion, pc.Descripcion) AS NombreComercial
FROM ods.ProductoComercial pc
LEFT JOIN ProductoDescripcion pd ON
	pc.AnoCampania = pd.CampaniaID 
	AND pc.CUV = pd.CUV
WHERE 
	pc.AnoCampania = @CampaniaID
	AND pc.CUV IN (SELECT splitdata FROM dbo.fnSplitString(@ListaCUV,'|'))

--SELECT @NombreProducto AS NombreProducto

END
