USE BelcorpBolivia
GO
IF (NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'PedidoDDDetalle' AND COLUMN_NAME = 'IndicadorEnviado'))
BEGIN
    alter table dbo.PedidoDDDetalle
	add IndicadorEnviado bit not null
	constraint DF_IndicadorEnviado DEFAULT 0;
END
GO
/*end*/

USE BelcorpChile
GO
IF (NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'PedidoDDDetalle' AND COLUMN_NAME = 'IndicadorEnviado'))
BEGIN
    alter table dbo.PedidoDDDetalle
	add IndicadorEnviado bit not null
	constraint DF_IndicadorEnviado DEFAULT 0;
END
GO
/*end*/

USE BelcorpColombia
GO
IF (NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'PedidoDDDetalle' AND COLUMN_NAME = 'IndicadorEnviado'))
BEGIN
    alter table dbo.PedidoDDDetalle
	add IndicadorEnviado bit not null
	constraint DF_IndicadorEnviado DEFAULT 0;
END
GO
/*end*/

USE BelcorpCostaRica
GO
IF (NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'PedidoDDDetalle' AND COLUMN_NAME = 'IndicadorEnviado'))
BEGIN
    alter table dbo.PedidoDDDetalle
	add IndicadorEnviado bit not null
	constraint DF_IndicadorEnviado DEFAULT 0;
END
GO
/*end*/

USE BelcorpDominicana
GO
IF (NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'PedidoDDDetalle' AND COLUMN_NAME = 'IndicadorEnviado'))
BEGIN
    alter table dbo.PedidoDDDetalle
	add IndicadorEnviado bit not null
	constraint DF_IndicadorEnviado DEFAULT 0;
END
GO
/*end*/

USE BelcorpEcuador
GO
IF (NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'PedidoDDDetalle' AND COLUMN_NAME = 'IndicadorEnviado'))
BEGIN
    alter table dbo.PedidoDDDetalle
	add IndicadorEnviado bit not null
	constraint DF_IndicadorEnviado DEFAULT 0;
END
GO
/*end*/

USE BelcorpGuatemala
GO
IF (NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'PedidoDDDetalle' AND COLUMN_NAME = 'IndicadorEnviado'))
BEGIN
    alter table dbo.PedidoDDDetalle
	add IndicadorEnviado bit not null
	constraint DF_IndicadorEnviado DEFAULT 0;
END
GO
/*end*/

USE BelcorpMexico
GO
IF (NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'PedidoDDDetalle' AND COLUMN_NAME = 'IndicadorEnviado'))
BEGIN
    alter table dbo.PedidoDDDetalle
	add IndicadorEnviado bit not null
	constraint DF_IndicadorEnviado DEFAULT 0;
END
GO
/*end*/

USE BelcorpPanama
GO
IF (NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'PedidoDDDetalle' AND COLUMN_NAME = 'IndicadorEnviado'))
BEGIN
    alter table dbo.PedidoDDDetalle
	add IndicadorEnviado bit not null
	constraint DF_IndicadorEnviado DEFAULT 0;
END
GO
/*end*/

USE BelcorpPeru
GO
IF (NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'PedidoDDDetalle' AND COLUMN_NAME = 'IndicadorEnviado'))
BEGIN
    alter table dbo.PedidoDDDetalle
	add IndicadorEnviado bit not null
	constraint DF_IndicadorEnviado DEFAULT 0;
END
GO
/*end*/

USE BelcorpPuertoRico
GO
IF (NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'PedidoDDDetalle' AND COLUMN_NAME = 'IndicadorEnviado'))
BEGIN
    alter table dbo.PedidoDDDetalle
	add IndicadorEnviado bit not null
	constraint DF_IndicadorEnviado DEFAULT 0;
END
GO
/*end*/

USE BelcorpSalvador
GO
IF (NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'PedidoDDDetalle' AND COLUMN_NAME = 'IndicadorEnviado'))
BEGIN
    alter table dbo.PedidoDDDetalle
	add IndicadorEnviado bit not null
	constraint DF_IndicadorEnviado DEFAULT 0;
END
GO
/*end*/

USE BelcorpVenezuela
GO
IF (NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'PedidoDDDetalle' AND COLUMN_NAME = 'IndicadorEnviado'))
BEGIN
    alter table dbo.PedidoDDDetalle
	add IndicadorEnviado bit not null
	constraint DF_IndicadorEnviado DEFAULT 0;
END
GO