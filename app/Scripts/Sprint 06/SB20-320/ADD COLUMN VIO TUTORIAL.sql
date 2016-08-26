if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('dbo.Usuario') and SYSCOLUMNS.NAME = N'VioTutorial') = 0
	ALTER TABLE dbo.Usuario ADD VioTutorial bit
go

UPDATE dbo.Usuario set VioTutorial = 0

SELECT TOP 10 * FROM USUARIO