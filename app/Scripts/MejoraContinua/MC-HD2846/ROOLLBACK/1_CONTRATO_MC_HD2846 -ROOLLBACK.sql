use belcorpColombia
go

DELETE FROM Permiso
WHERE PermisoID=1070

DELETE FROM RolPermiso
WHERE RolID=3 AND PermisoID=1070
  
GO