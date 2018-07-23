GO
USE BelcorpPeru
GO
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'ValidacionDatos' AND TABLE_SCHEMA = 'dbo')
BEGIN
    DROP TABLE dbo.ValidacionDatos;
END
GO
CREATE TABLE dbo.ValidacionDatos(
	ValidacionID bigint identity(1,1) primary key,
	TipoEnvio varchar(15) not null,
	DatoAntiguo varchar(50) not null,
	DatoNuevo varchar(50) not null,
	CodigoUsuario varchar(20) not null,
	Estado char(1) not null,
	CampaniaActivacionEmail int,
	FechaCreacion datetime not null,
	UsuarioCreacion varchar(20) not null,
	FechaModificacion datetime null,
	UsuarioModificacion varchar(20) null
);

GO
USE BelcorpMexico
GO
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'ValidacionDatos' AND TABLE_SCHEMA = 'dbo')
BEGIN
    DROP TABLE dbo.ValidacionDatos;
END
GO
CREATE TABLE dbo.ValidacionDatos(
	ValidacionID bigint identity(1,1) primary key,
	TipoEnvio varchar(15) not null,
	DatoAntiguo varchar(50) not null,
	DatoNuevo varchar(50) not null,
	CodigoUsuario varchar(20) not null,
	Estado char(1) not null,
	CampaniaActivacionEmail int,
	FechaCreacion datetime not null,
	UsuarioCreacion varchar(20) not null,
	FechaModificacion datetime null,
	UsuarioModificacion varchar(20) null
);

GO
USE BelcorpColombia
GO
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'ValidacionDatos' AND TABLE_SCHEMA = 'dbo')
BEGIN
    DROP TABLE dbo.ValidacionDatos;
END
GO
CREATE TABLE dbo.ValidacionDatos(
	ValidacionID bigint identity(1,1) primary key,
	TipoEnvio varchar(15) not null,
	DatoAntiguo varchar(50) not null,
	DatoNuevo varchar(50) not null,
	CodigoUsuario varchar(20) not null,
	Estado char(1) not null,
	CampaniaActivacionEmail int,
	FechaCreacion datetime not null,
	UsuarioCreacion varchar(20) not null,
	FechaModificacion datetime null,
	UsuarioModificacion varchar(20) null
);

GO
USE BelcorpSalvador
GO
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'ValidacionDatos' AND TABLE_SCHEMA = 'dbo')
BEGIN
    DROP TABLE dbo.ValidacionDatos;
END
GO
CREATE TABLE dbo.ValidacionDatos(
	ValidacionID bigint identity(1,1) primary key,
	TipoEnvio varchar(15) not null,
	DatoAntiguo varchar(50) not null,
	DatoNuevo varchar(50) not null,
	CodigoUsuario varchar(20) not null,
	Estado char(1) not null,
	CampaniaActivacionEmail int,
	FechaCreacion datetime not null,
	UsuarioCreacion varchar(20) not null,
	FechaModificacion datetime null,
	UsuarioModificacion varchar(20) null
);

GO
USE BelcorpPuertoRico
GO
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'ValidacionDatos' AND TABLE_SCHEMA = 'dbo')
BEGIN
    DROP TABLE dbo.ValidacionDatos;
END
GO
CREATE TABLE dbo.ValidacionDatos(
	ValidacionID bigint identity(1,1) primary key,
	TipoEnvio varchar(15) not null,
	DatoAntiguo varchar(50) not null,
	DatoNuevo varchar(50) not null,
	CodigoUsuario varchar(20) not null,
	Estado char(1) not null,
	CampaniaActivacionEmail int,
	FechaCreacion datetime not null,
	UsuarioCreacion varchar(20) not null,
	FechaModificacion datetime null,
	UsuarioModificacion varchar(20) null
);

GO
USE BelcorpPanama
GO
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'ValidacionDatos' AND TABLE_SCHEMA = 'dbo')
BEGIN
    DROP TABLE dbo.ValidacionDatos;
END
GO
CREATE TABLE dbo.ValidacionDatos(
	ValidacionID bigint identity(1,1) primary key,
	TipoEnvio varchar(15) not null,
	DatoAntiguo varchar(50) not null,
	DatoNuevo varchar(50) not null,
	CodigoUsuario varchar(20) not null,
	Estado char(1) not null,
	CampaniaActivacionEmail int,
	FechaCreacion datetime not null,
	UsuarioCreacion varchar(20) not null,
	FechaModificacion datetime null,
	UsuarioModificacion varchar(20) null
);

GO
USE BelcorpGuatemala
GO
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'ValidacionDatos' AND TABLE_SCHEMA = 'dbo')
BEGIN
    DROP TABLE dbo.ValidacionDatos;
END
GO
CREATE TABLE dbo.ValidacionDatos(
	ValidacionID bigint identity(1,1) primary key,
	TipoEnvio varchar(15) not null,
	DatoAntiguo varchar(50) not null,
	DatoNuevo varchar(50) not null,
	CodigoUsuario varchar(20) not null,
	Estado char(1) not null,
	CampaniaActivacionEmail int,
	FechaCreacion datetime not null,
	UsuarioCreacion varchar(20) not null,
	FechaModificacion datetime null,
	UsuarioModificacion varchar(20) null
);

GO
USE BelcorpEcuador
GO
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'ValidacionDatos' AND TABLE_SCHEMA = 'dbo')
BEGIN
    DROP TABLE dbo.ValidacionDatos;
END
GO
CREATE TABLE dbo.ValidacionDatos(
	ValidacionID bigint identity(1,1) primary key,
	TipoEnvio varchar(15) not null,
	DatoAntiguo varchar(50) not null,
	DatoNuevo varchar(50) not null,
	CodigoUsuario varchar(20) not null,
	Estado char(1) not null,
	CampaniaActivacionEmail int,
	FechaCreacion datetime not null,
	UsuarioCreacion varchar(20) not null,
	FechaModificacion datetime null,
	UsuarioModificacion varchar(20) null
);

GO
USE BelcorpDominicana
GO
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'ValidacionDatos' AND TABLE_SCHEMA = 'dbo')
BEGIN
    DROP TABLE dbo.ValidacionDatos;
END
GO
CREATE TABLE dbo.ValidacionDatos(
	ValidacionID bigint identity(1,1) primary key,
	TipoEnvio varchar(15) not null,
	DatoAntiguo varchar(50) not null,
	DatoNuevo varchar(50) not null,
	CodigoUsuario varchar(20) not null,
	Estado char(1) not null,
	CampaniaActivacionEmail int,
	FechaCreacion datetime not null,
	UsuarioCreacion varchar(20) not null,
	FechaModificacion datetime null,
	UsuarioModificacion varchar(20) null
);

GO
USE BelcorpCostaRica
GO
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'ValidacionDatos' AND TABLE_SCHEMA = 'dbo')
BEGIN
    DROP TABLE dbo.ValidacionDatos;
END
GO
CREATE TABLE dbo.ValidacionDatos(
	ValidacionID bigint identity(1,1) primary key,
	TipoEnvio varchar(15) not null,
	DatoAntiguo varchar(50) not null,
	DatoNuevo varchar(50) not null,
	CodigoUsuario varchar(20) not null,
	Estado char(1) not null,
	CampaniaActivacionEmail int,
	FechaCreacion datetime not null,
	UsuarioCreacion varchar(20) not null,
	FechaModificacion datetime null,
	UsuarioModificacion varchar(20) null
);

GO
USE BelcorpChile
GO
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'ValidacionDatos' AND TABLE_SCHEMA = 'dbo')
BEGIN
    DROP TABLE dbo.ValidacionDatos;
END
GO
CREATE TABLE dbo.ValidacionDatos(
	ValidacionID bigint identity(1,1) primary key,
	TipoEnvio varchar(15) not null,
	DatoAntiguo varchar(50) not null,
	DatoNuevo varchar(50) not null,
	CodigoUsuario varchar(20) not null,
	Estado char(1) not null,
	CampaniaActivacionEmail int,
	FechaCreacion datetime not null,
	UsuarioCreacion varchar(20) not null,
	FechaModificacion datetime null,
	UsuarioModificacion varchar(20) null
);

GO
USE BelcorpBolivia
GO
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'ValidacionDatos' AND TABLE_SCHEMA = 'dbo')
BEGIN
    DROP TABLE dbo.ValidacionDatos;
END
GO
CREATE TABLE dbo.ValidacionDatos(
	ValidacionID bigint identity(1,1) primary key,
	TipoEnvio varchar(15) not null,
	DatoAntiguo varchar(50) not null,
	DatoNuevo varchar(50) not null,
	CodigoUsuario varchar(20) not null,
	Estado char(1) not null,
	CampaniaActivacionEmail int,
	FechaCreacion datetime not null,
	UsuarioCreacion varchar(20) not null,
	FechaModificacion datetime null,
	UsuarioModificacion varchar(20) null
);

GO
