USE BelcorpBolivia
GO
IF OBJECT_ID('dbo.GetNivelesProgramaNuevasByCampania') IS NOT NULL
BEGIN
	drop procedure dbo.GetNivelesProgramaNuevasByCampania
END
GO
CREATE PROCEDURE dbo.GetNivelesProgramaNuevasByCampania
	@Campania varchar(6)
AS
BEGIN
	set nocount on;

	select
		CodigoPrograma,
		Campania,
		CodigoNivel,
		UnidadesNivel,
		UnidadesNivelElectivo
	from ods.NivelesProgramaNuevas
	where Campania = @Campania;
END
GO
/*end*/

USE BelcorpChile
GO
IF OBJECT_ID('dbo.GetNivelesProgramaNuevasByCampania') IS NOT NULL
BEGIN
	drop procedure dbo.GetNivelesProgramaNuevasByCampania
END
GO
CREATE PROCEDURE dbo.GetNivelesProgramaNuevasByCampania
	@Campania varchar(6)
AS
BEGIN
	set nocount on;

	select
		CodigoPrograma,
		Campania,
		CodigoNivel,
		UnidadesNivel,
		UnidadesNivelElectivo
	from ods.NivelesProgramaNuevas
	where Campania = @Campania;
END
GO
/*end*/

USE BelcorpColombia
GO
IF OBJECT_ID('dbo.GetNivelesProgramaNuevasByCampania') IS NOT NULL
BEGIN
	drop procedure dbo.GetNivelesProgramaNuevasByCampania
END
GO
CREATE PROCEDURE dbo.GetNivelesProgramaNuevasByCampania
	@Campania varchar(6)
AS
BEGIN
	set nocount on;

	select
		CodigoPrograma,
		Campania,
		CodigoNivel,
		UnidadesNivel,
		UnidadesNivelElectivo
	from ods.NivelesProgramaNuevas
	where Campania = @Campania;
END
GO
/*end*/

USE BelcorpCostaRica
GO
IF OBJECT_ID('dbo.GetNivelesProgramaNuevasByCampania') IS NOT NULL
BEGIN
	drop procedure dbo.GetNivelesProgramaNuevasByCampania
END
GO
CREATE PROCEDURE dbo.GetNivelesProgramaNuevasByCampania
	@Campania varchar(6)
AS
BEGIN
	set nocount on;

	select
		CodigoPrograma,
		Campania,
		CodigoNivel,
		UnidadesNivel,
		UnidadesNivelElectivo
	from ods.NivelesProgramaNuevas
	where Campania = @Campania;
END
GO
/*end*/

USE BelcorpDominicana
GO
IF OBJECT_ID('dbo.GetNivelesProgramaNuevasByCampania') IS NOT NULL
BEGIN
	drop procedure dbo.GetNivelesProgramaNuevasByCampania
END
GO
CREATE PROCEDURE dbo.GetNivelesProgramaNuevasByCampania
	@Campania varchar(6)
AS
BEGIN
	set nocount on;

	select
		CodigoPrograma,
		Campania,
		CodigoNivel,
		UnidadesNivel,
		UnidadesNivelElectivo
	from ods.NivelesProgramaNuevas
	where Campania = @Campania;
END
GO
/*end*/

USE BelcorpEcuador
GO
IF OBJECT_ID('dbo.GetNivelesProgramaNuevasByCampania') IS NOT NULL
BEGIN
	drop procedure dbo.GetNivelesProgramaNuevasByCampania
END
GO
CREATE PROCEDURE dbo.GetNivelesProgramaNuevasByCampania
	@Campania varchar(6)
AS
BEGIN
	set nocount on;

	select
		CodigoPrograma,
		Campania,
		CodigoNivel,
		UnidadesNivel,
		UnidadesNivelElectivo
	from ods.NivelesProgramaNuevas
	where Campania = @Campania;
END
GO
/*end*/

USE BelcorpGuatemala
GO
IF OBJECT_ID('dbo.GetNivelesProgramaNuevasByCampania') IS NOT NULL
BEGIN
	drop procedure dbo.GetNivelesProgramaNuevasByCampania
END
GO
CREATE PROCEDURE dbo.GetNivelesProgramaNuevasByCampania
	@Campania varchar(6)
AS
BEGIN
	set nocount on;

	select
		CodigoPrograma,
		Campania,
		CodigoNivel,
		UnidadesNivel,
		UnidadesNivelElectivo
	from ods.NivelesProgramaNuevas
	where Campania = @Campania;
END
GO
/*end*/

USE BelcorpMexico
GO
IF OBJECT_ID('dbo.GetNivelesProgramaNuevasByCampania') IS NOT NULL
BEGIN
	drop procedure dbo.GetNivelesProgramaNuevasByCampania
END
GO
CREATE PROCEDURE dbo.GetNivelesProgramaNuevasByCampania
	@Campania varchar(6)
AS
BEGIN
	set nocount on;

	select
		CodigoPrograma,
		Campania,
		CodigoNivel,
		UnidadesNivel,
		UnidadesNivelElectivo
	from ods.NivelesProgramaNuevas
	where Campania = @Campania;
END
GO
/*end*/

USE BelcorpPanama
GO
IF OBJECT_ID('dbo.GetNivelesProgramaNuevasByCampania') IS NOT NULL
BEGIN
	drop procedure dbo.GetNivelesProgramaNuevasByCampania
END
GO
CREATE PROCEDURE dbo.GetNivelesProgramaNuevasByCampania
	@Campania varchar(6)
AS
BEGIN
	set nocount on;

	select
		CodigoPrograma,
		Campania,
		CodigoNivel,
		UnidadesNivel,
		UnidadesNivelElectivo
	from ods.NivelesProgramaNuevas
	where Campania = @Campania;
END
GO
/*end*/

USE BelcorpPeru
GO
IF OBJECT_ID('dbo.GetNivelesProgramaNuevasByCampania') IS NOT NULL
BEGIN
	drop procedure dbo.GetNivelesProgramaNuevasByCampania
END
GO
CREATE PROCEDURE dbo.GetNivelesProgramaNuevasByCampania
	@Campania varchar(6)
AS
BEGIN
	set nocount on;

	select
		CodigoPrograma,
		Campania,
		CodigoNivel,
		UnidadesNivel,
		UnidadesNivelElectivo
	from ods.NivelesProgramaNuevas
	where Campania = @Campania;
END
GO
/*end*/

USE BelcorpPuertoRico
GO
IF OBJECT_ID('dbo.GetNivelesProgramaNuevasByCampania') IS NOT NULL
BEGIN
	drop procedure dbo.GetNivelesProgramaNuevasByCampania
END
GO
CREATE PROCEDURE dbo.GetNivelesProgramaNuevasByCampania
	@Campania varchar(6)
AS
BEGIN
	set nocount on;

	select
		CodigoPrograma,
		Campania,
		CodigoNivel,
		UnidadesNivel,
		UnidadesNivelElectivo
	from ods.NivelesProgramaNuevas
	where Campania = @Campania;
END
GO
/*end*/

USE BelcorpSalvador
GO
IF OBJECT_ID('dbo.GetNivelesProgramaNuevasByCampania') IS NOT NULL
BEGIN
	drop procedure dbo.GetNivelesProgramaNuevasByCampania
END
GO
CREATE PROCEDURE dbo.GetNivelesProgramaNuevasByCampania
	@Campania varchar(6)
AS
BEGIN
	set nocount on;

	select
		CodigoPrograma,
		Campania,
		CodigoNivel,
		UnidadesNivel,
		UnidadesNivelElectivo
	from ods.NivelesProgramaNuevas
	where Campania = @Campania;
END
GO