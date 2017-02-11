USE BelcorpPeru
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado
GO

--------------------------------------------------------------------
CREATE PROCEDURE GPR.GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado
	@IdProcesoPedidoRechazado BIGINT,
	@ProcesoValidacionPedidoRechazadoId BIGINT,
	@PaisISO VARCHAR(2)
AS
BEGIN


	INSERT INTO GPR.LogGPRValidacion(
		ProcesoValidacionPedidoRechazadoId,
		IdProcesoPedidoRechazado,
		DescripcionRechazo,
		ConsultoraID,
		CodigoConsultora,
		Campania,
		CodigoUsuario,
		NombreCompleto,
		Email,
		ZonaNuevoProl,
		PedidoID,
		SubTotal,
		Descuento,
		EstadoSimplificacionCUV,
		MontoMinimoPedido,
		MontoMaximoPedido
	)
	SELECT DISTINCT 
		@ProcesoValidacionPedidoRechazadoId,
		PR.IdProcesoPedidoRechazado,
		STUFF(
		(
			SELECT ',' + PR1.MotivoRechazo
			FROM GPR.PedidoRechazado AS PR1			
			WHERE
				C.Codigo =  PR1.CodigoConsultora
				AND U.CodigoConsultora =  PR1.CodigoConsultora
				AND PR1.IdProcesoPedidoRechazado = @IdProcesoPedidoRechazado
			FOR xml path('')),1,1,''
		),
		C.ConsultoraID,
		PR.CodigoConsultora,
		PR.Campania,
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
		), 0),
		C.MontoMinimoPedido,
		C.MontoMaximoPedido
	FROM GPR.PedidoRechazado PR
	INNER JOIN GPR.MotivoRechazo MR WITH(NOLOCK) ON PR.MotivoRechazo = MR.Codigo AND MR.RequiereGestion = 1
	LEFT JOIN ods.Consultora C WITH(NOLOCK) ON C.Codigo =  PR.CodigoConsultora
	LEFT JOIN Usuario U WITH(NOLOCK) ON U.CodigoConsultora =  PR.CodigoConsultora
	LEFT JOIN PedidoWeb PW WITH(NOLOCK) ON PW.CampaniaID = PR.Campania AND PW.ConsultoraID = C.ConsultoraID
	WHERE PR.IdProcesoPedidoRechazado = @IdProcesoPedidoRechazado AND PR.Procesado = 0;
		
	SELECT DISTINCT
		LGPRV.LogGPRValidacionId,
		LGPRV.IdProcesoPedidoRechazado,
		LGPRV.DescripcionRechazo, --Temp
		LGPRV.Campania,
		LGPRV.ConsultoraID,
		LGPRV.CodigoConsultora,
		LGPRV.CodigoUsuario,
		LGPRV.NombreCompleto, --Temp
		LGPRV.Email,
		LGPRV.ZonaNuevoProl,
		LGPRV.PedidoID,
		LGPRV.SubTotal, --Temp
		LGPRV.Descuento, --Temp
		LGPRV.EstadoSimplificacionCUV, --Temp
		LGPRV.Valor,
		P.Simbolo,
		LGPRV.MontoMinimoPedido,
		LGPRV.MontoMaximoPedido
	FROM GPR.LogGPRValidacion LGPRV
	INNER JOIN dbo.Usuario U WITH(NOLOCK) ON LGPRV.CodigoUsuario = U.CodigoUsuario
	INNER JOIN [dbo].[Pais] P (nolock) ON U.PaisID = P.PaisID
	WHERE LGPRV.ProcesoValidacionPedidoRechazadoId = @ProcesoValidacionPedidoRechazadoId;
END


GO

USE BelcorpMexico
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado
GO

--------------------------------------------------------------------
CREATE PROCEDURE GPR.GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado
	@IdProcesoPedidoRechazado BIGINT,
	@ProcesoValidacionPedidoRechazadoId BIGINT,
	@PaisISO VARCHAR(2)
AS
BEGIN


	INSERT INTO GPR.LogGPRValidacion(
		ProcesoValidacionPedidoRechazadoId,
		IdProcesoPedidoRechazado,
		DescripcionRechazo,
		ConsultoraID,
		CodigoConsultora,
		Campania,
		CodigoUsuario,
		NombreCompleto,
		Email,
		ZonaNuevoProl,
		PedidoID,
		SubTotal,
		Descuento,
		EstadoSimplificacionCUV,
		MontoMinimoPedido,
		MontoMaximoPedido
	)
	SELECT DISTINCT 
		@ProcesoValidacionPedidoRechazadoId,
		PR.IdProcesoPedidoRechazado,
		STUFF(
		(
			SELECT ',' + PR1.MotivoRechazo
			FROM GPR.PedidoRechazado AS PR1			
			WHERE
				C.Codigo =  PR1.CodigoConsultora
				AND U.CodigoConsultora =  PR1.CodigoConsultora
				AND PR1.IdProcesoPedidoRechazado = @IdProcesoPedidoRechazado
			FOR xml path('')),1,1,''
		),
		C.ConsultoraID,
		PR.CodigoConsultora,
		PR.Campania,
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
		), 0),
		C.MontoMinimoPedido,
		C.MontoMaximoPedido
	FROM GPR.PedidoRechazado PR
	INNER JOIN GPR.MotivoRechazo MR WITH(NOLOCK) ON PR.MotivoRechazo = MR.Codigo AND MR.RequiereGestion = 1
	LEFT JOIN ods.Consultora C WITH(NOLOCK) ON C.Codigo =  PR.CodigoConsultora
	LEFT JOIN Usuario U WITH(NOLOCK) ON U.CodigoConsultora =  PR.CodigoConsultora
	LEFT JOIN PedidoWeb PW WITH(NOLOCK) ON PW.CampaniaID = PR.Campania AND PW.ConsultoraID = C.ConsultoraID
	WHERE PR.IdProcesoPedidoRechazado = @IdProcesoPedidoRechazado AND PR.Procesado = 0;
		
	SELECT DISTINCT
		LGPRV.LogGPRValidacionId,
		LGPRV.IdProcesoPedidoRechazado,
		LGPRV.DescripcionRechazo, --Temp
		LGPRV.Campania,
		LGPRV.ConsultoraID,
		LGPRV.CodigoConsultora,
		LGPRV.CodigoUsuario,
		LGPRV.NombreCompleto, --Temp
		LGPRV.Email,
		LGPRV.ZonaNuevoProl,
		LGPRV.PedidoID,
		LGPRV.SubTotal, --Temp
		LGPRV.Descuento, --Temp
		LGPRV.EstadoSimplificacionCUV, --Temp
		LGPRV.Valor,
		P.Simbolo,
		LGPRV.MontoMinimoPedido,
		LGPRV.MontoMaximoPedido
	FROM GPR.LogGPRValidacion LGPRV
	INNER JOIN dbo.Usuario U WITH(NOLOCK) ON LGPRV.CodigoUsuario = U.CodigoUsuario
	INNER JOIN [dbo].[Pais] P (nolock) ON U.PaisID = P.PaisID
	WHERE LGPRV.ProcesoValidacionPedidoRechazadoId = @ProcesoValidacionPedidoRechazadoId;
END


GO

USE BelcorpColombia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado
GO

--------------------------------------------------------------------
CREATE PROCEDURE GPR.GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado
	@IdProcesoPedidoRechazado BIGINT,
	@ProcesoValidacionPedidoRechazadoId BIGINT,
	@PaisISO VARCHAR(2)
AS
BEGIN


	INSERT INTO GPR.LogGPRValidacion(
		ProcesoValidacionPedidoRechazadoId,
		IdProcesoPedidoRechazado,
		DescripcionRechazo,
		ConsultoraID,
		CodigoConsultora,
		Campania,
		CodigoUsuario,
		NombreCompleto,
		Email,
		ZonaNuevoProl,
		PedidoID,
		SubTotal,
		Descuento,
		EstadoSimplificacionCUV,
		MontoMinimoPedido,
		MontoMaximoPedido
	)
	SELECT DISTINCT 
		@ProcesoValidacionPedidoRechazadoId,
		PR.IdProcesoPedidoRechazado,
		STUFF(
		(
			SELECT ',' + PR1.MotivoRechazo
			FROM GPR.PedidoRechazado AS PR1			
			WHERE
				C.Codigo =  PR1.CodigoConsultora
				AND U.CodigoConsultora =  PR1.CodigoConsultora
				AND PR1.IdProcesoPedidoRechazado = @IdProcesoPedidoRechazado
			FOR xml path('')),1,1,''
		),
		C.ConsultoraID,
		PR.CodigoConsultora,
		PR.Campania,
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
		), 0),
		C.MontoMinimoPedido,
		C.MontoMaximoPedido
	FROM GPR.PedidoRechazado PR
	INNER JOIN GPR.MotivoRechazo MR WITH(NOLOCK) ON PR.MotivoRechazo = MR.Codigo AND MR.RequiereGestion = 1
	LEFT JOIN ods.Consultora C WITH(NOLOCK) ON C.Codigo =  PR.CodigoConsultora
	LEFT JOIN Usuario U WITH(NOLOCK) ON U.CodigoConsultora =  PR.CodigoConsultora
	LEFT JOIN PedidoWeb PW WITH(NOLOCK) ON PW.CampaniaID = PR.Campania AND PW.ConsultoraID = C.ConsultoraID
	WHERE PR.IdProcesoPedidoRechazado = @IdProcesoPedidoRechazado AND PR.Procesado = 0;
		
	SELECT DISTINCT
		LGPRV.LogGPRValidacionId,
		LGPRV.IdProcesoPedidoRechazado,
		LGPRV.DescripcionRechazo, --Temp
		LGPRV.Campania,
		LGPRV.ConsultoraID,
		LGPRV.CodigoConsultora,
		LGPRV.CodigoUsuario,
		LGPRV.NombreCompleto, --Temp
		LGPRV.Email,
		LGPRV.ZonaNuevoProl,
		LGPRV.PedidoID,
		LGPRV.SubTotal, --Temp
		LGPRV.Descuento, --Temp
		LGPRV.EstadoSimplificacionCUV, --Temp
		LGPRV.Valor,
		P.Simbolo,
		LGPRV.MontoMinimoPedido,
		LGPRV.MontoMaximoPedido
	FROM GPR.LogGPRValidacion LGPRV
	INNER JOIN dbo.Usuario U WITH(NOLOCK) ON LGPRV.CodigoUsuario = U.CodigoUsuario
	INNER JOIN [dbo].[Pais] P (nolock) ON U.PaisID = P.PaisID
	WHERE LGPRV.ProcesoValidacionPedidoRechazadoId = @ProcesoValidacionPedidoRechazadoId;
END


GO

USE BelcorpVenezuela
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado
GO

--------------------------------------------------------------------
CREATE PROCEDURE GPR.GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado
	@IdProcesoPedidoRechazado BIGINT,
	@ProcesoValidacionPedidoRechazadoId BIGINT,
	@PaisISO VARCHAR(2)
AS
BEGIN


	INSERT INTO GPR.LogGPRValidacion(
		ProcesoValidacionPedidoRechazadoId,
		IdProcesoPedidoRechazado,
		DescripcionRechazo,
		ConsultoraID,
		CodigoConsultora,
		Campania,
		CodigoUsuario,
		NombreCompleto,
		Email,
		ZonaNuevoProl,
		PedidoID,
		SubTotal,
		Descuento,
		EstadoSimplificacionCUV,
		MontoMinimoPedido,
		MontoMaximoPedido
	)
	SELECT DISTINCT 
		@ProcesoValidacionPedidoRechazadoId,
		PR.IdProcesoPedidoRechazado,
		STUFF(
		(
			SELECT ',' + PR1.MotivoRechazo
			FROM GPR.PedidoRechazado AS PR1			
			WHERE
				C.Codigo =  PR1.CodigoConsultora
				AND U.CodigoConsultora =  PR1.CodigoConsultora
				AND PR1.IdProcesoPedidoRechazado = @IdProcesoPedidoRechazado
			FOR xml path('')),1,1,''
		),
		C.ConsultoraID,
		PR.CodigoConsultora,
		PR.Campania,
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
		), 0),
		C.MontoMinimoPedido,
		C.MontoMaximoPedido
	FROM GPR.PedidoRechazado PR
	INNER JOIN GPR.MotivoRechazo MR WITH(NOLOCK) ON PR.MotivoRechazo = MR.Codigo AND MR.RequiereGestion = 1
	LEFT JOIN ods.Consultora C WITH(NOLOCK) ON C.Codigo =  PR.CodigoConsultora
	LEFT JOIN Usuario U WITH(NOLOCK) ON U.CodigoConsultora =  PR.CodigoConsultora
	LEFT JOIN PedidoWeb PW WITH(NOLOCK) ON PW.CampaniaID = PR.Campania AND PW.ConsultoraID = C.ConsultoraID
	WHERE PR.IdProcesoPedidoRechazado = @IdProcesoPedidoRechazado AND PR.Procesado = 0;
		
	SELECT DISTINCT
		LGPRV.LogGPRValidacionId,
		LGPRV.IdProcesoPedidoRechazado,
		LGPRV.DescripcionRechazo, --Temp
		LGPRV.Campania,
		LGPRV.ConsultoraID,
		LGPRV.CodigoConsultora,
		LGPRV.CodigoUsuario,
		LGPRV.NombreCompleto, --Temp
		LGPRV.Email,
		LGPRV.ZonaNuevoProl,
		LGPRV.PedidoID,
		LGPRV.SubTotal, --Temp
		LGPRV.Descuento, --Temp
		LGPRV.EstadoSimplificacionCUV, --Temp
		LGPRV.Valor,
		P.Simbolo,
		LGPRV.MontoMinimoPedido,
		LGPRV.MontoMaximoPedido
	FROM GPR.LogGPRValidacion LGPRV
	INNER JOIN dbo.Usuario U WITH(NOLOCK) ON LGPRV.CodigoUsuario = U.CodigoUsuario
	INNER JOIN [dbo].[Pais] P (nolock) ON U.PaisID = P.PaisID
	WHERE LGPRV.ProcesoValidacionPedidoRechazadoId = @ProcesoValidacionPedidoRechazadoId;
END


GO

USE BelcorpSalvador
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado
GO

--------------------------------------------------------------------
CREATE PROCEDURE GPR.GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado
	@IdProcesoPedidoRechazado BIGINT,
	@ProcesoValidacionPedidoRechazadoId BIGINT,
	@PaisISO VARCHAR(2)
AS
BEGIN


	INSERT INTO GPR.LogGPRValidacion(
		ProcesoValidacionPedidoRechazadoId,
		IdProcesoPedidoRechazado,
		DescripcionRechazo,
		ConsultoraID,
		CodigoConsultora,
		Campania,
		CodigoUsuario,
		NombreCompleto,
		Email,
		ZonaNuevoProl,
		PedidoID,
		SubTotal,
		Descuento,
		EstadoSimplificacionCUV,
		MontoMinimoPedido,
		MontoMaximoPedido
	)
	SELECT DISTINCT 
		@ProcesoValidacionPedidoRechazadoId,
		PR.IdProcesoPedidoRechazado,
		STUFF(
		(
			SELECT ',' + PR1.MotivoRechazo
			FROM GPR.PedidoRechazado AS PR1			
			WHERE
				C.Codigo =  PR1.CodigoConsultora
				AND U.CodigoConsultora =  PR1.CodigoConsultora
				AND PR1.IdProcesoPedidoRechazado = @IdProcesoPedidoRechazado
			FOR xml path('')),1,1,''
		),
		C.ConsultoraID,
		PR.CodigoConsultora,
		PR.Campania,
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
		), 0),
		C.MontoMinimoPedido,
		C.MontoMaximoPedido
	FROM GPR.PedidoRechazado PR
	INNER JOIN GPR.MotivoRechazo MR WITH(NOLOCK) ON PR.MotivoRechazo = MR.Codigo AND MR.RequiereGestion = 1
	LEFT JOIN ods.Consultora C WITH(NOLOCK) ON C.Codigo =  PR.CodigoConsultora
	LEFT JOIN Usuario U WITH(NOLOCK) ON U.CodigoConsultora =  PR.CodigoConsultora
	LEFT JOIN PedidoWeb PW WITH(NOLOCK) ON PW.CampaniaID = PR.Campania AND PW.ConsultoraID = C.ConsultoraID
	WHERE PR.IdProcesoPedidoRechazado = @IdProcesoPedidoRechazado AND PR.Procesado = 0;
		
	SELECT DISTINCT
		LGPRV.LogGPRValidacionId,
		LGPRV.IdProcesoPedidoRechazado,
		LGPRV.DescripcionRechazo, --Temp
		LGPRV.Campania,
		LGPRV.ConsultoraID,
		LGPRV.CodigoConsultora,
		LGPRV.CodigoUsuario,
		LGPRV.NombreCompleto, --Temp
		LGPRV.Email,
		LGPRV.ZonaNuevoProl,
		LGPRV.PedidoID,
		LGPRV.SubTotal, --Temp
		LGPRV.Descuento, --Temp
		LGPRV.EstadoSimplificacionCUV, --Temp
		LGPRV.Valor,
		P.Simbolo,
		LGPRV.MontoMinimoPedido,
		LGPRV.MontoMaximoPedido
	FROM GPR.LogGPRValidacion LGPRV
	INNER JOIN dbo.Usuario U WITH(NOLOCK) ON LGPRV.CodigoUsuario = U.CodigoUsuario
	INNER JOIN [dbo].[Pais] P (nolock) ON U.PaisID = P.PaisID
	WHERE LGPRV.ProcesoValidacionPedidoRechazadoId = @ProcesoValidacionPedidoRechazadoId;
END


GO

USE BelcorpPuertoRico
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado
GO

--------------------------------------------------------------------
CREATE PROCEDURE GPR.GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado
	@IdProcesoPedidoRechazado BIGINT,
	@ProcesoValidacionPedidoRechazadoId BIGINT,
	@PaisISO VARCHAR(2)
AS
BEGIN


	INSERT INTO GPR.LogGPRValidacion(
		ProcesoValidacionPedidoRechazadoId,
		IdProcesoPedidoRechazado,
		DescripcionRechazo,
		ConsultoraID,
		CodigoConsultora,
		Campania,
		CodigoUsuario,
		NombreCompleto,
		Email,
		ZonaNuevoProl,
		PedidoID,
		SubTotal,
		Descuento,
		EstadoSimplificacionCUV,
		MontoMinimoPedido,
		MontoMaximoPedido
	)
	SELECT DISTINCT 
		@ProcesoValidacionPedidoRechazadoId,
		PR.IdProcesoPedidoRechazado,
		STUFF(
		(
			SELECT ',' + PR1.MotivoRechazo
			FROM GPR.PedidoRechazado AS PR1			
			WHERE
				C.Codigo =  PR1.CodigoConsultora
				AND U.CodigoConsultora =  PR1.CodigoConsultora
				AND PR1.IdProcesoPedidoRechazado = @IdProcesoPedidoRechazado
			FOR xml path('')),1,1,''
		),
		C.ConsultoraID,
		PR.CodigoConsultora,
		PR.Campania,
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
		), 0),
		C.MontoMinimoPedido,
		C.MontoMaximoPedido
	FROM GPR.PedidoRechazado PR
	INNER JOIN GPR.MotivoRechazo MR WITH(NOLOCK) ON PR.MotivoRechazo = MR.Codigo AND MR.RequiereGestion = 1
	LEFT JOIN ods.Consultora C WITH(NOLOCK) ON C.Codigo =  PR.CodigoConsultora
	LEFT JOIN Usuario U WITH(NOLOCK) ON U.CodigoConsultora =  PR.CodigoConsultora
	LEFT JOIN PedidoWeb PW WITH(NOLOCK) ON PW.CampaniaID = PR.Campania AND PW.ConsultoraID = C.ConsultoraID
	WHERE PR.IdProcesoPedidoRechazado = @IdProcesoPedidoRechazado AND PR.Procesado = 0;
		
	SELECT DISTINCT
		LGPRV.LogGPRValidacionId,
		LGPRV.IdProcesoPedidoRechazado,
		LGPRV.DescripcionRechazo, --Temp
		LGPRV.Campania,
		LGPRV.ConsultoraID,
		LGPRV.CodigoConsultora,
		LGPRV.CodigoUsuario,
		LGPRV.NombreCompleto, --Temp
		LGPRV.Email,
		LGPRV.ZonaNuevoProl,
		LGPRV.PedidoID,
		LGPRV.SubTotal, --Temp
		LGPRV.Descuento, --Temp
		LGPRV.EstadoSimplificacionCUV, --Temp
		LGPRV.Valor,
		P.Simbolo,
		LGPRV.MontoMinimoPedido,
		LGPRV.MontoMaximoPedido
	FROM GPR.LogGPRValidacion LGPRV
	INNER JOIN dbo.Usuario U WITH(NOLOCK) ON LGPRV.CodigoUsuario = U.CodigoUsuario
	INNER JOIN [dbo].[Pais] P (nolock) ON U.PaisID = P.PaisID
	WHERE LGPRV.ProcesoValidacionPedidoRechazadoId = @ProcesoValidacionPedidoRechazadoId;
END


GO

USE BelcorpPanama
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado
GO

--------------------------------------------------------------------
CREATE PROCEDURE GPR.GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado
	@IdProcesoPedidoRechazado BIGINT,
	@ProcesoValidacionPedidoRechazadoId BIGINT,
	@PaisISO VARCHAR(2)
AS
BEGIN


	INSERT INTO GPR.LogGPRValidacion(
		ProcesoValidacionPedidoRechazadoId,
		IdProcesoPedidoRechazado,
		DescripcionRechazo,
		ConsultoraID,
		CodigoConsultora,
		Campania,
		CodigoUsuario,
		NombreCompleto,
		Email,
		ZonaNuevoProl,
		PedidoID,
		SubTotal,
		Descuento,
		EstadoSimplificacionCUV,
		MontoMinimoPedido,
		MontoMaximoPedido
	)
	SELECT DISTINCT 
		@ProcesoValidacionPedidoRechazadoId,
		PR.IdProcesoPedidoRechazado,
		STUFF(
		(
			SELECT ',' + PR1.MotivoRechazo
			FROM GPR.PedidoRechazado AS PR1			
			WHERE
				C.Codigo =  PR1.CodigoConsultora
				AND U.CodigoConsultora =  PR1.CodigoConsultora
				AND PR1.IdProcesoPedidoRechazado = @IdProcesoPedidoRechazado
			FOR xml path('')),1,1,''
		),
		C.ConsultoraID,
		PR.CodigoConsultora,
		PR.Campania,
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
		), 0),
		C.MontoMinimoPedido,
		C.MontoMaximoPedido
	FROM GPR.PedidoRechazado PR
	INNER JOIN GPR.MotivoRechazo MR WITH(NOLOCK) ON PR.MotivoRechazo = MR.Codigo AND MR.RequiereGestion = 1
	LEFT JOIN ods.Consultora C WITH(NOLOCK) ON C.Codigo =  PR.CodigoConsultora
	LEFT JOIN Usuario U WITH(NOLOCK) ON U.CodigoConsultora =  PR.CodigoConsultora
	LEFT JOIN PedidoWeb PW WITH(NOLOCK) ON PW.CampaniaID = PR.Campania AND PW.ConsultoraID = C.ConsultoraID
	WHERE PR.IdProcesoPedidoRechazado = @IdProcesoPedidoRechazado AND PR.Procesado = 0;
		
	SELECT DISTINCT
		LGPRV.LogGPRValidacionId,
		LGPRV.IdProcesoPedidoRechazado,
		LGPRV.DescripcionRechazo, --Temp
		LGPRV.Campania,
		LGPRV.ConsultoraID,
		LGPRV.CodigoConsultora,
		LGPRV.CodigoUsuario,
		LGPRV.NombreCompleto, --Temp
		LGPRV.Email,
		LGPRV.ZonaNuevoProl,
		LGPRV.PedidoID,
		LGPRV.SubTotal, --Temp
		LGPRV.Descuento, --Temp
		LGPRV.EstadoSimplificacionCUV, --Temp
		LGPRV.Valor,
		P.Simbolo,
		LGPRV.MontoMinimoPedido,
		LGPRV.MontoMaximoPedido
	FROM GPR.LogGPRValidacion LGPRV
	INNER JOIN dbo.Usuario U WITH(NOLOCK) ON LGPRV.CodigoUsuario = U.CodigoUsuario
	INNER JOIN [dbo].[Pais] P (nolock) ON U.PaisID = P.PaisID
	WHERE LGPRV.ProcesoValidacionPedidoRechazadoId = @ProcesoValidacionPedidoRechazadoId;
END


GO

USE BelcorpGuatemala
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado
GO

--------------------------------------------------------------------
CREATE PROCEDURE GPR.GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado
	@IdProcesoPedidoRechazado BIGINT,
	@ProcesoValidacionPedidoRechazadoId BIGINT,
	@PaisISO VARCHAR(2)
AS
BEGIN


	INSERT INTO GPR.LogGPRValidacion(
		ProcesoValidacionPedidoRechazadoId,
		IdProcesoPedidoRechazado,
		DescripcionRechazo,
		ConsultoraID,
		CodigoConsultora,
		Campania,
		CodigoUsuario,
		NombreCompleto,
		Email,
		ZonaNuevoProl,
		PedidoID,
		SubTotal,
		Descuento,
		EstadoSimplificacionCUV,
		MontoMinimoPedido,
		MontoMaximoPedido
	)
	SELECT DISTINCT 
		@ProcesoValidacionPedidoRechazadoId,
		PR.IdProcesoPedidoRechazado,
		STUFF(
		(
			SELECT ',' + PR1.MotivoRechazo
			FROM GPR.PedidoRechazado AS PR1			
			WHERE
				C.Codigo =  PR1.CodigoConsultora
				AND U.CodigoConsultora =  PR1.CodigoConsultora
				AND PR1.IdProcesoPedidoRechazado = @IdProcesoPedidoRechazado
			FOR xml path('')),1,1,''
		),
		C.ConsultoraID,
		PR.CodigoConsultora,
		PR.Campania,
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
		), 0),
		C.MontoMinimoPedido,
		C.MontoMaximoPedido
	FROM GPR.PedidoRechazado PR
	INNER JOIN GPR.MotivoRechazo MR WITH(NOLOCK) ON PR.MotivoRechazo = MR.Codigo AND MR.RequiereGestion = 1
	LEFT JOIN ods.Consultora C WITH(NOLOCK) ON C.Codigo =  PR.CodigoConsultora
	LEFT JOIN Usuario U WITH(NOLOCK) ON U.CodigoConsultora =  PR.CodigoConsultora
	LEFT JOIN PedidoWeb PW WITH(NOLOCK) ON PW.CampaniaID = PR.Campania AND PW.ConsultoraID = C.ConsultoraID
	WHERE PR.IdProcesoPedidoRechazado = @IdProcesoPedidoRechazado AND PR.Procesado = 0;
		
	SELECT DISTINCT
		LGPRV.LogGPRValidacionId,
		LGPRV.IdProcesoPedidoRechazado,
		LGPRV.DescripcionRechazo, --Temp
		LGPRV.Campania,
		LGPRV.ConsultoraID,
		LGPRV.CodigoConsultora,
		LGPRV.CodigoUsuario,
		LGPRV.NombreCompleto, --Temp
		LGPRV.Email,
		LGPRV.ZonaNuevoProl,
		LGPRV.PedidoID,
		LGPRV.SubTotal, --Temp
		LGPRV.Descuento, --Temp
		LGPRV.EstadoSimplificacionCUV, --Temp
		LGPRV.Valor,
		P.Simbolo,
		LGPRV.MontoMinimoPedido,
		LGPRV.MontoMaximoPedido
	FROM GPR.LogGPRValidacion LGPRV
	INNER JOIN dbo.Usuario U WITH(NOLOCK) ON LGPRV.CodigoUsuario = U.CodigoUsuario
	INNER JOIN [dbo].[Pais] P (nolock) ON U.PaisID = P.PaisID
	WHERE LGPRV.ProcesoValidacionPedidoRechazadoId = @ProcesoValidacionPedidoRechazadoId;
END


GO

USE BelcorpEcuador
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado
GO

--------------------------------------------------------------------
CREATE PROCEDURE GPR.GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado
	@IdProcesoPedidoRechazado BIGINT,
	@ProcesoValidacionPedidoRechazadoId BIGINT,
	@PaisISO VARCHAR(2)
AS
BEGIN


	INSERT INTO GPR.LogGPRValidacion(
		ProcesoValidacionPedidoRechazadoId,
		IdProcesoPedidoRechazado,
		DescripcionRechazo,
		ConsultoraID,
		CodigoConsultora,
		Campania,
		CodigoUsuario,
		NombreCompleto,
		Email,
		ZonaNuevoProl,
		PedidoID,
		SubTotal,
		Descuento,
		EstadoSimplificacionCUV,
		MontoMinimoPedido,
		MontoMaximoPedido
	)
	SELECT DISTINCT 
		@ProcesoValidacionPedidoRechazadoId,
		PR.IdProcesoPedidoRechazado,
		STUFF(
		(
			SELECT ',' + PR1.MotivoRechazo
			FROM GPR.PedidoRechazado AS PR1			
			WHERE
				C.Codigo =  PR1.CodigoConsultora
				AND U.CodigoConsultora =  PR1.CodigoConsultora
				AND PR1.IdProcesoPedidoRechazado = @IdProcesoPedidoRechazado
			FOR xml path('')),1,1,''
		),
		C.ConsultoraID,
		PR.CodigoConsultora,
		PR.Campania,
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
		), 0),
		C.MontoMinimoPedido,
		C.MontoMaximoPedido
	FROM GPR.PedidoRechazado PR
	INNER JOIN GPR.MotivoRechazo MR WITH(NOLOCK) ON PR.MotivoRechazo = MR.Codigo AND MR.RequiereGestion = 1
	LEFT JOIN ods.Consultora C WITH(NOLOCK) ON C.Codigo =  PR.CodigoConsultora
	LEFT JOIN Usuario U WITH(NOLOCK) ON U.CodigoConsultora =  PR.CodigoConsultora
	LEFT JOIN PedidoWeb PW WITH(NOLOCK) ON PW.CampaniaID = PR.Campania AND PW.ConsultoraID = C.ConsultoraID
	WHERE PR.IdProcesoPedidoRechazado = @IdProcesoPedidoRechazado AND PR.Procesado = 0;
		
	SELECT DISTINCT
		LGPRV.LogGPRValidacionId,
		LGPRV.IdProcesoPedidoRechazado,
		LGPRV.DescripcionRechazo, --Temp
		LGPRV.Campania,
		LGPRV.ConsultoraID,
		LGPRV.CodigoConsultora,
		LGPRV.CodigoUsuario,
		LGPRV.NombreCompleto, --Temp
		LGPRV.Email,
		LGPRV.ZonaNuevoProl,
		LGPRV.PedidoID,
		LGPRV.SubTotal, --Temp
		LGPRV.Descuento, --Temp
		LGPRV.EstadoSimplificacionCUV, --Temp
		LGPRV.Valor,
		P.Simbolo,
		LGPRV.MontoMinimoPedido,
		LGPRV.MontoMaximoPedido
	FROM GPR.LogGPRValidacion LGPRV
	INNER JOIN dbo.Usuario U WITH(NOLOCK) ON LGPRV.CodigoUsuario = U.CodigoUsuario
	INNER JOIN [dbo].[Pais] P (nolock) ON U.PaisID = P.PaisID
	WHERE LGPRV.ProcesoValidacionPedidoRechazadoId = @ProcesoValidacionPedidoRechazadoId;
END


GO

USE BelcorpDominicana
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado
GO

--------------------------------------------------------------------
CREATE PROCEDURE GPR.GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado
	@IdProcesoPedidoRechazado BIGINT,
	@ProcesoValidacionPedidoRechazadoId BIGINT,
	@PaisISO VARCHAR(2)
AS
BEGIN


	INSERT INTO GPR.LogGPRValidacion(
		ProcesoValidacionPedidoRechazadoId,
		IdProcesoPedidoRechazado,
		DescripcionRechazo,
		ConsultoraID,
		CodigoConsultora,
		Campania,
		CodigoUsuario,
		NombreCompleto,
		Email,
		ZonaNuevoProl,
		PedidoID,
		SubTotal,
		Descuento,
		EstadoSimplificacionCUV,
		MontoMinimoPedido,
		MontoMaximoPedido
	)
	SELECT DISTINCT 
		@ProcesoValidacionPedidoRechazadoId,
		PR.IdProcesoPedidoRechazado,
		STUFF(
		(
			SELECT ',' + PR1.MotivoRechazo
			FROM GPR.PedidoRechazado AS PR1			
			WHERE
				C.Codigo =  PR1.CodigoConsultora
				AND U.CodigoConsultora =  PR1.CodigoConsultora
				AND PR1.IdProcesoPedidoRechazado = @IdProcesoPedidoRechazado
			FOR xml path('')),1,1,''
		),
		C.ConsultoraID,
		PR.CodigoConsultora,
		PR.Campania,
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
		), 0),
		C.MontoMinimoPedido,
		C.MontoMaximoPedido
	FROM GPR.PedidoRechazado PR
	INNER JOIN GPR.MotivoRechazo MR WITH(NOLOCK) ON PR.MotivoRechazo = MR.Codigo AND MR.RequiereGestion = 1
	LEFT JOIN ods.Consultora C WITH(NOLOCK) ON C.Codigo =  PR.CodigoConsultora
	LEFT JOIN Usuario U WITH(NOLOCK) ON U.CodigoConsultora =  PR.CodigoConsultora
	LEFT JOIN PedidoWeb PW WITH(NOLOCK) ON PW.CampaniaID = PR.Campania AND PW.ConsultoraID = C.ConsultoraID
	WHERE PR.IdProcesoPedidoRechazado = @IdProcesoPedidoRechazado AND PR.Procesado = 0;
		
	SELECT DISTINCT
		LGPRV.LogGPRValidacionId,
		LGPRV.IdProcesoPedidoRechazado,
		LGPRV.DescripcionRechazo, --Temp
		LGPRV.Campania,
		LGPRV.ConsultoraID,
		LGPRV.CodigoConsultora,
		LGPRV.CodigoUsuario,
		LGPRV.NombreCompleto, --Temp
		LGPRV.Email,
		LGPRV.ZonaNuevoProl,
		LGPRV.PedidoID,
		LGPRV.SubTotal, --Temp
		LGPRV.Descuento, --Temp
		LGPRV.EstadoSimplificacionCUV, --Temp
		LGPRV.Valor,
		P.Simbolo,
		LGPRV.MontoMinimoPedido,
		LGPRV.MontoMaximoPedido
	FROM GPR.LogGPRValidacion LGPRV
	INNER JOIN dbo.Usuario U WITH(NOLOCK) ON LGPRV.CodigoUsuario = U.CodigoUsuario
	INNER JOIN [dbo].[Pais] P (nolock) ON U.PaisID = P.PaisID
	WHERE LGPRV.ProcesoValidacionPedidoRechazadoId = @ProcesoValidacionPedidoRechazadoId;
END


GO

USE BelcorpCostaRica
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado
GO

--------------------------------------------------------------------
CREATE PROCEDURE GPR.GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado
	@IdProcesoPedidoRechazado BIGINT,
	@ProcesoValidacionPedidoRechazadoId BIGINT,
	@PaisISO VARCHAR(2)
AS
BEGIN


	INSERT INTO GPR.LogGPRValidacion(
		ProcesoValidacionPedidoRechazadoId,
		IdProcesoPedidoRechazado,
		DescripcionRechazo,
		ConsultoraID,
		CodigoConsultora,
		Campania,
		CodigoUsuario,
		NombreCompleto,
		Email,
		ZonaNuevoProl,
		PedidoID,
		SubTotal,
		Descuento,
		EstadoSimplificacionCUV,
		MontoMinimoPedido,
		MontoMaximoPedido
	)
	SELECT DISTINCT 
		@ProcesoValidacionPedidoRechazadoId,
		PR.IdProcesoPedidoRechazado,
		STUFF(
		(
			SELECT ',' + PR1.MotivoRechazo
			FROM GPR.PedidoRechazado AS PR1			
			WHERE
				C.Codigo =  PR1.CodigoConsultora
				AND U.CodigoConsultora =  PR1.CodigoConsultora
				AND PR1.IdProcesoPedidoRechazado = @IdProcesoPedidoRechazado
			FOR xml path('')),1,1,''
		),
		C.ConsultoraID,
		PR.CodigoConsultora,
		PR.Campania,
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
		), 0),
		C.MontoMinimoPedido,
		C.MontoMaximoPedido
	FROM GPR.PedidoRechazado PR
	INNER JOIN GPR.MotivoRechazo MR WITH(NOLOCK) ON PR.MotivoRechazo = MR.Codigo AND MR.RequiereGestion = 1
	LEFT JOIN ods.Consultora C WITH(NOLOCK) ON C.Codigo =  PR.CodigoConsultora
	LEFT JOIN Usuario U WITH(NOLOCK) ON U.CodigoConsultora =  PR.CodigoConsultora
	LEFT JOIN PedidoWeb PW WITH(NOLOCK) ON PW.CampaniaID = PR.Campania AND PW.ConsultoraID = C.ConsultoraID
	WHERE PR.IdProcesoPedidoRechazado = @IdProcesoPedidoRechazado AND PR.Procesado = 0;
		
	SELECT DISTINCT
		LGPRV.LogGPRValidacionId,
		LGPRV.IdProcesoPedidoRechazado,
		LGPRV.DescripcionRechazo, --Temp
		LGPRV.Campania,
		LGPRV.ConsultoraID,
		LGPRV.CodigoConsultora,
		LGPRV.CodigoUsuario,
		LGPRV.NombreCompleto, --Temp
		LGPRV.Email,
		LGPRV.ZonaNuevoProl,
		LGPRV.PedidoID,
		LGPRV.SubTotal, --Temp
		LGPRV.Descuento, --Temp
		LGPRV.EstadoSimplificacionCUV, --Temp
		LGPRV.Valor,
		P.Simbolo,
		LGPRV.MontoMinimoPedido,
		LGPRV.MontoMaximoPedido
	FROM GPR.LogGPRValidacion LGPRV
	INNER JOIN dbo.Usuario U WITH(NOLOCK) ON LGPRV.CodigoUsuario = U.CodigoUsuario
	INNER JOIN [dbo].[Pais] P (nolock) ON U.PaisID = P.PaisID
	WHERE LGPRV.ProcesoValidacionPedidoRechazadoId = @ProcesoValidacionPedidoRechazadoId;
END


GO

USE BelcorpChile
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado
GO

--------------------------------------------------------------------
CREATE PROCEDURE GPR.GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado
	@IdProcesoPedidoRechazado BIGINT,
	@ProcesoValidacionPedidoRechazadoId BIGINT,
	@PaisISO VARCHAR(2)
AS
BEGIN


	INSERT INTO GPR.LogGPRValidacion(
		ProcesoValidacionPedidoRechazadoId,
		IdProcesoPedidoRechazado,
		DescripcionRechazo,
		ConsultoraID,
		CodigoConsultora,
		Campania,
		CodigoUsuario,
		NombreCompleto,
		Email,
		ZonaNuevoProl,
		PedidoID,
		SubTotal,
		Descuento,
		EstadoSimplificacionCUV,
		MontoMinimoPedido,
		MontoMaximoPedido
	)
	SELECT DISTINCT 
		@ProcesoValidacionPedidoRechazadoId,
		PR.IdProcesoPedidoRechazado,
		STUFF(
		(
			SELECT ',' + PR1.MotivoRechazo
			FROM GPR.PedidoRechazado AS PR1			
			WHERE
				C.Codigo =  PR1.CodigoConsultora
				AND U.CodigoConsultora =  PR1.CodigoConsultora
				AND PR1.IdProcesoPedidoRechazado = @IdProcesoPedidoRechazado
			FOR xml path('')),1,1,''
		),
		C.ConsultoraID,
		PR.CodigoConsultora,
		PR.Campania,
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
		), 0),
		C.MontoMinimoPedido,
		C.MontoMaximoPedido
	FROM GPR.PedidoRechazado PR
	INNER JOIN GPR.MotivoRechazo MR WITH(NOLOCK) ON PR.MotivoRechazo = MR.Codigo AND MR.RequiereGestion = 1
	LEFT JOIN ods.Consultora C WITH(NOLOCK) ON C.Codigo =  PR.CodigoConsultora
	LEFT JOIN Usuario U WITH(NOLOCK) ON U.CodigoConsultora =  PR.CodigoConsultora
	LEFT JOIN PedidoWeb PW WITH(NOLOCK) ON PW.CampaniaID = PR.Campania AND PW.ConsultoraID = C.ConsultoraID
	WHERE PR.IdProcesoPedidoRechazado = @IdProcesoPedidoRechazado AND PR.Procesado = 0;
		
	SELECT DISTINCT
		LGPRV.LogGPRValidacionId,
		LGPRV.IdProcesoPedidoRechazado,
		LGPRV.DescripcionRechazo, --Temp
		LGPRV.Campania,
		LGPRV.ConsultoraID,
		LGPRV.CodigoConsultora,
		LGPRV.CodigoUsuario,
		LGPRV.NombreCompleto, --Temp
		LGPRV.Email,
		LGPRV.ZonaNuevoProl,
		LGPRV.PedidoID,
		LGPRV.SubTotal, --Temp
		LGPRV.Descuento, --Temp
		LGPRV.EstadoSimplificacionCUV, --Temp
		LGPRV.Valor,
		P.Simbolo,
		LGPRV.MontoMinimoPedido,
		LGPRV.MontoMaximoPedido
	FROM GPR.LogGPRValidacion LGPRV
	INNER JOIN dbo.Usuario U WITH(NOLOCK) ON LGPRV.CodigoUsuario = U.CodigoUsuario
	INNER JOIN [dbo].[Pais] P (nolock) ON U.PaisID = P.PaisID
	WHERE LGPRV.ProcesoValidacionPedidoRechazadoId = @ProcesoValidacionPedidoRechazadoId;
END


GO

USE BelcorpBolivia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado
GO

--------------------------------------------------------------------
CREATE PROCEDURE GPR.GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado
	@IdProcesoPedidoRechazado BIGINT,
	@ProcesoValidacionPedidoRechazadoId BIGINT,
	@PaisISO VARCHAR(2)
AS
BEGIN


	INSERT INTO GPR.LogGPRValidacion(
		ProcesoValidacionPedidoRechazadoId,
		IdProcesoPedidoRechazado,
		DescripcionRechazo,
		ConsultoraID,
		CodigoConsultora,
		Campania,
		CodigoUsuario,
		NombreCompleto,
		Email,
		ZonaNuevoProl,
		PedidoID,
		SubTotal,
		Descuento,
		EstadoSimplificacionCUV,
		MontoMinimoPedido,
		MontoMaximoPedido
	)
	SELECT DISTINCT 
		@ProcesoValidacionPedidoRechazadoId,
		PR.IdProcesoPedidoRechazado,
		STUFF(
		(
			SELECT ',' + PR1.MotivoRechazo
			FROM GPR.PedidoRechazado AS PR1			
			WHERE
				C.Codigo =  PR1.CodigoConsultora
				AND U.CodigoConsultora =  PR1.CodigoConsultora
				AND PR1.IdProcesoPedidoRechazado = @IdProcesoPedidoRechazado
			FOR xml path('')),1,1,''
		),
		C.ConsultoraID,
		PR.CodigoConsultora,
		PR.Campania,
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
		), 0),
		C.MontoMinimoPedido,
		C.MontoMaximoPedido
	FROM GPR.PedidoRechazado PR
	INNER JOIN GPR.MotivoRechazo MR WITH(NOLOCK) ON PR.MotivoRechazo = MR.Codigo AND MR.RequiereGestion = 1
	LEFT JOIN ods.Consultora C WITH(NOLOCK) ON C.Codigo =  PR.CodigoConsultora
	LEFT JOIN Usuario U WITH(NOLOCK) ON U.CodigoConsultora =  PR.CodigoConsultora
	LEFT JOIN PedidoWeb PW WITH(NOLOCK) ON PW.CampaniaID = PR.Campania AND PW.ConsultoraID = C.ConsultoraID
	WHERE PR.IdProcesoPedidoRechazado = @IdProcesoPedidoRechazado AND PR.Procesado = 0;
		
	SELECT DISTINCT
		LGPRV.LogGPRValidacionId,
		LGPRV.IdProcesoPedidoRechazado,
		LGPRV.DescripcionRechazo, --Temp
		LGPRV.Campania,
		LGPRV.ConsultoraID,
		LGPRV.CodigoConsultora,
		LGPRV.CodigoUsuario,
		LGPRV.NombreCompleto, --Temp
		LGPRV.Email,
		LGPRV.ZonaNuevoProl,
		LGPRV.PedidoID,
		LGPRV.SubTotal, --Temp
		LGPRV.Descuento, --Temp
		LGPRV.EstadoSimplificacionCUV, --Temp
		LGPRV.Valor,
		P.Simbolo,
		LGPRV.MontoMinimoPedido,
		LGPRV.MontoMaximoPedido
	FROM GPR.LogGPRValidacion LGPRV
	INNER JOIN dbo.Usuario U WITH(NOLOCK) ON LGPRV.CodigoUsuario = U.CodigoUsuario
	INNER JOIN [dbo].[Pais] P (nolock) ON U.PaisID = P.PaisID
	WHERE LGPRV.ProcesoValidacionPedidoRechazadoId = @ProcesoValidacionPedidoRechazadoId;
END


GO

