USE BelcorpBolivia
GO
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'EncuestaResultadoDetalle' and schema_id = 1)
BEGIN

DROP TABLE dbo.EncuestaResultadoDetalle;

END

GO

CREATE TABLE dbo.EncuestaResultadoDetalle(
Id uniqueidentifier NOT NULL,
EncuestaResultadoId uniqueidentifier NOT NULL,
MotivoId INT NOT NULL,
Observacion NVARCHAR(MAX) NULL,
CreatedBy NVARCHAR(30) NOT NULL,
CreatedOn DATETIME NOT NULL CONSTRAINT DF_EncuestaResultadoDetalle_CreatedOn DEFAULT (GETDATE()),
CreatedHost NVARCHAR(20) NULL
)
GO

ALTER TABLE dbo.EncuestaResultadoDetalle WITH CHECK ADD CONSTRAINT PK_EncuestaResultadoDetalle_Id PRIMARY KEY CLUSTERED (Id) ON [PRIMARY];
ALTER TABLE dbo.EncuestaResultadoDetalle ADD CONSTRAINT FK_EncuestaResultadoDetalle_EncuestaResultado_Id FOREIGN KEY (EncuestaResultadoId) REFERENCES dbo.EncuestaResultado(Id);
GO

USE BelcorpChile
GO
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'EncuestaResultadoDetalle' and schema_id = 1)
BEGIN

DROP TABLE dbo.EncuestaResultadoDetalle;

END

GO

CREATE TABLE dbo.EncuestaResultadoDetalle(
Id uniqueidentifier NOT NULL,
EncuestaResultadoId uniqueidentifier NOT NULL,
MotivoId INT NOT NULL,
Observacion NVARCHAR(MAX) NULL,
CreatedBy NVARCHAR(30) NOT NULL,
CreatedOn DATETIME NOT NULL CONSTRAINT DF_EncuestaResultadoDetalle_CreatedOn DEFAULT (GETDATE()),
CreatedHost NVARCHAR(20) NULL
)
GO

ALTER TABLE dbo.EncuestaResultadoDetalle WITH CHECK ADD CONSTRAINT PK_EncuestaResultadoDetalle_Id PRIMARY KEY CLUSTERED (Id) ON [PRIMARY];
ALTER TABLE dbo.EncuestaResultadoDetalle ADD CONSTRAINT FK_EncuestaResultadoDetalle_EncuestaResultado_Id FOREIGN KEY (EncuestaResultadoId) REFERENCES dbo.EncuestaResultado(Id);
GO

USE BelcorpColombia
GO
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'EncuestaResultadoDetalle' and schema_id = 1)
BEGIN

DROP TABLE dbo.EncuestaResultadoDetalle;

END

GO

CREATE TABLE dbo.EncuestaResultadoDetalle(
Id uniqueidentifier NOT NULL,
EncuestaResultadoId uniqueidentifier NOT NULL,
MotivoId INT NOT NULL,
Observacion NVARCHAR(MAX) NULL,
CreatedBy NVARCHAR(30) NOT NULL,
CreatedOn DATETIME NOT NULL CONSTRAINT DF_EncuestaResultadoDetalle_CreatedOn DEFAULT (GETDATE()),
CreatedHost NVARCHAR(20) NULL
)
GO

ALTER TABLE dbo.EncuestaResultadoDetalle WITH CHECK ADD CONSTRAINT PK_EncuestaResultadoDetalle_Id PRIMARY KEY CLUSTERED (Id) ON [PRIMARY];
ALTER TABLE dbo.EncuestaResultadoDetalle ADD CONSTRAINT FK_EncuestaResultadoDetalle_EncuestaResultado_Id FOREIGN KEY (EncuestaResultadoId) REFERENCES dbo.EncuestaResultado(Id);
GO
	
USE BelcorpCostaRica
GO
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'EncuestaResultadoDetalle' and schema_id = 1)
BEGIN

DROP TABLE dbo.EncuestaResultadoDetalle;

END

GO

CREATE TABLE dbo.EncuestaResultadoDetalle(
Id uniqueidentifier NOT NULL,
EncuestaResultadoId uniqueidentifier NOT NULL,
MotivoId INT NOT NULL,
Observacion NVARCHAR(MAX) NULL,
CreatedBy NVARCHAR(30) NOT NULL,
CreatedOn DATETIME NOT NULL CONSTRAINT DF_EncuestaResultadoDetalle_CreatedOn DEFAULT (GETDATE()),
CreatedHost NVARCHAR(20) NULL
)
GO

ALTER TABLE dbo.EncuestaResultadoDetalle WITH CHECK ADD CONSTRAINT PK_EncuestaResultadoDetalle_Id PRIMARY KEY CLUSTERED (Id) ON [PRIMARY];
ALTER TABLE dbo.EncuestaResultadoDetalle ADD CONSTRAINT FK_EncuestaResultadoDetalle_EncuestaResultado_Id FOREIGN KEY (EncuestaResultadoId) REFERENCES dbo.EncuestaResultado(Id);
GO

USE BelcorpDominicana
GO
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'EncuestaResultadoDetalle' and schema_id = 1)
BEGIN

DROP TABLE dbo.EncuestaResultadoDetalle;

END

GO

CREATE TABLE dbo.EncuestaResultadoDetalle(
Id uniqueidentifier NOT NULL,
EncuestaResultadoId uniqueidentifier NOT NULL,
MotivoId INT NOT NULL,
Observacion NVARCHAR(MAX) NULL,
CreatedBy NVARCHAR(30) NOT NULL,
CreatedOn DATETIME NOT NULL CONSTRAINT DF_EncuestaResultadoDetalle_CreatedOn DEFAULT (GETDATE()),
CreatedHost NVARCHAR(20) NULL
)
GO

ALTER TABLE dbo.EncuestaResultadoDetalle WITH CHECK ADD CONSTRAINT PK_EncuestaResultadoDetalle_Id PRIMARY KEY CLUSTERED (Id) ON [PRIMARY];
ALTER TABLE dbo.EncuestaResultadoDetalle ADD CONSTRAINT FK_EncuestaResultadoDetalle_EncuestaResultado_Id FOREIGN KEY (EncuestaResultadoId) REFERENCES dbo.EncuestaResultado(Id);
GO

USE BelcorpEcuador
GO
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'EncuestaResultadoDetalle' and schema_id = 1)
BEGIN

DROP TABLE dbo.EncuestaResultadoDetalle;

END

GO

CREATE TABLE dbo.EncuestaResultadoDetalle(
Id uniqueidentifier NOT NULL,
EncuestaResultadoId uniqueidentifier NOT NULL,
MotivoId INT NOT NULL,
Observacion NVARCHAR(MAX) NULL,
CreatedBy NVARCHAR(30) NOT NULL,
CreatedOn DATETIME NOT NULL CONSTRAINT DF_EncuestaResultadoDetalle_CreatedOn DEFAULT (GETDATE()),
CreatedHost NVARCHAR(20) NULL
)
GO

ALTER TABLE dbo.EncuestaResultadoDetalle WITH CHECK ADD CONSTRAINT PK_EncuestaResultadoDetalle_Id PRIMARY KEY CLUSTERED (Id) ON [PRIMARY];
ALTER TABLE dbo.EncuestaResultadoDetalle ADD CONSTRAINT FK_EncuestaResultadoDetalle_EncuestaResultado_Id FOREIGN KEY (EncuestaResultadoId) REFERENCES dbo.EncuestaResultado(Id);
GO

USE BelcorpGuatemala
GO
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'EncuestaResultadoDetalle' and schema_id = 1)
BEGIN

DROP TABLE dbo.EncuestaResultadoDetalle;

END

GO

CREATE TABLE dbo.EncuestaResultadoDetalle(
Id uniqueidentifier NOT NULL,
EncuestaResultadoId uniqueidentifier NOT NULL,
MotivoId INT NOT NULL,
Observacion NVARCHAR(MAX) NULL,
CreatedBy NVARCHAR(30) NOT NULL,
CreatedOn DATETIME NOT NULL CONSTRAINT DF_EncuestaResultadoDetalle_CreatedOn DEFAULT (GETDATE()),
CreatedHost NVARCHAR(20) NULL
)
GO

ALTER TABLE dbo.EncuestaResultadoDetalle WITH CHECK ADD CONSTRAINT PK_EncuestaResultadoDetalle_Id PRIMARY KEY CLUSTERED (Id) ON [PRIMARY];
ALTER TABLE dbo.EncuestaResultadoDetalle ADD CONSTRAINT FK_EncuestaResultadoDetalle_EncuestaResultado_Id FOREIGN KEY (EncuestaResultadoId) REFERENCES dbo.EncuestaResultado(Id);
GO

USE BelcorpMexico
GO
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'EncuestaResultadoDetalle' and schema_id = 1)
BEGIN

DROP TABLE dbo.EncuestaResultadoDetalle;

END

GO

CREATE TABLE dbo.EncuestaResultadoDetalle(
Id uniqueidentifier NOT NULL,
EncuestaResultadoId uniqueidentifier NOT NULL,
MotivoId INT NOT NULL,
Observacion NVARCHAR(MAX) NULL,
CreatedBy NVARCHAR(30) NOT NULL,
CreatedOn DATETIME NOT NULL CONSTRAINT DF_EncuestaResultadoDetalle_CreatedOn DEFAULT (GETDATE()),
CreatedHost NVARCHAR(20) NULL
)
GO

ALTER TABLE dbo.EncuestaResultadoDetalle WITH CHECK ADD CONSTRAINT PK_EncuestaResultadoDetalle_Id PRIMARY KEY CLUSTERED (Id) ON [PRIMARY];
ALTER TABLE dbo.EncuestaResultadoDetalle ADD CONSTRAINT FK_EncuestaResultadoDetalle_EncuestaResultado_Id FOREIGN KEY (EncuestaResultadoId) REFERENCES dbo.EncuestaResultado(Id);
GO

USE BelcorpPanama
GO
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'EncuestaResultadoDetalle' and schema_id = 1)
BEGIN

DROP TABLE dbo.EncuestaResultadoDetalle;

END

GO

CREATE TABLE dbo.EncuestaResultadoDetalle(
Id uniqueidentifier NOT NULL,
EncuestaResultadoId uniqueidentifier NOT NULL,
MotivoId INT NOT NULL,
Observacion NVARCHAR(MAX) NULL,
CreatedBy NVARCHAR(30) NOT NULL,
CreatedOn DATETIME NOT NULL CONSTRAINT DF_EncuestaResultadoDetalle_CreatedOn DEFAULT (GETDATE()),
CreatedHost NVARCHAR(20) NULL
)
GO

ALTER TABLE dbo.EncuestaResultadoDetalle WITH CHECK ADD CONSTRAINT PK_EncuestaResultadoDetalle_Id PRIMARY KEY CLUSTERED (Id) ON [PRIMARY];
ALTER TABLE dbo.EncuestaResultadoDetalle ADD CONSTRAINT FK_EncuestaResultadoDetalle_EncuestaResultado_Id FOREIGN KEY (EncuestaResultadoId) REFERENCES dbo.EncuestaResultado(Id);
GO

USE BelcorpPeru
GO
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'EncuestaResultadoDetalle' and schema_id = 1)
BEGIN

DROP TABLE dbo.EncuestaResultadoDetalle;

END

GO

CREATE TABLE dbo.EncuestaResultadoDetalle(
Id uniqueidentifier NOT NULL,
EncuestaResultadoId uniqueidentifier NOT NULL,
MotivoId INT NOT NULL,
Observacion NVARCHAR(MAX) NULL,
CreatedBy NVARCHAR(30) NOT NULL,
CreatedOn DATETIME NOT NULL CONSTRAINT DF_EncuestaResultadoDetalle_CreatedOn DEFAULT (GETDATE()),
CreatedHost NVARCHAR(20) NULL
)
GO

ALTER TABLE dbo.EncuestaResultadoDetalle WITH CHECK ADD CONSTRAINT PK_EncuestaResultadoDetalle_Id PRIMARY KEY CLUSTERED (Id) ON [PRIMARY];
ALTER TABLE dbo.EncuestaResultadoDetalle ADD CONSTRAINT FK_EncuestaResultadoDetalle_EncuestaResultado_Id FOREIGN KEY (EncuestaResultadoId) REFERENCES dbo.EncuestaResultado(Id);
GO

USE BelcorpPuertoRico
GO
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'EncuestaResultadoDetalle' and schema_id = 1)
BEGIN

DROP TABLE dbo.EncuestaResultadoDetalle;

END

GO

CREATE TABLE dbo.EncuestaResultadoDetalle(
Id uniqueidentifier NOT NULL,
EncuestaResultadoId uniqueidentifier NOT NULL,
MotivoId INT NOT NULL,
Observacion NVARCHAR(MAX) NULL,
CreatedBy NVARCHAR(30) NOT NULL,
CreatedOn DATETIME NOT NULL CONSTRAINT DF_EncuestaResultadoDetalle_CreatedOn DEFAULT (GETDATE()),
CreatedHost NVARCHAR(20) NULL
)
GO

ALTER TABLE dbo.EncuestaResultadoDetalle WITH CHECK ADD CONSTRAINT PK_EncuestaResultadoDetalle_Id PRIMARY KEY CLUSTERED (Id) ON [PRIMARY];
ALTER TABLE dbo.EncuestaResultadoDetalle ADD CONSTRAINT FK_EncuestaResultadoDetalle_EncuestaResultado_Id FOREIGN KEY (EncuestaResultadoId) REFERENCES dbo.EncuestaResultado(Id);
GO

USE BelcorpSalvador
GO

IF EXISTS(SELECT * FROM sys.tables WHERE name = N'EncuestaResultadoDetalle' and schema_id = 1)
BEGIN

DROP TABLE dbo.EncuestaResultadoDetalle;

END

GO

CREATE TABLE dbo.EncuestaResultadoDetalle(
Id uniqueidentifier NOT NULL,
EncuestaResultadoId uniqueidentifier NOT NULL,
MotivoId INT NOT NULL,
Observacion NVARCHAR(MAX) NULL,
CreatedBy NVARCHAR(30) NOT NULL,
CreatedOn DATETIME NOT NULL CONSTRAINT DF_EncuestaResultadoDetalle_CreatedOn DEFAULT (GETDATE()),
CreatedHost NVARCHAR(20) NULL
)
GO

ALTER TABLE dbo.EncuestaResultadoDetalle WITH CHECK ADD CONSTRAINT PK_EncuestaResultadoDetalle_Id PRIMARY KEY CLUSTERED (Id) ON [PRIMARY];
ALTER TABLE dbo.EncuestaResultadoDetalle ADD CONSTRAINT FK_EncuestaResultadoDetalle_EncuestaResultado_Id FOREIGN KEY (EncuestaResultadoId) REFERENCES dbo.EncuestaResultado(Id);
GO
