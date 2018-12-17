USE BelcorpPeru;
GO
UPDATE Permiso SET Descripcion = 'MI COMUNIDAD', UrlItem='Comunidad/Index', PaginaNueva=0 WHERE Descripcion='TU VOZ ONLINE';
UPDATE MenuMobile SET Descripcion = 'Mi Comunidad', UrlItem='Comunidad/Index' WHERE Descripcion='Tu Voz Online' and EsSB2=1;

GO

USE BelcorpColombia;
GO
UPDATE Permiso SET Descripcion = 'MI COMUNIDAD', UrlItem='Comunidad/Index', PaginaNueva=0 WHERE Descripcion='TU VOZ ONLINE';
UPDATE MenuMobile SET Descripcion = 'Mi Comunidad', UrlItem='Comunidad/Index' WHERE Descripcion='Tu Voz Online' and EsSB2=1;
