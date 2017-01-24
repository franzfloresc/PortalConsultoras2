
USE BelcorpBolivia
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetDatosSapProductoByListaCuv_SB2'))
BEGIN
    DROP PROCEDURE dbo.GetDatosSapProductoByListaCuv_SB2
END

GO

CREATE PROCEDURE [dbo].[GetDatosSapProductoByListaCuv_SB2]
(
	@CampaniaID INT,
	@ListaCuv VARCHAR(MAX)
)
AS

BEGIN

SELECT p.CUV, sp.CodigoSap, sp.CodigoCategoria
from ods.ProductoComercial p
INNER JOIN ods.Campania c ON p.CampaniaID = c.CampaniaID
INNER JOIN ods.SAP_PRODUCTO sp ON p.CodigoProducto = sp.CodigoSap
WHERE c.Codigo = @CampaniaID
--and p.CUV = @CUV
AND p.CUV IN ( SELECT splitdata FROM fnSplitString(@ListaCUV,',') )

END

GO
/*end*/

USE BelcorpChile
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetDatosSapProductoByListaCuv_SB2'))
BEGIN
    DROP PROCEDURE dbo.GetDatosSapProductoByListaCuv_SB2
END

GO

CREATE PROCEDURE [dbo].[GetDatosSapProductoByListaCuv_SB2]
(
	@CampaniaID INT,
	@ListaCuv VARCHAR(MAX)
)
AS

BEGIN

SELECT p.CUV, sp.CodigoSap, sp.CodigoCategoria
from ods.ProductoComercial p
INNER JOIN ods.Campania c ON p.CampaniaID = c.CampaniaID
INNER JOIN ods.SAP_PRODUCTO sp ON p.CodigoProducto = sp.CodigoSap
WHERE c.Codigo = @CampaniaID
--and p.CUV = @CUV
AND p.CUV IN ( SELECT splitdata FROM fnSplitString(@ListaCUV,',') )

END

GO
/*end*/

USE BelcorpColombia
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetDatosSapProductoByListaCuv_SB2'))
BEGIN
    DROP PROCEDURE dbo.GetDatosSapProductoByListaCuv_SB2
END

GO

CREATE PROCEDURE [dbo].[GetDatosSapProductoByListaCuv_SB2]
(
	@CampaniaID INT,
	@ListaCuv VARCHAR(MAX)
)
AS

BEGIN

SELECT p.CUV, sp.CodigoSap, sp.CodigoCategoria
from ods.ProductoComercial p
INNER JOIN ods.Campania c ON p.CampaniaID = c.CampaniaID
INNER JOIN ods.SAP_PRODUCTO sp ON p.CodigoProducto = sp.CodigoSap
WHERE c.Codigo = @CampaniaID
--and p.CUV = @CUV
AND p.CUV IN ( SELECT splitdata FROM fnSplitString(@ListaCUV,',') )

END

GO
/*end*/

USE BelcorpCostaRica
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetDatosSapProductoByListaCuv_SB2'))
BEGIN
    DROP PROCEDURE dbo.GetDatosSapProductoByListaCuv_SB2
END

GO

CREATE PROCEDURE [dbo].[GetDatosSapProductoByListaCuv_SB2]
(
	@CampaniaID INT,
	@ListaCuv VARCHAR(MAX)
)
AS

BEGIN

SELECT p.CUV, sp.CodigoSap, sp.CodigoCategoria
from ods.ProductoComercial p
INNER JOIN ods.Campania c ON p.CampaniaID = c.CampaniaID
INNER JOIN ods.SAP_PRODUCTO sp ON p.CodigoProducto = sp.CodigoSap
WHERE c.Codigo = @CampaniaID
--and p.CUV = @CUV
AND p.CUV IN ( SELECT splitdata FROM fnSplitString(@ListaCUV,',') )

END

GO
/*end*/

USE BelcorpDominicana
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetDatosSapProductoByListaCuv_SB2'))
BEGIN
    DROP PROCEDURE dbo.GetDatosSapProductoByListaCuv_SB2
END

GO

CREATE PROCEDURE [dbo].[GetDatosSapProductoByListaCuv_SB2]
(
	@CampaniaID INT,
	@ListaCuv VARCHAR(MAX)
)
AS

BEGIN

SELECT p.CUV, sp.CodigoSap, sp.CodigoCategoria
from ods.ProductoComercial p
INNER JOIN ods.Campania c ON p.CampaniaID = c.CampaniaID
INNER JOIN ods.SAP_PRODUCTO sp ON p.CodigoProducto = sp.CodigoSap
WHERE c.Codigo = @CampaniaID
--and p.CUV = @CUV
AND p.CUV IN ( SELECT splitdata FROM fnSplitString(@ListaCUV,',') )

END

GO
/*end*/

USE BelcorpEcuador
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetDatosSapProductoByListaCuv_SB2'))
BEGIN
    DROP PROCEDURE dbo.GetDatosSapProductoByListaCuv_SB2
END

GO

CREATE PROCEDURE [dbo].[GetDatosSapProductoByListaCuv_SB2]
(
	@CampaniaID INT,
	@ListaCuv VARCHAR(MAX)
)
AS

BEGIN

SELECT p.CUV, sp.CodigoSap, sp.CodigoCategoria
from ods.ProductoComercial p
INNER JOIN ods.Campania c ON p.CampaniaID = c.CampaniaID
INNER JOIN ods.SAP_PRODUCTO sp ON p.CodigoProducto = sp.CodigoSap
WHERE c.Codigo = @CampaniaID
--and p.CUV = @CUV
AND p.CUV IN ( SELECT splitdata FROM fnSplitString(@ListaCUV,',') )

END

GO
/*end*/

USE BelcorpGuatemala
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetDatosSapProductoByListaCuv_SB2'))
BEGIN
    DROP PROCEDURE dbo.GetDatosSapProductoByListaCuv_SB2
END

GO

CREATE PROCEDURE [dbo].[GetDatosSapProductoByListaCuv_SB2]
(
	@CampaniaID INT,
	@ListaCuv VARCHAR(MAX)
)
AS

BEGIN

SELECT p.CUV, sp.CodigoSap, sp.CodigoCategoria
from ods.ProductoComercial p
INNER JOIN ods.Campania c ON p.CampaniaID = c.CampaniaID
INNER JOIN ods.SAP_PRODUCTO sp ON p.CodigoProducto = sp.CodigoSap
WHERE c.Codigo = @CampaniaID
--and p.CUV = @CUV
AND p.CUV IN ( SELECT splitdata FROM fnSplitString(@ListaCUV,',') )

END

GO
/*end*/

USE BelcorpMexico
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetDatosSapProductoByListaCuv_SB2'))
BEGIN
    DROP PROCEDURE dbo.GetDatosSapProductoByListaCuv_SB2
END

GO

CREATE PROCEDURE [dbo].[GetDatosSapProductoByListaCuv_SB2]
(
	@CampaniaID INT,
	@ListaCuv VARCHAR(MAX)
)
AS

BEGIN

SELECT p.CUV, sp.CodigoSap, sp.CodigoCategoria
from ods.ProductoComercial p
INNER JOIN ods.Campania c ON p.CampaniaID = c.CampaniaID
INNER JOIN ods.SAP_PRODUCTO sp ON p.CodigoProducto = sp.CodigoSap
WHERE c.Codigo = @CampaniaID
--and p.CUV = @CUV
AND p.CUV IN ( SELECT splitdata FROM fnSplitString(@ListaCUV,',') )

END

GO
/*end*/

USE BelcorpPanama
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetDatosSapProductoByListaCuv_SB2'))
BEGIN
    DROP PROCEDURE dbo.GetDatosSapProductoByListaCuv_SB2
END

GO

CREATE PROCEDURE [dbo].[GetDatosSapProductoByListaCuv_SB2]
(
	@CampaniaID INT,
	@ListaCuv VARCHAR(MAX)
)
AS

BEGIN

SELECT p.CUV, sp.CodigoSap, sp.CodigoCategoria
from ods.ProductoComercial p
INNER JOIN ods.Campania c ON p.CampaniaID = c.CampaniaID
INNER JOIN ods.SAP_PRODUCTO sp ON p.CodigoProducto = sp.CodigoSap
WHERE c.Codigo = @CampaniaID
--and p.CUV = @CUV
AND p.CUV IN ( SELECT splitdata FROM fnSplitString(@ListaCUV,',') )

END

GO
/*end*/

USE BelcorpPeru
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetDatosSapProductoByListaCuv_SB2'))
BEGIN
    DROP PROCEDURE dbo.GetDatosSapProductoByListaCuv_SB2
END

GO

CREATE PROCEDURE [dbo].[GetDatosSapProductoByListaCuv_SB2]
(
	@CampaniaID INT,
	@ListaCuv VARCHAR(MAX)
)
AS

BEGIN

SELECT p.CUV, sp.CodigoSap, sp.CodigoCategoria
from ods.ProductoComercial p
INNER JOIN ods.Campania c ON p.CampaniaID = c.CampaniaID
INNER JOIN ods.SAP_PRODUCTO sp ON p.CodigoProducto = sp.CodigoSap
WHERE c.Codigo = @CampaniaID
--and p.CUV = @CUV
AND p.CUV IN ( SELECT splitdata FROM fnSplitString(@ListaCUV,',') )

END

GO
/*end*/

USE BelcorpPuertoRico
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetDatosSapProductoByListaCuv_SB2'))
BEGIN
    DROP PROCEDURE dbo.GetDatosSapProductoByListaCuv_SB2
END

GO

CREATE PROCEDURE [dbo].[GetDatosSapProductoByListaCuv_SB2]
(
	@CampaniaID INT,
	@ListaCuv VARCHAR(MAX)
)
AS

BEGIN

SELECT p.CUV, sp.CodigoSap, sp.CodigoCategoria
from ods.ProductoComercial p
INNER JOIN ods.Campania c ON p.CampaniaID = c.CampaniaID
INNER JOIN ods.SAP_PRODUCTO sp ON p.CodigoProducto = sp.CodigoSap
WHERE c.Codigo = @CampaniaID
--and p.CUV = @CUV
AND p.CUV IN ( SELECT splitdata FROM fnSplitString(@ListaCUV,',') )

END

GO
/*end*/

USE BelcorpSalvador
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetDatosSapProductoByListaCuv_SB2'))
BEGIN
    DROP PROCEDURE dbo.GetDatosSapProductoByListaCuv_SB2
END

GO

CREATE PROCEDURE [dbo].[GetDatosSapProductoByListaCuv_SB2]
(
	@CampaniaID INT,
	@ListaCuv VARCHAR(MAX)
)
AS

BEGIN

SELECT p.CUV, sp.CodigoSap, sp.CodigoCategoria
from ods.ProductoComercial p
INNER JOIN ods.Campania c ON p.CampaniaID = c.CampaniaID
INNER JOIN ods.SAP_PRODUCTO sp ON p.CodigoProducto = sp.CodigoSap
WHERE c.Codigo = @CampaniaID
--and p.CUV = @CUV
AND p.CUV IN ( SELECT splitdata FROM fnSplitString(@ListaCUV,',') )

END

GO
/*end*/

USE BelcorpVenezuela
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetDatosSapProductoByListaCuv_SB2'))
BEGIN
    DROP PROCEDURE dbo.GetDatosSapProductoByListaCuv_SB2
END

GO

CREATE PROCEDURE [dbo].[GetDatosSapProductoByListaCuv_SB2]
(
	@CampaniaID INT,
	@ListaCuv VARCHAR(MAX)
)
AS

BEGIN

SELECT p.CUV, sp.CodigoSap, sp.CodigoCategoria
from ods.ProductoComercial p
INNER JOIN ods.Campania c ON p.CampaniaID = c.CampaniaID
INNER JOIN ods.SAP_PRODUCTO sp ON p.CodigoProducto = sp.CodigoSap
WHERE c.Codigo = @CampaniaID
--and p.CUV = @CUV
AND p.CUV IN ( SELECT splitdata FROM fnSplitString(@ListaCUV,',') )

END

GO