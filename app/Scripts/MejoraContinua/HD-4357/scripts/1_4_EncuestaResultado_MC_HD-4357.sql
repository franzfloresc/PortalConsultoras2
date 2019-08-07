USE BelcorpBolivia
GO
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'EncuestaResultado' and schema_id = 1)
BEGIN

DROP TABLE dbo.EncuestaResultado;

END
GO

CREATE TABLE dbo.EncuestaResultado(
Id uniqueidentifier NOT NULL,
EncuestaId INT NOT NULL,
CanalId INT NOT NULL,
CodigoCampania VARCHAR(6) NOT NULL,
CodigoConsultora NVARCHAR(25) NOT NULL,
SeleccionoMotivo BIT NOT NULL,
CreatedBy NVARCHAR(30) NOT NULL,
CreatedOn DATETIME NOT NULL CONSTRAINT DF_EncuestaResultado_CreatedOn DEFAULT (GETDATE()),
CreatedHost NVARCHAR(20) NULL
)
GO

ALTER TABLE dbo.EncuestaResultado WITH CHECK ADD CONSTRAINT PK_EncuestaResultado_Id PRIMARY KEY CLUSTERED (Id) ON [PRIMARY];
ALTER TABLE dbo.EncuestaResultado ADD CONSTRAINT FK_EncuestaResultado_Encuesta_Id FOREIGN KEY (EncuestaId) REFERENCES dbo.Encuesta(Id);
GO
USE BelcorpChile
GO
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'EncuestaResultado' and schema_id = 1)
BEGIN

DROP TABLE dbo.EncuestaResultado;

END
GO

CREATE TABLE dbo.EncuestaResultado(
Id uniqueidentifier NOT NULL,
EncuestaId INT NOT NULL,
CanalId INT NOT NULL,
CodigoCampania VARCHAR(6) NOT NULL,
CodigoConsultora NVARCHAR(25) NOT NULL,
SeleccionoMotivo BIT NOT NULL,
CreatedBy NVARCHAR(30) NOT NULL,
CreatedOn DATETIME NOT NULL CONSTRAINT DF_EncuestaResultado_CreatedOn DEFAULT (GETDATE()),
CreatedHost NVARCHAR(20) NULL
)
GO

ALTER TABLE dbo.EncuestaResultado WITH CHECK ADD CONSTRAINT PK_EncuestaResultado_Id PRIMARY KEY CLUSTERED (Id) ON [PRIMARY];
ALTER TABLE dbo.EncuestaResultado ADD CONSTRAINT FK_EncuestaResultado_Encuesta_Id FOREIGN KEY (EncuestaId) REFERENCES dbo.Encuesta(Id);
GO
USE BelcorpColombia
GO
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'EncuestaResultado' and schema_id = 1)
BEGIN

DROP TABLE dbo.EncuestaResultado;

END
GO

CREATE TABLE dbo.EncuestaResultado(
Id uniqueidentifier NOT NULL,
EncuestaId INT NOT NULL,
CanalId INT NOT NULL,
CodigoCampania VARCHAR(6) NOT NULL,
CodigoConsultora NVARCHAR(25) NOT NULL,
SeleccionoMotivo BIT NOT NULL,
CreatedBy NVARCHAR(30) NOT NULL,
CreatedOn DATETIME NOT NULL CONSTRAINT DF_EncuestaResultado_CreatedOn DEFAULT (GETDATE()),
CreatedHost NVARCHAR(20) NULL
)
GO

ALTER TABLE dbo.EncuestaResultado WITH CHECK ADD CONSTRAINT PK_EncuestaResultado_Id PRIMARY KEY CLUSTERED (Id) ON [PRIMARY];
ALTER TABLE dbo.EncuestaResultado ADD CONSTRAINT FK_EncuestaResultado_Encuesta_Id FOREIGN KEY (EncuestaId) REFERENCES dbo.Encuesta(Id);
GO	
USE BelcorpCostaRica
GO
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'EncuestaResultado' and schema_id = 1)
BEGIN

DROP TABLE dbo.EncuestaResultado;

END
GO

CREATE TABLE dbo.EncuestaResultado(
Id uniqueidentifier NOT NULL,
EncuestaId INT NOT NULL,
CanalId INT NOT NULL,
CodigoCampania VARCHAR(6) NOT NULL,
CodigoConsultora NVARCHAR(25) NOT NULL,
SeleccionoMotivo BIT NOT NULL,
CreatedBy NVARCHAR(30) NOT NULL,
CreatedOn DATETIME NOT NULL CONSTRAINT DF_EncuestaResultado_CreatedOn DEFAULT (GETDATE()),
CreatedHost NVARCHAR(20) NULL
)
GO

ALTER TABLE dbo.EncuestaResultado WITH CHECK ADD CONSTRAINT PK_EncuestaResultado_Id PRIMARY KEY CLUSTERED (Id) ON [PRIMARY];
ALTER TABLE dbo.EncuestaResultado ADD CONSTRAINT FK_EncuestaResultado_Encuesta_Id FOREIGN KEY (EncuestaId) REFERENCES dbo.Encuesta(Id);
GO
USE BelcorpDominicana
GO
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'EncuestaResultado' and schema_id = 1)
BEGIN

DROP TABLE dbo.EncuestaResultado;

END
GO

CREATE TABLE dbo.EncuestaResultado(
Id uniqueidentifier NOT NULL,
EncuestaId INT NOT NULL,
CanalId INT NOT NULL,
CodigoCampania VARCHAR(6) NOT NULL,
CodigoConsultora NVARCHAR(25) NOT NULL,
SeleccionoMotivo BIT NOT NULL,
CreatedBy NVARCHAR(30) NOT NULL,
CreatedOn DATETIME NOT NULL CONSTRAINT DF_EncuestaResultado_CreatedOn DEFAULT (GETDATE()),
CreatedHost NVARCHAR(20) NULL
)
GO

ALTER TABLE dbo.EncuestaResultado WITH CHECK ADD CONSTRAINT PK_EncuestaResultado_Id PRIMARY KEY CLUSTERED (Id) ON [PRIMARY];
ALTER TABLE dbo.EncuestaResultado ADD CONSTRAINT FK_EncuestaResultado_Encuesta_Id FOREIGN KEY (EncuestaId) REFERENCES dbo.Encuesta(Id);
GO
USE BelcorpEcuador
GO
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'EncuestaResultado' and schema_id = 1)
BEGIN

DROP TABLE dbo.EncuestaResultado;

END
GO

CREATE TABLE dbo.EncuestaResultado(
Id uniqueidentifier NOT NULL,
EncuestaId INT NOT NULL,
CanalId INT NOT NULL,
CodigoCampania VARCHAR(6) NOT NULL,
CodigoConsultora NVARCHAR(25) NOT NULL,
SeleccionoMotivo BIT NOT NULL,
CreatedBy NVARCHAR(30) NOT NULL,
CreatedOn DATETIME NOT NULL CONSTRAINT DF_EncuestaResultado_CreatedOn DEFAULT (GETDATE()),
CreatedHost NVARCHAR(20) NULL
)
GO

ALTER TABLE dbo.EncuestaResultado WITH CHECK ADD CONSTRAINT PK_EncuestaResultado_Id PRIMARY KEY CLUSTERED (Id) ON [PRIMARY];
ALTER TABLE dbo.EncuestaResultado ADD CONSTRAINT FK_EncuestaResultado_Encuesta_Id FOREIGN KEY (EncuestaId) REFERENCES dbo.Encuesta(Id);
GO
USE BelcorpGuatemala
GO
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'EncuestaResultado' and schema_id = 1)
BEGIN

DROP TABLE dbo.EncuestaResultado;

END
GO

CREATE TABLE dbo.EncuestaResultado(
Id uniqueidentifier NOT NULL,
EncuestaId INT NOT NULL,
CanalId INT NOT NULL,
CodigoCampania VARCHAR(6) NOT NULL,
CodigoConsultora NVARCHAR(25) NOT NULL,
SeleccionoMotivo BIT NOT NULL,
CreatedBy NVARCHAR(30) NOT NULL,
CreatedOn DATETIME NOT NULL CONSTRAINT DF_EncuestaResultado_CreatedOn DEFAULT (GETDATE()),
CreatedHost NVARCHAR(20) NULL
)
GO

ALTER TABLE dbo.EncuestaResultado WITH CHECK ADD CONSTRAINT PK_EncuestaResultado_Id PRIMARY KEY CLUSTERED (Id) ON [PRIMARY];
ALTER TABLE dbo.EncuestaResultado ADD CONSTRAINT FK_EncuestaResultado_Encuesta_Id FOREIGN KEY (EncuestaId) REFERENCES dbo.Encuesta(Id);
GO
USE BelcorpMexico
GO
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'EncuestaResultado' and schema_id = 1)
BEGIN

DROP TABLE dbo.EncuestaResultado;

END
GO

CREATE TABLE dbo.EncuestaResultado(
Id uniqueidentifier NOT NULL,
EncuestaId INT NOT NULL,
CanalId INT NOT NULL,
CodigoCampania VARCHAR(6) NOT NULL,
CodigoConsultora NVARCHAR(25) NOT NULL,
SeleccionoMotivo BIT NOT NULL,
CreatedBy NVARCHAR(30) NOT NULL,
CreatedOn DATETIME NOT NULL CONSTRAINT DF_EncuestaResultado_CreatedOn DEFAULT (GETDATE()),
CreatedHost NVARCHAR(20) NULL
)
GO

ALTER TABLE dbo.EncuestaResultado WITH CHECK ADD CONSTRAINT PK_EncuestaResultado_Id PRIMARY KEY CLUSTERED (Id) ON [PRIMARY];
ALTER TABLE dbo.EncuestaResultado ADD CONSTRAINT FK_EncuestaResultado_Encuesta_Id FOREIGN KEY (EncuestaId) REFERENCES dbo.Encuesta(Id);
GO
USE BelcorpPanama
GO
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'EncuestaResultado' and schema_id = 1)
BEGIN

DROP TABLE dbo.EncuestaResultado;

END
GO

CREATE TABLE dbo.EncuestaResultado(
Id uniqueidentifier NOT NULL,
EncuestaId INT NOT NULL,
CanalId INT NOT NULL,
CodigoCampania VARCHAR(6) NOT NULL,
CodigoConsultora NVARCHAR(25) NOT NULL,
SeleccionoMotivo BIT NOT NULL,
CreatedBy NVARCHAR(30) NOT NULL,
CreatedOn DATETIME NOT NULL CONSTRAINT DF_EncuestaResultado_CreatedOn DEFAULT (GETDATE()),
CreatedHost NVARCHAR(20) NULL
)
GO

ALTER TABLE dbo.EncuestaResultado WITH CHECK ADD CONSTRAINT PK_EncuestaResultado_Id PRIMARY KEY CLUSTERED (Id) ON [PRIMARY];
ALTER TABLE dbo.EncuestaResultado ADD CONSTRAINT FK_EncuestaResultado_Encuesta_Id FOREIGN KEY (EncuestaId) REFERENCES dbo.Encuesta(Id);
GO
USE BelcorpPeru
GO
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'EncuestaResultado' and schema_id = 1)
BEGIN

DROP TABLE dbo.EncuestaResultado;

END
GO

CREATE TABLE dbo.EncuestaResultado(
Id uniqueidentifier NOT NULL,
EncuestaId INT NOT NULL,
CanalId INT NOT NULL,
CodigoCampania VARCHAR(6) NOT NULL,
CodigoConsultora NVARCHAR(25) NOT NULL,
SeleccionoMotivo BIT NOT NULL,
CreatedBy NVARCHAR(30) NOT NULL,
CreatedOn DATETIME NOT NULL CONSTRAINT DF_EncuestaResultado_CreatedOn DEFAULT (GETDATE()),
CreatedHost NVARCHAR(20) NULL
)
GO

ALTER TABLE dbo.EncuestaResultado WITH CHECK ADD CONSTRAINT PK_EncuestaResultado_Id PRIMARY KEY CLUSTERED (Id) ON [PRIMARY];
ALTER TABLE dbo.EncuestaResultado ADD CONSTRAINT FK_EncuestaResultado_Encuesta_Id FOREIGN KEY (EncuestaId) REFERENCES dbo.Encuesta(Id);
GO
USE BelcorpPuertoRico
GO
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'EncuestaResultado' and schema_id = 1)
BEGIN

DROP TABLE dbo.EncuestaResultado;

END
GO

CREATE TABLE dbo.EncuestaResultado(
Id uniqueidentifier NOT NULL,
EncuestaId INT NOT NULL,
CanalId INT NOT NULL,
CodigoCampania VARCHAR(6) NOT NULL,
CodigoConsultora NVARCHAR(25) NOT NULL,
SeleccionoMotivo BIT NOT NULL,
CreatedBy NVARCHAR(30) NOT NULL,
CreatedOn DATETIME NOT NULL CONSTRAINT DF_EncuestaResultado_CreatedOn DEFAULT (GETDATE()),
CreatedHost NVARCHAR(20) NULL
)
GO

ALTER TABLE dbo.EncuestaResultado WITH CHECK ADD CONSTRAINT PK_EncuestaResultado_Id PRIMARY KEY CLUSTERED (Id) ON [PRIMARY];
ALTER TABLE dbo.EncuestaResultado ADD CONSTRAINT FK_EncuestaResultado_Encuesta_Id FOREIGN KEY (EncuestaId) REFERENCES dbo.Encuesta(Id);
GO
USE BelcorpSalvador
GO
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'EncuestaResultado' and schema_id = 1)
BEGIN

DROP TABLE dbo.EncuestaResultado;

END
GO

CREATE TABLE dbo.EncuestaResultado(
Id uniqueidentifier NOT NULL,
EncuestaId INT NOT NULL,
CanalId INT NOT NULL,
CodigoCampania VARCHAR(6) NOT NULL,
CodigoConsultora NVARCHAR(25) NOT NULL,
SeleccionoMotivo BIT NOT NULL,
CreatedBy NVARCHAR(30) NOT NULL,
CreatedOn DATETIME NOT NULL CONSTRAINT DF_EncuestaResultado_CreatedOn DEFAULT (GETDATE()),
CreatedHost NVARCHAR(20) NULL
)
GO

ALTER TABLE dbo.EncuestaResultado WITH CHECK ADD CONSTRAINT PK_EncuestaResultado_Id PRIMARY KEY CLUSTERED (Id) ON [PRIMARY];
ALTER TABLE dbo.EncuestaResultado ADD CONSTRAINT FK_EncuestaResultado_Encuesta_Id FOREIGN KEY (EncuestaId) REFERENCES dbo.Encuesta(Id);
GO


