DELETE FROM MensajeMetaConsultora WHERE TipoMensaje like '%Mobile';

insert into MensajeMetaConsultora (TipoMensaje, Titulo, Mensaje)
values
('MontoMinimoMobile', '', 'Te falta #valor para alcanzar el M. mínimo'),
('TippingPointMobile', '', 'Te falta #valor para llevarte tu regalo'),
('MontoMaximoMobile', '', 'Sólo puedes agregar #valor más'),
('MontoMaximoSuperoMobile', '', '¡Alcanzaste tu monto máximo!'),
('EscalaDescuentoMobile', '', 'Te falta #valor para el #porcentaje% DSCTO'),
('EscalaDescuentoSuperoMobile', '', '¡Alcanzaste el descuento máximo de #porcentaje% DSCTO!');