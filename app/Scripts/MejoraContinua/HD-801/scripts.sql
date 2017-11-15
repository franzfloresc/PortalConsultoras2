USE BelcorpColombia
go

if not exists(select 1 from Permiso where Descripcion = 'Mis certificados')
begin

	-- MENNU Y PERMISO
	DECLARE @IDPadre INT = 1003
	DECLARE @RolID INT = 1
	DECLARE @PermisoID INT
	DECLARE @OrdenItem INT

	
	-- select * from Permiso  WHERE IDPadre = 1003
	SELECT @PermisoID=MAX(PermisoID) FROM Permiso
	SELECT @OrdenItem=MAX(OrdenItem) FROM Permiso WHERE IDPadre = @IDPadre;
	--SELECT @PermisoID, @OrdenItem

	INSERT INTO Permiso
	(PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal, Codigo)
	VALUES(@PermisoID+1, 'Mis certificados', @IDPadre, @OrdenItem + 1,'MisCertificados/Index',0,'Header','',0,0,0,1,'MisCertificados')
	INSERT INTO RolPermiso(RolID, PermisoID, Activo, Mostrar) VALUES(@RolID, @PermisoID + 1, 1, 1)

end

GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TieneCampaniaConsecutivas]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].TieneCampaniaConsecutivas
GO

create procedure dbo.TieneCampaniaConsecutivas
@CampaniaId varchar(6),
@CantidadCampaniaConsecutiva int,
@ConsultoraId bigint
as
/*
TieneCampaniaConsecutivas '201716',3,351
TieneCampaniaConsecutivas '201717',3,351
*/
begin

declare @TiemeCampaniaConsecutiva bit = 0

declare @campaniafin varchar(6) = ffvv.fnGetCampaniaAnterior(@CampaniaId, 1)
declare @campaniainicio varchar(6) = ffvv.fnGetCampaniaAnterior(@CampaniaId, @CantidadCampaniaConsecutiva)

declare @NumeroCampaniaPedido int = 0
select @NumeroCampaniaPedido = count(*) 
from ods.Pedido 
where consultoraid=@ConsultoraId 
and campaniaid in (
  select campaniaid 
    from ods.campania 
    where @campaniainicio <= codigo and codigo <= @campaniafin
)

end

if (@CantidadCampaniaConsecutiva = @NumeroCampaniaPedido)
	set @TiemeCampaniaConsecutiva = 1
else
	set @TiemeCampaniaConsecutiva = 0

select @TiemeCampaniaConsecutiva as TiemeCampaniaConsecutiva

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerPromedioVentaCampaniaConsecutivas]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerPromedioVentaCampaniaConsecutivas
GO

create procedure dbo.ObtenerPromedioVentaCampaniaConsecutivas
@CampaniaId varchar(6),
@CantidadCampaniaConsecutiva int,
@ConsultoraId bigint
as
/*
ObtenerPromedioVentaCampaniaConsecutivas '201717',3,351
ObtenerPromedioVentaCampaniaConsecutivas '201716',3,351
*/
begin

declare @campaniafin varchar(6) = ffvv.fnGetCampaniaAnterior(@CampaniaId, 1)
declare @campaniainicio varchar(6) = ffvv.fnGetCampaniaAnterior(@CampaniaId, @CantidadCampaniaConsecutiva)

declare @PromedioVenta decimal(18,2) = 0
declare @TotalPedido decimal(18,2) = 0

select @TotalPedido = sum(MontoTotalPedido)
from ods.Pedido 
where consultoraid=@ConsultoraId 
and campaniaid in (
  select campaniaid 
    from ods.campania 
    where @campaniainicio <= codigo and codigo <= @campaniafin
)

set @PromedioVenta = @TotalPedido / @CantidadCampaniaConsecutiva

select @PromedioVenta

end

go