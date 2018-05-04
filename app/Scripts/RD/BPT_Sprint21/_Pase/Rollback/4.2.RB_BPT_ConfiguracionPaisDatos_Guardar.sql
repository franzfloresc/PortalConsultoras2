USE BelcorpPeru
GO

GO

ALTER PROCEDURE dbo.ConfiguracionPaisDatos_Guardar
	@ConfiguracionPaisID int
	,@CampaniaID int
	,@Componente varchar(100)
	,@Codigo varchar(100)
	,@Valor1 varchar(800)
	,@Valor2 varchar(800)
	,@Valor3 varchar(800)
	,@Estado bit = 1
	,@respuesta int output
AS
-- ListConfiguracionPaisComponenteDatos 0, 0, null, null
BEGIN

	SET @CampaniaID = ISNULL(@CampaniaID, 0)
	SET @ConfiguracionPaisID = ISNULL(@ConfiguracionPaisID, 0)
	SET @Componente = LTRIM(RTRIM(ISNULL(@Componente, '')))
	SET @Codigo = LTRIM(RTRIM(ISNULL(@Codigo, '')))
	SET @Valor1 = LTRIM(RTRIM(ISNULL(@Valor1, '')))
	SET @Valor2 = LTRIM(RTRIM(ISNULL(@Valor2, '')))
	SET @Valor3 = LTRIM(RTRIM(ISNULL(@Valor3, '')))
	set @Estado = ISNULL(@Estado, 1)

	SET @respuesta = 0
	if @ConfiguracionPaisID > 0 and @CampaniaID >= 0 and @Componente <> '' and @Codigo <> ''
	begin
			MERGE ConfiguracionPaisDatos AS target  
			USING (
					VALUES (@ConfiguracionPaisID, @CampaniaID, @Componente, @Codigo,
							@Valor1, @Valor2, @Valor3, @Estado)
			) AS source (ConfiguracionPaisID, CampaniaID, Componente, Codigo, Valor1, Valor2, Valor3, Estado)
			ON (
				target.ConfiguracionPaisID = source.ConfiguracionPaisID 
				and target.CampaniaID = source.CampaniaID
				and target.Componente = source.Componente
				and target.Codigo = source.Codigo
			)
			WHEN MATCHED THEN 
				UPDATE 
				SET target.Valor1 = source.Valor1,
					target.Valor2 = source.Valor2,
					target.Valor3 = source.Valor3,
					target.Estado = isnull(source.Estado, 1)
			WHEN NOT MATCHED BY TARGET THEN
				INSERT (ConfiguracionPaisID, CampaniaID, Componente, Codigo,
							Valor1, Valor2, Valor3, Estado) 
				VALUES (source.ConfiguracionPaisID, source.CampaniaID, source.Componente, source.Codigo,
							source.Valor1, source.Valor2, source.Valor3, source.Estado)
			;
			 SET @respuesta = @@ROWCOUNT 
	end

END

GO

USE BelcorpMexico
GO

GO

ALTER PROCEDURE dbo.ConfiguracionPaisDatos_Guardar
	@ConfiguracionPaisID int
	,@CampaniaID int
	,@Componente varchar(100)
	,@Codigo varchar(100)
	,@Valor1 varchar(800)
	,@Valor2 varchar(800)
	,@Valor3 varchar(800)
	,@Estado bit = 1
	,@respuesta int output
AS
-- ListConfiguracionPaisComponenteDatos 0, 0, null, null
BEGIN

	SET @CampaniaID = ISNULL(@CampaniaID, 0)
	SET @ConfiguracionPaisID = ISNULL(@ConfiguracionPaisID, 0)
	SET @Componente = LTRIM(RTRIM(ISNULL(@Componente, '')))
	SET @Codigo = LTRIM(RTRIM(ISNULL(@Codigo, '')))
	SET @Valor1 = LTRIM(RTRIM(ISNULL(@Valor1, '')))
	SET @Valor2 = LTRIM(RTRIM(ISNULL(@Valor2, '')))
	SET @Valor3 = LTRIM(RTRIM(ISNULL(@Valor3, '')))
	set @Estado = ISNULL(@Estado, 1)

	SET @respuesta = 0
	if @ConfiguracionPaisID > 0 and @CampaniaID >= 0 and @Componente <> '' and @Codigo <> ''
	begin
			MERGE ConfiguracionPaisDatos AS target  
			USING (
					VALUES (@ConfiguracionPaisID, @CampaniaID, @Componente, @Codigo,
							@Valor1, @Valor2, @Valor3, @Estado)
			) AS source (ConfiguracionPaisID, CampaniaID, Componente, Codigo, Valor1, Valor2, Valor3, Estado)
			ON (
				target.ConfiguracionPaisID = source.ConfiguracionPaisID 
				and target.CampaniaID = source.CampaniaID
				and target.Componente = source.Componente
				and target.Codigo = source.Codigo
			)
			WHEN MATCHED THEN 
				UPDATE 
				SET target.Valor1 = source.Valor1,
					target.Valor2 = source.Valor2,
					target.Valor3 = source.Valor3,
					target.Estado = isnull(source.Estado, 1)
			WHEN NOT MATCHED BY TARGET THEN
				INSERT (ConfiguracionPaisID, CampaniaID, Componente, Codigo,
							Valor1, Valor2, Valor3, Estado) 
				VALUES (source.ConfiguracionPaisID, source.CampaniaID, source.Componente, source.Codigo,
							source.Valor1, source.Valor2, source.Valor3, source.Estado)
			;
			 SET @respuesta = @@ROWCOUNT 
	end

END

GO

USE BelcorpColombia
GO

GO

ALTER PROCEDURE dbo.ConfiguracionPaisDatos_Guardar
	@ConfiguracionPaisID int
	,@CampaniaID int
	,@Componente varchar(100)
	,@Codigo varchar(100)
	,@Valor1 varchar(800)
	,@Valor2 varchar(800)
	,@Valor3 varchar(800)
	,@Estado bit = 1
	,@respuesta int output
AS
-- ListConfiguracionPaisComponenteDatos 0, 0, null, null
BEGIN

	SET @CampaniaID = ISNULL(@CampaniaID, 0)
	SET @ConfiguracionPaisID = ISNULL(@ConfiguracionPaisID, 0)
	SET @Componente = LTRIM(RTRIM(ISNULL(@Componente, '')))
	SET @Codigo = LTRIM(RTRIM(ISNULL(@Codigo, '')))
	SET @Valor1 = LTRIM(RTRIM(ISNULL(@Valor1, '')))
	SET @Valor2 = LTRIM(RTRIM(ISNULL(@Valor2, '')))
	SET @Valor3 = LTRIM(RTRIM(ISNULL(@Valor3, '')))
	set @Estado = ISNULL(@Estado, 1)

	SET @respuesta = 0
	if @ConfiguracionPaisID > 0 and @CampaniaID >= 0 and @Componente <> '' and @Codigo <> ''
	begin
			MERGE ConfiguracionPaisDatos AS target  
			USING (
					VALUES (@ConfiguracionPaisID, @CampaniaID, @Componente, @Codigo,
							@Valor1, @Valor2, @Valor3, @Estado)
			) AS source (ConfiguracionPaisID, CampaniaID, Componente, Codigo, Valor1, Valor2, Valor3, Estado)
			ON (
				target.ConfiguracionPaisID = source.ConfiguracionPaisID 
				and target.CampaniaID = source.CampaniaID
				and target.Componente = source.Componente
				and target.Codigo = source.Codigo
			)
			WHEN MATCHED THEN 
				UPDATE 
				SET target.Valor1 = source.Valor1,
					target.Valor2 = source.Valor2,
					target.Valor3 = source.Valor3,
					target.Estado = isnull(source.Estado, 1)
			WHEN NOT MATCHED BY TARGET THEN
				INSERT (ConfiguracionPaisID, CampaniaID, Componente, Codigo,
							Valor1, Valor2, Valor3, Estado) 
				VALUES (source.ConfiguracionPaisID, source.CampaniaID, source.Componente, source.Codigo,
							source.Valor1, source.Valor2, source.Valor3, source.Estado)
			;
			 SET @respuesta = @@ROWCOUNT 
	end

END

GO

USE BelcorpSalvador
GO

GO

ALTER PROCEDURE dbo.ConfiguracionPaisDatos_Guardar
	@ConfiguracionPaisID int
	,@CampaniaID int
	,@Componente varchar(100)
	,@Codigo varchar(100)
	,@Valor1 varchar(800)
	,@Valor2 varchar(800)
	,@Valor3 varchar(800)
	,@Estado bit = 1
	,@respuesta int output
AS
-- ListConfiguracionPaisComponenteDatos 0, 0, null, null
BEGIN

	SET @CampaniaID = ISNULL(@CampaniaID, 0)
	SET @ConfiguracionPaisID = ISNULL(@ConfiguracionPaisID, 0)
	SET @Componente = LTRIM(RTRIM(ISNULL(@Componente, '')))
	SET @Codigo = LTRIM(RTRIM(ISNULL(@Codigo, '')))
	SET @Valor1 = LTRIM(RTRIM(ISNULL(@Valor1, '')))
	SET @Valor2 = LTRIM(RTRIM(ISNULL(@Valor2, '')))
	SET @Valor3 = LTRIM(RTRIM(ISNULL(@Valor3, '')))
	set @Estado = ISNULL(@Estado, 1)

	SET @respuesta = 0
	if @ConfiguracionPaisID > 0 and @CampaniaID >= 0 and @Componente <> '' and @Codigo <> ''
	begin
			MERGE ConfiguracionPaisDatos AS target  
			USING (
					VALUES (@ConfiguracionPaisID, @CampaniaID, @Componente, @Codigo,
							@Valor1, @Valor2, @Valor3, @Estado)
			) AS source (ConfiguracionPaisID, CampaniaID, Componente, Codigo, Valor1, Valor2, Valor3, Estado)
			ON (
				target.ConfiguracionPaisID = source.ConfiguracionPaisID 
				and target.CampaniaID = source.CampaniaID
				and target.Componente = source.Componente
				and target.Codigo = source.Codigo
			)
			WHEN MATCHED THEN 
				UPDATE 
				SET target.Valor1 = source.Valor1,
					target.Valor2 = source.Valor2,
					target.Valor3 = source.Valor3,
					target.Estado = isnull(source.Estado, 1)
			WHEN NOT MATCHED BY TARGET THEN
				INSERT (ConfiguracionPaisID, CampaniaID, Componente, Codigo,
							Valor1, Valor2, Valor3, Estado) 
				VALUES (source.ConfiguracionPaisID, source.CampaniaID, source.Componente, source.Codigo,
							source.Valor1, source.Valor2, source.Valor3, source.Estado)
			;
			 SET @respuesta = @@ROWCOUNT 
	end

END

GO

USE BelcorpPuertoRico
GO

GO

ALTER PROCEDURE dbo.ConfiguracionPaisDatos_Guardar
	@ConfiguracionPaisID int
	,@CampaniaID int
	,@Componente varchar(100)
	,@Codigo varchar(100)
	,@Valor1 varchar(800)
	,@Valor2 varchar(800)
	,@Valor3 varchar(800)
	,@Estado bit = 1
	,@respuesta int output
AS
-- ListConfiguracionPaisComponenteDatos 0, 0, null, null
BEGIN

	SET @CampaniaID = ISNULL(@CampaniaID, 0)
	SET @ConfiguracionPaisID = ISNULL(@ConfiguracionPaisID, 0)
	SET @Componente = LTRIM(RTRIM(ISNULL(@Componente, '')))
	SET @Codigo = LTRIM(RTRIM(ISNULL(@Codigo, '')))
	SET @Valor1 = LTRIM(RTRIM(ISNULL(@Valor1, '')))
	SET @Valor2 = LTRIM(RTRIM(ISNULL(@Valor2, '')))
	SET @Valor3 = LTRIM(RTRIM(ISNULL(@Valor3, '')))
	set @Estado = ISNULL(@Estado, 1)

	SET @respuesta = 0
	if @ConfiguracionPaisID > 0 and @CampaniaID >= 0 and @Componente <> '' and @Codigo <> ''
	begin
			MERGE ConfiguracionPaisDatos AS target  
			USING (
					VALUES (@ConfiguracionPaisID, @CampaniaID, @Componente, @Codigo,
							@Valor1, @Valor2, @Valor3, @Estado)
			) AS source (ConfiguracionPaisID, CampaniaID, Componente, Codigo, Valor1, Valor2, Valor3, Estado)
			ON (
				target.ConfiguracionPaisID = source.ConfiguracionPaisID 
				and target.CampaniaID = source.CampaniaID
				and target.Componente = source.Componente
				and target.Codigo = source.Codigo
			)
			WHEN MATCHED THEN 
				UPDATE 
				SET target.Valor1 = source.Valor1,
					target.Valor2 = source.Valor2,
					target.Valor3 = source.Valor3,
					target.Estado = isnull(source.Estado, 1)
			WHEN NOT MATCHED BY TARGET THEN
				INSERT (ConfiguracionPaisID, CampaniaID, Componente, Codigo,
							Valor1, Valor2, Valor3, Estado) 
				VALUES (source.ConfiguracionPaisID, source.CampaniaID, source.Componente, source.Codigo,
							source.Valor1, source.Valor2, source.Valor3, source.Estado)
			;
			 SET @respuesta = @@ROWCOUNT 
	end

END

GO

USE BelcorpPanama
GO

GO

ALTER PROCEDURE dbo.ConfiguracionPaisDatos_Guardar
	@ConfiguracionPaisID int
	,@CampaniaID int
	,@Componente varchar(100)
	,@Codigo varchar(100)
	,@Valor1 varchar(800)
	,@Valor2 varchar(800)
	,@Valor3 varchar(800)
	,@Estado bit = 1
	,@respuesta int output
AS
-- ListConfiguracionPaisComponenteDatos 0, 0, null, null
BEGIN

	SET @CampaniaID = ISNULL(@CampaniaID, 0)
	SET @ConfiguracionPaisID = ISNULL(@ConfiguracionPaisID, 0)
	SET @Componente = LTRIM(RTRIM(ISNULL(@Componente, '')))
	SET @Codigo = LTRIM(RTRIM(ISNULL(@Codigo, '')))
	SET @Valor1 = LTRIM(RTRIM(ISNULL(@Valor1, '')))
	SET @Valor2 = LTRIM(RTRIM(ISNULL(@Valor2, '')))
	SET @Valor3 = LTRIM(RTRIM(ISNULL(@Valor3, '')))
	set @Estado = ISNULL(@Estado, 1)

	SET @respuesta = 0
	if @ConfiguracionPaisID > 0 and @CampaniaID >= 0 and @Componente <> '' and @Codigo <> ''
	begin
			MERGE ConfiguracionPaisDatos AS target  
			USING (
					VALUES (@ConfiguracionPaisID, @CampaniaID, @Componente, @Codigo,
							@Valor1, @Valor2, @Valor3, @Estado)
			) AS source (ConfiguracionPaisID, CampaniaID, Componente, Codigo, Valor1, Valor2, Valor3, Estado)
			ON (
				target.ConfiguracionPaisID = source.ConfiguracionPaisID 
				and target.CampaniaID = source.CampaniaID
				and target.Componente = source.Componente
				and target.Codigo = source.Codigo
			)
			WHEN MATCHED THEN 
				UPDATE 
				SET target.Valor1 = source.Valor1,
					target.Valor2 = source.Valor2,
					target.Valor3 = source.Valor3,
					target.Estado = isnull(source.Estado, 1)
			WHEN NOT MATCHED BY TARGET THEN
				INSERT (ConfiguracionPaisID, CampaniaID, Componente, Codigo,
							Valor1, Valor2, Valor3, Estado) 
				VALUES (source.ConfiguracionPaisID, source.CampaniaID, source.Componente, source.Codigo,
							source.Valor1, source.Valor2, source.Valor3, source.Estado)
			;
			 SET @respuesta = @@ROWCOUNT 
	end

END

GO

USE BelcorpGuatemala
GO

GO

ALTER PROCEDURE dbo.ConfiguracionPaisDatos_Guardar
	@ConfiguracionPaisID int
	,@CampaniaID int
	,@Componente varchar(100)
	,@Codigo varchar(100)
	,@Valor1 varchar(800)
	,@Valor2 varchar(800)
	,@Valor3 varchar(800)
	,@Estado bit = 1
	,@respuesta int output
AS
-- ListConfiguracionPaisComponenteDatos 0, 0, null, null
BEGIN

	SET @CampaniaID = ISNULL(@CampaniaID, 0)
	SET @ConfiguracionPaisID = ISNULL(@ConfiguracionPaisID, 0)
	SET @Componente = LTRIM(RTRIM(ISNULL(@Componente, '')))
	SET @Codigo = LTRIM(RTRIM(ISNULL(@Codigo, '')))
	SET @Valor1 = LTRIM(RTRIM(ISNULL(@Valor1, '')))
	SET @Valor2 = LTRIM(RTRIM(ISNULL(@Valor2, '')))
	SET @Valor3 = LTRIM(RTRIM(ISNULL(@Valor3, '')))
	set @Estado = ISNULL(@Estado, 1)

	SET @respuesta = 0
	if @ConfiguracionPaisID > 0 and @CampaniaID >= 0 and @Componente <> '' and @Codigo <> ''
	begin
			MERGE ConfiguracionPaisDatos AS target  
			USING (
					VALUES (@ConfiguracionPaisID, @CampaniaID, @Componente, @Codigo,
							@Valor1, @Valor2, @Valor3, @Estado)
			) AS source (ConfiguracionPaisID, CampaniaID, Componente, Codigo, Valor1, Valor2, Valor3, Estado)
			ON (
				target.ConfiguracionPaisID = source.ConfiguracionPaisID 
				and target.CampaniaID = source.CampaniaID
				and target.Componente = source.Componente
				and target.Codigo = source.Codigo
			)
			WHEN MATCHED THEN 
				UPDATE 
				SET target.Valor1 = source.Valor1,
					target.Valor2 = source.Valor2,
					target.Valor3 = source.Valor3,
					target.Estado = isnull(source.Estado, 1)
			WHEN NOT MATCHED BY TARGET THEN
				INSERT (ConfiguracionPaisID, CampaniaID, Componente, Codigo,
							Valor1, Valor2, Valor3, Estado) 
				VALUES (source.ConfiguracionPaisID, source.CampaniaID, source.Componente, source.Codigo,
							source.Valor1, source.Valor2, source.Valor3, source.Estado)
			;
			 SET @respuesta = @@ROWCOUNT 
	end

END

GO

USE BelcorpEcuador
GO

GO

ALTER PROCEDURE dbo.ConfiguracionPaisDatos_Guardar
	@ConfiguracionPaisID int
	,@CampaniaID int
	,@Componente varchar(100)
	,@Codigo varchar(100)
	,@Valor1 varchar(800)
	,@Valor2 varchar(800)
	,@Valor3 varchar(800)
	,@Estado bit = 1
	,@respuesta int output
AS
-- ListConfiguracionPaisComponenteDatos 0, 0, null, null
BEGIN

	SET @CampaniaID = ISNULL(@CampaniaID, 0)
	SET @ConfiguracionPaisID = ISNULL(@ConfiguracionPaisID, 0)
	SET @Componente = LTRIM(RTRIM(ISNULL(@Componente, '')))
	SET @Codigo = LTRIM(RTRIM(ISNULL(@Codigo, '')))
	SET @Valor1 = LTRIM(RTRIM(ISNULL(@Valor1, '')))
	SET @Valor2 = LTRIM(RTRIM(ISNULL(@Valor2, '')))
	SET @Valor3 = LTRIM(RTRIM(ISNULL(@Valor3, '')))
	set @Estado = ISNULL(@Estado, 1)

	SET @respuesta = 0
	if @ConfiguracionPaisID > 0 and @CampaniaID >= 0 and @Componente <> '' and @Codigo <> ''
	begin
			MERGE ConfiguracionPaisDatos AS target  
			USING (
					VALUES (@ConfiguracionPaisID, @CampaniaID, @Componente, @Codigo,
							@Valor1, @Valor2, @Valor3, @Estado)
			) AS source (ConfiguracionPaisID, CampaniaID, Componente, Codigo, Valor1, Valor2, Valor3, Estado)
			ON (
				target.ConfiguracionPaisID = source.ConfiguracionPaisID 
				and target.CampaniaID = source.CampaniaID
				and target.Componente = source.Componente
				and target.Codigo = source.Codigo
			)
			WHEN MATCHED THEN 
				UPDATE 
				SET target.Valor1 = source.Valor1,
					target.Valor2 = source.Valor2,
					target.Valor3 = source.Valor3,
					target.Estado = isnull(source.Estado, 1)
			WHEN NOT MATCHED BY TARGET THEN
				INSERT (ConfiguracionPaisID, CampaniaID, Componente, Codigo,
							Valor1, Valor2, Valor3, Estado) 
				VALUES (source.ConfiguracionPaisID, source.CampaniaID, source.Componente, source.Codigo,
							source.Valor1, source.Valor2, source.Valor3, source.Estado)
			;
			 SET @respuesta = @@ROWCOUNT 
	end

END

GO

USE BelcorpDominicana
GO

GO

ALTER PROCEDURE dbo.ConfiguracionPaisDatos_Guardar
	@ConfiguracionPaisID int
	,@CampaniaID int
	,@Componente varchar(100)
	,@Codigo varchar(100)
	,@Valor1 varchar(800)
	,@Valor2 varchar(800)
	,@Valor3 varchar(800)
	,@Estado bit = 1
	,@respuesta int output
AS
-- ListConfiguracionPaisComponenteDatos 0, 0, null, null
BEGIN

	SET @CampaniaID = ISNULL(@CampaniaID, 0)
	SET @ConfiguracionPaisID = ISNULL(@ConfiguracionPaisID, 0)
	SET @Componente = LTRIM(RTRIM(ISNULL(@Componente, '')))
	SET @Codigo = LTRIM(RTRIM(ISNULL(@Codigo, '')))
	SET @Valor1 = LTRIM(RTRIM(ISNULL(@Valor1, '')))
	SET @Valor2 = LTRIM(RTRIM(ISNULL(@Valor2, '')))
	SET @Valor3 = LTRIM(RTRIM(ISNULL(@Valor3, '')))
	set @Estado = ISNULL(@Estado, 1)

	SET @respuesta = 0
	if @ConfiguracionPaisID > 0 and @CampaniaID >= 0 and @Componente <> '' and @Codigo <> ''
	begin
			MERGE ConfiguracionPaisDatos AS target  
			USING (
					VALUES (@ConfiguracionPaisID, @CampaniaID, @Componente, @Codigo,
							@Valor1, @Valor2, @Valor3, @Estado)
			) AS source (ConfiguracionPaisID, CampaniaID, Componente, Codigo, Valor1, Valor2, Valor3, Estado)
			ON (
				target.ConfiguracionPaisID = source.ConfiguracionPaisID 
				and target.CampaniaID = source.CampaniaID
				and target.Componente = source.Componente
				and target.Codigo = source.Codigo
			)
			WHEN MATCHED THEN 
				UPDATE 
				SET target.Valor1 = source.Valor1,
					target.Valor2 = source.Valor2,
					target.Valor3 = source.Valor3,
					target.Estado = isnull(source.Estado, 1)
			WHEN NOT MATCHED BY TARGET THEN
				INSERT (ConfiguracionPaisID, CampaniaID, Componente, Codigo,
							Valor1, Valor2, Valor3, Estado) 
				VALUES (source.ConfiguracionPaisID, source.CampaniaID, source.Componente, source.Codigo,
							source.Valor1, source.Valor2, source.Valor3, source.Estado)
			;
			 SET @respuesta = @@ROWCOUNT 
	end

END

GO

USE BelcorpCostaRica
GO

GO

ALTER PROCEDURE dbo.ConfiguracionPaisDatos_Guardar
	@ConfiguracionPaisID int
	,@CampaniaID int
	,@Componente varchar(100)
	,@Codigo varchar(100)
	,@Valor1 varchar(800)
	,@Valor2 varchar(800)
	,@Valor3 varchar(800)
	,@Estado bit = 1
	,@respuesta int output
AS
-- ListConfiguracionPaisComponenteDatos 0, 0, null, null
BEGIN

	SET @CampaniaID = ISNULL(@CampaniaID, 0)
	SET @ConfiguracionPaisID = ISNULL(@ConfiguracionPaisID, 0)
	SET @Componente = LTRIM(RTRIM(ISNULL(@Componente, '')))
	SET @Codigo = LTRIM(RTRIM(ISNULL(@Codigo, '')))
	SET @Valor1 = LTRIM(RTRIM(ISNULL(@Valor1, '')))
	SET @Valor2 = LTRIM(RTRIM(ISNULL(@Valor2, '')))
	SET @Valor3 = LTRIM(RTRIM(ISNULL(@Valor3, '')))
	set @Estado = ISNULL(@Estado, 1)

	SET @respuesta = 0
	if @ConfiguracionPaisID > 0 and @CampaniaID >= 0 and @Componente <> '' and @Codigo <> ''
	begin
			MERGE ConfiguracionPaisDatos AS target  
			USING (
					VALUES (@ConfiguracionPaisID, @CampaniaID, @Componente, @Codigo,
							@Valor1, @Valor2, @Valor3, @Estado)
			) AS source (ConfiguracionPaisID, CampaniaID, Componente, Codigo, Valor1, Valor2, Valor3, Estado)
			ON (
				target.ConfiguracionPaisID = source.ConfiguracionPaisID 
				and target.CampaniaID = source.CampaniaID
				and target.Componente = source.Componente
				and target.Codigo = source.Codigo
			)
			WHEN MATCHED THEN 
				UPDATE 
				SET target.Valor1 = source.Valor1,
					target.Valor2 = source.Valor2,
					target.Valor3 = source.Valor3,
					target.Estado = isnull(source.Estado, 1)
			WHEN NOT MATCHED BY TARGET THEN
				INSERT (ConfiguracionPaisID, CampaniaID, Componente, Codigo,
							Valor1, Valor2, Valor3, Estado) 
				VALUES (source.ConfiguracionPaisID, source.CampaniaID, source.Componente, source.Codigo,
							source.Valor1, source.Valor2, source.Valor3, source.Estado)
			;
			 SET @respuesta = @@ROWCOUNT 
	end

END

GO

USE BelcorpChile
GO

GO

ALTER PROCEDURE dbo.ConfiguracionPaisDatos_Guardar
	@ConfiguracionPaisID int
	,@CampaniaID int
	,@Componente varchar(100)
	,@Codigo varchar(100)
	,@Valor1 varchar(800)
	,@Valor2 varchar(800)
	,@Valor3 varchar(800)
	,@Estado bit = 1
	,@respuesta int output
AS
-- ListConfiguracionPaisComponenteDatos 0, 0, null, null
BEGIN

	SET @CampaniaID = ISNULL(@CampaniaID, 0)
	SET @ConfiguracionPaisID = ISNULL(@ConfiguracionPaisID, 0)
	SET @Componente = LTRIM(RTRIM(ISNULL(@Componente, '')))
	SET @Codigo = LTRIM(RTRIM(ISNULL(@Codigo, '')))
	SET @Valor1 = LTRIM(RTRIM(ISNULL(@Valor1, '')))
	SET @Valor2 = LTRIM(RTRIM(ISNULL(@Valor2, '')))
	SET @Valor3 = LTRIM(RTRIM(ISNULL(@Valor3, '')))
	set @Estado = ISNULL(@Estado, 1)

	SET @respuesta = 0
	if @ConfiguracionPaisID > 0 and @CampaniaID >= 0 and @Componente <> '' and @Codigo <> ''
	begin
			MERGE ConfiguracionPaisDatos AS target  
			USING (
					VALUES (@ConfiguracionPaisID, @CampaniaID, @Componente, @Codigo,
							@Valor1, @Valor2, @Valor3, @Estado)
			) AS source (ConfiguracionPaisID, CampaniaID, Componente, Codigo, Valor1, Valor2, Valor3, Estado)
			ON (
				target.ConfiguracionPaisID = source.ConfiguracionPaisID 
				and target.CampaniaID = source.CampaniaID
				and target.Componente = source.Componente
				and target.Codigo = source.Codigo
			)
			WHEN MATCHED THEN 
				UPDATE 
				SET target.Valor1 = source.Valor1,
					target.Valor2 = source.Valor2,
					target.Valor3 = source.Valor3,
					target.Estado = isnull(source.Estado, 1)
			WHEN NOT MATCHED BY TARGET THEN
				INSERT (ConfiguracionPaisID, CampaniaID, Componente, Codigo,
							Valor1, Valor2, Valor3, Estado) 
				VALUES (source.ConfiguracionPaisID, source.CampaniaID, source.Componente, source.Codigo,
							source.Valor1, source.Valor2, source.Valor3, source.Estado)
			;
			 SET @respuesta = @@ROWCOUNT 
	end

END

GO

USE BelcorpBolivia
GO

GO

ALTER PROCEDURE dbo.ConfiguracionPaisDatos_Guardar
	@ConfiguracionPaisID int
	,@CampaniaID int
	,@Componente varchar(100)
	,@Codigo varchar(100)
	,@Valor1 varchar(800)
	,@Valor2 varchar(800)
	,@Valor3 varchar(800)
	,@Estado bit = 1
	,@respuesta int output
AS
-- ListConfiguracionPaisComponenteDatos 0, 0, null, null
BEGIN

	SET @CampaniaID = ISNULL(@CampaniaID, 0)
	SET @ConfiguracionPaisID = ISNULL(@ConfiguracionPaisID, 0)
	SET @Componente = LTRIM(RTRIM(ISNULL(@Componente, '')))
	SET @Codigo = LTRIM(RTRIM(ISNULL(@Codigo, '')))
	SET @Valor1 = LTRIM(RTRIM(ISNULL(@Valor1, '')))
	SET @Valor2 = LTRIM(RTRIM(ISNULL(@Valor2, '')))
	SET @Valor3 = LTRIM(RTRIM(ISNULL(@Valor3, '')))
	set @Estado = ISNULL(@Estado, 1)

	SET @respuesta = 0
	if @ConfiguracionPaisID > 0 and @CampaniaID >= 0 and @Componente <> '' and @Codigo <> ''
	begin
			MERGE ConfiguracionPaisDatos AS target  
			USING (
					VALUES (@ConfiguracionPaisID, @CampaniaID, @Componente, @Codigo,
							@Valor1, @Valor2, @Valor3, @Estado)
			) AS source (ConfiguracionPaisID, CampaniaID, Componente, Codigo, Valor1, Valor2, Valor3, Estado)
			ON (
				target.ConfiguracionPaisID = source.ConfiguracionPaisID 
				and target.CampaniaID = source.CampaniaID
				and target.Componente = source.Componente
				and target.Codigo = source.Codigo
			)
			WHEN MATCHED THEN 
				UPDATE 
				SET target.Valor1 = source.Valor1,
					target.Valor2 = source.Valor2,
					target.Valor3 = source.Valor3,
					target.Estado = isnull(source.Estado, 1)
			WHEN NOT MATCHED BY TARGET THEN
				INSERT (ConfiguracionPaisID, CampaniaID, Componente, Codigo,
							Valor1, Valor2, Valor3, Estado) 
				VALUES (source.ConfiguracionPaisID, source.CampaniaID, source.Componente, source.Codigo,
							source.Valor1, source.Valor2, source.Valor3, source.Estado)
			;
			 SET @respuesta = @@ROWCOUNT 
	end

END

GO

