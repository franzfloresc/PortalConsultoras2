
USE BelcorpColombia
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


USE BelcorpMexico
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

USE BelcorpPeru
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
