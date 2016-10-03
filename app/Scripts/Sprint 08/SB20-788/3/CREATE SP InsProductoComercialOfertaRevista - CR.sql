IF EXISTS(SELECT 1 
	      FROM sys.objects 
		  WHERE TYPE = 'P' 
		  AND NAME = 'InsProductoComercialOfertaRevista')
BEGIN
	DROP PROCEDURE [dbo].[InsProductoComercialOfertaRevista]
END
GO

CREATE PROCEDURE [dbo].[InsProductoComercialOfertaRevista]  
AS  
BEGIN
	DELETE FROM ProductoComercialOfertaRevista  
	  
	DECLARE @CampAnios TABLE  
	(  
		CampaniaID INT  
	)  
	  
	DECLARE @ProdCom TABLE  
	(  
		ProdId INT IDENTITY(1,1),  
		AnoCampania INT,  
		CUV VARCHAR(50),  
		CodigoProducto VARCHAR(12),  
		CodigoCatalago CHAR(6),  
		CodigoTipoOferta CHAR(6)  
	)  
	  
	INSERT INTO @CampAnios  
	SELECT DISTINCT CampaniaId  
		FROM ods.Cronograma (NOLOCK)    
		WHERE DATEPART(YEAR, fechainiciofacturacion) = DATEPART(YEAR, GETDATE())  
		AND DATEPART(MONTH, fechainiciofacturacion) = DATEPART(MONTH, GETDATE())  
	  
	DECLARE @CMax INT  
	SET @CMax = 0  
	SELECT @CMax = MAX(CampaniaID) FROM @CampAnios  
	  
	IF @CMax <> 0    
		BEGIN  
		INSERT INTO @CampAnios    
		SELECT TOP 1 CampaniaId     
			FROM ods.Cronograma (NOLOCK)    
			WHERE CampaniaId > @CMax    
		END  
	  
	DECLARE @CampMin INT  
	SET @CampMin = (SELECT min(CampaniaID) FROM @CampAnios)  
	  
	DECLARE @CampMax INT  
	SET @CampMax = (SELECT max(CampaniaID) FROM @CampAnios)  
	  
	WHILE(@CampMin <= @CampMax)  
		BEGIN    
		DELETE FROM @ProdCom    
		  
		INSERT INTO @ProdCom  
		SELECT AnoCampania, CUV, CodigoProducto, CodigoCatalago, CodigoTipoOferta  
			FROM ods.ProductoComercial (NOLOCK)    
			WHERE CampaniaId = @CampMin and IndicadorDigitable = 1  
		  
		DECLARE @ProdMin INT  
		SET @ProdMin = (SELECT MIN(ProdId) FROM @ProdCom)  
		  
		DECLARE @ProdMax INT    
		SET @ProdMax = (SELECT MAX(ProdId) FROM @ProdCom)    
		  
		WHILE(@ProdMin <= @ProdMax)    
			BEGIN    
			DECLARE @AnoCampania INT = 0
			DECLARE @CUV VARCHAR(50) = ''
			DECLARE @CodigoProducto VARCHAR(12) = ''
			DECLARE @CodigoCatalago CHAR(6) = ''
			DECLARE @CodigoTipoOferta CHAR(6) = ''
			  
			SELECT @AnoCampania = AnoCampania,  
					@CUV = CUV,  
					@CodigoProducto = CodigoProducto,  
					@CodigoCatalago = CodigoCatalago,  
					@CodigoTipoOferta = CodigoTipoOferta  
				FROM @ProdCom    
				WHERE ProdId = @ProdMin    
			  
			DECLARE @SAP VARCHAR(20) = ''
			DECLARE @OFERTA VARCHAR(20) = ''  
			  
			IF @CodigoCatalago <> '24'  
				BEGIN  
				SELECT TOP 1 @SAP = PC.CodigoProducto, @OFERTA = PC.CodigoTipoOferta  
					FROM @ProdCom PC  
					INNER JOIN (SELECT Codigo AS CTO, CAST(Descripcion AS INT) AS ORD   
								FROM TablaLogicaDatos  
								WHERE TablaLogicaID = 88) T ON T.CTO = PC.CodigoTipoOferta  
					WHERE PC.AnoCampania = @AnoCampania  
					AND PC.CUV <> @CUV  
					AND PC.CodigoProducto = @CodigoProducto  
					AND PC.CodigoCatalago = '24'
					ORDER BY T.ORD  
				END  
			ELSE  
				BEGIN  
				SET @SAP = ''  
				END  
			  
			IF @SAP <> ''  
				BEGIN  
				INSERT INTO ProductoComercialOfertaRevista
				VALUES(@AnoCampania, @CUV, @SAP, @OFERTA)
				END  
			SET @ProdMin = @ProdMin + 1  
		  
			END  
			  
		SET @CampMin = @CampMin + 1  
	  
		END
END
GO

EXEC InsProductoComercialOfertaRevista
GO