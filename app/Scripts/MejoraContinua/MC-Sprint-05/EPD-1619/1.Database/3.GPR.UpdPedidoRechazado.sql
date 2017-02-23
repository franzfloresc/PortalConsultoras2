USE BelcorpPeru
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[UpdPedidoRechazado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[UpdPedidoRechazado]
GO

CREATE PROCEDURE GPR.UpdPedidoRechazado
	@IdProcesoPedidoRechazado BIGINT,
	@CodigoConsultora VARCHAR(15),
	@Rechazado BIT,
	@CodigoRechazoSomosBelcorp VARCHAR(8)
AS
BEGIN
	UPDATE PR
	SET 
		PR.Procesado = 1,
		PR.Rechazado = @Rechazado,
		PR.CodigoRechazoSomosBelcorp = CASE 
											WHEN MR.Codigo = 'OCC-16' THEN 'MONTO MÍNIMO' 
											WHEN MR.Codigo = 'OCC-17' THEN 'MONTO MAXIMO'
											WHEN MR.Codigo = 'OCC-19' THEN 'DEUDA'
											WHEN MR.Codigo = 'OCC-51' THEN 'MONTO MINIMO STOCK' 
										END
	FROM GPR.PedidoRechazado PR
	INNER JOIN GPR.MotivoRechazo MR ON PR.MotivoRechazo = MR.Codigo
	WHERE PR.IdProcesoPedidoRechazado = @IdProcesoPedidoRechazado AND PR.CodigoConsultora= @CodigoConsultora
END

GO
-------------------------------------------------------------------------------------------------------

USE BelcorpMexico
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[UpdPedidoRechazado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[UpdPedidoRechazado]
GO

CREATE PROCEDURE GPR.UpdPedidoRechazado
	@IdProcesoPedidoRechazado BIGINT,
	@CodigoConsultora VARCHAR(15),
	@Rechazado BIT,
	@CodigoRechazoSomosBelcorp VARCHAR(8)
AS
BEGIN
	UPDATE PR
	SET 
		PR.Procesado = 1,
		PR.Rechazado = @Rechazado,
		PR.CodigoRechazoSomosBelcorp = CASE 
											WHEN MR.Codigo = 'OCC-16' THEN 'MONTO MÍNIMO' 
											WHEN MR.Codigo = 'OCC-17' THEN 'MONTO MAXIMO'
											WHEN MR.Codigo = 'OCC-19' THEN 'DEUDA'
											WHEN MR.Codigo = 'OCC-51' THEN 'MONTO MINIMO STOCK' 
										END
	FROM GPR.PedidoRechazado PR
	INNER JOIN GPR.MotivoRechazo MR ON PR.MotivoRechazo = MR.Codigo
	WHERE PR.IdProcesoPedidoRechazado = @IdProcesoPedidoRechazado AND PR.CodigoConsultora= @CodigoConsultora
END

GO
-------------------------------------------------------------------------------------------------------

USE BelcorpColombia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[UpdPedidoRechazado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[UpdPedidoRechazado]
GO

CREATE PROCEDURE GPR.UpdPedidoRechazado
	@IdProcesoPedidoRechazado BIGINT,
	@CodigoConsultora VARCHAR(15),
	@Rechazado BIT,
	@CodigoRechazoSomosBelcorp VARCHAR(8)
AS
BEGIN
	UPDATE PR
	SET 
		PR.Procesado = 1,
		PR.Rechazado = @Rechazado,
		PR.CodigoRechazoSomosBelcorp = CASE 
											WHEN MR.Codigo = 'OCC-16' THEN 'MONTO MÍNIMO' 
											WHEN MR.Codigo = 'OCC-17' THEN 'MONTO MAXIMO'
											WHEN MR.Codigo = 'OCC-19' THEN 'DEUDA'
											WHEN MR.Codigo = 'OCC-51' THEN 'MONTO MINIMO STOCK' 
										END
	FROM GPR.PedidoRechazado PR
	INNER JOIN GPR.MotivoRechazo MR ON PR.MotivoRechazo = MR.Codigo
	WHERE PR.IdProcesoPedidoRechazado = @IdProcesoPedidoRechazado AND PR.CodigoConsultora= @CodigoConsultora
END

GO
-------------------------------------------------------------------------------------------------------

USE BelcorpVenezuela
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[UpdPedidoRechazado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[UpdPedidoRechazado]
GO

CREATE PROCEDURE GPR.UpdPedidoRechazado
	@IdProcesoPedidoRechazado BIGINT,
	@CodigoConsultora VARCHAR(15),
	@Rechazado BIT,
	@CodigoRechazoSomosBelcorp VARCHAR(8)
AS
BEGIN
	UPDATE PR
	SET 
		PR.Procesado = 1,
		PR.Rechazado = @Rechazado,
		PR.CodigoRechazoSomosBelcorp = CASE 
											WHEN MR.Codigo = 'OCC-16' THEN 'MONTO MÍNIMO' 
											WHEN MR.Codigo = 'OCC-17' THEN 'MONTO MAXIMO'
											WHEN MR.Codigo = 'OCC-19' THEN 'DEUDA'
											WHEN MR.Codigo = 'OCC-51' THEN 'MONTO MINIMO STOCK' 
										END
	FROM GPR.PedidoRechazado PR
	INNER JOIN GPR.MotivoRechazo MR ON PR.MotivoRechazo = MR.Codigo
	WHERE PR.IdProcesoPedidoRechazado = @IdProcesoPedidoRechazado AND PR.CodigoConsultora= @CodigoConsultora
END

GO
-------------------------------------------------------------------------------------------------------

USE BelcorpSalvador
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[UpdPedidoRechazado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[UpdPedidoRechazado]
GO

CREATE PROCEDURE GPR.UpdPedidoRechazado
	@IdProcesoPedidoRechazado BIGINT,
	@CodigoConsultora VARCHAR(15),
	@Rechazado BIT,
	@CodigoRechazoSomosBelcorp VARCHAR(8)
AS
BEGIN
	UPDATE PR
	SET 
		PR.Procesado = 1,
		PR.Rechazado = @Rechazado,
		PR.CodigoRechazoSomosBelcorp = CASE 
											WHEN MR.Codigo = 'OCC-16' THEN 'MONTO MÍNIMO' 
											WHEN MR.Codigo = 'OCC-17' THEN 'MONTO MAXIMO'
											WHEN MR.Codigo = 'OCC-19' THEN 'DEUDA'
											WHEN MR.Codigo = 'OCC-51' THEN 'MONTO MINIMO STOCK' 
										END
	FROM GPR.PedidoRechazado PR
	INNER JOIN GPR.MotivoRechazo MR ON PR.MotivoRechazo = MR.Codigo
	WHERE PR.IdProcesoPedidoRechazado = @IdProcesoPedidoRechazado AND PR.CodigoConsultora= @CodigoConsultora
END

GO
-------------------------------------------------------------------------------------------------------

USE BelcorpPuertoRico
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[UpdPedidoRechazado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[UpdPedidoRechazado]
GO

CREATE PROCEDURE GPR.UpdPedidoRechazado
	@IdProcesoPedidoRechazado BIGINT,
	@CodigoConsultora VARCHAR(15),
	@Rechazado BIT,
	@CodigoRechazoSomosBelcorp VARCHAR(8)
AS
BEGIN
	UPDATE PR
	SET 
		PR.Procesado = 1,
		PR.Rechazado = @Rechazado,
		PR.CodigoRechazoSomosBelcorp = CASE 
											WHEN MR.Codigo = 'OCC-16' THEN 'MONTO MÍNIMO' 
											WHEN MR.Codigo = 'OCC-17' THEN 'MONTO MAXIMO'
											WHEN MR.Codigo = 'OCC-19' THEN 'DEUDA'
											WHEN MR.Codigo = 'OCC-51' THEN 'MONTO MINIMO STOCK' 
										END
	FROM GPR.PedidoRechazado PR
	INNER JOIN GPR.MotivoRechazo MR ON PR.MotivoRechazo = MR.Codigo
	WHERE PR.IdProcesoPedidoRechazado = @IdProcesoPedidoRechazado AND PR.CodigoConsultora= @CodigoConsultora
END

GO
-------------------------------------------------------------------------------------------------------

USE BelcorpPanama
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[UpdPedidoRechazado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[UpdPedidoRechazado]
GO

CREATE PROCEDURE GPR.UpdPedidoRechazado
	@IdProcesoPedidoRechazado BIGINT,
	@CodigoConsultora VARCHAR(15),
	@Rechazado BIT,
	@CodigoRechazoSomosBelcorp VARCHAR(8)
AS
BEGIN
	UPDATE PR
	SET 
		PR.Procesado = 1,
		PR.Rechazado = @Rechazado,
		PR.CodigoRechazoSomosBelcorp = CASE 
											WHEN MR.Codigo = 'OCC-16' THEN 'MONTO MÍNIMO' 
											WHEN MR.Codigo = 'OCC-17' THEN 'MONTO MAXIMO'
											WHEN MR.Codigo = 'OCC-19' THEN 'DEUDA'
											WHEN MR.Codigo = 'OCC-51' THEN 'MONTO MINIMO STOCK' 
										END
	FROM GPR.PedidoRechazado PR
	INNER JOIN GPR.MotivoRechazo MR ON PR.MotivoRechazo = MR.Codigo
	WHERE PR.IdProcesoPedidoRechazado = @IdProcesoPedidoRechazado AND PR.CodigoConsultora= @CodigoConsultora
END

GO
-------------------------------------------------------------------------------------------------------

USE BelcorpGuatemala
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[UpdPedidoRechazado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[UpdPedidoRechazado]
GO

CREATE PROCEDURE GPR.UpdPedidoRechazado
	@IdProcesoPedidoRechazado BIGINT,
	@CodigoConsultora VARCHAR(15),
	@Rechazado BIT,
	@CodigoRechazoSomosBelcorp VARCHAR(8)
AS
BEGIN
	UPDATE PR
	SET 
		PR.Procesado = 1,
		PR.Rechazado = @Rechazado,
		PR.CodigoRechazoSomosBelcorp = CASE 
											WHEN MR.Codigo = 'OCC-16' THEN 'MONTO MÍNIMO' 
											WHEN MR.Codigo = 'OCC-17' THEN 'MONTO MAXIMO'
											WHEN MR.Codigo = 'OCC-19' THEN 'DEUDA'
											WHEN MR.Codigo = 'OCC-51' THEN 'MONTO MINIMO STOCK' 
										END
	FROM GPR.PedidoRechazado PR
	INNER JOIN GPR.MotivoRechazo MR ON PR.MotivoRechazo = MR.Codigo
	WHERE PR.IdProcesoPedidoRechazado = @IdProcesoPedidoRechazado AND PR.CodigoConsultora= @CodigoConsultora
END

GO
-------------------------------------------------------------------------------------------------------

USE BelcorpEcuador
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[UpdPedidoRechazado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[UpdPedidoRechazado]
GO

CREATE PROCEDURE GPR.UpdPedidoRechazado
	@IdProcesoPedidoRechazado BIGINT,
	@CodigoConsultora VARCHAR(15),
	@Rechazado BIT,
	@CodigoRechazoSomosBelcorp VARCHAR(8)
AS
BEGIN
	UPDATE PR
	SET 
		PR.Procesado = 1,
		PR.Rechazado = @Rechazado,
		PR.CodigoRechazoSomosBelcorp = CASE 
											WHEN MR.Codigo = 'OCC-16' THEN 'MONTO MÍNIMO' 
											WHEN MR.Codigo = 'OCC-17' THEN 'MONTO MAXIMO'
											WHEN MR.Codigo = 'OCC-19' THEN 'DEUDA'
											WHEN MR.Codigo = 'OCC-51' THEN 'MONTO MINIMO STOCK' 
										END
	FROM GPR.PedidoRechazado PR
	INNER JOIN GPR.MotivoRechazo MR ON PR.MotivoRechazo = MR.Codigo
	WHERE PR.IdProcesoPedidoRechazado = @IdProcesoPedidoRechazado AND PR.CodigoConsultora= @CodigoConsultora
END

GO
-------------------------------------------------------------------------------------------------------

USE BelcorpDominicana
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[UpdPedidoRechazado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[UpdPedidoRechazado]
GO

CREATE PROCEDURE GPR.UpdPedidoRechazado
	@IdProcesoPedidoRechazado BIGINT,
	@CodigoConsultora VARCHAR(15),
	@Rechazado BIT,
	@CodigoRechazoSomosBelcorp VARCHAR(8)
AS
BEGIN
	UPDATE PR
	SET 
		PR.Procesado = 1,
		PR.Rechazado = @Rechazado,
		PR.CodigoRechazoSomosBelcorp = CASE 
											WHEN MR.Codigo = 'OCC-16' THEN 'MONTO MÍNIMO' 
											WHEN MR.Codigo = 'OCC-17' THEN 'MONTO MAXIMO'
											WHEN MR.Codigo = 'OCC-19' THEN 'DEUDA'
											WHEN MR.Codigo = 'OCC-51' THEN 'MONTO MINIMO STOCK' 
										END
	FROM GPR.PedidoRechazado PR
	INNER JOIN GPR.MotivoRechazo MR ON PR.MotivoRechazo = MR.Codigo
	WHERE PR.IdProcesoPedidoRechazado = @IdProcesoPedidoRechazado AND PR.CodigoConsultora= @CodigoConsultora
END

GO
-------------------------------------------------------------------------------------------------------

USE BelcorpCostaRica
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[UpdPedidoRechazado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[UpdPedidoRechazado]
GO

CREATE PROCEDURE GPR.UpdPedidoRechazado
	@IdProcesoPedidoRechazado BIGINT,
	@CodigoConsultora VARCHAR(15),
	@Rechazado BIT,
	@CodigoRechazoSomosBelcorp VARCHAR(8)
AS
BEGIN
	UPDATE PR
	SET 
		PR.Procesado = 1,
		PR.Rechazado = @Rechazado,
		PR.CodigoRechazoSomosBelcorp = CASE 
											WHEN MR.Codigo = 'OCC-16' THEN 'MONTO MÍNIMO' 
											WHEN MR.Codigo = 'OCC-17' THEN 'MONTO MAXIMO'
											WHEN MR.Codigo = 'OCC-19' THEN 'DEUDA'
											WHEN MR.Codigo = 'OCC-51' THEN 'MONTO MINIMO STOCK' 
										END
	FROM GPR.PedidoRechazado PR
	INNER JOIN GPR.MotivoRechazo MR ON PR.MotivoRechazo = MR.Codigo
	WHERE PR.IdProcesoPedidoRechazado = @IdProcesoPedidoRechazado AND PR.CodigoConsultora= @CodigoConsultora
END

GO
-------------------------------------------------------------------------------------------------------

USE BelcorpChile
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[UpdPedidoRechazado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[UpdPedidoRechazado]
GO

CREATE PROCEDURE GPR.UpdPedidoRechazado
	@IdProcesoPedidoRechazado BIGINT,
	@CodigoConsultora VARCHAR(15),
	@Rechazado BIT,
	@CodigoRechazoSomosBelcorp VARCHAR(8)
AS
BEGIN
	UPDATE PR
	SET 
		PR.Procesado = 1,
		PR.Rechazado = @Rechazado,
		PR.CodigoRechazoSomosBelcorp = CASE 
											WHEN MR.Codigo = 'OCC-16' THEN 'MONTO MÍNIMO' 
											WHEN MR.Codigo = 'OCC-17' THEN 'MONTO MAXIMO'
											WHEN MR.Codigo = 'OCC-19' THEN 'DEUDA'
											WHEN MR.Codigo = 'OCC-51' THEN 'MONTO MINIMO STOCK' 
										END
	FROM GPR.PedidoRechazado PR
	INNER JOIN GPR.MotivoRechazo MR ON PR.MotivoRechazo = MR.Codigo
	WHERE PR.IdProcesoPedidoRechazado = @IdProcesoPedidoRechazado AND PR.CodigoConsultora= @CodigoConsultora
END

GO
-------------------------------------------------------------------------------------------------------

USE BelcorpBolivia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[UpdPedidoRechazado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[UpdPedidoRechazado]
GO

CREATE PROCEDURE GPR.UpdPedidoRechazado
	@IdProcesoPedidoRechazado BIGINT,
	@CodigoConsultora VARCHAR(15),
	@Rechazado BIT,
	@CodigoRechazoSomosBelcorp VARCHAR(8)
AS
BEGIN
	UPDATE PR
	SET 
		PR.Procesado = 1,
		PR.Rechazado = @Rechazado,
		PR.CodigoRechazoSomosBelcorp = CASE 
											WHEN MR.Codigo = 'OCC-16' THEN 'MONTO MÍNIMO' 
											WHEN MR.Codigo = 'OCC-17' THEN 'MONTO MAXIMO'
											WHEN MR.Codigo = 'OCC-19' THEN 'DEUDA'
											WHEN MR.Codigo = 'OCC-51' THEN 'MONTO MINIMO STOCK' 
										END
	FROM GPR.PedidoRechazado PR
	INNER JOIN GPR.MotivoRechazo MR ON PR.MotivoRechazo = MR.Codigo
	WHERE PR.IdProcesoPedidoRechazado = @IdProcesoPedidoRechazado AND PR.CodigoConsultora= @CodigoConsultora
END

GO
-------------------------------------------------------------------------------------------------------

