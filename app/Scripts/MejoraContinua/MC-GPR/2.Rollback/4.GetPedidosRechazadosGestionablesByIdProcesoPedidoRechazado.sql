
USE BelcorpBolivia
GO

ALTER PROCEDURE [GPR].[GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado]
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
		Valor,
		MontoMinimoPedido,
		MontoMaximoPedido
	)
	
	SELECT ProcesoValidacionPedidoRechazadoId, IdProcesoPedidoRechazado,DescripcionRechazo, ConsultoraID , CodigoConsultora, Campania, CodigoUsuario, Nombre, 
	EMail, ZonaNuevoProl, PedidoID, ImporteTotal, DescuentoProl, EstadoSimplificacionCUV, 
	CASE WHEN charindex('-19',DescripcionRechazo)>0 THEN Valor ELSE NULL END Valor, 
	MontoMinimoPedido, MontoMaximoPedido
	FROM(

		SELECT DISTINCT 
			@ProcesoValidacionPedidoRechazadoId AS ProcesoValidacionPedidoRechazadoId,
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
			) AS DescripcionRechazo,
			C.ConsultoraID,
			PR.CodigoConsultora,
			PR.Campania,
			U.CodigoUsuario,
			U.Nombre,
			IIF(U.EmailActivo = 1, U.EMail, '') AS EMail,
			ISNULL((
				SELECT TOP 1 1
				FROM ConfiguracionValidacionNuevoPROL CVNP WITH(NOLOCK)
				WHERE CVNP.ZonaId = C.ZonaId
			),0) AS ZonaNuevoProl,
			PW.PedidoID,		
			PW.ImporteTotal,
			PW.DescuentoProl,
			ISNULL((
				SELECT TOP 1 EstadoSimplificacionCUV
				FROM Pais
				WHERE CodigoISO = @PaisISO
			), 0) AS EstadoSimplificacionCUV,
			STUFF(
			(
				SELECT ',' + PR1.valor
				FROM GPR.PedidoRechazado AS PR1			
				WHERE
					C.Codigo =  PR1.CodigoConsultora
					AND U.CodigoConsultora =  PR1.CodigoConsultora
					AND PR1.IdProcesoPedidoRechazado = @IdProcesoPedidoRechazado
					AND charindex('-19',PR1.MotivoRechazo)>0
				FOR xml path('')),1,1,''
			) AS Valor, 
			C.MontoMinimoPedido,		
			C.MontoMaximoPedido
		FROM GPR.PedidoRechazado PR
		INNER JOIN GPR.MotivoRechazo MR WITH(NOLOCK) ON PR.MotivoRechazo = MR.Codigo AND MR.RequiereGestion = 1
		LEFT JOIN ods.Consultora C WITH(NOLOCK) ON C.Codigo =  PR.CodigoConsultora
		LEFT JOIN Usuario U WITH(NOLOCK) ON U.CodigoConsultora =  PR.CodigoConsultora
		LEFT JOIN PedidoWeb PW WITH(NOLOCK) ON PW.CampaniaID = PR.Campania AND PW.ConsultoraID = C.ConsultoraID
		WHERE PR.IdProcesoPedidoRechazado = @IdProcesoPedidoRechazado AND PR.Procesado = 0
		) T
	GROUP BY ProcesoValidacionPedidoRechazadoId, IdProcesoPedidoRechazado,DescripcionRechazo, ConsultoraID , CodigoConsultora, Campania, CodigoUsuario, Nombre, 
	EMail, ZonaNuevoProl, PedidoID, ImporteTotal, DescuentoProl, EstadoSimplificacionCUV, Valor, MontoMinimoPedido, MontoMaximoPedido
		
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
/*end*/

USE BelcorpChile
GO

ALTER PROCEDURE [GPR].[GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado]
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
		Valor,
		MontoMinimoPedido,
		MontoMaximoPedido
	)
	
	SELECT ProcesoValidacionPedidoRechazadoId, IdProcesoPedidoRechazado,DescripcionRechazo, ConsultoraID , CodigoConsultora, Campania, CodigoUsuario, Nombre, 
	EMail, ZonaNuevoProl, PedidoID, ImporteTotal, DescuentoProl, EstadoSimplificacionCUV, 
	CASE WHEN charindex('-19',DescripcionRechazo)>0 THEN Valor ELSE NULL END Valor, 
	MontoMinimoPedido, MontoMaximoPedido
	FROM(

		SELECT DISTINCT 
			@ProcesoValidacionPedidoRechazadoId AS ProcesoValidacionPedidoRechazadoId,
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
			) AS DescripcionRechazo,
			C.ConsultoraID,
			PR.CodigoConsultora,
			PR.Campania,
			U.CodigoUsuario,
			U.Nombre,
			IIF(U.EmailActivo = 1, U.EMail, '') AS EMail,
			ISNULL((
				SELECT TOP 1 1
				FROM ConfiguracionValidacionNuevoPROL CVNP WITH(NOLOCK)
				WHERE CVNP.ZonaId = C.ZonaId
			),0) AS ZonaNuevoProl,
			PW.PedidoID,		
			PW.ImporteTotal,
			PW.DescuentoProl,
			ISNULL((
				SELECT TOP 1 EstadoSimplificacionCUV
				FROM Pais
				WHERE CodigoISO = @PaisISO
			), 0) AS EstadoSimplificacionCUV,
			STUFF(
			(
				SELECT ',' + PR1.valor
				FROM GPR.PedidoRechazado AS PR1			
				WHERE
					C.Codigo =  PR1.CodigoConsultora
					AND U.CodigoConsultora =  PR1.CodigoConsultora
					AND PR1.IdProcesoPedidoRechazado = @IdProcesoPedidoRechazado
					AND charindex('-19',PR1.MotivoRechazo)>0
				FOR xml path('')),1,1,''
			) AS Valor, 
			C.MontoMinimoPedido,		
			C.MontoMaximoPedido
		FROM GPR.PedidoRechazado PR
		INNER JOIN GPR.MotivoRechazo MR WITH(NOLOCK) ON PR.MotivoRechazo = MR.Codigo AND MR.RequiereGestion = 1
		LEFT JOIN ods.Consultora C WITH(NOLOCK) ON C.Codigo =  PR.CodigoConsultora
		LEFT JOIN Usuario U WITH(NOLOCK) ON U.CodigoConsultora =  PR.CodigoConsultora
		LEFT JOIN PedidoWeb PW WITH(NOLOCK) ON PW.CampaniaID = PR.Campania AND PW.ConsultoraID = C.ConsultoraID
		WHERE PR.IdProcesoPedidoRechazado = @IdProcesoPedidoRechazado AND PR.Procesado = 0
		) T
	GROUP BY ProcesoValidacionPedidoRechazadoId, IdProcesoPedidoRechazado,DescripcionRechazo, ConsultoraID , CodigoConsultora, Campania, CodigoUsuario, Nombre, 
	EMail, ZonaNuevoProl, PedidoID, ImporteTotal, DescuentoProl, EstadoSimplificacionCUV, Valor, MontoMinimoPedido, MontoMaximoPedido
		
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
/*end*/

USE BelcorpColombia
GO

ALTER PROCEDURE [GPR].[GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado]
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
		Valor,
		MontoMinimoPedido,
		MontoMaximoPedido
	)
	
	SELECT ProcesoValidacionPedidoRechazadoId, IdProcesoPedidoRechazado,DescripcionRechazo, ConsultoraID , CodigoConsultora, Campania, CodigoUsuario, Nombre, 
	EMail, ZonaNuevoProl, PedidoID, ImporteTotal, DescuentoProl, EstadoSimplificacionCUV, 
	CASE WHEN charindex('-19',DescripcionRechazo)>0 THEN Valor ELSE NULL END Valor, 
	MontoMinimoPedido, MontoMaximoPedido
	FROM(

		SELECT DISTINCT 
			@ProcesoValidacionPedidoRechazadoId AS ProcesoValidacionPedidoRechazadoId,
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
			) AS DescripcionRechazo,
			C.ConsultoraID,
			PR.CodigoConsultora,
			PR.Campania,
			U.CodigoUsuario,
			U.Nombre,
			IIF(U.EmailActivo = 1, U.EMail, '') AS EMail,
			ISNULL((
				SELECT TOP 1 1
				FROM ConfiguracionValidacionNuevoPROL CVNP WITH(NOLOCK)
				WHERE CVNP.ZonaId = C.ZonaId
			),0) AS ZonaNuevoProl,
			PW.PedidoID,		
			PW.ImporteTotal,
			PW.DescuentoProl,
			ISNULL((
				SELECT TOP 1 EstadoSimplificacionCUV
				FROM Pais
				WHERE CodigoISO = @PaisISO
			), 0) AS EstadoSimplificacionCUV,
			STUFF(
			(
				SELECT ',' + PR1.valor
				FROM GPR.PedidoRechazado AS PR1			
				WHERE
					C.Codigo =  PR1.CodigoConsultora
					AND U.CodigoConsultora =  PR1.CodigoConsultora
					AND PR1.IdProcesoPedidoRechazado = @IdProcesoPedidoRechazado
					AND charindex('-19',PR1.MotivoRechazo)>0
				FOR xml path('')),1,1,''
			) AS Valor, 
			C.MontoMinimoPedido,		
			C.MontoMaximoPedido
		FROM GPR.PedidoRechazado PR
		INNER JOIN GPR.MotivoRechazo MR WITH(NOLOCK) ON PR.MotivoRechazo = MR.Codigo AND MR.RequiereGestion = 1
		LEFT JOIN ods.Consultora C WITH(NOLOCK) ON C.Codigo =  PR.CodigoConsultora
		LEFT JOIN Usuario U WITH(NOLOCK) ON U.CodigoConsultora =  PR.CodigoConsultora
		LEFT JOIN PedidoWeb PW WITH(NOLOCK) ON PW.CampaniaID = PR.Campania AND PW.ConsultoraID = C.ConsultoraID
		WHERE PR.IdProcesoPedidoRechazado = @IdProcesoPedidoRechazado AND PR.Procesado = 0
		) T
	GROUP BY ProcesoValidacionPedidoRechazadoId, IdProcesoPedidoRechazado,DescripcionRechazo, ConsultoraID , CodigoConsultora, Campania, CodigoUsuario, Nombre, 
	EMail, ZonaNuevoProl, PedidoID, ImporteTotal, DescuentoProl, EstadoSimplificacionCUV, Valor, MontoMinimoPedido, MontoMaximoPedido
		
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
/*end*/

USE BelcorpCostaRica
GO

ALTER PROCEDURE [GPR].[GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado]
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
		Valor,
		MontoMinimoPedido,
		MontoMaximoPedido
	)
	
	SELECT ProcesoValidacionPedidoRechazadoId, IdProcesoPedidoRechazado,DescripcionRechazo, ConsultoraID , CodigoConsultora, Campania, CodigoUsuario, Nombre, 
	EMail, ZonaNuevoProl, PedidoID, ImporteTotal, DescuentoProl, EstadoSimplificacionCUV, 
	CASE WHEN charindex('-19',DescripcionRechazo)>0 THEN Valor ELSE NULL END Valor, 
	MontoMinimoPedido, MontoMaximoPedido
	FROM(

		SELECT DISTINCT 
			@ProcesoValidacionPedidoRechazadoId AS ProcesoValidacionPedidoRechazadoId,
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
			) AS DescripcionRechazo,
			C.ConsultoraID,
			PR.CodigoConsultora,
			PR.Campania,
			U.CodigoUsuario,
			U.Nombre,
			IIF(U.EmailActivo = 1, U.EMail, '') AS EMail,
			ISNULL((
				SELECT TOP 1 1
				FROM ConfiguracionValidacionNuevoPROL CVNP WITH(NOLOCK)
				WHERE CVNP.ZonaId = C.ZonaId
			),0) AS ZonaNuevoProl,
			PW.PedidoID,		
			PW.ImporteTotal,
			PW.DescuentoProl,
			ISNULL((
				SELECT TOP 1 EstadoSimplificacionCUV
				FROM Pais
				WHERE CodigoISO = @PaisISO
			), 0) AS EstadoSimplificacionCUV,
			STUFF(
			(
				SELECT ',' + PR1.valor
				FROM GPR.PedidoRechazado AS PR1			
				WHERE
					C.Codigo =  PR1.CodigoConsultora
					AND U.CodigoConsultora =  PR1.CodigoConsultora
					AND PR1.IdProcesoPedidoRechazado = @IdProcesoPedidoRechazado
					AND charindex('-19',PR1.MotivoRechazo)>0
				FOR xml path('')),1,1,''
			) AS Valor, 
			C.MontoMinimoPedido,		
			C.MontoMaximoPedido
		FROM GPR.PedidoRechazado PR
		INNER JOIN GPR.MotivoRechazo MR WITH(NOLOCK) ON PR.MotivoRechazo = MR.Codigo AND MR.RequiereGestion = 1
		LEFT JOIN ods.Consultora C WITH(NOLOCK) ON C.Codigo =  PR.CodigoConsultora
		LEFT JOIN Usuario U WITH(NOLOCK) ON U.CodigoConsultora =  PR.CodigoConsultora
		LEFT JOIN PedidoWeb PW WITH(NOLOCK) ON PW.CampaniaID = PR.Campania AND PW.ConsultoraID = C.ConsultoraID
		WHERE PR.IdProcesoPedidoRechazado = @IdProcesoPedidoRechazado AND PR.Procesado = 0
		) T
	GROUP BY ProcesoValidacionPedidoRechazadoId, IdProcesoPedidoRechazado,DescripcionRechazo, ConsultoraID , CodigoConsultora, Campania, CodigoUsuario, Nombre, 
	EMail, ZonaNuevoProl, PedidoID, ImporteTotal, DescuentoProl, EstadoSimplificacionCUV, Valor, MontoMinimoPedido, MontoMaximoPedido
		
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
/*end*/

USE BelcorpDominicana
GO

ALTER PROCEDURE [GPR].[GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado]
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
		Valor,
		MontoMinimoPedido,
		MontoMaximoPedido
	)
	
	SELECT ProcesoValidacionPedidoRechazadoId, IdProcesoPedidoRechazado,DescripcionRechazo, ConsultoraID , CodigoConsultora, Campania, CodigoUsuario, Nombre, 
	EMail, ZonaNuevoProl, PedidoID, ImporteTotal, DescuentoProl, EstadoSimplificacionCUV, 
	CASE WHEN charindex('-19',DescripcionRechazo)>0 THEN Valor ELSE NULL END Valor, 
	MontoMinimoPedido, MontoMaximoPedido
	FROM(

		SELECT DISTINCT 
			@ProcesoValidacionPedidoRechazadoId AS ProcesoValidacionPedidoRechazadoId,
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
			) AS DescripcionRechazo,
			C.ConsultoraID,
			PR.CodigoConsultora,
			PR.Campania,
			U.CodigoUsuario,
			U.Nombre,
			IIF(U.EmailActivo = 1, U.EMail, '') AS EMail,
			ISNULL((
				SELECT TOP 1 1
				FROM ConfiguracionValidacionNuevoPROL CVNP WITH(NOLOCK)
				WHERE CVNP.ZonaId = C.ZonaId
			),0) AS ZonaNuevoProl,
			PW.PedidoID,		
			PW.ImporteTotal,
			PW.DescuentoProl,
			ISNULL((
				SELECT TOP 1 EstadoSimplificacionCUV
				FROM Pais
				WHERE CodigoISO = @PaisISO
			), 0) AS EstadoSimplificacionCUV,
			STUFF(
			(
				SELECT ',' + PR1.valor
				FROM GPR.PedidoRechazado AS PR1			
				WHERE
					C.Codigo =  PR1.CodigoConsultora
					AND U.CodigoConsultora =  PR1.CodigoConsultora
					AND PR1.IdProcesoPedidoRechazado = @IdProcesoPedidoRechazado
					AND charindex('-19',PR1.MotivoRechazo)>0
				FOR xml path('')),1,1,''
			) AS Valor, 
			C.MontoMinimoPedido,		
			C.MontoMaximoPedido
		FROM GPR.PedidoRechazado PR
		INNER JOIN GPR.MotivoRechazo MR WITH(NOLOCK) ON PR.MotivoRechazo = MR.Codigo AND MR.RequiereGestion = 1
		LEFT JOIN ods.Consultora C WITH(NOLOCK) ON C.Codigo =  PR.CodigoConsultora
		LEFT JOIN Usuario U WITH(NOLOCK) ON U.CodigoConsultora =  PR.CodigoConsultora
		LEFT JOIN PedidoWeb PW WITH(NOLOCK) ON PW.CampaniaID = PR.Campania AND PW.ConsultoraID = C.ConsultoraID
		WHERE PR.IdProcesoPedidoRechazado = @IdProcesoPedidoRechazado AND PR.Procesado = 0
		) T
	GROUP BY ProcesoValidacionPedidoRechazadoId, IdProcesoPedidoRechazado,DescripcionRechazo, ConsultoraID , CodigoConsultora, Campania, CodigoUsuario, Nombre, 
	EMail, ZonaNuevoProl, PedidoID, ImporteTotal, DescuentoProl, EstadoSimplificacionCUV, Valor, MontoMinimoPedido, MontoMaximoPedido
		
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
/*end*/

USE BelcorpEcuador
GO

ALTER PROCEDURE [GPR].[GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado]
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
		Valor,
		MontoMinimoPedido,
		MontoMaximoPedido
	)
	
	SELECT ProcesoValidacionPedidoRechazadoId, IdProcesoPedidoRechazado,DescripcionRechazo, ConsultoraID , CodigoConsultora, Campania, CodigoUsuario, Nombre, 
	EMail, ZonaNuevoProl, PedidoID, ImporteTotal, DescuentoProl, EstadoSimplificacionCUV, 
	CASE WHEN charindex('-19',DescripcionRechazo)>0 THEN Valor ELSE NULL END Valor, 
	MontoMinimoPedido, MontoMaximoPedido
	FROM(

		SELECT DISTINCT 
			@ProcesoValidacionPedidoRechazadoId AS ProcesoValidacionPedidoRechazadoId,
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
			) AS DescripcionRechazo,
			C.ConsultoraID,
			PR.CodigoConsultora,
			PR.Campania,
			U.CodigoUsuario,
			U.Nombre,
			IIF(U.EmailActivo = 1, U.EMail, '') AS EMail,
			ISNULL((
				SELECT TOP 1 1
				FROM ConfiguracionValidacionNuevoPROL CVNP WITH(NOLOCK)
				WHERE CVNP.ZonaId = C.ZonaId
			),0) AS ZonaNuevoProl,
			PW.PedidoID,		
			PW.ImporteTotal,
			PW.DescuentoProl,
			ISNULL((
				SELECT TOP 1 EstadoSimplificacionCUV
				FROM Pais
				WHERE CodigoISO = @PaisISO
			), 0) AS EstadoSimplificacionCUV,
			STUFF(
			(
				SELECT ',' + PR1.valor
				FROM GPR.PedidoRechazado AS PR1			
				WHERE
					C.Codigo =  PR1.CodigoConsultora
					AND U.CodigoConsultora =  PR1.CodigoConsultora
					AND PR1.IdProcesoPedidoRechazado = @IdProcesoPedidoRechazado
					AND charindex('-19',PR1.MotivoRechazo)>0
				FOR xml path('')),1,1,''
			) AS Valor, 
			C.MontoMinimoPedido,		
			C.MontoMaximoPedido
		FROM GPR.PedidoRechazado PR
		INNER JOIN GPR.MotivoRechazo MR WITH(NOLOCK) ON PR.MotivoRechazo = MR.Codigo AND MR.RequiereGestion = 1
		LEFT JOIN ods.Consultora C WITH(NOLOCK) ON C.Codigo =  PR.CodigoConsultora
		LEFT JOIN Usuario U WITH(NOLOCK) ON U.CodigoConsultora =  PR.CodigoConsultora
		LEFT JOIN PedidoWeb PW WITH(NOLOCK) ON PW.CampaniaID = PR.Campania AND PW.ConsultoraID = C.ConsultoraID
		WHERE PR.IdProcesoPedidoRechazado = @IdProcesoPedidoRechazado AND PR.Procesado = 0
		) T
	GROUP BY ProcesoValidacionPedidoRechazadoId, IdProcesoPedidoRechazado,DescripcionRechazo, ConsultoraID , CodigoConsultora, Campania, CodigoUsuario, Nombre, 
	EMail, ZonaNuevoProl, PedidoID, ImporteTotal, DescuentoProl, EstadoSimplificacionCUV, Valor, MontoMinimoPedido, MontoMaximoPedido
		
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
/*end*/

USE BelcorpGuatemala
GO

ALTER PROCEDURE [GPR].[GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado]
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
		Valor,
		MontoMinimoPedido,
		MontoMaximoPedido
	)
	
	SELECT ProcesoValidacionPedidoRechazadoId, IdProcesoPedidoRechazado,DescripcionRechazo, ConsultoraID , CodigoConsultora, Campania, CodigoUsuario, Nombre, 
	EMail, ZonaNuevoProl, PedidoID, ImporteTotal, DescuentoProl, EstadoSimplificacionCUV, 
	CASE WHEN charindex('-19',DescripcionRechazo)>0 THEN Valor ELSE NULL END Valor, 
	MontoMinimoPedido, MontoMaximoPedido
	FROM(

		SELECT DISTINCT 
			@ProcesoValidacionPedidoRechazadoId AS ProcesoValidacionPedidoRechazadoId,
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
			) AS DescripcionRechazo,
			C.ConsultoraID,
			PR.CodigoConsultora,
			PR.Campania,
			U.CodigoUsuario,
			U.Nombre,
			IIF(U.EmailActivo = 1, U.EMail, '') AS EMail,
			ISNULL((
				SELECT TOP 1 1
				FROM ConfiguracionValidacionNuevoPROL CVNP WITH(NOLOCK)
				WHERE CVNP.ZonaId = C.ZonaId
			),0) AS ZonaNuevoProl,
			PW.PedidoID,		
			PW.ImporteTotal,
			PW.DescuentoProl,
			ISNULL((
				SELECT TOP 1 EstadoSimplificacionCUV
				FROM Pais
				WHERE CodigoISO = @PaisISO
			), 0) AS EstadoSimplificacionCUV,
			STUFF(
			(
				SELECT ',' + PR1.valor
				FROM GPR.PedidoRechazado AS PR1			
				WHERE
					C.Codigo =  PR1.CodigoConsultora
					AND U.CodigoConsultora =  PR1.CodigoConsultora
					AND PR1.IdProcesoPedidoRechazado = @IdProcesoPedidoRechazado
					AND charindex('-19',PR1.MotivoRechazo)>0
				FOR xml path('')),1,1,''
			) AS Valor, 
			C.MontoMinimoPedido,		
			C.MontoMaximoPedido
		FROM GPR.PedidoRechazado PR
		INNER JOIN GPR.MotivoRechazo MR WITH(NOLOCK) ON PR.MotivoRechazo = MR.Codigo AND MR.RequiereGestion = 1
		LEFT JOIN ods.Consultora C WITH(NOLOCK) ON C.Codigo =  PR.CodigoConsultora
		LEFT JOIN Usuario U WITH(NOLOCK) ON U.CodigoConsultora =  PR.CodigoConsultora
		LEFT JOIN PedidoWeb PW WITH(NOLOCK) ON PW.CampaniaID = PR.Campania AND PW.ConsultoraID = C.ConsultoraID
		WHERE PR.IdProcesoPedidoRechazado = @IdProcesoPedidoRechazado AND PR.Procesado = 0
		) T
	GROUP BY ProcesoValidacionPedidoRechazadoId, IdProcesoPedidoRechazado,DescripcionRechazo, ConsultoraID , CodigoConsultora, Campania, CodigoUsuario, Nombre, 
	EMail, ZonaNuevoProl, PedidoID, ImporteTotal, DescuentoProl, EstadoSimplificacionCUV, Valor, MontoMinimoPedido, MontoMaximoPedido
		
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
/*end*/

USE BelcorpMexico
GO

ALTER PROCEDURE [GPR].[GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado]
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
		Valor,
		MontoMinimoPedido,
		MontoMaximoPedido
	)
	
	SELECT ProcesoValidacionPedidoRechazadoId, IdProcesoPedidoRechazado,DescripcionRechazo, ConsultoraID , CodigoConsultora, Campania, CodigoUsuario, Nombre, 
	EMail, ZonaNuevoProl, PedidoID, ImporteTotal, DescuentoProl, EstadoSimplificacionCUV, 
	CASE WHEN charindex('-19',DescripcionRechazo)>0 THEN Valor ELSE NULL END Valor, 
	MontoMinimoPedido, MontoMaximoPedido
	FROM(

		SELECT DISTINCT 
			@ProcesoValidacionPedidoRechazadoId AS ProcesoValidacionPedidoRechazadoId,
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
			) AS DescripcionRechazo,
			C.ConsultoraID,
			PR.CodigoConsultora,
			PR.Campania,
			U.CodigoUsuario,
			U.Nombre,
			IIF(U.EmailActivo = 1, U.EMail, '') AS EMail,
			ISNULL((
				SELECT TOP 1 1
				FROM ConfiguracionValidacionNuevoPROL CVNP WITH(NOLOCK)
				WHERE CVNP.ZonaId = C.ZonaId
			),0) AS ZonaNuevoProl,
			PW.PedidoID,		
			PW.ImporteTotal,
			PW.DescuentoProl,
			ISNULL((
				SELECT TOP 1 EstadoSimplificacionCUV
				FROM Pais
				WHERE CodigoISO = @PaisISO
			), 0) AS EstadoSimplificacionCUV,
			STUFF(
			(
				SELECT ',' + PR1.valor
				FROM GPR.PedidoRechazado AS PR1			
				WHERE
					C.Codigo =  PR1.CodigoConsultora
					AND U.CodigoConsultora =  PR1.CodigoConsultora
					AND PR1.IdProcesoPedidoRechazado = @IdProcesoPedidoRechazado
					AND charindex('-19',PR1.MotivoRechazo)>0
				FOR xml path('')),1,1,''
			) AS Valor, 
			C.MontoMinimoPedido,		
			C.MontoMaximoPedido
		FROM GPR.PedidoRechazado PR
		INNER JOIN GPR.MotivoRechazo MR WITH(NOLOCK) ON PR.MotivoRechazo = MR.Codigo AND MR.RequiereGestion = 1
		LEFT JOIN ods.Consultora C WITH(NOLOCK) ON C.Codigo =  PR.CodigoConsultora
		LEFT JOIN Usuario U WITH(NOLOCK) ON U.CodigoConsultora =  PR.CodigoConsultora
		LEFT JOIN PedidoWeb PW WITH(NOLOCK) ON PW.CampaniaID = PR.Campania AND PW.ConsultoraID = C.ConsultoraID
		WHERE PR.IdProcesoPedidoRechazado = @IdProcesoPedidoRechazado AND PR.Procesado = 0
		) T
	GROUP BY ProcesoValidacionPedidoRechazadoId, IdProcesoPedidoRechazado,DescripcionRechazo, ConsultoraID , CodigoConsultora, Campania, CodigoUsuario, Nombre, 
	EMail, ZonaNuevoProl, PedidoID, ImporteTotal, DescuentoProl, EstadoSimplificacionCUV, Valor, MontoMinimoPedido, MontoMaximoPedido
		
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
/*end*/

USE BelcorpPanama
GO

ALTER PROCEDURE [GPR].[GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado]
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
		Valor,
		MontoMinimoPedido,
		MontoMaximoPedido
	)
	
	SELECT ProcesoValidacionPedidoRechazadoId, IdProcesoPedidoRechazado,DescripcionRechazo, ConsultoraID , CodigoConsultora, Campania, CodigoUsuario, Nombre, 
	EMail, ZonaNuevoProl, PedidoID, ImporteTotal, DescuentoProl, EstadoSimplificacionCUV, 
	CASE WHEN charindex('-19',DescripcionRechazo)>0 THEN Valor ELSE NULL END Valor, 
	MontoMinimoPedido, MontoMaximoPedido
	FROM(

		SELECT DISTINCT 
			@ProcesoValidacionPedidoRechazadoId AS ProcesoValidacionPedidoRechazadoId,
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
			) AS DescripcionRechazo,
			C.ConsultoraID,
			PR.CodigoConsultora,
			PR.Campania,
			U.CodigoUsuario,
			U.Nombre,
			IIF(U.EmailActivo = 1, U.EMail, '') AS EMail,
			ISNULL((
				SELECT TOP 1 1
				FROM ConfiguracionValidacionNuevoPROL CVNP WITH(NOLOCK)
				WHERE CVNP.ZonaId = C.ZonaId
			),0) AS ZonaNuevoProl,
			PW.PedidoID,		
			PW.ImporteTotal,
			PW.DescuentoProl,
			ISNULL((
				SELECT TOP 1 EstadoSimplificacionCUV
				FROM Pais
				WHERE CodigoISO = @PaisISO
			), 0) AS EstadoSimplificacionCUV,
			STUFF(
			(
				SELECT ',' + PR1.valor
				FROM GPR.PedidoRechazado AS PR1			
				WHERE
					C.Codigo =  PR1.CodigoConsultora
					AND U.CodigoConsultora =  PR1.CodigoConsultora
					AND PR1.IdProcesoPedidoRechazado = @IdProcesoPedidoRechazado
					AND charindex('-19',PR1.MotivoRechazo)>0
				FOR xml path('')),1,1,''
			) AS Valor, 
			C.MontoMinimoPedido,		
			C.MontoMaximoPedido
		FROM GPR.PedidoRechazado PR
		INNER JOIN GPR.MotivoRechazo MR WITH(NOLOCK) ON PR.MotivoRechazo = MR.Codigo AND MR.RequiereGestion = 1
		LEFT JOIN ods.Consultora C WITH(NOLOCK) ON C.Codigo =  PR.CodigoConsultora
		LEFT JOIN Usuario U WITH(NOLOCK) ON U.CodigoConsultora =  PR.CodigoConsultora
		LEFT JOIN PedidoWeb PW WITH(NOLOCK) ON PW.CampaniaID = PR.Campania AND PW.ConsultoraID = C.ConsultoraID
		WHERE PR.IdProcesoPedidoRechazado = @IdProcesoPedidoRechazado AND PR.Procesado = 0
		) T
	GROUP BY ProcesoValidacionPedidoRechazadoId, IdProcesoPedidoRechazado,DescripcionRechazo, ConsultoraID , CodigoConsultora, Campania, CodigoUsuario, Nombre, 
	EMail, ZonaNuevoProl, PedidoID, ImporteTotal, DescuentoProl, EstadoSimplificacionCUV, Valor, MontoMinimoPedido, MontoMaximoPedido
		
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
/*end*/

USE BelcorpPeru
GO

ALTER PROCEDURE [GPR].[GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado]
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
		Valor,
		MontoMinimoPedido,
		MontoMaximoPedido
	)
	
	SELECT ProcesoValidacionPedidoRechazadoId, IdProcesoPedidoRechazado,DescripcionRechazo, ConsultoraID , CodigoConsultora, Campania, CodigoUsuario, Nombre, 
	EMail, ZonaNuevoProl, PedidoID, ImporteTotal, DescuentoProl, EstadoSimplificacionCUV, 
	CASE WHEN charindex('-19',DescripcionRechazo)>0 THEN Valor ELSE NULL END Valor, 
	MontoMinimoPedido, MontoMaximoPedido
	FROM(

		SELECT DISTINCT 
			@ProcesoValidacionPedidoRechazadoId AS ProcesoValidacionPedidoRechazadoId,
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
			) AS DescripcionRechazo,
			C.ConsultoraID,
			PR.CodigoConsultora,
			PR.Campania,
			U.CodigoUsuario,
			U.Nombre,
			IIF(U.EmailActivo = 1, U.EMail, '') AS EMail,
			ISNULL((
				SELECT TOP 1 1
				FROM ConfiguracionValidacionNuevoPROL CVNP WITH(NOLOCK)
				WHERE CVNP.ZonaId = C.ZonaId
			),0) AS ZonaNuevoProl,
			PW.PedidoID,		
			PW.ImporteTotal,
			PW.DescuentoProl,
			ISNULL((
				SELECT TOP 1 EstadoSimplificacionCUV
				FROM Pais
				WHERE CodigoISO = @PaisISO
			), 0) AS EstadoSimplificacionCUV,
			STUFF(
			(
				SELECT ',' + PR1.valor
				FROM GPR.PedidoRechazado AS PR1			
				WHERE
					C.Codigo =  PR1.CodigoConsultora
					AND U.CodigoConsultora =  PR1.CodigoConsultora
					AND PR1.IdProcesoPedidoRechazado = @IdProcesoPedidoRechazado
					AND charindex('-19',PR1.MotivoRechazo)>0
				FOR xml path('')),1,1,''
			) AS Valor, 
			C.MontoMinimoPedido,		
			C.MontoMaximoPedido
		FROM GPR.PedidoRechazado PR
		INNER JOIN GPR.MotivoRechazo MR WITH(NOLOCK) ON PR.MotivoRechazo = MR.Codigo AND MR.RequiereGestion = 1
		LEFT JOIN ods.Consultora C WITH(NOLOCK) ON C.Codigo =  PR.CodigoConsultora
		LEFT JOIN Usuario U WITH(NOLOCK) ON U.CodigoConsultora =  PR.CodigoConsultora
		LEFT JOIN PedidoWeb PW WITH(NOLOCK) ON PW.CampaniaID = PR.Campania AND PW.ConsultoraID = C.ConsultoraID
		WHERE PR.IdProcesoPedidoRechazado = @IdProcesoPedidoRechazado AND PR.Procesado = 0
		) T
	GROUP BY ProcesoValidacionPedidoRechazadoId, IdProcesoPedidoRechazado,DescripcionRechazo, ConsultoraID , CodigoConsultora, Campania, CodigoUsuario, Nombre, 
	EMail, ZonaNuevoProl, PedidoID, ImporteTotal, DescuentoProl, EstadoSimplificacionCUV, Valor, MontoMinimoPedido, MontoMaximoPedido
		
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
/*end*/

USE BelcorpPuertoRico
GO

ALTER PROCEDURE [GPR].[GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado]
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
		Valor,
		MontoMinimoPedido,
		MontoMaximoPedido
	)
	
	SELECT ProcesoValidacionPedidoRechazadoId, IdProcesoPedidoRechazado,DescripcionRechazo, ConsultoraID , CodigoConsultora, Campania, CodigoUsuario, Nombre, 
	EMail, ZonaNuevoProl, PedidoID, ImporteTotal, DescuentoProl, EstadoSimplificacionCUV, 
	CASE WHEN charindex('-19',DescripcionRechazo)>0 THEN Valor ELSE NULL END Valor, 
	MontoMinimoPedido, MontoMaximoPedido
	FROM(

		SELECT DISTINCT 
			@ProcesoValidacionPedidoRechazadoId AS ProcesoValidacionPedidoRechazadoId,
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
			) AS DescripcionRechazo,
			C.ConsultoraID,
			PR.CodigoConsultora,
			PR.Campania,
			U.CodigoUsuario,
			U.Nombre,
			IIF(U.EmailActivo = 1, U.EMail, '') AS EMail,
			ISNULL((
				SELECT TOP 1 1
				FROM ConfiguracionValidacionNuevoPROL CVNP WITH(NOLOCK)
				WHERE CVNP.ZonaId = C.ZonaId
			),0) AS ZonaNuevoProl,
			PW.PedidoID,		
			PW.ImporteTotal,
			PW.DescuentoProl,
			ISNULL((
				SELECT TOP 1 EstadoSimplificacionCUV
				FROM Pais
				WHERE CodigoISO = @PaisISO
			), 0) AS EstadoSimplificacionCUV,
			STUFF(
			(
				SELECT ',' + PR1.valor
				FROM GPR.PedidoRechazado AS PR1			
				WHERE
					C.Codigo =  PR1.CodigoConsultora
					AND U.CodigoConsultora =  PR1.CodigoConsultora
					AND PR1.IdProcesoPedidoRechazado = @IdProcesoPedidoRechazado
					AND charindex('-19',PR1.MotivoRechazo)>0
				FOR xml path('')),1,1,''
			) AS Valor, 
			C.MontoMinimoPedido,		
			C.MontoMaximoPedido
		FROM GPR.PedidoRechazado PR
		INNER JOIN GPR.MotivoRechazo MR WITH(NOLOCK) ON PR.MotivoRechazo = MR.Codigo AND MR.RequiereGestion = 1
		LEFT JOIN ods.Consultora C WITH(NOLOCK) ON C.Codigo =  PR.CodigoConsultora
		LEFT JOIN Usuario U WITH(NOLOCK) ON U.CodigoConsultora =  PR.CodigoConsultora
		LEFT JOIN PedidoWeb PW WITH(NOLOCK) ON PW.CampaniaID = PR.Campania AND PW.ConsultoraID = C.ConsultoraID
		WHERE PR.IdProcesoPedidoRechazado = @IdProcesoPedidoRechazado AND PR.Procesado = 0
		) T
	GROUP BY ProcesoValidacionPedidoRechazadoId, IdProcesoPedidoRechazado,DescripcionRechazo, ConsultoraID , CodigoConsultora, Campania, CodigoUsuario, Nombre, 
	EMail, ZonaNuevoProl, PedidoID, ImporteTotal, DescuentoProl, EstadoSimplificacionCUV, Valor, MontoMinimoPedido, MontoMaximoPedido
		
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
/*end*/

USE BelcorpSalvador
GO

ALTER PROCEDURE [GPR].[GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado]
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
		Valor,
		MontoMinimoPedido,
		MontoMaximoPedido
	)
	
	SELECT ProcesoValidacionPedidoRechazadoId, IdProcesoPedidoRechazado,DescripcionRechazo, ConsultoraID , CodigoConsultora, Campania, CodigoUsuario, Nombre, 
	EMail, ZonaNuevoProl, PedidoID, ImporteTotal, DescuentoProl, EstadoSimplificacionCUV, 
	CASE WHEN charindex('-19',DescripcionRechazo)>0 THEN Valor ELSE NULL END Valor, 
	MontoMinimoPedido, MontoMaximoPedido
	FROM(

		SELECT DISTINCT 
			@ProcesoValidacionPedidoRechazadoId AS ProcesoValidacionPedidoRechazadoId,
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
			) AS DescripcionRechazo,
			C.ConsultoraID,
			PR.CodigoConsultora,
			PR.Campania,
			U.CodigoUsuario,
			U.Nombre,
			IIF(U.EmailActivo = 1, U.EMail, '') AS EMail,
			ISNULL((
				SELECT TOP 1 1
				FROM ConfiguracionValidacionNuevoPROL CVNP WITH(NOLOCK)
				WHERE CVNP.ZonaId = C.ZonaId
			),0) AS ZonaNuevoProl,
			PW.PedidoID,		
			PW.ImporteTotal,
			PW.DescuentoProl,
			ISNULL((
				SELECT TOP 1 EstadoSimplificacionCUV
				FROM Pais
				WHERE CodigoISO = @PaisISO
			), 0) AS EstadoSimplificacionCUV,
			STUFF(
			(
				SELECT ',' + PR1.valor
				FROM GPR.PedidoRechazado AS PR1			
				WHERE
					C.Codigo =  PR1.CodigoConsultora
					AND U.CodigoConsultora =  PR1.CodigoConsultora
					AND PR1.IdProcesoPedidoRechazado = @IdProcesoPedidoRechazado
					AND charindex('-19',PR1.MotivoRechazo)>0
				FOR xml path('')),1,1,''
			) AS Valor, 
			C.MontoMinimoPedido,		
			C.MontoMaximoPedido
		FROM GPR.PedidoRechazado PR
		INNER JOIN GPR.MotivoRechazo MR WITH(NOLOCK) ON PR.MotivoRechazo = MR.Codigo AND MR.RequiereGestion = 1
		LEFT JOIN ods.Consultora C WITH(NOLOCK) ON C.Codigo =  PR.CodigoConsultora
		LEFT JOIN Usuario U WITH(NOLOCK) ON U.CodigoConsultora =  PR.CodigoConsultora
		LEFT JOIN PedidoWeb PW WITH(NOLOCK) ON PW.CampaniaID = PR.Campania AND PW.ConsultoraID = C.ConsultoraID
		WHERE PR.IdProcesoPedidoRechazado = @IdProcesoPedidoRechazado AND PR.Procesado = 0
		) T
	GROUP BY ProcesoValidacionPedidoRechazadoId, IdProcesoPedidoRechazado,DescripcionRechazo, ConsultoraID , CodigoConsultora, Campania, CodigoUsuario, Nombre, 
	EMail, ZonaNuevoProl, PedidoID, ImporteTotal, DescuentoProl, EstadoSimplificacionCUV, Valor, MontoMinimoPedido, MontoMaximoPedido
		
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
/*end*/

USE BelcorpVenezuela
GO

ALTER PROCEDURE [GPR].[GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado]
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
		Valor,
		MontoMinimoPedido,
		MontoMaximoPedido
	)
	
	SELECT ProcesoValidacionPedidoRechazadoId, IdProcesoPedidoRechazado,DescripcionRechazo, ConsultoraID , CodigoConsultora, Campania, CodigoUsuario, Nombre, 
	EMail, ZonaNuevoProl, PedidoID, ImporteTotal, DescuentoProl, EstadoSimplificacionCUV, 
	CASE WHEN charindex('-19',DescripcionRechazo)>0 THEN Valor ELSE NULL END Valor, 
	MontoMinimoPedido, MontoMaximoPedido
	FROM(

		SELECT DISTINCT 
			@ProcesoValidacionPedidoRechazadoId AS ProcesoValidacionPedidoRechazadoId,
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
			) AS DescripcionRechazo,
			C.ConsultoraID,
			PR.CodigoConsultora,
			PR.Campania,
			U.CodigoUsuario,
			U.Nombre,
			IIF(U.EmailActivo = 1, U.EMail, '') AS EMail,
			ISNULL((
				SELECT TOP 1 1
				FROM ConfiguracionValidacionNuevoPROL CVNP WITH(NOLOCK)
				WHERE CVNP.ZonaId = C.ZonaId
			),0) AS ZonaNuevoProl,
			PW.PedidoID,		
			PW.ImporteTotal,
			PW.DescuentoProl,
			ISNULL((
				SELECT TOP 1 EstadoSimplificacionCUV
				FROM Pais
				WHERE CodigoISO = @PaisISO
			), 0) AS EstadoSimplificacionCUV,
			STUFF(
			(
				SELECT ',' + PR1.valor
				FROM GPR.PedidoRechazado AS PR1			
				WHERE
					C.Codigo =  PR1.CodigoConsultora
					AND U.CodigoConsultora =  PR1.CodigoConsultora
					AND PR1.IdProcesoPedidoRechazado = @IdProcesoPedidoRechazado
					AND charindex('-19',PR1.MotivoRechazo)>0
				FOR xml path('')),1,1,''
			) AS Valor, 
			C.MontoMinimoPedido,		
			C.MontoMaximoPedido
		FROM GPR.PedidoRechazado PR
		INNER JOIN GPR.MotivoRechazo MR WITH(NOLOCK) ON PR.MotivoRechazo = MR.Codigo AND MR.RequiereGestion = 1
		LEFT JOIN ods.Consultora C WITH(NOLOCK) ON C.Codigo =  PR.CodigoConsultora
		LEFT JOIN Usuario U WITH(NOLOCK) ON U.CodigoConsultora =  PR.CodigoConsultora
		LEFT JOIN PedidoWeb PW WITH(NOLOCK) ON PW.CampaniaID = PR.Campania AND PW.ConsultoraID = C.ConsultoraID
		WHERE PR.IdProcesoPedidoRechazado = @IdProcesoPedidoRechazado AND PR.Procesado = 0
		) T
	GROUP BY ProcesoValidacionPedidoRechazadoId, IdProcesoPedidoRechazado,DescripcionRechazo, ConsultoraID , CodigoConsultora, Campania, CodigoUsuario, Nombre, 
	EMail, ZonaNuevoProl, PedidoID, ImporteTotal, DescuentoProl, EstadoSimplificacionCUV, Valor, MontoMinimoPedido, MontoMaximoPedido
		
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