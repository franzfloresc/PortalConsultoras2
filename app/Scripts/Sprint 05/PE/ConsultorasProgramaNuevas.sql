
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
	values('MontoMinimo', '�VAMOS, ADELANTE!', 'Te faltan #valor para pasar pedido')
					
	insert into dbo.MensajeMetaConsultora(TipoMensaje, Titulo, Mensaje)
	values('TippingPoint', '�RECIBE TU BONIFICACI�N DEL PROGRAMA DE NUEVAS!', 'S�lo te faltan #valor m�s.')
	
	insert into dbo.MensajeMetaConsultora(TipoMensaje, Titulo, Mensaje)
	values('MontoMaximo', '�S�LO PUEDES AGREGAR #valor M�S!', 'Ya estas por llegar a tu tope de l�nea de cr�dito.')
	
	insert into dbo.MensajeMetaConsultora(TipoMensaje, Titulo, Mensaje)
	values('MontoMaximoSupero', 'YA ALCANZASTE EL L�MITE DE TU L�NEA DE CR�DITO', 'Tu pedido ya alcanz� el monto m�ximo de tu l�nea de cr�dito.')
	
	insert into dbo.MensajeMetaConsultora(TipoMensaje, Titulo, Mensaje)
	values('EscalaDescuento', '�YA LLEGAS AL #porcentaje% DSCTO!', 'Solo agrega #valor m�s.')
	
	insert into dbo.MensajeMetaConsultora(TipoMensaje, Titulo, Mensaje)
	values('EscalaDescuentoSupero', '�BIEN!', 'Ya alcanzaste el #porcentaje de descuento.')

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

