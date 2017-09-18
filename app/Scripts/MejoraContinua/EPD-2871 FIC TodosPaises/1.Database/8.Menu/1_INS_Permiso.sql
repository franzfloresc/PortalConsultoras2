GO
delete from RolPermiso
where PermisoID in (
	select PermisoID
	from Permiso
	where Descripcion in (
		'Activar Cronograma FIC',
		'Desactivar Cronograma FIC',
		'Configurar Cronograma FIC',
		'Reporte Pedido FIC',
		'Pedido FIC',
		'Administrar Oferta FIC'
	)
);
GO
delete from Permiso
where Descripcion in (
	'Activar Cronograma FIC',
	'Desactivar Cronograma FIC',
	'Configurar Cronograma FIC',
	'Reporte Pedido FIC',
	'Pedido FIC',
	'Administrar Oferta FIC'
);
GO
insert Permiso (PermisoID,Descripcion,IdPadre,OrdenItem,UrlItem,PaginaNueva,Posicion,EsPrincipal,UrlImagen,EsSoloImagen,EsMenuEspecial,EsServicios,Codigo) values
	(501, N'Activar Cronograma FIC', 81, 26, N'CronogramaFIC/Index', 0, N'Header',0,null,0,0,0,'PedidoFIC'),
	(502, N'Desactivar Cronograma FIC', 81, 27, N'CronogramaFIC/DesactivarCronogramaFIC', 0, N'Header',0,null,0,0,0,'PedidoFIC'),
	(503, N'Configurar Cronograma FIC', 81, 28, N'CronogramaFIC/ConfigurarCronogramaFIC', 0, N'Header',0,null,0,0,0,'PedidoFIC'),
	(504, N'Reporte Pedido FIC', 81, 29, N'ReportePedidoFIC/Index', 0, N'Header',0,null,0,0,0,'PedidoFIC'),
	(505, N'Administrar Oferta FIC', 81, 30, N'OfertaFIC/Index', 0, N'Header',0,null,0,0,0,'PedidoFIC'),
	(1014, N'Pedido FIC', 1003, 3, N'PedidoFIC/Index', 0, N'Header',1,null,0,0,0,'PedidoFIC');
GO
insert RolPermiso(RolID, PermisoID, Activo, Mostrar) values
	(1, 1014, 1, 1),
	(3, 501, 1, 1),
	(3, 502, 1, 1),
	(3, 503, 1, 1),
	(3, 504, 1, 1),
	(3, 505, 1, 1),
	(7, 501, 1, 1),
	(7, 502, 1, 1),
	(7, 503, 1, 1),
	(7, 504, 1, 1),
	(7, 505, 1, 1);
GO