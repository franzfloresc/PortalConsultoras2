USE BelcorpPeru
GO

ALTER PROCEDURE dbo.Usp_PedidoWeb
@CodigoConsultora VARCHAR(25),
@CampaniaID INT
AS
BEGIN
SELECT
CAST(P.CampaniaId AS VARCHAR(20)) AS CampaniaId,
CAST(P.PedidoID AS VARCHAR(20)) AS PedidoID,
CAST(C.ConsultoraID AS VARCHAR(25)) AS ConsultoraID,
C.NombreCompleto,
CAST(P.Clientes AS VARCHAR(20)) AS Clientes,
CAST(P.ImporteTotal AS VARCHAR(20)) AS ImporteTotal,
CAST(ISNULL(P.ImporteTotal,0) - ISNULL(P.DescuentoProl,0) AS VARCHAR(20)) AS ImporteTotalConDescuento,
CAST(P.ImporteCredito AS VARCHAR(20)) AS ImporteCredito,
CAST(P.IndicadorEnviado AS VARCHAR(20)) AS IndicadorEnviado,
CAST(P.Bloqueado AS VARCHAR(20)) AS Bloqueado,
CAST(P.EstadoPedido AS VARCHAR(20)) AS EstadoPedido,
CONVERT(varchar(10), p.fecharegistro, 103) AS FechaIngreso,
CONVERT(varchar(10), p.fechamodificacion, 103) AS FechaActualizacion,
CASE
WHEN (p.estadopedido = 202 and p.validacionabierta = 0) THEN 'SI'
ELSE 'NO'
END AS Validado,
CASE
WHEN (p.indicadorenviado = 1) THEN 'SI'
ELSE 'NO'
END AS PedidoDescargado
FROM PedidoWeb AS P
INNER JOIN ODS.Consultora AS C ON P.ConsultoraID = C.ConsultoraID
WHERE C.Codigo = @CodigoConsultora AND P.CampaniaId = @CampaniaID;
END
GO

USE BelcorpMexico
GO

ALTER PROCEDURE dbo.Usp_PedidoWeb
@CodigoConsultora VARCHAR(25),
@CampaniaID INT
AS
BEGIN
SELECT
CAST(P.CampaniaId AS VARCHAR(20)) AS CampaniaId,
CAST(P.PedidoID AS VARCHAR(20)) AS PedidoID,
CAST(C.ConsultoraID AS VARCHAR(25)) AS ConsultoraID,
C.NombreCompleto,
CAST(P.Clientes AS VARCHAR(20)) AS Clientes,
CAST(P.ImporteTotal AS VARCHAR(20)) AS ImporteTotal,
CAST(ISNULL(P.ImporteTotal,0) - ISNULL(P.DescuentoProl,0) AS VARCHAR(20)) AS ImporteTotalConDescuento,
CAST(P.ImporteCredito AS VARCHAR(20)) AS ImporteCredito,
CAST(P.IndicadorEnviado AS VARCHAR(20)) AS IndicadorEnviado,
CAST(P.Bloqueado AS VARCHAR(20)) AS Bloqueado,
CAST(P.EstadoPedido AS VARCHAR(20)) AS EstadoPedido,
CONVERT(varchar(10), p.fecharegistro, 103) AS FechaIngreso,
CONVERT(varchar(10), p.fechamodificacion, 103) AS FechaActualizacion,
CASE
WHEN (p.estadopedido = 202 and p.validacionabierta = 0) THEN 'SI'
ELSE 'NO'
END AS Validado,
CASE
WHEN (p.indicadorenviado = 1) THEN 'SI'
ELSE 'NO'
END AS PedidoDescargado
FROM PedidoWeb AS P
INNER JOIN ODS.Consultora AS C ON P.ConsultoraID = C.ConsultoraID
WHERE C.Codigo = @CodigoConsultora AND P.CampaniaId = @CampaniaID;
END
GO

USE BelcorpColombia
GO

ALTER PROCEDURE dbo.Usp_PedidoWeb
@CodigoConsultora VARCHAR(25),
@CampaniaID INT
AS
BEGIN
SELECT
CAST(P.CampaniaId AS VARCHAR(20)) AS CampaniaId,
CAST(P.PedidoID AS VARCHAR(20)) AS PedidoID,
CAST(C.ConsultoraID AS VARCHAR(25)) AS ConsultoraID,
C.NombreCompleto,
CAST(P.Clientes AS VARCHAR(20)) AS Clientes,
CAST(P.ImporteTotal AS VARCHAR(20)) AS ImporteTotal,
CAST(ISNULL(P.ImporteTotal,0) - ISNULL(P.DescuentoProl,0) AS VARCHAR(20)) AS ImporteTotalConDescuento,
CAST(P.ImporteCredito AS VARCHAR(20)) AS ImporteCredito,
CAST(P.IndicadorEnviado AS VARCHAR(20)) AS IndicadorEnviado,
CAST(P.Bloqueado AS VARCHAR(20)) AS Bloqueado,
CAST(P.EstadoPedido AS VARCHAR(20)) AS EstadoPedido,
CONVERT(varchar(10), p.fecharegistro, 103) AS FechaIngreso,
CONVERT(varchar(10), p.fechamodificacion, 103) AS FechaActualizacion,
CASE
WHEN (p.estadopedido = 202 and p.validacionabierta = 0) THEN 'SI'
ELSE 'NO'
END AS Validado,
CASE
WHEN (p.indicadorenviado = 1) THEN 'SI'
ELSE 'NO'
END AS PedidoDescargado
FROM PedidoWeb AS P
INNER JOIN ODS.Consultora AS C ON P.ConsultoraID = C.ConsultoraID
WHERE C.Codigo = @CodigoConsultora AND P.CampaniaId = @CampaniaID;
END
GO

USE BelcorpSalvador
GO

ALTER PROCEDURE dbo.Usp_PedidoWeb
@CodigoConsultora VARCHAR(25),
@CampaniaID INT
AS
BEGIN
SELECT
CAST(P.CampaniaId AS VARCHAR(20)) AS CampaniaId,
CAST(P.PedidoID AS VARCHAR(20)) AS PedidoID,
CAST(C.ConsultoraID AS VARCHAR(25)) AS ConsultoraID,
C.NombreCompleto,
CAST(P.Clientes AS VARCHAR(20)) AS Clientes,
CAST(P.ImporteTotal AS VARCHAR(20)) AS ImporteTotal,
CAST(ISNULL(P.ImporteTotal,0) - ISNULL(P.DescuentoProl,0) AS VARCHAR(20)) AS ImporteTotalConDescuento,
CAST(P.ImporteCredito AS VARCHAR(20)) AS ImporteCredito,
CAST(P.IndicadorEnviado AS VARCHAR(20)) AS IndicadorEnviado,
CAST(P.Bloqueado AS VARCHAR(20)) AS Bloqueado,
CAST(P.EstadoPedido AS VARCHAR(20)) AS EstadoPedido,
CONVERT(varchar(10), p.fecharegistro, 103) AS FechaIngreso,
CONVERT(varchar(10), p.fechamodificacion, 103) AS FechaActualizacion,
CASE
WHEN (p.estadopedido = 202 and p.validacionabierta = 0) THEN 'SI'
ELSE 'NO'
END AS Validado,
CASE
WHEN (p.indicadorenviado = 1) THEN 'SI'
ELSE 'NO'
END AS PedidoDescargado
FROM PedidoWeb AS P
INNER JOIN ODS.Consultora AS C ON P.ConsultoraID = C.ConsultoraID
WHERE C.Codigo = @CodigoConsultora AND P.CampaniaId = @CampaniaID;
END
GO

USE BelcorpPuertoRico
GO

ALTER PROCEDURE dbo.Usp_PedidoWeb
@CodigoConsultora VARCHAR(25),
@CampaniaID INT
AS
BEGIN
SELECT
CAST(P.CampaniaId AS VARCHAR(20)) AS CampaniaId,
CAST(P.PedidoID AS VARCHAR(20)) AS PedidoID,
CAST(C.ConsultoraID AS VARCHAR(25)) AS ConsultoraID,
C.NombreCompleto,
CAST(P.Clientes AS VARCHAR(20)) AS Clientes,
CAST(P.ImporteTotal AS VARCHAR(20)) AS ImporteTotal,
CAST(ISNULL(P.ImporteTotal,0) - ISNULL(P.DescuentoProl,0) AS VARCHAR(20)) AS ImporteTotalConDescuento,
CAST(P.ImporteCredito AS VARCHAR(20)) AS ImporteCredito,
CAST(P.IndicadorEnviado AS VARCHAR(20)) AS IndicadorEnviado,
CAST(P.Bloqueado AS VARCHAR(20)) AS Bloqueado,
CAST(P.EstadoPedido AS VARCHAR(20)) AS EstadoPedido,
CONVERT(varchar(10), p.fecharegistro, 103) AS FechaIngreso,
CONVERT(varchar(10), p.fechamodificacion, 103) AS FechaActualizacion,
CASE
WHEN (p.estadopedido = 202 and p.validacionabierta = 0) THEN 'SI'
ELSE 'NO'
END AS Validado,
CASE
WHEN (p.indicadorenviado = 1) THEN 'SI'
ELSE 'NO'
END AS PedidoDescargado
FROM PedidoWeb AS P
INNER JOIN ODS.Consultora AS C ON P.ConsultoraID = C.ConsultoraID
WHERE C.Codigo = @CodigoConsultora AND P.CampaniaId = @CampaniaID;
END
GO

USE BelcorpPanama
GO

ALTER PROCEDURE dbo.Usp_PedidoWeb
@CodigoConsultora VARCHAR(25),
@CampaniaID INT
AS
BEGIN
SELECT
CAST(P.CampaniaId AS VARCHAR(20)) AS CampaniaId,
CAST(P.PedidoID AS VARCHAR(20)) AS PedidoID,
CAST(C.ConsultoraID AS VARCHAR(25)) AS ConsultoraID,
C.NombreCompleto,
CAST(P.Clientes AS VARCHAR(20)) AS Clientes,
CAST(P.ImporteTotal AS VARCHAR(20)) AS ImporteTotal,
CAST(ISNULL(P.ImporteTotal,0) - ISNULL(P.DescuentoProl,0) AS VARCHAR(20)) AS ImporteTotalConDescuento,
CAST(P.ImporteCredito AS VARCHAR(20)) AS ImporteCredito,
CAST(P.IndicadorEnviado AS VARCHAR(20)) AS IndicadorEnviado,
CAST(P.Bloqueado AS VARCHAR(20)) AS Bloqueado,
CAST(P.EstadoPedido AS VARCHAR(20)) AS EstadoPedido,
CONVERT(varchar(10), p.fecharegistro, 103) AS FechaIngreso,
CONVERT(varchar(10), p.fechamodificacion, 103) AS FechaActualizacion,
CASE
WHEN (p.estadopedido = 202 and p.validacionabierta = 0) THEN 'SI'
ELSE 'NO'
END AS Validado,
CASE
WHEN (p.indicadorenviado = 1) THEN 'SI'
ELSE 'NO'
END AS PedidoDescargado
FROM PedidoWeb AS P
INNER JOIN ODS.Consultora AS C ON P.ConsultoraID = C.ConsultoraID
WHERE C.Codigo = @CodigoConsultora AND P.CampaniaId = @CampaniaID;
END
GO

USE BelcorpGuatemala
GO

ALTER PROCEDURE dbo.Usp_PedidoWeb
@CodigoConsultora VARCHAR(25),
@CampaniaID INT
AS
BEGIN
SELECT
CAST(P.CampaniaId AS VARCHAR(20)) AS CampaniaId,
CAST(P.PedidoID AS VARCHAR(20)) AS PedidoID,
CAST(C.ConsultoraID AS VARCHAR(25)) AS ConsultoraID,
C.NombreCompleto,
CAST(P.Clientes AS VARCHAR(20)) AS Clientes,
CAST(P.ImporteTotal AS VARCHAR(20)) AS ImporteTotal,
CAST(ISNULL(P.ImporteTotal,0) - ISNULL(P.DescuentoProl,0) AS VARCHAR(20)) AS ImporteTotalConDescuento,
CAST(P.ImporteCredito AS VARCHAR(20)) AS ImporteCredito,
CAST(P.IndicadorEnviado AS VARCHAR(20)) AS IndicadorEnviado,
CAST(P.Bloqueado AS VARCHAR(20)) AS Bloqueado,
CAST(P.EstadoPedido AS VARCHAR(20)) AS EstadoPedido,
CONVERT(varchar(10), p.fecharegistro, 103) AS FechaIngreso,
CONVERT(varchar(10), p.fechamodificacion, 103) AS FechaActualizacion,
CASE
WHEN (p.estadopedido = 202 and p.validacionabierta = 0) THEN 'SI'
ELSE 'NO'
END AS Validado,
CASE
WHEN (p.indicadorenviado = 1) THEN 'SI'
ELSE 'NO'
END AS PedidoDescargado
FROM PedidoWeb AS P
INNER JOIN ODS.Consultora AS C ON P.ConsultoraID = C.ConsultoraID
WHERE C.Codigo = @CodigoConsultora AND P.CampaniaId = @CampaniaID;
END
GO

USE BelcorpEcuador
GO

ALTER PROCEDURE dbo.Usp_PedidoWeb
@CodigoConsultora VARCHAR(25),
@CampaniaID INT
AS
BEGIN
SELECT
CAST(P.CampaniaId AS VARCHAR(20)) AS CampaniaId,
CAST(P.PedidoID AS VARCHAR(20)) AS PedidoID,
CAST(C.ConsultoraID AS VARCHAR(25)) AS ConsultoraID,
C.NombreCompleto,
CAST(P.Clientes AS VARCHAR(20)) AS Clientes,
CAST(P.ImporteTotal AS VARCHAR(20)) AS ImporteTotal,
CAST(ISNULL(P.ImporteTotal,0) - ISNULL(P.DescuentoProl,0) AS VARCHAR(20)) AS ImporteTotalConDescuento,
CAST(P.ImporteCredito AS VARCHAR(20)) AS ImporteCredito,
CAST(P.IndicadorEnviado AS VARCHAR(20)) AS IndicadorEnviado,
CAST(P.Bloqueado AS VARCHAR(20)) AS Bloqueado,
CAST(P.EstadoPedido AS VARCHAR(20)) AS EstadoPedido,
CONVERT(varchar(10), p.fecharegistro, 103) AS FechaIngreso,
CONVERT(varchar(10), p.fechamodificacion, 103) AS FechaActualizacion,
CASE
WHEN (p.estadopedido = 202 and p.validacionabierta = 0) THEN 'SI'
ELSE 'NO'
END AS Validado,
CASE
WHEN (p.indicadorenviado = 1) THEN 'SI'
ELSE 'NO'
END AS PedidoDescargado
FROM PedidoWeb AS P
INNER JOIN ODS.Consultora AS C ON P.ConsultoraID = C.ConsultoraID
WHERE C.Codigo = @CodigoConsultora AND P.CampaniaId = @CampaniaID;
END
GO

USE BelcorpDominicana
GO

ALTER PROCEDURE dbo.Usp_PedidoWeb
@CodigoConsultora VARCHAR(25),
@CampaniaID INT
AS
BEGIN
SELECT
CAST(P.CampaniaId AS VARCHAR(20)) AS CampaniaId,
CAST(P.PedidoID AS VARCHAR(20)) AS PedidoID,
CAST(C.ConsultoraID AS VARCHAR(25)) AS ConsultoraID,
C.NombreCompleto,
CAST(P.Clientes AS VARCHAR(20)) AS Clientes,
CAST(P.ImporteTotal AS VARCHAR(20)) AS ImporteTotal,
CAST(ISNULL(P.ImporteTotal,0) - ISNULL(P.DescuentoProl,0) AS VARCHAR(20)) AS ImporteTotalConDescuento,
CAST(P.ImporteCredito AS VARCHAR(20)) AS ImporteCredito,
CAST(P.IndicadorEnviado AS VARCHAR(20)) AS IndicadorEnviado,
CAST(P.Bloqueado AS VARCHAR(20)) AS Bloqueado,
CAST(P.EstadoPedido AS VARCHAR(20)) AS EstadoPedido,
CONVERT(varchar(10), p.fecharegistro, 103) AS FechaIngreso,
CONVERT(varchar(10), p.fechamodificacion, 103) AS FechaActualizacion,
CASE
WHEN (p.estadopedido = 202 and p.validacionabierta = 0) THEN 'SI'
ELSE 'NO'
END AS Validado,
CASE
WHEN (p.indicadorenviado = 1) THEN 'SI'
ELSE 'NO'
END AS PedidoDescargado
FROM PedidoWeb AS P
INNER JOIN ODS.Consultora AS C ON P.ConsultoraID = C.ConsultoraID
WHERE C.Codigo = @CodigoConsultora AND P.CampaniaId = @CampaniaID;
END
GO

USE BelcorpCostaRica
GO

ALTER PROCEDURE dbo.Usp_PedidoWeb
@CodigoConsultora VARCHAR(25),
@CampaniaID INT
AS
BEGIN
SELECT
CAST(P.CampaniaId AS VARCHAR(20)) AS CampaniaId,
CAST(P.PedidoID AS VARCHAR(20)) AS PedidoID,
CAST(C.ConsultoraID AS VARCHAR(25)) AS ConsultoraID,
C.NombreCompleto,
CAST(P.Clientes AS VARCHAR(20)) AS Clientes,
CAST(P.ImporteTotal AS VARCHAR(20)) AS ImporteTotal,
CAST(ISNULL(P.ImporteTotal,0) - ISNULL(P.DescuentoProl,0) AS VARCHAR(20)) AS ImporteTotalConDescuento,
CAST(P.ImporteCredito AS VARCHAR(20)) AS ImporteCredito,
CAST(P.IndicadorEnviado AS VARCHAR(20)) AS IndicadorEnviado,
CAST(P.Bloqueado AS VARCHAR(20)) AS Bloqueado,
CAST(P.EstadoPedido AS VARCHAR(20)) AS EstadoPedido,
CONVERT(varchar(10), p.fecharegistro, 103) AS FechaIngreso,
CONVERT(varchar(10), p.fechamodificacion, 103) AS FechaActualizacion,
CASE
WHEN (p.estadopedido = 202 and p.validacionabierta = 0) THEN 'SI'
ELSE 'NO'
END AS Validado,
CASE
WHEN (p.indicadorenviado = 1) THEN 'SI'
ELSE 'NO'
END AS PedidoDescargado
FROM PedidoWeb AS P
INNER JOIN ODS.Consultora AS C ON P.ConsultoraID = C.ConsultoraID
WHERE C.Codigo = @CodigoConsultora AND P.CampaniaId = @CampaniaID;
END
GO

USE BelcorpChile
GO

ALTER PROCEDURE dbo.Usp_PedidoWeb
@CodigoConsultora VARCHAR(25),
@CampaniaID INT
AS
BEGIN
SELECT
CAST(P.CampaniaId AS VARCHAR(20)) AS CampaniaId,
CAST(P.PedidoID AS VARCHAR(20)) AS PedidoID,
CAST(C.ConsultoraID AS VARCHAR(25)) AS ConsultoraID,
C.NombreCompleto,
CAST(P.Clientes AS VARCHAR(20)) AS Clientes,
CAST(P.ImporteTotal AS VARCHAR(20)) AS ImporteTotal,
CAST(ISNULL(P.ImporteTotal,0) - ISNULL(P.DescuentoProl,0) AS VARCHAR(20)) AS ImporteTotalConDescuento,
CAST(P.ImporteCredito AS VARCHAR(20)) AS ImporteCredito,
CAST(P.IndicadorEnviado AS VARCHAR(20)) AS IndicadorEnviado,
CAST(P.Bloqueado AS VARCHAR(20)) AS Bloqueado,
CAST(P.EstadoPedido AS VARCHAR(20)) AS EstadoPedido,
CONVERT(varchar(10), p.fecharegistro, 103) AS FechaIngreso,
CONVERT(varchar(10), p.fechamodificacion, 103) AS FechaActualizacion,
CASE
WHEN (p.estadopedido = 202 and p.validacionabierta = 0) THEN 'SI'
ELSE 'NO'
END AS Validado,
CASE
WHEN (p.indicadorenviado = 1) THEN 'SI'
ELSE 'NO'
END AS PedidoDescargado
FROM PedidoWeb AS P
INNER JOIN ODS.Consultora AS C ON P.ConsultoraID = C.ConsultoraID
WHERE C.Codigo = @CodigoConsultora AND P.CampaniaId = @CampaniaID;
END
GO

USE BelcorpBolivia
GO

ALTER PROCEDURE dbo.Usp_PedidoWeb
@CodigoConsultora VARCHAR(25),
@CampaniaID INT
AS
BEGIN
SELECT
CAST(P.CampaniaId AS VARCHAR(20)) AS CampaniaId,
CAST(P.PedidoID AS VARCHAR(20)) AS PedidoID,
CAST(C.ConsultoraID AS VARCHAR(25)) AS ConsultoraID,
C.NombreCompleto,
CAST(P.Clientes AS VARCHAR(20)) AS Clientes,
CAST(P.ImporteTotal AS VARCHAR(20)) AS ImporteTotal,
CAST(ISNULL(P.ImporteTotal,0) - ISNULL(P.DescuentoProl,0) AS VARCHAR(20)) AS ImporteTotalConDescuento,
CAST(P.ImporteCredito AS VARCHAR(20)) AS ImporteCredito,
CAST(P.IndicadorEnviado AS VARCHAR(20)) AS IndicadorEnviado,
CAST(P.Bloqueado AS VARCHAR(20)) AS Bloqueado,
CAST(P.EstadoPedido AS VARCHAR(20)) AS EstadoPedido,
CONVERT(varchar(10), p.fecharegistro, 103) AS FechaIngreso,
CONVERT(varchar(10), p.fechamodificacion, 103) AS FechaActualizacion,
CASE
WHEN (p.estadopedido = 202 and p.validacionabierta = 0) THEN 'SI'
ELSE 'NO'
END AS Validado,
CASE
WHEN (p.indicadorenviado = 1) THEN 'SI'
ELSE 'NO'
END AS PedidoDescargado
FROM PedidoWeb AS P
INNER JOIN ODS.Consultora AS C ON P.ConsultoraID = C.ConsultoraID
WHERE C.Codigo = @CodigoConsultora AND P.CampaniaId = @CampaniaID;
END
GO

