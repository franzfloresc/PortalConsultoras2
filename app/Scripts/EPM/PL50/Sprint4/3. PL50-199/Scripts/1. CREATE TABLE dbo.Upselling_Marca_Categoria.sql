use belcorpBolivia
go

IF OBJECT_ID(N'dbo.Upselling_Marca_Categoria', N'U') IS  NULL
BEGIN

CREATE TABLE dbo.Upselling_Marca_Categoria (
    UpsellingID int not null FOREIGN KEY REFERENCES UpSelling(UpsellingID),
    MarcaID char(2)  not null, 
    CategoriaID char(2)  not null, 
	   CONSTRAINT PK_Upselling_Marca_Categoria PRIMARY KEY (UpsellingID,MarcaID, CategoriaID)
);
END

use belcorpChile
go

IF OBJECT_ID(N'dbo.Upselling_Marca_Categoria', N'U') IS  NULL
BEGIN

CREATE TABLE dbo.Upselling_Marca_Categoria (
    UpsellingID int not null FOREIGN KEY REFERENCES UpSelling(UpsellingID),
    MarcaID char(2)  not null, 
    CategoriaID char(2)  not null, 
	   CONSTRAINT PK_Upselling_Marca_Categoria PRIMARY KEY (UpsellingID,MarcaID, CategoriaID)
);
END

use belcorpColombia
go

IF OBJECT_ID(N'dbo.Upselling_Marca_Categoria', N'U') IS  NULL
BEGIN

CREATE TABLE dbo.Upselling_Marca_Categoria (
    UpsellingID int not null FOREIGN KEY REFERENCES UpSelling(UpsellingID),
    MarcaID char(2)  not null, 
    CategoriaID char(2)  not null, 
	   CONSTRAINT PK_Upselling_Marca_Categoria PRIMARY KEY (UpsellingID,MarcaID, CategoriaID)
);
END

use belcorpCostaRica
go

IF OBJECT_ID(N'dbo.Upselling_Marca_Categoria', N'U') IS  NULL
BEGIN

CREATE TABLE dbo.Upselling_Marca_Categoria (
    UpsellingID int not null FOREIGN KEY REFERENCES UpSelling(UpsellingID),
    MarcaID char(2)  not null, 
    CategoriaID char(2)  not null, 
	   CONSTRAINT PK_Upselling_Marca_Categoria PRIMARY KEY (UpsellingID,MarcaID, CategoriaID)
);
END

use belcorpDominicana
go

IF OBJECT_ID(N'dbo.Upselling_Marca_Categoria', N'U') IS  NULL
BEGIN

CREATE TABLE dbo.Upselling_Marca_Categoria (
    UpsellingID int not null FOREIGN KEY REFERENCES UpSelling(UpsellingID),
    MarcaID char(2)  not null, 
    CategoriaID char(2)  not null, 
	   CONSTRAINT PK_Upselling_Marca_Categoria PRIMARY KEY (UpsellingID,MarcaID, CategoriaID)
);
END

use belcorpEcuador
go

IF OBJECT_ID(N'dbo.Upselling_Marca_Categoria', N'U') IS  NULL
BEGIN

CREATE TABLE dbo.Upselling_Marca_Categoria (
    UpsellingID int not null FOREIGN KEY REFERENCES UpSelling(UpsellingID),
    MarcaID char(2)  not null, 
    CategoriaID char(2)  not null, 
	   CONSTRAINT PK_Upselling_Marca_Categoria PRIMARY KEY (UpsellingID,MarcaID, CategoriaID)
);
END

use belcorpGuatemala
go

IF OBJECT_ID(N'dbo.Upselling_Marca_Categoria', N'U') IS  NULL
BEGIN

CREATE TABLE dbo.Upselling_Marca_Categoria (
    UpsellingID int not null FOREIGN KEY REFERENCES UpSelling(UpsellingID),
    MarcaID char(2)  not null, 
    CategoriaID char(2)  not null, 
	   CONSTRAINT PK_Upselling_Marca_Categoria PRIMARY KEY (UpsellingID,MarcaID, CategoriaID)
);
END

use belcorpMexico
go

IF OBJECT_ID(N'dbo.Upselling_Marca_Categoria', N'U') IS  NULL
BEGIN

CREATE TABLE dbo.Upselling_Marca_Categoria (
    UpsellingID int not null FOREIGN KEY REFERENCES UpSelling(UpsellingID),
    MarcaID char(2)  not null, 
    CategoriaID char(2)  not null, 
	   CONSTRAINT PK_Upselling_Marca_Categoria PRIMARY KEY (UpsellingID,MarcaID, CategoriaID)
);
END

use belcorpPanama
go

IF OBJECT_ID(N'dbo.Upselling_Marca_Categoria', N'U') IS  NULL
BEGIN

CREATE TABLE dbo.Upselling_Marca_Categoria (
    UpsellingID int not null FOREIGN KEY REFERENCES UpSelling(UpsellingID),
    MarcaID char(2)  not null, 
    CategoriaID char(2)  not null, 
	   CONSTRAINT PK_Upselling_Marca_Categoria PRIMARY KEY (UpsellingID,MarcaID, CategoriaID)
);
END

use belcorpPeru
go

IF OBJECT_ID(N'dbo.Upselling_Marca_Categoria', N'U') IS  NULL
BEGIN

CREATE TABLE dbo.Upselling_Marca_Categoria (
    UpsellingID int not null FOREIGN KEY REFERENCES UpSelling(UpsellingID),
    MarcaID char(2)  not null, 
    CategoriaID char(2)  not null, 
	   CONSTRAINT PK_Upselling_Marca_Categoria PRIMARY KEY (UpsellingID,MarcaID, CategoriaID)
);
END

use belcorpPuertoRico
go

IF OBJECT_ID(N'dbo.Upselling_Marca_Categoria', N'U') IS  NULL
BEGIN

CREATE TABLE dbo.Upselling_Marca_Categoria (
    UpsellingID int not null FOREIGN KEY REFERENCES UpSelling(UpsellingID),
    MarcaID char(2)  not null, 
    CategoriaID char(2)  not null, 
	   CONSTRAINT PK_Upselling_Marca_Categoria PRIMARY KEY (UpsellingID,MarcaID, CategoriaID)
);
END

use belcorpSalvador
go

IF OBJECT_ID(N'dbo.Upselling_Marca_Categoria', N'U') IS  NULL
BEGIN

CREATE TABLE dbo.Upselling_Marca_Categoria (
    UpsellingID int not null FOREIGN KEY REFERENCES UpSelling(UpsellingID),
    MarcaID char(2)  not null, 
    CategoriaID char(2)  not null, 
	   CONSTRAINT PK_Upselling_Marca_Categoria PRIMARY KEY (UpsellingID,MarcaID, CategoriaID)
);
END

