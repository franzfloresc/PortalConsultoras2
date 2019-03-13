USE BelcorpPeru
GO

IF NOT EXISTS (
		SELECT 1
		FROM TablaLogicaDatos
		WHERE TablaLogicaID = 160
			AND Descripcion LIKE '%Mensaje importante escala descuento%'
		)
BEGIN
	INSERT INTO dbo.TablaLogicaDatos (
		TablaLogicaDatosID
		,TablaLogicaID
		,Codigo
		,Descripcion
		,Valor
		)
	VALUES (
		16001
		,160
		,'01'
		,'Mensaje importante escala descuento'
		,'Todo pedido tendrá recargo por flete dependiendo del monto del pedido, peso y distancia. En Lima entre S/9.50 y S/16.00 en Provincias entre S/13.50 y S/19.00 Amazonas, San Martín, Ucayali y Loreto entre S/16.50 y S/24.00. Evita el cobro de flete adicional pasando tu pedido en fecha.
Si pasa tu pedido en fecha extemporánea de facturación se cobrará un adicional de S/5.00 en Lima S/7.00 en Provincias y S/10 .00 en Zonas Alejadas.'
		);
END
GO

USE BelcorpBolivia
GO

IF NOT EXISTS (
		SELECT 1
		FROM TablaLogicaDatos
		WHERE TablaLogicaID = 160
			AND Descripcion LIKE '%Mensaje importante escala descuento%'
		)
BEGIN
	INSERT INTO dbo.TablaLogicaDatos (
		TablaLogicaDatosID
		,TablaLogicaID
		,Codigo
		,Descripcion
		,Valor
		)
	VALUES (
		16001
		,160
		,'01'
		,'Mensaje importante escala descuento'
		,'Todo pedido tendrá un recargo por flete.fecha'
		);
END
GO

USE BelcorpChile
GO

IF NOT EXISTS (
		SELECT 1
		FROM TablaLogicaDatos
		WHERE TablaLogicaID = 160
			AND Descripcion LIKE '%Mensaje importante escala descuento%'
		)
BEGIN
	INSERT INTO dbo.TablaLogicaDatos (
		TablaLogicaDatosID
		,TablaLogicaID
		,Codigo
		,Descripcion
		,Valor
		)
	VALUES (
		16001
		,160
		,'01'
		,'Mensaje importante escala descuento'
		,'Todo lo que vendas suma para alcanzar tu escala de comisión. Todo el pedido tendrá recargo por flete: Santiago $. 1.800 y Provincia $. 2.900. No se aceptarán pedidos por un monto menor a $ 45.000.'
		);
END
GO

USE BelcorpColombia
GO

IF NOT EXISTS (
		SELECT 1
		FROM TablaLogicaDatos
		WHERE TablaLogicaID = 160
			AND Descripcion LIKE '%Mensaje importante escala descuento%'
		)
BEGIN
	INSERT INTO dbo.TablaLogicaDatos (
		TablaLogicaDatosID
		,TablaLogicaID
		,Codigo
		,Descripcion
		,Valor
		)
	VALUES (
		16001
		,160
		,'01'
		,'Mensaje importante escala descuento'
		,'Todo pedido tendrá recargo por flete.'
		);
END
GO

USE BelcorpGuatemala
GO

IF NOT EXISTS (
		SELECT 1
		FROM TablaLogicaDatos
		WHERE TablaLogicaID = 160
			AND Descripcion LIKE '%Mensaje importante escala descuento%'
		)
BEGIN
	INSERT INTO dbo.TablaLogicaDatos (
		TablaLogicaDatosID
		,TablaLogicaID
		,Codigo
		,Descripcion
		,Valor
		)
	VALUES (
		16001
		,160
		,'01'
		,'Mensaje importante escala descuento'
		,'No se aceptarán pedidos por un monto menor de Q. 570.00. Todo pedido tendrá un recargo por flete, en la Capital será de Q. 29.79 y en Provincia de Q.38.99.'
		);
END
GO

USE BelcorpMexico
GO

IF NOT EXISTS (
		SELECT 1
		FROM TablaLogicaDatos
		WHERE TablaLogicaID = 160
			AND Descripcion LIKE '%Mensaje importante escala descuento%'
		)
BEGIN
	INSERT INTO dbo.TablaLogicaDatos (
		TablaLogicaDatosID
		,TablaLogicaID
		,Codigo
		,Descripcion
		,Valor
		)
	VALUES (
		16001
		,160
		,'01'
		,'Mensaje importante escala descuento'
		,'Todo pedido tendrá recargo por flete.'
		);
END
GO

USE BelcorpCostaRica
GO

IF NOT EXISTS (
		SELECT 1
		FROM TablaLogicaDatos
		WHERE TablaLogicaID = 160
			AND Descripcion LIKE '%Mensaje importante escala descuento%'
		)
BEGIN
	INSERT INTO dbo.TablaLogicaDatos (
		TablaLogicaDatosID
		,TablaLogicaID
		,Codigo
		,Descripcion
		,Valor
		)
	VALUES (
		16001
		,160
		,'01'
		,'Mensaje importante escala descuento'
		,'No se aceptarán pedidos por un monto menor de ₡. 55,000. Todo pedido tendrá un recargo por flete. Si tu pedido es hasta ₡. 75,999.99 se te cargará ₡. 2,499 en la Capital y ₡. 2,799 en Provincia.'
		);
END
GO

USE BelcorpEcuador
GO

IF NOT EXISTS (
		SELECT 1
		FROM TablaLogicaDatos
		WHERE TablaLogicaID = 160
			AND Descripcion LIKE '%Mensaje importante escala descuento%'
		)
BEGIN
	INSERT INTO dbo.TablaLogicaDatos (
		TablaLogicaDatosID
		,TablaLogicaID
		,Codigo
		,Descripcion
		,Valor
		)
	VALUES (
		16001
		,160
		,'01'
		,'Mensaje importante escala descuento'
		,'Todo pedido tendrá un recargo por flete.'
		);
END
GO

USE BelcorpSalvador
GO

IF NOT EXISTS (
		SELECT 1
		FROM TablaLogicaDatos
		WHERE TablaLogicaID = 160
			AND Descripcion LIKE '%Mensaje importante escala descuento%'
		)
BEGIN
	INSERT INTO dbo.TablaLogicaDatos (
		TablaLogicaDatosID
		,TablaLogicaID
		,Codigo
		,Descripcion
		,Valor
		)
	VALUES (
		16001
		,160
		,'01'
		,'Mensaje importante escala descuento'
		,'No se aceptarán pedidos por un monto menor de $. 75.00. Todo pedido tendrá un recargo por flete, en la Capital será de $. 3.19 y en Departamento $. 4.09'
		);
END
GO

USE BelcorpPanama
GO

IF NOT EXISTS (
		SELECT 1
		FROM TablaLogicaDatos
		WHERE TablaLogicaID = 160
			AND Descripcion LIKE '%Mensaje importante escala descuento%'
		)
BEGIN
	INSERT INTO dbo.TablaLogicaDatos (
		TablaLogicaDatosID
		,TablaLogicaID
		,Codigo
		,Descripcion
		,Valor
		)
	VALUES (
		16001
		,160
		,'01'
		,'Mensaje importante escala descuento'
		,'No se aceptarán pedidos por un monto menor de B/. 110.00. Todo pedido tendrá un recargo por flete, en la Capital será  de B/. 6.54 y Afuera B/. 5.55.'
		);
END
GO

USE BelcorpPuertoRico
GO

IF NOT EXISTS (
		SELECT 1
		FROM TablaLogicaDatos
		WHERE TablaLogicaID = 160
			AND Descripcion LIKE '%Mensaje importante escala descuento%'
		)
BEGIN
	INSERT INTO dbo.TablaLogicaDatos (
		TablaLogicaDatosID
		,TablaLogicaID
		,Codigo
		,Descripcion
		,Valor
		)
	VALUES (
		16001
		,160
		,'01'
		,'Mensaje importante escala descuento'
		,'No se aceptarán pedidos por un monto menor de $ 120.00. Todo pedido tendrá un recargo por flete de $6.98. NINGÚN PRECIO INCLUYE EL IMPUESTO A LA VENTA Y EL USO, NI EL IMPUESTO MUNICIPAL CORRESPONDIENTE.'
		);
END
GO

USE BelcorpDominicana
GO

IF NOT EXISTS (
		SELECT 1
		FROM TablaLogicaDatos
		WHERE TablaLogicaID = 160
			AND Descripcion LIKE '%Mensaje importante escala descuento%'
		)
BEGIN
	INSERT INTO dbo.TablaLogicaDatos (
		TablaLogicaDatosID
		,TablaLogicaID
		,Codigo
		,Descripcion
		,Valor
		)
	VALUES (
		16001
		,160
		,'01'
		,'Mensaje importante escala descuento'
		,'No se aceptarán pedidos por un monto menor de RD$. 3,100.00 y todos tendrán un flete de RD$. 160.00.'
		);
END
