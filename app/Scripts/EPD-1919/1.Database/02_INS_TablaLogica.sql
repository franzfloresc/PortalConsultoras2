GO
if not exists(select 1 from TablaLogica where TablaLogicaID = 104)
begin
	insert into TablaLogica(TablaLogicaID,Descripcion)
	values(104,'CDR Express');
end
GO
if exists(select 1 from TablaLogica where TablaLogicaID = 104)
begin
	if not exists(select 1 from TablaLogicaDatos where TablaLogicaID = 104 and Codigo = 'Regular1')
	begin
		insert into TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion)
		values(10401,104,'Regular1','Envío REGULAR junto con tu pedido');
	end

	if not exists(select 1 from TablaLogicaDatos where TablaLogicaID = 104 and Codigo = 'Regular2')
	begin
		insert into TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion)
		values(10402,104,'Regular2',' - Sin costo adicional.');
	end

	if not exists(select 1 from TablaLogicaDatos where TablaLogicaID = 104 and Codigo = 'Express1')
	begin
		insert into TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion)
		values(10403,104,'Express1','Envío EXPRESS especial');
	end

	if not exists(select 1 from TablaLogicaDatos where TablaLogicaID = 104 and Codigo = 'Express2')
	begin
		insert into TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion)
		values(10404,104,'Express2',' - Flete {0}{1}.');
	end

	if not exists(select 1 from TablaLogicaDatos where TablaLogicaID = 104 and Codigo = 'Express3')
	begin
		insert into TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion)
		values(10405,104,'Express3','Recíbelo: Lima 48 horas y provincia 72 horas. No aplica domingos ni feriados.');
	end

	if not exists(select 1 from TablaLogicaDatos where TablaLogicaID = 104 and Codigo = 'Nuevas1')
	begin
		insert into TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion)
		values(10406,104,'Nuevas1',' Gratuito en tu ciclo de nuevas (6/6).');
	end
end
GO