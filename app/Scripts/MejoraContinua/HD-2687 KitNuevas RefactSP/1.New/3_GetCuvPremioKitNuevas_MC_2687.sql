USE BelcorpBolivia
GO
IF OBJECT_ID('dbo.GetCuvPremioKitNuevas') IS NOT NULL
BEGIN
	drop procedure dbo.GetCuvPremioKitNuevas
END
GO
CREATE PROCEDURE dbo.GetCuvPremioKitNuevas
	@CodigoPrograma varchar(3),
	@Campania char(6),
	@CodigoNivel char(2)
AS
BEGIN
	select top 1 CUV
	from ods.PremiosProgramaNuevas
	where
		CodigoPrograma = @CodigoPrograma and AnoCampana = @Campania and
		CodigoNivel = @CodigoNivel and PrecioUnitario > 0;
END
GO

USE BelcorpChile
GO
IF OBJECT_ID('dbo.GetCuvPremioKitNuevas') IS NOT NULL
BEGIN
	drop procedure dbo.GetCuvPremioKitNuevas
END
GO
CREATE PROCEDURE dbo.GetCuvPremioKitNuevas
	@CodigoPrograma varchar(3),
	@Campania char(6),
	@CodigoNivel char(2)
AS
BEGIN
	select top 1 CUV
	from ods.PremiosProgramaNuevas
	where
		CodigoPrograma = @CodigoPrograma and AnoCampana = @Campania and
		CodigoNivel = @CodigoNivel and PrecioUnitario > 0;
END
GO

USE BelcorpColombia
GO
IF OBJECT_ID('dbo.GetCuvPremioKitNuevas') IS NOT NULL
BEGIN
	drop procedure dbo.GetCuvPremioKitNuevas
END
GO
CREATE PROCEDURE dbo.GetCuvPremioKitNuevas
	@CodigoPrograma varchar(3),
	@Campania char(6),
	@CodigoNivel char(2)
AS
BEGIN
	select top 1 CUV
	from ods.PremiosProgramaNuevas
	where
		CodigoPrograma = @CodigoPrograma and AnoCampana = @Campania and
		CodigoNivel = @CodigoNivel and PrecioUnitario > 0;
END
GO

USE BelcorpCostaRica
GO
IF OBJECT_ID('dbo.GetCuvPremioKitNuevas') IS NOT NULL
BEGIN
	drop procedure dbo.GetCuvPremioKitNuevas
END
GO
CREATE PROCEDURE dbo.GetCuvPremioKitNuevas
	@CodigoPrograma varchar(3),
	@Campania char(6),
	@CodigoNivel char(2)
AS
BEGIN
	select top 1 CUV
	from ods.PremiosProgramaNuevas
	where
		CodigoPrograma = @CodigoPrograma and AnoCampana = @Campania and
		CodigoNivel = @CodigoNivel and PrecioUnitario > 0;
END
GO

USE BelcorpDominicana
GO
IF OBJECT_ID('dbo.GetCuvPremioKitNuevas') IS NOT NULL
BEGIN
	drop procedure dbo.GetCuvPremioKitNuevas
END
GO
CREATE PROCEDURE dbo.GetCuvPremioKitNuevas
	@CodigoPrograma varchar(3),
	@Campania char(6),
	@CodigoNivel char(2)
AS
BEGIN
	select top 1 CUV
	from ods.PremiosProgramaNuevas
	where
		CodigoPrograma = @CodigoPrograma and AnoCampana = @Campania and
		CodigoNivel = @CodigoNivel and PrecioUnitario > 0;
END
GO

USE BelcorpEcuador
GO
IF OBJECT_ID('dbo.GetCuvPremioKitNuevas') IS NOT NULL
BEGIN
	drop procedure dbo.GetCuvPremioKitNuevas
END
GO
CREATE PROCEDURE dbo.GetCuvPremioKitNuevas
	@CodigoPrograma varchar(3),
	@Campania char(6),
	@CodigoNivel char(2)
AS
BEGIN
	select top 1 CUV
	from ods.PremiosProgramaNuevas
	where
		CodigoPrograma = @CodigoPrograma and AnoCampana = @Campania and
		CodigoNivel = @CodigoNivel and PrecioUnitario > 0;
END
GO

USE BelcorpGuatemala
GO
IF OBJECT_ID('dbo.GetCuvPremioKitNuevas') IS NOT NULL
BEGIN
	drop procedure dbo.GetCuvPremioKitNuevas
END
GO
CREATE PROCEDURE dbo.GetCuvPremioKitNuevas
	@CodigoPrograma varchar(3),
	@Campania char(6),
	@CodigoNivel char(2)
AS
BEGIN
	select top 1 CUV
	from ods.PremiosProgramaNuevas
	where
		CodigoPrograma = @CodigoPrograma and AnoCampana = @Campania and
		CodigoNivel = @CodigoNivel and PrecioUnitario > 0;
END
GO

USE BelcorpMexico
GO
IF OBJECT_ID('dbo.GetCuvPremioKitNuevas') IS NOT NULL
BEGIN
	drop procedure dbo.GetCuvPremioKitNuevas
END
GO
CREATE PROCEDURE dbo.GetCuvPremioKitNuevas
	@CodigoPrograma varchar(3),
	@Campania char(6),
	@CodigoNivel char(2)
AS
BEGIN
	select top 1 CUV
	from ods.PremiosProgramaNuevas
	where
		CodigoPrograma = @CodigoPrograma and AnoCampana = @Campania and
		CodigoNivel = @CodigoNivel and PrecioUnitario > 0;
END
GO

USE BelcorpPanama
GO
IF OBJECT_ID('dbo.GetCuvPremioKitNuevas') IS NOT NULL
BEGIN
	drop procedure dbo.GetCuvPremioKitNuevas
END
GO
CREATE PROCEDURE dbo.GetCuvPremioKitNuevas
	@CodigoPrograma varchar(3),
	@Campania char(6),
	@CodigoNivel char(2)
AS
BEGIN
	select top 1 CUV
	from ods.PremiosProgramaNuevas
	where
		CodigoPrograma = @CodigoPrograma and AnoCampana = @Campania and
		CodigoNivel = @CodigoNivel and PrecioUnitario > 0;
END
GO

USE BelcorpPeru
GO
IF OBJECT_ID('dbo.GetCuvPremioKitNuevas') IS NOT NULL
BEGIN
	drop procedure dbo.GetCuvPremioKitNuevas
END
GO
CREATE PROCEDURE dbo.GetCuvPremioKitNuevas
	@CodigoPrograma varchar(3),
	@Campania char(6),
	@CodigoNivel char(2)
AS
BEGIN
	select top 1 CUV
	from ods.PremiosProgramaNuevas
	where
		CodigoPrograma = @CodigoPrograma and AnoCampana = @Campania and
		CodigoNivel = @CodigoNivel and PrecioUnitario > 0;
END
GO

USE BelcorpPuertoRico
GO
IF OBJECT_ID('dbo.GetCuvPremioKitNuevas') IS NOT NULL
BEGIN
	drop procedure dbo.GetCuvPremioKitNuevas
END
GO
CREATE PROCEDURE dbo.GetCuvPremioKitNuevas
	@CodigoPrograma varchar(3),
	@Campania char(6),
	@CodigoNivel char(2)
AS
BEGIN
	select top 1 CUV
	from ods.PremiosProgramaNuevas
	where
		CodigoPrograma = @CodigoPrograma and AnoCampana = @Campania and
		CodigoNivel = @CodigoNivel and PrecioUnitario > 0;
END
GO

USE BelcorpSalvador
GO
IF OBJECT_ID('dbo.GetCuvPremioKitNuevas') IS NOT NULL
BEGIN
	drop procedure dbo.GetCuvPremioKitNuevas
END
GO
CREATE PROCEDURE dbo.GetCuvPremioKitNuevas
	@CodigoPrograma varchar(3),
	@Campania char(6),
	@CodigoNivel char(2)
AS
BEGIN
	select top 1 CUV
	from ods.PremiosProgramaNuevas
	where
		CodigoPrograma = @CodigoPrograma and AnoCampana = @Campania and
		CodigoNivel = @CodigoNivel and PrecioUnitario > 0;
END
GO