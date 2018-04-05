USE BelcorpPeru
GO

IF OBJECT_ID('dbo.PedidoWebSet_Select', 'P') IS NOT NULL
	DROP PROC dbo.PedidoWebSet_Select
GO
CREATE PROCEDURE PedidoWebSet_Select @SetId INT
AS
BEGIN
	SELECT SetID
		,PedidoID
		,CuvSet
		,EstrategiaId
		,NombreSet
		,Cantidad
		,PrecioUnidad
		,ImporteTotal
		,TipoEstrategiaId
		,Campania
		,ConsultoraID
		,OrdenPedido
		,CodigoUsuarioCreacion
		,CodigoUsuarioModificacion
		,FechaCreacion
		,FechaModificacion
	FROM PedidoWebSet
	WHERE SetId = @SetId
END
GO

IF OBJECT_ID('dbo.PedidoWebSetDetalle_Select', 'P') IS NOT NULL
	DROP PROC dbo.PedidoWebSetDetalle_Select
GO
CREATE PROCEDURE PedidoWebSetDetalle_Select @SetId INT
AS
BEGIN
	SELECT SetDetalleID
		,SetID
		,CuvProducto
		,NombreProducto
		,Cantidad
		,CantidadOriginal
		,FactorRepeticion
		,PedidoDetalleID
		,PrecioUnidad
		,TipoOfertaSisID
	FROM PedidoWebSetDetalle
	WHERE SetId = @SetId
END
GO

IF OBJECT_ID('dbo.PedidoWebSet_Eliminar', 'P') IS NOT NULL
	DROP PROC dbo.PedidoWebSet_Eliminar
GO
CREATE PROCEDURE PedidoWebSet_Eliminar @SetId INT
AS
BEGIN
	BEGIN TRAN

	BEGIN TRY
		DELETE
		FROM PedidoWebSetDetalle
		WHERE SetId = @SetId

		DELETE
		FROM PedidoWebSet
		WHERE SetId = @setID

		COMMIT
	END TRY

	BEGIN CATCH
		ROLLBACK
	END CATCH
END

GO

USE BelcorpMexico
GO

IF OBJECT_ID('dbo.PedidoWebSet_Select', 'P') IS NOT NULL
	DROP PROC dbo.PedidoWebSet_Select
GO
CREATE PROCEDURE PedidoWebSet_Select @SetId INT
AS
BEGIN
	SELECT SetID
		,PedidoID
		,CuvSet
		,EstrategiaId
		,NombreSet
		,Cantidad
		,PrecioUnidad
		,ImporteTotal
		,TipoEstrategiaId
		,Campania
		,ConsultoraID
		,OrdenPedido
		,CodigoUsuarioCreacion
		,CodigoUsuarioModificacion
		,FechaCreacion
		,FechaModificacion
	FROM PedidoWebSet
	WHERE SetId = @SetId
END
GO

IF OBJECT_ID('dbo.PedidoWebSetDetalle_Select', 'P') IS NOT NULL
	DROP PROC dbo.PedidoWebSetDetalle_Select
GO
CREATE PROCEDURE PedidoWebSetDetalle_Select @SetId INT
AS
BEGIN
	SELECT SetDetalleID
		,SetID
		,CuvProducto
		,NombreProducto
		,Cantidad
		,CantidadOriginal
		,FactorRepeticion
		,PedidoDetalleID
		,PrecioUnidad
		,TipoOfertaSisID
	FROM PedidoWebSetDetalle
	WHERE SetId = @SetId
END
GO

IF OBJECT_ID('dbo.PedidoWebSet_Eliminar', 'P') IS NOT NULL
	DROP PROC dbo.PedidoWebSet_Eliminar
GO
CREATE PROCEDURE PedidoWebSet_Eliminar @SetId INT
AS
BEGIN
	BEGIN TRAN

	BEGIN TRY
		DELETE
		FROM PedidoWebSetDetalle
		WHERE SetId = @SetId

		DELETE
		FROM PedidoWebSet
		WHERE SetId = @setID

		COMMIT
	END TRY

	BEGIN CATCH
		ROLLBACK
	END CATCH
END

GO

USE BelcorpColombia
GO

IF OBJECT_ID('dbo.PedidoWebSet_Select', 'P') IS NOT NULL
	DROP PROC dbo.PedidoWebSet_Select
GO
CREATE PROCEDURE PedidoWebSet_Select @SetId INT
AS
BEGIN
	SELECT SetID
		,PedidoID
		,CuvSet
		,EstrategiaId
		,NombreSet
		,Cantidad
		,PrecioUnidad
		,ImporteTotal
		,TipoEstrategiaId
		,Campania
		,ConsultoraID
		,OrdenPedido
		,CodigoUsuarioCreacion
		,CodigoUsuarioModificacion
		,FechaCreacion
		,FechaModificacion
	FROM PedidoWebSet
	WHERE SetId = @SetId
END
GO

IF OBJECT_ID('dbo.PedidoWebSetDetalle_Select', 'P') IS NOT NULL
	DROP PROC dbo.PedidoWebSetDetalle_Select
GO
CREATE PROCEDURE PedidoWebSetDetalle_Select @SetId INT
AS
BEGIN
	SELECT SetDetalleID
		,SetID
		,CuvProducto
		,NombreProducto
		,Cantidad
		,CantidadOriginal
		,FactorRepeticion
		,PedidoDetalleID
		,PrecioUnidad
		,TipoOfertaSisID
	FROM PedidoWebSetDetalle
	WHERE SetId = @SetId
END
GO

IF OBJECT_ID('dbo.PedidoWebSet_Eliminar', 'P') IS NOT NULL
	DROP PROC dbo.PedidoWebSet_Eliminar
GO
CREATE PROCEDURE PedidoWebSet_Eliminar @SetId INT
AS
BEGIN
	BEGIN TRAN

	BEGIN TRY
		DELETE
		FROM PedidoWebSetDetalle
		WHERE SetId = @SetId

		DELETE
		FROM PedidoWebSet
		WHERE SetId = @setID

		COMMIT
	END TRY

	BEGIN CATCH
		ROLLBACK
	END CATCH
END

GO

USE BelcorpSalvador
GO

IF OBJECT_ID('dbo.PedidoWebSet_Select', 'P') IS NOT NULL
	DROP PROC dbo.PedidoWebSet_Select
GO
CREATE PROCEDURE PedidoWebSet_Select @SetId INT
AS
BEGIN
	SELECT SetID
		,PedidoID
		,CuvSet
		,EstrategiaId
		,NombreSet
		,Cantidad
		,PrecioUnidad
		,ImporteTotal
		,TipoEstrategiaId
		,Campania
		,ConsultoraID
		,OrdenPedido
		,CodigoUsuarioCreacion
		,CodigoUsuarioModificacion
		,FechaCreacion
		,FechaModificacion
	FROM PedidoWebSet
	WHERE SetId = @SetId
END
GO

IF OBJECT_ID('dbo.PedidoWebSetDetalle_Select', 'P') IS NOT NULL
	DROP PROC dbo.PedidoWebSetDetalle_Select
GO
CREATE PROCEDURE PedidoWebSetDetalle_Select @SetId INT
AS
BEGIN
	SELECT SetDetalleID
		,SetID
		,CuvProducto
		,NombreProducto
		,Cantidad
		,CantidadOriginal
		,FactorRepeticion
		,PedidoDetalleID
		,PrecioUnidad
		,TipoOfertaSisID
	FROM PedidoWebSetDetalle
	WHERE SetId = @SetId
END
GO

IF OBJECT_ID('dbo.PedidoWebSet_Eliminar', 'P') IS NOT NULL
	DROP PROC dbo.PedidoWebSet_Eliminar
GO
CREATE PROCEDURE PedidoWebSet_Eliminar @SetId INT
AS
BEGIN
	BEGIN TRAN

	BEGIN TRY
		DELETE
		FROM PedidoWebSetDetalle
		WHERE SetId = @SetId

		DELETE
		FROM PedidoWebSet
		WHERE SetId = @setID

		COMMIT
	END TRY

	BEGIN CATCH
		ROLLBACK
	END CATCH
END

GO

USE BelcorpPuertoRico
GO

IF OBJECT_ID('dbo.PedidoWebSet_Select', 'P') IS NOT NULL
	DROP PROC dbo.PedidoWebSet_Select
GO
CREATE PROCEDURE PedidoWebSet_Select @SetId INT
AS
BEGIN
	SELECT SetID
		,PedidoID
		,CuvSet
		,EstrategiaId
		,NombreSet
		,Cantidad
		,PrecioUnidad
		,ImporteTotal
		,TipoEstrategiaId
		,Campania
		,ConsultoraID
		,OrdenPedido
		,CodigoUsuarioCreacion
		,CodigoUsuarioModificacion
		,FechaCreacion
		,FechaModificacion
	FROM PedidoWebSet
	WHERE SetId = @SetId
END
GO

IF OBJECT_ID('dbo.PedidoWebSetDetalle_Select', 'P') IS NOT NULL
	DROP PROC dbo.PedidoWebSetDetalle_Select
GO
CREATE PROCEDURE PedidoWebSetDetalle_Select @SetId INT
AS
BEGIN
	SELECT SetDetalleID
		,SetID
		,CuvProducto
		,NombreProducto
		,Cantidad
		,CantidadOriginal
		,FactorRepeticion
		,PedidoDetalleID
		,PrecioUnidad
		,TipoOfertaSisID
	FROM PedidoWebSetDetalle
	WHERE SetId = @SetId
END
GO

IF OBJECT_ID('dbo.PedidoWebSet_Eliminar', 'P') IS NOT NULL
	DROP PROC dbo.PedidoWebSet_Eliminar
GO
CREATE PROCEDURE PedidoWebSet_Eliminar @SetId INT
AS
BEGIN
	BEGIN TRAN

	BEGIN TRY
		DELETE
		FROM PedidoWebSetDetalle
		WHERE SetId = @SetId

		DELETE
		FROM PedidoWebSet
		WHERE SetId = @setID

		COMMIT
	END TRY

	BEGIN CATCH
		ROLLBACK
	END CATCH
END

GO

USE BelcorpPanama
GO

IF OBJECT_ID('dbo.PedidoWebSet_Select', 'P') IS NOT NULL
	DROP PROC dbo.PedidoWebSet_Select
GO
CREATE PROCEDURE PedidoWebSet_Select @SetId INT
AS
BEGIN
	SELECT SetID
		,PedidoID
		,CuvSet
		,EstrategiaId
		,NombreSet
		,Cantidad
		,PrecioUnidad
		,ImporteTotal
		,TipoEstrategiaId
		,Campania
		,ConsultoraID
		,OrdenPedido
		,CodigoUsuarioCreacion
		,CodigoUsuarioModificacion
		,FechaCreacion
		,FechaModificacion
	FROM PedidoWebSet
	WHERE SetId = @SetId
END
GO

IF OBJECT_ID('dbo.PedidoWebSetDetalle_Select', 'P') IS NOT NULL
	DROP PROC dbo.PedidoWebSetDetalle_Select
GO
CREATE PROCEDURE PedidoWebSetDetalle_Select @SetId INT
AS
BEGIN
	SELECT SetDetalleID
		,SetID
		,CuvProducto
		,NombreProducto
		,Cantidad
		,CantidadOriginal
		,FactorRepeticion
		,PedidoDetalleID
		,PrecioUnidad
		,TipoOfertaSisID
	FROM PedidoWebSetDetalle
	WHERE SetId = @SetId
END
GO

IF OBJECT_ID('dbo.PedidoWebSet_Eliminar', 'P') IS NOT NULL
	DROP PROC dbo.PedidoWebSet_Eliminar
GO
CREATE PROCEDURE PedidoWebSet_Eliminar @SetId INT
AS
BEGIN
	BEGIN TRAN

	BEGIN TRY
		DELETE
		FROM PedidoWebSetDetalle
		WHERE SetId = @SetId

		DELETE
		FROM PedidoWebSet
		WHERE SetId = @setID

		COMMIT
	END TRY

	BEGIN CATCH
		ROLLBACK
	END CATCH
END

GO

USE BelcorpGuatemala
GO

IF OBJECT_ID('dbo.PedidoWebSet_Select', 'P') IS NOT NULL
	DROP PROC dbo.PedidoWebSet_Select
GO
CREATE PROCEDURE PedidoWebSet_Select @SetId INT
AS
BEGIN
	SELECT SetID
		,PedidoID
		,CuvSet
		,EstrategiaId
		,NombreSet
		,Cantidad
		,PrecioUnidad
		,ImporteTotal
		,TipoEstrategiaId
		,Campania
		,ConsultoraID
		,OrdenPedido
		,CodigoUsuarioCreacion
		,CodigoUsuarioModificacion
		,FechaCreacion
		,FechaModificacion
	FROM PedidoWebSet
	WHERE SetId = @SetId
END
GO

IF OBJECT_ID('dbo.PedidoWebSetDetalle_Select', 'P') IS NOT NULL
	DROP PROC dbo.PedidoWebSetDetalle_Select
GO
CREATE PROCEDURE PedidoWebSetDetalle_Select @SetId INT
AS
BEGIN
	SELECT SetDetalleID
		,SetID
		,CuvProducto
		,NombreProducto
		,Cantidad
		,CantidadOriginal
		,FactorRepeticion
		,PedidoDetalleID
		,PrecioUnidad
		,TipoOfertaSisID
	FROM PedidoWebSetDetalle
	WHERE SetId = @SetId
END
GO

IF OBJECT_ID('dbo.PedidoWebSet_Eliminar', 'P') IS NOT NULL
	DROP PROC dbo.PedidoWebSet_Eliminar
GO
CREATE PROCEDURE PedidoWebSet_Eliminar @SetId INT
AS
BEGIN
	BEGIN TRAN

	BEGIN TRY
		DELETE
		FROM PedidoWebSetDetalle
		WHERE SetId = @SetId

		DELETE
		FROM PedidoWebSet
		WHERE SetId = @setID

		COMMIT
	END TRY

	BEGIN CATCH
		ROLLBACK
	END CATCH
END

GO

USE BelcorpEcuador
GO

IF OBJECT_ID('dbo.PedidoWebSet_Select', 'P') IS NOT NULL
	DROP PROC dbo.PedidoWebSet_Select
GO
CREATE PROCEDURE PedidoWebSet_Select @SetId INT
AS
BEGIN
	SELECT SetID
		,PedidoID
		,CuvSet
		,EstrategiaId
		,NombreSet
		,Cantidad
		,PrecioUnidad
		,ImporteTotal
		,TipoEstrategiaId
		,Campania
		,ConsultoraID
		,OrdenPedido
		,CodigoUsuarioCreacion
		,CodigoUsuarioModificacion
		,FechaCreacion
		,FechaModificacion
	FROM PedidoWebSet
	WHERE SetId = @SetId
END
GO

IF OBJECT_ID('dbo.PedidoWebSetDetalle_Select', 'P') IS NOT NULL
	DROP PROC dbo.PedidoWebSetDetalle_Select
GO
CREATE PROCEDURE PedidoWebSetDetalle_Select @SetId INT
AS
BEGIN
	SELECT SetDetalleID
		,SetID
		,CuvProducto
		,NombreProducto
		,Cantidad
		,CantidadOriginal
		,FactorRepeticion
		,PedidoDetalleID
		,PrecioUnidad
		,TipoOfertaSisID
	FROM PedidoWebSetDetalle
	WHERE SetId = @SetId
END
GO

IF OBJECT_ID('dbo.PedidoWebSet_Eliminar', 'P') IS NOT NULL
	DROP PROC dbo.PedidoWebSet_Eliminar
GO
CREATE PROCEDURE PedidoWebSet_Eliminar @SetId INT
AS
BEGIN
	BEGIN TRAN

	BEGIN TRY
		DELETE
		FROM PedidoWebSetDetalle
		WHERE SetId = @SetId

		DELETE
		FROM PedidoWebSet
		WHERE SetId = @setID

		COMMIT
	END TRY

	BEGIN CATCH
		ROLLBACK
	END CATCH
END

GO

USE BelcorpDominicana
GO

IF OBJECT_ID('dbo.PedidoWebSet_Select', 'P') IS NOT NULL
	DROP PROC dbo.PedidoWebSet_Select
GO
CREATE PROCEDURE PedidoWebSet_Select @SetId INT
AS
BEGIN
	SELECT SetID
		,PedidoID
		,CuvSet
		,EstrategiaId
		,NombreSet
		,Cantidad
		,PrecioUnidad
		,ImporteTotal
		,TipoEstrategiaId
		,Campania
		,ConsultoraID
		,OrdenPedido
		,CodigoUsuarioCreacion
		,CodigoUsuarioModificacion
		,FechaCreacion
		,FechaModificacion
	FROM PedidoWebSet
	WHERE SetId = @SetId
END
GO

IF OBJECT_ID('dbo.PedidoWebSetDetalle_Select', 'P') IS NOT NULL
	DROP PROC dbo.PedidoWebSetDetalle_Select
GO
CREATE PROCEDURE PedidoWebSetDetalle_Select @SetId INT
AS
BEGIN
	SELECT SetDetalleID
		,SetID
		,CuvProducto
		,NombreProducto
		,Cantidad
		,CantidadOriginal
		,FactorRepeticion
		,PedidoDetalleID
		,PrecioUnidad
		,TipoOfertaSisID
	FROM PedidoWebSetDetalle
	WHERE SetId = @SetId
END
GO

IF OBJECT_ID('dbo.PedidoWebSet_Eliminar', 'P') IS NOT NULL
	DROP PROC dbo.PedidoWebSet_Eliminar
GO
CREATE PROCEDURE PedidoWebSet_Eliminar @SetId INT
AS
BEGIN
	BEGIN TRAN

	BEGIN TRY
		DELETE
		FROM PedidoWebSetDetalle
		WHERE SetId = @SetId

		DELETE
		FROM PedidoWebSet
		WHERE SetId = @setID

		COMMIT
	END TRY

	BEGIN CATCH
		ROLLBACK
	END CATCH
END

GO

USE BelcorpCostaRica
GO

IF OBJECT_ID('dbo.PedidoWebSet_Select', 'P') IS NOT NULL
	DROP PROC dbo.PedidoWebSet_Select
GO
CREATE PROCEDURE PedidoWebSet_Select @SetId INT
AS
BEGIN
	SELECT SetID
		,PedidoID
		,CuvSet
		,EstrategiaId
		,NombreSet
		,Cantidad
		,PrecioUnidad
		,ImporteTotal
		,TipoEstrategiaId
		,Campania
		,ConsultoraID
		,OrdenPedido
		,CodigoUsuarioCreacion
		,CodigoUsuarioModificacion
		,FechaCreacion
		,FechaModificacion
	FROM PedidoWebSet
	WHERE SetId = @SetId
END
GO

IF OBJECT_ID('dbo.PedidoWebSetDetalle_Select', 'P') IS NOT NULL
	DROP PROC dbo.PedidoWebSetDetalle_Select
GO
CREATE PROCEDURE PedidoWebSetDetalle_Select @SetId INT
AS
BEGIN
	SELECT SetDetalleID
		,SetID
		,CuvProducto
		,NombreProducto
		,Cantidad
		,CantidadOriginal
		,FactorRepeticion
		,PedidoDetalleID
		,PrecioUnidad
		,TipoOfertaSisID
	FROM PedidoWebSetDetalle
	WHERE SetId = @SetId
END
GO

IF OBJECT_ID('dbo.PedidoWebSet_Eliminar', 'P') IS NOT NULL
	DROP PROC dbo.PedidoWebSet_Eliminar
GO
CREATE PROCEDURE PedidoWebSet_Eliminar @SetId INT
AS
BEGIN
	BEGIN TRAN

	BEGIN TRY
		DELETE
		FROM PedidoWebSetDetalle
		WHERE SetId = @SetId

		DELETE
		FROM PedidoWebSet
		WHERE SetId = @setID

		COMMIT
	END TRY

	BEGIN CATCH
		ROLLBACK
	END CATCH
END

GO

USE BelcorpChile
GO

IF OBJECT_ID('dbo.PedidoWebSet_Select', 'P') IS NOT NULL
	DROP PROC dbo.PedidoWebSet_Select
GO
CREATE PROCEDURE PedidoWebSet_Select @SetId INT
AS
BEGIN
	SELECT SetID
		,PedidoID
		,CuvSet
		,EstrategiaId
		,NombreSet
		,Cantidad
		,PrecioUnidad
		,ImporteTotal
		,TipoEstrategiaId
		,Campania
		,ConsultoraID
		,OrdenPedido
		,CodigoUsuarioCreacion
		,CodigoUsuarioModificacion
		,FechaCreacion
		,FechaModificacion
	FROM PedidoWebSet
	WHERE SetId = @SetId
END
GO

IF OBJECT_ID('dbo.PedidoWebSetDetalle_Select', 'P') IS NOT NULL
	DROP PROC dbo.PedidoWebSetDetalle_Select
GO
CREATE PROCEDURE PedidoWebSetDetalle_Select @SetId INT
AS
BEGIN
	SELECT SetDetalleID
		,SetID
		,CuvProducto
		,NombreProducto
		,Cantidad
		,CantidadOriginal
		,FactorRepeticion
		,PedidoDetalleID
		,PrecioUnidad
		,TipoOfertaSisID
	FROM PedidoWebSetDetalle
	WHERE SetId = @SetId
END
GO

IF OBJECT_ID('dbo.PedidoWebSet_Eliminar', 'P') IS NOT NULL
	DROP PROC dbo.PedidoWebSet_Eliminar
GO
CREATE PROCEDURE PedidoWebSet_Eliminar @SetId INT
AS
BEGIN
	BEGIN TRAN

	BEGIN TRY
		DELETE
		FROM PedidoWebSetDetalle
		WHERE SetId = @SetId

		DELETE
		FROM PedidoWebSet
		WHERE SetId = @setID

		COMMIT
	END TRY

	BEGIN CATCH
		ROLLBACK
	END CATCH
END

GO

USE BelcorpBolivia
GO

IF OBJECT_ID('dbo.PedidoWebSet_Select', 'P') IS NOT NULL
	DROP PROC dbo.PedidoWebSet_Select
GO
CREATE PROCEDURE PedidoWebSet_Select @SetId INT
AS
BEGIN
	SELECT SetID
		,PedidoID
		,CuvSet
		,EstrategiaId
		,NombreSet
		,Cantidad
		,PrecioUnidad
		,ImporteTotal
		,TipoEstrategiaId
		,Campania
		,ConsultoraID
		,OrdenPedido
		,CodigoUsuarioCreacion
		,CodigoUsuarioModificacion
		,FechaCreacion
		,FechaModificacion
	FROM PedidoWebSet
	WHERE SetId = @SetId
END
GO

IF OBJECT_ID('dbo.PedidoWebSetDetalle_Select', 'P') IS NOT NULL
	DROP PROC dbo.PedidoWebSetDetalle_Select
GO
CREATE PROCEDURE PedidoWebSetDetalle_Select @SetId INT
AS
BEGIN
	SELECT SetDetalleID
		,SetID
		,CuvProducto
		,NombreProducto
		,Cantidad
		,CantidadOriginal
		,FactorRepeticion
		,PedidoDetalleID
		,PrecioUnidad
		,TipoOfertaSisID
	FROM PedidoWebSetDetalle
	WHERE SetId = @SetId
END
GO

IF OBJECT_ID('dbo.PedidoWebSet_Eliminar', 'P') IS NOT NULL
	DROP PROC dbo.PedidoWebSet_Eliminar
GO
CREATE PROCEDURE PedidoWebSet_Eliminar @SetId INT
AS
BEGIN
	BEGIN TRAN

	BEGIN TRY
		DELETE
		FROM PedidoWebSetDetalle
		WHERE SetId = @SetId

		DELETE
		FROM PedidoWebSet
		WHERE SetId = @setID

		COMMIT
	END TRY

	BEGIN CATCH
		ROLLBACK
	END CATCH
END

GO

