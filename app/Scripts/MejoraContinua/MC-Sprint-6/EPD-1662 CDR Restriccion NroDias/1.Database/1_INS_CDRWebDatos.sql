USE BelcorpPeru
go
if not exists(select 1 from CDRWebDatos where Codigo = 'ValidacionDiasFaltante')
begin
	insert into CDRWebDatos(Codigo, Valor)
	values('ValidacionDiasFaltante','7');
end
go
if not exists(select 1 from CDRWebDatos where Codigo = 'DiasAntesFacturacion')
begin
	insert into CDRWebDatos(Codigo, Valor)
	values('DiasAntesFacturacion','2');
end
go