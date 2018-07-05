use BelcorpColombia
go


ALTER PROCEDURE InsContrato
	@consultoraid BIGINT,
	@codigoconsultora VARCHAR(25)
AS
BEGIN
	SET NOCOUNT ON
		DECLARE @CodigoUsuario VARCHAR(20),
				@CampaniaID int,
				@ZonaID int,
				@RegionID int

		SET @CodigoUsuario = (SELECT u.CodigoConsultora FROM Usuario U inner join ods.Consultora C ON u.CodigoConsultora = c.Codigo
		WHERE ConsultoraID = @consultoraid)

		SELECT	@ZonaID = ISNULL(ZonaID,0),
				@RegionID = ISNULL(RegionID,0)
		FROM ods.consultora WITH(NOLOCK)
		WHERE ConsultoraID = @consultoraid

		SET @CampaniaID = (SELECT campaniaId FROM dbo.GetCampaniaPreLogin(4, @ZonaID, @RegionID, @ConsultoraID))

		IF	EXISTS(SELECT 1 FROM contrato WHERE ConsultoraID= @consultoraid)
		BEGIN
			UPDATE contrato SET AceptoContrato = 1, FechaAceptacion=GETDATE() WHERE ConsultoraID=@consultoraid
			UPDATE PaqueteDocumentario SET Campania = @CampaniaID, EstadoInvitacion = 1 WHERE CodigoConsultora = @CodigoUsuario
		END
		ELSE
		BEGIN
		-- INSERT INTO contrato (ConsultoraID	,CodigoConsultora	,AceptoContrato	,FechaAceptacion) VALUES (@consultoraid,@codigoconsultora,1,GETDATE());
			INSERT INTO contrato VALUES(@consultoraid,@codigoconsultora,1,GETDATE())
			IF NOT EXISTS(SELECT 1 FROM PaqueteDocumentario WHERE CodigoConsultora = @codigoconsultora AND Campania = @CampaniaID)
			BEGIN
				INSERT INTO PaqueteDocumentario VALUES (@CodigoUsuario, @CampaniaID, 1)
			END
		END
	SET NOCOUNT OFF
END

