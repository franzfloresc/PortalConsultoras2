GO
USE BelcorpPeru
GO
GO
IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1111401'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1111401', 'Desktop Landing Ganadoras Ganadoras Carrusel','1','Desktop','11','Landing Ganadoras',
		   '14','Ganadoras','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1111402'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1111402', 'Desktop Landing Ganadoras Ganadoras Ficha','1','Desktop','11','Landing Ganadoras',
		   '14','Ganadoras','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2111402'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2111402', 'Mobile Landing Ganadoras Ganadoras Ficha','2','Mobile','11','Landing Ganadoras',
		   '14','Ganadoras','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1081401'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1081401', 'Desktop Contenedor Ganadoras Carrusel','1','Desktop','08','Contenedor Ganadoras',
		   '14','Ganadoras','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1081402'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1081402', 'Desktop Contenedor Ganadoras Ficha','1','Desktop','08','Contenedor Ganadoras',
		   '14','Ganadoras','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2081402'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2081402', 'Mobile Contenedor Ganadoras Ficha',2,'Desktop','08','Contenedor Ganadoras',
		   '14','Ganadoras','02','Ficha');

GO

GO
USE BelcorpMexico
GO
GO
IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1111401'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1111401', 'Desktop Landing Ganadoras Ganadoras Carrusel','1','Desktop','11','Landing Ganadoras',
		   '14','Ganadoras','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1111402'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1111402', 'Desktop Landing Ganadoras Ganadoras Ficha','1','Desktop','11','Landing Ganadoras',
		   '14','Ganadoras','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2111402'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2111402', 'Mobile Landing Ganadoras Ganadoras Ficha','2','Mobile','11','Landing Ganadoras',
		   '14','Ganadoras','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1081401'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1081401', 'Desktop Contenedor Ganadoras Carrusel','1','Desktop','08','Contenedor Ganadoras',
		   '14','Ganadoras','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1081402'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1081402', 'Desktop Contenedor Ganadoras Ficha','1','Desktop','08','Contenedor Ganadoras',
		   '14','Ganadoras','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2081402'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2081402', 'Mobile Contenedor Ganadoras Ficha',2,'Desktop','08','Contenedor Ganadoras',
		   '14','Ganadoras','02','Ficha');

GO

GO
USE BelcorpColombia
GO
GO
IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1111401'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1111401', 'Desktop Landing Ganadoras Ganadoras Carrusel','1','Desktop','11','Landing Ganadoras',
		   '14','Ganadoras','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1111402'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1111402', 'Desktop Landing Ganadoras Ganadoras Ficha','1','Desktop','11','Landing Ganadoras',
		   '14','Ganadoras','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2111402'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2111402', 'Mobile Landing Ganadoras Ganadoras Ficha','2','Mobile','11','Landing Ganadoras',
		   '14','Ganadoras','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1081401'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1081401', 'Desktop Contenedor Ganadoras Carrusel','1','Desktop','08','Contenedor Ganadoras',
		   '14','Ganadoras','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1081402'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1081402', 'Desktop Contenedor Ganadoras Ficha','1','Desktop','08','Contenedor Ganadoras',
		   '14','Ganadoras','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2081402'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2081402', 'Mobile Contenedor Ganadoras Ficha',2,'Desktop','08','Contenedor Ganadoras',
		   '14','Ganadoras','02','Ficha');

GO

GO
USE BelcorpSalvador
GO
GO
IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1111401'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1111401', 'Desktop Landing Ganadoras Ganadoras Carrusel','1','Desktop','11','Landing Ganadoras',
		   '14','Ganadoras','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1111402'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1111402', 'Desktop Landing Ganadoras Ganadoras Ficha','1','Desktop','11','Landing Ganadoras',
		   '14','Ganadoras','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2111402'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2111402', 'Mobile Landing Ganadoras Ganadoras Ficha','2','Mobile','11','Landing Ganadoras',
		   '14','Ganadoras','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1081401'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1081401', 'Desktop Contenedor Ganadoras Carrusel','1','Desktop','08','Contenedor Ganadoras',
		   '14','Ganadoras','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1081402'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1081402', 'Desktop Contenedor Ganadoras Ficha','1','Desktop','08','Contenedor Ganadoras',
		   '14','Ganadoras','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2081402'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2081402', 'Mobile Contenedor Ganadoras Ficha',2,'Desktop','08','Contenedor Ganadoras',
		   '14','Ganadoras','02','Ficha');

GO

GO
USE BelcorpPuertoRico
GO
GO
IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1111401'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1111401', 'Desktop Landing Ganadoras Ganadoras Carrusel','1','Desktop','11','Landing Ganadoras',
		   '14','Ganadoras','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1111402'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1111402', 'Desktop Landing Ganadoras Ganadoras Ficha','1','Desktop','11','Landing Ganadoras',
		   '14','Ganadoras','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2111402'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2111402', 'Mobile Landing Ganadoras Ganadoras Ficha','2','Mobile','11','Landing Ganadoras',
		   '14','Ganadoras','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1081401'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1081401', 'Desktop Contenedor Ganadoras Carrusel','1','Desktop','08','Contenedor Ganadoras',
		   '14','Ganadoras','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1081402'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1081402', 'Desktop Contenedor Ganadoras Ficha','1','Desktop','08','Contenedor Ganadoras',
		   '14','Ganadoras','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2081402'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2081402', 'Mobile Contenedor Ganadoras Ficha',2,'Desktop','08','Contenedor Ganadoras',
		   '14','Ganadoras','02','Ficha');

GO

GO
USE BelcorpPanama
GO
GO
IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1111401'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1111401', 'Desktop Landing Ganadoras Ganadoras Carrusel','1','Desktop','11','Landing Ganadoras',
		   '14','Ganadoras','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1111402'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1111402', 'Desktop Landing Ganadoras Ganadoras Ficha','1','Desktop','11','Landing Ganadoras',
		   '14','Ganadoras','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2111402'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2111402', 'Mobile Landing Ganadoras Ganadoras Ficha','2','Mobile','11','Landing Ganadoras',
		   '14','Ganadoras','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1081401'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1081401', 'Desktop Contenedor Ganadoras Carrusel','1','Desktop','08','Contenedor Ganadoras',
		   '14','Ganadoras','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1081402'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1081402', 'Desktop Contenedor Ganadoras Ficha','1','Desktop','08','Contenedor Ganadoras',
		   '14','Ganadoras','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2081402'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2081402', 'Mobile Contenedor Ganadoras Ficha',2,'Desktop','08','Contenedor Ganadoras',
		   '14','Ganadoras','02','Ficha');

GO

GO
USE BelcorpGuatemala
GO
GO
IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1111401'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1111401', 'Desktop Landing Ganadoras Ganadoras Carrusel','1','Desktop','11','Landing Ganadoras',
		   '14','Ganadoras','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1111402'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1111402', 'Desktop Landing Ganadoras Ganadoras Ficha','1','Desktop','11','Landing Ganadoras',
		   '14','Ganadoras','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2111402'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2111402', 'Mobile Landing Ganadoras Ganadoras Ficha','2','Mobile','11','Landing Ganadoras',
		   '14','Ganadoras','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1081401'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1081401', 'Desktop Contenedor Ganadoras Carrusel','1','Desktop','08','Contenedor Ganadoras',
		   '14','Ganadoras','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1081402'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1081402', 'Desktop Contenedor Ganadoras Ficha','1','Desktop','08','Contenedor Ganadoras',
		   '14','Ganadoras','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2081402'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2081402', 'Mobile Contenedor Ganadoras Ficha',2,'Desktop','08','Contenedor Ganadoras',
		   '14','Ganadoras','02','Ficha');

GO

GO
USE BelcorpEcuador
GO
GO
IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1111401'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1111401', 'Desktop Landing Ganadoras Ganadoras Carrusel','1','Desktop','11','Landing Ganadoras',
		   '14','Ganadoras','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1111402'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1111402', 'Desktop Landing Ganadoras Ganadoras Ficha','1','Desktop','11','Landing Ganadoras',
		   '14','Ganadoras','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2111402'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2111402', 'Mobile Landing Ganadoras Ganadoras Ficha','2','Mobile','11','Landing Ganadoras',
		   '14','Ganadoras','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1081401'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1081401', 'Desktop Contenedor Ganadoras Carrusel','1','Desktop','08','Contenedor Ganadoras',
		   '14','Ganadoras','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1081402'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1081402', 'Desktop Contenedor Ganadoras Ficha','1','Desktop','08','Contenedor Ganadoras',
		   '14','Ganadoras','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2081402'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2081402', 'Mobile Contenedor Ganadoras Ficha',2,'Desktop','08','Contenedor Ganadoras',
		   '14','Ganadoras','02','Ficha');

GO

GO
USE BelcorpDominicana
GO
GO
IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1111401'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1111401', 'Desktop Landing Ganadoras Ganadoras Carrusel','1','Desktop','11','Landing Ganadoras',
		   '14','Ganadoras','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1111402'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1111402', 'Desktop Landing Ganadoras Ganadoras Ficha','1','Desktop','11','Landing Ganadoras',
		   '14','Ganadoras','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2111402'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2111402', 'Mobile Landing Ganadoras Ganadoras Ficha','2','Mobile','11','Landing Ganadoras',
		   '14','Ganadoras','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1081401'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1081401', 'Desktop Contenedor Ganadoras Carrusel','1','Desktop','08','Contenedor Ganadoras',
		   '14','Ganadoras','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1081402'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1081402', 'Desktop Contenedor Ganadoras Ficha','1','Desktop','08','Contenedor Ganadoras',
		   '14','Ganadoras','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2081402'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2081402', 'Mobile Contenedor Ganadoras Ficha',2,'Desktop','08','Contenedor Ganadoras',
		   '14','Ganadoras','02','Ficha');

GO

GO
USE BelcorpCostaRica
GO
GO
IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1111401'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1111401', 'Desktop Landing Ganadoras Ganadoras Carrusel','1','Desktop','11','Landing Ganadoras',
		   '14','Ganadoras','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1111402'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1111402', 'Desktop Landing Ganadoras Ganadoras Ficha','1','Desktop','11','Landing Ganadoras',
		   '14','Ganadoras','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2111402'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2111402', 'Mobile Landing Ganadoras Ganadoras Ficha','2','Mobile','11','Landing Ganadoras',
		   '14','Ganadoras','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1081401'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1081401', 'Desktop Contenedor Ganadoras Carrusel','1','Desktop','08','Contenedor Ganadoras',
		   '14','Ganadoras','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1081402'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1081402', 'Desktop Contenedor Ganadoras Ficha','1','Desktop','08','Contenedor Ganadoras',
		   '14','Ganadoras','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2081402'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2081402', 'Mobile Contenedor Ganadoras Ficha',2,'Desktop','08','Contenedor Ganadoras',
		   '14','Ganadoras','02','Ficha');

GO

GO
USE BelcorpChile
GO
GO
IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1111401'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1111401', 'Desktop Landing Ganadoras Ganadoras Carrusel','1','Desktop','11','Landing Ganadoras',
		   '14','Ganadoras','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1111402'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1111402', 'Desktop Landing Ganadoras Ganadoras Ficha','1','Desktop','11','Landing Ganadoras',
		   '14','Ganadoras','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2111402'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2111402', 'Mobile Landing Ganadoras Ganadoras Ficha','2','Mobile','11','Landing Ganadoras',
		   '14','Ganadoras','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1081401'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1081401', 'Desktop Contenedor Ganadoras Carrusel','1','Desktop','08','Contenedor Ganadoras',
		   '14','Ganadoras','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1081402'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1081402', 'Desktop Contenedor Ganadoras Ficha','1','Desktop','08','Contenedor Ganadoras',
		   '14','Ganadoras','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2081402'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2081402', 'Mobile Contenedor Ganadoras Ficha',2,'Desktop','08','Contenedor Ganadoras',
		   '14','Ganadoras','02','Ficha');

GO

GO
USE BelcorpBolivia
GO
GO
IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1111401'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1111401', 'Desktop Landing Ganadoras Ganadoras Carrusel','1','Desktop','11','Landing Ganadoras',
		   '14','Ganadoras','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1111402'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1111402', 'Desktop Landing Ganadoras Ganadoras Ficha','1','Desktop','11','Landing Ganadoras',
		   '14','Ganadoras','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2111402'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2111402', 'Mobile Landing Ganadoras Ganadoras Ficha','2','Mobile','11','Landing Ganadoras',
		   '14','Ganadoras','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1081401'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1081401', 'Desktop Contenedor Ganadoras Carrusel','1','Desktop','08','Contenedor Ganadoras',
		   '14','Ganadoras','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1081402'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1081402', 'Desktop Contenedor Ganadoras Ficha','1','Desktop','08','Contenedor Ganadoras',
		   '14','Ganadoras','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2081402'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2081402', 'Mobile Contenedor Ganadoras Ficha',2,'Desktop','08','Contenedor Ganadoras',
		   '14','Ganadoras','02','Ficha');

GO

GO
