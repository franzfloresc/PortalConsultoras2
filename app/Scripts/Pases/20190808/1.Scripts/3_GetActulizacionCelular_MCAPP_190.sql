USE BelcorpPeru
GO

GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetActualizacionCelular]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetActualizacionCelular]
GO

CREATE procedure [dbo].[GetActualizacionCelular]
(
@codConsultora varchar(20)=''
)
as
begin
if exists (select 1 from validacionDatos where tipoEnvio='SMS' and Estado='P' and CodigoUsuario= @codConsultora)
select top 1 '1'+'|'+ datoNuevo from validacionDatos where tipoEnvio='SMS' and Estado='P' and CodigoUsuario= @codConsultora
else
select 0
end

GO

USE BelcorpMexico
GO

GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetActualizacionCelular]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetActualizacionCelular]
GO

CREATE procedure [dbo].[GetActualizacionCelular]
(
@codConsultora varchar(20)=''
)
as
begin
if exists (select 1 from validacionDatos where tipoEnvio='SMS' and Estado='P' and CodigoUsuario= @codConsultora)
select top 1 '1'+'|'+ datoNuevo from validacionDatos where tipoEnvio='SMS' and Estado='P' and CodigoUsuario= @codConsultora
else
select 0
end

GO

USE BelcorpColombia
GO

GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetActualizacionCelular]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetActualizacionCelular]
GO

CREATE procedure [dbo].[GetActualizacionCelular]
(
@codConsultora varchar(20)=''
)
as
begin
if exists (select 1 from validacionDatos where tipoEnvio='SMS' and Estado='P' and CodigoUsuario= @codConsultora)
select top 1 '1'+'|'+ datoNuevo from validacionDatos where tipoEnvio='SMS' and Estado='P' and CodigoUsuario= @codConsultora
else
select 0
end

GO

USE BelcorpSalvador
GO

GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetActualizacionCelular]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetActualizacionCelular]
GO

CREATE procedure [dbo].[GetActualizacionCelular]
(
@codConsultora varchar(20)=''
)
as
begin
if exists (select 1 from validacionDatos where tipoEnvio='SMS' and Estado='P' and CodigoUsuario= @codConsultora)
select top 1 '1'+'|'+ datoNuevo from validacionDatos where tipoEnvio='SMS' and Estado='P' and CodigoUsuario= @codConsultora
else
select 0
end

GO

USE BelcorpPuertoRico
GO

GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetActualizacionCelular]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetActualizacionCelular]
GO

CREATE procedure [dbo].[GetActualizacionCelular]
(
@codConsultora varchar(20)=''
)
as
begin
if exists (select 1 from validacionDatos where tipoEnvio='SMS' and Estado='P' and CodigoUsuario= @codConsultora)
select top 1 '1'+'|'+ datoNuevo from validacionDatos where tipoEnvio='SMS' and Estado='P' and CodigoUsuario= @codConsultora
else
select 0
end

GO

USE BelcorpPanama
GO

GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetActualizacionCelular]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetActualizacionCelular]
GO

CREATE procedure [dbo].[GetActualizacionCelular]
(
@codConsultora varchar(20)=''
)
as
begin
if exists (select 1 from validacionDatos where tipoEnvio='SMS' and Estado='P' and CodigoUsuario= @codConsultora)
select top 1 '1'+'|'+ datoNuevo from validacionDatos where tipoEnvio='SMS' and Estado='P' and CodigoUsuario= @codConsultora
else
select 0
end

GO

USE BelcorpGuatemala
GO

GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetActualizacionCelular]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetActualizacionCelular]
GO

CREATE procedure [dbo].[GetActualizacionCelular]
(
@codConsultora varchar(20)=''
)
as
begin
if exists (select 1 from validacionDatos where tipoEnvio='SMS' and Estado='P' and CodigoUsuario= @codConsultora)
select top 1 '1'+'|'+ datoNuevo from validacionDatos where tipoEnvio='SMS' and Estado='P' and CodigoUsuario= @codConsultora
else
select 0
end

GO

USE BelcorpEcuador
GO

GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetActualizacionCelular]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetActualizacionCelular]
GO

CREATE procedure [dbo].[GetActualizacionCelular]
(
@codConsultora varchar(20)=''
)
as
begin
if exists (select 1 from validacionDatos where tipoEnvio='SMS' and Estado='P' and CodigoUsuario= @codConsultora)
select top 1 '1'+'|'+ datoNuevo from validacionDatos where tipoEnvio='SMS' and Estado='P' and CodigoUsuario= @codConsultora
else
select 0
end

GO

USE BelcorpDominicana
GO

GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetActualizacionCelular]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetActualizacionCelular]
GO

CREATE procedure [dbo].[GetActualizacionCelular]
(
@codConsultora varchar(20)=''
)
as
begin
if exists (select 1 from validacionDatos where tipoEnvio='SMS' and Estado='P' and CodigoUsuario= @codConsultora)
select top 1 '1'+'|'+ datoNuevo from validacionDatos where tipoEnvio='SMS' and Estado='P' and CodigoUsuario= @codConsultora
else
select 0
end

GO

USE BelcorpCostaRica
GO

GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetActualizacionCelular]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetActualizacionCelular]
GO

CREATE procedure [dbo].[GetActualizacionCelular]
(
@codConsultora varchar(20)=''
)
as
begin
if exists (select 1 from validacionDatos where tipoEnvio='SMS' and Estado='P' and CodigoUsuario= @codConsultora)
select top 1 '1'+'|'+ datoNuevo from validacionDatos where tipoEnvio='SMS' and Estado='P' and CodigoUsuario= @codConsultora
else
select 0
end

GO

USE BelcorpChile
GO

GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetActualizacionCelular]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetActualizacionCelular]
GO

CREATE procedure [dbo].[GetActualizacionCelular]
(
@codConsultora varchar(20)=''
)
as
begin
if exists (select 1 from validacionDatos where tipoEnvio='SMS' and Estado='P' and CodigoUsuario= @codConsultora)
select top 1 '1'+'|'+ datoNuevo from validacionDatos where tipoEnvio='SMS' and Estado='P' and CodigoUsuario= @codConsultora
else
select 0
end

GO

USE BelcorpBolivia
GO

GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetActualizacionCelular]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetActualizacionCelular]
GO

CREATE procedure [dbo].[GetActualizacionCelular]
(
@codConsultora varchar(20)=''
)
as
begin
if exists (select 1 from validacionDatos where tipoEnvio='SMS' and Estado='P' and CodigoUsuario= @codConsultora)
select top 1 '1'+'|'+ datoNuevo from validacionDatos where tipoEnvio='SMS' and Estado='P' and CodigoUsuario= @codConsultora
else
select 0
end

GO

