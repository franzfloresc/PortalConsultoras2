USE BelcorpPeru
GO

IF EXISTS (
    SELECT * FROM sys.objects
    WHERE object_id =
    OBJECT_ID(N'[dbo].[ListarDocumentoExcepcion]')
    AND type in (N'P', N'PC')
)
    DROP PROCEDURE [dbo].[ListarDocumentoExcepcion]
GO

create procedure dbo.ListarDocumentoExcepcion(
	@pNumeroDocumento varchar(30)
)
as
begin
	select stuff(( select '¬' + cast(DocumentoExcepionBuroID as varchar(30)) + '|' + isnull( NumeroDocumento,'') +'|' + isnull(tp.Nombre,'')+'|'+
	isnull(UsuarioCreacion,'') +'|'+ Convert(varchar(10),CONVERT(date,FechaCreacion,106),103)+'|'+ case when isnull(activo,0)=1 then 'Si' else 'No' end
	from dbo.DocumentoExcepcionBuro 
	cross apply (select * from unete.parametrounete where FK_IdTipoPArametro = 20 and valor = TipoDocumento) tp
	where NumeroDocumento
	 like '%'+@pNumeroDocumento+'%' order by DocumentoExcepionBuroID desc for xml path('')), 1,1,'')
end
GO

USE BelcorpMexico
GO

IF EXISTS (
    SELECT * FROM sys.objects
    WHERE object_id =
    OBJECT_ID(N'[dbo].[ListarDocumentoExcepcion]')
    AND type in (N'P', N'PC')
)
    DROP PROCEDURE [dbo].[ListarDocumentoExcepcion]
GO

create procedure dbo.ListarDocumentoExcepcion(
	@pNumeroDocumento varchar(30)
)
as
begin
	select stuff(( select '¬' + cast(DocumentoExcepionBuroID as varchar(30)) + '|' + isnull( NumeroDocumento,'') +'|' + isnull(tp.Nombre,'')+'|'+
	isnull(UsuarioCreacion,'') +'|'+ Convert(varchar(10),CONVERT(date,FechaCreacion,106),103)+'|'+ case when isnull(activo,0)=1 then 'Si' else 'No' end
	from dbo.DocumentoExcepcionBuro 
	cross apply (select * from unete.parametrounete where FK_IdTipoPArametro = 20 and valor = TipoDocumento) tp
	where NumeroDocumento
	 like '%'+@pNumeroDocumento+'%' order by DocumentoExcepionBuroID desc for xml path('')), 1,1,'')
end
GO

USE BelcorpColombia
GO

IF EXISTS (
    SELECT * FROM sys.objects
    WHERE object_id =
    OBJECT_ID(N'[dbo].[ListarDocumentoExcepcion]')
    AND type in (N'P', N'PC')
)
    DROP PROCEDURE [dbo].[ListarDocumentoExcepcion]
GO

create procedure dbo.ListarDocumentoExcepcion(
	@pNumeroDocumento varchar(30)
)
as
begin
	select stuff(( select '¬' + cast(DocumentoExcepionBuroID as varchar(30)) + '|' + isnull( NumeroDocumento,'') +'|' + isnull(tp.Nombre,'')+'|'+
	isnull(UsuarioCreacion,'') +'|'+ Convert(varchar(10),CONVERT(date,FechaCreacion,106),103)+'|'+ case when isnull(activo,0)=1 then 'Si' else 'No' end
	from dbo.DocumentoExcepcionBuro 
	cross apply (select * from unete.parametrounete where FK_IdTipoPArametro = 20 and valor = TipoDocumento) tp
	where NumeroDocumento
	 like '%'+@pNumeroDocumento+'%' order by DocumentoExcepionBuroID desc for xml path('')), 1,1,'')
end
GO

USE BelcorpSalvador
GO

IF EXISTS (
    SELECT * FROM sys.objects
    WHERE object_id =
    OBJECT_ID(N'[dbo].[ListarDocumentoExcepcion]')
    AND type in (N'P', N'PC')
)
    DROP PROCEDURE [dbo].[ListarDocumentoExcepcion]
GO

create procedure dbo.ListarDocumentoExcepcion(
	@pNumeroDocumento varchar(30)
)
as
begin
	select stuff(( select '¬' + cast(DocumentoExcepionBuroID as varchar(30)) + '|' + isnull( NumeroDocumento,'') +'|' + isnull(tp.Nombre,'')+'|'+
	isnull(UsuarioCreacion,'') +'|'+ Convert(varchar(10),CONVERT(date,FechaCreacion,106),103)+'|'+ case when isnull(activo,0)=1 then 'Si' else 'No' end
	from dbo.DocumentoExcepcionBuro 
	cross apply (select * from unete.parametrounete where FK_IdTipoPArametro = 20 and valor = TipoDocumento) tp
	where NumeroDocumento
	 like '%'+@pNumeroDocumento+'%' order by DocumentoExcepionBuroID desc for xml path('')), 1,1,'')
end
GO

USE BelcorpPuertoRico
GO

IF EXISTS (
    SELECT * FROM sys.objects
    WHERE object_id =
    OBJECT_ID(N'[dbo].[ListarDocumentoExcepcion]')
    AND type in (N'P', N'PC')
)
    DROP PROCEDURE [dbo].[ListarDocumentoExcepcion]
GO

create procedure dbo.ListarDocumentoExcepcion(
	@pNumeroDocumento varchar(30)
)
as
begin
	select stuff(( select '¬' + cast(DocumentoExcepionBuroID as varchar(30)) + '|' + isnull( NumeroDocumento,'') +'|' + isnull(tp.Nombre,'')+'|'+
	isnull(UsuarioCreacion,'') +'|'+ Convert(varchar(10),CONVERT(date,FechaCreacion,106),103)+'|'+ case when isnull(activo,0)=1 then 'Si' else 'No' end
	from dbo.DocumentoExcepcionBuro 
	cross apply (select * from unete.parametrounete where FK_IdTipoPArametro = 20 and valor = TipoDocumento) tp
	where NumeroDocumento
	 like '%'+@pNumeroDocumento+'%' order by DocumentoExcepionBuroID desc for xml path('')), 1,1,'')
end
GO

USE BelcorpPanama
GO

IF EXISTS (
    SELECT * FROM sys.objects
    WHERE object_id =
    OBJECT_ID(N'[dbo].[ListarDocumentoExcepcion]')
    AND type in (N'P', N'PC')
)
    DROP PROCEDURE [dbo].[ListarDocumentoExcepcion]
GO

create procedure dbo.ListarDocumentoExcepcion(
	@pNumeroDocumento varchar(30)
)
as
begin
	select stuff(( select '¬' + cast(DocumentoExcepionBuroID as varchar(30)) + '|' + isnull( NumeroDocumento,'') +'|' + isnull(tp.Nombre,'')+'|'+
	isnull(UsuarioCreacion,'') +'|'+ Convert(varchar(10),CONVERT(date,FechaCreacion,106),103)+'|'+ case when isnull(activo,0)=1 then 'Si' else 'No' end
	from dbo.DocumentoExcepcionBuro 
	cross apply (select * from unete.parametrounete where FK_IdTipoPArametro = 20 and valor = TipoDocumento) tp
	where NumeroDocumento
	 like '%'+@pNumeroDocumento+'%' order by DocumentoExcepionBuroID desc for xml path('')), 1,1,'')
end
GO

USE BelcorpGuatemala
GO

IF EXISTS (
    SELECT * FROM sys.objects
    WHERE object_id =
    OBJECT_ID(N'[dbo].[ListarDocumentoExcepcion]')
    AND type in (N'P', N'PC')
)
    DROP PROCEDURE [dbo].[ListarDocumentoExcepcion]
GO

create procedure dbo.ListarDocumentoExcepcion(
	@pNumeroDocumento varchar(30)
)
as
begin
	select stuff(( select '¬' + cast(DocumentoExcepionBuroID as varchar(30)) + '|' + isnull( NumeroDocumento,'') +'|' + isnull(tp.Nombre,'')+'|'+
	isnull(UsuarioCreacion,'') +'|'+ Convert(varchar(10),CONVERT(date,FechaCreacion,106),103)+'|'+ case when isnull(activo,0)=1 then 'Si' else 'No' end
	from dbo.DocumentoExcepcionBuro 
	cross apply (select * from unete.parametrounete where FK_IdTipoPArametro = 20 and valor = TipoDocumento) tp
	where NumeroDocumento
	 like '%'+@pNumeroDocumento+'%' order by DocumentoExcepionBuroID desc for xml path('')), 1,1,'')
end
GO

USE BelcorpEcuador
GO

IF EXISTS (
    SELECT * FROM sys.objects
    WHERE object_id =
    OBJECT_ID(N'[dbo].[ListarDocumentoExcepcion]')
    AND type in (N'P', N'PC')
)
    DROP PROCEDURE [dbo].[ListarDocumentoExcepcion]
GO

create procedure dbo.ListarDocumentoExcepcion(
	@pNumeroDocumento varchar(30)
)
as
begin
	select stuff(( select '¬' + cast(DocumentoExcepionBuroID as varchar(30)) + '|' + isnull( NumeroDocumento,'') +'|' + isnull(tp.Nombre,'')+'|'+
	isnull(UsuarioCreacion,'') +'|'+ Convert(varchar(10),CONVERT(date,FechaCreacion,106),103)+'|'+ case when isnull(activo,0)=1 then 'Si' else 'No' end
	from dbo.DocumentoExcepcionBuro 
	cross apply (select * from unete.parametrounete where FK_IdTipoPArametro = 20 and valor = TipoDocumento) tp
	where NumeroDocumento
	 like '%'+@pNumeroDocumento+'%' order by DocumentoExcepionBuroID desc for xml path('')), 1,1,'')
end
GO

USE BelcorpDominicana
GO

IF EXISTS (
    SELECT * FROM sys.objects
    WHERE object_id =
    OBJECT_ID(N'[dbo].[ListarDocumentoExcepcion]')
    AND type in (N'P', N'PC')
)
    DROP PROCEDURE [dbo].[ListarDocumentoExcepcion]
GO

create procedure dbo.ListarDocumentoExcepcion(
	@pNumeroDocumento varchar(30)
)
as
begin
	select stuff(( select '¬' + cast(DocumentoExcepionBuroID as varchar(30)) + '|' + isnull( NumeroDocumento,'') +'|' + isnull(tp.Nombre,'')+'|'+
	isnull(UsuarioCreacion,'') +'|'+ Convert(varchar(10),CONVERT(date,FechaCreacion,106),103)+'|'+ case when isnull(activo,0)=1 then 'Si' else 'No' end
	from dbo.DocumentoExcepcionBuro 
	cross apply (select * from unete.parametrounete where FK_IdTipoPArametro = 20 and valor = TipoDocumento) tp
	where NumeroDocumento
	 like '%'+@pNumeroDocumento+'%' order by DocumentoExcepionBuroID desc for xml path('')), 1,1,'')
end
GO

USE BelcorpCostaRica
GO

IF EXISTS (
    SELECT * FROM sys.objects
    WHERE object_id =
    OBJECT_ID(N'[dbo].[ListarDocumentoExcepcion]')
    AND type in (N'P', N'PC')
)
    DROP PROCEDURE [dbo].[ListarDocumentoExcepcion]
GO

create procedure dbo.ListarDocumentoExcepcion(
	@pNumeroDocumento varchar(30)
)
as
begin
	select stuff(( select '¬' + cast(DocumentoExcepionBuroID as varchar(30)) + '|' + isnull( NumeroDocumento,'') +'|' + isnull(tp.Nombre,'')+'|'+
	isnull(UsuarioCreacion,'') +'|'+ Convert(varchar(10),CONVERT(date,FechaCreacion,106),103)+'|'+ case when isnull(activo,0)=1 then 'Si' else 'No' end
	from dbo.DocumentoExcepcionBuro 
	cross apply (select * from unete.parametrounete where FK_IdTipoPArametro = 20 and valor = TipoDocumento) tp
	where NumeroDocumento
	 like '%'+@pNumeroDocumento+'%' order by DocumentoExcepionBuroID desc for xml path('')), 1,1,'')
end
GO

USE BelcorpChile
GO

IF EXISTS (
    SELECT * FROM sys.objects
    WHERE object_id =
    OBJECT_ID(N'[dbo].[ListarDocumentoExcepcion]')
    AND type in (N'P', N'PC')
)
    DROP PROCEDURE [dbo].[ListarDocumentoExcepcion]
GO

create procedure dbo.ListarDocumentoExcepcion(
	@pNumeroDocumento varchar(30)
)
as
begin
	select stuff(( select '¬' + cast(DocumentoExcepionBuroID as varchar(30)) + '|' + isnull( NumeroDocumento,'') +'|' + isnull(tp.Nombre,'')+'|'+
	isnull(UsuarioCreacion,'') +'|'+ Convert(varchar(10),CONVERT(date,FechaCreacion,106),103)+'|'+ case when isnull(activo,0)=1 then 'Si' else 'No' end
	from dbo.DocumentoExcepcionBuro 
	cross apply (select * from unete.parametrounete where FK_IdTipoPArametro = 20 and valor = TipoDocumento) tp
	where NumeroDocumento
	 like '%'+@pNumeroDocumento+'%' order by DocumentoExcepionBuroID desc for xml path('')), 1,1,'')
end
GO

USE BelcorpBolivia
GO

IF EXISTS (
    SELECT * FROM sys.objects
    WHERE object_id =
    OBJECT_ID(N'[dbo].[ListarDocumentoExcepcion]')
    AND type in (N'P', N'PC')
)
    DROP PROCEDURE [dbo].[ListarDocumentoExcepcion]
GO

create procedure dbo.ListarDocumentoExcepcion(
	@pNumeroDocumento varchar(30)
)
as
begin
	select stuff(( select '¬' + cast(DocumentoExcepionBuroID as varchar(30)) + '|' + isnull( NumeroDocumento,'') +'|' + isnull(tp.Nombre,'')+'|'+
	isnull(UsuarioCreacion,'') +'|'+ Convert(varchar(10),CONVERT(date,FechaCreacion,106),103)+'|'+ case when isnull(activo,0)=1 then 'Si' else 'No' end
	from dbo.DocumentoExcepcionBuro 
	cross apply (select * from unete.parametrounete where FK_IdTipoPArametro = 20 and valor = TipoDocumento) tp
	where NumeroDocumento
	 like '%'+@pNumeroDocumento+'%' order by DocumentoExcepionBuroID desc for xml path('')), 1,1,'')
end
GO

