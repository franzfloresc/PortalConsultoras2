use belcorpperu_pl50
go

IF  COL_LENGTH('dbo.Upselling', 'CategoriaApoyada') IS  NULL
BEGIN
    ALTER TABLE Upselling
	ADD CategoriaApoyada bit;
END

IF  COL_LENGTH('dbo.Upselling', 'CategoriaMonto') IS  NULL
BEGIN
	ALTER TABLE Upselling
	ADD CategoriaMonto bit;
END

go