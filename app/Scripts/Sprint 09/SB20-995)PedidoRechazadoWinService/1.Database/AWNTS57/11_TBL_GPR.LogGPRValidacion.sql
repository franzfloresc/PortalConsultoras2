USE BelcorpBolivia
GO
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'LogGPRValidacion' AND TABLE_SCHEMA = 'GPR')
BEGIN
    DROP TABLE GPR.LogGPRValidacion;
END
GO
CREATE TABLE GPR.LogGPRValidacion(
	LogGPRValidacionId BIGINT IDENTITY(1,1) PRIMARY KEY,
	ProcesoValidacionPedidoRechazadoId BIGINT NOT NULL,
	IdPedidoRechazado BIGINT NOT NULL,
	DescripcionRechazo VARCHAR(200) NOT NULL,
	ConsultoraID BIGINT NULL,
	CodigoUsuario VARCHAR(20) NULL,
	NombreCompleto VARCHAR(80) NULL,
	Email VARCHAR(50) NULL,
	ZonaNuevoProl BIT NOT NULL,
	PedidoID INT NULL,
	SubTotal MONEY NULL,
	Descuento MONEY NULL,
	EstadoSimplificacionCUV BIT NULL,
	FechaFinValidacion DATETIME NULL,
	Rechazado BIT NOT NULL,
	Visualizado BIT NOT NULL,
	ErrorValidacion VARCHAR(100) NULL,
	ErrorProceso VARCHAR(100) NULL,
	ErrorLog VARCHAR(2000) NULL
);
GO
ALTER TABLE GPR.LogGPRValidacion 
ADD CONSTRAINT DF_LogGPRValidacion_Rechazado
DEFAULT 0 FOR Rechazado;
GO
ALTER TABLE GPR.LogGPRValidacion 
ADD CONSTRAINT DF_LogGPRValidacion_Visualizado
DEFAULT 0 FOR Visualizado;
GO
/*end*/

USE BelcorpChile
GO
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'LogGPRValidacion' AND TABLE_SCHEMA = 'GPR')
BEGIN
    DROP TABLE GPR.LogGPRValidacion;
END
GO
CREATE TABLE GPR.LogGPRValidacion(
	LogGPRValidacionId BIGINT IDENTITY(1,1) PRIMARY KEY,
	ProcesoValidacionPedidoRechazadoId BIGINT NOT NULL,
	IdPedidoRechazado BIGINT NOT NULL,
	DescripcionRechazo VARCHAR(200) NOT NULL,
	ConsultoraID BIGINT NULL,
	CodigoUsuario VARCHAR(20) NULL,
	NombreCompleto VARCHAR(80) NULL,
	Email VARCHAR(50) NULL,
	ZonaNuevoProl BIT NOT NULL,
	PedidoID INT NULL,
	SubTotal MONEY NULL,
	Descuento MONEY NULL,
	EstadoSimplificacionCUV BIT NULL,
	FechaFinValidacion DATETIME NULL,
	Rechazado BIT NOT NULL,
	Visualizado BIT NOT NULL,
	ErrorValidacion VARCHAR(100) NULL,
	ErrorProceso VARCHAR(100) NULL,
	ErrorLog VARCHAR(2000) NULL
);
GO
ALTER TABLE GPR.LogGPRValidacion 
ADD CONSTRAINT DF_LogGPRValidacion_Rechazado
DEFAULT 0 FOR Rechazado;
GO
ALTER TABLE GPR.LogGPRValidacion 
ADD CONSTRAINT DF_LogGPRValidacion_Visualizado
DEFAULT 0 FOR Visualizado;
GO
/*end*/

USE BelcorpCostaRica
GO
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'LogGPRValidacion' AND TABLE_SCHEMA = 'GPR')
BEGIN
    DROP TABLE GPR.LogGPRValidacion;
END
GO
CREATE TABLE GPR.LogGPRValidacion(
	LogGPRValidacionId BIGINT IDENTITY(1,1) PRIMARY KEY,
	ProcesoValidacionPedidoRechazadoId BIGINT NOT NULL,
	IdPedidoRechazado BIGINT NOT NULL,
	DescripcionRechazo VARCHAR(200) NOT NULL,
	ConsultoraID BIGINT NULL,
	CodigoUsuario VARCHAR(20) NULL,
	NombreCompleto VARCHAR(80) NULL,
	Email VARCHAR(50) NULL,
	ZonaNuevoProl BIT NOT NULL,
	PedidoID INT NULL,
	SubTotal MONEY NULL,
	Descuento MONEY NULL,
	EstadoSimplificacionCUV BIT NULL,
	FechaFinValidacion DATETIME NULL,
	Rechazado BIT NOT NULL,
	Visualizado BIT NOT NULL,
	ErrorValidacion VARCHAR(100) NULL,
	ErrorProceso VARCHAR(100) NULL,
	ErrorLog VARCHAR(2000) NULL
);
GO
ALTER TABLE GPR.LogGPRValidacion 
ADD CONSTRAINT DF_LogGPRValidacion_Rechazado
DEFAULT 0 FOR Rechazado;
GO
ALTER TABLE GPR.LogGPRValidacion 
ADD CONSTRAINT DF_LogGPRValidacion_Visualizado
DEFAULT 0 FOR Visualizado;
GO
/*end*/

USE BelcorpDominicana
GO
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'LogGPRValidacion' AND TABLE_SCHEMA = 'GPR')
BEGIN
    DROP TABLE GPR.LogGPRValidacion;
END
GO
CREATE TABLE GPR.LogGPRValidacion(
	LogGPRValidacionId BIGINT IDENTITY(1,1) PRIMARY KEY,
	ProcesoValidacionPedidoRechazadoId BIGINT NOT NULL,
	IdPedidoRechazado BIGINT NOT NULL,
	DescripcionRechazo VARCHAR(200) NOT NULL,
	ConsultoraID BIGINT NULL,
	CodigoUsuario VARCHAR(20) NULL,
	NombreCompleto VARCHAR(80) NULL,
	Email VARCHAR(50) NULL,
	ZonaNuevoProl BIT NOT NULL,
	PedidoID INT NULL,
	SubTotal MONEY NULL,
	Descuento MONEY NULL,
	EstadoSimplificacionCUV BIT NULL,
	FechaFinValidacion DATETIME NULL,
	Rechazado BIT NOT NULL,
	Visualizado BIT NOT NULL,
	ErrorValidacion VARCHAR(100) NULL,
	ErrorProceso VARCHAR(100) NULL,
	ErrorLog VARCHAR(2000) NULL
);
GO
ALTER TABLE GPR.LogGPRValidacion 
ADD CONSTRAINT DF_LogGPRValidacion_Rechazado
DEFAULT 0 FOR Rechazado;
GO
ALTER TABLE GPR.LogGPRValidacion 
ADD CONSTRAINT DF_LogGPRValidacion_Visualizado
DEFAULT 0 FOR Visualizado;
GO
/*end*/

USE BelcorpEcuador
GO
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'LogGPRValidacion' AND TABLE_SCHEMA = 'GPR')
BEGIN
    DROP TABLE GPR.LogGPRValidacion;
END
GO
CREATE TABLE GPR.LogGPRValidacion(
	LogGPRValidacionId BIGINT IDENTITY(1,1) PRIMARY KEY,
	ProcesoValidacionPedidoRechazadoId BIGINT NOT NULL,
	IdPedidoRechazado BIGINT NOT NULL,
	DescripcionRechazo VARCHAR(200) NOT NULL,
	ConsultoraID BIGINT NULL,
	CodigoUsuario VARCHAR(20) NULL,
	NombreCompleto VARCHAR(80) NULL,
	Email VARCHAR(50) NULL,
	ZonaNuevoProl BIT NOT NULL,
	PedidoID INT NULL,
	SubTotal MONEY NULL,
	Descuento MONEY NULL,
	EstadoSimplificacionCUV BIT NULL,
	FechaFinValidacion DATETIME NULL,
	Rechazado BIT NOT NULL,
	Visualizado BIT NOT NULL,
	ErrorValidacion VARCHAR(100) NULL,
	ErrorProceso VARCHAR(100) NULL,
	ErrorLog VARCHAR(2000) NULL
);
GO
ALTER TABLE GPR.LogGPRValidacion 
ADD CONSTRAINT DF_LogGPRValidacion_Rechazado
DEFAULT 0 FOR Rechazado;
GO
ALTER TABLE GPR.LogGPRValidacion 
ADD CONSTRAINT DF_LogGPRValidacion_Visualizado
DEFAULT 0 FOR Visualizado;
GO
/*end*/

USE BelcorpGuatemala
GO
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'LogGPRValidacion' AND TABLE_SCHEMA = 'GPR')
BEGIN
    DROP TABLE GPR.LogGPRValidacion;
END
GO
CREATE TABLE GPR.LogGPRValidacion(
	LogGPRValidacionId BIGINT IDENTITY(1,1) PRIMARY KEY,
	ProcesoValidacionPedidoRechazadoId BIGINT NOT NULL,
	IdPedidoRechazado BIGINT NOT NULL,
	DescripcionRechazo VARCHAR(200) NOT NULL,
	ConsultoraID BIGINT NULL,
	CodigoUsuario VARCHAR(20) NULL,
	NombreCompleto VARCHAR(80) NULL,
	Email VARCHAR(50) NULL,
	ZonaNuevoProl BIT NOT NULL,
	PedidoID INT NULL,
	SubTotal MONEY NULL,
	Descuento MONEY NULL,
	EstadoSimplificacionCUV BIT NULL,
	FechaFinValidacion DATETIME NULL,
	Rechazado BIT NOT NULL,
	Visualizado BIT NOT NULL,
	ErrorValidacion VARCHAR(100) NULL,
	ErrorProceso VARCHAR(100) NULL,
	ErrorLog VARCHAR(2000) NULL
);
GO
ALTER TABLE GPR.LogGPRValidacion 
ADD CONSTRAINT DF_LogGPRValidacion_Rechazado
DEFAULT 0 FOR Rechazado;
GO
ALTER TABLE GPR.LogGPRValidacion 
ADD CONSTRAINT DF_LogGPRValidacion_Visualizado
DEFAULT 0 FOR Visualizado;
GO
/*end*/

USE BelcorpPanama
GO
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'LogGPRValidacion' AND TABLE_SCHEMA = 'GPR')
BEGIN
    DROP TABLE GPR.LogGPRValidacion;
END
GO
CREATE TABLE GPR.LogGPRValidacion(
	LogGPRValidacionId BIGINT IDENTITY(1,1) PRIMARY KEY,
	ProcesoValidacionPedidoRechazadoId BIGINT NOT NULL,
	IdPedidoRechazado BIGINT NOT NULL,
	DescripcionRechazo VARCHAR(200) NOT NULL,
	ConsultoraID BIGINT NULL,
	CodigoUsuario VARCHAR(20) NULL,
	NombreCompleto VARCHAR(80) NULL,
	Email VARCHAR(50) NULL,
	ZonaNuevoProl BIT NOT NULL,
	PedidoID INT NULL,
	SubTotal MONEY NULL,
	Descuento MONEY NULL,
	EstadoSimplificacionCUV BIT NULL,
	FechaFinValidacion DATETIME NULL,
	Rechazado BIT NOT NULL,
	Visualizado BIT NOT NULL,
	ErrorValidacion VARCHAR(100) NULL,
	ErrorProceso VARCHAR(100) NULL,
	ErrorLog VARCHAR(2000) NULL
);
GO
ALTER TABLE GPR.LogGPRValidacion 
ADD CONSTRAINT DF_LogGPRValidacion_Rechazado
DEFAULT 0 FOR Rechazado;
GO
ALTER TABLE GPR.LogGPRValidacion 
ADD CONSTRAINT DF_LogGPRValidacion_Visualizado
DEFAULT 0 FOR Visualizado;
GO
/*end*/

USE BelcorpPuertoRico
GO
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'LogGPRValidacion' AND TABLE_SCHEMA = 'GPR')
BEGIN
    DROP TABLE GPR.LogGPRValidacion;
END
GO
CREATE TABLE GPR.LogGPRValidacion(
	LogGPRValidacionId BIGINT IDENTITY(1,1) PRIMARY KEY,
	ProcesoValidacionPedidoRechazadoId BIGINT NOT NULL,
	IdPedidoRechazado BIGINT NOT NULL,
	DescripcionRechazo VARCHAR(200) NOT NULL,
	ConsultoraID BIGINT NULL,
	CodigoUsuario VARCHAR(20) NULL,
	NombreCompleto VARCHAR(80) NULL,
	Email VARCHAR(50) NULL,
	ZonaNuevoProl BIT NOT NULL,
	PedidoID INT NULL,
	SubTotal MONEY NULL,
	Descuento MONEY NULL,
	EstadoSimplificacionCUV BIT NULL,
	FechaFinValidacion DATETIME NULL,
	Rechazado BIT NOT NULL,
	Visualizado BIT NOT NULL,
	ErrorValidacion VARCHAR(100) NULL,
	ErrorProceso VARCHAR(100) NULL,
	ErrorLog VARCHAR(2000) NULL
);
GO
ALTER TABLE GPR.LogGPRValidacion 
ADD CONSTRAINT DF_LogGPRValidacion_Rechazado
DEFAULT 0 FOR Rechazado;
GO
ALTER TABLE GPR.LogGPRValidacion 
ADD CONSTRAINT DF_LogGPRValidacion_Visualizado
DEFAULT 0 FOR Visualizado;
GO
/*end*/

USE BelcorpSalvador
GO
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'LogGPRValidacion' AND TABLE_SCHEMA = 'GPR')
BEGIN
    DROP TABLE GPR.LogGPRValidacion;
END
GO
CREATE TABLE GPR.LogGPRValidacion(
	LogGPRValidacionId BIGINT IDENTITY(1,1) PRIMARY KEY,
	ProcesoValidacionPedidoRechazadoId BIGINT NOT NULL,
	IdPedidoRechazado BIGINT NOT NULL,
	DescripcionRechazo VARCHAR(200) NOT NULL,
	ConsultoraID BIGINT NULL,
	CodigoUsuario VARCHAR(20) NULL,
	NombreCompleto VARCHAR(80) NULL,
	Email VARCHAR(50) NULL,
	ZonaNuevoProl BIT NOT NULL,
	PedidoID INT NULL,
	SubTotal MONEY NULL,
	Descuento MONEY NULL,
	EstadoSimplificacionCUV BIT NULL,
	FechaFinValidacion DATETIME NULL,
	Rechazado BIT NOT NULL,
	Visualizado BIT NOT NULL,
	ErrorValidacion VARCHAR(100) NULL,
	ErrorProceso VARCHAR(100) NULL,
	ErrorLog VARCHAR(2000) NULL
);
GO
ALTER TABLE GPR.LogGPRValidacion 
ADD CONSTRAINT DF_LogGPRValidacion_Rechazado
DEFAULT 0 FOR Rechazado;
GO
ALTER TABLE GPR.LogGPRValidacion 
ADD CONSTRAINT DF_LogGPRValidacion_Visualizado
DEFAULT 0 FOR Visualizado;
GO
/*end*/

USE BelcorpVenezuela
GO
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'LogGPRValidacion' AND TABLE_SCHEMA = 'GPR')
BEGIN
    DROP TABLE GPR.LogGPRValidacion;
END
GO
CREATE TABLE GPR.LogGPRValidacion(
	LogGPRValidacionId BIGINT IDENTITY(1,1) PRIMARY KEY,
	ProcesoValidacionPedidoRechazadoId BIGINT NOT NULL,
	IdPedidoRechazado BIGINT NOT NULL,
	DescripcionRechazo VARCHAR(200) NOT NULL,
	ConsultoraID BIGINT NULL,
	CodigoUsuario VARCHAR(20) NULL,
	NombreCompleto VARCHAR(80) NULL,
	Email VARCHAR(50) NULL,
	ZonaNuevoProl BIT NOT NULL,
	PedidoID INT NULL,
	SubTotal MONEY NULL,
	Descuento MONEY NULL,
	EstadoSimplificacionCUV BIT NULL,
	FechaFinValidacion DATETIME NULL,
	Rechazado BIT NOT NULL,
	Visualizado BIT NOT NULL,
	ErrorValidacion VARCHAR(100) NULL,
	ErrorProceso VARCHAR(100) NULL,
	ErrorLog VARCHAR(2000) NULL
);
GO
ALTER TABLE GPR.LogGPRValidacion 
ADD CONSTRAINT DF_LogGPRValidacion_Rechazado
DEFAULT 0 FOR Rechazado;
GO
ALTER TABLE GPR.LogGPRValidacion 
ADD CONSTRAINT DF_LogGPRValidacion_Visualizado
DEFAULT 0 FOR Visualizado;
GO