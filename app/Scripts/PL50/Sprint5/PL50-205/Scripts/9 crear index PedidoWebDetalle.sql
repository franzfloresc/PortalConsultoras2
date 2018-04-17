USE BelcorpBolivia
GO

IF (
		 NOT EXISTS (
			SELECT *
			FROM sys.indexes
			WHERE name = 'INDX_PedidoWebDetalle_GetPedidoWebDetalleByPedidoValidado'
				AND object_id = OBJECT_ID('dbo.PedidoWebDetalle')
			)
		)
BEGIN
	CREATE NONCLUSTERED INDEX INDX_PedidoWebDetalle_GetPedidoWebDetalleByPedidoValidado ON [dbo].[PedidoWebDetalle] ([PedidoID]) INCLUDE (
		[CampaniaID]
		,[ClienteID]
		,[CUV]
		,[OfertaWeb]
		,[ConfiguracionOfertaID]
		,[TipoOfertaSisID]
		,[TipoPedido]
		,[ModificaPedidoReservadoMovil]
		,[ObservacionPROL]
		,[OrigenPedidoWeb]
		,[EsBackOrder]
		,[AceptoBackOrder]
		,[TipoEstrategiaID]
		)
END
GO
USE BelcorpChile
GO

IF (
		 NOT EXISTS (
			SELECT *
			FROM sys.indexes
			WHERE name = 'INDX_PedidoWebDetalle_GetPedidoWebDetalleByPedidoValidado'
				AND object_id = OBJECT_ID('dbo.PedidoWebDetalle')
			)
		)
BEGIN
	CREATE NONCLUSTERED INDEX INDX_PedidoWebDetalle_GetPedidoWebDetalleByPedidoValidado ON [dbo].[PedidoWebDetalle] ([PedidoID]) INCLUDE (
		[CampaniaID]
		,[ClienteID]
		,[CUV]
		,[OfertaWeb]
		,[ConfiguracionOfertaID]
		,[TipoOfertaSisID]
		,[TipoPedido]
		,[ModificaPedidoReservadoMovil]
		,[ObservacionPROL]
		,[OrigenPedidoWeb]
		,[EsBackOrder]
		,[AceptoBackOrder]
		,[TipoEstrategiaID]
		)
END
GO
USE BelcorpColombia
GO

IF (
		 NOT EXISTS (
			SELECT *
			FROM sys.indexes
			WHERE name = 'INDX_PedidoWebDetalle_GetPedidoWebDetalleByPedidoValidado'
				AND object_id = OBJECT_ID('dbo.PedidoWebDetalle')
			)
		)
BEGIN
	CREATE NONCLUSTERED INDEX INDX_PedidoWebDetalle_GetPedidoWebDetalleByPedidoValidado ON [dbo].[PedidoWebDetalle] ([PedidoID]) INCLUDE (
		[CampaniaID]
		,[ClienteID]
		,[CUV]
		,[OfertaWeb]
		,[ConfiguracionOfertaID]
		,[TipoOfertaSisID]
		,[TipoPedido]
		,[ModificaPedidoReservadoMovil]
		,[ObservacionPROL]
		,[OrigenPedidoWeb]
		,[EsBackOrder]
		,[AceptoBackOrder]
		,[TipoEstrategiaID]
		)
END
GO
USE BelcorpCostaRica
GO

IF (
		 NOT EXISTS (
			SELECT *
			FROM sys.indexes
			WHERE name = 'INDX_PedidoWebDetalle_GetPedidoWebDetalleByPedidoValidado'
				AND object_id = OBJECT_ID('dbo.PedidoWebDetalle')
			)
		)
BEGIN
	CREATE NONCLUSTERED INDEX INDX_PedidoWebDetalle_GetPedidoWebDetalleByPedidoValidado ON [dbo].[PedidoWebDetalle] ([PedidoID]) INCLUDE (
		[CampaniaID]
		,[ClienteID]
		,[CUV]
		,[OfertaWeb]
		,[ConfiguracionOfertaID]
		,[TipoOfertaSisID]
		,[TipoPedido]
		,[ModificaPedidoReservadoMovil]
		,[ObservacionPROL]
		,[OrigenPedidoWeb]
		,[EsBackOrder]
		,[AceptoBackOrder]
		,[TipoEstrategiaID]
		)
END
GO
USE BelcorpDominicana
GO

IF (
		 NOT EXISTS (
			SELECT *
			FROM sys.indexes
			WHERE name = 'INDX_PedidoWebDetalle_GetPedidoWebDetalleByPedidoValidado'
				AND object_id = OBJECT_ID('dbo.PedidoWebDetalle')
			)
		)
BEGIN
	CREATE NONCLUSTERED INDEX INDX_PedidoWebDetalle_GetPedidoWebDetalleByPedidoValidado ON [dbo].[PedidoWebDetalle] ([PedidoID]) INCLUDE (
		[CampaniaID]
		,[ClienteID]
		,[CUV]
		,[OfertaWeb]
		,[ConfiguracionOfertaID]
		,[TipoOfertaSisID]
		,[TipoPedido]
		,[ModificaPedidoReservadoMovil]
		,[ObservacionPROL]
		,[OrigenPedidoWeb]
		,[EsBackOrder]
		,[AceptoBackOrder]
		,[TipoEstrategiaID]
		)
END
GO
USE BelcorpEcuador
GO

IF (
		 NOT EXISTS (
			SELECT *
			FROM sys.indexes
			WHERE name = 'INDX_PedidoWebDetalle_GetPedidoWebDetalleByPedidoValidado'
				AND object_id = OBJECT_ID('dbo.PedidoWebDetalle')
			)
		)
BEGIN
	CREATE NONCLUSTERED INDEX INDX_PedidoWebDetalle_GetPedidoWebDetalleByPedidoValidado ON [dbo].[PedidoWebDetalle] ([PedidoID]) INCLUDE (
		[CampaniaID]
		,[ClienteID]
		,[CUV]
		,[OfertaWeb]
		,[ConfiguracionOfertaID]
		,[TipoOfertaSisID]
		,[TipoPedido]
		,[ModificaPedidoReservadoMovil]
		,[ObservacionPROL]
		,[OrigenPedidoWeb]
		,[EsBackOrder]
		,[AceptoBackOrder]
		,[TipoEstrategiaID]
		)
END
GO
USE BelcorpGuatemala
GO

IF (
		 NOT EXISTS (
			SELECT *
			FROM sys.indexes
			WHERE name = 'INDX_PedidoWebDetalle_GetPedidoWebDetalleByPedidoValidado'
				AND object_id = OBJECT_ID('dbo.PedidoWebDetalle')
			)
		)
BEGIN
	CREATE NONCLUSTERED INDEX INDX_PedidoWebDetalle_GetPedidoWebDetalleByPedidoValidado ON [dbo].[PedidoWebDetalle] ([PedidoID]) INCLUDE (
		[CampaniaID]
		,[ClienteID]
		,[CUV]
		,[OfertaWeb]
		,[ConfiguracionOfertaID]
		,[TipoOfertaSisID]
		,[TipoPedido]
		,[ModificaPedidoReservadoMovil]
		,[ObservacionPROL]
		,[OrigenPedidoWeb]
		,[EsBackOrder]
		,[AceptoBackOrder]
		,[TipoEstrategiaID]
		)
END
GO
USE BelcorpMexico
GO

IF (
		 NOT EXISTS (
			SELECT *
			FROM sys.indexes
			WHERE name = 'INDX_PedidoWebDetalle_GetPedidoWebDetalleByPedidoValidado'
				AND object_id = OBJECT_ID('dbo.PedidoWebDetalle')
			)
		)
BEGIN
	CREATE NONCLUSTERED INDEX INDX_PedidoWebDetalle_GetPedidoWebDetalleByPedidoValidado ON [dbo].[PedidoWebDetalle] ([PedidoID]) INCLUDE (
		[CampaniaID]
		,[ClienteID]
		,[CUV]
		,[OfertaWeb]
		,[ConfiguracionOfertaID]
		,[TipoOfertaSisID]
		,[TipoPedido]
		,[ModificaPedidoReservadoMovil]
		,[ObservacionPROL]
		,[OrigenPedidoWeb]
		,[EsBackOrder]
		,[AceptoBackOrder]
		,[TipoEstrategiaID]
		)
END
GO
USE BelcorPanama
GO

IF (
		 NOT EXISTS (
			SELECT *
			FROM sys.indexes
			WHERE name = 'INDX_PedidoWebDetalle_GetPedidoWebDetalleByPedidoValidado'
				AND object_id = OBJECT_ID('dbo.PedidoWebDetalle')
			)
		)
BEGIN
	CREATE NONCLUSTERED INDEX INDX_PedidoWebDetalle_GetPedidoWebDetalleByPedidoValidado ON [dbo].[PedidoWebDetalle] ([PedidoID]) INCLUDE (
		[CampaniaID]
		,[ClienteID]
		,[CUV]
		,[OfertaWeb]
		,[ConfiguracionOfertaID]
		,[TipoOfertaSisID]
		,[TipoPedido]
		,[ModificaPedidoReservadoMovil]
		,[ObservacionPROL]
		,[OrigenPedidoWeb]
		,[EsBackOrder]
		,[AceptoBackOrder]
		,[TipoEstrategiaID]
		)
END
GO
USE BelcorpPeru
GO

IF (
		 NOT EXISTS (
			SELECT *
			FROM sys.indexes
			WHERE name = 'INDX_PedidoWebDetalle_GetPedidoWebDetalleByPedidoValidado'
				AND object_id = OBJECT_ID('dbo.PedidoWebDetalle')
			)
		)
BEGIN
	CREATE NONCLUSTERED INDEX INDX_PedidoWebDetalle_GetPedidoWebDetalleByPedidoValidado ON [dbo].[PedidoWebDetalle] ([PedidoID]) INCLUDE (
		[CampaniaID]
		,[ClienteID]
		,[CUV]
		,[OfertaWeb]
		,[ConfiguracionOfertaID]
		,[TipoOfertaSisID]
		,[TipoPedido]
		,[ModificaPedidoReservadoMovil]
		,[ObservacionPROL]
		,[OrigenPedidoWeb]
		,[EsBackOrder]
		,[AceptoBackOrder]
		,[TipoEstrategiaID]
		)
END
GO
USE BelcorpPuertoRico
GO

IF (
		 NOT EXISTS (
			SELECT *
			FROM sys.indexes
			WHERE name = 'INDX_PedidoWebDetalle_GetPedidoWebDetalleByPedidoValidado'
				AND object_id = OBJECT_ID('dbo.PedidoWebDetalle')
			)
		)
BEGIN
	CREATE NONCLUSTERED INDEX INDX_PedidoWebDetalle_GetPedidoWebDetalleByPedidoValidado ON [dbo].[PedidoWebDetalle] ([PedidoID]) INCLUDE (
		[CampaniaID]
		,[ClienteID]
		,[CUV]
		,[OfertaWeb]
		,[ConfiguracionOfertaID]
		,[TipoOfertaSisID]
		,[TipoPedido]
		,[ModificaPedidoReservadoMovil]
		,[ObservacionPROL]
		,[OrigenPedidoWeb]
		,[EsBackOrder]
		,[AceptoBackOrder]
		,[TipoEstrategiaID]
		)
END
GO
USE BelcorpSalvador
GO

IF (
		 NOT EXISTS (
			SELECT *
			FROM sys.indexes
			WHERE name = 'INDX_PedidoWebDetalle_GetPedidoWebDetalleByPedidoValidado'
				AND object_id = OBJECT_ID('dbo.PedidoWebDetalle')
			)
		)
BEGIN
	CREATE NONCLUSTERED INDEX INDX_PedidoWebDetalle_GetPedidoWebDetalleByPedidoValidado ON [dbo].[PedidoWebDetalle] ([PedidoID]) INCLUDE (
		[CampaniaID]
		,[ClienteID]
		,[CUV]
		,[OfertaWeb]
		,[ConfiguracionOfertaID]
		,[TipoOfertaSisID]
		,[TipoPedido]
		,[ModificaPedidoReservadoMovil]
		,[ObservacionPROL]
		,[OrigenPedidoWeb]
		,[EsBackOrder]
		,[AceptoBackOrder]
		,[TipoEstrategiaID]
		)
END
GO
