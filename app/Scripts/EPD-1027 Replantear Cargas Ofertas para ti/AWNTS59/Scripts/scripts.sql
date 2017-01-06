USE BelcorpColombia
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
	'53,318,356,372,23,24,54,63,100,138,139,140,191,192,193,231,234,278,322,55,141,143,144,147,148,194,197,230,232,276,319,321,323,21,58,59,61,64,101,145,190,195,226,227,228,235,275,279,10,22,56,57,60,62,146,196,229,233,236,277,320,26,30,31,65,68,106,107,150,198,199,202,284,285,324,325,375,72,74,103,104,105,108,109,238,280,281,286,287,288,289,27,67,69,70,71,73,102,149,151,152,153,239,282,283,290,28,32,66,113,155,157,200,201,237,240,340,342,355,368,76,154,156,166,298,326,344,348,349,351,354,379,33,36,78,79,110,111,112,114,117,165,242,243,292,293,294,295,34,75,116,118,158,159,160,169,215,328,329,334,377,38,39,40,41,43,80,85,119,121,170,245,248,301,335,338,42,82,84,168,207,208,246,249,299,330,332,336,337,37,81,83,120,167,171,172,173,174,247,250,302,331,333,2,3,5,9,45,46,86,122,125,213,256,259,300,303,6,48,89,92,124,175,179,211,214,251,252,257,258,260,7,44,47,91,176,180,181,209,210,253,254,255,304,307,308,4,8,11,87,88,90,123,177,178,212,217,305,306,374,49,93,126,127,128,130,183,184,216,218,262,263,264,268,309,16,132,221,311,373,17,19,51,96,97,133,135,187,188,189,219,265,272,274,312,13,15,50,94,129,136,222,266,267,270,271,314,316,317,20,99,357,358,359,360,361,362,363,364,365,366,367,369,370,378',
	NULL,0,UsuarioCreacion,@FechaGeneral,UsuarioCreacion,
	@FechaGeneral,'',OfertaUltimoMinuto
from @EstrategiaTemporal
end

go

USE BelcorpMexico
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
	'43,88,5,6,7,45,46,47,48,125,176,216,217,253,288,289,332,337,339,9,10,49,50,51,89,90,126,127,177,218,219,220,290,291,333,335,338,11,12,52,53,128,129,130,178,180,181,182,222,327,329,330,341,13,14,54,55,56,92,93,131,132,133,135,183,223,292,322,324,15,57,58,94,95,137,138,139,140,141,184,254,293,294,321,323,336,59,60,96,97,144,145,225,226,256,257,295,325,326,328,331,334,340,17,18,19,101,102,103,187,188,189,229,230,231,260,297,298,20,21,22,63,64,104,148,149,190,191,232,261,262,263,264,299,23,24,65,66,105,150,151,152,192,193,194,195,233,265,266,300,25,26,106,107,153,154,155,156,157,158,159,196,197,267,268,269,301,27,67,68,69,70,108,109,110,111,160,161,162,198,199,200,234,270,271,28,29,30,71,72,73,112,163,164,201,202,235,236,272,31,32,33,74,75,76,113,165,203,237,238,239,274,275,34,77,78,114,115,116,166,167,204,205,206,276,277,278,302,35,79,80,81,117,118,119,168,169,207,208,279,303,304,36,37,38,82,120,121,170,209,240,280,281,305,306,307,39,83,122,123,210,241,242,243,282,308,309,310,311,40,41,84,124,171,211,212,244,245,248,249,250,283,312,313,314,315,2,42,85,86,87,172,173,213,214,246,247,251,252,284,316,317,3,4,174,285,318,320,342,44,175',
	NULL,0,UsuarioCreacion,@FechaGeneral,UsuarioCreacion,
	@FechaGeneral,'',OfertaUltimoMinuto
from @EstrategiaTemporal
end

go

USE BelcorpPeru
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
	'2231,2232,2233,2234,2235,2236,2237,2238,2239,2240,2241,2276,2310,2329,2588,2589,2590,2591,2592,2593,2036,2037,2039,2041,2042,2043,2044,2045,2046,2047,2048,2049,2050,2051,2052,2053,2054,2055,2056,2008,2009,2103,2104,2105,2106,2107,2108,2110,2111,2112,2113,2114,2115,2202,2203,2204,2208,2209,2210,2211,2212,2213,2305,2430,2431,2432,2434,2435,2438,2444,2445,2448,2488,2242,2243,2244,2245,2246,2247,2248,2249,2250,2251,2252,2253,2254,2255,2256,2257,2258,2259,2260,2133,2134,2135,2136,2139,2140,2141,2142,2143,2144,2145,2146,2147,2148,2012,2013,2014,2177,2178,2179,2180,2181,2183,2184,2185,2186,2301,2311,2583,2584,2585,2261,2262,2263,2264,2425,2426,2427,2020,2022,2025,2031,2032,2034,2035,2433,2436,2437,2440,2443,2548,2568,2569,2570,2571,2572,2010,2011,2163,2164,2165,2166,2167,2168,2169,2170,2171,2172,2173,2174,2175,2176,2015,2016,2017,2018,2187,2188,2189,2190,2191,2192,2193,2194,2195,2196,2197,2198,2199,2200,2201,2423,2001,2002,2003,2004,2075,2076,2077,2078,2079,2081,2082,2083,2084,2085,2086,2088,2089,2223,2224,2225,2226,2227,2228,2229,2306,2424,2446,2468,2508,2005,2006,2007,2090,2091,2092,2093,2094,2096,2098,2099,2100,2101,2302,2573,2574,2575,2576,2578,2149,2150,2151,2152,2153,2154,2155,2156,2157,2158,2159,2160,2161,2162,2304,2528,2579,2580,2581,2582',
	NULL,0,UsuarioCreacion,@FechaGeneral,UsuarioCreacion,
	@FechaGeneral,'',OfertaUltimoMinuto
from @EstrategiaTemporal
end

go