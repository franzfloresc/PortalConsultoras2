USE BelcorpPeru
GO

IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ActualizarPrecioEstrategia') AND type IN ( N'P', N'PC' ) ) 
DROP PROCEDURE dbo.ActualizarPrecioEstrategia
GO

CREATE PROCEDURE ActualizarPrecioEstrategia
AS
BEGIN 
	UPDATE Estrategia 
		SET Precio2 = ET.Precio,
		Ganancia = ET.Ganancia,
		Precio = ET.Precio + ET.Ganancia
	FROM Estrategia E
		INNER JOIN EstrategiaPrecioTemporal ET  
		ON E.CampaniaID = ET.Campania AND E.CUV2 = ET.Cuv
END
GO

USE BelcorpMexico
GO

IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ActualizarPrecioEstrategia') AND type IN ( N'P', N'PC' ) ) 
DROP PROCEDURE dbo.ActualizarPrecioEstrategia
GO

CREATE PROCEDURE ActualizarPrecioEstrategia
AS
BEGIN 
	UPDATE Estrategia 
		SET Precio2 = ET.Precio,
		Ganancia = ET.Ganancia,
		Precio = ET.Precio + ET.Ganancia
	FROM Estrategia E
		INNER JOIN EstrategiaPrecioTemporal ET  
		ON E.CampaniaID = ET.Campania AND E.CUV2 = ET.Cuv
END
GO

USE BelcorpColombia
GO

IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ActualizarPrecioEstrategia') AND type IN ( N'P', N'PC' ) ) 
DROP PROCEDURE dbo.ActualizarPrecioEstrategia
GO

CREATE PROCEDURE ActualizarPrecioEstrategia
AS
BEGIN 
	UPDATE Estrategia 
		SET Precio2 = ET.Precio,
		Ganancia = ET.Ganancia,
		Precio = ET.Precio + ET.Ganancia
	FROM Estrategia E
		INNER JOIN EstrategiaPrecioTemporal ET  
		ON E.CampaniaID = ET.Campania AND E.CUV2 = ET.Cuv
END
GO

USE BelcorpVenezuela
GO

IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ActualizarPrecioEstrategia') AND type IN ( N'P', N'PC' ) ) 
DROP PROCEDURE dbo.ActualizarPrecioEstrategia
GO

CREATE PROCEDURE ActualizarPrecioEstrategia
AS
BEGIN 
	UPDATE Estrategia 
		SET Precio2 = ET.Precio,
		Ganancia = ET.Ganancia,
		Precio = ET.Precio + ET.Ganancia
	FROM Estrategia E
		INNER JOIN EstrategiaPrecioTemporal ET  
		ON E.CampaniaID = ET.Campania AND E.CUV2 = ET.Cuv
END
GO

USE BelcorpSalvador
GO

IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ActualizarPrecioEstrategia') AND type IN ( N'P', N'PC' ) ) 
DROP PROCEDURE dbo.ActualizarPrecioEstrategia
GO

CREATE PROCEDURE ActualizarPrecioEstrategia
AS
BEGIN 
	UPDATE Estrategia 
		SET Precio2 = ET.Precio,
		Ganancia = ET.Ganancia,
		Precio = ET.Precio + ET.Ganancia
	FROM Estrategia E
		INNER JOIN EstrategiaPrecioTemporal ET  
		ON E.CampaniaID = ET.Campania AND E.CUV2 = ET.Cuv
END
GO

USE BelcorpPuertoRico
GO

IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ActualizarPrecioEstrategia') AND type IN ( N'P', N'PC' ) ) 
DROP PROCEDURE dbo.ActualizarPrecioEstrategia
GO

CREATE PROCEDURE ActualizarPrecioEstrategia
AS
BEGIN 
	UPDATE Estrategia 
		SET Precio2 = ET.Precio,
		Ganancia = ET.Ganancia,
		Precio = ET.Precio + ET.Ganancia
	FROM Estrategia E
		INNER JOIN EstrategiaPrecioTemporal ET  
		ON E.CampaniaID = ET.Campania AND E.CUV2 = ET.Cuv
END
GO

USE BelcorpPanama
GO

IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ActualizarPrecioEstrategia') AND type IN ( N'P', N'PC' ) ) 
DROP PROCEDURE dbo.ActualizarPrecioEstrategia
GO

CREATE PROCEDURE ActualizarPrecioEstrategia
AS
BEGIN 
	UPDATE Estrategia 
		SET Precio2 = ET.Precio,
		Ganancia = ET.Ganancia,
		Precio = ET.Precio + ET.Ganancia
	FROM Estrategia E
		INNER JOIN EstrategiaPrecioTemporal ET  
		ON E.CampaniaID = ET.Campania AND E.CUV2 = ET.Cuv
END
GO

USE BelcorpGuatemala
GO

IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ActualizarPrecioEstrategia') AND type IN ( N'P', N'PC' ) ) 
DROP PROCEDURE dbo.ActualizarPrecioEstrategia
GO

CREATE PROCEDURE ActualizarPrecioEstrategia
AS
BEGIN 
	UPDATE Estrategia 
		SET Precio2 = ET.Precio,
		Ganancia = ET.Ganancia,
		Precio = ET.Precio + ET.Ganancia
	FROM Estrategia E
		INNER JOIN EstrategiaPrecioTemporal ET  
		ON E.CampaniaID = ET.Campania AND E.CUV2 = ET.Cuv
END
GO

USE BelcorpEcuador
GO

IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ActualizarPrecioEstrategia') AND type IN ( N'P', N'PC' ) ) 
DROP PROCEDURE dbo.ActualizarPrecioEstrategia
GO

CREATE PROCEDURE ActualizarPrecioEstrategia
AS
BEGIN 
	UPDATE Estrategia 
		SET Precio2 = ET.Precio,
		Ganancia = ET.Ganancia,
		Precio = ET.Precio + ET.Ganancia
	FROM Estrategia E
		INNER JOIN EstrategiaPrecioTemporal ET  
		ON E.CampaniaID = ET.Campania AND E.CUV2 = ET.Cuv
END
GO

USE BelcorpDominicana
GO

IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ActualizarPrecioEstrategia') AND type IN ( N'P', N'PC' ) ) 
DROP PROCEDURE dbo.ActualizarPrecioEstrategia
GO

CREATE PROCEDURE ActualizarPrecioEstrategia
AS
BEGIN 
	UPDATE Estrategia 
		SET Precio2 = ET.Precio,
		Ganancia = ET.Ganancia,
		Precio = ET.Precio + ET.Ganancia
	FROM Estrategia E
		INNER JOIN EstrategiaPrecioTemporal ET  
		ON E.CampaniaID = ET.Campania AND E.CUV2 = ET.Cuv
END
GO

USE BelcorpCostaRica
GO

IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ActualizarPrecioEstrategia') AND type IN ( N'P', N'PC' ) ) 
DROP PROCEDURE dbo.ActualizarPrecioEstrategia
GO

CREATE PROCEDURE ActualizarPrecioEstrategia
AS
BEGIN 
	UPDATE Estrategia 
		SET Precio2 = ET.Precio,
		Ganancia = ET.Ganancia,
		Precio = ET.Precio + ET.Ganancia
	FROM Estrategia E
		INNER JOIN EstrategiaPrecioTemporal ET  
		ON E.CampaniaID = ET.Campania AND E.CUV2 = ET.Cuv
END
GO

USE BelcorpChile
GO

IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ActualizarPrecioEstrategia') AND type IN ( N'P', N'PC' ) ) 
DROP PROCEDURE dbo.ActualizarPrecioEstrategia
GO

CREATE PROCEDURE ActualizarPrecioEstrategia
AS
BEGIN 
	UPDATE Estrategia 
		SET Precio2 = ET.Precio,
		Ganancia = ET.Ganancia,
		Precio = ET.Precio + ET.Ganancia
	FROM Estrategia E
		INNER JOIN EstrategiaPrecioTemporal ET  
		ON E.CampaniaID = ET.Campania AND E.CUV2 = ET.Cuv
END
GO

USE BelcorpBolivia
GO

IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ActualizarPrecioEstrategia') AND type IN ( N'P', N'PC' ) ) 
DROP PROCEDURE dbo.ActualizarPrecioEstrategia
GO

CREATE PROCEDURE ActualizarPrecioEstrategia
AS
BEGIN 
	UPDATE Estrategia 
		SET Precio2 = ET.Precio,
		Ganancia = ET.Ganancia,
		Precio = ET.Precio + ET.Ganancia
	FROM Estrategia E
		INNER JOIN EstrategiaPrecioTemporal ET  
		ON E.CampaniaID = ET.Campania AND E.CUV2 = ET.Cuv
END
GO

