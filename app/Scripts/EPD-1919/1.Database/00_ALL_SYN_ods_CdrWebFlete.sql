USE BelcorpBolivia
GO
if not exists (select 1 from sys.synonyms where name = N'CdrWebFlete' AND schema_id = schema_id(N'ods'))
begin
	create synonym ods.CdrWebFlete FOR ODS_BO.dbo.CDRWEBFLETE
end
GO
/*end*/

USE BelcorpChile
GO
if not exists (select 1 from sys.synonyms where name = N'CdrWebFlete' AND schema_id = schema_id(N'ods'))
begin
	create synonym ods.CdrWebFlete FOR ODS_CL.dbo.CDRWEBFLETE
end
GO
/*end*/

USE BelcorpColombia
GO
if not exists (select 1 from sys.synonyms where name = N'CdrWebFlete' AND schema_id = schema_id(N'ods'))
begin
	create synonym ods.CdrWebFlete FOR ODS_CO.dbo.CDRWEBFLETE
end
GO
/*end*/

USE BelcorpCostaRica
GO
if not exists (select 1 from sys.synonyms where name = N'CdrWebFlete' AND schema_id = schema_id(N'ods'))
begin
	create synonym ods.CdrWebFlete FOR ODS_CR.dbo.CDRWEBFLETE
end
GO
/*end*/

USE BelcorpDominicana
GO
if not exists (select 1 from sys.synonyms where name = N'CdrWebFlete' AND schema_id = schema_id(N'ods'))
begin
	create synonym ods.CdrWebFlete FOR ODS_DO.dbo.CDRWEBFLETE
end
GO
/*end*/

USE BelcorpEcuador
GO
if not exists (select 1 from sys.synonyms where name = N'CdrWebFlete' AND schema_id = schema_id(N'ods'))
begin
	create synonym ods.CdrWebFlete FOR ODS_EC.dbo.CDRWEBFLETE
end
GO
/*end*/

USE BelcorpGuatemala
GO
if not exists (select 1 from sys.synonyms where name = N'CdrWebFlete' AND schema_id = schema_id(N'ods'))
begin
	create synonym ods.CdrWebFlete FOR ODS_GT.dbo.CDRWEBFLETE
end
GO
/*end*/

USE BelcorpMexico
GO
if not exists (select 1 from sys.synonyms where name = N'CdrWebFlete' AND schema_id = schema_id(N'ods'))
begin
	create synonym ods.CdrWebFlete FOR ODS_MX.dbo.CDRWEBFLETE
end
GO
/*end*/

USE BelcorpPanama
GO
if not exists (select 1 from sys.synonyms where name = N'CdrWebFlete' AND schema_id = schema_id(N'ods'))
begin
	create synonym ods.CdrWebFlete FOR ODS_PA.dbo.CDRWEBFLETE
end
GO
/*end*/

USE BelcorpPeru
GO
if not exists (select 1 from sys.synonyms where name = N'CdrWebFlete' AND schema_id = schema_id(N'ods'))
begin
	create synonym ods.CdrWebFlete FOR ODS_PE.dbo.CDRWEBFLETE
end
GO
/*end*/

USE BelcorpPuertoRico
GO
if not exists (select 1 from sys.synonyms where name = N'CdrWebFlete' AND schema_id = schema_id(N'ods'))
begin
	create synonym ods.CdrWebFlete FOR ODS_PR.dbo.CDRWEBFLETE
end
GO
/*end*/

USE BelcorpSalvador
GO
if not exists (select 1 from sys.synonyms where name = N'CdrWebFlete' AND schema_id = schema_id(N'ods'))
begin
	create synonym ods.CdrWebFlete FOR ODS_SV.dbo.CDRWEBFLETE
end
GO
/*end*/

USE BelcorpVenezuela
GO
if not exists (select 1 from sys.synonyms where name = N'CdrWebFlete' AND schema_id = schema_id(N'ods'))
begin
	create synonym ods.CdrWebFlete FOR ODS_VE.dbo.CDRWEBFLETE
end
GO