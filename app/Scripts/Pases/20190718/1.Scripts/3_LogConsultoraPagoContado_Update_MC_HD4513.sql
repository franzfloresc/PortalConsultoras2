GO
USE BelcorpPeru
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LogConsultoraPagoContado_Update]') AND type in (N'P', N'PC'))
BEGIN
	EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[LogConsultoraPagoContado_Update] AS'
END
GO
ALTER PROCEDURE LogConsultoraPagoContado_Update
@CampaniaID int,
@ConsultoraID int,
@TotalAtendido float,
@TotalDescuento float,
@TotalFlete float,
@PagoTotalSinDeuda float,
@PagoTotal float,
@TotalDeuda varchar(50)
AS
BEGIN

	DECLARE @LogConsultoraPagoContadoID INT

	SELECT @LogConsultoraPagoContadoID=LogConsultoraPagoContadoID
	FROM LogConsultoraPagoContado
	WHERE CampaniaID=@CampaniaID AND ConsultoraID=@ConsultoraID

    IF @LogConsultoraPagoContadoID IS NOT NULL
	BEGIN
		UPDATE LogConsultoraPagoContado
		SET TotalAtendido=@TotalAtendido,
		TotalDescuento=@TotalDescuento,
		TotalFlete=@TotalFlete,
		PagoTotal=@PagoTotal,
		TotalDeuda=@TotalDeuda,
	    PagoTotalSinDeuda=@PagoTotalSinDeuda,
		Activo=1,
		FechaActualizacion=GETDATE()
		WHERE LogConsultoraPagoContadoID=@LogConsultoraPagoContadoID
	END
	ELSE
	BEGIN
		INSERT INTO LogConsultoraPagoContado
		(CampaniaID,
		 ConsultoraID,
		 TotalAtendido,
		 TotalDescuento,
		 TotalFlete,
		 PagoTotal,
		 TotalDeuda,
		 PagoTotalSinDeuda,
		 Activo)
		 VALUES
		 (@CampaniaID,
		  @ConsultoraID,
		  @TotalAtendido,
		  @TotalDescuento,
		  @TotalFlete,
		  @PagoTotal,
		  @TotalDeuda,
		  @PagoTotalSinDeuda,
		  1)
	END
END

GO
USE BelcorpMexico
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LogConsultoraPagoContado_Update]') AND type in (N'P', N'PC'))
BEGIN
	EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[LogConsultoraPagoContado_Update] AS'
END
GO
ALTER PROCEDURE LogConsultoraPagoContado_Update
@CampaniaID int,
@ConsultoraID int,
@TotalAtendido float,
@TotalDescuento float,
@TotalFlete float,
@PagoTotalSinDeuda float,
@PagoTotal float,
@TotalDeuda varchar(50)
AS
BEGIN

	DECLARE @LogConsultoraPagoContadoID INT

	SELECT @LogConsultoraPagoContadoID=LogConsultoraPagoContadoID
	FROM LogConsultoraPagoContado
	WHERE CampaniaID=@CampaniaID AND ConsultoraID=@ConsultoraID

    IF @LogConsultoraPagoContadoID IS NOT NULL
	BEGIN
		UPDATE LogConsultoraPagoContado
		SET TotalAtendido=@TotalAtendido,
		TotalDescuento=@TotalDescuento,
		TotalFlete=@TotalFlete,
		PagoTotal=@PagoTotal,
		TotalDeuda=@TotalDeuda,
	    PagoTotalSinDeuda=@PagoTotalSinDeuda,
		Activo=1,
		FechaActualizacion=GETDATE()
		WHERE LogConsultoraPagoContadoID=@LogConsultoraPagoContadoID
	END
	ELSE
	BEGIN
		INSERT INTO LogConsultoraPagoContado
		(CampaniaID,
		 ConsultoraID,
		 TotalAtendido,
		 TotalDescuento,
		 TotalFlete,
		 PagoTotal,
		 TotalDeuda,
		 PagoTotalSinDeuda,
		 Activo)
		 VALUES
		 (@CampaniaID,
		  @ConsultoraID,
		  @TotalAtendido,
		  @TotalDescuento,
		  @TotalFlete,
		  @PagoTotal,
		  @TotalDeuda,
		  @PagoTotalSinDeuda,
		  1)
	END
END

GO
USE BelcorpColombia
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LogConsultoraPagoContado_Update]') AND type in (N'P', N'PC'))
BEGIN
	EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[LogConsultoraPagoContado_Update] AS'
END
GO
ALTER PROCEDURE LogConsultoraPagoContado_Update
@CampaniaID int,
@ConsultoraID int,
@TotalAtendido float,
@TotalDescuento float,
@TotalFlete float,
@PagoTotalSinDeuda float,
@PagoTotal float,
@TotalDeuda varchar(50)
AS
BEGIN

	DECLARE @LogConsultoraPagoContadoID INT

	SELECT @LogConsultoraPagoContadoID=LogConsultoraPagoContadoID
	FROM LogConsultoraPagoContado
	WHERE CampaniaID=@CampaniaID AND ConsultoraID=@ConsultoraID

    IF @LogConsultoraPagoContadoID IS NOT NULL
	BEGIN
		UPDATE LogConsultoraPagoContado
		SET TotalAtendido=@TotalAtendido,
		TotalDescuento=@TotalDescuento,
		TotalFlete=@TotalFlete,
		PagoTotal=@PagoTotal,
		TotalDeuda=@TotalDeuda,
	    PagoTotalSinDeuda=@PagoTotalSinDeuda,
		Activo=1,
		FechaActualizacion=GETDATE()
		WHERE LogConsultoraPagoContadoID=@LogConsultoraPagoContadoID
	END
	ELSE
	BEGIN
		INSERT INTO LogConsultoraPagoContado
		(CampaniaID,
		 ConsultoraID,
		 TotalAtendido,
		 TotalDescuento,
		 TotalFlete,
		 PagoTotal,
		 TotalDeuda,
		 PagoTotalSinDeuda,
		 Activo)
		 VALUES
		 (@CampaniaID,
		  @ConsultoraID,
		  @TotalAtendido,
		  @TotalDescuento,
		  @TotalFlete,
		  @PagoTotal,
		  @TotalDeuda,
		  @PagoTotalSinDeuda,
		  1)
	END
END

GO
USE BelcorpSalvador
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LogConsultoraPagoContado_Update]') AND type in (N'P', N'PC'))
BEGIN
	EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[LogConsultoraPagoContado_Update] AS'
END
GO
ALTER PROCEDURE LogConsultoraPagoContado_Update
@CampaniaID int,
@ConsultoraID int,
@TotalAtendido float,
@TotalDescuento float,
@TotalFlete float,
@PagoTotalSinDeuda float,
@PagoTotal float,
@TotalDeuda varchar(50)
AS
BEGIN

	DECLARE @LogConsultoraPagoContadoID INT

	SELECT @LogConsultoraPagoContadoID=LogConsultoraPagoContadoID
	FROM LogConsultoraPagoContado
	WHERE CampaniaID=@CampaniaID AND ConsultoraID=@ConsultoraID

    IF @LogConsultoraPagoContadoID IS NOT NULL
	BEGIN
		UPDATE LogConsultoraPagoContado
		SET TotalAtendido=@TotalAtendido,
		TotalDescuento=@TotalDescuento,
		TotalFlete=@TotalFlete,
		PagoTotal=@PagoTotal,
		TotalDeuda=@TotalDeuda,
	    PagoTotalSinDeuda=@PagoTotalSinDeuda,
		Activo=1,
		FechaActualizacion=GETDATE()
		WHERE LogConsultoraPagoContadoID=@LogConsultoraPagoContadoID
	END
	ELSE
	BEGIN
		INSERT INTO LogConsultoraPagoContado
		(CampaniaID,
		 ConsultoraID,
		 TotalAtendido,
		 TotalDescuento,
		 TotalFlete,
		 PagoTotal,
		 TotalDeuda,
		 PagoTotalSinDeuda,
		 Activo)
		 VALUES
		 (@CampaniaID,
		  @ConsultoraID,
		  @TotalAtendido,
		  @TotalDescuento,
		  @TotalFlete,
		  @PagoTotal,
		  @TotalDeuda,
		  @PagoTotalSinDeuda,
		  1)
	END
END

GO
USE BelcorpPuertoRico
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LogConsultoraPagoContado_Update]') AND type in (N'P', N'PC'))
BEGIN
	EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[LogConsultoraPagoContado_Update] AS'
END
GO
ALTER PROCEDURE LogConsultoraPagoContado_Update
@CampaniaID int,
@ConsultoraID int,
@TotalAtendido float,
@TotalDescuento float,
@TotalFlete float,
@PagoTotalSinDeuda float,
@PagoTotal float,
@TotalDeuda varchar(50)
AS
BEGIN

	DECLARE @LogConsultoraPagoContadoID INT

	SELECT @LogConsultoraPagoContadoID=LogConsultoraPagoContadoID
	FROM LogConsultoraPagoContado
	WHERE CampaniaID=@CampaniaID AND ConsultoraID=@ConsultoraID

    IF @LogConsultoraPagoContadoID IS NOT NULL
	BEGIN
		UPDATE LogConsultoraPagoContado
		SET TotalAtendido=@TotalAtendido,
		TotalDescuento=@TotalDescuento,
		TotalFlete=@TotalFlete,
		PagoTotal=@PagoTotal,
		TotalDeuda=@TotalDeuda,
	    PagoTotalSinDeuda=@PagoTotalSinDeuda,
		Activo=1,
		FechaActualizacion=GETDATE()
		WHERE LogConsultoraPagoContadoID=@LogConsultoraPagoContadoID
	END
	ELSE
	BEGIN
		INSERT INTO LogConsultoraPagoContado
		(CampaniaID,
		 ConsultoraID,
		 TotalAtendido,
		 TotalDescuento,
		 TotalFlete,
		 PagoTotal,
		 TotalDeuda,
		 PagoTotalSinDeuda,
		 Activo)
		 VALUES
		 (@CampaniaID,
		  @ConsultoraID,
		  @TotalAtendido,
		  @TotalDescuento,
		  @TotalFlete,
		  @PagoTotal,
		  @TotalDeuda,
		  @PagoTotalSinDeuda,
		  1)
	END
END

GO
USE BelcorpPanama
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LogConsultoraPagoContado_Update]') AND type in (N'P', N'PC'))
BEGIN
	EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[LogConsultoraPagoContado_Update] AS'
END
GO
ALTER PROCEDURE LogConsultoraPagoContado_Update
@CampaniaID int,
@ConsultoraID int,
@TotalAtendido float,
@TotalDescuento float,
@TotalFlete float,
@PagoTotalSinDeuda float,
@PagoTotal float,
@TotalDeuda varchar(50)
AS
BEGIN

	DECLARE @LogConsultoraPagoContadoID INT

	SELECT @LogConsultoraPagoContadoID=LogConsultoraPagoContadoID
	FROM LogConsultoraPagoContado
	WHERE CampaniaID=@CampaniaID AND ConsultoraID=@ConsultoraID

    IF @LogConsultoraPagoContadoID IS NOT NULL
	BEGIN
		UPDATE LogConsultoraPagoContado
		SET TotalAtendido=@TotalAtendido,
		TotalDescuento=@TotalDescuento,
		TotalFlete=@TotalFlete,
		PagoTotal=@PagoTotal,
		TotalDeuda=@TotalDeuda,
	    PagoTotalSinDeuda=@PagoTotalSinDeuda,
		Activo=1,
		FechaActualizacion=GETDATE()
		WHERE LogConsultoraPagoContadoID=@LogConsultoraPagoContadoID
	END
	ELSE
	BEGIN
		INSERT INTO LogConsultoraPagoContado
		(CampaniaID,
		 ConsultoraID,
		 TotalAtendido,
		 TotalDescuento,
		 TotalFlete,
		 PagoTotal,
		 TotalDeuda,
		 PagoTotalSinDeuda,
		 Activo)
		 VALUES
		 (@CampaniaID,
		  @ConsultoraID,
		  @TotalAtendido,
		  @TotalDescuento,
		  @TotalFlete,
		  @PagoTotal,
		  @TotalDeuda,
		  @PagoTotalSinDeuda,
		  1)
	END
END

GO
USE BelcorpGuatemala
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LogConsultoraPagoContado_Update]') AND type in (N'P', N'PC'))
BEGIN
	EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[LogConsultoraPagoContado_Update] AS'
END
GO
ALTER PROCEDURE LogConsultoraPagoContado_Update
@CampaniaID int,
@ConsultoraID int,
@TotalAtendido float,
@TotalDescuento float,
@TotalFlete float,
@PagoTotalSinDeuda float,
@PagoTotal float,
@TotalDeuda varchar(50)
AS
BEGIN

	DECLARE @LogConsultoraPagoContadoID INT

	SELECT @LogConsultoraPagoContadoID=LogConsultoraPagoContadoID
	FROM LogConsultoraPagoContado
	WHERE CampaniaID=@CampaniaID AND ConsultoraID=@ConsultoraID

    IF @LogConsultoraPagoContadoID IS NOT NULL
	BEGIN
		UPDATE LogConsultoraPagoContado
		SET TotalAtendido=@TotalAtendido,
		TotalDescuento=@TotalDescuento,
		TotalFlete=@TotalFlete,
		PagoTotal=@PagoTotal,
		TotalDeuda=@TotalDeuda,
	    PagoTotalSinDeuda=@PagoTotalSinDeuda,
		Activo=1,
		FechaActualizacion=GETDATE()
		WHERE LogConsultoraPagoContadoID=@LogConsultoraPagoContadoID
	END
	ELSE
	BEGIN
		INSERT INTO LogConsultoraPagoContado
		(CampaniaID,
		 ConsultoraID,
		 TotalAtendido,
		 TotalDescuento,
		 TotalFlete,
		 PagoTotal,
		 TotalDeuda,
		 PagoTotalSinDeuda,
		 Activo)
		 VALUES
		 (@CampaniaID,
		  @ConsultoraID,
		  @TotalAtendido,
		  @TotalDescuento,
		  @TotalFlete,
		  @PagoTotal,
		  @TotalDeuda,
		  @PagoTotalSinDeuda,
		  1)
	END
END

GO
USE BelcorpEcuador
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LogConsultoraPagoContado_Update]') AND type in (N'P', N'PC'))
BEGIN
	EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[LogConsultoraPagoContado_Update] AS'
END
GO
ALTER PROCEDURE LogConsultoraPagoContado_Update
@CampaniaID int,
@ConsultoraID int,
@TotalAtendido float,
@TotalDescuento float,
@TotalFlete float,
@PagoTotalSinDeuda float,
@PagoTotal float,
@TotalDeuda varchar(50)
AS
BEGIN

	DECLARE @LogConsultoraPagoContadoID INT

	SELECT @LogConsultoraPagoContadoID=LogConsultoraPagoContadoID
	FROM LogConsultoraPagoContado
	WHERE CampaniaID=@CampaniaID AND ConsultoraID=@ConsultoraID

    IF @LogConsultoraPagoContadoID IS NOT NULL
	BEGIN
		UPDATE LogConsultoraPagoContado
		SET TotalAtendido=@TotalAtendido,
		TotalDescuento=@TotalDescuento,
		TotalFlete=@TotalFlete,
		PagoTotal=@PagoTotal,
		TotalDeuda=@TotalDeuda,
	    PagoTotalSinDeuda=@PagoTotalSinDeuda,
		Activo=1,
		FechaActualizacion=GETDATE()
		WHERE LogConsultoraPagoContadoID=@LogConsultoraPagoContadoID
	END
	ELSE
	BEGIN
		INSERT INTO LogConsultoraPagoContado
		(CampaniaID,
		 ConsultoraID,
		 TotalAtendido,
		 TotalDescuento,
		 TotalFlete,
		 PagoTotal,
		 TotalDeuda,
		 PagoTotalSinDeuda,
		 Activo)
		 VALUES
		 (@CampaniaID,
		  @ConsultoraID,
		  @TotalAtendido,
		  @TotalDescuento,
		  @TotalFlete,
		  @PagoTotal,
		  @TotalDeuda,
		  @PagoTotalSinDeuda,
		  1)
	END
END

GO
USE BelcorpDominicana
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LogConsultoraPagoContado_Update]') AND type in (N'P', N'PC'))
BEGIN
	EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[LogConsultoraPagoContado_Update] AS'
END
GO
ALTER PROCEDURE LogConsultoraPagoContado_Update
@CampaniaID int,
@ConsultoraID int,
@TotalAtendido float,
@TotalDescuento float,
@TotalFlete float,
@PagoTotalSinDeuda float,
@PagoTotal float,
@TotalDeuda varchar(50)
AS
BEGIN

	DECLARE @LogConsultoraPagoContadoID INT

	SELECT @LogConsultoraPagoContadoID=LogConsultoraPagoContadoID
	FROM LogConsultoraPagoContado
	WHERE CampaniaID=@CampaniaID AND ConsultoraID=@ConsultoraID

    IF @LogConsultoraPagoContadoID IS NOT NULL
	BEGIN
		UPDATE LogConsultoraPagoContado
		SET TotalAtendido=@TotalAtendido,
		TotalDescuento=@TotalDescuento,
		TotalFlete=@TotalFlete,
		PagoTotal=@PagoTotal,
		TotalDeuda=@TotalDeuda,
	    PagoTotalSinDeuda=@PagoTotalSinDeuda,
		Activo=1,
		FechaActualizacion=GETDATE()
		WHERE LogConsultoraPagoContadoID=@LogConsultoraPagoContadoID
	END
	ELSE
	BEGIN
		INSERT INTO LogConsultoraPagoContado
		(CampaniaID,
		 ConsultoraID,
		 TotalAtendido,
		 TotalDescuento,
		 TotalFlete,
		 PagoTotal,
		 TotalDeuda,
		 PagoTotalSinDeuda,
		 Activo)
		 VALUES
		 (@CampaniaID,
		  @ConsultoraID,
		  @TotalAtendido,
		  @TotalDescuento,
		  @TotalFlete,
		  @PagoTotal,
		  @TotalDeuda,
		  @PagoTotalSinDeuda,
		  1)
	END
END

GO
USE BelcorpCostaRica
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LogConsultoraPagoContado_Update]') AND type in (N'P', N'PC'))
BEGIN
	EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[LogConsultoraPagoContado_Update] AS'
END
GO
ALTER PROCEDURE LogConsultoraPagoContado_Update
@CampaniaID int,
@ConsultoraID int,
@TotalAtendido float,
@TotalDescuento float,
@TotalFlete float,
@PagoTotalSinDeuda float,
@PagoTotal float,
@TotalDeuda varchar(50)
AS
BEGIN

	DECLARE @LogConsultoraPagoContadoID INT

	SELECT @LogConsultoraPagoContadoID=LogConsultoraPagoContadoID
	FROM LogConsultoraPagoContado
	WHERE CampaniaID=@CampaniaID AND ConsultoraID=@ConsultoraID

    IF @LogConsultoraPagoContadoID IS NOT NULL
	BEGIN
		UPDATE LogConsultoraPagoContado
		SET TotalAtendido=@TotalAtendido,
		TotalDescuento=@TotalDescuento,
		TotalFlete=@TotalFlete,
		PagoTotal=@PagoTotal,
		TotalDeuda=@TotalDeuda,
	    PagoTotalSinDeuda=@PagoTotalSinDeuda,
		Activo=1,
		FechaActualizacion=GETDATE()
		WHERE LogConsultoraPagoContadoID=@LogConsultoraPagoContadoID
	END
	ELSE
	BEGIN
		INSERT INTO LogConsultoraPagoContado
		(CampaniaID,
		 ConsultoraID,
		 TotalAtendido,
		 TotalDescuento,
		 TotalFlete,
		 PagoTotal,
		 TotalDeuda,
		 PagoTotalSinDeuda,
		 Activo)
		 VALUES
		 (@CampaniaID,
		  @ConsultoraID,
		  @TotalAtendido,
		  @TotalDescuento,
		  @TotalFlete,
		  @PagoTotal,
		  @TotalDeuda,
		  @PagoTotalSinDeuda,
		  1)
	END
END

GO
USE BelcorpChile
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LogConsultoraPagoContado_Update]') AND type in (N'P', N'PC'))
BEGIN
	EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[LogConsultoraPagoContado_Update] AS'
END
GO
ALTER PROCEDURE LogConsultoraPagoContado_Update
@CampaniaID int,
@ConsultoraID int,
@TotalAtendido float,
@TotalDescuento float,
@TotalFlete float,
@PagoTotalSinDeuda float,
@PagoTotal float,
@TotalDeuda varchar(50)
AS
BEGIN

	DECLARE @LogConsultoraPagoContadoID INT

	SELECT @LogConsultoraPagoContadoID=LogConsultoraPagoContadoID
	FROM LogConsultoraPagoContado
	WHERE CampaniaID=@CampaniaID AND ConsultoraID=@ConsultoraID

    IF @LogConsultoraPagoContadoID IS NOT NULL
	BEGIN
		UPDATE LogConsultoraPagoContado
		SET TotalAtendido=@TotalAtendido,
		TotalDescuento=@TotalDescuento,
		TotalFlete=@TotalFlete,
		PagoTotal=@PagoTotal,
		TotalDeuda=@TotalDeuda,
	    PagoTotalSinDeuda=@PagoTotalSinDeuda,
		Activo=1,
		FechaActualizacion=GETDATE()
		WHERE LogConsultoraPagoContadoID=@LogConsultoraPagoContadoID
	END
	ELSE
	BEGIN
		INSERT INTO LogConsultoraPagoContado
		(CampaniaID,
		 ConsultoraID,
		 TotalAtendido,
		 TotalDescuento,
		 TotalFlete,
		 PagoTotal,
		 TotalDeuda,
		 PagoTotalSinDeuda,
		 Activo)
		 VALUES
		 (@CampaniaID,
		  @ConsultoraID,
		  @TotalAtendido,
		  @TotalDescuento,
		  @TotalFlete,
		  @PagoTotal,
		  @TotalDeuda,
		  @PagoTotalSinDeuda,
		  1)
	END
END

GO
USE BelcorpBolivia
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LogConsultoraPagoContado_Update]') AND type in (N'P', N'PC'))
BEGIN
	EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[LogConsultoraPagoContado_Update] AS'
END
GO
ALTER PROCEDURE LogConsultoraPagoContado_Update
@CampaniaID int,
@ConsultoraID int,
@TotalAtendido float,
@TotalDescuento float,
@TotalFlete float,
@PagoTotalSinDeuda float,
@PagoTotal float,
@TotalDeuda varchar(50)
AS
BEGIN

	DECLARE @LogConsultoraPagoContadoID INT

	SELECT @LogConsultoraPagoContadoID=LogConsultoraPagoContadoID
	FROM LogConsultoraPagoContado
	WHERE CampaniaID=@CampaniaID AND ConsultoraID=@ConsultoraID

    IF @LogConsultoraPagoContadoID IS NOT NULL
	BEGIN
		UPDATE LogConsultoraPagoContado
		SET TotalAtendido=@TotalAtendido,
		TotalDescuento=@TotalDescuento,
		TotalFlete=@TotalFlete,
		PagoTotal=@PagoTotal,
		TotalDeuda=@TotalDeuda,
	    PagoTotalSinDeuda=@PagoTotalSinDeuda,
		Activo=1,
		FechaActualizacion=GETDATE()
		WHERE LogConsultoraPagoContadoID=@LogConsultoraPagoContadoID
	END
	ELSE
	BEGIN
		INSERT INTO LogConsultoraPagoContado
		(CampaniaID,
		 ConsultoraID,
		 TotalAtendido,
		 TotalDescuento,
		 TotalFlete,
		 PagoTotal,
		 TotalDeuda,
		 PagoTotalSinDeuda,
		 Activo)
		 VALUES
		 (@CampaniaID,
		  @ConsultoraID,
		  @TotalAtendido,
		  @TotalDescuento,
		  @TotalFlete,
		  @PagoTotal,
		  @TotalDeuda,
		  @PagoTotalSinDeuda,
		  1)
	END
END

GO
