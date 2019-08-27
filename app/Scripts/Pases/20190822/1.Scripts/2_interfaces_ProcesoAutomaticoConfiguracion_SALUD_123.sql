USE BelcorpBolivia
GO
if not exists(select 1 from interfaces.ProcesoAutomaticoConfiguracion where CodigoProceso = 'VPR-01')
begin
	insert into interfaces.ProcesoAutomaticoConfiguracion(CodigoProceso, Activo, RestriccionEjecucion, HoraInicioRestriccion, HoraFinRestriccion, ServiceEndPoint, EnvioCorreoTodo, EnvioCorreoError, TiempoEstadoPendiente)
	values('VPR-01', 1, 0, '08:00:00', '20:00:00', 'http://internal-PRDELB-WEBPROL-686478451.us-east-1.elb.amazonaws.com/wsPROLSicc/ServiceStockSsic.asmx', 0, 0, 120)
end
GO

USE BelcorpChile
GO
if not exists(select 1 from interfaces.ProcesoAutomaticoConfiguracion where CodigoProceso = 'VPR-01')
begin
	insert into interfaces.ProcesoAutomaticoConfiguracion(CodigoProceso, Activo, RestriccionEjecucion, HoraInicioRestriccion, HoraFinRestriccion, ServiceEndPoint, EnvioCorreoTodo, EnvioCorreoError, TiempoEstadoPendiente)
	values('VPR-01', 1, 0, '08:00:00', '20:00:00', 'http://internal-PRDELB-WEBPROL-686478451.us-east-1.elb.amazonaws.com/wsPROLSicc/ServiceStockSsic.asmx', 0, 0, 120)
end
GO

USE BelcorpColombia
GO
if not exists(select 1 from interfaces.ProcesoAutomaticoConfiguracion where CodigoProceso = 'VPR-01')
begin
	insert into interfaces.ProcesoAutomaticoConfiguracion(CodigoProceso, Activo, RestriccionEjecucion, HoraInicioRestriccion, HoraFinRestriccion, ServiceEndPoint, EnvioCorreoTodo, EnvioCorreoError, TiempoEstadoPendiente)
	values('VPR-01', 1, 0, '08:00:00', '20:00:00', 'http://internal-PRDELB-WEBPROL-686478451.us-east-1.elb.amazonaws.com/wsPROLSicc/ServiceStockSsic.asmx', 0, 0, 120)
end
GO

USE BelcorpCostaRica
GO
if not exists(select 1 from interfaces.ProcesoAutomaticoConfiguracion where CodigoProceso = 'VPR-01')
begin
	insert into interfaces.ProcesoAutomaticoConfiguracion(CodigoProceso, Activo, RestriccionEjecucion, HoraInicioRestriccion, HoraFinRestriccion, ServiceEndPoint, EnvioCorreoTodo, EnvioCorreoError, TiempoEstadoPendiente)
	values('VPR-01', 1, 0, '08:00:00', '20:00:00', 'http://internal-PRDELB-WEBPROL-686478451.us-east-1.elb.amazonaws.com/wsPROLSicc/ServiceStockSsic.asmx', 0, 0, 120)
end
GO

USE BelcorpDominicana
GO
if not exists(select 1 from interfaces.ProcesoAutomaticoConfiguracion where CodigoProceso = 'VPR-01')
begin
	insert into interfaces.ProcesoAutomaticoConfiguracion(CodigoProceso, Activo, RestriccionEjecucion, HoraInicioRestriccion, HoraFinRestriccion, ServiceEndPoint, EnvioCorreoTodo, EnvioCorreoError, TiempoEstadoPendiente)
	values('VPR-01', 1, 0, '08:00:00', '20:00:00', 'http://internal-PRDELB-WEBPROL-686478451.us-east-1.elb.amazonaws.com/wsPROLSicc/ServiceStockSsic.asmx', 0, 0, 120)
end
GO

USE BelcorpEcuador
GO
if not exists(select 1 from interfaces.ProcesoAutomaticoConfiguracion where CodigoProceso = 'VPR-01')
begin
	insert into interfaces.ProcesoAutomaticoConfiguracion(CodigoProceso, Activo, RestriccionEjecucion, HoraInicioRestriccion, HoraFinRestriccion, ServiceEndPoint, EnvioCorreoTodo, EnvioCorreoError, TiempoEstadoPendiente)
	values('VPR-01', 1, 0, '08:00:00', '20:00:00', 'http://internal-PRDELB-WEBPROL-686478451.us-east-1.elb.amazonaws.com/wsPROLSicc/ServiceStockSsic.asmx', 0, 0, 120)
end
GO

USE BelcorpGuatemala
GO
if not exists(select 1 from interfaces.ProcesoAutomaticoConfiguracion where CodigoProceso = 'VPR-01')
begin
	insert into interfaces.ProcesoAutomaticoConfiguracion(CodigoProceso, Activo, RestriccionEjecucion, HoraInicioRestriccion, HoraFinRestriccion, ServiceEndPoint, EnvioCorreoTodo, EnvioCorreoError, TiempoEstadoPendiente)
	values('VPR-01', 1, 0, '08:00:00', '20:00:00', 'http://internal-PRDELB-WEBPROL-686478451.us-east-1.elb.amazonaws.com/wsPROLSicc/ServiceStockSsic.asmx', 0, 0, 120)
end
GO

USE BelcorpMexico
GO
if not exists(select 1 from interfaces.ProcesoAutomaticoConfiguracion where CodigoProceso = 'VPR-01')
begin
	insert into interfaces.ProcesoAutomaticoConfiguracion(CodigoProceso, Activo, RestriccionEjecucion, HoraInicioRestriccion, HoraFinRestriccion, ServiceEndPoint, EnvioCorreoTodo, EnvioCorreoError, TiempoEstadoPendiente)
	values('VPR-01', 1, 0, '08:00:00', '20:00:00', 'http://internal-PRDELB-WEBPROL-686478451.us-east-1.elb.amazonaws.com/wsPROLSicc/ServiceStockSsic.asmx', 0, 0, 120)
end
GO

USE BelcorpPanama
GO
if not exists(select 1 from interfaces.ProcesoAutomaticoConfiguracion where CodigoProceso = 'VPR-01')
begin
	insert into interfaces.ProcesoAutomaticoConfiguracion(CodigoProceso, Activo, RestriccionEjecucion, HoraInicioRestriccion, HoraFinRestriccion, ServiceEndPoint, EnvioCorreoTodo, EnvioCorreoError, TiempoEstadoPendiente)
	values('VPR-01', 1, 0, '08:00:00', '20:00:00', 'http://internal-PRDELB-WEBPROL-686478451.us-east-1.elb.amazonaws.com/wsPROLSicc/ServiceStockSsic.asmx', 0, 0, 120)
end
GO

USE BelcorpPeru
GO
if not exists(select 1 from interfaces.ProcesoAutomaticoConfiguracion where CodigoProceso = 'VPR-01')
begin
	insert into interfaces.ProcesoAutomaticoConfiguracion(CodigoProceso, Activo, RestriccionEjecucion, HoraInicioRestriccion, HoraFinRestriccion, ServiceEndPoint, EnvioCorreoTodo, EnvioCorreoError, TiempoEstadoPendiente)
	values('VPR-01', 1, 0, '08:00:00', '20:00:00', 'http://internal-PRDELB-WEBPROL-686478451.us-east-1.elb.amazonaws.com/wsPROLSicc/ServiceStockSsic.asmx', 0, 0, 120)
end
GO

USE BelcorpPuertoRico
GO
if not exists(select 1 from interfaces.ProcesoAutomaticoConfiguracion where CodigoProceso = 'VPR-01')
begin
	insert into interfaces.ProcesoAutomaticoConfiguracion(CodigoProceso, Activo, RestriccionEjecucion, HoraInicioRestriccion, HoraFinRestriccion, ServiceEndPoint, EnvioCorreoTodo, EnvioCorreoError, TiempoEstadoPendiente)
	values('VPR-01', 1, 0, '08:00:00', '20:00:00', 'http://internal-PRDELB-WEBPROL-686478451.us-east-1.elb.amazonaws.com/wsPROLSicc/ServiceStockSsic.asmx', 0, 0, 120)
end
GO

USE BelcorpSalvador
GO
if not exists(select 1 from interfaces.ProcesoAutomaticoConfiguracion where CodigoProceso = 'VPR-01')
begin
	insert into interfaces.ProcesoAutomaticoConfiguracion(CodigoProceso, Activo, RestriccionEjecucion, HoraInicioRestriccion, HoraFinRestriccion, ServiceEndPoint, EnvioCorreoTodo, EnvioCorreoError, TiempoEstadoPendiente)
	values('VPR-01', 1, 0, '08:00:00', '20:00:00', 'http://internal-PRDELB-WEBPROL-686478451.us-east-1.elb.amazonaws.com/wsPROLSicc/ServiceStockSsic.asmx', 0, 0, 120)
end
GO