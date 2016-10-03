
go
if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('dbo.Usuario') and SYSCOLUMNS.NAME = N'VioTutorialDestock') = 0
	ALTER TABLE dbo.Usuario ADD VioTutorialDestock bit
go


IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'setUsuarioVerTutorialDestock_SB2' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.setUsuarioVerTutorialDestock_SB2
END

go
CREATE PROCEDURE setUsuarioVerTutorialDestock_SB2
@codigoUsuario VARCHAR(25)
AS
BEGIN
	UPDATE Usuario
	SET VioTutorialDestock = 1
	WHERE CodigoUsuario = @codigoUsuario
	SELECT 1
END

go

-- Solo peru y chile dejaro en null o cero el campo VioTutorialDestock
-- demás países ponerlo igual a VioVideo
GO
declare @Igual int = 0
select @Igual = count(1) from pais where CodigoIso in ('CL', 'PE') and EstadoActivo = 1

if @Igual = 0
begin
	UPDATE Usuario
	SET VioTutorialDestock = VioVideo
end

GO
