GO
USE BelcorpPeru
GO
IF EXISTS(SELECT 1 FROM sys.indexes WHERE name='UIX_ValidacionDatos_TipoEnvio_CodigoUsuario' AND object_id = OBJECT_ID('dbo.ValidacionDatos'))
BEGIN
	DROP INDEX UIX_ValidacionDatos_TipoEnvio_CodigoUsuario ON ValidacionDatos;
END
GO
CREATE UNIQUE INDEX UIX_ValidacionDatos_TipoEnvio_CodigoUsuario ON ValidacionDatos(TipoEnvio,CodigoUsuario)

GO
USE BelcorpMexico
GO
IF EXISTS(SELECT 1 FROM sys.indexes WHERE name='UIX_ValidacionDatos_TipoEnvio_CodigoUsuario' AND object_id = OBJECT_ID('dbo.ValidacionDatos'))
BEGIN
	DROP INDEX UIX_ValidacionDatos_TipoEnvio_CodigoUsuario ON ValidacionDatos;
END
GO
CREATE UNIQUE INDEX UIX_ValidacionDatos_TipoEnvio_CodigoUsuario ON ValidacionDatos(TipoEnvio,CodigoUsuario)

GO
USE BelcorpColombia
GO
IF EXISTS(SELECT 1 FROM sys.indexes WHERE name='UIX_ValidacionDatos_TipoEnvio_CodigoUsuario' AND object_id = OBJECT_ID('dbo.ValidacionDatos'))
BEGIN
	DROP INDEX UIX_ValidacionDatos_TipoEnvio_CodigoUsuario ON ValidacionDatos;
END
GO
CREATE UNIQUE INDEX UIX_ValidacionDatos_TipoEnvio_CodigoUsuario ON ValidacionDatos(TipoEnvio,CodigoUsuario)

GO
USE BelcorpSalvador
GO
IF EXISTS(SELECT 1 FROM sys.indexes WHERE name='UIX_ValidacionDatos_TipoEnvio_CodigoUsuario' AND object_id = OBJECT_ID('dbo.ValidacionDatos'))
BEGIN
	DROP INDEX UIX_ValidacionDatos_TipoEnvio_CodigoUsuario ON ValidacionDatos;
END
GO
CREATE UNIQUE INDEX UIX_ValidacionDatos_TipoEnvio_CodigoUsuario ON ValidacionDatos(TipoEnvio,CodigoUsuario)

GO
USE BelcorpPuertoRico
GO
IF EXISTS(SELECT 1 FROM sys.indexes WHERE name='UIX_ValidacionDatos_TipoEnvio_CodigoUsuario' AND object_id = OBJECT_ID('dbo.ValidacionDatos'))
BEGIN
	DROP INDEX UIX_ValidacionDatos_TipoEnvio_CodigoUsuario ON ValidacionDatos;
END
GO
CREATE UNIQUE INDEX UIX_ValidacionDatos_TipoEnvio_CodigoUsuario ON ValidacionDatos(TipoEnvio,CodigoUsuario)

GO
USE BelcorpPanama
GO
IF EXISTS(SELECT 1 FROM sys.indexes WHERE name='UIX_ValidacionDatos_TipoEnvio_CodigoUsuario' AND object_id = OBJECT_ID('dbo.ValidacionDatos'))
BEGIN
	DROP INDEX UIX_ValidacionDatos_TipoEnvio_CodigoUsuario ON ValidacionDatos;
END
GO
CREATE UNIQUE INDEX UIX_ValidacionDatos_TipoEnvio_CodigoUsuario ON ValidacionDatos(TipoEnvio,CodigoUsuario)

GO
USE BelcorpGuatemala
GO
IF EXISTS(SELECT 1 FROM sys.indexes WHERE name='UIX_ValidacionDatos_TipoEnvio_CodigoUsuario' AND object_id = OBJECT_ID('dbo.ValidacionDatos'))
BEGIN
	DROP INDEX UIX_ValidacionDatos_TipoEnvio_CodigoUsuario ON ValidacionDatos;
END
GO
CREATE UNIQUE INDEX UIX_ValidacionDatos_TipoEnvio_CodigoUsuario ON ValidacionDatos(TipoEnvio,CodigoUsuario)

GO
USE BelcorpEcuador
GO
IF EXISTS(SELECT 1 FROM sys.indexes WHERE name='UIX_ValidacionDatos_TipoEnvio_CodigoUsuario' AND object_id = OBJECT_ID('dbo.ValidacionDatos'))
BEGIN
	DROP INDEX UIX_ValidacionDatos_TipoEnvio_CodigoUsuario ON ValidacionDatos;
END
GO
CREATE UNIQUE INDEX UIX_ValidacionDatos_TipoEnvio_CodigoUsuario ON ValidacionDatos(TipoEnvio,CodigoUsuario)

GO
USE BelcorpDominicana
GO
IF EXISTS(SELECT 1 FROM sys.indexes WHERE name='UIX_ValidacionDatos_TipoEnvio_CodigoUsuario' AND object_id = OBJECT_ID('dbo.ValidacionDatos'))
BEGIN
	DROP INDEX UIX_ValidacionDatos_TipoEnvio_CodigoUsuario ON ValidacionDatos;
END
GO
CREATE UNIQUE INDEX UIX_ValidacionDatos_TipoEnvio_CodigoUsuario ON ValidacionDatos(TipoEnvio,CodigoUsuario)

GO
USE BelcorpCostaRica
GO
IF EXISTS(SELECT 1 FROM sys.indexes WHERE name='UIX_ValidacionDatos_TipoEnvio_CodigoUsuario' AND object_id = OBJECT_ID('dbo.ValidacionDatos'))
BEGIN
	DROP INDEX UIX_ValidacionDatos_TipoEnvio_CodigoUsuario ON ValidacionDatos;
END
GO
CREATE UNIQUE INDEX UIX_ValidacionDatos_TipoEnvio_CodigoUsuario ON ValidacionDatos(TipoEnvio,CodigoUsuario)

GO
USE BelcorpChile
GO
IF EXISTS(SELECT 1 FROM sys.indexes WHERE name='UIX_ValidacionDatos_TipoEnvio_CodigoUsuario' AND object_id = OBJECT_ID('dbo.ValidacionDatos'))
BEGIN
	DROP INDEX UIX_ValidacionDatos_TipoEnvio_CodigoUsuario ON ValidacionDatos;
END
GO
CREATE UNIQUE INDEX UIX_ValidacionDatos_TipoEnvio_CodigoUsuario ON ValidacionDatos(TipoEnvio,CodigoUsuario)

GO
USE BelcorpBolivia
GO
IF EXISTS(SELECT 1 FROM sys.indexes WHERE name='UIX_ValidacionDatos_TipoEnvio_CodigoUsuario' AND object_id = OBJECT_ID('dbo.ValidacionDatos'))
BEGIN
	DROP INDEX UIX_ValidacionDatos_TipoEnvio_CodigoUsuario ON ValidacionDatos;
END
GO
CREATE UNIQUE INDEX UIX_ValidacionDatos_TipoEnvio_CodigoUsuario ON ValidacionDatos(TipoEnvio,CodigoUsuario)

GO
