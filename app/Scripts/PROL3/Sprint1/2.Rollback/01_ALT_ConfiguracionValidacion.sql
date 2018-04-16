GO
IF (EXISTS(SELECT 1	FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'ConfiguracionValidacion' AND COLUMN_NAME = 'TieneProl3'))
BEGIN
    ALTER TABLE dbo.ConfiguracionValidacion
	DROP CONSTRAINT DF_ConfiguracionValidacion_TieneProl3;

    ALTER TABLE dbo.ConfiguracionValidacion
	DROP COLUMN TieneProl3;
END
GO