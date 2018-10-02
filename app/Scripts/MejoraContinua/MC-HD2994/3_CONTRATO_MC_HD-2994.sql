USE BelcorpPeru 
GO

IF (SELECT count(*) FROM syscolumns
    WHERE id = (SELECT id FROM sysobjects WHERE type = 'U' AND [Name] = 'contrato') and name='IMEI') =0
alter table contrato add IMEI varchar(15)
go
IF(SELECT count(*) FROM syscolumns
   WHERE id = (SELECT id FROM sysobjects WHERE type = 'U' AND [Name] = 'contrato') and name='DeviceID')=0
  alter table contrato add DeviceID varchar(50)
go

USE BelcorpMexico 
GO

IF (SELECT count(*) FROM syscolumns
    WHERE id = (SELECT id FROM sysobjects WHERE type = 'U' AND [Name] = 'contrato') and name='IMEI') =0
alter table contrato add IMEI varchar(15)
go

IF(SELECT count(*) FROM syscolumns
   WHERE id = (SELECT id FROM sysobjects WHERE type = 'U' AND [Name] = 'contrato') and name='DeviceID')=0
  alter table contrato add DeviceID varchar(50)
go

USE BelcorpColombia 
GO

IF (SELECT count(*) FROM syscolumns
    WHERE id = (SELECT id FROM sysobjects WHERE type = 'U' AND [Name] = 'contrato') and name='IMEI') =0
alter table contrato add IMEI varchar(15)
go

IF(SELECT count(*) FROM syscolumns
   WHERE id = (SELECT id FROM sysobjects WHERE type = 'U' AND [Name] = 'contrato') and name='DeviceID')=0
  alter table contrato add DeviceID varchar(50)
go

USE BelcorpSalvador 
GO

IF (SELECT count(*) FROM syscolumns
    WHERE id = (SELECT id FROM sysobjects WHERE type = 'U' AND [Name] = 'contrato') and name='IMEI') =0
alter table contrato add IMEI varchar(15)
go

IF(SELECT count(*) FROM syscolumns
   WHERE id = (SELECT id FROM sysobjects WHERE type = 'U' AND [Name] = 'contrato') and name='DeviceID')=0
  alter table contrato add DeviceID varchar(50)
go

USE BelcorpPuertoRico 
GO

IF (SELECT count(*) FROM syscolumns
    WHERE id = (SELECT id FROM sysobjects WHERE type = 'U' AND [Name] = 'contrato') and name='IMEI') =0
alter table contrato add IMEI varchar(15)
go

IF(SELECT count(*) FROM syscolumns
   WHERE id = (SELECT id FROM sysobjects WHERE type = 'U' AND [Name] = 'contrato') and name='DeviceID')=0
  alter table contrato add DeviceID varchar(50)
go

USE BelcorpPanama 
GO

IF (SELECT count(*) FROM syscolumns
    WHERE id = (SELECT id FROM sysobjects WHERE type = 'U' AND [Name] = 'contrato') and name='IMEI') =0
alter table contrato add IMEI varchar(15)
go

IF(SELECT count(*) FROM syscolumns
   WHERE id = (SELECT id FROM sysobjects WHERE type = 'U' AND [Name] = 'contrato') and name='DeviceID')=0
  alter table contrato add DeviceID varchar(50)
go

USE BelcorpGuatemala 
GO

IF (SELECT count(*) FROM syscolumns
    WHERE id = (SELECT id FROM sysobjects WHERE type = 'U' AND [Name] = 'contrato') and name='IMEI') =0
alter table contrato add IMEI varchar(15)
go

IF(SELECT count(*) FROM syscolumns
   WHERE id = (SELECT id FROM sysobjects WHERE type = 'U' AND [Name] = 'contrato') and name='DeviceID')=0
  alter table contrato add DeviceID varchar(50)
go

USE BelcorpEcuador 
GO

IF (SELECT count(*) FROM syscolumns
    WHERE id = (SELECT id FROM sysobjects WHERE type = 'U' AND [Name] = 'contrato') and name='IMEI') =0
alter table contrato add IMEI varchar(15)
go

IF(SELECT count(*) FROM syscolumns
   WHERE id = (SELECT id FROM sysobjects WHERE type = 'U' AND [Name] = 'contrato') and name='DeviceID')=0
  alter table contrato add DeviceID varchar(50)
go

USE BelcorpDominicana 
GO

IF (SELECT count(*) FROM syscolumns
    WHERE id = (SELECT id FROM sysobjects WHERE type = 'U' AND [Name] = 'contrato') and name='IMEI') =0
alter table contrato add IMEI varchar(15)
go

IF(SELECT count(*) FROM syscolumns
   WHERE id = (SELECT id FROM sysobjects WHERE type = 'U' AND [Name] = 'contrato') and name='DeviceID')=0
  alter table contrato add DeviceID varchar(50)
go

USE BelcorpCostaRica 
GO

IF (SELECT count(*) FROM syscolumns
    WHERE id = (SELECT id FROM sysobjects WHERE type = 'U' AND [Name] = 'contrato') and name='IMEI') =0
alter table contrato add IMEI varchar(15)
go

IF(SELECT count(*) FROM syscolumns
   WHERE id = (SELECT id FROM sysobjects WHERE type = 'U' AND [Name] = 'contrato') and name='DeviceID')=0
  alter table contrato add DeviceID varchar(50)
go

USE BelcorpChile 
GO

IF (SELECT count(*) FROM syscolumns
    WHERE id = (SELECT id FROM sysobjects WHERE type = 'U' AND [Name] = 'contrato') and name='IMEI') =0
alter table contrato add IMEI varchar(15)
go

IF(SELECT count(*) FROM syscolumns
   WHERE id = (SELECT id FROM sysobjects WHERE type = 'U' AND [Name] = 'contrato') and name='DeviceID')=0
  alter table contrato add DeviceID varchar(50)
go

USE BelcorpBolivia 
GO

IF (SELECT count(*) FROM syscolumns
    WHERE id = (SELECT id FROM sysobjects WHERE type = 'U' AND [Name] = 'contrato') and name='IMEI') =0
alter table contrato add IMEI varchar(15)
go

IF(SELECT count(*) FROM syscolumns
   WHERE id = (SELECT id FROM sysobjects WHERE type = 'U' AND [Name] = 'contrato') and name='DeviceID')=0
  alter table contrato add DeviceID varchar(50)
go

USE BelcorpPeru
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'dbo.ObtenerReporteContratoAceptacion') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE ObtenerReporteContratoAceptacion
GO
create procedure ObtenerReporteContratoAceptacion
(
 @CodigoConsultora varchar(25)=null,
 @Cedula varchar(20)=null,
 @fechaInicio datetime=null,
 @fechaFin datetime=null
)
as
begin

		select ROW_NUMBER() OVER(ORDER BY a.CodigoConsultora ASC) AS Registro
       ,a.CodigoConsultora
	   ,concat(concat(concat(concat(b.PrimerNombre,' '),b.PrimerApellido),' '),b.SegundoApellido) as NombreConsultora	  
	   ,case a.AceptoContrato when 1 then 'Acepto' else 'No Acepto' end AceptoContrato
	   ,a.FechaAceptacion
	   ,isnull(a.origen,'') as Origen
	   ,isnull(a.DireccionIP,'') as DireccionIP
	   ,isnull(a.InformacionSOMobile,'') as InformacionSOMobile
	   ,isnull(a.IMEI, '') as   IMEI
	   ,isnull(a.DeviceID,'') as DeviceID
	   from contrato a
	   inner join ods.consultora b  WITH (NOLOCK) on a.CodigoConsultora=b.Codigo
	   inner join ods.identificacion c  WITH (NOLOCK) on c.ConsultoraID=b.ConsultoraID
	   where (@CodigoConsultora is null or @CodigoConsultora='' or a.CodigoConsultora=@CodigoConsultora) and
	         (@Cedula is null  or @Cedula=''  or c.Numero=@Cedula) and
			 ( cast(a.FechaAceptacion as date)>= @fechaInicio and  cast(a.FechaAceptacion as date)<= @fechaFin or(@fechaInicio is null and @fechaFin is null)) 

end
go

USE BelcorpMexico
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'dbo.ObtenerReporteContratoAceptacion') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE ObtenerReporteContratoAceptacion
GO
create procedure ObtenerReporteContratoAceptacion
(
 @CodigoConsultora varchar(25)=null,
 @Cedula varchar(20)=null,
 @fechaInicio datetime=null,
 @fechaFin datetime=null
)
as
begin

		select ROW_NUMBER() OVER(ORDER BY a.CodigoConsultora ASC) AS Registro
       ,a.CodigoConsultora
	   ,concat(concat(concat(concat(b.PrimerNombre,' '),b.PrimerApellido),' '),b.SegundoApellido) as NombreConsultora	  
	   ,case a.AceptoContrato when 1 then 'Acepto' else 'No Acepto' end AceptoContrato
	   ,a.FechaAceptacion
	   ,isnull(a.origen,'') as Origen
	   ,isnull(a.DireccionIP,'') as DireccionIP
	   ,isnull(a.InformacionSOMobile,'') as InformacionSOMobile
	   ,isnull(a.IMEI, '') as   IMEI
	   ,isnull(a.DeviceID,'') as DeviceID
	   from contrato a
	   inner join ods.consultora b  WITH (NOLOCK) on a.CodigoConsultora=b.Codigo
	   inner join ods.identificacion c  WITH (NOLOCK) on c.ConsultoraID=b.ConsultoraID
	   where (@CodigoConsultora is null or @CodigoConsultora='' or a.CodigoConsultora=@CodigoConsultora) and
	         (@Cedula is null  or @Cedula=''  or c.Numero=@Cedula) and
			 ( cast(a.FechaAceptacion as date)>= @fechaInicio and  cast(a.FechaAceptacion as date)<= @fechaFin or(@fechaInicio is null and @fechaFin is null)) 

end
go

USE BelcorpColombia
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'dbo.ObtenerReporteContratoAceptacion') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE ObtenerReporteContratoAceptacion
GO
create procedure ObtenerReporteContratoAceptacion
(
 @CodigoConsultora varchar(25)=null,
 @Cedula varchar(20)=null,
 @fechaInicio datetime=null,
 @fechaFin datetime=null
)
as
begin

		select ROW_NUMBER() OVER(ORDER BY a.CodigoConsultora ASC) AS Registro
       ,a.CodigoConsultora
	   ,concat(concat(concat(concat(b.PrimerNombre,' '),b.PrimerApellido),' '),b.SegundoApellido) as NombreConsultora	  
	   ,case a.AceptoContrato when 1 then 'Acepto' else 'No Acepto' end AceptoContrato
	   ,a.FechaAceptacion
	   ,isnull(a.origen,'') as Origen
	   ,isnull(a.DireccionIP,'') as DireccionIP
	   ,isnull(a.InformacionSOMobile,'') as InformacionSOMobile
	   ,isnull(a.IMEI, '') as   IMEI
	   ,isnull(a.DeviceID,'') as DeviceID
	   from contrato a
	   inner join ods.consultora b  WITH (NOLOCK) on a.CodigoConsultora=b.Codigo
	   inner join ods.identificacion c  WITH (NOLOCK) on c.ConsultoraID=b.ConsultoraID
	   where (@CodigoConsultora is null or @CodigoConsultora='' or a.CodigoConsultora=@CodigoConsultora) and
	         (@Cedula is null  or @Cedula=''  or c.Numero=@Cedula) and
			 ( cast(a.FechaAceptacion as date)>= @fechaInicio and  cast(a.FechaAceptacion as date)<= @fechaFin or(@fechaInicio is null and @fechaFin is null)) 

end
go

USE BelcorpSalvador
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'dbo.ObtenerReporteContratoAceptacion') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE ObtenerReporteContratoAceptacion
GO
create procedure ObtenerReporteContratoAceptacion
(
 @CodigoConsultora varchar(25)=null,
 @Cedula varchar(20)=null,
 @fechaInicio datetime=null,
 @fechaFin datetime=null
)
as
begin

		select ROW_NUMBER() OVER(ORDER BY a.CodigoConsultora ASC) AS Registro
       ,a.CodigoConsultora
	   ,concat(concat(concat(concat(b.PrimerNombre,' '),b.PrimerApellido),' '),b.SegundoApellido) as NombreConsultora	  
	   ,case a.AceptoContrato when 1 then 'Acepto' else 'No Acepto' end AceptoContrato
	   ,a.FechaAceptacion
	   ,isnull(a.origen,'') as Origen
	   ,isnull(a.DireccionIP,'') as DireccionIP
	   ,isnull(a.InformacionSOMobile,'') as InformacionSOMobile
	   ,isnull(a.IMEI, '') as   IMEI
	   ,isnull(a.DeviceID,'') as DeviceID
	   from contrato a
	   inner join ods.consultora b  WITH (NOLOCK) on a.CodigoConsultora=b.Codigo
	   inner join ods.identificacion c  WITH (NOLOCK) on c.ConsultoraID=b.ConsultoraID
	   where (@CodigoConsultora is null or @CodigoConsultora='' or a.CodigoConsultora=@CodigoConsultora) and
	         (@Cedula is null  or @Cedula=''  or c.Numero=@Cedula) and
			 ( cast(a.FechaAceptacion as date)>= @fechaInicio and  cast(a.FechaAceptacion as date)<= @fechaFin or(@fechaInicio is null and @fechaFin is null)) 

end
go

USE BelcorpPuertoRico
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'dbo.ObtenerReporteContratoAceptacion') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE ObtenerReporteContratoAceptacion
GO
create procedure ObtenerReporteContratoAceptacion
(
 @CodigoConsultora varchar(25)=null,
 @Cedula varchar(20)=null,
 @fechaInicio datetime=null,
 @fechaFin datetime=null
)
as
begin

		select ROW_NUMBER() OVER(ORDER BY a.CodigoConsultora ASC) AS Registro
       ,a.CodigoConsultora
	   ,concat(concat(concat(concat(b.PrimerNombre,' '),b.PrimerApellido),' '),b.SegundoApellido) as NombreConsultora	  
	   ,case a.AceptoContrato when 1 then 'Acepto' else 'No Acepto' end AceptoContrato
	   ,a.FechaAceptacion
	   ,isnull(a.origen,'') as Origen
	   ,isnull(a.DireccionIP,'') as DireccionIP
	   ,isnull(a.InformacionSOMobile,'') as InformacionSOMobile
	   ,isnull(a.IMEI, '') as   IMEI
	   ,isnull(a.DeviceID,'') as DeviceID
	   from contrato a
	   inner join ods.consultora b  WITH (NOLOCK) on a.CodigoConsultora=b.Codigo
	   inner join ods.identificacion c  WITH (NOLOCK) on c.ConsultoraID=b.ConsultoraID
	   where (@CodigoConsultora is null or @CodigoConsultora='' or a.CodigoConsultora=@CodigoConsultora) and
	         (@Cedula is null  or @Cedula=''  or c.Numero=@Cedula) and
			 ( cast(a.FechaAceptacion as date)>= @fechaInicio and  cast(a.FechaAceptacion as date)<= @fechaFin or(@fechaInicio is null and @fechaFin is null)) 

end
go

USE BelcorpPanama
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'dbo.ObtenerReporteContratoAceptacion') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE ObtenerReporteContratoAceptacion
GO
create procedure ObtenerReporteContratoAceptacion
(
 @CodigoConsultora varchar(25)=null,
 @Cedula varchar(20)=null,
 @fechaInicio datetime=null,
 @fechaFin datetime=null
)
as
begin

		select ROW_NUMBER() OVER(ORDER BY a.CodigoConsultora ASC) AS Registro
       ,a.CodigoConsultora
	   ,concat(concat(concat(concat(b.PrimerNombre,' '),b.PrimerApellido),' '),b.SegundoApellido) as NombreConsultora	  
	   ,case a.AceptoContrato when 1 then 'Acepto' else 'No Acepto' end AceptoContrato
	   ,a.FechaAceptacion
	   ,isnull(a.origen,'') as Origen
	   ,isnull(a.DireccionIP,'') as DireccionIP
	   ,isnull(a.InformacionSOMobile,'') as InformacionSOMobile
	   ,isnull(a.IMEI, '') as   IMEI
	   ,isnull(a.DeviceID,'') as DeviceID
	   from contrato a
	   inner join ods.consultora b  WITH (NOLOCK) on a.CodigoConsultora=b.Codigo
	   inner join ods.identificacion c  WITH (NOLOCK) on c.ConsultoraID=b.ConsultoraID
	   where (@CodigoConsultora is null or @CodigoConsultora='' or a.CodigoConsultora=@CodigoConsultora) and
	         (@Cedula is null  or @Cedula=''  or c.Numero=@Cedula) and
			 ( cast(a.FechaAceptacion as date)>= @fechaInicio and  cast(a.FechaAceptacion as date)<= @fechaFin or(@fechaInicio is null and @fechaFin is null)) 

end
go

USE BelcorpGuatemala
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'dbo.ObtenerReporteContratoAceptacion') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE ObtenerReporteContratoAceptacion
GO
create procedure ObtenerReporteContratoAceptacion
(
 @CodigoConsultora varchar(25)=null,
 @Cedula varchar(20)=null,
 @fechaInicio datetime=null,
 @fechaFin datetime=null
)
as
begin

		select ROW_NUMBER() OVER(ORDER BY a.CodigoConsultora ASC) AS Registro
       ,a.CodigoConsultora
	   ,concat(concat(concat(concat(b.PrimerNombre,' '),b.PrimerApellido),' '),b.SegundoApellido) as NombreConsultora	  
	   ,case a.AceptoContrato when 1 then 'Acepto' else 'No Acepto' end AceptoContrato
	   ,a.FechaAceptacion
	   ,isnull(a.origen,'') as Origen
	   ,isnull(a.DireccionIP,'') as DireccionIP
	   ,isnull(a.InformacionSOMobile,'') as InformacionSOMobile
	   ,isnull(a.IMEI, '') as   IMEI
	   ,isnull(a.DeviceID,'') as DeviceID
	   from contrato a
	   inner join ods.consultora b  WITH (NOLOCK) on a.CodigoConsultora=b.Codigo
	   inner join ods.identificacion c  WITH (NOLOCK) on c.ConsultoraID=b.ConsultoraID
	   where (@CodigoConsultora is null or @CodigoConsultora='' or a.CodigoConsultora=@CodigoConsultora) and
	         (@Cedula is null  or @Cedula=''  or c.Numero=@Cedula) and
			 ( cast(a.FechaAceptacion as date)>= @fechaInicio and  cast(a.FechaAceptacion as date)<= @fechaFin or(@fechaInicio is null and @fechaFin is null)) 

end
go

USE BelcorpEcuador
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'dbo.ObtenerReporteContratoAceptacion') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE ObtenerReporteContratoAceptacion
GO
create procedure ObtenerReporteContratoAceptacion
(
 @CodigoConsultora varchar(25)=null,
 @Cedula varchar(20)=null,
 @fechaInicio datetime=null,
 @fechaFin datetime=null
)
as
begin

		select ROW_NUMBER() OVER(ORDER BY a.CodigoConsultora ASC) AS Registro
       ,a.CodigoConsultora
	   ,concat(concat(concat(concat(b.PrimerNombre,' '),b.PrimerApellido),' '),b.SegundoApellido) as NombreConsultora	  
	   ,case a.AceptoContrato when 1 then 'Acepto' else 'No Acepto' end AceptoContrato
	   ,a.FechaAceptacion
	   ,isnull(a.origen,'') as Origen
	   ,isnull(a.DireccionIP,'') as DireccionIP
	   ,isnull(a.InformacionSOMobile,'') as InformacionSOMobile
	   ,isnull(a.IMEI, '') as   IMEI
	   ,isnull(a.DeviceID,'') as DeviceID
	   from contrato a
	   inner join ods.consultora b  WITH (NOLOCK) on a.CodigoConsultora=b.Codigo
	   inner join ods.identificacion c  WITH (NOLOCK) on c.ConsultoraID=b.ConsultoraID
	   where (@CodigoConsultora is null or @CodigoConsultora='' or a.CodigoConsultora=@CodigoConsultora) and
	         (@Cedula is null  or @Cedula=''  or c.Numero=@Cedula) and
			 ( cast(a.FechaAceptacion as date)>= @fechaInicio and  cast(a.FechaAceptacion as date)<= @fechaFin or(@fechaInicio is null and @fechaFin is null)) 

end
go

USE BelcorpDominicana
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'dbo.ObtenerReporteContratoAceptacion') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE ObtenerReporteContratoAceptacion
GO
create procedure ObtenerReporteContratoAceptacion
(
 @CodigoConsultora varchar(25)=null,
 @Cedula varchar(20)=null,
 @fechaInicio datetime=null,
 @fechaFin datetime=null
)
as
begin

		select ROW_NUMBER() OVER(ORDER BY a.CodigoConsultora ASC) AS Registro
       ,a.CodigoConsultora
	   ,concat(concat(concat(concat(b.PrimerNombre,' '),b.PrimerApellido),' '),b.SegundoApellido) as NombreConsultora	  
	   ,case a.AceptoContrato when 1 then 'Acepto' else 'No Acepto' end AceptoContrato
	   ,a.FechaAceptacion
	   ,isnull(a.origen,'') as Origen
	   ,isnull(a.DireccionIP,'') as DireccionIP
	   ,isnull(a.InformacionSOMobile,'') as InformacionSOMobile
	   ,isnull(a.IMEI, '') as   IMEI
	   ,isnull(a.DeviceID,'') as DeviceID
	   from contrato a
	   inner join ods.consultora b  WITH (NOLOCK) on a.CodigoConsultora=b.Codigo
	   inner join ods.identificacion c  WITH (NOLOCK) on c.ConsultoraID=b.ConsultoraID
	   where (@CodigoConsultora is null or @CodigoConsultora='' or a.CodigoConsultora=@CodigoConsultora) and
	         (@Cedula is null  or @Cedula=''  or c.Numero=@Cedula) and
			 ( cast(a.FechaAceptacion as date)>= @fechaInicio and  cast(a.FechaAceptacion as date)<= @fechaFin or(@fechaInicio is null and @fechaFin is null)) 

end
go

USE BelcorpCostaRica
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'dbo.ObtenerReporteContratoAceptacion') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE ObtenerReporteContratoAceptacion
GO
create procedure ObtenerReporteContratoAceptacion
(
 @CodigoConsultora varchar(25)=null,
 @Cedula varchar(20)=null,
 @fechaInicio datetime=null,
 @fechaFin datetime=null
)
as
begin

		select ROW_NUMBER() OVER(ORDER BY a.CodigoConsultora ASC) AS Registro
       ,a.CodigoConsultora
	   ,concat(concat(concat(concat(b.PrimerNombre,' '),b.PrimerApellido),' '),b.SegundoApellido) as NombreConsultora	  
	   ,case a.AceptoContrato when 1 then 'Acepto' else 'No Acepto' end AceptoContrato
	   ,a.FechaAceptacion
	   ,isnull(a.origen,'') as Origen
	   ,isnull(a.DireccionIP,'') as DireccionIP
	   ,isnull(a.InformacionSOMobile,'') as InformacionSOMobile
	   ,isnull(a.IMEI, '') as   IMEI
	   ,isnull(a.DeviceID,'') as DeviceID
	   from contrato a
	   inner join ods.consultora b  WITH (NOLOCK) on a.CodigoConsultora=b.Codigo
	   inner join ods.identificacion c  WITH (NOLOCK) on c.ConsultoraID=b.ConsultoraID
	   where (@CodigoConsultora is null or @CodigoConsultora='' or a.CodigoConsultora=@CodigoConsultora) and
	         (@Cedula is null  or @Cedula=''  or c.Numero=@Cedula) and
			 ( cast(a.FechaAceptacion as date)>= @fechaInicio and  cast(a.FechaAceptacion as date)<= @fechaFin or(@fechaInicio is null and @fechaFin is null)) 

end
go

USE BelcorpChile
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'dbo.ObtenerReporteContratoAceptacion') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE ObtenerReporteContratoAceptacion
GO
create procedure ObtenerReporteContratoAceptacion
(
 @CodigoConsultora varchar(25)=null,
 @Cedula varchar(20)=null,
 @fechaInicio datetime=null,
 @fechaFin datetime=null
)
as
begin

		select ROW_NUMBER() OVER(ORDER BY a.CodigoConsultora ASC) AS Registro
       ,a.CodigoConsultora
	   ,concat(concat(concat(concat(b.PrimerNombre,' '),b.PrimerApellido),' '),b.SegundoApellido) as NombreConsultora	  
	   ,case a.AceptoContrato when 1 then 'Acepto' else 'No Acepto' end AceptoContrato
	   ,a.FechaAceptacion
	   ,isnull(a.origen,'') as Origen
	   ,isnull(a.DireccionIP,'') as DireccionIP
	   ,isnull(a.InformacionSOMobile,'') as InformacionSOMobile
	   ,isnull(a.IMEI, '') as   IMEI
	   ,isnull(a.DeviceID,'') as DeviceID
	   from contrato a
	   inner join ods.consultora b  WITH (NOLOCK) on a.CodigoConsultora=b.Codigo
	   inner join ods.identificacion c  WITH (NOLOCK) on c.ConsultoraID=b.ConsultoraID
	   where (@CodigoConsultora is null or @CodigoConsultora='' or a.CodigoConsultora=@CodigoConsultora) and
	         (@Cedula is null  or @Cedula=''  or c.Numero=@Cedula) and
			 ( cast(a.FechaAceptacion as date)>= @fechaInicio and  cast(a.FechaAceptacion as date)<= @fechaFin or(@fechaInicio is null and @fechaFin is null)) 

end
go

USE BelcorpBolivia
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'dbo.ObtenerReporteContratoAceptacion') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE ObtenerReporteContratoAceptacion
GO
create procedure ObtenerReporteContratoAceptacion
(
 @CodigoConsultora varchar(25)=null,
 @Cedula varchar(20)=null,
 @fechaInicio datetime=null,
 @fechaFin datetime=null
)
as
begin

		select ROW_NUMBER() OVER(ORDER BY a.CodigoConsultora ASC) AS Registro
       ,a.CodigoConsultora
	   ,concat(concat(concat(concat(b.PrimerNombre,' '),b.PrimerApellido),' '),b.SegundoApellido) as NombreConsultora	  
	   ,case a.AceptoContrato when 1 then 'Acepto' else 'No Acepto' end AceptoContrato
	   ,a.FechaAceptacion
	   ,isnull(a.origen,'') as Origen
	   ,isnull(a.DireccionIP,'') as DireccionIP
	   ,isnull(a.InformacionSOMobile,'') as InformacionSOMobile
	   ,isnull(a.IMEI, '') as   IMEI
	   ,isnull(a.DeviceID,'') as DeviceID
	   from contrato a
	   inner join ods.consultora b  WITH (NOLOCK) on a.CodigoConsultora=b.Codigo
	   inner join ods.identificacion c  WITH (NOLOCK) on c.ConsultoraID=b.ConsultoraID
	   where (@CodigoConsultora is null or @CodigoConsultora='' or a.CodigoConsultora=@CodigoConsultora) and
	         (@Cedula is null  or @Cedula=''  or c.Numero=@Cedula) and
			 ( cast(a.FechaAceptacion as date)>= @fechaInicio and  cast(a.FechaAceptacion as date)<= @fechaFin or(@fechaInicio is null and @fechaFin is null)) 

end
go
