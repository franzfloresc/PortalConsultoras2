GO
USE BelcorpPeru
GO
if exists (select * from ConfiguracionPaisDatos where codigo = 'CaracteresBuscador')
begin
	update ConfiguracionPaisDatos set valor1=4     where codigo = 'CaracteresBuscador'
end

GO
USE BelcorpMexico
GO
if exists (select * from ConfiguracionPaisDatos where codigo = 'CaracteresBuscador')
begin
	update ConfiguracionPaisDatos set valor1=4     where codigo = 'CaracteresBuscador'
end

GO
USE BelcorpColombia
GO
if exists (select * from ConfiguracionPaisDatos where codigo = 'CaracteresBuscador')
begin
	update ConfiguracionPaisDatos set valor1=4     where codigo = 'CaracteresBuscador'
end

GO
USE BelcorpSalvador
GO
if exists (select * from ConfiguracionPaisDatos where codigo = 'CaracteresBuscador')
begin
	update ConfiguracionPaisDatos set valor1=4     where codigo = 'CaracteresBuscador'
end

GO
USE BelcorpPuertoRico
GO
if exists (select * from ConfiguracionPaisDatos where codigo = 'CaracteresBuscador')
begin
	update ConfiguracionPaisDatos set valor1=4     where codigo = 'CaracteresBuscador'
end

GO
USE BelcorpPanama
GO
if exists (select * from ConfiguracionPaisDatos where codigo = 'CaracteresBuscador')
begin
	update ConfiguracionPaisDatos set valor1=4     where codigo = 'CaracteresBuscador'
end

GO
USE BelcorpGuatemala
GO
if exists (select * from ConfiguracionPaisDatos where codigo = 'CaracteresBuscador')
begin
	update ConfiguracionPaisDatos set valor1=4     where codigo = 'CaracteresBuscador'
end

GO
USE BelcorpEcuador
GO
if exists (select * from ConfiguracionPaisDatos where codigo = 'CaracteresBuscador')
begin
	update ConfiguracionPaisDatos set valor1=4     where codigo = 'CaracteresBuscador'
end

GO
USE BelcorpDominicana
GO
if exists (select * from ConfiguracionPaisDatos where codigo = 'CaracteresBuscador')
begin
	update ConfiguracionPaisDatos set valor1=4    where codigo = 'CaracteresBuscador'
end

GO
USE BelcorpCostaRica
GO
if exists (select * from ConfiguracionPaisDatos where codigo = 'CaracteresBuscador')
begin
	update ConfiguracionPaisDatos set valor1=4    where codigo = 'CaracteresBuscador'
end

GO
USE BelcorpChile
GO
if exists (select * from ConfiguracionPaisDatos where codigo = 'CaracteresBuscador')
begin
	update ConfiguracionPaisDatos set valor1=4     where codigo = 'CaracteresBuscador'
end

GO
USE BelcorpBolivia
GO
if exists (select * from ConfiguracionPaisDatos where codigo = 'CaracteresBuscador')
begin
	update ConfiguracionPaisDatos set valor1=4     where codigo = 'CaracteresBuscador'
end

GO

USE BelcorpPeru
GO
If not exists (select * from ConfiguracionPaisDatos where codigo = 'MostrarPalabrasMenoresACuatro')
begin
	insert into ConfiguracionPaisDatos
values (7022,'MostrarPalabrasMenoresACuatro',0
,'cat, you, cy, agu, mia, pen, set, apa, oh, lip, mad, go, bb, cc, be, in, for, my, air, eye, ojo, sol, gel, kit, duo, new, le, red, its, art, hd, sol, max'
,null,null,'Muestra las palabras con cantidad de caracteres menores a 4 de acuerdo a lista registrada',1,null)

end

GO
USE BelcorpMexico
GO
If not exists (select * from ConfiguracionPaisDatos where codigo = 'MostrarPalabrasMenoresACuatro')
begin
	insert into ConfiguracionPaisDatos
values (7022,'MostrarPalabrasMenoresACuatro',0
,'cat, you, cy, agu, mia, pen, set, apa, oh, lip, mad, go, bb, cc, be, in, for, my, air, eye, ojo, sol, gel, kit, duo, new, le, red, its, art, hd, sol, max'
,null,null,'Muestra las palabras con cantidad de caracteres menores a 4 de acuerdo a lista registrada',1,null)

end

GO
USE BelcorpColombia
GO
If not exists (select * from ConfiguracionPaisDatos where codigo = 'MostrarPalabrasMenoresACuatro')
begin
	insert into ConfiguracionPaisDatos
values (7022,'MostrarPalabrasMenoresACuatro',0
,'cat, you, cy, agu, mia, pen, set, apa, oh, lip, mad, go, bb, cc, be, in, for, my, air, eye, ojo, sol, gel, kit, duo, new, le, red, its, art, hd, sol, max'
,null,null,'Muestra las palabras con cantidad de caracteres menores a 4 de acuerdo a lista registrada',1,null)

end

GO
USE BelcorpSalvador
GO
If not exists (select * from ConfiguracionPaisDatos where codigo = 'MostrarPalabrasMenoresACuatro')
begin
	insert into ConfiguracionPaisDatos
values (7022,'MostrarPalabrasMenoresACuatro',0
,'cat, you, cy, agu, mia, pen, set, apa, oh, lip, mad, go, bb, cc, be, in, for, my, air, eye, ojo, sol, gel, kit, duo, new, le, red, its, art, hd, sol, max'
,null,null,'Muestra las palabras con cantidad de caracteres menores a 4 de acuerdo a lista registrada',1,null)

end

GO
USE BelcorpPuertoRico
GO
If not exists (select * from ConfiguracionPaisDatos where codigo = 'MostrarPalabrasMenoresACuatro')
begin
	insert into ConfiguracionPaisDatos
values (7022,'MostrarPalabrasMenoresACuatro',0
,'cat, you, cy, agu, mia, pen, set, apa, oh, lip, mad, go, bb, cc, be, in, for, my, air, eye, ojo, sol, gel, kit, duo, new, le, red, its, art, hd, sol, max'
,null,null,'Muestra las palabras con cantidad de caracteres menores a 4 de acuerdo a lista registrada',1,null)

end

GO
USE BelcorpPanama
GO
If not exists (select * from ConfiguracionPaisDatos where codigo = 'MostrarPalabrasMenoresACuatro')
begin
	insert into ConfiguracionPaisDatos
values (7022,'MostrarPalabrasMenoresACuatro',0
,'cat, you, cy, agu, mia, pen, set, apa, oh, lip, mad, go, bb, cc, be, in, for, my, air, eye, ojo, sol, gel, kit, duo, new, le, red, its, art, hd, sol, max'
,null,null,'Muestra las palabras con cantidad de caracteres menores a 4 de acuerdo a lista registrada',1,null)

end

GO
USE BelcorpGuatemala
GO
If not exists (select * from ConfiguracionPaisDatos where codigo = 'MostrarPalabrasMenoresACuatro')
begin
	insert into ConfiguracionPaisDatos
values (7022,'MostrarPalabrasMenoresACuatro',0
,'cat, you, cy, agu, mia, pen, set, apa, oh, lip, mad, go, bb, cc, be, in, for, my, air, eye, ojo, sol, gel, kit, duo, new, le, red, its, art, hd, sol, max'
,null,null,'Muestra las palabras con cantidad de caracteres menores a 4 de acuerdo a lista registrada',1,null)

end

GO
USE BelcorpEcuador
GO
If not exists (select * from ConfiguracionPaisDatos where codigo = 'MostrarPalabrasMenoresACuatro')
begin
	insert into ConfiguracionPaisDatos
values (7022,'MostrarPalabrasMenoresACuatro',0
,'cat, you, cy, agu, mia, pen, set, apa, oh, lip, mad, go, bb, cc, be, in, for, my, air, eye, ojo, sol, gel, kit, duo, new, le, red, its, art, hd, sol, max'
,null,null,'Muestra las palabras con cantidad de caracteres menores a 4 de acuerdo a lista registrada',1,null)

end

GO
USE BelcorpDominicana
GO
If not exists (select * from ConfiguracionPaisDatos where codigo = 'MostrarPalabrasMenoresACuatro')
begin
	insert into ConfiguracionPaisDatos
values (7022,'MostrarPalabrasMenoresACuatro',0
,'cat, you, cy, agu, mia, pen, set, apa, oh, lip, mad, go, bb, cc, be, in, for, my, air, eye, ojo, sol, gel, kit, duo, new, le, red, its, art, hd, sol, max'
,null,null,'Muestra las palabras con cantidad de caracteres menores a 4 de acuerdo a lista registrada',1,null)

end

GO
USE BelcorpCostaRica
GO
If not exists (select * from ConfiguracionPaisDatos where codigo = 'MostrarPalabrasMenoresACuatro')
begin
	insert into ConfiguracionPaisDatos
values (7022,'MostrarPalabrasMenoresACuatro',0
,'cat, you, cy, agu, mia, pen, set, apa, oh, lip, mad, go, bb, cc, be, in, for, my, air, eye, ojo, sol, gel, kit, duo, new, le, red, its, art, hd, sol, max'
,null,null,'Muestra las palabras con cantidad de caracteres menores a 4 de acuerdo a lista registrada',1,null)

end

GO
USE BelcorpChile
GO
If not exists (select * from ConfiguracionPaisDatos where codigo = 'MostrarPalabrasMenoresACuatro')
begin
	insert into ConfiguracionPaisDatos
values (7022,'MostrarPalabrasMenoresACuatro',0
,'cat, you, cy, agu, mia, pen, set, apa, oh, lip, mad, go, bb, cc, be, in, for, my, air, eye, ojo, sol, gel, kit, duo, new, le, red, its, art, hd, sol, max'
,null,null,'Muestra las palabras con cantidad de caracteres menores a 4 de acuerdo a lista registrada',1,null)

end

GO
USE BelcorpBolivia
GO
If not exists (select * from ConfiguracionPaisDatos where codigo = 'MostrarPalabrasMenoresACuatro')
begin
	insert into ConfiguracionPaisDatos
values (7022,'MostrarPalabrasMenoresACuatro',0
,'cat, you, cy, agu, mia, pen, set, apa, oh, lip, mad, go, bb, cc, be, in, for, my, air, eye, ojo, sol, gel, kit, duo, new, le, red, its, art, hd, sol, max'
,null,null,'Muestra las palabras con cantidad de caracteres menores a 4 de acuerdo a lista registrada',1,null)

end

GO
