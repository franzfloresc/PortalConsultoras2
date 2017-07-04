USE BelcorpPeru
GO

----------------------------------------------------------------------------------------------
-- INGRESO O ACUTALIZACION DE UN NUEVO REGISTRO DE SUSCRIPCION EN BASE AL CODIGO DE CONSULTORA
----------------------------------------------------------------------------------------------

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[RevistaDigitalSuscripcion_Registro]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[RevistaDigitalSuscripcion_Registro]
GO

CREATE PROCEDURE [dbo].[RevistaDigitalSuscripcion_Registro]
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
		WHERE CodigoConsultora = @CodigoConsultora and CampaniaID = @CampaniaID
		SET @RetornoID = (SELECT RevistaDigitalSuscripcionID FROM RevistaDigitalSuscripcion WHERE CodigoConsultora = @CodigoConsultora);
	END 

	INSERT INTO SuscripcionHistorial (Codigo, CodigoConsultora, Accion, Fecha)
	VALUES ('RD', @CodigoConsultora, CASE @EstadoRegistro WHEN 1 THEN 'Inscripcion' WHEN 2 THEN 'Cancelar Inscripcion' ELSE 'No me interesa' END , dbo.fnObtenerFechaHoraPais());
END
GO
/*end*/

USE BelcorpMexico
GO

----------------------------------------------------------------------------------------------
-- INGRESO O ACUTALIZACION DE UN NUEVO REGISTRO DE SUSCRIPCION EN BASE AL CODIGO DE CONSULTORA
----------------------------------------------------------------------------------------------

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[RevistaDigitalSuscripcion_Registro]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[RevistaDigitalSuscripcion_Registro]
GO

CREATE PROCEDURE [dbo].[RevistaDigitalSuscripcion_Registro]
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
		WHERE CodigoConsultora = @CodigoConsultora and CampaniaID = @CampaniaID
		SET @RetornoID = (SELECT RevistaDigitalSuscripcionID FROM RevistaDigitalSuscripcion WHERE CodigoConsultora = @CodigoConsultora);
	END 

	INSERT INTO SuscripcionHistorial (Codigo, CodigoConsultora, Accion, Fecha)
	VALUES ('RD', @CodigoConsultora, CASE @EstadoRegistro WHEN 1 THEN 'Inscripcion' WHEN 2 THEN 'Cancelar Inscripcion' ELSE 'No me interesa' END , dbo.fnObtenerFechaHoraPais());
END
GO
/*end*/

USE BelcorpColombia
GO

----------------------------------------------------------------------------------------------
-- INGRESO O ACUTALIZACION DE UN NUEVO REGISTRO DE SUSCRIPCION EN BASE AL CODIGO DE CONSULTORA
----------------------------------------------------------------------------------------------

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[RevistaDigitalSuscripcion_Registro]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[RevistaDigitalSuscripcion_Registro]
GO

CREATE PROCEDURE [dbo].[RevistaDigitalSuscripcion_Registro]
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
		WHERE CodigoConsultora = @CodigoConsultora and CampaniaID = @CampaniaID
		SET @RetornoID = (SELECT RevistaDigitalSuscripcionID FROM RevistaDigitalSuscripcion WHERE CodigoConsultora = @CodigoConsultora);
	END 

	INSERT INTO SuscripcionHistorial (Codigo, CodigoConsultora, Accion, Fecha)
	VALUES ('RD', @CodigoConsultora, CASE @EstadoRegistro WHEN 1 THEN 'Inscripcion' WHEN 2 THEN 'Cancelar Inscripcion' ELSE 'No me interesa' END , dbo.fnObtenerFechaHoraPais());
END
GO
/*end*/

USE BelcorpVenezuela
GO

----------------------------------------------------------------------------------------------
-- INGRESO O ACUTALIZACION DE UN NUEVO REGISTRO DE SUSCRIPCION EN BASE AL CODIGO DE CONSULTORA
----------------------------------------------------------------------------------------------

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[RevistaDigitalSuscripcion_Registro]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[RevistaDigitalSuscripcion_Registro]
GO

CREATE PROCEDURE [dbo].[RevistaDigitalSuscripcion_Registro]
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
		WHERE CodigoConsultora = @CodigoConsultora and CampaniaID = @CampaniaID
		SET @RetornoID = (SELECT RevistaDigitalSuscripcionID FROM RevistaDigitalSuscripcion WHERE CodigoConsultora = @CodigoConsultora);
	END 

	INSERT INTO SuscripcionHistorial (Codigo, CodigoConsultora, Accion, Fecha)
	VALUES ('RD', @CodigoConsultora, CASE @EstadoRegistro WHEN 1 THEN 'Inscripcion' WHEN 2 THEN 'Cancelar Inscripcion' ELSE 'No me interesa' END , dbo.fnObtenerFechaHoraPais());
END
GO
/*end*/

USE BelcorpSalvador
GO

----------------------------------------------------------------------------------------------
-- INGRESO O ACUTALIZACION DE UN NUEVO REGISTRO DE SUSCRIPCION EN BASE AL CODIGO DE CONSULTORA
----------------------------------------------------------------------------------------------

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[RevistaDigitalSuscripcion_Registro]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[RevistaDigitalSuscripcion_Registro]
GO

CREATE PROCEDURE [dbo].[RevistaDigitalSuscripcion_Registro]
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
		WHERE CodigoConsultora = @CodigoConsultora and CampaniaID = @CampaniaID
		SET @RetornoID = (SELECT RevistaDigitalSuscripcionID FROM RevistaDigitalSuscripcion WHERE CodigoConsultora = @CodigoConsultora);
	END 

	INSERT INTO SuscripcionHistorial (Codigo, CodigoConsultora, Accion, Fecha)
	VALUES ('RD', @CodigoConsultora, CASE @EstadoRegistro WHEN 1 THEN 'Inscripcion' WHEN 2 THEN 'Cancelar Inscripcion' ELSE 'No me interesa' END , dbo.fnObtenerFechaHoraPais());
END
GO
/*end*/

USE BelcorpPuertoRico
GO

----------------------------------------------------------------------------------------------
-- INGRESO O ACUTALIZACION DE UN NUEVO REGISTRO DE SUSCRIPCION EN BASE AL CODIGO DE CONSULTORA
----------------------------------------------------------------------------------------------

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[RevistaDigitalSuscripcion_Registro]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[RevistaDigitalSuscripcion_Registro]
GO

CREATE PROCEDURE [dbo].[RevistaDigitalSuscripcion_Registro]
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
		WHERE CodigoConsultora = @CodigoConsultora and CampaniaID = @CampaniaID
		SET @RetornoID = (SELECT RevistaDigitalSuscripcionID FROM RevistaDigitalSuscripcion WHERE CodigoConsultora = @CodigoConsultora);
	END 

	INSERT INTO SuscripcionHistorial (Codigo, CodigoConsultora, Accion, Fecha)
	VALUES ('RD', @CodigoConsultora, CASE @EstadoRegistro WHEN 1 THEN 'Inscripcion' WHEN 2 THEN 'Cancelar Inscripcion' ELSE 'No me interesa' END , dbo.fnObtenerFechaHoraPais());
END
GO
/*end*/

USE BelcorpPanama
GO

----------------------------------------------------------------------------------------------
-- INGRESO O ACUTALIZACION DE UN NUEVO REGISTRO DE SUSCRIPCION EN BASE AL CODIGO DE CONSULTORA
----------------------------------------------------------------------------------------------

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[RevistaDigitalSuscripcion_Registro]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[RevistaDigitalSuscripcion_Registro]
GO

CREATE PROCEDURE [dbo].[RevistaDigitalSuscripcion_Registro]
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
		WHERE CodigoConsultora = @CodigoConsultora and CampaniaID = @CampaniaID
		SET @RetornoID = (SELECT RevistaDigitalSuscripcionID FROM RevistaDigitalSuscripcion WHERE CodigoConsultora = @CodigoConsultora);
	END 

	INSERT INTO SuscripcionHistorial (Codigo, CodigoConsultora, Accion, Fecha)
	VALUES ('RD', @CodigoConsultora, CASE @EstadoRegistro WHEN 1 THEN 'Inscripcion' WHEN 2 THEN 'Cancelar Inscripcion' ELSE 'No me interesa' END , dbo.fnObtenerFechaHoraPais());
END
GO
/*end*/

USE BelcorpGuatemala
GO

----------------------------------------------------------------------------------------------
-- INGRESO O ACUTALIZACION DE UN NUEVO REGISTRO DE SUSCRIPCION EN BASE AL CODIGO DE CONSULTORA
----------------------------------------------------------------------------------------------

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[RevistaDigitalSuscripcion_Registro]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[RevistaDigitalSuscripcion_Registro]
GO

CREATE PROCEDURE [dbo].[RevistaDigitalSuscripcion_Registro]
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
		WHERE CodigoConsultora = @CodigoConsultora and CampaniaID = @CampaniaID
		SET @RetornoID = (SELECT RevistaDigitalSuscripcionID FROM RevistaDigitalSuscripcion WHERE CodigoConsultora = @CodigoConsultora);
	END 

	INSERT INTO SuscripcionHistorial (Codigo, CodigoConsultora, Accion, Fecha)
	VALUES ('RD', @CodigoConsultora, CASE @EstadoRegistro WHEN 1 THEN 'Inscripcion' WHEN 2 THEN 'Cancelar Inscripcion' ELSE 'No me interesa' END , dbo.fnObtenerFechaHoraPais());
END
GO
/*end*/

USE BelcorpEcuador
GO

----------------------------------------------------------------------------------------------
-- INGRESO O ACUTALIZACION DE UN NUEVO REGISTRO DE SUSCRIPCION EN BASE AL CODIGO DE CONSULTORA
----------------------------------------------------------------------------------------------

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[RevistaDigitalSuscripcion_Registro]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[RevistaDigitalSuscripcion_Registro]
GO

CREATE PROCEDURE [dbo].[RevistaDigitalSuscripcion_Registro]
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
		WHERE CodigoConsultora = @CodigoConsultora and CampaniaID = @CampaniaID
		SET @RetornoID = (SELECT RevistaDigitalSuscripcionID FROM RevistaDigitalSuscripcion WHERE CodigoConsultora = @CodigoConsultora);
	END 

	INSERT INTO SuscripcionHistorial (Codigo, CodigoConsultora, Accion, Fecha)
	VALUES ('RD', @CodigoConsultora, CASE @EstadoRegistro WHEN 1 THEN 'Inscripcion' WHEN 2 THEN 'Cancelar Inscripcion' ELSE 'No me interesa' END , dbo.fnObtenerFechaHoraPais());
END
GO
/*end*/

USE BelcorpDominicana
GO

----------------------------------------------------------------------------------------------
-- INGRESO O ACUTALIZACION DE UN NUEVO REGISTRO DE SUSCRIPCION EN BASE AL CODIGO DE CONSULTORA
----------------------------------------------------------------------------------------------

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[RevistaDigitalSuscripcion_Registro]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[RevistaDigitalSuscripcion_Registro]
GO

CREATE PROCEDURE [dbo].[RevistaDigitalSuscripcion_Registro]
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
		WHERE CodigoConsultora = @CodigoConsultora and CampaniaID = @CampaniaID
		SET @RetornoID = (SELECT RevistaDigitalSuscripcionID FROM RevistaDigitalSuscripcion WHERE CodigoConsultora = @CodigoConsultora);
	END 

	INSERT INTO SuscripcionHistorial (Codigo, CodigoConsultora, Accion, Fecha)
	VALUES ('RD', @CodigoConsultora, CASE @EstadoRegistro WHEN 1 THEN 'Inscripcion' WHEN 2 THEN 'Cancelar Inscripcion' ELSE 'No me interesa' END , dbo.fnObtenerFechaHoraPais());
END
GO
/*end*/

USE BelcorpCostaRica
GO

----------------------------------------------------------------------------------------------
-- INGRESO O ACUTALIZACION DE UN NUEVO REGISTRO DE SUSCRIPCION EN BASE AL CODIGO DE CONSULTORA
----------------------------------------------------------------------------------------------

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[RevistaDigitalSuscripcion_Registro]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[RevistaDigitalSuscripcion_Registro]
GO

CREATE PROCEDURE [dbo].[RevistaDigitalSuscripcion_Registro]
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
		WHERE CodigoConsultora = @CodigoConsultora and CampaniaID = @CampaniaID
		SET @RetornoID = (SELECT RevistaDigitalSuscripcionID FROM RevistaDigitalSuscripcion WHERE CodigoConsultora = @CodigoConsultora);
	END 

	INSERT INTO SuscripcionHistorial (Codigo, CodigoConsultora, Accion, Fecha)
	VALUES ('RD', @CodigoConsultora, CASE @EstadoRegistro WHEN 1 THEN 'Inscripcion' WHEN 2 THEN 'Cancelar Inscripcion' ELSE 'No me interesa' END , dbo.fnObtenerFechaHoraPais());
END
GO
/*end*/

USE BelcorpChile
GO

----------------------------------------------------------------------------------------------
-- INGRESO O ACUTALIZACION DE UN NUEVO REGISTRO DE SUSCRIPCION EN BASE AL CODIGO DE CONSULTORA
----------------------------------------------------------------------------------------------

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[RevistaDigitalSuscripcion_Registro]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[RevistaDigitalSuscripcion_Registro]
GO

CREATE PROCEDURE [dbo].[RevistaDigitalSuscripcion_Registro]
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
		WHERE CodigoConsultora = @CodigoConsultora and CampaniaID = @CampaniaID
		SET @RetornoID = (SELECT RevistaDigitalSuscripcionID FROM RevistaDigitalSuscripcion WHERE CodigoConsultora = @CodigoConsultora);
	END 

	INSERT INTO SuscripcionHistorial (Codigo, CodigoConsultora, Accion, Fecha)
	VALUES ('RD', @CodigoConsultora, CASE @EstadoRegistro WHEN 1 THEN 'Inscripcion' WHEN 2 THEN 'Cancelar Inscripcion' ELSE 'No me interesa' END , dbo.fnObtenerFechaHoraPais());
END
GO
/*end*/

USE BelcorpBolivia
GO

----------------------------------------------------------------------------------------------
-- INGRESO O ACUTALIZACION DE UN NUEVO REGISTRO DE SUSCRIPCION EN BASE AL CODIGO DE CONSULTORA
----------------------------------------------------------------------------------------------

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[RevistaDigitalSuscripcion_Registro]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[RevistaDigitalSuscripcion_Registro]
GO

CREATE PROCEDURE [dbo].[RevistaDigitalSuscripcion_Registro]
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
		WHERE CodigoConsultora = @CodigoConsultora and CampaniaID = @CampaniaID
		SET @RetornoID = (SELECT RevistaDigitalSuscripcionID FROM RevistaDigitalSuscripcion WHERE CodigoConsultora = @CodigoConsultora);
	END 

	INSERT INTO SuscripcionHistorial (Codigo, CodigoConsultora, Accion, Fecha)
	VALUES ('RD', @CodigoConsultora, CASE @EstadoRegistro WHEN 1 THEN 'Inscripcion' WHEN 2 THEN 'Cancelar Inscripcion' ELSE 'No me interesa' END , dbo.fnObtenerFechaHoraPais());
END
GO
