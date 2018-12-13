USE BelcorpPeru
GO

IF EXISTS(SELECT 1 
          FROM   sys.procedures 
          WHERE  NAME = 'usp_InsertEventoConsultora') 
  BEGIN 
      DROP PROCEDURE dbo.usp_inserteventoconsultora 
  END 
go 

CREATE PROCEDURE dbo.Usp_inserteventoconsultora @CampaniaID       INT, 
                                                @CodigoConsultora VARCHAR(20), 
                                                @Retorno          INT out 
AS 
  BEGIN 
      SET nocount ON 
      SET @Retorno = 0 
      DECLARE @EventoId INT 
      DECLARE @FechaGeneral DATETIME 
      DECLARE @IsoPais VARCHAR(5) 
      DECLARE @Segmento VARCHAR(50) 
      SET @IsoPais = (SELECT codigoiso 
                      FROM   pais 
                      WHERE  estadoactivo = 1) 
      SET @Segmento = (SELECT Concat (@IsoPais, '_', @CampaniaID, '_Perfil01')) 
      DECLARE @CodConsultoraForzada VARCHAR(20) = '' 
      SELECT @CodConsultoraForzada = codigo 
      FROM   tablalogicadatos 
      WHERE  tablalogicadatosid = 10002 

      IF EXISTS (SELECT 1 
                 FROM   ods.ofertaspersonalizadas op 
                 WHERE  op.codconsultora IN ( 
                        @CodigoConsultora, @CodConsultoraForzada 
                                            ) 
                        AND op.aniocampanaventa = @CampaniaID 
                        AND op.tipopersonalizacion = 'SR') 
        BEGIN 
            IF NOT EXISTS (SELECT 1 
                           FROM   showroom.eventoconsultora sc 
                           WHERE  sc.campaniaid = @CampaniaID 
                                  AND sc.codigoconsultora = @CodigoConsultora) 
              BEGIN 
                  SET @EventoId = (SELECT TOP 1 eventoid 
                                   FROM   showroom.evento 
                                   WHERE  campaniaid = @CampaniaID) 
                  SET @FechaGeneral = dbo.Fnobtenerfechahorapais() 

                  INSERT INTO showroom.eventoconsultora 
                              (eventoid, 
                               campaniaid, 
                               codigoconsultora, 
                               segmento, 
                               mostrarpopup, 
                               fechacreacion, 
                               usuariocreacion, 
                               fechamodificacion, 
                               usuariomodificacion, 
                               mostrarpopupventa, 
                               esgenerica) 
                  VALUES      ( @EventoId, 
                                @CampaniaID, 
                                @CodigoConsultora, 
                                @Segmento, 
                                1, 
                                @FechaGeneral, 
                                'MICROSERVICIO', 
                                @FechaGeneral, 
                                'MICROSERVICIO', 
                                1, 
                                0 ) 

                  SET @Retorno = @@IDENTITY 
              END 
        END 
      ELSE 
        BEGIN 
            --PRINT 'NO Existe en ofertas personalizadas' 
            --Buscar el valor generico 
            DECLARE @CodConsultoraGenerica VARCHAR(20) = '' 

            SELECT @CodConsultoraGenerica = codigo 
            FROM   tablalogicadatos 
            WHERE  tablalogicadatosid = 10001 

            IF EXISTS (SELECT 1 
                       FROM   ods.ofertaspersonalizadas op 
                       WHERE  op.codconsultora = @CodConsultoraGenerica 
                              AND op.aniocampanaventa = @CampaniaID 
                              AND op.tipopersonalizacion = 'SR') 
              BEGIN 
                  IF NOT EXISTS (SELECT 1 
                                 FROM   showroom.eventoconsultora sc 
                                 WHERE  sc.campaniaid = @CampaniaID 
                                        AND sc.codigoconsultora = 
                                            @CodigoConsultora) 
                    BEGIN 
                        SET @EventoId = (SELECT TOP 1 eventoid 
                                         FROM   showroom.evento 
                                         WHERE  campaniaid = @CampaniaID) 
                        SET @FechaGeneral = dbo.Fnobtenerfechahorapais() 

                        INSERT INTO showroom.eventoconsultora 
                                    (eventoid, 
                                     campaniaid, 
                                     codigoconsultora, 
                                     segmento, 
                                     mostrarpopup, 
                                     fechacreacion, 
                                     usuariocreacion, 
                                     fechamodificacion, 
                                     usuariomodificacion, 
                                     mostrarpopupventa, 
                                     esgenerica) 
                        VALUES      ( @EventoId, 
                                      @CampaniaID, 
                                      @CodigoConsultora, 
                                      @Segmento, 
                                      1, 
                                      @FechaGeneral, 
                                      'MICROSERVICIO', 
                                      @FechaGeneral, 
                                      'MICROSERVICIO', 
                                      1, 
                                      1 ) 
                        SET @Retorno = @@IDENTITY 
                    END 
              END 
        END 

		IF (@Retorno =0)
		BEGIN
		 SELECT @Retorno = EventoConsultoraID from  showroom.eventoconsultora Where campaniaid = @CampaniaID AND codigoconsultora = @CodigoConsultora
		END
  END 
  GO



USE BelcorpMexico

GO



IF EXISTS(SELECT 1 

          FROM   sys.procedures 

          WHERE  NAME = 'usp_InsertEventoConsultora') 

  BEGIN 

      DROP PROCEDURE dbo.usp_inserteventoconsultora 

  END 



go 



CREATE PROCEDURE dbo.Usp_inserteventoconsultora @CampaniaID       INT, 

                                                @CodigoConsultora VARCHAR(20), 

                                                @Retorno          INT out 

AS 

  BEGIN 

      SET nocount ON 

      SET @Retorno = 0 



      DECLARE @EventoId INT 

      DECLARE @FechaGeneral DATETIME 

      DECLARE @IsoPais VARCHAR(5) 

      DECLARE @Segmento VARCHAR(50) 



      SET @IsoPais = (SELECT codigoiso 

                      FROM   pais 

                      WHERE  estadoactivo = 1) 

      SET @Segmento = (SELECT Concat (@IsoPais, '_', @CampaniaID, '_Perfil01')) 



      DECLARE @CodConsultoraForzada VARCHAR(20) = '' 



      SELECT @CodConsultoraForzada = codigo 

      FROM   tablalogicadatos 

      WHERE  tablalogicadatosid = 10002 



      IF EXISTS (SELECT 1 

                 FROM   ods.ofertaspersonalizadas op 

                 WHERE  op.codconsultora IN ( 

                        @CodigoConsultora, @CodConsultoraForzada 

                                            ) 

                        AND op.aniocampanaventa = @CampaniaID 

                        AND op.tipopersonalizacion = 'SR') 

        BEGIN 

            IF NOT EXISTS (SELECT 1 

                           FROM   showroom.eventoconsultora sc 

                           WHERE  sc.campaniaid = @CampaniaID 

                                  AND sc.codigoconsultora = @CodigoConsultora) 

              BEGIN 

                  SET @EventoId = (SELECT TOP 1 eventoid 

                                   FROM   showroom.evento 

                                   WHERE  campaniaid = @CampaniaID) 

                  SET @FechaGeneral = dbo.Fnobtenerfechahorapais() 



                  INSERT INTO showroom.eventoconsultora 

                              (eventoid, 

                               campaniaid, 

                               codigoconsultora, 

                               segmento, 

                               mostrarpopup, 

                               fechacreacion, 

                               usuariocreacion, 

                               fechamodificacion, 

                               usuariomodificacion, 

                               mostrarpopupventa, 

                               esgenerica) 

                  VALUES      ( @EventoId, 

                                @CampaniaID, 

                                @CodigoConsultora, 

                                @Segmento, 

                                1, 

                                @FechaGeneral, 

                                'MICROSERVICIO', 

                                @FechaGeneral, 

                                'MICROSERVICIO', 

                                1, 

                                0 ) 



                  SET @Retorno = @@IDENTITY 

              END 

        END 

      ELSE 

        BEGIN 

            --PRINT 'NO Existe en ofertas personalizadas' 

            --Buscar el valor generico 

            DECLARE @CodConsultoraGenerica VARCHAR(20) = '' 



            SELECT @CodConsultoraGenerica = codigo 

            FROM   tablalogicadatos 

            WHERE  tablalogicadatosid = 10001 



            IF EXISTS (SELECT 1 

                       FROM   ods.ofertaspersonalizadas op 

                       WHERE  op.codconsultora = @CodConsultoraGenerica 

                              AND op.aniocampanaventa = @CampaniaID 

                              AND op.tipopersonalizacion = 'SR') 

              BEGIN 

                  IF NOT EXISTS (SELECT 1 

                                 FROM   showroom.eventoconsultora sc 

                                 WHERE  sc.campaniaid = @CampaniaID 

                                        AND sc.codigoconsultora = 

                                            @CodigoConsultora) 

                    BEGIN 

                        SET @EventoId = (SELECT TOP 1 eventoid 

                                         FROM   showroom.evento 

                                         WHERE  campaniaid = @CampaniaID) 

                        SET @FechaGeneral = dbo.Fnobtenerfechahorapais() 



                        INSERT INTO showroom.eventoconsultora 

                                    (eventoid, 

                                     campaniaid, 

                                     codigoconsultora, 

                                     segmento, 

                                     mostrarpopup, 

                                     fechacreacion, 

                                     usuariocreacion, 

                                     fechamodificacion, 

                                     usuariomodificacion, 

                                     mostrarpopupventa, 

                                     esgenerica) 

                        VALUES      ( @EventoId, 

                                      @CampaniaID, 

                                      @CodigoConsultora, 

                                      @Segmento, 

                                      1, 

                                      @FechaGeneral, 

                                      'MICROSERVICIO', 

                                      @FechaGeneral, 

                                      'MICROSERVICIO', 

                                      1, 

                                      1 ) 



                        SET @Retorno = @@IDENTITY 

                    END 

              END 

        END 



		IF (@Retorno =0)

		BEGIN

		 SELECT @Retorno = EventoConsultoraID from  showroom.eventoconsultora Where campaniaid = @CampaniaID AND codigoconsultora = @CodigoConsultora

		END

  END 

  GO



USE BelcorpColombia

GO



IF EXISTS(SELECT 1 

          FROM   sys.procedures 

          WHERE  NAME = 'usp_InsertEventoConsultora') 

  BEGIN 

      DROP PROCEDURE dbo.usp_inserteventoconsultora 

  END 



go 



CREATE PROCEDURE dbo.Usp_inserteventoconsultora @CampaniaID       INT, 

                                                @CodigoConsultora VARCHAR(20), 

                                                @Retorno          INT out 

AS 

  BEGIN 

      SET nocount ON 

      SET @Retorno = 0 



      DECLARE @EventoId INT 

      DECLARE @FechaGeneral DATETIME 

      DECLARE @IsoPais VARCHAR(5) 

      DECLARE @Segmento VARCHAR(50) 



      SET @IsoPais = (SELECT codigoiso 

                      FROM   pais 

                      WHERE  estadoactivo = 1) 

      SET @Segmento = (SELECT Concat (@IsoPais, '_', @CampaniaID, '_Perfil01')) 



      DECLARE @CodConsultoraForzada VARCHAR(20) = '' 



      SELECT @CodConsultoraForzada = codigo 

      FROM   tablalogicadatos 

      WHERE  tablalogicadatosid = 10002 



      IF EXISTS (SELECT 1 

                 FROM   ods.ofertaspersonalizadas op 

                 WHERE  op.codconsultora IN ( 

                        @CodigoConsultora, @CodConsultoraForzada 

                                            ) 

                        AND op.aniocampanaventa = @CampaniaID 

                        AND op.tipopersonalizacion = 'SR') 

        BEGIN 

            IF NOT EXISTS (SELECT 1 

                           FROM   showroom.eventoconsultora sc 

                           WHERE  sc.campaniaid = @CampaniaID 

                                  AND sc.codigoconsultora = @CodigoConsultora) 

              BEGIN 

                  SET @EventoId = (SELECT TOP 1 eventoid 

                                   FROM   showroom.evento 

                                   WHERE  campaniaid = @CampaniaID) 

                  SET @FechaGeneral = dbo.Fnobtenerfechahorapais() 



                  INSERT INTO showroom.eventoconsultora 

                              (eventoid, 

                               campaniaid, 

                               codigoconsultora, 

                               segmento, 

                               mostrarpopup, 

                               fechacreacion, 

                               usuariocreacion, 

                               fechamodificacion, 

                               usuariomodificacion, 

                               mostrarpopupventa, 

                               esgenerica) 

                  VALUES      ( @EventoId, 

                                @CampaniaID, 

                                @CodigoConsultora, 

                                @Segmento, 

                                1, 

                                @FechaGeneral, 

                                'MICROSERVICIO', 

                                @FechaGeneral, 

                                'MICROSERVICIO', 

                                1, 

                                0 ) 



                  SET @Retorno = @@IDENTITY 

              END 

        END 

      ELSE 

        BEGIN 

            --PRINT 'NO Existe en ofertas personalizadas' 

            --Buscar el valor generico 

            DECLARE @CodConsultoraGenerica VARCHAR(20) = '' 



            SELECT @CodConsultoraGenerica = codigo 

            FROM   tablalogicadatos 

            WHERE  tablalogicadatosid = 10001 



            IF EXISTS (SELECT 1 

                       FROM   ods.ofertaspersonalizadas op 

                       WHERE  op.codconsultora = @CodConsultoraGenerica 

                              AND op.aniocampanaventa = @CampaniaID 

                              AND op.tipopersonalizacion = 'SR') 

              BEGIN 

                  IF NOT EXISTS (SELECT 1 

                                 FROM   showroom.eventoconsultora sc 

                                 WHERE  sc.campaniaid = @CampaniaID 

                                        AND sc.codigoconsultora = 

                                            @CodigoConsultora) 

                    BEGIN 

                        SET @EventoId = (SELECT TOP 1 eventoid 

                                         FROM   showroom.evento 

                                         WHERE  campaniaid = @CampaniaID) 

                        SET @FechaGeneral = dbo.Fnobtenerfechahorapais() 



                        INSERT INTO showroom.eventoconsultora 

                                    (eventoid, 

                                     campaniaid, 

                                     codigoconsultora, 

                                     segmento, 

                                     mostrarpopup, 

                                     fechacreacion, 

                                     usuariocreacion, 

                                     fechamodificacion, 

                                     usuariomodificacion, 

                                     mostrarpopupventa, 

                                     esgenerica) 

                        VALUES      ( @EventoId, 

                                      @CampaniaID, 

                                      @CodigoConsultora, 

                                      @Segmento, 

                                      1, 

                                      @FechaGeneral, 

                                      'MICROSERVICIO', 

                                      @FechaGeneral, 

                                      'MICROSERVICIO', 

                                      1, 

                                      1 ) 



                        SET @Retorno = @@IDENTITY 

                    END 

              END 

        END 



		IF (@Retorno =0)

		BEGIN

		 SELECT @Retorno = EventoConsultoraID from  showroom.eventoconsultora Where campaniaid = @CampaniaID AND codigoconsultora = @CodigoConsultora

		END

  END 

  GO


USE BelcorpSalvador

GO



IF EXISTS(SELECT 1 

          FROM   sys.procedures 

          WHERE  NAME = 'usp_InsertEventoConsultora') 

  BEGIN 

      DROP PROCEDURE dbo.usp_inserteventoconsultora 

  END 



go 



CREATE PROCEDURE dbo.Usp_inserteventoconsultora @CampaniaID       INT, 

                                                @CodigoConsultora VARCHAR(20), 

                                                @Retorno          INT out 

AS 

  BEGIN 

      SET nocount ON 

      SET @Retorno = 0 



      DECLARE @EventoId INT 

      DECLARE @FechaGeneral DATETIME 

      DECLARE @IsoPais VARCHAR(5) 

      DECLARE @Segmento VARCHAR(50) 



      SET @IsoPais = (SELECT codigoiso 

                      FROM   pais 

                      WHERE  estadoactivo = 1) 

      SET @Segmento = (SELECT Concat (@IsoPais, '_', @CampaniaID, '_Perfil01')) 



      DECLARE @CodConsultoraForzada VARCHAR(20) = '' 



      SELECT @CodConsultoraForzada = codigo 

      FROM   tablalogicadatos 

      WHERE  tablalogicadatosid = 10002 



      IF EXISTS (SELECT 1 

                 FROM   ods.ofertaspersonalizadas op 

                 WHERE  op.codconsultora IN ( 

                        @CodigoConsultora, @CodConsultoraForzada 

                                            ) 

                        AND op.aniocampanaventa = @CampaniaID 

                        AND op.tipopersonalizacion = 'SR') 

        BEGIN 

            IF NOT EXISTS (SELECT 1 

                           FROM   showroom.eventoconsultora sc 

                           WHERE  sc.campaniaid = @CampaniaID 

                                  AND sc.codigoconsultora = @CodigoConsultora) 

              BEGIN 

                  SET @EventoId = (SELECT TOP 1 eventoid 

                                   FROM   showroom.evento 

                                   WHERE  campaniaid = @CampaniaID) 

                  SET @FechaGeneral = dbo.Fnobtenerfechahorapais() 



                  INSERT INTO showroom.eventoconsultora 

                              (eventoid, 

                               campaniaid, 

                               codigoconsultora, 

                               segmento, 

                               mostrarpopup, 

                               fechacreacion, 

                               usuariocreacion, 

                               fechamodificacion, 

                               usuariomodificacion, 

                               mostrarpopupventa, 

                               esgenerica) 

                  VALUES      ( @EventoId, 

                                @CampaniaID, 

                                @CodigoConsultora, 

                                @Segmento, 

                                1, 

                                @FechaGeneral, 

                                'MICROSERVICIO', 

                                @FechaGeneral, 

                                'MICROSERVICIO', 

                                1, 

                                0 ) 



                  SET @Retorno = @@IDENTITY 

              END 

        END 

      ELSE 

        BEGIN 

            --PRINT 'NO Existe en ofertas personalizadas' 

            --Buscar el valor generico 

            DECLARE @CodConsultoraGenerica VARCHAR(20) = '' 



            SELECT @CodConsultoraGenerica = codigo 

            FROM   tablalogicadatos 

            WHERE  tablalogicadatosid = 10001 



            IF EXISTS (SELECT 1 

                       FROM   ods.ofertaspersonalizadas op 

                       WHERE  op.codconsultora = @CodConsultoraGenerica 

                              AND op.aniocampanaventa = @CampaniaID 

                              AND op.tipopersonalizacion = 'SR') 

              BEGIN 

                  IF NOT EXISTS (SELECT 1 

                                 FROM   showroom.eventoconsultora sc 

                                 WHERE  sc.campaniaid = @CampaniaID 

                                        AND sc.codigoconsultora = 

                                            @CodigoConsultora) 

                    BEGIN 

                        SET @EventoId = (SELECT TOP 1 eventoid 

                                         FROM   showroom.evento 

                                         WHERE  campaniaid = @CampaniaID) 

                        SET @FechaGeneral = dbo.Fnobtenerfechahorapais() 



                        INSERT INTO showroom.eventoconsultora 

                                    (eventoid, 

                                     campaniaid, 

                                     codigoconsultora, 

                                     segmento, 

                                     mostrarpopup, 

                                     fechacreacion, 

                                     usuariocreacion, 

                                     fechamodificacion, 

                                     usuariomodificacion, 

                                     mostrarpopupventa, 

                                     esgenerica) 

                        VALUES      ( @EventoId, 

                                      @CampaniaID, 

                                      @CodigoConsultora, 

                                      @Segmento, 

                                      1, 

                                      @FechaGeneral, 

                                      'MICROSERVICIO', 

                                      @FechaGeneral, 

                                      'MICROSERVICIO', 

                                      1, 

                                      1 ) 



                        SET @Retorno = @@IDENTITY 

                    END 

              END 

        END 



		IF (@Retorno =0)

		BEGIN

		 SELECT @Retorno = EventoConsultoraID from  showroom.eventoconsultora Where campaniaid = @CampaniaID AND codigoconsultora = @CodigoConsultora

		END

  END 

  GO



USE BelcorpPuertoRico

GO



IF EXISTS(SELECT 1 

          FROM   sys.procedures 

          WHERE  NAME = 'usp_InsertEventoConsultora') 

  BEGIN 

      DROP PROCEDURE dbo.usp_inserteventoconsultora 

  END 



go 



CREATE PROCEDURE dbo.Usp_inserteventoconsultora @CampaniaID       INT, 

                                                @CodigoConsultora VARCHAR(20), 

                                                @Retorno          INT out 

AS 

  BEGIN 

      SET nocount ON 

      SET @Retorno = 0 



      DECLARE @EventoId INT 

      DECLARE @FechaGeneral DATETIME 

      DECLARE @IsoPais VARCHAR(5) 

      DECLARE @Segmento VARCHAR(50) 



      SET @IsoPais = (SELECT codigoiso 

                      FROM   pais 

                      WHERE  estadoactivo = 1) 

      SET @Segmento = (SELECT Concat (@IsoPais, '_', @CampaniaID, '_Perfil01')) 



      DECLARE @CodConsultoraForzada VARCHAR(20) = '' 



      SELECT @CodConsultoraForzada = codigo 

      FROM   tablalogicadatos 

      WHERE  tablalogicadatosid = 10002 



      IF EXISTS (SELECT 1 

                 FROM   ods.ofertaspersonalizadas op 

                 WHERE  op.codconsultora IN ( 

                        @CodigoConsultora, @CodConsultoraForzada 

                                            ) 

                        AND op.aniocampanaventa = @CampaniaID 

                        AND op.tipopersonalizacion = 'SR') 

        BEGIN 

            IF NOT EXISTS (SELECT 1 

                           FROM   showroom.eventoconsultora sc 

                           WHERE  sc.campaniaid = @CampaniaID 

                                  AND sc.codigoconsultora = @CodigoConsultora) 

              BEGIN 

                  SET @EventoId = (SELECT TOP 1 eventoid 

                                   FROM   showroom.evento 

                                   WHERE  campaniaid = @CampaniaID) 

                  SET @FechaGeneral = dbo.Fnobtenerfechahorapais() 



                  INSERT INTO showroom.eventoconsultora 

                              (eventoid, 

                               campaniaid, 

                               codigoconsultora, 

                               segmento, 

                               mostrarpopup, 

                               fechacreacion, 

                               usuariocreacion, 

                               fechamodificacion, 

                               usuariomodificacion, 

                               mostrarpopupventa, 

                               esgenerica) 

                  VALUES      ( @EventoId, 

                                @CampaniaID, 

                                @CodigoConsultora, 

                                @Segmento, 

                                1, 

                                @FechaGeneral, 

                                'MICROSERVICIO', 

                                @FechaGeneral, 

                                'MICROSERVICIO', 

                                1, 

                                0 ) 



                  SET @Retorno = @@IDENTITY 

              END 

        END 

      ELSE 

        BEGIN 

            --PRINT 'NO Existe en ofertas personalizadas' 

            --Buscar el valor generico 

            DECLARE @CodConsultoraGenerica VARCHAR(20) = '' 



            SELECT @CodConsultoraGenerica = codigo 

            FROM   tablalogicadatos 

            WHERE  tablalogicadatosid = 10001 



            IF EXISTS (SELECT 1 

                       FROM   ods.ofertaspersonalizadas op 

                       WHERE  op.codconsultora = @CodConsultoraGenerica 

                              AND op.aniocampanaventa = @CampaniaID 

                              AND op.tipopersonalizacion = 'SR') 

              BEGIN 

                  IF NOT EXISTS (SELECT 1 

                                 FROM   showroom.eventoconsultora sc 

                                 WHERE  sc.campaniaid = @CampaniaID 

                                        AND sc.codigoconsultora = 

                                            @CodigoConsultora) 

                    BEGIN 

                        SET @EventoId = (SELECT TOP 1 eventoid 

                                         FROM   showroom.evento 

                                         WHERE  campaniaid = @CampaniaID) 

                        SET @FechaGeneral = dbo.Fnobtenerfechahorapais() 



                        INSERT INTO showroom.eventoconsultora 

                                    (eventoid, 

                                     campaniaid, 

                                     codigoconsultora, 

                                     segmento, 

                                     mostrarpopup, 

                                     fechacreacion, 

                                     usuariocreacion, 

                                     fechamodificacion, 

                                     usuariomodificacion, 

                                     mostrarpopupventa, 

                                     esgenerica) 

                        VALUES      ( @EventoId, 

                                      @CampaniaID, 

                                      @CodigoConsultora, 

                                      @Segmento, 

                                      1, 

                                      @FechaGeneral, 

                                      'MICROSERVICIO', 

                                      @FechaGeneral, 

                                      'MICROSERVICIO', 

                                      1, 

                                      1 ) 



                        SET @Retorno = @@IDENTITY 

                    END 

              END 

        END 



		IF (@Retorno =0)

		BEGIN

		 SELECT @Retorno = EventoConsultoraID from  showroom.eventoconsultora Where campaniaid = @CampaniaID AND codigoconsultora = @CodigoConsultora

		END

  END 

  GO



USE BelcorpPanama

GO



IF EXISTS(SELECT 1 

          FROM   sys.procedures 

          WHERE  NAME = 'usp_InsertEventoConsultora') 

  BEGIN 

      DROP PROCEDURE dbo.usp_inserteventoconsultora 

  END 



go 



CREATE PROCEDURE dbo.Usp_inserteventoconsultora @CampaniaID       INT, 

                                                @CodigoConsultora VARCHAR(20), 

                                                @Retorno          INT out 

AS 

  BEGIN 

      SET nocount ON 

      SET @Retorno = 0 



      DECLARE @EventoId INT 

      DECLARE @FechaGeneral DATETIME 

      DECLARE @IsoPais VARCHAR(5) 

      DECLARE @Segmento VARCHAR(50) 



      SET @IsoPais = (SELECT codigoiso 

                      FROM   pais 

                      WHERE  estadoactivo = 1) 

      SET @Segmento = (SELECT Concat (@IsoPais, '_', @CampaniaID, '_Perfil01')) 



      DECLARE @CodConsultoraForzada VARCHAR(20) = '' 



      SELECT @CodConsultoraForzada = codigo 

      FROM   tablalogicadatos 

      WHERE  tablalogicadatosid = 10002 



      IF EXISTS (SELECT 1 

                 FROM   ods.ofertaspersonalizadas op 

                 WHERE  op.codconsultora IN ( 

                        @CodigoConsultora, @CodConsultoraForzada 

                                            ) 

                        AND op.aniocampanaventa = @CampaniaID 

                        AND op.tipopersonalizacion = 'SR') 

        BEGIN 

            IF NOT EXISTS (SELECT 1 

                           FROM   showroom.eventoconsultora sc 

                           WHERE  sc.campaniaid = @CampaniaID 

                                  AND sc.codigoconsultora = @CodigoConsultora) 

              BEGIN 

                  SET @EventoId = (SELECT TOP 1 eventoid 

                                   FROM   showroom.evento 

                                   WHERE  campaniaid = @CampaniaID) 

                  SET @FechaGeneral = dbo.Fnobtenerfechahorapais() 



                  INSERT INTO showroom.eventoconsultora 

                              (eventoid, 

                               campaniaid, 

                               codigoconsultora, 

                               segmento, 

                               mostrarpopup, 

                               fechacreacion, 

                               usuariocreacion, 

                               fechamodificacion, 

                               usuariomodificacion, 

                               mostrarpopupventa, 

                               esgenerica) 

                  VALUES      ( @EventoId, 

                                @CampaniaID, 

                                @CodigoConsultora, 

                                @Segmento, 

                                1, 

                                @FechaGeneral, 

                                'MICROSERVICIO', 

                                @FechaGeneral, 

                                'MICROSERVICIO', 

                                1, 

                                0 ) 



                  SET @Retorno = @@IDENTITY 

              END 

        END 

      ELSE 

        BEGIN 

            --PRINT 'NO Existe en ofertas personalizadas' 

            --Buscar el valor generico 

            DECLARE @CodConsultoraGenerica VARCHAR(20) = '' 



            SELECT @CodConsultoraGenerica = codigo 

            FROM   tablalogicadatos 

            WHERE  tablalogicadatosid = 10001 



            IF EXISTS (SELECT 1 

                       FROM   ods.ofertaspersonalizadas op 

                       WHERE  op.codconsultora = @CodConsultoraGenerica 

                              AND op.aniocampanaventa = @CampaniaID 

                              AND op.tipopersonalizacion = 'SR') 

              BEGIN 

                  IF NOT EXISTS (SELECT 1 

                                 FROM   showroom.eventoconsultora sc 

                                 WHERE  sc.campaniaid = @CampaniaID 

                                        AND sc.codigoconsultora = 

                                            @CodigoConsultora) 

                    BEGIN 

                        SET @EventoId = (SELECT TOP 1 eventoid 

                                         FROM   showroom.evento 

                                         WHERE  campaniaid = @CampaniaID) 

                        SET @FechaGeneral = dbo.Fnobtenerfechahorapais() 



                        INSERT INTO showroom.eventoconsultora 

                                    (eventoid, 

                                     campaniaid, 

                                     codigoconsultora, 

                                     segmento, 

                                     mostrarpopup, 

                                     fechacreacion, 

                                     usuariocreacion, 

                                     fechamodificacion, 

                                     usuariomodificacion, 

                                     mostrarpopupventa, 

                                     esgenerica) 

                        VALUES      ( @EventoId, 

                                      @CampaniaID, 

                                      @CodigoConsultora, 

                                      @Segmento, 

                                      1, 

                                      @FechaGeneral, 

                                      'MICROSERVICIO', 

                                      @FechaGeneral, 

                                      'MICROSERVICIO', 

                                      1, 

                                      1 ) 



                        SET @Retorno = @@IDENTITY 

                    END 

              END 

        END 



		IF (@Retorno =0)

		BEGIN

		 SELECT @Retorno = EventoConsultoraID from  showroom.eventoconsultora Where campaniaid = @CampaniaID AND codigoconsultora = @CodigoConsultora

		END

  END 

  GO



USE BelcorpGuatemala

GO



IF EXISTS(SELECT 1 

          FROM   sys.procedures 

          WHERE  NAME = 'usp_InsertEventoConsultora') 

  BEGIN 

      DROP PROCEDURE dbo.usp_inserteventoconsultora 

  END 



go 



CREATE PROCEDURE dbo.Usp_inserteventoconsultora @CampaniaID       INT, 

                                                @CodigoConsultora VARCHAR(20), 

                                                @Retorno          INT out 

AS 

  BEGIN 

      SET nocount ON 

      SET @Retorno = 0 



      DECLARE @EventoId INT 

      DECLARE @FechaGeneral DATETIME 

      DECLARE @IsoPais VARCHAR(5) 

      DECLARE @Segmento VARCHAR(50) 



      SET @IsoPais = (SELECT codigoiso 

                      FROM   pais 

                      WHERE  estadoactivo = 1) 

      SET @Segmento = (SELECT Concat (@IsoPais, '_', @CampaniaID, '_Perfil01')) 



      DECLARE @CodConsultoraForzada VARCHAR(20) = '' 



      SELECT @CodConsultoraForzada = codigo 

      FROM   tablalogicadatos 

      WHERE  tablalogicadatosid = 10002 



      IF EXISTS (SELECT 1 

                 FROM   ods.ofertaspersonalizadas op 

                 WHERE  op.codconsultora IN ( 

                        @CodigoConsultora, @CodConsultoraForzada 

                                            ) 

                        AND op.aniocampanaventa = @CampaniaID 

                        AND op.tipopersonalizacion = 'SR') 

        BEGIN 

            IF NOT EXISTS (SELECT 1 

                           FROM   showroom.eventoconsultora sc 

                           WHERE  sc.campaniaid = @CampaniaID 

                                  AND sc.codigoconsultora = @CodigoConsultora) 

              BEGIN 

                  SET @EventoId = (SELECT TOP 1 eventoid 

                                   FROM   showroom.evento 

                                   WHERE  campaniaid = @CampaniaID) 

                  SET @FechaGeneral = dbo.Fnobtenerfechahorapais() 



                  INSERT INTO showroom.eventoconsultora 

                              (eventoid, 

                               campaniaid, 

                               codigoconsultora, 

                               segmento, 

                               mostrarpopup, 

                               fechacreacion, 

                               usuariocreacion, 

                               fechamodificacion, 

                               usuariomodificacion, 

                               mostrarpopupventa, 

                               esgenerica) 

                  VALUES      ( @EventoId, 

                                @CampaniaID, 

                                @CodigoConsultora, 

                                @Segmento, 

                                1, 

                                @FechaGeneral, 

                                'MICROSERVICIO', 

                                @FechaGeneral, 

                                'MICROSERVICIO', 

                                1, 

                                0 ) 



                  SET @Retorno = @@IDENTITY 

              END 

        END 

      ELSE 

        BEGIN 

            --PRINT 'NO Existe en ofertas personalizadas' 

            --Buscar el valor generico 

            DECLARE @CodConsultoraGenerica VARCHAR(20) = '' 



            SELECT @CodConsultoraGenerica = codigo 

            FROM   tablalogicadatos 

            WHERE  tablalogicadatosid = 10001 



            IF EXISTS (SELECT 1 

                       FROM   ods.ofertaspersonalizadas op 

                       WHERE  op.codconsultora = @CodConsultoraGenerica 

                              AND op.aniocampanaventa = @CampaniaID 

                              AND op.tipopersonalizacion = 'SR') 

              BEGIN 

                  IF NOT EXISTS (SELECT 1 

                                 FROM   showroom.eventoconsultora sc 

                                 WHERE  sc.campaniaid = @CampaniaID 

                                        AND sc.codigoconsultora = 

                                            @CodigoConsultora) 

                    BEGIN 

                        SET @EventoId = (SELECT TOP 1 eventoid 

                                         FROM   showroom.evento 

                                         WHERE  campaniaid = @CampaniaID) 

                        SET @FechaGeneral = dbo.Fnobtenerfechahorapais() 



                        INSERT INTO showroom.eventoconsultora 

                                    (eventoid, 

                                     campaniaid, 

                                     codigoconsultora, 

                                     segmento, 

                                     mostrarpopup, 

                                     fechacreacion, 

                                     usuariocreacion, 

                                     fechamodificacion, 

                                     usuariomodificacion, 

                                     mostrarpopupventa, 

                                     esgenerica) 

                        VALUES      ( @EventoId, 

                                      @CampaniaID, 

                                      @CodigoConsultora, 

                                      @Segmento, 

                                      1, 

                                      @FechaGeneral, 

                                      'MICROSERVICIO', 

                                      @FechaGeneral, 

                                      'MICROSERVICIO', 

                                      1, 

                                      1 ) 



                        SET @Retorno = @@IDENTITY 

                    END 

              END 

        END 



		IF (@Retorno =0)

		BEGIN

		 SELECT @Retorno = EventoConsultoraID from  showroom.eventoconsultora Where campaniaid = @CampaniaID AND codigoconsultora = @CodigoConsultora

		END

  END 

  GO



USE BelcorpEcuador

GO



IF EXISTS(SELECT 1 

          FROM   sys.procedures 

          WHERE  NAME = 'usp_InsertEventoConsultora') 

  BEGIN 

      DROP PROCEDURE dbo.usp_inserteventoconsultora 

  END 



go 



CREATE PROCEDURE dbo.Usp_inserteventoconsultora @CampaniaID       INT, 

                                                @CodigoConsultora VARCHAR(20), 

                                                @Retorno          INT out 

AS 

  BEGIN 

      SET nocount ON 

      SET @Retorno = 0 



      DECLARE @EventoId INT 

      DECLARE @FechaGeneral DATETIME 

      DECLARE @IsoPais VARCHAR(5) 

      DECLARE @Segmento VARCHAR(50) 



      SET @IsoPais = (SELECT codigoiso 

                      FROM   pais 

                      WHERE  estadoactivo = 1) 

      SET @Segmento = (SELECT Concat (@IsoPais, '_', @CampaniaID, '_Perfil01')) 



      DECLARE @CodConsultoraForzada VARCHAR(20) = '' 



      SELECT @CodConsultoraForzada = codigo 

      FROM   tablalogicadatos 

      WHERE  tablalogicadatosid = 10002 



      IF EXISTS (SELECT 1 

                 FROM   ods.ofertaspersonalizadas op 

                 WHERE  op.codconsultora IN ( 

                        @CodigoConsultora, @CodConsultoraForzada 

                                            ) 

                        AND op.aniocampanaventa = @CampaniaID 

                        AND op.tipopersonalizacion = 'SR') 

        BEGIN 

            IF NOT EXISTS (SELECT 1 

                           FROM   showroom.eventoconsultora sc 

                           WHERE  sc.campaniaid = @CampaniaID 

                                  AND sc.codigoconsultora = @CodigoConsultora) 

              BEGIN 

                  SET @EventoId = (SELECT TOP 1 eventoid 

                                   FROM   showroom.evento 

                                   WHERE  campaniaid = @CampaniaID) 

                  SET @FechaGeneral = dbo.Fnobtenerfechahorapais() 



                  INSERT INTO showroom.eventoconsultora 

                              (eventoid, 

                               campaniaid, 

                               codigoconsultora, 

                               segmento, 

                               mostrarpopup, 

                               fechacreacion, 

                               usuariocreacion, 

                               fechamodificacion, 

                               usuariomodificacion, 

                               mostrarpopupventa, 

                               esgenerica) 

                  VALUES      ( @EventoId, 

                                @CampaniaID, 

                                @CodigoConsultora, 

                                @Segmento, 

                                1, 

                                @FechaGeneral, 

                                'MICROSERVICIO', 

                                @FechaGeneral, 

                                'MICROSERVICIO', 

                                1, 

                                0 ) 



                  SET @Retorno = @@IDENTITY 

              END 

        END 

      ELSE 

        BEGIN 

            --PRINT 'NO Existe en ofertas personalizadas' 

            --Buscar el valor generico 

            DECLARE @CodConsultoraGenerica VARCHAR(20) = '' 



            SELECT @CodConsultoraGenerica = codigo 

            FROM   tablalogicadatos 

            WHERE  tablalogicadatosid = 10001 



            IF EXISTS (SELECT 1 

                       FROM   ods.ofertaspersonalizadas op 

                       WHERE  op.codconsultora = @CodConsultoraGenerica 

                              AND op.aniocampanaventa = @CampaniaID 

                              AND op.tipopersonalizacion = 'SR') 

              BEGIN 

                  IF NOT EXISTS (SELECT 1 

                                 FROM   showroom.eventoconsultora sc 

                                 WHERE  sc.campaniaid = @CampaniaID 

                                        AND sc.codigoconsultora = 

                                            @CodigoConsultora) 

                    BEGIN 

                        SET @EventoId = (SELECT TOP 1 eventoid 

                                         FROM   showroom.evento 

                                         WHERE  campaniaid = @CampaniaID) 

                        SET @FechaGeneral = dbo.Fnobtenerfechahorapais() 



                        INSERT INTO showroom.eventoconsultora 

                                    (eventoid, 

                                     campaniaid, 

                                     codigoconsultora, 

                                     segmento, 

                                     mostrarpopup, 

                                     fechacreacion, 

                                     usuariocreacion, 

                                     fechamodificacion, 

                                     usuariomodificacion, 

                                     mostrarpopupventa, 

                                     esgenerica) 

                        VALUES      ( @EventoId, 

                                      @CampaniaID, 

                                      @CodigoConsultora, 

                                      @Segmento, 

                                      1, 

                                      @FechaGeneral, 

                                      'MICROSERVICIO', 

                                      @FechaGeneral, 

                                      'MICROSERVICIO', 

                                      1, 

                                      1 ) 



                        SET @Retorno = @@IDENTITY 

                    END 

              END 

        END 



		IF (@Retorno =0)

		BEGIN

		 SELECT @Retorno = EventoConsultoraID from  showroom.eventoconsultora Where campaniaid = @CampaniaID AND codigoconsultora = @CodigoConsultora

		END

  END 

  GO



USE BelcorpDominicana

GO



IF EXISTS(SELECT 1 

          FROM   sys.procedures 

          WHERE  NAME = 'usp_InsertEventoConsultora') 

  BEGIN 

      DROP PROCEDURE dbo.usp_inserteventoconsultora 

  END 



go 



CREATE PROCEDURE dbo.Usp_inserteventoconsultora @CampaniaID       INT, 

                                                @CodigoConsultora VARCHAR(20), 

                                                @Retorno          INT out 

AS 

  BEGIN 

      SET nocount ON 

      SET @Retorno = 0 



      DECLARE @EventoId INT 

      DECLARE @FechaGeneral DATETIME 

      DECLARE @IsoPais VARCHAR(5) 

      DECLARE @Segmento VARCHAR(50) 



      SET @IsoPais = (SELECT codigoiso 

                      FROM   pais 

                      WHERE  estadoactivo = 1) 

      SET @Segmento = (SELECT Concat (@IsoPais, '_', @CampaniaID, '_Perfil01')) 



      DECLARE @CodConsultoraForzada VARCHAR(20) = '' 



      SELECT @CodConsultoraForzada = codigo 

      FROM   tablalogicadatos 

      WHERE  tablalogicadatosid = 10002 



      IF EXISTS (SELECT 1 

                 FROM   ods.ofertaspersonalizadas op 

                 WHERE  op.codconsultora IN ( 

                        @CodigoConsultora, @CodConsultoraForzada 

                                            ) 

                        AND op.aniocampanaventa = @CampaniaID 

                        AND op.tipopersonalizacion = 'SR') 

        BEGIN 

            IF NOT EXISTS (SELECT 1 

                           FROM   showroom.eventoconsultora sc 

                           WHERE  sc.campaniaid = @CampaniaID 

                                  AND sc.codigoconsultora = @CodigoConsultora) 

              BEGIN 

                  SET @EventoId = (SELECT TOP 1 eventoid 

                                   FROM   showroom.evento 

                                   WHERE  campaniaid = @CampaniaID) 

                  SET @FechaGeneral = dbo.Fnobtenerfechahorapais() 



                  INSERT INTO showroom.eventoconsultora 

                              (eventoid, 

                               campaniaid, 

                               codigoconsultora, 

                               segmento, 

                               mostrarpopup, 

                               fechacreacion, 

                               usuariocreacion, 

                               fechamodificacion, 

                               usuariomodificacion, 

                               mostrarpopupventa, 

                               esgenerica) 

                  VALUES      ( @EventoId, 

                                @CampaniaID, 

                                @CodigoConsultora, 

                                @Segmento, 

                                1, 

                                @FechaGeneral, 

                                'MICROSERVICIO', 

                                @FechaGeneral, 

                                'MICROSERVICIO', 

                                1, 

                                0 ) 



                  SET @Retorno = @@IDENTITY 

              END 

        END 

      ELSE 

        BEGIN 

            --PRINT 'NO Existe en ofertas personalizadas' 

            --Buscar el valor generico 

            DECLARE @CodConsultoraGenerica VARCHAR(20) = '' 



            SELECT @CodConsultoraGenerica = codigo 

            FROM   tablalogicadatos 

            WHERE  tablalogicadatosid = 10001 



            IF EXISTS (SELECT 1 

                       FROM   ods.ofertaspersonalizadas op 

                       WHERE  op.codconsultora = @CodConsultoraGenerica 

                              AND op.aniocampanaventa = @CampaniaID 

                              AND op.tipopersonalizacion = 'SR') 

              BEGIN 

                  IF NOT EXISTS (SELECT 1 

                                 FROM   showroom.eventoconsultora sc 

                                 WHERE  sc.campaniaid = @CampaniaID 

                                        AND sc.codigoconsultora = 

                                            @CodigoConsultora) 

                    BEGIN 

                        SET @EventoId = (SELECT TOP 1 eventoid 

                                         FROM   showroom.evento 

                                         WHERE  campaniaid = @CampaniaID) 

                        SET @FechaGeneral = dbo.Fnobtenerfechahorapais() 



                        INSERT INTO showroom.eventoconsultora 

                                    (eventoid, 

                                     campaniaid, 

                                     codigoconsultora, 

                                     segmento, 

                                     mostrarpopup, 

                                     fechacreacion, 

                                     usuariocreacion, 

                                     fechamodificacion, 

                                     usuariomodificacion, 

                                     mostrarpopupventa, 

                                     esgenerica) 

                        VALUES      ( @EventoId, 

                                      @CampaniaID, 

                                      @CodigoConsultora, 

                                      @Segmento, 

                                      1, 

                                      @FechaGeneral, 

                                      'MICROSERVICIO', 

                                      @FechaGeneral, 

                                      'MICROSERVICIO', 

                                      1, 

                                      1 ) 



                        SET @Retorno = @@IDENTITY 

                    END 

              END 

        END 



		IF (@Retorno =0)

		BEGIN

		 SELECT @Retorno = EventoConsultoraID from  showroom.eventoconsultora Where campaniaid = @CampaniaID AND codigoconsultora = @CodigoConsultora

		END

  END 

  GO



USE BelcorpCostaRica

GO



IF EXISTS(SELECT 1 

          FROM   sys.procedures 

          WHERE  NAME = 'usp_InsertEventoConsultora') 

  BEGIN 

      DROP PROCEDURE dbo.usp_inserteventoconsultora 

  END 



go 



CREATE PROCEDURE dbo.Usp_inserteventoconsultora @CampaniaID       INT, 

                                                @CodigoConsultora VARCHAR(20), 

                                                @Retorno          INT out 

AS 

  BEGIN 

      SET nocount ON 

      SET @Retorno = 0 



      DECLARE @EventoId INT 

      DECLARE @FechaGeneral DATETIME 

      DECLARE @IsoPais VARCHAR(5) 

      DECLARE @Segmento VARCHAR(50) 



      SET @IsoPais = (SELECT codigoiso 

                      FROM   pais 

                      WHERE  estadoactivo = 1) 

      SET @Segmento = (SELECT Concat (@IsoPais, '_', @CampaniaID, '_Perfil01')) 



      DECLARE @CodConsultoraForzada VARCHAR(20) = '' 



      SELECT @CodConsultoraForzada = codigo 

      FROM   tablalogicadatos 

      WHERE  tablalogicadatosid = 10002 



      IF EXISTS (SELECT 1 

                 FROM   ods.ofertaspersonalizadas op 

                 WHERE  op.codconsultora IN ( 

                        @CodigoConsultora, @CodConsultoraForzada 

                                            ) 

                        AND op.aniocampanaventa = @CampaniaID 

                        AND op.tipopersonalizacion = 'SR') 

        BEGIN 

            IF NOT EXISTS (SELECT 1 

                           FROM   showroom.eventoconsultora sc 

                           WHERE  sc.campaniaid = @CampaniaID 

                                  AND sc.codigoconsultora = @CodigoConsultora) 

              BEGIN 

                  SET @EventoId = (SELECT TOP 1 eventoid 

                                   FROM   showroom.evento 

                                   WHERE  campaniaid = @CampaniaID) 

                  SET @FechaGeneral = dbo.Fnobtenerfechahorapais() 



                  INSERT INTO showroom.eventoconsultora 

                              (eventoid, 

                               campaniaid, 

                               codigoconsultora, 

                               segmento, 

                               mostrarpopup, 

                               fechacreacion, 

                               usuariocreacion, 

                               fechamodificacion, 

                               usuariomodificacion, 

                               mostrarpopupventa, 

                               esgenerica) 

                  VALUES      ( @EventoId, 

                                @CampaniaID, 

                                @CodigoConsultora, 

                                @Segmento, 

                                1, 

                                @FechaGeneral, 

                                'MICROSERVICIO', 

                                @FechaGeneral, 

                                'MICROSERVICIO', 

                                1, 

                                0 ) 



                  SET @Retorno = @@IDENTITY 

              END 

        END 

      ELSE 

        BEGIN 

            --PRINT 'NO Existe en ofertas personalizadas' 

            --Buscar el valor generico 

            DECLARE @CodConsultoraGenerica VARCHAR(20) = '' 



            SELECT @CodConsultoraGenerica = codigo 

            FROM   tablalogicadatos 

            WHERE  tablalogicadatosid = 10001 



            IF EXISTS (SELECT 1 

                       FROM   ods.ofertaspersonalizadas op 

                       WHERE  op.codconsultora = @CodConsultoraGenerica 

                              AND op.aniocampanaventa = @CampaniaID 

                              AND op.tipopersonalizacion = 'SR') 

              BEGIN 

                  IF NOT EXISTS (SELECT 1 

                                 FROM   showroom.eventoconsultora sc 

                                 WHERE  sc.campaniaid = @CampaniaID 

                                        AND sc.codigoconsultora = 

                                            @CodigoConsultora) 

                    BEGIN 

                        SET @EventoId = (SELECT TOP 1 eventoid 

                                         FROM   showroom.evento 

                                         WHERE  campaniaid = @CampaniaID) 

                        SET @FechaGeneral = dbo.Fnobtenerfechahorapais() 



                        INSERT INTO showroom.eventoconsultora 

                                    (eventoid, 

                                     campaniaid, 

                                     codigoconsultora, 

                                     segmento, 

                                     mostrarpopup, 

                                     fechacreacion, 

                                     usuariocreacion, 

                                     fechamodificacion, 

                                     usuariomodificacion, 

                                     mostrarpopupventa, 

                                     esgenerica) 

                        VALUES      ( @EventoId, 

                                      @CampaniaID, 

                                      @CodigoConsultora, 

                                      @Segmento, 

                                      1, 

                                      @FechaGeneral, 

                                      'MICROSERVICIO', 

                                      @FechaGeneral, 

                                      'MICROSERVICIO', 

                                      1, 

                                      1 ) 



                        SET @Retorno = @@IDENTITY 

                    END 

              END 

        END 



		IF (@Retorno =0)

		BEGIN

		 SELECT @Retorno = EventoConsultoraID from  showroom.eventoconsultora Where campaniaid = @CampaniaID AND codigoconsultora = @CodigoConsultora

		END

  END 

  GO



USE BelcorpChile

GO



IF EXISTS(SELECT 1 

          FROM   sys.procedures 

          WHERE  NAME = 'usp_InsertEventoConsultora') 

  BEGIN 

      DROP PROCEDURE dbo.usp_inserteventoconsultora 

  END 



go 



CREATE PROCEDURE dbo.Usp_inserteventoconsultora @CampaniaID       INT, 

                                                @CodigoConsultora VARCHAR(20), 

                                                @Retorno          INT out 

AS 

  BEGIN 

      SET nocount ON 

      SET @Retorno = 0 



      DECLARE @EventoId INT 

      DECLARE @FechaGeneral DATETIME 

      DECLARE @IsoPais VARCHAR(5) 

      DECLARE @Segmento VARCHAR(50) 



      SET @IsoPais = (SELECT codigoiso 

                      FROM   pais 

                      WHERE  estadoactivo = 1) 

      SET @Segmento = (SELECT Concat (@IsoPais, '_', @CampaniaID, '_Perfil01')) 



      DECLARE @CodConsultoraForzada VARCHAR(20) = '' 



      SELECT @CodConsultoraForzada = codigo 

      FROM   tablalogicadatos 

      WHERE  tablalogicadatosid = 10002 



      IF EXISTS (SELECT 1 

                 FROM   ods.ofertaspersonalizadas op 

                 WHERE  op.codconsultora IN ( 

                        @CodigoConsultora, @CodConsultoraForzada 

                                            ) 

                        AND op.aniocampanaventa = @CampaniaID 

                        AND op.tipopersonalizacion = 'SR') 

        BEGIN 

            IF NOT EXISTS (SELECT 1 

                           FROM   showroom.eventoconsultora sc 

                           WHERE  sc.campaniaid = @CampaniaID 

                                  AND sc.codigoconsultora = @CodigoConsultora) 

              BEGIN 

                  SET @EventoId = (SELECT TOP 1 eventoid 

                                   FROM   showroom.evento 

                                   WHERE  campaniaid = @CampaniaID) 

                  SET @FechaGeneral = dbo.Fnobtenerfechahorapais() 



                  INSERT INTO showroom.eventoconsultora 

                              (eventoid, 

                               campaniaid, 

                               codigoconsultora, 

                               segmento, 

                               mostrarpopup, 

                               fechacreacion, 

                               usuariocreacion, 

                               fechamodificacion, 

                               usuariomodificacion, 

                               mostrarpopupventa, 

                               esgenerica) 

                  VALUES      ( @EventoId, 

                                @CampaniaID, 

                                @CodigoConsultora, 

                                @Segmento, 

                                1, 

                                @FechaGeneral, 

                                'MICROSERVICIO', 

                                @FechaGeneral, 

                                'MICROSERVICIO', 

                                1, 

                                0 ) 



                  SET @Retorno = @@IDENTITY 

              END 

        END 

      ELSE 

        BEGIN 

            --PRINT 'NO Existe en ofertas personalizadas' 

            --Buscar el valor generico 

            DECLARE @CodConsultoraGenerica VARCHAR(20) = '' 



            SELECT @CodConsultoraGenerica = codigo 

            FROM   tablalogicadatos 

            WHERE  tablalogicadatosid = 10001 



            IF EXISTS (SELECT 1 

                       FROM   ods.ofertaspersonalizadas op 

                       WHERE  op.codconsultora = @CodConsultoraGenerica 

                              AND op.aniocampanaventa = @CampaniaID 

                              AND op.tipopersonalizacion = 'SR') 

              BEGIN 

                  IF NOT EXISTS (SELECT 1 

                                 FROM   showroom.eventoconsultora sc 

                                 WHERE  sc.campaniaid = @CampaniaID 

                                        AND sc.codigoconsultora = 

                                            @CodigoConsultora) 

                    BEGIN 

                        SET @EventoId = (SELECT TOP 1 eventoid 

                                         FROM   showroom.evento 

                                         WHERE  campaniaid = @CampaniaID) 

                        SET @FechaGeneral = dbo.Fnobtenerfechahorapais() 



                        INSERT INTO showroom.eventoconsultora 

                                    (eventoid, 

                                     campaniaid, 

                                     codigoconsultora, 

                                     segmento, 

                                     mostrarpopup, 

                                     fechacreacion, 

                                     usuariocreacion, 

                                     fechamodificacion, 

                                     usuariomodificacion, 

                                     mostrarpopupventa, 

                                     esgenerica) 

                        VALUES      ( @EventoId, 

                                      @CampaniaID, 

                                      @CodigoConsultora, 

                                      @Segmento, 

                                      1, 

                                      @FechaGeneral, 

                                      'MICROSERVICIO', 

                                      @FechaGeneral, 

                                      'MICROSERVICIO', 

                                      1, 

                                      1 ) 



                        SET @Retorno = @@IDENTITY 

                    END 

              END 

        END 



		IF (@Retorno =0)

		BEGIN

		 SELECT @Retorno = EventoConsultoraID from  showroom.eventoconsultora Where campaniaid = @CampaniaID AND codigoconsultora = @CodigoConsultora

		END

  END 

  GO



USE BelcorpBolivia

GO



IF EXISTS(SELECT 1 

          FROM   sys.procedures 

          WHERE  NAME = 'usp_InsertEventoConsultora') 

  BEGIN 

      DROP PROCEDURE dbo.usp_inserteventoconsultora 

  END 



go 



CREATE PROCEDURE dbo.Usp_inserteventoconsultora @CampaniaID       INT, 

                                                @CodigoConsultora VARCHAR(20), 

                                                @Retorno          INT out 

AS 

  BEGIN 

      SET nocount ON 

      SET @Retorno = 0 



      DECLARE @EventoId INT 

      DECLARE @FechaGeneral DATETIME 

      DECLARE @IsoPais VARCHAR(5) 

      DECLARE @Segmento VARCHAR(50) 



      SET @IsoPais = (SELECT codigoiso 

                      FROM   pais 

                      WHERE  estadoactivo = 1) 

      SET @Segmento = (SELECT Concat (@IsoPais, '_', @CampaniaID, '_Perfil01')) 



      DECLARE @CodConsultoraForzada VARCHAR(20) = '' 



      SELECT @CodConsultoraForzada = codigo 

      FROM   tablalogicadatos 

      WHERE  tablalogicadatosid = 10002 



      IF EXISTS (SELECT 1 

                 FROM   ods.ofertaspersonalizadas op 

                 WHERE  op.codconsultora IN ( 

                        @CodigoConsultora, @CodConsultoraForzada 

                                            ) 

                        AND op.aniocampanaventa = @CampaniaID 

                        AND op.tipopersonalizacion = 'SR') 

        BEGIN 

            IF NOT EXISTS (SELECT 1 

                           FROM   showroom.eventoconsultora sc 

                           WHERE  sc.campaniaid = @CampaniaID 

                                  AND sc.codigoconsultora = @CodigoConsultora) 

              BEGIN 

                  SET @EventoId = (SELECT TOP 1 eventoid 

                                   FROM   showroom.evento 

                                   WHERE  campaniaid = @CampaniaID) 

                  SET @FechaGeneral = dbo.Fnobtenerfechahorapais() 



                  INSERT INTO showroom.eventoconsultora 

                              (eventoid, 

                               campaniaid, 

                               codigoconsultora, 

                               segmento, 

                               mostrarpopup, 

                               fechacreacion, 

                               usuariocreacion, 

                               fechamodificacion, 

                               usuariomodificacion, 

                               mostrarpopupventa, 

                               esgenerica) 

                  VALUES      ( @EventoId, 

                                @CampaniaID, 

                                @CodigoConsultora, 

                                @Segmento, 

                                1, 

                                @FechaGeneral, 

                                'MICROSERVICIO', 

                                @FechaGeneral, 

                                'MICROSERVICIO', 

                                1, 

                                0 ) 



                  SET @Retorno = @@IDENTITY 

              END 

        END 

      ELSE 

        BEGIN 

            --PRINT 'NO Existe en ofertas personalizadas' 

            --Buscar el valor generico 

            DECLARE @CodConsultoraGenerica VARCHAR(20) = '' 



            SELECT @CodConsultoraGenerica = codigo 

            FROM   tablalogicadatos 

            WHERE  tablalogicadatosid = 10001 



            IF EXISTS (SELECT 1 

                       FROM   ods.ofertaspersonalizadas op 

                       WHERE  op.codconsultora = @CodConsultoraGenerica 

                              AND op.aniocampanaventa = @CampaniaID 

                              AND op.tipopersonalizacion = 'SR') 

              BEGIN 

                  IF NOT EXISTS (SELECT 1 

                                 FROM   showroom.eventoconsultora sc 

                                 WHERE  sc.campaniaid = @CampaniaID 

                                        AND sc.codigoconsultora = 

                                            @CodigoConsultora) 

                    BEGIN 

                        SET @EventoId = (SELECT TOP 1 eventoid 

                                         FROM   showroom.evento 

                                         WHERE  campaniaid = @CampaniaID) 

                        SET @FechaGeneral = dbo.Fnobtenerfechahorapais() 



                        INSERT INTO showroom.eventoconsultora 

                                    (eventoid, 

                                     campaniaid, 

                                     codigoconsultora, 

                                     segmento, 

                                     mostrarpopup, 

                                     fechacreacion, 

                                     usuariocreacion, 

                                     fechamodificacion, 

                                     usuariomodificacion, 

                                     mostrarpopupventa, 

                                     esgenerica) 

                        VALUES      ( @EventoId, 

                                      @CampaniaID, 

                                      @CodigoConsultora, 

                                      @Segmento, 

                                      1, 

                                      @FechaGeneral, 

                                      'MICROSERVICIO', 

                                      @FechaGeneral, 

                                      'MICROSERVICIO', 

                                      1, 

                                      1 ) 



                        SET @Retorno = @@IDENTITY 

                    END 

              END 

        END 



		IF (@Retorno =0)

		BEGIN

		 SELECT @Retorno = EventoConsultoraID from  showroom.eventoconsultora Where campaniaid = @CampaniaID AND codigoconsultora = @CodigoConsultora

		END

  END 

  GO



