USE BelcorpBolivia
GO
ALTER PROCEDURE GPR.GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado
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
		IIF(U.EmailActivo = 1, U.EMail, ''),
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

USE BelcorpChile
GO
ALTER PROCEDURE GPR.GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado
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
		IIF(U.EmailActivo = 1, U.EMail, ''),
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

USE BelcorpCostaRica
GO
ALTER PROCEDURE GPR.GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado
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
		IIF(U.EmailActivo = 1, U.EMail, ''),
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

USE BelcorpDominicana
GO
ALTER PROCEDURE GPR.GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado
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
		IIF(U.EmailActivo = 1, U.EMail, ''),
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

USE BelcorpEcuador
GO
ALTER PROCEDURE GPR.GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado
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
		IIF(U.EmailActivo = 1, U.EMail, ''),
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

USE BelcorpGuatemala
GO
ALTER PROCEDURE GPR.GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado
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
		IIF(U.EmailActivo = 1, U.EMail, ''),
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

USE BelcorpPanama
GO
ALTER PROCEDURE GPR.GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado
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
		IIF(U.EmailActivo = 1, U.EMail, ''),
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

USE BelcorpPuertoRico
GO
ALTER PROCEDURE GPR.GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado
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
		IIF(U.EmailActivo = 1, U.EMail, ''),
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

USE BelcorpSalvador
GO
ALTER PROCEDURE GPR.GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado
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
		IIF(U.EmailActivo = 1, U.EMail, ''),
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

USE BelcorpVenezuela
GO
ALTER PROCEDURE GPR.GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado
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
		IIF(U.EmailActivo = 1, U.EMail, ''),
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

USE BelcorpColombia
GO
ALTER PROCEDURE GPR.GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado
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
		IIF(U.EmailActivo = 1, U.EMail, ''),
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
ALTER PROCEDURE GPR.GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado
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
		IIF(U.EmailActivo = 1, U.EMail, ''),
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
ALTER PROCEDURE GPR.GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado
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
		IIF(U.EmailActivo = 1, U.EMail, ''),
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