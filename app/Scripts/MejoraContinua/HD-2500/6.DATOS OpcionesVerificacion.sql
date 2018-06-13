USE [BelcorpBolivia]
GO

delete from FiltrosOpcionesVerificacion
DBCC CHECKIDENT(FiltrosOpcionesVerificacion, RESEED, 0)
delete from ZonasOpcionesVerificacion
DBCC CHECKIDENT(ZonasOpcionesVerificacion, RESEED, 0)
delete from OpcionesVerificacion

go

insert into OpcionesVerificacion values (1, 'Olvide Contrasenia', 1, 1, 1, 1, 0, 0, 1),
										(2, 'Verificacion Autenticidad', 1, 1, 1, 0, 1, 1, 1),
										(3, 'Actualizar Datos', 1, 1, 1, 0, 0, 0, 0)

GO

insert into ZonasOpcionesVerificacion values (15, 1, 2),
											 (81, 1, 2),
											 (31, 1, 2),
											 (148, 1, 2),
											 (48, 1, 2)
GO


insert into FiltrosOpcionesVerificacion values (1, 0, 0, 'Por ser la primera vez que ingresas y por tu seguridad vamos a verificar tus datos.', 1, 2),
											   (7, 0, 0, '¡Nos alegras que hayas vuelto! Como hace tiempo que no sabíamos de ti, por tu seguridad vamos a verificar tus datos.', 1, 2)


