USE BelcorpBolivia
GO
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'EncuestaCalificacion' and schema_id = 1)
BEGIN

DROP TABLE dbo.EncuestaCalificacion;

END
GO

CREATE TABLE dbo.EncuestaCalificacion(
Id INT IDENTITY(1,1) NOT NULL,
EncuestaId INT NOT NULL,
Descripcion NVARCHAR(60) NOT NULL,
CssClass NVARCHAR(40) NULL,
Imagen NVARCHAR(20) NULL,
TipoCalificacion INT NOT NULL,
PreguntaDescripcion NVARCHAR(120) NOT NULL,
CreatedBy NVARCHAR(30) NOT NULL,
CreatedOn DATETIME NOT NULL CONSTRAINT DF_EncuestaCalificacion_CreatedOn DEFAULT (GETDATE()),
CreatedHost NVARCHAR(20) NULL,
ModifiedBy NVARCHAR(30) NULL,
ModifiedOn DATETIME NULL,
ModifiedHost NVARCHAR(20) NULL,
Status BIT NOT NULL CONSTRAINT DF_EncuestaCalificacion_Status DEFAULT (1)
)

GO

ALTER TABLE dbo.EncuestaCalificacion WITH CHECK ADD CONSTRAINT PK_EncuestaCalificacion_Id PRIMARY KEY CLUSTERED (Id) ON [PRIMARY];
ALTER TABLE dbo.EncuestaCalificacion ADD CONSTRAINT FK_EncuestaCalificacion_Encuesta_Id FOREIGN KEY (EncuestaId) REFERENCES dbo.Encuesta(Id);


GO

USE BelcorpChile
GO
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'EncuestaCalificacion' and schema_id = 1)
BEGIN

DROP TABLE dbo.EncuestaCalificacion;

END
GO

CREATE TABLE dbo.EncuestaCalificacion(
Id INT IDENTITY(1,1) NOT NULL,
EncuestaId INT NOT NULL,
Descripcion NVARCHAR(60) NOT NULL,
CssClass NVARCHAR(40) NULL,
Imagen NVARCHAR(20) NULL,
TipoCalificacion INT NOT NULL,
PreguntaDescripcion NVARCHAR(120) NOT NULL,
CreatedBy NVARCHAR(30) NOT NULL,
CreatedOn DATETIME NOT NULL CONSTRAINT DF_EncuestaCalificacion_CreatedOn DEFAULT (GETDATE()),
CreatedHost NVARCHAR(20) NULL,
ModifiedBy NVARCHAR(30) NULL,
ModifiedOn DATETIME NULL,
ModifiedHost NVARCHAR(20) NULL,
Status BIT NOT NULL CONSTRAINT DF_EncuestaCalificacion_Status DEFAULT (1)
)

GO

ALTER TABLE dbo.EncuestaCalificacion WITH CHECK ADD CONSTRAINT PK_EncuestaCalificacion_Id PRIMARY KEY CLUSTERED (Id) ON [PRIMARY];
ALTER TABLE dbo.EncuestaCalificacion ADD CONSTRAINT FK_EncuestaCalificacion_Encuesta_Id FOREIGN KEY (EncuestaId) REFERENCES dbo.Encuesta(Id);


GO

USE BelcorpColombia
GO
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'EncuestaCalificacion' and schema_id = 1)
BEGIN

DROP TABLE dbo.EncuestaCalificacion;

END
GO

CREATE TABLE dbo.EncuestaCalificacion(
Id INT IDENTITY(1,1) NOT NULL,
EncuestaId INT NOT NULL,
Descripcion NVARCHAR(60) NOT NULL,
CssClass NVARCHAR(40) NULL,
Imagen NVARCHAR(20) NULL,
TipoCalificacion INT NOT NULL,
PreguntaDescripcion NVARCHAR(120) NOT NULL,
CreatedBy NVARCHAR(30) NOT NULL,
CreatedOn DATETIME NOT NULL CONSTRAINT DF_EncuestaCalificacion_CreatedOn DEFAULT (GETDATE()),
CreatedHost NVARCHAR(20) NULL,
ModifiedBy NVARCHAR(30) NULL,
ModifiedOn DATETIME NULL,
ModifiedHost NVARCHAR(20) NULL,
Status BIT NOT NULL CONSTRAINT DF_EncuestaCalificacion_Status DEFAULT (1)
)

GO

ALTER TABLE dbo.EncuestaCalificacion WITH CHECK ADD CONSTRAINT PK_EncuestaCalificacion_Id PRIMARY KEY CLUSTERED (Id) ON [PRIMARY];
ALTER TABLE dbo.EncuestaCalificacion ADD CONSTRAINT FK_EncuestaCalificacion_Encuesta_Id FOREIGN KEY (EncuestaId) REFERENCES dbo.Encuesta(Id);


GO
	
USE BelcorpCostaRica
GO
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'EncuestaCalificacion' and schema_id = 1)
BEGIN

DROP TABLE dbo.EncuestaCalificacion;

END
GO

CREATE TABLE dbo.EncuestaCalificacion(
Id INT IDENTITY(1,1) NOT NULL,
EncuestaId INT NOT NULL,
Descripcion NVARCHAR(60) NOT NULL,
CssClass NVARCHAR(40) NULL,
Imagen NVARCHAR(20) NULL,
TipoCalificacion INT NOT NULL,
PreguntaDescripcion NVARCHAR(120) NOT NULL,
CreatedBy NVARCHAR(30) NOT NULL,
CreatedOn DATETIME NOT NULL CONSTRAINT DF_EncuestaCalificacion_CreatedOn DEFAULT (GETDATE()),
CreatedHost NVARCHAR(20) NULL,
ModifiedBy NVARCHAR(30) NULL,
ModifiedOn DATETIME NULL,
ModifiedHost NVARCHAR(20) NULL,
Status BIT NOT NULL CONSTRAINT DF_EncuestaCalificacion_Status DEFAULT (1)
)

GO

ALTER TABLE dbo.EncuestaCalificacion WITH CHECK ADD CONSTRAINT PK_EncuestaCalificacion_Id PRIMARY KEY CLUSTERED (Id) ON [PRIMARY];
ALTER TABLE dbo.EncuestaCalificacion ADD CONSTRAINT FK_EncuestaCalificacion_Encuesta_Id FOREIGN KEY (EncuestaId) REFERENCES dbo.Encuesta(Id);


GO

USE BelcorpDominicana
GO
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'EncuestaCalificacion' and schema_id = 1)
BEGIN

DROP TABLE dbo.EncuestaCalificacion;

END
GO

CREATE TABLE dbo.EncuestaCalificacion(
Id INT IDENTITY(1,1) NOT NULL,
EncuestaId INT NOT NULL,
Descripcion NVARCHAR(60) NOT NULL,
CssClass NVARCHAR(40) NULL,
Imagen NVARCHAR(20) NULL,
TipoCalificacion INT NOT NULL,
PreguntaDescripcion NVARCHAR(120) NOT NULL,
CreatedBy NVARCHAR(30) NOT NULL,
CreatedOn DATETIME NOT NULL CONSTRAINT DF_EncuestaCalificacion_CreatedOn DEFAULT (GETDATE()),
CreatedHost NVARCHAR(20) NULL,
ModifiedBy NVARCHAR(30) NULL,
ModifiedOn DATETIME NULL,
ModifiedHost NVARCHAR(20) NULL,
Status BIT NOT NULL CONSTRAINT DF_EncuestaCalificacion_Status DEFAULT (1)
)

GO

ALTER TABLE dbo.EncuestaCalificacion WITH CHECK ADD CONSTRAINT PK_EncuestaCalificacion_Id PRIMARY KEY CLUSTERED (Id) ON [PRIMARY];
ALTER TABLE dbo.EncuestaCalificacion ADD CONSTRAINT FK_EncuestaCalificacion_Encuesta_Id FOREIGN KEY (EncuestaId) REFERENCES dbo.Encuesta(Id);


GO

USE BelcorpEcuador
GO
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'EncuestaCalificacion' and schema_id = 1)
BEGIN

DROP TABLE dbo.EncuestaCalificacion;

END
GO

CREATE TABLE dbo.EncuestaCalificacion(
Id INT IDENTITY(1,1) NOT NULL,
EncuestaId INT NOT NULL,
Descripcion NVARCHAR(60) NOT NULL,
CssClass NVARCHAR(40) NULL,
Imagen NVARCHAR(20) NULL,
TipoCalificacion INT NOT NULL,
PreguntaDescripcion NVARCHAR(120) NOT NULL,
CreatedBy NVARCHAR(30) NOT NULL,
CreatedOn DATETIME NOT NULL CONSTRAINT DF_EncuestaCalificacion_CreatedOn DEFAULT (GETDATE()),
CreatedHost NVARCHAR(20) NULL,
ModifiedBy NVARCHAR(30) NULL,
ModifiedOn DATETIME NULL,
ModifiedHost NVARCHAR(20) NULL,
Status BIT NOT NULL CONSTRAINT DF_EncuestaCalificacion_Status DEFAULT (1)
)

GO

ALTER TABLE dbo.EncuestaCalificacion WITH CHECK ADD CONSTRAINT PK_EncuestaCalificacion_Id PRIMARY KEY CLUSTERED (Id) ON [PRIMARY];
ALTER TABLE dbo.EncuestaCalificacion ADD CONSTRAINT FK_EncuestaCalificacion_Encuesta_Id FOREIGN KEY (EncuestaId) REFERENCES dbo.Encuesta(Id);


GO

USE BelcorpGuatemala
GO
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'EncuestaCalificacion' and schema_id = 1)
BEGIN

DROP TABLE dbo.EncuestaCalificacion;

END
GO

CREATE TABLE dbo.EncuestaCalificacion(
Id INT IDENTITY(1,1) NOT NULL,
EncuestaId INT NOT NULL,
Descripcion NVARCHAR(60) NOT NULL,
CssClass NVARCHAR(40) NULL,
Imagen NVARCHAR(20) NULL,
TipoCalificacion INT NOT NULL,
PreguntaDescripcion NVARCHAR(120) NOT NULL,
CreatedBy NVARCHAR(30) NOT NULL,
CreatedOn DATETIME NOT NULL CONSTRAINT DF_EncuestaCalificacion_CreatedOn DEFAULT (GETDATE()),
CreatedHost NVARCHAR(20) NULL,
ModifiedBy NVARCHAR(30) NULL,
ModifiedOn DATETIME NULL,
ModifiedHost NVARCHAR(20) NULL,
Status BIT NOT NULL CONSTRAINT DF_EncuestaCalificacion_Status DEFAULT (1)
)

GO

ALTER TABLE dbo.EncuestaCalificacion WITH CHECK ADD CONSTRAINT PK_EncuestaCalificacion_Id PRIMARY KEY CLUSTERED (Id) ON [PRIMARY];
ALTER TABLE dbo.EncuestaCalificacion ADD CONSTRAINT FK_EncuestaCalificacion_Encuesta_Id FOREIGN KEY (EncuestaId) REFERENCES dbo.Encuesta(Id);


GO

USE BelcorpMexico
GO
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'EncuestaCalificacion' and schema_id = 1)
BEGIN

DROP TABLE dbo.EncuestaCalificacion;

END
GO

CREATE TABLE dbo.EncuestaCalificacion(
Id INT IDENTITY(1,1) NOT NULL,
EncuestaId INT NOT NULL,
Descripcion NVARCHAR(60) NOT NULL,
CssClass NVARCHAR(40) NULL,
Imagen NVARCHAR(20) NULL,
TipoCalificacion INT NOT NULL,
PreguntaDescripcion NVARCHAR(120) NOT NULL,
CreatedBy NVARCHAR(30) NOT NULL,
CreatedOn DATETIME NOT NULL CONSTRAINT DF_EncuestaCalificacion_CreatedOn DEFAULT (GETDATE()),
CreatedHost NVARCHAR(20) NULL,
ModifiedBy NVARCHAR(30) NULL,
ModifiedOn DATETIME NULL,
ModifiedHost NVARCHAR(20) NULL,
Status BIT NOT NULL CONSTRAINT DF_EncuestaCalificacion_Status DEFAULT (1)
)

GO

ALTER TABLE dbo.EncuestaCalificacion WITH CHECK ADD CONSTRAINT PK_EncuestaCalificacion_Id PRIMARY KEY CLUSTERED (Id) ON [PRIMARY];
ALTER TABLE dbo.EncuestaCalificacion ADD CONSTRAINT FK_EncuestaCalificacion_Encuesta_Id FOREIGN KEY (EncuestaId) REFERENCES dbo.Encuesta(Id);


GO

USE BelcorpPanama
GO
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'EncuestaCalificacion' and schema_id = 1)
BEGIN

DROP TABLE dbo.EncuestaCalificacion;

END
GO

CREATE TABLE dbo.EncuestaCalificacion(
Id INT IDENTITY(1,1) NOT NULL,
EncuestaId INT NOT NULL,
Descripcion NVARCHAR(60) NOT NULL,
CssClass NVARCHAR(40) NULL,
Imagen NVARCHAR(20) NULL,
TipoCalificacion INT NOT NULL,
PreguntaDescripcion NVARCHAR(120) NOT NULL,
CreatedBy NVARCHAR(30) NOT NULL,
CreatedOn DATETIME NOT NULL CONSTRAINT DF_EncuestaCalificacion_CreatedOn DEFAULT (GETDATE()),
CreatedHost NVARCHAR(20) NULL,
ModifiedBy NVARCHAR(30) NULL,
ModifiedOn DATETIME NULL,
ModifiedHost NVARCHAR(20) NULL,
Status BIT NOT NULL CONSTRAINT DF_EncuestaCalificacion_Status DEFAULT (1)
)

GO

ALTER TABLE dbo.EncuestaCalificacion WITH CHECK ADD CONSTRAINT PK_EncuestaCalificacion_Id PRIMARY KEY CLUSTERED (Id) ON [PRIMARY];
ALTER TABLE dbo.EncuestaCalificacion ADD CONSTRAINT FK_EncuestaCalificacion_Encuesta_Id FOREIGN KEY (EncuestaId) REFERENCES dbo.Encuesta(Id);


GO

USE BelcorpPeru
GO
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'EncuestaCalificacion' and schema_id = 1)
BEGIN

DROP TABLE dbo.EncuestaCalificacion;

END
GO

CREATE TABLE dbo.EncuestaCalificacion(
Id INT IDENTITY(1,1) NOT NULL,
EncuestaId INT NOT NULL,
Descripcion NVARCHAR(60) NOT NULL,
CssClass NVARCHAR(40) NULL,
Imagen NVARCHAR(20) NULL,
TipoCalificacion INT NOT NULL,
PreguntaDescripcion NVARCHAR(120) NOT NULL,
CreatedBy NVARCHAR(30) NOT NULL,
CreatedOn DATETIME NOT NULL CONSTRAINT DF_EncuestaCalificacion_CreatedOn DEFAULT (GETDATE()),
CreatedHost NVARCHAR(20) NULL,
ModifiedBy NVARCHAR(30) NULL,
ModifiedOn DATETIME NULL,
ModifiedHost NVARCHAR(20) NULL,
Status BIT NOT NULL CONSTRAINT DF_EncuestaCalificacion_Status DEFAULT (1)
)

GO

ALTER TABLE dbo.EncuestaCalificacion WITH CHECK ADD CONSTRAINT PK_EncuestaCalificacion_Id PRIMARY KEY CLUSTERED (Id) ON [PRIMARY];
ALTER TABLE dbo.EncuestaCalificacion ADD CONSTRAINT FK_EncuestaCalificacion_Encuesta_Id FOREIGN KEY (EncuestaId) REFERENCES dbo.Encuesta(Id);


GO

USE BelcorpPuertoRico
GO
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'EncuestaCalificacion' and schema_id = 1)
BEGIN

DROP TABLE dbo.EncuestaCalificacion;

END
GO

CREATE TABLE dbo.EncuestaCalificacion(
Id INT IDENTITY(1,1) NOT NULL,
EncuestaId INT NOT NULL,
Descripcion NVARCHAR(60) NOT NULL,
CssClass NVARCHAR(40) NULL,
Imagen NVARCHAR(20) NULL,
TipoCalificacion INT NOT NULL,
PreguntaDescripcion NVARCHAR(120) NOT NULL,
CreatedBy NVARCHAR(30) NOT NULL,
CreatedOn DATETIME NOT NULL CONSTRAINT DF_EncuestaCalificacion_CreatedOn DEFAULT (GETDATE()),
CreatedHost NVARCHAR(20) NULL,
ModifiedBy NVARCHAR(30) NULL,
ModifiedOn DATETIME NULL,
ModifiedHost NVARCHAR(20) NULL,
Status BIT NOT NULL CONSTRAINT DF_EncuestaCalificacion_Status DEFAULT (1)
)

GO

ALTER TABLE dbo.EncuestaCalificacion WITH CHECK ADD CONSTRAINT PK_EncuestaCalificacion_Id PRIMARY KEY CLUSTERED (Id) ON [PRIMARY];
ALTER TABLE dbo.EncuestaCalificacion ADD CONSTRAINT FK_EncuestaCalificacion_Encuesta_Id FOREIGN KEY (EncuestaId) REFERENCES dbo.Encuesta(Id);


GO

USE BelcorpSalvador
GO
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'EncuestaCalificacion' and schema_id = 1)
BEGIN

DROP TABLE dbo.EncuestaCalificacion;

END
GO

CREATE TABLE dbo.EncuestaCalificacion(
Id INT IDENTITY(1,1) NOT NULL,
EncuestaId INT NOT NULL,
Descripcion NVARCHAR(60) NOT NULL,
CssClass NVARCHAR(40) NULL,
Imagen NVARCHAR(20) NULL,
TipoCalificacion INT NOT NULL,
PreguntaDescripcion NVARCHAR(120) NOT NULL,
CreatedBy NVARCHAR(30) NOT NULL,
CreatedOn DATETIME NOT NULL CONSTRAINT DF_EncuestaCalificacion_CreatedOn DEFAULT (GETDATE()),
CreatedHost NVARCHAR(20) NULL,
ModifiedBy NVARCHAR(30) NULL,
ModifiedOn DATETIME NULL,
ModifiedHost NVARCHAR(20) NULL,
Status BIT NOT NULL CONSTRAINT DF_EncuestaCalificacion_Status DEFAULT (1)
)

GO

ALTER TABLE dbo.EncuestaCalificacion WITH CHECK ADD CONSTRAINT PK_EncuestaCalificacion_Id PRIMARY KEY CLUSTERED (Id) ON [PRIMARY];
ALTER TABLE dbo.EncuestaCalificacion ADD CONSTRAINT FK_EncuestaCalificacion_Encuesta_Id FOREIGN KEY (EncuestaId) REFERENCES dbo.Encuesta(Id);


GO


