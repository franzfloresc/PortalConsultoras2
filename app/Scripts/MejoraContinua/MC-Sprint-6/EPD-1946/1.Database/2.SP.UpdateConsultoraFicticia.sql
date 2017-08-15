USE BelcorpPeru
GO

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdConsultoraFicticia]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[UpdConsultoraFicticia]
GO

CREATE procedure UpdConsultoraFicticia

@CodigoUsuario varchar(20),
@CodigoConsultora varchar(20),
@ConsultoraID bigint,
@Clave varchar(200) = ''

as

begin
	if (select top 1 [CodigoConsultoraAsociada] from [dbo].[UsuarioPrueba] where [CodigoUsuario] = @CodigoUsuario) <> @CodigoConsultora
	begin
		update [dbo].[UsuarioPrueba]
		set [CodigoConsultoraAsociada] = @CodigoConsultora
		where [CodigoUsuario] = @CodigoUsuario
	end
	/* Actualizar la clave de la consultora ficticia. */
	IF (@Clave <> '')
	BEGIN
		DECLARE @ClaveEncriptada varchar(200) = ''
		SET @ClaveEncriptada = dbo.EncriptarClaveSHA1(@Clave)

		UPDATE  [dbo].[Usuario] SET ClaveSecreta =  @ClaveEncriptada 
		WHERE CodigoUsuario = @CodigoUsuario
	END

	update dbo.ConsultoraFicticia
	set
		[SeccionID] = (select [SeccionID] from ods.consultora where codigo = @CodigoConsultora),
		[RegionID] = (select [RegionID] from ods.consultora where codigo = @CodigoConsultora),
		[ZonaID] = (select [ZonaID] from ods.consultora where codigo = @CodigoConsultora),
		[TerritorioID] = (select [TerritorioID] from ods.consultora where codigo = @CodigoConsultora),
		[SegmentoID] = (select [SegmentoID] from ods.consultora where codigo = @CodigoConsultora),
		[IdEstadoActividad] = (select [IdEstadoActividad] from ods.consultora where codigo = @CodigoConsultora),
		[IdEstadoDatamart] = (select [IdEstadoDatamart] from ods.consultora where codigo = @CodigoConsultora),
		[FechaNacimiento] = (select [FechaNacimiento] from ods.consultora where codigo = @CodigoConsultora),
		[Genero] = (select [Genero] from ods.consultora where codigo = @CodigoConsultora),		
		[EstadoCivil] = (select [EstadoCivil] from ods.consultora where codigo = @CodigoConsultora),
		[PrimerPedido] = (select [PrimerPedido] from ods.consultora where codigo = @CodigoConsultora),
		[KtiNueva] = (select [KtiNueva] from ods.consultora where codigo = @CodigoConsultora),
		[AutorizaPedido] = (select [AutorizaPedido] from ods.consultora where codigo = @CodigoConsultora),
		[Email] = (select [Email] from ods.consultora where codigo = @CodigoConsultora),	
		[MontoUltimoPedido] = (select [MontoUltimoPedido] from ods.consultora where codigo = @CodigoConsultora),
		[EstatusCapacitacion] = (select [EstatusCapacitacion] from ods.consultora where codigo = @CodigoConsultora),
		[MontoFlexipago] = (select [MontoFlexipago] from ods.consultora where codigo = @CodigoConsultora),
		[CampaniaPrimeraID] = (select [CampaniaPrimeraID] from ods.consultora where codigo = @CodigoConsultora),
		[UltimaCampanaFacturada] = (select [UltimaCampanaFacturada] from ods.consultora where codigo = @CodigoConsultora),
		[EstadoConsultora] = (select [EstadoConsultora] from ods.consultora where codigo = @CodigoConsultora),
		[AnoCampanaIngreso] = (select [AnoCampanaIngreso] from ods.consultora where codigo = @CodigoConsultora),
		[IndicadorPasoPedido] = (select [IndicadorPasoPedido] from ods.consultora where codigo = @CodigoConsultora),
		[ModificacionDatosBB] = (select [ModificacionDatosBB] from ods.consultora where codigo = @CodigoConsultora),
		[IndicadorProl] = (select [IndicadorProl] from ods.consultora where codigo = @CodigoConsultora),
		[MontoMaximoPedido] = (select [MontoMaximoPedido] from ods.consultora where codigo = @CodigoConsultora),
		[MontoMinimoPedido] = (select [MontoMinimoPedido] from ods.consultora where codigo = @CodigoConsultora),
		[FechaIngreso] = (select [FechaIngreso] from ods.consultora where codigo = @CodigoConsultora),
		[MontoSaldoActual] = (select [MontoSaldoActual] from ods.consultora where codigo = @CodigoConsultora),
		[EstadoBloqueo] = (select [EstadoBloqueo] from ods.consultora where codigo = @CodigoConsultora),
		[FechaCarga] = (select [FechaCarga] from ods.consultora where codigo = @CodigoConsultora),
		[IndicadorFlexiPago] = (select [IndicadorFlexiPago] from ods.consultora where codigo = @CodigoConsultora),
		[IndicadorDupla] = (select [IndicadorDupla] from ods.consultora where codigo = @CodigoConsultora)
	where
		ConsultoraID = @ConsultoraID
end


GO

USE BelcorpMexico
GO

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdConsultoraFicticia]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[UpdConsultoraFicticia]
GO

CREATE procedure UpdConsultoraFicticia

@CodigoUsuario varchar(20),
@CodigoConsultora varchar(20),
@ConsultoraID bigint,
@Clave varchar(200) = ''

as

begin
	if (select top 1 [CodigoConsultoraAsociada] from [dbo].[UsuarioPrueba] where [CodigoUsuario] = @CodigoUsuario) <> @CodigoConsultora
	begin
		update [dbo].[UsuarioPrueba]
		set [CodigoConsultoraAsociada] = @CodigoConsultora
		where [CodigoUsuario] = @CodigoUsuario
	end
	/* Actualizar la clave de la consultora ficticia. */
	IF (@Clave <> '')
	BEGIN
		DECLARE @ClaveEncriptada varchar(200) = ''
		SET @ClaveEncriptada = dbo.EncriptarClaveSHA1(@Clave)

		UPDATE  [dbo].[Usuario] SET ClaveSecreta =  @ClaveEncriptada 
		WHERE CodigoUsuario = @CodigoUsuario
	END

	update dbo.ConsultoraFicticia
	set
		[SeccionID] = (select [SeccionID] from ods.consultora where codigo = @CodigoConsultora),
		[RegionID] = (select [RegionID] from ods.consultora where codigo = @CodigoConsultora),
		[ZonaID] = (select [ZonaID] from ods.consultora where codigo = @CodigoConsultora),
		[TerritorioID] = (select [TerritorioID] from ods.consultora where codigo = @CodigoConsultora),
		[SegmentoID] = (select [SegmentoID] from ods.consultora where codigo = @CodigoConsultora),
		[IdEstadoActividad] = (select [IdEstadoActividad] from ods.consultora where codigo = @CodigoConsultora),
		[IdEstadoDatamart] = (select [IdEstadoDatamart] from ods.consultora where codigo = @CodigoConsultora),
		[FechaNacimiento] = (select [FechaNacimiento] from ods.consultora where codigo = @CodigoConsultora),
		[Genero] = (select [Genero] from ods.consultora where codigo = @CodigoConsultora),		
		[EstadoCivil] = (select [EstadoCivil] from ods.consultora where codigo = @CodigoConsultora),
		[PrimerPedido] = (select [PrimerPedido] from ods.consultora where codigo = @CodigoConsultora),
		[KtiNueva] = (select [KtiNueva] from ods.consultora where codigo = @CodigoConsultora),
		[AutorizaPedido] = (select [AutorizaPedido] from ods.consultora where codigo = @CodigoConsultora),
		[Email] = (select [Email] from ods.consultora where codigo = @CodigoConsultora),	
		[MontoUltimoPedido] = (select [MontoUltimoPedido] from ods.consultora where codigo = @CodigoConsultora),
		[EstatusCapacitacion] = (select [EstatusCapacitacion] from ods.consultora where codigo = @CodigoConsultora),
		[MontoFlexipago] = (select [MontoFlexipago] from ods.consultora where codigo = @CodigoConsultora),
		[CampaniaPrimeraID] = (select [CampaniaPrimeraID] from ods.consultora where codigo = @CodigoConsultora),
		[UltimaCampanaFacturada] = (select [UltimaCampanaFacturada] from ods.consultora where codigo = @CodigoConsultora),
		[EstadoConsultora] = (select [EstadoConsultora] from ods.consultora where codigo = @CodigoConsultora),
		[AnoCampanaIngreso] = (select [AnoCampanaIngreso] from ods.consultora where codigo = @CodigoConsultora),
		[IndicadorPasoPedido] = (select [IndicadorPasoPedido] from ods.consultora where codigo = @CodigoConsultora),
		[ModificacionDatosBB] = (select [ModificacionDatosBB] from ods.consultora where codigo = @CodigoConsultora),
		[IndicadorProl] = (select [IndicadorProl] from ods.consultora where codigo = @CodigoConsultora),
		[MontoMaximoPedido] = (select [MontoMaximoPedido] from ods.consultora where codigo = @CodigoConsultora),
		[MontoMinimoPedido] = (select [MontoMinimoPedido] from ods.consultora where codigo = @CodigoConsultora),
		[FechaIngreso] = (select [FechaIngreso] from ods.consultora where codigo = @CodigoConsultora),
		[MontoSaldoActual] = (select [MontoSaldoActual] from ods.consultora where codigo = @CodigoConsultora),
		[EstadoBloqueo] = (select [EstadoBloqueo] from ods.consultora where codigo = @CodigoConsultora),
		[FechaCarga] = (select [FechaCarga] from ods.consultora where codigo = @CodigoConsultora),
		[IndicadorFlexiPago] = (select [IndicadorFlexiPago] from ods.consultora where codigo = @CodigoConsultora),
		[IndicadorDupla] = (select [IndicadorDupla] from ods.consultora where codigo = @CodigoConsultora)
	where
		ConsultoraID = @ConsultoraID
end


GO

USE BelcorpColombia
GO

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdConsultoraFicticia]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[UpdConsultoraFicticia]
GO

CREATE procedure UpdConsultoraFicticia

@CodigoUsuario varchar(20),
@CodigoConsultora varchar(20),
@ConsultoraID bigint,
@Clave varchar(200) = ''

as

begin
	if (select top 1 [CodigoConsultoraAsociada] from [dbo].[UsuarioPrueba] where [CodigoUsuario] = @CodigoUsuario) <> @CodigoConsultora
	begin
		update [dbo].[UsuarioPrueba]
		set [CodigoConsultoraAsociada] = @CodigoConsultora
		where [CodigoUsuario] = @CodigoUsuario
	end
	/* Actualizar la clave de la consultora ficticia. */
	IF (@Clave <> '')
	BEGIN
		DECLARE @ClaveEncriptada varchar(200) = ''
		SET @ClaveEncriptada = dbo.EncriptarClaveSHA1(@Clave)

		UPDATE  [dbo].[Usuario] SET ClaveSecreta =  @ClaveEncriptada 
		WHERE CodigoUsuario = @CodigoUsuario
	END

	update dbo.ConsultoraFicticia
	set
		[SeccionID] = (select [SeccionID] from ods.consultora where codigo = @CodigoConsultora),
		[RegionID] = (select [RegionID] from ods.consultora where codigo = @CodigoConsultora),
		[ZonaID] = (select [ZonaID] from ods.consultora where codigo = @CodigoConsultora),
		[TerritorioID] = (select [TerritorioID] from ods.consultora where codigo = @CodigoConsultora),
		[SegmentoID] = (select [SegmentoID] from ods.consultora where codigo = @CodigoConsultora),
		[IdEstadoActividad] = (select [IdEstadoActividad] from ods.consultora where codigo = @CodigoConsultora),
		[IdEstadoDatamart] = (select [IdEstadoDatamart] from ods.consultora where codigo = @CodigoConsultora),
		[FechaNacimiento] = (select [FechaNacimiento] from ods.consultora where codigo = @CodigoConsultora),
		[Genero] = (select [Genero] from ods.consultora where codigo = @CodigoConsultora),		
		[EstadoCivil] = (select [EstadoCivil] from ods.consultora where codigo = @CodigoConsultora),
		[PrimerPedido] = (select [PrimerPedido] from ods.consultora where codigo = @CodigoConsultora),
		[KtiNueva] = (select [KtiNueva] from ods.consultora where codigo = @CodigoConsultora),
		[AutorizaPedido] = (select [AutorizaPedido] from ods.consultora where codigo = @CodigoConsultora),
		[Email] = (select [Email] from ods.consultora where codigo = @CodigoConsultora),	
		[MontoUltimoPedido] = (select [MontoUltimoPedido] from ods.consultora where codigo = @CodigoConsultora),
		[EstatusCapacitacion] = (select [EstatusCapacitacion] from ods.consultora where codigo = @CodigoConsultora),
		[MontoFlexipago] = (select [MontoFlexipago] from ods.consultora where codigo = @CodigoConsultora),
		[CampaniaPrimeraID] = (select [CampaniaPrimeraID] from ods.consultora where codigo = @CodigoConsultora),
		[UltimaCampanaFacturada] = (select [UltimaCampanaFacturada] from ods.consultora where codigo = @CodigoConsultora),
		[EstadoConsultora] = (select [EstadoConsultora] from ods.consultora where codigo = @CodigoConsultora),
		[AnoCampanaIngreso] = (select [AnoCampanaIngreso] from ods.consultora where codigo = @CodigoConsultora),
		[IndicadorPasoPedido] = (select [IndicadorPasoPedido] from ods.consultora where codigo = @CodigoConsultora),
		[ModificacionDatosBB] = (select [ModificacionDatosBB] from ods.consultora where codigo = @CodigoConsultora),
		[IndicadorProl] = (select [IndicadorProl] from ods.consultora where codigo = @CodigoConsultora),
		[MontoMaximoPedido] = (select [MontoMaximoPedido] from ods.consultora where codigo = @CodigoConsultora),
		[MontoMinimoPedido] = (select [MontoMinimoPedido] from ods.consultora where codigo = @CodigoConsultora),
		[FechaIngreso] = (select [FechaIngreso] from ods.consultora where codigo = @CodigoConsultora),
		[MontoSaldoActual] = (select [MontoSaldoActual] from ods.consultora where codigo = @CodigoConsultora),
		[EstadoBloqueo] = (select [EstadoBloqueo] from ods.consultora where codigo = @CodigoConsultora),
		[FechaCarga] = (select [FechaCarga] from ods.consultora where codigo = @CodigoConsultora),
		[IndicadorFlexiPago] = (select [IndicadorFlexiPago] from ods.consultora where codigo = @CodigoConsultora),
		[IndicadorDupla] = (select [IndicadorDupla] from ods.consultora where codigo = @CodigoConsultora)
	where
		ConsultoraID = @ConsultoraID
end


GO

USE BelcorpVenezuela
GO

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdConsultoraFicticia]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[UpdConsultoraFicticia]
GO

CREATE procedure UpdConsultoraFicticia

@CodigoUsuario varchar(20),
@CodigoConsultora varchar(20),
@ConsultoraID bigint,
@Clave varchar(200) = ''

as

begin
	if (select top 1 [CodigoConsultoraAsociada] from [dbo].[UsuarioPrueba] where [CodigoUsuario] = @CodigoUsuario) <> @CodigoConsultora
	begin
		update [dbo].[UsuarioPrueba]
		set [CodigoConsultoraAsociada] = @CodigoConsultora
		where [CodigoUsuario] = @CodigoUsuario
	end
	/* Actualizar la clave de la consultora ficticia. */
	IF (@Clave <> '')
	BEGIN
		DECLARE @ClaveEncriptada varchar(200) = ''
		SET @ClaveEncriptada = dbo.EncriptarClaveSHA1(@Clave)

		UPDATE  [dbo].[Usuario] SET ClaveSecreta =  @ClaveEncriptada 
		WHERE CodigoUsuario = @CodigoUsuario
	END

	update dbo.ConsultoraFicticia
	set
		[SeccionID] = (select [SeccionID] from ods.consultora where codigo = @CodigoConsultora),
		[RegionID] = (select [RegionID] from ods.consultora where codigo = @CodigoConsultora),
		[ZonaID] = (select [ZonaID] from ods.consultora where codigo = @CodigoConsultora),
		[TerritorioID] = (select [TerritorioID] from ods.consultora where codigo = @CodigoConsultora),
		[SegmentoID] = (select [SegmentoID] from ods.consultora where codigo = @CodigoConsultora),
		[IdEstadoActividad] = (select [IdEstadoActividad] from ods.consultora where codigo = @CodigoConsultora),
		[IdEstadoDatamart] = (select [IdEstadoDatamart] from ods.consultora where codigo = @CodigoConsultora),
		[FechaNacimiento] = (select [FechaNacimiento] from ods.consultora where codigo = @CodigoConsultora),
		[Genero] = (select [Genero] from ods.consultora where codigo = @CodigoConsultora),		
		[EstadoCivil] = (select [EstadoCivil] from ods.consultora where codigo = @CodigoConsultora),
		[PrimerPedido] = (select [PrimerPedido] from ods.consultora where codigo = @CodigoConsultora),
		[KtiNueva] = (select [KtiNueva] from ods.consultora where codigo = @CodigoConsultora),
		[AutorizaPedido] = (select [AutorizaPedido] from ods.consultora where codigo = @CodigoConsultora),
		[Email] = (select [Email] from ods.consultora where codigo = @CodigoConsultora),	
		[MontoUltimoPedido] = (select [MontoUltimoPedido] from ods.consultora where codigo = @CodigoConsultora),
		[EstatusCapacitacion] = (select [EstatusCapacitacion] from ods.consultora where codigo = @CodigoConsultora),
		[MontoFlexipago] = (select [MontoFlexipago] from ods.consultora where codigo = @CodigoConsultora),
		[CampaniaPrimeraID] = (select [CampaniaPrimeraID] from ods.consultora where codigo = @CodigoConsultora),
		[UltimaCampanaFacturada] = (select [UltimaCampanaFacturada] from ods.consultora where codigo = @CodigoConsultora),
		[EstadoConsultora] = (select [EstadoConsultora] from ods.consultora where codigo = @CodigoConsultora),
		[AnoCampanaIngreso] = (select [AnoCampanaIngreso] from ods.consultora where codigo = @CodigoConsultora),
		[IndicadorPasoPedido] = (select [IndicadorPasoPedido] from ods.consultora where codigo = @CodigoConsultora),
		[ModificacionDatosBB] = (select [ModificacionDatosBB] from ods.consultora where codigo = @CodigoConsultora),
		[IndicadorProl] = (select [IndicadorProl] from ods.consultora where codigo = @CodigoConsultora),
		[MontoMaximoPedido] = (select [MontoMaximoPedido] from ods.consultora where codigo = @CodigoConsultora),
		[MontoMinimoPedido] = (select [MontoMinimoPedido] from ods.consultora where codigo = @CodigoConsultora),
		[FechaIngreso] = (select [FechaIngreso] from ods.consultora where codigo = @CodigoConsultora),
		[MontoSaldoActual] = (select [MontoSaldoActual] from ods.consultora where codigo = @CodigoConsultora),
		[EstadoBloqueo] = (select [EstadoBloqueo] from ods.consultora where codigo = @CodigoConsultora),
		[FechaCarga] = (select [FechaCarga] from ods.consultora where codigo = @CodigoConsultora),
		[IndicadorFlexiPago] = (select [IndicadorFlexiPago] from ods.consultora where codigo = @CodigoConsultora),
		[IndicadorDupla] = (select [IndicadorDupla] from ods.consultora where codigo = @CodigoConsultora)
	where
		ConsultoraID = @ConsultoraID
end


GO

USE BelcorpSalvador
GO

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdConsultoraFicticia]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[UpdConsultoraFicticia]
GO

CREATE procedure UpdConsultoraFicticia

@CodigoUsuario varchar(20),
@CodigoConsultora varchar(20),
@ConsultoraID bigint,
@Clave varchar(200) = ''

as

begin
	if (select top 1 [CodigoConsultoraAsociada] from [dbo].[UsuarioPrueba] where [CodigoUsuario] = @CodigoUsuario) <> @CodigoConsultora
	begin
		update [dbo].[UsuarioPrueba]
		set [CodigoConsultoraAsociada] = @CodigoConsultora
		where [CodigoUsuario] = @CodigoUsuario
	end
	/* Actualizar la clave de la consultora ficticia. */
	IF (@Clave <> '')
	BEGIN
		DECLARE @ClaveEncriptada varchar(200) = ''
		SET @ClaveEncriptada = dbo.EncriptarClaveSHA1(@Clave)

		UPDATE  [dbo].[Usuario] SET ClaveSecreta =  @ClaveEncriptada 
		WHERE CodigoUsuario = @CodigoUsuario
	END

	update dbo.ConsultoraFicticia
	set
		[SeccionID] = (select [SeccionID] from ods.consultora where codigo = @CodigoConsultora),
		[RegionID] = (select [RegionID] from ods.consultora where codigo = @CodigoConsultora),
		[ZonaID] = (select [ZonaID] from ods.consultora where codigo = @CodigoConsultora),
		[TerritorioID] = (select [TerritorioID] from ods.consultora where codigo = @CodigoConsultora),
		[SegmentoID] = (select [SegmentoID] from ods.consultora where codigo = @CodigoConsultora),
		[IdEstadoActividad] = (select [IdEstadoActividad] from ods.consultora where codigo = @CodigoConsultora),
		[IdEstadoDatamart] = (select [IdEstadoDatamart] from ods.consultora where codigo = @CodigoConsultora),
		[FechaNacimiento] = (select [FechaNacimiento] from ods.consultora where codigo = @CodigoConsultora),
		[Genero] = (select [Genero] from ods.consultora where codigo = @CodigoConsultora),		
		[EstadoCivil] = (select [EstadoCivil] from ods.consultora where codigo = @CodigoConsultora),
		[PrimerPedido] = (select [PrimerPedido] from ods.consultora where codigo = @CodigoConsultora),
		[KtiNueva] = (select [KtiNueva] from ods.consultora where codigo = @CodigoConsultora),
		[AutorizaPedido] = (select [AutorizaPedido] from ods.consultora where codigo = @CodigoConsultora),
		[Email] = (select [Email] from ods.consultora where codigo = @CodigoConsultora),	
		[MontoUltimoPedido] = (select [MontoUltimoPedido] from ods.consultora where codigo = @CodigoConsultora),
		[EstatusCapacitacion] = (select [EstatusCapacitacion] from ods.consultora where codigo = @CodigoConsultora),
		[MontoFlexipago] = (select [MontoFlexipago] from ods.consultora where codigo = @CodigoConsultora),
		[CampaniaPrimeraID] = (select [CampaniaPrimeraID] from ods.consultora where codigo = @CodigoConsultora),
		[UltimaCampanaFacturada] = (select [UltimaCampanaFacturada] from ods.consultora where codigo = @CodigoConsultora),
		[EstadoConsultora] = (select [EstadoConsultora] from ods.consultora where codigo = @CodigoConsultora),
		[AnoCampanaIngreso] = (select [AnoCampanaIngreso] from ods.consultora where codigo = @CodigoConsultora),
		[IndicadorPasoPedido] = (select [IndicadorPasoPedido] from ods.consultora where codigo = @CodigoConsultora),
		[ModificacionDatosBB] = (select [ModificacionDatosBB] from ods.consultora where codigo = @CodigoConsultora),
		[IndicadorProl] = (select [IndicadorProl] from ods.consultora where codigo = @CodigoConsultora),
		[MontoMaximoPedido] = (select [MontoMaximoPedido] from ods.consultora where codigo = @CodigoConsultora),
		[MontoMinimoPedido] = (select [MontoMinimoPedido] from ods.consultora where codigo = @CodigoConsultora),
		[FechaIngreso] = (select [FechaIngreso] from ods.consultora where codigo = @CodigoConsultora),
		[MontoSaldoActual] = (select [MontoSaldoActual] from ods.consultora where codigo = @CodigoConsultora),
		[EstadoBloqueo] = (select [EstadoBloqueo] from ods.consultora where codigo = @CodigoConsultora),
		[FechaCarga] = (select [FechaCarga] from ods.consultora where codigo = @CodigoConsultora),
		[IndicadorFlexiPago] = (select [IndicadorFlexiPago] from ods.consultora where codigo = @CodigoConsultora),
		[IndicadorDupla] = (select [IndicadorDupla] from ods.consultora where codigo = @CodigoConsultora)
	where
		ConsultoraID = @ConsultoraID
end


GO

USE BelcorpPuertoRico
GO

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdConsultoraFicticia]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[UpdConsultoraFicticia]
GO

CREATE procedure UpdConsultoraFicticia

@CodigoUsuario varchar(20),
@CodigoConsultora varchar(20),
@ConsultoraID bigint,
@Clave varchar(200) = ''

as

begin
	if (select top 1 [CodigoConsultoraAsociada] from [dbo].[UsuarioPrueba] where [CodigoUsuario] = @CodigoUsuario) <> @CodigoConsultora
	begin
		update [dbo].[UsuarioPrueba]
		set [CodigoConsultoraAsociada] = @CodigoConsultora
		where [CodigoUsuario] = @CodigoUsuario
	end
	/* Actualizar la clave de la consultora ficticia. */
	IF (@Clave <> '')
	BEGIN
		DECLARE @ClaveEncriptada varchar(200) = ''
		SET @ClaveEncriptada = dbo.EncriptarClaveSHA1(@Clave)

		UPDATE  [dbo].[Usuario] SET ClaveSecreta =  @ClaveEncriptada 
		WHERE CodigoUsuario = @CodigoUsuario
	END

	update dbo.ConsultoraFicticia
	set
		[SeccionID] = (select [SeccionID] from ods.consultora where codigo = @CodigoConsultora),
		[RegionID] = (select [RegionID] from ods.consultora where codigo = @CodigoConsultora),
		[ZonaID] = (select [ZonaID] from ods.consultora where codigo = @CodigoConsultora),
		[TerritorioID] = (select [TerritorioID] from ods.consultora where codigo = @CodigoConsultora),
		[SegmentoID] = (select [SegmentoID] from ods.consultora where codigo = @CodigoConsultora),
		[IdEstadoActividad] = (select [IdEstadoActividad] from ods.consultora where codigo = @CodigoConsultora),
		[IdEstadoDatamart] = (select [IdEstadoDatamart] from ods.consultora where codigo = @CodigoConsultora),
		[FechaNacimiento] = (select [FechaNacimiento] from ods.consultora where codigo = @CodigoConsultora),
		[Genero] = (select [Genero] from ods.consultora where codigo = @CodigoConsultora),		
		[EstadoCivil] = (select [EstadoCivil] from ods.consultora where codigo = @CodigoConsultora),
		[PrimerPedido] = (select [PrimerPedido] from ods.consultora where codigo = @CodigoConsultora),
		[KtiNueva] = (select [KtiNueva] from ods.consultora where codigo = @CodigoConsultora),
		[AutorizaPedido] = (select [AutorizaPedido] from ods.consultora where codigo = @CodigoConsultora),
		[Email] = (select [Email] from ods.consultora where codigo = @CodigoConsultora),	
		[MontoUltimoPedido] = (select [MontoUltimoPedido] from ods.consultora where codigo = @CodigoConsultora),
		[EstatusCapacitacion] = (select [EstatusCapacitacion] from ods.consultora where codigo = @CodigoConsultora),
		[MontoFlexipago] = (select [MontoFlexipago] from ods.consultora where codigo = @CodigoConsultora),
		[CampaniaPrimeraID] = (select [CampaniaPrimeraID] from ods.consultora where codigo = @CodigoConsultora),
		[UltimaCampanaFacturada] = (select [UltimaCampanaFacturada] from ods.consultora where codigo = @CodigoConsultora),
		[EstadoConsultora] = (select [EstadoConsultora] from ods.consultora where codigo = @CodigoConsultora),
		[AnoCampanaIngreso] = (select [AnoCampanaIngreso] from ods.consultora where codigo = @CodigoConsultora),
		[IndicadorPasoPedido] = (select [IndicadorPasoPedido] from ods.consultora where codigo = @CodigoConsultora),
		[ModificacionDatosBB] = (select [ModificacionDatosBB] from ods.consultora where codigo = @CodigoConsultora),
		[IndicadorProl] = (select [IndicadorProl] from ods.consultora where codigo = @CodigoConsultora),
		[MontoMaximoPedido] = (select [MontoMaximoPedido] from ods.consultora where codigo = @CodigoConsultora),
		[MontoMinimoPedido] = (select [MontoMinimoPedido] from ods.consultora where codigo = @CodigoConsultora),
		[FechaIngreso] = (select [FechaIngreso] from ods.consultora where codigo = @CodigoConsultora),
		[MontoSaldoActual] = (select [MontoSaldoActual] from ods.consultora where codigo = @CodigoConsultora),
		[EstadoBloqueo] = (select [EstadoBloqueo] from ods.consultora where codigo = @CodigoConsultora),
		[FechaCarga] = (select [FechaCarga] from ods.consultora where codigo = @CodigoConsultora),
		[IndicadorFlexiPago] = (select [IndicadorFlexiPago] from ods.consultora where codigo = @CodigoConsultora),
		[IndicadorDupla] = (select [IndicadorDupla] from ods.consultora where codigo = @CodigoConsultora)
	where
		ConsultoraID = @ConsultoraID
end


GO

USE BelcorpPanama
GO

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdConsultoraFicticia]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[UpdConsultoraFicticia]
GO

CREATE procedure UpdConsultoraFicticia

@CodigoUsuario varchar(20),
@CodigoConsultora varchar(20),
@ConsultoraID bigint,
@Clave varchar(200) = ''

as

begin
	if (select top 1 [CodigoConsultoraAsociada] from [dbo].[UsuarioPrueba] where [CodigoUsuario] = @CodigoUsuario) <> @CodigoConsultora
	begin
		update [dbo].[UsuarioPrueba]
		set [CodigoConsultoraAsociada] = @CodigoConsultora
		where [CodigoUsuario] = @CodigoUsuario
	end
	/* Actualizar la clave de la consultora ficticia. */
	IF (@Clave <> '')
	BEGIN
		DECLARE @ClaveEncriptada varchar(200) = ''
		SET @ClaveEncriptada = dbo.EncriptarClaveSHA1(@Clave)

		UPDATE  [dbo].[Usuario] SET ClaveSecreta =  @ClaveEncriptada 
		WHERE CodigoUsuario = @CodigoUsuario
	END

	update dbo.ConsultoraFicticia
	set
		[SeccionID] = (select [SeccionID] from ods.consultora where codigo = @CodigoConsultora),
		[RegionID] = (select [RegionID] from ods.consultora where codigo = @CodigoConsultora),
		[ZonaID] = (select [ZonaID] from ods.consultora where codigo = @CodigoConsultora),
		[TerritorioID] = (select [TerritorioID] from ods.consultora where codigo = @CodigoConsultora),
		[SegmentoID] = (select [SegmentoID] from ods.consultora where codigo = @CodigoConsultora),
		[IdEstadoActividad] = (select [IdEstadoActividad] from ods.consultora where codigo = @CodigoConsultora),
		[IdEstadoDatamart] = (select [IdEstadoDatamart] from ods.consultora where codigo = @CodigoConsultora),
		[FechaNacimiento] = (select [FechaNacimiento] from ods.consultora where codigo = @CodigoConsultora),
		[Genero] = (select [Genero] from ods.consultora where codigo = @CodigoConsultora),		
		[EstadoCivil] = (select [EstadoCivil] from ods.consultora where codigo = @CodigoConsultora),
		[PrimerPedido] = (select [PrimerPedido] from ods.consultora where codigo = @CodigoConsultora),
		[KtiNueva] = (select [KtiNueva] from ods.consultora where codigo = @CodigoConsultora),
		[AutorizaPedido] = (select [AutorizaPedido] from ods.consultora where codigo = @CodigoConsultora),
		[Email] = (select [Email] from ods.consultora where codigo = @CodigoConsultora),	
		[MontoUltimoPedido] = (select [MontoUltimoPedido] from ods.consultora where codigo = @CodigoConsultora),
		[EstatusCapacitacion] = (select [EstatusCapacitacion] from ods.consultora where codigo = @CodigoConsultora),
		[MontoFlexipago] = (select [MontoFlexipago] from ods.consultora where codigo = @CodigoConsultora),
		[CampaniaPrimeraID] = (select [CampaniaPrimeraID] from ods.consultora where codigo = @CodigoConsultora),
		[UltimaCampanaFacturada] = (select [UltimaCampanaFacturada] from ods.consultora where codigo = @CodigoConsultora),
		[EstadoConsultora] = (select [EstadoConsultora] from ods.consultora where codigo = @CodigoConsultora),
		[AnoCampanaIngreso] = (select [AnoCampanaIngreso] from ods.consultora where codigo = @CodigoConsultora),
		[IndicadorPasoPedido] = (select [IndicadorPasoPedido] from ods.consultora where codigo = @CodigoConsultora),
		[ModificacionDatosBB] = (select [ModificacionDatosBB] from ods.consultora where codigo = @CodigoConsultora),
		[IndicadorProl] = (select [IndicadorProl] from ods.consultora where codigo = @CodigoConsultora),
		[MontoMaximoPedido] = (select [MontoMaximoPedido] from ods.consultora where codigo = @CodigoConsultora),
		[MontoMinimoPedido] = (select [MontoMinimoPedido] from ods.consultora where codigo = @CodigoConsultora),
		[FechaIngreso] = (select [FechaIngreso] from ods.consultora where codigo = @CodigoConsultora),
		[MontoSaldoActual] = (select [MontoSaldoActual] from ods.consultora where codigo = @CodigoConsultora),
		[EstadoBloqueo] = (select [EstadoBloqueo] from ods.consultora where codigo = @CodigoConsultora),
		[FechaCarga] = (select [FechaCarga] from ods.consultora where codigo = @CodigoConsultora),
		[IndicadorFlexiPago] = (select [IndicadorFlexiPago] from ods.consultora where codigo = @CodigoConsultora),
		[IndicadorDupla] = (select [IndicadorDupla] from ods.consultora where codigo = @CodigoConsultora)
	where
		ConsultoraID = @ConsultoraID
end


GO

USE BelcorpGuatemala
GO

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdConsultoraFicticia]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[UpdConsultoraFicticia]
GO

CREATE procedure UpdConsultoraFicticia

@CodigoUsuario varchar(20),
@CodigoConsultora varchar(20),
@ConsultoraID bigint,
@Clave varchar(200) = ''

as

begin
	if (select top 1 [CodigoConsultoraAsociada] from [dbo].[UsuarioPrueba] where [CodigoUsuario] = @CodigoUsuario) <> @CodigoConsultora
	begin
		update [dbo].[UsuarioPrueba]
		set [CodigoConsultoraAsociada] = @CodigoConsultora
		where [CodigoUsuario] = @CodigoUsuario
	end
	/* Actualizar la clave de la consultora ficticia. */
	IF (@Clave <> '')
	BEGIN
		DECLARE @ClaveEncriptada varchar(200) = ''
		SET @ClaveEncriptada = dbo.EncriptarClaveSHA1(@Clave)

		UPDATE  [dbo].[Usuario] SET ClaveSecreta =  @ClaveEncriptada 
		WHERE CodigoUsuario = @CodigoUsuario
	END

	update dbo.ConsultoraFicticia
	set
		[SeccionID] = (select [SeccionID] from ods.consultora where codigo = @CodigoConsultora),
		[RegionID] = (select [RegionID] from ods.consultora where codigo = @CodigoConsultora),
		[ZonaID] = (select [ZonaID] from ods.consultora where codigo = @CodigoConsultora),
		[TerritorioID] = (select [TerritorioID] from ods.consultora where codigo = @CodigoConsultora),
		[SegmentoID] = (select [SegmentoID] from ods.consultora where codigo = @CodigoConsultora),
		[IdEstadoActividad] = (select [IdEstadoActividad] from ods.consultora where codigo = @CodigoConsultora),
		[IdEstadoDatamart] = (select [IdEstadoDatamart] from ods.consultora where codigo = @CodigoConsultora),
		[FechaNacimiento] = (select [FechaNacimiento] from ods.consultora where codigo = @CodigoConsultora),
		[Genero] = (select [Genero] from ods.consultora where codigo = @CodigoConsultora),		
		[EstadoCivil] = (select [EstadoCivil] from ods.consultora where codigo = @CodigoConsultora),
		[PrimerPedido] = (select [PrimerPedido] from ods.consultora where codigo = @CodigoConsultora),
		[KtiNueva] = (select [KtiNueva] from ods.consultora where codigo = @CodigoConsultora),
		[AutorizaPedido] = (select [AutorizaPedido] from ods.consultora where codigo = @CodigoConsultora),
		[Email] = (select [Email] from ods.consultora where codigo = @CodigoConsultora),	
		[MontoUltimoPedido] = (select [MontoUltimoPedido] from ods.consultora where codigo = @CodigoConsultora),
		[EstatusCapacitacion] = (select [EstatusCapacitacion] from ods.consultora where codigo = @CodigoConsultora),
		[MontoFlexipago] = (select [MontoFlexipago] from ods.consultora where codigo = @CodigoConsultora),
		[CampaniaPrimeraID] = (select [CampaniaPrimeraID] from ods.consultora where codigo = @CodigoConsultora),
		[UltimaCampanaFacturada] = (select [UltimaCampanaFacturada] from ods.consultora where codigo = @CodigoConsultora),
		[EstadoConsultora] = (select [EstadoConsultora] from ods.consultora where codigo = @CodigoConsultora),
		[AnoCampanaIngreso] = (select [AnoCampanaIngreso] from ods.consultora where codigo = @CodigoConsultora),
		[IndicadorPasoPedido] = (select [IndicadorPasoPedido] from ods.consultora where codigo = @CodigoConsultora),
		[ModificacionDatosBB] = (select [ModificacionDatosBB] from ods.consultora where codigo = @CodigoConsultora),
		[IndicadorProl] = (select [IndicadorProl] from ods.consultora where codigo = @CodigoConsultora),
		[MontoMaximoPedido] = (select [MontoMaximoPedido] from ods.consultora where codigo = @CodigoConsultora),
		[MontoMinimoPedido] = (select [MontoMinimoPedido] from ods.consultora where codigo = @CodigoConsultora),
		[FechaIngreso] = (select [FechaIngreso] from ods.consultora where codigo = @CodigoConsultora),
		[MontoSaldoActual] = (select [MontoSaldoActual] from ods.consultora where codigo = @CodigoConsultora),
		[EstadoBloqueo] = (select [EstadoBloqueo] from ods.consultora where codigo = @CodigoConsultora),
		[FechaCarga] = (select [FechaCarga] from ods.consultora where codigo = @CodigoConsultora),
		[IndicadorFlexiPago] = (select [IndicadorFlexiPago] from ods.consultora where codigo = @CodigoConsultora),
		[IndicadorDupla] = (select [IndicadorDupla] from ods.consultora where codigo = @CodigoConsultora)
	where
		ConsultoraID = @ConsultoraID
end


GO

USE BelcorpEcuador
GO

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdConsultoraFicticia]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[UpdConsultoraFicticia]
GO

CREATE procedure UpdConsultoraFicticia

@CodigoUsuario varchar(20),
@CodigoConsultora varchar(20),
@ConsultoraID bigint,
@Clave varchar(200) = ''

as

begin
	if (select top 1 [CodigoConsultoraAsociada] from [dbo].[UsuarioPrueba] where [CodigoUsuario] = @CodigoUsuario) <> @CodigoConsultora
	begin
		update [dbo].[UsuarioPrueba]
		set [CodigoConsultoraAsociada] = @CodigoConsultora
		where [CodigoUsuario] = @CodigoUsuario
	end
	/* Actualizar la clave de la consultora ficticia. */
	IF (@Clave <> '')
	BEGIN
		DECLARE @ClaveEncriptada varchar(200) = ''
		SET @ClaveEncriptada = dbo.EncriptarClaveSHA1(@Clave)

		UPDATE  [dbo].[Usuario] SET ClaveSecreta =  @ClaveEncriptada 
		WHERE CodigoUsuario = @CodigoUsuario
	END

	update dbo.ConsultoraFicticia
	set
		[SeccionID] = (select [SeccionID] from ods.consultora where codigo = @CodigoConsultora),
		[RegionID] = (select [RegionID] from ods.consultora where codigo = @CodigoConsultora),
		[ZonaID] = (select [ZonaID] from ods.consultora where codigo = @CodigoConsultora),
		[TerritorioID] = (select [TerritorioID] from ods.consultora where codigo = @CodigoConsultora),
		[SegmentoID] = (select [SegmentoID] from ods.consultora where codigo = @CodigoConsultora),
		[IdEstadoActividad] = (select [IdEstadoActividad] from ods.consultora where codigo = @CodigoConsultora),
		[IdEstadoDatamart] = (select [IdEstadoDatamart] from ods.consultora where codigo = @CodigoConsultora),
		[FechaNacimiento] = (select [FechaNacimiento] from ods.consultora where codigo = @CodigoConsultora),
		[Genero] = (select [Genero] from ods.consultora where codigo = @CodigoConsultora),		
		[EstadoCivil] = (select [EstadoCivil] from ods.consultora where codigo = @CodigoConsultora),
		[PrimerPedido] = (select [PrimerPedido] from ods.consultora where codigo = @CodigoConsultora),
		[KtiNueva] = (select [KtiNueva] from ods.consultora where codigo = @CodigoConsultora),
		[AutorizaPedido] = (select [AutorizaPedido] from ods.consultora where codigo = @CodigoConsultora),
		[Email] = (select [Email] from ods.consultora where codigo = @CodigoConsultora),	
		[MontoUltimoPedido] = (select [MontoUltimoPedido] from ods.consultora where codigo = @CodigoConsultora),
		[EstatusCapacitacion] = (select [EstatusCapacitacion] from ods.consultora where codigo = @CodigoConsultora),
		[MontoFlexipago] = (select [MontoFlexipago] from ods.consultora where codigo = @CodigoConsultora),
		[CampaniaPrimeraID] = (select [CampaniaPrimeraID] from ods.consultora where codigo = @CodigoConsultora),
		[UltimaCampanaFacturada] = (select [UltimaCampanaFacturada] from ods.consultora where codigo = @CodigoConsultora),
		[EstadoConsultora] = (select [EstadoConsultora] from ods.consultora where codigo = @CodigoConsultora),
		[AnoCampanaIngreso] = (select [AnoCampanaIngreso] from ods.consultora where codigo = @CodigoConsultora),
		[IndicadorPasoPedido] = (select [IndicadorPasoPedido] from ods.consultora where codigo = @CodigoConsultora),
		[ModificacionDatosBB] = (select [ModificacionDatosBB] from ods.consultora where codigo = @CodigoConsultora),
		[IndicadorProl] = (select [IndicadorProl] from ods.consultora where codigo = @CodigoConsultora),
		[MontoMaximoPedido] = (select [MontoMaximoPedido] from ods.consultora where codigo = @CodigoConsultora),
		[MontoMinimoPedido] = (select [MontoMinimoPedido] from ods.consultora where codigo = @CodigoConsultora),
		[FechaIngreso] = (select [FechaIngreso] from ods.consultora where codigo = @CodigoConsultora),
		[MontoSaldoActual] = (select [MontoSaldoActual] from ods.consultora where codigo = @CodigoConsultora),
		[EstadoBloqueo] = (select [EstadoBloqueo] from ods.consultora where codigo = @CodigoConsultora),
		[FechaCarga] = (select [FechaCarga] from ods.consultora where codigo = @CodigoConsultora),
		[IndicadorFlexiPago] = (select [IndicadorFlexiPago] from ods.consultora where codigo = @CodigoConsultora),
		[IndicadorDupla] = (select [IndicadorDupla] from ods.consultora where codigo = @CodigoConsultora)
	where
		ConsultoraID = @ConsultoraID
end


GO

USE BelcorpDominicana
GO

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdConsultoraFicticia]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[UpdConsultoraFicticia]
GO

CREATE procedure UpdConsultoraFicticia

@CodigoUsuario varchar(20),
@CodigoConsultora varchar(20),
@ConsultoraID bigint,
@Clave varchar(200) = ''

as

begin
	if (select top 1 [CodigoConsultoraAsociada] from [dbo].[UsuarioPrueba] where [CodigoUsuario] = @CodigoUsuario) <> @CodigoConsultora
	begin
		update [dbo].[UsuarioPrueba]
		set [CodigoConsultoraAsociada] = @CodigoConsultora
		where [CodigoUsuario] = @CodigoUsuario
	end
	/* Actualizar la clave de la consultora ficticia. */
	IF (@Clave <> '')
	BEGIN
		DECLARE @ClaveEncriptada varchar(200) = ''
		SET @ClaveEncriptada = dbo.EncriptarClaveSHA1(@Clave)

		UPDATE  [dbo].[Usuario] SET ClaveSecreta =  @ClaveEncriptada 
		WHERE CodigoUsuario = @CodigoUsuario
	END

	update dbo.ConsultoraFicticia
	set
		[SeccionID] = (select [SeccionID] from ods.consultora where codigo = @CodigoConsultora),
		[RegionID] = (select [RegionID] from ods.consultora where codigo = @CodigoConsultora),
		[ZonaID] = (select [ZonaID] from ods.consultora where codigo = @CodigoConsultora),
		[TerritorioID] = (select [TerritorioID] from ods.consultora where codigo = @CodigoConsultora),
		[SegmentoID] = (select [SegmentoID] from ods.consultora where codigo = @CodigoConsultora),
		[IdEstadoActividad] = (select [IdEstadoActividad] from ods.consultora where codigo = @CodigoConsultora),
		[IdEstadoDatamart] = (select [IdEstadoDatamart] from ods.consultora where codigo = @CodigoConsultora),
		[FechaNacimiento] = (select [FechaNacimiento] from ods.consultora where codigo = @CodigoConsultora),
		[Genero] = (select [Genero] from ods.consultora where codigo = @CodigoConsultora),		
		[EstadoCivil] = (select [EstadoCivil] from ods.consultora where codigo = @CodigoConsultora),
		[PrimerPedido] = (select [PrimerPedido] from ods.consultora where codigo = @CodigoConsultora),
		[KtiNueva] = (select [KtiNueva] from ods.consultora where codigo = @CodigoConsultora),
		[AutorizaPedido] = (select [AutorizaPedido] from ods.consultora where codigo = @CodigoConsultora),
		[Email] = (select [Email] from ods.consultora where codigo = @CodigoConsultora),	
		[MontoUltimoPedido] = (select [MontoUltimoPedido] from ods.consultora where codigo = @CodigoConsultora),
		[EstatusCapacitacion] = (select [EstatusCapacitacion] from ods.consultora where codigo = @CodigoConsultora),
		[MontoFlexipago] = (select [MontoFlexipago] from ods.consultora where codigo = @CodigoConsultora),
		[CampaniaPrimeraID] = (select [CampaniaPrimeraID] from ods.consultora where codigo = @CodigoConsultora),
		[UltimaCampanaFacturada] = (select [UltimaCampanaFacturada] from ods.consultora where codigo = @CodigoConsultora),
		[EstadoConsultora] = (select [EstadoConsultora] from ods.consultora where codigo = @CodigoConsultora),
		[AnoCampanaIngreso] = (select [AnoCampanaIngreso] from ods.consultora where codigo = @CodigoConsultora),
		[IndicadorPasoPedido] = (select [IndicadorPasoPedido] from ods.consultora where codigo = @CodigoConsultora),
		[ModificacionDatosBB] = (select [ModificacionDatosBB] from ods.consultora where codigo = @CodigoConsultora),
		[IndicadorProl] = (select [IndicadorProl] from ods.consultora where codigo = @CodigoConsultora),
		[MontoMaximoPedido] = (select [MontoMaximoPedido] from ods.consultora where codigo = @CodigoConsultora),
		[MontoMinimoPedido] = (select [MontoMinimoPedido] from ods.consultora where codigo = @CodigoConsultora),
		[FechaIngreso] = (select [FechaIngreso] from ods.consultora where codigo = @CodigoConsultora),
		[MontoSaldoActual] = (select [MontoSaldoActual] from ods.consultora where codigo = @CodigoConsultora),
		[EstadoBloqueo] = (select [EstadoBloqueo] from ods.consultora where codigo = @CodigoConsultora),
		[FechaCarga] = (select [FechaCarga] from ods.consultora where codigo = @CodigoConsultora),
		[IndicadorFlexiPago] = (select [IndicadorFlexiPago] from ods.consultora where codigo = @CodigoConsultora),
		[IndicadorDupla] = (select [IndicadorDupla] from ods.consultora where codigo = @CodigoConsultora)
	where
		ConsultoraID = @ConsultoraID
end


GO

USE BelcorpCostaRica
GO

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdConsultoraFicticia]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[UpdConsultoraFicticia]
GO

CREATE procedure UpdConsultoraFicticia

@CodigoUsuario varchar(20),
@CodigoConsultora varchar(20),
@ConsultoraID bigint,
@Clave varchar(200) = ''

as

begin
	if (select top 1 [CodigoConsultoraAsociada] from [dbo].[UsuarioPrueba] where [CodigoUsuario] = @CodigoUsuario) <> @CodigoConsultora
	begin
		update [dbo].[UsuarioPrueba]
		set [CodigoConsultoraAsociada] = @CodigoConsultora
		where [CodigoUsuario] = @CodigoUsuario
	end
	/* Actualizar la clave de la consultora ficticia. */
	IF (@Clave <> '')
	BEGIN
		DECLARE @ClaveEncriptada varchar(200) = ''
		SET @ClaveEncriptada = dbo.EncriptarClaveSHA1(@Clave)

		UPDATE  [dbo].[Usuario] SET ClaveSecreta =  @ClaveEncriptada 
		WHERE CodigoUsuario = @CodigoUsuario
	END

	update dbo.ConsultoraFicticia
	set
		[SeccionID] = (select [SeccionID] from ods.consultora where codigo = @CodigoConsultora),
		[RegionID] = (select [RegionID] from ods.consultora where codigo = @CodigoConsultora),
		[ZonaID] = (select [ZonaID] from ods.consultora where codigo = @CodigoConsultora),
		[TerritorioID] = (select [TerritorioID] from ods.consultora where codigo = @CodigoConsultora),
		[SegmentoID] = (select [SegmentoID] from ods.consultora where codigo = @CodigoConsultora),
		[IdEstadoActividad] = (select [IdEstadoActividad] from ods.consultora where codigo = @CodigoConsultora),
		[IdEstadoDatamart] = (select [IdEstadoDatamart] from ods.consultora where codigo = @CodigoConsultora),
		[FechaNacimiento] = (select [FechaNacimiento] from ods.consultora where codigo = @CodigoConsultora),
		[Genero] = (select [Genero] from ods.consultora where codigo = @CodigoConsultora),		
		[EstadoCivil] = (select [EstadoCivil] from ods.consultora where codigo = @CodigoConsultora),
		[PrimerPedido] = (select [PrimerPedido] from ods.consultora where codigo = @CodigoConsultora),
		[KtiNueva] = (select [KtiNueva] from ods.consultora where codigo = @CodigoConsultora),
		[AutorizaPedido] = (select [AutorizaPedido] from ods.consultora where codigo = @CodigoConsultora),
		[Email] = (select [Email] from ods.consultora where codigo = @CodigoConsultora),	
		[MontoUltimoPedido] = (select [MontoUltimoPedido] from ods.consultora where codigo = @CodigoConsultora),
		[EstatusCapacitacion] = (select [EstatusCapacitacion] from ods.consultora where codigo = @CodigoConsultora),
		[MontoFlexipago] = (select [MontoFlexipago] from ods.consultora where codigo = @CodigoConsultora),
		[CampaniaPrimeraID] = (select [CampaniaPrimeraID] from ods.consultora where codigo = @CodigoConsultora),
		[UltimaCampanaFacturada] = (select [UltimaCampanaFacturada] from ods.consultora where codigo = @CodigoConsultora),
		[EstadoConsultora] = (select [EstadoConsultora] from ods.consultora where codigo = @CodigoConsultora),
		[AnoCampanaIngreso] = (select [AnoCampanaIngreso] from ods.consultora where codigo = @CodigoConsultora),
		[IndicadorPasoPedido] = (select [IndicadorPasoPedido] from ods.consultora where codigo = @CodigoConsultora),
		[ModificacionDatosBB] = (select [ModificacionDatosBB] from ods.consultora where codigo = @CodigoConsultora),
		[IndicadorProl] = (select [IndicadorProl] from ods.consultora where codigo = @CodigoConsultora),
		[MontoMaximoPedido] = (select [MontoMaximoPedido] from ods.consultora where codigo = @CodigoConsultora),
		[MontoMinimoPedido] = (select [MontoMinimoPedido] from ods.consultora where codigo = @CodigoConsultora),
		[FechaIngreso] = (select [FechaIngreso] from ods.consultora where codigo = @CodigoConsultora),
		[MontoSaldoActual] = (select [MontoSaldoActual] from ods.consultora where codigo = @CodigoConsultora),
		[EstadoBloqueo] = (select [EstadoBloqueo] from ods.consultora where codigo = @CodigoConsultora),
		[FechaCarga] = (select [FechaCarga] from ods.consultora where codigo = @CodigoConsultora),
		[IndicadorFlexiPago] = (select [IndicadorFlexiPago] from ods.consultora where codigo = @CodigoConsultora),
		[IndicadorDupla] = (select [IndicadorDupla] from ods.consultora where codigo = @CodigoConsultora)
	where
		ConsultoraID = @ConsultoraID
end


GO

USE BelcorpChile
GO

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdConsultoraFicticia]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[UpdConsultoraFicticia]
GO

CREATE procedure UpdConsultoraFicticia

@CodigoUsuario varchar(20),
@CodigoConsultora varchar(20),
@ConsultoraID bigint,
@Clave varchar(200) = ''

as

begin
	if (select top 1 [CodigoConsultoraAsociada] from [dbo].[UsuarioPrueba] where [CodigoUsuario] = @CodigoUsuario) <> @CodigoConsultora
	begin
		update [dbo].[UsuarioPrueba]
		set [CodigoConsultoraAsociada] = @CodigoConsultora
		where [CodigoUsuario] = @CodigoUsuario
	end
	/* Actualizar la clave de la consultora ficticia. */
	IF (@Clave <> '')
	BEGIN
		DECLARE @ClaveEncriptada varchar(200) = ''
		SET @ClaveEncriptada = dbo.EncriptarClaveSHA1(@Clave)

		UPDATE  [dbo].[Usuario] SET ClaveSecreta =  @ClaveEncriptada 
		WHERE CodigoUsuario = @CodigoUsuario
	END

	update dbo.ConsultoraFicticia
	set
		[SeccionID] = (select [SeccionID] from ods.consultora where codigo = @CodigoConsultora),
		[RegionID] = (select [RegionID] from ods.consultora where codigo = @CodigoConsultora),
		[ZonaID] = (select [ZonaID] from ods.consultora where codigo = @CodigoConsultora),
		[TerritorioID] = (select [TerritorioID] from ods.consultora where codigo = @CodigoConsultora),
		[SegmentoID] = (select [SegmentoID] from ods.consultora where codigo = @CodigoConsultora),
		[IdEstadoActividad] = (select [IdEstadoActividad] from ods.consultora where codigo = @CodigoConsultora),
		[IdEstadoDatamart] = (select [IdEstadoDatamart] from ods.consultora where codigo = @CodigoConsultora),
		[FechaNacimiento] = (select [FechaNacimiento] from ods.consultora where codigo = @CodigoConsultora),
		[Genero] = (select [Genero] from ods.consultora where codigo = @CodigoConsultora),		
		[EstadoCivil] = (select [EstadoCivil] from ods.consultora where codigo = @CodigoConsultora),
		[PrimerPedido] = (select [PrimerPedido] from ods.consultora where codigo = @CodigoConsultora),
		[KtiNueva] = (select [KtiNueva] from ods.consultora where codigo = @CodigoConsultora),
		[AutorizaPedido] = (select [AutorizaPedido] from ods.consultora where codigo = @CodigoConsultora),
		[Email] = (select [Email] from ods.consultora where codigo = @CodigoConsultora),	
		[MontoUltimoPedido] = (select [MontoUltimoPedido] from ods.consultora where codigo = @CodigoConsultora),
		[EstatusCapacitacion] = (select [EstatusCapacitacion] from ods.consultora where codigo = @CodigoConsultora),
		[MontoFlexipago] = (select [MontoFlexipago] from ods.consultora where codigo = @CodigoConsultora),
		[CampaniaPrimeraID] = (select [CampaniaPrimeraID] from ods.consultora where codigo = @CodigoConsultora),
		[UltimaCampanaFacturada] = (select [UltimaCampanaFacturada] from ods.consultora where codigo = @CodigoConsultora),
		[EstadoConsultora] = (select [EstadoConsultora] from ods.consultora where codigo = @CodigoConsultora),
		[AnoCampanaIngreso] = (select [AnoCampanaIngreso] from ods.consultora where codigo = @CodigoConsultora),
		[IndicadorPasoPedido] = (select [IndicadorPasoPedido] from ods.consultora where codigo = @CodigoConsultora),
		[ModificacionDatosBB] = (select [ModificacionDatosBB] from ods.consultora where codigo = @CodigoConsultora),
		[IndicadorProl] = (select [IndicadorProl] from ods.consultora where codigo = @CodigoConsultora),
		[MontoMaximoPedido] = (select [MontoMaximoPedido] from ods.consultora where codigo = @CodigoConsultora),
		[MontoMinimoPedido] = (select [MontoMinimoPedido] from ods.consultora where codigo = @CodigoConsultora),
		[FechaIngreso] = (select [FechaIngreso] from ods.consultora where codigo = @CodigoConsultora),
		[MontoSaldoActual] = (select [MontoSaldoActual] from ods.consultora where codigo = @CodigoConsultora),
		[EstadoBloqueo] = (select [EstadoBloqueo] from ods.consultora where codigo = @CodigoConsultora),
		[FechaCarga] = (select [FechaCarga] from ods.consultora where codigo = @CodigoConsultora),
		[IndicadorFlexiPago] = (select [IndicadorFlexiPago] from ods.consultora where codigo = @CodigoConsultora),
		[IndicadorDupla] = (select [IndicadorDupla] from ods.consultora where codigo = @CodigoConsultora)
	where
		ConsultoraID = @ConsultoraID
end


GO

USE BelcorpBolivia
GO

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdConsultoraFicticia]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[UpdConsultoraFicticia]
GO

CREATE procedure UpdConsultoraFicticia

@CodigoUsuario varchar(20),
@CodigoConsultora varchar(20),
@ConsultoraID bigint,
@Clave varchar(200) = ''

as

begin
	if (select top 1 [CodigoConsultoraAsociada] from [dbo].[UsuarioPrueba] where [CodigoUsuario] = @CodigoUsuario) <> @CodigoConsultora
	begin
		update [dbo].[UsuarioPrueba]
		set [CodigoConsultoraAsociada] = @CodigoConsultora
		where [CodigoUsuario] = @CodigoUsuario
	end
	/* Actualizar la clave de la consultora ficticia. */
	IF (@Clave <> '')
	BEGIN
		DECLARE @ClaveEncriptada varchar(200) = ''
		SET @ClaveEncriptada = dbo.EncriptarClaveSHA1(@Clave)

		UPDATE  [dbo].[Usuario] SET ClaveSecreta =  @ClaveEncriptada 
		WHERE CodigoUsuario = @CodigoUsuario
	END

	update dbo.ConsultoraFicticia
	set
		[SeccionID] = (select [SeccionID] from ods.consultora where codigo = @CodigoConsultora),
		[RegionID] = (select [RegionID] from ods.consultora where codigo = @CodigoConsultora),
		[ZonaID] = (select [ZonaID] from ods.consultora where codigo = @CodigoConsultora),
		[TerritorioID] = (select [TerritorioID] from ods.consultora where codigo = @CodigoConsultora),
		[SegmentoID] = (select [SegmentoID] from ods.consultora where codigo = @CodigoConsultora),
		[IdEstadoActividad] = (select [IdEstadoActividad] from ods.consultora where codigo = @CodigoConsultora),
		[IdEstadoDatamart] = (select [IdEstadoDatamart] from ods.consultora where codigo = @CodigoConsultora),
		[FechaNacimiento] = (select [FechaNacimiento] from ods.consultora where codigo = @CodigoConsultora),
		[Genero] = (select [Genero] from ods.consultora where codigo = @CodigoConsultora),		
		[EstadoCivil] = (select [EstadoCivil] from ods.consultora where codigo = @CodigoConsultora),
		[PrimerPedido] = (select [PrimerPedido] from ods.consultora where codigo = @CodigoConsultora),
		[KtiNueva] = (select [KtiNueva] from ods.consultora where codigo = @CodigoConsultora),
		[AutorizaPedido] = (select [AutorizaPedido] from ods.consultora where codigo = @CodigoConsultora),
		[Email] = (select [Email] from ods.consultora where codigo = @CodigoConsultora),	
		[MontoUltimoPedido] = (select [MontoUltimoPedido] from ods.consultora where codigo = @CodigoConsultora),
		[EstatusCapacitacion] = (select [EstatusCapacitacion] from ods.consultora where codigo = @CodigoConsultora),
		[MontoFlexipago] = (select [MontoFlexipago] from ods.consultora where codigo = @CodigoConsultora),
		[CampaniaPrimeraID] = (select [CampaniaPrimeraID] from ods.consultora where codigo = @CodigoConsultora),
		[UltimaCampanaFacturada] = (select [UltimaCampanaFacturada] from ods.consultora where codigo = @CodigoConsultora),
		[EstadoConsultora] = (select [EstadoConsultora] from ods.consultora where codigo = @CodigoConsultora),
		[AnoCampanaIngreso] = (select [AnoCampanaIngreso] from ods.consultora where codigo = @CodigoConsultora),
		[IndicadorPasoPedido] = (select [IndicadorPasoPedido] from ods.consultora where codigo = @CodigoConsultora),
		[ModificacionDatosBB] = (select [ModificacionDatosBB] from ods.consultora where codigo = @CodigoConsultora),
		[IndicadorProl] = (select [IndicadorProl] from ods.consultora where codigo = @CodigoConsultora),
		[MontoMaximoPedido] = (select [MontoMaximoPedido] from ods.consultora where codigo = @CodigoConsultora),
		[MontoMinimoPedido] = (select [MontoMinimoPedido] from ods.consultora where codigo = @CodigoConsultora),
		[FechaIngreso] = (select [FechaIngreso] from ods.consultora where codigo = @CodigoConsultora),
		[MontoSaldoActual] = (select [MontoSaldoActual] from ods.consultora where codigo = @CodigoConsultora),
		[EstadoBloqueo] = (select [EstadoBloqueo] from ods.consultora where codigo = @CodigoConsultora),
		[FechaCarga] = (select [FechaCarga] from ods.consultora where codigo = @CodigoConsultora),
		[IndicadorFlexiPago] = (select [IndicadorFlexiPago] from ods.consultora where codigo = @CodigoConsultora),
		[IndicadorDupla] = (select [IndicadorDupla] from ods.consultora where codigo = @CodigoConsultora)
	where
		ConsultoraID = @ConsultoraID
end


GO

