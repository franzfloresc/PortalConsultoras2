
GO
IF EXISTS(
    SELECT *
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = 'EstrategiaTemporal' AND COLUMN_NAME = 'CodigoTipoEstrategia'
)
BEGIN
	ALTER TABLE EstrategiaTemporal  DROP COLUMN CodigoTipoEstrategia; 
END
GO
