if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('dbo.OfertaFinalConsultora_log') and SYSCOLUMNS.NAME = N'TipoRegistro') = 0
	ALTER TABLE dbo.OfertaFinalConsultora_log ADD TipoRegistro int
go

