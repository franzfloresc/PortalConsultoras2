 use belcorpBolivia
 go

IF (OBJECT_ID('dbo.ActivarDesactivarEstrategias', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.ActivarDesactivarEstrategias AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE ActivarDesactivarEstrategias



@UsuarioModificacion VARCHAR(100),

@EstrategiasActivas VARCHAR(500),

@EstrategiasDesactivas VARCHAR(500)

AS

BEGIN

	SET NOCOUNT ON	

	

	DECLARE @resultado int = 0

	DECLARE @TipoEstrategia nvarchar(90)

	

	select @TipoEstrategia=TipoEstrategia.DescripcionEstrategia from estrategia inner join TipoEstrategia on estrategia.Tipoestrategiaid =  TipoEstrategia.Tipoestrategiaid

	where  

	   estrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasDesactivas,',') union SELECT splitdata FROM dbo.fnSplitString(@EstrategiasActivas,','))

			

 

 



		SELECT DISTINCT   E.EstrategiaID

		INTO #ESTRATEGIASNOACTIVAS 

		FROM Estrategia E 	



		WHERE	



		E.EstrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasActivas,',')) AND



		((E.LimiteVenta IS NULL OR E.LimiteVenta = 0) OR 



		(E.ImagenURL IS NULL OR E.ImagenURL = ''))







		

	SELECT splitdata 

	INTO #ESTRATEGIASACTIVAR

	FROM dbo.fnSplitString(@EstrategiasActivas,',') EA 

	WHERE EA.splitdata NOT IN (SELECT EstrategiaID FROM #ESTRATEGIASNOACTIVAS)



 

 if(@TipoEstrategia!='ShowRoom')

 begin 

 

		-- Activar

	IF ((SELECT count(splitdata) FROM dbo.fnSplitString(@EstrategiasActivas,',')) > 0)



	BEGIN



		UPDATE Estrategia 



		SET activo = 1, UsuarioModificacion = @UsuarioModificacion, FechaModificacion = GETDATE()  

		WHERE estrategiaID IN (SELECT splitdata FROM #ESTRATEGIASACTIVAR)



	END 



	SELECT @resultado = COUNT (*) FROM #ESTRATEGIASNOACTIVAS



 end

 else

 begin



 -- Activar

 	IF ((SELECT count(splitdata) FROM dbo.fnSplitString(@EstrategiasActivas,',')) > 0)



	BEGIN



		UPDATE Estrategia 

		SET activo = 1, UsuarioModificacion = @UsuarioModificacion, FechaModificacion = GETDATE()  

		WHERE estrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasActivas,','))



	END

	 

 	set @resultado =0

 end 



 

	-- Desactivar



	IF ((SELECT count(splitdata) FROM dbo.fnSplitString(@EstrategiasDesactivas,',')) > 0)



	BEGIN



		UPDATE Estrategia 

		SET activo = 0, UsuarioModificacion = @UsuarioModificacion, FechaModificacion = GETDATE()  

		WHERE estrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasDesactivas,','))



	END



	select @resultado



	SET NOCOUNT OFF



END
go
use belcorpChile
 go

IF (OBJECT_ID('dbo.ActivarDesactivarEstrategias', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.ActivarDesactivarEstrategias AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE ActivarDesactivarEstrategias



@UsuarioModificacion VARCHAR(100),

@EstrategiasActivas VARCHAR(500),

@EstrategiasDesactivas VARCHAR(500)

AS

BEGIN

	SET NOCOUNT ON	

	

	DECLARE @resultado int = 0

	DECLARE @TipoEstrategia nvarchar(90)

	

	select @TipoEstrategia=TipoEstrategia.DescripcionEstrategia from estrategia inner join TipoEstrategia on estrategia.Tipoestrategiaid =  TipoEstrategia.Tipoestrategiaid

	where  

	   estrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasDesactivas,',') union SELECT splitdata FROM dbo.fnSplitString(@EstrategiasActivas,','))

			

 

 



		SELECT DISTINCT   E.EstrategiaID

		INTO #ESTRATEGIASNOACTIVAS 

		FROM Estrategia E 	



		WHERE	



		E.EstrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasActivas,',')) AND



		((E.LimiteVenta IS NULL OR E.LimiteVenta = 0) OR 



		(E.ImagenURL IS NULL OR E.ImagenURL = ''))







		

	SELECT splitdata 

	INTO #ESTRATEGIASACTIVAR

	FROM dbo.fnSplitString(@EstrategiasActivas,',') EA 

	WHERE EA.splitdata NOT IN (SELECT EstrategiaID FROM #ESTRATEGIASNOACTIVAS)



 

 if(@TipoEstrategia!='ShowRoom')

 begin 

 

		-- Activar

	IF ((SELECT count(splitdata) FROM dbo.fnSplitString(@EstrategiasActivas,',')) > 0)



	BEGIN



		UPDATE Estrategia 



		SET activo = 1, UsuarioModificacion = @UsuarioModificacion, FechaModificacion = GETDATE()  

		WHERE estrategiaID IN (SELECT splitdata FROM #ESTRATEGIASACTIVAR)



	END 



	SELECT @resultado = COUNT (*) FROM #ESTRATEGIASNOACTIVAS



 end

 else

 begin



 -- Activar

 	IF ((SELECT count(splitdata) FROM dbo.fnSplitString(@EstrategiasActivas,',')) > 0)



	BEGIN



		UPDATE Estrategia 

		SET activo = 1, UsuarioModificacion = @UsuarioModificacion, FechaModificacion = GETDATE()  

		WHERE estrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasActivas,','))



	END

	 

 	set @resultado =0

 end 



 

	-- Desactivar



	IF ((SELECT count(splitdata) FROM dbo.fnSplitString(@EstrategiasDesactivas,',')) > 0)



	BEGIN



		UPDATE Estrategia 

		SET activo = 0, UsuarioModificacion = @UsuarioModificacion, FechaModificacion = GETDATE()  

		WHERE estrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasDesactivas,','))



	END



	select @resultado



	SET NOCOUNT OFF



END
go
use belcorpColombia
 go

IF (OBJECT_ID('dbo.ActivarDesactivarEstrategias', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.ActivarDesactivarEstrategias AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE ActivarDesactivarEstrategias



@UsuarioModificacion VARCHAR(100),

@EstrategiasActivas VARCHAR(500),

@EstrategiasDesactivas VARCHAR(500)

AS

BEGIN

	SET NOCOUNT ON	

	

	DECLARE @resultado int = 0

	DECLARE @TipoEstrategia nvarchar(90)

	

	select @TipoEstrategia=TipoEstrategia.DescripcionEstrategia from estrategia inner join TipoEstrategia on estrategia.Tipoestrategiaid =  TipoEstrategia.Tipoestrategiaid

	where  

	   estrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasDesactivas,',') union SELECT splitdata FROM dbo.fnSplitString(@EstrategiasActivas,','))

			

 

 



		SELECT DISTINCT   E.EstrategiaID

		INTO #ESTRATEGIASNOACTIVAS 

		FROM Estrategia E 	



		WHERE	



		E.EstrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasActivas,',')) AND



		((E.LimiteVenta IS NULL OR E.LimiteVenta = 0) OR 



		(E.ImagenURL IS NULL OR E.ImagenURL = ''))







		

	SELECT splitdata 

	INTO #ESTRATEGIASACTIVAR

	FROM dbo.fnSplitString(@EstrategiasActivas,',') EA 

	WHERE EA.splitdata NOT IN (SELECT EstrategiaID FROM #ESTRATEGIASNOACTIVAS)



 

 if(@TipoEstrategia!='ShowRoom')

 begin 

 

		-- Activar

	IF ((SELECT count(splitdata) FROM dbo.fnSplitString(@EstrategiasActivas,',')) > 0)



	BEGIN



		UPDATE Estrategia 



		SET activo = 1, UsuarioModificacion = @UsuarioModificacion, FechaModificacion = GETDATE()  

		WHERE estrategiaID IN (SELECT splitdata FROM #ESTRATEGIASACTIVAR)



	END 



	SELECT @resultado = COUNT (*) FROM #ESTRATEGIASNOACTIVAS



 end

 else

 begin



 -- Activar

 	IF ((SELECT count(splitdata) FROM dbo.fnSplitString(@EstrategiasActivas,',')) > 0)



	BEGIN



		UPDATE Estrategia 

		SET activo = 1, UsuarioModificacion = @UsuarioModificacion, FechaModificacion = GETDATE()  

		WHERE estrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasActivas,','))



	END

	 

 	set @resultado =0

 end 



 

	-- Desactivar



	IF ((SELECT count(splitdata) FROM dbo.fnSplitString(@EstrategiasDesactivas,',')) > 0)



	BEGIN



		UPDATE Estrategia 

		SET activo = 0, UsuarioModificacion = @UsuarioModificacion, FechaModificacion = GETDATE()  

		WHERE estrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasDesactivas,','))



	END



	select @resultado



	SET NOCOUNT OFF



END
go
use belcorpCostaRica
 go

IF (OBJECT_ID('dbo.ActivarDesactivarEstrategias', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.ActivarDesactivarEstrategias AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE ActivarDesactivarEstrategias



@UsuarioModificacion VARCHAR(100),

@EstrategiasActivas VARCHAR(500),

@EstrategiasDesactivas VARCHAR(500)

AS

BEGIN

	SET NOCOUNT ON	

	

	DECLARE @resultado int = 0

	DECLARE @TipoEstrategia nvarchar(90)

	

	select @TipoEstrategia=TipoEstrategia.DescripcionEstrategia from estrategia inner join TipoEstrategia on estrategia.Tipoestrategiaid =  TipoEstrategia.Tipoestrategiaid

	where  

	   estrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasDesactivas,',') union SELECT splitdata FROM dbo.fnSplitString(@EstrategiasActivas,','))

			

 

 



		SELECT DISTINCT   E.EstrategiaID

		INTO #ESTRATEGIASNOACTIVAS 

		FROM Estrategia E 	



		WHERE	



		E.EstrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasActivas,',')) AND



		((E.LimiteVenta IS NULL OR E.LimiteVenta = 0) OR 



		(E.ImagenURL IS NULL OR E.ImagenURL = ''))







		

	SELECT splitdata 

	INTO #ESTRATEGIASACTIVAR

	FROM dbo.fnSplitString(@EstrategiasActivas,',') EA 

	WHERE EA.splitdata NOT IN (SELECT EstrategiaID FROM #ESTRATEGIASNOACTIVAS)



 

 if(@TipoEstrategia!='ShowRoom')

 begin 

 

		-- Activar

	IF ((SELECT count(splitdata) FROM dbo.fnSplitString(@EstrategiasActivas,',')) > 0)



	BEGIN



		UPDATE Estrategia 



		SET activo = 1, UsuarioModificacion = @UsuarioModificacion, FechaModificacion = GETDATE()  

		WHERE estrategiaID IN (SELECT splitdata FROM #ESTRATEGIASACTIVAR)



	END 



	SELECT @resultado = COUNT (*) FROM #ESTRATEGIASNOACTIVAS



 end

 else

 begin



 -- Activar

 	IF ((SELECT count(splitdata) FROM dbo.fnSplitString(@EstrategiasActivas,',')) > 0)



	BEGIN



		UPDATE Estrategia 

		SET activo = 1, UsuarioModificacion = @UsuarioModificacion, FechaModificacion = GETDATE()  

		WHERE estrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasActivas,','))



	END

	 

 	set @resultado =0

 end 



 

	-- Desactivar



	IF ((SELECT count(splitdata) FROM dbo.fnSplitString(@EstrategiasDesactivas,',')) > 0)



	BEGIN



		UPDATE Estrategia 

		SET activo = 0, UsuarioModificacion = @UsuarioModificacion, FechaModificacion = GETDATE()  

		WHERE estrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasDesactivas,','))



	END



	select @resultado



	SET NOCOUNT OFF



END
go
use belcorpDominicana
 go

IF (OBJECT_ID('dbo.ActivarDesactivarEstrategias', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.ActivarDesactivarEstrategias AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE ActivarDesactivarEstrategias



@UsuarioModificacion VARCHAR(100),

@EstrategiasActivas VARCHAR(500),

@EstrategiasDesactivas VARCHAR(500)

AS

BEGIN

	SET NOCOUNT ON	

	

	DECLARE @resultado int = 0

	DECLARE @TipoEstrategia nvarchar(90)

	

	select @TipoEstrategia=TipoEstrategia.DescripcionEstrategia from estrategia inner join TipoEstrategia on estrategia.Tipoestrategiaid =  TipoEstrategia.Tipoestrategiaid

	where  

	   estrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasDesactivas,',') union SELECT splitdata FROM dbo.fnSplitString(@EstrategiasActivas,','))

			

 

 



		SELECT DISTINCT   E.EstrategiaID

		INTO #ESTRATEGIASNOACTIVAS 

		FROM Estrategia E 	



		WHERE	



		E.EstrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasActivas,',')) AND



		((E.LimiteVenta IS NULL OR E.LimiteVenta = 0) OR 



		(E.ImagenURL IS NULL OR E.ImagenURL = ''))







		

	SELECT splitdata 

	INTO #ESTRATEGIASACTIVAR

	FROM dbo.fnSplitString(@EstrategiasActivas,',') EA 

	WHERE EA.splitdata NOT IN (SELECT EstrategiaID FROM #ESTRATEGIASNOACTIVAS)



 

 if(@TipoEstrategia!='ShowRoom')

 begin 

 

		-- Activar

	IF ((SELECT count(splitdata) FROM dbo.fnSplitString(@EstrategiasActivas,',')) > 0)



	BEGIN



		UPDATE Estrategia 



		SET activo = 1, UsuarioModificacion = @UsuarioModificacion, FechaModificacion = GETDATE()  

		WHERE estrategiaID IN (SELECT splitdata FROM #ESTRATEGIASACTIVAR)



	END 



	SELECT @resultado = COUNT (*) FROM #ESTRATEGIASNOACTIVAS



 end

 else

 begin



 -- Activar

 	IF ((SELECT count(splitdata) FROM dbo.fnSplitString(@EstrategiasActivas,',')) > 0)



	BEGIN



		UPDATE Estrategia 

		SET activo = 1, UsuarioModificacion = @UsuarioModificacion, FechaModificacion = GETDATE()  

		WHERE estrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasActivas,','))



	END

	 

 	set @resultado =0

 end 



 

	-- Desactivar



	IF ((SELECT count(splitdata) FROM dbo.fnSplitString(@EstrategiasDesactivas,',')) > 0)



	BEGIN



		UPDATE Estrategia 

		SET activo = 0, UsuarioModificacion = @UsuarioModificacion, FechaModificacion = GETDATE()  

		WHERE estrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasDesactivas,','))



	END



	select @resultado



	SET NOCOUNT OFF



END
go
use belcorpEcuador
 go

IF (OBJECT_ID('dbo.ActivarDesactivarEstrategias', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.ActivarDesactivarEstrategias AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE ActivarDesactivarEstrategias



@UsuarioModificacion VARCHAR(100),

@EstrategiasActivas VARCHAR(500),

@EstrategiasDesactivas VARCHAR(500)

AS

BEGIN

	SET NOCOUNT ON	

	

	DECLARE @resultado int = 0

	DECLARE @TipoEstrategia nvarchar(90)

	

	select @TipoEstrategia=TipoEstrategia.DescripcionEstrategia from estrategia inner join TipoEstrategia on estrategia.Tipoestrategiaid =  TipoEstrategia.Tipoestrategiaid

	where  

	   estrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasDesactivas,',') union SELECT splitdata FROM dbo.fnSplitString(@EstrategiasActivas,','))

			

 

 



		SELECT DISTINCT   E.EstrategiaID

		INTO #ESTRATEGIASNOACTIVAS 

		FROM Estrategia E 	



		WHERE	



		E.EstrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasActivas,',')) AND



		((E.LimiteVenta IS NULL OR E.LimiteVenta = 0) OR 



		(E.ImagenURL IS NULL OR E.ImagenURL = ''))







		

	SELECT splitdata 

	INTO #ESTRATEGIASACTIVAR

	FROM dbo.fnSplitString(@EstrategiasActivas,',') EA 

	WHERE EA.splitdata NOT IN (SELECT EstrategiaID FROM #ESTRATEGIASNOACTIVAS)



 

 if(@TipoEstrategia!='ShowRoom')

 begin 

 

		-- Activar

	IF ((SELECT count(splitdata) FROM dbo.fnSplitString(@EstrategiasActivas,',')) > 0)



	BEGIN



		UPDATE Estrategia 



		SET activo = 1, UsuarioModificacion = @UsuarioModificacion, FechaModificacion = GETDATE()  

		WHERE estrategiaID IN (SELECT splitdata FROM #ESTRATEGIASACTIVAR)



	END 



	SELECT @resultado = COUNT (*) FROM #ESTRATEGIASNOACTIVAS



 end

 else

 begin



 -- Activar

 	IF ((SELECT count(splitdata) FROM dbo.fnSplitString(@EstrategiasActivas,',')) > 0)



	BEGIN



		UPDATE Estrategia 

		SET activo = 1, UsuarioModificacion = @UsuarioModificacion, FechaModificacion = GETDATE()  

		WHERE estrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasActivas,','))



	END

	 

 	set @resultado =0

 end 



 

	-- Desactivar



	IF ((SELECT count(splitdata) FROM dbo.fnSplitString(@EstrategiasDesactivas,',')) > 0)



	BEGIN



		UPDATE Estrategia 

		SET activo = 0, UsuarioModificacion = @UsuarioModificacion, FechaModificacion = GETDATE()  

		WHERE estrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasDesactivas,','))



	END



	select @resultado



	SET NOCOUNT OFF



END
go
use belcorpGuatemala
 go

IF (OBJECT_ID('dbo.ActivarDesactivarEstrategias', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.ActivarDesactivarEstrategias AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE ActivarDesactivarEstrategias



@UsuarioModificacion VARCHAR(100),

@EstrategiasActivas VARCHAR(500),

@EstrategiasDesactivas VARCHAR(500)

AS

BEGIN

	SET NOCOUNT ON	

	

	DECLARE @resultado int = 0

	DECLARE @TipoEstrategia nvarchar(90)

	

	select @TipoEstrategia=TipoEstrategia.DescripcionEstrategia from estrategia inner join TipoEstrategia on estrategia.Tipoestrategiaid =  TipoEstrategia.Tipoestrategiaid

	where  

	   estrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasDesactivas,',') union SELECT splitdata FROM dbo.fnSplitString(@EstrategiasActivas,','))

			

 

 



		SELECT DISTINCT   E.EstrategiaID

		INTO #ESTRATEGIASNOACTIVAS 

		FROM Estrategia E 	



		WHERE	



		E.EstrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasActivas,',')) AND



		((E.LimiteVenta IS NULL OR E.LimiteVenta = 0) OR 



		(E.ImagenURL IS NULL OR E.ImagenURL = ''))







		

	SELECT splitdata 

	INTO #ESTRATEGIASACTIVAR

	FROM dbo.fnSplitString(@EstrategiasActivas,',') EA 

	WHERE EA.splitdata NOT IN (SELECT EstrategiaID FROM #ESTRATEGIASNOACTIVAS)



 

 if(@TipoEstrategia!='ShowRoom')

 begin 

 

		-- Activar

	IF ((SELECT count(splitdata) FROM dbo.fnSplitString(@EstrategiasActivas,',')) > 0)



	BEGIN



		UPDATE Estrategia 



		SET activo = 1, UsuarioModificacion = @UsuarioModificacion, FechaModificacion = GETDATE()  

		WHERE estrategiaID IN (SELECT splitdata FROM #ESTRATEGIASACTIVAR)



	END 



	SELECT @resultado = COUNT (*) FROM #ESTRATEGIASNOACTIVAS



 end

 else

 begin



 -- Activar

 	IF ((SELECT count(splitdata) FROM dbo.fnSplitString(@EstrategiasActivas,',')) > 0)



	BEGIN



		UPDATE Estrategia 

		SET activo = 1, UsuarioModificacion = @UsuarioModificacion, FechaModificacion = GETDATE()  

		WHERE estrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasActivas,','))



	END

	 

 	set @resultado =0

 end 



 

	-- Desactivar



	IF ((SELECT count(splitdata) FROM dbo.fnSplitString(@EstrategiasDesactivas,',')) > 0)



	BEGIN



		UPDATE Estrategia 

		SET activo = 0, UsuarioModificacion = @UsuarioModificacion, FechaModificacion = GETDATE()  

		WHERE estrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasDesactivas,','))



	END



	select @resultado



	SET NOCOUNT OFF



END
go
use belcorpMexico
 go

IF (OBJECT_ID('dbo.ActivarDesactivarEstrategias', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.ActivarDesactivarEstrategias AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE ActivarDesactivarEstrategias



@UsuarioModificacion VARCHAR(100),

@EstrategiasActivas VARCHAR(500),

@EstrategiasDesactivas VARCHAR(500)

AS

BEGIN

	SET NOCOUNT ON	

	

	DECLARE @resultado int = 0

	DECLARE @TipoEstrategia nvarchar(90)

	

	select @TipoEstrategia=TipoEstrategia.DescripcionEstrategia from estrategia inner join TipoEstrategia on estrategia.Tipoestrategiaid =  TipoEstrategia.Tipoestrategiaid

	where  

	   estrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasDesactivas,',') union SELECT splitdata FROM dbo.fnSplitString(@EstrategiasActivas,','))

			

 

 



		SELECT DISTINCT   E.EstrategiaID

		INTO #ESTRATEGIASNOACTIVAS 

		FROM Estrategia E 	



		WHERE	



		E.EstrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasActivas,',')) AND



		((E.LimiteVenta IS NULL OR E.LimiteVenta = 0) OR 



		(E.ImagenURL IS NULL OR E.ImagenURL = ''))







		

	SELECT splitdata 

	INTO #ESTRATEGIASACTIVAR

	FROM dbo.fnSplitString(@EstrategiasActivas,',') EA 

	WHERE EA.splitdata NOT IN (SELECT EstrategiaID FROM #ESTRATEGIASNOACTIVAS)



 

 if(@TipoEstrategia!='ShowRoom')

 begin 

 

		-- Activar

	IF ((SELECT count(splitdata) FROM dbo.fnSplitString(@EstrategiasActivas,',')) > 0)



	BEGIN



		UPDATE Estrategia 



		SET activo = 1, UsuarioModificacion = @UsuarioModificacion, FechaModificacion = GETDATE()  

		WHERE estrategiaID IN (SELECT splitdata FROM #ESTRATEGIASACTIVAR)



	END 



	SELECT @resultado = COUNT (*) FROM #ESTRATEGIASNOACTIVAS



 end

 else

 begin



 -- Activar

 	IF ((SELECT count(splitdata) FROM dbo.fnSplitString(@EstrategiasActivas,',')) > 0)



	BEGIN



		UPDATE Estrategia 

		SET activo = 1, UsuarioModificacion = @UsuarioModificacion, FechaModificacion = GETDATE()  

		WHERE estrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasActivas,','))



	END

	 

 	set @resultado =0

 end 



 

	-- Desactivar



	IF ((SELECT count(splitdata) FROM dbo.fnSplitString(@EstrategiasDesactivas,',')) > 0)



	BEGIN



		UPDATE Estrategia 

		SET activo = 0, UsuarioModificacion = @UsuarioModificacion, FechaModificacion = GETDATE()  

		WHERE estrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasDesactivas,','))



	END



	select @resultado



	SET NOCOUNT OFF



END
go
use belcorpPanama
 go

IF (OBJECT_ID('dbo.ActivarDesactivarEstrategias', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.ActivarDesactivarEstrategias AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE ActivarDesactivarEstrategias



@UsuarioModificacion VARCHAR(100),

@EstrategiasActivas VARCHAR(500),

@EstrategiasDesactivas VARCHAR(500)

AS

BEGIN

	SET NOCOUNT ON	

	

	DECLARE @resultado int = 0

	DECLARE @TipoEstrategia nvarchar(90)

	

	select @TipoEstrategia=TipoEstrategia.DescripcionEstrategia from estrategia inner join TipoEstrategia on estrategia.Tipoestrategiaid =  TipoEstrategia.Tipoestrategiaid

	where  

	   estrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasDesactivas,',') union SELECT splitdata FROM dbo.fnSplitString(@EstrategiasActivas,','))

			

 

 



		SELECT DISTINCT   E.EstrategiaID

		INTO #ESTRATEGIASNOACTIVAS 

		FROM Estrategia E 	



		WHERE	



		E.EstrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasActivas,',')) AND



		((E.LimiteVenta IS NULL OR E.LimiteVenta = 0) OR 



		(E.ImagenURL IS NULL OR E.ImagenURL = ''))







		

	SELECT splitdata 

	INTO #ESTRATEGIASACTIVAR

	FROM dbo.fnSplitString(@EstrategiasActivas,',') EA 

	WHERE EA.splitdata NOT IN (SELECT EstrategiaID FROM #ESTRATEGIASNOACTIVAS)



 

 if(@TipoEstrategia!='ShowRoom')

 begin 

 

		-- Activar

	IF ((SELECT count(splitdata) FROM dbo.fnSplitString(@EstrategiasActivas,',')) > 0)



	BEGIN



		UPDATE Estrategia 



		SET activo = 1, UsuarioModificacion = @UsuarioModificacion, FechaModificacion = GETDATE()  

		WHERE estrategiaID IN (SELECT splitdata FROM #ESTRATEGIASACTIVAR)



	END 



	SELECT @resultado = COUNT (*) FROM #ESTRATEGIASNOACTIVAS



 end

 else

 begin



 -- Activar

 	IF ((SELECT count(splitdata) FROM dbo.fnSplitString(@EstrategiasActivas,',')) > 0)



	BEGIN



		UPDATE Estrategia 

		SET activo = 1, UsuarioModificacion = @UsuarioModificacion, FechaModificacion = GETDATE()  

		WHERE estrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasActivas,','))



	END

	 

 	set @resultado =0

 end 



 

	-- Desactivar



	IF ((SELECT count(splitdata) FROM dbo.fnSplitString(@EstrategiasDesactivas,',')) > 0)



	BEGIN



		UPDATE Estrategia 

		SET activo = 0, UsuarioModificacion = @UsuarioModificacion, FechaModificacion = GETDATE()  

		WHERE estrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasDesactivas,','))



	END



	select @resultado



	SET NOCOUNT OFF



END
go
use belcorpPeru
 go

IF (OBJECT_ID('dbo.ActivarDesactivarEstrategias', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.ActivarDesactivarEstrategias AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE ActivarDesactivarEstrategias



@UsuarioModificacion VARCHAR(100),

@EstrategiasActivas VARCHAR(500),

@EstrategiasDesactivas VARCHAR(500)

AS

BEGIN

	SET NOCOUNT ON	

	

	DECLARE @resultado int = 0

	DECLARE @TipoEstrategia nvarchar(90)

	

	select @TipoEstrategia=TipoEstrategia.DescripcionEstrategia from estrategia inner join TipoEstrategia on estrategia.Tipoestrategiaid =  TipoEstrategia.Tipoestrategiaid

	where  

	   estrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasDesactivas,',') union SELECT splitdata FROM dbo.fnSplitString(@EstrategiasActivas,','))

			

 

 



		SELECT DISTINCT   E.EstrategiaID

		INTO #ESTRATEGIASNOACTIVAS 

		FROM Estrategia E 	



		WHERE	



		E.EstrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasActivas,',')) AND



		((E.LimiteVenta IS NULL OR E.LimiteVenta = 0) OR 



		(E.ImagenURL IS NULL OR E.ImagenURL = ''))







		

	SELECT splitdata 

	INTO #ESTRATEGIASACTIVAR

	FROM dbo.fnSplitString(@EstrategiasActivas,',') EA 

	WHERE EA.splitdata NOT IN (SELECT EstrategiaID FROM #ESTRATEGIASNOACTIVAS)



 

 if(@TipoEstrategia!='ShowRoom')

 begin 

 

		-- Activar

	IF ((SELECT count(splitdata) FROM dbo.fnSplitString(@EstrategiasActivas,',')) > 0)



	BEGIN



		UPDATE Estrategia 



		SET activo = 1, UsuarioModificacion = @UsuarioModificacion, FechaModificacion = GETDATE()  

		WHERE estrategiaID IN (SELECT splitdata FROM #ESTRATEGIASACTIVAR)



	END 



	SELECT @resultado = COUNT (*) FROM #ESTRATEGIASNOACTIVAS



 end

 else

 begin



 -- Activar

 	IF ((SELECT count(splitdata) FROM dbo.fnSplitString(@EstrategiasActivas,',')) > 0)



	BEGIN



		UPDATE Estrategia 

		SET activo = 1, UsuarioModificacion = @UsuarioModificacion, FechaModificacion = GETDATE()  

		WHERE estrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasActivas,','))



	END

	 

 	set @resultado =0

 end 



 

	-- Desactivar



	IF ((SELECT count(splitdata) FROM dbo.fnSplitString(@EstrategiasDesactivas,',')) > 0)



	BEGIN



		UPDATE Estrategia 

		SET activo = 0, UsuarioModificacion = @UsuarioModificacion, FechaModificacion = GETDATE()  

		WHERE estrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasDesactivas,','))



	END



	select @resultado



	SET NOCOUNT OFF



END
go
use belcorpPuertoRico
 go

IF (OBJECT_ID('dbo.ActivarDesactivarEstrategias', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.ActivarDesactivarEstrategias AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE ActivarDesactivarEstrategias



@UsuarioModificacion VARCHAR(100),

@EstrategiasActivas VARCHAR(500),

@EstrategiasDesactivas VARCHAR(500)

AS

BEGIN

	SET NOCOUNT ON	

	

	DECLARE @resultado int = 0

	DECLARE @TipoEstrategia nvarchar(90)

	

	select @TipoEstrategia=TipoEstrategia.DescripcionEstrategia from estrategia inner join TipoEstrategia on estrategia.Tipoestrategiaid =  TipoEstrategia.Tipoestrategiaid

	where  

	   estrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasDesactivas,',') union SELECT splitdata FROM dbo.fnSplitString(@EstrategiasActivas,','))

			

 

 



		SELECT DISTINCT   E.EstrategiaID

		INTO #ESTRATEGIASNOACTIVAS 

		FROM Estrategia E 	



		WHERE	



		E.EstrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasActivas,',')) AND



		((E.LimiteVenta IS NULL OR E.LimiteVenta = 0) OR 



		(E.ImagenURL IS NULL OR E.ImagenURL = ''))







		

	SELECT splitdata 

	INTO #ESTRATEGIASACTIVAR

	FROM dbo.fnSplitString(@EstrategiasActivas,',') EA 

	WHERE EA.splitdata NOT IN (SELECT EstrategiaID FROM #ESTRATEGIASNOACTIVAS)



 

 if(@TipoEstrategia!='ShowRoom')

 begin 

 

		-- Activar

	IF ((SELECT count(splitdata) FROM dbo.fnSplitString(@EstrategiasActivas,',')) > 0)



	BEGIN



		UPDATE Estrategia 



		SET activo = 1, UsuarioModificacion = @UsuarioModificacion, FechaModificacion = GETDATE()  

		WHERE estrategiaID IN (SELECT splitdata FROM #ESTRATEGIASACTIVAR)



	END 



	SELECT @resultado = COUNT (*) FROM #ESTRATEGIASNOACTIVAS



 end

 else

 begin



 -- Activar

 	IF ((SELECT count(splitdata) FROM dbo.fnSplitString(@EstrategiasActivas,',')) > 0)



	BEGIN



		UPDATE Estrategia 

		SET activo = 1, UsuarioModificacion = @UsuarioModificacion, FechaModificacion = GETDATE()  

		WHERE estrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasActivas,','))



	END

	 

 	set @resultado =0

 end 



 

	-- Desactivar



	IF ((SELECT count(splitdata) FROM dbo.fnSplitString(@EstrategiasDesactivas,',')) > 0)



	BEGIN



		UPDATE Estrategia 

		SET activo = 0, UsuarioModificacion = @UsuarioModificacion, FechaModificacion = GETDATE()  

		WHERE estrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasDesactivas,','))



	END



	select @resultado



	SET NOCOUNT OFF



END
go
use belcorpSalvador
 go

IF (OBJECT_ID('dbo.ActivarDesactivarEstrategias', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.ActivarDesactivarEstrategias AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE ActivarDesactivarEstrategias



@UsuarioModificacion VARCHAR(100),

@EstrategiasActivas VARCHAR(500),

@EstrategiasDesactivas VARCHAR(500)

AS

BEGIN

	SET NOCOUNT ON	

	

	DECLARE @resultado int = 0

	DECLARE @TipoEstrategia nvarchar(90)

	

	select @TipoEstrategia=TipoEstrategia.DescripcionEstrategia from estrategia inner join TipoEstrategia on estrategia.Tipoestrategiaid =  TipoEstrategia.Tipoestrategiaid

	where  

	   estrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasDesactivas,',') union SELECT splitdata FROM dbo.fnSplitString(@EstrategiasActivas,','))

			

 

 



		SELECT DISTINCT   E.EstrategiaID

		INTO #ESTRATEGIASNOACTIVAS 

		FROM Estrategia E 	



		WHERE	



		E.EstrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasActivas,',')) AND



		((E.LimiteVenta IS NULL OR E.LimiteVenta = 0) OR 



		(E.ImagenURL IS NULL OR E.ImagenURL = ''))







		

	SELECT splitdata 

	INTO #ESTRATEGIASACTIVAR

	FROM dbo.fnSplitString(@EstrategiasActivas,',') EA 

	WHERE EA.splitdata NOT IN (SELECT EstrategiaID FROM #ESTRATEGIASNOACTIVAS)



 

 if(@TipoEstrategia!='ShowRoom')

 begin 

 

		-- Activar

	IF ((SELECT count(splitdata) FROM dbo.fnSplitString(@EstrategiasActivas,',')) > 0)



	BEGIN



		UPDATE Estrategia 



		SET activo = 1, UsuarioModificacion = @UsuarioModificacion, FechaModificacion = GETDATE()  

		WHERE estrategiaID IN (SELECT splitdata FROM #ESTRATEGIASACTIVAR)



	END 



	SELECT @resultado = COUNT (*) FROM #ESTRATEGIASNOACTIVAS



 end

 else

 begin



 -- Activar

 	IF ((SELECT count(splitdata) FROM dbo.fnSplitString(@EstrategiasActivas,',')) > 0)



	BEGIN



		UPDATE Estrategia 

		SET activo = 1, UsuarioModificacion = @UsuarioModificacion, FechaModificacion = GETDATE()  

		WHERE estrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasActivas,','))



	END

	 

 	set @resultado =0

 end 



 

	-- Desactivar



	IF ((SELECT count(splitdata) FROM dbo.fnSplitString(@EstrategiasDesactivas,',')) > 0)



	BEGIN



		UPDATE Estrategia 

		SET activo = 0, UsuarioModificacion = @UsuarioModificacion, FechaModificacion = GETDATE()  

		WHERE estrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasDesactivas,','))



	END



	select @resultado



	SET NOCOUNT OFF



END
go
