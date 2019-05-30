-- CHILE 

USE BelcorpChile
GO

IF not exists (select 1 from OrigenPedidoWeb where CodOrigenPedidoWeb = '1181901')
begin
	insert into OrigenPedidoWeb (CodOrigenPedidoWeb ,DesOrigenPedidoWeb ,CodMedio, DesMedio, CodZona, DesZona,CodSeccion, DesSeccion, CodPopup,DesPopup)
	values ('1181901','Desktop Home Camino Brillante', 1, 'Desktop' , 18, 'Home Camino Brillante', 19, 'Camino Brillante', 01,'Carrusel')
end
go

IF not exists (select 1 from OrigenPedidoWeb where CodOrigenPedidoWeb = '2181901')
begin
	insert into OrigenPedidoWeb (CodOrigenPedidoWeb ,DesOrigenPedidoWeb ,CodMedio, DesMedio, CodZona,  DesZona,CodSeccion, DesSeccion, CodPopup,DesPopup)
	values ('2181901','Mobile Home Camino Brillante', 2, 'Mobile' , 18, 'Camino Brillante', 19, 'Camino Brillante', 01,'Carrusel')
end
go

IF not exists (select 1 from OrigenPedidoWeb where CodOrigenPedidoWeb = '4181901')
begin
	insert into OrigenPedidoWeb (CodOrigenPedidoWeb ,DesOrigenPedidoWeb ,CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup,DesPopup)
	values ('4181901','App Home Camino Brillante', 4, 'App' , 18, 'Camino Brillante', 19, 'Camino Brillante', 01,'Carrusel')
end
go

-- COSTA RICA 

USE BelcorpCostaRica
GO

IF not exists (select 1 from OrigenPedidoWeb where CodOrigenPedidoWeb = '1181901')
begin
	insert into OrigenPedidoWeb (CodOrigenPedidoWeb ,DesOrigenPedidoWeb ,CodMedio, DesMedio, CodZona, DesZona,CodSeccion, DesSeccion, CodPopup,DesPopup)
	values ('1181901','Desktop Home Camino Brillante', 1, 'Desktop' , 18, 'Home Camino Brillante', 19, 'Camino Brillante', 01,'Carrusel')
end
go

IF not exists (select 1 from OrigenPedidoWeb where CodOrigenPedidoWeb = '2181901')
begin
	insert into OrigenPedidoWeb (CodOrigenPedidoWeb ,DesOrigenPedidoWeb ,CodMedio, DesMedio, CodZona,  DesZona,CodSeccion, DesSeccion, CodPopup,DesPopup)
	values ('2181901','Mobile Home Camino Brillante', 2, 'Mobile' , 18, 'Camino Brillante', 19, 'Camino Brillante', 01,'Carrusel')
end
go

IF not exists (select 1 from OrigenPedidoWeb where CodOrigenPedidoWeb = '4181901')
begin
	insert into OrigenPedidoWeb (CodOrigenPedidoWeb ,DesOrigenPedidoWeb ,CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup,DesPopup)
	values ('4181901','App Home Camino Brillante', 4, 'App' , 18, 'Camino Brillante', 19, 'Camino Brillante', 01,'Carrusel')
end
go

-- BOLIVIA

USE BelcorpBolivia
GO

IF not exists (select 1 from OrigenPedidoWeb where CodOrigenPedidoWeb = '1181901')
begin
	insert into OrigenPedidoWeb (CodOrigenPedidoWeb ,DesOrigenPedidoWeb ,CodMedio, DesMedio, CodZona, DesZona,CodSeccion, DesSeccion, CodPopup,DesPopup)
	values ('1181901','Desktop Home Camino Brillante', 1, 'Desktop' , 18, 'Home Camino Brillante', 19, 'Camino Brillante', 01,'Carrusel')
end
go

IF not exists (select 1 from OrigenPedidoWeb where CodOrigenPedidoWeb = '2181901')
begin
	insert into OrigenPedidoWeb (CodOrigenPedidoWeb ,DesOrigenPedidoWeb ,CodMedio, DesMedio, CodZona,  DesZona,CodSeccion, DesSeccion, CodPopup,DesPopup)
	values ('2181901','Mobile Home Camino Brillante', 2, 'Mobile' , 18, 'Camino Brillante', 19, 'Camino Brillante', 01,'Carrusel')
end
go

IF not exists (select 1 from OrigenPedidoWeb where CodOrigenPedidoWeb = '4181901')
begin
	insert into OrigenPedidoWeb (CodOrigenPedidoWeb ,DesOrigenPedidoWeb ,CodMedio, DesMedio, CodZona, DesZona, CodSeccion, DesSeccion, CodPopup,DesPopup)
	values ('4181901','App Home Camino Brillante', 4, 'App' , 18, 'Camino Brillante', 19, 'Camino Brillante', 01,'Carrusel')
end
go