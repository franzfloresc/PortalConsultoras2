--EXECUTE GetPermisosByRol 1
USE BELCORPPERU_SB2
GO

CREATE TABLE #tblTemporal (idPermisoTemp int)
INSERT INTO #tblTemporal(idPermisoTemp) 
SELECT PermisoID FROM RolPermiso WHERE RolID=1
DELETE FROM RolPermiso WHERE RolID=1
DELETE FROM Permiso WHERE PermisoID IN (SELECT idPermisoTemp FROM #tblTemporal)
DROP TABLE #tblTemporal

INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (2, N'SOCIA EMPRESARIA', 0, 1, N'', 0, N'Header', NULL, 0, 0, 0)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (3, N'MI NEGOCIO', 0, 2, N'', 0, N'Header', NULL, 0, 0, 0)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (4, N'MI ACADEMIA', 0, 3, N'MiAcademia/Index', 0, N'Header', NULL, 0, 0, 0)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (5, N'MI COMUNIDAD', 0, 4, N'Comunidad/Index', 0, N'Header', NULL, 0, 0, 0)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (6, N'MI ASESOR DE BELLEZA', 0, 5, N'', 0, N'Header', NULL, 0, 0, 0)

--HIJOS MI NEGOCIO
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (13, N'Seguimiento a tu pedido', 3, 2, N'Tracking/Index', 0, N'Header', NULL, NULL, 0, 0)
--INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
--VALUES (14, N'Pedido FIC', 3, 3, N'PedidoFIC/Index', 0, N'Header', NULL, 0, 0, 0)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (15, N'Mis pedidos', 3, 4, N'MisPedidos/Index', 0, N'Header', NULL, 0, 0, 0)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (16, N'Mis pagos', 3, 5, N'MisPagos/Index', 0, N'Header', NULL, NULL, 0, 0)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios])
VALUES (17, N'Mis beneficios', 3, 6, N'MisBeneficios/Index', 0, N'Header', NULL, 0, 0, 0)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (18, N'Mis incentivos', 3, 7, N'', 0, N'Header', NULL, 0, 0, 0)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (19, N'Consultora Online', 3, 8, N'ConsultoraOnline/Index', 0, N'Header', NULL, 0, 0, 0)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (20, N'Mis clientes', 3, 9, N'Cliente/MisClientes', 0, N'Header', NULL, 0, 0, 0)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (21, N'Liquidaci�n web', 3, 10, N'OfertaLiquidacion/OfertasLiquidacion', 0, N'Header', NULL, 0, 0, 0)
--FIN HIJOS MI NEGOCIO

--HIJOS MI ASESOR DE BELLEZA
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (23, N'�SIKA', 6, 1, N'', 0, N'Header', NULL, 0, 0, 0)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (24, N'LBEL', 6, 1, N'', 0, N'Header', NULL, 0, 0, 0)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (25, N'CYZONE', 6, 1, N'', 0, N'Header', NULL, 0, 0, 0)

--HIJOS ESIKA
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (26, N'Maquillador Virtual', 23, 1, N'http://www.esika.com/coach-de-belleza/maquillador-virtual/', 1, N'Header', NULL, 0, 0, 0)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (27, N'Manicure virtual', 23, 2, N'http://www.esika.com/coach-de-belleza/manicure-virtual/', 1, N'Header', NULL, 0, 0, 0)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (28, N'Esika blog', 23, 3, N'http://www.esika.com/blog/', 1, N'Header', NULL, 0, 0, 0)
--FIN HIJOS ESIKA

-- HIJOS LBEL
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (29, N'Diagn�stico de Piel', 24, 1, N'http://www.lbel.com/diagnosticodepiel', 1, N'Header', NULL, 0, 0, 0)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (30, N'Asesor de Bases y Polvos', 24, 2, N'http://www.lbel.com/asesordemaquillaje/', 1, N'Header', NULL, 0, 0, 0)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (31, N'Belleza a tu medida', 24, 3, N'http://www.lbel.com/bellezaatumedida', 1, N'Header', NULL, 0, 0, 0)
-- FIN HIJOS LBEL

-- HIJOS CYZONE
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (32, N'Maquillador virtual', 25, 1, N'http://www.cyzone.com/pe/maquillador-virtual', 1, N'Header', NULL, 0, 0, 0)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (33, N'Manicure virtual', 25, 2, N'http://www.cyzone.com/pe/manicure-virtual', 1, N'Header', NULL, 0, 0, 0)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (34, N'Look book', 25, 3, N'http://www.cyzone.com/look-book/', 1, N'Header', NULL, 0, 0, 0)
-- FIN HIJOS CYZONE

-- FOOTER
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (37, N'AYUDA', 0, 1, N'', 0, N'Footer', NULL, 0, 0, 0)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (38, N'LEGAL', 0, 2, N'', 0, N'Footer', NULL, 0, 0, 0)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (39, N'PREGUNTAS FRECUENTES', 37, 1, N'https://www.somosbelcorp.com/Content/FAQ/Preguntas frecuentes Portal Consultora PE.pdf', 1, N'Footer', NULL, 0, 0, 0)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (40, N'CONT�CTANOS', 37, 2, N'http://belcorprespondeqa.somosbelcorp.com/', 1, N'Footer', NULL, 0, 0, 0)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (41, N'CONDICIONES DE USO WEB', 38, 1, N'https://www.somosbelcorp.com/Content/FAQ/CONDICIONES_DE_USO_WEB_PE.pdf', 1, N'Footer', NULL, 0, 0, 0)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (42, N'POL�TICAS DE PRIVACIDAD', 38, 2, N'https://www.somosbelcorp.com/Content/FAQ/POLITICA_DE_PRIVACIDAD_PE.pdf', 1, N'Footer', NULL, 0, 0, 0)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (43, N'PROCEDIMIENTO Y FORMULARIO PARA EL EJERCICIO DE DERECHOS ARCO', 38, 3, N'https://www.somosbelcorp.com/Content/FAQ/PROCEDIMIENTO_Y_FORMULARIO_PARA_EL_EJERCICIO_DE_DERECHOS_ARCO_PE.pdf', 1, N'Footer', NULL, 0, 0, 0)
-- FIN FOOTER

INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 2, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 3, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 4, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 5, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 6, 1, 1)

INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 13, 1, 1)
--INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 14, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 15, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 16, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 17, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 18, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 19, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 20, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 21, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 23, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 24, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 25, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 26, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 27, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 28, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 29, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 30, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 31, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 32, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 33, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 34, 1, 1)


INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 37, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 38, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 39, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 40, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 41, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 42, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 43, 1, 1)
