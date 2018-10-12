USE BelcorpBolivia
GO
IF OBJECT_ID('dbo.GetPedidoWebSetDetalle', 'P') IS NOT NULL
	DROP PROC dbo.GetPedidoWebSetDetalle
GO
CREATE PROCEDURE dbo.GetPedidoWebSetDetalle
                @Campania AS int,  
                @ConsultoraId AS bigint  
AS  
  SELECT
   dset.SetId,
  dset.CuvProducto,
  dset.PedidoDetalleID,
  dset.Cantidad,
  dset.FactorRepeticion
FROM dbo.PedidoWebSet pset
INNER JOIN dbo.PedidoWebSetDetalle dset
  ON pset.SetId = dset.SetId
WHERE pset.Campania = @Campania
AND pset.ConsultoraID = @ConsultoraId
GO

USE BelcorpChile
GO
IF OBJECT_ID('dbo.GetPedidoWebSetDetalle', 'P') IS NOT NULL
	DROP PROC dbo.GetPedidoWebSetDetalle
GO
CREATE PROCEDURE dbo.GetPedidoWebSetDetalle
                @Campania AS int,  
                @ConsultoraId AS bigint  
AS  
  SELECT
   dset.SetId,
  dset.CuvProducto,
  dset.PedidoDetalleID,
  dset.Cantidad,
  dset.FactorRepeticion
FROM dbo.PedidoWebSet pset
INNER JOIN dbo.PedidoWebSetDetalle dset
  ON pset.SetId = dset.SetId
WHERE pset.Campania = @Campania
AND pset.ConsultoraID = @ConsultoraId
GO

USE BelcorpColombia
GO
IF OBJECT_ID('dbo.GetPedidoWebSetDetalle', 'P') IS NOT NULL
	DROP PROC dbo.GetPedidoWebSetDetalle
GO
CREATE PROCEDURE dbo.GetPedidoWebSetDetalle
                @Campania AS int,  
                @ConsultoraId AS bigint  
AS  
  SELECT
   dset.SetId,
  dset.CuvProducto,
  dset.PedidoDetalleID,
  dset.Cantidad,
  dset.FactorRepeticion
FROM dbo.PedidoWebSet pset
INNER JOIN dbo.PedidoWebSetDetalle dset
  ON pset.SetId = dset.SetId
WHERE pset.Campania = @Campania
AND pset.ConsultoraID = @ConsultoraId
GO

USE BelcorpCostaRica
GO
IF OBJECT_ID('dbo.GetPedidoWebSetDetalle', 'P') IS NOT NULL
	DROP PROC dbo.GetPedidoWebSetDetalle
GO
CREATE PROCEDURE dbo.GetPedidoWebSetDetalle
                @Campania AS int,  
                @ConsultoraId AS bigint  
AS  
  SELECT
   dset.SetId,
  dset.CuvProducto,
  dset.PedidoDetalleID,
  dset.Cantidad,
  dset.FactorRepeticion
FROM dbo.PedidoWebSet pset
INNER JOIN dbo.PedidoWebSetDetalle dset
  ON pset.SetId = dset.SetId
WHERE pset.Campania = @Campania
AND pset.ConsultoraID = @ConsultoraId
GO

USE BelcorpDominicana
GO
IF OBJECT_ID('dbo.GetPedidoWebSetDetalle', 'P') IS NOT NULL
	DROP PROC dbo.GetPedidoWebSetDetalle
GO
CREATE PROCEDURE dbo.GetPedidoWebSetDetalle
                @Campania AS int,  
                @ConsultoraId AS bigint  
AS  
  SELECT
   dset.SetId,
  dset.CuvProducto,
  dset.PedidoDetalleID,
  dset.Cantidad,
  dset.FactorRepeticion
FROM dbo.PedidoWebSet pset
INNER JOIN dbo.PedidoWebSetDetalle dset
  ON pset.SetId = dset.SetId
WHERE pset.Campania = @Campania
AND pset.ConsultoraID = @ConsultoraId
GO

USE BelcorpEcuador
GO
IF OBJECT_ID('dbo.GetPedidoWebSetDetalle', 'P') IS NOT NULL
	DROP PROC dbo.GetPedidoWebSetDetalle
GO
CREATE PROCEDURE dbo.GetPedidoWebSetDetalle
                @Campania AS int,  
                @ConsultoraId AS bigint  
AS  
  SELECT
   dset.SetId,
  dset.CuvProducto,
  dset.PedidoDetalleID,
  dset.Cantidad,
  dset.FactorRepeticion
FROM dbo.PedidoWebSet pset
INNER JOIN dbo.PedidoWebSetDetalle dset
  ON pset.SetId = dset.SetId
WHERE pset.Campania = @Campania
AND pset.ConsultoraID = @ConsultoraId
GO

USE BelcorpGuatemala
GO
IF OBJECT_ID('dbo.GetPedidoWebSetDetalle', 'P') IS NOT NULL
	DROP PROC dbo.GetPedidoWebSetDetalle
GO
CREATE PROCEDURE dbo.GetPedidoWebSetDetalle
                @Campania AS int,  
                @ConsultoraId AS bigint  
AS  
  SELECT
   dset.SetId,
  dset.CuvProducto,
  dset.PedidoDetalleID,
  dset.Cantidad,
  dset.FactorRepeticion
FROM dbo.PedidoWebSet pset
INNER JOIN dbo.PedidoWebSetDetalle dset
  ON pset.SetId = dset.SetId
WHERE pset.Campania = @Campania
AND pset.ConsultoraID = @ConsultoraId
GO

USE BelcorpMexico
GO
IF OBJECT_ID('dbo.GetPedidoWebSetDetalle', 'P') IS NOT NULL
	DROP PROC dbo.GetPedidoWebSetDetalle
GO
CREATE PROCEDURE dbo.GetPedidoWebSetDetalle
                @Campania AS int,  
                @ConsultoraId AS bigint  
AS  
  SELECT
   dset.SetId,
  dset.CuvProducto,
  dset.PedidoDetalleID,
  dset.Cantidad,
  dset.FactorRepeticion
FROM dbo.PedidoWebSet pset
INNER JOIN dbo.PedidoWebSetDetalle dset
  ON pset.SetId = dset.SetId
WHERE pset.Campania = @Campania
AND pset.ConsultoraID = @ConsultoraId
GO

USE BelcorpPanama
GO
IF OBJECT_ID('dbo.GetPedidoWebSetDetalle', 'P') IS NOT NULL
	DROP PROC dbo.GetPedidoWebSetDetalle
GO
CREATE PROCEDURE dbo.GetPedidoWebSetDetalle
                @Campania AS int,  
                @ConsultoraId AS bigint  
AS  
  SELECT
   dset.SetId,
  dset.CuvProducto,
  dset.PedidoDetalleID,
  dset.Cantidad,
  dset.FactorRepeticion
FROM dbo.PedidoWebSet pset
INNER JOIN dbo.PedidoWebSetDetalle dset
  ON pset.SetId = dset.SetId
WHERE pset.Campania = @Campania
AND pset.ConsultoraID = @ConsultoraId
GO

USE BelcorpPeru
GO
IF OBJECT_ID('dbo.GetPedidoWebSetDetalle', 'P') IS NOT NULL
	DROP PROC dbo.GetPedidoWebSetDetalle
GO
CREATE PROCEDURE dbo.GetPedidoWebSetDetalle
                @Campania AS int,  
                @ConsultoraId AS bigint  
AS  
  SELECT
   dset.SetId,
  dset.CuvProducto,
  dset.PedidoDetalleID,
  dset.Cantidad,
  dset.FactorRepeticion
FROM dbo.PedidoWebSet pset
INNER JOIN dbo.PedidoWebSetDetalle dset
  ON pset.SetId = dset.SetId
WHERE pset.Campania = @Campania
AND pset.ConsultoraID = @ConsultoraId
GO

USE BelcorpPuertoRico
GO
IF OBJECT_ID('dbo.GetPedidoWebSetDetalle', 'P') IS NOT NULL
	DROP PROC dbo.GetPedidoWebSetDetalle
GO
CREATE PROCEDURE dbo.GetPedidoWebSetDetalle
                @Campania AS int,  
                @ConsultoraId AS bigint  
AS  
  SELECT
   dset.SetId,
  dset.CuvProducto,
  dset.PedidoDetalleID,
  dset.Cantidad,
  dset.FactorRepeticion
FROM dbo.PedidoWebSet pset
INNER JOIN dbo.PedidoWebSetDetalle dset
  ON pset.SetId = dset.SetId
WHERE pset.Campania = @Campania
AND pset.ConsultoraID = @ConsultoraId
GO

USE BelcorpSalvador
GO
IF OBJECT_ID('dbo.GetPedidoWebSetDetalle', 'P') IS NOT NULL
	DROP PROC dbo.GetPedidoWebSetDetalle
GO
CREATE PROCEDURE dbo.GetPedidoWebSetDetalle
                @Campania AS int,  
                @ConsultoraId AS bigint  
AS  
  SELECT
   dset.SetId,
  dset.CuvProducto,
  dset.PedidoDetalleID,
  dset.Cantidad,
  dset.FactorRepeticion
FROM dbo.PedidoWebSet pset
INNER JOIN dbo.PedidoWebSetDetalle dset
  ON pset.SetId = dset.SetId
WHERE pset.Campania = @Campania
AND pset.ConsultoraID = @ConsultoraId
GO


