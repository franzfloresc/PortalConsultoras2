GO
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'PedidoRecuperacionDetalle' AND TABLE_SCHEMA = 'dbo')
BEGIN
    DROP TABLE dbo.PedidoRecuperacionDetalle;
END
GO
CREATE TABLE dbo.PedidoRecuperacionDetalle(
	PedidoRecuperacionDetalleId int identity(1,1) primary key,
	PedidoRecuperacionId int,
	CUV varchar(6) not null,
	Cantidad int not null
);
GO