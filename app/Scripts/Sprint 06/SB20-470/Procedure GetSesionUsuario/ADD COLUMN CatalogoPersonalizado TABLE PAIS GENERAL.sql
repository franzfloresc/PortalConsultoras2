if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
  where sysobjects.id = object_id('dbo.Pais') and SYSCOLUMNS.NAME = N'CatalogoPersonalizado') = 0
  ALTER TABLE dbo.Pais ADD CatalogoPersonalizado int
go