GO
ALTER FUNCTION ValidarAutorizacion
(
	@paisID			INT,
	@CodigoUsuario	VARCHAR(100)
)
RETURNS INT
AS
/*
	SELECT DBO.ValidarAutorizacion(3, '1281283')
	SELECT DBO.ValidarAutorizacion(3, '076912262')
*/
BEGIN
	DECLARE @Usuario VARCHAR(100),
            @RolID INT,
            @AutorizaPedido VARCHAR(10),
            @IdEstadoActividad INT,
            @UltimaCampania INT,
            @CampaniaActual INT,
			@Resultado	INT,
			@CodigoConsultora varchar(20),
			@ZonaID INT,
			@RegionID INT,
			@ConsultoraID INT

	SET @RolID = 0
	SET @Usuario = ''
	SET @IdEstadoActividad = -1
	SET @UltimaCampania = 0
	SET @CampaniaActual = 0
	SET @Resultado = 0	

	SELECT	
		@CodigoConsultora = IsNull(CodigoConsultora,0),
		@PaisID = IsNull(PaisID,0)
	FROM usuario WITH(NOLOCK)
	WHERE codigousuario = @CodigoUsuario

	SELECT	
		@ZonaID = IsNull(ZonaID,0),
		@RegionID = IsNull(RegionID,0),
		@ConsultoraID = IsNull(ConsultoraID,0),
		@IdEstadoActividad = ISNULL(IdEstadoActividad,-1),
		@AutorizaPedido = ISNULL(AutorizaPedido,''),
		@UltimaCampania = ISNULL(UltimaCampanaFacturada,0)
	FROM ods.consultora WITH(NOLOCK)
	WHERE codigo = @CodigoConsultora

	SELECT 
		@Usuario = u.CodigoUsuario, 
		@RolID = ISNULL(ur.RolId,0),
		@AutorizaPedido = (CASE WHEN @AutorizaPedido = '' THEN '' WHEN @AutorizaPedido = '1' THEN 'S' WHEN @AutorizaPedido = '0' THEN 'N' END),
		@CampaniaActual = ISNULL((SELECT TOP 1 campaniaId FROM dbo.GetCampaniaPreLogin(@PaisID,@ZonaID,@RegionID,@ConsultoraID)),0)
	FROM Usuario u WITH(NOLOCK)
		LEFT JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario
	WHERE u.CodigoUsuario = @CodigoUsuario

    --0: Usuario No Existe
    --1: Usuario No es del Portal
    --2: Usuario Esta dentro de la Lista / Autoriza Pedido NULL o N
    --3: Usuario OK
	DECLARE @tabla_Retirada TABLE (Codigo VARCHAR(100) )
	INSERT INTO @tabla_Retirada
	SELECT Codigo FROM TablaLogicaDatos WHERE TablaLogicaID = 12
	
	DECLARE @tabla_Reingresada TABLE (Codigo VARCHAR(100) )
	INSERT INTO @tabla_Reingresada
	SELECT Codigo FROM TablaLogicaDatos WHERE TablaLogicaID = 18
	
	DECLARE @tabla_Egresada TABLE (Codigo VARCHAR(100) )
	INSERT INTO @tabla_Egresada
	SELECT Codigo FROM TablaLogicaDatos WHERE TablaLogicaID = 19

    IF @Usuario IS NOT NULL AND @Usuario <> ''
    BEGIN
        IF @RolID != 0
        BEGIN
            IF @AutorizaPedido IS NOT NULL AND @AutorizaPedido <> ''
            BEGIN
                IF @IdEstadoActividad <> -1
                BEGIN
                    -- Validamos si pertenece a Peru, Bolivia, Chile, Guatemala, El Salvador, Colombia (Paises ESIKA)
                    IF @paisID = 11 OR @paisID = 2 OR @paisID = 3 OR @paisID = 8 OR @paisID = 7 OR @paisID = 4
                    BEGIN
                        --Validamos si el estado es retirada
                        IF EXISTS(SELECT 1 FROM @tabla_Retirada WHERE Codigo = @IdEstadoActividad)
                        BEGIN
                            --Validamos si el pais es SICC
                            IF @paisID = 11 OR @paisID = 3 OR @paisID = 8 OR @paisID = 7 OR @paisID = 4
                            BEGIN
                                --Caso Colombia
								IF @paisID = 4
								BEGIN
                                    SET @Resultado =  2
                                END
								ELSE
                                BEGIN
                                    IF @AutorizaPedido = 'N'
                                        SET @Resultado =  2
                                    ELSE
                                        SET @Resultado =  3
                                END
                            END
                            ELSE
                            BEGIN
                                --Para bolivia (FOX) se hace la validación del campo AutorizaPedido
                                IF @paisID = 2
                                BEGIN
                                    IF @AutorizaPedido = 'N'
                                        SET @Resultado =  2
                                    ELSE
                                        SET @Resultado =  3
                                END
                                ELSE
                                BEGIN
                                    SET @Resultado =  3
                                END
                            END
                        END
                        ELSE
                        BEGIN
                            --Validamos si el estado es reingresada
                            IF EXISTS(SELECT 1 FROM @tabla_Reingresada WHERE Codigo = @IdEstadoActividad)
                            BEGIN
                                IF @paisID = 3
                                BEGIN
                                    --Se valida las campañas que no ha ingresado
                                    IF @UltimaCampania <> 0 AND LEN(@CampaniaActual) = 6 AND LEN(@UltimaCampania) = 6
                                    BEGIN
                                        DECLARE @CA VARCHAR(10),
												@UC VARCHAR(10)

										SET @CA = SUBSTRING(CONVERT(VARCHAR(6), @CampaniaActual), 1, 4)
                                        SET @UC = SUBSTRING(CONVERT(VARCHAR(6), @UltimaCampania), 1, 4)

                                        IF (@CA <> @UC)
                                        BEGIN
                                            SET @CA = SUBSTRING(CONVERT(VARCHAR(6), @CampaniaActual), 5, 2)
                                            SET @UC = SUBSTRING(CONVERT(VARCHAR(6), @UltimaCampania), 5, 2)
                                            SET @CampaniaActual = Convert(INT, @UC) + Convert(SMALLINT, @CA)
                                            SET @UltimaCampania = Convert(INT, @UC)
                                        END
                                    END

                                    IF @CampaniaActual - @UltimaCampania > 3 AND @UltimaCampania <> 0
                                        SET @Resultado =  2
                                    ELSE
                                    BEGIN
                                        --Validamos el Autoriza Pedido
                                        IF @AutorizaPedido = 'N'
                                            SET @Resultado =  2
                                        ELSE
                                            SET @Resultado =  3
                                    END
                                END
                                ELSE
                                BEGIN
                                    --Caso Colombia
                                    IF @paisID = 4
                                        SET @Resultado =  2
                                    ELSE
                                    BEGIN
                                        IF @AutorizaPedido = 'N'
                                        BEGIN
                                            --Validamos si es SICC o Bolivia
                                            IF @paisID = 11 OR @paisID = 3 OR @paisID = 8 OR @paisID = 7 OR @paisID = 2
                                                SET @Resultado =  2
                                            ELSE
                                                SET @Resultado =  3
                                        END
                                        ELSE
                                            SET @Resultado =  3
                                    END
                                END
                            END
                            ELSE
                            BEGIN
                                --Caso Colombia
                                IF @paisID = 4
                                BEGIN
                                    --Egresada o Posible Egreso
                                    IF EXISTS(SELECT 1 FROM @tabla_Egresada WHERE Codigo = @IdEstadoActividad)
                                    BEGIN
                                        SET @Resultado =  2
                                    END
                                END

                                --Validamos el Autoriza Pedido
                                IF @AutorizaPedido = 'N'
                                BEGIN
                                    --Validamos si es SICC o Bolivia
                                    IF @paisID = 11 OR @paisID = 3 OR @paisID = 8 OR @paisID = 7 OR @paisID = 2 OR @paisID = 4
                                        SET @Resultado =  2
                                    ELSE
                                        SET @Resultado =  3
                                END
                                ELSE
                                    SET @Resultado =  3

                            END
                        END
                    END
                    -- Validamos si pertenece a Costa Rica, Panama, Mexico, Puerto Rico, Dominicana, Ecuador, Argentina (Paises MyLbel)
                    ELSE IF @paisID = 5 OR @paisID = 10 OR @paisID = 9 OR @paisID = 12 OR @paisID = 13 OR @paisID = 6 OR @paisID = 1 OR @paisID = 14
                    BEGIN
                        -- Validamos si la consultora es retirada
                        IF EXISTS(SELECT 1 FROM @tabla_Retirada WHERE Codigo = @IdEstadoActividad)
                        BEGIN
                            --Validamos si el pais es SICC
                            IF @paisID = 5 OR @paisID = 10 OR @paisID = 6 OR @paisID = 14
                            BEGIN
                                --Validamos el Autoriza Pedido
                                IF @AutorizaPedido = 'N'
                                    SET @Resultado =  2
                                ELSE
                                    SET @Resultado =  3
                            END
                            ELSE
                            BEGIN
                                --Validamos el Autoriza Pedido
                                IF @AutorizaPedido = 'N'
                                BEGIN
                                    SET @Resultado =  2
                                END
                                ELSE
                                    SET @Resultado =  3
                            END
                        END
                        ELSE
                        BEGIN
                            --Validamos si el estado es retirada
                            IF EXISTS(SELECT 1 FROM @tabla_Egresada WHERE Codigo = @IdEstadoActividad)
                            BEGIN
								IF @AutorizaPedido = 'N'
								BEGIN
									--Validamos si es SICC
									IF @paisID = 5 OR @paisID = 10 OR @paisID = 6 OR @paisID = 14
										SET @Resultado =  2
									ELSE
										SET @Resultado =  3
								END
								ELSE
									SET @Resultado =  3
                            END
                            ELSE
                            BEGIN
                                --Validamos el Autoriza Pedido
                                IF @AutorizaPedido = 'N'
                                BEGIN
                                    --Validamos si es SICC
                                    IF @paisID = 5 OR @paisID = 10 OR @paisID = 6 OR @paisID = 14
                                        SET @Resultado =  2
                                    ELSE
                                        SET @Resultado =  3
                                END
                                ELSE
                                    SET @Resultado =  3
                            END
                        END
                    END
                    ELSE
                        SET @Resultado = 3
                END
                ELSE
                    SET @Resultado = 3 --Se asume para usuarios del tipo SAC
            END
            ELSE
                SET @Resultado = 3 --Se asume para usuarios del tipo SAC
        END
        ELSE
            SET @Resultado = 1
    END
    ELSE
        SET @Resultado = 0

    RETURN @Resultado

END
GO