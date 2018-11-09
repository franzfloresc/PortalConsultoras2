USE BelcorpBolivia
GO
if not exists (select 1 from sys.synonyms where name = N'GESTION_STOCK' AND schema_id = schema_id(N'ods'))
begin
	create synonym ods.GESTION_STOCK FOR ODS_BO.dbo.GESTION_STOCK
end
GO

USE BelcorpChile
GO
if not exists (select 1 from sys.synonyms where name = N'GESTION_STOCK' AND schema_id = schema_id(N'ods'))
begin
	create synonym ods.GESTION_STOCK FOR ODS_CL.dbo.GESTION_STOCK
end
GO

USE BelcorpColombia
GO
if not exists (select 1 from sys.synonyms where name = N'GESTION_STOCK' AND schema_id = schema_id(N'ods'))
begin
	create synonym ods.GESTION_STOCK FOR ODS_CO.dbo.GESTION_STOCK
end
GO

USE BelcorpCostaRica
GO
if not exists (select 1 from sys.synonyms where name = N'GESTION_STOCK' AND schema_id = schema_id(N'ods'))
begin
	create synonym ods.GESTION_STOCK FOR ODS_CR.dbo.GESTION_STOCK
end
GO

USE BelcorpDominicana
GO
if not exists (select 1 from sys.synonyms where name = N'GESTION_STOCK' AND schema_id = schema_id(N'ods'))
begin
	create synonym ods.GESTION_STOCK FOR ODS_DO.dbo.GESTION_STOCK
end
GO

USE BelcorpEcuador
GO
if not exists (select 1 from sys.synonyms where name = N'GESTION_STOCK' AND schema_id = schema_id(N'ods'))
begin
	create synonym ods.GESTION_STOCK FOR ODS_EC.dbo.GESTION_STOCK
end
GO

USE BelcorpGuatemala
GO
if not exists (select 1 from sys.synonyms where name = N'GESTION_STOCK' AND schema_id = schema_id(N'ods'))
begin
	create synonym ods.GESTION_STOCK FOR ODS_GT.dbo.GESTION_STOCK
end
GO

USE BelcorpMexico
GO
if not exists (select 1 from sys.synonyms where name = N'GESTION_STOCK' AND schema_id = schema_id(N'ods'))
begin
	create synonym ods.GESTION_STOCK FOR ODS_MX.dbo.GESTION_STOCK
end
GO

USE BelcorpPanama
GO
if not exists (select 1 from sys.synonyms where name = N'GESTION_STOCK' AND schema_id = schema_id(N'ods'))
begin
	create synonym ods.GESTION_STOCK FOR ODS_PA.dbo.GESTION_STOCK
end
GO

USE BelcorpPeru
GO
if not exists (select 1 from sys.synonyms where name = N'GESTION_STOCK' AND schema_id = schema_id(N'ods'))
begin
	create synonym ods.GESTION_STOCK FOR ODS_PE.dbo.GESTION_STOCK
end
GO

USE BelcorpPuertoRico
GO
if not exists (select 1 from sys.synonyms where name = N'GESTION_STOCK' AND schema_id = schema_id(N'ods'))
begin
	create synonym ods.GESTION_STOCK FOR ODS_PR.dbo.GESTION_STOCK
end
GO

USE BelcorpSalvador
GO
if not exists (select 1 from sys.synonyms where name = N'GESTION_STOCK' AND schema_id = schema_id(N'ods'))
begin
	create synonym ods.GESTION_STOCK FOR ODS_SV.dbo.GESTION_STOCK
end
GO