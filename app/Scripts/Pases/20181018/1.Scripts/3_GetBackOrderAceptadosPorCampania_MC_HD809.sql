USE BelcorpPeru
GO

if exists (select 1 from sys.objects where type = 'P' and name = 'GetBackOrderAceptadosPorCampania')
begin
	drop procedure GetBackOrderAceptadosPorCampania
end
go
Create Procedure GetBackOrderAceptadosPorCampania
(
@CampaniaID varchar(20)
)
As
Begin
	declare @Campania int = (select CampaniaID from ods.campania where Codigo = @CampaniaID)

	declare @Tabla_tmp table
	(
		Campania varchar(6),
		Region varchar(5),
		Zona varchar(6),
		CodigoConsultora varchar(20),
		CodigoSap varchar(12),
		Cuv varchar(20),
		DescripcionProducto varchar(100),
		Unidades int,
		FechaFacturacion varchar(10),
		AceptoBackOrder bit,
		codren int identity
	)

	insert into @Tabla_tmp
	select 
		@CampaniaID,
		R.Codigo,
		Z.Codigo,
		U.Codigo,
		M.CodigoProducto,
		M.CUV,
		M.Descripcion,
		D.Cantidad,		
		Isnull(convert(varchar(10), P.FechaFacturado, 103),''),
		D.AceptoBackOrder
	from (
		select PedidoID
		from PedidoWeb 
		where CampaniaID = @CampaniaID and EstadoPedido = 202 and ValidacionAbierta = 0) C
	inner join
		(
		select PedidoID, ConsultoraID, CUV, Cantidad, AceptoBackOrder
		from pedidowebdetalle 
		where CampaniaID=@CampaniaID and AceptobackOrder=1)  D 
	on (C.PedidoID = D.PedidoID)

	inner join 
		(
		select CUV, CodigoProducto, Descripcion
		from ods.ProductoComercial 
		where AnoCampania in (@CampaniaID)) as M 
	on (D.CUV = M.CUV) 
	inner join ODS.Consultora as U on (D.ConsultoraID = U.ConsultoraID)
	inner join ODS.ZONA as Z on (U.ZonaID = Z.ZonaID)
	inner join ODS.Region as R on (U.RegionID = R.RegionID)
	left join ODS.Pedido as P on (D.ConsultoraID = P.ConsultoraID and P.CampaniaID = @Campania)

	select * from @Tabla_tmp
End
GO

USE BelcorpMexico
GO

if exists (select 1 from sys.objects where type = 'P' and name = 'GetBackOrderAceptadosPorCampania')
begin
	drop procedure GetBackOrderAceptadosPorCampania
end
go
Create Procedure GetBackOrderAceptadosPorCampania
(
@CampaniaID varchar(20)
)
As
Begin
	declare @Campania int = (select CampaniaID from ods.campania where Codigo = @CampaniaID)

	declare @Tabla_tmp table
	(
		Campania varchar(6),
		Region varchar(5),
		Zona varchar(6),
		CodigoConsultora varchar(20),
		CodigoSap varchar(12),
		Cuv varchar(20),
		DescripcionProducto varchar(100),
		Unidades int,
		FechaFacturacion varchar(10),
		AceptoBackOrder bit,
		codren int identity
	)

	insert into @Tabla_tmp
	select 
		@CampaniaID,
		R.Codigo,
		Z.Codigo,
		U.Codigo,
		M.CodigoProducto,
		M.CUV,
		M.Descripcion,
		D.Cantidad,		
		Isnull(convert(varchar(10), P.FechaFacturado, 103),''),
		D.AceptoBackOrder
	from (
		select PedidoID
		from PedidoWeb 
		where CampaniaID = @CampaniaID and EstadoPedido = 202 and ValidacionAbierta = 0) C
	inner join
		(
		select PedidoID, ConsultoraID, CUV, Cantidad, AceptoBackOrder
		from pedidowebdetalle 
		where CampaniaID=@CampaniaID and AceptobackOrder=1)  D 
	on (C.PedidoID = D.PedidoID)

	inner join 
		(
		select CUV, CodigoProducto, Descripcion
		from ods.ProductoComercial 
		where AnoCampania in (@CampaniaID)) as M 
	on (D.CUV = M.CUV) 
	inner join ODS.Consultora as U on (D.ConsultoraID = U.ConsultoraID)
	inner join ODS.ZONA as Z on (U.ZonaID = Z.ZonaID)
	inner join ODS.Region as R on (U.RegionID = R.RegionID)
	left join ODS.Pedido as P on (D.ConsultoraID = P.ConsultoraID and P.CampaniaID = @Campania)

	select * from @Tabla_tmp
End
GO

USE BelcorpColombia
GO

if exists (select 1 from sys.objects where type = 'P' and name = 'GetBackOrderAceptadosPorCampania')
begin
	drop procedure GetBackOrderAceptadosPorCampania
end
go
Create Procedure GetBackOrderAceptadosPorCampania
(
@CampaniaID varchar(20)
)
As
Begin
	declare @Campania int = (select CampaniaID from ods.campania where Codigo = @CampaniaID)

	declare @Tabla_tmp table
	(
		Campania varchar(6),
		Region varchar(5),
		Zona varchar(6),
		CodigoConsultora varchar(20),
		CodigoSap varchar(12),
		Cuv varchar(20),
		DescripcionProducto varchar(100),
		Unidades int,
		FechaFacturacion varchar(10),
		AceptoBackOrder bit,
		codren int identity
	)

	insert into @Tabla_tmp
	select 
		@CampaniaID,
		R.Codigo,
		Z.Codigo,
		U.Codigo,
		M.CodigoProducto,
		M.CUV,
		M.Descripcion,
		D.Cantidad,		
		Isnull(convert(varchar(10), P.FechaFacturado, 103),''),
		D.AceptoBackOrder
	from (
		select PedidoID
		from PedidoWeb 
		where CampaniaID = @CampaniaID and EstadoPedido = 202 and ValidacionAbierta = 0) C
	inner join
		(
		select PedidoID, ConsultoraID, CUV, Cantidad, AceptoBackOrder
		from pedidowebdetalle 
		where CampaniaID=@CampaniaID and AceptobackOrder=1)  D 
	on (C.PedidoID = D.PedidoID)

	inner join 
		(
		select CUV, CodigoProducto, Descripcion
		from ods.ProductoComercial 
		where AnoCampania in (@CampaniaID)) as M 
	on (D.CUV = M.CUV) 
	inner join ODS.Consultora as U on (D.ConsultoraID = U.ConsultoraID)
	inner join ODS.ZONA as Z on (U.ZonaID = Z.ZonaID)
	inner join ODS.Region as R on (U.RegionID = R.RegionID)
	left join ODS.Pedido as P on (D.ConsultoraID = P.ConsultoraID and P.CampaniaID = @Campania)

	select * from @Tabla_tmp
End
GO

USE BelcorpSalvador
GO

if exists (select 1 from sys.objects where type = 'P' and name = 'GetBackOrderAceptadosPorCampania')
begin
	drop procedure GetBackOrderAceptadosPorCampania
end
go
Create Procedure GetBackOrderAceptadosPorCampania
(
@CampaniaID varchar(20)
)
As
Begin
	declare @Campania int = (select CampaniaID from ods.campania where Codigo = @CampaniaID)

	declare @Tabla_tmp table
	(
		Campania varchar(6),
		Region varchar(5),
		Zona varchar(6),
		CodigoConsultora varchar(20),
		CodigoSap varchar(12),
		Cuv varchar(20),
		DescripcionProducto varchar(100),
		Unidades int,
		FechaFacturacion varchar(10),
		AceptoBackOrder bit,
		codren int identity
	)

	insert into @Tabla_tmp
	select 
		@CampaniaID,
		R.Codigo,
		Z.Codigo,
		U.Codigo,
		M.CodigoProducto,
		M.CUV,
		M.Descripcion,
		D.Cantidad,		
		Isnull(convert(varchar(10), P.FechaFacturado, 103),''),
		D.AceptoBackOrder
	from (
		select PedidoID
		from PedidoWeb 
		where CampaniaID = @CampaniaID and EstadoPedido = 202 and ValidacionAbierta = 0) C
	inner join
		(
		select PedidoID, ConsultoraID, CUV, Cantidad, AceptoBackOrder
		from pedidowebdetalle 
		where CampaniaID=@CampaniaID and AceptobackOrder=1)  D 
	on (C.PedidoID = D.PedidoID)

	inner join 
		(
		select CUV, CodigoProducto, Descripcion
		from ods.ProductoComercial 
		where AnoCampania in (@CampaniaID)) as M 
	on (D.CUV = M.CUV) 
	inner join ODS.Consultora as U on (D.ConsultoraID = U.ConsultoraID)
	inner join ODS.ZONA as Z on (U.ZonaID = Z.ZonaID)
	inner join ODS.Region as R on (U.RegionID = R.RegionID)
	left join ODS.Pedido as P on (D.ConsultoraID = P.ConsultoraID and P.CampaniaID = @Campania)

	select * from @Tabla_tmp
End
GO

USE BelcorpPuertoRico
GO

if exists (select 1 from sys.objects where type = 'P' and name = 'GetBackOrderAceptadosPorCampania')
begin
	drop procedure GetBackOrderAceptadosPorCampania
end
go
Create Procedure GetBackOrderAceptadosPorCampania
(
@CampaniaID varchar(20)
)
As
Begin
	declare @Campania int = (select CampaniaID from ods.campania where Codigo = @CampaniaID)

	declare @Tabla_tmp table
	(
		Campania varchar(6),
		Region varchar(5),
		Zona varchar(6),
		CodigoConsultora varchar(20),
		CodigoSap varchar(12),
		Cuv varchar(20),
		DescripcionProducto varchar(100),
		Unidades int,
		FechaFacturacion varchar(10),
		AceptoBackOrder bit,
		codren int identity
	)

	insert into @Tabla_tmp
	select 
		@CampaniaID,
		R.Codigo,
		Z.Codigo,
		U.Codigo,
		M.CodigoProducto,
		M.CUV,
		M.Descripcion,
		D.Cantidad,		
		Isnull(convert(varchar(10), P.FechaFacturado, 103),''),
		D.AceptoBackOrder
	from (
		select PedidoID
		from PedidoWeb 
		where CampaniaID = @CampaniaID and EstadoPedido = 202 and ValidacionAbierta = 0) C
	inner join
		(
		select PedidoID, ConsultoraID, CUV, Cantidad, AceptoBackOrder
		from pedidowebdetalle 
		where CampaniaID=@CampaniaID and AceptobackOrder=1)  D 
	on (C.PedidoID = D.PedidoID)

	inner join 
		(
		select CUV, CodigoProducto, Descripcion
		from ods.ProductoComercial 
		where AnoCampania in (@CampaniaID)) as M 
	on (D.CUV = M.CUV) 
	inner join ODS.Consultora as U on (D.ConsultoraID = U.ConsultoraID)
	inner join ODS.ZONA as Z on (U.ZonaID = Z.ZonaID)
	inner join ODS.Region as R on (U.RegionID = R.RegionID)
	left join ODS.Pedido as P on (D.ConsultoraID = P.ConsultoraID and P.CampaniaID = @Campania)

	select * from @Tabla_tmp
End
GO

USE BelcorpPanama
GO

if exists (select 1 from sys.objects where type = 'P' and name = 'GetBackOrderAceptadosPorCampania')
begin
	drop procedure GetBackOrderAceptadosPorCampania
end
go
Create Procedure GetBackOrderAceptadosPorCampania
(
@CampaniaID varchar(20)
)
As
Begin
	declare @Campania int = (select CampaniaID from ods.campania where Codigo = @CampaniaID)

	declare @Tabla_tmp table
	(
		Campania varchar(6),
		Region varchar(5),
		Zona varchar(6),
		CodigoConsultora varchar(20),
		CodigoSap varchar(12),
		Cuv varchar(20),
		DescripcionProducto varchar(100),
		Unidades int,
		FechaFacturacion varchar(10),
		AceptoBackOrder bit,
		codren int identity
	)

	insert into @Tabla_tmp
	select 
		@CampaniaID,
		R.Codigo,
		Z.Codigo,
		U.Codigo,
		M.CodigoProducto,
		M.CUV,
		M.Descripcion,
		D.Cantidad,		
		Isnull(convert(varchar(10), P.FechaFacturado, 103),''),
		D.AceptoBackOrder
	from (
		select PedidoID
		from PedidoWeb 
		where CampaniaID = @CampaniaID and EstadoPedido = 202 and ValidacionAbierta = 0) C
	inner join
		(
		select PedidoID, ConsultoraID, CUV, Cantidad, AceptoBackOrder
		from pedidowebdetalle 
		where CampaniaID=@CampaniaID and AceptobackOrder=1)  D 
	on (C.PedidoID = D.PedidoID)

	inner join 
		(
		select CUV, CodigoProducto, Descripcion
		from ods.ProductoComercial 
		where AnoCampania in (@CampaniaID)) as M 
	on (D.CUV = M.CUV) 
	inner join ODS.Consultora as U on (D.ConsultoraID = U.ConsultoraID)
	inner join ODS.ZONA as Z on (U.ZonaID = Z.ZonaID)
	inner join ODS.Region as R on (U.RegionID = R.RegionID)
	left join ODS.Pedido as P on (D.ConsultoraID = P.ConsultoraID and P.CampaniaID = @Campania)

	select * from @Tabla_tmp
End
GO

USE BelcorpGuatemala
GO

if exists (select 1 from sys.objects where type = 'P' and name = 'GetBackOrderAceptadosPorCampania')
begin
	drop procedure GetBackOrderAceptadosPorCampania
end
go
Create Procedure GetBackOrderAceptadosPorCampania
(
@CampaniaID varchar(20)
)
As
Begin
	declare @Campania int = (select CampaniaID from ods.campania where Codigo = @CampaniaID)

	declare @Tabla_tmp table
	(
		Campania varchar(6),
		Region varchar(5),
		Zona varchar(6),
		CodigoConsultora varchar(20),
		CodigoSap varchar(12),
		Cuv varchar(20),
		DescripcionProducto varchar(100),
		Unidades int,
		FechaFacturacion varchar(10),
		AceptoBackOrder bit,
		codren int identity
	)

	insert into @Tabla_tmp
	select 
		@CampaniaID,
		R.Codigo,
		Z.Codigo,
		U.Codigo,
		M.CodigoProducto,
		M.CUV,
		M.Descripcion,
		D.Cantidad,		
		Isnull(convert(varchar(10), P.FechaFacturado, 103),''),
		D.AceptoBackOrder
	from (
		select PedidoID
		from PedidoWeb 
		where CampaniaID = @CampaniaID and EstadoPedido = 202 and ValidacionAbierta = 0) C
	inner join
		(
		select PedidoID, ConsultoraID, CUV, Cantidad, AceptoBackOrder
		from pedidowebdetalle 
		where CampaniaID=@CampaniaID and AceptobackOrder=1)  D 
	on (C.PedidoID = D.PedidoID)

	inner join 
		(
		select CUV, CodigoProducto, Descripcion
		from ods.ProductoComercial 
		where AnoCampania in (@CampaniaID)) as M 
	on (D.CUV = M.CUV) 
	inner join ODS.Consultora as U on (D.ConsultoraID = U.ConsultoraID)
	inner join ODS.ZONA as Z on (U.ZonaID = Z.ZonaID)
	inner join ODS.Region as R on (U.RegionID = R.RegionID)
	left join ODS.Pedido as P on (D.ConsultoraID = P.ConsultoraID and P.CampaniaID = @Campania)

	select * from @Tabla_tmp
End
GO

USE BelcorpEcuador
GO

if exists (select 1 from sys.objects where type = 'P' and name = 'GetBackOrderAceptadosPorCampania')
begin
	drop procedure GetBackOrderAceptadosPorCampania
end
go
Create Procedure GetBackOrderAceptadosPorCampania
(
@CampaniaID varchar(20)
)
As
Begin
	declare @Campania int = (select CampaniaID from ods.campania where Codigo = @CampaniaID)

	declare @Tabla_tmp table
	(
		Campania varchar(6),
		Region varchar(5),
		Zona varchar(6),
		CodigoConsultora varchar(20),
		CodigoSap varchar(12),
		Cuv varchar(20),
		DescripcionProducto varchar(100),
		Unidades int,
		FechaFacturacion varchar(10),
		AceptoBackOrder bit,
		codren int identity
	)

	insert into @Tabla_tmp
	select 
		@CampaniaID,
		R.Codigo,
		Z.Codigo,
		U.Codigo,
		M.CodigoProducto,
		M.CUV,
		M.Descripcion,
		D.Cantidad,		
		Isnull(convert(varchar(10), P.FechaFacturado, 103),''),
		D.AceptoBackOrder
	from (
		select PedidoID
		from PedidoWeb 
		where CampaniaID = @CampaniaID and EstadoPedido = 202 and ValidacionAbierta = 0) C
	inner join
		(
		select PedidoID, ConsultoraID, CUV, Cantidad, AceptoBackOrder
		from pedidowebdetalle 
		where CampaniaID=@CampaniaID and AceptobackOrder=1)  D 
	on (C.PedidoID = D.PedidoID)

	inner join 
		(
		select CUV, CodigoProducto, Descripcion
		from ods.ProductoComercial 
		where AnoCampania in (@CampaniaID)) as M 
	on (D.CUV = M.CUV) 
	inner join ODS.Consultora as U on (D.ConsultoraID = U.ConsultoraID)
	inner join ODS.ZONA as Z on (U.ZonaID = Z.ZonaID)
	inner join ODS.Region as R on (U.RegionID = R.RegionID)
	left join ODS.Pedido as P on (D.ConsultoraID = P.ConsultoraID and P.CampaniaID = @Campania)

	select * from @Tabla_tmp
End
GO

USE BelcorpDominicana
GO

if exists (select 1 from sys.objects where type = 'P' and name = 'GetBackOrderAceptadosPorCampania')
begin
	drop procedure GetBackOrderAceptadosPorCampania
end
go
Create Procedure GetBackOrderAceptadosPorCampania
(
@CampaniaID varchar(20)
)
As
Begin
	declare @Campania int = (select CampaniaID from ods.campania where Codigo = @CampaniaID)

	declare @Tabla_tmp table
	(
		Campania varchar(6),
		Region varchar(5),
		Zona varchar(6),
		CodigoConsultora varchar(20),
		CodigoSap varchar(12),
		Cuv varchar(20),
		DescripcionProducto varchar(100),
		Unidades int,
		FechaFacturacion varchar(10),
		AceptoBackOrder bit,
		codren int identity
	)

	insert into @Tabla_tmp
	select 
		@CampaniaID,
		R.Codigo,
		Z.Codigo,
		U.Codigo,
		M.CodigoProducto,
		M.CUV,
		M.Descripcion,
		D.Cantidad,		
		Isnull(convert(varchar(10), P.FechaFacturado, 103),''),
		D.AceptoBackOrder
	from (
		select PedidoID
		from PedidoWeb 
		where CampaniaID = @CampaniaID and EstadoPedido = 202 and ValidacionAbierta = 0) C
	inner join
		(
		select PedidoID, ConsultoraID, CUV, Cantidad, AceptoBackOrder
		from pedidowebdetalle 
		where CampaniaID=@CampaniaID and AceptobackOrder=1)  D 
	on (C.PedidoID = D.PedidoID)

	inner join 
		(
		select CUV, CodigoProducto, Descripcion
		from ods.ProductoComercial 
		where AnoCampania in (@CampaniaID)) as M 
	on (D.CUV = M.CUV) 
	inner join ODS.Consultora as U on (D.ConsultoraID = U.ConsultoraID)
	inner join ODS.ZONA as Z on (U.ZonaID = Z.ZonaID)
	inner join ODS.Region as R on (U.RegionID = R.RegionID)
	left join ODS.Pedido as P on (D.ConsultoraID = P.ConsultoraID and P.CampaniaID = @Campania)

	select * from @Tabla_tmp
End
GO

USE BelcorpCostaRica
GO

if exists (select 1 from sys.objects where type = 'P' and name = 'GetBackOrderAceptadosPorCampania')
begin
	drop procedure GetBackOrderAceptadosPorCampania
end
go
Create Procedure GetBackOrderAceptadosPorCampania
(
@CampaniaID varchar(20)
)
As
Begin
	declare @Campania int = (select CampaniaID from ods.campania where Codigo = @CampaniaID)

	declare @Tabla_tmp table
	(
		Campania varchar(6),
		Region varchar(5),
		Zona varchar(6),
		CodigoConsultora varchar(20),
		CodigoSap varchar(12),
		Cuv varchar(20),
		DescripcionProducto varchar(100),
		Unidades int,
		FechaFacturacion varchar(10),
		AceptoBackOrder bit,
		codren int identity
	)

	insert into @Tabla_tmp
	select 
		@CampaniaID,
		R.Codigo,
		Z.Codigo,
		U.Codigo,
		M.CodigoProducto,
		M.CUV,
		M.Descripcion,
		D.Cantidad,		
		Isnull(convert(varchar(10), P.FechaFacturado, 103),''),
		D.AceptoBackOrder
	from (
		select PedidoID
		from PedidoWeb 
		where CampaniaID = @CampaniaID and EstadoPedido = 202 and ValidacionAbierta = 0) C
	inner join
		(
		select PedidoID, ConsultoraID, CUV, Cantidad, AceptoBackOrder
		from pedidowebdetalle 
		where CampaniaID=@CampaniaID and AceptobackOrder=1)  D 
	on (C.PedidoID = D.PedidoID)

	inner join 
		(
		select CUV, CodigoProducto, Descripcion
		from ods.ProductoComercial 
		where AnoCampania in (@CampaniaID)) as M 
	on (D.CUV = M.CUV) 
	inner join ODS.Consultora as U on (D.ConsultoraID = U.ConsultoraID)
	inner join ODS.ZONA as Z on (U.ZonaID = Z.ZonaID)
	inner join ODS.Region as R on (U.RegionID = R.RegionID)
	left join ODS.Pedido as P on (D.ConsultoraID = P.ConsultoraID and P.CampaniaID = @Campania)

	select * from @Tabla_tmp
End
GO

USE BelcorpChile
GO

if exists (select 1 from sys.objects where type = 'P' and name = 'GetBackOrderAceptadosPorCampania')
begin
	drop procedure GetBackOrderAceptadosPorCampania
end
go
Create Procedure GetBackOrderAceptadosPorCampania
(
@CampaniaID varchar(20)
)
As
Begin
	declare @Campania int = (select CampaniaID from ods.campania where Codigo = @CampaniaID)

	declare @Tabla_tmp table
	(
		Campania varchar(6),
		Region varchar(5),
		Zona varchar(6),
		CodigoConsultora varchar(20),
		CodigoSap varchar(12),
		Cuv varchar(20),
		DescripcionProducto varchar(100),
		Unidades int,
		FechaFacturacion varchar(10),
		AceptoBackOrder bit,
		codren int identity
	)

	insert into @Tabla_tmp
	select 
		@CampaniaID,
		R.Codigo,
		Z.Codigo,
		U.Codigo,
		M.CodigoProducto,
		M.CUV,
		M.Descripcion,
		D.Cantidad,		
		Isnull(convert(varchar(10), P.FechaFacturado, 103),''),
		D.AceptoBackOrder
	from (
		select PedidoID
		from PedidoWeb 
		where CampaniaID = @CampaniaID and EstadoPedido = 202 and ValidacionAbierta = 0) C
	inner join
		(
		select PedidoID, ConsultoraID, CUV, Cantidad, AceptoBackOrder
		from pedidowebdetalle 
		where CampaniaID=@CampaniaID and AceptobackOrder=1)  D 
	on (C.PedidoID = D.PedidoID)

	inner join 
		(
		select CUV, CodigoProducto, Descripcion
		from ods.ProductoComercial 
		where AnoCampania in (@CampaniaID)) as M 
	on (D.CUV = M.CUV) 
	inner join ODS.Consultora as U on (D.ConsultoraID = U.ConsultoraID)
	inner join ODS.ZONA as Z on (U.ZonaID = Z.ZonaID)
	inner join ODS.Region as R on (U.RegionID = R.RegionID)
	left join ODS.Pedido as P on (D.ConsultoraID = P.ConsultoraID and P.CampaniaID = @Campania)

	select * from @Tabla_tmp
End
GO

USE BelcorpBolivia
GO

if exists (select 1 from sys.objects where type = 'P' and name = 'GetBackOrderAceptadosPorCampania')
begin
	drop procedure GetBackOrderAceptadosPorCampania
end
go
Create Procedure GetBackOrderAceptadosPorCampania
(
@CampaniaID varchar(20)
)
As
Begin
	declare @Campania int = (select CampaniaID from ods.campania where Codigo = @CampaniaID)

	declare @Tabla_tmp table
	(
		Campania varchar(6),
		Region varchar(5),
		Zona varchar(6),
		CodigoConsultora varchar(20),
		CodigoSap varchar(12),
		Cuv varchar(20),
		DescripcionProducto varchar(100),
		Unidades int,
		FechaFacturacion varchar(10),
		AceptoBackOrder bit,
		codren int identity
	)

	insert into @Tabla_tmp
	select 
		@CampaniaID,
		R.Codigo,
		Z.Codigo,
		U.Codigo,
		M.CodigoProducto,
		M.CUV,
		M.Descripcion,
		D.Cantidad,		
		Isnull(convert(varchar(10), P.FechaFacturado, 103),''),
		D.AceptoBackOrder
	from (
		select PedidoID
		from PedidoWeb 
		where CampaniaID = @CampaniaID and EstadoPedido = 202 and ValidacionAbierta = 0) C
	inner join
		(
		select PedidoID, ConsultoraID, CUV, Cantidad, AceptoBackOrder
		from pedidowebdetalle 
		where CampaniaID=@CampaniaID and AceptobackOrder=1)  D 
	on (C.PedidoID = D.PedidoID)

	inner join 
		(
		select CUV, CodigoProducto, Descripcion
		from ods.ProductoComercial 
		where AnoCampania in (@CampaniaID)) as M 
	on (D.CUV = M.CUV) 
	inner join ODS.Consultora as U on (D.ConsultoraID = U.ConsultoraID)
	inner join ODS.ZONA as Z on (U.ZonaID = Z.ZonaID)
	inner join ODS.Region as R on (U.RegionID = R.RegionID)
	left join ODS.Pedido as P on (D.ConsultoraID = P.ConsultoraID and P.CampaniaID = @Campania)

	select * from @Tabla_tmp
End
GO

