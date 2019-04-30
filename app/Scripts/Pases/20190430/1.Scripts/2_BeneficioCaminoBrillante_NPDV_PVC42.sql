USE BelcorpChile
GO

DELETE [dbo].[BeneficioCaminoBrillante];
DBCC CHECKIDENT (BeneficioCaminoBrillante, RESEED, 0)

INSERT [dbo].[BeneficioCaminoBrillante] ([CodigoNivel], [CodigoBeneficio], [NombreBeneficio], [Descripcion], [UrlIcono], [Orden], [FechaRegistro], [FechaActualizacion])
		VALUES	('1', 'BENEFICIO01', '3 catálogos y guía de negocio L’Bel/Gana+', '', '05', 1, GETDATE(), NULL),								  
				('1', 'BENEFICIO02', 'Regalo por pedido y constancia', '', '12', 2, GETDATE(), NULL),
				('1', 'BENEFICIO03', 'Servicio Callcenter', '', '04', 3, GETDATE(), NULL),						 
				('1', 'BENEFICIO04', 'Reconocimiento', '', '11', 4, GETDATE(), NULL),										 
				('1', 'BENEFICIO05', 'Asesor guía por whatsapp y en persona', '', '01', 5, GETDATE(), NULL)

INSERT [dbo].[BeneficioCaminoBrillante] ([CodigoNivel], [CodigoBeneficio], [NombreBeneficio], [Descripcion], [UrlIcono], [Orden], [FechaRegistro], [FechaActualizacion]) 
		VALUES	('2', 'BENEFICIO01', '3 catálogos y guía de negocio L’Bel/Gana+', '', '05', 1, GETDATE(), NULL),								  
				('2', 'BENEFICIO02', 'Regalo por pedido y constancia', '', '12', 2, GETDATE(), NULL),
				('2', 'BENEFICIO03', 'Servicio Callcenter', '', '04', 3, GETDATE(), NULL),						 
				('2', 'BENEFICIO04', 'Reconocimiento', '', '11', 4, GETDATE(), NULL),										 
				('2', 'BENEFICIO05', 'Asesor guía por whatsapp y en persona', '', '01', 5, GETDATE(), NULL),
				('2', 'BENEFICIO06', 'Kit de productos a bajo precio', '5 productos + muestras', '07', 6, GETDATE(), NULL),
				('2', 'BENEFICIO07', '20% de descuento en la compra  de catálogos y demostradores', '', '06', 7, GETDATE(), NULL),
				('2', 'BENEFICIO08', 'Descuentos especiales', 'Las mejores ofertas según tu nivel', '09', 8, GETDATE(), NULL)
				

INSERT [dbo].[BeneficioCaminoBrillante] ([CodigoNivel], [CodigoBeneficio], [NombreBeneficio], [Descripcion], [UrlIcono], [Orden], [FechaRegistro], [FechaActualizacion]) 
		VALUES	('3', 'BENEFICIO01', '3 catálogos y guía de negocio L’Bel/Gana+', '', '05', 1, GETDATE(), NULL),								  
				('3', 'BENEFICIO02', 'Regalo por pedido y constancia', '', '12', 2, GETDATE(), NULL),
				('3', 'BENEFICIO03', 'Servicio Callcenter', '', '04', 3, GETDATE(), NULL),						 
				('3', 'BENEFICIO04', 'Reconocimiento', '', '11', 4, GETDATE(), NULL),										 
				('3', 'BENEFICIO05', 'Asesor guía por whatsapp y en persona', '', '01', 5, GETDATE(), NULL),
				('3', 'BENEFICIO06', 'Kit de productos a bajo precio', '5 productos + muestras', '07', 6, GETDATE(), NULL),
				('3', 'BENEFICIO07', '25% de descuento en la compra  de catálogos y demostradores', '', '06', 7, GETDATE(), NULL),
				('3', 'BENEFICIO08', 'Descuentos especiales', 'Las mejores ofertas según tu nivel', '09', 8, GETDATE(), NULL)


INSERT [dbo].[BeneficioCaminoBrillante] ([CodigoNivel], [CodigoBeneficio], [NombreBeneficio], [Descripcion], [UrlIcono], [Orden], [FechaRegistro], [FechaActualizacion]) 
		VALUES	('4', 'BENEFICIO01', '3 catálogos y guía de negocio L’Bel/Gana+', '', '05', 1, GETDATE(), NULL),								  
				('4', 'BENEFICIO02', 'Regalo por pedido y constancia', '', '12', 2, GETDATE(), NULL),
				('4', 'BENEFICIO03', 'Servicio Callcenter', '', '04', 3, GETDATE(), NULL),						 
				('4', 'BENEFICIO04', 'Reconocimiento', '', '11', 4, GETDATE(), NULL),										 
				('4', 'BENEFICIO05', 'Asesor guía por whatsapp y en persona', '', '01', 5, GETDATE(), NULL),
				('4', 'BENEFICIO06', 'Kit de productos a bajo precio', '5 productos + muestras', '07', 6, GETDATE(), NULL),
				('4', 'BENEFICIO07', '30% de descuento en la compra  de catálogos y demostradores', '', '06', 7, GETDATE(), NULL),
				('4', 'BENEFICIO08', 'Brazalete Camino Brillante', '', '03', 8, GETDATE(), NULL),
				('4', 'BENEFICIO09', 'Descuentos especiales', 'Las mejores ofertas según tu nivel', '09', 9, GETDATE(), NULL)


INSERT [dbo].[BeneficioCaminoBrillante] ([CodigoNivel], [CodigoBeneficio], [NombreBeneficio], [Descripcion], [UrlIcono], [Orden], [FechaRegistro], [FechaActualizacion]) 
		VALUES	('5', 'BENEFICIO01', '3 catálogos y guía de negocio L’Bel/Gana+', '', '05', 1, GETDATE(), NULL),								  
				('5', 'BENEFICIO02', 'Regalo por pedido y constancia', '', '12', 2, GETDATE(), NULL),
				('5', 'BENEFICIO03', 'Servicio Callcenter', '', '04', 3, GETDATE(), NULL),						 
				('5', 'BENEFICIO04', 'Reconocimiento', '', '11', 4, GETDATE(), NULL),										 
				('5', 'BENEFICIO05', 'Asesor guía por whatsapp y en persona', '', '01', 5, GETDATE(), NULL),
				('5', 'BENEFICIO06', 'Kit de productos a bajo precio', '5 productos + muestras', '07', 6, GETDATE(), NULL),
				('5', 'BENEFICIO07', '35% de descuento en la compra  de catálogos y demostradores', '', '06', 7, GETDATE(), NULL),
				('5', 'BENEFICIO08', 'Brazalete Camino Brillante', '', '03', 8, GETDATE(), NULL),
				('5', 'BENEFICIO09', 'Programa Brillante', '', '10', 9, GETDATE(), NULL),
				('5', 'BENEFICIO10', 'Descuentos especiales', 'Las mejores ofertas según tu nivel', '09', 10, GETDATE(), NULL)


INSERT [dbo].[BeneficioCaminoBrillante] ([CodigoNivel], [CodigoBeneficio], [NombreBeneficio], [Descripcion], [UrlIcono], [Orden], [FechaRegistro], [FechaActualizacion]) 
		VALUES	('6', 'BENEFICIO01', '3 catálogos y guía de negocio L’Bel/Gana+', '', '05', 1, GETDATE(), NULL),								  
				('6', 'BENEFICIO02', 'Regalo por pedido y constancia', '', '12', 2, GETDATE(), NULL),
				('6', 'BENEFICIO03', 'Servicio Callcenter', '', '04', 3, GETDATE(), NULL),						 
				('6', 'BENEFICIO04', 'Reconocimiento', '', '11', 4, GETDATE(), NULL),										 
				('6', 'BENEFICIO05', 'Asesor guía por whatsapp y en persona', '', '01', 5, GETDATE(), NULL),
				('6', 'BENEFICIO06', 'Kit de productos a bajo precio', '5 productos + muestras', '07', 6, GETDATE(), NULL),
				('6', 'BENEFICIO07', '35% de descuento en la compra  de catálogos y demostradores', '', '06', 7, GETDATE(), NULL),
				('6', 'BENEFICIO08', 'Brazalete Camino Brillante', '', '03', 8, GETDATE(), NULL),
				('6', 'BENEFICIO09', 'Programa Brillante', '', '10', 9, GETDATE(), NULL),
				('6', 'BENEFICIO10', 'Descuentos especiales', 'Las mejores ofertas según tu nivel', '09', 10, GETDATE(), NULL)
GO


USE BelcorpBolivia
GO

DELETE [dbo].[BeneficioCaminoBrillante];
DBCC CHECKIDENT (BeneficioCaminoBrillante, RESEED, 0)


INSERT [dbo].[BeneficioCaminoBrillante] ([CodigoNivel], [CodigoBeneficio], [NombreBeneficio], [Descripcion], [UrlIcono], [Orden], [FechaRegistro], [FechaActualizacion])
		VALUES	('1', 'BENEFICIO01', '3 catálogos y guía de negocio L’Bel/Gana+', '', '05', 1, GETDATE(), NULL),								  
				('1', 'BENEFICIO02', 'Regalo por pedido y constancia', '', '12', 2, GETDATE(), NULL),
				('1', 'BENEFICIO03', 'Servicio Callcenter', '', '04', 3, GETDATE(), NULL),						 
				('1', 'BENEFICIO04', 'Reconocimiento', '', '11', 4, GETDATE(), NULL),										 
				('1', 'BENEFICIO05', 'Asesor guía por whatsapp y en persona', '', '01', 5, GETDATE(), NULL)

INSERT [dbo].[BeneficioCaminoBrillante] ([CodigoNivel], [CodigoBeneficio], [NombreBeneficio], [Descripcion], [UrlIcono], [Orden], [FechaRegistro], [FechaActualizacion]) 
		VALUES	('2', 'BENEFICIO01', '3 catálogos y guía de negocio L’Bel/Gana+', '', '05', 1, GETDATE(), NULL),								  
				('2', 'BENEFICIO02', 'Regalo por pedido y constancia', '', '12', 2, GETDATE(), NULL),
				('2', 'BENEFICIO03', 'Servicio Callcenter', '', '04', 3, GETDATE(), NULL),						 
				('2', 'BENEFICIO04', 'Reconocimiento', '', '11', 4, GETDATE(), NULL),										 
				('2', 'BENEFICIO05', 'Asesor guía por whatsapp y en persona', '', '01', 5, GETDATE(), NULL),
				('2', 'BENEFICIO06', 'Kit de productos a bajo precio', '5 productos + muestras', '07', 6, GETDATE(), NULL),
				('2', 'BENEFICIO07', '20% de descuento en la compra  de catálogos y demostradores', '', '06', 7, GETDATE(), NULL),
				('2', 'BENEFICIO08', 'Descuentos especiales', 'Las mejores ofertas según tu nivel', '09', 8, GETDATE(), NULL)

INSERT [dbo].[BeneficioCaminoBrillante] ([CodigoNivel], [CodigoBeneficio], [NombreBeneficio], [Descripcion], [UrlIcono], [Orden], [FechaRegistro], [FechaActualizacion]) 
		VALUES	('3', 'BENEFICIO01', '3 catálogos y guía de negocio L’Bel/Gana+', '', '05', 1, GETDATE(), NULL),								  
				('3', 'BENEFICIO02', 'Regalo por pedido y constancia', '', '12', 2, GETDATE(), NULL),
				('3', 'BENEFICIO03', 'Servicio Callcenter', '', '04', 3, GETDATE(), NULL),						 
				('3', 'BENEFICIO04', 'Reconocimiento', '', '11', 4, GETDATE(), NULL),										 
				('3', 'BENEFICIO05', 'Asesor guía por whatsapp y en persona', '', '01', 5, GETDATE(), NULL),
				('3', 'BENEFICIO06', 'Kit de productos a bajo precio', '5 productos + muestras', '07', 6, GETDATE(), NULL),
				('3', 'BENEFICIO07', '25% de descuento en la compra  de catálogos y demostradores', '', '06', 7, GETDATE(), NULL),
				('3', 'BENEFICIO08', 'Talleres', '', '13', 8, GETDATE(), NULL),
				('3', 'BENEFICIO09', 'Descuentos especiales', 'Las mejores ofertas según tu nivel', '09', 9, GETDATE(), NULL)


INSERT [dbo].[BeneficioCaminoBrillante] ([CodigoNivel], [CodigoBeneficio], [NombreBeneficio], [Descripcion], [UrlIcono], [Orden], [FechaRegistro], [FechaActualizacion]) 
		VALUES	('4', 'BENEFICIO01', '3 catálogos y guía de negocio L’Bel/Gana+', '', '05', 1, GETDATE(), NULL),								  
				('4', 'BENEFICIO02', 'Regalo por pedido y constancia', '', '12', 2, GETDATE(), NULL),
				('4', 'BENEFICIO03', 'Servicio Callcenter', '', '04', 3, GETDATE(), NULL),						 
				('4', 'BENEFICIO04', 'Reconocimiento', '', '11', 4, GETDATE(), NULL),										 
				('4', 'BENEFICIO05', 'Asesor guía por whatsapp y en persona', '', '01', 5, GETDATE(), NULL),
				('4', 'BENEFICIO06', 'Kit de productos a bajo precio', '5 productos + muestras', '07', 6, GETDATE(), NULL),
				('4', 'BENEFICIO07', '30% de descuento en la compra  de catálogos y demostradores', '', '06', 7, GETDATE(), NULL),
				('4', 'BENEFICIO08', 'Talleres', '', '13', 8, GETDATE(), NULL),
				('4', 'BENEFICIO09', 'Concurso de monto de pedido', '', '02', 9, GETDATE(), NULL),
				('4', 'BENEFICIO10', 'Brazalete Camino Brillante', '', '03', 10, GETDATE(), NULL),
				('4', 'BENEFICIO11', 'Descuentos especiales', 'Las mejores ofertas según tu nivel', '09', 11, GETDATE(), NULL)


INSERT [dbo].[BeneficioCaminoBrillante] ([CodigoNivel], [CodigoBeneficio], [NombreBeneficio], [Descripcion], [UrlIcono], [Orden], [FechaRegistro], [FechaActualizacion]) 
		VALUES	('5', 'BENEFICIO01', '3 catálogos y guía de negocio L’Bel/Gana+', '', '05', 1, GETDATE(), NULL),								  
				('5', 'BENEFICIO02', 'Regalo por pedido y constancia', '', '12', 2, GETDATE(), NULL),
				('5', 'BENEFICIO03', 'Servicio Callcenter', '', '04', 3, GETDATE(), NULL),						 
				('5', 'BENEFICIO04', 'Reconocimiento', '', '11', 4, GETDATE(), NULL),										 
				('5', 'BENEFICIO05', 'Asesor guía por whatsapp y en persona', '', '01', 5, GETDATE(), NULL),
				('5', 'BENEFICIO06', 'Kit de productos a bajo precio', '5 productos + muestras', '07', 6, GETDATE(), NULL),
				('5', 'BENEFICIO07', '35% de descuento en la compra  de catálogos y demostradores', '', '06', 7, GETDATE(), NULL),
				('5', 'BENEFICIO08', 'Talleres', '', '13', 8, GETDATE(), NULL),
				('5', 'BENEFICIO09', 'Concurso de monto de pedido', '', '02', 9, GETDATE(), NULL),
				('5', 'BENEFICIO10', 'Brazalete Camino Brillante', '', '03', 10, GETDATE(), NULL),
				('5', 'BENEFICIO11', 'Descuento en flete', '', '14', 11, GETDATE(), NULL),
				('5', 'BENEFICIO12', 'Programa Brillante', '', '10', 12, GETDATE(), NULL),
				('5', 'BENEFICIO13', 'Descuentos especiales', 'Las mejores ofertas según tu nivel', '09', 13, GETDATE(), NULL)


INSERT [dbo].[BeneficioCaminoBrillante] ([CodigoNivel], [CodigoBeneficio], [NombreBeneficio], [Descripcion], [UrlIcono], [Orden], [FechaRegistro], [FechaActualizacion]) 
		VALUES	('6', 'BENEFICIO01', '3 catálogos y guía de negocio L’Bel/Gana+', '', '05', 1, GETDATE(), NULL),								  
				('6', 'BENEFICIO02', 'Regalo por pedido y constancia', '', '12', 2, GETDATE(), NULL),
				('6', 'BENEFICIO03', 'Servicio Callcenter', '', '04', 3, GETDATE(), NULL),						 
				('6', 'BENEFICIO04', 'Reconocimiento', '', '11', 4, GETDATE(), NULL),										 
				('6', 'BENEFICIO05', 'Asesor guía por whatsapp y en persona', '', '01', 5, GETDATE(), NULL),
				('6', 'BENEFICIO06', 'Kit de productos a bajo precio', '5 productos + muestras', '07', 6, GETDATE(), NULL),
				('6', 'BENEFICIO07', '35% de descuento en la compra  de catálogos y demostradores', '', '06', 7, GETDATE(), NULL),
				('6', 'BENEFICIO08', 'Talleres', '', '13', 8, GETDATE(), NULL),
				('6', 'BENEFICIO09', 'Concurso de monto de pedido', '', '02', 9, GETDATE(), NULL),
				('6', 'BENEFICIO10', 'Brazalete Camino Brillante', '', '03', 10, GETDATE(), NULL),
				('6', 'BENEFICIO11', 'Descuento en flete', '', '14', 11, GETDATE(), NULL),
				('6', 'BENEFICIO12', 'Programa Brillante', '', '10', 12, GETDATE(), NULL),
				('6', 'BENEFICIO13', 'Descuentos especiales', 'Las mejores ofertas según tu nivel', '09', 13, GETDATE(), NULL)
GO


USE BelcorpCostaRica
GO

DELETE [dbo].[BeneficioCaminoBrillante];
DBCC CHECKIDENT (BeneficioCaminoBrillante, RESEED, 0)

INSERT [dbo].[BeneficioCaminoBrillante] ([CodigoNivel], [CodigoBeneficio], [NombreBeneficio], [Descripcion], [UrlIcono], [Orden], [FechaRegistro], [FechaActualizacion])
		VALUES	('1', 'BENEFICIO01', '3 catálogos y guía de negocio L’Bel/Gana+', '', '05', 1, GETDATE(), NULL),								  
				('1', 'BENEFICIO02', 'Regalo por pedido y constancia', '', '12', 2, GETDATE(), NULL),
				('1', 'BENEFICIO03', 'Servicio Callcenter', '', '04', 3, GETDATE(), NULL),						 
				('1', 'BENEFICIO04', 'Reconocimiento', '', '11', 4, GETDATE(), NULL),										 
				('1', 'BENEFICIO05', 'Asesor guía por whatsapp y en persona', '', '01', 5, GETDATE(), NULL)

INSERT [dbo].[BeneficioCaminoBrillante] ([CodigoNivel], [CodigoBeneficio], [NombreBeneficio], [Descripcion], [UrlIcono], [Orden], [FechaRegistro], [FechaActualizacion]) 
		VALUES	('2', 'BENEFICIO01', '3 catálogos y guía de negocio L’Bel/Gana+', '', '05', 1, GETDATE(), NULL),								  
				('2', 'BENEFICIO02', 'Regalo por pedido y constancia', '', '12', 2, GETDATE(), NULL),
				('2', 'BENEFICIO03', 'Servicio Callcenter', '', '04', 3, GETDATE(), NULL),						 
				('2', 'BENEFICIO04', 'Reconocimiento', '', '11', 4, GETDATE(), NULL),										 
				('2', 'BENEFICIO05', 'Asesor guía por whatsapp y en persona', '', '01', 5, GETDATE(), NULL),
				('2', 'BENEFICIO06', 'Kit de productos a bajo precio', '5 productos + muestras', '07', 6, GETDATE(), NULL),
				('2', 'BENEFICIO07', '20% de descuento en la compra  de catálogos y demostradores', '', '06', 7, GETDATE(), NULL),
				('2', 'BENEFICIO08', 'Descuentos especiales', 'Las mejores ofertas según tu nivel', '09', 8, GETDATE(), NULL)
				

INSERT [dbo].[BeneficioCaminoBrillante] ([CodigoNivel], [CodigoBeneficio], [NombreBeneficio], [Descripcion], [UrlIcono], [Orden], [FechaRegistro], [FechaActualizacion]) 
		VALUES	('3', 'BENEFICIO01', '3 catálogos y guía de negocio L’Bel/Gana+', '', '05', 1, GETDATE(), NULL),								  
				('3', 'BENEFICIO02', 'Regalo por pedido y constancia', '', '12', 2, GETDATE(), NULL),
				('3', 'BENEFICIO03', 'Servicio Callcenter', '', '04', 3, GETDATE(), NULL),						 
				('3', 'BENEFICIO04', 'Reconocimiento', '', '11', 4, GETDATE(), NULL),										 
				('3', 'BENEFICIO05', 'Asesor guía por whatsapp y en persona', '', '01', 5, GETDATE(), NULL),
				('3', 'BENEFICIO06', 'Kit de productos a bajo precio', '5 productos + muestras', '07', 6, GETDATE(), NULL),
				('3', 'BENEFICIO07', '25% de descuento en la compra  de catálogos y demostradores', '', '06', 7, GETDATE(), NULL),
				('3', 'BENEFICIO08', 'Talleres', '', '13', 8, GETDATE(), NULL),
				('3', 'BENEFICIO09', 'Descuentos especiales', 'Las mejores ofertas según tu nivel', '09', 9, GETDATE(), NULL)


INSERT [dbo].[BeneficioCaminoBrillante] ([CodigoNivel], [CodigoBeneficio], [NombreBeneficio], [Descripcion], [UrlIcono], [Orden], [FechaRegistro], [FechaActualizacion]) 
		VALUES	('4', 'BENEFICIO01', '3 catálogos y guía de negocio L’Bel/Gana+', '', '05', 1, GETDATE(), NULL),								  
				('4', 'BENEFICIO02', 'Regalo por pedido y constancia', '', '12', 2, GETDATE(), NULL),
				('4', 'BENEFICIO03', 'Servicio Callcenter', '', '04', 3, GETDATE(), NULL),						 
				('4', 'BENEFICIO04', 'Reconocimiento', '', '11', 4, GETDATE(), NULL),										 
				('4', 'BENEFICIO05', 'Asesor guía por whatsapp y en persona', '', '01', 5, GETDATE(), NULL),
				('4', 'BENEFICIO06', 'Kit de productos a bajo precio', '5 productos + muestras', '07', 6, GETDATE(), NULL),
				('4', 'BENEFICIO07', '30% de descuento en la compra  de catálogos y demostradores', '', '06', 7, GETDATE(), NULL),
				('4', 'BENEFICIO08', 'Talleres', '', '13', 8, GETDATE(), NULL),
				('4', 'BENEFICIO09', 'Concurso de monto de pedido', '', '02', 9, GETDATE(), NULL),
				('4', 'BENEFICIO10', 'Brazalete Camino Brillante', '', '03', 10, GETDATE(), NULL),
				('4', 'BENEFICIO11', 'Descuentos especiales', 'Las mejores ofertas según tu nivel', '09', 11, GETDATE(), NULL)


INSERT [dbo].[BeneficioCaminoBrillante] ([CodigoNivel], [CodigoBeneficio], [NombreBeneficio], [Descripcion], [UrlIcono], [Orden], [FechaRegistro], [FechaActualizacion]) 
		VALUES	('5', 'BENEFICIO01', '3 catálogos y guía de negocio L’Bel/Gana+', '', '05', 1, GETDATE(), NULL),								  
				('5', 'BENEFICIO02', 'Regalo por pedido y constancia', '', '12', 2, GETDATE(), NULL),
				('5', 'BENEFICIO03', 'Servicio Callcenter', '', '04', 3, GETDATE(), NULL),						 
				('5', 'BENEFICIO04', 'Reconocimiento', '', '11', 4, GETDATE(), NULL),										 
				('5', 'BENEFICIO05', 'Asesor guía por whatsapp y en persona', '', '01', 5, GETDATE(), NULL),
				('5', 'BENEFICIO06', 'Kit de productos a bajo precio', '5 productos + muestras', '07', 6, GETDATE(), NULL),
				('5', 'BENEFICIO07', '35% de descuento en la compra  de catálogos y demostradores', '', '06', 7, GETDATE(), NULL),
				('5', 'BENEFICIO08', 'Talleres', '', '13', 8, GETDATE(), NULL),
				('5', 'BENEFICIO09', 'Concurso de monto de pedido', '', '02', 9, GETDATE(), NULL),
				('5', 'BENEFICIO10', 'Brazalete Camino Brillante', '', '03', 10, GETDATE(), NULL),
				('5', 'BENEFICIO11', 'Descuento en flete', '', '06', 11, GETDATE(), NULL),
				('5', 'BENEFICIO12', 'Pago diferido', '', '08', 12, GETDATE(), NULL),
				('5', 'BENEFICIO13', 'Programa Brillante', '', '10', 13, GETDATE(), NULL),
				('5', 'BENEFICIO14', 'Descuentos especiales', 'Las mejores ofertas según tu nivel', '09', 14, GETDATE(), NULL)


INSERT [dbo].[BeneficioCaminoBrillante] ([CodigoNivel], [CodigoBeneficio], [NombreBeneficio], [Descripcion], [UrlIcono], [Orden], [FechaRegistro], [FechaActualizacion]) 
		VALUES	('6', 'BENEFICIO01', '3 catálogos y guía de negocio L’Bel/Gana+', '', '05', 1, GETDATE(), NULL),								  
				('6', 'BENEFICIO02', 'Regalo por pedido y constancia', '', '12', 2, GETDATE(), NULL),
				('6', 'BENEFICIO03', 'Servicio Callcenter', '', '04', 3, GETDATE(), NULL),						 
				('6', 'BENEFICIO04', 'Reconocimiento', '', '11', 4, GETDATE(), NULL),										 
				('6', 'BENEFICIO05', 'Asesor guía por whatsapp y en persona', '', '01', 5, GETDATE(), NULL),
				('6', 'BENEFICIO06', 'Kit de productos a bajo precio', '5 productos + muestras', '07', 6, GETDATE(), NULL),
				('6', 'BENEFICIO07', '35% de descuento en la compra  de catálogos y demostradores', '', '06', 7, GETDATE(), NULL),
				('6', 'BENEFICIO08', 'Talleres', '', '13', 8, GETDATE(), NULL),
				('6', 'BENEFICIO09', 'Concurso de monto de pedido', '', '02', 9, GETDATE(), NULL),
				('6', 'BENEFICIO10', 'Brazalete Camino Brillante', '', '03', 10, GETDATE(), NULL),
				('6', 'BENEFICIO11', 'Descuento en flete', '', '06', 11, GETDATE(), NULL),
				('6', 'BENEFICIO12', 'Pago diferido', '', '08', 12, GETDATE(), NULL),
				('6', 'BENEFICIO13', 'Programa Brillante', '', '10', 13, GETDATE(), NULL),
				('6', 'BENEFICIO14', 'Descuentos especiales', 'Las mejores ofertas según tu nivel', '09', 14, GETDATE(), NULL)

