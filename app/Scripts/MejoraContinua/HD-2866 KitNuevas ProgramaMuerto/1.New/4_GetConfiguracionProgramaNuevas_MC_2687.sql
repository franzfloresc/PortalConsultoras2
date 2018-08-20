USE BelcorpBolivia
GO
ALTER PROCEDURE dbo.GetConfiguracionProgramaNuevas
	@CodigoConsultora varchar(25),
	@Campania char(6),
	@CampaniaIngreso char(6) = ''
AS
BEGIN
	select top 1
		CfPN.CodigoPrograma,
		CfPN.IndExigVent,
		CfPN.IndProgObli,
		CfPN.CUVKit,
		CoPN.MontoVentaExigido
	from ods.ConfiguracionProgramaNuevas CfPN
	inner join ods.ConsultorasProgramaNuevas CoPN on CoPN.CodigoPrograma = CfPN.CodigoPrograma
	where
		CfPN.CampanaCarga = @CampaniaIngreso and CoPN.Campania = @Campania and
		CoPN.CodigoConsultora = @CodigoConsultora and CoPN.Participa = 1;
END
GO
/*end*/

USE BelcorpChile
GO
ALTER PROCEDURE dbo.GetConfiguracionProgramaNuevas
	@CodigoConsultora varchar(25),
	@Campania char(6),
	@CampaniaIngreso char(6) = ''
AS
BEGIN
	select top 1
		CfPN.CodigoPrograma,
		CfPN.IndExigVent,
		CfPN.IndProgObli,
		CfPN.CUVKit,
		CoPN.MontoVentaExigido
	from ods.ConfiguracionProgramaNuevas CfPN
	inner join ods.ConsultorasProgramaNuevas CoPN on CoPN.CodigoPrograma = CfPN.CodigoPrograma
	where
		CfPN.CampanaCarga = @CampaniaIngreso and CoPN.Campania = @Campania and
		CoPN.CodigoConsultora = @CodigoConsultora and CoPN.Participa = 1;
END
GO
/*end*/

USE BelcorpColombia
GO
ALTER PROCEDURE dbo.GetConfiguracionProgramaNuevas
	@CodigoConsultora varchar(25),
	@Campania char(6),
	@CampaniaIngreso char(6) = ''
AS
BEGIN
	select top 1
		CfPN.CodigoPrograma,
		CfPN.IndExigVent,
		CfPN.IndProgObli,
		CfPN.CUVKit,
		CoPN.MontoVentaExigido
	from ods.ConfiguracionProgramaNuevas CfPN
	inner join ods.ConsultorasProgramaNuevas CoPN on CoPN.CodigoPrograma = CfPN.CodigoPrograma
	where
		CfPN.CampanaCarga = @CampaniaIngreso and CoPN.Campania = @Campania and
		CoPN.CodigoConsultora = @CodigoConsultora and CoPN.Participa = 1;
END
GO
/*end*/

USE BelcorpCostaRica
GO
ALTER PROCEDURE dbo.GetConfiguracionProgramaNuevas
	@CodigoConsultora varchar(25),
	@Campania char(6),
	@CampaniaIngreso char(6) = ''
AS
BEGIN
	select top 1
		CfPN.CodigoPrograma,
		CfPN.IndExigVent,
		CfPN.IndProgObli,
		CfPN.CUVKit,
		CoPN.MontoVentaExigido
	from ods.ConfiguracionProgramaNuevas CfPN
	inner join ods.ConsultorasProgramaNuevas CoPN on CoPN.CodigoPrograma = CfPN.CodigoPrograma
	where
		CfPN.CampanaCarga = @CampaniaIngreso and CoPN.Campania = @Campania and
		CoPN.CodigoConsultora = @CodigoConsultora and CoPN.Participa = 1;
END
GO
/*end*/

USE BelcorpDominicana
GO
ALTER PROCEDURE dbo.GetConfiguracionProgramaNuevas
	@CodigoConsultora varchar(25),
	@Campania char(6),
	@CampaniaIngreso char(6) = ''
AS
BEGIN
	select top 1
		CfPN.CodigoPrograma,
		CfPN.IndExigVent,
		CfPN.IndProgObli,
		CfPN.CUVKit,
		CoPN.MontoVentaExigido
	from ods.ConfiguracionProgramaNuevas CfPN
	inner join ods.ConsultorasProgramaNuevas CoPN on CoPN.CodigoPrograma = CfPN.CodigoPrograma
	where
		CfPN.CampanaCarga = @CampaniaIngreso and CoPN.Campania = @Campania and
		CoPN.CodigoConsultora = @CodigoConsultora and CoPN.Participa = 1;
END
GO
/*end*/

USE BelcorpEcuador
GO
ALTER PROCEDURE dbo.GetConfiguracionProgramaNuevas
	@CodigoConsultora varchar(25),
	@Campania char(6),
	@CampaniaIngreso char(6) = ''
AS
BEGIN
	select top 1
		CfPN.CodigoPrograma,
		CfPN.IndExigVent,
		CfPN.IndProgObli,
		CfPN.CUVKit,
		CoPN.MontoVentaExigido
	from ods.ConfiguracionProgramaNuevas CfPN
	inner join ods.ConsultorasProgramaNuevas CoPN on CoPN.CodigoPrograma = CfPN.CodigoPrograma
	where
		CfPN.CampanaCarga = @CampaniaIngreso and CoPN.Campania = @Campania and
		CoPN.CodigoConsultora = @CodigoConsultora and CoPN.Participa = 1;
END
GO
/*end*/

USE BelcorpGuatemala
GO
ALTER PROCEDURE dbo.GetConfiguracionProgramaNuevas
	@CodigoConsultora varchar(25),
	@Campania char(6),
	@CampaniaIngreso char(6) = ''
AS
BEGIN
	select top 1
		CfPN.CodigoPrograma,
		CfPN.IndExigVent,
		CfPN.IndProgObli,
		CfPN.CUVKit,
		CoPN.MontoVentaExigido
	from ods.ConfiguracionProgramaNuevas CfPN
	inner join ods.ConsultorasProgramaNuevas CoPN on CoPN.CodigoPrograma = CfPN.CodigoPrograma
	where
		CfPN.CampanaCarga = @CampaniaIngreso and CoPN.Campania = @Campania and
		CoPN.CodigoConsultora = @CodigoConsultora and CoPN.Participa = 1;
END
GO
/*end*/

USE BelcorpMexico
GO
ALTER PROCEDURE dbo.GetConfiguracionProgramaNuevas
	@CodigoConsultora varchar(25),
	@Campania char(6),
	@CampaniaIngreso char(6) = ''
AS
BEGIN
	select top 1
		CfPN.CodigoPrograma,
		CfPN.IndExigVent,
		CfPN.IndProgObli,
		CfPN.CUVKit,
		CoPN.MontoVentaExigido
	from ods.ConfiguracionProgramaNuevas CfPN
	inner join ods.ConsultorasProgramaNuevas CoPN on CoPN.CodigoPrograma = CfPN.CodigoPrograma
	where
		CfPN.CampanaCarga = @CampaniaIngreso and CoPN.Campania = @Campania and
		CoPN.CodigoConsultora = @CodigoConsultora and CoPN.Participa = 1;
END
GO
/*end*/

USE BelcorpPanama
GO
ALTER PROCEDURE dbo.GetConfiguracionProgramaNuevas
	@CodigoConsultora varchar(25),
	@Campania char(6),
	@CampaniaIngreso char(6) = ''
AS
BEGIN
	select top 1
		CfPN.CodigoPrograma,
		CfPN.IndExigVent,
		CfPN.IndProgObli,
		CfPN.CUVKit,
		CoPN.MontoVentaExigido
	from ods.ConfiguracionProgramaNuevas CfPN
	inner join ods.ConsultorasProgramaNuevas CoPN on CoPN.CodigoPrograma = CfPN.CodigoPrograma
	where
		CfPN.CampanaCarga = @CampaniaIngreso and CoPN.Campania = @Campania and
		CoPN.CodigoConsultora = @CodigoConsultora and CoPN.Participa = 1;
END
GO
/*end*/

USE BelcorpPeru
GO
ALTER PROCEDURE dbo.GetConfiguracionProgramaNuevas
	@CodigoConsultora varchar(25),
	@Campania char(6),
	@CampaniaIngreso char(6) = ''
AS
BEGIN
	select top 1
		CfPN.CodigoPrograma,
		CfPN.IndExigVent,
		CfPN.IndProgObli,
		CfPN.CUVKit,
		CoPN.MontoVentaExigido
	from ods.ConfiguracionProgramaNuevas CfPN
	inner join ods.ConsultorasProgramaNuevas CoPN on CoPN.CodigoPrograma = CfPN.CodigoPrograma
	where
		CfPN.CampanaCarga = @CampaniaIngreso and CoPN.Campania = @Campania and
		CoPN.CodigoConsultora = @CodigoConsultora and CoPN.Participa = 1;
END
GO
/*end*/

USE BelcorpPuertoRico
GO
ALTER PROCEDURE dbo.GetConfiguracionProgramaNuevas
	@CodigoConsultora varchar(25),
	@Campania char(6),
	@CampaniaIngreso char(6) = ''
AS
BEGIN
	select top 1
		CfPN.CodigoPrograma,
		CfPN.IndExigVent,
		CfPN.IndProgObli,
		CfPN.CUVKit,
		CoPN.MontoVentaExigido
	from ods.ConfiguracionProgramaNuevas CfPN
	inner join ods.ConsultorasProgramaNuevas CoPN on CoPN.CodigoPrograma = CfPN.CodigoPrograma
	where
		CfPN.CampanaCarga = @CampaniaIngreso and CoPN.Campania = @Campania and
		CoPN.CodigoConsultora = @CodigoConsultora and CoPN.Participa = 1;
END
GO
/*end*/

USE BelcorpSalvador
GO
ALTER PROCEDURE dbo.GetConfiguracionProgramaNuevas
	@CodigoConsultora varchar(25),
	@Campania char(6),
	@CampaniaIngreso char(6) = ''
AS
BEGIN
	select top 1
		CfPN.CodigoPrograma,
		CfPN.IndExigVent,
		CfPN.IndProgObli,
		CfPN.CUVKit,
		CoPN.MontoVentaExigido
	from ods.ConfiguracionProgramaNuevas CfPN
	inner join ods.ConsultorasProgramaNuevas CoPN on CoPN.CodigoPrograma = CfPN.CodigoPrograma
	where
		CfPN.CampanaCarga = @CampaniaIngreso and CoPN.Campania = @Campania and
		CoPN.CodigoConsultora = @CodigoConsultora and CoPN.Participa = 1;
END
GO