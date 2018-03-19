﻿USE BelcorpPeru
GO

GO
IF EXISTS(
    SELECT *
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = 'EstrategiaTemporal' AND COLUMN_NAME = 'Niveles'
)
BEGIN
	ALTER TABLE EstrategiaTemporal  DROP COLUMN Niveles; 
END
GO

USE BelcorpMexico
GO

GO
IF EXISTS(
    SELECT *
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = 'EstrategiaTemporal' AND COLUMN_NAME = 'Niveles'
)
BEGIN
	ALTER TABLE EstrategiaTemporal  DROP COLUMN Niveles; 
END
GO

USE BelcorpColombia
GO

GO
IF EXISTS(
    SELECT *
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = 'EstrategiaTemporal' AND COLUMN_NAME = 'Niveles'
)
BEGIN
	ALTER TABLE EstrategiaTemporal  DROP COLUMN Niveles; 
END
GO

USE BelcorpVenezuela
GO

GO
IF EXISTS(
    SELECT *
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = 'EstrategiaTemporal' AND COLUMN_NAME = 'Niveles'
)
BEGIN
	ALTER TABLE EstrategiaTemporal  DROP COLUMN Niveles; 
END
GO

USE BelcorpSalvador
GO

GO
IF EXISTS(
    SELECT *
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = 'EstrategiaTemporal' AND COLUMN_NAME = 'Niveles'
)
BEGIN
	ALTER TABLE EstrategiaTemporal  DROP COLUMN Niveles; 
END
GO

USE BelcorpPuertoRico
GO

GO
IF EXISTS(
    SELECT *
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = 'EstrategiaTemporal' AND COLUMN_NAME = 'Niveles'
)
BEGIN
	ALTER TABLE EstrategiaTemporal  DROP COLUMN Niveles; 
END
GO

USE BelcorpPanama
GO

GO
IF EXISTS(
    SELECT *
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = 'EstrategiaTemporal' AND COLUMN_NAME = 'Niveles'
)
BEGIN
	ALTER TABLE EstrategiaTemporal  DROP COLUMN Niveles; 
END
GO

USE BelcorpGuatemala
GO

GO
IF EXISTS(
    SELECT *
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = 'EstrategiaTemporal' AND COLUMN_NAME = 'Niveles'
)
BEGIN
	ALTER TABLE EstrategiaTemporal  DROP COLUMN Niveles; 
END
GO

USE BelcorpEcuador
GO

GO
IF EXISTS(
    SELECT *
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = 'EstrategiaTemporal' AND COLUMN_NAME = 'Niveles'
)
BEGIN
	ALTER TABLE EstrategiaTemporal  DROP COLUMN Niveles; 
END
GO

USE BelcorpDominicana
GO

GO
IF EXISTS(
    SELECT *
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = 'EstrategiaTemporal' AND COLUMN_NAME = 'Niveles'
)
BEGIN
	ALTER TABLE EstrategiaTemporal  DROP COLUMN Niveles; 
END
GO

USE BelcorpCostaRica
GO

GO
IF EXISTS(
    SELECT *
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = 'EstrategiaTemporal' AND COLUMN_NAME = 'Niveles'
)
BEGIN
	ALTER TABLE EstrategiaTemporal  DROP COLUMN Niveles; 
END
GO

USE BelcorpChile
GO

GO
IF EXISTS(
    SELECT *
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = 'EstrategiaTemporal' AND COLUMN_NAME = 'Niveles'
)
BEGIN
	ALTER TABLE EstrategiaTemporal  DROP COLUMN Niveles; 
END
GO

USE BelcorpBolivia
GO

GO
IF EXISTS(
    SELECT *
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = 'EstrategiaTemporal' AND COLUMN_NAME = 'Niveles'
)
BEGIN
	ALTER TABLE EstrategiaTemporal  DROP COLUMN Niveles; 
END
GO