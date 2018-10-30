USE BelcorpPeru
GO

declare @TablaLogicaID int = 10
if not exists (select 1 from TablaLogica where TablaLogicaID = @TablaLogicaID)
begin
	insert into TablaLogica values (@TablaLogicaID, 'Mensajes Tooltip Perfil')
	insert into TablaLogicaDatos values (cast(@TablaLogicaID as varchar(2)) + '01', @TablaLogicaID, 'smsemail', 'Se muestra cuando solo esta pendiente actualizar su correo y celular ', 'Ingresa y actualiza tu correo y/o celular para poder contactarnos contigo.'),
										(cast(@TablaLogicaID as varchar(2)) + '02', @TablaLogicaID, 'sms', 'Se muestra cuando esta pendiente actualizar el celular', 'Ingresa y actualiza tu celular para acceder a nuestros beneficios.'),
										(cast(@TablaLogicaID as varchar(2)) + '03', @TablaLogicaID, 'email', 'Se muestra cuando esta pendiente actualizar el correo', 'Ingresa y actualiza tu correo para acceder a nuestros beneficios.')
end
Go

USE BelcorpMexico
GO

declare @TablaLogicaID int = 10
if not exists (select 1 from TablaLogica where TablaLogicaID = @TablaLogicaID)
begin
	insert into TablaLogica values (@TablaLogicaID, 'Mensajes Tooltip Perfil')
	insert into TablaLogicaDatos values (cast(@TablaLogicaID as varchar(2)) + '01', @TablaLogicaID, 'smsemail', 'Se muestra cuando solo esta pendiente actualizar su correo y celular ', 'Ingresa y actualiza tu correo y/o celular para poder contactarnos contigo.'),
										(cast(@TablaLogicaID as varchar(2)) + '02', @TablaLogicaID, 'sms', 'Se muestra cuando esta pendiente actualizar el celular', 'Ingresa y actualiza tu celular para acceder a nuestros beneficios.'),
										(cast(@TablaLogicaID as varchar(2)) + '03', @TablaLogicaID, 'email', 'Se muestra cuando esta pendiente actualizar el correo', 'Ingresa y actualiza tu correo para acceder a nuestros beneficios.')
end
Go

USE BelcorpColombia
GO

declare @TablaLogicaID int = 10
if not exists (select 1 from TablaLogica where TablaLogicaID = @TablaLogicaID)
begin
	insert into TablaLogica values (@TablaLogicaID, 'Mensajes Tooltip Perfil')
	insert into TablaLogicaDatos values (cast(@TablaLogicaID as varchar(2)) + '01', @TablaLogicaID, 'smsemail', 'Se muestra cuando solo esta pendiente actualizar su correo y celular ', 'Ingresa y actualiza tu correo y/o celular para poder contactarnos contigo.'),
										(cast(@TablaLogicaID as varchar(2)) + '02', @TablaLogicaID, 'sms', 'Se muestra cuando esta pendiente actualizar el celular', 'Ingresa y actualiza tu celular para acceder a nuestros beneficios.'),
										(cast(@TablaLogicaID as varchar(2)) + '03', @TablaLogicaID, 'email', 'Se muestra cuando esta pendiente actualizar el correo', 'Ingresa y actualiza tu correo para acceder a nuestros beneficios.')
end
Go

USE BelcorpSalvador
GO

declare @TablaLogicaID int = 10
if not exists (select 1 from TablaLogica where TablaLogicaID = @TablaLogicaID)
begin
	insert into TablaLogica values (@TablaLogicaID, 'Mensajes Tooltip Perfil')
	insert into TablaLogicaDatos values (cast(@TablaLogicaID as varchar(2)) + '01', @TablaLogicaID, 'smsemail', 'Se muestra cuando solo esta pendiente actualizar su correo y celular ', 'Ingresa y actualiza tu correo y/o celular para poder contactarnos contigo.'),
										(cast(@TablaLogicaID as varchar(2)) + '02', @TablaLogicaID, 'sms', 'Se muestra cuando esta pendiente actualizar el celular', 'Ingresa y actualiza tu celular para acceder a nuestros beneficios.'),
										(cast(@TablaLogicaID as varchar(2)) + '03', @TablaLogicaID, 'email', 'Se muestra cuando esta pendiente actualizar el correo', 'Ingresa y actualiza tu correo para acceder a nuestros beneficios.')
end
Go

USE BelcorpPuertoRico
GO

declare @TablaLogicaID int = 10
if not exists (select 1 from TablaLogica where TablaLogicaID = @TablaLogicaID)
begin
	insert into TablaLogica values (@TablaLogicaID, 'Mensajes Tooltip Perfil')
	insert into TablaLogicaDatos values (cast(@TablaLogicaID as varchar(2)) + '01', @TablaLogicaID, 'smsemail', 'Se muestra cuando solo esta pendiente actualizar su correo y celular ', 'Ingresa y actualiza tu correo y/o celular para poder contactarnos contigo.'),
										(cast(@TablaLogicaID as varchar(2)) + '02', @TablaLogicaID, 'sms', 'Se muestra cuando esta pendiente actualizar el celular', 'Ingresa y actualiza tu celular para acceder a nuestros beneficios.'),
										(cast(@TablaLogicaID as varchar(2)) + '03', @TablaLogicaID, 'email', 'Se muestra cuando esta pendiente actualizar el correo', 'Ingresa y actualiza tu correo para acceder a nuestros beneficios.')
end
Go

USE BelcorpPanama
GO

declare @TablaLogicaID int = 10
if not exists (select 1 from TablaLogica where TablaLogicaID = @TablaLogicaID)
begin
	insert into TablaLogica values (@TablaLogicaID, 'Mensajes Tooltip Perfil')
	insert into TablaLogicaDatos values (cast(@TablaLogicaID as varchar(2)) + '01', @TablaLogicaID, 'smsemail', 'Se muestra cuando solo esta pendiente actualizar su correo y celular ', 'Ingresa y actualiza tu correo y/o celular para poder contactarnos contigo.'),
										(cast(@TablaLogicaID as varchar(2)) + '02', @TablaLogicaID, 'sms', 'Se muestra cuando esta pendiente actualizar el celular', 'Ingresa y actualiza tu celular para acceder a nuestros beneficios.'),
										(cast(@TablaLogicaID as varchar(2)) + '03', @TablaLogicaID, 'email', 'Se muestra cuando esta pendiente actualizar el correo', 'Ingresa y actualiza tu correo para acceder a nuestros beneficios.')
end
Go

USE BelcorpGuatemala
GO

declare @TablaLogicaID int = 10
if not exists (select 1 from TablaLogica where TablaLogicaID = @TablaLogicaID)
begin
	insert into TablaLogica values (@TablaLogicaID, 'Mensajes Tooltip Perfil')
	insert into TablaLogicaDatos values (cast(@TablaLogicaID as varchar(2)) + '01', @TablaLogicaID, 'smsemail', 'Se muestra cuando solo esta pendiente actualizar su correo y celular ', 'Ingresa y actualiza tu correo y/o celular para poder contactarnos contigo.'),
										(cast(@TablaLogicaID as varchar(2)) + '02', @TablaLogicaID, 'sms', 'Se muestra cuando esta pendiente actualizar el celular', 'Ingresa y actualiza tu celular para acceder a nuestros beneficios.'),
										(cast(@TablaLogicaID as varchar(2)) + '03', @TablaLogicaID, 'email', 'Se muestra cuando esta pendiente actualizar el correo', 'Ingresa y actualiza tu correo para acceder a nuestros beneficios.')
end
Go

USE BelcorpEcuador
GO

declare @TablaLogicaID int = 10
if not exists (select 1 from TablaLogica where TablaLogicaID = @TablaLogicaID)
begin
	insert into TablaLogica values (@TablaLogicaID, 'Mensajes Tooltip Perfil')
	insert into TablaLogicaDatos values (cast(@TablaLogicaID as varchar(2)) + '01', @TablaLogicaID, 'smsemail', 'Se muestra cuando solo esta pendiente actualizar su correo y celular ', 'Ingresa y actualiza tu correo y/o celular para poder contactarnos contigo.'),
										(cast(@TablaLogicaID as varchar(2)) + '02', @TablaLogicaID, 'sms', 'Se muestra cuando esta pendiente actualizar el celular', 'Ingresa y actualiza tu celular para acceder a nuestros beneficios.'),
										(cast(@TablaLogicaID as varchar(2)) + '03', @TablaLogicaID, 'email', 'Se muestra cuando esta pendiente actualizar el correo', 'Ingresa y actualiza tu correo para acceder a nuestros beneficios.')
end
Go

USE BelcorpDominicana
GO

declare @TablaLogicaID int = 10
if not exists (select 1 from TablaLogica where TablaLogicaID = @TablaLogicaID)
begin
	insert into TablaLogica values (@TablaLogicaID, 'Mensajes Tooltip Perfil')
	insert into TablaLogicaDatos values (cast(@TablaLogicaID as varchar(2)) + '01', @TablaLogicaID, 'smsemail', 'Se muestra cuando solo esta pendiente actualizar su correo y celular ', 'Ingresa y actualiza tu correo y/o celular para poder contactarnos contigo.'),
										(cast(@TablaLogicaID as varchar(2)) + '02', @TablaLogicaID, 'sms', 'Se muestra cuando esta pendiente actualizar el celular', 'Ingresa y actualiza tu celular para acceder a nuestros beneficios.'),
										(cast(@TablaLogicaID as varchar(2)) + '03', @TablaLogicaID, 'email', 'Se muestra cuando esta pendiente actualizar el correo', 'Ingresa y actualiza tu correo para acceder a nuestros beneficios.')
end
Go

USE BelcorpCostaRica
GO

declare @TablaLogicaID int = 10
if not exists (select 1 from TablaLogica where TablaLogicaID = @TablaLogicaID)
begin
	insert into TablaLogica values (@TablaLogicaID, 'Mensajes Tooltip Perfil')
	insert into TablaLogicaDatos values (cast(@TablaLogicaID as varchar(2)) + '01', @TablaLogicaID, 'smsemail', 'Se muestra cuando solo esta pendiente actualizar su correo y celular ', 'Ingresa y actualiza tu correo y/o celular para poder contactarnos contigo.'),
										(cast(@TablaLogicaID as varchar(2)) + '02', @TablaLogicaID, 'sms', 'Se muestra cuando esta pendiente actualizar el celular', 'Ingresa y actualiza tu celular para acceder a nuestros beneficios.'),
										(cast(@TablaLogicaID as varchar(2)) + '03', @TablaLogicaID, 'email', 'Se muestra cuando esta pendiente actualizar el correo', 'Ingresa y actualiza tu correo para acceder a nuestros beneficios.')
end
Go

USE BelcorpChile
GO

declare @TablaLogicaID int = 10
if not exists (select 1 from TablaLogica where TablaLogicaID = @TablaLogicaID)
begin
	insert into TablaLogica values (@TablaLogicaID, 'Mensajes Tooltip Perfil')
	insert into TablaLogicaDatos values (cast(@TablaLogicaID as varchar(2)) + '01', @TablaLogicaID, 'smsemail', 'Se muestra cuando solo esta pendiente actualizar su correo y celular ', 'Ingresa y actualiza tu correo y/o celular para poder contactarnos contigo.'),
										(cast(@TablaLogicaID as varchar(2)) + '02', @TablaLogicaID, 'sms', 'Se muestra cuando esta pendiente actualizar el celular', 'Ingresa y actualiza tu celular para acceder a nuestros beneficios.'),
										(cast(@TablaLogicaID as varchar(2)) + '03', @TablaLogicaID, 'email', 'Se muestra cuando esta pendiente actualizar el correo', 'Ingresa y actualiza tu correo para acceder a nuestros beneficios.')
end
Go

USE BelcorpBolivia
GO

declare @TablaLogicaID int = 10
if not exists (select 1 from TablaLogica where TablaLogicaID = @TablaLogicaID)
begin
	insert into TablaLogica values (@TablaLogicaID, 'Mensajes Tooltip Perfil')
	insert into TablaLogicaDatos values (cast(@TablaLogicaID as varchar(2)) + '01', @TablaLogicaID, 'smsemail', 'Se muestra cuando solo esta pendiente actualizar su correo y celular ', 'Ingresa y actualiza tu correo y/o celular para poder contactarnos contigo.'),
										(cast(@TablaLogicaID as varchar(2)) + '02', @TablaLogicaID, 'sms', 'Se muestra cuando esta pendiente actualizar el celular', 'Ingresa y actualiza tu celular para acceder a nuestros beneficios.'),
										(cast(@TablaLogicaID as varchar(2)) + '03', @TablaLogicaID, 'email', 'Se muestra cuando esta pendiente actualizar el correo', 'Ingresa y actualiza tu correo para acceder a nuestros beneficios.')
end
Go

