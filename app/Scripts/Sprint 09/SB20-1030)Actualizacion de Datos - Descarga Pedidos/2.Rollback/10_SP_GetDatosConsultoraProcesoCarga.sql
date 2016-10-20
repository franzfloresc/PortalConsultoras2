GO
ALTER PROCEDURE GetDatosConsultoraProcesoCarga 
    @NroLote int,
    @CodigoUsuario varchar(25)
AS
BEGIN           
	declare @Fecha datetime
	set @Fecha = dbo.fnObtenerFechaHoraPais()
 
	insert into ConsultoraDescarga (NroLote,Estado,FechaInicio,Usuario)
	values(@NroLote,1,@Fecha,@CodigoUsuario)
 
	insert into LogCargaConsultora (NroLote,CodigoConsultora,Email,Telefono,Celular,CodigoUsuarioProceso,FechaCarga, EmailActivo, CampaniaActivacionEmail)
	select @NroLote, u.CodigoConsultora, ISNULL(u.Email,''), ISNULL(u.Telefono,''), ISNULL(u.Celular,''), @CodigoUsuario, @Fecha, u.EmailActivo, u.CampaniaActivacionEmail
	from usuario u (nolock) 
	inner join usuariorol ur (nolock) on u.codigousuario = ur.codigousuario
	inner join rol r (nolock) on ur.rolid = r.rolid
	where u.Modificado = 1 and Sistema = 1 and u.CodigoConsultora is not null and isnull(UsuarioPrueba,0) = 0
 
	select CodigoConsultora,Email,Telefono,Celular, ISNULL(EmailActivo,0) AS EmailActivo, ISNULL(CampaniaActivacionEmail,'') AS CampaniaActivacionEmail
	from LogCargaConsultora
	where NroLote = @NroLote
END
GO