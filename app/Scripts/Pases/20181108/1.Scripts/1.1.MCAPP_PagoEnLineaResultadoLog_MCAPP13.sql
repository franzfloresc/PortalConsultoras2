USE BelcorpPeru
GO

/* OpcionesVerificacion agregar campo IntentosSms */
IF COL_LENGTH('PagoEnLineaResultadoLog', 'Origen') IS NULL
BEGIN
  ALTER TABLE PagoEnLineaResultadoLog 
	ADD Origen VARCHAR(20) NULL 
	CONSTRAINT DF_PagoEnLineaResultadoLog_Origen DEFAULT ('Desktop');
END
GO

USE BelcorpMexico
GO

/* OpcionesVerificacion agregar campo IntentosSms */
IF COL_LENGTH('PagoEnLineaResultadoLog', 'Origen') IS NULL
BEGIN
  ALTER TABLE PagoEnLineaResultadoLog 
	ADD Origen VARCHAR(20) NULL 
	CONSTRAINT DF_PagoEnLineaResultadoLog_Origen DEFAULT ('Desktop');
END
GO

USE BelcorpColombia
GO

/* OpcionesVerificacion agregar campo IntentosSms */
IF COL_LENGTH('PagoEnLineaResultadoLog', 'Origen') IS NULL
BEGIN
  ALTER TABLE PagoEnLineaResultadoLog 
	ADD Origen VARCHAR(20) NULL 
	CONSTRAINT DF_PagoEnLineaResultadoLog_Origen DEFAULT ('Desktop');
END
GO

USE BelcorpSalvador
GO

/* OpcionesVerificacion agregar campo IntentosSms */
IF COL_LENGTH('PagoEnLineaResultadoLog', 'Origen') IS NULL
BEGIN
  ALTER TABLE PagoEnLineaResultadoLog 
	ADD Origen VARCHAR(20) NULL 
	CONSTRAINT DF_PagoEnLineaResultadoLog_Origen DEFAULT ('Desktop');
END
GO

USE BelcorpPuertoRico
GO

/* OpcionesVerificacion agregar campo IntentosSms */
IF COL_LENGTH('PagoEnLineaResultadoLog', 'Origen') IS NULL
BEGIN
  ALTER TABLE PagoEnLineaResultadoLog 
	ADD Origen VARCHAR(20) NULL 
	CONSTRAINT DF_PagoEnLineaResultadoLog_Origen DEFAULT ('Desktop');
END
GO

USE BelcorpPanama
GO

/* OpcionesVerificacion agregar campo IntentosSms */
IF COL_LENGTH('PagoEnLineaResultadoLog', 'Origen') IS NULL
BEGIN
  ALTER TABLE PagoEnLineaResultadoLog 
	ADD Origen VARCHAR(20) NULL 
	CONSTRAINT DF_PagoEnLineaResultadoLog_Origen DEFAULT ('Desktop');
END
GO

USE BelcorpGuatemala
GO

/* OpcionesVerificacion agregar campo IntentosSms */
IF COL_LENGTH('PagoEnLineaResultadoLog', 'Origen') IS NULL
BEGIN
  ALTER TABLE PagoEnLineaResultadoLog 
	ADD Origen VARCHAR(20) NULL 
	CONSTRAINT DF_PagoEnLineaResultadoLog_Origen DEFAULT ('Desktop');
END
GO

USE BelcorpEcuador
GO

/* OpcionesVerificacion agregar campo IntentosSms */
IF COL_LENGTH('PagoEnLineaResultadoLog', 'Origen') IS NULL
BEGIN
  ALTER TABLE PagoEnLineaResultadoLog 
	ADD Origen VARCHAR(20) NULL 
	CONSTRAINT DF_PagoEnLineaResultadoLog_Origen DEFAULT ('Desktop');
END
GO

USE BelcorpDominicana
GO

/* OpcionesVerificacion agregar campo IntentosSms */
IF COL_LENGTH('PagoEnLineaResultadoLog', 'Origen') IS NULL
BEGIN
  ALTER TABLE PagoEnLineaResultadoLog 
	ADD Origen VARCHAR(20) NULL 
	CONSTRAINT DF_PagoEnLineaResultadoLog_Origen DEFAULT ('Desktop');
END
GO

USE BelcorpCostaRica
GO

/* OpcionesVerificacion agregar campo IntentosSms */
IF COL_LENGTH('PagoEnLineaResultadoLog', 'Origen') IS NULL
BEGIN
  ALTER TABLE PagoEnLineaResultadoLog 
	ADD Origen VARCHAR(20) NULL 
	CONSTRAINT DF_PagoEnLineaResultadoLog_Origen DEFAULT ('Desktop');
END
GO

USE BelcorpChile
GO

/* OpcionesVerificacion agregar campo IntentosSms */
IF COL_LENGTH('PagoEnLineaResultadoLog', 'Origen') IS NULL
BEGIN
  ALTER TABLE PagoEnLineaResultadoLog 
	ADD Origen VARCHAR(20) NULL 
	CONSTRAINT DF_PagoEnLineaResultadoLog_Origen DEFAULT ('Desktop');
END
GO

USE BelcorpBolivia
GO

/* OpcionesVerificacion agregar campo IntentosSms */
IF COL_LENGTH('PagoEnLineaResultadoLog', 'Origen') IS NULL
BEGIN
  ALTER TABLE PagoEnLineaResultadoLog 
	ADD Origen VARCHAR(20) NULL 
	CONSTRAINT DF_PagoEnLineaResultadoLog_Origen DEFAULT ('Desktop');
END
GO

