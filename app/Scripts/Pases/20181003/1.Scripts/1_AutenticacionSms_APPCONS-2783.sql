USE BelcorpPeru
GO

/* OpcionesVerificacion agregar campo OpcionContrasena */
IF COL_LENGTH('OpcionesVerificacion', 'OpcionContrasena') IS NULL
BEGIN
  ALTER TABLE OpcionesVerificacion 
	ADD OpcionContrasena BIT NOT NULL 
	CONSTRAINT DF_OpcionesVerificacion_OpcionContrasena DEFAULT (0);
END
GO

/* OpcionesVerificacion agregar campo IntentosSms */
IF COL_LENGTH('OpcionesVerificacion', 'IntentosSms') IS NULL
BEGIN
  ALTER TABLE OpcionesVerificacion 
	ADD IntentosSms INT NOT NULL 
	CONSTRAINT DF_OpcionesVerificacion_IntentosSms DEFAULT (0);
END
GO

/* CodigoGenerado agregar campo CantidadEnvios */
IF COL_LENGTH('CodigoGenerado', 'CantidadEnvios') IS NULL
BEGIN
  ALTER TABLE CodigoGenerado 
	ADD CantidadEnvios INT NOT NULL 
	CONSTRAINT DF_CodigoGenerado_CantidadEnvios DEFAULT (0);
END
GO

USE BelcorpMexico
GO

/* OpcionesVerificacion agregar campo OpcionContrasena */
IF COL_LENGTH('OpcionesVerificacion', 'OpcionContrasena') IS NULL
BEGIN
  ALTER TABLE OpcionesVerificacion 
	ADD OpcionContrasena BIT NOT NULL 
	CONSTRAINT DF_OpcionesVerificacion_OpcionContrasena DEFAULT (0);
END
GO

/* OpcionesVerificacion agregar campo IntentosSms */
IF COL_LENGTH('OpcionesVerificacion', 'IntentosSms') IS NULL
BEGIN
  ALTER TABLE OpcionesVerificacion 
	ADD IntentosSms INT NOT NULL 
	CONSTRAINT DF_OpcionesVerificacion_IntentosSms DEFAULT (0);
END
GO

/* CodigoGenerado agregar campo CantidadEnvios */
IF COL_LENGTH('CodigoGenerado', 'CantidadEnvios') IS NULL
BEGIN
  ALTER TABLE CodigoGenerado 
	ADD CantidadEnvios INT NOT NULL 
	CONSTRAINT DF_CodigoGenerado_CantidadEnvios DEFAULT (0);
END
GO

USE BelcorpColombia
GO

/* OpcionesVerificacion agregar campo OpcionContrasena */
IF COL_LENGTH('OpcionesVerificacion', 'OpcionContrasena') IS NULL
BEGIN
  ALTER TABLE OpcionesVerificacion 
	ADD OpcionContrasena BIT NOT NULL 
	CONSTRAINT DF_OpcionesVerificacion_OpcionContrasena DEFAULT (0);
END
GO

/* OpcionesVerificacion agregar campo IntentosSms */
IF COL_LENGTH('OpcionesVerificacion', 'IntentosSms') IS NULL
BEGIN
  ALTER TABLE OpcionesVerificacion 
	ADD IntentosSms INT NOT NULL 
	CONSTRAINT DF_OpcionesVerificacion_IntentosSms DEFAULT (0);
END
GO

/* CodigoGenerado agregar campo CantidadEnvios */
IF COL_LENGTH('CodigoGenerado', 'CantidadEnvios') IS NULL
BEGIN
  ALTER TABLE CodigoGenerado 
	ADD CantidadEnvios INT NOT NULL 
	CONSTRAINT DF_CodigoGenerado_CantidadEnvios DEFAULT (0);
END
GO

USE BelcorpSalvador
GO

/* OpcionesVerificacion agregar campo OpcionContrasena */
IF COL_LENGTH('OpcionesVerificacion', 'OpcionContrasena') IS NULL
BEGIN
  ALTER TABLE OpcionesVerificacion 
	ADD OpcionContrasena BIT NOT NULL 
	CONSTRAINT DF_OpcionesVerificacion_OpcionContrasena DEFAULT (0);
END
GO

/* OpcionesVerificacion agregar campo IntentosSms */
IF COL_LENGTH('OpcionesVerificacion', 'IntentosSms') IS NULL
BEGIN
  ALTER TABLE OpcionesVerificacion 
	ADD IntentosSms INT NOT NULL 
	CONSTRAINT DF_OpcionesVerificacion_IntentosSms DEFAULT (0);
END
GO

/* CodigoGenerado agregar campo CantidadEnvios */
IF COL_LENGTH('CodigoGenerado', 'CantidadEnvios') IS NULL
BEGIN
  ALTER TABLE CodigoGenerado 
	ADD CantidadEnvios INT NOT NULL 
	CONSTRAINT DF_CodigoGenerado_CantidadEnvios DEFAULT (0);
END
GO

USE BelcorpPuertoRico
GO

/* OpcionesVerificacion agregar campo OpcionContrasena */
IF COL_LENGTH('OpcionesVerificacion', 'OpcionContrasena') IS NULL
BEGIN
  ALTER TABLE OpcionesVerificacion 
	ADD OpcionContrasena BIT NOT NULL 
	CONSTRAINT DF_OpcionesVerificacion_OpcionContrasena DEFAULT (0);
END
GO

/* OpcionesVerificacion agregar campo IntentosSms */
IF COL_LENGTH('OpcionesVerificacion', 'IntentosSms') IS NULL
BEGIN
  ALTER TABLE OpcionesVerificacion 
	ADD IntentosSms INT NOT NULL 
	CONSTRAINT DF_OpcionesVerificacion_IntentosSms DEFAULT (0);
END
GO

/* CodigoGenerado agregar campo CantidadEnvios */
IF COL_LENGTH('CodigoGenerado', 'CantidadEnvios') IS NULL
BEGIN
  ALTER TABLE CodigoGenerado 
	ADD CantidadEnvios INT NOT NULL 
	CONSTRAINT DF_CodigoGenerado_CantidadEnvios DEFAULT (0);
END
GO

USE BelcorpPanama
GO

/* OpcionesVerificacion agregar campo OpcionContrasena */
IF COL_LENGTH('OpcionesVerificacion', 'OpcionContrasena') IS NULL
BEGIN
  ALTER TABLE OpcionesVerificacion 
	ADD OpcionContrasena BIT NOT NULL 
	CONSTRAINT DF_OpcionesVerificacion_OpcionContrasena DEFAULT (0);
END
GO

/* OpcionesVerificacion agregar campo IntentosSms */
IF COL_LENGTH('OpcionesVerificacion', 'IntentosSms') IS NULL
BEGIN
  ALTER TABLE OpcionesVerificacion 
	ADD IntentosSms INT NOT NULL 
	CONSTRAINT DF_OpcionesVerificacion_IntentosSms DEFAULT (0);
END
GO

/* CodigoGenerado agregar campo CantidadEnvios */
IF COL_LENGTH('CodigoGenerado', 'CantidadEnvios') IS NULL
BEGIN
  ALTER TABLE CodigoGenerado 
	ADD CantidadEnvios INT NOT NULL 
	CONSTRAINT DF_CodigoGenerado_CantidadEnvios DEFAULT (0);
END
GO

USE BelcorpGuatemala
GO

/* OpcionesVerificacion agregar campo OpcionContrasena */
IF COL_LENGTH('OpcionesVerificacion', 'OpcionContrasena') IS NULL
BEGIN
  ALTER TABLE OpcionesVerificacion 
	ADD OpcionContrasena BIT NOT NULL 
	CONSTRAINT DF_OpcionesVerificacion_OpcionContrasena DEFAULT (0);
END
GO

/* OpcionesVerificacion agregar campo IntentosSms */
IF COL_LENGTH('OpcionesVerificacion', 'IntentosSms') IS NULL
BEGIN
  ALTER TABLE OpcionesVerificacion 
	ADD IntentosSms INT NOT NULL 
	CONSTRAINT DF_OpcionesVerificacion_IntentosSms DEFAULT (0);
END
GO

/* CodigoGenerado agregar campo CantidadEnvios */
IF COL_LENGTH('CodigoGenerado', 'CantidadEnvios') IS NULL
BEGIN
  ALTER TABLE CodigoGenerado 
	ADD CantidadEnvios INT NOT NULL 
	CONSTRAINT DF_CodigoGenerado_CantidadEnvios DEFAULT (0);
END
GO

USE BelcorpEcuador
GO

/* OpcionesVerificacion agregar campo OpcionContrasena */
IF COL_LENGTH('OpcionesVerificacion', 'OpcionContrasena') IS NULL
BEGIN
  ALTER TABLE OpcionesVerificacion 
	ADD OpcionContrasena BIT NOT NULL 
	CONSTRAINT DF_OpcionesVerificacion_OpcionContrasena DEFAULT (0);
END
GO

/* OpcionesVerificacion agregar campo IntentosSms */
IF COL_LENGTH('OpcionesVerificacion', 'IntentosSms') IS NULL
BEGIN
  ALTER TABLE OpcionesVerificacion 
	ADD IntentosSms INT NOT NULL 
	CONSTRAINT DF_OpcionesVerificacion_IntentosSms DEFAULT (0);
END
GO

/* CodigoGenerado agregar campo CantidadEnvios */
IF COL_LENGTH('CodigoGenerado', 'CantidadEnvios') IS NULL
BEGIN
  ALTER TABLE CodigoGenerado 
	ADD CantidadEnvios INT NOT NULL 
	CONSTRAINT DF_CodigoGenerado_CantidadEnvios DEFAULT (0);
END
GO

USE BelcorpDominicana
GO

/* OpcionesVerificacion agregar campo OpcionContrasena */
IF COL_LENGTH('OpcionesVerificacion', 'OpcionContrasena') IS NULL
BEGIN
  ALTER TABLE OpcionesVerificacion 
	ADD OpcionContrasena BIT NOT NULL 
	CONSTRAINT DF_OpcionesVerificacion_OpcionContrasena DEFAULT (0);
END
GO

/* OpcionesVerificacion agregar campo IntentosSms */
IF COL_LENGTH('OpcionesVerificacion', 'IntentosSms') IS NULL
BEGIN
  ALTER TABLE OpcionesVerificacion 
	ADD IntentosSms INT NOT NULL 
	CONSTRAINT DF_OpcionesVerificacion_IntentosSms DEFAULT (0);
END
GO

/* CodigoGenerado agregar campo CantidadEnvios */
IF COL_LENGTH('CodigoGenerado', 'CantidadEnvios') IS NULL
BEGIN
  ALTER TABLE CodigoGenerado 
	ADD CantidadEnvios INT NOT NULL 
	CONSTRAINT DF_CodigoGenerado_CantidadEnvios DEFAULT (0);
END
GO

USE BelcorpCostaRica
GO

/* OpcionesVerificacion agregar campo OpcionContrasena */
IF COL_LENGTH('OpcionesVerificacion', 'OpcionContrasena') IS NULL
BEGIN
  ALTER TABLE OpcionesVerificacion 
	ADD OpcionContrasena BIT NOT NULL 
	CONSTRAINT DF_OpcionesVerificacion_OpcionContrasena DEFAULT (0);
END
GO

/* OpcionesVerificacion agregar campo IntentosSms */
IF COL_LENGTH('OpcionesVerificacion', 'IntentosSms') IS NULL
BEGIN
  ALTER TABLE OpcionesVerificacion 
	ADD IntentosSms INT NOT NULL 
	CONSTRAINT DF_OpcionesVerificacion_IntentosSms DEFAULT (0);
END
GO

/* CodigoGenerado agregar campo CantidadEnvios */
IF COL_LENGTH('CodigoGenerado', 'CantidadEnvios') IS NULL
BEGIN
  ALTER TABLE CodigoGenerado 
	ADD CantidadEnvios INT NOT NULL 
	CONSTRAINT DF_CodigoGenerado_CantidadEnvios DEFAULT (0);
END
GO

USE BelcorpChile
GO

/* OpcionesVerificacion agregar campo OpcionContrasena */
IF COL_LENGTH('OpcionesVerificacion', 'OpcionContrasena') IS NULL
BEGIN
  ALTER TABLE OpcionesVerificacion 
	ADD OpcionContrasena BIT NOT NULL 
	CONSTRAINT DF_OpcionesVerificacion_OpcionContrasena DEFAULT (0);
END
GO

/* OpcionesVerificacion agregar campo IntentosSms */
IF COL_LENGTH('OpcionesVerificacion', 'IntentosSms') IS NULL
BEGIN
  ALTER TABLE OpcionesVerificacion 
	ADD IntentosSms INT NOT NULL 
	CONSTRAINT DF_OpcionesVerificacion_IntentosSms DEFAULT (0);
END
GO

/* CodigoGenerado agregar campo CantidadEnvios */
IF COL_LENGTH('CodigoGenerado', 'CantidadEnvios') IS NULL
BEGIN
  ALTER TABLE CodigoGenerado 
	ADD CantidadEnvios INT NOT NULL 
	CONSTRAINT DF_CodigoGenerado_CantidadEnvios DEFAULT (0);
END
GO

USE BelcorpBolivia
GO

/* OpcionesVerificacion agregar campo OpcionContrasena */
IF COL_LENGTH('OpcionesVerificacion', 'OpcionContrasena') IS NULL
BEGIN
  ALTER TABLE OpcionesVerificacion 
	ADD OpcionContrasena BIT NOT NULL 
	CONSTRAINT DF_OpcionesVerificacion_OpcionContrasena DEFAULT (0);
END
GO

/* OpcionesVerificacion agregar campo IntentosSms */
IF COL_LENGTH('OpcionesVerificacion', 'IntentosSms') IS NULL
BEGIN
  ALTER TABLE OpcionesVerificacion 
	ADD IntentosSms INT NOT NULL 
	CONSTRAINT DF_OpcionesVerificacion_IntentosSms DEFAULT (0);
END
GO

/* CodigoGenerado agregar campo CantidadEnvios */
IF COL_LENGTH('CodigoGenerado', 'CantidadEnvios') IS NULL
BEGIN
  ALTER TABLE CodigoGenerado 
	ADD CantidadEnvios INT NOT NULL 
	CONSTRAINT DF_CodigoGenerado_CantidadEnvios DEFAULT (0);
END
GO

