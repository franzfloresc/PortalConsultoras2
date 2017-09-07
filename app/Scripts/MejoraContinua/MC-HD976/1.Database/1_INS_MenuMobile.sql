GO
if not exists(select MenuMobileID from MenuMobile where UrlItem='Mobile/MisDatos')
begin
	declare @MenuMobilIDUltimo int = (select max(MenuMobileID) from MenuMobile);

	insert into MenuMobile(MenuMobileID,Descripcion,MenuPadreID,OrdenItem,UrlItem,UrlImagen,PaginaNueva,Posicion,[Version],EsSB2,Codigo)
	values((@MenuMobilIDUltimo+1),'Mis datos',1001,18,'Mobile/MisDatos','',0,'Menu','Mobile',1,null);
end
GO