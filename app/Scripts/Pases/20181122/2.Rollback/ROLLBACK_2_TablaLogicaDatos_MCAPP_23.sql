USE BelcorpPeru
GO

/* Habilitar el Pago en Linea para la App */
DELETE FROM [TablaLogicaDatos] WHERE [TablaLogicaDatosID] = 12213;

/* Habilitar la carga de Aplicaciones Externas en Pago de Banca por Internet */
DELETE FROM [TablaLogicaDatos] WHERE [TablaLogicaDatosID] = 12214;

GO