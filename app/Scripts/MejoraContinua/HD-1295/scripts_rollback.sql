USE BelcorpPeru
GO

if exists (select 1 from ConfiguracionPais where Codigo = 'PAYONLINE')
begin

delete from ConfiguracionPais where Codigo = 'PAYONLINE'

end

go

if exists (select 1 from TablaLogica where TablaLogicaID = 122)
begin

delete from TablaLogicaDatos where TablaLogicaID = 122
delete from TablaLogica where TablaLogicaID = 122

end

go

alter table TablaLogicaDatos alter column Codigo varchar(10)

go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaResultadoLog') and type = 'U')
   drop table dbo.PagoEnLineaResultadoLog
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertPagoEnLineaResultadoLog]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].InsertPagoEnLineaResultadoLog
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerTokenTarjetaGuardadaByConsultora]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerTokenTarjetaGuardadaByConsultora
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateMontoDeudaConsultora]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].UpdateMontoDeudaConsultora
GO

USE BelcorpMexico
GO

if exists (select 1 from ConfiguracionPais where Codigo = 'PAYONLINE')
begin

delete from ConfiguracionPais where Codigo = 'PAYONLINE'

end

go

if exists (select 1 from TablaLogica where TablaLogicaID = 122)
begin

delete from TablaLogicaDatos where TablaLogicaID = 122
delete from TablaLogica where TablaLogicaID = 122

end

go

alter table TablaLogicaDatos alter column Codigo varchar(10)

go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaResultadoLog') and type = 'U')
   drop table dbo.PagoEnLineaResultadoLog
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertPagoEnLineaResultadoLog]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].InsertPagoEnLineaResultadoLog
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerTokenTarjetaGuardadaByConsultora]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerTokenTarjetaGuardadaByConsultora
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateMontoDeudaConsultora]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].UpdateMontoDeudaConsultora
GO

USE BelcorpColombia
GO

if exists (select 1 from ConfiguracionPais where Codigo = 'PAYONLINE')
begin

delete from ConfiguracionPais where Codigo = 'PAYONLINE'

end

go

if exists (select 1 from TablaLogica where TablaLogicaID = 122)
begin

delete from TablaLogicaDatos where TablaLogicaID = 122
delete from TablaLogica where TablaLogicaID = 122

end

go

alter table TablaLogicaDatos alter column Codigo varchar(10)

go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaResultadoLog') and type = 'U')
   drop table dbo.PagoEnLineaResultadoLog
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertPagoEnLineaResultadoLog]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].InsertPagoEnLineaResultadoLog
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerTokenTarjetaGuardadaByConsultora]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerTokenTarjetaGuardadaByConsultora
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateMontoDeudaConsultora]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].UpdateMontoDeudaConsultora
GO

USE BelcorpVenezuela
GO

if exists (select 1 from ConfiguracionPais where Codigo = 'PAYONLINE')
begin

delete from ConfiguracionPais where Codigo = 'PAYONLINE'

end

go

if exists (select 1 from TablaLogica where TablaLogicaID = 122)
begin

delete from TablaLogicaDatos where TablaLogicaID = 122
delete from TablaLogica where TablaLogicaID = 122

end

go

alter table TablaLogicaDatos alter column Codigo varchar(10)

go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaResultadoLog') and type = 'U')
   drop table dbo.PagoEnLineaResultadoLog
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertPagoEnLineaResultadoLog]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].InsertPagoEnLineaResultadoLog
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerTokenTarjetaGuardadaByConsultora]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerTokenTarjetaGuardadaByConsultora
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateMontoDeudaConsultora]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].UpdateMontoDeudaConsultora
GO

USE BelcorpSalvador
GO

if exists (select 1 from ConfiguracionPais where Codigo = 'PAYONLINE')
begin

delete from ConfiguracionPais where Codigo = 'PAYONLINE'

end

go

if exists (select 1 from TablaLogica where TablaLogicaID = 122)
begin

delete from TablaLogicaDatos where TablaLogicaID = 122
delete from TablaLogica where TablaLogicaID = 122

end

go

alter table TablaLogicaDatos alter column Codigo varchar(10)

go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaResultadoLog') and type = 'U')
   drop table dbo.PagoEnLineaResultadoLog
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertPagoEnLineaResultadoLog]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].InsertPagoEnLineaResultadoLog
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerTokenTarjetaGuardadaByConsultora]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerTokenTarjetaGuardadaByConsultora
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateMontoDeudaConsultora]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].UpdateMontoDeudaConsultora
GO

USE BelcorpPuertoRico
GO

if exists (select 1 from ConfiguracionPais where Codigo = 'PAYONLINE')
begin

delete from ConfiguracionPais where Codigo = 'PAYONLINE'

end

go

if exists (select 1 from TablaLogica where TablaLogicaID = 122)
begin

delete from TablaLogicaDatos where TablaLogicaID = 122
delete from TablaLogica where TablaLogicaID = 122

end

go

alter table TablaLogicaDatos alter column Codigo varchar(10)

go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaResultadoLog') and type = 'U')
   drop table dbo.PagoEnLineaResultadoLog
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertPagoEnLineaResultadoLog]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].InsertPagoEnLineaResultadoLog
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerTokenTarjetaGuardadaByConsultora]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerTokenTarjetaGuardadaByConsultora
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateMontoDeudaConsultora]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].UpdateMontoDeudaConsultora
GO

USE BelcorpPanama
GO

if exists (select 1 from ConfiguracionPais where Codigo = 'PAYONLINE')
begin

delete from ConfiguracionPais where Codigo = 'PAYONLINE'

end

go

if exists (select 1 from TablaLogica where TablaLogicaID = 122)
begin

delete from TablaLogicaDatos where TablaLogicaID = 122
delete from TablaLogica where TablaLogicaID = 122

end

go

alter table TablaLogicaDatos alter column Codigo varchar(10)

go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaResultadoLog') and type = 'U')
   drop table dbo.PagoEnLineaResultadoLog
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertPagoEnLineaResultadoLog]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].InsertPagoEnLineaResultadoLog
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerTokenTarjetaGuardadaByConsultora]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerTokenTarjetaGuardadaByConsultora
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateMontoDeudaConsultora]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].UpdateMontoDeudaConsultora
GO

USE BelcorpGuatemala
GO

if exists (select 1 from ConfiguracionPais where Codigo = 'PAYONLINE')
begin

delete from ConfiguracionPais where Codigo = 'PAYONLINE'

end

go

if exists (select 1 from TablaLogica where TablaLogicaID = 122)
begin

delete from TablaLogicaDatos where TablaLogicaID = 122
delete from TablaLogica where TablaLogicaID = 122

end

go

alter table TablaLogicaDatos alter column Codigo varchar(10)

go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaResultadoLog') and type = 'U')
   drop table dbo.PagoEnLineaResultadoLog
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertPagoEnLineaResultadoLog]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].InsertPagoEnLineaResultadoLog
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerTokenTarjetaGuardadaByConsultora]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerTokenTarjetaGuardadaByConsultora
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateMontoDeudaConsultora]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].UpdateMontoDeudaConsultora
GO

USE BelcorpEcuador
GO

if exists (select 1 from ConfiguracionPais where Codigo = 'PAYONLINE')
begin

delete from ConfiguracionPais where Codigo = 'PAYONLINE'

end

go

if exists (select 1 from TablaLogica where TablaLogicaID = 122)
begin

delete from TablaLogicaDatos where TablaLogicaID = 122
delete from TablaLogica where TablaLogicaID = 122

end

go

alter table TablaLogicaDatos alter column Codigo varchar(10)

go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaResultadoLog') and type = 'U')
   drop table dbo.PagoEnLineaResultadoLog
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertPagoEnLineaResultadoLog]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].InsertPagoEnLineaResultadoLog
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerTokenTarjetaGuardadaByConsultora]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerTokenTarjetaGuardadaByConsultora
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateMontoDeudaConsultora]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].UpdateMontoDeudaConsultora
GO

USE BelcorpDominicana
GO

if exists (select 1 from ConfiguracionPais where Codigo = 'PAYONLINE')
begin

delete from ConfiguracionPais where Codigo = 'PAYONLINE'

end

go

if exists (select 1 from TablaLogica where TablaLogicaID = 122)
begin

delete from TablaLogicaDatos where TablaLogicaID = 122
delete from TablaLogica where TablaLogicaID = 122

end

go

alter table TablaLogicaDatos alter column Codigo varchar(10)

go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaResultadoLog') and type = 'U')
   drop table dbo.PagoEnLineaResultadoLog
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertPagoEnLineaResultadoLog]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].InsertPagoEnLineaResultadoLog
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerTokenTarjetaGuardadaByConsultora]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerTokenTarjetaGuardadaByConsultora
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateMontoDeudaConsultora]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].UpdateMontoDeudaConsultora
GO

USE BelcorpCostaRica
GO

if exists (select 1 from ConfiguracionPais where Codigo = 'PAYONLINE')
begin

delete from ConfiguracionPais where Codigo = 'PAYONLINE'

end

go

if exists (select 1 from TablaLogica where TablaLogicaID = 122)
begin

delete from TablaLogicaDatos where TablaLogicaID = 122
delete from TablaLogica where TablaLogicaID = 122

end

go

alter table TablaLogicaDatos alter column Codigo varchar(10)

go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaResultadoLog') and type = 'U')
   drop table dbo.PagoEnLineaResultadoLog
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertPagoEnLineaResultadoLog]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].InsertPagoEnLineaResultadoLog
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerTokenTarjetaGuardadaByConsultora]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerTokenTarjetaGuardadaByConsultora
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateMontoDeudaConsultora]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].UpdateMontoDeudaConsultora
GO

USE BelcorpChile
GO

if exists (select 1 from ConfiguracionPais where Codigo = 'PAYONLINE')
begin

delete from ConfiguracionPais where Codigo = 'PAYONLINE'

end

go

if exists (select 1 from TablaLogica where TablaLogicaID = 122)
begin

delete from TablaLogicaDatos where TablaLogicaID = 122
delete from TablaLogica where TablaLogicaID = 122

end

go

alter table TablaLogicaDatos alter column Codigo varchar(10)

go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaResultadoLog') and type = 'U')
   drop table dbo.PagoEnLineaResultadoLog
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertPagoEnLineaResultadoLog]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].InsertPagoEnLineaResultadoLog
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerTokenTarjetaGuardadaByConsultora]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerTokenTarjetaGuardadaByConsultora
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateMontoDeudaConsultora]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].UpdateMontoDeudaConsultora
GO

USE BelcorpBolivia
GO

if exists (select 1 from ConfiguracionPais where Codigo = 'PAYONLINE')
begin

delete from ConfiguracionPais where Codigo = 'PAYONLINE'

end

go

if exists (select 1 from TablaLogica where TablaLogicaID = 122)
begin

delete from TablaLogicaDatos where TablaLogicaID = 122
delete from TablaLogica where TablaLogicaID = 122

end

go

alter table TablaLogicaDatos alter column Codigo varchar(10)

go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaResultadoLog') and type = 'U')
   drop table dbo.PagoEnLineaResultadoLog
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertPagoEnLineaResultadoLog]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].InsertPagoEnLineaResultadoLog
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerTokenTarjetaGuardadaByConsultora]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerTokenTarjetaGuardadaByConsultora
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateMontoDeudaConsultora]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].UpdateMontoDeudaConsultora
GO

