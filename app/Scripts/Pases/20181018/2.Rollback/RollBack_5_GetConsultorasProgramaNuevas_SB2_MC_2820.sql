USE BelcorpBolivia
GO
IF OBJECT_ID('dbo.GetConsultorasProgramaNuevas_SB2') IS NOT NULL
BEGIN
	drop procedure dbo.GetConsultorasProgramaNuevas_SB2
END
GO
CREATE PROCEDURE dbo.GetConsultorasProgramaNuevas_SB2
	@CodigoConsultora varchar(50),
	@Campania varchar(10),
	@CodigoPrograma varchar(5)
AS
BEGIN
	SELECT 
		Campania
		,CodigoConsultora
		,CodigoPrograma
		,Participa
		,Motivo
		,MontoVentaExigido
	FROM ods.ConsultorasProgramaNuevas
	WHERE CodigoConsultora = @CodigoConsultora
		AND Campania = @Campania
		AND CodigoPrograma = @CodigoPrograma;
END
GO
/*end*/

USE BelcorpChile
GO
IF OBJECT_ID('dbo.GetConsultorasProgramaNuevas_SB2') IS NOT NULL
BEGIN
	drop procedure dbo.GetConsultorasProgramaNuevas_SB2
END
GO
CREATE PROCEDURE dbo.GetConsultorasProgramaNuevas_SB2
	@CodigoConsultora varchar(50),
	@Campania varchar(10),
	@CodigoPrograma varchar(5)
AS
BEGIN
	SELECT 
		Campania
		,CodigoConsultora
		,CodigoPrograma
		,Participa
		,Motivo
		,MontoVentaExigido
	FROM ods.ConsultorasProgramaNuevas
	WHERE CodigoConsultora = @CodigoConsultora
		AND Campania = @Campania
		AND CodigoPrograma = @CodigoPrograma;
END
GO
/*end*/

USE BelcorpColombia
GO
IF OBJECT_ID('dbo.GetConsultorasProgramaNuevas_SB2') IS NOT NULL
BEGIN
	drop procedure dbo.GetConsultorasProgramaNuevas_SB2
END
GO
CREATE PROCEDURE dbo.GetConsultorasProgramaNuevas_SB2
	@CodigoConsultora varchar(50),
	@Campania varchar(10),
	@CodigoPrograma varchar(5)
AS
BEGIN
	SELECT 
		Campania
		,CodigoConsultora
		,CodigoPrograma
		,Participa
		,Motivo
		,MontoVentaExigido
	FROM ods.ConsultorasProgramaNuevas
	WHERE CodigoConsultora = @CodigoConsultora
		AND Campania = @Campania
		AND CodigoPrograma = @CodigoPrograma;
END
GO
/*end*/

USE BelcorpCostaRica
GO
IF OBJECT_ID('dbo.GetConsultorasProgramaNuevas_SB2') IS NOT NULL
BEGIN
	drop procedure dbo.GetConsultorasProgramaNuevas_SB2
END
GO
CREATE PROCEDURE dbo.GetConsultorasProgramaNuevas_SB2
	@CodigoConsultora varchar(50),
	@Campania varchar(10),
	@CodigoPrograma varchar(5)
AS
BEGIN
	SELECT 
		Campania
		,CodigoConsultora
		,CodigoPrograma
		,Participa
		,Motivo
		,MontoVentaExigido
	FROM ods.ConsultorasProgramaNuevas
	WHERE CodigoConsultora = @CodigoConsultora
		AND Campania = @Campania
		AND CodigoPrograma = @CodigoPrograma;
END
GO
/*end*/

USE BelcorpDominicana
GO
IF OBJECT_ID('dbo.GetConsultorasProgramaNuevas_SB2') IS NOT NULL
BEGIN
	drop procedure dbo.GetConsultorasProgramaNuevas_SB2
END
GO
CREATE PROCEDURE dbo.GetConsultorasProgramaNuevas_SB2
	@CodigoConsultora varchar(50),
	@Campania varchar(10),
	@CodigoPrograma varchar(5)
AS
BEGIN
	SELECT 
		Campania
		,CodigoConsultora
		,CodigoPrograma
		,Participa
		,Motivo
		,MontoVentaExigido
	FROM ods.ConsultorasProgramaNuevas
	WHERE CodigoConsultora = @CodigoConsultora
		AND Campania = @Campania
		AND CodigoPrograma = @CodigoPrograma;
END
GO
/*end*/

USE BelcorpEcuador
GO
IF OBJECT_ID('dbo.GetConsultorasProgramaNuevas_SB2') IS NOT NULL
BEGIN
	drop procedure dbo.GetConsultorasProgramaNuevas_SB2
END
GO
CREATE PROCEDURE dbo.GetConsultorasProgramaNuevas_SB2
	@CodigoConsultora varchar(50),
	@Campania varchar(10),
	@CodigoPrograma varchar(5)
AS
BEGIN
	SELECT 
		Campania
		,CodigoConsultora
		,CodigoPrograma
		,Participa
		,Motivo
		,MontoVentaExigido
	FROM ods.ConsultorasProgramaNuevas
	WHERE CodigoConsultora = @CodigoConsultora
		AND Campania = @Campania
		AND CodigoPrograma = @CodigoPrograma;
END
GO
/*end*/

USE BelcorpGuatemala
GO
IF OBJECT_ID('dbo.GetConsultorasProgramaNuevas_SB2') IS NOT NULL
BEGIN
	drop procedure dbo.GetConsultorasProgramaNuevas_SB2
END
GO
CREATE PROCEDURE dbo.GetConsultorasProgramaNuevas_SB2
	@CodigoConsultora varchar(50),
	@Campania varchar(10),
	@CodigoPrograma varchar(5)
AS
BEGIN
	SELECT 
		Campania
		,CodigoConsultora
		,CodigoPrograma
		,Participa
		,Motivo
		,MontoVentaExigido
	FROM ods.ConsultorasProgramaNuevas
	WHERE CodigoConsultora = @CodigoConsultora
		AND Campania = @Campania
		AND CodigoPrograma = @CodigoPrograma;
END
GO
/*end*/

USE BelcorpMexico
GO
IF OBJECT_ID('dbo.GetConsultorasProgramaNuevas_SB2') IS NOT NULL
BEGIN
	drop procedure dbo.GetConsultorasProgramaNuevas_SB2
END
GO
CREATE PROCEDURE dbo.GetConsultorasProgramaNuevas_SB2
	@CodigoConsultora varchar(50),
	@Campania varchar(10),
	@CodigoPrograma varchar(5)
AS
BEGIN
	SELECT 
		Campania
		,CodigoConsultora
		,CodigoPrograma
		,Participa
		,Motivo
		,MontoVentaExigido
	FROM ods.ConsultorasProgramaNuevas
	WHERE CodigoConsultora = @CodigoConsultora
		AND Campania = @Campania
		AND CodigoPrograma = @CodigoPrograma;
END
GO
/*end*/

USE BelcorpPanama
GO
IF OBJECT_ID('dbo.GetConsultorasProgramaNuevas_SB2') IS NOT NULL
BEGIN
	drop procedure dbo.GetConsultorasProgramaNuevas_SB2
END
GO
CREATE PROCEDURE dbo.GetConsultorasProgramaNuevas_SB2
	@CodigoConsultora varchar(50),
	@Campania varchar(10),
	@CodigoPrograma varchar(5)
AS
BEGIN
	SELECT 
		Campania
		,CodigoConsultora
		,CodigoPrograma
		,Participa
		,Motivo
		,MontoVentaExigido
	FROM ods.ConsultorasProgramaNuevas
	WHERE CodigoConsultora = @CodigoConsultora
		AND Campania = @Campania
		AND CodigoPrograma = @CodigoPrograma;
END
GO
/*end*/

USE BelcorpPeru
GO
IF OBJECT_ID('dbo.GetConsultorasProgramaNuevas_SB2') IS NOT NULL
BEGIN
	drop procedure dbo.GetConsultorasProgramaNuevas_SB2
END
GO
CREATE PROCEDURE dbo.GetConsultorasProgramaNuevas_SB2
	@CodigoConsultora varchar(50),
	@Campania varchar(10),
	@CodigoPrograma varchar(5)
AS
BEGIN
	SELECT 
		Campania
		,CodigoConsultora
		,CodigoPrograma
		,Participa
		,Motivo
		,MontoVentaExigido
	FROM ods.ConsultorasProgramaNuevas
	WHERE CodigoConsultora = @CodigoConsultora
		AND Campania = @Campania
		AND CodigoPrograma = @CodigoPrograma;
END
GO
/*end*/

USE BelcorpPuertoRico
GO
IF OBJECT_ID('dbo.GetConsultorasProgramaNuevas_SB2') IS NOT NULL
BEGIN
	drop procedure dbo.GetConsultorasProgramaNuevas_SB2
END
GO
CREATE PROCEDURE dbo.GetConsultorasProgramaNuevas_SB2
	@CodigoConsultora varchar(50),
	@Campania varchar(10),
	@CodigoPrograma varchar(5)
AS
BEGIN
	SELECT 
		Campania
		,CodigoConsultora
		,CodigoPrograma
		,Participa
		,Motivo
		,MontoVentaExigido
	FROM ods.ConsultorasProgramaNuevas
	WHERE CodigoConsultora = @CodigoConsultora
		AND Campania = @Campania
		AND CodigoPrograma = @CodigoPrograma;
END
GO
/*end*/

USE BelcorpSalvador
GO
IF OBJECT_ID('dbo.GetConsultorasProgramaNuevas_SB2') IS NOT NULL
BEGIN
	drop procedure dbo.GetConsultorasProgramaNuevas_SB2
END
GO
CREATE PROCEDURE dbo.GetConsultorasProgramaNuevas_SB2
	@CodigoConsultora varchar(50),
	@Campania varchar(10),
	@CodigoPrograma varchar(5)
AS
BEGIN
	SELECT 
		Campania
		,CodigoConsultora
		,CodigoPrograma
		,Participa
		,Motivo
		,MontoVentaExigido
	FROM ods.ConsultorasProgramaNuevas
	WHERE CodigoConsultora = @CodigoConsultora
		AND Campania = @Campania
		AND CodigoPrograma = @CodigoPrograma;
END
GO