use BelcorpPeru_GANAMAS;


select * from PedidoWeb;

ALTER TABLE PedidoWeb ADD DescuentoRevista MONEY;
ALTER TABLE PedidoWeb ADD DescuentoWeb MONEY;
ALTER TABLE PedidoWeb ADD DescuentoOtros MONEY;