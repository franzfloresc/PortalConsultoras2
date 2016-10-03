go
if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('dbo.Usuario') and SYSCOLUMNS.NAME = N'VioTutorialDesktop') = 0
	ALTER TABLE dbo.Usuario ADD VioTutorialDesktop bit
go


IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'setUsuarioVerTutorialDesktop_SB2' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.setUsuarioVerTutorialDesktop_SB2
END

go
CREATE PROCEDURE setUsuarioVerTutorialDesktop_SB2
@codigoUsuario VARCHAR(25)
AS
BEGIN
	UPDATE Usuario
	SET VioTutorialDesktop = 1
	WHERE CodigoUsuario = @codigoUsuario
	SELECT 1
END

go

-- Solo peru y chile dejarlo en null o cero el campo VioTutorialDesktop
-- demás países ponerlo igual a VioVideo
GO
declare @Igual int = 0
select @Igual = count(1) from pais where CodigoIso in ('CL', 'PE') and EstadoActivo = 1

if @Igual = 0
begin
	UPDATE Usuario
	SET VioTutorialDesktop = VioVideo
end

GO
