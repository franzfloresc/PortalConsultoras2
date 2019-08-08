GO
USE BelcorpPeru
GO
begin
	if(not exists(select 1 from tablalogicadatos where ((TablaLogicaID = 158) and (codigo = 'LasMasGanadoras'))))
	begin
		declare @vTablaLogicaDatosID smallint;

		set @vTablaLogicaDatosID = (select max(TablaLogicaDatosID) + 1 from tablalogicadatos);

		insert into tablalogicadatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion,Valor)
		values (@vTablaLogicaDatosID,158,'LasMasGanadoras','Permite habilitar la funcionalidad de palanca Las Mas Ganadoras. 0:Deshabilitar,1:Habilitar',1);
	end;
end;

GO
USE BelcorpMexico
GO
begin
	if(not exists(select 1 from tablalogicadatos where ((TablaLogicaID = 158) and (codigo = 'LasMasGanadoras'))))
	begin
		declare @vTablaLogicaDatosID smallint;

		set @vTablaLogicaDatosID = (select max(TablaLogicaDatosID) + 1 from tablalogicadatos);

		insert into tablalogicadatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion,Valor)
		values (@vTablaLogicaDatosID,158,'LasMasGanadoras','Permite habilitar la funcionalidad de palanca Las Mas Ganadoras. 0:Deshabilitar,1:Habilitar',1);
	end;
end;

GO
USE BelcorpColombia
GO
begin
	if(not exists(select 1 from tablalogicadatos where ((TablaLogicaID = 158) and (codigo = 'LasMasGanadoras'))))
	begin
		declare @vTablaLogicaDatosID smallint;

		set @vTablaLogicaDatosID = (select max(TablaLogicaDatosID) + 1 from tablalogicadatos);

		insert into tablalogicadatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion,Valor)
		values (@vTablaLogicaDatosID,158,'LasMasGanadoras','Permite habilitar la funcionalidad de palanca Las Mas Ganadoras. 0:Deshabilitar,1:Habilitar',1);
	end;
end;

GO
USE BelcorpSalvador
GO
begin
	if(not exists(select 1 from tablalogicadatos where ((TablaLogicaID = 158) and (codigo = 'LasMasGanadoras'))))
	begin
		declare @vTablaLogicaDatosID smallint;

		set @vTablaLogicaDatosID = (select max(TablaLogicaDatosID) + 1 from tablalogicadatos);

		insert into tablalogicadatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion,Valor)
		values (@vTablaLogicaDatosID,158,'LasMasGanadoras','Permite habilitar la funcionalidad de palanca Las Mas Ganadoras. 0:Deshabilitar,1:Habilitar',1);
	end;
end;

GO
USE BelcorpPuertoRico
GO
begin
	if(not exists(select 1 from tablalogicadatos where ((TablaLogicaID = 158) and (codigo = 'LasMasGanadoras'))))
	begin
		declare @vTablaLogicaDatosID smallint;

		set @vTablaLogicaDatosID = (select max(TablaLogicaDatosID) + 1 from tablalogicadatos);

		insert into tablalogicadatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion,Valor)
		values (@vTablaLogicaDatosID,158,'LasMasGanadoras','Permite habilitar la funcionalidad de palanca Las Mas Ganadoras. 0:Deshabilitar,1:Habilitar',1);
	end;
end;

GO
USE BelcorpPanama
GO
begin
	if(not exists(select 1 from tablalogicadatos where ((TablaLogicaID = 158) and (codigo = 'LasMasGanadoras'))))
	begin
		declare @vTablaLogicaDatosID smallint;

		set @vTablaLogicaDatosID = (select max(TablaLogicaDatosID) + 1 from tablalogicadatos);

		insert into tablalogicadatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion,Valor)
		values (@vTablaLogicaDatosID,158,'LasMasGanadoras','Permite habilitar la funcionalidad de palanca Las Mas Ganadoras. 0:Deshabilitar,1:Habilitar',1);
	end;
end;

GO
USE BelcorpGuatemala
GO
begin
	if(not exists(select 1 from tablalogicadatos where ((TablaLogicaID = 158) and (codigo = 'LasMasGanadoras'))))
	begin
		declare @vTablaLogicaDatosID smallint;

		set @vTablaLogicaDatosID = (select max(TablaLogicaDatosID) + 1 from tablalogicadatos);

		insert into tablalogicadatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion,Valor)
		values (@vTablaLogicaDatosID,158,'LasMasGanadoras','Permite habilitar la funcionalidad de palanca Las Mas Ganadoras. 0:Deshabilitar,1:Habilitar',1);
	end;
end;

GO
USE BelcorpEcuador
GO
begin
	if(not exists(select 1 from tablalogicadatos where ((TablaLogicaID = 158) and (codigo = 'LasMasGanadoras'))))
	begin
		declare @vTablaLogicaDatosID smallint;

		set @vTablaLogicaDatosID = (select max(TablaLogicaDatosID) + 1 from tablalogicadatos);

		insert into tablalogicadatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion,Valor)
		values (@vTablaLogicaDatosID,158,'LasMasGanadoras','Permite habilitar la funcionalidad de palanca Las Mas Ganadoras. 0:Deshabilitar,1:Habilitar',1);
	end;
end;

GO
USE BelcorpDominicana
GO
begin
	if(not exists(select 1 from tablalogicadatos where ((TablaLogicaID = 158) and (codigo = 'LasMasGanadoras'))))
	begin
		declare @vTablaLogicaDatosID smallint;

		set @vTablaLogicaDatosID = (select max(TablaLogicaDatosID) + 1 from tablalogicadatos);

		insert into tablalogicadatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion,Valor)
		values (@vTablaLogicaDatosID,158,'LasMasGanadoras','Permite habilitar la funcionalidad de palanca Las Mas Ganadoras. 0:Deshabilitar,1:Habilitar',1);
	end;
end;

GO
USE BelcorpCostaRica
GO
begin
	if(not exists(select 1 from tablalogicadatos where ((TablaLogicaID = 158) and (codigo = 'LasMasGanadoras'))))
	begin
		declare @vTablaLogicaDatosID smallint;

		set @vTablaLogicaDatosID = (select max(TablaLogicaDatosID) + 1 from tablalogicadatos);

		insert into tablalogicadatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion,Valor)
		values (@vTablaLogicaDatosID,158,'LasMasGanadoras','Permite habilitar la funcionalidad de palanca Las Mas Ganadoras. 0:Deshabilitar,1:Habilitar',1);
	end;
end;

GO
USE BelcorpChile
GO
begin
	if(not exists(select 1 from tablalogicadatos where ((TablaLogicaID = 158) and (codigo = 'LasMasGanadoras'))))
	begin
		declare @vTablaLogicaDatosID smallint;

		set @vTablaLogicaDatosID = (select max(TablaLogicaDatosID) + 1 from tablalogicadatos);

		insert into tablalogicadatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion,Valor)
		values (@vTablaLogicaDatosID,158,'LasMasGanadoras','Permite habilitar la funcionalidad de palanca Las Mas Ganadoras. 0:Deshabilitar,1:Habilitar',1);
	end;
end;

GO
USE BelcorpBolivia
GO
begin
	if(not exists(select 1 from tablalogicadatos where ((TablaLogicaID = 158) and (codigo = 'LasMasGanadoras'))))
	begin
		declare @vTablaLogicaDatosID smallint;

		set @vTablaLogicaDatosID = (select max(TablaLogicaDatosID) + 1 from tablalogicadatos);

		insert into tablalogicadatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion,Valor)
		values (@vTablaLogicaDatosID,158,'LasMasGanadoras','Permite habilitar la funcionalidad de palanca Las Mas Ganadoras. 0:Deshabilitar,1:Habilitar',1);
	end;
end;

GO
