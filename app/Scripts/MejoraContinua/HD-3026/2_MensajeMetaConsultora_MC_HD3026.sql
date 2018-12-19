DELETE FROM MensajeMetaConsultora WHERE TipoMensaje like '%Mobile';

insert into MensajeMetaConsultora (TipoMensaje, Titulo, Mensaje)
values
('MontoMinimoMobile', '', 'Te falta #valor para alcanzar el M. m�nimo'),
('TippingPointMobile', '', 'Te falta #valor para llevarte tu regalo'),
('MontoMaximoMobile', '', 'S�lo puedes agregar #valor m�s'),
('MontoMaximoSuperoMobile', '', '�Alcanzaste tu monto m�ximo!'),
('EscalaDescuentoMobile', '', 'Te falta #valor para el #porcentaje% DSCTO'),
('EscalaDescuentoSuperoMobile', '', '�Alcanzaste el descuento m�ximo de #porcentaje% DSCTO!');