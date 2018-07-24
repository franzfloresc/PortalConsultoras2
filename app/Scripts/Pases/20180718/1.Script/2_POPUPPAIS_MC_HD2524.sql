USE BelcorpPeru
GO
if  exists (select 1 from POPUPPAIS where POPUPPAISID=13)
begin
  UPDATE POPUPPAIS
  SET CodigoPopup=13,
      Descripcion='ActualizarCorreo',
	  CodigoIso='PE',
	  Orden=12,
	  Activo=0
 where POPUPPAISID=13
end
else
INSERT INTO POPUPPAIS VALUES(13,'ActualizarCorreo','PE',12,0)
go

USE BelcorpMexico
GO
if  exists (select 1 from POPUPPAIS where POPUPPAISID=13)
begin
  UPDATE POPUPPAIS
  SET CodigoPopup=13,
      Descripcion='ActualizarCorreo',
	  CodigoIso='MX',
	  Orden=12,
	  Activo=0
 where POPUPPAISID=13
end
else
INSERT INTO POPUPPAIS VALUES(13,'ActualizarCorreo','MX',12,0)
go

USE BelcorpColombia
GO

if  exists (select 1 from POPUPPAIS where POPUPPAISID=13)
begin
  UPDATE POPUPPAIS
  SET CodigoPopup=13,
      Descripcion='ActualizarCorreo',
	  CodigoIso='CO',
	  Orden=12,
	  Activo=0
 where POPUPPAISID=13
end
else
INSERT INTO POPUPPAIS VALUES(13,'ActualizarCorreo','CO',12,0)
go

USE BelcorpSalvador
GO

if  exists (select 1 from POPUPPAIS where POPUPPAISID=13)
begin
  UPDATE POPUPPAIS
  SET CodigoPopup=13,
      Descripcion='ActualizarCorreo',
	  CodigoIso='SV',
	  Orden=12,
	  Activo=0
 where POPUPPAISID=13
end
else
INSERT INTO POPUPPAIS VALUES(13,'ActualizarCorreo','SV',12,0)
go


USE BelcorpPuertoRico
GO
if  exists (select 1 from POPUPPAIS where POPUPPAISID=13)
begin
  UPDATE POPUPPAIS
  SET CodigoPopup=13,
      Descripcion='ActualizarCorreo',
	  CodigoIso='PR',
	  Orden=12,
	  Activo=0
 where POPUPPAISID=13
end
else
INSERT INTO POPUPPAIS VALUES(13,'ActualizarCorreo','PR',12,0)
go

USE BelcorpPanama
GO
if  exists (select 1 from POPUPPAIS where POPUPPAISID=13)
begin
  UPDATE POPUPPAIS
  SET CodigoPopup=13,
      Descripcion='ActualizarCorreo',
	  CodigoIso='PA',
	  Orden=12,
	  Activo=0
 where POPUPPAISID=13
end
else
INSERT INTO POPUPPAIS VALUES(13,'ActualizarCorreo','PA',12,0)
go
USE BelcorpGuatemala
GO

if  exists (select 1 from POPUPPAIS where POPUPPAISID=13)
begin
  UPDATE POPUPPAIS
  SET CodigoPopup=13,
      Descripcion='ActualizarCorreo',
	  CodigoIso='GT',
	  Orden=12,
	  Activo=0
 where POPUPPAISID=13
end
else
INSERT INTO POPUPPAIS VALUES(13,'ActualizarCorreo','GT',12,0)
go

USE BelcorpEcuador
GO
if  exists (select 1 from POPUPPAIS where POPUPPAISID=13)
begin
  UPDATE POPUPPAIS
  SET CodigoPopup=13,
      Descripcion='ActualizarCorreo',
	  CodigoIso='EC',
	  Orden=12,
	  Activo=0
 where POPUPPAISID=13
end
else
INSERT INTO POPUPPAIS VALUES(13,'ActualizarCorreo','EC',12,0)
go

USE BelcorpDominicana
GO

if  exists (select 1 from POPUPPAIS where POPUPPAISID=13)
begin
  UPDATE POPUPPAIS
  SET CodigoPopup=13,
      Descripcion='ActualizarCorreo',
	  CodigoIso='DO',
	  Orden=12,
	  Activo=0
 where POPUPPAISID=13
end
else
INSERT INTO POPUPPAIS VALUES(13,'ActualizarCorreo','DO',12,0)
go

USE BelcorpCostaRica
GO

if  exists (select 1 from POPUPPAIS where POPUPPAISID=13)
begin
  UPDATE POPUPPAIS
  SET CodigoPopup=13,
      Descripcion='ActualizarCorreo',
	  CodigoIso='CR',
	  Orden=12,
	  Activo=0
 where POPUPPAISID=13
end
else
INSERT INTO POPUPPAIS VALUES(13,'ActualizarCorreo','CR',12,0)
go

USE BelcorpChile
GO
if  exists (select 1 from POPUPPAIS where POPUPPAISID=13)
begin
  UPDATE POPUPPAIS
  SET CodigoPopup=13,
      Descripcion='ActualizarCorreo',
	  CodigoIso='CL',
	  Orden=12,
	  Activo=0
 where POPUPPAISID=13
end
else
INSERT INTO POPUPPAIS VALUES(13,'ActualizarCorreo','CL',12,0)
go

USE BelcorpBolivia
GO
if  exists (select 1 from POPUPPAIS where POPUPPAISID=13)
begin
  UPDATE POPUPPAIS
  SET CodigoPopup=13,
      Descripcion='ActualizarCorreo',
	  CodigoIso='BO',
	  Orden=12,
	  Activo=0
 where POPUPPAISID=13
end
else
INSERT INTO POPUPPAIS VALUES(13,'ActualizarCorreo','BO',12,0)
go