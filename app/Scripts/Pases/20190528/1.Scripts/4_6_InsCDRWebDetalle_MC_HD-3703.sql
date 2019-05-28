USE BelcorpBolivia
GO

ALTER PROCEDURE dbo.InsCDRWebDetalle (
	@CDRWebDetalleID INT
	,@CDRWebID INT
	,@CodigoOperacion VARCHAR(5)
	,@CodigoReclamo VARCHAR(5)
	,@CUV VARCHAR(5)
	,@Cantidad INT
	,@CUV2 VARCHAR(5)
	,@Cantidad2 INT
	,@GrupoID VARCHAR(36) = NULL --HD-3703 EINCA
	--,@FechaRegistro datetime
	--,@Estado int
	--,@MotivoRechazo varchar(1)
	--,@Observacion varchar(1000)
	--,@Eliminado bit
	,@RetornoID INT OUTPUT
	)
AS
BEGIN
	SET @RetornoID = 0

	DECLARE @FechaGeneral DATETIME

	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

	IF @CDRWebDetalleID = 0
		AND @CDRWebID > 0
	BEGIN
		INSERT INTO CDRWebDetalle (
			CDRWebID
			,CodigoOperacion
			,CodigoReclamo
			,CUV
			,Cantidad
			,CUV2
			,Cantidad2
			,FechaRegistro
			,Estado
			,MotivoRechazo
			,Observacion
			,Eliminado
			,GrupoID
			)
		VALUES (
			@CDRWebID
			,@CodigoOperacion
			,@CodigoReclamo
			,@CUV
			,@Cantidad
			,@CUV2
			,@Cantidad2
			,@FechaGeneral
			,'1'
			,NULL
			,NULL
			,0
			,@GrupoID
			)

		SET @RetornoID = SCOPE_IDENTITY()
	END
	ELSE IF @CDRWebID > 0
		SET @RetornoID = @CDRWebDetalleID
END
GO

USE BelcorpChile
GO

ALTER PROCEDURE dbo.InsCDRWebDetalle (
	@CDRWebDetalleID INT
	,@CDRWebID INT
	,@CodigoOperacion VARCHAR(5)
	,@CodigoReclamo VARCHAR(5)
	,@CUV VARCHAR(5)
	,@Cantidad INT
	,@CUV2 VARCHAR(5)
	,@Cantidad2 INT
	,@GrupoID VARCHAR(36) = NULL --HD-3703 EINCA
	--,@FechaRegistro datetime
	--,@Estado int
	--,@MotivoRechazo varchar(1)
	--,@Observacion varchar(1000)
	--,@Eliminado bit
	,@RetornoID INT OUTPUT
	)
AS
BEGIN
	SET @RetornoID = 0

	DECLARE @FechaGeneral DATETIME

	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

	IF @CDRWebDetalleID = 0
		AND @CDRWebID > 0
	BEGIN
		INSERT INTO CDRWebDetalle (
			CDRWebID
			,CodigoOperacion
			,CodigoReclamo
			,CUV
			,Cantidad
			,CUV2
			,Cantidad2
			,FechaRegistro
			,Estado
			,MotivoRechazo
			,Observacion
			,Eliminado
			,GrupoID
			)
		VALUES (
			@CDRWebID
			,@CodigoOperacion
			,@CodigoReclamo
			,@CUV
			,@Cantidad
			,@CUV2
			,@Cantidad2
			,@FechaGeneral
			,'1'
			,NULL
			,NULL
			,0
			,@GrupoID
			)

		SET @RetornoID = SCOPE_IDENTITY()
	END
	ELSE IF @CDRWebID > 0
		SET @RetornoID = @CDRWebDetalleID
END
GO

USE BelcorpColombia
GO

ALTER PROCEDURE dbo.InsCDRWebDetalle (
	@CDRWebDetalleID INT
	,@CDRWebID INT
	,@CodigoOperacion VARCHAR(5)
	,@CodigoReclamo VARCHAR(5)
	,@CUV VARCHAR(5)
	,@Cantidad INT
	,@CUV2 VARCHAR(5)
	,@Cantidad2 INT
	,@GrupoID VARCHAR(36) = NULL --HD-3703 EINCA
	--,@FechaRegistro datetime
	--,@Estado int
	--,@MotivoRechazo varchar(1)
	--,@Observacion varchar(1000)
	--,@Eliminado bit
	,@RetornoID INT OUTPUT
	)
AS
BEGIN
	SET @RetornoID = 0

	DECLARE @FechaGeneral DATETIME

	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

	IF @CDRWebDetalleID = 0
		AND @CDRWebID > 0
	BEGIN
		INSERT INTO CDRWebDetalle (
			CDRWebID
			,CodigoOperacion
			,CodigoReclamo
			,CUV
			,Cantidad
			,CUV2
			,Cantidad2
			,FechaRegistro
			,Estado
			,MotivoRechazo
			,Observacion
			,Eliminado
			,GrupoID
			)
		VALUES (
			@CDRWebID
			,@CodigoOperacion
			,@CodigoReclamo
			,@CUV
			,@Cantidad
			,@CUV2
			,@Cantidad2
			,@FechaGeneral
			,'1'
			,NULL
			,NULL
			,0
			,@GrupoID
			)

		SET @RetornoID = SCOPE_IDENTITY()
	END
	ELSE IF @CDRWebID > 0
		SET @RetornoID = @CDRWebDetalleID
END
GO

USE BelcorpCostaRica
GO

ALTER PROCEDURE dbo.InsCDRWebDetalle (
	@CDRWebDetalleID INT
	,@CDRWebID INT
	,@CodigoOperacion VARCHAR(5)
	,@CodigoReclamo VARCHAR(5)
	,@CUV VARCHAR(5)
	,@Cantidad INT
	,@CUV2 VARCHAR(5)
	,@Cantidad2 INT
	,@GrupoID VARCHAR(36) = NULL --HD-3703 EINCA
	--,@FechaRegistro datetime
	--,@Estado int
	--,@MotivoRechazo varchar(1)
	--,@Observacion varchar(1000)
	--,@Eliminado bit
	,@RetornoID INT OUTPUT
	)
AS
BEGIN
	SET @RetornoID = 0

	DECLARE @FechaGeneral DATETIME

	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

	IF @CDRWebDetalleID = 0
		AND @CDRWebID > 0
	BEGIN
		INSERT INTO CDRWebDetalle (
			CDRWebID
			,CodigoOperacion
			,CodigoReclamo
			,CUV
			,Cantidad
			,CUV2
			,Cantidad2
			,FechaRegistro
			,Estado
			,MotivoRechazo
			,Observacion
			,Eliminado
			,GrupoID
			)
		VALUES (
			@CDRWebID
			,@CodigoOperacion
			,@CodigoReclamo
			,@CUV
			,@Cantidad
			,@CUV2
			,@Cantidad2
			,@FechaGeneral
			,'1'
			,NULL
			,NULL
			,0
			,@GrupoID
			)

		SET @RetornoID = SCOPE_IDENTITY()
	END
	ELSE IF @CDRWebID > 0
		SET @RetornoID = @CDRWebDetalleID
END
GO

USE BelcorpDominicana
GO

ALTER PROCEDURE dbo.InsCDRWebDetalle (
	@CDRWebDetalleID INT
	,@CDRWebID INT
	,@CodigoOperacion VARCHAR(5)
	,@CodigoReclamo VARCHAR(5)
	,@CUV VARCHAR(5)
	,@Cantidad INT
	,@CUV2 VARCHAR(5)
	,@Cantidad2 INT
	,@GrupoID VARCHAR(36) = NULL --HD-3703 EINCA
	--,@FechaRegistro datetime
	--,@Estado int
	--,@MotivoRechazo varchar(1)
	--,@Observacion varchar(1000)
	--,@Eliminado bit
	,@RetornoID INT OUTPUT
	)
AS
BEGIN
	SET @RetornoID = 0

	DECLARE @FechaGeneral DATETIME

	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

	IF @CDRWebDetalleID = 0
		AND @CDRWebID > 0
	BEGIN
		INSERT INTO CDRWebDetalle (
			CDRWebID
			,CodigoOperacion
			,CodigoReclamo
			,CUV
			,Cantidad
			,CUV2
			,Cantidad2
			,FechaRegistro
			,Estado
			,MotivoRechazo
			,Observacion
			,Eliminado
			,GrupoID
			)
		VALUES (
			@CDRWebID
			,@CodigoOperacion
			,@CodigoReclamo
			,@CUV
			,@Cantidad
			,@CUV2
			,@Cantidad2
			,@FechaGeneral
			,'1'
			,NULL
			,NULL
			,0
			,@GrupoID
			)

		SET @RetornoID = SCOPE_IDENTITY()
	END
	ELSE IF @CDRWebID > 0
		SET @RetornoID = @CDRWebDetalleID
END
GO

USE BelcorpEcuador
GO

ALTER PROCEDURE dbo.InsCDRWebDetalle (
	@CDRWebDetalleID INT
	,@CDRWebID INT
	,@CodigoOperacion VARCHAR(5)
	,@CodigoReclamo VARCHAR(5)
	,@CUV VARCHAR(5)
	,@Cantidad INT
	,@CUV2 VARCHAR(5)
	,@Cantidad2 INT
	,@GrupoID VARCHAR(36) = NULL --HD-3703 EINCA
	--,@FechaRegistro datetime
	--,@Estado int
	--,@MotivoRechazo varchar(1)
	--,@Observacion varchar(1000)
	--,@Eliminado bit
	,@RetornoID INT OUTPUT
	)
AS
BEGIN
	SET @RetornoID = 0

	DECLARE @FechaGeneral DATETIME

	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

	IF @CDRWebDetalleID = 0
		AND @CDRWebID > 0
	BEGIN
		INSERT INTO CDRWebDetalle (
			CDRWebID
			,CodigoOperacion
			,CodigoReclamo
			,CUV
			,Cantidad
			,CUV2
			,Cantidad2
			,FechaRegistro
			,Estado
			,MotivoRechazo
			,Observacion
			,Eliminado
			,GrupoID
			)
		VALUES (
			@CDRWebID
			,@CodigoOperacion
			,@CodigoReclamo
			,@CUV
			,@Cantidad
			,@CUV2
			,@Cantidad2
			,@FechaGeneral
			,'1'
			,NULL
			,NULL
			,0
			,@GrupoID
			)

		SET @RetornoID = SCOPE_IDENTITY()
	END
	ELSE IF @CDRWebID > 0
		SET @RetornoID = @CDRWebDetalleID
END
GO

USE BelcorpGuatemala
GO

ALTER PROCEDURE dbo.InsCDRWebDetalle (
	@CDRWebDetalleID INT
	,@CDRWebID INT
	,@CodigoOperacion VARCHAR(5)
	,@CodigoReclamo VARCHAR(5)
	,@CUV VARCHAR(5)
	,@Cantidad INT
	,@CUV2 VARCHAR(5)
	,@Cantidad2 INT
	,@GrupoID VARCHAR(36) = NULL --HD-3703 EINCA
	--,@FechaRegistro datetime
	--,@Estado int
	--,@MotivoRechazo varchar(1)
	--,@Observacion varchar(1000)
	--,@Eliminado bit
	,@RetornoID INT OUTPUT
	)
AS
BEGIN
	SET @RetornoID = 0

	DECLARE @FechaGeneral DATETIME

	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

	IF @CDRWebDetalleID = 0
		AND @CDRWebID > 0
	BEGIN
		INSERT INTO CDRWebDetalle (
			CDRWebID
			,CodigoOperacion
			,CodigoReclamo
			,CUV
			,Cantidad
			,CUV2
			,Cantidad2
			,FechaRegistro
			,Estado
			,MotivoRechazo
			,Observacion
			,Eliminado
			,GrupoID
			)
		VALUES (
			@CDRWebID
			,@CodigoOperacion
			,@CodigoReclamo
			,@CUV
			,@Cantidad
			,@CUV2
			,@Cantidad2
			,@FechaGeneral
			,'1'
			,NULL
			,NULL
			,0
			,@GrupoID
			)

		SET @RetornoID = SCOPE_IDENTITY()
	END
	ELSE IF @CDRWebID > 0
		SET @RetornoID = @CDRWebDetalleID
END
GO

USE BelcorpMexico
GO

ALTER PROCEDURE dbo.InsCDRWebDetalle (
	@CDRWebDetalleID INT
	,@CDRWebID INT
	,@CodigoOperacion VARCHAR(5)
	,@CodigoReclamo VARCHAR(5)
	,@CUV VARCHAR(5)
	,@Cantidad INT
	,@CUV2 VARCHAR(5)
	,@Cantidad2 INT
	,@GrupoID VARCHAR(36) = NULL --HD-3703 EINCA
	--,@FechaRegistro datetime
	--,@Estado int
	--,@MotivoRechazo varchar(1)
	--,@Observacion varchar(1000)
	--,@Eliminado bit
	,@RetornoID INT OUTPUT
	)
AS
BEGIN
	SET @RetornoID = 0

	DECLARE @FechaGeneral DATETIME

	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

	IF @CDRWebDetalleID = 0
		AND @CDRWebID > 0
	BEGIN
		INSERT INTO CDRWebDetalle (
			CDRWebID
			,CodigoOperacion
			,CodigoReclamo
			,CUV
			,Cantidad
			,CUV2
			,Cantidad2
			,FechaRegistro
			,Estado
			,MotivoRechazo
			,Observacion
			,Eliminado
			,GrupoID
			)
		VALUES (
			@CDRWebID
			,@CodigoOperacion
			,@CodigoReclamo
			,@CUV
			,@Cantidad
			,@CUV2
			,@Cantidad2
			,@FechaGeneral
			,'1'
			,NULL
			,NULL
			,0
			,@GrupoID
			)

		SET @RetornoID = SCOPE_IDENTITY()
	END
	ELSE IF @CDRWebID > 0
		SET @RetornoID = @CDRWebDetalleID
END
GO

USE BelcorpPanama
GO

ALTER PROCEDURE dbo.InsCDRWebDetalle (
	@CDRWebDetalleID INT
	,@CDRWebID INT
	,@CodigoOperacion VARCHAR(5)
	,@CodigoReclamo VARCHAR(5)
	,@CUV VARCHAR(5)
	,@Cantidad INT
	,@CUV2 VARCHAR(5)
	,@Cantidad2 INT
	,@GrupoID VARCHAR(36) = NULL --HD-3703 EINCA
	--,@FechaRegistro datetime
	--,@Estado int
	--,@MotivoRechazo varchar(1)
	--,@Observacion varchar(1000)
	--,@Eliminado bit
	,@RetornoID INT OUTPUT
	)
AS
BEGIN
	SET @RetornoID = 0

	DECLARE @FechaGeneral DATETIME

	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

	IF @CDRWebDetalleID = 0
		AND @CDRWebID > 0
	BEGIN
		INSERT INTO CDRWebDetalle (
			CDRWebID
			,CodigoOperacion
			,CodigoReclamo
			,CUV
			,Cantidad
			,CUV2
			,Cantidad2
			,FechaRegistro
			,Estado
			,MotivoRechazo
			,Observacion
			,Eliminado
			,GrupoID
			)
		VALUES (
			@CDRWebID
			,@CodigoOperacion
			,@CodigoReclamo
			,@CUV
			,@Cantidad
			,@CUV2
			,@Cantidad2
			,@FechaGeneral
			,'1'
			,NULL
			,NULL
			,0
			,@GrupoID
			)

		SET @RetornoID = SCOPE_IDENTITY()
	END
	ELSE IF @CDRWebID > 0
		SET @RetornoID = @CDRWebDetalleID
END
GO


USE BelcorpPeru
GO

ALTER PROCEDURE dbo.InsCDRWebDetalle (
	@CDRWebDetalleID INT
	,@CDRWebID INT
	,@CodigoOperacion VARCHAR(5)
	,@CodigoReclamo VARCHAR(5)
	,@CUV VARCHAR(5)
	,@Cantidad INT
	,@CUV2 VARCHAR(5)
	,@Cantidad2 INT
	,@GrupoID VARCHAR(36) = NULL --HD-3703 EINCA
	--,@FechaRegistro datetime
	--,@Estado int
	--,@MotivoRechazo varchar(1)
	--,@Observacion varchar(1000)
	--,@Eliminado bit
	,@RetornoID INT OUTPUT
	)
AS
BEGIN
	SET @RetornoID = 0

	DECLARE @FechaGeneral DATETIME

	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

	IF @CDRWebDetalleID = 0
		AND @CDRWebID > 0
	BEGIN
		INSERT INTO CDRWebDetalle (
			CDRWebID
			,CodigoOperacion
			,CodigoReclamo
			,CUV
			,Cantidad
			,CUV2
			,Cantidad2
			,FechaRegistro
			,Estado
			,MotivoRechazo
			,Observacion
			,Eliminado
			,GrupoID
			)
		VALUES (
			@CDRWebID
			,@CodigoOperacion
			,@CodigoReclamo
			,@CUV
			,@Cantidad
			,@CUV2
			,@Cantidad2
			,@FechaGeneral
			,'1'
			,NULL
			,NULL
			,0
			,@GrupoID
			)

		SET @RetornoID = SCOPE_IDENTITY()
	END
	ELSE IF @CDRWebID > 0
		SET @RetornoID = @CDRWebDetalleID
END
GO

USE BelcorpPuertoRico
GO

ALTER PROCEDURE dbo.InsCDRWebDetalle (
	@CDRWebDetalleID INT
	,@CDRWebID INT
	,@CodigoOperacion VARCHAR(5)
	,@CodigoReclamo VARCHAR(5)
	,@CUV VARCHAR(5)
	,@Cantidad INT
	,@CUV2 VARCHAR(5)
	,@Cantidad2 INT
	,@GrupoID VARCHAR(36) = NULL --HD-3703 EINCA
	--,@FechaRegistro datetime
	--,@Estado int
	--,@MotivoRechazo varchar(1)
	--,@Observacion varchar(1000)
	--,@Eliminado bit
	,@RetornoID INT OUTPUT
	)
AS
BEGIN
	SET @RetornoID = 0

	DECLARE @FechaGeneral DATETIME

	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

	IF @CDRWebDetalleID = 0
		AND @CDRWebID > 0
	BEGIN
		INSERT INTO CDRWebDetalle (
			CDRWebID
			,CodigoOperacion
			,CodigoReclamo
			,CUV
			,Cantidad
			,CUV2
			,Cantidad2
			,FechaRegistro
			,Estado
			,MotivoRechazo
			,Observacion
			,Eliminado
			,GrupoID
			)
		VALUES (
			@CDRWebID
			,@CodigoOperacion
			,@CodigoReclamo
			,@CUV
			,@Cantidad
			,@CUV2
			,@Cantidad2
			,@FechaGeneral
			,'1'
			,NULL
			,NULL
			,0
			,@GrupoID
			)

		SET @RetornoID = SCOPE_IDENTITY()
	END
	ELSE IF @CDRWebID > 0
		SET @RetornoID = @CDRWebDetalleID
END
GO

USE BelcorpSalvador
GO

ALTER PROCEDURE dbo.InsCDRWebDetalle (
	@CDRWebDetalleID INT
	,@CDRWebID INT
	,@CodigoOperacion VARCHAR(5)
	,@CodigoReclamo VARCHAR(5)
	,@CUV VARCHAR(5)
	,@Cantidad INT
	,@CUV2 VARCHAR(5)
	,@Cantidad2 INT
	,@GrupoID VARCHAR(36) = NULL --HD-3703 EINCA
	--,@FechaRegistro datetime
	--,@Estado int
	--,@MotivoRechazo varchar(1)
	--,@Observacion varchar(1000)
	--,@Eliminado bit
	,@RetornoID INT OUTPUT
	)
AS
BEGIN
	SET @RetornoID = 0

	DECLARE @FechaGeneral DATETIME

	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

	IF @CDRWebDetalleID = 0
		AND @CDRWebID > 0
	BEGIN
		INSERT INTO CDRWebDetalle (
			CDRWebID
			,CodigoOperacion
			,CodigoReclamo
			,CUV
			,Cantidad
			,CUV2
			,Cantidad2
			,FechaRegistro
			,Estado
			,MotivoRechazo
			,Observacion
			,Eliminado
			,GrupoID
			)
		VALUES (
			@CDRWebID
			,@CodigoOperacion
			,@CodigoReclamo
			,@CUV
			,@Cantidad
			,@CUV2
			,@Cantidad2
			,@FechaGeneral
			,'1'
			,NULL
			,NULL
			,0
			,@GrupoID
			)

		SET @RetornoID = SCOPE_IDENTITY()
	END
	ELSE IF @CDRWebID > 0
		SET @RetornoID = @CDRWebDetalleID
END
GO


