USE [BelcorpPeru]
GO

ALTER PROC GetReporteMovimientosPedido
(
	@CampaniaID INT = 0,
	@CodigoConsultora VARCHAR(30) = ''
)
AS
BEGIN

	DECLARE @consultoraId INT
	DECLARE @tipoAccionEliminacionProl INT

	SET @tipoAccionEliminacionProl = 201
	SET @consultoraId = (select consultoraid from ods.consultora where codigo = @CodigoConsultora)

	select
		pwaprol.Cuv, COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, pco.Descripcion) AS Descripcion, FechaAccion, 'PROL' as Origen, MensajeProl as Mensaje
	from 
		[dbo].[PedidoWebAccionesPROL] pwaprol
		LEFT join ods.productocomercial pco with(nolock) ON pwaprol.Cuv = pco.cuv and @CampaniaID = pco.anocampania
		LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON pco.CodigoProducto = MC.CodigoSAP
		LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = pco.anocampania AND OP.CUV = pco.CUV
		LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON pco.anocampania = PD.CampaniaID AND pco.CUV = PD.CUV
	where
		pwaprol.ConsultoraID = @consultoraId and 
		pwaprol.CampaniaID = @CampaniaID and
		pwaprol.Accion = @tipoAccionEliminacionProl

	UNION

	select
		pwdseg.Cuv, COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, pco.Descripcion) AS Descripcion, FechaAccion, 'CONSULTORA' as Origen, '' as Mensaje
	from 
		[dbo].[PedidoWebDetalleSeguimiento] pwdseg
		LEFT join ods.productocomercial pco with(nolock) ON pwdseg.Cuv = pco.cuv and @CampaniaID = pco.anocampania
		LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON pco.CodigoProducto = MC.CodigoSAP
		LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = pco.anocampania AND OP.CUV = pco.CUV
		LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON pco.anocampania = PD.CampaniaID AND pco.CUV = PD.CUV
	where
		pwdseg.ConsultoraID = @consultoraId and 
		pwdseg.CampaniaID = @CampaniaID

END
GO

USE [BelcorpBolivia]
GO

ALTER PROC GetReporteMovimientosPedido
(
	@CampaniaID INT = 0,
	@CodigoConsultora VARCHAR(30) = ''
)
AS
BEGIN

	DECLARE @consultoraId INT
	DECLARE @tipoAccionEliminacionProl INT

	SET @tipoAccionEliminacionProl = 201
	SET @consultoraId = (select consultoraid from ods.consultora where codigo = @CodigoConsultora)

	select
		pwaprol.Cuv, COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, pco.Descripcion) AS Descripcion, FechaAccion, 'PROL' as Origen, MensajeProl as Mensaje
	from 
		[dbo].[PedidoWebAccionesPROL] pwaprol
		LEFT join ods.productocomercial pco with(nolock) ON pwaprol.Cuv = pco.cuv and @CampaniaID = pco.anocampania
		LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON pco.CodigoProducto = MC.CodigoSAP
		LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = pco.anocampania AND OP.CUV = pco.CUV
		LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON pco.anocampania = PD.CampaniaID AND pco.CUV = PD.CUV
	where
		pwaprol.ConsultoraID = @consultoraId and 
		pwaprol.CampaniaID = @CampaniaID and
		pwaprol.Accion = @tipoAccionEliminacionProl

	UNION

	select
		pwdseg.Cuv, COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, pco.Descripcion) AS Descripcion, FechaAccion, 'CONSULTORA' as Origen, '' as Mensaje
	from 
		[dbo].[PedidoWebDetalleSeguimiento] pwdseg
		LEFT join ods.productocomercial pco with(nolock) ON pwdseg.Cuv = pco.cuv and @CampaniaID = pco.anocampania
		LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON pco.CodigoProducto = MC.CodigoSAP
		LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = pco.anocampania AND OP.CUV = pco.CUV
		LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON pco.anocampania = PD.CampaniaID AND pco.CUV = PD.CUV
	where
		pwdseg.ConsultoraID = @consultoraId and 
		pwdseg.CampaniaID = @CampaniaID

END
GO

USE [BelcorpChile]
GO

ALTER PROC GetReporteMovimientosPedido
(
	@CampaniaID INT = 0,
	@CodigoConsultora VARCHAR(30) = ''
)
AS
BEGIN

	DECLARE @consultoraId INT
	DECLARE @tipoAccionEliminacionProl INT

	SET @tipoAccionEliminacionProl = 201
	SET @consultoraId = (select consultoraid from ods.consultora where codigo = @CodigoConsultora)

	select
		pwaprol.Cuv, COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, pco.Descripcion) AS Descripcion, FechaAccion, 'PROL' as Origen, MensajeProl as Mensaje
	from 
		[dbo].[PedidoWebAccionesPROL] pwaprol
		LEFT join ods.productocomercial pco with(nolock) ON pwaprol.Cuv = pco.cuv and @CampaniaID = pco.anocampania
		LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON pco.CodigoProducto = MC.CodigoSAP
		LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = pco.anocampania AND OP.CUV = pco.CUV
		LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON pco.anocampania = PD.CampaniaID AND pco.CUV = PD.CUV
	where
		pwaprol.ConsultoraID = @consultoraId and 
		pwaprol.CampaniaID = @CampaniaID and
		pwaprol.Accion = @tipoAccionEliminacionProl

	UNION

	select
		pwdseg.Cuv, COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, pco.Descripcion) AS Descripcion, FechaAccion, 'CONSULTORA' as Origen, '' as Mensaje
	from 
		[dbo].[PedidoWebDetalleSeguimiento] pwdseg
		LEFT join ods.productocomercial pco with(nolock) ON pwdseg.Cuv = pco.cuv and @CampaniaID = pco.anocampania
		LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON pco.CodigoProducto = MC.CodigoSAP
		LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = pco.anocampania AND OP.CUV = pco.CUV
		LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON pco.anocampania = PD.CampaniaID AND pco.CUV = PD.CUV
	where
		pwdseg.ConsultoraID = @consultoraId and 
		pwdseg.CampaniaID = @CampaniaID

END
GO

USE [BelcorpColombia]
GO

ALTER PROC GetReporteMovimientosPedido
(
	@CampaniaID INT = 0,
	@CodigoConsultora VARCHAR(30) = ''
)
AS
BEGIN

	DECLARE @consultoraId INT
	DECLARE @tipoAccionEliminacionProl INT

	SET @tipoAccionEliminacionProl = 201
	SET @consultoraId = (select consultoraid from ods.consultora where codigo = @CodigoConsultora)

	select
		pwaprol.Cuv, COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, pco.Descripcion) AS Descripcion, FechaAccion, 'PROL' as Origen, MensajeProl as Mensaje
	from 
		[dbo].[PedidoWebAccionesPROL] pwaprol
		LEFT join ods.productocomercial pco with(nolock) ON pwaprol.Cuv = pco.cuv and @CampaniaID = pco.anocampania
		LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON pco.CodigoProducto = MC.CodigoSAP
		LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = pco.anocampania AND OP.CUV = pco.CUV
		LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON pco.anocampania = PD.CampaniaID AND pco.CUV = PD.CUV
	where
		pwaprol.ConsultoraID = @consultoraId and 
		pwaprol.CampaniaID = @CampaniaID and
		pwaprol.Accion = @tipoAccionEliminacionProl

	UNION

	select
		pwdseg.Cuv, COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, pco.Descripcion) AS Descripcion, FechaAccion, 'CONSULTORA' as Origen, '' as Mensaje
	from 
		[dbo].[PedidoWebDetalleSeguimiento] pwdseg
		LEFT join ods.productocomercial pco with(nolock) ON pwdseg.Cuv = pco.cuv and @CampaniaID = pco.anocampania
		LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON pco.CodigoProducto = MC.CodigoSAP
		LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = pco.anocampania AND OP.CUV = pco.CUV
		LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON pco.anocampania = PD.CampaniaID AND pco.CUV = PD.CUV
	where
		pwdseg.ConsultoraID = @consultoraId and 
		pwdseg.CampaniaID = @CampaniaID

END
GO

USE [BelcorpCostaRica]
GO

ALTER PROC GetReporteMovimientosPedido
(
	@CampaniaID INT = 0,
	@CodigoConsultora VARCHAR(30) = ''
)
AS
BEGIN

	DECLARE @consultoraId INT
	DECLARE @tipoAccionEliminacionProl INT

	SET @tipoAccionEliminacionProl = 201
	SET @consultoraId = (select consultoraid from ods.consultora where codigo = @CodigoConsultora)

	select
		pwaprol.Cuv, COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, pco.Descripcion) AS Descripcion, FechaAccion, 'PROL' as Origen, MensajeProl as Mensaje
	from 
		[dbo].[PedidoWebAccionesPROL] pwaprol
		LEFT join ods.productocomercial pco with(nolock) ON pwaprol.Cuv = pco.cuv and @CampaniaID = pco.anocampania
		LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON pco.CodigoProducto = MC.CodigoSAP
		LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = pco.anocampania AND OP.CUV = pco.CUV
		LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON pco.anocampania = PD.CampaniaID AND pco.CUV = PD.CUV
	where
		pwaprol.ConsultoraID = @consultoraId and 
		pwaprol.CampaniaID = @CampaniaID and
		pwaprol.Accion = @tipoAccionEliminacionProl

	UNION

	select
		pwdseg.Cuv, COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, pco.Descripcion) AS Descripcion, FechaAccion, 'CONSULTORA' as Origen, '' as Mensaje
	from 
		[dbo].[PedidoWebDetalleSeguimiento] pwdseg
		LEFT join ods.productocomercial pco with(nolock) ON pwdseg.Cuv = pco.cuv and @CampaniaID = pco.anocampania
		LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON pco.CodigoProducto = MC.CodigoSAP
		LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = pco.anocampania AND OP.CUV = pco.CUV
		LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON pco.anocampania = PD.CampaniaID AND pco.CUV = PD.CUV
	where
		pwdseg.ConsultoraID = @consultoraId and 
		pwdseg.CampaniaID = @CampaniaID

END
GO

USE [BelcorpDominicana]
GO

ALTER PROC GetReporteMovimientosPedido
(
	@CampaniaID INT = 0,
	@CodigoConsultora VARCHAR(30) = ''
)
AS
BEGIN

	DECLARE @consultoraId INT
	DECLARE @tipoAccionEliminacionProl INT

	SET @tipoAccionEliminacionProl = 201
	SET @consultoraId = (select consultoraid from ods.consultora where codigo = @CodigoConsultora)

	select
		pwaprol.Cuv, COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, pco.Descripcion) AS Descripcion, FechaAccion, 'PROL' as Origen, MensajeProl as Mensaje
	from 
		[dbo].[PedidoWebAccionesPROL] pwaprol
		LEFT join ods.productocomercial pco with(nolock) ON pwaprol.Cuv = pco.cuv and @CampaniaID = pco.anocampania
		LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON pco.CodigoProducto = MC.CodigoSAP
		LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = pco.anocampania AND OP.CUV = pco.CUV
		LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON pco.anocampania = PD.CampaniaID AND pco.CUV = PD.CUV
	where
		pwaprol.ConsultoraID = @consultoraId and 
		pwaprol.CampaniaID = @CampaniaID and
		pwaprol.Accion = @tipoAccionEliminacionProl

	UNION

	select
		pwdseg.Cuv, COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, pco.Descripcion) AS Descripcion, FechaAccion, 'CONSULTORA' as Origen, '' as Mensaje
	from 
		[dbo].[PedidoWebDetalleSeguimiento] pwdseg
		LEFT join ods.productocomercial pco with(nolock) ON pwdseg.Cuv = pco.cuv and @CampaniaID = pco.anocampania
		LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON pco.CodigoProducto = MC.CodigoSAP
		LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = pco.anocampania AND OP.CUV = pco.CUV
		LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON pco.anocampania = PD.CampaniaID AND pco.CUV = PD.CUV
	where
		pwdseg.ConsultoraID = @consultoraId and 
		pwdseg.CampaniaID = @CampaniaID

END
GO

USE [BelcorpEcuador]
GO

ALTER PROC GetReporteMovimientosPedido
(
	@CampaniaID INT = 0,
	@CodigoConsultora VARCHAR(30) = ''
)
AS
BEGIN

	DECLARE @consultoraId INT
	DECLARE @tipoAccionEliminacionProl INT

	SET @tipoAccionEliminacionProl = 201
	SET @consultoraId = (select consultoraid from ods.consultora where codigo = @CodigoConsultora)

	select
		pwaprol.Cuv, COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, pco.Descripcion) AS Descripcion, FechaAccion, 'PROL' as Origen, MensajeProl as Mensaje
	from 
		[dbo].[PedidoWebAccionesPROL] pwaprol
		LEFT join ods.productocomercial pco with(nolock) ON pwaprol.Cuv = pco.cuv and @CampaniaID = pco.anocampania
		LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON pco.CodigoProducto = MC.CodigoSAP
		LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = pco.anocampania AND OP.CUV = pco.CUV
		LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON pco.anocampania = PD.CampaniaID AND pco.CUV = PD.CUV
	where
		pwaprol.ConsultoraID = @consultoraId and 
		pwaprol.CampaniaID = @CampaniaID and
		pwaprol.Accion = @tipoAccionEliminacionProl

	UNION

	select
		pwdseg.Cuv, COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, pco.Descripcion) AS Descripcion, FechaAccion, 'CONSULTORA' as Origen, '' as Mensaje
	from 
		[dbo].[PedidoWebDetalleSeguimiento] pwdseg
		LEFT join ods.productocomercial pco with(nolock) ON pwdseg.Cuv = pco.cuv and @CampaniaID = pco.anocampania
		LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON pco.CodigoProducto = MC.CodigoSAP
		LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = pco.anocampania AND OP.CUV = pco.CUV
		LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON pco.anocampania = PD.CampaniaID AND pco.CUV = PD.CUV
	where
		pwdseg.ConsultoraID = @consultoraId and 
		pwdseg.CampaniaID = @CampaniaID

END
GO

USE [BelcorpGuatemala]
GO

ALTER PROC GetReporteMovimientosPedido
(
	@CampaniaID INT = 0,
	@CodigoConsultora VARCHAR(30) = ''
)
AS
BEGIN

	DECLARE @consultoraId INT
	DECLARE @tipoAccionEliminacionProl INT

	SET @tipoAccionEliminacionProl = 201
	SET @consultoraId = (select consultoraid from ods.consultora where codigo = @CodigoConsultora)

	select
		pwaprol.Cuv, COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, pco.Descripcion) AS Descripcion, FechaAccion, 'PROL' as Origen, MensajeProl as Mensaje
	from 
		[dbo].[PedidoWebAccionesPROL] pwaprol
		LEFT join ods.productocomercial pco with(nolock) ON pwaprol.Cuv = pco.cuv and @CampaniaID = pco.anocampania
		LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON pco.CodigoProducto = MC.CodigoSAP
		LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = pco.anocampania AND OP.CUV = pco.CUV
		LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON pco.anocampania = PD.CampaniaID AND pco.CUV = PD.CUV
	where
		pwaprol.ConsultoraID = @consultoraId and 
		pwaprol.CampaniaID = @CampaniaID and
		pwaprol.Accion = @tipoAccionEliminacionProl

	UNION

	select
		pwdseg.Cuv, COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, pco.Descripcion) AS Descripcion, FechaAccion, 'CONSULTORA' as Origen, '' as Mensaje
	from 
		[dbo].[PedidoWebDetalleSeguimiento] pwdseg
		LEFT join ods.productocomercial pco with(nolock) ON pwdseg.Cuv = pco.cuv and @CampaniaID = pco.anocampania
		LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON pco.CodigoProducto = MC.CodigoSAP
		LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = pco.anocampania AND OP.CUV = pco.CUV
		LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON pco.anocampania = PD.CampaniaID AND pco.CUV = PD.CUV
	where
		pwdseg.ConsultoraID = @consultoraId and 
		pwdseg.CampaniaID = @CampaniaID

END
GO

USE [BelcorpMexico]
GO

ALTER PROC GetReporteMovimientosPedido
(
	@CampaniaID INT = 0,
	@CodigoConsultora VARCHAR(30) = ''
)
AS
BEGIN

	DECLARE @consultoraId INT
	DECLARE @tipoAccionEliminacionProl INT

	SET @tipoAccionEliminacionProl = 201
	SET @consultoraId = (select consultoraid from ods.consultora where codigo = @CodigoConsultora)

	select
		pwaprol.Cuv, COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, pco.Descripcion) AS Descripcion, FechaAccion, 'PROL' as Origen, MensajeProl as Mensaje
	from 
		[dbo].[PedidoWebAccionesPROL] pwaprol
		LEFT join ods.productocomercial pco with(nolock) ON pwaprol.Cuv = pco.cuv and @CampaniaID = pco.anocampania
		LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON pco.CodigoProducto = MC.CodigoSAP
		LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = pco.anocampania AND OP.CUV = pco.CUV
		LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON pco.anocampania = PD.CampaniaID AND pco.CUV = PD.CUV
	where
		pwaprol.ConsultoraID = @consultoraId and 
		pwaprol.CampaniaID = @CampaniaID and
		pwaprol.Accion = @tipoAccionEliminacionProl

	UNION

	select
		pwdseg.Cuv, COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, pco.Descripcion) AS Descripcion, FechaAccion, 'CONSULTORA' as Origen, '' as Mensaje
	from 
		[dbo].[PedidoWebDetalleSeguimiento] pwdseg
		LEFT join ods.productocomercial pco with(nolock) ON pwdseg.Cuv = pco.cuv and @CampaniaID = pco.anocampania
		LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON pco.CodigoProducto = MC.CodigoSAP
		LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = pco.anocampania AND OP.CUV = pco.CUV
		LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON pco.anocampania = PD.CampaniaID AND pco.CUV = PD.CUV
	where
		pwdseg.ConsultoraID = @consultoraId and 
		pwdseg.CampaniaID = @CampaniaID

END
GO

USE [BelcorpPanama]
GO

ALTER PROC GetReporteMovimientosPedido
(
	@CampaniaID INT = 0,
	@CodigoConsultora VARCHAR(30) = ''
)
AS
BEGIN

	DECLARE @consultoraId INT
	DECLARE @tipoAccionEliminacionProl INT

	SET @tipoAccionEliminacionProl = 201
	SET @consultoraId = (select consultoraid from ods.consultora where codigo = @CodigoConsultora)

	select
		pwaprol.Cuv, COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, pco.Descripcion) AS Descripcion, FechaAccion, 'PROL' as Origen, MensajeProl as Mensaje
	from 
		[dbo].[PedidoWebAccionesPROL] pwaprol
		LEFT join ods.productocomercial pco with(nolock) ON pwaprol.Cuv = pco.cuv and @CampaniaID = pco.anocampania
		LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON pco.CodigoProducto = MC.CodigoSAP
		LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = pco.anocampania AND OP.CUV = pco.CUV
		LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON pco.anocampania = PD.CampaniaID AND pco.CUV = PD.CUV
	where
		pwaprol.ConsultoraID = @consultoraId and 
		pwaprol.CampaniaID = @CampaniaID and
		pwaprol.Accion = @tipoAccionEliminacionProl

	UNION

	select
		pwdseg.Cuv, COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, pco.Descripcion) AS Descripcion, FechaAccion, 'CONSULTORA' as Origen, '' as Mensaje
	from 
		[dbo].[PedidoWebDetalleSeguimiento] pwdseg
		LEFT join ods.productocomercial pco with(nolock) ON pwdseg.Cuv = pco.cuv and @CampaniaID = pco.anocampania
		LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON pco.CodigoProducto = MC.CodigoSAP
		LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = pco.anocampania AND OP.CUV = pco.CUV
		LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON pco.anocampania = PD.CampaniaID AND pco.CUV = PD.CUV
	where
		pwdseg.ConsultoraID = @consultoraId and 
		pwdseg.CampaniaID = @CampaniaID

END
GO

USE [BelcorpPuertoRico]
GO

ALTER PROC GetReporteMovimientosPedido
(
	@CampaniaID INT = 0,
	@CodigoConsultora VARCHAR(30) = ''
)
AS
BEGIN

	DECLARE @consultoraId INT
	DECLARE @tipoAccionEliminacionProl INT

	SET @tipoAccionEliminacionProl = 201
	SET @consultoraId = (select consultoraid from ods.consultora where codigo = @CodigoConsultora)

	select
		pwaprol.Cuv, COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, pco.Descripcion) AS Descripcion, FechaAccion, 'PROL' as Origen, MensajeProl as Mensaje
	from 
		[dbo].[PedidoWebAccionesPROL] pwaprol
		LEFT join ods.productocomercial pco with(nolock) ON pwaprol.Cuv = pco.cuv and @CampaniaID = pco.anocampania
		LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON pco.CodigoProducto = MC.CodigoSAP
		LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = pco.anocampania AND OP.CUV = pco.CUV
		LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON pco.anocampania = PD.CampaniaID AND pco.CUV = PD.CUV
	where
		pwaprol.ConsultoraID = @consultoraId and 
		pwaprol.CampaniaID = @CampaniaID and
		pwaprol.Accion = @tipoAccionEliminacionProl

	UNION

	select
		pwdseg.Cuv, COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, pco.Descripcion) AS Descripcion, FechaAccion, 'CONSULTORA' as Origen, '' as Mensaje
	from 
		[dbo].[PedidoWebDetalleSeguimiento] pwdseg
		LEFT join ods.productocomercial pco with(nolock) ON pwdseg.Cuv = pco.cuv and @CampaniaID = pco.anocampania
		LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON pco.CodigoProducto = MC.CodigoSAP
		LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = pco.anocampania AND OP.CUV = pco.CUV
		LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON pco.anocampania = PD.CampaniaID AND pco.CUV = PD.CUV
	where
		pwdseg.ConsultoraID = @consultoraId and 
		pwdseg.CampaniaID = @CampaniaID

END
GO

USE [BelcorpSalvador]
GO

ALTER PROC GetReporteMovimientosPedido
(
	@CampaniaID INT = 0,
	@CodigoConsultora VARCHAR(30) = ''
)
AS
BEGIN

	DECLARE @consultoraId INT
	DECLARE @tipoAccionEliminacionProl INT

	SET @tipoAccionEliminacionProl = 201
	SET @consultoraId = (select consultoraid from ods.consultora where codigo = @CodigoConsultora)

	select
		pwaprol.Cuv, COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, pco.Descripcion) AS Descripcion, FechaAccion, 'PROL' as Origen, MensajeProl as Mensaje
	from 
		[dbo].[PedidoWebAccionesPROL] pwaprol
		LEFT join ods.productocomercial pco with(nolock) ON pwaprol.Cuv = pco.cuv and @CampaniaID = pco.anocampania
		LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON pco.CodigoProducto = MC.CodigoSAP
		LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = pco.anocampania AND OP.CUV = pco.CUV
		LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON pco.anocampania = PD.CampaniaID AND pco.CUV = PD.CUV
	where
		pwaprol.ConsultoraID = @consultoraId and 
		pwaprol.CampaniaID = @CampaniaID and
		pwaprol.Accion = @tipoAccionEliminacionProl

	UNION

	select
		pwdseg.Cuv, COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, pco.Descripcion) AS Descripcion, FechaAccion, 'CONSULTORA' as Origen, '' as Mensaje
	from 
		[dbo].[PedidoWebDetalleSeguimiento] pwdseg
		LEFT join ods.productocomercial pco with(nolock) ON pwdseg.Cuv = pco.cuv and @CampaniaID = pco.anocampania
		LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON pco.CodigoProducto = MC.CodigoSAP
		LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = pco.anocampania AND OP.CUV = pco.CUV
		LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON pco.anocampania = PD.CampaniaID AND pco.CUV = PD.CUV
	where
		pwdseg.ConsultoraID = @consultoraId and 
		pwdseg.CampaniaID = @CampaniaID

END
GO


