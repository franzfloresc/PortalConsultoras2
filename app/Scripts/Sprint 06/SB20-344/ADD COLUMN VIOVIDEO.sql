if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('dbo.Usuario') and SYSCOLUMNS.NAME = N'VioVideo') = 0
	ALTER TABLE dbo.Usuario ADD VioVideo bit
go

UPDATE dbo.Usuario set VioVideo = 0