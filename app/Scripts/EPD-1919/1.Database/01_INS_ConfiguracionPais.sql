GO
if not exists(select 1 from ConfiguracionPais where Codigo = 'CDR-EXP')
begin
	insert into ConfiguracionPais(Codigo,Excluyente,Descripcion,Estado)
	values('CDR-EXP',1,'Tiene CDR Express',0);
end
GO