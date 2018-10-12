USE BelcorpPeru
GO

/* ROOLBACK */
IF COL_LENGTH('OpcionesVerificacion', 'OpcionContrasena') IS NOT NULL
BEGIN
  IF OBJECT_ID('DF_OpcionesVerificacion_OpcionContrasena') IS NOT NULL 
  BEGIN
	ALTER TABLE OpcionesVerificacion
	DROP CONSTRAINT DF_OpcionesVerificacion_OpcionContrasena;
  END
  ALTER TABLE OpcionesVerificacion DROP COLUMN OpcionContrasena;
END
GO

IF COL_LENGTH('OpcionesVerificacion', 'IntentosSms') IS NOT NULL
BEGIN
  IF OBJECT_ID('DF_OpcionesVerificacion_IntentosSms') IS NOT NULL 
  BEGIN
	ALTER TABLE OpcionesVerificacion
	DROP CONSTRAINT DF_OpcionesVerificacion_IntentosSms;
  END
  ALTER TABLE OpcionesVerificacion DROP COLUMN IntentosSms;
END
GO

IF COL_LENGTH('CodigoGenerado', 'CantidadEnvios') IS NOT NULL
BEGIN
  IF OBJECT_ID('DF_CodigoGenerado_CantidadEnvios') IS NOT NULL 
  BEGIN
	ALTER TABLE CodigoGenerado
	DROP CONSTRAINT DF_CodigoGenerado_CantidadEnvios;
  END
  ALTER TABLE CodigoGenerado DROP COLUMN CantidadEnvios;
END
GO

USE BelcorpMexico
GO

/* ROOLBACK */
IF COL_LENGTH('OpcionesVerificacion', 'OpcionContrasena') IS NOT NULL
BEGIN
  IF OBJECT_ID('DF_OpcionesVerificacion_OpcionContrasena') IS NOT NULL 
  BEGIN
	ALTER TABLE OpcionesVerificacion
	DROP CONSTRAINT DF_OpcionesVerificacion_OpcionContrasena;
  END
  ALTER TABLE OpcionesVerificacion DROP COLUMN OpcionContrasena;
END
GO

IF COL_LENGTH('OpcionesVerificacion', 'IntentosSms') IS NOT NULL
BEGIN
  IF OBJECT_ID('DF_OpcionesVerificacion_IntentosSms') IS NOT NULL 
  BEGIN
	ALTER TABLE OpcionesVerificacion
	DROP CONSTRAINT DF_OpcionesVerificacion_IntentosSms;
  END
  ALTER TABLE OpcionesVerificacion DROP COLUMN IntentosSms;
END
GO

IF COL_LENGTH('CodigoGenerado', 'CantidadEnvios') IS NOT NULL
BEGIN
  IF OBJECT_ID('DF_CodigoGenerado_CantidadEnvios') IS NOT NULL 
  BEGIN
	ALTER TABLE CodigoGenerado
	DROP CONSTRAINT DF_CodigoGenerado_CantidadEnvios;
  END
  ALTER TABLE CodigoGenerado DROP COLUMN CantidadEnvios;
END
GO

USE BelcorpColombia
GO

/* ROOLBACK */
IF COL_LENGTH('OpcionesVerificacion', 'OpcionContrasena') IS NOT NULL
BEGIN
  IF OBJECT_ID('DF_OpcionesVerificacion_OpcionContrasena') IS NOT NULL 
  BEGIN
	ALTER TABLE OpcionesVerificacion
	DROP CONSTRAINT DF_OpcionesVerificacion_OpcionContrasena;
  END
  ALTER TABLE OpcionesVerificacion DROP COLUMN OpcionContrasena;
END
GO

IF COL_LENGTH('OpcionesVerificacion', 'IntentosSms') IS NOT NULL
BEGIN
  IF OBJECT_ID('DF_OpcionesVerificacion_IntentosSms') IS NOT NULL 
  BEGIN
	ALTER TABLE OpcionesVerificacion
	DROP CONSTRAINT DF_OpcionesVerificacion_IntentosSms;
  END
  ALTER TABLE OpcionesVerificacion DROP COLUMN IntentosSms;
END
GO

IF COL_LENGTH('CodigoGenerado', 'CantidadEnvios') IS NOT NULL
BEGIN
  IF OBJECT_ID('DF_CodigoGenerado_CantidadEnvios') IS NOT NULL 
  BEGIN
	ALTER TABLE CodigoGenerado
	DROP CONSTRAINT DF_CodigoGenerado_CantidadEnvios;
  END
  ALTER TABLE CodigoGenerado DROP COLUMN CantidadEnvios;
END
GO

USE BelcorpSalvador
GO

/* ROOLBACK */
IF COL_LENGTH('OpcionesVerificacion', 'OpcionContrasena') IS NOT NULL
BEGIN
  IF OBJECT_ID('DF_OpcionesVerificacion_OpcionContrasena') IS NOT NULL 
  BEGIN
	ALTER TABLE OpcionesVerificacion
	DROP CONSTRAINT DF_OpcionesVerificacion_OpcionContrasena;
  END
  ALTER TABLE OpcionesVerificacion DROP COLUMN OpcionContrasena;
END
GO

IF COL_LENGTH('OpcionesVerificacion', 'IntentosSms') IS NOT NULL
BEGIN
  IF OBJECT_ID('DF_OpcionesVerificacion_IntentosSms') IS NOT NULL 
  BEGIN
	ALTER TABLE OpcionesVerificacion
	DROP CONSTRAINT DF_OpcionesVerificacion_IntentosSms;
  END
  ALTER TABLE OpcionesVerificacion DROP COLUMN IntentosSms;
END
GO

IF COL_LENGTH('CodigoGenerado', 'CantidadEnvios') IS NOT NULL
BEGIN
  IF OBJECT_ID('DF_CodigoGenerado_CantidadEnvios') IS NOT NULL 
  BEGIN
	ALTER TABLE CodigoGenerado
	DROP CONSTRAINT DF_CodigoGenerado_CantidadEnvios;
  END
  ALTER TABLE CodigoGenerado DROP COLUMN CantidadEnvios;
END
GO

USE BelcorpPuertoRico
GO

/* ROOLBACK */
IF COL_LENGTH('OpcionesVerificacion', 'OpcionContrasena') IS NOT NULL
BEGIN
  IF OBJECT_ID('DF_OpcionesVerificacion_OpcionContrasena') IS NOT NULL 
  BEGIN
	ALTER TABLE OpcionesVerificacion
	DROP CONSTRAINT DF_OpcionesVerificacion_OpcionContrasena;
  END
  ALTER TABLE OpcionesVerificacion DROP COLUMN OpcionContrasena;
END
GO

IF COL_LENGTH('OpcionesVerificacion', 'IntentosSms') IS NOT NULL
BEGIN
  IF OBJECT_ID('DF_OpcionesVerificacion_IntentosSms') IS NOT NULL 
  BEGIN
	ALTER TABLE OpcionesVerificacion
	DROP CONSTRAINT DF_OpcionesVerificacion_IntentosSms;
  END
  ALTER TABLE OpcionesVerificacion DROP COLUMN IntentosSms;
END
GO

IF COL_LENGTH('CodigoGenerado', 'CantidadEnvios') IS NOT NULL
BEGIN
  IF OBJECT_ID('DF_CodigoGenerado_CantidadEnvios') IS NOT NULL 
  BEGIN
	ALTER TABLE CodigoGenerado
	DROP CONSTRAINT DF_CodigoGenerado_CantidadEnvios;
  END
  ALTER TABLE CodigoGenerado DROP COLUMN CantidadEnvios;
END
GO

USE BelcorpPanama
GO

/* ROOLBACK */
IF COL_LENGTH('OpcionesVerificacion', 'OpcionContrasena') IS NOT NULL
BEGIN
  IF OBJECT_ID('DF_OpcionesVerificacion_OpcionContrasena') IS NOT NULL 
  BEGIN
	ALTER TABLE OpcionesVerificacion
	DROP CONSTRAINT DF_OpcionesVerificacion_OpcionContrasena;
  END
  ALTER TABLE OpcionesVerificacion DROP COLUMN OpcionContrasena;
END
GO

IF COL_LENGTH('OpcionesVerificacion', 'IntentosSms') IS NOT NULL
BEGIN
  IF OBJECT_ID('DF_OpcionesVerificacion_IntentosSms') IS NOT NULL 
  BEGIN
	ALTER TABLE OpcionesVerificacion
	DROP CONSTRAINT DF_OpcionesVerificacion_IntentosSms;
  END
  ALTER TABLE OpcionesVerificacion DROP COLUMN IntentosSms;
END
GO

IF COL_LENGTH('CodigoGenerado', 'CantidadEnvios') IS NOT NULL
BEGIN
  IF OBJECT_ID('DF_CodigoGenerado_CantidadEnvios') IS NOT NULL 
  BEGIN
	ALTER TABLE CodigoGenerado
	DROP CONSTRAINT DF_CodigoGenerado_CantidadEnvios;
  END
  ALTER TABLE CodigoGenerado DROP COLUMN CantidadEnvios;
END
GO

USE BelcorpGuatemala
GO

/* ROOLBACK */
IF COL_LENGTH('OpcionesVerificacion', 'OpcionContrasena') IS NOT NULL
BEGIN
  IF OBJECT_ID('DF_OpcionesVerificacion_OpcionContrasena') IS NOT NULL 
  BEGIN
	ALTER TABLE OpcionesVerificacion
	DROP CONSTRAINT DF_OpcionesVerificacion_OpcionContrasena;
  END
  ALTER TABLE OpcionesVerificacion DROP COLUMN OpcionContrasena;
END
GO

IF COL_LENGTH('OpcionesVerificacion', 'IntentosSms') IS NOT NULL
BEGIN
  IF OBJECT_ID('DF_OpcionesVerificacion_IntentosSms') IS NOT NULL 
  BEGIN
	ALTER TABLE OpcionesVerificacion
	DROP CONSTRAINT DF_OpcionesVerificacion_IntentosSms;
  END
  ALTER TABLE OpcionesVerificacion DROP COLUMN IntentosSms;
END
GO

IF COL_LENGTH('CodigoGenerado', 'CantidadEnvios') IS NOT NULL
BEGIN
  IF OBJECT_ID('DF_CodigoGenerado_CantidadEnvios') IS NOT NULL 
  BEGIN
	ALTER TABLE CodigoGenerado
	DROP CONSTRAINT DF_CodigoGenerado_CantidadEnvios;
  END
  ALTER TABLE CodigoGenerado DROP COLUMN CantidadEnvios;
END
GO

USE BelcorpEcuador
GO

/* ROOLBACK */
IF COL_LENGTH('OpcionesVerificacion', 'OpcionContrasena') IS NOT NULL
BEGIN
  IF OBJECT_ID('DF_OpcionesVerificacion_OpcionContrasena') IS NOT NULL 
  BEGIN
	ALTER TABLE OpcionesVerificacion
	DROP CONSTRAINT DF_OpcionesVerificacion_OpcionContrasena;
  END
  ALTER TABLE OpcionesVerificacion DROP COLUMN OpcionContrasena;
END
GO

IF COL_LENGTH('OpcionesVerificacion', 'IntentosSms') IS NOT NULL
BEGIN
  IF OBJECT_ID('DF_OpcionesVerificacion_IntentosSms') IS NOT NULL 
  BEGIN
	ALTER TABLE OpcionesVerificacion
	DROP CONSTRAINT DF_OpcionesVerificacion_IntentosSms;
  END
  ALTER TABLE OpcionesVerificacion DROP COLUMN IntentosSms;
END
GO

IF COL_LENGTH('CodigoGenerado', 'CantidadEnvios') IS NOT NULL
BEGIN
  IF OBJECT_ID('DF_CodigoGenerado_CantidadEnvios') IS NOT NULL 
  BEGIN
	ALTER TABLE CodigoGenerado
	DROP CONSTRAINT DF_CodigoGenerado_CantidadEnvios;
  END
  ALTER TABLE CodigoGenerado DROP COLUMN CantidadEnvios;
END
GO

USE BelcorpDominicana
GO

/* ROOLBACK */
IF COL_LENGTH('OpcionesVerificacion', 'OpcionContrasena') IS NOT NULL
BEGIN
  IF OBJECT_ID('DF_OpcionesVerificacion_OpcionContrasena') IS NOT NULL 
  BEGIN
	ALTER TABLE OpcionesVerificacion
	DROP CONSTRAINT DF_OpcionesVerificacion_OpcionContrasena;
  END
  ALTER TABLE OpcionesVerificacion DROP COLUMN OpcionContrasena;
END
GO

IF COL_LENGTH('OpcionesVerificacion', 'IntentosSms') IS NOT NULL
BEGIN
  IF OBJECT_ID('DF_OpcionesVerificacion_IntentosSms') IS NOT NULL 
  BEGIN
	ALTER TABLE OpcionesVerificacion
	DROP CONSTRAINT DF_OpcionesVerificacion_IntentosSms;
  END
  ALTER TABLE OpcionesVerificacion DROP COLUMN IntentosSms;
END
GO

IF COL_LENGTH('CodigoGenerado', 'CantidadEnvios') IS NOT NULL
BEGIN
  IF OBJECT_ID('DF_CodigoGenerado_CantidadEnvios') IS NOT NULL 
  BEGIN
	ALTER TABLE CodigoGenerado
	DROP CONSTRAINT DF_CodigoGenerado_CantidadEnvios;
  END
  ALTER TABLE CodigoGenerado DROP COLUMN CantidadEnvios;
END
GO

USE BelcorpCostaRica
GO

/* ROOLBACK */
IF COL_LENGTH('OpcionesVerificacion', 'OpcionContrasena') IS NOT NULL
BEGIN
  IF OBJECT_ID('DF_OpcionesVerificacion_OpcionContrasena') IS NOT NULL 
  BEGIN
	ALTER TABLE OpcionesVerificacion
	DROP CONSTRAINT DF_OpcionesVerificacion_OpcionContrasena;
  END
  ALTER TABLE OpcionesVerificacion DROP COLUMN OpcionContrasena;
END
GO

IF COL_LENGTH('OpcionesVerificacion', 'IntentosSms') IS NOT NULL
BEGIN
  IF OBJECT_ID('DF_OpcionesVerificacion_IntentosSms') IS NOT NULL 
  BEGIN
	ALTER TABLE OpcionesVerificacion
	DROP CONSTRAINT DF_OpcionesVerificacion_IntentosSms;
  END
  ALTER TABLE OpcionesVerificacion DROP COLUMN IntentosSms;
END
GO

IF COL_LENGTH('CodigoGenerado', 'CantidadEnvios') IS NOT NULL
BEGIN
  IF OBJECT_ID('DF_CodigoGenerado_CantidadEnvios') IS NOT NULL 
  BEGIN
	ALTER TABLE CodigoGenerado
	DROP CONSTRAINT DF_CodigoGenerado_CantidadEnvios;
  END
  ALTER TABLE CodigoGenerado DROP COLUMN CantidadEnvios;
END
GO

USE BelcorpChile
GO

/* ROOLBACK */
IF COL_LENGTH('OpcionesVerificacion', 'OpcionContrasena') IS NOT NULL
BEGIN
  IF OBJECT_ID('DF_OpcionesVerificacion_OpcionContrasena') IS NOT NULL 
  BEGIN
	ALTER TABLE OpcionesVerificacion
	DROP CONSTRAINT DF_OpcionesVerificacion_OpcionContrasena;
  END
  ALTER TABLE OpcionesVerificacion DROP COLUMN OpcionContrasena;
END
GO

IF COL_LENGTH('OpcionesVerificacion', 'IntentosSms') IS NOT NULL
BEGIN
  IF OBJECT_ID('DF_OpcionesVerificacion_IntentosSms') IS NOT NULL 
  BEGIN
	ALTER TABLE OpcionesVerificacion
	DROP CONSTRAINT DF_OpcionesVerificacion_IntentosSms;
  END
  ALTER TABLE OpcionesVerificacion DROP COLUMN IntentosSms;
END
GO

IF COL_LENGTH('CodigoGenerado', 'CantidadEnvios') IS NOT NULL
BEGIN
  IF OBJECT_ID('DF_CodigoGenerado_CantidadEnvios') IS NOT NULL 
  BEGIN
	ALTER TABLE CodigoGenerado
	DROP CONSTRAINT DF_CodigoGenerado_CantidadEnvios;
  END
  ALTER TABLE CodigoGenerado DROP COLUMN CantidadEnvios;
END
GO

USE BelcorpBolivia
GO

/* ROOLBACK */
IF COL_LENGTH('OpcionesVerificacion', 'OpcionContrasena') IS NOT NULL
BEGIN
  IF OBJECT_ID('DF_OpcionesVerificacion_OpcionContrasena') IS NOT NULL 
  BEGIN
	ALTER TABLE OpcionesVerificacion
	DROP CONSTRAINT DF_OpcionesVerificacion_OpcionContrasena;
  END
  ALTER TABLE OpcionesVerificacion DROP COLUMN OpcionContrasena;
END
GO

IF COL_LENGTH('OpcionesVerificacion', 'IntentosSms') IS NOT NULL
BEGIN
  IF OBJECT_ID('DF_OpcionesVerificacion_IntentosSms') IS NOT NULL 
  BEGIN
	ALTER TABLE OpcionesVerificacion
	DROP CONSTRAINT DF_OpcionesVerificacion_IntentosSms;
  END
  ALTER TABLE OpcionesVerificacion DROP COLUMN IntentosSms;
END
GO

IF COL_LENGTH('CodigoGenerado', 'CantidadEnvios') IS NOT NULL
BEGIN
  IF OBJECT_ID('DF_CodigoGenerado_CantidadEnvios') IS NOT NULL 
  BEGIN
	ALTER TABLE CodigoGenerado
	DROP CONSTRAINT DF_CodigoGenerado_CantidadEnvios;
  END
  ALTER TABLE CodigoGenerado DROP COLUMN CantidadEnvios;
END
GO

