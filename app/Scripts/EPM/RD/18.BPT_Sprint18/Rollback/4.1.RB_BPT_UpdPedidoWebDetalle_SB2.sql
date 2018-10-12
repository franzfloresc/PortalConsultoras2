USE BelcorpPeru
GO

GO

ALTER PROCEDURE [dbo].[UpdPedidoWebDetalle_SB2]
	@CampaniaID INT,
	@PedidoID INT,
	@PedidoDetalleID SMALLINT,
	@Cantidad INT,
	@PrecioUnidad MONEY,
	@ClienteID SMALLINT,
	@CodigoUsuarioModificacion varchar(25) = null,
	@EsSugerido bit,
	@OrdenPedidoWD int = 0,
	@OrigenPedidoWeb int = 0
AS
BEGIN	
	if @OrdenPedidoWD = 1
	begin		
		SELECT @OrdenPedidoWD = max(ISNULL(OrdenPedidoWD,0))
		FROM dbo.PedidoWebDetalle 
		WHERE 
			CampaniaID = @CampaniaID
			AND PedidoID = @PedidoID

		set @OrdenPedidoWD = ISNULL(@OrdenPedidoWD, 0) + 1
	end
	else set @OrdenPedidoWD = 0

	UPDATE dbo.PedidoWebDetalle
	SET	ClienteID = @ClienteID,
		Cantidad = @Cantidad,
		ImporteTotal = @Cantidad*@PrecioUnidad,
		CodigoUsuarioModificacion = @CodigoUsuarioModificacion,
		FechaModificacion = dbo.fnObtenerFechaHoraPais(),
		TipoPedido = CASE WHEN TipoPedido = 'M' THEN 'X' ELSE TipoPedido END,
		EsSugerido = @EsSugerido,
		OrdenPedidoWD = case when @OrdenPedidoWD > 0 then @OrdenPedidoWD else OrdenPedidoWD end,
		--OrigenPedidoWeb = @OrigenPedidoWeb,
		EsBackOrder = CASE WHEN ISNULL(EsBackOrder,0) = 1 THEN 1 ELSE 0 END,
		AceptoBackOrder = CASE WHEN ISNULL(AceptoBackOrder,0) = 1 THEN 1 ELSE 0 END
	WHERE
		CampaniaID = @CampaniaID
		AND	PedidoID = @PedidoID
		AND	PedidoDetalleID = @PedidoDetalleID;
END

GO

USE BelcorpMexico
GO

GO

ALTER PROCEDURE [dbo].[UpdPedidoWebDetalle_SB2]
	@CampaniaID INT,
	@PedidoID INT,
	@PedidoDetalleID SMALLINT,
	@Cantidad INT,
	@PrecioUnidad MONEY,
	@ClienteID SMALLINT,
	@CodigoUsuarioModificacion varchar(25) = null,
	@EsSugerido bit,
	@OrdenPedidoWD int = 0,
	@OrigenPedidoWeb int = 0
AS
BEGIN	
	if @OrdenPedidoWD = 1
	begin		
		SELECT @OrdenPedidoWD = max(ISNULL(OrdenPedidoWD,0))
		FROM dbo.PedidoWebDetalle 
		WHERE 
			CampaniaID = @CampaniaID
			AND PedidoID = @PedidoID

		set @OrdenPedidoWD = ISNULL(@OrdenPedidoWD, 0) + 1
	end
	else set @OrdenPedidoWD = 0

	UPDATE dbo.PedidoWebDetalle
	SET	ClienteID = @ClienteID,
		Cantidad = @Cantidad,
		ImporteTotal = @Cantidad*@PrecioUnidad,
		CodigoUsuarioModificacion = @CodigoUsuarioModificacion,
		FechaModificacion = dbo.fnObtenerFechaHoraPais(),
		TipoPedido = CASE WHEN TipoPedido = 'M' THEN 'X' ELSE TipoPedido END,
		EsSugerido = @EsSugerido,
		OrdenPedidoWD = case when @OrdenPedidoWD > 0 then @OrdenPedidoWD else OrdenPedidoWD end,
		--OrigenPedidoWeb = @OrigenPedidoWeb,
		EsBackOrder = CASE WHEN ISNULL(EsBackOrder,0) = 1 THEN 1 ELSE 0 END,
		AceptoBackOrder = CASE WHEN ISNULL(AceptoBackOrder,0) = 1 THEN 1 ELSE 0 END
	WHERE
		CampaniaID = @CampaniaID
		AND	PedidoID = @PedidoID
		AND	PedidoDetalleID = @PedidoDetalleID;
END

GO

USE BelcorpColombia
GO

GO

ALTER PROCEDURE [dbo].[UpdPedidoWebDetalle_SB2]
	@CampaniaID INT,
	@PedidoID INT,
	@PedidoDetalleID SMALLINT,
	@Cantidad INT,
	@PrecioUnidad MONEY,
	@ClienteID SMALLINT,
	@CodigoUsuarioModificacion varchar(25) = null,
	@EsSugerido bit,
	@OrdenPedidoWD int = 0,
	@OrigenPedidoWeb int = 0
AS
BEGIN	
	if @OrdenPedidoWD = 1
	begin		
		SELECT @OrdenPedidoWD = max(ISNULL(OrdenPedidoWD,0))
		FROM dbo.PedidoWebDetalle 
		WHERE 
			CampaniaID = @CampaniaID
			AND PedidoID = @PedidoID

		set @OrdenPedidoWD = ISNULL(@OrdenPedidoWD, 0) + 1
	end
	else set @OrdenPedidoWD = 0

	UPDATE dbo.PedidoWebDetalle
	SET	ClienteID = @ClienteID,
		Cantidad = @Cantidad,
		ImporteTotal = @Cantidad*@PrecioUnidad,
		CodigoUsuarioModificacion = @CodigoUsuarioModificacion,
		FechaModificacion = dbo.fnObtenerFechaHoraPais(),
		TipoPedido = CASE WHEN TipoPedido = 'M' THEN 'X' ELSE TipoPedido END,
		EsSugerido = @EsSugerido,
		OrdenPedidoWD = case when @OrdenPedidoWD > 0 then @OrdenPedidoWD else OrdenPedidoWD end,
		--OrigenPedidoWeb = @OrigenPedidoWeb,
		EsBackOrder = CASE WHEN ISNULL(EsBackOrder,0) = 1 THEN 1 ELSE 0 END,
		AceptoBackOrder = CASE WHEN ISNULL(AceptoBackOrder,0) = 1 THEN 1 ELSE 0 END
	WHERE
		CampaniaID = @CampaniaID
		AND	PedidoID = @PedidoID
		AND	PedidoDetalleID = @PedidoDetalleID;
END

GO

USE BelcorpVenezuela
GO

GO

ALTER PROCEDURE [dbo].[UpdPedidoWebDetalle_SB2]
	@CampaniaID INT,
	@PedidoID INT,
	@PedidoDetalleID SMALLINT,
	@Cantidad INT,
	@PrecioUnidad MONEY,
	@ClienteID SMALLINT,
	@CodigoUsuarioModificacion varchar(25) = null,
	@EsSugerido bit,
	@OrdenPedidoWD int = 0,
	@OrigenPedidoWeb int = 0
AS
BEGIN	
	if @OrdenPedidoWD = 1
	begin		
		SELECT @OrdenPedidoWD = max(ISNULL(OrdenPedidoWD,0))
		FROM dbo.PedidoWebDetalle 
		WHERE 
			CampaniaID = @CampaniaID
			AND PedidoID = @PedidoID

		set @OrdenPedidoWD = ISNULL(@OrdenPedidoWD, 0) + 1
	end
	else set @OrdenPedidoWD = 0

	UPDATE dbo.PedidoWebDetalle
	SET	ClienteID = @ClienteID,
		Cantidad = @Cantidad,
		ImporteTotal = @Cantidad*@PrecioUnidad,
		CodigoUsuarioModificacion = @CodigoUsuarioModificacion,
		FechaModificacion = dbo.fnObtenerFechaHoraPais(),
		TipoPedido = CASE WHEN TipoPedido = 'M' THEN 'X' ELSE TipoPedido END,
		EsSugerido = @EsSugerido,
		OrdenPedidoWD = case when @OrdenPedidoWD > 0 then @OrdenPedidoWD else OrdenPedidoWD end,
		--OrigenPedidoWeb = @OrigenPedidoWeb,
		EsBackOrder = CASE WHEN ISNULL(EsBackOrder,0) = 1 THEN 1 ELSE 0 END,
		AceptoBackOrder = CASE WHEN ISNULL(AceptoBackOrder,0) = 1 THEN 1 ELSE 0 END
	WHERE
		CampaniaID = @CampaniaID
		AND	PedidoID = @PedidoID
		AND	PedidoDetalleID = @PedidoDetalleID;
END

GO

USE BelcorpSalvador
GO

GO

ALTER PROCEDURE [dbo].[UpdPedidoWebDetalle_SB2]
	@CampaniaID INT,
	@PedidoID INT,
	@PedidoDetalleID SMALLINT,
	@Cantidad INT,
	@PrecioUnidad MONEY,
	@ClienteID SMALLINT,
	@CodigoUsuarioModificacion varchar(25) = null,
	@EsSugerido bit,
	@OrdenPedidoWD int = 0,
	@OrigenPedidoWeb int = 0
AS
BEGIN	
	if @OrdenPedidoWD = 1
	begin		
		SELECT @OrdenPedidoWD = max(ISNULL(OrdenPedidoWD,0))
		FROM dbo.PedidoWebDetalle 
		WHERE 
			CampaniaID = @CampaniaID
			AND PedidoID = @PedidoID

		set @OrdenPedidoWD = ISNULL(@OrdenPedidoWD, 0) + 1
	end
	else set @OrdenPedidoWD = 0

	UPDATE dbo.PedidoWebDetalle
	SET	ClienteID = @ClienteID,
		Cantidad = @Cantidad,
		ImporteTotal = @Cantidad*@PrecioUnidad,
		CodigoUsuarioModificacion = @CodigoUsuarioModificacion,
		FechaModificacion = dbo.fnObtenerFechaHoraPais(),
		TipoPedido = CASE WHEN TipoPedido = 'M' THEN 'X' ELSE TipoPedido END,
		EsSugerido = @EsSugerido,
		OrdenPedidoWD = case when @OrdenPedidoWD > 0 then @OrdenPedidoWD else OrdenPedidoWD end,
		--OrigenPedidoWeb = @OrigenPedidoWeb,
		EsBackOrder = CASE WHEN ISNULL(EsBackOrder,0) = 1 THEN 1 ELSE 0 END,
		AceptoBackOrder = CASE WHEN ISNULL(AceptoBackOrder,0) = 1 THEN 1 ELSE 0 END
	WHERE
		CampaniaID = @CampaniaID
		AND	PedidoID = @PedidoID
		AND	PedidoDetalleID = @PedidoDetalleID;
END

GO

USE BelcorpPuertoRico
GO

GO

ALTER PROCEDURE [dbo].[UpdPedidoWebDetalle_SB2]
	@CampaniaID INT,
	@PedidoID INT,
	@PedidoDetalleID SMALLINT,
	@Cantidad INT,
	@PrecioUnidad MONEY,
	@ClienteID SMALLINT,
	@CodigoUsuarioModificacion varchar(25) = null,
	@EsSugerido bit,
	@OrdenPedidoWD int = 0,
	@OrigenPedidoWeb int = 0
AS
BEGIN	
	if @OrdenPedidoWD = 1
	begin		
		SELECT @OrdenPedidoWD = max(ISNULL(OrdenPedidoWD,0))
		FROM dbo.PedidoWebDetalle 
		WHERE 
			CampaniaID = @CampaniaID
			AND PedidoID = @PedidoID

		set @OrdenPedidoWD = ISNULL(@OrdenPedidoWD, 0) + 1
	end
	else set @OrdenPedidoWD = 0

	UPDATE dbo.PedidoWebDetalle
	SET	ClienteID = @ClienteID,
		Cantidad = @Cantidad,
		ImporteTotal = @Cantidad*@PrecioUnidad,
		CodigoUsuarioModificacion = @CodigoUsuarioModificacion,
		FechaModificacion = dbo.fnObtenerFechaHoraPais(),
		TipoPedido = CASE WHEN TipoPedido = 'M' THEN 'X' ELSE TipoPedido END,
		EsSugerido = @EsSugerido,
		OrdenPedidoWD = case when @OrdenPedidoWD > 0 then @OrdenPedidoWD else OrdenPedidoWD end,
		--OrigenPedidoWeb = @OrigenPedidoWeb,
		EsBackOrder = CASE WHEN ISNULL(EsBackOrder,0) = 1 THEN 1 ELSE 0 END,
		AceptoBackOrder = CASE WHEN ISNULL(AceptoBackOrder,0) = 1 THEN 1 ELSE 0 END
	WHERE
		CampaniaID = @CampaniaID
		AND	PedidoID = @PedidoID
		AND	PedidoDetalleID = @PedidoDetalleID;
END

GO

USE BelcorpPanama
GO

GO

ALTER PROCEDURE [dbo].[UpdPedidoWebDetalle_SB2]
	@CampaniaID INT,
	@PedidoID INT,
	@PedidoDetalleID SMALLINT,
	@Cantidad INT,
	@PrecioUnidad MONEY,
	@ClienteID SMALLINT,
	@CodigoUsuarioModificacion varchar(25) = null,
	@EsSugerido bit,
	@OrdenPedidoWD int = 0,
	@OrigenPedidoWeb int = 0
AS
BEGIN	
	if @OrdenPedidoWD = 1
	begin		
		SELECT @OrdenPedidoWD = max(ISNULL(OrdenPedidoWD,0))
		FROM dbo.PedidoWebDetalle 
		WHERE 
			CampaniaID = @CampaniaID
			AND PedidoID = @PedidoID

		set @OrdenPedidoWD = ISNULL(@OrdenPedidoWD, 0) + 1
	end
	else set @OrdenPedidoWD = 0

	UPDATE dbo.PedidoWebDetalle
	SET	ClienteID = @ClienteID,
		Cantidad = @Cantidad,
		ImporteTotal = @Cantidad*@PrecioUnidad,
		CodigoUsuarioModificacion = @CodigoUsuarioModificacion,
		FechaModificacion = dbo.fnObtenerFechaHoraPais(),
		TipoPedido = CASE WHEN TipoPedido = 'M' THEN 'X' ELSE TipoPedido END,
		EsSugerido = @EsSugerido,
		OrdenPedidoWD = case when @OrdenPedidoWD > 0 then @OrdenPedidoWD else OrdenPedidoWD end,
		--OrigenPedidoWeb = @OrigenPedidoWeb,
		EsBackOrder = CASE WHEN ISNULL(EsBackOrder,0) = 1 THEN 1 ELSE 0 END,
		AceptoBackOrder = CASE WHEN ISNULL(AceptoBackOrder,0) = 1 THEN 1 ELSE 0 END
	WHERE
		CampaniaID = @CampaniaID
		AND	PedidoID = @PedidoID
		AND	PedidoDetalleID = @PedidoDetalleID;
END

GO

USE BelcorpGuatemala
GO

GO

ALTER PROCEDURE [dbo].[UpdPedidoWebDetalle_SB2]
	@CampaniaID INT,
	@PedidoID INT,
	@PedidoDetalleID SMALLINT,
	@Cantidad INT,
	@PrecioUnidad MONEY,
	@ClienteID SMALLINT,
	@CodigoUsuarioModificacion varchar(25) = null,
	@EsSugerido bit,
	@OrdenPedidoWD int = 0,
	@OrigenPedidoWeb int = 0
AS
BEGIN	
	if @OrdenPedidoWD = 1
	begin		
		SELECT @OrdenPedidoWD = max(ISNULL(OrdenPedidoWD,0))
		FROM dbo.PedidoWebDetalle 
		WHERE 
			CampaniaID = @CampaniaID
			AND PedidoID = @PedidoID

		set @OrdenPedidoWD = ISNULL(@OrdenPedidoWD, 0) + 1
	end
	else set @OrdenPedidoWD = 0

	UPDATE dbo.PedidoWebDetalle
	SET	ClienteID = @ClienteID,
		Cantidad = @Cantidad,
		ImporteTotal = @Cantidad*@PrecioUnidad,
		CodigoUsuarioModificacion = @CodigoUsuarioModificacion,
		FechaModificacion = dbo.fnObtenerFechaHoraPais(),
		TipoPedido = CASE WHEN TipoPedido = 'M' THEN 'X' ELSE TipoPedido END,
		EsSugerido = @EsSugerido,
		OrdenPedidoWD = case when @OrdenPedidoWD > 0 then @OrdenPedidoWD else OrdenPedidoWD end,
		--OrigenPedidoWeb = @OrigenPedidoWeb,
		EsBackOrder = CASE WHEN ISNULL(EsBackOrder,0) = 1 THEN 1 ELSE 0 END,
		AceptoBackOrder = CASE WHEN ISNULL(AceptoBackOrder,0) = 1 THEN 1 ELSE 0 END
	WHERE
		CampaniaID = @CampaniaID
		AND	PedidoID = @PedidoID
		AND	PedidoDetalleID = @PedidoDetalleID;
END

GO

USE BelcorpEcuador
GO

GO

ALTER PROCEDURE [dbo].[UpdPedidoWebDetalle_SB2]
	@CampaniaID INT,
	@PedidoID INT,
	@PedidoDetalleID SMALLINT,
	@Cantidad INT,
	@PrecioUnidad MONEY,
	@ClienteID SMALLINT,
	@CodigoUsuarioModificacion varchar(25) = null,
	@EsSugerido bit,
	@OrdenPedidoWD int = 0,
	@OrigenPedidoWeb int = 0
AS
BEGIN	
	if @OrdenPedidoWD = 1
	begin		
		SELECT @OrdenPedidoWD = max(ISNULL(OrdenPedidoWD,0))
		FROM dbo.PedidoWebDetalle 
		WHERE 
			CampaniaID = @CampaniaID
			AND PedidoID = @PedidoID

		set @OrdenPedidoWD = ISNULL(@OrdenPedidoWD, 0) + 1
	end
	else set @OrdenPedidoWD = 0

	UPDATE dbo.PedidoWebDetalle
	SET	ClienteID = @ClienteID,
		Cantidad = @Cantidad,
		ImporteTotal = @Cantidad*@PrecioUnidad,
		CodigoUsuarioModificacion = @CodigoUsuarioModificacion,
		FechaModificacion = dbo.fnObtenerFechaHoraPais(),
		TipoPedido = CASE WHEN TipoPedido = 'M' THEN 'X' ELSE TipoPedido END,
		EsSugerido = @EsSugerido,
		OrdenPedidoWD = case when @OrdenPedidoWD > 0 then @OrdenPedidoWD else OrdenPedidoWD end,
		--OrigenPedidoWeb = @OrigenPedidoWeb,
		EsBackOrder = CASE WHEN ISNULL(EsBackOrder,0) = 1 THEN 1 ELSE 0 END,
		AceptoBackOrder = CASE WHEN ISNULL(AceptoBackOrder,0) = 1 THEN 1 ELSE 0 END
	WHERE
		CampaniaID = @CampaniaID
		AND	PedidoID = @PedidoID
		AND	PedidoDetalleID = @PedidoDetalleID;
END

GO

USE BelcorpDominicana
GO

GO

ALTER PROCEDURE [dbo].[UpdPedidoWebDetalle_SB2]
	@CampaniaID INT,
	@PedidoID INT,
	@PedidoDetalleID SMALLINT,
	@Cantidad INT,
	@PrecioUnidad MONEY,
	@ClienteID SMALLINT,
	@CodigoUsuarioModificacion varchar(25) = null,
	@EsSugerido bit,
	@OrdenPedidoWD int = 0,
	@OrigenPedidoWeb int = 0
AS
BEGIN	
	if @OrdenPedidoWD = 1
	begin		
		SELECT @OrdenPedidoWD = max(ISNULL(OrdenPedidoWD,0))
		FROM dbo.PedidoWebDetalle 
		WHERE 
			CampaniaID = @CampaniaID
			AND PedidoID = @PedidoID

		set @OrdenPedidoWD = ISNULL(@OrdenPedidoWD, 0) + 1
	end
	else set @OrdenPedidoWD = 0

	UPDATE dbo.PedidoWebDetalle
	SET	ClienteID = @ClienteID,
		Cantidad = @Cantidad,
		ImporteTotal = @Cantidad*@PrecioUnidad,
		CodigoUsuarioModificacion = @CodigoUsuarioModificacion,
		FechaModificacion = dbo.fnObtenerFechaHoraPais(),
		TipoPedido = CASE WHEN TipoPedido = 'M' THEN 'X' ELSE TipoPedido END,
		EsSugerido = @EsSugerido,
		OrdenPedidoWD = case when @OrdenPedidoWD > 0 then @OrdenPedidoWD else OrdenPedidoWD end,
		--OrigenPedidoWeb = @OrigenPedidoWeb,
		EsBackOrder = CASE WHEN ISNULL(EsBackOrder,0) = 1 THEN 1 ELSE 0 END,
		AceptoBackOrder = CASE WHEN ISNULL(AceptoBackOrder,0) = 1 THEN 1 ELSE 0 END
	WHERE
		CampaniaID = @CampaniaID
		AND	PedidoID = @PedidoID
		AND	PedidoDetalleID = @PedidoDetalleID;
END

GO

USE BelcorpCostaRica
GO

GO

ALTER PROCEDURE [dbo].[UpdPedidoWebDetalle_SB2]
	@CampaniaID INT,
	@PedidoID INT,
	@PedidoDetalleID SMALLINT,
	@Cantidad INT,
	@PrecioUnidad MONEY,
	@ClienteID SMALLINT,
	@CodigoUsuarioModificacion varchar(25) = null,
	@EsSugerido bit,
	@OrdenPedidoWD int = 0,
	@OrigenPedidoWeb int = 0
AS
BEGIN	
	if @OrdenPedidoWD = 1
	begin		
		SELECT @OrdenPedidoWD = max(ISNULL(OrdenPedidoWD,0))
		FROM dbo.PedidoWebDetalle 
		WHERE 
			CampaniaID = @CampaniaID
			AND PedidoID = @PedidoID

		set @OrdenPedidoWD = ISNULL(@OrdenPedidoWD, 0) + 1
	end
	else set @OrdenPedidoWD = 0

	UPDATE dbo.PedidoWebDetalle
	SET	ClienteID = @ClienteID,
		Cantidad = @Cantidad,
		ImporteTotal = @Cantidad*@PrecioUnidad,
		CodigoUsuarioModificacion = @CodigoUsuarioModificacion,
		FechaModificacion = dbo.fnObtenerFechaHoraPais(),
		TipoPedido = CASE WHEN TipoPedido = 'M' THEN 'X' ELSE TipoPedido END,
		EsSugerido = @EsSugerido,
		OrdenPedidoWD = case when @OrdenPedidoWD > 0 then @OrdenPedidoWD else OrdenPedidoWD end,
		--OrigenPedidoWeb = @OrigenPedidoWeb,
		EsBackOrder = CASE WHEN ISNULL(EsBackOrder,0) = 1 THEN 1 ELSE 0 END,
		AceptoBackOrder = CASE WHEN ISNULL(AceptoBackOrder,0) = 1 THEN 1 ELSE 0 END
	WHERE
		CampaniaID = @CampaniaID
		AND	PedidoID = @PedidoID
		AND	PedidoDetalleID = @PedidoDetalleID;
END

GO

USE BelcorpChile
GO

GO

ALTER PROCEDURE [dbo].[UpdPedidoWebDetalle_SB2]
	@CampaniaID INT,
	@PedidoID INT,
	@PedidoDetalleID SMALLINT,
	@Cantidad INT,
	@PrecioUnidad MONEY,
	@ClienteID SMALLINT,
	@CodigoUsuarioModificacion varchar(25) = null,
	@EsSugerido bit,
	@OrdenPedidoWD int = 0,
	@OrigenPedidoWeb int = 0
AS
BEGIN	
	if @OrdenPedidoWD = 1
	begin		
		SELECT @OrdenPedidoWD = max(ISNULL(OrdenPedidoWD,0))
		FROM dbo.PedidoWebDetalle 
		WHERE 
			CampaniaID = @CampaniaID
			AND PedidoID = @PedidoID

		set @OrdenPedidoWD = ISNULL(@OrdenPedidoWD, 0) + 1
	end
	else set @OrdenPedidoWD = 0

	UPDATE dbo.PedidoWebDetalle
	SET	ClienteID = @ClienteID,
		Cantidad = @Cantidad,
		ImporteTotal = @Cantidad*@PrecioUnidad,
		CodigoUsuarioModificacion = @CodigoUsuarioModificacion,
		FechaModificacion = dbo.fnObtenerFechaHoraPais(),
		TipoPedido = CASE WHEN TipoPedido = 'M' THEN 'X' ELSE TipoPedido END,
		EsSugerido = @EsSugerido,
		OrdenPedidoWD = case when @OrdenPedidoWD > 0 then @OrdenPedidoWD else OrdenPedidoWD end,
		--OrigenPedidoWeb = @OrigenPedidoWeb,
		EsBackOrder = CASE WHEN ISNULL(EsBackOrder,0) = 1 THEN 1 ELSE 0 END,
		AceptoBackOrder = CASE WHEN ISNULL(AceptoBackOrder,0) = 1 THEN 1 ELSE 0 END
	WHERE
		CampaniaID = @CampaniaID
		AND	PedidoID = @PedidoID
		AND	PedidoDetalleID = @PedidoDetalleID;
END

GO

USE BelcorpBolivia
GO

GO

ALTER PROCEDURE [dbo].[UpdPedidoWebDetalle_SB2]
	@CampaniaID INT,
	@PedidoID INT,
	@PedidoDetalleID SMALLINT,
	@Cantidad INT,
	@PrecioUnidad MONEY,
	@ClienteID SMALLINT,
	@CodigoUsuarioModificacion varchar(25) = null,
	@EsSugerido bit,
	@OrdenPedidoWD int = 0,
	@OrigenPedidoWeb int = 0
AS
BEGIN	
	if @OrdenPedidoWD = 1
	begin		
		SELECT @OrdenPedidoWD = max(ISNULL(OrdenPedidoWD,0))
		FROM dbo.PedidoWebDetalle 
		WHERE 
			CampaniaID = @CampaniaID
			AND PedidoID = @PedidoID

		set @OrdenPedidoWD = ISNULL(@OrdenPedidoWD, 0) + 1
	end
	else set @OrdenPedidoWD = 0

	UPDATE dbo.PedidoWebDetalle
	SET	ClienteID = @ClienteID,
		Cantidad = @Cantidad,
		ImporteTotal = @Cantidad*@PrecioUnidad,
		CodigoUsuarioModificacion = @CodigoUsuarioModificacion,
		FechaModificacion = dbo.fnObtenerFechaHoraPais(),
		TipoPedido = CASE WHEN TipoPedido = 'M' THEN 'X' ELSE TipoPedido END,
		EsSugerido = @EsSugerido,
		OrdenPedidoWD = case when @OrdenPedidoWD > 0 then @OrdenPedidoWD else OrdenPedidoWD end,
		--OrigenPedidoWeb = @OrigenPedidoWeb,
		EsBackOrder = CASE WHEN ISNULL(EsBackOrder,0) = 1 THEN 1 ELSE 0 END,
		AceptoBackOrder = CASE WHEN ISNULL(AceptoBackOrder,0) = 1 THEN 1 ELSE 0 END
	WHERE
		CampaniaID = @CampaniaID
		AND	PedidoID = @PedidoID
		AND	PedidoDetalleID = @PedidoDetalleID;
END

GO

