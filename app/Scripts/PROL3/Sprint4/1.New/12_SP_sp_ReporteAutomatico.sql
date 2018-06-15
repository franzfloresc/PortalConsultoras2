ALTER PROCEDURE sp_ReporteAutomatico
	@FilasPagina INT,
	@Fila INT,
	@Cantidad INT,
	@ColumnaOrden VARCHAR(50),
	@DireccionOrden VARCHAR(5),
	@ValId INT
AS
BEGIN
	DECLARE
		@SentenciaSQL NVARCHAR(3072),
		@ParametroSQL NVARCHAR(512),
		@Orden SYSNAME;

	SET @Orden = CONCAT(@ColumnaOrden, ' ', @DireccionOrden);

	SET @SentenciaSQL = '
		SELECT
			val.Zona,
			CASE
				WHEN val.Estado = 2 THEN
					CASE
						WHEN val.EsDeuda = 1 THEN 8
						WHEN val.EsMontoMinino = 1 THEN val.Estado
						ELSE 6
					END
				WHEN val.Estado = 3 THEN
					CASE
						WHEN val.EsDeuda = 1 THEN 9
						WHEN val.EsMontoMinino = 1 THEN val.Estado
						ELSE 7
					END
				ELSE val.Estado
			END AS Estado,     
			CASE
				WHEN val.Estado = 1 THEN ''No Reservado - Pedido con P. Liquidación o Sin Productos de catálogo''  
				WHEN val.Estado = 2 THEN
					CASE
						WHEN val.EsDeuda = 1 THEN ''No Reservado Deuda''
						WHEN val.EsMontoMinino = 1 THEN ''No Reservado Monto Min''
						ELSE ''No Reservado Monto Max''
					END
				WHEN val.Estado = 3 THEN
					CASE
						WHEN val.EsDeuda = 1 THEN ''No Reservado Deuda con Obs.''
						WHEN val.EsMontoMinino = 1 THEN ''No Reservado Monto Min con Obs.''
						ELSE ''No Reservado Monto Max con Obs.''
					END
				WHEN val.Estado = 4 THEN ''Reservado''
				WHEN val.Estado = 5 THEN ''Reservado con Obs.''
				WHEN val.Estado = 99 THEN ''Error PROL''
			END AS DescripcionEstado,  
			ISNULL(EnvioCorreo,0) AS EnvioCorreo,    
			CONVERT(VARCHAR(10), val.FechaFacturacion, 103) AS FechaFacturacion,
			val.Codigo AS CodigoConsultora,  
			c.NombreCompleto AS NombreConsultora,
			val.montominimopedido AS MontoMinimo,
			val.montomaximopedido AS MontoMaximo,
			val.montoDeuda AS MontoDeuda,
			val.campaniaid AS Periodo,
			r.codigo AS Region,
			s.codigo AS Seccion,
			isnull(t.numero,'''') AS Telefono,
			isnull(P.ImporteTotal,0) AS ImporteTotal
		FROM ValidacionAutomaticaPROLLog val with(nolock)  
		INNER JOIN ods.Consultora c on val.codigo = c.codigo
		LEFT JOIN ODS.REGION R ON R.REGIONID = C.REGIONID
		LEFT JOIN ODS.SECCION S ON S.SECCIONID = C.SECCIONID
		LEFT JOIN ODS.TELEFONO T ON T.CONSULTORAID = C.CONSULTORAID AND T.CONSULTORAID = VAL.CONSULTORAID AND TIPOTELEFONO = ''TM''
		LEFT JOIN PedidoWeb P ON VAL.PEDIDOID = P.PEDIDOID
		WHERE val.ValAutomaticaPROLId = @ValId
		ORDER BY ' + @Orden + '
		OFFSET @Offset ROWS
		FETCH NEXT @Fetch ROWS ONLY;'

	SET @ParametroSQL = '@Offset int, @Fetch int, @ValId INT';

	EXECUTE sp_executesql
		@stmt = @SentenciaSQL,
		@params = @ParametroSQL,
		@Offset = @Fila,
		@Fetch = @FilasPagina,
		@ValId = @ValId
END;