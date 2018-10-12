USE BelcorpCostaRica
GO 
if not exists(select 1 from Permiso where Descripcion = 'Zona de Estrategias MSSQL')
begin

	-- MENU Y PERMISO
	--@IDPadre => Consultora: 1003, SAC: 81, ADMCONTENIDO: 111
	DECLARE @IDPadre INT = 111
	--@RolID Consultora: 1, SAC: 3, ADMCONTENIDO: 4
	DECLARE @RolID INT = 4
	DECLARE @PermisoID INT
	DECLARE @OrdenItem INT

	
	-- select * from Permiso  WHERE IDPadre = 81
	SELECT @PermisoID=MAX(PermisoID) FROM Permiso
	SELECT @OrdenItem=MAX(OrdenItem) FROM Permiso WHERE IDPadre = @IDPadre;
	--SELECT @PermisoID, @OrdenItem

	INSERT INTO Permiso
	(PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal, Codigo)
	VALUES(@PermisoID+1, 'Zona de Estrategias MSSQL', @IDPadre, @OrdenItem + 1,'AdministrarEstrategia/Index?dbdefault=true',0,'Header','',0,0,0,1,null)
	INSERT INTO RolPermiso(RolID, PermisoID, Activo, Mostrar) VALUES(@RolID, @PermisoID + 1, 1, 1)

end

GO


