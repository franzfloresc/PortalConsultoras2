USE BelcorpPeru
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'P' and id = OBJECT_ID('dbo.GetIncentivosMontoExigencia'))
	DROP PROC dbo.GetIncentivosMontoExigencia
GO
CREATE PROC GetIncentivosMontoExigencia
(
@CodigoCampania varchar(8),
@CodigoRegion varchar(8),
@CodigoZona varchar(8)
)
AS
BEGIN 
	Select 
		MontoID, 
		isnull(CodigoCampania, '') as CodigoCampania, 
		isnull(CodigoRegion, '') as CodigoRegion, 
		isnull(CodigoZona, '') as CodigoZona, 
		Monto, 
		AlcansoIncentivo
	from IncentivosMontoExigencia
	where (isnull(CodigoCampania, '') = @CodigoCampania or @CodigoCampania = '')
	and (isnull(CodigoRegion, '') = @CodigoRegion or @CodigoRegion = '')
	and (isnull(CodigoZona, '') = @CodigoZona or @CodigoZona = '')
END
GO

USE BelcorpMexico
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'P' and id = OBJECT_ID('dbo.GetIncentivosMontoExigencia'))
	DROP PROC dbo.GetIncentivosMontoExigencia
GO
CREATE PROC GetIncentivosMontoExigencia
(
@CodigoCampania varchar(8),
@CodigoRegion varchar(8),
@CodigoZona varchar(8)
)
AS
BEGIN 
	Select 
		MontoID, 
		isnull(CodigoCampania, '') as CodigoCampania, 
		isnull(CodigoRegion, '') as CodigoRegion, 
		isnull(CodigoZona, '') as CodigoZona, 
		Monto, 
		AlcansoIncentivo
	from IncentivosMontoExigencia
	where (isnull(CodigoCampania, '') = @CodigoCampania or @CodigoCampania = '')
	and (isnull(CodigoRegion, '') = @CodigoRegion or @CodigoRegion = '')
	and (isnull(CodigoZona, '') = @CodigoZona or @CodigoZona = '')
END
GO

USE BelcorpColombia
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'P' and id = OBJECT_ID('dbo.GetIncentivosMontoExigencia'))
	DROP PROC dbo.GetIncentivosMontoExigencia
GO
CREATE PROC GetIncentivosMontoExigencia
(
@CodigoCampania varchar(8),
@CodigoRegion varchar(8),
@CodigoZona varchar(8)
)
AS
BEGIN 
	Select 
		MontoID, 
		isnull(CodigoCampania, '') as CodigoCampania, 
		isnull(CodigoRegion, '') as CodigoRegion, 
		isnull(CodigoZona, '') as CodigoZona, 
		Monto, 
		AlcansoIncentivo
	from IncentivosMontoExigencia
	where (isnull(CodigoCampania, '') = @CodigoCampania or @CodigoCampania = '')
	and (isnull(CodigoRegion, '') = @CodigoRegion or @CodigoRegion = '')
	and (isnull(CodigoZona, '') = @CodigoZona or @CodigoZona = '')
END
GO

USE BelcorpSalvador
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'P' and id = OBJECT_ID('dbo.GetIncentivosMontoExigencia'))
	DROP PROC dbo.GetIncentivosMontoExigencia
GO
CREATE PROC GetIncentivosMontoExigencia
(
@CodigoCampania varchar(8),
@CodigoRegion varchar(8),
@CodigoZona varchar(8)
)
AS
BEGIN 
	Select 
		MontoID, 
		isnull(CodigoCampania, '') as CodigoCampania, 
		isnull(CodigoRegion, '') as CodigoRegion, 
		isnull(CodigoZona, '') as CodigoZona, 
		Monto, 
		AlcansoIncentivo
	from IncentivosMontoExigencia
	where (isnull(CodigoCampania, '') = @CodigoCampania or @CodigoCampania = '')
	and (isnull(CodigoRegion, '') = @CodigoRegion or @CodigoRegion = '')
	and (isnull(CodigoZona, '') = @CodigoZona or @CodigoZona = '')
END
GO

USE BelcorpPuertoRico
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'P' and id = OBJECT_ID('dbo.GetIncentivosMontoExigencia'))
	DROP PROC dbo.GetIncentivosMontoExigencia
GO
CREATE PROC GetIncentivosMontoExigencia
(
@CodigoCampania varchar(8),
@CodigoRegion varchar(8),
@CodigoZona varchar(8)
)
AS
BEGIN 
	Select 
		MontoID, 
		isnull(CodigoCampania, '') as CodigoCampania, 
		isnull(CodigoRegion, '') as CodigoRegion, 
		isnull(CodigoZona, '') as CodigoZona, 
		Monto, 
		AlcansoIncentivo
	from IncentivosMontoExigencia
	where (isnull(CodigoCampania, '') = @CodigoCampania or @CodigoCampania = '')
	and (isnull(CodigoRegion, '') = @CodigoRegion or @CodigoRegion = '')
	and (isnull(CodigoZona, '') = @CodigoZona or @CodigoZona = '')
END
GO

USE BelcorpPanama
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'P' and id = OBJECT_ID('dbo.GetIncentivosMontoExigencia'))
	DROP PROC dbo.GetIncentivosMontoExigencia
GO
CREATE PROC GetIncentivosMontoExigencia
(
@CodigoCampania varchar(8),
@CodigoRegion varchar(8),
@CodigoZona varchar(8)
)
AS
BEGIN 
	Select 
		MontoID, 
		isnull(CodigoCampania, '') as CodigoCampania, 
		isnull(CodigoRegion, '') as CodigoRegion, 
		isnull(CodigoZona, '') as CodigoZona, 
		Monto, 
		AlcansoIncentivo
	from IncentivosMontoExigencia
	where (isnull(CodigoCampania, '') = @CodigoCampania or @CodigoCampania = '')
	and (isnull(CodigoRegion, '') = @CodigoRegion or @CodigoRegion = '')
	and (isnull(CodigoZona, '') = @CodigoZona or @CodigoZona = '')
END
GO

USE BelcorpGuatemala
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'P' and id = OBJECT_ID('dbo.GetIncentivosMontoExigencia'))
	DROP PROC dbo.GetIncentivosMontoExigencia
GO
CREATE PROC GetIncentivosMontoExigencia
(
@CodigoCampania varchar(8),
@CodigoRegion varchar(8),
@CodigoZona varchar(8)
)
AS
BEGIN 
	Select 
		MontoID, 
		isnull(CodigoCampania, '') as CodigoCampania, 
		isnull(CodigoRegion, '') as CodigoRegion, 
		isnull(CodigoZona, '') as CodigoZona, 
		Monto, 
		AlcansoIncentivo
	from IncentivosMontoExigencia
	where (isnull(CodigoCampania, '') = @CodigoCampania or @CodigoCampania = '')
	and (isnull(CodigoRegion, '') = @CodigoRegion or @CodigoRegion = '')
	and (isnull(CodigoZona, '') = @CodigoZona or @CodigoZona = '')
END
GO

USE BelcorpEcuador
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'P' and id = OBJECT_ID('dbo.GetIncentivosMontoExigencia'))
	DROP PROC dbo.GetIncentivosMontoExigencia
GO
CREATE PROC GetIncentivosMontoExigencia
(
@CodigoCampania varchar(8),
@CodigoRegion varchar(8),
@CodigoZona varchar(8)
)
AS
BEGIN 
	Select 
		MontoID, 
		isnull(CodigoCampania, '') as CodigoCampania, 
		isnull(CodigoRegion, '') as CodigoRegion, 
		isnull(CodigoZona, '') as CodigoZona, 
		Monto, 
		AlcansoIncentivo
	from IncentivosMontoExigencia
	where (isnull(CodigoCampania, '') = @CodigoCampania or @CodigoCampania = '')
	and (isnull(CodigoRegion, '') = @CodigoRegion or @CodigoRegion = '')
	and (isnull(CodigoZona, '') = @CodigoZona or @CodigoZona = '')
END
GO

USE BelcorpDominicana
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'P' and id = OBJECT_ID('dbo.GetIncentivosMontoExigencia'))
	DROP PROC dbo.GetIncentivosMontoExigencia
GO
CREATE PROC GetIncentivosMontoExigencia
(
@CodigoCampania varchar(8),
@CodigoRegion varchar(8),
@CodigoZona varchar(8)
)
AS
BEGIN 
	Select 
		MontoID, 
		isnull(CodigoCampania, '') as CodigoCampania, 
		isnull(CodigoRegion, '') as CodigoRegion, 
		isnull(CodigoZona, '') as CodigoZona, 
		Monto, 
		AlcansoIncentivo
	from IncentivosMontoExigencia
	where (isnull(CodigoCampania, '') = @CodigoCampania or @CodigoCampania = '')
	and (isnull(CodigoRegion, '') = @CodigoRegion or @CodigoRegion = '')
	and (isnull(CodigoZona, '') = @CodigoZona or @CodigoZona = '')
END
GO

USE BelcorpCostaRica
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'P' and id = OBJECT_ID('dbo.GetIncentivosMontoExigencia'))
	DROP PROC dbo.GetIncentivosMontoExigencia
GO
CREATE PROC GetIncentivosMontoExigencia
(
@CodigoCampania varchar(8),
@CodigoRegion varchar(8),
@CodigoZona varchar(8)
)
AS
BEGIN 
	Select 
		MontoID, 
		isnull(CodigoCampania, '') as CodigoCampania, 
		isnull(CodigoRegion, '') as CodigoRegion, 
		isnull(CodigoZona, '') as CodigoZona, 
		Monto, 
		AlcansoIncentivo
	from IncentivosMontoExigencia
	where (isnull(CodigoCampania, '') = @CodigoCampania or @CodigoCampania = '')
	and (isnull(CodigoRegion, '') = @CodigoRegion or @CodigoRegion = '')
	and (isnull(CodigoZona, '') = @CodigoZona or @CodigoZona = '')
END
GO

USE BelcorpChile
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'P' and id = OBJECT_ID('dbo.GetIncentivosMontoExigencia'))
	DROP PROC dbo.GetIncentivosMontoExigencia
GO
CREATE PROC GetIncentivosMontoExigencia
(
@CodigoCampania varchar(8),
@CodigoRegion varchar(8),
@CodigoZona varchar(8)
)
AS
BEGIN 
	Select 
		MontoID, 
		isnull(CodigoCampania, '') as CodigoCampania, 
		isnull(CodigoRegion, '') as CodigoRegion, 
		isnull(CodigoZona, '') as CodigoZona, 
		Monto, 
		AlcansoIncentivo
	from IncentivosMontoExigencia
	where (isnull(CodigoCampania, '') = @CodigoCampania or @CodigoCampania = '')
	and (isnull(CodigoRegion, '') = @CodigoRegion or @CodigoRegion = '')
	and (isnull(CodigoZona, '') = @CodigoZona or @CodigoZona = '')
END
GO

USE BelcorpBolivia
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'P' and id = OBJECT_ID('dbo.GetIncentivosMontoExigencia'))
	DROP PROC dbo.GetIncentivosMontoExigencia
GO
CREATE PROC GetIncentivosMontoExigencia
(
@CodigoCampania varchar(8),
@CodigoRegion varchar(8),
@CodigoZona varchar(8)
)
AS
BEGIN 
	Select 
		MontoID, 
		isnull(CodigoCampania, '') as CodigoCampania, 
		isnull(CodigoRegion, '') as CodigoRegion, 
		isnull(CodigoZona, '') as CodigoZona, 
		Monto, 
		AlcansoIncentivo
	from IncentivosMontoExigencia
	where (isnull(CodigoCampania, '') = @CodigoCampania or @CodigoCampania = '')
	and (isnull(CodigoRegion, '') = @CodigoRegion or @CodigoRegion = '')
	and (isnull(CodigoZona, '') = @CodigoZona or @CodigoZona = '')
END
GO

