USE BelcorpBolivia
GO
if exists (select 1 from sys.synonyms where name = N'GestionStock' AND schema_id = schema_id(N'ods'))
begin
	drop synonym ods.GestionStock
end
GO

USE BelcorpChile
GO
if exists (select 1 from sys.synonyms where name = N'GestionStock' AND schema_id = schema_id(N'ods'))
begin
	drop synonym ods.GestionStock
end
GO

USE BelcorpColombia
GO
if exists (select 1 from sys.synonyms where name = N'GestionStock' AND schema_id = schema_id(N'ods'))
begin
	drop synonym ods.GestionStock
end
GO

USE BelcorpCostaRica
GO
if exists (select 1 from sys.synonyms where name = N'GestionStock' AND schema_id = schema_id(N'ods'))
begin
	drop synonym ods.GestionStock
end
GO

USE BelcorpDominicana
GO
if exists (select 1 from sys.synonyms where name = N'GestionStock' AND schema_id = schema_id(N'ods'))
begin
	drop synonym ods.GestionStock
end
GO

USE BelcorpEcuador
GO
if exists (select 1 from sys.synonyms where name = N'GestionStock' AND schema_id = schema_id(N'ods'))
begin
	drop synonym ods.GestionStock
end
GO

USE BelcorpGuatemala
GO
if exists (select 1 from sys.synonyms where name = N'GestionStock' AND schema_id = schema_id(N'ods'))
begin
	drop synonym ods.GestionStock
end
GO

USE BelcorpMexico
GO
if exists (select 1 from sys.synonyms where name = N'GestionStock' AND schema_id = schema_id(N'ods'))
begin
	drop synonym ods.GestionStock
end
GO

USE BelcorpPanama
GO
if exists (select 1 from sys.synonyms where name = N'GestionStock' AND schema_id = schema_id(N'ods'))
begin
	drop synonym ods.GestionStock
end
GO

USE BelcorpPeru
GO
if exists (select 1 from sys.synonyms where name = N'GestionStock' AND schema_id = schema_id(N'ods'))
begin
	drop synonym ods.GestionStock
end
GO

USE BelcorpPuertoRico
GO
if exists (select 1 from sys.synonyms where name = N'GestionStock' AND schema_id = schema_id(N'ods'))
begin
	drop synonym ods.GestionStock
end
GO

USE BelcorpSalvador
GO
if exists (select 1 from sys.synonyms where name = N'GestionStock' AND schema_id = schema_id(N'ods'))
begin
	drop synonym ods.GestionStock
end
GO