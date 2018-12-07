
GO
USE BelcorpPeru_BPT
go

set nocount on;

if not exists (select CodOrigenPedidoWeb from OrigenPedidoWeb where CodOrigenPedidoWeb = '1010302')
begin

	INSERT INTO OrigenPedidoWeb (CodOrigenPedidoWeb,DesOrigenPedidoWeb,CodMedio,DesMedio,CodZona,DesZona,CodSeccion,DesSeccion,CodPopup,DesPopup)
	VALUES ('1010302', 'Desktop Home Oferta Del Día Banner Superior', '1', 'Desktop', '01', 'Home', '03', 'Oferta Del Día', '01', 'Ficha')

end
go
 
 
 
 