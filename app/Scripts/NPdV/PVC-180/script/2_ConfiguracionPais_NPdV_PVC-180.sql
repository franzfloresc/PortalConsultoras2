USE BelcorpColombia
GO
update ConfiguracionPais
set Estado = 1, Excluyente = 0
where Codigo = 'CAMINOBRILLANTE';
GO