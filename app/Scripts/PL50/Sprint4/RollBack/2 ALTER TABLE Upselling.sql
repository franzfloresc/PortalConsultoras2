use belcorpperu_pl50
go

IF  COL_LENGTH('dbo.Upselling', 'CategoriaApoyada') IS not NULL
BEGIN
    ALTER TABLE Upselling
	DROP column CategoriaApoyada ;
END

IF  COL_LENGTH('dbo.Upselling', 'CategoriaMonto') IS not  NULL
BEGIN
	ALTER TABLE Upselling
	DROP column  CategoriaMonto;
END

go