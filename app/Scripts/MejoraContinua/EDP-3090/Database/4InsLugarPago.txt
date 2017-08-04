Alter procedure [dbo].[InsLugarPago]
  @PaisID int, 
  --@CampaniaID int, 
  @ConsultoraID bigint, 
  @Nombre varchar(150), 
  @UrlSitio varchar(1000), 
  @ArchivoLogo varchar(3000), 
  @ArchivoInstructivo varchar(3000),
  @TextoPago varchar(100)='',
  @Posicion int=0
as
declare @CantidadPosicion int 
set @CantidadPosicion=(select count(Posicion) from LugarPago where Posicion=@Posicion)
if(@CantidadPosicion=0)
begin
		insert LugarPago (PaisID, ConsultoraID, Nombre, UrlSitio, ArchivoLogo, ArchivoInstructivo,TextoPago,Posicion)
		values (@PaisID, @ConsultoraID, @Nombre, @UrlSitio, @ArchivoLogo, @ArchivoInstructivo,@TextoPago,@Posicion)
	select @Posicion
end
  else
  select -1