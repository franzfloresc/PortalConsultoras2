
ALTER PROCEDURE [dbo].[GetProductoCatalogoByCodigoIsoBySap]
(
	@CodigoIso CHAR(2),
	@CampaniaID INT,
	@CodigoSap VARCHAR(MAX),
	@NroCampania INT
)
AS
/*
exec [GetProductoCatalogoByCodigoIsoBySap2] 'PE',201707,'200084964|210056392|200085153|200085013|200083954',6
*/
BEGIN

DECLARE @tableCodigoSap TABLE (
	CodigoSap VARCHAR(20)
)

INSERT INTO @tableCodigoSap 
SELECT splitdata FROM fnSplitString(@CodigoSap,'|')

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
	@CodigoIso AS CodigoIso,
	pc.IdMarca, 
	pc.CodMarca AS CodigoMarca, 
	m.Nombre AS NombreMarca,
	@CampaniaID AS CampaniaId,
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
FROM ProductoCampana pc
INNER JOIN Marca m ON pc.IdMarca = m.Id
WHERE pc.CodPais = @CodigoIso
AND pc.CodCampana = @CampaniaID 
AND pc.IdCatalogo > 0 
AND pc.IdMarca IN (1,2,3)
AND pc.CodSAP IN (SELECT CodigoSap from @tableCodigoSap)

IF EXISTS (SELECT 1 FROM @tableProductos pc WHERE ISNULL(Imagen,'') = '')
BEGIN

	DECLARE @campInicio INT, @campFin INT
	SELECT @campInicio = MIN(CC.Codigo), @campFin = MAX(CC.Codigo)
	FROM (
		SELECT TOP (@NroCampania) Codigo 
		FROM Campana 
		WHERE CodPais = @CodigoIso
		AND Codigo < @CampaniaID
		ORDER BY Codigo DESC
	) AS CC

	SELECT TOP 1
		CodSAP AS CodigoSAP, 
		Imagen,
		CodCampana
	INTO #tmp1
	FROM ProductoCampana
	WHERE CodPais = @CodigoIso
	AND CodCampana BETWEEN @campInicio AND @campFin
	AND IdCatalogo > 0 
	AND IdMarca IN (1,2,3)
	AND ISNULL(Imagen,'') <> ''
	AND CodSAP IN (SELECT CodigoSAP FROM @tableProductos WHERE ISNULL(Imagen,'') = '')
	ORDER BY CodCampana  DESC
	
	UPDATE a
	SET a.Imagen = b.Imagen
	FROM @tableProductos a 
	INNER JOIN #tmp1 b ON a.CodigoSAP = b.CodigoSAP 
	WHERE ISNULL(a.Imagen,'') = ''

	DROP TABLE #tmp1

	IF EXISTS (SELECT 1 FROM @tableProductos pc WHERE ISNULL(Imagen,'') = '')
	BEGIN
		DECLARE @campSigue INT

		SELECT TOP 1 @campSigue = Codigo 
		FROM Campana 
		WHERE CodPais = @CodigoIso
		AND Codigo > @CampaniaID 
		ORDER BY Codigo

		UPDATE a
		SET a.Imagen = b.Imagen
		FROM @tableProductos a 
		INNER JOIN ProductoCampana b ON a.CodigoSAP = b.CodSAP AND b.CodCampana = @campSigue
		WHERE b.CodPais = @CodigoIso
		--AND b.CodCampana = @campSigue
		AND b.IdCatalogo > 0 
		AND b.IdMarca IN (1,2,3)
		AND ISNULL(b.Imagen,'') <> ''
		AND ISNULl(a.Imagen,'') = ''

	END
END

SELECT * FROM @tableProductos

END

