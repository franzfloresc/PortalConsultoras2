USE [AppCatalogo]
GO
/****** Object:  StoredProcedure [dbo].[GetProductoCatalogoByCodigoIsoBySap]    Script Date: 14/01/2019 3:03:40 PM ******/
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
	@NroCampania INT,
	@NroCampaniaAdelante INT=2
)
AS
/*
exec [GetProductoCatalogoByCodigoIsoBySap] 'PE',201707,'200084964|210056392|200085153|200085013|200083954',6,5
*/

DECLARE @tableCodigoSap TABLE (
	CodigoSap VARCHAR(20)
)
DECLARE @campanaSubsiguiente INT ---ADDED FROM SOPORTEPD-53
INSERT INTO @tableCodigoSap 
SELECT splitdata FROM fnSplitString(@CodigoSap,'|')

SET  @NroCampania = @NroCampania + @NroCampaniaAdelante ---ADDED FROM SOPORTEPD-53

select @campanaSubsiguiente=max(codigo) from  ---ADDED FROM SOPORTEPD-53
(select top (@NroCampaniaAdelante) codigo  from campana where codigo>@CampaniaID and CodPais=@CodigoIso ORDER BY codigo ASC) as cct
DECLARE @campInicio INT, @campFin INT

SELECT @campInicio = MIN(CC.Codigo), @campFin = MAX(CC.Codigo)
FROM (
	SELECT TOP (@NroCampania) Codigo 
	FROM Campana 
	WHERE CodPais = @CodigoIso
	AND Codigo <= @campanaSubsiguiente
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