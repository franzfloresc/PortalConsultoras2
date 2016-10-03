
USE BelcorpPeru
GO

IF EXISTS (
  SELECT 1 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[SolicitudCliente]') 
         AND name = 'PedidoWebID'
)
BEGIN
	ALTER TABLE [dbo].[SolicitudCliente] DROP COLUMN PedidoWebID
END

IF EXISTS (
  SELECT 1 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[SolicitudClienteDetalle]') 
         AND name = 'TipoAtencion'
)
BEGIN
	ALTER TABLE [dbo].[SolicitudClienteDetalle] DROP COLUMN TipoAtencion
END

IF EXISTS (
  SELECT 1 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[SolicitudClienteDetalle]') 
         AND name = 'PedidoWebID'
)
BEGIN
	ALTER TABLE [dbo].[SolicitudClienteDetalle] DROP COLUMN PedidoWebID
END

IF EXISTS (
  SELECT 1 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[SolicitudClienteDetalle]') 
         AND name = 'PedidoWebDetalleID'
)
BEGIN
	ALTER TABLE [dbo].[SolicitudClienteDetalle] DROP COLUMN PedidoWebDetalleID
END

GO

/*end*/

USE BelcorpColombia
GO

IF EXISTS (
  SELECT 1 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[SolicitudCliente]') 
         AND name = 'PedidoWebID'
)
BEGIN
	ALTER TABLE [dbo].[SolicitudCliente] DROP COLUMN PedidoWebID
END

IF EXISTS (
  SELECT 1 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[SolicitudClienteDetalle]') 
         AND name = 'TipoAtencion'
)
BEGIN
	ALTER TABLE [dbo].[SolicitudClienteDetalle] DROP COLUMN TipoAtencion
END

IF EXISTS (
  SELECT 1 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[SolicitudClienteDetalle]') 
         AND name = 'PedidoWebID'
)
BEGIN
	ALTER TABLE [dbo].[SolicitudClienteDetalle] DROP COLUMN PedidoWebID
END

IF EXISTS (
  SELECT 1 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[SolicitudClienteDetalle]') 
         AND name = 'PedidoWebDetalleID'
)
BEGIN
	ALTER TABLE [dbo].[SolicitudClienteDetalle] DROP COLUMN PedidoWebDetalleID
END

GO

/*end*/

USE BelcorpChile
GO

IF EXISTS (
  SELECT 1 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[SolicitudCliente]') 
         AND name = 'PedidoWebID'
)
BEGIN
	ALTER TABLE [dbo].[SolicitudCliente] DROP COLUMN PedidoWebID
END

IF EXISTS (
  SELECT 1 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[SolicitudClienteDetalle]') 
         AND name = 'TipoAtencion'
)
BEGIN
	ALTER TABLE [dbo].[SolicitudClienteDetalle] DROP COLUMN TipoAtencion
END

IF EXISTS (
  SELECT 1 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[SolicitudClienteDetalle]') 
         AND name = 'PedidoWebID'
)
BEGIN
	ALTER TABLE [dbo].[SolicitudClienteDetalle] DROP COLUMN PedidoWebID
END

IF EXISTS (
  SELECT 1 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[SolicitudClienteDetalle]') 
         AND name = 'PedidoWebDetalleID'
)
BEGIN
	ALTER TABLE [dbo].[SolicitudClienteDetalle] DROP COLUMN PedidoWebDetalleID
END

GO

/*end*/

USE BelcorpMexico
GO

IF EXISTS (
  SELECT 1 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[SolicitudCliente]') 
         AND name = 'PedidoWebID'
)
BEGIN
	ALTER TABLE [dbo].[SolicitudCliente] DROP COLUMN PedidoWebID
END

IF EXISTS (
  SELECT 1 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[SolicitudClienteDetalle]') 
         AND name = 'TipoAtencion'
)
BEGIN
	ALTER TABLE [dbo].[SolicitudClienteDetalle] DROP COLUMN TipoAtencion
END

IF EXISTS (
  SELECT 1 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[SolicitudClienteDetalle]') 
         AND name = 'PedidoWebID'
)
BEGIN
	ALTER TABLE [dbo].[SolicitudClienteDetalle] DROP COLUMN PedidoWebID
END

IF EXISTS (
  SELECT 1 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[SolicitudClienteDetalle]') 
         AND name = 'PedidoWebDetalleID'
)
BEGIN
	ALTER TABLE [dbo].[SolicitudClienteDetalle] DROP COLUMN PedidoWebDetalleID
END

GO

/*end*/

USE BelcorpEcuador
GO

IF EXISTS (
  SELECT 1 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[SolicitudCliente]') 
         AND name = 'PedidoWebID'
)
BEGIN
	ALTER TABLE [dbo].[SolicitudCliente] DROP COLUMN PedidoWebID
END

IF EXISTS (
  SELECT 1 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[SolicitudClienteDetalle]') 
         AND name = 'TipoAtencion'
)
BEGIN
	ALTER TABLE [dbo].[SolicitudClienteDetalle] DROP COLUMN TipoAtencion
END

IF EXISTS (
  SELECT 1 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[SolicitudClienteDetalle]') 
         AND name = 'PedidoWebID'
)
BEGIN
	ALTER TABLE [dbo].[SolicitudClienteDetalle] DROP COLUMN PedidoWebID
END

IF EXISTS (
  SELECT 1 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[SolicitudClienteDetalle]') 
         AND name = 'PedidoWebDetalleID'
)
BEGIN
	ALTER TABLE [dbo].[SolicitudClienteDetalle] DROP COLUMN PedidoWebDetalleID
END

GO

/*end*/

USE BelcorpCostaRica
GO

IF EXISTS (
  SELECT 1 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[SolicitudCliente]') 
         AND name = 'PedidoWebID'
)
BEGIN
	ALTER TABLE [dbo].[SolicitudCliente] DROP COLUMN PedidoWebID
END

IF EXISTS (
  SELECT 1 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[SolicitudClienteDetalle]') 
         AND name = 'TipoAtencion'
)
BEGIN
	ALTER TABLE [dbo].[SolicitudClienteDetalle] DROP COLUMN TipoAtencion
END

IF EXISTS (
  SELECT 1 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[SolicitudClienteDetalle]') 
         AND name = 'PedidoWebID'
)
BEGIN
	ALTER TABLE [dbo].[SolicitudClienteDetalle] DROP COLUMN PedidoWebID
END

IF EXISTS (
  SELECT 1 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[SolicitudClienteDetalle]') 
         AND name = 'PedidoWebDetalleID'
)
BEGIN
	ALTER TABLE [dbo].[SolicitudClienteDetalle] DROP COLUMN PedidoWebDetalleID
END

GO
