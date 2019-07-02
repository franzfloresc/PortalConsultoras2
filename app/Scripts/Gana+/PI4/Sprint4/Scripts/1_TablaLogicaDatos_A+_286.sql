use BelcorpColombia_GANAMAS;
go

begin
	if(not exists(select 1 from tablalogicadatos where ((TablaLogicaID = 158) and (codigo = 'LasMasGanadoras'))))
	begin
		declare @vTablaLogicaDatosID smallint;

		set @vTablaLogicaDatosID = (select max(TablaLogicaDatosID) + 1 from tablalogicadatos);

		insert into tablalogicadatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion,Valor) values (@vTablaLogicaDatosID,158,'LasMasGanadoras','Permite habilitar la funcionalidad de palanca Las Mas Ganadoras. 0:Deshabilitar,1:Habilitar',1);
	end;
end;

use BelcorpPeru_GANAMAS;
go

begin
	if(not exists(select 1 from tablalogicadatos where ((TablaLogicaID = 158) and (codigo = 'LasMasGanadoras'))))
	begin
		declare @vTablaLogicaDatosID smallint;

		set @vTablaLogicaDatosID = (select max(TablaLogicaDatosID) + 1 from tablalogicadatos);

		insert into tablalogicadatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion,Valor) values (@vTablaLogicaDatosID,158,'LasMasGanadoras','Permite habilitar la funcionalidad de palanca Las Mas Ganadoras. 0:Deshabilitar,1:Habilitar',1);
	end;
end;

use BelcorpChile_GANAMAS;
go

begin
	if(not exists(select 1 from tablalogicadatos where ((TablaLogicaID = 158) and (codigo = 'LasMasGanadoras'))))
	begin
		declare @vTablaLogicaDatosID smallint;

		set @vTablaLogicaDatosID = (select max(TablaLogicaDatosID) + 1 from tablalogicadatos);

		insert into tablalogicadatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion,Valor) values (@vTablaLogicaDatosID,158,'LasMasGanadoras','Permite habilitar la funcionalidad de palanca Las Mas Ganadoras. 0:Deshabilitar,1:Habilitar',1);
	end;
end;

use BelcorpCostaRica_GANAMAS;
go

begin
	if(not exists(select 1 from tablalogicadatos where ((TablaLogicaID = 158) and (codigo = 'LasMasGanadoras'))))
	begin
		declare @vTablaLogicaDatosID smallint;

		set @vTablaLogicaDatosID = (select max(TablaLogicaDatosID) + 1 from tablalogicadatos);

		insert into tablalogicadatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion,Valor) values (@vTablaLogicaDatosID,158,'LasMasGanadoras','Permite habilitar la funcionalidad de palanca Las Mas Ganadoras. 0:Deshabilitar,1:Habilitar',1);
	end;
end;

use BelcorpEcuador_GANAMAS;
go

begin
	if(not exists(select 1 from tablalogicadatos where ((TablaLogicaID = 158) and (codigo = 'LasMasGanadoras'))))
	begin
		declare @vTablaLogicaDatosID smallint;

		set @vTablaLogicaDatosID = (select max(TablaLogicaDatosID) + 1 from tablalogicadatos);

		insert into tablalogicadatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion,Valor) values (@vTablaLogicaDatosID,158,'LasMasGanadoras','Permite habilitar la funcionalidad de palanca Las Mas Ganadoras. 0:Deshabilitar,1:Habilitar',1);
	end;
end;

use BelcorpMexico_GANAMAS;
go

begin
	if(not exists(select 1 from tablalogicadatos where ((TablaLogicaID = 158) and (codigo = 'LasMasGanadoras'))))
	begin
		declare @vTablaLogicaDatosID smallint;

		set @vTablaLogicaDatosID = (select max(TablaLogicaDatosID) + 1 from tablalogicadatos);

		insert into tablalogicadatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion,Valor) values (@vTablaLogicaDatosID,158,'LasMasGanadoras','Permite habilitar la funcionalidad de palanca Las Mas Ganadoras. 0:Deshabilitar,1:Habilitar',1);
	end;
end;