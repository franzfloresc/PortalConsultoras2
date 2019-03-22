USE BelcorpPeru
GO

If Not Exists(select 1 from SYSOBJECTS where type = 'U' and id = OBJECT_ID('dbo.BeneficioCaminoBrillante'))
Begin
	CREATE TABLE BeneficioCaminoBrillante (
		BeneficioID int Identity,
		CodigoNivel varchar(3), 
		CodigoBeneficio varchar(15) NOT NULL,
		NombreBeneficio varchar(100) NOT NULL,
		Descripcion varchar(300) NULL,
		UrlIcono varchar(500) NULL,
		FechaRegistro datetime NOT NULL,
		FechaActualizacion datetime NULL	
		PRIMARY KEY (BeneficioID, CodigoBeneficio)
	)
end
GO

USE BelcorpMexico
GO

If Not Exists(select 1 from SYSOBJECTS where type = 'U' and id = OBJECT_ID('dbo.BeneficioCaminoBrillante'))
Begin
	CREATE TABLE BeneficioCaminoBrillante (
		BeneficioID int Identity,
		CodigoNivel varchar(3), 
		CodigoBeneficio varchar(15) NOT NULL,
		NombreBeneficio varchar(100) NOT NULL,
		Descripcion varchar(300) NULL,
		UrlIcono varchar(500) NULL,
		FechaRegistro datetime NOT NULL,
		FechaActualizacion datetime NULL	
		PRIMARY KEY (BeneficioID, CodigoBeneficio)
	)
end
GO

USE BelcorpColombia
GO

If Not Exists(select 1 from SYSOBJECTS where type = 'U' and id = OBJECT_ID('dbo.BeneficioCaminoBrillante'))
Begin
	CREATE TABLE BeneficioCaminoBrillante (
		BeneficioID int Identity,
		CodigoNivel varchar(3), 
		CodigoBeneficio varchar(15) NOT NULL,
		NombreBeneficio varchar(100) NOT NULL,
		Descripcion varchar(300) NULL,
		UrlIcono varchar(500) NULL,
		FechaRegistro datetime NOT NULL,
		FechaActualizacion datetime NULL	
		PRIMARY KEY (BeneficioID, CodigoBeneficio)
	)
end
GO

USE BelcorpSalvador
GO

If Not Exists(select 1 from SYSOBJECTS where type = 'U' and id = OBJECT_ID('dbo.BeneficioCaminoBrillante'))
Begin
	CREATE TABLE BeneficioCaminoBrillante (
		BeneficioID int Identity,
		CodigoNivel varchar(3), 
		CodigoBeneficio varchar(15) NOT NULL,
		NombreBeneficio varchar(100) NOT NULL,
		Descripcion varchar(300) NULL,
		UrlIcono varchar(500) NULL,
		FechaRegistro datetime NOT NULL,
		FechaActualizacion datetime NULL	
		PRIMARY KEY (BeneficioID, CodigoBeneficio)
	)
end
GO

USE BelcorpPuertoRico
GO

If Not Exists(select 1 from SYSOBJECTS where type = 'U' and id = OBJECT_ID('dbo.BeneficioCaminoBrillante'))
Begin
	CREATE TABLE BeneficioCaminoBrillante (
		BeneficioID int Identity,
		CodigoNivel varchar(3), 
		CodigoBeneficio varchar(15) NOT NULL,
		NombreBeneficio varchar(100) NOT NULL,
		Descripcion varchar(300) NULL,
		UrlIcono varchar(500) NULL,
		FechaRegistro datetime NOT NULL,
		FechaActualizacion datetime NULL	
		PRIMARY KEY (BeneficioID, CodigoBeneficio)
	)
end
GO

USE BelcorpPanama
GO

If Not Exists(select 1 from SYSOBJECTS where type = 'U' and id = OBJECT_ID('dbo.BeneficioCaminoBrillante'))
Begin
	CREATE TABLE BeneficioCaminoBrillante (
		BeneficioID int Identity,
		CodigoNivel varchar(3), 
		CodigoBeneficio varchar(15) NOT NULL,
		NombreBeneficio varchar(100) NOT NULL,
		Descripcion varchar(300) NULL,
		UrlIcono varchar(500) NULL,
		FechaRegistro datetime NOT NULL,
		FechaActualizacion datetime NULL	
		PRIMARY KEY (BeneficioID, CodigoBeneficio)
	)
end
GO

USE BelcorpGuatemala
GO

If Not Exists(select 1 from SYSOBJECTS where type = 'U' and id = OBJECT_ID('dbo.BeneficioCaminoBrillante'))
Begin
	CREATE TABLE BeneficioCaminoBrillante (
		BeneficioID int Identity,
		CodigoNivel varchar(3), 
		CodigoBeneficio varchar(15) NOT NULL,
		NombreBeneficio varchar(100) NOT NULL,
		Descripcion varchar(300) NULL,
		UrlIcono varchar(500) NULL,
		FechaRegistro datetime NOT NULL,
		FechaActualizacion datetime NULL	
		PRIMARY KEY (BeneficioID, CodigoBeneficio)
	)
end
GO

USE BelcorpEcuador
GO

If Not Exists(select 1 from SYSOBJECTS where type = 'U' and id = OBJECT_ID('dbo.BeneficioCaminoBrillante'))
Begin
	CREATE TABLE BeneficioCaminoBrillante (
		BeneficioID int Identity,
		CodigoNivel varchar(3), 
		CodigoBeneficio varchar(15) NOT NULL,
		NombreBeneficio varchar(100) NOT NULL,
		Descripcion varchar(300) NULL,
		UrlIcono varchar(500) NULL,
		FechaRegistro datetime NOT NULL,
		FechaActualizacion datetime NULL	
		PRIMARY KEY (BeneficioID, CodigoBeneficio)
	)
end
GO

USE BelcorpDominicana
GO

If Not Exists(select 1 from SYSOBJECTS where type = 'U' and id = OBJECT_ID('dbo.BeneficioCaminoBrillante'))
Begin
	CREATE TABLE BeneficioCaminoBrillante (
		BeneficioID int Identity,
		CodigoNivel varchar(3), 
		CodigoBeneficio varchar(15) NOT NULL,
		NombreBeneficio varchar(100) NOT NULL,
		Descripcion varchar(300) NULL,
		UrlIcono varchar(500) NULL,
		FechaRegistro datetime NOT NULL,
		FechaActualizacion datetime NULL	
		PRIMARY KEY (BeneficioID, CodigoBeneficio)
	)
end
GO

USE BelcorpCostaRica
GO

If Not Exists(select 1 from SYSOBJECTS where type = 'U' and id = OBJECT_ID('dbo.BeneficioCaminoBrillante'))
Begin
	CREATE TABLE BeneficioCaminoBrillante (
		BeneficioID int Identity,
		CodigoNivel varchar(3), 
		CodigoBeneficio varchar(15) NOT NULL,
		NombreBeneficio varchar(100) NOT NULL,
		Descripcion varchar(300) NULL,
		UrlIcono varchar(500) NULL,
		FechaRegistro datetime NOT NULL,
		FechaActualizacion datetime NULL	
		PRIMARY KEY (BeneficioID, CodigoBeneficio)
	)
end
GO

USE BelcorpChile
GO

If Not Exists(select 1 from SYSOBJECTS where type = 'U' and id = OBJECT_ID('dbo.BeneficioCaminoBrillante'))
Begin
	CREATE TABLE BeneficioCaminoBrillante (
		BeneficioID int Identity,
		CodigoNivel varchar(3), 
		CodigoBeneficio varchar(15) NOT NULL,
		NombreBeneficio varchar(100) NOT NULL,
		Descripcion varchar(300) NULL,
		UrlIcono varchar(500) NULL,
		FechaRegistro datetime NOT NULL,
		FechaActualizacion datetime NULL	
		PRIMARY KEY (BeneficioID, CodigoBeneficio)
	)
end
GO

USE BelcorpBolivia
GO

If Not Exists(select 1 from SYSOBJECTS where type = 'U' and id = OBJECT_ID('dbo.BeneficioCaminoBrillante'))
Begin
	CREATE TABLE BeneficioCaminoBrillante (
		BeneficioID int Identity,
		CodigoNivel varchar(3), 
		CodigoBeneficio varchar(15) NOT NULL,
		NombreBeneficio varchar(100) NOT NULL,
		Descripcion varchar(300) NULL,
		UrlIcono varchar(500) NULL,
		FechaRegistro datetime NOT NULL,
		FechaActualizacion datetime NULL	
		PRIMARY KEY (BeneficioID, CodigoBeneficio)
	)
end
GO