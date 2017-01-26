
USE BelcorpBolivia
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado]
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
		MR.CodigoSomosBelcorp AS CodigoRechazoSomosBelcorp,
		PR.MotivoRechazo,
		PR.Valor,
		P.Simbolo
	FROM GPR.LogGPRValidacion LGPRV
	INNER JOIN GPR.PedidoRechazado PR ON LGPRV.IdPedidoRechazado = PR.IdPedidoRechazado
	INNER JOIN GPR.MotivoRechazo MR WITH(NOLOCK) ON PR.MotivoRechazo = MR.Codigo AND MR.RequiereGestion = 1
	INNER JOIN dbo.Usuario U WITH(NOLOCK) ON LGPRV.CodigoUsuario = U.CodigoUsuario
	INNER JOIN [dbo].[Pais] P (nolock) ON U.PaisID = P.PaisID
	WHERE LGPRV.ProcesoValidacionPedidoRechazadoId = @ProcesoValidacionPedidoRechazadoId;
END

GO

USE BelcorpChile
go


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado]
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
		MR.CodigoSomosBelcorp AS CodigoRechazoSomosBelcorp,
		PR.MotivoRechazo,
		PR.Valor,
		P.Simbolo
	FROM GPR.LogGPRValidacion LGPRV
	INNER JOIN GPR.PedidoRechazado PR ON LGPRV.IdPedidoRechazado = PR.IdPedidoRechazado
	INNER JOIN GPR.MotivoRechazo MR WITH(NOLOCK) ON PR.MotivoRechazo = MR.Codigo AND MR.RequiereGestion = 1
	INNER JOIN dbo.Usuario U WITH(NOLOCK) ON LGPRV.CodigoUsuario = U.CodigoUsuario
	INNER JOIN [dbo].[Pais] P (nolock) ON U.PaisID = P.PaisID
	WHERE LGPRV.ProcesoValidacionPedidoRechazadoId = @ProcesoValidacionPedidoRechazadoId;
END

GO

USE BelcorpCostaRica
go


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado]
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
		MR.CodigoSomosBelcorp AS CodigoRechazoSomosBelcorp,
		PR.MotivoRechazo,
		PR.Valor,
		P.Simbolo
	FROM GPR.LogGPRValidacion LGPRV
	INNER JOIN GPR.PedidoRechazado PR ON LGPRV.IdPedidoRechazado = PR.IdPedidoRechazado
	INNER JOIN GPR.MotivoRechazo MR WITH(NOLOCK) ON PR.MotivoRechazo = MR.Codigo AND MR.RequiereGestion = 1
	INNER JOIN dbo.Usuario U WITH(NOLOCK) ON LGPRV.CodigoUsuario = U.CodigoUsuario
	INNER JOIN [dbo].[Pais] P (nolock) ON U.PaisID = P.PaisID
	WHERE LGPRV.ProcesoValidacionPedidoRechazadoId = @ProcesoValidacionPedidoRechazadoId;
END

GO

USE BelcorpDominicana
go


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado]
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
		MR.CodigoSomosBelcorp AS CodigoRechazoSomosBelcorp,
		PR.MotivoRechazo,
		PR.Valor,
		P.Simbolo
	FROM GPR.LogGPRValidacion LGPRV
	INNER JOIN GPR.PedidoRechazado PR ON LGPRV.IdPedidoRechazado = PR.IdPedidoRechazado
	INNER JOIN GPR.MotivoRechazo MR WITH(NOLOCK) ON PR.MotivoRechazo = MR.Codigo AND MR.RequiereGestion = 1
	INNER JOIN dbo.Usuario U WITH(NOLOCK) ON LGPRV.CodigoUsuario = U.CodigoUsuario
	INNER JOIN [dbo].[Pais] P (nolock) ON U.PaisID = P.PaisID
	WHERE LGPRV.ProcesoValidacionPedidoRechazadoId = @ProcesoValidacionPedidoRechazadoId;
END


GO


USE BelcorpEcuador
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado]
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
		MR.CodigoSomosBelcorp AS CodigoRechazoSomosBelcorp,
		PR.MotivoRechazo,
		PR.Valor,
		P.Simbolo
	FROM GPR.LogGPRValidacion LGPRV
	INNER JOIN GPR.PedidoRechazado PR ON LGPRV.IdPedidoRechazado = PR.IdPedidoRechazado
	INNER JOIN GPR.MotivoRechazo MR WITH(NOLOCK) ON PR.MotivoRechazo = MR.Codigo AND MR.RequiereGestion = 1
	INNER JOIN dbo.Usuario U WITH(NOLOCK) ON LGPRV.CodigoUsuario = U.CodigoUsuario
	INNER JOIN [dbo].[Pais] P (nolock) ON U.PaisID = P.PaisID
	WHERE LGPRV.ProcesoValidacionPedidoRechazadoId = @ProcesoValidacionPedidoRechazadoId;
END

GO


USE BelcorpGuatemala
GO


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado]
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
		MR.CodigoSomosBelcorp AS CodigoRechazoSomosBelcorp,
		PR.MotivoRechazo,
		PR.Valor,
		P.Simbolo
	FROM GPR.LogGPRValidacion LGPRV
	INNER JOIN GPR.PedidoRechazado PR ON LGPRV.IdPedidoRechazado = PR.IdPedidoRechazado
	INNER JOIN GPR.MotivoRechazo MR WITH(NOLOCK) ON PR.MotivoRechazo = MR.Codigo AND MR.RequiereGestion = 1
	INNER JOIN dbo.Usuario U WITH(NOLOCK) ON LGPRV.CodigoUsuario = U.CodigoUsuario
	INNER JOIN [dbo].[Pais] P (nolock) ON U.PaisID = P.PaisID
	WHERE LGPRV.ProcesoValidacionPedidoRechazadoId = @ProcesoValidacionPedidoRechazadoId;
END

GO

USE BelcorpPanama
go


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado]
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
		MR.CodigoSomosBelcorp AS CodigoRechazoSomosBelcorp,
		PR.MotivoRechazo,
		PR.Valor,
		P.Simbolo
	FROM GPR.LogGPRValidacion LGPRV
	INNER JOIN GPR.PedidoRechazado PR ON LGPRV.IdPedidoRechazado = PR.IdPedidoRechazado
	INNER JOIN GPR.MotivoRechazo MR WITH(NOLOCK) ON PR.MotivoRechazo = MR.Codigo AND MR.RequiereGestion = 1
	INNER JOIN dbo.Usuario U WITH(NOLOCK) ON LGPRV.CodigoUsuario = U.CodigoUsuario
	INNER JOIN [dbo].[Pais] P (nolock) ON U.PaisID = P.PaisID
	WHERE LGPRV.ProcesoValidacionPedidoRechazadoId = @ProcesoValidacionPedidoRechazadoId;
END


GO


USE BelcorpPuertoRico
go


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado]
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
		MR.CodigoSomosBelcorp AS CodigoRechazoSomosBelcorp,
		PR.MotivoRechazo,
		PR.Valor,
		P.Simbolo
	FROM GPR.LogGPRValidacion LGPRV
	INNER JOIN GPR.PedidoRechazado PR ON LGPRV.IdPedidoRechazado = PR.IdPedidoRechazado
	INNER JOIN GPR.MotivoRechazo MR WITH(NOLOCK) ON PR.MotivoRechazo = MR.Codigo AND MR.RequiereGestion = 1
	INNER JOIN dbo.Usuario U WITH(NOLOCK) ON LGPRV.CodigoUsuario = U.CodigoUsuario
	INNER JOIN [dbo].[Pais] P (nolock) ON U.PaisID = P.PaisID
	WHERE LGPRV.ProcesoValidacionPedidoRechazadoId = @ProcesoValidacionPedidoRechazadoId;
END


GO

USE BelcorpSalvador
go



IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado]
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
		MR.CodigoSomosBelcorp AS CodigoRechazoSomosBelcorp,
		PR.MotivoRechazo,
		PR.Valor,
		P.Simbolo
	FROM GPR.LogGPRValidacion LGPRV
	INNER JOIN GPR.PedidoRechazado PR ON LGPRV.IdPedidoRechazado = PR.IdPedidoRechazado
	INNER JOIN GPR.MotivoRechazo MR WITH(NOLOCK) ON PR.MotivoRechazo = MR.Codigo AND MR.RequiereGestion = 1
	INNER JOIN dbo.Usuario U WITH(NOLOCK) ON LGPRV.CodigoUsuario = U.CodigoUsuario
	INNER JOIN [dbo].[Pais] P (nolock) ON U.PaisID = P.PaisID
	WHERE LGPRV.ProcesoValidacionPedidoRechazadoId = @ProcesoValidacionPedidoRechazadoId;
END


GO


USE BelcorpVenezuela
go


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado]
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
		MR.CodigoSomosBelcorp AS CodigoRechazoSomosBelcorp,
		PR.MotivoRechazo,
		PR.Valor,
		P.Simbolo
	FROM GPR.LogGPRValidacion LGPRV
	INNER JOIN GPR.PedidoRechazado PR ON LGPRV.IdPedidoRechazado = PR.IdPedidoRechazado
	INNER JOIN GPR.MotivoRechazo MR WITH(NOLOCK) ON PR.MotivoRechazo = MR.Codigo AND MR.RequiereGestion = 1
	INNER JOIN dbo.Usuario U WITH(NOLOCK) ON LGPRV.CodigoUsuario = U.CodigoUsuario
	INNER JOIN [dbo].[Pais] P (nolock) ON U.PaisID = P.PaisID
	WHERE LGPRV.ProcesoValidacionPedidoRechazadoId = @ProcesoValidacionPedidoRechazadoId;
END


GO


-----------------------------------------------------------------------------------------------------------------

USE BelcorpColombia
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado]
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
		MR.CodigoSomosBelcorp AS CodigoRechazoSomosBelcorp,
		PR.MotivoRechazo,
		PR.Valor,
		P.Simbolo
	FROM GPR.LogGPRValidacion LGPRV
	INNER JOIN GPR.PedidoRechazado PR ON LGPRV.IdPedidoRechazado = PR.IdPedidoRechazado
	INNER JOIN GPR.MotivoRechazo MR WITH(NOLOCK) ON PR.MotivoRechazo = MR.Codigo AND MR.RequiereGestion = 1
	INNER JOIN dbo.Usuario U WITH(NOLOCK) ON LGPRV.CodigoUsuario = U.CodigoUsuario
	INNER JOIN [dbo].[Pais] P (nolock) ON U.PaisID = P.PaisID
	WHERE LGPRV.ProcesoValidacionPedidoRechazadoId = @ProcesoValidacionPedidoRechazadoId;
END

GO

USE BelcorpMexico
go


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado]
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
		MR.CodigoSomosBelcorp AS CodigoRechazoSomosBelcorp,
		PR.MotivoRechazo,
		PR.Valor,
		P.Simbolo
	FROM GPR.LogGPRValidacion LGPRV
	INNER JOIN GPR.PedidoRechazado PR ON LGPRV.IdPedidoRechazado = PR.IdPedidoRechazado
	INNER JOIN GPR.MotivoRechazo MR WITH(NOLOCK) ON PR.MotivoRechazo = MR.Codigo AND MR.RequiereGestion = 1
	INNER JOIN dbo.Usuario U WITH(NOLOCK) ON LGPRV.CodigoUsuario = U.CodigoUsuario
	INNER JOIN [dbo].[Pais] P (nolock) ON U.PaisID = P.PaisID
	WHERE LGPRV.ProcesoValidacionPedidoRechazadoId = @ProcesoValidacionPedidoRechazadoId;
END

GO

USE BelcorpPeru
go


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado]
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
		MR.CodigoSomosBelcorp AS CodigoRechazoSomosBelcorp,
		PR.MotivoRechazo,
		PR.Valor,
		P.Simbolo
	FROM GPR.LogGPRValidacion LGPRV
	INNER JOIN GPR.PedidoRechazado PR ON LGPRV.IdPedidoRechazado = PR.IdPedidoRechazado
	INNER JOIN GPR.MotivoRechazo MR WITH(NOLOCK) ON PR.MotivoRechazo = MR.Codigo AND MR.RequiereGestion = 1
	INNER JOIN dbo.Usuario U WITH(NOLOCK) ON LGPRV.CodigoUsuario = U.CodigoUsuario
	INNER JOIN [dbo].[Pais] P (nolock) ON U.PaisID = P.PaisID
	WHERE LGPRV.ProcesoValidacionPedidoRechazadoId = @ProcesoValidacionPedidoRechazadoId;
END

GO

