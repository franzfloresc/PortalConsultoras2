
USE BelcorpBolivia
GO

CREATE PROCEDURE [dbo].[GetCantidadSolicitudesPedido_SB2]    
(
	@ConsultoraId BIGINT,
	@Campania INT
)
AS    
BEGIN    

DECLARE @RegionID INT, @ZonaID INT
DECLARE @FechaInicioFact DATETIME, @FechaFinFact DATETIME

SELECT @RegionID = RegionID, @ZonaID = ZonaID FROM ods.Consultora WHERE ConsultoraID = @ConsultoraId

SELECT TOP 1 @FechaInicioFact = FechaFinFacturacion 
FROM ods.Campania c INNER JOIN ods.Cronograma cc ON c.CampaniaID = cc.CampaniaID 
WHERE c.Codigo < @Campania AND RegionID = @RegionID AND ZonaID = @ZonaID
ORDER BY c.CampaniaID DESC

SELECT TOP 1 @FechaFinFact = FechaFinFacturacion 
FROM ods.Campania c INNER JOIN ods.Cronograma cc ON c.CampaniaID = cc.CampaniaID 
WHERE c.Codigo = @Campania AND RegionID = @RegionID AND ZonaID = @ZonaID

SET @FechaInicioFact = DATEADD(DAY,1,@FechaInicioFact)

SELECT   
	ISNULL(COUNT(sc.SolicitudClienteID),0) AS cantidad
FROM SolicitudCliente sc 
LEFT JOIN Marca m on sc.MarcaID = m.MarcaID
WHERE ConsultoraID = @ConsultoraId 
--AND ( sc.Estado IS NULL OR (LTRIM(RTRIM(sc.Estado)) IN ('A','R','C')))  
AND ( sc.Estado IS NULL )
AND 
(
	(
		ISNULL(sc.MarcaID,0) = 0
		AND Campania = @Campania
	)
	OR 
	(
		ISNULL(sc.MarcaID,0) != 0
		AND Campania = Campania
	)
)
AND 
(
	(
		ISNULL(FlagConsultora,0) = 1
		AND cast(sc.FechaSolicitud AS DATE) BETWEEN CAST(@FechaInicioFact AS DATE) AND CAST(@FechaFinFact AS DATE)
	)
	OR 
	(
		ISNULL(FlagConsultora,0) = 0
		AND sc.FechaSolicitud > DATEADD(DAY,-1,GETDATE())
	)
)
--ORDER BY ISNULL(FlagConsultora,0) DESC,
--ISNULL(sc.MarcaID,0) ASC,
--FechaSolicitud ASC,
--PrecioTotal DESC

END   

GO

/*end*/

USE BelcorpChile
GO

CREATE PROCEDURE [dbo].[GetCantidadSolicitudesPedido_SB2]    
(
	@ConsultoraId BIGINT,
	@Campania INT
)
AS    
BEGIN    

DECLARE @RegionID INT, @ZonaID INT
DECLARE @FechaInicioFact DATETIME, @FechaFinFact DATETIME

SELECT @RegionID = RegionID, @ZonaID = ZonaID FROM ods.Consultora WHERE ConsultoraID = @ConsultoraId

SELECT TOP 1 @FechaInicioFact = FechaFinFacturacion 
FROM ods.Campania c INNER JOIN ods.Cronograma cc ON c.CampaniaID = cc.CampaniaID 
WHERE c.Codigo < @Campania AND RegionID = @RegionID AND ZonaID = @ZonaID
ORDER BY c.CampaniaID DESC

SELECT TOP 1 @FechaFinFact = FechaFinFacturacion 
FROM ods.Campania c INNER JOIN ods.Cronograma cc ON c.CampaniaID = cc.CampaniaID 
WHERE c.Codigo = @Campania AND RegionID = @RegionID AND ZonaID = @ZonaID

SET @FechaInicioFact = DATEADD(DAY,1,@FechaInicioFact)

SELECT   
	ISNULL(COUNT(sc.SolicitudClienteID),0) AS cantidad
FROM SolicitudCliente sc 
LEFT JOIN Marca m on sc.MarcaID = m.MarcaID
WHERE ConsultoraID = @ConsultoraId 
--AND ( sc.Estado IS NULL OR (LTRIM(RTRIM(sc.Estado)) IN ('A','R','C')))  
AND ( sc.Estado IS NULL )
AND 
(
	(
		ISNULL(sc.MarcaID,0) = 0
		AND Campania = @Campania
	)
	OR 
	(
		ISNULL(sc.MarcaID,0) != 0
		AND Campania = Campania
	)
)
AND 
(
	(
		ISNULL(FlagConsultora,0) = 1
		AND cast(sc.FechaSolicitud AS DATE) BETWEEN CAST(@FechaInicioFact AS DATE) AND CAST(@FechaFinFact AS DATE)
	)
	OR 
	(
		ISNULL(FlagConsultora,0) = 0
		AND sc.FechaSolicitud > DATEADD(DAY,-1,GETDATE())
	)
)
--ORDER BY ISNULL(FlagConsultora,0) DESC,
--ISNULL(sc.MarcaID,0) ASC,
--FechaSolicitud ASC,
--PrecioTotal DESC

END   

GO

/*end*/

USE BelcorpCostaRica
GO

CREATE PROCEDURE [dbo].[GetCantidadSolicitudesPedido_SB2]    
(
	@ConsultoraId BIGINT,
	@Campania INT
)
AS    
BEGIN    

DECLARE @RegionID INT, @ZonaID INT
DECLARE @FechaInicioFact DATETIME, @FechaFinFact DATETIME

SELECT @RegionID = RegionID, @ZonaID = ZonaID FROM ods.Consultora WHERE ConsultoraID = @ConsultoraId

SELECT TOP 1 @FechaInicioFact = FechaFinFacturacion 
FROM ods.Campania c INNER JOIN ods.Cronograma cc ON c.CampaniaID = cc.CampaniaID 
WHERE c.Codigo < @Campania AND RegionID = @RegionID AND ZonaID = @ZonaID
ORDER BY c.CampaniaID DESC

SELECT TOP 1 @FechaFinFact = FechaFinFacturacion 
FROM ods.Campania c INNER JOIN ods.Cronograma cc ON c.CampaniaID = cc.CampaniaID 
WHERE c.Codigo = @Campania AND RegionID = @RegionID AND ZonaID = @ZonaID

SET @FechaInicioFact = DATEADD(DAY,1,@FechaInicioFact)

SELECT   
	ISNULL(COUNT(sc.SolicitudClienteID),0) AS cantidad
FROM SolicitudCliente sc 
LEFT JOIN Marca m on sc.MarcaID = m.MarcaID
WHERE ConsultoraID = @ConsultoraId 
--AND ( sc.Estado IS NULL OR (LTRIM(RTRIM(sc.Estado)) IN ('A','R','C')))  
AND ( sc.Estado IS NULL )
AND 
(
	(
		ISNULL(sc.MarcaID,0) = 0
		AND Campania = @Campania
	)
	OR 
	(
		ISNULL(sc.MarcaID,0) != 0
		AND Campania = Campania
	)
)
AND 
(
	(
		ISNULL(FlagConsultora,0) = 1
		AND cast(sc.FechaSolicitud AS DATE) BETWEEN CAST(@FechaInicioFact AS DATE) AND CAST(@FechaFinFact AS DATE)
	)
	OR 
	(
		ISNULL(FlagConsultora,0) = 0
		AND sc.FechaSolicitud > DATEADD(DAY,-1,GETDATE())
	)
)
--ORDER BY ISNULL(FlagConsultora,0) DESC,
--ISNULL(sc.MarcaID,0) ASC,
--FechaSolicitud ASC,
--PrecioTotal DESC

END   

GO

/*end*/

USE BelcorpDominicana
GO

CREATE PROCEDURE [dbo].[GetCantidadSolicitudesPedido_SB2]    
(
	@ConsultoraId BIGINT,
	@Campania INT
)
AS    
BEGIN    

DECLARE @RegionID INT, @ZonaID INT
DECLARE @FechaInicioFact DATETIME, @FechaFinFact DATETIME

SELECT @RegionID = RegionID, @ZonaID = ZonaID FROM ods.Consultora WHERE ConsultoraID = @ConsultoraId

SELECT TOP 1 @FechaInicioFact = FechaFinFacturacion 
FROM ods.Campania c INNER JOIN ods.Cronograma cc ON c.CampaniaID = cc.CampaniaID 
WHERE c.Codigo < @Campania AND RegionID = @RegionID AND ZonaID = @ZonaID
ORDER BY c.CampaniaID DESC

SELECT TOP 1 @FechaFinFact = FechaFinFacturacion 
FROM ods.Campania c INNER JOIN ods.Cronograma cc ON c.CampaniaID = cc.CampaniaID 
WHERE c.Codigo = @Campania AND RegionID = @RegionID AND ZonaID = @ZonaID

SET @FechaInicioFact = DATEADD(DAY,1,@FechaInicioFact)

SELECT   
	ISNULL(COUNT(sc.SolicitudClienteID),0) AS cantidad
FROM SolicitudCliente sc 
LEFT JOIN Marca m on sc.MarcaID = m.MarcaID
WHERE ConsultoraID = @ConsultoraId 
--AND ( sc.Estado IS NULL OR (LTRIM(RTRIM(sc.Estado)) IN ('A','R','C')))  
AND ( sc.Estado IS NULL )
AND 
(
	(
		ISNULL(sc.MarcaID,0) = 0
		AND Campania = @Campania
	)
	OR 
	(
		ISNULL(sc.MarcaID,0) != 0
		AND Campania = Campania
	)
)
AND 
(
	(
		ISNULL(FlagConsultora,0) = 1
		AND cast(sc.FechaSolicitud AS DATE) BETWEEN CAST(@FechaInicioFact AS DATE) AND CAST(@FechaFinFact AS DATE)
	)
	OR 
	(
		ISNULL(FlagConsultora,0) = 0
		AND sc.FechaSolicitud > DATEADD(DAY,-1,GETDATE())
	)
)
--ORDER BY ISNULL(FlagConsultora,0) DESC,
--ISNULL(sc.MarcaID,0) ASC,
--FechaSolicitud ASC,
--PrecioTotal DESC

END   

GO

/*end*/

USE BelcorpEcuador
GO

CREATE PROCEDURE [dbo].[GetCantidadSolicitudesPedido_SB2]    
(
	@ConsultoraId BIGINT,
	@Campania INT
)
AS    
BEGIN    

DECLARE @RegionID INT, @ZonaID INT
DECLARE @FechaInicioFact DATETIME, @FechaFinFact DATETIME

SELECT @RegionID = RegionID, @ZonaID = ZonaID FROM ods.Consultora WHERE ConsultoraID = @ConsultoraId

SELECT TOP 1 @FechaInicioFact = FechaFinFacturacion 
FROM ods.Campania c INNER JOIN ods.Cronograma cc ON c.CampaniaID = cc.CampaniaID 
WHERE c.Codigo < @Campania AND RegionID = @RegionID AND ZonaID = @ZonaID
ORDER BY c.CampaniaID DESC

SELECT TOP 1 @FechaFinFact = FechaFinFacturacion 
FROM ods.Campania c INNER JOIN ods.Cronograma cc ON c.CampaniaID = cc.CampaniaID 
WHERE c.Codigo = @Campania AND RegionID = @RegionID AND ZonaID = @ZonaID

SET @FechaInicioFact = DATEADD(DAY,1,@FechaInicioFact)

SELECT   
	ISNULL(COUNT(sc.SolicitudClienteID),0) AS cantidad
FROM SolicitudCliente sc 
LEFT JOIN Marca m on sc.MarcaID = m.MarcaID
WHERE ConsultoraID = @ConsultoraId 
--AND ( sc.Estado IS NULL OR (LTRIM(RTRIM(sc.Estado)) IN ('A','R','C')))  
AND ( sc.Estado IS NULL )
AND 
(
	(
		ISNULL(sc.MarcaID,0) = 0
		AND Campania = @Campania
	)
	OR 
	(
		ISNULL(sc.MarcaID,0) != 0
		AND Campania = Campania
	)
)
AND 
(
	(
		ISNULL(FlagConsultora,0) = 1
		AND cast(sc.FechaSolicitud AS DATE) BETWEEN CAST(@FechaInicioFact AS DATE) AND CAST(@FechaFinFact AS DATE)
	)
	OR 
	(
		ISNULL(FlagConsultora,0) = 0
		AND sc.FechaSolicitud > DATEADD(DAY,-1,GETDATE())
	)
)
--ORDER BY ISNULL(FlagConsultora,0) DESC,
--ISNULL(sc.MarcaID,0) ASC,
--FechaSolicitud ASC,
--PrecioTotal DESC

END   

GO

/*end*/

USE BelcorpGuatemala
GO

CREATE PROCEDURE [dbo].[GetCantidadSolicitudesPedido_SB2]    
(
	@ConsultoraId BIGINT,
	@Campania INT
)
AS    
BEGIN    

DECLARE @RegionID INT, @ZonaID INT
DECLARE @FechaInicioFact DATETIME, @FechaFinFact DATETIME

SELECT @RegionID = RegionID, @ZonaID = ZonaID FROM ods.Consultora WHERE ConsultoraID = @ConsultoraId

SELECT TOP 1 @FechaInicioFact = FechaFinFacturacion 
FROM ods.Campania c INNER JOIN ods.Cronograma cc ON c.CampaniaID = cc.CampaniaID 
WHERE c.Codigo < @Campania AND RegionID = @RegionID AND ZonaID = @ZonaID
ORDER BY c.CampaniaID DESC

SELECT TOP 1 @FechaFinFact = FechaFinFacturacion 
FROM ods.Campania c INNER JOIN ods.Cronograma cc ON c.CampaniaID = cc.CampaniaID 
WHERE c.Codigo = @Campania AND RegionID = @RegionID AND ZonaID = @ZonaID

SET @FechaInicioFact = DATEADD(DAY,1,@FechaInicioFact)

SELECT   
	ISNULL(COUNT(sc.SolicitudClienteID),0) AS cantidad
FROM SolicitudCliente sc 
LEFT JOIN Marca m on sc.MarcaID = m.MarcaID
WHERE ConsultoraID = @ConsultoraId 
--AND ( sc.Estado IS NULL OR (LTRIM(RTRIM(sc.Estado)) IN ('A','R','C')))  
AND ( sc.Estado IS NULL )
AND 
(
	(
		ISNULL(sc.MarcaID,0) = 0
		AND Campania = @Campania
	)
	OR 
	(
		ISNULL(sc.MarcaID,0) != 0
		AND Campania = Campania
	)
)
AND 
(
	(
		ISNULL(FlagConsultora,0) = 1
		AND cast(sc.FechaSolicitud AS DATE) BETWEEN CAST(@FechaInicioFact AS DATE) AND CAST(@FechaFinFact AS DATE)
	)
	OR 
	(
		ISNULL(FlagConsultora,0) = 0
		AND sc.FechaSolicitud > DATEADD(DAY,-1,GETDATE())
	)
)
--ORDER BY ISNULL(FlagConsultora,0) DESC,
--ISNULL(sc.MarcaID,0) ASC,
--FechaSolicitud ASC,
--PrecioTotal DESC

END   

GO

/*end*/

USE BelcorpPanama
GO

CREATE PROCEDURE [dbo].[GetCantidadSolicitudesPedido_SB2]    
(
	@ConsultoraId BIGINT,
	@Campania INT
)
AS    
BEGIN    

DECLARE @RegionID INT, @ZonaID INT
DECLARE @FechaInicioFact DATETIME, @FechaFinFact DATETIME

SELECT @RegionID = RegionID, @ZonaID = ZonaID FROM ods.Consultora WHERE ConsultoraID = @ConsultoraId

SELECT TOP 1 @FechaInicioFact = FechaFinFacturacion 
FROM ods.Campania c INNER JOIN ods.Cronograma cc ON c.CampaniaID = cc.CampaniaID 
WHERE c.Codigo < @Campania AND RegionID = @RegionID AND ZonaID = @ZonaID
ORDER BY c.CampaniaID DESC

SELECT TOP 1 @FechaFinFact = FechaFinFacturacion 
FROM ods.Campania c INNER JOIN ods.Cronograma cc ON c.CampaniaID = cc.CampaniaID 
WHERE c.Codigo = @Campania AND RegionID = @RegionID AND ZonaID = @ZonaID

SET @FechaInicioFact = DATEADD(DAY,1,@FechaInicioFact)

SELECT   
	ISNULL(COUNT(sc.SolicitudClienteID),0) AS cantidad
FROM SolicitudCliente sc 
LEFT JOIN Marca m on sc.MarcaID = m.MarcaID
WHERE ConsultoraID = @ConsultoraId 
--AND ( sc.Estado IS NULL OR (LTRIM(RTRIM(sc.Estado)) IN ('A','R','C')))  
AND ( sc.Estado IS NULL )
AND 
(
	(
		ISNULL(sc.MarcaID,0) = 0
		AND Campania = @Campania
	)
	OR 
	(
		ISNULL(sc.MarcaID,0) != 0
		AND Campania = Campania
	)
)
AND 
(
	(
		ISNULL(FlagConsultora,0) = 1
		AND cast(sc.FechaSolicitud AS DATE) BETWEEN CAST(@FechaInicioFact AS DATE) AND CAST(@FechaFinFact AS DATE)
	)
	OR 
	(
		ISNULL(FlagConsultora,0) = 0
		AND sc.FechaSolicitud > DATEADD(DAY,-1,GETDATE())
	)
)
--ORDER BY ISNULL(FlagConsultora,0) DESC,
--ISNULL(sc.MarcaID,0) ASC,
--FechaSolicitud ASC,
--PrecioTotal DESC

END   

GO

/*end*/

USE BelcorpPuertoRico
GO

CREATE PROCEDURE [dbo].[GetCantidadSolicitudesPedido_SB2]    
(
	@ConsultoraId BIGINT,
	@Campania INT
)
AS    
BEGIN    

DECLARE @RegionID INT, @ZonaID INT
DECLARE @FechaInicioFact DATETIME, @FechaFinFact DATETIME

SELECT @RegionID = RegionID, @ZonaID = ZonaID FROM ods.Consultora WHERE ConsultoraID = @ConsultoraId

SELECT TOP 1 @FechaInicioFact = FechaFinFacturacion 
FROM ods.Campania c INNER JOIN ods.Cronograma cc ON c.CampaniaID = cc.CampaniaID 
WHERE c.Codigo < @Campania AND RegionID = @RegionID AND ZonaID = @ZonaID
ORDER BY c.CampaniaID DESC

SELECT TOP 1 @FechaFinFact = FechaFinFacturacion 
FROM ods.Campania c INNER JOIN ods.Cronograma cc ON c.CampaniaID = cc.CampaniaID 
WHERE c.Codigo = @Campania AND RegionID = @RegionID AND ZonaID = @ZonaID

SET @FechaInicioFact = DATEADD(DAY,1,@FechaInicioFact)

SELECT   
	ISNULL(COUNT(sc.SolicitudClienteID),0) AS cantidad
FROM SolicitudCliente sc 
LEFT JOIN Marca m on sc.MarcaID = m.MarcaID
WHERE ConsultoraID = @ConsultoraId 
--AND ( sc.Estado IS NULL OR (LTRIM(RTRIM(sc.Estado)) IN ('A','R','C')))  
AND ( sc.Estado IS NULL )
AND 
(
	(
		ISNULL(sc.MarcaID,0) = 0
		AND Campania = @Campania
	)
	OR 
	(
		ISNULL(sc.MarcaID,0) != 0
		AND Campania = Campania
	)
)
AND 
(
	(
		ISNULL(FlagConsultora,0) = 1
		AND cast(sc.FechaSolicitud AS DATE) BETWEEN CAST(@FechaInicioFact AS DATE) AND CAST(@FechaFinFact AS DATE)
	)
	OR 
	(
		ISNULL(FlagConsultora,0) = 0
		AND sc.FechaSolicitud > DATEADD(DAY,-1,GETDATE())
	)
)
--ORDER BY ISNULL(FlagConsultora,0) DESC,
--ISNULL(sc.MarcaID,0) ASC,
--FechaSolicitud ASC,
--PrecioTotal DESC

END   

GO

/*end*/

USE BelcorpSalvador
GO

CREATE PROCEDURE [dbo].[GetCantidadSolicitudesPedido_SB2]    
(
	@ConsultoraId BIGINT,
	@Campania INT
)
AS    
BEGIN    

DECLARE @RegionID INT, @ZonaID INT
DECLARE @FechaInicioFact DATETIME, @FechaFinFact DATETIME

SELECT @RegionID = RegionID, @ZonaID = ZonaID FROM ods.Consultora WHERE ConsultoraID = @ConsultoraId

SELECT TOP 1 @FechaInicioFact = FechaFinFacturacion 
FROM ods.Campania c INNER JOIN ods.Cronograma cc ON c.CampaniaID = cc.CampaniaID 
WHERE c.Codigo < @Campania AND RegionID = @RegionID AND ZonaID = @ZonaID
ORDER BY c.CampaniaID DESC

SELECT TOP 1 @FechaFinFact = FechaFinFacturacion 
FROM ods.Campania c INNER JOIN ods.Cronograma cc ON c.CampaniaID = cc.CampaniaID 
WHERE c.Codigo = @Campania AND RegionID = @RegionID AND ZonaID = @ZonaID

SET @FechaInicioFact = DATEADD(DAY,1,@FechaInicioFact)

SELECT   
	ISNULL(COUNT(sc.SolicitudClienteID),0) AS cantidad
FROM SolicitudCliente sc 
LEFT JOIN Marca m on sc.MarcaID = m.MarcaID
WHERE ConsultoraID = @ConsultoraId 
--AND ( sc.Estado IS NULL OR (LTRIM(RTRIM(sc.Estado)) IN ('A','R','C')))  
AND ( sc.Estado IS NULL )
AND 
(
	(
		ISNULL(sc.MarcaID,0) = 0
		AND Campania = @Campania
	)
	OR 
	(
		ISNULL(sc.MarcaID,0) != 0
		AND Campania = Campania
	)
)
AND 
(
	(
		ISNULL(FlagConsultora,0) = 1
		AND cast(sc.FechaSolicitud AS DATE) BETWEEN CAST(@FechaInicioFact AS DATE) AND CAST(@FechaFinFact AS DATE)
	)
	OR 
	(
		ISNULL(FlagConsultora,0) = 0
		AND sc.FechaSolicitud > DATEADD(DAY,-1,GETDATE())
	)
)
--ORDER BY ISNULL(FlagConsultora,0) DESC,
--ISNULL(sc.MarcaID,0) ASC,
--FechaSolicitud ASC,
--PrecioTotal DESC

END   

GO

/*end*/

USE BelcorpVenezuela
GO

CREATE PROCEDURE [dbo].[GetCantidadSolicitudesPedido_SB2]    
(
	@ConsultoraId BIGINT,
	@Campania INT
)
AS    
BEGIN    

DECLARE @RegionID INT, @ZonaID INT
DECLARE @FechaInicioFact DATETIME, @FechaFinFact DATETIME

SELECT @RegionID = RegionID, @ZonaID = ZonaID FROM ods.Consultora WHERE ConsultoraID = @ConsultoraId

SELECT TOP 1 @FechaInicioFact = FechaFinFacturacion 
FROM ods.Campania c INNER JOIN ods.Cronograma cc ON c.CampaniaID = cc.CampaniaID 
WHERE c.Codigo < @Campania AND RegionID = @RegionID AND ZonaID = @ZonaID
ORDER BY c.CampaniaID DESC

SELECT TOP 1 @FechaFinFact = FechaFinFacturacion 
FROM ods.Campania c INNER JOIN ods.Cronograma cc ON c.CampaniaID = cc.CampaniaID 
WHERE c.Codigo = @Campania AND RegionID = @RegionID AND ZonaID = @ZonaID

SET @FechaInicioFact = DATEADD(DAY,1,@FechaInicioFact)

SELECT   
	ISNULL(COUNT(sc.SolicitudClienteID),0) AS cantidad
FROM SolicitudCliente sc 
LEFT JOIN Marca m on sc.MarcaID = m.MarcaID
WHERE ConsultoraID = @ConsultoraId 
--AND ( sc.Estado IS NULL OR (LTRIM(RTRIM(sc.Estado)) IN ('A','R','C')))  
AND ( sc.Estado IS NULL )
AND 
(
	(
		ISNULL(sc.MarcaID,0) = 0
		AND Campania = @Campania
	)
	OR 
	(
		ISNULL(sc.MarcaID,0) != 0
		AND Campania = Campania
	)
)
AND 
(
	(
		ISNULL(FlagConsultora,0) = 1
		AND cast(sc.FechaSolicitud AS DATE) BETWEEN CAST(@FechaInicioFact AS DATE) AND CAST(@FechaFinFact AS DATE)
	)
	OR 
	(
		ISNULL(FlagConsultora,0) = 0
		AND sc.FechaSolicitud > DATEADD(DAY,-1,GETDATE())
	)
)
--ORDER BY ISNULL(FlagConsultora,0) DESC,
--ISNULL(sc.MarcaID,0) ASC,
--FechaSolicitud ASC,
--PrecioTotal DESC

END   

GO
