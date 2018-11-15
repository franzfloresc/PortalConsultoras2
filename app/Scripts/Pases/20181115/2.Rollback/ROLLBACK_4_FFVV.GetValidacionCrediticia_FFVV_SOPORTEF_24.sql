USE BelcorpPeru
GO

alter procedure [FFVV].[GetValidacionCrediticia]
(
@tipoIdentificacion char(2),
@numDocumento varchar(50)
)
as
begin
--exec ffvv.GetValidacionCrediticia '1','0000234330'
Set Transaction Isolation Level Read Uncommitted;
Set NoCount ON;
declare @DatabaseName varchar(30) = null, @DeudaBelcorp numeric(18,5) = 0.0 , @DeudaCastigada numeric(18,5) = 0.0 , @DeudaCastigadaTmp numeric(18,5) = 0.0
, @DeudaBelcorpHist numeric(18,5) = 0.0 , @DeudaCastigadaHist numeric(18,5) = 0.0 , @cantBlqueos int, @valoracionBelcorp varchar(50) = 'APTA', @existeEnHistorico int = 0
, @existeConsultoraTransaccional int = 0, @existeConsultoraHistorico int = 0
Select @DatabaseName = DB_NAME()
set @numDocumento = (select case @DatabaseName
when 'BelcorpPeru' then right('000' + @numDocumento,10)
else @numDocumento end)
select
c.PrimerApellido as primerApellido,
c.PrimerNombre as primerNombre,
c.SegundoApellido as segundoApellido,
c.SegundoNombre as segundoNombre,
'01' as TipoDocumento,
i.numero as DocIdentidad,
c.codigo as CodigoConsultora,
'APTA' as ValoracionBelcorp,
MontoSaldoActual as DeudaBelcorp,
vc.TOTAL_SALDO_DEUDA_CASTIGADA as DeudaCastigada,
0.0 as DeudaEntidadCrediticia,
r.codigo as Region,
z.codigo as Zona,
s.codigo as Seccion,
'' as tipoMoneda,
'' as Moneda,
ea.CodigoEstadoActividad AS codestadoCliente,
ea.descripcion as estadoCliente,
c.AnoCampanaIngreso as CampanaIngreso,
c.UltimaCampanaFacturada as UltimaCampanaFacturada,
c.AutorizaPedido AS AutorizaPedido
into #validacionCrediticia
from ods.consultora c WITH(NOLOCK)
inner join ods.identificacion i WITH(NOLOCK) on c.consultoraid = i.consultoraid
inner join ods.region r WITH(NOLOCK) on r.regionid = c.regionid
inner join ods.zona z WITH(NOLOCK) on z.zonaid = c.zonaid
inner join ods.seccion s WITH(NOLOCK) on s.seccionid = c.seccionid
inner join ods.EstadoActividad ea WITH(NOLOCK) on ea.idEstadoActividad = c.idEstadoActividad
left outer join ods.SOA_VALIDACION_CREDITICIA vc WITH(NOLOCK) on vc.COD_CONSULTORA = c.codigo and i.numero = vc.NUM_DOCUMENTO
where
i.numero = @numDocumento
and c.IndicadorConsultoraDigital <> 1
if @DatabaseName = 'BelcorpColombia' and (select count(*) from #validacionCrediticia) = 0
begin
select
vc.[VAL_APE1] as primerApellido,
vc.[VAL_NOM1] as primerNombre,
vc.[VAL_APE2] as segundoApellido,
vc.[VAL_NOM2] as segundoNombre,
'01' as TipoDocumento,
vc.NUM_DOCUMENTO as DocIdentidad,
case vc.[COD_CONSULTORA] when '' then null else vc.[COD_CONSULTORA] end as CodigoConsultora,
'APTA' as ValoracionBelcorp,
0.0 as DeudaBelcorp,
vc.TOTAL_SALDO_DEUDA_CASTIGADA as DeudaCastigada,
0.0 as DeudaEntidadCrediticia,
vc.[COD_REGI] as Region,
vc.[COD_ZONA] as Zona,
'' as Seccion,
'' as tipoMoneda,
'' as Moneda,
'' as estadoCliente,
'' CampanaIngreso,
'' UltimaCampanaFacturada,
'' codestadoCliente,
0 AutorizaPedido
into #validacionCrediticiaCO
from
ods.SOA_VALIDACION_CREDITICIA vc WITH(NOLOCK)
where vc.NUM_DOCUMENTO = @numDocumento
end
if (@DatabaseName in ('BelcorpPeru','BelcorpEcuador','BelcorpVenezuela')) --transaccional y historicos
begin
select
@DeudaBelcorp = DeudaBelcorp,
@DeudaCastigada = DeudaCastigada
--@DeudaBelcorpHist = DeudaBelcorpHist,
--@DeudaCastigadaHist = DeudaCastigadaHist,
--@DeudaCastigadaTmp = case when DeudaBelcorp <> DeudaCastigada then DeudaCastigada + DeudaCastigadaHist else DeudaCastigadaHist end --deuda castigada acumulada --
from #validacionCrediticia
--select @DeudaBelcorp as DeudaBelcorp, @DeudaCastigada as DeudaCastigada
select
@DeudaBelcorpHist = hvc.SALDO_DEUDA_BELCORP_HIST,
@DeudaCastigadaHist = hvc.TOTAL_SALDO_DEUDA_CASTIGADA_HIST
from ods.SOA_HIST_VALIDACION_CREDITICIA hvc WITH(NOLOCK)
where
hvc.NUM_DOCUMENTO = @numDocumento
if (@DeudaBelcorp <> @DeudaCastigada) --deuda castigada acumulada
set @DeudaCastigadaTmp = (@DeudaCastigada + @DeudaCastigadaHist)
else
set @DeudaCastigadaTmp = @DeudaCastigadaHist
--select @DeudaBelcorp as DeudaBelcorp, @DeudaCastigada as DeudaCastigada, @DeudaBelcorpHist as DeudaBelcorpHist, @DeudaCastigadaHist as DeudaCastigadaHist, @DeudaCastigadaTmp as DeudaCastigadaTmp
set @DeudaBelcorp = @DeudaBelcorp + @DeudaBelcorpHist --deuda belcorp acumulada --108
if (@DeudaBelcorp is not null and @DeudaCastigada is not null)
begin
set @DeudaBelcorp = @DeudaBelcorp + @DeudaCastigadaTmp
end
--select @DeudaBelcorp as DeudaBelcorp
/*************** bloqueos*****************/
select bloq.*
into #BloqueosHist
from
(
select Motivo_Bloqueo as MotivoBloqueo, Tipo_Bloqueo as TipoBloqueo, Observacion_Bloqueo as Observacion
from ods.SOA_MOTIVO_BLOQUEO_X_CONSULTORA WITH(NOLOCK)
where Num_Documento = @numDocumento
union all
select MOTIVO_BLOQUEO as MotivoBloqueo, TIPO_BLOQUEO as TipoBloqueo, OBSERVACION_BLOQUEO as Observacion
from ods.SOA_HIST_MOTIVO_BLOQUEO_X_CONSULTORA WITH(NOLOCK)
where Num_Documento = @numDocumento
) bloq
/*****************************************/
/************************************* Cálculo Valoración usuario **********************************************/
set @existeConsultoraTransaccional = (select count(*) from #validacionCrediticia)
set @existeConsultoraHistorico = (select count(NUM_DOCUMENTO) from ods.SOA_HIST_VALIDACION_CREDITICIA where NUM_DOCUMENTO = @numDocumento)
--si nunca fue consultora
if (@existeConsultoraTransaccional = 0 and @existeConsultoraHistorico = 0)
set @valoracionBelcorp = 'APTA'
else
--es consultora activa
if (select count(estadoCliente) from #validacionCrediticia where upper(estadoCliente) = 'RETIRADA') = 0
begin
set @valoracionBelcorp = 'CONSULTORA'
end
else
begin
set @cantBlqueos = (select count(*) from #BloqueosHist)
if (@DeudaBelcorp > 0 or @cantBlqueos > 0)
begin
if (@DeudaCastigada > 0 or @DeudaCastigadaTmp > 0)
set @valoracionBelcorp = 'INCOBRABLE'
else
set @valoracionBelcorp = 'NO APTA'
end
else
set @valoracionBelcorp = 'APTA'
end
/*****************************************************************************************************************/
--RESULTADO
if ((@existeConsultoraTransaccional > 0 and @existeConsultoraHistorico > 0) or (@existeConsultoraTransaccional > 0 and @existeConsultoraHistorico = 0))
begin
SELECT
PrimerApellido,
PrimerNombre,
segundoApellido,
segundoNombre,
TipoDocumento,
case @DatabaseName
when 'BelcorpPeru' then right('000' + @numDocumento,8)
else @numDocumento end DocIdentidad,
CodigoConsultora,
@valoracionBelcorp as ValoracionBelcorp,
@DeudaBelcorp as DeudaBelcorp,
DeudaEntidadCrediticia,
Region,
Zona,
Seccion,
tipoMoneda,
Moneda,
estadoCliente,
CampanaIngreso,
UltimaCampanaFacturada,
codestadoCliente,
AutorizaPedido
FROM #validacionCrediticia
end
else
if (@existeConsultoraTransaccional = 0 and @existeConsultoraHistorico > 0)
begin
SELECT
APELLIDO1 as primerApellido,
NOMBRE1 as primerNombre,
APELLIDO2 as segundoApellido,
NOMBRE2 as segundoNombre,
COD_TIPO_DOCUMENTO,
case @DatabaseName
when 'BelcorpPeru' then right('000' + @numDocumento,8)
else @numDocumento end DocIdentidad,
COD_CONSULTORA,
@valoracionBelcorp as ValoracionBelcorp,
@DeudaBelcorp as DeudaBelcorp,
0.0 DeudaEntidadCrediticia,
COD_REGION Region,
COD_ZONA Zona,
COD_SECCION Seccion,
'' tipoMoneda,
'' Moneda,
ESTADO_CLIENTE estadoCliente,
'' CampanaIngreso,
'' UltimaCampanaFacturada,
'' codestadoCliente,
0 AutorizaPedido
FROM ods.SOA_HIST_VALIDACION_CREDITICIA where NUM_DOCUMENTO = @numDocumento
end
else
begin --NUNCA FUE CONSULTORA
SELECT
'' primerApellido,
'' primerNombre,
'' segundoApellido,
'' segundoNombre,
'01' TipoDocumento,
@numDocumento DocIdentidad,
'Sin información' CodigoConsultora,
@valoracionBelcorp as ValoracionBelcorp,
@DeudaBelcorp as DeudaBelcorp,
0.0 DeudaEntidadCrediticia,
'' Region,
'' Zona,
'' Seccion,
'' tipoMoneda,
'' Moneda,
'' estadoCliente,
'' CampanaIngreso,
'' UltimaCampanaFacturada,
'' codestadoCliente,
0 AutorizaPedido
end
SELECT MotivoBloqueo, TipoBloqueo, Observacion
FROM #BloqueosHist
end
else
if @DatabaseName = 'BelcorpColombia' and (select count(*) from #validacionCrediticia) = 0
begin
set @DeudaCastigadaTmp = 0
select
@DeudaBelcorp = DeudaBelcorp,
@DeudaCastigada = DeudaCastigada
from #validacionCrediticiaCO
if (@DeudaBelcorp <> @DeudaCastigada) --deuda castigada
set @DeudaCastigadaTmp = (@DeudaCastigada)
else
set @DeudaCastigadaTmp = 0.0
if (@DeudaBelcorp is not null and @DeudaCastigada is not null)
set @DeudaBelcorp = @DeudaBelcorp + @DeudaCastigadaTmp
/*************** bloqueos*****************/
select bloq.*
into #BloqueosCO
from
(
select Motivo_Bloqueo as MotivoBloqueo, Tipo_Bloqueo as TipoBloqueo, Observacion_Bloqueo as Observacion
from ods.SOA_MOTIVO_BLOQUEO_X_CONSULTORA WITH(NOLOCK)
where Num_Documento = @numDocumento
) bloq
/*****************************************/
/************************************* Cálculo Valoración usuario **********************************************/
----si nunca fue consultora
--if (select count(*) from #validacionCrediticia) = 0
--	set @valoracionBelcorp = 'APTA'
--else
--es consultora activa
--if (select count(estadoCliente) from #validacionCrediticia where upper(estadoCliente) = 'RETIRADA') = 0
--	begin
--	set @valoracionBelcorp = 'CONSULTORA'
--	end
--	else
--	begin
set @cantBlqueos = (select count(*) from #BloqueosCO)
if (@DeudaBelcorp > 0 or @cantBlqueos > 0)
begin
if (@DeudaBelcorp > 0 or @DeudaCastigadaTmp > 0 or @DeudaCastigada>0)
set @valoracionBelcorp = 'INCOBRABLE'
else
set @valoracionBelcorp = 'NO APTA'
end
else
set @valoracionBelcorp = 'APTA'
-- CAMBIO HECHO POR GR PARA MOSTRAR SEÑORA SIN CODIGO DE CONSULTORA CON DEUDA PERO SIN BLOQUEOS
if (@cantBlqueos = 0 AND @DeudaCastigada > 0)
begin
insert into #BloqueosCO (MotivoBloqueo, TipoBloqueo, Observacion)
values ('DeudaCastigada',@valoracionBelcorp,'DeudaCastigada')
End
--end
/*****************************************************************************************************************/
--RESULTADO
--si nunca fue consultora
--if (select count(*) from #validacionCrediticia) = 0
--begin
--SELECT
--	'' primerApellido,
--	'' primerNombre,
--	'' segundoApellido,
--	'' segundoNombre,
--	'01' TipoDocumento,
--	@numDocumento DocIdentidad,
--	'Sin información' CodigoConsultora,
--	@valoracionBelcorp as ValoracionBelcorp,
--	@DeudaBelcorp as DeudaBelcorp,
--	0.0 DeudaEntidadCrediticia,
--	'' Region,
--	'' Zona,
--	'' Seccion,
--	'' tipoMoneda,
--	'' Moneda,
--	'' estadoCliente
--end
--else
SELECT
primerApellido,
primerNombre,
segundoApellido,
segundoNombre,
TipoDocumento,
DocIdentidad,
ISNULL(CodigoConsultora,DocIdentidad) CodigoConsultora,
@valoracionBelcorp as ValoracionBelcorp,
@DeudaBelcorp as DeudaBelcorp,
DeudaEntidadCrediticia,
Region,
Zona,
Seccion,
tipoMoneda,
Moneda,
estadoCliente,
codestadoCliente,
AutorizaPedido
FROM #validacionCrediticiaCO
SELECT MotivoBloqueo, TipoBloqueo, Observacion
FROM #BloqueosCO
end
else
begin -- transaccional , resto países
set @DeudaCastigadaTmp = 0
select
@DeudaBelcorp = DeudaBelcorp,
@DeudaCastigada = DeudaCastigada
from #validacionCrediticia
if (@DeudaBelcorp <> @DeudaCastigada) --deuda castigada
set @DeudaCastigadaTmp = (@DeudaCastigada)
else
set @DeudaCastigadaTmp = 0.0
if (@DeudaBelcorp is not null and @DeudaCastigada is not null)
set @DeudaBelcorp = @DeudaBelcorp + @DeudaCastigadaTmp
/*************** bloqueos*****************/
select bloq.*
into #Bloqueos
from
(
select Motivo_Bloqueo as MotivoBloqueo, Tipo_Bloqueo as TipoBloqueo, Observacion_Bloqueo as Observacion
from ods.SOA_MOTIVO_BLOQUEO_X_CONSULTORA WITH(NOLOCK)
where Num_Documento = @numDocumento
) bloq
/*****************************************/
/************************************* Cálculo Valoración usuario **********************************************/
--si nunca fue consultora
if (select count(*) from #validacionCrediticia) = 0
set @valoracionBelcorp = 'APTA'
else
--es consultora activa
if (select count(estadoCliente) from #validacionCrediticia where upper(estadoCliente) = 'RETIRADA') = 0
begin
set @valoracionBelcorp = 'CONSULTORA'
end
else
begin
set @cantBlqueos = (select count(*) from #Bloqueos)
if (@DeudaBelcorp > 0 or @cantBlqueos > 0)
begin
if (@DeudaCastigada > 0 or @DeudaCastigadaTmp > 0 or @DeudaCastigada>0)
set @valoracionBelcorp = 'INCOBRABLE'
else
set @valoracionBelcorp = 'NO APTA'
end
else
set @valoracionBelcorp = 'APTA'
end
/*****************************************************************************************************************/
--RESULTADO
--si nunca fue consultora
if (select count(*) from #validacionCrediticia) = 0
begin
SELECT
'' primerApellido,
'' primerNombre,
'' segundoApellido,
'' segundoNombre,
'01' TipoDocumento,
@numDocumento DocIdentidad,
'Sin información' CodigoConsultora,
@valoracionBelcorp as ValoracionBelcorp,
@DeudaBelcorp as DeudaBelcorp,
0.0 DeudaEntidadCrediticia,
'' Region,
'' Zona,
'' Seccion,
'' tipoMoneda,
'' Moneda,
'' estadoCliente,
'' codestadoCliente,
0 AutorizaPedido
end
else
SELECT
primerApellido,
primerNombre,
segundoApellido,
segundoNombre,
TipoDocumento,
DocIdentidad,
ISNULL(CodigoConsultora,DocIdentidad) CodigoConsultora,
@valoracionBelcorp as ValoracionBelcorp,
@DeudaBelcorp as DeudaBelcorp,
DeudaEntidadCrediticia,
Region,
Zona,
Seccion,
tipoMoneda,
Moneda,
estadoCliente,
CampanaIngreso,
UltimaCampanaFacturada,
codestadoCliente,
AutorizaPedido
FROM #validacionCrediticia
SELECT MotivoBloqueo, TipoBloqueo, Observacion
FROM #Bloqueos
end
end