USE BelcorpChile
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'ExisteConsultoraEnAsesoraOnline' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.ExisteConsultoraEnAsesoraOnline
END
GO
CREATE PROCEDURE dbo.ExisteConsultoraEnAsesoraOnline
	@CodigoConsultora varchar(20)
AS
BEGIN
	declare @result int;
	IF EXISTS (select 1 from dbo.AsesoraOnline where CodigoConsultora = @CodigoConsultora)
		set @result = 1;
	ELSE
		set @result = 0;

	select @result;
END
GO