USE BelcorpPeru
GO

GO
ALTER PROCEDURE [dbo].[RevistaDigitalSuscripcion_Registro]
(
	 @CodigoConsultora varchar(20)
	,@CampaniaID int
	,@CampaniaEfectiva int
	,@FechaSuscripcion datetime = null
	,@FechaDesuscripcion datetime = null
	,@EstadoRegistro int = -1
	,@Origen varchar(100) = ''
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

	IF NOT EXISTS(SELECT RevistaDigitalSuscripcionID FROM RevistaDigitalSuscripcion WHERE CodigoConsultora = @CodigoConsultora and CampaniaID = @CampaniaID)
	BEGIN
		INSERT INTO RevistaDigitalSuscripcion(	
			CodigoConsultora
			,CampaniaID
			,CampaniaEfectiva
			,FechaSuscripcion
			,FechaDesuscripcion
			,EstadoRegistro
			,Origen
			,EstadoEnvio
			,IsoPais
			,CodigoZona
			,EMail
		)
		VALUES(
			 @CodigoConsultora
			,@CampaniaID
			,@CampaniaEfectiva
			,case when @EstadoRegistro = 1 then dbo.fnObtenerFechaHoraPais() else null end
			,case when @EstadoRegistro = 2 then dbo.fnObtenerFechaHoraPais() else null end
			,@EstadoRegistro
			,@Origen
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
		SET  CampaniaEfectiva = @CampaniaEfectiva
			,FechaSuscripcion =  case when @EstadoRegistro = 1 then dbo.fnObtenerFechaHoraPais() else FechaSuscripcion end
			,FechaDesuscripcion = case when @EstadoRegistro = 2  then dbo.fnObtenerFechaHoraPais() else FechaDesuscripcion end
			,EstadoEnvio = case when @EstadoRegistro = EstadoRegistro then EstadoEnvio else 0 end
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
GO

USE BelcorpMexico
GO

GO
ALTER PROCEDURE [dbo].[RevistaDigitalSuscripcion_Registro]
(
	 @CodigoConsultora varchar(20)
	,@CampaniaID int
	,@CampaniaEfectiva int
	,@FechaSuscripcion datetime = null
	,@FechaDesuscripcion datetime = null
	,@EstadoRegistro int = -1
	,@Origen varchar(100) = ''
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

	IF NOT EXISTS(SELECT RevistaDigitalSuscripcionID FROM RevistaDigitalSuscripcion WHERE CodigoConsultora = @CodigoConsultora and CampaniaID = @CampaniaID)
	BEGIN
		INSERT INTO RevistaDigitalSuscripcion(	
			CodigoConsultora
			,CampaniaID
			,CampaniaEfectiva
			,FechaSuscripcion
			,FechaDesuscripcion
			,EstadoRegistro
			,Origen
			,EstadoEnvio
			,IsoPais
			,CodigoZona
			,EMail
		)
		VALUES(
			 @CodigoConsultora
			,@CampaniaID
			,@CampaniaEfectiva
			,case when @EstadoRegistro = 1 then dbo.fnObtenerFechaHoraPais() else null end
			,case when @EstadoRegistro = 2 then dbo.fnObtenerFechaHoraPais() else null end
			,@EstadoRegistro
			,@Origen
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
		SET  CampaniaEfectiva = @CampaniaEfectiva
			,FechaSuscripcion =  case when @EstadoRegistro = 1 then dbo.fnObtenerFechaHoraPais() else FechaSuscripcion end
			,FechaDesuscripcion = case when @EstadoRegistro = 2  then dbo.fnObtenerFechaHoraPais() else FechaDesuscripcion end
			,EstadoEnvio = case when @EstadoRegistro = EstadoRegistro then EstadoEnvio else 0 end
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
GO

USE BelcorpColombia
GO

GO
ALTER PROCEDURE [dbo].[RevistaDigitalSuscripcion_Registro]
(
	 @CodigoConsultora varchar(20)
	,@CampaniaID int
	,@CampaniaEfectiva int
	,@FechaSuscripcion datetime = null
	,@FechaDesuscripcion datetime = null
	,@EstadoRegistro int = -1
	,@Origen varchar(100) = ''
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

	IF NOT EXISTS(SELECT RevistaDigitalSuscripcionID FROM RevistaDigitalSuscripcion WHERE CodigoConsultora = @CodigoConsultora and CampaniaID = @CampaniaID)
	BEGIN
		INSERT INTO RevistaDigitalSuscripcion(	
			CodigoConsultora
			,CampaniaID
			,CampaniaEfectiva
			,FechaSuscripcion
			,FechaDesuscripcion
			,EstadoRegistro
			,Origen
			,EstadoEnvio
			,IsoPais
			,CodigoZona
			,EMail
		)
		VALUES(
			 @CodigoConsultora
			,@CampaniaID
			,@CampaniaEfectiva
			,case when @EstadoRegistro = 1 then dbo.fnObtenerFechaHoraPais() else null end
			,case when @EstadoRegistro = 2 then dbo.fnObtenerFechaHoraPais() else null end
			,@EstadoRegistro
			,@Origen
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
		SET  CampaniaEfectiva = @CampaniaEfectiva
			,FechaSuscripcion =  case when @EstadoRegistro = 1 then dbo.fnObtenerFechaHoraPais() else FechaSuscripcion end
			,FechaDesuscripcion = case when @EstadoRegistro = 2  then dbo.fnObtenerFechaHoraPais() else FechaDesuscripcion end
			,EstadoEnvio = case when @EstadoRegistro = EstadoRegistro then EstadoEnvio else 0 end
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
GO

USE BelcorpVenezuela
GO

GO
ALTER PROCEDURE [dbo].[RevistaDigitalSuscripcion_Registro]
(
	 @CodigoConsultora varchar(20)
	,@CampaniaID int
	,@CampaniaEfectiva int
	,@FechaSuscripcion datetime = null
	,@FechaDesuscripcion datetime = null
	,@EstadoRegistro int = -1
	,@Origen varchar(100) = ''
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

	IF NOT EXISTS(SELECT RevistaDigitalSuscripcionID FROM RevistaDigitalSuscripcion WHERE CodigoConsultora = @CodigoConsultora and CampaniaID = @CampaniaID)
	BEGIN
		INSERT INTO RevistaDigitalSuscripcion(	
			CodigoConsultora
			,CampaniaID
			,CampaniaEfectiva
			,FechaSuscripcion
			,FechaDesuscripcion
			,EstadoRegistro
			,Origen
			,EstadoEnvio
			,IsoPais
			,CodigoZona
			,EMail
		)
		VALUES(
			 @CodigoConsultora
			,@CampaniaID
			,@CampaniaEfectiva
			,case when @EstadoRegistro = 1 then dbo.fnObtenerFechaHoraPais() else null end
			,case when @EstadoRegistro = 2 then dbo.fnObtenerFechaHoraPais() else null end
			,@EstadoRegistro
			,@Origen
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
		SET  CampaniaEfectiva = @CampaniaEfectiva
			,FechaSuscripcion =  case when @EstadoRegistro = 1 then dbo.fnObtenerFechaHoraPais() else FechaSuscripcion end
			,FechaDesuscripcion = case when @EstadoRegistro = 2  then dbo.fnObtenerFechaHoraPais() else FechaDesuscripcion end
			,EstadoEnvio = case when @EstadoRegistro = EstadoRegistro then EstadoEnvio else 0 end
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
GO

USE BelcorpSalvador
GO

GO
ALTER PROCEDURE [dbo].[RevistaDigitalSuscripcion_Registro]
(
	 @CodigoConsultora varchar(20)
	,@CampaniaID int
	,@CampaniaEfectiva int
	,@FechaSuscripcion datetime = null
	,@FechaDesuscripcion datetime = null
	,@EstadoRegistro int = -1
	,@Origen varchar(100) = ''
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

	IF NOT EXISTS(SELECT RevistaDigitalSuscripcionID FROM RevistaDigitalSuscripcion WHERE CodigoConsultora = @CodigoConsultora and CampaniaID = @CampaniaID)
	BEGIN
		INSERT INTO RevistaDigitalSuscripcion(	
			CodigoConsultora
			,CampaniaID
			,CampaniaEfectiva
			,FechaSuscripcion
			,FechaDesuscripcion
			,EstadoRegistro
			,Origen
			,EstadoEnvio
			,IsoPais
			,CodigoZona
			,EMail
		)
		VALUES(
			 @CodigoConsultora
			,@CampaniaID
			,@CampaniaEfectiva
			,case when @EstadoRegistro = 1 then dbo.fnObtenerFechaHoraPais() else null end
			,case when @EstadoRegistro = 2 then dbo.fnObtenerFechaHoraPais() else null end
			,@EstadoRegistro
			,@Origen
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
		SET  CampaniaEfectiva = @CampaniaEfectiva
			,FechaSuscripcion =  case when @EstadoRegistro = 1 then dbo.fnObtenerFechaHoraPais() else FechaSuscripcion end
			,FechaDesuscripcion = case when @EstadoRegistro = 2  then dbo.fnObtenerFechaHoraPais() else FechaDesuscripcion end
			,EstadoEnvio = case when @EstadoRegistro = EstadoRegistro then EstadoEnvio else 0 end
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
GO

USE BelcorpPuertoRico
GO

GO
ALTER PROCEDURE [dbo].[RevistaDigitalSuscripcion_Registro]
(
	 @CodigoConsultora varchar(20)
	,@CampaniaID int
	,@CampaniaEfectiva int
	,@FechaSuscripcion datetime = null
	,@FechaDesuscripcion datetime = null
	,@EstadoRegistro int = -1
	,@Origen varchar(100) = ''
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

	IF NOT EXISTS(SELECT RevistaDigitalSuscripcionID FROM RevistaDigitalSuscripcion WHERE CodigoConsultora = @CodigoConsultora and CampaniaID = @CampaniaID)
	BEGIN
		INSERT INTO RevistaDigitalSuscripcion(	
			CodigoConsultora
			,CampaniaID
			,CampaniaEfectiva
			,FechaSuscripcion
			,FechaDesuscripcion
			,EstadoRegistro
			,Origen
			,EstadoEnvio
			,IsoPais
			,CodigoZona
			,EMail
		)
		VALUES(
			 @CodigoConsultora
			,@CampaniaID
			,@CampaniaEfectiva
			,case when @EstadoRegistro = 1 then dbo.fnObtenerFechaHoraPais() else null end
			,case when @EstadoRegistro = 2 then dbo.fnObtenerFechaHoraPais() else null end
			,@EstadoRegistro
			,@Origen
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
		SET  CampaniaEfectiva = @CampaniaEfectiva
			,FechaSuscripcion =  case when @EstadoRegistro = 1 then dbo.fnObtenerFechaHoraPais() else FechaSuscripcion end
			,FechaDesuscripcion = case when @EstadoRegistro = 2  then dbo.fnObtenerFechaHoraPais() else FechaDesuscripcion end
			,EstadoEnvio = case when @EstadoRegistro = EstadoRegistro then EstadoEnvio else 0 end
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
GO

USE BelcorpPanama
GO

GO
ALTER PROCEDURE [dbo].[RevistaDigitalSuscripcion_Registro]
(
	 @CodigoConsultora varchar(20)
	,@CampaniaID int
	,@CampaniaEfectiva int
	,@FechaSuscripcion datetime = null
	,@FechaDesuscripcion datetime = null
	,@EstadoRegistro int = -1
	,@Origen varchar(100) = ''
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

	IF NOT EXISTS(SELECT RevistaDigitalSuscripcionID FROM RevistaDigitalSuscripcion WHERE CodigoConsultora = @CodigoConsultora and CampaniaID = @CampaniaID)
	BEGIN
		INSERT INTO RevistaDigitalSuscripcion(	
			CodigoConsultora
			,CampaniaID
			,CampaniaEfectiva
			,FechaSuscripcion
			,FechaDesuscripcion
			,EstadoRegistro
			,Origen
			,EstadoEnvio
			,IsoPais
			,CodigoZona
			,EMail
		)
		VALUES(
			 @CodigoConsultora
			,@CampaniaID
			,@CampaniaEfectiva
			,case when @EstadoRegistro = 1 then dbo.fnObtenerFechaHoraPais() else null end
			,case when @EstadoRegistro = 2 then dbo.fnObtenerFechaHoraPais() else null end
			,@EstadoRegistro
			,@Origen
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
		SET  CampaniaEfectiva = @CampaniaEfectiva
			,FechaSuscripcion =  case when @EstadoRegistro = 1 then dbo.fnObtenerFechaHoraPais() else FechaSuscripcion end
			,FechaDesuscripcion = case when @EstadoRegistro = 2  then dbo.fnObtenerFechaHoraPais() else FechaDesuscripcion end
			,EstadoEnvio = case when @EstadoRegistro = EstadoRegistro then EstadoEnvio else 0 end
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
GO

USE BelcorpGuatemala
GO

GO
ALTER PROCEDURE [dbo].[RevistaDigitalSuscripcion_Registro]
(
	 @CodigoConsultora varchar(20)
	,@CampaniaID int
	,@CampaniaEfectiva int
	,@FechaSuscripcion datetime = null
	,@FechaDesuscripcion datetime = null
	,@EstadoRegistro int = -1
	,@Origen varchar(100) = ''
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

	IF NOT EXISTS(SELECT RevistaDigitalSuscripcionID FROM RevistaDigitalSuscripcion WHERE CodigoConsultora = @CodigoConsultora and CampaniaID = @CampaniaID)
	BEGIN
		INSERT INTO RevistaDigitalSuscripcion(	
			CodigoConsultora
			,CampaniaID
			,CampaniaEfectiva
			,FechaSuscripcion
			,FechaDesuscripcion
			,EstadoRegistro
			,Origen
			,EstadoEnvio
			,IsoPais
			,CodigoZona
			,EMail
		)
		VALUES(
			 @CodigoConsultora
			,@CampaniaID
			,@CampaniaEfectiva
			,case when @EstadoRegistro = 1 then dbo.fnObtenerFechaHoraPais() else null end
			,case when @EstadoRegistro = 2 then dbo.fnObtenerFechaHoraPais() else null end
			,@EstadoRegistro
			,@Origen
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
		SET  CampaniaEfectiva = @CampaniaEfectiva
			,FechaSuscripcion =  case when @EstadoRegistro = 1 then dbo.fnObtenerFechaHoraPais() else FechaSuscripcion end
			,FechaDesuscripcion = case when @EstadoRegistro = 2  then dbo.fnObtenerFechaHoraPais() else FechaDesuscripcion end
			,EstadoEnvio = case when @EstadoRegistro = EstadoRegistro then EstadoEnvio else 0 end
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
GO

USE BelcorpEcuador
GO

GO
ALTER PROCEDURE [dbo].[RevistaDigitalSuscripcion_Registro]
(
	 @CodigoConsultora varchar(20)
	,@CampaniaID int
	,@CampaniaEfectiva int
	,@FechaSuscripcion datetime = null
	,@FechaDesuscripcion datetime = null
	,@EstadoRegistro int = -1
	,@Origen varchar(100) = ''
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

	IF NOT EXISTS(SELECT RevistaDigitalSuscripcionID FROM RevistaDigitalSuscripcion WHERE CodigoConsultora = @CodigoConsultora and CampaniaID = @CampaniaID)
	BEGIN
		INSERT INTO RevistaDigitalSuscripcion(	
			CodigoConsultora
			,CampaniaID
			,CampaniaEfectiva
			,FechaSuscripcion
			,FechaDesuscripcion
			,EstadoRegistro
			,Origen
			,EstadoEnvio
			,IsoPais
			,CodigoZona
			,EMail
		)
		VALUES(
			 @CodigoConsultora
			,@CampaniaID
			,@CampaniaEfectiva
			,case when @EstadoRegistro = 1 then dbo.fnObtenerFechaHoraPais() else null end
			,case when @EstadoRegistro = 2 then dbo.fnObtenerFechaHoraPais() else null end
			,@EstadoRegistro
			,@Origen
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
		SET  CampaniaEfectiva = @CampaniaEfectiva
			,FechaSuscripcion =  case when @EstadoRegistro = 1 then dbo.fnObtenerFechaHoraPais() else FechaSuscripcion end
			,FechaDesuscripcion = case when @EstadoRegistro = 2  then dbo.fnObtenerFechaHoraPais() else FechaDesuscripcion end
			,EstadoEnvio = case when @EstadoRegistro = EstadoRegistro then EstadoEnvio else 0 end
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
GO

USE BelcorpDominicana
GO

GO
ALTER PROCEDURE [dbo].[RevistaDigitalSuscripcion_Registro]
(
	 @CodigoConsultora varchar(20)
	,@CampaniaID int
	,@CampaniaEfectiva int
	,@FechaSuscripcion datetime = null
	,@FechaDesuscripcion datetime = null
	,@EstadoRegistro int = -1
	,@Origen varchar(100) = ''
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

	IF NOT EXISTS(SELECT RevistaDigitalSuscripcionID FROM RevistaDigitalSuscripcion WHERE CodigoConsultora = @CodigoConsultora and CampaniaID = @CampaniaID)
	BEGIN
		INSERT INTO RevistaDigitalSuscripcion(	
			CodigoConsultora
			,CampaniaID
			,CampaniaEfectiva
			,FechaSuscripcion
			,FechaDesuscripcion
			,EstadoRegistro
			,Origen
			,EstadoEnvio
			,IsoPais
			,CodigoZona
			,EMail
		)
		VALUES(
			 @CodigoConsultora
			,@CampaniaID
			,@CampaniaEfectiva
			,case when @EstadoRegistro = 1 then dbo.fnObtenerFechaHoraPais() else null end
			,case when @EstadoRegistro = 2 then dbo.fnObtenerFechaHoraPais() else null end
			,@EstadoRegistro
			,@Origen
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
		SET  CampaniaEfectiva = @CampaniaEfectiva
			,FechaSuscripcion =  case when @EstadoRegistro = 1 then dbo.fnObtenerFechaHoraPais() else FechaSuscripcion end
			,FechaDesuscripcion = case when @EstadoRegistro = 2  then dbo.fnObtenerFechaHoraPais() else FechaDesuscripcion end
			,EstadoEnvio = case when @EstadoRegistro = EstadoRegistro then EstadoEnvio else 0 end
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
GO

USE BelcorpCostaRica
GO

GO
ALTER PROCEDURE [dbo].[RevistaDigitalSuscripcion_Registro]
(
	 @CodigoConsultora varchar(20)
	,@CampaniaID int
	,@CampaniaEfectiva int
	,@FechaSuscripcion datetime = null
	,@FechaDesuscripcion datetime = null
	,@EstadoRegistro int = -1
	,@Origen varchar(100) = ''
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

	IF NOT EXISTS(SELECT RevistaDigitalSuscripcionID FROM RevistaDigitalSuscripcion WHERE CodigoConsultora = @CodigoConsultora and CampaniaID = @CampaniaID)
	BEGIN
		INSERT INTO RevistaDigitalSuscripcion(	
			CodigoConsultora
			,CampaniaID
			,CampaniaEfectiva
			,FechaSuscripcion
			,FechaDesuscripcion
			,EstadoRegistro
			,Origen
			,EstadoEnvio
			,IsoPais
			,CodigoZona
			,EMail
		)
		VALUES(
			 @CodigoConsultora
			,@CampaniaID
			,@CampaniaEfectiva
			,case when @EstadoRegistro = 1 then dbo.fnObtenerFechaHoraPais() else null end
			,case when @EstadoRegistro = 2 then dbo.fnObtenerFechaHoraPais() else null end
			,@EstadoRegistro
			,@Origen
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
		SET  CampaniaEfectiva = @CampaniaEfectiva
			,FechaSuscripcion =  case when @EstadoRegistro = 1 then dbo.fnObtenerFechaHoraPais() else FechaSuscripcion end
			,FechaDesuscripcion = case when @EstadoRegistro = 2  then dbo.fnObtenerFechaHoraPais() else FechaDesuscripcion end
			,EstadoEnvio = case when @EstadoRegistro = EstadoRegistro then EstadoEnvio else 0 end
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
GO

USE BelcorpChile
GO

GO
ALTER PROCEDURE [dbo].[RevistaDigitalSuscripcion_Registro]
(
	 @CodigoConsultora varchar(20)
	,@CampaniaID int
	,@CampaniaEfectiva int
	,@FechaSuscripcion datetime = null
	,@FechaDesuscripcion datetime = null
	,@EstadoRegistro int = -1
	,@Origen varchar(100) = ''
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

	IF NOT EXISTS(SELECT RevistaDigitalSuscripcionID FROM RevistaDigitalSuscripcion WHERE CodigoConsultora = @CodigoConsultora and CampaniaID = @CampaniaID)
	BEGIN
		INSERT INTO RevistaDigitalSuscripcion(	
			CodigoConsultora
			,CampaniaID
			,CampaniaEfectiva
			,FechaSuscripcion
			,FechaDesuscripcion
			,EstadoRegistro
			,Origen
			,EstadoEnvio
			,IsoPais
			,CodigoZona
			,EMail
		)
		VALUES(
			 @CodigoConsultora
			,@CampaniaID
			,@CampaniaEfectiva
			,case when @EstadoRegistro = 1 then dbo.fnObtenerFechaHoraPais() else null end
			,case when @EstadoRegistro = 2 then dbo.fnObtenerFechaHoraPais() else null end
			,@EstadoRegistro
			,@Origen
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
		SET  CampaniaEfectiva = @CampaniaEfectiva
			,FechaSuscripcion =  case when @EstadoRegistro = 1 then dbo.fnObtenerFechaHoraPais() else FechaSuscripcion end
			,FechaDesuscripcion = case when @EstadoRegistro = 2  then dbo.fnObtenerFechaHoraPais() else FechaDesuscripcion end
			,EstadoEnvio = case when @EstadoRegistro = EstadoRegistro then EstadoEnvio else 0 end
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
GO

USE BelcorpBolivia
GO

GO
ALTER PROCEDURE [dbo].[RevistaDigitalSuscripcion_Registro]
(
	 @CodigoConsultora varchar(20)
	,@CampaniaID int
	,@CampaniaEfectiva int
	,@FechaSuscripcion datetime = null
	,@FechaDesuscripcion datetime = null
	,@EstadoRegistro int = -1
	,@Origen varchar(100) = ''
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

	IF NOT EXISTS(SELECT RevistaDigitalSuscripcionID FROM RevistaDigitalSuscripcion WHERE CodigoConsultora = @CodigoConsultora and CampaniaID = @CampaniaID)
	BEGIN
		INSERT INTO RevistaDigitalSuscripcion(	
			CodigoConsultora
			,CampaniaID
			,CampaniaEfectiva
			,FechaSuscripcion
			,FechaDesuscripcion
			,EstadoRegistro
			,Origen
			,EstadoEnvio
			,IsoPais
			,CodigoZona
			,EMail
		)
		VALUES(
			 @CodigoConsultora
			,@CampaniaID
			,@CampaniaEfectiva
			,case when @EstadoRegistro = 1 then dbo.fnObtenerFechaHoraPais() else null end
			,case when @EstadoRegistro = 2 then dbo.fnObtenerFechaHoraPais() else null end
			,@EstadoRegistro
			,@Origen
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
		SET  CampaniaEfectiva = @CampaniaEfectiva
			,FechaSuscripcion =  case when @EstadoRegistro = 1 then dbo.fnObtenerFechaHoraPais() else FechaSuscripcion end
			,FechaDesuscripcion = case when @EstadoRegistro = 2  then dbo.fnObtenerFechaHoraPais() else FechaDesuscripcion end
			,EstadoEnvio = case when @EstadoRegistro = EstadoRegistro then EstadoEnvio else 0 end
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
GO

