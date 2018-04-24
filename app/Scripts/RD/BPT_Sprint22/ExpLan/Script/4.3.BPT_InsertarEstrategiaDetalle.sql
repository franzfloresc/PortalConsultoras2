GO
ALTER PROCEDURE [dbo].[InsertarEstrategiaDetalle]
	@EstrategiaID int,
	@FlagIndividual bit = 0,
	@Slogan varchar(500) = '',
	@ImgFondoDesktop varchar(500) = '',
	--@ImgPrevDesktop varchar(500) = '',
	@ImgFichaDesktop varchar(500) = '',
	@UrlVideoDesktop varchar(500) = '',
	@ImgFondoMobile varchar(500) = '',
	@ImgFichaMobile varchar(500) = '',
	@UrlVideoMobile varchar(500) = '',
	@ImgFichaFondoMobile varchar(500) = '',
	@ImgFichaFondoDesktop varchar(500) = '',
	@ImgHomeDesktop varchar(500) = '',
	@ImgHomeMobile varchar(500) = '',
	@Retorno int output
AS
BEGIN
SET NOCOUNT ON
	BEGIN TRY
		IF(@EstrategiaID > 0)
		BEGIN

			DELETE FROM EstrategiaDetalle WHERE EstrategiaID = @EstrategiaID;
			-- Se ingresa los valores para la estrategia de lanzamineto.
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10201', @ImgFondoDesktop, '', 1);
			--INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			--VALUES (@EstrategiaID, '10202', @ImgPrevDesktop, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10203', @ImgFichaDesktop, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10204', @UrlVideoDesktop, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10205', @ImgFondoMobile, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10206', @ImgFichaMobile, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10207', @UrlVideoMobile, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10208', @ImgFichaFondoDesktop, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10209', @ImgFichaFondoMobile, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10210', @ImgHomeDesktop, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10211', @ImgHomeMobile, '', 1);
			
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10212', case when @FlagIndividual = 1 then '1' else '0' end, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10213', @Slogan, '', 1);

			SET @Retorno = 1;
		END
	END TRY
		
	BEGIN CATCH
		DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT
		SELECT @ErrorMessage = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE()
		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState)
	END CATCH

SET NOCOUNT OFF
END
GO