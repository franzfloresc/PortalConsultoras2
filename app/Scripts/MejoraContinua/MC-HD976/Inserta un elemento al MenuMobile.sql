Declare @MenuMobilIDUltimo int
set @MenuMobilIDUltimo=(select max(MenuMobileID) from MenuMobile) 
if not exists(select MenuMobileID from MenuMobile where UrlItem='Mobile/MisDatos')
	begin
		insert into MenuMobile values((@MenuMobilIDUltimo+1),'Mis datos',1001,18,'Mobile/MisDatos',0,'Menu','','Mobile',1,null)
	end
else 
begin
print 'El Id de menu ya existe'
end
