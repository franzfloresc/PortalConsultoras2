USE BelcorpPeru
GO

IF EXISTS(SELECT 1 
          FROM   sys.procedures 
          WHERE  NAME = 'up_changecampaign') 
  BEGIN 
      DROP PROCEDURE dbo.up_changecampaign 
  END 
GO 

--EXEC up_changecampaign '000003581', 201902 
--INPUT  
CREATE PROCEDURE dbo.up_changecampaign
 @Consultora VARCHAR(25),  
 @CampaniaDeseado INT  
AS  
--ALGORITMO 
--DECLARE @Consultora VARCHAR(25) = '000003581' 
--DECLARE @CampaniaDeseado INT  = 201902

DECLARE @TemporalCampanias TABLE(Identificador INT IDENTITY(1,1), Campania CHAR(6)) 
DECLARE @Campanias TABLE(Identificador INT IDENTITY(1,1), Campania CHAR(6)) 
DECLARE @CampaniaIDCN INT = 0
DECLARE @CantidadTrabajo INT = 0
DECLARE @Trabajo INT = 1
DECLARE @CampaniaFlag INT = 0
DECLARE @FechaFacturacion SMALLDATETIME
DECLARE @FechaRefacturacion SMALLDATETIME
DECLARE @UltimaCampanaFacturada INT = 0
DECLARE @CodigoConsultora VARCHAR(25) = ''
DECLARE @ConsultoraId BIGINT = 0  
DECLARE @CampaniaFacturado INT= (@CampaniaDeseado-1)
DECLARE @DiasAntes INT = -30  
DECLARE @DiasDespues INT = 10
DECLARE @Identificador INT = 0

SELECT @CampaniaIDCN = CampaniaIDCN FROM ods.Campania WHERE Codigo = @CampaniaDeseado AND Activo = 1 

INSERT INTO @TemporalCampanias (Campania)
SELECT Codigo FROM ods.Campania WHERE CampaniaIDCN BETWEEN (@CampaniaIDCN - 6) AND (@CampaniaIDCN + 8) AND Activo = 1 

SET @Identificador = (SELECT Identificador FROM @TemporalCampanias WHERE Campania = @CampaniaDeseado)

INSERT INTO @Campanias (Campania)
SELECT Campania FROM @TemporalCampanias WHERE Identificador BETWEEN (@Identificador - 3) AND (@Identificador + 3)

SET @CantidadTrabajo = (SELECT COUNT(*) FROM @Campanias)

WHILE (@Trabajo <= @CantidadTrabajo) 
BEGIN
	SET @CampaniaFlag = (SELECT Campania FROM @Campanias WHERE Identificador = @Trabajo)

	IF (@CampaniaFlag < @CampaniaDeseado)
	BEGIN
		SET @FechaFacturacion = CONVERT(VARCHAR(10), GETDATE() - (@DiasAntes * -1), 121)
		SET @FechaRefacturacion = CONVERT(VARCHAR(10), GETDATE() - (@DiasAntes * -1), 121)
	END
    ELSE IF(@CampaniaFlag = @CampaniaDeseado)
	BEGIN
		SET @FechaFacturacion = CONVERT(VARCHAR(10), GETDATE(), 121)
		SET @FechaRefacturacion = CONVERT(VARCHAR(10), GETDATE(), 121)
	END
    ELSE IF(@CampaniaFlag > @CampaniaDeseado)
	BEGIN
		SET @FechaFacturacion = CONVERT(VARCHAR(10), GETDATE() + @DiasDespues, 121)
		SET @FechaRefacturacion = CONVERT(VARCHAR(10), GETDATE() + @DiasDespues, 121)
	END

	UPDATE ods.Cronograma   
	 SET FechaInicioFacturacion = @FechaFacturacion,   
		 FechaFinFacturacion = @FechaFacturacion,  
		 FechaInicioRefacturacion = @FechaRefacturacion,  
		 FechaFinRefacturacion = @FechaRefacturacion  
		FROM ods.Consultora CO  
		INNER JOIN ods.Zona Z ON Z.ZonaID = CO.ZonaID AND Z.RegionID = CO.RegionID  
		INNER JOIN ods.Cronograma CR ON CR.ZonaID = Z.ZonaID AND CR.RegionID = Z.RegionID  
		INNER JOIN ods.Campania CA ON CA.CampaniaID = CR.CampaniaID AND CA.Codigo = @CampaniaFlag  
			WHERE CO.AutorizaPedido = 1  
			AND CO.Codigo = @Consultora 
	
	IF (@CampaniaFlag < @CampaniaDeseado)
	BEGIN
		SET @DiasAntes = @DiasAntes-(-10)
	END
    ELSE IF(@CampaniaFlag > @CampaniaDeseado)
	BEGIN
		SET @DiasDespues = @DiasDespues + 10 
	END

	SET @Trabajo = @Trabajo + 1
END

SELECT @UltimaCampanaFacturada=ultimacampanafacturada, @CodigoConsultora=Codigo, @ConsultoraId=ConsultoraId FROM ods.Consultora WHERE Codigo = @Consultora  
  
IF (@UltimaCampanaFacturada >= @CampaniaDeseado)  
BEGIN  
 UPDATE ods.Consultora SET ultimacampanafacturada = @CampaniaFacturado WHERE Codigo=@CodigoConsultora  
 UPDATE ods.Consultora SET autorizapedido = 1 WHERE Codigo = @CodigoConsultora  
END  
  
UPDATE PedidoWeb SET IndicadorEnviado = 0 WHERE ConsultoraID=@ConsultoraId AND CampaniaID > @CampaniaFacturado  
UPDATE PedidoWeb SET ValidacionAbierta = 0 WHERE consultoraid=@ConsultoraId AND CampaniaID > @CampaniaFacturado  
  

SELECT CR.FechaInicioFacturacion,CR.FechaFinFacturacion,CR.FechaInicioReFacturacion,CR.FechaFinReFacturacion,CA.Codigo,CO.Codigo,* FROM ods.Consultora CO
INNER JOIN ods.Zona Z ON CO.ZonaID = Z.ZonaID AND CO.RegionID = Z.RegionID
INNER JOIN ods.Cronograma CR ON Z.ZonaID = CR.ZonaID AND Z.RegionID = CR.RegionID
INNER JOIN ods.Campania CA ON CR.CampaniaID = CA.CampaniaID AND CA.Codigo IN (SELECT Campania FROM @Campanias)
WHERE CO.AutorizaPedido = 1 AND CO.Codigo = @Consultora

GO

USE BelcorpMexico
GO

IF EXISTS(SELECT 1 
          FROM   sys.procedures 
          WHERE  NAME = 'up_changecampaign') 
  BEGIN 
      DROP PROCEDURE dbo.up_changecampaign 
  END 
GO 

--EXEC up_changecampaign '000003581', 201902 
--INPUT  
CREATE PROCEDURE dbo.up_changecampaign
 @Consultora VARCHAR(25),  
 @CampaniaDeseado INT  
AS  
--ALGORITMO 
--DECLARE @Consultora VARCHAR(25) = '000003581' 
--DECLARE @CampaniaDeseado INT  = 201902

DECLARE @TemporalCampanias TABLE(Identificador INT IDENTITY(1,1), Campania CHAR(6)) 
DECLARE @Campanias TABLE(Identificador INT IDENTITY(1,1), Campania CHAR(6)) 
DECLARE @CampaniaIDCN INT = 0
DECLARE @CantidadTrabajo INT = 0
DECLARE @Trabajo INT = 1
DECLARE @CampaniaFlag INT = 0
DECLARE @FechaFacturacion SMALLDATETIME
DECLARE @FechaRefacturacion SMALLDATETIME
DECLARE @UltimaCampanaFacturada INT = 0
DECLARE @CodigoConsultora VARCHAR(25) = ''
DECLARE @ConsultoraId BIGINT = 0  
DECLARE @CampaniaFacturado INT= (@CampaniaDeseado-1)
DECLARE @DiasAntes INT = -30  
DECLARE @DiasDespues INT = 10
DECLARE @Identificador INT = 0

SELECT @CampaniaIDCN = CampaniaIDCN FROM ods.Campania WHERE Codigo = @CampaniaDeseado AND Activo = 1 

INSERT INTO @TemporalCampanias (Campania)
SELECT Codigo FROM ods.Campania WHERE CampaniaIDCN BETWEEN (@CampaniaIDCN - 6) AND (@CampaniaIDCN + 8) AND Activo = 1 

SET @Identificador = (SELECT Identificador FROM @TemporalCampanias WHERE Campania = @CampaniaDeseado)

INSERT INTO @Campanias (Campania)
SELECT Campania FROM @TemporalCampanias WHERE Identificador BETWEEN (@Identificador - 3) AND (@Identificador + 3)

SET @CantidadTrabajo = (SELECT COUNT(*) FROM @Campanias)

WHILE (@Trabajo <= @CantidadTrabajo) 
BEGIN
	SET @CampaniaFlag = (SELECT Campania FROM @Campanias WHERE Identificador = @Trabajo)

	IF (@CampaniaFlag < @CampaniaDeseado)
	BEGIN
		SET @FechaFacturacion = CONVERT(VARCHAR(10), GETDATE() - (@DiasAntes * -1), 121)
		SET @FechaRefacturacion = CONVERT(VARCHAR(10), GETDATE() - (@DiasAntes * -1), 121)
	END
    ELSE IF(@CampaniaFlag = @CampaniaDeseado)
	BEGIN
		SET @FechaFacturacion = CONVERT(VARCHAR(10), GETDATE(), 121)
		SET @FechaRefacturacion = CONVERT(VARCHAR(10), GETDATE(), 121)
	END
    ELSE IF(@CampaniaFlag > @CampaniaDeseado)
	BEGIN
		SET @FechaFacturacion = CONVERT(VARCHAR(10), GETDATE() + @DiasDespues, 121)
		SET @FechaRefacturacion = CONVERT(VARCHAR(10), GETDATE() + @DiasDespues, 121)
	END

	UPDATE ods.Cronograma   
	 SET FechaInicioFacturacion = @FechaFacturacion,   
		 FechaFinFacturacion = @FechaFacturacion,  
		 FechaInicioRefacturacion = @FechaRefacturacion,  
		 FechaFinRefacturacion = @FechaRefacturacion  
		FROM ods.Consultora CO  
		INNER JOIN ods.Zona Z ON Z.ZonaID = CO.ZonaID AND Z.RegionID = CO.RegionID  
		INNER JOIN ods.Cronograma CR ON CR.ZonaID = Z.ZonaID AND CR.RegionID = Z.RegionID  
		INNER JOIN ods.Campania CA ON CA.CampaniaID = CR.CampaniaID AND CA.Codigo = @CampaniaFlag  
			WHERE CO.AutorizaPedido = 1  
			AND CO.Codigo = @Consultora 
	
	IF (@CampaniaFlag < @CampaniaDeseado)
	BEGIN
		SET @DiasAntes = @DiasAntes-(-10)
	END
    ELSE IF(@CampaniaFlag > @CampaniaDeseado)
	BEGIN
		SET @DiasDespues = @DiasDespues + 10 
	END

	SET @Trabajo = @Trabajo + 1
END

SELECT @UltimaCampanaFacturada=ultimacampanafacturada, @CodigoConsultora=Codigo, @ConsultoraId=ConsultoraId FROM ods.Consultora WHERE Codigo = @Consultora  
  
IF (@UltimaCampanaFacturada >= @CampaniaDeseado)  
BEGIN  
 UPDATE ods.Consultora SET ultimacampanafacturada = @CampaniaFacturado WHERE Codigo=@CodigoConsultora  
 UPDATE ods.Consultora SET autorizapedido = 1 WHERE Codigo = @CodigoConsultora  
END  
  
UPDATE PedidoWeb SET IndicadorEnviado = 0 WHERE ConsultoraID=@ConsultoraId AND CampaniaID > @CampaniaFacturado  
UPDATE PedidoWeb SET ValidacionAbierta = 0 WHERE consultoraid=@ConsultoraId AND CampaniaID > @CampaniaFacturado  
  

SELECT CR.FechaInicioFacturacion,CR.FechaFinFacturacion,CR.FechaInicioReFacturacion,CR.FechaFinReFacturacion,CA.Codigo,CO.Codigo,* FROM ods.Consultora CO
INNER JOIN ods.Zona Z ON CO.ZonaID = Z.ZonaID AND CO.RegionID = Z.RegionID
INNER JOIN ods.Cronograma CR ON Z.ZonaID = CR.ZonaID AND Z.RegionID = CR.RegionID
INNER JOIN ods.Campania CA ON CR.CampaniaID = CA.CampaniaID AND CA.Codigo IN (SELECT Campania FROM @Campanias)
WHERE CO.AutorizaPedido = 1 AND CO.Codigo = @Consultora

GO

USE BelcorpColombia
GO

IF EXISTS(SELECT 1 
          FROM   sys.procedures 
          WHERE  NAME = 'up_changecampaign') 
  BEGIN 
      DROP PROCEDURE dbo.up_changecampaign 
  END 
GO 

--EXEC up_changecampaign '000003581', 201902 
--INPUT  
CREATE PROCEDURE dbo.up_changecampaign
 @Consultora VARCHAR(25),  
 @CampaniaDeseado INT  
AS  
--ALGORITMO 
--DECLARE @Consultora VARCHAR(25) = '000003581' 
--DECLARE @CampaniaDeseado INT  = 201902

DECLARE @TemporalCampanias TABLE(Identificador INT IDENTITY(1,1), Campania CHAR(6)) 
DECLARE @Campanias TABLE(Identificador INT IDENTITY(1,1), Campania CHAR(6)) 
DECLARE @CampaniaIDCN INT = 0
DECLARE @CantidadTrabajo INT = 0
DECLARE @Trabajo INT = 1
DECLARE @CampaniaFlag INT = 0
DECLARE @FechaFacturacion SMALLDATETIME
DECLARE @FechaRefacturacion SMALLDATETIME
DECLARE @UltimaCampanaFacturada INT = 0
DECLARE @CodigoConsultora VARCHAR(25) = ''
DECLARE @ConsultoraId BIGINT = 0  
DECLARE @CampaniaFacturado INT= (@CampaniaDeseado-1)
DECLARE @DiasAntes INT = -30  
DECLARE @DiasDespues INT = 10
DECLARE @Identificador INT = 0

SELECT @CampaniaIDCN = CampaniaIDCN FROM ods.Campania WHERE Codigo = @CampaniaDeseado AND Activo = 1 

INSERT INTO @TemporalCampanias (Campania)
SELECT Codigo FROM ods.Campania WHERE CampaniaIDCN BETWEEN (@CampaniaIDCN - 6) AND (@CampaniaIDCN + 8) AND Activo = 1 

SET @Identificador = (SELECT Identificador FROM @TemporalCampanias WHERE Campania = @CampaniaDeseado)

INSERT INTO @Campanias (Campania)
SELECT Campania FROM @TemporalCampanias WHERE Identificador BETWEEN (@Identificador - 3) AND (@Identificador + 3)

SET @CantidadTrabajo = (SELECT COUNT(*) FROM @Campanias)

WHILE (@Trabajo <= @CantidadTrabajo) 
BEGIN
	SET @CampaniaFlag = (SELECT Campania FROM @Campanias WHERE Identificador = @Trabajo)

	IF (@CampaniaFlag < @CampaniaDeseado)
	BEGIN
		SET @FechaFacturacion = CONVERT(VARCHAR(10), GETDATE() - (@DiasAntes * -1), 121)
		SET @FechaRefacturacion = CONVERT(VARCHAR(10), GETDATE() - (@DiasAntes * -1), 121)
	END
    ELSE IF(@CampaniaFlag = @CampaniaDeseado)
	BEGIN
		SET @FechaFacturacion = CONVERT(VARCHAR(10), GETDATE(), 121)
		SET @FechaRefacturacion = CONVERT(VARCHAR(10), GETDATE(), 121)
	END
    ELSE IF(@CampaniaFlag > @CampaniaDeseado)
	BEGIN
		SET @FechaFacturacion = CONVERT(VARCHAR(10), GETDATE() + @DiasDespues, 121)
		SET @FechaRefacturacion = CONVERT(VARCHAR(10), GETDATE() + @DiasDespues, 121)
	END

	UPDATE ods.Cronograma   
	 SET FechaInicioFacturacion = @FechaFacturacion,   
		 FechaFinFacturacion = @FechaFacturacion,  
		 FechaInicioRefacturacion = @FechaRefacturacion,  
		 FechaFinRefacturacion = @FechaRefacturacion  
		FROM ods.Consultora CO  
		INNER JOIN ods.Zona Z ON Z.ZonaID = CO.ZonaID AND Z.RegionID = CO.RegionID  
		INNER JOIN ods.Cronograma CR ON CR.ZonaID = Z.ZonaID AND CR.RegionID = Z.RegionID  
		INNER JOIN ods.Campania CA ON CA.CampaniaID = CR.CampaniaID AND CA.Codigo = @CampaniaFlag  
			WHERE CO.AutorizaPedido = 1  
			AND CO.Codigo = @Consultora 
	
	IF (@CampaniaFlag < @CampaniaDeseado)
	BEGIN
		SET @DiasAntes = @DiasAntes-(-10)
	END
    ELSE IF(@CampaniaFlag > @CampaniaDeseado)
	BEGIN
		SET @DiasDespues = @DiasDespues + 10 
	END

	SET @Trabajo = @Trabajo + 1
END

SELECT @UltimaCampanaFacturada=ultimacampanafacturada, @CodigoConsultora=Codigo, @ConsultoraId=ConsultoraId FROM ods.Consultora WHERE Codigo = @Consultora  
  
IF (@UltimaCampanaFacturada >= @CampaniaDeseado)  
BEGIN  
 UPDATE ods.Consultora SET ultimacampanafacturada = @CampaniaFacturado WHERE Codigo=@CodigoConsultora  
 UPDATE ods.Consultora SET autorizapedido = 1 WHERE Codigo = @CodigoConsultora  
END  
  
UPDATE PedidoWeb SET IndicadorEnviado = 0 WHERE ConsultoraID=@ConsultoraId AND CampaniaID > @CampaniaFacturado  
UPDATE PedidoWeb SET ValidacionAbierta = 0 WHERE consultoraid=@ConsultoraId AND CampaniaID > @CampaniaFacturado  
  

SELECT CR.FechaInicioFacturacion,CR.FechaFinFacturacion,CR.FechaInicioReFacturacion,CR.FechaFinReFacturacion,CA.Codigo,CO.Codigo,* FROM ods.Consultora CO
INNER JOIN ods.Zona Z ON CO.ZonaID = Z.ZonaID AND CO.RegionID = Z.RegionID
INNER JOIN ods.Cronograma CR ON Z.ZonaID = CR.ZonaID AND Z.RegionID = CR.RegionID
INNER JOIN ods.Campania CA ON CR.CampaniaID = CA.CampaniaID AND CA.Codigo IN (SELECT Campania FROM @Campanias)
WHERE CO.AutorizaPedido = 1 AND CO.Codigo = @Consultora

GO

USE BelcorpSalvador
GO

IF EXISTS(SELECT 1 
          FROM   sys.procedures 
          WHERE  NAME = 'up_changecampaign') 
  BEGIN 
      DROP PROCEDURE dbo.up_changecampaign 
  END 
GO 

--EXEC up_changecampaign '000003581', 201902 
--INPUT  
CREATE PROCEDURE dbo.up_changecampaign
 @Consultora VARCHAR(25),  
 @CampaniaDeseado INT  
AS  
--ALGORITMO 
--DECLARE @Consultora VARCHAR(25) = '000003581' 
--DECLARE @CampaniaDeseado INT  = 201902

DECLARE @TemporalCampanias TABLE(Identificador INT IDENTITY(1,1), Campania CHAR(6)) 
DECLARE @Campanias TABLE(Identificador INT IDENTITY(1,1), Campania CHAR(6)) 
DECLARE @CampaniaIDCN INT = 0
DECLARE @CantidadTrabajo INT = 0
DECLARE @Trabajo INT = 1
DECLARE @CampaniaFlag INT = 0
DECLARE @FechaFacturacion SMALLDATETIME
DECLARE @FechaRefacturacion SMALLDATETIME
DECLARE @UltimaCampanaFacturada INT = 0
DECLARE @CodigoConsultora VARCHAR(25) = ''
DECLARE @ConsultoraId BIGINT = 0  
DECLARE @CampaniaFacturado INT= (@CampaniaDeseado-1)
DECLARE @DiasAntes INT = -30  
DECLARE @DiasDespues INT = 10
DECLARE @Identificador INT = 0

SELECT @CampaniaIDCN = CampaniaIDCN FROM ods.Campania WHERE Codigo = @CampaniaDeseado AND Activo = 1 

INSERT INTO @TemporalCampanias (Campania)
SELECT Codigo FROM ods.Campania WHERE CampaniaIDCN BETWEEN (@CampaniaIDCN - 6) AND (@CampaniaIDCN + 8) AND Activo = 1 

SET @Identificador = (SELECT Identificador FROM @TemporalCampanias WHERE Campania = @CampaniaDeseado)

INSERT INTO @Campanias (Campania)
SELECT Campania FROM @TemporalCampanias WHERE Identificador BETWEEN (@Identificador - 3) AND (@Identificador + 3)

SET @CantidadTrabajo = (SELECT COUNT(*) FROM @Campanias)

WHILE (@Trabajo <= @CantidadTrabajo) 
BEGIN
	SET @CampaniaFlag = (SELECT Campania FROM @Campanias WHERE Identificador = @Trabajo)

	IF (@CampaniaFlag < @CampaniaDeseado)
	BEGIN
		SET @FechaFacturacion = CONVERT(VARCHAR(10), GETDATE() - (@DiasAntes * -1), 121)
		SET @FechaRefacturacion = CONVERT(VARCHAR(10), GETDATE() - (@DiasAntes * -1), 121)
	END
    ELSE IF(@CampaniaFlag = @CampaniaDeseado)
	BEGIN
		SET @FechaFacturacion = CONVERT(VARCHAR(10), GETDATE(), 121)
		SET @FechaRefacturacion = CONVERT(VARCHAR(10), GETDATE(), 121)
	END
    ELSE IF(@CampaniaFlag > @CampaniaDeseado)
	BEGIN
		SET @FechaFacturacion = CONVERT(VARCHAR(10), GETDATE() + @DiasDespues, 121)
		SET @FechaRefacturacion = CONVERT(VARCHAR(10), GETDATE() + @DiasDespues, 121)
	END

	UPDATE ods.Cronograma   
	 SET FechaInicioFacturacion = @FechaFacturacion,   
		 FechaFinFacturacion = @FechaFacturacion,  
		 FechaInicioRefacturacion = @FechaRefacturacion,  
		 FechaFinRefacturacion = @FechaRefacturacion  
		FROM ods.Consultora CO  
		INNER JOIN ods.Zona Z ON Z.ZonaID = CO.ZonaID AND Z.RegionID = CO.RegionID  
		INNER JOIN ods.Cronograma CR ON CR.ZonaID = Z.ZonaID AND CR.RegionID = Z.RegionID  
		INNER JOIN ods.Campania CA ON CA.CampaniaID = CR.CampaniaID AND CA.Codigo = @CampaniaFlag  
			WHERE CO.AutorizaPedido = 1  
			AND CO.Codigo = @Consultora 
	
	IF (@CampaniaFlag < @CampaniaDeseado)
	BEGIN
		SET @DiasAntes = @DiasAntes-(-10)
	END
    ELSE IF(@CampaniaFlag > @CampaniaDeseado)
	BEGIN
		SET @DiasDespues = @DiasDespues + 10 
	END

	SET @Trabajo = @Trabajo + 1
END

SELECT @UltimaCampanaFacturada=ultimacampanafacturada, @CodigoConsultora=Codigo, @ConsultoraId=ConsultoraId FROM ods.Consultora WHERE Codigo = @Consultora  
  
IF (@UltimaCampanaFacturada >= @CampaniaDeseado)  
BEGIN  
 UPDATE ods.Consultora SET ultimacampanafacturada = @CampaniaFacturado WHERE Codigo=@CodigoConsultora  
 UPDATE ods.Consultora SET autorizapedido = 1 WHERE Codigo = @CodigoConsultora  
END  
  
UPDATE PedidoWeb SET IndicadorEnviado = 0 WHERE ConsultoraID=@ConsultoraId AND CampaniaID > @CampaniaFacturado  
UPDATE PedidoWeb SET ValidacionAbierta = 0 WHERE consultoraid=@ConsultoraId AND CampaniaID > @CampaniaFacturado  
  

SELECT CR.FechaInicioFacturacion,CR.FechaFinFacturacion,CR.FechaInicioReFacturacion,CR.FechaFinReFacturacion,CA.Codigo,CO.Codigo,* FROM ods.Consultora CO
INNER JOIN ods.Zona Z ON CO.ZonaID = Z.ZonaID AND CO.RegionID = Z.RegionID
INNER JOIN ods.Cronograma CR ON Z.ZonaID = CR.ZonaID AND Z.RegionID = CR.RegionID
INNER JOIN ods.Campania CA ON CR.CampaniaID = CA.CampaniaID AND CA.Codigo IN (SELECT Campania FROM @Campanias)
WHERE CO.AutorizaPedido = 1 AND CO.Codigo = @Consultora

GO

USE BelcorpPuertoRico
GO

IF EXISTS(SELECT 1 
          FROM   sys.procedures 
          WHERE  NAME = 'up_changecampaign') 
  BEGIN 
      DROP PROCEDURE dbo.up_changecampaign 
  END 
GO 

--EXEC up_changecampaign '000003581', 201902 
--INPUT  
CREATE PROCEDURE dbo.up_changecampaign
 @Consultora VARCHAR(25),  
 @CampaniaDeseado INT  
AS  
--ALGORITMO 
--DECLARE @Consultora VARCHAR(25) = '000003581' 
--DECLARE @CampaniaDeseado INT  = 201902

DECLARE @TemporalCampanias TABLE(Identificador INT IDENTITY(1,1), Campania CHAR(6)) 
DECLARE @Campanias TABLE(Identificador INT IDENTITY(1,1), Campania CHAR(6)) 
DECLARE @CampaniaIDCN INT = 0
DECLARE @CantidadTrabajo INT = 0
DECLARE @Trabajo INT = 1
DECLARE @CampaniaFlag INT = 0
DECLARE @FechaFacturacion SMALLDATETIME
DECLARE @FechaRefacturacion SMALLDATETIME
DECLARE @UltimaCampanaFacturada INT = 0
DECLARE @CodigoConsultora VARCHAR(25) = ''
DECLARE @ConsultoraId BIGINT = 0  
DECLARE @CampaniaFacturado INT= (@CampaniaDeseado-1)
DECLARE @DiasAntes INT = -30  
DECLARE @DiasDespues INT = 10
DECLARE @Identificador INT = 0

SELECT @CampaniaIDCN = CampaniaIDCN FROM ods.Campania WHERE Codigo = @CampaniaDeseado AND Activo = 1 

INSERT INTO @TemporalCampanias (Campania)
SELECT Codigo FROM ods.Campania WHERE CampaniaIDCN BETWEEN (@CampaniaIDCN - 6) AND (@CampaniaIDCN + 8) AND Activo = 1 

SET @Identificador = (SELECT Identificador FROM @TemporalCampanias WHERE Campania = @CampaniaDeseado)

INSERT INTO @Campanias (Campania)
SELECT Campania FROM @TemporalCampanias WHERE Identificador BETWEEN (@Identificador - 3) AND (@Identificador + 3)

SET @CantidadTrabajo = (SELECT COUNT(*) FROM @Campanias)

WHILE (@Trabajo <= @CantidadTrabajo) 
BEGIN
	SET @CampaniaFlag = (SELECT Campania FROM @Campanias WHERE Identificador = @Trabajo)

	IF (@CampaniaFlag < @CampaniaDeseado)
	BEGIN
		SET @FechaFacturacion = CONVERT(VARCHAR(10), GETDATE() - (@DiasAntes * -1), 121)
		SET @FechaRefacturacion = CONVERT(VARCHAR(10), GETDATE() - (@DiasAntes * -1), 121)
	END
    ELSE IF(@CampaniaFlag = @CampaniaDeseado)
	BEGIN
		SET @FechaFacturacion = CONVERT(VARCHAR(10), GETDATE(), 121)
		SET @FechaRefacturacion = CONVERT(VARCHAR(10), GETDATE(), 121)
	END
    ELSE IF(@CampaniaFlag > @CampaniaDeseado)
	BEGIN
		SET @FechaFacturacion = CONVERT(VARCHAR(10), GETDATE() + @DiasDespues, 121)
		SET @FechaRefacturacion = CONVERT(VARCHAR(10), GETDATE() + @DiasDespues, 121)
	END

	UPDATE ods.Cronograma   
	 SET FechaInicioFacturacion = @FechaFacturacion,   
		 FechaFinFacturacion = @FechaFacturacion,  
		 FechaInicioRefacturacion = @FechaRefacturacion,  
		 FechaFinRefacturacion = @FechaRefacturacion  
		FROM ods.Consultora CO  
		INNER JOIN ods.Zona Z ON Z.ZonaID = CO.ZonaID AND Z.RegionID = CO.RegionID  
		INNER JOIN ods.Cronograma CR ON CR.ZonaID = Z.ZonaID AND CR.RegionID = Z.RegionID  
		INNER JOIN ods.Campania CA ON CA.CampaniaID = CR.CampaniaID AND CA.Codigo = @CampaniaFlag  
			WHERE CO.AutorizaPedido = 1  
			AND CO.Codigo = @Consultora 
	
	IF (@CampaniaFlag < @CampaniaDeseado)
	BEGIN
		SET @DiasAntes = @DiasAntes-(-10)
	END
    ELSE IF(@CampaniaFlag > @CampaniaDeseado)
	BEGIN
		SET @DiasDespues = @DiasDespues + 10 
	END

	SET @Trabajo = @Trabajo + 1
END

SELECT @UltimaCampanaFacturada=ultimacampanafacturada, @CodigoConsultora=Codigo, @ConsultoraId=ConsultoraId FROM ods.Consultora WHERE Codigo = @Consultora  
  
IF (@UltimaCampanaFacturada >= @CampaniaDeseado)  
BEGIN  
 UPDATE ods.Consultora SET ultimacampanafacturada = @CampaniaFacturado WHERE Codigo=@CodigoConsultora  
 UPDATE ods.Consultora SET autorizapedido = 1 WHERE Codigo = @CodigoConsultora  
END  
  
UPDATE PedidoWeb SET IndicadorEnviado = 0 WHERE ConsultoraID=@ConsultoraId AND CampaniaID > @CampaniaFacturado  
UPDATE PedidoWeb SET ValidacionAbierta = 0 WHERE consultoraid=@ConsultoraId AND CampaniaID > @CampaniaFacturado  
  

SELECT CR.FechaInicioFacturacion,CR.FechaFinFacturacion,CR.FechaInicioReFacturacion,CR.FechaFinReFacturacion,CA.Codigo,CO.Codigo,* FROM ods.Consultora CO
INNER JOIN ods.Zona Z ON CO.ZonaID = Z.ZonaID AND CO.RegionID = Z.RegionID
INNER JOIN ods.Cronograma CR ON Z.ZonaID = CR.ZonaID AND Z.RegionID = CR.RegionID
INNER JOIN ods.Campania CA ON CR.CampaniaID = CA.CampaniaID AND CA.Codigo IN (SELECT Campania FROM @Campanias)
WHERE CO.AutorizaPedido = 1 AND CO.Codigo = @Consultora

GO

USE BelcorpPanama
GO

IF EXISTS(SELECT 1 
          FROM   sys.procedures 
          WHERE  NAME = 'up_changecampaign') 
  BEGIN 
      DROP PROCEDURE dbo.up_changecampaign 
  END 
GO 

--EXEC up_changecampaign '000003581', 201902 
--INPUT  
CREATE PROCEDURE dbo.up_changecampaign
 @Consultora VARCHAR(25),  
 @CampaniaDeseado INT  
AS  
--ALGORITMO 
--DECLARE @Consultora VARCHAR(25) = '000003581' 
--DECLARE @CampaniaDeseado INT  = 201902

DECLARE @TemporalCampanias TABLE(Identificador INT IDENTITY(1,1), Campania CHAR(6)) 
DECLARE @Campanias TABLE(Identificador INT IDENTITY(1,1), Campania CHAR(6)) 
DECLARE @CampaniaIDCN INT = 0
DECLARE @CantidadTrabajo INT = 0
DECLARE @Trabajo INT = 1
DECLARE @CampaniaFlag INT = 0
DECLARE @FechaFacturacion SMALLDATETIME
DECLARE @FechaRefacturacion SMALLDATETIME
DECLARE @UltimaCampanaFacturada INT = 0
DECLARE @CodigoConsultora VARCHAR(25) = ''
DECLARE @ConsultoraId BIGINT = 0  
DECLARE @CampaniaFacturado INT= (@CampaniaDeseado-1)
DECLARE @DiasAntes INT = -30  
DECLARE @DiasDespues INT = 10
DECLARE @Identificador INT = 0

SELECT @CampaniaIDCN = CampaniaIDCN FROM ods.Campania WHERE Codigo = @CampaniaDeseado AND Activo = 1 

INSERT INTO @TemporalCampanias (Campania)
SELECT Codigo FROM ods.Campania WHERE CampaniaIDCN BETWEEN (@CampaniaIDCN - 6) AND (@CampaniaIDCN + 8) AND Activo = 1 

SET @Identificador = (SELECT Identificador FROM @TemporalCampanias WHERE Campania = @CampaniaDeseado)

INSERT INTO @Campanias (Campania)
SELECT Campania FROM @TemporalCampanias WHERE Identificador BETWEEN (@Identificador - 3) AND (@Identificador + 3)

SET @CantidadTrabajo = (SELECT COUNT(*) FROM @Campanias)

WHILE (@Trabajo <= @CantidadTrabajo) 
BEGIN
	SET @CampaniaFlag = (SELECT Campania FROM @Campanias WHERE Identificador = @Trabajo)

	IF (@CampaniaFlag < @CampaniaDeseado)
	BEGIN
		SET @FechaFacturacion = CONVERT(VARCHAR(10), GETDATE() - (@DiasAntes * -1), 121)
		SET @FechaRefacturacion = CONVERT(VARCHAR(10), GETDATE() - (@DiasAntes * -1), 121)
	END
    ELSE IF(@CampaniaFlag = @CampaniaDeseado)
	BEGIN
		SET @FechaFacturacion = CONVERT(VARCHAR(10), GETDATE(), 121)
		SET @FechaRefacturacion = CONVERT(VARCHAR(10), GETDATE(), 121)
	END
    ELSE IF(@CampaniaFlag > @CampaniaDeseado)
	BEGIN
		SET @FechaFacturacion = CONVERT(VARCHAR(10), GETDATE() + @DiasDespues, 121)
		SET @FechaRefacturacion = CONVERT(VARCHAR(10), GETDATE() + @DiasDespues, 121)
	END

	UPDATE ods.Cronograma   
	 SET FechaInicioFacturacion = @FechaFacturacion,   
		 FechaFinFacturacion = @FechaFacturacion,  
		 FechaInicioRefacturacion = @FechaRefacturacion,  
		 FechaFinRefacturacion = @FechaRefacturacion  
		FROM ods.Consultora CO  
		INNER JOIN ods.Zona Z ON Z.ZonaID = CO.ZonaID AND Z.RegionID = CO.RegionID  
		INNER JOIN ods.Cronograma CR ON CR.ZonaID = Z.ZonaID AND CR.RegionID = Z.RegionID  
		INNER JOIN ods.Campania CA ON CA.CampaniaID = CR.CampaniaID AND CA.Codigo = @CampaniaFlag  
			WHERE CO.AutorizaPedido = 1  
			AND CO.Codigo = @Consultora 
	
	IF (@CampaniaFlag < @CampaniaDeseado)
	BEGIN
		SET @DiasAntes = @DiasAntes-(-10)
	END
    ELSE IF(@CampaniaFlag > @CampaniaDeseado)
	BEGIN
		SET @DiasDespues = @DiasDespues + 10 
	END

	SET @Trabajo = @Trabajo + 1
END

SELECT @UltimaCampanaFacturada=ultimacampanafacturada, @CodigoConsultora=Codigo, @ConsultoraId=ConsultoraId FROM ods.Consultora WHERE Codigo = @Consultora  
  
IF (@UltimaCampanaFacturada >= @CampaniaDeseado)  
BEGIN  
 UPDATE ods.Consultora SET ultimacampanafacturada = @CampaniaFacturado WHERE Codigo=@CodigoConsultora  
 UPDATE ods.Consultora SET autorizapedido = 1 WHERE Codigo = @CodigoConsultora  
END  
  
UPDATE PedidoWeb SET IndicadorEnviado = 0 WHERE ConsultoraID=@ConsultoraId AND CampaniaID > @CampaniaFacturado  
UPDATE PedidoWeb SET ValidacionAbierta = 0 WHERE consultoraid=@ConsultoraId AND CampaniaID > @CampaniaFacturado  
  

SELECT CR.FechaInicioFacturacion,CR.FechaFinFacturacion,CR.FechaInicioReFacturacion,CR.FechaFinReFacturacion,CA.Codigo,CO.Codigo,* FROM ods.Consultora CO
INNER JOIN ods.Zona Z ON CO.ZonaID = Z.ZonaID AND CO.RegionID = Z.RegionID
INNER JOIN ods.Cronograma CR ON Z.ZonaID = CR.ZonaID AND Z.RegionID = CR.RegionID
INNER JOIN ods.Campania CA ON CR.CampaniaID = CA.CampaniaID AND CA.Codigo IN (SELECT Campania FROM @Campanias)
WHERE CO.AutorizaPedido = 1 AND CO.Codigo = @Consultora

GO

USE BelcorpGuatemala
GO

IF EXISTS(SELECT 1 
          FROM   sys.procedures 
          WHERE  NAME = 'up_changecampaign') 
  BEGIN 
      DROP PROCEDURE dbo.up_changecampaign 
  END 
GO 

--EXEC up_changecampaign '000003581', 201902 
--INPUT  
CREATE PROCEDURE dbo.up_changecampaign
 @Consultora VARCHAR(25),  
 @CampaniaDeseado INT  
AS  
--ALGORITMO 
--DECLARE @Consultora VARCHAR(25) = '000003581' 
--DECLARE @CampaniaDeseado INT  = 201902

DECLARE @TemporalCampanias TABLE(Identificador INT IDENTITY(1,1), Campania CHAR(6)) 
DECLARE @Campanias TABLE(Identificador INT IDENTITY(1,1), Campania CHAR(6)) 
DECLARE @CampaniaIDCN INT = 0
DECLARE @CantidadTrabajo INT = 0
DECLARE @Trabajo INT = 1
DECLARE @CampaniaFlag INT = 0
DECLARE @FechaFacturacion SMALLDATETIME
DECLARE @FechaRefacturacion SMALLDATETIME
DECLARE @UltimaCampanaFacturada INT = 0
DECLARE @CodigoConsultora VARCHAR(25) = ''
DECLARE @ConsultoraId BIGINT = 0  
DECLARE @CampaniaFacturado INT= (@CampaniaDeseado-1)
DECLARE @DiasAntes INT = -30  
DECLARE @DiasDespues INT = 10
DECLARE @Identificador INT = 0

SELECT @CampaniaIDCN = CampaniaIDCN FROM ods.Campania WHERE Codigo = @CampaniaDeseado AND Activo = 1 

INSERT INTO @TemporalCampanias (Campania)
SELECT Codigo FROM ods.Campania WHERE CampaniaIDCN BETWEEN (@CampaniaIDCN - 6) AND (@CampaniaIDCN + 8) AND Activo = 1 

SET @Identificador = (SELECT Identificador FROM @TemporalCampanias WHERE Campania = @CampaniaDeseado)

INSERT INTO @Campanias (Campania)
SELECT Campania FROM @TemporalCampanias WHERE Identificador BETWEEN (@Identificador - 3) AND (@Identificador + 3)

SET @CantidadTrabajo = (SELECT COUNT(*) FROM @Campanias)

WHILE (@Trabajo <= @CantidadTrabajo) 
BEGIN
	SET @CampaniaFlag = (SELECT Campania FROM @Campanias WHERE Identificador = @Trabajo)

	IF (@CampaniaFlag < @CampaniaDeseado)
	BEGIN
		SET @FechaFacturacion = CONVERT(VARCHAR(10), GETDATE() - (@DiasAntes * -1), 121)
		SET @FechaRefacturacion = CONVERT(VARCHAR(10), GETDATE() - (@DiasAntes * -1), 121)
	END
    ELSE IF(@CampaniaFlag = @CampaniaDeseado)
	BEGIN
		SET @FechaFacturacion = CONVERT(VARCHAR(10), GETDATE(), 121)
		SET @FechaRefacturacion = CONVERT(VARCHAR(10), GETDATE(), 121)
	END
    ELSE IF(@CampaniaFlag > @CampaniaDeseado)
	BEGIN
		SET @FechaFacturacion = CONVERT(VARCHAR(10), GETDATE() + @DiasDespues, 121)
		SET @FechaRefacturacion = CONVERT(VARCHAR(10), GETDATE() + @DiasDespues, 121)
	END

	UPDATE ods.Cronograma   
	 SET FechaInicioFacturacion = @FechaFacturacion,   
		 FechaFinFacturacion = @FechaFacturacion,  
		 FechaInicioRefacturacion = @FechaRefacturacion,  
		 FechaFinRefacturacion = @FechaRefacturacion  
		FROM ods.Consultora CO  
		INNER JOIN ods.Zona Z ON Z.ZonaID = CO.ZonaID AND Z.RegionID = CO.RegionID  
		INNER JOIN ods.Cronograma CR ON CR.ZonaID = Z.ZonaID AND CR.RegionID = Z.RegionID  
		INNER JOIN ods.Campania CA ON CA.CampaniaID = CR.CampaniaID AND CA.Codigo = @CampaniaFlag  
			WHERE CO.AutorizaPedido = 1  
			AND CO.Codigo = @Consultora 
	
	IF (@CampaniaFlag < @CampaniaDeseado)
	BEGIN
		SET @DiasAntes = @DiasAntes-(-10)
	END
    ELSE IF(@CampaniaFlag > @CampaniaDeseado)
	BEGIN
		SET @DiasDespues = @DiasDespues + 10 
	END

	SET @Trabajo = @Trabajo + 1
END

SELECT @UltimaCampanaFacturada=ultimacampanafacturada, @CodigoConsultora=Codigo, @ConsultoraId=ConsultoraId FROM ods.Consultora WHERE Codigo = @Consultora  
  
IF (@UltimaCampanaFacturada >= @CampaniaDeseado)  
BEGIN  
 UPDATE ods.Consultora SET ultimacampanafacturada = @CampaniaFacturado WHERE Codigo=@CodigoConsultora  
 UPDATE ods.Consultora SET autorizapedido = 1 WHERE Codigo = @CodigoConsultora  
END  
  
UPDATE PedidoWeb SET IndicadorEnviado = 0 WHERE ConsultoraID=@ConsultoraId AND CampaniaID > @CampaniaFacturado  
UPDATE PedidoWeb SET ValidacionAbierta = 0 WHERE consultoraid=@ConsultoraId AND CampaniaID > @CampaniaFacturado  
  

SELECT CR.FechaInicioFacturacion,CR.FechaFinFacturacion,CR.FechaInicioReFacturacion,CR.FechaFinReFacturacion,CA.Codigo,CO.Codigo,* FROM ods.Consultora CO
INNER JOIN ods.Zona Z ON CO.ZonaID = Z.ZonaID AND CO.RegionID = Z.RegionID
INNER JOIN ods.Cronograma CR ON Z.ZonaID = CR.ZonaID AND Z.RegionID = CR.RegionID
INNER JOIN ods.Campania CA ON CR.CampaniaID = CA.CampaniaID AND CA.Codigo IN (SELECT Campania FROM @Campanias)
WHERE CO.AutorizaPedido = 1 AND CO.Codigo = @Consultora

GO

USE BelcorpEcuador
GO

IF EXISTS(SELECT 1 
          FROM   sys.procedures 
          WHERE  NAME = 'up_changecampaign') 
  BEGIN 
      DROP PROCEDURE dbo.up_changecampaign 
  END 
GO 

--EXEC up_changecampaign '000003581', 201902 
--INPUT  
CREATE PROCEDURE dbo.up_changecampaign
 @Consultora VARCHAR(25),  
 @CampaniaDeseado INT  
AS  
--ALGORITMO 
--DECLARE @Consultora VARCHAR(25) = '000003581' 
--DECLARE @CampaniaDeseado INT  = 201902

DECLARE @TemporalCampanias TABLE(Identificador INT IDENTITY(1,1), Campania CHAR(6)) 
DECLARE @Campanias TABLE(Identificador INT IDENTITY(1,1), Campania CHAR(6)) 
DECLARE @CampaniaIDCN INT = 0
DECLARE @CantidadTrabajo INT = 0
DECLARE @Trabajo INT = 1
DECLARE @CampaniaFlag INT = 0
DECLARE @FechaFacturacion SMALLDATETIME
DECLARE @FechaRefacturacion SMALLDATETIME
DECLARE @UltimaCampanaFacturada INT = 0
DECLARE @CodigoConsultora VARCHAR(25) = ''
DECLARE @ConsultoraId BIGINT = 0  
DECLARE @CampaniaFacturado INT= (@CampaniaDeseado-1)
DECLARE @DiasAntes INT = -30  
DECLARE @DiasDespues INT = 10
DECLARE @Identificador INT = 0

SELECT @CampaniaIDCN = CampaniaIDCN FROM ods.Campania WHERE Codigo = @CampaniaDeseado AND Activo = 1 

INSERT INTO @TemporalCampanias (Campania)
SELECT Codigo FROM ods.Campania WHERE CampaniaIDCN BETWEEN (@CampaniaIDCN - 6) AND (@CampaniaIDCN + 8) AND Activo = 1 

SET @Identificador = (SELECT Identificador FROM @TemporalCampanias WHERE Campania = @CampaniaDeseado)

INSERT INTO @Campanias (Campania)
SELECT Campania FROM @TemporalCampanias WHERE Identificador BETWEEN (@Identificador - 3) AND (@Identificador + 3)

SET @CantidadTrabajo = (SELECT COUNT(*) FROM @Campanias)

WHILE (@Trabajo <= @CantidadTrabajo) 
BEGIN
	SET @CampaniaFlag = (SELECT Campania FROM @Campanias WHERE Identificador = @Trabajo)

	IF (@CampaniaFlag < @CampaniaDeseado)
	BEGIN
		SET @FechaFacturacion = CONVERT(VARCHAR(10), GETDATE() - (@DiasAntes * -1), 121)
		SET @FechaRefacturacion = CONVERT(VARCHAR(10), GETDATE() - (@DiasAntes * -1), 121)
	END
    ELSE IF(@CampaniaFlag = @CampaniaDeseado)
	BEGIN
		SET @FechaFacturacion = CONVERT(VARCHAR(10), GETDATE(), 121)
		SET @FechaRefacturacion = CONVERT(VARCHAR(10), GETDATE(), 121)
	END
    ELSE IF(@CampaniaFlag > @CampaniaDeseado)
	BEGIN
		SET @FechaFacturacion = CONVERT(VARCHAR(10), GETDATE() + @DiasDespues, 121)
		SET @FechaRefacturacion = CONVERT(VARCHAR(10), GETDATE() + @DiasDespues, 121)
	END

	UPDATE ods.Cronograma   
	 SET FechaInicioFacturacion = @FechaFacturacion,   
		 FechaFinFacturacion = @FechaFacturacion,  
		 FechaInicioRefacturacion = @FechaRefacturacion,  
		 FechaFinRefacturacion = @FechaRefacturacion  
		FROM ods.Consultora CO  
		INNER JOIN ods.Zona Z ON Z.ZonaID = CO.ZonaID AND Z.RegionID = CO.RegionID  
		INNER JOIN ods.Cronograma CR ON CR.ZonaID = Z.ZonaID AND CR.RegionID = Z.RegionID  
		INNER JOIN ods.Campania CA ON CA.CampaniaID = CR.CampaniaID AND CA.Codigo = @CampaniaFlag  
			WHERE CO.AutorizaPedido = 1  
			AND CO.Codigo = @Consultora 
	
	IF (@CampaniaFlag < @CampaniaDeseado)
	BEGIN
		SET @DiasAntes = @DiasAntes-(-10)
	END
    ELSE IF(@CampaniaFlag > @CampaniaDeseado)
	BEGIN
		SET @DiasDespues = @DiasDespues + 10 
	END

	SET @Trabajo = @Trabajo + 1
END

SELECT @UltimaCampanaFacturada=ultimacampanafacturada, @CodigoConsultora=Codigo, @ConsultoraId=ConsultoraId FROM ods.Consultora WHERE Codigo = @Consultora  
  
IF (@UltimaCampanaFacturada >= @CampaniaDeseado)  
BEGIN  
 UPDATE ods.Consultora SET ultimacampanafacturada = @CampaniaFacturado WHERE Codigo=@CodigoConsultora  
 UPDATE ods.Consultora SET autorizapedido = 1 WHERE Codigo = @CodigoConsultora  
END  
  
UPDATE PedidoWeb SET IndicadorEnviado = 0 WHERE ConsultoraID=@ConsultoraId AND CampaniaID > @CampaniaFacturado  
UPDATE PedidoWeb SET ValidacionAbierta = 0 WHERE consultoraid=@ConsultoraId AND CampaniaID > @CampaniaFacturado  
  

SELECT CR.FechaInicioFacturacion,CR.FechaFinFacturacion,CR.FechaInicioReFacturacion,CR.FechaFinReFacturacion,CA.Codigo,CO.Codigo,* FROM ods.Consultora CO
INNER JOIN ods.Zona Z ON CO.ZonaID = Z.ZonaID AND CO.RegionID = Z.RegionID
INNER JOIN ods.Cronograma CR ON Z.ZonaID = CR.ZonaID AND Z.RegionID = CR.RegionID
INNER JOIN ods.Campania CA ON CR.CampaniaID = CA.CampaniaID AND CA.Codigo IN (SELECT Campania FROM @Campanias)
WHERE CO.AutorizaPedido = 1 AND CO.Codigo = @Consultora

GO

USE BelcorpDominicana
GO

IF EXISTS(SELECT 1 
          FROM   sys.procedures 
          WHERE  NAME = 'up_changecampaign') 
  BEGIN 
      DROP PROCEDURE dbo.up_changecampaign 
  END 
GO 

--EXEC up_changecampaign '000003581', 201902 
--INPUT  
CREATE PROCEDURE dbo.up_changecampaign
 @Consultora VARCHAR(25),  
 @CampaniaDeseado INT  
AS  
--ALGORITMO 
--DECLARE @Consultora VARCHAR(25) = '000003581' 
--DECLARE @CampaniaDeseado INT  = 201902

DECLARE @TemporalCampanias TABLE(Identificador INT IDENTITY(1,1), Campania CHAR(6)) 
DECLARE @Campanias TABLE(Identificador INT IDENTITY(1,1), Campania CHAR(6)) 
DECLARE @CampaniaIDCN INT = 0
DECLARE @CantidadTrabajo INT = 0
DECLARE @Trabajo INT = 1
DECLARE @CampaniaFlag INT = 0
DECLARE @FechaFacturacion SMALLDATETIME
DECLARE @FechaRefacturacion SMALLDATETIME
DECLARE @UltimaCampanaFacturada INT = 0
DECLARE @CodigoConsultora VARCHAR(25) = ''
DECLARE @ConsultoraId BIGINT = 0  
DECLARE @CampaniaFacturado INT= (@CampaniaDeseado-1)
DECLARE @DiasAntes INT = -30  
DECLARE @DiasDespues INT = 10
DECLARE @Identificador INT = 0

SELECT @CampaniaIDCN = CampaniaIDCN FROM ods.Campania WHERE Codigo = @CampaniaDeseado AND Activo = 1 

INSERT INTO @TemporalCampanias (Campania)
SELECT Codigo FROM ods.Campania WHERE CampaniaIDCN BETWEEN (@CampaniaIDCN - 6) AND (@CampaniaIDCN + 8) AND Activo = 1 

SET @Identificador = (SELECT Identificador FROM @TemporalCampanias WHERE Campania = @CampaniaDeseado)

INSERT INTO @Campanias (Campania)
SELECT Campania FROM @TemporalCampanias WHERE Identificador BETWEEN (@Identificador - 3) AND (@Identificador + 3)

SET @CantidadTrabajo = (SELECT COUNT(*) FROM @Campanias)

WHILE (@Trabajo <= @CantidadTrabajo) 
BEGIN
	SET @CampaniaFlag = (SELECT Campania FROM @Campanias WHERE Identificador = @Trabajo)

	IF (@CampaniaFlag < @CampaniaDeseado)
	BEGIN
		SET @FechaFacturacion = CONVERT(VARCHAR(10), GETDATE() - (@DiasAntes * -1), 121)
		SET @FechaRefacturacion = CONVERT(VARCHAR(10), GETDATE() - (@DiasAntes * -1), 121)
	END
    ELSE IF(@CampaniaFlag = @CampaniaDeseado)
	BEGIN
		SET @FechaFacturacion = CONVERT(VARCHAR(10), GETDATE(), 121)
		SET @FechaRefacturacion = CONVERT(VARCHAR(10), GETDATE(), 121)
	END
    ELSE IF(@CampaniaFlag > @CampaniaDeseado)
	BEGIN
		SET @FechaFacturacion = CONVERT(VARCHAR(10), GETDATE() + @DiasDespues, 121)
		SET @FechaRefacturacion = CONVERT(VARCHAR(10), GETDATE() + @DiasDespues, 121)
	END

	UPDATE ods.Cronograma   
	 SET FechaInicioFacturacion = @FechaFacturacion,   
		 FechaFinFacturacion = @FechaFacturacion,  
		 FechaInicioRefacturacion = @FechaRefacturacion,  
		 FechaFinRefacturacion = @FechaRefacturacion  
		FROM ods.Consultora CO  
		INNER JOIN ods.Zona Z ON Z.ZonaID = CO.ZonaID AND Z.RegionID = CO.RegionID  
		INNER JOIN ods.Cronograma CR ON CR.ZonaID = Z.ZonaID AND CR.RegionID = Z.RegionID  
		INNER JOIN ods.Campania CA ON CA.CampaniaID = CR.CampaniaID AND CA.Codigo = @CampaniaFlag  
			WHERE CO.AutorizaPedido = 1  
			AND CO.Codigo = @Consultora 
	
	IF (@CampaniaFlag < @CampaniaDeseado)
	BEGIN
		SET @DiasAntes = @DiasAntes-(-10)
	END
    ELSE IF(@CampaniaFlag > @CampaniaDeseado)
	BEGIN
		SET @DiasDespues = @DiasDespues + 10 
	END

	SET @Trabajo = @Trabajo + 1
END

SELECT @UltimaCampanaFacturada=ultimacampanafacturada, @CodigoConsultora=Codigo, @ConsultoraId=ConsultoraId FROM ods.Consultora WHERE Codigo = @Consultora  
  
IF (@UltimaCampanaFacturada >= @CampaniaDeseado)  
BEGIN  
 UPDATE ods.Consultora SET ultimacampanafacturada = @CampaniaFacturado WHERE Codigo=@CodigoConsultora  
 UPDATE ods.Consultora SET autorizapedido = 1 WHERE Codigo = @CodigoConsultora  
END  
  
UPDATE PedidoWeb SET IndicadorEnviado = 0 WHERE ConsultoraID=@ConsultoraId AND CampaniaID > @CampaniaFacturado  
UPDATE PedidoWeb SET ValidacionAbierta = 0 WHERE consultoraid=@ConsultoraId AND CampaniaID > @CampaniaFacturado  
  

SELECT CR.FechaInicioFacturacion,CR.FechaFinFacturacion,CR.FechaInicioReFacturacion,CR.FechaFinReFacturacion,CA.Codigo,CO.Codigo,* FROM ods.Consultora CO
INNER JOIN ods.Zona Z ON CO.ZonaID = Z.ZonaID AND CO.RegionID = Z.RegionID
INNER JOIN ods.Cronograma CR ON Z.ZonaID = CR.ZonaID AND Z.RegionID = CR.RegionID
INNER JOIN ods.Campania CA ON CR.CampaniaID = CA.CampaniaID AND CA.Codigo IN (SELECT Campania FROM @Campanias)
WHERE CO.AutorizaPedido = 1 AND CO.Codigo = @Consultora

GO

USE BelcorpCostaRica
GO

IF EXISTS(SELECT 1 
          FROM   sys.procedures 
          WHERE  NAME = 'up_changecampaign') 
  BEGIN 
      DROP PROCEDURE dbo.up_changecampaign 
  END 
GO 

--EXEC up_changecampaign '000003581', 201902 
--INPUT  
CREATE PROCEDURE dbo.up_changecampaign
 @Consultora VARCHAR(25),  
 @CampaniaDeseado INT  
AS  
--ALGORITMO 
--DECLARE @Consultora VARCHAR(25) = '000003581' 
--DECLARE @CampaniaDeseado INT  = 201902

DECLARE @TemporalCampanias TABLE(Identificador INT IDENTITY(1,1), Campania CHAR(6)) 
DECLARE @Campanias TABLE(Identificador INT IDENTITY(1,1), Campania CHAR(6)) 
DECLARE @CampaniaIDCN INT = 0
DECLARE @CantidadTrabajo INT = 0
DECLARE @Trabajo INT = 1
DECLARE @CampaniaFlag INT = 0
DECLARE @FechaFacturacion SMALLDATETIME
DECLARE @FechaRefacturacion SMALLDATETIME
DECLARE @UltimaCampanaFacturada INT = 0
DECLARE @CodigoConsultora VARCHAR(25) = ''
DECLARE @ConsultoraId BIGINT = 0  
DECLARE @CampaniaFacturado INT= (@CampaniaDeseado-1)
DECLARE @DiasAntes INT = -30  
DECLARE @DiasDespues INT = 10
DECLARE @Identificador INT = 0

SELECT @CampaniaIDCN = CampaniaIDCN FROM ods.Campania WHERE Codigo = @CampaniaDeseado AND Activo = 1 

INSERT INTO @TemporalCampanias (Campania)
SELECT Codigo FROM ods.Campania WHERE CampaniaIDCN BETWEEN (@CampaniaIDCN - 6) AND (@CampaniaIDCN + 8) AND Activo = 1 

SET @Identificador = (SELECT Identificador FROM @TemporalCampanias WHERE Campania = @CampaniaDeseado)

INSERT INTO @Campanias (Campania)
SELECT Campania FROM @TemporalCampanias WHERE Identificador BETWEEN (@Identificador - 3) AND (@Identificador + 3)

SET @CantidadTrabajo = (SELECT COUNT(*) FROM @Campanias)

WHILE (@Trabajo <= @CantidadTrabajo) 
BEGIN
	SET @CampaniaFlag = (SELECT Campania FROM @Campanias WHERE Identificador = @Trabajo)

	IF (@CampaniaFlag < @CampaniaDeseado)
	BEGIN
		SET @FechaFacturacion = CONVERT(VARCHAR(10), GETDATE() - (@DiasAntes * -1), 121)
		SET @FechaRefacturacion = CONVERT(VARCHAR(10), GETDATE() - (@DiasAntes * -1), 121)
	END
    ELSE IF(@CampaniaFlag = @CampaniaDeseado)
	BEGIN
		SET @FechaFacturacion = CONVERT(VARCHAR(10), GETDATE(), 121)
		SET @FechaRefacturacion = CONVERT(VARCHAR(10), GETDATE(), 121)
	END
    ELSE IF(@CampaniaFlag > @CampaniaDeseado)
	BEGIN
		SET @FechaFacturacion = CONVERT(VARCHAR(10), GETDATE() + @DiasDespues, 121)
		SET @FechaRefacturacion = CONVERT(VARCHAR(10), GETDATE() + @DiasDespues, 121)
	END

	UPDATE ods.Cronograma   
	 SET FechaInicioFacturacion = @FechaFacturacion,   
		 FechaFinFacturacion = @FechaFacturacion,  
		 FechaInicioRefacturacion = @FechaRefacturacion,  
		 FechaFinRefacturacion = @FechaRefacturacion  
		FROM ods.Consultora CO  
		INNER JOIN ods.Zona Z ON Z.ZonaID = CO.ZonaID AND Z.RegionID = CO.RegionID  
		INNER JOIN ods.Cronograma CR ON CR.ZonaID = Z.ZonaID AND CR.RegionID = Z.RegionID  
		INNER JOIN ods.Campania CA ON CA.CampaniaID = CR.CampaniaID AND CA.Codigo = @CampaniaFlag  
			WHERE CO.AutorizaPedido = 1  
			AND CO.Codigo = @Consultora 
	
	IF (@CampaniaFlag < @CampaniaDeseado)
	BEGIN
		SET @DiasAntes = @DiasAntes-(-10)
	END
    ELSE IF(@CampaniaFlag > @CampaniaDeseado)
	BEGIN
		SET @DiasDespues = @DiasDespues + 10 
	END

	SET @Trabajo = @Trabajo + 1
END

SELECT @UltimaCampanaFacturada=ultimacampanafacturada, @CodigoConsultora=Codigo, @ConsultoraId=ConsultoraId FROM ods.Consultora WHERE Codigo = @Consultora  
  
IF (@UltimaCampanaFacturada >= @CampaniaDeseado)  
BEGIN  
 UPDATE ods.Consultora SET ultimacampanafacturada = @CampaniaFacturado WHERE Codigo=@CodigoConsultora  
 UPDATE ods.Consultora SET autorizapedido = 1 WHERE Codigo = @CodigoConsultora  
END  
  
UPDATE PedidoWeb SET IndicadorEnviado = 0 WHERE ConsultoraID=@ConsultoraId AND CampaniaID > @CampaniaFacturado  
UPDATE PedidoWeb SET ValidacionAbierta = 0 WHERE consultoraid=@ConsultoraId AND CampaniaID > @CampaniaFacturado  
  

SELECT CR.FechaInicioFacturacion,CR.FechaFinFacturacion,CR.FechaInicioReFacturacion,CR.FechaFinReFacturacion,CA.Codigo,CO.Codigo,* FROM ods.Consultora CO
INNER JOIN ods.Zona Z ON CO.ZonaID = Z.ZonaID AND CO.RegionID = Z.RegionID
INNER JOIN ods.Cronograma CR ON Z.ZonaID = CR.ZonaID AND Z.RegionID = CR.RegionID
INNER JOIN ods.Campania CA ON CR.CampaniaID = CA.CampaniaID AND CA.Codigo IN (SELECT Campania FROM @Campanias)
WHERE CO.AutorizaPedido = 1 AND CO.Codigo = @Consultora

GO

USE BelcorpChile
GO

IF EXISTS(SELECT 1 
          FROM   sys.procedures 
          WHERE  NAME = 'up_changecampaign') 
  BEGIN 
      DROP PROCEDURE dbo.up_changecampaign 
  END 
GO 

--EXEC up_changecampaign '000003581', 201902 
--INPUT  
CREATE PROCEDURE dbo.up_changecampaign
 @Consultora VARCHAR(25),  
 @CampaniaDeseado INT  
AS  
--ALGORITMO 
--DECLARE @Consultora VARCHAR(25) = '000003581' 
--DECLARE @CampaniaDeseado INT  = 201902

DECLARE @TemporalCampanias TABLE(Identificador INT IDENTITY(1,1), Campania CHAR(6)) 
DECLARE @Campanias TABLE(Identificador INT IDENTITY(1,1), Campania CHAR(6)) 
DECLARE @CampaniaIDCN INT = 0
DECLARE @CantidadTrabajo INT = 0
DECLARE @Trabajo INT = 1
DECLARE @CampaniaFlag INT = 0
DECLARE @FechaFacturacion SMALLDATETIME
DECLARE @FechaRefacturacion SMALLDATETIME
DECLARE @UltimaCampanaFacturada INT = 0
DECLARE @CodigoConsultora VARCHAR(25) = ''
DECLARE @ConsultoraId BIGINT = 0  
DECLARE @CampaniaFacturado INT= (@CampaniaDeseado-1)
DECLARE @DiasAntes INT = -30  
DECLARE @DiasDespues INT = 10
DECLARE @Identificador INT = 0

SELECT @CampaniaIDCN = CampaniaIDCN FROM ods.Campania WHERE Codigo = @CampaniaDeseado AND Activo = 1 

INSERT INTO @TemporalCampanias (Campania)
SELECT Codigo FROM ods.Campania WHERE CampaniaIDCN BETWEEN (@CampaniaIDCN - 6) AND (@CampaniaIDCN + 8) AND Activo = 1 

SET @Identificador = (SELECT Identificador FROM @TemporalCampanias WHERE Campania = @CampaniaDeseado)

INSERT INTO @Campanias (Campania)
SELECT Campania FROM @TemporalCampanias WHERE Identificador BETWEEN (@Identificador - 3) AND (@Identificador + 3)

SET @CantidadTrabajo = (SELECT COUNT(*) FROM @Campanias)

WHILE (@Trabajo <= @CantidadTrabajo) 
BEGIN
	SET @CampaniaFlag = (SELECT Campania FROM @Campanias WHERE Identificador = @Trabajo)

	IF (@CampaniaFlag < @CampaniaDeseado)
	BEGIN
		SET @FechaFacturacion = CONVERT(VARCHAR(10), GETDATE() - (@DiasAntes * -1), 121)
		SET @FechaRefacturacion = CONVERT(VARCHAR(10), GETDATE() - (@DiasAntes * -1), 121)
	END
    ELSE IF(@CampaniaFlag = @CampaniaDeseado)
	BEGIN
		SET @FechaFacturacion = CONVERT(VARCHAR(10), GETDATE(), 121)
		SET @FechaRefacturacion = CONVERT(VARCHAR(10), GETDATE(), 121)
	END
    ELSE IF(@CampaniaFlag > @CampaniaDeseado)
	BEGIN
		SET @FechaFacturacion = CONVERT(VARCHAR(10), GETDATE() + @DiasDespues, 121)
		SET @FechaRefacturacion = CONVERT(VARCHAR(10), GETDATE() + @DiasDespues, 121)
	END

	UPDATE ods.Cronograma   
	 SET FechaInicioFacturacion = @FechaFacturacion,   
		 FechaFinFacturacion = @FechaFacturacion,  
		 FechaInicioRefacturacion = @FechaRefacturacion,  
		 FechaFinRefacturacion = @FechaRefacturacion  
		FROM ods.Consultora CO  
		INNER JOIN ods.Zona Z ON Z.ZonaID = CO.ZonaID AND Z.RegionID = CO.RegionID  
		INNER JOIN ods.Cronograma CR ON CR.ZonaID = Z.ZonaID AND CR.RegionID = Z.RegionID  
		INNER JOIN ods.Campania CA ON CA.CampaniaID = CR.CampaniaID AND CA.Codigo = @CampaniaFlag  
			WHERE CO.AutorizaPedido = 1  
			AND CO.Codigo = @Consultora 
	
	IF (@CampaniaFlag < @CampaniaDeseado)
	BEGIN
		SET @DiasAntes = @DiasAntes-(-10)
	END
    ELSE IF(@CampaniaFlag > @CampaniaDeseado)
	BEGIN
		SET @DiasDespues = @DiasDespues + 10 
	END

	SET @Trabajo = @Trabajo + 1
END

SELECT @UltimaCampanaFacturada=ultimacampanafacturada, @CodigoConsultora=Codigo, @ConsultoraId=ConsultoraId FROM ods.Consultora WHERE Codigo = @Consultora  
  
IF (@UltimaCampanaFacturada >= @CampaniaDeseado)  
BEGIN  
 UPDATE ods.Consultora SET ultimacampanafacturada = @CampaniaFacturado WHERE Codigo=@CodigoConsultora  
 UPDATE ods.Consultora SET autorizapedido = 1 WHERE Codigo = @CodigoConsultora  
END  
  
UPDATE PedidoWeb SET IndicadorEnviado = 0 WHERE ConsultoraID=@ConsultoraId AND CampaniaID > @CampaniaFacturado  
UPDATE PedidoWeb SET ValidacionAbierta = 0 WHERE consultoraid=@ConsultoraId AND CampaniaID > @CampaniaFacturado  
  

SELECT CR.FechaInicioFacturacion,CR.FechaFinFacturacion,CR.FechaInicioReFacturacion,CR.FechaFinReFacturacion,CA.Codigo,CO.Codigo,* FROM ods.Consultora CO
INNER JOIN ods.Zona Z ON CO.ZonaID = Z.ZonaID AND CO.RegionID = Z.RegionID
INNER JOIN ods.Cronograma CR ON Z.ZonaID = CR.ZonaID AND Z.RegionID = CR.RegionID
INNER JOIN ods.Campania CA ON CR.CampaniaID = CA.CampaniaID AND CA.Codigo IN (SELECT Campania FROM @Campanias)
WHERE CO.AutorizaPedido = 1 AND CO.Codigo = @Consultora

GO

USE BelcorpBolivia
GO

IF EXISTS(SELECT 1 
          FROM   sys.procedures 
          WHERE  NAME = 'up_changecampaign') 
  BEGIN 
      DROP PROCEDURE dbo.up_changecampaign 
  END 
GO 

--EXEC up_changecampaign '000003581', 201902 
--INPUT  
CREATE PROCEDURE dbo.up_changecampaign
 @Consultora VARCHAR(25),  
 @CampaniaDeseado INT  
AS  
--ALGORITMO 
--DECLARE @Consultora VARCHAR(25) = '000003581' 
--DECLARE @CampaniaDeseado INT  = 201902

DECLARE @TemporalCampanias TABLE(Identificador INT IDENTITY(1,1), Campania CHAR(6)) 
DECLARE @Campanias TABLE(Identificador INT IDENTITY(1,1), Campania CHAR(6)) 
DECLARE @CampaniaIDCN INT = 0
DECLARE @CantidadTrabajo INT = 0
DECLARE @Trabajo INT = 1
DECLARE @CampaniaFlag INT = 0
DECLARE @FechaFacturacion SMALLDATETIME
DECLARE @FechaRefacturacion SMALLDATETIME
DECLARE @UltimaCampanaFacturada INT = 0
DECLARE @CodigoConsultora VARCHAR(25) = ''
DECLARE @ConsultoraId BIGINT = 0  
DECLARE @CampaniaFacturado INT= (@CampaniaDeseado-1)
DECLARE @DiasAntes INT = -30  
DECLARE @DiasDespues INT = 10
DECLARE @Identificador INT = 0

SELECT @CampaniaIDCN = CampaniaIDCN FROM ods.Campania WHERE Codigo = @CampaniaDeseado AND Activo = 1 

INSERT INTO @TemporalCampanias (Campania)
SELECT Codigo FROM ods.Campania WHERE CampaniaIDCN BETWEEN (@CampaniaIDCN - 6) AND (@CampaniaIDCN + 8) AND Activo = 1 

SET @Identificador = (SELECT Identificador FROM @TemporalCampanias WHERE Campania = @CampaniaDeseado)

INSERT INTO @Campanias (Campania)
SELECT Campania FROM @TemporalCampanias WHERE Identificador BETWEEN (@Identificador - 3) AND (@Identificador + 3)

SET @CantidadTrabajo = (SELECT COUNT(*) FROM @Campanias)

WHILE (@Trabajo <= @CantidadTrabajo) 
BEGIN
	SET @CampaniaFlag = (SELECT Campania FROM @Campanias WHERE Identificador = @Trabajo)

	IF (@CampaniaFlag < @CampaniaDeseado)
	BEGIN
		SET @FechaFacturacion = CONVERT(VARCHAR(10), GETDATE() - (@DiasAntes * -1), 121)
		SET @FechaRefacturacion = CONVERT(VARCHAR(10), GETDATE() - (@DiasAntes * -1), 121)
	END
    ELSE IF(@CampaniaFlag = @CampaniaDeseado)
	BEGIN
		SET @FechaFacturacion = CONVERT(VARCHAR(10), GETDATE(), 121)
		SET @FechaRefacturacion = CONVERT(VARCHAR(10), GETDATE(), 121)
	END
    ELSE IF(@CampaniaFlag > @CampaniaDeseado)
	BEGIN
		SET @FechaFacturacion = CONVERT(VARCHAR(10), GETDATE() + @DiasDespues, 121)
		SET @FechaRefacturacion = CONVERT(VARCHAR(10), GETDATE() + @DiasDespues, 121)
	END

	UPDATE ods.Cronograma   
	 SET FechaInicioFacturacion = @FechaFacturacion,   
		 FechaFinFacturacion = @FechaFacturacion,  
		 FechaInicioRefacturacion = @FechaRefacturacion,  
		 FechaFinRefacturacion = @FechaRefacturacion  
		FROM ods.Consultora CO  
		INNER JOIN ods.Zona Z ON Z.ZonaID = CO.ZonaID AND Z.RegionID = CO.RegionID  
		INNER JOIN ods.Cronograma CR ON CR.ZonaID = Z.ZonaID AND CR.RegionID = Z.RegionID  
		INNER JOIN ods.Campania CA ON CA.CampaniaID = CR.CampaniaID AND CA.Codigo = @CampaniaFlag  
			WHERE CO.AutorizaPedido = 1  
			AND CO.Codigo = @Consultora 
	
	IF (@CampaniaFlag < @CampaniaDeseado)
	BEGIN
		SET @DiasAntes = @DiasAntes-(-10)
	END
    ELSE IF(@CampaniaFlag > @CampaniaDeseado)
	BEGIN
		SET @DiasDespues = @DiasDespues + 10 
	END

	SET @Trabajo = @Trabajo + 1
END

SELECT @UltimaCampanaFacturada=ultimacampanafacturada, @CodigoConsultora=Codigo, @ConsultoraId=ConsultoraId FROM ods.Consultora WHERE Codigo = @Consultora  
  
IF (@UltimaCampanaFacturada >= @CampaniaDeseado)  
BEGIN  
 UPDATE ods.Consultora SET ultimacampanafacturada = @CampaniaFacturado WHERE Codigo=@CodigoConsultora  
 UPDATE ods.Consultora SET autorizapedido = 1 WHERE Codigo = @CodigoConsultora  
END  
  
UPDATE PedidoWeb SET IndicadorEnviado = 0 WHERE ConsultoraID=@ConsultoraId AND CampaniaID > @CampaniaFacturado  
UPDATE PedidoWeb SET ValidacionAbierta = 0 WHERE consultoraid=@ConsultoraId AND CampaniaID > @CampaniaFacturado  
  

SELECT CR.FechaInicioFacturacion,CR.FechaFinFacturacion,CR.FechaInicioReFacturacion,CR.FechaFinReFacturacion,CA.Codigo,CO.Codigo,* FROM ods.Consultora CO
INNER JOIN ods.Zona Z ON CO.ZonaID = Z.ZonaID AND CO.RegionID = Z.RegionID
INNER JOIN ods.Cronograma CR ON Z.ZonaID = CR.ZonaID AND Z.RegionID = CR.RegionID
INNER JOIN ods.Campania CA ON CR.CampaniaID = CA.CampaniaID AND CA.Codigo IN (SELECT Campania FROM @Campanias)
WHERE CO.AutorizaPedido = 1 AND CO.Codigo = @Consultora

GO

