USE BelcorpColombia
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES
	WHERE SPECIFIC_NAME = 'GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado' AND SPECIFIC_SCHEMA = 'GPR' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE GPR.GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado
END
GO
CREATE PROCEDURE GPR.GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado
	@IdProcesoPedidoRechazado BIGINT,
	@ProcesoValidacionPedidoRechazadoId BIGINT,
	@PaisISO VARCHAR(2)
AS
BEGIN
	INSERT INTO GPR.LogGPRValidacion(
		ProcesoValidacionPedidoRechazadoId,
		IdPedidoRechazado,
		DescripcionRechazo,
		ConsultoraID,
		CodigoUsuario,
		NombreCompleto,
		Email,
		ZonaNuevoProl,
		PedidoID,
		SubTotal,
		Descuento,
		EstadoSimplificacionCUV
	)
	SELECT
		@ProcesoValidacionPedidoRechazadoId,
		PR.IdPedidoRechazado,
		MR.Descripcion,
		C.ConsultoraID,
		U.CodigoUsuario,
		U.Nombre,
		U.EMail,
		ISNULL((
			SELECT TOP 1 1
			FROM ConfiguracionValidacionNuevoPROL CVNP WITH(NOLOCK)
			WHERE CVNP.ZonaId = C.ZonaId
		),0),
		PW.PedidoID,
		PW.ImporteTotal,
		PW.DescuentoProl,
		ISNULL((
			SELECT TOP 1 EstadoSimplificacionCUV
			FROM Pais
			WHERE CodigoISO = @PaisISO
		), 0)
	FROM GPR.PedidoRechazado PR
	INNER JOIN GPR.MotivoRechazo MR WITH(NOLOCK) ON PR.MotivoRechazo = MR.Codigo AND MR.RequiereGestion = 1
	LEFT JOIN ods.Consultora C WITH(NOLOCK) ON C.Codigo =  PR.CodigoConsultora
	LEFT JOIN Usuario U WITH(NOLOCK) ON U.CodigoConsultora =  PR.CodigoConsultora
	LEFT JOIN PedidoWeb PW WITH(NOLOCK) ON PW.CampaniaID = PR.Campania AND PW.ConsultoraID = C.ConsultoraID
	WHERE PR.IdProcesoPedidoRechazado = @IdProcesoPedidoRechazado AND PR.Procesado = 0;
		
	SELECT
		LGPRV.LogGPRValidacionId,
		LGPRV.IdPedidoRechazado,
		LGPRV.DescripcionRechazo, --Temp
		PR.Campania,
		LGPRV.ConsultoraID,
		PR.CodigoConsultora,
		LGPRV.CodigoUsuario,
		LGPRV.NombreCompleto, --Temp
		LGPRV.Email,
		LGPRV.ZonaNuevoProl,
		LGPRV.PedidoID,
		LGPRV.SubTotal, --Temp
		LGPRV.Descuento, --Temp
		LGPRV.EstadoSimplificacionCUV, --Temp
		MR.CodigoSomosBelcorp AS CodigoRechazoSomosBelcorp
	FROM GPR.LogGPRValidacion LGPRV
	INNER JOIN GPR.PedidoRechazado PR ON LGPRV.IdPedidoRechazado = PR.IdPedidoRechazado
	INNER JOIN GPR.MotivoRechazo MR WITH(NOLOCK) ON PR.MotivoRechazo = MR.Codigo AND MR.RequiereGestion = 1
	WHERE LGPRV.ProcesoValidacionPedidoRechazadoId = @ProcesoValidacionPedidoRechazadoId;
END
GO
/*end*/

USE BelcorpMexico
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES
	WHERE SPECIFIC_NAME = 'GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado' AND SPECIFIC_SCHEMA = 'GPR' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE GPR.GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado
END
GO
CREATE PROCEDURE GPR.GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado
	@IdProcesoPedidoRechazado BIGINT,
	@ProcesoValidacionPedidoRechazadoId BIGINT,
	@PaisISO VARCHAR(2)
AS
BEGIN
	INSERT INTO GPR.LogGPRValidacion(
		ProcesoValidacionPedidoRechazadoId,
		IdPedidoRechazado,
		DescripcionRechazo,
		ConsultoraID,
		CodigoUsuario,
		NombreCompleto,
		Email,
		ZonaNuevoProl,
		PedidoID,
		SubTotal,
		Descuento,
		EstadoSimplificacionCUV
	)
	SELECT
		@ProcesoValidacionPedidoRechazadoId,
		PR.IdPedidoRechazado,
		MR.Descripcion,
		C.ConsultoraID,
		U.CodigoUsuario,
		U.Nombre,
		U.EMail,
		ISNULL((
			SELECT TOP 1 1
			FROM ConfiguracionValidacionNuevoPROL CVNP WITH(NOLOCK)
			WHERE CVNP.ZonaId = C.ZonaId
		),0),
		PW.PedidoID,
		PW.ImporteTotal,
		PW.DescuentoProl,
		ISNULL((
			SELECT TOP 1 EstadoSimplificacionCUV
			FROM Pais
			WHERE CodigoISO = @PaisISO
		), 0)
	FROM GPR.PedidoRechazado PR
	INNER JOIN GPR.MotivoRechazo MR WITH(NOLOCK) ON PR.MotivoRechazo = MR.Codigo AND MR.RequiereGestion = 1
	LEFT JOIN ods.Consultora C WITH(NOLOCK) ON C.Codigo =  PR.CodigoConsultora
	LEFT JOIN Usuario U WITH(NOLOCK) ON U.CodigoConsultora =  PR.CodigoConsultora
	LEFT JOIN PedidoWeb PW WITH(NOLOCK) ON PW.CampaniaID = PR.Campania AND PW.ConsultoraID = C.ConsultoraID
	WHERE PR.IdProcesoPedidoRechazado = @IdProcesoPedidoRechazado AND PR.Procesado = 0;
		
	SELECT
		LGPRV.LogGPRValidacionId,
		LGPRV.IdPedidoRechazado,
		LGPRV.DescripcionRechazo, --Temp
		PR.Campania,
		LGPRV.ConsultoraID,
		PR.CodigoConsultora,
		LGPRV.CodigoUsuario,
		LGPRV.NombreCompleto, --Temp
		LGPRV.Email,
		LGPRV.ZonaNuevoProl,
		LGPRV.PedidoID,
		LGPRV.SubTotal, --Temp
		LGPRV.Descuento, --Temp
		LGPRV.EstadoSimplificacionCUV, --Temp
		MR.CodigoSomosBelcorp AS CodigoRechazoSomosBelcorp
	FROM GPR.LogGPRValidacion LGPRV
	INNER JOIN GPR.PedidoRechazado PR ON LGPRV.IdPedidoRechazado = PR.IdPedidoRechazado
	INNER JOIN GPR.MotivoRechazo MR WITH(NOLOCK) ON PR.MotivoRechazo = MR.Codigo AND MR.RequiereGestion = 1
	WHERE LGPRV.ProcesoValidacionPedidoRechazadoId = @ProcesoValidacionPedidoRechazadoId;
END
GO
/*end*/

USE BelcorpPeru
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES
	WHERE SPECIFIC_NAME = 'GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado' AND SPECIFIC_SCHEMA = 'GPR' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE GPR.GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado
END
GO
CREATE PROCEDURE GPR.GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado
	@IdProcesoPedidoRechazado BIGINT,
	@ProcesoValidacionPedidoRechazadoId BIGINT,
	@PaisISO VARCHAR(2)
AS
BEGIN
	INSERT INTO GPR.LogGPRValidacion(
		ProcesoValidacionPedidoRechazadoId,
		IdPedidoRechazado,
		DescripcionRechazo,
		ConsultoraID,
		CodigoUsuario,
		NombreCompleto,
		Email,
		ZonaNuevoProl,
		PedidoID,
		SubTotal,
		Descuento,
		EstadoSimplificacionCUV
	)
	SELECT
		@ProcesoValidacionPedidoRechazadoId,
		PR.IdPedidoRechazado,
		MR.Descripcion,
		C.ConsultoraID,
		U.CodigoUsuario,
		U.Nombre,
		U.EMail,
		ISNULL((
			SELECT TOP 1 1
			FROM ConfiguracionValidacionNuevoPROL CVNP WITH(NOLOCK)
			WHERE CVNP.ZonaId = C.ZonaId
		),0),
		PW.PedidoID,
		PW.ImporteTotal,
		PW.DescuentoProl,
		ISNULL((
			SELECT TOP 1 EstadoSimplificacionCUV
			FROM Pais
			WHERE CodigoISO = @PaisISO
		), 0)
	FROM GPR.PedidoRechazado PR
	INNER JOIN GPR.MotivoRechazo MR WITH(NOLOCK) ON PR.MotivoRechazo = MR.Codigo AND MR.RequiereGestion = 1
	LEFT JOIN ods.Consultora C WITH(NOLOCK) ON C.Codigo =  PR.CodigoConsultora
	LEFT JOIN Usuario U WITH(NOLOCK) ON U.CodigoConsultora =  PR.CodigoConsultora
	LEFT JOIN PedidoWeb PW WITH(NOLOCK) ON PW.CampaniaID = PR.Campania AND PW.ConsultoraID = C.ConsultoraID
	WHERE PR.IdProcesoPedidoRechazado = @IdProcesoPedidoRechazado AND PR.Procesado = 0;
		
	SELECT
		LGPRV.LogGPRValidacionId,
		LGPRV.IdPedidoRechazado,
		LGPRV.DescripcionRechazo, --Temp
		PR.Campania,
		LGPRV.ConsultoraID,
		PR.CodigoConsultora,
		LGPRV.CodigoUsuario,
		LGPRV.NombreCompleto, --Temp
		LGPRV.Email,
		LGPRV.ZonaNuevoProl,
		LGPRV.PedidoID,
		LGPRV.SubTotal, --Temp
		LGPRV.Descuento, --Temp
		LGPRV.EstadoSimplificacionCUV, --Temp
		MR.CodigoSomosBelcorp AS CodigoRechazoSomosBelcorp
	FROM GPR.LogGPRValidacion LGPRV
	INNER JOIN GPR.PedidoRechazado PR ON LGPRV.IdPedidoRechazado = PR.IdPedidoRechazado
	INNER JOIN GPR.MotivoRechazo MR WITH(NOLOCK) ON PR.MotivoRechazo = MR.Codigo AND MR.RequiereGestion = 1
	WHERE LGPRV.ProcesoValidacionPedidoRechazadoId = @ProcesoValidacionPedidoRechazadoId;
END
GO