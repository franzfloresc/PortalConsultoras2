
USE BelcorpBolivia
GO

IF NOT EXISTS (SELECT 1 FROM dbo.TablaLogica WHERE TablaLogicaID = 94)
BEGIN
	INSERT INTO [dbo].[TablaLogica] VALUES (94,'Ordernamiento FAV')
	
	-- Ordenamiento
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9303,94,'01','PRECIO | menor a mayor')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9304,94,'02','PRECIO | mayor a menor')
END

IF NOT EXISTS (SELECT 1 FROM dbo.TablaLogica WHERE TablaLogicaID = 95)
BEGIN
	INSERT INTO [dbo].[TablaLogica] VALUES (95,'Filtro Categorias FAV')
	
	-- Categorias
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9306,95,'01','FRAGANCIAS')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9307,95,'02','MAQUILLAJE')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9308,95,'04','CUIDADO PERSONAL')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9309,95,'09','TRATAMIENTO CORPORAL')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9310,95,'10','TRATAMIENTO FACIAL')
END

IF NOT EXISTS (SELECT 1 FROM dbo.TablaLogica WHERE TablaLogicaID = 96)
BEGIN
	INSERT INTO [dbo].[TablaLogica] VALUES (96,'Filtro Marcas FAV')
	
	-- Marca
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9311,96,'L','L´BEL')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9312,96,'E','ÉSIKA')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9313,96,'C','CYZONE')
END

IF NOT EXISTS (SELECT 1 FROM dbo.TablaLogica WHERE TablaLogicaID = 97)
BEGIN
	INSERT INTO [dbo].[TablaLogica] VALUES (97,'Filtro Tipo Publicación FAV')
	
	-- Tipo Publicacion
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9314,97,'SC','SOLO CATALOGO')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9315,97,'SN','SOLO GUIA DE NEGOCIO')
END

GO
/*end*/

USE BelcorpChile
GO

IF NOT EXISTS (SELECT 1 FROM dbo.TablaLogica WHERE TablaLogicaID = 94)
BEGIN
	INSERT INTO [dbo].[TablaLogica] VALUES (94,'Ordernamiento FAV')
	
	-- Ordenamiento
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9303,94,'01','PRECIO | menor a mayor')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9304,94,'02','PRECIO | mayor a menor')
END

IF NOT EXISTS (SELECT 1 FROM dbo.TablaLogica WHERE TablaLogicaID = 95)
BEGIN
	INSERT INTO [dbo].[TablaLogica] VALUES (95,'Filtro Categorias FAV')
	
	-- Categorias
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9306,95,'01','FRAGANCIAS')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9307,95,'02','MAQUILLAJE')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9308,95,'04','CUIDADO PERSONAL')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9309,95,'09','TRATAMIENTO CORPORAL')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9310,95,'10','TRATAMIENTO FACIAL')
END

IF NOT EXISTS (SELECT 1 FROM dbo.TablaLogica WHERE TablaLogicaID = 96)
BEGIN
	INSERT INTO [dbo].[TablaLogica] VALUES (96,'Filtro Marcas FAV')
	
	-- Marca
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9311,96,'L','L´BEL')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9312,96,'E','ÉSIKA')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9313,96,'C','CYZONE')
END

IF NOT EXISTS (SELECT 1 FROM dbo.TablaLogica WHERE TablaLogicaID = 97)
BEGIN
	INSERT INTO [dbo].[TablaLogica] VALUES (97,'Filtro Tipo Publicación FAV')
	
	-- Tipo Publicacion
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9314,97,'SC','SOLO CATALOGO')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9315,97,'SN','SOLO GUIA DE NEGOCIO')
END

GO
/*end*/

USE BelcorpColombia
GO

IF NOT EXISTS (SELECT 1 FROM dbo.TablaLogica WHERE TablaLogicaID = 94)
BEGIN
	INSERT INTO [dbo].[TablaLogica] VALUES (94,'Ordernamiento FAV')
	
	-- Ordenamiento
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9303,94,'01','PRECIO | menor a mayor')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9304,94,'02','PRECIO | mayor a menor')
END

IF NOT EXISTS (SELECT 1 FROM dbo.TablaLogica WHERE TablaLogicaID = 95)
BEGIN
	INSERT INTO [dbo].[TablaLogica] VALUES (95,'Filtro Categorias FAV')
	
	-- Categorias
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9306,95,'01','FRAGANCIAS')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9307,95,'02','MAQUILLAJE')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9308,95,'04','CUIDADO PERSONAL')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9309,95,'09','TRATAMIENTO CORPORAL')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9310,95,'10','TRATAMIENTO FACIAL')
END

IF NOT EXISTS (SELECT 1 FROM dbo.TablaLogica WHERE TablaLogicaID = 96)
BEGIN
	INSERT INTO [dbo].[TablaLogica] VALUES (96,'Filtro Marcas FAV')
	
	-- Marca
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9311,96,'L','L´BEL')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9312,96,'E','ÉSIKA')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9313,96,'C','CYZONE')
END

IF NOT EXISTS (SELECT 1 FROM dbo.TablaLogica WHERE TablaLogicaID = 97)
BEGIN
	INSERT INTO [dbo].[TablaLogica] VALUES (97,'Filtro Tipo Publicación FAV')
	
	-- Tipo Publicacion
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9314,97,'SC','SOLO CATALOGO')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9315,97,'SN','SOLO GUIA DE NEGOCIO')
END

GO
/*end*/

USE BelcorpCostaRica
GO

IF NOT EXISTS (SELECT 1 FROM dbo.TablaLogica WHERE TablaLogicaID = 94)
BEGIN
	INSERT INTO [dbo].[TablaLogica] VALUES (94,'Ordernamiento FAV')
	
	-- Ordenamiento
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9303,94,'01','PRECIO | menor a mayor')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9304,94,'02','PRECIO | mayor a menor')
END

IF NOT EXISTS (SELECT 1 FROM dbo.TablaLogica WHERE TablaLogicaID = 95)
BEGIN
	INSERT INTO [dbo].[TablaLogica] VALUES (95,'Filtro Categorias FAV')
	
	-- Categorias
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9306,95,'01','FRAGANCIAS')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9307,95,'02','MAQUILLAJE')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9308,95,'04','CUIDADO PERSONAL')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9309,95,'09','TRATAMIENTO CORPORAL')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9310,95,'10','TRATAMIENTO FACIAL')
END

IF NOT EXISTS (SELECT 1 FROM dbo.TablaLogica WHERE TablaLogicaID = 96)
BEGIN
	INSERT INTO [dbo].[TablaLogica] VALUES (96,'Filtro Marcas FAV')
	
	-- Marca
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9311,96,'L','L´BEL')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9312,96,'E','ÉSIKA')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9313,96,'C','CYZONE')
END

IF NOT EXISTS (SELECT 1 FROM dbo.TablaLogica WHERE TablaLogicaID = 97)
BEGIN
	INSERT INTO [dbo].[TablaLogica] VALUES (97,'Filtro Tipo Publicación FAV')
	
	-- Tipo Publicacion
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9314,97,'SC','SOLO CATALOGO')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9315,97,'SN','SOLO GUIA DE NEGOCIO')
END

GO
/*end*/

USE BelcorpDominicana
GO

IF NOT EXISTS (SELECT 1 FROM dbo.TablaLogica WHERE TablaLogicaID = 94)
BEGIN
	INSERT INTO [dbo].[TablaLogica] VALUES (94,'Ordernamiento FAV')
	
	-- Ordenamiento
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9303,94,'01','PRECIO | menor a mayor')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9304,94,'02','PRECIO | mayor a menor')
END

IF NOT EXISTS (SELECT 1 FROM dbo.TablaLogica WHERE TablaLogicaID = 95)
BEGIN
	INSERT INTO [dbo].[TablaLogica] VALUES (95,'Filtro Categorias FAV')
	
	-- Categorias
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9306,95,'01','FRAGANCIAS')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9307,95,'02','MAQUILLAJE')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9308,95,'04','CUIDADO PERSONAL')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9309,95,'09','TRATAMIENTO CORPORAL')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9310,95,'10','TRATAMIENTO FACIAL')
END

IF NOT EXISTS (SELECT 1 FROM dbo.TablaLogica WHERE TablaLogicaID = 96)
BEGIN
	INSERT INTO [dbo].[TablaLogica] VALUES (96,'Filtro Marcas FAV')
	
	-- Marca
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9311,96,'L','L´BEL')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9312,96,'E','ÉSIKA')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9313,96,'C','CYZONE')
END

IF NOT EXISTS (SELECT 1 FROM dbo.TablaLogica WHERE TablaLogicaID = 97)
BEGIN
	INSERT INTO [dbo].[TablaLogica] VALUES (97,'Filtro Tipo Publicación FAV')
	
	-- Tipo Publicacion
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9314,97,'SC','SOLO CATALOGO')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9315,97,'SN','SOLO GUIA DE NEGOCIO')
END

GO
/*end*/

USE BelcorpEcuador
GO

IF NOT EXISTS (SELECT 1 FROM dbo.TablaLogica WHERE TablaLogicaID = 94)
BEGIN
	INSERT INTO [dbo].[TablaLogica] VALUES (94,'Ordernamiento FAV')
	
	-- Ordenamiento
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9303,94,'01','PRECIO | menor a mayor')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9304,94,'02','PRECIO | mayor a menor')
END

IF NOT EXISTS (SELECT 1 FROM dbo.TablaLogica WHERE TablaLogicaID = 95)
BEGIN
	INSERT INTO [dbo].[TablaLogica] VALUES (95,'Filtro Categorias FAV')
	
	-- Categorias
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9306,95,'01','FRAGANCIAS')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9307,95,'02','MAQUILLAJE')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9308,95,'04','CUIDADO PERSONAL')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9309,95,'09','TRATAMIENTO CORPORAL')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9310,95,'10','TRATAMIENTO FACIAL')
END

IF NOT EXISTS (SELECT 1 FROM dbo.TablaLogica WHERE TablaLogicaID = 96)
BEGIN
	INSERT INTO [dbo].[TablaLogica] VALUES (96,'Filtro Marcas FAV')
	
	-- Marca
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9311,96,'L','L´BEL')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9312,96,'E','ÉSIKA')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9313,96,'C','CYZONE')
END

IF NOT EXISTS (SELECT 1 FROM dbo.TablaLogica WHERE TablaLogicaID = 97)
BEGIN
	INSERT INTO [dbo].[TablaLogica] VALUES (97,'Filtro Tipo Publicación FAV')
	
	-- Tipo Publicacion
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9314,97,'SC','SOLO CATALOGO')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9315,97,'SN','SOLO GUIA DE NEGOCIO')
END

GO
/*end*/

USE BelcorpGuatemala
GO

IF NOT EXISTS (SELECT 1 FROM dbo.TablaLogica WHERE TablaLogicaID = 94)
BEGIN
	INSERT INTO [dbo].[TablaLogica] VALUES (94,'Ordernamiento FAV')
	
	-- Ordenamiento
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9303,94,'01','PRECIO | menor a mayor')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9304,94,'02','PRECIO | mayor a menor')
END

IF NOT EXISTS (SELECT 1 FROM dbo.TablaLogica WHERE TablaLogicaID = 95)
BEGIN
	INSERT INTO [dbo].[TablaLogica] VALUES (95,'Filtro Categorias FAV')
	
	-- Categorias
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9306,95,'01','FRAGANCIAS')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9307,95,'02','MAQUILLAJE')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9308,95,'04','CUIDADO PERSONAL')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9309,95,'09','TRATAMIENTO CORPORAL')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9310,95,'10','TRATAMIENTO FACIAL')
END

IF NOT EXISTS (SELECT 1 FROM dbo.TablaLogica WHERE TablaLogicaID = 96)
BEGIN
	INSERT INTO [dbo].[TablaLogica] VALUES (96,'Filtro Marcas FAV')
	
	-- Marca
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9311,96,'L','L´BEL')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9312,96,'E','ÉSIKA')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9313,96,'C','CYZONE')
END

IF NOT EXISTS (SELECT 1 FROM dbo.TablaLogica WHERE TablaLogicaID = 97)
BEGIN
	INSERT INTO [dbo].[TablaLogica] VALUES (97,'Filtro Tipo Publicación FAV')
	
	-- Tipo Publicacion
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9314,97,'SC','SOLO CATALOGO')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9315,97,'SN','SOLO GUIA DE NEGOCIO')
END

GO
/*end*/

USE BelcorpMexico
GO

IF NOT EXISTS (SELECT 1 FROM dbo.TablaLogica WHERE TablaLogicaID = 94)
BEGIN
	INSERT INTO [dbo].[TablaLogica] VALUES (94,'Ordernamiento FAV')
	
	-- Ordenamiento
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9303,94,'01','PRECIO | menor a mayor')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9304,94,'02','PRECIO | mayor a menor')
END

IF NOT EXISTS (SELECT 1 FROM dbo.TablaLogica WHERE TablaLogicaID = 95)
BEGIN
	INSERT INTO [dbo].[TablaLogica] VALUES (95,'Filtro Categorias FAV')
	
	-- Categorias
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9306,95,'01','FRAGANCIAS')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9307,95,'02','MAQUILLAJE')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9308,95,'04','CUIDADO PERSONAL')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9309,95,'09','TRATAMIENTO CORPORAL')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9310,95,'10','TRATAMIENTO FACIAL')
END

IF NOT EXISTS (SELECT 1 FROM dbo.TablaLogica WHERE TablaLogicaID = 96)
BEGIN
	INSERT INTO [dbo].[TablaLogica] VALUES (96,'Filtro Marcas FAV')
	
	-- Marca
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9311,96,'L','L´BEL')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9312,96,'E','ÉSIKA')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9313,96,'C','CYZONE')
END

IF NOT EXISTS (SELECT 1 FROM dbo.TablaLogica WHERE TablaLogicaID = 97)
BEGIN
	INSERT INTO [dbo].[TablaLogica] VALUES (97,'Filtro Tipo Publicación FAV')
	
	-- Tipo Publicacion
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9314,97,'SC','SOLO CATALOGO')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9315,97,'SN','SOLO GUIA DE NEGOCIO')
END

GO
/*end*/

USE BelcorpPanama
GO

IF NOT EXISTS (SELECT 1 FROM dbo.TablaLogica WHERE TablaLogicaID = 94)
BEGIN
	INSERT INTO [dbo].[TablaLogica] VALUES (94,'Ordernamiento FAV')
	
	-- Ordenamiento
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9303,94,'01','PRECIO | menor a mayor')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9304,94,'02','PRECIO | mayor a menor')
END

IF NOT EXISTS (SELECT 1 FROM dbo.TablaLogica WHERE TablaLogicaID = 95)
BEGIN
	INSERT INTO [dbo].[TablaLogica] VALUES (95,'Filtro Categorias FAV')
	
	-- Categorias
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9306,95,'01','FRAGANCIAS')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9307,95,'02','MAQUILLAJE')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9308,95,'04','CUIDADO PERSONAL')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9309,95,'09','TRATAMIENTO CORPORAL')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9310,95,'10','TRATAMIENTO FACIAL')
END

IF NOT EXISTS (SELECT 1 FROM dbo.TablaLogica WHERE TablaLogicaID = 96)
BEGIN
	INSERT INTO [dbo].[TablaLogica] VALUES (96,'Filtro Marcas FAV')
	
	-- Marca
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9311,96,'L','L´BEL')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9312,96,'E','ÉSIKA')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9313,96,'C','CYZONE')
END

IF NOT EXISTS (SELECT 1 FROM dbo.TablaLogica WHERE TablaLogicaID = 97)
BEGIN
	INSERT INTO [dbo].[TablaLogica] VALUES (97,'Filtro Tipo Publicación FAV')
	
	-- Tipo Publicacion
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9314,97,'SC','SOLO CATALOGO')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9315,97,'SN','SOLO GUIA DE NEGOCIO')
END

GO
/*end*/

USE BelcorpPeru
GO

IF NOT EXISTS (SELECT 1 FROM dbo.TablaLogica WHERE TablaLogicaID = 94)
BEGIN
	INSERT INTO [dbo].[TablaLogica] VALUES (94,'Ordernamiento FAV')
	
	-- Ordenamiento
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9303,94,'01','PRECIO | menor a mayor')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9304,94,'02','PRECIO | mayor a menor')
END

IF NOT EXISTS (SELECT 1 FROM dbo.TablaLogica WHERE TablaLogicaID = 95)
BEGIN
	INSERT INTO [dbo].[TablaLogica] VALUES (95,'Filtro Categorias FAV')
	
	-- Categorias
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9306,95,'01','FRAGANCIAS')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9307,95,'02','MAQUILLAJE')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9308,95,'04','CUIDADO PERSONAL')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9309,95,'09','TRATAMIENTO CORPORAL')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9310,95,'10','TRATAMIENTO FACIAL')
END

IF NOT EXISTS (SELECT 1 FROM dbo.TablaLogica WHERE TablaLogicaID = 96)
BEGIN
	INSERT INTO [dbo].[TablaLogica] VALUES (96,'Filtro Marcas FAV')
	
	-- Marca
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9311,96,'L','L´BEL')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9312,96,'E','ÉSIKA')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9313,96,'C','CYZONE')
END

IF NOT EXISTS (SELECT 1 FROM dbo.TablaLogica WHERE TablaLogicaID = 97)
BEGIN
	INSERT INTO [dbo].[TablaLogica] VALUES (97,'Filtro Tipo Publicación FAV')
	
	-- Tipo Publicacion
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9314,97,'SC','SOLO CATALOGO')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9315,97,'SN','SOLO GUIA DE NEGOCIO')
END

GO
/*end*/

USE BelcorpPuertoRico
GO

IF NOT EXISTS (SELECT 1 FROM dbo.TablaLogica WHERE TablaLogicaID = 94)
BEGIN
	INSERT INTO [dbo].[TablaLogica] VALUES (94,'Ordernamiento FAV')
	
	-- Ordenamiento
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9303,94,'01','PRECIO | menor a mayor')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9304,94,'02','PRECIO | mayor a menor')
END

IF NOT EXISTS (SELECT 1 FROM dbo.TablaLogica WHERE TablaLogicaID = 95)
BEGIN
	INSERT INTO [dbo].[TablaLogica] VALUES (95,'Filtro Categorias FAV')
	
	-- Categorias
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9306,95,'01','FRAGANCIAS')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9307,95,'02','MAQUILLAJE')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9308,95,'04','CUIDADO PERSONAL')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9309,95,'09','TRATAMIENTO CORPORAL')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9310,95,'10','TRATAMIENTO FACIAL')
END

IF NOT EXISTS (SELECT 1 FROM dbo.TablaLogica WHERE TablaLogicaID = 96)
BEGIN
	INSERT INTO [dbo].[TablaLogica] VALUES (96,'Filtro Marcas FAV')
	
	-- Marca
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9311,96,'L','L´BEL')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9312,96,'E','ÉSIKA')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9313,96,'C','CYZONE')
END

IF NOT EXISTS (SELECT 1 FROM dbo.TablaLogica WHERE TablaLogicaID = 97)
BEGIN
	INSERT INTO [dbo].[TablaLogica] VALUES (97,'Filtro Tipo Publicación FAV')
	
	-- Tipo Publicacion
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9314,97,'SC','SOLO CATALOGO')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9315,97,'SN','SOLO GUIA DE NEGOCIO')
END

GO
/*end*/

USE BelcorpSalvador
GO

IF NOT EXISTS (SELECT 1 FROM dbo.TablaLogica WHERE TablaLogicaID = 94)
BEGIN
	INSERT INTO [dbo].[TablaLogica] VALUES (94,'Ordernamiento FAV')
	
	-- Ordenamiento
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9303,94,'01','PRECIO | menor a mayor')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9304,94,'02','PRECIO | mayor a menor')
END

IF NOT EXISTS (SELECT 1 FROM dbo.TablaLogica WHERE TablaLogicaID = 95)
BEGIN
	INSERT INTO [dbo].[TablaLogica] VALUES (95,'Filtro Categorias FAV')
	
	-- Categorias
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9306,95,'01','FRAGANCIAS')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9307,95,'02','MAQUILLAJE')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9308,95,'04','CUIDADO PERSONAL')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9309,95,'09','TRATAMIENTO CORPORAL')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9310,95,'10','TRATAMIENTO FACIAL')
END

IF NOT EXISTS (SELECT 1 FROM dbo.TablaLogica WHERE TablaLogicaID = 96)
BEGIN
	INSERT INTO [dbo].[TablaLogica] VALUES (96,'Filtro Marcas FAV')
	
	-- Marca
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9311,96,'L','L´BEL')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9312,96,'E','ÉSIKA')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9313,96,'C','CYZONE')
END

IF NOT EXISTS (SELECT 1 FROM dbo.TablaLogica WHERE TablaLogicaID = 97)
BEGIN
	INSERT INTO [dbo].[TablaLogica] VALUES (97,'Filtro Tipo Publicación FAV')
	
	-- Tipo Publicacion
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9314,97,'SC','SOLO CATALOGO')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9315,97,'SN','SOLO GUIA DE NEGOCIO')
END

GO
/*end*/

USE BelcorpVenezuela
GO

IF NOT EXISTS (SELECT 1 FROM dbo.TablaLogica WHERE TablaLogicaID = 94)
BEGIN
	INSERT INTO [dbo].[TablaLogica] VALUES (94,'Ordernamiento FAV')
	
	-- Ordenamiento
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9303,94,'01','PRECIO | menor a mayor')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9304,94,'02','PRECIO | mayor a menor')
END

IF NOT EXISTS (SELECT 1 FROM dbo.TablaLogica WHERE TablaLogicaID = 95)
BEGIN
	INSERT INTO [dbo].[TablaLogica] VALUES (95,'Filtro Categorias FAV')
	
	-- Categorias
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9306,95,'01','FRAGANCIAS')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9307,95,'02','MAQUILLAJE')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9308,95,'04','CUIDADO PERSONAL')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9309,95,'09','TRATAMIENTO CORPORAL')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9310,95,'10','TRATAMIENTO FACIAL')
END

IF NOT EXISTS (SELECT 1 FROM dbo.TablaLogica WHERE TablaLogicaID = 96)
BEGIN
	INSERT INTO [dbo].[TablaLogica] VALUES (96,'Filtro Marcas FAV')
	
	-- Marca
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9311,96,'L','L´BEL')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9312,96,'E','ÉSIKA')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9313,96,'C','CYZONE')
END

IF NOT EXISTS (SELECT 1 FROM dbo.TablaLogica WHERE TablaLogicaID = 97)
BEGIN
	INSERT INTO [dbo].[TablaLogica] VALUES (97,'Filtro Tipo Publicación FAV')
	
	-- Tipo Publicacion
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9314,97,'SC','SOLO CATALOGO')
	INSERT INTO [dbo].[TablaLogicaDatos] VALUES (9315,97,'SN','SOLO GUIA DE NEGOCIO')
END

GO
