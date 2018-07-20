USE BelcorpPeru;
GO
DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 133 AND TablaLogicaDatosID in (13302, 13303, 13304, 13305);

UPDATE TablaLogicaDatos SET Valor='alamadrid@belcorp.biz' WHERE TablaLogicaID = 133 AND Codigo = 'USUARIO';
UPDATE TablaLogicaDatos SET Valor='o9wXlIX2' WHERE TablaLogicaID = 133 AND Codigo = 'CLAVE';
Insert into TablaLogicaDatos values 
									(13302, 133, 'URL', 'URL de Solicitud', 'http://dilootu.com/'),
									(13303, 133, 'RECURSO', 'Ruta del recurso', 'init/default/api'),
									(13304, 133, 'MENSAJE', 'Mensaje SMS PIN', '{0} Es su PIN de verificacion para ingresar a Somos Belcorp'),
									(13305, 133, 'MENSAJE_OPTIN', 'Mensaje SMS OPTIN', '{0} es tu codigo de verificacion para actualizar tu celular en Somos Belcorp.');
GO

USE BelcorpBolivia;
GO
DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 133 AND TablaLogicaDatosID = 13305;
Insert into TablaLogicaDatos values 
									(13305, 133, 'MENSAJE_OPTIN', 'Mensaje SMS OPTIN', '{0} es tu codigo de verificacion para actualizar tu celular en Somos Belcorp.');
GO