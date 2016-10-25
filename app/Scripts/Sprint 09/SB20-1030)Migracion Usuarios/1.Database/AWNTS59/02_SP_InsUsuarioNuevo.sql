USE BelcorpColombia
GO
ALTER PROCEDURE [dbo].[InsUsuarioNuevo]
	@CodigoUsuario VARCHAR(20),
	@Nombre VARCHAR(80),
	@Email VARCHAR(50),
	@Telefono VARCHAR(20),
	@TelefonoTrabajo VARCHAR(20),
	@Celular VARCHAR(20),
	@PaisISO CHAR(2),
	@NroDocumento VARCHAR(20)
AS
BEGIN
	Declare @PaisID Int
	declare @estado int
	Set @PaisID = (Select TOP(1) PaisID From pais Where CodigoISO = @PaisISO)
	
	if ((select count(*) from dbo.usuario where codigousuario = @NroDocumento) = 0)
	begin
		Insert Into dbo.Usuario
		(CodigoUsuario, CodigoConsultora, PaisID, Nombre, ClaveSecreta, EMail, 
		 EMailActivo, Telefono, TelefonoTrabajo, Celular, Sobrenombre, CompartirDatos,
		 Activo, TipoUsuario, CambioClave)
		Values
		(@NroDocumento, @CodigoUsuario, @PaisID, @Nombre, '*******', @Email,
		 0, @Telefono, @TelefonoTrabajo, @Celular, '', 0,
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
	 
	 Insert Into ConsultoraIngreso (Codigo)
	 values (@CodigoUsuario);
END
GO
/*end*/

USE BelcorpMexico
GO
ALTER PROCEDURE [dbo].[InsUsuarioNuevo]
	@CodigoUsuario VARCHAR(20),
	@Nombre VARCHAR(80),
	@Email VARCHAR(50),
	@Telefono VARCHAR(20),
	@TelefonoTrabajo VARCHAR(20),
	@Celular VARCHAR(20),
	@PaisISO CHAR(2),
	@NroDocumento VARCHAR(20)
AS
BEGIN
	Declare @PaisID Int;
	Set @PaisID = (Select TOP(1) PaisID From pais Where CodigoISO = @PaisISO);
	
	if @PaisISO = 'EC'
	begin
		Insert Into dbo.Usuario
		(CodigoUsuario, CodigoConsultora, PaisID, Nombre, ClaveSecreta, EMail, 
		 EMailActivo, Telefono, TelefonoTrabajo, Celular, Sobrenombre, CompartirDatos,
		 Activo, TipoUsuario, CambioClave)
		Values
		(@PaisISO + @NroDocumento, @CodigoUsuario, @PaisID, @Nombre, '*******', @Email,
		 0, @Telefono, @TelefonoTrabajo, @Celular, '', 0,
		 1, 1, 0)
	 end
	 else
	 begin
		Insert Into dbo.Usuario
		(CodigoUsuario, CodigoConsultora, PaisID, Nombre, ClaveSecreta, EMail, 
		 EMailActivo, Telefono, TelefonoTrabajo, Celular, Sobrenombre, CompartirDatos,
		 Activo, TipoUsuario, CambioClave)
		Values
		(@CodigoUsuario, @CodigoUsuario, @PaisID, @Nombre, '*******', @Email,
		 0, @Telefono, @TelefonoTrabajo, @Celular, '', 0,
		 1, 1, 0)

		 --Description: Actualizar CodigoConsultora en SolicitudPostulante por NumeroDocumento
		IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateCodigoEnSolicitudPostulante]') AND type in (N'P', N'PC'))
		BEGIN		
			EXEC [dbo].[UpdateCodigoEnSolicitudPostulante] @CodigoUsuario, @NroDocumento
		END
	 end
	 
	 Insert Into ConsultoraIngreso (Codigo)
	 values (@CodigoUsuario);

	 Insert Into [dbo].[UsuarioRol] ([CodigoUsuario], [RolID], [Activo])
	 values (@CodigoUsuario, 1, 1);
END
GO
/*end*/

USE BelcorpPeru
GO
ALTER PROCEDURE [dbo].[InsUsuarioNuevo]
	@CodigoUsuario VARCHAR(20),
	@Nombre VARCHAR(80),
	@Email VARCHAR(50),
	@Telefono VARCHAR(20),
	@TelefonoTrabajo VARCHAR(20),
	@Celular VARCHAR(20),
	@PaisISO CHAR(2),
	@NroDocumento VARCHAR(20)
AS
BEGIN
	Declare @PaisID Int;
	Set @PaisID = (Select TOP(1) PaisID From pais Where CodigoISO = @PaisISO);
	
	if @PaisISO = 'EC'
	begin
		Insert Into dbo.Usuario
		(CodigoUsuario, CodigoConsultora, PaisID, Nombre, ClaveSecreta, EMail, 
		 EMailActivo, Telefono, TelefonoTrabajo, Celular, Sobrenombre, CompartirDatos,
		 Activo, TipoUsuario, CambioClave)
		Values
		(@PaisISO + @NroDocumento, @CodigoUsuario, @PaisID, @Nombre, '*******', @Email,
		 0, @Telefono, @TelefonoTrabajo, @Celular, '', 0,
		 1, 1, 0)
	 end
	 else
	 begin
		Insert Into dbo.Usuario
		(CodigoUsuario, CodigoConsultora, PaisID, Nombre, ClaveSecreta, EMail, 
		 EMailActivo, Telefono, TelefonoTrabajo, Celular, Sobrenombre, CompartirDatos,
		 Activo, TipoUsuario, CambioClave)
		Values
		(@CodigoUsuario, @CodigoUsuario, @PaisID, @Nombre, '*******', @Email,
		 0, @Telefono, @TelefonoTrabajo, @Celular, '', 0,
		 1, 1, 0)
	 end

	 insert into dbo.consultoraingreso (Codigo)
	 values (@CodigoUsuario);

	 insert into dbo.usuariorol ([CodigoUsuario], [RolID], [Activo])
	 values (@CodigoUsuario, 1, 1);
END
GO