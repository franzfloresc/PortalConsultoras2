USE BelcorpBolivia
GO
DELETE FROM GPR.MotivoRechazo;
GO
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-1', 'TIPO DE SOLICITUD', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-2', 'DIRECCIONES CLIENTE', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-3', 'UNIDADES ADMINISTRATIVAS', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-4', 'TIPO DE DESPACHO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-5', 'TIPO DE CAMBIO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-6', 'CLIENTE INACTIVO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-7', 'SEGUNDO PEDIDO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-8', 'BLOQUEO DEL CLIENTE', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-12', 'CABECERA SIN DETALLE', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-16', 'MONTO MINIMO', 1, 'minimo');
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-17', 'MONTO MAXIMO', 1, 'maximo');
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-18', 'REEMPLAZOS Y ANULADOS', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-19', 'ACTUALIZACION DE DEUDA', 1, 'deuda');
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-20', 'VALIDACION DE CODIGO DE CLIENTE INEXISTENTE', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-25', 'VALIDACION DE UNIDADES MAXIMA POR PRODUCTO Y PEDIDO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-26', 'VALIDACION DE PROGRAMA DE NUEVAS', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-34', 'VALIDACION CODIGO CLIENTE CAMBIADO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-36', 'VALIDACION DE TIPO DE DOCUMENTO INVALIDO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-37', 'VALIDACION RECHAZO OCR2', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-39', 'VALIDACION DE SECUENCIACION DE ZONAS Y TERRITORIO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-40', 'RECARGO FLETE', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-45', 'VALIDACIÓN DE ERROR EN CONFIGURACIÓN DE MATRIZ', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-46', 'RECHAZO POR FECHA DE FACTURACION', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-51', 'VALIDACION MONTO MINIMO STOCK', 1, 'minstock');
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-60', 'ANUL. MODIFICACION DE UNIDADES', 0, NULL);
GO
/*end*/

USE BelcorpChile
GO
DELETE FROM GPR.MotivoRechazo;
GO
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-1', 'TIPO DE SOLICITUD', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-2', 'DIRECCIONES CLIENTE', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-3', 'UNIDADES ADMINISTRATIVAS', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-4', 'TIPO DE DESPACHO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-5', 'TIPO DE CAMBIO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-6', 'CLIENTE INACTIVO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-7', 'SEGUNDO PEDIDO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-8', 'BLOQUEO DEL CLIENTE', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-12', 'CABECERA SIN DETALLE', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-16', 'MONTO MINIMO', 1, 'minimo');
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-17', 'MONTO MAXIMO', 1, 'maximo');
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-18', 'REEMPLAZOS Y ANULADOS', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-19', 'ACTUALIZACION DE DEUDA', 1, 'deuda');
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-20', 'VALIDACION DE CODIGO DE CLIENTE INEXISTENTE', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-25', 'VALIDACION DE UNIDADES MAXIMA POR PRODUCTO Y PEDIDO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-26', 'VALIDACION DE PROGRAMA DE NUEVAS', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-31', 'VALIDACION DE BLOQUEO POR CONTROL 2', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-34', 'VALIDACION CODIGO CLIENTE CAMBIADO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-36', 'VALIDACION DE TIPO DE DOCUMENTO INVALIDO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-37', 'VALIDACION RECHAZO OCR2', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-39', 'VALIDACION DE SECUENCIACION DE ZONAS Y TERRITORIO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-40', 'RECARGO FLETE', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-45', 'VALIDACIÓN DE ERROR EN CONFIGURACIÓN DE MATRIZ', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-58', 'DESVIACION', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-60', 'ANUL. MODIFICACION DE UNIDADES', 0, NULL);
GO
/*end*/

USE BelcorpCostaRica
GO
DELETE FROM GPR.MotivoRechazo;
GO
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-1', 'TIPO DE SOLICITUD', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-2', 'DIRECCIONES CLIENTE', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-3', 'UNIDADES ADMINISTRATIVAS', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-4', 'TIPO DE DESPACHO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-5', 'TIPO DE CAMBIO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-6', 'CLIENTE INACTIVO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-7', 'SEGUNDO PEDIDO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-8', 'BLOQUEO DEL CLIENTE', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-12', 'CABECERA SIN DETALLE', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-16', 'MONTO MINIMO', 1, 'minimo');
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-17', 'MONTO MAXIMO', 1, 'maximo');
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-18', 'REEMPLAZOS Y ANULADOS', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-19', 'ACTUALIZACION DE DEUDA', 1, 'deuda');
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-20', 'VALIDACION DE CODIGO DE CLIENTE INEXISTENTE', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-24', 'VALIDACION DE ERROR DE VENCIMIENTO DE CRONOGRAMA', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-25', 'VALIDACION DE UNIADES MAXIMA POR PRODUCTO Y PEDIDO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-26', 'VALIDACION DE PROGRAMA DE NUEVAS', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-31', 'VALIDACION DE BLOQUEO POR CONTROL 2', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-33', 'VALIDACION DE NUEVAS SEGUNDO DIA', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-34', 'VALIDACION CODIGO CLIENTE CAMBIADO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-36', 'VALIDACION DE TIPO DE DOCUMENTO INVALIDO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-37', 'VALIDACION RECHAZO OCR2', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-39', 'VALIDACION DE SECUENCIACION DE ZONAS Y TERRITORIO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-40', 'RECARGO FLETE', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-45', 'VALIDACIÓN DE ERROR EN CONFIGURACIÓN DE MATRIZ', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-46', 'RECHAZO POR FECHA DE FACTURACION', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-51', 'VALIDACION MONTO MINIMO STOCK', 1, 'minstock');
GO
/*end*/

USE BelcorpDominicana
GO
DELETE FROM GPR.MotivoRechazo;
GO
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-1', 'TIPO DE SOLICITUD', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-2', 'DIRECCIONES CLIENTE', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-3', 'UNIDADES ADMINISTRATIVAS', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-4', 'TIPO DE DESPACHO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-6', 'CLIENTE INACTIVO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-7', 'SEGUNDO PEDIDO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-8', 'BLOQUEO DEL CLIENTE', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-12', 'CABECERA SIN DETALLE', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-16', 'MONTO MINIMO', 1, 'minimo');
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-17', 'MONTO MAXIMO', 1, 'maximo');
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-18', 'REEMPLAZOS Y ANULADOS', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-19', 'ACTUALIZACION DE DEUDA', 1, 'deuda');
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-20', 'VALIDACION DE CODIGO DE CLIENTE INEXISTENTE', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-25', 'VALIDACION DE UNIADES MAXIMA POR PRODUCTO Y PEDIDO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-26', 'VALIDACION DE PROGRAMA DE NUEVAS', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-31', 'VALIDACION DE BLOQUEO POR CONTROL 2', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-34', 'VALIDACION CODIGO CLIENTE CAMBIADO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-36', 'VALIDACION DE TIPO DE DOCUMENTO INVALIDO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-37', 'VALIDACION RECHAZO OCR2', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-39', 'VALIDACION DE SECUENCIACION DE ZONAS Y TERRITORIO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-45', 'VALIDACIÓN DE ERROR EN CONFIGURACIÓN DE MATRIZ', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-46', 'RECHAZO POR FECHA DE FACTURACION', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-55', 'VALIDACION GESTION RECHAZADA', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-60', 'ANUL.  MODIFICACION DE UNIDADES', 0, NULL);
GO
/*end*/

USE BelcorpEcuador
GO
DELETE FROM GPR.MotivoRechazo;
GO
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-1', 'TIPO SOLICITUD', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-2', 'DIRECCIONES CLIENTE', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-3', 'UNIDADES ADMINISTRATIVAS', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-4', 'TIPO DESPACHO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-5', 'TIPO CAMBIO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-6', 'CLIENTE INACTIVO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-7', 'SEGUNDO PEDIDO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-8', 'BLOQUEO DEL CLIENTE', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-12', 'CABECERA SIN DETALLE', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-16', 'MONTO MINIMO', 1, 'minimo');
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-17', 'MONTO MAXIMO', 1, 'maximo');
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-18', 'REEMPLAZOS Y ANULADOS', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-19', 'ACTUALIZACION DEUDA', 1, 'deuda');
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-20', 'VALIDACION DE CODIGO DE CLIENTE INEXISTENTE', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-23', 'VALIDACION DE EXISTENCIA CRONOGRAMA ACTIVIDADES', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-24', 'VALIDACION DE ERROR DE VENCIMIENTO DE CRONOGRAMA', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-26', 'VALIDACION DE PROGRAMA DE NUEVAS', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-31', 'VALIDACION DE BLOQUEO POR CONTROL 2', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-32', 'VALIDACION DE ACTUALIZACION DE DEUDA MARCA', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-34', 'VALIDACION CODIGO CLIENTE CAMBIADO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-35', 'ZONA DE ARRIBO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-36', 'VALIDACION DE TIPO DE DOCUMENTO INVALIDO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-37', 'VALIDACION RECHAZO OCR2', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-39', 'VALIDACION DE SECUENCIACION DE ZONAS Y TERRITORIO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-40', 'RECARGO FLETE', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-45', 'VALIDACIÓN DE ERROR EN CONFIGURACIÓN DE MATRIZ', 0, NULL);
GO
/*end*/

USE BelcorpGuatemala
GO
DELETE FROM GPR.MotivoRechazo;
GO
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-1', 'TIPO DE SOLICITUD', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-2', 'DIRECCIONES CLIENTE', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-3', 'UNIDADES ADMINISTRATIVAS', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-4', 'TIPO DE DESPACHO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-5', 'TIPO DE CAMBIO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-6', 'CLIENTE INACTIVO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-7', 'SEGUNDO PEDIDO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-8', 'BLOQUEO DEL CLIENTE', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-12', 'CABECERA SIN DETALLE', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-16', 'MONTO MINIMO', 1, 'minimo');
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-17', 'MONTO MAXIMO', 1, 'maximo');
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-18', 'REEMPLAZOS Y ANULADOS', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-19', 'ACTUALIZACION DE DEUDA', 1, 'deuda');
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-20', 'VALIDACION DE CODIGO DE CLIENTE INEXISTENTE', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-25', 'VALIDACION DE UNIADES MAXIMA POR PRODUCTO Y PEDIDO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-26', 'VALIDACION DE PROGRAMA DE NUEVAS', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-31', 'VALIDACION DE BLOQUEO POR CONTROL 2', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-33', 'VALIDACION DE NUEVAS SEGUNDO DIA', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-34', 'VALIDACION CODIGO CLIENTE CAMBIADO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-36', 'VALIDACION DE TIPO DE DOCUMENTO INVALIDO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-37', 'VALIDACION RECHAZO OCR2', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-39', 'VALIDACION DE SECUENCIACION DE ZONAS Y TERRITORIO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-40', 'RECARGO FLETE', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-45', 'VALIDACIÓN DE ERROR EN CONFIGURACIÓN DE MATRIZ', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-46', 'RECHAZO POR FECHA DE FACTURACION', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-51', 'VALIDACION MONTO MINIMO STOCK', 1, 'minstock');
GO
/*end*/

USE BelcorpPanama
GO
DELETE FROM GPR.MotivoRechazo;
GO
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-1', 'TIPO DE SOLICITUD', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-2', 'DIRECCIONES CLIENTE', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-3', 'UNIDADES ADMINISTRATIVAS', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-4', 'TIPO DE DESPACHO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-5', 'TIPO DE CAMBIO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-6', 'CLIENTE INACTIVO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-7', 'SEGUNDO PEDIDO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-8', 'BLOQUEO DEL CLIENTE', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-12', 'CABECERA SIN DETALLE', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-16', 'MONTO MINIMO', 1, 'minimo');
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-17', 'MONTO MAXIMO', 1, 'maximo');
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-18', 'REEMPLAZOS Y ANULADOS', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-19', 'ACTUALIZACION DE DEUDA', 1, 'deuda');
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-20', 'CODIGO DE CLIENTE INEXISTENTE', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-23', 'VALIDACION DE EXISTENCIA CRONOGRAMA ACTIVIDADES', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-24', 'VALIDACION DE ERROR DE VENCIMIENTO DE CRONOGRAMA', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-25', 'VALIDACION DE UNIADES MAXIMA POR PRODUCTO Y PEDIDO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-26', 'VALIDACION DE PROGRAMA DE NUEVAS', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-31', 'VALIDACION DE BLOQUEO POR CONTROL 2', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-33', 'VALIDACION DE NUEVAS SEGUNDO DIA', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-34', 'VALIDACION CODIGO CLIENTE CAMBIADO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-36', 'VALIDACION DE TIPO DE DOCUMENTO INVALIDO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-37', 'VALIDACION RECHAZO OCR2', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-39', 'VALIDACION DE SECUENCIACION DE ZONAS Y TERRITORIO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-40', 'RECARGO FLETE', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-45', 'VALIDACIÓN DE ERROR EN CONFIGURACIÓN DE MATRIZ', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-46', 'RECHAZO POR FECHA DE FACTURACION', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-51', 'VALIDACION MONTO MINIMO STOCK', 1, 'minstock');
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-57', 'FORMA DE PAGO POR CLASIFICACION', 0, NULL);
GO
/*end*/

USE BelcorpPuertoRico
GO
DELETE FROM GPR.MotivoRechazo;
GO
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-1', 'TIPO DE SOLICITUD', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-2', 'DIRECCIONES CLIENTE', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-3', 'UNIDADES ADMINISTRATIVAS', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-4', 'TIPO DE DESPACHO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-6', 'CLIENTE INACTIVO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-7', 'SEGUNDO PEDIDO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-8', 'BLOQUEO DEL CLIENTE', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-12', 'CABECERA SIN DETALLE', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-16', 'MONTO MINIMO', 1, 'minimo');
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-17', 'MONTO MAXIMO', 1, 'maximo');
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-18', 'REEMPLAZOS Y ANULADOS', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-19', 'ACTUALIZACION DE DEUDA', 1, 'deuda');
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-20', 'VALIDACION DE CODIGO DE CLIENTE INEXISTENTE', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-25', 'VALIDACION DE UNIADES MAXIMA POR PRODUCTO Y PEDIDO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-26', 'VALIDACION DE PROGRAMA DE NUEVAS', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-31', 'VALIDACION DE BLOQUEO POR CONTROL 2', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-34', 'VALIDACION CODIGO CLIENTE CAMBIADO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-36', 'VALIDACION DE TIPO DE DOCUMENTO INVALIDO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-37', 'VALIDACION RECHAZO OCR2', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-39', 'VALIDACION DE SECUENCIACION DE ZONAS Y TERRITORIO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-45', 'VALIDACIÓN DE ERROR EN CONFIGURACIÓN DE MATRIZ', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-46', 'RECHAZO POR FECHA DE FACTURACION', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-60', 'ANUL.  MODIFICACION DE UNIDADES', 0, NULL);
GO
/*end*/

USE BelcorpSalvador
GO
DELETE FROM GPR.MotivoRechazo;
GO
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-1', 'TIPO DE SOLICITUD', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-2', 'DIRECCIONES CLIENTE', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-3', 'UNIDADES ADMINISTRATIVAS', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-4', 'TIPO DE DESPACHO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-5', 'TIPO DE CAMBIO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-6', 'CLIENTE INACTIVO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-7', 'SEGUNDO PEDIDO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-8', 'BLOQUEO DEL CLIENTE', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-12', 'CABECERA SIN DETALLE', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-16', 'MONTO MINIMO', 1, 'minimo');
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-17', 'MONTO MAXIMO', 1, 'maximo');
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-18', 'REEMPLAZOS Y ANULADOS', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-19', 'ACTUALIZACION DE DEUDA', 1, 'deuda');
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-20', 'VALIDACION DE CODIGO DE CLIENTE INEXISTENTE', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-25', 'VALIDACION DE UNIADES MAXIMA POR PRODUCTO Y PEDIDO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-26', 'VALIDACION DE PROGRAMA DE NUEVAS', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-31', 'VALIDACION DE BLOQUEO POR CONTROL 2', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-33', 'VALIDACION DE NUEVAS SEGUNDO DIA', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-34', 'VALIDACION CODIGO CLIENTE CAMBIADO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-36', 'VALIDACION DE TIPO DE DOCUMENTO INVALIDO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-37', 'VALIDACION RECHAZO OCR2', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-39', 'VALIDACION DE SECUENCIACION DE ZONAS Y TERRITORIO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-40', 'RECARGO FLETE', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-45', 'VALIDACIÓN DE ERROR EN CONFIGURACIÓN DE MATRIZ', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-46', 'RECHAZO POR FECHA DE FACTURACION', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-51', 'VALIDACION MONTO MINIMO STOCK', 1, 'minstock');
GO
/*end*/

USE BelcorpVenezuela
GO
DELETE FROM GPR.MotivoRechazo;
GO
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-1', 'TIPO DE SOLICITUD', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-2', 'DIRECCIONES CLIENTE', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-3', 'UNIDADES ADMINISTRATIVAS', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-4', 'TIPO DE DESPACHO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-5', 'TIPO DE CAMBIO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-6', 'CLIENTE INACTIVO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-7', 'SEGUNDO PEDIDO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-8', 'BLOQUEO DEL CLIENTE', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-12', 'CABECERA SIN DETALLE', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-15', 'RECHAZO POR OCR', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-16', 'MONTO MINIMO', 1, 'minimo');
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-17', 'MONTO MAXIMO', 1, 'maximo');
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-18', 'REEMPLAZOS Y ANULADOS', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-19', 'ACTUALIZACION DE DEUDA', 1, 'deuda');
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-20', 'CODIGO DE CLIENTE INEXISTENTE', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-23', 'VALIDACION DE EXISTENCIA CRONOGRAMA ACTIVIDADES', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-24', 'VALIDACION DE ERROR DE VENCIMIENTO DE CRONOGRAMA', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-25', 'VALIDACION DE UNIADES MAXIMA POR PRODUCTO Y PEDIDO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-26', 'VALIDACION DE PROGRAMA DE NUEVAS', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-29', 'VALIDACION DE OPORTUNIDADES PRIVILEGE', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-31', 'VALIDACION DE BLOQUEO POR CONTROL 2', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-34', 'VALIDACION CODIGO CLIENTE CAMBIADO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-39', 'VALIDACION DE SECUENCIACION DE ZONAS Y TERRITORIO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-45', 'VALIDACIÓN DE ERROR EN CONFIGURACIÓN DE MATRIZ', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-46', 'RECHAZO POR FECHA DE FACTURACION', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-51', 'VALIDACION MONTO MINIMO STOCK', 1, 'minstock');
GO