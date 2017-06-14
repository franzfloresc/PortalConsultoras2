USE BelcorpBolivia
GO

alter procedure dbo.GetOfertasParaTiByTipoConfigurado
@CampaniaID int,
@TipoConfigurado int
as
/*
exec GetOfertasParaTiByTipoConfigurado 201618,0
exec GetOfertasParaTiByTipoConfigurado 201618,1
exec GetOfertasParaTiByTipoConfigurado 201618,2
*/
declare @tablaResultado table (
Id int identity(1,1),
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
select * from @tablaResultado where Id in (
select min(id) from @tablaResultado
group by CUV2
)
go

USE BelcorpCostaRica
GO

alter procedure dbo.GetOfertasParaTiByTipoConfigurado
@CampaniaID int,
@TipoConfigurado int
as
/*
exec GetOfertasParaTiByTipoConfigurado 201618,0
exec GetOfertasParaTiByTipoConfigurado 201618,1
exec GetOfertasParaTiByTipoConfigurado 201618,2
*/
declare @tablaResultado table (
Id int identity(1,1),
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
select * from @tablaResultado where Id in (
select min(id) from @tablaResultado
group by CUV2
)
go

USE BelcorpChile
GO

alter procedure dbo.GetOfertasParaTiByTipoConfigurado
@CampaniaID int,
@TipoConfigurado int
as
/*
exec GetOfertasParaTiByTipoConfigurado 201618,0
exec GetOfertasParaTiByTipoConfigurado 201618,1
exec GetOfertasParaTiByTipoConfigurado 201618,2
*/
declare @tablaResultado table (
Id int identity(1,1),
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
select * from @tablaResultado where Id in (
select min(id) from @tablaResultado
group by CUV2
)
go

USE BelcorpColombia
GO

alter procedure dbo.GetOfertasParaTiByTipoConfigurado
@CampaniaID int,
@TipoConfigurado int
as
/*
exec GetOfertasParaTiByTipoConfigurado 201618,0
exec GetOfertasParaTiByTipoConfigurado 201618,1
exec GetOfertasParaTiByTipoConfigurado 201618,2
*/
declare @tablaResultado table (
Id int identity(1,1),
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
select * from @tablaResultado where Id in (
select min(id) from @tablaResultado
group by CUV2
)
go

USE BelcorpDominicana
GO

alter procedure dbo.GetOfertasParaTiByTipoConfigurado
@CampaniaID int,
@TipoConfigurado int
as
/*
exec GetOfertasParaTiByTipoConfigurado 201618,0
exec GetOfertasParaTiByTipoConfigurado 201618,1
exec GetOfertasParaTiByTipoConfigurado 201618,2
*/
declare @tablaResultado table (
Id int identity(1,1),
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
select * from @tablaResultado where Id in (
select min(id) from @tablaResultado
group by CUV2
)
go

USE BelcorpEcuador
GO

alter procedure dbo.GetOfertasParaTiByTipoConfigurado
@CampaniaID int,
@TipoConfigurado int
as
/*
exec GetOfertasParaTiByTipoConfigurado 201618,0
exec GetOfertasParaTiByTipoConfigurado 201618,1
exec GetOfertasParaTiByTipoConfigurado 201618,2
*/
declare @tablaResultado table (
Id int identity(1,1),
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
select * from @tablaResultado where Id in (
select min(id) from @tablaResultado
group by CUV2
)
go

USE BelcorpGuatemala
GO

alter procedure dbo.GetOfertasParaTiByTipoConfigurado
@CampaniaID int,
@TipoConfigurado int
as
/*
exec GetOfertasParaTiByTipoConfigurado 201618,0
exec GetOfertasParaTiByTipoConfigurado 201618,1
exec GetOfertasParaTiByTipoConfigurado 201618,2
*/
declare @tablaResultado table (
Id int identity(1,1),
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
select * from @tablaResultado where Id in (
select min(id) from @tablaResultado
group by CUV2
)
go

USE BelcorpMexico
GO

alter procedure dbo.GetOfertasParaTiByTipoConfigurado
@CampaniaID int,
@TipoConfigurado int
as
/*
exec GetOfertasParaTiByTipoConfigurado 201618,0
exec GetOfertasParaTiByTipoConfigurado 201618,1
exec GetOfertasParaTiByTipoConfigurado 201618,2
*/
declare @tablaResultado table (
Id int identity(1,1),
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
select * from @tablaResultado where Id in (
select min(id) from @tablaResultado
group by CUV2
)
go

USE BelcorpPanama
GO

alter procedure dbo.GetOfertasParaTiByTipoConfigurado
@CampaniaID int,
@TipoConfigurado int
as
/*
exec GetOfertasParaTiByTipoConfigurado 201618,0
exec GetOfertasParaTiByTipoConfigurado 201618,1
exec GetOfertasParaTiByTipoConfigurado 201618,2
*/
declare @tablaResultado table (
Id int identity(1,1),
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
select * from @tablaResultado where Id in (
select min(id) from @tablaResultado
group by CUV2
)
go

USE BelcorpPeru
GO

alter procedure dbo.GetOfertasParaTiByTipoConfigurado
@CampaniaID int,
@TipoConfigurado int
as
/*
exec GetOfertasParaTiByTipoConfigurado 201618,0
exec GetOfertasParaTiByTipoConfigurado 201618,1
exec GetOfertasParaTiByTipoConfigurado 201618,2
*/
declare @tablaResultado table (
Id int identity(1,1),
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
select * from @tablaResultado where Id in (
select min(id) from @tablaResultado
group by CUV2
)
go

USE BelcorpPuertoRico
GO

alter procedure dbo.GetOfertasParaTiByTipoConfigurado
@CampaniaID int,
@TipoConfigurado int
as
/*
exec GetOfertasParaTiByTipoConfigurado 201618,0
exec GetOfertasParaTiByTipoConfigurado 201618,1
exec GetOfertasParaTiByTipoConfigurado 201618,2
*/
declare @tablaResultado table (
Id int identity(1,1),
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
select * from @tablaResultado where Id in (
select min(id) from @tablaResultado
group by CUV2
)
go

USE BelcorpSalvador
GO

alter procedure dbo.GetOfertasParaTiByTipoConfigurado
@CampaniaID int,
@TipoConfigurado int
as
/*
exec GetOfertasParaTiByTipoConfigurado 201618,0
exec GetOfertasParaTiByTipoConfigurado 201618,1
exec GetOfertasParaTiByTipoConfigurado 201618,2
*/
declare @tablaResultado table (
Id int identity(1,1),
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
select * from @tablaResultado where Id in (
select min(id) from @tablaResultado
group by CUV2
)
go

USE BelcorpVenezuela
GO

alter procedure dbo.GetOfertasParaTiByTipoConfigurado
@CampaniaID int,
@TipoConfigurado int
as
/*
exec GetOfertasParaTiByTipoConfigurado 201618,0
exec GetOfertasParaTiByTipoConfigurado 201618,1
exec GetOfertasParaTiByTipoConfigurado 201618,2
*/
declare @tablaResultado table (
Id int identity(1,1),
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
select * from @tablaResultado where Id in (
select min(id) from @tablaResultado
group by CUV2
)
go










