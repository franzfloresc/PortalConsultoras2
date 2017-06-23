USE BelcorpBolivia
GO
IF OBJECT_ID('GetOfertasPlan20ByPedido', 'P') IS NOT NULL
	DROP PROCEDURE GetOfertasPlan20ByPedido
GO

CREATE PROCEDURE [dbo].[GetOfertasPlan20ByPedido]
 @CampaniaID INT,
 @ConsultoraID BIGINT,
 @PedidoID BIGINT
AS
 SELECT COUNT(1) as TieneOfertaPlan20
 FROM dbo.PedidoWebDetalle pwd
	 INNER JOIN dbo.PedidoWeb PW ON PW.PedidoID = pwd.PedidoID and pw.consultoraid=pwd.consultoraid and pw.CampaniaID=pwd.CampaniaID
	 JOIN ods.ProductoComercial pc ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV
	 LEFT JOIN dbo.Cliente c ON pwd.ClienteID = c.ClienteID AND pwd.ConsultoraID = c.ConsultoraID
	 LEFT JOIN dbo.ProductoDescripcion pd ON pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV
WHERE pwd.CampaniaID = @CampaniaID
	AND pwd.ConsultoraID = @ConsultoraID AND pwd.CUVPadre IS NULL
	AND pwd.PedidoID = @PedidoID 
	AND (pc.CodigoCatalago=35 OR pc.CodigoCatalago=44 OR pc.CodigoCatalago=45 OR pc.CodigoCatalago=46)
GO

USE BelcorpCostaRica
GO
IF OBJECT_ID('GetOfertasPlan20ByPedido', 'P') IS NOT NULL
	DROP PROCEDURE GetOfertasPlan20ByPedido
GO

CREATE PROCEDURE [dbo].[GetOfertasPlan20ByPedido]
 @CampaniaID INT,
 @ConsultoraID BIGINT,
 @PedidoID BIGINT
AS
 SELECT COUNT(1) as TieneOfertaPlan20
 FROM dbo.PedidoWebDetalle pwd
	 INNER JOIN dbo.PedidoWeb PW ON PW.PedidoID = pwd.PedidoID and pw.consultoraid=pwd.consultoraid and pw.CampaniaID=pwd.CampaniaID
	 JOIN ods.ProductoComercial pc ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV
	 LEFT JOIN dbo.Cliente c ON pwd.ClienteID = c.ClienteID AND pwd.ConsultoraID = c.ConsultoraID
	 LEFT JOIN dbo.ProductoDescripcion pd ON pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV
WHERE pwd.CampaniaID = @CampaniaID
	AND pwd.ConsultoraID = @ConsultoraID AND pwd.CUVPadre IS NULL
	AND pwd.PedidoID = @PedidoID 
	AND (pc.CodigoCatalago=35 OR pc.CodigoCatalago=44 OR pc.CodigoCatalago=45 OR pc.CodigoCatalago=46)
GO

USE BelcorpChile
GO
IF OBJECT_ID('GetOfertasPlan20ByPedido', 'P') IS NOT NULL
	DROP PROCEDURE GetOfertasPlan20ByPedido
GO

CREATE PROCEDURE [dbo].[GetOfertasPlan20ByPedido]
 @CampaniaID INT,
 @ConsultoraID BIGINT,
 @PedidoID BIGINT
AS
 SELECT COUNT(1) as TieneOfertaPlan20
 FROM dbo.PedidoWebDetalle pwd
	 INNER JOIN dbo.PedidoWeb PW ON PW.PedidoID = pwd.PedidoID and pw.consultoraid=pwd.consultoraid and pw.CampaniaID=pwd.CampaniaID
	 JOIN ods.ProductoComercial pc ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV
	 LEFT JOIN dbo.Cliente c ON pwd.ClienteID = c.ClienteID AND pwd.ConsultoraID = c.ConsultoraID
	 LEFT JOIN dbo.ProductoDescripcion pd ON pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV
WHERE pwd.CampaniaID = @CampaniaID
	AND pwd.ConsultoraID = @ConsultoraID AND pwd.CUVPadre IS NULL
	AND pwd.PedidoID = @PedidoID 
	AND (pc.CodigoCatalago=35 OR pc.CodigoCatalago=44 OR pc.CodigoCatalago=45 OR pc.CodigoCatalago=46)
GO

USE BelcorpColombia
GO
IF OBJECT_ID('GetOfertasPlan20ByPedido', 'P') IS NOT NULL
	DROP PROCEDURE GetOfertasPlan20ByPedido
GO

CREATE PROCEDURE [dbo].[GetOfertasPlan20ByPedido]
 @CampaniaID INT,
 @ConsultoraID BIGINT,
 @PedidoID BIGINT
AS
 SELECT COUNT(1) as TieneOfertaPlan20
 FROM dbo.PedidoWebDetalle pwd
	 INNER JOIN dbo.PedidoWeb PW ON PW.PedidoID = pwd.PedidoID and pw.consultoraid=pwd.consultoraid and pw.CampaniaID=pwd.CampaniaID
	 JOIN ods.ProductoComercial pc ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV
	 LEFT JOIN dbo.Cliente c ON pwd.ClienteID = c.ClienteID AND pwd.ConsultoraID = c.ConsultoraID
	 LEFT JOIN dbo.ProductoDescripcion pd ON pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV
WHERE pwd.CampaniaID = @CampaniaID
	AND pwd.ConsultoraID = @ConsultoraID AND pwd.CUVPadre IS NULL
	AND pwd.PedidoID = @PedidoID 
	AND (pc.CodigoCatalago=35 OR pc.CodigoCatalago=44 OR pc.CodigoCatalago=45 OR pc.CodigoCatalago=46)
GO

USE BelcorpDominicana
GO
IF OBJECT_ID('GetOfertasPlan20ByPedido', 'P') IS NOT NULL
	DROP PROCEDURE GetOfertasPlan20ByPedido
GO

CREATE PROCEDURE [dbo].[GetOfertasPlan20ByPedido]
 @CampaniaID INT,
 @ConsultoraID BIGINT,
 @PedidoID BIGINT
AS
 SELECT COUNT(1) as TieneOfertaPlan20
 FROM dbo.PedidoWebDetalle pwd
	 INNER JOIN dbo.PedidoWeb PW ON PW.PedidoID = pwd.PedidoID and pw.consultoraid=pwd.consultoraid and pw.CampaniaID=pwd.CampaniaID
	 JOIN ods.ProductoComercial pc ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV
	 LEFT JOIN dbo.Cliente c ON pwd.ClienteID = c.ClienteID AND pwd.ConsultoraID = c.ConsultoraID
	 LEFT JOIN dbo.ProductoDescripcion pd ON pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV
WHERE pwd.CampaniaID = @CampaniaID
	AND pwd.ConsultoraID = @ConsultoraID AND pwd.CUVPadre IS NULL
	AND pwd.PedidoID = @PedidoID 
	AND (pc.CodigoCatalago=35 OR pc.CodigoCatalago=44 OR pc.CodigoCatalago=45 OR pc.CodigoCatalago=46)
GO

USE BelcorpEcuador
GO
IF OBJECT_ID('GetOfertasPlan20ByPedido', 'P') IS NOT NULL
	DROP PROCEDURE GetOfertasPlan20ByPedido
GO

CREATE PROCEDURE [dbo].[GetOfertasPlan20ByPedido]
 @CampaniaID INT,
 @ConsultoraID BIGINT,
 @PedidoID BIGINT
AS
 SELECT COUNT(1) as TieneOfertaPlan20
 FROM dbo.PedidoWebDetalle pwd
	 INNER JOIN dbo.PedidoWeb PW ON PW.PedidoID = pwd.PedidoID and pw.consultoraid=pwd.consultoraid and pw.CampaniaID=pwd.CampaniaID
	 JOIN ods.ProductoComercial pc ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV
	 LEFT JOIN dbo.Cliente c ON pwd.ClienteID = c.ClienteID AND pwd.ConsultoraID = c.ConsultoraID
	 LEFT JOIN dbo.ProductoDescripcion pd ON pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV
WHERE pwd.CampaniaID = @CampaniaID
	AND pwd.ConsultoraID = @ConsultoraID AND pwd.CUVPadre IS NULL
	AND pwd.PedidoID = @PedidoID 
	AND (pc.CodigoCatalago=35 OR pc.CodigoCatalago=44 OR pc.CodigoCatalago=45 OR pc.CodigoCatalago=46)
GO

USE BelcorpGuatemala
GO
IF OBJECT_ID('GetOfertasPlan20ByPedido', 'P') IS NOT NULL
	DROP PROCEDURE GetOfertasPlan20ByPedido
GO

CREATE PROCEDURE [dbo].[GetOfertasPlan20ByPedido]
 @CampaniaID INT,
 @ConsultoraID BIGINT,
 @PedidoID BIGINT
AS
 SELECT COUNT(1) as TieneOfertaPlan20
 FROM dbo.PedidoWebDetalle pwd
	 INNER JOIN dbo.PedidoWeb PW ON PW.PedidoID = pwd.PedidoID and pw.consultoraid=pwd.consultoraid and pw.CampaniaID=pwd.CampaniaID
	 JOIN ods.ProductoComercial pc ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV
	 LEFT JOIN dbo.Cliente c ON pwd.ClienteID = c.ClienteID AND pwd.ConsultoraID = c.ConsultoraID
	 LEFT JOIN dbo.ProductoDescripcion pd ON pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV
WHERE pwd.CampaniaID = @CampaniaID
	AND pwd.ConsultoraID = @ConsultoraID AND pwd.CUVPadre IS NULL
	AND pwd.PedidoID = @PedidoID 
	AND (pc.CodigoCatalago=35 OR pc.CodigoCatalago=44 OR pc.CodigoCatalago=45 OR pc.CodigoCatalago=46)
GO

USE BelcorpMexico
GO
IF OBJECT_ID('GetOfertasPlan20ByPedido', 'P') IS NOT NULL
	DROP PROCEDURE GetOfertasPlan20ByPedido
GO

CREATE PROCEDURE [dbo].[GetOfertasPlan20ByPedido]
 @CampaniaID INT,
 @ConsultoraID BIGINT,
 @PedidoID BIGINT
AS
 SELECT COUNT(1) as TieneOfertaPlan20
 FROM dbo.PedidoWebDetalle pwd
	 INNER JOIN dbo.PedidoWeb PW ON PW.PedidoID = pwd.PedidoID and pw.consultoraid=pwd.consultoraid and pw.CampaniaID=pwd.CampaniaID
	 JOIN ods.ProductoComercial pc ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV
	 LEFT JOIN dbo.Cliente c ON pwd.ClienteID = c.ClienteID AND pwd.ConsultoraID = c.ConsultoraID
	 LEFT JOIN dbo.ProductoDescripcion pd ON pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV
WHERE pwd.CampaniaID = @CampaniaID
	AND pwd.ConsultoraID = @ConsultoraID AND pwd.CUVPadre IS NULL
	AND pwd.PedidoID = @PedidoID 
	AND (pc.CodigoCatalago=35 OR pc.CodigoCatalago=44 OR pc.CodigoCatalago=45 OR pc.CodigoCatalago=46)
GO

USE BelcorpPanama
GO
IF OBJECT_ID('GetOfertasPlan20ByPedido', 'P') IS NOT NULL
	DROP PROCEDURE GetOfertasPlan20ByPedido
GO

CREATE PROCEDURE [dbo].[GetOfertasPlan20ByPedido]
 @CampaniaID INT,
 @ConsultoraID BIGINT,
 @PedidoID BIGINT
AS
 SELECT COUNT(1) as TieneOfertaPlan20
 FROM dbo.PedidoWebDetalle pwd
	 INNER JOIN dbo.PedidoWeb PW ON PW.PedidoID = pwd.PedidoID and pw.consultoraid=pwd.consultoraid and pw.CampaniaID=pwd.CampaniaID
	 JOIN ods.ProductoComercial pc ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV
	 LEFT JOIN dbo.Cliente c ON pwd.ClienteID = c.ClienteID AND pwd.ConsultoraID = c.ConsultoraID
	 LEFT JOIN dbo.ProductoDescripcion pd ON pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV
WHERE pwd.CampaniaID = @CampaniaID
	AND pwd.ConsultoraID = @ConsultoraID AND pwd.CUVPadre IS NULL
	AND pwd.PedidoID = @PedidoID 
	AND (pc.CodigoCatalago=35 OR pc.CodigoCatalago=44 OR pc.CodigoCatalago=45 OR pc.CodigoCatalago=46)
GO

USE BelcorpPeru
GO
IF OBJECT_ID('GetOfertasPlan20ByPedido', 'P') IS NOT NULL
	DROP PROCEDURE GetOfertasPlan20ByPedido
GO

CREATE PROCEDURE [dbo].[GetOfertasPlan20ByPedido]
 @CampaniaID INT,
 @ConsultoraID BIGINT,
 @PedidoID BIGINT
AS
 SELECT COUNT(1) as TieneOfertaPlan20
 FROM dbo.PedidoWebDetalle pwd
	 INNER JOIN dbo.PedidoWeb PW ON PW.PedidoID = pwd.PedidoID and pw.consultoraid=pwd.consultoraid and pw.CampaniaID=pwd.CampaniaID
	 JOIN ods.ProductoComercial pc ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV
	 LEFT JOIN dbo.Cliente c ON pwd.ClienteID = c.ClienteID AND pwd.ConsultoraID = c.ConsultoraID
	 LEFT JOIN dbo.ProductoDescripcion pd ON pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV
WHERE pwd.CampaniaID = @CampaniaID
	AND pwd.ConsultoraID = @ConsultoraID AND pwd.CUVPadre IS NULL
	AND pwd.PedidoID = @PedidoID 
	AND (pc.CodigoCatalago=35 OR pc.CodigoCatalago=44 OR pc.CodigoCatalago=45 OR pc.CodigoCatalago=46)
GO

USE BelcorpPuertoRico
GO
IF OBJECT_ID('GetOfertasPlan20ByPedido', 'P') IS NOT NULL
	DROP PROCEDURE GetOfertasPlan20ByPedido
GO

CREATE PROCEDURE [dbo].[GetOfertasPlan20ByPedido]
 @CampaniaID INT,
 @ConsultoraID BIGINT,
 @PedidoID BIGINT
AS
 SELECT COUNT(1) as TieneOfertaPlan20
 FROM dbo.PedidoWebDetalle pwd
	 INNER JOIN dbo.PedidoWeb PW ON PW.PedidoID = pwd.PedidoID and pw.consultoraid=pwd.consultoraid and pw.CampaniaID=pwd.CampaniaID
	 JOIN ods.ProductoComercial pc ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV
	 LEFT JOIN dbo.Cliente c ON pwd.ClienteID = c.ClienteID AND pwd.ConsultoraID = c.ConsultoraID
	 LEFT JOIN dbo.ProductoDescripcion pd ON pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV
WHERE pwd.CampaniaID = @CampaniaID
	AND pwd.ConsultoraID = @ConsultoraID AND pwd.CUVPadre IS NULL
	AND pwd.PedidoID = @PedidoID 
	AND (pc.CodigoCatalago=35 OR pc.CodigoCatalago=44 OR pc.CodigoCatalago=45 OR pc.CodigoCatalago=46)
GO

USE BelcorpSalvador
GO
IF OBJECT_ID('GetOfertasPlan20ByPedido', 'P') IS NOT NULL
	DROP PROCEDURE GetOfertasPlan20ByPedido
GO

CREATE PROCEDURE [dbo].[GetOfertasPlan20ByPedido]
 @CampaniaID INT,
 @ConsultoraID BIGINT,
 @PedidoID BIGINT
AS
 SELECT COUNT(1) as TieneOfertaPlan20
 FROM dbo.PedidoWebDetalle pwd
	 INNER JOIN dbo.PedidoWeb PW ON PW.PedidoID = pwd.PedidoID and pw.consultoraid=pwd.consultoraid and pw.CampaniaID=pwd.CampaniaID
	 JOIN ods.ProductoComercial pc ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV
	 LEFT JOIN dbo.Cliente c ON pwd.ClienteID = c.ClienteID AND pwd.ConsultoraID = c.ConsultoraID
	 LEFT JOIN dbo.ProductoDescripcion pd ON pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV
WHERE pwd.CampaniaID = @CampaniaID
	AND pwd.ConsultoraID = @ConsultoraID AND pwd.CUVPadre IS NULL
	AND pwd.PedidoID = @PedidoID 
	AND (pc.CodigoCatalago=35 OR pc.CodigoCatalago=44 OR pc.CodigoCatalago=45 OR pc.CodigoCatalago=46)
GO

USE BelcorpVenezuela
GO
IF OBJECT_ID('GetOfertasPlan20ByPedido', 'P') IS NOT NULL
	DROP PROCEDURE GetOfertasPlan20ByPedido
GO

CREATE PROCEDURE [dbo].[GetOfertasPlan20ByPedido]
 @CampaniaID INT,
 @ConsultoraID BIGINT,
 @PedidoID BIGINT
AS
 SELECT COUNT(1) as TieneOfertaPlan20
 FROM dbo.PedidoWebDetalle pwd
	 INNER JOIN dbo.PedidoWeb PW ON PW.PedidoID = pwd.PedidoID and pw.consultoraid=pwd.consultoraid and pw.CampaniaID=pwd.CampaniaID
	 JOIN ods.ProductoComercial pc ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV
	 LEFT JOIN dbo.Cliente c ON pwd.ClienteID = c.ClienteID AND pwd.ConsultoraID = c.ConsultoraID
	 LEFT JOIN dbo.ProductoDescripcion pd ON pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV
WHERE pwd.CampaniaID = @CampaniaID
	AND pwd.ConsultoraID = @ConsultoraID AND pwd.CUVPadre IS NULL
	AND pwd.PedidoID = @PedidoID 
	AND (pc.CodigoCatalago=35 OR pc.CodigoCatalago=44 OR pc.CodigoCatalago=45 OR pc.CodigoCatalago=46)
GO






