GO
USE BelcorpPeru
GO
IF EXISTS(SELECT 1 FROM sys.indexes WHERE name='UIX_ValidacionDatos_TipoEnvio_CodigoUsuario' AND object_id = OBJECT_ID('dbo.ValidacionDatos'))
BEGIN
	DROP INDEX UIX_ValidacionDatos_TipoEnvio_CodigoUsuario ON ValidacionDatos;
END

GO
USE BelcorpMexico
GO
IF EXISTS(SELECT 1 FROM sys.indexes WHERE name='UIX_ValidacionDatos_TipoEnvio_CodigoUsuario' AND object_id = OBJECT_ID('dbo.ValidacionDatos'))
BEGIN
	DROP INDEX UIX_ValidacionDatos_TipoEnvio_CodigoUsuario ON ValidacionDatos;
END

GO
USE BelcorpColombia
GO
IF EXISTS(SELECT 1 FROM sys.indexes WHERE name='UIX_ValidacionDatos_TipoEnvio_CodigoUsuario' AND object_id = OBJECT_ID('dbo.ValidacionDatos'))
BEGIN
	DROP INDEX UIX_ValidacionDatos_TipoEnvio_CodigoUsuario ON ValidacionDatos;
END

GO
USE BelcorpSalvador
GO
IF EXISTS(SELECT 1 FROM sys.indexes WHERE name='UIX_ValidacionDatos_TipoEnvio_CodigoUsuario' AND object_id = OBJECT_ID('dbo.ValidacionDatos'))
BEGIN
	DROP INDEX UIX_ValidacionDatos_TipoEnvio_CodigoUsuario ON ValidacionDatos;
END

GO
USE BelcorpPuertoRico
GO
IF EXISTS(SELECT 1 FROM sys.indexes WHERE name='UIX_ValidacionDatos_TipoEnvio_CodigoUsuario' AND object_id = OBJECT_ID('dbo.ValidacionDatos'))
BEGIN
	DROP INDEX UIX_ValidacionDatos_TipoEnvio_CodigoUsuario ON ValidacionDatos;
END

GO
USE BelcorpPanama
GO
IF EXISTS(SELECT 1 FROM sys.indexes WHERE name='UIX_ValidacionDatos_TipoEnvio_CodigoUsuario' AND object_id = OBJECT_ID('dbo.ValidacionDatos'))
BEGIN
	DROP INDEX UIX_ValidacionDatos_TipoEnvio_CodigoUsuario ON ValidacionDatos;
END

GO
USE BelcorpGuatemala
GO
IF EXISTS(SELECT 1 FROM sys.indexes WHERE name='UIX_ValidacionDatos_TipoEnvio_CodigoUsuario' AND object_id = OBJECT_ID('dbo.ValidacionDatos'))
BEGIN
	DROP INDEX UIX_ValidacionDatos_TipoEnvio_CodigoUsuario ON ValidacionDatos;
END

GO
USE BelcorpEcuador
GO
IF EXISTS(SELECT 1 FROM sys.indexes WHERE name='UIX_ValidacionDatos_TipoEnvio_CodigoUsuario' AND object_id = OBJECT_ID('dbo.ValidacionDatos'))
BEGIN
	DROP INDEX UIX_ValidacionDatos_TipoEnvio_CodigoUsuario ON ValidacionDatos;
END

GO
USE BelcorpDominicana
GO
IF EXISTS(SELECT 1 FROM sys.indexes WHERE name='UIX_ValidacionDatos_TipoEnvio_CodigoUsuario' AND object_id = OBJECT_ID('dbo.ValidacionDatos'))
BEGIN
	DROP INDEX UIX_ValidacionDatos_TipoEnvio_CodigoUsuario ON ValidacionDatos;
END

GO
USE BelcorpCostaRica
GO
IF EXISTS(SELECT 1 FROM sys.indexes WHERE name='UIX_ValidacionDatos_TipoEnvio_CodigoUsuario' AND object_id = OBJECT_ID('dbo.ValidacionDatos'))
BEGIN
	DROP INDEX UIX_ValidacionDatos_TipoEnvio_CodigoUsuario ON ValidacionDatos;
END

GO
USE BelcorpChile
GO
IF EXISTS(SELECT 1 FROM sys.indexes WHERE name='UIX_ValidacionDatos_TipoEnvio_CodigoUsuario' AND object_id = OBJECT_ID('dbo.ValidacionDatos'))
BEGIN
	DROP INDEX UIX_ValidacionDatos_TipoEnvio_CodigoUsuario ON ValidacionDatos;
END

GO
USE BelcorpBolivia
GO
IF EXISTS(SELECT 1 FROM sys.indexes WHERE name='UIX_ValidacionDatos_TipoEnvio_CodigoUsuario' AND object_id = OBJECT_ID('dbo.ValidacionDatos'))
BEGIN
	DROP INDEX UIX_ValidacionDatos_TipoEnvio_CodigoUsuario ON ValidacionDatos;
END

GO
