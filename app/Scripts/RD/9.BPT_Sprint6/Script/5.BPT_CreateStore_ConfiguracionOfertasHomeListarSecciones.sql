

USE BelcorpPeru
GO

CREATE PROCEDURE [dbo].[ConfiguracionOfertasHomeListarSecciones]
	@CampaniaId int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT O.*, C.Codigo FROM ConfiguracionOfertasHome O
		inner join (
			SELECT MAX(CampaniaID) as CampaniaID, ConfiguracionPaisID 
			FROM ConfiguracionOfertasHome 
			WHERE CampaniaID <= @CampaniaId and isnull(CampaniaID, 0) > 0
			group by  ConfiguracionPaisID 
		) OC
		on O.CampaniaID = OC.CampaniaID and O.ConfiguracionPaisID = OC.ConfiguracionPaisID
		LEFT JOIN ConfiguracionPais C
			ON C.ConfiguracionPaisID = O.ConfiguracionPaisID
	where MobileActivo = 1 or DesktopActivo = 1
END
GO
/*end*/

USE BelcorpMexico
GO

CREATE PROCEDURE [dbo].[ConfiguracionOfertasHomeListarSecciones]
	@CampaniaId int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT O.*, C.Codigo FROM ConfiguracionOfertasHome O
		inner join (
			SELECT MAX(CampaniaID) as CampaniaID, ConfiguracionPaisID 
			FROM ConfiguracionOfertasHome 
			WHERE CampaniaID <= @CampaniaId and isnull(CampaniaID, 0) > 0
			group by  ConfiguracionPaisID 
		) OC
		on O.CampaniaID = OC.CampaniaID and O.ConfiguracionPaisID = OC.ConfiguracionPaisID
		LEFT JOIN ConfiguracionPais C
			ON C.ConfiguracionPaisID = O.ConfiguracionPaisID
	where MobileActivo = 1 or DesktopActivo = 1
END
GO
/*end*/

USE BelcorpColombia
GO

CREATE PROCEDURE [dbo].[ConfiguracionOfertasHomeListarSecciones]
	@CampaniaId int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT O.*, C.Codigo FROM ConfiguracionOfertasHome O
		inner join (
			SELECT MAX(CampaniaID) as CampaniaID, ConfiguracionPaisID 
			FROM ConfiguracionOfertasHome 
			WHERE CampaniaID <= @CampaniaId and isnull(CampaniaID, 0) > 0
			group by  ConfiguracionPaisID 
		) OC
		on O.CampaniaID = OC.CampaniaID and O.ConfiguracionPaisID = OC.ConfiguracionPaisID
		LEFT JOIN ConfiguracionPais C
			ON C.ConfiguracionPaisID = O.ConfiguracionPaisID
	where MobileActivo = 1 or DesktopActivo = 1
END
GO
/*end*/

USE BelcorpVenezuela
GO

CREATE PROCEDURE [dbo].[ConfiguracionOfertasHomeListarSecciones]
	@CampaniaId int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT O.*, C.Codigo FROM ConfiguracionOfertasHome O
		inner join (
			SELECT MAX(CampaniaID) as CampaniaID, ConfiguracionPaisID 
			FROM ConfiguracionOfertasHome 
			WHERE CampaniaID <= @CampaniaId and isnull(CampaniaID, 0) > 0
			group by  ConfiguracionPaisID 
		) OC
		on O.CampaniaID = OC.CampaniaID and O.ConfiguracionPaisID = OC.ConfiguracionPaisID
		LEFT JOIN ConfiguracionPais C
			ON C.ConfiguracionPaisID = O.ConfiguracionPaisID
	where MobileActivo = 1 or DesktopActivo = 1
END
GO
/*end*/

USE BelcorpSalvador
GO

CREATE PROCEDURE [dbo].[ConfiguracionOfertasHomeListarSecciones]
	@CampaniaId int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT O.*, C.Codigo FROM ConfiguracionOfertasHome O
		inner join (
			SELECT MAX(CampaniaID) as CampaniaID, ConfiguracionPaisID 
			FROM ConfiguracionOfertasHome 
			WHERE CampaniaID <= @CampaniaId and isnull(CampaniaID, 0) > 0
			group by  ConfiguracionPaisID 
		) OC
		on O.CampaniaID = OC.CampaniaID and O.ConfiguracionPaisID = OC.ConfiguracionPaisID
		LEFT JOIN ConfiguracionPais C
			ON C.ConfiguracionPaisID = O.ConfiguracionPaisID
	where MobileActivo = 1 or DesktopActivo = 1
END
GO
/*end*/

USE BelcorpPuertoRico
GO

CREATE PROCEDURE [dbo].[ConfiguracionOfertasHomeListarSecciones]
	@CampaniaId int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT O.*, C.Codigo FROM ConfiguracionOfertasHome O
		inner join (
			SELECT MAX(CampaniaID) as CampaniaID, ConfiguracionPaisID 
			FROM ConfiguracionOfertasHome 
			WHERE CampaniaID <= @CampaniaId and isnull(CampaniaID, 0) > 0
			group by  ConfiguracionPaisID 
		) OC
		on O.CampaniaID = OC.CampaniaID and O.ConfiguracionPaisID = OC.ConfiguracionPaisID
		LEFT JOIN ConfiguracionPais C
			ON C.ConfiguracionPaisID = O.ConfiguracionPaisID
	where MobileActivo = 1 or DesktopActivo = 1
END
GO
/*end*/

USE BelcorpPanama
GO

CREATE PROCEDURE [dbo].[ConfiguracionOfertasHomeListarSecciones]
	@CampaniaId int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT O.*, C.Codigo FROM ConfiguracionOfertasHome O
		inner join (
			SELECT MAX(CampaniaID) as CampaniaID, ConfiguracionPaisID 
			FROM ConfiguracionOfertasHome 
			WHERE CampaniaID <= @CampaniaId and isnull(CampaniaID, 0) > 0
			group by  ConfiguracionPaisID 
		) OC
		on O.CampaniaID = OC.CampaniaID and O.ConfiguracionPaisID = OC.ConfiguracionPaisID
		LEFT JOIN ConfiguracionPais C
			ON C.ConfiguracionPaisID = O.ConfiguracionPaisID
	where MobileActivo = 1 or DesktopActivo = 1
END
GO
/*end*/

USE BelcorpGuatemala
GO

CREATE PROCEDURE [dbo].[ConfiguracionOfertasHomeListarSecciones]
	@CampaniaId int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT O.*, C.Codigo FROM ConfiguracionOfertasHome O
		inner join (
			SELECT MAX(CampaniaID) as CampaniaID, ConfiguracionPaisID 
			FROM ConfiguracionOfertasHome 
			WHERE CampaniaID <= @CampaniaId and isnull(CampaniaID, 0) > 0
			group by  ConfiguracionPaisID 
		) OC
		on O.CampaniaID = OC.CampaniaID and O.ConfiguracionPaisID = OC.ConfiguracionPaisID
		LEFT JOIN ConfiguracionPais C
			ON C.ConfiguracionPaisID = O.ConfiguracionPaisID
	where MobileActivo = 1 or DesktopActivo = 1
END
GO
/*end*/

USE BelcorpEcuador
GO

CREATE PROCEDURE [dbo].[ConfiguracionOfertasHomeListarSecciones]
	@CampaniaId int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT O.*, C.Codigo FROM ConfiguracionOfertasHome O
		inner join (
			SELECT MAX(CampaniaID) as CampaniaID, ConfiguracionPaisID 
			FROM ConfiguracionOfertasHome 
			WHERE CampaniaID <= @CampaniaId and isnull(CampaniaID, 0) > 0
			group by  ConfiguracionPaisID 
		) OC
		on O.CampaniaID = OC.CampaniaID and O.ConfiguracionPaisID = OC.ConfiguracionPaisID
		LEFT JOIN ConfiguracionPais C
			ON C.ConfiguracionPaisID = O.ConfiguracionPaisID
	where MobileActivo = 1 or DesktopActivo = 1
END
GO
/*end*/

USE BelcorpDominicana
GO

CREATE PROCEDURE [dbo].[ConfiguracionOfertasHomeListarSecciones]
	@CampaniaId int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT O.*, C.Codigo FROM ConfiguracionOfertasHome O
		inner join (
			SELECT MAX(CampaniaID) as CampaniaID, ConfiguracionPaisID 
			FROM ConfiguracionOfertasHome 
			WHERE CampaniaID <= @CampaniaId and isnull(CampaniaID, 0) > 0
			group by  ConfiguracionPaisID 
		) OC
		on O.CampaniaID = OC.CampaniaID and O.ConfiguracionPaisID = OC.ConfiguracionPaisID
		LEFT JOIN ConfiguracionPais C
			ON C.ConfiguracionPaisID = O.ConfiguracionPaisID
	where MobileActivo = 1 or DesktopActivo = 1
END
GO
/*end*/

USE BelcorpCostaRica
GO

CREATE PROCEDURE [dbo].[ConfiguracionOfertasHomeListarSecciones]
	@CampaniaId int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT O.*, C.Codigo FROM ConfiguracionOfertasHome O
		inner join (
			SELECT MAX(CampaniaID) as CampaniaID, ConfiguracionPaisID 
			FROM ConfiguracionOfertasHome 
			WHERE CampaniaID <= @CampaniaId and isnull(CampaniaID, 0) > 0
			group by  ConfiguracionPaisID 
		) OC
		on O.CampaniaID = OC.CampaniaID and O.ConfiguracionPaisID = OC.ConfiguracionPaisID
		LEFT JOIN ConfiguracionPais C
			ON C.ConfiguracionPaisID = O.ConfiguracionPaisID
	where MobileActivo = 1 or DesktopActivo = 1
END
GO
/*end*/

USE BelcorpChile
GO

CREATE PROCEDURE [dbo].[ConfiguracionOfertasHomeListarSecciones]
	@CampaniaId int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT O.*, C.Codigo FROM ConfiguracionOfertasHome O
		inner join (
			SELECT MAX(CampaniaID) as CampaniaID, ConfiguracionPaisID 
			FROM ConfiguracionOfertasHome 
			WHERE CampaniaID <= @CampaniaId and isnull(CampaniaID, 0) > 0
			group by  ConfiguracionPaisID 
		) OC
		on O.CampaniaID = OC.CampaniaID and O.ConfiguracionPaisID = OC.ConfiguracionPaisID
		LEFT JOIN ConfiguracionPais C
			ON C.ConfiguracionPaisID = O.ConfiguracionPaisID
	where MobileActivo = 1 or DesktopActivo = 1
END
GO
/*end*/

USE BelcorpBolivia
GO

CREATE PROCEDURE [dbo].[ConfiguracionOfertasHomeListarSecciones]
	@CampaniaId int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT O.*, C.Codigo FROM ConfiguracionOfertasHome O
		inner join (
			SELECT MAX(CampaniaID) as CampaniaID, ConfiguracionPaisID 
			FROM ConfiguracionOfertasHome 
			WHERE CampaniaID <= @CampaniaId and isnull(CampaniaID, 0) > 0
			group by  ConfiguracionPaisID 
		) OC
		on O.CampaniaID = OC.CampaniaID and O.ConfiguracionPaisID = OC.ConfiguracionPaisID
		LEFT JOIN ConfiguracionPais C
			ON C.ConfiguracionPaisID = O.ConfiguracionPaisID
	where MobileActivo = 1 or DesktopActivo = 1
END
GO