USE BelcorpColombia
GO
DELETE FROM GPR.MotivoRechazo;
GO
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-1', 'TIPO DE SOLICITUD', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-2', 'DIRECCIONES CLIENTE', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-3', 'UNIDADES ADMINISTRATIVAS', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-4', 'TIPO DE DESPACHO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-5', 'TIPO DE CAMBIO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-6', 'CONSULTORA RETIRADA', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-7', 'SEGUNDO PEDIDO NO AUTORIZADO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-8', 'BLOQUEO DEL CLIENTE', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-12', 'OC SIN PRODUCTOS', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-16', 'MONTO MINIMO', 1, 'minimo');
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-17', 'MONTO MAXIMO', 1, 'maximo');
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-19', 'DEUDA', 1, 'deuda');
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-20', 'CONSULTORA NO EXISTE', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-26', 'VALIDACION DE PROGRAMA DE NUEVAS', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-31', 'BLOQUEO POR CONTROL', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-33', 'VALIDACION DE NUEVAS Y REINGRESOS 2DO DIA', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-34', 'VALIDACION CODIGO CLIENTE CAMBIADO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-36', 'TIPO DE DOCUMENTO INVALIDO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-37', 'DOCUMENTO ILEGIBLE', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-40', 'RECARGO FLETE', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-46', 'CRONOGRAMA NO ESTA ABIERTO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-51', 'MONTO INFERIOR', 1, 'minstock');
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-55', 'SCC EN GESTION O RECHAZADA', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-58', 'DESVIACION', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-60', 'ANUL. MODIFICACION DE UNIDADES', 0, NULL);
GO
/*end*/

USE BelcorpMexico
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
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-33', 'VALIDACION DE REGISTRADA EGRESADA TERCER DIA', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-34', 'VALIDACION CODIGO CLIENTE CAMBIADO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-36', 'VALIDACION DE TIPO DE DOCUMENTO INVALIDO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-37', 'VALIDACION RECHAZO OCR2', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-40', 'RECARGO FLETE', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-45', 'VALIDACIÓN DE ERROR EN CONFIGURACIÓN DE MATRIZ', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-46', 'RECHAZO POR FECHA DE FACTURACION', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-58', 'DESVIACION', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-60', 'ANUL. MODIFICACION DE UNIDADES', 0, NULL);
GO
/*end*/

USE BelcorpPeru
GO
DELETE FROM GPR.MotivoRechazo;
GO
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-1', 'VALIDACION TIPO DE SOLICITUD', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-2', 'VALIDACION DIRECCIONES CLIENTE', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-3', 'VALIDACION UNIDADES ADMINISTRATIVAS', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-4', 'VALIDACION DE TIPO DE DESPACHO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-5', 'VALIDACION DE TIPO DE CAMBIO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-6', 'VALIDACION DE CLIENTE INACTIVO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-7', 'VALIDACION DE SEGUNDO PEDIDO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-8', 'VALIDACION DE  BLOQUEO DEL CLIENTE', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-12', 'VALIDACION CABECERA SIN DETALLE', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-16', 'VALIDACION MONTO MINIMO', 1, 'minimo');
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-17', 'VALIDACION MONTO MAXIMO', 1, 'maximo');
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-19', 'VALIDACION DE ACTUALIZACION DE DEUDA', 1, 'deuda');
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-20', 'VALIDACION DE CODIGO DE CLIENTE INEXISTENTE', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-23', 'VALIDACION DE EXISTENCIA CRONOGRAMA ACTIVIDADES', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-26', 'VALIDACION DE PROGRAMA DE NUEVAS', 0, NULL);
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