USE BelcorpPeru
GO

DELETE from TablaLogicaDatos where TablaLogicaID = 132 --> Verificar el correlativo qen caso exista.
DELETE from TablaLogica where TablaLogicaID = 132

DECLARE @Correlativo varchar(6) = '132' --> Poner este correlativo 132 para todos los paises 

INSERT INTO [dbo].[TablaLogica]  (TablaLogicaID, Descripcion)
			VALUES (cast(@Correlativo as smallint), 'Datos SMS')

INSERT INTO [dbo].[TablaLogicaDatos] (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion) 
VALUES (cast(@Correlativo + '01' as smallint), cast(@Correlativo as smallint), 'USUARIO', 'RMONTERO')
INSERT INTO [dbo].[TablaLogicaDatos] (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion) 
VALUES (cast(@Correlativo + '02' as smallint), cast(@Correlativo as smallint), 'CLAVE', 'RMONTERO50')
INSERT INTO [dbo].[TablaLogicaDatos] (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion) 
VALUES (cast(@Correlativo + '03' as smallint), cast(@Correlativo as smallint), 'URL', 'http://servicio.smsmasivos.com.ar/enviar_sms.asp?')--> Url Diferente en casa País
GO

USE BelcorpMexico
GO

DELETE from TablaLogicaDatos where TablaLogicaID = 132 --> Verificar el correlativo qen caso exista.
DELETE from TablaLogica where TablaLogicaID = 132

DECLARE @Correlativo varchar(6) = '132' --> Poner este correlativo 132 para todos los paises 

INSERT INTO [dbo].[TablaLogica]  (TablaLogicaID, Descripcion)
			VALUES (cast(@Correlativo as smallint), 'Datos SMS')

INSERT INTO [dbo].[TablaLogicaDatos] (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion) 
VALUES (cast(@Correlativo + '01' as smallint), cast(@Correlativo as smallint), 'USUARIO', 'RMONTERO')
INSERT INTO [dbo].[TablaLogicaDatos] (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion) 
VALUES (cast(@Correlativo + '02' as smallint), cast(@Correlativo as smallint), 'CLAVE', 'RMONTERO50')
INSERT INTO [dbo].[TablaLogicaDatos] (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion) 
VALUES (cast(@Correlativo + '03' as smallint), cast(@Correlativo as smallint), 'URL', '')
GO

USE BelcorpColombia
GO

DELETE from TablaLogicaDatos where TablaLogicaID = 132 --> Verificar el correlativo qen caso exista.
DELETE from TablaLogica where TablaLogicaID = 132

DECLARE @Correlativo varchar(6) = '132' --> Poner este correlativo 132 para todos los paises 

INSERT INTO [dbo].[TablaLogica]  (TablaLogicaID, Descripcion)
			VALUES (cast(@Correlativo as smallint), 'Datos SMS')

INSERT INTO [dbo].[TablaLogicaDatos] (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion) 
VALUES (cast(@Correlativo + '01' as smallint), cast(@Correlativo as smallint), 'USUARIO', 'RMONTERO')
INSERT INTO [dbo].[TablaLogicaDatos] (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion) 
VALUES (cast(@Correlativo + '02' as smallint), cast(@Correlativo as smallint), 'CLAVE', 'RMONTERO50')
INSERT INTO [dbo].[TablaLogicaDatos] (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion) 
VALUES (cast(@Correlativo + '03' as smallint), cast(@Correlativo as smallint), 'URL', '')
GO

USE BelcorpVenezuela
GO

DELETE from TablaLogicaDatos where TablaLogicaID = 132 --> Verificar el correlativo qen caso exista.
DELETE from TablaLogica where TablaLogicaID = 132

DECLARE @Correlativo varchar(6) = '132' --> Poner este correlativo 132 para todos los paises 

INSERT INTO [dbo].[TablaLogica]  (TablaLogicaID, Descripcion)
			VALUES (cast(@Correlativo as smallint), 'Datos SMS')

INSERT INTO [dbo].[TablaLogicaDatos] (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion) 
VALUES (cast(@Correlativo + '01' as smallint), cast(@Correlativo as smallint), 'USUARIO', 'RMONTERO')
INSERT INTO [dbo].[TablaLogicaDatos] (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion) 
VALUES (cast(@Correlativo + '02' as smallint), cast(@Correlativo as smallint), 'CLAVE', 'RMONTERO50')
INSERT INTO [dbo].[TablaLogicaDatos] (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion) 
VALUES (cast(@Correlativo + '03' as smallint), cast(@Correlativo as smallint), 'URL', '')
GO

USE BelcorpSalvador
GO

DELETE from TablaLogicaDatos where TablaLogicaID = 132 --> Verificar el correlativo qen caso exista.
DELETE from TablaLogica where TablaLogicaID = 132

DECLARE @Correlativo varchar(6) = '132' --> Poner este correlativo 132 para todos los paises 

INSERT INTO [dbo].[TablaLogica]  (TablaLogicaID, Descripcion)
			VALUES (cast(@Correlativo as smallint), 'Datos SMS')

INSERT INTO [dbo].[TablaLogicaDatos] (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion) 
VALUES (cast(@Correlativo + '01' as smallint), cast(@Correlativo as smallint), 'USUARIO', 'RMONTERO')
INSERT INTO [dbo].[TablaLogicaDatos] (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion) 
VALUES (cast(@Correlativo + '02' as smallint), cast(@Correlativo as smallint), 'CLAVE', 'RMONTERO50')
INSERT INTO [dbo].[TablaLogicaDatos] (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion) 
VALUES (cast(@Correlativo + '03' as smallint), cast(@Correlativo as smallint), 'URL', '')
GO

USE BelcorpPuertoRico
GO

DELETE from TablaLogicaDatos where TablaLogicaID = 132 --> Verificar el correlativo qen caso exista.
DELETE from TablaLogica where TablaLogicaID = 132

DECLARE @Correlativo varchar(6) = '132' --> Poner este correlativo 132 para todos los paises 

INSERT INTO [dbo].[TablaLogica]  (TablaLogicaID, Descripcion)
			VALUES (cast(@Correlativo as smallint), 'Datos SMS')

INSERT INTO [dbo].[TablaLogicaDatos] (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion) 
VALUES (cast(@Correlativo + '01' as smallint), cast(@Correlativo as smallint), 'USUARIO', 'RMONTERO')
INSERT INTO [dbo].[TablaLogicaDatos] (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion) 
VALUES (cast(@Correlativo + '02' as smallint), cast(@Correlativo as smallint), 'CLAVE', 'RMONTERO50')
INSERT INTO [dbo].[TablaLogicaDatos] (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion) 
VALUES (cast(@Correlativo + '03' as smallint), cast(@Correlativo as smallint), 'URL', '')
GO

USE BelcorpPanama
GO

DELETE from TablaLogicaDatos where TablaLogicaID = 132 --> Verificar el correlativo qen caso exista.
DELETE from TablaLogica where TablaLogicaID = 132

DECLARE @Correlativo varchar(6) = '132' --> Poner este correlativo 132 para todos los paises 

INSERT INTO [dbo].[TablaLogica]  (TablaLogicaID, Descripcion)
			VALUES (cast(@Correlativo as smallint), 'Datos SMS')

INSERT INTO [dbo].[TablaLogicaDatos] (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion) 
VALUES (cast(@Correlativo + '01' as smallint), cast(@Correlativo as smallint), 'USUARIO', 'RMONTERO')
INSERT INTO [dbo].[TablaLogicaDatos] (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion) 
VALUES (cast(@Correlativo + '02' as smallint), cast(@Correlativo as smallint), 'CLAVE', 'RMONTERO50')
INSERT INTO [dbo].[TablaLogicaDatos] (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion) 
VALUES (cast(@Correlativo + '03' as smallint), cast(@Correlativo as smallint), 'URL', '')
GO

USE BelcorpGuatemala
GO

DELETE from TablaLogicaDatos where TablaLogicaID = 132 --> Verificar el correlativo qen caso exista.
DELETE from TablaLogica where TablaLogicaID = 132

DECLARE @Correlativo varchar(6) = '132' --> Poner este correlativo 132 para todos los paises 

INSERT INTO [dbo].[TablaLogica]  (TablaLogicaID, Descripcion)
			VALUES (cast(@Correlativo as smallint), 'Datos SMS')

INSERT INTO [dbo].[TablaLogicaDatos] (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion) 
VALUES (cast(@Correlativo + '01' as smallint), cast(@Correlativo as smallint), 'USUARIO', 'RMONTERO')
INSERT INTO [dbo].[TablaLogicaDatos] (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion) 
VALUES (cast(@Correlativo + '02' as smallint), cast(@Correlativo as smallint), 'CLAVE', 'RMONTERO50')
INSERT INTO [dbo].[TablaLogicaDatos] (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion) 
VALUES (cast(@Correlativo + '03' as smallint), cast(@Correlativo as smallint), 'URL', '')
GO

USE BelcorpEcuador
GO

DELETE from TablaLogicaDatos where TablaLogicaID = 132 --> Verificar el correlativo qen caso exista.
DELETE from TablaLogica where TablaLogicaID = 132

DECLARE @Correlativo varchar(6) = '132' --> Poner este correlativo 132 para todos los paises 

INSERT INTO [dbo].[TablaLogica]  (TablaLogicaID, Descripcion)
			VALUES (cast(@Correlativo as smallint), 'Datos SMS')

INSERT INTO [dbo].[TablaLogicaDatos] (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion) 
VALUES (cast(@Correlativo + '01' as smallint), cast(@Correlativo as smallint), 'USUARIO', 'RMONTERO')
INSERT INTO [dbo].[TablaLogicaDatos] (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion) 
VALUES (cast(@Correlativo + '02' as smallint), cast(@Correlativo as smallint), 'CLAVE', 'RMONTERO50')
INSERT INTO [dbo].[TablaLogicaDatos] (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion) 
VALUES (cast(@Correlativo + '03' as smallint), cast(@Correlativo as smallint), 'URL', '')
GO

USE BelcorpDominicana
GO

DELETE from TablaLogicaDatos where TablaLogicaID = 132 --> Verificar el correlativo qen caso exista.
DELETE from TablaLogica where TablaLogicaID = 132

DECLARE @Correlativo varchar(6) = '132' --> Poner este correlativo 132 para todos los paises 

INSERT INTO [dbo].[TablaLogica]  (TablaLogicaID, Descripcion)
			VALUES (cast(@Correlativo as smallint), 'Datos SMS')

INSERT INTO [dbo].[TablaLogicaDatos] (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion) 
VALUES (cast(@Correlativo + '01' as smallint), cast(@Correlativo as smallint), 'USUARIO', 'RMONTERO')
INSERT INTO [dbo].[TablaLogicaDatos] (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion) 
VALUES (cast(@Correlativo + '02' as smallint), cast(@Correlativo as smallint), 'CLAVE', 'RMONTERO50')
INSERT INTO [dbo].[TablaLogicaDatos] (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion) 
VALUES (cast(@Correlativo + '03' as smallint), cast(@Correlativo as smallint), 'URL', '')
GO

USE BelcorpCostaRica
GO

DELETE from TablaLogicaDatos where TablaLogicaID = 132 --> Verificar el correlativo qen caso exista.
DELETE from TablaLogica where TablaLogicaID = 132

DECLARE @Correlativo varchar(6) = '132' --> Poner este correlativo 132 para todos los paises 

INSERT INTO [dbo].[TablaLogica]  (TablaLogicaID, Descripcion)
			VALUES (cast(@Correlativo as smallint), 'Datos SMS')

INSERT INTO [dbo].[TablaLogicaDatos] (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion) 
VALUES (cast(@Correlativo + '01' as smallint), cast(@Correlativo as smallint), 'USUARIO', 'RMONTERO')
INSERT INTO [dbo].[TablaLogicaDatos] (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion) 
VALUES (cast(@Correlativo + '02' as smallint), cast(@Correlativo as smallint), 'CLAVE', 'RMONTERO50')
INSERT INTO [dbo].[TablaLogicaDatos] (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion) 
VALUES (cast(@Correlativo + '03' as smallint), cast(@Correlativo as smallint), 'URL', '')
GO

USE BelcorpChile
GO

DELETE from TablaLogicaDatos where TablaLogicaID = 132 --> Verificar el correlativo qen caso exista.
DELETE from TablaLogica where TablaLogicaID = 132

DECLARE @Correlativo varchar(6) = '132' --> Poner este correlativo 132 para todos los paises 

INSERT INTO [dbo].[TablaLogica]  (TablaLogicaID, Descripcion)
			VALUES (cast(@Correlativo as smallint), 'Datos SMS')

INSERT INTO [dbo].[TablaLogicaDatos] (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion) 
VALUES (cast(@Correlativo + '01' as smallint), cast(@Correlativo as smallint), 'USUARIO', 'RMONTERO')
INSERT INTO [dbo].[TablaLogicaDatos] (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion) 
VALUES (cast(@Correlativo + '02' as smallint), cast(@Correlativo as smallint), 'CLAVE', 'RMONTERO50')
INSERT INTO [dbo].[TablaLogicaDatos] (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion) 
VALUES (cast(@Correlativo + '03' as smallint), cast(@Correlativo as smallint), 'URL', '')
GO

USE BelcorpBolivia
GO

DELETE from TablaLogicaDatos where TablaLogicaID = 132 --> Verificar el correlativo qen caso exista.
DELETE from TablaLogica where TablaLogicaID = 132

DECLARE @Correlativo varchar(6) = '132' --> Poner este correlativo 132 para todos los paises 

INSERT INTO [dbo].[TablaLogica]  (TablaLogicaID, Descripcion)
			VALUES (cast(@Correlativo as smallint), 'Datos SMS')

INSERT INTO [dbo].[TablaLogicaDatos] (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion) 
VALUES (cast(@Correlativo + '01' as smallint), cast(@Correlativo as smallint), 'USUARIO', 'RMONTERO')
INSERT INTO [dbo].[TablaLogicaDatos] (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion) 
VALUES (cast(@Correlativo + '02' as smallint), cast(@Correlativo as smallint), 'CLAVE', 'RMONTERO50')
INSERT INTO [dbo].[TablaLogicaDatos] (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion) 
VALUES (cast(@Correlativo + '03' as smallint), cast(@Correlativo as smallint), 'URL', '')
GO

