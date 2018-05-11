

USE BelcorpBolivia
GO

IF (
		 EXISTS (
			SELECT *
			FROM sys.indexes
			WHERE name = 'INDX_PedidoWebDetalle_GetPedidoWebDetalleByPedidoValidado'
				AND object_id = OBJECT_ID('dbo.PedidoWebDetalle')
			)
		)
BEGIN
	DROP INDEX INDX_PedidoWebDetalle_GetPedidoWebDetalleByPedidoValidado   
    ON dbo.PedidoWebDetalle;  
END
GO 


USE BelcorpChile
GO

IF (
		 EXISTS (
			SELECT *
			FROM sys.indexes
			WHERE name = 'INDX_PedidoWebDetalle_GetPedidoWebDetalleByPedidoValidado'
				AND object_id = OBJECT_ID('dbo.PedidoWebDetalle')
			)
		)
BEGIN
	DROP INDEX INDX_PedidoWebDetalle_GetPedidoWebDetalleByPedidoValidado   
    ON dbo.PedidoWebDetalle;  
END
GO 

USE BelcorpColombia
GO

IF (
		 EXISTS (
			SELECT *
			FROM sys.indexes
			WHERE name = 'INDX_PedidoWebDetalle_GetPedidoWebDetalleByPedidoValidado'
				AND object_id = OBJECT_ID('dbo.PedidoWebDetalle')
			)
		)
BEGIN
	DROP INDEX INDX_PedidoWebDetalle_GetPedidoWebDetalleByPedidoValidado   
    ON dbo.PedidoWebDetalle;  
END
GO 

USE BelcorpCostaRica
GO

IF (
		 EXISTS (
			SELECT *
			FROM sys.indexes
			WHERE name = 'INDX_PedidoWebDetalle_GetPedidoWebDetalleByPedidoValidado'
				AND object_id = OBJECT_ID('dbo.PedidoWebDetalle')
			)
		)
BEGIN
	DROP INDEX INDX_PedidoWebDetalle_GetPedidoWebDetalleByPedidoValidado   
    ON dbo.PedidoWebDetalle;  
END
GO 

USE BelcorpDominicana
GO

IF (
		 EXISTS (
			SELECT *
			FROM sys.indexes
			WHERE name = 'INDX_PedidoWebDetalle_GetPedidoWebDetalleByPedidoValidado'
				AND object_id = OBJECT_ID('dbo.PedidoWebDetalle')
			)
		)
BEGIN
	DROP INDEX INDX_PedidoWebDetalle_GetPedidoWebDetalleByPedidoValidado   
    ON dbo.PedidoWebDetalle;  
END
GO 

USE BelcorpEcuador
GO

IF (
		 EXISTS (
			SELECT *
			FROM sys.indexes
			WHERE name = 'INDX_PedidoWebDetalle_GetPedidoWebDetalleByPedidoValidado'
				AND object_id = OBJECT_ID('dbo.PedidoWebDetalle')
			)
		)
BEGIN
	DROP INDEX INDX_PedidoWebDetalle_GetPedidoWebDetalleByPedidoValidado   
    ON dbo.PedidoWebDetalle;  
END
GO 

USE BelcorpGuatemala
GO

IF (
		 EXISTS (
			SELECT *
			FROM sys.indexes
			WHERE name = 'INDX_PedidoWebDetalle_GetPedidoWebDetalleByPedidoValidado'
				AND object_id = OBJECT_ID('dbo.PedidoWebDetalle')
			)
		)
BEGIN
	DROP INDEX INDX_PedidoWebDetalle_GetPedidoWebDetalleByPedidoValidado   
    ON dbo.PedidoWebDetalle;  
END
GO 

USE BelcorpMexico
GO

IF (
		 EXISTS (
			SELECT *
			FROM sys.indexes
			WHERE name = 'INDX_PedidoWebDetalle_GetPedidoWebDetalleByPedidoValidado'
				AND object_id = OBJECT_ID('dbo.PedidoWebDetalle')
			)
		)
BEGIN
	DROP INDEX INDX_PedidoWebDetalle_GetPedidoWebDetalleByPedidoValidado   
    ON dbo.PedidoWebDetalle;  
END
GO 

USE BelcorpPanama
GO

IF (
		 EXISTS (
			SELECT *
			FROM sys.indexes
			WHERE name = 'INDX_PedidoWebDetalle_GetPedidoWebDetalleByPedidoValidado'
				AND object_id = OBJECT_ID('dbo.PedidoWebDetalle')
			)
		)
BEGIN
	DROP INDEX INDX_PedidoWebDetalle_GetPedidoWebDetalleByPedidoValidado   
    ON dbo.PedidoWebDetalle;  
END
GO 

USE BelcorpPeru
GO

IF (
		 EXISTS (
			SELECT *
			FROM sys.indexes
			WHERE name = 'INDX_PedidoWebDetalle_GetPedidoWebDetalleByPedidoValidado'
				AND object_id = OBJECT_ID('dbo.PedidoWebDetalle')
			)
		)
BEGIN
	DROP INDEX INDX_PedidoWebDetalle_GetPedidoWebDetalleByPedidoValidado   
    ON dbo.PedidoWebDetalle;  
END
GO 

USE BelcorpPuertoRico
GO

IF (
		 EXISTS (
			SELECT *
			FROM sys.indexes
			WHERE name = 'INDX_PedidoWebDetalle_GetPedidoWebDetalleByPedidoValidado'
				AND object_id = OBJECT_ID('dbo.PedidoWebDetalle')
			)
		)
BEGIN
	DROP INDEX INDX_PedidoWebDetalle_GetPedidoWebDetalleByPedidoValidado   
    ON dbo.PedidoWebDetalle;  
END
GO 

USE BelcorpSalvador
GO

IF (
		 EXISTS (
			SELECT *
			FROM sys.indexes
			WHERE name = 'INDX_PedidoWebDetalle_GetPedidoWebDetalleByPedidoValidado'
				AND object_id = OBJECT_ID('dbo.PedidoWebDetalle')
			)
		)
BEGIN
	DROP INDEX INDX_PedidoWebDetalle_GetPedidoWebDetalleByPedidoValidado   
    ON dbo.PedidoWebDetalle;  
END
GO 
