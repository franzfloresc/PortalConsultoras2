


USE BelcorpPeru
GO

CREATE FUNCTION [dbo].[CaclSaldoHorasSolicitudPedido]
(
	@CreateAt DATETIME   
)
RETURNS VARCHAR(30)
AS
BEGIN
	
	DECLARE @StartDate DATETIME, @EndDate DATETIME

	--SET @createAt = '2016-10-05 12:01:44'
	--SET @StartDate = '2016-10-04 21:30:20'
	--SET @EndDate='2016-10-05 21:25:10'
	SET @StartDate = GETDATE()
	SET @EndDate = DATEADD(DAY,1,@createAt)
	
	--SELECT CONVERT(VARCHAR(5),DATEDIFF(s, @startDate, @EndDate)/3600) + ':' + 
	--	CONVERT(VARCHAR(5),DATEDIFF(s, @startDate, @EndDate)%3600/60) + ':' + 
	--	CONVERT(VARCHAR(5),(DATEDIFF(s, @startDate, @EndDate)%60)) AS [hh:mm:ss]

	RETURN CAST((@EndDate-@StartDate) AS TIME(0))-- AS '[hh:mm:ss]'
END

/*end*/

USE BelcorpColombia
GO

CREATE FUNCTION [dbo].[CaclSaldoHorasSolicitudPedido]
(
	@CreateAt DATETIME   
)
RETURNS VARCHAR(30)
AS
BEGIN
	
	DECLARE @StartDate DATETIME, @EndDate DATETIME

	--SET @createAt = '2016-10-05 12:01:44'
	--SET @StartDate = '2016-10-04 21:30:20'
	--SET @EndDate='2016-10-05 21:25:10'
	SET @StartDate = GETDATE()
	SET @EndDate = DATEADD(DAY,1,@createAt)
	
	--SELECT CONVERT(VARCHAR(5),DATEDIFF(s, @startDate, @EndDate)/3600) + ':' + 
	--	CONVERT(VARCHAR(5),DATEDIFF(s, @startDate, @EndDate)%3600/60) + ':' + 
	--	CONVERT(VARCHAR(5),(DATEDIFF(s, @startDate, @EndDate)%60)) AS [hh:mm:ss]

	RETURN CAST((@EndDate-@StartDate) AS TIME(0))-- AS '[hh:mm:ss]'
END

/*end*/

USE BelcorpChile
GO

CREATE FUNCTION [dbo].[CaclSaldoHorasSolicitudPedido]
(
	@CreateAt DATETIME   
)
RETURNS VARCHAR(30)
AS
BEGIN
	
	DECLARE @StartDate DATETIME, @EndDate DATETIME

	--SET @createAt = '2016-10-05 12:01:44'
	--SET @StartDate = '2016-10-04 21:30:20'
	--SET @EndDate='2016-10-05 21:25:10'
	SET @StartDate = GETDATE()
	SET @EndDate = DATEADD(DAY,1,@createAt)
	
	--SELECT CONVERT(VARCHAR(5),DATEDIFF(s, @startDate, @EndDate)/3600) + ':' + 
	--	CONVERT(VARCHAR(5),DATEDIFF(s, @startDate, @EndDate)%3600/60) + ':' + 
	--	CONVERT(VARCHAR(5),(DATEDIFF(s, @startDate, @EndDate)%60)) AS [hh:mm:ss]

	RETURN CAST((@EndDate-@StartDate) AS TIME(0))-- AS '[hh:mm:ss]'
END

/*end*/

USE BelcorpMexico
GO

CREATE FUNCTION [dbo].[CaclSaldoHorasSolicitudPedido]
(
	@CreateAt DATETIME   
)
RETURNS VARCHAR(30)
AS
BEGIN
	
	DECLARE @StartDate DATETIME, @EndDate DATETIME

	--SET @createAt = '2016-10-05 12:01:44'
	--SET @StartDate = '2016-10-04 21:30:20'
	--SET @EndDate='2016-10-05 21:25:10'
	SET @StartDate = GETDATE()
	SET @EndDate = DATEADD(DAY,1,@createAt)
	
	--SELECT CONVERT(VARCHAR(5),DATEDIFF(s, @startDate, @EndDate)/3600) + ':' + 
	--	CONVERT(VARCHAR(5),DATEDIFF(s, @startDate, @EndDate)%3600/60) + ':' + 
	--	CONVERT(VARCHAR(5),(DATEDIFF(s, @startDate, @EndDate)%60)) AS [hh:mm:ss]

	RETURN CAST((@EndDate-@StartDate) AS TIME(0))-- AS '[hh:mm:ss]'
END

/*end*/

USE BelcorpEcuador
GO

CREATE FUNCTION [dbo].[CaclSaldoHorasSolicitudPedido]
(
	@CreateAt DATETIME   
)
RETURNS VARCHAR(30)
AS
BEGIN
	
	DECLARE @StartDate DATETIME, @EndDate DATETIME

	--SET @createAt = '2016-10-05 12:01:44'
	--SET @StartDate = '2016-10-04 21:30:20'
	--SET @EndDate='2016-10-05 21:25:10'
	SET @StartDate = GETDATE()
	SET @EndDate = DATEADD(DAY,1,@createAt)
	
	--SELECT CONVERT(VARCHAR(5),DATEDIFF(s, @startDate, @EndDate)/3600) + ':' + 
	--	CONVERT(VARCHAR(5),DATEDIFF(s, @startDate, @EndDate)%3600/60) + ':' + 
	--	CONVERT(VARCHAR(5),(DATEDIFF(s, @startDate, @EndDate)%60)) AS [hh:mm:ss]

	RETURN CAST((@EndDate-@StartDate) AS TIME(0))-- AS '[hh:mm:ss]'
END

/*end*/

USE BelcorpCostaRica
GO

CREATE FUNCTION [dbo].[CaclSaldoHorasSolicitudPedido]
(
	@CreateAt DATETIME   
)
RETURNS VARCHAR(30)
AS
BEGIN
	
	DECLARE @StartDate DATETIME, @EndDate DATETIME

	--SET @createAt = '2016-10-05 12:01:44'
	--SET @StartDate = '2016-10-04 21:30:20'
	--SET @EndDate='2016-10-05 21:25:10'
	SET @StartDate = GETDATE()
	SET @EndDate = DATEADD(DAY,1,@createAt)
	
	--SELECT CONVERT(VARCHAR(5),DATEDIFF(s, @startDate, @EndDate)/3600) + ':' + 
	--	CONVERT(VARCHAR(5),DATEDIFF(s, @startDate, @EndDate)%3600/60) + ':' + 
	--	CONVERT(VARCHAR(5),(DATEDIFF(s, @startDate, @EndDate)%60)) AS [hh:mm:ss]

	RETURN CAST((@EndDate-@StartDate) AS TIME(0))-- AS '[hh:mm:ss]'
END

/*end*/

USE BelcorpBolivia
GO

CREATE FUNCTION [dbo].[CaclSaldoHorasSolicitudPedido]
(
	@CreateAt DATETIME   
)
RETURNS VARCHAR(30)
AS
BEGIN
	
	DECLARE @StartDate DATETIME, @EndDate DATETIME

	--SET @createAt = '2016-10-05 12:01:44'
	--SET @StartDate = '2016-10-04 21:30:20'
	--SET @EndDate='2016-10-05 21:25:10'
	SET @StartDate = GETDATE()
	SET @EndDate = DATEADD(DAY,1,@createAt)
	
	--SELECT CONVERT(VARCHAR(5),DATEDIFF(s, @startDate, @EndDate)/3600) + ':' + 
	--	CONVERT(VARCHAR(5),DATEDIFF(s, @startDate, @EndDate)%3600/60) + ':' + 
	--	CONVERT(VARCHAR(5),(DATEDIFF(s, @startDate, @EndDate)%60)) AS [hh:mm:ss]

	RETURN CAST((@EndDate-@StartDate) AS TIME(0))-- AS '[hh:mm:ss]'
END

/*end*/

USE BelcorpDominicana
GO

CREATE FUNCTION [dbo].[CaclSaldoHorasSolicitudPedido]
(
	@CreateAt DATETIME   
)
RETURNS VARCHAR(30)
AS
BEGIN
	
	DECLARE @StartDate DATETIME, @EndDate DATETIME

	--SET @createAt = '2016-10-05 12:01:44'
	--SET @StartDate = '2016-10-04 21:30:20'
	--SET @EndDate='2016-10-05 21:25:10'
	SET @StartDate = GETDATE()
	SET @EndDate = DATEADD(DAY,1,@createAt)
	
	--SELECT CONVERT(VARCHAR(5),DATEDIFF(s, @startDate, @EndDate)/3600) + ':' + 
	--	CONVERT(VARCHAR(5),DATEDIFF(s, @startDate, @EndDate)%3600/60) + ':' + 
	--	CONVERT(VARCHAR(5),(DATEDIFF(s, @startDate, @EndDate)%60)) AS [hh:mm:ss]

	RETURN CAST((@EndDate-@StartDate) AS TIME(0))-- AS '[hh:mm:ss]'
END
/*end*/

USE BelcorpGuatemala
GO

CREATE FUNCTION [dbo].[CaclSaldoHorasSolicitudPedido]
(
	@CreateAt DATETIME   
)
RETURNS VARCHAR(30)
AS
BEGIN
	
	DECLARE @StartDate DATETIME, @EndDate DATETIME

	--SET @createAt = '2016-10-05 12:01:44'
	--SET @StartDate = '2016-10-04 21:30:20'
	--SET @EndDate='2016-10-05 21:25:10'
	SET @StartDate = GETDATE()
	SET @EndDate = DATEADD(DAY,1,@createAt)
	
	--SELECT CONVERT(VARCHAR(5),DATEDIFF(s, @startDate, @EndDate)/3600) + ':' + 
	--	CONVERT(VARCHAR(5),DATEDIFF(s, @startDate, @EndDate)%3600/60) + ':' + 
	--	CONVERT(VARCHAR(5),(DATEDIFF(s, @startDate, @EndDate)%60)) AS [hh:mm:ss]

	RETURN CAST((@EndDate-@StartDate) AS TIME(0))-- AS '[hh:mm:ss]'
END

/*end*/

USE BelcorpPanama
GO

CREATE FUNCTION [dbo].[CaclSaldoHorasSolicitudPedido]
(
	@CreateAt DATETIME   
)
RETURNS VARCHAR(30)
AS
BEGIN
	
	DECLARE @StartDate DATETIME, @EndDate DATETIME

	--SET @createAt = '2016-10-05 12:01:44'
	--SET @StartDate = '2016-10-04 21:30:20'
	--SET @EndDate='2016-10-05 21:25:10'
	SET @StartDate = GETDATE()
	SET @EndDate = DATEADD(DAY,1,@createAt)
	
	--SELECT CONVERT(VARCHAR(5),DATEDIFF(s, @startDate, @EndDate)/3600) + ':' + 
	--	CONVERT(VARCHAR(5),DATEDIFF(s, @startDate, @EndDate)%3600/60) + ':' + 
	--	CONVERT(VARCHAR(5),(DATEDIFF(s, @startDate, @EndDate)%60)) AS [hh:mm:ss]

	RETURN CAST((@EndDate-@StartDate) AS TIME(0))-- AS '[hh:mm:ss]'
END
/*end*/

USE BelcorpPuertoRico
GO

CREATE FUNCTION [dbo].[CaclSaldoHorasSolicitudPedido]
(
	@CreateAt DATETIME   
)
RETURNS VARCHAR(30)
AS
BEGIN
	
	DECLARE @StartDate DATETIME, @EndDate DATETIME

	--SET @createAt = '2016-10-05 12:01:44'
	--SET @StartDate = '2016-10-04 21:30:20'
	--SET @EndDate='2016-10-05 21:25:10'
	SET @StartDate = GETDATE()
	SET @EndDate = DATEADD(DAY,1,@createAt)
	
	--SELECT CONVERT(VARCHAR(5),DATEDIFF(s, @startDate, @EndDate)/3600) + ':' + 
	--	CONVERT(VARCHAR(5),DATEDIFF(s, @startDate, @EndDate)%3600/60) + ':' + 
	--	CONVERT(VARCHAR(5),(DATEDIFF(s, @startDate, @EndDate)%60)) AS [hh:mm:ss]

	RETURN CAST((@EndDate-@StartDate) AS TIME(0))-- AS '[hh:mm:ss]'
END

/*end*/

USE BelcorpSalvador
GO

CREATE FUNCTION [dbo].[CaclSaldoHorasSolicitudPedido]
(
	@CreateAt DATETIME   
)
RETURNS VARCHAR(30)
AS
BEGIN
	
	DECLARE @StartDate DATETIME, @EndDate DATETIME

	--SET @createAt = '2016-10-05 12:01:44'
	--SET @StartDate = '2016-10-04 21:30:20'
	--SET @EndDate='2016-10-05 21:25:10'
	SET @StartDate = GETDATE()
	SET @EndDate = DATEADD(DAY,1,@createAt)
	
	--SELECT CONVERT(VARCHAR(5),DATEDIFF(s, @startDate, @EndDate)/3600) + ':' + 
	--	CONVERT(VARCHAR(5),DATEDIFF(s, @startDate, @EndDate)%3600/60) + ':' + 
	--	CONVERT(VARCHAR(5),(DATEDIFF(s, @startDate, @EndDate)%60)) AS [hh:mm:ss]

	RETURN CAST((@EndDate-@StartDate) AS TIME(0))-- AS '[hh:mm:ss]'
END

/*end*/

USE BelcorpVenezuela
GO

CREATE FUNCTION [dbo].[CaclSaldoHorasSolicitudPedido]
(
	@CreateAt DATETIME   
)
RETURNS VARCHAR(30)
AS
BEGIN
	
	DECLARE @StartDate DATETIME, @EndDate DATETIME

	--SET @createAt = '2016-10-05 12:01:44'
	--SET @StartDate = '2016-10-04 21:30:20'
	--SET @EndDate='2016-10-05 21:25:10'
	SET @StartDate = GETDATE()
	SET @EndDate = DATEADD(DAY,1,@createAt)
	
	--SELECT CONVERT(VARCHAR(5),DATEDIFF(s, @startDate, @EndDate)/3600) + ':' + 
	--	CONVERT(VARCHAR(5),DATEDIFF(s, @startDate, @EndDate)%3600/60) + ':' + 
	--	CONVERT(VARCHAR(5),(DATEDIFF(s, @startDate, @EndDate)%60)) AS [hh:mm:ss]

	RETURN CAST((@EndDate-@StartDate) AS TIME(0))-- AS '[hh:mm:ss]'
END
