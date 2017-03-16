
go
if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('dbo.TieneVariedad') and SYSCOLUMNS.NAME = N'TieneVariedad') = 0
	ALTER TABLE dbo.Estrategia ADD TieneVariedad int
go

