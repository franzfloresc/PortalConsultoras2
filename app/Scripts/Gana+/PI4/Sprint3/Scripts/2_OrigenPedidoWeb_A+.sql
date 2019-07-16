GO
USE BelcorpPeru
GO

DELETE FROM [dbo].[OrigenPedidoWeb]
      WHERE [CodOrigenPedidoWeb]
--Origen de Pedido Sugeridos
		in ('1190020','1190120','1190220','1190320','1191420','2190020','2190120','2190220','2190320','2191420','4190020','4190120','4190220','4190320','4191420','1190021','1190121','1190221','1190321','1191421','2190021','2190121','2190221','2190321','2191421','4190021','4190121','4190221','4190321','4191421'
--Origen de Pedido Cros Selling
		,'1190018','1190118','1190218','1190318','1191418','2190018','2190118','2190218','2190318','2191418','4190018','4190118','4190218','4190318','4191418','1190019','1190119','1190219','1190319','1191419','2190019','2190119','2190219','2190319','2191419','4190019','4190119','4190219','4190319','4191419'
)

go

INSERT INTO [dbo].[OrigenPedidoWeb]
           ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
     VALUES
--Origen de Pedido Sugeridos

('1190020','Desktop Ficha Ofertas Para Ti Carrusel Sugeridos','1','Desktop','19','Ficha','00','Ofertas Para Ti','20','Carrusel Sugeridos'),
('1190120','Desktop Ficha Showroom Carrusel Sugeridos','1','Desktop','19','Ficha','01','Showroom','20','Carrusel Sugeridos'),
('1190220','Desktop Ficha Lanzamientos Carrusel Sugeridos','1','Desktop','19','Ficha','02','Lanzamientos','20','Carrusel Sugeridos'),
('1190320','Desktop Ficha Oferta Del Día Carrusel Sugeridos','1','Desktop','19','Ficha','03','Oferta Del Día','20','Carrusel Sugeridos'),
('1191420','Desktop Ficha Ganadoras Carrusel Sugeridos','1','Desktop','19','Ficha','14','Ganadoras','20','Carrusel Sugeridos'),
('2190020','Mobile Ficha Ofertas Para Ti Carrusel Sugeridos','2','Mobile','19','Ficha','00','Ofertas Para Ti','20','Carrusel Sugeridos'),
('2190120','Mobile Ficha Showroom Carrusel Sugeridos','2','Mobile','19','Ficha','01','Showroom','20','Carrusel Sugeridos'),
('2190220','Mobile Ficha Lanzamientos Carrusel Sugeridos','2','Mobile','19','Ficha','02','Lanzamientos','20','Carrusel Sugeridos'),
('2190320','Mobile Ficha Oferta Del Día Carrusel Sugeridos','2','Mobile','19','Ficha','03','Oferta Del Día','20','Carrusel Sugeridos'),
('2191420','Mobile Ficha Ganadoras Carrusel Sugeridos','2','Mobile','19','Ficha','14','Ganadoras','20','Carrusel Sugeridos'),
('4190020','App Consultora Ficha Ofertas Para Ti Carrusel Sugeridos','4','App Consultora','19','Ficha','00','Ofertas Para Ti','20','Carrusel Sugeridos'),
('4190120','App Consultora Ficha Showroom Carrusel Sugeridos','4','App Consultora','19','Ficha','01','Showroom','20','Carrusel Sugeridos'),
('4190220','App Consultora Ficha Lanzamientos Carrusel Sugeridos','4','App Consultora','19','Ficha','02','Lanzamientos','20','Carrusel Sugeridos'),
('4190320','App Consultora Ficha Oferta Del Día Carrusel Sugeridos','4','App Consultora','19','Ficha','03','Oferta Del Día','20','Carrusel Sugeridos'),
('4191420','App Consultora Ficha Ganadoras Carrusel Sugeridos','4','App Consultora','19','Ficha','14','Ganadoras','20','Carrusel Sugeridos'),
('1190021','Desktop Ficha Ofertas Para Ti Ficha Sugeridos','1','Desktop','19','Ficha','00','Ofertas Para Ti','21','Ficha Sugeridos'),
('1190121','Desktop Ficha Showroom Ficha Sugeridos','1','Desktop','19','Ficha','01','Showroom','21','Ficha Sugeridos'),
('1190221','Desktop Ficha Lanzamientos Ficha Sugeridos','1','Desktop','19','Ficha','02','Lanzamientos','21','Ficha Sugeridos'),
('1190321','Desktop Ficha Oferta Del Día Ficha Sugeridos','1','Desktop','19','Ficha','03','Oferta Del Día','21','Ficha Sugeridos'),
('1191421','Desktop Ficha Ganadoras Ficha Sugeridos','1','Desktop','19','Ficha','14','Ganadoras','21','Ficha Sugeridos'),
('2190021','Mobile Ficha Ofertas Para Ti Ficha Sugeridos','2','Mobile','19','Ficha','00','Ofertas Para Ti','21','Ficha Sugeridos'),
('2190121','Mobile Ficha Showroom Ficha Sugeridos','2','Mobile','19','Ficha','01','Showroom','21','Ficha Sugeridos'),
('2190221','Mobile Ficha Lanzamientos Ficha Sugeridos','2','Mobile','19','Ficha','02','Lanzamientos','21','Ficha Sugeridos'),
('2190321','Mobile Ficha Oferta Del Día Ficha Sugeridos','2','Mobile','19','Ficha','03','Oferta Del Día','21','Ficha Sugeridos'),
('2191421','Mobile Ficha Ganadoras Ficha Sugeridos','2','Mobile','19','Ficha','14','Ganadoras','21','Ficha Sugeridos'),
('4190021','App Consultora Ficha Ofertas Para Ti Ficha Sugeridos','4','App Consultora','19','Ficha','00','Ofertas Para Ti','21','Ficha Sugeridos'),
('4190121','App Consultora Ficha Showroom Ficha Sugeridos','4','App Consultora','19','Ficha','01','Showroom','21','Ficha Sugeridos'),
('4190221','App Consultora Ficha Lanzamientos Ficha Sugeridos','4','App Consultora','19','Ficha','02','Lanzamientos','21','Ficha Sugeridos'),
('4190321','App Consultora Ficha Oferta Del Día Ficha Sugeridos','4','App Consultora','19','Ficha','03','Oferta Del Día','21','Ficha Sugeridos'),
('4191421','App Consultora Ficha Ganadoras Ficha Sugeridos','4','App Consultora','19','Ficha','14','Ganadoras','21','Ficha Sugeridos'),


--Origen de Pedido Cros Selling

('1190018','Desktop Ficha Ofertas Para Ti Carrusel CrossSelling','1','Desktop','19','Ficha','00','Ofertas Para Ti','18','Carrusel CrossSelling'),
('1190118','Desktop Ficha Showroom Carrusel CrossSelling','1','Desktop','19','Ficha','01','Showroom','18','Carrusel CrossSelling'),
('1190218','Desktop Ficha Lanzamientos Carrusel CrossSelling','1','Desktop','19','Ficha','02','Lanzamientos','18','Carrusel CrossSelling'),
('1190318','Desktop Ficha Oferta Del Día Carrusel CrossSelling','1','Desktop','19','Ficha','03','Oferta Del Día','18','Carrusel CrossSelling'),
('1191418','Desktop Ficha Ganadoras Carrusel CrossSelling','1','Desktop','19','Ficha','14','Ganadoras','18','Carrusel CrossSelling'),
('2190018','Mobile Ficha Ofertas Para Ti Carrusel CrossSelling','2','Mobile','19','Ficha','00','Ofertas Para Ti','18','Carrusel CrossSelling'),
('2190118','Mobile Ficha Showroom Carrusel CrossSelling','2','Mobile','19','Ficha','01','Showroom','18','Carrusel CrossSelling'),
('2190218','Mobile Ficha Lanzamientos Carrusel CrossSelling','2','Mobile','19','Ficha','02','Lanzamientos','18','Carrusel CrossSelling'),
('2190318','Mobile Ficha Oferta Del Día Carrusel CrossSelling','2','Mobile','19','Ficha','03','Oferta Del Día','18','Carrusel CrossSelling'),
('2191418','Mobile Ficha Ganadoras Carrusel CrossSelling','2','Mobile','19','Ficha','14','Ganadoras','18','Carrusel CrossSelling'),
('4190018','App Consultora Ficha Ofertas Para Ti Carrusel CrossSelling','4','App Consultora','19','Ficha','00','Ofertas Para Ti','18','Carrusel CrossSelling'),
('4190118','App Consultora Ficha Showroom Carrusel CrossSelling','4','App Consultora','19','Ficha','01','Showroom','18','Carrusel CrossSelling'),
('4190218','App Consultora Ficha Lanzamientos Carrusel CrossSelling','4','App Consultora','19','Ficha','02','Lanzamientos','18','Carrusel CrossSelling'),
('4190318','App Consultora Ficha Oferta Del Día Carrusel CrossSelling','4','App Consultora','19','Ficha','03','Oferta Del Día','18','Carrusel CrossSelling'),
('4191418','App Consultora Ficha Ganadoras Carrusel CrossSelling','4','App Consultora','19','Ficha','14','Ganadoras','18','Carrusel CrossSelling'),
('1190019','Desktop Ficha Ofertas Para Ti Ficha CrossSelling','1','Desktop','19','Ficha','00','Ofertas Para Ti','19','Ficha CrossSelling'),
('1190119','Desktop Ficha Showroom Ficha CrossSelling','1','Desktop','19','Ficha','01','Showroom','19','Ficha CrossSelling'),
('1190219','Desktop Ficha Lanzamientos Ficha CrossSelling','1','Desktop','19','Ficha','02','Lanzamientos','19','Ficha CrossSelling'),
('1190319','Desktop Ficha Oferta Del Día Ficha CrossSelling','1','Desktop','19','Ficha','03','Oferta Del Día','19','Ficha CrossSelling'),
('1191419','Desktop Ficha Ganadoras Ficha CrossSelling','1','Desktop','19','Ficha','14','Ganadoras','19','Ficha CrossSelling'),
('2190019','Mobile Ficha Ofertas Para Ti Ficha CrossSelling','2','Mobile','19','Ficha','00','Ofertas Para Ti','19','Ficha CrossSelling'),
('2190119','Mobile Ficha Showroom Ficha CrossSelling','2','Mobile','19','Ficha','01','Showroom','19','Ficha CrossSelling'),
('2190219','Mobile Ficha Lanzamientos Ficha CrossSelling','2','Mobile','19','Ficha','02','Lanzamientos','19','Ficha CrossSelling'),
('2190319','Mobile Ficha Oferta Del Día Ficha CrossSelling','2','Mobile','19','Ficha','03','Oferta Del Día','19','Ficha CrossSelling'),
('2191419','Mobile Ficha Ganadoras Ficha CrossSelling','2','Mobile','19','Ficha','14','Ganadoras','19','Ficha CrossSelling'),
('4190019','App Consultora Ficha Ofertas Para Ti Ficha CrossSelling','4','App Consultora','19','Ficha','00','Ofertas Para Ti','19','Ficha CrossSelling'),
('4190119','App Consultora Ficha Showroom Ficha CrossSelling','4','App Consultora','19','Ficha','01','Showroom','19','Ficha CrossSelling'),
('4190219','App Consultora Ficha Lanzamientos Ficha CrossSelling','4','App Consultora','19','Ficha','02','Lanzamientos','19','Ficha CrossSelling'),
('4190319','App Consultora Ficha Oferta Del Día Ficha CrossSelling','4','App Consultora','19','Ficha','03','Oferta Del Día','19','Ficha CrossSelling'),
('4191419','App Consultora Ficha Ganadoras Ficha CrossSelling','4','App Consultora','19','Ficha','14','Ganadoras','19','Ficha CrossSelling')


GO
USE BelcorpMexico
GO

DELETE FROM [dbo].[OrigenPedidoWeb]
      WHERE [CodOrigenPedidoWeb]
--Origen de Pedido Sugeridos
		in ('1190020','1190120','1190220','1190320','1191420','2190020','2190120','2190220','2190320','2191420','4190020','4190120','4190220','4190320','4191420','1190021','1190121','1190221','1190321','1191421','2190021','2190121','2190221','2190321','2191421','4190021','4190121','4190221','4190321','4191421'
--Origen de Pedido Cros Selling
		,'1190018','1190118','1190218','1190318','1191418','2190018','2190118','2190218','2190318','2191418','4190018','4190118','4190218','4190318','4191418','1190019','1190119','1190219','1190319','1191419','2190019','2190119','2190219','2190319','2191419','4190019','4190119','4190219','4190319','4191419'
)

go

INSERT INTO [dbo].[OrigenPedidoWeb]
           ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
     VALUES
--Origen de Pedido Sugeridos

('1190020','Desktop Ficha Ofertas Para Ti Carrusel Sugeridos','1','Desktop','19','Ficha','00','Ofertas Para Ti','20','Carrusel Sugeridos'),
('1190120','Desktop Ficha Showroom Carrusel Sugeridos','1','Desktop','19','Ficha','01','Showroom','20','Carrusel Sugeridos'),
('1190220','Desktop Ficha Lanzamientos Carrusel Sugeridos','1','Desktop','19','Ficha','02','Lanzamientos','20','Carrusel Sugeridos'),
('1190320','Desktop Ficha Oferta Del Día Carrusel Sugeridos','1','Desktop','19','Ficha','03','Oferta Del Día','20','Carrusel Sugeridos'),
('1191420','Desktop Ficha Ganadoras Carrusel Sugeridos','1','Desktop','19','Ficha','14','Ganadoras','20','Carrusel Sugeridos'),
('2190020','Mobile Ficha Ofertas Para Ti Carrusel Sugeridos','2','Mobile','19','Ficha','00','Ofertas Para Ti','20','Carrusel Sugeridos'),
('2190120','Mobile Ficha Showroom Carrusel Sugeridos','2','Mobile','19','Ficha','01','Showroom','20','Carrusel Sugeridos'),
('2190220','Mobile Ficha Lanzamientos Carrusel Sugeridos','2','Mobile','19','Ficha','02','Lanzamientos','20','Carrusel Sugeridos'),
('2190320','Mobile Ficha Oferta Del Día Carrusel Sugeridos','2','Mobile','19','Ficha','03','Oferta Del Día','20','Carrusel Sugeridos'),
('2191420','Mobile Ficha Ganadoras Carrusel Sugeridos','2','Mobile','19','Ficha','14','Ganadoras','20','Carrusel Sugeridos'),
('4190020','App Consultora Ficha Ofertas Para Ti Carrusel Sugeridos','4','App Consultora','19','Ficha','00','Ofertas Para Ti','20','Carrusel Sugeridos'),
('4190120','App Consultora Ficha Showroom Carrusel Sugeridos','4','App Consultora','19','Ficha','01','Showroom','20','Carrusel Sugeridos'),
('4190220','App Consultora Ficha Lanzamientos Carrusel Sugeridos','4','App Consultora','19','Ficha','02','Lanzamientos','20','Carrusel Sugeridos'),
('4190320','App Consultora Ficha Oferta Del Día Carrusel Sugeridos','4','App Consultora','19','Ficha','03','Oferta Del Día','20','Carrusel Sugeridos'),
('4191420','App Consultora Ficha Ganadoras Carrusel Sugeridos','4','App Consultora','19','Ficha','14','Ganadoras','20','Carrusel Sugeridos'),
('1190021','Desktop Ficha Ofertas Para Ti Ficha Sugeridos','1','Desktop','19','Ficha','00','Ofertas Para Ti','21','Ficha Sugeridos'),
('1190121','Desktop Ficha Showroom Ficha Sugeridos','1','Desktop','19','Ficha','01','Showroom','21','Ficha Sugeridos'),
('1190221','Desktop Ficha Lanzamientos Ficha Sugeridos','1','Desktop','19','Ficha','02','Lanzamientos','21','Ficha Sugeridos'),
('1190321','Desktop Ficha Oferta Del Día Ficha Sugeridos','1','Desktop','19','Ficha','03','Oferta Del Día','21','Ficha Sugeridos'),
('1191421','Desktop Ficha Ganadoras Ficha Sugeridos','1','Desktop','19','Ficha','14','Ganadoras','21','Ficha Sugeridos'),
('2190021','Mobile Ficha Ofertas Para Ti Ficha Sugeridos','2','Mobile','19','Ficha','00','Ofertas Para Ti','21','Ficha Sugeridos'),
('2190121','Mobile Ficha Showroom Ficha Sugeridos','2','Mobile','19','Ficha','01','Showroom','21','Ficha Sugeridos'),
('2190221','Mobile Ficha Lanzamientos Ficha Sugeridos','2','Mobile','19','Ficha','02','Lanzamientos','21','Ficha Sugeridos'),
('2190321','Mobile Ficha Oferta Del Día Ficha Sugeridos','2','Mobile','19','Ficha','03','Oferta Del Día','21','Ficha Sugeridos'),
('2191421','Mobile Ficha Ganadoras Ficha Sugeridos','2','Mobile','19','Ficha','14','Ganadoras','21','Ficha Sugeridos'),
('4190021','App Consultora Ficha Ofertas Para Ti Ficha Sugeridos','4','App Consultora','19','Ficha','00','Ofertas Para Ti','21','Ficha Sugeridos'),
('4190121','App Consultora Ficha Showroom Ficha Sugeridos','4','App Consultora','19','Ficha','01','Showroom','21','Ficha Sugeridos'),
('4190221','App Consultora Ficha Lanzamientos Ficha Sugeridos','4','App Consultora','19','Ficha','02','Lanzamientos','21','Ficha Sugeridos'),
('4190321','App Consultora Ficha Oferta Del Día Ficha Sugeridos','4','App Consultora','19','Ficha','03','Oferta Del Día','21','Ficha Sugeridos'),
('4191421','App Consultora Ficha Ganadoras Ficha Sugeridos','4','App Consultora','19','Ficha','14','Ganadoras','21','Ficha Sugeridos'),


--Origen de Pedido Cros Selling

('1190018','Desktop Ficha Ofertas Para Ti Carrusel CrossSelling','1','Desktop','19','Ficha','00','Ofertas Para Ti','18','Carrusel CrossSelling'),
('1190118','Desktop Ficha Showroom Carrusel CrossSelling','1','Desktop','19','Ficha','01','Showroom','18','Carrusel CrossSelling'),
('1190218','Desktop Ficha Lanzamientos Carrusel CrossSelling','1','Desktop','19','Ficha','02','Lanzamientos','18','Carrusel CrossSelling'),
('1190318','Desktop Ficha Oferta Del Día Carrusel CrossSelling','1','Desktop','19','Ficha','03','Oferta Del Día','18','Carrusel CrossSelling'),
('1191418','Desktop Ficha Ganadoras Carrusel CrossSelling','1','Desktop','19','Ficha','14','Ganadoras','18','Carrusel CrossSelling'),
('2190018','Mobile Ficha Ofertas Para Ti Carrusel CrossSelling','2','Mobile','19','Ficha','00','Ofertas Para Ti','18','Carrusel CrossSelling'),
('2190118','Mobile Ficha Showroom Carrusel CrossSelling','2','Mobile','19','Ficha','01','Showroom','18','Carrusel CrossSelling'),
('2190218','Mobile Ficha Lanzamientos Carrusel CrossSelling','2','Mobile','19','Ficha','02','Lanzamientos','18','Carrusel CrossSelling'),
('2190318','Mobile Ficha Oferta Del Día Carrusel CrossSelling','2','Mobile','19','Ficha','03','Oferta Del Día','18','Carrusel CrossSelling'),
('2191418','Mobile Ficha Ganadoras Carrusel CrossSelling','2','Mobile','19','Ficha','14','Ganadoras','18','Carrusel CrossSelling'),
('4190018','App Consultora Ficha Ofertas Para Ti Carrusel CrossSelling','4','App Consultora','19','Ficha','00','Ofertas Para Ti','18','Carrusel CrossSelling'),
('4190118','App Consultora Ficha Showroom Carrusel CrossSelling','4','App Consultora','19','Ficha','01','Showroom','18','Carrusel CrossSelling'),
('4190218','App Consultora Ficha Lanzamientos Carrusel CrossSelling','4','App Consultora','19','Ficha','02','Lanzamientos','18','Carrusel CrossSelling'),
('4190318','App Consultora Ficha Oferta Del Día Carrusel CrossSelling','4','App Consultora','19','Ficha','03','Oferta Del Día','18','Carrusel CrossSelling'),
('4191418','App Consultora Ficha Ganadoras Carrusel CrossSelling','4','App Consultora','19','Ficha','14','Ganadoras','18','Carrusel CrossSelling'),
('1190019','Desktop Ficha Ofertas Para Ti Ficha CrossSelling','1','Desktop','19','Ficha','00','Ofertas Para Ti','19','Ficha CrossSelling'),
('1190119','Desktop Ficha Showroom Ficha CrossSelling','1','Desktop','19','Ficha','01','Showroom','19','Ficha CrossSelling'),
('1190219','Desktop Ficha Lanzamientos Ficha CrossSelling','1','Desktop','19','Ficha','02','Lanzamientos','19','Ficha CrossSelling'),
('1190319','Desktop Ficha Oferta Del Día Ficha CrossSelling','1','Desktop','19','Ficha','03','Oferta Del Día','19','Ficha CrossSelling'),
('1191419','Desktop Ficha Ganadoras Ficha CrossSelling','1','Desktop','19','Ficha','14','Ganadoras','19','Ficha CrossSelling'),
('2190019','Mobile Ficha Ofertas Para Ti Ficha CrossSelling','2','Mobile','19','Ficha','00','Ofertas Para Ti','19','Ficha CrossSelling'),
('2190119','Mobile Ficha Showroom Ficha CrossSelling','2','Mobile','19','Ficha','01','Showroom','19','Ficha CrossSelling'),
('2190219','Mobile Ficha Lanzamientos Ficha CrossSelling','2','Mobile','19','Ficha','02','Lanzamientos','19','Ficha CrossSelling'),
('2190319','Mobile Ficha Oferta Del Día Ficha CrossSelling','2','Mobile','19','Ficha','03','Oferta Del Día','19','Ficha CrossSelling'),
('2191419','Mobile Ficha Ganadoras Ficha CrossSelling','2','Mobile','19','Ficha','14','Ganadoras','19','Ficha CrossSelling'),
('4190019','App Consultora Ficha Ofertas Para Ti Ficha CrossSelling','4','App Consultora','19','Ficha','00','Ofertas Para Ti','19','Ficha CrossSelling'),
('4190119','App Consultora Ficha Showroom Ficha CrossSelling','4','App Consultora','19','Ficha','01','Showroom','19','Ficha CrossSelling'),
('4190219','App Consultora Ficha Lanzamientos Ficha CrossSelling','4','App Consultora','19','Ficha','02','Lanzamientos','19','Ficha CrossSelling'),
('4190319','App Consultora Ficha Oferta Del Día Ficha CrossSelling','4','App Consultora','19','Ficha','03','Oferta Del Día','19','Ficha CrossSelling'),
('4191419','App Consultora Ficha Ganadoras Ficha CrossSelling','4','App Consultora','19','Ficha','14','Ganadoras','19','Ficha CrossSelling')



GO
USE BelcorpColombia
GO

DELETE FROM [dbo].[OrigenPedidoWeb]
      WHERE [CodOrigenPedidoWeb]
--Origen de Pedido Sugeridos
		in ('1190020','1190120','1190220','1190320','1191420','2190020','2190120','2190220','2190320','2191420','4190020','4190120','4190220','4190320','4191420','1190021','1190121','1190221','1190321','1191421','2190021','2190121','2190221','2190321','2191421','4190021','4190121','4190221','4190321','4191421'
--Origen de Pedido Cros Selling
		,'1190018','1190118','1190218','1190318','1191418','2190018','2190118','2190218','2190318','2191418','4190018','4190118','4190218','4190318','4191418','1190019','1190119','1190219','1190319','1191419','2190019','2190119','2190219','2190319','2191419','4190019','4190119','4190219','4190319','4191419'
)

go

INSERT INTO [dbo].[OrigenPedidoWeb]
           ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
     VALUES
--Origen de Pedido Sugeridos

('1190020','Desktop Ficha Ofertas Para Ti Carrusel Sugeridos','1','Desktop','19','Ficha','00','Ofertas Para Ti','20','Carrusel Sugeridos'),
('1190120','Desktop Ficha Showroom Carrusel Sugeridos','1','Desktop','19','Ficha','01','Showroom','20','Carrusel Sugeridos'),
('1190220','Desktop Ficha Lanzamientos Carrusel Sugeridos','1','Desktop','19','Ficha','02','Lanzamientos','20','Carrusel Sugeridos'),
('1190320','Desktop Ficha Oferta Del Día Carrusel Sugeridos','1','Desktop','19','Ficha','03','Oferta Del Día','20','Carrusel Sugeridos'),
('1191420','Desktop Ficha Ganadoras Carrusel Sugeridos','1','Desktop','19','Ficha','14','Ganadoras','20','Carrusel Sugeridos'),
('2190020','Mobile Ficha Ofertas Para Ti Carrusel Sugeridos','2','Mobile','19','Ficha','00','Ofertas Para Ti','20','Carrusel Sugeridos'),
('2190120','Mobile Ficha Showroom Carrusel Sugeridos','2','Mobile','19','Ficha','01','Showroom','20','Carrusel Sugeridos'),
('2190220','Mobile Ficha Lanzamientos Carrusel Sugeridos','2','Mobile','19','Ficha','02','Lanzamientos','20','Carrusel Sugeridos'),
('2190320','Mobile Ficha Oferta Del Día Carrusel Sugeridos','2','Mobile','19','Ficha','03','Oferta Del Día','20','Carrusel Sugeridos'),
('2191420','Mobile Ficha Ganadoras Carrusel Sugeridos','2','Mobile','19','Ficha','14','Ganadoras','20','Carrusel Sugeridos'),
('4190020','App Consultora Ficha Ofertas Para Ti Carrusel Sugeridos','4','App Consultora','19','Ficha','00','Ofertas Para Ti','20','Carrusel Sugeridos'),
('4190120','App Consultora Ficha Showroom Carrusel Sugeridos','4','App Consultora','19','Ficha','01','Showroom','20','Carrusel Sugeridos'),
('4190220','App Consultora Ficha Lanzamientos Carrusel Sugeridos','4','App Consultora','19','Ficha','02','Lanzamientos','20','Carrusel Sugeridos'),
('4190320','App Consultora Ficha Oferta Del Día Carrusel Sugeridos','4','App Consultora','19','Ficha','03','Oferta Del Día','20','Carrusel Sugeridos'),
('4191420','App Consultora Ficha Ganadoras Carrusel Sugeridos','4','App Consultora','19','Ficha','14','Ganadoras','20','Carrusel Sugeridos'),
('1190021','Desktop Ficha Ofertas Para Ti Ficha Sugeridos','1','Desktop','19','Ficha','00','Ofertas Para Ti','21','Ficha Sugeridos'),
('1190121','Desktop Ficha Showroom Ficha Sugeridos','1','Desktop','19','Ficha','01','Showroom','21','Ficha Sugeridos'),
('1190221','Desktop Ficha Lanzamientos Ficha Sugeridos','1','Desktop','19','Ficha','02','Lanzamientos','21','Ficha Sugeridos'),
('1190321','Desktop Ficha Oferta Del Día Ficha Sugeridos','1','Desktop','19','Ficha','03','Oferta Del Día','21','Ficha Sugeridos'),
('1191421','Desktop Ficha Ganadoras Ficha Sugeridos','1','Desktop','19','Ficha','14','Ganadoras','21','Ficha Sugeridos'),
('2190021','Mobile Ficha Ofertas Para Ti Ficha Sugeridos','2','Mobile','19','Ficha','00','Ofertas Para Ti','21','Ficha Sugeridos'),
('2190121','Mobile Ficha Showroom Ficha Sugeridos','2','Mobile','19','Ficha','01','Showroom','21','Ficha Sugeridos'),
('2190221','Mobile Ficha Lanzamientos Ficha Sugeridos','2','Mobile','19','Ficha','02','Lanzamientos','21','Ficha Sugeridos'),
('2190321','Mobile Ficha Oferta Del Día Ficha Sugeridos','2','Mobile','19','Ficha','03','Oferta Del Día','21','Ficha Sugeridos'),
('2191421','Mobile Ficha Ganadoras Ficha Sugeridos','2','Mobile','19','Ficha','14','Ganadoras','21','Ficha Sugeridos'),
('4190021','App Consultora Ficha Ofertas Para Ti Ficha Sugeridos','4','App Consultora','19','Ficha','00','Ofertas Para Ti','21','Ficha Sugeridos'),
('4190121','App Consultora Ficha Showroom Ficha Sugeridos','4','App Consultora','19','Ficha','01','Showroom','21','Ficha Sugeridos'),
('4190221','App Consultora Ficha Lanzamientos Ficha Sugeridos','4','App Consultora','19','Ficha','02','Lanzamientos','21','Ficha Sugeridos'),
('4190321','App Consultora Ficha Oferta Del Día Ficha Sugeridos','4','App Consultora','19','Ficha','03','Oferta Del Día','21','Ficha Sugeridos'),
('4191421','App Consultora Ficha Ganadoras Ficha Sugeridos','4','App Consultora','19','Ficha','14','Ganadoras','21','Ficha Sugeridos'),


--Origen de Pedido Cros Selling

('1190018','Desktop Ficha Ofertas Para Ti Carrusel CrossSelling','1','Desktop','19','Ficha','00','Ofertas Para Ti','18','Carrusel CrossSelling'),
('1190118','Desktop Ficha Showroom Carrusel CrossSelling','1','Desktop','19','Ficha','01','Showroom','18','Carrusel CrossSelling'),
('1190218','Desktop Ficha Lanzamientos Carrusel CrossSelling','1','Desktop','19','Ficha','02','Lanzamientos','18','Carrusel CrossSelling'),
('1190318','Desktop Ficha Oferta Del Día Carrusel CrossSelling','1','Desktop','19','Ficha','03','Oferta Del Día','18','Carrusel CrossSelling'),
('1191418','Desktop Ficha Ganadoras Carrusel CrossSelling','1','Desktop','19','Ficha','14','Ganadoras','18','Carrusel CrossSelling'),
('2190018','Mobile Ficha Ofertas Para Ti Carrusel CrossSelling','2','Mobile','19','Ficha','00','Ofertas Para Ti','18','Carrusel CrossSelling'),
('2190118','Mobile Ficha Showroom Carrusel CrossSelling','2','Mobile','19','Ficha','01','Showroom','18','Carrusel CrossSelling'),
('2190218','Mobile Ficha Lanzamientos Carrusel CrossSelling','2','Mobile','19','Ficha','02','Lanzamientos','18','Carrusel CrossSelling'),
('2190318','Mobile Ficha Oferta Del Día Carrusel CrossSelling','2','Mobile','19','Ficha','03','Oferta Del Día','18','Carrusel CrossSelling'),
('2191418','Mobile Ficha Ganadoras Carrusel CrossSelling','2','Mobile','19','Ficha','14','Ganadoras','18','Carrusel CrossSelling'),
('4190018','App Consultora Ficha Ofertas Para Ti Carrusel CrossSelling','4','App Consultora','19','Ficha','00','Ofertas Para Ti','18','Carrusel CrossSelling'),
('4190118','App Consultora Ficha Showroom Carrusel CrossSelling','4','App Consultora','19','Ficha','01','Showroom','18','Carrusel CrossSelling'),
('4190218','App Consultora Ficha Lanzamientos Carrusel CrossSelling','4','App Consultora','19','Ficha','02','Lanzamientos','18','Carrusel CrossSelling'),
('4190318','App Consultora Ficha Oferta Del Día Carrusel CrossSelling','4','App Consultora','19','Ficha','03','Oferta Del Día','18','Carrusel CrossSelling'),
('4191418','App Consultora Ficha Ganadoras Carrusel CrossSelling','4','App Consultora','19','Ficha','14','Ganadoras','18','Carrusel CrossSelling'),
('1190019','Desktop Ficha Ofertas Para Ti Ficha CrossSelling','1','Desktop','19','Ficha','00','Ofertas Para Ti','19','Ficha CrossSelling'),
('1190119','Desktop Ficha Showroom Ficha CrossSelling','1','Desktop','19','Ficha','01','Showroom','19','Ficha CrossSelling'),
('1190219','Desktop Ficha Lanzamientos Ficha CrossSelling','1','Desktop','19','Ficha','02','Lanzamientos','19','Ficha CrossSelling'),
('1190319','Desktop Ficha Oferta Del Día Ficha CrossSelling','1','Desktop','19','Ficha','03','Oferta Del Día','19','Ficha CrossSelling'),
('1191419','Desktop Ficha Ganadoras Ficha CrossSelling','1','Desktop','19','Ficha','14','Ganadoras','19','Ficha CrossSelling'),
('2190019','Mobile Ficha Ofertas Para Ti Ficha CrossSelling','2','Mobile','19','Ficha','00','Ofertas Para Ti','19','Ficha CrossSelling'),
('2190119','Mobile Ficha Showroom Ficha CrossSelling','2','Mobile','19','Ficha','01','Showroom','19','Ficha CrossSelling'),
('2190219','Mobile Ficha Lanzamientos Ficha CrossSelling','2','Mobile','19','Ficha','02','Lanzamientos','19','Ficha CrossSelling'),
('2190319','Mobile Ficha Oferta Del Día Ficha CrossSelling','2','Mobile','19','Ficha','03','Oferta Del Día','19','Ficha CrossSelling'),
('2191419','Mobile Ficha Ganadoras Ficha CrossSelling','2','Mobile','19','Ficha','14','Ganadoras','19','Ficha CrossSelling'),
('4190019','App Consultora Ficha Ofertas Para Ti Ficha CrossSelling','4','App Consultora','19','Ficha','00','Ofertas Para Ti','19','Ficha CrossSelling'),
('4190119','App Consultora Ficha Showroom Ficha CrossSelling','4','App Consultora','19','Ficha','01','Showroom','19','Ficha CrossSelling'),
('4190219','App Consultora Ficha Lanzamientos Ficha CrossSelling','4','App Consultora','19','Ficha','02','Lanzamientos','19','Ficha CrossSelling'),
('4190319','App Consultora Ficha Oferta Del Día Ficha CrossSelling','4','App Consultora','19','Ficha','03','Oferta Del Día','19','Ficha CrossSelling'),
('4191419','App Consultora Ficha Ganadoras Ficha CrossSelling','4','App Consultora','19','Ficha','14','Ganadoras','19','Ficha CrossSelling')



GO
USE BelcorpSalvador
GO

DELETE FROM [dbo].[OrigenPedidoWeb]
      WHERE [CodOrigenPedidoWeb]
--Origen de Pedido Sugeridos
		in ('1190020','1190120','1190220','1190320','1191420','2190020','2190120','2190220','2190320','2191420','4190020','4190120','4190220','4190320','4191420','1190021','1190121','1190221','1190321','1191421','2190021','2190121','2190221','2190321','2191421','4190021','4190121','4190221','4190321','4191421'
--Origen de Pedido Cros Selling
		,'1190018','1190118','1190218','1190318','1191418','2190018','2190118','2190218','2190318','2191418','4190018','4190118','4190218','4190318','4191418','1190019','1190119','1190219','1190319','1191419','2190019','2190119','2190219','2190319','2191419','4190019','4190119','4190219','4190319','4191419'
)

go

INSERT INTO [dbo].[OrigenPedidoWeb]
           ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
     VALUES
--Origen de Pedido Sugeridos

('1190020','Desktop Ficha Ofertas Para Ti Carrusel Sugeridos','1','Desktop','19','Ficha','00','Ofertas Para Ti','20','Carrusel Sugeridos'),
('1190120','Desktop Ficha Showroom Carrusel Sugeridos','1','Desktop','19','Ficha','01','Showroom','20','Carrusel Sugeridos'),
('1190220','Desktop Ficha Lanzamientos Carrusel Sugeridos','1','Desktop','19','Ficha','02','Lanzamientos','20','Carrusel Sugeridos'),
('1190320','Desktop Ficha Oferta Del Día Carrusel Sugeridos','1','Desktop','19','Ficha','03','Oferta Del Día','20','Carrusel Sugeridos'),
('1191420','Desktop Ficha Ganadoras Carrusel Sugeridos','1','Desktop','19','Ficha','14','Ganadoras','20','Carrusel Sugeridos'),
('2190020','Mobile Ficha Ofertas Para Ti Carrusel Sugeridos','2','Mobile','19','Ficha','00','Ofertas Para Ti','20','Carrusel Sugeridos'),
('2190120','Mobile Ficha Showroom Carrusel Sugeridos','2','Mobile','19','Ficha','01','Showroom','20','Carrusel Sugeridos'),
('2190220','Mobile Ficha Lanzamientos Carrusel Sugeridos','2','Mobile','19','Ficha','02','Lanzamientos','20','Carrusel Sugeridos'),
('2190320','Mobile Ficha Oferta Del Día Carrusel Sugeridos','2','Mobile','19','Ficha','03','Oferta Del Día','20','Carrusel Sugeridos'),
('2191420','Mobile Ficha Ganadoras Carrusel Sugeridos','2','Mobile','19','Ficha','14','Ganadoras','20','Carrusel Sugeridos'),
('4190020','App Consultora Ficha Ofertas Para Ti Carrusel Sugeridos','4','App Consultora','19','Ficha','00','Ofertas Para Ti','20','Carrusel Sugeridos'),
('4190120','App Consultora Ficha Showroom Carrusel Sugeridos','4','App Consultora','19','Ficha','01','Showroom','20','Carrusel Sugeridos'),
('4190220','App Consultora Ficha Lanzamientos Carrusel Sugeridos','4','App Consultora','19','Ficha','02','Lanzamientos','20','Carrusel Sugeridos'),
('4190320','App Consultora Ficha Oferta Del Día Carrusel Sugeridos','4','App Consultora','19','Ficha','03','Oferta Del Día','20','Carrusel Sugeridos'),
('4191420','App Consultora Ficha Ganadoras Carrusel Sugeridos','4','App Consultora','19','Ficha','14','Ganadoras','20','Carrusel Sugeridos'),
('1190021','Desktop Ficha Ofertas Para Ti Ficha Sugeridos','1','Desktop','19','Ficha','00','Ofertas Para Ti','21','Ficha Sugeridos'),
('1190121','Desktop Ficha Showroom Ficha Sugeridos','1','Desktop','19','Ficha','01','Showroom','21','Ficha Sugeridos'),
('1190221','Desktop Ficha Lanzamientos Ficha Sugeridos','1','Desktop','19','Ficha','02','Lanzamientos','21','Ficha Sugeridos'),
('1190321','Desktop Ficha Oferta Del Día Ficha Sugeridos','1','Desktop','19','Ficha','03','Oferta Del Día','21','Ficha Sugeridos'),
('1191421','Desktop Ficha Ganadoras Ficha Sugeridos','1','Desktop','19','Ficha','14','Ganadoras','21','Ficha Sugeridos'),
('2190021','Mobile Ficha Ofertas Para Ti Ficha Sugeridos','2','Mobile','19','Ficha','00','Ofertas Para Ti','21','Ficha Sugeridos'),
('2190121','Mobile Ficha Showroom Ficha Sugeridos','2','Mobile','19','Ficha','01','Showroom','21','Ficha Sugeridos'),
('2190221','Mobile Ficha Lanzamientos Ficha Sugeridos','2','Mobile','19','Ficha','02','Lanzamientos','21','Ficha Sugeridos'),
('2190321','Mobile Ficha Oferta Del Día Ficha Sugeridos','2','Mobile','19','Ficha','03','Oferta Del Día','21','Ficha Sugeridos'),
('2191421','Mobile Ficha Ganadoras Ficha Sugeridos','2','Mobile','19','Ficha','14','Ganadoras','21','Ficha Sugeridos'),
('4190021','App Consultora Ficha Ofertas Para Ti Ficha Sugeridos','4','App Consultora','19','Ficha','00','Ofertas Para Ti','21','Ficha Sugeridos'),
('4190121','App Consultora Ficha Showroom Ficha Sugeridos','4','App Consultora','19','Ficha','01','Showroom','21','Ficha Sugeridos'),
('4190221','App Consultora Ficha Lanzamientos Ficha Sugeridos','4','App Consultora','19','Ficha','02','Lanzamientos','21','Ficha Sugeridos'),
('4190321','App Consultora Ficha Oferta Del Día Ficha Sugeridos','4','App Consultora','19','Ficha','03','Oferta Del Día','21','Ficha Sugeridos'),
('4191421','App Consultora Ficha Ganadoras Ficha Sugeridos','4','App Consultora','19','Ficha','14','Ganadoras','21','Ficha Sugeridos'),


--Origen de Pedido Cros Selling

('1190018','Desktop Ficha Ofertas Para Ti Carrusel CrossSelling','1','Desktop','19','Ficha','00','Ofertas Para Ti','18','Carrusel CrossSelling'),
('1190118','Desktop Ficha Showroom Carrusel CrossSelling','1','Desktop','19','Ficha','01','Showroom','18','Carrusel CrossSelling'),
('1190218','Desktop Ficha Lanzamientos Carrusel CrossSelling','1','Desktop','19','Ficha','02','Lanzamientos','18','Carrusel CrossSelling'),
('1190318','Desktop Ficha Oferta Del Día Carrusel CrossSelling','1','Desktop','19','Ficha','03','Oferta Del Día','18','Carrusel CrossSelling'),
('1191418','Desktop Ficha Ganadoras Carrusel CrossSelling','1','Desktop','19','Ficha','14','Ganadoras','18','Carrusel CrossSelling'),
('2190018','Mobile Ficha Ofertas Para Ti Carrusel CrossSelling','2','Mobile','19','Ficha','00','Ofertas Para Ti','18','Carrusel CrossSelling'),
('2190118','Mobile Ficha Showroom Carrusel CrossSelling','2','Mobile','19','Ficha','01','Showroom','18','Carrusel CrossSelling'),
('2190218','Mobile Ficha Lanzamientos Carrusel CrossSelling','2','Mobile','19','Ficha','02','Lanzamientos','18','Carrusel CrossSelling'),
('2190318','Mobile Ficha Oferta Del Día Carrusel CrossSelling','2','Mobile','19','Ficha','03','Oferta Del Día','18','Carrusel CrossSelling'),
('2191418','Mobile Ficha Ganadoras Carrusel CrossSelling','2','Mobile','19','Ficha','14','Ganadoras','18','Carrusel CrossSelling'),
('4190018','App Consultora Ficha Ofertas Para Ti Carrusel CrossSelling','4','App Consultora','19','Ficha','00','Ofertas Para Ti','18','Carrusel CrossSelling'),
('4190118','App Consultora Ficha Showroom Carrusel CrossSelling','4','App Consultora','19','Ficha','01','Showroom','18','Carrusel CrossSelling'),
('4190218','App Consultora Ficha Lanzamientos Carrusel CrossSelling','4','App Consultora','19','Ficha','02','Lanzamientos','18','Carrusel CrossSelling'),
('4190318','App Consultora Ficha Oferta Del Día Carrusel CrossSelling','4','App Consultora','19','Ficha','03','Oferta Del Día','18','Carrusel CrossSelling'),
('4191418','App Consultora Ficha Ganadoras Carrusel CrossSelling','4','App Consultora','19','Ficha','14','Ganadoras','18','Carrusel CrossSelling'),
('1190019','Desktop Ficha Ofertas Para Ti Ficha CrossSelling','1','Desktop','19','Ficha','00','Ofertas Para Ti','19','Ficha CrossSelling'),
('1190119','Desktop Ficha Showroom Ficha CrossSelling','1','Desktop','19','Ficha','01','Showroom','19','Ficha CrossSelling'),
('1190219','Desktop Ficha Lanzamientos Ficha CrossSelling','1','Desktop','19','Ficha','02','Lanzamientos','19','Ficha CrossSelling'),
('1190319','Desktop Ficha Oferta Del Día Ficha CrossSelling','1','Desktop','19','Ficha','03','Oferta Del Día','19','Ficha CrossSelling'),
('1191419','Desktop Ficha Ganadoras Ficha CrossSelling','1','Desktop','19','Ficha','14','Ganadoras','19','Ficha CrossSelling'),
('2190019','Mobile Ficha Ofertas Para Ti Ficha CrossSelling','2','Mobile','19','Ficha','00','Ofertas Para Ti','19','Ficha CrossSelling'),
('2190119','Mobile Ficha Showroom Ficha CrossSelling','2','Mobile','19','Ficha','01','Showroom','19','Ficha CrossSelling'),
('2190219','Mobile Ficha Lanzamientos Ficha CrossSelling','2','Mobile','19','Ficha','02','Lanzamientos','19','Ficha CrossSelling'),
('2190319','Mobile Ficha Oferta Del Día Ficha CrossSelling','2','Mobile','19','Ficha','03','Oferta Del Día','19','Ficha CrossSelling'),
('2191419','Mobile Ficha Ganadoras Ficha CrossSelling','2','Mobile','19','Ficha','14','Ganadoras','19','Ficha CrossSelling'),
('4190019','App Consultora Ficha Ofertas Para Ti Ficha CrossSelling','4','App Consultora','19','Ficha','00','Ofertas Para Ti','19','Ficha CrossSelling'),
('4190119','App Consultora Ficha Showroom Ficha CrossSelling','4','App Consultora','19','Ficha','01','Showroom','19','Ficha CrossSelling'),
('4190219','App Consultora Ficha Lanzamientos Ficha CrossSelling','4','App Consultora','19','Ficha','02','Lanzamientos','19','Ficha CrossSelling'),
('4190319','App Consultora Ficha Oferta Del Día Ficha CrossSelling','4','App Consultora','19','Ficha','03','Oferta Del Día','19','Ficha CrossSelling'),
('4191419','App Consultora Ficha Ganadoras Ficha CrossSelling','4','App Consultora','19','Ficha','14','Ganadoras','19','Ficha CrossSelling')



GO
USE BelcorpPuertoRico
GO

DELETE FROM [dbo].[OrigenPedidoWeb]
      WHERE [CodOrigenPedidoWeb]
--Origen de Pedido Sugeridos
		in ('1190020','1190120','1190220','1190320','1191420','2190020','2190120','2190220','2190320','2191420','4190020','4190120','4190220','4190320','4191420','1190021','1190121','1190221','1190321','1191421','2190021','2190121','2190221','2190321','2191421','4190021','4190121','4190221','4190321','4191421'
--Origen de Pedido Cros Selling
		,'1190018','1190118','1190218','1190318','1191418','2190018','2190118','2190218','2190318','2191418','4190018','4190118','4190218','4190318','4191418','1190019','1190119','1190219','1190319','1191419','2190019','2190119','2190219','2190319','2191419','4190019','4190119','4190219','4190319','4191419'
)

go

INSERT INTO [dbo].[OrigenPedidoWeb]
           ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
     VALUES
--Origen de Pedido Sugeridos

('1190020','Desktop Ficha Ofertas Para Ti Carrusel Sugeridos','1','Desktop','19','Ficha','00','Ofertas Para Ti','20','Carrusel Sugeridos'),
('1190120','Desktop Ficha Showroom Carrusel Sugeridos','1','Desktop','19','Ficha','01','Showroom','20','Carrusel Sugeridos'),
('1190220','Desktop Ficha Lanzamientos Carrusel Sugeridos','1','Desktop','19','Ficha','02','Lanzamientos','20','Carrusel Sugeridos'),
('1190320','Desktop Ficha Oferta Del Día Carrusel Sugeridos','1','Desktop','19','Ficha','03','Oferta Del Día','20','Carrusel Sugeridos'),
('1191420','Desktop Ficha Ganadoras Carrusel Sugeridos','1','Desktop','19','Ficha','14','Ganadoras','20','Carrusel Sugeridos'),
('2190020','Mobile Ficha Ofertas Para Ti Carrusel Sugeridos','2','Mobile','19','Ficha','00','Ofertas Para Ti','20','Carrusel Sugeridos'),
('2190120','Mobile Ficha Showroom Carrusel Sugeridos','2','Mobile','19','Ficha','01','Showroom','20','Carrusel Sugeridos'),
('2190220','Mobile Ficha Lanzamientos Carrusel Sugeridos','2','Mobile','19','Ficha','02','Lanzamientos','20','Carrusel Sugeridos'),
('2190320','Mobile Ficha Oferta Del Día Carrusel Sugeridos','2','Mobile','19','Ficha','03','Oferta Del Día','20','Carrusel Sugeridos'),
('2191420','Mobile Ficha Ganadoras Carrusel Sugeridos','2','Mobile','19','Ficha','14','Ganadoras','20','Carrusel Sugeridos'),
('4190020','App Consultora Ficha Ofertas Para Ti Carrusel Sugeridos','4','App Consultora','19','Ficha','00','Ofertas Para Ti','20','Carrusel Sugeridos'),
('4190120','App Consultora Ficha Showroom Carrusel Sugeridos','4','App Consultora','19','Ficha','01','Showroom','20','Carrusel Sugeridos'),
('4190220','App Consultora Ficha Lanzamientos Carrusel Sugeridos','4','App Consultora','19','Ficha','02','Lanzamientos','20','Carrusel Sugeridos'),
('4190320','App Consultora Ficha Oferta Del Día Carrusel Sugeridos','4','App Consultora','19','Ficha','03','Oferta Del Día','20','Carrusel Sugeridos'),
('4191420','App Consultora Ficha Ganadoras Carrusel Sugeridos','4','App Consultora','19','Ficha','14','Ganadoras','20','Carrusel Sugeridos'),
('1190021','Desktop Ficha Ofertas Para Ti Ficha Sugeridos','1','Desktop','19','Ficha','00','Ofertas Para Ti','21','Ficha Sugeridos'),
('1190121','Desktop Ficha Showroom Ficha Sugeridos','1','Desktop','19','Ficha','01','Showroom','21','Ficha Sugeridos'),
('1190221','Desktop Ficha Lanzamientos Ficha Sugeridos','1','Desktop','19','Ficha','02','Lanzamientos','21','Ficha Sugeridos'),
('1190321','Desktop Ficha Oferta Del Día Ficha Sugeridos','1','Desktop','19','Ficha','03','Oferta Del Día','21','Ficha Sugeridos'),
('1191421','Desktop Ficha Ganadoras Ficha Sugeridos','1','Desktop','19','Ficha','14','Ganadoras','21','Ficha Sugeridos'),
('2190021','Mobile Ficha Ofertas Para Ti Ficha Sugeridos','2','Mobile','19','Ficha','00','Ofertas Para Ti','21','Ficha Sugeridos'),
('2190121','Mobile Ficha Showroom Ficha Sugeridos','2','Mobile','19','Ficha','01','Showroom','21','Ficha Sugeridos'),
('2190221','Mobile Ficha Lanzamientos Ficha Sugeridos','2','Mobile','19','Ficha','02','Lanzamientos','21','Ficha Sugeridos'),
('2190321','Mobile Ficha Oferta Del Día Ficha Sugeridos','2','Mobile','19','Ficha','03','Oferta Del Día','21','Ficha Sugeridos'),
('2191421','Mobile Ficha Ganadoras Ficha Sugeridos','2','Mobile','19','Ficha','14','Ganadoras','21','Ficha Sugeridos'),
('4190021','App Consultora Ficha Ofertas Para Ti Ficha Sugeridos','4','App Consultora','19','Ficha','00','Ofertas Para Ti','21','Ficha Sugeridos'),
('4190121','App Consultora Ficha Showroom Ficha Sugeridos','4','App Consultora','19','Ficha','01','Showroom','21','Ficha Sugeridos'),
('4190221','App Consultora Ficha Lanzamientos Ficha Sugeridos','4','App Consultora','19','Ficha','02','Lanzamientos','21','Ficha Sugeridos'),
('4190321','App Consultora Ficha Oferta Del Día Ficha Sugeridos','4','App Consultora','19','Ficha','03','Oferta Del Día','21','Ficha Sugeridos'),
('4191421','App Consultora Ficha Ganadoras Ficha Sugeridos','4','App Consultora','19','Ficha','14','Ganadoras','21','Ficha Sugeridos'),


--Origen de Pedido Cros Selling

('1190018','Desktop Ficha Ofertas Para Ti Carrusel CrossSelling','1','Desktop','19','Ficha','00','Ofertas Para Ti','18','Carrusel CrossSelling'),
('1190118','Desktop Ficha Showroom Carrusel CrossSelling','1','Desktop','19','Ficha','01','Showroom','18','Carrusel CrossSelling'),
('1190218','Desktop Ficha Lanzamientos Carrusel CrossSelling','1','Desktop','19','Ficha','02','Lanzamientos','18','Carrusel CrossSelling'),
('1190318','Desktop Ficha Oferta Del Día Carrusel CrossSelling','1','Desktop','19','Ficha','03','Oferta Del Día','18','Carrusel CrossSelling'),
('1191418','Desktop Ficha Ganadoras Carrusel CrossSelling','1','Desktop','19','Ficha','14','Ganadoras','18','Carrusel CrossSelling'),
('2190018','Mobile Ficha Ofertas Para Ti Carrusel CrossSelling','2','Mobile','19','Ficha','00','Ofertas Para Ti','18','Carrusel CrossSelling'),
('2190118','Mobile Ficha Showroom Carrusel CrossSelling','2','Mobile','19','Ficha','01','Showroom','18','Carrusel CrossSelling'),
('2190218','Mobile Ficha Lanzamientos Carrusel CrossSelling','2','Mobile','19','Ficha','02','Lanzamientos','18','Carrusel CrossSelling'),
('2190318','Mobile Ficha Oferta Del Día Carrusel CrossSelling','2','Mobile','19','Ficha','03','Oferta Del Día','18','Carrusel CrossSelling'),
('2191418','Mobile Ficha Ganadoras Carrusel CrossSelling','2','Mobile','19','Ficha','14','Ganadoras','18','Carrusel CrossSelling'),
('4190018','App Consultora Ficha Ofertas Para Ti Carrusel CrossSelling','4','App Consultora','19','Ficha','00','Ofertas Para Ti','18','Carrusel CrossSelling'),
('4190118','App Consultora Ficha Showroom Carrusel CrossSelling','4','App Consultora','19','Ficha','01','Showroom','18','Carrusel CrossSelling'),
('4190218','App Consultora Ficha Lanzamientos Carrusel CrossSelling','4','App Consultora','19','Ficha','02','Lanzamientos','18','Carrusel CrossSelling'),
('4190318','App Consultora Ficha Oferta Del Día Carrusel CrossSelling','4','App Consultora','19','Ficha','03','Oferta Del Día','18','Carrusel CrossSelling'),
('4191418','App Consultora Ficha Ganadoras Carrusel CrossSelling','4','App Consultora','19','Ficha','14','Ganadoras','18','Carrusel CrossSelling'),
('1190019','Desktop Ficha Ofertas Para Ti Ficha CrossSelling','1','Desktop','19','Ficha','00','Ofertas Para Ti','19','Ficha CrossSelling'),
('1190119','Desktop Ficha Showroom Ficha CrossSelling','1','Desktop','19','Ficha','01','Showroom','19','Ficha CrossSelling'),
('1190219','Desktop Ficha Lanzamientos Ficha CrossSelling','1','Desktop','19','Ficha','02','Lanzamientos','19','Ficha CrossSelling'),
('1190319','Desktop Ficha Oferta Del Día Ficha CrossSelling','1','Desktop','19','Ficha','03','Oferta Del Día','19','Ficha CrossSelling'),
('1191419','Desktop Ficha Ganadoras Ficha CrossSelling','1','Desktop','19','Ficha','14','Ganadoras','19','Ficha CrossSelling'),
('2190019','Mobile Ficha Ofertas Para Ti Ficha CrossSelling','2','Mobile','19','Ficha','00','Ofertas Para Ti','19','Ficha CrossSelling'),
('2190119','Mobile Ficha Showroom Ficha CrossSelling','2','Mobile','19','Ficha','01','Showroom','19','Ficha CrossSelling'),
('2190219','Mobile Ficha Lanzamientos Ficha CrossSelling','2','Mobile','19','Ficha','02','Lanzamientos','19','Ficha CrossSelling'),
('2190319','Mobile Ficha Oferta Del Día Ficha CrossSelling','2','Mobile','19','Ficha','03','Oferta Del Día','19','Ficha CrossSelling'),
('2191419','Mobile Ficha Ganadoras Ficha CrossSelling','2','Mobile','19','Ficha','14','Ganadoras','19','Ficha CrossSelling'),
('4190019','App Consultora Ficha Ofertas Para Ti Ficha CrossSelling','4','App Consultora','19','Ficha','00','Ofertas Para Ti','19','Ficha CrossSelling'),
('4190119','App Consultora Ficha Showroom Ficha CrossSelling','4','App Consultora','19','Ficha','01','Showroom','19','Ficha CrossSelling'),
('4190219','App Consultora Ficha Lanzamientos Ficha CrossSelling','4','App Consultora','19','Ficha','02','Lanzamientos','19','Ficha CrossSelling'),
('4190319','App Consultora Ficha Oferta Del Día Ficha CrossSelling','4','App Consultora','19','Ficha','03','Oferta Del Día','19','Ficha CrossSelling'),
('4191419','App Consultora Ficha Ganadoras Ficha CrossSelling','4','App Consultora','19','Ficha','14','Ganadoras','19','Ficha CrossSelling')



GO
USE BelcorpPanama
GO

DELETE FROM [dbo].[OrigenPedidoWeb]
      WHERE [CodOrigenPedidoWeb]
--Origen de Pedido Sugeridos
		in ('1190020','1190120','1190220','1190320','1191420','2190020','2190120','2190220','2190320','2191420','4190020','4190120','4190220','4190320','4191420','1190021','1190121','1190221','1190321','1191421','2190021','2190121','2190221','2190321','2191421','4190021','4190121','4190221','4190321','4191421'
--Origen de Pedido Cros Selling
		,'1190018','1190118','1190218','1190318','1191418','2190018','2190118','2190218','2190318','2191418','4190018','4190118','4190218','4190318','4191418','1190019','1190119','1190219','1190319','1191419','2190019','2190119','2190219','2190319','2191419','4190019','4190119','4190219','4190319','4191419'
)

go

INSERT INTO [dbo].[OrigenPedidoWeb]
           ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
     VALUES
--Origen de Pedido Sugeridos

('1190020','Desktop Ficha Ofertas Para Ti Carrusel Sugeridos','1','Desktop','19','Ficha','00','Ofertas Para Ti','20','Carrusel Sugeridos'),
('1190120','Desktop Ficha Showroom Carrusel Sugeridos','1','Desktop','19','Ficha','01','Showroom','20','Carrusel Sugeridos'),
('1190220','Desktop Ficha Lanzamientos Carrusel Sugeridos','1','Desktop','19','Ficha','02','Lanzamientos','20','Carrusel Sugeridos'),
('1190320','Desktop Ficha Oferta Del Día Carrusel Sugeridos','1','Desktop','19','Ficha','03','Oferta Del Día','20','Carrusel Sugeridos'),
('1191420','Desktop Ficha Ganadoras Carrusel Sugeridos','1','Desktop','19','Ficha','14','Ganadoras','20','Carrusel Sugeridos'),
('2190020','Mobile Ficha Ofertas Para Ti Carrusel Sugeridos','2','Mobile','19','Ficha','00','Ofertas Para Ti','20','Carrusel Sugeridos'),
('2190120','Mobile Ficha Showroom Carrusel Sugeridos','2','Mobile','19','Ficha','01','Showroom','20','Carrusel Sugeridos'),
('2190220','Mobile Ficha Lanzamientos Carrusel Sugeridos','2','Mobile','19','Ficha','02','Lanzamientos','20','Carrusel Sugeridos'),
('2190320','Mobile Ficha Oferta Del Día Carrusel Sugeridos','2','Mobile','19','Ficha','03','Oferta Del Día','20','Carrusel Sugeridos'),
('2191420','Mobile Ficha Ganadoras Carrusel Sugeridos','2','Mobile','19','Ficha','14','Ganadoras','20','Carrusel Sugeridos'),
('4190020','App Consultora Ficha Ofertas Para Ti Carrusel Sugeridos','4','App Consultora','19','Ficha','00','Ofertas Para Ti','20','Carrusel Sugeridos'),
('4190120','App Consultora Ficha Showroom Carrusel Sugeridos','4','App Consultora','19','Ficha','01','Showroom','20','Carrusel Sugeridos'),
('4190220','App Consultora Ficha Lanzamientos Carrusel Sugeridos','4','App Consultora','19','Ficha','02','Lanzamientos','20','Carrusel Sugeridos'),
('4190320','App Consultora Ficha Oferta Del Día Carrusel Sugeridos','4','App Consultora','19','Ficha','03','Oferta Del Día','20','Carrusel Sugeridos'),
('4191420','App Consultora Ficha Ganadoras Carrusel Sugeridos','4','App Consultora','19','Ficha','14','Ganadoras','20','Carrusel Sugeridos'),
('1190021','Desktop Ficha Ofertas Para Ti Ficha Sugeridos','1','Desktop','19','Ficha','00','Ofertas Para Ti','21','Ficha Sugeridos'),
('1190121','Desktop Ficha Showroom Ficha Sugeridos','1','Desktop','19','Ficha','01','Showroom','21','Ficha Sugeridos'),
('1190221','Desktop Ficha Lanzamientos Ficha Sugeridos','1','Desktop','19','Ficha','02','Lanzamientos','21','Ficha Sugeridos'),
('1190321','Desktop Ficha Oferta Del Día Ficha Sugeridos','1','Desktop','19','Ficha','03','Oferta Del Día','21','Ficha Sugeridos'),
('1191421','Desktop Ficha Ganadoras Ficha Sugeridos','1','Desktop','19','Ficha','14','Ganadoras','21','Ficha Sugeridos'),
('2190021','Mobile Ficha Ofertas Para Ti Ficha Sugeridos','2','Mobile','19','Ficha','00','Ofertas Para Ti','21','Ficha Sugeridos'),
('2190121','Mobile Ficha Showroom Ficha Sugeridos','2','Mobile','19','Ficha','01','Showroom','21','Ficha Sugeridos'),
('2190221','Mobile Ficha Lanzamientos Ficha Sugeridos','2','Mobile','19','Ficha','02','Lanzamientos','21','Ficha Sugeridos'),
('2190321','Mobile Ficha Oferta Del Día Ficha Sugeridos','2','Mobile','19','Ficha','03','Oferta Del Día','21','Ficha Sugeridos'),
('2191421','Mobile Ficha Ganadoras Ficha Sugeridos','2','Mobile','19','Ficha','14','Ganadoras','21','Ficha Sugeridos'),
('4190021','App Consultora Ficha Ofertas Para Ti Ficha Sugeridos','4','App Consultora','19','Ficha','00','Ofertas Para Ti','21','Ficha Sugeridos'),
('4190121','App Consultora Ficha Showroom Ficha Sugeridos','4','App Consultora','19','Ficha','01','Showroom','21','Ficha Sugeridos'),
('4190221','App Consultora Ficha Lanzamientos Ficha Sugeridos','4','App Consultora','19','Ficha','02','Lanzamientos','21','Ficha Sugeridos'),
('4190321','App Consultora Ficha Oferta Del Día Ficha Sugeridos','4','App Consultora','19','Ficha','03','Oferta Del Día','21','Ficha Sugeridos'),
('4191421','App Consultora Ficha Ganadoras Ficha Sugeridos','4','App Consultora','19','Ficha','14','Ganadoras','21','Ficha Sugeridos'),


--Origen de Pedido Cros Selling

('1190018','Desktop Ficha Ofertas Para Ti Carrusel CrossSelling','1','Desktop','19','Ficha','00','Ofertas Para Ti','18','Carrusel CrossSelling'),
('1190118','Desktop Ficha Showroom Carrusel CrossSelling','1','Desktop','19','Ficha','01','Showroom','18','Carrusel CrossSelling'),
('1190218','Desktop Ficha Lanzamientos Carrusel CrossSelling','1','Desktop','19','Ficha','02','Lanzamientos','18','Carrusel CrossSelling'),
('1190318','Desktop Ficha Oferta Del Día Carrusel CrossSelling','1','Desktop','19','Ficha','03','Oferta Del Día','18','Carrusel CrossSelling'),
('1191418','Desktop Ficha Ganadoras Carrusel CrossSelling','1','Desktop','19','Ficha','14','Ganadoras','18','Carrusel CrossSelling'),
('2190018','Mobile Ficha Ofertas Para Ti Carrusel CrossSelling','2','Mobile','19','Ficha','00','Ofertas Para Ti','18','Carrusel CrossSelling'),
('2190118','Mobile Ficha Showroom Carrusel CrossSelling','2','Mobile','19','Ficha','01','Showroom','18','Carrusel CrossSelling'),
('2190218','Mobile Ficha Lanzamientos Carrusel CrossSelling','2','Mobile','19','Ficha','02','Lanzamientos','18','Carrusel CrossSelling'),
('2190318','Mobile Ficha Oferta Del Día Carrusel CrossSelling','2','Mobile','19','Ficha','03','Oferta Del Día','18','Carrusel CrossSelling'),
('2191418','Mobile Ficha Ganadoras Carrusel CrossSelling','2','Mobile','19','Ficha','14','Ganadoras','18','Carrusel CrossSelling'),
('4190018','App Consultora Ficha Ofertas Para Ti Carrusel CrossSelling','4','App Consultora','19','Ficha','00','Ofertas Para Ti','18','Carrusel CrossSelling'),
('4190118','App Consultora Ficha Showroom Carrusel CrossSelling','4','App Consultora','19','Ficha','01','Showroom','18','Carrusel CrossSelling'),
('4190218','App Consultora Ficha Lanzamientos Carrusel CrossSelling','4','App Consultora','19','Ficha','02','Lanzamientos','18','Carrusel CrossSelling'),
('4190318','App Consultora Ficha Oferta Del Día Carrusel CrossSelling','4','App Consultora','19','Ficha','03','Oferta Del Día','18','Carrusel CrossSelling'),
('4191418','App Consultora Ficha Ganadoras Carrusel CrossSelling','4','App Consultora','19','Ficha','14','Ganadoras','18','Carrusel CrossSelling'),
('1190019','Desktop Ficha Ofertas Para Ti Ficha CrossSelling','1','Desktop','19','Ficha','00','Ofertas Para Ti','19','Ficha CrossSelling'),
('1190119','Desktop Ficha Showroom Ficha CrossSelling','1','Desktop','19','Ficha','01','Showroom','19','Ficha CrossSelling'),
('1190219','Desktop Ficha Lanzamientos Ficha CrossSelling','1','Desktop','19','Ficha','02','Lanzamientos','19','Ficha CrossSelling'),
('1190319','Desktop Ficha Oferta Del Día Ficha CrossSelling','1','Desktop','19','Ficha','03','Oferta Del Día','19','Ficha CrossSelling'),
('1191419','Desktop Ficha Ganadoras Ficha CrossSelling','1','Desktop','19','Ficha','14','Ganadoras','19','Ficha CrossSelling'),
('2190019','Mobile Ficha Ofertas Para Ti Ficha CrossSelling','2','Mobile','19','Ficha','00','Ofertas Para Ti','19','Ficha CrossSelling'),
('2190119','Mobile Ficha Showroom Ficha CrossSelling','2','Mobile','19','Ficha','01','Showroom','19','Ficha CrossSelling'),
('2190219','Mobile Ficha Lanzamientos Ficha CrossSelling','2','Mobile','19','Ficha','02','Lanzamientos','19','Ficha CrossSelling'),
('2190319','Mobile Ficha Oferta Del Día Ficha CrossSelling','2','Mobile','19','Ficha','03','Oferta Del Día','19','Ficha CrossSelling'),
('2191419','Mobile Ficha Ganadoras Ficha CrossSelling','2','Mobile','19','Ficha','14','Ganadoras','19','Ficha CrossSelling'),
('4190019','App Consultora Ficha Ofertas Para Ti Ficha CrossSelling','4','App Consultora','19','Ficha','00','Ofertas Para Ti','19','Ficha CrossSelling'),
('4190119','App Consultora Ficha Showroom Ficha CrossSelling','4','App Consultora','19','Ficha','01','Showroom','19','Ficha CrossSelling'),
('4190219','App Consultora Ficha Lanzamientos Ficha CrossSelling','4','App Consultora','19','Ficha','02','Lanzamientos','19','Ficha CrossSelling'),
('4190319','App Consultora Ficha Oferta Del Día Ficha CrossSelling','4','App Consultora','19','Ficha','03','Oferta Del Día','19','Ficha CrossSelling'),
('4191419','App Consultora Ficha Ganadoras Ficha CrossSelling','4','App Consultora','19','Ficha','14','Ganadoras','19','Ficha CrossSelling')



GO
USE BelcorpGuatemala
GO

DELETE FROM [dbo].[OrigenPedidoWeb]
      WHERE [CodOrigenPedidoWeb]
--Origen de Pedido Sugeridos
		in ('1190020','1190120','1190220','1190320','1191420','2190020','2190120','2190220','2190320','2191420','4190020','4190120','4190220','4190320','4191420','1190021','1190121','1190221','1190321','1191421','2190021','2190121','2190221','2190321','2191421','4190021','4190121','4190221','4190321','4191421'
--Origen de Pedido Cros Selling
		,'1190018','1190118','1190218','1190318','1191418','2190018','2190118','2190218','2190318','2191418','4190018','4190118','4190218','4190318','4191418','1190019','1190119','1190219','1190319','1191419','2190019','2190119','2190219','2190319','2191419','4190019','4190119','4190219','4190319','4191419'
)

go

INSERT INTO [dbo].[OrigenPedidoWeb]
           ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
     VALUES
--Origen de Pedido Sugeridos

('1190020','Desktop Ficha Ofertas Para Ti Carrusel Sugeridos','1','Desktop','19','Ficha','00','Ofertas Para Ti','20','Carrusel Sugeridos'),
('1190120','Desktop Ficha Showroom Carrusel Sugeridos','1','Desktop','19','Ficha','01','Showroom','20','Carrusel Sugeridos'),
('1190220','Desktop Ficha Lanzamientos Carrusel Sugeridos','1','Desktop','19','Ficha','02','Lanzamientos','20','Carrusel Sugeridos'),
('1190320','Desktop Ficha Oferta Del Día Carrusel Sugeridos','1','Desktop','19','Ficha','03','Oferta Del Día','20','Carrusel Sugeridos'),
('1191420','Desktop Ficha Ganadoras Carrusel Sugeridos','1','Desktop','19','Ficha','14','Ganadoras','20','Carrusel Sugeridos'),
('2190020','Mobile Ficha Ofertas Para Ti Carrusel Sugeridos','2','Mobile','19','Ficha','00','Ofertas Para Ti','20','Carrusel Sugeridos'),
('2190120','Mobile Ficha Showroom Carrusel Sugeridos','2','Mobile','19','Ficha','01','Showroom','20','Carrusel Sugeridos'),
('2190220','Mobile Ficha Lanzamientos Carrusel Sugeridos','2','Mobile','19','Ficha','02','Lanzamientos','20','Carrusel Sugeridos'),
('2190320','Mobile Ficha Oferta Del Día Carrusel Sugeridos','2','Mobile','19','Ficha','03','Oferta Del Día','20','Carrusel Sugeridos'),
('2191420','Mobile Ficha Ganadoras Carrusel Sugeridos','2','Mobile','19','Ficha','14','Ganadoras','20','Carrusel Sugeridos'),
('4190020','App Consultora Ficha Ofertas Para Ti Carrusel Sugeridos','4','App Consultora','19','Ficha','00','Ofertas Para Ti','20','Carrusel Sugeridos'),
('4190120','App Consultora Ficha Showroom Carrusel Sugeridos','4','App Consultora','19','Ficha','01','Showroom','20','Carrusel Sugeridos'),
('4190220','App Consultora Ficha Lanzamientos Carrusel Sugeridos','4','App Consultora','19','Ficha','02','Lanzamientos','20','Carrusel Sugeridos'),
('4190320','App Consultora Ficha Oferta Del Día Carrusel Sugeridos','4','App Consultora','19','Ficha','03','Oferta Del Día','20','Carrusel Sugeridos'),
('4191420','App Consultora Ficha Ganadoras Carrusel Sugeridos','4','App Consultora','19','Ficha','14','Ganadoras','20','Carrusel Sugeridos'),
('1190021','Desktop Ficha Ofertas Para Ti Ficha Sugeridos','1','Desktop','19','Ficha','00','Ofertas Para Ti','21','Ficha Sugeridos'),
('1190121','Desktop Ficha Showroom Ficha Sugeridos','1','Desktop','19','Ficha','01','Showroom','21','Ficha Sugeridos'),
('1190221','Desktop Ficha Lanzamientos Ficha Sugeridos','1','Desktop','19','Ficha','02','Lanzamientos','21','Ficha Sugeridos'),
('1190321','Desktop Ficha Oferta Del Día Ficha Sugeridos','1','Desktop','19','Ficha','03','Oferta Del Día','21','Ficha Sugeridos'),
('1191421','Desktop Ficha Ganadoras Ficha Sugeridos','1','Desktop','19','Ficha','14','Ganadoras','21','Ficha Sugeridos'),
('2190021','Mobile Ficha Ofertas Para Ti Ficha Sugeridos','2','Mobile','19','Ficha','00','Ofertas Para Ti','21','Ficha Sugeridos'),
('2190121','Mobile Ficha Showroom Ficha Sugeridos','2','Mobile','19','Ficha','01','Showroom','21','Ficha Sugeridos'),
('2190221','Mobile Ficha Lanzamientos Ficha Sugeridos','2','Mobile','19','Ficha','02','Lanzamientos','21','Ficha Sugeridos'),
('2190321','Mobile Ficha Oferta Del Día Ficha Sugeridos','2','Mobile','19','Ficha','03','Oferta Del Día','21','Ficha Sugeridos'),
('2191421','Mobile Ficha Ganadoras Ficha Sugeridos','2','Mobile','19','Ficha','14','Ganadoras','21','Ficha Sugeridos'),
('4190021','App Consultora Ficha Ofertas Para Ti Ficha Sugeridos','4','App Consultora','19','Ficha','00','Ofertas Para Ti','21','Ficha Sugeridos'),
('4190121','App Consultora Ficha Showroom Ficha Sugeridos','4','App Consultora','19','Ficha','01','Showroom','21','Ficha Sugeridos'),
('4190221','App Consultora Ficha Lanzamientos Ficha Sugeridos','4','App Consultora','19','Ficha','02','Lanzamientos','21','Ficha Sugeridos'),
('4190321','App Consultora Ficha Oferta Del Día Ficha Sugeridos','4','App Consultora','19','Ficha','03','Oferta Del Día','21','Ficha Sugeridos'),
('4191421','App Consultora Ficha Ganadoras Ficha Sugeridos','4','App Consultora','19','Ficha','14','Ganadoras','21','Ficha Sugeridos'),


--Origen de Pedido Cros Selling

('1190018','Desktop Ficha Ofertas Para Ti Carrusel CrossSelling','1','Desktop','19','Ficha','00','Ofertas Para Ti','18','Carrusel CrossSelling'),
('1190118','Desktop Ficha Showroom Carrusel CrossSelling','1','Desktop','19','Ficha','01','Showroom','18','Carrusel CrossSelling'),
('1190218','Desktop Ficha Lanzamientos Carrusel CrossSelling','1','Desktop','19','Ficha','02','Lanzamientos','18','Carrusel CrossSelling'),
('1190318','Desktop Ficha Oferta Del Día Carrusel CrossSelling','1','Desktop','19','Ficha','03','Oferta Del Día','18','Carrusel CrossSelling'),
('1191418','Desktop Ficha Ganadoras Carrusel CrossSelling','1','Desktop','19','Ficha','14','Ganadoras','18','Carrusel CrossSelling'),
('2190018','Mobile Ficha Ofertas Para Ti Carrusel CrossSelling','2','Mobile','19','Ficha','00','Ofertas Para Ti','18','Carrusel CrossSelling'),
('2190118','Mobile Ficha Showroom Carrusel CrossSelling','2','Mobile','19','Ficha','01','Showroom','18','Carrusel CrossSelling'),
('2190218','Mobile Ficha Lanzamientos Carrusel CrossSelling','2','Mobile','19','Ficha','02','Lanzamientos','18','Carrusel CrossSelling'),
('2190318','Mobile Ficha Oferta Del Día Carrusel CrossSelling','2','Mobile','19','Ficha','03','Oferta Del Día','18','Carrusel CrossSelling'),
('2191418','Mobile Ficha Ganadoras Carrusel CrossSelling','2','Mobile','19','Ficha','14','Ganadoras','18','Carrusel CrossSelling'),
('4190018','App Consultora Ficha Ofertas Para Ti Carrusel CrossSelling','4','App Consultora','19','Ficha','00','Ofertas Para Ti','18','Carrusel CrossSelling'),
('4190118','App Consultora Ficha Showroom Carrusel CrossSelling','4','App Consultora','19','Ficha','01','Showroom','18','Carrusel CrossSelling'),
('4190218','App Consultora Ficha Lanzamientos Carrusel CrossSelling','4','App Consultora','19','Ficha','02','Lanzamientos','18','Carrusel CrossSelling'),
('4190318','App Consultora Ficha Oferta Del Día Carrusel CrossSelling','4','App Consultora','19','Ficha','03','Oferta Del Día','18','Carrusel CrossSelling'),
('4191418','App Consultora Ficha Ganadoras Carrusel CrossSelling','4','App Consultora','19','Ficha','14','Ganadoras','18','Carrusel CrossSelling'),
('1190019','Desktop Ficha Ofertas Para Ti Ficha CrossSelling','1','Desktop','19','Ficha','00','Ofertas Para Ti','19','Ficha CrossSelling'),
('1190119','Desktop Ficha Showroom Ficha CrossSelling','1','Desktop','19','Ficha','01','Showroom','19','Ficha CrossSelling'),
('1190219','Desktop Ficha Lanzamientos Ficha CrossSelling','1','Desktop','19','Ficha','02','Lanzamientos','19','Ficha CrossSelling'),
('1190319','Desktop Ficha Oferta Del Día Ficha CrossSelling','1','Desktop','19','Ficha','03','Oferta Del Día','19','Ficha CrossSelling'),
('1191419','Desktop Ficha Ganadoras Ficha CrossSelling','1','Desktop','19','Ficha','14','Ganadoras','19','Ficha CrossSelling'),
('2190019','Mobile Ficha Ofertas Para Ti Ficha CrossSelling','2','Mobile','19','Ficha','00','Ofertas Para Ti','19','Ficha CrossSelling'),
('2190119','Mobile Ficha Showroom Ficha CrossSelling','2','Mobile','19','Ficha','01','Showroom','19','Ficha CrossSelling'),
('2190219','Mobile Ficha Lanzamientos Ficha CrossSelling','2','Mobile','19','Ficha','02','Lanzamientos','19','Ficha CrossSelling'),
('2190319','Mobile Ficha Oferta Del Día Ficha CrossSelling','2','Mobile','19','Ficha','03','Oferta Del Día','19','Ficha CrossSelling'),
('2191419','Mobile Ficha Ganadoras Ficha CrossSelling','2','Mobile','19','Ficha','14','Ganadoras','19','Ficha CrossSelling'),
('4190019','App Consultora Ficha Ofertas Para Ti Ficha CrossSelling','4','App Consultora','19','Ficha','00','Ofertas Para Ti','19','Ficha CrossSelling'),
('4190119','App Consultora Ficha Showroom Ficha CrossSelling','4','App Consultora','19','Ficha','01','Showroom','19','Ficha CrossSelling'),
('4190219','App Consultora Ficha Lanzamientos Ficha CrossSelling','4','App Consultora','19','Ficha','02','Lanzamientos','19','Ficha CrossSelling'),
('4190319','App Consultora Ficha Oferta Del Día Ficha CrossSelling','4','App Consultora','19','Ficha','03','Oferta Del Día','19','Ficha CrossSelling'),
('4191419','App Consultora Ficha Ganadoras Ficha CrossSelling','4','App Consultora','19','Ficha','14','Ganadoras','19','Ficha CrossSelling')



GO
USE BelcorpEcuador
GO

DELETE FROM [dbo].[OrigenPedidoWeb]
      WHERE [CodOrigenPedidoWeb]
--Origen de Pedido Sugeridos
		in ('1190020','1190120','1190220','1190320','1191420','2190020','2190120','2190220','2190320','2191420','4190020','4190120','4190220','4190320','4191420','1190021','1190121','1190221','1190321','1191421','2190021','2190121','2190221','2190321','2191421','4190021','4190121','4190221','4190321','4191421'
--Origen de Pedido Cros Selling
		,'1190018','1190118','1190218','1190318','1191418','2190018','2190118','2190218','2190318','2191418','4190018','4190118','4190218','4190318','4191418','1190019','1190119','1190219','1190319','1191419','2190019','2190119','2190219','2190319','2191419','4190019','4190119','4190219','4190319','4191419'
)

go

INSERT INTO [dbo].[OrigenPedidoWeb]
           ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
     VALUES
--Origen de Pedido Sugeridos

('1190020','Desktop Ficha Ofertas Para Ti Carrusel Sugeridos','1','Desktop','19','Ficha','00','Ofertas Para Ti','20','Carrusel Sugeridos'),
('1190120','Desktop Ficha Showroom Carrusel Sugeridos','1','Desktop','19','Ficha','01','Showroom','20','Carrusel Sugeridos'),
('1190220','Desktop Ficha Lanzamientos Carrusel Sugeridos','1','Desktop','19','Ficha','02','Lanzamientos','20','Carrusel Sugeridos'),
('1190320','Desktop Ficha Oferta Del Día Carrusel Sugeridos','1','Desktop','19','Ficha','03','Oferta Del Día','20','Carrusel Sugeridos'),
('1191420','Desktop Ficha Ganadoras Carrusel Sugeridos','1','Desktop','19','Ficha','14','Ganadoras','20','Carrusel Sugeridos'),
('2190020','Mobile Ficha Ofertas Para Ti Carrusel Sugeridos','2','Mobile','19','Ficha','00','Ofertas Para Ti','20','Carrusel Sugeridos'),
('2190120','Mobile Ficha Showroom Carrusel Sugeridos','2','Mobile','19','Ficha','01','Showroom','20','Carrusel Sugeridos'),
('2190220','Mobile Ficha Lanzamientos Carrusel Sugeridos','2','Mobile','19','Ficha','02','Lanzamientos','20','Carrusel Sugeridos'),
('2190320','Mobile Ficha Oferta Del Día Carrusel Sugeridos','2','Mobile','19','Ficha','03','Oferta Del Día','20','Carrusel Sugeridos'),
('2191420','Mobile Ficha Ganadoras Carrusel Sugeridos','2','Mobile','19','Ficha','14','Ganadoras','20','Carrusel Sugeridos'),
('4190020','App Consultora Ficha Ofertas Para Ti Carrusel Sugeridos','4','App Consultora','19','Ficha','00','Ofertas Para Ti','20','Carrusel Sugeridos'),
('4190120','App Consultora Ficha Showroom Carrusel Sugeridos','4','App Consultora','19','Ficha','01','Showroom','20','Carrusel Sugeridos'),
('4190220','App Consultora Ficha Lanzamientos Carrusel Sugeridos','4','App Consultora','19','Ficha','02','Lanzamientos','20','Carrusel Sugeridos'),
('4190320','App Consultora Ficha Oferta Del Día Carrusel Sugeridos','4','App Consultora','19','Ficha','03','Oferta Del Día','20','Carrusel Sugeridos'),
('4191420','App Consultora Ficha Ganadoras Carrusel Sugeridos','4','App Consultora','19','Ficha','14','Ganadoras','20','Carrusel Sugeridos'),
('1190021','Desktop Ficha Ofertas Para Ti Ficha Sugeridos','1','Desktop','19','Ficha','00','Ofertas Para Ti','21','Ficha Sugeridos'),
('1190121','Desktop Ficha Showroom Ficha Sugeridos','1','Desktop','19','Ficha','01','Showroom','21','Ficha Sugeridos'),
('1190221','Desktop Ficha Lanzamientos Ficha Sugeridos','1','Desktop','19','Ficha','02','Lanzamientos','21','Ficha Sugeridos'),
('1190321','Desktop Ficha Oferta Del Día Ficha Sugeridos','1','Desktop','19','Ficha','03','Oferta Del Día','21','Ficha Sugeridos'),
('1191421','Desktop Ficha Ganadoras Ficha Sugeridos','1','Desktop','19','Ficha','14','Ganadoras','21','Ficha Sugeridos'),
('2190021','Mobile Ficha Ofertas Para Ti Ficha Sugeridos','2','Mobile','19','Ficha','00','Ofertas Para Ti','21','Ficha Sugeridos'),
('2190121','Mobile Ficha Showroom Ficha Sugeridos','2','Mobile','19','Ficha','01','Showroom','21','Ficha Sugeridos'),
('2190221','Mobile Ficha Lanzamientos Ficha Sugeridos','2','Mobile','19','Ficha','02','Lanzamientos','21','Ficha Sugeridos'),
('2190321','Mobile Ficha Oferta Del Día Ficha Sugeridos','2','Mobile','19','Ficha','03','Oferta Del Día','21','Ficha Sugeridos'),
('2191421','Mobile Ficha Ganadoras Ficha Sugeridos','2','Mobile','19','Ficha','14','Ganadoras','21','Ficha Sugeridos'),
('4190021','App Consultora Ficha Ofertas Para Ti Ficha Sugeridos','4','App Consultora','19','Ficha','00','Ofertas Para Ti','21','Ficha Sugeridos'),
('4190121','App Consultora Ficha Showroom Ficha Sugeridos','4','App Consultora','19','Ficha','01','Showroom','21','Ficha Sugeridos'),
('4190221','App Consultora Ficha Lanzamientos Ficha Sugeridos','4','App Consultora','19','Ficha','02','Lanzamientos','21','Ficha Sugeridos'),
('4190321','App Consultora Ficha Oferta Del Día Ficha Sugeridos','4','App Consultora','19','Ficha','03','Oferta Del Día','21','Ficha Sugeridos'),
('4191421','App Consultora Ficha Ganadoras Ficha Sugeridos','4','App Consultora','19','Ficha','14','Ganadoras','21','Ficha Sugeridos'),


--Origen de Pedido Cros Selling

('1190018','Desktop Ficha Ofertas Para Ti Carrusel CrossSelling','1','Desktop','19','Ficha','00','Ofertas Para Ti','18','Carrusel CrossSelling'),
('1190118','Desktop Ficha Showroom Carrusel CrossSelling','1','Desktop','19','Ficha','01','Showroom','18','Carrusel CrossSelling'),
('1190218','Desktop Ficha Lanzamientos Carrusel CrossSelling','1','Desktop','19','Ficha','02','Lanzamientos','18','Carrusel CrossSelling'),
('1190318','Desktop Ficha Oferta Del Día Carrusel CrossSelling','1','Desktop','19','Ficha','03','Oferta Del Día','18','Carrusel CrossSelling'),
('1191418','Desktop Ficha Ganadoras Carrusel CrossSelling','1','Desktop','19','Ficha','14','Ganadoras','18','Carrusel CrossSelling'),
('2190018','Mobile Ficha Ofertas Para Ti Carrusel CrossSelling','2','Mobile','19','Ficha','00','Ofertas Para Ti','18','Carrusel CrossSelling'),
('2190118','Mobile Ficha Showroom Carrusel CrossSelling','2','Mobile','19','Ficha','01','Showroom','18','Carrusel CrossSelling'),
('2190218','Mobile Ficha Lanzamientos Carrusel CrossSelling','2','Mobile','19','Ficha','02','Lanzamientos','18','Carrusel CrossSelling'),
('2190318','Mobile Ficha Oferta Del Día Carrusel CrossSelling','2','Mobile','19','Ficha','03','Oferta Del Día','18','Carrusel CrossSelling'),
('2191418','Mobile Ficha Ganadoras Carrusel CrossSelling','2','Mobile','19','Ficha','14','Ganadoras','18','Carrusel CrossSelling'),
('4190018','App Consultora Ficha Ofertas Para Ti Carrusel CrossSelling','4','App Consultora','19','Ficha','00','Ofertas Para Ti','18','Carrusel CrossSelling'),
('4190118','App Consultora Ficha Showroom Carrusel CrossSelling','4','App Consultora','19','Ficha','01','Showroom','18','Carrusel CrossSelling'),
('4190218','App Consultora Ficha Lanzamientos Carrusel CrossSelling','4','App Consultora','19','Ficha','02','Lanzamientos','18','Carrusel CrossSelling'),
('4190318','App Consultora Ficha Oferta Del Día Carrusel CrossSelling','4','App Consultora','19','Ficha','03','Oferta Del Día','18','Carrusel CrossSelling'),
('4191418','App Consultora Ficha Ganadoras Carrusel CrossSelling','4','App Consultora','19','Ficha','14','Ganadoras','18','Carrusel CrossSelling'),
('1190019','Desktop Ficha Ofertas Para Ti Ficha CrossSelling','1','Desktop','19','Ficha','00','Ofertas Para Ti','19','Ficha CrossSelling'),
('1190119','Desktop Ficha Showroom Ficha CrossSelling','1','Desktop','19','Ficha','01','Showroom','19','Ficha CrossSelling'),
('1190219','Desktop Ficha Lanzamientos Ficha CrossSelling','1','Desktop','19','Ficha','02','Lanzamientos','19','Ficha CrossSelling'),
('1190319','Desktop Ficha Oferta Del Día Ficha CrossSelling','1','Desktop','19','Ficha','03','Oferta Del Día','19','Ficha CrossSelling'),
('1191419','Desktop Ficha Ganadoras Ficha CrossSelling','1','Desktop','19','Ficha','14','Ganadoras','19','Ficha CrossSelling'),
('2190019','Mobile Ficha Ofertas Para Ti Ficha CrossSelling','2','Mobile','19','Ficha','00','Ofertas Para Ti','19','Ficha CrossSelling'),
('2190119','Mobile Ficha Showroom Ficha CrossSelling','2','Mobile','19','Ficha','01','Showroom','19','Ficha CrossSelling'),
('2190219','Mobile Ficha Lanzamientos Ficha CrossSelling','2','Mobile','19','Ficha','02','Lanzamientos','19','Ficha CrossSelling'),
('2190319','Mobile Ficha Oferta Del Día Ficha CrossSelling','2','Mobile','19','Ficha','03','Oferta Del Día','19','Ficha CrossSelling'),
('2191419','Mobile Ficha Ganadoras Ficha CrossSelling','2','Mobile','19','Ficha','14','Ganadoras','19','Ficha CrossSelling'),
('4190019','App Consultora Ficha Ofertas Para Ti Ficha CrossSelling','4','App Consultora','19','Ficha','00','Ofertas Para Ti','19','Ficha CrossSelling'),
('4190119','App Consultora Ficha Showroom Ficha CrossSelling','4','App Consultora','19','Ficha','01','Showroom','19','Ficha CrossSelling'),
('4190219','App Consultora Ficha Lanzamientos Ficha CrossSelling','4','App Consultora','19','Ficha','02','Lanzamientos','19','Ficha CrossSelling'),
('4190319','App Consultora Ficha Oferta Del Día Ficha CrossSelling','4','App Consultora','19','Ficha','03','Oferta Del Día','19','Ficha CrossSelling'),
('4191419','App Consultora Ficha Ganadoras Ficha CrossSelling','4','App Consultora','19','Ficha','14','Ganadoras','19','Ficha CrossSelling')


GO
USE BelcorpDominicana
GO

DELETE FROM [dbo].[OrigenPedidoWeb]
      WHERE [CodOrigenPedidoWeb]
--Origen de Pedido Sugeridos
		in ('1190020','1190120','1190220','1190320','1191420','2190020','2190120','2190220','2190320','2191420','4190020','4190120','4190220','4190320','4191420','1190021','1190121','1190221','1190321','1191421','2190021','2190121','2190221','2190321','2191421','4190021','4190121','4190221','4190321','4191421'
--Origen de Pedido Cros Selling
		,'1190018','1190118','1190218','1190318','1191418','2190018','2190118','2190218','2190318','2191418','4190018','4190118','4190218','4190318','4191418','1190019','1190119','1190219','1190319','1191419','2190019','2190119','2190219','2190319','2191419','4190019','4190119','4190219','4190319','4191419'
)

go

INSERT INTO [dbo].[OrigenPedidoWeb]
           ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
     VALUES
--Origen de Pedido Sugeridos

('1190020','Desktop Ficha Ofertas Para Ti Carrusel Sugeridos','1','Desktop','19','Ficha','00','Ofertas Para Ti','20','Carrusel Sugeridos'),
('1190120','Desktop Ficha Showroom Carrusel Sugeridos','1','Desktop','19','Ficha','01','Showroom','20','Carrusel Sugeridos'),
('1190220','Desktop Ficha Lanzamientos Carrusel Sugeridos','1','Desktop','19','Ficha','02','Lanzamientos','20','Carrusel Sugeridos'),
('1190320','Desktop Ficha Oferta Del Día Carrusel Sugeridos','1','Desktop','19','Ficha','03','Oferta Del Día','20','Carrusel Sugeridos'),
('1191420','Desktop Ficha Ganadoras Carrusel Sugeridos','1','Desktop','19','Ficha','14','Ganadoras','20','Carrusel Sugeridos'),
('2190020','Mobile Ficha Ofertas Para Ti Carrusel Sugeridos','2','Mobile','19','Ficha','00','Ofertas Para Ti','20','Carrusel Sugeridos'),
('2190120','Mobile Ficha Showroom Carrusel Sugeridos','2','Mobile','19','Ficha','01','Showroom','20','Carrusel Sugeridos'),
('2190220','Mobile Ficha Lanzamientos Carrusel Sugeridos','2','Mobile','19','Ficha','02','Lanzamientos','20','Carrusel Sugeridos'),
('2190320','Mobile Ficha Oferta Del Día Carrusel Sugeridos','2','Mobile','19','Ficha','03','Oferta Del Día','20','Carrusel Sugeridos'),
('2191420','Mobile Ficha Ganadoras Carrusel Sugeridos','2','Mobile','19','Ficha','14','Ganadoras','20','Carrusel Sugeridos'),
('4190020','App Consultora Ficha Ofertas Para Ti Carrusel Sugeridos','4','App Consultora','19','Ficha','00','Ofertas Para Ti','20','Carrusel Sugeridos'),
('4190120','App Consultora Ficha Showroom Carrusel Sugeridos','4','App Consultora','19','Ficha','01','Showroom','20','Carrusel Sugeridos'),
('4190220','App Consultora Ficha Lanzamientos Carrusel Sugeridos','4','App Consultora','19','Ficha','02','Lanzamientos','20','Carrusel Sugeridos'),
('4190320','App Consultora Ficha Oferta Del Día Carrusel Sugeridos','4','App Consultora','19','Ficha','03','Oferta Del Día','20','Carrusel Sugeridos'),
('4191420','App Consultora Ficha Ganadoras Carrusel Sugeridos','4','App Consultora','19','Ficha','14','Ganadoras','20','Carrusel Sugeridos'),
('1190021','Desktop Ficha Ofertas Para Ti Ficha Sugeridos','1','Desktop','19','Ficha','00','Ofertas Para Ti','21','Ficha Sugeridos'),
('1190121','Desktop Ficha Showroom Ficha Sugeridos','1','Desktop','19','Ficha','01','Showroom','21','Ficha Sugeridos'),
('1190221','Desktop Ficha Lanzamientos Ficha Sugeridos','1','Desktop','19','Ficha','02','Lanzamientos','21','Ficha Sugeridos'),
('1190321','Desktop Ficha Oferta Del Día Ficha Sugeridos','1','Desktop','19','Ficha','03','Oferta Del Día','21','Ficha Sugeridos'),
('1191421','Desktop Ficha Ganadoras Ficha Sugeridos','1','Desktop','19','Ficha','14','Ganadoras','21','Ficha Sugeridos'),
('2190021','Mobile Ficha Ofertas Para Ti Ficha Sugeridos','2','Mobile','19','Ficha','00','Ofertas Para Ti','21','Ficha Sugeridos'),
('2190121','Mobile Ficha Showroom Ficha Sugeridos','2','Mobile','19','Ficha','01','Showroom','21','Ficha Sugeridos'),
('2190221','Mobile Ficha Lanzamientos Ficha Sugeridos','2','Mobile','19','Ficha','02','Lanzamientos','21','Ficha Sugeridos'),
('2190321','Mobile Ficha Oferta Del Día Ficha Sugeridos','2','Mobile','19','Ficha','03','Oferta Del Día','21','Ficha Sugeridos'),
('2191421','Mobile Ficha Ganadoras Ficha Sugeridos','2','Mobile','19','Ficha','14','Ganadoras','21','Ficha Sugeridos'),
('4190021','App Consultora Ficha Ofertas Para Ti Ficha Sugeridos','4','App Consultora','19','Ficha','00','Ofertas Para Ti','21','Ficha Sugeridos'),
('4190121','App Consultora Ficha Showroom Ficha Sugeridos','4','App Consultora','19','Ficha','01','Showroom','21','Ficha Sugeridos'),
('4190221','App Consultora Ficha Lanzamientos Ficha Sugeridos','4','App Consultora','19','Ficha','02','Lanzamientos','21','Ficha Sugeridos'),
('4190321','App Consultora Ficha Oferta Del Día Ficha Sugeridos','4','App Consultora','19','Ficha','03','Oferta Del Día','21','Ficha Sugeridos'),
('4191421','App Consultora Ficha Ganadoras Ficha Sugeridos','4','App Consultora','19','Ficha','14','Ganadoras','21','Ficha Sugeridos'),


--Origen de Pedido Cros Selling

('1190018','Desktop Ficha Ofertas Para Ti Carrusel CrossSelling','1','Desktop','19','Ficha','00','Ofertas Para Ti','18','Carrusel CrossSelling'),
('1190118','Desktop Ficha Showroom Carrusel CrossSelling','1','Desktop','19','Ficha','01','Showroom','18','Carrusel CrossSelling'),
('1190218','Desktop Ficha Lanzamientos Carrusel CrossSelling','1','Desktop','19','Ficha','02','Lanzamientos','18','Carrusel CrossSelling'),
('1190318','Desktop Ficha Oferta Del Día Carrusel CrossSelling','1','Desktop','19','Ficha','03','Oferta Del Día','18','Carrusel CrossSelling'),
('1191418','Desktop Ficha Ganadoras Carrusel CrossSelling','1','Desktop','19','Ficha','14','Ganadoras','18','Carrusel CrossSelling'),
('2190018','Mobile Ficha Ofertas Para Ti Carrusel CrossSelling','2','Mobile','19','Ficha','00','Ofertas Para Ti','18','Carrusel CrossSelling'),
('2190118','Mobile Ficha Showroom Carrusel CrossSelling','2','Mobile','19','Ficha','01','Showroom','18','Carrusel CrossSelling'),
('2190218','Mobile Ficha Lanzamientos Carrusel CrossSelling','2','Mobile','19','Ficha','02','Lanzamientos','18','Carrusel CrossSelling'),
('2190318','Mobile Ficha Oferta Del Día Carrusel CrossSelling','2','Mobile','19','Ficha','03','Oferta Del Día','18','Carrusel CrossSelling'),
('2191418','Mobile Ficha Ganadoras Carrusel CrossSelling','2','Mobile','19','Ficha','14','Ganadoras','18','Carrusel CrossSelling'),
('4190018','App Consultora Ficha Ofertas Para Ti Carrusel CrossSelling','4','App Consultora','19','Ficha','00','Ofertas Para Ti','18','Carrusel CrossSelling'),
('4190118','App Consultora Ficha Showroom Carrusel CrossSelling','4','App Consultora','19','Ficha','01','Showroom','18','Carrusel CrossSelling'),
('4190218','App Consultora Ficha Lanzamientos Carrusel CrossSelling','4','App Consultora','19','Ficha','02','Lanzamientos','18','Carrusel CrossSelling'),
('4190318','App Consultora Ficha Oferta Del Día Carrusel CrossSelling','4','App Consultora','19','Ficha','03','Oferta Del Día','18','Carrusel CrossSelling'),
('4191418','App Consultora Ficha Ganadoras Carrusel CrossSelling','4','App Consultora','19','Ficha','14','Ganadoras','18','Carrusel CrossSelling'),
('1190019','Desktop Ficha Ofertas Para Ti Ficha CrossSelling','1','Desktop','19','Ficha','00','Ofertas Para Ti','19','Ficha CrossSelling'),
('1190119','Desktop Ficha Showroom Ficha CrossSelling','1','Desktop','19','Ficha','01','Showroom','19','Ficha CrossSelling'),
('1190219','Desktop Ficha Lanzamientos Ficha CrossSelling','1','Desktop','19','Ficha','02','Lanzamientos','19','Ficha CrossSelling'),
('1190319','Desktop Ficha Oferta Del Día Ficha CrossSelling','1','Desktop','19','Ficha','03','Oferta Del Día','19','Ficha CrossSelling'),
('1191419','Desktop Ficha Ganadoras Ficha CrossSelling','1','Desktop','19','Ficha','14','Ganadoras','19','Ficha CrossSelling'),
('2190019','Mobile Ficha Ofertas Para Ti Ficha CrossSelling','2','Mobile','19','Ficha','00','Ofertas Para Ti','19','Ficha CrossSelling'),
('2190119','Mobile Ficha Showroom Ficha CrossSelling','2','Mobile','19','Ficha','01','Showroom','19','Ficha CrossSelling'),
('2190219','Mobile Ficha Lanzamientos Ficha CrossSelling','2','Mobile','19','Ficha','02','Lanzamientos','19','Ficha CrossSelling'),
('2190319','Mobile Ficha Oferta Del Día Ficha CrossSelling','2','Mobile','19','Ficha','03','Oferta Del Día','19','Ficha CrossSelling'),
('2191419','Mobile Ficha Ganadoras Ficha CrossSelling','2','Mobile','19','Ficha','14','Ganadoras','19','Ficha CrossSelling'),
('4190019','App Consultora Ficha Ofertas Para Ti Ficha CrossSelling','4','App Consultora','19','Ficha','00','Ofertas Para Ti','19','Ficha CrossSelling'),
('4190119','App Consultora Ficha Showroom Ficha CrossSelling','4','App Consultora','19','Ficha','01','Showroom','19','Ficha CrossSelling'),
('4190219','App Consultora Ficha Lanzamientos Ficha CrossSelling','4','App Consultora','19','Ficha','02','Lanzamientos','19','Ficha CrossSelling'),
('4190319','App Consultora Ficha Oferta Del Día Ficha CrossSelling','4','App Consultora','19','Ficha','03','Oferta Del Día','19','Ficha CrossSelling'),
('4191419','App Consultora Ficha Ganadoras Ficha CrossSelling','4','App Consultora','19','Ficha','14','Ganadoras','19','Ficha CrossSelling')



GO
USE BelcorpCostaRica
GO

DELETE FROM [dbo].[OrigenPedidoWeb]
      WHERE [CodOrigenPedidoWeb]
--Origen de Pedido Sugeridos
		in ('1190020','1190120','1190220','1190320','1191420','2190020','2190120','2190220','2190320','2191420','4190020','4190120','4190220','4190320','4191420','1190021','1190121','1190221','1190321','1191421','2190021','2190121','2190221','2190321','2191421','4190021','4190121','4190221','4190321','4191421'
--Origen de Pedido Cros Selling
		,'1190018','1190118','1190218','1190318','1191418','2190018','2190118','2190218','2190318','2191418','4190018','4190118','4190218','4190318','4191418','1190019','1190119','1190219','1190319','1191419','2190019','2190119','2190219','2190319','2191419','4190019','4190119','4190219','4190319','4191419'
)

go

INSERT INTO [dbo].[OrigenPedidoWeb]
           ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
     VALUES
--Origen de Pedido Sugeridos

('1190020','Desktop Ficha Ofertas Para Ti Carrusel Sugeridos','1','Desktop','19','Ficha','00','Ofertas Para Ti','20','Carrusel Sugeridos'),
('1190120','Desktop Ficha Showroom Carrusel Sugeridos','1','Desktop','19','Ficha','01','Showroom','20','Carrusel Sugeridos'),
('1190220','Desktop Ficha Lanzamientos Carrusel Sugeridos','1','Desktop','19','Ficha','02','Lanzamientos','20','Carrusel Sugeridos'),
('1190320','Desktop Ficha Oferta Del Día Carrusel Sugeridos','1','Desktop','19','Ficha','03','Oferta Del Día','20','Carrusel Sugeridos'),
('1191420','Desktop Ficha Ganadoras Carrusel Sugeridos','1','Desktop','19','Ficha','14','Ganadoras','20','Carrusel Sugeridos'),
('2190020','Mobile Ficha Ofertas Para Ti Carrusel Sugeridos','2','Mobile','19','Ficha','00','Ofertas Para Ti','20','Carrusel Sugeridos'),
('2190120','Mobile Ficha Showroom Carrusel Sugeridos','2','Mobile','19','Ficha','01','Showroom','20','Carrusel Sugeridos'),
('2190220','Mobile Ficha Lanzamientos Carrusel Sugeridos','2','Mobile','19','Ficha','02','Lanzamientos','20','Carrusel Sugeridos'),
('2190320','Mobile Ficha Oferta Del Día Carrusel Sugeridos','2','Mobile','19','Ficha','03','Oferta Del Día','20','Carrusel Sugeridos'),
('2191420','Mobile Ficha Ganadoras Carrusel Sugeridos','2','Mobile','19','Ficha','14','Ganadoras','20','Carrusel Sugeridos'),
('4190020','App Consultora Ficha Ofertas Para Ti Carrusel Sugeridos','4','App Consultora','19','Ficha','00','Ofertas Para Ti','20','Carrusel Sugeridos'),
('4190120','App Consultora Ficha Showroom Carrusel Sugeridos','4','App Consultora','19','Ficha','01','Showroom','20','Carrusel Sugeridos'),
('4190220','App Consultora Ficha Lanzamientos Carrusel Sugeridos','4','App Consultora','19','Ficha','02','Lanzamientos','20','Carrusel Sugeridos'),
('4190320','App Consultora Ficha Oferta Del Día Carrusel Sugeridos','4','App Consultora','19','Ficha','03','Oferta Del Día','20','Carrusel Sugeridos'),
('4191420','App Consultora Ficha Ganadoras Carrusel Sugeridos','4','App Consultora','19','Ficha','14','Ganadoras','20','Carrusel Sugeridos'),
('1190021','Desktop Ficha Ofertas Para Ti Ficha Sugeridos','1','Desktop','19','Ficha','00','Ofertas Para Ti','21','Ficha Sugeridos'),
('1190121','Desktop Ficha Showroom Ficha Sugeridos','1','Desktop','19','Ficha','01','Showroom','21','Ficha Sugeridos'),
('1190221','Desktop Ficha Lanzamientos Ficha Sugeridos','1','Desktop','19','Ficha','02','Lanzamientos','21','Ficha Sugeridos'),
('1190321','Desktop Ficha Oferta Del Día Ficha Sugeridos','1','Desktop','19','Ficha','03','Oferta Del Día','21','Ficha Sugeridos'),
('1191421','Desktop Ficha Ganadoras Ficha Sugeridos','1','Desktop','19','Ficha','14','Ganadoras','21','Ficha Sugeridos'),
('2190021','Mobile Ficha Ofertas Para Ti Ficha Sugeridos','2','Mobile','19','Ficha','00','Ofertas Para Ti','21','Ficha Sugeridos'),
('2190121','Mobile Ficha Showroom Ficha Sugeridos','2','Mobile','19','Ficha','01','Showroom','21','Ficha Sugeridos'),
('2190221','Mobile Ficha Lanzamientos Ficha Sugeridos','2','Mobile','19','Ficha','02','Lanzamientos','21','Ficha Sugeridos'),
('2190321','Mobile Ficha Oferta Del Día Ficha Sugeridos','2','Mobile','19','Ficha','03','Oferta Del Día','21','Ficha Sugeridos'),
('2191421','Mobile Ficha Ganadoras Ficha Sugeridos','2','Mobile','19','Ficha','14','Ganadoras','21','Ficha Sugeridos'),
('4190021','App Consultora Ficha Ofertas Para Ti Ficha Sugeridos','4','App Consultora','19','Ficha','00','Ofertas Para Ti','21','Ficha Sugeridos'),
('4190121','App Consultora Ficha Showroom Ficha Sugeridos','4','App Consultora','19','Ficha','01','Showroom','21','Ficha Sugeridos'),
('4190221','App Consultora Ficha Lanzamientos Ficha Sugeridos','4','App Consultora','19','Ficha','02','Lanzamientos','21','Ficha Sugeridos'),
('4190321','App Consultora Ficha Oferta Del Día Ficha Sugeridos','4','App Consultora','19','Ficha','03','Oferta Del Día','21','Ficha Sugeridos'),
('4191421','App Consultora Ficha Ganadoras Ficha Sugeridos','4','App Consultora','19','Ficha','14','Ganadoras','21','Ficha Sugeridos'),


--Origen de Pedido Cros Selling

('1190018','Desktop Ficha Ofertas Para Ti Carrusel CrossSelling','1','Desktop','19','Ficha','00','Ofertas Para Ti','18','Carrusel CrossSelling'),
('1190118','Desktop Ficha Showroom Carrusel CrossSelling','1','Desktop','19','Ficha','01','Showroom','18','Carrusel CrossSelling'),
('1190218','Desktop Ficha Lanzamientos Carrusel CrossSelling','1','Desktop','19','Ficha','02','Lanzamientos','18','Carrusel CrossSelling'),
('1190318','Desktop Ficha Oferta Del Día Carrusel CrossSelling','1','Desktop','19','Ficha','03','Oferta Del Día','18','Carrusel CrossSelling'),
('1191418','Desktop Ficha Ganadoras Carrusel CrossSelling','1','Desktop','19','Ficha','14','Ganadoras','18','Carrusel CrossSelling'),
('2190018','Mobile Ficha Ofertas Para Ti Carrusel CrossSelling','2','Mobile','19','Ficha','00','Ofertas Para Ti','18','Carrusel CrossSelling'),
('2190118','Mobile Ficha Showroom Carrusel CrossSelling','2','Mobile','19','Ficha','01','Showroom','18','Carrusel CrossSelling'),
('2190218','Mobile Ficha Lanzamientos Carrusel CrossSelling','2','Mobile','19','Ficha','02','Lanzamientos','18','Carrusel CrossSelling'),
('2190318','Mobile Ficha Oferta Del Día Carrusel CrossSelling','2','Mobile','19','Ficha','03','Oferta Del Día','18','Carrusel CrossSelling'),
('2191418','Mobile Ficha Ganadoras Carrusel CrossSelling','2','Mobile','19','Ficha','14','Ganadoras','18','Carrusel CrossSelling'),
('4190018','App Consultora Ficha Ofertas Para Ti Carrusel CrossSelling','4','App Consultora','19','Ficha','00','Ofertas Para Ti','18','Carrusel CrossSelling'),
('4190118','App Consultora Ficha Showroom Carrusel CrossSelling','4','App Consultora','19','Ficha','01','Showroom','18','Carrusel CrossSelling'),
('4190218','App Consultora Ficha Lanzamientos Carrusel CrossSelling','4','App Consultora','19','Ficha','02','Lanzamientos','18','Carrusel CrossSelling'),
('4190318','App Consultora Ficha Oferta Del Día Carrusel CrossSelling','4','App Consultora','19','Ficha','03','Oferta Del Día','18','Carrusel CrossSelling'),
('4191418','App Consultora Ficha Ganadoras Carrusel CrossSelling','4','App Consultora','19','Ficha','14','Ganadoras','18','Carrusel CrossSelling'),
('1190019','Desktop Ficha Ofertas Para Ti Ficha CrossSelling','1','Desktop','19','Ficha','00','Ofertas Para Ti','19','Ficha CrossSelling'),
('1190119','Desktop Ficha Showroom Ficha CrossSelling','1','Desktop','19','Ficha','01','Showroom','19','Ficha CrossSelling'),
('1190219','Desktop Ficha Lanzamientos Ficha CrossSelling','1','Desktop','19','Ficha','02','Lanzamientos','19','Ficha CrossSelling'),
('1190319','Desktop Ficha Oferta Del Día Ficha CrossSelling','1','Desktop','19','Ficha','03','Oferta Del Día','19','Ficha CrossSelling'),
('1191419','Desktop Ficha Ganadoras Ficha CrossSelling','1','Desktop','19','Ficha','14','Ganadoras','19','Ficha CrossSelling'),
('2190019','Mobile Ficha Ofertas Para Ti Ficha CrossSelling','2','Mobile','19','Ficha','00','Ofertas Para Ti','19','Ficha CrossSelling'),
('2190119','Mobile Ficha Showroom Ficha CrossSelling','2','Mobile','19','Ficha','01','Showroom','19','Ficha CrossSelling'),
('2190219','Mobile Ficha Lanzamientos Ficha CrossSelling','2','Mobile','19','Ficha','02','Lanzamientos','19','Ficha CrossSelling'),
('2190319','Mobile Ficha Oferta Del Día Ficha CrossSelling','2','Mobile','19','Ficha','03','Oferta Del Día','19','Ficha CrossSelling'),
('2191419','Mobile Ficha Ganadoras Ficha CrossSelling','2','Mobile','19','Ficha','14','Ganadoras','19','Ficha CrossSelling'),
('4190019','App Consultora Ficha Ofertas Para Ti Ficha CrossSelling','4','App Consultora','19','Ficha','00','Ofertas Para Ti','19','Ficha CrossSelling'),
('4190119','App Consultora Ficha Showroom Ficha CrossSelling','4','App Consultora','19','Ficha','01','Showroom','19','Ficha CrossSelling'),
('4190219','App Consultora Ficha Lanzamientos Ficha CrossSelling','4','App Consultora','19','Ficha','02','Lanzamientos','19','Ficha CrossSelling'),
('4190319','App Consultora Ficha Oferta Del Día Ficha CrossSelling','4','App Consultora','19','Ficha','03','Oferta Del Día','19','Ficha CrossSelling'),
('4191419','App Consultora Ficha Ganadoras Ficha CrossSelling','4','App Consultora','19','Ficha','14','Ganadoras','19','Ficha CrossSelling')



GO
USE BelcorpChile
GO

DELETE FROM [dbo].[OrigenPedidoWeb]
      WHERE [CodOrigenPedidoWeb]
--Origen de Pedido Sugeridos
		in ('1190020','1190120','1190220','1190320','1191420','2190020','2190120','2190220','2190320','2191420','4190020','4190120','4190220','4190320','4191420','1190021','1190121','1190221','1190321','1191421','2190021','2190121','2190221','2190321','2191421','4190021','4190121','4190221','4190321','4191421'
--Origen de Pedido Cros Selling
		,'1190018','1190118','1190218','1190318','1191418','2190018','2190118','2190218','2190318','2191418','4190018','4190118','4190218','4190318','4191418','1190019','1190119','1190219','1190319','1191419','2190019','2190119','2190219','2190319','2191419','4190019','4190119','4190219','4190319','4191419'
)

go

INSERT INTO [dbo].[OrigenPedidoWeb]
           ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
     VALUES
--Origen de Pedido Sugeridos

('1190020','Desktop Ficha Ofertas Para Ti Carrusel Sugeridos','1','Desktop','19','Ficha','00','Ofertas Para Ti','20','Carrusel Sugeridos'),
('1190120','Desktop Ficha Showroom Carrusel Sugeridos','1','Desktop','19','Ficha','01','Showroom','20','Carrusel Sugeridos'),
('1190220','Desktop Ficha Lanzamientos Carrusel Sugeridos','1','Desktop','19','Ficha','02','Lanzamientos','20','Carrusel Sugeridos'),
('1190320','Desktop Ficha Oferta Del Día Carrusel Sugeridos','1','Desktop','19','Ficha','03','Oferta Del Día','20','Carrusel Sugeridos'),
('1191420','Desktop Ficha Ganadoras Carrusel Sugeridos','1','Desktop','19','Ficha','14','Ganadoras','20','Carrusel Sugeridos'),
('2190020','Mobile Ficha Ofertas Para Ti Carrusel Sugeridos','2','Mobile','19','Ficha','00','Ofertas Para Ti','20','Carrusel Sugeridos'),
('2190120','Mobile Ficha Showroom Carrusel Sugeridos','2','Mobile','19','Ficha','01','Showroom','20','Carrusel Sugeridos'),
('2190220','Mobile Ficha Lanzamientos Carrusel Sugeridos','2','Mobile','19','Ficha','02','Lanzamientos','20','Carrusel Sugeridos'),
('2190320','Mobile Ficha Oferta Del Día Carrusel Sugeridos','2','Mobile','19','Ficha','03','Oferta Del Día','20','Carrusel Sugeridos'),
('2191420','Mobile Ficha Ganadoras Carrusel Sugeridos','2','Mobile','19','Ficha','14','Ganadoras','20','Carrusel Sugeridos'),
('4190020','App Consultora Ficha Ofertas Para Ti Carrusel Sugeridos','4','App Consultora','19','Ficha','00','Ofertas Para Ti','20','Carrusel Sugeridos'),
('4190120','App Consultora Ficha Showroom Carrusel Sugeridos','4','App Consultora','19','Ficha','01','Showroom','20','Carrusel Sugeridos'),
('4190220','App Consultora Ficha Lanzamientos Carrusel Sugeridos','4','App Consultora','19','Ficha','02','Lanzamientos','20','Carrusel Sugeridos'),
('4190320','App Consultora Ficha Oferta Del Día Carrusel Sugeridos','4','App Consultora','19','Ficha','03','Oferta Del Día','20','Carrusel Sugeridos'),
('4191420','App Consultora Ficha Ganadoras Carrusel Sugeridos','4','App Consultora','19','Ficha','14','Ganadoras','20','Carrusel Sugeridos'),
('1190021','Desktop Ficha Ofertas Para Ti Ficha Sugeridos','1','Desktop','19','Ficha','00','Ofertas Para Ti','21','Ficha Sugeridos'),
('1190121','Desktop Ficha Showroom Ficha Sugeridos','1','Desktop','19','Ficha','01','Showroom','21','Ficha Sugeridos'),
('1190221','Desktop Ficha Lanzamientos Ficha Sugeridos','1','Desktop','19','Ficha','02','Lanzamientos','21','Ficha Sugeridos'),
('1190321','Desktop Ficha Oferta Del Día Ficha Sugeridos','1','Desktop','19','Ficha','03','Oferta Del Día','21','Ficha Sugeridos'),
('1191421','Desktop Ficha Ganadoras Ficha Sugeridos','1','Desktop','19','Ficha','14','Ganadoras','21','Ficha Sugeridos'),
('2190021','Mobile Ficha Ofertas Para Ti Ficha Sugeridos','2','Mobile','19','Ficha','00','Ofertas Para Ti','21','Ficha Sugeridos'),
('2190121','Mobile Ficha Showroom Ficha Sugeridos','2','Mobile','19','Ficha','01','Showroom','21','Ficha Sugeridos'),
('2190221','Mobile Ficha Lanzamientos Ficha Sugeridos','2','Mobile','19','Ficha','02','Lanzamientos','21','Ficha Sugeridos'),
('2190321','Mobile Ficha Oferta Del Día Ficha Sugeridos','2','Mobile','19','Ficha','03','Oferta Del Día','21','Ficha Sugeridos'),
('2191421','Mobile Ficha Ganadoras Ficha Sugeridos','2','Mobile','19','Ficha','14','Ganadoras','21','Ficha Sugeridos'),
('4190021','App Consultora Ficha Ofertas Para Ti Ficha Sugeridos','4','App Consultora','19','Ficha','00','Ofertas Para Ti','21','Ficha Sugeridos'),
('4190121','App Consultora Ficha Showroom Ficha Sugeridos','4','App Consultora','19','Ficha','01','Showroom','21','Ficha Sugeridos'),
('4190221','App Consultora Ficha Lanzamientos Ficha Sugeridos','4','App Consultora','19','Ficha','02','Lanzamientos','21','Ficha Sugeridos'),
('4190321','App Consultora Ficha Oferta Del Día Ficha Sugeridos','4','App Consultora','19','Ficha','03','Oferta Del Día','21','Ficha Sugeridos'),
('4191421','App Consultora Ficha Ganadoras Ficha Sugeridos','4','App Consultora','19','Ficha','14','Ganadoras','21','Ficha Sugeridos'),


--Origen de Pedido Cros Selling

('1190018','Desktop Ficha Ofertas Para Ti Carrusel CrossSelling','1','Desktop','19','Ficha','00','Ofertas Para Ti','18','Carrusel CrossSelling'),
('1190118','Desktop Ficha Showroom Carrusel CrossSelling','1','Desktop','19','Ficha','01','Showroom','18','Carrusel CrossSelling'),
('1190218','Desktop Ficha Lanzamientos Carrusel CrossSelling','1','Desktop','19','Ficha','02','Lanzamientos','18','Carrusel CrossSelling'),
('1190318','Desktop Ficha Oferta Del Día Carrusel CrossSelling','1','Desktop','19','Ficha','03','Oferta Del Día','18','Carrusel CrossSelling'),
('1191418','Desktop Ficha Ganadoras Carrusel CrossSelling','1','Desktop','19','Ficha','14','Ganadoras','18','Carrusel CrossSelling'),
('2190018','Mobile Ficha Ofertas Para Ti Carrusel CrossSelling','2','Mobile','19','Ficha','00','Ofertas Para Ti','18','Carrusel CrossSelling'),
('2190118','Mobile Ficha Showroom Carrusel CrossSelling','2','Mobile','19','Ficha','01','Showroom','18','Carrusel CrossSelling'),
('2190218','Mobile Ficha Lanzamientos Carrusel CrossSelling','2','Mobile','19','Ficha','02','Lanzamientos','18','Carrusel CrossSelling'),
('2190318','Mobile Ficha Oferta Del Día Carrusel CrossSelling','2','Mobile','19','Ficha','03','Oferta Del Día','18','Carrusel CrossSelling'),
('2191418','Mobile Ficha Ganadoras Carrusel CrossSelling','2','Mobile','19','Ficha','14','Ganadoras','18','Carrusel CrossSelling'),
('4190018','App Consultora Ficha Ofertas Para Ti Carrusel CrossSelling','4','App Consultora','19','Ficha','00','Ofertas Para Ti','18','Carrusel CrossSelling'),
('4190118','App Consultora Ficha Showroom Carrusel CrossSelling','4','App Consultora','19','Ficha','01','Showroom','18','Carrusel CrossSelling'),
('4190218','App Consultora Ficha Lanzamientos Carrusel CrossSelling','4','App Consultora','19','Ficha','02','Lanzamientos','18','Carrusel CrossSelling'),
('4190318','App Consultora Ficha Oferta Del Día Carrusel CrossSelling','4','App Consultora','19','Ficha','03','Oferta Del Día','18','Carrusel CrossSelling'),
('4191418','App Consultora Ficha Ganadoras Carrusel CrossSelling','4','App Consultora','19','Ficha','14','Ganadoras','18','Carrusel CrossSelling'),
('1190019','Desktop Ficha Ofertas Para Ti Ficha CrossSelling','1','Desktop','19','Ficha','00','Ofertas Para Ti','19','Ficha CrossSelling'),
('1190119','Desktop Ficha Showroom Ficha CrossSelling','1','Desktop','19','Ficha','01','Showroom','19','Ficha CrossSelling'),
('1190219','Desktop Ficha Lanzamientos Ficha CrossSelling','1','Desktop','19','Ficha','02','Lanzamientos','19','Ficha CrossSelling'),
('1190319','Desktop Ficha Oferta Del Día Ficha CrossSelling','1','Desktop','19','Ficha','03','Oferta Del Día','19','Ficha CrossSelling'),
('1191419','Desktop Ficha Ganadoras Ficha CrossSelling','1','Desktop','19','Ficha','14','Ganadoras','19','Ficha CrossSelling'),
('2190019','Mobile Ficha Ofertas Para Ti Ficha CrossSelling','2','Mobile','19','Ficha','00','Ofertas Para Ti','19','Ficha CrossSelling'),
('2190119','Mobile Ficha Showroom Ficha CrossSelling','2','Mobile','19','Ficha','01','Showroom','19','Ficha CrossSelling'),
('2190219','Mobile Ficha Lanzamientos Ficha CrossSelling','2','Mobile','19','Ficha','02','Lanzamientos','19','Ficha CrossSelling'),
('2190319','Mobile Ficha Oferta Del Día Ficha CrossSelling','2','Mobile','19','Ficha','03','Oferta Del Día','19','Ficha CrossSelling'),
('2191419','Mobile Ficha Ganadoras Ficha CrossSelling','2','Mobile','19','Ficha','14','Ganadoras','19','Ficha CrossSelling'),
('4190019','App Consultora Ficha Ofertas Para Ti Ficha CrossSelling','4','App Consultora','19','Ficha','00','Ofertas Para Ti','19','Ficha CrossSelling'),
('4190119','App Consultora Ficha Showroom Ficha CrossSelling','4','App Consultora','19','Ficha','01','Showroom','19','Ficha CrossSelling'),
('4190219','App Consultora Ficha Lanzamientos Ficha CrossSelling','4','App Consultora','19','Ficha','02','Lanzamientos','19','Ficha CrossSelling'),
('4190319','App Consultora Ficha Oferta Del Día Ficha CrossSelling','4','App Consultora','19','Ficha','03','Oferta Del Día','19','Ficha CrossSelling'),
('4191419','App Consultora Ficha Ganadoras Ficha CrossSelling','4','App Consultora','19','Ficha','14','Ganadoras','19','Ficha CrossSelling')



GO
USE BelcorpBolivia
GO

DELETE FROM [dbo].[OrigenPedidoWeb]
      WHERE [CodOrigenPedidoWeb]
--Origen de Pedido Sugeridos
		in ('1190020','1190120','1190220','1190320','1191420','2190020','2190120','2190220','2190320','2191420','4190020','4190120','4190220','4190320','4191420','1190021','1190121','1190221','1190321','1191421','2190021','2190121','2190221','2190321','2191421','4190021','4190121','4190221','4190321','4191421'
--Origen de Pedido Cros Selling
		,'1190018','1190118','1190218','1190318','1191418','2190018','2190118','2190218','2190318','2191418','4190018','4190118','4190218','4190318','4191418','1190019','1190119','1190219','1190319','1191419','2190019','2190119','2190219','2190319','2191419','4190019','4190119','4190219','4190319','4191419'
)

go

INSERT INTO [dbo].[OrigenPedidoWeb]
           ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
     VALUES
--Origen de Pedido Sugeridos

('1190020','Desktop Ficha Ofertas Para Ti Carrusel Sugeridos','1','Desktop','19','Ficha','00','Ofertas Para Ti','20','Carrusel Sugeridos'),
('1190120','Desktop Ficha Showroom Carrusel Sugeridos','1','Desktop','19','Ficha','01','Showroom','20','Carrusel Sugeridos'),
('1190220','Desktop Ficha Lanzamientos Carrusel Sugeridos','1','Desktop','19','Ficha','02','Lanzamientos','20','Carrusel Sugeridos'),
('1190320','Desktop Ficha Oferta Del Día Carrusel Sugeridos','1','Desktop','19','Ficha','03','Oferta Del Día','20','Carrusel Sugeridos'),
('1191420','Desktop Ficha Ganadoras Carrusel Sugeridos','1','Desktop','19','Ficha','14','Ganadoras','20','Carrusel Sugeridos'),
('2190020','Mobile Ficha Ofertas Para Ti Carrusel Sugeridos','2','Mobile','19','Ficha','00','Ofertas Para Ti','20','Carrusel Sugeridos'),
('2190120','Mobile Ficha Showroom Carrusel Sugeridos','2','Mobile','19','Ficha','01','Showroom','20','Carrusel Sugeridos'),
('2190220','Mobile Ficha Lanzamientos Carrusel Sugeridos','2','Mobile','19','Ficha','02','Lanzamientos','20','Carrusel Sugeridos'),
('2190320','Mobile Ficha Oferta Del Día Carrusel Sugeridos','2','Mobile','19','Ficha','03','Oferta Del Día','20','Carrusel Sugeridos'),
('2191420','Mobile Ficha Ganadoras Carrusel Sugeridos','2','Mobile','19','Ficha','14','Ganadoras','20','Carrusel Sugeridos'),
('4190020','App Consultora Ficha Ofertas Para Ti Carrusel Sugeridos','4','App Consultora','19','Ficha','00','Ofertas Para Ti','20','Carrusel Sugeridos'),
('4190120','App Consultora Ficha Showroom Carrusel Sugeridos','4','App Consultora','19','Ficha','01','Showroom','20','Carrusel Sugeridos'),
('4190220','App Consultora Ficha Lanzamientos Carrusel Sugeridos','4','App Consultora','19','Ficha','02','Lanzamientos','20','Carrusel Sugeridos'),
('4190320','App Consultora Ficha Oferta Del Día Carrusel Sugeridos','4','App Consultora','19','Ficha','03','Oferta Del Día','20','Carrusel Sugeridos'),
('4191420','App Consultora Ficha Ganadoras Carrusel Sugeridos','4','App Consultora','19','Ficha','14','Ganadoras','20','Carrusel Sugeridos'),
('1190021','Desktop Ficha Ofertas Para Ti Ficha Sugeridos','1','Desktop','19','Ficha','00','Ofertas Para Ti','21','Ficha Sugeridos'),
('1190121','Desktop Ficha Showroom Ficha Sugeridos','1','Desktop','19','Ficha','01','Showroom','21','Ficha Sugeridos'),
('1190221','Desktop Ficha Lanzamientos Ficha Sugeridos','1','Desktop','19','Ficha','02','Lanzamientos','21','Ficha Sugeridos'),
('1190321','Desktop Ficha Oferta Del Día Ficha Sugeridos','1','Desktop','19','Ficha','03','Oferta Del Día','21','Ficha Sugeridos'),
('1191421','Desktop Ficha Ganadoras Ficha Sugeridos','1','Desktop','19','Ficha','14','Ganadoras','21','Ficha Sugeridos'),
('2190021','Mobile Ficha Ofertas Para Ti Ficha Sugeridos','2','Mobile','19','Ficha','00','Ofertas Para Ti','21','Ficha Sugeridos'),
('2190121','Mobile Ficha Showroom Ficha Sugeridos','2','Mobile','19','Ficha','01','Showroom','21','Ficha Sugeridos'),
('2190221','Mobile Ficha Lanzamientos Ficha Sugeridos','2','Mobile','19','Ficha','02','Lanzamientos','21','Ficha Sugeridos'),
('2190321','Mobile Ficha Oferta Del Día Ficha Sugeridos','2','Mobile','19','Ficha','03','Oferta Del Día','21','Ficha Sugeridos'),
('2191421','Mobile Ficha Ganadoras Ficha Sugeridos','2','Mobile','19','Ficha','14','Ganadoras','21','Ficha Sugeridos'),
('4190021','App Consultora Ficha Ofertas Para Ti Ficha Sugeridos','4','App Consultora','19','Ficha','00','Ofertas Para Ti','21','Ficha Sugeridos'),
('4190121','App Consultora Ficha Showroom Ficha Sugeridos','4','App Consultora','19','Ficha','01','Showroom','21','Ficha Sugeridos'),
('4190221','App Consultora Ficha Lanzamientos Ficha Sugeridos','4','App Consultora','19','Ficha','02','Lanzamientos','21','Ficha Sugeridos'),
('4190321','App Consultora Ficha Oferta Del Día Ficha Sugeridos','4','App Consultora','19','Ficha','03','Oferta Del Día','21','Ficha Sugeridos'),
('4191421','App Consultora Ficha Ganadoras Ficha Sugeridos','4','App Consultora','19','Ficha','14','Ganadoras','21','Ficha Sugeridos'),


--Origen de Pedido Cros Selling

('1190018','Desktop Ficha Ofertas Para Ti Carrusel CrossSelling','1','Desktop','19','Ficha','00','Ofertas Para Ti','18','Carrusel CrossSelling'),
('1190118','Desktop Ficha Showroom Carrusel CrossSelling','1','Desktop','19','Ficha','01','Showroom','18','Carrusel CrossSelling'),
('1190218','Desktop Ficha Lanzamientos Carrusel CrossSelling','1','Desktop','19','Ficha','02','Lanzamientos','18','Carrusel CrossSelling'),
('1190318','Desktop Ficha Oferta Del Día Carrusel CrossSelling','1','Desktop','19','Ficha','03','Oferta Del Día','18','Carrusel CrossSelling'),
('1191418','Desktop Ficha Ganadoras Carrusel CrossSelling','1','Desktop','19','Ficha','14','Ganadoras','18','Carrusel CrossSelling'),
('2190018','Mobile Ficha Ofertas Para Ti Carrusel CrossSelling','2','Mobile','19','Ficha','00','Ofertas Para Ti','18','Carrusel CrossSelling'),
('2190118','Mobile Ficha Showroom Carrusel CrossSelling','2','Mobile','19','Ficha','01','Showroom','18','Carrusel CrossSelling'),
('2190218','Mobile Ficha Lanzamientos Carrusel CrossSelling','2','Mobile','19','Ficha','02','Lanzamientos','18','Carrusel CrossSelling'),
('2190318','Mobile Ficha Oferta Del Día Carrusel CrossSelling','2','Mobile','19','Ficha','03','Oferta Del Día','18','Carrusel CrossSelling'),
('2191418','Mobile Ficha Ganadoras Carrusel CrossSelling','2','Mobile','19','Ficha','14','Ganadoras','18','Carrusel CrossSelling'),
('4190018','App Consultora Ficha Ofertas Para Ti Carrusel CrossSelling','4','App Consultora','19','Ficha','00','Ofertas Para Ti','18','Carrusel CrossSelling'),
('4190118','App Consultora Ficha Showroom Carrusel CrossSelling','4','App Consultora','19','Ficha','01','Showroom','18','Carrusel CrossSelling'),
('4190218','App Consultora Ficha Lanzamientos Carrusel CrossSelling','4','App Consultora','19','Ficha','02','Lanzamientos','18','Carrusel CrossSelling'),
('4190318','App Consultora Ficha Oferta Del Día Carrusel CrossSelling','4','App Consultora','19','Ficha','03','Oferta Del Día','18','Carrusel CrossSelling'),
('4191418','App Consultora Ficha Ganadoras Carrusel CrossSelling','4','App Consultora','19','Ficha','14','Ganadoras','18','Carrusel CrossSelling'),
('1190019','Desktop Ficha Ofertas Para Ti Ficha CrossSelling','1','Desktop','19','Ficha','00','Ofertas Para Ti','19','Ficha CrossSelling'),
('1190119','Desktop Ficha Showroom Ficha CrossSelling','1','Desktop','19','Ficha','01','Showroom','19','Ficha CrossSelling'),
('1190219','Desktop Ficha Lanzamientos Ficha CrossSelling','1','Desktop','19','Ficha','02','Lanzamientos','19','Ficha CrossSelling'),
('1190319','Desktop Ficha Oferta Del Día Ficha CrossSelling','1','Desktop','19','Ficha','03','Oferta Del Día','19','Ficha CrossSelling'),
('1191419','Desktop Ficha Ganadoras Ficha CrossSelling','1','Desktop','19','Ficha','14','Ganadoras','19','Ficha CrossSelling'),
('2190019','Mobile Ficha Ofertas Para Ti Ficha CrossSelling','2','Mobile','19','Ficha','00','Ofertas Para Ti','19','Ficha CrossSelling'),
('2190119','Mobile Ficha Showroom Ficha CrossSelling','2','Mobile','19','Ficha','01','Showroom','19','Ficha CrossSelling'),
('2190219','Mobile Ficha Lanzamientos Ficha CrossSelling','2','Mobile','19','Ficha','02','Lanzamientos','19','Ficha CrossSelling'),
('2190319','Mobile Ficha Oferta Del Día Ficha CrossSelling','2','Mobile','19','Ficha','03','Oferta Del Día','19','Ficha CrossSelling'),
('2191419','Mobile Ficha Ganadoras Ficha CrossSelling','2','Mobile','19','Ficha','14','Ganadoras','19','Ficha CrossSelling'),
('4190019','App Consultora Ficha Ofertas Para Ti Ficha CrossSelling','4','App Consultora','19','Ficha','00','Ofertas Para Ti','19','Ficha CrossSelling'),
('4190119','App Consultora Ficha Showroom Ficha CrossSelling','4','App Consultora','19','Ficha','01','Showroom','19','Ficha CrossSelling'),
('4190219','App Consultora Ficha Lanzamientos Ficha CrossSelling','4','App Consultora','19','Ficha','02','Lanzamientos','19','Ficha CrossSelling'),
('4190319','App Consultora Ficha Oferta Del Día Ficha CrossSelling','4','App Consultora','19','Ficha','03','Oferta Del Día','19','Ficha CrossSelling'),
('4191419','App Consultora Ficha Ganadoras Ficha CrossSelling','4','App Consultora','19','Ficha','14','Ganadoras','19','Ficha CrossSelling')



GO
