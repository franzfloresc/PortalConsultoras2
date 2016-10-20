USE BelcorpBolivia
GO
IF NOT EXISTS(SELECT 1 FROM GPR.ProcesoPedidoRechazadoConfiguracion WHERE CodigoProceso = 'VPR-01')
BEGIN
	INSERT GPR.ProcesoPedidoRechazadoConfiguracion(ProcesoPedidoRechazadoConfiguracionId,CodigoProceso,Activo,RestriccionEjecucion,HoraInicioRestriccion,HoraFinRestriccion,ProlServiceEndPoint,EnvioCorreoTodo,EnvioCorreoError)
	VALUES (1, 'VPR-01', 1, 1, '08:00:00', '20:00:00', 'http://qaielb-webprol-1875224445.us-east-1.elb.amazonaws.com/wsPROLSicc/ServiceStockSsic.asmx', 0, 0);
END
GO
/*end*/

USE BelcorpChile
GO
IF NOT EXISTS(SELECT 1 FROM GPR.ProcesoPedidoRechazadoConfiguracion WHERE CodigoProceso = 'VPR-01')
BEGIN
	INSERT GPR.ProcesoPedidoRechazadoConfiguracion(ProcesoPedidoRechazadoConfiguracionId,CodigoProceso,Activo,RestriccionEjecucion,HoraInicioRestriccion,HoraFinRestriccion,ProlServiceEndPoint,EnvioCorreoTodo,EnvioCorreoError)
	VALUES (1, 'VPR-01', 1, 1, '08:00:00', '20:00:00', 'http://qaielb-webprol-1875224445.us-east-1.elb.amazonaws.com/wsPROLSicc/ServiceStockSsic.asmx', 0, 0);
END
GO
/*end*/

USE BelcorpCostaRica
GO
IF NOT EXISTS(SELECT 1 FROM GPR.ProcesoPedidoRechazadoConfiguracion WHERE CodigoProceso = 'VPR-01')
BEGIN
	INSERT GPR.ProcesoPedidoRechazadoConfiguracion(ProcesoPedidoRechazadoConfiguracionId,CodigoProceso,Activo,RestriccionEjecucion,HoraInicioRestriccion,HoraFinRestriccion,ProlServiceEndPoint,EnvioCorreoTodo,EnvioCorreoError)
	VALUES (1, 'VPR-01', 1, 1, '08:00:00', '20:00:00', 'http://qaielb-webprol-1875224445.us-east-1.elb.amazonaws.com/wsPROLSicc/ServiceStockSsic.asmx', 0, 0);
END
GO
/*end*/

USE BelcorpDominicana
GO
IF NOT EXISTS(SELECT 1 FROM GPR.ProcesoPedidoRechazadoConfiguracion WHERE CodigoProceso = 'VPR-01')
BEGIN
	INSERT GPR.ProcesoPedidoRechazadoConfiguracion(ProcesoPedidoRechazadoConfiguracionId,CodigoProceso,Activo,RestriccionEjecucion,HoraInicioRestriccion,HoraFinRestriccion,ProlServiceEndPoint,EnvioCorreoTodo,EnvioCorreoError)
	VALUES (1, 'VPR-01', 1, 1, '08:00:00', '20:00:00', 'http://qaielb-webprol-1875224445.us-east-1.elb.amazonaws.com/wsPROLSicc/ServiceStockSsic.asmx', 0, 0);
END
GO
/*end*/

USE BelcorpEcuador
GO
IF NOT EXISTS(SELECT 1 FROM GPR.ProcesoPedidoRechazadoConfiguracion WHERE CodigoProceso = 'VPR-01')
BEGIN
	INSERT GPR.ProcesoPedidoRechazadoConfiguracion(ProcesoPedidoRechazadoConfiguracionId,CodigoProceso,Activo,RestriccionEjecucion,HoraInicioRestriccion,HoraFinRestriccion,ProlServiceEndPoint,EnvioCorreoTodo,EnvioCorreoError)
	VALUES (1, 'VPR-01', 1, 1, '08:00:00', '20:00:00', 'http://qaielb-webprol-1875224445.us-east-1.elb.amazonaws.com/wsPROLSicc/ServiceStockSsic.asmx', 0, 0);
END
GO
/*end*/

USE BelcorpGuatemala
GO
IF NOT EXISTS(SELECT 1 FROM GPR.ProcesoPedidoRechazadoConfiguracion WHERE CodigoProceso = 'VPR-01')
BEGIN
	INSERT GPR.ProcesoPedidoRechazadoConfiguracion(ProcesoPedidoRechazadoConfiguracionId,CodigoProceso,Activo,RestriccionEjecucion,HoraInicioRestriccion,HoraFinRestriccion,ProlServiceEndPoint,EnvioCorreoTodo,EnvioCorreoError)
	VALUES (1, 'VPR-01', 1, 1, '08:00:00', '20:00:00', 'http://qaielb-webprol-1875224445.us-east-1.elb.amazonaws.com/wsPROLSicc/ServiceStockSsic.asmx', 0, 0);
END
GO
/*end*/

USE BelcorpPanama
GO
IF NOT EXISTS(SELECT 1 FROM GPR.ProcesoPedidoRechazadoConfiguracion WHERE CodigoProceso = 'VPR-01')
BEGIN
	INSERT GPR.ProcesoPedidoRechazadoConfiguracion(ProcesoPedidoRechazadoConfiguracionId,CodigoProceso,Activo,RestriccionEjecucion,HoraInicioRestriccion,HoraFinRestriccion,ProlServiceEndPoint,EnvioCorreoTodo,EnvioCorreoError)
	VALUES (1, 'VPR-01', 1, 1, '08:00:00', '20:00:00', 'http://qaielb-webprol-1875224445.us-east-1.elb.amazonaws.com/wsPROLSicc/ServiceStockSsic.asmx', 0, 0);
END
GO
/*end*/

USE BelcorpPuertoRico
GO
IF NOT EXISTS(SELECT 1 FROM GPR.ProcesoPedidoRechazadoConfiguracion WHERE CodigoProceso = 'VPR-01')
BEGIN
	INSERT GPR.ProcesoPedidoRechazadoConfiguracion(ProcesoPedidoRechazadoConfiguracionId,CodigoProceso,Activo,RestriccionEjecucion,HoraInicioRestriccion,HoraFinRestriccion,ProlServiceEndPoint,EnvioCorreoTodo,EnvioCorreoError)
	VALUES (1, 'VPR-01', 1, 1, '08:00:00', '20:00:00', 'http://qaielb-webprol-1875224445.us-east-1.elb.amazonaws.com/wsPROLSicc/ServiceStockSsic.asmx', 0, 0);
END
GO
/*end*/

USE BelcorpSalvador
GO
IF NOT EXISTS(SELECT 1 FROM GPR.ProcesoPedidoRechazadoConfiguracion WHERE CodigoProceso = 'VPR-01')
BEGIN
	INSERT GPR.ProcesoPedidoRechazadoConfiguracion(ProcesoPedidoRechazadoConfiguracionId,CodigoProceso,Activo,RestriccionEjecucion,HoraInicioRestriccion,HoraFinRestriccion,ProlServiceEndPoint,EnvioCorreoTodo,EnvioCorreoError)
	VALUES (1, 'VPR-01', 1, 1, '08:00:00', '20:00:00', 'http://qaielb-webprol-1875224445.us-east-1.elb.amazonaws.com/wsPROLSicc/ServiceStockSsic.asmx', 0, 0);
END
GO
/*end*/

USE BelcorpVenezuela
GO
IF NOT EXISTS(SELECT 1 FROM GPR.ProcesoPedidoRechazadoConfiguracion WHERE CodigoProceso = 'VPR-01')
BEGIN
	INSERT GPR.ProcesoPedidoRechazadoConfiguracion(ProcesoPedidoRechazadoConfiguracionId,CodigoProceso,Activo,RestriccionEjecucion,HoraInicioRestriccion,HoraFinRestriccion,ProlServiceEndPoint,EnvioCorreoTodo,EnvioCorreoError)
	VALUES (1, 'VPR-01', 1, 1, '08:00:00', '20:00:00', 'http://qaielb-webprol-1875224445.us-east-1.elb.amazonaws.com/wsPROLSicc/ServiceStockSsic.asmx', 0, 0);
END
GO