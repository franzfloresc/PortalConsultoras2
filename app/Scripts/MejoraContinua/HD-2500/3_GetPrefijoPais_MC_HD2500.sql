USE BelcorpPeru
GO

if Exists(select 1 from sys.objects where type = 'P' and name = 'GetPrefijoPais')
begin
	 drop proc GetPrefijoPais
end
GO
CREATE PROC GetPrefijoPais
(
@CodigoISO varchar(2)
)
AS
BEGIN
	select
		IsNull(PrefijoTelefono, '') as PrefijoTelefono
	from Pais
	where CodigoISO = @CodigoISO
END
GO

USE BelcorpMexico
GO

if Exists(select 1 from sys.objects where type = 'P' and name = 'GetPrefijoPais')
begin
	 drop proc GetPrefijoPais
end
GO
CREATE PROC GetPrefijoPais
(
@CodigoISO varchar(2)
)
AS
BEGIN
	select
		IsNull(PrefijoTelefono, '') as PrefijoTelefono
	from Pais
	where CodigoISO = @CodigoISO
END
GO

USE BelcorpColombia
GO

if Exists(select 1 from sys.objects where type = 'P' and name = 'GetPrefijoPais')
begin
	 drop proc GetPrefijoPais
end
GO
CREATE PROC GetPrefijoPais
(
@CodigoISO varchar(2)
)
AS
BEGIN
	select
		IsNull(PrefijoTelefono, '') as PrefijoTelefono
	from Pais
	where CodigoISO = @CodigoISO
END
GO

USE BelcorpSalvador
GO

if Exists(select 1 from sys.objects where type = 'P' and name = 'GetPrefijoPais')
begin
	 drop proc GetPrefijoPais
end
GO
CREATE PROC GetPrefijoPais
(
@CodigoISO varchar(2)
)
AS
BEGIN
	select
		IsNull(PrefijoTelefono, '') as PrefijoTelefono
	from Pais
	where CodigoISO = @CodigoISO
END
GO

USE BelcorpPuertoRico
GO

if Exists(select 1 from sys.objects where type = 'P' and name = 'GetPrefijoPais')
begin
	 drop proc GetPrefijoPais
end
GO
CREATE PROC GetPrefijoPais
(
@CodigoISO varchar(2)
)
AS
BEGIN
	select
		IsNull(PrefijoTelefono, '') as PrefijoTelefono
	from Pais
	where CodigoISO = @CodigoISO
END
GO

USE BelcorpPanama
GO

if Exists(select 1 from sys.objects where type = 'P' and name = 'GetPrefijoPais')
begin
	 drop proc GetPrefijoPais
end
GO
CREATE PROC GetPrefijoPais
(
@CodigoISO varchar(2)
)
AS
BEGIN
	select
		IsNull(PrefijoTelefono, '') as PrefijoTelefono
	from Pais
	where CodigoISO = @CodigoISO
END
GO

USE BelcorpGuatemala
GO

if Exists(select 1 from sys.objects where type = 'P' and name = 'GetPrefijoPais')
begin
	 drop proc GetPrefijoPais
end
GO
CREATE PROC GetPrefijoPais
(
@CodigoISO varchar(2)
)
AS
BEGIN
	select
		IsNull(PrefijoTelefono, '') as PrefijoTelefono
	from Pais
	where CodigoISO = @CodigoISO
END
GO

USE BelcorpEcuador
GO

if Exists(select 1 from sys.objects where type = 'P' and name = 'GetPrefijoPais')
begin
	 drop proc GetPrefijoPais
end
GO
CREATE PROC GetPrefijoPais
(
@CodigoISO varchar(2)
)
AS
BEGIN
	select
		IsNull(PrefijoTelefono, '') as PrefijoTelefono
	from Pais
	where CodigoISO = @CodigoISO
END
GO

USE BelcorpDominicana
GO

if Exists(select 1 from sys.objects where type = 'P' and name = 'GetPrefijoPais')
begin
	 drop proc GetPrefijoPais
end
GO
CREATE PROC GetPrefijoPais
(
@CodigoISO varchar(2)
)
AS
BEGIN
	select
		IsNull(PrefijoTelefono, '') as PrefijoTelefono
	from Pais
	where CodigoISO = @CodigoISO
END
GO

USE BelcorpCostaRica
GO

if Exists(select 1 from sys.objects where type = 'P' and name = 'GetPrefijoPais')
begin
	 drop proc GetPrefijoPais
end
GO
CREATE PROC GetPrefijoPais
(
@CodigoISO varchar(2)
)
AS
BEGIN
	select
		IsNull(PrefijoTelefono, '') as PrefijoTelefono
	from Pais
	where CodigoISO = @CodigoISO
END
GO

USE BelcorpChile
GO

if Exists(select 1 from sys.objects where type = 'P' and name = 'GetPrefijoPais')
begin
	 drop proc GetPrefijoPais
end
GO
CREATE PROC GetPrefijoPais
(
@CodigoISO varchar(2)
)
AS
BEGIN
	select
		IsNull(PrefijoTelefono, '') as PrefijoTelefono
	from Pais
	where CodigoISO = @CodigoISO
END
GO

USE BelcorpBolivia
GO

if Exists(select 1 from sys.objects where type = 'P' and name = 'GetPrefijoPais')
begin
	 drop proc GetPrefijoPais
end
GO
CREATE PROC GetPrefijoPais
(
@CodigoISO varchar(2)
)
AS
BEGIN
	select
		IsNull(PrefijoTelefono, '') as PrefijoTelefono
	from Pais
	where CodigoISO = @CodigoISO
END
GO

