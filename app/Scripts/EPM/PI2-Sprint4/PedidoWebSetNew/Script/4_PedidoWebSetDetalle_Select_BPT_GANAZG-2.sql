﻿USE [BelcorpPeru_BPT]
GO
/****** Object:  StoredProcedure [dbo].[PedidoWebSetDetalle_Select]    Script Date: 27/11/2018 12:10:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[PedidoWebSetDetalle_Select] @SetId INT
AS
BEGIN
	SELECT SetDetalleID
		,SetID
		,CuvProducto
		--,NombreProducto
		,Cantidad
		--,CantidadOriginal
		,FactorRepeticion
		,PedidoDetalleID
		,PrecioUnidad
		--,TipoOfertaSisID
	FROM PedidoWebSetDetalle
	WHERE SetId = @SetId
END
GO

USE [BelcorpChile_BPT]
GO
/****** Object:  StoredProcedure [dbo].[PedidoWebSetDetalle_Select]    Script Date: 27/11/2018 12:10:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[PedidoWebSetDetalle_Select] @SetId INT
AS
BEGIN
	SELECT SetDetalleID
		,SetID
		,CuvProducto
		--,NombreProducto
		,Cantidad
		--,CantidadOriginal
		,FactorRepeticion
		,PedidoDetalleID
		,PrecioUnidad
		--,TipoOfertaSisID
	FROM PedidoWebSetDetalle
	WHERE SetId = @SetId
END
GO

USE [BelcorpCostaRica_BPT]
GO
/****** Object:  StoredProcedure [dbo].[PedidoWebSetDetalle_Select]    Script Date: 27/11/2018 12:10:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[PedidoWebSetDetalle_Select] @SetId INT
AS
BEGIN
	SELECT SetDetalleID
		,SetID
		,CuvProducto
		--,NombreProducto
		,Cantidad
		--,CantidadOriginal
		,FactorRepeticion
		,PedidoDetalleID
		,PrecioUnidad
		--,TipoOfertaSisID
	FROM PedidoWebSetDetalle
	WHERE SetId = @SetId
END
GO