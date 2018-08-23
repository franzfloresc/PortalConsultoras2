truncate table PagoEnLineaTipoPago
insert into PagoEnLineaTipoPago (Descripcion,Codigo,Estado) values ('Pago Total','01',1)
insert into PagoEnLineaTipoPago (Descripcion,Codigo,Estado) values ('Pago Parcial','02',1)

truncate table PagoEnLineaMedioPago
insert into PagoEnLineaMedioPago (Descripcion,Codigo,RutaIcono,Orden,TextoToolTip,Estado) values ('VISA','VISA','',1,'',1)
--insert into PagoEnLineaMedioPago (Descripcion,Codigo,RutaIcono,Orden,TextoToolTip,Estado) values ('MASTERCARD','MC','',1,'',0)

truncate table PagoEnLineaMedioPagoDetalle
insert into PagoEnLineaMedioPagoDetalle (PagoEnLineaMedioPagoId,Descripcion,Orden,TerminosCondiciones,TipoPasarelaCodigoPlataforma)
values (1,'VISA (CRÉDITO)',1,'Términos y condiciones de VISA','A')

truncate table PagoEnLineaTipoPasarela
insert into PagoEnLineaTipoPasarela (CodigoPlataforma,Codigo,Descripcion,Valor) 
values ('A','01','Codigo de comercio','148009103')
insert into PagoEnLineaTipoPasarela (CodigoPlataforma,Codigo,Descripcion,Valor) 
values ('A','02','AccessKey Id','AKIAJM6EP4YHGUJMNUNA')
insert into PagoEnLineaTipoPasarela (CodigoPlataforma,Codigo,Descripcion,Valor) 
values ('A','03','SecretAccessKey','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')
insert into PagoEnLineaTipoPasarela (CodigoPlataforma,Codigo,Descripcion,Valor) 
values ('A','04','URL sesión para el botón de pagos','https://devapice.vnforapps.com/api.ecommerce/api/v1/ecommerce/token/')
insert into PagoEnLineaTipoPasarela (CodigoPlataforma,Codigo,Descripcion,Valor) 
values ('A','05','URL para numero pedido','https://devapice.vnforapps.com/api.tokenization/api/v2/merchant/')
insert into PagoEnLineaTipoPasarela (CodigoPlataforma,Codigo,Descripcion,Valor) 
values ('A','06','% Gastos Administrativos','3')
insert into PagoEnLineaTipoPasarela (CodigoPlataforma,Codigo,Descripcion,Valor) 
values ('A','07','URL Libreria Pago Visa','https://static-content.vnforapps.com/v1/js/checkout.js?qa=true')
insert into PagoEnLineaTipoPasarela (CodigoPlataforma,Codigo,Descripcion,Valor) 
values ('A','08','URL Autorizacion para el botón de pagos','https://devpsv.vnforapps.com/api.authorization/api/v1/authorization/web/')
insert into PagoEnLineaTipoPasarela (CodigoPlataforma,Codigo,Descripcion,Valor) 
values ('A','09','URL Logo Pasarela Pagos','http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/Matriz/PE/Logo_Esika.png')
insert into PagoEnLineaTipoPasarela (CodigoPlataforma,Codigo,Descripcion,Valor) 
values ('A','10','Color Boton Pagar Pasarela Pagos','#e81c36')
insert into PagoEnLineaTipoPasarela (CodigoPlataforma,Codigo,Descripcion,Valor) 
values ('A','11','Mensaje Información Pago Exitoso','Los pagos realizados después de las 10:00 p.m. serán efectivos al día siguiente.')
insert into PagoEnLineaTipoPasarela (CodigoPlataforma,Codigo,Descripcion,Valor) 
values ('A','12','Codigo Banco Visa','20014016')