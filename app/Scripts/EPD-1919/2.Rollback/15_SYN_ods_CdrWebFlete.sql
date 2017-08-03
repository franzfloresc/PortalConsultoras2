GO
if exists (select 1 from sys.synonyms where name = N'CdrWebFlete' AND schema_id = schema_id(N'ods'))
begin
	drop synonym ods.CdrWebFlete
end
GO