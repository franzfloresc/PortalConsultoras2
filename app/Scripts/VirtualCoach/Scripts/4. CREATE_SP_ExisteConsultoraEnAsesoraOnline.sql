USE BelcorpChile
GO

CREATE PROCEDURE [dbo].[ExisteConsultoraEnAsesoraOnline]
	@CodigoConsultora varchar(20)
AS
BEGIN
	declare @result int;
	IF EXISTS (select * from dbo.AsesoraOnline where CodigoConsultora = @CodigoConsultora)
	  set @result = 1;
	ELSE
	  set @result = 0;

	select @result;
END
GO