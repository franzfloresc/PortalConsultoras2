/*tablas*/

/*
Encuesta
Calificacion
Motivo

EncuestaResultado
DetalleEncunestaResultado

*/

USE BelcorpPeru_MC
go

IF EXISTS(SELECT * FROM sys.tables WHERE name = N'EncuestaResultadoDetalle' and schema_id = 1)
BEGIN

DROP TABLE dbo.EncuestaResultadoDetalle;

END

GO

IF EXISTS(SELECT * FROM sys.tables WHERE name = N'EncuestaResultado' and schema_id = 1)
BEGIN

DROP TABLE dbo.EncuestaResultado;

END
GO

IF EXISTS(SELECT * FROM sys.tables WHERE name = N'EncuestaMotivo' and schema_id = 1)
BEGIN

DROP TABLE dbo.EncuestaMotivo;

END
GO


IF EXISTS(SELECT * FROM sys.tables WHERE name = N'EncuestaCalificacion' and schema_id = 1)
BEGIN

DROP TABLE dbo.EncuestaCalificacion;

END
GO


IF EXISTS(SELECT * FROM sys.tables WHERE name = N'Encuesta' and schema_id = 1)
BEGIN

DROP TABLE dbo.Encuesta;

END
GO


CREATE TABLE dbo.Encuesta(
Id INT IDENTITY(1,1) NOT NULL,
Descripcion NVARCHAR(60) NOT NULL,
FechaDesde DATETIME NOT NULL,
FechaHasta DATETIME NOT NULL,
Prioridad INT NOT NULL,
CreatedBy NVARCHAR(30) NOT NULL,
CreatedOn DATETIME NOT NULL CONSTRAINT DF_Encuesta_CreatedOn DEFAULT (GETDATE()),
CreatedHost NVARCHAR(20) NULL,
ModifiedBy NVARCHAR(30) NULL,
ModifiedOn DATETIME NULL,
ModifiedHost NVARCHAR(20) NULL,
Status AS CASE WHEN FechaHasta > FechaDesde THEN 1 ELSE 0 END
)
GO

CREATE TABLE dbo.EncuestaCalificacion(
Id INT IDENTITY(1,1) NOT NULL,
EncuestaId INT NOT NULL,
Descripcion NVARCHAR(60) NOT NULL,
CssClass NVARCHAR(40) NULL,
Imagen NVARCHAR(20) NULL,
TipoCalificacion INT NOT NULL,
CreatedBy NVARCHAR(30) NOT NULL,
CreatedOn DATETIME NOT NULL CONSTRAINT DF_EncuestaCalificacion_CreatedOn DEFAULT (GETDATE()),
CreatedHost NVARCHAR(20) NULL,
ModifiedBy NVARCHAR(30) NULL,
ModifiedOn DATETIME NULL,
ModifiedHost NVARCHAR(20) NULL,
Status BIT NOT NULL CONSTRAINT DF_EncuestaCalificacion_Status DEFAULT (1)
)


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



CREATE TABLE dbo.EncuestaResultado(
Id uniqueidentifier NOT NULL,
EncuestaId INT NOT NULL,
CanalId INT NOT NULL,
CodigoCampania VARCHAR(6) NOT NULL,
CodigoConsultora NVARCHAR(25) NOT NULL,
CreatedBy NVARCHAR(30) NOT NULL,
CreatedOn DATETIME NOT NULL CONSTRAINT DF_EncuestaResultado_CreatedOn DEFAULT (GETDATE()),
CreatedHost NVARCHAR(20) NULL
)

CREATE TABLE dbo.EncuestaResultadoDetalle(
Id uniqueidentifier NOT NULL,
EncuestaResultadoId uniqueidentifier NOT NULL,

MotivoId INT NOT NULL,
Observacion NVARCHAR(MAX) NULL,
CreatedBy NVARCHAR(30) NOT NULL,
CreatedOn DATETIME NOT NULL CONSTRAINT DF_EncuestaResultadoDetalle_CreatedOn DEFAULT (GETDATE()),
CreatedHost NVARCHAR(20) NULL
)

--PK
ALTER TABLE dbo.Encuesta WITH CHECK ADD CONSTRAINT PK_Encuesta_Id PRIMARY KEY CLUSTERED (Id) ON [PRIMARY];
ALTER TABLE dbo.EncuestaCalificacion WITH CHECK ADD CONSTRAINT PK_EncuestaCalificacion_Id PRIMARY KEY CLUSTERED (Id) ON [PRIMARY];
ALTER TABLE dbo.EncuestaMotivo WITH CHECK ADD CONSTRAINT PK_EncuestaMotivo_Id PRIMARY KEY CLUSTERED (Id) ON [PRIMARY];
ALTER TABLE dbo.EncuestaResultado WITH CHECK ADD CONSTRAINT PK_EncuestaResultado_Id PRIMARY KEY CLUSTERED (Id) ON [PRIMARY];
ALTER TABLE dbo.EncuestaResultadoDetalle WITH CHECK ADD CONSTRAINT PK_EncuestaResultadoDetalle_Id PRIMARY KEY CLUSTERED (Id) ON [PRIMARY];

--FK

ALTER TABLE dbo.EncuestaCalificacion ADD CONSTRAINT FK_EncuestaCalificacion_Encuesta_Id FOREIGN KEY (EncuestaId) REFERENCES dbo.Encuesta(Id);
ALTER TABLE dbo.EncuestaMotivo ADD CONSTRAINT FK_EncuestaMotivo_EncuestaCalificacion_Id FOREIGN KEY (EncuestaCalificacionId) REFERENCES dbo.EncuestaCalificacion(Id);
ALTER TABLE dbo.EncuestaResultado ADD CONSTRAINT FK_EncuestaResultado_Encuesta_Id FOREIGN KEY (EncuestaId) REFERENCES dbo.Encuesta(Id);
ALTER TABLE dbo.EncuestaResultadoDetalle ADD CONSTRAINT FK_EncuestaResultadoDetalle_EncuestaResultado_Id FOREIGN KEY (EncuestaResultadoId) REFERENCES dbo.EncuestaResultado(Id);


--Insertar data

SET IDENTITY_INSERT [dbo].[Encuesta] ON 
INSERT [dbo].[Encuesta] ([Id], [Descripcion],[FechaDesde],[FechaHasta],[Prioridad], [CreatedBy]) VALUES (1, N'Encuesta de satisfacción de campaña',getdate(),GETDATE()+100,1, N'EINCA')
SET IDENTITY_INSERT [dbo].[Encuesta] OFF

--Mal	Regular	Bien	Muy bien	Excelente

SET IDENTITY_INSERT [dbo].[EncuestaCalificacion] ON 
INSERT [dbo].[EncuestaCalificacion] ([Id], [EncuestaId], [Descripcion], [CreatedBy],[TipoCalificacion],[CssClass],[Imagen]) VALUES (1, 1,'Pésimo', N'EINCA',1,'pesimo','pesimo.svg');
INSERT [dbo].[EncuestaCalificacion] ([Id], [EncuestaId], [Descripcion], [CreatedBy],[TipoCalificacion],[CssClass],[Imagen]) VALUES (2, 1,'Malo', N'EINCA',1,'malo','mal.svg');
INSERT [dbo].[EncuestaCalificacion] ([Id], [EncuestaId], [Descripcion], [CreatedBy],[TipoCalificacion],[CssClass],[Imagen]) VALUES (3, 1,'Regular', N'EINCA',1,'regular','regular.svg');
INSERT [dbo].[EncuestaCalificacion] ([Id], [EncuestaId], [Descripcion], [CreatedBy],[TipoCalificacion],[CssClass],[Imagen]) VALUES (4, 1,'Bueno', N'EINCA',1,'bueno','bueno.svg');
INSERT [dbo].[EncuestaCalificacion] ([Id], [EncuestaId], [Descripcion], [CreatedBy],[TipoCalificacion],[CssClass],[Imagen]) VALUES (5, 1,'Excelente', N'EINCA',2,'excelente','excelente.svg');
SET IDENTITY_INSERT [dbo].[EncuestaCalificacion] OFF

SET IDENTITY_INSERT [dbo].[EncuestaMotivo] ON 
INSERT [dbo].[EncuestaMotivo] ([Id], [EncuestaCalificacionId],[TipoEncuestaMotivoId], [Descripcion], [CreatedBy]) VALUES (1, 1,1,'Producto en mal estado', N'EINCA');
INSERT [dbo].[EncuestaMotivo] ([Id], [EncuestaCalificacionId],[TipoEncuestaMotivoId], [Descripcion], [CreatedBy]) VALUES (2, 1,1,'Reemplazaron productos', N'EINCA');
INSERT [dbo].[EncuestaMotivo] ([Id], [EncuestaCalificacionId],[TipoEncuestaMotivoId], [Descripcion], [CreatedBy]) VALUES (3, 1,1,'Premio en mal estado', N'EINCA');
INSERT [dbo].[EncuestaMotivo] ([Id], [EncuestaCalificacionId],[TipoEncuestaMotivoId], [Descripcion], [CreatedBy]) VALUES (4, 1,1,'No llegó el premio', N'EINCA');
INSERT [dbo].[EncuestaMotivo] ([Id], [EncuestaCalificacionId],[TipoEncuestaMotivoId], [Descripcion], [CreatedBy]) VALUES (5, 1,1,'Pedido Incompleto', N'EINCA');
INSERT [dbo].[EncuestaMotivo] ([Id], [EncuestaCalificacionId],[TipoEncuestaMotivoId], [Descripcion], [CreatedBy]) VALUES (6, 1,2,'Otro', N'EINCA');

INSERT [dbo].[EncuestaMotivo] ([Id], [EncuestaCalificacionId],[TipoEncuestaMotivoId], [Descripcion], [CreatedBy]) VALUES (7, 2,1,'Demora en la entraga', N'EINCA');
INSERT [dbo].[EncuestaMotivo] ([Id], [EncuestaCalificacionId],[TipoEncuestaMotivoId], [Descripcion], [CreatedBy]) VALUES (8, 2,1,'Demasioados alertas', N'EINCA');
INSERT [dbo].[EncuestaMotivo] ([Id], [EncuestaCalificacionId],[TipoEncuestaMotivoId], [Descripcion], [CreatedBy]) VALUES (9, 2,1,'Premio regular', N'EINCA');
INSERT [dbo].[EncuestaMotivo] ([Id], [EncuestaCalificacionId],[TipoEncuestaMotivoId], [Descripcion], [CreatedBy]) VALUES (10, 2,2,'Otro', N'EINCA');

INSERT [dbo].[EncuestaMotivo] ([Id], [EncuestaCalificacionId],[TipoEncuestaMotivoId], [Descripcion], [CreatedBy]) VALUES (11, 3,1,'Entrega completa', N'EINCA');
INSERT [dbo].[EncuestaMotivo] ([Id], [EncuestaCalificacionId],[TipoEncuestaMotivoId], [Descripcion], [CreatedBy]) VALUES (12, 3,1,'Demasioados alertas', N'EINCA');
INSERT [dbo].[EncuestaMotivo] ([Id], [EncuestaCalificacionId],[TipoEncuestaMotivoId], [Descripcion], [CreatedBy]) VALUES (13, 3,2,'Otro', N'EINCA');

INSERT [dbo].[EncuestaMotivo] ([Id], [EncuestaCalificacionId],[TipoEncuestaMotivoId], [Descripcion], [CreatedBy]) VALUES (14, 4,1,'Entrega puntual', N'EINCA');
INSERT [dbo].[EncuestaMotivo] ([Id], [EncuestaCalificacionId],[TipoEncuestaMotivoId], [Descripcion], [CreatedBy]) VALUES (15, 4,1,'Producto completo', N'EINCA');
INSERT [dbo].[EncuestaMotivo] ([Id], [EncuestaCalificacionId],[TipoEncuestaMotivoId], [Descripcion], [CreatedBy]) VALUES (16, 4,1,'Premio muy bueno', N'EINCA');
INSERT [dbo].[EncuestaMotivo] ([Id], [EncuestaCalificacionId],[TipoEncuestaMotivoId], [Descripcion], [CreatedBy]) VALUES (17, 4,2,'Otro', N'EINCA');

INSERT [dbo].[EncuestaMotivo] ([Id], [EncuestaCalificacionId],[TipoEncuestaMotivoId], [Descripcion], [CreatedBy]) VALUES (18, 5,3,'Sin motivo', N'EINCA');


SET IDENTITY_INSERT [dbo].[EncuestaMotivo] OFF

