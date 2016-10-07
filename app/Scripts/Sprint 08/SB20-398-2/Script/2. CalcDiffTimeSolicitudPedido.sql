


USE BelcorpPeru
GO

CREATE FUNCTION [dbo].[CalcDiffTimeSolicitudPedido]
(
	@fechaRegistro DATETIME
)
RETURNS VARCHAR(20) 
AS
BEGIN
	DECLARE @output VARCHAR(20), @hours INT, @minutes INT, @seconds INT, @fechaLimite DATETIME
	SET @fechaLimite = dateadd(day,1,@fechaRegistro)
	SET @hours = datediff(hour,getdate(),@fechaLimite)
	SET @minutes = (@hours * 60 - datediff(minute,getdate(),@fechaLimite))
	IF (@hours < 0 OR @hours > 24) SET @hours = 24;
	IF (@minutes < 0 OR @minutes > 60) SET @minutes = 60;
	SET @output = RIGHT('00' + CAST(@hours AS VARCHAR),2) + ':' 
		+ RIGHT('00' + CAST(@minutes AS VARCHAR),2) + ':00'
	RETURN @output
END

/*end*/

USE BelcorpColombia
GO

CREATE FUNCTION [dbo].[CalcDiffTimeSolicitudPedido]
(
	@fechaRegistro DATETIME
)
RETURNS VARCHAR(20) 
AS
BEGIN
	DECLARE @output VARCHAR(20), @hours INT, @minutes INT, @seconds INT, @fechaLimite DATETIME
	SET @fechaLimite = dateadd(day,1,@fechaRegistro)
	SET @hours = datediff(hour,getdate(),@fechaLimite)
	SET @minutes = (@hours * 60 - datediff(minute,getdate(),@fechaLimite))
	IF (@hours < 0 OR @hours > 24) SET @hours = 24;
	IF (@minutes < 0 OR @minutes > 60) SET @minutes = 60;
	SET @output = RIGHT('00' + CAST(@hours AS VARCHAR),2) + ':' 
		+ RIGHT('00' + CAST(@minutes AS VARCHAR),2) + ':00'
	RETURN @output
END

/*end*/

USE BelcorpChile
GO

CREATE FUNCTION [dbo].[CalcDiffTimeSolicitudPedido]
(
	@fechaRegistro DATETIME
)
RETURNS VARCHAR(20) 
AS
BEGIN
	DECLARE @output VARCHAR(20), @hours INT, @minutes INT, @seconds INT, @fechaLimite DATETIME
	SET @fechaLimite = dateadd(day,1,@fechaRegistro)
	SET @hours = datediff(hour,getdate(),@fechaLimite)
	SET @minutes = (@hours * 60 - datediff(minute,getdate(),@fechaLimite))
	IF (@hours < 0 OR @hours > 24) SET @hours = 24;
	IF (@minutes < 0 OR @minutes > 60) SET @minutes = 60;
	SET @output = RIGHT('00' + CAST(@hours AS VARCHAR),2) + ':' 
		+ RIGHT('00' + CAST(@minutes AS VARCHAR),2) + ':00'
	RETURN @output
END

/*end*/

USE BelcorpMexico
GO

CREATE FUNCTION [dbo].[CalcDiffTimeSolicitudPedido]
(
	@fechaRegistro DATETIME
)
RETURNS VARCHAR(20) 
AS
BEGIN
	DECLARE @output VARCHAR(20), @hours INT, @minutes INT, @seconds INT, @fechaLimite DATETIME
	SET @fechaLimite = dateadd(day,1,@fechaRegistro)
	SET @hours = datediff(hour,getdate(),@fechaLimite)
	SET @minutes = (@hours * 60 - datediff(minute,getdate(),@fechaLimite))
	IF (@hours < 0 OR @hours > 24) SET @hours = 24;
	IF (@minutes < 0 OR @minutes > 60) SET @minutes = 60;
	SET @output = RIGHT('00' + CAST(@hours AS VARCHAR),2) + ':' 
		+ RIGHT('00' + CAST(@minutes AS VARCHAR),2) + ':00'
	RETURN @output
END

/*end*/

USE BelcorpEcuador
GO

CREATE FUNCTION [dbo].[CalcDiffTimeSolicitudPedido]
(
	@fechaRegistro DATETIME
)
RETURNS VARCHAR(20) 
AS
BEGIN
	DECLARE @output VARCHAR(20), @hours INT, @minutes INT, @seconds INT, @fechaLimite DATETIME
	SET @fechaLimite = dateadd(day,1,@fechaRegistro)
	SET @hours = datediff(hour,getdate(),@fechaLimite)
	SET @minutes = (@hours * 60 - datediff(minute,getdate(),@fechaLimite))
	IF (@hours < 0 OR @hours > 24) SET @hours = 24;
	IF (@minutes < 0 OR @minutes > 60) SET @minutes = 60;
	SET @output = RIGHT('00' + CAST(@hours AS VARCHAR),2) + ':' 
		+ RIGHT('00' + CAST(@minutes AS VARCHAR),2) + ':00'
	RETURN @output
END

/*end*/

USE BelcorpCostaRica
GO

CREATE FUNCTION [dbo].[CalcDiffTimeSolicitudPedido]
(
	@fechaRegistro DATETIME
)
RETURNS VARCHAR(20) 
AS
BEGIN
	DECLARE @output VARCHAR(20), @hours INT, @minutes INT, @seconds INT, @fechaLimite DATETIME
	SET @fechaLimite = dateadd(day,1,@fechaRegistro)
	SET @hours = datediff(hour,getdate(),@fechaLimite)
	SET @minutes = (@hours * 60 - datediff(minute,getdate(),@fechaLimite))
	IF (@hours < 0 OR @hours > 24) SET @hours = 24;
	IF (@minutes < 0 OR @minutes > 60) SET @minutes = 60;
	SET @output = RIGHT('00' + CAST(@hours AS VARCHAR),2) + ':' 
		+ RIGHT('00' + CAST(@minutes AS VARCHAR),2) + ':00'
	RETURN @output
END

/*end*/

USE BelcorpBolivia
GO

CREATE FUNCTION [dbo].[CalcDiffTimeSolicitudPedido]
(
	@fechaRegistro DATETIME
)
RETURNS VARCHAR(30) 
AS
BEGIN
	DECLARE @output VARCHAR(30), @hours VARCHAR(10), @minutes VARCHAR(10), @seconds VARCHAR(10), @fechaLimite DATETIME
	SET @fechaLimite = dateadd(day,1,@fechaRegistro)
	SET @hours = datediff(hour,getdate(),@fechaLimite)
	SET @minutes = (datediff(minute,getdate(),@fechaLimite) - @hours * 60)
	IF (@hours < 0) SET @hours = '24';
	IF (@minutes < 0) SET @hours = '60';
	SET @output = RIGHT('00' + @hours,2) + ':' + RIGHT('00' + @minutes,2) + ':00'
	RETURN @output
END

/*end*/

USE BelcorpDominicana
GO

CREATE FUNCTION [dbo].[CalcDiffTimeSolicitudPedido]
(
	@fechaRegistro DATETIME
)
RETURNS VARCHAR(30) 
AS
BEGIN
	DECLARE @output VARCHAR(30), @hours VARCHAR(10), @minutes VARCHAR(10), @seconds VARCHAR(10), @fechaLimite DATETIME
	SET @fechaLimite = dateadd(day,1,@fechaRegistro)
	SET @hours = datediff(hour,getdate(),@fechaLimite)
	SET @minutes = (datediff(minute,getdate(),@fechaLimite) - @hours * 60)
	IF (@hours < 0) SET @hours = '24';
	IF (@minutes < 0) SET @hours = '60';
	SET @output = RIGHT('00' + @hours,2) + ':' + RIGHT('00' + @minutes,2) + ':00'
	RETURN @output
END

/*end*/

USE BelcorpGuatemala
GO

CREATE FUNCTION [dbo].[CalcDiffTimeSolicitudPedido]
(
	@fechaRegistro DATETIME
)
RETURNS VARCHAR(30) 
AS
BEGIN
	DECLARE @output VARCHAR(30), @hours VARCHAR(10), @minutes VARCHAR(10), @seconds VARCHAR(10), @fechaLimite DATETIME
	SET @fechaLimite = dateadd(day,1,@fechaRegistro)
	SET @hours = datediff(hour,getdate(),@fechaLimite)
	SET @minutes = (datediff(minute,getdate(),@fechaLimite) - @hours * 60)
	IF (@hours < 0) SET @hours = '24';
	IF (@minutes < 0) SET @hours = '60';
	SET @output = RIGHT('00' + @hours,2) + ':' + RIGHT('00' + @minutes,2) + ':00'
	RETURN @output
END

/*end*/

USE BelcorpPanama
GO

CREATE FUNCTION [dbo].[CalcDiffTimeSolicitudPedido]
(
	@fechaRegistro DATETIME
)
RETURNS VARCHAR(30) 
AS
BEGIN
	DECLARE @output VARCHAR(30), @hours VARCHAR(10), @minutes VARCHAR(10), @seconds VARCHAR(10), @fechaLimite DATETIME
	SET @fechaLimite = dateadd(day,1,@fechaRegistro)
	SET @hours = datediff(hour,getdate(),@fechaLimite)
	SET @minutes = (datediff(minute,getdate(),@fechaLimite) - @hours * 60)
	IF (@hours < 0) SET @hours = '24';
	IF (@minutes < 0) SET @hours = '60';
	SET @output = RIGHT('00' + @hours,2) + ':' + RIGHT('00' + @minutes,2) + ':00'
	RETURN @output
END

/*end*/

USE BelcorpPuertoRico
GO

CREATE FUNCTION [dbo].[CalcDiffTimeSolicitudPedido]
(
	@fechaRegistro DATETIME
)
RETURNS VARCHAR(30) 
AS
BEGIN
	DECLARE @output VARCHAR(30), @hours VARCHAR(10), @minutes VARCHAR(10), @seconds VARCHAR(10), @fechaLimite DATETIME
	SET @fechaLimite = dateadd(day,1,@fechaRegistro)
	SET @hours = datediff(hour,getdate(),@fechaLimite)
	SET @minutes = (datediff(minute,getdate(),@fechaLimite) - @hours * 60)
	IF (@hours < 0) SET @hours = '24';
	IF (@minutes < 0) SET @hours = '60';
	SET @output = RIGHT('00' + @hours,2) + ':' + RIGHT('00' + @minutes,2) + ':00'
	RETURN @output
END

/*end*/

USE BelcorpSalvador
GO

CREATE FUNCTION [dbo].[CalcDiffTimeSolicitudPedido]
(
	@fechaRegistro DATETIME
)
RETURNS VARCHAR(30) 
AS
BEGIN
	DECLARE @output VARCHAR(30), @hours VARCHAR(10), @minutes VARCHAR(10), @seconds VARCHAR(10), @fechaLimite DATETIME
	SET @fechaLimite = dateadd(day,1,@fechaRegistro)
	SET @hours = datediff(hour,getdate(),@fechaLimite)
	SET @minutes = (datediff(minute,getdate(),@fechaLimite) - @hours * 60)
	IF (@hours < 0) SET @hours = '24';
	IF (@minutes < 0) SET @hours = '60';
	SET @output = RIGHT('00' + @hours,2) + ':' + RIGHT('00' + @minutes,2) + ':00'
	RETURN @output
END

/*end*/

USE BelcorpVenezuela
GO

CREATE FUNCTION [dbo].[CalcDiffTimeSolicitudPedido]
(
	@fechaRegistro DATETIME
)
RETURNS VARCHAR(30) 
AS
BEGIN
	DECLARE @output VARCHAR(30), @hours VARCHAR(10), @minutes VARCHAR(10), @seconds VARCHAR(10), @fechaLimite DATETIME
	SET @fechaLimite = dateadd(day,1,@fechaRegistro)
	SET @hours = datediff(hour,getdate(),@fechaLimite)
	SET @minutes = (datediff(minute,getdate(),@fechaLimite) - @hours * 60)
	IF (@hours < 0) SET @hours = '24';
	IF (@minutes < 0) SET @hours = '60';
	SET @output = RIGHT('00' + @hours,2) + ':' + RIGHT('00' + @minutes,2) + ':00'
	RETURN @output
END
