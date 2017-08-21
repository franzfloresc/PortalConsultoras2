GO
if exists(
	select 1
	from INFORMATION_SCHEMA.ROUTINES 
	where SPECIFIC_NAME = 'GetMontoFletePorZonaId' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
begin
    drop procedure dbo.GetMontoFletePorZonaId
end
GO