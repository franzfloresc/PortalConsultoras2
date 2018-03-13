USE BelcorpPeru
go

if not exists (select 1 from TablaLogica where TablaLogicaID = 121)
begin

insert into TablaLogica (TablaLogicaID,Descripcion) values (121,'Valores Imagenes Resize')

insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12101,121,'125','Width Small')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12102,121,'125','Height Small')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12103,121,'250','Witdh Medium')
insert into TablaLogicaDatos (TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) values (12104,121,'250','Height Medium')

end

go