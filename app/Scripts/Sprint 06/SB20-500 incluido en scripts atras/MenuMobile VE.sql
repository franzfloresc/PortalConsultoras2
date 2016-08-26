DELETE FROM MenuMobile WHERE Posicion='Menu'

INSERT INTO MenuMobile(MenuMobileID, Descripcion, MenuPadreID, OrdenItem, UrlItem, UrlImagen, PaginaNueva, Posicion, [Version])
VALUES
(1, 'Mi Negocio', 0, 1, '', '', 0, 'Menu', 'Mobile'),
(2, 'Catálogos y Revistas', 0, 2, 'Mobile/Catalogo', '', 0, 'Menu', 'Mobile'),
(3, 'Mi Asesor de Belleza', 0, 3, '', '', 0, 'Menu', 'Mobile'),
(4, 'Mi Academia', 0, 4, 'MiAcademia/Index', '', 1, 'Menu', 'Mobile'),
(5, 'Mi Comunidad', 0, 5, 'Comunidad/Index', '', 1, 'Menu', 'Mobile'),
(6, 'Mis Notificaciones', 0, 6, 'Mobile/Notificaciones', '', 0, 'Menu', 'Mobile'),

(9, 'Seguimiento a tu pedido', 1, 1, 'Mobile/SeguimientoPedido', '', 0, 'Menu', 'Mobile'),
--(11, 'Pedido FIC', 1, 2, '#', '', 0, 'Menu', 'Mobile'),
(12, 'Pedidos ingresados', 1, 3, 'Mobile/PedidosFacturados', '', 0, 'Menu', 'Mobile'),
(13, 'Pedidos facturados', 1, 4, 'Mobile/PedidosFacturados', '', 0, 'Menu', 'Mobile'),
(10, 'Estado de cuenta', 1, 5, 'Mobile/EstadoCuenta', '', 0, 'Menu', 'Mobile'),
--(16, 'Pago en Línea', 1, 6, 'Mobile/Paypal', '', 0, 'Menu', 'Mobile')
--(7, 'Consultora Online', 1, 7, 'Mobile/ConsultoraOnline', '', 0, 'Menu', 'Mobile'),
(14, 'Mis clientes', 1, 8, 'Mobile/Cliente', '', 0, 'Menu', 'Mobile'),
--(8, 'Liquidación web', 1, 9, 'Mobile/OfertaLiquidacion', '', 0, 'Menu', 'Mobile'),
(15, 'Productos Agotados', 1, 10, 'Mobile/ProductosAgotados', '', 0, 'Menu', 'Mobile')