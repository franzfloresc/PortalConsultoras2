
-- CHILE 

USE BelcorpChile
GO

if exists (select 1 from OrigenPedidoWeb where CodOrigenPedidoWeb = '1181901')
begin
	Delete from OrigenPedidoWeb where CodOrigenPedidoWeb = '1181901'
end
GO

if exists (select 1 from OrigenPedidoWeb where CodOrigenPedidoWeb = '2181901')
begin
	Delete from OrigenPedidoWeb where CodOrigenPedidoWeb = '2181901'
end
GO

if exists (select 1 from OrigenPedidoWeb where CodOrigenPedidoWeb = '4181901')
begin
	Delete from OrigenPedidoWeb where CodOrigenPedidoWeb = '4181901'
end
GO


--COSTA RICA

USE BelcorpCostaRica
GO

if exists (select 1 from OrigenPedidoWeb where CodOrigenPedidoWeb = '1181901')
begin
	Delete from OrigenPedidoWeb where CodOrigenPedidoWeb = '1181901'
end
GO

if exists (select 1 from OrigenPedidoWeb where CodOrigenPedidoWeb = '2181901')
begin
	Delete from OrigenPedidoWeb where CodOrigenPedidoWeb = '2181901'
end
GO

if exists (select 1 from OrigenPedidoWeb where CodOrigenPedidoWeb = '4181901')
begin
	Delete from OrigenPedidoWeb where CodOrigenPedidoWeb = '4181901'
end
GO

--BOLIVIA 

USE BelcorpBolivia
GO

if exists (select 1 from OrigenPedidoWeb where CodOrigenPedidoWeb = '1181901')
begin
	Delete from OrigenPedidoWeb where CodOrigenPedidoWeb = '1181901'
end
GO

if exists (select 1 from OrigenPedidoWeb where CodOrigenPedidoWeb = '2181901')
begin
	Delete from OrigenPedidoWeb where CodOrigenPedidoWeb = '2181901'
end
GO

if exists (select 1 from OrigenPedidoWeb where CodOrigenPedidoWeb = '4181901')
begin
	Delete from OrigenPedidoWeb where CodOrigenPedidoWeb = '4181901'
end
GO
