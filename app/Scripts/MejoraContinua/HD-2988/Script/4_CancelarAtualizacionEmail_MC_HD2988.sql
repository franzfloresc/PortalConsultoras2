USE BelcorpPeru
GO

ALTER procedure [dbo].[CancelarAtualizacionEmail]
(
 @codConsultora varchar(20)='',
 @TipoEnvio varchar(5) = ''
)
as
begin

    declare @LongCampaniaActivacion int=0
	select @LongCampaniaActivacion=len(isnull(CampaniaActivacionEmail,'')) from validacionDatos where tipoEnvio=@TipoEnvio and CodigoUsuario=@codConsultora

	if @LongCampaniaActivacion=6
	   update validacionDatos
	   set DatoNuevo='',
	   Estado='A'
	   where tipoEnvio=@TipoEnvio and CodigoUsuario=@codConsultora
	else
		delete from validacionDatos where tipoEnvio=@TipoEnvio and CodigoUsuario=@codConsultora
	select 1
end
GO

USE BelcorpMexico
GO

ALTER procedure [dbo].[CancelarAtualizacionEmail]
(
 @codConsultora varchar(20)='',
 @TipoEnvio varchar(5) = ''
)
as
begin

    declare @LongCampaniaActivacion int=0
	select @LongCampaniaActivacion=len(isnull(CampaniaActivacionEmail,'')) from validacionDatos where tipoEnvio=@TipoEnvio and CodigoUsuario=@codConsultora

	if @LongCampaniaActivacion=6
	   update validacionDatos
	   set DatoNuevo='',
	   Estado='A'
	   where tipoEnvio=@TipoEnvio and CodigoUsuario=@codConsultora
	else
		delete from validacionDatos where tipoEnvio=@TipoEnvio and CodigoUsuario=@codConsultora
	select 1
end
GO

USE BelcorpColombia
GO

ALTER procedure [dbo].[CancelarAtualizacionEmail]
(
 @codConsultora varchar(20)='',
 @TipoEnvio varchar(5) = ''
)
as
begin

    declare @LongCampaniaActivacion int=0
	select @LongCampaniaActivacion=len(isnull(CampaniaActivacionEmail,'')) from validacionDatos where tipoEnvio=@TipoEnvio and CodigoUsuario=@codConsultora

	if @LongCampaniaActivacion=6
	   update validacionDatos
	   set DatoNuevo='',
	   Estado='A'
	   where tipoEnvio=@TipoEnvio and CodigoUsuario=@codConsultora
	else
		delete from validacionDatos where tipoEnvio=@TipoEnvio and CodigoUsuario=@codConsultora
	select 1
end
GO

USE BelcorpSalvador
GO

ALTER procedure [dbo].[CancelarAtualizacionEmail]
(
 @codConsultora varchar(20)='',
 @TipoEnvio varchar(5) = ''
)
as
begin

    declare @LongCampaniaActivacion int=0
	select @LongCampaniaActivacion=len(isnull(CampaniaActivacionEmail,'')) from validacionDatos where tipoEnvio=@TipoEnvio and CodigoUsuario=@codConsultora

	if @LongCampaniaActivacion=6
	   update validacionDatos
	   set DatoNuevo='',
	   Estado='A'
	   where tipoEnvio=@TipoEnvio and CodigoUsuario=@codConsultora
	else
		delete from validacionDatos where tipoEnvio=@TipoEnvio and CodigoUsuario=@codConsultora
	select 1
end
GO

USE BelcorpPuertoRico
GO

ALTER procedure [dbo].[CancelarAtualizacionEmail]
(
 @codConsultora varchar(20)='',
 @TipoEnvio varchar(5) = ''
)
as
begin

    declare @LongCampaniaActivacion int=0
	select @LongCampaniaActivacion=len(isnull(CampaniaActivacionEmail,'')) from validacionDatos where tipoEnvio=@TipoEnvio and CodigoUsuario=@codConsultora

	if @LongCampaniaActivacion=6
	   update validacionDatos
	   set DatoNuevo='',
	   Estado='A'
	   where tipoEnvio=@TipoEnvio and CodigoUsuario=@codConsultora
	else
		delete from validacionDatos where tipoEnvio=@TipoEnvio and CodigoUsuario=@codConsultora
	select 1
end
GO

USE BelcorpPanama
GO

ALTER procedure [dbo].[CancelarAtualizacionEmail]
(
 @codConsultora varchar(20)='',
 @TipoEnvio varchar(5) = ''
)
as
begin

    declare @LongCampaniaActivacion int=0
	select @LongCampaniaActivacion=len(isnull(CampaniaActivacionEmail,'')) from validacionDatos where tipoEnvio=@TipoEnvio and CodigoUsuario=@codConsultora

	if @LongCampaniaActivacion=6
	   update validacionDatos
	   set DatoNuevo='',
	   Estado='A'
	   where tipoEnvio=@TipoEnvio and CodigoUsuario=@codConsultora
	else
		delete from validacionDatos where tipoEnvio=@TipoEnvio and CodigoUsuario=@codConsultora
	select 1
end
GO

USE BelcorpGuatemala
GO

ALTER procedure [dbo].[CancelarAtualizacionEmail]
(
 @codConsultora varchar(20)='',
 @TipoEnvio varchar(5) = ''
)
as
begin

    declare @LongCampaniaActivacion int=0
	select @LongCampaniaActivacion=len(isnull(CampaniaActivacionEmail,'')) from validacionDatos where tipoEnvio=@TipoEnvio and CodigoUsuario=@codConsultora

	if @LongCampaniaActivacion=6
	   update validacionDatos
	   set DatoNuevo='',
	   Estado='A'
	   where tipoEnvio=@TipoEnvio and CodigoUsuario=@codConsultora
	else
		delete from validacionDatos where tipoEnvio=@TipoEnvio and CodigoUsuario=@codConsultora
	select 1
end
GO

USE BelcorpEcuador
GO

ALTER procedure [dbo].[CancelarAtualizacionEmail]
(
 @codConsultora varchar(20)='',
 @TipoEnvio varchar(5) = ''
)
as
begin

    declare @LongCampaniaActivacion int=0
	select @LongCampaniaActivacion=len(isnull(CampaniaActivacionEmail,'')) from validacionDatos where tipoEnvio=@TipoEnvio and CodigoUsuario=@codConsultora

	if @LongCampaniaActivacion=6
	   update validacionDatos
	   set DatoNuevo='',
	   Estado='A'
	   where tipoEnvio=@TipoEnvio and CodigoUsuario=@codConsultora
	else
		delete from validacionDatos where tipoEnvio=@TipoEnvio and CodigoUsuario=@codConsultora
	select 1
end
GO

USE BelcorpDominicana
GO

ALTER procedure [dbo].[CancelarAtualizacionEmail]
(
 @codConsultora varchar(20)='',
 @TipoEnvio varchar(5) = ''
)
as
begin

    declare @LongCampaniaActivacion int=0
	select @LongCampaniaActivacion=len(isnull(CampaniaActivacionEmail,'')) from validacionDatos where tipoEnvio=@TipoEnvio and CodigoUsuario=@codConsultora

	if @LongCampaniaActivacion=6
	   update validacionDatos
	   set DatoNuevo='',
	   Estado='A'
	   where tipoEnvio=@TipoEnvio and CodigoUsuario=@codConsultora
	else
		delete from validacionDatos where tipoEnvio=@TipoEnvio and CodigoUsuario=@codConsultora
	select 1
end
GO

USE BelcorpCostaRica
GO

ALTER procedure [dbo].[CancelarAtualizacionEmail]
(
 @codConsultora varchar(20)='',
 @TipoEnvio varchar(5) = ''
)
as
begin

    declare @LongCampaniaActivacion int=0
	select @LongCampaniaActivacion=len(isnull(CampaniaActivacionEmail,'')) from validacionDatos where tipoEnvio=@TipoEnvio and CodigoUsuario=@codConsultora

	if @LongCampaniaActivacion=6
	   update validacionDatos
	   set DatoNuevo='',
	   Estado='A'
	   where tipoEnvio=@TipoEnvio and CodigoUsuario=@codConsultora
	else
		delete from validacionDatos where tipoEnvio=@TipoEnvio and CodigoUsuario=@codConsultora
	select 1
end
GO

USE BelcorpChile
GO

ALTER procedure [dbo].[CancelarAtualizacionEmail]
(
 @codConsultora varchar(20)='',
 @TipoEnvio varchar(5) = ''
)
as
begin

    declare @LongCampaniaActivacion int=0
	select @LongCampaniaActivacion=len(isnull(CampaniaActivacionEmail,'')) from validacionDatos where tipoEnvio=@TipoEnvio and CodigoUsuario=@codConsultora

	if @LongCampaniaActivacion=6
	   update validacionDatos
	   set DatoNuevo='',
	   Estado='A'
	   where tipoEnvio=@TipoEnvio and CodigoUsuario=@codConsultora
	else
		delete from validacionDatos where tipoEnvio=@TipoEnvio and CodigoUsuario=@codConsultora
	select 1
end
GO

USE BelcorpBolivia
GO

ALTER procedure [dbo].[CancelarAtualizacionEmail]
(
 @codConsultora varchar(20)='',
 @TipoEnvio varchar(5) = ''
)
as
begin

    declare @LongCampaniaActivacion int=0
	select @LongCampaniaActivacion=len(isnull(CampaniaActivacionEmail,'')) from validacionDatos where tipoEnvio=@TipoEnvio and CodigoUsuario=@codConsultora

	if @LongCampaniaActivacion=6
	   update validacionDatos
	   set DatoNuevo='',
	   Estado='A'
	   where tipoEnvio=@TipoEnvio and CodigoUsuario=@codConsultora
	else
		delete from validacionDatos where tipoEnvio=@TipoEnvio and CodigoUsuario=@codConsultora
	select 1
end
GO

