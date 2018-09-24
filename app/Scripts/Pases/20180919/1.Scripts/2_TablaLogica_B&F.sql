GO
USE BelcorpPeru
GO
IF NOT EXISTS (SELECT * FROM [TablaLogica] WHERE [TablaLogicaID] = 145)
BEGIN
	INSERT [dbo].[TablaLogica] ([TablaLogicaID], [Descripcion]) VALUES (145, N'Descripción Producto')

	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14501,145,'CLUBGANA+','Gana+')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14502,145,'SOLOHOY','¡Sólo Hoy')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14503,145,'CATALOGOLBEL','Catálogo L''Bel')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14504,145,'CATALOGOESIKA','Catálogo Ésika')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14505,145,'CATALOGOCYZONE','Catálogo Cyzone')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14506,145,'OFERTASLIQUIDACION','Ofertas Liquidación')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14507,145,'OFERTAPARATI','Ofertas Digitales')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14508,145,'LANZAMIENTOS','Ofertas Digitales')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14509,145,'OFERTADELDIA','¡Sólo Hoy!')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14510,145,'GUIADENEGOCIODIGITAL','Ofertas Digitales')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14511,145,'HERRAMIENTASDEVENTA','Ofertas Digitales')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14512,145,'ESPECIALES','Ofertas Digitales')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14513,145,'OFERTASFLEXIPAGO','Ofertas Flexipago')
END

GO
USE BelcorpMexico
GO
IF NOT EXISTS (SELECT * FROM [TablaLogica] WHERE [TablaLogicaID] = 145)
BEGIN
	INSERT [dbo].[TablaLogica] ([TablaLogicaID], [Descripcion]) VALUES (145, N'Descripción Producto')

	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14501,145,'CLUBGANA+','Gana+')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14502,145,'SOLOHOY','¡Sólo Hoy')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14503,145,'CATALOGOLBEL','Catálogo L''Bel')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14504,145,'CATALOGOESIKA','Catálogo Ésika')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14505,145,'CATALOGOCYZONE','Catálogo Cyzone')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14506,145,'OFERTASLIQUIDACION','Ofertas Liquidación')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14507,145,'OFERTAPARATI','Ofertas Digitales')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14508,145,'LANZAMIENTOS','Ofertas Digitales')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14509,145,'OFERTADELDIA','¡Sólo Hoy!')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14510,145,'GUIADENEGOCIODIGITAL','Ofertas Digitales')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14511,145,'HERRAMIENTASDEVENTA','Ofertas Digitales')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14512,145,'ESPECIALES','Ofertas Digitales')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14513,145,'OFERTASFLEXIPAGO','Ofertas Flexipago')
END

GO
USE BelcorpColombia
GO
IF NOT EXISTS (SELECT * FROM [TablaLogica] WHERE [TablaLogicaID] = 145)
BEGIN
	INSERT [dbo].[TablaLogica] ([TablaLogicaID], [Descripcion]) VALUES (145, N'Descripción Producto')

	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14501,145,'CLUBGANA+','Gana+')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14502,145,'SOLOHOY','¡Sólo Hoy')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14503,145,'CATALOGOLBEL','Catálogo L''Bel')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14504,145,'CATALOGOESIKA','Catálogo Ésika')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14505,145,'CATALOGOCYZONE','Catálogo Cyzone')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14506,145,'OFERTASLIQUIDACION','Ofertas Liquidación')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14507,145,'OFERTAPARATI','Ofertas Digitales')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14508,145,'LANZAMIENTOS','Ofertas Digitales')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14509,145,'OFERTADELDIA','¡Sólo Hoy!')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14510,145,'GUIADENEGOCIODIGITAL','Ofertas Digitales')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14511,145,'HERRAMIENTASDEVENTA','Ofertas Digitales')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14512,145,'ESPECIALES','Ofertas Digitales')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14513,145,'OFERTASFLEXIPAGO','Ofertas Flexipago')
END

GO
USE BelcorpSalvador
GO
IF NOT EXISTS (SELECT * FROM [TablaLogica] WHERE [TablaLogicaID] = 145)
BEGIN
	INSERT [dbo].[TablaLogica] ([TablaLogicaID], [Descripcion]) VALUES (145, N'Descripción Producto')

	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14501,145,'CLUBGANA+','Gana+')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14502,145,'SOLOHOY','¡Sólo Hoy')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14503,145,'CATALOGOLBEL','Catálogo L''Bel')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14504,145,'CATALOGOESIKA','Catálogo Ésika')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14505,145,'CATALOGOCYZONE','Catálogo Cyzone')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14506,145,'OFERTASLIQUIDACION','Ofertas Liquidación')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14507,145,'OFERTAPARATI','Ofertas Digitales')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14508,145,'LANZAMIENTOS','Ofertas Digitales')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14509,145,'OFERTADELDIA','¡Sólo Hoy!')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14510,145,'GUIADENEGOCIODIGITAL','Ofertas Digitales')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14511,145,'HERRAMIENTASDEVENTA','Ofertas Digitales')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14512,145,'ESPECIALES','Ofertas Digitales')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14513,145,'OFERTASFLEXIPAGO','Ofertas Flexipago')
END

GO
USE BelcorpPuertoRico
GO
IF NOT EXISTS (SELECT * FROM [TablaLogica] WHERE [TablaLogicaID] = 145)
BEGIN
	INSERT [dbo].[TablaLogica] ([TablaLogicaID], [Descripcion]) VALUES (145, N'Descripción Producto')

	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14501,145,'CLUBGANA+','Gana+')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14502,145,'SOLOHOY','¡Sólo Hoy')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14503,145,'CATALOGOLBEL','Catálogo L''Bel')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14504,145,'CATALOGOESIKA','Catálogo Ésika')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14505,145,'CATALOGOCYZONE','Catálogo Cyzone')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14506,145,'OFERTASLIQUIDACION','Ofertas Liquidación')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14507,145,'OFERTAPARATI','Ofertas Digitales')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14508,145,'LANZAMIENTOS','Ofertas Digitales')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14509,145,'OFERTADELDIA','¡Sólo Hoy!')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14510,145,'GUIADENEGOCIODIGITAL','Ofertas Digitales')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14511,145,'HERRAMIENTASDEVENTA','Ofertas Digitales')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14512,145,'ESPECIALES','Ofertas Digitales')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14513,145,'OFERTASFLEXIPAGO','Ofertas Flexipago')
END

GO
USE BelcorpPanama
GO
IF NOT EXISTS (SELECT * FROM [TablaLogica] WHERE [TablaLogicaID] = 145)
BEGIN
	INSERT [dbo].[TablaLogica] ([TablaLogicaID], [Descripcion]) VALUES (145, N'Descripción Producto')

	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14501,145,'CLUBGANA+','Gana+')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14502,145,'SOLOHOY','¡Sólo Hoy')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14503,145,'CATALOGOLBEL','Catálogo L''Bel')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14504,145,'CATALOGOESIKA','Catálogo Ésika')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14505,145,'CATALOGOCYZONE','Catálogo Cyzone')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14506,145,'OFERTASLIQUIDACION','Ofertas Liquidación')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14507,145,'OFERTAPARATI','Ofertas Digitales')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14508,145,'LANZAMIENTOS','Ofertas Digitales')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14509,145,'OFERTADELDIA','¡Sólo Hoy!')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14510,145,'GUIADENEGOCIODIGITAL','Ofertas Digitales')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14511,145,'HERRAMIENTASDEVENTA','Ofertas Digitales')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14512,145,'ESPECIALES','Ofertas Digitales')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14513,145,'OFERTASFLEXIPAGO','Ofertas Flexipago')
END

GO
USE BelcorpGuatemala
GO
IF NOT EXISTS (SELECT * FROM [TablaLogica] WHERE [TablaLogicaID] = 145)
BEGIN
	INSERT [dbo].[TablaLogica] ([TablaLogicaID], [Descripcion]) VALUES (145, N'Descripción Producto')

	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14501,145,'CLUBGANA+','Gana+')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14502,145,'SOLOHOY','¡Sólo Hoy')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14503,145,'CATALOGOLBEL','Catálogo L''Bel')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14504,145,'CATALOGOESIKA','Catálogo Ésika')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14505,145,'CATALOGOCYZONE','Catálogo Cyzone')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14506,145,'OFERTASLIQUIDACION','Ofertas Liquidación')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14507,145,'OFERTAPARATI','Ofertas Digitales')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14508,145,'LANZAMIENTOS','Ofertas Digitales')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14509,145,'OFERTADELDIA','¡Sólo Hoy!')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14510,145,'GUIADENEGOCIODIGITAL','Ofertas Digitales')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14511,145,'HERRAMIENTASDEVENTA','Ofertas Digitales')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14512,145,'ESPECIALES','Ofertas Digitales')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14513,145,'OFERTASFLEXIPAGO','Ofertas Flexipago')
END

GO
USE BelcorpEcuador
GO
IF NOT EXISTS (SELECT * FROM [TablaLogica] WHERE [TablaLogicaID] = 145)
BEGIN
	INSERT [dbo].[TablaLogica] ([TablaLogicaID], [Descripcion]) VALUES (145, N'Descripción Producto')

	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14501,145,'CLUBGANA+','Gana+')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14502,145,'SOLOHOY','¡Sólo Hoy')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14503,145,'CATALOGOLBEL','Catálogo L''Bel')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14504,145,'CATALOGOESIKA','Catálogo Ésika')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14505,145,'CATALOGOCYZONE','Catálogo Cyzone')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14506,145,'OFERTASLIQUIDACION','Ofertas Liquidación')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14507,145,'OFERTAPARATI','Ofertas Digitales')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14508,145,'LANZAMIENTOS','Ofertas Digitales')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14509,145,'OFERTADELDIA','¡Sólo Hoy!')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14510,145,'GUIADENEGOCIODIGITAL','Ofertas Digitales')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14511,145,'HERRAMIENTASDEVENTA','Ofertas Digitales')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14512,145,'ESPECIALES','Ofertas Digitales')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14513,145,'OFERTASFLEXIPAGO','Ofertas Flexipago')
END

GO
USE BelcorpDominicana
GO
IF NOT EXISTS (SELECT * FROM [TablaLogica] WHERE [TablaLogicaID] = 145)
BEGIN
	INSERT [dbo].[TablaLogica] ([TablaLogicaID], [Descripcion]) VALUES (145, N'Descripción Producto')

	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14501,145,'CLUBGANA+','Gana+')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14502,145,'SOLOHOY','¡Sólo Hoy')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14503,145,'CATALOGOLBEL','Catálogo L''Bel')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14504,145,'CATALOGOESIKA','Catálogo Ésika')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14505,145,'CATALOGOCYZONE','Catálogo Cyzone')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14506,145,'OFERTASLIQUIDACION','Ofertas Liquidación')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14507,145,'OFERTAPARATI','Ofertas Digitales')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14508,145,'LANZAMIENTOS','Ofertas Digitales')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14509,145,'OFERTADELDIA','¡Sólo Hoy!')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14510,145,'GUIADENEGOCIODIGITAL','Ofertas Digitales')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14511,145,'HERRAMIENTASDEVENTA','Ofertas Digitales')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14512,145,'ESPECIALES','Ofertas Digitales')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14513,145,'OFERTASFLEXIPAGO','Ofertas Flexipago')
END

GO
USE BelcorpCostaRica
GO
IF NOT EXISTS (SELECT * FROM [TablaLogica] WHERE [TablaLogicaID] = 145)
BEGIN
	INSERT [dbo].[TablaLogica] ([TablaLogicaID], [Descripcion]) VALUES (145, N'Descripción Producto')

	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14501,145,'CLUBGANA+','Gana+')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14502,145,'SOLOHOY','¡Sólo Hoy')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14503,145,'CATALOGOLBEL','Catálogo L''Bel')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14504,145,'CATALOGOESIKA','Catálogo Ésika')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14505,145,'CATALOGOCYZONE','Catálogo Cyzone')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14506,145,'OFERTASLIQUIDACION','Ofertas Liquidación')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14507,145,'OFERTAPARATI','Ofertas Digitales')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14508,145,'LANZAMIENTOS','Ofertas Digitales')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14509,145,'OFERTADELDIA','¡Sólo Hoy!')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14510,145,'GUIADENEGOCIODIGITAL','Ofertas Digitales')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14511,145,'HERRAMIENTASDEVENTA','Ofertas Digitales')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14512,145,'ESPECIALES','Ofertas Digitales')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14513,145,'OFERTASFLEXIPAGO','Ofertas Flexipago')
END

GO
USE BelcorpChile
GO
IF NOT EXISTS (SELECT * FROM [TablaLogica] WHERE [TablaLogicaID] = 145)
BEGIN
	INSERT [dbo].[TablaLogica] ([TablaLogicaID], [Descripcion]) VALUES (145, N'Descripción Producto')

	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14501,145,'CLUBGANA+','Gana+')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14502,145,'SOLOHOY','¡Sólo Hoy')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14503,145,'CATALOGOLBEL','Catálogo L''Bel')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14504,145,'CATALOGOESIKA','Catálogo Ésika')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14505,145,'CATALOGOCYZONE','Catálogo Cyzone')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14506,145,'OFERTASLIQUIDACION','Ofertas Liquidación')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14507,145,'OFERTAPARATI','Ofertas Digitales')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14508,145,'LANZAMIENTOS','Ofertas Digitales')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14509,145,'OFERTADELDIA','¡Sólo Hoy!')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14510,145,'GUIADENEGOCIODIGITAL','Ofertas Digitales')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14511,145,'HERRAMIENTASDEVENTA','Ofertas Digitales')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14512,145,'ESPECIALES','Ofertas Digitales')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14513,145,'OFERTASFLEXIPAGO','Ofertas Flexipago')
END

GO
USE BelcorpBolivia
GO
IF NOT EXISTS (SELECT * FROM [TablaLogica] WHERE [TablaLogicaID] = 145)
BEGIN
	INSERT [dbo].[TablaLogica] ([TablaLogicaID], [Descripcion]) VALUES (145, N'Descripción Producto')

	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14501,145,'CLUBGANA+','Gana+')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14502,145,'SOLOHOY','¡Sólo Hoy')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14503,145,'CATALOGOLBEL','Catálogo L''Bel')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14504,145,'CATALOGOESIKA','Catálogo Ésika')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14505,145,'CATALOGOCYZONE','Catálogo Cyzone')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14506,145,'OFERTASLIQUIDACION','Ofertas Liquidación')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14507,145,'OFERTAPARATI','Ofertas Digitales')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14508,145,'LANZAMIENTOS','Ofertas Digitales')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14509,145,'OFERTADELDIA','¡Sólo Hoy!')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14510,145,'GUIADENEGOCIODIGITAL','Ofertas Digitales')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14511,145,'HERRAMIENTASDEVENTA','Ofertas Digitales')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14512,145,'ESPECIALES','Ofertas Digitales')
	INSERT INTO TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) VALUES(14513,145,'OFERTASFLEXIPAGO','Ofertas Flexipago')
END

GO
