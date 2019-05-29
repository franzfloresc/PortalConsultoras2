USE BelcorpPeru
GO

ALTER PROCEDURE dbo.GetConsultoraDatoSAC(
@paisID VARCHAR(3),
@codigoConsultora VARCHAR(20) = NULL,
@documento VARCHAR(30) = NULL)
AS
BEGIN
SET NOCOUNT ON;
BEGIN
	declare @codigoConsultora2 VARCHAR(20)
	declare @consultoraID bigint
	declare @CampaniaID int
	declare @CampaniaAnterior int
	declare @ZonaID int
	declare @RegionID int
	declare @PaisID2 int

	set @PaisID2 = convert(int,isnull(@paisID,'0'))
	select @codigoConsultora2 =C.Codigo 
		,@consultoraID =C.ConsultoraID
		,@ZonaID = IsNull(C.ZonaID,0)
		,@RegionID = IsNull(C.RegionID,0)
		,@ConsultoraID = IsNull(C.ConsultoraID,0) 
	from ods.consultora C with(nolock) 
		inner join ods.Identificacion AS I ON I.ConsultoraID = C.ConsultoraID AND I.DocumentoPrincipal = '1'  
	where ISNULL(C.codigo,'-1') = (CASE When ISNULL(@codigoConsultora,'-1')='-1' THEN ISNULL(C.codigo,'-1') ELSE @codigoConsultora END)
		and ISNULL(I.Numero,'-1') = (CASE When ISNULL(@documento,'-1')='-1' THEN ISNULL(I.Numero,'-1') ELSE @documento END)

	select @CampaniaID = campaniaId from dbo.GetCampaniaPreLogin(@PaisID2,@ZonaID,@RegionID,@ConsultoraID)
	exec GetCampaniaAnterior @CampaniaID,18,1,@CampaniaAnterior OUT;
	
	SELECT 
	top 1
		C.ConsultoraID as consultoraID, 
		C.Codigo AS codigo, 
		R.Codigo AS region,
		S.Codigo AS seccion,
		Z.Codigo AS zona,
		C.NombreCompleto as nombreCompleto,
		CONVERT(VARCHAR(10), C.FechaNacimiento, 103) as  fechaNacimiento,
		C.EstadoCivil as estadoCivil,
		U.Email as email,
		U.Telefono as telefono1,
		U.Celular as telefono2,
		ISNULL(D.Direccion,D.DireccionLinea1) direccionDomicilio,
		ISNULL(D2.Direccion,D2.DireccionLinea1) direccionEntrega,
		validoEmail = case U.EMailActivo when 1 then 'SI' else 'NO' end,
		ofertaWeb = case OW.OfertaWeb when 1 then 'SI' else 'NO' end,
		cataloVirtual = case isnull(CC.CodigoConsultora,0) when 0 then 'NO' else 'SI' end
	FROM [dbo].[Usuario] u with(nolock)
		LEFT JOIN (select top 1 * from ods.consultora with(nolock) where codigo = @codigoConsultora2 ) C ON u.CodigoConsultora = c.Codigo
		left join (select top 1 Direccion,ConsultoraID,DireccionLinea1 from ods.Direccion with(nolock) where TipoDireccion = 'Domicilio' and estadoActivo = 1 and ConsultoraID = @consultoraID) D on D.ConsultoraID = C.ConsultoraID 
		left join (select top 1 Direccion,ConsultoraID,DireccionLinea1 from ods.Direccion with(nolock) where TipoDireccion <> 'Domicilio' and estadoActivo = 1 and ConsultoraID = @consultoraID) D2 on D2.ConsultoraID = C.ConsultoraID 
		INNER JOIN ods.Seccion AS S ON C.SeccionID = S.SeccionID 
		INNER JOIN ods.Zona AS Z  ON S.ZonaID = Z.ZonaID 
		INNER JOIN ods.Region AS R ON Z.RegionID = R.RegionID
		LEFT JOIN ods.Identificacion AS I ON I.ConsultoraID = C.ConsultoraID AND I.DocumentoPrincipal = '1'  
		left join (select top 1 OfertaWeb,ConsultoraId from dbo.PedidoWebDetalle where OfertaWeb = 1 and ConsultoraID = @consultoraID and CampaniaID = @CampaniaAnterior) OW on OW.ConsultoraID = C.ConsultoraID
		left join (select top 1 CodigoConsultora from dbo.CatalogoCampania where CodigoConsultora = @codigoConsultora2  and CodigoCampania = @CampaniaID) CC on CC.CodigoConsultora = U.CodigoConsultora
	WHERE ISNULL(u.CodigoConsultora,'-1') = (CASE When ISNULL(@codigoConsultora2,'-1')='-1' THEN ISNULL(u.CodigoConsultora,'-1') ELSE @codigoConsultora2 END)
END
END


GO

USE BelcorpMexico
GO

ALTER PROCEDURE dbo.GetConsultoraDatoSAC(
@paisID VARCHAR(3),
@codigoConsultora VARCHAR(20) = NULL,
@documento VARCHAR(30) = NULL)
AS
BEGIN
SET NOCOUNT ON;
BEGIN
	declare @codigoConsultora2 VARCHAR(20)
	declare @consultoraID bigint
	declare @CampaniaID int
	declare @CampaniaAnterior int
	declare @ZonaID int
	declare @RegionID int
	declare @PaisID2 int

	set @PaisID2 = convert(int,isnull(@paisID,'0'))
	select @codigoConsultora2 =C.Codigo 
		,@consultoraID =C.ConsultoraID
		,@ZonaID = IsNull(C.ZonaID,0)
		,@RegionID = IsNull(C.RegionID,0)
		,@ConsultoraID = IsNull(C.ConsultoraID,0) 
	from ods.consultora C with(nolock) 
		inner join ods.Identificacion AS I ON I.ConsultoraID = C.ConsultoraID AND I.DocumentoPrincipal = '1'  
	where ISNULL(C.codigo,'-1') = (CASE When ISNULL(@codigoConsultora,'-1')='-1' THEN ISNULL(C.codigo,'-1') ELSE @codigoConsultora END)
		and ISNULL(I.Numero,'-1') = (CASE When ISNULL(@documento,'-1')='-1' THEN ISNULL(I.Numero,'-1') ELSE @documento END)

	select @CampaniaID = campaniaId from dbo.GetCampaniaPreLogin(@PaisID2,@ZonaID,@RegionID,@ConsultoraID)
	exec GetCampaniaAnterior @CampaniaID,18,1,@CampaniaAnterior OUT;
	
	SELECT 
	top 1
		C.ConsultoraID as consultoraID, 
		C.Codigo AS codigo, 
		R.Codigo AS region,
		S.Codigo AS seccion,
		Z.Codigo AS zona,
		C.NombreCompleto as nombreCompleto,
		CONVERT(VARCHAR(10), C.FechaNacimiento, 103) as  fechaNacimiento,
		C.EstadoCivil as estadoCivil,
		U.Email as email,
		U.Telefono as telefono1,
		U.Celular as telefono2,
		ISNULL(D.Direccion,D.DireccionLinea1) direccionDomicilio,
		ISNULL(D2.Direccion,D2.DireccionLinea1) direccionEntrega,
		validoEmail = case U.EMailActivo when 1 then 'SI' else 'NO' end,
		ofertaWeb = case OW.OfertaWeb when 1 then 'SI' else 'NO' end,
		cataloVirtual = case isnull(CC.CodigoConsultora,0) when 0 then 'NO' else 'SI' end
	FROM [dbo].[Usuario] u with(nolock)
		LEFT JOIN (select top 1 * from ods.consultora with(nolock) where codigo = @codigoConsultora2 ) C ON u.CodigoConsultora = c.Codigo
		left join (select top 1 Direccion,ConsultoraID,DireccionLinea1 from ods.Direccion with(nolock) where TipoDireccion = 'Domicilio' and estadoActivo = 1 and ConsultoraID = @consultoraID) D on D.ConsultoraID = C.ConsultoraID 
		left join (select top 1 Direccion,ConsultoraID,DireccionLinea1 from ods.Direccion with(nolock) where TipoDireccion <> 'Domicilio' and estadoActivo = 1 and ConsultoraID = @consultoraID) D2 on D2.ConsultoraID = C.ConsultoraID 
		INNER JOIN ods.Seccion AS S ON C.SeccionID = S.SeccionID 
		INNER JOIN ods.Zona AS Z  ON S.ZonaID = Z.ZonaID 
		INNER JOIN ods.Region AS R ON Z.RegionID = R.RegionID
		LEFT JOIN ods.Identificacion AS I ON I.ConsultoraID = C.ConsultoraID AND I.DocumentoPrincipal = '1'  
		left join (select top 1 OfertaWeb,ConsultoraId from dbo.PedidoWebDetalle where OfertaWeb = 1 and ConsultoraID = @consultoraID and CampaniaID = @CampaniaAnterior) OW on OW.ConsultoraID = C.ConsultoraID
		left join (select top 1 CodigoConsultora from dbo.CatalogoCampania where CodigoConsultora = @codigoConsultora2  and CodigoCampania = @CampaniaID) CC on CC.CodigoConsultora = U.CodigoConsultora
	WHERE ISNULL(u.CodigoConsultora,'-1') = (CASE When ISNULL(@codigoConsultora2,'-1')='-1' THEN ISNULL(u.CodigoConsultora,'-1') ELSE @codigoConsultora2 END)
END
END


GO

USE BelcorpColombia
GO

ALTER PROCEDURE dbo.GetConsultoraDatoSAC(
@paisID VARCHAR(3),
@codigoConsultora VARCHAR(20) = NULL,
@documento VARCHAR(30) = NULL)
AS
BEGIN
SET NOCOUNT ON;
BEGIN
	declare @codigoConsultora2 VARCHAR(20)
	declare @consultoraID bigint
	declare @CampaniaID int
	declare @CampaniaAnterior int
	declare @ZonaID int
	declare @RegionID int
	declare @PaisID2 int

	set @PaisID2 = convert(int,isnull(@paisID,'0'))
	select @codigoConsultora2 =C.Codigo 
		,@consultoraID =C.ConsultoraID
		,@ZonaID = IsNull(C.ZonaID,0)
		,@RegionID = IsNull(C.RegionID,0)
		,@ConsultoraID = IsNull(C.ConsultoraID,0) 
	from ods.consultora C with(nolock) 
		inner join ods.Identificacion AS I ON I.ConsultoraID = C.ConsultoraID AND I.DocumentoPrincipal = '1'  
	where ISNULL(C.codigo,'-1') = (CASE When ISNULL(@codigoConsultora,'-1')='-1' THEN ISNULL(C.codigo,'-1') ELSE @codigoConsultora END)
		and ISNULL(I.Numero,'-1') = (CASE When ISNULL(@documento,'-1')='-1' THEN ISNULL(I.Numero,'-1') ELSE @documento END)

	select @CampaniaID = campaniaId from dbo.GetCampaniaPreLogin(@PaisID2,@ZonaID,@RegionID,@ConsultoraID)
	exec GetCampaniaAnterior @CampaniaID,18,1,@CampaniaAnterior OUT;
	
	SELECT 
	top 1
		C.ConsultoraID as consultoraID, 
		C.Codigo AS codigo, 
		R.Codigo AS region,
		S.Codigo AS seccion,
		Z.Codigo AS zona,
		C.NombreCompleto as nombreCompleto,
		CONVERT(VARCHAR(10), C.FechaNacimiento, 103) as  fechaNacimiento,
		C.EstadoCivil as estadoCivil,
		U.Email as email,
		U.Telefono as telefono1,
		U.Celular as telefono2,
		ISNULL(D.Direccion,D.DireccionLinea1) direccionDomicilio,
		ISNULL(D2.Direccion,D2.DireccionLinea1) direccionEntrega,
		validoEmail = case U.EMailActivo when 1 then 'SI' else 'NO' end,
		ofertaWeb = case OW.OfertaWeb when 1 then 'SI' else 'NO' end,
		cataloVirtual = case isnull(CC.CodigoConsultora,0) when 0 then 'NO' else 'SI' end
	FROM [dbo].[Usuario] u with(nolock)
		LEFT JOIN (select top 1 * from ods.consultora with(nolock) where codigo = @codigoConsultora2 ) C ON u.CodigoConsultora = c.Codigo
		left join (select top 1 Direccion,ConsultoraID,DireccionLinea1 from ods.Direccion with(nolock) where TipoDireccion = 'Domicilio' and estadoActivo = 1 and ConsultoraID = @consultoraID) D on D.ConsultoraID = C.ConsultoraID 
		left join (select top 1 Direccion,ConsultoraID,DireccionLinea1 from ods.Direccion with(nolock) where TipoDireccion <> 'Domicilio' and estadoActivo = 1 and ConsultoraID = @consultoraID) D2 on D2.ConsultoraID = C.ConsultoraID 
		INNER JOIN ods.Seccion AS S ON C.SeccionID = S.SeccionID 
		INNER JOIN ods.Zona AS Z  ON S.ZonaID = Z.ZonaID 
		INNER JOIN ods.Region AS R ON Z.RegionID = R.RegionID
		LEFT JOIN ods.Identificacion AS I ON I.ConsultoraID = C.ConsultoraID AND I.DocumentoPrincipal = '1'  
		left join (select top 1 OfertaWeb,ConsultoraId from dbo.PedidoWebDetalle where OfertaWeb = 1 and ConsultoraID = @consultoraID and CampaniaID = @CampaniaAnterior) OW on OW.ConsultoraID = C.ConsultoraID
		left join (select top 1 CodigoConsultora from dbo.CatalogoCampania where CodigoConsultora = @codigoConsultora2  and CodigoCampania = @CampaniaID) CC on CC.CodigoConsultora = U.CodigoConsultora
	WHERE ISNULL(u.CodigoConsultora,'-1') = (CASE When ISNULL(@codigoConsultora2,'-1')='-1' THEN ISNULL(u.CodigoConsultora,'-1') ELSE @codigoConsultora2 END)
END
END


GO

USE BelcorpSalvador
GO

ALTER PROCEDURE dbo.GetConsultoraDatoSAC(
@paisID VARCHAR(3),
@codigoConsultora VARCHAR(20) = NULL,
@documento VARCHAR(30) = NULL)
AS
BEGIN
SET NOCOUNT ON;
BEGIN
	declare @codigoConsultora2 VARCHAR(20)
	declare @consultoraID bigint
	declare @CampaniaID int
	declare @CampaniaAnterior int
	declare @ZonaID int
	declare @RegionID int
	declare @PaisID2 int

	set @PaisID2 = convert(int,isnull(@paisID,'0'))
	select @codigoConsultora2 =C.Codigo 
		,@consultoraID =C.ConsultoraID
		,@ZonaID = IsNull(C.ZonaID,0)
		,@RegionID = IsNull(C.RegionID,0)
		,@ConsultoraID = IsNull(C.ConsultoraID,0) 
	from ods.consultora C with(nolock) 
		inner join ods.Identificacion AS I ON I.ConsultoraID = C.ConsultoraID AND I.DocumentoPrincipal = '1'  
	where ISNULL(C.codigo,'-1') = (CASE When ISNULL(@codigoConsultora,'-1')='-1' THEN ISNULL(C.codigo,'-1') ELSE @codigoConsultora END)
		and ISNULL(I.Numero,'-1') = (CASE When ISNULL(@documento,'-1')='-1' THEN ISNULL(I.Numero,'-1') ELSE @documento END)

	select @CampaniaID = campaniaId from dbo.GetCampaniaPreLogin(@PaisID2,@ZonaID,@RegionID,@ConsultoraID)
	exec GetCampaniaAnterior @CampaniaID,18,1,@CampaniaAnterior OUT;
	
	SELECT 
	top 1
		C.ConsultoraID as consultoraID, 
		C.Codigo AS codigo, 
		R.Codigo AS region,
		S.Codigo AS seccion,
		Z.Codigo AS zona,
		C.NombreCompleto as nombreCompleto,
		CONVERT(VARCHAR(10), C.FechaNacimiento, 103) as  fechaNacimiento,
		C.EstadoCivil as estadoCivil,
		U.Email as email,
		U.Telefono as telefono1,
		U.Celular as telefono2,
		ISNULL(D.Direccion,D.DireccionLinea1) direccionDomicilio,
		ISNULL(D2.Direccion,D2.DireccionLinea1) direccionEntrega,
		validoEmail = case U.EMailActivo when 1 then 'SI' else 'NO' end,
		ofertaWeb = case OW.OfertaWeb when 1 then 'SI' else 'NO' end,
		cataloVirtual = case isnull(CC.CodigoConsultora,0) when 0 then 'NO' else 'SI' end
	FROM [dbo].[Usuario] u with(nolock)
		LEFT JOIN (select top 1 * from ods.consultora with(nolock) where codigo = @codigoConsultora2 ) C ON u.CodigoConsultora = c.Codigo
		left join (select top 1 Direccion,ConsultoraID,DireccionLinea1 from ods.Direccion with(nolock) where TipoDireccion = 'Domicilio' and estadoActivo = 1 and ConsultoraID = @consultoraID) D on D.ConsultoraID = C.ConsultoraID 
		left join (select top 1 Direccion,ConsultoraID,DireccionLinea1 from ods.Direccion with(nolock) where TipoDireccion <> 'Domicilio' and estadoActivo = 1 and ConsultoraID = @consultoraID) D2 on D2.ConsultoraID = C.ConsultoraID 
		INNER JOIN ods.Seccion AS S ON C.SeccionID = S.SeccionID 
		INNER JOIN ods.Zona AS Z  ON S.ZonaID = Z.ZonaID 
		INNER JOIN ods.Region AS R ON Z.RegionID = R.RegionID
		LEFT JOIN ods.Identificacion AS I ON I.ConsultoraID = C.ConsultoraID AND I.DocumentoPrincipal = '1'  
		left join (select top 1 OfertaWeb,ConsultoraId from dbo.PedidoWebDetalle where OfertaWeb = 1 and ConsultoraID = @consultoraID and CampaniaID = @CampaniaAnterior) OW on OW.ConsultoraID = C.ConsultoraID
		left join (select top 1 CodigoConsultora from dbo.CatalogoCampania where CodigoConsultora = @codigoConsultora2  and CodigoCampania = @CampaniaID) CC on CC.CodigoConsultora = U.CodigoConsultora
	WHERE ISNULL(u.CodigoConsultora,'-1') = (CASE When ISNULL(@codigoConsultora2,'-1')='-1' THEN ISNULL(u.CodigoConsultora,'-1') ELSE @codigoConsultora2 END)
END
END


GO

USE BelcorpPuertoRico
GO

ALTER PROCEDURE dbo.GetConsultoraDatoSAC(
@paisID VARCHAR(3),
@codigoConsultora VARCHAR(20) = NULL,
@documento VARCHAR(30) = NULL)
AS
BEGIN
SET NOCOUNT ON;
BEGIN
	declare @codigoConsultora2 VARCHAR(20)
	declare @consultoraID bigint
	declare @CampaniaID int
	declare @CampaniaAnterior int
	declare @ZonaID int
	declare @RegionID int
	declare @PaisID2 int

	set @PaisID2 = convert(int,isnull(@paisID,'0'))
	select @codigoConsultora2 =C.Codigo 
		,@consultoraID =C.ConsultoraID
		,@ZonaID = IsNull(C.ZonaID,0)
		,@RegionID = IsNull(C.RegionID,0)
		,@ConsultoraID = IsNull(C.ConsultoraID,0) 
	from ods.consultora C with(nolock) 
		inner join ods.Identificacion AS I ON I.ConsultoraID = C.ConsultoraID AND I.DocumentoPrincipal = '1'  
	where ISNULL(C.codigo,'-1') = (CASE When ISNULL(@codigoConsultora,'-1')='-1' THEN ISNULL(C.codigo,'-1') ELSE @codigoConsultora END)
		and ISNULL(I.Numero,'-1') = (CASE When ISNULL(@documento,'-1')='-1' THEN ISNULL(I.Numero,'-1') ELSE @documento END)

	select @CampaniaID = campaniaId from dbo.GetCampaniaPreLogin(@PaisID2,@ZonaID,@RegionID,@ConsultoraID)
	exec GetCampaniaAnterior @CampaniaID,18,1,@CampaniaAnterior OUT;
	
	SELECT 
	top 1
		C.ConsultoraID as consultoraID, 
		C.Codigo AS codigo, 
		R.Codigo AS region,
		S.Codigo AS seccion,
		Z.Codigo AS zona,
		C.NombreCompleto as nombreCompleto,
		CONVERT(VARCHAR(10), C.FechaNacimiento, 103) as  fechaNacimiento,
		C.EstadoCivil as estadoCivil,
		U.Email as email,
		U.Telefono as telefono1,
		U.Celular as telefono2,
		ISNULL(D.Direccion,D.DireccionLinea1) direccionDomicilio,
		ISNULL(D2.Direccion,D2.DireccionLinea1) direccionEntrega,
		validoEmail = case U.EMailActivo when 1 then 'SI' else 'NO' end,
		ofertaWeb = case OW.OfertaWeb when 1 then 'SI' else 'NO' end,
		cataloVirtual = case isnull(CC.CodigoConsultora,0) when 0 then 'NO' else 'SI' end
	FROM [dbo].[Usuario] u with(nolock)
		LEFT JOIN (select top 1 * from ods.consultora with(nolock) where codigo = @codigoConsultora2 ) C ON u.CodigoConsultora = c.Codigo
		left join (select top 1 Direccion,ConsultoraID,DireccionLinea1 from ods.Direccion with(nolock) where TipoDireccion = 'Domicilio' and estadoActivo = 1 and ConsultoraID = @consultoraID) D on D.ConsultoraID = C.ConsultoraID 
		left join (select top 1 Direccion,ConsultoraID,DireccionLinea1 from ods.Direccion with(nolock) where TipoDireccion <> 'Domicilio' and estadoActivo = 1 and ConsultoraID = @consultoraID) D2 on D2.ConsultoraID = C.ConsultoraID 
		INNER JOIN ods.Seccion AS S ON C.SeccionID = S.SeccionID 
		INNER JOIN ods.Zona AS Z  ON S.ZonaID = Z.ZonaID 
		INNER JOIN ods.Region AS R ON Z.RegionID = R.RegionID
		LEFT JOIN ods.Identificacion AS I ON I.ConsultoraID = C.ConsultoraID AND I.DocumentoPrincipal = '1'  
		left join (select top 1 OfertaWeb,ConsultoraId from dbo.PedidoWebDetalle where OfertaWeb = 1 and ConsultoraID = @consultoraID and CampaniaID = @CampaniaAnterior) OW on OW.ConsultoraID = C.ConsultoraID
		left join (select top 1 CodigoConsultora from dbo.CatalogoCampania where CodigoConsultora = @codigoConsultora2  and CodigoCampania = @CampaniaID) CC on CC.CodigoConsultora = U.CodigoConsultora
	WHERE ISNULL(u.CodigoConsultora,'-1') = (CASE When ISNULL(@codigoConsultora2,'-1')='-1' THEN ISNULL(u.CodigoConsultora,'-1') ELSE @codigoConsultora2 END)
END
END


GO

USE BelcorpPanama
GO

ALTER PROCEDURE dbo.GetConsultoraDatoSAC(
@paisID VARCHAR(3),
@codigoConsultora VARCHAR(20) = NULL,
@documento VARCHAR(30) = NULL)
AS
BEGIN
SET NOCOUNT ON;
BEGIN
	declare @codigoConsultora2 VARCHAR(20)
	declare @consultoraID bigint
	declare @CampaniaID int
	declare @CampaniaAnterior int
	declare @ZonaID int
	declare @RegionID int
	declare @PaisID2 int

	set @PaisID2 = convert(int,isnull(@paisID,'0'))
	select @codigoConsultora2 =C.Codigo 
		,@consultoraID =C.ConsultoraID
		,@ZonaID = IsNull(C.ZonaID,0)
		,@RegionID = IsNull(C.RegionID,0)
		,@ConsultoraID = IsNull(C.ConsultoraID,0) 
	from ods.consultora C with(nolock) 
		inner join ods.Identificacion AS I ON I.ConsultoraID = C.ConsultoraID AND I.DocumentoPrincipal = '1'  
	where ISNULL(C.codigo,'-1') = (CASE When ISNULL(@codigoConsultora,'-1')='-1' THEN ISNULL(C.codigo,'-1') ELSE @codigoConsultora END)
		and ISNULL(I.Numero,'-1') = (CASE When ISNULL(@documento,'-1')='-1' THEN ISNULL(I.Numero,'-1') ELSE @documento END)

	select @CampaniaID = campaniaId from dbo.GetCampaniaPreLogin(@PaisID2,@ZonaID,@RegionID,@ConsultoraID)
	exec GetCampaniaAnterior @CampaniaID,18,1,@CampaniaAnterior OUT;
	
	SELECT 
	top 1
		C.ConsultoraID as consultoraID, 
		C.Codigo AS codigo, 
		R.Codigo AS region,
		S.Codigo AS seccion,
		Z.Codigo AS zona,
		C.NombreCompleto as nombreCompleto,
		CONVERT(VARCHAR(10), C.FechaNacimiento, 103) as  fechaNacimiento,
		C.EstadoCivil as estadoCivil,
		U.Email as email,
		U.Telefono as telefono1,
		U.Celular as telefono2,
		ISNULL(D.Direccion,D.DireccionLinea1) direccionDomicilio,
		ISNULL(D2.Direccion,D2.DireccionLinea1) direccionEntrega,
		validoEmail = case U.EMailActivo when 1 then 'SI' else 'NO' end,
		ofertaWeb = case OW.OfertaWeb when 1 then 'SI' else 'NO' end,
		cataloVirtual = case isnull(CC.CodigoConsultora,0) when 0 then 'NO' else 'SI' end
	FROM [dbo].[Usuario] u with(nolock)
		LEFT JOIN (select top 1 * from ods.consultora with(nolock) where codigo = @codigoConsultora2 ) C ON u.CodigoConsultora = c.Codigo
		left join (select top 1 Direccion,ConsultoraID,DireccionLinea1 from ods.Direccion with(nolock) where TipoDireccion = 'Domicilio' and estadoActivo = 1 and ConsultoraID = @consultoraID) D on D.ConsultoraID = C.ConsultoraID 
		left join (select top 1 Direccion,ConsultoraID,DireccionLinea1 from ods.Direccion with(nolock) where TipoDireccion <> 'Domicilio' and estadoActivo = 1 and ConsultoraID = @consultoraID) D2 on D2.ConsultoraID = C.ConsultoraID 
		INNER JOIN ods.Seccion AS S ON C.SeccionID = S.SeccionID 
		INNER JOIN ods.Zona AS Z  ON S.ZonaID = Z.ZonaID 
		INNER JOIN ods.Region AS R ON Z.RegionID = R.RegionID
		LEFT JOIN ods.Identificacion AS I ON I.ConsultoraID = C.ConsultoraID AND I.DocumentoPrincipal = '1'  
		left join (select top 1 OfertaWeb,ConsultoraId from dbo.PedidoWebDetalle where OfertaWeb = 1 and ConsultoraID = @consultoraID and CampaniaID = @CampaniaAnterior) OW on OW.ConsultoraID = C.ConsultoraID
		left join (select top 1 CodigoConsultora from dbo.CatalogoCampania where CodigoConsultora = @codigoConsultora2  and CodigoCampania = @CampaniaID) CC on CC.CodigoConsultora = U.CodigoConsultora
	WHERE ISNULL(u.CodigoConsultora,'-1') = (CASE When ISNULL(@codigoConsultora2,'-1')='-1' THEN ISNULL(u.CodigoConsultora,'-1') ELSE @codigoConsultora2 END)
END
END


GO

USE BelcorpGuatemala
GO

ALTER PROCEDURE dbo.GetConsultoraDatoSAC(
@paisID VARCHAR(3),
@codigoConsultora VARCHAR(20) = NULL,
@documento VARCHAR(30) = NULL)
AS
BEGIN
SET NOCOUNT ON;
BEGIN
	declare @codigoConsultora2 VARCHAR(20)
	declare @consultoraID bigint
	declare @CampaniaID int
	declare @CampaniaAnterior int
	declare @ZonaID int
	declare @RegionID int
	declare @PaisID2 int

	set @PaisID2 = convert(int,isnull(@paisID,'0'))
	select @codigoConsultora2 =C.Codigo 
		,@consultoraID =C.ConsultoraID
		,@ZonaID = IsNull(C.ZonaID,0)
		,@RegionID = IsNull(C.RegionID,0)
		,@ConsultoraID = IsNull(C.ConsultoraID,0) 
	from ods.consultora C with(nolock) 
		inner join ods.Identificacion AS I ON I.ConsultoraID = C.ConsultoraID AND I.DocumentoPrincipal = '1'  
	where ISNULL(C.codigo,'-1') = (CASE When ISNULL(@codigoConsultora,'-1')='-1' THEN ISNULL(C.codigo,'-1') ELSE @codigoConsultora END)
		and ISNULL(I.Numero,'-1') = (CASE When ISNULL(@documento,'-1')='-1' THEN ISNULL(I.Numero,'-1') ELSE @documento END)

	select @CampaniaID = campaniaId from dbo.GetCampaniaPreLogin(@PaisID2,@ZonaID,@RegionID,@ConsultoraID)
	exec GetCampaniaAnterior @CampaniaID,18,1,@CampaniaAnterior OUT;
	
	SELECT 
	top 1
		C.ConsultoraID as consultoraID, 
		C.Codigo AS codigo, 
		R.Codigo AS region,
		S.Codigo AS seccion,
		Z.Codigo AS zona,
		C.NombreCompleto as nombreCompleto,
		CONVERT(VARCHAR(10), C.FechaNacimiento, 103) as  fechaNacimiento,
		C.EstadoCivil as estadoCivil,
		U.Email as email,
		U.Telefono as telefono1,
		U.Celular as telefono2,
		ISNULL(D.Direccion,D.DireccionLinea1) direccionDomicilio,
		ISNULL(D2.Direccion,D2.DireccionLinea1) direccionEntrega,
		validoEmail = case U.EMailActivo when 1 then 'SI' else 'NO' end,
		ofertaWeb = case OW.OfertaWeb when 1 then 'SI' else 'NO' end,
		cataloVirtual = case isnull(CC.CodigoConsultora,0) when 0 then 'NO' else 'SI' end
	FROM [dbo].[Usuario] u with(nolock)
		LEFT JOIN (select top 1 * from ods.consultora with(nolock) where codigo = @codigoConsultora2 ) C ON u.CodigoConsultora = c.Codigo
		left join (select top 1 Direccion,ConsultoraID,DireccionLinea1 from ods.Direccion with(nolock) where TipoDireccion = 'Domicilio' and estadoActivo = 1 and ConsultoraID = @consultoraID) D on D.ConsultoraID = C.ConsultoraID 
		left join (select top 1 Direccion,ConsultoraID,DireccionLinea1 from ods.Direccion with(nolock) where TipoDireccion <> 'Domicilio' and estadoActivo = 1 and ConsultoraID = @consultoraID) D2 on D2.ConsultoraID = C.ConsultoraID 
		INNER JOIN ods.Seccion AS S ON C.SeccionID = S.SeccionID 
		INNER JOIN ods.Zona AS Z  ON S.ZonaID = Z.ZonaID 
		INNER JOIN ods.Region AS R ON Z.RegionID = R.RegionID
		LEFT JOIN ods.Identificacion AS I ON I.ConsultoraID = C.ConsultoraID AND I.DocumentoPrincipal = '1'  
		left join (select top 1 OfertaWeb,ConsultoraId from dbo.PedidoWebDetalle where OfertaWeb = 1 and ConsultoraID = @consultoraID and CampaniaID = @CampaniaAnterior) OW on OW.ConsultoraID = C.ConsultoraID
		left join (select top 1 CodigoConsultora from dbo.CatalogoCampania where CodigoConsultora = @codigoConsultora2  and CodigoCampania = @CampaniaID) CC on CC.CodigoConsultora = U.CodigoConsultora
	WHERE ISNULL(u.CodigoConsultora,'-1') = (CASE When ISNULL(@codigoConsultora2,'-1')='-1' THEN ISNULL(u.CodigoConsultora,'-1') ELSE @codigoConsultora2 END)
END
END


GO

USE BelcorpEcuador
GO

ALTER PROCEDURE dbo.GetConsultoraDatoSAC(
@paisID VARCHAR(3),
@codigoConsultora VARCHAR(20) = NULL,
@documento VARCHAR(30) = NULL)
AS
BEGIN
SET NOCOUNT ON;
BEGIN
	declare @codigoConsultora2 VARCHAR(20)
	declare @consultoraID bigint
	declare @CampaniaID int
	declare @CampaniaAnterior int
	declare @ZonaID int
	declare @RegionID int
	declare @PaisID2 int

	set @PaisID2 = convert(int,isnull(@paisID,'0'))
	select @codigoConsultora2 =C.Codigo 
		,@consultoraID =C.ConsultoraID
		,@ZonaID = IsNull(C.ZonaID,0)
		,@RegionID = IsNull(C.RegionID,0)
		,@ConsultoraID = IsNull(C.ConsultoraID,0) 
	from ods.consultora C with(nolock) 
		inner join ods.Identificacion AS I ON I.ConsultoraID = C.ConsultoraID AND I.DocumentoPrincipal = '1'  
	where ISNULL(C.codigo,'-1') = (CASE When ISNULL(@codigoConsultora,'-1')='-1' THEN ISNULL(C.codigo,'-1') ELSE @codigoConsultora END)
		and ISNULL(I.Numero,'-1') = (CASE When ISNULL(@documento,'-1')='-1' THEN ISNULL(I.Numero,'-1') ELSE @documento END)

	select @CampaniaID = campaniaId from dbo.GetCampaniaPreLogin(@PaisID2,@ZonaID,@RegionID,@ConsultoraID)
	exec GetCampaniaAnterior @CampaniaID,18,1,@CampaniaAnterior OUT;
	
	SELECT 
	top 1
		C.ConsultoraID as consultoraID, 
		C.Codigo AS codigo, 
		R.Codigo AS region,
		S.Codigo AS seccion,
		Z.Codigo AS zona,
		C.NombreCompleto as nombreCompleto,
		CONVERT(VARCHAR(10), C.FechaNacimiento, 103) as  fechaNacimiento,
		C.EstadoCivil as estadoCivil,
		U.Email as email,
		U.Telefono as telefono1,
		U.Celular as telefono2,
		ISNULL(D.Direccion,D.DireccionLinea1) direccionDomicilio,
		ISNULL(D2.Direccion,D2.DireccionLinea1) direccionEntrega,
		validoEmail = case U.EMailActivo when 1 then 'SI' else 'NO' end,
		ofertaWeb = case OW.OfertaWeb when 1 then 'SI' else 'NO' end,
		cataloVirtual = case isnull(CC.CodigoConsultora,0) when 0 then 'NO' else 'SI' end
	FROM [dbo].[Usuario] u with(nolock)
		LEFT JOIN (select top 1 * from ods.consultora with(nolock) where codigo = @codigoConsultora2 ) C ON u.CodigoConsultora = c.Codigo
		left join (select top 1 Direccion,ConsultoraID,DireccionLinea1 from ods.Direccion with(nolock) where TipoDireccion = 'Domicilio' and estadoActivo = 1 and ConsultoraID = @consultoraID) D on D.ConsultoraID = C.ConsultoraID 
		left join (select top 1 Direccion,ConsultoraID,DireccionLinea1 from ods.Direccion with(nolock) where TipoDireccion <> 'Domicilio' and estadoActivo = 1 and ConsultoraID = @consultoraID) D2 on D2.ConsultoraID = C.ConsultoraID 
		INNER JOIN ods.Seccion AS S ON C.SeccionID = S.SeccionID 
		INNER JOIN ods.Zona AS Z  ON S.ZonaID = Z.ZonaID 
		INNER JOIN ods.Region AS R ON Z.RegionID = R.RegionID
		LEFT JOIN ods.Identificacion AS I ON I.ConsultoraID = C.ConsultoraID AND I.DocumentoPrincipal = '1'  
		left join (select top 1 OfertaWeb,ConsultoraId from dbo.PedidoWebDetalle where OfertaWeb = 1 and ConsultoraID = @consultoraID and CampaniaID = @CampaniaAnterior) OW on OW.ConsultoraID = C.ConsultoraID
		left join (select top 1 CodigoConsultora from dbo.CatalogoCampania where CodigoConsultora = @codigoConsultora2  and CodigoCampania = @CampaniaID) CC on CC.CodigoConsultora = U.CodigoConsultora
	WHERE ISNULL(u.CodigoConsultora,'-1') = (CASE When ISNULL(@codigoConsultora2,'-1')='-1' THEN ISNULL(u.CodigoConsultora,'-1') ELSE @codigoConsultora2 END)
END
END


GO

USE BelcorpDominicana
GO

ALTER PROCEDURE dbo.GetConsultoraDatoSAC(
@paisID VARCHAR(3),
@codigoConsultora VARCHAR(20) = NULL,
@documento VARCHAR(30) = NULL)
AS
BEGIN
SET NOCOUNT ON;
BEGIN
	declare @codigoConsultora2 VARCHAR(20)
	declare @consultoraID bigint
	declare @CampaniaID int
	declare @CampaniaAnterior int
	declare @ZonaID int
	declare @RegionID int
	declare @PaisID2 int

	set @PaisID2 = convert(int,isnull(@paisID,'0'))
	select @codigoConsultora2 =C.Codigo 
		,@consultoraID =C.ConsultoraID
		,@ZonaID = IsNull(C.ZonaID,0)
		,@RegionID = IsNull(C.RegionID,0)
		,@ConsultoraID = IsNull(C.ConsultoraID,0) 
	from ods.consultora C with(nolock) 
		inner join ods.Identificacion AS I ON I.ConsultoraID = C.ConsultoraID AND I.DocumentoPrincipal = '1'  
	where ISNULL(C.codigo,'-1') = (CASE When ISNULL(@codigoConsultora,'-1')='-1' THEN ISNULL(C.codigo,'-1') ELSE @codigoConsultora END)
		and ISNULL(I.Numero,'-1') = (CASE When ISNULL(@documento,'-1')='-1' THEN ISNULL(I.Numero,'-1') ELSE @documento END)

	select @CampaniaID = campaniaId from dbo.GetCampaniaPreLogin(@PaisID2,@ZonaID,@RegionID,@ConsultoraID)
	exec GetCampaniaAnterior @CampaniaID,18,1,@CampaniaAnterior OUT;
	
	SELECT 
	top 1
		C.ConsultoraID as consultoraID, 
		C.Codigo AS codigo, 
		R.Codigo AS region,
		S.Codigo AS seccion,
		Z.Codigo AS zona,
		C.NombreCompleto as nombreCompleto,
		CONVERT(VARCHAR(10), C.FechaNacimiento, 103) as  fechaNacimiento,
		C.EstadoCivil as estadoCivil,
		U.Email as email,
		U.Telefono as telefono1,
		U.Celular as telefono2,
		ISNULL(D.Direccion,D.DireccionLinea1) direccionDomicilio,
		ISNULL(D2.Direccion,D2.DireccionLinea1) direccionEntrega,
		validoEmail = case U.EMailActivo when 1 then 'SI' else 'NO' end,
		ofertaWeb = case OW.OfertaWeb when 1 then 'SI' else 'NO' end,
		cataloVirtual = case isnull(CC.CodigoConsultora,0) when 0 then 'NO' else 'SI' end
	FROM [dbo].[Usuario] u with(nolock)
		LEFT JOIN (select top 1 * from ods.consultora with(nolock) where codigo = @codigoConsultora2 ) C ON u.CodigoConsultora = c.Codigo
		left join (select top 1 Direccion,ConsultoraID,DireccionLinea1 from ods.Direccion with(nolock) where TipoDireccion = 'Domicilio' and estadoActivo = 1 and ConsultoraID = @consultoraID) D on D.ConsultoraID = C.ConsultoraID 
		left join (select top 1 Direccion,ConsultoraID,DireccionLinea1 from ods.Direccion with(nolock) where TipoDireccion <> 'Domicilio' and estadoActivo = 1 and ConsultoraID = @consultoraID) D2 on D2.ConsultoraID = C.ConsultoraID 
		INNER JOIN ods.Seccion AS S ON C.SeccionID = S.SeccionID 
		INNER JOIN ods.Zona AS Z  ON S.ZonaID = Z.ZonaID 
		INNER JOIN ods.Region AS R ON Z.RegionID = R.RegionID
		LEFT JOIN ods.Identificacion AS I ON I.ConsultoraID = C.ConsultoraID AND I.DocumentoPrincipal = '1'  
		left join (select top 1 OfertaWeb,ConsultoraId from dbo.PedidoWebDetalle where OfertaWeb = 1 and ConsultoraID = @consultoraID and CampaniaID = @CampaniaAnterior) OW on OW.ConsultoraID = C.ConsultoraID
		left join (select top 1 CodigoConsultora from dbo.CatalogoCampania where CodigoConsultora = @codigoConsultora2  and CodigoCampania = @CampaniaID) CC on CC.CodigoConsultora = U.CodigoConsultora
	WHERE ISNULL(u.CodigoConsultora,'-1') = (CASE When ISNULL(@codigoConsultora2,'-1')='-1' THEN ISNULL(u.CodigoConsultora,'-1') ELSE @codigoConsultora2 END)
END
END


GO

USE BelcorpCostaRica
GO

ALTER PROCEDURE dbo.GetConsultoraDatoSAC(
@paisID VARCHAR(3),
@codigoConsultora VARCHAR(20) = NULL,
@documento VARCHAR(30) = NULL)
AS
BEGIN
SET NOCOUNT ON;
BEGIN
	declare @codigoConsultora2 VARCHAR(20)
	declare @consultoraID bigint
	declare @CampaniaID int
	declare @CampaniaAnterior int
	declare @ZonaID int
	declare @RegionID int
	declare @PaisID2 int

	set @PaisID2 = convert(int,isnull(@paisID,'0'))
	select @codigoConsultora2 =C.Codigo 
		,@consultoraID =C.ConsultoraID
		,@ZonaID = IsNull(C.ZonaID,0)
		,@RegionID = IsNull(C.RegionID,0)
		,@ConsultoraID = IsNull(C.ConsultoraID,0) 
	from ods.consultora C with(nolock) 
		inner join ods.Identificacion AS I ON I.ConsultoraID = C.ConsultoraID AND I.DocumentoPrincipal = '1'  
	where ISNULL(C.codigo,'-1') = (CASE When ISNULL(@codigoConsultora,'-1')='-1' THEN ISNULL(C.codigo,'-1') ELSE @codigoConsultora END)
		and ISNULL(I.Numero,'-1') = (CASE When ISNULL(@documento,'-1')='-1' THEN ISNULL(I.Numero,'-1') ELSE @documento END)

	select @CampaniaID = campaniaId from dbo.GetCampaniaPreLogin(@PaisID2,@ZonaID,@RegionID,@ConsultoraID)
	exec GetCampaniaAnterior @CampaniaID,18,1,@CampaniaAnterior OUT;
	
	SELECT 
	top 1
		C.ConsultoraID as consultoraID, 
		C.Codigo AS codigo, 
		R.Codigo AS region,
		S.Codigo AS seccion,
		Z.Codigo AS zona,
		C.NombreCompleto as nombreCompleto,
		CONVERT(VARCHAR(10), C.FechaNacimiento, 103) as  fechaNacimiento,
		C.EstadoCivil as estadoCivil,
		U.Email as email,
		U.Telefono as telefono1,
		U.Celular as telefono2,
		ISNULL(D.Direccion,D.DireccionLinea1) direccionDomicilio,
		ISNULL(D2.Direccion,D2.DireccionLinea1) direccionEntrega,
		validoEmail = case U.EMailActivo when 1 then 'SI' else 'NO' end,
		ofertaWeb = case OW.OfertaWeb when 1 then 'SI' else 'NO' end,
		cataloVirtual = case isnull(CC.CodigoConsultora,0) when 0 then 'NO' else 'SI' end
	FROM [dbo].[Usuario] u with(nolock)
		LEFT JOIN (select top 1 * from ods.consultora with(nolock) where codigo = @codigoConsultora2 ) C ON u.CodigoConsultora = c.Codigo
		left join (select top 1 Direccion,ConsultoraID,DireccionLinea1 from ods.Direccion with(nolock) where TipoDireccion = 'Domicilio' and estadoActivo = 1 and ConsultoraID = @consultoraID) D on D.ConsultoraID = C.ConsultoraID 
		left join (select top 1 Direccion,ConsultoraID,DireccionLinea1 from ods.Direccion with(nolock) where TipoDireccion <> 'Domicilio' and estadoActivo = 1 and ConsultoraID = @consultoraID) D2 on D2.ConsultoraID = C.ConsultoraID 
		INNER JOIN ods.Seccion AS S ON C.SeccionID = S.SeccionID 
		INNER JOIN ods.Zona AS Z  ON S.ZonaID = Z.ZonaID 
		INNER JOIN ods.Region AS R ON Z.RegionID = R.RegionID
		LEFT JOIN ods.Identificacion AS I ON I.ConsultoraID = C.ConsultoraID AND I.DocumentoPrincipal = '1'  
		left join (select top 1 OfertaWeb,ConsultoraId from dbo.PedidoWebDetalle where OfertaWeb = 1 and ConsultoraID = @consultoraID and CampaniaID = @CampaniaAnterior) OW on OW.ConsultoraID = C.ConsultoraID
		left join (select top 1 CodigoConsultora from dbo.CatalogoCampania where CodigoConsultora = @codigoConsultora2  and CodigoCampania = @CampaniaID) CC on CC.CodigoConsultora = U.CodigoConsultora
	WHERE ISNULL(u.CodigoConsultora,'-1') = (CASE When ISNULL(@codigoConsultora2,'-1')='-1' THEN ISNULL(u.CodigoConsultora,'-1') ELSE @codigoConsultora2 END)
END
END


GO

USE BelcorpChile
GO

ALTER PROCEDURE dbo.GetConsultoraDatoSAC(
@paisID VARCHAR(3),
@codigoConsultora VARCHAR(20) = NULL,
@documento VARCHAR(30) = NULL)
AS
BEGIN
SET NOCOUNT ON;
BEGIN
	declare @codigoConsultora2 VARCHAR(20)
	declare @consultoraID bigint
	declare @CampaniaID int
	declare @CampaniaAnterior int
	declare @ZonaID int
	declare @RegionID int
	declare @PaisID2 int

	set @PaisID2 = convert(int,isnull(@paisID,'0'))
	select @codigoConsultora2 =C.Codigo 
		,@consultoraID =C.ConsultoraID
		,@ZonaID = IsNull(C.ZonaID,0)
		,@RegionID = IsNull(C.RegionID,0)
		,@ConsultoraID = IsNull(C.ConsultoraID,0) 
	from ods.consultora C with(nolock) 
		inner join ods.Identificacion AS I ON I.ConsultoraID = C.ConsultoraID AND I.DocumentoPrincipal = '1'  
	where ISNULL(C.codigo,'-1') = (CASE When ISNULL(@codigoConsultora,'-1')='-1' THEN ISNULL(C.codigo,'-1') ELSE @codigoConsultora END)
		and ISNULL(I.Numero,'-1') = (CASE When ISNULL(@documento,'-1')='-1' THEN ISNULL(I.Numero,'-1') ELSE @documento END)

	select @CampaniaID = campaniaId from dbo.GetCampaniaPreLogin(@PaisID2,@ZonaID,@RegionID,@ConsultoraID)
	exec GetCampaniaAnterior @CampaniaID,18,1,@CampaniaAnterior OUT;
	
	SELECT 
	top 1
		C.ConsultoraID as consultoraID, 
		C.Codigo AS codigo, 
		R.Codigo AS region,
		S.Codigo AS seccion,
		Z.Codigo AS zona,
		C.NombreCompleto as nombreCompleto,
		CONVERT(VARCHAR(10), C.FechaNacimiento, 103) as  fechaNacimiento,
		C.EstadoCivil as estadoCivil,
		U.Email as email,
		U.Telefono as telefono1,
		U.Celular as telefono2,
		ISNULL(D.Direccion,D.DireccionLinea1) direccionDomicilio,
		ISNULL(D2.Direccion,D2.DireccionLinea1) direccionEntrega,
		validoEmail = case U.EMailActivo when 1 then 'SI' else 'NO' end,
		ofertaWeb = case OW.OfertaWeb when 1 then 'SI' else 'NO' end,
		cataloVirtual = case isnull(CC.CodigoConsultora,0) when 0 then 'NO' else 'SI' end
	FROM [dbo].[Usuario] u with(nolock)
		LEFT JOIN (select top 1 * from ods.consultora with(nolock) where codigo = @codigoConsultora2 ) C ON u.CodigoConsultora = c.Codigo
		left join (select top 1 Direccion,ConsultoraID,DireccionLinea1 from ods.Direccion with(nolock) where TipoDireccion = 'Domicilio' and estadoActivo = 1 and ConsultoraID = @consultoraID) D on D.ConsultoraID = C.ConsultoraID 
		left join (select top 1 Direccion,ConsultoraID,DireccionLinea1 from ods.Direccion with(nolock) where TipoDireccion <> 'Domicilio' and estadoActivo = 1 and ConsultoraID = @consultoraID) D2 on D2.ConsultoraID = C.ConsultoraID 
		INNER JOIN ods.Seccion AS S ON C.SeccionID = S.SeccionID 
		INNER JOIN ods.Zona AS Z  ON S.ZonaID = Z.ZonaID 
		INNER JOIN ods.Region AS R ON Z.RegionID = R.RegionID
		LEFT JOIN ods.Identificacion AS I ON I.ConsultoraID = C.ConsultoraID AND I.DocumentoPrincipal = '1'  
		left join (select top 1 OfertaWeb,ConsultoraId from dbo.PedidoWebDetalle where OfertaWeb = 1 and ConsultoraID = @consultoraID and CampaniaID = @CampaniaAnterior) OW on OW.ConsultoraID = C.ConsultoraID
		left join (select top 1 CodigoConsultora from dbo.CatalogoCampania where CodigoConsultora = @codigoConsultora2  and CodigoCampania = @CampaniaID) CC on CC.CodigoConsultora = U.CodigoConsultora
	WHERE ISNULL(u.CodigoConsultora,'-1') = (CASE When ISNULL(@codigoConsultora2,'-1')='-1' THEN ISNULL(u.CodigoConsultora,'-1') ELSE @codigoConsultora2 END)
END
END


GO

USE BelcorpBolivia
GO

ALTER PROCEDURE dbo.GetConsultoraDatoSAC(
@paisID VARCHAR(3),
@codigoConsultora VARCHAR(20) = NULL,
@documento VARCHAR(30) = NULL)
AS
BEGIN
SET NOCOUNT ON;
BEGIN
	declare @codigoConsultora2 VARCHAR(20)
	declare @consultoraID bigint
	declare @CampaniaID int
	declare @CampaniaAnterior int
	declare @ZonaID int
	declare @RegionID int
	declare @PaisID2 int

	set @PaisID2 = convert(int,isnull(@paisID,'0'))
	select @codigoConsultora2 =C.Codigo 
		,@consultoraID =C.ConsultoraID
		,@ZonaID = IsNull(C.ZonaID,0)
		,@RegionID = IsNull(C.RegionID,0)
		,@ConsultoraID = IsNull(C.ConsultoraID,0) 
	from ods.consultora C with(nolock) 
		inner join ods.Identificacion AS I ON I.ConsultoraID = C.ConsultoraID AND I.DocumentoPrincipal = '1'  
	where ISNULL(C.codigo,'-1') = (CASE When ISNULL(@codigoConsultora,'-1')='-1' THEN ISNULL(C.codigo,'-1') ELSE @codigoConsultora END)
		and ISNULL(I.Numero,'-1') = (CASE When ISNULL(@documento,'-1')='-1' THEN ISNULL(I.Numero,'-1') ELSE @documento END)

	select @CampaniaID = campaniaId from dbo.GetCampaniaPreLogin(@PaisID2,@ZonaID,@RegionID,@ConsultoraID)
	exec GetCampaniaAnterior @CampaniaID,18,1,@CampaniaAnterior OUT;
	
	SELECT 
	top 1
		C.ConsultoraID as consultoraID, 
		C.Codigo AS codigo, 
		R.Codigo AS region,
		S.Codigo AS seccion,
		Z.Codigo AS zona,
		C.NombreCompleto as nombreCompleto,
		CONVERT(VARCHAR(10), C.FechaNacimiento, 103) as  fechaNacimiento,
		C.EstadoCivil as estadoCivil,
		U.Email as email,
		U.Telefono as telefono1,
		U.Celular as telefono2,
		ISNULL(D.Direccion,D.DireccionLinea1) direccionDomicilio,
		ISNULL(D2.Direccion,D2.DireccionLinea1) direccionEntrega,
		validoEmail = case U.EMailActivo when 1 then 'SI' else 'NO' end,
		ofertaWeb = case OW.OfertaWeb when 1 then 'SI' else 'NO' end,
		cataloVirtual = case isnull(CC.CodigoConsultora,0) when 0 then 'NO' else 'SI' end
	FROM [dbo].[Usuario] u with(nolock)
		LEFT JOIN (select top 1 * from ods.consultora with(nolock) where codigo = @codigoConsultora2 ) C ON u.CodigoConsultora = c.Codigo
		left join (select top 1 Direccion,ConsultoraID,DireccionLinea1 from ods.Direccion with(nolock) where TipoDireccion = 'Domicilio' and estadoActivo = 1 and ConsultoraID = @consultoraID) D on D.ConsultoraID = C.ConsultoraID 
		left join (select top 1 Direccion,ConsultoraID,DireccionLinea1 from ods.Direccion with(nolock) where TipoDireccion <> 'Domicilio' and estadoActivo = 1 and ConsultoraID = @consultoraID) D2 on D2.ConsultoraID = C.ConsultoraID 
		INNER JOIN ods.Seccion AS S ON C.SeccionID = S.SeccionID 
		INNER JOIN ods.Zona AS Z  ON S.ZonaID = Z.ZonaID 
		INNER JOIN ods.Region AS R ON Z.RegionID = R.RegionID
		LEFT JOIN ods.Identificacion AS I ON I.ConsultoraID = C.ConsultoraID AND I.DocumentoPrincipal = '1'  
		left join (select top 1 OfertaWeb,ConsultoraId from dbo.PedidoWebDetalle where OfertaWeb = 1 and ConsultoraID = @consultoraID and CampaniaID = @CampaniaAnterior) OW on OW.ConsultoraID = C.ConsultoraID
		left join (select top 1 CodigoConsultora from dbo.CatalogoCampania where CodigoConsultora = @codigoConsultora2  and CodigoCampania = @CampaniaID) CC on CC.CodigoConsultora = U.CodigoConsultora
	WHERE ISNULL(u.CodigoConsultora,'-1') = (CASE When ISNULL(@codigoConsultora2,'-1')='-1' THEN ISNULL(u.CodigoConsultora,'-1') ELSE @codigoConsultora2 END)
END
END


GO

