USE BelcorpBolivia
GO
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'MotivoRechazo' AND TABLE_SCHEMA = 'GPR')
BEGIN
    DROP TABLE GPR.MotivoRechazo;
END
GO
CREATE TABLE GPR.MotivoRechazo
(
	IdMotivoRechazo INT IDENTITY(1,1) PRIMARY KEY,
	Codigo VARCHAR(6) NULL,
	Descripcion VARCHAR(100) NULL,
	RequiereGestion BIT NOT NULL,
	CodigoSomosBelcorp VARCHAR(8) NULL,
);
GO
/*end*/

USE BelcorpChile
GO
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'MotivoRechazo' AND TABLE_SCHEMA = 'GPR')
BEGIN
    DROP TABLE GPR.MotivoRechazo;
END
GO
CREATE TABLE GPR.MotivoRechazo
(
	IdMotivoRechazo INT IDENTITY(1,1) PRIMARY KEY,
	Codigo VARCHAR(6) NULL,
	Descripcion VARCHAR(100) NULL,
	RequiereGestion BIT NOT NULL,
	CodigoSomosBelcorp VARCHAR(8) NULL,
);
GO
/*end*/

USE BelcorpCostaRica
GO
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'MotivoRechazo' AND TABLE_SCHEMA = 'GPR')
BEGIN
    DROP TABLE GPR.MotivoRechazo;
END
GO
CREATE TABLE GPR.MotivoRechazo
(
	IdMotivoRechazo INT IDENTITY(1,1) PRIMARY KEY,
	Codigo VARCHAR(6) NULL,
	Descripcion VARCHAR(100) NULL,
	RequiereGestion BIT NOT NULL,
	CodigoSomosBelcorp VARCHAR(8) NULL,
);
GO
/*end*/

USE BelcorpDominicana
GO
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'MotivoRechazo' AND TABLE_SCHEMA = 'GPR')
BEGIN
    DROP TABLE GPR.MotivoRechazo;
END
GO
CREATE TABLE GPR.MotivoRechazo
(
	IdMotivoRechazo INT IDENTITY(1,1) PRIMARY KEY,
	Codigo VARCHAR(6) NULL,
	Descripcion VARCHAR(100) NULL,
	RequiereGestion BIT NOT NULL,
	CodigoSomosBelcorp VARCHAR(8) NULL,
);
GO
/*end*/

USE BelcorpEcuador
GO
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'MotivoRechazo' AND TABLE_SCHEMA = 'GPR')
BEGIN
    DROP TABLE GPR.MotivoRechazo;
END
GO
CREATE TABLE GPR.MotivoRechazo
(
	IdMotivoRechazo INT IDENTITY(1,1) PRIMARY KEY,
	Codigo VARCHAR(6) NULL,
	Descripcion VARCHAR(100) NULL,
	RequiereGestion BIT NOT NULL,
	CodigoSomosBelcorp VARCHAR(8) NULL,
);
GO
/*end*/

USE BelcorpGuatemala
GO
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'MotivoRechazo' AND TABLE_SCHEMA = 'GPR')
BEGIN
    DROP TABLE GPR.MotivoRechazo;
END
GO
CREATE TABLE GPR.MotivoRechazo
(
	IdMotivoRechazo INT IDENTITY(1,1) PRIMARY KEY,
	Codigo VARCHAR(6) NULL,
	Descripcion VARCHAR(100) NULL,
	RequiereGestion BIT NOT NULL,
	CodigoSomosBelcorp VARCHAR(8) NULL,
);
GO
/*end*/

USE BelcorpPanama
GO
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'MotivoRechazo' AND TABLE_SCHEMA = 'GPR')
BEGIN
    DROP TABLE GPR.MotivoRechazo;
END
GO
CREATE TABLE GPR.MotivoRechazo
(
	IdMotivoRechazo INT IDENTITY(1,1) PRIMARY KEY,
	Codigo VARCHAR(6) NULL,
	Descripcion VARCHAR(100) NULL,
	RequiereGestion BIT NOT NULL,
	CodigoSomosBelcorp VARCHAR(8) NULL,
);
GO
/*end*/

USE BelcorpPuertoRico
GO
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'MotivoRechazo' AND TABLE_SCHEMA = 'GPR')
BEGIN
    DROP TABLE GPR.MotivoRechazo;
END
GO
CREATE TABLE GPR.MotivoRechazo
(
	IdMotivoRechazo INT IDENTITY(1,1) PRIMARY KEY,
	Codigo VARCHAR(6) NULL,
	Descripcion VARCHAR(100) NULL,
	RequiereGestion BIT NOT NULL,
	CodigoSomosBelcorp VARCHAR(8) NULL,
);
GO
/*end*/

USE BelcorpSalvador
GO
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'MotivoRechazo' AND TABLE_SCHEMA = 'GPR')
BEGIN
    DROP TABLE GPR.MotivoRechazo;
END
GO
CREATE TABLE GPR.MotivoRechazo
(
	IdMotivoRechazo INT IDENTITY(1,1) PRIMARY KEY,
	Codigo VARCHAR(6) NULL,
	Descripcion VARCHAR(100) NULL,
	RequiereGestion BIT NOT NULL,
	CodigoSomosBelcorp VARCHAR(8) NULL,
);
GO
/*end*/

USE BelcorpVenezuela
GO
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'MotivoRechazo' AND TABLE_SCHEMA = 'GPR')
BEGIN
    DROP TABLE GPR.MotivoRechazo;
END
GO
CREATE TABLE GPR.MotivoRechazo
(
	IdMotivoRechazo INT IDENTITY(1,1) PRIMARY KEY,
	Codigo VARCHAR(6) NULL,
	Descripcion VARCHAR(100) NULL,
	RequiereGestion BIT NOT NULL,
	CodigoSomosBelcorp VARCHAR(8) NULL,
);
GO