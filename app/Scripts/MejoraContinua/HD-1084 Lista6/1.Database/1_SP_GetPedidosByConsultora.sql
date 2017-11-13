USE BelcorpBolivia
GO
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
	WHERE Campana >= 201409 AND Consultora = @CodigoConsultora;

	select top (@Top)
		Consultora,
		NumeroPedido,
		Campana,
		Estado,
		Fecha
	from @Temp
	order by Campana DESC, Fecha DESC;
END
GO
/*end*/

USE BelcorpChile
GO
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
	WHERE Consultora = @CodigoConsultora

	select top (@Top) 
		t.Consultora,
		t.NumeroPedido,
		t.Campana, 
		case when pfr.Periodo is null then t.Estado else 'ANULADO' end Estado,
		t.Fecha
	from @Temp t
	left join ods.PedidoFacturadoRechazado pfr with(nolock) on
		t.Campana = pfr.Periodo and
		t.Consultora = pfr.CodigoConsultora and
		t.NumeroPedido = pfr.NumeroPedido
	order by t.Campana DESC, t.Fecha DESC;
END
GO
/*end*/

USE BelcorpColombia
GO
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
	WHERE Campana >= 201407 AND Consultora = @CodigoConsultora;

	select top (@Top)
		t.Consultora,
		t.NumeroPedido,
		t.Campana, 
		case when pfr.Periodo is null then t.Estado else 'ANULADO' end Estado,
		t.Fecha
	from @Temp t
	left join ods.PedidoFacturadoRechazado pfr with(nolock) on
		t.Campana = pfr.Periodo and
		t.Consultora = pfr.CodigoConsultora and
		t.NumeroPedido = pfr.NumeroPedido
	order by t.Campana DESC, t.Fecha DESC;
END
GO
/*end*/

USE BelcorpCostaRica
GO
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
	WHERE Consultora = @CodigoConsultora;

	select top (@Top)
		t.Consultora,
		t.NumeroPedido,
		t.Campana, 
		case when pfr.Periodo is null then t.Estado else 'ANULADO' end Estado,
		t.Fecha
	from @Temp t
	left join ods.PedidoFacturadoRechazado pfr with(nolock) on
		t.Campana = pfr.Periodo and
		t.Consultora = pfr.CodigoConsultora and
		t.NumeroPedido = pfr.NumeroPedido
	order by t.Campana DESC, t.Fecha DESC;;
END
GO
/*end*/

USE BelcorpDominicana
GO
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
	WHERE Consultora = @CodigoConsultora;

	select top (@Top)
		t.Consultora,
		t.NumeroPedido,
		t.Campana, 
		case when pfr.Periodo is null then t.Estado else 'ANULADO' end Estado,
		t.Fecha
	from @Temp t
	left join ods.PedidoFacturadoRechazado pfr with(nolock) on
		t.Campana = pfr.Periodo and
		t.Consultora = pfr.CodigoConsultora and
		t.NumeroPedido = pfr.NumeroPedido
	order by t.Campana DESC, t.Fecha DESC;
END
GO
/*end*/

USE BelcorpEcuador
GO
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
	WHERE Consultora = @CodigoConsultora;

	select top (@Top)
		t.Consultora,
		t.NumeroPedido,
		t.Campana, 
		case when pfr.Periodo is null then t.Estado else 'ANULADO' end Estado,
		t.Fecha
	from @Temp t
	left join ods.PedidoFacturadoRechazado pfr with(nolock) on
		t.Campana = pfr.Periodo and
		t.Consultora = pfr.CodigoConsultora and
		t.NumeroPedido = pfr.NumeroPedido
	order by t.Campana DESC, t.Fecha DESC;
END
GO
/*end*/

USE BelcorpGuatemala
GO
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
	WHERE Consultora = @CodigoConsultora;

	select top (@Top)
		t.Consultora,
		t.NumeroPedido,
		t.Campana, 
		case when pfr.Periodo is null then t.Estado else 'ANULADO' end Estado,
		t.Fecha
	from @Temp t
	left join ods.PedidoFacturadoRechazado pfr with(nolock) on
		t.Campana = pfr.Periodo and
		t.Consultora = pfr.CodigoConsultora and
		t.NumeroPedido = pfr.NumeroPedido
	order by t.Campana DESC, t.Fecha DESC;
END
GO
/*end*/

USE BelcorpMexico
GO
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

	select top (@Top)
		Consultora,
		NumeroPedido,
		Campana,
		Estado,
		Fecha
	from @Temp
	order by Campana DESC, Fecha DESC;
END
GO
/*end*/

USE BelcorpPanama
GO
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
	WHERE Consultora = @CodigoConsultora;

	select top (@Top)
		t.Consultora,
		t.NumeroPedido,
		t.Campana, 
		case when pfr.Periodo is null then t.Estado else 'ANULADO' end Estado,
		t.Fecha
	from @Temp t
	left join ods.PedidoFacturadoRechazado pfr with(nolock) on
		t.Campana = pfr.Periodo and
		t.Consultora = pfr.CodigoConsultora and
		t.NumeroPedido = pfr.NumeroPedido
	order BY t.Campana DESC, t.Fecha DESC;
END
GO
/*end*/

USE BelcorpPeru
GO
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
	WHERE Consultora = @CodigoConsultora;

	select top (@Top)
		t.Consultora,
		t.NumeroPedido,
		t.Campana, 
		case when pfr.Periodo is null then t.Estado else 'ANULADO' end Estado,
		t.Fecha
	from @Temp t
	left join ods.PedidoFacturadoRechazado pfr with(nolock) on
		t.Campana = pfr.Periodo and
		t.Consultora = pfr.CodigoConsultora and
		t.NumeroPedido = pfr.NumeroPedido
	order by t.Campana DESC, t.Fecha DESC;
END
GO
/*end*/

USE BelcorpPuertoRico
GO
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
	WHERE Consultora = @CodigoConsultora;

	select top (@Top)
		t.Consultora,
		t.NumeroPedido,
		t.Campana, 
		case when pfr.Periodo is null then t.Estado else 'ANULADO' end Estado,
		t.Fecha
	from @Temp t
	left join ods.PedidoFacturadoRechazado pfr with(nolock) on
		t.Campana = pfr.Periodo and
		t.Consultora = pfr.CodigoConsultora and
		t.NumeroPedido = pfr.NumeroPedido
	order by t.Campana DESC, t.Fecha DESC;
END
GO
/*end*/

USE BelcorpSalvador
GO
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
	WHERE Consultora = @CodigoConsultora;

	select top (@Top)
		t.Consultora,
		t.NumeroPedido,
		t.Campana, 
		case when pfr.Periodo is null then t.Estado else 'ANULADO' end Estado,
		t.Fecha
	from @Temp t
	left join ods.PedidoFacturadoRechazado pfr with(nolock) on
		t.Campana = pfr.Periodo and
		t.Consultora = pfr.CodigoConsultora and
		t.NumeroPedido = pfr.NumeroPedido
	order by t.Campana DESC, t.Fecha DESC;
END
GO
/*end*/

USE BelcorpVenezuela
GO
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
	WHERE Consultora = @CodigoConsultora
	--ORDER BY Campana DESC, Fecha DESC

	select top (@Top)
		t.Consultora,
		t.NumeroPedido,
		t.Campana, 
		case when pfr.Periodo is null then t.Estado else 'ANULADO' end Estado,
		t.Fecha
	from @Temp t
	left join ods.PedidoFacturadoRechazado pfr with(nolock) on
		t.Campana = pfr.Periodo and
		t.Consultora = pfr.CodigoConsultora and
		t.NumeroPedido = pfr.NumeroPedido
	order by t.Campana DESC, t.Fecha DESC;
END
GO