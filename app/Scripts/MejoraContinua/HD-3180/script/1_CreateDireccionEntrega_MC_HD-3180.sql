USE BelcorpPeru
GO

IF (EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.TABLES 
                 WHERE TABLE_SCHEMA = 'dbo' 
                 AND  TABLE_NAME = 'DireccionEntrega'))
DROP TABLE [dbo].[DireccionEntrega]
GO
create table DireccionEntrega
(
 DireccionEntregaID int identity(1,1),
 ConsultoraID int not null,
 CampaniaID int not null,
 CampaniaAnteriorID int not null,
 Ubigeo1 int not null,
 Ubigeo2 int not null,
 Ubigeo3 int not null,
 Ubigeo1Anterior int not null,
 Ubigeo2Anterior int not null,
 Ubigeo3Anterior int not null,
 DireccionAnterior varchar(400) not null,
 Direccion varchar(400) not null,
 ZonaAnterior varchar(400) null,
 Zona varchar(400) null,
 Referencia varchar(400) null,
 CodigoConsultora varchar(20) not null,
 Latitud decimal(9,6) ,
 Longitud decimal(9,6) ,
 LatitudAnterior decimal(9,6) ,
 LongitudAnterior decimal(9,6) ,
 UltimafechaActualizacion Datetime null,
 CONSTRAINT PK_Person PRIMARY KEY (ConsultoraID,DireccionEntregaID)
)

GO

USE BelcorpMexico
GO

IF (EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.TABLES 
                 WHERE TABLE_SCHEMA = 'dbo' 
                 AND  TABLE_NAME = 'DireccionEntrega'))
DROP TABLE [dbo].[DireccionEntrega]
GO
create table DireccionEntrega
(
 DireccionEntregaID int identity(1,1),
 ConsultoraID int not null,
 CampaniaID int not null,
 CampaniaAnteriorID int not null,
 Ubigeo1 int not null,
 Ubigeo2 int not null,
 Ubigeo3 int not null,
 Ubigeo1Anterior int not null,
 Ubigeo2Anterior int not null,
 Ubigeo3Anterior int not null,
 DireccionAnterior varchar(400) not null,
 Direccion varchar(400) not null,
 ZonaAnterior varchar(400) null,
 Zona varchar(400) null,
 Referencia varchar(400) null,
 CodigoConsultora varchar(20) not null,
 Latitud decimal(9,6) ,
 Longitud decimal(9,6) ,
 LatitudAnterior decimal(9,6) ,
 LongitudAnterior decimal(9,6) ,
 UltimafechaActualizacion Datetime null,
 CONSTRAINT PK_Person PRIMARY KEY (ConsultoraID,DireccionEntregaID)
)

GO

USE BelcorpColombia
GO

IF (EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.TABLES 
                 WHERE TABLE_SCHEMA = 'dbo' 
                 AND  TABLE_NAME = 'DireccionEntrega'))
DROP TABLE [dbo].[DireccionEntrega]
GO
create table DireccionEntrega
(
 DireccionEntregaID int identity(1,1),
 ConsultoraID int not null,
 CampaniaID int not null,
 CampaniaAnteriorID int not null,
 Ubigeo1 int not null,
 Ubigeo2 int not null,
 Ubigeo3 int not null,
 Ubigeo1Anterior int not null,
 Ubigeo2Anterior int not null,
 Ubigeo3Anterior int not null,
 DireccionAnterior varchar(400) not null,
 Direccion varchar(400) not null,
 ZonaAnterior varchar(400) null,
 Zona varchar(400) null,
 Referencia varchar(400) null,
 CodigoConsultora varchar(20) not null,
 Latitud decimal(9,6) ,
 Longitud decimal(9,6) ,
 LatitudAnterior decimal(9,6) ,
 LongitudAnterior decimal(9,6) ,
 UltimafechaActualizacion Datetime null,
 CONSTRAINT PK_Person PRIMARY KEY (ConsultoraID,DireccionEntregaID)
)

GO

USE BelcorpSalvador
GO

IF (EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.TABLES 
                 WHERE TABLE_SCHEMA = 'dbo' 
                 AND  TABLE_NAME = 'DireccionEntrega'))
DROP TABLE [dbo].[DireccionEntrega]
GO
create table DireccionEntrega
(
 DireccionEntregaID int identity(1,1),
 ConsultoraID int not null,
 CampaniaID int not null,
 CampaniaAnteriorID int not null,
 Ubigeo1 int not null,
 Ubigeo2 int not null,
 Ubigeo3 int not null,
 Ubigeo1Anterior int not null,
 Ubigeo2Anterior int not null,
 Ubigeo3Anterior int not null,
 DireccionAnterior varchar(400) not null,
 Direccion varchar(400) not null,
 ZonaAnterior varchar(400) null,
 Zona varchar(400) null,
 Referencia varchar(400) null,
 CodigoConsultora varchar(20) not null,
 Latitud decimal(9,6) ,
 Longitud decimal(9,6) ,
 LatitudAnterior decimal(9,6) ,
 LongitudAnterior decimal(9,6) ,
 UltimafechaActualizacion Datetime null,
 CONSTRAINT PK_Person PRIMARY KEY (ConsultoraID,DireccionEntregaID)
)

GO

USE BelcorpPuertoRico
GO

IF (EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.TABLES 
                 WHERE TABLE_SCHEMA = 'dbo' 
                 AND  TABLE_NAME = 'DireccionEntrega'))
DROP TABLE [dbo].[DireccionEntrega]
GO
create table DireccionEntrega
(
 DireccionEntregaID int identity(1,1),
 ConsultoraID int not null,
 CampaniaID int not null,
 CampaniaAnteriorID int not null,
 Ubigeo1 int not null,
 Ubigeo2 int not null,
 Ubigeo3 int not null,
 Ubigeo1Anterior int not null,
 Ubigeo2Anterior int not null,
 Ubigeo3Anterior int not null,
 DireccionAnterior varchar(400) not null,
 Direccion varchar(400) not null,
 ZonaAnterior varchar(400) null,
 Zona varchar(400) null,
 Referencia varchar(400) null,
 CodigoConsultora varchar(20) not null,
 Latitud decimal(9,6) ,
 Longitud decimal(9,6) ,
 LatitudAnterior decimal(9,6) ,
 LongitudAnterior decimal(9,6) ,
 UltimafechaActualizacion Datetime null,
 CONSTRAINT PK_Person PRIMARY KEY (ConsultoraID,DireccionEntregaID)
)

GO

USE BelcorpPanama
GO

IF (EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.TABLES 
                 WHERE TABLE_SCHEMA = 'dbo' 
                 AND  TABLE_NAME = 'DireccionEntrega'))
DROP TABLE [dbo].[DireccionEntrega]
GO
create table DireccionEntrega
(
 DireccionEntregaID int identity(1,1),
 ConsultoraID int not null,
 CampaniaID int not null,
 CampaniaAnteriorID int not null,
 Ubigeo1 int not null,
 Ubigeo2 int not null,
 Ubigeo3 int not null,
 Ubigeo1Anterior int not null,
 Ubigeo2Anterior int not null,
 Ubigeo3Anterior int not null,
 DireccionAnterior varchar(400) not null,
 Direccion varchar(400) not null,
 ZonaAnterior varchar(400) null,
 Zona varchar(400) null,
 Referencia varchar(400) null,
 CodigoConsultora varchar(20) not null,
 Latitud decimal(9,6) ,
 Longitud decimal(9,6) ,
 LatitudAnterior decimal(9,6) ,
 LongitudAnterior decimal(9,6) ,
 UltimafechaActualizacion Datetime null,
 CONSTRAINT PK_Person PRIMARY KEY (ConsultoraID,DireccionEntregaID)
)

GO

USE BelcorpGuatemala
GO

IF (EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.TABLES 
                 WHERE TABLE_SCHEMA = 'dbo' 
                 AND  TABLE_NAME = 'DireccionEntrega'))
DROP TABLE [dbo].[DireccionEntrega]
GO
create table DireccionEntrega
(
 DireccionEntregaID int identity(1,1),
 ConsultoraID int not null,
 CampaniaID int not null,
 CampaniaAnteriorID int not null,
 Ubigeo1 int not null,
 Ubigeo2 int not null,
 Ubigeo3 int not null,
 Ubigeo1Anterior int not null,
 Ubigeo2Anterior int not null,
 Ubigeo3Anterior int not null,
 DireccionAnterior varchar(400) not null,
 Direccion varchar(400) not null,
 ZonaAnterior varchar(400) null,
 Zona varchar(400) null,
 Referencia varchar(400) null,
 CodigoConsultora varchar(20) not null,
 Latitud decimal(9,6) ,
 Longitud decimal(9,6) ,
 LatitudAnterior decimal(9,6) ,
 LongitudAnterior decimal(9,6) ,
 UltimafechaActualizacion Datetime null,
 CONSTRAINT PK_Person PRIMARY KEY (ConsultoraID,DireccionEntregaID)
)

GO

USE BelcorpEcuador
GO

IF (EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.TABLES 
                 WHERE TABLE_SCHEMA = 'dbo' 
                 AND  TABLE_NAME = 'DireccionEntrega'))
DROP TABLE [dbo].[DireccionEntrega]
GO
create table DireccionEntrega
(
 DireccionEntregaID int identity(1,1),
 ConsultoraID int not null,
 CampaniaID int not null,
 CampaniaAnteriorID int not null,
 Ubigeo1 int not null,
 Ubigeo2 int not null,
 Ubigeo3 int not null,
 Ubigeo1Anterior int not null,
 Ubigeo2Anterior int not null,
 Ubigeo3Anterior int not null,
 DireccionAnterior varchar(400) not null,
 Direccion varchar(400) not null,
 ZonaAnterior varchar(400) null,
 Zona varchar(400) null,
 Referencia varchar(400) null,
 CodigoConsultora varchar(20) not null,
 Latitud decimal(9,6) ,
 Longitud decimal(9,6) ,
 LatitudAnterior decimal(9,6) ,
 LongitudAnterior decimal(9,6) ,
 UltimafechaActualizacion Datetime null,
 CONSTRAINT PK_Person PRIMARY KEY (ConsultoraID,DireccionEntregaID)
)

GO

USE BelcorpDominicana
GO

IF (EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.TABLES 
                 WHERE TABLE_SCHEMA = 'dbo' 
                 AND  TABLE_NAME = 'DireccionEntrega'))
DROP TABLE [dbo].[DireccionEntrega]
GO
create table DireccionEntrega
(
 DireccionEntregaID int identity(1,1),
 ConsultoraID int not null,
 CampaniaID int not null,
 CampaniaAnteriorID int not null,
 Ubigeo1 int not null,
 Ubigeo2 int not null,
 Ubigeo3 int not null,
 Ubigeo1Anterior int not null,
 Ubigeo2Anterior int not null,
 Ubigeo3Anterior int not null,
 DireccionAnterior varchar(400) not null,
 Direccion varchar(400) not null,
 ZonaAnterior varchar(400) null,
 Zona varchar(400) null,
 Referencia varchar(400) null,
 CodigoConsultora varchar(20) not null,
 Latitud decimal(9,6) ,
 Longitud decimal(9,6) ,
 LatitudAnterior decimal(9,6) ,
 LongitudAnterior decimal(9,6) ,
 UltimafechaActualizacion Datetime null,
 CONSTRAINT PK_Person PRIMARY KEY (ConsultoraID,DireccionEntregaID)
)

GO

USE BelcorpCostaRica
GO

IF (EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.TABLES 
                 WHERE TABLE_SCHEMA = 'dbo' 
                 AND  TABLE_NAME = 'DireccionEntrega'))
DROP TABLE [dbo].[DireccionEntrega]
GO
create table DireccionEntrega
(
 DireccionEntregaID int identity(1,1),
 ConsultoraID int not null,
 CampaniaID int not null,
 CampaniaAnteriorID int not null,
 Ubigeo1 int not null,
 Ubigeo2 int not null,
 Ubigeo3 int not null,
 Ubigeo1Anterior int not null,
 Ubigeo2Anterior int not null,
 Ubigeo3Anterior int not null,
 DireccionAnterior varchar(400) not null,
 Direccion varchar(400) not null,
 ZonaAnterior varchar(400) null,
 Zona varchar(400) null,
 Referencia varchar(400) null,
 CodigoConsultora varchar(20) not null,
 Latitud decimal(9,6) ,
 Longitud decimal(9,6) ,
 LatitudAnterior decimal(9,6) ,
 LongitudAnterior decimal(9,6) ,
 UltimafechaActualizacion Datetime null,
 CONSTRAINT PK_Person PRIMARY KEY (ConsultoraID,DireccionEntregaID)
)

GO

USE BelcorpChile
GO

IF (EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.TABLES 
                 WHERE TABLE_SCHEMA = 'dbo' 
                 AND  TABLE_NAME = 'DireccionEntrega'))
DROP TABLE [dbo].[DireccionEntrega]
GO
create table DireccionEntrega
(
 DireccionEntregaID int identity(1,1),
 ConsultoraID int not null,
 CampaniaID int not null,
 CampaniaAnteriorID int not null,
 Ubigeo1 int not null,
 Ubigeo2 int not null,
 Ubigeo3 int not null,
 Ubigeo1Anterior int not null,
 Ubigeo2Anterior int not null,
 Ubigeo3Anterior int not null,
 DireccionAnterior varchar(400) not null,
 Direccion varchar(400) not null,
 ZonaAnterior varchar(400) null,
 Zona varchar(400) null,
 Referencia varchar(400) null,
 CodigoConsultora varchar(20) not null,
 Latitud decimal(9,6) ,
 Longitud decimal(9,6) ,
 LatitudAnterior decimal(9,6) ,
 LongitudAnterior decimal(9,6) ,
 UltimafechaActualizacion Datetime null,
 CONSTRAINT PK_Person PRIMARY KEY (ConsultoraID,DireccionEntregaID)
)

GO

USE BelcorpBolivia
GO

IF (EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.TABLES 
                 WHERE TABLE_SCHEMA = 'dbo' 
                 AND  TABLE_NAME = 'DireccionEntrega'))
DROP TABLE [dbo].[DireccionEntrega]
GO
create table DireccionEntrega
(
 DireccionEntregaID int identity(1,1),
 ConsultoraID int not null,
 CampaniaID int not null,
 CampaniaAnteriorID int not null,
 Ubigeo1 int not null,
 Ubigeo2 int not null,
 Ubigeo3 int not null,
 Ubigeo1Anterior int not null,
 Ubigeo2Anterior int not null,
 Ubigeo3Anterior int not null,
 DireccionAnterior varchar(400) not null,
 Direccion varchar(400) not null,
 ZonaAnterior varchar(400) null,
 Zona varchar(400) null,
 Referencia varchar(400) null,
 CodigoConsultora varchar(20) not null,
 Latitud decimal(9,6) ,
 Longitud decimal(9,6) ,
 LatitudAnterior decimal(9,6) ,
 LongitudAnterior decimal(9,6) ,
 UltimafechaActualizacion Datetime null,
 CONSTRAINT PK_Person PRIMARY KEY (ConsultoraID,DireccionEntregaID)
)

GO

