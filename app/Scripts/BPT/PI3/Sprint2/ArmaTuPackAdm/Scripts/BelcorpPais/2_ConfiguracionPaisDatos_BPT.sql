
use BelcorpCostaRica_BPT



declare @codigo varchar(5)  = '004'

if not exists (	
	select 1 from ConfiguracionPaisDatos d
	inner join ConfiguracionPais p on p.ConfiguracionPaisID = d.ConfiguracionPaisID
	where p.Codigo = 'MSPersonalizacion' and d.Codigo ='EstrategiaDisponible' 
	and (','+valor1+',') like ('%'+@codigo+'%')
)
begin

	update d
	set Valor1 = Valor1 + ',' + @codigo
	from ConfiguracionPaisDatos d
	inner join ConfiguracionPais p on p.ConfiguracionPaisID = d.ConfiguracionPaisID
	where p.Codigo = 'MSPersonalizacion' and d.Codigo ='EstrategiaDisponible'

end


