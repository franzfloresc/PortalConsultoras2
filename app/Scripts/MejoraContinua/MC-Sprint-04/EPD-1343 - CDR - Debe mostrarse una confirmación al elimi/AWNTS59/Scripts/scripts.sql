USE BelcorpColombia
go

alter procedure dbo.GetCDRWeb
@ConsultoraID bigint
,@PedidoID int = 0
,@CampaniaID int = 0
,@CDRWebID int = 0
as
/*
GetCDRWeb 2
GetCDRWeb 2,707193021,0
GetCDRWeb 2,0,0,1
*/
begin
	select top 20
			C.CDRWebID,
			C.PedidoID,
			C.PedidoNumero,
			C.CampaniaID,
			C.ConsultoraID,
			C.FechaRegistro,
			C.Estado,
			C.FechaCulminado,
			C.FechaAtencion,
			C.Importe,
			(select count(*) from CDRWebDetalle where CDRWebID = C.CDRWebID) as CantidadDetalle
	from CDRWeb C
	where C.ConsultoraID = @ConsultoraID
		and (C.PedidoID = @PedidoID or @PedidoID = 0)
		and (C.CampaniaID = @CampaniaID or @CampaniaID = 0)
		and (C.CDRWebID = @CDRWebID or @CDRWebID = 0)
		--and (C.CDRWebID IN (SELECT CDRWebID FROM CDRWebDetalle DD WHERE DD.CDRWebID = C.CDRWebID))
	order by C.CDRWebID desc

end

go

USE BelcorpMexico
go

alter procedure dbo.GetCDRWeb
@ConsultoraID bigint
,@PedidoID int = 0
,@CampaniaID int = 0
,@CDRWebID int = 0
as
/*
GetCDRWeb 2
GetCDRWeb 2,707193021,0
GetCDRWeb 2,0,0,1
*/
begin
	select top 20
			C.CDRWebID,
			C.PedidoID,
			C.PedidoNumero,
			C.CampaniaID,
			C.ConsultoraID,
			C.FechaRegistro,
			C.Estado,
			C.FechaCulminado,
			C.FechaAtencion,
			C.Importe,
			(select count(*) from CDRWebDetalle where CDRWebID = C.CDRWebID) as CantidadDetalle
	from CDRWeb C
	where C.ConsultoraID = @ConsultoraID
		and (C.PedidoID = @PedidoID or @PedidoID = 0)
		and (C.CampaniaID = @CampaniaID or @CampaniaID = 0)
		and (C.CDRWebID = @CDRWebID or @CDRWebID = 0)
		--and (C.CDRWebID IN (SELECT CDRWebID FROM CDRWebDetalle DD WHERE DD.CDRWebID = C.CDRWebID))
	order by C.CDRWebID desc

end

go

USE BelcorpPeru
go

alter procedure [dbo].GetCDRWeb
@ConsultoraID bigint
,@PedidoID int = 0
,@CampaniaID int = 0
,@CDRWebID int = 0
as
/*
GetCDRWeb 2
GetCDRWeb 2,708495691,0
GetCDRWeb 2,0,0,3013
*/
begin
	select top 20
			C.CDRWebID,
			C.PedidoID,
			C.PedidoNumero,
			C.CampaniaID,
			C.ConsultoraID,
			C.FechaRegistro,
			C.Estado,
			C.FechaCulminado,
			C.FechaAtencion,
			C.Importe,
			(select count(*) from CDRWebDetalle where CDRWebID = C.CDRWebID) as CantidadDetalle
	from CDRWeb C
	where C.ConsultoraID = @ConsultoraID
		and (C.PedidoID = @PedidoID or @PedidoID = 0)
		and (C.CampaniaID = @CampaniaID or @CampaniaID = 0)
		and (C.CDRWebID = @CDRWebID or @CDRWebID = 0)
		--and (C.CDRWebID IN (SELECT CDRWebID FROM CDRWebDetalle DD WHERE DD.CDRWebID = C.CDRWebID))
	order by C.CDRWebID desc

end

go

