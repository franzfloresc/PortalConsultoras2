USE BelcorpPeru_BPT

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
		SELECT PWS.SetID
			,PWS.PedidoID
			,PWS.CuvSet
			,PWS.EstrategiaId
			--,PWS.NombreSet
			,PWS.Cantidad
			,PWS.PrecioUnidad
			,PWS.ImporteTotal
			--,PWS.TipoEstrategiaId
			,PWS.Campania
			,PWS.ConsultoraID
			,PWS.OrdenPedido
			,PWS.CodigoUsuarioCreacion
			,PWS.CodigoUsuarioModificacion
			,PWS.FechaCreacion
			,PWS.FechaModificacion
			,ClienteId = ISNULL(C.ClienteID,0)
			,ClienteNombre = ISNULL(C.NOMBRE,'')
		FROM PedidoWebSet PWS
			LEFT JOIN CLIENTE C ON PWS.ConsultoraID = C.ConsultoraID 
				AND ISNULL(PWS.ClienteID,0) = C.ClienteID

		WHERE PWS.SetId = @SetId
	END

GO
