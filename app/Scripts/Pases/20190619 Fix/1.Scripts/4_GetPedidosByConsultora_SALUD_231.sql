use [BelcorpBolivia]
go
ALTER PROCEDURE dbo.GetPedidosByConsultora
-- exec GetPedidosByConsultora '0534629', 6
	@CodigoConsultora VARCHAR(20),
	@Top INT = 4
AS
BEGIN
	SET NOCOUNT ON;

	declare @Temp table
	(
		Consultora varchar(12),
		NumeroPedido varchar(50),
		Campana int,
		Estado varchar(50),
		Fecha date
	)

	insert into @Temp
	SELECT distinct
		Consultora,
		NroPedido AS NumeroPedido,
		Campana,
		Estado,
		Fecha
	FROM vwPedidosTracking 
	WHERE Campana >= 201409 AND Consultora = @CodigoConsultora;

	select
		Consultora,
		NumeroPedido,
		Campana,
		Estado,
		Fecha
	from (
		select top (@Top) *
		from @Temp as t1
		where not exists (
		  select 1
		  from @Temp as t2
		  where t1.Campana = t2.Campana and t1.Fecha < t2.Fecha)
	) t
	order by Campana DESC, Fecha DESC;
END

GO

use [BelcorpChile]
go
ALTER PROCEDURE dbo.GetPedidosByConsultora
-- EXEC GetPedidosByConsultora '0774948',6
	@CodigoConsultora VARCHAR(20),
	@Top INT = 4
AS
BEGIN
	SET NOCOUNT ON;

	declare @Temp table
	(
		Consultora varchar(12),
		NumeroPedido varchar(50),
		Campana int,
		Estado varchar(50),
		Fecha date
	)

	insert into @Temp
	SELECT distinct
		Consultora,
		NroPedido AS NumeroPedido,
		Campana,
		Estado,
		FechaFact
	FROM vwPedidosTracking 
	WHERE Consultora = @CodigoConsultora

	select
		t.Consultora,
		t.NumeroPedido,
		t.Campana, 
		case when pfr.Periodo is null then t.Estado else 'ANULADO' end Estado,
		t.Fecha
	from (
		select top (@Top) *
		from @Temp as t1
		where not exists (
		  select 1
		  from @Temp as t2
		  where t1.Campana = t2.Campana and t1.Fecha < t2.Fecha)
	) t
	left join ods.PedidoFacturadoRechazado pfr with(nolock) on
		t.Campana = pfr.Periodo and
		t.Consultora = pfr.CodigoConsultora and
		t.NumeroPedido = pfr.NumeroPedido
	order by t.Campana DESC, t.Fecha DESC;
END

GO

use [BelcorpColombia]
go
ALTER PROCEDURE dbo.GetPedidosByConsultora
	@CodigoConsultora VARCHAR(20),
	@Top INT = 4
AS
BEGIN
	SET NOCOUNT ON;

	declare @Temp table
	(
		Consultora varchar(12),
		NumeroPedido varchar(50),
		Campana int,
		Estado varchar(50),
		Fecha date
	)

	insert into @Temp
	SELECT distinct
		Consultora,
		NroPedido AS NumeroPedido,
		Campana,
		Estado,
		FechaFact
	FROM vwPedidosTracking 
	WHERE Campana >= 201407 AND Consultora = @CodigoConsultora;

	select
		t.Consultora,
		t.NumeroPedido,
		t.Campana, 
		case when pfr.Periodo is null then t.Estado else 'ANULADO' end Estado,
		t.Fecha
	from (
		select top (@Top) *
		from @Temp as t1
		where not exists (
		  select 1
		  from @Temp as t2
		  where t1.Campana = t2.Campana and t1.Fecha < t2.Fecha)
	) t
	left join ods.PedidoFacturadoRechazado pfr with(nolock) on
		t.Campana = pfr.Periodo and
		t.Consultora = pfr.CodigoConsultora and
		t.NumeroPedido = pfr.NumeroPedido
	order by t.Campana DESC, t.Fecha DESC;
END

GO


use [BelcorpCostaRica]
go
ALTER PROCEDURE dbo.GetPedidosByConsultora
	@CodigoConsultora VARCHAR(20),
	@Top INT = 4
AS
BEGIN
	SET NOCOUNT ON;

	declare @Temp table
	(
		Consultora varchar(12),
		NumeroPedido varchar(50),
		Campana int,
		Estado varchar(50),
		Fecha date
	)

	insert into @Temp
	SELECT distinct
		Consultora,
		NroPedido AS NumeroPedido,
		Campana,
		Estado,
		FechaFact
	FROM vwPedidosTracking 
	WHERE Consultora = @CodigoConsultora

	select
		t.Consultora,
		t.NumeroPedido,
		t.Campana, 
		case when pfr.Periodo is null then t.Estado else 'ANULADO' end Estado,
		t.Fecha
	from (
		select top (@Top) *
		from @Temp as t1
		where not exists (
		  select 1
		  from @Temp as t2
		  where t1.Campana = t2.Campana and t1.Fecha < t2.Fecha)
	) t
	left join ods.PedidoFacturadoRechazado pfr with(nolock) on
		t.Campana = pfr.Periodo and
		t.Consultora = pfr.CodigoConsultora and
		t.NumeroPedido = pfr.NumeroPedido
	order by t.Campana DESC, t.Fecha DESC;
END

GO

use [BelcorpDominicana]
go

ALTER PROCEDURE dbo.GetPedidosByConsultora
	@CodigoConsultora VARCHAR(20),
	@Top INT = 4
AS
BEGIN
	SET NOCOUNT ON;

	declare @Temp table
	(
		Consultora varchar(12),
		NumeroPedido varchar(50),
		Campana int,
		Estado varchar(50),
		Fecha date
	)

	insert into @Temp
	SELECT distinct
	Consultora,
	NroPedido AS NumeroPedido,
	Campana,
	Estado,
	FechaFact
	FROM vwPedidosTracking 
	WHERE Consultora = @CodigoConsultora;

	select
		t.Consultora,
		t.NumeroPedido,
		t.Campana, 
		case when pfr.Periodo is null then t.Estado else 'ANULADO' end Estado,
		t.Fecha
	from (
		select top (@Top) *
		from @Temp as t1
		where not exists (
		  select 1
		  from @Temp as t2
		  where t1.Campana = t2.Campana and t1.Fecha < t2.Fecha)
	) t
	left join ods.PedidoFacturadoRechazado pfr with(nolock) on
		t.Campana = pfr.Periodo and
		t.Consultora = pfr.CodigoConsultora and
		t.NumeroPedido = pfr.NumeroPedido
	order by t.Campana DESC, t.Fecha DESC;
END

GO

use [BelcorpEcuador]
go

ALTER PROCEDURE dbo.GetPedidosByConsultora
	@CodigoConsultora VARCHAR(20),
	@Top INT = 4
AS
BEGIN
	SET NOCOUNT ON;

	declare @Temp table
	(
		Consultora varchar(12),
		NumeroPedido varchar(50),
		Campana int,
		Estado varchar(50),
		Fecha date
	)

	insert into @Temp
	SELECT distinct
	Consultora,
	NroPedido AS NumeroPedido,
	Campana,
	Estado,
	FechaFact
	FROM vwPedidosTracking 
	WHERE Consultora = @CodigoConsultora;

	select
		t.Consultora,
		t.NumeroPedido,
		t.Campana, 
		case when pfr.Periodo is null then t.Estado else 'ANULADO' end Estado,
		t.Fecha
	from (
		select top (@Top) *
		from @Temp as t1
		where not exists (
		  select 1
		  from @Temp as t2
		  where t1.Campana = t2.Campana and t1.Fecha < t2.Fecha)
	) t
	left join ods.PedidoFacturadoRechazado pfr with(nolock) on
		t.Campana = pfr.Periodo and
		t.Consultora = pfr.CodigoConsultora and
		t.NumeroPedido = pfr.NumeroPedido
	order by t.Campana DESC, t.Fecha DESC;
END

GO

use [BelcorpGuatemala]
go

ALTER PROCEDURE dbo.GetPedidosByConsultora
	@CodigoConsultora VARCHAR(20),
	@Top INT = 4
AS
BEGIN
	SET NOCOUNT ON;

	declare @Temp table
	(
		Consultora varchar(12),
		NumeroPedido varchar(50),
		Campana int,
		Estado varchar(50),
		Fecha date
	)

	insert into @Temp
	SELECT distinct
		Consultora,
		NroPedido AS NumeroPedido,
		Campana,
		Estado,
		FechaFact
	FROM vwPedidosTracking 
	WHERE Consultora = @CodigoConsultora;

	select
		t.Consultora,
		t.NumeroPedido,
		t.Campana, 
		case when pfr.Periodo is null then t.Estado else 'ANULADO' end Estado,
		t.Fecha
	from (
		select top (@Top) *
		from @Temp as t1
		where not exists (
		  select 1
		  from @Temp as t2
		  where t1.Campana = t2.Campana and t1.Fecha < t2.Fecha)
	) t
	left join ods.PedidoFacturadoRechazado pfr with(nolock) on
		t.Campana = pfr.Periodo and
		t.Consultora = pfr.CodigoConsultora and
		t.NumeroPedido = pfr.NumeroPedido
	order by t.Campana DESC, t.Fecha DESC;
END

GO

use [BelcorpMexico]
go

ALTER PROCEDURE dbo.GetPedidosByConsultora
	@CodigoConsultora VARCHAR(20),
	@Top INT = 4
AS
BEGIN
	SET NOCOUNT ON;

	declare @Temp table
	(
		Consultora varchar(12),
		NumeroPedido varchar(50),
		Campana int,
		Estado varchar(50),
		Fecha date
	)

	insert into @Temp
	SELECT distinct
		Consultora,
		NroPedido AS NumeroPedido,
		Campana,
		Estado,
		Fecha
	FROM vwPedidosTracking 
	WHERE Campana >= 201410 AND Consultora = @CodigoConsultora;

	select
		Consultora,
		NumeroPedido,
		Campana,
		Estado,
		Fecha
	from (
		select top (@Top) *
		from @Temp as t1
		where not exists (
		  select 1
		  from @Temp as t2
		  where t1.Campana = t2.Campana and t1.Fecha < t2.Fecha)
	) t
	order by Campana DESC, Fecha DESC;
END

GO

use [BelcorpPanama]
go

ALTER PROCEDURE dbo.GetPedidosByConsultora
	@CodigoConsultora VARCHAR(20),
	@Top INT = 4
AS
BEGIN
	SET NOCOUNT ON;

	declare @Temp table
	(
		Consultora varchar(12),
		NumeroPedido varchar(50),
		Campana int,
		Estado varchar(50),
		Fecha date
	)

	insert into @Temp
	SELECT distinct
		Consultora,
		NroPedido AS NumeroPedido,
		Campana,
		Estado,
		FechaFact
	FROM vwPedidosTracking 
	WHERE Consultora = @CodigoConsultora;

	select
		t.Consultora,
		t.NumeroPedido,
		t.Campana, 
		case when pfr.Periodo is null then t.Estado else 'ANULADO' end Estado,
		t.Fecha
	from (
		select top (@Top) *
		from @Temp as t1
		where not exists (
		  select 1
		  from @Temp as t2
		  where t1.Campana = t2.Campana and t1.Fecha < t2.Fecha)
	) t
	left join ods.PedidoFacturadoRechazado pfr with(nolock) on
		t.Campana = pfr.Periodo and
		t.Consultora = pfr.CodigoConsultora and
		t.NumeroPedido = pfr.NumeroPedido
	order by t.Campana DESC, t.Fecha DESC;
END
go

use [BelcorpPeru]
go

ALTER PROCEDURE dbo.GetPedidosByConsultora
-- exec GetPedidosByConsultora '043926217',6
	@CodigoConsultora VARCHAR(20),
	@Top INT = 4
AS
BEGIN
	SET NOCOUNT ON;

	declare @Temp table
	(
		Consultora varchar(12),
		NumeroPedido varchar(50),
		Campana int,
		Estado varchar(50),
		Fecha date
	)

	insert into @Temp
	SELECT distinct
		Consultora,
		NroPedido AS NumeroPedido,
		Campana,
		Estado,
		FechaFact
	FROM vwPedidosTracking 
	WHERE Consultora = @CodigoConsultora;

	select
		t.Consultora,
		t.NumeroPedido,
		t.Campana, 
		case when pfr.Periodo is null then t.Estado else 'ANULADO' end Estado,
		t.Fecha
	from (
		select top (@Top) *
		from @Temp as t1
		where not exists (
		  select 1
		  from @Temp as t2
		  where t1.Campana = t2.Campana and t1.Fecha < t2.Fecha)
	) t
	left join ods.PedidoFacturadoRechazado pfr with(nolock) on
		t.Campana = pfr.Periodo and
		t.Consultora = pfr.CodigoConsultora and
		t.NumeroPedido = pfr.NumeroPedido
	order by t.Campana DESC, t.Fecha DESC;
END
go

use [BelcorpPuertoRico]
go

ALTER PROCEDURE dbo.GetPedidosByConsultora
-- exec GetPedidosByConsultora '043926217',6
	@CodigoConsultora VARCHAR(20),
	@Top INT = 4
AS
BEGIN
	SET NOCOUNT ON;

	declare @Temp table
	(
		Consultora varchar(12),
		NumeroPedido varchar(50),
		Campana int,
		Estado varchar(50),
		Fecha date
	)

	insert into @Temp
	SELECT distinct
		Consultora,
		NroPedido AS NumeroPedido,
		Campana,
		Estado,
		FechaFact
	FROM vwPedidosTracking 
	WHERE Consultora = @CodigoConsultora;

	select
		t.Consultora,
		t.NumeroPedido,
		t.Campana, 
		case when pfr.Periodo is null then t.Estado else 'ANULADO' end Estado,
		t.Fecha
	from (
		select top (@Top) *
		from @Temp as t1
		where not exists (
		  select 1
		  from @Temp as t2
		  where t1.Campana = t2.Campana and t1.Fecha < t2.Fecha)
	) t
	left join ods.PedidoFacturadoRechazado pfr with(nolock) on
		t.Campana = pfr.Periodo and
		t.Consultora = pfr.CodigoConsultora and
		t.NumeroPedido = pfr.NumeroPedido
	order by t.Campana DESC, t.Fecha DESC;
END
go

use [BelcorpSalvador]
go

ALTER PROCEDURE dbo.GetPedidosByConsultora
-- exec GetPedidosByConsultora '043926217',6
	@CodigoConsultora VARCHAR(20),
	@Top INT = 4
AS
BEGIN
	SET NOCOUNT ON;

	declare @Temp table
	(
		Consultora varchar(12),
		NumeroPedido varchar(50),
		Campana int,
		Estado varchar(50),
		Fecha date
	)

	insert into @Temp
	SELECT distinct
		Consultora,
		NroPedido AS NumeroPedido,
		Campana,
		Estado,
		FechaFact
	FROM vwPedidosTracking 
	WHERE Consultora = @CodigoConsultora;

	select
		t.Consultora,
		t.NumeroPedido,
		t.Campana, 
		case when pfr.Periodo is null then t.Estado else 'ANULADO' end Estado,
		t.Fecha
	from (
		select top (@Top) *
		from @Temp as t1
		where not exists (
		  select 1
		  from @Temp as t2
		  where t1.Campana = t2.Campana and t1.Fecha < t2.Fecha)
	) t
	left join ods.PedidoFacturadoRechazado pfr with(nolock) on
		t.Campana = pfr.Periodo and
		t.Consultora = pfr.CodigoConsultora and
		t.NumeroPedido = pfr.NumeroPedido
	order by t.Campana DESC, t.Fecha DESC;
END
go