USE BelcorpPeru
GO

DECLARE @ID_PARENT INT

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VER_MAS'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ( [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VER_MAS','Ver Más', 0, 1, 1)	
	SET @ID_PARENT=@@IDENTITY
END
ELSE
BEGIN
	SET @ID_PARENT= (SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VER_MAS')
END


IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='AGR_CAR'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('AGR_CAR', 'Agregar al carrito ', 0, 2, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_BONI'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_BONI', 'Bonificaciones', @ID_PARENT, 3, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_CLIE'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] 
		([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_CLIE', 'Clientes', @ID_PARENT, 4, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_PASE'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_PASE', 'Pase de Pedido', @ID_PARENT, 5, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_MIAC'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_MIAC','Mi Academia', @ID_PARENT, 6, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_TUVO'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_TUVO', 'Tu Voz Online', @ID_PARENT, 7, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE [Codigo]='VM_ACTU'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_ACTU', 'Actualización de datos', @ID_PARENT, 8, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA', 'Gana+', @ID_PARENT, 9, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_CHAT'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_CHAT', 'Chat', @ID_PARENT, 10, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_EMBE'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_EMBE', 'Embebido', @ID_PARENT, 11, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_ODD'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_ODD', 'Oferta del Dia', @ID_PARENT, 12, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_SR'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_SR', 'ShowRoom', @ID_PARENT, 13, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_MG'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_MG', 'Más Ganadoras', @ID_PARENT, 14, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_OPT'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_OPT','Ofertas para ti', @ID_PARENT, 15, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_RD'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_RD', 'Revista Digital Completa', @ID_PARENT, 16, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_HV'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_HV', 'Herramientas de venta', @ID_PARENT, 17, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_DP'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_DP', 'Duo Perfecto', @ID_PARENT, 18, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_PN'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_PN', 'Pack de Nuevas', @ID_PARENT, 19, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_ATP'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_ATP','Arma tu Pack', @ID_PARENT, 20, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_LAN'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_LAN', 'Nuevos Lanzamientos', @ID_PARENT, 21, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_OPM'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_OPM', 'Ofertas Para Mi', @ID_PARENT, 22, 1)
END

GO

USE BelcorpMexico
GO

DECLARE @ID_PARENT INT

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VER_MAS'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ( [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VER_MAS','Ver Más', 0, 1, 1)	
	SET @ID_PARENT=@@IDENTITY
END
ELSE
BEGIN
	SET @ID_PARENT= (SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VER_MAS')
END


IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='AGR_CAR'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('AGR_CAR', 'Agregar al carrito ', 0, 2, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_BONI'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_BONI', 'Bonificaciones', @ID_PARENT, 3, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_CLIE'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] 
		([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_CLIE', 'Clientes', @ID_PARENT, 4, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_PASE'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_PASE', 'Pase de Pedido', @ID_PARENT, 5, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_MIAC'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_MIAC','Mi Academia', @ID_PARENT, 6, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_TUVO'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_TUVO', 'Tu Voz Online', @ID_PARENT, 7, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE [Codigo]='VM_ACTU'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_ACTU', 'Actualización de datos', @ID_PARENT, 8, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA', 'Gana+', @ID_PARENT, 9, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_CHAT'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_CHAT', 'Chat', @ID_PARENT, 10, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_EMBE'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_EMBE', 'Embebido', @ID_PARENT, 11, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_ODD'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_ODD', 'Oferta del Dia', @ID_PARENT, 12, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_SR'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_SR', 'ShowRoom', @ID_PARENT, 13, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_MG'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_MG', 'Más Ganadoras', @ID_PARENT, 14, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_OPT'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_OPT','Ofertas para ti', @ID_PARENT, 15, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_RD'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_RD', 'Revista Digital Completa', @ID_PARENT, 16, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_HV'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_HV', 'Herramientas de venta', @ID_PARENT, 17, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_DP'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_DP', 'Duo Perfecto', @ID_PARENT, 18, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_PN'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_PN', 'Pack de Nuevas', @ID_PARENT, 19, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_ATP'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_ATP','Arma tu Pack', @ID_PARENT, 20, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_LAN'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_LAN', 'Nuevos Lanzamientos', @ID_PARENT, 21, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_OPM'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_OPM', 'Ofertas Para Mi', @ID_PARENT, 22, 1)
END

GO

USE BelcorpColombia
GO

DECLARE @ID_PARENT INT

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VER_MAS'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ( [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VER_MAS','Ver Más', 0, 1, 1)	
	SET @ID_PARENT=@@IDENTITY
END
ELSE
BEGIN
	SET @ID_PARENT= (SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VER_MAS')
END


IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='AGR_CAR'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('AGR_CAR', 'Agregar al carrito ', 0, 2, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_BONI'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_BONI', 'Bonificaciones', @ID_PARENT, 3, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_CLIE'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] 
		([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_CLIE', 'Clientes', @ID_PARENT, 4, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_PASE'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_PASE', 'Pase de Pedido', @ID_PARENT, 5, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_MIAC'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_MIAC','Mi Academia', @ID_PARENT, 6, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_TUVO'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_TUVO', 'Tu Voz Online', @ID_PARENT, 7, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE [Codigo]='VM_ACTU'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_ACTU', 'Actualización de datos', @ID_PARENT, 8, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA', 'Gana+', @ID_PARENT, 9, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_CHAT'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_CHAT', 'Chat', @ID_PARENT, 10, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_EMBE'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_EMBE', 'Embebido', @ID_PARENT, 11, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_ODD'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_ODD', 'Oferta del Dia', @ID_PARENT, 12, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_SR'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_SR', 'ShowRoom', @ID_PARENT, 13, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_MG'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_MG', 'Más Ganadoras', @ID_PARENT, 14, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_OPT'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_OPT','Ofertas para ti', @ID_PARENT, 15, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_RD'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_RD', 'Revista Digital Completa', @ID_PARENT, 16, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_HV'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_HV', 'Herramientas de venta', @ID_PARENT, 17, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_DP'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_DP', 'Duo Perfecto', @ID_PARENT, 18, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_PN'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_PN', 'Pack de Nuevas', @ID_PARENT, 19, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_ATP'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_ATP','Arma tu Pack', @ID_PARENT, 20, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_LAN'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_LAN', 'Nuevos Lanzamientos', @ID_PARENT, 21, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_OPM'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_OPM', 'Ofertas Para Mi', @ID_PARENT, 22, 1)
END

GO

USE BelcorpSalvador
GO

DECLARE @ID_PARENT INT

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VER_MAS'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ( [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VER_MAS','Ver Más', 0, 1, 1)	
	SET @ID_PARENT=@@IDENTITY
END
ELSE
BEGIN
	SET @ID_PARENT= (SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VER_MAS')
END


IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='AGR_CAR'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('AGR_CAR', 'Agregar al carrito ', 0, 2, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_BONI'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_BONI', 'Bonificaciones', @ID_PARENT, 3, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_CLIE'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] 
		([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_CLIE', 'Clientes', @ID_PARENT, 4, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_PASE'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_PASE', 'Pase de Pedido', @ID_PARENT, 5, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_MIAC'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_MIAC','Mi Academia', @ID_PARENT, 6, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_TUVO'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_TUVO', 'Tu Voz Online', @ID_PARENT, 7, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE [Codigo]='VM_ACTU'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_ACTU', 'Actualización de datos', @ID_PARENT, 8, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA', 'Gana+', @ID_PARENT, 9, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_CHAT'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_CHAT', 'Chat', @ID_PARENT, 10, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_EMBE'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_EMBE', 'Embebido', @ID_PARENT, 11, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_ODD'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_ODD', 'Oferta del Dia', @ID_PARENT, 12, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_SR'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_SR', 'ShowRoom', @ID_PARENT, 13, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_MG'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_MG', 'Más Ganadoras', @ID_PARENT, 14, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_OPT'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_OPT','Ofertas para ti', @ID_PARENT, 15, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_RD'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_RD', 'Revista Digital Completa', @ID_PARENT, 16, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_HV'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_HV', 'Herramientas de venta', @ID_PARENT, 17, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_DP'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_DP', 'Duo Perfecto', @ID_PARENT, 18, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_PN'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_PN', 'Pack de Nuevas', @ID_PARENT, 19, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_ATP'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_ATP','Arma tu Pack', @ID_PARENT, 20, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_LAN'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_LAN', 'Nuevos Lanzamientos', @ID_PARENT, 21, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_OPM'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_OPM', 'Ofertas Para Mi', @ID_PARENT, 22, 1)
END

GO

USE BelcorpPuertoRico
GO

DECLARE @ID_PARENT INT

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VER_MAS'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ( [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VER_MAS','Ver Más', 0, 1, 1)	
	SET @ID_PARENT=@@IDENTITY
END
ELSE
BEGIN
	SET @ID_PARENT= (SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VER_MAS')
END


IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='AGR_CAR'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('AGR_CAR', 'Agregar al carrito ', 0, 2, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_BONI'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_BONI', 'Bonificaciones', @ID_PARENT, 3, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_CLIE'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] 
		([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_CLIE', 'Clientes', @ID_PARENT, 4, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_PASE'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_PASE', 'Pase de Pedido', @ID_PARENT, 5, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_MIAC'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_MIAC','Mi Academia', @ID_PARENT, 6, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_TUVO'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_TUVO', 'Tu Voz Online', @ID_PARENT, 7, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE [Codigo]='VM_ACTU'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_ACTU', 'Actualización de datos', @ID_PARENT, 8, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA', 'Gana+', @ID_PARENT, 9, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_CHAT'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_CHAT', 'Chat', @ID_PARENT, 10, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_EMBE'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_EMBE', 'Embebido', @ID_PARENT, 11, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_ODD'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_ODD', 'Oferta del Dia', @ID_PARENT, 12, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_SR'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_SR', 'ShowRoom', @ID_PARENT, 13, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_MG'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_MG', 'Más Ganadoras', @ID_PARENT, 14, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_OPT'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_OPT','Ofertas para ti', @ID_PARENT, 15, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_RD'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_RD', 'Revista Digital Completa', @ID_PARENT, 16, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_HV'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_HV', 'Herramientas de venta', @ID_PARENT, 17, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_DP'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_DP', 'Duo Perfecto', @ID_PARENT, 18, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_PN'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_PN', 'Pack de Nuevas', @ID_PARENT, 19, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_ATP'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_ATP','Arma tu Pack', @ID_PARENT, 20, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_LAN'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_LAN', 'Nuevos Lanzamientos', @ID_PARENT, 21, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_OPM'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_OPM', 'Ofertas Para Mi', @ID_PARENT, 22, 1)
END

GO

USE BelcorpPanama
GO

DECLARE @ID_PARENT INT

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VER_MAS'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ( [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VER_MAS','Ver Más', 0, 1, 1)	
	SET @ID_PARENT=@@IDENTITY
END
ELSE
BEGIN
	SET @ID_PARENT= (SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VER_MAS')
END


IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='AGR_CAR'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('AGR_CAR', 'Agregar al carrito ', 0, 2, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_BONI'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_BONI', 'Bonificaciones', @ID_PARENT, 3, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_CLIE'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] 
		([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_CLIE', 'Clientes', @ID_PARENT, 4, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_PASE'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_PASE', 'Pase de Pedido', @ID_PARENT, 5, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_MIAC'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_MIAC','Mi Academia', @ID_PARENT, 6, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_TUVO'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_TUVO', 'Tu Voz Online', @ID_PARENT, 7, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE [Codigo]='VM_ACTU'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_ACTU', 'Actualización de datos', @ID_PARENT, 8, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA', 'Gana+', @ID_PARENT, 9, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_CHAT'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_CHAT', 'Chat', @ID_PARENT, 10, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_EMBE'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_EMBE', 'Embebido', @ID_PARENT, 11, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_ODD'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_ODD', 'Oferta del Dia', @ID_PARENT, 12, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_SR'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_SR', 'ShowRoom', @ID_PARENT, 13, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_MG'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_MG', 'Más Ganadoras', @ID_PARENT, 14, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_OPT'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_OPT','Ofertas para ti', @ID_PARENT, 15, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_RD'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_RD', 'Revista Digital Completa', @ID_PARENT, 16, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_HV'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_HV', 'Herramientas de venta', @ID_PARENT, 17, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_DP'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_DP', 'Duo Perfecto', @ID_PARENT, 18, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_PN'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_PN', 'Pack de Nuevas', @ID_PARENT, 19, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_ATP'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_ATP','Arma tu Pack', @ID_PARENT, 20, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_LAN'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_LAN', 'Nuevos Lanzamientos', @ID_PARENT, 21, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_OPM'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_OPM', 'Ofertas Para Mi', @ID_PARENT, 22, 1)
END

GO

USE BelcorpGuatemala
GO

DECLARE @ID_PARENT INT

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VER_MAS'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ( [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VER_MAS','Ver Más', 0, 1, 1)	
	SET @ID_PARENT=@@IDENTITY
END
ELSE
BEGIN
	SET @ID_PARENT= (SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VER_MAS')
END


IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='AGR_CAR'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('AGR_CAR', 'Agregar al carrito ', 0, 2, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_BONI'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_BONI', 'Bonificaciones', @ID_PARENT, 3, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_CLIE'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] 
		([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_CLIE', 'Clientes', @ID_PARENT, 4, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_PASE'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_PASE', 'Pase de Pedido', @ID_PARENT, 5, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_MIAC'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_MIAC','Mi Academia', @ID_PARENT, 6, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_TUVO'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_TUVO', 'Tu Voz Online', @ID_PARENT, 7, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE [Codigo]='VM_ACTU'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_ACTU', 'Actualización de datos', @ID_PARENT, 8, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA', 'Gana+', @ID_PARENT, 9, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_CHAT'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_CHAT', 'Chat', @ID_PARENT, 10, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_EMBE'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_EMBE', 'Embebido', @ID_PARENT, 11, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_ODD'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_ODD', 'Oferta del Dia', @ID_PARENT, 12, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_SR'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_SR', 'ShowRoom', @ID_PARENT, 13, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_MG'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_MG', 'Más Ganadoras', @ID_PARENT, 14, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_OPT'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_OPT','Ofertas para ti', @ID_PARENT, 15, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_RD'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_RD', 'Revista Digital Completa', @ID_PARENT, 16, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_HV'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_HV', 'Herramientas de venta', @ID_PARENT, 17, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_DP'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_DP', 'Duo Perfecto', @ID_PARENT, 18, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_PN'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_PN', 'Pack de Nuevas', @ID_PARENT, 19, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_ATP'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_ATP','Arma tu Pack', @ID_PARENT, 20, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_LAN'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_LAN', 'Nuevos Lanzamientos', @ID_PARENT, 21, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_OPM'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_OPM', 'Ofertas Para Mi', @ID_PARENT, 22, 1)
END

GO

USE BelcorpEcuador
GO

DECLARE @ID_PARENT INT

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VER_MAS'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ( [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VER_MAS','Ver Más', 0, 1, 1)	
	SET @ID_PARENT=@@IDENTITY
END
ELSE
BEGIN
	SET @ID_PARENT= (SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VER_MAS')
END


IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='AGR_CAR'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('AGR_CAR', 'Agregar al carrito ', 0, 2, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_BONI'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_BONI', 'Bonificaciones', @ID_PARENT, 3, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_CLIE'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] 
		([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_CLIE', 'Clientes', @ID_PARENT, 4, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_PASE'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_PASE', 'Pase de Pedido', @ID_PARENT, 5, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_MIAC'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_MIAC','Mi Academia', @ID_PARENT, 6, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_TUVO'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_TUVO', 'Tu Voz Online', @ID_PARENT, 7, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE [Codigo]='VM_ACTU'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_ACTU', 'Actualización de datos', @ID_PARENT, 8, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA', 'Gana+', @ID_PARENT, 9, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_CHAT'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_CHAT', 'Chat', @ID_PARENT, 10, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_EMBE'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_EMBE', 'Embebido', @ID_PARENT, 11, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_ODD'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_ODD', 'Oferta del Dia', @ID_PARENT, 12, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_SR'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_SR', 'ShowRoom', @ID_PARENT, 13, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_MG'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_MG', 'Más Ganadoras', @ID_PARENT, 14, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_OPT'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_OPT','Ofertas para ti', @ID_PARENT, 15, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_RD'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_RD', 'Revista Digital Completa', @ID_PARENT, 16, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_HV'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_HV', 'Herramientas de venta', @ID_PARENT, 17, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_DP'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_DP', 'Duo Perfecto', @ID_PARENT, 18, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_PN'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_PN', 'Pack de Nuevas', @ID_PARENT, 19, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_ATP'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_ATP','Arma tu Pack', @ID_PARENT, 20, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_LAN'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_LAN', 'Nuevos Lanzamientos', @ID_PARENT, 21, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_OPM'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_OPM', 'Ofertas Para Mi', @ID_PARENT, 22, 1)
END

GO

USE BelcorpDominicana
GO

DECLARE @ID_PARENT INT

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VER_MAS'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ( [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VER_MAS','Ver Más', 0, 1, 1)	
	SET @ID_PARENT=@@IDENTITY
END
ELSE
BEGIN
	SET @ID_PARENT= (SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VER_MAS')
END


IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='AGR_CAR'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('AGR_CAR', 'Agregar al carrito ', 0, 2, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_BONI'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_BONI', 'Bonificaciones', @ID_PARENT, 3, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_CLIE'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] 
		([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_CLIE', 'Clientes', @ID_PARENT, 4, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_PASE'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_PASE', 'Pase de Pedido', @ID_PARENT, 5, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_MIAC'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_MIAC','Mi Academia', @ID_PARENT, 6, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_TUVO'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_TUVO', 'Tu Voz Online', @ID_PARENT, 7, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE [Codigo]='VM_ACTU'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_ACTU', 'Actualización de datos', @ID_PARENT, 8, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA', 'Gana+', @ID_PARENT, 9, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_CHAT'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_CHAT', 'Chat', @ID_PARENT, 10, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_EMBE'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_EMBE', 'Embebido', @ID_PARENT, 11, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_ODD'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_ODD', 'Oferta del Dia', @ID_PARENT, 12, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_SR'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_SR', 'ShowRoom', @ID_PARENT, 13, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_MG'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_MG', 'Más Ganadoras', @ID_PARENT, 14, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_OPT'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_OPT','Ofertas para ti', @ID_PARENT, 15, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_RD'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_RD', 'Revista Digital Completa', @ID_PARENT, 16, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_HV'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_HV', 'Herramientas de venta', @ID_PARENT, 17, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_DP'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_DP', 'Duo Perfecto', @ID_PARENT, 18, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_PN'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_PN', 'Pack de Nuevas', @ID_PARENT, 19, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_ATP'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_ATP','Arma tu Pack', @ID_PARENT, 20, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_LAN'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_LAN', 'Nuevos Lanzamientos', @ID_PARENT, 21, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_OPM'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_OPM', 'Ofertas Para Mi', @ID_PARENT, 22, 1)
END

GO

USE BelcorpCostaRica
GO

DECLARE @ID_PARENT INT

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VER_MAS'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ( [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VER_MAS','Ver Más', 0, 1, 1)	
	SET @ID_PARENT=@@IDENTITY
END
ELSE
BEGIN
	SET @ID_PARENT= (SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VER_MAS')
END


IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='AGR_CAR'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('AGR_CAR', 'Agregar al carrito ', 0, 2, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_BONI'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_BONI', 'Bonificaciones', @ID_PARENT, 3, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_CLIE'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] 
		([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_CLIE', 'Clientes', @ID_PARENT, 4, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_PASE'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_PASE', 'Pase de Pedido', @ID_PARENT, 5, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_MIAC'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_MIAC','Mi Academia', @ID_PARENT, 6, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_TUVO'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_TUVO', 'Tu Voz Online', @ID_PARENT, 7, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE [Codigo]='VM_ACTU'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_ACTU', 'Actualización de datos', @ID_PARENT, 8, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA', 'Gana+', @ID_PARENT, 9, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_CHAT'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_CHAT', 'Chat', @ID_PARENT, 10, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_EMBE'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_EMBE', 'Embebido', @ID_PARENT, 11, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_ODD'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_ODD', 'Oferta del Dia', @ID_PARENT, 12, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_SR'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_SR', 'ShowRoom', @ID_PARENT, 13, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_MG'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_MG', 'Más Ganadoras', @ID_PARENT, 14, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_OPT'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_OPT','Ofertas para ti', @ID_PARENT, 15, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_RD'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_RD', 'Revista Digital Completa', @ID_PARENT, 16, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_HV'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_HV', 'Herramientas de venta', @ID_PARENT, 17, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_DP'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_DP', 'Duo Perfecto', @ID_PARENT, 18, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_PN'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_PN', 'Pack de Nuevas', @ID_PARENT, 19, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_ATP'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_ATP','Arma tu Pack', @ID_PARENT, 20, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_LAN'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_LAN', 'Nuevos Lanzamientos', @ID_PARENT, 21, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_OPM'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_OPM', 'Ofertas Para Mi', @ID_PARENT, 22, 1)
END

GO

USE BelcorpChile
GO

DECLARE @ID_PARENT INT

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VER_MAS'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ( [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VER_MAS','Ver Más', 0, 1, 1)	
	SET @ID_PARENT=@@IDENTITY
END
ELSE
BEGIN
	SET @ID_PARENT= (SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VER_MAS')
END


IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='AGR_CAR'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('AGR_CAR', 'Agregar al carrito ', 0, 2, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_BONI'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_BONI', 'Bonificaciones', @ID_PARENT, 3, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_CLIE'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] 
		([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_CLIE', 'Clientes', @ID_PARENT, 4, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_PASE'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_PASE', 'Pase de Pedido', @ID_PARENT, 5, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_MIAC'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_MIAC','Mi Academia', @ID_PARENT, 6, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_TUVO'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_TUVO', 'Tu Voz Online', @ID_PARENT, 7, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE [Codigo]='VM_ACTU'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_ACTU', 'Actualización de datos', @ID_PARENT, 8, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA', 'Gana+', @ID_PARENT, 9, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_CHAT'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_CHAT', 'Chat', @ID_PARENT, 10, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_EMBE'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_EMBE', 'Embebido', @ID_PARENT, 11, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_ODD'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_ODD', 'Oferta del Dia', @ID_PARENT, 12, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_SR'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_SR', 'ShowRoom', @ID_PARENT, 13, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_MG'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_MG', 'Más Ganadoras', @ID_PARENT, 14, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_OPT'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_OPT','Ofertas para ti', @ID_PARENT, 15, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_RD'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_RD', 'Revista Digital Completa', @ID_PARENT, 16, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_HV'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_HV', 'Herramientas de venta', @ID_PARENT, 17, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_DP'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_DP', 'Duo Perfecto', @ID_PARENT, 18, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_PN'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_PN', 'Pack de Nuevas', @ID_PARENT, 19, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_ATP'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_ATP','Arma tu Pack', @ID_PARENT, 20, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_LAN'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_LAN', 'Nuevos Lanzamientos', @ID_PARENT, 21, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_OPM'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_OPM', 'Ofertas Para Mi', @ID_PARENT, 22, 1)
END

GO

USE BelcorpBolivia
GO

DECLARE @ID_PARENT INT

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VER_MAS'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ( [Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VER_MAS','Ver Más', 0, 1, 1)	
	SET @ID_PARENT=@@IDENTITY
END
ELSE
BEGIN
	SET @ID_PARENT= (SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VER_MAS')
END


IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='AGR_CAR'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('AGR_CAR', 'Agregar al carrito ', 0, 2, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_BONI'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_BONI', 'Bonificaciones', @ID_PARENT, 3, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_CLIE'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] 
		([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_CLIE', 'Clientes', @ID_PARENT, 4, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_PASE'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_PASE', 'Pase de Pedido', @ID_PARENT, 5, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_MIAC'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_MIAC','Mi Academia', @ID_PARENT, 6, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_TUVO'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_TUVO', 'Tu Voz Online', @ID_PARENT, 7, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE [Codigo]='VM_ACTU'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_ACTU', 'Actualización de datos', @ID_PARENT, 8, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA', 'Gana+', @ID_PARENT, 9, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_CHAT'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_CHAT', 'Chat', @ID_PARENT, 10, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_EMBE'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_EMBE', 'Embebido', @ID_PARENT, 11, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_ODD'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_ODD', 'Oferta del Dia', @ID_PARENT, 12, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_SR'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_SR', 'ShowRoom', @ID_PARENT, 13, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_MG'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_MG', 'Más Ganadoras', @ID_PARENT, 14, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_OPT'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_OPT','Ofertas para ti', @ID_PARENT, 15, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_RD'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_RD', 'Revista Digital Completa', @ID_PARENT, 16, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_HV'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_HV', 'Herramientas de venta', @ID_PARENT, 17, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_DP'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_DP', 'Duo Perfecto', @ID_PARENT, 18, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_PN'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_PN', 'Pack de Nuevas', @ID_PARENT, 19, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_ATP'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_ATP','Arma tu Pack', @ID_PARENT, 20, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_LAN'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_LAN', 'Nuevos Lanzamientos', @ID_PARENT, 21, 1)
END

IF(NOT EXISTS(SELECT IdContenidoAct FROM ContenidoAppDetaAct WHERE Codigo='VM_GANA_OPM'))
BEGIN
	INSERT [dbo].[ContenidoAppDetaAct] ([Codigo], [Descripcion], [Parent], [Orden], [Activo]) 
	VALUES ('VM_GANA_OPM', 'Ofertas Para Mi', @ID_PARENT, 22, 1)
END

GO

