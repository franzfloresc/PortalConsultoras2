CREATE PROC GetCDRWebTipoOperacion
as
begin
select 
	CodigoOperacion,
	DescripcionOperacion,
	NumeroDiasAtrasOperacion
from [dbo].[TipoOperacionesCDR]
end



