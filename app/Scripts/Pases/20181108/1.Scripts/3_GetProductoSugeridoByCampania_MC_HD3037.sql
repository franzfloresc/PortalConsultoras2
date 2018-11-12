USE BelcorpPeru
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetProductoSugeridoByCampania'))
begin
	DROP PROC dbo.GetProductoSugeridoByCampania
end
GO
CREATE PROC [dbo].[GetProductoSugeridoByCampania] 
(
@CampaniaID int
)
as
begin
	declare @isoPais as varchar(2)
	set @isoPais =(select CODIGOISO from pais where estadoactivo=1)
	
	select 
		@isoPais as pais,
		@CampaniaID as campaniaID,
		c.codigo as codigoConsultora,
		c.nombrecompleto as NombreConsultora,
		r.codigo as region,
		z.codigo as zona,
		pc2.cuv as productoSugerido,
		pc2.Descripcion as descripcionSugerido,
		pc2.codigoproducto as sapSugerido,
		pc1.cuv as productoDigitado,
		pc1.Descripcion as descripcionDigitado,
		pc1.codigoproducto as sapDigitado,
		pd.cantidad,
		case when esSugerido=0 then 'no' when esSugerido=1 then 'si' else '' end aceptoProductoSugerido,
		cast(ROW_NUMBER() OVER(ORDER BY c.codigo ASC) as int) as codren 
	 from pedidoweb p with (nolock)
	 inner join ods.consultora c with (nolock) on p.consultoraid=c.consultoraid 
	 inner join pedidowebdetalle pd with (nolock) on p.pedidoid=pd.pedidoid
	 inner join ods.zona z with(nolock) on c.zonaid=z.zonaid
	 inner join ods.region r with(nolock) on z.regionid=r.regionid 
	 inner join ProductoSugerido ps with (nolock) on ps.campaniaid=p.campaniaid and ps.campaniaid=pd.campaniaid and ps.cuvsugerido=pd.cuv
	 inner join ods.ProductoComercial pc1 with (nolock) on pc1.anocampania=p.campaniaid and pc1.anocampania=pd.campaniaid and pc1.cuv=ps.cuv
	 inner join ods.ProductoComercial pc2 with (nolock) on pc2.anocampania=p.campaniaid and pc2.anocampania=pd.campaniaid and pc2.cuv=ps.cuvsugerido
	 where p.campaniaid=@CampaniaID
end
GO

USE BelcorpMexico
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetProductoSugeridoByCampania'))
begin
	DROP PROC dbo.GetProductoSugeridoByCampania
end
GO
CREATE PROC [dbo].[GetProductoSugeridoByCampania] 
(
@CampaniaID int
)
as
begin
	declare @isoPais as varchar(2)
	set @isoPais =(select CODIGOISO from pais where estadoactivo=1)
	
	select 
		@isoPais as pais,
		@CampaniaID as campaniaID,
		c.codigo as codigoConsultora,
		c.nombrecompleto as NombreConsultora,
		r.codigo as region,
		z.codigo as zona,
		pc2.cuv as productoSugerido,
		pc2.Descripcion as descripcionSugerido,
		pc2.codigoproducto as sapSugerido,
		pc1.cuv as productoDigitado,
		pc1.Descripcion as descripcionDigitado,
		pc1.codigoproducto as sapDigitado,
		pd.cantidad,
		case when esSugerido=0 then 'no' when esSugerido=1 then 'si' else '' end aceptoProductoSugerido,
		cast(ROW_NUMBER() OVER(ORDER BY c.codigo ASC) as int) as codren 
	 from pedidoweb p with (nolock)
	 inner join ods.consultora c with (nolock) on p.consultoraid=c.consultoraid 
	 inner join pedidowebdetalle pd with (nolock) on p.pedidoid=pd.pedidoid
	 inner join ods.zona z with(nolock) on c.zonaid=z.zonaid
	 inner join ods.region r with(nolock) on z.regionid=r.regionid 
	 inner join ProductoSugerido ps with (nolock) on ps.campaniaid=p.campaniaid and ps.campaniaid=pd.campaniaid and ps.cuvsugerido=pd.cuv
	 inner join ods.ProductoComercial pc1 with (nolock) on pc1.anocampania=p.campaniaid and pc1.anocampania=pd.campaniaid and pc1.cuv=ps.cuv
	 inner join ods.ProductoComercial pc2 with (nolock) on pc2.anocampania=p.campaniaid and pc2.anocampania=pd.campaniaid and pc2.cuv=ps.cuvsugerido
	 where p.campaniaid=@CampaniaID
end
GO

USE BelcorpColombia
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetProductoSugeridoByCampania'))
begin
	DROP PROC dbo.GetProductoSugeridoByCampania
end
GO
CREATE PROC [dbo].[GetProductoSugeridoByCampania] 
(
@CampaniaID int
)
as
begin
	declare @isoPais as varchar(2)
	set @isoPais =(select CODIGOISO from pais where estadoactivo=1)
	
	select 
		@isoPais as pais,
		@CampaniaID as campaniaID,
		c.codigo as codigoConsultora,
		c.nombrecompleto as NombreConsultora,
		r.codigo as region,
		z.codigo as zona,
		pc2.cuv as productoSugerido,
		pc2.Descripcion as descripcionSugerido,
		pc2.codigoproducto as sapSugerido,
		pc1.cuv as productoDigitado,
		pc1.Descripcion as descripcionDigitado,
		pc1.codigoproducto as sapDigitado,
		pd.cantidad,
		case when esSugerido=0 then 'no' when esSugerido=1 then 'si' else '' end aceptoProductoSugerido,
		cast(ROW_NUMBER() OVER(ORDER BY c.codigo ASC) as int) as codren 
	 from pedidoweb p with (nolock)
	 inner join ods.consultora c with (nolock) on p.consultoraid=c.consultoraid 
	 inner join pedidowebdetalle pd with (nolock) on p.pedidoid=pd.pedidoid
	 inner join ods.zona z with(nolock) on c.zonaid=z.zonaid
	 inner join ods.region r with(nolock) on z.regionid=r.regionid 
	 inner join ProductoSugerido ps with (nolock) on ps.campaniaid=p.campaniaid and ps.campaniaid=pd.campaniaid and ps.cuvsugerido=pd.cuv
	 inner join ods.ProductoComercial pc1 with (nolock) on pc1.anocampania=p.campaniaid and pc1.anocampania=pd.campaniaid and pc1.cuv=ps.cuv
	 inner join ods.ProductoComercial pc2 with (nolock) on pc2.anocampania=p.campaniaid and pc2.anocampania=pd.campaniaid and pc2.cuv=ps.cuvsugerido
	 where p.campaniaid=@CampaniaID
end
GO

USE BelcorpSalvador
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetProductoSugeridoByCampania'))
begin
	DROP PROC dbo.GetProductoSugeridoByCampania
end
GO
CREATE PROC [dbo].[GetProductoSugeridoByCampania] 
(
@CampaniaID int
)
as
begin
	declare @isoPais as varchar(2)
	set @isoPais =(select CODIGOISO from pais where estadoactivo=1)
	
	select 
		@isoPais as pais,
		@CampaniaID as campaniaID,
		c.codigo as codigoConsultora,
		c.nombrecompleto as NombreConsultora,
		r.codigo as region,
		z.codigo as zona,
		pc2.cuv as productoSugerido,
		pc2.Descripcion as descripcionSugerido,
		pc2.codigoproducto as sapSugerido,
		pc1.cuv as productoDigitado,
		pc1.Descripcion as descripcionDigitado,
		pc1.codigoproducto as sapDigitado,
		pd.cantidad,
		case when esSugerido=0 then 'no' when esSugerido=1 then 'si' else '' end aceptoProductoSugerido,
		cast(ROW_NUMBER() OVER(ORDER BY c.codigo ASC) as int) as codren 
	 from pedidoweb p with (nolock)
	 inner join ods.consultora c with (nolock) on p.consultoraid=c.consultoraid 
	 inner join pedidowebdetalle pd with (nolock) on p.pedidoid=pd.pedidoid
	 inner join ods.zona z with(nolock) on c.zonaid=z.zonaid
	 inner join ods.region r with(nolock) on z.regionid=r.regionid 
	 inner join ProductoSugerido ps with (nolock) on ps.campaniaid=p.campaniaid and ps.campaniaid=pd.campaniaid and ps.cuvsugerido=pd.cuv
	 inner join ods.ProductoComercial pc1 with (nolock) on pc1.anocampania=p.campaniaid and pc1.anocampania=pd.campaniaid and pc1.cuv=ps.cuv
	 inner join ods.ProductoComercial pc2 with (nolock) on pc2.anocampania=p.campaniaid and pc2.anocampania=pd.campaniaid and pc2.cuv=ps.cuvsugerido
	 where p.campaniaid=@CampaniaID
end
GO

USE BelcorpPuertoRico
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetProductoSugeridoByCampania'))
begin
	DROP PROC dbo.GetProductoSugeridoByCampania
end
GO
CREATE PROC [dbo].[GetProductoSugeridoByCampania] 
(
@CampaniaID int
)
as
begin
	declare @isoPais as varchar(2)
	set @isoPais =(select CODIGOISO from pais where estadoactivo=1)
	
	select 
		@isoPais as pais,
		@CampaniaID as campaniaID,
		c.codigo as codigoConsultora,
		c.nombrecompleto as NombreConsultora,
		r.codigo as region,
		z.codigo as zona,
		pc2.cuv as productoSugerido,
		pc2.Descripcion as descripcionSugerido,
		pc2.codigoproducto as sapSugerido,
		pc1.cuv as productoDigitado,
		pc1.Descripcion as descripcionDigitado,
		pc1.codigoproducto as sapDigitado,
		pd.cantidad,
		case when esSugerido=0 then 'no' when esSugerido=1 then 'si' else '' end aceptoProductoSugerido,
		cast(ROW_NUMBER() OVER(ORDER BY c.codigo ASC) as int) as codren 
	 from pedidoweb p with (nolock)
	 inner join ods.consultora c with (nolock) on p.consultoraid=c.consultoraid 
	 inner join pedidowebdetalle pd with (nolock) on p.pedidoid=pd.pedidoid
	 inner join ods.zona z with(nolock) on c.zonaid=z.zonaid
	 inner join ods.region r with(nolock) on z.regionid=r.regionid 
	 inner join ProductoSugerido ps with (nolock) on ps.campaniaid=p.campaniaid and ps.campaniaid=pd.campaniaid and ps.cuvsugerido=pd.cuv
	 inner join ods.ProductoComercial pc1 with (nolock) on pc1.anocampania=p.campaniaid and pc1.anocampania=pd.campaniaid and pc1.cuv=ps.cuv
	 inner join ods.ProductoComercial pc2 with (nolock) on pc2.anocampania=p.campaniaid and pc2.anocampania=pd.campaniaid and pc2.cuv=ps.cuvsugerido
	 where p.campaniaid=@CampaniaID
end
GO

USE BelcorpPanama
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetProductoSugeridoByCampania'))
begin
	DROP PROC dbo.GetProductoSugeridoByCampania
end
GO
CREATE PROC [dbo].[GetProductoSugeridoByCampania] 
(
@CampaniaID int
)
as
begin
	declare @isoPais as varchar(2)
	set @isoPais =(select CODIGOISO from pais where estadoactivo=1)
	
	select 
		@isoPais as pais,
		@CampaniaID as campaniaID,
		c.codigo as codigoConsultora,
		c.nombrecompleto as NombreConsultora,
		r.codigo as region,
		z.codigo as zona,
		pc2.cuv as productoSugerido,
		pc2.Descripcion as descripcionSugerido,
		pc2.codigoproducto as sapSugerido,
		pc1.cuv as productoDigitado,
		pc1.Descripcion as descripcionDigitado,
		pc1.codigoproducto as sapDigitado,
		pd.cantidad,
		case when esSugerido=0 then 'no' when esSugerido=1 then 'si' else '' end aceptoProductoSugerido,
		cast(ROW_NUMBER() OVER(ORDER BY c.codigo ASC) as int) as codren 
	 from pedidoweb p with (nolock)
	 inner join ods.consultora c with (nolock) on p.consultoraid=c.consultoraid 
	 inner join pedidowebdetalle pd with (nolock) on p.pedidoid=pd.pedidoid
	 inner join ods.zona z with(nolock) on c.zonaid=z.zonaid
	 inner join ods.region r with(nolock) on z.regionid=r.regionid 
	 inner join ProductoSugerido ps with (nolock) on ps.campaniaid=p.campaniaid and ps.campaniaid=pd.campaniaid and ps.cuvsugerido=pd.cuv
	 inner join ods.ProductoComercial pc1 with (nolock) on pc1.anocampania=p.campaniaid and pc1.anocampania=pd.campaniaid and pc1.cuv=ps.cuv
	 inner join ods.ProductoComercial pc2 with (nolock) on pc2.anocampania=p.campaniaid and pc2.anocampania=pd.campaniaid and pc2.cuv=ps.cuvsugerido
	 where p.campaniaid=@CampaniaID
end
GO

USE BelcorpGuatemala
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetProductoSugeridoByCampania'))
begin
	DROP PROC dbo.GetProductoSugeridoByCampania
end
GO
CREATE PROC [dbo].[GetProductoSugeridoByCampania] 
(
@CampaniaID int
)
as
begin
	declare @isoPais as varchar(2)
	set @isoPais =(select CODIGOISO from pais where estadoactivo=1)
	
	select 
		@isoPais as pais,
		@CampaniaID as campaniaID,
		c.codigo as codigoConsultora,
		c.nombrecompleto as NombreConsultora,
		r.codigo as region,
		z.codigo as zona,
		pc2.cuv as productoSugerido,
		pc2.Descripcion as descripcionSugerido,
		pc2.codigoproducto as sapSugerido,
		pc1.cuv as productoDigitado,
		pc1.Descripcion as descripcionDigitado,
		pc1.codigoproducto as sapDigitado,
		pd.cantidad,
		case when esSugerido=0 then 'no' when esSugerido=1 then 'si' else '' end aceptoProductoSugerido,
		cast(ROW_NUMBER() OVER(ORDER BY c.codigo ASC) as int) as codren 
	 from pedidoweb p with (nolock)
	 inner join ods.consultora c with (nolock) on p.consultoraid=c.consultoraid 
	 inner join pedidowebdetalle pd with (nolock) on p.pedidoid=pd.pedidoid
	 inner join ods.zona z with(nolock) on c.zonaid=z.zonaid
	 inner join ods.region r with(nolock) on z.regionid=r.regionid 
	 inner join ProductoSugerido ps with (nolock) on ps.campaniaid=p.campaniaid and ps.campaniaid=pd.campaniaid and ps.cuvsugerido=pd.cuv
	 inner join ods.ProductoComercial pc1 with (nolock) on pc1.anocampania=p.campaniaid and pc1.anocampania=pd.campaniaid and pc1.cuv=ps.cuv
	 inner join ods.ProductoComercial pc2 with (nolock) on pc2.anocampania=p.campaniaid and pc2.anocampania=pd.campaniaid and pc2.cuv=ps.cuvsugerido
	 where p.campaniaid=@CampaniaID
end
GO

USE BelcorpEcuador
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetProductoSugeridoByCampania'))
begin
	DROP PROC dbo.GetProductoSugeridoByCampania
end
GO
CREATE PROC [dbo].[GetProductoSugeridoByCampania] 
(
@CampaniaID int
)
as
begin
	declare @isoPais as varchar(2)
	set @isoPais =(select CODIGOISO from pais where estadoactivo=1)
	
	select 
		@isoPais as pais,
		@CampaniaID as campaniaID,
		c.codigo as codigoConsultora,
		c.nombrecompleto as NombreConsultora,
		r.codigo as region,
		z.codigo as zona,
		pc2.cuv as productoSugerido,
		pc2.Descripcion as descripcionSugerido,
		pc2.codigoproducto as sapSugerido,
		pc1.cuv as productoDigitado,
		pc1.Descripcion as descripcionDigitado,
		pc1.codigoproducto as sapDigitado,
		pd.cantidad,
		case when esSugerido=0 then 'no' when esSugerido=1 then 'si' else '' end aceptoProductoSugerido,
		cast(ROW_NUMBER() OVER(ORDER BY c.codigo ASC) as int) as codren 
	 from pedidoweb p with (nolock)
	 inner join ods.consultora c with (nolock) on p.consultoraid=c.consultoraid 
	 inner join pedidowebdetalle pd with (nolock) on p.pedidoid=pd.pedidoid
	 inner join ods.zona z with(nolock) on c.zonaid=z.zonaid
	 inner join ods.region r with(nolock) on z.regionid=r.regionid 
	 inner join ProductoSugerido ps with (nolock) on ps.campaniaid=p.campaniaid and ps.campaniaid=pd.campaniaid and ps.cuvsugerido=pd.cuv
	 inner join ods.ProductoComercial pc1 with (nolock) on pc1.anocampania=p.campaniaid and pc1.anocampania=pd.campaniaid and pc1.cuv=ps.cuv
	 inner join ods.ProductoComercial pc2 with (nolock) on pc2.anocampania=p.campaniaid and pc2.anocampania=pd.campaniaid and pc2.cuv=ps.cuvsugerido
	 where p.campaniaid=@CampaniaID
end
GO

USE BelcorpDominicana
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetProductoSugeridoByCampania'))
begin
	DROP PROC dbo.GetProductoSugeridoByCampania
end
GO
CREATE PROC [dbo].[GetProductoSugeridoByCampania] 
(
@CampaniaID int
)
as
begin
	declare @isoPais as varchar(2)
	set @isoPais =(select CODIGOISO from pais where estadoactivo=1)
	
	select 
		@isoPais as pais,
		@CampaniaID as campaniaID,
		c.codigo as codigoConsultora,
		c.nombrecompleto as NombreConsultora,
		r.codigo as region,
		z.codigo as zona,
		pc2.cuv as productoSugerido,
		pc2.Descripcion as descripcionSugerido,
		pc2.codigoproducto as sapSugerido,
		pc1.cuv as productoDigitado,
		pc1.Descripcion as descripcionDigitado,
		pc1.codigoproducto as sapDigitado,
		pd.cantidad,
		case when esSugerido=0 then 'no' when esSugerido=1 then 'si' else '' end aceptoProductoSugerido,
		cast(ROW_NUMBER() OVER(ORDER BY c.codigo ASC) as int) as codren 
	 from pedidoweb p with (nolock)
	 inner join ods.consultora c with (nolock) on p.consultoraid=c.consultoraid 
	 inner join pedidowebdetalle pd with (nolock) on p.pedidoid=pd.pedidoid
	 inner join ods.zona z with(nolock) on c.zonaid=z.zonaid
	 inner join ods.region r with(nolock) on z.regionid=r.regionid 
	 inner join ProductoSugerido ps with (nolock) on ps.campaniaid=p.campaniaid and ps.campaniaid=pd.campaniaid and ps.cuvsugerido=pd.cuv
	 inner join ods.ProductoComercial pc1 with (nolock) on pc1.anocampania=p.campaniaid and pc1.anocampania=pd.campaniaid and pc1.cuv=ps.cuv
	 inner join ods.ProductoComercial pc2 with (nolock) on pc2.anocampania=p.campaniaid and pc2.anocampania=pd.campaniaid and pc2.cuv=ps.cuvsugerido
	 where p.campaniaid=@CampaniaID
end
GO

USE BelcorpCostaRica
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetProductoSugeridoByCampania'))
begin
	DROP PROC dbo.GetProductoSugeridoByCampania
end
GO
CREATE PROC [dbo].[GetProductoSugeridoByCampania] 
(
@CampaniaID int
)
as
begin
	declare @isoPais as varchar(2)
	set @isoPais =(select CODIGOISO from pais where estadoactivo=1)
	
	select 
		@isoPais as pais,
		@CampaniaID as campaniaID,
		c.codigo as codigoConsultora,
		c.nombrecompleto as NombreConsultora,
		r.codigo as region,
		z.codigo as zona,
		pc2.cuv as productoSugerido,
		pc2.Descripcion as descripcionSugerido,
		pc2.codigoproducto as sapSugerido,
		pc1.cuv as productoDigitado,
		pc1.Descripcion as descripcionDigitado,
		pc1.codigoproducto as sapDigitado,
		pd.cantidad,
		case when esSugerido=0 then 'no' when esSugerido=1 then 'si' else '' end aceptoProductoSugerido,
		cast(ROW_NUMBER() OVER(ORDER BY c.codigo ASC) as int) as codren 
	 from pedidoweb p with (nolock)
	 inner join ods.consultora c with (nolock) on p.consultoraid=c.consultoraid 
	 inner join pedidowebdetalle pd with (nolock) on p.pedidoid=pd.pedidoid
	 inner join ods.zona z with(nolock) on c.zonaid=z.zonaid
	 inner join ods.region r with(nolock) on z.regionid=r.regionid 
	 inner join ProductoSugerido ps with (nolock) on ps.campaniaid=p.campaniaid and ps.campaniaid=pd.campaniaid and ps.cuvsugerido=pd.cuv
	 inner join ods.ProductoComercial pc1 with (nolock) on pc1.anocampania=p.campaniaid and pc1.anocampania=pd.campaniaid and pc1.cuv=ps.cuv
	 inner join ods.ProductoComercial pc2 with (nolock) on pc2.anocampania=p.campaniaid and pc2.anocampania=pd.campaniaid and pc2.cuv=ps.cuvsugerido
	 where p.campaniaid=@CampaniaID
end
GO

USE BelcorpChile
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetProductoSugeridoByCampania'))
begin
	DROP PROC dbo.GetProductoSugeridoByCampania
end
GO
CREATE PROC [dbo].[GetProductoSugeridoByCampania] 
(
@CampaniaID int
)
as
begin
	declare @isoPais as varchar(2)
	set @isoPais =(select CODIGOISO from pais where estadoactivo=1)
	
	select 
		@isoPais as pais,
		@CampaniaID as campaniaID,
		c.codigo as codigoConsultora,
		c.nombrecompleto as NombreConsultora,
		r.codigo as region,
		z.codigo as zona,
		pc2.cuv as productoSugerido,
		pc2.Descripcion as descripcionSugerido,
		pc2.codigoproducto as sapSugerido,
		pc1.cuv as productoDigitado,
		pc1.Descripcion as descripcionDigitado,
		pc1.codigoproducto as sapDigitado,
		pd.cantidad,
		case when esSugerido=0 then 'no' when esSugerido=1 then 'si' else '' end aceptoProductoSugerido,
		cast(ROW_NUMBER() OVER(ORDER BY c.codigo ASC) as int) as codren 
	 from pedidoweb p with (nolock)
	 inner join ods.consultora c with (nolock) on p.consultoraid=c.consultoraid 
	 inner join pedidowebdetalle pd with (nolock) on p.pedidoid=pd.pedidoid
	 inner join ods.zona z with(nolock) on c.zonaid=z.zonaid
	 inner join ods.region r with(nolock) on z.regionid=r.regionid 
	 inner join ProductoSugerido ps with (nolock) on ps.campaniaid=p.campaniaid and ps.campaniaid=pd.campaniaid and ps.cuvsugerido=pd.cuv
	 inner join ods.ProductoComercial pc1 with (nolock) on pc1.anocampania=p.campaniaid and pc1.anocampania=pd.campaniaid and pc1.cuv=ps.cuv
	 inner join ods.ProductoComercial pc2 with (nolock) on pc2.anocampania=p.campaniaid and pc2.anocampania=pd.campaniaid and pc2.cuv=ps.cuvsugerido
	 where p.campaniaid=@CampaniaID
end
GO

USE BelcorpBolivia
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetProductoSugeridoByCampania'))
begin
	DROP PROC dbo.GetProductoSugeridoByCampania
end
GO
CREATE PROC [dbo].[GetProductoSugeridoByCampania] 
(
@CampaniaID int
)
as
begin
	declare @isoPais as varchar(2)
	set @isoPais =(select CODIGOISO from pais where estadoactivo=1)
	
	select 
		@isoPais as pais,
		@CampaniaID as campaniaID,
		c.codigo as codigoConsultora,
		c.nombrecompleto as NombreConsultora,
		r.codigo as region,
		z.codigo as zona,
		pc2.cuv as productoSugerido,
		pc2.Descripcion as descripcionSugerido,
		pc2.codigoproducto as sapSugerido,
		pc1.cuv as productoDigitado,
		pc1.Descripcion as descripcionDigitado,
		pc1.codigoproducto as sapDigitado,
		pd.cantidad,
		case when esSugerido=0 then 'no' when esSugerido=1 then 'si' else '' end aceptoProductoSugerido,
		cast(ROW_NUMBER() OVER(ORDER BY c.codigo ASC) as int) as codren 
	 from pedidoweb p with (nolock)
	 inner join ods.consultora c with (nolock) on p.consultoraid=c.consultoraid 
	 inner join pedidowebdetalle pd with (nolock) on p.pedidoid=pd.pedidoid
	 inner join ods.zona z with(nolock) on c.zonaid=z.zonaid
	 inner join ods.region r with(nolock) on z.regionid=r.regionid 
	 inner join ProductoSugerido ps with (nolock) on ps.campaniaid=p.campaniaid and ps.campaniaid=pd.campaniaid and ps.cuvsugerido=pd.cuv
	 inner join ods.ProductoComercial pc1 with (nolock) on pc1.anocampania=p.campaniaid and pc1.anocampania=pd.campaniaid and pc1.cuv=ps.cuv
	 inner join ods.ProductoComercial pc2 with (nolock) on pc2.anocampania=p.campaniaid and pc2.anocampania=pd.campaniaid and pc2.cuv=ps.cuvsugerido
	 where p.campaniaid=@CampaniaID
end
GO

