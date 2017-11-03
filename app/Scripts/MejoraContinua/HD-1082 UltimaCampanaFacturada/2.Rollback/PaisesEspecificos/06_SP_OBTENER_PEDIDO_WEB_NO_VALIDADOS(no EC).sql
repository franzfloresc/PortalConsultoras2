GO
ALTER PROCEDURE dbo.OBTENER_PEDIDO_WEB_NO_VALIDADOS
  @ConsultoraLiderID     	BIGINT,
  @CodigoPais				VARCHAR(3),
  @CodigoCampaniaActual		VARCHAR(6)
AS
BEGIN
	DECLARE 
		@CodigoZona VARCHAR(4)
		, @CodigoRegion VARCHAR(2)
		, @CodigoSeccion VARCHAR(1)
		, @CodigoConsultora VARCHAR(25)

	SELECT TOP 1
		@CodigoRegion = isnull(rtrim(substring(cl.SeccionGestionLider, 1, 2)), '')
		, @CodigoZona = isnull(rtrim(substring(cl.SeccionGestionLider, 3, 4)), '')
		, @CodigoSeccion = isnull(rtrim(substring(cl.SeccionGestionLider, 7, 8)), '')
		, @CodigoConsultora = cl.CodigoConsultora
	FROM ods.ConsultoraLider cl
	WHERE
		cl.ConsultoraID = @ConsultoraLiderID

	SELECT DISTINCT
		c.ConsultoraID
		, c.NombreCompleto AS Nombre
		, c.Codigo AS CodigodeConsultora
		, isnull(terr.Codigo, '') AS Territorio
		, isnull(tf.Numero, '') AS TelefonoCasa
		, isnull(tm.Numero, '') AS TelefonoCelular
		, isnull(cdm.FrecuenciaPedidos, '') AS Constancia
		, CASE 
			WHEN @CodigoPais = 'VE' THEN isnull(seg.Descripcion, '')
			ELSE isnull(segint.Descripcion, '')
		  END AS Segmentacion
		, isnull(c.MontoSaldoActual, 0.00) AS SaldoPendienteTotal
		, isnull(pdw.ImporteTotal-isnull(pdw.DescuentoProl,0), 0.00) AS VentaConsultora
		, isnull(c.MontoUltimoPedido, 0.00) AS MontoPedidoFacturado
		, isnull(sip.MOT_RECH, '') AS MotivoRechazo
		-- Adicionales
		, isnull(idt.Numero,'') AS DocumentodeIdentidad
		, isnull(dir.DireccionLinea1, '') AS Direccion
		, isnull(c.Email, '') AS Email
		, CASE 
			WHEN c.IndicadorFamiliaProtegida = 1 THEN 'SI' 
			ELSE 'NO' 
		  END AS FamiliaProtegida
		, CASE 
			WHEN c.IndicadorFlexiPago = 1 THEN 'SI' 
			ELSE 'NO' 
		  END AS UsaFlexipago
		, CASE 
			WHEN c.EsBrillante = 1 THEN 'SI' 
			ELSE 'NO' 
		  END AS EsBrillante
		, isnull(c.AnoCampanaIngreso, '') AS CampaniaIngreso
		, isnull(CAST(c.UltimaCampanaFacturada AS VARCHAR(6)), '') AS UltimaFacturacion
		, isnull(sip.VAL_ORIG,'') AS OrigenPedido
		, CASE 
			WHEN isnull(c.FechaNacimiento,'')='' THEN '' 
			ELSE CAST(DAY(c.FechaNacimiento) AS VARCHAR(2)) + 
				 ' de ' + 
				 (CASE MONTH(c.FechaNacimiento) 
					WHEN 1 THEN 'Enero' 
					WHEN 2 THEN 'Febrero' 
					WHEN 3 THEN 'Marzo' 
					WHEN 4 THEN 'Abril' 
					WHEN 5 THEN 'Mayo' 
					WHEN 6 THEN 'Junio' 
					WHEN 7 THEN 'Julio' 
					WHEN 8 THEN 'Agosto' 
					WHEN 9 THEN 'Setiembre' 
					WHEN 10 THEN 'Octubre' 
					WHEN 11 THEN 'Noviembre' 
					WHEN 12 THEN 'Diciembre'
				 END)  
			END AS Cumpleanios
	FROM PedidoWeb pdw
		JOIN ods.Consultora c ON pdw.ConsultoraID = c.ConsultoraID
		JOIN ods.Zona z ON z.ZonaID = c.ZonaID AND z.Codigo = @CodigoZona
		JOIN ods.Seccion s ON s.SeccionID = c.SeccionID AND s.Codigo = @CodigoSeccion
		LEFT JOIN ods.SOA_INFOR_PEDID sip WITH(NOLOCK) ON 
			c.ConsultoraID = sip.ConsultoraID
			AND sip.COD_PERI = @CodigoCampaniaActual
		LEFT JOIN ods.Territorio terr WITH(NOLOCK) ON 
			c.TerritorioID = terr.TerritorioID 
			AND c.SeccionID = terr.SeccionID
		LEFT JOIN ods.Telefono tf WITH(NOLOCK) ON 
			c.ConsultoraID = tf.ConsultoraID 
			AND tf.TipoTelefono = 'TF'
		LEFT JOIN ods.Telefono tm WITH(NOLOCK) ON 
			c.ConsultoraID = tm.ConsultoraID 
			AND tm.TipoTelefono = 'TM'
		LEFT JOIN ods.ConsultoraDM cdm WITH(NOLOCK) ON c.Codigo = cdm.ConsultoraID
		LEFT JOIN ods.SegmentoInterno segint WITH(NOLOCK) ON c.SegmentoInternoID = segint.SegmentoInternoID
		LEFT JOIN ods.Segmento seg WITH(NOLOCK) ON c.SegmentoID = seg.SegmentoID
		-- Adicionales
		LEFT JOIN ods.Identificacion idt ON 
			c.ConsultoraID = idt.ConsultoraID 
			AND idt.DocumentoPrincipal = 1
		LEFT JOIN ods.Direccion dir ON 
			c.ConsultoraID = dir.ConsultoraID 
			AND dir.TipoDireccion = 'Domicilio' 
			AND dir.EstadoActivo = 1
	WHERE
		pdw.CampaniaID = @CodigoCampaniaActual 
		AND ((pdw.IndicadorEnviado = 0) OR (pdw.IndicadorEnviado = 1 AND sip.VAL_ESTA_PEDI = 'ENVIADO'))
		AND (pdw.EstadoPedido <> 202 OR pdw.ValidacionAbierta <> 0 OR pdw.ModificaPedidoReservadoMovil <> 0)
		AND (sip.VAL_ORIG = 'WEB' OR sip.VAL_ORIG IS NULL)
END

GO
