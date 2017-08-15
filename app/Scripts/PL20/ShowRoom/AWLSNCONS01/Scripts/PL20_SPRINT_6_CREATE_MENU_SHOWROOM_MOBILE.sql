USE BelcorpBolivia
GO

declare @UrlItem varchar(2030)
declare @Descripcion varchar(75)
set @UrlItem = ''
set @Descripcion = 'GRAN VENTA ONLINE'

if (select count(*) from MenuMobile where ltrim(rtrim(Descripcion)) = @Descripcion) = 0
begin
	declare @MenuMobileID int
 set @MenuMobileID = (select max(MenuMobileID) + 1 from MenuMobile)

 insert into MenuMobile(MenuMobileID,Descripcion,MenuPadreID,OrdenItem,UrlItem,UrlImagen,PaginaNueva,Posicion,Version,EsSB2)
 values(@MenuMobileID,@Descripcion,0,1,@UrlItem,@UrlItem,0,'Menu','Mobile',1)
end

/*end*/

USE BelcorpChile
GO

declare @UrlItem varchar(2030)
declare @Descripcion varchar(75)
set @UrlItem = ''
set @Descripcion = 'GRAN VENTA ONLINE'

if (select count(*) from MenuMobile where ltrim(rtrim(Descripcion)) = @Descripcion) = 0
begin
	declare @MenuMobileID int
 set @MenuMobileID = (select max(MenuMobileID) + 1 from MenuMobile)

 insert into MenuMobile(MenuMobileID,Descripcion,MenuPadreID,OrdenItem,UrlItem,UrlImagen,PaginaNueva,Posicion,Version,EsSB2)
 values(@MenuMobileID,@Descripcion,0,1,@UrlItem,@UrlItem,0,'Menu','Mobile',1)
end

/*end*/

USE BelcorpColombia
GO

declare @UrlItem varchar(2030)
declare @Descripcion varchar(75)
set @UrlItem = ''
set @Descripcion = 'GRAN VENTA ONLINE'

if (select count(*) from MenuMobile where ltrim(rtrim(Descripcion)) = @Descripcion) = 0
begin
	declare @MenuMobileID int
 set @MenuMobileID = (select max(MenuMobileID) + 1 from MenuMobile)

 insert into MenuMobile(MenuMobileID,Descripcion,MenuPadreID,OrdenItem,UrlItem,UrlImagen,PaginaNueva,Posicion,Version,EsSB2)
 values(@MenuMobileID,@Descripcion,0,1,@UrlItem,@UrlItem,0,'Menu','Mobile',1)
end

/*end*/

USE BelcorpCostaRica
GO

declare @UrlItem varchar(2030)
declare @Descripcion varchar(75)
set @UrlItem = ''
set @Descripcion = 'GRAN VENTA ONLINE'

if (select count(*) from MenuMobile where ltrim(rtrim(Descripcion)) = @Descripcion) = 0
begin
	declare @MenuMobileID int
 set @MenuMobileID = (select max(MenuMobileID) + 1 from MenuMobile)

 insert into MenuMobile(MenuMobileID,Descripcion,MenuPadreID,OrdenItem,UrlItem,UrlImagen,PaginaNueva,Posicion,Version,EsSB2)
 values(@MenuMobileID,@Descripcion,0,1,@UrlItem,@UrlItem,0,'Menu','Mobile',1)
end

/*end*/

USE BelcorpDominicana
GO

declare @UrlItem varchar(2030)
declare @Descripcion varchar(75)
set @UrlItem = ''
set @Descripcion = 'GRAN VENTA ONLINE'

if (select count(*) from MenuMobile where ltrim(rtrim(Descripcion)) = @Descripcion) = 0
begin
	declare @MenuMobileID int
 set @MenuMobileID = (select max(MenuMobileID) + 1 from MenuMobile)

 insert into MenuMobile(MenuMobileID,Descripcion,MenuPadreID,OrdenItem,UrlItem,UrlImagen,PaginaNueva,Posicion,Version,EsSB2)
 values(@MenuMobileID,@Descripcion,0,1,@UrlItem,@UrlItem,0,'Menu','Mobile',1)
end

/*end*/

USE BelcorpEcuador
GO

declare @UrlItem varchar(2030)
declare @Descripcion varchar(75)
set @UrlItem = ''
set @Descripcion = 'GRAN VENTA ONLINE'

if (select count(*) from MenuMobile where ltrim(rtrim(Descripcion)) = @Descripcion) = 0
begin
	declare @MenuMobileID int
 set @MenuMobileID = (select max(MenuMobileID) + 1 from MenuMobile)

 insert into MenuMobile(MenuMobileID,Descripcion,MenuPadreID,OrdenItem,UrlItem,UrlImagen,PaginaNueva,Posicion,Version,EsSB2)
 values(@MenuMobileID,@Descripcion,0,1,@UrlItem,@UrlItem,0,'Menu','Mobile',1)
end

/*end*/

USE BelcorpGuatemala
GO

declare @UrlItem varchar(2030)
declare @Descripcion varchar(75)
set @UrlItem = ''
set @Descripcion = 'GRAN VENTA ONLINE'

if (select count(*) from MenuMobile where ltrim(rtrim(Descripcion)) = @Descripcion) = 0
begin
	declare @MenuMobileID int
 set @MenuMobileID = (select max(MenuMobileID) + 1 from MenuMobile)

 insert into MenuMobile(MenuMobileID,Descripcion,MenuPadreID,OrdenItem,UrlItem,UrlImagen,PaginaNueva,Posicion,Version,EsSB2)
 values(@MenuMobileID,@Descripcion,0,1,@UrlItem,@UrlItem,0,'Menu','Mobile',1)
end

/*end*/

USE BelcorpMexico
GO

declare @UrlItem varchar(2030)
declare @Descripcion varchar(75)
set @UrlItem = ''
set @Descripcion = 'GRAN VENTA ONLINE'

if (select count(*) from MenuMobile where ltrim(rtrim(Descripcion)) = @Descripcion) = 0
begin
	declare @MenuMobileID int
 set @MenuMobileID = (select max(MenuMobileID) + 1 from MenuMobile)

 insert into MenuMobile(MenuMobileID,Descripcion,MenuPadreID,OrdenItem,UrlItem,UrlImagen,PaginaNueva,Posicion,Version,EsSB2)
 values(@MenuMobileID,@Descripcion,0,1,@UrlItem,@UrlItem,0,'Menu','Mobile',1)
end

/*end*/

USE BelcorpPanama
GO

declare @UrlItem varchar(2030)
declare @Descripcion varchar(75)
set @UrlItem = ''
set @Descripcion = 'GRAN VENTA ONLINE'

if (select count(*) from MenuMobile where ltrim(rtrim(Descripcion)) = @Descripcion) = 0
begin
	declare @MenuMobileID int
 set @MenuMobileID = (select max(MenuMobileID) + 1 from MenuMobile)

 insert into MenuMobile(MenuMobileID,Descripcion,MenuPadreID,OrdenItem,UrlItem,UrlImagen,PaginaNueva,Posicion,Version,EsSB2)
 values(@MenuMobileID,@Descripcion,0,1,@UrlItem,@UrlItem,0,'Menu','Mobile',1)
end

/*end*/

USE BelcorpPeru
GO

declare @UrlItem varchar(2030)
declare @Descripcion varchar(75)
set @UrlItem = ''
set @Descripcion = 'GRAN VENTA ONLINE'

if (select count(*) from MenuMobile where ltrim(rtrim(Descripcion)) = @Descripcion) = 0
begin
	declare @MenuMobileID int
 set @MenuMobileID = (select max(MenuMobileID) + 1 from MenuMobile)

 insert into MenuMobile(MenuMobileID,Descripcion,MenuPadreID,OrdenItem,UrlItem,UrlImagen,PaginaNueva,Posicion,Version,EsSB2)
 values(@MenuMobileID,@Descripcion,0,1,@UrlItem,@UrlItem,0,'Menu','Mobile',1)
end

/*end*/

USE BelcorpPuertoRico
GO

declare @UrlItem varchar(2030)
declare @Descripcion varchar(75)
set @UrlItem = ''
set @Descripcion = 'GRAN VENTA ONLINE'

if (select count(*) from MenuMobile where ltrim(rtrim(Descripcion)) = @Descripcion) = 0
begin
	declare @MenuMobileID int
 set @MenuMobileID = (select max(MenuMobileID) + 1 from MenuMobile)

 insert into MenuMobile(MenuMobileID,Descripcion,MenuPadreID,OrdenItem,UrlItem,UrlImagen,PaginaNueva,Posicion,Version,EsSB2)
 values(@MenuMobileID,@Descripcion,0,1,@UrlItem,@UrlItem,0,'Menu','Mobile',1)
end

/*end*/

USE BelcorpSalvador
GO

declare @UrlItem varchar(2030)
declare @Descripcion varchar(75)
set @UrlItem = ''
set @Descripcion = 'GRAN VENTA ONLINE'

if (select count(*) from MenuMobile where ltrim(rtrim(Descripcion)) = @Descripcion) = 0
begin
	declare @MenuMobileID int
 set @MenuMobileID = (select max(MenuMobileID) + 1 from MenuMobile)

 insert into MenuMobile(MenuMobileID,Descripcion,MenuPadreID,OrdenItem,UrlItem,UrlImagen,PaginaNueva,Posicion,Version,EsSB2)
 values(@MenuMobileID,@Descripcion,0,1,@UrlItem,@UrlItem,0,'Menu','Mobile',1)
end

/*end*/

USE BelcorpVenezuela
GO

declare @UrlItem varchar(2030)
declare @Descripcion varchar(75)
set @UrlItem = ''
set @Descripcion = 'GRAN VENTA ONLINE'

if (select count(*) from MenuMobile where ltrim(rtrim(Descripcion)) = @Descripcion) = 0
begin
	declare @MenuMobileID int
 set @MenuMobileID = (select max(MenuMobileID) + 1 from MenuMobile)

 insert into MenuMobile(MenuMobileID,Descripcion,MenuPadreID,OrdenItem,UrlItem,UrlImagen,PaginaNueva,Posicion,Version,EsSB2)
 values(@MenuMobileID,@Descripcion,0,1,@UrlItem,@UrlItem,0,'Menu','Mobile',1)
end


