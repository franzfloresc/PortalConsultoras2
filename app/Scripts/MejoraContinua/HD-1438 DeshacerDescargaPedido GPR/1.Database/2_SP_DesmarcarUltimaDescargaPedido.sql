USE BelcorpBolivia
GO
ALTER PROCEDURE [dbo].[DesmarcarUltimaDescargaPedido]
AS
BEGIN	
	DECLARE @NroLote AS INT;
	SELECT TOP 1 @NroLote = NroLote FROM PedidoDescarga ORDER BY FechaInicio DESC;

	UPDATE PW
	SET PW.GPRSB = 0, PW.IndicadorEnviado = 0 
	FROM PedidoWeb PW
	INNER JOIN LogCargaPedidoDetalle LPD ON PW.PedidoID = LPD.PedidoID
	WHERE NroLote = @NroLote;

	UPDATE PDD
	SET PDD.IndicadorEnviado = 0
	FROM PedidoDD PDD
	INNER JOIN LogCargaPedidoDetalle LPD ON PDD.PedidoID = LPD.PedidoID
	WHERE NroLote = @NroLote;

	UPDATE PDDD
	SET PDDD.IndicadorEnviado = 0
	FROM PedidoDDDetalle PDDD
	INNER JOIN LogCargaPedidoDetalle LPD ON PDDD.PedidoID = LPD.PedidoID
	WHERE NroLote = @NroLote;

	Update CC
	Set CC.EstadoCupon = 2
	From CuponConsultora CC
	Inner Join ods.Consultora C On CC.CodigoConsultora = C.Codigo
	Inner Join PedidoWeb PW On CC.CampaniaID = PW.CampaniaID And C.ConsultoraID = PW.ConsultoraID
	Inner Join LogCargaPedidoDetalle LCPD On PW.PedidoID = LCPD.PedidoID
	Where LCPD.NroLote = @NroLote And CC.EstadoCupon = 3;

	UPDATE PedidoDescarga SET Desmarcado = 1 WHERE NroLote = @NroLote;
END
GO
/*end*/

USE BelcorpChile
GO
ALTER PROCEDURE [dbo].[DesmarcarUltimaDescargaPedido]
AS
BEGIN	
	DECLARE @NroLote AS INT;
	SELECT TOP 1 @NroLote = NroLote FROM PedidoDescarga ORDER BY FechaInicio DESC;

	UPDATE PW
	SET PW.GPRSB = 0, PW.IndicadorEnviado = 0 
	FROM PedidoWeb PW
	INNER JOIN LogCargaPedidoDetalle LPD ON PW.PedidoID = LPD.PedidoID
	WHERE NroLote = @NroLote;

	UPDATE PDD
	SET PDD.IndicadorEnviado = 0
	FROM PedidoDD PDD
	INNER JOIN LogCargaPedidoDetalle LPD ON PDD.PedidoID = LPD.PedidoID
	WHERE NroLote = @NroLote;

	UPDATE PDDD
	SET PDDD.IndicadorEnviado = 0
	FROM PedidoDDDetalle PDDD
	INNER JOIN LogCargaPedidoDetalle LPD ON PDDD.PedidoID = LPD.PedidoID
	WHERE NroLote = @NroLote;

	Update CC
	Set CC.EstadoCupon = 2
	From CuponConsultora CC
	Inner Join ods.Consultora C On CC.CodigoConsultora = C.Codigo
	Inner Join PedidoWeb PW On CC.CampaniaID = PW.CampaniaID And C.ConsultoraID = PW.ConsultoraID
	Inner Join LogCargaPedidoDetalle LCPD On PW.PedidoID = LCPD.PedidoID
	Where LCPD.NroLote = @NroLote And CC.EstadoCupon = 3;

	UPDATE PedidoDescarga SET Desmarcado = 1 WHERE NroLote = @NroLote;
END
GO
/*end*/

USE BelcorpColombia
GO
ALTER PROCEDURE [dbo].[DesmarcarUltimaDescargaPedido]
AS
BEGIN	
	DECLARE @NroLote AS INT;
	SELECT TOP 1 @NroLote = NroLote FROM PedidoDescarga ORDER BY FechaInicio DESC;

	UPDATE PW
	SET PW.GPRSB = 0, PW.IndicadorEnviado = 0 
	FROM PedidoWeb PW
	INNER JOIN LogCargaPedidoDetalle LPD ON PW.PedidoID = LPD.PedidoID
	WHERE NroLote = @NroLote;

	UPDATE PDD
	SET PDD.IndicadorEnviado = 0
	FROM PedidoDD PDD
	INNER JOIN LogCargaPedidoDetalle LPD ON PDD.PedidoID = LPD.PedidoID
	WHERE NroLote = @NroLote;

	UPDATE PDDD
	SET PDDD.IndicadorEnviado = 0
	FROM PedidoDDDetalle PDDD
	INNER JOIN LogCargaPedidoDetalle LPD ON PDDD.PedidoID = LPD.PedidoID
	WHERE NroLote = @NroLote;

	Update CC
	Set CC.EstadoCupon = 2
	From CuponConsultora CC
	Inner Join ods.Consultora C On CC.CodigoConsultora = C.Codigo
	Inner Join PedidoWeb PW On CC.CampaniaID = PW.CampaniaID And C.ConsultoraID = PW.ConsultoraID
	Inner Join LogCargaPedidoDetalle LCPD On PW.PedidoID = LCPD.PedidoID
	Where LCPD.NroLote = @NroLote And CC.EstadoCupon = 3;

	UPDATE PedidoDescarga SET Desmarcado = 1 WHERE NroLote = @NroLote;
END
GO
/*end*/

USE BelcorpCostaRica
GO
ALTER PROCEDURE [dbo].[DesmarcarUltimaDescargaPedido]
AS
BEGIN	
	DECLARE @NroLote AS INT;
	SELECT TOP 1 @NroLote = NroLote FROM PedidoDescarga ORDER BY FechaInicio DESC;

	UPDATE PW
	SET PW.GPRSB = 0, PW.IndicadorEnviado = 0 
	FROM PedidoWeb PW
	INNER JOIN LogCargaPedidoDetalle LPD ON PW.PedidoID = LPD.PedidoID
	WHERE NroLote = @NroLote;

	UPDATE PDD
	SET PDD.IndicadorEnviado = 0
	FROM PedidoDD PDD
	INNER JOIN LogCargaPedidoDetalle LPD ON PDD.PedidoID = LPD.PedidoID
	WHERE NroLote = @NroLote;

	UPDATE PDDD
	SET PDDD.IndicadorEnviado = 0
	FROM PedidoDDDetalle PDDD
	INNER JOIN LogCargaPedidoDetalle LPD ON PDDD.PedidoID = LPD.PedidoID
	WHERE NroLote = @NroLote;

	Update CC
	Set CC.EstadoCupon = 2
	From CuponConsultora CC
	Inner Join ods.Consultora C On CC.CodigoConsultora = C.Codigo
	Inner Join PedidoWeb PW On CC.CampaniaID = PW.CampaniaID And C.ConsultoraID = PW.ConsultoraID
	Inner Join LogCargaPedidoDetalle LCPD On PW.PedidoID = LCPD.PedidoID
	Where LCPD.NroLote = @NroLote And CC.EstadoCupon = 3;

	UPDATE PedidoDescarga SET Desmarcado = 1 WHERE NroLote = @NroLote;
END
GO
/*end*/

USE BelcorpDominicana
GO
ALTER PROCEDURE [dbo].[DesmarcarUltimaDescargaPedido]
AS
BEGIN	
	DECLARE @NroLote AS INT;
	SELECT TOP 1 @NroLote = NroLote FROM PedidoDescarga ORDER BY FechaInicio DESC;

	UPDATE PW
	SET PW.GPRSB = 0, PW.IndicadorEnviado = 0 
	FROM PedidoWeb PW
	INNER JOIN LogCargaPedidoDetalle LPD ON PW.PedidoID = LPD.PedidoID
	WHERE NroLote = @NroLote;

	UPDATE PDD
	SET PDD.IndicadorEnviado = 0
	FROM PedidoDD PDD
	INNER JOIN LogCargaPedidoDetalle LPD ON PDD.PedidoID = LPD.PedidoID
	WHERE NroLote = @NroLote;

	UPDATE PDDD
	SET PDDD.IndicadorEnviado = 0
	FROM PedidoDDDetalle PDDD
	INNER JOIN LogCargaPedidoDetalle LPD ON PDDD.PedidoID = LPD.PedidoID
	WHERE NroLote = @NroLote;

	Update CC
	Set CC.EstadoCupon = 2
	From CuponConsultora CC
	Inner Join ods.Consultora C On CC.CodigoConsultora = C.Codigo
	Inner Join PedidoWeb PW On CC.CampaniaID = PW.CampaniaID And C.ConsultoraID = PW.ConsultoraID
	Inner Join LogCargaPedidoDetalle LCPD On PW.PedidoID = LCPD.PedidoID
	Where LCPD.NroLote = @NroLote And CC.EstadoCupon = 3;

	UPDATE PedidoDescarga SET Desmarcado = 1 WHERE NroLote = @NroLote;
END
GO
/*end*/

USE BelcorpEcuador
GO
ALTER PROCEDURE [dbo].[DesmarcarUltimaDescargaPedido]
AS
BEGIN	
	DECLARE @NroLote AS INT;
	SELECT TOP 1 @NroLote = NroLote FROM PedidoDescarga ORDER BY FechaInicio DESC;

	UPDATE PW
	SET PW.GPRSB = 0, PW.IndicadorEnviado = 0 
	FROM PedidoWeb PW
	INNER JOIN LogCargaPedidoDetalle LPD ON PW.PedidoID = LPD.PedidoID
	WHERE NroLote = @NroLote;

	UPDATE PDD
	SET PDD.IndicadorEnviado = 0
	FROM PedidoDD PDD
	INNER JOIN LogCargaPedidoDetalle LPD ON PDD.PedidoID = LPD.PedidoID
	WHERE NroLote = @NroLote;

	UPDATE PDDD
	SET PDDD.IndicadorEnviado = 0
	FROM PedidoDDDetalle PDDD
	INNER JOIN LogCargaPedidoDetalle LPD ON PDDD.PedidoID = LPD.PedidoID
	WHERE NroLote = @NroLote;

	Update CC
	Set CC.EstadoCupon = 2
	From CuponConsultora CC
	Inner Join ods.Consultora C On CC.CodigoConsultora = C.Codigo
	Inner Join PedidoWeb PW On CC.CampaniaID = PW.CampaniaID And C.ConsultoraID = PW.ConsultoraID
	Inner Join LogCargaPedidoDetalle LCPD On PW.PedidoID = LCPD.PedidoID
	Where LCPD.NroLote = @NroLote And CC.EstadoCupon = 3;

	UPDATE PedidoDescarga SET Desmarcado = 1 WHERE NroLote = @NroLote;
END
GO
/*end*/

USE BelcorpGuatemala
GO
ALTER PROCEDURE [dbo].[DesmarcarUltimaDescargaPedido]
AS
BEGIN	
	DECLARE @NroLote AS INT;
	SELECT TOP 1 @NroLote = NroLote FROM PedidoDescarga ORDER BY FechaInicio DESC;

	UPDATE PW
	SET PW.GPRSB = 0, PW.IndicadorEnviado = 0 
	FROM PedidoWeb PW
	INNER JOIN LogCargaPedidoDetalle LPD ON PW.PedidoID = LPD.PedidoID
	WHERE NroLote = @NroLote;

	UPDATE PDD
	SET PDD.IndicadorEnviado = 0
	FROM PedidoDD PDD
	INNER JOIN LogCargaPedidoDetalle LPD ON PDD.PedidoID = LPD.PedidoID
	WHERE NroLote = @NroLote;

	UPDATE PDDD
	SET PDDD.IndicadorEnviado = 0
	FROM PedidoDDDetalle PDDD
	INNER JOIN LogCargaPedidoDetalle LPD ON PDDD.PedidoID = LPD.PedidoID
	WHERE NroLote = @NroLote;

	Update CC
	Set CC.EstadoCupon = 2
	From CuponConsultora CC
	Inner Join ods.Consultora C On CC.CodigoConsultora = C.Codigo
	Inner Join PedidoWeb PW On CC.CampaniaID = PW.CampaniaID And C.ConsultoraID = PW.ConsultoraID
	Inner Join LogCargaPedidoDetalle LCPD On PW.PedidoID = LCPD.PedidoID
	Where LCPD.NroLote = @NroLote And CC.EstadoCupon = 3;

	UPDATE PedidoDescarga SET Desmarcado = 1 WHERE NroLote = @NroLote;
END
GO
/*end*/

USE BelcorpMexico
GO
ALTER PROCEDURE [dbo].[DesmarcarUltimaDescargaPedido]
AS
BEGIN	
	DECLARE @NroLote AS INT;
	SELECT TOP 1 @NroLote = NroLote FROM PedidoDescarga ORDER BY FechaInicio DESC;

	UPDATE PW
	SET PW.GPRSB = 0, PW.IndicadorEnviado = 0 
	FROM PedidoWeb PW
	INNER JOIN LogCargaPedidoDetalle LPD ON PW.PedidoID = LPD.PedidoID
	WHERE NroLote = @NroLote;

	UPDATE PDD
	SET PDD.IndicadorEnviado = 0
	FROM PedidoDD PDD
	INNER JOIN LogCargaPedidoDetalle LPD ON PDD.PedidoID = LPD.PedidoID
	WHERE NroLote = @NroLote;

	UPDATE PDDD
	SET PDDD.IndicadorEnviado = 0
	FROM PedidoDDDetalle PDDD
	INNER JOIN LogCargaPedidoDetalle LPD ON PDDD.PedidoID = LPD.PedidoID
	WHERE NroLote = @NroLote;

	Update CC
	Set CC.EstadoCupon = 2
	From CuponConsultora CC
	Inner Join ods.Consultora C On CC.CodigoConsultora = C.Codigo
	Inner Join PedidoWeb PW On CC.CampaniaID = PW.CampaniaID And C.ConsultoraID = PW.ConsultoraID
	Inner Join LogCargaPedidoDetalle LCPD On PW.PedidoID = LCPD.PedidoID
	Where LCPD.NroLote = @NroLote And CC.EstadoCupon = 3;

	UPDATE PedidoDescarga SET Desmarcado = 1 WHERE NroLote = @NroLote;
END
GO
/*end*/

USE BelcorpPanama
GO
ALTER PROCEDURE [dbo].[DesmarcarUltimaDescargaPedido]
AS
BEGIN	
	DECLARE @NroLote AS INT;
	SELECT TOP 1 @NroLote = NroLote FROM PedidoDescarga ORDER BY FechaInicio DESC;

	UPDATE PW
	SET PW.GPRSB = 0, PW.IndicadorEnviado = 0 
	FROM PedidoWeb PW
	INNER JOIN LogCargaPedidoDetalle LPD ON PW.PedidoID = LPD.PedidoID
	WHERE NroLote = @NroLote;

	UPDATE PDD
	SET PDD.IndicadorEnviado = 0
	FROM PedidoDD PDD
	INNER JOIN LogCargaPedidoDetalle LPD ON PDD.PedidoID = LPD.PedidoID
	WHERE NroLote = @NroLote;

	UPDATE PDDD
	SET PDDD.IndicadorEnviado = 0
	FROM PedidoDDDetalle PDDD
	INNER JOIN LogCargaPedidoDetalle LPD ON PDDD.PedidoID = LPD.PedidoID
	WHERE NroLote = @NroLote;

	Update CC
	Set CC.EstadoCupon = 2
	From CuponConsultora CC
	Inner Join ods.Consultora C On CC.CodigoConsultora = C.Codigo
	Inner Join PedidoWeb PW On CC.CampaniaID = PW.CampaniaID And C.ConsultoraID = PW.ConsultoraID
	Inner Join LogCargaPedidoDetalle LCPD On PW.PedidoID = LCPD.PedidoID
	Where LCPD.NroLote = @NroLote And CC.EstadoCupon = 3;

	UPDATE PedidoDescarga SET Desmarcado = 1 WHERE NroLote = @NroLote;
END
GO
/*end*/

USE BelcorpPeru
GO
ALTER PROCEDURE [dbo].[DesmarcarUltimaDescargaPedido]
AS
BEGIN	
	DECLARE @NroLote AS INT;
	SELECT TOP 1 @NroLote = NroLote FROM PedidoDescarga ORDER BY FechaInicio DESC;

	UPDATE PW
	SET PW.GPRSB = 0, PW.IndicadorEnviado = 0 
	FROM PedidoWeb PW
	INNER JOIN LogCargaPedidoDetalle LPD ON PW.PedidoID = LPD.PedidoID
	WHERE NroLote = @NroLote;

	UPDATE PDD
	SET PDD.IndicadorEnviado = 0
	FROM PedidoDD PDD
	INNER JOIN LogCargaPedidoDetalle LPD ON PDD.PedidoID = LPD.PedidoID
	WHERE NroLote = @NroLote;

	UPDATE PDDD
	SET PDDD.IndicadorEnviado = 0
	FROM PedidoDDDetalle PDDD
	INNER JOIN LogCargaPedidoDetalle LPD ON PDDD.PedidoID = LPD.PedidoID
	WHERE NroLote = @NroLote;

	Update CC
	Set CC.EstadoCupon = 2
	From CuponConsultora CC
	Inner Join ods.Consultora C On CC.CodigoConsultora = C.Codigo
	Inner Join PedidoWeb PW On CC.CampaniaID = PW.CampaniaID And C.ConsultoraID = PW.ConsultoraID
	Inner Join LogCargaPedidoDetalle LCPD On PW.PedidoID = LCPD.PedidoID
	Where LCPD.NroLote = @NroLote And CC.EstadoCupon = 3;

	UPDATE PedidoDescarga SET Desmarcado = 1 WHERE NroLote = @NroLote;
END
GO
/*end*/

USE BelcorpPuertoRico
GO
ALTER PROCEDURE [dbo].[DesmarcarUltimaDescargaPedido]
AS
BEGIN	
	DECLARE @NroLote AS INT;
	SELECT TOP 1 @NroLote = NroLote FROM PedidoDescarga ORDER BY FechaInicio DESC;

	UPDATE PW
	SET PW.GPRSB = 0, PW.IndicadorEnviado = 0 
	FROM PedidoWeb PW
	INNER JOIN LogCargaPedidoDetalle LPD ON PW.PedidoID = LPD.PedidoID
	WHERE NroLote = @NroLote;

	UPDATE PDD
	SET PDD.IndicadorEnviado = 0
	FROM PedidoDD PDD
	INNER JOIN LogCargaPedidoDetalle LPD ON PDD.PedidoID = LPD.PedidoID
	WHERE NroLote = @NroLote;

	UPDATE PDDD
	SET PDDD.IndicadorEnviado = 0
	FROM PedidoDDDetalle PDDD
	INNER JOIN LogCargaPedidoDetalle LPD ON PDDD.PedidoID = LPD.PedidoID
	WHERE NroLote = @NroLote;

	Update CC
	Set CC.EstadoCupon = 2
	From CuponConsultora CC
	Inner Join ods.Consultora C On CC.CodigoConsultora = C.Codigo
	Inner Join PedidoWeb PW On CC.CampaniaID = PW.CampaniaID And C.ConsultoraID = PW.ConsultoraID
	Inner Join LogCargaPedidoDetalle LCPD On PW.PedidoID = LCPD.PedidoID
	Where LCPD.NroLote = @NroLote And CC.EstadoCupon = 3;

	UPDATE PedidoDescarga SET Desmarcado = 1 WHERE NroLote = @NroLote;
END
GO
/*end*/

USE BelcorpSalvador
GO
ALTER PROCEDURE [dbo].[DesmarcarUltimaDescargaPedido]
AS
BEGIN	
	DECLARE @NroLote AS INT;
	SELECT TOP 1 @NroLote = NroLote FROM PedidoDescarga ORDER BY FechaInicio DESC;

	UPDATE PW
	SET PW.GPRSB = 0, PW.IndicadorEnviado = 0 
	FROM PedidoWeb PW
	INNER JOIN LogCargaPedidoDetalle LPD ON PW.PedidoID = LPD.PedidoID
	WHERE NroLote = @NroLote;

	UPDATE PDD
	SET PDD.IndicadorEnviado = 0
	FROM PedidoDD PDD
	INNER JOIN LogCargaPedidoDetalle LPD ON PDD.PedidoID = LPD.PedidoID
	WHERE NroLote = @NroLote;

	UPDATE PDDD
	SET PDDD.IndicadorEnviado = 0
	FROM PedidoDDDetalle PDDD
	INNER JOIN LogCargaPedidoDetalle LPD ON PDDD.PedidoID = LPD.PedidoID
	WHERE NroLote = @NroLote;

	Update CC
	Set CC.EstadoCupon = 2
	From CuponConsultora CC
	Inner Join ods.Consultora C On CC.CodigoConsultora = C.Codigo
	Inner Join PedidoWeb PW On CC.CampaniaID = PW.CampaniaID And C.ConsultoraID = PW.ConsultoraID
	Inner Join LogCargaPedidoDetalle LCPD On PW.PedidoID = LCPD.PedidoID
	Where LCPD.NroLote = @NroLote And CC.EstadoCupon = 3;

	UPDATE PedidoDescarga SET Desmarcado = 1 WHERE NroLote = @NroLote;
END
GO
/*end*/

USE BelcorpVenezuela
GO
ALTER PROCEDURE [dbo].[DesmarcarUltimaDescargaPedido]
AS
BEGIN	
	DECLARE @NroLote AS INT;
	SELECT TOP 1 @NroLote = NroLote FROM PedidoDescarga ORDER BY FechaInicio DESC;

	UPDATE PW
	SET PW.GPRSB = 0, PW.IndicadorEnviado = 0 
	FROM PedidoWeb PW
	INNER JOIN LogCargaPedidoDetalle LPD ON PW.PedidoID = LPD.PedidoID
	WHERE NroLote = @NroLote;

	UPDATE PDD
	SET PDD.IndicadorEnviado = 0
	FROM PedidoDD PDD
	INNER JOIN LogCargaPedidoDetalle LPD ON PDD.PedidoID = LPD.PedidoID
	WHERE NroLote = @NroLote;

	UPDATE PDDD
	SET PDDD.IndicadorEnviado = 0
	FROM PedidoDDDetalle PDDD
	INNER JOIN LogCargaPedidoDetalle LPD ON PDDD.PedidoID = LPD.PedidoID
	WHERE NroLote = @NroLote;

	Update CC
	Set CC.EstadoCupon = 2
	From CuponConsultora CC
	Inner Join ods.Consultora C On CC.CodigoConsultora = C.Codigo
	Inner Join PedidoWeb PW On CC.CampaniaID = PW.CampaniaID And C.ConsultoraID = PW.ConsultoraID
	Inner Join LogCargaPedidoDetalle LCPD On PW.PedidoID = LCPD.PedidoID
	Where LCPD.NroLote = @NroLote And CC.EstadoCupon = 3;

	UPDATE PedidoDescarga SET Desmarcado = 1 WHERE NroLote = @NroLote;
END
GO