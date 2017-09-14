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
create procedure dbo.GetMontoFletePorZonaId
	@ZonaId int = null
as
begin
	select top 1 Montoflete as Monto
	from ods.cdrwebflete c
	inner join ods.zona z on c.codigozona = z.codigo
	where z.zonaId = @ZonaId;	
end
GO