USE BelcorpPeru
GO

IF Exists (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.InsBeneficioCaminoBrillante'))
	Drop Proc dbo.InsBeneficioCaminoBrillante
GO
CREATE PROC dbo.InsBeneficioCaminoBrillante
(
@BeneficioID int,
@CodigoBeneficio varchar(15),
@NombreBeneficio varchar(100),
@Descripcion varchar(300),
@UrlIcono varchar(500)
)
AS
BEGIN
if Not Exists (Select 1 from dbo.BeneficioCaminoBrillante where BeneficioID = @BeneficioID and CodigoBeneficio = @CodigoBeneficio)
begin
	insert into dbo.BeneficioCaminoBrillante
		(
			 CodigoBeneficio
			,NombreBeneficio
			,Descripcion
			,UrlIcono
			,FechaRegistro
		) 
		values 
		(
			 @CodigoBeneficio
			,@NombreBeneficio
			,@Descripcion
			,@UrlIcono
			,GetDate()
		)
end
Else
Begin
	Update dbo.BeneficioCaminoBrillante set 
			 NombreBeneficio = @NombreBeneficio
			,Descripcion = @Descripcion
			,UrlIcono = @UrlIcono
			,FechaActualizacion = GetDate()
	where BeneficioID = @BeneficioID and CodigoBeneficio = @CodigoBeneficio
End
END
GO

USE BelcorpMexico
GO

IF Exists (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.InsBeneficioCaminoBrillante'))
	Drop Proc dbo.InsBeneficioCaminoBrillante
GO
CREATE PROC dbo.InsBeneficioCaminoBrillante
(
@BeneficioID int,
@CodigoBeneficio varchar(15),
@NombreBeneficio varchar(100),
@Descripcion varchar(300),
@UrlIcono varchar(500)
)
AS
BEGIN
if Not Exists (Select 1 from dbo.BeneficioCaminoBrillante where BeneficioID = @BeneficioID and CodigoBeneficio = @CodigoBeneficio)
begin
	insert into dbo.BeneficioCaminoBrillante
		(
			 CodigoBeneficio
			,NombreBeneficio
			,Descripcion
			,UrlIcono
			,FechaRegistro
		) 
		values 
		(
			 @CodigoBeneficio
			,@NombreBeneficio
			,@Descripcion
			,@UrlIcono
			,GetDate()
		)
end
Else
Begin
	Update dbo.BeneficioCaminoBrillante set 
			 NombreBeneficio = @NombreBeneficio
			,Descripcion = @Descripcion
			,UrlIcono = @UrlIcono
			,FechaActualizacion = GetDate()
	where BeneficioID = @BeneficioID and CodigoBeneficio = @CodigoBeneficio
End
END
GO

USE BelcorpColombia
GO

IF Exists (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.InsBeneficioCaminoBrillante'))
	Drop Proc dbo.InsBeneficioCaminoBrillante
GO
CREATE PROC dbo.InsBeneficioCaminoBrillante
(
@BeneficioID int,
@CodigoBeneficio varchar(15),
@NombreBeneficio varchar(100),
@Descripcion varchar(300),
@UrlIcono varchar(500)
)
AS
BEGIN
if Not Exists (Select 1 from dbo.BeneficioCaminoBrillante where BeneficioID = @BeneficioID and CodigoBeneficio = @CodigoBeneficio)
begin
	insert into dbo.BeneficioCaminoBrillante
		(
			 CodigoBeneficio
			,NombreBeneficio
			,Descripcion
			,UrlIcono
			,FechaRegistro
		) 
		values 
		(
			 @CodigoBeneficio
			,@NombreBeneficio
			,@Descripcion
			,@UrlIcono
			,GetDate()
		)
end
Else
Begin
	Update dbo.BeneficioCaminoBrillante set 
			 NombreBeneficio = @NombreBeneficio
			,Descripcion = @Descripcion
			,UrlIcono = @UrlIcono
			,FechaActualizacion = GetDate()
	where BeneficioID = @BeneficioID and CodigoBeneficio = @CodigoBeneficio
End
END
GO

USE BelcorpSalvador
GO

IF Exists (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.InsBeneficioCaminoBrillante'))
	Drop Proc dbo.InsBeneficioCaminoBrillante
GO
CREATE PROC dbo.InsBeneficioCaminoBrillante
(
@BeneficioID int,
@CodigoBeneficio varchar(15),
@NombreBeneficio varchar(100),
@Descripcion varchar(300),
@UrlIcono varchar(500)
)
AS
BEGIN
if Not Exists (Select 1 from dbo.BeneficioCaminoBrillante where BeneficioID = @BeneficioID and CodigoBeneficio = @CodigoBeneficio)
begin
	insert into dbo.BeneficioCaminoBrillante
		(
			 CodigoBeneficio
			,NombreBeneficio
			,Descripcion
			,UrlIcono
			,FechaRegistro
		) 
		values 
		(
			 @CodigoBeneficio
			,@NombreBeneficio
			,@Descripcion
			,@UrlIcono
			,GetDate()
		)
end
Else
Begin
	Update dbo.BeneficioCaminoBrillante set 
			 NombreBeneficio = @NombreBeneficio
			,Descripcion = @Descripcion
			,UrlIcono = @UrlIcono
			,FechaActualizacion = GetDate()
	where BeneficioID = @BeneficioID and CodigoBeneficio = @CodigoBeneficio
End
END
GO

USE BelcorpPuertoRico
GO

IF Exists (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.InsBeneficioCaminoBrillante'))
	Drop Proc dbo.InsBeneficioCaminoBrillante
GO
CREATE PROC dbo.InsBeneficioCaminoBrillante
(
@BeneficioID int,
@CodigoBeneficio varchar(15),
@NombreBeneficio varchar(100),
@Descripcion varchar(300),
@UrlIcono varchar(500)
)
AS
BEGIN
if Not Exists (Select 1 from dbo.BeneficioCaminoBrillante where BeneficioID = @BeneficioID and CodigoBeneficio = @CodigoBeneficio)
begin
	insert into dbo.BeneficioCaminoBrillante
		(
			 CodigoBeneficio
			,NombreBeneficio
			,Descripcion
			,UrlIcono
			,FechaRegistro
		) 
		values 
		(
			 @CodigoBeneficio
			,@NombreBeneficio
			,@Descripcion
			,@UrlIcono
			,GetDate()
		)
end
Else
Begin
	Update dbo.BeneficioCaminoBrillante set 
			 NombreBeneficio = @NombreBeneficio
			,Descripcion = @Descripcion
			,UrlIcono = @UrlIcono
			,FechaActualizacion = GetDate()
	where BeneficioID = @BeneficioID and CodigoBeneficio = @CodigoBeneficio
End
END
GO

USE BelcorpPanama
GO

IF Exists (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.InsBeneficioCaminoBrillante'))
	Drop Proc dbo.InsBeneficioCaminoBrillante
GO
CREATE PROC dbo.InsBeneficioCaminoBrillante
(
@BeneficioID int,
@CodigoBeneficio varchar(15),
@NombreBeneficio varchar(100),
@Descripcion varchar(300),
@UrlIcono varchar(500)
)
AS
BEGIN
if Not Exists (Select 1 from dbo.BeneficioCaminoBrillante where BeneficioID = @BeneficioID and CodigoBeneficio = @CodigoBeneficio)
begin
	insert into dbo.BeneficioCaminoBrillante
		(
			 CodigoBeneficio
			,NombreBeneficio
			,Descripcion
			,UrlIcono
			,FechaRegistro
		) 
		values 
		(
			 @CodigoBeneficio
			,@NombreBeneficio
			,@Descripcion
			,@UrlIcono
			,GetDate()
		)
end
Else
Begin
	Update dbo.BeneficioCaminoBrillante set 
			 NombreBeneficio = @NombreBeneficio
			,Descripcion = @Descripcion
			,UrlIcono = @UrlIcono
			,FechaActualizacion = GetDate()
	where BeneficioID = @BeneficioID and CodigoBeneficio = @CodigoBeneficio
End
END
GO

USE BelcorpGuatemala
GO

IF Exists (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.InsBeneficioCaminoBrillante'))
	Drop Proc dbo.InsBeneficioCaminoBrillante
GO
CREATE PROC dbo.InsBeneficioCaminoBrillante
(
@BeneficioID int,
@CodigoBeneficio varchar(15),
@NombreBeneficio varchar(100),
@Descripcion varchar(300),
@UrlIcono varchar(500)
)
AS
BEGIN
if Not Exists (Select 1 from dbo.BeneficioCaminoBrillante where BeneficioID = @BeneficioID and CodigoBeneficio = @CodigoBeneficio)
begin
	insert into dbo.BeneficioCaminoBrillante
		(
			 CodigoBeneficio
			,NombreBeneficio
			,Descripcion
			,UrlIcono
			,FechaRegistro
		) 
		values 
		(
			 @CodigoBeneficio
			,@NombreBeneficio
			,@Descripcion
			,@UrlIcono
			,GetDate()
		)
end
Else
Begin
	Update dbo.BeneficioCaminoBrillante set 
			 NombreBeneficio = @NombreBeneficio
			,Descripcion = @Descripcion
			,UrlIcono = @UrlIcono
			,FechaActualizacion = GetDate()
	where BeneficioID = @BeneficioID and CodigoBeneficio = @CodigoBeneficio
End
END
GO

USE BelcorpEcuador
GO

IF Exists (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.InsBeneficioCaminoBrillante'))
	Drop Proc dbo.InsBeneficioCaminoBrillante
GO
CREATE PROC dbo.InsBeneficioCaminoBrillante
(
@BeneficioID int,
@CodigoBeneficio varchar(15),
@NombreBeneficio varchar(100),
@Descripcion varchar(300),
@UrlIcono varchar(500)
)
AS
BEGIN
if Not Exists (Select 1 from dbo.BeneficioCaminoBrillante where BeneficioID = @BeneficioID and CodigoBeneficio = @CodigoBeneficio)
begin
	insert into dbo.BeneficioCaminoBrillante
		(
			 CodigoBeneficio
			,NombreBeneficio
			,Descripcion
			,UrlIcono
			,FechaRegistro
		) 
		values 
		(
			 @CodigoBeneficio
			,@NombreBeneficio
			,@Descripcion
			,@UrlIcono
			,GetDate()
		)
end
Else
Begin
	Update dbo.BeneficioCaminoBrillante set 
			 NombreBeneficio = @NombreBeneficio
			,Descripcion = @Descripcion
			,UrlIcono = @UrlIcono
			,FechaActualizacion = GetDate()
	where BeneficioID = @BeneficioID and CodigoBeneficio = @CodigoBeneficio
End
END
GO

USE BelcorpDominicana
GO

IF Exists (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.InsBeneficioCaminoBrillante'))
	Drop Proc dbo.InsBeneficioCaminoBrillante
GO
CREATE PROC dbo.InsBeneficioCaminoBrillante
(
@BeneficioID int,
@CodigoBeneficio varchar(15),
@NombreBeneficio varchar(100),
@Descripcion varchar(300),
@UrlIcono varchar(500)
)
AS
BEGIN
if Not Exists (Select 1 from dbo.BeneficioCaminoBrillante where BeneficioID = @BeneficioID and CodigoBeneficio = @CodigoBeneficio)
begin
	insert into dbo.BeneficioCaminoBrillante
		(
			 CodigoBeneficio
			,NombreBeneficio
			,Descripcion
			,UrlIcono
			,FechaRegistro
		) 
		values 
		(
			 @CodigoBeneficio
			,@NombreBeneficio
			,@Descripcion
			,@UrlIcono
			,GetDate()
		)
end
Else
Begin
	Update dbo.BeneficioCaminoBrillante set 
			 NombreBeneficio = @NombreBeneficio
			,Descripcion = @Descripcion
			,UrlIcono = @UrlIcono
			,FechaActualizacion = GetDate()
	where BeneficioID = @BeneficioID and CodigoBeneficio = @CodigoBeneficio
End
END
GO

USE BelcorpCostaRica
GO

IF Exists (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.InsBeneficioCaminoBrillante'))
	Drop Proc dbo.InsBeneficioCaminoBrillante
GO
CREATE PROC dbo.InsBeneficioCaminoBrillante
(
@BeneficioID int,
@CodigoBeneficio varchar(15),
@NombreBeneficio varchar(100),
@Descripcion varchar(300),
@UrlIcono varchar(500)
)
AS
BEGIN
if Not Exists (Select 1 from dbo.BeneficioCaminoBrillante where BeneficioID = @BeneficioID and CodigoBeneficio = @CodigoBeneficio)
begin
	insert into dbo.BeneficioCaminoBrillante
		(
			 CodigoBeneficio
			,NombreBeneficio
			,Descripcion
			,UrlIcono
			,FechaRegistro
		) 
		values 
		(
			 @CodigoBeneficio
			,@NombreBeneficio
			,@Descripcion
			,@UrlIcono
			,GetDate()
		)
end
Else
Begin
	Update dbo.BeneficioCaminoBrillante set 
			 NombreBeneficio = @NombreBeneficio
			,Descripcion = @Descripcion
			,UrlIcono = @UrlIcono
			,FechaActualizacion = GetDate()
	where BeneficioID = @BeneficioID and CodigoBeneficio = @CodigoBeneficio
End
END
GO

USE BelcorpChile
GO

IF Exists (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.InsBeneficioCaminoBrillante'))
	Drop Proc dbo.InsBeneficioCaminoBrillante
GO
CREATE PROC dbo.InsBeneficioCaminoBrillante
(
@BeneficioID int,
@CodigoBeneficio varchar(15),
@NombreBeneficio varchar(100),
@Descripcion varchar(300),
@UrlIcono varchar(500)
)
AS
BEGIN
if Not Exists (Select 1 from dbo.BeneficioCaminoBrillante where BeneficioID = @BeneficioID and CodigoBeneficio = @CodigoBeneficio)
begin
	insert into dbo.BeneficioCaminoBrillante
		(
			 CodigoBeneficio
			,NombreBeneficio
			,Descripcion
			,UrlIcono
			,FechaRegistro
		) 
		values 
		(
			 @CodigoBeneficio
			,@NombreBeneficio
			,@Descripcion
			,@UrlIcono
			,GetDate()
		)
end
Else
Begin
	Update dbo.BeneficioCaminoBrillante set 
			 NombreBeneficio = @NombreBeneficio
			,Descripcion = @Descripcion
			,UrlIcono = @UrlIcono
			,FechaActualizacion = GetDate()
	where BeneficioID = @BeneficioID and CodigoBeneficio = @CodigoBeneficio
End
END
GO

USE BelcorpBolivia
GO

IF Exists (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.InsBeneficioCaminoBrillante'))
	Drop Proc dbo.InsBeneficioCaminoBrillante
GO
CREATE PROC dbo.InsBeneficioCaminoBrillante
(
@BeneficioID int,
@CodigoBeneficio varchar(15),
@NombreBeneficio varchar(100),
@Descripcion varchar(300),
@UrlIcono varchar(500)
)
AS
BEGIN
if Not Exists (Select 1 from dbo.BeneficioCaminoBrillante where BeneficioID = @BeneficioID and CodigoBeneficio = @CodigoBeneficio)
begin
	insert into dbo.BeneficioCaminoBrillante
		(
			 CodigoBeneficio
			,NombreBeneficio
			,Descripcion
			,UrlIcono
			,FechaRegistro
		) 
		values 
		(
			 @CodigoBeneficio
			,@NombreBeneficio
			,@Descripcion
			,@UrlIcono
			,GetDate()
		)
end
Else
Begin
	Update dbo.BeneficioCaminoBrillante set 
			 NombreBeneficio = @NombreBeneficio
			,Descripcion = @Descripcion
			,UrlIcono = @UrlIcono
			,FechaActualizacion = GetDate()
	where BeneficioID = @BeneficioID and CodigoBeneficio = @CodigoBeneficio
End
END
GO

