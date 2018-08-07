USE BelcorpPeru
GO

DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 9
DELETE FROM TablaLogica Where TablaLogicaID = 9
GO
INSERT INTO TablaLogica Values (9, 'Facturacion Electronica') 
INSERT INTO TablaLogicaDatos Values (900, 9, '01','Mostrar link de facturacion electronica', '1') 
GO

USE BelcorpMexico
GO

DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 9
DELETE FROM TablaLogica Where TablaLogicaID = 9
GO
INSERT INTO TablaLogica Values (9, 'Facturacion Electronica') 
INSERT INTO TablaLogicaDatos Values (900, 9, '01','Mostrar link de facturacion electronica', '1'),
									(901, 9, '02', 'Direccion url','http://coappdev01/WS.Documento/Disponibilidad/Index?'),
									(902, 9, '03', 'Parametros','countryId={0}&accountCode={1}')
GO

USE BelcorpColombia
GO

DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 9
DELETE FROM TablaLogica Where TablaLogicaID = 9
GO
INSERT INTO TablaLogica Values (9, 'Facturacion Electronica') 
INSERT INTO TablaLogicaDatos Values (900, 9, '01', 'Mostrar link de facturacion electronica', '1'),
									(901, 9, '02', 'Direccion url','http://coappdev01/WS.Documento/Disponibilidad/Index?'),
									(902, 9, '03', 'Parametros, considerar el orden {paisISO},{DocumentoIdentidad}','countryId={0}&accountCode={1}')
GO

USE BelcorpSalvador
GO

DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 9
DELETE FROM TablaLogica Where TablaLogicaID = 9
GO
INSERT INTO TablaLogica Values (9, 'Facturacion Electronica') 
INSERT INTO TablaLogicaDatos Values (900, 9, '01','Mostrar link de facturacion electronica', '0') 
GO

USE BelcorpPuertoRico
GO

DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 9
DELETE FROM TablaLogica Where TablaLogicaID = 9
GO
INSERT INTO TablaLogica Values (9, 'Facturacion Electronica') 
INSERT INTO TablaLogicaDatos Values (900, 9, '01','Mostrar link de facturacion electronica', '0') 
GO

USE BelcorpPanama
GO

DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 9
DELETE FROM TablaLogica Where TablaLogicaID = 9
GO
INSERT INTO TablaLogica Values (9, 'Facturacion Electronica') 
INSERT INTO TablaLogicaDatos Values (900, 9, '01','Mostrar link de facturacion electronica', '0') 
GO

USE BelcorpGuatemala
GO

DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 9
DELETE FROM TablaLogica Where TablaLogicaID = 9
GO
INSERT INTO TablaLogica Values (9, 'Facturacion Electronica') 
INSERT INTO TablaLogicaDatos Values (900, 9, '01','Mostrar link de facturacion electronica', '1'),
									(901, 9, '02', 'Direccion url','http://coappdev01/WS.Documento/Disponibilidad/Index?'),
									(902, 9, '03', 'Parametros','countryId={0}&accountCode={1}')
GO

USE BelcorpEcuador
GO

DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 9
DELETE FROM TablaLogica Where TablaLogicaID = 9
GO
INSERT INTO TablaLogica Values (9, 'Facturacion Electronica') 
INSERT INTO TablaLogicaDatos Values (900, 9, '01','Mostrar link de facturacion electronica', '1') 
GO

USE BelcorpDominicana
GO

DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 9
DELETE FROM TablaLogica Where TablaLogicaID = 9
GO
INSERT INTO TablaLogica Values (9, 'Facturacion Electronica') 
INSERT INTO TablaLogicaDatos Values (900, 9, '01','Mostrar link de facturacion electronica', '0') 
GO

USE BelcorpCostaRica
GO

DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 9
DELETE FROM TablaLogica Where TablaLogicaID = 9
GO
INSERT INTO TablaLogica Values (9, 'Facturacion Electronica') 
INSERT INTO TablaLogicaDatos Values (900, 9, '01','Mostrar link de facturacion electronica', '1'),
									(901, 9, '02', 'Direccion url','http://coappdev01/WS.Documento/Disponibilidad/Index?'),
									(902, 9, '03', 'Parametros','countryId={0}&accountCode={1}')
							
GO

USE BelcorpChile
GO

DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 9
DELETE FROM TablaLogica Where TablaLogicaID = 9
GO
INSERT INTO TablaLogica Values (9, 'Facturacion Electronica') 
INSERT INTO TablaLogicaDatos Values (900, 9, '01','Mostrar link de facturacion electronica', '0') 
GO

USE BelcorpBolivia
GO

DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 9
DELETE FROM TablaLogica Where TablaLogicaID = 9
GO
INSERT INTO TablaLogica Values (9, 'Facturacion Electronica') 
INSERT INTO TablaLogicaDatos Values (900, 9, '01','Mostrar link de facturacion electronica', '0') 
GO
