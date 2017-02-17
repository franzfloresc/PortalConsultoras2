USE BelcorpColombia
go

update Usuario
set ClaveSecreta = uc.Contrasenia
from Usuario u
inner join UsuarioContrasenia uc on
	u.CodigoUsuario = uc.CodigoUsuario

go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[UsuarioContraseniaTemporal]') AND (type = 'U') )
	DROP TABLE [dbo].UsuarioContraseniaTemporal
GO

create table dbo.UsuarioContraseniaTemporal
(
	CodigoUsuario varchar(20),
	Contrasenia varchar(200),
	ClaveDesencriptada varchar(200)
)

go

CREATE NONCLUSTERED INDEX IX_UsuarioContraseniaTemporal_CodigoUsuario ON dbo.UsuarioContraseniaTemporal (CodigoUsuario);

go

IF exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[EncriptarClaveSHA1]') and OBJECTPROPERTY(id, N'IsScalarFunction') = 1)
	drop function [dbo].EncriptarClaveSHA1
GO

CREATE FUNCTION dbo.EncriptarClaveSHA1
(
	@Clave nvarchar(max)
)
returns nvarchar(max)
AS
BEGIN
	SET @Clave = UPPER(@Clave)

	DECLARE @ClaveEncriptada NVARCHAR(MAX);

	SELECT @ClaveEncriptada = UPPER(SUBSTRING(master.dbo.fn_varbintohexstr(HashBytes('SHA1', @Clave)), 3, 40));

	RETURN @ClaveEncriptada;
END

GO

IF exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[GenerarClaveDefault]') and OBJECTPROPERTY(id, N'IsScalarFunction') = 1)
	drop function [dbo].GenerarClaveDefault
GO

create function dbo.GenerarClaveDefault
(
	@CodigoConsultora varchar(20)
) 
returns varchar(100)
as
/*
select dbo.GenerarClaveDefault('9900000002')
*/
begin
	declare @resultado varchar(100) = ''

	declare @ConsultoraID int = 0
	select @ConsultoraID = ConsultoraID from ods.Consultora where Codigo = @CodigoConsultora

	select @resultado = Numero from ods.Identificacion where ConsultoraID = @ConsultoraID
	
	--select * from ods.consultora where consultoraid=2
	--select * from ods.identificacion 

	return @resultado
end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetCantidadUsuariosInsertarTemporal]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetCantidadUsuariosInsertarTemporal
GO

create procedure dbo.GetCantidadUsuariosInsertarTemporal
as
/*
GetCantidadUsuariosInsertarTemporal
*/
begin

declare @resultado int = 0

select @resultado = count(*) 
	from Usuario u
	inner join UsuarioContrasenia uc on
		u.CodigoUsuario = uc.CodigoUsuario
	where u.CodigoUsuario not in (
		select CodigoUsuario from UsuarioContraseniaTemporal
	)

select @resultado

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetUsuariosClaveEncriptada]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetUsuariosClaveEncriptada
GO

create procedure dbo.GetUsuariosClaveEncriptada
@Cantidad int
as
/*
GetUsuariosClaveEncriptada 5000
*/
begin

select top (@Cantidad)
	u.CodigoUsuario,
	u.ClaveSecreta
from Usuario u
inner join UsuarioContrasenia uc on
		u.CodigoUsuario = uc.CodigoUsuario
	where u.CodigoUsuario not in (
		select CodigoUsuario from UsuarioContraseniaTemporal
	)

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateUsuarioContrasenia]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].UpdateUsuarioContrasenia
GO

create procedure UpdateUsuarioContrasenia
as
begin

update Usuario
	set ClaveSecreta = uct.ClaveDesencriptada
from Usuario u
inner join UsuarioContraseniaTemporal uct on
	u.CodigoUsuario = uct.CodigoUsuario

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateUsuarioContraseniaDefault]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].UpdateUsuarioContraseniaDefault
GO

create procedure dbo.UpdateUsuarioContraseniaDefault
as
begin

update Usuario
set
	ClaveSecreta = dbo.GenerarClaveDefault(u.CodigoConsultora)
from Usuario u
inner join UsuarioRol ur on
	u.CodigoUsuario = ur.CodigoUsuario
	and ur.RolID = 1
where 
	u.CodigoUsuario not in (
		select CodigoUsuario from UsuarioContrasenia
	)

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateUsuarioContraseniaEncriptada]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].UpdateUsuarioContraseniaEncriptada
GO

create procedure dbo.UpdateUsuarioContraseniaEncriptada
as
begin

update Usuario 
set ClaveSecreta = dbo.EncriptarClaveSHA1(u.ClaveSecreta)
from Usuario u
inner join UsuarioContrasenia uc on
	u.CodigoUsuario = uc.CodigoUsuario

update Usuario 
set
	ClaveSecreta = (
		case 
			when ClaveSecreta = '' then '' 
			else dbo.EncriptarClaveSHA1(u.ClaveSecreta) 
		end)
from Usuario u
inner join UsuarioRol ur on
	u.CodigoUsuario = ur.CodigoUsuario
	and ur.RolID = 1
where 
	u.CodigoUsuario not in (
		select CodigoUsuario from UsuarioContrasenia
	)

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CambiarClaveUsuario]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].CambiarClaveUsuario
GO

create procedure dbo.CambiarClaveUsuario
@CodigoUsuario varchar(20),
@NuevaContrasenia varchar(200),
@Correo varchar(50)
as
begin

declare @ClaveEncriptada varchar(200)

set @ClaveEncriptada = dbo.EncriptarClaveSHA1(@NuevaContrasenia)

update Usuario set ClaveSecreta = @ClaveEncriptada where CodigoUsuario = @CodigoUsuario

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ExisteUsuario]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ExisteUsuario
GO

create procedure dbo.ExisteUsuario
@CodigoUsuario varchar(20),
@Clave varchar(200)
as
/*
--Enviar vacio la clave indica que no valida si la clave es la misma
ExisteUsuario '000758833','1234'
ExisteUsuario '000758833','12345'
ExisteUsuario '000758833',''
ExisteUsuario 'dsfdsfdsf',''
*/
begin
/*
0: no existe
1: existe pero la clave es diferente
2: existe con/sin validacion de clave
*/
declare @resultado int = 0

if @Clave != ''
begin
	set @Clave = dbo.EncriptarClaveSHA1(@Clave)

	if exists (select 1 from Usuario where CodigoUsuario = @CodigoUsuario and ClaveSecreta = @Clave)
		set @resultado = 2
	else
		if exists (select 1 from Usuario where CodigoUsuario = @CodigoUsuario)
			set @resultado = 1
		else
			set @resultado = 0
end
else	
begin
	if exists (select 1 from Usuario where CodigoUsuario = @CodigoUsuario)
		set @resultado = 2
	else
		set @resultado = 0
end

select @resultado

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ValidarLogin_SB2]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ValidarLogin_SB2
GO

CREATE PROCEDURE ValidarLogin_SB2
(
	@CodigoUsuario VARCHAR(30),
	@Contrasenia VARCHAR(200)
)
AS
BEGIN

SET @Contrasenia = dbo.EncriptarClaveSHA1(@Contrasenia)

DECLARE @CodigoConsultora VARCHAR(20)
DECLARE @PaisID INT
DECLARE @ZonaID INT
DECLARE @RegionID INT
DECLARE @ConsultoraID INT
DECLARE @IdEstadoActividad INT
DECLARE @AutorizaPedido CHAR(1)
DECLARE @UltimaCampanaFacturada INT

DECLARE @Result INT
DECLARE @Mensaje VARCHAR(100)

DECLARE @PaisesEsika TABLE (
	PaisID INT
)
DECLARE @PaisesLbel TABLE (
	PaisID INT
)
DECLARE @TablaLogica TABLE (
	TablaLogicaID INT, 
	Codigo VARCHAR(10)
)

INSERT INTO @PaisesEsika(PaisID) VALUES (2),(3),(4),(7),(8),(11)
INSERT INTO @PaisesLbel(PaisID) VALUES (1),(5),(6),(9),(10),(12),(13),(14)

INSERT INTO @TablaLogica (TablaLogicaID, Codigo)
SELECT TablaLogicaID, Codigo
FROM TablaLogicaDatos WHERE TablaLogicaID in (12,18,19)

SET @Result = -1

SET @AutorizaPedido = ''
SET @IdEstadoActividad = -1
SET @UltimaCampanaFacturada = 0

-- STEP 1

IF (@CodigoUsuario LIKE '[a-z,0-9,_,-]%@[a-z,0-9,_,-]%.[a-z][a-z]%')
BEGIN
	DECLARE @CodigoUsuario_1 VARCHAR(30)
	SELECT 
		@CodigoConsultora = ISNULL(CodigoConsultora,''),
		@CodigoUsuario_1 = CodigoUsuario,
		@PaisID = ISNULL(PaisID,0)
	FROM usuario WITH(NOLOCK)
	WHERE EMail = @CodigoUsuario
	AND ClaveSecreta = @Contrasenia

	SET @CodigoUsuario = @CodigoUsuario_1
END
ELSE
BEGIN
	SELECT 
		@CodigoConsultora = ISNULL(CodigoConsultora,''),
		@PaisID = ISNULL(PaisID,0)
	FROM usuario WITH(NOLOCK)
	WHERE CodigoUsuario LIKE @CodigoUsuario
	AND ClaveSecreta = @Contrasenia
END

PRINT 'STEP 1'
PRINT @CodigoConsultora
PRINT @PaisID

IF (@CodigoConsultora != '' AND @PaisID != 0)
BEGIN
	PRINT 'STEP 2'

	--SELECT 
	--	@CodigoConsultora = ISNULL(CodigoConsultora,0),
	--	@PaidID = ISNULL(PaisID,0)
	--FROM usuario WITH(NOLOCK)
	--WHERE codigousuario = @CodigoUsuario

	SELECT	
		@ZonaID = ISNULL(ZonaID,0),
		@RegionID = ISNULL(RegionID,0),
		@ConsultoraID = ISNULL(ConsultoraID,0),
		@IdEstadoActividad = ISNULL(IdEstadoActividad,-1),
		@AutorizaPedido = ISNULL(AutorizaPedido,''),
		@UltimaCampanaFacturada = ISNULL(UltimaCampanaFacturada,0)
	FROM ods.Consultora WITH(NOLOCK)
	WHERE Codigo = @CodigoConsultora

	DECLARE @CodigoUsuario_ VARCHAR(30)
	DECLARE @RolID INT
	DECLARE @AutorizaPedido_ CHAR(1)
	DECLARE @CampaniaActual INT

	SELECT 
		@CodigoUsuario_ = ISNULL(u.CodigoUsuario,''), 
		@RolID = ISNULL(ur.RolID,0), 
		--@IdEstadoActividad AS IdEstadoActividad, 
		@AutorizaPedido_ = (CASE WHEN @AutorizaPedido = '' THEN '' WHEN @AutorizaPedido = '1' THEN 'S' WHEN @AutorizaPedido = '0' THEN 'N' END),
		--@UltimaCampanaFacturada AS UltimaCampania,
		@CampaniaActual = ISNULL((SELECT TOP 1 CampaniaID FROM dbo.GetCampaniaPreLogin(@PaisID,@ZonaID,@RegionID,@ConsultoraID)),0)
	FROM Usuario u WITH(NOLOCK)
	LEFT JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario
	WHERE u.CodigoUsuario = @CodigoUsuario

	-- STEP 3
	IF (@CodigoUsuario_ != '')
	BEGIN
		PRINT 'STEP 3'
		IF (@RolID != 0)
		BEGIN
			IF (@AutorizaPedido_ != '')
			BEGIN
				IF (@IdEstadoActividad != -1)
				BEGIN
					-- validamos si el pais esta en paises esika
					IF @PaisID IN (SELECT PaisID FROM @PaisesEsika)
					BEGIN
						PRINT 'Pais Esika'
						-- validamos si el estado es retirada
						IF @IdEstadoActividad IN (SELECT Codigo FROM @TablaLogica WHERE TablaLogicaID = 12)
						BEGIN
							PRINT 'Estado retirada'
							-- validamos si el pais es SICC
							IF @PaisID IN (3,4,7,8,11)
							BEGIN
								-- caso Colombia
								IF (@PaisID = 4)
									SET @Result = 2
								ELSE
								BEGIN
									-- validamos si autoriza pedido
									IF (@AutorizaPedido_ = 'N')
										SET @Result = 2
									ELSE
										SET @Result = 3
								END
							END
							ELSE
							BEGIN
								-- caso Bolivia
								IF (@PaisID = 2)
								BEGIN
									-- validamos si autoriza pedido
									IF (@AutorizaPedido_ = 'N')
										SET @Result = 2
									ELSE
										SET @Result = 3
								END
								ELSE
									SET @Result = 3
							END
						END
						ELSE
						BEGIN
							-- validamos si el estado es reingresado
							IF @IdEstadoActividad IN (SELECT Codigo FROM @TablaLogica WHERE TablaLogicaID = 18)
							BEGIN
								PRINT 'Estado reingreso'
								-- caso Chile
								IF (@PaisID = 3)
								BEGIN
									-- validamos las campañas que no ha ingresado
									IF (@UltimaCampanaFacturada != 0 AND LEN(@CampaniaActual) = 6 AND LEN(@UltimaCampanaFacturada) = 6)
									BEGIN
										DECLARE @ca VARCHAR(10)
										DECLARE @uc VARCHAR(10)
										SET @ca = SUBSTRING(CAST(@CampaniaActual AS VARCHAR),1,4)
										SET @uc = SUBSTRING(CAST(@UltimaCampanaFacturada AS VARCHAR),1,4)

										IF @ca != @uc
										BEGIN
											SET @ca = SUBSTRING(CAST(@CampaniaActual AS VARCHAR),5,2)
											SET @uc = SUBSTRING(CAST(@UltimaCampanaFacturada AS VARCHAR),5,2)
											SET @CampaniaActual = CAST(@uc AS INT) + CAST(@ca AS INT)
											SET @UltimaCampanaFacturada = CAST(@uc AS INT)
										END
									END

									IF (@CampaniaActual - @UltimaCampanaFacturada > 3 AND @UltimaCampanaFacturada != 0)
										SET @Result = 2
									ELSE
									BEGIN
										-- validamos si autoriza pedido
										IF (@AutorizaPedido_ = 'N')
											SET @Result = 2
										ELSE
											SET @Result = 3
									END
								END
								ELSE
								BEGIN
									-- caso Colombia
									IF (@PaisID = 4)
										SET @Result = 2
									ELSE
									BEGIN
										-- validamos si autoriza pedido
										IF (@AutorizaPedido_ = 'N')
										BEGIN
											-- validamos si el pais es SICC
											IF (@PaisID IN (2,3,7,8,11))
												SET @Result = 2
											ELSE
												SET @Result = 3
										END
										ELSE
											SET @Result = 3
									END
								END
							END
							ELSE
							BEGIN
								-- caso Colombia
								IF (@PaisID = 4)
								BEGIN
									-- validamos si el estado es egresada o posible egrese
									IF @IdEstadoActividad IN (SELECT Codigo FROM @TablaLogica WHERE TablaLogicaID = 19)
									BEGIN
										PRINT 'Estado egresada'
										SET @Result = 2
									END
								END
								
								-- validamos si autoriza pedido
								IF (@AutorizaPedido_ = 'N')
								BEGIN
									-- validamos si el pais es SICC
									IF (@PaisID IN (2,3,4,7,8,11))
										SET @Result = 2
									ELSE
										SET @Result = 3
								END
								ELSE
									SET @Result = 3
							END
						END
					END	-- ESIKA
					-- validamos si el pais esta en paises lbel
					ELSE IF @PaisID IN (SELECT PaisID FROM @PaisesLbel)
					BEGIN
						PRINT 'Pais Lbel'
						-- validamos si la consultora es retirada
						IF @IdEstadoActividad IN (SELECT Codigo FROM @TablaLogica WHERE TablaLogicaID = 12)
						BEGIN
							PRINT 'Estado retirada'
							-- validamos si el pais es SICC
							IF (@PaisID IN (5,6,10,14))
							BEGIN
								-- validamos si autoriza pedido
								IF (@AutorizaPedido_ = 'N')
									SET @Result = 2
								ELSE
									SET @Result = 3
							END
							ELSE
							BEGIN
								-- validamos si autoriza pedido
								IF (@AutorizaPedido_ = 'N')
									SET @Result = 2
								ELSE
									SET @Result = 3
							END
						END
						ELSE
						BEGIN
							-- validamos si el estado es egresada
							IF @IdEstadoActividad IN (SELECT Codigo FROM @TablaLogica WHERE TablaLogicaID = 19)
							BEGIN
								PRINT 'Estado egresada'
								-- validamos si autoriza pedido
								IF (@AutorizaPedido_ = 'N')
								BEGIN
									-- validamos si el pais es SICC
									IF (@PaisID IN (5,6,9,10,12,13,14))
										SET @Result = 2
									ELSE
										SET @Result = 3
								END
								ELSE
									SET @Result = 3
							END
							ELSE
							BEGIN
								-- validamos si autoriza pedido
								IF (@AutorizaPedido_ = 'N')
								BEGIN
									-- validamos si el pais es SICC
									IF (@PaisID IN (5,6,9,10,12,13,14))
										SET @Result = 2
									ELSE
										SET @Result = 3
								END
								ELSE
									SET @Result = 3
							END
						END
						
					END		-- LBEL
					ELSE
						SET @Result = 3
						
				END	-- @IdEstadoActividad
				ELSE
					SET @Result = 3		-- se asume para usuarios del tipo SAC
			END	-- @AutorizaPedido_
			ELSE
				SET @Result = 3		-- se asume para usuarios del tipo SAC
		END	-- @RolID

	END	-- @CodigoUsuario_
	ELSE
		SET @Result = 0

END
ELSE
	SET @Result = 4 


/*
0: Usuario No Existe
1: Usuario No es del Portal
2: Usuario Esta dentro de la Lista / Autoriza Pedido NULL o N
3: Usuario OK
4: Usuario o contrasenia incorrectos
*/

IF (@Result = 0)
	SET @Mensaje = 'Usuario No Existe'
ELSE IF (@Result = 1)
	SET @Mensaje = 'Usuario No es del Portal'
ELSE IF (@Result = 2)
	SET @Mensaje = 'Usuario No esta Autorizado para realizar Pedidos'
ELSE IF (@Result = 3)
	SET @Mensaje = 'Usuario OK'
ELSE IF (@Result = 4)
	SET @Mensaje = 'Usuario o Contraseña Incorrectas'


SELECT @Result AS Result, @Mensaje AS Mensaje

END

GO

USE BelcorpMexico
go

update Usuario
set ClaveSecreta = uc.Contrasenia
from Usuario u
inner join UsuarioContrasenia uc on
	u.CodigoUsuario = uc.CodigoUsuario

go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[UsuarioContraseniaTemporal]') AND (type = 'U') )
	DROP TABLE [dbo].UsuarioContraseniaTemporal
GO

create table dbo.UsuarioContraseniaTemporal
(
	CodigoUsuario varchar(20),
	Contrasenia varchar(200),
	ClaveDesencriptada varchar(200)
)

go

CREATE NONCLUSTERED INDEX IX_UsuarioContraseniaTemporal_CodigoUsuario ON dbo.UsuarioContraseniaTemporal (CodigoUsuario);

go

IF exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[EncriptarClaveSHA1]') and OBJECTPROPERTY(id, N'IsScalarFunction') = 1)
	drop function [dbo].EncriptarClaveSHA1
GO

CREATE FUNCTION dbo.EncriptarClaveSHA1
(
	@Clave nvarchar(max)
)
returns nvarchar(max)
AS
BEGIN
	SET @Clave = UPPER(@Clave)

	DECLARE @ClaveEncriptada NVARCHAR(MAX);

	SELECT @ClaveEncriptada = UPPER(SUBSTRING(master.dbo.fn_varbintohexstr(HashBytes('SHA1', @Clave)), 3, 40));

	RETURN @ClaveEncriptada;
END

GO

IF exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[GenerarClaveDefault]') and OBJECTPROPERTY(id, N'IsScalarFunction') = 1)
	drop function [dbo].GenerarClaveDefault
GO

create function dbo.GenerarClaveDefault
(
	@CodigoConsultora varchar(20)
) 
returns varchar(100)
as
/*
select dbo.GenerarClaveDefault('0009864')
*/
begin
	declare @resultado varchar(100) = ''	
	
	set @resultado = substring(@CodigoConsultora, len(@CodigoConsultora)-3,4)

	--select * from ods.consultora where consultoraid=2
	--select * from ods.identificacion

	return @resultado
end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetCantidadUsuariosInsertarTemporal]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetCantidadUsuariosInsertarTemporal
GO

create procedure dbo.GetCantidadUsuariosInsertarTemporal
as
/*
GetCantidadUsuariosInsertarTemporal
*/
begin

declare @resultado int = 0

select @resultado = count(*) 
	from Usuario u
	inner join UsuarioContrasenia uc on
		u.CodigoUsuario = uc.CodigoUsuario
	where u.CodigoUsuario not in (
		select CodigoUsuario from UsuarioContraseniaTemporal
	)

select @resultado

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetUsuariosClaveEncriptada]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetUsuariosClaveEncriptada
GO

create procedure dbo.GetUsuariosClaveEncriptada
@Cantidad int
as
/*
GetUsuariosClaveEncriptada 5000
*/
begin

select top (@Cantidad)
	u.CodigoUsuario,
	u.ClaveSecreta
from Usuario u
inner join UsuarioContrasenia uc on
		u.CodigoUsuario = uc.CodigoUsuario
	where u.CodigoUsuario not in (
		select CodigoUsuario from UsuarioContraseniaTemporal
	)

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateUsuarioContrasenia]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].UpdateUsuarioContrasenia
GO

create procedure UpdateUsuarioContrasenia
as
begin

update Usuario
	set ClaveSecreta = uct.ClaveDesencriptada
from Usuario u
inner join UsuarioContraseniaTemporal uct on
	u.CodigoUsuario = uct.CodigoUsuario

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateUsuarioContraseniaDefault]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].UpdateUsuarioContraseniaDefault
GO

create procedure dbo.UpdateUsuarioContraseniaDefault
as
begin

update Usuario
set
	ClaveSecreta = dbo.GenerarClaveDefault(u.CodigoConsultora)
from Usuario u
inner join UsuarioRol ur on
	u.CodigoUsuario = ur.CodigoUsuario
	and ur.RolID = 1
where 
	u.CodigoUsuario not in (
		select CodigoUsuario from UsuarioContrasenia
	)

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateUsuarioContraseniaEncriptada]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].UpdateUsuarioContraseniaEncriptada
GO

create procedure dbo.UpdateUsuarioContraseniaEncriptada
as
begin

update Usuario 
set ClaveSecreta = dbo.EncriptarClaveSHA1(u.ClaveSecreta)
from Usuario u
inner join UsuarioContrasenia uc on
	u.CodigoUsuario = uc.CodigoUsuario

update Usuario 
set
	ClaveSecreta = (
		case 
			when ClaveSecreta = '' then '' 
			else dbo.EncriptarClaveSHA1(u.ClaveSecreta) 
		end)
from Usuario u
inner join UsuarioRol ur on
	u.CodigoUsuario = ur.CodigoUsuario
	and ur.RolID = 1
where 
	u.CodigoUsuario not in (
		select CodigoUsuario from UsuarioContrasenia
	)

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CambiarClaveUsuario]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].CambiarClaveUsuario
GO

create procedure dbo.CambiarClaveUsuario
@CodigoUsuario varchar(20),
@NuevaContrasenia varchar(200),
@Correo varchar(50)
as
begin

declare @ClaveEncriptada varchar(200)

set @ClaveEncriptada = dbo.EncriptarClaveSHA1(@NuevaContrasenia)

update Usuario set ClaveSecreta = @ClaveEncriptada where CodigoUsuario = @CodigoUsuario

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ExisteUsuario]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ExisteUsuario
GO

create procedure dbo.ExisteUsuario
@CodigoUsuario varchar(20),
@Clave varchar(200)
as
/*
--Enviar vacio la clave indica que no valida si la clave es la misma
ExisteUsuario '000758833','1234'
ExisteUsuario '000758833','12345'
ExisteUsuario '000758833',''
ExisteUsuario 'dsfdsfdsf',''
*/
begin
/*
0: no existe
1: existe pero la clave es diferente
2: existe con/sin validacion de clave
*/
declare @resultado int = 0

if @Clave != ''
begin
	set @Clave = dbo.EncriptarClaveSHA1(@Clave)

	if exists (select 1 from Usuario where CodigoUsuario = @CodigoUsuario and ClaveSecreta = @Clave)
		set @resultado = 2
	else
		if exists (select 1 from Usuario where CodigoUsuario = @CodigoUsuario)
			set @resultado = 1
		else
			set @resultado = 0
end
else	
begin
	if exists (select 1 from Usuario where CodigoUsuario = @CodigoUsuario)
		set @resultado = 2
	else
		set @resultado = 0
end

select @resultado

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ValidarLogin_SB2]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ValidarLogin_SB2
GO

CREATE PROCEDURE ValidarLogin_SB2
(
	@CodigoUsuario VARCHAR(30),
	@Contrasenia VARCHAR(200)
)
AS
BEGIN

SET @Contrasenia = dbo.EncriptarClaveSHA1(@Contrasenia)

DECLARE @CodigoConsultora VARCHAR(20)
DECLARE @PaisID INT
DECLARE @ZonaID INT
DECLARE @RegionID INT
DECLARE @ConsultoraID INT
DECLARE @IdEstadoActividad INT
DECLARE @AutorizaPedido CHAR(1)
DECLARE @UltimaCampanaFacturada INT

DECLARE @Result INT
DECLARE @Mensaje VARCHAR(100)

DECLARE @PaisesEsika TABLE (
	PaisID INT
)
DECLARE @PaisesLbel TABLE (
	PaisID INT
)
DECLARE @TablaLogica TABLE (
	TablaLogicaID INT, 
	Codigo VARCHAR(10)
)

INSERT INTO @PaisesEsika(PaisID) VALUES (2),(3),(4),(7),(8),(11)
INSERT INTO @PaisesLbel(PaisID) VALUES (1),(5),(6),(9),(10),(12),(13),(14)

INSERT INTO @TablaLogica (TablaLogicaID, Codigo)
SELECT TablaLogicaID, Codigo
FROM TablaLogicaDatos WHERE TablaLogicaID in (12,18,19)

SET @Result = -1

SET @AutorizaPedido = ''
SET @IdEstadoActividad = -1
SET @UltimaCampanaFacturada = 0

-- STEP 1

IF (@CodigoUsuario LIKE '[a-z,0-9,_,-]%@[a-z,0-9,_,-]%.[a-z][a-z]%')
BEGIN
	DECLARE @CodigoUsuario_1 VARCHAR(30)
	SELECT 
		@CodigoConsultora = ISNULL(CodigoConsultora,''),
		@CodigoUsuario_1 = CodigoUsuario,
		@PaisID = ISNULL(PaisID,0)
	FROM usuario WITH(NOLOCK)
	WHERE EMail = @CodigoUsuario
	AND ClaveSecreta = @Contrasenia

	SET @CodigoUsuario = @CodigoUsuario_1
END
ELSE
BEGIN
	SELECT 
		@CodigoConsultora = ISNULL(CodigoConsultora,''),
		@PaisID = ISNULL(PaisID,0)
	FROM usuario WITH(NOLOCK)
	WHERE CodigoUsuario LIKE @CodigoUsuario
	AND ClaveSecreta = @Contrasenia
END

PRINT 'STEP 1'
PRINT @CodigoConsultora
PRINT @PaisID

IF (@CodigoConsultora != '' AND @PaisID != 0)
BEGIN
	PRINT 'STEP 2'

	--SELECT 
	--	@CodigoConsultora = ISNULL(CodigoConsultora,0),
	--	@PaidID = ISNULL(PaisID,0)
	--FROM usuario WITH(NOLOCK)
	--WHERE codigousuario = @CodigoUsuario

	SELECT	
		@ZonaID = ISNULL(ZonaID,0),
		@RegionID = ISNULL(RegionID,0),
		@ConsultoraID = ISNULL(ConsultoraID,0),
		@IdEstadoActividad = ISNULL(IdEstadoActividad,-1),
		@AutorizaPedido = ISNULL(AutorizaPedido,''),
		@UltimaCampanaFacturada = ISNULL(UltimaCampanaFacturada,0)
	FROM ods.Consultora WITH(NOLOCK)
	WHERE Codigo = @CodigoConsultora

	DECLARE @CodigoUsuario_ VARCHAR(30)
	DECLARE @RolID INT
	DECLARE @AutorizaPedido_ CHAR(1)
	DECLARE @CampaniaActual INT

	SELECT 
		@CodigoUsuario_ = ISNULL(u.CodigoUsuario,''), 
		@RolID = ISNULL(ur.RolID,0), 
		--@IdEstadoActividad AS IdEstadoActividad, 
		@AutorizaPedido_ = (CASE WHEN @AutorizaPedido = '' THEN '' WHEN @AutorizaPedido = '1' THEN 'S' WHEN @AutorizaPedido = '0' THEN 'N' END),
		--@UltimaCampanaFacturada AS UltimaCampania,
		@CampaniaActual = ISNULL((SELECT TOP 1 CampaniaID FROM dbo.GetCampaniaPreLogin(@PaisID,@ZonaID,@RegionID,@ConsultoraID)),0)
	FROM Usuario u WITH(NOLOCK)
	LEFT JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario
	WHERE u.CodigoUsuario = @CodigoUsuario

	-- STEP 3
	IF (@CodigoUsuario_ != '')
	BEGIN
		PRINT 'STEP 3'
		IF (@RolID != 0)
		BEGIN
			IF (@AutorizaPedido_ != '')
			BEGIN
				IF (@IdEstadoActividad != -1)
				BEGIN
					-- validamos si el pais esta en paises esika
					IF @PaisID IN (SELECT PaisID FROM @PaisesEsika)
					BEGIN
						PRINT 'Pais Esika'
						-- validamos si el estado es retirada
						IF @IdEstadoActividad IN (SELECT Codigo FROM @TablaLogica WHERE TablaLogicaID = 12)
						BEGIN
							PRINT 'Estado retirada'
							-- validamos si el pais es SICC
							IF @PaisID IN (3,4,7,8,11)
							BEGIN
								-- caso Colombia
								IF (@PaisID = 4)
									SET @Result = 2
								ELSE
								BEGIN
									-- validamos si autoriza pedido
									IF (@AutorizaPedido_ = 'N')
										SET @Result = 2
									ELSE
										SET @Result = 3
								END
							END
							ELSE
							BEGIN
								-- caso Bolivia
								IF (@PaisID = 2)
								BEGIN
									-- validamos si autoriza pedido
									IF (@AutorizaPedido_ = 'N')
										SET @Result = 2
									ELSE
										SET @Result = 3
								END
								ELSE
									SET @Result = 3
							END
						END
						ELSE
						BEGIN
							-- validamos si el estado es reingresado
							IF @IdEstadoActividad IN (SELECT Codigo FROM @TablaLogica WHERE TablaLogicaID = 18)
							BEGIN
								PRINT 'Estado reingreso'
								-- caso Chile
								IF (@PaisID = 3)
								BEGIN
									-- validamos las campañas que no ha ingresado
									IF (@UltimaCampanaFacturada != 0 AND LEN(@CampaniaActual) = 6 AND LEN(@UltimaCampanaFacturada) = 6)
									BEGIN
										DECLARE @ca VARCHAR(10)
										DECLARE @uc VARCHAR(10)
										SET @ca = SUBSTRING(CAST(@CampaniaActual AS VARCHAR),1,4)
										SET @uc = SUBSTRING(CAST(@UltimaCampanaFacturada AS VARCHAR),1,4)

										IF @ca != @uc
										BEGIN
											SET @ca = SUBSTRING(CAST(@CampaniaActual AS VARCHAR),5,2)
											SET @uc = SUBSTRING(CAST(@UltimaCampanaFacturada AS VARCHAR),5,2)
											SET @CampaniaActual = CAST(@uc AS INT) + CAST(@ca AS INT)
											SET @UltimaCampanaFacturada = CAST(@uc AS INT)
										END
									END

									IF (@CampaniaActual - @UltimaCampanaFacturada > 3 AND @UltimaCampanaFacturada != 0)
										SET @Result = 2
									ELSE
									BEGIN
										-- validamos si autoriza pedido
										IF (@AutorizaPedido_ = 'N')
											SET @Result = 2
										ELSE
											SET @Result = 3
									END
								END
								ELSE
								BEGIN
									-- caso Colombia
									IF (@PaisID = 4)
										SET @Result = 2
									ELSE
									BEGIN
										-- validamos si autoriza pedido
										IF (@AutorizaPedido_ = 'N')
										BEGIN
											-- validamos si el pais es SICC
											IF (@PaisID IN (2,3,7,8,11))
												SET @Result = 2
											ELSE
												SET @Result = 3
										END
										ELSE
											SET @Result = 3
									END
								END
							END
							ELSE
							BEGIN
								-- caso Colombia
								IF (@PaisID = 4)
								BEGIN
									-- validamos si el estado es egresada o posible egrese
									IF @IdEstadoActividad IN (SELECT Codigo FROM @TablaLogica WHERE TablaLogicaID = 19)
									BEGIN
										PRINT 'Estado egresada'
										SET @Result = 2
									END
								END
								
								-- validamos si autoriza pedido
								IF (@AutorizaPedido_ = 'N')
								BEGIN
									-- validamos si el pais es SICC
									IF (@PaisID IN (2,3,4,7,8,11))
										SET @Result = 2
									ELSE
										SET @Result = 3
								END
								ELSE
									SET @Result = 3
							END
						END
					END	-- ESIKA
					-- validamos si el pais esta en paises lbel
					ELSE IF @PaisID IN (SELECT PaisID FROM @PaisesLbel)
					BEGIN
						PRINT 'Pais Lbel'
						-- validamos si la consultora es retirada
						IF @IdEstadoActividad IN (SELECT Codigo FROM @TablaLogica WHERE TablaLogicaID = 12)
						BEGIN
							PRINT 'Estado retirada'
							-- validamos si el pais es SICC
							IF (@PaisID IN (5,6,10,14))
							BEGIN
								-- validamos si autoriza pedido
								IF (@AutorizaPedido_ = 'N')
									SET @Result = 2
								ELSE
									SET @Result = 3
							END
							ELSE
							BEGIN
								-- validamos si autoriza pedido
								IF (@AutorizaPedido_ = 'N')
									SET @Result = 2
								ELSE
									SET @Result = 3
							END
						END
						ELSE
						BEGIN
							-- validamos si el estado es egresada
							IF @IdEstadoActividad IN (SELECT Codigo FROM @TablaLogica WHERE TablaLogicaID = 19)
							BEGIN
								PRINT 'Estado egresada'
								-- validamos si autoriza pedido
								IF (@AutorizaPedido_ = 'N')
								BEGIN
									-- validamos si el pais es SICC
									IF (@PaisID IN (5,6,9,10,12,13,14))
										SET @Result = 2
									ELSE
										SET @Result = 3
								END
								ELSE
									SET @Result = 3
							END
							ELSE
							BEGIN
								-- validamos si autoriza pedido
								IF (@AutorizaPedido_ = 'N')
								BEGIN
									-- validamos si el pais es SICC
									IF (@PaisID IN (5,6,9,10,12,13,14))
										SET @Result = 2
									ELSE
										SET @Result = 3
								END
								ELSE
									SET @Result = 3
							END
						END
						
					END		-- LBEL
					ELSE
						SET @Result = 3
						
				END	-- @IdEstadoActividad
				ELSE
					SET @Result = 3		-- se asume para usuarios del tipo SAC
			END	-- @AutorizaPedido_
			ELSE
				SET @Result = 3		-- se asume para usuarios del tipo SAC
		END	-- @RolID

	END	-- @CodigoUsuario_
	ELSE
		SET @Result = 0

END
ELSE
	SET @Result = 4 


/*
0: Usuario No Existe
1: Usuario No es del Portal
2: Usuario Esta dentro de la Lista / Autoriza Pedido NULL o N
3: Usuario OK
4: Usuario o contrasenia incorrectos
*/

IF (@Result = 0)
	SET @Mensaje = 'Usuario No Existe'
ELSE IF (@Result = 1)
	SET @Mensaje = 'Usuario No es del Portal'
ELSE IF (@Result = 2)
	SET @Mensaje = 'Usuario No esta Autorizado para realizar Pedidos'
ELSE IF (@Result = 3)
	SET @Mensaje = 'Usuario OK'
ELSE IF (@Result = 4)
	SET @Mensaje = 'Usuario o Contraseña Incorrectas'


SELECT @Result AS Result, @Mensaje AS Mensaje

END

GO

USE BelcorpPeru
go

update Usuario
set ClaveSecreta = uc.Contrasenia
from Usuario u
inner join UsuarioContrasenia uc on
	u.CodigoUsuario = uc.CodigoUsuario

go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[UsuarioContraseniaTemporal]') AND (type = 'U') )
	DROP TABLE [dbo].UsuarioContraseniaTemporal
GO

create table dbo.UsuarioContraseniaTemporal
(
	CodigoUsuario varchar(20),
	Contrasenia varchar(200),
	ClaveDesencriptada varchar(200)
)

go

CREATE NONCLUSTERED INDEX IX_UsuarioContraseniaTemporal_CodigoUsuario ON dbo.UsuarioContraseniaTemporal (CodigoUsuario);

go

IF exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[EncriptarClaveSHA1]') and OBJECTPROPERTY(id, N'IsScalarFunction') = 1)
	drop function [dbo].EncriptarClaveSHA1
GO

CREATE FUNCTION dbo.EncriptarClaveSHA1
(
	@Clave nvarchar(max)
)
returns nvarchar(max)
AS
BEGIN
	SET @Clave = UPPER(@Clave)

	DECLARE @ClaveEncriptada NVARCHAR(MAX);

	SELECT @ClaveEncriptada = UPPER(SUBSTRING(master.dbo.fn_varbintohexstr(HashBytes('SHA1', @Clave)), 3, 40));

	RETURN @ClaveEncriptada;
END

GO

IF exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[GenerarClaveDefault]') and OBJECTPROPERTY(id, N'IsScalarFunction') = 1)
	drop function [dbo].GenerarClaveDefault
GO

create function dbo.GenerarClaveDefault
(
	@CodigoConsultora varchar(20)
) 
returns varchar(100)
as
/*
select dbo.GenerarClaveDefault('000758833')
*/
begin
	declare @resultado varchar(100) = ''

	declare @ConsultoraID int = 0
	select @ConsultoraID = ConsultoraID from ods.Consultora where Codigo = @CodigoConsultora

	select @resultado = Numero from ods.Identificacion where ConsultoraID = @ConsultoraID

	return @resultado
end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetCantidadUsuariosInsertarTemporal]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetCantidadUsuariosInsertarTemporal
GO

create procedure dbo.GetCantidadUsuariosInsertarTemporal
as
/*
GetCantidadUsuariosInsertarTemporal
*/
begin

declare @resultado int = 0

select @resultado = count(*) 
	from Usuario u
	inner join UsuarioContrasenia uc on
		u.CodigoUsuario = uc.CodigoUsuario
	where u.CodigoUsuario not in (
		select CodigoUsuario from UsuarioContraseniaTemporal
	)

select @resultado

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetUsuariosClaveEncriptada]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetUsuariosClaveEncriptada
GO

create procedure dbo.GetUsuariosClaveEncriptada
@Cantidad int
as
/*
GetUsuariosClaveEncriptada 5000
*/
begin

select top (@Cantidad)
	u.CodigoUsuario,
	u.ClaveSecreta
from Usuario u
inner join UsuarioContrasenia uc on
		u.CodigoUsuario = uc.CodigoUsuario
	where u.CodigoUsuario not in (
		select CodigoUsuario from UsuarioContraseniaTemporal
	)

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateUsuarioContrasenia]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].UpdateUsuarioContrasenia
GO

create procedure UpdateUsuarioContrasenia
as
begin

update Usuario
	set ClaveSecreta = uct.ClaveDesencriptada
from Usuario u
inner join UsuarioContraseniaTemporal uct on
	u.CodigoUsuario = uct.CodigoUsuario

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateUsuarioContraseniaDefault]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].UpdateUsuarioContraseniaDefault
GO

create procedure dbo.UpdateUsuarioContraseniaDefault
as
begin

update Usuario
set
	ClaveSecreta = dbo.GenerarClaveDefault(u.CodigoConsultora)
from Usuario u
inner join UsuarioRol ur on
	u.CodigoUsuario = ur.CodigoUsuario
	and ur.RolID = 1
where 
	u.CodigoUsuario not in (
		select CodigoUsuario from UsuarioContrasenia
	)

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateUsuarioContraseniaEncriptada]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].UpdateUsuarioContraseniaEncriptada
GO

create procedure dbo.UpdateUsuarioContraseniaEncriptada
as
begin

update Usuario 
set ClaveSecreta = dbo.EncriptarClaveSHA1(u.ClaveSecreta)
from Usuario u
inner join UsuarioContrasenia uc on
	u.CodigoUsuario = uc.CodigoUsuario

update Usuario 
set
	ClaveSecreta = (
		case 
			when ClaveSecreta = '' then '' 
			else dbo.EncriptarClaveSHA1(u.ClaveSecreta) 
		end)
from Usuario u
inner join UsuarioRol ur on
	u.CodigoUsuario = ur.CodigoUsuario
	and ur.RolID = 1
where 
	u.CodigoUsuario not in (
		select CodigoUsuario from UsuarioContrasenia
	)

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CambiarClaveUsuario]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].CambiarClaveUsuario
GO

create procedure dbo.CambiarClaveUsuario
@CodigoUsuario varchar(20),
@NuevaContrasenia varchar(200),
@Correo varchar(50)
as
begin

declare @ClaveEncriptada varchar(200)

set @ClaveEncriptada = dbo.EncriptarClaveSHA1(@NuevaContrasenia)

update Usuario set ClaveSecreta = @ClaveEncriptada where CodigoUsuario = @CodigoUsuario

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ExisteUsuario]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ExisteUsuario
GO

create procedure dbo.ExisteUsuario
@CodigoUsuario varchar(20),
@Clave varchar(200)
as
/*
--Enviar vacio la clave indica que no valida si la clave es la misma
ExisteUsuario '000758833','1234'
ExisteUsuario '000758833','12345'
ExisteUsuario '000758833',''
ExisteUsuario 'dsfdsfdsf',''
*/
begin
/*
0: no existe
1: existe pero la clave es diferente
2: existe con/sin validacion de clave
*/
declare @resultado int = 0

if @Clave != ''
begin
	set @Clave = dbo.EncriptarClaveSHA1(@Clave)

	if exists (select 1 from Usuario where CodigoUsuario = @CodigoUsuario and ClaveSecreta = @Clave)
		set @resultado = 2
	else
		if exists (select 1 from Usuario where CodigoUsuario = @CodigoUsuario)
			set @resultado = 1
		else
			set @resultado = 0
end
else	
begin
	if exists (select 1 from Usuario where CodigoUsuario = @CodigoUsuario)
		set @resultado = 2
	else
		set @resultado = 0
end

select @resultado

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ValidarLogin_SB2]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ValidarLogin_SB2
GO

CREATE PROCEDURE ValidarLogin_SB2
(
	@CodigoUsuario VARCHAR(30),
	@Contrasenia VARCHAR(200)
)
AS
/*
ValidarLogin_SB2 '000758833','1234'
*/
BEGIN

SET @Contrasenia = dbo.EncriptarClaveSHA1(@Contrasenia)

DECLARE @CodigoConsultora VARCHAR(20)
DECLARE @PaisID INT
DECLARE @ZonaID INT
DECLARE @RegionID INT
DECLARE @ConsultoraID INT
DECLARE @IdEstadoActividad INT
DECLARE @AutorizaPedido CHAR(1)
DECLARE @UltimaCampanaFacturada INT

DECLARE @Result INT
DECLARE @Mensaje VARCHAR(100)

DECLARE @PaisesEsika TABLE (
	PaisID INT
)
DECLARE @PaisesLbel TABLE (
	PaisID INT
)
DECLARE @TablaLogica TABLE (
	TablaLogicaID INT, 
	Codigo VARCHAR(10)
)

INSERT INTO @PaisesEsika(PaisID) VALUES (2),(3),(4),(7),(8),(11)
INSERT INTO @PaisesLbel(PaisID) VALUES (1),(5),(6),(9),(10),(12),(13),(14)

INSERT INTO @TablaLogica (TablaLogicaID, Codigo)
SELECT TablaLogicaID, Codigo
FROM TablaLogicaDatos WHERE TablaLogicaID in (12,18,19)

SET @Result = -1

SET @AutorizaPedido = ''
SET @IdEstadoActividad = -1
SET @UltimaCampanaFacturada = 0

-- STEP 1

IF (@CodigoUsuario LIKE '[a-z,0-9,_,-]%@[a-z,0-9,_,-]%.[a-z][a-z]%')
BEGIN
	DECLARE @CodigoUsuario_1 VARCHAR(30)
	SELECT 
		@CodigoConsultora = ISNULL(CodigoConsultora,''),
		@CodigoUsuario_1 = CodigoUsuario,
		@PaisID = ISNULL(PaisID,0)
	FROM usuario WITH(NOLOCK)
	WHERE EMail = @CodigoUsuario
	AND ClaveSecreta = @Contrasenia

	SET @CodigoUsuario = @CodigoUsuario_1
END
ELSE
BEGIN
	SELECT 
		@CodigoConsultora = ISNULL(CodigoConsultora,''),
		@PaisID = ISNULL(PaisID,0)
	FROM usuario WITH(NOLOCK)
	WHERE CodigoUsuario LIKE @CodigoUsuario
	AND ClaveSecreta = @Contrasenia
END

PRINT 'STEP 1'
PRINT @CodigoConsultora
PRINT @PaisID

IF (@CodigoConsultora != '' AND @PaisID != 0)
BEGIN
	PRINT 'STEP 2'

	--SELECT 
	--	@CodigoConsultora = ISNULL(CodigoConsultora,0),
	--	@PaidID = ISNULL(PaisID,0)
	--FROM usuario WITH(NOLOCK)
	--WHERE codigousuario = @CodigoUsuario

	SELECT	
		@ZonaID = ISNULL(ZonaID,0),
		@RegionID = ISNULL(RegionID,0),
		@ConsultoraID = ISNULL(ConsultoraID,0),
		@IdEstadoActividad = ISNULL(IdEstadoActividad,-1),
		@AutorizaPedido = ISNULL(AutorizaPedido,''),
		@UltimaCampanaFacturada = ISNULL(UltimaCampanaFacturada,0)
	FROM ods.Consultora WITH(NOLOCK)
	WHERE Codigo = @CodigoConsultora

	DECLARE @CodigoUsuario_ VARCHAR(30)
	DECLARE @RolID INT
	DECLARE @AutorizaPedido_ CHAR(1)
	DECLARE @CampaniaActual INT

	SELECT 
		@CodigoUsuario_ = ISNULL(u.CodigoUsuario,''), 
		@RolID = ISNULL(ur.RolID,0), 
		--@IdEstadoActividad AS IdEstadoActividad, 
		@AutorizaPedido_ = (CASE WHEN @AutorizaPedido = '' THEN '' WHEN @AutorizaPedido = '1' THEN 'S' WHEN @AutorizaPedido = '0' THEN 'N' END),
		--@UltimaCampanaFacturada AS UltimaCampania,
		@CampaniaActual = ISNULL((SELECT TOP 1 CampaniaID FROM dbo.GetCampaniaPreLogin(@PaisID,@ZonaID,@RegionID,@ConsultoraID)),0)
	FROM Usuario u WITH(NOLOCK)
	LEFT JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario
	WHERE u.CodigoUsuario = @CodigoUsuario

	-- STEP 3
	IF (@CodigoUsuario_ != '')
	BEGIN
		PRINT 'STEP 3'
		IF (@RolID != 0)
		BEGIN
			IF (@AutorizaPedido_ != '')
			BEGIN
				IF (@IdEstadoActividad != -1)
				BEGIN
					-- validamos si el pais esta en paises esika
					IF @PaisID IN (SELECT PaisID FROM @PaisesEsika)
					BEGIN
						PRINT 'Pais Esika'
						-- validamos si el estado es retirada
						IF @IdEstadoActividad IN (SELECT Codigo FROM @TablaLogica WHERE TablaLogicaID = 12)
						BEGIN
							PRINT 'Estado retirada'
							-- validamos si el pais es SICC
							IF @PaisID IN (3,4,7,8,11)
							BEGIN
								-- caso Colombia
								IF (@PaisID = 4)
									SET @Result = 2
								ELSE
								BEGIN
									-- validamos si autoriza pedido
									IF (@AutorizaPedido_ = 'N')
										SET @Result = 2
									ELSE
										SET @Result = 3
								END
							END
							ELSE
							BEGIN
								-- caso Bolivia
								IF (@PaisID = 2)
								BEGIN
									-- validamos si autoriza pedido
									IF (@AutorizaPedido_ = 'N')
										SET @Result = 2
									ELSE
										SET @Result = 3
								END
								ELSE
									SET @Result = 3
							END
						END
						ELSE
						BEGIN
							-- validamos si el estado es reingresado
							IF @IdEstadoActividad IN (SELECT Codigo FROM @TablaLogica WHERE TablaLogicaID = 18)
							BEGIN
								PRINT 'Estado reingreso'
								-- caso Chile
								IF (@PaisID = 3)
								BEGIN
									-- validamos las campañas que no ha ingresado
									IF (@UltimaCampanaFacturada != 0 AND LEN(@CampaniaActual) = 6 AND LEN(@UltimaCampanaFacturada) = 6)
									BEGIN
										DECLARE @ca VARCHAR(10)
										DECLARE @uc VARCHAR(10)
										SET @ca = SUBSTRING(CAST(@CampaniaActual AS VARCHAR),1,4)
										SET @uc = SUBSTRING(CAST(@UltimaCampanaFacturada AS VARCHAR),1,4)

										IF @ca != @uc
										BEGIN
											SET @ca = SUBSTRING(CAST(@CampaniaActual AS VARCHAR),5,2)
											SET @uc = SUBSTRING(CAST(@UltimaCampanaFacturada AS VARCHAR),5,2)
											SET @CampaniaActual = CAST(@uc AS INT) + CAST(@ca AS INT)
											SET @UltimaCampanaFacturada = CAST(@uc AS INT)
										END
									END

									IF (@CampaniaActual - @UltimaCampanaFacturada > 3 AND @UltimaCampanaFacturada != 0)
										SET @Result = 2
									ELSE
									BEGIN
										-- validamos si autoriza pedido
										IF (@AutorizaPedido_ = 'N')
											SET @Result = 2
										ELSE
											SET @Result = 3
									END
								END
								ELSE
								BEGIN
									-- caso Colombia
									IF (@PaisID = 4)
										SET @Result = 2
									ELSE
									BEGIN
										-- validamos si autoriza pedido
										IF (@AutorizaPedido_ = 'N')
										BEGIN
											-- validamos si el pais es SICC
											IF (@PaisID IN (2,3,7,8,11))
												SET @Result = 2
											ELSE
												SET @Result = 3
										END
										ELSE
											SET @Result = 3
									END
								END
							END
							ELSE
							BEGIN
								-- caso Colombia
								IF (@PaisID = 4)
								BEGIN
									-- validamos si el estado es egresada o posible egrese
									IF @IdEstadoActividad IN (SELECT Codigo FROM @TablaLogica WHERE TablaLogicaID = 19)
									BEGIN
										PRINT 'Estado egresada'
										SET @Result = 2
									END
								END
								
								-- validamos si autoriza pedido
								IF (@AutorizaPedido_ = 'N')
								BEGIN
									-- validamos si el pais es SICC
									IF (@PaisID IN (2,3,4,7,8,11))
										SET @Result = 2
									ELSE
										SET @Result = 3
								END
								ELSE
									SET @Result = 3
							END
						END
					END	-- ESIKA
					-- validamos si el pais esta en paises lbel
					ELSE IF @PaisID IN (SELECT PaisID FROM @PaisesLbel)
					BEGIN
						PRINT 'Pais Lbel'
						-- validamos si la consultora es retirada
						IF @IdEstadoActividad IN (SELECT Codigo FROM @TablaLogica WHERE TablaLogicaID = 12)
						BEGIN
							PRINT 'Estado retirada'
							-- validamos si el pais es SICC
							IF (@PaisID IN (5,6,10,14))
							BEGIN
								-- validamos si autoriza pedido
								IF (@AutorizaPedido_ = 'N')
									SET @Result = 2
								ELSE
									SET @Result = 3
							END
							ELSE
							BEGIN
								-- validamos si autoriza pedido
								IF (@AutorizaPedido_ = 'N')
									SET @Result = 2
								ELSE
									SET @Result = 3
							END
						END
						ELSE
						BEGIN
							-- validamos si el estado es egresada
							IF @IdEstadoActividad IN (SELECT Codigo FROM @TablaLogica WHERE TablaLogicaID = 19)
							BEGIN
								PRINT 'Estado egresada'
								-- validamos si autoriza pedido
								IF (@AutorizaPedido_ = 'N')
								BEGIN
									-- validamos si el pais es SICC
									IF (@PaisID IN (5,6,9,10,12,13,14))
										SET @Result = 2
									ELSE
										SET @Result = 3
								END
								ELSE
									SET @Result = 3
							END
							ELSE
							BEGIN
								-- validamos si autoriza pedido
								IF (@AutorizaPedido_ = 'N')
								BEGIN
									-- validamos si el pais es SICC
									IF (@PaisID IN (5,6,9,10,12,13,14))
										SET @Result = 2
									ELSE
										SET @Result = 3
								END
								ELSE
									SET @Result = 3
							END
						END
						
					END		-- LBEL
					ELSE
						SET @Result = 3
						
				END	-- @IdEstadoActividad
				ELSE
					SET @Result = 3		-- se asume para usuarios del tipo SAC
			END	-- @AutorizaPedido_
			ELSE
				SET @Result = 3		-- se asume para usuarios del tipo SAC
		END	-- @RolID

	END	-- @CodigoUsuario_
	ELSE
		SET @Result = 0

END
ELSE
	SET @Result = 4 


/*
0: Usuario No Existe
1: Usuario No es del Portal
2: Usuario Esta dentro de la Lista / Autoriza Pedido NULL o N
3: Usuario OK
4: Usuario o contrasenia incorrectos
*/

IF (@Result = 0)
	SET @Mensaje = 'Usuario No Existe'
ELSE IF (@Result = 1)
	SET @Mensaje = 'Usuario No es del Portal'
ELSE IF (@Result = 2)
	SET @Mensaje = 'Usuario No esta Autorizado para realizar Pedidos'
ELSE IF (@Result = 3)
	SET @Mensaje = 'Usuario OK'
ELSE IF (@Result = 4)
	SET @Mensaje = 'Usuario o Contraseña Incorrectas'


SELECT @Result AS Result, @Mensaje AS Mensaje

END

GO