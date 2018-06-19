GO
IF (EXISTS(SELECT 1	FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'ValidacionAutomaticaPROLLog' AND COLUMN_NAME = 'EsDeuda'))
BEGIN
    ALTER TABLE dbo.ValidacionAutomaticaPROLLog
	DROP CONSTRAINT DF_ValidacionAutomaticaPROLLog_EsDeuda;

    ALTER TABLE dbo.ValidacionAutomaticaPROLLog
	DROP COLUMN EsDeuda;
END
IF (EXISTS(SELECT 1	FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'ValidacionAutomaticaPROLLog' AND COLUMN_NAME = 'MontoDeuda'))
BEGIN
    ALTER TABLE dbo.ValidacionAutomaticaPROLLog
	DROP CONSTRAINT DF_ValidacionAutomaticaPROLLog_MontoDeuda;

    ALTER TABLE dbo.ValidacionAutomaticaPROLLog
	DROP COLUMN MontoDeuda;
END
GO