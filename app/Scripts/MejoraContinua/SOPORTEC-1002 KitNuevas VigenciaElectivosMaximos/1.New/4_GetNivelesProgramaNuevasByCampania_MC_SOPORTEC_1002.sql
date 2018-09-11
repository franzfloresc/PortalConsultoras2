USE BelcorpBolivia
GO
ALTER PROCEDURE dbo.GetNivelesProgramaNuevasByCampania
	@Campania varchar(6)
AS
BEGIN
	set nocount on;

	select
		NPN.CodigoPrograma,
		NPN.Campania,
		NPN.CodigoNivel,
		NPN.UnidadesNivel,
		NPN.UnidadesNivelElectivo,
		CPN.NumeroCampanasVigentes
	from ods.NivelesProgramaNuevas NPN (nolock)
	inner join (
		select distinct
			CodigoPrograma,
			CodigoNivel,
			NumeroCampanasVigentes
		from ods.CuponesProgramaNuevas (nolock)
		where Campana = @Campania
	) CPN on NPN.CodigoPrograma = CPN.CodigoPrograma and NPN.CodigoNivel = CPN.CodigoNivel
	where NPN.Campania = @Campania;
END
GO

USE BelcorpChile
GO
ALTER PROCEDURE dbo.GetNivelesProgramaNuevasByCampania
	@Campania varchar(6)
AS
BEGIN
	set nocount on;

	select
		NPN.CodigoPrograma,
		NPN.Campania,
		NPN.CodigoNivel,
		NPN.UnidadesNivel,
		NPN.UnidadesNivelElectivo,
		CPN.NumeroCampanasVigentes
	from ods.NivelesProgramaNuevas NPN (nolock)
	inner join (
		select distinct
			CodigoPrograma,
			CodigoNivel,
			NumeroCampanasVigentes
		from ods.CuponesProgramaNuevas (nolock)
		where Campana = @Campania
	) CPN on NPN.CodigoPrograma = CPN.CodigoPrograma and NPN.CodigoNivel = CPN.CodigoNivel
	where NPN.Campania = @Campania;
END
GO

USE BelcorpColombia
GO
ALTER PROCEDURE dbo.GetNivelesProgramaNuevasByCampania
	@Campania varchar(6)
AS
BEGIN
	set nocount on;

	select
		NPN.CodigoPrograma,
		NPN.Campania,
		NPN.CodigoNivel,
		NPN.UnidadesNivel,
		NPN.UnidadesNivelElectivo,
		CPN.NumeroCampanasVigentes
	from ods.NivelesProgramaNuevas NPN (nolock)
	inner join (
		select distinct
			CodigoPrograma,
			CodigoNivel,
			NumeroCampanasVigentes
		from ods.CuponesProgramaNuevas (nolock)
		where Campana = @Campania
	) CPN on NPN.CodigoPrograma = CPN.CodigoPrograma and NPN.CodigoNivel = CPN.CodigoNivel
	where NPN.Campania = @Campania;
END
GO

USE BelcorpCostaRica
GO
ALTER PROCEDURE dbo.GetNivelesProgramaNuevasByCampania
	@Campania varchar(6)
AS
BEGIN
	set nocount on;

	select
		NPN.CodigoPrograma,
		NPN.Campania,
		NPN.CodigoNivel,
		NPN.UnidadesNivel,
		NPN.UnidadesNivelElectivo,
		CPN.NumeroCampanasVigentes
	from ods.NivelesProgramaNuevas NPN (nolock)
	inner join (
		select distinct
			CodigoPrograma,
			CodigoNivel,
			NumeroCampanasVigentes
		from ods.CuponesProgramaNuevas (nolock)
		where Campana = @Campania
	) CPN on NPN.CodigoPrograma = CPN.CodigoPrograma and NPN.CodigoNivel = CPN.CodigoNivel
	where NPN.Campania = @Campania;
END
GO

USE BelcorpDominicana
GO
ALTER PROCEDURE dbo.GetNivelesProgramaNuevasByCampania
	@Campania varchar(6)
AS
BEGIN
	set nocount on;

	select
		NPN.CodigoPrograma,
		NPN.Campania,
		NPN.CodigoNivel,
		NPN.UnidadesNivel,
		NPN.UnidadesNivelElectivo,
		CPN.NumeroCampanasVigentes
	from ods.NivelesProgramaNuevas NPN (nolock)
	inner join (
		select distinct
			CodigoPrograma,
			CodigoNivel,
			NumeroCampanasVigentes
		from ods.CuponesProgramaNuevas (nolock)
		where Campana = @Campania
	) CPN on NPN.CodigoPrograma = CPN.CodigoPrograma and NPN.CodigoNivel = CPN.CodigoNivel
	where NPN.Campania = @Campania;
END
GO

USE BelcorpEcuador
GO
ALTER PROCEDURE dbo.GetNivelesProgramaNuevasByCampania
	@Campania varchar(6)
AS
BEGIN
	set nocount on;

	select
		NPN.CodigoPrograma,
		NPN.Campania,
		NPN.CodigoNivel,
		NPN.UnidadesNivel,
		NPN.UnidadesNivelElectivo,
		CPN.NumeroCampanasVigentes
	from ods.NivelesProgramaNuevas NPN (nolock)
	inner join (
		select distinct
			CodigoPrograma,
			CodigoNivel,
			NumeroCampanasVigentes
		from ods.CuponesProgramaNuevas (nolock)
		where Campana = @Campania
	) CPN on NPN.CodigoPrograma = CPN.CodigoPrograma and NPN.CodigoNivel = CPN.CodigoNivel
	where NPN.Campania = @Campania;
END
GO

USE BelcorpGuatemala
GO
ALTER PROCEDURE dbo.GetNivelesProgramaNuevasByCampania
	@Campania varchar(6)
AS
BEGIN
	set nocount on;

	select
		NPN.CodigoPrograma,
		NPN.Campania,
		NPN.CodigoNivel,
		NPN.UnidadesNivel,
		NPN.UnidadesNivelElectivo,
		CPN.NumeroCampanasVigentes
	from ods.NivelesProgramaNuevas NPN (nolock)
	inner join (
		select distinct
			CodigoPrograma,
			CodigoNivel,
			NumeroCampanasVigentes
		from ods.CuponesProgramaNuevas (nolock)
		where Campana = @Campania
	) CPN on NPN.CodigoPrograma = CPN.CodigoPrograma and NPN.CodigoNivel = CPN.CodigoNivel
	where NPN.Campania = @Campania;
END
GO

USE BelcorpMexico
GO
ALTER PROCEDURE dbo.GetNivelesProgramaNuevasByCampania
	@Campania varchar(6)
AS
BEGIN
	set nocount on;

	select
		NPN.CodigoPrograma,
		NPN.Campania,
		NPN.CodigoNivel,
		NPN.UnidadesNivel,
		NPN.UnidadesNivelElectivo,
		CPN.NumeroCampanasVigentes
	from ods.NivelesProgramaNuevas NPN (nolock)
	inner join (
		select distinct
			CodigoPrograma,
			CodigoNivel,
			NumeroCampanasVigentes
		from ods.CuponesProgramaNuevas (nolock)
		where Campana = @Campania
	) CPN on NPN.CodigoPrograma = CPN.CodigoPrograma and NPN.CodigoNivel = CPN.CodigoNivel
	where NPN.Campania = @Campania;
END
GO

USE BelcorpPanama
GO
ALTER PROCEDURE dbo.GetNivelesProgramaNuevasByCampania
	@Campania varchar(6)
AS
BEGIN
	set nocount on;

	select
		NPN.CodigoPrograma,
		NPN.Campania,
		NPN.CodigoNivel,
		NPN.UnidadesNivel,
		NPN.UnidadesNivelElectivo,
		CPN.NumeroCampanasVigentes
	from ods.NivelesProgramaNuevas NPN (nolock)
	inner join (
		select distinct
			CodigoPrograma,
			CodigoNivel,
			NumeroCampanasVigentes
		from ods.CuponesProgramaNuevas (nolock)
		where Campana = @Campania
	) CPN on NPN.CodigoPrograma = CPN.CodigoPrograma and NPN.CodigoNivel = CPN.CodigoNivel
	where NPN.Campania = @Campania;
END
GO

USE BelcorpPeru
GO
ALTER PROCEDURE dbo.GetNivelesProgramaNuevasByCampania
	@Campania varchar(6)
AS
BEGIN
	set nocount on;

	select
		NPN.CodigoPrograma,
		NPN.Campania,
		NPN.CodigoNivel,
		NPN.UnidadesNivel,
		NPN.UnidadesNivelElectivo,
		CPN.NumeroCampanasVigentes
	from ods.NivelesProgramaNuevas NPN (nolock)
	inner join (
		select distinct
			CodigoPrograma,
			CodigoNivel,
			NumeroCampanasVigentes
		from ods.CuponesProgramaNuevas (nolock)
		where Campana = @Campania
	) CPN on NPN.CodigoPrograma = CPN.CodigoPrograma and NPN.CodigoNivel = CPN.CodigoNivel
	where NPN.Campania = @Campania;
END
GO

USE BelcorpPuertoRico
GO
ALTER PROCEDURE dbo.GetNivelesProgramaNuevasByCampania
	@Campania varchar(6)
AS
BEGIN
	set nocount on;

	select
		NPN.CodigoPrograma,
		NPN.Campania,
		NPN.CodigoNivel,
		NPN.UnidadesNivel,
		NPN.UnidadesNivelElectivo,
		CPN.NumeroCampanasVigentes
	from ods.NivelesProgramaNuevas NPN (nolock)
	inner join (
		select distinct
			CodigoPrograma,
			CodigoNivel,
			NumeroCampanasVigentes
		from ods.CuponesProgramaNuevas (nolock)
		where Campana = @Campania
	) CPN on NPN.CodigoPrograma = CPN.CodigoPrograma and NPN.CodigoNivel = CPN.CodigoNivel
	where NPN.Campania = @Campania;
END
GO

USE BelcorpSalvador
GO
ALTER PROCEDURE dbo.GetNivelesProgramaNuevasByCampania
	@Campania varchar(6)
AS
BEGIN
	set nocount on;

	select
		NPN.CodigoPrograma,
		NPN.Campania,
		NPN.CodigoNivel,
		NPN.UnidadesNivel,
		NPN.UnidadesNivelElectivo,
		CPN.NumeroCampanasVigentes
	from ods.NivelesProgramaNuevas NPN (nolock)
	inner join (
		select distinct
			CodigoPrograma,
			CodigoNivel,
			NumeroCampanasVigentes
		from ods.CuponesProgramaNuevas (nolock)
		where Campana = @Campania
	) CPN on NPN.CodigoPrograma = CPN.CodigoPrograma and NPN.CodigoNivel = CPN.CodigoNivel
	where NPN.Campania = @Campania;
END
GO