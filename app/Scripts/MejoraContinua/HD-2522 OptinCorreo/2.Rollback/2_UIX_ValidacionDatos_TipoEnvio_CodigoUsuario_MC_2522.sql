GO
IF EXISTS(SELECT 1 FROM sys.indexes WHERE name='UIX_ValidacionDatos_TipoEnvio_CodigoUsuario' AND object_id = OBJECT_ID('dbo.ValidacionDatos'))
BEGIN
	DROP INDEX UIX_ValidacionDatos_TipoEnvio_CodigoUsuario ON ValidacionDatos;
END
GO