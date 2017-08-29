if not exists(select MenuMobileID from MenuMobile where MenuMobileID=1043)
	begin
		insert into MenuMobile values(1043,'Mis datos',1001,18,'Mobile/MisDatos',0,'Menu','','Mobile',1,null)
	end
else
begin
print 'El Id de menu ya existe'
end