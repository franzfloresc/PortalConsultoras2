Alter procedure [dbo].[DelLugarPago]
  @LugarPagoID int
as
declare @Poscion int
select @Poscion=posicion from LugarPago where LugarPagoID = @LugarPagoID 
  delete LugarPago
  where LugarPagoID = @LugarPagoID 
   update LugarPago set Posicion=Posicion-1 where Posicion>@Poscion and Posicion>0
   go 