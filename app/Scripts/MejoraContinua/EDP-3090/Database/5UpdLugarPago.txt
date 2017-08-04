Alter procedure [dbo].[UpdLugarPago]
  @LugarPagoID int,
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
select  @CantidadPosicion=count(*) from LugarPago where LugarPagoID!=@LugarPagoID and Posicion=@Posicion
  if (@CantidadPosicion=0)
	  begin 
		  update LugarPago
		  set PaisID=@PaisID, 
		  --CampaniaID=@CampaniaID, 
		  ConsultoraID=@ConsultoraID, 
		  Nombre=@Nombre, 
		  UrlSitio=@UrlSitio, 
		  ArchivoLogo=@ArchivoLogo, 
		  ArchivoInstructivo=@ArchivoInstructivo,
		  TextoPago=@TextoPago,
		  Posicion=@Posicion
		  where LugarPagoID = @LugarPagoID
		  select @Posicion
	  end
  else
  select-1
go 