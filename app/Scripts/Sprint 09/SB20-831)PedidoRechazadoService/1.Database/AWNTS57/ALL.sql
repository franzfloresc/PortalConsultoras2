USE BelcorpBolivia
GO
IF NOT EXISTS(SELECT 1 FROM sys.schemas WHERE name = 'GPR')
BEGIN
	EXEC sp_executesql N'CREATE SCHEMA GPR';
END
GO
---------------------------------------------------------------------------------------------------------------
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'ProcesoPedidoRechazado' AND TABLE_SCHEMA = 'GPR')
BEGIN
    DROP TABLE GPR.ProcesoPedidoRechazado;
END
GO
CREATE TABLE GPR.ProcesoPedidoRechazado
(
	IdProcesoPedidoRechazado BIGINT IDENTITY(1,1) PRIMARY KEY,
	Fecha DATETIME NOT NULL,
	Estado VARCHAR(5) NOT NULL,
	Mensaje varchar(1500) NOT NULL,
	Procesado bit NOT NULL
);
GO
ALTER TABLE GPR.ProcesoPedidoRechazado 
ADD CONSTRAINT DF_ProcesoPedidoRechazado_Procesado
DEFAULT 0 FOR Procesado;
GO
---------------------------------------------------------------------------------------------------------------
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'PedidoRechazado' AND TABLE_SCHEMA = 'GPR')
BEGIN
    DROP TABLE GPR.PedidoRechazado;
END
GO
CREATE TABLE GPR.PedidoRechazado
(
	IdPedidoRechazado BIGINT IDENTITY(1,1) PRIMARY KEY,
	IdProcesoPedidoRechazado BIGINT NOT NULL,
	Campania VARCHAR(6) NULL,
	CodigoConsultora VARCHAR(15) NULL,
	MotivoRechazo VARCHAR(6) NULL,
	Valor VARCHAR(10) NULL,
	CodigoRechazoSomosBelcorp VARCHAR(8) NULL,
	Procesado bit NOT NULL,
	Rechazado bit NOT NULL
);
GO
ALTER TABLE GPR.PedidoRechazado 
ADD CONSTRAINT DF_PedidoRechazado_Procesado
DEFAULT 0 FOR Procesado;
GO
ALTER TABLE GPR.PedidoRechazado 
ADD CONSTRAINT DF_PedidoRechazado_Rechazado
DEFAULT 0 FOR Rechazado;
GO
---------------------------------------------------------------------------------------------------------------
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'InsertarPedidoRechazadoXML' AND SPECIFIC_SCHEMA = 'GPR' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE GPR.InsertarPedidoRechazadoXML
END
GO
CREATE PROCEDURE GPR.InsertarPedidoRechazadoXML
	@Estado VARCHAR(5),
	@Mensaje varchar(1500),
	@PedidoRechazoXml xml
AS
BEGIN
	INSERT INTO GPR.ProcesoPedidoRechazado(Fecha, Estado, Mensaje)
	VALUES(GETDATE(),@Estado,@Mensaje);
	DECLARE @IdProcesoPedidoRechazado BIGINT = SCOPE_IDENTITY();

	INSERT INTO GPR.PedidoRechazado(IdProcesoPedidoRechazado,Campania,CodigoConsultora,MotivoRechazo,Valor)
	SELECT
		@IdProcesoPedidoRechazado,
		p.value('@Campania','VARCHAR(6)'), 
		p.value('@CodigoConsultora','VARCHAR(15)'),
		p.value('@MotivoRechazo','VARCHAR(6)'),
		p.value('@Valor','VARCHAR(10)')
	FROM @PedidoRechazoXml.nodes('/ROOT/PedidoRechazado')n(p);
END
GO
/*end*/

USE BelcorpChile
GO
IF NOT EXISTS(SELECT 1 FROM sys.schemas WHERE name = 'GPR')
BEGIN
	EXEC sp_executesql N'CREATE SCHEMA GPR';
END
GO
---------------------------------------------------------------------------------------------------------------
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'ProcesoPedidoRechazado' AND TABLE_SCHEMA = 'GPR')
BEGIN
    DROP TABLE GPR.ProcesoPedidoRechazado;
END
GO
CREATE TABLE GPR.ProcesoPedidoRechazado
(
	IdProcesoPedidoRechazado BIGINT IDENTITY(1,1) PRIMARY KEY,
	Fecha DATETIME NOT NULL,
	Estado VARCHAR(5) NOT NULL,
	Mensaje varchar(1500) NOT NULL,
	Procesado bit NOT NULL
);
GO
ALTER TABLE GPR.ProcesoPedidoRechazado 
ADD CONSTRAINT DF_ProcesoPedidoRechazado_Procesado
DEFAULT 0 FOR Procesado;
GO
---------------------------------------------------------------------------------------------------------------
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'PedidoRechazado' AND TABLE_SCHEMA = 'GPR')
BEGIN
    DROP TABLE GPR.PedidoRechazado;
END
GO
CREATE TABLE GPR.PedidoRechazado
(
	IdPedidoRechazado BIGINT IDENTITY(1,1) PRIMARY KEY,
	IdProcesoPedidoRechazado BIGINT NOT NULL,
	Campania VARCHAR(6) NULL,
	CodigoConsultora VARCHAR(15) NULL,
	MotivoRechazo VARCHAR(6) NULL,
	Valor VARCHAR(10) NULL,
	CodigoRechazoSomosBelcorp VARCHAR(8) NULL,
	Procesado bit NOT NULL,
	Rechazado bit NOT NULL
);
GO
ALTER TABLE GPR.PedidoRechazado 
ADD CONSTRAINT DF_PedidoRechazado_Procesado
DEFAULT 0 FOR Procesado;
GO
ALTER TABLE GPR.PedidoRechazado 
ADD CONSTRAINT DF_PedidoRechazado_Rechazado
DEFAULT 0 FOR Rechazado;
GO
---------------------------------------------------------------------------------------------------------------
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'InsertarPedidoRechazadoXML' AND SPECIFIC_SCHEMA = 'GPR' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE GPR.InsertarPedidoRechazadoXML
END
GO
CREATE PROCEDURE GPR.InsertarPedidoRechazadoXML
	@Estado VARCHAR(5),
	@Mensaje varchar(1500),
	@PedidoRechazoXml xml
AS
BEGIN
	INSERT INTO GPR.ProcesoPedidoRechazado(Fecha, Estado, Mensaje)
	VALUES(GETDATE(),@Estado,@Mensaje);
	DECLARE @IdProcesoPedidoRechazado BIGINT = SCOPE_IDENTITY();

	INSERT INTO GPR.PedidoRechazado(IdProcesoPedidoRechazado,Campania,CodigoConsultora,MotivoRechazo,Valor)
	SELECT
		@IdProcesoPedidoRechazado,
		p.value('@Campania','VARCHAR(6)'), 
		p.value('@CodigoConsultora','VARCHAR(15)'),
		p.value('@MotivoRechazo','VARCHAR(6)'),
		p.value('@Valor','VARCHAR(10)')
	FROM @PedidoRechazoXml.nodes('/ROOT/PedidoRechazado')n(p);
END
GO
/*end*/

USE BelcorpCostaRica
GO
IF NOT EXISTS(SELECT 1 FROM sys.schemas WHERE name = 'GPR')
BEGIN
	EXEC sp_executesql N'CREATE SCHEMA GPR';
END
GO
---------------------------------------------------------------------------------------------------------------
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'ProcesoPedidoRechazado' AND TABLE_SCHEMA = 'GPR')
BEGIN
    DROP TABLE GPR.ProcesoPedidoRechazado;
END
GO
CREATE TABLE GPR.ProcesoPedidoRechazado
(
	IdProcesoPedidoRechazado BIGINT IDENTITY(1,1) PRIMARY KEY,
	Fecha DATETIME NOT NULL,
	Estado VARCHAR(5) NOT NULL,
	Mensaje varchar(1500) NOT NULL,
	Procesado bit NOT NULL
);
GO
ALTER TABLE GPR.ProcesoPedidoRechazado 
ADD CONSTRAINT DF_ProcesoPedidoRechazado_Procesado
DEFAULT 0 FOR Procesado;
GO
---------------------------------------------------------------------------------------------------------------
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'PedidoRechazado' AND TABLE_SCHEMA = 'GPR')
BEGIN
    DROP TABLE GPR.PedidoRechazado;
END
GO
CREATE TABLE GPR.PedidoRechazado
(
	IdPedidoRechazado BIGINT IDENTITY(1,1) PRIMARY KEY,
	IdProcesoPedidoRechazado BIGINT NOT NULL,
	Campania VARCHAR(6) NULL,
	CodigoConsultora VARCHAR(15) NULL,
	MotivoRechazo VARCHAR(6) NULL,
	Valor VARCHAR(10) NULL,
	CodigoRechazoSomosBelcorp VARCHAR(8) NULL,
	Procesado bit NOT NULL,
	Rechazado bit NOT NULL
);
GO
ALTER TABLE GPR.PedidoRechazado 
ADD CONSTRAINT DF_PedidoRechazado_Procesado
DEFAULT 0 FOR Procesado;
GO
ALTER TABLE GPR.PedidoRechazado 
ADD CONSTRAINT DF_PedidoRechazado_Rechazado
DEFAULT 0 FOR Rechazado;
GO
---------------------------------------------------------------------------------------------------------------
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'InsertarPedidoRechazadoXML' AND SPECIFIC_SCHEMA = 'GPR' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE GPR.InsertarPedidoRechazadoXML
END
GO
CREATE PROCEDURE GPR.InsertarPedidoRechazadoXML
	@Estado VARCHAR(5),
	@Mensaje varchar(1500),
	@PedidoRechazoXml xml
AS
BEGIN
	INSERT INTO GPR.ProcesoPedidoRechazado(Fecha, Estado, Mensaje)
	VALUES(GETDATE(),@Estado,@Mensaje);
	DECLARE @IdProcesoPedidoRechazado BIGINT = SCOPE_IDENTITY();

	INSERT INTO GPR.PedidoRechazado(IdProcesoPedidoRechazado,Campania,CodigoConsultora,MotivoRechazo,Valor)
	SELECT
		@IdProcesoPedidoRechazado,
		p.value('@Campania','VARCHAR(6)'), 
		p.value('@CodigoConsultora','VARCHAR(15)'),
		p.value('@MotivoRechazo','VARCHAR(6)'),
		p.value('@Valor','VARCHAR(10)')
	FROM @PedidoRechazoXml.nodes('/ROOT/PedidoRechazado')n(p);
END
GO
/*end*/

USE BelcorpDominicana
GO
IF NOT EXISTS(SELECT 1 FROM sys.schemas WHERE name = 'GPR')
BEGIN
	EXEC sp_executesql N'CREATE SCHEMA GPR';
END
GO
---------------------------------------------------------------------------------------------------------------
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'ProcesoPedidoRechazado' AND TABLE_SCHEMA = 'GPR')
BEGIN
    DROP TABLE GPR.ProcesoPedidoRechazado;
END
GO
CREATE TABLE GPR.ProcesoPedidoRechazado
(
	IdProcesoPedidoRechazado BIGINT IDENTITY(1,1) PRIMARY KEY,
	Fecha DATETIME NOT NULL,
	Estado VARCHAR(5) NOT NULL,
	Mensaje varchar(1500) NOT NULL,
	Procesado bit NOT NULL
);
GO
ALTER TABLE GPR.ProcesoPedidoRechazado 
ADD CONSTRAINT DF_ProcesoPedidoRechazado_Procesado
DEFAULT 0 FOR Procesado;
GO
---------------------------------------------------------------------------------------------------------------
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'PedidoRechazado' AND TABLE_SCHEMA = 'GPR')
BEGIN
    DROP TABLE GPR.PedidoRechazado;
END
GO
CREATE TABLE GPR.PedidoRechazado
(
	IdPedidoRechazado BIGINT IDENTITY(1,1) PRIMARY KEY,
	IdProcesoPedidoRechazado BIGINT NOT NULL,
	Campania VARCHAR(6) NULL,
	CodigoConsultora VARCHAR(15) NULL,
	MotivoRechazo VARCHAR(6) NULL,
	Valor VARCHAR(10) NULL,
	CodigoRechazoSomosBelcorp VARCHAR(8) NULL,
	Procesado bit NOT NULL,
	Rechazado bit NOT NULL
);
GO
ALTER TABLE GPR.PedidoRechazado 
ADD CONSTRAINT DF_PedidoRechazado_Procesado
DEFAULT 0 FOR Procesado;
GO
ALTER TABLE GPR.PedidoRechazado 
ADD CONSTRAINT DF_PedidoRechazado_Rechazado
DEFAULT 0 FOR Rechazado;
GO
---------------------------------------------------------------------------------------------------------------
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'InsertarPedidoRechazadoXML' AND SPECIFIC_SCHEMA = 'GPR' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE GPR.InsertarPedidoRechazadoXML
END
GO
CREATE PROCEDURE GPR.InsertarPedidoRechazadoXML
	@Estado VARCHAR(5),
	@Mensaje varchar(1500),
	@PedidoRechazoXml xml
AS
BEGIN
	INSERT INTO GPR.ProcesoPedidoRechazado(Fecha, Estado, Mensaje)
	VALUES(GETDATE(),@Estado,@Mensaje);
	DECLARE @IdProcesoPedidoRechazado BIGINT = SCOPE_IDENTITY();

	INSERT INTO GPR.PedidoRechazado(IdProcesoPedidoRechazado,Campania,CodigoConsultora,MotivoRechazo,Valor)
	SELECT
		@IdProcesoPedidoRechazado,
		p.value('@Campania','VARCHAR(6)'), 
		p.value('@CodigoConsultora','VARCHAR(15)'),
		p.value('@MotivoRechazo','VARCHAR(6)'),
		p.value('@Valor','VARCHAR(10)')
	FROM @PedidoRechazoXml.nodes('/ROOT/PedidoRechazado')n(p);
END
GO
/*end*/

USE BelcorpEcuador
GO
IF NOT EXISTS(SELECT 1 FROM sys.schemas WHERE name = 'GPR')
BEGIN
	EXEC sp_executesql N'CREATE SCHEMA GPR';
END
GO
---------------------------------------------------------------------------------------------------------------
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'ProcesoPedidoRechazado' AND TABLE_SCHEMA = 'GPR')
BEGIN
    DROP TABLE GPR.ProcesoPedidoRechazado;
END
GO
CREATE TABLE GPR.ProcesoPedidoRechazado
(
	IdProcesoPedidoRechazado BIGINT IDENTITY(1,1) PRIMARY KEY,
	Fecha DATETIME NOT NULL,
	Estado VARCHAR(5) NOT NULL,
	Mensaje varchar(1500) NOT NULL,
	Procesado bit NOT NULL
);
GO
ALTER TABLE GPR.ProcesoPedidoRechazado 
ADD CONSTRAINT DF_ProcesoPedidoRechazado_Procesado
DEFAULT 0 FOR Procesado;
GO
---------------------------------------------------------------------------------------------------------------
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'PedidoRechazado' AND TABLE_SCHEMA = 'GPR')
BEGIN
    DROP TABLE GPR.PedidoRechazado;
END
GO
CREATE TABLE GPR.PedidoRechazado
(
	IdPedidoRechazado BIGINT IDENTITY(1,1) PRIMARY KEY,
	IdProcesoPedidoRechazado BIGINT NOT NULL,
	Campania VARCHAR(6) NULL,
	CodigoConsultora VARCHAR(15) NULL,
	MotivoRechazo VARCHAR(6) NULL,
	Valor VARCHAR(10) NULL,
	CodigoRechazoSomosBelcorp VARCHAR(8) NULL,
	Procesado bit NOT NULL,
	Rechazado bit NOT NULL
);
GO
ALTER TABLE GPR.PedidoRechazado 
ADD CONSTRAINT DF_PedidoRechazado_Procesado
DEFAULT 0 FOR Procesado;
GO
ALTER TABLE GPR.PedidoRechazado 
ADD CONSTRAINT DF_PedidoRechazado_Rechazado
DEFAULT 0 FOR Rechazado;
GO
---------------------------------------------------------------------------------------------------------------
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'InsertarPedidoRechazadoXML' AND SPECIFIC_SCHEMA = 'GPR' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE GPR.InsertarPedidoRechazadoXML
END
GO
CREATE PROCEDURE GPR.InsertarPedidoRechazadoXML
	@Estado VARCHAR(5),
	@Mensaje varchar(1500),
	@PedidoRechazoXml xml
AS
BEGIN
	INSERT INTO GPR.ProcesoPedidoRechazado(Fecha, Estado, Mensaje)
	VALUES(GETDATE(),@Estado,@Mensaje);
	DECLARE @IdProcesoPedidoRechazado BIGINT = SCOPE_IDENTITY();

	INSERT INTO GPR.PedidoRechazado(IdProcesoPedidoRechazado,Campania,CodigoConsultora,MotivoRechazo,Valor)
	SELECT
		@IdProcesoPedidoRechazado,
		p.value('@Campania','VARCHAR(6)'), 
		p.value('@CodigoConsultora','VARCHAR(15)'),
		p.value('@MotivoRechazo','VARCHAR(6)'),
		p.value('@Valor','VARCHAR(10)')
	FROM @PedidoRechazoXml.nodes('/ROOT/PedidoRechazado')n(p);
END
GO
/*end*/

USE BelcorpGuatemala
GO
IF NOT EXISTS(SELECT 1 FROM sys.schemas WHERE name = 'GPR')
BEGIN
	EXEC sp_executesql N'CREATE SCHEMA GPR';
END
GO
---------------------------------------------------------------------------------------------------------------
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'ProcesoPedidoRechazado' AND TABLE_SCHEMA = 'GPR')
BEGIN
    DROP TABLE GPR.ProcesoPedidoRechazado;
END
GO
CREATE TABLE GPR.ProcesoPedidoRechazado
(
	IdProcesoPedidoRechazado BIGINT IDENTITY(1,1) PRIMARY KEY,
	Fecha DATETIME NOT NULL,
	Estado VARCHAR(5) NOT NULL,
	Mensaje varchar(1500) NOT NULL,
	Procesado bit NOT NULL
);
GO
ALTER TABLE GPR.ProcesoPedidoRechazado 
ADD CONSTRAINT DF_ProcesoPedidoRechazado_Procesado
DEFAULT 0 FOR Procesado;
GO
---------------------------------------------------------------------------------------------------------------
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'PedidoRechazado' AND TABLE_SCHEMA = 'GPR')
BEGIN
    DROP TABLE GPR.PedidoRechazado;
END
GO
CREATE TABLE GPR.PedidoRechazado
(
	IdPedidoRechazado BIGINT IDENTITY(1,1) PRIMARY KEY,
	IdProcesoPedidoRechazado BIGINT NOT NULL,
	Campania VARCHAR(6) NULL,
	CodigoConsultora VARCHAR(15) NULL,
	MotivoRechazo VARCHAR(6) NULL,
	Valor VARCHAR(10) NULL,
	CodigoRechazoSomosBelcorp VARCHAR(8) NULL,
	Procesado bit NOT NULL,
	Rechazado bit NOT NULL
);
GO
ALTER TABLE GPR.PedidoRechazado 
ADD CONSTRAINT DF_PedidoRechazado_Procesado
DEFAULT 0 FOR Procesado;
GO
ALTER TABLE GPR.PedidoRechazado 
ADD CONSTRAINT DF_PedidoRechazado_Rechazado
DEFAULT 0 FOR Rechazado;
GO
---------------------------------------------------------------------------------------------------------------
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'InsertarPedidoRechazadoXML' AND SPECIFIC_SCHEMA = 'GPR' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE GPR.InsertarPedidoRechazadoXML
END
GO
CREATE PROCEDURE GPR.InsertarPedidoRechazadoXML
	@Estado VARCHAR(5),
	@Mensaje varchar(1500),
	@PedidoRechazoXml xml
AS
BEGIN
	INSERT INTO GPR.ProcesoPedidoRechazado(Fecha, Estado, Mensaje)
	VALUES(GETDATE(),@Estado,@Mensaje);
	DECLARE @IdProcesoPedidoRechazado BIGINT = SCOPE_IDENTITY();

	INSERT INTO GPR.PedidoRechazado(IdProcesoPedidoRechazado,Campania,CodigoConsultora,MotivoRechazo,Valor)
	SELECT
		@IdProcesoPedidoRechazado,
		p.value('@Campania','VARCHAR(6)'), 
		p.value('@CodigoConsultora','VARCHAR(15)'),
		p.value('@MotivoRechazo','VARCHAR(6)'),
		p.value('@Valor','VARCHAR(10)')
	FROM @PedidoRechazoXml.nodes('/ROOT/PedidoRechazado')n(p);
END
GO
/*end*/

USE BelcorpPanama
GO
IF NOT EXISTS(SELECT 1 FROM sys.schemas WHERE name = 'GPR')
BEGIN
	EXEC sp_executesql N'CREATE SCHEMA GPR';
END
GO
---------------------------------------------------------------------------------------------------------------
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'ProcesoPedidoRechazado' AND TABLE_SCHEMA = 'GPR')
BEGIN
    DROP TABLE GPR.ProcesoPedidoRechazado;
END
GO
CREATE TABLE GPR.ProcesoPedidoRechazado
(
	IdProcesoPedidoRechazado BIGINT IDENTITY(1,1) PRIMARY KEY,
	Fecha DATETIME NOT NULL,
	Estado VARCHAR(5) NOT NULL,
	Mensaje varchar(1500) NOT NULL,
	Procesado bit NOT NULL
);
GO
ALTER TABLE GPR.ProcesoPedidoRechazado 
ADD CONSTRAINT DF_ProcesoPedidoRechazado_Procesado
DEFAULT 0 FOR Procesado;
GO
---------------------------------------------------------------------------------------------------------------
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'PedidoRechazado' AND TABLE_SCHEMA = 'GPR')
BEGIN
    DROP TABLE GPR.PedidoRechazado;
END
GO
CREATE TABLE GPR.PedidoRechazado
(
	IdPedidoRechazado BIGINT IDENTITY(1,1) PRIMARY KEY,
	IdProcesoPedidoRechazado BIGINT NOT NULL,
	Campania VARCHAR(6) NULL,
	CodigoConsultora VARCHAR(15) NULL,
	MotivoRechazo VARCHAR(6) NULL,
	Valor VARCHAR(10) NULL,
	CodigoRechazoSomosBelcorp VARCHAR(8) NULL,
	Procesado bit NOT NULL,
	Rechazado bit NOT NULL
);
GO
ALTER TABLE GPR.PedidoRechazado 
ADD CONSTRAINT DF_PedidoRechazado_Procesado
DEFAULT 0 FOR Procesado;
GO
ALTER TABLE GPR.PedidoRechazado 
ADD CONSTRAINT DF_PedidoRechazado_Rechazado
DEFAULT 0 FOR Rechazado;
GO
---------------------------------------------------------------------------------------------------------------
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'InsertarPedidoRechazadoXML' AND SPECIFIC_SCHEMA = 'GPR' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE GPR.InsertarPedidoRechazadoXML
END
GO
CREATE PROCEDURE GPR.InsertarPedidoRechazadoXML
	@Estado VARCHAR(5),
	@Mensaje varchar(1500),
	@PedidoRechazoXml xml
AS
BEGIN
	INSERT INTO GPR.ProcesoPedidoRechazado(Fecha, Estado, Mensaje)
	VALUES(GETDATE(),@Estado,@Mensaje);
	DECLARE @IdProcesoPedidoRechazado BIGINT = SCOPE_IDENTITY();

	INSERT INTO GPR.PedidoRechazado(IdProcesoPedidoRechazado,Campania,CodigoConsultora,MotivoRechazo,Valor)
	SELECT
		@IdProcesoPedidoRechazado,
		p.value('@Campania','VARCHAR(6)'), 
		p.value('@CodigoConsultora','VARCHAR(15)'),
		p.value('@MotivoRechazo','VARCHAR(6)'),
		p.value('@Valor','VARCHAR(10)')
	FROM @PedidoRechazoXml.nodes('/ROOT/PedidoRechazado')n(p);
END
GO
/*end*/

USE BelcorpPuertoRico
GO
IF NOT EXISTS(SELECT 1 FROM sys.schemas WHERE name = 'GPR')
BEGIN
	EXEC sp_executesql N'CREATE SCHEMA GPR';
END
GO
---------------------------------------------------------------------------------------------------------------
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'ProcesoPedidoRechazado' AND TABLE_SCHEMA = 'GPR')
BEGIN
    DROP TABLE GPR.ProcesoPedidoRechazado;
END
GO
CREATE TABLE GPR.ProcesoPedidoRechazado
(
	IdProcesoPedidoRechazado BIGINT IDENTITY(1,1) PRIMARY KEY,
	Fecha DATETIME NOT NULL,
	Estado VARCHAR(5) NOT NULL,
	Mensaje varchar(1500) NOT NULL,
	Procesado bit NOT NULL
);
GO
ALTER TABLE GPR.ProcesoPedidoRechazado 
ADD CONSTRAINT DF_ProcesoPedidoRechazado_Procesado
DEFAULT 0 FOR Procesado;
GO
---------------------------------------------------------------------------------------------------------------
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'PedidoRechazado' AND TABLE_SCHEMA = 'GPR')
BEGIN
    DROP TABLE GPR.PedidoRechazado;
END
GO
CREATE TABLE GPR.PedidoRechazado
(
	IdPedidoRechazado BIGINT IDENTITY(1,1) PRIMARY KEY,
	IdProcesoPedidoRechazado BIGINT NOT NULL,
	Campania VARCHAR(6) NULL,
	CodigoConsultora VARCHAR(15) NULL,
	MotivoRechazo VARCHAR(6) NULL,
	Valor VARCHAR(10) NULL,
	CodigoRechazoSomosBelcorp VARCHAR(8) NULL,
	Procesado bit NOT NULL,
	Rechazado bit NOT NULL
);
GO
ALTER TABLE GPR.PedidoRechazado 
ADD CONSTRAINT DF_PedidoRechazado_Procesado
DEFAULT 0 FOR Procesado;
GO
ALTER TABLE GPR.PedidoRechazado 
ADD CONSTRAINT DF_PedidoRechazado_Rechazado
DEFAULT 0 FOR Rechazado;
GO
---------------------------------------------------------------------------------------------------------------
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'InsertarPedidoRechazadoXML' AND SPECIFIC_SCHEMA = 'GPR' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE GPR.InsertarPedidoRechazadoXML
END
GO
CREATE PROCEDURE GPR.InsertarPedidoRechazadoXML
	@Estado VARCHAR(5),
	@Mensaje varchar(1500),
	@PedidoRechazoXml xml
AS
BEGIN
	INSERT INTO GPR.ProcesoPedidoRechazado(Fecha, Estado, Mensaje)
	VALUES(GETDATE(),@Estado,@Mensaje);
	DECLARE @IdProcesoPedidoRechazado BIGINT = SCOPE_IDENTITY();

	INSERT INTO GPR.PedidoRechazado(IdProcesoPedidoRechazado,Campania,CodigoConsultora,MotivoRechazo,Valor)
	SELECT
		@IdProcesoPedidoRechazado,
		p.value('@Campania','VARCHAR(6)'), 
		p.value('@CodigoConsultora','VARCHAR(15)'),
		p.value('@MotivoRechazo','VARCHAR(6)'),
		p.value('@Valor','VARCHAR(10)')
	FROM @PedidoRechazoXml.nodes('/ROOT/PedidoRechazado')n(p);
END
GO
/*end*/

USE BelcorpSalvador
GO
IF NOT EXISTS(SELECT 1 FROM sys.schemas WHERE name = 'GPR')
BEGIN
	EXEC sp_executesql N'CREATE SCHEMA GPR';
END
GO
---------------------------------------------------------------------------------------------------------------
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'ProcesoPedidoRechazado' AND TABLE_SCHEMA = 'GPR')
BEGIN
    DROP TABLE GPR.ProcesoPedidoRechazado;
END
GO
CREATE TABLE GPR.ProcesoPedidoRechazado
(
	IdProcesoPedidoRechazado BIGINT IDENTITY(1,1) PRIMARY KEY,
	Fecha DATETIME NOT NULL,
	Estado VARCHAR(5) NOT NULL,
	Mensaje varchar(1500) NOT NULL,
	Procesado bit NOT NULL
);
GO
ALTER TABLE GPR.ProcesoPedidoRechazado 
ADD CONSTRAINT DF_ProcesoPedidoRechazado_Procesado
DEFAULT 0 FOR Procesado;
GO
---------------------------------------------------------------------------------------------------------------
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'PedidoRechazado' AND TABLE_SCHEMA = 'GPR')
BEGIN
    DROP TABLE GPR.PedidoRechazado;
END
GO
CREATE TABLE GPR.PedidoRechazado
(
	IdPedidoRechazado BIGINT IDENTITY(1,1) PRIMARY KEY,
	IdProcesoPedidoRechazado BIGINT NOT NULL,
	Campania VARCHAR(6) NULL,
	CodigoConsultora VARCHAR(15) NULL,
	MotivoRechazo VARCHAR(6) NULL,
	Valor VARCHAR(10) NULL,
	CodigoRechazoSomosBelcorp VARCHAR(8) NULL,
	Procesado bit NOT NULL,
	Rechazado bit NOT NULL
);
GO
ALTER TABLE GPR.PedidoRechazado 
ADD CONSTRAINT DF_PedidoRechazado_Procesado
DEFAULT 0 FOR Procesado;
GO
ALTER TABLE GPR.PedidoRechazado 
ADD CONSTRAINT DF_PedidoRechazado_Rechazado
DEFAULT 0 FOR Rechazado;
GO
---------------------------------------------------------------------------------------------------------------
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'InsertarPedidoRechazadoXML' AND SPECIFIC_SCHEMA = 'GPR' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE GPR.InsertarPedidoRechazadoXML
END
GO
CREATE PROCEDURE GPR.InsertarPedidoRechazadoXML
	@Estado VARCHAR(5),
	@Mensaje varchar(1500),
	@PedidoRechazoXml xml
AS
BEGIN
	INSERT INTO GPR.ProcesoPedidoRechazado(Fecha, Estado, Mensaje)
	VALUES(GETDATE(),@Estado,@Mensaje);
	DECLARE @IdProcesoPedidoRechazado BIGINT = SCOPE_IDENTITY();

	INSERT INTO GPR.PedidoRechazado(IdProcesoPedidoRechazado,Campania,CodigoConsultora,MotivoRechazo,Valor)
	SELECT
		@IdProcesoPedidoRechazado,
		p.value('@Campania','VARCHAR(6)'), 
		p.value('@CodigoConsultora','VARCHAR(15)'),
		p.value('@MotivoRechazo','VARCHAR(6)'),
		p.value('@Valor','VARCHAR(10)')
	FROM @PedidoRechazoXml.nodes('/ROOT/PedidoRechazado')n(p);
END
GO
/*end*/

USE BelcorpVenezuela
GO
IF NOT EXISTS(SELECT 1 FROM sys.schemas WHERE name = 'GPR')
BEGIN
	EXEC sp_executesql N'CREATE SCHEMA GPR';
END
GO
---------------------------------------------------------------------------------------------------------------
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'ProcesoPedidoRechazado' AND TABLE_SCHEMA = 'GPR')
BEGIN
    DROP TABLE GPR.ProcesoPedidoRechazado;
END
GO
CREATE TABLE GPR.ProcesoPedidoRechazado
(
	IdProcesoPedidoRechazado BIGINT IDENTITY(1,1) PRIMARY KEY,
	Fecha DATETIME NOT NULL,
	Estado VARCHAR(5) NOT NULL,
	Mensaje varchar(1500) NOT NULL,
	Procesado bit NOT NULL
);
GO
ALTER TABLE GPR.ProcesoPedidoRechazado 
ADD CONSTRAINT DF_ProcesoPedidoRechazado_Procesado
DEFAULT 0 FOR Procesado;
GO
---------------------------------------------------------------------------------------------------------------
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'PedidoRechazado' AND TABLE_SCHEMA = 'GPR')
BEGIN
    DROP TABLE GPR.PedidoRechazado;
END
GO
CREATE TABLE GPR.PedidoRechazado
(
	IdPedidoRechazado BIGINT IDENTITY(1,1) PRIMARY KEY,
	IdProcesoPedidoRechazado BIGINT NOT NULL,
	Campania VARCHAR(6) NULL,
	CodigoConsultora VARCHAR(15) NULL,
	MotivoRechazo VARCHAR(6) NULL,
	Valor VARCHAR(10) NULL,
	CodigoRechazoSomosBelcorp VARCHAR(8) NULL,
	Procesado bit NOT NULL,
	Rechazado bit NOT NULL
);
GO
ALTER TABLE GPR.PedidoRechazado 
ADD CONSTRAINT DF_PedidoRechazado_Procesado
DEFAULT 0 FOR Procesado;
GO
ALTER TABLE GPR.PedidoRechazado 
ADD CONSTRAINT DF_PedidoRechazado_Rechazado
DEFAULT 0 FOR Rechazado;
GO
---------------------------------------------------------------------------------------------------------------
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'InsertarPedidoRechazadoXML' AND SPECIFIC_SCHEMA = 'GPR' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE GPR.InsertarPedidoRechazadoXML
END
GO
CREATE PROCEDURE GPR.InsertarPedidoRechazadoXML
	@Estado VARCHAR(5),
	@Mensaje varchar(1500),
	@PedidoRechazoXml xml
AS
BEGIN
	INSERT INTO GPR.ProcesoPedidoRechazado(Fecha, Estado, Mensaje)
	VALUES(GETDATE(),@Estado,@Mensaje);
	DECLARE @IdProcesoPedidoRechazado BIGINT = SCOPE_IDENTITY();

	INSERT INTO GPR.PedidoRechazado(IdProcesoPedidoRechazado,Campania,CodigoConsultora,MotivoRechazo,Valor)
	SELECT
		@IdProcesoPedidoRechazado,
		p.value('@Campania','VARCHAR(6)'), 
		p.value('@CodigoConsultora','VARCHAR(15)'),
		p.value('@MotivoRechazo','VARCHAR(6)'),
		p.value('@Valor','VARCHAR(10)')
	FROM @PedidoRechazoXml.nodes('/ROOT/PedidoRechazado')n(p);
END
GO