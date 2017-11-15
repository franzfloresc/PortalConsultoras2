GO
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'PedidoRecuperacion' AND TABLE_SCHEMA = 'dbo')
BEGIN
    DROP TABLE dbo.PedidoRecuperacion;
END
GO
CREATE TABLE dbo.PedidoRecuperacion(
	PedidoRecuperacionId int identity(1,1) primary key,
	CampaniaID int not null,
	ConsultoraID bigint not null,
	CodigoConsultora varchar(25) not null,
	Mostrado bit null
);
GO