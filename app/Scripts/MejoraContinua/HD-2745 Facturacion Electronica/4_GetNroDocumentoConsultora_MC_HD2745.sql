USE BelcorpPeru
GO

ALTER PROCEDURE GetNroDocumentoConsultora
@CODIGO VARCHAR(25)
AS
BEGIN
	Select Top 1 Isnull(I.Numero,'') from ods.consultora C Inner Join ods.Identificacion I ON C.ConsultoraId = I.ConsultoraID
	Where LTRIM(RTRIM(C.Codigo)) = @CODIGO and I.DocumentoPrincipal = '1'
END
GO

USE BelcorpMexico
GO

ALTER PROCEDURE GetNroDocumentoConsultora
@CODIGO VARCHAR(25)
AS
BEGIN
	Select Top 1 Isnull(I.Numero,'') from ods.consultora C Inner Join ods.Identificacion I ON C.ConsultoraId = I.ConsultoraID
	Where LTRIM(RTRIM(C.Codigo)) = @CODIGO and I.DocumentoPrincipal = '1'
END
GO

USE BelcorpColombia
GO

ALTER PROCEDURE GetNroDocumentoConsultora
@CODIGO VARCHAR(25)
AS
BEGIN
	Select Top 1 Isnull(I.Numero,'') from ods.consultora C Inner Join ods.Identificacion I ON C.ConsultoraId = I.ConsultoraID
	Where LTRIM(RTRIM(C.Codigo)) = @CODIGO and I.DocumentoPrincipal = '1'
END
GO

USE BelcorpSalvador
GO

ALTER PROCEDURE GetNroDocumentoConsultora
@CODIGO VARCHAR(25)
AS
BEGIN
	Select Top 1 Isnull(I.Numero,'') from ods.consultora C Inner Join ods.Identificacion I ON C.ConsultoraId = I.ConsultoraID
	Where LTRIM(RTRIM(C.Codigo)) = @CODIGO and I.DocumentoPrincipal = '1'
END
GO

USE BelcorpPuertoRico
GO

ALTER PROCEDURE GetNroDocumentoConsultora
@CODIGO VARCHAR(25)
AS
BEGIN
	Select Top 1 Isnull(I.Numero,'') from ods.consultora C Inner Join ods.Identificacion I ON C.ConsultoraId = I.ConsultoraID
	Where LTRIM(RTRIM(C.Codigo)) = @CODIGO and I.DocumentoPrincipal = '1'
END
GO

USE BelcorpPanama
GO

ALTER PROCEDURE GetNroDocumentoConsultora
@CODIGO VARCHAR(25)
AS
BEGIN
	Select Top 1 Isnull(I.Numero,'') from ods.consultora C Inner Join ods.Identificacion I ON C.ConsultoraId = I.ConsultoraID
	Where LTRIM(RTRIM(C.Codigo)) = @CODIGO and I.DocumentoPrincipal = '1'
END
GO

USE BelcorpGuatemala
GO

ALTER PROCEDURE GetNroDocumentoConsultora
@CODIGO VARCHAR(25)
AS
BEGIN
	Select Top 1 Isnull(I.Numero,'') from ods.consultora C Inner Join ods.Identificacion I ON C.ConsultoraId = I.ConsultoraID
	Where LTRIM(RTRIM(C.Codigo)) = @CODIGO and I.DocumentoPrincipal = '1'
END
GO

USE BelcorpEcuador
GO

ALTER PROCEDURE GetNroDocumentoConsultora
@CODIGO VARCHAR(25)
AS
BEGIN
	Select Top 1 Isnull(I.Numero,'') from ods.consultora C Inner Join ods.Identificacion I ON C.ConsultoraId = I.ConsultoraID
	Where LTRIM(RTRIM(C.Codigo)) = @CODIGO and I.DocumentoPrincipal = '1'
END
GO

USE BelcorpDominicana
GO

ALTER PROCEDURE GetNroDocumentoConsultora
@CODIGO VARCHAR(25)
AS
BEGIN
	Select Top 1 Isnull(I.Numero,'') from ods.consultora C Inner Join ods.Identificacion I ON C.ConsultoraId = I.ConsultoraID
	Where LTRIM(RTRIM(C.Codigo)) = @CODIGO and I.DocumentoPrincipal = '1'
END
GO

USE BelcorpCostaRica
GO

ALTER PROCEDURE GetNroDocumentoConsultora
@CODIGO VARCHAR(25)
AS
BEGIN
	Select Top 1 Isnull(I.Numero,'') from ods.consultora C Inner Join ods.Identificacion I ON C.ConsultoraId = I.ConsultoraID
	Where LTRIM(RTRIM(C.Codigo)) = @CODIGO and I.DocumentoPrincipal = '1'
END
GO

USE BelcorpChile
GO

ALTER PROCEDURE GetNroDocumentoConsultora
@CODIGO VARCHAR(25)
AS
BEGIN
	Select Top 1 Isnull(I.Numero,'') from ods.consultora C Inner Join ods.Identificacion I ON C.ConsultoraId = I.ConsultoraID
	Where LTRIM(RTRIM(C.Codigo)) = @CODIGO and I.DocumentoPrincipal = '1'
END
GO

USE BelcorpBolivia
GO

ALTER PROCEDURE GetNroDocumentoConsultora
@CODIGO VARCHAR(25)
AS
BEGIN
	Select Top 1 Isnull(I.Numero,'') from ods.consultora C Inner Join ods.Identificacion I ON C.ConsultoraId = I.ConsultoraID
	Where LTRIM(RTRIM(C.Codigo)) = @CODIGO and I.DocumentoPrincipal = '1'
END
GO

