USE BelcorpMexico
GO

ALTER PROCEDURE [dbo].[ProcesoCargaSolicitudes]

	@NumeroLote INT

AS

BEGIN

/*

	EXEC ProcesoCargaSolicitudes 0

*/

	/*Variables*/

	DECLARE @FechaGeneral DATETIME

	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

	DECLARE @SolicitudCreditoTemporal TABLE (

		SolicitudCreditoID			INT,

		TipoSolicitud				VARCHAR(3),

		PrefijoPais					VARCHAR(3),

		CodigoConsultora			VARCHAR(15),

		CodigoTerritorio			VARCHAR(13),

		TipoContacto				VARCHAR(1),

		CodigoConsultoraRecomienda	VARCHAR(15),

		ApellidoPaterno				VARCHAR(15),

		ApellidoMaterno				VARCHAR(15),

		PrimerNombre				VARCHAR(15),

		SegundoNombre				VARCHAR(15),

		TipoDocumento				VARCHAR(2),

		NumeroDocumento				VARCHAR(15),

		FechaNacimiento				VARCHAR(8),

		EstadoCivil					VARCHAR(2),

		NivelEducativo				VARCHAR(2),

		CodigoUbigeo				VARCHAR(24),

		--Direccion					VARCHAR(140),
		Direccion					VARCHAR(460),

		Telefono					VARCHAR(15),

		Celular						VARCHAR(15),

		CodigoOtrasMarcas			VARCHAR(1),

		CorreoElectronico			VARCHAR(100),

		DireccionEntrega			VARCHAR(140),

		TelefonoEntrega				VARCHAR(15),

		CelularEntrega				VARCHAR(15),

		NombreFamiliar				VARCHAR(25),

		ApellidoFamiliar			VARCHAR(25),

		DireccionFamiliar			VARCHAR(35),

		TelefonoFamiliar			VARCHAR(15),

		CelularFamiliar				VARCHAR(15),

		TipoVinculoFamiliar			VARCHAR(1),

		NombreNoFamiliar			VARCHAR(25),

		ApellidoNoFamiliar			VARCHAR(25),

		DireccionNoFamiliar			VARCHAR(35),

		TelefonoNoFamiliar			VARCHAR(15),

		CelularNoFamiliar			VARCHAR(15),

		TipoVinculoNoFamiliar		VARCHAR(1),

		PrimerNombreAval			VARCHAR(25),

		ApellidoPaternoAval			VARCHAR(25),

		DireccionAval				VARCHAR(35),

		TelefonoAval				VARCHAR(15),

		CelularAval					VARCHAR(15),

		TipoDocumentoAval			VARCHAR(2),

		NumeroDocumentoAval			VARCHAR(15),

		TipoVinculoAval				VARCHAR(1),

		NumeroPreImpreso			VARCHAR(10),

		FechaCreacion				VARCHAR(19),

		CampaniaID					VARCHAR(6),

		CodigoPremio				VARCHAR(5),

		ObservacionEntrega			VARCHAR(150),

		ApellidoMaternoAval			VARCHAR(25),

		SegundoNombreAval			VARCHAR(25),

		TipoNacionalidad			VARCHAR(4),

		Sexo						VARCHAR(1),

		Ciudad						VARCHAR(6),

		TipoVia						VARCHAR(2),

		PoblacionVilla				VARCHAR(40),

		CodigoPostal				VARCHAR(5),

		TipoMeta					VARCHAR(1),

		MontoMeta					VARCHAR(9),

		DescripcionMeta				VARCHAR(50)

	)



	INSERT INTO @SolicitudCreditoTemporal

	SELECT

		SolicitudCreditoID,

		TipoSolicitud,

		'MXL', --R2380

		CodigoConsultora,

		isnull(LEFT(CodigoZona,2) + LEFT(CodigoZona,4) + REPLICATE('0',6 - LEN(RTRIM(CodigoTerritorio))) + CodigoTerritorio,''),

		case when TipoContacto is null then 1 when TipoContacto=0 then 1 else convert(VARCHAR(1),TipoContacto) end,

		CodigoConsultoraRecomienda,

		ApellidoPaterno,

		ApellidoMaterno,

		Nombres PrimerNombre,

		'' SegundoNombre,

		'01' TipoDocumento,

		NumeroRFC NumeroDocumento,

		isnull(right('0'+cast(day(FechaNacimiento) as VARCHAR),2)+right('0'+cast(month(FechaNacimiento) as VARCHAR),2)+right('0'+cast(year(FechaNacimiento) as VARCHAR),4),''),

		case when EstadoCivil is null then '01' when EstadoCivil='0' then '01' when EstadoCivil>0 then '0'+ convert(varchar(2),EstadoCivil) else EstadoCivil end, --R2380

		case when NivelEducativo is null then '01' when NivelEducativo='0' then '01' when EstadoCivil>0 then '0'+ convert(varchar(2),EstadoCivil)  else NivelEducativo end, --R2380

		LEFT(CodigoUbigeo + Colonia, 24) CodigoUbigeo,

		--CONVERT(CHAR(40),Direccion)+CONVERT(CHAR(100),Referencia),
		CONVERT(CHAR(60),Direccion)+CONVERT(CHAR(400),Referencia),

		Telefono,

		Celular,

		case when CodigoOtrasMarcas is null then 0 else convert(VARCHAR(1),CodigoOtrasMarcas) end,

		CorreoElectronico,

		'' DireccionEntrega,

		'' TelefonoEntrega,

		'' CelularEntrega,

		NombreFamiliar,

		'' ApellidoFamiliar,

		DireccionFamiliar,

		TelefonoFamiliar,

		CelularFamiliar,

		case when TipoVinculoFamiliar is null then '' when TipoVinculoFamiliar=0 then '' else convert(VARCHAR(1),TipoVinculoFamiliar) end,

		NombreNoFamiliar,

		'' ApellidoNoFamiliar,

		DireccionNoFamiliar,

		TelefonoNoFamiliar,

		CelularNoFamiliar,

		case when TipoVinculoNoFamiliar is null then '' when TipoVinculoNoFamiliar=0 then '' else convert(VARCHAR(1),TipoVinculoNoFamiliar) end,

		'' PrimerNombreAval,

		'' ApellidoPaternoAval,

		'' DireccionAval,

		'' TelefonoAval,

		'' CelularAval,

		'' TipoDocumentoAval,

		'' NumeroDocumentoAval,

		'' TipoVinculoAval,

		RTRIM(LTRIM(NumeroPreimpreso)) NumeroPreimpreso,

		LEFT(convert(char(10),FechaCreacion,103) + ' ' + convert(char(8),FechaCreacion,24), 19),

		case when CampaniaID is null or CampaniaID =0 then '' else convert(VARCHAR(6),CampaniaID) END AS CampaniaID, --R2380

		'' CodigoPremio,

		'' ObservacionEntrega,

		'' ApellidoMaternoAval,

		'' SegundoNombreAval,

		'' TipoNacionalidad,

		'' Sexo,

		'' Ciudad,

		'' TipoVia,

		'' PoblacionVilla,

		LEFT(CodigoPostal, 5) CodigoPostal,

		'' TipoMeta,

		'' MontoMeta,

		'' DescripcionMeta

	FROM SolicitudCredito

	WHERE isnull(CodigoLote,0) = 0



	INSERT INTO SolicitudCreditoLog (SolicitudCreditoID,NumeroLote,FechaIngreso)

	SELECT SolicitudCreditoID,@NumeroLote,@FechaGeneral

	FROM @SolicitudCreditoTemporal

	

	SELECT

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

	FROM

		@SolicitudCreditoTemporal

	WHERE TipoSolicitud = 'INS'



	SELECT

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

	FROM 

	@SolicitudCreditoTemporal

	WHERE TipoSolicitud = 'UPD'

END



GO
