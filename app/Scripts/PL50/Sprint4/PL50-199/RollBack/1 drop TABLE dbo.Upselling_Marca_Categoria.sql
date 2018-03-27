use belcorpperu_pl50
go

IF OBJECT_ID(N'dbo.Upselling_Marca_Categoria', N'U') IS not NULL
BEGIN

drop TABLE dbo.Upselling_Marca_Categoria;
END
