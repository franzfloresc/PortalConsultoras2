USE BelcorpMexico;
GO
Update tablalogicadatos SET Codigo='2.4' where tablalogicaDatosid=12206;
-- codigo banco
Update tablalogicadatos SET Codigo='20154026' where tablalogicaDatosid=12212;

UPDATE PagoEnLineaMedioPagoDetalle SET ExpresionRegularTarjeta = '^(4)(\d{12}|\d{15})$|^(606374\d{10}$)' WHERE PagoEnLineaMedioPagoId = 1 AND TipoTarjeta = 'ALL';
UPDATE PagoEnLineaMedioPagoDetalle SET ExpresionRegularTarjeta = '^(5[1-5]\d{14}$)|^(2(?:2(?:2[1-9][3-9]\d)|[3-6]\d\d|7(?:[01]\d|20))\d{12}$)' WHERE PagoEnLineaMedioPagoId = 2 AND TipoTarjeta = 'ALL';
GO