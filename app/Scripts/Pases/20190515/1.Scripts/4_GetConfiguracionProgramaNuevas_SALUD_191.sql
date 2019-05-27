USE BelcorpPeru
GO

ALTER PROCEDURE dbo.GetConfiguracionProgramaNuevas
	@CodigoConsultora varchar(25),
	@Campania char(6),
	@CampaniaIngreso char(6) = ''
AS
BEGIN
	declare @NroCampanias int = (select top 1 NroCampanias from Pais where EstadoActivo = 1);
	declare @iCampaniaIngreso int = @CampaniaIngreso + 6;
	set @CampaniaIngreso = dbo.fnAddCampaniaAndNumero2(@iCampaniaIngreso,-6,@NroCampanias);

	select top 1
		CfPN.CodigoPrograma,
		CfPN.IndExigVent,
		CfPN.IndProgObli,
		iif(CfPN.CuponKit is null, CfPN.CUVKit, '') CUVKit,
		CoPN.MontoVentaExigido
	from ods.ConfiguracionProgramaNuevas CfPN
	inner join ods.ConsultorasProgramaNuevas CoPN on CoPN.CodigoPrograma = CfPN.CodigoPrograma
	where
		CfPN.CampanaCarga = @CampaniaIngreso and CoPN.Campania = @Campania and
		CoPN.CodigoConsultora = @CodigoConsultora and CoPN.Participa = 1;
END

GO

USE BelcorpMexico
GO

ALTER PROCEDURE dbo.GetConfiguracionProgramaNuevas
	@CodigoConsultora varchar(25),
	@Campania char(6),
	@CampaniaIngreso char(6) = ''
AS
BEGIN
	declare @NroCampanias int = (select top 1 NroCampanias from Pais where EstadoActivo = 1);
	declare @iCampaniaIngreso int = @CampaniaIngreso + 6;
	set @CampaniaIngreso = dbo.fnAddCampaniaAndNumero2(@iCampaniaIngreso,-6,@NroCampanias);

	select top 1
		CfPN.CodigoPrograma,
		CfPN.IndExigVent,
		CfPN.IndProgObli,
		iif(CfPN.CuponKit is null, CfPN.CUVKit, '') CUVKit,
		CoPN.MontoVentaExigido
	from ods.ConfiguracionProgramaNuevas CfPN
	inner join ods.ConsultorasProgramaNuevas CoPN on CoPN.CodigoPrograma = CfPN.CodigoPrograma
	where
		CfPN.CampanaCarga = @CampaniaIngreso and CoPN.Campania = @Campania and
		CoPN.CodigoConsultora = @CodigoConsultora and CoPN.Participa = 1;
END

GO

USE BelcorpColombia
GO

ALTER PROCEDURE dbo.GetConfiguracionProgramaNuevas
	@CodigoConsultora varchar(25),
	@Campania char(6),
	@CampaniaIngreso char(6) = ''
AS
BEGIN
	declare @NroCampanias int = (select top 1 NroCampanias from Pais where EstadoActivo = 1);
	declare @iCampaniaIngreso int = @CampaniaIngreso + 6;
	set @CampaniaIngreso = dbo.fnAddCampaniaAndNumero2(@iCampaniaIngreso,-6,@NroCampanias);

	select top 1
		CfPN.CodigoPrograma,
		CfPN.IndExigVent,
		CfPN.IndProgObli,
		iif(CfPN.CuponKit is null, CfPN.CUVKit, '') CUVKit,
		CoPN.MontoVentaExigido
	from ods.ConfiguracionProgramaNuevas CfPN
	inner join ods.ConsultorasProgramaNuevas CoPN on CoPN.CodigoPrograma = CfPN.CodigoPrograma
	where
		CfPN.CampanaCarga = @CampaniaIngreso and CoPN.Campania = @Campania and
		CoPN.CodigoConsultora = @CodigoConsultora and CoPN.Participa = 1;
END

GO

USE BelcorpSalvador
GO

ALTER PROCEDURE dbo.GetConfiguracionProgramaNuevas
	@CodigoConsultora varchar(25),
	@Campania char(6),
	@CampaniaIngreso char(6) = ''
AS
BEGIN
	declare @NroCampanias int = (select top 1 NroCampanias from Pais where EstadoActivo = 1);
	declare @iCampaniaIngreso int = @CampaniaIngreso + 6;
	set @CampaniaIngreso = dbo.fnAddCampaniaAndNumero2(@iCampaniaIngreso,-6,@NroCampanias);

	select top 1
		CfPN.CodigoPrograma,
		CfPN.IndExigVent,
		CfPN.IndProgObli,
		iif(CfPN.CuponKit is null, CfPN.CUVKit, '') CUVKit,
		CoPN.MontoVentaExigido
	from ods.ConfiguracionProgramaNuevas CfPN
	inner join ods.ConsultorasProgramaNuevas CoPN on CoPN.CodigoPrograma = CfPN.CodigoPrograma
	where
		CfPN.CampanaCarga = @CampaniaIngreso and CoPN.Campania = @Campania and
		CoPN.CodigoConsultora = @CodigoConsultora and CoPN.Participa = 1;
END

GO

USE BelcorpPuertoRico
GO

ALTER PROCEDURE dbo.GetConfiguracionProgramaNuevas
	@CodigoConsultora varchar(25),
	@Campania char(6),
	@CampaniaIngreso char(6) = ''
AS
BEGIN
	declare @NroCampanias int = (select top 1 NroCampanias from Pais where EstadoActivo = 1);
	declare @iCampaniaIngreso int = @CampaniaIngreso + 6;
	set @CampaniaIngreso = dbo.fnAddCampaniaAndNumero2(@iCampaniaIngreso,-6,@NroCampanias);

	select top 1
		CfPN.CodigoPrograma,
		CfPN.IndExigVent,
		CfPN.IndProgObli,
		iif(CfPN.CuponKit is null, CfPN.CUVKit, '') CUVKit,
		CoPN.MontoVentaExigido
	from ods.ConfiguracionProgramaNuevas CfPN
	inner join ods.ConsultorasProgramaNuevas CoPN on CoPN.CodigoPrograma = CfPN.CodigoPrograma
	where
		CfPN.CampanaCarga = @CampaniaIngreso and CoPN.Campania = @Campania and
		CoPN.CodigoConsultora = @CodigoConsultora and CoPN.Participa = 1;
END

GO

USE BelcorpPanama
GO

ALTER PROCEDURE dbo.GetConfiguracionProgramaNuevas
	@CodigoConsultora varchar(25),
	@Campania char(6),
	@CampaniaIngreso char(6) = ''
AS
BEGIN
	declare @NroCampanias int = (select top 1 NroCampanias from Pais where EstadoActivo = 1);
	declare @iCampaniaIngreso int = @CampaniaIngreso + 6;
	set @CampaniaIngreso = dbo.fnAddCampaniaAndNumero2(@iCampaniaIngreso,-6,@NroCampanias);

	select top 1
		CfPN.CodigoPrograma,
		CfPN.IndExigVent,
		CfPN.IndProgObli,
		iif(CfPN.CuponKit is null, CfPN.CUVKit, '') CUVKit,
		CoPN.MontoVentaExigido
	from ods.ConfiguracionProgramaNuevas CfPN
	inner join ods.ConsultorasProgramaNuevas CoPN on CoPN.CodigoPrograma = CfPN.CodigoPrograma
	where
		CfPN.CampanaCarga = @CampaniaIngreso and CoPN.Campania = @Campania and
		CoPN.CodigoConsultora = @CodigoConsultora and CoPN.Participa = 1;
END

GO

USE BelcorpGuatemala
GO

ALTER PROCEDURE dbo.GetConfiguracionProgramaNuevas
	@CodigoConsultora varchar(25),
	@Campania char(6),
	@CampaniaIngreso char(6) = ''
AS
BEGIN
	declare @NroCampanias int = (select top 1 NroCampanias from Pais where EstadoActivo = 1);
	declare @iCampaniaIngreso int = @CampaniaIngreso + 6;
	set @CampaniaIngreso = dbo.fnAddCampaniaAndNumero2(@iCampaniaIngreso,-6,@NroCampanias);

	select top 1
		CfPN.CodigoPrograma,
		CfPN.IndExigVent,
		CfPN.IndProgObli,
		iif(CfPN.CuponKit is null, CfPN.CUVKit, '') CUVKit,
		CoPN.MontoVentaExigido
	from ods.ConfiguracionProgramaNuevas CfPN
	inner join ods.ConsultorasProgramaNuevas CoPN on CoPN.CodigoPrograma = CfPN.CodigoPrograma
	where
		CfPN.CampanaCarga = @CampaniaIngreso and CoPN.Campania = @Campania and
		CoPN.CodigoConsultora = @CodigoConsultora and CoPN.Participa = 1;
END

GO

USE BelcorpEcuador
GO

ALTER PROCEDURE dbo.GetConfiguracionProgramaNuevas
	@CodigoConsultora varchar(25),
	@Campania char(6),
	@CampaniaIngreso char(6) = ''
AS
BEGIN
	declare @NroCampanias int = (select top 1 NroCampanias from Pais where EstadoActivo = 1);
	declare @iCampaniaIngreso int = @CampaniaIngreso + 6;
	set @CampaniaIngreso = dbo.fnAddCampaniaAndNumero2(@iCampaniaIngreso,-6,@NroCampanias);

	select top 1
		CfPN.CodigoPrograma,
		CfPN.IndExigVent,
		CfPN.IndProgObli,
		iif(CfPN.CuponKit is null, CfPN.CUVKit, '') CUVKit,
		CoPN.MontoVentaExigido
	from ods.ConfiguracionProgramaNuevas CfPN
	inner join ods.ConsultorasProgramaNuevas CoPN on CoPN.CodigoPrograma = CfPN.CodigoPrograma
	where
		CfPN.CampanaCarga = @CampaniaIngreso and CoPN.Campania = @Campania and
		CoPN.CodigoConsultora = @CodigoConsultora and CoPN.Participa = 1;
END

GO

USE BelcorpDominicana
GO

ALTER PROCEDURE dbo.GetConfiguracionProgramaNuevas
	@CodigoConsultora varchar(25),
	@Campania char(6),
	@CampaniaIngreso char(6) = ''
AS
BEGIN
	declare @NroCampanias int = (select top 1 NroCampanias from Pais where EstadoActivo = 1);
	declare @iCampaniaIngreso int = @CampaniaIngreso + 6;
	set @CampaniaIngreso = dbo.fnAddCampaniaAndNumero2(@iCampaniaIngreso,-6,@NroCampanias);

	select top 1
		CfPN.CodigoPrograma,
		CfPN.IndExigVent,
		CfPN.IndProgObli,
		iif(CfPN.CuponKit is null, CfPN.CUVKit, '') CUVKit,
		CoPN.MontoVentaExigido
	from ods.ConfiguracionProgramaNuevas CfPN
	inner join ods.ConsultorasProgramaNuevas CoPN on CoPN.CodigoPrograma = CfPN.CodigoPrograma
	where
		CfPN.CampanaCarga = @CampaniaIngreso and CoPN.Campania = @Campania and
		CoPN.CodigoConsultora = @CodigoConsultora and CoPN.Participa = 1;
END

GO

USE BelcorpCostaRica
GO

ALTER PROCEDURE dbo.GetConfiguracionProgramaNuevas
	@CodigoConsultora varchar(25),
	@Campania char(6),
	@CampaniaIngreso char(6) = ''
AS
BEGIN
	declare @NroCampanias int = (select top 1 NroCampanias from Pais where EstadoActivo = 1);
	declare @iCampaniaIngreso int = @CampaniaIngreso + 6;
	set @CampaniaIngreso = dbo.fnAddCampaniaAndNumero2(@iCampaniaIngreso,-6,@NroCampanias);

	select top 1
		CfPN.CodigoPrograma,
		CfPN.IndExigVent,
		CfPN.IndProgObli,
		iif(CfPN.CuponKit is null, CfPN.CUVKit, '') CUVKit,
		CoPN.MontoVentaExigido
	from ods.ConfiguracionProgramaNuevas CfPN
	inner join ods.ConsultorasProgramaNuevas CoPN on CoPN.CodigoPrograma = CfPN.CodigoPrograma
	where
		CfPN.CampanaCarga = @CampaniaIngreso and CoPN.Campania = @Campania and
		CoPN.CodigoConsultora = @CodigoConsultora and CoPN.Participa = 1;
END

GO

USE BelcorpChile
GO

ALTER PROCEDURE dbo.GetConfiguracionProgramaNuevas
	@CodigoConsultora varchar(25),
	@Campania char(6),
	@CampaniaIngreso char(6) = ''
AS
BEGIN
	declare @NroCampanias int = (select top 1 NroCampanias from Pais where EstadoActivo = 1);
	declare @iCampaniaIngreso int = @CampaniaIngreso + 6;
	set @CampaniaIngreso = dbo.fnAddCampaniaAndNumero2(@iCampaniaIngreso,-6,@NroCampanias);

	select top 1
		CfPN.CodigoPrograma,
		CfPN.IndExigVent,
		CfPN.IndProgObli,
		iif(CfPN.CuponKit is null, CfPN.CUVKit, '') CUVKit,
		CoPN.MontoVentaExigido
	from ods.ConfiguracionProgramaNuevas CfPN
	inner join ods.ConsultorasProgramaNuevas CoPN on CoPN.CodigoPrograma = CfPN.CodigoPrograma
	where
		CfPN.CampanaCarga = @CampaniaIngreso and CoPN.Campania = @Campania and
		CoPN.CodigoConsultora = @CodigoConsultora and CoPN.Participa = 1;
END

GO

USE BelcorpBolivia
GO

ALTER PROCEDURE dbo.GetConfiguracionProgramaNuevas
	@CodigoConsultora varchar(25),
	@Campania char(6),
	@CampaniaIngreso char(6) = ''
AS
BEGIN
	declare @NroCampanias int = (select top 1 NroCampanias from Pais where EstadoActivo = 1);
	declare @iCampaniaIngreso int = @CampaniaIngreso + 6;
	set @CampaniaIngreso = dbo.fnAddCampaniaAndNumero2(@iCampaniaIngreso,-6,@NroCampanias);

	select top 1
		CfPN.CodigoPrograma,
		CfPN.IndExigVent,
		CfPN.IndProgObli,
		iif(CfPN.CuponKit is null, CfPN.CUVKit, '') CUVKit,
		CoPN.MontoVentaExigido
	from ods.ConfiguracionProgramaNuevas CfPN
	inner join ods.ConsultorasProgramaNuevas CoPN on CoPN.CodigoPrograma = CfPN.CodigoPrograma
	where
		CfPN.CampanaCarga = @CampaniaIngreso and CoPN.Campania = @Campania and
		CoPN.CodigoConsultora = @CodigoConsultora and CoPN.Participa = 1;
END

GO