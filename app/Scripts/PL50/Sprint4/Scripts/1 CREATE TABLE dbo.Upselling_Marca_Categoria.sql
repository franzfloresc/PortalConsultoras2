use belcorpperu_pl50
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
