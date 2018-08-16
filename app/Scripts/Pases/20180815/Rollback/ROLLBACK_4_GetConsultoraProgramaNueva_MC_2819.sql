USE BelcorpBolivia
GO
ALTER PROCEDURE dbo.GetConsultoraProgramaNueva
	@ConsultoraID  BIGINT
AS
BEGIN
	SET NOCOUNT ON;

	SELECT  
		C.ConsecutivoNueva, 
		CP.CodigoPrograma
	FROM ods.Consultora C WITH (NOLOCK) 
	LEFT JOIN ods.ConsultorasProgramaNuevas CP WITH (NOLOCK) ON C.Codigo = CP.CodigoConsultora AND CP.Participa = 1
	WHERE C.ConsultoraID = @ConsultoraID 
END
GO
/*end*/

USE BelcorpChile
GO
ALTER PROCEDURE dbo.GetConsultoraProgramaNueva
	@ConsultoraID  BIGINT
AS
BEGIN
	SET NOCOUNT ON;

	SELECT  
		C.ConsecutivoNueva, 
		CP.CodigoPrograma
	FROM ods.Consultora C WITH (NOLOCK) 
	LEFT JOIN ods.ConsultorasProgramaNuevas CP WITH (NOLOCK) ON C.Codigo = CP.CodigoConsultora AND CP.Participa = 1
	WHERE C.ConsultoraID = @ConsultoraID 
END
GO
/*end*/

USE BelcorpColombia
GO
ALTER PROCEDURE dbo.GetConsultoraProgramaNueva
	@ConsultoraID  BIGINT
AS
BEGIN
	SET NOCOUNT ON;

	SELECT  
		C.ConsecutivoNueva, 
		CP.CodigoPrograma
	FROM ods.Consultora C WITH (NOLOCK) 
	LEFT JOIN ods.ConsultorasProgramaNuevas CP WITH (NOLOCK) ON C.Codigo = CP.CodigoConsultora AND CP.Participa = 1
	WHERE C.ConsultoraID = @ConsultoraID 
END
GO
/*end*/

USE BelcorpCostaRica
GO
ALTER PROCEDURE dbo.GetConsultoraProgramaNueva
	@ConsultoraID  BIGINT
AS
BEGIN
	SET NOCOUNT ON;

	SELECT  
		C.ConsecutivoNueva, 
		CP.CodigoPrograma
	FROM ods.Consultora C WITH (NOLOCK) 
	LEFT JOIN ods.ConsultorasProgramaNuevas CP WITH (NOLOCK) ON C.Codigo = CP.CodigoConsultora AND CP.Participa = 1
	WHERE C.ConsultoraID = @ConsultoraID 
END
GO
/*end*/

USE BelcorpDominicana
GO
ALTER PROCEDURE dbo.GetConsultoraProgramaNueva
	@ConsultoraID  BIGINT
AS
BEGIN
	SET NOCOUNT ON;

	SELECT  
		C.ConsecutivoNueva, 
		CP.CodigoPrograma
	FROM ods.Consultora C WITH (NOLOCK) 
	LEFT JOIN ods.ConsultorasProgramaNuevas CP WITH (NOLOCK) ON C.Codigo = CP.CodigoConsultora AND CP.Participa = 1
	WHERE C.ConsultoraID = @ConsultoraID 
END
GO
/*end*/

USE BelcorpEcuador
GO
ALTER PROCEDURE dbo.GetConsultoraProgramaNueva
	@ConsultoraID  BIGINT
AS
BEGIN
	SET NOCOUNT ON;

	SELECT  
		C.ConsecutivoNueva, 
		CP.CodigoPrograma
	FROM ods.Consultora C WITH (NOLOCK) 
	LEFT JOIN ods.ConsultorasProgramaNuevas CP WITH (NOLOCK) ON C.Codigo = CP.CodigoConsultora AND CP.Participa = 1
	WHERE C.ConsultoraID = @ConsultoraID 
END
GO
/*end*/

USE BelcorpGuatemala
GO
ALTER PROCEDURE dbo.GetConsultoraProgramaNueva
	@ConsultoraID  BIGINT
AS
BEGIN
	SET NOCOUNT ON;

	SELECT  
		C.ConsecutivoNueva, 
		CP.CodigoPrograma
	FROM ods.Consultora C WITH (NOLOCK) 
	LEFT JOIN ods.ConsultorasProgramaNuevas CP WITH (NOLOCK) ON C.Codigo = CP.CodigoConsultora AND CP.Participa = 1
	WHERE C.ConsultoraID = @ConsultoraID 
END
GO
/*end*/

USE BelcorpMexico
GO
ALTER PROCEDURE dbo.GetConsultoraProgramaNueva
	@ConsultoraID  BIGINT
AS
BEGIN
	SET NOCOUNT ON;

	SELECT  
		C.ConsecutivoNueva, 
		CP.CodigoPrograma
	FROM ods.Consultora C WITH (NOLOCK) 
	LEFT JOIN ods.ConsultorasProgramaNuevas CP WITH (NOLOCK) ON C.Codigo = CP.CodigoConsultora AND CP.Participa = 1
	WHERE C.ConsultoraID = @ConsultoraID 
END
GO
/*end*/

USE BelcorpPanama
GO
ALTER PROCEDURE dbo.GetConsultoraProgramaNueva
	@ConsultoraID  BIGINT
AS
BEGIN
	SET NOCOUNT ON;

	SELECT  
		C.ConsecutivoNueva, 
		CP.CodigoPrograma
	FROM ods.Consultora C WITH (NOLOCK) 
	LEFT JOIN ods.ConsultorasProgramaNuevas CP WITH (NOLOCK) ON C.Codigo = CP.CodigoConsultora AND CP.Participa = 1
	WHERE C.ConsultoraID = @ConsultoraID 
END
GO
/*end*/

USE BelcorpPeru
GO
ALTER PROCEDURE dbo.GetConsultoraProgramaNueva
	@ConsultoraID  BIGINT
AS
BEGIN
	SET NOCOUNT ON;

	SELECT  
		C.ConsecutivoNueva, 
		CP.CodigoPrograma
	FROM ods.Consultora C WITH (NOLOCK) 
	LEFT JOIN ods.ConsultorasProgramaNuevas CP WITH (NOLOCK) ON C.Codigo = CP.CodigoConsultora AND CP.Participa = 1
	WHERE C.ConsultoraID = @ConsultoraID 
END
GO
/*end*/

USE BelcorpPuertoRico
GO
ALTER PROCEDURE dbo.GetConsultoraProgramaNueva
	@ConsultoraID  BIGINT
AS
BEGIN
	SET NOCOUNT ON;

	SELECT  
		C.ConsecutivoNueva, 
		CP.CodigoPrograma
	FROM ods.Consultora C WITH (NOLOCK) 
	LEFT JOIN ods.ConsultorasProgramaNuevas CP WITH (NOLOCK) ON C.Codigo = CP.CodigoConsultora AND CP.Participa = 1
	WHERE C.ConsultoraID = @ConsultoraID 
END
GO
/*end*/

USE BelcorpSalvador
GO
ALTER PROCEDURE dbo.GetConsultoraProgramaNueva
	@ConsultoraID  BIGINT
AS
BEGIN
	SET NOCOUNT ON;

	SELECT  
		C.ConsecutivoNueva, 
		CP.CodigoPrograma
	FROM ods.Consultora C WITH (NOLOCK) 
	LEFT JOIN ods.ConsultorasProgramaNuevas CP WITH (NOLOCK) ON C.Codigo = CP.CodigoConsultora AND CP.Participa = 1
	WHERE C.ConsultoraID = @ConsultoraID 
END
GO