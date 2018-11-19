USE BelcorpPeru
GO

/* Habilitar el Pago en Linea para la App */
INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion], [Valor])
VALUES (12213, 122, 'FLAG_ENABLE_APP', 'Flag para habilitar Pago en Linea en el App de Consultoras', '1');

/* Habilitar la carga de Aplicaciones Externas en Pago de Banca por Internet */
INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion], [Valor])
VALUES (12214, 122, 'FLAG_PBI_EXTERNAL_APP', 'Flag para habilitar la Carga de las Apps de los Bancos', '1');

GO