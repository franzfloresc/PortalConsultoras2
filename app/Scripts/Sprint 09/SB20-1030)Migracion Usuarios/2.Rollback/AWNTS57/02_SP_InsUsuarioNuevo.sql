USE BelcorpBolivia
GO
ALTER PROCEDURE [dbo].[InsUsuarioNuevo]

@CodigoUsuario	Varchar(20),
@Nombre			Varchar(80),
@Email			Varchar(50),
@Telefono		Varchar(20),
@Celular		Varchar(20),
@PaisISO		Char(2),
@NroDocumento	Varchar(20)

as

begin

	Declare @PaisID Int

	Set @PaisID = (Select TOP(1) PaisID From pais Where CodigoISO = @PaisISO)
	
	if @PaisISO = 'EC'
	begin
		Insert Into dbo.Usuario
		(CodigoUsuario, CodigoConsultora, PaisID, Nombre, ClaveSecreta, EMail, 
		 EMailActivo, Telefono, Celular, Sobrenombre, CompartirDatos,
		 Activo, TipoUsuario, CambioClave)
		Values
		(@PaisISO + @NroDocumento, @CodigoUsuario, @PaisID, @Nombre, '*******', @Email,
		 0, @Telefono, @Celular, '', 0,
		 1, 1, 0)
	 end
	 else
	 begin
		Insert Into dbo.Usuario
		(CodigoUsuario, CodigoConsultora, PaisID, Nombre, ClaveSecreta, EMail, 
		 EMailActivo, Telefono, Celular, Sobrenombre, CompartirDatos,
		 Activo, TipoUsuario, CambioClave)
		Values
		(@CodigoUsuario, @CodigoUsuario, @PaisID, @Nombre, '*******', @Email,
		 0, @Telefono, @Celular, '', 0,
		 1, 1, 0)
	 end
	 Insert Into ConsultoraIngreso
	 (Codigo)
	 values
	 (@CodigoUsuario)

	 Insert Into [dbo].[UsuarioRol]
	 ([CodigoUsuario], [RolID], [Activo])
	 values
	 (@CodigoUsuario, 1, 1)

end
GO
/*end*/

USE BelcorpChile
GO
ALTER PROCEDURE [dbo].[InsUsuarioNuevo]

@CodigoUsuario	Varchar(20),
@Nombre			Varchar(80),
@Email			Varchar(50),
@Telefono		Varchar(20),
@Celular		Varchar(20),
@PaisISO		Char(2),
@NroDocumento	Varchar(20)

as

begin

	Declare @PaisID Int
	declare @estado int
	Set @PaisID = (Select TOP(1) PaisID From pais Where CodigoISO = @PaisISO)
	
	if ((select count(*) from dbo.usuario where codigousuario = @NroDocumento) = 0)
	begin
		Insert Into dbo.Usuario
		(CodigoUsuario, CodigoConsultora, PaisID, Nombre, ClaveSecreta, EMail, 
		 EMailActivo, Telefono, Celular, Sobrenombre, CompartirDatos,
		 Activo, TipoUsuario, CambioClave)
		Values
		(@NroDocumento, @CodigoUsuario, @PaisID, @Nombre, '*******', @Email,
		 0, @Telefono, @Celular, '', 0,
		 1, 1, 0)
		 
		Insert Into [dbo].[UsuarioRol]
		([CodigoUsuario], [RolID], [Activo])
		values
		(@NroDocumento, 1, 1)
		
		--Description: Actualizar CodigoConsultora en SolicitudPostulante por NumeroDocumento
		IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateCodigoEnSolicitudPostulante]') AND type in (N'P', N'PC'))
		BEGIN		
			EXEC [dbo].[UpdateCodigoEnSolicitudPostulante] @CodigoUsuario, @NroDocumento
		END
		
		
	 end
	 else
	 begin
	 set @estado = (select idestadoactividad from ods.consultora where codigo = @codigousuario)
		if(@estado != 5 and @estado != 7)
			update dbo.usuario set codigoconsultora = @codigousuario where CodigoUsuario = @NroDocumento
	 end
	 Insert Into ConsultoraIngreso
	 (Codigo)
	 values
	 (@CodigoUsuario)
	 

end
GO
/*end*/

USE BelcorpCostaRica
GO
ALTER PROCEDURE [dbo].[InsUsuarioNuevo]

@CodigoUsuario	Varchar(20),
@Nombre			Varchar(80),
@Email			Varchar(50),
@Telefono		Varchar(20),
@Celular		Varchar(20),
@PaisISO		Char(2),
@NroDocumento	Varchar(20)

as

begin

	Declare @PaisID Int

	Set @PaisID = (Select TOP(1) PaisID From pais Where CodigoISO = @PaisISO)
	
	if @PaisISO = 'EC'
	begin
		Insert Into dbo.Usuario
		(CodigoUsuario, CodigoConsultora, PaisID, Nombre, ClaveSecreta, EMail, 
		 EMailActivo, Telefono, Celular, Sobrenombre, CompartirDatos,
		 Activo, TipoUsuario, CambioClave)
		Values
		(@PaisISO + @NroDocumento, @CodigoUsuario, @PaisID, @Nombre, '*******', @Email,
		 0, @Telefono, @Celular, '', 0,
		 1, 1, 0)
	 end
	 else
	 begin
		Insert Into dbo.Usuario
		(CodigoUsuario, CodigoConsultora, PaisID, Nombre, ClaveSecreta, EMail, 
		 EMailActivo, Telefono, Celular, Sobrenombre, CompartirDatos,
		 Activo, TipoUsuario, CambioClave)
		Values
		(@CodigoUsuario, @CodigoUsuario, @PaisID, @Nombre, '*******', @Email,
		 0, @Telefono, @Celular, '', 0,
		 1, 1, 0)
	 end
	 Insert Into ConsultoraIngreso
	 (Codigo)
	 values
	 (@CodigoUsuario)

	 Insert Into [dbo].[UsuarioRol]
	 ([CodigoUsuario], [RolID], [Activo])
	 values
	 (@CodigoUsuario, 1, 1)

end
GO
/*end*/

USE BelcorpDominicana
GO
ALTER PROCEDURE [dbo].[InsUsuarioNuevo]

@CodigoUsuario	Varchar(20),
@Nombre			Varchar(80),
@Email			Varchar(50),
@Telefono		Varchar(20),
@Celular		Varchar(20),
@PaisISO		Char(2),
@NroDocumento	Varchar(20)

as

begin

	Declare @PaisID Int

	Set @PaisID = (Select TOP(1) PaisID From pais Where CodigoISO = @PaisISO)
	
	if @PaisISO = 'EC'
	begin
		Insert Into dbo.Usuario
		(CodigoUsuario, CodigoConsultora, PaisID, Nombre, ClaveSecreta, EMail, 
		 EMailActivo, Telefono, Celular, Sobrenombre, CompartirDatos,
		 Activo, TipoUsuario, CambioClave)
		Values
		(@PaisISO + @NroDocumento, @CodigoUsuario, @PaisID, @Nombre, '*******', @Email,
		 0, @Telefono, @Celular, '', 0,
		 1, 1, 0)
	 end
	 else
	 begin
		Insert Into dbo.Usuario
		(CodigoUsuario, CodigoConsultora, PaisID, Nombre, ClaveSecreta, EMail, 
		 EMailActivo, Telefono, Celular, Sobrenombre, CompartirDatos,
		 Activo, TipoUsuario, CambioClave)
		Values
		(@CodigoUsuario, @CodigoUsuario, @PaisID, @Nombre, '*******', @Email,
		 0, @Telefono, @Celular, '', 0,
		 1, 1, 0)
	 end
	 insert into dbo.consultoraingreso
	 (Codigo)
	 values
	 (@CodigoUsuario)

	 insert into dbo.usuariorol
	 ([CodigoUsuario], [RolID], [Activo])
	 values
	 (@CodigoUsuario, 1, 1)

end
GO
/*end*/

USE BelcorpEcuador
GO
ALTER PROCEDURE [dbo].[InsUsuarioNuevo]

@CodigoUsuario	Varchar(20),
@Nombre			Varchar(80),
@Email			Varchar(50),
@Telefono		Varchar(20),
@Celular		Varchar(20),
@PaisISO		Char(2),
@NroDocumento	Varchar(20)

as

begin
	Declare @PaisID Int
	declare @estado int

	Set @PaisID = (Select TOP(1) PaisID From pais Where CodigoISO = @PaisISO)
	
	if ((select count(*) from dbo.usuario where codigousuario = @NroDocumento) = 0)
	begin
		Insert Into dbo.Usuario
		(CodigoUsuario, CodigoConsultora, PaisID, Nombre, ClaveSecreta, EMail, 
		 EMailActivo, Telefono, Celular, Sobrenombre, CompartirDatos,
		 Activo, TipoUsuario, CambioClave)
		Values
		(@NroDocumento, @CodigoUsuario, @PaisID, @Nombre, '*******', @Email,
		 0, @Telefono, @Celular, '', 0,
		 1, 1, 0)
		 
		Insert Into [dbo].[UsuarioRol]
		([CodigoUsuario], [RolID], [Activo])
		values
		(@NroDocumento, 1, 1)
	 end
	 else
	 begin
	    set @estado = (select idestadoactividad from ods.consultora where codigo = @codigousuario)
		
		if(@estado != 5 and @estado != 7)
			update dbo.usuario set codigoconsultora = @codigousuario where CodigoUsuario = @NroDocumento
	 end
	 
	 Insert Into ConsultoraIngreso
	 (Codigo)
	 values
	 (@CodigoUsuario)
end
GO
/*end*/

USE BelcorpGuatemala
GO
ALTER PROCEDURE [dbo].[InsUsuarioNuevo]

@CodigoUsuario	Varchar(20),
@Nombre			Varchar(80),
@Email			Varchar(50),
@Telefono		Varchar(20),
@Celular		Varchar(20),
@PaisISO		Char(2),
@NroDocumento	Varchar(20)

as

begin

	Declare @PaisID Int

	Set @PaisID = (Select TOP(1) PaisID From pais Where CodigoISO = @PaisISO)
	
	if @PaisISO = 'EC'
	begin
		Insert Into dbo.Usuario
		(CodigoUsuario, CodigoConsultora, PaisID, Nombre, ClaveSecreta, EMail, 
		 EMailActivo, Telefono, Celular, Sobrenombre, CompartirDatos,
		 Activo, TipoUsuario, CambioClave)
		Values
		(@PaisISO + @NroDocumento, @CodigoUsuario, @PaisID, @Nombre, '*******', @Email,
		 0, @Telefono, @Celular, '', 0,
		 1, 1, 0)
	 end
	 else
	 begin
		Insert Into dbo.Usuario
		(CodigoUsuario, CodigoConsultora, PaisID, Nombre, ClaveSecreta, EMail, 
		 EMailActivo, Telefono, Celular, Sobrenombre, CompartirDatos,
		 Activo, TipoUsuario, CambioClave)
		Values
		(@CodigoUsuario, @CodigoUsuario, @PaisID, @Nombre, '*******', @Email,
		 0, @Telefono, @Celular, '', 0,
		 1, 1, 0)
	 end
	 Insert Into ConsultoraIngreso
	 (Codigo)
	 values
	 (@CodigoUsuario)

	 Insert Into [dbo].[UsuarioRol]
	 ([CodigoUsuario], [RolID], [Activo])
	 values
	 (@CodigoUsuario, 1, 1)


end
GO
/*end*/

USE BelcorpPanama
GO
ALTER PROCEDURE [dbo].[InsUsuarioNuevo]

@CodigoUsuario	Varchar(20),
@Nombre			Varchar(80),
@Email			Varchar(50),
@Telefono		Varchar(20),
@Celular		Varchar(20),
@PaisISO		Char(2),
@NroDocumento	Varchar(20)

as

begin

	Declare @PaisID Int

	Set @PaisID = (Select TOP(1) PaisID From pais Where CodigoISO = @PaisISO)
	
	if @PaisISO = 'EC'
	begin
		Insert Into dbo.Usuario
		(CodigoUsuario, CodigoConsultora, PaisID, Nombre, ClaveSecreta, EMail, 
		 EMailActivo, Telefono, Celular, Sobrenombre, CompartirDatos,
		 Activo, TipoUsuario, CambioClave)
		Values
		(@PaisISO + @NroDocumento, @CodigoUsuario, @PaisID, @Nombre, '*******', @Email,
		 0, @Telefono, @Celular, '', 0,
		 1, 1, 0)
	 end
	 else
	 begin
		Insert Into dbo.Usuario
		(CodigoUsuario, CodigoConsultora, PaisID, Nombre, ClaveSecreta, EMail, 
		 EMailActivo, Telefono, Celular, Sobrenombre, CompartirDatos,
		 Activo, TipoUsuario, CambioClave)
		Values
		(@CodigoUsuario, @CodigoUsuario, @PaisID, @Nombre, '*******', @Email,
		 0, @Telefono, @Celular, '', 0,
		 1, 1, 0)
	 end
	 Insert Into ConsultoraIngreso
	 (Codigo)
	 values
	 (@CodigoUsuario)

	 Insert Into [dbo].[UsuarioRol]
	 ([CodigoUsuario], [RolID], [Activo])
	 values
	 (@CodigoUsuario, 1, 1)

end
GO
/*end*/

USE BelcorpPuertoRico
GO
ALTER PROCEDURE [dbo].[InsUsuarioNuevo]

@CodigoUsuario	Varchar(20),
@Nombre			Varchar(80),
@Email			Varchar(50),
@Telefono		Varchar(20),
@Celular		Varchar(20),
@PaisISO		Char(2),
@NroDocumento	Varchar(20)

as

begin

	Declare @PaisID Int

	Set @PaisID = (Select TOP(1) PaisID From pais Where CodigoISO = @PaisISO)
	
	if @PaisISO = 'EC'
	begin
		Insert Into dbo.Usuario
		(CodigoUsuario, CodigoConsultora, PaisID, Nombre, ClaveSecreta, EMail, 
		 EMailActivo, Telefono, Celular, Sobrenombre, CompartirDatos,
		 Activo, TipoUsuario, CambioClave)
		Values
		(@PaisISO + @NroDocumento, @CodigoUsuario, @PaisID, @Nombre, '*******', @Email,
		 0, @Telefono, @Celular, '', 0,
		 1, 1, 0)
	 end
	 else
	 begin
		Insert Into dbo.Usuario
		(CodigoUsuario, CodigoConsultora, PaisID, Nombre, ClaveSecreta, EMail, 
		 EMailActivo, Telefono, Celular, Sobrenombre, CompartirDatos,
		 Activo, TipoUsuario, CambioClave)
		Values
		(@CodigoUsuario, @CodigoUsuario, @PaisID, @Nombre, '*******', @Email,
		 0, @Telefono, @Celular, '', 0,
		 1, 1, 0)
	 end
	 insert into dbo.consultoraingreso
	 (Codigo)
	 values
	 (@CodigoUsuario)

	 insert into dbo.usuariorol
	 ([CodigoUsuario], [RolID], [Activo])
	 values
	 (@CodigoUsuario, 1, 1)

end
GO
/*end*/

USE BelcorpSalvador
GO
ALTER PROCEDURE [dbo].[InsUsuarioNuevo]

@CodigoUsuario	Varchar(20),
@Nombre			Varchar(80),
@Email			Varchar(50),
@Telefono		Varchar(20),
@Celular		Varchar(20),
@PaisISO		Char(2),
@NroDocumento	Varchar(20)

as

begin

	Declare @PaisID Int

	Set @PaisID = (Select TOP(1) PaisID From pais Where CodigoISO = @PaisISO)
	
	if @PaisISO = 'EC'
	begin
		Insert Into dbo.Usuario
		(CodigoUsuario, CodigoConsultora, PaisID, Nombre, ClaveSecreta, EMail, 
		 EMailActivo, Telefono, Celular, Sobrenombre, CompartirDatos,
		 Activo, TipoUsuario, CambioClave)
		Values
		(@PaisISO + @NroDocumento, @CodigoUsuario, @PaisID, @Nombre, '*******', @Email,
		 0, @Telefono, @Celular, '', 0,
		 1, 1, 0)
	 end
	 else
	 begin
		Insert Into dbo.Usuario
		(CodigoUsuario, CodigoConsultora, PaisID, Nombre, ClaveSecreta, EMail, 
		 EMailActivo, Telefono, Celular, Sobrenombre, CompartirDatos,
		 Activo, TipoUsuario, CambioClave)
		Values
		(@CodigoUsuario, @CodigoUsuario, @PaisID, @Nombre, '*******', @Email,
		 0, @Telefono, @Celular, '', 0,
		 1, 1, 0)
	 end
	 Insert Into ConsultoraIngreso
	 (Codigo)
	 values
	 (@CodigoUsuario)

	 Insert Into [dbo].[UsuarioRol]
	 ([CodigoUsuario], [RolID], [Activo])
	 values
	 (@CodigoUsuario, 1, 1)

end
GO
/*end*/

USE BelcorpVenezuela
GO
ALTER PROCEDURE [dbo].[InsUsuarioNuevo]

@CodigoUsuario	Varchar(20),
@Nombre			Varchar(80),
@Email			Varchar(50),
@Telefono		Varchar(20),
@Celular		Varchar(20),
@PaisISO		Char(2),
@NroDocumento	Varchar(20)

as

begin

	Declare @PaisID Int

	Set @PaisID = (Select TOP(1) PaisID From pais Where CodigoISO = @PaisISO)
	
	if @PaisISO = 'EC'
	begin
		Insert Into dbo.Usuario
		(CodigoUsuario, CodigoConsultora, PaisID, Nombre, ClaveSecreta, EMail, 
		 EMailActivo, Telefono, Celular, Sobrenombre, CompartirDatos,
		 Activo, TipoUsuario, CambioClave)
		Values
		(@PaisISO + @NroDocumento, @CodigoUsuario, @PaisID, @Nombre, '*******', @Email,
		 0, @Telefono, @Celular, '', 0,
		 1, 1, 0)
	 end
	 else
	 begin
		Insert Into dbo.Usuario
		(CodigoUsuario, CodigoConsultora, PaisID, Nombre, ClaveSecreta, EMail, 
		 EMailActivo, Telefono, Celular, Sobrenombre, CompartirDatos,
		 Activo, TipoUsuario, CambioClave)
		Values
		(@CodigoUsuario, @CodigoUsuario, @PaisID, @Nombre, '*******', @Email,
		 0, @Telefono, @Celular, '', 0,
		 1, 1, 0)
	 end
	 Insert Into ConsultoraIngreso
	 (Codigo)
	 values
	 (@CodigoUsuario)

	 Insert Into [dbo].[UsuarioRol]
	 ([CodigoUsuario], [RolID], [Activo])
	 values
	 (@CodigoUsuario, 1, 1)

end
GO