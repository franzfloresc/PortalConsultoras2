USE BelcorpPeru;
GO

if not exists(select MenuMobileID from MenuMobile where Descripcion='Mis Eventos')
begin
	declare @MenuMobilIDUltimo int = (select max(MenuMobileID) from MenuMobile);

	insert into MenuMobile(MenuMobileID,Descripcion,MenuPadreID,OrdenItem,UrlItem,UrlImagen,PaginaNueva,Posicion,[Version],EsSB2,Codigo)
	values((@MenuMobilIDUltimo+1),'Mis Eventos',0,9,'https://s3.amazonaws.com/somosbelcorpqa/FileConsultoras/PE/MisEventos.pdf','',1,'Menu','Mobile',1,null);
end
GO
