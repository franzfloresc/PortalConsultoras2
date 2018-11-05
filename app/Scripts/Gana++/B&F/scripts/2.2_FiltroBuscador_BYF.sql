USE BelcorpPeru
GO

--AGREGANDO CATEGORIAS
DELETE FROM FiltroBuscador WHERE TablaLogicaDatosID = 14801
INSERT INTO [dbo].[FiltroBuscador]
           ([TablaLogicaDatosID],[Estado],[Codigo],[Nombre],[Descripcion],[ValorMinimo],[ValorMaximo])
     VALUES
           (14801,1,'101','Fragancias','Categoría Fragancias','','')
           ,(14801,1,'102','Maquillaje','Categoría Maquillaje','','')
           ,(14801,1,'103','Cuidado Personal','Categoría Cuidado Personal','','')
           ,(14801,1,'104','Tratamiento Facial','Categoría Tratamiento Facial','','')
           ,(14801,1,'105','Bijouterie','Categoría Bijouterie','','')
           ,(14801,1,'106','Moda','Categoría Moda','','')
           ,(14801,1,'107','Herramientas de Venta','Categoría Herramientas de Venta','','')
GO

--AGREGANDO RELACION CATEGORIAS Y GRUPO ARTICULO
DELETE FROM [dbo].[FiltroBuscadorGrupoArticulo]
INSERT INTO [dbo].[FiltroBuscadorGrupoArticulo] ([CodigoFiltroBuscador], [CodigoGrupoArticulo])
     VALUES ('101', '0101')
			,('102', '0102')
			,('102', '0106')
			,('103', '0103')
			,('103', '0105')
			,('104', '0104')
			,('105', '020101')
			,('105', '020102')
			,('105', '020103')
			,('105', '020104')
			,('105', '020105')
			,('105', '020106')
			,('105', '020107')
			,('106', '0202')
			,('106', '0203')
			,('106', '0301')
			,('106', '0302')
			,('106', '0303')
			,('106', '0401')
			,('106', '0501')
			,('107', '0503')
			,('107', '0504')
GO

USE BelcorpMexico
GO

--AGREGANDO CATEGORIAS
DELETE FROM FiltroBuscador WHERE TablaLogicaDatosID = 14801
INSERT INTO [dbo].[FiltroBuscador]
           ([TablaLogicaDatosID],[Estado],[Codigo],[Nombre],[Descripcion],[ValorMinimo],[ValorMaximo])
     VALUES
           (14801,1,'101','Fragancias','Categoría Fragancias','','')
           ,(14801,1,'102','Maquillaje','Categoría Maquillaje','','')
           ,(14801,1,'103','Cuidado Personal','Categoría Cuidado Personal','','')
           ,(14801,1,'104','Tratamiento Facial','Categoría Tratamiento Facial','','')
           ,(14801,1,'105','Bijouterie','Categoría Bijouterie','','')
           ,(14801,1,'106','Moda','Categoría Moda','','')
           ,(14801,1,'107','Herramientas de Venta','Categoría Herramientas de Venta','','')
GO

--AGREGANDO RELACION CATEGORIAS Y GRUPO ARTICULO
DELETE FROM [dbo].[FiltroBuscadorGrupoArticulo]
INSERT INTO [dbo].[FiltroBuscadorGrupoArticulo] ([CodigoFiltroBuscador], [CodigoGrupoArticulo])
     VALUES ('101', '0101')
			,('102', '0102')
			,('102', '0106')
			,('103', '0103')
			,('103', '0105')
			,('104', '0104')
			,('105', '020101')
			,('105', '020102')
			,('105', '020103')
			,('105', '020104')
			,('105', '020105')
			,('105', '020106')
			,('105', '020107')
			,('106', '0202')
			,('106', '0203')
			,('106', '0301')
			,('106', '0302')
			,('106', '0303')
			,('106', '0401')
			,('106', '0501')
			,('107', '0503')
			,('107', '0504')
GO

USE BelcorpColombia
GO

--AGREGANDO CATEGORIAS
DELETE FROM FiltroBuscador WHERE TablaLogicaDatosID = 14801
INSERT INTO [dbo].[FiltroBuscador]
           ([TablaLogicaDatosID],[Estado],[Codigo],[Nombre],[Descripcion],[ValorMinimo],[ValorMaximo])
     VALUES
           (14801,1,'101','Fragancias','Categoría Fragancias','','')
           ,(14801,1,'102','Maquillaje','Categoría Maquillaje','','')
           ,(14801,1,'103','Cuidado Personal','Categoría Cuidado Personal','','')
           ,(14801,1,'104','Tratamiento Facial','Categoría Tratamiento Facial','','')
           ,(14801,1,'105','Bijouterie','Categoría Bijouterie','','')
           ,(14801,1,'106','Moda','Categoría Moda','','')
           ,(14801,1,'107','Herramientas de Venta','Categoría Herramientas de Venta','','')
GO

--AGREGANDO RELACION CATEGORIAS Y GRUPO ARTICULO
DELETE FROM [dbo].[FiltroBuscadorGrupoArticulo]
INSERT INTO [dbo].[FiltroBuscadorGrupoArticulo] ([CodigoFiltroBuscador], [CodigoGrupoArticulo])
     VALUES ('101', '0101')
			,('102', '0102')
			,('102', '0106')
			,('103', '0103')
			,('103', '0105')
			,('104', '0104')
			,('105', '020101')
			,('105', '020102')
			,('105', '020103')
			,('105', '020104')
			,('105', '020105')
			,('105', '020106')
			,('105', '020107')
			,('106', '0202')
			,('106', '0203')
			,('106', '0301')
			,('106', '0302')
			,('106', '0303')
			,('106', '0401')
			,('106', '0501')
			,('107', '0503')
			,('107', '0504')
GO

USE BelcorpSalvador
GO

--AGREGANDO CATEGORIAS
DELETE FROM FiltroBuscador WHERE TablaLogicaDatosID = 14801
INSERT INTO [dbo].[FiltroBuscador]
           ([TablaLogicaDatosID],[Estado],[Codigo],[Nombre],[Descripcion],[ValorMinimo],[ValorMaximo])
     VALUES
           (14801,1,'101','Fragancias','Categoría Fragancias','','')
           ,(14801,1,'102','Maquillaje','Categoría Maquillaje','','')
           ,(14801,1,'103','Cuidado Personal','Categoría Cuidado Personal','','')
           ,(14801,1,'104','Tratamiento Facial','Categoría Tratamiento Facial','','')
           ,(14801,1,'105','Bijouterie','Categoría Bijouterie','','')
           ,(14801,1,'106','Moda','Categoría Moda','','')
           ,(14801,1,'107','Herramientas de Venta','Categoría Herramientas de Venta','','')
GO

--AGREGANDO RELACION CATEGORIAS Y GRUPO ARTICULO
DELETE FROM [dbo].[FiltroBuscadorGrupoArticulo]
INSERT INTO [dbo].[FiltroBuscadorGrupoArticulo] ([CodigoFiltroBuscador], [CodigoGrupoArticulo])
     VALUES ('101', '0101')
			,('102', '0102')
			,('102', '0106')
			,('103', '0103')
			,('103', '0105')
			,('104', '0104')
			,('105', '020101')
			,('105', '020102')
			,('105', '020103')
			,('105', '020104')
			,('105', '020105')
			,('105', '020106')
			,('105', '020107')
			,('106', '0202')
			,('106', '0203')
			,('106', '0301')
			,('106', '0302')
			,('106', '0303')
			,('106', '0401')
			,('106', '0501')
			,('107', '0503')
			,('107', '0504')
GO

USE BelcorpPuertoRico
GO

--AGREGANDO CATEGORIAS
DELETE FROM FiltroBuscador WHERE TablaLogicaDatosID = 14801
INSERT INTO [dbo].[FiltroBuscador]
           ([TablaLogicaDatosID],[Estado],[Codigo],[Nombre],[Descripcion],[ValorMinimo],[ValorMaximo])
     VALUES
           (14801,1,'101','Fragancias','Categoría Fragancias','','')
           ,(14801,1,'102','Maquillaje','Categoría Maquillaje','','')
           ,(14801,1,'103','Cuidado Personal','Categoría Cuidado Personal','','')
           ,(14801,1,'104','Tratamiento Facial','Categoría Tratamiento Facial','','')
           ,(14801,1,'105','Bijouterie','Categoría Bijouterie','','')
           ,(14801,1,'106','Moda','Categoría Moda','','')
           ,(14801,1,'107','Herramientas de Venta','Categoría Herramientas de Venta','','')
GO

--AGREGANDO RELACION CATEGORIAS Y GRUPO ARTICULO
DELETE FROM [dbo].[FiltroBuscadorGrupoArticulo]
INSERT INTO [dbo].[FiltroBuscadorGrupoArticulo] ([CodigoFiltroBuscador], [CodigoGrupoArticulo])
     VALUES ('101', '0101')
			,('102', '0102')
			,('102', '0106')
			,('103', '0103')
			,('103', '0105')
			,('104', '0104')
			,('105', '020101')
			,('105', '020102')
			,('105', '020103')
			,('105', '020104')
			,('105', '020105')
			,('105', '020106')
			,('105', '020107')
			,('106', '0202')
			,('106', '0203')
			,('106', '0301')
			,('106', '0302')
			,('106', '0303')
			,('106', '0401')
			,('106', '0501')
			,('107', '0503')
			,('107', '0504')
GO

USE BelcorpPanama
GO

--AGREGANDO CATEGORIAS
DELETE FROM FiltroBuscador WHERE TablaLogicaDatosID = 14801
INSERT INTO [dbo].[FiltroBuscador]
           ([TablaLogicaDatosID],[Estado],[Codigo],[Nombre],[Descripcion],[ValorMinimo],[ValorMaximo])
     VALUES
           (14801,1,'101','Fragancias','Categoría Fragancias','','')
           ,(14801,1,'102','Maquillaje','Categoría Maquillaje','','')
           ,(14801,1,'103','Cuidado Personal','Categoría Cuidado Personal','','')
           ,(14801,1,'104','Tratamiento Facial','Categoría Tratamiento Facial','','')
           ,(14801,1,'105','Bijouterie','Categoría Bijouterie','','')
           ,(14801,1,'106','Moda','Categoría Moda','','')
           ,(14801,1,'107','Herramientas de Venta','Categoría Herramientas de Venta','','')
GO

--AGREGANDO RELACION CATEGORIAS Y GRUPO ARTICULO
DELETE FROM [dbo].[FiltroBuscadorGrupoArticulo]
INSERT INTO [dbo].[FiltroBuscadorGrupoArticulo] ([CodigoFiltroBuscador], [CodigoGrupoArticulo])
     VALUES ('101', '0101')
			,('102', '0102')
			,('102', '0106')
			,('103', '0103')
			,('103', '0105')
			,('104', '0104')
			,('105', '020101')
			,('105', '020102')
			,('105', '020103')
			,('105', '020104')
			,('105', '020105')
			,('105', '020106')
			,('105', '020107')
			,('106', '0202')
			,('106', '0203')
			,('106', '0301')
			,('106', '0302')
			,('106', '0303')
			,('106', '0401')
			,('106', '0501')
			,('107', '0503')
			,('107', '0504')
GO

USE BelcorpGuatemala
GO

--AGREGANDO CATEGORIAS
DELETE FROM FiltroBuscador WHERE TablaLogicaDatosID = 14801
INSERT INTO [dbo].[FiltroBuscador]
           ([TablaLogicaDatosID],[Estado],[Codigo],[Nombre],[Descripcion],[ValorMinimo],[ValorMaximo])
     VALUES
           (14801,1,'101','Fragancias','Categoría Fragancias','','')
           ,(14801,1,'102','Maquillaje','Categoría Maquillaje','','')
           ,(14801,1,'103','Cuidado Personal','Categoría Cuidado Personal','','')
           ,(14801,1,'104','Tratamiento Facial','Categoría Tratamiento Facial','','')
           ,(14801,1,'105','Bijouterie','Categoría Bijouterie','','')
           ,(14801,1,'106','Moda','Categoría Moda','','')
           ,(14801,1,'107','Herramientas de Venta','Categoría Herramientas de Venta','','')
GO

--AGREGANDO RELACION CATEGORIAS Y GRUPO ARTICULO
DELETE FROM [dbo].[FiltroBuscadorGrupoArticulo]
INSERT INTO [dbo].[FiltroBuscadorGrupoArticulo] ([CodigoFiltroBuscador], [CodigoGrupoArticulo])
     VALUES ('101', '0101')
			,('102', '0102')
			,('102', '0106')
			,('103', '0103')
			,('103', '0105')
			,('104', '0104')
			,('105', '020101')
			,('105', '020102')
			,('105', '020103')
			,('105', '020104')
			,('105', '020105')
			,('105', '020106')
			,('105', '020107')
			,('106', '0202')
			,('106', '0203')
			,('106', '0301')
			,('106', '0302')
			,('106', '0303')
			,('106', '0401')
			,('106', '0501')
			,('107', '0503')
			,('107', '0504')
GO

USE BelcorpEcuador
GO

--AGREGANDO CATEGORIAS
DELETE FROM FiltroBuscador WHERE TablaLogicaDatosID = 14801
INSERT INTO [dbo].[FiltroBuscador]
           ([TablaLogicaDatosID],[Estado],[Codigo],[Nombre],[Descripcion],[ValorMinimo],[ValorMaximo])
     VALUES
           (14801,1,'101','Fragancias','Categoría Fragancias','','')
           ,(14801,1,'102','Maquillaje','Categoría Maquillaje','','')
           ,(14801,1,'103','Cuidado Personal','Categoría Cuidado Personal','','')
           ,(14801,1,'104','Tratamiento Facial','Categoría Tratamiento Facial','','')
           ,(14801,1,'105','Bijouterie','Categoría Bijouterie','','')
           ,(14801,1,'106','Moda','Categoría Moda','','')
           ,(14801,1,'107','Herramientas de Venta','Categoría Herramientas de Venta','','')
GO

--AGREGANDO RELACION CATEGORIAS Y GRUPO ARTICULO
DELETE FROM [dbo].[FiltroBuscadorGrupoArticulo]
INSERT INTO [dbo].[FiltroBuscadorGrupoArticulo] ([CodigoFiltroBuscador], [CodigoGrupoArticulo])
     VALUES ('101', '0101')
			,('102', '0102')
			,('102', '0106')
			,('103', '0103')
			,('103', '0105')
			,('104', '0104')
			,('105', '020101')
			,('105', '020102')
			,('105', '020103')
			,('105', '020104')
			,('105', '020105')
			,('105', '020106')
			,('105', '020107')
			,('106', '0202')
			,('106', '0203')
			,('106', '0301')
			,('106', '0302')
			,('106', '0303')
			,('106', '0401')
			,('106', '0501')
			,('107', '0503')
			,('107', '0504')
GO

USE BelcorpDominicana
GO

--AGREGANDO CATEGORIAS
DELETE FROM FiltroBuscador WHERE TablaLogicaDatosID = 14801
INSERT INTO [dbo].[FiltroBuscador]
           ([TablaLogicaDatosID],[Estado],[Codigo],[Nombre],[Descripcion],[ValorMinimo],[ValorMaximo])
     VALUES
           (14801,1,'101','Fragancias','Categoría Fragancias','','')
           ,(14801,1,'102','Maquillaje','Categoría Maquillaje','','')
           ,(14801,1,'103','Cuidado Personal','Categoría Cuidado Personal','','')
           ,(14801,1,'104','Tratamiento Facial','Categoría Tratamiento Facial','','')
           ,(14801,1,'105','Bijouterie','Categoría Bijouterie','','')
           ,(14801,1,'106','Moda','Categoría Moda','','')
           ,(14801,1,'107','Herramientas de Venta','Categoría Herramientas de Venta','','')
GO

--AGREGANDO RELACION CATEGORIAS Y GRUPO ARTICULO
DELETE FROM [dbo].[FiltroBuscadorGrupoArticulo]
INSERT INTO [dbo].[FiltroBuscadorGrupoArticulo] ([CodigoFiltroBuscador], [CodigoGrupoArticulo])
     VALUES ('101', '0101')
			,('102', '0102')
			,('102', '0106')
			,('103', '0103')
			,('103', '0105')
			,('104', '0104')
			,('105', '020101')
			,('105', '020102')
			,('105', '020103')
			,('105', '020104')
			,('105', '020105')
			,('105', '020106')
			,('105', '020107')
			,('106', '0202')
			,('106', '0203')
			,('106', '0301')
			,('106', '0302')
			,('106', '0303')
			,('106', '0401')
			,('106', '0501')
			,('107', '0503')
			,('107', '0504')
GO

USE BelcorpCostaRica
GO

--AGREGANDO CATEGORIAS
DELETE FROM FiltroBuscador WHERE TablaLogicaDatosID = 14801
INSERT INTO [dbo].[FiltroBuscador]
           ([TablaLogicaDatosID],[Estado],[Codigo],[Nombre],[Descripcion],[ValorMinimo],[ValorMaximo])
     VALUES
           (14801,1,'101','Fragancias','Categoría Fragancias','','')
           ,(14801,1,'102','Maquillaje','Categoría Maquillaje','','')
           ,(14801,1,'103','Cuidado Personal','Categoría Cuidado Personal','','')
           ,(14801,1,'104','Tratamiento Facial','Categoría Tratamiento Facial','','')
           ,(14801,1,'105','Bijouterie','Categoría Bijouterie','','')
           ,(14801,1,'106','Moda','Categoría Moda','','')
           ,(14801,1,'107','Herramientas de Venta','Categoría Herramientas de Venta','','')
GO

--AGREGANDO RELACION CATEGORIAS Y GRUPO ARTICULO
DELETE FROM [dbo].[FiltroBuscadorGrupoArticulo]
INSERT INTO [dbo].[FiltroBuscadorGrupoArticulo] ([CodigoFiltroBuscador], [CodigoGrupoArticulo])
     VALUES ('101', '0101')
			,('102', '0102')
			,('102', '0106')
			,('103', '0103')
			,('103', '0105')
			,('104', '0104')
			,('105', '020101')
			,('105', '020102')
			,('105', '020103')
			,('105', '020104')
			,('105', '020105')
			,('105', '020106')
			,('105', '020107')
			,('106', '0202')
			,('106', '0203')
			,('106', '0301')
			,('106', '0302')
			,('106', '0303')
			,('106', '0401')
			,('106', '0501')
			,('107', '0503')
			,('107', '0504')
GO

USE BelcorpChile
GO

--AGREGANDO CATEGORIAS
DELETE FROM FiltroBuscador WHERE TablaLogicaDatosID = 14801
INSERT INTO [dbo].[FiltroBuscador]
           ([TablaLogicaDatosID],[Estado],[Codigo],[Nombre],[Descripcion],[ValorMinimo],[ValorMaximo])
     VALUES
           (14801,1,'101','Fragancias','Categoría Fragancias','','')
           ,(14801,1,'102','Maquillaje','Categoría Maquillaje','','')
           ,(14801,1,'103','Cuidado Personal','Categoría Cuidado Personal','','')
           ,(14801,1,'104','Tratamiento Facial','Categoría Tratamiento Facial','','')
           ,(14801,1,'105','Bijouterie','Categoría Bijouterie','','')
           ,(14801,1,'106','Moda','Categoría Moda','','')
           ,(14801,1,'107','Herramientas de Venta','Categoría Herramientas de Venta','','')
GO

--AGREGANDO RELACION CATEGORIAS Y GRUPO ARTICULO
DELETE FROM [dbo].[FiltroBuscadorGrupoArticulo]
INSERT INTO [dbo].[FiltroBuscadorGrupoArticulo] ([CodigoFiltroBuscador], [CodigoGrupoArticulo])
     VALUES ('101', '0101')
			,('102', '0102')
			,('102', '0106')
			,('103', '0103')
			,('103', '0105')
			,('104', '0104')
			,('105', '020101')
			,('105', '020102')
			,('105', '020103')
			,('105', '020104')
			,('105', '020105')
			,('105', '020106')
			,('105', '020107')
			,('106', '0202')
			,('106', '0203')
			,('106', '0301')
			,('106', '0302')
			,('106', '0303')
			,('106', '0401')
			,('106', '0501')
			,('107', '0503')
			,('107', '0504')
GO

USE BelcorpBolivia
GO

--AGREGANDO CATEGORIAS
DELETE FROM FiltroBuscador WHERE TablaLogicaDatosID = 14801
INSERT INTO [dbo].[FiltroBuscador]
           ([TablaLogicaDatosID],[Estado],[Codigo],[Nombre],[Descripcion],[ValorMinimo],[ValorMaximo])
     VALUES
           (14801,1,'101','Fragancias','Categoría Fragancias','','')
           ,(14801,1,'102','Maquillaje','Categoría Maquillaje','','')
           ,(14801,1,'103','Cuidado Personal','Categoría Cuidado Personal','','')
           ,(14801,1,'104','Tratamiento Facial','Categoría Tratamiento Facial','','')
           ,(14801,1,'105','Bijouterie','Categoría Bijouterie','','')
           ,(14801,1,'106','Moda','Categoría Moda','','')
           ,(14801,1,'107','Herramientas de Venta','Categoría Herramientas de Venta','','')
GO

--AGREGANDO RELACION CATEGORIAS Y GRUPO ARTICULO
DELETE FROM [dbo].[FiltroBuscadorGrupoArticulo]
INSERT INTO [dbo].[FiltroBuscadorGrupoArticulo] ([CodigoFiltroBuscador], [CodigoGrupoArticulo])
     VALUES ('101', '0101')
			,('102', '0102')
			,('102', '0106')
			,('103', '0103')
			,('103', '0105')
			,('104', '0104')
			,('105', '020101')
			,('105', '020102')
			,('105', '020103')
			,('105', '020104')
			,('105', '020105')
			,('105', '020106')
			,('105', '020107')
			,('106', '0202')
			,('106', '0203')
			,('106', '0301')
			,('106', '0302')
			,('106', '0303')
			,('106', '0401')
			,('106', '0501')
			,('107', '0503')
			,('107', '0504')
GO

