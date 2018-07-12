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
CREATE PROCEDURE RegistrarProductoMasivo
   @data varchar(max) =''
as
begin
set nocount on

select top 0 null cta, CampaniaID, CUV, Descripcion,PrecioProducto,FactorRepeticion into #productoDescripcion from dbo.productoDescripcion
alter table #productoDescripcion alter column PrecioProducto varchar(20)
alter table #productoDescripcion alter column FactorRepeticion varchar(20)
select @data =REPLACE(@data,'''', '''''');

select @data = 'select row_number()over(order by (select 0)), * from(values('''+ replace(replace(@data, '|', ''','''), '¬', '''),(''') +'''))t(a,b,c,d,e)'
insert into #productoDescripcion exec(@data)

;merge into productoDescripcion t
using(select * from(select item = row_number()over(partition by CampaniaID, CUV order by cta desc), * from #productoDescripcion)t where item = 1) s
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
GO

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
CREATE PROCEDURE RegistrarProductoMasivo
   @data varchar(max) =''
as
begin
set nocount on

select top 0 null cta, CampaniaID, CUV, Descripcion,PrecioProducto,FactorRepeticion into #productoDescripcion from dbo.productoDescripcion
alter table #productoDescripcion alter column PrecioProducto varchar(20)
alter table #productoDescripcion alter column FactorRepeticion varchar(20)
select @data =REPLACE(@data,'''', '''''');

select @data = 'select row_number()over(order by (select 0)), * from(values('''+ replace(replace(@data, '|', ''','''), '¬', '''),(''') +'''))t(a,b,c,d,e)'
insert into #productoDescripcion exec(@data)

;merge into productoDescripcion t
using(select * from(select item = row_number()over(partition by CampaniaID, CUV order by cta desc), * from #productoDescripcion)t where item = 1) s
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
GO

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
CREATE PROCEDURE RegistrarProductoMasivo
   @data varchar(max) =''
as
begin
set nocount on

select top 0 null cta, CampaniaID, CUV, Descripcion,PrecioProducto,FactorRepeticion into #productoDescripcion from dbo.productoDescripcion
alter table #productoDescripcion alter column PrecioProducto varchar(20)
alter table #productoDescripcion alter column FactorRepeticion varchar(20)
select @data =REPLACE(@data,'''', '''''');

select @data = 'select row_number()over(order by (select 0)), * from(values('''+ replace(replace(@data, '|', ''','''), '¬', '''),(''') +'''))t(a,b,c,d,e)'
insert into #productoDescripcion exec(@data)

;merge into productoDescripcion t
using(select * from(select item = row_number()over(partition by CampaniaID, CUV order by cta desc), * from #productoDescripcion)t where item = 1) s
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
GO

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
CREATE PROCEDURE RegistrarProductoMasivo
   @data varchar(max) =''
as
begin
set nocount on

select top 0 null cta, CampaniaID, CUV, Descripcion,PrecioProducto,FactorRepeticion into #productoDescripcion from dbo.productoDescripcion
alter table #productoDescripcion alter column PrecioProducto varchar(20)
alter table #productoDescripcion alter column FactorRepeticion varchar(20)
select @data =REPLACE(@data,'''', '''''');

select @data = 'select row_number()over(order by (select 0)), * from(values('''+ replace(replace(@data, '|', ''','''), '¬', '''),(''') +'''))t(a,b,c,d,e)'
insert into #productoDescripcion exec(@data)

;merge into productoDescripcion t
using(select * from(select item = row_number()over(partition by CampaniaID, CUV order by cta desc), * from #productoDescripcion)t where item = 1) s
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
GO

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
CREATE PROCEDURE RegistrarProductoMasivo
   @data varchar(max) =''
as
begin
set nocount on

select top 0 null cta, CampaniaID, CUV, Descripcion,PrecioProducto,FactorRepeticion into #productoDescripcion from dbo.productoDescripcion
alter table #productoDescripcion alter column PrecioProducto varchar(20)
alter table #productoDescripcion alter column FactorRepeticion varchar(20)
select @data =REPLACE(@data,'''', '''''');

select @data = 'select row_number()over(order by (select 0)), * from(values('''+ replace(replace(@data, '|', ''','''), '¬', '''),(''') +'''))t(a,b,c,d,e)'
insert into #productoDescripcion exec(@data)

;merge into productoDescripcion t
using(select * from(select item = row_number()over(partition by CampaniaID, CUV order by cta desc), * from #productoDescripcion)t where item = 1) s
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
GO

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
CREATE PROCEDURE RegistrarProductoMasivo
   @data varchar(max) =''
as
begin
set nocount on

select top 0 null cta, CampaniaID, CUV, Descripcion,PrecioProducto,FactorRepeticion into #productoDescripcion from dbo.productoDescripcion
alter table #productoDescripcion alter column PrecioProducto varchar(20)
alter table #productoDescripcion alter column FactorRepeticion varchar(20)
select @data =REPLACE(@data,'''', '''''');

select @data = 'select row_number()over(order by (select 0)), * from(values('''+ replace(replace(@data, '|', ''','''), '¬', '''),(''') +'''))t(a,b,c,d,e)'
insert into #productoDescripcion exec(@data)

;merge into productoDescripcion t
using(select * from(select item = row_number()over(partition by CampaniaID, CUV order by cta desc), * from #productoDescripcion)t where item = 1) s
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
GO

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
CREATE PROCEDURE RegistrarProductoMasivo
   @data varchar(max) =''
as
begin
set nocount on

select top 0 null cta, CampaniaID, CUV, Descripcion,PrecioProducto,FactorRepeticion into #productoDescripcion from dbo.productoDescripcion
alter table #productoDescripcion alter column PrecioProducto varchar(20)
alter table #productoDescripcion alter column FactorRepeticion varchar(20)
select @data =REPLACE(@data,'''', '''''');

select @data = 'select row_number()over(order by (select 0)), * from(values('''+ replace(replace(@data, '|', ''','''), '¬', '''),(''') +'''))t(a,b,c,d,e)'
insert into #productoDescripcion exec(@data)

;merge into productoDescripcion t
using(select * from(select item = row_number()over(partition by CampaniaID, CUV order by cta desc), * from #productoDescripcion)t where item = 1) s
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
GO

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
CREATE PROCEDURE RegistrarProductoMasivo
   @data varchar(max) =''
as
begin
set nocount on

select top 0 null cta, CampaniaID, CUV, Descripcion,PrecioProducto,FactorRepeticion into #productoDescripcion from dbo.productoDescripcion
alter table #productoDescripcion alter column PrecioProducto varchar(20)
alter table #productoDescripcion alter column FactorRepeticion varchar(20)
select @data =REPLACE(@data,'''', '''''');

select @data = 'select row_number()over(order by (select 0)), * from(values('''+ replace(replace(@data, '|', ''','''), '¬', '''),(''') +'''))t(a,b,c,d,e)'
insert into #productoDescripcion exec(@data)

;merge into productoDescripcion t
using(select * from(select item = row_number()over(partition by CampaniaID, CUV order by cta desc), * from #productoDescripcion)t where item = 1) s
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
GO

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
CREATE PROCEDURE RegistrarProductoMasivo
   @data varchar(max) =''
as
begin
set nocount on

select top 0 null cta, CampaniaID, CUV, Descripcion,PrecioProducto,FactorRepeticion into #productoDescripcion from dbo.productoDescripcion
alter table #productoDescripcion alter column PrecioProducto varchar(20)
alter table #productoDescripcion alter column FactorRepeticion varchar(20)
select @data =REPLACE(@data,'''', '''''');

select @data = 'select row_number()over(order by (select 0)), * from(values('''+ replace(replace(@data, '|', ''','''), '¬', '''),(''') +'''))t(a,b,c,d,e)'
insert into #productoDescripcion exec(@data)

;merge into productoDescripcion t
using(select * from(select item = row_number()over(partition by CampaniaID, CUV order by cta desc), * from #productoDescripcion)t where item = 1) s
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
GO

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
CREATE PROCEDURE RegistrarProductoMasivo
   @data varchar(max) =''
as
begin
set nocount on

select top 0 null cta, CampaniaID, CUV, Descripcion,PrecioProducto,FactorRepeticion into #productoDescripcion from dbo.productoDescripcion
alter table #productoDescripcion alter column PrecioProducto varchar(20)
alter table #productoDescripcion alter column FactorRepeticion varchar(20)
select @data =REPLACE(@data,'''', '''''');

select @data = 'select row_number()over(order by (select 0)), * from(values('''+ replace(replace(@data, '|', ''','''), '¬', '''),(''') +'''))t(a,b,c,d,e)'
insert into #productoDescripcion exec(@data)

;merge into productoDescripcion t
using(select * from(select item = row_number()over(partition by CampaniaID, CUV order by cta desc), * from #productoDescripcion)t where item = 1) s
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
GO

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
CREATE PROCEDURE RegistrarProductoMasivo
   @data varchar(max) =''
as
begin
set nocount on

select top 0 null cta, CampaniaID, CUV, Descripcion,PrecioProducto,FactorRepeticion into #productoDescripcion from dbo.productoDescripcion
alter table #productoDescripcion alter column PrecioProducto varchar(20)
alter table #productoDescripcion alter column FactorRepeticion varchar(20)
select @data =REPLACE(@data,'''', '''''');

select @data = 'select row_number()over(order by (select 0)), * from(values('''+ replace(replace(@data, '|', ''','''), '¬', '''),(''') +'''))t(a,b,c,d,e)'
insert into #productoDescripcion exec(@data)

;merge into productoDescripcion t
using(select * from(select item = row_number()over(partition by CampaniaID, CUV order by cta desc), * from #productoDescripcion)t where item = 1) s
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
GO

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
CREATE PROCEDURE RegistrarProductoMasivo
   @data varchar(max) =''
as
begin
set nocount on

select top 0 null cta, CampaniaID, CUV, Descripcion,PrecioProducto,FactorRepeticion into #productoDescripcion from dbo.productoDescripcion
alter table #productoDescripcion alter column PrecioProducto varchar(20)
alter table #productoDescripcion alter column FactorRepeticion varchar(20)
select @data =REPLACE(@data,'''', '''''');

select @data = 'select row_number()over(order by (select 0)), * from(values('''+ replace(replace(@data, '|', ''','''), '¬', '''),(''') +'''))t(a,b,c,d,e)'
insert into #productoDescripcion exec(@data)

;merge into productoDescripcion t
using(select * from(select item = row_number()over(partition by CampaniaID, CUV order by cta desc), * from #productoDescripcion)t where item = 1) s
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
GO