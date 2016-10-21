GO
ALTER PROCEDURE UpdUsuarioDatosPrimeraVez
 @CodigoUsuario varchar(20),  
 @EMail varchar(50),  
 @Telefono varchar(20),  
 @Celular varchar(20),  
 @CorreoAnterior varchar(50),
 @AceptoContrato bit
as
BEGIN
if (@EMail = @CorreoAnterior)  
begin  
 update dbo.Usuario  
 set EMail = @EMail,  
  Telefono = @Telefono, Celular = @Celular,
    CambioClave = 1,
	Modificado = 1,
	FechaModificacion = dbo.fnObtenerFechaHoraPais()
 where CodigoUsuario = @CodigoUsuario  
end  
else  
begin  
 update dbo.Usuario  
 set EMail = @EMail,  
	Telefono = @Telefono, Celular = @Celular,
	CambioClave = 1,  
	EMailActivo = 0,
	Modificado = 1,
	FechaModificacion = dbo.fnObtenerFechaHoraPais()
 where CodigoUsuario = @CodigoUsuario  
end

Declare @ConsultoraId bigint
	Select @ConsultoraId=C.ConsultoraID From Usuario U left join ods.Consultora C on U.CodigoConsultora= C.Codigo Where U.CodigoUsuario=@CodigoUsuario --CO 585
	IF (EXISTS (SELECT * FROM ConsultoraAceptaData Where ConsultoraID = @ConsultoraId))
		BEGIN
			Update ConsultoraAceptaData Set AceptoTerminos = @AceptoContrato, FechaModificacion = getdate() Where ConsultoraID=@ConsultoraId
		END
	ELSE
		BEGIN
			Insert Into ConsultoraAceptaData  (ConsultoraID,AceptoTerminos,FechaCreacion,FechaModificacion)VALUES (@ConsultoraId,@AceptoContrato,getdate(),null)
		END
END
GO