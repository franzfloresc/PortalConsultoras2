USE [BelcorpBolivia]
GO
/****** Object:  StoredProcedure [dbo].[GetFADDescargaInformacion]    Script Date: 14/08/2018 15:33:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[GetFADDescargaInformacion]
as 

declare @FechaFact date
declare @fechaFact_ date
set @FechaFact = cast(getdate() as date)

set @FechaFact_ = cast(getdate() -1 as date)

declare @PedidosEnviados table
(
	CampaniaId int,
	ConsultoraId bigint
)

insert into @PedidosEnviados
select CampaniaId, ConsultoraId
from PedidoWeb with(nolock)
where IndicadorEnviado = 1 and cast(FechaProceso as date) = @FechaFact

declare @tempFAD table
(
	LogIngresoFADId bigint
)
insert into @tempFAD
select max(fad.LogIngresoFADId) as LogIngresoFADId
from [dbo].[LogIngresoFAD] fad with(nolock)
inner join @PedidosEnviados pe on fad.CampaniaId = pe.CampaniaId and fad.ConsultoraId = pe.ConsultoraId
group by fad.CampaniaID, fad.ConsultoraID, fad.cuv

declare @tempProl table
(
	PedidoWebAccionesPROLID bigint
)
insert into @tempProl
select max(PedidoWebAccionesPROLID) as PedidoWebAccionesPROLID
from [dbo].[PedidoWebAccionesPROL] acc with(nolock)
inner hash join @PedidosEnviados pe on acc.CampaniaId = pe.CampaniaId and acc.ConsultoraId = pe.ConsultoraId
where (charindex('stock',acc.MensajePROL) > 0 or charindex('agotado',acc.MensajePROL)>0)
group by acc.CampaniaID, acc.PedidoID, acc.ConsultoraID, acc.CUV

select 'BO03' as centro,campaniaid,FechaRegistro,codigoproducto,codigotipooferta,sum(cantidad) as cantidad, sum(PrecioUnidad) as total
from (
select fad.campaniaid, @FechaFact_ as FechaRegistro,pr.codigoproducto,pr.codigotipooferta,
fad.cantidad*pr.FactorRepeticion as cantidad, fad.cantidad * fad.PrecioUnidad as PrecioUnidad
from [dbo].[LogIngresoFAD] fad with(nolock)
inner join @tempFAD tf on fad.LogIngresoFADId = tf.LogIngresoFADId
inner join ods.campania ca with(nolock) on fad.campaniaid = ca.codigo
inner join ods.productocomercial pr with(nolock) on ca.campaniaid = pr.campaniaid and fad.cuv = pr.cuv
UNION ALL
select acc.CampaniaID, @FechaFact_ as FechaRegistro,pr.codigoproducto,pr.codigotipooferta,
acc.cantidad*pr.FactorRepeticion as cantidad, acc.cantidad * acc.PrecioUnidad as PrecioUnidad
from [dbo].[PedidoWebAccionesPROL] acc with(nolock)
inner join @tempProl tp on acc.PedidoWebAccionesPROLID = tp.PedidoWebAccionesPROLID
inner join ods.campania ca with(nolock) on acc.campaniaid = ca.codigo
inner join ods.productocomercial pr with(nolock) on ca.campaniaid = pr.campaniaid and acc.cuv = pr.cuv
) r
group by campaniaid, FechaRegistro,codigoproducto,codigotipooferta
order by campaniaid, FechaRegistro, codigoproducto
GO

USE [BelcorpChile]
GO
/****** Object:  StoredProcedure [dbo].[GetFADDescargaInformacion]    Script Date: 14/08/2018 15:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[GetFADDescargaInformacion]
as
declare @FechaFact date

declare @fechaFact_ date


--set @FechaFact = cast(getdate()-1 as date)

set @FechaFact = cast(getdate() as date)

set @FechaFact_ = cast(getdate() -1 as date)

declare @PedidosEnviados table
(
CampaniaId int,
ConsultoraId bigint
)
insert into @PedidosEnviados
select CampaniaId, ConsultoraId
from PedidoWeb with(nolock)
where IndicadorEnviado = 1 and cast(FechaProceso as date) = @FechaFact
declare @tempFAD table
(
LogIngresoFADId bigint
)
insert into @tempFAD
select max(fad.LogIngresoFADId) as LogIngresoFADId
from [dbo].[LogIngresoFAD] fad with(nolock)
inner join @PedidosEnviados pe on fad.CampaniaId = pe.CampaniaId and fad.ConsultoraId = pe.ConsultoraId
group by fad.CampaniaID, fad.ConsultoraID, fad.cuv
declare @tempProl table
(
PedidoWebAccionesPROLID bigint
)
insert into @tempProl
select max(PedidoWebAccionesPROLID) as PedidoWebAccionesPROLID
from [dbo].[PedidoWebAccionesPROL] acc with(nolock)
inner join @PedidosEnviados pe on acc.CampaniaId = pe.CampaniaId and acc.ConsultoraId = pe.ConsultoraId
where (charindex('stock',acc.MensajePROL) > 0 or charindex('agotado',acc.MensajePROL)>0)
group by acc.CampaniaID, acc.PedidoID, acc.ConsultoraID, acc.CUV

select 'CL03' as centro,campaniaid,FechaRegistro,codigoproducto,codigotipooferta,sum(cantidad) as cantidad, sum(PrecioUnidad) as total
from (
select fad.campaniaid, @FechaFact_ as FechaRegistro,pr.codigoproducto,pr.codigotipooferta,
fad.cantidad*pr.FactorRepeticion as cantidad, fad.cantidad * fad.PrecioUnidad as PrecioUnidad
from [dbo].[LogIngresoFAD] fad with(nolock)
inner join @tempFAD tf on fad.LogIngresoFADId = tf.LogIngresoFADId
inner join ods.campania ca with(nolock) on fad.campaniaid = ca.codigo
inner join ods.productocomercial pr with(nolock) on ca.campaniaid = pr.campaniaid and fad.cuv = pr.cuv
UNION ALL
select acc.CampaniaID, @FechaFact_ as FechaRegistro,pr.codigoproducto,pr.codigotipooferta,
acc.cantidad*pr.FactorRepeticion as cantidad, acc.cantidad * acc.PrecioUnidad as PrecioUnidad
from [dbo].[PedidoWebAccionesPROL] acc with(nolock)
inner join @tempProl tp on acc.PedidoWebAccionesPROLID = tp.PedidoWebAccionesPROLID
inner join ods.campania ca with(nolock) on acc.campaniaid = ca.codigo
inner join ods.productocomercial pr with(nolock) on ca.campaniaid = pr.campaniaid and acc.cuv = pr.cuv
) r
group by campaniaid, FechaRegistro,codigoproducto,codigotipooferta
order by campaniaid, FechaRegistro, codigoproducto
GO

USE [BelcorpColombia]
GO
/****** Object:  StoredProcedure [dbo].[GetFADDescargaInformacion]    Script Date: 14/08/2018 15:39:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[GetFADDescargaInformacion]
as
declare @FechaFact date
set @FechaFact = cast(getdate()-1 as date)
declare @PedidosEnviados table
(
CampaniaId int,
ConsultoraId bigint
)
insert into @PedidosEnviados
select CampaniaId, ConsultoraId
from PedidoWeb with(nolock)
where IndicadorEnviado = 1 and cast(FechaProceso as date) = @FechaFact
declare @tempFAD table
(
LogIngresoFADId bigint
)
insert into @tempFAD
select max(fad.LogIngresoFADId) as LogIngresoFADId
from [dbo].[LogIngresoFAD] fad with(nolock)
inner join @PedidosEnviados pe on fad.CampaniaId = pe.CampaniaId and fad.ConsultoraId = pe.ConsultoraId
group by fad.CampaniaID, fad.ConsultoraID, fad.cuv

declare @tempProl table
(
PedidoWebAccionesPROLID bigint
)
insert into @tempProl
select max(PedidoWebAccionesPROLID) as PedidoWebAccionesPROLID
from [dbo].[PedidoWebAccionesPROL] acc with(nolock)
inner hash join @PedidosEnviados pe on acc.CampaniaId = pe.CampaniaId and acc.ConsultoraId = pe.ConsultoraId
where (charindex('stock',acc.MensajePROL) > 0 or charindex('agotado',acc.MensajePROL)>0) and charindex('al pack',acc.MensajePROL)=0 and charindex('del pack',acc.MensajePROL)=0
group by acc.CampaniaID, acc.PedidoID, acc.ConsultoraID, acc.CUV

select 'CO03' as centro,campaniaid,FechaRegistro,codigoproducto,codigotipooferta,sum(cantidad) as cantidad, sum(PrecioUnidad) as total
from (
select fad.campaniaid, @FechaFact as FechaRegistro,pr.codigoproducto,pr.codigotipooferta,
fad.cantidad*pr.FactorRepeticion as cantidad, fad.cantidad * fad.PrecioUnidad as PrecioUnidad
from [dbo].[LogIngresoFAD] fad with(nolock)
inner join @tempFAD tf on fad.LogIngresoFADId = tf.LogIngresoFADId
inner join ods.campania ca with(nolock) on fad.campaniaid = ca.codigo
inner join ods.productocomercial pr with(nolock) on ca.campaniaid = pr.campaniaid and fad.cuv = pr.cuv
UNION ALL
select acc.CampaniaID, @FechaFact as FechaRegistro,pr.codigoproducto,pr.codigotipooferta,
acc.cantidad*pr.FactorRepeticion as cantidad, acc.cantidad * acc.PrecioUnidad as PrecioUnidad
from [dbo].[PedidoWebAccionesPROL] acc with(nolock)
inner join @tempProl tp on acc.PedidoWebAccionesPROLID = tp.PedidoWebAccionesPROLID
inner join ods.campania ca with(nolock) on acc.campaniaid = ca.codigo
inner join ods.productocomercial pr with(nolock) on ca.campaniaid = pr.campaniaid and acc.cuv = pr.cuv
) r
group by campaniaid, FechaRegistro,codigoproducto,codigotipooferta
order by campaniaid, FechaRegistro, codigoproducto
GO

USE [BelcorpCostaRica]
GO
/****** Object:  StoredProcedure [dbo].[GetFADDescargaInformacion]    Script Date: 14/08/2018 15:41:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER procedure [dbo].[GetFADDescargaInformacion]
as 

declare @FechaFact date
set @FechaFact = cast(getdate()-1 as date)

declare @PedidosEnviados table
(
	CampaniaId int,
	ConsultoraId bigint
)

insert into @PedidosEnviados
select CampaniaId, ConsultoraId
from PedidoWeb with(nolock)
where IndicadorEnviado = 1 and cast(FechaProceso as date) = @FechaFact

declare @tempFAD table
(
	LogIngresoFADId bigint
)
insert into @tempFAD
select max(fad.LogIngresoFADId) as LogIngresoFADId
from [dbo].[LogIngresoFAD] fad with(nolock)
inner join @PedidosEnviados pe on fad.CampaniaId = pe.CampaniaId and fad.ConsultoraId = pe.ConsultoraId
group by fad.CampaniaID, fad.ConsultoraID, fad.cuv

declare @tempProl table
(
	PedidoWebAccionesPROLID bigint
)
insert into @tempProl
select max(PedidoWebAccionesPROLID) as PedidoWebAccionesPROLID
from [dbo].[PedidoWebAccionesPROL] acc with(nolock)
inner join @PedidosEnviados pe on acc.CampaniaId = pe.CampaniaId and acc.ConsultoraId = pe.ConsultoraId
where (charindex('stock',acc.MensajePROL) > 0 or charindex('agotado',acc.MensajePROL)>0)
group by acc.CampaniaID, acc.PedidoID, acc.ConsultoraID, acc.CUV

select 'CR03' as centro,campaniaid,FechaRegistro,codigoproducto,codigotipooferta,sum(cantidad) as cantidad, sum(PrecioUnidad) as total
from (
select fad.campaniaid, @FechaFact as FechaRegistro,pr.codigoproducto,pr.codigotipooferta,
fad.cantidad*pr.FactorRepeticion as cantidad, fad.cantidad * fad.PrecioUnidad as PrecioUnidad
from [dbo].[LogIngresoFAD] fad with(nolock)
inner join @tempFAD tf on fad.LogIngresoFADId = tf.LogIngresoFADId
inner join ods.campania ca with(nolock) on fad.campaniaid = ca.codigo
inner join ods.productocomercial pr with(nolock) on ca.campaniaid = pr.campaniaid and fad.cuv = pr.cuv
UNION ALL
select acc.CampaniaID, @FechaFact as FechaRegistro,pr.codigoproducto,pr.codigotipooferta,
acc.cantidad*pr.FactorRepeticion as cantidad, acc.cantidad * acc.PrecioUnidad as PrecioUnidad
from [dbo].[PedidoWebAccionesPROL] acc with(nolock)
inner join @tempProl tp on acc.PedidoWebAccionesPROLID = tp.PedidoWebAccionesPROLID
inner join ods.campania ca with(nolock) on acc.campaniaid = ca.codigo
inner join ods.productocomercial pr with(nolock) on ca.campaniaid = pr.campaniaid and acc.cuv = pr.cuv
) r
group by campaniaid, FechaRegistro,codigoproducto,codigotipooferta
order by campaniaid, FechaRegistro, codigoproducto
GO

USE [BelcorpDominicana]
GO
/****** Object:  StoredProcedure [dbo].[GetFADDescargaInformacion]    Script Date: 14/08/2018 15:43:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER procedure [dbo].[GetFADDescargaInformacion]
as 

declare @FechaFact date
set @FechaFact = cast(getdate()-1 as date)

declare @PedidosEnviados table
(
	CampaniaId int,
	ConsultoraId bigint
)

insert into @PedidosEnviados
select CampaniaId, ConsultoraId
from PedidoWeb with(nolock)
where IndicadorEnviado = 1 and cast(FechaProceso as date) = @FechaFact

declare @tempFAD table
(
	LogIngresoFADId bigint
)
insert into @tempFAD
select max(fad.LogIngresoFADId) as LogIngresoFADId
from [dbo].[LogIngresoFAD] fad with(nolock)
inner join @PedidosEnviados pe on fad.CampaniaId = pe.CampaniaId and fad.ConsultoraId = pe.ConsultoraId
group by fad.CampaniaID, fad.ConsultoraID, fad.cuv

declare @tempProl table
(
	PedidoWebAccionesPROLID bigint
)
insert into @tempProl
select max(PedidoWebAccionesPROLID) as PedidoWebAccionesPROLID
from [dbo].[PedidoWebAccionesPROL] acc with(nolock)
inner join @PedidosEnviados pe on acc.CampaniaId = pe.CampaniaId and acc.ConsultoraId = pe.ConsultoraId
where (charindex('stock',acc.MensajePROL) > 0 or charindex('agotado',acc.MensajePROL)>0)
group by acc.CampaniaID, acc.PedidoID, acc.ConsultoraID, acc.CUV

select 'DO03' as centro,campaniaid,FechaRegistro,codigoproducto,codigotipooferta,sum(cantidad) as cantidad, sum(PrecioUnidad) as total
from (
select fad.campaniaid, @FechaFact as FechaRegistro,pr.codigoproducto,pr.codigotipooferta,
fad.cantidad*pr.FactorRepeticion as cantidad, fad.cantidad * fad.PrecioUnidad as PrecioUnidad
from [dbo].[LogIngresoFAD] fad with(nolock)
inner join @tempFAD tf on fad.LogIngresoFADId = tf.LogIngresoFADId
inner join ods.campania ca with(nolock) on fad.campaniaid = ca.codigo
inner join ods.productocomercial pr with(nolock) on ca.campaniaid = pr.campaniaid and fad.cuv = pr.cuv
UNION ALL
select acc.CampaniaID, @FechaFact as FechaRegistro,pr.codigoproducto,pr.codigotipooferta,
acc.cantidad*pr.FactorRepeticion as cantidad, acc.cantidad * acc.PrecioUnidad as PrecioUnidad
from [dbo].[PedidoWebAccionesPROL] acc with(nolock)
inner join @tempProl tp on acc.PedidoWebAccionesPROLID = tp.PedidoWebAccionesPROLID
inner join ods.campania ca with(nolock) on acc.campaniaid = ca.codigo
inner join ods.productocomercial pr with(nolock) on ca.campaniaid = pr.campaniaid and acc.cuv = pr.cuv
) r
group by campaniaid, FechaRegistro,codigoproducto,codigotipooferta
order by campaniaid, FechaRegistro, codigoproducto
GO

USE [BelcorpEcuador]
GO
/****** Object:  StoredProcedure [dbo].[GetFADDescargaInformacion]    Script Date: 14/08/2018 15:46:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER procedure [dbo].[GetFADDescargaInformacion]
as 

declare @FechaFact date
set @FechaFact = cast(getdate()-1 as date)

declare @PedidosEnviados table
(
	CampaniaId int,
	ConsultoraId bigint
)

insert into @PedidosEnviados
select CampaniaId, ConsultoraId
from PedidoWeb with(nolock)
where IndicadorEnviado = 1 and cast(FechaProceso as date) = @FechaFact

declare @tempFAD table
(
	LogIngresoFADId bigint
)
insert into @tempFAD
select max(fad.LogIngresoFADId) as LogIngresoFADId
from [dbo].[LogIngresoFAD] fad with(nolock)
inner join @PedidosEnviados pe on fad.CampaniaId = pe.CampaniaId and fad.ConsultoraId = pe.ConsultoraId
group by fad.CampaniaID, fad.ConsultoraID, fad.cuv

declare @tempProl table
(
	PedidoWebAccionesPROLID bigint
)
insert into @tempProl
select max(PedidoWebAccionesPROLID) as PedidoWebAccionesPROLID
from [dbo].[PedidoWebAccionesPROL] acc with(nolock)
inner join @PedidosEnviados pe on acc.CampaniaId = pe.CampaniaId and acc.ConsultoraId = pe.ConsultoraId
where (charindex('stock',acc.MensajePROL) > 0 or charindex('agotado',acc.MensajePROL)>0)
group by acc.CampaniaID, acc.PedidoID, acc.ConsultoraID, acc.CUV

select 'EC03' as centro,campaniaid,FechaRegistro,codigoproducto,codigotipooferta,sum(cantidad) as cantidad, sum(PrecioUnidad) as total
from (
select fad.campaniaid, @FechaFact as FechaRegistro,pr.codigoproducto,pr.codigotipooferta,
fad.cantidad*pr.FactorRepeticion as cantidad, fad.cantidad * fad.PrecioUnidad as PrecioUnidad
from [dbo].[LogIngresoFAD] fad with(nolock)
inner join @tempFAD tf on fad.LogIngresoFADId = tf.LogIngresoFADId
inner join ods.campania ca with(nolock) on fad.campaniaid = ca.codigo
inner join ods.productocomercial pr with(nolock) on ca.campaniaid = pr.campaniaid and fad.cuv = pr.cuv
UNION ALL
select acc.CampaniaID, @FechaFact as FechaRegistro,pr.codigoproducto,pr.codigotipooferta,
acc.cantidad*pr.FactorRepeticion as cantidad, acc.cantidad * acc.PrecioUnidad as PrecioUnidad
from [dbo].[PedidoWebAccionesPROL] acc with(nolock)
inner join @tempProl tp on acc.PedidoWebAccionesPROLID = tp.PedidoWebAccionesPROLID
inner join ods.campania ca with(nolock) on acc.campaniaid = ca.codigo
inner join ods.productocomercial pr with(nolock) on ca.campaniaid = pr.campaniaid and acc.cuv = pr.cuv
) r
group by campaniaid, FechaRegistro,codigoproducto,codigotipooferta
order by campaniaid, FechaRegistro, codigoproducto
GO

USE [BelcorpGuatemala]
GO
/****** Object:  StoredProcedure [dbo].[GetFADDescargaInformacion]    Script Date: 14/08/2018 15:48:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER procedure [dbo].[GetFADDescargaInformacion]
as 

declare @FechaFact date
set @FechaFact = cast(getdate()-1 as date)

declare @PedidosEnviados table
(
	CampaniaId int,
	ConsultoraId bigint
)

insert into @PedidosEnviados
select CampaniaId, ConsultoraId
from PedidoWeb with(nolock)
where IndicadorEnviado = 1 and cast(FechaProceso as date) = @FechaFact

declare @tempFAD table
(
	LogIngresoFADId bigint
)
insert into @tempFAD
select max(fad.LogIngresoFADId) as LogIngresoFADId
from [dbo].[LogIngresoFAD] fad with(nolock)
inner join @PedidosEnviados pe on fad.CampaniaId = pe.CampaniaId and fad.ConsultoraId = pe.ConsultoraId
group by fad.CampaniaID, fad.ConsultoraID, fad.cuv

declare @tempProl table
(
	PedidoWebAccionesPROLID bigint
)
insert into @tempProl
select max(PedidoWebAccionesPROLID) as PedidoWebAccionesPROLID
from [dbo].[PedidoWebAccionesPROL] acc with(nolock)
inner join @PedidosEnviados pe on acc.CampaniaId = pe.CampaniaId and acc.ConsultoraId = pe.ConsultoraId
where (charindex('stock',acc.MensajePROL) > 0 or charindex('agotado',acc.MensajePROL)>0)
group by acc.CampaniaID, acc.PedidoID, acc.ConsultoraID, acc.CUV

select 'GT23' as centro,campaniaid,FechaRegistro,codigoproducto,codigotipooferta,sum(cantidad) as cantidad, sum(PrecioUnidad) as total
from (
select fad.campaniaid, @FechaFact as FechaRegistro,pr.codigoproducto,pr.codigotipooferta,
fad.cantidad*pr.FactorRepeticion as cantidad, fad.cantidad * fad.PrecioUnidad as PrecioUnidad
from [dbo].[LogIngresoFAD] fad with(nolock)
inner join @tempFAD tf on fad.LogIngresoFADId = tf.LogIngresoFADId
inner join ods.campania ca with(nolock) on fad.campaniaid = ca.codigo
inner join ods.productocomercial pr with(nolock) on ca.campaniaid = pr.campaniaid and fad.cuv = pr.cuv
UNION ALL
select acc.CampaniaID, @FechaFact as FechaRegistro,pr.codigoproducto,pr.codigotipooferta,
acc.cantidad*pr.FactorRepeticion as cantidad, acc.cantidad * acc.PrecioUnidad as PrecioUnidad
from [dbo].[PedidoWebAccionesPROL] acc with(nolock)
inner join @tempProl tp on acc.PedidoWebAccionesPROLID = tp.PedidoWebAccionesPROLID
inner join ods.campania ca with(nolock) on acc.campaniaid = ca.codigo
inner join ods.productocomercial pr with(nolock) on ca.campaniaid = pr.campaniaid and acc.cuv = pr.cuv
) r
group by campaniaid, FechaRegistro,codigoproducto,codigotipooferta
order by campaniaid, FechaRegistro, codigoproducto
GO

USE [BelcorpMexico]
GO
/****** Object:  StoredProcedure [dbo].[GetFADDescargaInformacion]    Script Date: 14/08/2018 15:50:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[GetFADDescargaInformacion]
as 

declare @FechaFact date
set @FechaFact = cast(getdate()-1 as date)

declare @PedidosEnviados table
(
	CampaniaId int,
	ConsultoraId bigint
)

insert into @PedidosEnviados
select CampaniaId, ConsultoraId
from PedidoWeb with(nolock)
where IndicadorEnviado = 1 and cast(FechaProceso as date) = @FechaFact

declare @tempFAD table
(
	LogIngresoFADId bigint
)
insert into @tempFAD
select max(fad.LogIngresoFADId) as LogIngresoFADId
from [dbo].[LogIngresoFAD] fad with(nolock)
inner hash join @PedidosEnviados pe on fad.CampaniaId = pe.CampaniaId and fad.ConsultoraId = pe.ConsultoraId
group by fad.CampaniaID, fad.ConsultoraID, fad.cuv

declare @tempProl table
(
	PedidoWebAccionesPROLID bigint
)
insert into @tempProl
select max(PedidoWebAccionesPROLID) as PedidoWebAccionesPROLID
from [dbo].[PedidoWebAccionesPROL] acc with(nolock)
inner hash join @PedidosEnviados pe on acc.CampaniaId = pe.CampaniaId and acc.ConsultoraId = pe.ConsultoraId
where (charindex('stock',acc.MensajePROL) > 0 or charindex('agotado',acc.MensajePROL)>0) and charindex('al pack',acc.MensajePROL)=0
group by acc.CampaniaID, acc.PedidoID, acc.ConsultoraID, acc.CUV

select 'MX03' as centro,campaniaid,FechaRegistro,codigoproducto,codigotipooferta,sum(cantidad) as cantidad, sum(PrecioUnidad) as total
from (
select fad.campaniaid, @FechaFact as FechaRegistro,pr.codigoproducto,pr.codigotipooferta,
fad.cantidad*pr.FactorRepeticion as cantidad, fad.cantidad * fad.PrecioUnidad as PrecioUnidad
from [dbo].[LogIngresoFAD] fad with(nolock)
inner join @tempFAD tf on fad.LogIngresoFADId = tf.LogIngresoFADId
inner join ods.campania ca with(nolock) on fad.campaniaid = ca.codigo
inner join ods.productocomercial pr with(nolock) on ca.campaniaid = pr.campaniaid and fad.cuv = pr.cuv
UNION ALL
select acc.CampaniaID, @FechaFact as FechaRegistro,pr.codigoproducto,pr.codigotipooferta,
acc.cantidad*pr.FactorRepeticion as cantidad, acc.cantidad * acc.PrecioUnidad as PrecioUnidad
from [dbo].[PedidoWebAccionesPROL] acc with(nolock)
inner join @tempProl tp on acc.PedidoWebAccionesPROLID = tp.PedidoWebAccionesPROLID
inner join ods.campania ca with(nolock) on acc.campaniaid = ca.codigo
inner join ods.productocomercial pr with(nolock) on ca.campaniaid = pr.campaniaid and acc.cuv = pr.cuv
) r
group by campaniaid, FechaRegistro,codigoproducto,codigotipooferta
order by campaniaid, FechaRegistro, codigoproducto
GO

USE [BelcorpPanama]
GO
/****** Object:  StoredProcedure [dbo].[GetFADDescargaInformacion]    Script Date: 14/08/2018 15:52:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER procedure [dbo].[GetFADDescargaInformacion]
as 

declare @FechaFact date
set @FechaFact = cast(getdate()-1 as date)

declare @PedidosEnviados table
(
	CampaniaId int,
	ConsultoraId bigint
)

insert into @PedidosEnviados
select CampaniaId, ConsultoraId
from PedidoWeb with(nolock)
where IndicadorEnviado = 1 and cast(FechaProceso as date) = @FechaFact

declare @tempFAD table
(
	LogIngresoFADId bigint
)
insert into @tempFAD
select max(fad.LogIngresoFADId) as LogIngresoFADId
from [dbo].[LogIngresoFAD] fad with(nolock)
inner join @PedidosEnviados pe on fad.CampaniaId = pe.CampaniaId and fad.ConsultoraId = pe.ConsultoraId
group by fad.CampaniaID, fad.ConsultoraID, fad.cuv

declare @tempProl table
(
	PedidoWebAccionesPROLID bigint
)
insert into @tempProl
select max(PedidoWebAccionesPROLID) as PedidoWebAccionesPROLID
from [dbo].[PedidoWebAccionesPROL] acc with(nolock)
inner join @PedidosEnviados pe on acc.CampaniaId = pe.CampaniaId and acc.ConsultoraId = pe.ConsultoraId
where (charindex('stock',acc.MensajePROL) > 0 or charindex('agotado',acc.MensajePROL)>0)
group by acc.CampaniaID, acc.PedidoID, acc.ConsultoraID, acc.CUV

select 'PA33' as centro,campaniaid,FechaRegistro,codigoproducto,codigotipooferta,sum(cantidad) as cantidad, sum(PrecioUnidad) as total
from (
select fad.campaniaid, @FechaFact as FechaRegistro,pr.codigoproducto,pr.codigotipooferta,
fad.cantidad*pr.FactorRepeticion as cantidad, fad.cantidad * fad.PrecioUnidad as PrecioUnidad
from [dbo].[LogIngresoFAD] fad with(nolock)
inner join @tempFAD tf on fad.LogIngresoFADId = tf.LogIngresoFADId
inner join ods.campania ca with(nolock) on fad.campaniaid = ca.codigo
inner join ods.productocomercial pr with(nolock) on ca.campaniaid = pr.campaniaid and fad.cuv = pr.cuv
UNION ALL
select acc.CampaniaID, @FechaFact as FechaRegistro,pr.codigoproducto,pr.codigotipooferta,
acc.cantidad*pr.FactorRepeticion as cantidad, acc.cantidad * acc.PrecioUnidad as PrecioUnidad
from [dbo].[PedidoWebAccionesPROL] acc with(nolock)
inner join @tempProl tp on acc.PedidoWebAccionesPROLID = tp.PedidoWebAccionesPROLID
inner join ods.campania ca with(nolock) on acc.campaniaid = ca.codigo
inner join ods.productocomercial pr with(nolock) on ca.campaniaid = pr.campaniaid and acc.cuv = pr.cuv
) r
group by campaniaid, FechaRegistro,codigoproducto,codigotipooferta
order by campaniaid, FechaRegistro, codigoproducto
GO

USE [BelcorpPeru]
GO
/****** Object:  StoredProcedure [dbo].[GetFADDescargaInformacion]    Script Date: 14/08/2018 15:53:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER procedure [dbo].[GetFADDescargaInformacion]
as
declare @FechaFact date
set @FechaFact = cast(getdate()-1 as date)

declare @PedidosEnviados table
(
CampaniaId int,
ConsultoraId bigint
)
insert into @PedidosEnviados
select CampaniaId, ConsultoraId
from PedidoWeb with(nolock)
where IndicadorEnviado = 1 and cast(FechaProceso as date) = @FechaFact

declare @tempFAD table
(
LogIngresoFADId bigint
)
insert into @tempFAD
select max(fad.LogIngresoFADId) as LogIngresoFADId
from [dbo].[LogIngresoFAD] fad with(nolock)
inner join @PedidosEnviados pe on fad.CampaniaId = pe.CampaniaId and fad.ConsultoraId = pe.ConsultoraId
group by fad.CampaniaID, fad.ConsultoraID, fad.cuv

declare @tempProl table
(
PedidoWebAccionesPROLID bigint
)
insert into @tempProl
select max(PedidoWebAccionesPROLID) as PedidoWebAccionesPROLID
from [dbo].[PedidoWebAccionesPROL] acc with(nolock)
inner hash join @PedidosEnviados pe on acc.CampaniaId = pe.CampaniaId and acc.ConsultoraId = pe.ConsultoraId
where (charindex('stock',acc.MensajePROL) > 0 or charindex('agotado',acc.MensajePROL)>0)  and charindex('al pack',acc.MensajePROL)=0 and charindex('del pack',acc.MensajePROL)=0
group by acc.CampaniaID, acc.PedidoID, acc.ConsultoraID, acc.CUV

select 'PE03' as centro,campaniaid,FechaRegistro,codigoproducto,codigotipooferta,sum(cantidad) as cantidad, sum(PrecioUnidad) as total
from (
select fad.campaniaid, @FechaFact as FechaRegistro,pr.codigoproducto,pr.codigotipooferta,
fad.cantidad*pr.FactorRepeticion as cantidad, fad.cantidad * fad.PrecioUnidad as PrecioUnidad
from [dbo].[LogIngresoFAD] fad with(nolock)
inner hash join @tempFAD tf on fad.LogIngresoFADId = tf.LogIngresoFADId
inner join ods.campania ca with(nolock) on fad.campaniaid = ca.codigo
inner hash join ods.productocomercial pr with(nolock) on ca.campaniaid = pr.campaniaid and fad.cuv = pr.cuv
UNION ALL
select acc.CampaniaID, @FechaFact as FechaRegistro,pr.codigoproducto,pr.codigotipooferta,
acc.cantidad*pr.FactorRepeticion as cantidad, acc.cantidad * acc.PrecioUnidad as PrecioUnidad
from [dbo].[PedidoWebAccionesPROL] acc with(nolock)
inner hash join @tempProl tp on acc.PedidoWebAccionesPROLID = tp.PedidoWebAccionesPROLID
inner join ods.campania ca with(nolock) on acc.campaniaid = ca.codigo
inner hash join ods.productocomercial pr with(nolock) on ca.campaniaid = pr.campaniaid and acc.cuv = pr.cuv
) r
group by campaniaid, FechaRegistro,codigoproducto,codigotipooferta
order by campaniaid, FechaRegistro, codigoproducto
GO

USE [BelcorpPuertoRico]
GO
/****** Object:  StoredProcedure [dbo].[GetFADDescargaInformacion]    Script Date: 14/08/2018 15:54:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[GetFADDescargaInformacion]
as
declare @FechaFact date
set @FechaFact = cast(getdate()-1 as date)
declare @PedidosEnviados table
(
CampaniaId int,
ConsultoraId bigint
)
insert into @PedidosEnviados
select CampaniaId, ConsultoraId
from PedidoWeb with(nolock)
where IndicadorEnviado = 1 and cast(FechaProceso as date) = @FechaFact
declare @tempFAD table
(
LogIngresoFADId bigint
)
insert into @tempFAD
select max(fad.LogIngresoFADId) as LogIngresoFADId
from [dbo].[LogIngresoFAD] fad with(nolock)
inner join @PedidosEnviados pe on fad.CampaniaId = pe.CampaniaId and fad.ConsultoraId = pe.ConsultoraId
group by fad.CampaniaID, fad.ConsultoraID, fad.cuv
declare @tempProl table
(
PedidoWebAccionesPROLID bigint
)
insert into @tempProl
select max(PedidoWebAccionesPROLID) as PedidoWebAccionesPROLID
from [dbo].[PedidoWebAccionesPROL] acc with(nolock)
inner join @PedidosEnviados pe on acc.CampaniaId = pe.CampaniaId and acc.ConsultoraId = pe.ConsultoraId
where (charindex('stock',acc.MensajePROL) > 0 or charindex('agotado',acc.MensajePROL)>0) and charindex('al pack',acc.MensajePROL)=0 and charindex('del pack',acc.MensajePROL)=0
group by acc.CampaniaID, acc.PedidoID, acc.ConsultoraID, acc.CUV

select 'PR03' as centro,campaniaid,FechaRegistro,codigoproducto,codigotipooferta,sum(cantidad) as cantidad, sum(PrecioUnidad) as total
from (
select fad.campaniaid, @FechaFact as FechaRegistro,pr.codigoproducto,pr.codigotipooferta,
fad.cantidad*pr.FactorRepeticion as cantidad, fad.cantidad * fad.PrecioUnidad as PrecioUnidad
from [dbo].[LogIngresoFAD] fad with(nolock)
inner join @tempFAD tf on fad.LogIngresoFADId = tf.LogIngresoFADId
inner join ods.campania ca with(nolock) on fad.campaniaid = ca.codigo
inner join ods.productocomercial pr with(nolock) on ca.campaniaid = pr.campaniaid and fad.cuv = pr.cuv
UNION ALL
select acc.CampaniaID, @FechaFact as FechaRegistro,pr.codigoproducto,pr.codigotipooferta,
acc.cantidad*pr.FactorRepeticion as cantidad, acc.cantidad * acc.PrecioUnidad as PrecioUnidad
from [dbo].[PedidoWebAccionesPROL] acc with(nolock)
inner join @tempProl tp on acc.PedidoWebAccionesPROLID = tp.PedidoWebAccionesPROLID
inner join ods.campania ca with(nolock) on acc.campaniaid = ca.codigo
inner join ods.productocomercial pr with(nolock) on ca.campaniaid = pr.campaniaid and acc.cuv = pr.cuv
) r
group by campaniaid, FechaRegistro,codigoproducto,codigotipooferta
order by campaniaid, FechaRegistro, codigoproducto
GO

USE [BelcorpSalvador]
GO
/****** Object:  StoredProcedure [dbo].[GetFADDescargaInformacion]    Script Date: 14/08/2018 15:55:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER procedure [dbo].[GetFADDescargaInformacion]
as 

declare @FechaFact date
set @FechaFact = cast(getdate()-1 as date)

declare @PedidosEnviados table
(
	CampaniaId int,
	ConsultoraId bigint
)

insert into @PedidosEnviados
select CampaniaId, ConsultoraId
from PedidoWeb with(nolock)
where IndicadorEnviado = 1 and cast(FechaProceso as date) = @FechaFact

declare @tempFAD table
(
	LogIngresoFADId bigint
)
insert into @tempFAD
select max(fad.LogIngresoFADId) as LogIngresoFADId
from [dbo].[LogIngresoFAD] fad with(nolock)
inner join @PedidosEnviados pe on fad.CampaniaId = pe.CampaniaId and fad.ConsultoraId = pe.ConsultoraId
group by fad.CampaniaID, fad.ConsultoraID, fad.cuv

declare @tempProl table
(
	PedidoWebAccionesPROLID bigint
)
insert into @tempProl
select max(PedidoWebAccionesPROLID) as PedidoWebAccionesPROLID
from [dbo].[PedidoWebAccionesPROL] acc with(nolock)
inner join @PedidosEnviados pe on acc.CampaniaId = pe.CampaniaId and acc.ConsultoraId = pe.ConsultoraId
where (charindex('stock',acc.MensajePROL) > 0 or charindex('agotado',acc.MensajePROL)>0)
group by acc.CampaniaID, acc.PedidoID, acc.ConsultoraID, acc.CUV

select 'SV13' as centro,campaniaid,FechaRegistro,codigoproducto,codigotipooferta,sum(cantidad) as cantidad, sum(PrecioUnidad) as total
from (
select fad.campaniaid, @FechaFact as FechaRegistro,pr.codigoproducto,pr.codigotipooferta,
fad.cantidad*pr.FactorRepeticion as cantidad, fad.cantidad * fad.PrecioUnidad as PrecioUnidad
from [dbo].[LogIngresoFAD] fad with(nolock)
inner join @tempFAD tf on fad.LogIngresoFADId = tf.LogIngresoFADId
inner join ods.campania ca with(nolock) on fad.campaniaid = ca.codigo
inner join ods.productocomercial pr with(nolock) on ca.campaniaid = pr.campaniaid and fad.cuv = pr.cuv
UNION ALL
select acc.CampaniaID, @FechaFact as FechaRegistro,pr.codigoproducto,pr.codigotipooferta,
acc.cantidad*pr.FactorRepeticion as cantidad, acc.cantidad * acc.PrecioUnidad as PrecioUnidad
from [dbo].[PedidoWebAccionesPROL] acc with(nolock)
inner join @tempProl tp on acc.PedidoWebAccionesPROLID = tp.PedidoWebAccionesPROLID
inner join ods.campania ca with(nolock) on acc.campaniaid = ca.codigo
inner join ods.productocomercial pr with(nolock) on ca.campaniaid = pr.campaniaid and acc.cuv = pr.cuv
) r
group by campaniaid, FechaRegistro,codigoproducto,codigotipooferta
order by campaniaid, FechaRegistro, codigoproducto