USE BelcorpBolivia
GO
IF OBJECT_ID('dbo.GetConfiguracionProgramaNuevas') IS NOT NULL
BEGIN
	drop procedure dbo.GetConfiguracionProgramaNuevas
END
GO
CREATE PROCEDURE dbo.GetConfiguracionProgramaNuevas
	@Campania char(6),
	@CodigoConsultora varchar(25)
AS
BEGIN
	select top 1
		CfPN.CodigoPrograma,
		CfPN.IndExigVent,
		CfPN.IndProgObli,
		CfPN.CUVKit,
		CoPN.MontoVentaExigido
	from ods.ConfiguracionProgramaNuevas CfPN
	inner join ods.ConsultorasProgramaNuevas CoPN on CoPN.Campania = CfPN.CampanaCarga and CoPN.CodigoPrograma = CfPN.CodigoPrograma
	where CoPN.Campania = @Campania and CoPN.CodigoConsultora = @CodigoConsultora and CoPN.Participa = 1;
END
GO

USE BelcorpChile
GO
IF OBJECT_ID('dbo.GetConfiguracionProgramaNuevas') IS NOT NULL
BEGIN
	drop procedure dbo.GetConfiguracionProgramaNuevas
END
GO
CREATE PROCEDURE dbo.GetConfiguracionProgramaNuevas
	@Campania char(6),
	@CodigoConsultora varchar(25)
AS
BEGIN
	select top 1
		CfPN.CodigoPrograma,
		CfPN.IndExigVent,
		CfPN.IndProgObli,
		CfPN.CUVKit,
		CoPN.MontoVentaExigido
	from ods.ConfiguracionProgramaNuevas CfPN
	inner join ods.ConsultorasProgramaNuevas CoPN on CoPN.Campania = CfPN.CampanaCarga and CoPN.CodigoPrograma = CfPN.CodigoPrograma
	where CoPN.Campania = @Campania and CoPN.CodigoConsultora = @CodigoConsultora and CoPN.Participa = 1;
END
GO

USE BelcorpColombia
GO
IF OBJECT_ID('dbo.GetConfiguracionProgramaNuevas') IS NOT NULL
BEGIN
	drop procedure dbo.GetConfiguracionProgramaNuevas
END
GO
CREATE PROCEDURE dbo.GetConfiguracionProgramaNuevas
	@Campania char(6),
	@CodigoConsultora varchar(25)
AS
BEGIN
	select top 1
		CfPN.CodigoPrograma,
		CfPN.IndExigVent,
		CfPN.IndProgObli,
		CfPN.CUVKit,
		CoPN.MontoVentaExigido
	from ods.ConfiguracionProgramaNuevas CfPN
	inner join ods.ConsultorasProgramaNuevas CoPN on CoPN.Campania = CfPN.CampanaCarga and CoPN.CodigoPrograma = CfPN.CodigoPrograma
	where CoPN.Campania = @Campania and CoPN.CodigoConsultora = @CodigoConsultora and CoPN.Participa = 1;
END
GO

USE BelcorpCostaRica
GO
IF OBJECT_ID('dbo.GetConfiguracionProgramaNuevas') IS NOT NULL
BEGIN
	drop procedure dbo.GetConfiguracionProgramaNuevas
END
GO
CREATE PROCEDURE dbo.GetConfiguracionProgramaNuevas
	@Campania char(6),
	@CodigoConsultora varchar(25)
AS
BEGIN
	select top 1
		CfPN.CodigoPrograma,
		CfPN.IndExigVent,
		CfPN.IndProgObli,
		CfPN.CUVKit,
		CoPN.MontoVentaExigido
	from ods.ConfiguracionProgramaNuevas CfPN
	inner join ods.ConsultorasProgramaNuevas CoPN on CoPN.Campania = CfPN.CampanaCarga and CoPN.CodigoPrograma = CfPN.CodigoPrograma
	where CoPN.Campania = @Campania and CoPN.CodigoConsultora = @CodigoConsultora and CoPN.Participa = 1;
END
GO

USE BelcorpDominicana
GO
IF OBJECT_ID('dbo.GetConfiguracionProgramaNuevas') IS NOT NULL
BEGIN
	drop procedure dbo.GetConfiguracionProgramaNuevas
END
GO
CREATE PROCEDURE dbo.GetConfiguracionProgramaNuevas
	@Campania char(6),
	@CodigoConsultora varchar(25)
AS
BEGIN
	select top 1
		CfPN.CodigoPrograma,
		CfPN.IndExigVent,
		CfPN.IndProgObli,
		CfPN.CUVKit,
		CoPN.MontoVentaExigido
	from ods.ConfiguracionProgramaNuevas CfPN
	inner join ods.ConsultorasProgramaNuevas CoPN on CoPN.Campania = CfPN.CampanaCarga and CoPN.CodigoPrograma = CfPN.CodigoPrograma
	where CoPN.Campania = @Campania and CoPN.CodigoConsultora = @CodigoConsultora and CoPN.Participa = 1;
END
GO

USE BelcorpEcuador
GO
IF OBJECT_ID('dbo.GetConfiguracionProgramaNuevas') IS NOT NULL
BEGIN
	drop procedure dbo.GetConfiguracionProgramaNuevas
END
GO
CREATE PROCEDURE dbo.GetConfiguracionProgramaNuevas
	@Campania char(6),
	@CodigoConsultora varchar(25)
AS
BEGIN
	select top 1
		CfPN.CodigoPrograma,
		CfPN.IndExigVent,
		CfPN.IndProgObli,
		CfPN.CUVKit,
		CoPN.MontoVentaExigido
	from ods.ConfiguracionProgramaNuevas CfPN
	inner join ods.ConsultorasProgramaNuevas CoPN on CoPN.Campania = CfPN.CampanaCarga and CoPN.CodigoPrograma = CfPN.CodigoPrograma
	where CoPN.Campania = @Campania and CoPN.CodigoConsultora = @CodigoConsultora and CoPN.Participa = 1;
END
GO

USE BelcorpGuatemala
GO
IF OBJECT_ID('dbo.GetConfiguracionProgramaNuevas') IS NOT NULL
BEGIN
	drop procedure dbo.GetConfiguracionProgramaNuevas
END
GO
CREATE PROCEDURE dbo.GetConfiguracionProgramaNuevas
	@Campania char(6),
	@CodigoConsultora varchar(25)
AS
BEGIN
	select top 1
		CfPN.CodigoPrograma,
		CfPN.IndExigVent,
		CfPN.IndProgObli,
		CfPN.CUVKit,
		CoPN.MontoVentaExigido
	from ods.ConfiguracionProgramaNuevas CfPN
	inner join ods.ConsultorasProgramaNuevas CoPN on CoPN.Campania = CfPN.CampanaCarga and CoPN.CodigoPrograma = CfPN.CodigoPrograma
	where CoPN.Campania = @Campania and CoPN.CodigoConsultora = @CodigoConsultora and CoPN.Participa = 1;
END
GO

USE BelcorpMexico
GO
IF OBJECT_ID('dbo.GetConfiguracionProgramaNuevas') IS NOT NULL
BEGIN
	drop procedure dbo.GetConfiguracionProgramaNuevas
END
GO
CREATE PROCEDURE dbo.GetConfiguracionProgramaNuevas
	@Campania char(6),
	@CodigoConsultora varchar(25)
AS
BEGIN
	select top 1
		CfPN.CodigoPrograma,
		CfPN.IndExigVent,
		CfPN.IndProgObli,
		CfPN.CUVKit,
		CoPN.MontoVentaExigido
	from ods.ConfiguracionProgramaNuevas CfPN
	inner join ods.ConsultorasProgramaNuevas CoPN on CoPN.Campania = CfPN.CampanaCarga and CoPN.CodigoPrograma = CfPN.CodigoPrograma
	where CoPN.Campania = @Campania and CoPN.CodigoConsultora = @CodigoConsultora and CoPN.Participa = 1;
END
GO

USE BelcorpPanama
GO
IF OBJECT_ID('dbo.GetConfiguracionProgramaNuevas') IS NOT NULL
BEGIN
	drop procedure dbo.GetConfiguracionProgramaNuevas
END
GO
CREATE PROCEDURE dbo.GetConfiguracionProgramaNuevas
	@Campania char(6),
	@CodigoConsultora varchar(25)
AS
BEGIN
	select top 1
		CfPN.CodigoPrograma,
		CfPN.IndExigVent,
		CfPN.IndProgObli,
		CfPN.CUVKit,
		CoPN.MontoVentaExigido
	from ods.ConfiguracionProgramaNuevas CfPN
	inner join ods.ConsultorasProgramaNuevas CoPN on CoPN.Campania = CfPN.CampanaCarga and CoPN.CodigoPrograma = CfPN.CodigoPrograma
	where CoPN.Campania = @Campania and CoPN.CodigoConsultora = @CodigoConsultora and CoPN.Participa = 1;
END
GO

USE BelcorpPeru
GO
IF OBJECT_ID('dbo.GetConfiguracionProgramaNuevas') IS NOT NULL
BEGIN
	drop procedure dbo.GetConfiguracionProgramaNuevas
END
GO
CREATE PROCEDURE dbo.GetConfiguracionProgramaNuevas
	@Campania char(6),
	@CodigoConsultora varchar(25)
AS
BEGIN
	select top 1
		CfPN.CodigoPrograma,
		CfPN.IndExigVent,
		CfPN.IndProgObli,
		CfPN.CUVKit,
		CoPN.MontoVentaExigido
	from ods.ConfiguracionProgramaNuevas CfPN
	inner join ods.ConsultorasProgramaNuevas CoPN on CoPN.Campania = CfPN.CampanaCarga and CoPN.CodigoPrograma = CfPN.CodigoPrograma
	where CoPN.Campania = @Campania and CoPN.CodigoConsultora = @CodigoConsultora and CoPN.Participa = 1;
END
GO

USE BelcorpPuertoRico
GO
IF OBJECT_ID('dbo.GetConfiguracionProgramaNuevas') IS NOT NULL
BEGIN
	drop procedure dbo.GetConfiguracionProgramaNuevas
END
GO
CREATE PROCEDURE dbo.GetConfiguracionProgramaNuevas
	@Campania char(6),
	@CodigoConsultora varchar(25)
AS
BEGIN
	select top 1
		CfPN.CodigoPrograma,
		CfPN.IndExigVent,
		CfPN.IndProgObli,
		CfPN.CUVKit,
		CoPN.MontoVentaExigido
	from ods.ConfiguracionProgramaNuevas CfPN
	inner join ods.ConsultorasProgramaNuevas CoPN on CoPN.Campania = CfPN.CampanaCarga and CoPN.CodigoPrograma = CfPN.CodigoPrograma
	where CoPN.Campania = @Campania and CoPN.CodigoConsultora = @CodigoConsultora and CoPN.Participa = 1;
END
GO

USE BelcorpSalvador
GO
IF OBJECT_ID('dbo.GetConfiguracionProgramaNuevas') IS NOT NULL
BEGIN
	drop procedure dbo.GetConfiguracionProgramaNuevas
END
GO
CREATE PROCEDURE dbo.GetConfiguracionProgramaNuevas
	@Campania char(6),
	@CodigoConsultora varchar(25)
AS
BEGIN
	select top 1
		CfPN.CodigoPrograma,
		CfPN.IndExigVent,
		CfPN.IndProgObli,
		CfPN.CUVKit,
		CoPN.MontoVentaExigido
	from ods.ConfiguracionProgramaNuevas CfPN
	inner join ods.ConsultorasProgramaNuevas CoPN on CoPN.Campania = CfPN.CampanaCarga and CoPN.CodigoPrograma = CfPN.CodigoPrograma
	where CoPN.Campania = @Campania and CoPN.CodigoConsultora = @CodigoConsultora and CoPN.Participa = 1;
END
GO