USE BelcorpBolivia
GO
if not exists (select 1 from sys.synonyms where name = N'GestionStock' AND schema_id = schema_id(N'ods'))
begin
	create synonym ods.GestionStock FOR ODS_BO.dbo.GestionStock
end
GO

USE BelcorpChile
GO
if not exists (select 1 from sys.synonyms where name = N'GestionStock' AND schema_id = schema_id(N'ods'))
begin
	create synonym ods.GestionStock FOR ODS_CL.dbo.GestionStock
end
GO

USE BelcorpColombia
GO
if not exists (select 1 from sys.synonyms where name = N'GestionStock' AND schema_id = schema_id(N'ods'))
begin
	create synonym ods.GestionStock FOR ODS_CO.dbo.GestionStock
end
GO

USE BelcorpCostaRica
GO
if not exists (select 1 from sys.synonyms where name = N'GestionStock' AND schema_id = schema_id(N'ods'))
begin
	create synonym ods.GestionStock FOR ODS_CR.dbo.GestionStock
end
GO

USE BelcorpDominicana
GO
if not exists (select 1 from sys.synonyms where name = N'GestionStock' AND schema_id = schema_id(N'ods'))
begin
	create synonym ods.GestionStock FOR ODS_DO.dbo.GestionStock
end
GO

USE BelcorpEcuador
GO
if not exists (select 1 from sys.synonyms where name = N'GestionStock' AND schema_id = schema_id(N'ods'))
begin
	create synonym ods.GestionStock FOR ODS_EC.dbo.GestionStock
end
GO

USE BelcorpGuatemala
GO
if not exists (select 1 from sys.synonyms where name = N'GestionStock' AND schema_id = schema_id(N'ods'))
begin
	create synonym ods.GestionStock FOR ODS_GT.dbo.GestionStock
end
GO

USE BelcorpMexico
GO
if not exists (select 1 from sys.synonyms where name = N'GestionStock' AND schema_id = schema_id(N'ods'))
begin
	create synonym ods.GestionStock FOR ODS_MX.dbo.GestionStock
end
GO

USE BelcorpPanama
GO
if not exists (select 1 from sys.synonyms where name = N'GestionStock' AND schema_id = schema_id(N'ods'))
begin
	create synonym ods.GestionStock FOR ODS_PA.dbo.GestionStock
end
GO

USE BelcorpPeru
GO
if not exists (select 1 from sys.synonyms where name = N'GestionStock' AND schema_id = schema_id(N'ods'))
begin
	create synonym ods.GestionStock FOR ODS_PE.dbo.GestionStock
end
GO

USE BelcorpPuertoRico
GO
if not exists (select 1 from sys.synonyms where name = N'GestionStock' AND schema_id = schema_id(N'ods'))
begin
	create synonym ods.GestionStock FOR ODS_PR.dbo.GestionStock
end
GO

USE BelcorpSalvador
GO
if not exists (select 1 from sys.synonyms where name = N'GestionStock' AND schema_id = schema_id(N'ods'))
begin
	create synonym ods.GestionStock FOR ODS_SV.dbo.GestionStock
end
GO