GO
USE BelcorpPeru
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetMenuMobile_SB2]')
		   AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[GetMenuMobile_SB2]
GO


CREATE PROCEDURE [dbo].[GetMenuMobile_SB2]
AS
BEGIN
SET NOCOUNT ON;
	SELECT
		MenuMobileID
		,Descripcion
		,MenuPadreID
		,OrdenItem
		,UrlItem
		,UrlImagen
		,PaginaNueva
		,Posicion
		,[Version]
		,EsSB2
		,Codigo
	FROM dbo.MenuMobile
	WHERE EsSB2=1
	order by Posicion, MenuPadreID, ordenItem
END


GO
USE BelcorpMexico
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetMenuMobile_SB2]')
		   AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[GetMenuMobile_SB2]
GO


CREATE PROCEDURE [dbo].[GetMenuMobile_SB2]
AS
BEGIN
SET NOCOUNT ON;
	SELECT
		MenuMobileID
		,Descripcion
		,MenuPadreID
		,OrdenItem
		,UrlItem
		,UrlImagen
		,PaginaNueva
		,Posicion
		,[Version]
		,EsSB2
		,Codigo
	FROM dbo.MenuMobile
	WHERE EsSB2=1
	order by Posicion, MenuPadreID, ordenItem
END


GO
USE BelcorpColombia
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetMenuMobile_SB2]')
		   AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[GetMenuMobile_SB2]
GO


CREATE PROCEDURE [dbo].[GetMenuMobile_SB2]
AS
BEGIN
SET NOCOUNT ON;
	SELECT
		MenuMobileID
		,Descripcion
		,MenuPadreID
		,OrdenItem
		,UrlItem
		,UrlImagen
		,PaginaNueva
		,Posicion
		,[Version]
		,EsSB2
		,Codigo
	FROM dbo.MenuMobile
	WHERE EsSB2=1
	order by Posicion, MenuPadreID, ordenItem
END


GO
USE BelcorpSalvador
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetMenuMobile_SB2]')
		   AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[GetMenuMobile_SB2]
GO


CREATE PROCEDURE [dbo].[GetMenuMobile_SB2]
AS
BEGIN
SET NOCOUNT ON;
	SELECT
		MenuMobileID
		,Descripcion
		,MenuPadreID
		,OrdenItem
		,UrlItem
		,UrlImagen
		,PaginaNueva
		,Posicion
		,[Version]
		,EsSB2
		,Codigo
	FROM dbo.MenuMobile
	WHERE EsSB2=1
	order by Posicion, MenuPadreID, ordenItem
END


GO
USE BelcorpPuertoRico
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetMenuMobile_SB2]')
		   AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[GetMenuMobile_SB2]
GO


CREATE PROCEDURE [dbo].[GetMenuMobile_SB2]
AS
BEGIN
SET NOCOUNT ON;
	SELECT
		MenuMobileID
		,Descripcion
		,MenuPadreID
		,OrdenItem
		,UrlItem
		,UrlImagen
		,PaginaNueva
		,Posicion
		,[Version]
		,EsSB2
		,Codigo
	FROM dbo.MenuMobile
	WHERE EsSB2=1
	order by Posicion, MenuPadreID, ordenItem
END


GO
USE BelcorpPanama
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetMenuMobile_SB2]')
		   AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[GetMenuMobile_SB2]
GO


CREATE PROCEDURE [dbo].[GetMenuMobile_SB2]
AS
BEGIN
SET NOCOUNT ON;
	SELECT
		MenuMobileID
		,Descripcion
		,MenuPadreID
		,OrdenItem
		,UrlItem
		,UrlImagen
		,PaginaNueva
		,Posicion
		,[Version]
		,EsSB2
		,Codigo
	FROM dbo.MenuMobile
	WHERE EsSB2=1
	order by Posicion, MenuPadreID, ordenItem
END


GO
USE BelcorpGuatemala
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetMenuMobile_SB2]')
		   AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[GetMenuMobile_SB2]
GO


CREATE PROCEDURE [dbo].[GetMenuMobile_SB2]
AS
BEGIN
SET NOCOUNT ON;
	SELECT
		MenuMobileID
		,Descripcion
		,MenuPadreID
		,OrdenItem
		,UrlItem
		,UrlImagen
		,PaginaNueva
		,Posicion
		,[Version]
		,EsSB2
		,Codigo
	FROM dbo.MenuMobile
	WHERE EsSB2=1
	order by Posicion, MenuPadreID, ordenItem
END


GO
USE BelcorpEcuador
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetMenuMobile_SB2]')
		   AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[GetMenuMobile_SB2]
GO


CREATE PROCEDURE [dbo].[GetMenuMobile_SB2]
AS
BEGIN
SET NOCOUNT ON;
	SELECT
		MenuMobileID
		,Descripcion
		,MenuPadreID
		,OrdenItem
		,UrlItem
		,UrlImagen
		,PaginaNueva
		,Posicion
		,[Version]
		,EsSB2
		,Codigo
	FROM dbo.MenuMobile
	WHERE EsSB2=1
	order by Posicion, MenuPadreID, ordenItem
END


GO
USE BelcorpDominicana
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetMenuMobile_SB2]')
		   AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[GetMenuMobile_SB2]
GO


CREATE PROCEDURE [dbo].[GetMenuMobile_SB2]
AS
BEGIN
SET NOCOUNT ON;
	SELECT
		MenuMobileID
		,Descripcion
		,MenuPadreID
		,OrdenItem
		,UrlItem
		,UrlImagen
		,PaginaNueva
		,Posicion
		,[Version]
		,EsSB2
		,Codigo
	FROM dbo.MenuMobile
	WHERE EsSB2=1
	order by Posicion, MenuPadreID, ordenItem
END


GO
USE BelcorpCostaRica
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetMenuMobile_SB2]')
		   AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[GetMenuMobile_SB2]
GO


CREATE PROCEDURE [dbo].[GetMenuMobile_SB2]
AS
BEGIN
SET NOCOUNT ON;
	SELECT
		MenuMobileID
		,Descripcion
		,MenuPadreID
		,OrdenItem
		,UrlItem
		,UrlImagen
		,PaginaNueva
		,Posicion
		,[Version]
		,EsSB2
		,Codigo
	FROM dbo.MenuMobile
	WHERE EsSB2=1
	order by Posicion, MenuPadreID, ordenItem
END


GO
USE BelcorpChile
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetMenuMobile_SB2]')
		   AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[GetMenuMobile_SB2]
GO


CREATE PROCEDURE [dbo].[GetMenuMobile_SB2]
AS
BEGIN
SET NOCOUNT ON;
	SELECT
		MenuMobileID
		,Descripcion
		,MenuPadreID
		,OrdenItem
		,UrlItem
		,UrlImagen
		,PaginaNueva
		,Posicion
		,[Version]
		,EsSB2
		,Codigo
	FROM dbo.MenuMobile
	WHERE EsSB2=1
	order by Posicion, MenuPadreID, ordenItem
END


GO
USE BelcorpBolivia
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetMenuMobile_SB2]')
		   AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[GetMenuMobile_SB2]
GO


CREATE PROCEDURE [dbo].[GetMenuMobile_SB2]
AS
BEGIN
SET NOCOUNT ON;
	SELECT
		MenuMobileID
		,Descripcion
		,MenuPadreID
		,OrdenItem
		,UrlItem
		,UrlImagen
		,PaginaNueva
		,Posicion
		,[Version]
		,EsSB2
		,Codigo
	FROM dbo.MenuMobile
	WHERE EsSB2=1
	order by Posicion, MenuPadreID, ordenItem
END


GO
