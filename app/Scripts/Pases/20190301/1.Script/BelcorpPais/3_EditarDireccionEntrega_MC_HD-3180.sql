USE BelcorpPeru
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[EditarDireccionEntrega]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[EditarDireccionEntrega]
GO

CREATE PROCEDURE EditarDireccionEntrega
@DireccionEntregaID	 int,
@CampaniaID int ,
@CampaniaAnteriorID int ,
@Ubigeo1 int ,
@Ubigeo2 int ,
@Ubigeo3 int ,
@Ubigeo1Anterior int ,
@Ubigeo2Anterior int ,
@Ubigeo3Anterior int ,
@DireccionAnterior varchar(400) ,
@Direccion varchar(400) ,
@ZonaAnterior varchar(400),
@Zona varchar(400),
@Referencia varchar(400) ,
@CodigoConsultora varchar(20),
@LatitudAnterior decimal(9,6) ,
@LongitudAnterior decimal(9,6) ,
@Latitud decimal(9,6) ,
@Longitud decimal(9,6)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	Update dbo.DireccionEntrega
	set  	CampaniaID = @CampaniaID,
			CampaniaAnteriorID =@CampaniaAnteriorID,
			Ubigeo1 = @Ubigeo1,
			Ubigeo2 =@Ubigeo2,
			Ubigeo3 = @Ubigeo3,
			Ubigeo1Anterior = @Ubigeo1Anterior,
			Ubigeo2Anterior =@Ubigeo2Anterior,
			Ubigeo3Anterior= @Ubigeo3Anterior,
			DireccionAnterior =@DireccionAnterior,
			Direccion =@Direccion,
			ZonaAnterior = @ZonaAnterior,
			Zona = @Zona,
			Referencia = @Referencia,
			CodigoConsultora =@CodigoConsultora,
			Latitud =@Latitud,
			Longitud =@Longitud,
			LatitudAnterior =@LatitudAnterior,
			LongitudAnterior =@LongitudAnterior,
			UltimafechaActualizacion = GETDATE()
    where   DireccionEntregaID =@DireccionEntregaID;

	SELECT @DireccionEntregaID DireccionEntregaID
END
GO

USE BelcorpMexico
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[EditarDireccionEntrega]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[EditarDireccionEntrega]
GO

CREATE PROCEDURE EditarDireccionEntrega
@DireccionEntregaID	 int,
@CampaniaID int ,
@CampaniaAnteriorID int ,
@Ubigeo1 int ,
@Ubigeo2 int ,
@Ubigeo3 int ,
@Ubigeo1Anterior int ,
@Ubigeo2Anterior int ,
@Ubigeo3Anterior int ,
@DireccionAnterior varchar(400) ,
@Direccion varchar(400) ,
@ZonaAnterior varchar(400),
@Zona varchar(400),
@Referencia varchar(400) ,
@CodigoConsultora varchar(20),
@LatitudAnterior decimal(9,6) ,
@LongitudAnterior decimal(9,6) ,
@Latitud decimal(9,6) ,
@Longitud decimal(9,6)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	Update dbo.DireccionEntrega
	set  	CampaniaID = @CampaniaID,
			CampaniaAnteriorID =@CampaniaAnteriorID,
			Ubigeo1 = @Ubigeo1,
			Ubigeo2 =@Ubigeo2,
			Ubigeo3 = @Ubigeo3,
			Ubigeo1Anterior = @Ubigeo1Anterior,
			Ubigeo2Anterior =@Ubigeo2Anterior,
			Ubigeo3Anterior= @Ubigeo3Anterior,
			DireccionAnterior =@DireccionAnterior,
			Direccion =@Direccion,
			ZonaAnterior = @ZonaAnterior,
			Zona = @Zona,
			Referencia = @Referencia,
			CodigoConsultora =@CodigoConsultora,
			Latitud =@Latitud,
			Longitud =@Longitud,
			LatitudAnterior =@LatitudAnterior,
			LongitudAnterior =@LongitudAnterior,
			UltimafechaActualizacion = GETDATE()
    where   DireccionEntregaID =@DireccionEntregaID;

	SELECT @DireccionEntregaID DireccionEntregaID
END
GO

USE BelcorpColombia
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[EditarDireccionEntrega]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[EditarDireccionEntrega]
GO

CREATE PROCEDURE EditarDireccionEntrega
@DireccionEntregaID	 int,
@CampaniaID int ,
@CampaniaAnteriorID int ,
@Ubigeo1 int ,
@Ubigeo2 int ,
@Ubigeo3 int ,
@Ubigeo1Anterior int ,
@Ubigeo2Anterior int ,
@Ubigeo3Anterior int ,
@DireccionAnterior varchar(400) ,
@Direccion varchar(400) ,
@ZonaAnterior varchar(400),
@Zona varchar(400),
@Referencia varchar(400) ,
@CodigoConsultora varchar(20),
@LatitudAnterior decimal(9,6) ,
@LongitudAnterior decimal(9,6) ,
@Latitud decimal(9,6) ,
@Longitud decimal(9,6)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	Update dbo.DireccionEntrega
	set  	CampaniaID = @CampaniaID,
			CampaniaAnteriorID =@CampaniaAnteriorID,
			Ubigeo1 = @Ubigeo1,
			Ubigeo2 =@Ubigeo2,
			Ubigeo3 = @Ubigeo3,
			Ubigeo1Anterior = @Ubigeo1Anterior,
			Ubigeo2Anterior =@Ubigeo2Anterior,
			Ubigeo3Anterior= @Ubigeo3Anterior,
			DireccionAnterior =@DireccionAnterior,
			Direccion =@Direccion,
			ZonaAnterior = @ZonaAnterior,
			Zona = @Zona,
			Referencia = @Referencia,
			CodigoConsultora =@CodigoConsultora,
			Latitud =@Latitud,
			Longitud =@Longitud,
			LatitudAnterior =@LatitudAnterior,
			LongitudAnterior =@LongitudAnterior,
			UltimafechaActualizacion = GETDATE()
    where   DireccionEntregaID =@DireccionEntregaID;

	SELECT @DireccionEntregaID DireccionEntregaID
END
GO

USE BelcorpSalvador
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[EditarDireccionEntrega]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[EditarDireccionEntrega]
GO

CREATE PROCEDURE EditarDireccionEntrega
@DireccionEntregaID	 int,
@CampaniaID int ,
@CampaniaAnteriorID int ,
@Ubigeo1 int ,
@Ubigeo2 int ,
@Ubigeo3 int ,
@Ubigeo1Anterior int ,
@Ubigeo2Anterior int ,
@Ubigeo3Anterior int ,
@DireccionAnterior varchar(400) ,
@Direccion varchar(400) ,
@ZonaAnterior varchar(400),
@Zona varchar(400),
@Referencia varchar(400) ,
@CodigoConsultora varchar(20),
@LatitudAnterior decimal(9,6) ,
@LongitudAnterior decimal(9,6) ,
@Latitud decimal(9,6) ,
@Longitud decimal(9,6)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	Update dbo.DireccionEntrega
	set  	CampaniaID = @CampaniaID,
			CampaniaAnteriorID =@CampaniaAnteriorID,
			Ubigeo1 = @Ubigeo1,
			Ubigeo2 =@Ubigeo2,
			Ubigeo3 = @Ubigeo3,
			Ubigeo1Anterior = @Ubigeo1Anterior,
			Ubigeo2Anterior =@Ubigeo2Anterior,
			Ubigeo3Anterior= @Ubigeo3Anterior,
			DireccionAnterior =@DireccionAnterior,
			Direccion =@Direccion,
			ZonaAnterior = @ZonaAnterior,
			Zona = @Zona,
			Referencia = @Referencia,
			CodigoConsultora =@CodigoConsultora,
			Latitud =@Latitud,
			Longitud =@Longitud,
			LatitudAnterior =@LatitudAnterior,
			LongitudAnterior =@LongitudAnterior,
			UltimafechaActualizacion = GETDATE()
    where   DireccionEntregaID =@DireccionEntregaID;

	SELECT @DireccionEntregaID DireccionEntregaID
END
GO

USE BelcorpPuertoRico
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[EditarDireccionEntrega]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[EditarDireccionEntrega]
GO

CREATE PROCEDURE EditarDireccionEntrega
@DireccionEntregaID	 int,
@CampaniaID int ,
@CampaniaAnteriorID int ,
@Ubigeo1 int ,
@Ubigeo2 int ,
@Ubigeo3 int ,
@Ubigeo1Anterior int ,
@Ubigeo2Anterior int ,
@Ubigeo3Anterior int ,
@DireccionAnterior varchar(400) ,
@Direccion varchar(400) ,
@ZonaAnterior varchar(400),
@Zona varchar(400),
@Referencia varchar(400) ,
@CodigoConsultora varchar(20),
@LatitudAnterior decimal(9,6) ,
@LongitudAnterior decimal(9,6) ,
@Latitud decimal(9,6) ,
@Longitud decimal(9,6)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	Update dbo.DireccionEntrega
	set  	CampaniaID = @CampaniaID,
			CampaniaAnteriorID =@CampaniaAnteriorID,
			Ubigeo1 = @Ubigeo1,
			Ubigeo2 =@Ubigeo2,
			Ubigeo3 = @Ubigeo3,
			Ubigeo1Anterior = @Ubigeo1Anterior,
			Ubigeo2Anterior =@Ubigeo2Anterior,
			Ubigeo3Anterior= @Ubigeo3Anterior,
			DireccionAnterior =@DireccionAnterior,
			Direccion =@Direccion,
			ZonaAnterior = @ZonaAnterior,
			Zona = @Zona,
			Referencia = @Referencia,
			CodigoConsultora =@CodigoConsultora,
			Latitud =@Latitud,
			Longitud =@Longitud,
			LatitudAnterior =@LatitudAnterior,
			LongitudAnterior =@LongitudAnterior,
			UltimafechaActualizacion = GETDATE()
    where   DireccionEntregaID =@DireccionEntregaID;

	SELECT @DireccionEntregaID DireccionEntregaID
END
GO

USE BelcorpPanama
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[EditarDireccionEntrega]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[EditarDireccionEntrega]
GO

CREATE PROCEDURE EditarDireccionEntrega
@DireccionEntregaID	 int,
@CampaniaID int ,
@CampaniaAnteriorID int ,
@Ubigeo1 int ,
@Ubigeo2 int ,
@Ubigeo3 int ,
@Ubigeo1Anterior int ,
@Ubigeo2Anterior int ,
@Ubigeo3Anterior int ,
@DireccionAnterior varchar(400) ,
@Direccion varchar(400) ,
@ZonaAnterior varchar(400),
@Zona varchar(400),
@Referencia varchar(400) ,
@CodigoConsultora varchar(20),
@LatitudAnterior decimal(9,6) ,
@LongitudAnterior decimal(9,6) ,
@Latitud decimal(9,6) ,
@Longitud decimal(9,6)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	Update dbo.DireccionEntrega
	set  	CampaniaID = @CampaniaID,
			CampaniaAnteriorID =@CampaniaAnteriorID,
			Ubigeo1 = @Ubigeo1,
			Ubigeo2 =@Ubigeo2,
			Ubigeo3 = @Ubigeo3,
			Ubigeo1Anterior = @Ubigeo1Anterior,
			Ubigeo2Anterior =@Ubigeo2Anterior,
			Ubigeo3Anterior= @Ubigeo3Anterior,
			DireccionAnterior =@DireccionAnterior,
			Direccion =@Direccion,
			ZonaAnterior = @ZonaAnterior,
			Zona = @Zona,
			Referencia = @Referencia,
			CodigoConsultora =@CodigoConsultora,
			Latitud =@Latitud,
			Longitud =@Longitud,
			LatitudAnterior =@LatitudAnterior,
			LongitudAnterior =@LongitudAnterior,
			UltimafechaActualizacion = GETDATE()
    where   DireccionEntregaID =@DireccionEntregaID;

	SELECT @DireccionEntregaID DireccionEntregaID
END
GO

USE BelcorpGuatemala
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[EditarDireccionEntrega]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[EditarDireccionEntrega]
GO

CREATE PROCEDURE EditarDireccionEntrega
@DireccionEntregaID	 int,
@CampaniaID int ,
@CampaniaAnteriorID int ,
@Ubigeo1 int ,
@Ubigeo2 int ,
@Ubigeo3 int ,
@Ubigeo1Anterior int ,
@Ubigeo2Anterior int ,
@Ubigeo3Anterior int ,
@DireccionAnterior varchar(400) ,
@Direccion varchar(400) ,
@ZonaAnterior varchar(400),
@Zona varchar(400),
@Referencia varchar(400) ,
@CodigoConsultora varchar(20),
@LatitudAnterior decimal(9,6) ,
@LongitudAnterior decimal(9,6) ,
@Latitud decimal(9,6) ,
@Longitud decimal(9,6)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	Update dbo.DireccionEntrega
	set  	CampaniaID = @CampaniaID,
			CampaniaAnteriorID =@CampaniaAnteriorID,
			Ubigeo1 = @Ubigeo1,
			Ubigeo2 =@Ubigeo2,
			Ubigeo3 = @Ubigeo3,
			Ubigeo1Anterior = @Ubigeo1Anterior,
			Ubigeo2Anterior =@Ubigeo2Anterior,
			Ubigeo3Anterior= @Ubigeo3Anterior,
			DireccionAnterior =@DireccionAnterior,
			Direccion =@Direccion,
			ZonaAnterior = @ZonaAnterior,
			Zona = @Zona,
			Referencia = @Referencia,
			CodigoConsultora =@CodigoConsultora,
			Latitud =@Latitud,
			Longitud =@Longitud,
			LatitudAnterior =@LatitudAnterior,
			LongitudAnterior =@LongitudAnterior,
			UltimafechaActualizacion = GETDATE()
    where   DireccionEntregaID =@DireccionEntregaID;

	SELECT @DireccionEntregaID DireccionEntregaID
END
GO

USE BelcorpEcuador
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[EditarDireccionEntrega]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[EditarDireccionEntrega]
GO

CREATE PROCEDURE EditarDireccionEntrega
@DireccionEntregaID	 int,
@CampaniaID int ,
@CampaniaAnteriorID int ,
@Ubigeo1 int ,
@Ubigeo2 int ,
@Ubigeo3 int ,
@Ubigeo1Anterior int ,
@Ubigeo2Anterior int ,
@Ubigeo3Anterior int ,
@DireccionAnterior varchar(400) ,
@Direccion varchar(400) ,
@ZonaAnterior varchar(400),
@Zona varchar(400),
@Referencia varchar(400) ,
@CodigoConsultora varchar(20),
@LatitudAnterior decimal(9,6) ,
@LongitudAnterior decimal(9,6) ,
@Latitud decimal(9,6) ,
@Longitud decimal(9,6)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	Update dbo.DireccionEntrega
	set  	CampaniaID = @CampaniaID,
			CampaniaAnteriorID =@CampaniaAnteriorID,
			Ubigeo1 = @Ubigeo1,
			Ubigeo2 =@Ubigeo2,
			Ubigeo3 = @Ubigeo3,
			Ubigeo1Anterior = @Ubigeo1Anterior,
			Ubigeo2Anterior =@Ubigeo2Anterior,
			Ubigeo3Anterior= @Ubigeo3Anterior,
			DireccionAnterior =@DireccionAnterior,
			Direccion =@Direccion,
			ZonaAnterior = @ZonaAnterior,
			Zona = @Zona,
			Referencia = @Referencia,
			CodigoConsultora =@CodigoConsultora,
			Latitud =@Latitud,
			Longitud =@Longitud,
			LatitudAnterior =@LatitudAnterior,
			LongitudAnterior =@LongitudAnterior,
			UltimafechaActualizacion = GETDATE()
    where   DireccionEntregaID =@DireccionEntregaID;

	SELECT @DireccionEntregaID DireccionEntregaID
END
GO

USE BelcorpDominicana
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[EditarDireccionEntrega]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[EditarDireccionEntrega]
GO

CREATE PROCEDURE EditarDireccionEntrega
@DireccionEntregaID	 int,
@CampaniaID int ,
@CampaniaAnteriorID int ,
@Ubigeo1 int ,
@Ubigeo2 int ,
@Ubigeo3 int ,
@Ubigeo1Anterior int ,
@Ubigeo2Anterior int ,
@Ubigeo3Anterior int ,
@DireccionAnterior varchar(400) ,
@Direccion varchar(400) ,
@ZonaAnterior varchar(400),
@Zona varchar(400),
@Referencia varchar(400) ,
@CodigoConsultora varchar(20),
@LatitudAnterior decimal(9,6) ,
@LongitudAnterior decimal(9,6) ,
@Latitud decimal(9,6) ,
@Longitud decimal(9,6)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	Update dbo.DireccionEntrega
	set  	CampaniaID = @CampaniaID,
			CampaniaAnteriorID =@CampaniaAnteriorID,
			Ubigeo1 = @Ubigeo1,
			Ubigeo2 =@Ubigeo2,
			Ubigeo3 = @Ubigeo3,
			Ubigeo1Anterior = @Ubigeo1Anterior,
			Ubigeo2Anterior =@Ubigeo2Anterior,
			Ubigeo3Anterior= @Ubigeo3Anterior,
			DireccionAnterior =@DireccionAnterior,
			Direccion =@Direccion,
			ZonaAnterior = @ZonaAnterior,
			Zona = @Zona,
			Referencia = @Referencia,
			CodigoConsultora =@CodigoConsultora,
			Latitud =@Latitud,
			Longitud =@Longitud,
			LatitudAnterior =@LatitudAnterior,
			LongitudAnterior =@LongitudAnterior,
			UltimafechaActualizacion = GETDATE()
    where   DireccionEntregaID =@DireccionEntregaID;

	SELECT @DireccionEntregaID DireccionEntregaID
END
GO

USE BelcorpCostaRica
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[EditarDireccionEntrega]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[EditarDireccionEntrega]
GO

CREATE PROCEDURE EditarDireccionEntrega
@DireccionEntregaID	 int,
@CampaniaID int ,
@CampaniaAnteriorID int ,
@Ubigeo1 int ,
@Ubigeo2 int ,
@Ubigeo3 int ,
@Ubigeo1Anterior int ,
@Ubigeo2Anterior int ,
@Ubigeo3Anterior int ,
@DireccionAnterior varchar(400) ,
@Direccion varchar(400) ,
@ZonaAnterior varchar(400),
@Zona varchar(400),
@Referencia varchar(400) ,
@CodigoConsultora varchar(20),
@LatitudAnterior decimal(9,6) ,
@LongitudAnterior decimal(9,6) ,
@Latitud decimal(9,6) ,
@Longitud decimal(9,6)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	Update dbo.DireccionEntrega
	set  	CampaniaID = @CampaniaID,
			CampaniaAnteriorID =@CampaniaAnteriorID,
			Ubigeo1 = @Ubigeo1,
			Ubigeo2 =@Ubigeo2,
			Ubigeo3 = @Ubigeo3,
			Ubigeo1Anterior = @Ubigeo1Anterior,
			Ubigeo2Anterior =@Ubigeo2Anterior,
			Ubigeo3Anterior= @Ubigeo3Anterior,
			DireccionAnterior =@DireccionAnterior,
			Direccion =@Direccion,
			ZonaAnterior = @ZonaAnterior,
			Zona = @Zona,
			Referencia = @Referencia,
			CodigoConsultora =@CodigoConsultora,
			Latitud =@Latitud,
			Longitud =@Longitud,
			LatitudAnterior =@LatitudAnterior,
			LongitudAnterior =@LongitudAnterior,
			UltimafechaActualizacion = GETDATE()
    where   DireccionEntregaID =@DireccionEntregaID;

	SELECT @DireccionEntregaID DireccionEntregaID
END
GO

USE BelcorpChile
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[EditarDireccionEntrega]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[EditarDireccionEntrega]
GO

CREATE PROCEDURE EditarDireccionEntrega
@DireccionEntregaID	 int,
@CampaniaID int ,
@CampaniaAnteriorID int ,
@Ubigeo1 int ,
@Ubigeo2 int ,
@Ubigeo3 int ,
@Ubigeo1Anterior int ,
@Ubigeo2Anterior int ,
@Ubigeo3Anterior int ,
@DireccionAnterior varchar(400) ,
@Direccion varchar(400) ,
@ZonaAnterior varchar(400),
@Zona varchar(400),
@Referencia varchar(400) ,
@CodigoConsultora varchar(20),
@LatitudAnterior decimal(9,6) ,
@LongitudAnterior decimal(9,6) ,
@Latitud decimal(9,6) ,
@Longitud decimal(9,6)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	Update dbo.DireccionEntrega
	set  	CampaniaID = @CampaniaID,
			CampaniaAnteriorID =@CampaniaAnteriorID,
			Ubigeo1 = @Ubigeo1,
			Ubigeo2 =@Ubigeo2,
			Ubigeo3 = @Ubigeo3,
			Ubigeo1Anterior = @Ubigeo1Anterior,
			Ubigeo2Anterior =@Ubigeo2Anterior,
			Ubigeo3Anterior= @Ubigeo3Anterior,
			DireccionAnterior =@DireccionAnterior,
			Direccion =@Direccion,
			ZonaAnterior = @ZonaAnterior,
			Zona = @Zona,
			Referencia = @Referencia,
			CodigoConsultora =@CodigoConsultora,
			Latitud =@Latitud,
			Longitud =@Longitud,
			LatitudAnterior =@LatitudAnterior,
			LongitudAnterior =@LongitudAnterior,
			UltimafechaActualizacion = GETDATE()
    where   DireccionEntregaID =@DireccionEntregaID;

	SELECT @DireccionEntregaID DireccionEntregaID
END
GO

USE BelcorpBolivia
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[EditarDireccionEntrega]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[EditarDireccionEntrega]
GO

CREATE PROCEDURE EditarDireccionEntrega
@DireccionEntregaID	 int,
@CampaniaID int ,
@CampaniaAnteriorID int ,
@Ubigeo1 int ,
@Ubigeo2 int ,
@Ubigeo3 int ,
@Ubigeo1Anterior int ,
@Ubigeo2Anterior int ,
@Ubigeo3Anterior int ,
@DireccionAnterior varchar(400) ,
@Direccion varchar(400) ,
@ZonaAnterior varchar(400),
@Zona varchar(400),
@Referencia varchar(400) ,
@CodigoConsultora varchar(20),
@LatitudAnterior decimal(9,6) ,
@LongitudAnterior decimal(9,6) ,
@Latitud decimal(9,6) ,
@Longitud decimal(9,6)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	Update dbo.DireccionEntrega
	set  	CampaniaID = @CampaniaID,
			CampaniaAnteriorID =@CampaniaAnteriorID,
			Ubigeo1 = @Ubigeo1,
			Ubigeo2 =@Ubigeo2,
			Ubigeo3 = @Ubigeo3,
			Ubigeo1Anterior = @Ubigeo1Anterior,
			Ubigeo2Anterior =@Ubigeo2Anterior,
			Ubigeo3Anterior= @Ubigeo3Anterior,
			DireccionAnterior =@DireccionAnterior,
			Direccion =@Direccion,
			ZonaAnterior = @ZonaAnterior,
			Zona = @Zona,
			Referencia = @Referencia,
			CodigoConsultora =@CodigoConsultora,
			Latitud =@Latitud,
			Longitud =@Longitud,
			LatitudAnterior =@LatitudAnterior,
			LongitudAnterior =@LongitudAnterior,
			UltimafechaActualizacion = GETDATE()
    where   DireccionEntregaID =@DireccionEntregaID;

	SELECT @DireccionEntregaID DireccionEntregaID
END
GO

