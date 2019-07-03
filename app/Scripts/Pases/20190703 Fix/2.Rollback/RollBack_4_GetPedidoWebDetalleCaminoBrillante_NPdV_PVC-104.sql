USE BelcorpPeru
GO

ALTER PROC [dbo].[GetPedidoWebDetalleCaminoBrillante] (
@Periodo int,
@CampaniaID int,
@ConsultoraID bigint
)
As
BEGIN
DECLARE @PedidoId Int = -1;
SELECT TOP 1 @PedidoId = PedidoID FROM PedidoWeb
WHERE CampaniaID = @CampaniaID AND ConsultoraID = @ConsultoraID;
SELECT [CampaniaID] AS CampaniaID
,[PedidoID] AS PedidoID
,[PedidoDetalleID] AS PedidoDetalleID
,[CUV] AS CUV
FROM [dbo].[PedidoWebDetalle] WITH (NOLOCK)
WHERE [PedidoID] = @PedidoId AND [OrigenPedidoWeb] in (1181901,2181901 ,4181901)
AND [CampaniaID] = @CampaniaID AND [ConsultoraID] = @ConsultoraID
END
GO

USE BelcorpMexico
GO

ALTER PROC [dbo].[GetPedidoWebDetalleCaminoBrillante] (
@Periodo int,
@CampaniaID int,
@ConsultoraID bigint
)
As
BEGIN
DECLARE @PedidoId Int = -1;
SELECT TOP 1 @PedidoId = PedidoID FROM PedidoWeb
WHERE CampaniaID = @CampaniaID AND ConsultoraID = @ConsultoraID;
SELECT [CampaniaID] AS CampaniaID
,[PedidoID] AS PedidoID
,[PedidoDetalleID] AS PedidoDetalleID
,[CUV] AS CUV
FROM [dbo].[PedidoWebDetalle] WITH (NOLOCK)
WHERE [PedidoID] = @PedidoId AND [OrigenPedidoWeb] in (1181901,2181901 ,4181901)
AND [CampaniaID] = @CampaniaID AND [ConsultoraID] = @ConsultoraID
END
GO

USE BelcorpColombia
GO

ALTER PROC [dbo].[GetPedidoWebDetalleCaminoBrillante] (
@Periodo int,
@CampaniaID int,
@ConsultoraID bigint
)
As
BEGIN
DECLARE @PedidoId Int = -1;
SELECT TOP 1 @PedidoId = PedidoID FROM PedidoWeb
WHERE CampaniaID = @CampaniaID AND ConsultoraID = @ConsultoraID;
SELECT [CampaniaID] AS CampaniaID
,[PedidoID] AS PedidoID
,[PedidoDetalleID] AS PedidoDetalleID
,[CUV] AS CUV
FROM [dbo].[PedidoWebDetalle] WITH (NOLOCK)
WHERE [PedidoID] = @PedidoId AND [OrigenPedidoWeb] in (1181901,2181901 ,4181901)
AND [CampaniaID] = @CampaniaID AND [ConsultoraID] = @ConsultoraID
END
GO

USE BelcorpSalvador
GO

ALTER PROC [dbo].[GetPedidoWebDetalleCaminoBrillante] (
@Periodo int,
@CampaniaID int,
@ConsultoraID bigint
)
As
BEGIN
DECLARE @PedidoId Int = -1;
SELECT TOP 1 @PedidoId = PedidoID FROM PedidoWeb
WHERE CampaniaID = @CampaniaID AND ConsultoraID = @ConsultoraID;
SELECT [CampaniaID] AS CampaniaID
,[PedidoID] AS PedidoID
,[PedidoDetalleID] AS PedidoDetalleID
,[CUV] AS CUV
FROM [dbo].[PedidoWebDetalle] WITH (NOLOCK)
WHERE [PedidoID] = @PedidoId AND [OrigenPedidoWeb] in (1181901,2181901 ,4181901)
AND [CampaniaID] = @CampaniaID AND [ConsultoraID] = @ConsultoraID
END
GO

USE BelcorpPuertoRico
GO

ALTER PROC [dbo].[GetPedidoWebDetalleCaminoBrillante] (
@Periodo int,
@CampaniaID int,
@ConsultoraID bigint
)
As
BEGIN
DECLARE @PedidoId Int = -1;
SELECT TOP 1 @PedidoId = PedidoID FROM PedidoWeb
WHERE CampaniaID = @CampaniaID AND ConsultoraID = @ConsultoraID;
SELECT [CampaniaID] AS CampaniaID
,[PedidoID] AS PedidoID
,[PedidoDetalleID] AS PedidoDetalleID
,[CUV] AS CUV
FROM [dbo].[PedidoWebDetalle] WITH (NOLOCK)
WHERE [PedidoID] = @PedidoId AND [OrigenPedidoWeb] in (1181901,2181901 ,4181901)
AND [CampaniaID] = @CampaniaID AND [ConsultoraID] = @ConsultoraID
END
GO

USE BelcorpPanama
GO

ALTER PROC [dbo].[GetPedidoWebDetalleCaminoBrillante] (
@Periodo int,
@CampaniaID int,
@ConsultoraID bigint
)
As
BEGIN
DECLARE @PedidoId Int = -1;
SELECT TOP 1 @PedidoId = PedidoID FROM PedidoWeb
WHERE CampaniaID = @CampaniaID AND ConsultoraID = @ConsultoraID;
SELECT [CampaniaID] AS CampaniaID
,[PedidoID] AS PedidoID
,[PedidoDetalleID] AS PedidoDetalleID
,[CUV] AS CUV
FROM [dbo].[PedidoWebDetalle] WITH (NOLOCK)
WHERE [PedidoID] = @PedidoId AND [OrigenPedidoWeb] in (1181901,2181901 ,4181901)
AND [CampaniaID] = @CampaniaID AND [ConsultoraID] = @ConsultoraID
END
GO

USE BelcorpGuatemala
GO

ALTER PROC [dbo].[GetPedidoWebDetalleCaminoBrillante] (
@Periodo int,
@CampaniaID int,
@ConsultoraID bigint
)
As
BEGIN
DECLARE @PedidoId Int = -1;
SELECT TOP 1 @PedidoId = PedidoID FROM PedidoWeb
WHERE CampaniaID = @CampaniaID AND ConsultoraID = @ConsultoraID;
SELECT [CampaniaID] AS CampaniaID
,[PedidoID] AS PedidoID
,[PedidoDetalleID] AS PedidoDetalleID
,[CUV] AS CUV
FROM [dbo].[PedidoWebDetalle] WITH (NOLOCK)
WHERE [PedidoID] = @PedidoId AND [OrigenPedidoWeb] in (1181901,2181901 ,4181901)
AND [CampaniaID] = @CampaniaID AND [ConsultoraID] = @ConsultoraID
END
GO

USE BelcorpEcuador
GO

ALTER PROC [dbo].[GetPedidoWebDetalleCaminoBrillante] (
@Periodo int,
@CampaniaID int,
@ConsultoraID bigint
)
As
BEGIN
DECLARE @PedidoId Int = -1;
SELECT TOP 1 @PedidoId = PedidoID FROM PedidoWeb
WHERE CampaniaID = @CampaniaID AND ConsultoraID = @ConsultoraID;
SELECT [CampaniaID] AS CampaniaID
,[PedidoID] AS PedidoID
,[PedidoDetalleID] AS PedidoDetalleID
,[CUV] AS CUV
FROM [dbo].[PedidoWebDetalle] WITH (NOLOCK)
WHERE [PedidoID] = @PedidoId AND [OrigenPedidoWeb] in (1181901,2181901 ,4181901)
AND [CampaniaID] = @CampaniaID AND [ConsultoraID] = @ConsultoraID
END
GO

USE BelcorpDominicana
GO

ALTER PROC [dbo].[GetPedidoWebDetalleCaminoBrillante] (
@Periodo int,
@CampaniaID int,
@ConsultoraID bigint
)
As
BEGIN
DECLARE @PedidoId Int = -1;
SELECT TOP 1 @PedidoId = PedidoID FROM PedidoWeb
WHERE CampaniaID = @CampaniaID AND ConsultoraID = @ConsultoraID;
SELECT [CampaniaID] AS CampaniaID
,[PedidoID] AS PedidoID
,[PedidoDetalleID] AS PedidoDetalleID
,[CUV] AS CUV
FROM [dbo].[PedidoWebDetalle] WITH (NOLOCK)
WHERE [PedidoID] = @PedidoId AND [OrigenPedidoWeb] in (1181901,2181901 ,4181901)
AND [CampaniaID] = @CampaniaID AND [ConsultoraID] = @ConsultoraID
END
GO

USE BelcorpCostaRica
GO

ALTER PROC [dbo].[GetPedidoWebDetalleCaminoBrillante] (
@Periodo int,
@CampaniaID int,
@ConsultoraID bigint
)
As
BEGIN
DECLARE @PedidoId Int = -1;
SELECT TOP 1 @PedidoId = PedidoID FROM PedidoWeb
WHERE CampaniaID = @CampaniaID AND ConsultoraID = @ConsultoraID;
SELECT [CampaniaID] AS CampaniaID
,[PedidoID] AS PedidoID
,[PedidoDetalleID] AS PedidoDetalleID
,[CUV] AS CUV
FROM [dbo].[PedidoWebDetalle] WITH (NOLOCK)
WHERE [PedidoID] = @PedidoId AND [OrigenPedidoWeb] in (1181901,2181901 ,4181901)
AND [CampaniaID] = @CampaniaID AND [ConsultoraID] = @ConsultoraID
END
GO

USE BelcorpChile
GO

ALTER PROC [dbo].[GetPedidoWebDetalleCaminoBrillante] (
@Periodo int,
@CampaniaID int,
@ConsultoraID bigint
)
As
BEGIN
DECLARE @PedidoId Int = -1;
SELECT TOP 1 @PedidoId = PedidoID FROM PedidoWeb
WHERE CampaniaID = @CampaniaID AND ConsultoraID = @ConsultoraID;
SELECT [CampaniaID] AS CampaniaID
,[PedidoID] AS PedidoID
,[PedidoDetalleID] AS PedidoDetalleID
,[CUV] AS CUV
FROM [dbo].[PedidoWebDetalle] WITH (NOLOCK)
WHERE [PedidoID] = @PedidoId AND [OrigenPedidoWeb] in (1181901,2181901 ,4181901)
AND [CampaniaID] = @CampaniaID AND [ConsultoraID] = @ConsultoraID
END
GO

USE BelcorpBolivia
GO

ALTER PROC [dbo].[GetPedidoWebDetalleCaminoBrillante] (
@Periodo int,
@CampaniaID int,
@ConsultoraID bigint
)
As
BEGIN
DECLARE @PedidoId Int = -1;
SELECT TOP 1 @PedidoId = PedidoID FROM PedidoWeb
WHERE CampaniaID = @CampaniaID AND ConsultoraID = @ConsultoraID;
SELECT [CampaniaID] AS CampaniaID
,[PedidoID] AS PedidoID
,[PedidoDetalleID] AS PedidoDetalleID
,[CUV] AS CUV
FROM [dbo].[PedidoWebDetalle] WITH (NOLOCK)
WHERE [PedidoID] = @PedidoId AND [OrigenPedidoWeb] in (1181901,2181901 ,4181901)
AND [CampaniaID] = @CampaniaID AND [ConsultoraID] = @ConsultoraID
END
GO

