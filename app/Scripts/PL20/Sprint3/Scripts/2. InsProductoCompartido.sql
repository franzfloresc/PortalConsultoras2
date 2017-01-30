
USE [BelcorpBolivia]
GO
/****** Object:  StoredProcedure [dbo].[InsProductoCompartido]    Script Date: 06/01/2017 16:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- InsProductoCompartido 201701,00037,'FAV','/..../../','w'

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.InsProductoCompartido'))
BEGIN
    DROP PROCEDURE dbo.InsProductoCompartido
END

GO

CREATE PROCEDURE [dbo].[InsProductoCompartido]
(
@ProductoCompCampaniaID int,
@ProductoCompCUV varchar(20),
@ProductoCompPalanca varchar(10),
@ProductoCompDetalle varchar(max),
@ProductoCompApp varchar(5),
@ProductoCompID int output
)
as
BEGIN
	if not exists (select 1 from [dbo].[ProductoCompartido] where CampaniaID = @ProductoCompCampaniaID 
	and CUV = @ProductoCompCUV and Palanca = @ProductoCompPalanca)
	BEGIN
		insert into [dbo].[ProductoCompartido]
			(
			  [CampaniaID]
			 ,[CUV]
			 ,[Palanca]
			 ,[Detalle]
			 ,[Applicacion]
			 ,[FechaRegisto]
			)
			values
			(
			  @ProductoCompCampaniaID
			 ,@ProductoCompCUV
			 ,@ProductoCompPalanca
			 ,@ProductoCompDetalle
			 ,@ProductoCompApp
			 ,GETDATE()
			)

			set @ProductoCompID = SCOPE_IDENTITY();			
	END
	ELSE
	BEGIN
			select @ProductoCompID = ProductoCompID from [dbo].[ProductoCompartido] where CampaniaID = @ProductoCompCampaniaID 
			and CUV = @ProductoCompCUV and Palanca = @ProductoCompPalanca
	END
END

GO

/*end*/

USE [BelcorpChile]
GO
/****** Object:  StoredProcedure [dbo].[InsProductoCompartido]    Script Date: 06/01/2017 16:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- InsProductoCompartido 201701,00037,'FAV','/..../../','w'

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.InsProductoCompartido'))
BEGIN
    DROP PROCEDURE dbo.InsProductoCompartido
END

GO

CREATE PROCEDURE [dbo].[InsProductoCompartido]
(
@ProductoCompCampaniaID int,
@ProductoCompCUV varchar(20),
@ProductoCompPalanca varchar(10),
@ProductoCompDetalle varchar(max),
@ProductoCompApp varchar(5),
@ProductoCompID int output
)
as
BEGIN
	if not exists (select 1 from [dbo].[ProductoCompartido] where CampaniaID = @ProductoCompCampaniaID 
	and CUV = @ProductoCompCUV and Palanca = @ProductoCompPalanca)
	BEGIN
		insert into [dbo].[ProductoCompartido]
			(
			  [CampaniaID]
			 ,[CUV]
			 ,[Palanca]
			 ,[Detalle]
			 ,[Applicacion]
			 ,[FechaRegisto]
			)
			values
			(
			  @ProductoCompCampaniaID
			 ,@ProductoCompCUV
			 ,@ProductoCompPalanca
			 ,@ProductoCompDetalle
			 ,@ProductoCompApp
			 ,GETDATE()
			)

			set @ProductoCompID = SCOPE_IDENTITY();			
	END
	ELSE
	BEGIN
			select @ProductoCompID = ProductoCompID from [dbo].[ProductoCompartido] where CampaniaID = @ProductoCompCampaniaID 
			and CUV = @ProductoCompCUV and Palanca = @ProductoCompPalanca
	END
END

GO

/*end*/

USE [BelcorpColombia]
GO
/****** Object:  StoredProcedure [dbo].[InsProductoCompartido]    Script Date: 06/01/2017 16:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- InsProductoCompartido 201701,00037,'FAV','/..../../','w'

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.InsProductoCompartido'))
BEGIN
    DROP PROCEDURE dbo.InsProductoCompartido
END

GO

CREATE PROCEDURE [dbo].[InsProductoCompartido]
(
@ProductoCompCampaniaID int,
@ProductoCompCUV varchar(20),
@ProductoCompPalanca varchar(10),
@ProductoCompDetalle varchar(max),
@ProductoCompApp varchar(5),
@ProductoCompID int output
)
as
BEGIN
	if not exists (select 1 from [dbo].[ProductoCompartido] where CampaniaID = @ProductoCompCampaniaID 
	and CUV = @ProductoCompCUV and Palanca = @ProductoCompPalanca)
	BEGIN
		insert into [dbo].[ProductoCompartido]
			(
			  [CampaniaID]
			 ,[CUV]
			 ,[Palanca]
			 ,[Detalle]
			 ,[Applicacion]
			 ,[FechaRegisto]
			)
			values
			(
			  @ProductoCompCampaniaID
			 ,@ProductoCompCUV
			 ,@ProductoCompPalanca
			 ,@ProductoCompDetalle
			 ,@ProductoCompApp
			 ,GETDATE()
			)

			set @ProductoCompID = SCOPE_IDENTITY();			
	END
	ELSE
	BEGIN
			select @ProductoCompID = ProductoCompID from [dbo].[ProductoCompartido] where CampaniaID = @ProductoCompCampaniaID 
			and CUV = @ProductoCompCUV and Palanca = @ProductoCompPalanca
	END
END

GO

/*end*/

USE [BelcorpCostaRica]
GO
/****** Object:  StoredProcedure [dbo].[InsProductoCompartido]    Script Date: 06/01/2017 16:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- InsProductoCompartido 201701,00037,'FAV','/..../../','w'

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.InsProductoCompartido'))
BEGIN
    DROP PROCEDURE dbo.InsProductoCompartido
END

GO

CREATE PROCEDURE [dbo].[InsProductoCompartido]
(
@ProductoCompCampaniaID int,
@ProductoCompCUV varchar(20),
@ProductoCompPalanca varchar(10),
@ProductoCompDetalle varchar(max),
@ProductoCompApp varchar(5),
@ProductoCompID int output
)
as
BEGIN
	if not exists (select 1 from [dbo].[ProductoCompartido] where CampaniaID = @ProductoCompCampaniaID 
	and CUV = @ProductoCompCUV and Palanca = @ProductoCompPalanca)
	BEGIN
		insert into [dbo].[ProductoCompartido]
			(
			  [CampaniaID]
			 ,[CUV]
			 ,[Palanca]
			 ,[Detalle]
			 ,[Applicacion]
			 ,[FechaRegisto]
			)
			values
			(
			  @ProductoCompCampaniaID
			 ,@ProductoCompCUV
			 ,@ProductoCompPalanca
			 ,@ProductoCompDetalle
			 ,@ProductoCompApp
			 ,GETDATE()
			)

			set @ProductoCompID = SCOPE_IDENTITY();			
	END
	ELSE
	BEGIN
			select @ProductoCompID = ProductoCompID from [dbo].[ProductoCompartido] where CampaniaID = @ProductoCompCampaniaID 
			and CUV = @ProductoCompCUV and Palanca = @ProductoCompPalanca
	END
END

GO

/*end*/

USE [BelcorpDominicana]
GO
/****** Object:  StoredProcedure [dbo].[InsProductoCompartido]    Script Date: 06/01/2017 16:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- InsProductoCompartido 201701,00037,'FAV','/..../../','w'

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.InsProductoCompartido'))
BEGIN
    DROP PROCEDURE dbo.InsProductoCompartido
END

GO

CREATE PROCEDURE [dbo].[InsProductoCompartido]
(
@ProductoCompCampaniaID int,
@ProductoCompCUV varchar(20),
@ProductoCompPalanca varchar(10),
@ProductoCompDetalle varchar(max),
@ProductoCompApp varchar(5),
@ProductoCompID int output
)
as
BEGIN
	if not exists (select 1 from [dbo].[ProductoCompartido] where CampaniaID = @ProductoCompCampaniaID 
	and CUV = @ProductoCompCUV and Palanca = @ProductoCompPalanca)
	BEGIN
		insert into [dbo].[ProductoCompartido]
			(
			  [CampaniaID]
			 ,[CUV]
			 ,[Palanca]
			 ,[Detalle]
			 ,[Applicacion]
			 ,[FechaRegisto]
			)
			values
			(
			  @ProductoCompCampaniaID
			 ,@ProductoCompCUV
			 ,@ProductoCompPalanca
			 ,@ProductoCompDetalle
			 ,@ProductoCompApp
			 ,GETDATE()
			)

			set @ProductoCompID = SCOPE_IDENTITY();			
	END
	ELSE
	BEGIN
			select @ProductoCompID = ProductoCompID from [dbo].[ProductoCompartido] where CampaniaID = @ProductoCompCampaniaID 
			and CUV = @ProductoCompCUV and Palanca = @ProductoCompPalanca
	END
END

GO

/*end*/

USE [BelcorpEcuador]
GO
/****** Object:  StoredProcedure [dbo].[InsProductoCompartido]    Script Date: 06/01/2017 16:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- InsProductoCompartido 201701,00037,'FAV','/..../../','w'

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.InsProductoCompartido'))
BEGIN
    DROP PROCEDURE dbo.InsProductoCompartido
END

GO

CREATE PROCEDURE [dbo].[InsProductoCompartido]
(
@ProductoCompCampaniaID int,
@ProductoCompCUV varchar(20),
@ProductoCompPalanca varchar(10),
@ProductoCompDetalle varchar(max),
@ProductoCompApp varchar(5),
@ProductoCompID int output
)
as
BEGIN
	if not exists (select 1 from [dbo].[ProductoCompartido] where CampaniaID = @ProductoCompCampaniaID 
	and CUV = @ProductoCompCUV and Palanca = @ProductoCompPalanca)
	BEGIN
		insert into [dbo].[ProductoCompartido]
			(
			  [CampaniaID]
			 ,[CUV]
			 ,[Palanca]
			 ,[Detalle]
			 ,[Applicacion]
			 ,[FechaRegisto]
			)
			values
			(
			  @ProductoCompCampaniaID
			 ,@ProductoCompCUV
			 ,@ProductoCompPalanca
			 ,@ProductoCompDetalle
			 ,@ProductoCompApp
			 ,GETDATE()
			)

			set @ProductoCompID = SCOPE_IDENTITY();			
	END
	ELSE
	BEGIN
			select @ProductoCompID = ProductoCompID from [dbo].[ProductoCompartido] where CampaniaID = @ProductoCompCampaniaID 
			and CUV = @ProductoCompCUV and Palanca = @ProductoCompPalanca
	END
END

GO

/*end*/

USE [BelcorpGuatemala]
GO
/****** Object:  StoredProcedure [dbo].[InsProductoCompartido]    Script Date: 06/01/2017 16:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- InsProductoCompartido 201701,00037,'FAV','/..../../','w'

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.InsProductoCompartido'))
BEGIN
    DROP PROCEDURE dbo.InsProductoCompartido
END

GO

CREATE PROCEDURE [dbo].[InsProductoCompartido]
(
@ProductoCompCampaniaID int,
@ProductoCompCUV varchar(20),
@ProductoCompPalanca varchar(10),
@ProductoCompDetalle varchar(max),
@ProductoCompApp varchar(5),
@ProductoCompID int output
)
as
BEGIN
	if not exists (select 1 from [dbo].[ProductoCompartido] where CampaniaID = @ProductoCompCampaniaID 
	and CUV = @ProductoCompCUV and Palanca = @ProductoCompPalanca)
	BEGIN
		insert into [dbo].[ProductoCompartido]
			(
			  [CampaniaID]
			 ,[CUV]
			 ,[Palanca]
			 ,[Detalle]
			 ,[Applicacion]
			 ,[FechaRegisto]
			)
			values
			(
			  @ProductoCompCampaniaID
			 ,@ProductoCompCUV
			 ,@ProductoCompPalanca
			 ,@ProductoCompDetalle
			 ,@ProductoCompApp
			 ,GETDATE()
			)

			set @ProductoCompID = SCOPE_IDENTITY();			
	END
	ELSE
	BEGIN
			select @ProductoCompID = ProductoCompID from [dbo].[ProductoCompartido] where CampaniaID = @ProductoCompCampaniaID 
			and CUV = @ProductoCompCUV and Palanca = @ProductoCompPalanca
	END
END

GO

/*end*/

USE [BelcorpMexico]
GO
/****** Object:  StoredProcedure [dbo].[InsProductoCompartido]    Script Date: 06/01/2017 16:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- InsProductoCompartido 201701,00037,'FAV','/..../../','w'

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.InsProductoCompartido'))
BEGIN
    DROP PROCEDURE dbo.InsProductoCompartido
END

GO

CREATE PROCEDURE [dbo].[InsProductoCompartido]
(
@ProductoCompCampaniaID int,
@ProductoCompCUV varchar(20),
@ProductoCompPalanca varchar(10),
@ProductoCompDetalle varchar(max),
@ProductoCompApp varchar(5),
@ProductoCompID int output
)
as
BEGIN
	if not exists (select 1 from [dbo].[ProductoCompartido] where CampaniaID = @ProductoCompCampaniaID 
	and CUV = @ProductoCompCUV and Palanca = @ProductoCompPalanca)
	BEGIN
		insert into [dbo].[ProductoCompartido]
			(
			  [CampaniaID]
			 ,[CUV]
			 ,[Palanca]
			 ,[Detalle]
			 ,[Applicacion]
			 ,[FechaRegisto]
			)
			values
			(
			  @ProductoCompCampaniaID
			 ,@ProductoCompCUV
			 ,@ProductoCompPalanca
			 ,@ProductoCompDetalle
			 ,@ProductoCompApp
			 ,GETDATE()
			)

			set @ProductoCompID = SCOPE_IDENTITY();			
	END
	ELSE
	BEGIN
			select @ProductoCompID = ProductoCompID from [dbo].[ProductoCompartido] where CampaniaID = @ProductoCompCampaniaID 
			and CUV = @ProductoCompCUV and Palanca = @ProductoCompPalanca
	END
END

GO

/*end*/

USE [BelcorpPanama]
GO
/****** Object:  StoredProcedure [dbo].[InsProductoCompartido]    Script Date: 06/01/2017 16:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- InsProductoCompartido 201701,00037,'FAV','/..../../','w'

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.InsProductoCompartido'))
BEGIN
    DROP PROCEDURE dbo.InsProductoCompartido
END

GO

CREATE PROCEDURE [dbo].[InsProductoCompartido]
(
@ProductoCompCampaniaID int,
@ProductoCompCUV varchar(20),
@ProductoCompPalanca varchar(10),
@ProductoCompDetalle varchar(max),
@ProductoCompApp varchar(5),
@ProductoCompID int output
)
as
BEGIN
	if not exists (select 1 from [dbo].[ProductoCompartido] where CampaniaID = @ProductoCompCampaniaID 
	and CUV = @ProductoCompCUV and Palanca = @ProductoCompPalanca)
	BEGIN
		insert into [dbo].[ProductoCompartido]
			(
			  [CampaniaID]
			 ,[CUV]
			 ,[Palanca]
			 ,[Detalle]
			 ,[Applicacion]
			 ,[FechaRegisto]
			)
			values
			(
			  @ProductoCompCampaniaID
			 ,@ProductoCompCUV
			 ,@ProductoCompPalanca
			 ,@ProductoCompDetalle
			 ,@ProductoCompApp
			 ,GETDATE()
			)

			set @ProductoCompID = SCOPE_IDENTITY();			
	END
	ELSE
	BEGIN
			select @ProductoCompID = ProductoCompID from [dbo].[ProductoCompartido] where CampaniaID = @ProductoCompCampaniaID 
			and CUV = @ProductoCompCUV and Palanca = @ProductoCompPalanca
	END
END

GO

/*end*/

USE [BelcorpPeru]
GO
/****** Object:  StoredProcedure [dbo].[InsProductoCompartido]    Script Date: 06/01/2017 16:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- InsProductoCompartido 201701,00037,'FAV','/..../../','w'

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.InsProductoCompartido'))
BEGIN
    DROP PROCEDURE dbo.InsProductoCompartido
END

GO

CREATE PROCEDURE [dbo].[InsProductoCompartido]
(
@ProductoCompCampaniaID int,
@ProductoCompCUV varchar(20),
@ProductoCompPalanca varchar(10),
@ProductoCompDetalle varchar(max),
@ProductoCompApp varchar(5),
@ProductoCompID int output
)
as
BEGIN
	if not exists (select 1 from [dbo].[ProductoCompartido] where CampaniaID = @ProductoCompCampaniaID 
	and CUV = @ProductoCompCUV and Palanca = @ProductoCompPalanca)
	BEGIN
		insert into [dbo].[ProductoCompartido]
			(
			  [CampaniaID]
			 ,[CUV]
			 ,[Palanca]
			 ,[Detalle]
			 ,[Applicacion]
			 ,[FechaRegisto]
			)
			values
			(
			  @ProductoCompCampaniaID
			 ,@ProductoCompCUV
			 ,@ProductoCompPalanca
			 ,@ProductoCompDetalle
			 ,@ProductoCompApp
			 ,GETDATE()
			)

			set @ProductoCompID = SCOPE_IDENTITY();			
	END
	ELSE
	BEGIN
			select @ProductoCompID = ProductoCompID from [dbo].[ProductoCompartido] where CampaniaID = @ProductoCompCampaniaID 
			and CUV = @ProductoCompCUV and Palanca = @ProductoCompPalanca
	END
END

GO

/*end*/

USE [BelcorpPuertoRico]
GO
/****** Object:  StoredProcedure [dbo].[InsProductoCompartido]    Script Date: 06/01/2017 16:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- InsProductoCompartido 201701,00037,'FAV','/..../../','w'

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.InsProductoCompartido'))
BEGIN
    DROP PROCEDURE dbo.InsProductoCompartido
END

GO

CREATE PROCEDURE [dbo].[InsProductoCompartido]
(
@ProductoCompCampaniaID int,
@ProductoCompCUV varchar(20),
@ProductoCompPalanca varchar(10),
@ProductoCompDetalle varchar(max),
@ProductoCompApp varchar(5),
@ProductoCompID int output
)
as
BEGIN
	if not exists (select 1 from [dbo].[ProductoCompartido] where CampaniaID = @ProductoCompCampaniaID 
	and CUV = @ProductoCompCUV and Palanca = @ProductoCompPalanca)
	BEGIN
		insert into [dbo].[ProductoCompartido]
			(
			  [CampaniaID]
			 ,[CUV]
			 ,[Palanca]
			 ,[Detalle]
			 ,[Applicacion]
			 ,[FechaRegisto]
			)
			values
			(
			  @ProductoCompCampaniaID
			 ,@ProductoCompCUV
			 ,@ProductoCompPalanca
			 ,@ProductoCompDetalle
			 ,@ProductoCompApp
			 ,GETDATE()
			)

			set @ProductoCompID = SCOPE_IDENTITY();			
	END
	ELSE
	BEGIN
			select @ProductoCompID = ProductoCompID from [dbo].[ProductoCompartido] where CampaniaID = @ProductoCompCampaniaID 
			and CUV = @ProductoCompCUV and Palanca = @ProductoCompPalanca
	END
END

GO

/*end*/

USE [BelcorpSalvador]
GO
/****** Object:  StoredProcedure [dbo].[InsProductoCompartido]    Script Date: 06/01/2017 16:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- InsProductoCompartido 201701,00037,'FAV','/..../../','w'

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.InsProductoCompartido'))
BEGIN
    DROP PROCEDURE dbo.InsProductoCompartido
END

GO

CREATE PROCEDURE [dbo].[InsProductoCompartido]
(
@ProductoCompCampaniaID int,
@ProductoCompCUV varchar(20),
@ProductoCompPalanca varchar(10),
@ProductoCompDetalle varchar(max),
@ProductoCompApp varchar(5),
@ProductoCompID int output
)
as
BEGIN
	if not exists (select 1 from [dbo].[ProductoCompartido] where CampaniaID = @ProductoCompCampaniaID 
	and CUV = @ProductoCompCUV and Palanca = @ProductoCompPalanca)
	BEGIN
		insert into [dbo].[ProductoCompartido]
			(
			  [CampaniaID]
			 ,[CUV]
			 ,[Palanca]
			 ,[Detalle]
			 ,[Applicacion]
			 ,[FechaRegisto]
			)
			values
			(
			  @ProductoCompCampaniaID
			 ,@ProductoCompCUV
			 ,@ProductoCompPalanca
			 ,@ProductoCompDetalle
			 ,@ProductoCompApp
			 ,GETDATE()
			)

			set @ProductoCompID = SCOPE_IDENTITY();			
	END
	ELSE
	BEGIN
			select @ProductoCompID = ProductoCompID from [dbo].[ProductoCompartido] where CampaniaID = @ProductoCompCampaniaID 
			and CUV = @ProductoCompCUV and Palanca = @ProductoCompPalanca
	END
END

GO

/*end*/

USE [BelcorpVenezuela]
GO
/****** Object:  StoredProcedure [dbo].[InsProductoCompartido]    Script Date: 06/01/2017 16:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- InsProductoCompartido 201701,00037,'FAV','/..../../','w'

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.InsProductoCompartido'))
BEGIN
    DROP PROCEDURE dbo.InsProductoCompartido
END

GO

CREATE PROCEDURE [dbo].[InsProductoCompartido]
(
@ProductoCompCampaniaID int,
@ProductoCompCUV varchar(20),
@ProductoCompPalanca varchar(10),
@ProductoCompDetalle varchar(max),
@ProductoCompApp varchar(5),
@ProductoCompID int output
)
as
BEGIN
	if not exists (select 1 from [dbo].[ProductoCompartido] where CampaniaID = @ProductoCompCampaniaID 
	and CUV = @ProductoCompCUV and Palanca = @ProductoCompPalanca)
	BEGIN
		insert into [dbo].[ProductoCompartido]
			(
			  [CampaniaID]
			 ,[CUV]
			 ,[Palanca]
			 ,[Detalle]
			 ,[Applicacion]
			 ,[FechaRegisto]
			)
			values
			(
			  @ProductoCompCampaniaID
			 ,@ProductoCompCUV
			 ,@ProductoCompPalanca
			 ,@ProductoCompDetalle
			 ,@ProductoCompApp
			 ,GETDATE()
			)

			set @ProductoCompID = SCOPE_IDENTITY();			
	END
	ELSE
	BEGIN
			select @ProductoCompID = ProductoCompID from [dbo].[ProductoCompartido] where CampaniaID = @ProductoCompCampaniaID 
			and CUV = @ProductoCompCUV and Palanca = @ProductoCompPalanca
	END
END


GO



