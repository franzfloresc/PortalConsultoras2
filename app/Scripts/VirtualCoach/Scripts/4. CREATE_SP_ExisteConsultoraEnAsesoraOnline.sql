USE BelcorpChile
GO

CREATE PROCEDURE [dbo].[ExisteConsultoraEnAsesoraOnline]
	@CodigoConsultora varchar(20)
AS
BEGIN
	IF EXISTS (select * from dbo.AsesoraOnline where CodigoConsultora = @CodigoConsultora)
	  return 1;
	ELSE
	  return 0;
END
GO