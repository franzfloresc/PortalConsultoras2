USE BelcorpPeru
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'P' and id = OBJECT_ID('dbo.InsIncentivosMontoExigencia'))
	DROP PROC dbo.InsIncentivosMontoExigencia
GO
CREATE PROC InsIncentivosMontoExigencia
(
@MontoID int,
@CodigoCampania varchar(8),
@CodigoRegion varchar(8),
@CodigoZona varchar(8),
@Monto varchar(12),
@AlcansoIncentivo varchar(1)
)
AS
BEGIN
	IF EXISTS (SELECT 1 FROM IncentivosMontoExigencia WHERE MontoID = @MontoID)
	begin
		Update IncentivosMontoExigencia set
			CodigoCampania = @CodigoCampania,
			CodigoRegion = @CodigoRegion,
			CodigoZona = @CodigoZona,
			Monto = @Monto,
			AlcansoIncentivo = @AlcansoIncentivo,
			FechaModificacion = GETDATE()
		WHERE MontoID = @MontoID
	end
	ELSE
	BEGIN
		INSERT INTO IncentivosMontoExigencia VALUES
		(
			@CodigoCampania,
			@CodigoRegion,
			@CodigoZona,
			@Monto,
			@AlcansoIncentivo,
			GETDATE(),
			NULL
		)
	END
END
GO

USE BelcorpMexico
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'P' and id = OBJECT_ID('dbo.InsIncentivosMontoExigencia'))
	DROP PROC dbo.InsIncentivosMontoExigencia
GO
CREATE PROC InsIncentivosMontoExigencia
(
@MontoID int,
@CodigoCampania varchar(8),
@CodigoRegion varchar(8),
@CodigoZona varchar(8),
@Monto varchar(12),
@AlcansoIncentivo varchar(1)
)
AS
BEGIN
	IF EXISTS (SELECT 1 FROM IncentivosMontoExigencia WHERE MontoID = @MontoID)
	begin
		Update IncentivosMontoExigencia set
			CodigoCampania = @CodigoCampania,
			CodigoRegion = @CodigoRegion,
			CodigoZona = @CodigoZona,
			Monto = @Monto,
			AlcansoIncentivo = @AlcansoIncentivo,
			FechaModificacion = GETDATE()
		WHERE MontoID = @MontoID
	end
	ELSE
	BEGIN
		INSERT INTO IncentivosMontoExigencia VALUES
		(
			@CodigoCampania,
			@CodigoRegion,
			@CodigoZona,
			@Monto,
			@AlcansoIncentivo,
			GETDATE(),
			NULL
		)
	END
END
GO

USE BelcorpColombia
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'P' and id = OBJECT_ID('dbo.InsIncentivosMontoExigencia'))
	DROP PROC dbo.InsIncentivosMontoExigencia
GO
CREATE PROC InsIncentivosMontoExigencia
(
@MontoID int,
@CodigoCampania varchar(8),
@CodigoRegion varchar(8),
@CodigoZona varchar(8),
@Monto varchar(12),
@AlcansoIncentivo varchar(1)
)
AS
BEGIN
	IF EXISTS (SELECT 1 FROM IncentivosMontoExigencia WHERE MontoID = @MontoID)
	begin
		Update IncentivosMontoExigencia set
			CodigoCampania = @CodigoCampania,
			CodigoRegion = @CodigoRegion,
			CodigoZona = @CodigoZona,
			Monto = @Monto,
			AlcansoIncentivo = @AlcansoIncentivo,
			FechaModificacion = GETDATE()
		WHERE MontoID = @MontoID
	end
	ELSE
	BEGIN
		INSERT INTO IncentivosMontoExigencia VALUES
		(
			@CodigoCampania,
			@CodigoRegion,
			@CodigoZona,
			@Monto,
			@AlcansoIncentivo,
			GETDATE(),
			NULL
		)
	END
END
GO

USE BelcorpSalvador
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'P' and id = OBJECT_ID('dbo.InsIncentivosMontoExigencia'))
	DROP PROC dbo.InsIncentivosMontoExigencia
GO
CREATE PROC InsIncentivosMontoExigencia
(
@MontoID int,
@CodigoCampania varchar(8),
@CodigoRegion varchar(8),
@CodigoZona varchar(8),
@Monto varchar(12),
@AlcansoIncentivo varchar(1)
)
AS
BEGIN
	IF EXISTS (SELECT 1 FROM IncentivosMontoExigencia WHERE MontoID = @MontoID)
	begin
		Update IncentivosMontoExigencia set
			CodigoCampania = @CodigoCampania,
			CodigoRegion = @CodigoRegion,
			CodigoZona = @CodigoZona,
			Monto = @Monto,
			AlcansoIncentivo = @AlcansoIncentivo,
			FechaModificacion = GETDATE()
		WHERE MontoID = @MontoID
	end
	ELSE
	BEGIN
		INSERT INTO IncentivosMontoExigencia VALUES
		(
			@CodigoCampania,
			@CodigoRegion,
			@CodigoZona,
			@Monto,
			@AlcansoIncentivo,
			GETDATE(),
			NULL
		)
	END
END
GO

USE BelcorpPuertoRico
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'P' and id = OBJECT_ID('dbo.InsIncentivosMontoExigencia'))
	DROP PROC dbo.InsIncentivosMontoExigencia
GO
CREATE PROC InsIncentivosMontoExigencia
(
@MontoID int,
@CodigoCampania varchar(8),
@CodigoRegion varchar(8),
@CodigoZona varchar(8),
@Monto varchar(12),
@AlcansoIncentivo varchar(1)
)
AS
BEGIN
	IF EXISTS (SELECT 1 FROM IncentivosMontoExigencia WHERE MontoID = @MontoID)
	begin
		Update IncentivosMontoExigencia set
			CodigoCampania = @CodigoCampania,
			CodigoRegion = @CodigoRegion,
			CodigoZona = @CodigoZona,
			Monto = @Monto,
			AlcansoIncentivo = @AlcansoIncentivo,
			FechaModificacion = GETDATE()
		WHERE MontoID = @MontoID
	end
	ELSE
	BEGIN
		INSERT INTO IncentivosMontoExigencia VALUES
		(
			@CodigoCampania,
			@CodigoRegion,
			@CodigoZona,
			@Monto,
			@AlcansoIncentivo,
			GETDATE(),
			NULL
		)
	END
END
GO

USE BelcorpPanama
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'P' and id = OBJECT_ID('dbo.InsIncentivosMontoExigencia'))
	DROP PROC dbo.InsIncentivosMontoExigencia
GO
CREATE PROC InsIncentivosMontoExigencia
(
@MontoID int,
@CodigoCampania varchar(8),
@CodigoRegion varchar(8),
@CodigoZona varchar(8),
@Monto varchar(12),
@AlcansoIncentivo varchar(1)
)
AS
BEGIN
	IF EXISTS (SELECT 1 FROM IncentivosMontoExigencia WHERE MontoID = @MontoID)
	begin
		Update IncentivosMontoExigencia set
			CodigoCampania = @CodigoCampania,
			CodigoRegion = @CodigoRegion,
			CodigoZona = @CodigoZona,
			Monto = @Monto,
			AlcansoIncentivo = @AlcansoIncentivo,
			FechaModificacion = GETDATE()
		WHERE MontoID = @MontoID
	end
	ELSE
	BEGIN
		INSERT INTO IncentivosMontoExigencia VALUES
		(
			@CodigoCampania,
			@CodigoRegion,
			@CodigoZona,
			@Monto,
			@AlcansoIncentivo,
			GETDATE(),
			NULL
		)
	END
END
GO

USE BelcorpGuatemala
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'P' and id = OBJECT_ID('dbo.InsIncentivosMontoExigencia'))
	DROP PROC dbo.InsIncentivosMontoExigencia
GO
CREATE PROC InsIncentivosMontoExigencia
(
@MontoID int,
@CodigoCampania varchar(8),
@CodigoRegion varchar(8),
@CodigoZona varchar(8),
@Monto varchar(12),
@AlcansoIncentivo varchar(1)
)
AS
BEGIN
	IF EXISTS (SELECT 1 FROM IncentivosMontoExigencia WHERE MontoID = @MontoID)
	begin
		Update IncentivosMontoExigencia set
			CodigoCampania = @CodigoCampania,
			CodigoRegion = @CodigoRegion,
			CodigoZona = @CodigoZona,
			Monto = @Monto,
			AlcansoIncentivo = @AlcansoIncentivo,
			FechaModificacion = GETDATE()
		WHERE MontoID = @MontoID
	end
	ELSE
	BEGIN
		INSERT INTO IncentivosMontoExigencia VALUES
		(
			@CodigoCampania,
			@CodigoRegion,
			@CodigoZona,
			@Monto,
			@AlcansoIncentivo,
			GETDATE(),
			NULL
		)
	END
END
GO

USE BelcorpEcuador
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'P' and id = OBJECT_ID('dbo.InsIncentivosMontoExigencia'))
	DROP PROC dbo.InsIncentivosMontoExigencia
GO
CREATE PROC InsIncentivosMontoExigencia
(
@MontoID int,
@CodigoCampania varchar(8),
@CodigoRegion varchar(8),
@CodigoZona varchar(8),
@Monto varchar(12),
@AlcansoIncentivo varchar(1)
)
AS
BEGIN
	IF EXISTS (SELECT 1 FROM IncentivosMontoExigencia WHERE MontoID = @MontoID)
	begin
		Update IncentivosMontoExigencia set
			CodigoCampania = @CodigoCampania,
			CodigoRegion = @CodigoRegion,
			CodigoZona = @CodigoZona,
			Monto = @Monto,
			AlcansoIncentivo = @AlcansoIncentivo,
			FechaModificacion = GETDATE()
		WHERE MontoID = @MontoID
	end
	ELSE
	BEGIN
		INSERT INTO IncentivosMontoExigencia VALUES
		(
			@CodigoCampania,
			@CodigoRegion,
			@CodigoZona,
			@Monto,
			@AlcansoIncentivo,
			GETDATE(),
			NULL
		)
	END
END
GO

USE BelcorpDominicana
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'P' and id = OBJECT_ID('dbo.InsIncentivosMontoExigencia'))
	DROP PROC dbo.InsIncentivosMontoExigencia
GO
CREATE PROC InsIncentivosMontoExigencia
(
@MontoID int,
@CodigoCampania varchar(8),
@CodigoRegion varchar(8),
@CodigoZona varchar(8),
@Monto varchar(12),
@AlcansoIncentivo varchar(1)
)
AS
BEGIN
	IF EXISTS (SELECT 1 FROM IncentivosMontoExigencia WHERE MontoID = @MontoID)
	begin
		Update IncentivosMontoExigencia set
			CodigoCampania = @CodigoCampania,
			CodigoRegion = @CodigoRegion,
			CodigoZona = @CodigoZona,
			Monto = @Monto,
			AlcansoIncentivo = @AlcansoIncentivo,
			FechaModificacion = GETDATE()
		WHERE MontoID = @MontoID
	end
	ELSE
	BEGIN
		INSERT INTO IncentivosMontoExigencia VALUES
		(
			@CodigoCampania,
			@CodigoRegion,
			@CodigoZona,
			@Monto,
			@AlcansoIncentivo,
			GETDATE(),
			NULL
		)
	END
END
GO

USE BelcorpCostaRica
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'P' and id = OBJECT_ID('dbo.InsIncentivosMontoExigencia'))
	DROP PROC dbo.InsIncentivosMontoExigencia
GO
CREATE PROC InsIncentivosMontoExigencia
(
@MontoID int,
@CodigoCampania varchar(8),
@CodigoRegion varchar(8),
@CodigoZona varchar(8),
@Monto varchar(12),
@AlcansoIncentivo varchar(1)
)
AS
BEGIN
	IF EXISTS (SELECT 1 FROM IncentivosMontoExigencia WHERE MontoID = @MontoID)
	begin
		Update IncentivosMontoExigencia set
			CodigoCampania = @CodigoCampania,
			CodigoRegion = @CodigoRegion,
			CodigoZona = @CodigoZona,
			Monto = @Monto,
			AlcansoIncentivo = @AlcansoIncentivo,
			FechaModificacion = GETDATE()
		WHERE MontoID = @MontoID
	end
	ELSE
	BEGIN
		INSERT INTO IncentivosMontoExigencia VALUES
		(
			@CodigoCampania,
			@CodigoRegion,
			@CodigoZona,
			@Monto,
			@AlcansoIncentivo,
			GETDATE(),
			NULL
		)
	END
END
GO

USE BelcorpChile
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'P' and id = OBJECT_ID('dbo.InsIncentivosMontoExigencia'))
	DROP PROC dbo.InsIncentivosMontoExigencia
GO
CREATE PROC InsIncentivosMontoExigencia
(
@MontoID int,
@CodigoCampania varchar(8),
@CodigoRegion varchar(8),
@CodigoZona varchar(8),
@Monto varchar(12),
@AlcansoIncentivo varchar(1)
)
AS
BEGIN
	IF EXISTS (SELECT 1 FROM IncentivosMontoExigencia WHERE MontoID = @MontoID)
	begin
		Update IncentivosMontoExigencia set
			CodigoCampania = @CodigoCampania,
			CodigoRegion = @CodigoRegion,
			CodigoZona = @CodigoZona,
			Monto = @Monto,
			AlcansoIncentivo = @AlcansoIncentivo,
			FechaModificacion = GETDATE()
		WHERE MontoID = @MontoID
	end
	ELSE
	BEGIN
		INSERT INTO IncentivosMontoExigencia VALUES
		(
			@CodigoCampania,
			@CodigoRegion,
			@CodigoZona,
			@Monto,
			@AlcansoIncentivo,
			GETDATE(),
			NULL
		)
	END
END
GO

USE BelcorpBolivia
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'P' and id = OBJECT_ID('dbo.InsIncentivosMontoExigencia'))
	DROP PROC dbo.InsIncentivosMontoExigencia
GO
CREATE PROC InsIncentivosMontoExigencia
(
@MontoID int,
@CodigoCampania varchar(8),
@CodigoRegion varchar(8),
@CodigoZona varchar(8),
@Monto varchar(12),
@AlcansoIncentivo varchar(1)
)
AS
BEGIN
	IF EXISTS (SELECT 1 FROM IncentivosMontoExigencia WHERE MontoID = @MontoID)
	begin
		Update IncentivosMontoExigencia set
			CodigoCampania = @CodigoCampania,
			CodigoRegion = @CodigoRegion,
			CodigoZona = @CodigoZona,
			Monto = @Monto,
			AlcansoIncentivo = @AlcansoIncentivo,
			FechaModificacion = GETDATE()
		WHERE MontoID = @MontoID
	end
	ELSE
	BEGIN
		INSERT INTO IncentivosMontoExigencia VALUES
		(
			@CodigoCampania,
			@CodigoRegion,
			@CodigoZona,
			@Monto,
			@AlcansoIncentivo,
			GETDATE(),
			NULL
		)
	END
END
GO

