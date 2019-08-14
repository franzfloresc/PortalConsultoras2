GO
USE BelcorpPeru
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListZonasUnete]')
		   AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[ListZonasUnete]
GO

CREATE PROC ListZonasUnete
AS
BEGIN
	select Nombre from [Unete].[ParametroUnete] where FK_IdTipoParametro =
	(select IdTipoParametroUnete from unete.TipoParametroUnete where Descripcion ='CA3754')
	and estado=1
END


GO
USE BelcorpMexico
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListZonasUnete]')
		   AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[ListZonasUnete]
GO

CREATE PROC ListZonasUnete
AS
BEGIN
	select Nombre from [Unete].[ParametroUnete] where FK_IdTipoParametro =
	(select IdTipoParametroUnete from unete.TipoParametroUnete where Descripcion ='CA3754')
	and estado=1
END


GO
USE BelcorpColombia
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListZonasUnete]')
		   AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[ListZonasUnete]
GO

CREATE PROC ListZonasUnete
AS
BEGIN
	select Nombre from [Unete].[ParametroUnete] where FK_IdTipoParametro =
	(select IdTipoParametroUnete from unete.TipoParametroUnete where Descripcion ='CA3754')
	and estado=1
END


GO
USE BelcorpSalvador
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListZonasUnete]')
		   AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[ListZonasUnete]
GO

CREATE PROC ListZonasUnete
AS
BEGIN
	select Nombre from [Unete].[ParametroUnete] where FK_IdTipoParametro =
	(select IdTipoParametroUnete from unete.TipoParametroUnete where Descripcion ='CA3754')
	and estado=1
END


GO
USE BelcorpPuertoRico
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListZonasUnete]')
		   AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[ListZonasUnete]
GO

CREATE PROC ListZonasUnete
AS
BEGIN
	select Nombre from [Unete].[ParametroUnete] where FK_IdTipoParametro =
	(select IdTipoParametroUnete from unete.TipoParametroUnete where Descripcion ='CA3754')
	and estado=1
END


GO
USE BelcorpPanama
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListZonasUnete]')
		   AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[ListZonasUnete]
GO

CREATE PROC ListZonasUnete
AS
BEGIN
	select Nombre from [Unete].[ParametroUnete] where FK_IdTipoParametro =
	(select IdTipoParametroUnete from unete.TipoParametroUnete where Descripcion ='CA3754')
	and estado=1
END


GO
USE BelcorpGuatemala
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListZonasUnete]')
		   AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[ListZonasUnete]
GO

CREATE PROC ListZonasUnete
AS
BEGIN
	select Nombre from [Unete].[ParametroUnete] where FK_IdTipoParametro =
	(select IdTipoParametroUnete from unete.TipoParametroUnete where Descripcion ='CA3754')
	and estado=1
END


GO
USE BelcorpEcuador
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListZonasUnete]')
		   AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[ListZonasUnete]
GO

CREATE PROC ListZonasUnete
AS
BEGIN
	select Nombre from [Unete].[ParametroUnete] where FK_IdTipoParametro =
	(select IdTipoParametroUnete from unete.TipoParametroUnete where Descripcion ='CA3754')
	and estado=1
END


GO
USE BelcorpDominicana
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListZonasUnete]')
		   AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[ListZonasUnete]
GO

CREATE PROC ListZonasUnete
AS
BEGIN
	select Nombre from [Unete].[ParametroUnete] where FK_IdTipoParametro =
	(select IdTipoParametroUnete from unete.TipoParametroUnete where Descripcion ='CA3754')
	and estado=1
END


GO
USE BelcorpCostaRica
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListZonasUnete]')
		   AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[ListZonasUnete]
GO

CREATE PROC ListZonasUnete
AS
BEGIN
	select Nombre from [Unete].[ParametroUnete] where FK_IdTipoParametro =
	(select IdTipoParametroUnete from unete.TipoParametroUnete where Descripcion ='CA3754')
	and estado=1
END


GO
USE BelcorpChile
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListZonasUnete]')
		   AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[ListZonasUnete]
GO

CREATE PROC ListZonasUnete
AS
BEGIN
	select Nombre from [Unete].[ParametroUnete] where FK_IdTipoParametro =
	(select IdTipoParametroUnete from unete.TipoParametroUnete where Descripcion ='CA3754')
	and estado=1
END


GO
USE BelcorpBolivia
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListZonasUnete]')
		   AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[ListZonasUnete]
GO

CREATE PROC ListZonasUnete
AS
BEGIN
	select Nombre from [Unete].[ParametroUnete] where FK_IdTipoParametro =
	(select IdTipoParametroUnete from unete.TipoParametroUnete where Descripcion ='CA3754')
	and estado=1
END


GO
