GO
USE BelcorpPeru
GO
ALTER procedure dbo.InsertPagoEnLineaResultadoLog
@PagoEnLineaResultadoLogId int output,
@ConsultoraId bigint,
@CodigoConsultora varchar(20),
@NumeroDocumento varchar(30),
@CampaniaId int,
@FechaVencimiento datetime,
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

/*Info:
EstadoSsicc ===> 1: Por Evaluar, 2: Error al realizar el pago, 3: Procesado Servicio OK, 99: Procesado Servicio Error
*/
declare @EstadoSsicc int = 0
if (@CodigoError = '0' and @CodigoAccion = '000')
	set @EstadoSsicc = 1
else
	set @EstadoSsicc = 2

DECLARE @FechaGeneral DATETIME
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()
insert into PagoEnLineaResultadoLog
(ConsultoraId,CodigoConsultora,NumeroDocumento,CampaniaId,FechaVencimiento,MontoPago,MontoGastosAdministrativos,
TipoTarjeta,CodigoError,MensajeError,IdGuidTransaccion,IdGuidExternoTransaccion,MerchantId,IdTokenUsuario,
AliasNameTarjeta,FechaTransaccion,ResultadoValidacionCVV2,CsiMensaje,IdUnicoTransaccion,Etiqueta,
RespuestaSistemAntifraude,CsiPorcentajeDescuento,NumeroCuota,TokenTarjetaGuardada,CsiImporteComercio,
CsiCodigoPrograma,DescripcionIndicadorComercioElectronico,IndicadorComercioElectronico,DescripcionCodigoAccion,
NombreBancoEmisor,ImporteCuota,CsiTipoCobro,NumeroReferencia,Respuesta,NumeroOrdenTienda,CodigoAccion,
ImporteAutorizado,CodigoAutorizacion,CodigoTienda,NumeroTarjeta,OrigenTarjeta,EstadoSsicc,
Visualizado,UsuarioCreacion,UsuarioModificacion,FechaCreacion,FechaModificacion)
values
(@ConsultoraId,@CodigoConsultora,@NumeroDocumento,@CampaniaId,@FechaVencimiento,@MontoPago,@MontoGastosAdministrativos,
@TipoTarjeta,@CodigoError,@MensajeError,@IdGuidTransaccion,@IdGuidExternoTransaccion,@MerchantId,@IdTokenUsuario,
@AliasNameTarjeta,@FechaTransaccion,@ResultadoValidacionCVV2,@CsiMensaje,@IdUnicoTransaccion,@Etiqueta,
@RespuestaSistemAntifraude,@CsiPorcentajeDescuento,@NumeroCuota,@TokenTarjetaGuardada,@CsiImporteComercio,
@CsiCodigoPrograma,@DescripcionIndicadorComercioElectronico,@IndicadorComercioElectronico,@DescripcionCodigoAccion,
@NombreBancoEmisor,@ImporteCuota,@CsiTipoCobro,@NumeroReferencia,@Respuesta,@NumeroOrdenTienda,@CodigoAccion,
@ImporteAutorizado,@CodigoAutorizacion,@CodigoTienda,@NumeroTarjeta,@OrigenTarjeta,@EstadoSsicc,
0,@UsuarioCreacion,@UsuarioCreacion,@FechaGeneral,@FechaGeneral)

set @PagoEnLineaResultadoLogId = @@IDENTITY
end

GO
USE BelcorpMexico
GO
ALTER procedure dbo.InsertPagoEnLineaResultadoLog
@PagoEnLineaResultadoLogId int output,
@ConsultoraId bigint,
@CodigoConsultora varchar(20),
@NumeroDocumento varchar(30),
@CampaniaId int,
@FechaVencimiento datetime,
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

/*Info:
EstadoSsicc ===> 1: Por Evaluar, 2: Error al realizar el pago, 3: Procesado Servicio OK, 99: Procesado Servicio Error
*/
declare @EstadoSsicc int = 0
if (@CodigoError = '0' and @CodigoAccion = '000')
	set @EstadoSsicc = 1
else
	set @EstadoSsicc = 2

DECLARE @FechaGeneral DATETIME
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()
insert into PagoEnLineaResultadoLog
(ConsultoraId,CodigoConsultora,NumeroDocumento,CampaniaId,FechaVencimiento,MontoPago,MontoGastosAdministrativos,
TipoTarjeta,CodigoError,MensajeError,IdGuidTransaccion,IdGuidExternoTransaccion,MerchantId,IdTokenUsuario,
AliasNameTarjeta,FechaTransaccion,ResultadoValidacionCVV2,CsiMensaje,IdUnicoTransaccion,Etiqueta,
RespuestaSistemAntifraude,CsiPorcentajeDescuento,NumeroCuota,TokenTarjetaGuardada,CsiImporteComercio,
CsiCodigoPrograma,DescripcionIndicadorComercioElectronico,IndicadorComercioElectronico,DescripcionCodigoAccion,
NombreBancoEmisor,ImporteCuota,CsiTipoCobro,NumeroReferencia,Respuesta,NumeroOrdenTienda,CodigoAccion,
ImporteAutorizado,CodigoAutorizacion,CodigoTienda,NumeroTarjeta,OrigenTarjeta,EstadoSsicc,
Visualizado,UsuarioCreacion,UsuarioModificacion,FechaCreacion,FechaModificacion)
values
(@ConsultoraId,@CodigoConsultora,@NumeroDocumento,@CampaniaId,@FechaVencimiento,@MontoPago,@MontoGastosAdministrativos,
@TipoTarjeta,@CodigoError,@MensajeError,@IdGuidTransaccion,@IdGuidExternoTransaccion,@MerchantId,@IdTokenUsuario,
@AliasNameTarjeta,@FechaTransaccion,@ResultadoValidacionCVV2,@CsiMensaje,@IdUnicoTransaccion,@Etiqueta,
@RespuestaSistemAntifraude,@CsiPorcentajeDescuento,@NumeroCuota,@TokenTarjetaGuardada,@CsiImporteComercio,
@CsiCodigoPrograma,@DescripcionIndicadorComercioElectronico,@IndicadorComercioElectronico,@DescripcionCodigoAccion,
@NombreBancoEmisor,@ImporteCuota,@CsiTipoCobro,@NumeroReferencia,@Respuesta,@NumeroOrdenTienda,@CodigoAccion,
@ImporteAutorizado,@CodigoAutorizacion,@CodigoTienda,@NumeroTarjeta,@OrigenTarjeta,@EstadoSsicc,
0,@UsuarioCreacion,@UsuarioCreacion,@FechaGeneral,@FechaGeneral)

set @PagoEnLineaResultadoLogId = @@IDENTITY
end

GO
USE BelcorpColombia
GO
ALTER procedure dbo.InsertPagoEnLineaResultadoLog
@PagoEnLineaResultadoLogId int output,
@ConsultoraId bigint,
@CodigoConsultora varchar(20),
@NumeroDocumento varchar(30),
@CampaniaId int,
@FechaVencimiento datetime,
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

/*Info:
EstadoSsicc ===> 1: Por Evaluar, 2: Error al realizar el pago, 3: Procesado Servicio OK, 99: Procesado Servicio Error
*/
declare @EstadoSsicc int = 0
if (@CodigoError = '0' and @CodigoAccion = '000')
	set @EstadoSsicc = 1
else
	set @EstadoSsicc = 2

DECLARE @FechaGeneral DATETIME
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()
insert into PagoEnLineaResultadoLog
(ConsultoraId,CodigoConsultora,NumeroDocumento,CampaniaId,FechaVencimiento,MontoPago,MontoGastosAdministrativos,
TipoTarjeta,CodigoError,MensajeError,IdGuidTransaccion,IdGuidExternoTransaccion,MerchantId,IdTokenUsuario,
AliasNameTarjeta,FechaTransaccion,ResultadoValidacionCVV2,CsiMensaje,IdUnicoTransaccion,Etiqueta,
RespuestaSistemAntifraude,CsiPorcentajeDescuento,NumeroCuota,TokenTarjetaGuardada,CsiImporteComercio,
CsiCodigoPrograma,DescripcionIndicadorComercioElectronico,IndicadorComercioElectronico,DescripcionCodigoAccion,
NombreBancoEmisor,ImporteCuota,CsiTipoCobro,NumeroReferencia,Respuesta,NumeroOrdenTienda,CodigoAccion,
ImporteAutorizado,CodigoAutorizacion,CodigoTienda,NumeroTarjeta,OrigenTarjeta,EstadoSsicc,
Visualizado,UsuarioCreacion,UsuarioModificacion,FechaCreacion,FechaModificacion)
values
(@ConsultoraId,@CodigoConsultora,@NumeroDocumento,@CampaniaId,@FechaVencimiento,@MontoPago,@MontoGastosAdministrativos,
@TipoTarjeta,@CodigoError,@MensajeError,@IdGuidTransaccion,@IdGuidExternoTransaccion,@MerchantId,@IdTokenUsuario,
@AliasNameTarjeta,@FechaTransaccion,@ResultadoValidacionCVV2,@CsiMensaje,@IdUnicoTransaccion,@Etiqueta,
@RespuestaSistemAntifraude,@CsiPorcentajeDescuento,@NumeroCuota,@TokenTarjetaGuardada,@CsiImporteComercio,
@CsiCodigoPrograma,@DescripcionIndicadorComercioElectronico,@IndicadorComercioElectronico,@DescripcionCodigoAccion,
@NombreBancoEmisor,@ImporteCuota,@CsiTipoCobro,@NumeroReferencia,@Respuesta,@NumeroOrdenTienda,@CodigoAccion,
@ImporteAutorizado,@CodigoAutorizacion,@CodigoTienda,@NumeroTarjeta,@OrigenTarjeta,@EstadoSsicc,
0,@UsuarioCreacion,@UsuarioCreacion,@FechaGeneral,@FechaGeneral)

set @PagoEnLineaResultadoLogId = @@IDENTITY
end

GO
USE BelcorpSalvador
GO
ALTER procedure dbo.InsertPagoEnLineaResultadoLog
@PagoEnLineaResultadoLogId int output,
@ConsultoraId bigint,
@CodigoConsultora varchar(20),
@NumeroDocumento varchar(30),
@CampaniaId int,
@FechaVencimiento datetime,
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

/*Info:
EstadoSsicc ===> 1: Por Evaluar, 2: Error al realizar el pago, 3: Procesado Servicio OK, 99: Procesado Servicio Error
*/
declare @EstadoSsicc int = 0
if (@CodigoError = '0' and @CodigoAccion = '000')
	set @EstadoSsicc = 1
else
	set @EstadoSsicc = 2

DECLARE @FechaGeneral DATETIME
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()
insert into PagoEnLineaResultadoLog
(ConsultoraId,CodigoConsultora,NumeroDocumento,CampaniaId,FechaVencimiento,MontoPago,MontoGastosAdministrativos,
TipoTarjeta,CodigoError,MensajeError,IdGuidTransaccion,IdGuidExternoTransaccion,MerchantId,IdTokenUsuario,
AliasNameTarjeta,FechaTransaccion,ResultadoValidacionCVV2,CsiMensaje,IdUnicoTransaccion,Etiqueta,
RespuestaSistemAntifraude,CsiPorcentajeDescuento,NumeroCuota,TokenTarjetaGuardada,CsiImporteComercio,
CsiCodigoPrograma,DescripcionIndicadorComercioElectronico,IndicadorComercioElectronico,DescripcionCodigoAccion,
NombreBancoEmisor,ImporteCuota,CsiTipoCobro,NumeroReferencia,Respuesta,NumeroOrdenTienda,CodigoAccion,
ImporteAutorizado,CodigoAutorizacion,CodigoTienda,NumeroTarjeta,OrigenTarjeta,EstadoSsicc,
Visualizado,UsuarioCreacion,UsuarioModificacion,FechaCreacion,FechaModificacion)
values
(@ConsultoraId,@CodigoConsultora,@NumeroDocumento,@CampaniaId,@FechaVencimiento,@MontoPago,@MontoGastosAdministrativos,
@TipoTarjeta,@CodigoError,@MensajeError,@IdGuidTransaccion,@IdGuidExternoTransaccion,@MerchantId,@IdTokenUsuario,
@AliasNameTarjeta,@FechaTransaccion,@ResultadoValidacionCVV2,@CsiMensaje,@IdUnicoTransaccion,@Etiqueta,
@RespuestaSistemAntifraude,@CsiPorcentajeDescuento,@NumeroCuota,@TokenTarjetaGuardada,@CsiImporteComercio,
@CsiCodigoPrograma,@DescripcionIndicadorComercioElectronico,@IndicadorComercioElectronico,@DescripcionCodigoAccion,
@NombreBancoEmisor,@ImporteCuota,@CsiTipoCobro,@NumeroReferencia,@Respuesta,@NumeroOrdenTienda,@CodigoAccion,
@ImporteAutorizado,@CodigoAutorizacion,@CodigoTienda,@NumeroTarjeta,@OrigenTarjeta,@EstadoSsicc,
0,@UsuarioCreacion,@UsuarioCreacion,@FechaGeneral,@FechaGeneral)

set @PagoEnLineaResultadoLogId = @@IDENTITY
end

GO
USE BelcorpPuertoRico
GO
ALTER procedure dbo.InsertPagoEnLineaResultadoLog
@PagoEnLineaResultadoLogId int output,
@ConsultoraId bigint,
@CodigoConsultora varchar(20),
@NumeroDocumento varchar(30),
@CampaniaId int,
@FechaVencimiento datetime,
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

/*Info:
EstadoSsicc ===> 1: Por Evaluar, 2: Error al realizar el pago, 3: Procesado Servicio OK, 99: Procesado Servicio Error
*/
declare @EstadoSsicc int = 0
if (@CodigoError = '0' and @CodigoAccion = '000')
	set @EstadoSsicc = 1
else
	set @EstadoSsicc = 2

DECLARE @FechaGeneral DATETIME
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()
insert into PagoEnLineaResultadoLog
(ConsultoraId,CodigoConsultora,NumeroDocumento,CampaniaId,FechaVencimiento,MontoPago,MontoGastosAdministrativos,
TipoTarjeta,CodigoError,MensajeError,IdGuidTransaccion,IdGuidExternoTransaccion,MerchantId,IdTokenUsuario,
AliasNameTarjeta,FechaTransaccion,ResultadoValidacionCVV2,CsiMensaje,IdUnicoTransaccion,Etiqueta,
RespuestaSistemAntifraude,CsiPorcentajeDescuento,NumeroCuota,TokenTarjetaGuardada,CsiImporteComercio,
CsiCodigoPrograma,DescripcionIndicadorComercioElectronico,IndicadorComercioElectronico,DescripcionCodigoAccion,
NombreBancoEmisor,ImporteCuota,CsiTipoCobro,NumeroReferencia,Respuesta,NumeroOrdenTienda,CodigoAccion,
ImporteAutorizado,CodigoAutorizacion,CodigoTienda,NumeroTarjeta,OrigenTarjeta,EstadoSsicc,
Visualizado,UsuarioCreacion,UsuarioModificacion,FechaCreacion,FechaModificacion)
values
(@ConsultoraId,@CodigoConsultora,@NumeroDocumento,@CampaniaId,@FechaVencimiento,@MontoPago,@MontoGastosAdministrativos,
@TipoTarjeta,@CodigoError,@MensajeError,@IdGuidTransaccion,@IdGuidExternoTransaccion,@MerchantId,@IdTokenUsuario,
@AliasNameTarjeta,@FechaTransaccion,@ResultadoValidacionCVV2,@CsiMensaje,@IdUnicoTransaccion,@Etiqueta,
@RespuestaSistemAntifraude,@CsiPorcentajeDescuento,@NumeroCuota,@TokenTarjetaGuardada,@CsiImporteComercio,
@CsiCodigoPrograma,@DescripcionIndicadorComercioElectronico,@IndicadorComercioElectronico,@DescripcionCodigoAccion,
@NombreBancoEmisor,@ImporteCuota,@CsiTipoCobro,@NumeroReferencia,@Respuesta,@NumeroOrdenTienda,@CodigoAccion,
@ImporteAutorizado,@CodigoAutorizacion,@CodigoTienda,@NumeroTarjeta,@OrigenTarjeta,@EstadoSsicc,
0,@UsuarioCreacion,@UsuarioCreacion,@FechaGeneral,@FechaGeneral)

set @PagoEnLineaResultadoLogId = @@IDENTITY
end

GO
USE BelcorpPanama
GO
ALTER procedure dbo.InsertPagoEnLineaResultadoLog
@PagoEnLineaResultadoLogId int output,
@ConsultoraId bigint,
@CodigoConsultora varchar(20),
@NumeroDocumento varchar(30),
@CampaniaId int,
@FechaVencimiento datetime,
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

/*Info:
EstadoSsicc ===> 1: Por Evaluar, 2: Error al realizar el pago, 3: Procesado Servicio OK, 99: Procesado Servicio Error
*/
declare @EstadoSsicc int = 0
if (@CodigoError = '0' and @CodigoAccion = '000')
	set @EstadoSsicc = 1
else
	set @EstadoSsicc = 2

DECLARE @FechaGeneral DATETIME
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()
insert into PagoEnLineaResultadoLog
(ConsultoraId,CodigoConsultora,NumeroDocumento,CampaniaId,FechaVencimiento,MontoPago,MontoGastosAdministrativos,
TipoTarjeta,CodigoError,MensajeError,IdGuidTransaccion,IdGuidExternoTransaccion,MerchantId,IdTokenUsuario,
AliasNameTarjeta,FechaTransaccion,ResultadoValidacionCVV2,CsiMensaje,IdUnicoTransaccion,Etiqueta,
RespuestaSistemAntifraude,CsiPorcentajeDescuento,NumeroCuota,TokenTarjetaGuardada,CsiImporteComercio,
CsiCodigoPrograma,DescripcionIndicadorComercioElectronico,IndicadorComercioElectronico,DescripcionCodigoAccion,
NombreBancoEmisor,ImporteCuota,CsiTipoCobro,NumeroReferencia,Respuesta,NumeroOrdenTienda,CodigoAccion,
ImporteAutorizado,CodigoAutorizacion,CodigoTienda,NumeroTarjeta,OrigenTarjeta,EstadoSsicc,
Visualizado,UsuarioCreacion,UsuarioModificacion,FechaCreacion,FechaModificacion)
values
(@ConsultoraId,@CodigoConsultora,@NumeroDocumento,@CampaniaId,@FechaVencimiento,@MontoPago,@MontoGastosAdministrativos,
@TipoTarjeta,@CodigoError,@MensajeError,@IdGuidTransaccion,@IdGuidExternoTransaccion,@MerchantId,@IdTokenUsuario,
@AliasNameTarjeta,@FechaTransaccion,@ResultadoValidacionCVV2,@CsiMensaje,@IdUnicoTransaccion,@Etiqueta,
@RespuestaSistemAntifraude,@CsiPorcentajeDescuento,@NumeroCuota,@TokenTarjetaGuardada,@CsiImporteComercio,
@CsiCodigoPrograma,@DescripcionIndicadorComercioElectronico,@IndicadorComercioElectronico,@DescripcionCodigoAccion,
@NombreBancoEmisor,@ImporteCuota,@CsiTipoCobro,@NumeroReferencia,@Respuesta,@NumeroOrdenTienda,@CodigoAccion,
@ImporteAutorizado,@CodigoAutorizacion,@CodigoTienda,@NumeroTarjeta,@OrigenTarjeta,@EstadoSsicc,
0,@UsuarioCreacion,@UsuarioCreacion,@FechaGeneral,@FechaGeneral)

set @PagoEnLineaResultadoLogId = @@IDENTITY
end

GO
USE BelcorpGuatemala
GO
ALTER procedure dbo.InsertPagoEnLineaResultadoLog
@PagoEnLineaResultadoLogId int output,
@ConsultoraId bigint,
@CodigoConsultora varchar(20),
@NumeroDocumento varchar(30),
@CampaniaId int,
@FechaVencimiento datetime,
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

/*Info:
EstadoSsicc ===> 1: Por Evaluar, 2: Error al realizar el pago, 3: Procesado Servicio OK, 99: Procesado Servicio Error
*/
declare @EstadoSsicc int = 0
if (@CodigoError = '0' and @CodigoAccion = '000')
	set @EstadoSsicc = 1
else
	set @EstadoSsicc = 2

DECLARE @FechaGeneral DATETIME
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()
insert into PagoEnLineaResultadoLog
(ConsultoraId,CodigoConsultora,NumeroDocumento,CampaniaId,FechaVencimiento,MontoPago,MontoGastosAdministrativos,
TipoTarjeta,CodigoError,MensajeError,IdGuidTransaccion,IdGuidExternoTransaccion,MerchantId,IdTokenUsuario,
AliasNameTarjeta,FechaTransaccion,ResultadoValidacionCVV2,CsiMensaje,IdUnicoTransaccion,Etiqueta,
RespuestaSistemAntifraude,CsiPorcentajeDescuento,NumeroCuota,TokenTarjetaGuardada,CsiImporteComercio,
CsiCodigoPrograma,DescripcionIndicadorComercioElectronico,IndicadorComercioElectronico,DescripcionCodigoAccion,
NombreBancoEmisor,ImporteCuota,CsiTipoCobro,NumeroReferencia,Respuesta,NumeroOrdenTienda,CodigoAccion,
ImporteAutorizado,CodigoAutorizacion,CodigoTienda,NumeroTarjeta,OrigenTarjeta,EstadoSsicc,
Visualizado,UsuarioCreacion,UsuarioModificacion,FechaCreacion,FechaModificacion)
values
(@ConsultoraId,@CodigoConsultora,@NumeroDocumento,@CampaniaId,@FechaVencimiento,@MontoPago,@MontoGastosAdministrativos,
@TipoTarjeta,@CodigoError,@MensajeError,@IdGuidTransaccion,@IdGuidExternoTransaccion,@MerchantId,@IdTokenUsuario,
@AliasNameTarjeta,@FechaTransaccion,@ResultadoValidacionCVV2,@CsiMensaje,@IdUnicoTransaccion,@Etiqueta,
@RespuestaSistemAntifraude,@CsiPorcentajeDescuento,@NumeroCuota,@TokenTarjetaGuardada,@CsiImporteComercio,
@CsiCodigoPrograma,@DescripcionIndicadorComercioElectronico,@IndicadorComercioElectronico,@DescripcionCodigoAccion,
@NombreBancoEmisor,@ImporteCuota,@CsiTipoCobro,@NumeroReferencia,@Respuesta,@NumeroOrdenTienda,@CodigoAccion,
@ImporteAutorizado,@CodigoAutorizacion,@CodigoTienda,@NumeroTarjeta,@OrigenTarjeta,@EstadoSsicc,
0,@UsuarioCreacion,@UsuarioCreacion,@FechaGeneral,@FechaGeneral)

set @PagoEnLineaResultadoLogId = @@IDENTITY
end

GO
USE BelcorpEcuador
GO
ALTER procedure dbo.InsertPagoEnLineaResultadoLog
@PagoEnLineaResultadoLogId int output,
@ConsultoraId bigint,
@CodigoConsultora varchar(20),
@NumeroDocumento varchar(30),
@CampaniaId int,
@FechaVencimiento datetime,
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

/*Info:
EstadoSsicc ===> 1: Por Evaluar, 2: Error al realizar el pago, 3: Procesado Servicio OK, 99: Procesado Servicio Error
*/
declare @EstadoSsicc int = 0
if (@CodigoError = '0' and @CodigoAccion = '000')
	set @EstadoSsicc = 1
else
	set @EstadoSsicc = 2

DECLARE @FechaGeneral DATETIME
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()
insert into PagoEnLineaResultadoLog
(ConsultoraId,CodigoConsultora,NumeroDocumento,CampaniaId,FechaVencimiento,MontoPago,MontoGastosAdministrativos,
TipoTarjeta,CodigoError,MensajeError,IdGuidTransaccion,IdGuidExternoTransaccion,MerchantId,IdTokenUsuario,
AliasNameTarjeta,FechaTransaccion,ResultadoValidacionCVV2,CsiMensaje,IdUnicoTransaccion,Etiqueta,
RespuestaSistemAntifraude,CsiPorcentajeDescuento,NumeroCuota,TokenTarjetaGuardada,CsiImporteComercio,
CsiCodigoPrograma,DescripcionIndicadorComercioElectronico,IndicadorComercioElectronico,DescripcionCodigoAccion,
NombreBancoEmisor,ImporteCuota,CsiTipoCobro,NumeroReferencia,Respuesta,NumeroOrdenTienda,CodigoAccion,
ImporteAutorizado,CodigoAutorizacion,CodigoTienda,NumeroTarjeta,OrigenTarjeta,EstadoSsicc,
Visualizado,UsuarioCreacion,UsuarioModificacion,FechaCreacion,FechaModificacion)
values
(@ConsultoraId,@CodigoConsultora,@NumeroDocumento,@CampaniaId,@FechaVencimiento,@MontoPago,@MontoGastosAdministrativos,
@TipoTarjeta,@CodigoError,@MensajeError,@IdGuidTransaccion,@IdGuidExternoTransaccion,@MerchantId,@IdTokenUsuario,
@AliasNameTarjeta,@FechaTransaccion,@ResultadoValidacionCVV2,@CsiMensaje,@IdUnicoTransaccion,@Etiqueta,
@RespuestaSistemAntifraude,@CsiPorcentajeDescuento,@NumeroCuota,@TokenTarjetaGuardada,@CsiImporteComercio,
@CsiCodigoPrograma,@DescripcionIndicadorComercioElectronico,@IndicadorComercioElectronico,@DescripcionCodigoAccion,
@NombreBancoEmisor,@ImporteCuota,@CsiTipoCobro,@NumeroReferencia,@Respuesta,@NumeroOrdenTienda,@CodigoAccion,
@ImporteAutorizado,@CodigoAutorizacion,@CodigoTienda,@NumeroTarjeta,@OrigenTarjeta,@EstadoSsicc,
0,@UsuarioCreacion,@UsuarioCreacion,@FechaGeneral,@FechaGeneral)

set @PagoEnLineaResultadoLogId = @@IDENTITY
end

GO
USE BelcorpDominicana
GO
ALTER procedure dbo.InsertPagoEnLineaResultadoLog
@PagoEnLineaResultadoLogId int output,
@ConsultoraId bigint,
@CodigoConsultora varchar(20),
@NumeroDocumento varchar(30),
@CampaniaId int,
@FechaVencimiento datetime,
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

/*Info:
EstadoSsicc ===> 1: Por Evaluar, 2: Error al realizar el pago, 3: Procesado Servicio OK, 99: Procesado Servicio Error
*/
declare @EstadoSsicc int = 0
if (@CodigoError = '0' and @CodigoAccion = '000')
	set @EstadoSsicc = 1
else
	set @EstadoSsicc = 2

DECLARE @FechaGeneral DATETIME
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()
insert into PagoEnLineaResultadoLog
(ConsultoraId,CodigoConsultora,NumeroDocumento,CampaniaId,FechaVencimiento,MontoPago,MontoGastosAdministrativos,
TipoTarjeta,CodigoError,MensajeError,IdGuidTransaccion,IdGuidExternoTransaccion,MerchantId,IdTokenUsuario,
AliasNameTarjeta,FechaTransaccion,ResultadoValidacionCVV2,CsiMensaje,IdUnicoTransaccion,Etiqueta,
RespuestaSistemAntifraude,CsiPorcentajeDescuento,NumeroCuota,TokenTarjetaGuardada,CsiImporteComercio,
CsiCodigoPrograma,DescripcionIndicadorComercioElectronico,IndicadorComercioElectronico,DescripcionCodigoAccion,
NombreBancoEmisor,ImporteCuota,CsiTipoCobro,NumeroReferencia,Respuesta,NumeroOrdenTienda,CodigoAccion,
ImporteAutorizado,CodigoAutorizacion,CodigoTienda,NumeroTarjeta,OrigenTarjeta,EstadoSsicc,
Visualizado,UsuarioCreacion,UsuarioModificacion,FechaCreacion,FechaModificacion)
values
(@ConsultoraId,@CodigoConsultora,@NumeroDocumento,@CampaniaId,@FechaVencimiento,@MontoPago,@MontoGastosAdministrativos,
@TipoTarjeta,@CodigoError,@MensajeError,@IdGuidTransaccion,@IdGuidExternoTransaccion,@MerchantId,@IdTokenUsuario,
@AliasNameTarjeta,@FechaTransaccion,@ResultadoValidacionCVV2,@CsiMensaje,@IdUnicoTransaccion,@Etiqueta,
@RespuestaSistemAntifraude,@CsiPorcentajeDescuento,@NumeroCuota,@TokenTarjetaGuardada,@CsiImporteComercio,
@CsiCodigoPrograma,@DescripcionIndicadorComercioElectronico,@IndicadorComercioElectronico,@DescripcionCodigoAccion,
@NombreBancoEmisor,@ImporteCuota,@CsiTipoCobro,@NumeroReferencia,@Respuesta,@NumeroOrdenTienda,@CodigoAccion,
@ImporteAutorizado,@CodigoAutorizacion,@CodigoTienda,@NumeroTarjeta,@OrigenTarjeta,@EstadoSsicc,
0,@UsuarioCreacion,@UsuarioCreacion,@FechaGeneral,@FechaGeneral)

set @PagoEnLineaResultadoLogId = @@IDENTITY
end

GO
USE BelcorpCostaRica
GO
ALTER procedure dbo.InsertPagoEnLineaResultadoLog
@PagoEnLineaResultadoLogId int output,
@ConsultoraId bigint,
@CodigoConsultora varchar(20),
@NumeroDocumento varchar(30),
@CampaniaId int,
@FechaVencimiento datetime,
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

/*Info:
EstadoSsicc ===> 1: Por Evaluar, 2: Error al realizar el pago, 3: Procesado Servicio OK, 99: Procesado Servicio Error
*/
declare @EstadoSsicc int = 0
if (@CodigoError = '0' and @CodigoAccion = '000')
	set @EstadoSsicc = 1
else
	set @EstadoSsicc = 2

DECLARE @FechaGeneral DATETIME
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()
insert into PagoEnLineaResultadoLog
(ConsultoraId,CodigoConsultora,NumeroDocumento,CampaniaId,FechaVencimiento,MontoPago,MontoGastosAdministrativos,
TipoTarjeta,CodigoError,MensajeError,IdGuidTransaccion,IdGuidExternoTransaccion,MerchantId,IdTokenUsuario,
AliasNameTarjeta,FechaTransaccion,ResultadoValidacionCVV2,CsiMensaje,IdUnicoTransaccion,Etiqueta,
RespuestaSistemAntifraude,CsiPorcentajeDescuento,NumeroCuota,TokenTarjetaGuardada,CsiImporteComercio,
CsiCodigoPrograma,DescripcionIndicadorComercioElectronico,IndicadorComercioElectronico,DescripcionCodigoAccion,
NombreBancoEmisor,ImporteCuota,CsiTipoCobro,NumeroReferencia,Respuesta,NumeroOrdenTienda,CodigoAccion,
ImporteAutorizado,CodigoAutorizacion,CodigoTienda,NumeroTarjeta,OrigenTarjeta,EstadoSsicc,
Visualizado,UsuarioCreacion,UsuarioModificacion,FechaCreacion,FechaModificacion)
values
(@ConsultoraId,@CodigoConsultora,@NumeroDocumento,@CampaniaId,@FechaVencimiento,@MontoPago,@MontoGastosAdministrativos,
@TipoTarjeta,@CodigoError,@MensajeError,@IdGuidTransaccion,@IdGuidExternoTransaccion,@MerchantId,@IdTokenUsuario,
@AliasNameTarjeta,@FechaTransaccion,@ResultadoValidacionCVV2,@CsiMensaje,@IdUnicoTransaccion,@Etiqueta,
@RespuestaSistemAntifraude,@CsiPorcentajeDescuento,@NumeroCuota,@TokenTarjetaGuardada,@CsiImporteComercio,
@CsiCodigoPrograma,@DescripcionIndicadorComercioElectronico,@IndicadorComercioElectronico,@DescripcionCodigoAccion,
@NombreBancoEmisor,@ImporteCuota,@CsiTipoCobro,@NumeroReferencia,@Respuesta,@NumeroOrdenTienda,@CodigoAccion,
@ImporteAutorizado,@CodigoAutorizacion,@CodigoTienda,@NumeroTarjeta,@OrigenTarjeta,@EstadoSsicc,
0,@UsuarioCreacion,@UsuarioCreacion,@FechaGeneral,@FechaGeneral)

set @PagoEnLineaResultadoLogId = @@IDENTITY
end

GO
USE BelcorpChile
GO
ALTER procedure dbo.InsertPagoEnLineaResultadoLog
@PagoEnLineaResultadoLogId int output,
@ConsultoraId bigint,
@CodigoConsultora varchar(20),
@NumeroDocumento varchar(30),
@CampaniaId int,
@FechaVencimiento datetime,
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

/*Info:
EstadoSsicc ===> 1: Por Evaluar, 2: Error al realizar el pago, 3: Procesado Servicio OK, 99: Procesado Servicio Error
*/
declare @EstadoSsicc int = 0
if (@CodigoError = '0' and @CodigoAccion = '000')
	set @EstadoSsicc = 1
else
	set @EstadoSsicc = 2

DECLARE @FechaGeneral DATETIME
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()
insert into PagoEnLineaResultadoLog
(ConsultoraId,CodigoConsultora,NumeroDocumento,CampaniaId,FechaVencimiento,MontoPago,MontoGastosAdministrativos,
TipoTarjeta,CodigoError,MensajeError,IdGuidTransaccion,IdGuidExternoTransaccion,MerchantId,IdTokenUsuario,
AliasNameTarjeta,FechaTransaccion,ResultadoValidacionCVV2,CsiMensaje,IdUnicoTransaccion,Etiqueta,
RespuestaSistemAntifraude,CsiPorcentajeDescuento,NumeroCuota,TokenTarjetaGuardada,CsiImporteComercio,
CsiCodigoPrograma,DescripcionIndicadorComercioElectronico,IndicadorComercioElectronico,DescripcionCodigoAccion,
NombreBancoEmisor,ImporteCuota,CsiTipoCobro,NumeroReferencia,Respuesta,NumeroOrdenTienda,CodigoAccion,
ImporteAutorizado,CodigoAutorizacion,CodigoTienda,NumeroTarjeta,OrigenTarjeta,EstadoSsicc,
Visualizado,UsuarioCreacion,UsuarioModificacion,FechaCreacion,FechaModificacion)
values
(@ConsultoraId,@CodigoConsultora,@NumeroDocumento,@CampaniaId,@FechaVencimiento,@MontoPago,@MontoGastosAdministrativos,
@TipoTarjeta,@CodigoError,@MensajeError,@IdGuidTransaccion,@IdGuidExternoTransaccion,@MerchantId,@IdTokenUsuario,
@AliasNameTarjeta,@FechaTransaccion,@ResultadoValidacionCVV2,@CsiMensaje,@IdUnicoTransaccion,@Etiqueta,
@RespuestaSistemAntifraude,@CsiPorcentajeDescuento,@NumeroCuota,@TokenTarjetaGuardada,@CsiImporteComercio,
@CsiCodigoPrograma,@DescripcionIndicadorComercioElectronico,@IndicadorComercioElectronico,@DescripcionCodigoAccion,
@NombreBancoEmisor,@ImporteCuota,@CsiTipoCobro,@NumeroReferencia,@Respuesta,@NumeroOrdenTienda,@CodigoAccion,
@ImporteAutorizado,@CodigoAutorizacion,@CodigoTienda,@NumeroTarjeta,@OrigenTarjeta,@EstadoSsicc,
0,@UsuarioCreacion,@UsuarioCreacion,@FechaGeneral,@FechaGeneral)

set @PagoEnLineaResultadoLogId = @@IDENTITY
end

GO
USE BelcorpBolivia
GO
ALTER procedure dbo.InsertPagoEnLineaResultadoLog
@PagoEnLineaResultadoLogId int output,
@ConsultoraId bigint,
@CodigoConsultora varchar(20),
@NumeroDocumento varchar(30),
@CampaniaId int,
@FechaVencimiento datetime,
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

/*Info:
EstadoSsicc ===> 1: Por Evaluar, 2: Error al realizar el pago, 3: Procesado Servicio OK, 99: Procesado Servicio Error
*/
declare @EstadoSsicc int = 0
if (@CodigoError = '0' and @CodigoAccion = '000')
	set @EstadoSsicc = 1
else
	set @EstadoSsicc = 2

DECLARE @FechaGeneral DATETIME
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()
insert into PagoEnLineaResultadoLog
(ConsultoraId,CodigoConsultora,NumeroDocumento,CampaniaId,FechaVencimiento,MontoPago,MontoGastosAdministrativos,
TipoTarjeta,CodigoError,MensajeError,IdGuidTransaccion,IdGuidExternoTransaccion,MerchantId,IdTokenUsuario,
AliasNameTarjeta,FechaTransaccion,ResultadoValidacionCVV2,CsiMensaje,IdUnicoTransaccion,Etiqueta,
RespuestaSistemAntifraude,CsiPorcentajeDescuento,NumeroCuota,TokenTarjetaGuardada,CsiImporteComercio,
CsiCodigoPrograma,DescripcionIndicadorComercioElectronico,IndicadorComercioElectronico,DescripcionCodigoAccion,
NombreBancoEmisor,ImporteCuota,CsiTipoCobro,NumeroReferencia,Respuesta,NumeroOrdenTienda,CodigoAccion,
ImporteAutorizado,CodigoAutorizacion,CodigoTienda,NumeroTarjeta,OrigenTarjeta,EstadoSsicc,
Visualizado,UsuarioCreacion,UsuarioModificacion,FechaCreacion,FechaModificacion)
values
(@ConsultoraId,@CodigoConsultora,@NumeroDocumento,@CampaniaId,@FechaVencimiento,@MontoPago,@MontoGastosAdministrativos,
@TipoTarjeta,@CodigoError,@MensajeError,@IdGuidTransaccion,@IdGuidExternoTransaccion,@MerchantId,@IdTokenUsuario,
@AliasNameTarjeta,@FechaTransaccion,@ResultadoValidacionCVV2,@CsiMensaje,@IdUnicoTransaccion,@Etiqueta,
@RespuestaSistemAntifraude,@CsiPorcentajeDescuento,@NumeroCuota,@TokenTarjetaGuardada,@CsiImporteComercio,
@CsiCodigoPrograma,@DescripcionIndicadorComercioElectronico,@IndicadorComercioElectronico,@DescripcionCodigoAccion,
@NombreBancoEmisor,@ImporteCuota,@CsiTipoCobro,@NumeroReferencia,@Respuesta,@NumeroOrdenTienda,@CodigoAccion,
@ImporteAutorizado,@CodigoAutorizacion,@CodigoTienda,@NumeroTarjeta,@OrigenTarjeta,@EstadoSsicc,
0,@UsuarioCreacion,@UsuarioCreacion,@FechaGeneral,@FechaGeneral)

set @PagoEnLineaResultadoLogId = @@IDENTITY
end

GO
