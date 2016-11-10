GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'Usuario' AND COLUMN_NAME = 'TelefonoTrabajo'
))
BEGIN
	ALTER TABLE dbo.Usuario
	ADD TelefonoTrabajo VARCHAR(20);
END
GO
---------------------------------------------------------------------------------------------------------------
ALTER PROCEDURE GetUsuario
	@CodigoUsuario varchar(20)
AS
BEGIN
select
	U.CodigoUsuario,
	U.CodigoConsultora,
	U.PaisID,
	U.Nombre,
	U.ClaveSecreta,
	U.EMail,
	U.EMailActivo,
	U.Telefono,
	U.TelefonoTrabajo,
	U.Celular,
	U.Sobrenombre,
	U.CompartirDatos,
	U.Activo,
	U.TipoUsuario,
	U.CambioClave,
	U.MostrarAyudaWebTraking,
	CAD.AceptoTerminos as AceptoContrato
from dbo.Usuario U
LEFT JOIN ods.Consultora C on U.CodigoConsultora= C.Codigo
LEFT JOIN dbo.ConsultoraAceptaData CAD on CAD.ConsultoraID = C.ConsultoraID
where U.CodigoUsuario = @CodigoUsuario;
END
GO
---------------------------------------------------------------------------------------------------------------
ALTER PROCEDURE GetUsuarioByEMail
	@EMail varchar(50)
AS
BEGIN
	select
		CodigoUsuario,
		CodigoConsultora,
		PaisID,
		Nombre,
		ClaveSecreta,
		EMail,
		EMailActivo,
		Telefono,
		TelefonoTrabajo,
		Celular,
		Sobrenombre,
		CompartirDatos,
		Activo,
		TipoUsuario,
		CambioClave
	from dbo.Usuario
	where EMail = @EMail and EMailActivo = 1;
END
GO
---------------------------------------------------------------------------------------------------------------
ALTER PROCEDURE UpdUsuarioDatos
	@CodigoUsuario varchar(20),
	@EMail varchar(50),
	@Telefono varchar(20),
	@TelefonoTrabajo varchar(20),
	@Celular varchar(20),
	@Sobrenombre varchar(80),
	@CorreoAnterior varchar (50),
	@CompartirDatos bit,
	@AceptoContrato bit
AS
BEGIN
	UPDATE dbo.Usuario
	SET
		EMailActivo			= CASE @EMail WHEN @CorreoAnterior THEN EMailActivo ELSE 0 END,
		EMail				= @EMail,
		Telefono			= @Telefono,
		TelefonoTrabajo		= @TelefonoTrabajo,
		Celular				= @Celular,
		Sobrenombre			= @Sobrenombre,
		CompartirDatos		= @CompartirDatos,
		Modificado			= 1,
		FechaModificacion	= dbo.fnObtenerFechaHoraPais()
	WHERE CodigoUsuario = @CodigoUsuario;
	
	IF (@AceptoContrato = 1)
	BEGIN
		DECLARE @ConsultoraId BIGINT

		SELECT @ConsultoraId = C.ConsultoraID
		FROM Usuario U 
		LEFT JOIN ods.Consultora C on U.CodigoConsultora= C.Codigo
		WHERE U.CodigoUsuario=@CodigoUsuario

		IF (EXISTS (SELECT * FROM ConsultoraAceptaData WHERE ConsultoraID = @ConsultoraId))
			update ConsultoraAceptaData
			set 
				AceptoTerminos = @AceptoContrato,
				FechaModificacion = getdate()
			where
				ConsultoraID=@ConsultoraId
				and
				AceptoTerminos = 0
		ELSE
			insert into ConsultoraAceptaData(ConsultoraID,AceptoTerminos,FechaCreacion,FechaModificacion)
			values(@ConsultoraId,@AceptoContrato,getdate(),null)
	END
END
GO
---------------------------------------------------------------------------------------------------------------
ALTER PROCEDURE UpdUsuarioDatosPrimeraVez
	@CodigoUsuario varchar(20),
	@EMail varchar(50),
	@Telefono varchar(20),
	@TelefonoTrabajo varchar(20),
	@Celular varchar(20),
	@CorreoAnterior varchar(50),
	@AceptoContrato bit
AS
BEGIN
	UPDATE dbo.Usuario
	SET
		EMail = @EMail,
		Telefono = @Telefono,
		TelefonoTrabajo = @TelefonoTrabajo,
		Celular = @Celular,
		CambioClave = 1,
		Modificado = 1,
		EMailActivo = IIF(@EMail = @CorreoAnterior, EMailActivo, 0),
		FechaModificacion = dbo.fnObtenerFechaHoraPais()
	WHERE CodigoUsuario = @CodigoUsuario;

	DECLARE @ConsultoraId BIGINT
	SELECT @ConsultoraId=C.ConsultoraID
	FROM Usuario U
	LEFT JOIN ods.Consultora C ON U.CodigoConsultora= C.Codigo
	WHERE U.CodigoUsuario=@CodigoUsuario;

	IF (EXISTS(SELECT 1 FROM ConsultoraAceptaData WHERE ConsultoraID = @ConsultoraId))
	BEGIN
		UPDATE ConsultoraAceptaData
		SET 
			AceptoTerminos = @AceptoContrato,
			FechaModificacion = GETDATE()
		WHERE ConsultoraID=@ConsultoraId;
	END
	ELSE
	BEGIN
		INSERT INTO ConsultoraAceptaData(ConsultoraID,AceptoTerminos,FechaCreacion,FechaModificacion)
		VALUES (@ConsultoraId,@AceptoContrato,GETDATE(),NULL);
	END
END
GO
---------------------------------------------------------------------------------------------------------------
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'LogCargaConsultora' AND COLUMN_NAME = 'TelefonoTrabajo'
))
BEGIN
	ALTER TABLE dbo.LogCargaConsultora
	ADD TelefonoTrabajo VARCHAR(50) NULL;
END
GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'LogCargaConsultora' AND COLUMN_NAME = 'Latitud'
))
BEGIN
	ALTER TABLE dbo.LogCargaConsultora
	ADD Latitud VARCHAR(50) NULL;
END
GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'LogCargaConsultora' AND COLUMN_NAME = 'Longitud'
))
BEGIN
	ALTER TABLE dbo.LogCargaConsultora
	ADD Longitud VARCHAR(50) NULL;
END
GO
---------------------------------------------------------------------------------------------------------------
ALTER PROCEDURE GetDatosConsultoraProcesoCarga 
    @NroLote int,
    @CodigoUsuario varchar(25)
AS
BEGIN           
	declare @Fecha datetime
	set @Fecha = dbo.fnObtenerFechaHoraPais();
 
	insert into ConsultoraDescarga (NroLote,Estado,FechaInicio,Usuario)
	values(@NroLote,1,@Fecha,@CodigoUsuario);
 
	insert into LogCargaConsultora (
		NroLote,
		CodigoConsultora,
		Email,
		Telefono,
		TelefonoTrabajo,
		Celular,
		CodigoUsuarioProceso,
		FechaCarga,
		EmailActivo,
		CampaniaActivacionEmail,
		Latitud,
		Longitud
	)
	select
		@NroLote,
		U.CodigoConsultora,
		ISNULL(U.Email,''),
		ISNULL(U.Telefono,''),
		ISNULL(U.TelefonoTrabajo,''),
		ISNULL(U.Celular,''),
		@CodigoUsuario,
		@Fecha,
		U.EmailActivo,
		U.CampaniaActivacionEmail,
		ISNULL(CG.Latitud,''),
		ISNULL(CG.Longitud,'')
	from Usuario U (nolock)
	inner join UsuarioRol UR (nolock) ON U.CodigoUsuario = UR.CodigoUsuario
	inner join Rol R (nolock) ON UR.RolId = R.RolId AND R.Sistema = 1
	left join ConsultoraGeo CG (nolock) ON
		U.CodigoConsultora = CG.Codigo
		AND
		CG.FuenteIngresoID = 1 AND CG.Estado = 1
	where 
		U.CodigoConsultora IS NOT NULL AND ISNULL(U.UsuarioPrueba,0) = 0
		AND
		(
			U.Modificado = 1
			OR
			(CG.Codigo IS NOT NULL AND ISNULL(CG.Enviado,0) = 0)
		);

	select 
		CodigoConsultora,
		Email,
		Telefono,
		TelefonoTrabajo,
		Celular,
		ISNULL(EmailActivo,0) AS EmailActivo,
		ISNULL(CampaniaActivacionEmail,'') AS CampaniaActivacionEmail,
		Latitud,
		Longitud
	from LogCargaConsultora
	where NroLote = @NroLote;
END
GO
---------------------------------------------------------------------------------------------------------------
ALTER PROCEDURE UpdDatosConsultoraIndicadorEnviado
	@NroLote int,
	@Estado tinyint,
	@Mensaje nvarchar(255),
	@NombreArchivo varchar(100) = null,
	@NombreServer varchar(100) = null
AS
BEGIN
	DECLARE @FechaGeneral DATETIME        
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

	if @Estado = 2
	begin
		UPDATE Usuario
		SET Modificado = 0
		WHERE codigoconsultora in (
			SELECT codigoconsultora
			FROM LogCargaConsultora
			WHERE NroLote = @NroLote
		)
		
		UPDATE ConsultoraGeo
		SET Enviado = 1
		WHERE
			Codigo IN (
				SELECT codigoconsultora
				FROM LogCargaConsultora
				WHERE NroLote = @NroLote
			)
			AND
			FuenteIngresoID = 1 AND Estado = 1;
	end

	UPDATE ConsultoraDescarga
	SET FechaFin = @FechaGeneral,
		Estado = @Estado,
		Mensaje = @Mensaje,
		NombreArchivo = @NombreArchivo,
		NombreServer = @NombreServer
	WHERE NroLote = @NroLote;
END
GO