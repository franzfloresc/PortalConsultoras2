USE BelcorpPeru
GO

IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'GetCodigoSMS')
BEGIN
	DROP PROC GetCodigoSMS
END
GO
CREATE PROC GetCodigoSMS 
(
@CodigoConsultora varchar(20),
@Origen varchar(30)
)
AS
BEGIN 
	SELECT top 1
		CodigoGenerado AS CodigoSms
	FROM [dbo].[CodigoSMS]
	WHERE [CodigoConsultora] = @CodigoConsultora
	and [Origen] = @Origen
END
GO

USE BelcorpMexico
GO

IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'GetCodigoSMS')
BEGIN
	DROP PROC GetCodigoSMS
END
GO
CREATE PROC GetCodigoSMS 
(
@CodigoConsultora varchar(20),
@Origen varchar(30)
)
AS
BEGIN 
	SELECT top 1
		CodigoGenerado AS CodigoSms
	FROM [dbo].[CodigoSMS]
	WHERE [CodigoConsultora] = @CodigoConsultora
	and [Origen] = @Origen
END
GO

USE BelcorpColombia
GO

IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'GetCodigoSMS')
BEGIN
	DROP PROC GetCodigoSMS
END
GO
CREATE PROC GetCodigoSMS 
(
@CodigoConsultora varchar(20),
@Origen varchar(30)
)
AS
BEGIN 
	SELECT top 1
		CodigoGenerado AS CodigoSms
	FROM [dbo].[CodigoSMS]
	WHERE [CodigoConsultora] = @CodigoConsultora
	and [Origen] = @Origen
END
GO

USE BelcorpVenezuela
GO

IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'GetCodigoSMS')
BEGIN
	DROP PROC GetCodigoSMS
END
GO
CREATE PROC GetCodigoSMS 
(
@CodigoConsultora varchar(20),
@Origen varchar(30)
)
AS
BEGIN 
	SELECT top 1
		CodigoGenerado AS CodigoSms
	FROM [dbo].[CodigoSMS]
	WHERE [CodigoConsultora] = @CodigoConsultora
	and [Origen] = @Origen
END
GO

USE BelcorpSalvador
GO

IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'GetCodigoSMS')
BEGIN
	DROP PROC GetCodigoSMS
END
GO
CREATE PROC GetCodigoSMS 
(
@CodigoConsultora varchar(20),
@Origen varchar(30)
)
AS
BEGIN 
	SELECT top 1
		CodigoGenerado AS CodigoSms
	FROM [dbo].[CodigoSMS]
	WHERE [CodigoConsultora] = @CodigoConsultora
	and [Origen] = @Origen
END
GO

USE BelcorpPuertoRico
GO

IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'GetCodigoSMS')
BEGIN
	DROP PROC GetCodigoSMS
END
GO
CREATE PROC GetCodigoSMS 
(
@CodigoConsultora varchar(20),
@Origen varchar(30)
)
AS
BEGIN 
	SELECT top 1
		CodigoGenerado AS CodigoSms
	FROM [dbo].[CodigoSMS]
	WHERE [CodigoConsultora] = @CodigoConsultora
	and [Origen] = @Origen
END
GO

USE BelcorpPanama
GO

IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'GetCodigoSMS')
BEGIN
	DROP PROC GetCodigoSMS
END
GO
CREATE PROC GetCodigoSMS 
(
@CodigoConsultora varchar(20),
@Origen varchar(30)
)
AS
BEGIN 
	SELECT top 1
		CodigoGenerado AS CodigoSms
	FROM [dbo].[CodigoSMS]
	WHERE [CodigoConsultora] = @CodigoConsultora
	and [Origen] = @Origen
END
GO

USE BelcorpGuatemala
GO

IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'GetCodigoSMS')
BEGIN
	DROP PROC GetCodigoSMS
END
GO
CREATE PROC GetCodigoSMS 
(
@CodigoConsultora varchar(20),
@Origen varchar(30)
)
AS
BEGIN 
	SELECT top 1
		CodigoGenerado AS CodigoSms
	FROM [dbo].[CodigoSMS]
	WHERE [CodigoConsultora] = @CodigoConsultora
	and [Origen] = @Origen
END
GO

USE BelcorpEcuador
GO

IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'GetCodigoSMS')
BEGIN
	DROP PROC GetCodigoSMS
END
GO
CREATE PROC GetCodigoSMS 
(
@CodigoConsultora varchar(20),
@Origen varchar(30)
)
AS
BEGIN 
	SELECT top 1
		CodigoGenerado AS CodigoSms
	FROM [dbo].[CodigoSMS]
	WHERE [CodigoConsultora] = @CodigoConsultora
	and [Origen] = @Origen
END
GO

USE BelcorpDominicana
GO

IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'GetCodigoSMS')
BEGIN
	DROP PROC GetCodigoSMS
END
GO
CREATE PROC GetCodigoSMS 
(
@CodigoConsultora varchar(20),
@Origen varchar(30)
)
AS
BEGIN 
	SELECT top 1
		CodigoGenerado AS CodigoSms
	FROM [dbo].[CodigoSMS]
	WHERE [CodigoConsultora] = @CodigoConsultora
	and [Origen] = @Origen
END
GO

USE BelcorpCostaRica
GO

IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'GetCodigoSMS')
BEGIN
	DROP PROC GetCodigoSMS
END
GO
CREATE PROC GetCodigoSMS 
(
@CodigoConsultora varchar(20),
@Origen varchar(30)
)
AS
BEGIN 
	SELECT top 1
		CodigoGenerado AS CodigoSms
	FROM [dbo].[CodigoSMS]
	WHERE [CodigoConsultora] = @CodigoConsultora
	and [Origen] = @Origen
END
GO

USE BelcorpChile
GO

IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'GetCodigoSMS')
BEGIN
	DROP PROC GetCodigoSMS
END
GO
CREATE PROC GetCodigoSMS 
(
@CodigoConsultora varchar(20),
@Origen varchar(30)
)
AS
BEGIN 
	SELECT top 1
		CodigoGenerado AS CodigoSms
	FROM [dbo].[CodigoSMS]
	WHERE [CodigoConsultora] = @CodigoConsultora
	and [Origen] = @Origen
END
GO

USE BelcorpBolivia
GO

IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'GetCodigoSMS')
BEGIN
	DROP PROC GetCodigoSMS
END
GO
CREATE PROC GetCodigoSMS 
(
@CodigoConsultora varchar(20),
@Origen varchar(30)
)
AS
BEGIN 
	SELECT top 1
		CodigoGenerado AS CodigoSms
	FROM [dbo].[CodigoSMS]
	WHERE [CodigoConsultora] = @CodigoConsultora
	and [Origen] = @Origen
END
GO

