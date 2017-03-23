USE BelcorpPeru
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdPedidoWebDetalleOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[UpdPedidoWebDetalleOferta]
GO

CREATE PROCEDURE [dbo].[UpdPedidoWebDetalleOferta]

	@ConsultoraID INT,
	@CampaniaID INT,
	@CUV Varchar(20),
	@Cantidad INT,
	@CantidadAnterior INT,
	@PrecioUnidad MONEY,
	@TipoOfertaSisID int,
	@CodigoUsuarioModificacion varchar(25) = null,
	@OrigenPedidoWeb int = 0
AS
BEGIN
--Nueva 2
--Anterior 4
-- Actual 4

--Nueva 4
--Anterior 2
-- Actual 12

--Nueva 4
--Anterior 4
-- Actual 12

	Declare @CantidadActual int 
	SET @CantidadActual = (select isnull(cantidad,0) from pedidowebdetalle WHERE 
							CampaniaID = @CampaniaID AND
							CUV = @CUV AND
							TipoOfertaSisID = @TipoOfertaSisID AND
							ConsultoraID = @ConsultoraID)

UPDATE dbo.PedidoWebDetalle
	set Cantidad = CASE WHEN @Cantidad = @CantidadAnterior THEN @Cantidad
						WHEN @CantidadAnterior > @Cantidad THEN @CantidadActual - (@CantidadAnterior - @Cantidad)
						WHEN @CantidadAnterior < @Cantidad THEN @CantidadActual + (@Cantidad - @CantidadAnterior)
					END,
	ImporteTotal = @Cantidad*@PrecioUnidad,
	CodigoUsuarioModificacion = @CodigoUsuarioModificacion,
	FechaModificacion = dbo.fnObtenerFechaHoraPais(),	
	OrigenPedidoWeb = CASE WHEN OrigenPedidoWeb > 0 THEN OrigenPedidoWeb ELSE @OrigenPedidoWeb END
WHERE  CampaniaID = @CampaniaID AND
		CUV = @CUV AND
		TipoOfertaSisID = @TipoOfertaSisID AND
		ConsultoraID = @ConsultoraID 
END


GO

USE BelcorpMexico
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdPedidoWebDetalleOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[UpdPedidoWebDetalleOferta]
GO

CREATE PROCEDURE [dbo].[UpdPedidoWebDetalleOferta]

	@ConsultoraID INT,
	@CampaniaID INT,
	@CUV Varchar(20),
	@Cantidad INT,
	@CantidadAnterior INT,
	@PrecioUnidad MONEY,
	@TipoOfertaSisID int,
	@CodigoUsuarioModificacion varchar(25) = null,
	@OrigenPedidoWeb int = 0
AS
BEGIN
--Nueva 2
--Anterior 4
-- Actual 4

--Nueva 4
--Anterior 2
-- Actual 12

--Nueva 4
--Anterior 4
-- Actual 12

	Declare @CantidadActual int 
	SET @CantidadActual = (select isnull(cantidad,0) from pedidowebdetalle WHERE 
							CampaniaID = @CampaniaID AND
							CUV = @CUV AND
							TipoOfertaSisID = @TipoOfertaSisID AND
							ConsultoraID = @ConsultoraID)

UPDATE dbo.PedidoWebDetalle
	set Cantidad = CASE WHEN @Cantidad = @CantidadAnterior THEN @Cantidad
						WHEN @CantidadAnterior > @Cantidad THEN @CantidadActual - (@CantidadAnterior - @Cantidad)
						WHEN @CantidadAnterior < @Cantidad THEN @CantidadActual + (@Cantidad - @CantidadAnterior)
					END,
	ImporteTotal = @Cantidad*@PrecioUnidad,
	CodigoUsuarioModificacion = @CodigoUsuarioModificacion,
	FechaModificacion = dbo.fnObtenerFechaHoraPais(),	
	OrigenPedidoWeb = CASE WHEN OrigenPedidoWeb > 0 THEN OrigenPedidoWeb ELSE @OrigenPedidoWeb END
WHERE  CampaniaID = @CampaniaID AND
		CUV = @CUV AND
		TipoOfertaSisID = @TipoOfertaSisID AND
		ConsultoraID = @ConsultoraID 
END


GO

USE BelcorpColombia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdPedidoWebDetalleOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[UpdPedidoWebDetalleOferta]
GO

CREATE PROCEDURE [dbo].[UpdPedidoWebDetalleOferta]

	@ConsultoraID INT,
	@CampaniaID INT,
	@CUV Varchar(20),
	@Cantidad INT,
	@CantidadAnterior INT,
	@PrecioUnidad MONEY,
	@TipoOfertaSisID int,
	@CodigoUsuarioModificacion varchar(25) = null,
	@OrigenPedidoWeb int = 0
AS
BEGIN
--Nueva 2
--Anterior 4
-- Actual 4

--Nueva 4
--Anterior 2
-- Actual 12

--Nueva 4
--Anterior 4
-- Actual 12

	Declare @CantidadActual int 
	SET @CantidadActual = (select isnull(cantidad,0) from pedidowebdetalle WHERE 
							CampaniaID = @CampaniaID AND
							CUV = @CUV AND
							TipoOfertaSisID = @TipoOfertaSisID AND
							ConsultoraID = @ConsultoraID)

UPDATE dbo.PedidoWebDetalle
	set Cantidad = CASE WHEN @Cantidad = @CantidadAnterior THEN @Cantidad
						WHEN @CantidadAnterior > @Cantidad THEN @CantidadActual - (@CantidadAnterior - @Cantidad)
						WHEN @CantidadAnterior < @Cantidad THEN @CantidadActual + (@Cantidad - @CantidadAnterior)
					END,
	ImporteTotal = @Cantidad*@PrecioUnidad,
	CodigoUsuarioModificacion = @CodigoUsuarioModificacion,
	FechaModificacion = dbo.fnObtenerFechaHoraPais(),	
	OrigenPedidoWeb = CASE WHEN OrigenPedidoWeb > 0 THEN OrigenPedidoWeb ELSE @OrigenPedidoWeb END
WHERE  CampaniaID = @CampaniaID AND
		CUV = @CUV AND
		TipoOfertaSisID = @TipoOfertaSisID AND
		ConsultoraID = @ConsultoraID 
END


GO

USE BelcorpVenezuela
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdPedidoWebDetalleOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[UpdPedidoWebDetalleOferta]
GO

CREATE PROCEDURE [dbo].[UpdPedidoWebDetalleOferta]

	@ConsultoraID INT,
	@CampaniaID INT,
	@CUV Varchar(20),
	@Cantidad INT,
	@CantidadAnterior INT,
	@PrecioUnidad MONEY,
	@TipoOfertaSisID int,
	@CodigoUsuarioModificacion varchar(25) = null,
	@OrigenPedidoWeb int = 0
AS
BEGIN
--Nueva 2
--Anterior 4
-- Actual 4

--Nueva 4
--Anterior 2
-- Actual 12

--Nueva 4
--Anterior 4
-- Actual 12

	Declare @CantidadActual int 
	SET @CantidadActual = (select isnull(cantidad,0) from pedidowebdetalle WHERE 
							CampaniaID = @CampaniaID AND
							CUV = @CUV AND
							TipoOfertaSisID = @TipoOfertaSisID AND
							ConsultoraID = @ConsultoraID)

UPDATE dbo.PedidoWebDetalle
	set Cantidad = CASE WHEN @Cantidad = @CantidadAnterior THEN @Cantidad
						WHEN @CantidadAnterior > @Cantidad THEN @CantidadActual - (@CantidadAnterior - @Cantidad)
						WHEN @CantidadAnterior < @Cantidad THEN @CantidadActual + (@Cantidad - @CantidadAnterior)
					END,
	ImporteTotal = @Cantidad*@PrecioUnidad,
	CodigoUsuarioModificacion = @CodigoUsuarioModificacion,
	FechaModificacion = dbo.fnObtenerFechaHoraPais(),	
	OrigenPedidoWeb = CASE WHEN OrigenPedidoWeb > 0 THEN OrigenPedidoWeb ELSE @OrigenPedidoWeb END
WHERE  CampaniaID = @CampaniaID AND
		CUV = @CUV AND
		TipoOfertaSisID = @TipoOfertaSisID AND
		ConsultoraID = @ConsultoraID 
END


GO

USE BelcorpSalvador
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdPedidoWebDetalleOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[UpdPedidoWebDetalleOferta]
GO

CREATE PROCEDURE [dbo].[UpdPedidoWebDetalleOferta]

	@ConsultoraID INT,
	@CampaniaID INT,
	@CUV Varchar(20),
	@Cantidad INT,
	@CantidadAnterior INT,
	@PrecioUnidad MONEY,
	@TipoOfertaSisID int,
	@CodigoUsuarioModificacion varchar(25) = null,
	@OrigenPedidoWeb int = 0
AS
BEGIN
--Nueva 2
--Anterior 4
-- Actual 4

--Nueva 4
--Anterior 2
-- Actual 12

--Nueva 4
--Anterior 4
-- Actual 12

	Declare @CantidadActual int 
	SET @CantidadActual = (select isnull(cantidad,0) from pedidowebdetalle WHERE 
							CampaniaID = @CampaniaID AND
							CUV = @CUV AND
							TipoOfertaSisID = @TipoOfertaSisID AND
							ConsultoraID = @ConsultoraID)

UPDATE dbo.PedidoWebDetalle
	set Cantidad = CASE WHEN @Cantidad = @CantidadAnterior THEN @Cantidad
						WHEN @CantidadAnterior > @Cantidad THEN @CantidadActual - (@CantidadAnterior - @Cantidad)
						WHEN @CantidadAnterior < @Cantidad THEN @CantidadActual + (@Cantidad - @CantidadAnterior)
					END,
	ImporteTotal = @Cantidad*@PrecioUnidad,
	CodigoUsuarioModificacion = @CodigoUsuarioModificacion,
	FechaModificacion = dbo.fnObtenerFechaHoraPais(),	
	OrigenPedidoWeb = CASE WHEN OrigenPedidoWeb > 0 THEN OrigenPedidoWeb ELSE @OrigenPedidoWeb END
WHERE  CampaniaID = @CampaniaID AND
		CUV = @CUV AND
		TipoOfertaSisID = @TipoOfertaSisID AND
		ConsultoraID = @ConsultoraID 
END


GO

USE BelcorpPuertoRico
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdPedidoWebDetalleOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[UpdPedidoWebDetalleOferta]
GO

CREATE PROCEDURE [dbo].[UpdPedidoWebDetalleOferta]

	@ConsultoraID INT,
	@CampaniaID INT,
	@CUV Varchar(20),
	@Cantidad INT,
	@CantidadAnterior INT,
	@PrecioUnidad MONEY,
	@TipoOfertaSisID int,
	@CodigoUsuarioModificacion varchar(25) = null,
	@OrigenPedidoWeb int = 0
AS
BEGIN
--Nueva 2
--Anterior 4
-- Actual 4

--Nueva 4
--Anterior 2
-- Actual 12

--Nueva 4
--Anterior 4
-- Actual 12

	Declare @CantidadActual int 
	SET @CantidadActual = (select isnull(cantidad,0) from pedidowebdetalle WHERE 
							CampaniaID = @CampaniaID AND
							CUV = @CUV AND
							TipoOfertaSisID = @TipoOfertaSisID AND
							ConsultoraID = @ConsultoraID)

UPDATE dbo.PedidoWebDetalle
	set Cantidad = CASE WHEN @Cantidad = @CantidadAnterior THEN @Cantidad
						WHEN @CantidadAnterior > @Cantidad THEN @CantidadActual - (@CantidadAnterior - @Cantidad)
						WHEN @CantidadAnterior < @Cantidad THEN @CantidadActual + (@Cantidad - @CantidadAnterior)
					END,
	ImporteTotal = @Cantidad*@PrecioUnidad,
	CodigoUsuarioModificacion = @CodigoUsuarioModificacion,
	FechaModificacion = dbo.fnObtenerFechaHoraPais(),	
	OrigenPedidoWeb = CASE WHEN OrigenPedidoWeb > 0 THEN OrigenPedidoWeb ELSE @OrigenPedidoWeb END
WHERE  CampaniaID = @CampaniaID AND
		CUV = @CUV AND
		TipoOfertaSisID = @TipoOfertaSisID AND
		ConsultoraID = @ConsultoraID 
END


GO

USE BelcorpPanama
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdPedidoWebDetalleOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[UpdPedidoWebDetalleOferta]
GO

CREATE PROCEDURE [dbo].[UpdPedidoWebDetalleOferta]

	@ConsultoraID INT,
	@CampaniaID INT,
	@CUV Varchar(20),
	@Cantidad INT,
	@CantidadAnterior INT,
	@PrecioUnidad MONEY,
	@TipoOfertaSisID int,
	@CodigoUsuarioModificacion varchar(25) = null,
	@OrigenPedidoWeb int = 0
AS
BEGIN
--Nueva 2
--Anterior 4
-- Actual 4

--Nueva 4
--Anterior 2
-- Actual 12

--Nueva 4
--Anterior 4
-- Actual 12

	Declare @CantidadActual int 
	SET @CantidadActual = (select isnull(cantidad,0) from pedidowebdetalle WHERE 
							CampaniaID = @CampaniaID AND
							CUV = @CUV AND
							TipoOfertaSisID = @TipoOfertaSisID AND
							ConsultoraID = @ConsultoraID)

UPDATE dbo.PedidoWebDetalle
	set Cantidad = CASE WHEN @Cantidad = @CantidadAnterior THEN @Cantidad
						WHEN @CantidadAnterior > @Cantidad THEN @CantidadActual - (@CantidadAnterior - @Cantidad)
						WHEN @CantidadAnterior < @Cantidad THEN @CantidadActual + (@Cantidad - @CantidadAnterior)
					END,
	ImporteTotal = @Cantidad*@PrecioUnidad,
	CodigoUsuarioModificacion = @CodigoUsuarioModificacion,
	FechaModificacion = dbo.fnObtenerFechaHoraPais(),	
	OrigenPedidoWeb = CASE WHEN OrigenPedidoWeb > 0 THEN OrigenPedidoWeb ELSE @OrigenPedidoWeb END
WHERE  CampaniaID = @CampaniaID AND
		CUV = @CUV AND
		TipoOfertaSisID = @TipoOfertaSisID AND
		ConsultoraID = @ConsultoraID 
END


GO

USE BelcorpGuatemala
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdPedidoWebDetalleOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[UpdPedidoWebDetalleOferta]
GO

CREATE PROCEDURE [dbo].[UpdPedidoWebDetalleOferta]

	@ConsultoraID INT,
	@CampaniaID INT,
	@CUV Varchar(20),
	@Cantidad INT,
	@CantidadAnterior INT,
	@PrecioUnidad MONEY,
	@TipoOfertaSisID int,
	@CodigoUsuarioModificacion varchar(25) = null,
	@OrigenPedidoWeb int = 0
AS
BEGIN
--Nueva 2
--Anterior 4
-- Actual 4

--Nueva 4
--Anterior 2
-- Actual 12

--Nueva 4
--Anterior 4
-- Actual 12

	Declare @CantidadActual int 
	SET @CantidadActual = (select isnull(cantidad,0) from pedidowebdetalle WHERE 
							CampaniaID = @CampaniaID AND
							CUV = @CUV AND
							TipoOfertaSisID = @TipoOfertaSisID AND
							ConsultoraID = @ConsultoraID)

UPDATE dbo.PedidoWebDetalle
	set Cantidad = CASE WHEN @Cantidad = @CantidadAnterior THEN @Cantidad
						WHEN @CantidadAnterior > @Cantidad THEN @CantidadActual - (@CantidadAnterior - @Cantidad)
						WHEN @CantidadAnterior < @Cantidad THEN @CantidadActual + (@Cantidad - @CantidadAnterior)
					END,
	ImporteTotal = @Cantidad*@PrecioUnidad,
	CodigoUsuarioModificacion = @CodigoUsuarioModificacion,
	FechaModificacion = dbo.fnObtenerFechaHoraPais(),	
	OrigenPedidoWeb = CASE WHEN OrigenPedidoWeb > 0 THEN OrigenPedidoWeb ELSE @OrigenPedidoWeb END
WHERE  CampaniaID = @CampaniaID AND
		CUV = @CUV AND
		TipoOfertaSisID = @TipoOfertaSisID AND
		ConsultoraID = @ConsultoraID 
END


GO

USE BelcorpEcuador
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdPedidoWebDetalleOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[UpdPedidoWebDetalleOferta]
GO

CREATE PROCEDURE [dbo].[UpdPedidoWebDetalleOferta]

	@ConsultoraID INT,
	@CampaniaID INT,
	@CUV Varchar(20),
	@Cantidad INT,
	@CantidadAnterior INT,
	@PrecioUnidad MONEY,
	@TipoOfertaSisID int,
	@CodigoUsuarioModificacion varchar(25) = null,
	@OrigenPedidoWeb int = 0
AS
BEGIN
--Nueva 2
--Anterior 4
-- Actual 4

--Nueva 4
--Anterior 2
-- Actual 12

--Nueva 4
--Anterior 4
-- Actual 12

	Declare @CantidadActual int 
	SET @CantidadActual = (select isnull(cantidad,0) from pedidowebdetalle WHERE 
							CampaniaID = @CampaniaID AND
							CUV = @CUV AND
							TipoOfertaSisID = @TipoOfertaSisID AND
							ConsultoraID = @ConsultoraID)

UPDATE dbo.PedidoWebDetalle
	set Cantidad = CASE WHEN @Cantidad = @CantidadAnterior THEN @Cantidad
						WHEN @CantidadAnterior > @Cantidad THEN @CantidadActual - (@CantidadAnterior - @Cantidad)
						WHEN @CantidadAnterior < @Cantidad THEN @CantidadActual + (@Cantidad - @CantidadAnterior)
					END,
	ImporteTotal = @Cantidad*@PrecioUnidad,
	CodigoUsuarioModificacion = @CodigoUsuarioModificacion,
	FechaModificacion = dbo.fnObtenerFechaHoraPais(),	
	OrigenPedidoWeb = CASE WHEN OrigenPedidoWeb > 0 THEN OrigenPedidoWeb ELSE @OrigenPedidoWeb END
WHERE  CampaniaID = @CampaniaID AND
		CUV = @CUV AND
		TipoOfertaSisID = @TipoOfertaSisID AND
		ConsultoraID = @ConsultoraID 
END


GO

USE BelcorpDominicana
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdPedidoWebDetalleOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[UpdPedidoWebDetalleOferta]
GO

CREATE PROCEDURE [dbo].[UpdPedidoWebDetalleOferta]

	@ConsultoraID INT,
	@CampaniaID INT,
	@CUV Varchar(20),
	@Cantidad INT,
	@CantidadAnterior INT,
	@PrecioUnidad MONEY,
	@TipoOfertaSisID int,
	@CodigoUsuarioModificacion varchar(25) = null,
	@OrigenPedidoWeb int = 0
AS
BEGIN
--Nueva 2
--Anterior 4
-- Actual 4

--Nueva 4
--Anterior 2
-- Actual 12

--Nueva 4
--Anterior 4
-- Actual 12

	Declare @CantidadActual int 
	SET @CantidadActual = (select isnull(cantidad,0) from pedidowebdetalle WHERE 
							CampaniaID = @CampaniaID AND
							CUV = @CUV AND
							TipoOfertaSisID = @TipoOfertaSisID AND
							ConsultoraID = @ConsultoraID)

UPDATE dbo.PedidoWebDetalle
	set Cantidad = CASE WHEN @Cantidad = @CantidadAnterior THEN @Cantidad
						WHEN @CantidadAnterior > @Cantidad THEN @CantidadActual - (@CantidadAnterior - @Cantidad)
						WHEN @CantidadAnterior < @Cantidad THEN @CantidadActual + (@Cantidad - @CantidadAnterior)
					END,
	ImporteTotal = @Cantidad*@PrecioUnidad,
	CodigoUsuarioModificacion = @CodigoUsuarioModificacion,
	FechaModificacion = dbo.fnObtenerFechaHoraPais(),	
	OrigenPedidoWeb = CASE WHEN OrigenPedidoWeb > 0 THEN OrigenPedidoWeb ELSE @OrigenPedidoWeb END
WHERE  CampaniaID = @CampaniaID AND
		CUV = @CUV AND
		TipoOfertaSisID = @TipoOfertaSisID AND
		ConsultoraID = @ConsultoraID 
END


GO

USE BelcorpCostaRica
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdPedidoWebDetalleOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[UpdPedidoWebDetalleOferta]
GO

CREATE PROCEDURE [dbo].[UpdPedidoWebDetalleOferta]

	@ConsultoraID INT,
	@CampaniaID INT,
	@CUV Varchar(20),
	@Cantidad INT,
	@CantidadAnterior INT,
	@PrecioUnidad MONEY,
	@TipoOfertaSisID int,
	@CodigoUsuarioModificacion varchar(25) = null,
	@OrigenPedidoWeb int = 0
AS
BEGIN
--Nueva 2
--Anterior 4
-- Actual 4

--Nueva 4
--Anterior 2
-- Actual 12

--Nueva 4
--Anterior 4
-- Actual 12

	Declare @CantidadActual int 
	SET @CantidadActual = (select isnull(cantidad,0) from pedidowebdetalle WHERE 
							CampaniaID = @CampaniaID AND
							CUV = @CUV AND
							TipoOfertaSisID = @TipoOfertaSisID AND
							ConsultoraID = @ConsultoraID)

UPDATE dbo.PedidoWebDetalle
	set Cantidad = CASE WHEN @Cantidad = @CantidadAnterior THEN @Cantidad
						WHEN @CantidadAnterior > @Cantidad THEN @CantidadActual - (@CantidadAnterior - @Cantidad)
						WHEN @CantidadAnterior < @Cantidad THEN @CantidadActual + (@Cantidad - @CantidadAnterior)
					END,
	ImporteTotal = @Cantidad*@PrecioUnidad,
	CodigoUsuarioModificacion = @CodigoUsuarioModificacion,
	FechaModificacion = dbo.fnObtenerFechaHoraPais(),	
	OrigenPedidoWeb = CASE WHEN OrigenPedidoWeb > 0 THEN OrigenPedidoWeb ELSE @OrigenPedidoWeb END
WHERE  CampaniaID = @CampaniaID AND
		CUV = @CUV AND
		TipoOfertaSisID = @TipoOfertaSisID AND
		ConsultoraID = @ConsultoraID 
END


GO

USE BelcorpChile
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdPedidoWebDetalleOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[UpdPedidoWebDetalleOferta]
GO

CREATE PROCEDURE [dbo].[UpdPedidoWebDetalleOferta]

	@ConsultoraID INT,
	@CampaniaID INT,
	@CUV Varchar(20),
	@Cantidad INT,
	@CantidadAnterior INT,
	@PrecioUnidad MONEY,
	@TipoOfertaSisID int,
	@CodigoUsuarioModificacion varchar(25) = null,
	@OrigenPedidoWeb int = 0
AS
BEGIN
--Nueva 2
--Anterior 4
-- Actual 4

--Nueva 4
--Anterior 2
-- Actual 12

--Nueva 4
--Anterior 4
-- Actual 12

	Declare @CantidadActual int 
	SET @CantidadActual = (select isnull(cantidad,0) from pedidowebdetalle WHERE 
							CampaniaID = @CampaniaID AND
							CUV = @CUV AND
							TipoOfertaSisID = @TipoOfertaSisID AND
							ConsultoraID = @ConsultoraID)

UPDATE dbo.PedidoWebDetalle
	set Cantidad = CASE WHEN @Cantidad = @CantidadAnterior THEN @Cantidad
						WHEN @CantidadAnterior > @Cantidad THEN @CantidadActual - (@CantidadAnterior - @Cantidad)
						WHEN @CantidadAnterior < @Cantidad THEN @CantidadActual + (@Cantidad - @CantidadAnterior)
					END,
	ImporteTotal = @Cantidad*@PrecioUnidad,
	CodigoUsuarioModificacion = @CodigoUsuarioModificacion,
	FechaModificacion = dbo.fnObtenerFechaHoraPais(),	
	OrigenPedidoWeb = CASE WHEN OrigenPedidoWeb > 0 THEN OrigenPedidoWeb ELSE @OrigenPedidoWeb END
WHERE  CampaniaID = @CampaniaID AND
		CUV = @CUV AND
		TipoOfertaSisID = @TipoOfertaSisID AND
		ConsultoraID = @ConsultoraID 
END


GO

USE BelcorpBolivia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdPedidoWebDetalleOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[UpdPedidoWebDetalleOferta]
GO

CREATE PROCEDURE [dbo].[UpdPedidoWebDetalleOferta]

	@ConsultoraID INT,
	@CampaniaID INT,
	@CUV Varchar(20),
	@Cantidad INT,
	@CantidadAnterior INT,
	@PrecioUnidad MONEY,
	@TipoOfertaSisID int,
	@CodigoUsuarioModificacion varchar(25) = null,
	@OrigenPedidoWeb int = 0
AS
BEGIN
--Nueva 2
--Anterior 4
-- Actual 4

--Nueva 4
--Anterior 2
-- Actual 12

--Nueva 4
--Anterior 4
-- Actual 12

	Declare @CantidadActual int 
	SET @CantidadActual = (select isnull(cantidad,0) from pedidowebdetalle WHERE 
							CampaniaID = @CampaniaID AND
							CUV = @CUV AND
							TipoOfertaSisID = @TipoOfertaSisID AND
							ConsultoraID = @ConsultoraID)

UPDATE dbo.PedidoWebDetalle
	set Cantidad = CASE WHEN @Cantidad = @CantidadAnterior THEN @Cantidad
						WHEN @CantidadAnterior > @Cantidad THEN @CantidadActual - (@CantidadAnterior - @Cantidad)
						WHEN @CantidadAnterior < @Cantidad THEN @CantidadActual + (@Cantidad - @CantidadAnterior)
					END,
	ImporteTotal = @Cantidad*@PrecioUnidad,
	CodigoUsuarioModificacion = @CodigoUsuarioModificacion,
	FechaModificacion = dbo.fnObtenerFechaHoraPais(),	
	OrigenPedidoWeb = CASE WHEN OrigenPedidoWeb > 0 THEN OrigenPedidoWeb ELSE @OrigenPedidoWeb END
WHERE  CampaniaID = @CampaniaID AND
		CUV = @CUV AND
		TipoOfertaSisID = @TipoOfertaSisID AND
		ConsultoraID = @ConsultoraID 
END


GO

