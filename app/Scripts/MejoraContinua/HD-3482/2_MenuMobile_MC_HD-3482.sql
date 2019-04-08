USE [BelcorpBolivia];
GO
if not exists(select MenuMobileID from MenuMobile where Descripcion='Mis Eventos')
begin
	declare @MenuMobilIDUltimo int = (select max(MenuMobileID) from MenuMobile);

	insert into MenuMobile(MenuMobileID,Descripcion,MenuPadreID,OrdenItem,UrlItem,UrlImagen,PaginaNueva,Posicion,[Version],EsSB2,Codigo)
	values((@MenuMobilIDUltimo+1),'Mis Eventos',0,9,'https://s3.amazonaws.com/somosbelcorpprd/FileConsultoras/PE/MisEventos.pdf','',1,'Menu','Mobile',0,null);
end

GO
USE [BelcorpChile];
GO
if not exists(select MenuMobileID from MenuMobile where Descripcion='Mis Eventos')
begin
	declare @MenuMobilIDUltimo int = (select max(MenuMobileID) from MenuMobile);

	insert into MenuMobile(MenuMobileID,Descripcion,MenuPadreID,OrdenItem,UrlItem,UrlImagen,PaginaNueva,Posicion,[Version],EsSB2,Codigo)
	values((@MenuMobilIDUltimo+1),'Mis Eventos',0,9,'https://s3.amazonaws.com/somosbelcorpprd/FileConsultoras/PE/MisEventos.pdf','',1,'Menu','Mobile',0,null);
end

GO
USE [BelcorpColombia];
GO
if not exists(select MenuMobileID from MenuMobile where Descripcion='Mis Eventos')
begin
	declare @MenuMobilIDUltimo int = (select max(MenuMobileID) from MenuMobile);

	insert into MenuMobile(MenuMobileID,Descripcion,MenuPadreID,OrdenItem,UrlItem,UrlImagen,PaginaNueva,Posicion,[Version],EsSB2,Codigo)
	values((@MenuMobilIDUltimo+1),'Mis Eventos',0,9,'https://s3.amazonaws.com/somosbelcorpprd/FileConsultoras/PE/MisEventos.pdf','',1,'Menu','Mobile',0,null);
end

GO
USE [BelcorpCostaRica];
GO
if not exists(select MenuMobileID from MenuMobile where Descripcion='Mis Eventos')
begin
	declare @MenuMobilIDUltimo int = (select max(MenuMobileID) from MenuMobile);

	insert into MenuMobile(MenuMobileID,Descripcion,MenuPadreID,OrdenItem,UrlItem,UrlImagen,PaginaNueva,Posicion,[Version],EsSB2,Codigo)
	values((@MenuMobilIDUltimo+1),'Mis Eventos',0,9,'https://s3.amazonaws.com/somosbelcorpprd/FileConsultoras/PE/MisEventos.pdf','',1,'Menu','Mobile',0,null);
end

GO
USE [BelcorpDominicana];
GO
if not exists(select MenuMobileID from MenuMobile where Descripcion='Mis Eventos')
begin
	declare @MenuMobilIDUltimo int = (select max(MenuMobileID) from MenuMobile);

	insert into MenuMobile(MenuMobileID,Descripcion,MenuPadreID,OrdenItem,UrlItem,UrlImagen,PaginaNueva,Posicion,[Version],EsSB2,Codigo)
	values((@MenuMobilIDUltimo+1),'Mis Eventos',0,9,'https://s3.amazonaws.com/somosbelcorpprd/FileConsultoras/PE/MisEventos.pdf','',1,'Menu','Mobile',0,null);
end

GO
USE [BelcorpEcuador];
GO
if not exists(select MenuMobileID from MenuMobile where Descripcion='Mis Eventos')
begin
	declare @MenuMobilIDUltimo int = (select max(MenuMobileID) from MenuMobile);

	insert into MenuMobile(MenuMobileID,Descripcion,MenuPadreID,OrdenItem,UrlItem,UrlImagen,PaginaNueva,Posicion,[Version],EsSB2,Codigo)
	values((@MenuMobilIDUltimo+1),'Mis Eventos',0,9,'https://s3.amazonaws.com/somosbelcorpprd/FileConsultoras/PE/MisEventos.pdf','',1,'Menu','Mobile',0,null);
end

GO
USE [BelcorpGuatemala];
GO
if not exists(select MenuMobileID from MenuMobile where Descripcion='Mis Eventos')
begin
	declare @MenuMobilIDUltimo int = (select max(MenuMobileID) from MenuMobile);

	insert into MenuMobile(MenuMobileID,Descripcion,MenuPadreID,OrdenItem,UrlItem,UrlImagen,PaginaNueva,Posicion,[Version],EsSB2,Codigo)
	values((@MenuMobilIDUltimo+1),'Mis Eventos',0,9,'https://s3.amazonaws.com/somosbelcorpprd/FileConsultoras/PE/MisEventos.pdf','',1,'Menu','Mobile',0,null);
end

GO
USE [BelcorpMexico];
GO
if not exists(select MenuMobileID from MenuMobile where Descripcion='Mis Eventos')
begin
	declare @MenuMobilIDUltimo int = (select max(MenuMobileID) from MenuMobile);

	insert into MenuMobile(MenuMobileID,Descripcion,MenuPadreID,OrdenItem,UrlItem,UrlImagen,PaginaNueva,Posicion,[Version],EsSB2,Codigo)
	values((@MenuMobilIDUltimo+1),'Mis Eventos',0,9,'https://s3.amazonaws.com/somosbelcorpprd/FileConsultoras/PE/MisEventos.pdf','',1,'Menu','Mobile',0,null);
end

GO
USE [BelcorpPanama];
GO
if not exists(select MenuMobileID from MenuMobile where Descripcion='Mis Eventos')
begin
	declare @MenuMobilIDUltimo int = (select max(MenuMobileID) from MenuMobile);

	insert into MenuMobile(MenuMobileID,Descripcion,MenuPadreID,OrdenItem,UrlItem,UrlImagen,PaginaNueva,Posicion,[Version],EsSB2,Codigo)
	values((@MenuMobilIDUltimo+1),'Mis Eventos',0,9,'https://s3.amazonaws.com/somosbelcorpprd/FileConsultoras/PE/MisEventos.pdf','',1,'Menu','Mobile',0,null);
end

GO
USE [BelcorpPeru];
GO
if not exists(select MenuMobileID from MenuMobile where Descripcion='Mis Eventos')
begin
	declare @MenuMobilIDUltimo int = (select max(MenuMobileID) from MenuMobile);

	insert into MenuMobile(MenuMobileID,Descripcion,MenuPadreID,OrdenItem,UrlItem,UrlImagen,PaginaNueva,Posicion,[Version],EsSB2,Codigo)
	values((@MenuMobilIDUltimo+1),'Mis Eventos',0,9,'https://s3.amazonaws.com/somosbelcorpprd/FileConsultoras/PE/MisEventos.pdf','',1,'Menu','Mobile',1,null);
end

GO
USE [BelcorpPuertoRico];
GO
if not exists(select MenuMobileID from MenuMobile where Descripcion='Mis Eventos')
begin
	declare @MenuMobilIDUltimo int = (select max(MenuMobileID) from MenuMobile);

	insert into MenuMobile(MenuMobileID,Descripcion,MenuPadreID,OrdenItem,UrlItem,UrlImagen,PaginaNueva,Posicion,[Version],EsSB2,Codigo)
	values((@MenuMobilIDUltimo+1),'Mis Eventos',0,9,'https://s3.amazonaws.com/somosbelcorpprd/FileConsultoras/PE/MisEventos.pdf','',1,'Menu','Mobile',0,null);
end

GO
USE [BelcorpSalvador];
GO
if not exists(select MenuMobileID from MenuMobile where Descripcion='Mis Eventos')
begin
	declare @MenuMobilIDUltimo int = (select max(MenuMobileID) from MenuMobile);

	insert into MenuMobile(MenuMobileID,Descripcion,MenuPadreID,OrdenItem,UrlItem,UrlImagen,PaginaNueva,Posicion,[Version],EsSB2,Codigo)
	values((@MenuMobilIDUltimo+1),'Mis Eventos',0,9,'https://s3.amazonaws.com/somosbelcorpprd/FileConsultoras/PE/MisEventos.pdf','',1,'Menu','Mobile',0,null);
end

GO
