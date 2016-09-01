if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('dbo.Usuario') and SYSCOLUMNS.NAME = N'VioTutorial') = 0
	ALTER TABLE dbo.Usuario ADD VioTutorial bit
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('dbo.Usuario') and SYSCOLUMNS.NAME = N'VioVideo') = 0
	ALTER TABLE dbo.Usuario ADD VioVideo bit
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
where sysobjects.id = object_id('dbo.Pais') and SYSCOLUMNS.NAME = N'CatalogoPersonalizado') = 0
	ALTER TABLE dbo.Pais ADD CatalogoPersonalizado int
go


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[setUsuarioVerTutorial_SB2]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].setUsuarioVerTutorial_SB2
GO

CREATE PROCEDURE setUsuarioVerTutorial_SB2
@codigoUsuario VARCHAR(25)
AS
BEGIN
	UPDATE Usuario
	SET VioTutorial = 1
	WHERE CodigoUsuario = @codigoUsuario
	SELECT 1
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[setUsuarioVideoIntroductorio_SB2]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].setUsuarioVideoIntroductorio_SB2
GO

CREATE PROCEDURE setUsuarioVideoIntroductorio_SB2
@codigoUsuario VARCHAR(25)
AS
BEGIN
	UPDATE Usuario
	SET VioVideo = 1
	WHERE CodigoUsuario = @codigoUsuario
	SELECT 1
END
GO