--USE BelcorpPeru_BPT

--USE BelcorpChile_BPT

--USE BelcorpCostaRica_BPT

GO

IF EXISTS (	SELECT 1
			FROM SYS.OBJECTS SO
			WHERE SO.NAME = 'PedidoWebSet_Select'
			AND SO.[TYPE] = 'p')

BEGIN
	DROP PROCEDURE [PedidoWebSet_Select]
END

GO

CREATE PROCEDURE [dbo].[PedidoWebSet_Select] 
	@SetId INT
	AS
	BEGIN
		SELECT SetID
			,PedidoID
			,CuvSet
			,EstrategiaId
			--,NombreSet
			,Cantidad
			,PrecioUnidad
			,ImporteTotal
			--,TipoEstrategiaId
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
