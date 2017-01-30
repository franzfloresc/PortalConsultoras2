
USE [BelcorpBolivia]
GO
/****** Object:  StoredProcedure [dbo].[DesmarcarUltimaDescargaPedido]    Script Date: 25/01/2017 03:20:12 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS(
SELECT 1
FROM INFORMATION_SCHEMA.ROUTINES 
WHERE SPECIFIC_NAME = 'DesmarcarUltimaDescargaPedido' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.DesmarcarUltimaDescargaPedido
END
GO

CREATE PROCEDURE [dbo].[DesmarcarUltimaDescargaPedido]	
AS

BEGIN
	
	DECLARE @NroLote AS INT
	SELECT TOP 1 @NroLote = NroLote FROM PedidoDescarga ORDER BY FechaInicio DESC

	UPDATE PW
	SET PW.GPRSB = 0, PW.IndicadorEnviado = 0 
	FROM PedidoWeb PW
	INNER JOIN LogCargaPedidoDetalle LPD ON PW.PedidoID = LPD.PedidoID
	WHERE NroLote = @NroLote

	UPDATE PDD
	SET PDD.IndicadorEnviado = 0
	FROM PedidoDD PDD
	INNER JOIN LogCargaPedidoDetalle LPD ON PDD.PedidoID = LPD.PedidoID
	WHERE NroLote = @NroLote

	UPDATE PedidoDescarga SET Desmarcado = 1 WHERE NroLote = @NroLote

END

GO

/*end*/

USE [BelcorpChile]
GO
/****** Object:  StoredProcedure [dbo].[DesmarcarUltimaDescargaPedido]    Script Date: 25/01/2017 03:21:37 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS(
SELECT 1
FROM INFORMATION_SCHEMA.ROUTINES 
WHERE SPECIFIC_NAME = 'DesmarcarUltimaDescargaPedido' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.DesmarcarUltimaDescargaPedido
END
GO

CREATE PROCEDURE [dbo].[DesmarcarUltimaDescargaPedido]	
AS

BEGIN

	DECLARE @NroLote AS INT
	SELECT TOP 1 @NroLote = NroLote FROM PedidoDescarga ORDER BY FechaInicio DESC

	UPDATE PW
	SET PW.IndicadorEnviado = 0 
	FROM PedidoWeb PW
	INNER JOIN LogCargaPedidoDetalle LPD ON PW.PedidoID = LPD.PedidoID
	WHERE NroLote = @NroLote

	UPDATE PDD
	SET PDD.IndicadorEnviado = 0
	FROM PedidoDD PDD
	INNER JOIN LogCargaPedidoDetalle LPD ON PDD.PedidoID = LPD.PedidoID
	WHERE NroLote = @NroLote


	UPDATE PedidoDescarga SET Desmarcado = 1 WHERE NroLote = @NroLote
END

GO

/*end*/


USE [BelcorpColombia]
GO
/****** Object:  StoredProcedure [dbo].[DesmarcarUltimaDescargaPedido]    Script Date: 25/01/2017 03:24:25 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS(
SELECT 1
FROM INFORMATION_SCHEMA.ROUTINES 
WHERE SPECIFIC_NAME = 'DesmarcarUltimaDescargaPedido' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.DesmarcarUltimaDescargaPedido
END
GO

CREATE PROCEDURE [dbo].[DesmarcarUltimaDescargaPedido]	
AS

BEGIN
	
	DECLARE @NroLote AS INT
	SELECT TOP 1 @NroLote = NroLote FROM PedidoDescarga ORDER BY FechaInicio DESC

	UPDATE PW
	SET PW.IndicadorEnviado = 0 
	FROM PedidoWeb PW
	INNER JOIN LogCargaPedidoDetalle LPD ON PW.PedidoID = LPD.PedidoID
	WHERE NroLote = @NroLote

	UPDATE PDD
	SET PDD.IndicadorEnviado = 0
	FROM PedidoDD PDD
	INNER JOIN LogCargaPedidoDetalle LPD ON PDD.PedidoID = LPD.PedidoID
	WHERE NroLote = @NroLote

	UPDATE PedidoDescarga SET Desmarcado = 1 WHERE NroLote = @NroLote
END

GO

/*end*/

USE [BelcorpCostaRica]
GO

IF EXISTS(
SELECT 1
FROM INFORMATION_SCHEMA.ROUTINES 
WHERE SPECIFIC_NAME = 'DesmarcarUltimaDescargaPedido' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.DesmarcarUltimaDescargaPedido
END
GO

CREATE PROCEDURE [dbo].[DesmarcarUltimaDescargaPedido]	
AS

BEGIN
	
	DECLARE @NroLote AS INT
	SELECT TOP 1 @NroLote = NroLote FROM PedidoDescarga ORDER BY FechaInicio DESC

	UPDATE PW
	SET PW.IndicadorEnviado = 0 
	FROM PedidoWeb PW
	INNER JOIN LogCargaPedidoDetalle LPD ON PW.PedidoID = LPD.PedidoID
	WHERE NroLote = @NroLote

	UPDATE PDD
	SET PDD.IndicadorEnviado = 0
	FROM PedidoDD PDD
	INNER JOIN LogCargaPedidoDetalle LPD ON PDD.PedidoID = LPD.PedidoID
	WHERE NroLote = @NroLote

	
	UPDATE PDDD
		SET PDDD.IndicadorEnviado = 0
		FROM PedidoDDDetalle PDDD
		INNER JOIN LogCargaPedidoDetalle LPD ON PDDD.PedidoID = LPD.PedidoID
		WHERE NroLote = @NroLote


	UPDATE PedidoDescarga SET Desmarcado = 1 WHERE NroLote = @NroLote

END
GO

/*end*/

USE [BelcorpDominicana]
GO
/****** Object:  StoredProcedure [dbo].[DesmarcarUltimaDescargaPedido]    Script Date: 25/01/2017 03:27:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS(
SELECT 1
FROM INFORMATION_SCHEMA.ROUTINES 
WHERE SPECIFIC_NAME = 'DesmarcarUltimaDescargaPedido' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.DesmarcarUltimaDescargaPedido
END
GO

CREATE PROCEDURE [dbo].[DesmarcarUltimaDescargaPedido]	
AS

BEGIN
	
	DECLARE @NroLote AS INT
	SELECT TOP 1 @NroLote = NroLote FROM PedidoDescarga ORDER BY FechaInicio DESC

	UPDATE PW
	SET PW.GPRSB = 0, PW.IndicadorEnviado = 0 
	FROM PedidoWeb PW
	INNER JOIN LogCargaPedidoDetalle LPD ON PW.PedidoID = LPD.PedidoID
	WHERE NroLote = @NroLote

	UPDATE PDD
	SET PDD.IndicadorEnviado = 0
	FROM PedidoDD PDD
	INNER JOIN LogCargaPedidoDetalle LPD ON PDD.PedidoID = LPD.PedidoID
	WHERE NroLote = @NroLote


	UPDATE PedidoDescarga SET Desmarcado = 1 WHERE NroLote = @NroLote

END
GO

/*end*/

USE [BelcorpEcuador]
GO
/****** Object:  StoredProcedure [dbo].[DesmarcarUltimaDescargaPedido]    Script Date: 25/01/2017 03:30:47 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS(
SELECT 1
FROM INFORMATION_SCHEMA.ROUTINES 
WHERE SPECIFIC_NAME = 'DesmarcarUltimaDescargaPedido' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.DesmarcarUltimaDescargaPedido
END
GO

CREATE PROCEDURE [dbo].[DesmarcarUltimaDescargaPedido]	
AS

BEGIN

	
	DECLARE @NroLote AS INT
	SELECT TOP 1 @NroLote = NroLote FROM PedidoDescarga ORDER BY FechaInicio DESC

	UPDATE PW
	SET PW.IndicadorEnviado = 0 
	FROM PedidoWeb PW
	INNER JOIN LogCargaPedidoDetalle LPD ON PW.PedidoID = LPD.PedidoID
	WHERE NroLote = @NroLote

	UPDATE PDD
	SET PDD.IndicadorEnviado = 0
	FROM PedidoDD PDD
	INNER JOIN LogCargaPedidoDetalle LPD ON PDD.PedidoID = LPD.PedidoID
	WHERE NroLote = @NroLote

	UPDATE PedidoDescarga SET Desmarcado = 1 WHERE NroLote = @NroLote

END
GO

/*end*/

USE [BelcorpGuatemala]
GO
/****** Object:  StoredProcedure [dbo].[DesmarcarUltimaDescargaPedido]    Script Date: 25/01/2017 03:41:32 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS(
SELECT 1
FROM INFORMATION_SCHEMA.ROUTINES 
WHERE SPECIFIC_NAME = 'DesmarcarUltimaDescargaPedido' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.DesmarcarUltimaDescargaPedido
END
GO

CREATE PROCEDURE [dbo].[DesmarcarUltimaDescargaPedido]	
AS

BEGIN

	
	DECLARE @NroLote AS INT
	SELECT TOP 1 @NroLote = NroLote FROM PedidoDescarga ORDER BY FechaInicio DESC

	UPDATE PW
	SET PW.IndicadorEnviado = 0 
	FROM PedidoWeb PW
	INNER JOIN LogCargaPedidoDetalle LPD ON PW.PedidoID = LPD.PedidoID
	WHERE NroLote = @NroLote

	UPDATE PDD
	SET PDD.IndicadorEnviado = 0
	FROM PedidoDD PDD
	INNER JOIN LogCargaPedidoDetalle LPD ON PDD.PedidoID = LPD.PedidoID
	WHERE NroLote = @NroLote

	UPDATE PDDD
		SET PDDD.IndicadorEnviado = 0
		FROM PedidoDDDetalle PDDD
		INNER JOIN LogCargaPedidoDetalle LPD ON PDDD.PedidoID = LPD.PedidoID
		WHERE NroLote = @NroLote


	UPDATE PedidoDescarga SET Desmarcado = 1 WHERE NroLote = @NroLote

END
GO

/*end*/

USE [BelcorpMexico]
GO
/****** Object:  StoredProcedure [dbo].[DesmarcarUltimaDescargaPedido]    Script Date: 25/01/2017 03:42:24 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS(
SELECT 1
FROM INFORMATION_SCHEMA.ROUTINES 
WHERE SPECIFIC_NAME = 'DesmarcarUltimaDescargaPedido' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.DesmarcarUltimaDescargaPedido
END
GO

CREATE PROCEDURE [dbo].[DesmarcarUltimaDescargaPedido]	
AS

BEGIN
	
	DECLARE @NroLote AS INT
	SELECT TOP 1 @NroLote = NroLote FROM PedidoDescarga ORDER BY FechaInicio DESC

	UPDATE PW
	SET PW.GPRSB = 0, PW.IndicadorEnviado = 0 
	FROM PedidoWeb PW
	INNER JOIN LogCargaPedidoDetalle LPD ON PW.PedidoID = LPD.PedidoID
	WHERE NroLote = @NroLote

	UPDATE PDD
	SET PDD.IndicadorEnviado = 0
	FROM PedidoDD PDD
	INNER JOIN LogCargaPedidoDetalle LPD ON PDD.PedidoID = LPD.PedidoID
	WHERE NroLote = @NroLote


	UPDATE PedidoDescarga SET Desmarcado = 1 WHERE NroLote = @NroLote

END

GO

/*end*/

USE [BelcorpPanama]
GO
/****** Object:  StoredProcedure [dbo].[DesmarcarUltimaDescargaPedido]    Script Date: 25/01/2017 03:45:49 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS(
SELECT 1
FROM INFORMATION_SCHEMA.ROUTINES 
WHERE SPECIFIC_NAME = 'DesmarcarUltimaDescargaPedido' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.DesmarcarUltimaDescargaPedido
END
GO

CREATE PROCEDURE [dbo].[DesmarcarUltimaDescargaPedido]	
AS

BEGIN
	DECLARE @NroLote AS INT
	SELECT TOP 1 @NroLote = NroLote FROM PedidoDescarga ORDER BY FechaInicio DESC

	UPDATE PW
	SET PW.IndicadorEnviado = 0 
	FROM PedidoWeb PW
	INNER JOIN LogCargaPedidoDetalle LPD ON PW.PedidoID = LPD.PedidoID
	WHERE NroLote = @NroLote

	UPDATE PDD
	SET PDD.IndicadorEnviado = 0
	FROM PedidoDD PDD
	INNER JOIN LogCargaPedidoDetalle LPD ON PDD.PedidoID = LPD.PedidoID
	WHERE NroLote = @NroLote

	UPDATE PDDD
		SET PDDD.IndicadorEnviado = 0
		FROM PedidoDDDetalle PDDD
		INNER JOIN LogCargaPedidoDetalle LPD ON PDDD.PedidoID = LPD.PedidoID
		WHERE NroLote = @NroLote


	UPDATE PedidoDescarga SET Desmarcado = 1 WHERE NroLote = @NroLote

END

GO

/*end*/

USE [BelcorpPeru]
GO
/****** Object:  StoredProcedure [dbo].[DesmarcarUltimaDescargaPedido]    Script Date: 25/01/2017 03:46:45 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS(
SELECT 1
FROM INFORMATION_SCHEMA.ROUTINES 
WHERE SPECIFIC_NAME = 'DesmarcarUltimaDescargaPedido' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.DesmarcarUltimaDescargaPedido
END
GO

CREATE PROCEDURE [dbo].[DesmarcarUltimaDescargaPedido]	
AS

BEGIN
	
	DECLARE @NroLote AS INT
	SELECT TOP 1 @NroLote = NroLote FROM PedidoDescarga ORDER BY FechaInicio DESC

	UPDATE PW
	SET PW.GPRSB = 0, PW.IndicadorEnviado = 0 
	FROM PedidoWeb PW
	INNER JOIN LogCargaPedidoDetalle LPD ON PW.PedidoID = LPD.PedidoID
	WHERE NroLote = @NroLote

	UPDATE PDD
	SET PDD.IndicadorEnviado = 0
	FROM PedidoDD PDD
	INNER JOIN LogCargaPedidoDetalle LPD ON PDD.PedidoID = LPD.PedidoID
	WHERE NroLote = @NroLote


	UPDATE PedidoDescarga SET Desmarcado = 1 WHERE NroLote = @NroLote

END
GO

/*end*/

USE [BelcorpPuertoRico]
GO
/****** Object:  StoredProcedure [dbo].[DesmarcarUltimaDescargaPedido]    Script Date: 25/01/2017 03:50:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS(
SELECT 1
FROM INFORMATION_SCHEMA.ROUTINES 
WHERE SPECIFIC_NAME = 'DesmarcarUltimaDescargaPedido' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.DesmarcarUltimaDescargaPedido
END
GO

CREATE PROCEDURE [dbo].[DesmarcarUltimaDescargaPedido]	
AS

BEGIN

	DECLARE @NroLote AS INT
	SELECT TOP 1 @NroLote = NroLote FROM PedidoDescarga ORDER BY FechaInicio DESC

	UPDATE PW
	SET PW.GPRSB = 0, PW.IndicadorEnviado = 0 
	FROM PedidoWeb PW
	INNER JOIN LogCargaPedidoDetalle LPD ON PW.PedidoID = LPD.PedidoID
	WHERE NroLote = @NroLote

	UPDATE PDD
	SET PDD.IndicadorEnviado = 0
	FROM PedidoDD PDD
	INNER JOIN LogCargaPedidoDetalle LPD ON PDD.PedidoID = LPD.PedidoID
	WHERE NroLote = @NroLote

	UPDATE PedidoDescarga SET Desmarcado = 1 WHERE NroLote = @NroLote

END

GO

/*end*/

USE [BelcorpSalvador]
GO
/****** Object:  StoredProcedure [dbo].[DesmarcarUltimaDescargaPedido]    Script Date: 25/01/2017 03:53:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS(
SELECT 1
FROM INFORMATION_SCHEMA.ROUTINES 
WHERE SPECIFIC_NAME = 'DesmarcarUltimaDescargaPedido' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.DesmarcarUltimaDescargaPedido
END
GO

CREATE PROCEDURE [dbo].[DesmarcarUltimaDescargaPedido]	
AS

BEGIN

	DECLARE @NroLote AS INT
	SELECT TOP 1 @NroLote = NroLote FROM PedidoDescarga ORDER BY FechaInicio DESC

	UPDATE PW
	SET PW.IndicadorEnviado = 0 
	FROM PedidoWeb PW
	INNER JOIN LogCargaPedidoDetalle LPD ON PW.PedidoID = LPD.PedidoID
	WHERE NroLote = @NroLote

	UPDATE PDD
	SET PDD.IndicadorEnviado = 0
	FROM PedidoDD PDD
	INNER JOIN LogCargaPedidoDetalle LPD ON PDD.PedidoID = LPD.PedidoID
	WHERE NroLote = @NroLote

	UPDATE PDDD
		SET PDDD.IndicadorEnviado = 0
		FROM PedidoDDDetalle PDDD
		INNER JOIN LogCargaPedidoDetalle LPD ON PDDD.PedidoID = LPD.PedidoID
		WHERE NroLote = @NroLote

	UPDATE PedidoDescarga SET Desmarcado = 1 WHERE NroLote = @NroLote

END

GO

/*end*/

USE [BelcorpVenezuela]
GO
/****** Object:  StoredProcedure [dbo].[DesmarcarUltimaDescargaPedido]    Script Date: 25/01/2017 03:57:25 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS(
SELECT 1
FROM INFORMATION_SCHEMA.ROUTINES 
WHERE SPECIFIC_NAME = 'DesmarcarUltimaDescargaPedido' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.DesmarcarUltimaDescargaPedido
END
GO

CREATE PROCEDURE [dbo].[DesmarcarUltimaDescargaPedido]	
AS

BEGIN
	
	DECLARE @NroLote AS INT
	SELECT TOP 1 @NroLote = NroLote FROM PedidoDescarga ORDER BY FechaInicio DESC

	UPDATE PW
	SET PW.GPRSB = 0, PW.IndicadorEnviado = 0 
	FROM PedidoWeb PW
	INNER JOIN LogCargaPedidoDetalle LPD ON PW.PedidoID = LPD.PedidoID
	WHERE NroLote = @NroLote

	UPDATE PDD
	SET PDD.IndicadorEnviado = 0
	FROM PedidoDD PDD
	INNER JOIN LogCargaPedidoDetalle LPD ON PDD.PedidoID = LPD.PedidoID
	WHERE NroLote = @NroLote

	UPDATE PedidoDescarga SET Desmarcado = 1 WHERE NroLote = @NroLote

END

GO