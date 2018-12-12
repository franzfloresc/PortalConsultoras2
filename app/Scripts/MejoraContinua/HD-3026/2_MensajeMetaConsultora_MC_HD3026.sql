DELETE FROM MensajeMetaConsultora WHERE TipoMensaje like '%Mobile';

insert into MensajeMetaConsultora (TipoMensaje, Titulo, Mensaje)
values
('MontoMinimoMobile', '', 'Te falta #valor para alcanzar el M. m�nimo'),
('TippingPointMobile', '', 'Te falta #valor para tu regalo'),
('MontoMaximoMobile', '', 'Te falta #valor para alcanzar tu L. de cr�dito'),
('MontoMaximoSuperoMobile', '', '�Ya alcanzaste tu l�mite de cr�dito!'),
('EscalaDescuentoMobile', '', 'Te falta #valor para el #porcentaje% DSCTO'),
('EscalaDescuentoSuperoMobile', '', '�Alcanzaste el descuento m�ximo de #porcentaje% DSCTO!');