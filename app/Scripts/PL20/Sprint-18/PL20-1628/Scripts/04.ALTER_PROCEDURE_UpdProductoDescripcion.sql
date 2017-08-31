USE BelcorpPeru
GO
DROP PROCEDURE [dbo].[UpdProductoDescripcion]
GO

CREATE proc [dbo].[UpdProductoDescripcion]
	@CampaniaID int,
	@CUV varchar(20),
	@Descripcion varchar(100),
	@PrecioProducto numeric(12,2),
	@FactorRepeticion int,
	@CodigoUsuario varchar(25),
	@RegaloDescripcion varchar(500) = NULL,
	@RegaloImagenUrl varchar(255)= NULL
as
begin try
	begin tran

	if exists(select CampaniaID, CUV from ProductoDescripcion where CampaniaID = @CampaniaID and CUV = @CUV)
 	   insert into LogMatrizCampania(CampaniaID, CUV, Descripcion, Precio, FactorRepeticion, CodigoUsuarioProceso, FechaModificacion)
	   select CampaniaID, CUV, Descripcion, PrecioProducto, FactorRepeticion, @CodigoUsuario, dbo.fnObtenerFechaHoraPais()
	   from ProductoDescripcion where CampaniaID = @CampaniaID and CUV = @CUV

	merge dbo.ProductoDescripcion as target
	using (select @CampaniaID, @CUV, @Descripcion,@PrecioProducto,@FactorRepeticion)
	as source (CampaniaID, CUV, Descripcion, PrecioProducto,FactorRepeticion)
	on (target.CampaniaID = source.CampaniaID
		and target.CUV = source.CUV)
	when matched then
		update set Descripcion = source.Descripcion,
				   PrecioProducto = source.PrecioProducto,
				   FactorRepeticion = source.FactorRepeticion
	when not matched by target then
		insert (CampaniaID, CUV, Descripcion,PrecioProducto,FactorRepeticion)
		values (source.CampaniaID, source.CUV, source.Descripcion,source.PrecioProducto,source.FactorRepeticion);

	commit tran;
end try

begin catch
	rollback tran;
	throw;
end catch
GO


USE BelcorpColombia
GO
DROP PROCEDURE [dbo].[UpdProductoDescripcion]
GO

CREATE proc [dbo].[UpdProductoDescripcion]
	@CampaniaID int,
	@CUV varchar(20),
	@Descripcion varchar(100),
	@PrecioProducto numeric(12,2),
	@FactorRepeticion int,
	@CodigoUsuario varchar(25),
	@RegaloDescripcion varchar(500) = NULL,
	@RegaloImagenUrl varchar(255)= NULL
as
begin try
	begin tran

	if exists(select CampaniaID, CUV from ProductoDescripcion where CampaniaID = @CampaniaID and CUV = @CUV)
 	   insert into LogMatrizCampania(CampaniaID, CUV, Descripcion, Precio, FactorRepeticion, CodigoUsuarioProceso, FechaModificacion)
	   select CampaniaID, CUV, Descripcion, PrecioProducto, FactorRepeticion, @CodigoUsuario, dbo.fnObtenerFechaHoraPais()
	   from ProductoDescripcion where CampaniaID = @CampaniaID and CUV = @CUV

	merge dbo.ProductoDescripcion as target
	using (select @CampaniaID, @CUV, @Descripcion,@PrecioProducto,@FactorRepeticion)
	as source (CampaniaID, CUV, Descripcion, PrecioProducto,FactorRepeticion)
	on (target.CampaniaID = source.CampaniaID
		and target.CUV = source.CUV)
	when matched then
		update set Descripcion = source.Descripcion,
				   PrecioProducto = source.PrecioProducto,
				   FactorRepeticion = source.FactorRepeticion
	when not matched by target then
		insert (CampaniaID, CUV, Descripcion,PrecioProducto,FactorRepeticion)
		values (source.CampaniaID, source.CUV, source.Descripcion,source.PrecioProducto,source.FactorRepeticion);

	commit tran;
end try

begin catch
	rollback tran;
	throw;
end catch
GO


USE BelcorpMexico
GO
DROP PROCEDURE [dbo].[UpdProductoDescripcion]
GO

CREATE proc [dbo].[UpdProductoDescripcion]
	@CampaniaID int,
	@CUV varchar(20),
	@Descripcion varchar(100),
	@PrecioProducto numeric(12,2),
	@FactorRepeticion int,
	@CodigoUsuario varchar(25),
	@RegaloDescripcion varchar(500) = NULL,
	@RegaloImagenUrl varchar(255)= NULL
as
begin try
	begin tran

	if exists(select CampaniaID, CUV from ProductoDescripcion where CampaniaID = @CampaniaID and CUV = @CUV)
 	   insert into LogMatrizCampania(CampaniaID, CUV, Descripcion, Precio, FactorRepeticion, CodigoUsuarioProceso, FechaModificacion)
	   select CampaniaID, CUV, Descripcion, PrecioProducto, FactorRepeticion, @CodigoUsuario, dbo.fnObtenerFechaHoraPais()
	   from ProductoDescripcion where CampaniaID = @CampaniaID and CUV = @CUV

	merge dbo.ProductoDescripcion as target
	using (select @CampaniaID, @CUV, @Descripcion,@PrecioProducto,@FactorRepeticion)
	as source (CampaniaID, CUV, Descripcion, PrecioProducto,FactorRepeticion)
	on (target.CampaniaID = source.CampaniaID
		and target.CUV = source.CUV)
	when matched then
		update set Descripcion = source.Descripcion,
				   PrecioProducto = source.PrecioProducto,
				   FactorRepeticion = source.FactorRepeticion
	when not matched by target then
		insert (CampaniaID, CUV, Descripcion,PrecioProducto,FactorRepeticion)
		values (source.CampaniaID, source.CUV, source.Descripcion,source.PrecioProducto,source.FactorRepeticion);

	commit tran;
end try

begin catch
	rollback tran;
	throw;
end catch
GO


USE BelcorpChile
GO
DROP PROCEDURE [dbo].[UpdProductoDescripcion]
GO

CREATE proc [dbo].[UpdProductoDescripcion]
	@CampaniaID int,
	@CUV varchar(20),
	@Descripcion varchar(100),
	@PrecioProducto numeric(12,2),
	@FactorRepeticion int,
	@CodigoUsuario varchar(25),
	@RegaloDescripcion varchar(500) = NULL,
	@RegaloImagenUrl varchar(255)= NULL
as
begin try
	begin tran

	if exists(select CampaniaID, CUV from ProductoDescripcion where CampaniaID = @CampaniaID and CUV = @CUV)
 	   insert into LogMatrizCampania(CampaniaID, CUV, Descripcion, Precio, FactorRepeticion, CodigoUsuarioProceso, FechaModificacion)
	   select CampaniaID, CUV, Descripcion, PrecioProducto, FactorRepeticion, @CodigoUsuario, dbo.fnObtenerFechaHoraPais()
	   from ProductoDescripcion where CampaniaID = @CampaniaID and CUV = @CUV

	merge dbo.ProductoDescripcion as target
	using (select @CampaniaID, @CUV, @Descripcion,@PrecioProducto,@FactorRepeticion)
	as source (CampaniaID, CUV, Descripcion, PrecioProducto,FactorRepeticion)
	on (target.CampaniaID = source.CampaniaID
		and target.CUV = source.CUV)
	when matched then
		update set Descripcion = source.Descripcion,
				   PrecioProducto = source.PrecioProducto,
				   FactorRepeticion = source.FactorRepeticion
	when not matched by target then
		insert (CampaniaID, CUV, Descripcion,PrecioProducto,FactorRepeticion)
		values (source.CampaniaID, source.CUV, source.Descripcion,source.PrecioProducto,source.FactorRepeticion);

	commit tran;
end try

begin catch
	rollback tran;
	throw;
end catch
GO


USE [BelcorpChile_Plan20]
GO

DROP PROCEDURE UpdProductoDescripcion
GO

CREATE PROCEDURE UpdProductoDescripcion
	@CampaniaID int,
	@CUV varchar(20),
	@Descripcion varchar(100),
	@PrecioProducto numeric(12,2),
	@FactorRepeticion int,
	@CodigoUsuario varchar(25),
	@RegaloDescripcion varchar(500) = NULL,
	@RegaloImagenUrl varchar(255)= NULL
AS
BEGIN TRY
	BEGIN TRAN

	IF EXISTS(	SELECT CAMPANIAID, CUV 
				FROM PRODUCTODESCRIPCION 
				WHERE CAMPANIAID = @CAMPANIAID AND CUV = @CUV)
		INSERT INTO LOGMATRIZCAMPANIA(CAMPANIAID, CUV, DESCRIPCION, PRECIO, FACTORREPETICION, CODIGOUSUARIOPROCESO, FECHAMODIFICACION)
		SELECT CAMPANIAID, CUV, DESCRIPCION, PRECIOPRODUCTO, FACTORREPETICION, @CODIGOUSUARIO, DBO.FNOBTENERFECHAHORAPAIS()
		FROM PRODUCTODESCRIPCION 
		WHERE CAMPANIAID = @CAMPANIAID 
		AND CUV = @CUV

	MERGE DBO.PRODUCTODESCRIPCION AS [TARGET]
	USING (
		SELECT 
		CAMPANIAID = @CAMPANIAID
		,CUV = @CUV
		,DESCRIPCION = @DESCRIPCION
		,PRECIOPRODUCTO = @PRECIOPRODUCTO
		,FACTORREPETICION = @FACTORREPETICION
		,REGALODESCRIPCION = @RegaloDescripcion
		,REGALOIMAGENURL = @RegaloImagenUrl
	)AS [SOURCE] 
	ON (
		[TARGET].CAMPANIAID = [SOURCE].CAMPANIAID
		AND [TARGET].CUV = [SOURCE].CUV
	)
	WHEN MATCHED THEN
		UPDATE 
		SET DESCRIPCION = [SOURCE].DESCRIPCION,
		PRECIOPRODUCTO = [SOURCE].PRECIOPRODUCTO,
		FACTORREPETICION = [SOURCE].FACTORREPETICION,
		REGALODESCRIPCION = [SOURCE].REGALODESCRIPCION,
		REGALOIMAGENURL = [SOURCE].REGALOIMAGENURL
	WHEN NOT MATCHED THEN
		INSERT (CAMPANIAID, CUV, DESCRIPCION,PRECIOPRODUCTO,FACTORREPETICION,REGALODESCRIPCION,REGALOIMAGENURL)
		VALUES ([SOURCE].CAMPANIAID, [SOURCE].CUV, [SOURCE].DESCRIPCION,[SOURCE].PRECIOPRODUCTO,[SOURCE].FACTORREPETICION,[SOURCE].REGALODESCRIPCION,[SOURCE].REGALOIMAGENURL);

	COMMIT TRAN;
END TRY
BEGIN CATCH
	ROLLBACK TRAN;
	THROW;
END CATCH
GO


USE BelcorpBolivia
GO
DROP PROCEDURE [dbo].[UpdProductoDescripcion]
GO

CREATE proc [dbo].[UpdProductoDescripcion]
	@CampaniaID int,
	@CUV varchar(20),
	@Descripcion varchar(100),
	@PrecioProducto numeric(12,2),
	@FactorRepeticion int,
	@CodigoUsuario varchar(25),
	@RegaloDescripcion varchar(500) = NULL,
	@RegaloImagenUrl varchar(255)= NULL
as
begin try
	begin tran

	if exists(select CampaniaID, CUV from ProductoDescripcion where CampaniaID = @CampaniaID and CUV = @CUV)
 	   insert into LogMatrizCampania(CampaniaID, CUV, Descripcion, Precio, FactorRepeticion, CodigoUsuarioProceso, FechaModificacion)
	   select CampaniaID, CUV, Descripcion, PrecioProducto, FactorRepeticion, @CodigoUsuario, dbo.fnObtenerFechaHoraPais()
	   from ProductoDescripcion where CampaniaID = @CampaniaID and CUV = @CUV

	merge dbo.ProductoDescripcion as target
	using (select @CampaniaID, @CUV, @Descripcion,@PrecioProducto,@FactorRepeticion)
	as source (CampaniaID, CUV, Descripcion, PrecioProducto,FactorRepeticion)
	on (target.CampaniaID = source.CampaniaID
		and target.CUV = source.CUV)
	when matched then
		update set Descripcion = source.Descripcion,
				   PrecioProducto = source.PrecioProducto,
				   FactorRepeticion = source.FactorRepeticion
	when not matched by target then
		insert (CampaniaID, CUV, Descripcion,PrecioProducto,FactorRepeticion)
		values (source.CampaniaID, source.CUV, source.Descripcion,source.PrecioProducto,source.FactorRepeticion);

	commit tran;
end try

begin catch
	rollback tran;
	throw;
end catch
GO


USE BelcorpEcuador
GO
DROP PROCEDURE [dbo].[UpdProductoDescripcion]
GO

CREATE proc [dbo].[UpdProductoDescripcion]
	@CampaniaID int,
	@CUV varchar(20),
	@Descripcion varchar(100),
	@PrecioProducto numeric(12,2),
	@FactorRepeticion int,
	@CodigoUsuario varchar(25),
	@RegaloDescripcion varchar(500) = NULL,
	@RegaloImagenUrl varchar(255)= NULL
as
begin try
	begin tran

	if exists(select CampaniaID, CUV from ProductoDescripcion where CampaniaID = @CampaniaID and CUV = @CUV)
 	   insert into LogMatrizCampania(CampaniaID, CUV, Descripcion, Precio, FactorRepeticion, CodigoUsuarioProceso, FechaModificacion)
	   select CampaniaID, CUV, Descripcion, PrecioProducto, FactorRepeticion, @CodigoUsuario, dbo.fnObtenerFechaHoraPais()
	   from ProductoDescripcion where CampaniaID = @CampaniaID and CUV = @CUV

	merge dbo.ProductoDescripcion as target
	using (select @CampaniaID, @CUV, @Descripcion,@PrecioProducto,@FactorRepeticion)
	as source (CampaniaID, CUV, Descripcion, PrecioProducto,FactorRepeticion)
	on (target.CampaniaID = source.CampaniaID
		and target.CUV = source.CUV)
	when matched then
		update set Descripcion = source.Descripcion,
				   PrecioProducto = source.PrecioProducto,
				   FactorRepeticion = source.FactorRepeticion
	when not matched by target then
		insert (CampaniaID, CUV, Descripcion,PrecioProducto,FactorRepeticion)
		values (source.CampaniaID, source.CUV, source.Descripcion,source.PrecioProducto,source.FactorRepeticion);

	commit tran;
end try

begin catch
	rollback tran;
	throw;
end catch
GO


USE BelcorpCostaRica
GO
DROP PROCEDURE [dbo].[UpdProductoDescripcion]
GO

CREATE proc [dbo].[UpdProductoDescripcion]
	@CampaniaID int,
	@CUV varchar(20),
	@Descripcion varchar(100),
	@PrecioProducto numeric(12,2),
	@FactorRepeticion int,
	@CodigoUsuario varchar(25),
	@RegaloDescripcion varchar(500) = NULL,
	@RegaloImagenUrl varchar(255)= NULL
as
begin try
	begin tran

	if exists(select CampaniaID, CUV from ProductoDescripcion where CampaniaID = @CampaniaID and CUV = @CUV)
 	   insert into LogMatrizCampania(CampaniaID, CUV, Descripcion, Precio, FactorRepeticion, CodigoUsuarioProceso, FechaModificacion)
	   select CampaniaID, CUV, Descripcion, PrecioProducto, FactorRepeticion, @CodigoUsuario, dbo.fnObtenerFechaHoraPais()
	   from ProductoDescripcion where CampaniaID = @CampaniaID and CUV = @CUV

	merge dbo.ProductoDescripcion as target
	using (select @CampaniaID, @CUV, @Descripcion,@PrecioProducto,@FactorRepeticion)
	as source (CampaniaID, CUV, Descripcion, PrecioProducto,FactorRepeticion)
	on (target.CampaniaID = source.CampaniaID
		and target.CUV = source.CUV)
	when matched then
		update set Descripcion = source.Descripcion,
				   PrecioProducto = source.PrecioProducto,
				   FactorRepeticion = source.FactorRepeticion
	when not matched by target then
		insert (CampaniaID, CUV, Descripcion,PrecioProducto,FactorRepeticion)
		values (source.CampaniaID, source.CUV, source.Descripcion,source.PrecioProducto,source.FactorRepeticion);

	commit tran;
end try

begin catch
	rollback tran;
	throw;
end catch
GO


USE BelcorpDominicana
GO
DROP PROCEDURE [dbo].[UpdProductoDescripcion]
GO

CREATE proc [dbo].[UpdProductoDescripcion]
	@CampaniaID int,
	@CUV varchar(20),
	@Descripcion varchar(100),
	@PrecioProducto numeric(12,2),
	@FactorRepeticion int,
	@CodigoUsuario varchar(25),
	@RegaloDescripcion varchar(500) = NULL,
	@RegaloImagenUrl varchar(255)= NULL
as
begin try
	begin tran

	if exists(select CampaniaID, CUV from ProductoDescripcion where CampaniaID = @CampaniaID and CUV = @CUV)
 	   insert into LogMatrizCampania(CampaniaID, CUV, Descripcion, Precio, FactorRepeticion, CodigoUsuarioProceso, FechaModificacion)
	   select CampaniaID, CUV, Descripcion, PrecioProducto, FactorRepeticion, @CodigoUsuario, dbo.fnObtenerFechaHoraPais()
	   from ProductoDescripcion where CampaniaID = @CampaniaID and CUV = @CUV

	merge dbo.ProductoDescripcion as target
	using (select @CampaniaID, @CUV, @Descripcion,@PrecioProducto,@FactorRepeticion)
	as source (CampaniaID, CUV, Descripcion, PrecioProducto,FactorRepeticion)
	on (target.CampaniaID = source.CampaniaID
		and target.CUV = source.CUV)
	when matched then
		update set Descripcion = source.Descripcion,
				   PrecioProducto = source.PrecioProducto,
				   FactorRepeticion = source.FactorRepeticion
	when not matched by target then
		insert (CampaniaID, CUV, Descripcion,PrecioProducto,FactorRepeticion)
		values (source.CampaniaID, source.CUV, source.Descripcion,source.PrecioProducto,source.FactorRepeticion);

	commit tran;
end try

begin catch
	rollback tran;
	throw;
end catch
GO


USE BelcorpGuatemala
GO
DROP PROCEDURE [dbo].[UpdProductoDescripcion]
GO

CREATE proc [dbo].[UpdProductoDescripcion]
	@CampaniaID int,
	@CUV varchar(20),
	@Descripcion varchar(100),
	@PrecioProducto numeric(12,2),
	@FactorRepeticion int,
	@CodigoUsuario varchar(25),
	@RegaloDescripcion varchar(500) = NULL,
	@RegaloImagenUrl varchar(255)= NULL
as
begin try
	begin tran

	if exists(select CampaniaID, CUV from ProductoDescripcion where CampaniaID = @CampaniaID and CUV = @CUV)
 	   insert into LogMatrizCampania(CampaniaID, CUV, Descripcion, Precio, FactorRepeticion, CodigoUsuarioProceso, FechaModificacion)
	   select CampaniaID, CUV, Descripcion, PrecioProducto, FactorRepeticion, @CodigoUsuario, dbo.fnObtenerFechaHoraPais()
	   from ProductoDescripcion where CampaniaID = @CampaniaID and CUV = @CUV

	merge dbo.ProductoDescripcion as target
	using (select @CampaniaID, @CUV, @Descripcion,@PrecioProducto,@FactorRepeticion)
	as source (CampaniaID, CUV, Descripcion, PrecioProducto,FactorRepeticion)
	on (target.CampaniaID = source.CampaniaID
		and target.CUV = source.CUV)
	when matched then
		update set Descripcion = source.Descripcion,
				   PrecioProducto = source.PrecioProducto,
				   FactorRepeticion = source.FactorRepeticion
	when not matched by target then
		insert (CampaniaID, CUV, Descripcion,PrecioProducto,FactorRepeticion)
		values (source.CampaniaID, source.CUV, source.Descripcion,source.PrecioProducto,source.FactorRepeticion);

	commit tran;
end try

begin catch
	rollback tran;
	throw;
end catch
GO


USE BelcorpPanama
GO
DROP PROCEDURE [dbo].[UpdProductoDescripcion]
GO

CREATE proc [dbo].[UpdProductoDescripcion]
	@CampaniaID int,
	@CUV varchar(20),
	@Descripcion varchar(100),
	@PrecioProducto numeric(12,2),
	@FactorRepeticion int,
	@CodigoUsuario varchar(25),
	@RegaloDescripcion varchar(500) = NULL,
	@RegaloImagenUrl varchar(255)= NULL
as
begin try
	begin tran

	if exists(select CampaniaID, CUV from ProductoDescripcion where CampaniaID = @CampaniaID and CUV = @CUV)
 	   insert into LogMatrizCampania(CampaniaID, CUV, Descripcion, Precio, FactorRepeticion, CodigoUsuarioProceso, FechaModificacion)
	   select CampaniaID, CUV, Descripcion, PrecioProducto, FactorRepeticion, @CodigoUsuario, dbo.fnObtenerFechaHoraPais()
	   from ProductoDescripcion where CampaniaID = @CampaniaID and CUV = @CUV

	merge dbo.ProductoDescripcion as target
	using (select @CampaniaID, @CUV, @Descripcion,@PrecioProducto,@FactorRepeticion)
	as source (CampaniaID, CUV, Descripcion, PrecioProducto,FactorRepeticion)
	on (target.CampaniaID = source.CampaniaID
		and target.CUV = source.CUV)
	when matched then
		update set Descripcion = source.Descripcion,
				   PrecioProducto = source.PrecioProducto,
				   FactorRepeticion = source.FactorRepeticion
	when not matched by target then
		insert (CampaniaID, CUV, Descripcion,PrecioProducto,FactorRepeticion)
		values (source.CampaniaID, source.CUV, source.Descripcion,source.PrecioProducto,source.FactorRepeticion);

	commit tran;
end try

begin catch
	rollback tran;
	throw;
end catch
GO


USE BelcorpPuertoRico
GO
DROP PROCEDURE [dbo].[UpdProductoDescripcion]
GO

CREATE proc [dbo].[UpdProductoDescripcion]
	@CampaniaID int,
	@CUV varchar(20),
	@Descripcion varchar(100),
	@PrecioProducto numeric(12,2),
	@FactorRepeticion int,
	@CodigoUsuario varchar(25),
	@RegaloDescripcion varchar(500) = NULL,
	@RegaloImagenUrl varchar(255)= NULL
as
begin try
	begin tran

	if exists(select CampaniaID, CUV from ProductoDescripcion where CampaniaID = @CampaniaID and CUV = @CUV)
 	   insert into LogMatrizCampania(CampaniaID, CUV, Descripcion, Precio, FactorRepeticion, CodigoUsuarioProceso, FechaModificacion)
	   select CampaniaID, CUV, Descripcion, PrecioProducto, FactorRepeticion, @CodigoUsuario, dbo.fnObtenerFechaHoraPais()
	   from ProductoDescripcion where CampaniaID = @CampaniaID and CUV = @CUV

	merge dbo.ProductoDescripcion as target
	using (select @CampaniaID, @CUV, @Descripcion,@PrecioProducto,@FactorRepeticion)
	as source (CampaniaID, CUV, Descripcion, PrecioProducto,FactorRepeticion)
	on (target.CampaniaID = source.CampaniaID
		and target.CUV = source.CUV)
	when matched then
		update set Descripcion = source.Descripcion,
				   PrecioProducto = source.PrecioProducto,
				   FactorRepeticion = source.FactorRepeticion
	when not matched by target then
		insert (CampaniaID, CUV, Descripcion,PrecioProducto,FactorRepeticion)
		values (source.CampaniaID, source.CUV, source.Descripcion,source.PrecioProducto,source.FactorRepeticion);

	commit tran;
end try

begin catch
	rollback tran;
	throw;
end catch
GO


USE BelcorpSalvador
GO
DROP PROCEDURE [dbo].[UpdProductoDescripcion]
GO

CREATE proc [dbo].[UpdProductoDescripcion]
	@CampaniaID int,
	@CUV varchar(20),
	@Descripcion varchar(100),
	@PrecioProducto numeric(12,2),
	@FactorRepeticion int,
	@CodigoUsuario varchar(25),
	@RegaloDescripcion varchar(500) = NULL,
	@RegaloImagenUrl varchar(255)= NULL
as
begin try
	begin tran

	if exists(select CampaniaID, CUV from ProductoDescripcion where CampaniaID = @CampaniaID and CUV = @CUV)
 	   insert into LogMatrizCampania(CampaniaID, CUV, Descripcion, Precio, FactorRepeticion, CodigoUsuarioProceso, FechaModificacion)
	   select CampaniaID, CUV, Descripcion, PrecioProducto, FactorRepeticion, @CodigoUsuario, dbo.fnObtenerFechaHoraPais()
	   from ProductoDescripcion where CampaniaID = @CampaniaID and CUV = @CUV

	merge dbo.ProductoDescripcion as target
	using (select @CampaniaID, @CUV, @Descripcion,@PrecioProducto,@FactorRepeticion)
	as source (CampaniaID, CUV, Descripcion, PrecioProducto,FactorRepeticion)
	on (target.CampaniaID = source.CampaniaID
		and target.CUV = source.CUV)
	when matched then
		update set Descripcion = source.Descripcion,
				   PrecioProducto = source.PrecioProducto,
				   FactorRepeticion = source.FactorRepeticion
	when not matched by target then
		insert (CampaniaID, CUV, Descripcion,PrecioProducto,FactorRepeticion)
		values (source.CampaniaID, source.CUV, source.Descripcion,source.PrecioProducto,source.FactorRepeticion);

	commit tran;
end try

begin catch
	rollback tran;
	throw;
end catch
GO


USE BelcorpVenezuela
GO
DROP PROCEDURE [dbo].[UpdProductoDescripcion]
GO

CREATE proc [dbo].[UpdProductoDescripcion]
	@CampaniaID int,
	@CUV varchar(20),
	@Descripcion varchar(100),
	@PrecioProducto numeric(12,2),
	@FactorRepeticion int,
	@CodigoUsuario varchar(25),
	@RegaloDescripcion varchar(500) = NULL,
	@RegaloImagenUrl varchar(255)= NULL
as
begin try
	begin tran

	if exists(select CampaniaID, CUV from ProductoDescripcion where CampaniaID = @CampaniaID and CUV = @CUV)
 	   insert into LogMatrizCampania(CampaniaID, CUV, Descripcion, Precio, FactorRepeticion, CodigoUsuarioProceso, FechaModificacion)
	   select CampaniaID, CUV, Descripcion, PrecioProducto, FactorRepeticion, @CodigoUsuario, dbo.fnObtenerFechaHoraPais()
	   from ProductoDescripcion where CampaniaID = @CampaniaID and CUV = @CUV

	merge dbo.ProductoDescripcion as target
	using (select @CampaniaID, @CUV, @Descripcion,@PrecioProducto,@FactorRepeticion)
	as source (CampaniaID, CUV, Descripcion, PrecioProducto,FactorRepeticion)
	on (target.CampaniaID = source.CampaniaID
		and target.CUV = source.CUV)
	when matched then
		update set Descripcion = source.Descripcion,
				   PrecioProducto = source.PrecioProducto,
				   FactorRepeticion = source.FactorRepeticion
	when not matched by target then
		insert (CampaniaID, CUV, Descripcion,PrecioProducto,FactorRepeticion)
		values (source.CampaniaID, source.CUV, source.Descripcion,source.PrecioProducto,source.FactorRepeticion);

	commit tran;
end try

begin catch
	rollback tran;
	throw;
end catch
GO