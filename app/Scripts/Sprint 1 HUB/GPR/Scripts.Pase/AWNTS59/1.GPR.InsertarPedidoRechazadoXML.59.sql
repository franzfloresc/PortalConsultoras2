USE BelcorpColombia
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[InsertarPedidoRechazadoXML]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[InsertarPedidoRechazadoXML]
GO

CREATE PROCEDURE GPR.InsertarPedidoRechazadoXML
	@Estado VARCHAR(5),
	@Mensaje varchar(1500),
	@PedidoRechazoXml xml
AS
BEGIN
	INSERT INTO GPR.ProcesoPedidoRechazado(Fecha, Estado, Mensaje)
	VALUES(dbo.fnObtenerFechaHoraPais(),@Estado,@Mensaje);
	DECLARE @IdProcesoPedidoRechazado BIGINT = SCOPE_IDENTITY();

	INSERT INTO GPR.PedidoRechazado(IdProcesoPedidoRechazado,Campania,CodigoConsultora,MotivoRechazo,Valor)
	SELECT
		@IdProcesoPedidoRechazado,
		p.value('@Campania','VARCHAR(6)'), 
		p.value('@CodigoConsultora','VARCHAR(15)'),
		p.value('@MotivoRechazo','VARCHAR(6)'),
		p.value('@Valor','VARCHAR(10)')
	FROM @PedidoRechazoXml.nodes('/ROOT/PedidoRechazado')n(p);
END

GO


USE BelcorpMexico
go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[InsertarPedidoRechazadoXML]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[InsertarPedidoRechazadoXML]
GO

CREATE PROCEDURE GPR.InsertarPedidoRechazadoXML
	@Estado VARCHAR(5),
	@Mensaje varchar(1500),
	@PedidoRechazoXml xml
AS
BEGIN
	INSERT INTO GPR.ProcesoPedidoRechazado(Fecha, Estado, Mensaje)
	VALUES(dbo.fnObtenerFechaHoraPais(),@Estado,@Mensaje);
	DECLARE @IdProcesoPedidoRechazado BIGINT = SCOPE_IDENTITY();

	INSERT INTO GPR.PedidoRechazado(IdProcesoPedidoRechazado,Campania,CodigoConsultora,MotivoRechazo,Valor)
	SELECT
		@IdProcesoPedidoRechazado,
		p.value('@Campania','VARCHAR(6)'), 
		p.value('@CodigoConsultora','VARCHAR(15)'),
		p.value('@MotivoRechazo','VARCHAR(6)'),
		p.value('@Valor','VARCHAR(10)')
	FROM @PedidoRechazoXml.nodes('/ROOT/PedidoRechazado')n(p);
END

GO

USE BelcorpPeru
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[InsertarPedidoRechazadoXML]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[InsertarPedidoRechazadoXML]
GO

CREATE PROCEDURE GPR.InsertarPedidoRechazadoXML
	@Estado VARCHAR(5),
	@Mensaje varchar(1500),
	@PedidoRechazoXml xml
AS
BEGIN
	INSERT INTO GPR.ProcesoPedidoRechazado(Fecha, Estado, Mensaje)
	VALUES(dbo.fnObtenerFechaHoraPais(),@Estado,@Mensaje);
	DECLARE @IdProcesoPedidoRechazado BIGINT = SCOPE_IDENTITY();

	INSERT INTO GPR.PedidoRechazado(IdProcesoPedidoRechazado,Campania,CodigoConsultora,MotivoRechazo,Valor)
	SELECT
		@IdProcesoPedidoRechazado,
		p.value('@Campania','VARCHAR(6)'), 
		p.value('@CodigoConsultora','VARCHAR(15)'),
		p.value('@MotivoRechazo','VARCHAR(6)'),
		p.value('@Valor','VARCHAR(10)')
	FROM @PedidoRechazoXml.nodes('/ROOT/PedidoRechazado')n(p);
END


GO
