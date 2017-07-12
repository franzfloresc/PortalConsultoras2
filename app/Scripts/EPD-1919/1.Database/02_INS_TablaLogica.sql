GO
if not exists(select 1 from TablaLogica where TablaLogicaID = 104)
begin
	insert into TablaLogica(TablaLogicaID,Descripcion)
	values(104,'CDR Express');
end
GO
if exists(select 1 from TablaLogica where TablaLogicaID = 104)
begin
	if not exists(select 1 from TablaLogicaDatos where TablaLogicaID = 104 and Codigo = 'Mensaje')
	begin
		insert into TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion)
		values(10401,104,'Mensaje','Sólo aplicable a cambios. Tiene un costo de envío{0}{1}.');
	end

	if not exists(select 1 from TablaLogicaDatos where TablaLogicaID = 104 and Codigo = 'MensajeNew')
	begin
		insert into TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion)
		values(10402,104,'MensajeNew','Por ser consultora nueva en esta oportunidad tu envío es gratis.');
	end
end
GO