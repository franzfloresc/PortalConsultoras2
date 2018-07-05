GO
USE BelcorpPeru
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnGetEtiquetaId') AND type IN ( N'TF', N'FN' ) )
	DROP FUNCTION [fnGetEtiquetaId]
GO
CREATE FUNCTION [fnGetEtiquetaId]
(
	@EstrategiaCodigo varchar(100)
)
returns int
begin

	DECLARE @tipoId int = 0
	IF @EstrategiaCodigo = '001'
	BEGIN
		SELECT @tipoId = EtiquetaID FROM Etiqueta
		WHERE Descripcion like '%' + UPPER('Precio para T') + '%'
	END

	IF @EstrategiaCodigo = '009'
	BEGIN
		SELECT @tipoId = EtiquetaID FROM Etiqueta
		WHERE Descripcion like '%' + UPPER('OFERTA DEL DÍA') + '%'
	END
	IF @EstrategiaCodigo = '020'
	BEGIN
		SELECT @tipoId = EtiquetaID FROM Etiqueta
		WHERE Descripcion like '%' + UPPER('Los más vendidos') + '%'
	END

	return @tipoId
end
GO

GO
USE BelcorpMexico
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnGetEtiquetaId') AND type IN ( N'TF', N'FN' ) )
	DROP FUNCTION [fnGetEtiquetaId]
GO
CREATE FUNCTION [fnGetEtiquetaId]
(
	@EstrategiaCodigo varchar(100)
)
returns int
begin

	DECLARE @tipoId int = 0
	IF @EstrategiaCodigo = '001'
	BEGIN
		SELECT @tipoId = EtiquetaID FROM Etiqueta
		WHERE Descripcion like '%' + UPPER('Precio para T') + '%'
	END

	IF @EstrategiaCodigo = '009'
	BEGIN
		SELECT @tipoId = EtiquetaID FROM Etiqueta
		WHERE Descripcion like '%' + UPPER('OFERTA DEL DÍA') + '%'
	END
	IF @EstrategiaCodigo = '020'
	BEGIN
		SELECT @tipoId = EtiquetaID FROM Etiqueta
		WHERE Descripcion like '%' + UPPER('Los más vendidos') + '%'
	END

	return @tipoId
end
GO

GO
USE BelcorpColombia
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnGetEtiquetaId') AND type IN ( N'TF', N'FN' ) )
	DROP FUNCTION [fnGetEtiquetaId]
GO
CREATE FUNCTION [fnGetEtiquetaId]
(
	@EstrategiaCodigo varchar(100)
)
returns int
begin

	DECLARE @tipoId int = 0
	IF @EstrategiaCodigo = '001'
	BEGIN
		SELECT @tipoId = EtiquetaID FROM Etiqueta
		WHERE Descripcion like '%' + UPPER('Precio para T') + '%'
	END

	IF @EstrategiaCodigo = '009'
	BEGIN
		SELECT @tipoId = EtiquetaID FROM Etiqueta
		WHERE Descripcion like '%' + UPPER('OFERTA DEL DÍA') + '%'
	END
	IF @EstrategiaCodigo = '020'
	BEGIN
		SELECT @tipoId = EtiquetaID FROM Etiqueta
		WHERE Descripcion like '%' + UPPER('Los más vendidos') + '%'
	END

	return @tipoId
end
GO

GO
USE BelcorpSalvador
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnGetEtiquetaId') AND type IN ( N'TF', N'FN' ) )
	DROP FUNCTION [fnGetEtiquetaId]
GO
CREATE FUNCTION [fnGetEtiquetaId]
(
	@EstrategiaCodigo varchar(100)
)
returns int
begin

	DECLARE @tipoId int = 0
	IF @EstrategiaCodigo = '001'
	BEGIN
		SELECT @tipoId = EtiquetaID FROM Etiqueta
		WHERE Descripcion like '%' + UPPER('Precio para T') + '%'
	END

	IF @EstrategiaCodigo = '009'
	BEGIN
		SELECT @tipoId = EtiquetaID FROM Etiqueta
		WHERE Descripcion like '%' + UPPER('OFERTA DEL DÍA') + '%'
	END
	IF @EstrategiaCodigo = '020'
	BEGIN
		SELECT @tipoId = EtiquetaID FROM Etiqueta
		WHERE Descripcion like '%' + UPPER('Los más vendidos') + '%'
	END

	return @tipoId
end
GO

GO
USE BelcorpPuertoRico
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnGetEtiquetaId') AND type IN ( N'TF', N'FN' ) )
	DROP FUNCTION [fnGetEtiquetaId]
GO
CREATE FUNCTION [fnGetEtiquetaId]
(
	@EstrategiaCodigo varchar(100)
)
returns int
begin

	DECLARE @tipoId int = 0
	IF @EstrategiaCodigo = '001'
	BEGIN
		SELECT @tipoId = EtiquetaID FROM Etiqueta
		WHERE Descripcion like '%' + UPPER('Precio para T') + '%'
	END

	IF @EstrategiaCodigo = '009'
	BEGIN
		SELECT @tipoId = EtiquetaID FROM Etiqueta
		WHERE Descripcion like '%' + UPPER('OFERTA DEL DÍA') + '%'
	END
	IF @EstrategiaCodigo = '020'
	BEGIN
		SELECT @tipoId = EtiquetaID FROM Etiqueta
		WHERE Descripcion like '%' + UPPER('Los más vendidos') + '%'
	END

	return @tipoId
end
GO

GO
USE BelcorpPanama
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnGetEtiquetaId') AND type IN ( N'TF', N'FN' ) )
	DROP FUNCTION [fnGetEtiquetaId]
GO
CREATE FUNCTION [fnGetEtiquetaId]
(
	@EstrategiaCodigo varchar(100)
)
returns int
begin

	DECLARE @tipoId int = 0
	IF @EstrategiaCodigo = '001'
	BEGIN
		SELECT @tipoId = EtiquetaID FROM Etiqueta
		WHERE Descripcion like '%' + UPPER('Precio para T') + '%'
	END

	IF @EstrategiaCodigo = '009'
	BEGIN
		SELECT @tipoId = EtiquetaID FROM Etiqueta
		WHERE Descripcion like '%' + UPPER('OFERTA DEL DÍA') + '%'
	END
	IF @EstrategiaCodigo = '020'
	BEGIN
		SELECT @tipoId = EtiquetaID FROM Etiqueta
		WHERE Descripcion like '%' + UPPER('Los más vendidos') + '%'
	END

	return @tipoId
end
GO

GO
USE BelcorpGuatemala
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnGetEtiquetaId') AND type IN ( N'TF', N'FN' ) )
	DROP FUNCTION [fnGetEtiquetaId]
GO
CREATE FUNCTION [fnGetEtiquetaId]
(
	@EstrategiaCodigo varchar(100)
)
returns int
begin

	DECLARE @tipoId int = 0
	IF @EstrategiaCodigo = '001'
	BEGIN
		SELECT @tipoId = EtiquetaID FROM Etiqueta
		WHERE Descripcion like '%' + UPPER('Precio para T') + '%'
	END

	IF @EstrategiaCodigo = '009'
	BEGIN
		SELECT @tipoId = EtiquetaID FROM Etiqueta
		WHERE Descripcion like '%' + UPPER('OFERTA DEL DÍA') + '%'
	END
	IF @EstrategiaCodigo = '020'
	BEGIN
		SELECT @tipoId = EtiquetaID FROM Etiqueta
		WHERE Descripcion like '%' + UPPER('Los más vendidos') + '%'
	END

	return @tipoId
end
GO

GO
USE BelcorpEcuador
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnGetEtiquetaId') AND type IN ( N'TF', N'FN' ) )
	DROP FUNCTION [fnGetEtiquetaId]
GO
CREATE FUNCTION [fnGetEtiquetaId]
(
	@EstrategiaCodigo varchar(100)
)
returns int
begin

	DECLARE @tipoId int = 0
	IF @EstrategiaCodigo = '001'
	BEGIN
		SELECT @tipoId = EtiquetaID FROM Etiqueta
		WHERE Descripcion like '%' + UPPER('Precio para T') + '%'
	END

	IF @EstrategiaCodigo = '009'
	BEGIN
		SELECT @tipoId = EtiquetaID FROM Etiqueta
		WHERE Descripcion like '%' + UPPER('OFERTA DEL DÍA') + '%'
	END
	IF @EstrategiaCodigo = '020'
	BEGIN
		SELECT @tipoId = EtiquetaID FROM Etiqueta
		WHERE Descripcion like '%' + UPPER('Los más vendidos') + '%'
	END

	return @tipoId
end
GO

GO
USE BelcorpDominicana
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnGetEtiquetaId') AND type IN ( N'TF', N'FN' ) )
	DROP FUNCTION [fnGetEtiquetaId]
GO
CREATE FUNCTION [fnGetEtiquetaId]
(
	@EstrategiaCodigo varchar(100)
)
returns int
begin

	DECLARE @tipoId int = 0
	IF @EstrategiaCodigo = '001'
	BEGIN
		SELECT @tipoId = EtiquetaID FROM Etiqueta
		WHERE Descripcion like '%' + UPPER('Precio para T') + '%'
	END

	IF @EstrategiaCodigo = '009'
	BEGIN
		SELECT @tipoId = EtiquetaID FROM Etiqueta
		WHERE Descripcion like '%' + UPPER('OFERTA DEL DÍA') + '%'
	END
	IF @EstrategiaCodigo = '020'
	BEGIN
		SELECT @tipoId = EtiquetaID FROM Etiqueta
		WHERE Descripcion like '%' + UPPER('Los más vendidos') + '%'
	END

	return @tipoId
end
GO

GO
USE BelcorpCostaRica
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnGetEtiquetaId') AND type IN ( N'TF', N'FN' ) )
	DROP FUNCTION [fnGetEtiquetaId]
GO
CREATE FUNCTION [fnGetEtiquetaId]
(
	@EstrategiaCodigo varchar(100)
)
returns int
begin

	DECLARE @tipoId int = 0
	IF @EstrategiaCodigo = '001'
	BEGIN
		SELECT @tipoId = EtiquetaID FROM Etiqueta
		WHERE Descripcion like '%' + UPPER('Precio para T') + '%'
	END

	IF @EstrategiaCodigo = '009'
	BEGIN
		SELECT @tipoId = EtiquetaID FROM Etiqueta
		WHERE Descripcion like '%' + UPPER('OFERTA DEL DÍA') + '%'
	END
	IF @EstrategiaCodigo = '020'
	BEGIN
		SELECT @tipoId = EtiquetaID FROM Etiqueta
		WHERE Descripcion like '%' + UPPER('Los más vendidos') + '%'
	END

	return @tipoId
end
GO

GO
USE BelcorpChile
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnGetEtiquetaId') AND type IN ( N'TF', N'FN' ) )
	DROP FUNCTION [fnGetEtiquetaId]
GO
CREATE FUNCTION [fnGetEtiquetaId]
(
	@EstrategiaCodigo varchar(100)
)
returns int
begin

	DECLARE @tipoId int = 0
	IF @EstrategiaCodigo = '001'
	BEGIN
		SELECT @tipoId = EtiquetaID FROM Etiqueta
		WHERE Descripcion like '%' + UPPER('Precio para T') + '%'
	END

	IF @EstrategiaCodigo = '009'
	BEGIN
		SELECT @tipoId = EtiquetaID FROM Etiqueta
		WHERE Descripcion like '%' + UPPER('OFERTA DEL DÍA') + '%'
	END
	IF @EstrategiaCodigo = '020'
	BEGIN
		SELECT @tipoId = EtiquetaID FROM Etiqueta
		WHERE Descripcion like '%' + UPPER('Los más vendidos') + '%'
	END

	return @tipoId
end
GO

GO
USE BelcorpBolivia
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnGetEtiquetaId') AND type IN ( N'TF', N'FN' ) )
	DROP FUNCTION [fnGetEtiquetaId]
GO
CREATE FUNCTION [fnGetEtiquetaId]
(
	@EstrategiaCodigo varchar(100)
)
returns int
begin

	DECLARE @tipoId int = 0
	IF @EstrategiaCodigo = '001'
	BEGIN
		SELECT @tipoId = EtiquetaID FROM Etiqueta
		WHERE Descripcion like '%' + UPPER('Precio para T') + '%'
	END

	IF @EstrategiaCodigo = '009'
	BEGIN
		SELECT @tipoId = EtiquetaID FROM Etiqueta
		WHERE Descripcion like '%' + UPPER('OFERTA DEL DÍA') + '%'
	END
	IF @EstrategiaCodigo = '020'
	BEGIN
		SELECT @tipoId = EtiquetaID FROM Etiqueta
		WHERE Descripcion like '%' + UPPER('Los más vendidos') + '%'
	END

	return @tipoId
end
GO

GO
