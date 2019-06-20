USE [BelcorpPeru]
GO
alter procedure [dbo].[InsApePedido]

AS
declare @TempCambios table(
	Codigo varchar(20),
	Campana int,
	NroPedido varchar(50)
)

insert into @TempCambios
select YT.Codigo, YT.Campana, YT.NroPedido
from YobelPedidoTemp YT
inner join ods.ApePedido A on YT.NroPedido = A.NroPedido and YT.Campana = A.Campana and YT.Codigo = A.Codigo

update YobelPedidoTemp
set Estado = 0
from YobelPedidoTemp T
inner join @TempCambios C on T.NroPedido = C.NroPedido and T.Campana = C.Campana and T.Codigo = C.Codigo

insert into ods.ApePedido
([Campana],[NroPedido],[Codigo],[AChequeo],[FechaFact],[Tiempo],[ErrorEmbalaje],[Inducido],[IndFechaHora],
[Armado],[Chequeado],[CFechaHoraI],[CFechaHoraF],[EnDespacho],[EnTransporte],[DFechaHora],[TipoPedido],
[CostoPedido],[OrdenImpreso],[FechaEntregado],[NroCajas])
select [Campana],[NroPedido],[Codigo],[AChequeo],[FechaFact],[Tiempo],[ErrorEmbalaje],[Inducido],[IndFechaHora],
[Armado],[Chequeado],[CFechaHoraI],[CFechaHoraF],[EnDespacho],[EnTransporte],[DFechaHora],[TipoPedido],
[CostoPedido],[OrdenImpreso],[FechaEntregado],[NroCajas]
from YobelPedidoTemp
where Estado = 1

update ods.ApePedido
set [AChequeo]		= T.[AChequeo],		
	[FechaFact]		= T.[FechaFact],		
	[Tiempo]		= T.[Tiempo],		
	[ErrorEmbalaje]	= T.[ErrorEmbalaje],	
	[Inducido]		= T.[Inducido],		
	[IndFechaHora]	= T.[IndFechaHora],	
	[Armado]		= T.[Armado],		
	[Chequeado]		= T.[Chequeado],		
	[CFechaHoraI]	= T.[CFechaHoraI],	
	[CFechaHoraF]	= T.[CFechaHoraF],	
	[EnDespacho]	= T.[EnDespacho],	
	[EnTransporte]	= T.[EnTransporte],	
	[DFechaHora]	= T.[DFechaHora],	
	[TipoPedido]	= T.[TipoPedido],	
	[CostoPedido]	= T.[CostoPedido],	
	[OrdenImpreso]	= T.[OrdenImpreso],	
	[FechaEntregado]= T.[FechaEntregado],
	[NroCajas]		= T.[NroCajas]		
from ods.ApePedido A
inner join YobelPedidoTemp T ON A.NroPedido = T.NroPedido and A.Campana = T.Campana and A.Codigo = T.Codigo
where T.Estado = 0
GO