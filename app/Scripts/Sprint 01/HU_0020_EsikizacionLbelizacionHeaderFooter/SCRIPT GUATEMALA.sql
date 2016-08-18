USE BelcorpGuatemala_SB2
GO

CREATE TABLE #tblTemporal (idPermisoTemp int)
INSERT INTO #tblTemporal(idPermisoTemp) 
SELECT PermisoID FROM RolPermiso WHERE RolID=1
DELETE FROM RolPermiso WHERE RolID=1
DELETE FROM Permiso WHERE PermisoID IN (SELECT idPermisoTemp FROM #tblTemporal)
DROP TABLE #tblTemporal

INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (2, N'SOCIA EMPRESARIA', 0, 1, N'Lider/Index', 1, N'Header', NULL, 0, 0, 0)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (3, N'MI NEGOCIO', 0, 2, N'', 0, N'Header', NULL, 0, 0, 0)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (4, N'MI ACADEMIA', 0, 3, N'MiAcademia/Index', 0, N'Header', NULL, 0, 0, 0)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (5, N'MI COMUNIDAD', 0, 4, N'Comunidad/Index', 0, N'Header', NULL, 0, 0, 0)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (6, N'MI ASESOR DE BELLEZA', 0, 5, N'', 0, N'Header', NULL, 0, 0, 0)

INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (7, N'MIS PEDIDOS', 3, 1, N'', 0, N'Header', NULL, 0, 0, 0)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (8, N'MIS PAGOS', 3, 2, N'', 0, N'Header', NULL, 0, 0, 0)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (9, N'MIS CAT�LOGOS Y REVISTAS', 3, 3, N'', 0, N'Header', NULL, 0, 0, 0)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (10, N'MIS CLIENTES', 3, 4, N'', 0, N'Header', NULL, 0, 0, 0)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (11, N'PROGRAMAS BELCORP', 3, 5, N'', 0, N'Header', NULL, 0, 0, 1)

INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (12, N'Ingresa tu pedido', 7, 1, N'Pedido/Index', 0, N'Header', NULL, 0, 0, 0)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (13, N'Informaci�n de campa�a', 7, 2, N'Bienvenida/Index', 0, N'Header', NULL, 0, 0, 0)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (14, N'Seguimiento de pedido', 7, 3, N'Tracking/Index', 0, N'Header', NULL, NULL, 0, 0)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (15, N'Paquete documentario', 7, 4, N'PaqueteDocumentario/Index', 0, N'Header', NULL, 0, 0, 0)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (16, N'Mis Pedidos', 7, 5, N'MisPedidos/Index', 0, N'Header', NULL, NULL, 0, 0)
--INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
--VALUES (17, N'Pedidos facturados', 7, 6, N'PedidoWebAnteriores/PedidoWebAnteriores', 0, N'Header', NULL, 0, 0, 0)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (18, N'Zona de liquidaci�n', 7, 7, N'OfertaLiquidacion/OfertasLiquidacion', 0, N'Header', NULL, 0, 0, 0)
--INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
--VALUES (19, N'Ofertas flexiPago', 7, 8, N'OfertaFlexipago/OfertasFlexipago', 0, N'Header', NULL, 0, 0, 0)
--INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
--VALUES (20, N'Incentivos', 7, 9, N'Incentivos/Index', 0, N'Header', NULL, 0, 0, 0)

INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (21, N'Mis Pagos', 8, 1, N'MisPagos/Index', 0, N'Header', NULL, 0, 0, 0)
--INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
--VALUES (22, N'Lugares de pago', 8, 2, N'LugaresPago/Index', 0, N'Header', NULL, 0, 0, 0)
--INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
--VALUES (23, N'Facturaci�n electr�nica', 8, 3, N'FacturaElectronica/Index', 0, N'Header', NULL, 0, 0, 0)
--INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
--VALUES (24, N'Percepciones', 8, 4, N'Percepciones/Index', 0, N'Header', NULL, NULL, 0, 0)
--INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
--VALUES (25, N'Escala de descuentos', 8, 5, N'EscalaDescuentos/Index', 0, N'Header', NULL, 0, 0, 0)

INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (26, N'Mis Cat�logos y Revistas', 9, 1, N'MisCatalogosRevistas/Index', 0, N'Header', NULL, 0, 0, 0)
--INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
--VALUES (27, N'Gu�a de Negocio �sika', 9, 2, N'RevistaGana/Index', 0, N'Header', NULL, 0, 0, 0)

INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (28, N'Listado de clientes', 10, 1, N'Cliente/Index', 0, N'Header', NULL, 0, 0, 0)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (29, N'Pedidos por cliente', 10, 2, N'PedidoWeb/PedidoWeb', 0, N'Header', NULL, 0, 0, 0)
--INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
--VALUES (30, N'Consultora Online', 10, 3, N'ConsultoraOnline/Index', 0, N'Header', NULL, 0, 0, 0)

--INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
--VALUES (31, N'', 6, 1, N'', 0, N'Header', NULL, 0, 0, 0)
--INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
--VALUES (32, N'Maquillador Virtual', 31, 1, N'http://www.esika.biz/coach-de-belleza/maquillador-virtual/', 1, N'Header', NULL, 0, 0, 0)
--INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
--VALUES (33, N'�sika Fashion Blog', 31, 2, N'http://fashionblog.esika.biz/', 1, N'Header', NULL, 0, 0, 0)
--INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
--VALUES (34, N'Asesor de looks', 31, 3, N'http://www.esika.biz/coach-de-belleza/asesor-de-looks/', 1, N'Header', NULL, 0, 0, 0)
--INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
--VALUES (35, N'Asesor de Fragancias', 31, 4, N'http://www.esika.biz/coach-de-belleza/asesor-de-fragancias-para-ti/', 1, N'Header', NULL, 0, 0, 0)
--INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
--VALUES (36, N'Manicure Virtual', 31, 5, N'http://www.esika.biz/coach-de-belleza/manicure-virtual/', 1, N'Header', NULL, 0, 0, 0)
--INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
--VALUES (37, N'Esika Fashion Blog ', 31, 5, N'http://www.fashionblog.esika.com/', 1, N'Header', NULL, 0, 0, 0)
--INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
--VALUES (38, N'Tips de Belleza ', 31, 5, N'http://www.esika.com/clps-de-belleza/', 1, N'Header', NULL, 0, 0, 0)
--INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
--VALUES (39, N'A la Moda', 31, 5, N'http://www.esika.com/a-la-moda/esika-fashion/', 1, N'Header', NULL, 0, 0, 0)

--INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
--VALUES (31, N'Brillante 2016', 11, 1, N'https://s3.amazonaws.com/somosbelcorp/2016/Folleto+Brillante+2016/Folleto+Brillante+2016+GT.pdf', 1, N'Header', NULL, 0, 0, 0)
--INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
--VALUES (30, N'Programa Nuevas', 11, 2, N'https://s3.amazonaws.com/somosbelcorp/2016/Minisite+Nuevas+Esikizado/GT/index.html', 1, N'Header', NULL, 0, 0, 0)

INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (40, N'AYUDA', 0, 2, N'', 0, N'Footer', NULL, 0, 0, 0)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (41, N'LEGAL', 0, 3, N'', 0, N'Footer', NULL, 0, 0, 0)

INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (42, N'PREGUNTAS FRECUENTES', 40, 1, N'https://www.somosbelcorp.com/Content/FAQ/Preguntas%20frecuentes%20Portal%20Consultora%20GT.pdf', 1, N'Footer', NULL, 0, 0, 0)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (43, N'CONT�CTANOS', 40, 2, N'http://belcorpresponde.somosbelcorp.com/', 1, N'Footer', NULL, 0, 0, 0)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (44, N'CONDICIONES DE USO WEB', 41, 1, N'https://www.somosbelcorp.com/WebPages/TerminosyReferencias_GT.aspx', 1, N'Footer', NULL, 0, 0, 0)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (45, N'POL�TICAS DE PRIVACIDAD', 41, 2, N'https://www.somosbelcorp.com/WebPages/TerminosyReferencias_GT.aspx', 1, N'Footer', NULL, 0, 0, 0)
--INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
--VALUES (46, N'PROCEDIMIENTO Y FORMULARIO PARA EL EJERCICIO DE DERECHOS ARCO', 41, 3, N'https://www.somosbelcorp.com/Content/FAQ/PROCEDIMIENTO_Y_FORMULARIO_PARA_EL_EJERCICIO_DE_DERECHOS_ARCO_GT.pdf', 1, N'Footer', NULL, 0, 0, 0)
--GO

INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (50, N'', 6, 1, N'', 0, N'Header', NULL, 0, 0, 0)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (51, N'Maquillador Virtual', 50, 1, N'http://www.esika.biz/coach-de-belleza/maquillador-virtual/', 1, N'Header', NULL, 0, 0, 0)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (52, N'�sika Fashion Blog', 50, 2, N'http://fashionblog.esika.biz/', 1, N'Header', NULL, 0, 0, 0)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (53, N'Asesor de looks', 50, 3, N'http://www.esika.biz/coach-de-belleza/asesor-de-looks/', 1, N'Header', NULL, 0, 0, 0)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (54, N'Asesor de Fragancias', 50, 4, N'http://www.esika.biz/coach-de-belleza/asesor-de-fragancias-para-ti/', 1, N'Header', NULL, 0, 0, 0)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (55, N'Manicure Virtual', 50, 5, N'http://www.esika.biz/coach-de-belleza/manicure-virtual/', 1, N'Header', NULL, 0, 0, 0)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (56, N'Tips de Belleza ', 50, 6, N'http://www.esika.com/clps-de-belleza/', 1, N'Header', NULL, 0, 0, 0)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (57, N'A la Moda', 50, 7, N'http://www.esika.com/a-la-moda/esika-fashion/', 1, N'Header', NULL, 0, 0, 0)

INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 2, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 3, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 4, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 5, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 6, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 7, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 8, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 9, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 10, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 11, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 12, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 13, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 14, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 15, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 16, 1, 1)
--INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 17, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 18, 1, 1)

--INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 19, 1, 1)
--INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 20, 0, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 21, 1, 1)
--INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 22, 1, 1)
--INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 23, 1, 1)

--INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 24, 1, 1)
--INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 25, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 26, 1, 1)
--INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 27, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 28, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 29, 1, 1)
--INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 30, 1, 1)
--INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 31, 1, 1)

--INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 32, 1, 1)
--INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 33, 1, 1)
--INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 34, 1, 1)
--INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 35, 1, 1)
--INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 36, 1, 1)
--INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 37, 1, 1)
--INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 38, 1, 1)
--INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 39, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 40, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 41, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 42, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 43, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 44, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 45, 1, 1)
--INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 46, 1, 1)

INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 50, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 51, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 52, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 53, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 54, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 55, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 56, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 57, 1, 1)

GO
