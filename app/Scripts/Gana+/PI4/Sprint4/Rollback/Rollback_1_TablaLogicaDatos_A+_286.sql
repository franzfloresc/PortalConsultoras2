use BelcorpColombia_GANAMAS;
go

begin
	if(exists(select 1 from tablalogicadatos where ((TablaLogicaID = 158) and (codigo = 'LasMasGanadoras'))))
	begin
		delete from tablalogicadatos where ((TablaLogicaID = 158) and (codigo = 'LasMasGanadoras'))
	end;
end;

use BelcorpPeru_GANAMAS;
go

begin
	if(exists(select 1 from tablalogicadatos where ((TablaLogicaID = 158) and (codigo = 'LasMasGanadoras'))))
	begin
		delete from tablalogicadatos where ((TablaLogicaID = 158) and (codigo = 'LasMasGanadoras'))
	end;
end;

use BelcorpChile_GANAMAS;
go

begin
	if(exists(select 1 from tablalogicadatos where ((TablaLogicaID = 158) and (codigo = 'LasMasGanadoras'))))
	begin
		delete from tablalogicadatos where ((TablaLogicaID = 158) and (codigo = 'LasMasGanadoras'))
	end;
end;

use BelcorpCostaRica_GANAMAS;
go

begin
	if(exists(select 1 from tablalogicadatos where ((TablaLogicaID = 158) and (codigo = 'LasMasGanadoras'))))
	begin
		delete from tablalogicadatos where ((TablaLogicaID = 158) and (codigo = 'LasMasGanadoras'))
	end;
end;

use BelcorpEcuador_GANAMAS;
go

begin
	if(exists(select 1 from tablalogicadatos where ((TablaLogicaID = 158) and (codigo = 'LasMasGanadoras'))))
	begin
		delete from tablalogicadatos where ((TablaLogicaID = 158) and (codigo = 'LasMasGanadoras'))
	end;
end;

use BelcorpMexico_GANAMAS;
go

begin
	if(exists(select 1 from tablalogicadatos where ((TablaLogicaID = 158) and (codigo = 'LasMasGanadoras'))))
	begin
		delete from tablalogicadatos where ((TablaLogicaID = 158) and (codigo = 'LasMasGanadoras'))
	end;
end;