USE BelcorpPeru
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsConsultoraFicticia]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsConsultoraFicticia]
GO

CREATE PROCEDURE [dbo].[InsConsultoraFicticia]

@PaisID int,
@CodigoUsuario varchar(20),
@CodigoConsultora varchar(20),
@Clave varchar(200)
as

declare @Validador int
declare @consultoraid bigint
declare @codigo varchar(25)

begin
	
	set @Validador = (select count(*) from [dbo].[UsuarioPrueba] where [CodigoUsuario] = @CodigoUsuario and [CodigoConsultoraAsociada] = @CodigoConsultora)
	
	if @Validador = 0
	begin
		
		set @consultoraid = (select isnull(max(consultoraID),999000000) + 1 from consultoraficticia )
		set @codigo = CAST(@consultoraid AS VARCHAR)

		insert into [dbo].[UsuarioPrueba]
		([CodigoUsuario], [CodigoConsultoraAsociada], [CodigoFicticio])
		values
		(@CodigoUsuario, @CodigoConsultora, @Codigo)

		declare @ClaveEncriptada varchar(200) = ''
		SET @ClaveEncriptada = dbo.EncriptarClaveSHA1(@Clave)

		insert into [dbo].[Usuario]
		([CodigoUsuario], [PaisID], [CodigoConsultora], [Nombre], [ClaveSecreta], [EMail], 
		 [EMailActivo], [Telefono], [Celular], [Sobrenombre], [CompartirDatos], [Activo], 
		 [TipoUsuario], [CambioClave], [UsuarioPrueba])
		values
		(@CodigoUsuario, @PaisID, @codigo, @CodigoUsuario, @ClaveEncriptada, null,
		 0, '','','',0,1,
		 1, 0, 1)
		 
		 insert into dbo.UsuarioRol
		 (CodigoUsuario, RolID, Activo)
		 values
		 (@CodigoUsuario, 1, 1)

		 insert into ConsultoraFicticia
		 ([ConsultoraID],			[SeccionID],			[RegionID],				[ZonaID],				[TerritorioID], 
		  [SegmentoID],				[IdEstadoActividad],	[IdEstadoDatamart],		[Codigo],				[PrimerNombre], 
		  [SegundoNombre],			[PrimerApellido],		[SegundoApellido],		[NombreCompleto],		[FechaNacimiento], 
		  [Genero],					[EstadoCivil],			[PrimerPedido],			[KtiNueva],				[AutorizaPedido], 
		  [Email],					[MontoUltimoPedido],	[EstatusCapacitacion],	[MontoFlexipago],		[CampaniaPrimeraID],
		  [UltimaCampanaFacturada],	[EstadoConsultora],		[AnoCampanaIngreso],	[IndicadorPasoPedido],	[ModificacionDatosBB],
		  [IndicadorProl],			[MontoMaximoPedido],	[MontoMinimoPedido],	[FechaIngreso],			[MontoSaldoActual],
		  [EstadoBloqueo],			[FechaCarga],			[IndicadorFlexiPago],	[IndicadorDupla],		[CompraKitDupla])
		
		select
			@consultoraid,				[SeccionID],			[RegionID],				[ZonaID],				[TerritorioID],
			[SegmentoID],				[IdEstadoActividad],	[IdEstadoDatamart],		@codigo,				@CodigoUsuario,
			'',							'',						'',						@CodigoUsuario,			[FechaNacimiento],
			[Genero],					[EstadoCivil],			[PrimerPedido],			[KtiNueva],				[AutorizaPedido],
			[Email],					[MontoUltimoPedido],	[EstatusCapacitacion],	[MontoFlexipago],		[CampaniaPrimeraID],
			[UltimaCampanaFacturada],	[EstadoConsultora],		[AnoCampanaIngreso],	[IndicadorPasoPedido],	[ModificacionDatosBB], 
			[IndicadorProl],			[MontoMaximoPedido],	[MontoMinimoPedido],	[FechaIngreso],			[MontoSaldoActual],
			[EstadoBloqueo],			[FechaCarga],			[IndicadorFlexiPago],	[IndicadorDupla],		[CompraKitDupla]		
		from 
			ods.consultora
		where
			codigo = @CodigoConsultora
			
		select 1
	 end
	 else
	 begin
		select 3
	 end
end

GO

USE BelcorpMexico
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsConsultoraFicticia]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsConsultoraFicticia]
GO

CREATE PROCEDURE [dbo].[InsConsultoraFicticia]

@PaisID int,
@CodigoUsuario varchar(20),
@CodigoConsultora varchar(20),
@Clave varchar(200)
as

declare @Validador int
declare @consultoraid bigint
declare @codigo varchar(25)

begin
	
	set @Validador = (select count(*) from [dbo].[UsuarioPrueba] where [CodigoUsuario] = @CodigoUsuario and [CodigoConsultoraAsociada] = @CodigoConsultora)
	
	if @Validador = 0
	begin
		
		set @consultoraid = (select isnull(max(consultoraID),999000000) + 1 from consultoraficticia )
		set @codigo = CAST(@consultoraid AS VARCHAR)

		insert into [dbo].[UsuarioPrueba]
		([CodigoUsuario], [CodigoConsultoraAsociada], [CodigoFicticio])
		values
		(@CodigoUsuario, @CodigoConsultora, @Codigo)

		declare @ClaveEncriptada varchar(200) = ''
		SET @ClaveEncriptada = dbo.EncriptarClaveSHA1(@Clave)

		insert into [dbo].[Usuario]
		([CodigoUsuario], [PaisID], [CodigoConsultora], [Nombre], [ClaveSecreta], [EMail], 
		 [EMailActivo], [Telefono], [Celular], [Sobrenombre], [CompartirDatos], [Activo], 
		 [TipoUsuario], [CambioClave], [UsuarioPrueba])
		values
		(@CodigoUsuario, @PaisID, @codigo, @CodigoUsuario, @ClaveEncriptada, null,
		 0, '','','',0,1,
		 1, 0, 1)
		 
		 insert into dbo.UsuarioRol
		 (CodigoUsuario, RolID, Activo)
		 values
		 (@CodigoUsuario, 1, 1)

		 insert into ConsultoraFicticia
		 ([ConsultoraID],			[SeccionID],			[RegionID],				[ZonaID],				[TerritorioID], 
		  [SegmentoID],				[IdEstadoActividad],	[IdEstadoDatamart],		[Codigo],				[PrimerNombre], 
		  [SegundoNombre],			[PrimerApellido],		[SegundoApellido],		[NombreCompleto],		[FechaNacimiento], 
		  [Genero],					[EstadoCivil],			[PrimerPedido],			[KtiNueva],				[AutorizaPedido], 
		  [Email],					[MontoUltimoPedido],	[EstatusCapacitacion],	[MontoFlexipago],		[CampaniaPrimeraID],
		  [UltimaCampanaFacturada],	[EstadoConsultora],		[AnoCampanaIngreso],	[IndicadorPasoPedido],	[ModificacionDatosBB],
		  [IndicadorProl],			[MontoMaximoPedido],	[MontoMinimoPedido],	[FechaIngreso],			[MontoSaldoActual],
		  [EstadoBloqueo],			[FechaCarga],			[IndicadorFlexiPago],	[IndicadorDupla],		[CompraKitDupla])
		
		select
			@consultoraid,				[SeccionID],			[RegionID],				[ZonaID],				[TerritorioID],
			[SegmentoID],				[IdEstadoActividad],	[IdEstadoDatamart],		@codigo,				@CodigoUsuario,
			'',							'',						'',						@CodigoUsuario,			[FechaNacimiento],
			[Genero],					[EstadoCivil],			[PrimerPedido],			[KtiNueva],				[AutorizaPedido],
			[Email],					[MontoUltimoPedido],	[EstatusCapacitacion],	[MontoFlexipago],		[CampaniaPrimeraID],
			[UltimaCampanaFacturada],	[EstadoConsultora],		[AnoCampanaIngreso],	[IndicadorPasoPedido],	[ModificacionDatosBB], 
			[IndicadorProl],			[MontoMaximoPedido],	[MontoMinimoPedido],	[FechaIngreso],			[MontoSaldoActual],
			[EstadoBloqueo],			[FechaCarga],			[IndicadorFlexiPago],	[IndicadorDupla],		[CompraKitDupla]		
		from 
			ods.consultora
		where
			codigo = @CodigoConsultora
			
		select 1
	 end
	 else
	 begin
		select 3
	 end
end

GO

USE BelcorpColombia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsConsultoraFicticia]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsConsultoraFicticia]
GO

CREATE PROCEDURE [dbo].[InsConsultoraFicticia]

@PaisID int,
@CodigoUsuario varchar(20),
@CodigoConsultora varchar(20),
@Clave varchar(200)
as

declare @Validador int
declare @consultoraid bigint
declare @codigo varchar(25)

begin
	
	set @Validador = (select count(*) from [dbo].[UsuarioPrueba] where [CodigoUsuario] = @CodigoUsuario and [CodigoConsultoraAsociada] = @CodigoConsultora)
	
	if @Validador = 0
	begin
		
		set @consultoraid = (select isnull(max(consultoraID),999000000) + 1 from consultoraficticia )
		set @codigo = CAST(@consultoraid AS VARCHAR)

		insert into [dbo].[UsuarioPrueba]
		([CodigoUsuario], [CodigoConsultoraAsociada], [CodigoFicticio])
		values
		(@CodigoUsuario, @CodigoConsultora, @Codigo)

		declare @ClaveEncriptada varchar(200) = ''
		SET @ClaveEncriptada = dbo.EncriptarClaveSHA1(@Clave)

		insert into [dbo].[Usuario]
		([CodigoUsuario], [PaisID], [CodigoConsultora], [Nombre], [ClaveSecreta], [EMail], 
		 [EMailActivo], [Telefono], [Celular], [Sobrenombre], [CompartirDatos], [Activo], 
		 [TipoUsuario], [CambioClave], [UsuarioPrueba])
		values
		(@CodigoUsuario, @PaisID, @codigo, @CodigoUsuario, @ClaveEncriptada, null,
		 0, '','','',0,1,
		 1, 0, 1)
		 
		 insert into dbo.UsuarioRol
		 (CodigoUsuario, RolID, Activo)
		 values
		 (@CodigoUsuario, 1, 1)

		 insert into ConsultoraFicticia
		 ([ConsultoraID],			[SeccionID],			[RegionID],				[ZonaID],				[TerritorioID], 
		  [SegmentoID],				[IdEstadoActividad],	[IdEstadoDatamart],		[Codigo],				[PrimerNombre], 
		  [SegundoNombre],			[PrimerApellido],		[SegundoApellido],		[NombreCompleto],		[FechaNacimiento], 
		  [Genero],					[EstadoCivil],			[PrimerPedido],			[KtiNueva],				[AutorizaPedido], 
		  [Email],					[MontoUltimoPedido],	[EstatusCapacitacion],	[MontoFlexipago],		[CampaniaPrimeraID],
		  [UltimaCampanaFacturada],	[EstadoConsultora],		[AnoCampanaIngreso],	[IndicadorPasoPedido],	[ModificacionDatosBB],
		  [IndicadorProl],			[MontoMaximoPedido],	[MontoMinimoPedido],	[FechaIngreso],			[MontoSaldoActual],
		  [EstadoBloqueo],			[FechaCarga],			[IndicadorFlexiPago],	[IndicadorDupla],		[CompraKitDupla])
		
		select
			@consultoraid,				[SeccionID],			[RegionID],				[ZonaID],				[TerritorioID],
			[SegmentoID],				[IdEstadoActividad],	[IdEstadoDatamart],		@codigo,				@CodigoUsuario,
			'',							'',						'',						@CodigoUsuario,			[FechaNacimiento],
			[Genero],					[EstadoCivil],			[PrimerPedido],			[KtiNueva],				[AutorizaPedido],
			[Email],					[MontoUltimoPedido],	[EstatusCapacitacion],	[MontoFlexipago],		[CampaniaPrimeraID],
			[UltimaCampanaFacturada],	[EstadoConsultora],		[AnoCampanaIngreso],	[IndicadorPasoPedido],	[ModificacionDatosBB], 
			[IndicadorProl],			[MontoMaximoPedido],	[MontoMinimoPedido],	[FechaIngreso],			[MontoSaldoActual],
			[EstadoBloqueo],			[FechaCarga],			[IndicadorFlexiPago],	[IndicadorDupla],		[CompraKitDupla]		
		from 
			ods.consultora
		where
			codigo = @CodigoConsultora
			
		select 1
	 end
	 else
	 begin
		select 3
	 end
end

GO

USE BelcorpVenezuela
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsConsultoraFicticia]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsConsultoraFicticia]
GO

CREATE PROCEDURE [dbo].[InsConsultoraFicticia]

@PaisID int,
@CodigoUsuario varchar(20),
@CodigoConsultora varchar(20),
@Clave varchar(200)
as

declare @Validador int
declare @consultoraid bigint
declare @codigo varchar(25)

begin
	
	set @Validador = (select count(*) from [dbo].[UsuarioPrueba] where [CodigoUsuario] = @CodigoUsuario and [CodigoConsultoraAsociada] = @CodigoConsultora)
	
	if @Validador = 0
	begin
		
		set @consultoraid = (select isnull(max(consultoraID),999000000) + 1 from consultoraficticia )
		set @codigo = CAST(@consultoraid AS VARCHAR)

		insert into [dbo].[UsuarioPrueba]
		([CodigoUsuario], [CodigoConsultoraAsociada], [CodigoFicticio])
		values
		(@CodigoUsuario, @CodigoConsultora, @Codigo)

		declare @ClaveEncriptada varchar(200) = ''
		SET @ClaveEncriptada = dbo.EncriptarClaveSHA1(@Clave)

		insert into [dbo].[Usuario]
		([CodigoUsuario], [PaisID], [CodigoConsultora], [Nombre], [ClaveSecreta], [EMail], 
		 [EMailActivo], [Telefono], [Celular], [Sobrenombre], [CompartirDatos], [Activo], 
		 [TipoUsuario], [CambioClave], [UsuarioPrueba])
		values
		(@CodigoUsuario, @PaisID, @codigo, @CodigoUsuario, @ClaveEncriptada, null,
		 0, '','','',0,1,
		 1, 0, 1)
		 
		 insert into dbo.UsuarioRol
		 (CodigoUsuario, RolID, Activo)
		 values
		 (@CodigoUsuario, 1, 1)

		 insert into ConsultoraFicticia
		 ([ConsultoraID],			[SeccionID],			[RegionID],				[ZonaID],				[TerritorioID], 
		  [SegmentoID],				[IdEstadoActividad],	[IdEstadoDatamart],		[Codigo],				[PrimerNombre], 
		  [SegundoNombre],			[PrimerApellido],		[SegundoApellido],		[NombreCompleto],		[FechaNacimiento], 
		  [Genero],					[EstadoCivil],			[PrimerPedido],			[KtiNueva],				[AutorizaPedido], 
		  [Email],					[MontoUltimoPedido],	[EstatusCapacitacion],	[MontoFlexipago],		[CampaniaPrimeraID],
		  [UltimaCampanaFacturada],	[EstadoConsultora],		[AnoCampanaIngreso],	[IndicadorPasoPedido],	[ModificacionDatosBB],
		  [IndicadorProl],			[MontoMaximoPedido],	[MontoMinimoPedido],	[FechaIngreso],			[MontoSaldoActual],
		  [EstadoBloqueo],			[FechaCarga],			[IndicadorFlexiPago],	[IndicadorDupla],		[CompraKitDupla])
		
		select
			@consultoraid,				[SeccionID],			[RegionID],				[ZonaID],				[TerritorioID],
			[SegmentoID],				[IdEstadoActividad],	[IdEstadoDatamart],		@codigo,				@CodigoUsuario,
			'',							'',						'',						@CodigoUsuario,			[FechaNacimiento],
			[Genero],					[EstadoCivil],			[PrimerPedido],			[KtiNueva],				[AutorizaPedido],
			[Email],					[MontoUltimoPedido],	[EstatusCapacitacion],	[MontoFlexipago],		[CampaniaPrimeraID],
			[UltimaCampanaFacturada],	[EstadoConsultora],		[AnoCampanaIngreso],	[IndicadorPasoPedido],	[ModificacionDatosBB], 
			[IndicadorProl],			[MontoMaximoPedido],	[MontoMinimoPedido],	[FechaIngreso],			[MontoSaldoActual],
			[EstadoBloqueo],			[FechaCarga],			[IndicadorFlexiPago],	[IndicadorDupla],		[CompraKitDupla]		
		from 
			ods.consultora
		where
			codigo = @CodigoConsultora
			
		select 1
	 end
	 else
	 begin
		select 3
	 end
end

GO

USE BelcorpSalvador
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsConsultoraFicticia]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsConsultoraFicticia]
GO

CREATE PROCEDURE [dbo].[InsConsultoraFicticia]

@PaisID int,
@CodigoUsuario varchar(20),
@CodigoConsultora varchar(20),
@Clave varchar(200)
as

declare @Validador int
declare @consultoraid bigint
declare @codigo varchar(25)

begin
	
	set @Validador = (select count(*) from [dbo].[UsuarioPrueba] where [CodigoUsuario] = @CodigoUsuario and [CodigoConsultoraAsociada] = @CodigoConsultora)
	
	if @Validador = 0
	begin
		
		set @consultoraid = (select isnull(max(consultoraID),999000000) + 1 from consultoraficticia )
		set @codigo = CAST(@consultoraid AS VARCHAR)

		insert into [dbo].[UsuarioPrueba]
		([CodigoUsuario], [CodigoConsultoraAsociada], [CodigoFicticio])
		values
		(@CodigoUsuario, @CodigoConsultora, @Codigo)

		declare @ClaveEncriptada varchar(200) = ''
		SET @ClaveEncriptada = dbo.EncriptarClaveSHA1(@Clave)

		insert into [dbo].[Usuario]
		([CodigoUsuario], [PaisID], [CodigoConsultora], [Nombre], [ClaveSecreta], [EMail], 
		 [EMailActivo], [Telefono], [Celular], [Sobrenombre], [CompartirDatos], [Activo], 
		 [TipoUsuario], [CambioClave], [UsuarioPrueba])
		values
		(@CodigoUsuario, @PaisID, @codigo, @CodigoUsuario, @ClaveEncriptada, null,
		 0, '','','',0,1,
		 1, 0, 1)
		 
		 insert into dbo.UsuarioRol
		 (CodigoUsuario, RolID, Activo)
		 values
		 (@CodigoUsuario, 1, 1)

		 insert into ConsultoraFicticia
		 ([ConsultoraID],			[SeccionID],			[RegionID],				[ZonaID],				[TerritorioID], 
		  [SegmentoID],				[IdEstadoActividad],	[IdEstadoDatamart],		[Codigo],				[PrimerNombre], 
		  [SegundoNombre],			[PrimerApellido],		[SegundoApellido],		[NombreCompleto],		[FechaNacimiento], 
		  [Genero],					[EstadoCivil],			[PrimerPedido],			[KtiNueva],				[AutorizaPedido], 
		  [Email],					[MontoUltimoPedido],	[EstatusCapacitacion],	[MontoFlexipago],		[CampaniaPrimeraID],
		  [UltimaCampanaFacturada],	[EstadoConsultora],		[AnoCampanaIngreso],	[IndicadorPasoPedido],	[ModificacionDatosBB],
		  [IndicadorProl],			[MontoMaximoPedido],	[MontoMinimoPedido],	[FechaIngreso],			[MontoSaldoActual],
		  [EstadoBloqueo],			[FechaCarga],			[IndicadorFlexiPago],	[IndicadorDupla],		[CompraKitDupla])
		
		select
			@consultoraid,				[SeccionID],			[RegionID],				[ZonaID],				[TerritorioID],
			[SegmentoID],				[IdEstadoActividad],	[IdEstadoDatamart],		@codigo,				@CodigoUsuario,
			'',							'',						'',						@CodigoUsuario,			[FechaNacimiento],
			[Genero],					[EstadoCivil],			[PrimerPedido],			[KtiNueva],				[AutorizaPedido],
			[Email],					[MontoUltimoPedido],	[EstatusCapacitacion],	[MontoFlexipago],		[CampaniaPrimeraID],
			[UltimaCampanaFacturada],	[EstadoConsultora],		[AnoCampanaIngreso],	[IndicadorPasoPedido],	[ModificacionDatosBB], 
			[IndicadorProl],			[MontoMaximoPedido],	[MontoMinimoPedido],	[FechaIngreso],			[MontoSaldoActual],
			[EstadoBloqueo],			[FechaCarga],			[IndicadorFlexiPago],	[IndicadorDupla],		[CompraKitDupla]		
		from 
			ods.consultora
		where
			codigo = @CodigoConsultora
			
		select 1
	 end
	 else
	 begin
		select 3
	 end
end

GO

USE BelcorpPuertoRico
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsConsultoraFicticia]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsConsultoraFicticia]
GO

CREATE PROCEDURE [dbo].[InsConsultoraFicticia]

@PaisID int,
@CodigoUsuario varchar(20),
@CodigoConsultora varchar(20),
@Clave varchar(200)
as

declare @Validador int
declare @consultoraid bigint
declare @codigo varchar(25)

begin
	
	set @Validador = (select count(*) from [dbo].[UsuarioPrueba] where [CodigoUsuario] = @CodigoUsuario and [CodigoConsultoraAsociada] = @CodigoConsultora)
	
	if @Validador = 0
	begin
		
		set @consultoraid = (select isnull(max(consultoraID),999000000) + 1 from consultoraficticia )
		set @codigo = CAST(@consultoraid AS VARCHAR)

		insert into [dbo].[UsuarioPrueba]
		([CodigoUsuario], [CodigoConsultoraAsociada], [CodigoFicticio])
		values
		(@CodigoUsuario, @CodigoConsultora, @Codigo)

		declare @ClaveEncriptada varchar(200) = ''
		SET @ClaveEncriptada = dbo.EncriptarClaveSHA1(@Clave)

		insert into [dbo].[Usuario]
		([CodigoUsuario], [PaisID], [CodigoConsultora], [Nombre], [ClaveSecreta], [EMail], 
		 [EMailActivo], [Telefono], [Celular], [Sobrenombre], [CompartirDatos], [Activo], 
		 [TipoUsuario], [CambioClave], [UsuarioPrueba])
		values
		(@CodigoUsuario, @PaisID, @codigo, @CodigoUsuario, @ClaveEncriptada, null,
		 0, '','','',0,1,
		 1, 0, 1)
		 
		 insert into dbo.UsuarioRol
		 (CodigoUsuario, RolID, Activo)
		 values
		 (@CodigoUsuario, 1, 1)

		 insert into ConsultoraFicticia
		 ([ConsultoraID],			[SeccionID],			[RegionID],				[ZonaID],				[TerritorioID], 
		  [SegmentoID],				[IdEstadoActividad],	[IdEstadoDatamart],		[Codigo],				[PrimerNombre], 
		  [SegundoNombre],			[PrimerApellido],		[SegundoApellido],		[NombreCompleto],		[FechaNacimiento], 
		  [Genero],					[EstadoCivil],			[PrimerPedido],			[KtiNueva],				[AutorizaPedido], 
		  [Email],					[MontoUltimoPedido],	[EstatusCapacitacion],	[MontoFlexipago],		[CampaniaPrimeraID],
		  [UltimaCampanaFacturada],	[EstadoConsultora],		[AnoCampanaIngreso],	[IndicadorPasoPedido],	[ModificacionDatosBB],
		  [IndicadorProl],			[MontoMaximoPedido],	[MontoMinimoPedido],	[FechaIngreso],			[MontoSaldoActual],
		  [EstadoBloqueo],			[FechaCarga],			[IndicadorFlexiPago],	[IndicadorDupla],		[CompraKitDupla])
		
		select
			@consultoraid,				[SeccionID],			[RegionID],				[ZonaID],				[TerritorioID],
			[SegmentoID],				[IdEstadoActividad],	[IdEstadoDatamart],		@codigo,				@CodigoUsuario,
			'',							'',						'',						@CodigoUsuario,			[FechaNacimiento],
			[Genero],					[EstadoCivil],			[PrimerPedido],			[KtiNueva],				[AutorizaPedido],
			[Email],					[MontoUltimoPedido],	[EstatusCapacitacion],	[MontoFlexipago],		[CampaniaPrimeraID],
			[UltimaCampanaFacturada],	[EstadoConsultora],		[AnoCampanaIngreso],	[IndicadorPasoPedido],	[ModificacionDatosBB], 
			[IndicadorProl],			[MontoMaximoPedido],	[MontoMinimoPedido],	[FechaIngreso],			[MontoSaldoActual],
			[EstadoBloqueo],			[FechaCarga],			[IndicadorFlexiPago],	[IndicadorDupla],		[CompraKitDupla]		
		from 
			ods.consultora
		where
			codigo = @CodigoConsultora
			
		select 1
	 end
	 else
	 begin
		select 3
	 end
end

GO

USE BelcorpPanama
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsConsultoraFicticia]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsConsultoraFicticia]
GO

CREATE PROCEDURE [dbo].[InsConsultoraFicticia]

@PaisID int,
@CodigoUsuario varchar(20),
@CodigoConsultora varchar(20),
@Clave varchar(200)
as

declare @Validador int
declare @consultoraid bigint
declare @codigo varchar(25)

begin
	
	set @Validador = (select count(*) from [dbo].[UsuarioPrueba] where [CodigoUsuario] = @CodigoUsuario and [CodigoConsultoraAsociada] = @CodigoConsultora)
	
	if @Validador = 0
	begin
		
		set @consultoraid = (select isnull(max(consultoraID),999000000) + 1 from consultoraficticia )
		set @codigo = CAST(@consultoraid AS VARCHAR)

		insert into [dbo].[UsuarioPrueba]
		([CodigoUsuario], [CodigoConsultoraAsociada], [CodigoFicticio])
		values
		(@CodigoUsuario, @CodigoConsultora, @Codigo)

		declare @ClaveEncriptada varchar(200) = ''
		SET @ClaveEncriptada = dbo.EncriptarClaveSHA1(@Clave)

		insert into [dbo].[Usuario]
		([CodigoUsuario], [PaisID], [CodigoConsultora], [Nombre], [ClaveSecreta], [EMail], 
		 [EMailActivo], [Telefono], [Celular], [Sobrenombre], [CompartirDatos], [Activo], 
		 [TipoUsuario], [CambioClave], [UsuarioPrueba])
		values
		(@CodigoUsuario, @PaisID, @codigo, @CodigoUsuario, @ClaveEncriptada, null,
		 0, '','','',0,1,
		 1, 0, 1)
		 
		 insert into dbo.UsuarioRol
		 (CodigoUsuario, RolID, Activo)
		 values
		 (@CodigoUsuario, 1, 1)

		 insert into ConsultoraFicticia
		 ([ConsultoraID],			[SeccionID],			[RegionID],				[ZonaID],				[TerritorioID], 
		  [SegmentoID],				[IdEstadoActividad],	[IdEstadoDatamart],		[Codigo],				[PrimerNombre], 
		  [SegundoNombre],			[PrimerApellido],		[SegundoApellido],		[NombreCompleto],		[FechaNacimiento], 
		  [Genero],					[EstadoCivil],			[PrimerPedido],			[KtiNueva],				[AutorizaPedido], 
		  [Email],					[MontoUltimoPedido],	[EstatusCapacitacion],	[MontoFlexipago],		[CampaniaPrimeraID],
		  [UltimaCampanaFacturada],	[EstadoConsultora],		[AnoCampanaIngreso],	[IndicadorPasoPedido],	[ModificacionDatosBB],
		  [IndicadorProl],			[MontoMaximoPedido],	[MontoMinimoPedido],	[FechaIngreso],			[MontoSaldoActual],
		  [EstadoBloqueo],			[FechaCarga],			[IndicadorFlexiPago],	[IndicadorDupla],		[CompraKitDupla])
		
		select
			@consultoraid,				[SeccionID],			[RegionID],				[ZonaID],				[TerritorioID],
			[SegmentoID],				[IdEstadoActividad],	[IdEstadoDatamart],		@codigo,				@CodigoUsuario,
			'',							'',						'',						@CodigoUsuario,			[FechaNacimiento],
			[Genero],					[EstadoCivil],			[PrimerPedido],			[KtiNueva],				[AutorizaPedido],
			[Email],					[MontoUltimoPedido],	[EstatusCapacitacion],	[MontoFlexipago],		[CampaniaPrimeraID],
			[UltimaCampanaFacturada],	[EstadoConsultora],		[AnoCampanaIngreso],	[IndicadorPasoPedido],	[ModificacionDatosBB], 
			[IndicadorProl],			[MontoMaximoPedido],	[MontoMinimoPedido],	[FechaIngreso],			[MontoSaldoActual],
			[EstadoBloqueo],			[FechaCarga],			[IndicadorFlexiPago],	[IndicadorDupla],		[CompraKitDupla]		
		from 
			ods.consultora
		where
			codigo = @CodigoConsultora
			
		select 1
	 end
	 else
	 begin
		select 3
	 end
end

GO

USE BelcorpGuatemala
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsConsultoraFicticia]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsConsultoraFicticia]
GO

CREATE PROCEDURE [dbo].[InsConsultoraFicticia]

@PaisID int,
@CodigoUsuario varchar(20),
@CodigoConsultora varchar(20),
@Clave varchar(200)
as

declare @Validador int
declare @consultoraid bigint
declare @codigo varchar(25)

begin
	
	set @Validador = (select count(*) from [dbo].[UsuarioPrueba] where [CodigoUsuario] = @CodigoUsuario and [CodigoConsultoraAsociada] = @CodigoConsultora)
	
	if @Validador = 0
	begin
		
		set @consultoraid = (select isnull(max(consultoraID),999000000) + 1 from consultoraficticia )
		set @codigo = CAST(@consultoraid AS VARCHAR)

		insert into [dbo].[UsuarioPrueba]
		([CodigoUsuario], [CodigoConsultoraAsociada], [CodigoFicticio])
		values
		(@CodigoUsuario, @CodigoConsultora, @Codigo)

		declare @ClaveEncriptada varchar(200) = ''
		SET @ClaveEncriptada = dbo.EncriptarClaveSHA1(@Clave)

		insert into [dbo].[Usuario]
		([CodigoUsuario], [PaisID], [CodigoConsultora], [Nombre], [ClaveSecreta], [EMail], 
		 [EMailActivo], [Telefono], [Celular], [Sobrenombre], [CompartirDatos], [Activo], 
		 [TipoUsuario], [CambioClave], [UsuarioPrueba])
		values
		(@CodigoUsuario, @PaisID, @codigo, @CodigoUsuario, @ClaveEncriptada, null,
		 0, '','','',0,1,
		 1, 0, 1)
		 
		 insert into dbo.UsuarioRol
		 (CodigoUsuario, RolID, Activo)
		 values
		 (@CodigoUsuario, 1, 1)

		 insert into ConsultoraFicticia
		 ([ConsultoraID],			[SeccionID],			[RegionID],				[ZonaID],				[TerritorioID], 
		  [SegmentoID],				[IdEstadoActividad],	[IdEstadoDatamart],		[Codigo],				[PrimerNombre], 
		  [SegundoNombre],			[PrimerApellido],		[SegundoApellido],		[NombreCompleto],		[FechaNacimiento], 
		  [Genero],					[EstadoCivil],			[PrimerPedido],			[KtiNueva],				[AutorizaPedido], 
		  [Email],					[MontoUltimoPedido],	[EstatusCapacitacion],	[MontoFlexipago],		[CampaniaPrimeraID],
		  [UltimaCampanaFacturada],	[EstadoConsultora],		[AnoCampanaIngreso],	[IndicadorPasoPedido],	[ModificacionDatosBB],
		  [IndicadorProl],			[MontoMaximoPedido],	[MontoMinimoPedido],	[FechaIngreso],			[MontoSaldoActual],
		  [EstadoBloqueo],			[FechaCarga],			[IndicadorFlexiPago],	[IndicadorDupla],		[CompraKitDupla])
		
		select
			@consultoraid,				[SeccionID],			[RegionID],				[ZonaID],				[TerritorioID],
			[SegmentoID],				[IdEstadoActividad],	[IdEstadoDatamart],		@codigo,				@CodigoUsuario,
			'',							'',						'',						@CodigoUsuario,			[FechaNacimiento],
			[Genero],					[EstadoCivil],			[PrimerPedido],			[KtiNueva],				[AutorizaPedido],
			[Email],					[MontoUltimoPedido],	[EstatusCapacitacion],	[MontoFlexipago],		[CampaniaPrimeraID],
			[UltimaCampanaFacturada],	[EstadoConsultora],		[AnoCampanaIngreso],	[IndicadorPasoPedido],	[ModificacionDatosBB], 
			[IndicadorProl],			[MontoMaximoPedido],	[MontoMinimoPedido],	[FechaIngreso],			[MontoSaldoActual],
			[EstadoBloqueo],			[FechaCarga],			[IndicadorFlexiPago],	[IndicadorDupla],		[CompraKitDupla]		
		from 
			ods.consultora
		where
			codigo = @CodigoConsultora
			
		select 1
	 end
	 else
	 begin
		select 3
	 end
end

GO

USE BelcorpEcuador
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsConsultoraFicticia]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsConsultoraFicticia]
GO

CREATE PROCEDURE [dbo].[InsConsultoraFicticia]

@PaisID int,
@CodigoUsuario varchar(20),
@CodigoConsultora varchar(20),
@Clave varchar(200)
as

declare @Validador int
declare @consultoraid bigint
declare @codigo varchar(25)

begin
	
	set @Validador = (select count(*) from [dbo].[UsuarioPrueba] where [CodigoUsuario] = @CodigoUsuario and [CodigoConsultoraAsociada] = @CodigoConsultora)
	
	if @Validador = 0
	begin
		
		set @consultoraid = (select isnull(max(consultoraID),999000000) + 1 from consultoraficticia )
		set @codigo = CAST(@consultoraid AS VARCHAR)

		insert into [dbo].[UsuarioPrueba]
		([CodigoUsuario], [CodigoConsultoraAsociada], [CodigoFicticio])
		values
		(@CodigoUsuario, @CodigoConsultora, @Codigo)

		declare @ClaveEncriptada varchar(200) = ''
		SET @ClaveEncriptada = dbo.EncriptarClaveSHA1(@Clave)

		insert into [dbo].[Usuario]
		([CodigoUsuario], [PaisID], [CodigoConsultora], [Nombre], [ClaveSecreta], [EMail], 
		 [EMailActivo], [Telefono], [Celular], [Sobrenombre], [CompartirDatos], [Activo], 
		 [TipoUsuario], [CambioClave], [UsuarioPrueba])
		values
		(@CodigoUsuario, @PaisID, @codigo, @CodigoUsuario, @ClaveEncriptada, null,
		 0, '','','',0,1,
		 1, 0, 1)
		 
		 insert into dbo.UsuarioRol
		 (CodigoUsuario, RolID, Activo)
		 values
		 (@CodigoUsuario, 1, 1)

		 insert into ConsultoraFicticia
		 ([ConsultoraID],			[SeccionID],			[RegionID],				[ZonaID],				[TerritorioID], 
		  [SegmentoID],				[IdEstadoActividad],	[IdEstadoDatamart],		[Codigo],				[PrimerNombre], 
		  [SegundoNombre],			[PrimerApellido],		[SegundoApellido],		[NombreCompleto],		[FechaNacimiento], 
		  [Genero],					[EstadoCivil],			[PrimerPedido],			[KtiNueva],				[AutorizaPedido], 
		  [Email],					[MontoUltimoPedido],	[EstatusCapacitacion],	[MontoFlexipago],		[CampaniaPrimeraID],
		  [UltimaCampanaFacturada],	[EstadoConsultora],		[AnoCampanaIngreso],	[IndicadorPasoPedido],	[ModificacionDatosBB],
		  [IndicadorProl],			[MontoMaximoPedido],	[MontoMinimoPedido],	[FechaIngreso],			[MontoSaldoActual],
		  [EstadoBloqueo],			[FechaCarga],			[IndicadorFlexiPago],	[IndicadorDupla],		[CompraKitDupla])
		
		select
			@consultoraid,				[SeccionID],			[RegionID],				[ZonaID],				[TerritorioID],
			[SegmentoID],				[IdEstadoActividad],	[IdEstadoDatamart],		@codigo,				@CodigoUsuario,
			'',							'',						'',						@CodigoUsuario,			[FechaNacimiento],
			[Genero],					[EstadoCivil],			[PrimerPedido],			[KtiNueva],				[AutorizaPedido],
			[Email],					[MontoUltimoPedido],	[EstatusCapacitacion],	[MontoFlexipago],		[CampaniaPrimeraID],
			[UltimaCampanaFacturada],	[EstadoConsultora],		[AnoCampanaIngreso],	[IndicadorPasoPedido],	[ModificacionDatosBB], 
			[IndicadorProl],			[MontoMaximoPedido],	[MontoMinimoPedido],	[FechaIngreso],			[MontoSaldoActual],
			[EstadoBloqueo],			[FechaCarga],			[IndicadorFlexiPago],	[IndicadorDupla],		[CompraKitDupla]		
		from 
			ods.consultora
		where
			codigo = @CodigoConsultora
			
		select 1
	 end
	 else
	 begin
		select 3
	 end
end

GO

USE BelcorpDominicana
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsConsultoraFicticia]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsConsultoraFicticia]
GO

CREATE PROCEDURE [dbo].[InsConsultoraFicticia]

@PaisID int,
@CodigoUsuario varchar(20),
@CodigoConsultora varchar(20),
@Clave varchar(200)
as

declare @Validador int
declare @consultoraid bigint
declare @codigo varchar(25)

begin
	
	set @Validador = (select count(*) from [dbo].[UsuarioPrueba] where [CodigoUsuario] = @CodigoUsuario and [CodigoConsultoraAsociada] = @CodigoConsultora)
	
	if @Validador = 0
	begin
		
		set @consultoraid = (select isnull(max(consultoraID),999000000) + 1 from consultoraficticia )
		set @codigo = CAST(@consultoraid AS VARCHAR)

		insert into [dbo].[UsuarioPrueba]
		([CodigoUsuario], [CodigoConsultoraAsociada], [CodigoFicticio])
		values
		(@CodigoUsuario, @CodigoConsultora, @Codigo)

		declare @ClaveEncriptada varchar(200) = ''
		SET @ClaveEncriptada = dbo.EncriptarClaveSHA1(@Clave)

		insert into [dbo].[Usuario]
		([CodigoUsuario], [PaisID], [CodigoConsultora], [Nombre], [ClaveSecreta], [EMail], 
		 [EMailActivo], [Telefono], [Celular], [Sobrenombre], [CompartirDatos], [Activo], 
		 [TipoUsuario], [CambioClave], [UsuarioPrueba])
		values
		(@CodigoUsuario, @PaisID, @codigo, @CodigoUsuario, @ClaveEncriptada, null,
		 0, '','','',0,1,
		 1, 0, 1)
		 
		 insert into dbo.UsuarioRol
		 (CodigoUsuario, RolID, Activo)
		 values
		 (@CodigoUsuario, 1, 1)

		 insert into ConsultoraFicticia
		 ([ConsultoraID],			[SeccionID],			[RegionID],				[ZonaID],				[TerritorioID], 
		  [SegmentoID],				[IdEstadoActividad],	[IdEstadoDatamart],		[Codigo],				[PrimerNombre], 
		  [SegundoNombre],			[PrimerApellido],		[SegundoApellido],		[NombreCompleto],		[FechaNacimiento], 
		  [Genero],					[EstadoCivil],			[PrimerPedido],			[KtiNueva],				[AutorizaPedido], 
		  [Email],					[MontoUltimoPedido],	[EstatusCapacitacion],	[MontoFlexipago],		[CampaniaPrimeraID],
		  [UltimaCampanaFacturada],	[EstadoConsultora],		[AnoCampanaIngreso],	[IndicadorPasoPedido],	[ModificacionDatosBB],
		  [IndicadorProl],			[MontoMaximoPedido],	[MontoMinimoPedido],	[FechaIngreso],			[MontoSaldoActual],
		  [EstadoBloqueo],			[FechaCarga],			[IndicadorFlexiPago],	[IndicadorDupla],		[CompraKitDupla])
		
		select
			@consultoraid,				[SeccionID],			[RegionID],				[ZonaID],				[TerritorioID],
			[SegmentoID],				[IdEstadoActividad],	[IdEstadoDatamart],		@codigo,				@CodigoUsuario,
			'',							'',						'',						@CodigoUsuario,			[FechaNacimiento],
			[Genero],					[EstadoCivil],			[PrimerPedido],			[KtiNueva],				[AutorizaPedido],
			[Email],					[MontoUltimoPedido],	[EstatusCapacitacion],	[MontoFlexipago],		[CampaniaPrimeraID],
			[UltimaCampanaFacturada],	[EstadoConsultora],		[AnoCampanaIngreso],	[IndicadorPasoPedido],	[ModificacionDatosBB], 
			[IndicadorProl],			[MontoMaximoPedido],	[MontoMinimoPedido],	[FechaIngreso],			[MontoSaldoActual],
			[EstadoBloqueo],			[FechaCarga],			[IndicadorFlexiPago],	[IndicadorDupla],		[CompraKitDupla]		
		from 
			ods.consultora
		where
			codigo = @CodigoConsultora
			
		select 1
	 end
	 else
	 begin
		select 3
	 end
end

GO

USE BelcorpCostaRica
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsConsultoraFicticia]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsConsultoraFicticia]
GO

CREATE PROCEDURE [dbo].[InsConsultoraFicticia]

@PaisID int,
@CodigoUsuario varchar(20),
@CodigoConsultora varchar(20),
@Clave varchar(200)
as

declare @Validador int
declare @consultoraid bigint
declare @codigo varchar(25)

begin
	
	set @Validador = (select count(*) from [dbo].[UsuarioPrueba] where [CodigoUsuario] = @CodigoUsuario and [CodigoConsultoraAsociada] = @CodigoConsultora)
	
	if @Validador = 0
	begin
		
		set @consultoraid = (select isnull(max(consultoraID),999000000) + 1 from consultoraficticia )
		set @codigo = CAST(@consultoraid AS VARCHAR)

		insert into [dbo].[UsuarioPrueba]
		([CodigoUsuario], [CodigoConsultoraAsociada], [CodigoFicticio])
		values
		(@CodigoUsuario, @CodigoConsultora, @Codigo)

		declare @ClaveEncriptada varchar(200) = ''
		SET @ClaveEncriptada = dbo.EncriptarClaveSHA1(@Clave)

		insert into [dbo].[Usuario]
		([CodigoUsuario], [PaisID], [CodigoConsultora], [Nombre], [ClaveSecreta], [EMail], 
		 [EMailActivo], [Telefono], [Celular], [Sobrenombre], [CompartirDatos], [Activo], 
		 [TipoUsuario], [CambioClave], [UsuarioPrueba])
		values
		(@CodigoUsuario, @PaisID, @codigo, @CodigoUsuario, @ClaveEncriptada, null,
		 0, '','','',0,1,
		 1, 0, 1)
		 
		 insert into dbo.UsuarioRol
		 (CodigoUsuario, RolID, Activo)
		 values
		 (@CodigoUsuario, 1, 1)

		 insert into ConsultoraFicticia
		 ([ConsultoraID],			[SeccionID],			[RegionID],				[ZonaID],				[TerritorioID], 
		  [SegmentoID],				[IdEstadoActividad],	[IdEstadoDatamart],		[Codigo],				[PrimerNombre], 
		  [SegundoNombre],			[PrimerApellido],		[SegundoApellido],		[NombreCompleto],		[FechaNacimiento], 
		  [Genero],					[EstadoCivil],			[PrimerPedido],			[KtiNueva],				[AutorizaPedido], 
		  [Email],					[MontoUltimoPedido],	[EstatusCapacitacion],	[MontoFlexipago],		[CampaniaPrimeraID],
		  [UltimaCampanaFacturada],	[EstadoConsultora],		[AnoCampanaIngreso],	[IndicadorPasoPedido],	[ModificacionDatosBB],
		  [IndicadorProl],			[MontoMaximoPedido],	[MontoMinimoPedido],	[FechaIngreso],			[MontoSaldoActual],
		  [EstadoBloqueo],			[FechaCarga],			[IndicadorFlexiPago],	[IndicadorDupla],		[CompraKitDupla])
		
		select
			@consultoraid,				[SeccionID],			[RegionID],				[ZonaID],				[TerritorioID],
			[SegmentoID],				[IdEstadoActividad],	[IdEstadoDatamart],		@codigo,				@CodigoUsuario,
			'',							'',						'',						@CodigoUsuario,			[FechaNacimiento],
			[Genero],					[EstadoCivil],			[PrimerPedido],			[KtiNueva],				[AutorizaPedido],
			[Email],					[MontoUltimoPedido],	[EstatusCapacitacion],	[MontoFlexipago],		[CampaniaPrimeraID],
			[UltimaCampanaFacturada],	[EstadoConsultora],		[AnoCampanaIngreso],	[IndicadorPasoPedido],	[ModificacionDatosBB], 
			[IndicadorProl],			[MontoMaximoPedido],	[MontoMinimoPedido],	[FechaIngreso],			[MontoSaldoActual],
			[EstadoBloqueo],			[FechaCarga],			[IndicadorFlexiPago],	[IndicadorDupla],		[CompraKitDupla]		
		from 
			ods.consultora
		where
			codigo = @CodigoConsultora
			
		select 1
	 end
	 else
	 begin
		select 3
	 end
end

GO

USE BelcorpChile
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsConsultoraFicticia]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsConsultoraFicticia]
GO

CREATE PROCEDURE [dbo].[InsConsultoraFicticia]

@PaisID int,
@CodigoUsuario varchar(20),
@CodigoConsultora varchar(20),
@Clave varchar(200)
as

declare @Validador int
declare @consultoraid bigint
declare @codigo varchar(25)

begin
	
	set @Validador = (select count(*) from [dbo].[UsuarioPrueba] where [CodigoUsuario] = @CodigoUsuario and [CodigoConsultoraAsociada] = @CodigoConsultora)
	
	if @Validador = 0
	begin
		
		set @consultoraid = (select isnull(max(consultoraID),999000000) + 1 from consultoraficticia )
		set @codigo = CAST(@consultoraid AS VARCHAR)

		insert into [dbo].[UsuarioPrueba]
		([CodigoUsuario], [CodigoConsultoraAsociada], [CodigoFicticio])
		values
		(@CodigoUsuario, @CodigoConsultora, @Codigo)

		declare @ClaveEncriptada varchar(200) = ''
		SET @ClaveEncriptada = dbo.EncriptarClaveSHA1(@Clave)

		insert into [dbo].[Usuario]
		([CodigoUsuario], [PaisID], [CodigoConsultora], [Nombre], [ClaveSecreta], [EMail], 
		 [EMailActivo], [Telefono], [Celular], [Sobrenombre], [CompartirDatos], [Activo], 
		 [TipoUsuario], [CambioClave], [UsuarioPrueba])
		values
		(@CodigoUsuario, @PaisID, @codigo, @CodigoUsuario, @ClaveEncriptada, null,
		 0, '','','',0,1,
		 1, 0, 1)
		 
		 insert into dbo.UsuarioRol
		 (CodigoUsuario, RolID, Activo)
		 values
		 (@CodigoUsuario, 1, 1)

		 insert into ConsultoraFicticia
		 ([ConsultoraID],			[SeccionID],			[RegionID],				[ZonaID],				[TerritorioID], 
		  [SegmentoID],				[IdEstadoActividad],	[IdEstadoDatamart],		[Codigo],				[PrimerNombre], 
		  [SegundoNombre],			[PrimerApellido],		[SegundoApellido],		[NombreCompleto],		[FechaNacimiento], 
		  [Genero],					[EstadoCivil],			[PrimerPedido],			[KtiNueva],				[AutorizaPedido], 
		  [Email],					[MontoUltimoPedido],	[EstatusCapacitacion],	[MontoFlexipago],		[CampaniaPrimeraID],
		  [UltimaCampanaFacturada],	[EstadoConsultora],		[AnoCampanaIngreso],	[IndicadorPasoPedido],	[ModificacionDatosBB],
		  [IndicadorProl],			[MontoMaximoPedido],	[MontoMinimoPedido],	[FechaIngreso],			[MontoSaldoActual],
		  [EstadoBloqueo],			[FechaCarga],			[IndicadorFlexiPago],	[IndicadorDupla],		[CompraKitDupla])
		
		select
			@consultoraid,				[SeccionID],			[RegionID],				[ZonaID],				[TerritorioID],
			[SegmentoID],				[IdEstadoActividad],	[IdEstadoDatamart],		@codigo,				@CodigoUsuario,
			'',							'',						'',						@CodigoUsuario,			[FechaNacimiento],
			[Genero],					[EstadoCivil],			[PrimerPedido],			[KtiNueva],				[AutorizaPedido],
			[Email],					[MontoUltimoPedido],	[EstatusCapacitacion],	[MontoFlexipago],		[CampaniaPrimeraID],
			[UltimaCampanaFacturada],	[EstadoConsultora],		[AnoCampanaIngreso],	[IndicadorPasoPedido],	[ModificacionDatosBB], 
			[IndicadorProl],			[MontoMaximoPedido],	[MontoMinimoPedido],	[FechaIngreso],			[MontoSaldoActual],
			[EstadoBloqueo],			[FechaCarga],			[IndicadorFlexiPago],	[IndicadorDupla],		[CompraKitDupla]		
		from 
			ods.consultora
		where
			codigo = @CodigoConsultora
			
		select 1
	 end
	 else
	 begin
		select 3
	 end
end

GO

USE BelcorpBolivia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsConsultoraFicticia]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsConsultoraFicticia]
GO

CREATE PROCEDURE [dbo].[InsConsultoraFicticia]

@PaisID int,
@CodigoUsuario varchar(20),
@CodigoConsultora varchar(20),
@Clave varchar(200)
as

declare @Validador int
declare @consultoraid bigint
declare @codigo varchar(25)

begin
	
	set @Validador = (select count(*) from [dbo].[UsuarioPrueba] where [CodigoUsuario] = @CodigoUsuario and [CodigoConsultoraAsociada] = @CodigoConsultora)
	
	if @Validador = 0
	begin
		
		set @consultoraid = (select isnull(max(consultoraID),999000000) + 1 from consultoraficticia )
		set @codigo = CAST(@consultoraid AS VARCHAR)

		insert into [dbo].[UsuarioPrueba]
		([CodigoUsuario], [CodigoConsultoraAsociada], [CodigoFicticio])
		values
		(@CodigoUsuario, @CodigoConsultora, @Codigo)

		declare @ClaveEncriptada varchar(200) = ''
		SET @ClaveEncriptada = dbo.EncriptarClaveSHA1(@Clave)

		insert into [dbo].[Usuario]
		([CodigoUsuario], [PaisID], [CodigoConsultora], [Nombre], [ClaveSecreta], [EMail], 
		 [EMailActivo], [Telefono], [Celular], [Sobrenombre], [CompartirDatos], [Activo], 
		 [TipoUsuario], [CambioClave], [UsuarioPrueba])
		values
		(@CodigoUsuario, @PaisID, @codigo, @CodigoUsuario, @ClaveEncriptada, null,
		 0, '','','',0,1,
		 1, 0, 1)
		 
		 insert into dbo.UsuarioRol
		 (CodigoUsuario, RolID, Activo)
		 values
		 (@CodigoUsuario, 1, 1)

		 insert into ConsultoraFicticia
		 ([ConsultoraID],			[SeccionID],			[RegionID],				[ZonaID],				[TerritorioID], 
		  [SegmentoID],				[IdEstadoActividad],	[IdEstadoDatamart],		[Codigo],				[PrimerNombre], 
		  [SegundoNombre],			[PrimerApellido],		[SegundoApellido],		[NombreCompleto],		[FechaNacimiento], 
		  [Genero],					[EstadoCivil],			[PrimerPedido],			[KtiNueva],				[AutorizaPedido], 
		  [Email],					[MontoUltimoPedido],	[EstatusCapacitacion],	[MontoFlexipago],		[CampaniaPrimeraID],
		  [UltimaCampanaFacturada],	[EstadoConsultora],		[AnoCampanaIngreso],	[IndicadorPasoPedido],	[ModificacionDatosBB],
		  [IndicadorProl],			[MontoMaximoPedido],	[MontoMinimoPedido],	[FechaIngreso],			[MontoSaldoActual],
		  [EstadoBloqueo],			[FechaCarga],			[IndicadorFlexiPago],	[IndicadorDupla],		[CompraKitDupla])
		
		select
			@consultoraid,				[SeccionID],			[RegionID],				[ZonaID],				[TerritorioID],
			[SegmentoID],				[IdEstadoActividad],	[IdEstadoDatamart],		@codigo,				@CodigoUsuario,
			'',							'',						'',						@CodigoUsuario,			[FechaNacimiento],
			[Genero],					[EstadoCivil],			[PrimerPedido],			[KtiNueva],				[AutorizaPedido],
			[Email],					[MontoUltimoPedido],	[EstatusCapacitacion],	[MontoFlexipago],		[CampaniaPrimeraID],
			[UltimaCampanaFacturada],	[EstadoConsultora],		[AnoCampanaIngreso],	[IndicadorPasoPedido],	[ModificacionDatosBB], 
			[IndicadorProl],			[MontoMaximoPedido],	[MontoMinimoPedido],	[FechaIngreso],			[MontoSaldoActual],
			[EstadoBloqueo],			[FechaCarga],			[IndicadorFlexiPago],	[IndicadorDupla],		[CompraKitDupla]		
		from 
			ods.consultora
		where
			codigo = @CodigoConsultora
			
		select 1
	 end
	 else
	 begin
		select 3
	 end
end

GO

