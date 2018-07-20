USE BelcorpPeru
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[CancelarAtualizacionEmail]') 
	AND type in (N'P', N'PC')
) 
DROP PROCEDURE [dbo].[CancelarAtualizacionEmail]
GO
CREATE procedure CancelarAtualizacionEmail
(
 @codConsultora varchar(20)=''
)
as
begin

    declare @LongCampaniaActivacion int=0
	select @LongCampaniaActivacion=len(isnull(CampaniaActivacionEmail,'')) from validacionDatos where tipoEnvio='email' and CodigoUsuario=@codConsultora

	if @LongCampaniaActivacion=6
	   update validacionDatos
	   set DatoNuevo='',
	   Estado='A'
	   where tipoEnvio='email' and CodigoUsuario=@codConsultora
	else
		delete from validacionDatos where tipoEnvio='email' and CodigoUsuario=@codConsultora
	select 1
end
GO

USE BelcorpMexico
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[CancelarAtualizacionEmail]') 
	AND type in (N'P', N'PC')
) 
DROP PROCEDURE [dbo].[CancelarAtualizacionEmail]
GO
CREATE procedure CancelarAtualizacionEmail
(
 @codConsultora varchar(20)=''
)
as
begin

    declare @LongCampaniaActivacion int=0
	select @LongCampaniaActivacion=len(isnull(CampaniaActivacionEmail,'')) from validacionDatos where tipoEnvio='email' and CodigoUsuario=@codConsultora

	if @LongCampaniaActivacion=6
	   update validacionDatos
	   set DatoNuevo='',
	   Estado='A'
	   where tipoEnvio='email' and CodigoUsuario=@codConsultora
	else
		delete from validacionDatos where tipoEnvio='email' and CodigoUsuario=@codConsultora
	select 1
end
GO

USE BelcorpColombia
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[CancelarAtualizacionEmail]') 
	AND type in (N'P', N'PC')
) 
DROP PROCEDURE [dbo].[CancelarAtualizacionEmail]
GO
CREATE procedure CancelarAtualizacionEmail
(
 @codConsultora varchar(20)=''
)
as
begin

    declare @LongCampaniaActivacion int=0
	select @LongCampaniaActivacion=len(isnull(CampaniaActivacionEmail,'')) from validacionDatos where tipoEnvio='email' and CodigoUsuario=@codConsultora

	if @LongCampaniaActivacion=6
	   update validacionDatos
	   set DatoNuevo='',
	   Estado='A'
	   where tipoEnvio='email' and CodigoUsuario=@codConsultora
	else
		delete from validacionDatos where tipoEnvio='email' and CodigoUsuario=@codConsultora
	select 1
end
GO

USE BelcorpSalvador
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[CancelarAtualizacionEmail]') 
	AND type in (N'P', N'PC')
) 
DROP PROCEDURE [dbo].[CancelarAtualizacionEmail]
GO
CREATE procedure CancelarAtualizacionEmail
(
 @codConsultora varchar(20)=''
)
as
begin

    declare @LongCampaniaActivacion int=0
	select @LongCampaniaActivacion=len(isnull(CampaniaActivacionEmail,'')) from validacionDatos where tipoEnvio='email' and CodigoUsuario=@codConsultora

	if @LongCampaniaActivacion=6
	   update validacionDatos
	   set DatoNuevo='',
	   Estado='A'
	   where tipoEnvio='email' and CodigoUsuario=@codConsultora
	else
		delete from validacionDatos where tipoEnvio='email' and CodigoUsuario=@codConsultora
	select 1
end
GO

USE BelcorpPuertoRico
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[CancelarAtualizacionEmail]') 
	AND type in (N'P', N'PC')
) 
DROP PROCEDURE [dbo].[CancelarAtualizacionEmail]
GO
CREATE procedure CancelarAtualizacionEmail
(
 @codConsultora varchar(20)=''
)
as
begin

    declare @LongCampaniaActivacion int=0
	select @LongCampaniaActivacion=len(isnull(CampaniaActivacionEmail,'')) from validacionDatos where tipoEnvio='email' and CodigoUsuario=@codConsultora

	if @LongCampaniaActivacion=6
	   update validacionDatos
	   set DatoNuevo='',
	   Estado='A'
	   where tipoEnvio='email' and CodigoUsuario=@codConsultora
	else
		delete from validacionDatos where tipoEnvio='email' and CodigoUsuario=@codConsultora
	select 1
end
GO

USE BelcorpPanama
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[CancelarAtualizacionEmail]') 
	AND type in (N'P', N'PC')
) 
DROP PROCEDURE [dbo].[CancelarAtualizacionEmail]
GO
CREATE procedure CancelarAtualizacionEmail
(
 @codConsultora varchar(20)=''
)
as
begin

    declare @LongCampaniaActivacion int=0
	select @LongCampaniaActivacion=len(isnull(CampaniaActivacionEmail,'')) from validacionDatos where tipoEnvio='email' and CodigoUsuario=@codConsultora

	if @LongCampaniaActivacion=6
	   update validacionDatos
	   set DatoNuevo='',
	   Estado='A'
	   where tipoEnvio='email' and CodigoUsuario=@codConsultora
	else
		delete from validacionDatos where tipoEnvio='email' and CodigoUsuario=@codConsultora
	select 1
end
GO

USE BelcorpGuatemala
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[CancelarAtualizacionEmail]') 
	AND type in (N'P', N'PC')
) 
DROP PROCEDURE [dbo].[CancelarAtualizacionEmail]
GO
CREATE procedure CancelarAtualizacionEmail
(
 @codConsultora varchar(20)=''
)
as
begin

    declare @LongCampaniaActivacion int=0
	select @LongCampaniaActivacion=len(isnull(CampaniaActivacionEmail,'')) from validacionDatos where tipoEnvio='email' and CodigoUsuario=@codConsultora

	if @LongCampaniaActivacion=6
	   update validacionDatos
	   set DatoNuevo='',
	   Estado='A'
	   where tipoEnvio='email' and CodigoUsuario=@codConsultora
	else
		delete from validacionDatos where tipoEnvio='email' and CodigoUsuario=@codConsultora
	select 1
end
GO

USE BelcorpEcuador
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[CancelarAtualizacionEmail]') 
	AND type in (N'P', N'PC')
) 
DROP PROCEDURE [dbo].[CancelarAtualizacionEmail]
GO
CREATE procedure CancelarAtualizacionEmail
(
 @codConsultora varchar(20)=''
)
as
begin

    declare @LongCampaniaActivacion int=0
	select @LongCampaniaActivacion=len(isnull(CampaniaActivacionEmail,'')) from validacionDatos where tipoEnvio='email' and CodigoUsuario=@codConsultora

	if @LongCampaniaActivacion=6
	   update validacionDatos
	   set DatoNuevo='',
	   Estado='A'
	   where tipoEnvio='email' and CodigoUsuario=@codConsultora
	else
		delete from validacionDatos where tipoEnvio='email' and CodigoUsuario=@codConsultora
	select 1
end
GO

USE BelcorpDominicana
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[CancelarAtualizacionEmail]') 
	AND type in (N'P', N'PC')
) 
DROP PROCEDURE [dbo].[CancelarAtualizacionEmail]
GO
CREATE procedure CancelarAtualizacionEmail
(
 @codConsultora varchar(20)=''
)
as
begin

    declare @LongCampaniaActivacion int=0
	select @LongCampaniaActivacion=len(isnull(CampaniaActivacionEmail,'')) from validacionDatos where tipoEnvio='email' and CodigoUsuario=@codConsultora

	if @LongCampaniaActivacion=6
	   update validacionDatos
	   set DatoNuevo='',
	   Estado='A'
	   where tipoEnvio='email' and CodigoUsuario=@codConsultora
	else
		delete from validacionDatos where tipoEnvio='email' and CodigoUsuario=@codConsultora
	select 1
end
GO

USE BelcorpCostaRica
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[CancelarAtualizacionEmail]') 
	AND type in (N'P', N'PC')
) 
DROP PROCEDURE [dbo].[CancelarAtualizacionEmail]
GO
CREATE procedure CancelarAtualizacionEmail
(
 @codConsultora varchar(20)=''
)
as
begin

    declare @LongCampaniaActivacion int=0
	select @LongCampaniaActivacion=len(isnull(CampaniaActivacionEmail,'')) from validacionDatos where tipoEnvio='email' and CodigoUsuario=@codConsultora

	if @LongCampaniaActivacion=6
	   update validacionDatos
	   set DatoNuevo='',
	   Estado='A'
	   where tipoEnvio='email' and CodigoUsuario=@codConsultora
	else
		delete from validacionDatos where tipoEnvio='email' and CodigoUsuario=@codConsultora
	select 1
end
GO

USE BelcorpChile
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[CancelarAtualizacionEmail]') 
	AND type in (N'P', N'PC')
) 
DROP PROCEDURE [dbo].[CancelarAtualizacionEmail]
GO
CREATE procedure CancelarAtualizacionEmail
(
 @codConsultora varchar(20)=''
)
as
begin

    declare @LongCampaniaActivacion int=0
	select @LongCampaniaActivacion=len(isnull(CampaniaActivacionEmail,'')) from validacionDatos where tipoEnvio='email' and CodigoUsuario=@codConsultora

	if @LongCampaniaActivacion=6
	   update validacionDatos
	   set DatoNuevo='',
	   Estado='A'
	   where tipoEnvio='email' and CodigoUsuario=@codConsultora
	else
		delete from validacionDatos where tipoEnvio='email' and CodigoUsuario=@codConsultora
	select 1
end
GO

USE BelcorpBolivia
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[CancelarAtualizacionEmail]') 
	AND type in (N'P', N'PC')
) 
DROP PROCEDURE [dbo].[CancelarAtualizacionEmail]
GO
CREATE procedure CancelarAtualizacionEmail
(
 @codConsultora varchar(20)=''
)
as
begin

    declare @LongCampaniaActivacion int=0
	select @LongCampaniaActivacion=len(isnull(CampaniaActivacionEmail,'')) from validacionDatos where tipoEnvio='email' and CodigoUsuario=@codConsultora

	if @LongCampaniaActivacion=6
	   update validacionDatos
	   set DatoNuevo='',
	   Estado='A'
	   where tipoEnvio='email' and CodigoUsuario=@codConsultora
	else
		delete from validacionDatos where tipoEnvio='email' and CodigoUsuario=@codConsultora
	select 1
end
GO

