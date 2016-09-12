ALTER FUNCTION FiltrarTallaColorLiquidacion_2
( @CUV VARCHAR(20), 
  @CampaniaID INT 
) 
	RETURNS VARCHAR(8000)
AS
BEGIN
	DECLARE @tblTallaColor TABLE(ID INT IDENTITY(1, 1), CUV VARCHAR(20), DESCRIPCIONCUV VARCHAR(200), DESCRIPCIONTALLACOLOR VARCHAR(200), PrecioUnitario numeric(15, 2))	

	INSERT INTO @tblTallaColor
	SELECT TCC.CUV, 
	CASE
		WHEN ISNULL(TCC.DescripcionCUV, '') = '' THEN PC.Descripcion
		ELSE TCC.DescripcionCUV 
	END,
	'Seleccione',	
	pc.PrecioUnitario
	FROM TallaColorLiquidacion TCC 
	INNER JOIN ods.ProductoComercial PC ON PC.CUV = TCC.CUV
	INNER JOIN ods.Campania	CA ON CA.CampaniaID = PC.CampaniaID  AND TCC.CampaniaID = CA.Codigo
	WHERE 
			 TCC.CampaniaID = @CampaniaID
		 AND TCC.CUV = @CUV

	INSERT INTO @tblTallaColor
	SELECT TCC.CUV, 
	CASE
		WHEN ISNULL(TCC.DescripcionCUV, '') = '' THEN PC.Descripcion
		ELSE TCC.DescripcionCUV 
	END, 
	TCC.Descripcion,	
	pc.PrecioUnitario
	FROM TallaColorLiquidacion TCC 
	INNER JOIN ods.ProductoComercial PC ON PC.CUV = TCC.CUV
	INNER JOIN ods.Campania	CA ON CA.CampaniaID = PC.CampaniaID  AND TCC.CampaniaID = CA.Codigo
	WHERE 
			TCC.CampaniaID = @CampaniaID
		 AND TCC.CUV = @CUV
		 AND ISNULL(TCC.Descripcion, '') <> ''

	INSERT INTO @tblTallaColor
	SELECT TCC.CUV, 
	CASE
		WHEN ISNULL(TCC.DescripcionCUV, '') = '' THEN PC.Descripcion
		ELSE TCC.DescripcionCUV 
	END, 
	TCC.DESCRIPCION, pc.PrecioUnitario 
	FROM TallaColorLiquidacion TCC 
	INNER JOIN ods.ProductoComercial PC ON PC.CUV = TCC.CUV
	INNER JOIN ods.Campania	CA ON CA.CampaniaID = PC.CampaniaID  AND TCC.CampaniaID = CA.Codigo
	INNER JOIN OfertaProducto OP ON OP.CUV = PC.CUV AND OP.CampaniaID = PC.CampaniaID
	WHERE 
			TCC.CampaniaID = @CampaniaID
		 AND CUVPadre = @CUV
		 AND TCC.CUV <> @CUV
		 AND OP.Stock > 0

	DECLARE @i INT, @total INT, @strTallaColor VARCHAR(MAX), @cuvv VARCHAR(20), @descripcionCUVv VARCHAR(200), @descripcionTallaColorv VARCHAR(200), @PrecioUnitario numeric(15, 2), @tipo VARCHAR(20)

	SET @strTallaColor = ''
	SET @tipo = (SELECT Tipo FROM TallaColorLiquidacion WHERE CUV = @CUV AND CampaniaID = @CampaniaID)

	SET @i = 1
	SET @total =(SELECT MAX(ID) FROM @tblTallaColor)

	IF @total > 1
	BEGIN
		SET @strTallaColor = @strTallaColor + @tipo + '^'
	END

	WHILE @i <= @total
	BEGIN
			SET @cuvv = (SELECT cuv FROM @tblTallaColor WHERE ID = @i)
			SET @descripcionCUVv = (SELECT DESCRIPCIONCUV FROM @tblTallaColor WHERE ID = @i)
			SET @descripcionTallaColorv = (SELECT DESCRIPCIONTALLACOLOR FROM @tblTallaColor WHERE ID = @i)
			SET @PrecioUnitario = (SELECT PrecioUnitario FROM @tblTallaColor WHERE ID = @i)
			SET @strTallaColor = @strTallaColor + @cuvv + '|' + @descripcionCUVv + '|' + @descripcionTallaColorv + '|' + CONVERT(VARCHAR(20), @PrecioUnitario) + '</>'
			
		SET @i = @i + 1
	END

	RETURN ISNULL(@strTallaColor, '')
END

