GO
USE BelcorpPeru
GO

DELETE FROM [dbo].[OrigenPedidoWeb]
      WHERE [CodOrigenPedidoWeb]
		in ('1190015',
			'1190115',
			'1190215',
			'1190315',
			'1191415',
			'2190015',
			'2190115',
			'2190215',
			'2190315',
			'2191415',
			'1190016',
			'1190116',
			'1190216',
			'1190316',
			'1191416',
			'2190016',
			'2190116',
			'2190216',
			'2190316',
			'2191416')

go

INSERT INTO [dbo].[OrigenPedidoWeb]
           ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
     VALUES
           ('1190015', 'Desktop Ficha Ofertas Para Ti Carrusel Upselling', '1', 'Desktop', '19', 'Ficha', '00', 'Ofertas Para Ti', '15','Carrusel Upselling'),
		   ('1190115', 'Desktop Ficha Showroom Carrusel Upselling', '1', 'Desktop', '19', 'Ficha', '01', 'Showroom', '15','Carrusel Upselling'),
		   ('1190215', 'Desktop Ficha Lanzamientos Carrusel Upselling', '1', 'Desktop', '19', 'Ficha', '02', 'Lanzamientos', '15','Carrusel Upselling'),
		   ('1190315', 'Desktop Ficha Oferta Del Día Carrusel Upselling', '1', 'Desktop', '19', 'Ficha', '03', 'Oferta Del Día', '15','Carrusel Upselling'),
		   ('1191415', 'Desktop Ficha Ganadoras Carrusel Upselling', '1', 'Desktop', '19', 'Ficha', '14', 'Ganadoras', '15','Carrusel Upselling'),
		   ('2190015', 'Mobile Ficha Ofertas Para Ti Carrusel Upselling', '2', 'Desktop', '19', 'Ficha', '00', 'Ofertas Para Ti', '15','Carrusel Upselling'),
		   ('2190115', 'Mobile Ficha Showroom Carrusel Upselling', '2', 'Desktop', '19', 'Ficha', '01', 'Showroom', '15','Carrusel Upselling'),
		   ('2190215', 'Mobile Ficha Lanzamientos Carrusel Upselling', '2', 'Desktop', '19', 'Ficha', '02', 'Lanzamientos', '15','Carrusel Upselling'),
		   ('2190315', 'Mobile Ficha Oferta Del Día Carrusel Upselling', '2', 'Desktop', '19', 'Ficha', '03', 'Oferta Del Día', '15','Carrusel Upselling'),
		   ('2191415', 'Mobile Ficha Ganadoras Carrusel Upselling', '2', 'Desktop', '19', 'Ficha', '14', 'Ganadoras', '15','Carrusel Upselling'),
		   ('1190016', 'Desktop Ficha Ofertas Para Ti Ficha Upselling', '1', 'Desktop', '19', 'Ficha', '00', 'Ofertas Para Ti', '16','Ficha Upselling'),
		   ('1190116', 'Desktop Ficha Showroom Ficha Upselling', '1', 'Desktop', '19', 'Ficha', '01', 'Showroom', '16','Ficha Upselling'),
		   ('1190216', 'Desktop Ficha Lanzamientos Ficha Upselling', '1', 'Desktop', '19', 'Ficha', '02', 'Lanzamientos', '16','Ficha Upselling'),
		   ('1190316', 'Desktop Ficha Oferta Del Día Ficha Upselling', '1', 'Desktop', '19', 'Ficha', '03', 'Oferta Del Día', '16','Ficha Upselling'),
		   ('1191416', 'Desktop Ficha Ganadoras Ficha Upselling', '1', 'Desktop', '19', 'Ficha', '14', 'Ganadoras', '16','Ficha Upselling'),
		   ('2190016', 'Mobile Ficha Ofertas Para Ti Ficha Upselling', '2', 'Desktop', '19', 'Ficha', '00', 'Ofertas Para Ti', '16','Ficha Upselling'),
		   ('2190116', 'Mobile Ficha Showroom Ficha Upselling', '2', 'Desktop', '19', 'Ficha', '01', 'Showroom', '16','Ficha Upselling'),
		   ('2190216', 'Mobile Ficha Lanzamientos Ficha Upselling', '2', 'Desktop', '19', 'Ficha', '02', 'Lanzamientos', '16','Ficha Upselling'),
		   ('2190316', 'Mobile Ficha Oferta Del Día Ficha Upselling', '2', 'Desktop', '19', 'Ficha', '03', 'Oferta Del Día', '16','Ficha Upselling'),
		   ('2191416', 'Mobile Ficha Ganadoras Ficha Upselling', '2', 'Desktop', '19', 'Ficha', '14', 'Ganadoras', '16','Ficha Upselling')


GO
USE BelcorpMexico
GO

DELETE FROM [dbo].[OrigenPedidoWeb]
      WHERE [CodOrigenPedidoWeb]
		in ('1190015',
			'1190115',
			'1190215',
			'1190315',
			'1191415',
			'2190015',
			'2190115',
			'2190215',
			'2190315',
			'2191415',
			'1190016',
			'1190116',
			'1190216',
			'1190316',
			'1191416',
			'2190016',
			'2190116',
			'2190216',
			'2190316',
			'2191416')

go

INSERT INTO [dbo].[OrigenPedidoWeb]
           ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
     VALUES
           ('1190015', 'Desktop Ficha Ofertas Para Ti Carrusel Upselling', '1', 'Desktop', '19', 'Ficha', '00', 'Ofertas Para Ti', '15','Carrusel Upselling'),
		   ('1190115', 'Desktop Ficha Showroom Carrusel Upselling', '1', 'Desktop', '19', 'Ficha', '01', 'Showroom', '15','Carrusel Upselling'),
		   ('1190215', 'Desktop Ficha Lanzamientos Carrusel Upselling', '1', 'Desktop', '19', 'Ficha', '02', 'Lanzamientos', '15','Carrusel Upselling'),
		   ('1190315', 'Desktop Ficha Oferta Del Día Carrusel Upselling', '1', 'Desktop', '19', 'Ficha', '03', 'Oferta Del Día', '15','Carrusel Upselling'),
		   ('1191415', 'Desktop Ficha Ganadoras Carrusel Upselling', '1', 'Desktop', '19', 'Ficha', '14', 'Ganadoras', '15','Carrusel Upselling'),
		   ('2190015', 'Mobile Ficha Ofertas Para Ti Carrusel Upselling', '2', 'Desktop', '19', 'Ficha', '00', 'Ofertas Para Ti', '15','Carrusel Upselling'),
		   ('2190115', 'Mobile Ficha Showroom Carrusel Upselling', '2', 'Desktop', '19', 'Ficha', '01', 'Showroom', '15','Carrusel Upselling'),
		   ('2190215', 'Mobile Ficha Lanzamientos Carrusel Upselling', '2', 'Desktop', '19', 'Ficha', '02', 'Lanzamientos', '15','Carrusel Upselling'),
		   ('2190315', 'Mobile Ficha Oferta Del Día Carrusel Upselling', '2', 'Desktop', '19', 'Ficha', '03', 'Oferta Del Día', '15','Carrusel Upselling'),
		   ('2191415', 'Mobile Ficha Ganadoras Carrusel Upselling', '2', 'Desktop', '19', 'Ficha', '14', 'Ganadoras', '15','Carrusel Upselling'),
		   ('1190016', 'Desktop Ficha Ofertas Para Ti Ficha Upselling', '1', 'Desktop', '19', 'Ficha', '00', 'Ofertas Para Ti', '16','Ficha Upselling'),
		   ('1190116', 'Desktop Ficha Showroom Ficha Upselling', '1', 'Desktop', '19', 'Ficha', '01', 'Showroom', '16','Ficha Upselling'),
		   ('1190216', 'Desktop Ficha Lanzamientos Ficha Upselling', '1', 'Desktop', '19', 'Ficha', '02', 'Lanzamientos', '16','Ficha Upselling'),
		   ('1190316', 'Desktop Ficha Oferta Del Día Ficha Upselling', '1', 'Desktop', '19', 'Ficha', '03', 'Oferta Del Día', '16','Ficha Upselling'),
		   ('1191416', 'Desktop Ficha Ganadoras Ficha Upselling', '1', 'Desktop', '19', 'Ficha', '14', 'Ganadoras', '16','Ficha Upselling'),
		   ('2190016', 'Mobile Ficha Ofertas Para Ti Ficha Upselling', '2', 'Desktop', '19', 'Ficha', '00', 'Ofertas Para Ti', '16','Ficha Upselling'),
		   ('2190116', 'Mobile Ficha Showroom Ficha Upselling', '2', 'Desktop', '19', 'Ficha', '01', 'Showroom', '16','Ficha Upselling'),
		   ('2190216', 'Mobile Ficha Lanzamientos Ficha Upselling', '2', 'Desktop', '19', 'Ficha', '02', 'Lanzamientos', '16','Ficha Upselling'),
		   ('2190316', 'Mobile Ficha Oferta Del Día Ficha Upselling', '2', 'Desktop', '19', 'Ficha', '03', 'Oferta Del Día', '16','Ficha Upselling'),
		   ('2191416', 'Mobile Ficha Ganadoras Ficha Upselling', '2', 'Desktop', '19', 'Ficha', '14', 'Ganadoras', '16','Ficha Upselling')


GO
USE BelcorpColombia
GO

DELETE FROM [dbo].[OrigenPedidoWeb]
      WHERE [CodOrigenPedidoWeb]
		in ('1190015',
			'1190115',
			'1190215',
			'1190315',
			'1191415',
			'2190015',
			'2190115',
			'2190215',
			'2190315',
			'2191415',
			'1190016',
			'1190116',
			'1190216',
			'1190316',
			'1191416',
			'2190016',
			'2190116',
			'2190216',
			'2190316',
			'2191416')

go

INSERT INTO [dbo].[OrigenPedidoWeb]
           ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
     VALUES
           ('1190015', 'Desktop Ficha Ofertas Para Ti Carrusel Upselling', '1', 'Desktop', '19', 'Ficha', '00', 'Ofertas Para Ti', '15','Carrusel Upselling'),
		   ('1190115', 'Desktop Ficha Showroom Carrusel Upselling', '1', 'Desktop', '19', 'Ficha', '01', 'Showroom', '15','Carrusel Upselling'),
		   ('1190215', 'Desktop Ficha Lanzamientos Carrusel Upselling', '1', 'Desktop', '19', 'Ficha', '02', 'Lanzamientos', '15','Carrusel Upselling'),
		   ('1190315', 'Desktop Ficha Oferta Del Día Carrusel Upselling', '1', 'Desktop', '19', 'Ficha', '03', 'Oferta Del Día', '15','Carrusel Upselling'),
		   ('1191415', 'Desktop Ficha Ganadoras Carrusel Upselling', '1', 'Desktop', '19', 'Ficha', '14', 'Ganadoras', '15','Carrusel Upselling'),
		   ('2190015', 'Mobile Ficha Ofertas Para Ti Carrusel Upselling', '2', 'Desktop', '19', 'Ficha', '00', 'Ofertas Para Ti', '15','Carrusel Upselling'),
		   ('2190115', 'Mobile Ficha Showroom Carrusel Upselling', '2', 'Desktop', '19', 'Ficha', '01', 'Showroom', '15','Carrusel Upselling'),
		   ('2190215', 'Mobile Ficha Lanzamientos Carrusel Upselling', '2', 'Desktop', '19', 'Ficha', '02', 'Lanzamientos', '15','Carrusel Upselling'),
		   ('2190315', 'Mobile Ficha Oferta Del Día Carrusel Upselling', '2', 'Desktop', '19', 'Ficha', '03', 'Oferta Del Día', '15','Carrusel Upselling'),
		   ('2191415', 'Mobile Ficha Ganadoras Carrusel Upselling', '2', 'Desktop', '19', 'Ficha', '14', 'Ganadoras', '15','Carrusel Upselling'),
		   ('1190016', 'Desktop Ficha Ofertas Para Ti Ficha Upselling', '1', 'Desktop', '19', 'Ficha', '00', 'Ofertas Para Ti', '16','Ficha Upselling'),
		   ('1190116', 'Desktop Ficha Showroom Ficha Upselling', '1', 'Desktop', '19', 'Ficha', '01', 'Showroom', '16','Ficha Upselling'),
		   ('1190216', 'Desktop Ficha Lanzamientos Ficha Upselling', '1', 'Desktop', '19', 'Ficha', '02', 'Lanzamientos', '16','Ficha Upselling'),
		   ('1190316', 'Desktop Ficha Oferta Del Día Ficha Upselling', '1', 'Desktop', '19', 'Ficha', '03', 'Oferta Del Día', '16','Ficha Upselling'),
		   ('1191416', 'Desktop Ficha Ganadoras Ficha Upselling', '1', 'Desktop', '19', 'Ficha', '14', 'Ganadoras', '16','Ficha Upselling'),
		   ('2190016', 'Mobile Ficha Ofertas Para Ti Ficha Upselling', '2', 'Desktop', '19', 'Ficha', '00', 'Ofertas Para Ti', '16','Ficha Upselling'),
		   ('2190116', 'Mobile Ficha Showroom Ficha Upselling', '2', 'Desktop', '19', 'Ficha', '01', 'Showroom', '16','Ficha Upselling'),
		   ('2190216', 'Mobile Ficha Lanzamientos Ficha Upselling', '2', 'Desktop', '19', 'Ficha', '02', 'Lanzamientos', '16','Ficha Upselling'),
		   ('2190316', 'Mobile Ficha Oferta Del Día Ficha Upselling', '2', 'Desktop', '19', 'Ficha', '03', 'Oferta Del Día', '16','Ficha Upselling'),
		   ('2191416', 'Mobile Ficha Ganadoras Ficha Upselling', '2', 'Desktop', '19', 'Ficha', '14', 'Ganadoras', '16','Ficha Upselling')


GO
USE BelcorpSalvador
GO

DELETE FROM [dbo].[OrigenPedidoWeb]
      WHERE [CodOrigenPedidoWeb]
		in ('1190015',
			'1190115',
			'1190215',
			'1190315',
			'1191415',
			'2190015',
			'2190115',
			'2190215',
			'2190315',
			'2191415',
			'1190016',
			'1190116',
			'1190216',
			'1190316',
			'1191416',
			'2190016',
			'2190116',
			'2190216',
			'2190316',
			'2191416')

go

INSERT INTO [dbo].[OrigenPedidoWeb]
           ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
     VALUES
           ('1190015', 'Desktop Ficha Ofertas Para Ti Carrusel Upselling', '1', 'Desktop', '19', 'Ficha', '00', 'Ofertas Para Ti', '15','Carrusel Upselling'),
		   ('1190115', 'Desktop Ficha Showroom Carrusel Upselling', '1', 'Desktop', '19', 'Ficha', '01', 'Showroom', '15','Carrusel Upselling'),
		   ('1190215', 'Desktop Ficha Lanzamientos Carrusel Upselling', '1', 'Desktop', '19', 'Ficha', '02', 'Lanzamientos', '15','Carrusel Upselling'),
		   ('1190315', 'Desktop Ficha Oferta Del Día Carrusel Upselling', '1', 'Desktop', '19', 'Ficha', '03', 'Oferta Del Día', '15','Carrusel Upselling'),
		   ('1191415', 'Desktop Ficha Ganadoras Carrusel Upselling', '1', 'Desktop', '19', 'Ficha', '14', 'Ganadoras', '15','Carrusel Upselling'),
		   ('2190015', 'Mobile Ficha Ofertas Para Ti Carrusel Upselling', '2', 'Desktop', '19', 'Ficha', '00', 'Ofertas Para Ti', '15','Carrusel Upselling'),
		   ('2190115', 'Mobile Ficha Showroom Carrusel Upselling', '2', 'Desktop', '19', 'Ficha', '01', 'Showroom', '15','Carrusel Upselling'),
		   ('2190215', 'Mobile Ficha Lanzamientos Carrusel Upselling', '2', 'Desktop', '19', 'Ficha', '02', 'Lanzamientos', '15','Carrusel Upselling'),
		   ('2190315', 'Mobile Ficha Oferta Del Día Carrusel Upselling', '2', 'Desktop', '19', 'Ficha', '03', 'Oferta Del Día', '15','Carrusel Upselling'),
		   ('2191415', 'Mobile Ficha Ganadoras Carrusel Upselling', '2', 'Desktop', '19', 'Ficha', '14', 'Ganadoras', '15','Carrusel Upselling'),
		   ('1190016', 'Desktop Ficha Ofertas Para Ti Ficha Upselling', '1', 'Desktop', '19', 'Ficha', '00', 'Ofertas Para Ti', '16','Ficha Upselling'),
		   ('1190116', 'Desktop Ficha Showroom Ficha Upselling', '1', 'Desktop', '19', 'Ficha', '01', 'Showroom', '16','Ficha Upselling'),
		   ('1190216', 'Desktop Ficha Lanzamientos Ficha Upselling', '1', 'Desktop', '19', 'Ficha', '02', 'Lanzamientos', '16','Ficha Upselling'),
		   ('1190316', 'Desktop Ficha Oferta Del Día Ficha Upselling', '1', 'Desktop', '19', 'Ficha', '03', 'Oferta Del Día', '16','Ficha Upselling'),
		   ('1191416', 'Desktop Ficha Ganadoras Ficha Upselling', '1', 'Desktop', '19', 'Ficha', '14', 'Ganadoras', '16','Ficha Upselling'),
		   ('2190016', 'Mobile Ficha Ofertas Para Ti Ficha Upselling', '2', 'Desktop', '19', 'Ficha', '00', 'Ofertas Para Ti', '16','Ficha Upselling'),
		   ('2190116', 'Mobile Ficha Showroom Ficha Upselling', '2', 'Desktop', '19', 'Ficha', '01', 'Showroom', '16','Ficha Upselling'),
		   ('2190216', 'Mobile Ficha Lanzamientos Ficha Upselling', '2', 'Desktop', '19', 'Ficha', '02', 'Lanzamientos', '16','Ficha Upselling'),
		   ('2190316', 'Mobile Ficha Oferta Del Día Ficha Upselling', '2', 'Desktop', '19', 'Ficha', '03', 'Oferta Del Día', '16','Ficha Upselling'),
		   ('2191416', 'Mobile Ficha Ganadoras Ficha Upselling', '2', 'Desktop', '19', 'Ficha', '14', 'Ganadoras', '16','Ficha Upselling')


GO
USE BelcorpPuertoRico
GO

DELETE FROM [dbo].[OrigenPedidoWeb]
      WHERE [CodOrigenPedidoWeb]
		in ('1190015',
			'1190115',
			'1190215',
			'1190315',
			'1191415',
			'2190015',
			'2190115',
			'2190215',
			'2190315',
			'2191415',
			'1190016',
			'1190116',
			'1190216',
			'1190316',
			'1191416',
			'2190016',
			'2190116',
			'2190216',
			'2190316',
			'2191416')

go

INSERT INTO [dbo].[OrigenPedidoWeb]
           ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
     VALUES
           ('1190015', 'Desktop Ficha Ofertas Para Ti Carrusel Upselling', '1', 'Desktop', '19', 'Ficha', '00', 'Ofertas Para Ti', '15','Carrusel Upselling'),
		   ('1190115', 'Desktop Ficha Showroom Carrusel Upselling', '1', 'Desktop', '19', 'Ficha', '01', 'Showroom', '15','Carrusel Upselling'),
		   ('1190215', 'Desktop Ficha Lanzamientos Carrusel Upselling', '1', 'Desktop', '19', 'Ficha', '02', 'Lanzamientos', '15','Carrusel Upselling'),
		   ('1190315', 'Desktop Ficha Oferta Del Día Carrusel Upselling', '1', 'Desktop', '19', 'Ficha', '03', 'Oferta Del Día', '15','Carrusel Upselling'),
		   ('1191415', 'Desktop Ficha Ganadoras Carrusel Upselling', '1', 'Desktop', '19', 'Ficha', '14', 'Ganadoras', '15','Carrusel Upselling'),
		   ('2190015', 'Mobile Ficha Ofertas Para Ti Carrusel Upselling', '2', 'Desktop', '19', 'Ficha', '00', 'Ofertas Para Ti', '15','Carrusel Upselling'),
		   ('2190115', 'Mobile Ficha Showroom Carrusel Upselling', '2', 'Desktop', '19', 'Ficha', '01', 'Showroom', '15','Carrusel Upselling'),
		   ('2190215', 'Mobile Ficha Lanzamientos Carrusel Upselling', '2', 'Desktop', '19', 'Ficha', '02', 'Lanzamientos', '15','Carrusel Upselling'),
		   ('2190315', 'Mobile Ficha Oferta Del Día Carrusel Upselling', '2', 'Desktop', '19', 'Ficha', '03', 'Oferta Del Día', '15','Carrusel Upselling'),
		   ('2191415', 'Mobile Ficha Ganadoras Carrusel Upselling', '2', 'Desktop', '19', 'Ficha', '14', 'Ganadoras', '15','Carrusel Upselling'),
		   ('1190016', 'Desktop Ficha Ofertas Para Ti Ficha Upselling', '1', 'Desktop', '19', 'Ficha', '00', 'Ofertas Para Ti', '16','Ficha Upselling'),
		   ('1190116', 'Desktop Ficha Showroom Ficha Upselling', '1', 'Desktop', '19', 'Ficha', '01', 'Showroom', '16','Ficha Upselling'),
		   ('1190216', 'Desktop Ficha Lanzamientos Ficha Upselling', '1', 'Desktop', '19', 'Ficha', '02', 'Lanzamientos', '16','Ficha Upselling'),
		   ('1190316', 'Desktop Ficha Oferta Del Día Ficha Upselling', '1', 'Desktop', '19', 'Ficha', '03', 'Oferta Del Día', '16','Ficha Upselling'),
		   ('1191416', 'Desktop Ficha Ganadoras Ficha Upselling', '1', 'Desktop', '19', 'Ficha', '14', 'Ganadoras', '16','Ficha Upselling'),
		   ('2190016', 'Mobile Ficha Ofertas Para Ti Ficha Upselling', '2', 'Desktop', '19', 'Ficha', '00', 'Ofertas Para Ti', '16','Ficha Upselling'),
		   ('2190116', 'Mobile Ficha Showroom Ficha Upselling', '2', 'Desktop', '19', 'Ficha', '01', 'Showroom', '16','Ficha Upselling'),
		   ('2190216', 'Mobile Ficha Lanzamientos Ficha Upselling', '2', 'Desktop', '19', 'Ficha', '02', 'Lanzamientos', '16','Ficha Upselling'),
		   ('2190316', 'Mobile Ficha Oferta Del Día Ficha Upselling', '2', 'Desktop', '19', 'Ficha', '03', 'Oferta Del Día', '16','Ficha Upselling'),
		   ('2191416', 'Mobile Ficha Ganadoras Ficha Upselling', '2', 'Desktop', '19', 'Ficha', '14', 'Ganadoras', '16','Ficha Upselling')


GO
USE BelcorpPanama
GO

DELETE FROM [dbo].[OrigenPedidoWeb]
      WHERE [CodOrigenPedidoWeb]
		in ('1190015',
			'1190115',
			'1190215',
			'1190315',
			'1191415',
			'2190015',
			'2190115',
			'2190215',
			'2190315',
			'2191415',
			'1190016',
			'1190116',
			'1190216',
			'1190316',
			'1191416',
			'2190016',
			'2190116',
			'2190216',
			'2190316',
			'2191416')

go

INSERT INTO [dbo].[OrigenPedidoWeb]
           ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
     VALUES
           ('1190015', 'Desktop Ficha Ofertas Para Ti Carrusel Upselling', '1', 'Desktop', '19', 'Ficha', '00', 'Ofertas Para Ti', '15','Carrusel Upselling'),
		   ('1190115', 'Desktop Ficha Showroom Carrusel Upselling', '1', 'Desktop', '19', 'Ficha', '01', 'Showroom', '15','Carrusel Upselling'),
		   ('1190215', 'Desktop Ficha Lanzamientos Carrusel Upselling', '1', 'Desktop', '19', 'Ficha', '02', 'Lanzamientos', '15','Carrusel Upselling'),
		   ('1190315', 'Desktop Ficha Oferta Del Día Carrusel Upselling', '1', 'Desktop', '19', 'Ficha', '03', 'Oferta Del Día', '15','Carrusel Upselling'),
		   ('1191415', 'Desktop Ficha Ganadoras Carrusel Upselling', '1', 'Desktop', '19', 'Ficha', '14', 'Ganadoras', '15','Carrusel Upselling'),
		   ('2190015', 'Mobile Ficha Ofertas Para Ti Carrusel Upselling', '2', 'Desktop', '19', 'Ficha', '00', 'Ofertas Para Ti', '15','Carrusel Upselling'),
		   ('2190115', 'Mobile Ficha Showroom Carrusel Upselling', '2', 'Desktop', '19', 'Ficha', '01', 'Showroom', '15','Carrusel Upselling'),
		   ('2190215', 'Mobile Ficha Lanzamientos Carrusel Upselling', '2', 'Desktop', '19', 'Ficha', '02', 'Lanzamientos', '15','Carrusel Upselling'),
		   ('2190315', 'Mobile Ficha Oferta Del Día Carrusel Upselling', '2', 'Desktop', '19', 'Ficha', '03', 'Oferta Del Día', '15','Carrusel Upselling'),
		   ('2191415', 'Mobile Ficha Ganadoras Carrusel Upselling', '2', 'Desktop', '19', 'Ficha', '14', 'Ganadoras', '15','Carrusel Upselling'),
		   ('1190016', 'Desktop Ficha Ofertas Para Ti Ficha Upselling', '1', 'Desktop', '19', 'Ficha', '00', 'Ofertas Para Ti', '16','Ficha Upselling'),
		   ('1190116', 'Desktop Ficha Showroom Ficha Upselling', '1', 'Desktop', '19', 'Ficha', '01', 'Showroom', '16','Ficha Upselling'),
		   ('1190216', 'Desktop Ficha Lanzamientos Ficha Upselling', '1', 'Desktop', '19', 'Ficha', '02', 'Lanzamientos', '16','Ficha Upselling'),
		   ('1190316', 'Desktop Ficha Oferta Del Día Ficha Upselling', '1', 'Desktop', '19', 'Ficha', '03', 'Oferta Del Día', '16','Ficha Upselling'),
		   ('1191416', 'Desktop Ficha Ganadoras Ficha Upselling', '1', 'Desktop', '19', 'Ficha', '14', 'Ganadoras', '16','Ficha Upselling'),
		   ('2190016', 'Mobile Ficha Ofertas Para Ti Ficha Upselling', '2', 'Desktop', '19', 'Ficha', '00', 'Ofertas Para Ti', '16','Ficha Upselling'),
		   ('2190116', 'Mobile Ficha Showroom Ficha Upselling', '2', 'Desktop', '19', 'Ficha', '01', 'Showroom', '16','Ficha Upselling'),
		   ('2190216', 'Mobile Ficha Lanzamientos Ficha Upselling', '2', 'Desktop', '19', 'Ficha', '02', 'Lanzamientos', '16','Ficha Upselling'),
		   ('2190316', 'Mobile Ficha Oferta Del Día Ficha Upselling', '2', 'Desktop', '19', 'Ficha', '03', 'Oferta Del Día', '16','Ficha Upselling'),
		   ('2191416', 'Mobile Ficha Ganadoras Ficha Upselling', '2', 'Desktop', '19', 'Ficha', '14', 'Ganadoras', '16','Ficha Upselling')


GO
USE BelcorpGuatemala
GO

DELETE FROM [dbo].[OrigenPedidoWeb]
      WHERE [CodOrigenPedidoWeb]
		in ('1190015',
			'1190115',
			'1190215',
			'1190315',
			'1191415',
			'2190015',
			'2190115',
			'2190215',
			'2190315',
			'2191415',
			'1190016',
			'1190116',
			'1190216',
			'1190316',
			'1191416',
			'2190016',
			'2190116',
			'2190216',
			'2190316',
			'2191416')

go

INSERT INTO [dbo].[OrigenPedidoWeb]
           ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
     VALUES
           ('1190015', 'Desktop Ficha Ofertas Para Ti Carrusel Upselling', '1', 'Desktop', '19', 'Ficha', '00', 'Ofertas Para Ti', '15','Carrusel Upselling'),
		   ('1190115', 'Desktop Ficha Showroom Carrusel Upselling', '1', 'Desktop', '19', 'Ficha', '01', 'Showroom', '15','Carrusel Upselling'),
		   ('1190215', 'Desktop Ficha Lanzamientos Carrusel Upselling', '1', 'Desktop', '19', 'Ficha', '02', 'Lanzamientos', '15','Carrusel Upselling'),
		   ('1190315', 'Desktop Ficha Oferta Del Día Carrusel Upselling', '1', 'Desktop', '19', 'Ficha', '03', 'Oferta Del Día', '15','Carrusel Upselling'),
		   ('1191415', 'Desktop Ficha Ganadoras Carrusel Upselling', '1', 'Desktop', '19', 'Ficha', '14', 'Ganadoras', '15','Carrusel Upselling'),
		   ('2190015', 'Mobile Ficha Ofertas Para Ti Carrusel Upselling', '2', 'Desktop', '19', 'Ficha', '00', 'Ofertas Para Ti', '15','Carrusel Upselling'),
		   ('2190115', 'Mobile Ficha Showroom Carrusel Upselling', '2', 'Desktop', '19', 'Ficha', '01', 'Showroom', '15','Carrusel Upselling'),
		   ('2190215', 'Mobile Ficha Lanzamientos Carrusel Upselling', '2', 'Desktop', '19', 'Ficha', '02', 'Lanzamientos', '15','Carrusel Upselling'),
		   ('2190315', 'Mobile Ficha Oferta Del Día Carrusel Upselling', '2', 'Desktop', '19', 'Ficha', '03', 'Oferta Del Día', '15','Carrusel Upselling'),
		   ('2191415', 'Mobile Ficha Ganadoras Carrusel Upselling', '2', 'Desktop', '19', 'Ficha', '14', 'Ganadoras', '15','Carrusel Upselling'),
		   ('1190016', 'Desktop Ficha Ofertas Para Ti Ficha Upselling', '1', 'Desktop', '19', 'Ficha', '00', 'Ofertas Para Ti', '16','Ficha Upselling'),
		   ('1190116', 'Desktop Ficha Showroom Ficha Upselling', '1', 'Desktop', '19', 'Ficha', '01', 'Showroom', '16','Ficha Upselling'),
		   ('1190216', 'Desktop Ficha Lanzamientos Ficha Upselling', '1', 'Desktop', '19', 'Ficha', '02', 'Lanzamientos', '16','Ficha Upselling'),
		   ('1190316', 'Desktop Ficha Oferta Del Día Ficha Upselling', '1', 'Desktop', '19', 'Ficha', '03', 'Oferta Del Día', '16','Ficha Upselling'),
		   ('1191416', 'Desktop Ficha Ganadoras Ficha Upselling', '1', 'Desktop', '19', 'Ficha', '14', 'Ganadoras', '16','Ficha Upselling'),
		   ('2190016', 'Mobile Ficha Ofertas Para Ti Ficha Upselling', '2', 'Desktop', '19', 'Ficha', '00', 'Ofertas Para Ti', '16','Ficha Upselling'),
		   ('2190116', 'Mobile Ficha Showroom Ficha Upselling', '2', 'Desktop', '19', 'Ficha', '01', 'Showroom', '16','Ficha Upselling'),
		   ('2190216', 'Mobile Ficha Lanzamientos Ficha Upselling', '2', 'Desktop', '19', 'Ficha', '02', 'Lanzamientos', '16','Ficha Upselling'),
		   ('2190316', 'Mobile Ficha Oferta Del Día Ficha Upselling', '2', 'Desktop', '19', 'Ficha', '03', 'Oferta Del Día', '16','Ficha Upselling'),
		   ('2191416', 'Mobile Ficha Ganadoras Ficha Upselling', '2', 'Desktop', '19', 'Ficha', '14', 'Ganadoras', '16','Ficha Upselling')


GO
USE BelcorpEcuador
GO

DELETE FROM [dbo].[OrigenPedidoWeb]
      WHERE [CodOrigenPedidoWeb]
		in ('1190015',
			'1190115',
			'1190215',
			'1190315',
			'1191415',
			'2190015',
			'2190115',
			'2190215',
			'2190315',
			'2191415',
			'1190016',
			'1190116',
			'1190216',
			'1190316',
			'1191416',
			'2190016',
			'2190116',
			'2190216',
			'2190316',
			'2191416')

go

INSERT INTO [dbo].[OrigenPedidoWeb]
           ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
     VALUES
           ('1190015', 'Desktop Ficha Ofertas Para Ti Carrusel Upselling', '1', 'Desktop', '19', 'Ficha', '00', 'Ofertas Para Ti', '15','Carrusel Upselling'),
		   ('1190115', 'Desktop Ficha Showroom Carrusel Upselling', '1', 'Desktop', '19', 'Ficha', '01', 'Showroom', '15','Carrusel Upselling'),
		   ('1190215', 'Desktop Ficha Lanzamientos Carrusel Upselling', '1', 'Desktop', '19', 'Ficha', '02', 'Lanzamientos', '15','Carrusel Upselling'),
		   ('1190315', 'Desktop Ficha Oferta Del Día Carrusel Upselling', '1', 'Desktop', '19', 'Ficha', '03', 'Oferta Del Día', '15','Carrusel Upselling'),
		   ('1191415', 'Desktop Ficha Ganadoras Carrusel Upselling', '1', 'Desktop', '19', 'Ficha', '14', 'Ganadoras', '15','Carrusel Upselling'),
		   ('2190015', 'Mobile Ficha Ofertas Para Ti Carrusel Upselling', '2', 'Desktop', '19', 'Ficha', '00', 'Ofertas Para Ti', '15','Carrusel Upselling'),
		   ('2190115', 'Mobile Ficha Showroom Carrusel Upselling', '2', 'Desktop', '19', 'Ficha', '01', 'Showroom', '15','Carrusel Upselling'),
		   ('2190215', 'Mobile Ficha Lanzamientos Carrusel Upselling', '2', 'Desktop', '19', 'Ficha', '02', 'Lanzamientos', '15','Carrusel Upselling'),
		   ('2190315', 'Mobile Ficha Oferta Del Día Carrusel Upselling', '2', 'Desktop', '19', 'Ficha', '03', 'Oferta Del Día', '15','Carrusel Upselling'),
		   ('2191415', 'Mobile Ficha Ganadoras Carrusel Upselling', '2', 'Desktop', '19', 'Ficha', '14', 'Ganadoras', '15','Carrusel Upselling'),
		   ('1190016', 'Desktop Ficha Ofertas Para Ti Ficha Upselling', '1', 'Desktop', '19', 'Ficha', '00', 'Ofertas Para Ti', '16','Ficha Upselling'),
		   ('1190116', 'Desktop Ficha Showroom Ficha Upselling', '1', 'Desktop', '19', 'Ficha', '01', 'Showroom', '16','Ficha Upselling'),
		   ('1190216', 'Desktop Ficha Lanzamientos Ficha Upselling', '1', 'Desktop', '19', 'Ficha', '02', 'Lanzamientos', '16','Ficha Upselling'),
		   ('1190316', 'Desktop Ficha Oferta Del Día Ficha Upselling', '1', 'Desktop', '19', 'Ficha', '03', 'Oferta Del Día', '16','Ficha Upselling'),
		   ('1191416', 'Desktop Ficha Ganadoras Ficha Upselling', '1', 'Desktop', '19', 'Ficha', '14', 'Ganadoras', '16','Ficha Upselling'),
		   ('2190016', 'Mobile Ficha Ofertas Para Ti Ficha Upselling', '2', 'Desktop', '19', 'Ficha', '00', 'Ofertas Para Ti', '16','Ficha Upselling'),
		   ('2190116', 'Mobile Ficha Showroom Ficha Upselling', '2', 'Desktop', '19', 'Ficha', '01', 'Showroom', '16','Ficha Upselling'),
		   ('2190216', 'Mobile Ficha Lanzamientos Ficha Upselling', '2', 'Desktop', '19', 'Ficha', '02', 'Lanzamientos', '16','Ficha Upselling'),
		   ('2190316', 'Mobile Ficha Oferta Del Día Ficha Upselling', '2', 'Desktop', '19', 'Ficha', '03', 'Oferta Del Día', '16','Ficha Upselling'),
		   ('2191416', 'Mobile Ficha Ganadoras Ficha Upselling', '2', 'Desktop', '19', 'Ficha', '14', 'Ganadoras', '16','Ficha Upselling')


GO
USE BelcorpDominicana
GO

DELETE FROM [dbo].[OrigenPedidoWeb]
      WHERE [CodOrigenPedidoWeb]
		in ('1190015',
			'1190115',
			'1190215',
			'1190315',
			'1191415',
			'2190015',
			'2190115',
			'2190215',
			'2190315',
			'2191415',
			'1190016',
			'1190116',
			'1190216',
			'1190316',
			'1191416',
			'2190016',
			'2190116',
			'2190216',
			'2190316',
			'2191416')

go

INSERT INTO [dbo].[OrigenPedidoWeb]
           ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
     VALUES
           ('1190015', 'Desktop Ficha Ofertas Para Ti Carrusel Upselling', '1', 'Desktop', '19', 'Ficha', '00', 'Ofertas Para Ti', '15','Carrusel Upselling'),
		   ('1190115', 'Desktop Ficha Showroom Carrusel Upselling', '1', 'Desktop', '19', 'Ficha', '01', 'Showroom', '15','Carrusel Upselling'),
		   ('1190215', 'Desktop Ficha Lanzamientos Carrusel Upselling', '1', 'Desktop', '19', 'Ficha', '02', 'Lanzamientos', '15','Carrusel Upselling'),
		   ('1190315', 'Desktop Ficha Oferta Del Día Carrusel Upselling', '1', 'Desktop', '19', 'Ficha', '03', 'Oferta Del Día', '15','Carrusel Upselling'),
		   ('1191415', 'Desktop Ficha Ganadoras Carrusel Upselling', '1', 'Desktop', '19', 'Ficha', '14', 'Ganadoras', '15','Carrusel Upselling'),
		   ('2190015', 'Mobile Ficha Ofertas Para Ti Carrusel Upselling', '2', 'Desktop', '19', 'Ficha', '00', 'Ofertas Para Ti', '15','Carrusel Upselling'),
		   ('2190115', 'Mobile Ficha Showroom Carrusel Upselling', '2', 'Desktop', '19', 'Ficha', '01', 'Showroom', '15','Carrusel Upselling'),
		   ('2190215', 'Mobile Ficha Lanzamientos Carrusel Upselling', '2', 'Desktop', '19', 'Ficha', '02', 'Lanzamientos', '15','Carrusel Upselling'),
		   ('2190315', 'Mobile Ficha Oferta Del Día Carrusel Upselling', '2', 'Desktop', '19', 'Ficha', '03', 'Oferta Del Día', '15','Carrusel Upselling'),
		   ('2191415', 'Mobile Ficha Ganadoras Carrusel Upselling', '2', 'Desktop', '19', 'Ficha', '14', 'Ganadoras', '15','Carrusel Upselling'),
		   ('1190016', 'Desktop Ficha Ofertas Para Ti Ficha Upselling', '1', 'Desktop', '19', 'Ficha', '00', 'Ofertas Para Ti', '16','Ficha Upselling'),
		   ('1190116', 'Desktop Ficha Showroom Ficha Upselling', '1', 'Desktop', '19', 'Ficha', '01', 'Showroom', '16','Ficha Upselling'),
		   ('1190216', 'Desktop Ficha Lanzamientos Ficha Upselling', '1', 'Desktop', '19', 'Ficha', '02', 'Lanzamientos', '16','Ficha Upselling'),
		   ('1190316', 'Desktop Ficha Oferta Del Día Ficha Upselling', '1', 'Desktop', '19', 'Ficha', '03', 'Oferta Del Día', '16','Ficha Upselling'),
		   ('1191416', 'Desktop Ficha Ganadoras Ficha Upselling', '1', 'Desktop', '19', 'Ficha', '14', 'Ganadoras', '16','Ficha Upselling'),
		   ('2190016', 'Mobile Ficha Ofertas Para Ti Ficha Upselling', '2', 'Desktop', '19', 'Ficha', '00', 'Ofertas Para Ti', '16','Ficha Upselling'),
		   ('2190116', 'Mobile Ficha Showroom Ficha Upselling', '2', 'Desktop', '19', 'Ficha', '01', 'Showroom', '16','Ficha Upselling'),
		   ('2190216', 'Mobile Ficha Lanzamientos Ficha Upselling', '2', 'Desktop', '19', 'Ficha', '02', 'Lanzamientos', '16','Ficha Upselling'),
		   ('2190316', 'Mobile Ficha Oferta Del Día Ficha Upselling', '2', 'Desktop', '19', 'Ficha', '03', 'Oferta Del Día', '16','Ficha Upselling'),
		   ('2191416', 'Mobile Ficha Ganadoras Ficha Upselling', '2', 'Desktop', '19', 'Ficha', '14', 'Ganadoras', '16','Ficha Upselling')


GO
USE BelcorpCostaRica
GO

DELETE FROM [dbo].[OrigenPedidoWeb]
      WHERE [CodOrigenPedidoWeb]
		in ('1190015',
			'1190115',
			'1190215',
			'1190315',
			'1191415',
			'2190015',
			'2190115',
			'2190215',
			'2190315',
			'2191415',
			'1190016',
			'1190116',
			'1190216',
			'1190316',
			'1191416',
			'2190016',
			'2190116',
			'2190216',
			'2190316',
			'2191416')

go

INSERT INTO [dbo].[OrigenPedidoWeb]
           ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
     VALUES
           ('1190015', 'Desktop Ficha Ofertas Para Ti Carrusel Upselling', '1', 'Desktop', '19', 'Ficha', '00', 'Ofertas Para Ti', '15','Carrusel Upselling'),
		   ('1190115', 'Desktop Ficha Showroom Carrusel Upselling', '1', 'Desktop', '19', 'Ficha', '01', 'Showroom', '15','Carrusel Upselling'),
		   ('1190215', 'Desktop Ficha Lanzamientos Carrusel Upselling', '1', 'Desktop', '19', 'Ficha', '02', 'Lanzamientos', '15','Carrusel Upselling'),
		   ('1190315', 'Desktop Ficha Oferta Del Día Carrusel Upselling', '1', 'Desktop', '19', 'Ficha', '03', 'Oferta Del Día', '15','Carrusel Upselling'),
		   ('1191415', 'Desktop Ficha Ganadoras Carrusel Upselling', '1', 'Desktop', '19', 'Ficha', '14', 'Ganadoras', '15','Carrusel Upselling'),
		   ('2190015', 'Mobile Ficha Ofertas Para Ti Carrusel Upselling', '2', 'Desktop', '19', 'Ficha', '00', 'Ofertas Para Ti', '15','Carrusel Upselling'),
		   ('2190115', 'Mobile Ficha Showroom Carrusel Upselling', '2', 'Desktop', '19', 'Ficha', '01', 'Showroom', '15','Carrusel Upselling'),
		   ('2190215', 'Mobile Ficha Lanzamientos Carrusel Upselling', '2', 'Desktop', '19', 'Ficha', '02', 'Lanzamientos', '15','Carrusel Upselling'),
		   ('2190315', 'Mobile Ficha Oferta Del Día Carrusel Upselling', '2', 'Desktop', '19', 'Ficha', '03', 'Oferta Del Día', '15','Carrusel Upselling'),
		   ('2191415', 'Mobile Ficha Ganadoras Carrusel Upselling', '2', 'Desktop', '19', 'Ficha', '14', 'Ganadoras', '15','Carrusel Upselling'),
		   ('1190016', 'Desktop Ficha Ofertas Para Ti Ficha Upselling', '1', 'Desktop', '19', 'Ficha', '00', 'Ofertas Para Ti', '16','Ficha Upselling'),
		   ('1190116', 'Desktop Ficha Showroom Ficha Upselling', '1', 'Desktop', '19', 'Ficha', '01', 'Showroom', '16','Ficha Upselling'),
		   ('1190216', 'Desktop Ficha Lanzamientos Ficha Upselling', '1', 'Desktop', '19', 'Ficha', '02', 'Lanzamientos', '16','Ficha Upselling'),
		   ('1190316', 'Desktop Ficha Oferta Del Día Ficha Upselling', '1', 'Desktop', '19', 'Ficha', '03', 'Oferta Del Día', '16','Ficha Upselling'),
		   ('1191416', 'Desktop Ficha Ganadoras Ficha Upselling', '1', 'Desktop', '19', 'Ficha', '14', 'Ganadoras', '16','Ficha Upselling'),
		   ('2190016', 'Mobile Ficha Ofertas Para Ti Ficha Upselling', '2', 'Desktop', '19', 'Ficha', '00', 'Ofertas Para Ti', '16','Ficha Upselling'),
		   ('2190116', 'Mobile Ficha Showroom Ficha Upselling', '2', 'Desktop', '19', 'Ficha', '01', 'Showroom', '16','Ficha Upselling'),
		   ('2190216', 'Mobile Ficha Lanzamientos Ficha Upselling', '2', 'Desktop', '19', 'Ficha', '02', 'Lanzamientos', '16','Ficha Upselling'),
		   ('2190316', 'Mobile Ficha Oferta Del Día Ficha Upselling', '2', 'Desktop', '19', 'Ficha', '03', 'Oferta Del Día', '16','Ficha Upselling'),
		   ('2191416', 'Mobile Ficha Ganadoras Ficha Upselling', '2', 'Desktop', '19', 'Ficha', '14', 'Ganadoras', '16','Ficha Upselling')


GO
USE BelcorpChile
GO

DELETE FROM [dbo].[OrigenPedidoWeb]
      WHERE [CodOrigenPedidoWeb]
		in ('1190015',
			'1190115',
			'1190215',
			'1190315',
			'1191415',
			'2190015',
			'2190115',
			'2190215',
			'2190315',
			'2191415',
			'1190016',
			'1190116',
			'1190216',
			'1190316',
			'1191416',
			'2190016',
			'2190116',
			'2190216',
			'2190316',
			'2191416')

go

INSERT INTO [dbo].[OrigenPedidoWeb]
           ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
     VALUES
           ('1190015', 'Desktop Ficha Ofertas Para Ti Carrusel Upselling', '1', 'Desktop', '19', 'Ficha', '00', 'Ofertas Para Ti', '15','Carrusel Upselling'),
		   ('1190115', 'Desktop Ficha Showroom Carrusel Upselling', '1', 'Desktop', '19', 'Ficha', '01', 'Showroom', '15','Carrusel Upselling'),
		   ('1190215', 'Desktop Ficha Lanzamientos Carrusel Upselling', '1', 'Desktop', '19', 'Ficha', '02', 'Lanzamientos', '15','Carrusel Upselling'),
		   ('1190315', 'Desktop Ficha Oferta Del Día Carrusel Upselling', '1', 'Desktop', '19', 'Ficha', '03', 'Oferta Del Día', '15','Carrusel Upselling'),
		   ('1191415', 'Desktop Ficha Ganadoras Carrusel Upselling', '1', 'Desktop', '19', 'Ficha', '14', 'Ganadoras', '15','Carrusel Upselling'),
		   ('2190015', 'Mobile Ficha Ofertas Para Ti Carrusel Upselling', '2', 'Desktop', '19', 'Ficha', '00', 'Ofertas Para Ti', '15','Carrusel Upselling'),
		   ('2190115', 'Mobile Ficha Showroom Carrusel Upselling', '2', 'Desktop', '19', 'Ficha', '01', 'Showroom', '15','Carrusel Upselling'),
		   ('2190215', 'Mobile Ficha Lanzamientos Carrusel Upselling', '2', 'Desktop', '19', 'Ficha', '02', 'Lanzamientos', '15','Carrusel Upselling'),
		   ('2190315', 'Mobile Ficha Oferta Del Día Carrusel Upselling', '2', 'Desktop', '19', 'Ficha', '03', 'Oferta Del Día', '15','Carrusel Upselling'),
		   ('2191415', 'Mobile Ficha Ganadoras Carrusel Upselling', '2', 'Desktop', '19', 'Ficha', '14', 'Ganadoras', '15','Carrusel Upselling'),
		   ('1190016', 'Desktop Ficha Ofertas Para Ti Ficha Upselling', '1', 'Desktop', '19', 'Ficha', '00', 'Ofertas Para Ti', '16','Ficha Upselling'),
		   ('1190116', 'Desktop Ficha Showroom Ficha Upselling', '1', 'Desktop', '19', 'Ficha', '01', 'Showroom', '16','Ficha Upselling'),
		   ('1190216', 'Desktop Ficha Lanzamientos Ficha Upselling', '1', 'Desktop', '19', 'Ficha', '02', 'Lanzamientos', '16','Ficha Upselling'),
		   ('1190316', 'Desktop Ficha Oferta Del Día Ficha Upselling', '1', 'Desktop', '19', 'Ficha', '03', 'Oferta Del Día', '16','Ficha Upselling'),
		   ('1191416', 'Desktop Ficha Ganadoras Ficha Upselling', '1', 'Desktop', '19', 'Ficha', '14', 'Ganadoras', '16','Ficha Upselling'),
		   ('2190016', 'Mobile Ficha Ofertas Para Ti Ficha Upselling', '2', 'Desktop', '19', 'Ficha', '00', 'Ofertas Para Ti', '16','Ficha Upselling'),
		   ('2190116', 'Mobile Ficha Showroom Ficha Upselling', '2', 'Desktop', '19', 'Ficha', '01', 'Showroom', '16','Ficha Upselling'),
		   ('2190216', 'Mobile Ficha Lanzamientos Ficha Upselling', '2', 'Desktop', '19', 'Ficha', '02', 'Lanzamientos', '16','Ficha Upselling'),
		   ('2190316', 'Mobile Ficha Oferta Del Día Ficha Upselling', '2', 'Desktop', '19', 'Ficha', '03', 'Oferta Del Día', '16','Ficha Upselling'),
		   ('2191416', 'Mobile Ficha Ganadoras Ficha Upselling', '2', 'Desktop', '19', 'Ficha', '14', 'Ganadoras', '16','Ficha Upselling')


GO
USE BelcorpBolivia
GO

DELETE FROM [dbo].[OrigenPedidoWeb]
      WHERE [CodOrigenPedidoWeb]
		in ('1190015',
			'1190115',
			'1190215',
			'1190315',
			'1191415',
			'2190015',
			'2190115',
			'2190215',
			'2190315',
			'2191415',
			'1190016',
			'1190116',
			'1190216',
			'1190316',
			'1191416',
			'2190016',
			'2190116',
			'2190216',
			'2190316',
			'2191416')

go

INSERT INTO [dbo].[OrigenPedidoWeb]
           ([CodOrigenPedidoWeb],[DesOrigenPedidoWeb],[CodMedio],[DesMedio],[CodZona],[DesZona],[CodSeccion],[DesSeccion],[CodPopup],[DesPopup])
     VALUES
           ('1190015', 'Desktop Ficha Ofertas Para Ti Carrusel Upselling', '1', 'Desktop', '19', 'Ficha', '00', 'Ofertas Para Ti', '15','Carrusel Upselling'),
		   ('1190115', 'Desktop Ficha Showroom Carrusel Upselling', '1', 'Desktop', '19', 'Ficha', '01', 'Showroom', '15','Carrusel Upselling'),
		   ('1190215', 'Desktop Ficha Lanzamientos Carrusel Upselling', '1', 'Desktop', '19', 'Ficha', '02', 'Lanzamientos', '15','Carrusel Upselling'),
		   ('1190315', 'Desktop Ficha Oferta Del Día Carrusel Upselling', '1', 'Desktop', '19', 'Ficha', '03', 'Oferta Del Día', '15','Carrusel Upselling'),
		   ('1191415', 'Desktop Ficha Ganadoras Carrusel Upselling', '1', 'Desktop', '19', 'Ficha', '14', 'Ganadoras', '15','Carrusel Upselling'),
		   ('2190015', 'Mobile Ficha Ofertas Para Ti Carrusel Upselling', '2', 'Desktop', '19', 'Ficha', '00', 'Ofertas Para Ti', '15','Carrusel Upselling'),
		   ('2190115', 'Mobile Ficha Showroom Carrusel Upselling', '2', 'Desktop', '19', 'Ficha', '01', 'Showroom', '15','Carrusel Upselling'),
		   ('2190215', 'Mobile Ficha Lanzamientos Carrusel Upselling', '2', 'Desktop', '19', 'Ficha', '02', 'Lanzamientos', '15','Carrusel Upselling'),
		   ('2190315', 'Mobile Ficha Oferta Del Día Carrusel Upselling', '2', 'Desktop', '19', 'Ficha', '03', 'Oferta Del Día', '15','Carrusel Upselling'),
		   ('2191415', 'Mobile Ficha Ganadoras Carrusel Upselling', '2', 'Desktop', '19', 'Ficha', '14', 'Ganadoras', '15','Carrusel Upselling'),
		   ('1190016', 'Desktop Ficha Ofertas Para Ti Ficha Upselling', '1', 'Desktop', '19', 'Ficha', '00', 'Ofertas Para Ti', '16','Ficha Upselling'),
		   ('1190116', 'Desktop Ficha Showroom Ficha Upselling', '1', 'Desktop', '19', 'Ficha', '01', 'Showroom', '16','Ficha Upselling'),
		   ('1190216', 'Desktop Ficha Lanzamientos Ficha Upselling', '1', 'Desktop', '19', 'Ficha', '02', 'Lanzamientos', '16','Ficha Upselling'),
		   ('1190316', 'Desktop Ficha Oferta Del Día Ficha Upselling', '1', 'Desktop', '19', 'Ficha', '03', 'Oferta Del Día', '16','Ficha Upselling'),
		   ('1191416', 'Desktop Ficha Ganadoras Ficha Upselling', '1', 'Desktop', '19', 'Ficha', '14', 'Ganadoras', '16','Ficha Upselling'),
		   ('2190016', 'Mobile Ficha Ofertas Para Ti Ficha Upselling', '2', 'Desktop', '19', 'Ficha', '00', 'Ofertas Para Ti', '16','Ficha Upselling'),
		   ('2190116', 'Mobile Ficha Showroom Ficha Upselling', '2', 'Desktop', '19', 'Ficha', '01', 'Showroom', '16','Ficha Upselling'),
		   ('2190216', 'Mobile Ficha Lanzamientos Ficha Upselling', '2', 'Desktop', '19', 'Ficha', '02', 'Lanzamientos', '16','Ficha Upselling'),
		   ('2190316', 'Mobile Ficha Oferta Del Día Ficha Upselling', '2', 'Desktop', '19', 'Ficha', '03', 'Oferta Del Día', '16','Ficha Upselling'),
		   ('2191416', 'Mobile Ficha Ganadoras Ficha Upselling', '2', 'Desktop', '19', 'Ficha', '14', 'Ganadoras', '16','Ficha Upselling')


GO
