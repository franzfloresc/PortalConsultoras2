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
/*end*/

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
/*end*/

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
/*end*/

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
/*end*/

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
/*end*/

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
/*end*/

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
/*end*/

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
/*end*/

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
/*end*/

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
/*end*/

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
/*end*/

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