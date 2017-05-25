USE BelcorpCostaRica
GO
IF NOT EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'NemoTecnico'
          AND Object_ID = Object_ID(N'MatrizComercialImagen'))
BEGIN
	ALTER TABLE MatrizComercialImagen
	ADD NemoTecnico VARCHAR(100);
END