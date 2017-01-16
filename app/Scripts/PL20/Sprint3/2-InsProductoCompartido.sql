use [BelcorpBolivia]
GO
/****** Object:  StoredProcedure [dbo].[InsProductoCompartido]    Script Date: 06/01/2017 16:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- InsProductoCompartido 201701,00037,'FAV','/..../../','w'

CREATE PROC [dbo].[InsProductoCompartido]
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
	if not exists (select * from [dbo].[ProductoCompartido] where CampaniaID = @ProductoCompCampaniaID 
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
go

use [BelcorpChile]
GO
/****** Object:  StoredProcedure [dbo].[InsProductoCompartido]    Script Date: 06/01/2017 16:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- InsProductoCompartido 201701,00037,'FAV','/..../../','w'

CREATE PROC [dbo].[InsProductoCompartido]
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
	if not exists (select * from [dbo].[ProductoCompartido] where CampaniaID = @ProductoCompCampaniaID 
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
go


use [BelcorpColombia]
GO
/****** Object:  StoredProcedure [dbo].[InsProductoCompartido]    Script Date: 06/01/2017 16:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- InsProductoCompartido 201701,00037,'FAV','/..../../','w'

CREATE PROC [dbo].[InsProductoCompartido]
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
	if not exists (select * from [dbo].[ProductoCompartido] where CampaniaID = @ProductoCompCampaniaID 
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
go



use [BelcorpCostaRica]
GO
/****** Object:  StoredProcedure [dbo].[InsProductoCompartido]    Script Date: 06/01/2017 16:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- InsProductoCompartido 201701,00037,'FAV','/..../../','w'

CREATE PROC [dbo].[InsProductoCompartido]
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
	if not exists (select * from [dbo].[ProductoCompartido] where CampaniaID = @ProductoCompCampaniaID 
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
go



use [BelcorpDominicana]
GO
/****** Object:  StoredProcedure [dbo].[InsProductoCompartido]    Script Date: 06/01/2017 16:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- InsProductoCompartido 201701,00037,'FAV','/..../../','w'

CREATE PROC [dbo].[InsProductoCompartido]
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
	if not exists (select * from [dbo].[ProductoCompartido] where CampaniaID = @ProductoCompCampaniaID 
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
go



use [BelcorpEcuador]
GO
/****** Object:  StoredProcedure [dbo].[InsProductoCompartido]    Script Date: 06/01/2017 16:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- InsProductoCompartido 201701,00037,'FAV','/..../../','w'

CREATE PROC [dbo].[InsProductoCompartido]
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
	if not exists (select * from [dbo].[ProductoCompartido] where CampaniaID = @ProductoCompCampaniaID 
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
go



use [BelcorpGuatemala]
GO
/****** Object:  StoredProcedure [dbo].[InsProductoCompartido]    Script Date: 06/01/2017 16:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- InsProductoCompartido 201701,00037,'FAV','/..../../','w'

CREATE PROC [dbo].[InsProductoCompartido]
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
	if not exists (select * from [dbo].[ProductoCompartido] where CampaniaID = @ProductoCompCampaniaID 
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
go



use [BelcorpMexico]
GO
/****** Object:  StoredProcedure [dbo].[InsProductoCompartido]    Script Date: 06/01/2017 16:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- InsProductoCompartido 201701,00037,'FAV','/..../../','w'

CREATE PROC [dbo].[InsProductoCompartido]
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
	if not exists (select * from [dbo].[ProductoCompartido] where CampaniaID = @ProductoCompCampaniaID 
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
go



use [BelcorpPanama]
GO
/****** Object:  StoredProcedure [dbo].[InsProductoCompartido]    Script Date: 06/01/2017 16:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- InsProductoCompartido 201701,00037,'FAV','/..../../','w'

CREATE PROC [dbo].[InsProductoCompartido]
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
	if not exists (select * from [dbo].[ProductoCompartido] where CampaniaID = @ProductoCompCampaniaID 
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
go



use [BelcorpPeru]
GO
/****** Object:  StoredProcedure [dbo].[InsProductoCompartido]    Script Date: 06/01/2017 16:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- InsProductoCompartido 201701,00037,'FAV','/..../../','w'

CREATE PROC [dbo].[InsProductoCompartido]
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
	if not exists (select * from [dbo].[ProductoCompartido] where CampaniaID = @ProductoCompCampaniaID 
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
go



use [BelcorpPuertoRico]
GO
/****** Object:  StoredProcedure [dbo].[InsProductoCompartido]    Script Date: 06/01/2017 16:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- InsProductoCompartido 201701,00037,'FAV','/..../../','w'

CREATE PROC [dbo].[InsProductoCompartido]
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
	if not exists (select * from [dbo].[ProductoCompartido] where CampaniaID = @ProductoCompCampaniaID 
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
go



use [BelcorpSalvador]
GO
/****** Object:  StoredProcedure [dbo].[InsProductoCompartido]    Script Date: 06/01/2017 16:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- InsProductoCompartido 201701,00037,'FAV','/..../../','w'

CREATE PROC [dbo].[InsProductoCompartido]
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
	if not exists (select * from [dbo].[ProductoCompartido] where CampaniaID = @ProductoCompCampaniaID 
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
go



use [BelcorpVenezuela]
GO
/****** Object:  StoredProcedure [dbo].[InsProductoCompartido]    Script Date: 06/01/2017 16:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- InsProductoCompartido 201701,00037,'FAV','/..../../','w'

CREATE PROC [dbo].[InsProductoCompartido]
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
	if not exists (select * from [dbo].[ProductoCompartido] where CampaniaID = @ProductoCompCampaniaID 
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
go



