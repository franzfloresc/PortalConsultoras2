IF COL_LENGTH('dbo.PagoEnLineaResultadoLog', 'Correo') IS NULL
BEGIN
    ALTER TABLE PagoEnLineaResultadoLog ADD FechaNacimiento DATETIME NULL, Correo VARCHAR(255) NULL, Celular VARCHAR (20) NULL;
END