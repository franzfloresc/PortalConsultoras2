USE [BelcorpBolivia]
GO

ALTER PROCEDURE [dbo].[Usp_CantidadPedidoWebDetalleSeguimiento]
(
@Codigo VARCHAR(25),
@CampaniaID INT
)
AS

BEGIN

DECLARE @CampaniaIDca INT
SET @CampaniaIDca = (SELECT CampaniaID FROM ODS.Campania where Codigo = @CampaniaID)

SELECT COUNT(P.PedidoSeguimientoID) AS Cantidad
FROM PedidoWebDetalleSeguimiento AS P
INNER JOIN ODS.Consultora AS C ON P.ConsultoraID = C.ConsultoraID
JOIN ODS.ProductoComercial AS PC ON P.CUV = PC.CUV
LEFT JOIN ODS.Marca AS M ON P.MarcaID = M.MarcaID
WHERE C.Codigo = @Codigo AND P.CampaniaId = @CampaniaID
AND PC.CampaniaID = @CampaniaIDca

END;

GO

USE [BelcorpChile]
GO

ALTER PROCEDURE [dbo].[Usp_CantidadPedidoWebDetalleSeguimiento]
(
@Codigo VARCHAR(25),
@CampaniaID INT
)
AS

BEGIN

DECLARE @CampaniaIDca INT
SET @CampaniaIDca = (SELECT CampaniaID FROM ODS.Campania where Codigo = @CampaniaID)

SELECT COUNT(P.PedidoSeguimientoID) AS Cantidad
FROM PedidoWebDetalleSeguimiento AS P
INNER JOIN ODS.Consultora AS C ON P.ConsultoraID = C.ConsultoraID
JOIN ODS.ProductoComercial AS PC ON P.CUV = PC.CUV
LEFT JOIN ODS.Marca AS M ON P.MarcaID = M.MarcaID
WHERE C.Codigo = @Codigo AND P.CampaniaId = @CampaniaID
AND PC.CampaniaID = @CampaniaIDca

END;

GO

USE [BelcorpColombia]
GO

ALTER PROCEDURE [dbo].[Usp_CantidadPedidoWebDetalleSeguimiento]
(
@Codigo VARCHAR(25),
@CampaniaID INT
)
AS

BEGIN

DECLARE @CampaniaIDca INT
SET @CampaniaIDca = (SELECT CampaniaID FROM ODS.Campania where Codigo = @CampaniaID)

SELECT COUNT(P.PedidoSeguimientoID) AS Cantidad
FROM PedidoWebDetalleSeguimiento AS P
INNER JOIN ODS.Consultora AS C ON P.ConsultoraID = C.ConsultoraID
JOIN ODS.ProductoComercial AS PC ON P.CUV = PC.CUV
LEFT JOIN ODS.Marca AS M ON P.MarcaID = M.MarcaID
WHERE C.Codigo = @Codigo AND P.CampaniaId = @CampaniaID
AND PC.CampaniaID = @CampaniaIDca

END;

GO

USE [BelcorpCostaRica]
GO

ALTER PROCEDURE [dbo].[Usp_CantidadPedidoWebDetalleSeguimiento]
(
@Codigo VARCHAR(25),
@CampaniaID INT
)
AS

BEGIN

DECLARE @CampaniaIDca INT
SET @CampaniaIDca = (SELECT CampaniaID FROM ODS.Campania where Codigo = @CampaniaID)

SELECT COUNT(P.PedidoSeguimientoID) AS Cantidad
FROM PedidoWebDetalleSeguimiento AS P
INNER JOIN ODS.Consultora AS C ON P.ConsultoraID = C.ConsultoraID
JOIN ODS.ProductoComercial AS PC ON P.CUV = PC.CUV
LEFT JOIN ODS.Marca AS M ON P.MarcaID = M.MarcaID
WHERE C.Codigo = @Codigo AND P.CampaniaId = @CampaniaID
AND PC.CampaniaID = @CampaniaIDca

END;

GO

USE [BelcorpDominicana]
GO

ALTER PROCEDURE [dbo].[Usp_CantidadPedidoWebDetalleSeguimiento]
(
@Codigo VARCHAR(25),
@CampaniaID INT
)
AS

BEGIN

DECLARE @CampaniaIDca INT
SET @CampaniaIDca = (SELECT CampaniaID FROM ODS.Campania where Codigo = @CampaniaID)

SELECT COUNT(P.PedidoSeguimientoID) AS Cantidad
FROM PedidoWebDetalleSeguimiento AS P
INNER JOIN ODS.Consultora AS C ON P.ConsultoraID = C.ConsultoraID
JOIN ODS.ProductoComercial AS PC ON P.CUV = PC.CUV
LEFT JOIN ODS.Marca AS M ON P.MarcaID = M.MarcaID
WHERE C.Codigo = @Codigo AND P.CampaniaId = @CampaniaID
AND PC.CampaniaID = @CampaniaIDca

END;

GO

USE [BelcorpEcuador]
GO

ALTER PROCEDURE [dbo].[Usp_CantidadPedidoWebDetalleSeguimiento]
(
@Codigo VARCHAR(25),
@CampaniaID INT
)
AS

BEGIN

DECLARE @CampaniaIDca INT
SET @CampaniaIDca = (SELECT CampaniaID FROM ODS.Campania where Codigo = @CampaniaID)

SELECT COUNT(P.PedidoSeguimientoID) AS Cantidad
FROM PedidoWebDetalleSeguimiento AS P
INNER JOIN ODS.Consultora AS C ON P.ConsultoraID = C.ConsultoraID
JOIN ODS.ProductoComercial AS PC ON P.CUV = PC.CUV
LEFT JOIN ODS.Marca AS M ON P.MarcaID = M.MarcaID
WHERE C.Codigo = @Codigo AND P.CampaniaId = @CampaniaID
AND PC.CampaniaID = @CampaniaIDca

END;

GO

USE [BelcorpGuatemala]
GO

ALTER PROCEDURE [dbo].[Usp_CantidadPedidoWebDetalleSeguimiento]
(
@Codigo VARCHAR(25),
@CampaniaID INT
)
AS

BEGIN

DECLARE @CampaniaIDca INT
SET @CampaniaIDca = (SELECT CampaniaID FROM ODS.Campania where Codigo = @CampaniaID)

SELECT COUNT(P.PedidoSeguimientoID) AS Cantidad
FROM PedidoWebDetalleSeguimiento AS P
INNER JOIN ODS.Consultora AS C ON P.ConsultoraID = C.ConsultoraID
JOIN ODS.ProductoComercial AS PC ON P.CUV = PC.CUV
LEFT JOIN ODS.Marca AS M ON P.MarcaID = M.MarcaID
WHERE C.Codigo = @Codigo AND P.CampaniaId = @CampaniaID
AND PC.CampaniaID = @CampaniaIDca

END;

GO

USE [BelcorpMexico]
GO

ALTER PROCEDURE [dbo].[Usp_CantidadPedidoWebDetalleSeguimiento]
(
@Codigo VARCHAR(25),
@CampaniaID INT
)
AS

BEGIN

DECLARE @CampaniaIDca INT
SET @CampaniaIDca = (SELECT CampaniaID FROM ODS.Campania where Codigo = @CampaniaID)

SELECT COUNT(P.PedidoSeguimientoID) AS Cantidad
FROM PedidoWebDetalleSeguimiento AS P
INNER JOIN ODS.Consultora AS C ON P.ConsultoraID = C.ConsultoraID
JOIN ODS.ProductoComercial AS PC ON P.CUV = PC.CUV
LEFT JOIN ODS.Marca AS M ON P.MarcaID = M.MarcaID
WHERE C.Codigo = @Codigo AND P.CampaniaId = @CampaniaID
AND PC.CampaniaID = @CampaniaIDca

END;

GO

USE [BelcorpPanama]
GO

ALTER PROCEDURE [dbo].[Usp_CantidadPedidoWebDetalleSeguimiento]
(
@Codigo VARCHAR(25),
@CampaniaID INT
)
AS

BEGIN

DECLARE @CampaniaIDca INT
SET @CampaniaIDca = (SELECT CampaniaID FROM ODS.Campania where Codigo = @CampaniaID)

SELECT COUNT(P.PedidoSeguimientoID) AS Cantidad
FROM PedidoWebDetalleSeguimiento AS P
INNER JOIN ODS.Consultora AS C ON P.ConsultoraID = C.ConsultoraID
JOIN ODS.ProductoComercial AS PC ON P.CUV = PC.CUV
LEFT JOIN ODS.Marca AS M ON P.MarcaID = M.MarcaID
WHERE C.Codigo = @Codigo AND P.CampaniaId = @CampaniaID
AND PC.CampaniaID = @CampaniaIDca

END;

GO

USE [BelcorpPeru]
GO

ALTER PROCEDURE [dbo].[Usp_CantidadPedidoWebDetalleSeguimiento]
(
@Codigo VARCHAR(25),
@CampaniaID INT
)
AS

BEGIN

DECLARE @CampaniaIDca INT
SET @CampaniaIDca = (SELECT CampaniaID FROM ODS.Campania where Codigo = @CampaniaID)

SELECT COUNT(P.PedidoSeguimientoID) AS Cantidad
FROM PedidoWebDetalleSeguimiento AS P
INNER JOIN ODS.Consultora AS C ON P.ConsultoraID = C.ConsultoraID
JOIN ODS.ProductoComercial AS PC ON P.CUV = PC.CUV
LEFT JOIN ODS.Marca AS M ON P.MarcaID = M.MarcaID
WHERE C.Codigo = @Codigo AND P.CampaniaId = @CampaniaID
AND PC.CampaniaID = @CampaniaIDca

END;

GO

USE [BelcorpPuertoRico]
GO

ALTER PROCEDURE [dbo].[Usp_CantidadPedidoWebDetalleSeguimiento]
(
@Codigo VARCHAR(25),
@CampaniaID INT
)
AS

BEGIN

DECLARE @CampaniaIDca INT
SET @CampaniaIDca = (SELECT CampaniaID FROM ODS.Campania where Codigo = @CampaniaID)

SELECT COUNT(P.PedidoSeguimientoID) AS Cantidad
FROM PedidoWebDetalleSeguimiento AS P
INNER JOIN ODS.Consultora AS C ON P.ConsultoraID = C.ConsultoraID
JOIN ODS.ProductoComercial AS PC ON P.CUV = PC.CUV
LEFT JOIN ODS.Marca AS M ON P.MarcaID = M.MarcaID
WHERE C.Codigo = @Codigo AND P.CampaniaId = @CampaniaID
AND PC.CampaniaID = @CampaniaIDca

END;

GO

USE [BelcorpSalvador]
GO

ALTER PROCEDURE [dbo].[Usp_CantidadPedidoWebDetalleSeguimiento]
(
@Codigo VARCHAR(25),
@CampaniaID INT
)
AS

BEGIN

DECLARE @CampaniaIDca INT
SET @CampaniaIDca = (SELECT CampaniaID FROM ODS.Campania where Codigo = @CampaniaID)

SELECT COUNT(P.PedidoSeguimientoID) AS Cantidad
FROM PedidoWebDetalleSeguimiento AS P
INNER JOIN ODS.Consultora AS C ON P.ConsultoraID = C.ConsultoraID
JOIN ODS.ProductoComercial AS PC ON P.CUV = PC.CUV
LEFT JOIN ODS.Marca AS M ON P.MarcaID = M.MarcaID
WHERE C.Codigo = @Codigo AND P.CampaniaId = @CampaniaID
AND PC.CampaniaID = @CampaniaIDca

END;

GO

