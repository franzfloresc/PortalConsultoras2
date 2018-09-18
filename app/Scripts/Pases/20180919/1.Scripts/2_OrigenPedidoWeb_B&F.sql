GO
USE BelcorpPeru
GO
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1404')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1404','Desktop Buscador Ofertas Para Ti Desplegable Buscador','1','Desktop','4','Buscador','0','Ofertas Para Ti','4','Desplegable Buscador')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1402')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1402','Desktop Buscador Ofertas Para Ti Ficha','1','Desktop','4','Buscador','0','Ofertas Para Ti','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1414')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1414','Desktop Buscador Showroom Desplegable Buscador','1','Desktop','4','Buscador','1','Showroom','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1412')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1412','Desktop Buscador Showroom Ficha','1','Desktop','4','Buscador','1','Showroom','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1424')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1424','Desktop Buscador Lanzamientos Desplegable Buscador','1','Desktop','4','Buscador','2','Lanzamientos','4','Desplegable Buscador')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1422')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1422','Desktop Buscador Lanzamientos Ficha','1','Desktop','4','Buscador','2','Lanzamientos','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1434')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1434','Desktop Buscador Oferta Del Día Desplegable Buscador','1','Desktop','4','Buscador','3','Oferta Del Día','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1432')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1432','Desktop Buscador Oferta Del Día Ficha','1','Desktop','4','Buscador','3','Oferta Del Día','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1454')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1454','Desktop Buscador GND Desplegable Buscador','1','Desktop','4','Buscador','5','GND','4','Desplegable Buscador')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1452')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1452','Desktop Buscador GND Ficha','1','Desktop','4','Buscador','5','GND','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1464')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1464','Desktop Buscador Liquidación Desplegable Buscador','1','Desktop','4','Buscador','6','Liquidación','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1484')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1484','Desktop Buscador Herramientas de Venta Desplegable Buscador','1','Desktop','4','Buscador','8','Herramientas de Venta','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1482')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1482','Desktop Buscador Herramientas de Venta Ficha','1','Desktop','4','Buscador','8','Herramientas de Venta','2','Ficha')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '14B4')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('14B4','Desktop Buscador Catalogo Lbel Desplegable Buscador','1','Desktop','4','Buscador','B','Catalogo Lbel','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '14C4')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('14C4','Desktop Buscador Catalogo Esika Desplegable Buscador','1','Desktop','4','Buscador','C','Catalogo Esika','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '14D4')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('14D4','Desktop Buscador Catalogo Cyzone Desplegable Buscador','1','Desktop','4','Buscador','D','Catalogo Cyzone','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2404')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2404','Mobile Buscador Ofertas Para Ti Desplegable Buscador','2','Mobile','4','Buscador','0','Ofertas Para Ti','4','Desplegable Buscador')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2402')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2402','Mobile Buscador Ofertas Para Ti Ficha','2','Mobile','4','Buscador','0','Ofertas Para Ti','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2414')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2414','Mobile Buscador Showroom Desplegable Buscador','2','Mobile','4','Buscador','1','Showroom','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2412')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2412','Mobile Buscador Showroom Ficha','2','Mobile','4','Buscador','1','Showroom','2','Ficha')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2424')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2424','Mobile Buscador Lanzamientos Desplegable Buscador','2','Mobile','4','Buscador','2','Lanzamientos','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2422')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2422','Mobile Buscador Lanzamientos Ficha','2','Mobile','4','Buscador','2','Lanzamientos','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2434')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2434','Mobile Buscador Oferta Del Día Desplegable Buscador','2','Mobile','4','Buscador','3','Oferta Del Día','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2432')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2432','Mobile Buscador Oferta Del Día Ficha','2','Mobile','4','Buscador','3','Oferta Del Día','2','Ficha')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2454')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2454','Mobile Buscador GND Desplegable Buscador','2','Mobile','4','Buscador','5','GND','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2452')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2452','Mobile Buscador GND Ficha','2','Mobile','4','Buscador','5','GND','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2464')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2464','Mobile Buscador Liquidación Desplegable Buscador','2','Mobile','4','Buscador','6','Liquidación','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2484')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2484','Mobile Buscador Herramientas de Venta Desplegable Buscador','2','Mobile','4','Buscador','8','Herramientas de Venta','4','Desplegable Buscador')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2482')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2482','Mobile Buscador Herramientas de Venta Ficha','2','Mobile','4','Buscador','8','Herramientas de Venta','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '24B4')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('24B4','Mobile Buscador Catalogo Lbel Desplegable Buscador','2','Mobile','4','Buscador','B','Catalogo Lbel','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '24C4')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('24C4','Mobile Buscador Catalogo Esika Desplegable Buscador','2','Mobile','4','Buscador','C','Catalogo Esika','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '24D4')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('24D4','Mobile Buscador Catalogo Cyzone Desplegable Buscador','2','Mobile','4','Buscador','D','Catalogo Cyzone','4','Desplegable Buscador')
END

GO
USE BelcorpMexico
GO
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1404')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1404','Desktop Buscador Ofertas Para Ti Desplegable Buscador','1','Desktop','4','Buscador','0','Ofertas Para Ti','4','Desplegable Buscador')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1402')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1402','Desktop Buscador Ofertas Para Ti Ficha','1','Desktop','4','Buscador','0','Ofertas Para Ti','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1414')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1414','Desktop Buscador Showroom Desplegable Buscador','1','Desktop','4','Buscador','1','Showroom','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1412')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1412','Desktop Buscador Showroom Ficha','1','Desktop','4','Buscador','1','Showroom','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1424')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1424','Desktop Buscador Lanzamientos Desplegable Buscador','1','Desktop','4','Buscador','2','Lanzamientos','4','Desplegable Buscador')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1422')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1422','Desktop Buscador Lanzamientos Ficha','1','Desktop','4','Buscador','2','Lanzamientos','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1434')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1434','Desktop Buscador Oferta Del Día Desplegable Buscador','1','Desktop','4','Buscador','3','Oferta Del Día','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1432')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1432','Desktop Buscador Oferta Del Día Ficha','1','Desktop','4','Buscador','3','Oferta Del Día','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1454')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1454','Desktop Buscador GND Desplegable Buscador','1','Desktop','4','Buscador','5','GND','4','Desplegable Buscador')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1452')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1452','Desktop Buscador GND Ficha','1','Desktop','4','Buscador','5','GND','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1464')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1464','Desktop Buscador Liquidación Desplegable Buscador','1','Desktop','4','Buscador','6','Liquidación','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1484')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1484','Desktop Buscador Herramientas de Venta Desplegable Buscador','1','Desktop','4','Buscador','8','Herramientas de Venta','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1482')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1482','Desktop Buscador Herramientas de Venta Ficha','1','Desktop','4','Buscador','8','Herramientas de Venta','2','Ficha')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '14B4')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('14B4','Desktop Buscador Catalogo Lbel Desplegable Buscador','1','Desktop','4','Buscador','B','Catalogo Lbel','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '14C4')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('14C4','Desktop Buscador Catalogo Esika Desplegable Buscador','1','Desktop','4','Buscador','C','Catalogo Esika','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '14D4')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('14D4','Desktop Buscador Catalogo Cyzone Desplegable Buscador','1','Desktop','4','Buscador','D','Catalogo Cyzone','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2404')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2404','Mobile Buscador Ofertas Para Ti Desplegable Buscador','2','Mobile','4','Buscador','0','Ofertas Para Ti','4','Desplegable Buscador')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2402')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2402','Mobile Buscador Ofertas Para Ti Ficha','2','Mobile','4','Buscador','0','Ofertas Para Ti','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2414')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2414','Mobile Buscador Showroom Desplegable Buscador','2','Mobile','4','Buscador','1','Showroom','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2412')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2412','Mobile Buscador Showroom Ficha','2','Mobile','4','Buscador','1','Showroom','2','Ficha')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2424')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2424','Mobile Buscador Lanzamientos Desplegable Buscador','2','Mobile','4','Buscador','2','Lanzamientos','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2422')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2422','Mobile Buscador Lanzamientos Ficha','2','Mobile','4','Buscador','2','Lanzamientos','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2434')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2434','Mobile Buscador Oferta Del Día Desplegable Buscador','2','Mobile','4','Buscador','3','Oferta Del Día','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2432')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2432','Mobile Buscador Oferta Del Día Ficha','2','Mobile','4','Buscador','3','Oferta Del Día','2','Ficha')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2454')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2454','Mobile Buscador GND Desplegable Buscador','2','Mobile','4','Buscador','5','GND','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2452')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2452','Mobile Buscador GND Ficha','2','Mobile','4','Buscador','5','GND','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2464')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2464','Mobile Buscador Liquidación Desplegable Buscador','2','Mobile','4','Buscador','6','Liquidación','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2484')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2484','Mobile Buscador Herramientas de Venta Desplegable Buscador','2','Mobile','4','Buscador','8','Herramientas de Venta','4','Desplegable Buscador')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2482')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2482','Mobile Buscador Herramientas de Venta Ficha','2','Mobile','4','Buscador','8','Herramientas de Venta','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '24B4')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('24B4','Mobile Buscador Catalogo Lbel Desplegable Buscador','2','Mobile','4','Buscador','B','Catalogo Lbel','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '24C4')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('24C4','Mobile Buscador Catalogo Esika Desplegable Buscador','2','Mobile','4','Buscador','C','Catalogo Esika','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '24D4')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('24D4','Mobile Buscador Catalogo Cyzone Desplegable Buscador','2','Mobile','4','Buscador','D','Catalogo Cyzone','4','Desplegable Buscador')
END

GO
USE BelcorpColombia
GO
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1404')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1404','Desktop Buscador Ofertas Para Ti Desplegable Buscador','1','Desktop','4','Buscador','0','Ofertas Para Ti','4','Desplegable Buscador')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1402')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1402','Desktop Buscador Ofertas Para Ti Ficha','1','Desktop','4','Buscador','0','Ofertas Para Ti','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1414')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1414','Desktop Buscador Showroom Desplegable Buscador','1','Desktop','4','Buscador','1','Showroom','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1412')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1412','Desktop Buscador Showroom Ficha','1','Desktop','4','Buscador','1','Showroom','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1424')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1424','Desktop Buscador Lanzamientos Desplegable Buscador','1','Desktop','4','Buscador','2','Lanzamientos','4','Desplegable Buscador')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1422')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1422','Desktop Buscador Lanzamientos Ficha','1','Desktop','4','Buscador','2','Lanzamientos','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1434')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1434','Desktop Buscador Oferta Del Día Desplegable Buscador','1','Desktop','4','Buscador','3','Oferta Del Día','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1432')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1432','Desktop Buscador Oferta Del Día Ficha','1','Desktop','4','Buscador','3','Oferta Del Día','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1454')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1454','Desktop Buscador GND Desplegable Buscador','1','Desktop','4','Buscador','5','GND','4','Desplegable Buscador')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1452')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1452','Desktop Buscador GND Ficha','1','Desktop','4','Buscador','5','GND','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1464')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1464','Desktop Buscador Liquidación Desplegable Buscador','1','Desktop','4','Buscador','6','Liquidación','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1484')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1484','Desktop Buscador Herramientas de Venta Desplegable Buscador','1','Desktop','4','Buscador','8','Herramientas de Venta','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1482')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1482','Desktop Buscador Herramientas de Venta Ficha','1','Desktop','4','Buscador','8','Herramientas de Venta','2','Ficha')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '14B4')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('14B4','Desktop Buscador Catalogo Lbel Desplegable Buscador','1','Desktop','4','Buscador','B','Catalogo Lbel','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '14C4')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('14C4','Desktop Buscador Catalogo Esika Desplegable Buscador','1','Desktop','4','Buscador','C','Catalogo Esika','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '14D4')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('14D4','Desktop Buscador Catalogo Cyzone Desplegable Buscador','1','Desktop','4','Buscador','D','Catalogo Cyzone','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2404')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2404','Mobile Buscador Ofertas Para Ti Desplegable Buscador','2','Mobile','4','Buscador','0','Ofertas Para Ti','4','Desplegable Buscador')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2402')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2402','Mobile Buscador Ofertas Para Ti Ficha','2','Mobile','4','Buscador','0','Ofertas Para Ti','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2414')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2414','Mobile Buscador Showroom Desplegable Buscador','2','Mobile','4','Buscador','1','Showroom','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2412')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2412','Mobile Buscador Showroom Ficha','2','Mobile','4','Buscador','1','Showroom','2','Ficha')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2424')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2424','Mobile Buscador Lanzamientos Desplegable Buscador','2','Mobile','4','Buscador','2','Lanzamientos','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2422')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2422','Mobile Buscador Lanzamientos Ficha','2','Mobile','4','Buscador','2','Lanzamientos','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2434')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2434','Mobile Buscador Oferta Del Día Desplegable Buscador','2','Mobile','4','Buscador','3','Oferta Del Día','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2432')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2432','Mobile Buscador Oferta Del Día Ficha','2','Mobile','4','Buscador','3','Oferta Del Día','2','Ficha')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2454')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2454','Mobile Buscador GND Desplegable Buscador','2','Mobile','4','Buscador','5','GND','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2452')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2452','Mobile Buscador GND Ficha','2','Mobile','4','Buscador','5','GND','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2464')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2464','Mobile Buscador Liquidación Desplegable Buscador','2','Mobile','4','Buscador','6','Liquidación','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2484')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2484','Mobile Buscador Herramientas de Venta Desplegable Buscador','2','Mobile','4','Buscador','8','Herramientas de Venta','4','Desplegable Buscador')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2482')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2482','Mobile Buscador Herramientas de Venta Ficha','2','Mobile','4','Buscador','8','Herramientas de Venta','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '24B4')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('24B4','Mobile Buscador Catalogo Lbel Desplegable Buscador','2','Mobile','4','Buscador','B','Catalogo Lbel','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '24C4')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('24C4','Mobile Buscador Catalogo Esika Desplegable Buscador','2','Mobile','4','Buscador','C','Catalogo Esika','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '24D4')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('24D4','Mobile Buscador Catalogo Cyzone Desplegable Buscador','2','Mobile','4','Buscador','D','Catalogo Cyzone','4','Desplegable Buscador')
END

GO
USE BelcorpSalvador
GO
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1404')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1404','Desktop Buscador Ofertas Para Ti Desplegable Buscador','1','Desktop','4','Buscador','0','Ofertas Para Ti','4','Desplegable Buscador')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1402')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1402','Desktop Buscador Ofertas Para Ti Ficha','1','Desktop','4','Buscador','0','Ofertas Para Ti','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1414')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1414','Desktop Buscador Showroom Desplegable Buscador','1','Desktop','4','Buscador','1','Showroom','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1412')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1412','Desktop Buscador Showroom Ficha','1','Desktop','4','Buscador','1','Showroom','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1424')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1424','Desktop Buscador Lanzamientos Desplegable Buscador','1','Desktop','4','Buscador','2','Lanzamientos','4','Desplegable Buscador')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1422')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1422','Desktop Buscador Lanzamientos Ficha','1','Desktop','4','Buscador','2','Lanzamientos','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1434')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1434','Desktop Buscador Oferta Del Día Desplegable Buscador','1','Desktop','4','Buscador','3','Oferta Del Día','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1432')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1432','Desktop Buscador Oferta Del Día Ficha','1','Desktop','4','Buscador','3','Oferta Del Día','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1454')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1454','Desktop Buscador GND Desplegable Buscador','1','Desktop','4','Buscador','5','GND','4','Desplegable Buscador')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1452')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1452','Desktop Buscador GND Ficha','1','Desktop','4','Buscador','5','GND','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1464')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1464','Desktop Buscador Liquidación Desplegable Buscador','1','Desktop','4','Buscador','6','Liquidación','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1484')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1484','Desktop Buscador Herramientas de Venta Desplegable Buscador','1','Desktop','4','Buscador','8','Herramientas de Venta','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1482')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1482','Desktop Buscador Herramientas de Venta Ficha','1','Desktop','4','Buscador','8','Herramientas de Venta','2','Ficha')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '14B4')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('14B4','Desktop Buscador Catalogo Lbel Desplegable Buscador','1','Desktop','4','Buscador','B','Catalogo Lbel','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '14C4')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('14C4','Desktop Buscador Catalogo Esika Desplegable Buscador','1','Desktop','4','Buscador','C','Catalogo Esika','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '14D4')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('14D4','Desktop Buscador Catalogo Cyzone Desplegable Buscador','1','Desktop','4','Buscador','D','Catalogo Cyzone','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2404')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2404','Mobile Buscador Ofertas Para Ti Desplegable Buscador','2','Mobile','4','Buscador','0','Ofertas Para Ti','4','Desplegable Buscador')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2402')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2402','Mobile Buscador Ofertas Para Ti Ficha','2','Mobile','4','Buscador','0','Ofertas Para Ti','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2414')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2414','Mobile Buscador Showroom Desplegable Buscador','2','Mobile','4','Buscador','1','Showroom','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2412')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2412','Mobile Buscador Showroom Ficha','2','Mobile','4','Buscador','1','Showroom','2','Ficha')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2424')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2424','Mobile Buscador Lanzamientos Desplegable Buscador','2','Mobile','4','Buscador','2','Lanzamientos','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2422')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2422','Mobile Buscador Lanzamientos Ficha','2','Mobile','4','Buscador','2','Lanzamientos','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2434')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2434','Mobile Buscador Oferta Del Día Desplegable Buscador','2','Mobile','4','Buscador','3','Oferta Del Día','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2432')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2432','Mobile Buscador Oferta Del Día Ficha','2','Mobile','4','Buscador','3','Oferta Del Día','2','Ficha')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2454')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2454','Mobile Buscador GND Desplegable Buscador','2','Mobile','4','Buscador','5','GND','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2452')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2452','Mobile Buscador GND Ficha','2','Mobile','4','Buscador','5','GND','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2464')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2464','Mobile Buscador Liquidación Desplegable Buscador','2','Mobile','4','Buscador','6','Liquidación','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2484')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2484','Mobile Buscador Herramientas de Venta Desplegable Buscador','2','Mobile','4','Buscador','8','Herramientas de Venta','4','Desplegable Buscador')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2482')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2482','Mobile Buscador Herramientas de Venta Ficha','2','Mobile','4','Buscador','8','Herramientas de Venta','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '24B4')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('24B4','Mobile Buscador Catalogo Lbel Desplegable Buscador','2','Mobile','4','Buscador','B','Catalogo Lbel','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '24C4')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('24C4','Mobile Buscador Catalogo Esika Desplegable Buscador','2','Mobile','4','Buscador','C','Catalogo Esika','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '24D4')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('24D4','Mobile Buscador Catalogo Cyzone Desplegable Buscador','2','Mobile','4','Buscador','D','Catalogo Cyzone','4','Desplegable Buscador')
END

GO
USE BelcorpPuertoRico
GO
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1404')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1404','Desktop Buscador Ofertas Para Ti Desplegable Buscador','1','Desktop','4','Buscador','0','Ofertas Para Ti','4','Desplegable Buscador')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1402')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1402','Desktop Buscador Ofertas Para Ti Ficha','1','Desktop','4','Buscador','0','Ofertas Para Ti','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1414')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1414','Desktop Buscador Showroom Desplegable Buscador','1','Desktop','4','Buscador','1','Showroom','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1412')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1412','Desktop Buscador Showroom Ficha','1','Desktop','4','Buscador','1','Showroom','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1424')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1424','Desktop Buscador Lanzamientos Desplegable Buscador','1','Desktop','4','Buscador','2','Lanzamientos','4','Desplegable Buscador')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1422')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1422','Desktop Buscador Lanzamientos Ficha','1','Desktop','4','Buscador','2','Lanzamientos','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1434')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1434','Desktop Buscador Oferta Del Día Desplegable Buscador','1','Desktop','4','Buscador','3','Oferta Del Día','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1432')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1432','Desktop Buscador Oferta Del Día Ficha','1','Desktop','4','Buscador','3','Oferta Del Día','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1454')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1454','Desktop Buscador GND Desplegable Buscador','1','Desktop','4','Buscador','5','GND','4','Desplegable Buscador')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1452')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1452','Desktop Buscador GND Ficha','1','Desktop','4','Buscador','5','GND','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1464')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1464','Desktop Buscador Liquidación Desplegable Buscador','1','Desktop','4','Buscador','6','Liquidación','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1484')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1484','Desktop Buscador Herramientas de Venta Desplegable Buscador','1','Desktop','4','Buscador','8','Herramientas de Venta','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1482')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1482','Desktop Buscador Herramientas de Venta Ficha','1','Desktop','4','Buscador','8','Herramientas de Venta','2','Ficha')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '14B4')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('14B4','Desktop Buscador Catalogo Lbel Desplegable Buscador','1','Desktop','4','Buscador','B','Catalogo Lbel','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '14C4')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('14C4','Desktop Buscador Catalogo Esika Desplegable Buscador','1','Desktop','4','Buscador','C','Catalogo Esika','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '14D4')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('14D4','Desktop Buscador Catalogo Cyzone Desplegable Buscador','1','Desktop','4','Buscador','D','Catalogo Cyzone','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2404')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2404','Mobile Buscador Ofertas Para Ti Desplegable Buscador','2','Mobile','4','Buscador','0','Ofertas Para Ti','4','Desplegable Buscador')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2402')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2402','Mobile Buscador Ofertas Para Ti Ficha','2','Mobile','4','Buscador','0','Ofertas Para Ti','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2414')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2414','Mobile Buscador Showroom Desplegable Buscador','2','Mobile','4','Buscador','1','Showroom','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2412')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2412','Mobile Buscador Showroom Ficha','2','Mobile','4','Buscador','1','Showroom','2','Ficha')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2424')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2424','Mobile Buscador Lanzamientos Desplegable Buscador','2','Mobile','4','Buscador','2','Lanzamientos','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2422')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2422','Mobile Buscador Lanzamientos Ficha','2','Mobile','4','Buscador','2','Lanzamientos','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2434')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2434','Mobile Buscador Oferta Del Día Desplegable Buscador','2','Mobile','4','Buscador','3','Oferta Del Día','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2432')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2432','Mobile Buscador Oferta Del Día Ficha','2','Mobile','4','Buscador','3','Oferta Del Día','2','Ficha')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2454')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2454','Mobile Buscador GND Desplegable Buscador','2','Mobile','4','Buscador','5','GND','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2452')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2452','Mobile Buscador GND Ficha','2','Mobile','4','Buscador','5','GND','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2464')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2464','Mobile Buscador Liquidación Desplegable Buscador','2','Mobile','4','Buscador','6','Liquidación','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2484')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2484','Mobile Buscador Herramientas de Venta Desplegable Buscador','2','Mobile','4','Buscador','8','Herramientas de Venta','4','Desplegable Buscador')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2482')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2482','Mobile Buscador Herramientas de Venta Ficha','2','Mobile','4','Buscador','8','Herramientas de Venta','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '24B4')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('24B4','Mobile Buscador Catalogo Lbel Desplegable Buscador','2','Mobile','4','Buscador','B','Catalogo Lbel','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '24C4')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('24C4','Mobile Buscador Catalogo Esika Desplegable Buscador','2','Mobile','4','Buscador','C','Catalogo Esika','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '24D4')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('24D4','Mobile Buscador Catalogo Cyzone Desplegable Buscador','2','Mobile','4','Buscador','D','Catalogo Cyzone','4','Desplegable Buscador')
END

GO
USE BelcorpPanama
GO
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1404')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1404','Desktop Buscador Ofertas Para Ti Desplegable Buscador','1','Desktop','4','Buscador','0','Ofertas Para Ti','4','Desplegable Buscador')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1402')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1402','Desktop Buscador Ofertas Para Ti Ficha','1','Desktop','4','Buscador','0','Ofertas Para Ti','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1414')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1414','Desktop Buscador Showroom Desplegable Buscador','1','Desktop','4','Buscador','1','Showroom','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1412')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1412','Desktop Buscador Showroom Ficha','1','Desktop','4','Buscador','1','Showroom','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1424')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1424','Desktop Buscador Lanzamientos Desplegable Buscador','1','Desktop','4','Buscador','2','Lanzamientos','4','Desplegable Buscador')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1422')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1422','Desktop Buscador Lanzamientos Ficha','1','Desktop','4','Buscador','2','Lanzamientos','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1434')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1434','Desktop Buscador Oferta Del Día Desplegable Buscador','1','Desktop','4','Buscador','3','Oferta Del Día','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1432')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1432','Desktop Buscador Oferta Del Día Ficha','1','Desktop','4','Buscador','3','Oferta Del Día','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1454')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1454','Desktop Buscador GND Desplegable Buscador','1','Desktop','4','Buscador','5','GND','4','Desplegable Buscador')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1452')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1452','Desktop Buscador GND Ficha','1','Desktop','4','Buscador','5','GND','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1464')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1464','Desktop Buscador Liquidación Desplegable Buscador','1','Desktop','4','Buscador','6','Liquidación','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1484')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1484','Desktop Buscador Herramientas de Venta Desplegable Buscador','1','Desktop','4','Buscador','8','Herramientas de Venta','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1482')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1482','Desktop Buscador Herramientas de Venta Ficha','1','Desktop','4','Buscador','8','Herramientas de Venta','2','Ficha')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '14B4')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('14B4','Desktop Buscador Catalogo Lbel Desplegable Buscador','1','Desktop','4','Buscador','B','Catalogo Lbel','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '14C4')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('14C4','Desktop Buscador Catalogo Esika Desplegable Buscador','1','Desktop','4','Buscador','C','Catalogo Esika','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '14D4')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('14D4','Desktop Buscador Catalogo Cyzone Desplegable Buscador','1','Desktop','4','Buscador','D','Catalogo Cyzone','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2404')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2404','Mobile Buscador Ofertas Para Ti Desplegable Buscador','2','Mobile','4','Buscador','0','Ofertas Para Ti','4','Desplegable Buscador')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2402')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2402','Mobile Buscador Ofertas Para Ti Ficha','2','Mobile','4','Buscador','0','Ofertas Para Ti','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2414')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2414','Mobile Buscador Showroom Desplegable Buscador','2','Mobile','4','Buscador','1','Showroom','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2412')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2412','Mobile Buscador Showroom Ficha','2','Mobile','4','Buscador','1','Showroom','2','Ficha')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2424')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2424','Mobile Buscador Lanzamientos Desplegable Buscador','2','Mobile','4','Buscador','2','Lanzamientos','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2422')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2422','Mobile Buscador Lanzamientos Ficha','2','Mobile','4','Buscador','2','Lanzamientos','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2434')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2434','Mobile Buscador Oferta Del Día Desplegable Buscador','2','Mobile','4','Buscador','3','Oferta Del Día','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2432')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2432','Mobile Buscador Oferta Del Día Ficha','2','Mobile','4','Buscador','3','Oferta Del Día','2','Ficha')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2454')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2454','Mobile Buscador GND Desplegable Buscador','2','Mobile','4','Buscador','5','GND','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2452')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2452','Mobile Buscador GND Ficha','2','Mobile','4','Buscador','5','GND','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2464')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2464','Mobile Buscador Liquidación Desplegable Buscador','2','Mobile','4','Buscador','6','Liquidación','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2484')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2484','Mobile Buscador Herramientas de Venta Desplegable Buscador','2','Mobile','4','Buscador','8','Herramientas de Venta','4','Desplegable Buscador')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2482')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2482','Mobile Buscador Herramientas de Venta Ficha','2','Mobile','4','Buscador','8','Herramientas de Venta','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '24B4')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('24B4','Mobile Buscador Catalogo Lbel Desplegable Buscador','2','Mobile','4','Buscador','B','Catalogo Lbel','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '24C4')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('24C4','Mobile Buscador Catalogo Esika Desplegable Buscador','2','Mobile','4','Buscador','C','Catalogo Esika','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '24D4')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('24D4','Mobile Buscador Catalogo Cyzone Desplegable Buscador','2','Mobile','4','Buscador','D','Catalogo Cyzone','4','Desplegable Buscador')
END

GO
USE BelcorpGuatemala
GO
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1404')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1404','Desktop Buscador Ofertas Para Ti Desplegable Buscador','1','Desktop','4','Buscador','0','Ofertas Para Ti','4','Desplegable Buscador')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1402')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1402','Desktop Buscador Ofertas Para Ti Ficha','1','Desktop','4','Buscador','0','Ofertas Para Ti','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1414')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1414','Desktop Buscador Showroom Desplegable Buscador','1','Desktop','4','Buscador','1','Showroom','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1412')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1412','Desktop Buscador Showroom Ficha','1','Desktop','4','Buscador','1','Showroom','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1424')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1424','Desktop Buscador Lanzamientos Desplegable Buscador','1','Desktop','4','Buscador','2','Lanzamientos','4','Desplegable Buscador')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1422')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1422','Desktop Buscador Lanzamientos Ficha','1','Desktop','4','Buscador','2','Lanzamientos','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1434')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1434','Desktop Buscador Oferta Del Día Desplegable Buscador','1','Desktop','4','Buscador','3','Oferta Del Día','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1432')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1432','Desktop Buscador Oferta Del Día Ficha','1','Desktop','4','Buscador','3','Oferta Del Día','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1454')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1454','Desktop Buscador GND Desplegable Buscador','1','Desktop','4','Buscador','5','GND','4','Desplegable Buscador')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1452')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1452','Desktop Buscador GND Ficha','1','Desktop','4','Buscador','5','GND','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1464')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1464','Desktop Buscador Liquidación Desplegable Buscador','1','Desktop','4','Buscador','6','Liquidación','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1484')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1484','Desktop Buscador Herramientas de Venta Desplegable Buscador','1','Desktop','4','Buscador','8','Herramientas de Venta','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1482')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1482','Desktop Buscador Herramientas de Venta Ficha','1','Desktop','4','Buscador','8','Herramientas de Venta','2','Ficha')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '14B4')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('14B4','Desktop Buscador Catalogo Lbel Desplegable Buscador','1','Desktop','4','Buscador','B','Catalogo Lbel','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '14C4')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('14C4','Desktop Buscador Catalogo Esika Desplegable Buscador','1','Desktop','4','Buscador','C','Catalogo Esika','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '14D4')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('14D4','Desktop Buscador Catalogo Cyzone Desplegable Buscador','1','Desktop','4','Buscador','D','Catalogo Cyzone','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2404')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2404','Mobile Buscador Ofertas Para Ti Desplegable Buscador','2','Mobile','4','Buscador','0','Ofertas Para Ti','4','Desplegable Buscador')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2402')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2402','Mobile Buscador Ofertas Para Ti Ficha','2','Mobile','4','Buscador','0','Ofertas Para Ti','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2414')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2414','Mobile Buscador Showroom Desplegable Buscador','2','Mobile','4','Buscador','1','Showroom','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2412')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2412','Mobile Buscador Showroom Ficha','2','Mobile','4','Buscador','1','Showroom','2','Ficha')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2424')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2424','Mobile Buscador Lanzamientos Desplegable Buscador','2','Mobile','4','Buscador','2','Lanzamientos','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2422')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2422','Mobile Buscador Lanzamientos Ficha','2','Mobile','4','Buscador','2','Lanzamientos','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2434')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2434','Mobile Buscador Oferta Del Día Desplegable Buscador','2','Mobile','4','Buscador','3','Oferta Del Día','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2432')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2432','Mobile Buscador Oferta Del Día Ficha','2','Mobile','4','Buscador','3','Oferta Del Día','2','Ficha')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2454')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2454','Mobile Buscador GND Desplegable Buscador','2','Mobile','4','Buscador','5','GND','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2452')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2452','Mobile Buscador GND Ficha','2','Mobile','4','Buscador','5','GND','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2464')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2464','Mobile Buscador Liquidación Desplegable Buscador','2','Mobile','4','Buscador','6','Liquidación','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2484')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2484','Mobile Buscador Herramientas de Venta Desplegable Buscador','2','Mobile','4','Buscador','8','Herramientas de Venta','4','Desplegable Buscador')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2482')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2482','Mobile Buscador Herramientas de Venta Ficha','2','Mobile','4','Buscador','8','Herramientas de Venta','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '24B4')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('24B4','Mobile Buscador Catalogo Lbel Desplegable Buscador','2','Mobile','4','Buscador','B','Catalogo Lbel','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '24C4')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('24C4','Mobile Buscador Catalogo Esika Desplegable Buscador','2','Mobile','4','Buscador','C','Catalogo Esika','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '24D4')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('24D4','Mobile Buscador Catalogo Cyzone Desplegable Buscador','2','Mobile','4','Buscador','D','Catalogo Cyzone','4','Desplegable Buscador')
END

GO
USE BelcorpEcuador
GO
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1404')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1404','Desktop Buscador Ofertas Para Ti Desplegable Buscador','1','Desktop','4','Buscador','0','Ofertas Para Ti','4','Desplegable Buscador')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1402')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1402','Desktop Buscador Ofertas Para Ti Ficha','1','Desktop','4','Buscador','0','Ofertas Para Ti','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1414')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1414','Desktop Buscador Showroom Desplegable Buscador','1','Desktop','4','Buscador','1','Showroom','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1412')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1412','Desktop Buscador Showroom Ficha','1','Desktop','4','Buscador','1','Showroom','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1424')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1424','Desktop Buscador Lanzamientos Desplegable Buscador','1','Desktop','4','Buscador','2','Lanzamientos','4','Desplegable Buscador')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1422')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1422','Desktop Buscador Lanzamientos Ficha','1','Desktop','4','Buscador','2','Lanzamientos','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1434')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1434','Desktop Buscador Oferta Del Día Desplegable Buscador','1','Desktop','4','Buscador','3','Oferta Del Día','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1432')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1432','Desktop Buscador Oferta Del Día Ficha','1','Desktop','4','Buscador','3','Oferta Del Día','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1454')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1454','Desktop Buscador GND Desplegable Buscador','1','Desktop','4','Buscador','5','GND','4','Desplegable Buscador')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1452')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1452','Desktop Buscador GND Ficha','1','Desktop','4','Buscador','5','GND','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1464')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1464','Desktop Buscador Liquidación Desplegable Buscador','1','Desktop','4','Buscador','6','Liquidación','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1484')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1484','Desktop Buscador Herramientas de Venta Desplegable Buscador','1','Desktop','4','Buscador','8','Herramientas de Venta','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1482')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1482','Desktop Buscador Herramientas de Venta Ficha','1','Desktop','4','Buscador','8','Herramientas de Venta','2','Ficha')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '14B4')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('14B4','Desktop Buscador Catalogo Lbel Desplegable Buscador','1','Desktop','4','Buscador','B','Catalogo Lbel','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '14C4')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('14C4','Desktop Buscador Catalogo Esika Desplegable Buscador','1','Desktop','4','Buscador','C','Catalogo Esika','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '14D4')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('14D4','Desktop Buscador Catalogo Cyzone Desplegable Buscador','1','Desktop','4','Buscador','D','Catalogo Cyzone','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2404')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2404','Mobile Buscador Ofertas Para Ti Desplegable Buscador','2','Mobile','4','Buscador','0','Ofertas Para Ti','4','Desplegable Buscador')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2402')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2402','Mobile Buscador Ofertas Para Ti Ficha','2','Mobile','4','Buscador','0','Ofertas Para Ti','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2414')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2414','Mobile Buscador Showroom Desplegable Buscador','2','Mobile','4','Buscador','1','Showroom','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2412')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2412','Mobile Buscador Showroom Ficha','2','Mobile','4','Buscador','1','Showroom','2','Ficha')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2424')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2424','Mobile Buscador Lanzamientos Desplegable Buscador','2','Mobile','4','Buscador','2','Lanzamientos','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2422')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2422','Mobile Buscador Lanzamientos Ficha','2','Mobile','4','Buscador','2','Lanzamientos','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2434')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2434','Mobile Buscador Oferta Del Día Desplegable Buscador','2','Mobile','4','Buscador','3','Oferta Del Día','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2432')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2432','Mobile Buscador Oferta Del Día Ficha','2','Mobile','4','Buscador','3','Oferta Del Día','2','Ficha')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2454')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2454','Mobile Buscador GND Desplegable Buscador','2','Mobile','4','Buscador','5','GND','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2452')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2452','Mobile Buscador GND Ficha','2','Mobile','4','Buscador','5','GND','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2464')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2464','Mobile Buscador Liquidación Desplegable Buscador','2','Mobile','4','Buscador','6','Liquidación','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2484')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2484','Mobile Buscador Herramientas de Venta Desplegable Buscador','2','Mobile','4','Buscador','8','Herramientas de Venta','4','Desplegable Buscador')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2482')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2482','Mobile Buscador Herramientas de Venta Ficha','2','Mobile','4','Buscador','8','Herramientas de Venta','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '24B4')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('24B4','Mobile Buscador Catalogo Lbel Desplegable Buscador','2','Mobile','4','Buscador','B','Catalogo Lbel','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '24C4')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('24C4','Mobile Buscador Catalogo Esika Desplegable Buscador','2','Mobile','4','Buscador','C','Catalogo Esika','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '24D4')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('24D4','Mobile Buscador Catalogo Cyzone Desplegable Buscador','2','Mobile','4','Buscador','D','Catalogo Cyzone','4','Desplegable Buscador')
END

GO
USE BelcorpDominicana
GO
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1404')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1404','Desktop Buscador Ofertas Para Ti Desplegable Buscador','1','Desktop','4','Buscador','0','Ofertas Para Ti','4','Desplegable Buscador')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1402')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1402','Desktop Buscador Ofertas Para Ti Ficha','1','Desktop','4','Buscador','0','Ofertas Para Ti','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1414')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1414','Desktop Buscador Showroom Desplegable Buscador','1','Desktop','4','Buscador','1','Showroom','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1412')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1412','Desktop Buscador Showroom Ficha','1','Desktop','4','Buscador','1','Showroom','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1424')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1424','Desktop Buscador Lanzamientos Desplegable Buscador','1','Desktop','4','Buscador','2','Lanzamientos','4','Desplegable Buscador')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1422')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1422','Desktop Buscador Lanzamientos Ficha','1','Desktop','4','Buscador','2','Lanzamientos','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1434')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1434','Desktop Buscador Oferta Del Día Desplegable Buscador','1','Desktop','4','Buscador','3','Oferta Del Día','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1432')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1432','Desktop Buscador Oferta Del Día Ficha','1','Desktop','4','Buscador','3','Oferta Del Día','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1454')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1454','Desktop Buscador GND Desplegable Buscador','1','Desktop','4','Buscador','5','GND','4','Desplegable Buscador')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1452')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1452','Desktop Buscador GND Ficha','1','Desktop','4','Buscador','5','GND','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1464')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1464','Desktop Buscador Liquidación Desplegable Buscador','1','Desktop','4','Buscador','6','Liquidación','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1484')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1484','Desktop Buscador Herramientas de Venta Desplegable Buscador','1','Desktop','4','Buscador','8','Herramientas de Venta','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1482')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1482','Desktop Buscador Herramientas de Venta Ficha','1','Desktop','4','Buscador','8','Herramientas de Venta','2','Ficha')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '14B4')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('14B4','Desktop Buscador Catalogo Lbel Desplegable Buscador','1','Desktop','4','Buscador','B','Catalogo Lbel','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '14C4')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('14C4','Desktop Buscador Catalogo Esika Desplegable Buscador','1','Desktop','4','Buscador','C','Catalogo Esika','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '14D4')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('14D4','Desktop Buscador Catalogo Cyzone Desplegable Buscador','1','Desktop','4','Buscador','D','Catalogo Cyzone','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2404')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2404','Mobile Buscador Ofertas Para Ti Desplegable Buscador','2','Mobile','4','Buscador','0','Ofertas Para Ti','4','Desplegable Buscador')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2402')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2402','Mobile Buscador Ofertas Para Ti Ficha','2','Mobile','4','Buscador','0','Ofertas Para Ti','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2414')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2414','Mobile Buscador Showroom Desplegable Buscador','2','Mobile','4','Buscador','1','Showroom','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2412')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2412','Mobile Buscador Showroom Ficha','2','Mobile','4','Buscador','1','Showroom','2','Ficha')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2424')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2424','Mobile Buscador Lanzamientos Desplegable Buscador','2','Mobile','4','Buscador','2','Lanzamientos','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2422')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2422','Mobile Buscador Lanzamientos Ficha','2','Mobile','4','Buscador','2','Lanzamientos','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2434')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2434','Mobile Buscador Oferta Del Día Desplegable Buscador','2','Mobile','4','Buscador','3','Oferta Del Día','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2432')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2432','Mobile Buscador Oferta Del Día Ficha','2','Mobile','4','Buscador','3','Oferta Del Día','2','Ficha')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2454')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2454','Mobile Buscador GND Desplegable Buscador','2','Mobile','4','Buscador','5','GND','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2452')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2452','Mobile Buscador GND Ficha','2','Mobile','4','Buscador','5','GND','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2464')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2464','Mobile Buscador Liquidación Desplegable Buscador','2','Mobile','4','Buscador','6','Liquidación','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2484')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2484','Mobile Buscador Herramientas de Venta Desplegable Buscador','2','Mobile','4','Buscador','8','Herramientas de Venta','4','Desplegable Buscador')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2482')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2482','Mobile Buscador Herramientas de Venta Ficha','2','Mobile','4','Buscador','8','Herramientas de Venta','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '24B4')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('24B4','Mobile Buscador Catalogo Lbel Desplegable Buscador','2','Mobile','4','Buscador','B','Catalogo Lbel','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '24C4')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('24C4','Mobile Buscador Catalogo Esika Desplegable Buscador','2','Mobile','4','Buscador','C','Catalogo Esika','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '24D4')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('24D4','Mobile Buscador Catalogo Cyzone Desplegable Buscador','2','Mobile','4','Buscador','D','Catalogo Cyzone','4','Desplegable Buscador')
END

GO
USE BelcorpCostaRica
GO
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1404')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1404','Desktop Buscador Ofertas Para Ti Desplegable Buscador','1','Desktop','4','Buscador','0','Ofertas Para Ti','4','Desplegable Buscador')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1402')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1402','Desktop Buscador Ofertas Para Ti Ficha','1','Desktop','4','Buscador','0','Ofertas Para Ti','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1414')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1414','Desktop Buscador Showroom Desplegable Buscador','1','Desktop','4','Buscador','1','Showroom','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1412')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1412','Desktop Buscador Showroom Ficha','1','Desktop','4','Buscador','1','Showroom','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1424')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1424','Desktop Buscador Lanzamientos Desplegable Buscador','1','Desktop','4','Buscador','2','Lanzamientos','4','Desplegable Buscador')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1422')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1422','Desktop Buscador Lanzamientos Ficha','1','Desktop','4','Buscador','2','Lanzamientos','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1434')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1434','Desktop Buscador Oferta Del Día Desplegable Buscador','1','Desktop','4','Buscador','3','Oferta Del Día','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1432')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1432','Desktop Buscador Oferta Del Día Ficha','1','Desktop','4','Buscador','3','Oferta Del Día','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1454')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1454','Desktop Buscador GND Desplegable Buscador','1','Desktop','4','Buscador','5','GND','4','Desplegable Buscador')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1452')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1452','Desktop Buscador GND Ficha','1','Desktop','4','Buscador','5','GND','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1464')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1464','Desktop Buscador Liquidación Desplegable Buscador','1','Desktop','4','Buscador','6','Liquidación','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1484')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1484','Desktop Buscador Herramientas de Venta Desplegable Buscador','1','Desktop','4','Buscador','8','Herramientas de Venta','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1482')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1482','Desktop Buscador Herramientas de Venta Ficha','1','Desktop','4','Buscador','8','Herramientas de Venta','2','Ficha')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '14B4')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('14B4','Desktop Buscador Catalogo Lbel Desplegable Buscador','1','Desktop','4','Buscador','B','Catalogo Lbel','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '14C4')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('14C4','Desktop Buscador Catalogo Esika Desplegable Buscador','1','Desktop','4','Buscador','C','Catalogo Esika','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '14D4')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('14D4','Desktop Buscador Catalogo Cyzone Desplegable Buscador','1','Desktop','4','Buscador','D','Catalogo Cyzone','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2404')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2404','Mobile Buscador Ofertas Para Ti Desplegable Buscador','2','Mobile','4','Buscador','0','Ofertas Para Ti','4','Desplegable Buscador')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2402')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2402','Mobile Buscador Ofertas Para Ti Ficha','2','Mobile','4','Buscador','0','Ofertas Para Ti','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2414')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2414','Mobile Buscador Showroom Desplegable Buscador','2','Mobile','4','Buscador','1','Showroom','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2412')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2412','Mobile Buscador Showroom Ficha','2','Mobile','4','Buscador','1','Showroom','2','Ficha')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2424')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2424','Mobile Buscador Lanzamientos Desplegable Buscador','2','Mobile','4','Buscador','2','Lanzamientos','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2422')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2422','Mobile Buscador Lanzamientos Ficha','2','Mobile','4','Buscador','2','Lanzamientos','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2434')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2434','Mobile Buscador Oferta Del Día Desplegable Buscador','2','Mobile','4','Buscador','3','Oferta Del Día','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2432')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2432','Mobile Buscador Oferta Del Día Ficha','2','Mobile','4','Buscador','3','Oferta Del Día','2','Ficha')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2454')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2454','Mobile Buscador GND Desplegable Buscador','2','Mobile','4','Buscador','5','GND','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2452')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2452','Mobile Buscador GND Ficha','2','Mobile','4','Buscador','5','GND','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2464')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2464','Mobile Buscador Liquidación Desplegable Buscador','2','Mobile','4','Buscador','6','Liquidación','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2484')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2484','Mobile Buscador Herramientas de Venta Desplegable Buscador','2','Mobile','4','Buscador','8','Herramientas de Venta','4','Desplegable Buscador')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2482')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2482','Mobile Buscador Herramientas de Venta Ficha','2','Mobile','4','Buscador','8','Herramientas de Venta','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '24B4')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('24B4','Mobile Buscador Catalogo Lbel Desplegable Buscador','2','Mobile','4','Buscador','B','Catalogo Lbel','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '24C4')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('24C4','Mobile Buscador Catalogo Esika Desplegable Buscador','2','Mobile','4','Buscador','C','Catalogo Esika','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '24D4')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('24D4','Mobile Buscador Catalogo Cyzone Desplegable Buscador','2','Mobile','4','Buscador','D','Catalogo Cyzone','4','Desplegable Buscador')
END

GO
USE BelcorpChile
GO
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1404')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1404','Desktop Buscador Ofertas Para Ti Desplegable Buscador','1','Desktop','4','Buscador','0','Ofertas Para Ti','4','Desplegable Buscador')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1402')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1402','Desktop Buscador Ofertas Para Ti Ficha','1','Desktop','4','Buscador','0','Ofertas Para Ti','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1414')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1414','Desktop Buscador Showroom Desplegable Buscador','1','Desktop','4','Buscador','1','Showroom','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1412')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1412','Desktop Buscador Showroom Ficha','1','Desktop','4','Buscador','1','Showroom','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1424')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1424','Desktop Buscador Lanzamientos Desplegable Buscador','1','Desktop','4','Buscador','2','Lanzamientos','4','Desplegable Buscador')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1422')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1422','Desktop Buscador Lanzamientos Ficha','1','Desktop','4','Buscador','2','Lanzamientos','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1434')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1434','Desktop Buscador Oferta Del Día Desplegable Buscador','1','Desktop','4','Buscador','3','Oferta Del Día','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1432')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1432','Desktop Buscador Oferta Del Día Ficha','1','Desktop','4','Buscador','3','Oferta Del Día','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1454')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1454','Desktop Buscador GND Desplegable Buscador','1','Desktop','4','Buscador','5','GND','4','Desplegable Buscador')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1452')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1452','Desktop Buscador GND Ficha','1','Desktop','4','Buscador','5','GND','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1464')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1464','Desktop Buscador Liquidación Desplegable Buscador','1','Desktop','4','Buscador','6','Liquidación','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1484')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1484','Desktop Buscador Herramientas de Venta Desplegable Buscador','1','Desktop','4','Buscador','8','Herramientas de Venta','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1482')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1482','Desktop Buscador Herramientas de Venta Ficha','1','Desktop','4','Buscador','8','Herramientas de Venta','2','Ficha')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '14B4')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('14B4','Desktop Buscador Catalogo Lbel Desplegable Buscador','1','Desktop','4','Buscador','B','Catalogo Lbel','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '14C4')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('14C4','Desktop Buscador Catalogo Esika Desplegable Buscador','1','Desktop','4','Buscador','C','Catalogo Esika','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '14D4')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('14D4','Desktop Buscador Catalogo Cyzone Desplegable Buscador','1','Desktop','4','Buscador','D','Catalogo Cyzone','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2404')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2404','Mobile Buscador Ofertas Para Ti Desplegable Buscador','2','Mobile','4','Buscador','0','Ofertas Para Ti','4','Desplegable Buscador')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2402')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2402','Mobile Buscador Ofertas Para Ti Ficha','2','Mobile','4','Buscador','0','Ofertas Para Ti','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2414')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2414','Mobile Buscador Showroom Desplegable Buscador','2','Mobile','4','Buscador','1','Showroom','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2412')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2412','Mobile Buscador Showroom Ficha','2','Mobile','4','Buscador','1','Showroom','2','Ficha')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2424')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2424','Mobile Buscador Lanzamientos Desplegable Buscador','2','Mobile','4','Buscador','2','Lanzamientos','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2422')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2422','Mobile Buscador Lanzamientos Ficha','2','Mobile','4','Buscador','2','Lanzamientos','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2434')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2434','Mobile Buscador Oferta Del Día Desplegable Buscador','2','Mobile','4','Buscador','3','Oferta Del Día','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2432')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2432','Mobile Buscador Oferta Del Día Ficha','2','Mobile','4','Buscador','3','Oferta Del Día','2','Ficha')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2454')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2454','Mobile Buscador GND Desplegable Buscador','2','Mobile','4','Buscador','5','GND','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2452')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2452','Mobile Buscador GND Ficha','2','Mobile','4','Buscador','5','GND','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2464')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2464','Mobile Buscador Liquidación Desplegable Buscador','2','Mobile','4','Buscador','6','Liquidación','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2484')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2484','Mobile Buscador Herramientas de Venta Desplegable Buscador','2','Mobile','4','Buscador','8','Herramientas de Venta','4','Desplegable Buscador')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2482')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2482','Mobile Buscador Herramientas de Venta Ficha','2','Mobile','4','Buscador','8','Herramientas de Venta','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '24B4')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('24B4','Mobile Buscador Catalogo Lbel Desplegable Buscador','2','Mobile','4','Buscador','B','Catalogo Lbel','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '24C4')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('24C4','Mobile Buscador Catalogo Esika Desplegable Buscador','2','Mobile','4','Buscador','C','Catalogo Esika','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '24D4')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('24D4','Mobile Buscador Catalogo Cyzone Desplegable Buscador','2','Mobile','4','Buscador','D','Catalogo Cyzone','4','Desplegable Buscador')
END

GO
USE BelcorpBolivia
GO
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1404')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1404','Desktop Buscador Ofertas Para Ti Desplegable Buscador','1','Desktop','4','Buscador','0','Ofertas Para Ti','4','Desplegable Buscador')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1402')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1402','Desktop Buscador Ofertas Para Ti Ficha','1','Desktop','4','Buscador','0','Ofertas Para Ti','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1414')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1414','Desktop Buscador Showroom Desplegable Buscador','1','Desktop','4','Buscador','1','Showroom','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1412')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1412','Desktop Buscador Showroom Ficha','1','Desktop','4','Buscador','1','Showroom','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1424')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1424','Desktop Buscador Lanzamientos Desplegable Buscador','1','Desktop','4','Buscador','2','Lanzamientos','4','Desplegable Buscador')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1422')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1422','Desktop Buscador Lanzamientos Ficha','1','Desktop','4','Buscador','2','Lanzamientos','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1434')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1434','Desktop Buscador Oferta Del Día Desplegable Buscador','1','Desktop','4','Buscador','3','Oferta Del Día','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1432')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1432','Desktop Buscador Oferta Del Día Ficha','1','Desktop','4','Buscador','3','Oferta Del Día','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1454')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1454','Desktop Buscador GND Desplegable Buscador','1','Desktop','4','Buscador','5','GND','4','Desplegable Buscador')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1452')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1452','Desktop Buscador GND Ficha','1','Desktop','4','Buscador','5','GND','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1464')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1464','Desktop Buscador Liquidación Desplegable Buscador','1','Desktop','4','Buscador','6','Liquidación','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1484')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1484','Desktop Buscador Herramientas de Venta Desplegable Buscador','1','Desktop','4','Buscador','8','Herramientas de Venta','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '1482')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('1482','Desktop Buscador Herramientas de Venta Ficha','1','Desktop','4','Buscador','8','Herramientas de Venta','2','Ficha')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '14B4')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('14B4','Desktop Buscador Catalogo Lbel Desplegable Buscador','1','Desktop','4','Buscador','B','Catalogo Lbel','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '14C4')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('14C4','Desktop Buscador Catalogo Esika Desplegable Buscador','1','Desktop','4','Buscador','C','Catalogo Esika','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '14D4')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('14D4','Desktop Buscador Catalogo Cyzone Desplegable Buscador','1','Desktop','4','Buscador','D','Catalogo Cyzone','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2404')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2404','Mobile Buscador Ofertas Para Ti Desplegable Buscador','2','Mobile','4','Buscador','0','Ofertas Para Ti','4','Desplegable Buscador')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2402')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2402','Mobile Buscador Ofertas Para Ti Ficha','2','Mobile','4','Buscador','0','Ofertas Para Ti','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2414')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2414','Mobile Buscador Showroom Desplegable Buscador','2','Mobile','4','Buscador','1','Showroom','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2412')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2412','Mobile Buscador Showroom Ficha','2','Mobile','4','Buscador','1','Showroom','2','Ficha')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2424')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2424','Mobile Buscador Lanzamientos Desplegable Buscador','2','Mobile','4','Buscador','2','Lanzamientos','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2422')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2422','Mobile Buscador Lanzamientos Ficha','2','Mobile','4','Buscador','2','Lanzamientos','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2434')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2434','Mobile Buscador Oferta Del Día Desplegable Buscador','2','Mobile','4','Buscador','3','Oferta Del Día','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2432')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2432','Mobile Buscador Oferta Del Día Ficha','2','Mobile','4','Buscador','3','Oferta Del Día','2','Ficha')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2454')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2454','Mobile Buscador GND Desplegable Buscador','2','Mobile','4','Buscador','5','GND','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2452')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2452','Mobile Buscador GND Ficha','2','Mobile','4','Buscador','5','GND','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2464')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2464','Mobile Buscador Liquidación Desplegable Buscador','2','Mobile','4','Buscador','6','Liquidación','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2484')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2484','Mobile Buscador Herramientas de Venta Desplegable Buscador','2','Mobile','4','Buscador','8','Herramientas de Venta','4','Desplegable Buscador')
END

IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '2482')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('2482','Mobile Buscador Herramientas de Venta Ficha','2','Mobile','4','Buscador','8','Herramientas de Venta','2','Ficha')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '24B4')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('24B4','Mobile Buscador Catalogo Lbel Desplegable Buscador','2','Mobile','4','Buscador','B','Catalogo Lbel','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '24C4')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('24C4','Mobile Buscador Catalogo Esika Desplegable Buscador','2','Mobile','4','Buscador','C','Catalogo Esika','4','Desplegable Buscador')
END
IF NOT EXISTS (SELECT * FROM [OrigenPedidoWeb] WHERE [CodOrigenPedidoWeb] = '24D4')
BEGIN
	INSERT INTO [dbo].[OrigenPedidoWeb] ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
VALUES ('24D4','Mobile Buscador Catalogo Cyzone Desplegable Buscador','2','Mobile','4','Buscador','D','Catalogo Cyzone','4','Desplegable Buscador')
END

GO
