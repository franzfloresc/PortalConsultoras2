
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetConsultorasProgramaNuevas_SB2]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetConsultorasProgramaNuevas_SB2
GO

CREATE PROCEDURE dbo.GetConsultorasProgramaNuevas_SB2
	@CodigoConsultora varchar(50),
	@Campania varchar(10),
	@CodigoPrograma varchar(5)
AS

BEGIN

		SELECT 
			Campania
			,CodigoConsultora
			,CodigoPrograma
			,Participa
			,Motivo
			,MontoVentaExigido
		FROM ods.ConsultorasProgramaNuevas
		WHERE CodigoConsultora = @CodigoConsultora
			AND Campania = @Campania
			AND CodigoPrograma = @CodigoPrograma

END

go

go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
 where sysobjects.id = object_id('dbo.MensajeMetaConsultora')) = 0
 begin

	CREATE TABLE dbo.MensajeMetaConsultora(
		TipoMensaje varchar(50),
		Titulo varchar(1000),
		Mensaje varchar(1000)
	);
	
	insert into dbo.MensajeMetaConsultora(TipoMensaje, Titulo, Mensaje)
	values('MontoMinimo', '¡VAMOS, ADELANTE!', 'Te faltan #valor para alcanzar el monto mínimo y poder pasar tu pedido')
					
	insert into dbo.MensajeMetaConsultora(TipoMensaje, Titulo, Mensaje)
	values('TippingPoint', '¡VAMOS POR LA BONIFICACIÓN!', 'Pasando solo #valor más recibirás los productos gratis de tu programa de nuevas')
	
	insert into dbo.MensajeMetaConsultora(TipoMensaje, Titulo, Mensaje)
	values('MontoMaximo', '¡VAMOS, ADELANTE!', 'Puedes ingresar un pedido de hasta #valor')
	
	insert into dbo.MensajeMetaConsultora(TipoMensaje, Titulo, Mensaje)
	values('MontoMaximoSupero', '¡FELICIDADES!', 'Tu pedido ya alcanzó el monto máximo de tu línea de crédito')
	
	insert into dbo.MensajeMetaConsultora(TipoMensaje, Titulo, Mensaje)
	values('EscalaDescuento', '¡YA LLEGAS AL #valor% DSCTO!', 'Te faltan solo #valor para obtener un mayor descuento y ganar más')
	
	insert into dbo.MensajeMetaConsultora(TipoMensaje, Titulo, Mensaje)
	values('EscalaDescuentoSupero', '¡FELICIDADES!', '¡Felicitaciones! Ya alcanzaste la última escala de descuento')

end
go


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetMensajeMetaConsultoraas_SB2]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetMensajeMetaConsultoraas_SB2
GO

CREATE PROCEDURE dbo.GetMensajeMetaConsultoraas_SB2
	@TipoMensaje varchar(50) = ''
AS

BEGIN
		set @TipoMensaje = isnull(@TipoMensaje, '')

		SELECT 
			TipoMensaje
			,Titulo
			,Mensaje
		FROM dbo.MensajeMetaConsultora
		WHERE TipoMensaje = @TipoMensaje or @TipoMensaje = ''

END

go

go

