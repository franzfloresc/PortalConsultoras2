USE BelcorpPeru
GO

DELETE [dbo].[TablaLogicaDatos] WHERE [TablaLogicaID] IN (165, 166, 167, 168);
DELETE [dbo].[TablaLogica] WHERE [TablaLogicaID] IN (165, 166, 167, 168);

INSERT INTO TablaLogica values (165, 'Datos Camino Brillante')
INSERT INTO [dbo].[TablaLogicaDatos] VALUES (16501, 165, 'url_inf_com', 'url de Informacion Comercial Services', ''),
							        (16502, 165, 'usu_inf_com', 'usuario', ''),
							        (16503, 165, 'cla_inf_com', 'clave', ''),
									(16504, 165, 'num_cam_per', 'Número de campanias a obtener en un Periodo', '6')

INSERT INTO [dbo].[TablaLogica] ([TablaLogicaID] ,[Descripcion]) VALUES ( 166, 'Camino Brillante - Logros'),
																		( 167, 'Camino Brillante - Indicadores'),
																		( 168, 'Camino Brillante - Ofertas')

INSERT INTO [dbo].[TablaLogicaDatos]([TablaLogicaDatosID] ,[TablaLogicaID] ,[Codigo] ,[Valor] ,[Descripcion])
	VALUES	(16601,166,'CRECIMIENTO','Crecimiento','Tu progreso tiene recompensas.'),
			(16602,166,'COMPROMISO','Compromiso','Tu progreso tiene recompensas.'),
			(16603,166,'RESUMEN','Mis logros','')


INSERT INTO [dbo].[TablaLogicaDatos]([TablaLogicaDatosID] ,[TablaLogicaID] ,[Codigo] ,[Valor] ,[Descripcion])
	VALUES	(16701,167,'ESCALA','Cambio de escala', ''),
			(16702,167,'NIVEL','Cambio de nivel', ''),
			(16703,167,'CONSTANCIA','Constancia', ''),
			(16704,167,'INCREMENTO_PEDIDO','Incremento en monto de pedidos', ''),
			(16705,167,'TIEMPO_JUNTOS','Tiempo juntos', ''),
			(16706,167,'PROGRAMA_NUEVAS','Programa de Nuevas', '')
	
	
INSERT INTO [dbo].[TablaLogicaDatos]([TablaLogicaDatosID] ,[TablaLogicaID] ,[Codigo] ,[Valor] ,[Descripcion])
	VALUES  (16800,168,'*','1', 'Valor por Defecto 1: Activo'),
			(16801,168,'1','0', 'Desactivar para el Nivel 1')
GO

USE BelcorpMexico
GO

DELETE [dbo].[TablaLogicaDatos] WHERE [TablaLogicaID] IN (165, 166, 167, 168);
DELETE [dbo].[TablaLogica] WHERE [TablaLogicaID] IN (165, 166, 167, 168);

INSERT INTO TablaLogica values (165, 'Datos Camino Brillante')
INSERT INTO [dbo].[TablaLogicaDatos] VALUES (16501, 165, 'url_inf_com', 'url de Informacion Comercial Services', ''),
							        (16502, 165, 'usu_inf_com', 'usuario', ''),
							        (16503, 165, 'cla_inf_com', 'clave', ''),
									(16504, 165, 'num_cam_per', 'Número de campanias a obtener en un Periodo', '6')

INSERT INTO [dbo].[TablaLogica] ([TablaLogicaID] ,[Descripcion]) VALUES ( 166, 'Camino Brillante - Logros'),
																		( 167, 'Camino Brillante - Indicadores'),
																		( 168, 'Camino Brillante - Ofertas')

INSERT INTO [dbo].[TablaLogicaDatos]([TablaLogicaDatosID] ,[TablaLogicaID] ,[Codigo] ,[Valor] ,[Descripcion])
	VALUES	(16601,166,'CRECIMIENTO','Crecimiento','Tu progreso tiene recompensas.'),
			(16602,166,'COMPROMISO','Compromiso','Tu progreso tiene recompensas.'),
			(16603,166,'RESUMEN','Mis logros','')


INSERT INTO [dbo].[TablaLogicaDatos]([TablaLogicaDatosID] ,[TablaLogicaID] ,[Codigo] ,[Valor] ,[Descripcion])
	VALUES	(16701,167,'ESCALA','Cambio de escala', ''),
			(16702,167,'NIVEL','Cambio de nivel', ''),
			(16703,167,'CONSTANCIA','Constancia', ''),
			(16704,167,'INCREMENTO_PEDIDO','Incremento en monto de pedidos', ''),
			(16705,167,'TIEMPO_JUNTOS','Tiempo juntos', ''),
			(16706,167,'PROGRAMA_NUEVAS','Programa de Nuevas', '')
	
	
INSERT INTO [dbo].[TablaLogicaDatos]([TablaLogicaDatosID] ,[TablaLogicaID] ,[Codigo] ,[Valor] ,[Descripcion])
	VALUES  (16800,168,'*','1', 'Valor por Defecto 1: Activo'),
			(16801,168,'1','0', 'Desactivar para el Nivel 1')
GO

USE BelcorpColombia
GO

DELETE [dbo].[TablaLogicaDatos] WHERE [TablaLogicaID] IN (165, 166, 167, 168);
DELETE [dbo].[TablaLogica] WHERE [TablaLogicaID] IN (165, 166, 167, 168);

INSERT INTO TablaLogica values (165, 'Datos Camino Brillante')
INSERT INTO [dbo].[TablaLogicaDatos] VALUES (16501, 165, 'url_inf_com', 'url de Informacion Comercial Services', ''),
							        (16502, 165, 'usu_inf_com', 'usuario', ''),
							        (16503, 165, 'cla_inf_com', 'clave', ''),
									(16504, 165, 'num_cam_per', 'Número de campanias a obtener en un Periodo', '6')

INSERT INTO [dbo].[TablaLogica] ([TablaLogicaID] ,[Descripcion]) VALUES ( 166, 'Camino Brillante - Logros'),
																		( 167, 'Camino Brillante - Indicadores'),
																		( 168, 'Camino Brillante - Ofertas')

INSERT INTO [dbo].[TablaLogicaDatos]([TablaLogicaDatosID] ,[TablaLogicaID] ,[Codigo] ,[Valor] ,[Descripcion])
	VALUES	(16601,166,'CRECIMIENTO','Crecimiento','Tu progreso tiene recompensas.'),
			(16602,166,'COMPROMISO','Compromiso','Tu progreso tiene recompensas.'),
			(16603,166,'RESUMEN','Mis logros','')


INSERT INTO [dbo].[TablaLogicaDatos]([TablaLogicaDatosID] ,[TablaLogicaID] ,[Codigo] ,[Valor] ,[Descripcion])
	VALUES	(16701,167,'ESCALA','Cambio de escala', ''),
			(16702,167,'NIVEL','Cambio de nivel', ''),
			(16703,167,'CONSTANCIA','Constancia', ''),
			(16704,167,'INCREMENTO_PEDIDO','Incremento en monto de pedidos', ''),
			(16705,167,'TIEMPO_JUNTOS','Tiempo juntos', ''),
			(16706,167,'PROGRAMA_NUEVAS','Programa de Nuevas', '')
	
	
INSERT INTO [dbo].[TablaLogicaDatos]([TablaLogicaDatosID] ,[TablaLogicaID] ,[Codigo] ,[Valor] ,[Descripcion])
	VALUES  (16800,168,'*','1', 'Valor por Defecto 1: Activo'),
			(16801,168,'1','0', 'Desactivar para el Nivel 1')
GO

USE BelcorpSalvador
GO

DELETE [dbo].[TablaLogicaDatos] WHERE [TablaLogicaID] IN (165, 166, 167, 168);
DELETE [dbo].[TablaLogica] WHERE [TablaLogicaID] IN (165, 166, 167, 168);

INSERT INTO TablaLogica values (165, 'Datos Camino Brillante')
INSERT INTO [dbo].[TablaLogicaDatos] VALUES (16501, 165, 'url_inf_com', 'url de Informacion Comercial Services', ''),
							        (16502, 165, 'usu_inf_com', 'usuario', ''),
							        (16503, 165, 'cla_inf_com', 'clave', ''),
									(16504, 165, 'num_cam_per', 'Número de campanias a obtener en un Periodo', '6')

INSERT INTO [dbo].[TablaLogica] ([TablaLogicaID] ,[Descripcion]) VALUES ( 166, 'Camino Brillante - Logros'),
																		( 167, 'Camino Brillante - Indicadores'),
																		( 168, 'Camino Brillante - Ofertas')

INSERT INTO [dbo].[TablaLogicaDatos]([TablaLogicaDatosID] ,[TablaLogicaID] ,[Codigo] ,[Valor] ,[Descripcion])
	VALUES	(16601,166,'CRECIMIENTO','Crecimiento','Tu progreso tiene recompensas.'),
			(16602,166,'COMPROMISO','Compromiso','Tu progreso tiene recompensas.'),
			(16603,166,'RESUMEN','Mis logros','')


INSERT INTO [dbo].[TablaLogicaDatos]([TablaLogicaDatosID] ,[TablaLogicaID] ,[Codigo] ,[Valor] ,[Descripcion])
	VALUES	(16701,167,'ESCALA','Cambio de escala', ''),
			(16702,167,'NIVEL','Cambio de nivel', ''),
			(16703,167,'CONSTANCIA','Constancia', ''),
			(16704,167,'INCREMENTO_PEDIDO','Incremento en monto de pedidos', ''),
			(16705,167,'TIEMPO_JUNTOS','Tiempo juntos', ''),
			(16706,167,'PROGRAMA_NUEVAS','Programa de Nuevas', '')
	
	
INSERT INTO [dbo].[TablaLogicaDatos]([TablaLogicaDatosID] ,[TablaLogicaID] ,[Codigo] ,[Valor] ,[Descripcion])
	VALUES  (16800,168,'*','1', 'Valor por Defecto 1: Activo'),
			(16801,168,'1','0', 'Desactivar para el Nivel 1')
GO

USE BelcorpPuertoRico
GO

DELETE [dbo].[TablaLogicaDatos] WHERE [TablaLogicaID] IN (165, 166, 167, 168);
DELETE [dbo].[TablaLogica] WHERE [TablaLogicaID] IN (165, 166, 167, 168);

INSERT INTO TablaLogica values (165, 'Datos Camino Brillante')
INSERT INTO [dbo].[TablaLogicaDatos] VALUES (16501, 165, 'url_inf_com', 'url de Informacion Comercial Services', ''),
							        (16502, 165, 'usu_inf_com', 'usuario', ''),
							        (16503, 165, 'cla_inf_com', 'clave', ''),
									(16504, 165, 'num_cam_per', 'Número de campanias a obtener en un Periodo', '6')

INSERT INTO [dbo].[TablaLogica] ([TablaLogicaID] ,[Descripcion]) VALUES ( 166, 'Camino Brillante - Logros'),
																		( 167, 'Camino Brillante - Indicadores'),
																		( 168, 'Camino Brillante - Ofertas')

INSERT INTO [dbo].[TablaLogicaDatos]([TablaLogicaDatosID] ,[TablaLogicaID] ,[Codigo] ,[Valor] ,[Descripcion])
	VALUES	(16601,166,'CRECIMIENTO','Crecimiento','Tu progreso tiene recompensas.'),
			(16602,166,'COMPROMISO','Compromiso','Tu progreso tiene recompensas.'),
			(16603,166,'RESUMEN','Mis logros','')


INSERT INTO [dbo].[TablaLogicaDatos]([TablaLogicaDatosID] ,[TablaLogicaID] ,[Codigo] ,[Valor] ,[Descripcion])
	VALUES	(16701,167,'ESCALA','Cambio de escala', ''),
			(16702,167,'NIVEL','Cambio de nivel', ''),
			(16703,167,'CONSTANCIA','Constancia', ''),
			(16704,167,'INCREMENTO_PEDIDO','Incremento en monto de pedidos', ''),
			(16705,167,'TIEMPO_JUNTOS','Tiempo juntos', ''),
			(16706,167,'PROGRAMA_NUEVAS','Programa de Nuevas', '')
	
	
INSERT INTO [dbo].[TablaLogicaDatos]([TablaLogicaDatosID] ,[TablaLogicaID] ,[Codigo] ,[Valor] ,[Descripcion])
	VALUES  (16800,168,'*','1', 'Valor por Defecto 1: Activo'),
			(16801,168,'1','0', 'Desactivar para el Nivel 1')
GO

USE BelcorpPanama
GO

DELETE [dbo].[TablaLogicaDatos] WHERE [TablaLogicaID] IN (165, 166, 167, 168);
DELETE [dbo].[TablaLogica] WHERE [TablaLogicaID] IN (165, 166, 167, 168);

INSERT INTO TablaLogica values (165, 'Datos Camino Brillante')
INSERT INTO [dbo].[TablaLogicaDatos] VALUES (16501, 165, 'url_inf_com', 'url de Informacion Comercial Services', ''),
							        (16502, 165, 'usu_inf_com', 'usuario', ''),
							        (16503, 165, 'cla_inf_com', 'clave', ''),
									(16504, 165, 'num_cam_per', 'Número de campanias a obtener en un Periodo', '6')

INSERT INTO [dbo].[TablaLogica] ([TablaLogicaID] ,[Descripcion]) VALUES ( 166, 'Camino Brillante - Logros'),
																		( 167, 'Camino Brillante - Indicadores'),
																		( 168, 'Camino Brillante - Ofertas')

INSERT INTO [dbo].[TablaLogicaDatos]([TablaLogicaDatosID] ,[TablaLogicaID] ,[Codigo] ,[Valor] ,[Descripcion])
	VALUES	(16601,166,'CRECIMIENTO','Crecimiento','Tu progreso tiene recompensas.'),
			(16602,166,'COMPROMISO','Compromiso','Tu progreso tiene recompensas.'),
			(16603,166,'RESUMEN','Mis logros','')


INSERT INTO [dbo].[TablaLogicaDatos]([TablaLogicaDatosID] ,[TablaLogicaID] ,[Codigo] ,[Valor] ,[Descripcion])
	VALUES	(16701,167,'ESCALA','Cambio de escala', ''),
			(16702,167,'NIVEL','Cambio de nivel', ''),
			(16703,167,'CONSTANCIA','Constancia', ''),
			(16704,167,'INCREMENTO_PEDIDO','Incremento en monto de pedidos', ''),
			(16705,167,'TIEMPO_JUNTOS','Tiempo juntos', ''),
			(16706,167,'PROGRAMA_NUEVAS','Programa de Nuevas', '')
	
	
INSERT INTO [dbo].[TablaLogicaDatos]([TablaLogicaDatosID] ,[TablaLogicaID] ,[Codigo] ,[Valor] ,[Descripcion])
	VALUES  (16800,168,'*','1', 'Valor por Defecto 1: Activo'),
			(16801,168,'1','0', 'Desactivar para el Nivel 1')
GO

USE BelcorpGuatemala
GO

DELETE [dbo].[TablaLogicaDatos] WHERE [TablaLogicaID] IN (165, 166, 167, 168);
DELETE [dbo].[TablaLogica] WHERE [TablaLogicaID] IN (165, 166, 167, 168);

INSERT INTO TablaLogica values (165, 'Datos Camino Brillante')
INSERT INTO [dbo].[TablaLogicaDatos] VALUES (16501, 165, 'url_inf_com', 'url de Informacion Comercial Services', ''),
							        (16502, 165, 'usu_inf_com', 'usuario', ''),
							        (16503, 165, 'cla_inf_com', 'clave', ''),
									(16504, 165, 'num_cam_per', 'Número de campanias a obtener en un Periodo', '6')

INSERT INTO [dbo].[TablaLogica] ([TablaLogicaID] ,[Descripcion]) VALUES ( 166, 'Camino Brillante - Logros'),
																		( 167, 'Camino Brillante - Indicadores'),
																		( 168, 'Camino Brillante - Ofertas')

INSERT INTO [dbo].[TablaLogicaDatos]([TablaLogicaDatosID] ,[TablaLogicaID] ,[Codigo] ,[Valor] ,[Descripcion])
	VALUES	(16601,166,'CRECIMIENTO','Crecimiento','Tu progreso tiene recompensas.'),
			(16602,166,'COMPROMISO','Compromiso','Tu progreso tiene recompensas.'),
			(16603,166,'RESUMEN','Mis logros','')


INSERT INTO [dbo].[TablaLogicaDatos]([TablaLogicaDatosID] ,[TablaLogicaID] ,[Codigo] ,[Valor] ,[Descripcion])
	VALUES	(16701,167,'ESCALA','Cambio de escala', ''),
			(16702,167,'NIVEL','Cambio de nivel', ''),
			(16703,167,'CONSTANCIA','Constancia', ''),
			(16704,167,'INCREMENTO_PEDIDO','Incremento en monto de pedidos', ''),
			(16705,167,'TIEMPO_JUNTOS','Tiempo juntos', ''),
			(16706,167,'PROGRAMA_NUEVAS','Programa de Nuevas', '')
	
	
INSERT INTO [dbo].[TablaLogicaDatos]([TablaLogicaDatosID] ,[TablaLogicaID] ,[Codigo] ,[Valor] ,[Descripcion])
	VALUES  (16800,168,'*','1', 'Valor por Defecto 1: Activo'),
			(16801,168,'1','0', 'Desactivar para el Nivel 1')
GO

USE BelcorpEcuador
GO

DELETE [dbo].[TablaLogicaDatos] WHERE [TablaLogicaID] IN (165, 166, 167, 168);
DELETE [dbo].[TablaLogica] WHERE [TablaLogicaID] IN (165, 166, 167, 168);

INSERT INTO TablaLogica values (165, 'Datos Camino Brillante')
INSERT INTO [dbo].[TablaLogicaDatos] VALUES (16501, 165, 'url_inf_com', 'url de Informacion Comercial Services', ''),
							        (16502, 165, 'usu_inf_com', 'usuario', ''),
							        (16503, 165, 'cla_inf_com', 'clave', ''),
									(16504, 165, 'num_cam_per', 'Número de campanias a obtener en un Periodo', '6')

INSERT INTO [dbo].[TablaLogica] ([TablaLogicaID] ,[Descripcion]) VALUES ( 166, 'Camino Brillante - Logros'),
																		( 167, 'Camino Brillante - Indicadores'),
																		( 168, 'Camino Brillante - Ofertas')

INSERT INTO [dbo].[TablaLogicaDatos]([TablaLogicaDatosID] ,[TablaLogicaID] ,[Codigo] ,[Valor] ,[Descripcion])
	VALUES	(16601,166,'CRECIMIENTO','Crecimiento','Tu progreso tiene recompensas.'),
			(16602,166,'COMPROMISO','Compromiso','Tu progreso tiene recompensas.'),
			(16603,166,'RESUMEN','Mis logros','')


INSERT INTO [dbo].[TablaLogicaDatos]([TablaLogicaDatosID] ,[TablaLogicaID] ,[Codigo] ,[Valor] ,[Descripcion])
	VALUES	(16701,167,'ESCALA','Cambio de escala', ''),
			(16702,167,'NIVEL','Cambio de nivel', ''),
			(16703,167,'CONSTANCIA','Constancia', ''),
			(16704,167,'INCREMENTO_PEDIDO','Incremento en monto de pedidos', ''),
			(16705,167,'TIEMPO_JUNTOS','Tiempo juntos', ''),
			(16706,167,'PROGRAMA_NUEVAS','Programa de Nuevas', '')
	
	
INSERT INTO [dbo].[TablaLogicaDatos]([TablaLogicaDatosID] ,[TablaLogicaID] ,[Codigo] ,[Valor] ,[Descripcion])
	VALUES  (16800,168,'*','1', 'Valor por Defecto 1: Activo'),
			(16801,168,'1','0', 'Desactivar para el Nivel 1')
GO

USE BelcorpDominicana
GO

DELETE [dbo].[TablaLogicaDatos] WHERE [TablaLogicaID] IN (165, 166, 167, 168);
DELETE [dbo].[TablaLogica] WHERE [TablaLogicaID] IN (165, 166, 167, 168);

INSERT INTO TablaLogica values (165, 'Datos Camino Brillante')
INSERT INTO [dbo].[TablaLogicaDatos] VALUES (16501, 165, 'url_inf_com', 'url de Informacion Comercial Services', ''),
							        (16502, 165, 'usu_inf_com', 'usuario', ''),
							        (16503, 165, 'cla_inf_com', 'clave', ''),
									(16504, 165, 'num_cam_per', 'Número de campanias a obtener en un Periodo', '6')

INSERT INTO [dbo].[TablaLogica] ([TablaLogicaID] ,[Descripcion]) VALUES ( 166, 'Camino Brillante - Logros'),
																		( 167, 'Camino Brillante - Indicadores'),
																		( 168, 'Camino Brillante - Ofertas')

INSERT INTO [dbo].[TablaLogicaDatos]([TablaLogicaDatosID] ,[TablaLogicaID] ,[Codigo] ,[Valor] ,[Descripcion])
	VALUES	(16601,166,'CRECIMIENTO','Crecimiento','Tu progreso tiene recompensas.'),
			(16602,166,'COMPROMISO','Compromiso','Tu progreso tiene recompensas.'),
			(16603,166,'RESUMEN','Mis logros','')


INSERT INTO [dbo].[TablaLogicaDatos]([TablaLogicaDatosID] ,[TablaLogicaID] ,[Codigo] ,[Valor] ,[Descripcion])
	VALUES	(16701,167,'ESCALA','Cambio de escala', ''),
			(16702,167,'NIVEL','Cambio de nivel', ''),
			(16703,167,'CONSTANCIA','Constancia', ''),
			(16704,167,'INCREMENTO_PEDIDO','Incremento en monto de pedidos', ''),
			(16705,167,'TIEMPO_JUNTOS','Tiempo juntos', ''),
			(16706,167,'PROGRAMA_NUEVAS','Programa de Nuevas', '')
	
	
INSERT INTO [dbo].[TablaLogicaDatos]([TablaLogicaDatosID] ,[TablaLogicaID] ,[Codigo] ,[Valor] ,[Descripcion])
	VALUES  (16800,168,'*','1', 'Valor por Defecto 1: Activo'),
			(16801,168,'1','0', 'Desactivar para el Nivel 1')
GO

USE BelcorpCostaRica
GO

DELETE [dbo].[TablaLogicaDatos] WHERE [TablaLogicaID] IN (165, 166, 167, 168);
DELETE [dbo].[TablaLogica] WHERE [TablaLogicaID] IN (165, 166, 167, 168);

INSERT INTO TablaLogica values (165, 'Datos Camino Brillante')
INSERT INTO [dbo].[TablaLogicaDatos] VALUES (16501, 165, 'url_inf_com', 'url de Informacion Comercial Services', ''),
							        (16502, 165, 'usu_inf_com', 'usuario', ''),
							        (16503, 165, 'cla_inf_com', 'clave', ''),
									(16504, 165, 'num_cam_per', 'Número de campanias a obtener en un Periodo', '6')

INSERT INTO [dbo].[TablaLogica] ([TablaLogicaID] ,[Descripcion]) VALUES ( 166, 'Camino Brillante - Logros'),
																		( 167, 'Camino Brillante - Indicadores'),
																		( 168, 'Camino Brillante - Ofertas')

INSERT INTO [dbo].[TablaLogicaDatos]([TablaLogicaDatosID] ,[TablaLogicaID] ,[Codigo] ,[Valor] ,[Descripcion])
	VALUES	(16601,166,'CRECIMIENTO','Crecimiento','Tu progreso tiene recompensas.'),
			(16602,166,'COMPROMISO','Compromiso','Tu progreso tiene recompensas.'),
			(16603,166,'RESUMEN','Mis logros','')


INSERT INTO [dbo].[TablaLogicaDatos]([TablaLogicaDatosID] ,[TablaLogicaID] ,[Codigo] ,[Valor] ,[Descripcion])
	VALUES	(16701,167,'ESCALA','Cambio de escala', ''),
			(16702,167,'NIVEL','Cambio de nivel', ''),
			(16703,167,'CONSTANCIA','Constancia', ''),
			(16704,167,'INCREMENTO_PEDIDO','Incremento en monto de pedidos', ''),
			(16705,167,'TIEMPO_JUNTOS','Tiempo juntos', ''),
			(16706,167,'PROGRAMA_NUEVAS','Programa de Nuevas', '')
	
	
INSERT INTO [dbo].[TablaLogicaDatos]([TablaLogicaDatosID] ,[TablaLogicaID] ,[Codigo] ,[Valor] ,[Descripcion])
	VALUES  (16800,168,'*','1', 'Valor por Defecto 1: Activo'),
			(16801,168,'1','0', 'Desactivar para el Nivel 1')
GO

USE BelcorpChile
GO

DELETE [dbo].[TablaLogicaDatos] WHERE [TablaLogicaID] IN (165, 166, 167, 168);
DELETE [dbo].[TablaLogica] WHERE [TablaLogicaID] IN (165, 166, 167, 168);

INSERT INTO TablaLogica values (165, 'Datos Camino Brillante')
INSERT INTO [dbo].[TablaLogicaDatos] VALUES (16501, 165, 'url_inf_com', 'url de Informacion Comercial Services', ''),
							        (16502, 165, 'usu_inf_com', 'usuario', ''),
							        (16503, 165, 'cla_inf_com', 'clave', ''),
									(16504, 165, 'num_cam_per', 'Número de campanias a obtener en un Periodo', '6')

INSERT INTO [dbo].[TablaLogica] ([TablaLogicaID] ,[Descripcion]) VALUES ( 166, 'Camino Brillante - Logros'),
																		( 167, 'Camino Brillante - Indicadores'),
																		( 168, 'Camino Brillante - Ofertas')

INSERT INTO [dbo].[TablaLogicaDatos]([TablaLogicaDatosID] ,[TablaLogicaID] ,[Codigo] ,[Valor] ,[Descripcion])
	VALUES	(16601,166,'CRECIMIENTO','Crecimiento','Tu progreso tiene recompensas.'),
			(16602,166,'COMPROMISO','Compromiso','Tu progreso tiene recompensas.'),
			(16603,166,'RESUMEN','Mis logros','')


INSERT INTO [dbo].[TablaLogicaDatos]([TablaLogicaDatosID] ,[TablaLogicaID] ,[Codigo] ,[Valor] ,[Descripcion])
	VALUES	(16701,167,'ESCALA','Cambio de escala', ''),
			(16702,167,'NIVEL','Cambio de nivel', ''),
			(16703,167,'CONSTANCIA','Constancia', ''),
			(16704,167,'INCREMENTO_PEDIDO','Incremento en monto de pedidos', ''),
			(16705,167,'TIEMPO_JUNTOS','Tiempo juntos', ''),
			(16706,167,'PROGRAMA_NUEVAS','Programa de Nuevas', '')
	
	
INSERT INTO [dbo].[TablaLogicaDatos]([TablaLogicaDatosID] ,[TablaLogicaID] ,[Codigo] ,[Valor] ,[Descripcion])
	VALUES  (16800,168,'*','1', 'Valor por Defecto 1: Activo'),
			(16801,168,'1','0', 'Desactivar para el Nivel 1')
GO

USE BelcorpBolivia
GO

DELETE [dbo].[TablaLogicaDatos] WHERE [TablaLogicaID] IN (165, 166, 167, 168);
DELETE [dbo].[TablaLogica] WHERE [TablaLogicaID] IN (165, 166, 167, 168);

INSERT INTO TablaLogica values (165, 'Datos Camino Brillante')
INSERT INTO [dbo].[TablaLogicaDatos] VALUES (16501, 165, 'url_inf_com', 'url de Informacion Comercial Services', ''),
							        (16502, 165, 'usu_inf_com', 'usuario', ''),
							        (16503, 165, 'cla_inf_com', 'clave', ''),
									(16504, 165, 'num_cam_per', 'Número de campanias a obtener en un Periodo', '6')

INSERT INTO [dbo].[TablaLogica] ([TablaLogicaID] ,[Descripcion]) VALUES ( 166, 'Camino Brillante - Logros'),
																		( 167, 'Camino Brillante - Indicadores'),
																		( 168, 'Camino Brillante - Ofertas')

INSERT INTO [dbo].[TablaLogicaDatos]([TablaLogicaDatosID] ,[TablaLogicaID] ,[Codigo] ,[Valor] ,[Descripcion])
	VALUES	(16601,166,'CRECIMIENTO','Crecimiento','Tu progreso tiene recompensas.'),
			(16602,166,'COMPROMISO','Compromiso','Tu progreso tiene recompensas.'),
			(16603,166,'RESUMEN','Mis logros','')


INSERT INTO [dbo].[TablaLogicaDatos]([TablaLogicaDatosID] ,[TablaLogicaID] ,[Codigo] ,[Valor] ,[Descripcion])
	VALUES	(16701,167,'ESCALA','Cambio de escala', ''),
			(16702,167,'NIVEL','Cambio de nivel', ''),
			(16703,167,'CONSTANCIA','Constancia', ''),
			(16704,167,'INCREMENTO_PEDIDO','Incremento en monto de pedidos', ''),
			(16705,167,'TIEMPO_JUNTOS','Tiempo juntos', ''),
			(16706,167,'PROGRAMA_NUEVAS','Programa de Nuevas', '')
	
	
INSERT INTO [dbo].[TablaLogicaDatos]([TablaLogicaDatosID] ,[TablaLogicaID] ,[Codigo] ,[Valor] ,[Descripcion])
	VALUES  (16800,168,'*','1', 'Valor por Defecto 1: Activo'),
			(16801,168,'1','0', 'Desactivar para el Nivel 1')
GO

