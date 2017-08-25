

USE BelcorpBolivia
GO

IF OBJECT_ID('dbo.DF_DocumentoIdentidad', 'D') IS NOT NULL
BEGIN
    ALTER TABLE dbo.Usuario DROP CONSTRAINT DF_DocumentoIdentidad;
END
GO

IF EXISTS(SELECT 1 FROM sys.indexes 
		WHERE name='IX_Usuario_DocumentoIdentidad' AND OBJECT_ID = OBJECT_ID('dbo.Usuario'))
BEGIN
	DROP INDEX IX_Usuario_DocumentoIdentidad   
    ON dbo.Usuario;  
GO  
END
GO

IF EXISTS(SELECT 1 FROM sys.indexes 
		WHERE name='IX_UsuarioPostulante_CodigoUsuario' AND OBJECT_ID = OBJECT_ID('dbo.UsuarioPostulante'))
BEGIN
	DROP INDEX IX_UsuarioPostulante_CodigoUsuario   
    ON dbo.UsuarioPostulante;  
END
GO

/*end*/

USE BelcorpChile
GO

IF OBJECT_ID('dbo.DF_DocumentoIdentidad', 'D') IS NOT NULL
BEGIN
    ALTER TABLE dbo.Usuario DROP CONSTRAINT DF_DocumentoIdentidad;
END
GO

IF EXISTS(SELECT 1 FROM sys.indexes 
		WHERE name='IX_Usuario_DocumentoIdentidad' AND OBJECT_ID = OBJECT_ID('dbo.Usuario'))
BEGIN
	DROP INDEX IX_Usuario_DocumentoIdentidad   
    ON dbo.Usuario;  
GO  
END
GO

IF EXISTS(SELECT 1 FROM sys.indexes 
		WHERE name='IX_UsuarioPostulante_CodigoUsuario' AND OBJECT_ID = OBJECT_ID('dbo.UsuarioPostulante'))
BEGIN
	DROP INDEX IX_UsuarioPostulante_CodigoUsuario   
    ON dbo.UsuarioPostulante;  
END
GO

/*end*/

USE BelcorpColombia
GO

IF OBJECT_ID('dbo.DF_DocumentoIdentidad', 'D') IS NOT NULL
BEGIN
    ALTER TABLE dbo.Usuario DROP CONSTRAINT DF_DocumentoIdentidad;
END
GO

IF EXISTS(SELECT 1 FROM sys.indexes 
		WHERE name='IX_Usuario_DocumentoIdentidad' AND OBJECT_ID = OBJECT_ID('dbo.Usuario'))
BEGIN
	DROP INDEX IX_Usuario_DocumentoIdentidad   
    ON dbo.Usuario;  
GO  
END
GO

IF EXISTS(SELECT 1 FROM sys.indexes 
		WHERE name='IX_UsuarioPostulante_CodigoUsuario' AND OBJECT_ID = OBJECT_ID('dbo.UsuarioPostulante'))
BEGIN
	DROP INDEX IX_UsuarioPostulante_CodigoUsuario   
    ON dbo.UsuarioPostulante;  
END
GO

/*end*/

USE BelcorpCostaRica
GO

IF OBJECT_ID('dbo.DF_DocumentoIdentidad', 'D') IS NOT NULL
BEGIN
    ALTER TABLE dbo.Usuario DROP CONSTRAINT DF_DocumentoIdentidad;
END
GO

IF EXISTS(SELECT 1 FROM sys.indexes 
		WHERE name='IX_Usuario_DocumentoIdentidad' AND OBJECT_ID = OBJECT_ID('dbo.Usuario'))
BEGIN
	DROP INDEX IX_Usuario_DocumentoIdentidad   
    ON dbo.Usuario;  
GO  
END
GO

IF EXISTS(SELECT 1 FROM sys.indexes 
		WHERE name='IX_UsuarioPostulante_CodigoUsuario' AND OBJECT_ID = OBJECT_ID('dbo.UsuarioPostulante'))
BEGIN
	DROP INDEX IX_UsuarioPostulante_CodigoUsuario   
    ON dbo.UsuarioPostulante;  
END
GO

/*end*/

USE BelcorpDominicana
GO

IF OBJECT_ID('dbo.DF_DocumentoIdentidad', 'D') IS NOT NULL
BEGIN
    ALTER TABLE dbo.Usuario DROP CONSTRAINT DF_DocumentoIdentidad;
END
GO

IF EXISTS(SELECT 1 FROM sys.indexes 
		WHERE name='IX_Usuario_DocumentoIdentidad' AND OBJECT_ID = OBJECT_ID('dbo.Usuario'))
BEGIN
	DROP INDEX IX_Usuario_DocumentoIdentidad   
    ON dbo.Usuario;  
GO  
END
GO

IF EXISTS(SELECT 1 FROM sys.indexes 
		WHERE name='IX_UsuarioPostulante_CodigoUsuario' AND OBJECT_ID = OBJECT_ID('dbo.UsuarioPostulante'))
BEGIN
	DROP INDEX IX_UsuarioPostulante_CodigoUsuario   
    ON dbo.UsuarioPostulante;  
END
GO

/*end*/

USE BelcorpEcuador
GO

IF OBJECT_ID('dbo.DF_DocumentoIdentidad', 'D') IS NOT NULL
BEGIN
    ALTER TABLE dbo.Usuario DROP CONSTRAINT DF_DocumentoIdentidad;
END
GO

IF EXISTS(SELECT 1 FROM sys.indexes 
		WHERE name='IX_Usuario_DocumentoIdentidad' AND OBJECT_ID = OBJECT_ID('dbo.Usuario'))
BEGIN
	DROP INDEX IX_Usuario_DocumentoIdentidad   
    ON dbo.Usuario;  
GO  
END
GO

IF EXISTS(SELECT 1 FROM sys.indexes 
		WHERE name='IX_UsuarioPostulante_CodigoUsuario' AND OBJECT_ID = OBJECT_ID('dbo.UsuarioPostulante'))
BEGIN
	DROP INDEX IX_UsuarioPostulante_CodigoUsuario   
    ON dbo.UsuarioPostulante;  
END
GO


/*end*/

USE BelcorpGuatemala
GO

IF OBJECT_ID('dbo.DF_DocumentoIdentidad', 'D') IS NOT NULL
BEGIN
    ALTER TABLE dbo.Usuario DROP CONSTRAINT DF_DocumentoIdentidad;
END
GO

IF EXISTS(SELECT 1 FROM sys.indexes 
		WHERE name='IX_Usuario_DocumentoIdentidad' AND OBJECT_ID = OBJECT_ID('dbo.Usuario'))
BEGIN
	DROP INDEX IX_Usuario_DocumentoIdentidad   
    ON dbo.Usuario;  
GO  
END
GO

IF EXISTS(SELECT 1 FROM sys.indexes 
		WHERE name='IX_UsuarioPostulante_CodigoUsuario' AND OBJECT_ID = OBJECT_ID('dbo.UsuarioPostulante'))
BEGIN
	DROP INDEX IX_UsuarioPostulante_CodigoUsuario   
    ON dbo.UsuarioPostulante;  
END
GO

/*end*/

USE BelcorpMexico
GO

IF OBJECT_ID('dbo.DF_DocumentoIdentidad', 'D') IS NOT NULL
BEGIN
    ALTER TABLE dbo.Usuario DROP CONSTRAINT DF_DocumentoIdentidad;
END
GO

IF EXISTS(SELECT 1 FROM sys.indexes 
		WHERE name='IX_Usuario_DocumentoIdentidad' AND OBJECT_ID = OBJECT_ID('dbo.Usuario'))
BEGIN
	DROP INDEX IX_Usuario_DocumentoIdentidad   
    ON dbo.Usuario;  
GO  
END
GO

IF EXISTS(SELECT 1 FROM sys.indexes 
		WHERE name='IX_UsuarioPostulante_CodigoUsuario' AND OBJECT_ID = OBJECT_ID('dbo.UsuarioPostulante'))
BEGIN
	DROP INDEX IX_UsuarioPostulante_CodigoUsuario   
    ON dbo.UsuarioPostulante;  
END
GO

/*end*/

USE BelcorpPanama
GO

IF OBJECT_ID('dbo.DF_DocumentoIdentidad', 'D') IS NOT NULL
BEGIN
    ALTER TABLE dbo.Usuario DROP CONSTRAINT DF_DocumentoIdentidad;
END
GO

IF EXISTS(SELECT 1 FROM sys.indexes 
		WHERE name='IX_Usuario_DocumentoIdentidad' AND OBJECT_ID = OBJECT_ID('dbo.Usuario'))
BEGIN
	DROP INDEX IX_Usuario_DocumentoIdentidad   
    ON dbo.Usuario;  
GO  
END
GO

IF EXISTS(SELECT 1 FROM sys.indexes 
		WHERE name='IX_UsuarioPostulante_CodigoUsuario' AND OBJECT_ID = OBJECT_ID('dbo.UsuarioPostulante'))
BEGIN
	DROP INDEX IX_UsuarioPostulante_CodigoUsuario   
    ON dbo.UsuarioPostulante;  
END
GO

/*end*/

USE BelcorpPeru
GO

IF OBJECT_ID('dbo.DF_DocumentoIdentidad', 'D') IS NOT NULL
BEGIN
    ALTER TABLE dbo.Usuario DROP CONSTRAINT DF_DocumentoIdentidad;
END
GO

IF EXISTS(SELECT 1 FROM sys.indexes 
		WHERE name='IX_Usuario_DocumentoIdentidad' AND OBJECT_ID = OBJECT_ID('dbo.Usuario'))
BEGIN
	DROP INDEX IX_Usuario_DocumentoIdentidad   
    ON dbo.Usuario;  
GO  
END
GO

IF EXISTS(SELECT 1 FROM sys.indexes 
		WHERE name='IX_UsuarioPostulante_CodigoUsuario' AND OBJECT_ID = OBJECT_ID('dbo.UsuarioPostulante'))
BEGIN
	DROP INDEX IX_UsuarioPostulante_CodigoUsuario   
    ON dbo.UsuarioPostulante;  
END
GO

/*end*/

USE BelcorpPuertoRico
GO

IF OBJECT_ID('dbo.DF_DocumentoIdentidad', 'D') IS NOT NULL
BEGIN
    ALTER TABLE dbo.Usuario DROP CONSTRAINT DF_DocumentoIdentidad;
END
GO

IF EXISTS(SELECT 1 FROM sys.indexes 
		WHERE name='IX_Usuario_DocumentoIdentidad' AND OBJECT_ID = OBJECT_ID('dbo.Usuario'))
BEGIN
	DROP INDEX IX_Usuario_DocumentoIdentidad   
    ON dbo.Usuario;  
GO  
END
GO

IF EXISTS(SELECT 1 FROM sys.indexes 
		WHERE name='IX_UsuarioPostulante_CodigoUsuario' AND OBJECT_ID = OBJECT_ID('dbo.UsuarioPostulante'))
BEGIN
	DROP INDEX IX_UsuarioPostulante_CodigoUsuario   
    ON dbo.UsuarioPostulante;  
END
GO

/*end*/

USE BelcorpSalvador
GO

IF OBJECT_ID('dbo.DF_DocumentoIdentidad', 'D') IS NOT NULL
BEGIN
    ALTER TABLE dbo.Usuario DROP CONSTRAINT DF_DocumentoIdentidad;
END
GO

IF EXISTS(SELECT 1 FROM sys.indexes 
		WHERE name='IX_Usuario_DocumentoIdentidad' AND OBJECT_ID = OBJECT_ID('dbo.Usuario'))
BEGIN
	DROP INDEX IX_Usuario_DocumentoIdentidad   
    ON dbo.Usuario;  
GO  
END
GO

IF EXISTS(SELECT 1 FROM sys.indexes 
		WHERE name='IX_UsuarioPostulante_CodigoUsuario' AND OBJECT_ID = OBJECT_ID('dbo.UsuarioPostulante'))
BEGIN
	DROP INDEX IX_UsuarioPostulante_CodigoUsuario   
    ON dbo.UsuarioPostulante;  
END
GO

/*end*/

USE BelcorpVenezuela
GO

IF OBJECT_ID('dbo.DF_DocumentoIdentidad', 'D') IS NOT NULL
BEGIN
    ALTER TABLE dbo.Usuario DROP CONSTRAINT DF_DocumentoIdentidad;
END
GO

IF EXISTS(SELECT 1 FROM sys.indexes 
		WHERE name='IX_Usuario_DocumentoIdentidad' AND OBJECT_ID = OBJECT_ID('dbo.Usuario'))
BEGIN
	DROP INDEX IX_Usuario_DocumentoIdentidad   
    ON dbo.Usuario;  
GO  
END
GO

IF EXISTS(SELECT 1 FROM sys.indexes 
		WHERE name='IX_UsuarioPostulante_CodigoUsuario' AND OBJECT_ID = OBJECT_ID('dbo.UsuarioPostulante'))
BEGIN
	DROP INDEX IX_UsuarioPostulante_CodigoUsuario   
    ON dbo.UsuarioPostulante;  
END
GO





