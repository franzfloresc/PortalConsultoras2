
USE AppCatalogo
GO

ALTER PROCEDURE [dbo].[ObtenerProductosBySap]
AS
BEGIN
	SELECT 
		pc.CodPais AS CodigoIso,
		B.Campania AS Campania,
		pc.CodSAP AS CodigoSap, 
		ISNULL(pc.NombreComercial, '') AS NombreComercial, 
		ISNULL(pc.Descripcion, '') AS Descripcion, 
		ISNULL(pc.Volumen, '') AS Volumen, 
		ISNULL(pc.Imagen, '') AS Imagen,
		ISNULL(pc.ImagenBulk, '') AS ImagenBulk,
		ISNULL(pc.NombreBulk, '') AS NombreBulk,
		pc.CodCampana AS CampaniaApp
	FROM (SELECT PC.CodSap, MAX(PC.Id) AS Id, PCT.Campania
		FROM ProductoCampana PC
		INNER JOIN ProductoCampanaTemporalSB  PCT ON PC.CodSAP = PCT.CodigoSap 
			AND PC.CodPais = PCT.IsoPais AND PC.CodCampana BETWEEN PCT.CampaniaIncio AND PCT.Campania
		WHERE  PC.IdMarca IN (1, 2, 3) AND PC.IdCatalogo > 0
		GROUP BY PC.CodSap,PCT.Campania) B
	INNER JOIN ProductoCampana pc ON B.Id = pc.Id
	INNER JOIN Marca m ON pc.IdMarca = m.Id
END
GO