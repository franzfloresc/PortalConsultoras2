
USE [AppCatalogo]
GO

IF OBJECT_ID(N'dbo.fnSplitString') IS NOT NULL
BEGIN
    DROP FUNCTION dbo.fnSplitString
END

GO

CREATE FUNCTION [dbo].[fnSplitString] 
( 
    @string NVARCHAR(MAX), 
    @delimiter CHAR(1) 
) 
RETURNS @output TABLE(splitdata NVARCHAR(MAX) 
) 
BEGIN 
    DECLARE @start INT, @end INT 
    SELECT @start = 1, @end = CHARINDEX(@delimiter, @string) 
    WHILE @start < LEN(@string) + 1 BEGIN 
        IF @end = 0  
            SET @end = LEN(@string) + 1
       
        INSERT INTO @output (splitdata)  
        VALUES(SUBSTRING(@string, @start, @end - @start)) 
        SET @start = @end + 1 
        SET @end = CHARINDEX(@delimiter, @string, @start)
        
    END 
    RETURN 
END

GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetProductoCatalogoByListaCUV'))
BEGIN
    DROP PROCEDURE dbo.GetProductoCatalogoByListaCUV
END

GO

CREATE PROCEDURE [dbo].[GetProductoCatalogoByListaCUV]
(
	@CodigoIso VARCHAR(2),
	@CampaniaID INT,
	@ListaCUV VARCHAR(MAX)
)
AS

SELECT 
	pc.CodPais AS CodigoIso, 
	pc.IdMarca AS IdMarca, 
	pc.CodMarca AS CodigoMarca, 
	m.Nombre AS NombreMarca,
	pc.CodCampana AS CampaniaId, 
	pc.CUV AS Cuv, 
	pc.CodSAP AS CodigoSap, 
	DescripcionComercial, 
	ISNULL(pc.NombreComercial, '') AS NombreComercial, 
	ISNULL(pc.Descripcion, '') AS Descripcion, 
	ISNULL(pc.PrecioValorizado, 0) AS PrecioValorizado, 
	ISNULL(pc.PrecioCatalogo, 0) AS PrecioCatalogo, 
	ISNULL(pc.Volumen, '') AS Volumen, 
	ISNULL(pc.Imagen, '') AS Imagen,
	--CASE WHEN ISNULL(pc.ImagenBulk,'') <> '' AND ISNULL(pc.NombreBulk,'') <> '' THEN 1 ELSE 0 END EsMaquillaje
	pc.ImagenBulk,
	pc.NombreBulk
FROM ProductoCampana pc INNER JOIN Marca m ON pc.IdMarca = m.Id
WHERE pc.CodPais = @CodigoIso
AND pc.CodCampana = @CampaniaID 
AND pc.IdCatalogo > 0 
AND pc.IdMarca IN (1,2,3)
AND pc.CUV IN (SELECT splitdata FROM fnSplitString(@ListaCUV,','))

GO

