USE BelcorpBolivia
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
			CDRWebID,
			PedidoID,
			PedidoNumero,
			CampaniaID,
			ConsultoraID,
			FechaRegistro,
			Estado,
			FechaCulminado,
			FechaAtencion,
			Importe				
	from CDRWeb
	where ConsultoraID = @ConsultoraID
		and (PedidoID = @PedidoID or @PedidoID = 0)
		and (CampaniaID = @CampaniaID or @CampaniaID = 0)
		and (CDRWebID = @CDRWebID or @CDRWebID = 0)
	order by CDRWebID desc

end

go

USE BelcorpChile
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
			CDRWebID,
			PedidoID,
			PedidoNumero,
			CampaniaID,
			ConsultoraID,
			FechaRegistro,
			Estado,
			FechaCulminado,
			FechaAtencion,
			Importe				
	from CDRWeb
	where ConsultoraID = @ConsultoraID
		and (PedidoID = @PedidoID or @PedidoID = 0)
		and (CampaniaID = @CampaniaID or @CampaniaID = 0)
		and (CDRWebID = @CDRWebID or @CDRWebID = 0)
	order by CDRWebID desc

end

go

USE BelcorpCostaRica
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
			CDRWebID,
			PedidoID,
			PedidoNumero,
			CampaniaID,
			ConsultoraID,
			FechaRegistro,
			Estado,
			FechaCulminado,
			FechaAtencion,
			Importe				
	from CDRWeb
	where ConsultoraID = @ConsultoraID
		and (PedidoID = @PedidoID or @PedidoID = 0)
		and (CampaniaID = @CampaniaID or @CampaniaID = 0)
		and (CDRWebID = @CDRWebID or @CDRWebID = 0)
	order by CDRWebID desc

end

go

USE BelcorpDominicana
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
			CDRWebID,
			PedidoID,
			PedidoNumero,
			CampaniaID,
			ConsultoraID,
			FechaRegistro,
			Estado,
			FechaCulminado,
			FechaAtencion,
			Importe				
	from CDRWeb
	where ConsultoraID = @ConsultoraID
		and (PedidoID = @PedidoID or @PedidoID = 0)
		and (CampaniaID = @CampaniaID or @CampaniaID = 0)
		and (CDRWebID = @CDRWebID or @CDRWebID = 0)
	order by CDRWebID desc

end

go

USE BelcorpEcuador
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
			CDRWebID,
			PedidoID,
			PedidoNumero,
			CampaniaID,
			ConsultoraID,
			FechaRegistro,
			Estado,
			FechaCulminado,
			FechaAtencion,
			Importe				
	from CDRWeb
	where ConsultoraID = @ConsultoraID
		and (PedidoID = @PedidoID or @PedidoID = 0)
		and (CampaniaID = @CampaniaID or @CampaniaID = 0)
		and (CDRWebID = @CDRWebID or @CDRWebID = 0)
	order by CDRWebID desc

end

go

USE BelcorpGuatemala
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
			CDRWebID,
			PedidoID,
			PedidoNumero,
			CampaniaID,
			ConsultoraID,
			FechaRegistro,
			Estado,
			FechaCulminado,
			FechaAtencion,
			Importe				
	from CDRWeb
	where ConsultoraID = @ConsultoraID
		and (PedidoID = @PedidoID or @PedidoID = 0)
		and (CampaniaID = @CampaniaID or @CampaniaID = 0)
		and (CDRWebID = @CDRWebID or @CDRWebID = 0)
	order by CDRWebID desc

end

go

USE BelcorpPanama
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
			CDRWebID,
			PedidoID,
			PedidoNumero,
			CampaniaID,
			ConsultoraID,
			FechaRegistro,
			Estado,
			FechaCulminado,
			FechaAtencion,
			Importe				
	from CDRWeb
	where ConsultoraID = @ConsultoraID
		and (PedidoID = @PedidoID or @PedidoID = 0)
		and (CampaniaID = @CampaniaID or @CampaniaID = 0)
		and (CDRWebID = @CDRWebID or @CDRWebID = 0)
	order by CDRWebID desc

end

go

USE BelcorpPuertoRico
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
			CDRWebID,
			PedidoID,
			PedidoNumero,
			CampaniaID,
			ConsultoraID,
			FechaRegistro,
			Estado,
			FechaCulminado,
			FechaAtencion,
			Importe				
	from CDRWeb
	where ConsultoraID = @ConsultoraID
		and (PedidoID = @PedidoID or @PedidoID = 0)
		and (CampaniaID = @CampaniaID or @CampaniaID = 0)
		and (CDRWebID = @CDRWebID or @CDRWebID = 0)
	order by CDRWebID desc

end

go

USE BelcorpSalvador
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
			CDRWebID,
			PedidoID,
			PedidoNumero,
			CampaniaID,
			ConsultoraID,
			FechaRegistro,
			Estado,
			FechaCulminado,
			FechaAtencion,
			Importe				
	from CDRWeb
	where ConsultoraID = @ConsultoraID
		and (PedidoID = @PedidoID or @PedidoID = 0)
		and (CampaniaID = @CampaniaID or @CampaniaID = 0)
		and (CDRWebID = @CDRWebID or @CDRWebID = 0)
	order by CDRWebID desc

end

go

USE BelcorpVenezuela
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
			CDRWebID,
			PedidoID,
			PedidoNumero,
			CampaniaID,
			ConsultoraID,
			FechaRegistro,
			Estado,
			FechaCulminado,
			FechaAtencion,
			Importe				
	from CDRWeb
	where ConsultoraID = @ConsultoraID
		and (PedidoID = @PedidoID or @PedidoID = 0)
		and (CampaniaID = @CampaniaID or @CampaniaID = 0)
		and (CDRWebID = @CDRWebID or @CDRWebID = 0)
	order by CDRWebID desc

end

go