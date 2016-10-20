USE BelcorpBolivia
GO
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'ProcesoValidacionPedidoRechazado' AND TABLE_SCHEMA = 'GPR')
BEGIN
    DROP TABLE GPR.ProcesoValidacionPedidoRechazado;
END
GO
CREATE TABLE GPR.ProcesoValidacionPedidoRechazado(
	ProcesoValidacionPedidoRechazadoId BIGINT IDENTITY(1,1) PRIMARY KEY,
	CodigoProceso VARCHAR(6) NULL,
	FechaHoraInicio DATETIME NULL,
	FechaHoraFin DATETIME NULL,
	Estado INT NULL,
	ErrorProceso VARCHAR(100) NULL,
	ErrorLog varchar(2000) NULL
);
GO
/*end*/

USE BelcorpChile
GO
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'ProcesoValidacionPedidoRechazado' AND TABLE_SCHEMA = 'GPR')
BEGIN
    DROP TABLE GPR.ProcesoValidacionPedidoRechazado;
END
GO
CREATE TABLE GPR.ProcesoValidacionPedidoRechazado(
	ProcesoValidacionPedidoRechazadoId BIGINT IDENTITY(1,1) PRIMARY KEY,
	CodigoProceso VARCHAR(6) NULL,
	FechaHoraInicio DATETIME NULL,
	FechaHoraFin DATETIME NULL,
	Estado INT NULL,
	ErrorProceso VARCHAR(100) NULL,
	ErrorLog varchar(2000) NULL
);
GO
/*end*/

USE BelcorpCostaRica
GO
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'ProcesoValidacionPedidoRechazado' AND TABLE_SCHEMA = 'GPR')
BEGIN
    DROP TABLE GPR.ProcesoValidacionPedidoRechazado;
END
GO
CREATE TABLE GPR.ProcesoValidacionPedidoRechazado(
	ProcesoValidacionPedidoRechazadoId BIGINT IDENTITY(1,1) PRIMARY KEY,
	CodigoProceso VARCHAR(6) NULL,
	FechaHoraInicio DATETIME NULL,
	FechaHoraFin DATETIME NULL,
	Estado INT NULL,
	ErrorProceso VARCHAR(100) NULL,
	ErrorLog varchar(2000) NULL
);
GO
/*end*/

USE BelcorpDominicana
GO
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'ProcesoValidacionPedidoRechazado' AND TABLE_SCHEMA = 'GPR')
BEGIN
    DROP TABLE GPR.ProcesoValidacionPedidoRechazado;
END
GO
CREATE TABLE GPR.ProcesoValidacionPedidoRechazado(
	ProcesoValidacionPedidoRechazadoId BIGINT IDENTITY(1,1) PRIMARY KEY,
	CodigoProceso VARCHAR(6) NULL,
	FechaHoraInicio DATETIME NULL,
	FechaHoraFin DATETIME NULL,
	Estado INT NULL,
	ErrorProceso VARCHAR(100) NULL,
	ErrorLog varchar(2000) NULL
);
GO
/*end*/

USE BelcorpEcuador
GO
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'ProcesoValidacionPedidoRechazado' AND TABLE_SCHEMA = 'GPR')
BEGIN
    DROP TABLE GPR.ProcesoValidacionPedidoRechazado;
END
GO
CREATE TABLE GPR.ProcesoValidacionPedidoRechazado(
	ProcesoValidacionPedidoRechazadoId BIGINT IDENTITY(1,1) PRIMARY KEY,
	CodigoProceso VARCHAR(6) NULL,
	FechaHoraInicio DATETIME NULL,
	FechaHoraFin DATETIME NULL,
	Estado INT NULL,
	ErrorProceso VARCHAR(100) NULL,
	ErrorLog varchar(2000) NULL
);
GO
/*end*/

USE BelcorpGuatemala
GO
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'ProcesoValidacionPedidoRechazado' AND TABLE_SCHEMA = 'GPR')
BEGIN
    DROP TABLE GPR.ProcesoValidacionPedidoRechazado;
END
GO
CREATE TABLE GPR.ProcesoValidacionPedidoRechazado(
	ProcesoValidacionPedidoRechazadoId BIGINT IDENTITY(1,1) PRIMARY KEY,
	CodigoProceso VARCHAR(6) NULL,
	FechaHoraInicio DATETIME NULL,
	FechaHoraFin DATETIME NULL,
	Estado INT NULL,
	ErrorProceso VARCHAR(100) NULL,
	ErrorLog varchar(2000) NULL
);
GO
/*end*/

USE BelcorpPanama
GO
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'ProcesoValidacionPedidoRechazado' AND TABLE_SCHEMA = 'GPR')
BEGIN
    DROP TABLE GPR.ProcesoValidacionPedidoRechazado;
END
GO
CREATE TABLE GPR.ProcesoValidacionPedidoRechazado(
	ProcesoValidacionPedidoRechazadoId BIGINT IDENTITY(1,1) PRIMARY KEY,
	CodigoProceso VARCHAR(6) NULL,
	FechaHoraInicio DATETIME NULL,
	FechaHoraFin DATETIME NULL,
	Estado INT NULL,
	ErrorProceso VARCHAR(100) NULL,
	ErrorLog varchar(2000) NULL
);
GO
/*end*/

USE BelcorpPuertoRico
GO
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'ProcesoValidacionPedidoRechazado' AND TABLE_SCHEMA = 'GPR')
BEGIN
    DROP TABLE GPR.ProcesoValidacionPedidoRechazado;
END
GO
CREATE TABLE GPR.ProcesoValidacionPedidoRechazado(
	ProcesoValidacionPedidoRechazadoId BIGINT IDENTITY(1,1) PRIMARY KEY,
	CodigoProceso VARCHAR(6) NULL,
	FechaHoraInicio DATETIME NULL,
	FechaHoraFin DATETIME NULL,
	Estado INT NULL,
	ErrorProceso VARCHAR(100) NULL,
	ErrorLog varchar(2000) NULL
);
GO
/*end*/

USE BelcorpSalvador
GO
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'ProcesoValidacionPedidoRechazado' AND TABLE_SCHEMA = 'GPR')
BEGIN
    DROP TABLE GPR.ProcesoValidacionPedidoRechazado;
END
GO
CREATE TABLE GPR.ProcesoValidacionPedidoRechazado(
	ProcesoValidacionPedidoRechazadoId BIGINT IDENTITY(1,1) PRIMARY KEY,
	CodigoProceso VARCHAR(6) NULL,
	FechaHoraInicio DATETIME NULL,
	FechaHoraFin DATETIME NULL,
	Estado INT NULL,
	ErrorProceso VARCHAR(100) NULL,
	ErrorLog varchar(2000) NULL
);
GO
/*end*/

USE BelcorpVenezuela
GO
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'ProcesoValidacionPedidoRechazado' AND TABLE_SCHEMA = 'GPR')
BEGIN
    DROP TABLE GPR.ProcesoValidacionPedidoRechazado;
END
GO
CREATE TABLE GPR.ProcesoValidacionPedidoRechazado(
	ProcesoValidacionPedidoRechazadoId BIGINT IDENTITY(1,1) PRIMARY KEY,
	CodigoProceso VARCHAR(6) NULL,
	FechaHoraInicio DATETIME NULL,
	FechaHoraFin DATETIME NULL,
	Estado INT NULL,
	ErrorProceso VARCHAR(100) NULL,
	ErrorLog varchar(2000) NULL
);
GO