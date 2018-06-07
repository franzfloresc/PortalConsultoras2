USE BelcorpPeru
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[RegistrarProductoMasivo]') 
	AND type in (N'P', N'PC')
) 
DROP PROCEDURE [dbo].[RegistrarProductoMasivo]
GO
create procedure RegistrarProductoMasivo
   @data varchar(max) =''
as
begin
set nocount on

select top 0 CampaniaID, CUV, Descripcion,PrecioProducto,FactorRepeticion into #productoDescripcion from dbo.productoDescripcion
alter table #productoDescripcion alter column PrecioProducto varchar(20)
alter table #productoDescripcion alter column FactorRepeticion varchar(20)
select @data = 'select * from(values('''+ replace(replace(@data, '|', ''','''), '¬', '''),(''') +'''))t(a,b,c,d,e)'
insert into #productoDescripcion exec(@data)

select distinct * into #productoDescripcion2 from #productoDescripcion

delete tt from(
select idem = row_number()over(partition by CampaniaID, CUV order by item desc),* from(
select item = row_number()over(partition by CampaniaID, CUV order by CampaniaID, CUV), * from #productoDescripcion2
)t)tt where idem != 1

;merge into productoDescripcion t
using dbo.#productoDescripcion2 s
on (t.CampaniaID = s.CampaniaID and t.CUV = s.CUV)
when matched then
update set
    t.Descripcion        = isnull(nullif(s.Descripcion, ''), t.Descripcion),
    t.PrecioProducto     = isnull(nullif(s.PrecioProducto, ''), t.PrecioProducto),
    t.FactorRepeticion   = isnull(nullif(s.FactorRepeticion, ''), t.FactorRepeticion)
   -- t.RegaloDescripcion  = isnull(nullif(s.RegaloDescripcion, ''), t.RegaloDescripcion),
   -- t.RegaloImagenUrl    = isnull(nullif(s.RegaloImagenUrl, ''), t.RegaloImagenUrl)
when not matched then
insert(CampaniaID, CUV, Descripcion, PrecioProducto, FactorRepeticion, RegaloDescripcion, RegaloImagenUrl)
values(s.CampaniaID, s.CUV, s.Descripcion, s.PrecioProducto, s.FactorRepeticion, null, null);

select @@ROWCOUNT
end
go

USE BelcorpMexico
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[RegistrarProductoMasivo]') 
	AND type in (N'P', N'PC')
) 
DROP PROCEDURE [dbo].[RegistrarProductoMasivo]
GO
create procedure RegistrarProductoMasivo
   @data varchar(max) =''
as
begin
set nocount on

select top 0 CampaniaID, CUV, Descripcion,PrecioProducto,FactorRepeticion into #productoDescripcion from dbo.productoDescripcion
alter table #productoDescripcion alter column PrecioProducto varchar(20)
alter table #productoDescripcion alter column FactorRepeticion varchar(20)
select @data = 'select * from(values('''+ replace(replace(@data, '|', ''','''), '¬', '''),(''') +'''))t(a,b,c,d,e)'
insert into #productoDescripcion exec(@data)

select distinct * into #productoDescripcion2 from #productoDescripcion

delete tt from(
select idem = row_number()over(partition by CampaniaID, CUV order by item desc),* from(
select item = row_number()over(partition by CampaniaID, CUV order by CampaniaID, CUV), * from #productoDescripcion2
)t)tt where idem != 1

;merge into productoDescripcion t
using dbo.#productoDescripcion2 s
on (t.CampaniaID = s.CampaniaID and t.CUV = s.CUV)
when matched then
update set
    t.Descripcion        = isnull(nullif(s.Descripcion, ''), t.Descripcion),
    t.PrecioProducto     = isnull(nullif(s.PrecioProducto, ''), t.PrecioProducto),
    t.FactorRepeticion   = isnull(nullif(s.FactorRepeticion, ''), t.FactorRepeticion)
   -- t.RegaloDescripcion  = isnull(nullif(s.RegaloDescripcion, ''), t.RegaloDescripcion),
   -- t.RegaloImagenUrl    = isnull(nullif(s.RegaloImagenUrl, ''), t.RegaloImagenUrl)
when not matched then
insert(CampaniaID, CUV, Descripcion, PrecioProducto, FactorRepeticion, RegaloDescripcion, RegaloImagenUrl)
values(s.CampaniaID, s.CUV, s.Descripcion, s.PrecioProducto, s.FactorRepeticion, null, null);

select @@ROWCOUNT
end
go

USE BelcorpColombia
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[RegistrarProductoMasivo]') 
	AND type in (N'P', N'PC')
) 
DROP PROCEDURE [dbo].[RegistrarProductoMasivo]
GO
create procedure RegistrarProductoMasivo
   @data varchar(max) =''
as
begin
set nocount on

select top 0 CampaniaID, CUV, Descripcion,PrecioProducto,FactorRepeticion into #productoDescripcion from dbo.productoDescripcion
alter table #productoDescripcion alter column PrecioProducto varchar(20)
alter table #productoDescripcion alter column FactorRepeticion varchar(20)
select @data = 'select * from(values('''+ replace(replace(@data, '|', ''','''), '¬', '''),(''') +'''))t(a,b,c,d,e)'
insert into #productoDescripcion exec(@data)

select distinct * into #productoDescripcion2 from #productoDescripcion

delete tt from(
select idem = row_number()over(partition by CampaniaID, CUV order by item desc),* from(
select item = row_number()over(partition by CampaniaID, CUV order by CampaniaID, CUV), * from #productoDescripcion2
)t)tt where idem != 1

;merge into productoDescripcion t
using dbo.#productoDescripcion2 s
on (t.CampaniaID = s.CampaniaID and t.CUV = s.CUV)
when matched then
update set
    t.Descripcion        = isnull(nullif(s.Descripcion, ''), t.Descripcion),
    t.PrecioProducto     = isnull(nullif(s.PrecioProducto, ''), t.PrecioProducto),
    t.FactorRepeticion   = isnull(nullif(s.FactorRepeticion, ''), t.FactorRepeticion)
   -- t.RegaloDescripcion  = isnull(nullif(s.RegaloDescripcion, ''), t.RegaloDescripcion),
   -- t.RegaloImagenUrl    = isnull(nullif(s.RegaloImagenUrl, ''), t.RegaloImagenUrl)
when not matched then
insert(CampaniaID, CUV, Descripcion, PrecioProducto, FactorRepeticion, RegaloDescripcion, RegaloImagenUrl)
values(s.CampaniaID, s.CUV, s.Descripcion, s.PrecioProducto, s.FactorRepeticion, null, null);

select @@ROWCOUNT
end
go

USE BelcorpSalvador
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[RegistrarProductoMasivo]') 
	AND type in (N'P', N'PC')
) 
DROP PROCEDURE [dbo].[RegistrarProductoMasivo]
GO
create procedure RegistrarProductoMasivo
   @data varchar(max) =''
as
begin
set nocount on

select top 0 CampaniaID, CUV, Descripcion,PrecioProducto,FactorRepeticion into #productoDescripcion from dbo.productoDescripcion
alter table #productoDescripcion alter column PrecioProducto varchar(20)
alter table #productoDescripcion alter column FactorRepeticion varchar(20)
select @data = 'select * from(values('''+ replace(replace(@data, '|', ''','''), '¬', '''),(''') +'''))t(a,b,c,d,e)'
insert into #productoDescripcion exec(@data)

select distinct * into #productoDescripcion2 from #productoDescripcion

delete tt from(
select idem = row_number()over(partition by CampaniaID, CUV order by item desc),* from(
select item = row_number()over(partition by CampaniaID, CUV order by CampaniaID, CUV), * from #productoDescripcion2
)t)tt where idem != 1

;merge into productoDescripcion t
using dbo.#productoDescripcion2 s
on (t.CampaniaID = s.CampaniaID and t.CUV = s.CUV)
when matched then
update set
    t.Descripcion        = isnull(nullif(s.Descripcion, ''), t.Descripcion),
    t.PrecioProducto     = isnull(nullif(s.PrecioProducto, ''), t.PrecioProducto),
    t.FactorRepeticion   = isnull(nullif(s.FactorRepeticion, ''), t.FactorRepeticion)
   -- t.RegaloDescripcion  = isnull(nullif(s.RegaloDescripcion, ''), t.RegaloDescripcion),
   -- t.RegaloImagenUrl    = isnull(nullif(s.RegaloImagenUrl, ''), t.RegaloImagenUrl)
when not matched then
insert(CampaniaID, CUV, Descripcion, PrecioProducto, FactorRepeticion, RegaloDescripcion, RegaloImagenUrl)
values(s.CampaniaID, s.CUV, s.Descripcion, s.PrecioProducto, s.FactorRepeticion, null, null);

select @@ROWCOUNT
end
go

USE BelcorpPuertoRico
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[RegistrarProductoMasivo]') 
	AND type in (N'P', N'PC')
) 
DROP PROCEDURE [dbo].[RegistrarProductoMasivo]
GO
create procedure RegistrarProductoMasivo
   @data varchar(max) =''
as
begin
set nocount on

select top 0 CampaniaID, CUV, Descripcion,PrecioProducto,FactorRepeticion into #productoDescripcion from dbo.productoDescripcion
alter table #productoDescripcion alter column PrecioProducto varchar(20)
alter table #productoDescripcion alter column FactorRepeticion varchar(20)
select @data = 'select * from(values('''+ replace(replace(@data, '|', ''','''), '¬', '''),(''') +'''))t(a,b,c,d,e)'
insert into #productoDescripcion exec(@data)

select distinct * into #productoDescripcion2 from #productoDescripcion

delete tt from(
select idem = row_number()over(partition by CampaniaID, CUV order by item desc),* from(
select item = row_number()over(partition by CampaniaID, CUV order by CampaniaID, CUV), * from #productoDescripcion2
)t)tt where idem != 1

;merge into productoDescripcion t
using dbo.#productoDescripcion2 s
on (t.CampaniaID = s.CampaniaID and t.CUV = s.CUV)
when matched then
update set
    t.Descripcion        = isnull(nullif(s.Descripcion, ''), t.Descripcion),
    t.PrecioProducto     = isnull(nullif(s.PrecioProducto, ''), t.PrecioProducto),
    t.FactorRepeticion   = isnull(nullif(s.FactorRepeticion, ''), t.FactorRepeticion)
   -- t.RegaloDescripcion  = isnull(nullif(s.RegaloDescripcion, ''), t.RegaloDescripcion),
   -- t.RegaloImagenUrl    = isnull(nullif(s.RegaloImagenUrl, ''), t.RegaloImagenUrl)
when not matched then
insert(CampaniaID, CUV, Descripcion, PrecioProducto, FactorRepeticion, RegaloDescripcion, RegaloImagenUrl)
values(s.CampaniaID, s.CUV, s.Descripcion, s.PrecioProducto, s.FactorRepeticion, null, null);

select @@ROWCOUNT
end
go

USE BelcorpPanama
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[RegistrarProductoMasivo]') 
	AND type in (N'P', N'PC')
) 
DROP PROCEDURE [dbo].[RegistrarProductoMasivo]
GO
create procedure RegistrarProductoMasivo
   @data varchar(max) =''
as
begin
set nocount on

select top 0 CampaniaID, CUV, Descripcion,PrecioProducto,FactorRepeticion into #productoDescripcion from dbo.productoDescripcion
alter table #productoDescripcion alter column PrecioProducto varchar(20)
alter table #productoDescripcion alter column FactorRepeticion varchar(20)
select @data = 'select * from(values('''+ replace(replace(@data, '|', ''','''), '¬', '''),(''') +'''))t(a,b,c,d,e)'
insert into #productoDescripcion exec(@data)

select distinct * into #productoDescripcion2 from #productoDescripcion

delete tt from(
select idem = row_number()over(partition by CampaniaID, CUV order by item desc),* from(
select item = row_number()over(partition by CampaniaID, CUV order by CampaniaID, CUV), * from #productoDescripcion2
)t)tt where idem != 1

;merge into productoDescripcion t
using dbo.#productoDescripcion2 s
on (t.CampaniaID = s.CampaniaID and t.CUV = s.CUV)
when matched then
update set
    t.Descripcion        = isnull(nullif(s.Descripcion, ''), t.Descripcion),
    t.PrecioProducto     = isnull(nullif(s.PrecioProducto, ''), t.PrecioProducto),
    t.FactorRepeticion   = isnull(nullif(s.FactorRepeticion, ''), t.FactorRepeticion)
   -- t.RegaloDescripcion  = isnull(nullif(s.RegaloDescripcion, ''), t.RegaloDescripcion),
   -- t.RegaloImagenUrl    = isnull(nullif(s.RegaloImagenUrl, ''), t.RegaloImagenUrl)
when not matched then
insert(CampaniaID, CUV, Descripcion, PrecioProducto, FactorRepeticion, RegaloDescripcion, RegaloImagenUrl)
values(s.CampaniaID, s.CUV, s.Descripcion, s.PrecioProducto, s.FactorRepeticion, null, null);

select @@ROWCOUNT
end
go

USE BelcorpGuatemala
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[RegistrarProductoMasivo]') 
	AND type in (N'P', N'PC')
) 
DROP PROCEDURE [dbo].[RegistrarProductoMasivo]
GO
create procedure RegistrarProductoMasivo
   @data varchar(max) =''
as
begin
set nocount on

select top 0 CampaniaID, CUV, Descripcion,PrecioProducto,FactorRepeticion into #productoDescripcion from dbo.productoDescripcion
alter table #productoDescripcion alter column PrecioProducto varchar(20)
alter table #productoDescripcion alter column FactorRepeticion varchar(20)
select @data = 'select * from(values('''+ replace(replace(@data, '|', ''','''), '¬', '''),(''') +'''))t(a,b,c,d,e)'
insert into #productoDescripcion exec(@data)

select distinct * into #productoDescripcion2 from #productoDescripcion

delete tt from(
select idem = row_number()over(partition by CampaniaID, CUV order by item desc),* from(
select item = row_number()over(partition by CampaniaID, CUV order by CampaniaID, CUV), * from #productoDescripcion2
)t)tt where idem != 1

;merge into productoDescripcion t
using dbo.#productoDescripcion2 s
on (t.CampaniaID = s.CampaniaID and t.CUV = s.CUV)
when matched then
update set
    t.Descripcion        = isnull(nullif(s.Descripcion, ''), t.Descripcion),
    t.PrecioProducto     = isnull(nullif(s.PrecioProducto, ''), t.PrecioProducto),
    t.FactorRepeticion   = isnull(nullif(s.FactorRepeticion, ''), t.FactorRepeticion)
   -- t.RegaloDescripcion  = isnull(nullif(s.RegaloDescripcion, ''), t.RegaloDescripcion),
   -- t.RegaloImagenUrl    = isnull(nullif(s.RegaloImagenUrl, ''), t.RegaloImagenUrl)
when not matched then
insert(CampaniaID, CUV, Descripcion, PrecioProducto, FactorRepeticion, RegaloDescripcion, RegaloImagenUrl)
values(s.CampaniaID, s.CUV, s.Descripcion, s.PrecioProducto, s.FactorRepeticion, null, null);

select @@ROWCOUNT
end
go

USE BelcorpEcuador
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[RegistrarProductoMasivo]') 
	AND type in (N'P', N'PC')
) 
DROP PROCEDURE [dbo].[RegistrarProductoMasivo]
GO
create procedure RegistrarProductoMasivo
   @data varchar(max) =''
as
begin
set nocount on

select top 0 CampaniaID, CUV, Descripcion,PrecioProducto,FactorRepeticion into #productoDescripcion from dbo.productoDescripcion
alter table #productoDescripcion alter column PrecioProducto varchar(20)
alter table #productoDescripcion alter column FactorRepeticion varchar(20)
select @data = 'select * from(values('''+ replace(replace(@data, '|', ''','''), '¬', '''),(''') +'''))t(a,b,c,d,e)'
insert into #productoDescripcion exec(@data)

select distinct * into #productoDescripcion2 from #productoDescripcion

delete tt from(
select idem = row_number()over(partition by CampaniaID, CUV order by item desc),* from(
select item = row_number()over(partition by CampaniaID, CUV order by CampaniaID, CUV), * from #productoDescripcion2
)t)tt where idem != 1

;merge into productoDescripcion t
using dbo.#productoDescripcion2 s
on (t.CampaniaID = s.CampaniaID and t.CUV = s.CUV)
when matched then
update set
    t.Descripcion        = isnull(nullif(s.Descripcion, ''), t.Descripcion),
    t.PrecioProducto     = isnull(nullif(s.PrecioProducto, ''), t.PrecioProducto),
    t.FactorRepeticion   = isnull(nullif(s.FactorRepeticion, ''), t.FactorRepeticion)
   -- t.RegaloDescripcion  = isnull(nullif(s.RegaloDescripcion, ''), t.RegaloDescripcion),
   -- t.RegaloImagenUrl    = isnull(nullif(s.RegaloImagenUrl, ''), t.RegaloImagenUrl)
when not matched then
insert(CampaniaID, CUV, Descripcion, PrecioProducto, FactorRepeticion, RegaloDescripcion, RegaloImagenUrl)
values(s.CampaniaID, s.CUV, s.Descripcion, s.PrecioProducto, s.FactorRepeticion, null, null);

select @@ROWCOUNT
end
go

USE BelcorpDominicana
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[RegistrarProductoMasivo]') 
	AND type in (N'P', N'PC')
) 
DROP PROCEDURE [dbo].[RegistrarProductoMasivo]
GO
create procedure RegistrarProductoMasivo
   @data varchar(max) =''
as
begin
set nocount on

select top 0 CampaniaID, CUV, Descripcion,PrecioProducto,FactorRepeticion into #productoDescripcion from dbo.productoDescripcion
alter table #productoDescripcion alter column PrecioProducto varchar(20)
alter table #productoDescripcion alter column FactorRepeticion varchar(20)
select @data = 'select * from(values('''+ replace(replace(@data, '|', ''','''), '¬', '''),(''') +'''))t(a,b,c,d,e)'
insert into #productoDescripcion exec(@data)

select distinct * into #productoDescripcion2 from #productoDescripcion

delete tt from(
select idem = row_number()over(partition by CampaniaID, CUV order by item desc),* from(
select item = row_number()over(partition by CampaniaID, CUV order by CampaniaID, CUV), * from #productoDescripcion2
)t)tt where idem != 1

;merge into productoDescripcion t
using dbo.#productoDescripcion2 s
on (t.CampaniaID = s.CampaniaID and t.CUV = s.CUV)
when matched then
update set
    t.Descripcion        = isnull(nullif(s.Descripcion, ''), t.Descripcion),
    t.PrecioProducto     = isnull(nullif(s.PrecioProducto, ''), t.PrecioProducto),
    t.FactorRepeticion   = isnull(nullif(s.FactorRepeticion, ''), t.FactorRepeticion)
   -- t.RegaloDescripcion  = isnull(nullif(s.RegaloDescripcion, ''), t.RegaloDescripcion),
   -- t.RegaloImagenUrl    = isnull(nullif(s.RegaloImagenUrl, ''), t.RegaloImagenUrl)
when not matched then
insert(CampaniaID, CUV, Descripcion, PrecioProducto, FactorRepeticion, RegaloDescripcion, RegaloImagenUrl)
values(s.CampaniaID, s.CUV, s.Descripcion, s.PrecioProducto, s.FactorRepeticion, null, null);

select @@ROWCOUNT
end
go

USE BelcorpCostaRica
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[RegistrarProductoMasivo]') 
	AND type in (N'P', N'PC')
) 
DROP PROCEDURE [dbo].[RegistrarProductoMasivo]
GO
create procedure RegistrarProductoMasivo
   @data varchar(max) =''
as
begin
set nocount on

select top 0 CampaniaID, CUV, Descripcion,PrecioProducto,FactorRepeticion into #productoDescripcion from dbo.productoDescripcion
alter table #productoDescripcion alter column PrecioProducto varchar(20)
alter table #productoDescripcion alter column FactorRepeticion varchar(20)
select @data = 'select * from(values('''+ replace(replace(@data, '|', ''','''), '¬', '''),(''') +'''))t(a,b,c,d,e)'
insert into #productoDescripcion exec(@data)

select distinct * into #productoDescripcion2 from #productoDescripcion

delete tt from(
select idem = row_number()over(partition by CampaniaID, CUV order by item desc),* from(
select item = row_number()over(partition by CampaniaID, CUV order by CampaniaID, CUV), * from #productoDescripcion2
)t)tt where idem != 1

;merge into productoDescripcion t
using dbo.#productoDescripcion2 s
on (t.CampaniaID = s.CampaniaID and t.CUV = s.CUV)
when matched then
update set
    t.Descripcion        = isnull(nullif(s.Descripcion, ''), t.Descripcion),
    t.PrecioProducto     = isnull(nullif(s.PrecioProducto, ''), t.PrecioProducto),
    t.FactorRepeticion   = isnull(nullif(s.FactorRepeticion, ''), t.FactorRepeticion)
   -- t.RegaloDescripcion  = isnull(nullif(s.RegaloDescripcion, ''), t.RegaloDescripcion),
   -- t.RegaloImagenUrl    = isnull(nullif(s.RegaloImagenUrl, ''), t.RegaloImagenUrl)
when not matched then
insert(CampaniaID, CUV, Descripcion, PrecioProducto, FactorRepeticion, RegaloDescripcion, RegaloImagenUrl)
values(s.CampaniaID, s.CUV, s.Descripcion, s.PrecioProducto, s.FactorRepeticion, null, null);

select @@ROWCOUNT
end
go

USE BelcorpChile
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[RegistrarProductoMasivo]') 
	AND type in (N'P', N'PC')
) 
DROP PROCEDURE [dbo].[RegistrarProductoMasivo]
GO
create procedure RegistrarProductoMasivo
   @data varchar(max) =''
as
begin
set nocount on

select top 0 CampaniaID, CUV, Descripcion,PrecioProducto,FactorRepeticion into #productoDescripcion from dbo.productoDescripcion
alter table #productoDescripcion alter column PrecioProducto varchar(20)
alter table #productoDescripcion alter column FactorRepeticion varchar(20)
select @data = 'select * from(values('''+ replace(replace(@data, '|', ''','''), '¬', '''),(''') +'''))t(a,b,c,d,e)'
insert into #productoDescripcion exec(@data)

select distinct * into #productoDescripcion2 from #productoDescripcion

delete tt from(
select idem = row_number()over(partition by CampaniaID, CUV order by item desc),* from(
select item = row_number()over(partition by CampaniaID, CUV order by CampaniaID, CUV), * from #productoDescripcion2
)t)tt where idem != 1

;merge into productoDescripcion t
using dbo.#productoDescripcion2 s
on (t.CampaniaID = s.CampaniaID and t.CUV = s.CUV)
when matched then
update set
    t.Descripcion        = isnull(nullif(s.Descripcion, ''), t.Descripcion),
    t.PrecioProducto     = isnull(nullif(s.PrecioProducto, ''), t.PrecioProducto),
    t.FactorRepeticion   = isnull(nullif(s.FactorRepeticion, ''), t.FactorRepeticion)
   -- t.RegaloDescripcion  = isnull(nullif(s.RegaloDescripcion, ''), t.RegaloDescripcion),
   -- t.RegaloImagenUrl    = isnull(nullif(s.RegaloImagenUrl, ''), t.RegaloImagenUrl)
when not matched then
insert(CampaniaID, CUV, Descripcion, PrecioProducto, FactorRepeticion, RegaloDescripcion, RegaloImagenUrl)
values(s.CampaniaID, s.CUV, s.Descripcion, s.PrecioProducto, s.FactorRepeticion, null, null);

select @@ROWCOUNT
end
go

USE BelcorpBolivia
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[RegistrarProductoMasivo]') 
	AND type in (N'P', N'PC')
) 
DROP PROCEDURE [dbo].[RegistrarProductoMasivo]
GO
create procedure RegistrarProductoMasivo
   @data varchar(max) =''
as
begin
set nocount on

select top 0 CampaniaID, CUV, Descripcion,PrecioProducto,FactorRepeticion into #productoDescripcion from dbo.productoDescripcion
alter table #productoDescripcion alter column PrecioProducto varchar(20)
alter table #productoDescripcion alter column FactorRepeticion varchar(20)
select @data = 'select * from(values('''+ replace(replace(@data, '|', ''','''), '¬', '''),(''') +'''))t(a,b,c,d,e)'
insert into #productoDescripcion exec(@data)

select distinct * into #productoDescripcion2 from #productoDescripcion

delete tt from(
select idem = row_number()over(partition by CampaniaID, CUV order by item desc),* from(
select item = row_number()over(partition by CampaniaID, CUV order by CampaniaID, CUV), * from #productoDescripcion2
)t)tt where idem != 1

;merge into productoDescripcion t
using dbo.#productoDescripcion2 s
on (t.CampaniaID = s.CampaniaID and t.CUV = s.CUV)
when matched then
update set
    t.Descripcion        = isnull(nullif(s.Descripcion, ''), t.Descripcion),
    t.PrecioProducto     = isnull(nullif(s.PrecioProducto, ''), t.PrecioProducto),
    t.FactorRepeticion   = isnull(nullif(s.FactorRepeticion, ''), t.FactorRepeticion)
   -- t.RegaloDescripcion  = isnull(nullif(s.RegaloDescripcion, ''), t.RegaloDescripcion),
   -- t.RegaloImagenUrl    = isnull(nullif(s.RegaloImagenUrl, ''), t.RegaloImagenUrl)
when not matched then
insert(CampaniaID, CUV, Descripcion, PrecioProducto, FactorRepeticion, RegaloDescripcion, RegaloImagenUrl)
values(s.CampaniaID, s.CUV, s.Descripcion, s.PrecioProducto, s.FactorRepeticion, null, null);

select @@ROWCOUNT
end
go

