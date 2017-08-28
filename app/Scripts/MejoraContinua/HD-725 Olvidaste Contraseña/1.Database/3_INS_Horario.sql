GO
delete from Horario
where Codigo = 'ChatEmtelco';
GO
insert into Horario(Codigo,Resumen,PrimerDiaSemana,HoraISO,HoraIncluyente)
values('ChatEmtelco','L-V: 08:00 a 20:00 y S: 08:00 a 18:00',1,0,1);
GO