USE BelcorpPeru;
GO
UPDATE Permiso SET Descripcion = 'TU VOZ ONLINE', UrlItem='https://esikatuvozonline.questionpro.com', PaginaNueva=1  WHERE Descripcion='MI COMUNIDAD';
UPDATE MenuMobile SET Descripcion = 'Tu Voz Online', UrlItem='https://esikatuvozonline.questionpro.com' WHERE Descripcion='Mi Comunidad' and EsSB2=1;

GO

USE BelcorpColombia;
GO
UPDATE Permiso SET Descripcion = 'TU VOZ ONLINE', UrlItem='https://esikatuvozonline.questionpro.com', PaginaNueva=1  WHERE Descripcion='MI COMUNIDAD';
UPDATE MenuMobile SET Descripcion = 'Tu Voz Online', UrlItem='https://esikatuvozonline.questionpro.com' WHERE Descripcion='Mi Comunidad' and EsSB2=1;
