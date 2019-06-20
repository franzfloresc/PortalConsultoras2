USE [BelcorpBolivia];
GO
-- Duo Perfecto --
IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1141601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1141601', 'Desktop Landing Dúo Perfecto Carrusel','1','Desktop','14','Landing Dúo Perfecto',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1141602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1141602', 'Desktop Landing Dúo Perfecto Ficha','1','Desktop','14','Landing Dúo Perfecto',
		   '16','Dúo Perfecto','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1011601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1011601', 'Desktop Home Dúo Perfecto Carrusel','1','Desktop','01','Home',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1011602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1011602', 'Desktop Home Dúo Perfecto Ficha','1','Desktop','01','Home',
		   '16','Dúo Perfecto','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1021601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1021601', 'Desktop Pedido Dúo Perfecto Carrusel','1','Desktop','02','Pedido',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1021602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1021602', 'Desktop Pedido Dúo Perfecto Ficha','1','Desktop','02','Pedido',
		   '16','Dúo Perfecto','02','Ficha');


IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2141601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2141601', 'Mobile Landing Dúo Perfecto Carrusel','2','Mobile','14','Landing Dúo Perfecto',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2141602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2141602', 'Mobile Landing Dúo Perfecto Ficha','2','Mobile','14','Landing Dúo Perfecto',
		   '16','Dúo Perfecto','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2011601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2011601', 'Mobile Home Dúo Perfecto Carrusel','2','Mobile','01','Home',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2011602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2011602', 'Mobile Home Dúo Perfecto Ficha','2','Mobile','01','Home',
		   '16','Dúo Perfecto','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2021601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2021601', 'Mobile Pedido Dúo Perfecto Carrusel','2','Mobile','02','Pedido',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2021602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2021602', 'Mobile Pedido Dúo Perfecto Ficha','2','Mobile','02','Pedido',
		   '16','Dúo Perfecto','02','Ficha');


IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4141601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4141601', 'App Consultora Landing Dúo Perfecto Carrusel','4','App Consultora','14','Landing Dúo Perfecto',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4141602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4141602', 'App Consultora Landing Dúo Perfecto Ficha','4','App Consultora','14','Landing Dúo Perfecto',
		   '16','Dúo Perfecto','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4011601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4011601', 'App Consultora Home Dúo Perfecto Carrusel','4','App Consultora','01','Home',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4011602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4011602', 'App Consultora Home Dúo Perfecto Ficha','4','App Consultora','01','Home',
		   '16','Dúo Perfecto','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4021601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4021601', 'App Consultora Pedido Dúo Perfecto Carrusel','4','App Consultora','02','Pedido',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4021602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4021602', 'App Consultora Pedido Dúo Perfecto Ficha','4','App Consultora','02','Pedido',
		   '16','Dúo Perfecto','02','Ficha');

-- Pack Nuevas --

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1151701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1151701', 'Desktop Landing Pack de Nuevas Carrusel','1','Desktop','15','Landing Pack de Nuevas',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1151702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1151702', 'Desktop Landing Pack de Nuevas Ficha','1','Desktop','15','Landing Pack de Nuevas',
		   '17','Pack de Nuevas','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1011701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1011701', 'Desktop Home Pack de Nuevas Carrusel','1','Desktop','01','Home',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1011702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1011702', 'Desktop Home Pack de Nuevas Ficha','1','Desktop','01','Home',
		   '17','Pack de Nuevas','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1021701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1021701', 'Desktop Pedido Pack de Nuevas Carrusel','1','Desktop','02','Pedido',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1021702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1021702', 'Desktop Pedido Pack de Nuevas Ficha','1','Desktop','02','Pedido',
		   '17','Pack de Nuevas','02','Ficha');


IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2151701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2151701', 'Mobile Landing Pack de Nuevas Carrusel','2','Mobile','15','Landing Pack de Nuevas',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2151702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2151702', 'Mobile Landing Pack de Nuevas Ficha','2','Mobile','15','Landing Pack de Nuevas',
		   '17','Pack de Nuevas','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2011701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2011701', 'Mobile Home Pack de Nuevas Carrusel','2','Mobile','01','Home',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2011702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2011702', 'Mobile Home Pack de Nuevas Ficha','2','Mobile','01','Home',
		   '17','Pack de Nuevas','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2021701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2021701', 'Mobile Pedido Pack de Nuevas Carrusel','2','Mobile','02','Pedido',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2021702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2021702', 'Mobile Pedido Pack de Nuevas Ficha','2','Mobile','02','Pedido',
		   '17','Pack de Nuevas','02','Ficha');


IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4151701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4151701', 'App Consultora Landing Pack de Nuevas Carrusel','4','App Consultora','15','Landing Pack de Nuevas',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4151702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4151702', 'App Consultora Landing Pack de Nuevas Ficha','4','App Consultora','15','Landing Pack de Nuevas',
		   '17','Pack de Nuevas','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4011701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4011701', 'App Consultora Home Pack de Nuevas Carrusel','4','App Consultora','01','Home',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4011702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4011702', 'App Consultora Home Pack de Nuevas Ficha','4','App Consultora','01','Home',
		   '17','Pack de Nuevas','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4021701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4021701', 'App Consultora Pedido Pack de Nuevas Carrusel','4','App Consultora','02','Pedido',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4021702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4021702', 'App Consultora Pedido Pack de Nuevas Ficha','4','App Consultora','02','Pedido',
		   '17','Pack de Nuevas','02','Ficha');

GO
USE [BelcorpChile];
GO
-- Duo Perfecto --
IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1141601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1141601', 'Desktop Landing Dúo Perfecto Carrusel','1','Desktop','14','Landing Dúo Perfecto',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1141602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1141602', 'Desktop Landing Dúo Perfecto Ficha','1','Desktop','14','Landing Dúo Perfecto',
		   '16','Dúo Perfecto','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1011601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1011601', 'Desktop Home Dúo Perfecto Carrusel','1','Desktop','01','Home',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1011602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1011602', 'Desktop Home Dúo Perfecto Ficha','1','Desktop','01','Home',
		   '16','Dúo Perfecto','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1021601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1021601', 'Desktop Pedido Dúo Perfecto Carrusel','1','Desktop','02','Pedido',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1021602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1021602', 'Desktop Pedido Dúo Perfecto Ficha','1','Desktop','02','Pedido',
		   '16','Dúo Perfecto','02','Ficha');


IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2141601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2141601', 'Mobile Landing Dúo Perfecto Carrusel','2','Mobile','14','Landing Dúo Perfecto',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2141602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2141602', 'Mobile Landing Dúo Perfecto Ficha','2','Mobile','14','Landing Dúo Perfecto',
		   '16','Dúo Perfecto','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2011601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2011601', 'Mobile Home Dúo Perfecto Carrusel','2','Mobile','01','Home',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2011602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2011602', 'Mobile Home Dúo Perfecto Ficha','2','Mobile','01','Home',
		   '16','Dúo Perfecto','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2021601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2021601', 'Mobile Pedido Dúo Perfecto Carrusel','2','Mobile','02','Pedido',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2021602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2021602', 'Mobile Pedido Dúo Perfecto Ficha','2','Mobile','02','Pedido',
		   '16','Dúo Perfecto','02','Ficha');


IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4141601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4141601', 'App Consultora Landing Dúo Perfecto Carrusel','4','App Consultora','14','Landing Dúo Perfecto',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4141602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4141602', 'App Consultora Landing Dúo Perfecto Ficha','4','App Consultora','14','Landing Dúo Perfecto',
		   '16','Dúo Perfecto','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4011601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4011601', 'App Consultora Home Dúo Perfecto Carrusel','4','App Consultora','01','Home',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4011602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4011602', 'App Consultora Home Dúo Perfecto Ficha','4','App Consultora','01','Home',
		   '16','Dúo Perfecto','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4021601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4021601', 'App Consultora Pedido Dúo Perfecto Carrusel','4','App Consultora','02','Pedido',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4021602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4021602', 'App Consultora Pedido Dúo Perfecto Ficha','4','App Consultora','02','Pedido',
		   '16','Dúo Perfecto','02','Ficha');

-- Pack Nuevas --

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1151701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1151701', 'Desktop Landing Pack de Nuevas Carrusel','1','Desktop','15','Landing Pack de Nuevas',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1151702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1151702', 'Desktop Landing Pack de Nuevas Ficha','1','Desktop','15','Landing Pack de Nuevas',
		   '17','Pack de Nuevas','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1011701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1011701', 'Desktop Home Pack de Nuevas Carrusel','1','Desktop','01','Home',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1011702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1011702', 'Desktop Home Pack de Nuevas Ficha','1','Desktop','01','Home',
		   '17','Pack de Nuevas','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1021701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1021701', 'Desktop Pedido Pack de Nuevas Carrusel','1','Desktop','02','Pedido',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1021702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1021702', 'Desktop Pedido Pack de Nuevas Ficha','1','Desktop','02','Pedido',
		   '17','Pack de Nuevas','02','Ficha');


IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2151701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2151701', 'Mobile Landing Pack de Nuevas Carrusel','2','Mobile','15','Landing Pack de Nuevas',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2151702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2151702', 'Mobile Landing Pack de Nuevas Ficha','2','Mobile','15','Landing Pack de Nuevas',
		   '17','Pack de Nuevas','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2011701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2011701', 'Mobile Home Pack de Nuevas Carrusel','2','Mobile','01','Home',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2011702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2011702', 'Mobile Home Pack de Nuevas Ficha','2','Mobile','01','Home',
		   '17','Pack de Nuevas','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2021701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2021701', 'Mobile Pedido Pack de Nuevas Carrusel','2','Mobile','02','Pedido',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2021702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2021702', 'Mobile Pedido Pack de Nuevas Ficha','2','Mobile','02','Pedido',
		   '17','Pack de Nuevas','02','Ficha');


IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4151701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4151701', 'App Consultora Landing Pack de Nuevas Carrusel','4','App Consultora','15','Landing Pack de Nuevas',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4151702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4151702', 'App Consultora Landing Pack de Nuevas Ficha','4','App Consultora','15','Landing Pack de Nuevas',
		   '17','Pack de Nuevas','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4011701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4011701', 'App Consultora Home Pack de Nuevas Carrusel','4','App Consultora','01','Home',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4011702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4011702', 'App Consultora Home Pack de Nuevas Ficha','4','App Consultora','01','Home',
		   '17','Pack de Nuevas','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4021701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4021701', 'App Consultora Pedido Pack de Nuevas Carrusel','4','App Consultora','02','Pedido',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4021702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4021702', 'App Consultora Pedido Pack de Nuevas Ficha','4','App Consultora','02','Pedido',
		   '17','Pack de Nuevas','02','Ficha');

GO
USE [BelcorpColombia];
GO
-- Duo Perfecto --
IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1141601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1141601', 'Desktop Landing Dúo Perfecto Carrusel','1','Desktop','14','Landing Dúo Perfecto',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1141602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1141602', 'Desktop Landing Dúo Perfecto Ficha','1','Desktop','14','Landing Dúo Perfecto',
		   '16','Dúo Perfecto','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1011601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1011601', 'Desktop Home Dúo Perfecto Carrusel','1','Desktop','01','Home',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1011602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1011602', 'Desktop Home Dúo Perfecto Ficha','1','Desktop','01','Home',
		   '16','Dúo Perfecto','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1021601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1021601', 'Desktop Pedido Dúo Perfecto Carrusel','1','Desktop','02','Pedido',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1021602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1021602', 'Desktop Pedido Dúo Perfecto Ficha','1','Desktop','02','Pedido',
		   '16','Dúo Perfecto','02','Ficha');


IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2141601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2141601', 'Mobile Landing Dúo Perfecto Carrusel','2','Mobile','14','Landing Dúo Perfecto',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2141602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2141602', 'Mobile Landing Dúo Perfecto Ficha','2','Mobile','14','Landing Dúo Perfecto',
		   '16','Dúo Perfecto','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2011601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2011601', 'Mobile Home Dúo Perfecto Carrusel','2','Mobile','01','Home',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2011602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2011602', 'Mobile Home Dúo Perfecto Ficha','2','Mobile','01','Home',
		   '16','Dúo Perfecto','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2021601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2021601', 'Mobile Pedido Dúo Perfecto Carrusel','2','Mobile','02','Pedido',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2021602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2021602', 'Mobile Pedido Dúo Perfecto Ficha','2','Mobile','02','Pedido',
		   '16','Dúo Perfecto','02','Ficha');


IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4141601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4141601', 'App Consultora Landing Dúo Perfecto Carrusel','4','App Consultora','14','Landing Dúo Perfecto',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4141602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4141602', 'App Consultora Landing Dúo Perfecto Ficha','4','App Consultora','14','Landing Dúo Perfecto',
		   '16','Dúo Perfecto','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4011601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4011601', 'App Consultora Home Dúo Perfecto Carrusel','4','App Consultora','01','Home',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4011602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4011602', 'App Consultora Home Dúo Perfecto Ficha','4','App Consultora','01','Home',
		   '16','Dúo Perfecto','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4021601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4021601', 'App Consultora Pedido Dúo Perfecto Carrusel','4','App Consultora','02','Pedido',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4021602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4021602', 'App Consultora Pedido Dúo Perfecto Ficha','4','App Consultora','02','Pedido',
		   '16','Dúo Perfecto','02','Ficha');

-- Pack Nuevas --

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1151701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1151701', 'Desktop Landing Pack de Nuevas Carrusel','1','Desktop','15','Landing Pack de Nuevas',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1151702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1151702', 'Desktop Landing Pack de Nuevas Ficha','1','Desktop','15','Landing Pack de Nuevas',
		   '17','Pack de Nuevas','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1011701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1011701', 'Desktop Home Pack de Nuevas Carrusel','1','Desktop','01','Home',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1011702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1011702', 'Desktop Home Pack de Nuevas Ficha','1','Desktop','01','Home',
		   '17','Pack de Nuevas','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1021701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1021701', 'Desktop Pedido Pack de Nuevas Carrusel','1','Desktop','02','Pedido',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1021702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1021702', 'Desktop Pedido Pack de Nuevas Ficha','1','Desktop','02','Pedido',
		   '17','Pack de Nuevas','02','Ficha');


IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2151701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2151701', 'Mobile Landing Pack de Nuevas Carrusel','2','Mobile','15','Landing Pack de Nuevas',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2151702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2151702', 'Mobile Landing Pack de Nuevas Ficha','2','Mobile','15','Landing Pack de Nuevas',
		   '17','Pack de Nuevas','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2011701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2011701', 'Mobile Home Pack de Nuevas Carrusel','2','Mobile','01','Home',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2011702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2011702', 'Mobile Home Pack de Nuevas Ficha','2','Mobile','01','Home',
		   '17','Pack de Nuevas','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2021701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2021701', 'Mobile Pedido Pack de Nuevas Carrusel','2','Mobile','02','Pedido',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2021702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2021702', 'Mobile Pedido Pack de Nuevas Ficha','2','Mobile','02','Pedido',
		   '17','Pack de Nuevas','02','Ficha');


IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4151701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4151701', 'App Consultora Landing Pack de Nuevas Carrusel','4','App Consultora','15','Landing Pack de Nuevas',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4151702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4151702', 'App Consultora Landing Pack de Nuevas Ficha','4','App Consultora','15','Landing Pack de Nuevas',
		   '17','Pack de Nuevas','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4011701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4011701', 'App Consultora Home Pack de Nuevas Carrusel','4','App Consultora','01','Home',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4011702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4011702', 'App Consultora Home Pack de Nuevas Ficha','4','App Consultora','01','Home',
		   '17','Pack de Nuevas','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4021701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4021701', 'App Consultora Pedido Pack de Nuevas Carrusel','4','App Consultora','02','Pedido',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4021702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4021702', 'App Consultora Pedido Pack de Nuevas Ficha','4','App Consultora','02','Pedido',
		   '17','Pack de Nuevas','02','Ficha');

GO
USE [BelcorpCostaRica];
GO
-- Duo Perfecto --
IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1141601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1141601', 'Desktop Landing Dúo Perfecto Carrusel','1','Desktop','14','Landing Dúo Perfecto',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1141602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1141602', 'Desktop Landing Dúo Perfecto Ficha','1','Desktop','14','Landing Dúo Perfecto',
		   '16','Dúo Perfecto','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1011601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1011601', 'Desktop Home Dúo Perfecto Carrusel','1','Desktop','01','Home',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1011602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1011602', 'Desktop Home Dúo Perfecto Ficha','1','Desktop','01','Home',
		   '16','Dúo Perfecto','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1021601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1021601', 'Desktop Pedido Dúo Perfecto Carrusel','1','Desktop','02','Pedido',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1021602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1021602', 'Desktop Pedido Dúo Perfecto Ficha','1','Desktop','02','Pedido',
		   '16','Dúo Perfecto','02','Ficha');


IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2141601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2141601', 'Mobile Landing Dúo Perfecto Carrusel','2','Mobile','14','Landing Dúo Perfecto',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2141602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2141602', 'Mobile Landing Dúo Perfecto Ficha','2','Mobile','14','Landing Dúo Perfecto',
		   '16','Dúo Perfecto','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2011601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2011601', 'Mobile Home Dúo Perfecto Carrusel','2','Mobile','01','Home',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2011602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2011602', 'Mobile Home Dúo Perfecto Ficha','2','Mobile','01','Home',
		   '16','Dúo Perfecto','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2021601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2021601', 'Mobile Pedido Dúo Perfecto Carrusel','2','Mobile','02','Pedido',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2021602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2021602', 'Mobile Pedido Dúo Perfecto Ficha','2','Mobile','02','Pedido',
		   '16','Dúo Perfecto','02','Ficha');


IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4141601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4141601', 'App Consultora Landing Dúo Perfecto Carrusel','4','App Consultora','14','Landing Dúo Perfecto',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4141602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4141602', 'App Consultora Landing Dúo Perfecto Ficha','4','App Consultora','14','Landing Dúo Perfecto',
		   '16','Dúo Perfecto','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4011601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4011601', 'App Consultora Home Dúo Perfecto Carrusel','4','App Consultora','01','Home',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4011602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4011602', 'App Consultora Home Dúo Perfecto Ficha','4','App Consultora','01','Home',
		   '16','Dúo Perfecto','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4021601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4021601', 'App Consultora Pedido Dúo Perfecto Carrusel','4','App Consultora','02','Pedido',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4021602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4021602', 'App Consultora Pedido Dúo Perfecto Ficha','4','App Consultora','02','Pedido',
		   '16','Dúo Perfecto','02','Ficha');

-- Pack Nuevas --

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1151701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1151701', 'Desktop Landing Pack de Nuevas Carrusel','1','Desktop','15','Landing Pack de Nuevas',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1151702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1151702', 'Desktop Landing Pack de Nuevas Ficha','1','Desktop','15','Landing Pack de Nuevas',
		   '17','Pack de Nuevas','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1011701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1011701', 'Desktop Home Pack de Nuevas Carrusel','1','Desktop','01','Home',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1011702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1011702', 'Desktop Home Pack de Nuevas Ficha','1','Desktop','01','Home',
		   '17','Pack de Nuevas','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1021701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1021701', 'Desktop Pedido Pack de Nuevas Carrusel','1','Desktop','02','Pedido',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1021702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1021702', 'Desktop Pedido Pack de Nuevas Ficha','1','Desktop','02','Pedido',
		   '17','Pack de Nuevas','02','Ficha');


IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2151701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2151701', 'Mobile Landing Pack de Nuevas Carrusel','2','Mobile','15','Landing Pack de Nuevas',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2151702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2151702', 'Mobile Landing Pack de Nuevas Ficha','2','Mobile','15','Landing Pack de Nuevas',
		   '17','Pack de Nuevas','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2011701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2011701', 'Mobile Home Pack de Nuevas Carrusel','2','Mobile','01','Home',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2011702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2011702', 'Mobile Home Pack de Nuevas Ficha','2','Mobile','01','Home',
		   '17','Pack de Nuevas','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2021701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2021701', 'Mobile Pedido Pack de Nuevas Carrusel','2','Mobile','02','Pedido',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2021702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2021702', 'Mobile Pedido Pack de Nuevas Ficha','2','Mobile','02','Pedido',
		   '17','Pack de Nuevas','02','Ficha');


IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4151701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4151701', 'App Consultora Landing Pack de Nuevas Carrusel','4','App Consultora','15','Landing Pack de Nuevas',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4151702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4151702', 'App Consultora Landing Pack de Nuevas Ficha','4','App Consultora','15','Landing Pack de Nuevas',
		   '17','Pack de Nuevas','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4011701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4011701', 'App Consultora Home Pack de Nuevas Carrusel','4','App Consultora','01','Home',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4011702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4011702', 'App Consultora Home Pack de Nuevas Ficha','4','App Consultora','01','Home',
		   '17','Pack de Nuevas','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4021701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4021701', 'App Consultora Pedido Pack de Nuevas Carrusel','4','App Consultora','02','Pedido',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4021702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4021702', 'App Consultora Pedido Pack de Nuevas Ficha','4','App Consultora','02','Pedido',
		   '17','Pack de Nuevas','02','Ficha');

GO
USE [BelcorpDominicana];
GO
-- Duo Perfecto --
IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1141601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1141601', 'Desktop Landing Dúo Perfecto Carrusel','1','Desktop','14','Landing Dúo Perfecto',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1141602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1141602', 'Desktop Landing Dúo Perfecto Ficha','1','Desktop','14','Landing Dúo Perfecto',
		   '16','Dúo Perfecto','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1011601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1011601', 'Desktop Home Dúo Perfecto Carrusel','1','Desktop','01','Home',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1011602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1011602', 'Desktop Home Dúo Perfecto Ficha','1','Desktop','01','Home',
		   '16','Dúo Perfecto','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1021601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1021601', 'Desktop Pedido Dúo Perfecto Carrusel','1','Desktop','02','Pedido',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1021602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1021602', 'Desktop Pedido Dúo Perfecto Ficha','1','Desktop','02','Pedido',
		   '16','Dúo Perfecto','02','Ficha');


IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2141601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2141601', 'Mobile Landing Dúo Perfecto Carrusel','2','Mobile','14','Landing Dúo Perfecto',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2141602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2141602', 'Mobile Landing Dúo Perfecto Ficha','2','Mobile','14','Landing Dúo Perfecto',
		   '16','Dúo Perfecto','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2011601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2011601', 'Mobile Home Dúo Perfecto Carrusel','2','Mobile','01','Home',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2011602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2011602', 'Mobile Home Dúo Perfecto Ficha','2','Mobile','01','Home',
		   '16','Dúo Perfecto','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2021601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2021601', 'Mobile Pedido Dúo Perfecto Carrusel','2','Mobile','02','Pedido',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2021602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2021602', 'Mobile Pedido Dúo Perfecto Ficha','2','Mobile','02','Pedido',
		   '16','Dúo Perfecto','02','Ficha');


IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4141601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4141601', 'App Consultora Landing Dúo Perfecto Carrusel','4','App Consultora','14','Landing Dúo Perfecto',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4141602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4141602', 'App Consultora Landing Dúo Perfecto Ficha','4','App Consultora','14','Landing Dúo Perfecto',
		   '16','Dúo Perfecto','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4011601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4011601', 'App Consultora Home Dúo Perfecto Carrusel','4','App Consultora','01','Home',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4011602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4011602', 'App Consultora Home Dúo Perfecto Ficha','4','App Consultora','01','Home',
		   '16','Dúo Perfecto','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4021601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4021601', 'App Consultora Pedido Dúo Perfecto Carrusel','4','App Consultora','02','Pedido',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4021602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4021602', 'App Consultora Pedido Dúo Perfecto Ficha','4','App Consultora','02','Pedido',
		   '16','Dúo Perfecto','02','Ficha');

-- Pack Nuevas --

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1151701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1151701', 'Desktop Landing Pack de Nuevas Carrusel','1','Desktop','15','Landing Pack de Nuevas',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1151702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1151702', 'Desktop Landing Pack de Nuevas Ficha','1','Desktop','15','Landing Pack de Nuevas',
		   '17','Pack de Nuevas','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1011701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1011701', 'Desktop Home Pack de Nuevas Carrusel','1','Desktop','01','Home',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1011702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1011702', 'Desktop Home Pack de Nuevas Ficha','1','Desktop','01','Home',
		   '17','Pack de Nuevas','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1021701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1021701', 'Desktop Pedido Pack de Nuevas Carrusel','1','Desktop','02','Pedido',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1021702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1021702', 'Desktop Pedido Pack de Nuevas Ficha','1','Desktop','02','Pedido',
		   '17','Pack de Nuevas','02','Ficha');


IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2151701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2151701', 'Mobile Landing Pack de Nuevas Carrusel','2','Mobile','15','Landing Pack de Nuevas',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2151702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2151702', 'Mobile Landing Pack de Nuevas Ficha','2','Mobile','15','Landing Pack de Nuevas',
		   '17','Pack de Nuevas','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2011701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2011701', 'Mobile Home Pack de Nuevas Carrusel','2','Mobile','01','Home',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2011702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2011702', 'Mobile Home Pack de Nuevas Ficha','2','Mobile','01','Home',
		   '17','Pack de Nuevas','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2021701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2021701', 'Mobile Pedido Pack de Nuevas Carrusel','2','Mobile','02','Pedido',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2021702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2021702', 'Mobile Pedido Pack de Nuevas Ficha','2','Mobile','02','Pedido',
		   '17','Pack de Nuevas','02','Ficha');


IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4151701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4151701', 'App Consultora Landing Pack de Nuevas Carrusel','4','App Consultora','15','Landing Pack de Nuevas',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4151702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4151702', 'App Consultora Landing Pack de Nuevas Ficha','4','App Consultora','15','Landing Pack de Nuevas',
		   '17','Pack de Nuevas','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4011701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4011701', 'App Consultora Home Pack de Nuevas Carrusel','4','App Consultora','01','Home',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4011702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4011702', 'App Consultora Home Pack de Nuevas Ficha','4','App Consultora','01','Home',
		   '17','Pack de Nuevas','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4021701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4021701', 'App Consultora Pedido Pack de Nuevas Carrusel','4','App Consultora','02','Pedido',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4021702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4021702', 'App Consultora Pedido Pack de Nuevas Ficha','4','App Consultora','02','Pedido',
		   '17','Pack de Nuevas','02','Ficha');

GO
USE [BelcorpEcuador];
GO
-- Duo Perfecto --
IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1141601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1141601', 'Desktop Landing Dúo Perfecto Carrusel','1','Desktop','14','Landing Dúo Perfecto',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1141602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1141602', 'Desktop Landing Dúo Perfecto Ficha','1','Desktop','14','Landing Dúo Perfecto',
		   '16','Dúo Perfecto','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1011601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1011601', 'Desktop Home Dúo Perfecto Carrusel','1','Desktop','01','Home',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1011602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1011602', 'Desktop Home Dúo Perfecto Ficha','1','Desktop','01','Home',
		   '16','Dúo Perfecto','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1021601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1021601', 'Desktop Pedido Dúo Perfecto Carrusel','1','Desktop','02','Pedido',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1021602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1021602', 'Desktop Pedido Dúo Perfecto Ficha','1','Desktop','02','Pedido',
		   '16','Dúo Perfecto','02','Ficha');


IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2141601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2141601', 'Mobile Landing Dúo Perfecto Carrusel','2','Mobile','14','Landing Dúo Perfecto',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2141602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2141602', 'Mobile Landing Dúo Perfecto Ficha','2','Mobile','14','Landing Dúo Perfecto',
		   '16','Dúo Perfecto','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2011601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2011601', 'Mobile Home Dúo Perfecto Carrusel','2','Mobile','01','Home',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2011602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2011602', 'Mobile Home Dúo Perfecto Ficha','2','Mobile','01','Home',
		   '16','Dúo Perfecto','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2021601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2021601', 'Mobile Pedido Dúo Perfecto Carrusel','2','Mobile','02','Pedido',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2021602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2021602', 'Mobile Pedido Dúo Perfecto Ficha','2','Mobile','02','Pedido',
		   '16','Dúo Perfecto','02','Ficha');


IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4141601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4141601', 'App Consultora Landing Dúo Perfecto Carrusel','4','App Consultora','14','Landing Dúo Perfecto',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4141602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4141602', 'App Consultora Landing Dúo Perfecto Ficha','4','App Consultora','14','Landing Dúo Perfecto',
		   '16','Dúo Perfecto','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4011601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4011601', 'App Consultora Home Dúo Perfecto Carrusel','4','App Consultora','01','Home',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4011602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4011602', 'App Consultora Home Dúo Perfecto Ficha','4','App Consultora','01','Home',
		   '16','Dúo Perfecto','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4021601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4021601', 'App Consultora Pedido Dúo Perfecto Carrusel','4','App Consultora','02','Pedido',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4021602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4021602', 'App Consultora Pedido Dúo Perfecto Ficha','4','App Consultora','02','Pedido',
		   '16','Dúo Perfecto','02','Ficha');

-- Pack Nuevas --

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1151701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1151701', 'Desktop Landing Pack de Nuevas Carrusel','1','Desktop','15','Landing Pack de Nuevas',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1151702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1151702', 'Desktop Landing Pack de Nuevas Ficha','1','Desktop','15','Landing Pack de Nuevas',
		   '17','Pack de Nuevas','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1011701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1011701', 'Desktop Home Pack de Nuevas Carrusel','1','Desktop','01','Home',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1011702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1011702', 'Desktop Home Pack de Nuevas Ficha','1','Desktop','01','Home',
		   '17','Pack de Nuevas','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1021701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1021701', 'Desktop Pedido Pack de Nuevas Carrusel','1','Desktop','02','Pedido',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1021702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1021702', 'Desktop Pedido Pack de Nuevas Ficha','1','Desktop','02','Pedido',
		   '17','Pack de Nuevas','02','Ficha');


IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2151701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2151701', 'Mobile Landing Pack de Nuevas Carrusel','2','Mobile','15','Landing Pack de Nuevas',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2151702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2151702', 'Mobile Landing Pack de Nuevas Ficha','2','Mobile','15','Landing Pack de Nuevas',
		   '17','Pack de Nuevas','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2011701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2011701', 'Mobile Home Pack de Nuevas Carrusel','2','Mobile','01','Home',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2011702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2011702', 'Mobile Home Pack de Nuevas Ficha','2','Mobile','01','Home',
		   '17','Pack de Nuevas','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2021701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2021701', 'Mobile Pedido Pack de Nuevas Carrusel','2','Mobile','02','Pedido',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2021702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2021702', 'Mobile Pedido Pack de Nuevas Ficha','2','Mobile','02','Pedido',
		   '17','Pack de Nuevas','02','Ficha');


IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4151701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4151701', 'App Consultora Landing Pack de Nuevas Carrusel','4','App Consultora','15','Landing Pack de Nuevas',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4151702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4151702', 'App Consultora Landing Pack de Nuevas Ficha','4','App Consultora','15','Landing Pack de Nuevas',
		   '17','Pack de Nuevas','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4011701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4011701', 'App Consultora Home Pack de Nuevas Carrusel','4','App Consultora','01','Home',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4011702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4011702', 'App Consultora Home Pack de Nuevas Ficha','4','App Consultora','01','Home',
		   '17','Pack de Nuevas','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4021701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4021701', 'App Consultora Pedido Pack de Nuevas Carrusel','4','App Consultora','02','Pedido',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4021702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4021702', 'App Consultora Pedido Pack de Nuevas Ficha','4','App Consultora','02','Pedido',
		   '17','Pack de Nuevas','02','Ficha');

GO
USE [BelcorpGuatemala];
GO
-- Duo Perfecto --
IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1141601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1141601', 'Desktop Landing Dúo Perfecto Carrusel','1','Desktop','14','Landing Dúo Perfecto',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1141602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1141602', 'Desktop Landing Dúo Perfecto Ficha','1','Desktop','14','Landing Dúo Perfecto',
		   '16','Dúo Perfecto','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1011601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1011601', 'Desktop Home Dúo Perfecto Carrusel','1','Desktop','01','Home',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1011602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1011602', 'Desktop Home Dúo Perfecto Ficha','1','Desktop','01','Home',
		   '16','Dúo Perfecto','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1021601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1021601', 'Desktop Pedido Dúo Perfecto Carrusel','1','Desktop','02','Pedido',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1021602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1021602', 'Desktop Pedido Dúo Perfecto Ficha','1','Desktop','02','Pedido',
		   '16','Dúo Perfecto','02','Ficha');


IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2141601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2141601', 'Mobile Landing Dúo Perfecto Carrusel','2','Mobile','14','Landing Dúo Perfecto',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2141602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2141602', 'Mobile Landing Dúo Perfecto Ficha','2','Mobile','14','Landing Dúo Perfecto',
		   '16','Dúo Perfecto','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2011601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2011601', 'Mobile Home Dúo Perfecto Carrusel','2','Mobile','01','Home',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2011602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2011602', 'Mobile Home Dúo Perfecto Ficha','2','Mobile','01','Home',
		   '16','Dúo Perfecto','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2021601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2021601', 'Mobile Pedido Dúo Perfecto Carrusel','2','Mobile','02','Pedido',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2021602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2021602', 'Mobile Pedido Dúo Perfecto Ficha','2','Mobile','02','Pedido',
		   '16','Dúo Perfecto','02','Ficha');


IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4141601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4141601', 'App Consultora Landing Dúo Perfecto Carrusel','4','App Consultora','14','Landing Dúo Perfecto',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4141602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4141602', 'App Consultora Landing Dúo Perfecto Ficha','4','App Consultora','14','Landing Dúo Perfecto',
		   '16','Dúo Perfecto','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4011601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4011601', 'App Consultora Home Dúo Perfecto Carrusel','4','App Consultora','01','Home',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4011602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4011602', 'App Consultora Home Dúo Perfecto Ficha','4','App Consultora','01','Home',
		   '16','Dúo Perfecto','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4021601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4021601', 'App Consultora Pedido Dúo Perfecto Carrusel','4','App Consultora','02','Pedido',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4021602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4021602', 'App Consultora Pedido Dúo Perfecto Ficha','4','App Consultora','02','Pedido',
		   '16','Dúo Perfecto','02','Ficha');

-- Pack Nuevas --

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1151701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1151701', 'Desktop Landing Pack de Nuevas Carrusel','1','Desktop','15','Landing Pack de Nuevas',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1151702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1151702', 'Desktop Landing Pack de Nuevas Ficha','1','Desktop','15','Landing Pack de Nuevas',
		   '17','Pack de Nuevas','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1011701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1011701', 'Desktop Home Pack de Nuevas Carrusel','1','Desktop','01','Home',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1011702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1011702', 'Desktop Home Pack de Nuevas Ficha','1','Desktop','01','Home',
		   '17','Pack de Nuevas','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1021701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1021701', 'Desktop Pedido Pack de Nuevas Carrusel','1','Desktop','02','Pedido',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1021702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1021702', 'Desktop Pedido Pack de Nuevas Ficha','1','Desktop','02','Pedido',
		   '17','Pack de Nuevas','02','Ficha');


IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2151701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2151701', 'Mobile Landing Pack de Nuevas Carrusel','2','Mobile','15','Landing Pack de Nuevas',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2151702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2151702', 'Mobile Landing Pack de Nuevas Ficha','2','Mobile','15','Landing Pack de Nuevas',
		   '17','Pack de Nuevas','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2011701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2011701', 'Mobile Home Pack de Nuevas Carrusel','2','Mobile','01','Home',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2011702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2011702', 'Mobile Home Pack de Nuevas Ficha','2','Mobile','01','Home',
		   '17','Pack de Nuevas','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2021701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2021701', 'Mobile Pedido Pack de Nuevas Carrusel','2','Mobile','02','Pedido',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2021702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2021702', 'Mobile Pedido Pack de Nuevas Ficha','2','Mobile','02','Pedido',
		   '17','Pack de Nuevas','02','Ficha');


IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4151701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4151701', 'App Consultora Landing Pack de Nuevas Carrusel','4','App Consultora','15','Landing Pack de Nuevas',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4151702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4151702', 'App Consultora Landing Pack de Nuevas Ficha','4','App Consultora','15','Landing Pack de Nuevas',
		   '17','Pack de Nuevas','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4011701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4011701', 'App Consultora Home Pack de Nuevas Carrusel','4','App Consultora','01','Home',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4011702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4011702', 'App Consultora Home Pack de Nuevas Ficha','4','App Consultora','01','Home',
		   '17','Pack de Nuevas','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4021701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4021701', 'App Consultora Pedido Pack de Nuevas Carrusel','4','App Consultora','02','Pedido',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4021702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4021702', 'App Consultora Pedido Pack de Nuevas Ficha','4','App Consultora','02','Pedido',
		   '17','Pack de Nuevas','02','Ficha');

GO
USE [BelcorpMexico];
GO
-- Duo Perfecto --
IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1141601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1141601', 'Desktop Landing Dúo Perfecto Carrusel','1','Desktop','14','Landing Dúo Perfecto',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1141602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1141602', 'Desktop Landing Dúo Perfecto Ficha','1','Desktop','14','Landing Dúo Perfecto',
		   '16','Dúo Perfecto','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1011601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1011601', 'Desktop Home Dúo Perfecto Carrusel','1','Desktop','01','Home',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1011602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1011602', 'Desktop Home Dúo Perfecto Ficha','1','Desktop','01','Home',
		   '16','Dúo Perfecto','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1021601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1021601', 'Desktop Pedido Dúo Perfecto Carrusel','1','Desktop','02','Pedido',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1021602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1021602', 'Desktop Pedido Dúo Perfecto Ficha','1','Desktop','02','Pedido',
		   '16','Dúo Perfecto','02','Ficha');


IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2141601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2141601', 'Mobile Landing Dúo Perfecto Carrusel','2','Mobile','14','Landing Dúo Perfecto',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2141602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2141602', 'Mobile Landing Dúo Perfecto Ficha','2','Mobile','14','Landing Dúo Perfecto',
		   '16','Dúo Perfecto','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2011601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2011601', 'Mobile Home Dúo Perfecto Carrusel','2','Mobile','01','Home',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2011602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2011602', 'Mobile Home Dúo Perfecto Ficha','2','Mobile','01','Home',
		   '16','Dúo Perfecto','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2021601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2021601', 'Mobile Pedido Dúo Perfecto Carrusel','2','Mobile','02','Pedido',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2021602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2021602', 'Mobile Pedido Dúo Perfecto Ficha','2','Mobile','02','Pedido',
		   '16','Dúo Perfecto','02','Ficha');


IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4141601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4141601', 'App Consultora Landing Dúo Perfecto Carrusel','4','App Consultora','14','Landing Dúo Perfecto',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4141602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4141602', 'App Consultora Landing Dúo Perfecto Ficha','4','App Consultora','14','Landing Dúo Perfecto',
		   '16','Dúo Perfecto','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4011601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4011601', 'App Consultora Home Dúo Perfecto Carrusel','4','App Consultora','01','Home',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4011602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4011602', 'App Consultora Home Dúo Perfecto Ficha','4','App Consultora','01','Home',
		   '16','Dúo Perfecto','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4021601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4021601', 'App Consultora Pedido Dúo Perfecto Carrusel','4','App Consultora','02','Pedido',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4021602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4021602', 'App Consultora Pedido Dúo Perfecto Ficha','4','App Consultora','02','Pedido',
		   '16','Dúo Perfecto','02','Ficha');

-- Pack Nuevas --

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1151701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1151701', 'Desktop Landing Pack de Nuevas Carrusel','1','Desktop','15','Landing Pack de Nuevas',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1151702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1151702', 'Desktop Landing Pack de Nuevas Ficha','1','Desktop','15','Landing Pack de Nuevas',
		   '17','Pack de Nuevas','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1011701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1011701', 'Desktop Home Pack de Nuevas Carrusel','1','Desktop','01','Home',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1011702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1011702', 'Desktop Home Pack de Nuevas Ficha','1','Desktop','01','Home',
		   '17','Pack de Nuevas','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1021701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1021701', 'Desktop Pedido Pack de Nuevas Carrusel','1','Desktop','02','Pedido',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1021702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1021702', 'Desktop Pedido Pack de Nuevas Ficha','1','Desktop','02','Pedido',
		   '17','Pack de Nuevas','02','Ficha');


IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2151701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2151701', 'Mobile Landing Pack de Nuevas Carrusel','2','Mobile','15','Landing Pack de Nuevas',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2151702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2151702', 'Mobile Landing Pack de Nuevas Ficha','2','Mobile','15','Landing Pack de Nuevas',
		   '17','Pack de Nuevas','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2011701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2011701', 'Mobile Home Pack de Nuevas Carrusel','2','Mobile','01','Home',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2011702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2011702', 'Mobile Home Pack de Nuevas Ficha','2','Mobile','01','Home',
		   '17','Pack de Nuevas','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2021701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2021701', 'Mobile Pedido Pack de Nuevas Carrusel','2','Mobile','02','Pedido',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2021702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2021702', 'Mobile Pedido Pack de Nuevas Ficha','2','Mobile','02','Pedido',
		   '17','Pack de Nuevas','02','Ficha');


IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4151701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4151701', 'App Consultora Landing Pack de Nuevas Carrusel','4','App Consultora','15','Landing Pack de Nuevas',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4151702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4151702', 'App Consultora Landing Pack de Nuevas Ficha','4','App Consultora','15','Landing Pack de Nuevas',
		   '17','Pack de Nuevas','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4011701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4011701', 'App Consultora Home Pack de Nuevas Carrusel','4','App Consultora','01','Home',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4011702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4011702', 'App Consultora Home Pack de Nuevas Ficha','4','App Consultora','01','Home',
		   '17','Pack de Nuevas','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4021701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4021701', 'App Consultora Pedido Pack de Nuevas Carrusel','4','App Consultora','02','Pedido',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4021702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4021702', 'App Consultora Pedido Pack de Nuevas Ficha','4','App Consultora','02','Pedido',
		   '17','Pack de Nuevas','02','Ficha');

GO
USE [BelcorpPanama];
GO
-- Duo Perfecto --
IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1141601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1141601', 'Desktop Landing Dúo Perfecto Carrusel','1','Desktop','14','Landing Dúo Perfecto',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1141602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1141602', 'Desktop Landing Dúo Perfecto Ficha','1','Desktop','14','Landing Dúo Perfecto',
		   '16','Dúo Perfecto','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1011601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1011601', 'Desktop Home Dúo Perfecto Carrusel','1','Desktop','01','Home',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1011602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1011602', 'Desktop Home Dúo Perfecto Ficha','1','Desktop','01','Home',
		   '16','Dúo Perfecto','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1021601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1021601', 'Desktop Pedido Dúo Perfecto Carrusel','1','Desktop','02','Pedido',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1021602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1021602', 'Desktop Pedido Dúo Perfecto Ficha','1','Desktop','02','Pedido',
		   '16','Dúo Perfecto','02','Ficha');


IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2141601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2141601', 'Mobile Landing Dúo Perfecto Carrusel','2','Mobile','14','Landing Dúo Perfecto',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2141602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2141602', 'Mobile Landing Dúo Perfecto Ficha','2','Mobile','14','Landing Dúo Perfecto',
		   '16','Dúo Perfecto','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2011601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2011601', 'Mobile Home Dúo Perfecto Carrusel','2','Mobile','01','Home',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2011602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2011602', 'Mobile Home Dúo Perfecto Ficha','2','Mobile','01','Home',
		   '16','Dúo Perfecto','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2021601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2021601', 'Mobile Pedido Dúo Perfecto Carrusel','2','Mobile','02','Pedido',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2021602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2021602', 'Mobile Pedido Dúo Perfecto Ficha','2','Mobile','02','Pedido',
		   '16','Dúo Perfecto','02','Ficha');


IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4141601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4141601', 'App Consultora Landing Dúo Perfecto Carrusel','4','App Consultora','14','Landing Dúo Perfecto',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4141602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4141602', 'App Consultora Landing Dúo Perfecto Ficha','4','App Consultora','14','Landing Dúo Perfecto',
		   '16','Dúo Perfecto','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4011601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4011601', 'App Consultora Home Dúo Perfecto Carrusel','4','App Consultora','01','Home',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4011602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4011602', 'App Consultora Home Dúo Perfecto Ficha','4','App Consultora','01','Home',
		   '16','Dúo Perfecto','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4021601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4021601', 'App Consultora Pedido Dúo Perfecto Carrusel','4','App Consultora','02','Pedido',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4021602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4021602', 'App Consultora Pedido Dúo Perfecto Ficha','4','App Consultora','02','Pedido',
		   '16','Dúo Perfecto','02','Ficha');

-- Pack Nuevas --

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1151701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1151701', 'Desktop Landing Pack de Nuevas Carrusel','1','Desktop','15','Landing Pack de Nuevas',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1151702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1151702', 'Desktop Landing Pack de Nuevas Ficha','1','Desktop','15','Landing Pack de Nuevas',
		   '17','Pack de Nuevas','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1011701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1011701', 'Desktop Home Pack de Nuevas Carrusel','1','Desktop','01','Home',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1011702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1011702', 'Desktop Home Pack de Nuevas Ficha','1','Desktop','01','Home',
		   '17','Pack de Nuevas','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1021701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1021701', 'Desktop Pedido Pack de Nuevas Carrusel','1','Desktop','02','Pedido',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1021702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1021702', 'Desktop Pedido Pack de Nuevas Ficha','1','Desktop','02','Pedido',
		   '17','Pack de Nuevas','02','Ficha');


IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2151701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2151701', 'Mobile Landing Pack de Nuevas Carrusel','2','Mobile','15','Landing Pack de Nuevas',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2151702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2151702', 'Mobile Landing Pack de Nuevas Ficha','2','Mobile','15','Landing Pack de Nuevas',
		   '17','Pack de Nuevas','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2011701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2011701', 'Mobile Home Pack de Nuevas Carrusel','2','Mobile','01','Home',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2011702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2011702', 'Mobile Home Pack de Nuevas Ficha','2','Mobile','01','Home',
		   '17','Pack de Nuevas','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2021701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2021701', 'Mobile Pedido Pack de Nuevas Carrusel','2','Mobile','02','Pedido',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2021702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2021702', 'Mobile Pedido Pack de Nuevas Ficha','2','Mobile','02','Pedido',
		   '17','Pack de Nuevas','02','Ficha');


IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4151701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4151701', 'App Consultora Landing Pack de Nuevas Carrusel','4','App Consultora','15','Landing Pack de Nuevas',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4151702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4151702', 'App Consultora Landing Pack de Nuevas Ficha','4','App Consultora','15','Landing Pack de Nuevas',
		   '17','Pack de Nuevas','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4011701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4011701', 'App Consultora Home Pack de Nuevas Carrusel','4','App Consultora','01','Home',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4011702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4011702', 'App Consultora Home Pack de Nuevas Ficha','4','App Consultora','01','Home',
		   '17','Pack de Nuevas','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4021701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4021701', 'App Consultora Pedido Pack de Nuevas Carrusel','4','App Consultora','02','Pedido',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4021702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4021702', 'App Consultora Pedido Pack de Nuevas Ficha','4','App Consultora','02','Pedido',
		   '17','Pack de Nuevas','02','Ficha');

GO
USE [BelcorpPeru];
GO
-- Duo Perfecto --
IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1141601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1141601', 'Desktop Landing Dúo Perfecto Carrusel','1','Desktop','14','Landing Dúo Perfecto',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1141602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1141602', 'Desktop Landing Dúo Perfecto Ficha','1','Desktop','14','Landing Dúo Perfecto',
		   '16','Dúo Perfecto','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1011601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1011601', 'Desktop Home Dúo Perfecto Carrusel','1','Desktop','01','Home',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1011602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1011602', 'Desktop Home Dúo Perfecto Ficha','1','Desktop','01','Home',
		   '16','Dúo Perfecto','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1021601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1021601', 'Desktop Pedido Dúo Perfecto Carrusel','1','Desktop','02','Pedido',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1021602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1021602', 'Desktop Pedido Dúo Perfecto Ficha','1','Desktop','02','Pedido',
		   '16','Dúo Perfecto','02','Ficha');


IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2141601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2141601', 'Mobile Landing Dúo Perfecto Carrusel','2','Mobile','14','Landing Dúo Perfecto',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2141602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2141602', 'Mobile Landing Dúo Perfecto Ficha','2','Mobile','14','Landing Dúo Perfecto',
		   '16','Dúo Perfecto','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2011601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2011601', 'Mobile Home Dúo Perfecto Carrusel','2','Mobile','01','Home',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2011602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2011602', 'Mobile Home Dúo Perfecto Ficha','2','Mobile','01','Home',
		   '16','Dúo Perfecto','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2021601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2021601', 'Mobile Pedido Dúo Perfecto Carrusel','2','Mobile','02','Pedido',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2021602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2021602', 'Mobile Pedido Dúo Perfecto Ficha','2','Mobile','02','Pedido',
		   '16','Dúo Perfecto','02','Ficha');


IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4141601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4141601', 'App Consultora Landing Dúo Perfecto Carrusel','4','App Consultora','14','Landing Dúo Perfecto',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4141602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4141602', 'App Consultora Landing Dúo Perfecto Ficha','4','App Consultora','14','Landing Dúo Perfecto',
		   '16','Dúo Perfecto','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4011601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4011601', 'App Consultora Home Dúo Perfecto Carrusel','4','App Consultora','01','Home',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4011602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4011602', 'App Consultora Home Dúo Perfecto Ficha','4','App Consultora','01','Home',
		   '16','Dúo Perfecto','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4021601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4021601', 'App Consultora Pedido Dúo Perfecto Carrusel','4','App Consultora','02','Pedido',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4021602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4021602', 'App Consultora Pedido Dúo Perfecto Ficha','4','App Consultora','02','Pedido',
		   '16','Dúo Perfecto','02','Ficha');

-- Pack Nuevas --

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1151701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1151701', 'Desktop Landing Pack de Nuevas Carrusel','1','Desktop','15','Landing Pack de Nuevas',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1151702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1151702', 'Desktop Landing Pack de Nuevas Ficha','1','Desktop','15','Landing Pack de Nuevas',
		   '17','Pack de Nuevas','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1011701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1011701', 'Desktop Home Pack de Nuevas Carrusel','1','Desktop','01','Home',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1011702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1011702', 'Desktop Home Pack de Nuevas Ficha','1','Desktop','01','Home',
		   '17','Pack de Nuevas','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1021701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1021701', 'Desktop Pedido Pack de Nuevas Carrusel','1','Desktop','02','Pedido',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1021702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1021702', 'Desktop Pedido Pack de Nuevas Ficha','1','Desktop','02','Pedido',
		   '17','Pack de Nuevas','02','Ficha');


IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2151701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2151701', 'Mobile Landing Pack de Nuevas Carrusel','2','Mobile','15','Landing Pack de Nuevas',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2151702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2151702', 'Mobile Landing Pack de Nuevas Ficha','2','Mobile','15','Landing Pack de Nuevas',
		   '17','Pack de Nuevas','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2011701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2011701', 'Mobile Home Pack de Nuevas Carrusel','2','Mobile','01','Home',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2011702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2011702', 'Mobile Home Pack de Nuevas Ficha','2','Mobile','01','Home',
		   '17','Pack de Nuevas','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2021701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2021701', 'Mobile Pedido Pack de Nuevas Carrusel','2','Mobile','02','Pedido',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2021702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2021702', 'Mobile Pedido Pack de Nuevas Ficha','2','Mobile','02','Pedido',
		   '17','Pack de Nuevas','02','Ficha');


IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4151701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4151701', 'App Consultora Landing Pack de Nuevas Carrusel','4','App Consultora','15','Landing Pack de Nuevas',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4151702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4151702', 'App Consultora Landing Pack de Nuevas Ficha','4','App Consultora','15','Landing Pack de Nuevas',
		   '17','Pack de Nuevas','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4011701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4011701', 'App Consultora Home Pack de Nuevas Carrusel','4','App Consultora','01','Home',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4011702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4011702', 'App Consultora Home Pack de Nuevas Ficha','4','App Consultora','01','Home',
		   '17','Pack de Nuevas','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4021701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4021701', 'App Consultora Pedido Pack de Nuevas Carrusel','4','App Consultora','02','Pedido',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4021702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4021702', 'App Consultora Pedido Pack de Nuevas Ficha','4','App Consultora','02','Pedido',
		   '17','Pack de Nuevas','02','Ficha');

GO
USE [BelcorpPuertoRico];
GO
-- Duo Perfecto --
IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1141601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1141601', 'Desktop Landing Dúo Perfecto Carrusel','1','Desktop','14','Landing Dúo Perfecto',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1141602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1141602', 'Desktop Landing Dúo Perfecto Ficha','1','Desktop','14','Landing Dúo Perfecto',
		   '16','Dúo Perfecto','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1011601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1011601', 'Desktop Home Dúo Perfecto Carrusel','1','Desktop','01','Home',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1011602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1011602', 'Desktop Home Dúo Perfecto Ficha','1','Desktop','01','Home',
		   '16','Dúo Perfecto','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1021601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1021601', 'Desktop Pedido Dúo Perfecto Carrusel','1','Desktop','02','Pedido',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1021602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1021602', 'Desktop Pedido Dúo Perfecto Ficha','1','Desktop','02','Pedido',
		   '16','Dúo Perfecto','02','Ficha');


IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2141601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2141601', 'Mobile Landing Dúo Perfecto Carrusel','2','Mobile','14','Landing Dúo Perfecto',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2141602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2141602', 'Mobile Landing Dúo Perfecto Ficha','2','Mobile','14','Landing Dúo Perfecto',
		   '16','Dúo Perfecto','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2011601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2011601', 'Mobile Home Dúo Perfecto Carrusel','2','Mobile','01','Home',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2011602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2011602', 'Mobile Home Dúo Perfecto Ficha','2','Mobile','01','Home',
		   '16','Dúo Perfecto','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2021601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2021601', 'Mobile Pedido Dúo Perfecto Carrusel','2','Mobile','02','Pedido',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2021602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2021602', 'Mobile Pedido Dúo Perfecto Ficha','2','Mobile','02','Pedido',
		   '16','Dúo Perfecto','02','Ficha');


IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4141601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4141601', 'App Consultora Landing Dúo Perfecto Carrusel','4','App Consultora','14','Landing Dúo Perfecto',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4141602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4141602', 'App Consultora Landing Dúo Perfecto Ficha','4','App Consultora','14','Landing Dúo Perfecto',
		   '16','Dúo Perfecto','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4011601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4011601', 'App Consultora Home Dúo Perfecto Carrusel','4','App Consultora','01','Home',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4011602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4011602', 'App Consultora Home Dúo Perfecto Ficha','4','App Consultora','01','Home',
		   '16','Dúo Perfecto','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4021601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4021601', 'App Consultora Pedido Dúo Perfecto Carrusel','4','App Consultora','02','Pedido',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4021602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4021602', 'App Consultora Pedido Dúo Perfecto Ficha','4','App Consultora','02','Pedido',
		   '16','Dúo Perfecto','02','Ficha');

-- Pack Nuevas --

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1151701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1151701', 'Desktop Landing Pack de Nuevas Carrusel','1','Desktop','15','Landing Pack de Nuevas',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1151702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1151702', 'Desktop Landing Pack de Nuevas Ficha','1','Desktop','15','Landing Pack de Nuevas',
		   '17','Pack de Nuevas','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1011701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1011701', 'Desktop Home Pack de Nuevas Carrusel','1','Desktop','01','Home',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1011702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1011702', 'Desktop Home Pack de Nuevas Ficha','1','Desktop','01','Home',
		   '17','Pack de Nuevas','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1021701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1021701', 'Desktop Pedido Pack de Nuevas Carrusel','1','Desktop','02','Pedido',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1021702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1021702', 'Desktop Pedido Pack de Nuevas Ficha','1','Desktop','02','Pedido',
		   '17','Pack de Nuevas','02','Ficha');


IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2151701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2151701', 'Mobile Landing Pack de Nuevas Carrusel','2','Mobile','15','Landing Pack de Nuevas',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2151702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2151702', 'Mobile Landing Pack de Nuevas Ficha','2','Mobile','15','Landing Pack de Nuevas',
		   '17','Pack de Nuevas','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2011701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2011701', 'Mobile Home Pack de Nuevas Carrusel','2','Mobile','01','Home',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2011702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2011702', 'Mobile Home Pack de Nuevas Ficha','2','Mobile','01','Home',
		   '17','Pack de Nuevas','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2021701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2021701', 'Mobile Pedido Pack de Nuevas Carrusel','2','Mobile','02','Pedido',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2021702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2021702', 'Mobile Pedido Pack de Nuevas Ficha','2','Mobile','02','Pedido',
		   '17','Pack de Nuevas','02','Ficha');


IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4151701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4151701', 'App Consultora Landing Pack de Nuevas Carrusel','4','App Consultora','15','Landing Pack de Nuevas',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4151702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4151702', 'App Consultora Landing Pack de Nuevas Ficha','4','App Consultora','15','Landing Pack de Nuevas',
		   '17','Pack de Nuevas','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4011701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4011701', 'App Consultora Home Pack de Nuevas Carrusel','4','App Consultora','01','Home',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4011702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4011702', 'App Consultora Home Pack de Nuevas Ficha','4','App Consultora','01','Home',
		   '17','Pack de Nuevas','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4021701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4021701', 'App Consultora Pedido Pack de Nuevas Carrusel','4','App Consultora','02','Pedido',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4021702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4021702', 'App Consultora Pedido Pack de Nuevas Ficha','4','App Consultora','02','Pedido',
		   '17','Pack de Nuevas','02','Ficha');

GO
USE [BelcorpSalvador];
GO
-- Duo Perfecto --
IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1141601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1141601', 'Desktop Landing Dúo Perfecto Carrusel','1','Desktop','14','Landing Dúo Perfecto',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1141602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1141602', 'Desktop Landing Dúo Perfecto Ficha','1','Desktop','14','Landing Dúo Perfecto',
		   '16','Dúo Perfecto','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1011601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1011601', 'Desktop Home Dúo Perfecto Carrusel','1','Desktop','01','Home',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1011602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1011602', 'Desktop Home Dúo Perfecto Ficha','1','Desktop','01','Home',
		   '16','Dúo Perfecto','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1021601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1021601', 'Desktop Pedido Dúo Perfecto Carrusel','1','Desktop','02','Pedido',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1021602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1021602', 'Desktop Pedido Dúo Perfecto Ficha','1','Desktop','02','Pedido',
		   '16','Dúo Perfecto','02','Ficha');


IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2141601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2141601', 'Mobile Landing Dúo Perfecto Carrusel','2','Mobile','14','Landing Dúo Perfecto',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2141602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2141602', 'Mobile Landing Dúo Perfecto Ficha','2','Mobile','14','Landing Dúo Perfecto',
		   '16','Dúo Perfecto','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2011601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2011601', 'Mobile Home Dúo Perfecto Carrusel','2','Mobile','01','Home',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2011602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2011602', 'Mobile Home Dúo Perfecto Ficha','2','Mobile','01','Home',
		   '16','Dúo Perfecto','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2021601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2021601', 'Mobile Pedido Dúo Perfecto Carrusel','2','Mobile','02','Pedido',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2021602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2021602', 'Mobile Pedido Dúo Perfecto Ficha','2','Mobile','02','Pedido',
		   '16','Dúo Perfecto','02','Ficha');


IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4141601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4141601', 'App Consultora Landing Dúo Perfecto Carrusel','4','App Consultora','14','Landing Dúo Perfecto',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4141602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4141602', 'App Consultora Landing Dúo Perfecto Ficha','4','App Consultora','14','Landing Dúo Perfecto',
		   '16','Dúo Perfecto','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4011601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4011601', 'App Consultora Home Dúo Perfecto Carrusel','4','App Consultora','01','Home',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4011602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4011602', 'App Consultora Home Dúo Perfecto Ficha','4','App Consultora','01','Home',
		   '16','Dúo Perfecto','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4021601'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4021601', 'App Consultora Pedido Dúo Perfecto Carrusel','4','App Consultora','02','Pedido',
		   '16','Dúo Perfecto','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4021602'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4021602', 'App Consultora Pedido Dúo Perfecto Ficha','4','App Consultora','02','Pedido',
		   '16','Dúo Perfecto','02','Ficha');

-- Pack Nuevas --

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1151701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1151701', 'Desktop Landing Pack de Nuevas Carrusel','1','Desktop','15','Landing Pack de Nuevas',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1151702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1151702', 'Desktop Landing Pack de Nuevas Ficha','1','Desktop','15','Landing Pack de Nuevas',
		   '17','Pack de Nuevas','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1011701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1011701', 'Desktop Home Pack de Nuevas Carrusel','1','Desktop','01','Home',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1011702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1011702', 'Desktop Home Pack de Nuevas Ficha','1','Desktop','01','Home',
		   '17','Pack de Nuevas','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1021701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1021701', 'Desktop Pedido Pack de Nuevas Carrusel','1','Desktop','02','Pedido',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '1021702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('1021702', 'Desktop Pedido Pack de Nuevas Ficha','1','Desktop','02','Pedido',
		   '17','Pack de Nuevas','02','Ficha');


IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2151701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2151701', 'Mobile Landing Pack de Nuevas Carrusel','2','Mobile','15','Landing Pack de Nuevas',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2151702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2151702', 'Mobile Landing Pack de Nuevas Ficha','2','Mobile','15','Landing Pack de Nuevas',
		   '17','Pack de Nuevas','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2011701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2011701', 'Mobile Home Pack de Nuevas Carrusel','2','Mobile','01','Home',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2011702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2011702', 'Mobile Home Pack de Nuevas Ficha','2','Mobile','01','Home',
		   '17','Pack de Nuevas','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2021701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2021701', 'Mobile Pedido Pack de Nuevas Carrusel','2','Mobile','02','Pedido',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '2021702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('2021702', 'Mobile Pedido Pack de Nuevas Ficha','2','Mobile','02','Pedido',
		   '17','Pack de Nuevas','02','Ficha');


IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4151701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4151701', 'App Consultora Landing Pack de Nuevas Carrusel','4','App Consultora','15','Landing Pack de Nuevas',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4151702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4151702', 'App Consultora Landing Pack de Nuevas Ficha','4','App Consultora','15','Landing Pack de Nuevas',
		   '17','Pack de Nuevas','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4011701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4011701', 'App Consultora Home Pack de Nuevas Carrusel','4','App Consultora','01','Home',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4011702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4011702', 'App Consultora Home Pack de Nuevas Ficha','4','App Consultora','01','Home',
		   '17','Pack de Nuevas','02','Ficha');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4021701'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
							 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4021701', 'App Consultora Pedido Pack de Nuevas Carrusel','4','App Consultora','02','Pedido',
		   '17','Pack de Nuevas','01','Carrusel');

IF(NOT EXISTS(SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb = '4021702'))
	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona,
								 CodSeccion, DesSeccion, CodPopup, DesPopup)
	VALUES ('4021702', 'App Consultora Pedido Pack de Nuevas Ficha','4','App Consultora','02','Pedido',
		   '17','Pack de Nuevas','02','Ficha');

GO
