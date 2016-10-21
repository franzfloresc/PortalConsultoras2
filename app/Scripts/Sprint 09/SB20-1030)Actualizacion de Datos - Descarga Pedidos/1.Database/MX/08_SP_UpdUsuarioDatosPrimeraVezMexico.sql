USE BelcorpMexico
GO
ALTER PROCEDURE UpdUsuarioDatosPrimeraVezMexico
(
	@CodigoUsuario varchar(20),
	@Nombre varchar(50),
	@Apellidos varchar(100),
	@Telefono varchar(20),
	@TelefonoTrabajo varchar(20),
	@Celular varchar(20),
	@Email varchar(80),
	@IdConsultora int,
	@CodigoConsultora varchar(20),
	@CampaniaID_Actual varchar(20),
	@CampaniaID_UltimaF varchar(20),
	@RegionID int,
	@ZonaID int,
	@EmailAnterior varchar(80)
)
AS
BEGIN 
	DECLARE
		@m_IdConsultora int,
		@m_CodigoConsultora varchar(20),
		@m_CampaniaID_Actual varchar(20),
		@m_CampaniaID_UltimoF varchar(20),
		@m_RegionID int,
		@m_ZonaID	int,
		@m_EmailAnterior varchar(80),
		@m_Pais  int=9,
		@err_message varchar(max);
		
	SELECT TOP 1
		@m_CodigoConsultora = CodigoConsultora,
		@m_Pais=PaisID,
		@m_EmailAnterior=EMail
	FROM Usuario
	WHERE CodigoUsuario=@CodigoUsuario;
			
	SELECT TOP 1
		@m_IdConsultora=ConsultoraID,
		@m_RegionID=RegionID,
		@m_ZonaID=ZonaID,
		@m_CampaniaID_UltimoF=UltimaCampanaFacturada 
	FROM ods.Consultora 
	WHERE Codigo=@m_CodigoConsultora;

	SELECT TOP 1 @m_CampaniaID_Actual = campaniaId
	FROM dbo.GetCampaniaPreLogin(@m_Pais,@m_ZonaID,@m_RegionID,@m_IdConsultora)
		
	IF EXISTS(SELECT 1 FROM DatosActualizadosUsuario WHERE CodigoConsultora = @m_CodigoConsultora)
	BEGIN
		SET @err_message = 'Sus Datos ya fueron actualizados. Muchas gracias';
		RAISERROR (@err_message, 11,1);
	END
	ELSE IF EXISTS(SELECT 1 FROM Usuario WHERE CodigoUsuario<>@CodigoUsuario AND EMail=@Email) 
		OR EXISTS(SELECT 1 FROM DatosActualizadosUsuario WHERE CodigoConsultora <> @m_CodigoConsultora AND EMail=@Email)
	BEGIN				
		SET @err_message = 'El correo '+@Email +' ya esta siendo usada por otra consultora'
		RAISERROR (@err_message, 11,1)
	END 
	ELSE
	BEGIN
		INSERT INTO DatosActualizadosUsuario(
			Nombre,
			Apellidos,
			Telefono,
			TelefonoTrabajo,
			Celular,
			Email,
			IdConsultora,
			CodigoConsultora,
			CampaniaID_Actual,
			FechaRegistro,
			CampaniaID_UltimaF,
			RegionID,
			ZonaID
		)
		VALUES (
			@Nombre,
			@Apellidos,
			@Telefono,
			@TelefonoTrabajo,
			@Celular,
			@Email,
			@m_IdConsultora,
			@m_CodigoConsultora,
			@m_CampaniaID_Actual,
			GETDATE(),
			@m_CampaniaID_UltimoF,
			@m_RegionID,
			@m_ZonaID
		);
	END
END