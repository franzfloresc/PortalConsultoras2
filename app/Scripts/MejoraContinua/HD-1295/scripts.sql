USE BelcorpPeru
GO

if not exists (select 1 from ConfiguracionPais where Codigo = 'PAYONLINE')
begin

--select * from configuracionpais
-- SOLO PERU ESTADO = 1 LOS DEMAS 0

insert into ConfiguracionPais
(Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,MobileTituloMenu,DesktopTituloMenu,Logo,
Orden,DesktopTituloBanner,MobileTituloBanner,DesktopSubTituloBanner,MobileSubTituloBanner,DesktopFondoBanner,MobileFondoBanner,
DesktopLogoBanner,MobileLogoBanner,UrlMenu,OrdenBpt,MobileOrden,MobileOrdenBPT)
values
('PAYONLINE',1,'Pago en Línea',1,0,0,null,null,null,
0,null,null,null,null,null,null,
null,null,null,0,0,0)

end

go

alter table TablaLogicaDatos alter column Codigo varchar(150)

go

if not exists (select 1 from TablaLogica where TablaLogicaID = 122)
begin

insert into TablaLogica (TablaLogicaID,Descripcion) values (122,'Valores Pago en Línea')

insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12201,122,'148009103','Codigo de comercio')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12202,122,'AKIAJM6EP4YHGUJMNUNA','AccessKey Id')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12203,122,'UPgia3zgvVNXk6YFBh8CFAt8UYq9dScfh1jf7DWd','SecretAccessKey')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12204,122,'https://devapice.vnforapps.com/api.ecommerce/api/v1/ecommerce/token/','URL sesión para el botón de pagos')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12205,122,'https://devapice.vnforapps.com/api.tokenization/api/v2/merchant/','URL para numero pedido')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12206,122,'3','% Gastos Administrativos')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12207,122,'https://static-content.vnforapps.com/v1/js/checkout.js?qa=true','URL Libreria Pago Visa')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12208,122,'https://devpsv.vnforapps.com/api.authorization/api/v1/authorization/web/','URL Autorizacion para el botón de pagos')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12209,122,'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/Matriz/PE/Logo_Esika.png','URL Logo Pasarela Pagos')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12210,122,'#e81c36','Color Boton Pagar Pasarela Pagos')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12211,122,'Los pagos realizados después de las 10:00 p.m. serán efectivos al día siguiente.','Mensaje Información Pago Exitoso')

end

go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaResultadoLog') and type = 'U')
   drop table dbo.PagoEnLineaResultadoLog
go

create table dbo.PagoEnLineaResultadoLog
(
	PagoEnLineaResultadoLogId int identity(1,1) primary key,
	CodigoConsultora varchar(20),
	NumeroDocumento varchar(30),
	CampaniaId int,
	MontoPago decimal(18,2),
	MontoGastosAdministrativos decimal(18,2),
	TipoTarjeta varchar(20),
	CodigoError varchar(10),
	MensajeError varchar(100),
	IdGuidTransaccion varchar(100),
	IdGuidExternoTransaccion varchar(100),
	MerchantId varchar(9),	
	IdTokenUsuario varchar(100),
	AliasNameTarjeta varchar(100),
	FechaTransaccion datetime,
	ResultadoValidacionCVV2 varchar(100),
	CsiMensaje varchar(100),
	IdUnicoTransaccion varchar(15),
	Etiqueta varchar(100),
	RespuestaSistemAntifraude varchar(20),
	CsiPorcentajeDescuento decimal(18,2),
	NumeroCuota varchar(2),
	TokenTarjetaGuardada varchar(100),
	CsiImporteComercio decimal(18,2),
	CsiCodigoPrograma varchar(20),
	DescripcionIndicadorComercioElectronico varchar(100),
	IndicadorComercioElectronico varchar(2),
	DescripcionCodigoAccion varchar(100),
	NombreBancoEmisor varchar(100),	
	ImporteCuota decimal(18,2),
	CsiTipoCobro varchar(10),
	NumeroReferencia varchar(100),
	Respuesta varchar(1),
	NumeroOrdenTienda varchar(9),
	CodigoAccion varchar(3),
	ImporteAutorizado decimal(18,2),
	CodigoAutorizacion varchar(20),
	CodigoTienda varchar(9),
	NumeroTarjeta varchar(19),
	OrigenTarjeta varchar(1),
	EstadoSsicc int,
	TieneErrorSsicc bit,
	UsuarioCreacion varchar(20),
	UsuarioModificacion varchar(20),
	FechaCreacion datetime,
	FechaModificacion datetime
)

go

create index PagoEnLineaResultadoLog_Consultora on dbo.PagoEnLineaResultadoLog(CodigoConsultora)

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertPagoEnLineaResultadoLog]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].InsertPagoEnLineaResultadoLog
GO

create procedure dbo.InsertPagoEnLineaResultadoLog
@CodigoConsultora varchar(20),
@NumeroDocumento varchar(30),
@CampaniaId int,
@MontoPago decimal(18,2),
@MontoGastosAdministrativos decimal(18,2),
@TipoTarjeta varchar(20),
@CodigoError varchar(10),
@MensajeError varchar(100),
@IdGuidTransaccion varchar(100),
@IdGuidExternoTransaccion varchar(100),
@MerchantId varchar(9),
@IdTokenUsuario varchar(100),
@AliasNameTarjeta varchar(100),
@FechaTransaccion datetime,
@ResultadoValidacionCVV2 varchar(100),
@CsiMensaje varchar(100),
@IdUnicoTransaccion varchar(15),
@Etiqueta varchar(100),
@RespuestaSistemAntifraude varchar(20),
@CsiPorcentajeDescuento decimal(18,2),
@NumeroCuota varchar(2),
@TokenTarjetaGuardada varchar(100),
@CsiImporteComercio decimal(18,2),
@CsiCodigoPrograma varchar(20),
@DescripcionIndicadorComercioElectronico varchar(100),
@IndicadorComercioElectronico varchar(2),
@DescripcionCodigoAccion varchar(100),
@NombreBancoEmisor varchar(100),
@ImporteCuota decimal(18,2),
@CsiTipoCobro varchar(10),
@NumeroReferencia varchar(100),
@Respuesta varchar(1),
@NumeroOrdenTienda varchar(9),
@CodigoAccion varchar(3),
@ImporteAutorizado decimal(18,2),
@CodigoAutorizacion varchar(20),
@CodigoTienda varchar(9),
@NumeroTarjeta varchar(19),
@OrigenTarjeta varchar(1),
@UsuarioCreacion varchar(20)
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

insert into PagoEnLineaResultadoLog 
(CodigoConsultora,NumeroDocumento,CampaniaId,MontoPago,MontoGastosAdministrativos,TipoTarjeta,CodigoError,MensajeError,
IdGuidTransaccion,IdGuidExternoTransaccion,MerchantId,IdTokenUsuario,AliasNameTarjeta,FechaTransaccion,
ResultadoValidacionCVV2,CsiMensaje,IdUnicoTransaccion,Etiqueta,RespuestaSistemAntifraude,CsiPorcentajeDescuento,
NumeroCuota,TokenTarjetaGuardada,CsiImporteComercio,CsiCodigoPrograma,DescripcionIndicadorComercioElectronico,
IndicadorComercioElectronico,DescripcionCodigoAccion,NombreBancoEmisor,ImporteCuota,CsiTipoCobro,NumeroReferencia,
Respuesta,NumeroOrdenTienda,CodigoAccion,ImporteAutorizado,CodigoAutorizacion,CodigoTienda,NumeroTarjeta,OrigenTarjeta,
UsuarioCreacion,UsuarioModificacion,FechaCreacion,FechaModificacion)
values
(@CodigoConsultora,@NumeroDocumento,@CampaniaId,@MontoPago,@MontoGastosAdministrativos,@TipoTarjeta,@CodigoError,@MensajeError,
@IdGuidTransaccion,@IdGuidExternoTransaccion,@MerchantId,@IdTokenUsuario,@AliasNameTarjeta,@FechaTransaccion,
@ResultadoValidacionCVV2,@CsiMensaje,@IdUnicoTransaccion,@Etiqueta,@RespuestaSistemAntifraude,@CsiPorcentajeDescuento,
@NumeroCuota,@TokenTarjetaGuardada,@CsiImporteComercio,@CsiCodigoPrograma,@DescripcionIndicadorComercioElectronico,
@IndicadorComercioElectronico,@DescripcionCodigoAccion,@NombreBancoEmisor,@ImporteCuota,@CsiTipoCobro,@NumeroReferencia,
@Respuesta,@NumeroOrdenTienda,@CodigoAccion,@ImporteAutorizado,@CodigoAutorizacion,@CodigoTienda,@NumeroTarjeta,@OrigenTarjeta,
@UsuarioCreacion,@UsuarioCreacion,@FechaGeneral,@FechaGeneral)

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerTokenTarjetaGuardadaByConsultora]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerTokenTarjetaGuardadaByConsultora
GO

create procedure dbo.ObtenerTokenTarjetaGuardadaByConsultora
@CodigoConsultora varchar(20)
as
/*
ObtenerTokenTarjetaGuardadaByConsultora '000758833'
*/
begin

select top 1 IdTokenUsuario from PagoEnLineaResultadoLog
where CodigoConsultora = @CodigoConsultora and isnull(IdTokenUsuario,'') <> ''
order by 1 desc

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateMontoDeudaConsultora]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].UpdateMontoDeudaConsultora
GO

create procedure dbo.UpdateMontoDeudaConsultora
@CodigoConsultora varchar(20),
@MontoDeuda decimal(18,2)
as
begin

update ods.consultora set MontoSaldoActual = @MontoDeuda where Codigo = @CodigoConsultora

end

go

USE BelcorpMexico
GO

if not exists (select 1 from ConfiguracionPais where Codigo = 'PAYONLINE')
begin

--select * from configuracionpais
-- SOLO PERU ESTADO = 1 LOS DEMAS 0

insert into ConfiguracionPais
(Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,MobileTituloMenu,DesktopTituloMenu,Logo,
Orden,DesktopTituloBanner,MobileTituloBanner,DesktopSubTituloBanner,MobileSubTituloBanner,DesktopFondoBanner,MobileFondoBanner,
DesktopLogoBanner,MobileLogoBanner,UrlMenu,OrdenBpt,MobileOrden,MobileOrdenBPT)
values
('PAYONLINE',1,'Pago en Línea',0,0,0,null,null,null,
0,null,null,null,null,null,null,
null,null,null,0,0,0)

end

go

alter table TablaLogicaDatos alter column Codigo varchar(150)

go

if not exists (select 1 from TablaLogica where TablaLogicaID = 122)
begin

insert into TablaLogica (TablaLogicaID,Descripcion) values (122,'Valores Pago en Línea')

insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12201,122,'148009103','Codigo de comercio')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12202,122,'AKIAJM6EP4YHGUJMNUNA','AccessKey Id')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12203,122,'UPgia3zgvVNXk6YFBh8CFAt8UYq9dScfh1jf7DWd','SecretAccessKey')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12204,122,'https://devapice.vnforapps.com/api.ecommerce/api/v1/ecommerce/token/','URL sesión para el botón de pagos')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12205,122,'https://devapice.vnforapps.com/api.tokenization/api/v2/merchant/','URL para numero pedido')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12206,122,'3','% Gastos Administrativos')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12207,122,'https://static-content.vnforapps.com/v1/js/checkout.js?qa=true','URL Libreria Pago Visa')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12208,122,'https://devpsv.vnforapps.com/api.authorization/api/v1/authorization/web/','URL Autorizacion para el botón de pagos')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12209,122,'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/Matriz/PE/Logo_Esika.png','URL Logo Pasarela Pagos')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12210,122,'#e81c36','Color Boton Pagar Pasarela Pagos')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12211,122,'Los pagos realizados después de las 10:00 p.m. serán efectivos al día siguiente.','Mensaje Información Pago Exitoso')

end

go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaResultadoLog') and type = 'U')
   drop table dbo.PagoEnLineaResultadoLog
go

create table dbo.PagoEnLineaResultadoLog
(
	PagoEnLineaResultadoLogId int identity(1,1) primary key,
	CodigoConsultora varchar(20),
	NumeroDocumento varchar(30),
	CampaniaId int,
	MontoPago decimal(18,2),
	MontoGastosAdministrativos decimal(18,2),
	TipoTarjeta varchar(20),
	CodigoError varchar(10),
	MensajeError varchar(100),
	IdGuidTransaccion varchar(100),
	IdGuidExternoTransaccion varchar(100),
	MerchantId varchar(9),	
	IdTokenUsuario varchar(100),
	AliasNameTarjeta varchar(100),
	FechaTransaccion datetime,
	ResultadoValidacionCVV2 varchar(100),
	CsiMensaje varchar(100),
	IdUnicoTransaccion varchar(15),
	Etiqueta varchar(100),
	RespuestaSistemAntifraude varchar(20),
	CsiPorcentajeDescuento decimal(18,2),
	NumeroCuota varchar(2),
	TokenTarjetaGuardada varchar(100),
	CsiImporteComercio decimal(18,2),
	CsiCodigoPrograma varchar(20),
	DescripcionIndicadorComercioElectronico varchar(100),
	IndicadorComercioElectronico varchar(2),
	DescripcionCodigoAccion varchar(100),
	NombreBancoEmisor varchar(100),	
	ImporteCuota decimal(18,2),
	CsiTipoCobro varchar(10),
	NumeroReferencia varchar(100),
	Respuesta varchar(1),
	NumeroOrdenTienda varchar(9),
	CodigoAccion varchar(3),
	ImporteAutorizado decimal(18,2),
	CodigoAutorizacion varchar(20),
	CodigoTienda varchar(9),
	NumeroTarjeta varchar(19),
	OrigenTarjeta varchar(1),
	EstadoSsicc int,
	TieneErrorSsicc bit,
	UsuarioCreacion varchar(20),
	UsuarioModificacion varchar(20),
	FechaCreacion datetime,
	FechaModificacion datetime
)

go

create index PagoEnLineaResultadoLog_Consultora on dbo.PagoEnLineaResultadoLog(CodigoConsultora)

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertPagoEnLineaResultadoLog]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].InsertPagoEnLineaResultadoLog
GO

create procedure dbo.InsertPagoEnLineaResultadoLog
@CodigoConsultora varchar(20),
@NumeroDocumento varchar(30),
@CampaniaId int,
@MontoPago decimal(18,2),
@MontoGastosAdministrativos decimal(18,2),
@TipoTarjeta varchar(20),
@CodigoError varchar(10),
@MensajeError varchar(100),
@IdGuidTransaccion varchar(100),
@IdGuidExternoTransaccion varchar(100),
@MerchantId varchar(9),
@IdTokenUsuario varchar(100),
@AliasNameTarjeta varchar(100),
@FechaTransaccion datetime,
@ResultadoValidacionCVV2 varchar(100),
@CsiMensaje varchar(100),
@IdUnicoTransaccion varchar(15),
@Etiqueta varchar(100),
@RespuestaSistemAntifraude varchar(20),
@CsiPorcentajeDescuento decimal(18,2),
@NumeroCuota varchar(2),
@TokenTarjetaGuardada varchar(100),
@CsiImporteComercio decimal(18,2),
@CsiCodigoPrograma varchar(20),
@DescripcionIndicadorComercioElectronico varchar(100),
@IndicadorComercioElectronico varchar(2),
@DescripcionCodigoAccion varchar(100),
@NombreBancoEmisor varchar(100),
@ImporteCuota decimal(18,2),
@CsiTipoCobro varchar(10),
@NumeroReferencia varchar(100),
@Respuesta varchar(1),
@NumeroOrdenTienda varchar(9),
@CodigoAccion varchar(3),
@ImporteAutorizado decimal(18,2),
@CodigoAutorizacion varchar(20),
@CodigoTienda varchar(9),
@NumeroTarjeta varchar(19),
@OrigenTarjeta varchar(1),
@UsuarioCreacion varchar(20)
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

insert into PagoEnLineaResultadoLog 
(CodigoConsultora,NumeroDocumento,CampaniaId,MontoPago,MontoGastosAdministrativos,TipoTarjeta,CodigoError,MensajeError,
IdGuidTransaccion,IdGuidExternoTransaccion,MerchantId,IdTokenUsuario,AliasNameTarjeta,FechaTransaccion,
ResultadoValidacionCVV2,CsiMensaje,IdUnicoTransaccion,Etiqueta,RespuestaSistemAntifraude,CsiPorcentajeDescuento,
NumeroCuota,TokenTarjetaGuardada,CsiImporteComercio,CsiCodigoPrograma,DescripcionIndicadorComercioElectronico,
IndicadorComercioElectronico,DescripcionCodigoAccion,NombreBancoEmisor,ImporteCuota,CsiTipoCobro,NumeroReferencia,
Respuesta,NumeroOrdenTienda,CodigoAccion,ImporteAutorizado,CodigoAutorizacion,CodigoTienda,NumeroTarjeta,OrigenTarjeta,
UsuarioCreacion,UsuarioModificacion,FechaCreacion,FechaModificacion)
values
(@CodigoConsultora,@NumeroDocumento,@CampaniaId,@MontoPago,@MontoGastosAdministrativos,@TipoTarjeta,@CodigoError,@MensajeError,
@IdGuidTransaccion,@IdGuidExternoTransaccion,@MerchantId,@IdTokenUsuario,@AliasNameTarjeta,@FechaTransaccion,
@ResultadoValidacionCVV2,@CsiMensaje,@IdUnicoTransaccion,@Etiqueta,@RespuestaSistemAntifraude,@CsiPorcentajeDescuento,
@NumeroCuota,@TokenTarjetaGuardada,@CsiImporteComercio,@CsiCodigoPrograma,@DescripcionIndicadorComercioElectronico,
@IndicadorComercioElectronico,@DescripcionCodigoAccion,@NombreBancoEmisor,@ImporteCuota,@CsiTipoCobro,@NumeroReferencia,
@Respuesta,@NumeroOrdenTienda,@CodigoAccion,@ImporteAutorizado,@CodigoAutorizacion,@CodigoTienda,@NumeroTarjeta,@OrigenTarjeta,
@UsuarioCreacion,@UsuarioCreacion,@FechaGeneral,@FechaGeneral)

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerTokenTarjetaGuardadaByConsultora]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerTokenTarjetaGuardadaByConsultora
GO

create procedure dbo.ObtenerTokenTarjetaGuardadaByConsultora
@CodigoConsultora varchar(20)
as
/*
ObtenerTokenTarjetaGuardadaByConsultora '000758833'
*/
begin

select top 1 IdTokenUsuario from PagoEnLineaResultadoLog
where CodigoConsultora = @CodigoConsultora and isnull(IdTokenUsuario,'') <> ''
order by 1 desc

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateMontoDeudaConsultora]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].UpdateMontoDeudaConsultora
GO

create procedure dbo.UpdateMontoDeudaConsultora
@CodigoConsultora varchar(20),
@MontoDeuda decimal(18,2)
as
begin

update ods.consultora set MontoSaldoActual = @MontoDeuda where Codigo = @CodigoConsultora

end

go

USE BelcorpColombia
GO

if not exists (select 1 from ConfiguracionPais where Codigo = 'PAYONLINE')
begin

--select * from configuracionpais
-- SOLO PERU ESTADO = 1 LOS DEMAS 0

insert into ConfiguracionPais
(Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,MobileTituloMenu,DesktopTituloMenu,Logo,
Orden,DesktopTituloBanner,MobileTituloBanner,DesktopSubTituloBanner,MobileSubTituloBanner,DesktopFondoBanner,MobileFondoBanner,
DesktopLogoBanner,MobileLogoBanner,UrlMenu,OrdenBpt,MobileOrden,MobileOrdenBPT)
values
('PAYONLINE',1,'Pago en Línea',0,0,0,null,null,null,
0,null,null,null,null,null,null,
null,null,null,0,0,0)

end

go

alter table TablaLogicaDatos alter column Codigo varchar(150)

go

if not exists (select 1 from TablaLogica where TablaLogicaID = 122)
begin

insert into TablaLogica (TablaLogicaID,Descripcion) values (122,'Valores Pago en Línea')

insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12201,122,'148009103','Codigo de comercio')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12202,122,'AKIAJM6EP4YHGUJMNUNA','AccessKey Id')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12203,122,'UPgia3zgvVNXk6YFBh8CFAt8UYq9dScfh1jf7DWd','SecretAccessKey')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12204,122,'https://devapice.vnforapps.com/api.ecommerce/api/v1/ecommerce/token/','URL sesión para el botón de pagos')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12205,122,'https://devapice.vnforapps.com/api.tokenization/api/v2/merchant/','URL para numero pedido')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12206,122,'3','% Gastos Administrativos')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12207,122,'https://static-content.vnforapps.com/v1/js/checkout.js?qa=true','URL Libreria Pago Visa')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12208,122,'https://devpsv.vnforapps.com/api.authorization/api/v1/authorization/web/','URL Autorizacion para el botón de pagos')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12209,122,'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/Matriz/PE/Logo_Esika.png','URL Logo Pasarela Pagos')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12210,122,'#e81c36','Color Boton Pagar Pasarela Pagos')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12211,122,'Los pagos realizados después de las 10:00 p.m. serán efectivos al día siguiente.','Mensaje Información Pago Exitoso')

end

go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaResultadoLog') and type = 'U')
   drop table dbo.PagoEnLineaResultadoLog
go

create table dbo.PagoEnLineaResultadoLog
(
	PagoEnLineaResultadoLogId int identity(1,1) primary key,
	CodigoConsultora varchar(20),
	NumeroDocumento varchar(30),
	CampaniaId int,
	MontoPago decimal(18,2),
	MontoGastosAdministrativos decimal(18,2),
	TipoTarjeta varchar(20),
	CodigoError varchar(10),
	MensajeError varchar(100),
	IdGuidTransaccion varchar(100),
	IdGuidExternoTransaccion varchar(100),
	MerchantId varchar(9),	
	IdTokenUsuario varchar(100),
	AliasNameTarjeta varchar(100),
	FechaTransaccion datetime,
	ResultadoValidacionCVV2 varchar(100),
	CsiMensaje varchar(100),
	IdUnicoTransaccion varchar(15),
	Etiqueta varchar(100),
	RespuestaSistemAntifraude varchar(20),
	CsiPorcentajeDescuento decimal(18,2),
	NumeroCuota varchar(2),
	TokenTarjetaGuardada varchar(100),
	CsiImporteComercio decimal(18,2),
	CsiCodigoPrograma varchar(20),
	DescripcionIndicadorComercioElectronico varchar(100),
	IndicadorComercioElectronico varchar(2),
	DescripcionCodigoAccion varchar(100),
	NombreBancoEmisor varchar(100),	
	ImporteCuota decimal(18,2),
	CsiTipoCobro varchar(10),
	NumeroReferencia varchar(100),
	Respuesta varchar(1),
	NumeroOrdenTienda varchar(9),
	CodigoAccion varchar(3),
	ImporteAutorizado decimal(18,2),
	CodigoAutorizacion varchar(20),
	CodigoTienda varchar(9),
	NumeroTarjeta varchar(19),
	OrigenTarjeta varchar(1),
	EstadoSsicc int,
	TieneErrorSsicc bit,
	UsuarioCreacion varchar(20),
	UsuarioModificacion varchar(20),
	FechaCreacion datetime,
	FechaModificacion datetime
)

go

create index PagoEnLineaResultadoLog_Consultora on dbo.PagoEnLineaResultadoLog(CodigoConsultora)

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertPagoEnLineaResultadoLog]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].InsertPagoEnLineaResultadoLog
GO

create procedure dbo.InsertPagoEnLineaResultadoLog
@CodigoConsultora varchar(20),
@NumeroDocumento varchar(30),
@CampaniaId int,
@MontoPago decimal(18,2),
@MontoGastosAdministrativos decimal(18,2),
@TipoTarjeta varchar(20),
@CodigoError varchar(10),
@MensajeError varchar(100),
@IdGuidTransaccion varchar(100),
@IdGuidExternoTransaccion varchar(100),
@MerchantId varchar(9),
@IdTokenUsuario varchar(100),
@AliasNameTarjeta varchar(100),
@FechaTransaccion datetime,
@ResultadoValidacionCVV2 varchar(100),
@CsiMensaje varchar(100),
@IdUnicoTransaccion varchar(15),
@Etiqueta varchar(100),
@RespuestaSistemAntifraude varchar(20),
@CsiPorcentajeDescuento decimal(18,2),
@NumeroCuota varchar(2),
@TokenTarjetaGuardada varchar(100),
@CsiImporteComercio decimal(18,2),
@CsiCodigoPrograma varchar(20),
@DescripcionIndicadorComercioElectronico varchar(100),
@IndicadorComercioElectronico varchar(2),
@DescripcionCodigoAccion varchar(100),
@NombreBancoEmisor varchar(100),
@ImporteCuota decimal(18,2),
@CsiTipoCobro varchar(10),
@NumeroReferencia varchar(100),
@Respuesta varchar(1),
@NumeroOrdenTienda varchar(9),
@CodigoAccion varchar(3),
@ImporteAutorizado decimal(18,2),
@CodigoAutorizacion varchar(20),
@CodigoTienda varchar(9),
@NumeroTarjeta varchar(19),
@OrigenTarjeta varchar(1),
@UsuarioCreacion varchar(20)
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

insert into PagoEnLineaResultadoLog 
(CodigoConsultora,NumeroDocumento,CampaniaId,MontoPago,MontoGastosAdministrativos,TipoTarjeta,CodigoError,MensajeError,
IdGuidTransaccion,IdGuidExternoTransaccion,MerchantId,IdTokenUsuario,AliasNameTarjeta,FechaTransaccion,
ResultadoValidacionCVV2,CsiMensaje,IdUnicoTransaccion,Etiqueta,RespuestaSistemAntifraude,CsiPorcentajeDescuento,
NumeroCuota,TokenTarjetaGuardada,CsiImporteComercio,CsiCodigoPrograma,DescripcionIndicadorComercioElectronico,
IndicadorComercioElectronico,DescripcionCodigoAccion,NombreBancoEmisor,ImporteCuota,CsiTipoCobro,NumeroReferencia,
Respuesta,NumeroOrdenTienda,CodigoAccion,ImporteAutorizado,CodigoAutorizacion,CodigoTienda,NumeroTarjeta,OrigenTarjeta,
UsuarioCreacion,UsuarioModificacion,FechaCreacion,FechaModificacion)
values
(@CodigoConsultora,@NumeroDocumento,@CampaniaId,@MontoPago,@MontoGastosAdministrativos,@TipoTarjeta,@CodigoError,@MensajeError,
@IdGuidTransaccion,@IdGuidExternoTransaccion,@MerchantId,@IdTokenUsuario,@AliasNameTarjeta,@FechaTransaccion,
@ResultadoValidacionCVV2,@CsiMensaje,@IdUnicoTransaccion,@Etiqueta,@RespuestaSistemAntifraude,@CsiPorcentajeDescuento,
@NumeroCuota,@TokenTarjetaGuardada,@CsiImporteComercio,@CsiCodigoPrograma,@DescripcionIndicadorComercioElectronico,
@IndicadorComercioElectronico,@DescripcionCodigoAccion,@NombreBancoEmisor,@ImporteCuota,@CsiTipoCobro,@NumeroReferencia,
@Respuesta,@NumeroOrdenTienda,@CodigoAccion,@ImporteAutorizado,@CodigoAutorizacion,@CodigoTienda,@NumeroTarjeta,@OrigenTarjeta,
@UsuarioCreacion,@UsuarioCreacion,@FechaGeneral,@FechaGeneral)

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerTokenTarjetaGuardadaByConsultora]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerTokenTarjetaGuardadaByConsultora
GO

create procedure dbo.ObtenerTokenTarjetaGuardadaByConsultora
@CodigoConsultora varchar(20)
as
/*
ObtenerTokenTarjetaGuardadaByConsultora '000758833'
*/
begin

select top 1 IdTokenUsuario from PagoEnLineaResultadoLog
where CodigoConsultora = @CodigoConsultora and isnull(IdTokenUsuario,'') <> ''
order by 1 desc

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateMontoDeudaConsultora]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].UpdateMontoDeudaConsultora
GO

create procedure dbo.UpdateMontoDeudaConsultora
@CodigoConsultora varchar(20),
@MontoDeuda decimal(18,2)
as
begin

update ods.consultora set MontoSaldoActual = @MontoDeuda where Codigo = @CodigoConsultora

end

go

USE BelcorpVenezuela
GO

if not exists (select 1 from ConfiguracionPais where Codigo = 'PAYONLINE')
begin

--select * from configuracionpais
-- SOLO PERU ESTADO = 1 LOS DEMAS 0

insert into ConfiguracionPais
(Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,MobileTituloMenu,DesktopTituloMenu,Logo,
Orden,DesktopTituloBanner,MobileTituloBanner,DesktopSubTituloBanner,MobileSubTituloBanner,DesktopFondoBanner,MobileFondoBanner,
DesktopLogoBanner,MobileLogoBanner,UrlMenu,OrdenBpt,MobileOrden,MobileOrdenBPT)
values
('PAYONLINE',1,'Pago en Línea',0,0,0,null,null,null,
0,null,null,null,null,null,null,
null,null,null,0,0,0)

end

go

alter table TablaLogicaDatos alter column Codigo varchar(150)

go

if not exists (select 1 from TablaLogica where TablaLogicaID = 122)
begin

insert into TablaLogica (TablaLogicaID,Descripcion) values (122,'Valores Pago en Línea')

insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12201,122,'148009103','Codigo de comercio')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12202,122,'AKIAJM6EP4YHGUJMNUNA','AccessKey Id')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12203,122,'UPgia3zgvVNXk6YFBh8CFAt8UYq9dScfh1jf7DWd','SecretAccessKey')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12204,122,'https://devapice.vnforapps.com/api.ecommerce/api/v1/ecommerce/token/','URL sesión para el botón de pagos')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12205,122,'https://devapice.vnforapps.com/api.tokenization/api/v2/merchant/','URL para numero pedido')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12206,122,'3','% Gastos Administrativos')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12207,122,'https://static-content.vnforapps.com/v1/js/checkout.js?qa=true','URL Libreria Pago Visa')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12208,122,'https://devpsv.vnforapps.com/api.authorization/api/v1/authorization/web/','URL Autorizacion para el botón de pagos')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12209,122,'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/Matriz/PE/Logo_Esika.png','URL Logo Pasarela Pagos')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12210,122,'#e81c36','Color Boton Pagar Pasarela Pagos')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12211,122,'Los pagos realizados después de las 10:00 p.m. serán efectivos al día siguiente.','Mensaje Información Pago Exitoso')

end

go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaResultadoLog') and type = 'U')
   drop table dbo.PagoEnLineaResultadoLog
go

create table dbo.PagoEnLineaResultadoLog
(
	PagoEnLineaResultadoLogId int identity(1,1) primary key,
	CodigoConsultora varchar(20),
	NumeroDocumento varchar(30),
	CampaniaId int,
	MontoPago decimal(18,2),
	MontoGastosAdministrativos decimal(18,2),
	TipoTarjeta varchar(20),
	CodigoError varchar(10),
	MensajeError varchar(100),
	IdGuidTransaccion varchar(100),
	IdGuidExternoTransaccion varchar(100),
	MerchantId varchar(9),	
	IdTokenUsuario varchar(100),
	AliasNameTarjeta varchar(100),
	FechaTransaccion datetime,
	ResultadoValidacionCVV2 varchar(100),
	CsiMensaje varchar(100),
	IdUnicoTransaccion varchar(15),
	Etiqueta varchar(100),
	RespuestaSistemAntifraude varchar(20),
	CsiPorcentajeDescuento decimal(18,2),
	NumeroCuota varchar(2),
	TokenTarjetaGuardada varchar(100),
	CsiImporteComercio decimal(18,2),
	CsiCodigoPrograma varchar(20),
	DescripcionIndicadorComercioElectronico varchar(100),
	IndicadorComercioElectronico varchar(2),
	DescripcionCodigoAccion varchar(100),
	NombreBancoEmisor varchar(100),	
	ImporteCuota decimal(18,2),
	CsiTipoCobro varchar(10),
	NumeroReferencia varchar(100),
	Respuesta varchar(1),
	NumeroOrdenTienda varchar(9),
	CodigoAccion varchar(3),
	ImporteAutorizado decimal(18,2),
	CodigoAutorizacion varchar(20),
	CodigoTienda varchar(9),
	NumeroTarjeta varchar(19),
	OrigenTarjeta varchar(1),
	EstadoSsicc int,
	TieneErrorSsicc bit,
	UsuarioCreacion varchar(20),
	UsuarioModificacion varchar(20),
	FechaCreacion datetime,
	FechaModificacion datetime
)

go

create index PagoEnLineaResultadoLog_Consultora on dbo.PagoEnLineaResultadoLog(CodigoConsultora)

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertPagoEnLineaResultadoLog]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].InsertPagoEnLineaResultadoLog
GO

create procedure dbo.InsertPagoEnLineaResultadoLog
@CodigoConsultora varchar(20),
@NumeroDocumento varchar(30),
@CampaniaId int,
@MontoPago decimal(18,2),
@MontoGastosAdministrativos decimal(18,2),
@TipoTarjeta varchar(20),
@CodigoError varchar(10),
@MensajeError varchar(100),
@IdGuidTransaccion varchar(100),
@IdGuidExternoTransaccion varchar(100),
@MerchantId varchar(9),
@IdTokenUsuario varchar(100),
@AliasNameTarjeta varchar(100),
@FechaTransaccion datetime,
@ResultadoValidacionCVV2 varchar(100),
@CsiMensaje varchar(100),
@IdUnicoTransaccion varchar(15),
@Etiqueta varchar(100),
@RespuestaSistemAntifraude varchar(20),
@CsiPorcentajeDescuento decimal(18,2),
@NumeroCuota varchar(2),
@TokenTarjetaGuardada varchar(100),
@CsiImporteComercio decimal(18,2),
@CsiCodigoPrograma varchar(20),
@DescripcionIndicadorComercioElectronico varchar(100),
@IndicadorComercioElectronico varchar(2),
@DescripcionCodigoAccion varchar(100),
@NombreBancoEmisor varchar(100),
@ImporteCuota decimal(18,2),
@CsiTipoCobro varchar(10),
@NumeroReferencia varchar(100),
@Respuesta varchar(1),
@NumeroOrdenTienda varchar(9),
@CodigoAccion varchar(3),
@ImporteAutorizado decimal(18,2),
@CodigoAutorizacion varchar(20),
@CodigoTienda varchar(9),
@NumeroTarjeta varchar(19),
@OrigenTarjeta varchar(1),
@UsuarioCreacion varchar(20)
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

insert into PagoEnLineaResultadoLog 
(CodigoConsultora,NumeroDocumento,CampaniaId,MontoPago,MontoGastosAdministrativos,TipoTarjeta,CodigoError,MensajeError,
IdGuidTransaccion,IdGuidExternoTransaccion,MerchantId,IdTokenUsuario,AliasNameTarjeta,FechaTransaccion,
ResultadoValidacionCVV2,CsiMensaje,IdUnicoTransaccion,Etiqueta,RespuestaSistemAntifraude,CsiPorcentajeDescuento,
NumeroCuota,TokenTarjetaGuardada,CsiImporteComercio,CsiCodigoPrograma,DescripcionIndicadorComercioElectronico,
IndicadorComercioElectronico,DescripcionCodigoAccion,NombreBancoEmisor,ImporteCuota,CsiTipoCobro,NumeroReferencia,
Respuesta,NumeroOrdenTienda,CodigoAccion,ImporteAutorizado,CodigoAutorizacion,CodigoTienda,NumeroTarjeta,OrigenTarjeta,
UsuarioCreacion,UsuarioModificacion,FechaCreacion,FechaModificacion)
values
(@CodigoConsultora,@NumeroDocumento,@CampaniaId,@MontoPago,@MontoGastosAdministrativos,@TipoTarjeta,@CodigoError,@MensajeError,
@IdGuidTransaccion,@IdGuidExternoTransaccion,@MerchantId,@IdTokenUsuario,@AliasNameTarjeta,@FechaTransaccion,
@ResultadoValidacionCVV2,@CsiMensaje,@IdUnicoTransaccion,@Etiqueta,@RespuestaSistemAntifraude,@CsiPorcentajeDescuento,
@NumeroCuota,@TokenTarjetaGuardada,@CsiImporteComercio,@CsiCodigoPrograma,@DescripcionIndicadorComercioElectronico,
@IndicadorComercioElectronico,@DescripcionCodigoAccion,@NombreBancoEmisor,@ImporteCuota,@CsiTipoCobro,@NumeroReferencia,
@Respuesta,@NumeroOrdenTienda,@CodigoAccion,@ImporteAutorizado,@CodigoAutorizacion,@CodigoTienda,@NumeroTarjeta,@OrigenTarjeta,
@UsuarioCreacion,@UsuarioCreacion,@FechaGeneral,@FechaGeneral)

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerTokenTarjetaGuardadaByConsultora]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerTokenTarjetaGuardadaByConsultora
GO

create procedure dbo.ObtenerTokenTarjetaGuardadaByConsultora
@CodigoConsultora varchar(20)
as
/*
ObtenerTokenTarjetaGuardadaByConsultora '000758833'
*/
begin

select top 1 IdTokenUsuario from PagoEnLineaResultadoLog
where CodigoConsultora = @CodigoConsultora and isnull(IdTokenUsuario,'') <> ''
order by 1 desc

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateMontoDeudaConsultora]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].UpdateMontoDeudaConsultora
GO

create procedure dbo.UpdateMontoDeudaConsultora
@CodigoConsultora varchar(20),
@MontoDeuda decimal(18,2)
as
begin

update ods.consultora set MontoSaldoActual = @MontoDeuda where Codigo = @CodigoConsultora

end

go

USE BelcorpSalvador
GO

if not exists (select 1 from ConfiguracionPais where Codigo = 'PAYONLINE')
begin

--select * from configuracionpais
-- SOLO PERU ESTADO = 1 LOS DEMAS 0

insert into ConfiguracionPais
(Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,MobileTituloMenu,DesktopTituloMenu,Logo,
Orden,DesktopTituloBanner,MobileTituloBanner,DesktopSubTituloBanner,MobileSubTituloBanner,DesktopFondoBanner,MobileFondoBanner,
DesktopLogoBanner,MobileLogoBanner,UrlMenu,OrdenBpt,MobileOrden,MobileOrdenBPT)
values
('PAYONLINE',1,'Pago en Línea',0,0,0,null,null,null,
0,null,null,null,null,null,null,
null,null,null,0,0,0)

end

go

alter table TablaLogicaDatos alter column Codigo varchar(150)

go

if not exists (select 1 from TablaLogica where TablaLogicaID = 122)
begin

insert into TablaLogica (TablaLogicaID,Descripcion) values (122,'Valores Pago en Línea')

insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12201,122,'148009103','Codigo de comercio')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12202,122,'AKIAJM6EP4YHGUJMNUNA','AccessKey Id')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12203,122,'UPgia3zgvVNXk6YFBh8CFAt8UYq9dScfh1jf7DWd','SecretAccessKey')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12204,122,'https://devapice.vnforapps.com/api.ecommerce/api/v1/ecommerce/token/','URL sesión para el botón de pagos')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12205,122,'https://devapice.vnforapps.com/api.tokenization/api/v2/merchant/','URL para numero pedido')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12206,122,'3','% Gastos Administrativos')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12207,122,'https://static-content.vnforapps.com/v1/js/checkout.js?qa=true','URL Libreria Pago Visa')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12208,122,'https://devpsv.vnforapps.com/api.authorization/api/v1/authorization/web/','URL Autorizacion para el botón de pagos')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12209,122,'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/Matriz/PE/Logo_Esika.png','URL Logo Pasarela Pagos')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12210,122,'#e81c36','Color Boton Pagar Pasarela Pagos')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12211,122,'Los pagos realizados después de las 10:00 p.m. serán efectivos al día siguiente.','Mensaje Información Pago Exitoso')

end

go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaResultadoLog') and type = 'U')
   drop table dbo.PagoEnLineaResultadoLog
go

create table dbo.PagoEnLineaResultadoLog
(
	PagoEnLineaResultadoLogId int identity(1,1) primary key,
	CodigoConsultora varchar(20),
	NumeroDocumento varchar(30),
	CampaniaId int,
	MontoPago decimal(18,2),
	MontoGastosAdministrativos decimal(18,2),
	TipoTarjeta varchar(20),
	CodigoError varchar(10),
	MensajeError varchar(100),
	IdGuidTransaccion varchar(100),
	IdGuidExternoTransaccion varchar(100),
	MerchantId varchar(9),	
	IdTokenUsuario varchar(100),
	AliasNameTarjeta varchar(100),
	FechaTransaccion datetime,
	ResultadoValidacionCVV2 varchar(100),
	CsiMensaje varchar(100),
	IdUnicoTransaccion varchar(15),
	Etiqueta varchar(100),
	RespuestaSistemAntifraude varchar(20),
	CsiPorcentajeDescuento decimal(18,2),
	NumeroCuota varchar(2),
	TokenTarjetaGuardada varchar(100),
	CsiImporteComercio decimal(18,2),
	CsiCodigoPrograma varchar(20),
	DescripcionIndicadorComercioElectronico varchar(100),
	IndicadorComercioElectronico varchar(2),
	DescripcionCodigoAccion varchar(100),
	NombreBancoEmisor varchar(100),	
	ImporteCuota decimal(18,2),
	CsiTipoCobro varchar(10),
	NumeroReferencia varchar(100),
	Respuesta varchar(1),
	NumeroOrdenTienda varchar(9),
	CodigoAccion varchar(3),
	ImporteAutorizado decimal(18,2),
	CodigoAutorizacion varchar(20),
	CodigoTienda varchar(9),
	NumeroTarjeta varchar(19),
	OrigenTarjeta varchar(1),
	EstadoSsicc int,
	TieneErrorSsicc bit,
	UsuarioCreacion varchar(20),
	UsuarioModificacion varchar(20),
	FechaCreacion datetime,
	FechaModificacion datetime
)

go

create index PagoEnLineaResultadoLog_Consultora on dbo.PagoEnLineaResultadoLog(CodigoConsultora)

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertPagoEnLineaResultadoLog]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].InsertPagoEnLineaResultadoLog
GO

create procedure dbo.InsertPagoEnLineaResultadoLog
@CodigoConsultora varchar(20),
@NumeroDocumento varchar(30),
@CampaniaId int,
@MontoPago decimal(18,2),
@MontoGastosAdministrativos decimal(18,2),
@TipoTarjeta varchar(20),
@CodigoError varchar(10),
@MensajeError varchar(100),
@IdGuidTransaccion varchar(100),
@IdGuidExternoTransaccion varchar(100),
@MerchantId varchar(9),
@IdTokenUsuario varchar(100),
@AliasNameTarjeta varchar(100),
@FechaTransaccion datetime,
@ResultadoValidacionCVV2 varchar(100),
@CsiMensaje varchar(100),
@IdUnicoTransaccion varchar(15),
@Etiqueta varchar(100),
@RespuestaSistemAntifraude varchar(20),
@CsiPorcentajeDescuento decimal(18,2),
@NumeroCuota varchar(2),
@TokenTarjetaGuardada varchar(100),
@CsiImporteComercio decimal(18,2),
@CsiCodigoPrograma varchar(20),
@DescripcionIndicadorComercioElectronico varchar(100),
@IndicadorComercioElectronico varchar(2),
@DescripcionCodigoAccion varchar(100),
@NombreBancoEmisor varchar(100),
@ImporteCuota decimal(18,2),
@CsiTipoCobro varchar(10),
@NumeroReferencia varchar(100),
@Respuesta varchar(1),
@NumeroOrdenTienda varchar(9),
@CodigoAccion varchar(3),
@ImporteAutorizado decimal(18,2),
@CodigoAutorizacion varchar(20),
@CodigoTienda varchar(9),
@NumeroTarjeta varchar(19),
@OrigenTarjeta varchar(1),
@UsuarioCreacion varchar(20)
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

insert into PagoEnLineaResultadoLog 
(CodigoConsultora,NumeroDocumento,CampaniaId,MontoPago,MontoGastosAdministrativos,TipoTarjeta,CodigoError,MensajeError,
IdGuidTransaccion,IdGuidExternoTransaccion,MerchantId,IdTokenUsuario,AliasNameTarjeta,FechaTransaccion,
ResultadoValidacionCVV2,CsiMensaje,IdUnicoTransaccion,Etiqueta,RespuestaSistemAntifraude,CsiPorcentajeDescuento,
NumeroCuota,TokenTarjetaGuardada,CsiImporteComercio,CsiCodigoPrograma,DescripcionIndicadorComercioElectronico,
IndicadorComercioElectronico,DescripcionCodigoAccion,NombreBancoEmisor,ImporteCuota,CsiTipoCobro,NumeroReferencia,
Respuesta,NumeroOrdenTienda,CodigoAccion,ImporteAutorizado,CodigoAutorizacion,CodigoTienda,NumeroTarjeta,OrigenTarjeta,
UsuarioCreacion,UsuarioModificacion,FechaCreacion,FechaModificacion)
values
(@CodigoConsultora,@NumeroDocumento,@CampaniaId,@MontoPago,@MontoGastosAdministrativos,@TipoTarjeta,@CodigoError,@MensajeError,
@IdGuidTransaccion,@IdGuidExternoTransaccion,@MerchantId,@IdTokenUsuario,@AliasNameTarjeta,@FechaTransaccion,
@ResultadoValidacionCVV2,@CsiMensaje,@IdUnicoTransaccion,@Etiqueta,@RespuestaSistemAntifraude,@CsiPorcentajeDescuento,
@NumeroCuota,@TokenTarjetaGuardada,@CsiImporteComercio,@CsiCodigoPrograma,@DescripcionIndicadorComercioElectronico,
@IndicadorComercioElectronico,@DescripcionCodigoAccion,@NombreBancoEmisor,@ImporteCuota,@CsiTipoCobro,@NumeroReferencia,
@Respuesta,@NumeroOrdenTienda,@CodigoAccion,@ImporteAutorizado,@CodigoAutorizacion,@CodigoTienda,@NumeroTarjeta,@OrigenTarjeta,
@UsuarioCreacion,@UsuarioCreacion,@FechaGeneral,@FechaGeneral)

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerTokenTarjetaGuardadaByConsultora]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerTokenTarjetaGuardadaByConsultora
GO

create procedure dbo.ObtenerTokenTarjetaGuardadaByConsultora
@CodigoConsultora varchar(20)
as
/*
ObtenerTokenTarjetaGuardadaByConsultora '000758833'
*/
begin

select top 1 IdTokenUsuario from PagoEnLineaResultadoLog
where CodigoConsultora = @CodigoConsultora and isnull(IdTokenUsuario,'') <> ''
order by 1 desc

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateMontoDeudaConsultora]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].UpdateMontoDeudaConsultora
GO

create procedure dbo.UpdateMontoDeudaConsultora
@CodigoConsultora varchar(20),
@MontoDeuda decimal(18,2)
as
begin

update ods.consultora set MontoSaldoActual = @MontoDeuda where Codigo = @CodigoConsultora

end

go

USE BelcorpPuertoRico
GO

if not exists (select 1 from ConfiguracionPais where Codigo = 'PAYONLINE')
begin

--select * from configuracionpais
-- SOLO PERU ESTADO = 1 LOS DEMAS 0

insert into ConfiguracionPais
(Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,MobileTituloMenu,DesktopTituloMenu,Logo,
Orden,DesktopTituloBanner,MobileTituloBanner,DesktopSubTituloBanner,MobileSubTituloBanner,DesktopFondoBanner,MobileFondoBanner,
DesktopLogoBanner,MobileLogoBanner,UrlMenu,OrdenBpt,MobileOrden,MobileOrdenBPT)
values
('PAYONLINE',1,'Pago en Línea',0,0,0,null,null,null,
0,null,null,null,null,null,null,
null,null,null,0,0,0)

end

go

alter table TablaLogicaDatos alter column Codigo varchar(150)

go

if not exists (select 1 from TablaLogica where TablaLogicaID = 122)
begin

insert into TablaLogica (TablaLogicaID,Descripcion) values (122,'Valores Pago en Línea')

insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12201,122,'148009103','Codigo de comercio')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12202,122,'AKIAJM6EP4YHGUJMNUNA','AccessKey Id')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12203,122,'UPgia3zgvVNXk6YFBh8CFAt8UYq9dScfh1jf7DWd','SecretAccessKey')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12204,122,'https://devapice.vnforapps.com/api.ecommerce/api/v1/ecommerce/token/','URL sesión para el botón de pagos')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12205,122,'https://devapice.vnforapps.com/api.tokenization/api/v2/merchant/','URL para numero pedido')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12206,122,'3','% Gastos Administrativos')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12207,122,'https://static-content.vnforapps.com/v1/js/checkout.js?qa=true','URL Libreria Pago Visa')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12208,122,'https://devpsv.vnforapps.com/api.authorization/api/v1/authorization/web/','URL Autorizacion para el botón de pagos')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12209,122,'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/Matriz/PE/Logo_Esika.png','URL Logo Pasarela Pagos')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12210,122,'#e81c36','Color Boton Pagar Pasarela Pagos')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12211,122,'Los pagos realizados después de las 10:00 p.m. serán efectivos al día siguiente.','Mensaje Información Pago Exitoso')

end

go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaResultadoLog') and type = 'U')
   drop table dbo.PagoEnLineaResultadoLog
go

create table dbo.PagoEnLineaResultadoLog
(
	PagoEnLineaResultadoLogId int identity(1,1) primary key,
	CodigoConsultora varchar(20),
	NumeroDocumento varchar(30),
	CampaniaId int,
	MontoPago decimal(18,2),
	MontoGastosAdministrativos decimal(18,2),
	TipoTarjeta varchar(20),
	CodigoError varchar(10),
	MensajeError varchar(100),
	IdGuidTransaccion varchar(100),
	IdGuidExternoTransaccion varchar(100),
	MerchantId varchar(9),	
	IdTokenUsuario varchar(100),
	AliasNameTarjeta varchar(100),
	FechaTransaccion datetime,
	ResultadoValidacionCVV2 varchar(100),
	CsiMensaje varchar(100),
	IdUnicoTransaccion varchar(15),
	Etiqueta varchar(100),
	RespuestaSistemAntifraude varchar(20),
	CsiPorcentajeDescuento decimal(18,2),
	NumeroCuota varchar(2),
	TokenTarjetaGuardada varchar(100),
	CsiImporteComercio decimal(18,2),
	CsiCodigoPrograma varchar(20),
	DescripcionIndicadorComercioElectronico varchar(100),
	IndicadorComercioElectronico varchar(2),
	DescripcionCodigoAccion varchar(100),
	NombreBancoEmisor varchar(100),	
	ImporteCuota decimal(18,2),
	CsiTipoCobro varchar(10),
	NumeroReferencia varchar(100),
	Respuesta varchar(1),
	NumeroOrdenTienda varchar(9),
	CodigoAccion varchar(3),
	ImporteAutorizado decimal(18,2),
	CodigoAutorizacion varchar(20),
	CodigoTienda varchar(9),
	NumeroTarjeta varchar(19),
	OrigenTarjeta varchar(1),
	EstadoSsicc int,
	TieneErrorSsicc bit,
	UsuarioCreacion varchar(20),
	UsuarioModificacion varchar(20),
	FechaCreacion datetime,
	FechaModificacion datetime
)

go

create index PagoEnLineaResultadoLog_Consultora on dbo.PagoEnLineaResultadoLog(CodigoConsultora)

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertPagoEnLineaResultadoLog]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].InsertPagoEnLineaResultadoLog
GO

create procedure dbo.InsertPagoEnLineaResultadoLog
@CodigoConsultora varchar(20),
@NumeroDocumento varchar(30),
@CampaniaId int,
@MontoPago decimal(18,2),
@MontoGastosAdministrativos decimal(18,2),
@TipoTarjeta varchar(20),
@CodigoError varchar(10),
@MensajeError varchar(100),
@IdGuidTransaccion varchar(100),
@IdGuidExternoTransaccion varchar(100),
@MerchantId varchar(9),
@IdTokenUsuario varchar(100),
@AliasNameTarjeta varchar(100),
@FechaTransaccion datetime,
@ResultadoValidacionCVV2 varchar(100),
@CsiMensaje varchar(100),
@IdUnicoTransaccion varchar(15),
@Etiqueta varchar(100),
@RespuestaSistemAntifraude varchar(20),
@CsiPorcentajeDescuento decimal(18,2),
@NumeroCuota varchar(2),
@TokenTarjetaGuardada varchar(100),
@CsiImporteComercio decimal(18,2),
@CsiCodigoPrograma varchar(20),
@DescripcionIndicadorComercioElectronico varchar(100),
@IndicadorComercioElectronico varchar(2),
@DescripcionCodigoAccion varchar(100),
@NombreBancoEmisor varchar(100),
@ImporteCuota decimal(18,2),
@CsiTipoCobro varchar(10),
@NumeroReferencia varchar(100),
@Respuesta varchar(1),
@NumeroOrdenTienda varchar(9),
@CodigoAccion varchar(3),
@ImporteAutorizado decimal(18,2),
@CodigoAutorizacion varchar(20),
@CodigoTienda varchar(9),
@NumeroTarjeta varchar(19),
@OrigenTarjeta varchar(1),
@UsuarioCreacion varchar(20)
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

insert into PagoEnLineaResultadoLog 
(CodigoConsultora,NumeroDocumento,CampaniaId,MontoPago,MontoGastosAdministrativos,TipoTarjeta,CodigoError,MensajeError,
IdGuidTransaccion,IdGuidExternoTransaccion,MerchantId,IdTokenUsuario,AliasNameTarjeta,FechaTransaccion,
ResultadoValidacionCVV2,CsiMensaje,IdUnicoTransaccion,Etiqueta,RespuestaSistemAntifraude,CsiPorcentajeDescuento,
NumeroCuota,TokenTarjetaGuardada,CsiImporteComercio,CsiCodigoPrograma,DescripcionIndicadorComercioElectronico,
IndicadorComercioElectronico,DescripcionCodigoAccion,NombreBancoEmisor,ImporteCuota,CsiTipoCobro,NumeroReferencia,
Respuesta,NumeroOrdenTienda,CodigoAccion,ImporteAutorizado,CodigoAutorizacion,CodigoTienda,NumeroTarjeta,OrigenTarjeta,
UsuarioCreacion,UsuarioModificacion,FechaCreacion,FechaModificacion)
values
(@CodigoConsultora,@NumeroDocumento,@CampaniaId,@MontoPago,@MontoGastosAdministrativos,@TipoTarjeta,@CodigoError,@MensajeError,
@IdGuidTransaccion,@IdGuidExternoTransaccion,@MerchantId,@IdTokenUsuario,@AliasNameTarjeta,@FechaTransaccion,
@ResultadoValidacionCVV2,@CsiMensaje,@IdUnicoTransaccion,@Etiqueta,@RespuestaSistemAntifraude,@CsiPorcentajeDescuento,
@NumeroCuota,@TokenTarjetaGuardada,@CsiImporteComercio,@CsiCodigoPrograma,@DescripcionIndicadorComercioElectronico,
@IndicadorComercioElectronico,@DescripcionCodigoAccion,@NombreBancoEmisor,@ImporteCuota,@CsiTipoCobro,@NumeroReferencia,
@Respuesta,@NumeroOrdenTienda,@CodigoAccion,@ImporteAutorizado,@CodigoAutorizacion,@CodigoTienda,@NumeroTarjeta,@OrigenTarjeta,
@UsuarioCreacion,@UsuarioCreacion,@FechaGeneral,@FechaGeneral)

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerTokenTarjetaGuardadaByConsultora]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerTokenTarjetaGuardadaByConsultora
GO

create procedure dbo.ObtenerTokenTarjetaGuardadaByConsultora
@CodigoConsultora varchar(20)
as
/*
ObtenerTokenTarjetaGuardadaByConsultora '000758833'
*/
begin

select top 1 IdTokenUsuario from PagoEnLineaResultadoLog
where CodigoConsultora = @CodigoConsultora and isnull(IdTokenUsuario,'') <> ''
order by 1 desc

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateMontoDeudaConsultora]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].UpdateMontoDeudaConsultora
GO

create procedure dbo.UpdateMontoDeudaConsultora
@CodigoConsultora varchar(20),
@MontoDeuda decimal(18,2)
as
begin

update ods.consultora set MontoSaldoActual = @MontoDeuda where Codigo = @CodigoConsultora

end

go

USE BelcorpPanama
GO

if not exists (select 1 from ConfiguracionPais where Codigo = 'PAYONLINE')
begin

--select * from configuracionpais
-- SOLO PERU ESTADO = 1 LOS DEMAS 0

insert into ConfiguracionPais
(Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,MobileTituloMenu,DesktopTituloMenu,Logo,
Orden,DesktopTituloBanner,MobileTituloBanner,DesktopSubTituloBanner,MobileSubTituloBanner,DesktopFondoBanner,MobileFondoBanner,
DesktopLogoBanner,MobileLogoBanner,UrlMenu,OrdenBpt,MobileOrden,MobileOrdenBPT)
values
('PAYONLINE',1,'Pago en Línea',0,0,0,null,null,null,
0,null,null,null,null,null,null,
null,null,null,0,0,0)

end

go

alter table TablaLogicaDatos alter column Codigo varchar(150)

go

if not exists (select 1 from TablaLogica where TablaLogicaID = 122)
begin

insert into TablaLogica (TablaLogicaID,Descripcion) values (122,'Valores Pago en Línea')

insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12201,122,'148009103','Codigo de comercio')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12202,122,'AKIAJM6EP4YHGUJMNUNA','AccessKey Id')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12203,122,'UPgia3zgvVNXk6YFBh8CFAt8UYq9dScfh1jf7DWd','SecretAccessKey')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12204,122,'https://devapice.vnforapps.com/api.ecommerce/api/v1/ecommerce/token/','URL sesión para el botón de pagos')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12205,122,'https://devapice.vnforapps.com/api.tokenization/api/v2/merchant/','URL para numero pedido')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12206,122,'3','% Gastos Administrativos')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12207,122,'https://static-content.vnforapps.com/v1/js/checkout.js?qa=true','URL Libreria Pago Visa')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12208,122,'https://devpsv.vnforapps.com/api.authorization/api/v1/authorization/web/','URL Autorizacion para el botón de pagos')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12209,122,'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/Matriz/PE/Logo_Esika.png','URL Logo Pasarela Pagos')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12210,122,'#e81c36','Color Boton Pagar Pasarela Pagos')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12211,122,'Los pagos realizados después de las 10:00 p.m. serán efectivos al día siguiente.','Mensaje Información Pago Exitoso')

end

go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaResultadoLog') and type = 'U')
   drop table dbo.PagoEnLineaResultadoLog
go

create table dbo.PagoEnLineaResultadoLog
(
	PagoEnLineaResultadoLogId int identity(1,1) primary key,
	CodigoConsultora varchar(20),
	NumeroDocumento varchar(30),
	CampaniaId int,
	MontoPago decimal(18,2),
	MontoGastosAdministrativos decimal(18,2),
	TipoTarjeta varchar(20),
	CodigoError varchar(10),
	MensajeError varchar(100),
	IdGuidTransaccion varchar(100),
	IdGuidExternoTransaccion varchar(100),
	MerchantId varchar(9),	
	IdTokenUsuario varchar(100),
	AliasNameTarjeta varchar(100),
	FechaTransaccion datetime,
	ResultadoValidacionCVV2 varchar(100),
	CsiMensaje varchar(100),
	IdUnicoTransaccion varchar(15),
	Etiqueta varchar(100),
	RespuestaSistemAntifraude varchar(20),
	CsiPorcentajeDescuento decimal(18,2),
	NumeroCuota varchar(2),
	TokenTarjetaGuardada varchar(100),
	CsiImporteComercio decimal(18,2),
	CsiCodigoPrograma varchar(20),
	DescripcionIndicadorComercioElectronico varchar(100),
	IndicadorComercioElectronico varchar(2),
	DescripcionCodigoAccion varchar(100),
	NombreBancoEmisor varchar(100),	
	ImporteCuota decimal(18,2),
	CsiTipoCobro varchar(10),
	NumeroReferencia varchar(100),
	Respuesta varchar(1),
	NumeroOrdenTienda varchar(9),
	CodigoAccion varchar(3),
	ImporteAutorizado decimal(18,2),
	CodigoAutorizacion varchar(20),
	CodigoTienda varchar(9),
	NumeroTarjeta varchar(19),
	OrigenTarjeta varchar(1),
	EstadoSsicc int,
	TieneErrorSsicc bit,
	UsuarioCreacion varchar(20),
	UsuarioModificacion varchar(20),
	FechaCreacion datetime,
	FechaModificacion datetime
)

go

create index PagoEnLineaResultadoLog_Consultora on dbo.PagoEnLineaResultadoLog(CodigoConsultora)

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertPagoEnLineaResultadoLog]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].InsertPagoEnLineaResultadoLog
GO

create procedure dbo.InsertPagoEnLineaResultadoLog
@CodigoConsultora varchar(20),
@NumeroDocumento varchar(30),
@CampaniaId int,
@MontoPago decimal(18,2),
@MontoGastosAdministrativos decimal(18,2),
@TipoTarjeta varchar(20),
@CodigoError varchar(10),
@MensajeError varchar(100),
@IdGuidTransaccion varchar(100),
@IdGuidExternoTransaccion varchar(100),
@MerchantId varchar(9),
@IdTokenUsuario varchar(100),
@AliasNameTarjeta varchar(100),
@FechaTransaccion datetime,
@ResultadoValidacionCVV2 varchar(100),
@CsiMensaje varchar(100),
@IdUnicoTransaccion varchar(15),
@Etiqueta varchar(100),
@RespuestaSistemAntifraude varchar(20),
@CsiPorcentajeDescuento decimal(18,2),
@NumeroCuota varchar(2),
@TokenTarjetaGuardada varchar(100),
@CsiImporteComercio decimal(18,2),
@CsiCodigoPrograma varchar(20),
@DescripcionIndicadorComercioElectronico varchar(100),
@IndicadorComercioElectronico varchar(2),
@DescripcionCodigoAccion varchar(100),
@NombreBancoEmisor varchar(100),
@ImporteCuota decimal(18,2),
@CsiTipoCobro varchar(10),
@NumeroReferencia varchar(100),
@Respuesta varchar(1),
@NumeroOrdenTienda varchar(9),
@CodigoAccion varchar(3),
@ImporteAutorizado decimal(18,2),
@CodigoAutorizacion varchar(20),
@CodigoTienda varchar(9),
@NumeroTarjeta varchar(19),
@OrigenTarjeta varchar(1),
@UsuarioCreacion varchar(20)
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

insert into PagoEnLineaResultadoLog 
(CodigoConsultora,NumeroDocumento,CampaniaId,MontoPago,MontoGastosAdministrativos,TipoTarjeta,CodigoError,MensajeError,
IdGuidTransaccion,IdGuidExternoTransaccion,MerchantId,IdTokenUsuario,AliasNameTarjeta,FechaTransaccion,
ResultadoValidacionCVV2,CsiMensaje,IdUnicoTransaccion,Etiqueta,RespuestaSistemAntifraude,CsiPorcentajeDescuento,
NumeroCuota,TokenTarjetaGuardada,CsiImporteComercio,CsiCodigoPrograma,DescripcionIndicadorComercioElectronico,
IndicadorComercioElectronico,DescripcionCodigoAccion,NombreBancoEmisor,ImporteCuota,CsiTipoCobro,NumeroReferencia,
Respuesta,NumeroOrdenTienda,CodigoAccion,ImporteAutorizado,CodigoAutorizacion,CodigoTienda,NumeroTarjeta,OrigenTarjeta,
UsuarioCreacion,UsuarioModificacion,FechaCreacion,FechaModificacion)
values
(@CodigoConsultora,@NumeroDocumento,@CampaniaId,@MontoPago,@MontoGastosAdministrativos,@TipoTarjeta,@CodigoError,@MensajeError,
@IdGuidTransaccion,@IdGuidExternoTransaccion,@MerchantId,@IdTokenUsuario,@AliasNameTarjeta,@FechaTransaccion,
@ResultadoValidacionCVV2,@CsiMensaje,@IdUnicoTransaccion,@Etiqueta,@RespuestaSistemAntifraude,@CsiPorcentajeDescuento,
@NumeroCuota,@TokenTarjetaGuardada,@CsiImporteComercio,@CsiCodigoPrograma,@DescripcionIndicadorComercioElectronico,
@IndicadorComercioElectronico,@DescripcionCodigoAccion,@NombreBancoEmisor,@ImporteCuota,@CsiTipoCobro,@NumeroReferencia,
@Respuesta,@NumeroOrdenTienda,@CodigoAccion,@ImporteAutorizado,@CodigoAutorizacion,@CodigoTienda,@NumeroTarjeta,@OrigenTarjeta,
@UsuarioCreacion,@UsuarioCreacion,@FechaGeneral,@FechaGeneral)

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerTokenTarjetaGuardadaByConsultora]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerTokenTarjetaGuardadaByConsultora
GO

create procedure dbo.ObtenerTokenTarjetaGuardadaByConsultora
@CodigoConsultora varchar(20)
as
/*
ObtenerTokenTarjetaGuardadaByConsultora '000758833'
*/
begin

select top 1 IdTokenUsuario from PagoEnLineaResultadoLog
where CodigoConsultora = @CodigoConsultora and isnull(IdTokenUsuario,'') <> ''
order by 1 desc

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateMontoDeudaConsultora]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].UpdateMontoDeudaConsultora
GO

create procedure dbo.UpdateMontoDeudaConsultora
@CodigoConsultora varchar(20),
@MontoDeuda decimal(18,2)
as
begin

update ods.consultora set MontoSaldoActual = @MontoDeuda where Codigo = @CodigoConsultora

end

go

USE BelcorpGuatemala
GO

if not exists (select 1 from ConfiguracionPais where Codigo = 'PAYONLINE')
begin

--select * from configuracionpais
-- SOLO PERU ESTADO = 1 LOS DEMAS 0

insert into ConfiguracionPais
(Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,MobileTituloMenu,DesktopTituloMenu,Logo,
Orden,DesktopTituloBanner,MobileTituloBanner,DesktopSubTituloBanner,MobileSubTituloBanner,DesktopFondoBanner,MobileFondoBanner,
DesktopLogoBanner,MobileLogoBanner,UrlMenu,OrdenBpt,MobileOrden,MobileOrdenBPT)
values
('PAYONLINE',1,'Pago en Línea',0,0,0,null,null,null,
0,null,null,null,null,null,null,
null,null,null,0,0,0)

end

go

alter table TablaLogicaDatos alter column Codigo varchar(150)

go

if not exists (select 1 from TablaLogica where TablaLogicaID = 122)
begin

insert into TablaLogica (TablaLogicaID,Descripcion) values (122,'Valores Pago en Línea')

insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12201,122,'148009103','Codigo de comercio')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12202,122,'AKIAJM6EP4YHGUJMNUNA','AccessKey Id')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12203,122,'UPgia3zgvVNXk6YFBh8CFAt8UYq9dScfh1jf7DWd','SecretAccessKey')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12204,122,'https://devapice.vnforapps.com/api.ecommerce/api/v1/ecommerce/token/','URL sesión para el botón de pagos')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12205,122,'https://devapice.vnforapps.com/api.tokenization/api/v2/merchant/','URL para numero pedido')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12206,122,'3','% Gastos Administrativos')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12207,122,'https://static-content.vnforapps.com/v1/js/checkout.js?qa=true','URL Libreria Pago Visa')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12208,122,'https://devpsv.vnforapps.com/api.authorization/api/v1/authorization/web/','URL Autorizacion para el botón de pagos')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12209,122,'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/Matriz/PE/Logo_Esika.png','URL Logo Pasarela Pagos')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12210,122,'#e81c36','Color Boton Pagar Pasarela Pagos')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12211,122,'Los pagos realizados después de las 10:00 p.m. serán efectivos al día siguiente.','Mensaje Información Pago Exitoso')

end

go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaResultadoLog') and type = 'U')
   drop table dbo.PagoEnLineaResultadoLog
go

create table dbo.PagoEnLineaResultadoLog
(
	PagoEnLineaResultadoLogId int identity(1,1) primary key,
	CodigoConsultora varchar(20),
	NumeroDocumento varchar(30),
	CampaniaId int,
	MontoPago decimal(18,2),
	MontoGastosAdministrativos decimal(18,2),
	TipoTarjeta varchar(20),
	CodigoError varchar(10),
	MensajeError varchar(100),
	IdGuidTransaccion varchar(100),
	IdGuidExternoTransaccion varchar(100),
	MerchantId varchar(9),	
	IdTokenUsuario varchar(100),
	AliasNameTarjeta varchar(100),
	FechaTransaccion datetime,
	ResultadoValidacionCVV2 varchar(100),
	CsiMensaje varchar(100),
	IdUnicoTransaccion varchar(15),
	Etiqueta varchar(100),
	RespuestaSistemAntifraude varchar(20),
	CsiPorcentajeDescuento decimal(18,2),
	NumeroCuota varchar(2),
	TokenTarjetaGuardada varchar(100),
	CsiImporteComercio decimal(18,2),
	CsiCodigoPrograma varchar(20),
	DescripcionIndicadorComercioElectronico varchar(100),
	IndicadorComercioElectronico varchar(2),
	DescripcionCodigoAccion varchar(100),
	NombreBancoEmisor varchar(100),	
	ImporteCuota decimal(18,2),
	CsiTipoCobro varchar(10),
	NumeroReferencia varchar(100),
	Respuesta varchar(1),
	NumeroOrdenTienda varchar(9),
	CodigoAccion varchar(3),
	ImporteAutorizado decimal(18,2),
	CodigoAutorizacion varchar(20),
	CodigoTienda varchar(9),
	NumeroTarjeta varchar(19),
	OrigenTarjeta varchar(1),
	EstadoSsicc int,
	TieneErrorSsicc bit,
	UsuarioCreacion varchar(20),
	UsuarioModificacion varchar(20),
	FechaCreacion datetime,
	FechaModificacion datetime
)

go

create index PagoEnLineaResultadoLog_Consultora on dbo.PagoEnLineaResultadoLog(CodigoConsultora)

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertPagoEnLineaResultadoLog]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].InsertPagoEnLineaResultadoLog
GO

create procedure dbo.InsertPagoEnLineaResultadoLog
@CodigoConsultora varchar(20),
@NumeroDocumento varchar(30),
@CampaniaId int,
@MontoPago decimal(18,2),
@MontoGastosAdministrativos decimal(18,2),
@TipoTarjeta varchar(20),
@CodigoError varchar(10),
@MensajeError varchar(100),
@IdGuidTransaccion varchar(100),
@IdGuidExternoTransaccion varchar(100),
@MerchantId varchar(9),
@IdTokenUsuario varchar(100),
@AliasNameTarjeta varchar(100),
@FechaTransaccion datetime,
@ResultadoValidacionCVV2 varchar(100),
@CsiMensaje varchar(100),
@IdUnicoTransaccion varchar(15),
@Etiqueta varchar(100),
@RespuestaSistemAntifraude varchar(20),
@CsiPorcentajeDescuento decimal(18,2),
@NumeroCuota varchar(2),
@TokenTarjetaGuardada varchar(100),
@CsiImporteComercio decimal(18,2),
@CsiCodigoPrograma varchar(20),
@DescripcionIndicadorComercioElectronico varchar(100),
@IndicadorComercioElectronico varchar(2),
@DescripcionCodigoAccion varchar(100),
@NombreBancoEmisor varchar(100),
@ImporteCuota decimal(18,2),
@CsiTipoCobro varchar(10),
@NumeroReferencia varchar(100),
@Respuesta varchar(1),
@NumeroOrdenTienda varchar(9),
@CodigoAccion varchar(3),
@ImporteAutorizado decimal(18,2),
@CodigoAutorizacion varchar(20),
@CodigoTienda varchar(9),
@NumeroTarjeta varchar(19),
@OrigenTarjeta varchar(1),
@UsuarioCreacion varchar(20)
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

insert into PagoEnLineaResultadoLog 
(CodigoConsultora,NumeroDocumento,CampaniaId,MontoPago,MontoGastosAdministrativos,TipoTarjeta,CodigoError,MensajeError,
IdGuidTransaccion,IdGuidExternoTransaccion,MerchantId,IdTokenUsuario,AliasNameTarjeta,FechaTransaccion,
ResultadoValidacionCVV2,CsiMensaje,IdUnicoTransaccion,Etiqueta,RespuestaSistemAntifraude,CsiPorcentajeDescuento,
NumeroCuota,TokenTarjetaGuardada,CsiImporteComercio,CsiCodigoPrograma,DescripcionIndicadorComercioElectronico,
IndicadorComercioElectronico,DescripcionCodigoAccion,NombreBancoEmisor,ImporteCuota,CsiTipoCobro,NumeroReferencia,
Respuesta,NumeroOrdenTienda,CodigoAccion,ImporteAutorizado,CodigoAutorizacion,CodigoTienda,NumeroTarjeta,OrigenTarjeta,
UsuarioCreacion,UsuarioModificacion,FechaCreacion,FechaModificacion)
values
(@CodigoConsultora,@NumeroDocumento,@CampaniaId,@MontoPago,@MontoGastosAdministrativos,@TipoTarjeta,@CodigoError,@MensajeError,
@IdGuidTransaccion,@IdGuidExternoTransaccion,@MerchantId,@IdTokenUsuario,@AliasNameTarjeta,@FechaTransaccion,
@ResultadoValidacionCVV2,@CsiMensaje,@IdUnicoTransaccion,@Etiqueta,@RespuestaSistemAntifraude,@CsiPorcentajeDescuento,
@NumeroCuota,@TokenTarjetaGuardada,@CsiImporteComercio,@CsiCodigoPrograma,@DescripcionIndicadorComercioElectronico,
@IndicadorComercioElectronico,@DescripcionCodigoAccion,@NombreBancoEmisor,@ImporteCuota,@CsiTipoCobro,@NumeroReferencia,
@Respuesta,@NumeroOrdenTienda,@CodigoAccion,@ImporteAutorizado,@CodigoAutorizacion,@CodigoTienda,@NumeroTarjeta,@OrigenTarjeta,
@UsuarioCreacion,@UsuarioCreacion,@FechaGeneral,@FechaGeneral)

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerTokenTarjetaGuardadaByConsultora]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerTokenTarjetaGuardadaByConsultora
GO

create procedure dbo.ObtenerTokenTarjetaGuardadaByConsultora
@CodigoConsultora varchar(20)
as
/*
ObtenerTokenTarjetaGuardadaByConsultora '000758833'
*/
begin

select top 1 IdTokenUsuario from PagoEnLineaResultadoLog
where CodigoConsultora = @CodigoConsultora and isnull(IdTokenUsuario,'') <> ''
order by 1 desc

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateMontoDeudaConsultora]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].UpdateMontoDeudaConsultora
GO

create procedure dbo.UpdateMontoDeudaConsultora
@CodigoConsultora varchar(20),
@MontoDeuda decimal(18,2)
as
begin

update ods.consultora set MontoSaldoActual = @MontoDeuda where Codigo = @CodigoConsultora

end

go

USE BelcorpEcuador
GO

if not exists (select 1 from ConfiguracionPais where Codigo = 'PAYONLINE')
begin

--select * from configuracionpais
-- SOLO PERU ESTADO = 1 LOS DEMAS 0

insert into ConfiguracionPais
(Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,MobileTituloMenu,DesktopTituloMenu,Logo,
Orden,DesktopTituloBanner,MobileTituloBanner,DesktopSubTituloBanner,MobileSubTituloBanner,DesktopFondoBanner,MobileFondoBanner,
DesktopLogoBanner,MobileLogoBanner,UrlMenu,OrdenBpt,MobileOrden,MobileOrdenBPT)
values
('PAYONLINE',1,'Pago en Línea',0,0,0,null,null,null,
0,null,null,null,null,null,null,
null,null,null,0,0,0)

end

go

alter table TablaLogicaDatos alter column Codigo varchar(150)

go

if not exists (select 1 from TablaLogica where TablaLogicaID = 122)
begin

insert into TablaLogica (TablaLogicaID,Descripcion) values (122,'Valores Pago en Línea')

insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12201,122,'148009103','Codigo de comercio')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12202,122,'AKIAJM6EP4YHGUJMNUNA','AccessKey Id')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12203,122,'UPgia3zgvVNXk6YFBh8CFAt8UYq9dScfh1jf7DWd','SecretAccessKey')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12204,122,'https://devapice.vnforapps.com/api.ecommerce/api/v1/ecommerce/token/','URL sesión para el botón de pagos')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12205,122,'https://devapice.vnforapps.com/api.tokenization/api/v2/merchant/','URL para numero pedido')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12206,122,'3','% Gastos Administrativos')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12207,122,'https://static-content.vnforapps.com/v1/js/checkout.js?qa=true','URL Libreria Pago Visa')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12208,122,'https://devpsv.vnforapps.com/api.authorization/api/v1/authorization/web/','URL Autorizacion para el botón de pagos')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12209,122,'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/Matriz/PE/Logo_Esika.png','URL Logo Pasarela Pagos')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12210,122,'#e81c36','Color Boton Pagar Pasarela Pagos')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12211,122,'Los pagos realizados después de las 10:00 p.m. serán efectivos al día siguiente.','Mensaje Información Pago Exitoso')

end

go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaResultadoLog') and type = 'U')
   drop table dbo.PagoEnLineaResultadoLog
go

create table dbo.PagoEnLineaResultadoLog
(
	PagoEnLineaResultadoLogId int identity(1,1) primary key,
	CodigoConsultora varchar(20),
	NumeroDocumento varchar(30),
	CampaniaId int,
	MontoPago decimal(18,2),
	MontoGastosAdministrativos decimal(18,2),
	TipoTarjeta varchar(20),
	CodigoError varchar(10),
	MensajeError varchar(100),
	IdGuidTransaccion varchar(100),
	IdGuidExternoTransaccion varchar(100),
	MerchantId varchar(9),	
	IdTokenUsuario varchar(100),
	AliasNameTarjeta varchar(100),
	FechaTransaccion datetime,
	ResultadoValidacionCVV2 varchar(100),
	CsiMensaje varchar(100),
	IdUnicoTransaccion varchar(15),
	Etiqueta varchar(100),
	RespuestaSistemAntifraude varchar(20),
	CsiPorcentajeDescuento decimal(18,2),
	NumeroCuota varchar(2),
	TokenTarjetaGuardada varchar(100),
	CsiImporteComercio decimal(18,2),
	CsiCodigoPrograma varchar(20),
	DescripcionIndicadorComercioElectronico varchar(100),
	IndicadorComercioElectronico varchar(2),
	DescripcionCodigoAccion varchar(100),
	NombreBancoEmisor varchar(100),	
	ImporteCuota decimal(18,2),
	CsiTipoCobro varchar(10),
	NumeroReferencia varchar(100),
	Respuesta varchar(1),
	NumeroOrdenTienda varchar(9),
	CodigoAccion varchar(3),
	ImporteAutorizado decimal(18,2),
	CodigoAutorizacion varchar(20),
	CodigoTienda varchar(9),
	NumeroTarjeta varchar(19),
	OrigenTarjeta varchar(1),
	EstadoSsicc int,
	TieneErrorSsicc bit,
	UsuarioCreacion varchar(20),
	UsuarioModificacion varchar(20),
	FechaCreacion datetime,
	FechaModificacion datetime
)

go

create index PagoEnLineaResultadoLog_Consultora on dbo.PagoEnLineaResultadoLog(CodigoConsultora)

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertPagoEnLineaResultadoLog]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].InsertPagoEnLineaResultadoLog
GO

create procedure dbo.InsertPagoEnLineaResultadoLog
@CodigoConsultora varchar(20),
@NumeroDocumento varchar(30),
@CampaniaId int,
@MontoPago decimal(18,2),
@MontoGastosAdministrativos decimal(18,2),
@TipoTarjeta varchar(20),
@CodigoError varchar(10),
@MensajeError varchar(100),
@IdGuidTransaccion varchar(100),
@IdGuidExternoTransaccion varchar(100),
@MerchantId varchar(9),
@IdTokenUsuario varchar(100),
@AliasNameTarjeta varchar(100),
@FechaTransaccion datetime,
@ResultadoValidacionCVV2 varchar(100),
@CsiMensaje varchar(100),
@IdUnicoTransaccion varchar(15),
@Etiqueta varchar(100),
@RespuestaSistemAntifraude varchar(20),
@CsiPorcentajeDescuento decimal(18,2),
@NumeroCuota varchar(2),
@TokenTarjetaGuardada varchar(100),
@CsiImporteComercio decimal(18,2),
@CsiCodigoPrograma varchar(20),
@DescripcionIndicadorComercioElectronico varchar(100),
@IndicadorComercioElectronico varchar(2),
@DescripcionCodigoAccion varchar(100),
@NombreBancoEmisor varchar(100),
@ImporteCuota decimal(18,2),
@CsiTipoCobro varchar(10),
@NumeroReferencia varchar(100),
@Respuesta varchar(1),
@NumeroOrdenTienda varchar(9),
@CodigoAccion varchar(3),
@ImporteAutorizado decimal(18,2),
@CodigoAutorizacion varchar(20),
@CodigoTienda varchar(9),
@NumeroTarjeta varchar(19),
@OrigenTarjeta varchar(1),
@UsuarioCreacion varchar(20)
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

insert into PagoEnLineaResultadoLog 
(CodigoConsultora,NumeroDocumento,CampaniaId,MontoPago,MontoGastosAdministrativos,TipoTarjeta,CodigoError,MensajeError,
IdGuidTransaccion,IdGuidExternoTransaccion,MerchantId,IdTokenUsuario,AliasNameTarjeta,FechaTransaccion,
ResultadoValidacionCVV2,CsiMensaje,IdUnicoTransaccion,Etiqueta,RespuestaSistemAntifraude,CsiPorcentajeDescuento,
NumeroCuota,TokenTarjetaGuardada,CsiImporteComercio,CsiCodigoPrograma,DescripcionIndicadorComercioElectronico,
IndicadorComercioElectronico,DescripcionCodigoAccion,NombreBancoEmisor,ImporteCuota,CsiTipoCobro,NumeroReferencia,
Respuesta,NumeroOrdenTienda,CodigoAccion,ImporteAutorizado,CodigoAutorizacion,CodigoTienda,NumeroTarjeta,OrigenTarjeta,
UsuarioCreacion,UsuarioModificacion,FechaCreacion,FechaModificacion)
values
(@CodigoConsultora,@NumeroDocumento,@CampaniaId,@MontoPago,@MontoGastosAdministrativos,@TipoTarjeta,@CodigoError,@MensajeError,
@IdGuidTransaccion,@IdGuidExternoTransaccion,@MerchantId,@IdTokenUsuario,@AliasNameTarjeta,@FechaTransaccion,
@ResultadoValidacionCVV2,@CsiMensaje,@IdUnicoTransaccion,@Etiqueta,@RespuestaSistemAntifraude,@CsiPorcentajeDescuento,
@NumeroCuota,@TokenTarjetaGuardada,@CsiImporteComercio,@CsiCodigoPrograma,@DescripcionIndicadorComercioElectronico,
@IndicadorComercioElectronico,@DescripcionCodigoAccion,@NombreBancoEmisor,@ImporteCuota,@CsiTipoCobro,@NumeroReferencia,
@Respuesta,@NumeroOrdenTienda,@CodigoAccion,@ImporteAutorizado,@CodigoAutorizacion,@CodigoTienda,@NumeroTarjeta,@OrigenTarjeta,
@UsuarioCreacion,@UsuarioCreacion,@FechaGeneral,@FechaGeneral)

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerTokenTarjetaGuardadaByConsultora]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerTokenTarjetaGuardadaByConsultora
GO

create procedure dbo.ObtenerTokenTarjetaGuardadaByConsultora
@CodigoConsultora varchar(20)
as
/*
ObtenerTokenTarjetaGuardadaByConsultora '000758833'
*/
begin

select top 1 IdTokenUsuario from PagoEnLineaResultadoLog
where CodigoConsultora = @CodigoConsultora and isnull(IdTokenUsuario,'') <> ''
order by 1 desc

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateMontoDeudaConsultora]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].UpdateMontoDeudaConsultora
GO

create procedure dbo.UpdateMontoDeudaConsultora
@CodigoConsultora varchar(20),
@MontoDeuda decimal(18,2)
as
begin

update ods.consultora set MontoSaldoActual = @MontoDeuda where Codigo = @CodigoConsultora

end

go

USE BelcorpDominicana
GO

if not exists (select 1 from ConfiguracionPais where Codigo = 'PAYONLINE')
begin

--select * from configuracionpais
-- SOLO PERU ESTADO = 1 LOS DEMAS 0

insert into ConfiguracionPais
(Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,MobileTituloMenu,DesktopTituloMenu,Logo,
Orden,DesktopTituloBanner,MobileTituloBanner,DesktopSubTituloBanner,MobileSubTituloBanner,DesktopFondoBanner,MobileFondoBanner,
DesktopLogoBanner,MobileLogoBanner,UrlMenu,OrdenBpt,MobileOrden,MobileOrdenBPT)
values
('PAYONLINE',1,'Pago en Línea',0,0,0,null,null,null,
0,null,null,null,null,null,null,
null,null,null,0,0,0)

end

go

alter table TablaLogicaDatos alter column Codigo varchar(150)

go

if not exists (select 1 from TablaLogica where TablaLogicaID = 122)
begin

insert into TablaLogica (TablaLogicaID,Descripcion) values (122,'Valores Pago en Línea')

insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12201,122,'148009103','Codigo de comercio')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12202,122,'AKIAJM6EP4YHGUJMNUNA','AccessKey Id')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12203,122,'UPgia3zgvVNXk6YFBh8CFAt8UYq9dScfh1jf7DWd','SecretAccessKey')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12204,122,'https://devapice.vnforapps.com/api.ecommerce/api/v1/ecommerce/token/','URL sesión para el botón de pagos')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12205,122,'https://devapice.vnforapps.com/api.tokenization/api/v2/merchant/','URL para numero pedido')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12206,122,'3','% Gastos Administrativos')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12207,122,'https://static-content.vnforapps.com/v1/js/checkout.js?qa=true','URL Libreria Pago Visa')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12208,122,'https://devpsv.vnforapps.com/api.authorization/api/v1/authorization/web/','URL Autorizacion para el botón de pagos')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12209,122,'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/Matriz/PE/Logo_Esika.png','URL Logo Pasarela Pagos')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12210,122,'#e81c36','Color Boton Pagar Pasarela Pagos')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12211,122,'Los pagos realizados después de las 10:00 p.m. serán efectivos al día siguiente.','Mensaje Información Pago Exitoso')

end

go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaResultadoLog') and type = 'U')
   drop table dbo.PagoEnLineaResultadoLog
go

create table dbo.PagoEnLineaResultadoLog
(
	PagoEnLineaResultadoLogId int identity(1,1) primary key,
	CodigoConsultora varchar(20),
	NumeroDocumento varchar(30),
	CampaniaId int,
	MontoPago decimal(18,2),
	MontoGastosAdministrativos decimal(18,2),
	TipoTarjeta varchar(20),
	CodigoError varchar(10),
	MensajeError varchar(100),
	IdGuidTransaccion varchar(100),
	IdGuidExternoTransaccion varchar(100),
	MerchantId varchar(9),	
	IdTokenUsuario varchar(100),
	AliasNameTarjeta varchar(100),
	FechaTransaccion datetime,
	ResultadoValidacionCVV2 varchar(100),
	CsiMensaje varchar(100),
	IdUnicoTransaccion varchar(15),
	Etiqueta varchar(100),
	RespuestaSistemAntifraude varchar(20),
	CsiPorcentajeDescuento decimal(18,2),
	NumeroCuota varchar(2),
	TokenTarjetaGuardada varchar(100),
	CsiImporteComercio decimal(18,2),
	CsiCodigoPrograma varchar(20),
	DescripcionIndicadorComercioElectronico varchar(100),
	IndicadorComercioElectronico varchar(2),
	DescripcionCodigoAccion varchar(100),
	NombreBancoEmisor varchar(100),	
	ImporteCuota decimal(18,2),
	CsiTipoCobro varchar(10),
	NumeroReferencia varchar(100),
	Respuesta varchar(1),
	NumeroOrdenTienda varchar(9),
	CodigoAccion varchar(3),
	ImporteAutorizado decimal(18,2),
	CodigoAutorizacion varchar(20),
	CodigoTienda varchar(9),
	NumeroTarjeta varchar(19),
	OrigenTarjeta varchar(1),
	EstadoSsicc int,
	TieneErrorSsicc bit,
	UsuarioCreacion varchar(20),
	UsuarioModificacion varchar(20),
	FechaCreacion datetime,
	FechaModificacion datetime
)

go

create index PagoEnLineaResultadoLog_Consultora on dbo.PagoEnLineaResultadoLog(CodigoConsultora)

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertPagoEnLineaResultadoLog]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].InsertPagoEnLineaResultadoLog
GO

create procedure dbo.InsertPagoEnLineaResultadoLog
@CodigoConsultora varchar(20),
@NumeroDocumento varchar(30),
@CampaniaId int,
@MontoPago decimal(18,2),
@MontoGastosAdministrativos decimal(18,2),
@TipoTarjeta varchar(20),
@CodigoError varchar(10),
@MensajeError varchar(100),
@IdGuidTransaccion varchar(100),
@IdGuidExternoTransaccion varchar(100),
@MerchantId varchar(9),
@IdTokenUsuario varchar(100),
@AliasNameTarjeta varchar(100),
@FechaTransaccion datetime,
@ResultadoValidacionCVV2 varchar(100),
@CsiMensaje varchar(100),
@IdUnicoTransaccion varchar(15),
@Etiqueta varchar(100),
@RespuestaSistemAntifraude varchar(20),
@CsiPorcentajeDescuento decimal(18,2),
@NumeroCuota varchar(2),
@TokenTarjetaGuardada varchar(100),
@CsiImporteComercio decimal(18,2),
@CsiCodigoPrograma varchar(20),
@DescripcionIndicadorComercioElectronico varchar(100),
@IndicadorComercioElectronico varchar(2),
@DescripcionCodigoAccion varchar(100),
@NombreBancoEmisor varchar(100),
@ImporteCuota decimal(18,2),
@CsiTipoCobro varchar(10),
@NumeroReferencia varchar(100),
@Respuesta varchar(1),
@NumeroOrdenTienda varchar(9),
@CodigoAccion varchar(3),
@ImporteAutorizado decimal(18,2),
@CodigoAutorizacion varchar(20),
@CodigoTienda varchar(9),
@NumeroTarjeta varchar(19),
@OrigenTarjeta varchar(1),
@UsuarioCreacion varchar(20)
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

insert into PagoEnLineaResultadoLog 
(CodigoConsultora,NumeroDocumento,CampaniaId,MontoPago,MontoGastosAdministrativos,TipoTarjeta,CodigoError,MensajeError,
IdGuidTransaccion,IdGuidExternoTransaccion,MerchantId,IdTokenUsuario,AliasNameTarjeta,FechaTransaccion,
ResultadoValidacionCVV2,CsiMensaje,IdUnicoTransaccion,Etiqueta,RespuestaSistemAntifraude,CsiPorcentajeDescuento,
NumeroCuota,TokenTarjetaGuardada,CsiImporteComercio,CsiCodigoPrograma,DescripcionIndicadorComercioElectronico,
IndicadorComercioElectronico,DescripcionCodigoAccion,NombreBancoEmisor,ImporteCuota,CsiTipoCobro,NumeroReferencia,
Respuesta,NumeroOrdenTienda,CodigoAccion,ImporteAutorizado,CodigoAutorizacion,CodigoTienda,NumeroTarjeta,OrigenTarjeta,
UsuarioCreacion,UsuarioModificacion,FechaCreacion,FechaModificacion)
values
(@CodigoConsultora,@NumeroDocumento,@CampaniaId,@MontoPago,@MontoGastosAdministrativos,@TipoTarjeta,@CodigoError,@MensajeError,
@IdGuidTransaccion,@IdGuidExternoTransaccion,@MerchantId,@IdTokenUsuario,@AliasNameTarjeta,@FechaTransaccion,
@ResultadoValidacionCVV2,@CsiMensaje,@IdUnicoTransaccion,@Etiqueta,@RespuestaSistemAntifraude,@CsiPorcentajeDescuento,
@NumeroCuota,@TokenTarjetaGuardada,@CsiImporteComercio,@CsiCodigoPrograma,@DescripcionIndicadorComercioElectronico,
@IndicadorComercioElectronico,@DescripcionCodigoAccion,@NombreBancoEmisor,@ImporteCuota,@CsiTipoCobro,@NumeroReferencia,
@Respuesta,@NumeroOrdenTienda,@CodigoAccion,@ImporteAutorizado,@CodigoAutorizacion,@CodigoTienda,@NumeroTarjeta,@OrigenTarjeta,
@UsuarioCreacion,@UsuarioCreacion,@FechaGeneral,@FechaGeneral)

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerTokenTarjetaGuardadaByConsultora]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerTokenTarjetaGuardadaByConsultora
GO

create procedure dbo.ObtenerTokenTarjetaGuardadaByConsultora
@CodigoConsultora varchar(20)
as
/*
ObtenerTokenTarjetaGuardadaByConsultora '000758833'
*/
begin

select top 1 IdTokenUsuario from PagoEnLineaResultadoLog
where CodigoConsultora = @CodigoConsultora and isnull(IdTokenUsuario,'') <> ''
order by 1 desc

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateMontoDeudaConsultora]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].UpdateMontoDeudaConsultora
GO

create procedure dbo.UpdateMontoDeudaConsultora
@CodigoConsultora varchar(20),
@MontoDeuda decimal(18,2)
as
begin

update ods.consultora set MontoSaldoActual = @MontoDeuda where Codigo = @CodigoConsultora

end

go

USE BelcorpCostaRica
GO

if not exists (select 1 from ConfiguracionPais where Codigo = 'PAYONLINE')
begin

--select * from configuracionpais
-- SOLO PERU ESTADO = 1 LOS DEMAS 0

insert into ConfiguracionPais
(Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,MobileTituloMenu,DesktopTituloMenu,Logo,
Orden,DesktopTituloBanner,MobileTituloBanner,DesktopSubTituloBanner,MobileSubTituloBanner,DesktopFondoBanner,MobileFondoBanner,
DesktopLogoBanner,MobileLogoBanner,UrlMenu,OrdenBpt,MobileOrden,MobileOrdenBPT)
values
('PAYONLINE',1,'Pago en Línea',0,0,0,null,null,null,
0,null,null,null,null,null,null,
null,null,null,0,0,0)

end

go

alter table TablaLogicaDatos alter column Codigo varchar(150)

go

if not exists (select 1 from TablaLogica where TablaLogicaID = 122)
begin

insert into TablaLogica (TablaLogicaID,Descripcion) values (122,'Valores Pago en Línea')

insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12201,122,'148009103','Codigo de comercio')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12202,122,'AKIAJM6EP4YHGUJMNUNA','AccessKey Id')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12203,122,'UPgia3zgvVNXk6YFBh8CFAt8UYq9dScfh1jf7DWd','SecretAccessKey')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12204,122,'https://devapice.vnforapps.com/api.ecommerce/api/v1/ecommerce/token/','URL sesión para el botón de pagos')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12205,122,'https://devapice.vnforapps.com/api.tokenization/api/v2/merchant/','URL para numero pedido')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12206,122,'3','% Gastos Administrativos')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12207,122,'https://static-content.vnforapps.com/v1/js/checkout.js?qa=true','URL Libreria Pago Visa')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12208,122,'https://devpsv.vnforapps.com/api.authorization/api/v1/authorization/web/','URL Autorizacion para el botón de pagos')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12209,122,'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/Matriz/PE/Logo_Esika.png','URL Logo Pasarela Pagos')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12210,122,'#e81c36','Color Boton Pagar Pasarela Pagos')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12211,122,'Los pagos realizados después de las 10:00 p.m. serán efectivos al día siguiente.','Mensaje Información Pago Exitoso')

end

go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaResultadoLog') and type = 'U')
   drop table dbo.PagoEnLineaResultadoLog
go

create table dbo.PagoEnLineaResultadoLog
(
	PagoEnLineaResultadoLogId int identity(1,1) primary key,
	CodigoConsultora varchar(20),
	NumeroDocumento varchar(30),
	CampaniaId int,
	MontoPago decimal(18,2),
	MontoGastosAdministrativos decimal(18,2),
	TipoTarjeta varchar(20),
	CodigoError varchar(10),
	MensajeError varchar(100),
	IdGuidTransaccion varchar(100),
	IdGuidExternoTransaccion varchar(100),
	MerchantId varchar(9),	
	IdTokenUsuario varchar(100),
	AliasNameTarjeta varchar(100),
	FechaTransaccion datetime,
	ResultadoValidacionCVV2 varchar(100),
	CsiMensaje varchar(100),
	IdUnicoTransaccion varchar(15),
	Etiqueta varchar(100),
	RespuestaSistemAntifraude varchar(20),
	CsiPorcentajeDescuento decimal(18,2),
	NumeroCuota varchar(2),
	TokenTarjetaGuardada varchar(100),
	CsiImporteComercio decimal(18,2),
	CsiCodigoPrograma varchar(20),
	DescripcionIndicadorComercioElectronico varchar(100),
	IndicadorComercioElectronico varchar(2),
	DescripcionCodigoAccion varchar(100),
	NombreBancoEmisor varchar(100),	
	ImporteCuota decimal(18,2),
	CsiTipoCobro varchar(10),
	NumeroReferencia varchar(100),
	Respuesta varchar(1),
	NumeroOrdenTienda varchar(9),
	CodigoAccion varchar(3),
	ImporteAutorizado decimal(18,2),
	CodigoAutorizacion varchar(20),
	CodigoTienda varchar(9),
	NumeroTarjeta varchar(19),
	OrigenTarjeta varchar(1),
	EstadoSsicc int,
	TieneErrorSsicc bit,
	UsuarioCreacion varchar(20),
	UsuarioModificacion varchar(20),
	FechaCreacion datetime,
	FechaModificacion datetime
)

go

create index PagoEnLineaResultadoLog_Consultora on dbo.PagoEnLineaResultadoLog(CodigoConsultora)

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertPagoEnLineaResultadoLog]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].InsertPagoEnLineaResultadoLog
GO

create procedure dbo.InsertPagoEnLineaResultadoLog
@CodigoConsultora varchar(20),
@NumeroDocumento varchar(30),
@CampaniaId int,
@MontoPago decimal(18,2),
@MontoGastosAdministrativos decimal(18,2),
@TipoTarjeta varchar(20),
@CodigoError varchar(10),
@MensajeError varchar(100),
@IdGuidTransaccion varchar(100),
@IdGuidExternoTransaccion varchar(100),
@MerchantId varchar(9),
@IdTokenUsuario varchar(100),
@AliasNameTarjeta varchar(100),
@FechaTransaccion datetime,
@ResultadoValidacionCVV2 varchar(100),
@CsiMensaje varchar(100),
@IdUnicoTransaccion varchar(15),
@Etiqueta varchar(100),
@RespuestaSistemAntifraude varchar(20),
@CsiPorcentajeDescuento decimal(18,2),
@NumeroCuota varchar(2),
@TokenTarjetaGuardada varchar(100),
@CsiImporteComercio decimal(18,2),
@CsiCodigoPrograma varchar(20),
@DescripcionIndicadorComercioElectronico varchar(100),
@IndicadorComercioElectronico varchar(2),
@DescripcionCodigoAccion varchar(100),
@NombreBancoEmisor varchar(100),
@ImporteCuota decimal(18,2),
@CsiTipoCobro varchar(10),
@NumeroReferencia varchar(100),
@Respuesta varchar(1),
@NumeroOrdenTienda varchar(9),
@CodigoAccion varchar(3),
@ImporteAutorizado decimal(18,2),
@CodigoAutorizacion varchar(20),
@CodigoTienda varchar(9),
@NumeroTarjeta varchar(19),
@OrigenTarjeta varchar(1),
@UsuarioCreacion varchar(20)
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

insert into PagoEnLineaResultadoLog 
(CodigoConsultora,NumeroDocumento,CampaniaId,MontoPago,MontoGastosAdministrativos,TipoTarjeta,CodigoError,MensajeError,
IdGuidTransaccion,IdGuidExternoTransaccion,MerchantId,IdTokenUsuario,AliasNameTarjeta,FechaTransaccion,
ResultadoValidacionCVV2,CsiMensaje,IdUnicoTransaccion,Etiqueta,RespuestaSistemAntifraude,CsiPorcentajeDescuento,
NumeroCuota,TokenTarjetaGuardada,CsiImporteComercio,CsiCodigoPrograma,DescripcionIndicadorComercioElectronico,
IndicadorComercioElectronico,DescripcionCodigoAccion,NombreBancoEmisor,ImporteCuota,CsiTipoCobro,NumeroReferencia,
Respuesta,NumeroOrdenTienda,CodigoAccion,ImporteAutorizado,CodigoAutorizacion,CodigoTienda,NumeroTarjeta,OrigenTarjeta,
UsuarioCreacion,UsuarioModificacion,FechaCreacion,FechaModificacion)
values
(@CodigoConsultora,@NumeroDocumento,@CampaniaId,@MontoPago,@MontoGastosAdministrativos,@TipoTarjeta,@CodigoError,@MensajeError,
@IdGuidTransaccion,@IdGuidExternoTransaccion,@MerchantId,@IdTokenUsuario,@AliasNameTarjeta,@FechaTransaccion,
@ResultadoValidacionCVV2,@CsiMensaje,@IdUnicoTransaccion,@Etiqueta,@RespuestaSistemAntifraude,@CsiPorcentajeDescuento,
@NumeroCuota,@TokenTarjetaGuardada,@CsiImporteComercio,@CsiCodigoPrograma,@DescripcionIndicadorComercioElectronico,
@IndicadorComercioElectronico,@DescripcionCodigoAccion,@NombreBancoEmisor,@ImporteCuota,@CsiTipoCobro,@NumeroReferencia,
@Respuesta,@NumeroOrdenTienda,@CodigoAccion,@ImporteAutorizado,@CodigoAutorizacion,@CodigoTienda,@NumeroTarjeta,@OrigenTarjeta,
@UsuarioCreacion,@UsuarioCreacion,@FechaGeneral,@FechaGeneral)

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerTokenTarjetaGuardadaByConsultora]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerTokenTarjetaGuardadaByConsultora
GO

create procedure dbo.ObtenerTokenTarjetaGuardadaByConsultora
@CodigoConsultora varchar(20)
as
/*
ObtenerTokenTarjetaGuardadaByConsultora '000758833'
*/
begin

select top 1 IdTokenUsuario from PagoEnLineaResultadoLog
where CodigoConsultora = @CodigoConsultora and isnull(IdTokenUsuario,'') <> ''
order by 1 desc

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateMontoDeudaConsultora]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].UpdateMontoDeudaConsultora
GO

create procedure dbo.UpdateMontoDeudaConsultora
@CodigoConsultora varchar(20),
@MontoDeuda decimal(18,2)
as
begin

update ods.consultora set MontoSaldoActual = @MontoDeuda where Codigo = @CodigoConsultora

end

go

USE BelcorpChile
GO

if not exists (select 1 from ConfiguracionPais where Codigo = 'PAYONLINE')
begin

--select * from configuracionpais
-- SOLO PERU ESTADO = 1 LOS DEMAS 0

insert into ConfiguracionPais
(Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,MobileTituloMenu,DesktopTituloMenu,Logo,
Orden,DesktopTituloBanner,MobileTituloBanner,DesktopSubTituloBanner,MobileSubTituloBanner,DesktopFondoBanner,MobileFondoBanner,
DesktopLogoBanner,MobileLogoBanner,UrlMenu,OrdenBpt,MobileOrden,MobileOrdenBPT)
values
('PAYONLINE',1,'Pago en Línea',0,0,0,null,null,null,
0,null,null,null,null,null,null,
null,null,null,0,0,0)

end

go

alter table TablaLogicaDatos alter column Codigo varchar(150)

go

if not exists (select 1 from TablaLogica where TablaLogicaID = 122)
begin

insert into TablaLogica (TablaLogicaID,Descripcion) values (122,'Valores Pago en Línea')

insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12201,122,'148009103','Codigo de comercio')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12202,122,'AKIAJM6EP4YHGUJMNUNA','AccessKey Id')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12203,122,'UPgia3zgvVNXk6YFBh8CFAt8UYq9dScfh1jf7DWd','SecretAccessKey')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12204,122,'https://devapice.vnforapps.com/api.ecommerce/api/v1/ecommerce/token/','URL sesión para el botón de pagos')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12205,122,'https://devapice.vnforapps.com/api.tokenization/api/v2/merchant/','URL para numero pedido')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12206,122,'3','% Gastos Administrativos')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12207,122,'https://static-content.vnforapps.com/v1/js/checkout.js?qa=true','URL Libreria Pago Visa')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12208,122,'https://devpsv.vnforapps.com/api.authorization/api/v1/authorization/web/','URL Autorizacion para el botón de pagos')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12209,122,'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/Matriz/PE/Logo_Esika.png','URL Logo Pasarela Pagos')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12210,122,'#e81c36','Color Boton Pagar Pasarela Pagos')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12211,122,'Los pagos realizados después de las 10:00 p.m. serán efectivos al día siguiente.','Mensaje Información Pago Exitoso')

end

go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaResultadoLog') and type = 'U')
   drop table dbo.PagoEnLineaResultadoLog
go

create table dbo.PagoEnLineaResultadoLog
(
	PagoEnLineaResultadoLogId int identity(1,1) primary key,
	CodigoConsultora varchar(20),
	NumeroDocumento varchar(30),
	CampaniaId int,
	MontoPago decimal(18,2),
	MontoGastosAdministrativos decimal(18,2),
	TipoTarjeta varchar(20),
	CodigoError varchar(10),
	MensajeError varchar(100),
	IdGuidTransaccion varchar(100),
	IdGuidExternoTransaccion varchar(100),
	MerchantId varchar(9),	
	IdTokenUsuario varchar(100),
	AliasNameTarjeta varchar(100),
	FechaTransaccion datetime,
	ResultadoValidacionCVV2 varchar(100),
	CsiMensaje varchar(100),
	IdUnicoTransaccion varchar(15),
	Etiqueta varchar(100),
	RespuestaSistemAntifraude varchar(20),
	CsiPorcentajeDescuento decimal(18,2),
	NumeroCuota varchar(2),
	TokenTarjetaGuardada varchar(100),
	CsiImporteComercio decimal(18,2),
	CsiCodigoPrograma varchar(20),
	DescripcionIndicadorComercioElectronico varchar(100),
	IndicadorComercioElectronico varchar(2),
	DescripcionCodigoAccion varchar(100),
	NombreBancoEmisor varchar(100),	
	ImporteCuota decimal(18,2),
	CsiTipoCobro varchar(10),
	NumeroReferencia varchar(100),
	Respuesta varchar(1),
	NumeroOrdenTienda varchar(9),
	CodigoAccion varchar(3),
	ImporteAutorizado decimal(18,2),
	CodigoAutorizacion varchar(20),
	CodigoTienda varchar(9),
	NumeroTarjeta varchar(19),
	OrigenTarjeta varchar(1),
	EstadoSsicc int,
	TieneErrorSsicc bit,
	UsuarioCreacion varchar(20),
	UsuarioModificacion varchar(20),
	FechaCreacion datetime,
	FechaModificacion datetime
)

go

create index PagoEnLineaResultadoLog_Consultora on dbo.PagoEnLineaResultadoLog(CodigoConsultora)

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertPagoEnLineaResultadoLog]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].InsertPagoEnLineaResultadoLog
GO

create procedure dbo.InsertPagoEnLineaResultadoLog
@CodigoConsultora varchar(20),
@NumeroDocumento varchar(30),
@CampaniaId int,
@MontoPago decimal(18,2),
@MontoGastosAdministrativos decimal(18,2),
@TipoTarjeta varchar(20),
@CodigoError varchar(10),
@MensajeError varchar(100),
@IdGuidTransaccion varchar(100),
@IdGuidExternoTransaccion varchar(100),
@MerchantId varchar(9),
@IdTokenUsuario varchar(100),
@AliasNameTarjeta varchar(100),
@FechaTransaccion datetime,
@ResultadoValidacionCVV2 varchar(100),
@CsiMensaje varchar(100),
@IdUnicoTransaccion varchar(15),
@Etiqueta varchar(100),
@RespuestaSistemAntifraude varchar(20),
@CsiPorcentajeDescuento decimal(18,2),
@NumeroCuota varchar(2),
@TokenTarjetaGuardada varchar(100),
@CsiImporteComercio decimal(18,2),
@CsiCodigoPrograma varchar(20),
@DescripcionIndicadorComercioElectronico varchar(100),
@IndicadorComercioElectronico varchar(2),
@DescripcionCodigoAccion varchar(100),
@NombreBancoEmisor varchar(100),
@ImporteCuota decimal(18,2),
@CsiTipoCobro varchar(10),
@NumeroReferencia varchar(100),
@Respuesta varchar(1),
@NumeroOrdenTienda varchar(9),
@CodigoAccion varchar(3),
@ImporteAutorizado decimal(18,2),
@CodigoAutorizacion varchar(20),
@CodigoTienda varchar(9),
@NumeroTarjeta varchar(19),
@OrigenTarjeta varchar(1),
@UsuarioCreacion varchar(20)
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

insert into PagoEnLineaResultadoLog 
(CodigoConsultora,NumeroDocumento,CampaniaId,MontoPago,MontoGastosAdministrativos,TipoTarjeta,CodigoError,MensajeError,
IdGuidTransaccion,IdGuidExternoTransaccion,MerchantId,IdTokenUsuario,AliasNameTarjeta,FechaTransaccion,
ResultadoValidacionCVV2,CsiMensaje,IdUnicoTransaccion,Etiqueta,RespuestaSistemAntifraude,CsiPorcentajeDescuento,
NumeroCuota,TokenTarjetaGuardada,CsiImporteComercio,CsiCodigoPrograma,DescripcionIndicadorComercioElectronico,
IndicadorComercioElectronico,DescripcionCodigoAccion,NombreBancoEmisor,ImporteCuota,CsiTipoCobro,NumeroReferencia,
Respuesta,NumeroOrdenTienda,CodigoAccion,ImporteAutorizado,CodigoAutorizacion,CodigoTienda,NumeroTarjeta,OrigenTarjeta,
UsuarioCreacion,UsuarioModificacion,FechaCreacion,FechaModificacion)
values
(@CodigoConsultora,@NumeroDocumento,@CampaniaId,@MontoPago,@MontoGastosAdministrativos,@TipoTarjeta,@CodigoError,@MensajeError,
@IdGuidTransaccion,@IdGuidExternoTransaccion,@MerchantId,@IdTokenUsuario,@AliasNameTarjeta,@FechaTransaccion,
@ResultadoValidacionCVV2,@CsiMensaje,@IdUnicoTransaccion,@Etiqueta,@RespuestaSistemAntifraude,@CsiPorcentajeDescuento,
@NumeroCuota,@TokenTarjetaGuardada,@CsiImporteComercio,@CsiCodigoPrograma,@DescripcionIndicadorComercioElectronico,
@IndicadorComercioElectronico,@DescripcionCodigoAccion,@NombreBancoEmisor,@ImporteCuota,@CsiTipoCobro,@NumeroReferencia,
@Respuesta,@NumeroOrdenTienda,@CodigoAccion,@ImporteAutorizado,@CodigoAutorizacion,@CodigoTienda,@NumeroTarjeta,@OrigenTarjeta,
@UsuarioCreacion,@UsuarioCreacion,@FechaGeneral,@FechaGeneral)

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerTokenTarjetaGuardadaByConsultora]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerTokenTarjetaGuardadaByConsultora
GO

create procedure dbo.ObtenerTokenTarjetaGuardadaByConsultora
@CodigoConsultora varchar(20)
as
/*
ObtenerTokenTarjetaGuardadaByConsultora '000758833'
*/
begin

select top 1 IdTokenUsuario from PagoEnLineaResultadoLog
where CodigoConsultora = @CodigoConsultora and isnull(IdTokenUsuario,'') <> ''
order by 1 desc

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateMontoDeudaConsultora]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].UpdateMontoDeudaConsultora
GO

create procedure dbo.UpdateMontoDeudaConsultora
@CodigoConsultora varchar(20),
@MontoDeuda decimal(18,2)
as
begin

update ods.consultora set MontoSaldoActual = @MontoDeuda where Codigo = @CodigoConsultora

end

go

USE BelcorpBolivia
GO

if not exists (select 1 from ConfiguracionPais where Codigo = 'PAYONLINE')
begin

--select * from configuracionpais
-- SOLO PERU ESTADO = 1 LOS DEMAS 0

insert into ConfiguracionPais
(Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,MobileTituloMenu,DesktopTituloMenu,Logo,
Orden,DesktopTituloBanner,MobileTituloBanner,DesktopSubTituloBanner,MobileSubTituloBanner,DesktopFondoBanner,MobileFondoBanner,
DesktopLogoBanner,MobileLogoBanner,UrlMenu,OrdenBpt,MobileOrden,MobileOrdenBPT)
values
('PAYONLINE',1,'Pago en Línea',0,0,0,null,null,null,
0,null,null,null,null,null,null,
null,null,null,0,0,0)

end

go

alter table TablaLogicaDatos alter column Codigo varchar(150)

go

if not exists (select 1 from TablaLogica where TablaLogicaID = 122)
begin

insert into TablaLogica (TablaLogicaID,Descripcion) values (122,'Valores Pago en Línea')

insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12201,122,'148009103','Codigo de comercio')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12202,122,'AKIAJM6EP4YHGUJMNUNA','AccessKey Id')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12203,122,'UPgia3zgvVNXk6YFBh8CFAt8UYq9dScfh1jf7DWd','SecretAccessKey')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12204,122,'https://devapice.vnforapps.com/api.ecommerce/api/v1/ecommerce/token/','URL sesión para el botón de pagos')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12205,122,'https://devapice.vnforapps.com/api.tokenization/api/v2/merchant/','URL para numero pedido')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12206,122,'3','% Gastos Administrativos')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12207,122,'https://static-content.vnforapps.com/v1/js/checkout.js?qa=true','URL Libreria Pago Visa')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12208,122,'https://devpsv.vnforapps.com/api.authorization/api/v1/authorization/web/','URL Autorizacion para el botón de pagos')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12209,122,'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/Matriz/PE/Logo_Esika.png','URL Logo Pasarela Pagos')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12210,122,'#e81c36','Color Boton Pagar Pasarela Pagos')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12211,122,'Los pagos realizados después de las 10:00 p.m. serán efectivos al día siguiente.','Mensaje Información Pago Exitoso')

end

go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaResultadoLog') and type = 'U')
   drop table dbo.PagoEnLineaResultadoLog
go

create table dbo.PagoEnLineaResultadoLog
(
	PagoEnLineaResultadoLogId int identity(1,1) primary key,
	CodigoConsultora varchar(20),
	NumeroDocumento varchar(30),
	CampaniaId int,
	MontoPago decimal(18,2),
	MontoGastosAdministrativos decimal(18,2),
	TipoTarjeta varchar(20),
	CodigoError varchar(10),
	MensajeError varchar(100),
	IdGuidTransaccion varchar(100),
	IdGuidExternoTransaccion varchar(100),
	MerchantId varchar(9),	
	IdTokenUsuario varchar(100),
	AliasNameTarjeta varchar(100),
	FechaTransaccion datetime,
	ResultadoValidacionCVV2 varchar(100),
	CsiMensaje varchar(100),
	IdUnicoTransaccion varchar(15),
	Etiqueta varchar(100),
	RespuestaSistemAntifraude varchar(20),
	CsiPorcentajeDescuento decimal(18,2),
	NumeroCuota varchar(2),
	TokenTarjetaGuardada varchar(100),
	CsiImporteComercio decimal(18,2),
	CsiCodigoPrograma varchar(20),
	DescripcionIndicadorComercioElectronico varchar(100),
	IndicadorComercioElectronico varchar(2),
	DescripcionCodigoAccion varchar(100),
	NombreBancoEmisor varchar(100),	
	ImporteCuota decimal(18,2),
	CsiTipoCobro varchar(10),
	NumeroReferencia varchar(100),
	Respuesta varchar(1),
	NumeroOrdenTienda varchar(9),
	CodigoAccion varchar(3),
	ImporteAutorizado decimal(18,2),
	CodigoAutorizacion varchar(20),
	CodigoTienda varchar(9),
	NumeroTarjeta varchar(19),
	OrigenTarjeta varchar(1),
	EstadoSsicc int,
	TieneErrorSsicc bit,
	UsuarioCreacion varchar(20),
	UsuarioModificacion varchar(20),
	FechaCreacion datetime,
	FechaModificacion datetime
)

go

create index PagoEnLineaResultadoLog_Consultora on dbo.PagoEnLineaResultadoLog(CodigoConsultora)

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertPagoEnLineaResultadoLog]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].InsertPagoEnLineaResultadoLog
GO

create procedure dbo.InsertPagoEnLineaResultadoLog
@CodigoConsultora varchar(20),
@NumeroDocumento varchar(30),
@CampaniaId int,
@MontoPago decimal(18,2),
@MontoGastosAdministrativos decimal(18,2),
@TipoTarjeta varchar(20),
@CodigoError varchar(10),
@MensajeError varchar(100),
@IdGuidTransaccion varchar(100),
@IdGuidExternoTransaccion varchar(100),
@MerchantId varchar(9),
@IdTokenUsuario varchar(100),
@AliasNameTarjeta varchar(100),
@FechaTransaccion datetime,
@ResultadoValidacionCVV2 varchar(100),
@CsiMensaje varchar(100),
@IdUnicoTransaccion varchar(15),
@Etiqueta varchar(100),
@RespuestaSistemAntifraude varchar(20),
@CsiPorcentajeDescuento decimal(18,2),
@NumeroCuota varchar(2),
@TokenTarjetaGuardada varchar(100),
@CsiImporteComercio decimal(18,2),
@CsiCodigoPrograma varchar(20),
@DescripcionIndicadorComercioElectronico varchar(100),
@IndicadorComercioElectronico varchar(2),
@DescripcionCodigoAccion varchar(100),
@NombreBancoEmisor varchar(100),
@ImporteCuota decimal(18,2),
@CsiTipoCobro varchar(10),
@NumeroReferencia varchar(100),
@Respuesta varchar(1),
@NumeroOrdenTienda varchar(9),
@CodigoAccion varchar(3),
@ImporteAutorizado decimal(18,2),
@CodigoAutorizacion varchar(20),
@CodigoTienda varchar(9),
@NumeroTarjeta varchar(19),
@OrigenTarjeta varchar(1),
@UsuarioCreacion varchar(20)
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

insert into PagoEnLineaResultadoLog 
(CodigoConsultora,NumeroDocumento,CampaniaId,MontoPago,MontoGastosAdministrativos,TipoTarjeta,CodigoError,MensajeError,
IdGuidTransaccion,IdGuidExternoTransaccion,MerchantId,IdTokenUsuario,AliasNameTarjeta,FechaTransaccion,
ResultadoValidacionCVV2,CsiMensaje,IdUnicoTransaccion,Etiqueta,RespuestaSistemAntifraude,CsiPorcentajeDescuento,
NumeroCuota,TokenTarjetaGuardada,CsiImporteComercio,CsiCodigoPrograma,DescripcionIndicadorComercioElectronico,
IndicadorComercioElectronico,DescripcionCodigoAccion,NombreBancoEmisor,ImporteCuota,CsiTipoCobro,NumeroReferencia,
Respuesta,NumeroOrdenTienda,CodigoAccion,ImporteAutorizado,CodigoAutorizacion,CodigoTienda,NumeroTarjeta,OrigenTarjeta,
UsuarioCreacion,UsuarioModificacion,FechaCreacion,FechaModificacion)
values
(@CodigoConsultora,@NumeroDocumento,@CampaniaId,@MontoPago,@MontoGastosAdministrativos,@TipoTarjeta,@CodigoError,@MensajeError,
@IdGuidTransaccion,@IdGuidExternoTransaccion,@MerchantId,@IdTokenUsuario,@AliasNameTarjeta,@FechaTransaccion,
@ResultadoValidacionCVV2,@CsiMensaje,@IdUnicoTransaccion,@Etiqueta,@RespuestaSistemAntifraude,@CsiPorcentajeDescuento,
@NumeroCuota,@TokenTarjetaGuardada,@CsiImporteComercio,@CsiCodigoPrograma,@DescripcionIndicadorComercioElectronico,
@IndicadorComercioElectronico,@DescripcionCodigoAccion,@NombreBancoEmisor,@ImporteCuota,@CsiTipoCobro,@NumeroReferencia,
@Respuesta,@NumeroOrdenTienda,@CodigoAccion,@ImporteAutorizado,@CodigoAutorizacion,@CodigoTienda,@NumeroTarjeta,@OrigenTarjeta,
@UsuarioCreacion,@UsuarioCreacion,@FechaGeneral,@FechaGeneral)

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerTokenTarjetaGuardadaByConsultora]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerTokenTarjetaGuardadaByConsultora
GO

create procedure dbo.ObtenerTokenTarjetaGuardadaByConsultora
@CodigoConsultora varchar(20)
as
/*
ObtenerTokenTarjetaGuardadaByConsultora '000758833'
*/
begin

select top 1 IdTokenUsuario from PagoEnLineaResultadoLog
where CodigoConsultora = @CodigoConsultora and isnull(IdTokenUsuario,'') <> ''
order by 1 desc

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateMontoDeudaConsultora]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].UpdateMontoDeudaConsultora
GO

create procedure dbo.UpdateMontoDeudaConsultora
@CodigoConsultora varchar(20),
@MontoDeuda decimal(18,2)
as
begin

update ods.consultora set MontoSaldoActual = @MontoDeuda where Codigo = @CodigoConsultora

end

go

