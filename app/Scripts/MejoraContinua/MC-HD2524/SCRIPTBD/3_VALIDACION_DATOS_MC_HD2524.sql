USE BelcorpPeru
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetActualizacionEmail]') 
	AND type in (N'P', N'PC')
) 
DROP PROCEDURE [dbo].[GetActualizacionEmail]
GO
CREATE procedure [dbo].[GetActualizacionEmail]
(
 @codConsultora varchar(20)=''
)
as
begin
 if exists (select 1 from validacionDatos where tipoEnvio='email' and Estado='P' and CodigoUsuario= @codConsultora)
  select top 1 '1'+'|'+ datoNuevo from validacionDatos where tipoEnvio='email' and Estado='P' and CodigoUsuario= @codConsultora
 else
  select 0
end
go

USE BelcorpMexico
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetActualizacionEmail]') 
	AND type in (N'P', N'PC')
) 
DROP PROCEDURE [dbo].[GetActualizacionEmail]
GO
CREATE procedure [dbo].[GetActualizacionEmail]
(
 @codConsultora varchar(20)=''
)
as
begin
 if exists (select 1 from validacionDatos where tipoEnvio='email' and Estado='P' and CodigoUsuario= @codConsultora)
  select top 1 '1'+'|'+ datoNuevo from validacionDatos where tipoEnvio='email' and Estado='P' and CodigoUsuario= @codConsultora
 else
  select 0
end
go

USE BelcorpColombia
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetActualizacionEmail]') 
	AND type in (N'P', N'PC')
) 
DROP PROCEDURE [dbo].[GetActualizacionEmail]
GO
CREATE procedure [dbo].[GetActualizacionEmail]
(
 @codConsultora varchar(20)=''
)
as
begin
 if exists (select 1 from validacionDatos where tipoEnvio='email' and Estado='P' and CodigoUsuario= @codConsultora)
  select top 1 '1'+'|'+ datoNuevo from validacionDatos where tipoEnvio='email' and Estado='P' and CodigoUsuario= @codConsultora
 else
  select 0
end
go

USE BelcorpSalvador
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetActualizacionEmail]') 
	AND type in (N'P', N'PC')
) 
DROP PROCEDURE [dbo].[GetActualizacionEmail]
GO
CREATE procedure [dbo].[GetActualizacionEmail]
(
 @codConsultora varchar(20)=''
)
as
begin
 if exists (select 1 from validacionDatos where tipoEnvio='email' and Estado='P' and CodigoUsuario= @codConsultora)
  select top 1 '1'+'|'+ datoNuevo from validacionDatos where tipoEnvio='email' and Estado='P' and CodigoUsuario= @codConsultora
 else
  select 0
end
go

USE BelcorpPuertoRico
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetActualizacionEmail]') 
	AND type in (N'P', N'PC')
) 
DROP PROCEDURE [dbo].[GetActualizacionEmail]
GO
CREATE procedure [dbo].[GetActualizacionEmail]
(
 @codConsultora varchar(20)=''
)
as
begin
 if exists (select 1 from validacionDatos where tipoEnvio='email' and Estado='P' and CodigoUsuario= @codConsultora)
  select top 1 '1'+'|'+ datoNuevo from validacionDatos where tipoEnvio='email' and Estado='P' and CodigoUsuario= @codConsultora
 else
  select 0
end
go

USE BelcorpPanama
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetActualizacionEmail]') 
	AND type in (N'P', N'PC')
) 
DROP PROCEDURE [dbo].[GetActualizacionEmail]
GO
CREATE procedure [dbo].[GetActualizacionEmail]
(
 @codConsultora varchar(20)=''
)
as
begin
 if exists (select 1 from validacionDatos where tipoEnvio='email' and Estado='P' and CodigoUsuario= @codConsultora)
  select top 1 '1'+'|'+ datoNuevo from validacionDatos where tipoEnvio='email' and Estado='P' and CodigoUsuario= @codConsultora
 else
  select 0
end
go

USE BelcorpGuatemala
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetActualizacionEmail]') 
	AND type in (N'P', N'PC')
) 
DROP PROCEDURE [dbo].[GetActualizacionEmail]
GO
CREATE procedure [dbo].[GetActualizacionEmail]
(
 @codConsultora varchar(20)=''
)
as
begin
 if exists (select 1 from validacionDatos where tipoEnvio='email' and Estado='P' and CodigoUsuario= @codConsultora)
  select top 1 '1'+'|'+ datoNuevo from validacionDatos where tipoEnvio='email' and Estado='P' and CodigoUsuario= @codConsultora
 else
  select 0
end
go

USE BelcorpEcuador
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetActualizacionEmail]') 
	AND type in (N'P', N'PC')
) 
DROP PROCEDURE [dbo].[GetActualizacionEmail]
GO
CREATE procedure [dbo].[GetActualizacionEmail]
(
 @codConsultora varchar(20)=''
)
as
begin
 if exists (select 1 from validacionDatos where tipoEnvio='email' and Estado='P' and CodigoUsuario= @codConsultora)
  select top 1 '1'+'|'+ datoNuevo from validacionDatos where tipoEnvio='email' and Estado='P' and CodigoUsuario= @codConsultora
 else
  select 0
end
go

USE BelcorpDominicana
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetActualizacionEmail]') 
	AND type in (N'P', N'PC')
) 
DROP PROCEDURE [dbo].[GetActualizacionEmail]
GO
CREATE procedure [dbo].[GetActualizacionEmail]
(
 @codConsultora varchar(20)=''
)
as
begin
 if exists (select 1 from validacionDatos where tipoEnvio='email' and Estado='P' and CodigoUsuario= @codConsultora)
  select top 1 '1'+'|'+ datoNuevo from validacionDatos where tipoEnvio='email' and Estado='P' and CodigoUsuario= @codConsultora
 else
  select 0
end
go

USE BelcorpCostaRica
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetActualizacionEmail]') 
	AND type in (N'P', N'PC')
) 
DROP PROCEDURE [dbo].[GetActualizacionEmail]
GO
CREATE procedure [dbo].[GetActualizacionEmail]
(
 @codConsultora varchar(20)=''
)
as
begin
 if exists (select 1 from validacionDatos where tipoEnvio='email' and Estado='P' and CodigoUsuario= @codConsultora)
  select top 1 '1'+'|'+ datoNuevo from validacionDatos where tipoEnvio='email' and Estado='P' and CodigoUsuario= @codConsultora
 else
  select 0
end
go

USE BelcorpChile
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetActualizacionEmail]') 
	AND type in (N'P', N'PC')
) 
DROP PROCEDURE [dbo].[GetActualizacionEmail]
GO
CREATE procedure [dbo].[GetActualizacionEmail]
(
 @codConsultora varchar(20)=''
)
as
begin
 if exists (select 1 from validacionDatos where tipoEnvio='email' and Estado='P' and CodigoUsuario= @codConsultora)
  select top 1 '1'+'|'+ datoNuevo from validacionDatos where tipoEnvio='email' and Estado='P' and CodigoUsuario= @codConsultora
 else
  select 0
end
go

USE BelcorpBolivia
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetActualizacionEmail]') 
	AND type in (N'P', N'PC')
) 
DROP PROCEDURE [dbo].[GetActualizacionEmail]
GO
CREATE procedure [dbo].[GetActualizacionEmail]
(
 @codConsultora varchar(20)=''
)
as
begin
 if exists (select 1 from validacionDatos where tipoEnvio='email' and Estado='P' and CodigoUsuario= @codConsultora)
  select top 1 '1'+'|'+ datoNuevo from validacionDatos where tipoEnvio='email' and Estado='P' and CodigoUsuario= @codConsultora
 else
  select 0
end
go