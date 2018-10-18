
ALTER PROCEDURE [dbo].[RevistaDigitalSuscripcion_Registro]
(
	 @CodigoConsultora varchar(20)
	,@CampaniaID int
	,@FechaSuscripcion datetime = null
	,@FechaDesuscripcion datetime = null
	,@EstadoRegistro int = -1
	,@EstadoEnvio int = 0
	,@IsoPais varchar(2) = ''
	,@CodigoZona varchar(4) = ''
	,@EMail varchar(100) = ''
	,@RetornoID int output
)
AS
BEGIN
	
	set @RetornoID = 0
	set @EstadoRegistro = case when @EstadoRegistro <= 0 then 1 else @EstadoRegistro end

	-- este store se considera para Suscripcion y Desuscripcion, cambiar para considerar ambos estados

	IF NOT EXISTS(SELECT RevistaDigitalSuscripcionID FROM RevistaDigitalSuscripcion WHERE CodigoConsultora = @CodigoConsultora and CampaniaID = @CampaniaID)
	BEGIN
  		INSERT INTO RevistaDigitalSuscripcion(	
			CodigoConsultora
			,CampaniaID
			,FechaSuscripcion
			,FechaDesuscripcion
			,EstadoRegistro
			,EstadoEnvio
			,IsoPais
			,CodigoZona
			,EMail
		)
  		VALUES(
			 @CodigoConsultora
			,@CampaniaID
			,case when @EstadoRegistro = 1 then dbo.fnObtenerFechaHoraPais() else null end
			,case when @EstadoRegistro = 2 then dbo.fnObtenerFechaHoraPais() else null end
			,@EstadoRegistro
			,0
			,@IsoPais
			,@CodigoZona
			,@EMail
		)
		SET @RetornoID =  SCOPE_IDENTITY();
	END 
	ELSE
	BEGIN
		UPDATE RevistaDigitalSuscripcion 
		SET  FechaSuscripcion =  case when @EstadoRegistro = 1 then dbo.fnObtenerFechaHoraPais() else FechaSuscripcion end
			,FechaDesuscripcion = case when @EstadoRegistro = 2  then dbo.fnObtenerFechaHoraPais() else FechaDesuscripcion end
			,EstadoRegistro = @EstadoRegistro
			,IsoPais = @IsoPais
			,CodigoZona = @CodigoZona
			,EMail = @EMail
			,@RetornoID = RevistaDigitalSuscripcionID
		WHERE CodigoConsultora = @CodigoConsultora and CampaniaID = @CampaniaID
	END 

	INSERT INTO SuscripcionHistorial (Codigo, CodigoConsultora, Accion, Fecha)
	VALUES ('RD', @CodigoConsultora, CASE @EstadoRegistro WHEN 1 THEN 'Inscripcion' WHEN 2 THEN 'Cancelar Inscripcion' ELSE 'No me interesa' END , dbo.fnObtenerFechaHoraPais());
END

