use SoporteConsultoras
GO

/*** Peru ***/
if exists(select 1 from Permiso where IdPerfil = 7 and IdMenu = 36)
begin
    delete from Permiso where IdPerfil = 7 and IdMenu = 36
end
GO 
if exists(select 1 from Permiso where IdPerfil = 14 and IdMenu = 36)
begin
    delete from Permiso where IdPerfil = 14 and IdMenu = 36
end
GO
/*** Chile ***/
if exists(select 1 from Permiso where IdPerfil = 10 and IdMenu = 36)
begin
    delete from Permiso where IdPerfil = 10 and IdMenu = 36
end
GO 

/***CARIBE***/
/*** Dominicana ***/
if exists(select 1 from Permiso where IdPerfil = 6 and IdMenu = 36)
begin
    delete from Permiso where IdPerfil = 6 and IdMenu = 36
end 
GO
/*** Puerto Rico ***/
if exists(select 1 from Permiso where IdPerfil = 6 and IdMenu = 36)
begin
    delete from Permiso where IdPerfil = 6 and IdMenu = 36
end 
GO
/***Fin Caribe***/

/***CAM***/
/***Guatemala***/
if exists(select 1 from Permiso where IdPerfil = 8 and IdMenu = 36)
begin
    delete from Permiso where IdPerfil = 8 and IdMenu = 36
end 
GO
if exists(select 1 from Permiso where IdPerfil = 12 and IdMenu = 36)
begin
    delete from Permiso where IdPerfil = 12 and IdMenu = 36
end 
GO
/***El Salvador***/
if exists(select 1 from Permiso where IdPerfil = 8 and IdMenu = 36)
begin
    delete from Permiso where IdPerfil = 8 and IdMenu = 36
end 
GO
if exists(select 1 from Permiso where IdPerfil = 12 and IdMenu = 36)
begin
    delete from Permiso where IdPerfil = 12 and IdMenu = 36
end 
GO
/***Costa Rica***/
if exists(select 1 from Permiso where IdPerfil = 8 and IdMenu = 36)
begin
    delete from Permiso where IdPerfil = 8 and IdMenu = 36
end 
GO
if exists(select 1 from Permiso where IdPerfil = 12 and IdMenu = 36)
begin
    delete from Permiso where IdPerfil = 12 and IdMenu = 36
end 
GO
/***Panama***/
if exists(select 1 from Permiso where IdPerfil = 8 and IdMenu = 36)
begin
    delete from Permiso where IdPerfil = 8 and IdMenu = 36
end 
GO
if exists(select 1 from Permiso where IdPerfil = 12 and IdMenu = 36)
begin
    delete from Permiso where IdPerfil = 12 and IdMenu = 36
end 
GO
/***FIN CAM***/

/*** Ecuador ***/
if exists(select 1 from Permiso where IdPerfil = 9 and IdMenu = 36)
begin
    delete from Permiso where IdPerfil = 9 and IdMenu = 36
end 
GO
if exists(select 1 from Permiso where IdPerfil = 16 and IdMenu = 36)
begin
    delete from Permiso where IdPerfil = 16 and IdMenu = 36
end 
GO

/*** Colombia ***/
if exists(select 1 from Permiso where IdPerfil = 19 and IdMenu = 36)
begin
    delete from Permiso where IdPerfil = 19 and IdMenu = 36
end 
GO

/*** Mexico ***/
if exists(select 1 from Permiso where IdPerfil = 22 and IdMenu = 36)
begin
    delete from Permiso where IdPerfil = 22 and IdMenu = 36
end 
GO

/*** Bolivia ***/
if exists(select 1 from Permiso where IdPerfil = 4 and IdMenu = 36)
begin
    delete from Permiso where IdPerfil = 4 and IdMenu = 36
end 
GO
if not exists(select 1 from Permiso where IdPerfil = 18 and IdMenu = 36)
begin
    delete from Permiso where IdPerfil = 18 and IdMenu = 36
end 
GO

/**** Eliminando Menu *****/
if exists(select 1 from Menu where seccion='Consultoras' and IdMEnu = 36)
begin
	delete from Menu where seccion='Consultoras' and IdMEnu = 36
end
GO
