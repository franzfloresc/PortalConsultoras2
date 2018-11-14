USE BelcorpBolivia;

GO
USE BelcorpChile;

GO
USE BelcorpColombia;
GO
UPDATE Permiso SET Descripcion = 'TU VOZ ONLINE', UrlItem='https://esikatuvozonline.questionpro.com', PaginaNueva=1  WHERE Descripcion='MI COMUNIDAD';
UPDATE MenuMobile SET Descripcion = 'Tu Voz Online', UrlItem='https://esikatuvozonline.questionpro.com' WHERE Descripcion='Mi Comunidad' and EsSB2=1;

GO
USE BelcorpCostaRica;

GO
USE BelcorpDominicana;

GO
USE BelcorpEcuador;

GO
USE BelcorpGuatemala;
GO

USE BelcorpMexico;
GO

USE BelcorpPanama;
GO

USE BelcorpPeru;
GO
UPDATE Permiso SET Descripcion = 'TU VOZ ONLINE', UrlItem='https://esikatuvozonline.questionpro.com', PaginaNueva=1  WHERE Descripcion='MI COMUNIDAD';
UPDATE MenuMobile SET Descripcion = 'Tu Voz Online', UrlItem='https://esikatuvozonline.questionpro.com' WHERE Descripcion='Mi Comunidad' and EsSB2=1;

GO
USE BelcorpPuertoRico;
GO

USE BelcorpSalvador;
GO

