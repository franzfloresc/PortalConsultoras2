
if not exists(select MenuMobileID from MenuMobile where UrlItem='Mobile/MisReclamos')
begin
	declare @MenuMobilIDUltimo int = (select max(MenuMobileID) from MenuMobile);

	insert into MenuMobile(MenuMobileID,Descripcion,MenuPadreID,OrdenItem,UrlItem,UrlImagen,PaginaNueva,Posicion,[Version],EsSB2,Codigo)
	values((@MenuMobilIDUltimo+1),'Cambios y devoluciones',1001,19,'Mobile/MisReclamos','',0,'Menu','Mobile',1,null);
end
GO
