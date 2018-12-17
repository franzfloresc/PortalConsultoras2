use SoporteConsultoras
GO
if not exists(select 1 from Menu where seccion='Consultoras' and IdMEnu = 36)
begin
	insert into Menu values (36, 'Consultoras', 'Reporte Producto Sugerido', 21, 'Consultoras/ReporteProductoSugerido', 1)
end
GO
/***** INSERTAR PERMISOS ******/
/*** Peru ***/
if not exists(select 1 from Permiso where IdPerfil = 7 and IdMenu = 36)
begin
    insert into Permiso values (7, 11, 36)
end
GO 
if not exists(select 1 from Permiso where IdPerfil = 14 and IdMenu = 36)
begin
    insert into Permiso values (14, 11, 36)
end
GO
/*** Chile ***/
if not exists(select 1 from Permiso where IdPerfil = 10 and IdMenu = 36)
begin
    insert into Permiso values (10, 3, 36)
end
GO 

/***CARIBE***/
/*** Dominicana ***/
if not exists(select 1 from Permiso where IdPerfil = 6 and IdMenu = 36)
begin
    insert into Permiso values (6, 13, 36)
end 
GO
/*** Puerto Rico ***/
if not exists(select 1 from Permiso where IdPerfil = 6 and IdMenu = 36)
begin
    insert into Permiso values (6, 12, 36)
end 
GO
/***Fin Caribe***/

/***CAM***/
/***Guatemala***/
if not exists(select 1 from Permiso where IdPerfil = 8 and IdMenu = 36)
begin
    insert into Permiso values (8, 8, 36)
end 
GO
if not exists(select 1 from Permiso where IdPerfil = 12 and IdMenu = 36)
begin
    insert into Permiso values (12, 8, 36)
end 
GO
/***El Salvador***/
if not exists(select 1 from Permiso where IdPerfil = 8 and IdMenu = 36)
begin
    insert into Permiso values (8, 7, 36)
end 
GO
if not exists(select 1 from Permiso where IdPerfil = 12 and IdMenu = 36)
begin
    insert into Permiso values (12, 7, 36)
end 
GO
/***Costa Rica***/
if not exists(select 1 from Permiso where IdPerfil = 8 and IdMenu = 36)
begin
    insert into Permiso values (8, 5, 36)
end 
GO
if not exists(select 1 from Permiso where IdPerfil = 12 and IdMenu = 36)
begin
    insert into Permiso values (12, 5, 36)
end 
GO
/***Panama***/
if not exists(select 1 from Permiso where IdPerfil = 8 and IdMenu = 36)
begin
    insert into Permiso values (8, 10, 36)
end 
GO
if not exists(select 1 from Permiso where IdPerfil = 12 and IdMenu = 36)
begin
    insert into Permiso values (12, 10, 36)
end 
GO
/***FIN CAM***/

/*** Ecuador ***/
if not exists(select 1 from Permiso where IdPerfil = 9 and IdMenu = 36)
begin
    insert into Permiso values (9, 6, 36)
end 
GO
if not exists(select 1 from Permiso where IdPerfil = 16 and IdMenu = 36)
begin
    insert into Permiso values (16, 6, 36)
end 
GO

/*** Colombia ***/
if not exists(select 1 from Permiso where IdPerfil = 19 and IdMenu = 36)
begin
    insert into Permiso values (19, 4, 36)
end 
GO

/*** Mexico ***/
if not exists(select 1 from Permiso where IdPerfil = 22 and IdMenu = 36)
begin
    insert into Permiso values (22, 9, 36)
end 
GO

/*** Bolivia ***/
if not exists(select 1 from Permiso where IdPerfil = 4 and IdMenu = 36)
begin
    insert into Permiso values (4, 2, 36)
end 
GO
if not exists(select 1 from Permiso where IdPerfil = 18 and IdMenu = 36)
begin
    insert into Permiso values (18, 2, 36)
end 
GO


