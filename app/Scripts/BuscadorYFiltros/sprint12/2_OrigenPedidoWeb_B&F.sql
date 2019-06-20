GO
USE BelcorpPeru
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '1020009') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('1020009', 'Desktop Ficha Resumida Ofertas Para Ti', '1', 'Desktop', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '1020109') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('1020109', 'Desktop Ficha Resumida Showroom', '1', 'Desktop', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '1020209') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('1020209', 'Desktop Ficha Resumida Lanzamientos', '1', 'Desktop', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '1020309') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('1020309', 'Desktop Ficha Resumida Oferta Del Día', '1', 'Desktop', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '1020809') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('1020809', 'Desktop Ficha Resumida Herramientas de Venta', '1', 'Desktop', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '1021409') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('1021409', 'Desktop Ficha Resumida Ganadoras', '1', 'Desktop', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '2020009') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('2020009', 'Mobile Ficha Resumida Ofertas Para Ti', '2', 'Mobile', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '2020109') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('2020109', 'Mobile Ficha Resumida Showroom', '2', 'Mobile', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '2020209') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('2020209', 'Mobile Ficha Resumida Lanzamientos', '2', 'Mobile', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '2020309') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('2020309', 'Mobile Ficha Resumida Oferta Del Día', '2', 'Mobile', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '2020809') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('2020809', 'Mobile Ficha Resumida Herramienta de ventas', '2', 'Mobile', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '2021409') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('2021409', 'Mobile Ficha Resumida Ganadoras', '2', 'Mobile', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO

GO
USE BelcorpMexico
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '1020009') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('1020009', 'Desktop Ficha Resumida Ofertas Para Ti', '1', 'Desktop', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '1020109') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('1020109', 'Desktop Ficha Resumida Showroom', '1', 'Desktop', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '1020209') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('1020209', 'Desktop Ficha Resumida Lanzamientos', '1', 'Desktop', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '1020309') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('1020309', 'Desktop Ficha Resumida Oferta Del Día', '1', 'Desktop', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '1020809') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('1020809', 'Desktop Ficha Resumida Herramientas de Venta', '1', 'Desktop', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '1021409') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('1021409', 'Desktop Ficha Resumida Ganadoras', '1', 'Desktop', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '2020009') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('2020009', 'Mobile Ficha Resumida Ofertas Para Ti', '2', 'Mobile', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '2020109') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('2020109', 'Mobile Ficha Resumida Showroom', '2', 'Mobile', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '2020209') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('2020209', 'Mobile Ficha Resumida Lanzamientos', '2', 'Mobile', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '2020309') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('2020309', 'Mobile Ficha Resumida Oferta Del Día', '2', 'Mobile', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '2020809') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('2020809', 'Mobile Ficha Resumida Herramienta de ventas', '2', 'Mobile', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '2021409') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('2021409', 'Mobile Ficha Resumida Ganadoras', '2', 'Mobile', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO

GO
USE BelcorpColombia
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '1020009') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('1020009', 'Desktop Ficha Resumida Ofertas Para Ti', '1', 'Desktop', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '1020109') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('1020109', 'Desktop Ficha Resumida Showroom', '1', 'Desktop', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '1020209') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('1020209', 'Desktop Ficha Resumida Lanzamientos', '1', 'Desktop', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '1020309') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('1020309', 'Desktop Ficha Resumida Oferta Del Día', '1', 'Desktop', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '1020809') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('1020809', 'Desktop Ficha Resumida Herramientas de Venta', '1', 'Desktop', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '1021409') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('1021409', 'Desktop Ficha Resumida Ganadoras', '1', 'Desktop', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '2020009') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('2020009', 'Mobile Ficha Resumida Ofertas Para Ti', '2', 'Mobile', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '2020109') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('2020109', 'Mobile Ficha Resumida Showroom', '2', 'Mobile', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '2020209') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('2020209', 'Mobile Ficha Resumida Lanzamientos', '2', 'Mobile', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '2020309') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('2020309', 'Mobile Ficha Resumida Oferta Del Día', '2', 'Mobile', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '2020809') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('2020809', 'Mobile Ficha Resumida Herramienta de ventas', '2', 'Mobile', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '2021409') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('2021409', 'Mobile Ficha Resumida Ganadoras', '2', 'Mobile', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO

GO
USE BelcorpSalvador
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '1020009') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('1020009', 'Desktop Ficha Resumida Ofertas Para Ti', '1', 'Desktop', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '1020109') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('1020109', 'Desktop Ficha Resumida Showroom', '1', 'Desktop', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '1020209') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('1020209', 'Desktop Ficha Resumida Lanzamientos', '1', 'Desktop', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '1020309') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('1020309', 'Desktop Ficha Resumida Oferta Del Día', '1', 'Desktop', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '1020809') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('1020809', 'Desktop Ficha Resumida Herramientas de Venta', '1', 'Desktop', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '1021409') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('1021409', 'Desktop Ficha Resumida Ganadoras', '1', 'Desktop', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '2020009') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('2020009', 'Mobile Ficha Resumida Ofertas Para Ti', '2', 'Mobile', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '2020109') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('2020109', 'Mobile Ficha Resumida Showroom', '2', 'Mobile', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '2020209') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('2020209', 'Mobile Ficha Resumida Lanzamientos', '2', 'Mobile', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '2020309') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('2020309', 'Mobile Ficha Resumida Oferta Del Día', '2', 'Mobile', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '2020809') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('2020809', 'Mobile Ficha Resumida Herramienta de ventas', '2', 'Mobile', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '2021409') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('2021409', 'Mobile Ficha Resumida Ganadoras', '2', 'Mobile', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO

GO
USE BelcorpPuertoRico
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '1020009') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('1020009', 'Desktop Ficha Resumida Ofertas Para Ti', '1', 'Desktop', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '1020109') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('1020109', 'Desktop Ficha Resumida Showroom', '1', 'Desktop', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '1020209') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('1020209', 'Desktop Ficha Resumida Lanzamientos', '1', 'Desktop', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '1020309') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('1020309', 'Desktop Ficha Resumida Oferta Del Día', '1', 'Desktop', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '1020809') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('1020809', 'Desktop Ficha Resumida Herramientas de Venta', '1', 'Desktop', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '1021409') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('1021409', 'Desktop Ficha Resumida Ganadoras', '1', 'Desktop', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '2020009') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('2020009', 'Mobile Ficha Resumida Ofertas Para Ti', '2', 'Mobile', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '2020109') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('2020109', 'Mobile Ficha Resumida Showroom', '2', 'Mobile', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '2020209') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('2020209', 'Mobile Ficha Resumida Lanzamientos', '2', 'Mobile', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '2020309') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('2020309', 'Mobile Ficha Resumida Oferta Del Día', '2', 'Mobile', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '2020809') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('2020809', 'Mobile Ficha Resumida Herramienta de ventas', '2', 'Mobile', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '2021409') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('2021409', 'Mobile Ficha Resumida Ganadoras', '2', 'Mobile', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO

GO
USE BelcorpPanama
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '1020009') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('1020009', 'Desktop Ficha Resumida Ofertas Para Ti', '1', 'Desktop', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '1020109') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('1020109', 'Desktop Ficha Resumida Showroom', '1', 'Desktop', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '1020209') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('1020209', 'Desktop Ficha Resumida Lanzamientos', '1', 'Desktop', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '1020309') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('1020309', 'Desktop Ficha Resumida Oferta Del Día', '1', 'Desktop', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '1020809') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('1020809', 'Desktop Ficha Resumida Herramientas de Venta', '1', 'Desktop', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '1021409') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('1021409', 'Desktop Ficha Resumida Ganadoras', '1', 'Desktop', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '2020009') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('2020009', 'Mobile Ficha Resumida Ofertas Para Ti', '2', 'Mobile', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '2020109') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('2020109', 'Mobile Ficha Resumida Showroom', '2', 'Mobile', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '2020209') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('2020209', 'Mobile Ficha Resumida Lanzamientos', '2', 'Mobile', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '2020309') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('2020309', 'Mobile Ficha Resumida Oferta Del Día', '2', 'Mobile', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '2020809') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('2020809', 'Mobile Ficha Resumida Herramienta de ventas', '2', 'Mobile', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '2021409') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('2021409', 'Mobile Ficha Resumida Ganadoras', '2', 'Mobile', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO

GO
USE BelcorpGuatemala
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '1020009') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('1020009', 'Desktop Ficha Resumida Ofertas Para Ti', '1', 'Desktop', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '1020109') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('1020109', 'Desktop Ficha Resumida Showroom', '1', 'Desktop', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '1020209') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('1020209', 'Desktop Ficha Resumida Lanzamientos', '1', 'Desktop', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '1020309') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('1020309', 'Desktop Ficha Resumida Oferta Del Día', '1', 'Desktop', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '1020809') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('1020809', 'Desktop Ficha Resumida Herramientas de Venta', '1', 'Desktop', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '1021409') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('1021409', 'Desktop Ficha Resumida Ganadoras', '1', 'Desktop', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '2020009') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('2020009', 'Mobile Ficha Resumida Ofertas Para Ti', '2', 'Mobile', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '2020109') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('2020109', 'Mobile Ficha Resumida Showroom', '2', 'Mobile', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '2020209') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('2020209', 'Mobile Ficha Resumida Lanzamientos', '2', 'Mobile', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '2020309') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('2020309', 'Mobile Ficha Resumida Oferta Del Día', '2', 'Mobile', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '2020809') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('2020809', 'Mobile Ficha Resumida Herramienta de ventas', '2', 'Mobile', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '2021409') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('2021409', 'Mobile Ficha Resumida Ganadoras', '2', 'Mobile', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO

GO
USE BelcorpEcuador
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '1020009') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('1020009', 'Desktop Ficha Resumida Ofertas Para Ti', '1', 'Desktop', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '1020109') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('1020109', 'Desktop Ficha Resumida Showroom', '1', 'Desktop', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '1020209') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('1020209', 'Desktop Ficha Resumida Lanzamientos', '1', 'Desktop', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '1020309') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('1020309', 'Desktop Ficha Resumida Oferta Del Día', '1', 'Desktop', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '1020809') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('1020809', 'Desktop Ficha Resumida Herramientas de Venta', '1', 'Desktop', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '1021409') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('1021409', 'Desktop Ficha Resumida Ganadoras', '1', 'Desktop', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '2020009') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('2020009', 'Mobile Ficha Resumida Ofertas Para Ti', '2', 'Mobile', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '2020109') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('2020109', 'Mobile Ficha Resumida Showroom', '2', 'Mobile', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '2020209') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('2020209', 'Mobile Ficha Resumida Lanzamientos', '2', 'Mobile', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '2020309') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('2020309', 'Mobile Ficha Resumida Oferta Del Día', '2', 'Mobile', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '2020809') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('2020809', 'Mobile Ficha Resumida Herramienta de ventas', '2', 'Mobile', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '2021409') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('2021409', 'Mobile Ficha Resumida Ganadoras', '2', 'Mobile', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO

GO
USE BelcorpDominicana
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '1020009') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('1020009', 'Desktop Ficha Resumida Ofertas Para Ti', '1', 'Desktop', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '1020109') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('1020109', 'Desktop Ficha Resumida Showroom', '1', 'Desktop', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '1020209') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('1020209', 'Desktop Ficha Resumida Lanzamientos', '1', 'Desktop', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '1020309') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('1020309', 'Desktop Ficha Resumida Oferta Del Día', '1', 'Desktop', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '1020809') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('1020809', 'Desktop Ficha Resumida Herramientas de Venta', '1', 'Desktop', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '1021409') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('1021409', 'Desktop Ficha Resumida Ganadoras', '1', 'Desktop', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '2020009') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('2020009', 'Mobile Ficha Resumida Ofertas Para Ti', '2', 'Mobile', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '2020109') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('2020109', 'Mobile Ficha Resumida Showroom', '2', 'Mobile', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '2020209') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('2020209', 'Mobile Ficha Resumida Lanzamientos', '2', 'Mobile', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '2020309') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('2020309', 'Mobile Ficha Resumida Oferta Del Día', '2', 'Mobile', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '2020809') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('2020809', 'Mobile Ficha Resumida Herramienta de ventas', '2', 'Mobile', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '2021409') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('2021409', 'Mobile Ficha Resumida Ganadoras', '2', 'Mobile', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO

GO
USE BelcorpCostaRica
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '1020009') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('1020009', 'Desktop Ficha Resumida Ofertas Para Ti', '1', 'Desktop', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '1020109') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('1020109', 'Desktop Ficha Resumida Showroom', '1', 'Desktop', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '1020209') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('1020209', 'Desktop Ficha Resumida Lanzamientos', '1', 'Desktop', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '1020309') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('1020309', 'Desktop Ficha Resumida Oferta Del Día', '1', 'Desktop', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '1020809') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('1020809', 'Desktop Ficha Resumida Herramientas de Venta', '1', 'Desktop', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '1021409') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('1021409', 'Desktop Ficha Resumida Ganadoras', '1', 'Desktop', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '2020009') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('2020009', 'Mobile Ficha Resumida Ofertas Para Ti', '2', 'Mobile', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '2020109') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('2020109', 'Mobile Ficha Resumida Showroom', '2', 'Mobile', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '2020209') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('2020209', 'Mobile Ficha Resumida Lanzamientos', '2', 'Mobile', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '2020309') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('2020309', 'Mobile Ficha Resumida Oferta Del Día', '2', 'Mobile', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '2020809') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('2020809', 'Mobile Ficha Resumida Herramienta de ventas', '2', 'Mobile', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '2021409') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('2021409', 'Mobile Ficha Resumida Ganadoras', '2', 'Mobile', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO

GO
USE BelcorpChile
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '1020009') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('1020009', 'Desktop Ficha Resumida Ofertas Para Ti', '1', 'Desktop', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '1020109') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('1020109', 'Desktop Ficha Resumida Showroom', '1', 'Desktop', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '1020209') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('1020209', 'Desktop Ficha Resumida Lanzamientos', '1', 'Desktop', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '1020309') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('1020309', 'Desktop Ficha Resumida Oferta Del Día', '1', 'Desktop', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '1020809') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('1020809', 'Desktop Ficha Resumida Herramientas de Venta', '1', 'Desktop', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '1021409') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('1021409', 'Desktop Ficha Resumida Ganadoras', '1', 'Desktop', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '2020009') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('2020009', 'Mobile Ficha Resumida Ofertas Para Ti', '2', 'Mobile', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '2020109') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('2020109', 'Mobile Ficha Resumida Showroom', '2', 'Mobile', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '2020209') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('2020209', 'Mobile Ficha Resumida Lanzamientos', '2', 'Mobile', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '2020309') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('2020309', 'Mobile Ficha Resumida Oferta Del Día', '2', 'Mobile', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '2020809') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('2020809', 'Mobile Ficha Resumida Herramienta de ventas', '2', 'Mobile', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '2021409') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('2021409', 'Mobile Ficha Resumida Ganadoras', '2', 'Mobile', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO

GO
USE BelcorpBolivia
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '1020009') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('1020009', 'Desktop Ficha Resumida Ofertas Para Ti', '1', 'Desktop', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '1020109') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('1020109', 'Desktop Ficha Resumida Showroom', '1', 'Desktop', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '1020209') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('1020209', 'Desktop Ficha Resumida Lanzamientos', '1', 'Desktop', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '1020309') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('1020309', 'Desktop Ficha Resumida Oferta Del Día', '1', 'Desktop', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '1020809') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('1020809', 'Desktop Ficha Resumida Herramientas de Venta', '1', 'Desktop', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '1021409') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('1021409', 'Desktop Ficha Resumida Ganadoras', '1', 'Desktop', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '2020009') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('2020009', 'Mobile Ficha Resumida Ofertas Para Ti', '2', 'Mobile', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '2020109') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('2020109', 'Mobile Ficha Resumida Showroom', '2', 'Mobile', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '2020209') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('2020209', 'Mobile Ficha Resumida Lanzamientos', '2', 'Mobile', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '2020309') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('2020309', 'Mobile Ficha Resumida Oferta Del Día', '2', 'Mobile', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '2020809') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('2020809', 'Mobile Ficha Resumida Herramienta de ventas', '2', 'Mobile', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO
IF (SELECT Count(*) FROM   origenpedidoweb WHERE  codorigenpedidoweb = '2021409') = 0
BEGIN
    INSERT INTO [dbo].[origenpedidoweb] (codorigenpedidoweb, desorigenpedidoweb, codmedio, desmedio, codzona, deszona, codseccion, desseccion, codpopup, despopup)
    VALUES ('2021409', 'Mobile Ficha Resumida Ganadoras', '2', 'Mobile', '02', 'Pedido', '15', 'Producto Recomendado', '02', 'Ficha')
END
GO

GO
