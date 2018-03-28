USE BelcorpPeru
GO

IF COL_LENGTH('dbo.TablaLogicaDatos', 'Valor') IS NULL
BEGIN
	ALTER TABLE TablaLogicaDatos DROP COLUMN Valor;
END

GO

ALTER PROCEDURE [dbo].[GetTablaLogicaDatos] @TablaLogicaID SMALLINT
AS
SELECT TablaLogicaDatosID
	,TablaLogicaID
	,Codigo
	,Descripcion	
FROM TablaLogicaDatos(NOLOCK)
WHERE TablaLogicaID = @TablaLogicaID

GO

USE BelcorpMexico
GO

IF COL_LENGTH('dbo.TablaLogicaDatos', 'Valor') IS NULL
BEGIN
	ALTER TABLE TablaLogicaDatos DROP COLUMN Valor;
END

GO

ALTER PROCEDURE [dbo].[GetTablaLogicaDatos] @TablaLogicaID SMALLINT
AS
SELECT TablaLogicaDatosID
	,TablaLogicaID
	,Codigo
	,Descripcion	
FROM TablaLogicaDatos(NOLOCK)
WHERE TablaLogicaID = @TablaLogicaID

GO

USE BelcorpColombia
GO

IF COL_LENGTH('dbo.TablaLogicaDatos', 'Valor') IS NULL
BEGIN
	ALTER TABLE TablaLogicaDatos DROP COLUMN Valor;
END

GO

ALTER PROCEDURE [dbo].[GetTablaLogicaDatos] @TablaLogicaID SMALLINT
AS
SELECT TablaLogicaDatosID
	,TablaLogicaID
	,Codigo
	,Descripcion	
FROM TablaLogicaDatos(NOLOCK)
WHERE TablaLogicaID = @TablaLogicaID

GO

USE BelcorpSalvador
GO

IF COL_LENGTH('dbo.TablaLogicaDatos', 'Valor') IS NULL
BEGIN
	ALTER TABLE TablaLogicaDatos DROP COLUMN Valor;
END

GO

ALTER PROCEDURE [dbo].[GetTablaLogicaDatos] @TablaLogicaID SMALLINT
AS
SELECT TablaLogicaDatosID
	,TablaLogicaID
	,Codigo
	,Descripcion	
FROM TablaLogicaDatos(NOLOCK)
WHERE TablaLogicaID = @TablaLogicaID

GO

USE BelcorpPuertoRico
GO

IF COL_LENGTH('dbo.TablaLogicaDatos', 'Valor') IS NULL
BEGIN
	ALTER TABLE TablaLogicaDatos DROP COLUMN Valor;
END

GO

ALTER PROCEDURE [dbo].[GetTablaLogicaDatos] @TablaLogicaID SMALLINT
AS
SELECT TablaLogicaDatosID
	,TablaLogicaID
	,Codigo
	,Descripcion	
FROM TablaLogicaDatos(NOLOCK)
WHERE TablaLogicaID = @TablaLogicaID

GO

USE BelcorpPanama
GO

IF COL_LENGTH('dbo.TablaLogicaDatos', 'Valor') IS NULL
BEGIN
	ALTER TABLE TablaLogicaDatos DROP COLUMN Valor;
END

GO

ALTER PROCEDURE [dbo].[GetTablaLogicaDatos] @TablaLogicaID SMALLINT
AS
SELECT TablaLogicaDatosID
	,TablaLogicaID
	,Codigo
	,Descripcion	
FROM TablaLogicaDatos(NOLOCK)
WHERE TablaLogicaID = @TablaLogicaID

GO

USE BelcorpGuatemala
GO

IF COL_LENGTH('dbo.TablaLogicaDatos', 'Valor') IS NULL
BEGIN
	ALTER TABLE TablaLogicaDatos DROP COLUMN Valor;
END

GO

ALTER PROCEDURE [dbo].[GetTablaLogicaDatos] @TablaLogicaID SMALLINT
AS
SELECT TablaLogicaDatosID
	,TablaLogicaID
	,Codigo
	,Descripcion	
FROM TablaLogicaDatos(NOLOCK)
WHERE TablaLogicaID = @TablaLogicaID

GO

USE BelcorpEcuador
GO

IF COL_LENGTH('dbo.TablaLogicaDatos', 'Valor') IS NULL
BEGIN
	ALTER TABLE TablaLogicaDatos DROP COLUMN Valor;
END

GO

ALTER PROCEDURE [dbo].[GetTablaLogicaDatos] @TablaLogicaID SMALLINT
AS
SELECT TablaLogicaDatosID
	,TablaLogicaID
	,Codigo
	,Descripcion	
FROM TablaLogicaDatos(NOLOCK)
WHERE TablaLogicaID = @TablaLogicaID

GO

USE BelcorpDominicana
GO

IF COL_LENGTH('dbo.TablaLogicaDatos', 'Valor') IS NULL
BEGIN
	ALTER TABLE TablaLogicaDatos DROP COLUMN Valor;
END

GO

ALTER PROCEDURE [dbo].[GetTablaLogicaDatos] @TablaLogicaID SMALLINT
AS
SELECT TablaLogicaDatosID
	,TablaLogicaID
	,Codigo
	,Descripcion	
FROM TablaLogicaDatos(NOLOCK)
WHERE TablaLogicaID = @TablaLogicaID

GO

USE BelcorpCostaRica
GO

IF COL_LENGTH('dbo.TablaLogicaDatos', 'Valor') IS NULL
BEGIN
	ALTER TABLE TablaLogicaDatos DROP COLUMN Valor;
END

GO

ALTER PROCEDURE [dbo].[GetTablaLogicaDatos] @TablaLogicaID SMALLINT
AS
SELECT TablaLogicaDatosID
	,TablaLogicaID
	,Codigo
	,Descripcion	
FROM TablaLogicaDatos(NOLOCK)
WHERE TablaLogicaID = @TablaLogicaID

GO

USE BelcorpChile
GO

IF COL_LENGTH('dbo.TablaLogicaDatos', 'Valor') IS NULL
BEGIN
	ALTER TABLE TablaLogicaDatos DROP COLUMN Valor;
END

GO

ALTER PROCEDURE [dbo].[GetTablaLogicaDatos] @TablaLogicaID SMALLINT
AS
SELECT TablaLogicaDatosID
	,TablaLogicaID
	,Codigo
	,Descripcion	
FROM TablaLogicaDatos(NOLOCK)
WHERE TablaLogicaID = @TablaLogicaID

GO

USE BelcorpBolivia
GO

IF COL_LENGTH('dbo.TablaLogicaDatos', 'Valor') IS NULL
BEGIN
	ALTER TABLE TablaLogicaDatos DROP COLUMN Valor;
END

GO

ALTER PROCEDURE [dbo].[GetTablaLogicaDatos] @TablaLogicaID SMALLINT
AS
SELECT TablaLogicaDatosID
	,TablaLogicaID
	,Codigo
	,Descripcion	
FROM TablaLogicaDatos(NOLOCK)
WHERE TablaLogicaID = @TablaLogicaID

GO

