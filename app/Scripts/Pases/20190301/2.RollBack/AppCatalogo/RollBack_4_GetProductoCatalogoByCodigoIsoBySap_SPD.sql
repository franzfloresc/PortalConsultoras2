﻿USE [AppCatalogo]
GO
/****** Object:  StoredProcedure [dbo].[GetProductoCatalogoByCodigoIsoBySap]    Script Date: 18/02/2019 03:02:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--select * from productocampana where codpais = 'CO' and codsap = '210085867' and idcatalogo > 0

ALTER PROCEDURE [dbo].[GetProductoCatalogoByCodigoIsoBySap]
(
	@CodigoIso CHAR(2),
	@CampaniaID INT,
	@CodigoSap VARCHAR(MAX),
	@NroCampania INT
)
AS
/*
exec [GetProductoCatalogoByCodigoIsoBySap] 'CL',201905,'200091290|200091288|200091289',6
*/

DECLARE @tableCodigoSap TABLE (
	CodigoSap VARCHAR(20)
)

INSERT INTO @tableCodigoSap 
SELECT splitdata FROM fnSplitString(@CodigoSap,'|')

DECLARE @campInicio INT, @campFin INT
SELECT @campInicio = MIN(CC.Codigo), @campFin = MAX(CC.Codigo)
FROM (
	SELECT TOP (@NroCampania) Codigo 
	FROM Campana 
	WHERE CodPais = @CodigoIso
	AND Codigo <= @CampaniaID
	ORDER BY Codigo DESC
) AS CC

DECLARE @tableProductos TABLE (
	CodigoIso CHAR(3),
	IdMarca INT,
	CodigoMarca CHAR(1),
	NombreMarca VARCHAR(50),
	CampaniaId INT,
	Cuv VARCHAR(10),
	CodigoSap VARCHAR(15),
	DescripcionComercial VARCHAR(100),
	NombreComercial VARCHAR(200),
	Descripcion VARCHAR(400),
	PrecioValorizado DECIMAL(10,2),
	PrecioCatalogo DECIMAL(10,2),
	Volumen VARCHAR(50),
	Imagen VARCHAR(50),
	ImagenBulk VARCHAR(50),
	NombreBulk VARCHAR(50)
)

INSERT INTO @tableProductos
SELECT 
	pc.CodPais AS CodigoIso,
	pc.IdMarca, 
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
	ISNULL(pc.ImagenBulk, '') AS ImagenBulk,
	ISNULL(pc.NombreBulk, '') AS NombreBulk
FROM (SELECT CodSap, max(Id) Id
        FROM ProductoCampana
       WHERE CodPais = @CodigoIso
         AND IdMarca IN (1, 2, 3)
         AND (CodCampana >= @campInicio AND CodCampana <= @campFin)
         AND CodSap IN (SELECT CodigoSap from @tableCodigoSap)
         AND IdCatalogo > 0
       GROUP BY CodSap) b
INNER JOIN ProductoCampana pc ON b.Id = pc.Id
INNER JOIN Marca m ON pc.IdMarca = m.Id

SELECT * FROM @tableProductos


