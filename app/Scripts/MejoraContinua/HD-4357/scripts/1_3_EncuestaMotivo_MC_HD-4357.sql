USE BelcorpBolivia
GO
CREATE TABLE dbo.EncuestaMotivo(
Id INT IDENTITY(1,1) NOT NULL,
EncuestaCalificacionId INT NOT NULL,
TipoEncuestaMotivoId INT NOT NULL,
Descripcion NVARCHAR(60) NOT NULL,
CreatedBy NVARCHAR(30) NOT NULL,
CreatedOn DATETIME NOT NULL CONSTRAINT DF_EncuestaMotivo_CreatedOn DEFAULT (GETDATE()),
CreatedHost NVARCHAR(20) NULL,
ModifiedBy NVARCHAR(30) NULL,
ModifiedOn DATETIME NULL,
ModifiedHost NVARCHAR(20) NULL,
Status BIT NOT NULL CONSTRAINT DF_EncuestaMotivo_Status DEFAULT (1)
)
GO

ALTER TABLE dbo.EncuestaMotivo WITH CHECK ADD CONSTRAINT PK_EncuestaMotivo_Id PRIMARY KEY CLUSTERED (Id) ON [PRIMARY];
ALTER TABLE dbo.EncuestaMotivo ADD CONSTRAINT FK_EncuestaMotivo_EncuestaCalificacion_Id FOREIGN KEY (EncuestaCalificacionId) REFERENCES dbo.EncuestaCalificacion(Id);
GO

USE BelcorpChile
GO
CREATE TABLE dbo.EncuestaMotivo(
Id INT IDENTITY(1,1) NOT NULL,
EncuestaCalificacionId INT NOT NULL,
TipoEncuestaMotivoId INT NOT NULL,
Descripcion NVARCHAR(60) NOT NULL,
CreatedBy NVARCHAR(30) NOT NULL,
CreatedOn DATETIME NOT NULL CONSTRAINT DF_EncuestaMotivo_CreatedOn DEFAULT (GETDATE()),
CreatedHost NVARCHAR(20) NULL,
ModifiedBy NVARCHAR(30) NULL,
ModifiedOn DATETIME NULL,
ModifiedHost NVARCHAR(20) NULL,
Status BIT NOT NULL CONSTRAINT DF_EncuestaMotivo_Status DEFAULT (1)
)
GO

ALTER TABLE dbo.EncuestaMotivo WITH CHECK ADD CONSTRAINT PK_EncuestaMotivo_Id PRIMARY KEY CLUSTERED (Id) ON [PRIMARY];
ALTER TABLE dbo.EncuestaMotivo ADD CONSTRAINT FK_EncuestaMotivo_EncuestaCalificacion_Id FOREIGN KEY (EncuestaCalificacionId) REFERENCES dbo.EncuestaCalificacion(Id);
GO

USE BelcorpColombia
GO
CREATE TABLE dbo.EncuestaMotivo(
Id INT IDENTITY(1,1) NOT NULL,
EncuestaCalificacionId INT NOT NULL,
TipoEncuestaMotivoId INT NOT NULL,
Descripcion NVARCHAR(60) NOT NULL,
CreatedBy NVARCHAR(30) NOT NULL,
CreatedOn DATETIME NOT NULL CONSTRAINT DF_EncuestaMotivo_CreatedOn DEFAULT (GETDATE()),
CreatedHost NVARCHAR(20) NULL,
ModifiedBy NVARCHAR(30) NULL,
ModifiedOn DATETIME NULL,
ModifiedHost NVARCHAR(20) NULL,
Status BIT NOT NULL CONSTRAINT DF_EncuestaMotivo_Status DEFAULT (1)
)
GO

ALTER TABLE dbo.EncuestaMotivo WITH CHECK ADD CONSTRAINT PK_EncuestaMotivo_Id PRIMARY KEY CLUSTERED (Id) ON [PRIMARY];
ALTER TABLE dbo.EncuestaMotivo ADD CONSTRAINT FK_EncuestaMotivo_EncuestaCalificacion_Id FOREIGN KEY (EncuestaCalificacionId) REFERENCES dbo.EncuestaCalificacion(Id);
GO
	
USE BelcorpCostaRica
GO
CREATE TABLE dbo.EncuestaMotivo(
Id INT IDENTITY(1,1) NOT NULL,
EncuestaCalificacionId INT NOT NULL,
TipoEncuestaMotivoId INT NOT NULL,
Descripcion NVARCHAR(60) NOT NULL,
CreatedBy NVARCHAR(30) NOT NULL,
CreatedOn DATETIME NOT NULL CONSTRAINT DF_EncuestaMotivo_CreatedOn DEFAULT (GETDATE()),
CreatedHost NVARCHAR(20) NULL,
ModifiedBy NVARCHAR(30) NULL,
ModifiedOn DATETIME NULL,
ModifiedHost NVARCHAR(20) NULL,
Status BIT NOT NULL CONSTRAINT DF_EncuestaMotivo_Status DEFAULT (1)
)
GO

ALTER TABLE dbo.EncuestaMotivo WITH CHECK ADD CONSTRAINT PK_EncuestaMotivo_Id PRIMARY KEY CLUSTERED (Id) ON [PRIMARY];
ALTER TABLE dbo.EncuestaMotivo ADD CONSTRAINT FK_EncuestaMotivo_EncuestaCalificacion_Id FOREIGN KEY (EncuestaCalificacionId) REFERENCES dbo.EncuestaCalificacion(Id);
GO

USE BelcorpDominicana
GO
CREATE TABLE dbo.EncuestaMotivo(
Id INT IDENTITY(1,1) NOT NULL,
EncuestaCalificacionId INT NOT NULL,
TipoEncuestaMotivoId INT NOT NULL,
Descripcion NVARCHAR(60) NOT NULL,
CreatedBy NVARCHAR(30) NOT NULL,
CreatedOn DATETIME NOT NULL CONSTRAINT DF_EncuestaMotivo_CreatedOn DEFAULT (GETDATE()),
CreatedHost NVARCHAR(20) NULL,
ModifiedBy NVARCHAR(30) NULL,
ModifiedOn DATETIME NULL,
ModifiedHost NVARCHAR(20) NULL,
Status BIT NOT NULL CONSTRAINT DF_EncuestaMotivo_Status DEFAULT (1)
)
GO

ALTER TABLE dbo.EncuestaMotivo WITH CHECK ADD CONSTRAINT PK_EncuestaMotivo_Id PRIMARY KEY CLUSTERED (Id) ON [PRIMARY];
ALTER TABLE dbo.EncuestaMotivo ADD CONSTRAINT FK_EncuestaMotivo_EncuestaCalificacion_Id FOREIGN KEY (EncuestaCalificacionId) REFERENCES dbo.EncuestaCalificacion(Id);
GO

USE BelcorpEcuador
GO
CREATE TABLE dbo.EncuestaMotivo(
Id INT IDENTITY(1,1) NOT NULL,
EncuestaCalificacionId INT NOT NULL,
TipoEncuestaMotivoId INT NOT NULL,
Descripcion NVARCHAR(60) NOT NULL,
CreatedBy NVARCHAR(30) NOT NULL,
CreatedOn DATETIME NOT NULL CONSTRAINT DF_EncuestaMotivo_CreatedOn DEFAULT (GETDATE()),
CreatedHost NVARCHAR(20) NULL,
ModifiedBy NVARCHAR(30) NULL,
ModifiedOn DATETIME NULL,
ModifiedHost NVARCHAR(20) NULL,
Status BIT NOT NULL CONSTRAINT DF_EncuestaMotivo_Status DEFAULT (1)
)
GO

ALTER TABLE dbo.EncuestaMotivo WITH CHECK ADD CONSTRAINT PK_EncuestaMotivo_Id PRIMARY KEY CLUSTERED (Id) ON [PRIMARY];
ALTER TABLE dbo.EncuestaMotivo ADD CONSTRAINT FK_EncuestaMotivo_EncuestaCalificacion_Id FOREIGN KEY (EncuestaCalificacionId) REFERENCES dbo.EncuestaCalificacion(Id);
GO

USE BelcorpGuatemala
GO
CREATE TABLE dbo.EncuestaMotivo(
Id INT IDENTITY(1,1) NOT NULL,
EncuestaCalificacionId INT NOT NULL,
TipoEncuestaMotivoId INT NOT NULL,
Descripcion NVARCHAR(60) NOT NULL,
CreatedBy NVARCHAR(30) NOT NULL,
CreatedOn DATETIME NOT NULL CONSTRAINT DF_EncuestaMotivo_CreatedOn DEFAULT (GETDATE()),
CreatedHost NVARCHAR(20) NULL,
ModifiedBy NVARCHAR(30) NULL,
ModifiedOn DATETIME NULL,
ModifiedHost NVARCHAR(20) NULL,
Status BIT NOT NULL CONSTRAINT DF_EncuestaMotivo_Status DEFAULT (1)
)
GO

ALTER TABLE dbo.EncuestaMotivo WITH CHECK ADD CONSTRAINT PK_EncuestaMotivo_Id PRIMARY KEY CLUSTERED (Id) ON [PRIMARY];
ALTER TABLE dbo.EncuestaMotivo ADD CONSTRAINT FK_EncuestaMotivo_EncuestaCalificacion_Id FOREIGN KEY (EncuestaCalificacionId) REFERENCES dbo.EncuestaCalificacion(Id);
GO

USE BelcorpMexico
GO
CREATE TABLE dbo.EncuestaMotivo(
Id INT IDENTITY(1,1) NOT NULL,
EncuestaCalificacionId INT NOT NULL,
TipoEncuestaMotivoId INT NOT NULL,
Descripcion NVARCHAR(60) NOT NULL,
CreatedBy NVARCHAR(30) NOT NULL,
CreatedOn DATETIME NOT NULL CONSTRAINT DF_EncuestaMotivo_CreatedOn DEFAULT (GETDATE()),
CreatedHost NVARCHAR(20) NULL,
ModifiedBy NVARCHAR(30) NULL,
ModifiedOn DATETIME NULL,
ModifiedHost NVARCHAR(20) NULL,
Status BIT NOT NULL CONSTRAINT DF_EncuestaMotivo_Status DEFAULT (1)
)
GO

ALTER TABLE dbo.EncuestaMotivo WITH CHECK ADD CONSTRAINT PK_EncuestaMotivo_Id PRIMARY KEY CLUSTERED (Id) ON [PRIMARY];
ALTER TABLE dbo.EncuestaMotivo ADD CONSTRAINT FK_EncuestaMotivo_EncuestaCalificacion_Id FOREIGN KEY (EncuestaCalificacionId) REFERENCES dbo.EncuestaCalificacion(Id);
GO

USE BelcorpPanama
GO
CREATE TABLE dbo.EncuestaMotivo(
Id INT IDENTITY(1,1) NOT NULL,
EncuestaCalificacionId INT NOT NULL,
TipoEncuestaMotivoId INT NOT NULL,
Descripcion NVARCHAR(60) NOT NULL,
CreatedBy NVARCHAR(30) NOT NULL,
CreatedOn DATETIME NOT NULL CONSTRAINT DF_EncuestaMotivo_CreatedOn DEFAULT (GETDATE()),
CreatedHost NVARCHAR(20) NULL,
ModifiedBy NVARCHAR(30) NULL,
ModifiedOn DATETIME NULL,
ModifiedHost NVARCHAR(20) NULL,
Status BIT NOT NULL CONSTRAINT DF_EncuestaMotivo_Status DEFAULT (1)
)
GO

ALTER TABLE dbo.EncuestaMotivo WITH CHECK ADD CONSTRAINT PK_EncuestaMotivo_Id PRIMARY KEY CLUSTERED (Id) ON [PRIMARY];
ALTER TABLE dbo.EncuestaMotivo ADD CONSTRAINT FK_EncuestaMotivo_EncuestaCalificacion_Id FOREIGN KEY (EncuestaCalificacionId) REFERENCES dbo.EncuestaCalificacion(Id);
GO

USE BelcorpPeru
GO
CREATE TABLE dbo.EncuestaMotivo(
Id INT IDENTITY(1,1) NOT NULL,
EncuestaCalificacionId INT NOT NULL,
TipoEncuestaMotivoId INT NOT NULL,
Descripcion NVARCHAR(60) NOT NULL,
CreatedBy NVARCHAR(30) NOT NULL,
CreatedOn DATETIME NOT NULL CONSTRAINT DF_EncuestaMotivo_CreatedOn DEFAULT (GETDATE()),
CreatedHost NVARCHAR(20) NULL,
ModifiedBy NVARCHAR(30) NULL,
ModifiedOn DATETIME NULL,
ModifiedHost NVARCHAR(20) NULL,
Status BIT NOT NULL CONSTRAINT DF_EncuestaMotivo_Status DEFAULT (1)
)
GO

ALTER TABLE dbo.EncuestaMotivo WITH CHECK ADD CONSTRAINT PK_EncuestaMotivo_Id PRIMARY KEY CLUSTERED (Id) ON [PRIMARY];
ALTER TABLE dbo.EncuestaMotivo ADD CONSTRAINT FK_EncuestaMotivo_EncuestaCalificacion_Id FOREIGN KEY (EncuestaCalificacionId) REFERENCES dbo.EncuestaCalificacion(Id);
GO

USE BelcorpPuertoRico
GO
CREATE TABLE dbo.EncuestaMotivo(
Id INT IDENTITY(1,1) NOT NULL,
EncuestaCalificacionId INT NOT NULL,
TipoEncuestaMotivoId INT NOT NULL,
Descripcion NVARCHAR(60) NOT NULL,
CreatedBy NVARCHAR(30) NOT NULL,
CreatedOn DATETIME NOT NULL CONSTRAINT DF_EncuestaMotivo_CreatedOn DEFAULT (GETDATE()),
CreatedHost NVARCHAR(20) NULL,
ModifiedBy NVARCHAR(30) NULL,
ModifiedOn DATETIME NULL,
ModifiedHost NVARCHAR(20) NULL,
Status BIT NOT NULL CONSTRAINT DF_EncuestaMotivo_Status DEFAULT (1)
)
GO

ALTER TABLE dbo.EncuestaMotivo WITH CHECK ADD CONSTRAINT PK_EncuestaMotivo_Id PRIMARY KEY CLUSTERED (Id) ON [PRIMARY];
ALTER TABLE dbo.EncuestaMotivo ADD CONSTRAINT FK_EncuestaMotivo_EncuestaCalificacion_Id FOREIGN KEY (EncuestaCalificacionId) REFERENCES dbo.EncuestaCalificacion(Id);
GO

USE BelcorpSalvador
GO
CREATE TABLE dbo.EncuestaMotivo(
Id INT IDENTITY(1,1) NOT NULL,
EncuestaCalificacionId INT NOT NULL,
TipoEncuestaMotivoId INT NOT NULL,
Descripcion NVARCHAR(60) NOT NULL,
CreatedBy NVARCHAR(30) NOT NULL,
CreatedOn DATETIME NOT NULL CONSTRAINT DF_EncuestaMotivo_CreatedOn DEFAULT (GETDATE()),
CreatedHost NVARCHAR(20) NULL,
ModifiedBy NVARCHAR(30) NULL,
ModifiedOn DATETIME NULL,
ModifiedHost NVARCHAR(20) NULL,
Status BIT NOT NULL CONSTRAINT DF_EncuestaMotivo_Status DEFAULT (1)
)
GO

ALTER TABLE dbo.EncuestaMotivo WITH CHECK ADD CONSTRAINT PK_EncuestaMotivo_Id PRIMARY KEY CLUSTERED (Id) ON [PRIMARY];
ALTER TABLE dbo.EncuestaMotivo ADD CONSTRAINT FK_EncuestaMotivo_EncuestaCalificacion_Id FOREIGN KEY (EncuestaCalificacionId) REFERENCES dbo.EncuestaCalificacion(Id);
GO



