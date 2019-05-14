USE BelcorpPeru
GO

If Exists(select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetPedidoWebDetalleCaminoBrillante'))
Begin
	DROP PROCEDURE [dbo].[GetPedidoWebDetalleCaminoBrillante]
end
GO
CREATE PROC [dbo].[GetPedidoWebDetalleCaminoBrillante] (
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

If Exists(select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetPedidoWebDetalleCaminoBrillante'))
Begin
	DROP PROCEDURE [dbo].[GetPedidoWebDetalleCaminoBrillante]
end
GO
CREATE PROC [dbo].[GetPedidoWebDetalleCaminoBrillante] (
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

If Exists(select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetPedidoWebDetalleCaminoBrillante'))
Begin
	DROP PROCEDURE [dbo].[GetPedidoWebDetalleCaminoBrillante]
end
GO
CREATE PROC [dbo].[GetPedidoWebDetalleCaminoBrillante] (
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

If Exists(select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetPedidoWebDetalleCaminoBrillante'))
Begin
	DROP PROCEDURE [dbo].[GetPedidoWebDetalleCaminoBrillante]
end
GO
CREATE PROC [dbo].[GetPedidoWebDetalleCaminoBrillante] (
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

If Exists(select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetPedidoWebDetalleCaminoBrillante'))
Begin
	DROP PROCEDURE [dbo].[GetPedidoWebDetalleCaminoBrillante]
end
GO
CREATE PROC [dbo].[GetPedidoWebDetalleCaminoBrillante] (
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

If Exists(select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetPedidoWebDetalleCaminoBrillante'))
Begin
	DROP PROCEDURE [dbo].[GetPedidoWebDetalleCaminoBrillante]
end
GO
CREATE PROC [dbo].[GetPedidoWebDetalleCaminoBrillante] (
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

If Exists(select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetPedidoWebDetalleCaminoBrillante'))
Begin
	DROP PROCEDURE [dbo].[GetPedidoWebDetalleCaminoBrillante]
end
GO
CREATE PROC [dbo].[GetPedidoWebDetalleCaminoBrillante] (
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

If Exists(select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetPedidoWebDetalleCaminoBrillante'))
Begin
	DROP PROCEDURE [dbo].[GetPedidoWebDetalleCaminoBrillante]
end
GO
CREATE PROC [dbo].[GetPedidoWebDetalleCaminoBrillante] (
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

If Exists(select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetPedidoWebDetalleCaminoBrillante'))
Begin
	DROP PROCEDURE [dbo].[GetPedidoWebDetalleCaminoBrillante]
end
GO
CREATE PROC [dbo].[GetPedidoWebDetalleCaminoBrillante] (
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

If Exists(select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetPedidoWebDetalleCaminoBrillante'))
Begin
	DROP PROCEDURE [dbo].[GetPedidoWebDetalleCaminoBrillante]
end
GO
CREATE PROC [dbo].[GetPedidoWebDetalleCaminoBrillante] (
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

If Exists(select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetPedidoWebDetalleCaminoBrillante'))
Begin
	DROP PROCEDURE [dbo].[GetPedidoWebDetalleCaminoBrillante]
end
GO
CREATE PROC [dbo].[GetPedidoWebDetalleCaminoBrillante] (
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

If Exists(select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetPedidoWebDetalleCaminoBrillante'))
Begin
	DROP PROCEDURE [dbo].[GetPedidoWebDetalleCaminoBrillante]
end
GO
CREATE PROC [dbo].[GetPedidoWebDetalleCaminoBrillante] (
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

