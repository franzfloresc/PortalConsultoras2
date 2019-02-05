USE BelcorpPeru
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = OBJECT_ID(N'[dbo].[InsertarDireccionEntrega]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[InsertarDireccionEntrega]
GO

create PROCEDURE InsertarDireccionEntrega	 
@ConsultoraID int ,
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

    -- Insert statements for procedure here
	declare @Id int =0;
	Insert DireccionEntrega
	(
		ConsultoraID,
		CampaniaID,
		CampaniaAnteriorID,
		Ubigeo1,
		Ubigeo2,
		Ubigeo3,
		Ubigeo1Anterior,
		Ubigeo2Anterior,
		Ubigeo3Anterior,
		DireccionAnterior,
		Direccion,
		Referencia,
		CodigoConsultora,
		Latitud,
		Longitud,
		LatitudAnterior,
		LongitudAnterior
	)
	values(@ConsultoraID,@CampaniaID,@CampaniaAnteriorID,@Ubigeo1,@Ubigeo2,@Ubigeo3,@Ubigeo1Anterior,@Ubigeo2Anterior,@Ubigeo3Anterior,@DireccionAnterior,@Direccion,@Referencia,@CodigoConsultora,@Latitud,@Longitud,@LatitudAnterior,@LongitudAnterior)
	set @Id =@@IDENTITY;

	select @Id DireccionEntregaID;
END
GO

USE BelcorpMexico
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = OBJECT_ID(N'[dbo].[InsertarDireccionEntrega]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[InsertarDireccionEntrega]
GO

create PROCEDURE InsertarDireccionEntrega	 
@ConsultoraID int ,
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

    -- Insert statements for procedure here
	declare @Id int =0;
	Insert DireccionEntrega
	(
		ConsultoraID,
		CampaniaID,
		CampaniaAnteriorID,
		Ubigeo1,
		Ubigeo2,
		Ubigeo3,
		Ubigeo1Anterior,
		Ubigeo2Anterior,
		Ubigeo3Anterior,
		DireccionAnterior,
		Direccion,
		Referencia,
		CodigoConsultora,
		Latitud,
		Longitud,
		LatitudAnterior,
		LongitudAnterior
	)
	values(@ConsultoraID,@CampaniaID,@CampaniaAnteriorID,@Ubigeo1,@Ubigeo2,@Ubigeo3,@Ubigeo1Anterior,@Ubigeo2Anterior,@Ubigeo3Anterior,@DireccionAnterior,@Direccion,@Referencia,@CodigoConsultora,@Latitud,@Longitud,@LatitudAnterior,@LongitudAnterior)
	set @Id =@@IDENTITY;

	select @Id DireccionEntregaID;
END
GO

USE BelcorpColombia
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = OBJECT_ID(N'[dbo].[InsertarDireccionEntrega]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[InsertarDireccionEntrega]
GO

create PROCEDURE InsertarDireccionEntrega	 
@ConsultoraID int ,
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

    -- Insert statements for procedure here
	declare @Id int =0;
	Insert DireccionEntrega
	(
		ConsultoraID,
		CampaniaID,
		CampaniaAnteriorID,
		Ubigeo1,
		Ubigeo2,
		Ubigeo3,
		Ubigeo1Anterior,
		Ubigeo2Anterior,
		Ubigeo3Anterior,
		DireccionAnterior,
		Direccion,
		Referencia,
		CodigoConsultora,
		Latitud,
		Longitud,
		LatitudAnterior,
		LongitudAnterior
	)
	values(@ConsultoraID,@CampaniaID,@CampaniaAnteriorID,@Ubigeo1,@Ubigeo2,@Ubigeo3,@Ubigeo1Anterior,@Ubigeo2Anterior,@Ubigeo3Anterior,@DireccionAnterior,@Direccion,@Referencia,@CodigoConsultora,@Latitud,@Longitud,@LatitudAnterior,@LongitudAnterior)
	set @Id =@@IDENTITY;

	select @Id DireccionEntregaID;
END
GO

USE BelcorpSalvador
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = OBJECT_ID(N'[dbo].[InsertarDireccionEntrega]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[InsertarDireccionEntrega]
GO

create PROCEDURE InsertarDireccionEntrega	 
@ConsultoraID int ,
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

    -- Insert statements for procedure here
	declare @Id int =0;
	Insert DireccionEntrega
	(
		ConsultoraID,
		CampaniaID,
		CampaniaAnteriorID,
		Ubigeo1,
		Ubigeo2,
		Ubigeo3,
		Ubigeo1Anterior,
		Ubigeo2Anterior,
		Ubigeo3Anterior,
		DireccionAnterior,
		Direccion,
		Referencia,
		CodigoConsultora,
		Latitud,
		Longitud,
		LatitudAnterior,
		LongitudAnterior
	)
	values(@ConsultoraID,@CampaniaID,@CampaniaAnteriorID,@Ubigeo1,@Ubigeo2,@Ubigeo3,@Ubigeo1Anterior,@Ubigeo2Anterior,@Ubigeo3Anterior,@DireccionAnterior,@Direccion,@Referencia,@CodigoConsultora,@Latitud,@Longitud,@LatitudAnterior,@LongitudAnterior)
	set @Id =@@IDENTITY;

	select @Id DireccionEntregaID;
END
GO

USE BelcorpPuertoRico
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = OBJECT_ID(N'[dbo].[InsertarDireccionEntrega]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[InsertarDireccionEntrega]
GO

create PROCEDURE InsertarDireccionEntrega	 
@ConsultoraID int ,
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

    -- Insert statements for procedure here
	declare @Id int =0;
	Insert DireccionEntrega
	(
		ConsultoraID,
		CampaniaID,
		CampaniaAnteriorID,
		Ubigeo1,
		Ubigeo2,
		Ubigeo3,
		Ubigeo1Anterior,
		Ubigeo2Anterior,
		Ubigeo3Anterior,
		DireccionAnterior,
		Direccion,
		Referencia,
		CodigoConsultora,
		Latitud,
		Longitud,
		LatitudAnterior,
		LongitudAnterior
	)
	values(@ConsultoraID,@CampaniaID,@CampaniaAnteriorID,@Ubigeo1,@Ubigeo2,@Ubigeo3,@Ubigeo1Anterior,@Ubigeo2Anterior,@Ubigeo3Anterior,@DireccionAnterior,@Direccion,@Referencia,@CodigoConsultora,@Latitud,@Longitud,@LatitudAnterior,@LongitudAnterior)
	set @Id =@@IDENTITY;

	select @Id DireccionEntregaID;
END
GO

USE BelcorpPanama
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = OBJECT_ID(N'[dbo].[InsertarDireccionEntrega]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[InsertarDireccionEntrega]
GO

create PROCEDURE InsertarDireccionEntrega	 
@ConsultoraID int ,
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

    -- Insert statements for procedure here
	declare @Id int =0;
	Insert DireccionEntrega
	(
		ConsultoraID,
		CampaniaID,
		CampaniaAnteriorID,
		Ubigeo1,
		Ubigeo2,
		Ubigeo3,
		Ubigeo1Anterior,
		Ubigeo2Anterior,
		Ubigeo3Anterior,
		DireccionAnterior,
		Direccion,
		Referencia,
		CodigoConsultora,
		Latitud,
		Longitud,
		LatitudAnterior,
		LongitudAnterior
	)
	values(@ConsultoraID,@CampaniaID,@CampaniaAnteriorID,@Ubigeo1,@Ubigeo2,@Ubigeo3,@Ubigeo1Anterior,@Ubigeo2Anterior,@Ubigeo3Anterior,@DireccionAnterior,@Direccion,@Referencia,@CodigoConsultora,@Latitud,@Longitud,@LatitudAnterior,@LongitudAnterior)
	set @Id =@@IDENTITY;

	select @Id DireccionEntregaID;
END
GO

USE BelcorpGuatemala
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = OBJECT_ID(N'[dbo].[InsertarDireccionEntrega]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[InsertarDireccionEntrega]
GO

create PROCEDURE InsertarDireccionEntrega	 
@ConsultoraID int ,
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

    -- Insert statements for procedure here
	declare @Id int =0;
	Insert DireccionEntrega
	(
		ConsultoraID,
		CampaniaID,
		CampaniaAnteriorID,
		Ubigeo1,
		Ubigeo2,
		Ubigeo3,
		Ubigeo1Anterior,
		Ubigeo2Anterior,
		Ubigeo3Anterior,
		DireccionAnterior,
		Direccion,
		Referencia,
		CodigoConsultora,
		Latitud,
		Longitud,
		LatitudAnterior,
		LongitudAnterior
	)
	values(@ConsultoraID,@CampaniaID,@CampaniaAnteriorID,@Ubigeo1,@Ubigeo2,@Ubigeo3,@Ubigeo1Anterior,@Ubigeo2Anterior,@Ubigeo3Anterior,@DireccionAnterior,@Direccion,@Referencia,@CodigoConsultora,@Latitud,@Longitud,@LatitudAnterior,@LongitudAnterior)
	set @Id =@@IDENTITY;

	select @Id DireccionEntregaID;
END
GO

USE BelcorpEcuador
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = OBJECT_ID(N'[dbo].[InsertarDireccionEntrega]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[InsertarDireccionEntrega]
GO

create PROCEDURE InsertarDireccionEntrega	 
@ConsultoraID int ,
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

    -- Insert statements for procedure here
	declare @Id int =0;
	Insert DireccionEntrega
	(
		ConsultoraID,
		CampaniaID,
		CampaniaAnteriorID,
		Ubigeo1,
		Ubigeo2,
		Ubigeo3,
		Ubigeo1Anterior,
		Ubigeo2Anterior,
		Ubigeo3Anterior,
		DireccionAnterior,
		Direccion,
		Referencia,
		CodigoConsultora,
		Latitud,
		Longitud,
		LatitudAnterior,
		LongitudAnterior
	)
	values(@ConsultoraID,@CampaniaID,@CampaniaAnteriorID,@Ubigeo1,@Ubigeo2,@Ubigeo3,@Ubigeo1Anterior,@Ubigeo2Anterior,@Ubigeo3Anterior,@DireccionAnterior,@Direccion,@Referencia,@CodigoConsultora,@Latitud,@Longitud,@LatitudAnterior,@LongitudAnterior)
	set @Id =@@IDENTITY;

	select @Id DireccionEntregaID;
END
GO

USE BelcorpDominicana
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = OBJECT_ID(N'[dbo].[InsertarDireccionEntrega]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[InsertarDireccionEntrega]
GO

create PROCEDURE InsertarDireccionEntrega	 
@ConsultoraID int ,
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

    -- Insert statements for procedure here
	declare @Id int =0;
	Insert DireccionEntrega
	(
		ConsultoraID,
		CampaniaID,
		CampaniaAnteriorID,
		Ubigeo1,
		Ubigeo2,
		Ubigeo3,
		Ubigeo1Anterior,
		Ubigeo2Anterior,
		Ubigeo3Anterior,
		DireccionAnterior,
		Direccion,
		Referencia,
		CodigoConsultora,
		Latitud,
		Longitud,
		LatitudAnterior,
		LongitudAnterior
	)
	values(@ConsultoraID,@CampaniaID,@CampaniaAnteriorID,@Ubigeo1,@Ubigeo2,@Ubigeo3,@Ubigeo1Anterior,@Ubigeo2Anterior,@Ubigeo3Anterior,@DireccionAnterior,@Direccion,@Referencia,@CodigoConsultora,@Latitud,@Longitud,@LatitudAnterior,@LongitudAnterior)
	set @Id =@@IDENTITY;

	select @Id DireccionEntregaID;
END
GO

USE BelcorpCostaRica
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = OBJECT_ID(N'[dbo].[InsertarDireccionEntrega]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[InsertarDireccionEntrega]
GO

create PROCEDURE InsertarDireccionEntrega	 
@ConsultoraID int ,
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

    -- Insert statements for procedure here
	declare @Id int =0;
	Insert DireccionEntrega
	(
		ConsultoraID,
		CampaniaID,
		CampaniaAnteriorID,
		Ubigeo1,
		Ubigeo2,
		Ubigeo3,
		Ubigeo1Anterior,
		Ubigeo2Anterior,
		Ubigeo3Anterior,
		DireccionAnterior,
		Direccion,
		Referencia,
		CodigoConsultora,
		Latitud,
		Longitud,
		LatitudAnterior,
		LongitudAnterior
	)
	values(@ConsultoraID,@CampaniaID,@CampaniaAnteriorID,@Ubigeo1,@Ubigeo2,@Ubigeo3,@Ubigeo1Anterior,@Ubigeo2Anterior,@Ubigeo3Anterior,@DireccionAnterior,@Direccion,@Referencia,@CodigoConsultora,@Latitud,@Longitud,@LatitudAnterior,@LongitudAnterior)
	set @Id =@@IDENTITY;

	select @Id DireccionEntregaID;
END
GO

USE BelcorpChile
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = OBJECT_ID(N'[dbo].[InsertarDireccionEntrega]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[InsertarDireccionEntrega]
GO

create PROCEDURE InsertarDireccionEntrega	 
@ConsultoraID int ,
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

    -- Insert statements for procedure here
	declare @Id int =0;
	Insert DireccionEntrega
	(
		ConsultoraID,
		CampaniaID,
		CampaniaAnteriorID,
		Ubigeo1,
		Ubigeo2,
		Ubigeo3,
		Ubigeo1Anterior,
		Ubigeo2Anterior,
		Ubigeo3Anterior,
		DireccionAnterior,
		Direccion,
		Referencia,
		CodigoConsultora,
		Latitud,
		Longitud,
		LatitudAnterior,
		LongitudAnterior
	)
	values(@ConsultoraID,@CampaniaID,@CampaniaAnteriorID,@Ubigeo1,@Ubigeo2,@Ubigeo3,@Ubigeo1Anterior,@Ubigeo2Anterior,@Ubigeo3Anterior,@DireccionAnterior,@Direccion,@Referencia,@CodigoConsultora,@Latitud,@Longitud,@LatitudAnterior,@LongitudAnterior)
	set @Id =@@IDENTITY;

	select @Id DireccionEntregaID;
END
GO

USE BelcorpBolivia
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = OBJECT_ID(N'[dbo].[InsertarDireccionEntrega]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[InsertarDireccionEntrega]
GO

create PROCEDURE InsertarDireccionEntrega	 
@ConsultoraID int ,
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

    -- Insert statements for procedure here
	declare @Id int =0;
	Insert DireccionEntrega
	(
		ConsultoraID,
		CampaniaID,
		CampaniaAnteriorID,
		Ubigeo1,
		Ubigeo2,
		Ubigeo3,
		Ubigeo1Anterior,
		Ubigeo2Anterior,
		Ubigeo3Anterior,
		DireccionAnterior,
		Direccion,
		Referencia,
		CodigoConsultora,
		Latitud,
		Longitud,
		LatitudAnterior,
		LongitudAnterior
	)
	values(@ConsultoraID,@CampaniaID,@CampaniaAnteriorID,@Ubigeo1,@Ubigeo2,@Ubigeo3,@Ubigeo1Anterior,@Ubigeo2Anterior,@Ubigeo3Anterior,@DireccionAnterior,@Direccion,@Referencia,@CodigoConsultora,@Latitud,@Longitud,@LatitudAnterior,@LongitudAnterior)
	set @Id =@@IDENTITY;

	select @Id DireccionEntregaID;
END
GO

