USE [BelcorpPeru_GANA]
GO
/****** Object:  StoredProcedure [dbo].[PedidoWebSet_Select]    Script Date: 27/11/2018 12:09:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[PedidoWebSet_Select] @SetId INT
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
