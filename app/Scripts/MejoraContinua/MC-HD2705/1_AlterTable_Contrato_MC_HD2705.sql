Use BelcorpColombia
GO
IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema='dbo' and table_name='Contrato' and column_name='DireccionIP')
BEGIN
	ALTER TABLE Contrato ADD DireccionIP varchar(15);
END
GO
IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema='dbo' and table_name='Contrato' and column_name='InformacionSOMobile')
BEGIN
	ALTER TABLE Contrato ADD InformacionSOMobile varchar(500);
END
GO