

USE BelcorpBolivia
GO

IF NOT EXISTS (SELECT 1 FROM dbo.TablaLogica WHERE Descripcion = 'Ofertas Consultora')
BEGIN
	DECLARE @newId INT 
	SET @newId = (SELECT MAX(TablaLogicaID)+1 FROM dbo.TablaLogica)

	INSERT INTO dbo.TablaLogica
	(
	    TablaLogicaID,
	    Descripcion
	)
	VALUES
	(   @newId,
	    'Ofertas Consultora'
	)

	DECLARE @newDetalleId INT
	SET @newDetalleId = (SELECT MAX(TablaLogicaDatosID)+1 FROM dbo.TablaLogicaDatos)

	INSERT INTO dbo.TablaLogicaDatos
	(
	    TablaLogicaDatosID,
	    TablaLogicaID,
	    Codigo,
	    Descripcion,
	    Valor
	)
	VALUES
	(   @newDetalleId,
	    @newId,
	    '01',
	    'Dias Antes Stock',
	    -2
	)
END
GO

USE BelcorpChile
GO

IF NOT EXISTS (SELECT 1 FROM dbo.TablaLogica WHERE Descripcion = 'Ofertas Consultora')
BEGIN
	DECLARE @newId INT 
	SET @newId = (SELECT MAX(TablaLogicaID)+1 FROM dbo.TablaLogica)

	INSERT INTO dbo.TablaLogica
	(
	    TablaLogicaID,
	    Descripcion
	)
	VALUES
	(   @newId,
	    'Ofertas Consultora'
	)

	DECLARE @newDetalleId INT
	SET @newDetalleId = (SELECT MAX(TablaLogicaDatosID)+1 FROM dbo.TablaLogicaDatos)

	INSERT INTO dbo.TablaLogicaDatos
	(
	    TablaLogicaDatosID,
	    TablaLogicaID,
	    Codigo,
	    Descripcion,
	    Valor
	)
	VALUES
	(   @newDetalleId,
	    @newId,
	    '01',
	    'Dias Antes Stock',
	    -2
	)
END
GO

USE BelcorpColombia
GO

IF NOT EXISTS (SELECT 1 FROM dbo.TablaLogica WHERE Descripcion = 'Ofertas Consultora')
BEGIN
	DECLARE @newId INT 
	SET @newId = (SELECT MAX(TablaLogicaID)+1 FROM dbo.TablaLogica)

	INSERT INTO dbo.TablaLogica
	(
	    TablaLogicaID,
	    Descripcion
	)
	VALUES
	(   @newId,
	    'Ofertas Consultora'
	)

	DECLARE @newDetalleId INT
	SET @newDetalleId = (SELECT MAX(TablaLogicaDatosID)+1 FROM dbo.TablaLogicaDatos)

	INSERT INTO dbo.TablaLogicaDatos
	(
	    TablaLogicaDatosID,
	    TablaLogicaID,
	    Codigo,
	    Descripcion,
	    Valor
	)
	VALUES
	(   @newDetalleId,
	    @newId,
	    '01',
	    'Dias Antes Stock',
	    -2
	)
END
GO

USE BelcorpCostaRica
GO

IF NOT EXISTS (SELECT 1 FROM dbo.TablaLogica WHERE Descripcion = 'Ofertas Consultora')
BEGIN
	DECLARE @newId INT 
	SET @newId = (SELECT MAX(TablaLogicaID)+1 FROM dbo.TablaLogica)

	INSERT INTO dbo.TablaLogica
	(
	    TablaLogicaID,
	    Descripcion
	)
	VALUES
	(   @newId,
	    'Ofertas Consultora'
	)

	DECLARE @newDetalleId INT
	SET @newDetalleId = (SELECT MAX(TablaLogicaDatosID)+1 FROM dbo.TablaLogicaDatos)

	INSERT INTO dbo.TablaLogicaDatos
	(
	    TablaLogicaDatosID,
	    TablaLogicaID,
	    Codigo,
	    Descripcion,
	    Valor
	)
	VALUES
	(   @newDetalleId,
	    @newId,
	    '01',
	    'Dias Antes Stock',
	    -2
	)
END
GO

USE BelcorpDominicana
GO

IF NOT EXISTS (SELECT 1 FROM dbo.TablaLogica WHERE Descripcion = 'Ofertas Consultora')
BEGIN
	DECLARE @newId INT 
	SET @newId = (SELECT MAX(TablaLogicaID)+1 FROM dbo.TablaLogica)

	INSERT INTO dbo.TablaLogica
	(
	    TablaLogicaID,
	    Descripcion
	)
	VALUES
	(   @newId,
	    'Ofertas Consultora'
	)

	DECLARE @newDetalleId INT
	SET @newDetalleId = (SELECT MAX(TablaLogicaDatosID)+1 FROM dbo.TablaLogicaDatos)

	INSERT INTO dbo.TablaLogicaDatos
	(
	    TablaLogicaDatosID,
	    TablaLogicaID,
	    Codigo,
	    Descripcion,
	    Valor
	)
	VALUES
	(   @newDetalleId,
	    @newId,
	    '01',
	    'Dias Antes Stock',
	    -2
	)
END
GO

USE BelcorpEcuador
GO

IF NOT EXISTS (SELECT 1 FROM dbo.TablaLogica WHERE Descripcion = 'Ofertas Consultora')
BEGIN
	DECLARE @newId INT 
	SET @newId = (SELECT MAX(TablaLogicaID)+1 FROM dbo.TablaLogica)

	INSERT INTO dbo.TablaLogica
	(
	    TablaLogicaID,
	    Descripcion
	)
	VALUES
	(   @newId,
	    'Ofertas Consultora'
	)

	DECLARE @newDetalleId INT
	SET @newDetalleId = (SELECT MAX(TablaLogicaDatosID)+1 FROM dbo.TablaLogicaDatos)

	INSERT INTO dbo.TablaLogicaDatos
	(
	    TablaLogicaDatosID,
	    TablaLogicaID,
	    Codigo,
	    Descripcion,
	    Valor
	)
	VALUES
	(   @newDetalleId,
	    @newId,
	    '01',
	    'Dias Antes Stock',
	    -2
	)
END
GO

USE BelcorpGuatemala
GO

IF NOT EXISTS (SELECT 1 FROM dbo.TablaLogica WHERE Descripcion = 'Ofertas Consultora')
BEGIN
	DECLARE @newId INT 
	SET @newId = (SELECT MAX(TablaLogicaID)+1 FROM dbo.TablaLogica)

	INSERT INTO dbo.TablaLogica
	(
	    TablaLogicaID,
	    Descripcion
	)
	VALUES
	(   @newId,
	    'Ofertas Consultora'
	)

	DECLARE @newDetalleId INT
	SET @newDetalleId = (SELECT MAX(TablaLogicaDatosID)+1 FROM dbo.TablaLogicaDatos)

	INSERT INTO dbo.TablaLogicaDatos
	(
	    TablaLogicaDatosID,
	    TablaLogicaID,
	    Codigo,
	    Descripcion,
	    Valor
	)
	VALUES
	(   @newDetalleId,
	    @newId,
	    '01',
	    'Dias Antes Stock',
	    -2
	)
END
GO

USE BelcorpMexico
GO

IF NOT EXISTS (SELECT 1 FROM dbo.TablaLogica WHERE Descripcion = 'Ofertas Consultora')
BEGIN
	DECLARE @newId INT 
	SET @newId = (SELECT MAX(TablaLogicaID)+1 FROM dbo.TablaLogica)

	INSERT INTO dbo.TablaLogica
	(
	    TablaLogicaID,
	    Descripcion
	)
	VALUES
	(   @newId,
	    'Ofertas Consultora'
	)

	DECLARE @newDetalleId INT
	SET @newDetalleId = (SELECT MAX(TablaLogicaDatosID)+1 FROM dbo.TablaLogicaDatos)

	INSERT INTO dbo.TablaLogicaDatos
	(
	    TablaLogicaDatosID,
	    TablaLogicaID,
	    Codigo,
	    Descripcion,
	    Valor
	)
	VALUES
	(   @newDetalleId,
	    @newId,
	    '01',
	    'Dias Antes Stock',
	    -2
	)
END
GO

USE BelcorpPanama
GO

IF NOT EXISTS (SELECT 1 FROM dbo.TablaLogica WHERE Descripcion = 'Ofertas Consultora')
BEGIN
	DECLARE @newId INT 
	SET @newId = (SELECT MAX(TablaLogicaID)+1 FROM dbo.TablaLogica)

	INSERT INTO dbo.TablaLogica
	(
	    TablaLogicaID,
	    Descripcion
	)
	VALUES
	(   @newId,
	    'Ofertas Consultora'
	)

	DECLARE @newDetalleId INT
	SET @newDetalleId = (SELECT MAX(TablaLogicaDatosID)+1 FROM dbo.TablaLogicaDatos)

	INSERT INTO dbo.TablaLogicaDatos
	(
	    TablaLogicaDatosID,
	    TablaLogicaID,
	    Codigo,
	    Descripcion,
	    Valor
	)
	VALUES
	(   @newDetalleId,
	    @newId,
	    '01',
	    'Dias Antes Stock',
	    -2
	)
END
GO

USE BelcorpPeru
GO

IF NOT EXISTS (SELECT 1 FROM dbo.TablaLogica WHERE Descripcion = 'Ofertas Consultora')
BEGIN
	DECLARE @newId INT 
	SET @newId = (SELECT MAX(TablaLogicaID)+1 FROM dbo.TablaLogica)

	INSERT INTO dbo.TablaLogica
	(
	    TablaLogicaID,
	    Descripcion
	)
	VALUES
	(   @newId,
	    'Ofertas Consultora'
	)

	DECLARE @newDetalleId INT
	SET @newDetalleId = (SELECT MAX(TablaLogicaDatosID)+1 FROM dbo.TablaLogicaDatos)

	INSERT INTO dbo.TablaLogicaDatos
	(
	    TablaLogicaDatosID,
	    TablaLogicaID,
	    Codigo,
	    Descripcion,
	    Valor
	)
	VALUES
	(   @newDetalleId,
	    @newId,
	    '01',
	    'Dias Antes Stock',
	    -2
	)
END
GO

USE BelcorpPuertoRico
GO

IF NOT EXISTS (SELECT 1 FROM dbo.TablaLogica WHERE Descripcion = 'Ofertas Consultora')
BEGIN
	DECLARE @newId INT 
	SET @newId = (SELECT MAX(TablaLogicaID)+1 FROM dbo.TablaLogica)

	INSERT INTO dbo.TablaLogica
	(
	    TablaLogicaID,
	    Descripcion
	)
	VALUES
	(   @newId,
	    'Ofertas Consultora'
	)

	DECLARE @newDetalleId INT
	SET @newDetalleId = (SELECT MAX(TablaLogicaDatosID)+1 FROM dbo.TablaLogicaDatos)

	INSERT INTO dbo.TablaLogicaDatos
	(
	    TablaLogicaDatosID,
	    TablaLogicaID,
	    Codigo,
	    Descripcion,
	    Valor
	)
	VALUES
	(   @newDetalleId,
	    @newId,
	    '01',
	    'Dias Antes Stock',
	    -2
	)
END
GO

USE BelcorpSalvador
GO

IF NOT EXISTS (SELECT 1 FROM dbo.TablaLogica WHERE Descripcion = 'Ofertas Consultora')
BEGIN
	DECLARE @newId INT 
	SET @newId = (SELECT MAX(TablaLogicaID)+1 FROM dbo.TablaLogica)

	INSERT INTO dbo.TablaLogica
	(
	    TablaLogicaID,
	    Descripcion
	)
	VALUES
	(   @newId,
	    'Ofertas Consultora'
	)

	DECLARE @newDetalleId INT
	SET @newDetalleId = (SELECT MAX(TablaLogicaDatosID)+1 FROM dbo.TablaLogicaDatos)

	INSERT INTO dbo.TablaLogicaDatos
	(
	    TablaLogicaDatosID,
	    TablaLogicaID,
	    Codigo,
	    Descripcion,
	    Valor
	)
	VALUES
	(   @newDetalleId,
	    @newId,
	    '01',
	    'Dias Antes Stock',
	    -2
	)
END
GO

