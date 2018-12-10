DELETE FROM MensajeMetaConsultora WHERE TipoMensaje like '%Mobile';

insert into MensajeMetaConsultora (TipoMensaje, Titulo, Mensaje)
values
('MontoMinimoMobile', '', 'Te falta #valor para alcanzar el M. mínimo'),
('TippingPointMobile', '', 'Te falta #valor para tu regalo'),
('MontoMaximoMobile', '', 'Te falta #valor para alcanzar tu L. de crédito'),
('MontoMaximoSuperoMobile', '', '¡Ya alcanzaste tu límite de crédito!'),
('EscalaDescuentoMobile', '', 'Te falta #valor para el #porcentaje% DSCTO'),
('EscalaDescuentoSuperoMobile', '', '¡Alcanzaste el descuento máximo de #porcentaje% DSCTO!');