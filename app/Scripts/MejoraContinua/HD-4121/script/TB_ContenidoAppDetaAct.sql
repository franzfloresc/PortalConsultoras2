USE [BelcorpPeru_MC]
GO
/****** Object:  Table [dbo].[ContenidoAppDetaAct]    Script Date: 15/5/2019 10:31:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ContenidoAppDetaAct](
	[IdContenidoAct] [int] IDENTITY(1,1) NOT NULL,
	[Codigo] [varchar](20) NOT NULL,
	[Descripcion] [varchar](100) NOT NULL,
	[Parent] [int] NULL,
	[Orden] [int] NULL,
	[Activo] [bit] NULL,
 CONSTRAINT [PK_ContenidoAppDetaAct] PRIMARY KEY CLUSTERED 
(
	[IdContenidoAct] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[ContenidoAppDetaAct] ON 

INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) VALUES (1, N'VER_MAS', N'Ver Más', 0, 1, 1)
INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) VALUES (2, N'AGR_CAR', N'Agregar al carrito ', 0, 2, 1)
INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) VALUES (3, N'VM_BONI', N'Bonificaciones', 1, 3, 1)
INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) VALUES (4, N'VM_CLIE', N'Clientes', 1, 4, 1)
INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) VALUES (5, N'VM_PASE', N'Pase de Pedido', 1, 5, 1)
INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) VALUES (6, N'VM_MIAC', N'Mi Academia', 1, 6, 1)
INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) VALUES (7, N'VM_TUVO', N'Tu Voz Online', 1, 7, 1)
INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) VALUES (8, N'VM_ACTU', N'Actualización de datos', 1, 8, 1)
INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) VALUES (9, N'VM_GANA', N'Gana+', 1, 9, 1)
INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) VALUES (10, N'VM_CHAT', N'Chat', 1, 10, 1)
INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) VALUES (11, N'VM_EMBE', N'Embebido', 1, 11, 1)
INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) VALUES (12, N'VM_GANA_ODD', N'Oferta del Dia', 1, 12, 1)
INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) VALUES (13, N'VM_GANA_SR', N'ShowRoom', 1, 13, 1)
INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) VALUES (14, N'VM_GANA_MG', N'Más Ganadoras', 1, 14, 1)
INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) VALUES (15, N'VM_GANA_OPT', N'Ofertas para ti', 1, 15, 1)
INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) VALUES (16, N'VM_GANA_RD', N'Revista Digital Completa', 1, 16, 1)
INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) VALUES (17, N'VM_GANA_HV', N'Herramientas de venta', 1, 17, 1)
INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) VALUES (18, N'VM_GANA_DP', N'Duo Perfecto', 1, 18, 1)
INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) VALUES (19, N'VM_GANA_PN', N'Pack de Nuevas', 1, 19, 1)
INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) VALUES (20, N'VM_GANA_ATP', N'Arma tu Pack', 1, 20, 1)
INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) VALUES (21, N'VM_GANA_LAN', N'Nuevos Lanzamientos', 1, 21, 1)
INSERT [dbo].[ContenidoAppDetaAct] ([IdContenidoAct], [Codigo], [Descripcion], [Parent], [Orden], [Activo]) VALUES (22, N'VM_GANA_OPM', N'Ofertas Para Mi', 1, 22, 1)
SET IDENTITY_INSERT [dbo].[ContenidoAppDetaAct] OFF
