GO
ALTER TABLE dbo.TablaLogicaDatos
ALTER COLUMN Codigo VARCHAR(150) NOT NULL;
GO
ALTER TABLE dbo.TablaLogicaDatos
ALTER COLUMN Descripcion VARCHAR(180) NOT NULL;
GO
IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE name='IX_TablaLogicaDatos_TablaLogicaID')
BEGIN
	CREATE INDEX IX_TablaLogicaDatos_TablaLogicaID ON dbo.TablaLogicaDatos(TablaLogicaID);
END
GO

