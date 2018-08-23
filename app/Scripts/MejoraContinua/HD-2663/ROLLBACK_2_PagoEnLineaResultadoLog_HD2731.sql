IF COL_LENGTH('dbo.PagoEnLineaResultadoLog', 'Correo') IS NOT NULL
BEGIN
    ALTER TABLE PagoEnLineaResultadoLog DROP COLUMN FechaNacimiento, Correo, Celular;
END