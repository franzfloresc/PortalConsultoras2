USE BelcorpPeru
GO

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=1))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (1, N'VER_MAS', N'Ver Más', 0, 1, 1)	
END


IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=2))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (2, N'AGR_CAR', N'Agregar al carrito ', 0, 2, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=3))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (3, N'VM_BONI', N'Bonificaciones', 1, 3, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=4))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (4, N'VM_CLIE', N'Clientes', 1, 4, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=5))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (5, N'VM_PASE', N'Pase de Pedido', 1, 5, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=6))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (6, N'VM_MIAC', N'Mi Academia', 1, 6, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=7))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (7, N'VM_TUVO', N'Tu Voz Online', 1, 7, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=8))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (8, N'VM_ACTU', N'Actualización de datos', 1, 8, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=9))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (9, N'VM_GANA', N'Gana+', 1, 9, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=10))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (10, N'VM_CHAT', N'Chat', 1, 10, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=11))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (11, N'VM_EMBE', N'Embebido', 1, 11, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=12))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (12, N'VM_GANA_ODD', N'Oferta del Dia', 1, 12, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=13))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (13, N'VM_GANA_SR', N'ShowRoom', 1, 13, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=14))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (14, N'VM_GANA_MG', N'Más Ganadoras', 1, 14, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=15))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (15, N'VM_GANA_OPT', N'Ofertas para ti', 1, 15, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=16))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (16, N'VM_GANA_RD', N'Revista Digital Completa', 1, 16, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=17))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (17, N'VM_GANA_HV', N'Herramientas de venta', 1, 17, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=18))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (18, N'VM_GANA_DP', N'Duo Perfecto', 1, 18, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=19))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (19, N'VM_GANA_PN', N'Pack de Nuevas', 1, 19, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=20))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (20, N'VM_GANA_ATP', N'Arma tu Pack', 1, 20, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=21))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (21, N'VM_GANA_LAN', N'Nuevos Lanzamientos', 1, 21, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=22))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (22, N'VM_GANA_OPM', N'Ofertas Para Mi', 1, 22, 1)
END

GO

USE BelcorpMexico
GO

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=1))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (1, N'VER_MAS', N'Ver Más', 0, 1, 1)	
END


IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=2))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (2, N'AGR_CAR', N'Agregar al carrito ', 0, 2, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=3))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (3, N'VM_BONI', N'Bonificaciones', 1, 3, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=4))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (4, N'VM_CLIE', N'Clientes', 1, 4, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=5))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (5, N'VM_PASE', N'Pase de Pedido', 1, 5, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=6))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (6, N'VM_MIAC', N'Mi Academia', 1, 6, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=7))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (7, N'VM_TUVO', N'Tu Voz Online', 1, 7, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=8))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (8, N'VM_ACTU', N'Actualización de datos', 1, 8, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=9))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (9, N'VM_GANA', N'Gana+', 1, 9, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=10))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (10, N'VM_CHAT', N'Chat', 1, 10, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=11))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (11, N'VM_EMBE', N'Embebido', 1, 11, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=12))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (12, N'VM_GANA_ODD', N'Oferta del Dia', 1, 12, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=13))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (13, N'VM_GANA_SR', N'ShowRoom', 1, 13, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=14))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (14, N'VM_GANA_MG', N'Más Ganadoras', 1, 14, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=15))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (15, N'VM_GANA_OPT', N'Ofertas para ti', 1, 15, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=16))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (16, N'VM_GANA_RD', N'Revista Digital Completa', 1, 16, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=17))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (17, N'VM_GANA_HV', N'Herramientas de venta', 1, 17, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=18))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (18, N'VM_GANA_DP', N'Duo Perfecto', 1, 18, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=19))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (19, N'VM_GANA_PN', N'Pack de Nuevas', 1, 19, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=20))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (20, N'VM_GANA_ATP', N'Arma tu Pack', 1, 20, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=21))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (21, N'VM_GANA_LAN', N'Nuevos Lanzamientos', 1, 21, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=22))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (22, N'VM_GANA_OPM', N'Ofertas Para Mi', 1, 22, 1)
END

GO

USE BelcorpColombia
GO

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=1))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (1, N'VER_MAS', N'Ver Más', 0, 1, 1)	
END


IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=2))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (2, N'AGR_CAR', N'Agregar al carrito ', 0, 2, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=3))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (3, N'VM_BONI', N'Bonificaciones', 1, 3, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=4))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (4, N'VM_CLIE', N'Clientes', 1, 4, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=5))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (5, N'VM_PASE', N'Pase de Pedido', 1, 5, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=6))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (6, N'VM_MIAC', N'Mi Academia', 1, 6, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=7))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (7, N'VM_TUVO', N'Tu Voz Online', 1, 7, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=8))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (8, N'VM_ACTU', N'Actualización de datos', 1, 8, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=9))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (9, N'VM_GANA', N'Gana+', 1, 9, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=10))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (10, N'VM_CHAT', N'Chat', 1, 10, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=11))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (11, N'VM_EMBE', N'Embebido', 1, 11, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=12))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (12, N'VM_GANA_ODD', N'Oferta del Dia', 1, 12, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=13))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (13, N'VM_GANA_SR', N'ShowRoom', 1, 13, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=14))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (14, N'VM_GANA_MG', N'Más Ganadoras', 1, 14, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=15))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (15, N'VM_GANA_OPT', N'Ofertas para ti', 1, 15, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=16))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (16, N'VM_GANA_RD', N'Revista Digital Completa', 1, 16, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=17))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (17, N'VM_GANA_HV', N'Herramientas de venta', 1, 17, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=18))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (18, N'VM_GANA_DP', N'Duo Perfecto', 1, 18, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=19))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (19, N'VM_GANA_PN', N'Pack de Nuevas', 1, 19, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=20))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (20, N'VM_GANA_ATP', N'Arma tu Pack', 1, 20, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=21))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (21, N'VM_GANA_LAN', N'Nuevos Lanzamientos', 1, 21, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=22))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (22, N'VM_GANA_OPM', N'Ofertas Para Mi', 1, 22, 1)
END

GO

USE BelcorpSalvador
GO

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=1))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (1, N'VER_MAS', N'Ver Más', 0, 1, 1)	
END


IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=2))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (2, N'AGR_CAR', N'Agregar al carrito ', 0, 2, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=3))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (3, N'VM_BONI', N'Bonificaciones', 1, 3, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=4))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (4, N'VM_CLIE', N'Clientes', 1, 4, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=5))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (5, N'VM_PASE', N'Pase de Pedido', 1, 5, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=6))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (6, N'VM_MIAC', N'Mi Academia', 1, 6, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=7))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (7, N'VM_TUVO', N'Tu Voz Online', 1, 7, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=8))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (8, N'VM_ACTU', N'Actualización de datos', 1, 8, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=9))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (9, N'VM_GANA', N'Gana+', 1, 9, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=10))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (10, N'VM_CHAT', N'Chat', 1, 10, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=11))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (11, N'VM_EMBE', N'Embebido', 1, 11, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=12))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (12, N'VM_GANA_ODD', N'Oferta del Dia', 1, 12, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=13))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (13, N'VM_GANA_SR', N'ShowRoom', 1, 13, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=14))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (14, N'VM_GANA_MG', N'Más Ganadoras', 1, 14, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=15))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (15, N'VM_GANA_OPT', N'Ofertas para ti', 1, 15, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=16))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (16, N'VM_GANA_RD', N'Revista Digital Completa', 1, 16, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=17))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (17, N'VM_GANA_HV', N'Herramientas de venta', 1, 17, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=18))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (18, N'VM_GANA_DP', N'Duo Perfecto', 1, 18, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=19))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (19, N'VM_GANA_PN', N'Pack de Nuevas', 1, 19, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=20))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (20, N'VM_GANA_ATP', N'Arma tu Pack', 1, 20, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=21))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (21, N'VM_GANA_LAN', N'Nuevos Lanzamientos', 1, 21, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=22))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (22, N'VM_GANA_OPM', N'Ofertas Para Mi', 1, 22, 1)
END

GO

USE BelcorpPuertoRico
GO

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=1))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (1, N'VER_MAS', N'Ver Más', 0, 1, 1)	
END


IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=2))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (2, N'AGR_CAR', N'Agregar al carrito ', 0, 2, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=3))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (3, N'VM_BONI', N'Bonificaciones', 1, 3, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=4))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (4, N'VM_CLIE', N'Clientes', 1, 4, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=5))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (5, N'VM_PASE', N'Pase de Pedido', 1, 5, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=6))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (6, N'VM_MIAC', N'Mi Academia', 1, 6, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=7))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (7, N'VM_TUVO', N'Tu Voz Online', 1, 7, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=8))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (8, N'VM_ACTU', N'Actualización de datos', 1, 8, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=9))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (9, N'VM_GANA', N'Gana+', 1, 9, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=10))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (10, N'VM_CHAT', N'Chat', 1, 10, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=11))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (11, N'VM_EMBE', N'Embebido', 1, 11, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=12))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (12, N'VM_GANA_ODD', N'Oferta del Dia', 1, 12, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=13))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (13, N'VM_GANA_SR', N'ShowRoom', 1, 13, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=14))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (14, N'VM_GANA_MG', N'Más Ganadoras', 1, 14, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=15))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (15, N'VM_GANA_OPT', N'Ofertas para ti', 1, 15, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=16))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (16, N'VM_GANA_RD', N'Revista Digital Completa', 1, 16, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=17))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (17, N'VM_GANA_HV', N'Herramientas de venta', 1, 17, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=18))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (18, N'VM_GANA_DP', N'Duo Perfecto', 1, 18, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=19))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (19, N'VM_GANA_PN', N'Pack de Nuevas', 1, 19, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=20))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (20, N'VM_GANA_ATP', N'Arma tu Pack', 1, 20, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=21))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (21, N'VM_GANA_LAN', N'Nuevos Lanzamientos', 1, 21, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=22))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (22, N'VM_GANA_OPM', N'Ofertas Para Mi', 1, 22, 1)
END

GO

USE BelcorpPanama
GO

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=1))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (1, N'VER_MAS', N'Ver Más', 0, 1, 1)	
END


IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=2))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (2, N'AGR_CAR', N'Agregar al carrito ', 0, 2, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=3))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (3, N'VM_BONI', N'Bonificaciones', 1, 3, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=4))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (4, N'VM_CLIE', N'Clientes', 1, 4, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=5))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (5, N'VM_PASE', N'Pase de Pedido', 1, 5, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=6))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (6, N'VM_MIAC', N'Mi Academia', 1, 6, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=7))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (7, N'VM_TUVO', N'Tu Voz Online', 1, 7, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=8))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (8, N'VM_ACTU', N'Actualización de datos', 1, 8, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=9))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (9, N'VM_GANA', N'Gana+', 1, 9, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=10))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (10, N'VM_CHAT', N'Chat', 1, 10, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=11))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (11, N'VM_EMBE', N'Embebido', 1, 11, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=12))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (12, N'VM_GANA_ODD', N'Oferta del Dia', 1, 12, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=13))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (13, N'VM_GANA_SR', N'ShowRoom', 1, 13, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=14))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (14, N'VM_GANA_MG', N'Más Ganadoras', 1, 14, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=15))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (15, N'VM_GANA_OPT', N'Ofertas para ti', 1, 15, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=16))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (16, N'VM_GANA_RD', N'Revista Digital Completa', 1, 16, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=17))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (17, N'VM_GANA_HV', N'Herramientas de venta', 1, 17, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=18))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (18, N'VM_GANA_DP', N'Duo Perfecto', 1, 18, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=19))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (19, N'VM_GANA_PN', N'Pack de Nuevas', 1, 19, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=20))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (20, N'VM_GANA_ATP', N'Arma tu Pack', 1, 20, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=21))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (21, N'VM_GANA_LAN', N'Nuevos Lanzamientos', 1, 21, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=22))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (22, N'VM_GANA_OPM', N'Ofertas Para Mi', 1, 22, 1)
END

GO

USE BelcorpGuatemala
GO

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=1))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (1, N'VER_MAS', N'Ver Más', 0, 1, 1)	
END


IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=2))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (2, N'AGR_CAR', N'Agregar al carrito ', 0, 2, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=3))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (3, N'VM_BONI', N'Bonificaciones', 1, 3, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=4))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (4, N'VM_CLIE', N'Clientes', 1, 4, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=5))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (5, N'VM_PASE', N'Pase de Pedido', 1, 5, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=6))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (6, N'VM_MIAC', N'Mi Academia', 1, 6, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=7))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (7, N'VM_TUVO', N'Tu Voz Online', 1, 7, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=8))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (8, N'VM_ACTU', N'Actualización de datos', 1, 8, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=9))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (9, N'VM_GANA', N'Gana+', 1, 9, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=10))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (10, N'VM_CHAT', N'Chat', 1, 10, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=11))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (11, N'VM_EMBE', N'Embebido', 1, 11, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=12))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (12, N'VM_GANA_ODD', N'Oferta del Dia', 1, 12, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=13))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (13, N'VM_GANA_SR', N'ShowRoom', 1, 13, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=14))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (14, N'VM_GANA_MG', N'Más Ganadoras', 1, 14, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=15))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (15, N'VM_GANA_OPT', N'Ofertas para ti', 1, 15, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=16))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (16, N'VM_GANA_RD', N'Revista Digital Completa', 1, 16, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=17))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (17, N'VM_GANA_HV', N'Herramientas de venta', 1, 17, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=18))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (18, N'VM_GANA_DP', N'Duo Perfecto', 1, 18, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=19))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (19, N'VM_GANA_PN', N'Pack de Nuevas', 1, 19, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=20))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (20, N'VM_GANA_ATP', N'Arma tu Pack', 1, 20, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=21))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (21, N'VM_GANA_LAN', N'Nuevos Lanzamientos', 1, 21, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=22))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (22, N'VM_GANA_OPM', N'Ofertas Para Mi', 1, 22, 1)
END

GO

USE BelcorpEcuador
GO

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=1))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (1, N'VER_MAS', N'Ver Más', 0, 1, 1)	
END


IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=2))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (2, N'AGR_CAR', N'Agregar al carrito ', 0, 2, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=3))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (3, N'VM_BONI', N'Bonificaciones', 1, 3, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=4))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (4, N'VM_CLIE', N'Clientes', 1, 4, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=5))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (5, N'VM_PASE', N'Pase de Pedido', 1, 5, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=6))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (6, N'VM_MIAC', N'Mi Academia', 1, 6, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=7))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (7, N'VM_TUVO', N'Tu Voz Online', 1, 7, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=8))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (8, N'VM_ACTU', N'Actualización de datos', 1, 8, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=9))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (9, N'VM_GANA', N'Gana+', 1, 9, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=10))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (10, N'VM_CHAT', N'Chat', 1, 10, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=11))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (11, N'VM_EMBE', N'Embebido', 1, 11, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=12))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (12, N'VM_GANA_ODD', N'Oferta del Dia', 1, 12, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=13))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (13, N'VM_GANA_SR', N'ShowRoom', 1, 13, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=14))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (14, N'VM_GANA_MG', N'Más Ganadoras', 1, 14, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=15))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (15, N'VM_GANA_OPT', N'Ofertas para ti', 1, 15, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=16))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (16, N'VM_GANA_RD', N'Revista Digital Completa', 1, 16, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=17))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (17, N'VM_GANA_HV', N'Herramientas de venta', 1, 17, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=18))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (18, N'VM_GANA_DP', N'Duo Perfecto', 1, 18, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=19))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (19, N'VM_GANA_PN', N'Pack de Nuevas', 1, 19, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=20))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (20, N'VM_GANA_ATP', N'Arma tu Pack', 1, 20, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=21))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (21, N'VM_GANA_LAN', N'Nuevos Lanzamientos', 1, 21, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=22))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (22, N'VM_GANA_OPM', N'Ofertas Para Mi', 1, 22, 1)
END

GO

USE BelcorpDominicana
GO

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=1))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (1, N'VER_MAS', N'Ver Más', 0, 1, 1)	
END


IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=2))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (2, N'AGR_CAR', N'Agregar al carrito ', 0, 2, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=3))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (3, N'VM_BONI', N'Bonificaciones', 1, 3, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=4))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (4, N'VM_CLIE', N'Clientes', 1, 4, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=5))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (5, N'VM_PASE', N'Pase de Pedido', 1, 5, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=6))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (6, N'VM_MIAC', N'Mi Academia', 1, 6, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=7))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (7, N'VM_TUVO', N'Tu Voz Online', 1, 7, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=8))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (8, N'VM_ACTU', N'Actualización de datos', 1, 8, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=9))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (9, N'VM_GANA', N'Gana+', 1, 9, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=10))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (10, N'VM_CHAT', N'Chat', 1, 10, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=11))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (11, N'VM_EMBE', N'Embebido', 1, 11, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=12))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (12, N'VM_GANA_ODD', N'Oferta del Dia', 1, 12, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=13))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (13, N'VM_GANA_SR', N'ShowRoom', 1, 13, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=14))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (14, N'VM_GANA_MG', N'Más Ganadoras', 1, 14, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=15))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (15, N'VM_GANA_OPT', N'Ofertas para ti', 1, 15, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=16))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (16, N'VM_GANA_RD', N'Revista Digital Completa', 1, 16, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=17))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (17, N'VM_GANA_HV', N'Herramientas de venta', 1, 17, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=18))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (18, N'VM_GANA_DP', N'Duo Perfecto', 1, 18, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=19))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (19, N'VM_GANA_PN', N'Pack de Nuevas', 1, 19, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=20))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (20, N'VM_GANA_ATP', N'Arma tu Pack', 1, 20, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=21))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (21, N'VM_GANA_LAN', N'Nuevos Lanzamientos', 1, 21, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=22))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (22, N'VM_GANA_OPM', N'Ofertas Para Mi', 1, 22, 1)
END

GO

USE BelcorpCostaRica
GO

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=1))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (1, N'VER_MAS', N'Ver Más', 0, 1, 1)	
END


IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=2))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (2, N'AGR_CAR', N'Agregar al carrito ', 0, 2, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=3))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (3, N'VM_BONI', N'Bonificaciones', 1, 3, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=4))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (4, N'VM_CLIE', N'Clientes', 1, 4, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=5))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (5, N'VM_PASE', N'Pase de Pedido', 1, 5, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=6))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (6, N'VM_MIAC', N'Mi Academia', 1, 6, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=7))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (7, N'VM_TUVO', N'Tu Voz Online', 1, 7, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=8))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (8, N'VM_ACTU', N'Actualización de datos', 1, 8, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=9))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (9, N'VM_GANA', N'Gana+', 1, 9, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=10))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (10, N'VM_CHAT', N'Chat', 1, 10, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=11))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (11, N'VM_EMBE', N'Embebido', 1, 11, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=12))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (12, N'VM_GANA_ODD', N'Oferta del Dia', 1, 12, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=13))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (13, N'VM_GANA_SR', N'ShowRoom', 1, 13, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=14))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (14, N'VM_GANA_MG', N'Más Ganadoras', 1, 14, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=15))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (15, N'VM_GANA_OPT', N'Ofertas para ti', 1, 15, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=16))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (16, N'VM_GANA_RD', N'Revista Digital Completa', 1, 16, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=17))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (17, N'VM_GANA_HV', N'Herramientas de venta', 1, 17, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=18))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (18, N'VM_GANA_DP', N'Duo Perfecto', 1, 18, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=19))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (19, N'VM_GANA_PN', N'Pack de Nuevas', 1, 19, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=20))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (20, N'VM_GANA_ATP', N'Arma tu Pack', 1, 20, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=21))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (21, N'VM_GANA_LAN', N'Nuevos Lanzamientos', 1, 21, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=22))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (22, N'VM_GANA_OPM', N'Ofertas Para Mi', 1, 22, 1)
END

GO

USE BelcorpChile
GO

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=1))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (1, N'VER_MAS', N'Ver Más', 0, 1, 1)	
END


IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=2))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (2, N'AGR_CAR', N'Agregar al carrito ', 0, 2, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=3))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (3, N'VM_BONI', N'Bonificaciones', 1, 3, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=4))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (4, N'VM_CLIE', N'Clientes', 1, 4, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=5))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (5, N'VM_PASE', N'Pase de Pedido', 1, 5, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=6))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (6, N'VM_MIAC', N'Mi Academia', 1, 6, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=7))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (7, N'VM_TUVO', N'Tu Voz Online', 1, 7, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=8))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (8, N'VM_ACTU', N'Actualización de datos', 1, 8, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=9))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (9, N'VM_GANA', N'Gana+', 1, 9, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=10))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (10, N'VM_CHAT', N'Chat', 1, 10, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=11))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (11, N'VM_EMBE', N'Embebido', 1, 11, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=12))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (12, N'VM_GANA_ODD', N'Oferta del Dia', 1, 12, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=13))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (13, N'VM_GANA_SR', N'ShowRoom', 1, 13, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=14))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (14, N'VM_GANA_MG', N'Más Ganadoras', 1, 14, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=15))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (15, N'VM_GANA_OPT', N'Ofertas para ti', 1, 15, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=16))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (16, N'VM_GANA_RD', N'Revista Digital Completa', 1, 16, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=17))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (17, N'VM_GANA_HV', N'Herramientas de venta', 1, 17, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=18))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (18, N'VM_GANA_DP', N'Duo Perfecto', 1, 18, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=19))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (19, N'VM_GANA_PN', N'Pack de Nuevas', 1, 19, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=20))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (20, N'VM_GANA_ATP', N'Arma tu Pack', 1, 20, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=21))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (21, N'VM_GANA_LAN', N'Nuevos Lanzamientos', 1, 21, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=22))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (22, N'VM_GANA_OPM', N'Ofertas Para Mi', 1, 22, 1)
END

GO

USE BelcorpBolivia
GO

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=1))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (1, N'VER_MAS', N'Ver Más', 0, 1, 1)	
END


IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=2))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (2, N'AGR_CAR', N'Agregar al carrito ', 0, 2, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=3))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (3, N'VM_BONI', N'Bonificaciones', 1, 3, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=4))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (4, N'VM_CLIE', N'Clientes', 1, 4, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=5))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (5, N'VM_PASE', N'Pase de Pedido', 1, 5, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=6))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (6, N'VM_MIAC', N'Mi Academia', 1, 6, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=7))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (7, N'VM_TUVO', N'Tu Voz Online', 1, 7, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=8))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (8, N'VM_ACTU', N'Actualización de datos', 1, 8, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=9))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (9, N'VM_GANA', N'Gana+', 1, 9, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=10))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (10, N'VM_CHAT', N'Chat', 1, 10, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=11))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (11, N'VM_EMBE', N'Embebido', 1, 11, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=12))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (12, N'VM_GANA_ODD', N'Oferta del Dia', 1, 12, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=13))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (13, N'VM_GANA_SR', N'ShowRoom', 1, 13, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=14))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (14, N'VM_GANA_MG', N'Más Ganadoras', 1, 14, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=15))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (15, N'VM_GANA_OPT', N'Ofertas para ti', 1, 15, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=16))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (16, N'VM_GANA_RD', N'Revista Digital Completa', 1, 16, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=17))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (17, N'VM_GANA_HV', N'Herramientas de venta', 1, 17, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=18))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (18, N'VM_GANA_DP', N'Duo Perfecto', 1, 18, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=19))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (19, N'VM_GANA_PN', N'Pack de Nuevas', 1, 19, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=20))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (20, N'VM_GANA_ATP', N'Arma tu Pack', 1, 20, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=21))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (21, N'VM_GANA_LAN', N'Nuevos Lanzamientos', 1, 21, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE IdContenidoAct=22))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES (22, N'VM_GANA_OPM', N'Ofertas Para Mi', 1, 22, 1)
END

GO

