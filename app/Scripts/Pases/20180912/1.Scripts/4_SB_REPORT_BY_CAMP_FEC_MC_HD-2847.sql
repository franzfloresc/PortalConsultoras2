USE [BelcorpBolivia]
GO
/****** Object:  StoredProcedure [dbo].[SB_REPORT_BY_CAMP_FEC]    Script Date: 15/08/2018 18:11:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[SB_REPORT_BY_CAMP_FEC] 
(@CAMPANIA VARCHAR(6),@CODSAP VARCHAR(12))

AS

DECLARE @SQLQUERY VARCHAR(8000)

SET @SQLQUERY='
declare @PedidosEnviados table
(
                CampaniaId int,
				ConsultoraId bigint,
                FechaProceso
	 datetime,
				FechaRegistro datetime
)
insert into @PedidosEnviados
select  CampaniaId, ConsultoraId,fechaproceso,fecharegistro
from PedidoWeb with(nolock)
where CAMPANIAID='+@CAMPANIA+' and IndicadorEnviado = 1 

declare @tempFAD table
(
               
	 LogIngresoFADId bigint,
                FechaProceso datetime,
				FechaRegistro datetime
)
insert into @tempFAD
select max(fad.LogIngresoFADId) as LogIngresoFADId,pe.FechaProceso,pe.fecharegistro
from LogIngresoFAD fad with(nolock)
inner hash join @PedidosEnviados pe on fad.CampaniaId = pe.CampaniaId and fad.ConsultoraId = pe.ConsultoraId
group by fad.CampaniaID, fad.ConsultoraID, fad.cuv,pe.FechaProceso,pe.fecharegistro

declare @tempProl table
(
                PedidoWebAccionesPROLID bigint,
        
	       FechaProceso datetime,
			   FechaRegistro datetime
)


insert into @tempProl
select max(PedidoWebAccionesPROLID) as PedidoWebAccionesPROLID,pe.FechaProceso,pe.FechaRegistro
from PedidoWebAccionesPROL acc with(nolock)
inner hash join @PedidosEnviados pe on acc.CampaniaId = pe.CampaniaId and acc.ConsultoraId = pe.ConsultoraId
where (charindex(''stock'',acc.MensajePROL) > 0 or charindex(''agotado'',acc.MensajePROL)>0)
group by acc.CampaniaID, acc.PedidoID, acc.ConsultoraID, acc.CUV,pe.FechaProceso,pe.FechaRegistro

declare @tempFRS table
(
DemandaTotalReemplazoSugeridoId bigint,
FechaProceso datetime,
FechaRegistro datetime
)
insert into @tempFRS
select max(dtrs.SugeridoID) as SugeridoID,pe.FechaProceso,pe.fecharegistro
from [dbo].[DemandaTotalReemplazoSugerido] dtrs with(nolock)
inner join @PedidosEnviados pe on dtrs.CampaniaId = pe.CampaniaId and dtrs.ConsultoraId = pe.ConsultoraId
where dtrs.tipo = ''FRS''
group by dtrs.CampaniaID, dtrs.ConsultoraID, dtrs.CUVOriginal,pe.FechaProceso,pe.fecharegistro

select 
	fad.CampaniaID as Campania, 
	isnull(si.descripcion,'''') TipoConsultora,
	co.Codigo as CodigoConsultora, 
	r.Codigo as Region, 
	z.Codigo as Zona,
	tf.FechaRegistro as FechaRegistroPedido,
	fad.FechaRegistro  as FechaRegistroFaltante,
	pr.CodigoProducto, 
	pr.CodigoTipoOferta, 
	fad.CUV,
	fad.Cantidad,
	fad.cantidad*pr.FactorRepeticion as CantidadPorFactor, 
	''FAD'' as Tipo,
	convert(varchar,tf.FechaProceso,103) FechaProceso,
	'' '' Observacion
from LogIngresoFAD fad with(nolock
	)
inner hash join @tempFAD tf on fad.LogIngresoFADId = tf.LogIngresoFADId
inner join ods.campania ca with(nolock) on fad.campaniaid = ca.codigo
inner hash join ods.productocomercial pr with(nolock) on ca.campaniaid = pr.campaniaid and fad.cuv = pr.cuv
inner hash join ods.consultora co with(nolock) on fad.ConsultoraId = co.ConsultoraId
inner join ods.region r with(nolock) on co.regionid = r.regionid
inner join ods.zona z with(nolock) on co.zonaid = z.zonaid 
left join ods.SegmentoInterno si with(nolock) on
	 si.segmentointernoid=co.segmentointernoid'+
CASE WHEN LEN(@CODSAP)>0 THEN ' WHERE pr.codigoproducto ='''+@CODSAP+''' ' ELSE ' ' END+'
UNION ALL
select 
	acc.CampaniaID as Campania, 
	isnull(si.descripcion,'''') TipoConsultora,
	co.Codigo as CodigoConsultora, 
	r.Codigo as Region, 
	z.Codigo as Zona, 
	tp.FechaRegistro as FechaRegistroPedido,
	acc.FechaAccion  as FechaRegistroFaltante,
	pr.CodigoProducto, 
	pr.CodigoTipoOferta, 
	acc.CUV,acc.Cantidad,
	acc.cantidad*pr.FactorRepeticion as CantidadPorFactor, 
	''PROL'' as Tipo,
	convert(varchar,tp.FechaProceso,103) FechaProceso, 
	acc.MensajePROL Observacion
from PedidoWebAccionesPROL acc with(nolock)
inner hash join @tempProl tp on acc.PedidoWebAccionesPROLID = tp.PedidoWebAccionesPROLID
inner join ods.campania ca with(nolock) on acc.campaniaid = ca.codigo
inner hash join ods.productocomercial pr with(nolock) on ca.campaniaid = pr.campaniaid and acc.cuv = pr.cuv
inner hash join ods.consultora co with(nolock) on acc.ConsultoraId = co.ConsultoraId
inner join ods.region r with(nolock) on co.regionid = r.regionid
inner join ods.zona z with(nolock) on co.zonaid = z.zonaid 
left join ods.SegmentoInterno si with(nolock) on si.segmentointernoid=co.segmentointernoid'+
CASE WHEN LEN(@CODSAP)>0 THEN ' WHERE pr.codigo producto ='''+@CODSAP+''' ' ELSE ' ' END+'
UNION ALL
select 
	dtrs.CampaniaID as Campania, 
	isnull(si.descripcion,'''') TipoConsultora,
	co.Codigo as CodigoConsultora, 
	r.Codigo as Region, 
	z.Codigo as Zona,
	tr.FechaRegistro as FechaRegistroPedido,
	dtrs.FechaProceso  as FechaRegistroFaltante,
	pr.CodigoProducto, 
	pr.CodigoTipoOferta, 
	dtrs.CUVOriginal,
	dtrs.Cantidad,
	dtrs.cantidad*pr.FactorRepeticion as CantidadPorFactor, 
	''FRS'' as Tipo,
	convert(varchar,tr.FechaProceso,103) FechaProceso,
	'' '' Observacion
from [dbo].[DemandaTotalReemplazoSugerido] dtrs with(nolock)
inner hash join @tempFRS tr on dtrs.SugeridoID = tr.DemandaTotalReemplazoSugeridoId
inner join ods.campania ca with(nolock) on dtrs.campaniaid = ca.codigo
inner hash join ods.productocomercial pr with(nolock) on ca.campaniaid = pr.campaniaid and dtrs.CUVOriginal = pr.cuv
inner hash join ods.consultora co with(nolock) on dtrs.ConsultoraId = co.ConsultoraId
inner join ods.region r with(nolock) on co.regionid = r.regionid
inner join ods.zona z with(nolock) on co.zonaid = z.zonaid 
left join ods.SegmentoInterno si with(nolock) on si.segmentointernoid=co.segmentointernoid'+
CASE WHEN LEN(@CODSAP)>0 THEN ' WHERE pr.codigoproducto ='''+@CODSAP+''' ' ELSE ' ' END+''

EXEC(@SQLQUERY)
GO

USE [BelcorpChile]
GO
/****** Object:  StoredProcedure [dbo].[SB_REPORT_BY_CAMP_FEC]    Script Date: 15/08/2018 18:13:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SB_REPORT_BY_CAMP_FEC] 
(@CAMPANIA VARCHAR(6),@CODSAP VARCHAR(12))

AS

DECLARE @SQLQUERY VARCHAR(8000)

SET @SQLQUERY='
declare @PedidosEnviados table
(
                CampaniaId int,
				ConsultoraId bigint,
                FechaProceso datetime,
				FechaRegistro datetime
)
insert into @PedidosEnviados
select  CampaniaId, ConsultoraId,fechaproceso,fecharegistro
from PedidoWeb with(nolock)
where CAMPANIAID='+@CAMPANIA+' and IndicadorEnviado = 1 

declare @tempFAD table
(
                LogIngresoFADId bigint,
                FechaProceso datetime,
				FechaRegistro datetime
)
insert into @tempFAD
select max(fad.LogIngresoFADId) as LogIngresoFADId,pe.FechaProceso,pe.fecharegistro
from LogIngresoFAD fad with(nolock)
inner hash join @PedidosEnviados pe on fad.CampaniaId = pe.CampaniaId and fad.ConsultoraId = pe.ConsultoraId
group by fad.CampaniaID, fad.ConsultoraID, fad.cuv,pe.FechaProceso,pe.fecharegistro

declare @tempProl table
(
                PedidoWebAccionesPROLID bigint,
               FechaProceso datetime,
			   FechaRegistro datetime
)


insert into @tempProl
select max(PedidoWebAccionesPROLID) as PedidoWebAccionesPROLID,pe.FechaProceso,pe.FechaRegistro
from PedidoWebAccionesPROL acc with(nolock)
inner hash join @PedidosEnviados pe on acc.CampaniaId = pe.CampaniaId and acc.ConsultoraId = pe.ConsultoraId
where (charindex(''stock'',acc.MensajePROL) > 0 or charindex(''agotado'',acc.MensajePROL)>0)
group by acc.CampaniaID, acc.PedidoID, acc.ConsultoraID, acc.CUV,pe.FechaProceso,pe.FechaRegistro

declare @tempFRS table
(
DemandaTotalReemplazoSugeridoId bigint,
FechaProceso datetime,
FechaRegistro datetime
)
insert into @tempFRS
select max(dtrs.SugeridoID) as SugeridoID,pe.FechaProceso,pe.fecharegistro
from [dbo].[DemandaTotalReemplazoSugerido] dtrs with(nolock)
inner join @PedidosEnviados pe on dtrs.CampaniaId = pe.CampaniaId and dtrs.ConsultoraId = pe.ConsultoraId
where dtrs.tipo = ''FRS''
group by dtrs.CampaniaID, dtrs.ConsultoraID, dtrs.CUVOriginal,pe.FechaProceso,pe.fecharegistro

select 
	fad.CampaniaID as Campania, 
	isnull(si.descripcion,'''') TipoConsultora,
	co.Codigo as CodigoConsultora, 
	r.Codigo as Region, 
	z.Codigo as Zona,
	tf.FechaRegistro as FechaRegistroPedido,
	fad.FechaRegistro  as FechaRegistroFaltante,
	pr.CodigoProducto, 
	pr.CodigoTipoOferta, 
	fad.CUV,
	fad.Cantidad,
	fad.cantidad*pr.FactorRepeticion as CantidadPorFactor, 
	''FAD'' as Tipo,
	convert(varchar,tf.FechaProceso,103) FechaProceso,
	'' '' Observacion
from LogIngresoFAD fad with(nolock)
inner hash join @tempFAD tf on fad.LogIngresoFADId = tf.LogIngresoFADId
inner join ods.campania ca with(nolock) on fad.campaniaid = ca.codigo
inner hash join ods.productocomercial pr with(nolock) on ca.campaniaid = pr.campaniaid and fad.cuv = pr.cuv
inner hash join ods.consultora co with(nolock) on fad.ConsultoraId = co.ConsultoraId
inner join ods.region r with(nolock) on co.regionid = r.regionid
inner join ods.zona z with(nolock) on co.zonaid = z.zonaid 
left join ods.SegmentoInterno si with(nolock) on si.segmentointernoid=co.segmentointernoid'+
CASE WHEN LEN(@CODSAP)>0 THEN ' WHERE pr.codigoproducto ='''+@CODSAP+''' ' ELSE ' ' END+'
UNION ALL
select 
	acc.CampaniaID as Campania, 
	isnull(si.descripcion,'''') TipoConsultora,
	co.Codigo as CodigoConsultora, 
	r.Codigo as Region, 
	z.Codigo as Zona, 
	tp.FechaRegistro as FechaRegistroPedido,
	acc.FechaAccion  as FechaRegistroFaltante,
	pr.CodigoProducto, 
	pr.CodigoTipoOferta, 
	acc.CUV,acc.Cantidad,
	acc.cantidad*pr.FactorRepeticion as CantidadPorFactor, 
	''PROL'' as Tipo,
	convert(varchar,tp.FechaProceso,103) FechaProceso, 
	acc.MensajePROL Observacion
from PedidoWebAccionesPROL acc with(nolock)
inner hash join @tempProl tp on acc.PedidoWebAccionesPROLID = tp.PedidoWebAccionesPROLID
inner join ods.campania ca with(nolock) on acc.campaniaid = ca.codigo
inner hash join ods.productocomercial pr with(nolock) on ca.campaniaid = pr.campaniaid and acc.cuv = pr.cuv
inner hash join ods.consultora co with(nolock) on acc.ConsultoraId = co.ConsultoraId
inner join ods.region r with(nolock) on co.regionid = r.regionid
inner join ods.zona z with(nolock) on co.zonaid = z.zonaid 
left join ods.SegmentoInterno si with(nolock) on si.segmentointernoid=co.segmentointernoid'+
CASE WHEN LEN(@CODSAP)>0 THEN ' WHERE pr.codigoproducto ='''+@CODSAP+''' ' ELSE ' ' END+'
UNION ALL
select 
	dtrs.CampaniaID as Campania, 
	isnull(si.descripcion,'''') TipoConsultora,
	co.Codigo as CodigoConsultora, 
	r.Codigo as Region, 
	z.Codigo as Zona,
	tr.FechaRegistro as FechaRegistroPedido,
	dtrs.FechaProceso  as FechaRegistroFaltante,
	pr.CodigoProducto, 
	pr.CodigoTipoOferta, 
	dtrs.CUVOriginal,
	dtrs.Cantidad,
	dtrs.cantidad*pr.FactorRepeticion as CantidadPorFactor, 
	''FRS'' as Tipo,
	convert(varchar,tr.FechaProceso,103) FechaProceso,
	'' '' Observacion
from [dbo].[DemandaTotalReemplazoSugerido] dtrs with(nolock)
inner hash join @tempFRS tr on dtrs.SugeridoID = tr.DemandaTotalReemplazoSugeridoId
inner join ods.campania ca with(nolock) on dtrs.campaniaid = ca.codigo
inner hash join ods.productocomercial pr with(nolock) on ca.campaniaid = pr.campaniaid and dtrs.CUVOriginal = pr.cuv
inner hash join ods.consultora co with(nolock) on dtrs.ConsultoraId = co.ConsultoraId
inner join ods.region r with(nolock) on co.regionid = r.regionid
inner join ods.zona z with(nolock) on co.zonaid = z.zonaid 
left join ods.SegmentoInterno si with(nolock) on si.segmentointernoid=co.segmentointernoid'+
CASE WHEN LEN(@CODSAP)>0 THEN ' WHERE pr.codigoproducto ='''+@CODSAP+''' ' ELSE ' ' END+''

EXEC(@SQLQUERY)
GO

USE [BelcorpColombia]
GO
/****** Object:  StoredProcedure [dbo].[SB_REPORT_BY_CAMP_FEC]    Script Date: 15/08/2018 18:14:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SB_REPORT_BY_CAMP_FEC] 
(@CAMPANIA VARCHAR(6),@CODSAP VARCHAR(12))

AS

DECLARE @SQLQUERY VARCHAR(8000)

SET @SQLQUERY='
declare @PedidosEnviados table
(
                CampaniaId int,
				ConsultoraId bigint,
                FechaProceso datetime,
				FechaRegistro datetime
)
insert into @PedidosEnviados
select  CampaniaId, ConsultoraId,fechaproceso,fecharegistro
from PedidoWeb with(nolock)
where CAMPANIAID='+@CAMPANIA+' and IndicadorEnviado = 1 

declare @tempFAD table
(
                LogIngresoFADId bigint,
                FechaProceso datetime,
				FechaRegistro datetime
)
insert into @tempFAD
select max(fad.LogIngresoFADId) as LogIngresoFADId,pe.FechaProceso,pe.fecharegistro
from LogIngresoFAD fad with(nolock)
inner hash join @PedidosEnviados pe on fad.CampaniaId = pe.CampaniaId and fad.ConsultoraId = pe.ConsultoraId
group by fad.CampaniaID, fad.ConsultoraID, fad.cuv,pe.FechaProceso,pe.fecharegistro

declare @tempProl table
(
                PedidoWebAccionesPROLID bigint,
               FechaProceso datetime,
			   FechaRegistro datetime
)


insert into @tempProl
select max(PedidoWebAccionesPROLID) as PedidoWebAccionesPROLID,pe.FechaProceso,pe.FechaRegistro
from PedidoWebAccionesPROL acc with(nolock)
inner hash join @PedidosEnviados pe on acc.CampaniaId = pe.CampaniaId and acc.ConsultoraId = pe.ConsultoraId
where (charindex(''stock'',acc.MensajePROL) > 0 or charindex(''agotado'',acc.MensajePROL)>0)
group by acc.CampaniaID, acc.PedidoID, acc.ConsultoraID, acc.CUV,pe.FechaProceso,pe.FechaRegistro

declare @tempFRS table
(
DemandaTotalReemplazoSugeridoId bigint,
FechaProceso datetime,
FechaRegistro datetime
)
insert into @tempFRS
select max(dtrs.SugeridoID) as SugeridoID,pe.FechaProceso,pe.fecharegistro
from [dbo].[DemandaTotalReemplazoSugerido] dtrs with(nolock)
inner join @PedidosEnviados pe on dtrs.CampaniaId = pe.CampaniaId and dtrs.ConsultoraId = pe.ConsultoraId
where dtrs.tipo = ''FRS''
group by dtrs.CampaniaID, dtrs.ConsultoraID, dtrs.CUVOriginal,pe.FechaProceso,pe.fecharegistro

select 
	fad.CampaniaID as Campania, 
	isnull(si.descripcion,'''') TipoConsultora,
	co.Codigo as CodigoConsultora, 
	r.Codigo as Region, 
	z.Codigo as Zona,
	tf.FechaRegistro as FechaRegistroPedido,
	fad.FechaRegistro  as FechaRegistroFaltante,
	pr.CodigoProducto, 
	pr.CodigoTipoOferta, 
	fad.CUV,
	fad.Cantidad,
	fad.cantidad*pr.FactorRepeticion as CantidadPorFactor, 
	''FAD'' as Tipo,
	convert(varchar,tf.FechaProceso,103) FechaProceso,
	'' '' Observacion
from LogIngresoFAD fad with(nolock)
inner hash join @tempFAD tf on fad.LogIngresoFADId = tf.LogIngresoFADId
inner join ods.campania ca with(nolock) on fad.campaniaid = ca.codigo
inner hash join ods.productocomercial pr with(nolock) on ca.campaniaid = pr.campaniaid and fad.cuv = pr.cuv
inner hash join ods.consultora co with(nolock) on fad.ConsultoraId = co.ConsultoraId
inner join ods.region r with(nolock) on co.regionid = r.regionid
inner join ods.zona z with(nolock) on co.zonaid = z.zonaid 
left join ods.SegmentoInterno si with(nolock) on si.segmentointernoid=co.segmentointernoid'+
CASE WHEN LEN(@CODSAP)>0 THEN ' WHERE pr.codigoproducto ='''+@CODSAP+''' ' ELSE ' ' END+'
UNION ALL
select 
	acc.CampaniaID as Campania, 
	isnull(si.descripcion,'''') TipoConsultora,
	co.Codigo as CodigoConsultora, 
	r.Codigo as Region, 
	z.Codigo as Zona, 
	tp.FechaRegistro as FechaRegistroPedido,
	acc.FechaAccion  as FechaRegistroFaltante,
	pr.CodigoProducto, 
	pr.CodigoTipoOferta, 
	acc.CUV,acc.Cantidad,
	acc.cantidad*pr.FactorRepeticion as CantidadPorFactor, 
	''PROL'' as Tipo,
	convert(varchar,tp.FechaProceso,103) FechaProceso, 
	acc.MensajePROL Observacion
from PedidoWebAccionesPROL acc with(nolock)
inner hash join @tempProl tp on acc.PedidoWebAccionesPROLID = tp.PedidoWebAccionesPROLID
inner join ods.campania ca with(nolock) on acc.campaniaid = ca.codigo
inner hash join ods.productocomercial pr with(nolock) on ca.campaniaid = pr.campaniaid and acc.cuv = pr.cuv
inner hash join ods.consultora co with(nolock) on acc.ConsultoraId = co.ConsultoraId
inner join ods.region r with(nolock) on co.regionid = r.regionid
inner join ods.zona z with(nolock) on co.zonaid = z.zonaid 
left join ods.SegmentoInterno si with(nolock) on si.segmentointernoid=co.segmentointernoid'+
CASE WHEN LEN(@CODSAP)>0 THEN ' WHERE pr.codigoproducto ='''+@CODSAP+''' ' ELSE ' ' END+'
UNION ALL
select 
	dtrs.CampaniaID as Campania, 
	isnull(si.descripcion,'''') TipoConsultora,
	co.Codigo as CodigoConsultora, 
	r.Codigo as Region, 
	z.Codigo as Zona,
	tr.FechaRegistro as FechaRegistroPedido,
	dtrs.FechaProceso  as FechaRegistroFaltante,
	pr.CodigoProducto, 
	pr.CodigoTipoOferta, 
	dtrs.CUVOriginal,
	dtrs.Cantidad,
	dtrs.cantidad*pr.FactorRepeticion as CantidadPorFactor, 
	''FRS'' as Tipo,
	convert(varchar,tr.FechaProceso,103) FechaProceso,
	'' '' Observacion
from [dbo].[DemandaTotalReemplazoSugerido] dtrs with(nolock)
inner hash join @tempFRS tr on dtrs.SugeridoID = tr.DemandaTotalReemplazoSugeridoId
inner join ods.campania ca with(nolock) on dtrs.campaniaid = ca.codigo
inner hash join ods.productocomercial pr with(nolock) on ca.campaniaid = pr.campaniaid and dtrs.CUVOriginal = pr.cuv
inner hash join ods.consultora co with(nolock) on dtrs.ConsultoraId = co.ConsultoraId
inner join ods.region r with(nolock) on co.regionid = r.regionid
inner join ods.zona z with(nolock) on co.zonaid = z.zonaid 
left join ods.SegmentoInterno si with(nolock) on si.segmentointernoid=co.segmentointernoid'+
CASE WHEN LEN(@CODSAP)>0 THEN ' WHERE pr.codigoproducto ='''+@CODSAP+''' ' ELSE ' ' END+''

EXEC(@SQLQUERY)
GO

USE [BelcorpCostaRica]
GO
/****** Object:  StoredProcedure [dbo].[SB_REPORT_BY_CAMP_FEC]    Script Date: 15/08/2018 18:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SB_REPORT_BY_CAMP_FEC] 
(@CAMPANIA VARCHAR(6),@CODSAP VARCHAR(12))

AS

DECLARE @SQLQUERY VARCHAR(8000)

SET @SQLQUERY='
declare @PedidosEnviados table
(
                CampaniaId int,
				ConsultoraId bigint,
                FechaProceso datetime,
				FechaRegistro datetime
)
insert into @PedidosEnviados
select  CampaniaId, ConsultoraId,fechaproceso,fecharegistro
from PedidoWeb with(nolock)
where CAMPANIAID='+@CAMPANIA+' and IndicadorEnviado = 1 

declare @tempFAD table
(
                LogIngresoFADId bigint,
                FechaProceso datetime,
				FechaRegistro datetime
)
insert into @tempFAD
select max(fad.LogIngresoFADId) as LogIngresoFADId,pe.FechaProceso,pe.fecharegistro
from LogIngresoFAD fad with(nolock)
inner hash join @PedidosEnviados pe on fad.CampaniaId = pe.CampaniaId and fad.ConsultoraId = pe.ConsultoraId
group by fad.CampaniaID, fad.ConsultoraID, fad.cuv,pe.FechaProceso,pe.fecharegistro

declare @tempProl table
(
                PedidoWebAccionesPROLID bigint,
               FechaProceso datetime,
			   FechaRegistro datetime
)


insert into @tempProl
select max(PedidoWebAccionesPROLID) as PedidoWebAccionesPROLID,pe.FechaProceso,pe.FechaRegistro
from PedidoWebAccionesPROL acc with(nolock)
inner hash join @PedidosEnviados pe on acc.CampaniaId = pe.CampaniaId and acc.ConsultoraId = pe.ConsultoraId
where (charindex(''stock'',acc.MensajePROL) > 0 or charindex(''agotado'',acc.MensajePROL)>0)
group by acc.CampaniaID, acc.PedidoID, acc.ConsultoraID, acc.CUV,pe.FechaProceso,pe.FechaRegistro

declare @tempFRS table
(
DemandaTotalReemplazoSugeridoId bigint,
FechaProceso datetime,
FechaRegistro datetime
)
insert into @tempFRS
select max(dtrs.SugeridoID) as SugeridoID,pe.FechaProceso,pe.fecharegistro
from [dbo].[DemandaTotalReemplazoSugerido] dtrs with(nolock)
inner join @PedidosEnviados pe on dtrs.CampaniaId = pe.CampaniaId and dtrs.ConsultoraId = pe.ConsultoraId
where dtrs.tipo = ''FRS''
group by dtrs.CampaniaID, dtrs.ConsultoraID, dtrs.CUVOriginal,pe.FechaProceso,pe.fecharegistro

select 
	fad.CampaniaID as Campania, 
	isnull(si.descripcion,'''') TipoConsultora,
	co.Codigo as CodigoConsultora, 
	r.Codigo as Region, 
	z.Codigo as Zona,
	tf.FechaRegistro as FechaRegistroPedido,
	fad.FechaRegistro  as FechaRegistroFaltante,
	pr.CodigoProducto, 
	pr.CodigoTipoOferta, 
	fad.CUV,
	fad.Cantidad,
	fad.cantidad*pr.FactorRepeticion as CantidadPorFactor, 
	''FAD'' as Tipo,
	convert(varchar,tf.FechaProceso,103) FechaProceso,
	'' '' Observacion
from LogIngresoFAD fad with(nolock)
inner hash join @tempFAD tf on fad.LogIngresoFADId = tf.LogIngresoFADId
inner join ods.campania ca with(nolock) on fad.campaniaid = ca.codigo
inner hash join ods.productocomercial pr with(nolock) on ca.campaniaid = pr.campaniaid and fad.cuv = pr.cuv
inner hash join ods.consultora co with(nolock) on fad.ConsultoraId = co.ConsultoraId
inner join ods.region r with(nolock) on co.regionid = r.regionid
inner join ods.zona z with(nolock) on co.zonaid = z.zonaid 
left join ods.SegmentoInterno si with(nolock) on si.segmentointernoid=co.segmentointernoid'+
CASE WHEN LEN(@CODSAP)>0 THEN ' WHERE pr.codigoproducto ='''+@CODSAP+''' ' ELSE ' ' END+'
UNION ALL
select 
	acc.CampaniaID as Campania, 
	isnull(si.descripcion,'''') TipoConsultora,
	co.Codigo as CodigoConsultora, 
	r.Codigo as Region, 
	z.Codigo as Zona, 
	tp.FechaRegistro as FechaRegistroPedido,
	acc.FechaAccion  as FechaRegistroFaltante,
	pr.CodigoProducto, 
	pr.CodigoTipoOferta, 
	acc.CUV,acc.Cantidad,
	acc.cantidad*pr.FactorRepeticion as CantidadPorFactor, 
	''PROL'' as Tipo,
	convert(varchar,tp.FechaProceso,103) FechaProceso, 
	acc.MensajePROL Observacion
from PedidoWebAccionesPROL acc with(nolock)
inner hash join @tempProl tp on acc.PedidoWebAccionesPROLID = tp.PedidoWebAccionesPROLID
inner join ods.campania ca with(nolock) on acc.campaniaid = ca.codigo
inner hash join ods.productocomercial pr with(nolock) on ca.campaniaid = pr.campaniaid and acc.cuv = pr.cuv
inner hash join ods.consultora co with(nolock) on acc.ConsultoraId = co.ConsultoraId
inner join ods.region r with(nolock) on co.regionid = r.regionid
inner join ods.zona z with(nolock) on co.zonaid = z.zonaid 
left join ods.SegmentoInterno si with(nolock) on si.segmentointernoid=co.segmentointernoid'+
CASE WHEN LEN(@CODSAP)>0 THEN ' WHERE pr.codigoproducto ='''+@CODSAP+''' ' ELSE ' ' END+'
UNION ALL
select 
	dtrs.CampaniaID as Campania, 
	isnull(si.descripcion,'''') TipoConsultora,
	co.Codigo as CodigoConsultora, 
	r.Codigo as Region, 
	z.Codigo as Zona,
	tr.FechaRegistro as FechaRegistroPedido,
	dtrs.FechaProceso  as FechaRegistroFaltante,
	pr.CodigoProducto, 
	pr.CodigoTipoOferta, 
	dtrs.CUVOriginal,
	dtrs.Cantidad,
	dtrs.cantidad*pr.FactorRepeticion as CantidadPorFactor, 
	''FRS'' as Tipo,
	convert(varchar,tr.FechaProceso,103) FechaProceso,
	'' '' Observacion
from [dbo].[DemandaTotalReemplazoSugerido] dtrs with(nolock)
inner hash join @tempFRS tr on dtrs.SugeridoID = tr.DemandaTotalReemplazoSugeridoId
inner join ods.campania ca with(nolock) on dtrs.campaniaid = ca.codigo
inner hash join ods.productocomercial pr with(nolock) on ca.campaniaid = pr.campaniaid and dtrs.CUVOriginal = pr.cuv
inner hash join ods.consultora co with(nolock) on dtrs.ConsultoraId = co.ConsultoraId
inner join ods.region r with(nolock) on co.regionid = r.regionid
inner join ods.zona z with(nolock) on co.zonaid = z.zonaid 
left join ods.SegmentoInterno si with(nolock) on si.segmentointernoid=co.segmentointernoid'+
CASE WHEN LEN(@CODSAP)>0 THEN ' WHERE pr.codigoproducto ='''+@CODSAP+''' ' ELSE ' ' END+''

EXEC(@SQLQUERY)
GO

USE [BelcorpDominicana]
GO
/****** Object:  StoredProcedure [dbo].[SB_REPORT_BY_CAMP_FEC]    Script Date: 15/08/2018 18:15:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SB_REPORT_BY_CAMP_FEC] 
(@CAMPANIA VARCHAR(6),@CODSAP VARCHAR(12))

AS

DECLARE @SQLQUERY VARCHAR(8000)

SET @SQLQUERY='
declare @PedidosEnviados table
(
                CampaniaId int,
				ConsultoraId bigint,
                FechaProceso datetime,
				FechaRegistro datetime
)
insert into @PedidosEnviados
select  CampaniaId, ConsultoraId,fechaproceso,fecharegistro
from PedidoWeb with(nolock)
where CAMPANIAID='+@CAMPANIA+' and IndicadorEnviado = 1 

declare @tempFAD table
(
                LogIngresoFADId bigint,
                FechaProceso datetime,
				FechaRegistro datetime
)
insert into @tempFAD
select max(fad.LogIngresoFADId) as LogIngresoFADId,pe.FechaProceso,pe.fecharegistro
from LogIngresoFAD fad with(nolock)
inner hash join @PedidosEnviados pe on fad.CampaniaId = pe.CampaniaId and fad.ConsultoraId = pe.ConsultoraId
group by fad.CampaniaID, fad.ConsultoraID, fad.cuv,pe.FechaProceso,pe.fecharegistro

declare @tempProl table
(
                PedidoWebAccionesPROLID bigint,
               FechaProceso datetime,
			   FechaRegistro datetime
)


insert into @tempProl
select max(PedidoWebAccionesPROLID) as PedidoWebAccionesPROLID,pe.FechaProceso,pe.FechaRegistro
from PedidoWebAccionesPROL acc with(nolock)
inner hash join @PedidosEnviados pe on acc.CampaniaId = pe.CampaniaId and acc.ConsultoraId = pe.ConsultoraId
where (charindex(''stock'',acc.MensajePROL) > 0 or charindex(''agotado'',acc.MensajePROL)>0)
group by acc.CampaniaID, acc.PedidoID, acc.ConsultoraID, acc.CUV,pe.FechaProceso,pe.FechaRegistro

declare @tempFRS table
(
DemandaTotalReemplazoSugeridoId bigint,
FechaProceso datetime,
FechaRegistro datetime
)
insert into @tempFRS
select max(dtrs.SugeridoID) as SugeridoID,pe.FechaProceso,pe.fecharegistro
from [dbo].[DemandaTotalReemplazoSugerido] dtrs with(nolock)
inner join @PedidosEnviados pe on dtrs.CampaniaId = pe.CampaniaId and dtrs.ConsultoraId = pe.ConsultoraId
where dtrs.tipo = ''FRS''
group by dtrs.CampaniaID, dtrs.ConsultoraID, dtrs.CUVOriginal,pe.FechaProceso,pe.fecharegistro

select 
	fad.CampaniaID as Campania, 
	isnull(si.descripcion,'''') TipoConsultora,
	co.Codigo as CodigoConsultora, 
	r.Codigo as Region, 
	z.Codigo as Zona,
	tf.FechaRegistro as FechaRegistroPedido,
	fad.FechaRegistro  as FechaRegistroFaltante,
	pr.CodigoProducto, 
	pr.CodigoTipoOferta, 
	fad.CUV,
	fad.Cantidad,
	fad.cantidad*pr.FactorRepeticion as CantidadPorFactor, 
	''FAD'' as Tipo,
	convert(varchar,tf.FechaProceso,103) FechaProceso,
	'' '' Observacion
from LogIngresoFAD fad with(nolock)
inner hash join @tempFAD tf on fad.LogIngresoFADId = tf.LogIngresoFADId
inner join ods.campania ca with(nolock) on fad.campaniaid = ca.codigo
inner hash join ods.productocomercial pr with(nolock) on ca.campaniaid = pr.campaniaid and fad.cuv = pr.cuv
inner hash join ods.consultora co with(nolock) on fad.ConsultoraId = co.ConsultoraId
inner join ods.region r with(nolock) on co.regionid = r.regionid
inner join ods.zona z with(nolock) on co.zonaid = z.zonaid 
left join ods.SegmentoInterno si with(nolock) on si.segmentointernoid=co.segmentointernoid'+
CASE WHEN LEN(@CODSAP)>0 THEN ' WHERE pr.codigoproducto ='''+@CODSAP+''' ' ELSE ' ' END+'
UNION ALL
select 
	acc.CampaniaID as Campania, 
	isnull(si.descripcion,'''') TipoConsultora,
	co.Codigo as CodigoConsultora, 
	r.Codigo as Region, 
	z.Codigo as Zona, 
	tp.FechaRegistro as FechaRegistroPedido,
	acc.FechaAccion  as FechaRegistroFaltante,
	pr.CodigoProducto, 
	pr.CodigoTipoOferta, 
	acc.CUV,acc.Cantidad,
	acc.cantidad*pr.FactorRepeticion as CantidadPorFactor, 
	''PROL'' as Tipo,
	convert(varchar,tp.FechaProceso,103) FechaProceso, 
	acc.MensajePROL Observacion
from PedidoWebAccionesPROL acc with(nolock)
inner hash join @tempProl tp on acc.PedidoWebAccionesPROLID = tp.PedidoWebAccionesPROLID
inner join ods.campania ca with(nolock) on acc.campaniaid = ca.codigo
inner hash join ods.productocomercial pr with(nolock) on ca.campaniaid = pr.campaniaid and acc.cuv = pr.cuv
inner hash join ods.consultora co with(nolock) on acc.ConsultoraId = co.ConsultoraId
inner join ods.region r with(nolock) on co.regionid = r.regionid
inner join ods.zona z with(nolock) on co.zonaid = z.zonaid 
left join ods.SegmentoInterno si with(nolock) on si.segmentointernoid=co.segmentointernoid'+
CASE WHEN LEN(@CODSAP)>0 THEN ' WHERE pr.codigoproducto ='''+@CODSAP+''' ' ELSE ' ' END+'
UNION ALL
select 
	dtrs.CampaniaID as Campania, 
	isnull(si.descripcion,'''') TipoConsultora,
	co.Codigo as CodigoConsultora, 
	r.Codigo as Region, 
	z.Codigo as Zona,
	tr.FechaRegistro as FechaRegistroPedido,
	dtrs.FechaProceso  as FechaRegistroFaltante,
	pr.CodigoProducto, 
	pr.CodigoTipoOferta, 
	dtrs.CUVOriginal,
	dtrs.Cantidad,
	dtrs.cantidad*pr.FactorRepeticion as CantidadPorFactor, 
	''FRS'' as Tipo,
	convert(varchar,tr.FechaProceso,103) FechaProceso,
	'' '' Observacion
from [dbo].[DemandaTotalReemplazoSugerido] dtrs with(nolock)
inner hash join @tempFRS tr on dtrs.SugeridoID = tr.DemandaTotalReemplazoSugeridoId
inner join ods.campania ca with(nolock) on dtrs.campaniaid = ca.codigo
inner hash join ods.productocomercial pr with(nolock) on ca.campaniaid = pr.campaniaid and dtrs.CUVOriginal = pr.cuv
inner hash join ods.consultora co with(nolock) on dtrs.ConsultoraId = co.ConsultoraId
inner join ods.region r with(nolock) on co.regionid = r.regionid
inner join ods.zona z with(nolock) on co.zonaid = z.zonaid 
left join ods.SegmentoInterno si with(nolock) on si.segmentointernoid=co.segmentointernoid'+
CASE WHEN LEN(@CODSAP)>0 THEN ' WHERE pr.codigoproducto ='''+@CODSAP+''' ' ELSE ' ' END+''

EXEC(@SQLQUERY)
GO

USE [BelcorpEcuador]
GO
/****** Object:  StoredProcedure [dbo].[SB_REPORT_BY_CAMP_FEC]    Script Date: 15/08/2018 18:16:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SB_REPORT_BY_CAMP_FEC] 
(@CAMPANIA VARCHAR(6),@CODSAP VARCHAR(12))

AS

DECLARE @SQLQUERY VARCHAR(8000)

SET @SQLQUERY='
declare @PedidosEnviados table
(
                CampaniaId int,
				ConsultoraId bigint,
                FechaProceso datetime,
				FechaRegistro datetime
)
insert into @PedidosEnviados
select  CampaniaId, ConsultoraId,fechaproceso,fecharegistro
from PedidoWeb with(nolock)
where CAMPANIAID='+@CAMPANIA+' and IndicadorEnviado = 1 

declare @tempFAD table
(
                LogIngresoFADId bigint,
                FechaProceso datetime,
				FechaRegistro datetime
)
insert into @tempFAD
select max(fad.LogIngresoFADId) as LogIngresoFADId,pe.FechaProceso,pe.fecharegistro
from LogIngresoFAD fad with(nolock)
inner hash join @PedidosEnviados pe on fad.CampaniaId = pe.CampaniaId and fad.ConsultoraId = pe.ConsultoraId
group by fad.CampaniaID, fad.ConsultoraID, fad.cuv,pe.FechaProceso,pe.fecharegistro

declare @tempProl table
(
                PedidoWebAccionesPROLID bigint,
               FechaProceso datetime,
			   FechaRegistro datetime
)


insert into @tempProl
select max(PedidoWebAccionesPROLID) as PedidoWebAccionesPROLID,pe.FechaProceso,pe.FechaRegistro
from PedidoWebAccionesPROL acc with(nolock)
inner hash join @PedidosEnviados pe on acc.CampaniaId = pe.CampaniaId and acc.ConsultoraId = pe.ConsultoraId
where (charindex(''stock'',acc.MensajePROL) > 0 or charindex(''agotado'',acc.MensajePROL)>0)
group by acc.CampaniaID, acc.PedidoID, acc.ConsultoraID, acc.CUV,pe.FechaProceso,pe.FechaRegistro

declare @tempFRS table
(
DemandaTotalReemplazoSugeridoId bigint,
FechaProceso datetime,
FechaRegistro datetime
)
insert into @tempFRS
select max(dtrs.SugeridoID) as SugeridoID,pe.FechaProceso,pe.fecharegistro
from [dbo].[DemandaTotalReemplazoSugerido] dtrs with(nolock)
inner join @PedidosEnviados pe on dtrs.CampaniaId = pe.CampaniaId and dtrs.ConsultoraId = pe.ConsultoraId
where dtrs.tipo = ''FRS''
group by dtrs.CampaniaID, dtrs.ConsultoraID, dtrs.CUVOriginal,pe.FechaProceso,pe.fecharegistro

select 
	fad.CampaniaID as Campania, 
	isnull(si.descripcion,'''') TipoConsultora,
	co.Codigo as CodigoConsultora, 
	r.Codigo as Region, 
	z.Codigo as Zona,
	tf.FechaRegistro as FechaRegistroPedido,
	fad.FechaRegistro  as FechaRegistroFaltante,
	pr.CodigoProducto, 
	pr.CodigoTipoOferta, 
	fad.CUV,
	fad.Cantidad,
	fad.cantidad*pr.FactorRepeticion as CantidadPorFactor, 
	''FAD'' as Tipo,
	convert(varchar,tf.FechaProceso,103) FechaProceso,
	'' '' Observacion
from LogIngresoFAD fad with(nolock)
inner hash join @tempFAD tf on fad.LogIngresoFADId = tf.LogIngresoFADId
inner join ods.campania ca with(nolock) on fad.campaniaid = ca.codigo
inner hash join ods.productocomercial pr with(nolock) on ca.campaniaid = pr.campaniaid and fad.cuv = pr.cuv
inner hash join ods.consultora co with(nolock) on fad.ConsultoraId = co.ConsultoraId
inner join ods.region r with(nolock) on co.regionid = r.regionid
inner join ods.zona z with(nolock) on co.zonaid = z.zonaid 
left join ods.SegmentoInterno si with(nolock) on si.segmentointernoid=co.segmentointernoid'+
CASE WHEN LEN(@CODSAP)>0 THEN ' WHERE pr.codigoproducto ='''+@CODSAP+''' ' ELSE ' ' END+'
UNION ALL
select 
	acc.CampaniaID as Campania, 
	isnull(si.descripcion,'''') TipoConsultora,
	co.Codigo as CodigoConsultora, 
	r.Codigo as Region, 
	z.Codigo as Zona, 
	tp.FechaRegistro as FechaRegistroPedido,
	acc.FechaAccion  as FechaRegistroFaltante,
	pr.CodigoProducto, 
	pr.CodigoTipoOferta, 
	acc.CUV,acc.Cantidad,
	acc.cantidad*pr.FactorRepeticion as CantidadPorFactor, 
	''PROL'' as Tipo,
	convert(varchar,tp.FechaProceso,103) FechaProceso, 
	acc.MensajePROL Observacion
from PedidoWebAccionesPROL acc with(nolock)
inner hash join @tempProl tp on acc.PedidoWebAccionesPROLID = tp.PedidoWebAccionesPROLID
inner join ods.campania ca with(nolock) on acc.campaniaid = ca.codigo
inner hash join ods.productocomercial pr with(nolock) on ca.campaniaid = pr.campaniaid and acc.cuv = pr.cuv
inner hash join ods.consultora co with(nolock) on acc.ConsultoraId = co.ConsultoraId
inner join ods.region r with(nolock) on co.regionid = r.regionid
inner join ods.zona z with(nolock) on co.zonaid = z.zonaid 
left join ods.SegmentoInterno si with(nolock) on si.segmentointernoid=co.segmentointernoid'+
CASE WHEN LEN(@CODSAP)>0 THEN ' WHERE pr.codigoproducto ='''+@CODSAP+''' ' ELSE ' ' END+'
UNION ALL
select 
	dtrs.CampaniaID as Campania, 
	isnull(si.descripcion,'''') TipoConsultora,
	co.Codigo as CodigoConsultora, 
	r.Codigo as Region, 
	z.Codigo as Zona,
	tr.FechaRegistro as FechaRegistroPedido,
	dtrs.FechaProceso  as FechaRegistroFaltante,
	pr.CodigoProducto, 
	pr.CodigoTipoOferta, 
	dtrs.CUVOriginal,
	dtrs.Cantidad,
	dtrs.cantidad*pr.FactorRepeticion as CantidadPorFactor, 
	''FRS'' as Tipo,
	convert(varchar,tr.FechaProceso,103) FechaProceso,
	'' '' Observacion
from [dbo].[DemandaTotalReemplazoSugerido] dtrs with(nolock)
inner hash join @tempFRS tr on dtrs.SugeridoID = tr.DemandaTotalReemplazoSugeridoId
inner join ods.campania ca with(nolock) on dtrs.campaniaid = ca.codigo
inner hash join ods.productocomercial pr with(nolock) on ca.campaniaid = pr.campaniaid and dtrs.CUVOriginal = pr.cuv
inner hash join ods.consultora co with(nolock) on dtrs.ConsultoraId = co.ConsultoraId
inner join ods.region r with(nolock) on co.regionid = r.regionid
inner join ods.zona z with(nolock) on co.zonaid = z.zonaid 
left join ods.SegmentoInterno si with(nolock) on si.segmentointernoid=co.segmentointernoid'+
CASE WHEN LEN(@CODSAP)>0 THEN ' WHERE pr.codigoproducto ='''+@CODSAP+''' ' ELSE ' ' END+''

EXEC(@SQLQUERY)
GO

USE [BelcorpGuatemala]
GO
/****** Object:  StoredProcedure [dbo].[SB_REPORT_BY_CAMP_FEC]    Script Date: 15/08/2018 18:17:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SB_REPORT_BY_CAMP_FEC] 
(@CAMPANIA VARCHAR(6),@CODSAP VARCHAR(12))

AS

DECLARE @SQLQUERY VARCHAR(8000)

SET @SQLQUERY='
declare @PedidosEnviados table
(
                CampaniaId int,
				ConsultoraId bigint,
                FechaProceso datetime,
				FechaRegistro datetime
)
insert into @PedidosEnviados
select  CampaniaId, ConsultoraId,fechaproceso,fecharegistro
from PedidoWeb with(nolock)
where CAMPANIAID='+@CAMPANIA+' and IndicadorEnviado = 1 

declare @tempFAD table
(
                LogIngresoFADId bigint,
                FechaProceso datetime,
				FechaRegistro datetime
)
insert into @tempFAD
select max(fad.LogIngresoFADId) as LogIngresoFADId,pe.FechaProceso,pe.fecharegistro
from LogIngresoFAD fad with(nolock)
inner hash join @PedidosEnviados pe on fad.CampaniaId = pe.CampaniaId and fad.ConsultoraId = pe.ConsultoraId
group by fad.CampaniaID, fad.ConsultoraID, fad.cuv,pe.FechaProceso,pe.fecharegistro

declare @tempProl table
(
                PedidoWebAccionesPROLID bigint,
               FechaProceso datetime,
			   FechaRegistro datetime
)


insert into @tempProl
select max(PedidoWebAccionesPROLID) as PedidoWebAccionesPROLID,pe.FechaProceso,pe.FechaRegistro
from PedidoWebAccionesPROL acc with(nolock)
inner hash join @PedidosEnviados pe on acc.CampaniaId = pe.CampaniaId and acc.ConsultoraId = pe.ConsultoraId
where (charindex(''stock'',acc.MensajePROL) > 0 or charindex(''agotado'',acc.MensajePROL)>0)
group by acc.CampaniaID, acc.PedidoID, acc.ConsultoraID, acc.CUV,pe.FechaProceso,pe.FechaRegistro

declare @tempFRS table
(
DemandaTotalReemplazoSugeridoId bigint,
FechaProceso datetime,
FechaRegistro datetime
)
insert into @tempFRS
select max(dtrs.SugeridoID) as SugeridoID,pe.FechaProceso,pe.fecharegistro
from [dbo].[DemandaTotalReemplazoSugerido] dtrs with(nolock)
inner join @PedidosEnviados pe on dtrs.CampaniaId = pe.CampaniaId and dtrs.ConsultoraId = pe.ConsultoraId
where dtrs.tipo = ''FRS''
group by dtrs.CampaniaID, dtrs.ConsultoraID, dtrs.CUVOriginal,pe.FechaProceso,pe.fecharegistro

select 
	fad.CampaniaID as Campania, 
	isnull(si.descripcion,'''') TipoConsultora,
	co.Codigo as CodigoConsultora, 
	r.Codigo as Region, 
	z.Codigo as Zona,
	tf.FechaRegistro as FechaRegistroPedido,
	fad.FechaRegistro  as FechaRegistroFaltante,
	pr.CodigoProducto, 
	pr.CodigoTipoOferta, 
	fad.CUV,
	fad.Cantidad,
	fad.cantidad*pr.FactorRepeticion as CantidadPorFactor, 
	''FAD'' as Tipo,
	convert(varchar,tf.FechaProceso,103) FechaProceso,
	'' '' Observacion
from LogIngresoFAD fad with(nolock)
inner hash join @tempFAD tf on fad.LogIngresoFADId = tf.LogIngresoFADId
inner join ods.campania ca with(nolock) on fad.campaniaid = ca.codigo
inner hash join ods.productocomercial pr with(nolock) on ca.campaniaid = pr.campaniaid and fad.cuv = pr.cuv
inner hash join ods.consultora co with(nolock) on fad.ConsultoraId = co.ConsultoraId
inner join ods.region r with(nolock) on co.regionid = r.regionid
inner join ods.zona z with(nolock) on co.zonaid = z.zonaid 
left join ods.SegmentoInterno si with(nolock) on si.segmentointernoid=co.segmentointernoid'+
CASE WHEN LEN(@CODSAP)>0 THEN ' WHERE pr.codigoproducto ='''+@CODSAP+''' ' ELSE ' ' END+'
UNION ALL
select 
	acc.CampaniaID as Campania, 
	isnull(si.descripcion,'''') TipoConsultora,
	co.Codigo as CodigoConsultora, 
	r.Codigo as Region, 
	z.Codigo as Zona, 
	tp.FechaRegistro as FechaRegistroPedido,
	acc.FechaAccion  as FechaRegistroFaltante,
	pr.CodigoProducto, 
	pr.CodigoTipoOferta, 
	acc.CUV,acc.Cantidad,
	acc.cantidad*pr.FactorRepeticion as CantidadPorFactor, 
	''PROL'' as Tipo,
	convert(varchar,tp.FechaProceso,103) FechaProceso, 
	acc.MensajePROL Observacion
from PedidoWebAccionesPROL acc with(nolock)
inner hash join @tempProl tp on acc.PedidoWebAccionesPROLID = tp.PedidoWebAccionesPROLID
inner join ods.campania ca with(nolock) on acc.campaniaid = ca.codigo
inner hash join ods.productocomercial pr with(nolock) on ca.campaniaid = pr.campaniaid and acc.cuv = pr.cuv
inner hash join ods.consultora co with(nolock) on acc.ConsultoraId = co.ConsultoraId
inner join ods.region r with(nolock) on co.regionid = r.regionid
inner join ods.zona z with(nolock) on co.zonaid = z.zonaid 
left join ods.SegmentoInterno si with(nolock) on si.segmentointernoid=co.segmentointernoid'+
CASE WHEN LEN(@CODSAP)>0 THEN ' WHERE pr.codigoproducto ='''+@CODSAP+''' ' ELSE ' ' END+'
UNION ALL
select 
	dtrs.CampaniaID as Campania, 
	isnull(si.descripcion,'''') TipoConsultora,
	co.Codigo as CodigoConsultora, 
	r.Codigo as Region, 
	z.Codigo as Zona,
	tr.FechaRegistro as FechaRegistroPedido,
	dtrs.FechaProceso  as FechaRegistroFaltante,
	pr.CodigoProducto, 
	pr.CodigoTipoOferta, 
	dtrs.CUVOriginal,
	dtrs.Cantidad,
	dtrs.cantidad*pr.FactorRepeticion as CantidadPorFactor, 
	''FRS'' as Tipo,
	convert(varchar,tr.FechaProceso,103) FechaProceso,
	'' '' Observacion
from [dbo].[DemandaTotalReemplazoSugerido] dtrs with(nolock)
inner hash join @tempFRS tr on dtrs.SugeridoID = tr.DemandaTotalReemplazoSugeridoId
inner join ods.campania ca with(nolock) on dtrs.campaniaid = ca.codigo
inner hash join ods.productocomercial pr with(nolock) on ca.campaniaid = pr.campaniaid and dtrs.CUVOriginal = pr.cuv
inner hash join ods.consultora co with(nolock) on dtrs.ConsultoraId = co.ConsultoraId
inner join ods.region r with(nolock) on co.regionid = r.regionid
inner join ods.zona z with(nolock) on co.zonaid = z.zonaid 
left join ods.SegmentoInterno si with(nolock) on si.segmentointernoid=co.segmentointernoid'+
CASE WHEN LEN(@CODSAP)>0 THEN ' WHERE pr.codigoproducto ='''+@CODSAP+''' ' ELSE ' ' END+''

EXEC(@SQLQUERY)
GO

USE [BelcorpMexico]
GO
/****** Object:  StoredProcedure [dbo].[SB_REPORT_BY_CAMP_FEC]    Script Date: 15/08/2018 18:17:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SB_REPORT_BY_CAMP_FEC] 
(@CAMPANIA VARCHAR(6),@CODSAP VARCHAR(12))

AS

DECLARE @SQLQUERY VARCHAR(8000)

SET @SQLQUERY='
declare @PedidosEnviados table
(
                CampaniaId int,
				ConsultoraId bigint,
                FechaProceso datetime,
				FechaRegistro datetime
)
insert into @PedidosEnviados
select  CampaniaId, ConsultoraId,fechaproceso,fecharegistro
from PedidoWeb with(nolock)
where CAMPANIAID='+@CAMPANIA+' and IndicadorEnviado = 1 

declare @tempFAD table
(
                LogIngresoFADId bigint,
                FechaProceso datetime,
				FechaRegistro datetime
)
insert into @tempFAD
select max(fad.LogIngresoFADId) as LogIngresoFADId,pe.FechaProceso,pe.fecharegistro
from LogIngresoFAD fad with(nolock)
inner hash join @PedidosEnviados pe on fad.CampaniaId = pe.CampaniaId and fad.ConsultoraId = pe.ConsultoraId
group by fad.CampaniaID, fad.ConsultoraID, fad.cuv,pe.FechaProceso,pe.fecharegistro

declare @tempProl table
(
                PedidoWebAccionesPROLID bigint,
               FechaProceso datetime,
			   FechaRegistro datetime
)


insert into @tempProl
select max(PedidoWebAccionesPROLID) as PedidoWebAccionesPROLID,pe.FechaProceso,pe.FechaRegistro
from PedidoWebAccionesPROL acc with(nolock)
inner hash join @PedidosEnviados pe on acc.CampaniaId = pe.CampaniaId and acc.ConsultoraId = pe.ConsultoraId
where (charindex(''stock'',acc.MensajePROL) > 0 or charindex(''agotado'',acc.MensajePROL)>0)
group by acc.CampaniaID, acc.PedidoID, acc.ConsultoraID, acc.CUV,pe.FechaProceso,pe.FechaRegistro

declare @tempFRS table
(
DemandaTotalReemplazoSugeridoId bigint,
FechaProceso datetime,
FechaRegistro datetime
)
insert into @tempFRS
select max(dtrs.SugeridoID) as SugeridoID,pe.FechaProceso,pe.fecharegistro
from [dbo].[DemandaTotalReemplazoSugerido] dtrs with(nolock)
inner join @PedidosEnviados pe on dtrs.CampaniaId = pe.CampaniaId and dtrs.ConsultoraId = pe.ConsultoraId
where dtrs.tipo = ''FRS''
group by dtrs.CampaniaID, dtrs.ConsultoraID, dtrs.CUVOriginal,pe.FechaProceso,pe.fecharegistro

select 
	fad.CampaniaID as Campania, 
	isnull(si.descripcion,'''') TipoConsultora,
	co.Codigo as CodigoConsultora, 
	r.Codigo as Region, 
	z.Codigo as Zona,
	tf.FechaRegistro as FechaRegistroPedido,
	fad.FechaRegistro  as FechaRegistroFaltante,
	pr.CodigoProducto, 
	pr.CodigoTipoOferta, 
	fad.CUV,
	fad.Cantidad,
	fad.cantidad*pr.FactorRepeticion as CantidadPorFactor, 
	''FAD'' as Tipo,
	convert(varchar,tf.FechaProceso,103) FechaProceso,
	'' '' Observacion
from LogIngresoFAD fad with(nolock)
inner hash join @tempFAD tf on fad.LogIngresoFADId = tf.LogIngresoFADId
inner join ods.campania ca with(nolock) on fad.campaniaid = ca.codigo
inner hash join ods.productocomercial pr with(nolock) on ca.campaniaid = pr.campaniaid and fad.cuv = pr.cuv
inner hash join ods.consultora co with(nolock) on fad.ConsultoraId = co.ConsultoraId
inner join ods.region r with(nolock) on co.regionid = r.regionid
inner join ods.zona z with(nolock) on co.zonaid = z.zonaid 
left join ods.SegmentoInterno si with(nolock) on si.segmentointernoid=co.segmentointernoid'+
CASE WHEN LEN(@CODSAP)>0 THEN ' WHERE pr.codigoproducto ='''+@CODSAP+''' ' ELSE ' ' END+'
UNION ALL
select 
	acc.CampaniaID as Campania, 
	isnull(si.descripcion,'''') TipoConsultora,
	co.Codigo as CodigoConsultora, 
	r.Codigo as Region, 
	z.Codigo as Zona, 
	tp.FechaRegistro as FechaRegistroPedido,
	acc.FechaAccion  as FechaRegistroFaltante,
	pr.CodigoProducto, 
	pr.CodigoTipoOferta, 
	acc.CUV,acc.Cantidad,
	acc.cantidad*pr.FactorRepeticion as CantidadPorFactor, 
	''PROL'' as Tipo,
	convert(varchar,tp.FechaProceso,103) FechaProceso, 
	acc.MensajePROL Observacion
from PedidoWebAccionesPROL acc with(nolock)
inner hash join @tempProl tp on acc.PedidoWebAccionesPROLID = tp.PedidoWebAccionesPROLID
inner join ods.campania ca with(nolock) on acc.campaniaid = ca.codigo
inner hash join ods.productocomercial pr with(nolock) on ca.campaniaid = pr.campaniaid and acc.cuv = pr.cuv
inner hash join ods.consultora co with(nolock) on acc.ConsultoraId = co.ConsultoraId
inner join ods.region r with(nolock) on co.regionid = r.regionid
inner join ods.zona z with(nolock) on co.zonaid = z.zonaid 
left join ods.SegmentoInterno si with(nolock) on si.segmentointernoid=co.segmentointernoid'+
CASE WHEN LEN(@CODSAP)>0 THEN ' WHERE pr.codigoproducto ='''+@CODSAP+''' ' ELSE ' ' END+'
UNION ALL
select 
	dtrs.CampaniaID as Campania, 
	isnull(si.descripcion,'''') TipoConsultora,
	co.Codigo as CodigoConsultora, 
	r.Codigo as Region, 
	z.Codigo as Zona,
	tr.FechaRegistro as FechaRegistroPedido,
	dtrs.FechaProceso  as FechaRegistroFaltante,
	pr.CodigoProducto, 
	pr.CodigoTipoOferta, 
	dtrs.CUVOriginal,
	dtrs.Cantidad,
	dtrs.cantidad*pr.FactorRepeticion as CantidadPorFactor, 
	''FRS'' as Tipo,
	convert(varchar,tr.FechaProceso,103) FechaProceso,
	'' '' Observacion
from [dbo].[DemandaTotalReemplazoSugerido] dtrs with(nolock)
inner hash join @tempFRS tr on dtrs.SugeridoID = tr.DemandaTotalReemplazoSugeridoId
inner join ods.campania ca with(nolock) on dtrs.campaniaid = ca.codigo
inner hash join ods.productocomercial pr with(nolock) on ca.campaniaid = pr.campaniaid and dtrs.CUVOriginal = pr.cuv
inner hash join ods.consultora co with(nolock) on dtrs.ConsultoraId = co.ConsultoraId
inner join ods.region r with(nolock) on co.regionid = r.regionid
inner join ods.zona z with(nolock) on co.zonaid = z.zonaid 
left join ods.SegmentoInterno si with(nolock) on si.segmentointernoid=co.segmentointernoid'+
CASE WHEN LEN(@CODSAP)>0 THEN ' WHERE pr.codigoproducto ='''+@CODSAP+''' ' ELSE ' ' END+''

EXEC(@SQLQUERY)
GO

USE [BelcorpPanama]
GO
/****** Object:  StoredProcedure [dbo].[SB_REPORT_BY_CAMP_FEC]    Script Date: 15/08/2018 18:18:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SB_REPORT_BY_CAMP_FEC] 
(@CAMPANIA VARCHAR(6),@CODSAP VARCHAR(12))

AS

DECLARE @SQLQUERY VARCHAR(8000)

SET @SQLQUERY='
declare @PedidosEnviados table
(
                CampaniaId int,
				ConsultoraId bigint,
                FechaProceso datetime,
				FechaRegistro datetime
)
insert into @PedidosEnviados
select  CampaniaId, ConsultoraId,fechaproceso,fecharegistro
from PedidoWeb with(nolock)
where CAMPANIAID='+@CAMPANIA+' and IndicadorEnviado = 1 

declare @tempFAD table
(
                LogIngresoFADId bigint,
                FechaProceso datetime,
				FechaRegistro datetime
)
insert into @tempFAD
select max(fad.LogIngresoFADId) as LogIngresoFADId,pe.FechaProceso,pe.fecharegistro
from LogIngresoFAD fad with(nolock)
inner hash join @PedidosEnviados pe on fad.CampaniaId = pe.CampaniaId and fad.ConsultoraId = pe.ConsultoraId
group by fad.CampaniaID, fad.ConsultoraID, fad.cuv,pe.FechaProceso,pe.fecharegistro

declare @tempProl table
(
                PedidoWebAccionesPROLID bigint,
               FechaProceso datetime,
			   FechaRegistro datetime
)


insert into @tempProl
select max(PedidoWebAccionesPROLID) as PedidoWebAccionesPROLID,pe.FechaProceso,pe.FechaRegistro
from PedidoWebAccionesPROL acc with(nolock)
inner hash join @PedidosEnviados pe on acc.CampaniaId = pe.CampaniaId and acc.ConsultoraId = pe.ConsultoraId
where (charindex(''stock'',acc.MensajePROL) > 0 or charindex(''agotado'',acc.MensajePROL)>0)
group by acc.CampaniaID, acc.PedidoID, acc.ConsultoraID, acc.CUV,pe.FechaProceso,pe.FechaRegistro

declare @tempFRS table
(
DemandaTotalReemplazoSugeridoId bigint,
FechaProceso datetime,
FechaRegistro datetime
)
insert into @tempFRS
select max(dtrs.SugeridoID) as SugeridoID,pe.FechaProceso,pe.fecharegistro
from [dbo].[DemandaTotalReemplazoSugerido] dtrs with(nolock)
inner join @PedidosEnviados pe on dtrs.CampaniaId = pe.CampaniaId and dtrs.ConsultoraId = pe.ConsultoraId
where dtrs.tipo = ''FRS''
group by dtrs.CampaniaID, dtrs.ConsultoraID, dtrs.CUVOriginal,pe.FechaProceso,pe.fecharegistro

select 
	fad.CampaniaID as Campania, 
	isnull(si.descripcion,'''') TipoConsultora,
	co.Codigo as CodigoConsultora, 
	r.Codigo as Region, 
	z.Codigo as Zona,
	tf.FechaRegistro as FechaRegistroPedido,
	fad.FechaRegistro  as FechaRegistroFaltante,
	pr.CodigoProducto, 
	pr.CodigoTipoOferta, 
	fad.CUV,
	fad.Cantidad,
	fad.cantidad*pr.FactorRepeticion as CantidadPorFactor, 
	''FAD'' as Tipo,
	convert(varchar,tf.FechaProceso,103) FechaProceso,
	'' '' Observacion
from LogIngresoFAD fad with(nolock)
inner hash join @tempFAD tf on fad.LogIngresoFADId = tf.LogIngresoFADId
inner join ods.campania ca with(nolock) on fad.campaniaid = ca.codigo
inner hash join ods.productocomercial pr with(nolock) on ca.campaniaid = pr.campaniaid and fad.cuv = pr.cuv
inner hash join ods.consultora co with(nolock) on fad.ConsultoraId = co.ConsultoraId
inner join ods.region r with(nolock) on co.regionid = r.regionid
inner join ods.zona z with(nolock) on co.zonaid = z.zonaid 
left join ods.SegmentoInterno si with(nolock) on si.segmentointernoid=co.segmentointernoid'+
CASE WHEN LEN(@CODSAP)>0 THEN ' WHERE pr.codigoproducto ='''+@CODSAP+''' ' ELSE ' ' END+'
UNION ALL
select 
	acc.CampaniaID as Campania, 
	isnull(si.descripcion,'''') TipoConsultora,
	co.Codigo as CodigoConsultora, 
	r.Codigo as Region, 
	z.Codigo as Zona, 
	tp.FechaRegistro as FechaRegistroPedido,
	acc.FechaAccion  as FechaRegistroFaltante,
	pr.CodigoProducto, 
	pr.CodigoTipoOferta, 
	acc.CUV,acc.Cantidad,
	acc.cantidad*pr.FactorRepeticion as CantidadPorFactor, 
	''PROL'' as Tipo,
	convert(varchar,tp.FechaProceso,103) FechaProceso, 
	acc.MensajePROL Observacion
from PedidoWebAccionesPROL acc with(nolock)
inner hash join @tempProl tp on acc.PedidoWebAccionesPROLID = tp.PedidoWebAccionesPROLID
inner join ods.campania ca with(nolock) on acc.campaniaid = ca.codigo
inner hash join ods.productocomercial pr with(nolock) on ca.campaniaid = pr.campaniaid and acc.cuv = pr.cuv
inner hash join ods.consultora co with(nolock) on acc.ConsultoraId = co.ConsultoraId
inner join ods.region r with(nolock) on co.regionid = r.regionid
inner join ods.zona z with(nolock) on co.zonaid = z.zonaid 
left join ods.SegmentoInterno si with(nolock) on si.segmentointernoid=co.segmentointernoid'+
CASE WHEN LEN(@CODSAP)>0 THEN ' WHERE pr.codigoproducto ='''+@CODSAP+''' ' ELSE ' ' END+'
UNION ALL
select 
	dtrs.CampaniaID as Campania, 
	isnull(si.descripcion,'''') TipoConsultora,
	co.Codigo as CodigoConsultora, 
	r.Codigo as Region, 
	z.Codigo as Zona,
	tr.FechaRegistro as FechaRegistroPedido,
	dtrs.FechaProceso  as FechaRegistroFaltante,
	pr.CodigoProducto, 
	pr.CodigoTipoOferta, 
	dtrs.CUVOriginal,
	dtrs.Cantidad,
	dtrs.cantidad*pr.FactorRepeticion as CantidadPorFactor, 
	''FRS'' as Tipo,
	convert(varchar,tr.FechaProceso,103) FechaProceso,
	'' '' Observacion
from [dbo].[DemandaTotalReemplazoSugerido] dtrs with(nolock)
inner hash join @tempFRS tr on dtrs.SugeridoID = tr.DemandaTotalReemplazoSugeridoId
inner join ods.campania ca with(nolock) on dtrs.campaniaid = ca.codigo
inner hash join ods.productocomercial pr with(nolock) on ca.campaniaid = pr.campaniaid and dtrs.CUVOriginal = pr.cuv
inner hash join ods.consultora co with(nolock) on dtrs.ConsultoraId = co.ConsultoraId
inner join ods.region r with(nolock) on co.regionid = r.regionid
inner join ods.zona z with(nolock) on co.zonaid = z.zonaid 
left join ods.SegmentoInterno si with(nolock) on si.segmentointernoid=co.segmentointernoid'+
CASE WHEN LEN(@CODSAP)>0 THEN ' WHERE pr.codigoproducto ='''+@CODSAP+''' ' ELSE ' ' END+''

EXEC(@SQLQUERY)
GO

USE [BelcorpPuertoRico]
GO
/****** Object:  StoredProcedure [dbo].[SB_REPORT_BY_CAMP_FEC]    Script Date: 15/08/2018 18:19:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SB_REPORT_BY_CAMP_FEC] 
(@CAMPANIA VARCHAR(6),@CODSAP VARCHAR(12))

AS

DECLARE @SQLQUERY VARCHAR(8000)

SET @SQLQUERY='
declare @PedidosEnviados table
(
                CampaniaId int,
				ConsultoraId bigint,
                FechaProceso datetime,
				FechaRegistro datetime
)
insert into @PedidosEnviados
select  CampaniaId, ConsultoraId,fechaproceso,fecharegistro
from PedidoWeb with(nolock)
where CAMPANIAID='+@CAMPANIA+' and IndicadorEnviado = 1 

declare @tempFAD table
(
                LogIngresoFADId bigint,
                FechaProceso datetime,
				FechaRegistro datetime
)
insert into @tempFAD
select max(fad.LogIngresoFADId) as LogIngresoFADId,pe.FechaProceso,pe.fecharegistro
from LogIngresoFAD fad with(nolock)
inner hash join @PedidosEnviados pe on fad.CampaniaId = pe.CampaniaId and fad.ConsultoraId = pe.ConsultoraId
group by fad.CampaniaID, fad.ConsultoraID, fad.cuv,pe.FechaProceso,pe.fecharegistro

declare @tempProl table
(
                PedidoWebAccionesPROLID bigint,
               FechaProceso datetime,
			   FechaRegistro datetime
)


insert into @tempProl
select max(PedidoWebAccionesPROLID) as PedidoWebAccionesPROLID,pe.FechaProceso,pe.FechaRegistro
from PedidoWebAccionesPROL acc with(nolock)
inner hash join @PedidosEnviados pe on acc.CampaniaId = pe.CampaniaId and acc.ConsultoraId = pe.ConsultoraId
where (charindex(''stock'',acc.MensajePROL) > 0 or charindex(''agotado'',acc.MensajePROL)>0)
group by acc.CampaniaID, acc.PedidoID, acc.ConsultoraID, acc.CUV,pe.FechaProceso,pe.FechaRegistro

declare @tempFRS table
(
DemandaTotalReemplazoSugeridoId bigint,
FechaProceso datetime,
FechaRegistro datetime
)
insert into @tempFRS
select max(dtrs.SugeridoID) as SugeridoID,pe.FechaProceso,pe.fecharegistro
from [dbo].[DemandaTotalReemplazoSugerido] dtrs with(nolock)
inner join @PedidosEnviados pe on dtrs.CampaniaId = pe.CampaniaId and dtrs.ConsultoraId = pe.ConsultoraId
where dtrs.tipo = ''FRS''
group by dtrs.CampaniaID, dtrs.ConsultoraID, dtrs.CUVOriginal,pe.FechaProceso,pe.fecharegistro

select 
	fad.CampaniaID as Campania, 
	isnull(si.descripcion,'''') TipoConsultora,
	co.Codigo as CodigoConsultora, 
	r.Codigo as Region, 
	z.Codigo as Zona,
	tf.FechaRegistro as FechaRegistroPedido,
	fad.FechaRegistro  as FechaRegistroFaltante,
	pr.CodigoProducto, 
	pr.CodigoTipoOferta, 
	fad.CUV,
	fad.Cantidad,
	fad.cantidad*pr.FactorRepeticion as CantidadPorFactor, 
	''FAD'' as Tipo,
	convert(varchar,tf.FechaProceso,103) FechaProceso,
	'' '' Observacion
from LogIngresoFAD fad with(nolock)
inner hash join @tempFAD tf on fad.LogIngresoFADId = tf.LogIngresoFADId
inner join ods.campania ca with(nolock) on fad.campaniaid = ca.codigo
inner hash join ods.productocomercial pr with(nolock) on ca.campaniaid = pr.campaniaid and fad.cuv = pr.cuv
inner hash join ods.consultora co with(nolock) on fad.ConsultoraId = co.ConsultoraId
inner join ods.region r with(nolock) on co.regionid = r.regionid
inner join ods.zona z with(nolock) on co.zonaid = z.zonaid 
left join ods.SegmentoInterno si with(nolock) on si.segmentointernoid=co.segmentointernoid'+
CASE WHEN LEN(@CODSAP)>0 THEN ' WHERE pr.codigoproducto ='''+@CODSAP+''' ' ELSE ' ' END+'
UNION ALL
select 
	acc.CampaniaID as Campania, 
	isnull(si.descripcion,'''') TipoConsultora,
	co.Codigo as CodigoConsultora, 
	r.Codigo as Region, 
	z.Codigo as Zona, 
	tp.FechaRegistro as FechaRegistroPedido,
	acc.FechaAccion  as FechaRegistroFaltante,
	pr.CodigoProducto, 
	pr.CodigoTipoOferta, 
	acc.CUV,acc.Cantidad,
	acc.cantidad*pr.FactorRepeticion as CantidadPorFactor, 
	''PROL'' as Tipo,
	convert(varchar,tp.FechaProceso,103) FechaProceso, 
	acc.MensajePROL Observacion
from PedidoWebAccionesPROL acc with(nolock)
inner hash join @tempProl tp on acc.PedidoWebAccionesPROLID = tp.PedidoWebAccionesPROLID
inner join ods.campania ca with(nolock) on acc.campaniaid = ca.codigo
inner hash join ods.productocomercial pr with(nolock) on ca.campaniaid = pr.campaniaid and acc.cuv = pr.cuv
inner hash join ods.consultora co with(nolock) on acc.ConsultoraId = co.ConsultoraId
inner join ods.region r with(nolock) on co.regionid = r.regionid
inner join ods.zona z with(nolock) on co.zonaid = z.zonaid 
left join ods.SegmentoInterno si with(nolock) on si.segmentointernoid=co.segmentointernoid'+
CASE WHEN LEN(@CODSAP)>0 THEN ' WHERE pr.codigoproducto ='''+@CODSAP+''' ' ELSE ' ' END+'
UNION ALL
select 
	dtrs.CampaniaID as Campania, 
	isnull(si.descripcion,'''') TipoConsultora,
	co.Codigo as CodigoConsultora, 
	r.Codigo as Region, 
	z.Codigo as Zona,
	tr.FechaRegistro as FechaRegistroPedido,
	dtrs.FechaProceso  as FechaRegistroFaltante,
	pr.CodigoProducto, 
	pr.CodigoTipoOferta, 
	dtrs.CUVOriginal,
	dtrs.Cantidad,
	dtrs.cantidad*pr.FactorRepeticion as CantidadPorFactor, 
	''FRS'' as Tipo,
	convert(varchar,tr.FechaProceso,103) FechaProceso,
	'' '' Observacion
from [dbo].[DemandaTotalReemplazoSugerido] dtrs with(nolock)
inner hash join @tempFRS tr on dtrs.SugeridoID = tr.DemandaTotalReemplazoSugeridoId
inner join ods.campania ca with(nolock) on dtrs.campaniaid = ca.codigo
inner hash join ods.productocomercial pr with(nolock) on ca.campaniaid = pr.campaniaid and dtrs.CUVOriginal = pr.cuv
inner hash join ods.consultora co with(nolock) on dtrs.ConsultoraId = co.ConsultoraId
inner join ods.region r with(nolock) on co.regionid = r.regionid
inner join ods.zona z with(nolock) on co.zonaid = z.zonaid 
left join ods.SegmentoInterno si with(nolock) on si.segmentointernoid=co.segmentointernoid'+
CASE WHEN LEN(@CODSAP)>0 THEN ' WHERE pr.codigoproducto ='''+@CODSAP+''' ' ELSE ' ' END+''

EXEC(@SQLQUERY)
GO

USE [BelcorpPeru]
GO
/****** Object:  StoredProcedure [dbo].[SB_REPORT_BY_CAMP_FEC]    Script Date: 15/08/2018 18:19:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SB_REPORT_BY_CAMP_FEC] 
(@CAMPANIA VARCHAR(6),@CODSAP VARCHAR(12))

AS

DECLARE @SQLQUERY VARCHAR(8000)

SET @SQLQUERY='
declare @PedidosEnviados table
(
                CampaniaId int,
				ConsultoraId bigint,
                FechaProceso datetime,
				FechaRegistro datetime
)
insert into @PedidosEnviados
select  CampaniaId, ConsultoraId,fechaproceso,fecharegistro
from PedidoWeb with(nolock)
where CAMPANIAID='+@CAMPANIA+' and IndicadorEnviado = 1 

declare @tempFAD table
(
                LogIngresoFADId bigint,
                FechaProceso datetime,
				FechaRegistro datetime
)
insert into @tempFAD
select max(fad.LogIngresoFADId) as LogIngresoFADId,pe.FechaProceso,pe.fecharegistro
from LogIngresoFAD fad with(nolock)
inner hash join @PedidosEnviados pe on fad.CampaniaId = pe.CampaniaId and fad.ConsultoraId = pe.ConsultoraId
group by fad.CampaniaID, fad.ConsultoraID, fad.cuv,pe.FechaProceso,pe.fecharegistro

declare @tempProl table
(
                PedidoWebAccionesPROLID bigint,
               FechaProceso datetime,
			   FechaRegistro datetime
)


insert into @tempProl
select max(PedidoWebAccionesPROLID) as PedidoWebAccionesPROLID,pe.FechaProceso,pe.FechaRegistro
from PedidoWebAccionesPROL acc with(nolock)
inner hash join @PedidosEnviados pe on acc.CampaniaId = pe.CampaniaId and acc.ConsultoraId = pe.ConsultoraId
where (charindex(''stock'',acc.MensajePROL) > 0 or charindex(''agotado'',acc.MensajePROL)>0)
group by acc.CampaniaID, acc.PedidoID, acc.ConsultoraID, acc.CUV,pe.FechaProceso,pe.FechaRegistro

declare @tempFRS table
(
DemandaTotalReemplazoSugeridoId bigint,
FechaProceso datetime,
FechaRegistro datetime
)
insert into @tempFRS
select max(dtrs.SugeridoID) as SugeridoID,pe.FechaProceso,pe.fecharegistro
from [dbo].[DemandaTotalReemplazoSugerido] dtrs with(nolock)
inner join @PedidosEnviados pe on dtrs.CampaniaId = pe.CampaniaId and dtrs.ConsultoraId = pe.ConsultoraId
where dtrs.tipo = ''FRS''
group by dtrs.CampaniaID, dtrs.ConsultoraID, dtrs.CUVOriginal,pe.FechaProceso,pe.fecharegistro

select 
	fad.CampaniaID as Campania, 
	isnull(si.descripcion,'''') TipoConsultora,
	co.Codigo as CodigoConsultora, 
	r.Codigo as Region, 
	z.Codigo as Zona,
	tf.FechaRegistro as FechaRegistroPedido,
	fad.FechaRegistro  as FechaRegistroFaltante,
	pr.CodigoProducto, 
	pr.CodigoTipoOferta, 
	fad.CUV,
	fad.Cantidad,
	fad.cantidad*pr.FactorRepeticion as CantidadPorFactor, 
	''FAD'' as Tipo,
	convert(varchar,tf.FechaProceso,103) FechaProceso,
	'' '' Observacion
from LogIngresoFAD fad with(nolock)
inner hash join @tempFAD tf on fad.LogIngresoFADId = tf.LogIngresoFADId
inner join ods.campania ca with(nolock) on fad.campaniaid = ca.codigo
inner hash join ods.productocomercial pr with(nolock) on ca.campaniaid = pr.campaniaid and fad.cuv = pr.cuv
inner hash join ods.consultora co with(nolock) on fad.ConsultoraId = co.ConsultoraId
inner join ods.region r with(nolock) on co.regionid = r.regionid
inner join ods.zona z with(nolock) on co.zonaid = z.zonaid 
left join ods.SegmentoInterno si with(nolock) on si.segmentointernoid=co.segmentointernoid'+
CASE WHEN LEN(@CODSAP)>0 THEN ' WHERE pr.codigoproducto ='''+@CODSAP+''' ' ELSE ' ' END+'
UNION ALL
select 
	acc.CampaniaID as Campania, 
	isnull(si.descripcion,'''') TipoConsultora,
	co.Codigo as CodigoConsultora, 
	r.Codigo as Region, 
	z.Codigo as Zona, 
	tp.FechaRegistro as FechaRegistroPedido,
	acc.FechaAccion  as FechaRegistroFaltante,
	pr.CodigoProducto, 
	pr.CodigoTipoOferta, 
	acc.CUV,acc.Cantidad,
	acc.cantidad*pr.FactorRepeticion as CantidadPorFactor, 
	''PROL'' as Tipo,
	convert(varchar,tp.FechaProceso,103) FechaProceso, 
	acc.MensajePROL Observacion
from PedidoWebAccionesPROL acc with(nolock)
inner hash join @tempProl tp on acc.PedidoWebAccionesPROLID = tp.PedidoWebAccionesPROLID
inner join ods.campania ca with(nolock) on acc.campaniaid = ca.codigo
inner hash join ods.productocomercial pr with(nolock) on ca.campaniaid = pr.campaniaid and acc.cuv = pr.cuv
inner hash join ods.consultora co with(nolock) on acc.ConsultoraId = co.ConsultoraId
inner join ods.region r with(nolock) on co.regionid = r.regionid
inner join ods.zona z with(nolock) on co.zonaid = z.zonaid 
left join ods.SegmentoInterno si with(nolock) on si.segmentointernoid=co.segmentointernoid'+
CASE WHEN LEN(@CODSAP)>0 THEN ' WHERE pr.codigoproducto ='''+@CODSAP+''' ' ELSE ' ' END+'
UNION ALL
select 
	dtrs.CampaniaID as Campania, 
	isnull(si.descripcion,'''') TipoConsultora,
	co.Codigo as CodigoConsultora, 
	r.Codigo as Region, 
	z.Codigo as Zona,
	tr.FechaRegistro as FechaRegistroPedido,
	dtrs.FechaProceso  as FechaRegistroFaltante,
	pr.CodigoProducto, 
	pr.CodigoTipoOferta, 
	dtrs.CUVOriginal,
	dtrs.Cantidad,
	dtrs.cantidad*pr.FactorRepeticion as CantidadPorFactor, 
	''FRS'' as Tipo,
	convert(varchar,tr.FechaProceso,103) FechaProceso,
	'' '' Observacion
from [dbo].[DemandaTotalReemplazoSugerido] dtrs with(nolock)
inner hash join @tempFRS tr on dtrs.SugeridoID = tr.DemandaTotalReemplazoSugeridoId
inner join ods.campania ca with(nolock) on dtrs.campaniaid = ca.codigo
inner hash join ods.productocomercial pr with(nolock) on ca.campaniaid = pr.campaniaid and dtrs.CUVOriginal = pr.cuv
inner hash join ods.consultora co with(nolock) on dtrs.ConsultoraId = co.ConsultoraId
inner join ods.region r with(nolock) on co.regionid = r.regionid
inner join ods.zona z with(nolock) on co.zonaid = z.zonaid 
left join ods.SegmentoInterno si with(nolock) on si.segmentointernoid=co.segmentointernoid'+
CASE WHEN LEN(@CODSAP)>0 THEN ' WHERE pr.codigoproducto ='''+@CODSAP+''' ' ELSE ' ' END+''

EXEC(@SQLQUERY)
GO

USE [BelcorpSalvador]
GO
/****** Object:  StoredProcedure [dbo].[SB_REPORT_BY_CAMP_FEC]    Script Date: 15/08/2018 18:20:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SB_REPORT_BY_CAMP_FEC] 
(@CAMPANIA VARCHAR(6),@CODSAP VARCHAR(12))

AS

DECLARE @SQLQUERY VARCHAR(8000)

SET @SQLQUERY='
declare @PedidosEnviados table
(
                CampaniaId int,
				ConsultoraId bigint,
                FechaProceso datetime,
				FechaRegistro datetime
)
insert into @PedidosEnviados
select  CampaniaId, ConsultoraId,fechaproceso,fecharegistro
from PedidoWeb with(nolock)
where CAMPANIAID='+@CAMPANIA+' and IndicadorEnviado = 1 

declare @tempFAD table
(
                LogIngresoFADId bigint,
                FechaProceso datetime,
				FechaRegistro datetime
)
insert into @tempFAD
select max(fad.LogIngresoFADId) as LogIngresoFADId,pe.FechaProceso,pe.fecharegistro
from LogIngresoFAD fad with(nolock)
inner hash join @PedidosEnviados pe on fad.CampaniaId = pe.CampaniaId and fad.ConsultoraId = pe.ConsultoraId
group by fad.CampaniaID, fad.ConsultoraID, fad.cuv,pe.FechaProceso,pe.fecharegistro

declare @tempProl table
(
                PedidoWebAccionesPROLID bigint,
               FechaProceso datetime,
			   FechaRegistro datetime
)


insert into @tempProl
select max(PedidoWebAccionesPROLID) as PedidoWebAccionesPROLID,pe.FechaProceso,pe.FechaRegistro
from PedidoWebAccionesPROL acc with(nolock)
inner hash join @PedidosEnviados pe on acc.CampaniaId = pe.CampaniaId and acc.ConsultoraId = pe.ConsultoraId
where (charindex(''stock'',acc.MensajePROL) > 0 or charindex(''agotado'',acc.MensajePROL)>0)
group by acc.CampaniaID, acc.PedidoID, acc.ConsultoraID, acc.CUV,pe.FechaProceso,pe.FechaRegistro

declare @tempFRS table
(
DemandaTotalReemplazoSugeridoId bigint,
FechaProceso datetime,
FechaRegistro datetime
)
insert into @tempFRS
select max(dtrs.SugeridoID) as SugeridoID,pe.FechaProceso,pe.fecharegistro
from [dbo].[DemandaTotalReemplazoSugerido] dtrs with(nolock)
inner join @PedidosEnviados pe on dtrs.CampaniaId = pe.CampaniaId and dtrs.ConsultoraId = pe.ConsultoraId
where dtrs.tipo = ''FRS''
group by dtrs.CampaniaID, dtrs.ConsultoraID, dtrs.CUVOriginal,pe.FechaProceso,pe.fecharegistro

select 
	fad.CampaniaID as Campania, 
	isnull(si.descripcion,'''') TipoConsultora,
	co.Codigo as CodigoConsultora, 
	r.Codigo as Region, 
	z.Codigo as Zona,
	tf.FechaRegistro as FechaRegistroPedido,
	fad.FechaRegistro  as FechaRegistroFaltante,
	pr.CodigoProducto, 
	pr.CodigoTipoOferta, 
	fad.CUV,
	fad.Cantidad,
	fad.cantidad*pr.FactorRepeticion as CantidadPorFactor, 
	''FAD'' as Tipo,
	convert(varchar,tf.FechaProceso,103) FechaProceso,
	'' '' Observacion
from LogIngresoFAD fad with(nolock)
inner hash join @tempFAD tf on fad.LogIngresoFADId = tf.LogIngresoFADId
inner join ods.campania ca with(nolock) on fad.campaniaid = ca.codigo
inner hash join ods.productocomercial pr with(nolock) on ca.campaniaid = pr.campaniaid and fad.cuv = pr.cuv
inner hash join ods.consultora co with(nolock) on fad.ConsultoraId = co.ConsultoraId
inner join ods.region r with(nolock) on co.regionid = r.regionid
inner join ods.zona z with(nolock) on co.zonaid = z.zonaid 
left join ods.SegmentoInterno si with(nolock) on si.segmentointernoid=co.segmentointernoid'+
CASE WHEN LEN(@CODSAP)>0 THEN ' WHERE pr.codigoproducto ='''+@CODSAP+''' ' ELSE ' ' END+'
UNION ALL
select 
	acc.CampaniaID as Campania, 
	isnull(si.descripcion,'''') TipoConsultora,
	co.Codigo as CodigoConsultora, 
	r.Codigo as Region, 
	z.Codigo as Zona, 
	tp.FechaRegistro as FechaRegistroPedido,
	acc.FechaAccion  as FechaRegistroFaltante,
	pr.CodigoProducto, 
	pr.CodigoTipoOferta, 
	acc.CUV,acc.Cantidad,
	acc.cantidad*pr.FactorRepeticion as CantidadPorFactor, 
	''PROL'' as Tipo,
	convert(varchar,tp.FechaProceso,103) FechaProceso, 
	acc.MensajePROL Observacion
from PedidoWebAccionesPROL acc with(nolock)
inner hash join @tempProl tp on acc.PedidoWebAccionesPROLID = tp.PedidoWebAccionesPROLID
inner join ods.campania ca with(nolock) on acc.campaniaid = ca.codigo
inner hash join ods.productocomercial pr with(nolock) on ca.campaniaid = pr.campaniaid and acc.cuv = pr.cuv
inner hash join ods.consultora co with(nolock) on acc.ConsultoraId = co.ConsultoraId
inner join ods.region r with(nolock) on co.regionid = r.regionid
inner join ods.zona z with(nolock) on co.zonaid = z.zonaid 
left join ods.SegmentoInterno si with(nolock) on si.segmentointernoid=co.segmentointernoid'+
CASE WHEN LEN(@CODSAP)>0 THEN ' WHERE pr.codigoproducto ='''+@CODSAP+''' ' ELSE ' ' END+'
UNION ALL
select 
	dtrs.CampaniaID as Campania, 
	isnull(si.descripcion,'''') TipoConsultora,
	co.Codigo as CodigoConsultora, 
	r.Codigo as Region, 
	z.Codigo as Zona,
	tr.FechaRegistro as FechaRegistroPedido,
	dtrs.FechaProceso  as FechaRegistroFaltante,
	pr.CodigoProducto, 
	pr.CodigoTipoOferta, 
	dtrs.CUVOriginal,
	dtrs.Cantidad,
	dtrs.cantidad*pr.FactorRepeticion as CantidadPorFactor, 
	''FRS'' as Tipo,
	convert(varchar,tr.FechaProceso,103) FechaProceso,
	'' '' Observacion
from [dbo].[DemandaTotalReemplazoSugerido] dtrs with(nolock)
inner hash join @tempFRS tr on dtrs.SugeridoID = tr.DemandaTotalReemplazoSugeridoId
inner join ods.campania ca with(nolock) on dtrs.campaniaid = ca.codigo
inner hash join ods.productocomercial pr with(nolock) on ca.campaniaid = pr.campaniaid and dtrs.CUVOriginal = pr.cuv
inner hash join ods.consultora co with(nolock) on dtrs.ConsultoraId = co.ConsultoraId
inner join ods.region r with(nolock) on co.regionid = r.regionid
inner join ods.zona z with(nolock) on co.zonaid = z.zonaid 
left join ods.SegmentoInterno si with(nolock) on si.segmentointernoid=co.segmentointernoid'+
CASE WHEN LEN(@CODSAP)>0 THEN ' WHERE pr.codigoproducto ='''+@CODSAP+''' ' ELSE ' ' END+''

EXEC(@SQLQUERY)
