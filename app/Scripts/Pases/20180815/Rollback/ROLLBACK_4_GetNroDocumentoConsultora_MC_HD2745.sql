USE BelcorpPeru
GO

ALTER PROCEDURE GetNroDocumentoConsultora

@CODIGO VARCHAR(25)

AS

BEGIN

declare @documento varchar(20)

	Set @documento = (Select Top 1 Isnull(I.Numero,'') from ods.consultora C Inner Join ods.Identificacion I ON C.ConsultoraId = I.ConsultoraID
	Where LTRIM(RTRIM(C.Codigo)) = @CODIGO and I.TipoDocumento = 'DNI' and I.DocumentoPrincipal = '1')

	if @documento = '' OR @documento is null
	begin
		Set @documento = (Select Top 1 Isnull(I.Numero,'') from ods.consultora C Inner Join ods.Identificacion I ON C.ConsultoraId = I.ConsultoraID
		Where LTRIM(RTRIM(C.Codigo)) = @CODIGO and I.DocumentoPrincipal = '1')
	end

	SELECT @documento
END
GO

USE BelcorpMexico
GO

ALTER PROCEDURE GetNroDocumentoConsultora

@CODIGO VARCHAR(25)

AS

BEGIN
	Select Top 1 Isnull(I.Numero,'') from ods.consultora C Inner Join ods.Identificacion I ON C.ConsultoraId = I.ConsultoraID
	Where LTRIM(RTRIM(C.Codigo)) = @CODIGO and I.TipoDocumento = 'DNI' and I.DocumentoPrincipal = '1'
END

GO

USE BelcorpColombia
GO

ALTER PROCEDURE GetNroDocumentoConsultora
@CODIGO VARCHAR(25)
AS
BEGIN
declare @documento varchar(20)
	Set @documento = (Select Top 1 Isnull(I.Numero,'') from ods.consultora C Inner Join ods.Identificacion I ON C.ConsultoraId = I.ConsultoraID
	Where LTRIM(RTRIM(C.Codigo)) = @CODIGO and I.TipoDocumento = 'DNI' and I.DocumentoPrincipal = '1')

	if @documento = '' OR @documento is null
	begin
		Set @documento = (Select Top 1 Isnull(I.Numero,'') from ods.consultora C Inner Join ods.Identificacion I ON C.ConsultoraId = I.ConsultoraID
		Where LTRIM(RTRIM(C.Codigo)) = @CODIGO and I.DocumentoPrincipal = '1')
	end
	SELECT @documento
END
GO

USE BelcorpSalvador
GO

ALTER PROCEDURE GetNroDocumentoConsultora

@CODIGO VARCHAR(25)

AS

BEGIN
	Select Top 1 Isnull(I.Numero,'') from ods.consultora C Inner Join ods.Identificacion I ON C.ConsultoraId = I.ConsultoraID
	Where LTRIM(RTRIM(C.Codigo)) = @CODIGO and I.TipoDocumento = 'DNI' and I.DocumentoPrincipal = '1'
END
GO

USE BelcorpPuertoRico
GO

ALTER PROCEDURE GetNroDocumentoConsultora

@CODIGO VARCHAR(25)

AS

BEGIN

declare @documento varchar(20)

	Set @documento = (Select Top 1 Isnull(I.Numero,'') from ods.consultora C Inner Join ods.Identificacion I ON C.ConsultoraId = I.ConsultoraID
	Where LTRIM(RTRIM(C.Codigo)) = @CODIGO and I.TipoDocumento = 'DNI' and I.DocumentoPrincipal = '1')

	if @documento = '' OR @documento is null
	begin
		Set @documento = (Select Top 1 Isnull(I.Numero,'') from ods.consultora C Inner Join ods.Identificacion I ON C.ConsultoraId = I.ConsultoraID
		Where LTRIM(RTRIM(C.Codigo)) = @CODIGO and I.DocumentoPrincipal = '1')
	end

	SELECT @documento
END
GO

USE BelcorpPanama
GO

ALTER PROCEDURE GetNroDocumentoConsultora

@CODIGO VARCHAR(25)

AS

BEGIN
	Select Top 1 Isnull(I.Numero,'') from ods.consultora C Inner Join ods.Identificacion I ON C.ConsultoraId = I.ConsultoraID
	Where LTRIM(RTRIM(C.Codigo)) = @CODIGO and I.TipoDocumento = 'DNI' and I.DocumentoPrincipal = '1'
END
GO

USE BelcorpGuatemala
GO

ALTER PROCEDURE GetNroDocumentoConsultora

@CODIGO VARCHAR(25)

AS

BEGIN
	Select Top 1 Isnull(I.Numero,'') from ods.consultora C Inner Join ods.Identificacion I ON C.ConsultoraId = I.ConsultoraID
	Where LTRIM(RTRIM(C.Codigo)) = @CODIGO and I.TipoDocumento = 'DNI' and I.DocumentoPrincipal = '1'
END
GO

USE BelcorpEcuador
GO

ALTER PROCEDURE GetNroDocumentoConsultora
	@CODIGO VARCHAR(25)
AS
BEGIN
	DECLARE @Sql VARCHAR(300)

		SET @Sql = 'SELECT TOP 1 ISNULL(I.Numero,'''')
					FROM ods.Consultora C
					INNER JOIN ods.Identificacion I ON C.ConsultoraID = I.ConsultoraID
					WHERE LTRIM(RTRIM(C.Codigo)) = ''' + @CODIGO + ''' AND (I.TipoDocumento = ''CCI'' OR I.DocumentoPrincipal = ''1'')'
		exec(@Sql)
END
GO

USE BelcorpDominicana
GO

ALTER PROCEDURE GetNroDocumentoConsultora

@CODIGO VARCHAR(25)

AS

BEGIN

declare @documento varchar(20)

	Set @documento = (Select Top 1 Isnull(I.Numero,'') from ods.consultora C Inner Join ods.Identificacion I ON C.ConsultoraId = I.ConsultoraID
	Where LTRIM(RTRIM(C.Codigo)) = @CODIGO and I.TipoDocumento = 'DNI' and I.DocumentoPrincipal = '1')

	if @documento = '' OR @documento is null
	begin
		Set @documento = (Select Top 1 Isnull(I.Numero,'') from ods.consultora C Inner Join ods.Identificacion I ON C.ConsultoraId = I.ConsultoraID
		Where LTRIM(RTRIM(C.Codigo)) = @CODIGO and I.DocumentoPrincipal = '1')
	end

	SELECT @documento
END
GO

USE BelcorpCostaRica
GO

ALTER PROCEDURE GetNroDocumentoConsultora

@CODIGO VARCHAR(25)

AS

BEGIN
	Select Top 1 Isnull(I.Numero,'') from ods.consultora C Inner Join ods.Identificacion I ON C.ConsultoraId = I.ConsultoraID
	Where LTRIM(RTRIM(C.Codigo)) = @CODIGO and I.TipoDocumento = 'DNI' and I.DocumentoPrincipal = '1'
END
GO

USE BelcorpChile
GO

ALTER PROCEDURE GetNroDocumentoConsultora

@CODIGO VARCHAR(25)
AS
BEGIN
	Select Top 1 Isnull(I.Numero,'') from ods.consultora C Inner Join ods.Identificacion I ON C.ConsultoraId = I.ConsultoraID
	Where LTRIM(RTRIM(C.Codigo)) = @CODIGO and I.TipoDocumento = 'DNI' and I.DocumentoPrincipal = '1'
END
GO

USE BelcorpBolivia
GO

ALTER PROCEDURE GetNroDocumentoConsultora

@CODIGO VARCHAR(25)

AS

BEGIN

declare @documento varchar(20)

	Set @documento = (Select Top 1 Isnull(I.Numero,'') from ods.consultora C Inner Join ods.Identificacion I ON C.ConsultoraId = I.ConsultoraID
	Where LTRIM(RTRIM(C.Codigo)) = @CODIGO and I.TipoDocumento = 'DNI' and I.DocumentoPrincipal = '1')

	if @documento = '' OR @documento is null
	begin
		Set @documento = (Select Top 1 Isnull(I.Numero,'') from ods.consultora C Inner Join ods.Identificacion I ON C.ConsultoraId = I.ConsultoraID
		Where LTRIM(RTRIM(C.Codigo)) = @CODIGO and I.DocumentoPrincipal = '1')
	end

	SELECT @documento
END
GO

