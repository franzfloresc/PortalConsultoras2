USE BelcorpBolivia
GO
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'LogGPRValidacionDetalle' AND TABLE_SCHEMA = 'GPR')
BEGIN
    DROP TABLE GPR.LogGPRValidacionDetalle;
END
GO
CREATE TABLE GPR.LogGPRValidacionDetalle(
	LogGPRValidacionDetalleId BIGINT IDENTITY(1,1) PRIMARY KEY,
	LogGPRValidacionId BIGINT NOT NULL,
	PedidoDetalleID SMALLINT NOT NULL,
	CUV VARCHAR(20) NOT NULL,
	Descripcion VARCHAR(200) NOT NULL,
	Cantidad INT NOT NULL,
	PrecioUnidad MONEY NOT NULL,
	ImporteTotal MONEY NOT NULL,
	IndicadorOferta INT NOT NULL,
	ConfiguracionOfertaID INT NULL
);
GO
/*end*/

USE BelcorpChile
GO
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'LogGPRValidacionDetalle' AND TABLE_SCHEMA = 'GPR')
BEGIN
    DROP TABLE GPR.LogGPRValidacionDetalle;
END
GO
CREATE TABLE GPR.LogGPRValidacionDetalle(
	LogGPRValidacionDetalleId BIGINT IDENTITY(1,1) PRIMARY KEY,
	LogGPRValidacionId BIGINT NOT NULL,
	PedidoDetalleID SMALLINT NOT NULL,
	CUV VARCHAR(20) NOT NULL,
	Descripcion VARCHAR(200) NOT NULL,
	Cantidad INT NOT NULL,
	PrecioUnidad MONEY NOT NULL,
	ImporteTotal MONEY NOT NULL,
	IndicadorOferta INT NOT NULL,
	ConfiguracionOfertaID INT NULL
);
GO
/*end*/

USE BelcorpCostaRica
GO
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'LogGPRValidacionDetalle' AND TABLE_SCHEMA = 'GPR')
BEGIN
    DROP TABLE GPR.LogGPRValidacionDetalle;
END
GO
CREATE TABLE GPR.LogGPRValidacionDetalle(
	LogGPRValidacionDetalleId BIGINT IDENTITY(1,1) PRIMARY KEY,
	LogGPRValidacionId BIGINT NOT NULL,
	PedidoDetalleID SMALLINT NOT NULL,
	CUV VARCHAR(20) NOT NULL,
	Descripcion VARCHAR(200) NOT NULL,
	Cantidad INT NOT NULL,
	PrecioUnidad MONEY NOT NULL,
	ImporteTotal MONEY NOT NULL,
	IndicadorOferta INT NOT NULL,
	ConfiguracionOfertaID INT NULL
);
GO
/*end*/

USE BelcorpDominicana
GO
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'LogGPRValidacionDetalle' AND TABLE_SCHEMA = 'GPR')
BEGIN
    DROP TABLE GPR.LogGPRValidacionDetalle;
END
GO
CREATE TABLE GPR.LogGPRValidacionDetalle(
	LogGPRValidacionDetalleId BIGINT IDENTITY(1,1) PRIMARY KEY,
	LogGPRValidacionId BIGINT NOT NULL,
	PedidoDetalleID SMALLINT NOT NULL,
	CUV VARCHAR(20) NOT NULL,
	Descripcion VARCHAR(200) NOT NULL,
	Cantidad INT NOT NULL,
	PrecioUnidad MONEY NOT NULL,
	ImporteTotal MONEY NOT NULL,
	IndicadorOferta INT NOT NULL,
	ConfiguracionOfertaID INT NULL
);
GO
/*end*/

USE BelcorpEcuador
GO
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'LogGPRValidacionDetalle' AND TABLE_SCHEMA = 'GPR')
BEGIN
    DROP TABLE GPR.LogGPRValidacionDetalle;
END
GO
CREATE TABLE GPR.LogGPRValidacionDetalle(
	LogGPRValidacionDetalleId BIGINT IDENTITY(1,1) PRIMARY KEY,
	LogGPRValidacionId BIGINT NOT NULL,
	PedidoDetalleID SMALLINT NOT NULL,
	CUV VARCHAR(20) NOT NULL,
	Descripcion VARCHAR(200) NOT NULL,
	Cantidad INT NOT NULL,
	PrecioUnidad MONEY NOT NULL,
	ImporteTotal MONEY NOT NULL,
	IndicadorOferta INT NOT NULL,
	ConfiguracionOfertaID INT NULL
);
GO
/*end*/

USE BelcorpGuatemala
GO
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'LogGPRValidacionDetalle' AND TABLE_SCHEMA = 'GPR')
BEGIN
    DROP TABLE GPR.LogGPRValidacionDetalle;
END
GO
CREATE TABLE GPR.LogGPRValidacionDetalle(
	LogGPRValidacionDetalleId BIGINT IDENTITY(1,1) PRIMARY KEY,
	LogGPRValidacionId BIGINT NOT NULL,
	PedidoDetalleID SMALLINT NOT NULL,
	CUV VARCHAR(20) NOT NULL,
	Descripcion VARCHAR(200) NOT NULL,
	Cantidad INT NOT NULL,
	PrecioUnidad MONEY NOT NULL,
	ImporteTotal MONEY NOT NULL,
	IndicadorOferta INT NOT NULL,
	ConfiguracionOfertaID INT NULL
);
GO
/*end*/

USE BelcorpPanama
GO
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'LogGPRValidacionDetalle' AND TABLE_SCHEMA = 'GPR')
BEGIN
    DROP TABLE GPR.LogGPRValidacionDetalle;
END
GO
CREATE TABLE GPR.LogGPRValidacionDetalle(
	LogGPRValidacionDetalleId BIGINT IDENTITY(1,1) PRIMARY KEY,
	LogGPRValidacionId BIGINT NOT NULL,
	PedidoDetalleID SMALLINT NOT NULL,
	CUV VARCHAR(20) NOT NULL,
	Descripcion VARCHAR(200) NOT NULL,
	Cantidad INT NOT NULL,
	PrecioUnidad MONEY NOT NULL,
	ImporteTotal MONEY NOT NULL,
	IndicadorOferta INT NOT NULL,
	ConfiguracionOfertaID INT NULL
);
GO
/*end*/

USE BelcorpPuertoRico
GO
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'LogGPRValidacionDetalle' AND TABLE_SCHEMA = 'GPR')
BEGIN
    DROP TABLE GPR.LogGPRValidacionDetalle;
END
GO
CREATE TABLE GPR.LogGPRValidacionDetalle(
	LogGPRValidacionDetalleId BIGINT IDENTITY(1,1) PRIMARY KEY,
	LogGPRValidacionId BIGINT NOT NULL,
	PedidoDetalleID SMALLINT NOT NULL,
	CUV VARCHAR(20) NOT NULL,
	Descripcion VARCHAR(200) NOT NULL,
	Cantidad INT NOT NULL,
	PrecioUnidad MONEY NOT NULL,
	ImporteTotal MONEY NOT NULL,
	IndicadorOferta INT NOT NULL,
	ConfiguracionOfertaID INT NULL
);
GO
/*end*/

USE BelcorpSalvador
GO
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'LogGPRValidacionDetalle' AND TABLE_SCHEMA = 'GPR')
BEGIN
    DROP TABLE GPR.LogGPRValidacionDetalle;
END
GO
CREATE TABLE GPR.LogGPRValidacionDetalle(
	LogGPRValidacionDetalleId BIGINT IDENTITY(1,1) PRIMARY KEY,
	LogGPRValidacionId BIGINT NOT NULL,
	PedidoDetalleID SMALLINT NOT NULL,
	CUV VARCHAR(20) NOT NULL,
	Descripcion VARCHAR(200) NOT NULL,
	Cantidad INT NOT NULL,
	PrecioUnidad MONEY NOT NULL,
	ImporteTotal MONEY NOT NULL,
	IndicadorOferta INT NOT NULL,
	ConfiguracionOfertaID INT NULL
);
GO
/*end*/

USE BelcorpVenezuela
GO
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'LogGPRValidacionDetalle' AND TABLE_SCHEMA = 'GPR')
BEGIN
    DROP TABLE GPR.LogGPRValidacionDetalle;
END
GO
CREATE TABLE GPR.LogGPRValidacionDetalle(
	LogGPRValidacionDetalleId BIGINT IDENTITY(1,1) PRIMARY KEY,
	LogGPRValidacionId BIGINT NOT NULL,
	PedidoDetalleID SMALLINT NOT NULL,
	CUV VARCHAR(20) NOT NULL,
	Descripcion VARCHAR(200) NOT NULL,
	Cantidad INT NOT NULL,
	PrecioUnidad MONEY NOT NULL,
	ImporteTotal MONEY NOT NULL,
	IndicadorOferta INT NOT NULL,
	ConfiguracionOfertaID INT NULL
);
GO