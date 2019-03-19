USE [BelcorpBolivia];
GO
IF EXISTS(
		  SELECT * FROM sys.objects
		  WHERE object_id=
		  OBJECT_ID(N'[dbo].[UpdCantidadProducto]')
		  AND type in (N'P',N'PC')
)
DROP PROCEDURE [dbo].[UpdCantidadProducto]
GO
CREATE PROC UpdCantidadProducto
	@PedidoWebDetalleValAuto dbo.PedidoWebDetalleValAutoType readonly
AS
BEGIN
	update PedidoWebDetalle
	SET Cantidad=T.Cantidad,
	ImporteTotal=T.Cantidad * T.PrecioUnidad
	FROM PedidoWebDetalle PWD
	inner join (
	select CampaniaID,
		   PedidoID,
		   PedidoDetalleID,
		   ConsultoraID,
		   CUV,
		   Cantidad,
		   PrecioUnidad,
		   FechaCreacion,
		   Tipo,
		   Accion,
		   MensajePROL,
		   ValAutomaticaPROLLogId,
		   CodigoObservacion,
		   TipoOrigen
		   FROM @PedidoWebDetalleValAuto
      group by
			CampaniaID,
			PedidoID,
			PedidoDetalleID,
			ConsultoraID,
		   CUV,
		   Cantidad,
		   PrecioUnidad,
		   FechaCreacion,
		   Tipo,
		   Accion,
		   MensajePROL,
		   ValAutomaticaPROLLogId,
		   CodigoObservacion,
		   TipoOrigen
	) T on
	    PWD.CampaniaID = T.CampaniaID and 
		PWD.PedidoID = T.PedidoID and 
		PWD.PedidoDetalleID = T.PedidoDetalleID;
END

GO
USE [BelcorpChile];
GO
IF EXISTS(
		  SELECT * FROM sys.objects
		  WHERE object_id=
		  OBJECT_ID(N'[dbo].[UpdCantidadProducto]')
		  AND type in (N'P',N'PC')
)
DROP PROCEDURE [dbo].[UpdCantidadProducto]
GO
CREATE PROC UpdCantidadProducto
	@PedidoWebDetalleValAuto dbo.PedidoWebDetalleValAutoType readonly
AS
BEGIN
	update PedidoWebDetalle
	SET Cantidad=T.Cantidad,
	ImporteTotal=T.Cantidad * T.PrecioUnidad
	FROM PedidoWebDetalle PWD
	inner join (
	select CampaniaID,
		   PedidoID,
		   PedidoDetalleID,
		   ConsultoraID,
		   CUV,
		   Cantidad,
		   PrecioUnidad,
		   FechaCreacion,
		   Tipo,
		   Accion,
		   MensajePROL,
		   ValAutomaticaPROLLogId,
		   CodigoObservacion,
		   TipoOrigen
		   FROM @PedidoWebDetalleValAuto
      group by
			CampaniaID,
			PedidoID,
			PedidoDetalleID,
			ConsultoraID,
		   CUV,
		   Cantidad,
		   PrecioUnidad,
		   FechaCreacion,
		   Tipo,
		   Accion,
		   MensajePROL,
		   ValAutomaticaPROLLogId,
		   CodigoObservacion,
		   TipoOrigen
	) T on
	    PWD.CampaniaID = T.CampaniaID and 
		PWD.PedidoID = T.PedidoID and 
		PWD.PedidoDetalleID = T.PedidoDetalleID;
END

GO
USE [BelcorpColombia];
GO
IF EXISTS(
		  SELECT * FROM sys.objects
		  WHERE object_id=
		  OBJECT_ID(N'[dbo].[UpdCantidadProducto]')
		  AND type in (N'P',N'PC')
)
DROP PROCEDURE [dbo].[UpdCantidadProducto]
GO
CREATE PROC UpdCantidadProducto
	@PedidoWebDetalleValAuto dbo.PedidoWebDetalleValAutoType readonly
AS
BEGIN
	update PedidoWebDetalle
	SET Cantidad=T.Cantidad,
	ImporteTotal=T.Cantidad * T.PrecioUnidad
	FROM PedidoWebDetalle PWD
	inner join (
	select CampaniaID,
		   PedidoID,
		   PedidoDetalleID,
		   ConsultoraID,
		   CUV,
		   Cantidad,
		   PrecioUnidad,
		   FechaCreacion,
		   Tipo,
		   Accion,
		   MensajePROL,
		   ValAutomaticaPROLLogId,
		   CodigoObservacion,
		   TipoOrigen
		   FROM @PedidoWebDetalleValAuto
      group by
			CampaniaID,
			PedidoID,
			PedidoDetalleID,
			ConsultoraID,
		   CUV,
		   Cantidad,
		   PrecioUnidad,
		   FechaCreacion,
		   Tipo,
		   Accion,
		   MensajePROL,
		   ValAutomaticaPROLLogId,
		   CodigoObservacion,
		   TipoOrigen
	) T on
	    PWD.CampaniaID = T.CampaniaID and 
		PWD.PedidoID = T.PedidoID and 
		PWD.PedidoDetalleID = T.PedidoDetalleID;
END

GO
USE [BelcorpCostaRica];
GO
IF EXISTS(
		  SELECT * FROM sys.objects
		  WHERE object_id=
		  OBJECT_ID(N'[dbo].[UpdCantidadProducto]')
		  AND type in (N'P',N'PC')
)
DROP PROCEDURE [dbo].[UpdCantidadProducto]
GO
CREATE PROC UpdCantidadProducto
	@PedidoWebDetalleValAuto dbo.PedidoWebDetalleValAutoType readonly
AS
BEGIN
	update PedidoWebDetalle
	SET Cantidad=T.Cantidad,
	ImporteTotal=T.Cantidad * T.PrecioUnidad
	FROM PedidoWebDetalle PWD
	inner join (
	select CampaniaID,
		   PedidoID,
		   PedidoDetalleID,
		   ConsultoraID,
		   CUV,
		   Cantidad,
		   PrecioUnidad,
		   FechaCreacion,
		   Tipo,
		   Accion,
		   MensajePROL,
		   ValAutomaticaPROLLogId,
		   CodigoObservacion,
		   TipoOrigen
		   FROM @PedidoWebDetalleValAuto
      group by
			CampaniaID,
			PedidoID,
			PedidoDetalleID,
			ConsultoraID,
		   CUV,
		   Cantidad,
		   PrecioUnidad,
		   FechaCreacion,
		   Tipo,
		   Accion,
		   MensajePROL,
		   ValAutomaticaPROLLogId,
		   CodigoObservacion,
		   TipoOrigen
	) T on
	    PWD.CampaniaID = T.CampaniaID and 
		PWD.PedidoID = T.PedidoID and 
		PWD.PedidoDetalleID = T.PedidoDetalleID;
END

GO
USE [BelcorpDominicana];
GO
IF EXISTS(
		  SELECT * FROM sys.objects
		  WHERE object_id=
		  OBJECT_ID(N'[dbo].[UpdCantidadProducto]')
		  AND type in (N'P',N'PC')
)
DROP PROCEDURE [dbo].[UpdCantidadProducto]
GO
CREATE PROC UpdCantidadProducto
	@PedidoWebDetalleValAuto dbo.PedidoWebDetalleValAutoType readonly
AS
BEGIN
	update PedidoWebDetalle
	SET Cantidad=T.Cantidad,
	ImporteTotal=T.Cantidad * T.PrecioUnidad
	FROM PedidoWebDetalle PWD
	inner join (
	select CampaniaID,
		   PedidoID,
		   PedidoDetalleID,
		   ConsultoraID,
		   CUV,
		   Cantidad,
		   PrecioUnidad,
		   FechaCreacion,
		   Tipo,
		   Accion,
		   MensajePROL,
		   ValAutomaticaPROLLogId,
		   CodigoObservacion,
		   TipoOrigen
		   FROM @PedidoWebDetalleValAuto
      group by
			CampaniaID,
			PedidoID,
			PedidoDetalleID,
			ConsultoraID,
		   CUV,
		   Cantidad,
		   PrecioUnidad,
		   FechaCreacion,
		   Tipo,
		   Accion,
		   MensajePROL,
		   ValAutomaticaPROLLogId,
		   CodigoObservacion,
		   TipoOrigen
	) T on
	    PWD.CampaniaID = T.CampaniaID and 
		PWD.PedidoID = T.PedidoID and 
		PWD.PedidoDetalleID = T.PedidoDetalleID;
END

GO
USE [BelcorpEcuador];
GO
IF EXISTS(
		  SELECT * FROM sys.objects
		  WHERE object_id=
		  OBJECT_ID(N'[dbo].[UpdCantidadProducto]')
		  AND type in (N'P',N'PC')
)
DROP PROCEDURE [dbo].[UpdCantidadProducto]
GO
CREATE PROC UpdCantidadProducto
	@PedidoWebDetalleValAuto dbo.PedidoWebDetalleValAutoType readonly
AS
BEGIN
	update PedidoWebDetalle
	SET Cantidad=T.Cantidad,
	ImporteTotal=T.Cantidad * T.PrecioUnidad
	FROM PedidoWebDetalle PWD
	inner join (
	select CampaniaID,
		   PedidoID,
		   PedidoDetalleID,
		   ConsultoraID,
		   CUV,
		   Cantidad,
		   PrecioUnidad,
		   FechaCreacion,
		   Tipo,
		   Accion,
		   MensajePROL,
		   ValAutomaticaPROLLogId,
		   CodigoObservacion,
		   TipoOrigen
		   FROM @PedidoWebDetalleValAuto
      group by
			CampaniaID,
			PedidoID,
			PedidoDetalleID,
			ConsultoraID,
		   CUV,
		   Cantidad,
		   PrecioUnidad,
		   FechaCreacion,
		   Tipo,
		   Accion,
		   MensajePROL,
		   ValAutomaticaPROLLogId,
		   CodigoObservacion,
		   TipoOrigen
	) T on
	    PWD.CampaniaID = T.CampaniaID and 
		PWD.PedidoID = T.PedidoID and 
		PWD.PedidoDetalleID = T.PedidoDetalleID;
END

GO
USE [BelcorpGuatemala];
GO
IF EXISTS(
		  SELECT * FROM sys.objects
		  WHERE object_id=
		  OBJECT_ID(N'[dbo].[UpdCantidadProducto]')
		  AND type in (N'P',N'PC')
)
DROP PROCEDURE [dbo].[UpdCantidadProducto]
GO
CREATE PROC UpdCantidadProducto
	@PedidoWebDetalleValAuto dbo.PedidoWebDetalleValAutoType readonly
AS
BEGIN
	update PedidoWebDetalle
	SET Cantidad=T.Cantidad,
	ImporteTotal=T.Cantidad * T.PrecioUnidad
	FROM PedidoWebDetalle PWD
	inner join (
	select CampaniaID,
		   PedidoID,
		   PedidoDetalleID,
		   ConsultoraID,
		   CUV,
		   Cantidad,
		   PrecioUnidad,
		   FechaCreacion,
		   Tipo,
		   Accion,
		   MensajePROL,
		   ValAutomaticaPROLLogId,
		   CodigoObservacion,
		   TipoOrigen
		   FROM @PedidoWebDetalleValAuto
      group by
			CampaniaID,
			PedidoID,
			PedidoDetalleID,
			ConsultoraID,
		   CUV,
		   Cantidad,
		   PrecioUnidad,
		   FechaCreacion,
		   Tipo,
		   Accion,
		   MensajePROL,
		   ValAutomaticaPROLLogId,
		   CodigoObservacion,
		   TipoOrigen
	) T on
	    PWD.CampaniaID = T.CampaniaID and 
		PWD.PedidoID = T.PedidoID and 
		PWD.PedidoDetalleID = T.PedidoDetalleID;
END

GO
USE [BelcorpMexico];
GO
IF EXISTS(
		  SELECT * FROM sys.objects
		  WHERE object_id=
		  OBJECT_ID(N'[dbo].[UpdCantidadProducto]')
		  AND type in (N'P',N'PC')
)
DROP PROCEDURE [dbo].[UpdCantidadProducto]
GO
CREATE PROC UpdCantidadProducto
	@PedidoWebDetalleValAuto dbo.PedidoWebDetalleValAutoType readonly
AS
BEGIN
	update PedidoWebDetalle
	SET Cantidad=T.Cantidad,
	ImporteTotal=T.Cantidad * T.PrecioUnidad
	FROM PedidoWebDetalle PWD
	inner join (
	select CampaniaID,
		   PedidoID,
		   PedidoDetalleID,
		   ConsultoraID,
		   CUV,
		   Cantidad,
		   PrecioUnidad,
		   FechaCreacion,
		   Tipo,
		   Accion,
		   MensajePROL,
		   ValAutomaticaPROLLogId,
		   CodigoObservacion,
		   TipoOrigen
		   FROM @PedidoWebDetalleValAuto
      group by
			CampaniaID,
			PedidoID,
			PedidoDetalleID,
			ConsultoraID,
		   CUV,
		   Cantidad,
		   PrecioUnidad,
		   FechaCreacion,
		   Tipo,
		   Accion,
		   MensajePROL,
		   ValAutomaticaPROLLogId,
		   CodigoObservacion,
		   TipoOrigen
	) T on
	    PWD.CampaniaID = T.CampaniaID and 
		PWD.PedidoID = T.PedidoID and 
		PWD.PedidoDetalleID = T.PedidoDetalleID;
END

GO
USE [BelcorpPanama];
GO
IF EXISTS(
		  SELECT * FROM sys.objects
		  WHERE object_id=
		  OBJECT_ID(N'[dbo].[UpdCantidadProducto]')
		  AND type in (N'P',N'PC')
)
DROP PROCEDURE [dbo].[UpdCantidadProducto]
GO
CREATE PROC UpdCantidadProducto
	@PedidoWebDetalleValAuto dbo.PedidoWebDetalleValAutoType readonly
AS
BEGIN
	update PedidoWebDetalle
	SET Cantidad=T.Cantidad,
	ImporteTotal=T.Cantidad * T.PrecioUnidad
	FROM PedidoWebDetalle PWD
	inner join (
	select CampaniaID,
		   PedidoID,
		   PedidoDetalleID,
		   ConsultoraID,
		   CUV,
		   Cantidad,
		   PrecioUnidad,
		   FechaCreacion,
		   Tipo,
		   Accion,
		   MensajePROL,
		   ValAutomaticaPROLLogId,
		   CodigoObservacion,
		   TipoOrigen
		   FROM @PedidoWebDetalleValAuto
      group by
			CampaniaID,
			PedidoID,
			PedidoDetalleID,
			ConsultoraID,
		   CUV,
		   Cantidad,
		   PrecioUnidad,
		   FechaCreacion,
		   Tipo,
		   Accion,
		   MensajePROL,
		   ValAutomaticaPROLLogId,
		   CodigoObservacion,
		   TipoOrigen
	) T on
	    PWD.CampaniaID = T.CampaniaID and 
		PWD.PedidoID = T.PedidoID and 
		PWD.PedidoDetalleID = T.PedidoDetalleID;
END

GO
USE [BelcorpPeru];
GO
IF EXISTS(
		  SELECT * FROM sys.objects
		  WHERE object_id=
		  OBJECT_ID(N'[dbo].[UpdCantidadProducto]')
		  AND type in (N'P',N'PC')
)
DROP PROCEDURE [dbo].[UpdCantidadProducto]
GO
CREATE PROC UpdCantidadProducto
	@PedidoWebDetalleValAuto dbo.PedidoWebDetalleValAutoType readonly
AS
BEGIN
	update PedidoWebDetalle
	SET Cantidad=T.Cantidad,
	ImporteTotal=T.Cantidad * T.PrecioUnidad
	FROM PedidoWebDetalle PWD
	inner join (
	select CampaniaID,
		   PedidoID,
		   PedidoDetalleID,
		   ConsultoraID,
		   CUV,
		   Cantidad,
		   PrecioUnidad,
		   FechaCreacion,
		   Tipo,
		   Accion,
		   MensajePROL,
		   ValAutomaticaPROLLogId,
		   CodigoObservacion,
		   TipoOrigen
		   FROM @PedidoWebDetalleValAuto
      group by
			CampaniaID,
			PedidoID,
			PedidoDetalleID,
			ConsultoraID,
		   CUV,
		   Cantidad,
		   PrecioUnidad,
		   FechaCreacion,
		   Tipo,
		   Accion,
		   MensajePROL,
		   ValAutomaticaPROLLogId,
		   CodigoObservacion,
		   TipoOrigen
	) T on
	    PWD.CampaniaID = T.CampaniaID and 
		PWD.PedidoID = T.PedidoID and 
		PWD.PedidoDetalleID = T.PedidoDetalleID;
END

GO
USE [BelcorpPuertoRico];
GO
IF EXISTS(
		  SELECT * FROM sys.objects
		  WHERE object_id=
		  OBJECT_ID(N'[dbo].[UpdCantidadProducto]')
		  AND type in (N'P',N'PC')
)
DROP PROCEDURE [dbo].[UpdCantidadProducto]
GO
CREATE PROC UpdCantidadProducto
	@PedidoWebDetalleValAuto dbo.PedidoWebDetalleValAutoType readonly
AS
BEGIN
	update PedidoWebDetalle
	SET Cantidad=T.Cantidad,
	ImporteTotal=T.Cantidad * T.PrecioUnidad
	FROM PedidoWebDetalle PWD
	inner join (
	select CampaniaID,
		   PedidoID,
		   PedidoDetalleID,
		   ConsultoraID,
		   CUV,
		   Cantidad,
		   PrecioUnidad,
		   FechaCreacion,
		   Tipo,
		   Accion,
		   MensajePROL,
		   ValAutomaticaPROLLogId,
		   CodigoObservacion,
		   TipoOrigen
		   FROM @PedidoWebDetalleValAuto
      group by
			CampaniaID,
			PedidoID,
			PedidoDetalleID,
			ConsultoraID,
		   CUV,
		   Cantidad,
		   PrecioUnidad,
		   FechaCreacion,
		   Tipo,
		   Accion,
		   MensajePROL,
		   ValAutomaticaPROLLogId,
		   CodigoObservacion,
		   TipoOrigen
	) T on
	    PWD.CampaniaID = T.CampaniaID and 
		PWD.PedidoID = T.PedidoID and 
		PWD.PedidoDetalleID = T.PedidoDetalleID;
END

GO
USE [BelcorpSalvador];
GO
IF EXISTS(
		  SELECT * FROM sys.objects
		  WHERE object_id=
		  OBJECT_ID(N'[dbo].[UpdCantidadProducto]')
		  AND type in (N'P',N'PC')
)
DROP PROCEDURE [dbo].[UpdCantidadProducto]
GO
CREATE PROC UpdCantidadProducto
	@PedidoWebDetalleValAuto dbo.PedidoWebDetalleValAutoType readonly
AS
BEGIN
	update PedidoWebDetalle
	SET Cantidad=T.Cantidad,
	ImporteTotal=T.Cantidad * T.PrecioUnidad
	FROM PedidoWebDetalle PWD
	inner join (
	select CampaniaID,
		   PedidoID,
		   PedidoDetalleID,
		   ConsultoraID,
		   CUV,
		   Cantidad,
		   PrecioUnidad,
		   FechaCreacion,
		   Tipo,
		   Accion,
		   MensajePROL,
		   ValAutomaticaPROLLogId,
		   CodigoObservacion,
		   TipoOrigen
		   FROM @PedidoWebDetalleValAuto
      group by
			CampaniaID,
			PedidoID,
			PedidoDetalleID,
			ConsultoraID,
		   CUV,
		   Cantidad,
		   PrecioUnidad,
		   FechaCreacion,
		   Tipo,
		   Accion,
		   MensajePROL,
		   ValAutomaticaPROLLogId,
		   CodigoObservacion,
		   TipoOrigen
	) T on
	    PWD.CampaniaID = T.CampaniaID and 
		PWD.PedidoID = T.PedidoID and 
		PWD.PedidoDetalleID = T.PedidoDetalleID;
END

GO
