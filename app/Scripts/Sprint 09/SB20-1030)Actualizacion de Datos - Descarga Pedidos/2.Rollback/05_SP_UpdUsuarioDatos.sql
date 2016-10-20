GO
ALTER PROCEDURE UpdUsuarioDatos
	@CodigoUsuario varchar(20),
	@EMail varchar(50),
	@Telefono varchar(20),
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