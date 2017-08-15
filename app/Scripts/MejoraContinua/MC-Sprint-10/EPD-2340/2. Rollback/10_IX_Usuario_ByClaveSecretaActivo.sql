
USE BelcorpBolivia
GO

IF EXISTS (
	SELECT 1
	FROM sys.indexes 
	WHERE name='IX_Usuario_ByClaveSecretaActivo' AND object_id = OBJECT_ID('dbo.Usuario')
)
BEGIN
	DROP INDEX IX_Usuario_ByClaveSecretaActivo ON dbo.Usuario
END
GO
/*end*/

USE BelcorpChile
GO

IF EXISTS (
	SELECT 1
	FROM sys.indexes 
	WHERE name='IX_Usuario_ByClaveSecretaActivo' AND object_id = OBJECT_ID('dbo.Usuario')
)
BEGIN
	DROP INDEX IX_Usuario_ByClaveSecretaActivo ON dbo.Usuario
END
GO
/*end*/

USE BelcorpColombia
GO

IF EXISTS (
	SELECT 1
	FROM sys.indexes 
	WHERE name='IX_Usuario_ByClaveSecretaActivo' AND object_id = OBJECT_ID('dbo.Usuario')
)
BEGIN
	DROP INDEX IX_Usuario_ByClaveSecretaActivo ON dbo.Usuario
END
GO
/*end*/

USE BelcorpCostaRica
GO

IF EXISTS (
	SELECT 1
	FROM sys.indexes 
	WHERE name='IX_Usuario_ByClaveSecretaActivo' AND object_id = OBJECT_ID('dbo.Usuario')
)
BEGIN
	DROP INDEX IX_Usuario_ByClaveSecretaActivo ON dbo.Usuario
END
GO
/*end*/

USE BelcorpDominicana
GO

IF EXISTS (
	SELECT 1
	FROM sys.indexes 
	WHERE name='IX_Usuario_ByClaveSecretaActivo' AND object_id = OBJECT_ID('dbo.Usuario')
)
BEGIN
	DROP INDEX IX_Usuario_ByClaveSecretaActivo ON dbo.Usuario
END
GO
/*end*/

USE BelcorpEcuador
GO

IF EXISTS (
	SELECT 1
	FROM sys.indexes 
	WHERE name='IX_Usuario_ByClaveSecretaActivo' AND object_id = OBJECT_ID('dbo.Usuario')
)
BEGIN
	DROP INDEX IX_Usuario_ByClaveSecretaActivo ON dbo.Usuario
END
GO
/*end*/

USE BelcorpGuatemala
GO

IF EXISTS (
	SELECT 1
	FROM sys.indexes 
	WHERE name='IX_Usuario_ByClaveSecretaActivo' AND object_id = OBJECT_ID('dbo.Usuario')
)
BEGIN
	DROP INDEX IX_Usuario_ByClaveSecretaActivo ON dbo.Usuario
END
GO
/*end*/

USE BelcorpMexico
GO

IF EXISTS (
	SELECT 1
	FROM sys.indexes 
	WHERE name='IX_Usuario_ByClaveSecretaActivo' AND object_id = OBJECT_ID('dbo.Usuario')
)
BEGIN
	DROP INDEX IX_Usuario_ByClaveSecretaActivo ON dbo.Usuario
END
GO
/*end*/

USE BelcorpPanama
GO

IF EXISTS (
	SELECT 1
	FROM sys.indexes 
	WHERE name='IX_Usuario_ByClaveSecretaActivo' AND object_id = OBJECT_ID('dbo.Usuario')
)
BEGIN
	DROP INDEX IX_Usuario_ByClaveSecretaActivo ON dbo.Usuario
END
GO
/*end*/

USE BelcorpPeru
GO

IF EXISTS (
	SELECT 1
	FROM sys.indexes 
	WHERE name='IX_Usuario_ByClaveSecretaActivo' AND object_id = OBJECT_ID('dbo.Usuario')
)
BEGIN
	DROP INDEX IX_Usuario_ByClaveSecretaActivo ON dbo.Usuario
END
GO
/*end*/

USE BelcorpPuertoRico
GO

IF EXISTS (
	SELECT 1
	FROM sys.indexes 
	WHERE name='IX_Usuario_ByClaveSecretaActivo' AND object_id = OBJECT_ID('dbo.Usuario')
)
BEGIN
	DROP INDEX IX_Usuario_ByClaveSecretaActivo ON dbo.Usuario
END
GO
/*end*/

USE BelcorpSalvador
GO

IF EXISTS (
	SELECT 1
	FROM sys.indexes 
	WHERE name='IX_Usuario_ByClaveSecretaActivo' AND object_id = OBJECT_ID('dbo.Usuario')
)
BEGIN
	DROP INDEX IX_Usuario_ByClaveSecretaActivo ON dbo.Usuario
END
GO
/*end*/

USE BelcorpVenezuela
GO

IF EXISTS (
	SELECT 1
	FROM sys.indexes 
	WHERE name='IX_Usuario_ByClaveSecretaActivo' AND object_id = OBJECT_ID('dbo.Usuario')
)
BEGIN
	DROP INDEX IX_Usuario_ByClaveSecretaActivo ON dbo.Usuario
END
GO
