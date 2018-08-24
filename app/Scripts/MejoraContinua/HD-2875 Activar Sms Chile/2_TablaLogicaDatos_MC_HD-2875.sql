USE BelcorpChile
GO
Delete from TablaLogicaDatos where TablaLogicaID = 133
Insert Into TablaLogicaDatos values (13300, 133, 'USUARIO', 'Usuario para el proveedor sms, en caso lo requiera', 'BelcorpChile'),
									(13301, 133, 'CLAVE', 'Clave para el proveedor, en caso lo requiera', 'ofG2Xo7dJo9/z8tCzQZdyg=='),
									(13302, 133, 'URL', 'URL de Solicitud', 'http://www.belcorpchile.cl'),
									(13303, 133, 'RECURSO', 'Ruta del recurso', '/ServiciosRest/sms/enviar'),
									(13304, 133, 'MENSAJE', 'Mensaje de Texto Verificacion autenticiad', 'Mensaje de prueba')