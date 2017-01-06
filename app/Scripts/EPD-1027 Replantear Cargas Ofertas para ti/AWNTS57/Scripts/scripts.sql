USE BelcorpBolivia
go

IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'EstrategiaTemporal' AND TABLE_SCHEMA = 'dbo')
BEGIN
    DROP TABLE dbo.EstrategiaTemporal
END
GO
CREATE TABLE dbo.EstrategiaTemporal(
	EstrategiaTemporalId INT IDENTITY(1,1) PRIMARY KEY,
	CampaniaId int,
	CUV varchar(5),
	Descripcion varchar(100),
	PrecioOferta decimal(18,2),
	PrecioTachado decimal(18,2),
	CodigoSap varchar(20),
	OfertaUltimoMinuto int,
	LimiteVenta int,
	NumeroLote int,
	FechaCreacion datetime,
	UsuarioCreacion varchar(20)
)
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetCantidadOfertasParaTi]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetCantidadOfertasParaTi
GO

create procedure dbo.GetCantidadOfertasParaTi
@CampaniaID int,
@TipoConfigurado int
as
/*
exec GetCantidadOfertasParaTi 201618,0
exec GetCantidadOfertasParaTi 201618,1
exec GetCantidadOfertasParaTi 201618,2
*/
begin
	declare @resultado int = 0

	declare @tablaCuvsOPT table (CampaniaID int, CUV varchar(5))
	insert into @tablaCuvsOPT
	select distinct @CampaniaID, CUV from ods.OfertasPersonalizadas where AnioCampanaVenta = @CampaniaID and TipoPersonalizacion='OPT'

	if @TipoConfigurado=0
	begin
		set @resultado = (select count(*) from @tablaCuvsOPT)
	end
	else
	begin
		if @TipoConfigurado = 1
		begin
			set @resultado = (select count(*)
			from Estrategia e
			inner join @tablaCuvsOPT t on
				e.CampaniaID = t.CampaniaID
				and e.CUV2 = t.CUV
			where e.CampaniaID = @CampaniaID)
		end
		else
		begin
			set @resultado = (select count(*)
			from @tablaCuvsOPT t
			left join Estrategia e on
				t.CampaniaID = e.CampaniaID
				and t.CUV = e.CUV2
			where 
				t.CampaniaID = @CampaniaID
				and e.CUV2 is null)
		end
	end

	select @resultado	
end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetOfertasParaTiByTipoConfigurado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetOfertasParaTiByTipoConfigurado
GO

create procedure dbo.GetOfertasParaTiByTipoConfigurado
@CampaniaID int,
@TipoConfigurado int
as
/*
exec GetOfertasParaTiByTipoConfigurado 201618,0
exec GetOfertasParaTiByTipoConfigurado 201618,1
exec GetOfertasParaTiByTipoConfigurado 201618,2
*/
begin
	declare @tablaResultado table (
		CUV2 varchar(5), 
		DescripcionCUV2 varchar(100),
		Precio2 decimal(18,2),
		CodigoProducto varchar(20),
		OfertaUltimoMinuto int,
		LimiteVenta int
	)

	declare @tablaCuvsOPT table (CampaniaID int, CUV varchar(5), OfertaUltimoMinuto int, LimiteVenta int)
	insert into @tablaCuvsOPT
	select distinct @CampaniaID, CUV, isnull(FlagUltMinuto,0), isnull(LimUnidades,99)
	from ods.OfertasPersonalizadas where AnioCampanaVenta = @CampaniaID and TipoPersonalizacion='OPT'

	if @TipoConfigurado=0
	begin
		insert into @tablaResultado
		select 
			t.CUV,
			coalesce(e.DescripcionCUV2,pd.Descripcion,p.Descripcion),
			coalesce(e.Precio2,p.PrecioUnitario),
			p.CodigoProducto,
			t.OfertaUltimoMinuto,
			t.LimiteVenta
		from @tablaCuvsOPT t
		inner join ods.ProductoComercial p on
			t.CampaniaID = p.AnoCampania
			and t.CUV = p.CUV
		left join Estrategia e on
			t.CampaniaID = e.CampaniaID
			and t.CUV = e.CUV2
		left join dbo.ProductoDescripcion pd on
				p.AnoCampania = pd.CampaniaID
				and p.CUV = pd.CUV
		where 
			p.AnoCampania = @CampaniaID
		
		insert into @tablaResultado
		select
			CUV,'',0,'',0,0
		from @tablaCuvsOPT where CUV not in (
			select CUV from ods.ProductoComercial where AnoCampania = @CampaniaID
		)
	end
	else
	begin
		if @TipoConfigurado = 1
		begin
			insert into @tablaResultado
			select
				t.CUV,
				coalesce(e.DescripcionCUV2,pd.Descripcion,p.Descripcion),
				coalesce(e.Precio2,p.PrecioUnitario),
				p.CodigoProducto,
				t.OfertaUltimoMinuto,
				t.LimiteVenta
			from @tablaCuvsOPT t
			inner join ods.ProductoComercial p on
				t.CampaniaID = p.AnoCampania
				and t.CUV = p.CUV
			inner join Estrategia e on
				t.CampaniaID = e.CampaniaID
				and t.CUV = e.CUV2
			left join dbo.ProductoDescripcion pd on
				p.AnoCampania = pd.CampaniaID
				and p.CUV = pd.CUV
			where e.CampaniaID = @CampaniaID
		end
		else
		begin
			insert into @tablaResultado
			select
				t.CUV,
				coalesce(e.DescripcionCUV2,pd.Descripcion,p.Descripcion),
				coalesce(e.Precio2,p.PrecioUnitario),
				p.CodigoProducto,
				t.OfertaUltimoMinuto,
				t.LimiteVenta
			from @tablaCuvsOPT t
			inner join ods.ProductoComercial p on
				t.CampaniaID = p.AnoCampania
				and t.CUV = p.CUV
			left join Estrategia e on
				t.CampaniaID = e.CampaniaID
				and t.CUV = e.CUV2
			left join dbo.ProductoDescripcion pd on
				p.AnoCampania = pd.CampaniaID
				and p.CUV = pd.CUV
			where 
				t.CampaniaID = @CampaniaID
				and e.CUV2 is null

			insert into @tablaResultado
			select
				CUV,'',0,'',0,0
			from @tablaCuvsOPT where CUV not in (
				select CUV from ods.ProductoComercial where AnoCampania = @CampaniaID
			)
		end
	end

	select * from @tablaResultado
end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertEstrategiaOfertaParaTi]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.InsertEstrategiaOfertaParaTi
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertEstrategiaTemporal]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.InsertEstrategiaTemporal
GO

IF TYPE_ID('dbo.EstrategiaTemporalType') IS NOT NULL
	DROP TYPE dbo.EstrategiaTemporalType
GO

CREATE TYPE dbo.EstrategiaTemporalType AS TABLE(
	CampaniaId int,
	CUV varchar(5),
	Descripcion varchar(100),
	PrecioOferta decimal(18,2),
	PrecioTachado decimal(18,2),
	CodigoSap varchar(20),
	OfertaUltimoMinuto int,
	LimiteVenta int,
	UsuarioCreacion varchar(50)
)
GO

create procedure dbo.InsertEstrategiaTemporal
@EstrategiaTemporal dbo.EstrategiaTemporalType readonly
as
/*

*/
begin

DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

declare @NumeroLote int = 0
select @NumeroLote = isnull(max(NumeroLote),0) from EstrategiaTemporal

set @NumeroLote = @NumeroLote + 1

insert into EstrategiaTemporal 
(CampaniaId,CUV,Descripcion,PrecioOferta,PrecioTachado,CodigoSap,OfertaUltimoMinuto,LimiteVenta,NumeroLote,FechaCreacion,UsuarioCreacion)
select
CampaniaId,CUV,Descripcion,PrecioOferta,PrecioTachado,CodigoSap,OfertaUltimoMinuto,LimiteVenta,@NumeroLote,@FechaGeneral,UsuarioCreacion
from @EstrategiaTemporal

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetCantidadOfertasParaTiTemporal]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetCantidadOfertasParaTiTemporal
GO

create procedure dbo.GetCantidadOfertasParaTiTemporal
@CampaniaID int,
@TipoConfigurado int
as
/*
exec GetCantidadOfertasParaTiTemporal 201618,0
exec GetCantidadOfertasParaTiTemporal 201618,1
exec GetCantidadOfertasParaTiTemporal 201618,2
*/
begin
	declare @resultado int = 0

	declare @NumeroLote int = 0
	select @NumeroLote = max(NumeroLote) from EstrategiaTemporal

	if @TipoConfigurado = 0
	begin		
		select @resultado = count(*) from EstrategiaTemporal
		where 
			CampaniaId = @CampaniaID
			and NumeroLote = @NumeroLote
	end
	else
	begin
		if @TipoConfigurado = 1
		begin
			select @resultado = count(*) from EstrategiaTemporal
			where 
				CampaniaId = @CampaniaID
				and Descripcion != ''
				and NumeroLote = @NumeroLote
		end
		else
		begin
			select @resultado = count(*) from EstrategiaTemporal
			where 
				CampaniaId = @CampaniaID
				and Descripcion = ''
				and NumeroLote = @NumeroLote
		end
	end

	select @resultado
end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetOfertasParaTiByTipoConfiguradoTemporal]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetOfertasParaTiByTipoConfiguradoTemporal
GO

create procedure dbo.GetOfertasParaTiByTipoConfiguradoTemporal
@CampaniaID int,
@TipoConfigurado int
as
/*
exec GetOfertasParaTiByTipoConfiguradoTemporal 201618,0
exec GetOfertasParaTiByTipoConfiguradoTemporal 201618,1
exec GetOfertasParaTiByTipoConfiguradoTemporal 201618,2
*/
begin

	declare @tablaResultado table (
		CUV2 varchar(5), 
		DescripcionCUV2 varchar(100),
		Precio2 decimal(18,2),
		Precio decimal(18,2),
		CodigoProducto varchar(20),
		OfertaUltimoMinuto int,
		LimiteVenta int
	)

	declare @NumeroLote int = 0
	select @NumeroLote = max(NumeroLote) from EstrategiaTemporal

	if @TipoConfigurado = 0
	begin
		insert into @tablaResultado
		select CUV, Descripcion, PrecioOferta, PrecioTachado, CodigoSap, OfertaUltimoMinuto, LimiteVenta
		from EstrategiaTemporal
		where 
			CampaniaId = @CampaniaID
			and NumeroLote = @NumeroLote
	end
	else
	begin
		if @TipoConfigurado = 1
		begin
			insert into @tablaResultado
			select CUV, Descripcion, PrecioOferta, PrecioTachado, CodigoSap, OfertaUltimoMinuto, LimiteVenta
			from EstrategiaTemporal
			where 
				CampaniaId = @CampaniaID
				and Descripcion != ''
				and NumeroLote = @NumeroLote
		end
		else
		begin
			insert into @tablaResultado
			select CUV, Descripcion, PrecioOferta, PrecioTachado, CodigoSap, OfertaUltimoMinuto, LimiteVenta
			from EstrategiaTemporal
			where 
				CampaniaId = @CampaniaID
				and Descripcion = ''
				and NumeroLote = @NumeroLote
		end
	end

	select * from @tablaResultado
end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteEstrategiaTemporal]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.DeleteEstrategiaTemporal
GO

create procedure dbo.DeleteEstrategiaTemporal
@CampaniaID int
as
begin
	declare @NumeroLote int = 0
	select @NumeroLote = max(NumeroLote) from EstrategiaTemporal

	delete from EstrategiaTemporal
	where 
		CampaniaId = @CampaniaID
		and NumeroLote = @NumeroLote
end

go

create procedure dbo.InsertEstrategiaOfertaParaTi
@EstrategiaTemporal dbo.EstrategiaTemporalType readonly
as
begin

DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

declare @TipoEstrategiaID int = 0

select @TipoEstrategiaID = TipoEstrategiaID 
from TipoEstrategia 
where DescripcionEstrategia like '%'+ UPPER('OFERTA PARA TI')+'%'

insert into Estrategia
(TipoEstrategiaID,CampaniaID,CampaniaIDFin,NumeroPedido,Activo,ImagenURL,LimiteVenta,DescripcionCUV2,
FlagDescripcion,CUV,EtiquetaID,Precio,FlagCEP,CUV2,EtiquetaID2,Precio2,FlagCEP2,TextoLibre,FlagTextoLibre,
Cantidad,FlagCantidad,
Zona,
Limite,Orden,UsuarioCreacion,FechaCreacion,UsuarioModificacion,
FechaModificacion,ColorFondo,FlagEstrella)
select 
	@TipoEstrategiaID,CampaniaId,0,0,1,'',LimiteVenta,Descripcion,
	1,'',0,PrecioTachado,0,CUV,3,PrecioOferta,1,'',0,
	0,0,
	'57,81,134,13,14,15,16,29,30,31,56,58,72,73,91,95,115,130,11,12,26,33,53,54,76,87,93,94,7,8,22,25,45,88,89,109,110,112,122,124,9,43,44,50,83,85,111,123,125,10,38,39,51,70,86,103,119,71,84,106,107,121,23,24,27,28,41,42,46,52,90,105,113,114,120,129,18,32,47,61,74,75,131,2,17,59,60,62,67,77,78,92,96,101,102,116,118,132,34,49,64,97,3,20,21,36,37,48,63,66,69,79,82,117,5,6,65,80,68,100',
	NULL,0,UsuarioCreacion,@FechaGeneral,UsuarioCreacion,
	@FechaGeneral,'',OfertaUltimoMinuto
from @EstrategiaTemporal
end

go

USE BelcorpChile
go

IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'EstrategiaTemporal' AND TABLE_SCHEMA = 'dbo')
BEGIN
    DROP TABLE dbo.EstrategiaTemporal
END
GO
CREATE TABLE dbo.EstrategiaTemporal(
	EstrategiaTemporalId INT IDENTITY(1,1) PRIMARY KEY,
	CampaniaId int,
	CUV varchar(5),
	Descripcion varchar(100),
	PrecioOferta decimal(18,2),
	PrecioTachado decimal(18,2),
	CodigoSap varchar(20),
	OfertaUltimoMinuto int,
	LimiteVenta int,
	NumeroLote int,
	FechaCreacion datetime,
	UsuarioCreacion varchar(20)
)
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetCantidadOfertasParaTi]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetCantidadOfertasParaTi
GO

create procedure dbo.GetCantidadOfertasParaTi
@CampaniaID int,
@TipoConfigurado int
as
/*
exec GetCantidadOfertasParaTi 201618,0
exec GetCantidadOfertasParaTi 201618,1
exec GetCantidadOfertasParaTi 201618,2
*/
begin
	declare @resultado int = 0

	declare @tablaCuvsOPT table (CampaniaID int, CUV varchar(5))
	insert into @tablaCuvsOPT
	select distinct @CampaniaID, CUV from ods.OfertasPersonalizadas where AnioCampanaVenta = @CampaniaID and TipoPersonalizacion='OPT'

	if @TipoConfigurado=0
	begin
		set @resultado = (select count(*) from @tablaCuvsOPT)
	end
	else
	begin
		if @TipoConfigurado = 1
		begin
			set @resultado = (select count(*)
			from Estrategia e
			inner join @tablaCuvsOPT t on
				e.CampaniaID = t.CampaniaID
				and e.CUV2 = t.CUV
			where e.CampaniaID = @CampaniaID)
		end
		else
		begin
			set @resultado = (select count(*)
			from @tablaCuvsOPT t
			left join Estrategia e on
				t.CampaniaID = e.CampaniaID
				and t.CUV = e.CUV2
			where 
				t.CampaniaID = @CampaniaID
				and e.CUV2 is null)
		end
	end

	select @resultado	
end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetOfertasParaTiByTipoConfigurado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetOfertasParaTiByTipoConfigurado
GO

create procedure dbo.GetOfertasParaTiByTipoConfigurado
@CampaniaID int,
@TipoConfigurado int
as
/*
exec GetOfertasParaTiByTipoConfigurado 201618,0
exec GetOfertasParaTiByTipoConfigurado 201618,1
exec GetOfertasParaTiByTipoConfigurado 201618,2
*/
begin
	declare @tablaResultado table (
		CUV2 varchar(5), 
		DescripcionCUV2 varchar(100),
		Precio2 decimal(18,2),
		CodigoProducto varchar(20),
		OfertaUltimoMinuto int,
		LimiteVenta int
	)

	declare @tablaCuvsOPT table (CampaniaID int, CUV varchar(5), OfertaUltimoMinuto int, LimiteVenta int)
	insert into @tablaCuvsOPT
	select distinct @CampaniaID, CUV, isnull(FlagUltMinuto,0), isnull(LimUnidades,99)
	from ods.OfertasPersonalizadas where AnioCampanaVenta = @CampaniaID and TipoPersonalizacion='OPT'

	if @TipoConfigurado=0
	begin
		insert into @tablaResultado
		select 
			t.CUV,
			coalesce(e.DescripcionCUV2,pd.Descripcion,p.Descripcion),
			coalesce(e.Precio2,p.PrecioUnitario),
			p.CodigoProducto,
			t.OfertaUltimoMinuto,
			t.LimiteVenta
		from @tablaCuvsOPT t
		inner join ods.ProductoComercial p on
			t.CampaniaID = p.AnoCampania
			and t.CUV = p.CUV
		left join Estrategia e on
			t.CampaniaID = e.CampaniaID
			and t.CUV = e.CUV2
		left join dbo.ProductoDescripcion pd on
				p.AnoCampania = pd.CampaniaID
				and p.CUV = pd.CUV
		where 
			p.AnoCampania = @CampaniaID
		
		insert into @tablaResultado
		select
			CUV,'',0,'',0,0
		from @tablaCuvsOPT where CUV not in (
			select CUV from ods.ProductoComercial where AnoCampania = @CampaniaID
		)
	end
	else
	begin
		if @TipoConfigurado = 1
		begin
			insert into @tablaResultado
			select
				t.CUV,
				coalesce(e.DescripcionCUV2,pd.Descripcion,p.Descripcion),
				coalesce(e.Precio2,p.PrecioUnitario),
				p.CodigoProducto,
				t.OfertaUltimoMinuto,
				t.LimiteVenta
			from @tablaCuvsOPT t
			inner join ods.ProductoComercial p on
				t.CampaniaID = p.AnoCampania
				and t.CUV = p.CUV
			inner join Estrategia e on
				t.CampaniaID = e.CampaniaID
				and t.CUV = e.CUV2
			left join dbo.ProductoDescripcion pd on
				p.AnoCampania = pd.CampaniaID
				and p.CUV = pd.CUV
			where e.CampaniaID = @CampaniaID
		end
		else
		begin
			insert into @tablaResultado
			select
				t.CUV,
				coalesce(e.DescripcionCUV2,pd.Descripcion,p.Descripcion),
				coalesce(e.Precio2,p.PrecioUnitario),
				p.CodigoProducto,
				t.OfertaUltimoMinuto,
				t.LimiteVenta
			from @tablaCuvsOPT t
			inner join ods.ProductoComercial p on
				t.CampaniaID = p.AnoCampania
				and t.CUV = p.CUV
			left join Estrategia e on
				t.CampaniaID = e.CampaniaID
				and t.CUV = e.CUV2
			left join dbo.ProductoDescripcion pd on
				p.AnoCampania = pd.CampaniaID
				and p.CUV = pd.CUV
			where 
				t.CampaniaID = @CampaniaID
				and e.CUV2 is null

			insert into @tablaResultado
			select
				CUV,'',0,'',0,0
			from @tablaCuvsOPT where CUV not in (
				select CUV from ods.ProductoComercial where AnoCampania = @CampaniaID
			)
		end
	end

	select * from @tablaResultado
end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertEstrategiaOfertaParaTi]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.InsertEstrategiaOfertaParaTi
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertEstrategiaTemporal]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.InsertEstrategiaTemporal
GO

IF TYPE_ID('dbo.EstrategiaTemporalType') IS NOT NULL
	DROP TYPE dbo.EstrategiaTemporalType
GO

CREATE TYPE dbo.EstrategiaTemporalType AS TABLE(
	CampaniaId int,
	CUV varchar(5),
	Descripcion varchar(100),
	PrecioOferta decimal(18,2),
	PrecioTachado decimal(18,2),
	CodigoSap varchar(20),
	OfertaUltimoMinuto int,
	LimiteVenta int,
	UsuarioCreacion varchar(50)
)
GO

create procedure dbo.InsertEstrategiaTemporal
@EstrategiaTemporal dbo.EstrategiaTemporalType readonly
as
/*

*/
begin

DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

declare @NumeroLote int = 0
select @NumeroLote = isnull(max(NumeroLote),0) from EstrategiaTemporal

set @NumeroLote = @NumeroLote + 1

insert into EstrategiaTemporal 
(CampaniaId,CUV,Descripcion,PrecioOferta,PrecioTachado,CodigoSap,OfertaUltimoMinuto,LimiteVenta,NumeroLote,FechaCreacion,UsuarioCreacion)
select
CampaniaId,CUV,Descripcion,PrecioOferta,PrecioTachado,CodigoSap,OfertaUltimoMinuto,LimiteVenta,@NumeroLote,@FechaGeneral,UsuarioCreacion
from @EstrategiaTemporal

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetCantidadOfertasParaTiTemporal]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetCantidadOfertasParaTiTemporal
GO

create procedure dbo.GetCantidadOfertasParaTiTemporal
@CampaniaID int,
@TipoConfigurado int
as
/*
exec GetCantidadOfertasParaTiTemporal 201618,0
exec GetCantidadOfertasParaTiTemporal 201618,1
exec GetCantidadOfertasParaTiTemporal 201618,2
*/
begin
	declare @resultado int = 0

	declare @NumeroLote int = 0
	select @NumeroLote = max(NumeroLote) from EstrategiaTemporal

	if @TipoConfigurado = 0
	begin		
		select @resultado = count(*) from EstrategiaTemporal
		where 
			CampaniaId = @CampaniaID
			and NumeroLote = @NumeroLote
	end
	else
	begin
		if @TipoConfigurado = 1
		begin
			select @resultado = count(*) from EstrategiaTemporal
			where 
				CampaniaId = @CampaniaID
				and Descripcion != ''
				and NumeroLote = @NumeroLote
		end
		else
		begin
			select @resultado = count(*) from EstrategiaTemporal
			where 
				CampaniaId = @CampaniaID
				and Descripcion = ''
				and NumeroLote = @NumeroLote
		end
	end

	select @resultado
end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetOfertasParaTiByTipoConfiguradoTemporal]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetOfertasParaTiByTipoConfiguradoTemporal
GO

create procedure dbo.GetOfertasParaTiByTipoConfiguradoTemporal
@CampaniaID int,
@TipoConfigurado int
as
/*
exec GetOfertasParaTiByTipoConfiguradoTemporal 201618,0
exec GetOfertasParaTiByTipoConfiguradoTemporal 201618,1
exec GetOfertasParaTiByTipoConfiguradoTemporal 201618,2
*/
begin

	declare @tablaResultado table (
		CUV2 varchar(5), 
		DescripcionCUV2 varchar(100),
		Precio2 decimal(18,2),
		Precio decimal(18,2),
		CodigoProducto varchar(20),
		OfertaUltimoMinuto int,
		LimiteVenta int
	)

	declare @NumeroLote int = 0
	select @NumeroLote = max(NumeroLote) from EstrategiaTemporal

	if @TipoConfigurado = 0
	begin
		insert into @tablaResultado
		select CUV, Descripcion, PrecioOferta, PrecioTachado, CodigoSap, OfertaUltimoMinuto, LimiteVenta
		from EstrategiaTemporal
		where 
			CampaniaId = @CampaniaID
			and NumeroLote = @NumeroLote
	end
	else
	begin
		if @TipoConfigurado = 1
		begin
			insert into @tablaResultado
			select CUV, Descripcion, PrecioOferta, PrecioTachado, CodigoSap, OfertaUltimoMinuto, LimiteVenta
			from EstrategiaTemporal
			where 
				CampaniaId = @CampaniaID
				and Descripcion != ''
				and NumeroLote = @NumeroLote
		end
		else
		begin
			insert into @tablaResultado
			select CUV, Descripcion, PrecioOferta, PrecioTachado, CodigoSap, OfertaUltimoMinuto, LimiteVenta
			from EstrategiaTemporal
			where 
				CampaniaId = @CampaniaID
				and Descripcion = ''
				and NumeroLote = @NumeroLote
		end
	end

	select * from @tablaResultado
end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteEstrategiaTemporal]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.DeleteEstrategiaTemporal
GO

create procedure dbo.DeleteEstrategiaTemporal
@CampaniaID int
as
begin
	declare @NumeroLote int = 0
	select @NumeroLote = max(NumeroLote) from EstrategiaTemporal

	delete from EstrategiaTemporal
	where 
		CampaniaId = @CampaniaID
		and NumeroLote = @NumeroLote
end

go

create procedure dbo.InsertEstrategiaOfertaParaTi
@EstrategiaTemporal dbo.EstrategiaTemporalType readonly
as
begin

DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

declare @TipoEstrategiaID int = 0

select @TipoEstrategiaID = TipoEstrategiaID 
from TipoEstrategia 
where DescripcionEstrategia like '%'+ UPPER('OFERTA PARA TI')+'%'

insert into Estrategia
(TipoEstrategiaID,CampaniaID,CampaniaIDFin,NumeroPedido,Activo,ImagenURL,LimiteVenta,DescripcionCUV2,
FlagDescripcion,CUV,EtiquetaID,Precio,FlagCEP,CUV2,EtiquetaID2,Precio2,FlagCEP2,TextoLibre,FlagTextoLibre,
Cantidad,FlagCantidad,
Zona,
Limite,Orden,UsuarioCreacion,FechaCreacion,UsuarioModificacion,
FechaModificacion,ColorFondo,FlagEstrella)
select 
	@TipoEstrategiaID,CampaniaId,0,0,1,'',LimiteVenta,Descripcion,
	1,'',0,PrecioTachado,0,CUV,3,PrecioOferta,1,'',0,
	0,0,
	'12144,12176,12122,12142,12156,12157,12158,12167,12168,12169,12173,12174,12175,12189,12190,12206,12108,12109,12110,12119,12120,12121,12134,12141,12143,12155,12170,12171,12172,12191,12105,12106,12116,12124,12126,12138,12146,12163,12164,12179,12180,12182,12183,12199,12114,12115,12117,12125,12136,12137,12145,12147,12162,12181,12196,12197,12198,12210,12107,12118,12127,12133,12148,12149,12154,12165,12184,12185,12187,12200,12205,12128,12130,12131,12132,12150,12151,12152,12153,12166,12186,12202,12203,12204,12111,12112,12113,12129,12139,12140,12159,12160,12178,12192,12193,12194,12195,12201,12209,12177,12135,12161',
	NULL,0,UsuarioCreacion,@FechaGeneral,UsuarioCreacion,
	@FechaGeneral,'',OfertaUltimoMinuto
from @EstrategiaTemporal
end

go

USE BelcorpCostaRica
go

IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'EstrategiaTemporal' AND TABLE_SCHEMA = 'dbo')
BEGIN
    DROP TABLE dbo.EstrategiaTemporal
END
GO
CREATE TABLE dbo.EstrategiaTemporal(
	EstrategiaTemporalId INT IDENTITY(1,1) PRIMARY KEY,
	CampaniaId int,
	CUV varchar(5),
	Descripcion varchar(100),
	PrecioOferta decimal(18,2),
	PrecioTachado decimal(18,2),
	CodigoSap varchar(20),
	OfertaUltimoMinuto int,
	LimiteVenta int,
	NumeroLote int,
	FechaCreacion datetime,
	UsuarioCreacion varchar(20)
)
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetCantidadOfertasParaTi]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetCantidadOfertasParaTi
GO

create procedure dbo.GetCantidadOfertasParaTi
@CampaniaID int,
@TipoConfigurado int
as
/*
exec GetCantidadOfertasParaTi 201618,0
exec GetCantidadOfertasParaTi 201618,1
exec GetCantidadOfertasParaTi 201618,2
*/
begin
	declare @resultado int = 0

	declare @tablaCuvsOPT table (CampaniaID int, CUV varchar(5))
	insert into @tablaCuvsOPT
	select distinct @CampaniaID, CUV from ods.OfertasPersonalizadas where AnioCampanaVenta = @CampaniaID and TipoPersonalizacion='OPT'

	if @TipoConfigurado=0
	begin
		set @resultado = (select count(*) from @tablaCuvsOPT)
	end
	else
	begin
		if @TipoConfigurado = 1
		begin
			set @resultado = (select count(*)
			from Estrategia e
			inner join @tablaCuvsOPT t on
				e.CampaniaID = t.CampaniaID
				and e.CUV2 = t.CUV
			where e.CampaniaID = @CampaniaID)
		end
		else
		begin
			set @resultado = (select count(*)
			from @tablaCuvsOPT t
			left join Estrategia e on
				t.CampaniaID = e.CampaniaID
				and t.CUV = e.CUV2
			where 
				t.CampaniaID = @CampaniaID
				and e.CUV2 is null)
		end
	end

	select @resultado	
end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetOfertasParaTiByTipoConfigurado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetOfertasParaTiByTipoConfigurado
GO

create procedure dbo.GetOfertasParaTiByTipoConfigurado
@CampaniaID int,
@TipoConfigurado int
as
/*
exec GetOfertasParaTiByTipoConfigurado 201618,0
exec GetOfertasParaTiByTipoConfigurado 201618,1
exec GetOfertasParaTiByTipoConfigurado 201618,2
*/
begin
	declare @tablaResultado table (
		CUV2 varchar(5), 
		DescripcionCUV2 varchar(100),
		Precio2 decimal(18,2),
		CodigoProducto varchar(20),
		OfertaUltimoMinuto int,
		LimiteVenta int
	)

	declare @tablaCuvsOPT table (CampaniaID int, CUV varchar(5), OfertaUltimoMinuto int, LimiteVenta int)
	insert into @tablaCuvsOPT
	select distinct @CampaniaID, CUV, isnull(FlagUltMinuto,0), isnull(LimUnidades,99)
	from ods.OfertasPersonalizadas where AnioCampanaVenta = @CampaniaID and TipoPersonalizacion='OPT'

	if @TipoConfigurado=0
	begin
		insert into @tablaResultado
		select 
			t.CUV,
			coalesce(e.DescripcionCUV2,pd.Descripcion,p.Descripcion),
			coalesce(e.Precio2,p.PrecioUnitario),
			p.CodigoProducto,
			t.OfertaUltimoMinuto,
			t.LimiteVenta
		from @tablaCuvsOPT t
		inner join ods.ProductoComercial p on
			t.CampaniaID = p.AnoCampania
			and t.CUV = p.CUV
		left join Estrategia e on
			t.CampaniaID = e.CampaniaID
			and t.CUV = e.CUV2
		left join dbo.ProductoDescripcion pd on
				p.AnoCampania = pd.CampaniaID
				and p.CUV = pd.CUV
		where 
			p.AnoCampania = @CampaniaID
		
		insert into @tablaResultado
		select
			CUV,'',0,'',0,0
		from @tablaCuvsOPT where CUV not in (
			select CUV from ods.ProductoComercial where AnoCampania = @CampaniaID
		)
	end
	else
	begin
		if @TipoConfigurado = 1
		begin
			insert into @tablaResultado
			select
				t.CUV,
				coalesce(e.DescripcionCUV2,pd.Descripcion,p.Descripcion),
				coalesce(e.Precio2,p.PrecioUnitario),
				p.CodigoProducto,
				t.OfertaUltimoMinuto,
				t.LimiteVenta
			from @tablaCuvsOPT t
			inner join ods.ProductoComercial p on
				t.CampaniaID = p.AnoCampania
				and t.CUV = p.CUV
			inner join Estrategia e on
				t.CampaniaID = e.CampaniaID
				and t.CUV = e.CUV2
			left join dbo.ProductoDescripcion pd on
				p.AnoCampania = pd.CampaniaID
				and p.CUV = pd.CUV
			where e.CampaniaID = @CampaniaID
		end
		else
		begin
			insert into @tablaResultado
			select
				t.CUV,
				coalesce(e.DescripcionCUV2,pd.Descripcion,p.Descripcion),
				coalesce(e.Precio2,p.PrecioUnitario),
				p.CodigoProducto,
				t.OfertaUltimoMinuto,
				t.LimiteVenta
			from @tablaCuvsOPT t
			inner join ods.ProductoComercial p on
				t.CampaniaID = p.AnoCampania
				and t.CUV = p.CUV
			left join Estrategia e on
				t.CampaniaID = e.CampaniaID
				and t.CUV = e.CUV2
			left join dbo.ProductoDescripcion pd on
				p.AnoCampania = pd.CampaniaID
				and p.CUV = pd.CUV
			where 
				t.CampaniaID = @CampaniaID
				and e.CUV2 is null

			insert into @tablaResultado
			select
				CUV,'',0,'',0,0
			from @tablaCuvsOPT where CUV not in (
				select CUV from ods.ProductoComercial where AnoCampania = @CampaniaID
			)
		end
	end

	select * from @tablaResultado
end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertEstrategiaOfertaParaTi]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.InsertEstrategiaOfertaParaTi
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertEstrategiaTemporal]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.InsertEstrategiaTemporal
GO

IF TYPE_ID('dbo.EstrategiaTemporalType') IS NOT NULL
	DROP TYPE dbo.EstrategiaTemporalType
GO

CREATE TYPE dbo.EstrategiaTemporalType AS TABLE(
	CampaniaId int,
	CUV varchar(5),
	Descripcion varchar(100),
	PrecioOferta decimal(18,2),
	PrecioTachado decimal(18,2),
	CodigoSap varchar(20),
	OfertaUltimoMinuto int,
	LimiteVenta int,
	UsuarioCreacion varchar(50)
)
GO

create procedure dbo.InsertEstrategiaTemporal
@EstrategiaTemporal dbo.EstrategiaTemporalType readonly
as
/*

*/
begin

DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

declare @NumeroLote int = 0
select @NumeroLote = isnull(max(NumeroLote),0) from EstrategiaTemporal

set @NumeroLote = @NumeroLote + 1

insert into EstrategiaTemporal 
(CampaniaId,CUV,Descripcion,PrecioOferta,PrecioTachado,CodigoSap,OfertaUltimoMinuto,LimiteVenta,NumeroLote,FechaCreacion,UsuarioCreacion)
select
CampaniaId,CUV,Descripcion,PrecioOferta,PrecioTachado,CodigoSap,OfertaUltimoMinuto,LimiteVenta,@NumeroLote,@FechaGeneral,UsuarioCreacion
from @EstrategiaTemporal

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetCantidadOfertasParaTiTemporal]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetCantidadOfertasParaTiTemporal
GO

create procedure dbo.GetCantidadOfertasParaTiTemporal
@CampaniaID int,
@TipoConfigurado int
as
/*
exec GetCantidadOfertasParaTiTemporal 201618,0
exec GetCantidadOfertasParaTiTemporal 201618,1
exec GetCantidadOfertasParaTiTemporal 201618,2
*/
begin
	declare @resultado int = 0

	declare @NumeroLote int = 0
	select @NumeroLote = max(NumeroLote) from EstrategiaTemporal

	if @TipoConfigurado = 0
	begin		
		select @resultado = count(*) from EstrategiaTemporal
		where 
			CampaniaId = @CampaniaID
			and NumeroLote = @NumeroLote
	end
	else
	begin
		if @TipoConfigurado = 1
		begin
			select @resultado = count(*) from EstrategiaTemporal
			where 
				CampaniaId = @CampaniaID
				and Descripcion != ''
				and NumeroLote = @NumeroLote
		end
		else
		begin
			select @resultado = count(*) from EstrategiaTemporal
			where 
				CampaniaId = @CampaniaID
				and Descripcion = ''
				and NumeroLote = @NumeroLote
		end
	end

	select @resultado
end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetOfertasParaTiByTipoConfiguradoTemporal]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetOfertasParaTiByTipoConfiguradoTemporal
GO

create procedure dbo.GetOfertasParaTiByTipoConfiguradoTemporal
@CampaniaID int,
@TipoConfigurado int
as
/*
exec GetOfertasParaTiByTipoConfiguradoTemporal 201618,0
exec GetOfertasParaTiByTipoConfiguradoTemporal 201618,1
exec GetOfertasParaTiByTipoConfiguradoTemporal 201618,2
*/
begin

	declare @tablaResultado table (
		CUV2 varchar(5), 
		DescripcionCUV2 varchar(100),
		Precio2 decimal(18,2),
		Precio decimal(18,2),
		CodigoProducto varchar(20),
		OfertaUltimoMinuto int,
		LimiteVenta int
	)

	declare @NumeroLote int = 0
	select @NumeroLote = max(NumeroLote) from EstrategiaTemporal

	if @TipoConfigurado = 0
	begin
		insert into @tablaResultado
		select CUV, Descripcion, PrecioOferta, PrecioTachado, CodigoSap, OfertaUltimoMinuto, LimiteVenta
		from EstrategiaTemporal
		where 
			CampaniaId = @CampaniaID
			and NumeroLote = @NumeroLote
	end
	else
	begin
		if @TipoConfigurado = 1
		begin
			insert into @tablaResultado
			select CUV, Descripcion, PrecioOferta, PrecioTachado, CodigoSap, OfertaUltimoMinuto, LimiteVenta
			from EstrategiaTemporal
			where 
				CampaniaId = @CampaniaID
				and Descripcion != ''
				and NumeroLote = @NumeroLote
		end
		else
		begin
			insert into @tablaResultado
			select CUV, Descripcion, PrecioOferta, PrecioTachado, CodigoSap, OfertaUltimoMinuto, LimiteVenta
			from EstrategiaTemporal
			where 
				CampaniaId = @CampaniaID
				and Descripcion = ''
				and NumeroLote = @NumeroLote
		end
	end

	select * from @tablaResultado
end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteEstrategiaTemporal]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.DeleteEstrategiaTemporal
GO

create procedure dbo.DeleteEstrategiaTemporal
@CampaniaID int
as
begin
	declare @NumeroLote int = 0
	select @NumeroLote = max(NumeroLote) from EstrategiaTemporal

	delete from EstrategiaTemporal
	where 
		CampaniaId = @CampaniaID
		and NumeroLote = @NumeroLote
end

go

create procedure dbo.InsertEstrategiaOfertaParaTi
@EstrategiaTemporal dbo.EstrategiaTemporalType readonly
as
begin

DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

declare @TipoEstrategiaID int = 0

select @TipoEstrategiaID = TipoEstrategiaID 
from TipoEstrategia 
where DescripcionEstrategia like '%'+ UPPER('OFERTA PARA TI')+'%'

insert into Estrategia
(TipoEstrategiaID,CampaniaID,CampaniaIDFin,NumeroPedido,Activo,ImagenURL,LimiteVenta,DescripcionCUV2,
FlagDescripcion,CUV,EtiquetaID,Precio,FlagCEP,CUV2,EtiquetaID2,Precio2,FlagCEP2,TextoLibre,FlagTextoLibre,
Cantidad,FlagCantidad,
Zona,
Limite,Orden,UsuarioCreacion,FechaCreacion,UsuarioModificacion,
FechaModificacion,ColorFondo,FlagEstrella)
select 
	@TipoEstrategiaID,CampaniaId,0,0,1,'',LimiteVenta,Descripcion,
	1,'',0,PrecioTachado,0,CUV,3,PrecioOferta,1,'',0,
	0,0,
	'2053,2121,2101,2102,2103,2105,20003,20004,20005,20006,20007,20008,20009,20010,20055,20058,2106,2107,2109,2110,20011,20012,20013,20014,20016,20017,20054,20059,20060,2111,2112,2114,2115,20028,20029,20030,20031,20032,20033,20034,20035,20056,20061',
	NULL,0,UsuarioCreacion,@FechaGeneral,UsuarioCreacion,
	@FechaGeneral,'',OfertaUltimoMinuto
from @EstrategiaTemporal
end

go

USE BelcorpDominicana
go

IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'EstrategiaTemporal' AND TABLE_SCHEMA = 'dbo')
BEGIN
    DROP TABLE dbo.EstrategiaTemporal
END
GO
CREATE TABLE dbo.EstrategiaTemporal(
	EstrategiaTemporalId INT IDENTITY(1,1) PRIMARY KEY,
	CampaniaId int,
	CUV varchar(5),
	Descripcion varchar(100),
	PrecioOferta decimal(18,2),
	PrecioTachado decimal(18,2),
	CodigoSap varchar(20),
	OfertaUltimoMinuto int,
	LimiteVenta int,
	NumeroLote int,
	FechaCreacion datetime,
	UsuarioCreacion varchar(20)
)
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetCantidadOfertasParaTi]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetCantidadOfertasParaTi
GO

create procedure dbo.GetCantidadOfertasParaTi
@CampaniaID int,
@TipoConfigurado int
as
/*
exec GetCantidadOfertasParaTi 201618,0
exec GetCantidadOfertasParaTi 201618,1
exec GetCantidadOfertasParaTi 201618,2
*/
begin
	declare @resultado int = 0

	declare @tablaCuvsOPT table (CampaniaID int, CUV varchar(5))
	insert into @tablaCuvsOPT
	select distinct @CampaniaID, CUV from ods.OfertasPersonalizadas where AnioCampanaVenta = @CampaniaID and TipoPersonalizacion='OPT'

	if @TipoConfigurado=0
	begin
		set @resultado = (select count(*) from @tablaCuvsOPT)
	end
	else
	begin
		if @TipoConfigurado = 1
		begin
			set @resultado = (select count(*)
			from Estrategia e
			inner join @tablaCuvsOPT t on
				e.CampaniaID = t.CampaniaID
				and e.CUV2 = t.CUV
			where e.CampaniaID = @CampaniaID)
		end
		else
		begin
			set @resultado = (select count(*)
			from @tablaCuvsOPT t
			left join Estrategia e on
				t.CampaniaID = e.CampaniaID
				and t.CUV = e.CUV2
			where 
				t.CampaniaID = @CampaniaID
				and e.CUV2 is null)
		end
	end

	select @resultado	
end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetOfertasParaTiByTipoConfigurado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetOfertasParaTiByTipoConfigurado
GO

create procedure dbo.GetOfertasParaTiByTipoConfigurado
@CampaniaID int,
@TipoConfigurado int
as
/*
exec GetOfertasParaTiByTipoConfigurado 201618,0
exec GetOfertasParaTiByTipoConfigurado 201618,1
exec GetOfertasParaTiByTipoConfigurado 201618,2
*/
begin
	declare @tablaResultado table (
		CUV2 varchar(5), 
		DescripcionCUV2 varchar(100),
		Precio2 decimal(18,2),
		CodigoProducto varchar(20),
		OfertaUltimoMinuto int,
		LimiteVenta int
	)

	declare @tablaCuvsOPT table (CampaniaID int, CUV varchar(5), OfertaUltimoMinuto int, LimiteVenta int)
	insert into @tablaCuvsOPT
	select distinct @CampaniaID, CUV, isnull(FlagUltMinuto,0), isnull(LimUnidades,99)
	from ods.OfertasPersonalizadas where AnioCampanaVenta = @CampaniaID and TipoPersonalizacion='OPT'

	if @TipoConfigurado=0
	begin
		insert into @tablaResultado
		select 
			t.CUV,
			coalesce(e.DescripcionCUV2,pd.Descripcion,p.Descripcion),
			coalesce(e.Precio2,p.PrecioUnitario),
			p.CodigoProducto,
			t.OfertaUltimoMinuto,
			t.LimiteVenta
		from @tablaCuvsOPT t
		inner join ods.ProductoComercial p on
			t.CampaniaID = p.AnoCampania
			and t.CUV = p.CUV
		left join Estrategia e on
			t.CampaniaID = e.CampaniaID
			and t.CUV = e.CUV2
		left join dbo.ProductoDescripcion pd on
				p.AnoCampania = pd.CampaniaID
				and p.CUV = pd.CUV
		where 
			p.AnoCampania = @CampaniaID
		
		insert into @tablaResultado
		select
			CUV,'',0,'',0,0
		from @tablaCuvsOPT where CUV not in (
			select CUV from ods.ProductoComercial where AnoCampania = @CampaniaID
		)
	end
	else
	begin
		if @TipoConfigurado = 1
		begin
			insert into @tablaResultado
			select
				t.CUV,
				coalesce(e.DescripcionCUV2,pd.Descripcion,p.Descripcion),
				coalesce(e.Precio2,p.PrecioUnitario),
				p.CodigoProducto,
				t.OfertaUltimoMinuto,
				t.LimiteVenta
			from @tablaCuvsOPT t
			inner join ods.ProductoComercial p on
				t.CampaniaID = p.AnoCampania
				and t.CUV = p.CUV
			inner join Estrategia e on
				t.CampaniaID = e.CampaniaID
				and t.CUV = e.CUV2
			left join dbo.ProductoDescripcion pd on
				p.AnoCampania = pd.CampaniaID
				and p.CUV = pd.CUV
			where e.CampaniaID = @CampaniaID
		end
		else
		begin
			insert into @tablaResultado
			select
				t.CUV,
				coalesce(e.DescripcionCUV2,pd.Descripcion,p.Descripcion),
				coalesce(e.Precio2,p.PrecioUnitario),
				p.CodigoProducto,
				t.OfertaUltimoMinuto,
				t.LimiteVenta
			from @tablaCuvsOPT t
			inner join ods.ProductoComercial p on
				t.CampaniaID = p.AnoCampania
				and t.CUV = p.CUV
			left join Estrategia e on
				t.CampaniaID = e.CampaniaID
				and t.CUV = e.CUV2
			left join dbo.ProductoDescripcion pd on
				p.AnoCampania = pd.CampaniaID
				and p.CUV = pd.CUV
			where 
				t.CampaniaID = @CampaniaID
				and e.CUV2 is null

			insert into @tablaResultado
			select
				CUV,'',0,'',0,0
			from @tablaCuvsOPT where CUV not in (
				select CUV from ods.ProductoComercial where AnoCampania = @CampaniaID
			)
		end
	end

	select * from @tablaResultado
end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertEstrategiaOfertaParaTi]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.InsertEstrategiaOfertaParaTi
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertEstrategiaTemporal]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.InsertEstrategiaTemporal
GO

IF TYPE_ID('dbo.EstrategiaTemporalType') IS NOT NULL
	DROP TYPE dbo.EstrategiaTemporalType
GO

CREATE TYPE dbo.EstrategiaTemporalType AS TABLE(
	CampaniaId int,
	CUV varchar(5),
	Descripcion varchar(100),
	PrecioOferta decimal(18,2),
	PrecioTachado decimal(18,2),
	CodigoSap varchar(20),
	OfertaUltimoMinuto int,
	LimiteVenta int,
	UsuarioCreacion varchar(50)
)
GO

create procedure dbo.InsertEstrategiaTemporal
@EstrategiaTemporal dbo.EstrategiaTemporalType readonly
as
/*

*/
begin

DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

declare @NumeroLote int = 0
select @NumeroLote = isnull(max(NumeroLote),0) from EstrategiaTemporal

set @NumeroLote = @NumeroLote + 1

insert into EstrategiaTemporal 
(CampaniaId,CUV,Descripcion,PrecioOferta,PrecioTachado,CodigoSap,OfertaUltimoMinuto,LimiteVenta,NumeroLote,FechaCreacion,UsuarioCreacion)
select
CampaniaId,CUV,Descripcion,PrecioOferta,PrecioTachado,CodigoSap,OfertaUltimoMinuto,LimiteVenta,@NumeroLote,@FechaGeneral,UsuarioCreacion
from @EstrategiaTemporal

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetCantidadOfertasParaTiTemporal]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetCantidadOfertasParaTiTemporal
GO

create procedure dbo.GetCantidadOfertasParaTiTemporal
@CampaniaID int,
@TipoConfigurado int
as
/*
exec GetCantidadOfertasParaTiTemporal 201618,0
exec GetCantidadOfertasParaTiTemporal 201618,1
exec GetCantidadOfertasParaTiTemporal 201618,2
*/
begin
	declare @resultado int = 0

	declare @NumeroLote int = 0
	select @NumeroLote = max(NumeroLote) from EstrategiaTemporal

	if @TipoConfigurado = 0
	begin		
		select @resultado = count(*) from EstrategiaTemporal
		where 
			CampaniaId = @CampaniaID
			and NumeroLote = @NumeroLote
	end
	else
	begin
		if @TipoConfigurado = 1
		begin
			select @resultado = count(*) from EstrategiaTemporal
			where 
				CampaniaId = @CampaniaID
				and Descripcion != ''
				and NumeroLote = @NumeroLote
		end
		else
		begin
			select @resultado = count(*) from EstrategiaTemporal
			where 
				CampaniaId = @CampaniaID
				and Descripcion = ''
				and NumeroLote = @NumeroLote
		end
	end

	select @resultado
end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetOfertasParaTiByTipoConfiguradoTemporal]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetOfertasParaTiByTipoConfiguradoTemporal
GO

create procedure dbo.GetOfertasParaTiByTipoConfiguradoTemporal
@CampaniaID int,
@TipoConfigurado int
as
/*
exec GetOfertasParaTiByTipoConfiguradoTemporal 201618,0
exec GetOfertasParaTiByTipoConfiguradoTemporal 201618,1
exec GetOfertasParaTiByTipoConfiguradoTemporal 201618,2
*/
begin

	declare @tablaResultado table (
		CUV2 varchar(5), 
		DescripcionCUV2 varchar(100),
		Precio2 decimal(18,2),
		Precio decimal(18,2),
		CodigoProducto varchar(20),
		OfertaUltimoMinuto int,
		LimiteVenta int
	)

	declare @NumeroLote int = 0
	select @NumeroLote = max(NumeroLote) from EstrategiaTemporal

	if @TipoConfigurado = 0
	begin
		insert into @tablaResultado
		select CUV, Descripcion, PrecioOferta, PrecioTachado, CodigoSap, OfertaUltimoMinuto, LimiteVenta
		from EstrategiaTemporal
		where 
			CampaniaId = @CampaniaID
			and NumeroLote = @NumeroLote
	end
	else
	begin
		if @TipoConfigurado = 1
		begin
			insert into @tablaResultado
			select CUV, Descripcion, PrecioOferta, PrecioTachado, CodigoSap, OfertaUltimoMinuto, LimiteVenta
			from EstrategiaTemporal
			where 
				CampaniaId = @CampaniaID
				and Descripcion != ''
				and NumeroLote = @NumeroLote
		end
		else
		begin
			insert into @tablaResultado
			select CUV, Descripcion, PrecioOferta, PrecioTachado, CodigoSap, OfertaUltimoMinuto, LimiteVenta
			from EstrategiaTemporal
			where 
				CampaniaId = @CampaniaID
				and Descripcion = ''
				and NumeroLote = @NumeroLote
		end
	end

	select * from @tablaResultado
end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteEstrategiaTemporal]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.DeleteEstrategiaTemporal
GO

create procedure dbo.DeleteEstrategiaTemporal
@CampaniaID int
as
begin
	declare @NumeroLote int = 0
	select @NumeroLote = max(NumeroLote) from EstrategiaTemporal

	delete from EstrategiaTemporal
	where 
		CampaniaId = @CampaniaID
		and NumeroLote = @NumeroLote
end

go

create procedure dbo.InsertEstrategiaOfertaParaTi
@EstrategiaTemporal dbo.EstrategiaTemporalType readonly
as
begin

DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

declare @TipoEstrategiaID int = 0

select @TipoEstrategiaID = TipoEstrategiaID 
from TipoEstrategia 
where DescripcionEstrategia like '%'+ UPPER('OFERTA PARA TI')+'%'

insert into Estrategia
(TipoEstrategiaID,CampaniaID,CampaniaIDFin,NumeroPedido,Activo,ImagenURL,LimiteVenta,DescripcionCUV2,
FlagDescripcion,CUV,EtiquetaID,Precio,FlagCEP,CUV2,EtiquetaID2,Precio2,FlagCEP2,TextoLibre,FlagTextoLibre,
Cantidad,FlagCantidad,
Zona,
Limite,Orden,UsuarioCreacion,FechaCreacion,UsuarioModificacion,
FechaModificacion,ColorFondo,FlagEstrella)
select 
	@TipoEstrategiaID,CampaniaId,0,0,1,'',LimiteVenta,Descripcion,
	1,'',0,PrecioTachado,0,CUV,3,PrecioOferta,1,'',0,
	0,0,
	'14,16,3,4,7,29,30,43,57,58,63,64,77,78,80,82,83,84,87,5,12,20,21,22,25,36,45,46,48,49,50,51,54,71,72,85,86,2,9,10,15,17,18,26,31,32,33,39,42,55,61,68,69,6,13,23,24,27,37,47,52,53,56,62,66,74,75,76,79,81,88,59,60',
	NULL,0,UsuarioCreacion,@FechaGeneral,UsuarioCreacion,
	@FechaGeneral,'',OfertaUltimoMinuto
from @EstrategiaTemporal
end

go

USE BelcorpEcuador
go

IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'EstrategiaTemporal' AND TABLE_SCHEMA = 'dbo')
BEGIN
    DROP TABLE dbo.EstrategiaTemporal
END
GO
CREATE TABLE dbo.EstrategiaTemporal(
	EstrategiaTemporalId INT IDENTITY(1,1) PRIMARY KEY,
	CampaniaId int,
	CUV varchar(5),
	Descripcion varchar(100),
	PrecioOferta decimal(18,2),
	PrecioTachado decimal(18,2),
	CodigoSap varchar(20),
	OfertaUltimoMinuto int,
	LimiteVenta int,
	NumeroLote int,
	FechaCreacion datetime,
	UsuarioCreacion varchar(20)
)
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetCantidadOfertasParaTi]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetCantidadOfertasParaTi
GO

create procedure dbo.GetCantidadOfertasParaTi
@CampaniaID int,
@TipoConfigurado int
as
/*
exec GetCantidadOfertasParaTi 201618,0
exec GetCantidadOfertasParaTi 201618,1
exec GetCantidadOfertasParaTi 201618,2
*/
begin
	declare @resultado int = 0

	declare @tablaCuvsOPT table (CampaniaID int, CUV varchar(5))
	insert into @tablaCuvsOPT
	select distinct @CampaniaID, CUV from ods.OfertasPersonalizadas where AnioCampanaVenta = @CampaniaID and TipoPersonalizacion='OPT'

	if @TipoConfigurado=0
	begin
		set @resultado = (select count(*) from @tablaCuvsOPT)
	end
	else
	begin
		if @TipoConfigurado = 1
		begin
			set @resultado = (select count(*)
			from Estrategia e
			inner join @tablaCuvsOPT t on
				e.CampaniaID = t.CampaniaID
				and e.CUV2 = t.CUV
			where e.CampaniaID = @CampaniaID)
		end
		else
		begin
			set @resultado = (select count(*)
			from @tablaCuvsOPT t
			left join Estrategia e on
				t.CampaniaID = e.CampaniaID
				and t.CUV = e.CUV2
			where 
				t.CampaniaID = @CampaniaID
				and e.CUV2 is null)
		end
	end

	select @resultado	
end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetOfertasParaTiByTipoConfigurado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetOfertasParaTiByTipoConfigurado
GO

create procedure dbo.GetOfertasParaTiByTipoConfigurado
@CampaniaID int,
@TipoConfigurado int
as
/*
exec GetOfertasParaTiByTipoConfigurado 201618,0
exec GetOfertasParaTiByTipoConfigurado 201618,1
exec GetOfertasParaTiByTipoConfigurado 201618,2
*/
begin
	declare @tablaResultado table (
		CUV2 varchar(5), 
		DescripcionCUV2 varchar(100),
		Precio2 decimal(18,2),
		CodigoProducto varchar(20),
		OfertaUltimoMinuto int,
		LimiteVenta int
	)

	declare @tablaCuvsOPT table (CampaniaID int, CUV varchar(5), OfertaUltimoMinuto int, LimiteVenta int)
	insert into @tablaCuvsOPT
	select distinct @CampaniaID, CUV, isnull(FlagUltMinuto,0), isnull(LimUnidades,99)
	from ods.OfertasPersonalizadas where AnioCampanaVenta = @CampaniaID and TipoPersonalizacion='OPT'

	if @TipoConfigurado=0
	begin
		insert into @tablaResultado
		select 
			t.CUV,
			coalesce(e.DescripcionCUV2,pd.Descripcion,p.Descripcion),
			coalesce(e.Precio2,p.PrecioUnitario),
			p.CodigoProducto,
			t.OfertaUltimoMinuto,
			t.LimiteVenta
		from @tablaCuvsOPT t
		inner join ods.ProductoComercial p on
			t.CampaniaID = p.AnoCampania
			and t.CUV = p.CUV
		left join Estrategia e on
			t.CampaniaID = e.CampaniaID
			and t.CUV = e.CUV2
		left join dbo.ProductoDescripcion pd on
				p.AnoCampania = pd.CampaniaID
				and p.CUV = pd.CUV
		where 
			p.AnoCampania = @CampaniaID
		
		insert into @tablaResultado
		select
			CUV,'',0,'',0,0
		from @tablaCuvsOPT where CUV not in (
			select CUV from ods.ProductoComercial where AnoCampania = @CampaniaID
		)
	end
	else
	begin
		if @TipoConfigurado = 1
		begin
			insert into @tablaResultado
			select
				t.CUV,
				coalesce(e.DescripcionCUV2,pd.Descripcion,p.Descripcion),
				coalesce(e.Precio2,p.PrecioUnitario),
				p.CodigoProducto,
				t.OfertaUltimoMinuto,
				t.LimiteVenta
			from @tablaCuvsOPT t
			inner join ods.ProductoComercial p on
				t.CampaniaID = p.AnoCampania
				and t.CUV = p.CUV
			inner join Estrategia e on
				t.CampaniaID = e.CampaniaID
				and t.CUV = e.CUV2
			left join dbo.ProductoDescripcion pd on
				p.AnoCampania = pd.CampaniaID
				and p.CUV = pd.CUV
			where e.CampaniaID = @CampaniaID
		end
		else
		begin
			insert into @tablaResultado
			select
				t.CUV,
				coalesce(e.DescripcionCUV2,pd.Descripcion,p.Descripcion),
				coalesce(e.Precio2,p.PrecioUnitario),
				p.CodigoProducto,
				t.OfertaUltimoMinuto,
				t.LimiteVenta
			from @tablaCuvsOPT t
			inner join ods.ProductoComercial p on
				t.CampaniaID = p.AnoCampania
				and t.CUV = p.CUV
			left join Estrategia e on
				t.CampaniaID = e.CampaniaID
				and t.CUV = e.CUV2
			left join dbo.ProductoDescripcion pd on
				p.AnoCampania = pd.CampaniaID
				and p.CUV = pd.CUV
			where 
				t.CampaniaID = @CampaniaID
				and e.CUV2 is null

			insert into @tablaResultado
			select
				CUV,'',0,'',0,0
			from @tablaCuvsOPT where CUV not in (
				select CUV from ods.ProductoComercial where AnoCampania = @CampaniaID
			)
		end
	end

	select * from @tablaResultado
end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertEstrategiaOfertaParaTi]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.InsertEstrategiaOfertaParaTi
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertEstrategiaTemporal]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.InsertEstrategiaTemporal
GO

IF TYPE_ID('dbo.EstrategiaTemporalType') IS NOT NULL
	DROP TYPE dbo.EstrategiaTemporalType
GO

CREATE TYPE dbo.EstrategiaTemporalType AS TABLE(
	CampaniaId int,
	CUV varchar(5),
	Descripcion varchar(100),
	PrecioOferta decimal(18,2),
	PrecioTachado decimal(18,2),
	CodigoSap varchar(20),
	OfertaUltimoMinuto int,
	LimiteVenta int,
	UsuarioCreacion varchar(50)
)
GO

create procedure dbo.InsertEstrategiaTemporal
@EstrategiaTemporal dbo.EstrategiaTemporalType readonly
as
/*

*/
begin

DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

declare @NumeroLote int = 0
select @NumeroLote = isnull(max(NumeroLote),0) from EstrategiaTemporal

set @NumeroLote = @NumeroLote + 1

insert into EstrategiaTemporal 
(CampaniaId,CUV,Descripcion,PrecioOferta,PrecioTachado,CodigoSap,OfertaUltimoMinuto,LimiteVenta,NumeroLote,FechaCreacion,UsuarioCreacion)
select
CampaniaId,CUV,Descripcion,PrecioOferta,PrecioTachado,CodigoSap,OfertaUltimoMinuto,LimiteVenta,@NumeroLote,@FechaGeneral,UsuarioCreacion
from @EstrategiaTemporal

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetCantidadOfertasParaTiTemporal]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetCantidadOfertasParaTiTemporal
GO

create procedure dbo.GetCantidadOfertasParaTiTemporal
@CampaniaID int,
@TipoConfigurado int
as
/*
exec GetCantidadOfertasParaTiTemporal 201618,0
exec GetCantidadOfertasParaTiTemporal 201618,1
exec GetCantidadOfertasParaTiTemporal 201618,2
*/
begin
	declare @resultado int = 0

	declare @NumeroLote int = 0
	select @NumeroLote = max(NumeroLote) from EstrategiaTemporal

	if @TipoConfigurado = 0
	begin		
		select @resultado = count(*) from EstrategiaTemporal
		where 
			CampaniaId = @CampaniaID
			and NumeroLote = @NumeroLote
	end
	else
	begin
		if @TipoConfigurado = 1
		begin
			select @resultado = count(*) from EstrategiaTemporal
			where 
				CampaniaId = @CampaniaID
				and Descripcion != ''
				and NumeroLote = @NumeroLote
		end
		else
		begin
			select @resultado = count(*) from EstrategiaTemporal
			where 
				CampaniaId = @CampaniaID
				and Descripcion = ''
				and NumeroLote = @NumeroLote
		end
	end

	select @resultado
end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetOfertasParaTiByTipoConfiguradoTemporal]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetOfertasParaTiByTipoConfiguradoTemporal
GO

create procedure dbo.GetOfertasParaTiByTipoConfiguradoTemporal
@CampaniaID int,
@TipoConfigurado int
as
/*
exec GetOfertasParaTiByTipoConfiguradoTemporal 201618,0
exec GetOfertasParaTiByTipoConfiguradoTemporal 201618,1
exec GetOfertasParaTiByTipoConfiguradoTemporal 201618,2
*/
begin

	declare @tablaResultado table (
		CUV2 varchar(5), 
		DescripcionCUV2 varchar(100),
		Precio2 decimal(18,2),
		Precio decimal(18,2),
		CodigoProducto varchar(20),
		OfertaUltimoMinuto int,
		LimiteVenta int
	)

	declare @NumeroLote int = 0
	select @NumeroLote = max(NumeroLote) from EstrategiaTemporal

	if @TipoConfigurado = 0
	begin
		insert into @tablaResultado
		select CUV, Descripcion, PrecioOferta, PrecioTachado, CodigoSap, OfertaUltimoMinuto, LimiteVenta
		from EstrategiaTemporal
		where 
			CampaniaId = @CampaniaID
			and NumeroLote = @NumeroLote
	end
	else
	begin
		if @TipoConfigurado = 1
		begin
			insert into @tablaResultado
			select CUV, Descripcion, PrecioOferta, PrecioTachado, CodigoSap, OfertaUltimoMinuto, LimiteVenta
			from EstrategiaTemporal
			where 
				CampaniaId = @CampaniaID
				and Descripcion != ''
				and NumeroLote = @NumeroLote
		end
		else
		begin
			insert into @tablaResultado
			select CUV, Descripcion, PrecioOferta, PrecioTachado, CodigoSap, OfertaUltimoMinuto, LimiteVenta
			from EstrategiaTemporal
			where 
				CampaniaId = @CampaniaID
				and Descripcion = ''
				and NumeroLote = @NumeroLote
		end
	end

	select * from @tablaResultado
end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteEstrategiaTemporal]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.DeleteEstrategiaTemporal
GO

create procedure dbo.DeleteEstrategiaTemporal
@CampaniaID int
as
begin
	declare @NumeroLote int = 0
	select @NumeroLote = max(NumeroLote) from EstrategiaTemporal

	delete from EstrategiaTemporal
	where 
		CampaniaId = @CampaniaID
		and NumeroLote = @NumeroLote
end

go

create procedure dbo.InsertEstrategiaOfertaParaTi
@EstrategiaTemporal dbo.EstrategiaTemporalType readonly
as
begin

DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

declare @TipoEstrategiaID int = 0

select @TipoEstrategiaID = TipoEstrategiaID 
from TipoEstrategia 
where DescripcionEstrategia like '%'+ UPPER('OFERTA PARA TI')+'%'

insert into Estrategia
(TipoEstrategiaID,CampaniaID,CampaniaIDFin,NumeroPedido,Activo,ImagenURL,LimiteVenta,DescripcionCUV2,
FlagDescripcion,CUV,EtiquetaID,Precio,FlagCEP,CUV2,EtiquetaID2,Precio2,FlagCEP2,TextoLibre,FlagTextoLibre,
Cantidad,FlagCantidad,
Zona,
Limite,Orden,UsuarioCreacion,FechaCreacion,UsuarioModificacion,
FechaModificacion,ColorFondo,FlagEstrella)
select 
	@TipoEstrategiaID,CampaniaId,0,0,1,'',LimiteVenta,Descripcion,
	1,'',0,PrecioTachado,0,CUV,3,PrecioOferta,1,'',0,
	0,0,
	'2053,2094,2536,2357,2376,2390,2416,2443,2498,2501,2508,2515,2520,2521,2522,2525,2526,2528,2529,2531,2362,2363,2364,2378,2405,2446,2447,2458,2476,2523,2527,2532,2533,2534,2537,2381,2392,2417,2427,2428,2448,2460,2477,2483,2493,2496,2512,2382,2394,2407,2418,2430,2432,2491,2495,2497,2500,2503,2504,2513,2517,2519,2370,2383,2396,2397,2408,2409,2419,2420,2433,2434,2452,2475,2481,2524,2530,2535,2371,2372,2384,2385,2398,2410,2411,2421,2422,2423,2424,2435,2453,2462,2472,2478,2373,2374,2375,2386,2387,2412,2425,2436,2438,2439,2464,2465,2466,2482,2489,2388,2389,2399,2413,2414,2441,2442,2454,2455,2456,2467,2468,2469,2470,2471,2479',
	NULL,0,UsuarioCreacion,@FechaGeneral,UsuarioCreacion,
	@FechaGeneral,'',OfertaUltimoMinuto
from @EstrategiaTemporal
end

go

USE BelcorpGuatemala
go

IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'EstrategiaTemporal' AND TABLE_SCHEMA = 'dbo')
BEGIN
    DROP TABLE dbo.EstrategiaTemporal
END
GO
CREATE TABLE dbo.EstrategiaTemporal(
	EstrategiaTemporalId INT IDENTITY(1,1) PRIMARY KEY,
	CampaniaId int,
	CUV varchar(5),
	Descripcion varchar(100),
	PrecioOferta decimal(18,2),
	PrecioTachado decimal(18,2),
	CodigoSap varchar(20),
	OfertaUltimoMinuto int,
	LimiteVenta int,
	NumeroLote int,
	FechaCreacion datetime,
	UsuarioCreacion varchar(20)
)
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetCantidadOfertasParaTi]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetCantidadOfertasParaTi
GO

create procedure dbo.GetCantidadOfertasParaTi
@CampaniaID int,
@TipoConfigurado int
as
/*
exec GetCantidadOfertasParaTi 201618,0
exec GetCantidadOfertasParaTi 201618,1
exec GetCantidadOfertasParaTi 201618,2
*/
begin
	declare @resultado int = 0

	declare @tablaCuvsOPT table (CampaniaID int, CUV varchar(5))
	insert into @tablaCuvsOPT
	select distinct @CampaniaID, CUV from ods.OfertasPersonalizadas where AnioCampanaVenta = @CampaniaID and TipoPersonalizacion='OPT'

	if @TipoConfigurado=0
	begin
		set @resultado = (select count(*) from @tablaCuvsOPT)
	end
	else
	begin
		if @TipoConfigurado = 1
		begin
			set @resultado = (select count(*)
			from Estrategia e
			inner join @tablaCuvsOPT t on
				e.CampaniaID = t.CampaniaID
				and e.CUV2 = t.CUV
			where e.CampaniaID = @CampaniaID)
		end
		else
		begin
			set @resultado = (select count(*)
			from @tablaCuvsOPT t
			left join Estrategia e on
				t.CampaniaID = e.CampaniaID
				and t.CUV = e.CUV2
			where 
				t.CampaniaID = @CampaniaID
				and e.CUV2 is null)
		end
	end

	select @resultado	
end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetOfertasParaTiByTipoConfigurado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetOfertasParaTiByTipoConfigurado
GO

create procedure dbo.GetOfertasParaTiByTipoConfigurado
@CampaniaID int,
@TipoConfigurado int
as
/*
exec GetOfertasParaTiByTipoConfigurado 201618,0
exec GetOfertasParaTiByTipoConfigurado 201618,1
exec GetOfertasParaTiByTipoConfigurado 201618,2
*/
begin
	declare @tablaResultado table (
		CUV2 varchar(5), 
		DescripcionCUV2 varchar(100),
		Precio2 decimal(18,2),
		CodigoProducto varchar(20),
		OfertaUltimoMinuto int,
		LimiteVenta int
	)

	declare @tablaCuvsOPT table (CampaniaID int, CUV varchar(5), OfertaUltimoMinuto int, LimiteVenta int)
	insert into @tablaCuvsOPT
	select distinct @CampaniaID, CUV, isnull(FlagUltMinuto,0), isnull(LimUnidades,99)
	from ods.OfertasPersonalizadas where AnioCampanaVenta = @CampaniaID and TipoPersonalizacion='OPT'

	if @TipoConfigurado=0
	begin
		insert into @tablaResultado
		select 
			t.CUV,
			coalesce(e.DescripcionCUV2,pd.Descripcion,p.Descripcion),
			coalesce(e.Precio2,p.PrecioUnitario),
			p.CodigoProducto,
			t.OfertaUltimoMinuto,
			t.LimiteVenta
		from @tablaCuvsOPT t
		inner join ods.ProductoComercial p on
			t.CampaniaID = p.AnoCampania
			and t.CUV = p.CUV
		left join Estrategia e on
			t.CampaniaID = e.CampaniaID
			and t.CUV = e.CUV2
		left join dbo.ProductoDescripcion pd on
				p.AnoCampania = pd.CampaniaID
				and p.CUV = pd.CUV
		where 
			p.AnoCampania = @CampaniaID
		
		insert into @tablaResultado
		select
			CUV,'',0,'',0,0
		from @tablaCuvsOPT where CUV not in (
			select CUV from ods.ProductoComercial where AnoCampania = @CampaniaID
		)
	end
	else
	begin
		if @TipoConfigurado = 1
		begin
			insert into @tablaResultado
			select
				t.CUV,
				coalesce(e.DescripcionCUV2,pd.Descripcion,p.Descripcion),
				coalesce(e.Precio2,p.PrecioUnitario),
				p.CodigoProducto,
				t.OfertaUltimoMinuto,
				t.LimiteVenta
			from @tablaCuvsOPT t
			inner join ods.ProductoComercial p on
				t.CampaniaID = p.AnoCampania
				and t.CUV = p.CUV
			inner join Estrategia e on
				t.CampaniaID = e.CampaniaID
				and t.CUV = e.CUV2
			left join dbo.ProductoDescripcion pd on
				p.AnoCampania = pd.CampaniaID
				and p.CUV = pd.CUV
			where e.CampaniaID = @CampaniaID
		end
		else
		begin
			insert into @tablaResultado
			select
				t.CUV,
				coalesce(e.DescripcionCUV2,pd.Descripcion,p.Descripcion),
				coalesce(e.Precio2,p.PrecioUnitario),
				p.CodigoProducto,
				t.OfertaUltimoMinuto,
				t.LimiteVenta
			from @tablaCuvsOPT t
			inner join ods.ProductoComercial p on
				t.CampaniaID = p.AnoCampania
				and t.CUV = p.CUV
			left join Estrategia e on
				t.CampaniaID = e.CampaniaID
				and t.CUV = e.CUV2
			left join dbo.ProductoDescripcion pd on
				p.AnoCampania = pd.CampaniaID
				and p.CUV = pd.CUV
			where 
				t.CampaniaID = @CampaniaID
				and e.CUV2 is null

			insert into @tablaResultado
			select
				CUV,'',0,'',0,0
			from @tablaCuvsOPT where CUV not in (
				select CUV from ods.ProductoComercial where AnoCampania = @CampaniaID
			)
		end
	end

	select * from @tablaResultado
end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertEstrategiaOfertaParaTi]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.InsertEstrategiaOfertaParaTi
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertEstrategiaTemporal]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.InsertEstrategiaTemporal
GO

IF TYPE_ID('dbo.EstrategiaTemporalType') IS NOT NULL
	DROP TYPE dbo.EstrategiaTemporalType
GO

CREATE TYPE dbo.EstrategiaTemporalType AS TABLE(
	CampaniaId int,
	CUV varchar(5),
	Descripcion varchar(100),
	PrecioOferta decimal(18,2),
	PrecioTachado decimal(18,2),
	CodigoSap varchar(20),
	OfertaUltimoMinuto int,
	LimiteVenta int,
	UsuarioCreacion varchar(50)
)
GO

create procedure dbo.InsertEstrategiaTemporal
@EstrategiaTemporal dbo.EstrategiaTemporalType readonly
as
/*

*/
begin

DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

declare @NumeroLote int = 0
select @NumeroLote = isnull(max(NumeroLote),0) from EstrategiaTemporal

set @NumeroLote = @NumeroLote + 1

insert into EstrategiaTemporal 
(CampaniaId,CUV,Descripcion,PrecioOferta,PrecioTachado,CodigoSap,OfertaUltimoMinuto,LimiteVenta,NumeroLote,FechaCreacion,UsuarioCreacion)
select
CampaniaId,CUV,Descripcion,PrecioOferta,PrecioTachado,CodigoSap,OfertaUltimoMinuto,LimiteVenta,@NumeroLote,@FechaGeneral,UsuarioCreacion
from @EstrategiaTemporal

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetCantidadOfertasParaTiTemporal]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetCantidadOfertasParaTiTemporal
GO

create procedure dbo.GetCantidadOfertasParaTiTemporal
@CampaniaID int,
@TipoConfigurado int
as
/*
exec GetCantidadOfertasParaTiTemporal 201618,0
exec GetCantidadOfertasParaTiTemporal 201618,1
exec GetCantidadOfertasParaTiTemporal 201618,2
*/
begin
	declare @resultado int = 0

	declare @NumeroLote int = 0
	select @NumeroLote = max(NumeroLote) from EstrategiaTemporal

	if @TipoConfigurado = 0
	begin		
		select @resultado = count(*) from EstrategiaTemporal
		where 
			CampaniaId = @CampaniaID
			and NumeroLote = @NumeroLote
	end
	else
	begin
		if @TipoConfigurado = 1
		begin
			select @resultado = count(*) from EstrategiaTemporal
			where 
				CampaniaId = @CampaniaID
				and Descripcion != ''
				and NumeroLote = @NumeroLote
		end
		else
		begin
			select @resultado = count(*) from EstrategiaTemporal
			where 
				CampaniaId = @CampaniaID
				and Descripcion = ''
				and NumeroLote = @NumeroLote
		end
	end

	select @resultado
end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetOfertasParaTiByTipoConfiguradoTemporal]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetOfertasParaTiByTipoConfiguradoTemporal
GO

create procedure dbo.GetOfertasParaTiByTipoConfiguradoTemporal
@CampaniaID int,
@TipoConfigurado int
as
/*
exec GetOfertasParaTiByTipoConfiguradoTemporal 201618,0
exec GetOfertasParaTiByTipoConfiguradoTemporal 201618,1
exec GetOfertasParaTiByTipoConfiguradoTemporal 201618,2
*/
begin

	declare @tablaResultado table (
		CUV2 varchar(5), 
		DescripcionCUV2 varchar(100),
		Precio2 decimal(18,2),
		Precio decimal(18,2),
		CodigoProducto varchar(20),
		OfertaUltimoMinuto int,
		LimiteVenta int
	)

	declare @NumeroLote int = 0
	select @NumeroLote = max(NumeroLote) from EstrategiaTemporal

	if @TipoConfigurado = 0
	begin
		insert into @tablaResultado
		select CUV, Descripcion, PrecioOferta, PrecioTachado, CodigoSap, OfertaUltimoMinuto, LimiteVenta
		from EstrategiaTemporal
		where 
			CampaniaId = @CampaniaID
			and NumeroLote = @NumeroLote
	end
	else
	begin
		if @TipoConfigurado = 1
		begin
			insert into @tablaResultado
			select CUV, Descripcion, PrecioOferta, PrecioTachado, CodigoSap, OfertaUltimoMinuto, LimiteVenta
			from EstrategiaTemporal
			where 
				CampaniaId = @CampaniaID
				and Descripcion != ''
				and NumeroLote = @NumeroLote
		end
		else
		begin
			insert into @tablaResultado
			select CUV, Descripcion, PrecioOferta, PrecioTachado, CodigoSap, OfertaUltimoMinuto, LimiteVenta
			from EstrategiaTemporal
			where 
				CampaniaId = @CampaniaID
				and Descripcion = ''
				and NumeroLote = @NumeroLote
		end
	end

	select * from @tablaResultado
end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteEstrategiaTemporal]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.DeleteEstrategiaTemporal
GO

create procedure dbo.DeleteEstrategiaTemporal
@CampaniaID int
as
begin
	declare @NumeroLote int = 0
	select @NumeroLote = max(NumeroLote) from EstrategiaTemporal

	delete from EstrategiaTemporal
	where 
		CampaniaId = @CampaniaID
		and NumeroLote = @NumeroLote
end

go

create procedure dbo.InsertEstrategiaOfertaParaTi
@EstrategiaTemporal dbo.EstrategiaTemporalType readonly
as
begin

DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

declare @TipoEstrategiaID int = 0

select @TipoEstrategiaID = TipoEstrategiaID 
from TipoEstrategia 
where DescripcionEstrategia like '%'+ UPPER('OFERTA PARA TI')+'%'

insert into Estrategia
(TipoEstrategiaID,CampaniaID,CampaniaIDFin,NumeroPedido,Activo,ImagenURL,LimiteVenta,DescripcionCUV2,
FlagDescripcion,CUV,EtiquetaID,Precio,FlagCEP,CUV2,EtiquetaID2,Precio2,FlagCEP2,TextoLibre,FlagTextoLibre,
Cantidad,FlagCantidad,
Zona,
Limite,Orden,UsuarioCreacion,FechaCreacion,UsuarioModificacion,
FechaModificacion,ColorFondo,FlagEstrella)
select 
	@TipoEstrategiaID,CampaniaId,0,0,1,'',LimiteVenta,Descripcion,
	1,'',0,PrecioTachado,0,CUV,3,PrecioOferta,1,'',0,
	0,0,
	'20616,20654,20590,20593,20594,20609,20610,20615,20625,20641,20650,20651,20652,20653,20659,20598,20599,20600,20601,20602,20619,20622,20633,20635,20638,20647,20648,20656,20603,20604,20612,20623,20624,20630,20631,20645,20657,20666,20667,20670,20596,20611,20617,20626,20627,20628,20642,20643,20644,20649,20663,20664,20668,20597,20618,20591,20606,20607,20608,20620,20621,20634,20636,20639,20640,20660,20661,20662,20655',
	NULL,0,UsuarioCreacion,@FechaGeneral,UsuarioCreacion,
	@FechaGeneral,'',OfertaUltimoMinuto
from @EstrategiaTemporal
end

go

USE BelcorpPanama
go

IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'EstrategiaTemporal' AND TABLE_SCHEMA = 'dbo')
BEGIN
    DROP TABLE dbo.EstrategiaTemporal
END
GO
CREATE TABLE dbo.EstrategiaTemporal(
	EstrategiaTemporalId INT IDENTITY(1,1) PRIMARY KEY,
	CampaniaId int,
	CUV varchar(5),
	Descripcion varchar(100),
	PrecioOferta decimal(18,2),
	PrecioTachado decimal(18,2),
	CodigoSap varchar(20),
	OfertaUltimoMinuto int,
	LimiteVenta int,
	NumeroLote int,
	FechaCreacion datetime,
	UsuarioCreacion varchar(20)
)
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetCantidadOfertasParaTi]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetCantidadOfertasParaTi
GO

create procedure dbo.GetCantidadOfertasParaTi
@CampaniaID int,
@TipoConfigurado int
as
/*
exec GetCantidadOfertasParaTi 201618,0
exec GetCantidadOfertasParaTi 201618,1
exec GetCantidadOfertasParaTi 201618,2
*/
begin
	declare @resultado int = 0

	declare @tablaCuvsOPT table (CampaniaID int, CUV varchar(5))
	insert into @tablaCuvsOPT
	select distinct @CampaniaID, CUV from ods.OfertasPersonalizadas where AnioCampanaVenta = @CampaniaID and TipoPersonalizacion='OPT'

	if @TipoConfigurado=0
	begin
		set @resultado = (select count(*) from @tablaCuvsOPT)
	end
	else
	begin
		if @TipoConfigurado = 1
		begin
			set @resultado = (select count(*)
			from Estrategia e
			inner join @tablaCuvsOPT t on
				e.CampaniaID = t.CampaniaID
				and e.CUV2 = t.CUV
			where e.CampaniaID = @CampaniaID)
		end
		else
		begin
			set @resultado = (select count(*)
			from @tablaCuvsOPT t
			left join Estrategia e on
				t.CampaniaID = e.CampaniaID
				and t.CUV = e.CUV2
			where 
				t.CampaniaID = @CampaniaID
				and e.CUV2 is null)
		end
	end

	select @resultado	
end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetOfertasParaTiByTipoConfigurado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetOfertasParaTiByTipoConfigurado
GO

create procedure dbo.GetOfertasParaTiByTipoConfigurado
@CampaniaID int,
@TipoConfigurado int
as
/*
exec GetOfertasParaTiByTipoConfigurado 201618,0
exec GetOfertasParaTiByTipoConfigurado 201618,1
exec GetOfertasParaTiByTipoConfigurado 201618,2
*/
begin
	declare @tablaResultado table (
		CUV2 varchar(5), 
		DescripcionCUV2 varchar(100),
		Precio2 decimal(18,2),
		CodigoProducto varchar(20),
		OfertaUltimoMinuto int,
		LimiteVenta int
	)

	declare @tablaCuvsOPT table (CampaniaID int, CUV varchar(5), OfertaUltimoMinuto int, LimiteVenta int)
	insert into @tablaCuvsOPT
	select distinct @CampaniaID, CUV, isnull(FlagUltMinuto,0), isnull(LimUnidades,99)
	from ods.OfertasPersonalizadas where AnioCampanaVenta = @CampaniaID and TipoPersonalizacion='OPT'

	if @TipoConfigurado=0
	begin
		insert into @tablaResultado
		select 
			t.CUV,
			coalesce(e.DescripcionCUV2,pd.Descripcion,p.Descripcion),
			coalesce(e.Precio2,p.PrecioUnitario),
			p.CodigoProducto,
			t.OfertaUltimoMinuto,
			t.LimiteVenta
		from @tablaCuvsOPT t
		inner join ods.ProductoComercial p on
			t.CampaniaID = p.AnoCampania
			and t.CUV = p.CUV
		left join Estrategia e on
			t.CampaniaID = e.CampaniaID
			and t.CUV = e.CUV2
		left join dbo.ProductoDescripcion pd on
				p.AnoCampania = pd.CampaniaID
				and p.CUV = pd.CUV
		where 
			p.AnoCampania = @CampaniaID
		
		insert into @tablaResultado
		select
			CUV,'',0,'',0,0
		from @tablaCuvsOPT where CUV not in (
			select CUV from ods.ProductoComercial where AnoCampania = @CampaniaID
		)
	end
	else
	begin
		if @TipoConfigurado = 1
		begin
			insert into @tablaResultado
			select
				t.CUV,
				coalesce(e.DescripcionCUV2,pd.Descripcion,p.Descripcion),
				coalesce(e.Precio2,p.PrecioUnitario),
				p.CodigoProducto,
				t.OfertaUltimoMinuto,
				t.LimiteVenta
			from @tablaCuvsOPT t
			inner join ods.ProductoComercial p on
				t.CampaniaID = p.AnoCampania
				and t.CUV = p.CUV
			inner join Estrategia e on
				t.CampaniaID = e.CampaniaID
				and t.CUV = e.CUV2
			left join dbo.ProductoDescripcion pd on
				p.AnoCampania = pd.CampaniaID
				and p.CUV = pd.CUV
			where e.CampaniaID = @CampaniaID
		end
		else
		begin
			insert into @tablaResultado
			select
				t.CUV,
				coalesce(e.DescripcionCUV2,pd.Descripcion,p.Descripcion),
				coalesce(e.Precio2,p.PrecioUnitario),
				p.CodigoProducto,
				t.OfertaUltimoMinuto,
				t.LimiteVenta
			from @tablaCuvsOPT t
			inner join ods.ProductoComercial p on
				t.CampaniaID = p.AnoCampania
				and t.CUV = p.CUV
			left join Estrategia e on
				t.CampaniaID = e.CampaniaID
				and t.CUV = e.CUV2
			left join dbo.ProductoDescripcion pd on
				p.AnoCampania = pd.CampaniaID
				and p.CUV = pd.CUV
			where 
				t.CampaniaID = @CampaniaID
				and e.CUV2 is null

			insert into @tablaResultado
			select
				CUV,'',0,'',0,0
			from @tablaCuvsOPT where CUV not in (
				select CUV from ods.ProductoComercial where AnoCampania = @CampaniaID
			)
		end
	end

	select * from @tablaResultado
end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertEstrategiaOfertaParaTi]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.InsertEstrategiaOfertaParaTi
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertEstrategiaTemporal]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.InsertEstrategiaTemporal
GO

IF TYPE_ID('dbo.EstrategiaTemporalType') IS NOT NULL
	DROP TYPE dbo.EstrategiaTemporalType
GO

CREATE TYPE dbo.EstrategiaTemporalType AS TABLE(
	CampaniaId int,
	CUV varchar(5),
	Descripcion varchar(100),
	PrecioOferta decimal(18,2),
	PrecioTachado decimal(18,2),
	CodigoSap varchar(20),
	OfertaUltimoMinuto int,
	LimiteVenta int,
	UsuarioCreacion varchar(50)
)
GO

create procedure dbo.InsertEstrategiaTemporal
@EstrategiaTemporal dbo.EstrategiaTemporalType readonly
as
/*

*/
begin

DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

declare @NumeroLote int = 0
select @NumeroLote = isnull(max(NumeroLote),0) from EstrategiaTemporal

set @NumeroLote = @NumeroLote + 1

insert into EstrategiaTemporal 
(CampaniaId,CUV,Descripcion,PrecioOferta,PrecioTachado,CodigoSap,OfertaUltimoMinuto,LimiteVenta,NumeroLote,FechaCreacion,UsuarioCreacion)
select
CampaniaId,CUV,Descripcion,PrecioOferta,PrecioTachado,CodigoSap,OfertaUltimoMinuto,LimiteVenta,@NumeroLote,@FechaGeneral,UsuarioCreacion
from @EstrategiaTemporal

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetCantidadOfertasParaTiTemporal]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetCantidadOfertasParaTiTemporal
GO

create procedure dbo.GetCantidadOfertasParaTiTemporal
@CampaniaID int,
@TipoConfigurado int
as
/*
exec GetCantidadOfertasParaTiTemporal 201618,0
exec GetCantidadOfertasParaTiTemporal 201618,1
exec GetCantidadOfertasParaTiTemporal 201618,2
*/
begin
	declare @resultado int = 0

	declare @NumeroLote int = 0
	select @NumeroLote = max(NumeroLote) from EstrategiaTemporal

	if @TipoConfigurado = 0
	begin		
		select @resultado = count(*) from EstrategiaTemporal
		where 
			CampaniaId = @CampaniaID
			and NumeroLote = @NumeroLote
	end
	else
	begin
		if @TipoConfigurado = 1
		begin
			select @resultado = count(*) from EstrategiaTemporal
			where 
				CampaniaId = @CampaniaID
				and Descripcion != ''
				and NumeroLote = @NumeroLote
		end
		else
		begin
			select @resultado = count(*) from EstrategiaTemporal
			where 
				CampaniaId = @CampaniaID
				and Descripcion = ''
				and NumeroLote = @NumeroLote
		end
	end

	select @resultado
end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetOfertasParaTiByTipoConfiguradoTemporal]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetOfertasParaTiByTipoConfiguradoTemporal
GO

create procedure dbo.GetOfertasParaTiByTipoConfiguradoTemporal
@CampaniaID int,
@TipoConfigurado int
as
/*
exec GetOfertasParaTiByTipoConfiguradoTemporal 201618,0
exec GetOfertasParaTiByTipoConfiguradoTemporal 201618,1
exec GetOfertasParaTiByTipoConfiguradoTemporal 201618,2
*/
begin

	declare @tablaResultado table (
		CUV2 varchar(5), 
		DescripcionCUV2 varchar(100),
		Precio2 decimal(18,2),
		Precio decimal(18,2),
		CodigoProducto varchar(20),
		OfertaUltimoMinuto int,
		LimiteVenta int
	)

	declare @NumeroLote int = 0
	select @NumeroLote = max(NumeroLote) from EstrategiaTemporal

	if @TipoConfigurado = 0
	begin
		insert into @tablaResultado
		select CUV, Descripcion, PrecioOferta, PrecioTachado, CodigoSap, OfertaUltimoMinuto, LimiteVenta
		from EstrategiaTemporal
		where 
			CampaniaId = @CampaniaID
			and NumeroLote = @NumeroLote
	end
	else
	begin
		if @TipoConfigurado = 1
		begin
			insert into @tablaResultado
			select CUV, Descripcion, PrecioOferta, PrecioTachado, CodigoSap, OfertaUltimoMinuto, LimiteVenta
			from EstrategiaTemporal
			where 
				CampaniaId = @CampaniaID
				and Descripcion != ''
				and NumeroLote = @NumeroLote
		end
		else
		begin
			insert into @tablaResultado
			select CUV, Descripcion, PrecioOferta, PrecioTachado, CodigoSap, OfertaUltimoMinuto, LimiteVenta
			from EstrategiaTemporal
			where 
				CampaniaId = @CampaniaID
				and Descripcion = ''
				and NumeroLote = @NumeroLote
		end
	end

	select * from @tablaResultado
end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteEstrategiaTemporal]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.DeleteEstrategiaTemporal
GO

create procedure dbo.DeleteEstrategiaTemporal
@CampaniaID int
as
begin
	declare @NumeroLote int = 0
	select @NumeroLote = max(NumeroLote) from EstrategiaTemporal

	delete from EstrategiaTemporal
	where 
		CampaniaId = @CampaniaID
		and NumeroLote = @NumeroLote
end

go

create procedure dbo.InsertEstrategiaOfertaParaTi
@EstrategiaTemporal dbo.EstrategiaTemporalType readonly
as
begin

DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

declare @TipoEstrategiaID int = 0

select @TipoEstrategiaID = TipoEstrategiaID 
from TipoEstrategia 
where DescripcionEstrategia like '%'+ UPPER('OFERTA PARA TI')+'%'

insert into Estrategia
(TipoEstrategiaID,CampaniaID,CampaniaIDFin,NumeroPedido,Activo,ImagenURL,LimiteVenta,DescripcionCUV2,
FlagDescripcion,CUV,EtiquetaID,Precio,FlagCEP,CUV2,EtiquetaID2,Precio2,FlagCEP2,TextoLibre,FlagTextoLibre,
Cantidad,FlagCantidad,
Zona,
Limite,Orden,UsuarioCreacion,FechaCreacion,UsuarioModificacion,
FechaModificacion,ColorFondo,FlagEstrella)
select 
	@TipoEstrategiaID,CampaniaId,0,0,1,'',LimiteVenta,Descripcion,
	1,'',0,PrecioTachado,0,CUV,3,PrecioOferta,1,'',0,
	0,0,
	'2493,2494,2535,2536,2541,2542,2543,2544,2545,2548,2551,2554,2555,2556,2557,2558,2559,2560,2561',
	NULL,0,UsuarioCreacion,@FechaGeneral,UsuarioCreacion,
	@FechaGeneral,'',OfertaUltimoMinuto
from @EstrategiaTemporal
end

go

USE BelcorpPuertoRico
go

IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'EstrategiaTemporal' AND TABLE_SCHEMA = 'dbo')
BEGIN
    DROP TABLE dbo.EstrategiaTemporal
END
GO
CREATE TABLE dbo.EstrategiaTemporal(
	EstrategiaTemporalId INT IDENTITY(1,1) PRIMARY KEY,
	CampaniaId int,
	CUV varchar(5),
	Descripcion varchar(100),
	PrecioOferta decimal(18,2),
	PrecioTachado decimal(18,2),
	CodigoSap varchar(20),
	OfertaUltimoMinuto int,
	LimiteVenta int,
	NumeroLote int,
	FechaCreacion datetime,
	UsuarioCreacion varchar(20)
)
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetCantidadOfertasParaTi]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetCantidadOfertasParaTi
GO

create procedure dbo.GetCantidadOfertasParaTi
@CampaniaID int,
@TipoConfigurado int
as
/*
exec GetCantidadOfertasParaTi 201618,0
exec GetCantidadOfertasParaTi 201618,1
exec GetCantidadOfertasParaTi 201618,2
*/
begin
	declare @resultado int = 0

	declare @tablaCuvsOPT table (CampaniaID int, CUV varchar(5))
	insert into @tablaCuvsOPT
	select distinct @CampaniaID, CUV from ods.OfertasPersonalizadas where AnioCampanaVenta = @CampaniaID and TipoPersonalizacion='OPT'

	if @TipoConfigurado=0
	begin
		set @resultado = (select count(*) from @tablaCuvsOPT)
	end
	else
	begin
		if @TipoConfigurado = 1
		begin
			set @resultado = (select count(*)
			from Estrategia e
			inner join @tablaCuvsOPT t on
				e.CampaniaID = t.CampaniaID
				and e.CUV2 = t.CUV
			where e.CampaniaID = @CampaniaID)
		end
		else
		begin
			set @resultado = (select count(*)
			from @tablaCuvsOPT t
			left join Estrategia e on
				t.CampaniaID = e.CampaniaID
				and t.CUV = e.CUV2
			where 
				t.CampaniaID = @CampaniaID
				and e.CUV2 is null)
		end
	end

	select @resultado	
end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetOfertasParaTiByTipoConfigurado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetOfertasParaTiByTipoConfigurado
GO

create procedure dbo.GetOfertasParaTiByTipoConfigurado
@CampaniaID int,
@TipoConfigurado int
as
/*
exec GetOfertasParaTiByTipoConfigurado 201618,0
exec GetOfertasParaTiByTipoConfigurado 201618,1
exec GetOfertasParaTiByTipoConfigurado 201618,2
*/
begin
	declare @tablaResultado table (
		CUV2 varchar(5), 
		DescripcionCUV2 varchar(100),
		Precio2 decimal(18,2),
		CodigoProducto varchar(20),
		OfertaUltimoMinuto int,
		LimiteVenta int
	)

	declare @tablaCuvsOPT table (CampaniaID int, CUV varchar(5), OfertaUltimoMinuto int, LimiteVenta int)
	insert into @tablaCuvsOPT
	select distinct @CampaniaID, CUV, isnull(FlagUltMinuto,0), isnull(LimUnidades,99)
	from ods.OfertasPersonalizadas where AnioCampanaVenta = @CampaniaID and TipoPersonalizacion='OPT'

	if @TipoConfigurado=0
	begin
		insert into @tablaResultado
		select 
			t.CUV,
			coalesce(e.DescripcionCUV2,pd.Descripcion,p.Descripcion),
			coalesce(e.Precio2,p.PrecioUnitario),
			p.CodigoProducto,
			t.OfertaUltimoMinuto,
			t.LimiteVenta
		from @tablaCuvsOPT t
		inner join ods.ProductoComercial p on
			t.CampaniaID = p.AnoCampania
			and t.CUV = p.CUV
		left join Estrategia e on
			t.CampaniaID = e.CampaniaID
			and t.CUV = e.CUV2
		left join dbo.ProductoDescripcion pd on
				p.AnoCampania = pd.CampaniaID
				and p.CUV = pd.CUV
		where 
			p.AnoCampania = @CampaniaID
		
		insert into @tablaResultado
		select
			CUV,'',0,'',0,0
		from @tablaCuvsOPT where CUV not in (
			select CUV from ods.ProductoComercial where AnoCampania = @CampaniaID
		)
	end
	else
	begin
		if @TipoConfigurado = 1
		begin
			insert into @tablaResultado
			select
				t.CUV,
				coalesce(e.DescripcionCUV2,pd.Descripcion,p.Descripcion),
				coalesce(e.Precio2,p.PrecioUnitario),
				p.CodigoProducto,
				t.OfertaUltimoMinuto,
				t.LimiteVenta
			from @tablaCuvsOPT t
			inner join ods.ProductoComercial p on
				t.CampaniaID = p.AnoCampania
				and t.CUV = p.CUV
			inner join Estrategia e on
				t.CampaniaID = e.CampaniaID
				and t.CUV = e.CUV2
			left join dbo.ProductoDescripcion pd on
				p.AnoCampania = pd.CampaniaID
				and p.CUV = pd.CUV
			where e.CampaniaID = @CampaniaID
		end
		else
		begin
			insert into @tablaResultado
			select
				t.CUV,
				coalesce(e.DescripcionCUV2,pd.Descripcion,p.Descripcion),
				coalesce(e.Precio2,p.PrecioUnitario),
				p.CodigoProducto,
				t.OfertaUltimoMinuto,
				t.LimiteVenta
			from @tablaCuvsOPT t
			inner join ods.ProductoComercial p on
				t.CampaniaID = p.AnoCampania
				and t.CUV = p.CUV
			left join Estrategia e on
				t.CampaniaID = e.CampaniaID
				and t.CUV = e.CUV2
			left join dbo.ProductoDescripcion pd on
				p.AnoCampania = pd.CampaniaID
				and p.CUV = pd.CUV
			where 
				t.CampaniaID = @CampaniaID
				and e.CUV2 is null

			insert into @tablaResultado
			select
				CUV,'',0,'',0,0
			from @tablaCuvsOPT where CUV not in (
				select CUV from ods.ProductoComercial where AnoCampania = @CampaniaID
			)
		end
	end

	select * from @tablaResultado
end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertEstrategiaOfertaParaTi]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.InsertEstrategiaOfertaParaTi
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertEstrategiaTemporal]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.InsertEstrategiaTemporal
GO

IF TYPE_ID('dbo.EstrategiaTemporalType') IS NOT NULL
	DROP TYPE dbo.EstrategiaTemporalType
GO

CREATE TYPE dbo.EstrategiaTemporalType AS TABLE(
	CampaniaId int,
	CUV varchar(5),
	Descripcion varchar(100),
	PrecioOferta decimal(18,2),
	PrecioTachado decimal(18,2),
	CodigoSap varchar(20),
	OfertaUltimoMinuto int,
	LimiteVenta int,
	UsuarioCreacion varchar(50)
)
GO

create procedure dbo.InsertEstrategiaTemporal
@EstrategiaTemporal dbo.EstrategiaTemporalType readonly
as
/*

*/
begin

DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

declare @NumeroLote int = 0
select @NumeroLote = isnull(max(NumeroLote),0) from EstrategiaTemporal

set @NumeroLote = @NumeroLote + 1

insert into EstrategiaTemporal 
(CampaniaId,CUV,Descripcion,PrecioOferta,PrecioTachado,CodigoSap,OfertaUltimoMinuto,LimiteVenta,NumeroLote,FechaCreacion,UsuarioCreacion)
select
CampaniaId,CUV,Descripcion,PrecioOferta,PrecioTachado,CodigoSap,OfertaUltimoMinuto,LimiteVenta,@NumeroLote,@FechaGeneral,UsuarioCreacion
from @EstrategiaTemporal

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetCantidadOfertasParaTiTemporal]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetCantidadOfertasParaTiTemporal
GO

create procedure dbo.GetCantidadOfertasParaTiTemporal
@CampaniaID int,
@TipoConfigurado int
as
/*
exec GetCantidadOfertasParaTiTemporal 201618,0
exec GetCantidadOfertasParaTiTemporal 201618,1
exec GetCantidadOfertasParaTiTemporal 201618,2
*/
begin
	declare @resultado int = 0

	declare @NumeroLote int = 0
	select @NumeroLote = max(NumeroLote) from EstrategiaTemporal

	if @TipoConfigurado = 0
	begin		
		select @resultado = count(*) from EstrategiaTemporal
		where 
			CampaniaId = @CampaniaID
			and NumeroLote = @NumeroLote
	end
	else
	begin
		if @TipoConfigurado = 1
		begin
			select @resultado = count(*) from EstrategiaTemporal
			where 
				CampaniaId = @CampaniaID
				and Descripcion != ''
				and NumeroLote = @NumeroLote
		end
		else
		begin
			select @resultado = count(*) from EstrategiaTemporal
			where 
				CampaniaId = @CampaniaID
				and Descripcion = ''
				and NumeroLote = @NumeroLote
		end
	end

	select @resultado
end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetOfertasParaTiByTipoConfiguradoTemporal]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetOfertasParaTiByTipoConfiguradoTemporal
GO

create procedure dbo.GetOfertasParaTiByTipoConfiguradoTemporal
@CampaniaID int,
@TipoConfigurado int
as
/*
exec GetOfertasParaTiByTipoConfiguradoTemporal 201618,0
exec GetOfertasParaTiByTipoConfiguradoTemporal 201618,1
exec GetOfertasParaTiByTipoConfiguradoTemporal 201618,2
*/
begin

	declare @tablaResultado table (
		CUV2 varchar(5), 
		DescripcionCUV2 varchar(100),
		Precio2 decimal(18,2),
		Precio decimal(18,2),
		CodigoProducto varchar(20),
		OfertaUltimoMinuto int,
		LimiteVenta int
	)

	declare @NumeroLote int = 0
	select @NumeroLote = max(NumeroLote) from EstrategiaTemporal

	if @TipoConfigurado = 0
	begin
		insert into @tablaResultado
		select CUV, Descripcion, PrecioOferta, PrecioTachado, CodigoSap, OfertaUltimoMinuto, LimiteVenta
		from EstrategiaTemporal
		where 
			CampaniaId = @CampaniaID
			and NumeroLote = @NumeroLote
	end
	else
	begin
		if @TipoConfigurado = 1
		begin
			insert into @tablaResultado
			select CUV, Descripcion, PrecioOferta, PrecioTachado, CodigoSap, OfertaUltimoMinuto, LimiteVenta
			from EstrategiaTemporal
			where 
				CampaniaId = @CampaniaID
				and Descripcion != ''
				and NumeroLote = @NumeroLote
		end
		else
		begin
			insert into @tablaResultado
			select CUV, Descripcion, PrecioOferta, PrecioTachado, CodigoSap, OfertaUltimoMinuto, LimiteVenta
			from EstrategiaTemporal
			where 
				CampaniaId = @CampaniaID
				and Descripcion = ''
				and NumeroLote = @NumeroLote
		end
	end

	select * from @tablaResultado
end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteEstrategiaTemporal]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.DeleteEstrategiaTemporal
GO

create procedure dbo.DeleteEstrategiaTemporal
@CampaniaID int
as
begin
	declare @NumeroLote int = 0
	select @NumeroLote = max(NumeroLote) from EstrategiaTemporal

	delete from EstrategiaTemporal
	where 
		CampaniaId = @CampaniaID
		and NumeroLote = @NumeroLote
end

go

create procedure dbo.InsertEstrategiaOfertaParaTi
@EstrategiaTemporal dbo.EstrategiaTemporalType readonly
as
begin

DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

declare @TipoEstrategiaID int = 0

select @TipoEstrategiaID = TipoEstrategiaID 
from TipoEstrategia 
where DescripcionEstrategia like '%'+ UPPER('OFERTA PARA TI')+'%'

insert into Estrategia
(TipoEstrategiaID,CampaniaID,CampaniaIDFin,NumeroPedido,Activo,ImagenURL,LimiteVenta,DescripcionCUV2,
FlagDescripcion,CUV,EtiquetaID,Precio,FlagCEP,CUV2,EtiquetaID2,Precio2,FlagCEP2,TextoLibre,FlagTextoLibre,
Cantidad,FlagCantidad,
Zona,
Limite,Orden,UsuarioCreacion,FechaCreacion,UsuarioModificacion,
FechaModificacion,ColorFondo,FlagEstrella)
select 
	@TipoEstrategiaID,CampaniaId,0,0,1,'',LimiteVenta,Descripcion,
	1,'',0,PrecioTachado,0,CUV,3,PrecioOferta,1,'',0,
	0,0,
	'43,44,82,42,50,52,56,57,60,63,64,70,72,79,84,88,90,91,97,99,100,46,54,59,73,83,85,86,87,89,92,93,94,95,98,75,80',
	NULL,0,UsuarioCreacion,@FechaGeneral,UsuarioCreacion,
	@FechaGeneral,'',OfertaUltimoMinuto
from @EstrategiaTemporal
end

go

USE BelcorpSalvador
go

IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'EstrategiaTemporal' AND TABLE_SCHEMA = 'dbo')
BEGIN
    DROP TABLE dbo.EstrategiaTemporal
END
GO
CREATE TABLE dbo.EstrategiaTemporal(
	EstrategiaTemporalId INT IDENTITY(1,1) PRIMARY KEY,
	CampaniaId int,
	CUV varchar(5),
	Descripcion varchar(100),
	PrecioOferta decimal(18,2),
	PrecioTachado decimal(18,2),
	CodigoSap varchar(20),
	OfertaUltimoMinuto int,
	LimiteVenta int,
	NumeroLote int,
	FechaCreacion datetime,
	UsuarioCreacion varchar(20)
)
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetCantidadOfertasParaTi]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetCantidadOfertasParaTi
GO

create procedure dbo.GetCantidadOfertasParaTi
@CampaniaID int,
@TipoConfigurado int
as
/*
exec GetCantidadOfertasParaTi 201618,0
exec GetCantidadOfertasParaTi 201618,1
exec GetCantidadOfertasParaTi 201618,2
*/
begin
	declare @resultado int = 0

	declare @tablaCuvsOPT table (CampaniaID int, CUV varchar(5))
	insert into @tablaCuvsOPT
	select distinct @CampaniaID, CUV from ods.OfertasPersonalizadas where AnioCampanaVenta = @CampaniaID and TipoPersonalizacion='OPT'

	if @TipoConfigurado=0
	begin
		set @resultado = (select count(*) from @tablaCuvsOPT)
	end
	else
	begin
		if @TipoConfigurado = 1
		begin
			set @resultado = (select count(*)
			from Estrategia e
			inner join @tablaCuvsOPT t on
				e.CampaniaID = t.CampaniaID
				and e.CUV2 = t.CUV
			where e.CampaniaID = @CampaniaID)
		end
		else
		begin
			set @resultado = (select count(*)
			from @tablaCuvsOPT t
			left join Estrategia e on
				t.CampaniaID = e.CampaniaID
				and t.CUV = e.CUV2
			where 
				t.CampaniaID = @CampaniaID
				and e.CUV2 is null)
		end
	end

	select @resultado	
end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetOfertasParaTiByTipoConfigurado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetOfertasParaTiByTipoConfigurado
GO

create procedure dbo.GetOfertasParaTiByTipoConfigurado
@CampaniaID int,
@TipoConfigurado int
as
/*
exec GetOfertasParaTiByTipoConfigurado 201618,0
exec GetOfertasParaTiByTipoConfigurado 201618,1
exec GetOfertasParaTiByTipoConfigurado 201618,2
*/
begin
	declare @tablaResultado table (
		CUV2 varchar(5), 
		DescripcionCUV2 varchar(100),
		Precio2 decimal(18,2),
		CodigoProducto varchar(20),
		OfertaUltimoMinuto int,
		LimiteVenta int
	)

	declare @tablaCuvsOPT table (CampaniaID int, CUV varchar(5), OfertaUltimoMinuto int, LimiteVenta int)
	insert into @tablaCuvsOPT
	select distinct @CampaniaID, CUV, isnull(FlagUltMinuto,0), isnull(LimUnidades,99)
	from ods.OfertasPersonalizadas where AnioCampanaVenta = @CampaniaID and TipoPersonalizacion='OPT'

	if @TipoConfigurado=0
	begin
		insert into @tablaResultado
		select 
			t.CUV,
			coalesce(e.DescripcionCUV2,pd.Descripcion,p.Descripcion),
			coalesce(e.Precio2,p.PrecioUnitario),
			p.CodigoProducto,
			t.OfertaUltimoMinuto,
			t.LimiteVenta
		from @tablaCuvsOPT t
		inner join ods.ProductoComercial p on
			t.CampaniaID = p.AnoCampania
			and t.CUV = p.CUV
		left join Estrategia e on
			t.CampaniaID = e.CampaniaID
			and t.CUV = e.CUV2
		left join dbo.ProductoDescripcion pd on
				p.AnoCampania = pd.CampaniaID
				and p.CUV = pd.CUV
		where 
			p.AnoCampania = @CampaniaID
		
		insert into @tablaResultado
		select
			CUV,'',0,'',0,0
		from @tablaCuvsOPT where CUV not in (
			select CUV from ods.ProductoComercial where AnoCampania = @CampaniaID
		)
	end
	else
	begin
		if @TipoConfigurado = 1
		begin
			insert into @tablaResultado
			select
				t.CUV,
				coalesce(e.DescripcionCUV2,pd.Descripcion,p.Descripcion),
				coalesce(e.Precio2,p.PrecioUnitario),
				p.CodigoProducto,
				t.OfertaUltimoMinuto,
				t.LimiteVenta
			from @tablaCuvsOPT t
			inner join ods.ProductoComercial p on
				t.CampaniaID = p.AnoCampania
				and t.CUV = p.CUV
			inner join Estrategia e on
				t.CampaniaID = e.CampaniaID
				and t.CUV = e.CUV2
			left join dbo.ProductoDescripcion pd on
				p.AnoCampania = pd.CampaniaID
				and p.CUV = pd.CUV
			where e.CampaniaID = @CampaniaID
		end
		else
		begin
			insert into @tablaResultado
			select
				t.CUV,
				coalesce(e.DescripcionCUV2,pd.Descripcion,p.Descripcion),
				coalesce(e.Precio2,p.PrecioUnitario),
				p.CodigoProducto,
				t.OfertaUltimoMinuto,
				t.LimiteVenta
			from @tablaCuvsOPT t
			inner join ods.ProductoComercial p on
				t.CampaniaID = p.AnoCampania
				and t.CUV = p.CUV
			left join Estrategia e on
				t.CampaniaID = e.CampaniaID
				and t.CUV = e.CUV2
			left join dbo.ProductoDescripcion pd on
				p.AnoCampania = pd.CampaniaID
				and p.CUV = pd.CUV
			where 
				t.CampaniaID = @CampaniaID
				and e.CUV2 is null

			insert into @tablaResultado
			select
				CUV,'',0,'',0,0
			from @tablaCuvsOPT where CUV not in (
				select CUV from ods.ProductoComercial where AnoCampania = @CampaniaID
			)
		end
	end

	select * from @tablaResultado
end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertEstrategiaOfertaParaTi]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.InsertEstrategiaOfertaParaTi
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertEstrategiaTemporal]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.InsertEstrategiaTemporal
GO

IF TYPE_ID('dbo.EstrategiaTemporalType') IS NOT NULL
	DROP TYPE dbo.EstrategiaTemporalType
GO

CREATE TYPE dbo.EstrategiaTemporalType AS TABLE(
	CampaniaId int,
	CUV varchar(5),
	Descripcion varchar(100),
	PrecioOferta decimal(18,2),
	PrecioTachado decimal(18,2),
	CodigoSap varchar(20),
	OfertaUltimoMinuto int,
	LimiteVenta int,
	UsuarioCreacion varchar(50)
)
GO

create procedure dbo.InsertEstrategiaTemporal
@EstrategiaTemporal dbo.EstrategiaTemporalType readonly
as
/*

*/
begin

DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

declare @NumeroLote int = 0
select @NumeroLote = isnull(max(NumeroLote),0) from EstrategiaTemporal

set @NumeroLote = @NumeroLote + 1

insert into EstrategiaTemporal 
(CampaniaId,CUV,Descripcion,PrecioOferta,PrecioTachado,CodigoSap,OfertaUltimoMinuto,LimiteVenta,NumeroLote,FechaCreacion,UsuarioCreacion)
select
CampaniaId,CUV,Descripcion,PrecioOferta,PrecioTachado,CodigoSap,OfertaUltimoMinuto,LimiteVenta,@NumeroLote,@FechaGeneral,UsuarioCreacion
from @EstrategiaTemporal

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetCantidadOfertasParaTiTemporal]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetCantidadOfertasParaTiTemporal
GO

create procedure dbo.GetCantidadOfertasParaTiTemporal
@CampaniaID int,
@TipoConfigurado int
as
/*
exec GetCantidadOfertasParaTiTemporal 201618,0
exec GetCantidadOfertasParaTiTemporal 201618,1
exec GetCantidadOfertasParaTiTemporal 201618,2
*/
begin
	declare @resultado int = 0

	declare @NumeroLote int = 0
	select @NumeroLote = max(NumeroLote) from EstrategiaTemporal

	if @TipoConfigurado = 0
	begin		
		select @resultado = count(*) from EstrategiaTemporal
		where 
			CampaniaId = @CampaniaID
			and NumeroLote = @NumeroLote
	end
	else
	begin
		if @TipoConfigurado = 1
		begin
			select @resultado = count(*) from EstrategiaTemporal
			where 
				CampaniaId = @CampaniaID
				and Descripcion != ''
				and NumeroLote = @NumeroLote
		end
		else
		begin
			select @resultado = count(*) from EstrategiaTemporal
			where 
				CampaniaId = @CampaniaID
				and Descripcion = ''
				and NumeroLote = @NumeroLote
		end
	end

	select @resultado
end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetOfertasParaTiByTipoConfiguradoTemporal]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetOfertasParaTiByTipoConfiguradoTemporal
GO

create procedure dbo.GetOfertasParaTiByTipoConfiguradoTemporal
@CampaniaID int,
@TipoConfigurado int
as
/*
exec GetOfertasParaTiByTipoConfiguradoTemporal 201618,0
exec GetOfertasParaTiByTipoConfiguradoTemporal 201618,1
exec GetOfertasParaTiByTipoConfiguradoTemporal 201618,2
*/
begin

	declare @tablaResultado table (
		CUV2 varchar(5), 
		DescripcionCUV2 varchar(100),
		Precio2 decimal(18,2),
		Precio decimal(18,2),
		CodigoProducto varchar(20),
		OfertaUltimoMinuto int,
		LimiteVenta int
	)

	declare @NumeroLote int = 0
	select @NumeroLote = max(NumeroLote) from EstrategiaTemporal

	if @TipoConfigurado = 0
	begin
		insert into @tablaResultado
		select CUV, Descripcion, PrecioOferta, PrecioTachado, CodigoSap, OfertaUltimoMinuto, LimiteVenta
		from EstrategiaTemporal
		where 
			CampaniaId = @CampaniaID
			and NumeroLote = @NumeroLote
	end
	else
	begin
		if @TipoConfigurado = 1
		begin
			insert into @tablaResultado
			select CUV, Descripcion, PrecioOferta, PrecioTachado, CodigoSap, OfertaUltimoMinuto, LimiteVenta
			from EstrategiaTemporal
			where 
				CampaniaId = @CampaniaID
				and Descripcion != ''
				and NumeroLote = @NumeroLote
		end
		else
		begin
			insert into @tablaResultado
			select CUV, Descripcion, PrecioOferta, PrecioTachado, CodigoSap, OfertaUltimoMinuto, LimiteVenta
			from EstrategiaTemporal
			where 
				CampaniaId = @CampaniaID
				and Descripcion = ''
				and NumeroLote = @NumeroLote
		end
	end

	select * from @tablaResultado
end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteEstrategiaTemporal]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.DeleteEstrategiaTemporal
GO

create procedure dbo.DeleteEstrategiaTemporal
@CampaniaID int
as
begin
	declare @NumeroLote int = 0
	select @NumeroLote = max(NumeroLote) from EstrategiaTemporal

	delete from EstrategiaTemporal
	where 
		CampaniaId = @CampaniaID
		and NumeroLote = @NumeroLote
end

go

create procedure dbo.InsertEstrategiaOfertaParaTi
@EstrategiaTemporal dbo.EstrategiaTemporalType readonly
as
begin

DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

declare @TipoEstrategiaID int = 0

select @TipoEstrategiaID = TipoEstrategiaID 
from TipoEstrategia 
where DescripcionEstrategia like '%'+ UPPER('OFERTA PARA TI')+'%'

insert into Estrategia
(TipoEstrategiaID,CampaniaID,CampaniaIDFin,NumeroPedido,Activo,ImagenURL,LimiteVenta,DescripcionCUV2,
FlagDescripcion,CUV,EtiquetaID,Precio,FlagCEP,CUV2,EtiquetaID2,Precio2,FlagCEP2,TextoLibre,FlagTextoLibre,
Cantidad,FlagCantidad,
Zona,
Limite,Orden,UsuarioCreacion,FechaCreacion,UsuarioModificacion,
FechaModificacion,ColorFondo,FlagEstrella)
select 
	@TipoEstrategiaID,CampaniaId,0,0,1,'',LimiteVenta,Descripcion,
	1,'',0,PrecioTachado,0,CUV,3,PrecioOferta,1,'',0,
	0,0,
	'20627,20637,20617,20618,20623,20628,20629,20633,20634,20640,20654,20655,20664,20669,20670,20613,20614,20615,20616,20624,20625,20631,20632,20639,20644,20652,20653,20661,20662,20610,20620,20630,20638,20642,20643,20646,20656,20657,20665,20672,20673,20609,20619,20621,20635,20636,20645,20647,20648,20649,20650,20658,20659,20674,20612,20660,20668',
	NULL,0,UsuarioCreacion,@FechaGeneral,UsuarioCreacion,
	@FechaGeneral,'',OfertaUltimoMinuto
from @EstrategiaTemporal
end

go

USE BelcorpVenezuela
go

IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'EstrategiaTemporal' AND TABLE_SCHEMA = 'dbo')
BEGIN
    DROP TABLE dbo.EstrategiaTemporal
END
GO
CREATE TABLE dbo.EstrategiaTemporal(
	EstrategiaTemporalId INT IDENTITY(1,1) PRIMARY KEY,
	CampaniaId int,
	CUV varchar(5),
	Descripcion varchar(100),
	PrecioOferta decimal(18,2),
	PrecioTachado decimal(18,2),
	CodigoSap varchar(20),
	OfertaUltimoMinuto int,
	LimiteVenta int,
	NumeroLote int,
	FechaCreacion datetime,
	UsuarioCreacion varchar(20)
)
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetCantidadOfertasParaTi]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetCantidadOfertasParaTi
GO

create procedure dbo.GetCantidadOfertasParaTi
@CampaniaID int,
@TipoConfigurado int
as
/*
exec GetCantidadOfertasParaTi 201618,0
exec GetCantidadOfertasParaTi 201618,1
exec GetCantidadOfertasParaTi 201618,2
*/
begin
	declare @resultado int = 0

	declare @tablaCuvsOPT table (CampaniaID int, CUV varchar(5))
	insert into @tablaCuvsOPT
	select distinct @CampaniaID, CUV from ods.OfertasPersonalizadas where AnioCampanaVenta = @CampaniaID and TipoPersonalizacion='OPT'

	if @TipoConfigurado=0
	begin
		set @resultado = (select count(*) from @tablaCuvsOPT)
	end
	else
	begin
		if @TipoConfigurado = 1
		begin
			set @resultado = (select count(*)
			from Estrategia e
			inner join @tablaCuvsOPT t on
				e.CampaniaID = t.CampaniaID
				and e.CUV2 = t.CUV
			where e.CampaniaID = @CampaniaID)
		end
		else
		begin
			set @resultado = (select count(*)
			from @tablaCuvsOPT t
			left join Estrategia e on
				t.CampaniaID = e.CampaniaID
				and t.CUV = e.CUV2
			where 
				t.CampaniaID = @CampaniaID
				and e.CUV2 is null)
		end
	end

	select @resultado	
end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetOfertasParaTiByTipoConfigurado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetOfertasParaTiByTipoConfigurado
GO

create procedure dbo.GetOfertasParaTiByTipoConfigurado
@CampaniaID int,
@TipoConfigurado int
as
/*
exec GetOfertasParaTiByTipoConfigurado 201618,0
exec GetOfertasParaTiByTipoConfigurado 201618,1
exec GetOfertasParaTiByTipoConfigurado 201618,2
*/
begin
	declare @tablaResultado table (
		CUV2 varchar(5), 
		DescripcionCUV2 varchar(100),
		Precio2 decimal(18,2),
		CodigoProducto varchar(20),
		OfertaUltimoMinuto int,
		LimiteVenta int
	)

	declare @tablaCuvsOPT table (CampaniaID int, CUV varchar(5), OfertaUltimoMinuto int, LimiteVenta int)
	insert into @tablaCuvsOPT
	select distinct @CampaniaID, CUV, isnull(FlagUltMinuto,0), isnull(LimUnidades,99)
	from ods.OfertasPersonalizadas where AnioCampanaVenta = @CampaniaID and TipoPersonalizacion='OPT'

	if @TipoConfigurado=0
	begin
		insert into @tablaResultado
		select 
			t.CUV,
			coalesce(e.DescripcionCUV2,pd.Descripcion,p.Descripcion),
			coalesce(e.Precio2,p.PrecioUnitario),
			p.CodigoProducto,
			t.OfertaUltimoMinuto,
			t.LimiteVenta
		from @tablaCuvsOPT t
		inner join ods.ProductoComercial p on
			t.CampaniaID = p.AnoCampania
			and t.CUV = p.CUV
		left join Estrategia e on
			t.CampaniaID = e.CampaniaID
			and t.CUV = e.CUV2
		left join dbo.ProductoDescripcion pd on
				p.AnoCampania = pd.CampaniaID
				and p.CUV = pd.CUV
		where 
			p.AnoCampania = @CampaniaID
		
		insert into @tablaResultado
		select
			CUV,'',0,'',0,0
		from @tablaCuvsOPT where CUV not in (
			select CUV from ods.ProductoComercial where AnoCampania = @CampaniaID
		)
	end
	else
	begin
		if @TipoConfigurado = 1
		begin
			insert into @tablaResultado
			select
				t.CUV,
				coalesce(e.DescripcionCUV2,pd.Descripcion,p.Descripcion),
				coalesce(e.Precio2,p.PrecioUnitario),
				p.CodigoProducto,
				t.OfertaUltimoMinuto,
				t.LimiteVenta
			from @tablaCuvsOPT t
			inner join ods.ProductoComercial p on
				t.CampaniaID = p.AnoCampania
				and t.CUV = p.CUV
			inner join Estrategia e on
				t.CampaniaID = e.CampaniaID
				and t.CUV = e.CUV2
			left join dbo.ProductoDescripcion pd on
				p.AnoCampania = pd.CampaniaID
				and p.CUV = pd.CUV
			where e.CampaniaID = @CampaniaID
		end
		else
		begin
			insert into @tablaResultado
			select
				t.CUV,
				coalesce(e.DescripcionCUV2,pd.Descripcion,p.Descripcion),
				coalesce(e.Precio2,p.PrecioUnitario),
				p.CodigoProducto,
				t.OfertaUltimoMinuto,
				t.LimiteVenta
			from @tablaCuvsOPT t
			inner join ods.ProductoComercial p on
				t.CampaniaID = p.AnoCampania
				and t.CUV = p.CUV
			left join Estrategia e on
				t.CampaniaID = e.CampaniaID
				and t.CUV = e.CUV2
			left join dbo.ProductoDescripcion pd on
				p.AnoCampania = pd.CampaniaID
				and p.CUV = pd.CUV
			where 
				t.CampaniaID = @CampaniaID
				and e.CUV2 is null

			insert into @tablaResultado
			select
				CUV,'',0,'',0,0
			from @tablaCuvsOPT where CUV not in (
				select CUV from ods.ProductoComercial where AnoCampania = @CampaniaID
			)
		end
	end

	select * from @tablaResultado
end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertEstrategiaOfertaParaTi]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.InsertEstrategiaOfertaParaTi
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertEstrategiaTemporal]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.InsertEstrategiaTemporal
GO

IF TYPE_ID('dbo.EstrategiaTemporalType') IS NOT NULL
	DROP TYPE dbo.EstrategiaTemporalType
GO

CREATE TYPE dbo.EstrategiaTemporalType AS TABLE(
	CampaniaId int,
	CUV varchar(5),
	Descripcion varchar(100),
	PrecioOferta decimal(18,2),
	PrecioTachado decimal(18,2),
	CodigoSap varchar(20),
	OfertaUltimoMinuto int,
	LimiteVenta int,
	UsuarioCreacion varchar(50)
)
GO

create procedure dbo.InsertEstrategiaTemporal
@EstrategiaTemporal dbo.EstrategiaTemporalType readonly
as
/*

*/
begin

DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

declare @NumeroLote int = 0
select @NumeroLote = isnull(max(NumeroLote),0) from EstrategiaTemporal

set @NumeroLote = @NumeroLote + 1

insert into EstrategiaTemporal 
(CampaniaId,CUV,Descripcion,PrecioOferta,PrecioTachado,CodigoSap,OfertaUltimoMinuto,LimiteVenta,NumeroLote,FechaCreacion,UsuarioCreacion)
select
CampaniaId,CUV,Descripcion,PrecioOferta,PrecioTachado,CodigoSap,OfertaUltimoMinuto,LimiteVenta,@NumeroLote,@FechaGeneral,UsuarioCreacion
from @EstrategiaTemporal

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetCantidadOfertasParaTiTemporal]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetCantidadOfertasParaTiTemporal
GO

create procedure dbo.GetCantidadOfertasParaTiTemporal
@CampaniaID int,
@TipoConfigurado int
as
/*
exec GetCantidadOfertasParaTiTemporal 201618,0
exec GetCantidadOfertasParaTiTemporal 201618,1
exec GetCantidadOfertasParaTiTemporal 201618,2
*/
begin
	declare @resultado int = 0

	declare @NumeroLote int = 0
	select @NumeroLote = max(NumeroLote) from EstrategiaTemporal

	if @TipoConfigurado = 0
	begin		
		select @resultado = count(*) from EstrategiaTemporal
		where 
			CampaniaId = @CampaniaID
			and NumeroLote = @NumeroLote
	end
	else
	begin
		if @TipoConfigurado = 1
		begin
			select @resultado = count(*) from EstrategiaTemporal
			where 
				CampaniaId = @CampaniaID
				and Descripcion != ''
				and NumeroLote = @NumeroLote
		end
		else
		begin
			select @resultado = count(*) from EstrategiaTemporal
			where 
				CampaniaId = @CampaniaID
				and Descripcion = ''
				and NumeroLote = @NumeroLote
		end
	end

	select @resultado
end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetOfertasParaTiByTipoConfiguradoTemporal]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetOfertasParaTiByTipoConfiguradoTemporal
GO

create procedure dbo.GetOfertasParaTiByTipoConfiguradoTemporal
@CampaniaID int,
@TipoConfigurado int
as
/*
exec GetOfertasParaTiByTipoConfiguradoTemporal 201618,0
exec GetOfertasParaTiByTipoConfiguradoTemporal 201618,1
exec GetOfertasParaTiByTipoConfiguradoTemporal 201618,2
*/
begin

	declare @tablaResultado table (
		CUV2 varchar(5), 
		DescripcionCUV2 varchar(100),
		Precio2 decimal(18,2),
		Precio decimal(18,2),
		CodigoProducto varchar(20),
		OfertaUltimoMinuto int,
		LimiteVenta int
	)

	declare @NumeroLote int = 0
	select @NumeroLote = max(NumeroLote) from EstrategiaTemporal

	if @TipoConfigurado = 0
	begin
		insert into @tablaResultado
		select CUV, Descripcion, PrecioOferta, PrecioTachado, CodigoSap, OfertaUltimoMinuto, LimiteVenta
		from EstrategiaTemporal
		where 
			CampaniaId = @CampaniaID
			and NumeroLote = @NumeroLote
	end
	else
	begin
		if @TipoConfigurado = 1
		begin
			insert into @tablaResultado
			select CUV, Descripcion, PrecioOferta, PrecioTachado, CodigoSap, OfertaUltimoMinuto, LimiteVenta
			from EstrategiaTemporal
			where 
				CampaniaId = @CampaniaID
				and Descripcion != ''
				and NumeroLote = @NumeroLote
		end
		else
		begin
			insert into @tablaResultado
			select CUV, Descripcion, PrecioOferta, PrecioTachado, CodigoSap, OfertaUltimoMinuto, LimiteVenta
			from EstrategiaTemporal
			where 
				CampaniaId = @CampaniaID
				and Descripcion = ''
				and NumeroLote = @NumeroLote
		end
	end

	select * from @tablaResultado
end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteEstrategiaTemporal]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.DeleteEstrategiaTemporal
GO

create procedure dbo.DeleteEstrategiaTemporal
@CampaniaID int
as
begin
	declare @NumeroLote int = 0
	select @NumeroLote = max(NumeroLote) from EstrategiaTemporal

	delete from EstrategiaTemporal
	where 
		CampaniaId = @CampaniaID
		and NumeroLote = @NumeroLote
end

go

create procedure dbo.InsertEstrategiaOfertaParaTi
@EstrategiaTemporal dbo.EstrategiaTemporalType readonly
as
begin

DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

declare @TipoEstrategiaID int = 0

select @TipoEstrategiaID = TipoEstrategiaID 
from TipoEstrategia 
where DescripcionEstrategia like '%'+ UPPER('OFERTA PARA TI')+'%'

insert into Estrategia
(TipoEstrategiaID,CampaniaID,CampaniaIDFin,NumeroPedido,Activo,ImagenURL,LimiteVenta,DescripcionCUV2,
FlagDescripcion,CUV,EtiquetaID,Precio,FlagCEP,CUV2,EtiquetaID2,Precio2,FlagCEP2,TextoLibre,FlagTextoLibre,
Cantidad,FlagCantidad,
Zona,
Limite,Orden,UsuarioCreacion,FechaCreacion,UsuarioModificacion,
FechaModificacion,ColorFondo,FlagEstrella)
select 
	@TipoEstrategiaID,CampaniaId,0,0,1,'',LimiteVenta,Descripcion,
	1,'',0,PrecioTachado,0,CUV,3,PrecioOferta,1,'',0,
	0,0,
	'2147,2148,2149,2152,2153,2154,2773,2774,2776,2778,2779,2873,2167,2169,2170,2172,2174,2176,2177,2178,2179,2183,2822,2823,2825,2333,2335,2337,2343,2349,2508,2750,2772,2793,2794,2795,2798,2799,2801,2803,2208,2211,2686,2688,2690,2696,2813,2815,2816,2817,2821,2824,2228,2229,2232,2243,2244,2674,2675,2676,2680,2681,2684,2250,2251,2253,2254,2484,2749,2751,2752,2755,2757,2758,2767,2768,2770,2269,2276,2707,2710,2711,2713,2714,2913,2914,2919,2923,2926,2928,2285,2289,2290,2291,2292,2301,2495,2500,2915,2916,2917,2925,2354,2362,2364,2365,2372,2699,2701,2725,2729,2731,2732,2893,2894,2375,2378,2381,2384,2385,2386,2456,2459,2703,2736,2737,2946,2947,2948,2392,2394,2396,2397,2400,2401,2403,2404,2405,2406,2407,2408,2412,2413,2415,2416,2418,2419,2420,2920,2921,2924,2143,2438,2436,2437,2570,2572,2573,2574,2575,2577,2581,2586,2587,2588,2936,2937,2943',
	NULL,0,UsuarioCreacion,@FechaGeneral,UsuarioCreacion,
	@FechaGeneral,'',OfertaUltimoMinuto
from @EstrategiaTemporal
end

go