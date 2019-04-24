USE BelcorpChile
GO

DELETE [dbo].[BeneficioCaminoBrillante];
DBCC CHECKIDENT (BeneficioCaminoBrillante, RESEED, 0)

INSERT [dbo].[BeneficioCaminoBrillante] ([CodigoNivel], [CodigoBeneficio], [NombreBeneficio], [Descripcion], [UrlIcono], [Orden], [FechaRegistro], [FechaActualizacion])
		VALUES	('1', 'BENEFICIO01', '3 catálogos y Guía de Negocio L’Bel/Gana+', '', '04', 1, GETDATE(), NULL),								  
				('1', 'BENEFICIO02', 'Regalo por Pedido / Constancia (en campañas específicas)', '', '04', 2, GETDATE(), NULL),
				('1', 'BENEFICIO03', 'Call Center', '', '09', 3, GETDATE(), NULL),						 
				('1', 'BENEFICIO04', 'Reconocimiento', '', '03', 4, GETDATE(), NULL),										 
				('1', 'BENEFICIO05', 'Acompañamiento presencial y virtual', '', '01', 5, GETDATE(), NULL)

INSERT [dbo].[BeneficioCaminoBrillante] ([CodigoNivel], [CodigoBeneficio], [NombreBeneficio], [Descripcion], [UrlIcono], [Orden], [FechaRegistro], [FechaActualizacion]) 
		VALUES	('2', 'BENEFICIO01', '3 catálogos y Guía de Negocio L’Bel/Gana+', '', '04', 1, GETDATE(), NULL),								  
				('2', 'BENEFICIO02', 'Regalo por Pedido / Constancia (en campañas específicas)', '', '04', 2, GETDATE(), NULL),
				('2', 'BENEFICIO03', 'Call Center', '', '09', 3, GETDATE(), NULL),						 
				('2', 'BENEFICIO04', 'Reconocimiento', '', '03', 4, GETDATE(), NULL),										 
				('2', 'BENEFICIO05', 'Acompañamiento presencial y virtual', '', '01', 5, GETDATE(), NULL),
				('2', 'BENEFICIO06', 'Kit de productos por nivel', '', '01', 6, GETDATE(), NULL),
				('2', 'BENEFICIO07', 'Descuento en demostradores y catálogos', '', '01', 7, GETDATE(), NULL)
				

INSERT [dbo].[BeneficioCaminoBrillante] ([CodigoNivel], [CodigoBeneficio], [NombreBeneficio], [Descripcion], [UrlIcono], [Orden], [FechaRegistro], [FechaActualizacion]) 
		VALUES	('3', 'BENEFICIO01', '3 catálogos y Guía de Negocio L’Bel/Gana+', '', '04', 1, GETDATE(), NULL),								  
				('3', 'BENEFICIO02', 'Regalo por Pedido / Constancia (en campañas específicas)', '', '04', 2, GETDATE(), NULL),
				('3', 'BENEFICIO03', 'Call Center', '', '09', 3, GETDATE(), NULL),						 
				('3', 'BENEFICIO04', 'Reconocimiento', '', '03', 4, GETDATE(), NULL),										 
				('3', 'BENEFICIO05', 'Acompañamiento presencial y virtual', '', '01', 5, GETDATE(), NULL),
				('3', 'BENEFICIO06', 'Kit de productos por nivel', '', '01', 6, GETDATE(), NULL),
				('3', 'BENEFICIO07', 'Descuento en demostradores y catálogos', '', '01', 7, GETDATE(), NULL)


INSERT [dbo].[BeneficioCaminoBrillante] ([CodigoNivel], [CodigoBeneficio], [NombreBeneficio], [Descripcion], [UrlIcono], [Orden], [FechaRegistro], [FechaActualizacion]) 
		VALUES	('4', 'BENEFICIO01', '3 catálogos y Guía de Negocio L’Bel/Gana+', '', '04', 1, GETDATE(), NULL),								  
				('4', 'BENEFICIO02', 'Regalo por Pedido / Constancia (en campañas específicas)', '', '04', 2, GETDATE(), NULL),
				('4', 'BENEFICIO03', 'Call Center', '', '09', 3, GETDATE(), NULL),						 
				('4', 'BENEFICIO04', 'Reconocimiento', '', '03', 4, GETDATE(), NULL),										 
				('4', 'BENEFICIO05', 'Acompañamiento presencial y virtual', '', '01', 5, GETDATE(), NULL),
				('4', 'BENEFICIO06', 'Kit de productos por nivel', '', '01', 7, GETDATE(), NULL),
				('4', 'BENEFICIO07', 'Descuento en demostradores y catálogos', '', '01', 8, GETDATE(), NULL),
				('4', 'BENEFICIO08', 'Brazalete Camino Brillante', '', '01', 6, GETDATE(), NULL)


INSERT [dbo].[BeneficioCaminoBrillante] ([CodigoNivel], [CodigoBeneficio], [NombreBeneficio], [Descripcion], [UrlIcono], [Orden], [FechaRegistro], [FechaActualizacion]) 
		VALUES	('5', 'BENEFICIO01', '3 catálogos y Guía de Negocio L’Bel/Gana+', '', '04', 1, GETDATE(), NULL),								  
				('5', 'BENEFICIO02', 'Regalo por Pedido / Constancia (en campañas específicas)', '', '04', 2, GETDATE(), NULL),
				('5', 'BENEFICIO03', 'Call Center', '', '09', 3, GETDATE(), NULL),						 
				('5', 'BENEFICIO04', 'Reconocimiento', '', '03', 4, GETDATE(), NULL),										 
				('5', 'BENEFICIO05', 'Acompañamiento presencial y virtual', '', '01', 5, GETDATE(), NULL),
				('5', 'BENEFICIO06', 'Kit de productos por nivel', '', '01', 8, GETDATE(), NULL),
				('5', 'BENEFICIO07', 'Descuento en demostradores y catálogos', '', '01', 9, GETDATE(), NULL),
				('5', 'BENEFICIO08', 'Brazalete Camino Brillante', '', '01', 6, GETDATE(), NULL),
				('5', 'BENEFICIO09', 'Programa Brillante', '', '01', 7, GETDATE(), NULL)


INSERT [dbo].[BeneficioCaminoBrillante] ([CodigoNivel], [CodigoBeneficio], [NombreBeneficio], [Descripcion], [UrlIcono], [Orden], [FechaRegistro], [FechaActualizacion]) 
		VALUES	('6', 'BENEFICIO01', '3 catálogos y Guía de Negocio L’Bel/Gana+', '', '04', 1, GETDATE(), NULL),								  
				('6', 'BENEFICIO02', 'Regalo por Pedido / Constancia (en campañas específicas)', '', '04', 2, GETDATE(), NULL),
				('6', 'BENEFICIO03', 'Call Center', '', '09', 3, GETDATE(), NULL),						 
				('6', 'BENEFICIO04', 'Reconocimiento', '', '03', 4, GETDATE(), NULL),										 
				('6', 'BENEFICIO05', 'Acompañamiento presencial y virtual', '', '01', 5, GETDATE(), NULL),
				('6', 'BENEFICIO06', 'Kit de productos por nivel', '', '01', 8, GETDATE(), NULL),
				('6', 'BENEFICIO07', 'Descuento en demostradores y catálogos', '', '01', 9, GETDATE(), NULL),
				('6', 'BENEFICIO08', 'Brazalete Camino Brillante', '', '01', 6, GETDATE(), NULL),
				('6', 'BENEFICIO09', 'Programa Brillante', '', '01', 7, GETDATE(), NULL)
GO


USE BelcorpBolivia
GO

DELETE [dbo].[BeneficioCaminoBrillante];
DBCC CHECKIDENT (BeneficioCaminoBrillante, RESEED, 0)

INSERT [dbo].[BeneficioCaminoBrillante] ([CodigoNivel], [CodigoBeneficio], [NombreBeneficio], [Descripcion], [UrlIcono], [Orden], [FechaRegistro], [FechaActualizacion])
		VALUES	('1', 'BENEFICIO01', '3 catálogos y Guía de Negocio L’Bel/Gana+', '', '04', 1, GETDATE(), NULL),								  
				('1', 'BENEFICIO02', 'Regalo por Pedido / Constancia (en campañas específicas)', '', '04', 2, GETDATE(), NULL),
				('1', 'BENEFICIO03', 'Call Center', '', '09', 3, GETDATE(), NULL),						 
				('1', 'BENEFICIO04', 'Reconocimiento', '', '03', 4, GETDATE(), NULL),										 
				('1', 'BENEFICIO05', 'Acompañamiento presencial y virtual', '', '01', 5, GETDATE(), NULL)

INSERT [dbo].[BeneficioCaminoBrillante] ([CodigoNivel], [CodigoBeneficio], [NombreBeneficio], [Descripcion], [UrlIcono], [Orden], [FechaRegistro], [FechaActualizacion]) 
		VALUES	('2', 'BENEFICIO01', '3 catálogos y Guía de Negocio L’Bel/Gana+', '', '04', 1, GETDATE(), NULL),								  
				('2', 'BENEFICIO02', 'Regalo por Pedido / Constancia (en campañas específicas)', '', '04', 2, GETDATE(), NULL),
				('2', 'BENEFICIO03', 'Call Center', '', '09', 3, GETDATE(), NULL),						 
				('2', 'BENEFICIO04', 'Reconocimiento', '', '03', 4, GETDATE(), NULL),										 
				('2', 'BENEFICIO05', 'Acompañamiento presencial y virtual', '', '01', 5, GETDATE(), NULL),
				('2', 'BENEFICIO06', 'Kit de productos por nivel', '', '01', 6, GETDATE(), NULL),
				('2', 'BENEFICIO07', 'Descuento en demostradores y catálogos', '', '01', 7, GETDATE(), NULL)
				

INSERT [dbo].[BeneficioCaminoBrillante] ([CodigoNivel], [CodigoBeneficio], [NombreBeneficio], [Descripcion], [UrlIcono], [Orden], [FechaRegistro], [FechaActualizacion]) 
		VALUES	('3', 'BENEFICIO01', '3 catálogos y Guía de Negocio L’Bel/Gana+', '', '04', 1, GETDATE(), NULL),								  
				('3', 'BENEFICIO02', 'Regalo por Pedido / Constancia (en campañas específicas)', '', '04', 2, GETDATE(), NULL),
				('3', 'BENEFICIO03', 'Call Center', '', '09', 3, GETDATE(), NULL),						 
				('3', 'BENEFICIO04', 'Reconocimiento', '', '03', 4, GETDATE(), NULL),										 
				('3', 'BENEFICIO05', 'Acompañamiento presencial y virtual', '', '01', 5, GETDATE(), NULL),
				('3', 'BENEFICIO06', 'Kit de productos por nivel', '', '01', 7, GETDATE(), NULL),
				('3', 'BENEFICIO07', 'Descuento en demostradores y catálogos', '', '01', 8, GETDATE(), NULL),
				('3', 'BENEFICIO08', 'Talleres', '', '01', 6, GETDATE(), NULL)


INSERT [dbo].[BeneficioCaminoBrillante] ([CodigoNivel], [CodigoBeneficio], [NombreBeneficio], [Descripcion], [UrlIcono], [Orden], [FechaRegistro], [FechaActualizacion]) 
		VALUES	('4', 'BENEFICIO01', '3 catálogos y Guía de Negocio L’Bel/Gana+', '', '04', 1, GETDATE(), NULL),								  
				('4', 'BENEFICIO02', 'Regalo por Pedido / Constancia (en campañas específicas)', '', '04', 2, GETDATE(), NULL),
				('4', 'BENEFICIO03', 'Call Center', '', '09', 3, GETDATE(), NULL),						 
				('4', 'BENEFICIO04', 'Reconocimiento', '', '03', 4, GETDATE(), NULL),										 
				('4', 'BENEFICIO05', 'Acompañamiento presencial y virtual', '', '01', 5, GETDATE(), NULL),
				('4', 'BENEFICIO06', 'Kit de productos por nivel', '', '01', 9, GETDATE(), NULL),
				('4', 'BENEFICIO07', 'Descuento en demostradores y catálogos', '', '01', 10, GETDATE(), NULL),
				('4', 'BENEFICIO08', 'Talleres', '', '01', 6, GETDATE(), NULL),
				('4', 'BENEFICIO09', 'Concurso de monto de pedido (en campañas específicas)', '', '01', 7, GETDATE(), NULL),
				('4', 'BENEFICIO10', 'Brazalete Camino Brillante', '', '01', 8, GETDATE(), NULL)


INSERT [dbo].[BeneficioCaminoBrillante] ([CodigoNivel], [CodigoBeneficio], [NombreBeneficio], [Descripcion], [UrlIcono], [Orden], [FechaRegistro], [FechaActualizacion]) 
		VALUES	('5', 'BENEFICIO01', '3 catálogos y Guía de Negocio L’Bel/Gana+', '', '04', 1, GETDATE(), NULL),								  
				('5', 'BENEFICIO02', 'Regalo por Pedido / Constancia (en campañas específicas)', '', '04', 2, GETDATE(), NULL),
				('5', 'BENEFICIO03', 'Call Center', '', '09', 3, GETDATE(), NULL),						 
				('5', 'BENEFICIO04', 'Reconocimiento', '', '03', 4, GETDATE(), NULL),										 
				('5', 'BENEFICIO05', 'Acompañamiento presencial y virtual', '', '01', 5, GETDATE(), NULL),
				('5', 'BENEFICIO06', 'Kit de productos por nivel', '', '01', 11, GETDATE(), NULL),
				('5', 'BENEFICIO07', 'Descuento en demostradores y catálogos', '', '01', 12, GETDATE(), NULL),
				('5', 'BENEFICIO08', 'Talleres', '', '01', 6, GETDATE(), NULL),
				('5', 'BENEFICIO09', 'Concurso de monto de pedido (en campañas específicas)', '', '01', 7, GETDATE(), NULL),
				('5', 'BENEFICIO10', 'Brazalete Camino Brillante', '', '01', 8, GETDATE(), NULL),
				('5', 'BENEFICIO11', 'Descuento en flete', '', '01', 9, GETDATE(), NULL),
				('5', 'BENEFICIO12', 'Programa Brillante', '', '01', 10, GETDATE(), NULL)


INSERT [dbo].[BeneficioCaminoBrillante] ([CodigoNivel], [CodigoBeneficio], [NombreBeneficio], [Descripcion], [UrlIcono], [Orden], [FechaRegistro], [FechaActualizacion]) 
		VALUES	('6', 'BENEFICIO01', '3 catálogos y Guía de Negocio L’Bel/Gana+', '', '04', 1, GETDATE(), NULL),								  
				('6', 'BENEFICIO02', 'Regalo por Pedido / Constancia (en campañas específicas)', '', '04', 2, GETDATE(), NULL),
				('6', 'BENEFICIO03', 'Call Center', '', '09', 3, GETDATE(), NULL),						 
				('6', 'BENEFICIO04', 'Reconocimiento', '', '03', 4, GETDATE(), NULL),										 
				('6', 'BENEFICIO05', 'Acompañamiento presencial y virtual', '', '01', 5, GETDATE(), NULL),
				('6', 'BENEFICIO06', 'Kit de productos por nivel', '', '01', 11, GETDATE(), NULL),
				('6', 'BENEFICIO07', 'Descuento en demostradores y catálogos', '', '01', 12, GETDATE(), NULL),
				('6', 'BENEFICIO08', 'Talleres', '', '01', 6, GETDATE(), NULL),
				('6', 'BENEFICIO09', 'Concurso de monto de pedido (en campañas específicas)', '', '01', 7, GETDATE(), NULL),
				('6', 'BENEFICIO10', 'Brazalete Camino Brillante', '', '01', 8, GETDATE(), NULL),
				('6', 'BENEFICIO11', 'Descuento en flete', '', '01', 9, GETDATE(), NULL),
				('6', 'BENEFICIO12', 'Programa Brillante', '', '01', 10, GETDATE(), NULL)
GO


USE BelcorpCostaRica
GO

DELETE [dbo].[BeneficioCaminoBrillante];
DBCC CHECKIDENT (BeneficioCaminoBrillante, RESEED, 0)

INSERT [dbo].[BeneficioCaminoBrillante] ([CodigoNivel], [CodigoBeneficio], [NombreBeneficio], [Descripcion], [UrlIcono], [Orden], [FechaRegistro], [FechaActualizacion])
		VALUES	('1', 'BENEFICIO01', '3 catálogos y Guía de Negocio L’Bel/Gana+', '', '04', 1, GETDATE(), NULL),								  
				('1', 'BENEFICIO02', 'Regalo por Pedido / Constancia (en campañas específicas)', '', '04', 2, GETDATE(), NULL),
				('1', 'BENEFICIO03', 'Call Center', '', '09', 3, GETDATE(), NULL),						 
				('1', 'BENEFICIO04', 'Reconocimiento', '', '03', 4, GETDATE(), NULL),										 
				('1', 'BENEFICIO05', 'Acompañamiento presencial y virtual', '', '01', 5, GETDATE(), NULL)

INSERT [dbo].[BeneficioCaminoBrillante] ([CodigoNivel], [CodigoBeneficio], [NombreBeneficio], [Descripcion], [UrlIcono], [Orden], [FechaRegistro], [FechaActualizacion]) 
		VALUES	('2', 'BENEFICIO01', '3 catálogos y Guía de Negocio L’Bel/Gana+', '', '04', 1, GETDATE(), NULL),								  
				('2', 'BENEFICIO02', 'Regalo por Pedido / Constancia (en campañas específicas)', '', '04', 2, GETDATE(), NULL),
				('2', 'BENEFICIO03', 'Call Center', '', '09', 3, GETDATE(), NULL),						 
				('2', 'BENEFICIO04', 'Reconocimiento', '', '03', 4, GETDATE(), NULL),										 
				('2', 'BENEFICIO05', 'Acompañamiento presencial y virtual', '', '01', 5, GETDATE(), NULL),
				('2', 'BENEFICIO06', 'Kit de productos por nivel', '', '01', 6, GETDATE(), NULL),
				('2', 'BENEFICIO07', 'Descuento en demostradores y catálogos', '', '01', 7, GETDATE(), NULL)
				

INSERT [dbo].[BeneficioCaminoBrillante] ([CodigoNivel], [CodigoBeneficio], [NombreBeneficio], [Descripcion], [UrlIcono], [Orden], [FechaRegistro], [FechaActualizacion]) 
		VALUES	('3', 'BENEFICIO01', '3 catálogos y Guía de Negocio L’Bel/Gana+', '', '04', 1, GETDATE(), NULL),								  
				('3', 'BENEFICIO02', 'Regalo por Pedido / Constancia (en campañas específicas)', '', '04', 2, GETDATE(), NULL),
				('3', 'BENEFICIO03', 'Call Center', '', '09', 3, GETDATE(), NULL),						 
				('3', 'BENEFICIO04', 'Reconocimiento', '', '03', 4, GETDATE(), NULL),										 
				('3', 'BENEFICIO05', 'Acompañamiento presencial y virtual', '', '01', 5, GETDATE(), NULL),
				('3', 'BENEFICIO06', 'Kit de productos por nivel', '', '01', 7, GETDATE(), NULL),
				('3', 'BENEFICIO07', 'Descuento en demostradores y catálogos', '', '01', 8, GETDATE(), NULL),
				('3', 'BENEFICIO08', 'Talleres', '', '01', 6, GETDATE(), NULL)


INSERT [dbo].[BeneficioCaminoBrillante] ([CodigoNivel], [CodigoBeneficio], [NombreBeneficio], [Descripcion], [UrlIcono], [Orden], [FechaRegistro], [FechaActualizacion]) 
		VALUES	('4', 'BENEFICIO01', '3 catálogos y Guía de Negocio L’Bel/Gana+', '', '04', 1, GETDATE(), NULL),								  
				('4', 'BENEFICIO02', 'Regalo por Pedido / Constancia (en campañas específicas)', '', '04', 2, GETDATE(), NULL),
				('4', 'BENEFICIO03', 'Call Center', '', '09', 3, GETDATE(), NULL),						 
				('4', 'BENEFICIO04', 'Reconocimiento', '', '03', 4, GETDATE(), NULL),										 
				('4', 'BENEFICIO05', 'Acompañamiento presencial y virtual', '', '01', 5, GETDATE(), NULL),
				('4', 'BENEFICIO06', 'Kit de productos por nivel', '', '01', 9, GETDATE(), NULL),
				('4', 'BENEFICIO07', 'Descuento en demostradores y catálogos', '', '01', 10, GETDATE(), NULL),
				('4', 'BENEFICIO08', 'Talleres', '', '01', 6, GETDATE(), NULL),
				('4', 'BENEFICIO09', 'Concurso de monto de pedido (en campañas específicas)', '', '01', 7, GETDATE(), NULL),
				('4', 'BENEFICIO10', 'Brazalete Camino Brillante', '', '01', 8, GETDATE(), NULL)


INSERT [dbo].[BeneficioCaminoBrillante] ([CodigoNivel], [CodigoBeneficio], [NombreBeneficio], [Descripcion], [UrlIcono], [Orden], [FechaRegistro], [FechaActualizacion]) 
		VALUES	('5', 'BENEFICIO01', '3 catálogos y Guía de Negocio L’Bel/Gana+', '', '04', 1, GETDATE(), NULL),								  
				('5', 'BENEFICIO02', 'Regalo por Pedido / Constancia (en campañas específicas)', '', '04', 2, GETDATE(), NULL),
				('5', 'BENEFICIO03', 'Call Center', '', '09', 3, GETDATE(), NULL),						 
				('5', 'BENEFICIO04', 'Reconocimiento', '', '03', 4, GETDATE(), NULL),										 
				('5', 'BENEFICIO05', 'Acompañamiento presencial y virtual', '', '01', 5, GETDATE(), NULL),
				('5', 'BENEFICIO06', 'Kit de productos por nivel', '', '01', 12, GETDATE(), NULL),
				('5', 'BENEFICIO07', 'Descuento en demostradores y catálogos', '', '01', 13, GETDATE(), NULL),
				('5', 'BENEFICIO08', 'Talleres', '', '01', 6, GETDATE(), NULL),
				('5', 'BENEFICIO09', 'Concurso de monto de pedido (en campañas específicas)', '', '01', 7, GETDATE(), NULL),
				('5', 'BENEFICIO10', 'Brazalete Camino Brillante', '', '01', 8, GETDATE(), NULL),
				('5', 'BENEFICIO11', 'Descuento en flete', '', '01', 9, GETDATE(), NULL),
				('5', 'BENEFICIO12', 'Pago diferido', '', '01', 10, GETDATE(), NULL),
				('5', 'BENEFICIO13', 'Programa Brillante', '', '01', 11, GETDATE(), NULL)


INSERT [dbo].[BeneficioCaminoBrillante] ([CodigoNivel], [CodigoBeneficio], [NombreBeneficio], [Descripcion], [UrlIcono], [Orden], [FechaRegistro], [FechaActualizacion]) 
		VALUES	('6', 'BENEFICIO01', '3 catálogos y Guía de Negocio L’Bel/Gana+', '', '04', 1, GETDATE(), NULL),								  
				('6', 'BENEFICIO02', 'Regalo por Pedido / Constancia (en campañas específicas)', '', '04', 2, GETDATE(), NULL),
				('6', 'BENEFICIO03', 'Call Center', '', '09', 3, GETDATE(), NULL),						 
				('6', 'BENEFICIO04', 'Reconocimiento', '', '03', 4, GETDATE(), NULL),										 
				('6', 'BENEFICIO05', 'Acompañamiento presencial y virtual', '', '01', 5, GETDATE(), NULL),
				('6', 'BENEFICIO06', 'Kit de productos por nivel', '', '01', 12, GETDATE(), NULL),
				('6', 'BENEFICIO07', 'Descuento en demostradores y catálogos', '', '01', 13, GETDATE(), NULL),
				('6', 'BENEFICIO08', 'Talleres', '', '01', 6, GETDATE(), NULL),
				('6', 'BENEFICIO09', 'Concurso de monto de pedido (en campañas específicas)', '', '01', 7, GETDATE(), NULL),
				('6', 'BENEFICIO10', 'Brazalete Camino Brillante', '', '01', 8, GETDATE(), NULL),
				('6', 'BENEFICIO11', 'Descuento en flete', '', '01', 9, GETDATE(), NULL),
				('6', 'BENEFICIO12', 'Pago diferido', '', '01', 10, GETDATE(), NULL),
				('6', 'BENEFICIO13', 'Programa Brillante', '', '01', 11, GETDATE(), NULL)


