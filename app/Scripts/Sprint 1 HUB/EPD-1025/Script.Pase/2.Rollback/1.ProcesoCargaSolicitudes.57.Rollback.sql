USE belcorpChile
GO 

ALTER procedure ProcesoCargaSolicitudes
@NumeroLote int
as
begin

/*Variables*/
declare @FechaGeneral datetime        
set @FechaGeneral = dbo.fnObtenerFechaHoraPais()

declare @SolicitudCreditoTemporal table
(
SolicitudCreditoID int, TipoSolicitud varchar(3),
PrefijoPais varchar(3), CodigoConsultora varchar(15), CodigoTerritorio varchar(13), TipoContacto varchar(1), 
CodigoConsultoraRecomienda varchar(15), ApellidoPaterno varchar(15), ApellidoMaterno varchar(15), PrimerNombre varchar(15),
SegundoNombre varchar(15), TipoDocumento varchar(2), NumeroDocumento varchar(15), FechaNacimiento varchar(8), EstadoCivil varchar(2),
NivelEducativo varchar(2), CodigoUbigeo varchar(18), Direccion varchar(140), Telefono varchar(15), Celular varchar(15),
CodigoOtrasMarcas varchar(1), CorreoElectronico varchar(100), DireccionEntrega varchar(140), TelefonoEntrega varchar(15), 
CelularEntrega varchar(15), NombreFamiliar varchar(25), ApellidoFamiliar varchar(25), DireccionFamiliar varchar(35),
TelefonoFamiliar varchar(15), CelularFamiliar varchar(15), TipoVinculoFamiliar varchar(1), NombreNoFamiliar varchar(25), 
ApellidoNoFamiliar varchar(25), DireccionNoFamiliar varchar(35), TelefonoNoFamiliar varchar(15), CelularNoFamiliar varchar(15),
TipoVinculoNoFamiliar varchar(1), PrimerNombreAval varchar(25), ApellidoPaternoAval varchar(25), DireccionAval varchar(35),
TelefonoAval varchar(15), CelularAval varchar(15), TipoDocumentoAval varchar(2), NumeroDocumentoAval varchar(15), 
TipoVinculoAval varchar(1), NumeroPreImpreso varchar(10), FechaCreacion varchar(19), CampaniaID varchar(6), CodigoPremio varchar(5),
ObservacionEntrega varchar(150), ApellidoMaternoAval varchar(25), SegundoNombreAval varchar(25), TipoNacionalidad varchar(4),
Sexo varchar(1), Ciudad varchar(6), TipoVia varchar(2), PoblacionVilla varchar(40), CodigoPostal varchar(5), TipoMeta varchar(1),
MontoMeta varchar(9), DescripcionMeta varchar(50)
)

insert into @SolicitudCreditoTemporal
select
SolicitudCreditoID, TipoSolicitud,
'CLE', CodigoConsultora, 
isnull(LEFT(CodigoZona,2) + LEFT(CodigoZona,4) + REPLICATE('0',6 - LEN(RTRIM(CodigoTerritorio))) + CodigoTerritorio,''),
case when TipoContacto is null then 1 when TipoContacto=0 then 1 else convert(varchar(1),TipoContacto) end,
CodigoConsultoraRecomienda, ApellidoPaterno, ApellidoMaterno, PrimerNombre,
SegundoNombre, TipoDocumento, NumeroDocumento, 
isnull(right('0'+cast(day(FechaNacimiento) as varchar),2)+right('0'+cast(month(FechaNacimiento) as varchar),2)+right('0'+cast(year(FechaNacimiento) as varchar),4),''),
case when EstadoCivil is null then '01' when EstadoCivil='0' then '01' else EstadoCivil end,
case when NivelEducativo is null then '01' when NivelEducativo='0' then '01' else NivelEducativo end,
CodigoUbigeo, Direccion, Telefono, Celular,
case when CodigoOtrasMarcas is null then 0 else convert(varchar(1),CodigoOtrasMarcas) end, 
CorreoElectronico, DireccionEntrega, TelefonoEntrega,
CelularEntrega, NombreFamiliar, ApellidoFamiliar, DireccionFamiliar,
TelefonoFamiliar, CelularFamiliar, 
case when TipoVinculoFamiliar is null then ' ' when TipoVinculoFamiliar=0 then ' ' else convert(varchar(1),TipoVinculoFamiliar) end,
NombreNoFamiliar,
ApellidoNoFamiliar, DireccionNoFamiliar, TelefonoNoFamiliar, CelularNoFamiliar,
case when TipoVinculoNoFamiliar is null then ' ' when TipoVinculoNoFamiliar=0 then ' ' else convert(varchar(1),TipoVinculoNoFamiliar) end,
PrimerNombreAval, ApellidoPaternoAval, DireccionAval,
TelefonoAval, CelularAval, TipoDocumentoAval, NumeroDocumentoAval,
case when TipoVinculoAval is null then ' ' when TipoVinculoAval=0 then ' ' else convert(varchar(1),TipoVinculoAval) end,
NumeroPreimpreso, convert(char(10),FechaCreacion,103) + ' ' + convert(char(8),FechaCreacion,24), 
case when CampaniaID = 0 then '' else convert(varchar(6),CampaniaID) end, CodigoPremio,
ObservacionEntrega, ApellidoMaternoAval, SegundoNombreAval, TipoNacionalidad,
Sexo, Ciudad, TipoVia, PoblacionVilla, '', TipoMeta,
case when MontoMeta > 0 then convert(varchar(9),MontoMeta) else '' end, DescripcionMeta
from SolicitudCredito
where isnull(CodigoLote,0)=0

insert into SolicitudCreditoLog (SolicitudCreditoID,NumeroLote,FechaIngreso)
select SolicitudCreditoID,@NumeroLote,@FechaGeneral
from @SolicitudCreditoTemporal

select 
PrefijoPais as Pais,CodigoConsultora as Consultora,CodigoTerritorio as Territorio,TipoContacto,
CodigoConsultoraRecomienda as ConsultoraRecomienda,ApellidoPaterno,ApellidoMaterno,PrimerNombre,SegundoNombre,TipoDocumento,
NumeroDocumento,FechaNacimiento,EstadoCivil,NivelEducativo,CodigoUbigeo as Ubigeo,Direccion,Telefono,Celular,
CodigoOtrasMarcas as OtrasMarcas,CorreoElectronico as Correo,DireccionEntrega,TelefonoEntrega,CelularEntrega,NombreFamiliar,
ApellidoFamiliar,DireccionFamiliar,TelefonoFamiliar,CelularFamiliar,TipoVinculoFamiliar as VinculoFamiliar,NombreNoFamiliar,
ApellidoNoFamiliar,DireccionNoFamiliar,TelefonoNoFamiliar,CelularNoFamiliar,TipoVinculoNoFamiliar as VinculoNoFamiliar,
PrimerNombreAval,ApellidoPaternoAval,DireccionAval,TelefonoAval,CelularAval,TipoDocumentoAval,NumeroDocumentoAval,
TipoVinculoAval as VinculoAval,NumeroPreImpreso as PreImpreso,FechaCreacion,CampaniaID as Campania,CodigoPremio as Premio,ObservacionEntrega,
ApellidoMaternoAval,SegundoNombreAval,TipoNacionalidad as Nacionalidad,Sexo,Ciudad,TipoVia,PoblacionVilla,CodigoPostal,TipoMeta,
MontoMeta,DescripcionMeta
from @SolicitudCreditoTemporal
where TipoSolicitud = 'INS'

select 
PrefijoPais as Pais,CodigoConsultora as Consultora,CodigoTerritorio as Territorio,TipoContacto,
CodigoConsultoraRecomienda as ConsultoraRecomienda,ApellidoPaterno,ApellidoMaterno,PrimerNombre,SegundoNombre,TipoDocumento,
NumeroDocumento,FechaNacimiento,EstadoCivil,NivelEducativo,CodigoUbigeo as Ubigeo,Direccion,Telefono,Celular,
CodigoOtrasMarcas as OtrasMarcas,CorreoElectronico as Correo,DireccionEntrega,TelefonoEntrega,CelularEntrega,NombreFamiliar,
ApellidoFamiliar,DireccionFamiliar,TelefonoFamiliar,CelularFamiliar,TipoVinculoFamiliar as VinculoFamiliar,NombreNoFamiliar,
ApellidoNoFamiliar,DireccionNoFamiliar,TelefonoNoFamiliar,CelularNoFamiliar,TipoVinculoNoFamiliar as VinculoNoFamiliar,
PrimerNombreAval,ApellidoPaternoAval,DireccionAval,TelefonoAval,CelularAval,TipoDocumentoAval,NumeroDocumentoAval,
TipoVinculoAval as VinculoAval,NumeroPreImpreso as PreImpreso,FechaCreacion,CampaniaID as Campania,CodigoPremio as Premio,ObservacionEntrega,
ApellidoMaternoAval,SegundoNombreAval,TipoNacionalidad as Nacionalidad,Sexo,Ciudad,TipoVia,PoblacionVilla,CodigoPostal,TipoMeta,
MontoMeta,DescripcionMeta
from @SolicitudCreditoTemporal
where TipoSolicitud = 'UPD'

end


GO
----------------------------------------------------------------------------



USE BelcorpDominicana
GO

ALTER procedure ProcesoCargaSolicitudes
@NumeroLote int
as
begin
/*Variables*/
declare @FechaGeneral datetime
set @FechaGeneral = dbo.fnObtenerFechaHoraPais()
declare @SolicitudCreditoTemporal table (
SolicitudCreditoID int,
TipoSolicitud varchar(3),
PrefijoPais varchar(3),
CodigoConsultora varchar(15),
CodigoTerritorio varchar(13),
TipoContacto varchar(1),
CodigoConsultoraRecomienda varchar(15),
ApellidoPaterno varchar(15),
ApellidoMaterno varchar(15),
PrimerNombre varchar(15),
SegundoNombre varchar(15),
TipoDocumento varchar(2),
NumeroDocumento varchar(15),
FechaNacimiento varchar(8),
EstadoCivil varchar(2),
NivelEducativo varchar(2),
CodigoUbigeo varchar(18),
Direccion varchar(140),
Telefono varchar(15),
Celular varchar(15),
CodigoOtrasMarcas varchar(1),
CorreoElectronico varchar(100),
DireccionEntrega varchar(140),
TelefonoEntrega varchar(15),
CelularEntrega varchar(15),
NombreFamiliar varchar(25),
ApellidoFamiliar varchar(25),
DireccionFamiliar varchar(35),
TelefonoFamiliar varchar(15),
CelularFamiliar varchar(15),
TipoVinculoFamiliar varchar(1),
NombreNoFamiliar varchar(25),
ApellidoNoFamiliar varchar(25),
DireccionNoFamiliar varchar(35),
TelefonoNoFamiliar varchar(15),
CelularNoFamiliar varchar(15),
TipoVinculoNoFamiliar varchar(1),
PrimerNombreAval varchar(25),
ApellidoPaternoAval varchar(25),
DireccionAval varchar(35),
TelefonoAval varchar(15),
CelularAval varchar(15),
TipoDocumentoAval varchar(2),
NumeroDocumentoAval varchar(15),
TipoVinculoAval varchar(1),
NumeroPreImpreso varchar(10),
FechaCreacion varchar(19),
CampaniaID varchar(6),
CodigoPremio varchar(5),
ObservacionEntrega varchar(150),
ApellidoMaternoAval varchar(25),
SegundoNombreAval varchar(25),
TipoNacionalidad varchar(4),
Sexo varchar(1),
Ciudad varchar(6),
TipoVia varchar(2),
PoblacionVilla varchar(40),
CodigoPostal varchar(5),
TipoMeta varchar(1),
MontoMeta varchar(9),
DescripcionMeta varchar(50)
)
insert into @SolicitudCreditoTemporal
select
SolicitudCreditoID,
TipoSolicitud,
'DOL',
CodigoConsultora,
isnull(LEFT(CodigoZona,2) + LEFT(CodigoZona,4) + REPLICATE('0',6 - LEN(RTRIM(CodigoTerritorio))) + CodigoTerritorio,''),
case when TipoContacto is null then 1 when TipoContacto=0 then 1 else convert(varchar(1),TipoContacto) end,
CodigoConsultoraRecomienda,
ApellidoPaterno,
ApellidoMaterno,
PrimerNombre,
SegundoNombre,
TipoDocumento,
NumeroDocumento,
isnull(right('0'+cast(day(FechaNacimiento) as varchar),2)+right('0'+cast(month(FechaNacimiento) as varchar),2)+right('0'+cast(year(FechaNacimiento) as varchar),4),''),
case when EstadoCivil is null then '01' when EstadoCivil='0' then '01' else EstadoCivil end,
case when NivelEducativo is null then '01' when NivelEducativo='0' then '01' else NivelEducativo end,
CodigoUbigeo,
convert(char(80),Direccion) + convert(char(60),Referencia),
Telefono,
Celular,
case when CodigoOtrasMarcas is null then 0 else convert(varchar(1),CodigoOtrasMarcas) end,
CorreoElectronico,
convert(char(80),DireccionEntrega) + convert(char(60),ReferenciaEntrega),
TelefonoEntrega,
CelularEntrega,
NombreFamiliar,
ApellidoFamiliar,
DireccionFamiliar,
TelefonoFamiliar,
CelularFamiliar,
case when TipoVinculoFamiliar is null then ' ' when TipoVinculoFamiliar=0 then ' ' else convert(varchar(1),TipoVinculoFamiliar) end,
NombreNoFamiliar,
ApellidoNoFamiliar,
DireccionNoFamiliar,
TelefonoNoFamiliar,
CelularNoFamiliar,
case when TipoVinculoNoFamiliar is null then '' when TipoVinculoNoFamiliar=0 then ' ' else convert(varchar(1),TipoVinculoNoFamiliar) end,
PrimerNombreAval,
ApellidoPaternoAval,
DireccionAval,
TelefonoAval,
CelularAval,
TipoDocumentoAval,
NumeroDocumentoAval,
case when TipoVinculoAval is null then '' when TipoVinculoAval=0 then ' ' else convert(varchar(1),TipoVinculoAval) end,
NumeroPreimpreso,
convert(char(10),FechaCreacion,103) + ' ' + convert(char(8),FechaCreacion,24),
'' as CampaniaID,
CodigoPremio,
ObservacionEntrega,
ApellidoMaternoAval,
SegundoNombreAval,
TipoNacionalidad,
Sexo,
Ciudad,
TipoVia,
PoblacionVilla,
'',
TipoMeta,
case when MontoMeta > 0 then convert(varchar(9),MontoMeta) else '' end,
DescripcionMeta
from SolicitudCredito
where isnull(CodigoLote,0)=0
insert into SolicitudCreditoLog (SolicitudCreditoID,NumeroLote,FechaIngreso)
select SolicitudCreditoID,@NumeroLote,@FechaGeneral
from @SolicitudCreditoTemporal
select
PrefijoPais as Pais,
CodigoConsultora as Consultora,
CodigoTerritorio as Territorio,
TipoContacto,
CodigoConsultoraRecomienda as ConsultoraRecomienda,
ApellidoPaterno,
ApellidoMaterno,
PrimerNombre,
SegundoNombre,
TipoDocumento,
NumeroDocumento,
FechaNacimiento,
EstadoCivil,
NivelEducativo,
CodigoUbigeo as Ubigeo,
Direccion,
Telefono,
Celular,
CodigoOtrasMarcas as OtrasMarcas,
CorreoElectronico as Correo,
DireccionEntrega,
TelefonoEntrega,
CelularEntrega,
NombreFamiliar,
ApellidoFamiliar,
DireccionFamiliar,
TelefonoFamiliar,
CelularFamiliar,
TipoVinculoFamiliar as VinculoFamiliar,
NombreNoFamiliar,
ApellidoNoFamiliar,
DireccionNoFamiliar,
TelefonoNoFamiliar,
CelularNoFamiliar,
TipoVinculoNoFamiliar as VinculoNoFamiliar,
PrimerNombreAval,
ApellidoPaternoAval,
DireccionAval,
TelefonoAval,
CelularAval,
TipoDocumentoAval,
NumeroDocumentoAval,
TipoVinculoAval as VinculoAval,
NumeroPreImpreso AS PreImpreso,
FechaCreacion,
CampaniaID as Campania,
CodigoPremio as Premio,
ObservacionEntrega,
ApellidoMaternoAval,
SegundoNombreAval,
TipoNacionalidad as Nacionalidad,
Sexo,
Ciudad,
TipoVia,
PoblacionVilla,
CodigoPostal,
TipoMeta,
MontoMeta,
DescripcionMeta from
@SolicitudCreditoTemporal
where TipoSolicitud = 'INS'
select
PrefijoPais as Pais,
CodigoConsultora as Consultora,
CodigoTerritorio as Territorio,
TipoContacto,
CodigoConsultoraRecomienda as ConsultoraRecomienda,
ApellidoPaterno,
ApellidoMaterno,
PrimerNombre,
SegundoNombre,
TipoDocumento,
NumeroDocumento,
FechaNacimiento,
EstadoCivil,
NivelEducativo,
CodigoUbigeo as Ubigeo,
Direccion,
Telefono,
Celular,
CodigoOtrasMarcas as OtrasMarcas,
CorreoElectronico as Correo,
DireccionEntrega,
TelefonoEntrega,
CelularEntrega,
NombreFamiliar,
ApellidoFamiliar,
DireccionFamiliar,
TelefonoFamiliar,
CelularFamiliar,
TipoVinculoFamiliar as VinculoFamiliar,
NombreNoFamiliar,
ApellidoNoFamiliar,
DireccionNoFamiliar,
TelefonoNoFamiliar,
CelularNoFamiliar,
TipoVinculoNoFamiliar as VinculoNoFamiliar,
PrimerNombreAval,
ApellidoPaternoAval,
DireccionAval,
TelefonoAval,
CelularAval,
TipoDocumentoAval,
NumeroDocumentoAval,
TipoVinculoAval as VinculoAval,
NumeroPreImpreso AS PreImpreso,
FechaCreacion,
CampaniaID as Campania,
CodigoPremio as Premio,
ObservacionEntrega,
ApellidoMaternoAval,
SegundoNombreAval,
TipoNacionalidad as Nacionalidad,
Sexo,
Ciudad,
TipoVia,
PoblacionVilla,
CodigoPostal,
TipoMeta,
MontoMeta,
DescripcionMeta
from @SolicitudCreditoTemporal
where TipoSolicitud = 'UPD'
end


GO


----------------------------------------------------------------------------

USE BelcorpPuertoRico
GO

ALTER procedure ProcesoCargaSolicitudes 
	@NumeroLote int 
as 
begin 
/*Variables*/ 
declare @FechaGeneral datetime 
set @FechaGeneral = dbo.fnObtenerFechaHoraPais() 
declare @SolicitudCreditoTemporal table ( 
SolicitudCreditoID int, 
TipoSolicitud varchar(3), 
PrefijoPais varchar(3), 
CodigoConsultora varchar(15), 
CodigoTerritorio varchar(13), 
TipoContacto varchar(1), 
CodigoConsultoraRecomienda varchar(15), 
ApellidoPaterno varchar(15), 
ApellidoMaterno varchar(15), 
PrimerNombre varchar(15), 
SegundoNombre varchar(15), 
TipoDocumento varchar(2), 
NumeroDocumento varchar(15), 
FechaNacimiento varchar(8), 
EstadoCivil varchar(2), 
NivelEducativo varchar(2), 
CodigoUbigeo varchar(18), 
Direccion varchar(140), 
Telefono varchar(15), 
Celular varchar(15), 
CodigoOtrasMarcas varchar(1), 
CorreoElectronico varchar(100), 
DireccionEntrega varchar(140), 
TelefonoEntrega varchar(15), 
CelularEntrega varchar(15), 
NombreFamiliar varchar(25), 
ApellidoFamiliar varchar(25), 
DireccionFamiliar varchar(35), 
TelefonoFamiliar varchar(15),
CelularFamiliar varchar(15), 
TipoVinculoFamiliar varchar(1), 
NombreNoFamiliar varchar(25), 
ApellidoNoFamiliar varchar(25), 
DireccionNoFamiliar varchar(35), 
TelefonoNoFamiliar varchar(15), 
CelularNoFamiliar varchar(15), 
TipoVinculoNoFamiliar varchar(1), 
PrimerNombreAval varchar(25), 
ApellidoPaternoAval varchar(25), 
DireccionAval varchar(35), 
TelefonoAval varchar(15), 
CelularAval varchar(15), 
TipoDocumentoAval varchar(2), 
NumeroDocumentoAval varchar(15), 
TipoVinculoAval varchar(1), 
NumeroPreImpreso varchar(10), 
FechaCreacion varchar(19), 
CampaniaID varchar(6), 
CodigoPremio varchar(5), 
ObservacionEntrega varchar(150), 
ApellidoMaternoAval varchar(25), 
SegundoNombreAval varchar(25), 
TipoNacionalidad varchar(4), 
Sexo varchar(1), 
Ciudad varchar(6), 
TipoVia varchar(2), 
PoblacionVilla varchar(40), 
CodigoPostal varchar(5), 
TipoMeta varchar(1), 
MontoMeta varchar(9), 
DescripcionMeta varchar(50) 
) 
insert into @SolicitudCreditoTemporal 
select 
SolicitudCreditoID, 
TipoSolicitud, 
'PRL', 
CodigoConsultora, 
isnull(LEFT(CodigoZona,2) + LEFT(CodigoZona,4) + REPLICATE('0',6 - LEN(RTRIM(CodigoTerritorio))) + CodigoTerritorio,''), 
case when TipoContacto is null then 1 when TipoContacto=0 then 1 else convert(varchar(1),TipoContacto) end, 
CodigoConsultoraRecomienda, 
ApellidoPaterno, 
ApellidoMaterno, 
PrimerNombre, 
SegundoNombre, 
TipoDocumento, 
NumeroDocumento, 
isnull(right('0'+cast(day(FechaNacimiento) as varchar),2)+right('0'+cast(month(FechaNacimiento) as varchar),2)+right('0'+cast(year(FechaNacimiento) as varchar),4),''), 
case when EstadoCivil is null then '01' when EstadoCivil='0' then '01' else EstadoCivil end, 
case when NivelEducativo is null then '01' when NivelEducativo='0' then '01' else NivelEducativo end, 
CodigoUbigeo, 
Direccion, 
Telefono, 
Celular, 
case when CodigoOtrasMarcas is null then 0 else convert(varchar(1),CodigoOtrasMarcas) end, 
CorreoElectronico, 
DireccionEntrega, 
TelefonoEntrega, 
CelularEntrega, 
NombreFamiliar, 
ApellidoFamiliar, 
DireccionFamiliar, 
TelefonoFamiliar, 
CelularFamiliar, 
case when TipoVinculoFamiliar is null then ' ' when TipoVinculoFamiliar=0 then ' ' else convert(varchar(1),TipoVinculoFamiliar) end, 
NombreNoFamiliar, 
ApellidoNoFamiliar, 
DireccionNoFamiliar, 
TelefonoNoFamiliar, 
CelularNoFamiliar, 
case when TipoVinculoNoFamiliar is null then '' when TipoVinculoNoFamiliar=0 then ' ' else convert(varchar(1),TipoVinculoNoFamiliar) end, 
PrimerNombreAval, 
ApellidoPaternoAval, 
DireccionAval, 
TelefonoAval, 
CelularAval, 
TipoDocumentoAval, 
NumeroDocumentoAval, 
case when TipoVinculoAval is null then '' when TipoVinculoAval=0 then ' ' else convert(varchar(1),TipoVinculoAval) end, 
NumeroPreimpreso, 
convert(char(10),FechaCreacion,103) + ' ' + convert(char(8),FechaCreacion,24), 
'' as CampaniaID, 
CodigoPremio, 
ObservacionEntrega, 
ApellidoMaternoAval, 
SegundoNombreAval, 
TipoNacionalidad, 
Sexo, 
Ciudad, 
TipoVia, 
PoblacionVilla, 
CodigoPostal, 
TipoMeta, 
case when MontoMeta > 0 then convert(varchar(9),MontoMeta) else '' end, 
DescripcionMeta 
from SolicitudCredito 
where isnull(CodigoLote,0)=0 

insert into SolicitudCreditoLog (SolicitudCreditoID,NumeroLote,FechaIngreso) 
select SolicitudCreditoID,@NumeroLote,@FechaGeneral 
from @SolicitudCreditoTemporal 

select 
PrefijoPais as Pais,
CodigoConsultora as Consultora,
CodigoTerritorio as Territorio,
TipoContacto, 
CodigoConsultoraRecomienda as ConsultoraRecomienda,
ApellidoPaterno,
ApellidoMaterno,
PrimerNombre,
SegundoNombre,
TipoDocumento, 
NumeroDocumento,
FechaNacimiento,
EstadoCivil,
NivelEducativo,
CodigoUbigeo as Ubigeo,
Direccion,
Telefono,
Celular, 
CodigoOtrasMarcas as OtrasMarcas,
CorreoElectronico as Correo,
DireccionEntrega,
TelefonoEntrega,
CelularEntrega,
NombreFamiliar, 
ApellidoFamiliar,
DireccionFamiliar,
TelefonoFamiliar,
CelularFamiliar,
TipoVinculoFamiliar as VinculoFamiliar,
NombreNoFamiliar, 
ApellidoNoFamiliar,
DireccionNoFamiliar,
TelefonoNoFamiliar,
CelularNoFamiliar,
TipoVinculoNoFamiliar as VinculoNoFamiliar, 
PrimerNombreAval,
ApellidoPaternoAval,
DireccionAval,
TelefonoAval,
CelularAval,
TipoDocumentoAval,
NumeroDocumentoAval, 
TipoVinculoAval as VinculoAval,
NumeroPreImpreso AS PreImpreso,
FechaCreacion,
CampaniaID as Campania,
CodigoPremio as Premio,
ObservacionEntrega, 
ApellidoMaternoAval,
SegundoNombreAval,
TipoNacionalidad as Nacionalidad,
Sexo,
Ciudad,
TipoVia,
PoblacionVilla,
CodigoPostal,
TipoMeta, 
MontoMeta,
DescripcionMeta from 
@SolicitudCreditoTemporal 
where TipoSolicitud = 'INS' 

select 
PrefijoPais as Pais,
CodigoConsultora as Consultora,
CodigoTerritorio as Territorio,
TipoContacto, 
CodigoConsultoraRecomienda as ConsultoraRecomienda,
ApellidoPaterno,
ApellidoMaterno,
PrimerNombre,
SegundoNombre,
TipoDocumento, 
NumeroDocumento,
FechaNacimiento,
EstadoCivil,
NivelEducativo,
CodigoUbigeo as Ubigeo,
Direccion,
Telefono,
Celular, 
CodigoOtrasMarcas as OtrasMarcas,
CorreoElectronico as Correo,
DireccionEntrega,
TelefonoEntrega,
CelularEntrega,
NombreFamiliar, 
ApellidoFamiliar,
DireccionFamiliar,
TelefonoFamiliar,
CelularFamiliar,
TipoVinculoFamiliar as VinculoFamiliar,
NombreNoFamiliar, 
ApellidoNoFamiliar,
DireccionNoFamiliar,
TelefonoNoFamiliar,
CelularNoFamiliar,
TipoVinculoNoFamiliar as VinculoNoFamiliar, 
PrimerNombreAval,
ApellidoPaternoAval,
DireccionAval,
TelefonoAval,
CelularAval,
TipoDocumentoAval,
NumeroDocumentoAval, 
TipoVinculoAval as VinculoAval,
NumeroPreImpreso AS PreImpreso,
FechaCreacion,
CampaniaID as Campania,
CodigoPremio as Premio,
ObservacionEntrega, 
ApellidoMaternoAval,
SegundoNombreAval,
TipoNacionalidad as Nacionalidad,
Sexo,
Ciudad,
TipoVia,
PoblacionVilla,
CodigoPostal,
TipoMeta, 
MontoMeta,
DescripcionMeta 
from @SolicitudCreditoTemporal 
where TipoSolicitud = 'UPD' 
end

GO
-----------------------------------------------------------------------------


USE BelcorpVenezuela
GO

ALTER procedure ProcesoCargaSolicitudes
@NumeroLote int
as
begin

/*Variables*/
declare @FechaGeneral datetime        
set @FechaGeneral = dbo.fnObtenerFechaHoraPais()

declare @SolicitudCreditoTemporal table
(
SolicitudCreditoID int, TipoSolicitud varchar(3),
PrefijoPais varchar(3), CodigoConsultora varchar(15), CodigoTerritorio varchar(13), TipoContacto varchar(1), 
CodigoConsultoraRecomienda varchar(15), ApellidoPaterno varchar(15), ApellidoMaterno varchar(15), PrimerNombre varchar(15),
SegundoNombre varchar(15), TipoDocumento varchar(2), NumeroDocumento varchar(15), FechaNacimiento varchar(8), EstadoCivil varchar(2),
NivelEducativo varchar(2), CodigoUbigeo varchar(18), Direccion varchar(140), Telefono varchar(15), Celular varchar(15),
CodigoOtrasMarcas varchar(1), CorreoElectronico varchar(100), DireccionEntrega varchar(140), TelefonoEntrega varchar(15), 
CelularEntrega varchar(15), NombreFamiliar varchar(25), ApellidoFamiliar varchar(25), DireccionFamiliar varchar(35),
TelefonoFamiliar varchar(15), CelularFamiliar varchar(15), TipoVinculoFamiliar varchar(1), NombreNoFamiliar varchar(25), 
ApellidoNoFamiliar varchar(25), DireccionNoFamiliar varchar(35), TelefonoNoFamiliar varchar(15), CelularNoFamiliar varchar(15),
TipoVinculoNoFamiliar varchar(1), PrimerNombreAval varchar(25), ApellidoPaternoAval varchar(25), DireccionAval varchar(35),
TelefonoAval varchar(15), CelularAval varchar(15), TipoDocumentoAval varchar(2), NumeroDocumentoAval varchar(15), 
TipoVinculoAval varchar(1), NumeroPreImpreso varchar(10), FechaCreacion varchar(19), CampaniaID varchar(6), CodigoPremio varchar(5),
ObservacionEntrega varchar(150), ApellidoMaternoAval varchar(25), SegundoNombreAval varchar(25), TipoNacionalidad varchar(4),
Sexo varchar(1), Ciudad varchar(6), TipoVia varchar(2), PoblacionVilla varchar(40), CodigoPostal varchar(5), TipoMeta varchar(1),
MontoMeta varchar(9), DescripcionMeta varchar(50)
)

insert into @SolicitudCreditoTemporal
select
SolicitudCreditoID, TipoSolicitud,
'VEL', CodigoConsultora, isnull(CodigoTerritorio,''), 
case when TipoContacto is null then 1 when TipoContacto=0 then 1 else convert(varchar(1),TipoContacto) end,
CodigoConsultoraRecomienda, ApellidoPaterno, ApellidoMaterno, PrimerNombre,
SegundoNombre, TipoDocumento, NumeroDocumento, 
isnull(right('0'+cast(day(FechaNacimiento) as varchar),2)+right('0'+cast(month(FechaNacimiento) as varchar),2)+right('0'+cast(year(FechaNacimiento) as varchar),4),''),
case when EstadoCivil is null then '01' when EstadoCivil='0' then '01' else EstadoCivil end,
case when NivelEducativo is null then '01' when NivelEducativo='0' then '01' else NivelEducativo end,
CodigoUbigeo, Direccion, Telefono, Celular,
case when CodigoOtrasMarcas is null then 0 else convert(varchar(1),CodigoOtrasMarcas) end, 
CorreoElectronico, DireccionEntrega, TelefonoEntrega,
CelularEntrega, NombreFamiliar, ApellidoFamiliar, DireccionFamiliar,
TelefonoFamiliar, CelularFamiliar, 
case when TipoVinculoFamiliar is null then ' ' when TipoVinculoFamiliar=0 then ' ' else convert(varchar(1),TipoVinculoFamiliar) end,
NombreNoFamiliar,
ApellidoNoFamiliar, DireccionNoFamiliar, TelefonoNoFamiliar, CelularNoFamiliar,
case when TipoVinculoNoFamiliar is null then ' ' when TipoVinculoNoFamiliar=0 then ' ' else convert(varchar(1),TipoVinculoNoFamiliar) end,
PrimerNombreAval, ApellidoPaternoAval, DireccionAval,
TelefonoAval, CelularAval, TipoDocumentoAval, NumeroDocumentoAval,
case when TipoVinculoAval is null then ' ' when TipoVinculoAval=0 then ' ' else convert(varchar(1),TipoVinculoAval) end,
NumeroPreimpreso, convert(char(10),FechaCreacion,103) + ' ' + convert(char(8),FechaCreacion,24), '', '',
'', '', '', '', '', '', '', '', '', TipoMeta,
case when MontoMeta > 0 then convert(varchar(9),MontoMeta) else '' end, DescripcionMeta
from SolicitudCredito
where isnull(CodigoLote,0)=0

insert into SolicitudCreditoLog (SolicitudCreditoID,NumeroLote,FechaIngreso)
select SolicitudCreditoID,@NumeroLote,@FechaGeneral
from @SolicitudCreditoTemporal

select 
PrefijoPais as Pais,CodigoConsultora as Consultora,CodigoTerritorio as Territorio,TipoContacto,
CodigoConsultoraRecomienda as ConsultoraRecomienda,ApellidoPaterno,ApellidoMaterno,PrimerNombre,SegundoNombre,TipoDocumento,
NumeroDocumento,FechaNacimiento,EstadoCivil,NivelEducativo,CodigoUbigeo as Ubigeo,Direccion,Telefono,Celular,
CodigoOtrasMarcas as OtrasMarcas,CorreoElectronico as Correo,DireccionEntrega,TelefonoEntrega,CelularEntrega,NombreFamiliar,
ApellidoFamiliar,DireccionFamiliar,TelefonoFamiliar,CelularFamiliar,TipoVinculoFamiliar as VinculoFamiliar,NombreNoFamiliar,
ApellidoNoFamiliar,DireccionNoFamiliar,TelefonoNoFamiliar,CelularNoFamiliar,TipoVinculoNoFamiliar as VinculoNoFamiliar,
PrimerNombreAval,ApellidoPaternoAval,DireccionAval,TelefonoAval,CelularAval,TipoDocumentoAval,NumeroDocumentoAval,
TipoVinculoAval as VinculoAval,NumeroPreImpreso AS PreImpreso,FechaCreacion,CampaniaID as Campania,CodigoPremio as Premio,ObservacionEntrega,
ApellidoMaternoAval,SegundoNombreAval,TipoNacionalidad as Nacionalidad,Sexo,Ciudad,TipoVia,PoblacionVilla,CodigoPostal,TipoMeta,
MontoMeta,DescripcionMeta
from @SolicitudCreditoTemporal
where TipoSolicitud = 'INS'

select 
PrefijoPais as Pais,CodigoConsultora as Consultora,CodigoTerritorio as Territorio,TipoContacto,
CodigoConsultoraRecomienda as ConsultoraRecomienda,ApellidoPaterno,ApellidoMaterno,PrimerNombre,SegundoNombre,TipoDocumento,
NumeroDocumento,FechaNacimiento,EstadoCivil,NivelEducativo,CodigoUbigeo as Ubigeo,Direccion,Telefono,Celular,
CodigoOtrasMarcas as OtrasMarcas,CorreoElectronico as Correo,DireccionEntrega,TelefonoEntrega,CelularEntrega,NombreFamiliar,
ApellidoFamiliar,DireccionFamiliar,TelefonoFamiliar,CelularFamiliar,TipoVinculoFamiliar as VinculoFamiliar,NombreNoFamiliar,
ApellidoNoFamiliar,DireccionNoFamiliar,TelefonoNoFamiliar,CelularNoFamiliar,TipoVinculoNoFamiliar as VinculoNoFamiliar,
PrimerNombreAval,ApellidoPaternoAval,DireccionAval,TelefonoAval,CelularAval,TipoDocumentoAval,NumeroDocumentoAval,
TipoVinculoAval as VinculoAval,NumeroPreImpreso AS PreImpreso,FechaCreacion,CampaniaID as Campania,CodigoPremio as Premio,ObservacionEntrega,
ApellidoMaternoAval,SegundoNombreAval,TipoNacionalidad as Nacionalidad,Sexo,Ciudad,TipoVia,PoblacionVilla,CodigoPostal,TipoMeta,
MontoMeta,DescripcionMeta
from @SolicitudCreditoTemporal
where TipoSolicitud = 'UPD'

end

GO

