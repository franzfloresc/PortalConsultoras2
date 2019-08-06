GO
USE BelcorpPeru
GO

print db_name()
go

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1190022')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1190022','Desktop Ficha Ofertas Para Ti Promocion Condicional','01','Desktop','19','Ficha','00','Ofertas Para Ti','22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1190122')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1190122','Desktop Ficha Showroom Promocion Condicional','01','Desktop','19','Ficha','01','Showroom','22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1190222')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1190222','Desktop Ficha Lanzamientos Promocion Condicional','01','Desktop','19','Ficha','02','Lanzamientos','22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1190322')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1190322','Desktop Ficha Oferta Del Día Promocion Condicional','01','Desktop','19','Ficha','03','Oferta Del Día','22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1190522')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1190522','Desktop Ficha GND Promocion Condicional','01','Desktop','19','Ficha','05','GND','22','Promocion Condicional')

end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1190822')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1190822','Desktop Ficha Herramientas de Venta Promocion Condicional','01','Desktop','19','Ficha','08','Herramientas de Venta','22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1191122')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1191122','Desktop Ficha Catalogo Lbel Promocion Condicional','01','Desktop','19','Ficha','11','Catalogo Lbel','22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1191222')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1191222',	'Desktop Ficha Catalogo Esika Promocion Condicional',		'01','Desktop',	'19','Ficha','12','Catalogo Esika',			'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1191322')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1191322',	'Desktop Ficha Catalogo Cyzone Promocion Condicional',		'01','Desktop',	'19','Ficha','13','Catalogo Cyzone',		'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1191422')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1191422',	'Desktop Ficha Ganadoras Promocion Condicional',			'01','Desktop',	'19','Ficha','14','Ganadoras',				'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2190022')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2190022',	'Mobile Ficha Ofertas Para Ti Promocion Condicional',		'02','Mobile',	'19','Ficha','00','Ofertas Para Ti',		'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2190122')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2190122',	'Mobile Ficha Showroom Promocion Condicional',				'02','Mobile',	'19','Ficha','01','Showroom',				'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2190222')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2190222',	'Mobile Ficha Lanzamientos Promocion Condicional',			'02','Mobile',	'19','Ficha','02','Lanzamientos',			'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2190322')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2190322',	'Mobile Ficha Oferta Del Día Promocion Condicional',		'02','Mobile',	'19','Ficha','03','Oferta Del Día',			'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2190522')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2190522',	'Mobile Ficha GND Promocion Condicional',					'02','Mobile',	'19','Ficha','05','GND',					'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2191122')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2191122',	'Mobile Ficha Catalogo Lbel Promocion Condicional',			'02','Mobile',	'19','Ficha','11','Catalogo Lbel',			'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2191222')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2191222',	'Mobile Ficha Catalogo Esika Promocion Condicional',		'02','Mobile',	'19','Ficha','12','Catalogo Esika',			'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2191322')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2191322',	'Mobile Ficha Catalogo Cyzone Promocion Condicional',		'02','Mobile',	'19','Ficha','13','Catalogo Cyzone',		'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2191422')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2191422',	'Mobile Ficha Ganadoras Promocion Condicional',				'02','Mobile',	'19','Ficha','14','Ganadoras',				'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1190523')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1190523',	'Desktop Ficha GND Promocion Producto',						'01','Desktop',	'19','Ficha','05','GND',					'23','Promocion Producto')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1191123')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1191123',	'Desktop Ficha Catalogo Lbel Promocion Producto',			'01','Desktop',	'19','Ficha','11','Catalogo Lbel',			'23','Promocion Producto')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1191223')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1191223',	'Desktop Ficha Catalogo Esika Promocion Producto',			'01','Desktop',	'19','Ficha','12','Catalogo Esika',			'23','Promocion Producto')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1191323')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1191323',	'Desktop Ficha Catalogo Cyzone Promocion Producto',			'01','Desktop',	'19','Ficha','13','Catalogo Cyzone',		'23','Promocion Producto')
end



if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2190523')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2190523',	'Mobile Ficha GND Promocion Producto',						'02','Mobile',	'19','Ficha','05','GND',					'23','Promocion Producto')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2191123')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2191123',	'Mobile Ficha Catalogo Lbel Promocion Producto',			'02','Mobile',	'19','Ficha','11','Catalogo Lbel',			'23','Promocion Producto')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2191223')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2191223',	'Mobile Ficha Catalogo Esika Promocion Producto',			'02','Mobile',	'19','Ficha','12','Catalogo Esika',			'23','Promocion Producto')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2191323')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2191323',	'Mobile Ficha Catalogo Cyzone Promocion Producto',			'02','Mobile',	'19','Ficha','13','Catalogo Cyzone',		'23','Promocion Producto')
end




go

GO
USE BelcorpMexico
GO

print db_name()
go

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1190022')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1190022','Desktop Ficha Ofertas Para Ti Promocion Condicional','01','Desktop','19','Ficha','00','Ofertas Para Ti','22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1190122')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1190122','Desktop Ficha Showroom Promocion Condicional','01','Desktop','19','Ficha','01','Showroom','22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1190222')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1190222','Desktop Ficha Lanzamientos Promocion Condicional','01','Desktop','19','Ficha','02','Lanzamientos','22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1190322')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1190322','Desktop Ficha Oferta Del Día Promocion Condicional','01','Desktop','19','Ficha','03','Oferta Del Día','22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1190522')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1190522','Desktop Ficha GND Promocion Condicional','01','Desktop','19','Ficha','05','GND','22','Promocion Condicional')

end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1190822')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1190822','Desktop Ficha Herramientas de Venta Promocion Condicional','01','Desktop','19','Ficha','08','Herramientas de Venta','22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1191122')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1191122','Desktop Ficha Catalogo Lbel Promocion Condicional','01','Desktop','19','Ficha','11','Catalogo Lbel','22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1191222')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1191222',	'Desktop Ficha Catalogo Esika Promocion Condicional',		'01','Desktop',	'19','Ficha','12','Catalogo Esika',			'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1191322')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1191322',	'Desktop Ficha Catalogo Cyzone Promocion Condicional',		'01','Desktop',	'19','Ficha','13','Catalogo Cyzone',		'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1191422')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1191422',	'Desktop Ficha Ganadoras Promocion Condicional',			'01','Desktop',	'19','Ficha','14','Ganadoras',				'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2190022')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2190022',	'Mobile Ficha Ofertas Para Ti Promocion Condicional',		'02','Mobile',	'19','Ficha','00','Ofertas Para Ti',		'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2190122')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2190122',	'Mobile Ficha Showroom Promocion Condicional',				'02','Mobile',	'19','Ficha','01','Showroom',				'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2190222')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2190222',	'Mobile Ficha Lanzamientos Promocion Condicional',			'02','Mobile',	'19','Ficha','02','Lanzamientos',			'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2190322')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2190322',	'Mobile Ficha Oferta Del Día Promocion Condicional',		'02','Mobile',	'19','Ficha','03','Oferta Del Día',			'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2190522')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2190522',	'Mobile Ficha GND Promocion Condicional',					'02','Mobile',	'19','Ficha','05','GND',					'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2191122')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2191122',	'Mobile Ficha Catalogo Lbel Promocion Condicional',			'02','Mobile',	'19','Ficha','11','Catalogo Lbel',			'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2191222')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2191222',	'Mobile Ficha Catalogo Esika Promocion Condicional',		'02','Mobile',	'19','Ficha','12','Catalogo Esika',			'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2191322')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2191322',	'Mobile Ficha Catalogo Cyzone Promocion Condicional',		'02','Mobile',	'19','Ficha','13','Catalogo Cyzone',		'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2191422')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2191422',	'Mobile Ficha Ganadoras Promocion Condicional',				'02','Mobile',	'19','Ficha','14','Ganadoras',				'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1190523')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1190523',	'Desktop Ficha GND Promocion Producto',						'01','Desktop',	'19','Ficha','05','GND',					'23','Promocion Producto')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1191123')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1191123',	'Desktop Ficha Catalogo Lbel Promocion Producto',			'01','Desktop',	'19','Ficha','11','Catalogo Lbel',			'23','Promocion Producto')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1191223')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1191223',	'Desktop Ficha Catalogo Esika Promocion Producto',			'01','Desktop',	'19','Ficha','12','Catalogo Esika',			'23','Promocion Producto')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1191323')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1191323',	'Desktop Ficha Catalogo Cyzone Promocion Producto',			'01','Desktop',	'19','Ficha','13','Catalogo Cyzone',		'23','Promocion Producto')
end



if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2190523')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2190523',	'Mobile Ficha GND Promocion Producto',						'02','Mobile',	'19','Ficha','05','GND',					'23','Promocion Producto')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2191123')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2191123',	'Mobile Ficha Catalogo Lbel Promocion Producto',			'02','Mobile',	'19','Ficha','11','Catalogo Lbel',			'23','Promocion Producto')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2191223')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2191223',	'Mobile Ficha Catalogo Esika Promocion Producto',			'02','Mobile',	'19','Ficha','12','Catalogo Esika',			'23','Promocion Producto')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2191323')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2191323',	'Mobile Ficha Catalogo Cyzone Promocion Producto',			'02','Mobile',	'19','Ficha','13','Catalogo Cyzone',		'23','Promocion Producto')
end




go

GO
USE BelcorpColombia
GO

print db_name()
go

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1190022')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1190022','Desktop Ficha Ofertas Para Ti Promocion Condicional','01','Desktop','19','Ficha','00','Ofertas Para Ti','22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1190122')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1190122','Desktop Ficha Showroom Promocion Condicional','01','Desktop','19','Ficha','01','Showroom','22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1190222')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1190222','Desktop Ficha Lanzamientos Promocion Condicional','01','Desktop','19','Ficha','02','Lanzamientos','22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1190322')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1190322','Desktop Ficha Oferta Del Día Promocion Condicional','01','Desktop','19','Ficha','03','Oferta Del Día','22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1190522')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1190522','Desktop Ficha GND Promocion Condicional','01','Desktop','19','Ficha','05','GND','22','Promocion Condicional')

end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1190822')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1190822','Desktop Ficha Herramientas de Venta Promocion Condicional','01','Desktop','19','Ficha','08','Herramientas de Venta','22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1191122')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1191122','Desktop Ficha Catalogo Lbel Promocion Condicional','01','Desktop','19','Ficha','11','Catalogo Lbel','22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1191222')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1191222',	'Desktop Ficha Catalogo Esika Promocion Condicional',		'01','Desktop',	'19','Ficha','12','Catalogo Esika',			'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1191322')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1191322',	'Desktop Ficha Catalogo Cyzone Promocion Condicional',		'01','Desktop',	'19','Ficha','13','Catalogo Cyzone',		'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1191422')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1191422',	'Desktop Ficha Ganadoras Promocion Condicional',			'01','Desktop',	'19','Ficha','14','Ganadoras',				'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2190022')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2190022',	'Mobile Ficha Ofertas Para Ti Promocion Condicional',		'02','Mobile',	'19','Ficha','00','Ofertas Para Ti',		'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2190122')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2190122',	'Mobile Ficha Showroom Promocion Condicional',				'02','Mobile',	'19','Ficha','01','Showroom',				'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2190222')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2190222',	'Mobile Ficha Lanzamientos Promocion Condicional',			'02','Mobile',	'19','Ficha','02','Lanzamientos',			'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2190322')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2190322',	'Mobile Ficha Oferta Del Día Promocion Condicional',		'02','Mobile',	'19','Ficha','03','Oferta Del Día',			'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2190522')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2190522',	'Mobile Ficha GND Promocion Condicional',					'02','Mobile',	'19','Ficha','05','GND',					'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2191122')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2191122',	'Mobile Ficha Catalogo Lbel Promocion Condicional',			'02','Mobile',	'19','Ficha','11','Catalogo Lbel',			'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2191222')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2191222',	'Mobile Ficha Catalogo Esika Promocion Condicional',		'02','Mobile',	'19','Ficha','12','Catalogo Esika',			'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2191322')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2191322',	'Mobile Ficha Catalogo Cyzone Promocion Condicional',		'02','Mobile',	'19','Ficha','13','Catalogo Cyzone',		'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2191422')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2191422',	'Mobile Ficha Ganadoras Promocion Condicional',				'02','Mobile',	'19','Ficha','14','Ganadoras',				'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1190523')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1190523',	'Desktop Ficha GND Promocion Producto',						'01','Desktop',	'19','Ficha','05','GND',					'23','Promocion Producto')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1191123')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1191123',	'Desktop Ficha Catalogo Lbel Promocion Producto',			'01','Desktop',	'19','Ficha','11','Catalogo Lbel',			'23','Promocion Producto')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1191223')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1191223',	'Desktop Ficha Catalogo Esika Promocion Producto',			'01','Desktop',	'19','Ficha','12','Catalogo Esika',			'23','Promocion Producto')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1191323')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1191323',	'Desktop Ficha Catalogo Cyzone Promocion Producto',			'01','Desktop',	'19','Ficha','13','Catalogo Cyzone',		'23','Promocion Producto')
end



if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2190523')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2190523',	'Mobile Ficha GND Promocion Producto',						'02','Mobile',	'19','Ficha','05','GND',					'23','Promocion Producto')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2191123')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2191123',	'Mobile Ficha Catalogo Lbel Promocion Producto',			'02','Mobile',	'19','Ficha','11','Catalogo Lbel',			'23','Promocion Producto')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2191223')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2191223',	'Mobile Ficha Catalogo Esika Promocion Producto',			'02','Mobile',	'19','Ficha','12','Catalogo Esika',			'23','Promocion Producto')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2191323')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2191323',	'Mobile Ficha Catalogo Cyzone Promocion Producto',			'02','Mobile',	'19','Ficha','13','Catalogo Cyzone',		'23','Promocion Producto')
end




go

GO
USE BelcorpSalvador
GO

print db_name()
go

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1190022')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1190022','Desktop Ficha Ofertas Para Ti Promocion Condicional','01','Desktop','19','Ficha','00','Ofertas Para Ti','22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1190122')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1190122','Desktop Ficha Showroom Promocion Condicional','01','Desktop','19','Ficha','01','Showroom','22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1190222')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1190222','Desktop Ficha Lanzamientos Promocion Condicional','01','Desktop','19','Ficha','02','Lanzamientos','22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1190322')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1190322','Desktop Ficha Oferta Del Día Promocion Condicional','01','Desktop','19','Ficha','03','Oferta Del Día','22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1190522')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1190522','Desktop Ficha GND Promocion Condicional','01','Desktop','19','Ficha','05','GND','22','Promocion Condicional')

end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1190822')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1190822','Desktop Ficha Herramientas de Venta Promocion Condicional','01','Desktop','19','Ficha','08','Herramientas de Venta','22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1191122')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1191122','Desktop Ficha Catalogo Lbel Promocion Condicional','01','Desktop','19','Ficha','11','Catalogo Lbel','22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1191222')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1191222',	'Desktop Ficha Catalogo Esika Promocion Condicional',		'01','Desktop',	'19','Ficha','12','Catalogo Esika',			'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1191322')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1191322',	'Desktop Ficha Catalogo Cyzone Promocion Condicional',		'01','Desktop',	'19','Ficha','13','Catalogo Cyzone',		'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1191422')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1191422',	'Desktop Ficha Ganadoras Promocion Condicional',			'01','Desktop',	'19','Ficha','14','Ganadoras',				'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2190022')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2190022',	'Mobile Ficha Ofertas Para Ti Promocion Condicional',		'02','Mobile',	'19','Ficha','00','Ofertas Para Ti',		'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2190122')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2190122',	'Mobile Ficha Showroom Promocion Condicional',				'02','Mobile',	'19','Ficha','01','Showroom',				'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2190222')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2190222',	'Mobile Ficha Lanzamientos Promocion Condicional',			'02','Mobile',	'19','Ficha','02','Lanzamientos',			'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2190322')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2190322',	'Mobile Ficha Oferta Del Día Promocion Condicional',		'02','Mobile',	'19','Ficha','03','Oferta Del Día',			'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2190522')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2190522',	'Mobile Ficha GND Promocion Condicional',					'02','Mobile',	'19','Ficha','05','GND',					'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2191122')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2191122',	'Mobile Ficha Catalogo Lbel Promocion Condicional',			'02','Mobile',	'19','Ficha','11','Catalogo Lbel',			'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2191222')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2191222',	'Mobile Ficha Catalogo Esika Promocion Condicional',		'02','Mobile',	'19','Ficha','12','Catalogo Esika',			'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2191322')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2191322',	'Mobile Ficha Catalogo Cyzone Promocion Condicional',		'02','Mobile',	'19','Ficha','13','Catalogo Cyzone',		'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2191422')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2191422',	'Mobile Ficha Ganadoras Promocion Condicional',				'02','Mobile',	'19','Ficha','14','Ganadoras',				'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1190523')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1190523',	'Desktop Ficha GND Promocion Producto',						'01','Desktop',	'19','Ficha','05','GND',					'23','Promocion Producto')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1191123')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1191123',	'Desktop Ficha Catalogo Lbel Promocion Producto',			'01','Desktop',	'19','Ficha','11','Catalogo Lbel',			'23','Promocion Producto')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1191223')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1191223',	'Desktop Ficha Catalogo Esika Promocion Producto',			'01','Desktop',	'19','Ficha','12','Catalogo Esika',			'23','Promocion Producto')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1191323')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1191323',	'Desktop Ficha Catalogo Cyzone Promocion Producto',			'01','Desktop',	'19','Ficha','13','Catalogo Cyzone',		'23','Promocion Producto')
end



if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2190523')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2190523',	'Mobile Ficha GND Promocion Producto',						'02','Mobile',	'19','Ficha','05','GND',					'23','Promocion Producto')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2191123')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2191123',	'Mobile Ficha Catalogo Lbel Promocion Producto',			'02','Mobile',	'19','Ficha','11','Catalogo Lbel',			'23','Promocion Producto')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2191223')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2191223',	'Mobile Ficha Catalogo Esika Promocion Producto',			'02','Mobile',	'19','Ficha','12','Catalogo Esika',			'23','Promocion Producto')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2191323')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2191323',	'Mobile Ficha Catalogo Cyzone Promocion Producto',			'02','Mobile',	'19','Ficha','13','Catalogo Cyzone',		'23','Promocion Producto')
end




go

GO
USE BelcorpPuertoRico
GO

print db_name()
go

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1190022')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1190022','Desktop Ficha Ofertas Para Ti Promocion Condicional','01','Desktop','19','Ficha','00','Ofertas Para Ti','22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1190122')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1190122','Desktop Ficha Showroom Promocion Condicional','01','Desktop','19','Ficha','01','Showroom','22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1190222')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1190222','Desktop Ficha Lanzamientos Promocion Condicional','01','Desktop','19','Ficha','02','Lanzamientos','22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1190322')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1190322','Desktop Ficha Oferta Del Día Promocion Condicional','01','Desktop','19','Ficha','03','Oferta Del Día','22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1190522')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1190522','Desktop Ficha GND Promocion Condicional','01','Desktop','19','Ficha','05','GND','22','Promocion Condicional')

end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1190822')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1190822','Desktop Ficha Herramientas de Venta Promocion Condicional','01','Desktop','19','Ficha','08','Herramientas de Venta','22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1191122')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1191122','Desktop Ficha Catalogo Lbel Promocion Condicional','01','Desktop','19','Ficha','11','Catalogo Lbel','22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1191222')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1191222',	'Desktop Ficha Catalogo Esika Promocion Condicional',		'01','Desktop',	'19','Ficha','12','Catalogo Esika',			'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1191322')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1191322',	'Desktop Ficha Catalogo Cyzone Promocion Condicional',		'01','Desktop',	'19','Ficha','13','Catalogo Cyzone',		'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1191422')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1191422',	'Desktop Ficha Ganadoras Promocion Condicional',			'01','Desktop',	'19','Ficha','14','Ganadoras',				'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2190022')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2190022',	'Mobile Ficha Ofertas Para Ti Promocion Condicional',		'02','Mobile',	'19','Ficha','00','Ofertas Para Ti',		'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2190122')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2190122',	'Mobile Ficha Showroom Promocion Condicional',				'02','Mobile',	'19','Ficha','01','Showroom',				'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2190222')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2190222',	'Mobile Ficha Lanzamientos Promocion Condicional',			'02','Mobile',	'19','Ficha','02','Lanzamientos',			'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2190322')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2190322',	'Mobile Ficha Oferta Del Día Promocion Condicional',		'02','Mobile',	'19','Ficha','03','Oferta Del Día',			'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2190522')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2190522',	'Mobile Ficha GND Promocion Condicional',					'02','Mobile',	'19','Ficha','05','GND',					'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2191122')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2191122',	'Mobile Ficha Catalogo Lbel Promocion Condicional',			'02','Mobile',	'19','Ficha','11','Catalogo Lbel',			'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2191222')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2191222',	'Mobile Ficha Catalogo Esika Promocion Condicional',		'02','Mobile',	'19','Ficha','12','Catalogo Esika',			'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2191322')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2191322',	'Mobile Ficha Catalogo Cyzone Promocion Condicional',		'02','Mobile',	'19','Ficha','13','Catalogo Cyzone',		'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2191422')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2191422',	'Mobile Ficha Ganadoras Promocion Condicional',				'02','Mobile',	'19','Ficha','14','Ganadoras',				'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1190523')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1190523',	'Desktop Ficha GND Promocion Producto',						'01','Desktop',	'19','Ficha','05','GND',					'23','Promocion Producto')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1191123')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1191123',	'Desktop Ficha Catalogo Lbel Promocion Producto',			'01','Desktop',	'19','Ficha','11','Catalogo Lbel',			'23','Promocion Producto')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1191223')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1191223',	'Desktop Ficha Catalogo Esika Promocion Producto',			'01','Desktop',	'19','Ficha','12','Catalogo Esika',			'23','Promocion Producto')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1191323')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1191323',	'Desktop Ficha Catalogo Cyzone Promocion Producto',			'01','Desktop',	'19','Ficha','13','Catalogo Cyzone',		'23','Promocion Producto')
end



if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2190523')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2190523',	'Mobile Ficha GND Promocion Producto',						'02','Mobile',	'19','Ficha','05','GND',					'23','Promocion Producto')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2191123')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2191123',	'Mobile Ficha Catalogo Lbel Promocion Producto',			'02','Mobile',	'19','Ficha','11','Catalogo Lbel',			'23','Promocion Producto')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2191223')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2191223',	'Mobile Ficha Catalogo Esika Promocion Producto',			'02','Mobile',	'19','Ficha','12','Catalogo Esika',			'23','Promocion Producto')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2191323')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2191323',	'Mobile Ficha Catalogo Cyzone Promocion Producto',			'02','Mobile',	'19','Ficha','13','Catalogo Cyzone',		'23','Promocion Producto')
end




go

GO
USE BelcorpPanama
GO

print db_name()
go

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1190022')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1190022','Desktop Ficha Ofertas Para Ti Promocion Condicional','01','Desktop','19','Ficha','00','Ofertas Para Ti','22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1190122')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1190122','Desktop Ficha Showroom Promocion Condicional','01','Desktop','19','Ficha','01','Showroom','22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1190222')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1190222','Desktop Ficha Lanzamientos Promocion Condicional','01','Desktop','19','Ficha','02','Lanzamientos','22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1190322')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1190322','Desktop Ficha Oferta Del Día Promocion Condicional','01','Desktop','19','Ficha','03','Oferta Del Día','22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1190522')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1190522','Desktop Ficha GND Promocion Condicional','01','Desktop','19','Ficha','05','GND','22','Promocion Condicional')

end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1190822')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1190822','Desktop Ficha Herramientas de Venta Promocion Condicional','01','Desktop','19','Ficha','08','Herramientas de Venta','22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1191122')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1191122','Desktop Ficha Catalogo Lbel Promocion Condicional','01','Desktop','19','Ficha','11','Catalogo Lbel','22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1191222')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1191222',	'Desktop Ficha Catalogo Esika Promocion Condicional',		'01','Desktop',	'19','Ficha','12','Catalogo Esika',			'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1191322')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1191322',	'Desktop Ficha Catalogo Cyzone Promocion Condicional',		'01','Desktop',	'19','Ficha','13','Catalogo Cyzone',		'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1191422')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1191422',	'Desktop Ficha Ganadoras Promocion Condicional',			'01','Desktop',	'19','Ficha','14','Ganadoras',				'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2190022')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2190022',	'Mobile Ficha Ofertas Para Ti Promocion Condicional',		'02','Mobile',	'19','Ficha','00','Ofertas Para Ti',		'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2190122')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2190122',	'Mobile Ficha Showroom Promocion Condicional',				'02','Mobile',	'19','Ficha','01','Showroom',				'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2190222')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2190222',	'Mobile Ficha Lanzamientos Promocion Condicional',			'02','Mobile',	'19','Ficha','02','Lanzamientos',			'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2190322')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2190322',	'Mobile Ficha Oferta Del Día Promocion Condicional',		'02','Mobile',	'19','Ficha','03','Oferta Del Día',			'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2190522')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2190522',	'Mobile Ficha GND Promocion Condicional',					'02','Mobile',	'19','Ficha','05','GND',					'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2191122')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2191122',	'Mobile Ficha Catalogo Lbel Promocion Condicional',			'02','Mobile',	'19','Ficha','11','Catalogo Lbel',			'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2191222')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2191222',	'Mobile Ficha Catalogo Esika Promocion Condicional',		'02','Mobile',	'19','Ficha','12','Catalogo Esika',			'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2191322')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2191322',	'Mobile Ficha Catalogo Cyzone Promocion Condicional',		'02','Mobile',	'19','Ficha','13','Catalogo Cyzone',		'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2191422')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2191422',	'Mobile Ficha Ganadoras Promocion Condicional',				'02','Mobile',	'19','Ficha','14','Ganadoras',				'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1190523')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1190523',	'Desktop Ficha GND Promocion Producto',						'01','Desktop',	'19','Ficha','05','GND',					'23','Promocion Producto')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1191123')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1191123',	'Desktop Ficha Catalogo Lbel Promocion Producto',			'01','Desktop',	'19','Ficha','11','Catalogo Lbel',			'23','Promocion Producto')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1191223')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1191223',	'Desktop Ficha Catalogo Esika Promocion Producto',			'01','Desktop',	'19','Ficha','12','Catalogo Esika',			'23','Promocion Producto')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1191323')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1191323',	'Desktop Ficha Catalogo Cyzone Promocion Producto',			'01','Desktop',	'19','Ficha','13','Catalogo Cyzone',		'23','Promocion Producto')
end



if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2190523')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2190523',	'Mobile Ficha GND Promocion Producto',						'02','Mobile',	'19','Ficha','05','GND',					'23','Promocion Producto')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2191123')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2191123',	'Mobile Ficha Catalogo Lbel Promocion Producto',			'02','Mobile',	'19','Ficha','11','Catalogo Lbel',			'23','Promocion Producto')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2191223')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2191223',	'Mobile Ficha Catalogo Esika Promocion Producto',			'02','Mobile',	'19','Ficha','12','Catalogo Esika',			'23','Promocion Producto')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2191323')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2191323',	'Mobile Ficha Catalogo Cyzone Promocion Producto',			'02','Mobile',	'19','Ficha','13','Catalogo Cyzone',		'23','Promocion Producto')
end




go

GO
USE BelcorpGuatemala
GO

print db_name()
go

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1190022')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1190022','Desktop Ficha Ofertas Para Ti Promocion Condicional','01','Desktop','19','Ficha','00','Ofertas Para Ti','22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1190122')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1190122','Desktop Ficha Showroom Promocion Condicional','01','Desktop','19','Ficha','01','Showroom','22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1190222')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1190222','Desktop Ficha Lanzamientos Promocion Condicional','01','Desktop','19','Ficha','02','Lanzamientos','22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1190322')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1190322','Desktop Ficha Oferta Del Día Promocion Condicional','01','Desktop','19','Ficha','03','Oferta Del Día','22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1190522')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1190522','Desktop Ficha GND Promocion Condicional','01','Desktop','19','Ficha','05','GND','22','Promocion Condicional')

end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1190822')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1190822','Desktop Ficha Herramientas de Venta Promocion Condicional','01','Desktop','19','Ficha','08','Herramientas de Venta','22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1191122')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1191122','Desktop Ficha Catalogo Lbel Promocion Condicional','01','Desktop','19','Ficha','11','Catalogo Lbel','22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1191222')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1191222',	'Desktop Ficha Catalogo Esika Promocion Condicional',		'01','Desktop',	'19','Ficha','12','Catalogo Esika',			'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1191322')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1191322',	'Desktop Ficha Catalogo Cyzone Promocion Condicional',		'01','Desktop',	'19','Ficha','13','Catalogo Cyzone',		'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1191422')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1191422',	'Desktop Ficha Ganadoras Promocion Condicional',			'01','Desktop',	'19','Ficha','14','Ganadoras',				'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2190022')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2190022',	'Mobile Ficha Ofertas Para Ti Promocion Condicional',		'02','Mobile',	'19','Ficha','00','Ofertas Para Ti',		'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2190122')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2190122',	'Mobile Ficha Showroom Promocion Condicional',				'02','Mobile',	'19','Ficha','01','Showroom',				'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2190222')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2190222',	'Mobile Ficha Lanzamientos Promocion Condicional',			'02','Mobile',	'19','Ficha','02','Lanzamientos',			'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2190322')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2190322',	'Mobile Ficha Oferta Del Día Promocion Condicional',		'02','Mobile',	'19','Ficha','03','Oferta Del Día',			'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2190522')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2190522',	'Mobile Ficha GND Promocion Condicional',					'02','Mobile',	'19','Ficha','05','GND',					'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2191122')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2191122',	'Mobile Ficha Catalogo Lbel Promocion Condicional',			'02','Mobile',	'19','Ficha','11','Catalogo Lbel',			'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2191222')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2191222',	'Mobile Ficha Catalogo Esika Promocion Condicional',		'02','Mobile',	'19','Ficha','12','Catalogo Esika',			'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2191322')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2191322',	'Mobile Ficha Catalogo Cyzone Promocion Condicional',		'02','Mobile',	'19','Ficha','13','Catalogo Cyzone',		'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2191422')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2191422',	'Mobile Ficha Ganadoras Promocion Condicional',				'02','Mobile',	'19','Ficha','14','Ganadoras',				'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1190523')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1190523',	'Desktop Ficha GND Promocion Producto',						'01','Desktop',	'19','Ficha','05','GND',					'23','Promocion Producto')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1191123')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1191123',	'Desktop Ficha Catalogo Lbel Promocion Producto',			'01','Desktop',	'19','Ficha','11','Catalogo Lbel',			'23','Promocion Producto')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1191223')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1191223',	'Desktop Ficha Catalogo Esika Promocion Producto',			'01','Desktop',	'19','Ficha','12','Catalogo Esika',			'23','Promocion Producto')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1191323')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1191323',	'Desktop Ficha Catalogo Cyzone Promocion Producto',			'01','Desktop',	'19','Ficha','13','Catalogo Cyzone',		'23','Promocion Producto')
end



if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2190523')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2190523',	'Mobile Ficha GND Promocion Producto',						'02','Mobile',	'19','Ficha','05','GND',					'23','Promocion Producto')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2191123')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2191123',	'Mobile Ficha Catalogo Lbel Promocion Producto',			'02','Mobile',	'19','Ficha','11','Catalogo Lbel',			'23','Promocion Producto')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2191223')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2191223',	'Mobile Ficha Catalogo Esika Promocion Producto',			'02','Mobile',	'19','Ficha','12','Catalogo Esika',			'23','Promocion Producto')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2191323')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2191323',	'Mobile Ficha Catalogo Cyzone Promocion Producto',			'02','Mobile',	'19','Ficha','13','Catalogo Cyzone',		'23','Promocion Producto')
end




go

GO
USE BelcorpEcuador
GO

print db_name()
go

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1190022')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1190022','Desktop Ficha Ofertas Para Ti Promocion Condicional','01','Desktop','19','Ficha','00','Ofertas Para Ti','22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1190122')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1190122','Desktop Ficha Showroom Promocion Condicional','01','Desktop','19','Ficha','01','Showroom','22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1190222')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1190222','Desktop Ficha Lanzamientos Promocion Condicional','01','Desktop','19','Ficha','02','Lanzamientos','22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1190322')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1190322','Desktop Ficha Oferta Del Día Promocion Condicional','01','Desktop','19','Ficha','03','Oferta Del Día','22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1190522')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1190522','Desktop Ficha GND Promocion Condicional','01','Desktop','19','Ficha','05','GND','22','Promocion Condicional')

end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1190822')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1190822','Desktop Ficha Herramientas de Venta Promocion Condicional','01','Desktop','19','Ficha','08','Herramientas de Venta','22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1191122')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1191122','Desktop Ficha Catalogo Lbel Promocion Condicional','01','Desktop','19','Ficha','11','Catalogo Lbel','22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1191222')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1191222',	'Desktop Ficha Catalogo Esika Promocion Condicional',		'01','Desktop',	'19','Ficha','12','Catalogo Esika',			'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1191322')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1191322',	'Desktop Ficha Catalogo Cyzone Promocion Condicional',		'01','Desktop',	'19','Ficha','13','Catalogo Cyzone',		'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1191422')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1191422',	'Desktop Ficha Ganadoras Promocion Condicional',			'01','Desktop',	'19','Ficha','14','Ganadoras',				'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2190022')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2190022',	'Mobile Ficha Ofertas Para Ti Promocion Condicional',		'02','Mobile',	'19','Ficha','00','Ofertas Para Ti',		'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2190122')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2190122',	'Mobile Ficha Showroom Promocion Condicional',				'02','Mobile',	'19','Ficha','01','Showroom',				'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2190222')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2190222',	'Mobile Ficha Lanzamientos Promocion Condicional',			'02','Mobile',	'19','Ficha','02','Lanzamientos',			'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2190322')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2190322',	'Mobile Ficha Oferta Del Día Promocion Condicional',		'02','Mobile',	'19','Ficha','03','Oferta Del Día',			'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2190522')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2190522',	'Mobile Ficha GND Promocion Condicional',					'02','Mobile',	'19','Ficha','05','GND',					'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2191122')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2191122',	'Mobile Ficha Catalogo Lbel Promocion Condicional',			'02','Mobile',	'19','Ficha','11','Catalogo Lbel',			'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2191222')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2191222',	'Mobile Ficha Catalogo Esika Promocion Condicional',		'02','Mobile',	'19','Ficha','12','Catalogo Esika',			'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2191322')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2191322',	'Mobile Ficha Catalogo Cyzone Promocion Condicional',		'02','Mobile',	'19','Ficha','13','Catalogo Cyzone',		'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2191422')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2191422',	'Mobile Ficha Ganadoras Promocion Condicional',				'02','Mobile',	'19','Ficha','14','Ganadoras',				'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1190523')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1190523',	'Desktop Ficha GND Promocion Producto',						'01','Desktop',	'19','Ficha','05','GND',					'23','Promocion Producto')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1191123')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1191123',	'Desktop Ficha Catalogo Lbel Promocion Producto',			'01','Desktop',	'19','Ficha','11','Catalogo Lbel',			'23','Promocion Producto')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1191223')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1191223',	'Desktop Ficha Catalogo Esika Promocion Producto',			'01','Desktop',	'19','Ficha','12','Catalogo Esika',			'23','Promocion Producto')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1191323')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1191323',	'Desktop Ficha Catalogo Cyzone Promocion Producto',			'01','Desktop',	'19','Ficha','13','Catalogo Cyzone',		'23','Promocion Producto')
end



if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2190523')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2190523',	'Mobile Ficha GND Promocion Producto',						'02','Mobile',	'19','Ficha','05','GND',					'23','Promocion Producto')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2191123')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2191123',	'Mobile Ficha Catalogo Lbel Promocion Producto',			'02','Mobile',	'19','Ficha','11','Catalogo Lbel',			'23','Promocion Producto')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2191223')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2191223',	'Mobile Ficha Catalogo Esika Promocion Producto',			'02','Mobile',	'19','Ficha','12','Catalogo Esika',			'23','Promocion Producto')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2191323')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2191323',	'Mobile Ficha Catalogo Cyzone Promocion Producto',			'02','Mobile',	'19','Ficha','13','Catalogo Cyzone',		'23','Promocion Producto')
end




go

GO
USE BelcorpDominicana
GO

print db_name()
go

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1190022')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1190022','Desktop Ficha Ofertas Para Ti Promocion Condicional','01','Desktop','19','Ficha','00','Ofertas Para Ti','22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1190122')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1190122','Desktop Ficha Showroom Promocion Condicional','01','Desktop','19','Ficha','01','Showroom','22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1190222')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1190222','Desktop Ficha Lanzamientos Promocion Condicional','01','Desktop','19','Ficha','02','Lanzamientos','22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1190322')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1190322','Desktop Ficha Oferta Del Día Promocion Condicional','01','Desktop','19','Ficha','03','Oferta Del Día','22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1190522')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1190522','Desktop Ficha GND Promocion Condicional','01','Desktop','19','Ficha','05','GND','22','Promocion Condicional')

end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1190822')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1190822','Desktop Ficha Herramientas de Venta Promocion Condicional','01','Desktop','19','Ficha','08','Herramientas de Venta','22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1191122')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1191122','Desktop Ficha Catalogo Lbel Promocion Condicional','01','Desktop','19','Ficha','11','Catalogo Lbel','22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1191222')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1191222',	'Desktop Ficha Catalogo Esika Promocion Condicional',		'01','Desktop',	'19','Ficha','12','Catalogo Esika',			'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1191322')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1191322',	'Desktop Ficha Catalogo Cyzone Promocion Condicional',		'01','Desktop',	'19','Ficha','13','Catalogo Cyzone',		'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1191422')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1191422',	'Desktop Ficha Ganadoras Promocion Condicional',			'01','Desktop',	'19','Ficha','14','Ganadoras',				'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2190022')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2190022',	'Mobile Ficha Ofertas Para Ti Promocion Condicional',		'02','Mobile',	'19','Ficha','00','Ofertas Para Ti',		'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2190122')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2190122',	'Mobile Ficha Showroom Promocion Condicional',				'02','Mobile',	'19','Ficha','01','Showroom',				'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2190222')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2190222',	'Mobile Ficha Lanzamientos Promocion Condicional',			'02','Mobile',	'19','Ficha','02','Lanzamientos',			'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2190322')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2190322',	'Mobile Ficha Oferta Del Día Promocion Condicional',		'02','Mobile',	'19','Ficha','03','Oferta Del Día',			'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2190522')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2190522',	'Mobile Ficha GND Promocion Condicional',					'02','Mobile',	'19','Ficha','05','GND',					'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2191122')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2191122',	'Mobile Ficha Catalogo Lbel Promocion Condicional',			'02','Mobile',	'19','Ficha','11','Catalogo Lbel',			'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2191222')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2191222',	'Mobile Ficha Catalogo Esika Promocion Condicional',		'02','Mobile',	'19','Ficha','12','Catalogo Esika',			'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2191322')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2191322',	'Mobile Ficha Catalogo Cyzone Promocion Condicional',		'02','Mobile',	'19','Ficha','13','Catalogo Cyzone',		'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2191422')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2191422',	'Mobile Ficha Ganadoras Promocion Condicional',				'02','Mobile',	'19','Ficha','14','Ganadoras',				'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1190523')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1190523',	'Desktop Ficha GND Promocion Producto',						'01','Desktop',	'19','Ficha','05','GND',					'23','Promocion Producto')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1191123')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1191123',	'Desktop Ficha Catalogo Lbel Promocion Producto',			'01','Desktop',	'19','Ficha','11','Catalogo Lbel',			'23','Promocion Producto')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1191223')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1191223',	'Desktop Ficha Catalogo Esika Promocion Producto',			'01','Desktop',	'19','Ficha','12','Catalogo Esika',			'23','Promocion Producto')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1191323')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1191323',	'Desktop Ficha Catalogo Cyzone Promocion Producto',			'01','Desktop',	'19','Ficha','13','Catalogo Cyzone',		'23','Promocion Producto')
end



if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2190523')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2190523',	'Mobile Ficha GND Promocion Producto',						'02','Mobile',	'19','Ficha','05','GND',					'23','Promocion Producto')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2191123')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2191123',	'Mobile Ficha Catalogo Lbel Promocion Producto',			'02','Mobile',	'19','Ficha','11','Catalogo Lbel',			'23','Promocion Producto')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2191223')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2191223',	'Mobile Ficha Catalogo Esika Promocion Producto',			'02','Mobile',	'19','Ficha','12','Catalogo Esika',			'23','Promocion Producto')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2191323')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2191323',	'Mobile Ficha Catalogo Cyzone Promocion Producto',			'02','Mobile',	'19','Ficha','13','Catalogo Cyzone',		'23','Promocion Producto')
end




go

GO
USE BelcorpCostaRica
GO

print db_name()
go

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1190022')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1190022','Desktop Ficha Ofertas Para Ti Promocion Condicional','01','Desktop','19','Ficha','00','Ofertas Para Ti','22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1190122')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1190122','Desktop Ficha Showroom Promocion Condicional','01','Desktop','19','Ficha','01','Showroom','22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1190222')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1190222','Desktop Ficha Lanzamientos Promocion Condicional','01','Desktop','19','Ficha','02','Lanzamientos','22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1190322')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1190322','Desktop Ficha Oferta Del Día Promocion Condicional','01','Desktop','19','Ficha','03','Oferta Del Día','22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1190522')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1190522','Desktop Ficha GND Promocion Condicional','01','Desktop','19','Ficha','05','GND','22','Promocion Condicional')

end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1190822')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1190822','Desktop Ficha Herramientas de Venta Promocion Condicional','01','Desktop','19','Ficha','08','Herramientas de Venta','22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1191122')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1191122','Desktop Ficha Catalogo Lbel Promocion Condicional','01','Desktop','19','Ficha','11','Catalogo Lbel','22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1191222')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1191222',	'Desktop Ficha Catalogo Esika Promocion Condicional',		'01','Desktop',	'19','Ficha','12','Catalogo Esika',			'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1191322')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1191322',	'Desktop Ficha Catalogo Cyzone Promocion Condicional',		'01','Desktop',	'19','Ficha','13','Catalogo Cyzone',		'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1191422')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1191422',	'Desktop Ficha Ganadoras Promocion Condicional',			'01','Desktop',	'19','Ficha','14','Ganadoras',				'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2190022')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2190022',	'Mobile Ficha Ofertas Para Ti Promocion Condicional',		'02','Mobile',	'19','Ficha','00','Ofertas Para Ti',		'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2190122')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2190122',	'Mobile Ficha Showroom Promocion Condicional',				'02','Mobile',	'19','Ficha','01','Showroom',				'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2190222')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2190222',	'Mobile Ficha Lanzamientos Promocion Condicional',			'02','Mobile',	'19','Ficha','02','Lanzamientos',			'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2190322')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2190322',	'Mobile Ficha Oferta Del Día Promocion Condicional',		'02','Mobile',	'19','Ficha','03','Oferta Del Día',			'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2190522')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2190522',	'Mobile Ficha GND Promocion Condicional',					'02','Mobile',	'19','Ficha','05','GND',					'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2191122')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2191122',	'Mobile Ficha Catalogo Lbel Promocion Condicional',			'02','Mobile',	'19','Ficha','11','Catalogo Lbel',			'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2191222')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2191222',	'Mobile Ficha Catalogo Esika Promocion Condicional',		'02','Mobile',	'19','Ficha','12','Catalogo Esika',			'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2191322')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2191322',	'Mobile Ficha Catalogo Cyzone Promocion Condicional',		'02','Mobile',	'19','Ficha','13','Catalogo Cyzone',		'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2191422')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2191422',	'Mobile Ficha Ganadoras Promocion Condicional',				'02','Mobile',	'19','Ficha','14','Ganadoras',				'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1190523')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1190523',	'Desktop Ficha GND Promocion Producto',						'01','Desktop',	'19','Ficha','05','GND',					'23','Promocion Producto')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1191123')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1191123',	'Desktop Ficha Catalogo Lbel Promocion Producto',			'01','Desktop',	'19','Ficha','11','Catalogo Lbel',			'23','Promocion Producto')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1191223')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1191223',	'Desktop Ficha Catalogo Esika Promocion Producto',			'01','Desktop',	'19','Ficha','12','Catalogo Esika',			'23','Promocion Producto')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1191323')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1191323',	'Desktop Ficha Catalogo Cyzone Promocion Producto',			'01','Desktop',	'19','Ficha','13','Catalogo Cyzone',		'23','Promocion Producto')
end



if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2190523')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2190523',	'Mobile Ficha GND Promocion Producto',						'02','Mobile',	'19','Ficha','05','GND',					'23','Promocion Producto')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2191123')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2191123',	'Mobile Ficha Catalogo Lbel Promocion Producto',			'02','Mobile',	'19','Ficha','11','Catalogo Lbel',			'23','Promocion Producto')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2191223')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2191223',	'Mobile Ficha Catalogo Esika Promocion Producto',			'02','Mobile',	'19','Ficha','12','Catalogo Esika',			'23','Promocion Producto')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2191323')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2191323',	'Mobile Ficha Catalogo Cyzone Promocion Producto',			'02','Mobile',	'19','Ficha','13','Catalogo Cyzone',		'23','Promocion Producto')
end




go

GO
USE BelcorpChile
GO

print db_name()
go

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1190022')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1190022','Desktop Ficha Ofertas Para Ti Promocion Condicional','01','Desktop','19','Ficha','00','Ofertas Para Ti','22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1190122')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1190122','Desktop Ficha Showroom Promocion Condicional','01','Desktop','19','Ficha','01','Showroom','22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1190222')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1190222','Desktop Ficha Lanzamientos Promocion Condicional','01','Desktop','19','Ficha','02','Lanzamientos','22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1190322')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1190322','Desktop Ficha Oferta Del Día Promocion Condicional','01','Desktop','19','Ficha','03','Oferta Del Día','22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1190522')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1190522','Desktop Ficha GND Promocion Condicional','01','Desktop','19','Ficha','05','GND','22','Promocion Condicional')

end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1190822')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1190822','Desktop Ficha Herramientas de Venta Promocion Condicional','01','Desktop','19','Ficha','08','Herramientas de Venta','22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1191122')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1191122','Desktop Ficha Catalogo Lbel Promocion Condicional','01','Desktop','19','Ficha','11','Catalogo Lbel','22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1191222')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1191222',	'Desktop Ficha Catalogo Esika Promocion Condicional',		'01','Desktop',	'19','Ficha','12','Catalogo Esika',			'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1191322')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1191322',	'Desktop Ficha Catalogo Cyzone Promocion Condicional',		'01','Desktop',	'19','Ficha','13','Catalogo Cyzone',		'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1191422')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1191422',	'Desktop Ficha Ganadoras Promocion Condicional',			'01','Desktop',	'19','Ficha','14','Ganadoras',				'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2190022')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2190022',	'Mobile Ficha Ofertas Para Ti Promocion Condicional',		'02','Mobile',	'19','Ficha','00','Ofertas Para Ti',		'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2190122')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2190122',	'Mobile Ficha Showroom Promocion Condicional',				'02','Mobile',	'19','Ficha','01','Showroom',				'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2190222')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2190222',	'Mobile Ficha Lanzamientos Promocion Condicional',			'02','Mobile',	'19','Ficha','02','Lanzamientos',			'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2190322')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2190322',	'Mobile Ficha Oferta Del Día Promocion Condicional',		'02','Mobile',	'19','Ficha','03','Oferta Del Día',			'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2190522')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2190522',	'Mobile Ficha GND Promocion Condicional',					'02','Mobile',	'19','Ficha','05','GND',					'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2191122')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2191122',	'Mobile Ficha Catalogo Lbel Promocion Condicional',			'02','Mobile',	'19','Ficha','11','Catalogo Lbel',			'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2191222')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2191222',	'Mobile Ficha Catalogo Esika Promocion Condicional',		'02','Mobile',	'19','Ficha','12','Catalogo Esika',			'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2191322')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2191322',	'Mobile Ficha Catalogo Cyzone Promocion Condicional',		'02','Mobile',	'19','Ficha','13','Catalogo Cyzone',		'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2191422')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2191422',	'Mobile Ficha Ganadoras Promocion Condicional',				'02','Mobile',	'19','Ficha','14','Ganadoras',				'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1190523')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1190523',	'Desktop Ficha GND Promocion Producto',						'01','Desktop',	'19','Ficha','05','GND',					'23','Promocion Producto')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1191123')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1191123',	'Desktop Ficha Catalogo Lbel Promocion Producto',			'01','Desktop',	'19','Ficha','11','Catalogo Lbel',			'23','Promocion Producto')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1191223')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1191223',	'Desktop Ficha Catalogo Esika Promocion Producto',			'01','Desktop',	'19','Ficha','12','Catalogo Esika',			'23','Promocion Producto')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1191323')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1191323',	'Desktop Ficha Catalogo Cyzone Promocion Producto',			'01','Desktop',	'19','Ficha','13','Catalogo Cyzone',		'23','Promocion Producto')
end



if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2190523')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2190523',	'Mobile Ficha GND Promocion Producto',						'02','Mobile',	'19','Ficha','05','GND',					'23','Promocion Producto')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2191123')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2191123',	'Mobile Ficha Catalogo Lbel Promocion Producto',			'02','Mobile',	'19','Ficha','11','Catalogo Lbel',			'23','Promocion Producto')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2191223')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2191223',	'Mobile Ficha Catalogo Esika Promocion Producto',			'02','Mobile',	'19','Ficha','12','Catalogo Esika',			'23','Promocion Producto')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2191323')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2191323',	'Mobile Ficha Catalogo Cyzone Promocion Producto',			'02','Mobile',	'19','Ficha','13','Catalogo Cyzone',		'23','Promocion Producto')
end




go

GO
USE BelcorpBolivia
GO

print db_name()
go

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1190022')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1190022','Desktop Ficha Ofertas Para Ti Promocion Condicional','01','Desktop','19','Ficha','00','Ofertas Para Ti','22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1190122')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1190122','Desktop Ficha Showroom Promocion Condicional','01','Desktop','19','Ficha','01','Showroom','22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1190222')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1190222','Desktop Ficha Lanzamientos Promocion Condicional','01','Desktop','19','Ficha','02','Lanzamientos','22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1190322')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1190322','Desktop Ficha Oferta Del Día Promocion Condicional','01','Desktop','19','Ficha','03','Oferta Del Día','22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1190522')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1190522','Desktop Ficha GND Promocion Condicional','01','Desktop','19','Ficha','05','GND','22','Promocion Condicional')

end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1190822')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1190822','Desktop Ficha Herramientas de Venta Promocion Condicional','01','Desktop','19','Ficha','08','Herramientas de Venta','22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1191122')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1191122','Desktop Ficha Catalogo Lbel Promocion Condicional','01','Desktop','19','Ficha','11','Catalogo Lbel','22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1191222')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1191222',	'Desktop Ficha Catalogo Esika Promocion Condicional',		'01','Desktop',	'19','Ficha','12','Catalogo Esika',			'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1191322')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1191322',	'Desktop Ficha Catalogo Cyzone Promocion Condicional',		'01','Desktop',	'19','Ficha','13','Catalogo Cyzone',		'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1191422')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1191422',	'Desktop Ficha Ganadoras Promocion Condicional',			'01','Desktop',	'19','Ficha','14','Ganadoras',				'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2190022')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2190022',	'Mobile Ficha Ofertas Para Ti Promocion Condicional',		'02','Mobile',	'19','Ficha','00','Ofertas Para Ti',		'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2190122')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2190122',	'Mobile Ficha Showroom Promocion Condicional',				'02','Mobile',	'19','Ficha','01','Showroom',				'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2190222')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2190222',	'Mobile Ficha Lanzamientos Promocion Condicional',			'02','Mobile',	'19','Ficha','02','Lanzamientos',			'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2190322')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2190322',	'Mobile Ficha Oferta Del Día Promocion Condicional',		'02','Mobile',	'19','Ficha','03','Oferta Del Día',			'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2190522')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2190522',	'Mobile Ficha GND Promocion Condicional',					'02','Mobile',	'19','Ficha','05','GND',					'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2191122')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2191122',	'Mobile Ficha Catalogo Lbel Promocion Condicional',			'02','Mobile',	'19','Ficha','11','Catalogo Lbel',			'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2191222')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2191222',	'Mobile Ficha Catalogo Esika Promocion Condicional',		'02','Mobile',	'19','Ficha','12','Catalogo Esika',			'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2191322')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2191322',	'Mobile Ficha Catalogo Cyzone Promocion Condicional',		'02','Mobile',	'19','Ficha','13','Catalogo Cyzone',		'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2191422')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2191422',	'Mobile Ficha Ganadoras Promocion Condicional',				'02','Mobile',	'19','Ficha','14','Ganadoras',				'22','Promocion Condicional')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1190523')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1190523',	'Desktop Ficha GND Promocion Producto',						'01','Desktop',	'19','Ficha','05','GND',					'23','Promocion Producto')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1191123')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1191123',	'Desktop Ficha Catalogo Lbel Promocion Producto',			'01','Desktop',	'19','Ficha','11','Catalogo Lbel',			'23','Promocion Producto')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1191223')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1191223',	'Desktop Ficha Catalogo Esika Promocion Producto',			'01','Desktop',	'19','Ficha','12','Catalogo Esika',			'23','Promocion Producto')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '1191323')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('1191323',	'Desktop Ficha Catalogo Cyzone Promocion Producto',			'01','Desktop',	'19','Ficha','13','Catalogo Cyzone',		'23','Promocion Producto')
end



if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2190523')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2190523',	'Mobile Ficha GND Promocion Producto',						'02','Mobile',	'19','Ficha','05','GND',					'23','Promocion Producto')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2191123')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2191123',	'Mobile Ficha Catalogo Lbel Promocion Producto',			'02','Mobile',	'19','Ficha','11','Catalogo Lbel',			'23','Promocion Producto')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2191223')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2191223',	'Mobile Ficha Catalogo Esika Promocion Producto',			'02','Mobile',	'19','Ficha','12','Catalogo Esika',			'23','Promocion Producto')
end

if not exists(	select opw.*
			from OrigenPedidoWeb opw
			where opw.CodOrigenPedidoWeb = '2191323')
begin
	insert into OrigenPedidoWeb(CodOrigenPedidoWeb, DesOrigenPedidoWeb, CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup, DesPopup )
	values('2191323',	'Mobile Ficha Catalogo Cyzone Promocion Producto',			'02','Mobile',	'19','Ficha','13','Catalogo Cyzone',		'23','Promocion Producto')
end




go

GO
