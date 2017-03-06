USE BelcorpPeru
go
if exists(select 1 from CDRWebDatos where Codigo = 'ValidacionDiasFaltante')
begin
	delete from CDRWebDatos
	where Codigo = 'ValidacionDiasFaltante';
end
go
if exists(select 1 from CDRWebDatos where Codigo = 'DiasAntesFacturacion')
begin
	delete from CDRWebDatos
	where Codigo = 'DiasAntesFacturacion';
end
go