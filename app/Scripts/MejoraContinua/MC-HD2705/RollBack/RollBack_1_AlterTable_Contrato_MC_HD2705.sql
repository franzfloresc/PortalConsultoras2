Use BelcorpColombia
GO
IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema='dbo' and table_name='Contrato' and column_name='DireccionIP')
BEGIN
	ALTER TABLE Contrato DROP Column DireccionIP
END
GO
IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema='dbo' and table_name='Contrato' and column_name='InformacionSOMobile')
BEGIN
	ALTER TABLE Contrato DROP Column InformacionSOMobile
END
GO