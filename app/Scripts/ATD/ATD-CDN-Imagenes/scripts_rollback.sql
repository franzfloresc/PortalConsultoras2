USE BelcorpPeru
GO

declare @BucketAntiguoQA varchar(100) = 'd1y60eoca8fkyl.cloudfront.net/'
declare @BucketNuevoQA varchar(100) = 'S3.amazonaws.com/consultorasQAS/SomosBelcorp/'

declare @BucketAntiguoPRD varchar(100) = 'd1y60eoca8fkyl.cloudfront.net/'
declare @BucketNuevoPRD varchar(100) = 'S3.amazonaws.com/consultorasPRD/SomosBelcorp/'

--select * from ProductoSugerido
update ProductoSugerido set ImagenProducto = replace(ImagenProducto, @BucketAntiguoQA, @BucketNuevoQA)
update ProductoSugerido set ImagenProducto = replace(ImagenProducto, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from Comunicado
update Comunicado set UrlImagen = replace(UrlImagen, @BucketAntiguoQA, @BucketNuevoQA)
update Comunicado set UrlImagen = replace(UrlImagen, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from EventoFestivo
update EventoFestivo set Personalizacion = replace(Personalizacion, @BucketAntiguoQA, @BucketNuevoQA)
update EventoFestivo set Personalizacion = replace(Personalizacion, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from Incentivo
update Incentivo set ArchivoPortada = replace(ArchivoPortada, @BucketAntiguoQA, @BucketNuevoQA)
update Incentivo set ArchivoPortada = replace(ArchivoPortada, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from ItemCarruselInicio
update ItemCarruselInicio set TextoLink = replace(TextoLink, @BucketAntiguoQA, @BucketNuevoQA)
update ItemCarruselInicio set TextoLink = replace(TextoLink, @BucketAntiguoPRD, @BucketNuevoPRD)
update ItemCarruselInicio set UrlImagenPrincipal = replace(UrlImagenPrincipal, @BucketAntiguoQA, @BucketNuevoQA)
update ItemCarruselInicio set UrlImagenPrincipal = replace(UrlImagenPrincipal, @BucketAntiguoPRD, @BucketNuevoPRD)
update ItemCarruselInicio set UrlImagenTitulo = replace(UrlImagenTitulo, @BucketAntiguoQA, @BucketNuevoQA)
update ItemCarruselInicio set UrlImagenTitulo = replace(UrlImagenTitulo, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from Permiso
update Permiso set UrlImagen = replace(UrlImagen, @BucketAntiguoQA, @BucketNuevoQA)
update Permiso set UrlImagen = replace(UrlImagen, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from ProductoCompartido
update ProductoCompartido set Detalle = replace(Detalle, @BucketAntiguoQA, @BucketNuevoQA)
update ProductoCompartido set Detalle = replace(Detalle, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from ProductoSugerido
update ProductoSugerido set ImagenProducto = replace(ImagenProducto, @BucketAntiguoQA, @BucketNuevoQA)
update ProductoSugerido set ImagenProducto = replace(ImagenProducto, @BucketAntiguoPRD, @BucketNuevoPRD)

--[Unete].[ArchivoCSS].[Url]
--[Unete].[Formulario].[LinkAceptoTerminosYCondiciones]
--[Unete].[SeccionAsesoriaItem].[UrlImagen]
--[Unete].[SeccionFooterItem].[UrlIcono]
--[Unete].[SeccionFooterItem].[UrlWeb]
--[Unete].[SeccionGananciaItem].[UrlImagen]
--[Unete].[SeccionIniciaNegocio].[UrlImagenFondo]
--[Unete].[SeccionInicio].[UrlImagenFondoMovil]
--[Unete].[SeccionInicio].[UrlImagenFondoWeb]
--[Unete].[SeccionNuestrosProductos].[UrlImagenCatalogo]
--[Unete].[SeccionNuestrosProductosItem].[UrlImagen]
--[Unete].[SeccionNuestrosProductosItem].[UrlImagenHover]
--[Unete].[SeccionTestimonio].[UrlBoton]

go

USE BelcorpMexico
GO

declare @BucketAntiguoQA varchar(100) = 'd1y60eoca8fkyl.cloudfront.net/'
declare @BucketNuevoQA varchar(100) = 'S3.amazonaws.com/consultorasQAS/SomosBelcorp/'

declare @BucketAntiguoPRD varchar(100) = 'd1y60eoca8fkyl.cloudfront.net/'
declare @BucketNuevoPRD varchar(100) = 'S3.amazonaws.com/consultorasPRD/SomosBelcorp/'

--select * from ProductoSugerido
update ProductoSugerido set ImagenProducto = replace(ImagenProducto, @BucketAntiguoQA, @BucketNuevoQA)
update ProductoSugerido set ImagenProducto = replace(ImagenProducto, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from Comunicado
update Comunicado set UrlImagen = replace(UrlImagen, @BucketAntiguoQA, @BucketNuevoQA)
update Comunicado set UrlImagen = replace(UrlImagen, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from EventoFestivo
update EventoFestivo set Personalizacion = replace(Personalizacion, @BucketAntiguoQA, @BucketNuevoQA)
update EventoFestivo set Personalizacion = replace(Personalizacion, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from Incentivo
update Incentivo set ArchivoPortada = replace(ArchivoPortada, @BucketAntiguoQA, @BucketNuevoQA)
update Incentivo set ArchivoPortada = replace(ArchivoPortada, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from ItemCarruselInicio
update ItemCarruselInicio set TextoLink = replace(TextoLink, @BucketAntiguoQA, @BucketNuevoQA)
update ItemCarruselInicio set TextoLink = replace(TextoLink, @BucketAntiguoPRD, @BucketNuevoPRD)
update ItemCarruselInicio set UrlImagenPrincipal = replace(UrlImagenPrincipal, @BucketAntiguoQA, @BucketNuevoQA)
update ItemCarruselInicio set UrlImagenPrincipal = replace(UrlImagenPrincipal, @BucketAntiguoPRD, @BucketNuevoPRD)
update ItemCarruselInicio set UrlImagenTitulo = replace(UrlImagenTitulo, @BucketAntiguoQA, @BucketNuevoQA)
update ItemCarruselInicio set UrlImagenTitulo = replace(UrlImagenTitulo, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from Permiso
update Permiso set UrlImagen = replace(UrlImagen, @BucketAntiguoQA, @BucketNuevoQA)
update Permiso set UrlImagen = replace(UrlImagen, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from ProductoCompartido
update ProductoCompartido set Detalle = replace(Detalle, @BucketAntiguoQA, @BucketNuevoQA)
update ProductoCompartido set Detalle = replace(Detalle, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from ProductoSugerido
update ProductoSugerido set ImagenProducto = replace(ImagenProducto, @BucketAntiguoQA, @BucketNuevoQA)
update ProductoSugerido set ImagenProducto = replace(ImagenProducto, @BucketAntiguoPRD, @BucketNuevoPRD)

--[Unete].[ArchivoCSS].[Url]
--[Unete].[Formulario].[LinkAceptoTerminosYCondiciones]
--[Unete].[SeccionAsesoriaItem].[UrlImagen]
--[Unete].[SeccionFooterItem].[UrlIcono]
--[Unete].[SeccionFooterItem].[UrlWeb]
--[Unete].[SeccionGananciaItem].[UrlImagen]
--[Unete].[SeccionIniciaNegocio].[UrlImagenFondo]
--[Unete].[SeccionInicio].[UrlImagenFondoMovil]
--[Unete].[SeccionInicio].[UrlImagenFondoWeb]
--[Unete].[SeccionNuestrosProductos].[UrlImagenCatalogo]
--[Unete].[SeccionNuestrosProductosItem].[UrlImagen]
--[Unete].[SeccionNuestrosProductosItem].[UrlImagenHover]
--[Unete].[SeccionTestimonio].[UrlBoton]

go

USE BelcorpColombia
GO

declare @BucketAntiguoQA varchar(100) = 'd1y60eoca8fkyl.cloudfront.net/'
declare @BucketNuevoQA varchar(100) = 'S3.amazonaws.com/consultorasQAS/SomosBelcorp/'

declare @BucketAntiguoPRD varchar(100) = 'd1y60eoca8fkyl.cloudfront.net/'
declare @BucketNuevoPRD varchar(100) = 'S3.amazonaws.com/consultorasPRD/SomosBelcorp/'

--select * from ProductoSugerido
update ProductoSugerido set ImagenProducto = replace(ImagenProducto, @BucketAntiguoQA, @BucketNuevoQA)
update ProductoSugerido set ImagenProducto = replace(ImagenProducto, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from Comunicado
update Comunicado set UrlImagen = replace(UrlImagen, @BucketAntiguoQA, @BucketNuevoQA)
update Comunicado set UrlImagen = replace(UrlImagen, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from EventoFestivo
update EventoFestivo set Personalizacion = replace(Personalizacion, @BucketAntiguoQA, @BucketNuevoQA)
update EventoFestivo set Personalizacion = replace(Personalizacion, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from Incentivo
update Incentivo set ArchivoPortada = replace(ArchivoPortada, @BucketAntiguoQA, @BucketNuevoQA)
update Incentivo set ArchivoPortada = replace(ArchivoPortada, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from ItemCarruselInicio
update ItemCarruselInicio set TextoLink = replace(TextoLink, @BucketAntiguoQA, @BucketNuevoQA)
update ItemCarruselInicio set TextoLink = replace(TextoLink, @BucketAntiguoPRD, @BucketNuevoPRD)
update ItemCarruselInicio set UrlImagenPrincipal = replace(UrlImagenPrincipal, @BucketAntiguoQA, @BucketNuevoQA)
update ItemCarruselInicio set UrlImagenPrincipal = replace(UrlImagenPrincipal, @BucketAntiguoPRD, @BucketNuevoPRD)
update ItemCarruselInicio set UrlImagenTitulo = replace(UrlImagenTitulo, @BucketAntiguoQA, @BucketNuevoQA)
update ItemCarruselInicio set UrlImagenTitulo = replace(UrlImagenTitulo, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from Permiso
update Permiso set UrlImagen = replace(UrlImagen, @BucketAntiguoQA, @BucketNuevoQA)
update Permiso set UrlImagen = replace(UrlImagen, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from ProductoCompartido
update ProductoCompartido set Detalle = replace(Detalle, @BucketAntiguoQA, @BucketNuevoQA)
update ProductoCompartido set Detalle = replace(Detalle, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from ProductoSugerido
update ProductoSugerido set ImagenProducto = replace(ImagenProducto, @BucketAntiguoQA, @BucketNuevoQA)
update ProductoSugerido set ImagenProducto = replace(ImagenProducto, @BucketAntiguoPRD, @BucketNuevoPRD)

--[Unete].[ArchivoCSS].[Url]
--[Unete].[Formulario].[LinkAceptoTerminosYCondiciones]
--[Unete].[SeccionAsesoriaItem].[UrlImagen]
--[Unete].[SeccionFooterItem].[UrlIcono]
--[Unete].[SeccionFooterItem].[UrlWeb]
--[Unete].[SeccionGananciaItem].[UrlImagen]
--[Unete].[SeccionIniciaNegocio].[UrlImagenFondo]
--[Unete].[SeccionInicio].[UrlImagenFondoMovil]
--[Unete].[SeccionInicio].[UrlImagenFondoWeb]
--[Unete].[SeccionNuestrosProductos].[UrlImagenCatalogo]
--[Unete].[SeccionNuestrosProductosItem].[UrlImagen]
--[Unete].[SeccionNuestrosProductosItem].[UrlImagenHover]
--[Unete].[SeccionTestimonio].[UrlBoton]

go

USE BelcorpVenezuela
GO

declare @BucketAntiguoQA varchar(100) = 'd1y60eoca8fkyl.cloudfront.net/'
declare @BucketNuevoQA varchar(100) = 'S3.amazonaws.com/consultorasQAS/SomosBelcorp/'

declare @BucketAntiguoPRD varchar(100) = 'd1y60eoca8fkyl.cloudfront.net/'
declare @BucketNuevoPRD varchar(100) = 'S3.amazonaws.com/consultorasPRD/SomosBelcorp/'

--select * from ProductoSugerido
update ProductoSugerido set ImagenProducto = replace(ImagenProducto, @BucketAntiguoQA, @BucketNuevoQA)
update ProductoSugerido set ImagenProducto = replace(ImagenProducto, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from Comunicado
update Comunicado set UrlImagen = replace(UrlImagen, @BucketAntiguoQA, @BucketNuevoQA)
update Comunicado set UrlImagen = replace(UrlImagen, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from EventoFestivo
update EventoFestivo set Personalizacion = replace(Personalizacion, @BucketAntiguoQA, @BucketNuevoQA)
update EventoFestivo set Personalizacion = replace(Personalizacion, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from Incentivo
update Incentivo set ArchivoPortada = replace(ArchivoPortada, @BucketAntiguoQA, @BucketNuevoQA)
update Incentivo set ArchivoPortada = replace(ArchivoPortada, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from ItemCarruselInicio
update ItemCarruselInicio set TextoLink = replace(TextoLink, @BucketAntiguoQA, @BucketNuevoQA)
update ItemCarruselInicio set TextoLink = replace(TextoLink, @BucketAntiguoPRD, @BucketNuevoPRD)
update ItemCarruselInicio set UrlImagenPrincipal = replace(UrlImagenPrincipal, @BucketAntiguoQA, @BucketNuevoQA)
update ItemCarruselInicio set UrlImagenPrincipal = replace(UrlImagenPrincipal, @BucketAntiguoPRD, @BucketNuevoPRD)
update ItemCarruselInicio set UrlImagenTitulo = replace(UrlImagenTitulo, @BucketAntiguoQA, @BucketNuevoQA)
update ItemCarruselInicio set UrlImagenTitulo = replace(UrlImagenTitulo, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from Permiso
update Permiso set UrlImagen = replace(UrlImagen, @BucketAntiguoQA, @BucketNuevoQA)
update Permiso set UrlImagen = replace(UrlImagen, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from ProductoCompartido
update ProductoCompartido set Detalle = replace(Detalle, @BucketAntiguoQA, @BucketNuevoQA)
update ProductoCompartido set Detalle = replace(Detalle, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from ProductoSugerido
update ProductoSugerido set ImagenProducto = replace(ImagenProducto, @BucketAntiguoQA, @BucketNuevoQA)
update ProductoSugerido set ImagenProducto = replace(ImagenProducto, @BucketAntiguoPRD, @BucketNuevoPRD)

--[Unete].[ArchivoCSS].[Url]
--[Unete].[Formulario].[LinkAceptoTerminosYCondiciones]
--[Unete].[SeccionAsesoriaItem].[UrlImagen]
--[Unete].[SeccionFooterItem].[UrlIcono]
--[Unete].[SeccionFooterItem].[UrlWeb]
--[Unete].[SeccionGananciaItem].[UrlImagen]
--[Unete].[SeccionIniciaNegocio].[UrlImagenFondo]
--[Unete].[SeccionInicio].[UrlImagenFondoMovil]
--[Unete].[SeccionInicio].[UrlImagenFondoWeb]
--[Unete].[SeccionNuestrosProductos].[UrlImagenCatalogo]
--[Unete].[SeccionNuestrosProductosItem].[UrlImagen]
--[Unete].[SeccionNuestrosProductosItem].[UrlImagenHover]
--[Unete].[SeccionTestimonio].[UrlBoton]

go

USE BelcorpSalvador
GO

declare @BucketAntiguoQA varchar(100) = 'd1y60eoca8fkyl.cloudfront.net/'
declare @BucketNuevoQA varchar(100) = 'S3.amazonaws.com/consultorasQAS/SomosBelcorp/'

declare @BucketAntiguoPRD varchar(100) = 'd1y60eoca8fkyl.cloudfront.net/'
declare @BucketNuevoPRD varchar(100) = 'S3.amazonaws.com/consultorasPRD/SomosBelcorp/'

--select * from ProductoSugerido
update ProductoSugerido set ImagenProducto = replace(ImagenProducto, @BucketAntiguoQA, @BucketNuevoQA)
update ProductoSugerido set ImagenProducto = replace(ImagenProducto, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from Comunicado
update Comunicado set UrlImagen = replace(UrlImagen, @BucketAntiguoQA, @BucketNuevoQA)
update Comunicado set UrlImagen = replace(UrlImagen, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from EventoFestivo
update EventoFestivo set Personalizacion = replace(Personalizacion, @BucketAntiguoQA, @BucketNuevoQA)
update EventoFestivo set Personalizacion = replace(Personalizacion, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from Incentivo
update Incentivo set ArchivoPortada = replace(ArchivoPortada, @BucketAntiguoQA, @BucketNuevoQA)
update Incentivo set ArchivoPortada = replace(ArchivoPortada, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from ItemCarruselInicio
update ItemCarruselInicio set TextoLink = replace(TextoLink, @BucketAntiguoQA, @BucketNuevoQA)
update ItemCarruselInicio set TextoLink = replace(TextoLink, @BucketAntiguoPRD, @BucketNuevoPRD)
update ItemCarruselInicio set UrlImagenPrincipal = replace(UrlImagenPrincipal, @BucketAntiguoQA, @BucketNuevoQA)
update ItemCarruselInicio set UrlImagenPrincipal = replace(UrlImagenPrincipal, @BucketAntiguoPRD, @BucketNuevoPRD)
update ItemCarruselInicio set UrlImagenTitulo = replace(UrlImagenTitulo, @BucketAntiguoQA, @BucketNuevoQA)
update ItemCarruselInicio set UrlImagenTitulo = replace(UrlImagenTitulo, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from Permiso
update Permiso set UrlImagen = replace(UrlImagen, @BucketAntiguoQA, @BucketNuevoQA)
update Permiso set UrlImagen = replace(UrlImagen, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from ProductoCompartido
update ProductoCompartido set Detalle = replace(Detalle, @BucketAntiguoQA, @BucketNuevoQA)
update ProductoCompartido set Detalle = replace(Detalle, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from ProductoSugerido
update ProductoSugerido set ImagenProducto = replace(ImagenProducto, @BucketAntiguoQA, @BucketNuevoQA)
update ProductoSugerido set ImagenProducto = replace(ImagenProducto, @BucketAntiguoPRD, @BucketNuevoPRD)

--[Unete].[ArchivoCSS].[Url]
--[Unete].[Formulario].[LinkAceptoTerminosYCondiciones]
--[Unete].[SeccionAsesoriaItem].[UrlImagen]
--[Unete].[SeccionFooterItem].[UrlIcono]
--[Unete].[SeccionFooterItem].[UrlWeb]
--[Unete].[SeccionGananciaItem].[UrlImagen]
--[Unete].[SeccionIniciaNegocio].[UrlImagenFondo]
--[Unete].[SeccionInicio].[UrlImagenFondoMovil]
--[Unete].[SeccionInicio].[UrlImagenFondoWeb]
--[Unete].[SeccionNuestrosProductos].[UrlImagenCatalogo]
--[Unete].[SeccionNuestrosProductosItem].[UrlImagen]
--[Unete].[SeccionNuestrosProductosItem].[UrlImagenHover]
--[Unete].[SeccionTestimonio].[UrlBoton]

go

USE BelcorpPuertoRico
GO

declare @BucketAntiguoQA varchar(100) = 'd1y60eoca8fkyl.cloudfront.net/'
declare @BucketNuevoQA varchar(100) = 'S3.amazonaws.com/consultorasQAS/SomosBelcorp/'

declare @BucketAntiguoPRD varchar(100) = 'd1y60eoca8fkyl.cloudfront.net/'
declare @BucketNuevoPRD varchar(100) = 'S3.amazonaws.com/consultorasPRD/SomosBelcorp/'

--select * from ProductoSugerido
update ProductoSugerido set ImagenProducto = replace(ImagenProducto, @BucketAntiguoQA, @BucketNuevoQA)
update ProductoSugerido set ImagenProducto = replace(ImagenProducto, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from Comunicado
update Comunicado set UrlImagen = replace(UrlImagen, @BucketAntiguoQA, @BucketNuevoQA)
update Comunicado set UrlImagen = replace(UrlImagen, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from EventoFestivo
update EventoFestivo set Personalizacion = replace(Personalizacion, @BucketAntiguoQA, @BucketNuevoQA)
update EventoFestivo set Personalizacion = replace(Personalizacion, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from Incentivo
update Incentivo set ArchivoPortada = replace(ArchivoPortada, @BucketAntiguoQA, @BucketNuevoQA)
update Incentivo set ArchivoPortada = replace(ArchivoPortada, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from ItemCarruselInicio
update ItemCarruselInicio set TextoLink = replace(TextoLink, @BucketAntiguoQA, @BucketNuevoQA)
update ItemCarruselInicio set TextoLink = replace(TextoLink, @BucketAntiguoPRD, @BucketNuevoPRD)
update ItemCarruselInicio set UrlImagenPrincipal = replace(UrlImagenPrincipal, @BucketAntiguoQA, @BucketNuevoQA)
update ItemCarruselInicio set UrlImagenPrincipal = replace(UrlImagenPrincipal, @BucketAntiguoPRD, @BucketNuevoPRD)
update ItemCarruselInicio set UrlImagenTitulo = replace(UrlImagenTitulo, @BucketAntiguoQA, @BucketNuevoQA)
update ItemCarruselInicio set UrlImagenTitulo = replace(UrlImagenTitulo, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from Permiso
update Permiso set UrlImagen = replace(UrlImagen, @BucketAntiguoQA, @BucketNuevoQA)
update Permiso set UrlImagen = replace(UrlImagen, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from ProductoCompartido
update ProductoCompartido set Detalle = replace(Detalle, @BucketAntiguoQA, @BucketNuevoQA)
update ProductoCompartido set Detalle = replace(Detalle, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from ProductoSugerido
update ProductoSugerido set ImagenProducto = replace(ImagenProducto, @BucketAntiguoQA, @BucketNuevoQA)
update ProductoSugerido set ImagenProducto = replace(ImagenProducto, @BucketAntiguoPRD, @BucketNuevoPRD)

--[Unete].[ArchivoCSS].[Url]
--[Unete].[Formulario].[LinkAceptoTerminosYCondiciones]
--[Unete].[SeccionAsesoriaItem].[UrlImagen]
--[Unete].[SeccionFooterItem].[UrlIcono]
--[Unete].[SeccionFooterItem].[UrlWeb]
--[Unete].[SeccionGananciaItem].[UrlImagen]
--[Unete].[SeccionIniciaNegocio].[UrlImagenFondo]
--[Unete].[SeccionInicio].[UrlImagenFondoMovil]
--[Unete].[SeccionInicio].[UrlImagenFondoWeb]
--[Unete].[SeccionNuestrosProductos].[UrlImagenCatalogo]
--[Unete].[SeccionNuestrosProductosItem].[UrlImagen]
--[Unete].[SeccionNuestrosProductosItem].[UrlImagenHover]
--[Unete].[SeccionTestimonio].[UrlBoton]

go

USE BelcorpPanama
GO

declare @BucketAntiguoQA varchar(100) = 'd1y60eoca8fkyl.cloudfront.net/'
declare @BucketNuevoQA varchar(100) = 'S3.amazonaws.com/consultorasQAS/SomosBelcorp/'

declare @BucketAntiguoPRD varchar(100) = 'd1y60eoca8fkyl.cloudfront.net/'
declare @BucketNuevoPRD varchar(100) = 'S3.amazonaws.com/consultorasPRD/SomosBelcorp/'

--select * from ProductoSugerido
update ProductoSugerido set ImagenProducto = replace(ImagenProducto, @BucketAntiguoQA, @BucketNuevoQA)
update ProductoSugerido set ImagenProducto = replace(ImagenProducto, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from Comunicado
update Comunicado set UrlImagen = replace(UrlImagen, @BucketAntiguoQA, @BucketNuevoQA)
update Comunicado set UrlImagen = replace(UrlImagen, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from EventoFestivo
update EventoFestivo set Personalizacion = replace(Personalizacion, @BucketAntiguoQA, @BucketNuevoQA)
update EventoFestivo set Personalizacion = replace(Personalizacion, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from Incentivo
update Incentivo set ArchivoPortada = replace(ArchivoPortada, @BucketAntiguoQA, @BucketNuevoQA)
update Incentivo set ArchivoPortada = replace(ArchivoPortada, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from ItemCarruselInicio
update ItemCarruselInicio set TextoLink = replace(TextoLink, @BucketAntiguoQA, @BucketNuevoQA)
update ItemCarruselInicio set TextoLink = replace(TextoLink, @BucketAntiguoPRD, @BucketNuevoPRD)
update ItemCarruselInicio set UrlImagenPrincipal = replace(UrlImagenPrincipal, @BucketAntiguoQA, @BucketNuevoQA)
update ItemCarruselInicio set UrlImagenPrincipal = replace(UrlImagenPrincipal, @BucketAntiguoPRD, @BucketNuevoPRD)
update ItemCarruselInicio set UrlImagenTitulo = replace(UrlImagenTitulo, @BucketAntiguoQA, @BucketNuevoQA)
update ItemCarruselInicio set UrlImagenTitulo = replace(UrlImagenTitulo, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from Permiso
update Permiso set UrlImagen = replace(UrlImagen, @BucketAntiguoQA, @BucketNuevoQA)
update Permiso set UrlImagen = replace(UrlImagen, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from ProductoCompartido
update ProductoCompartido set Detalle = replace(Detalle, @BucketAntiguoQA, @BucketNuevoQA)
update ProductoCompartido set Detalle = replace(Detalle, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from ProductoSugerido
update ProductoSugerido set ImagenProducto = replace(ImagenProducto, @BucketAntiguoQA, @BucketNuevoQA)
update ProductoSugerido set ImagenProducto = replace(ImagenProducto, @BucketAntiguoPRD, @BucketNuevoPRD)

--[Unete].[ArchivoCSS].[Url]
--[Unete].[Formulario].[LinkAceptoTerminosYCondiciones]
--[Unete].[SeccionAsesoriaItem].[UrlImagen]
--[Unete].[SeccionFooterItem].[UrlIcono]
--[Unete].[SeccionFooterItem].[UrlWeb]
--[Unete].[SeccionGananciaItem].[UrlImagen]
--[Unete].[SeccionIniciaNegocio].[UrlImagenFondo]
--[Unete].[SeccionInicio].[UrlImagenFondoMovil]
--[Unete].[SeccionInicio].[UrlImagenFondoWeb]
--[Unete].[SeccionNuestrosProductos].[UrlImagenCatalogo]
--[Unete].[SeccionNuestrosProductosItem].[UrlImagen]
--[Unete].[SeccionNuestrosProductosItem].[UrlImagenHover]
--[Unete].[SeccionTestimonio].[UrlBoton]

go

USE BelcorpGuatemala
GO

declare @BucketAntiguoQA varchar(100) = 'd1y60eoca8fkyl.cloudfront.net/'
declare @BucketNuevoQA varchar(100) = 'S3.amazonaws.com/consultorasQAS/SomosBelcorp/'

declare @BucketAntiguoPRD varchar(100) = 'd1y60eoca8fkyl.cloudfront.net/'
declare @BucketNuevoPRD varchar(100) = 'S3.amazonaws.com/consultorasPRD/SomosBelcorp/'

--select * from ProductoSugerido
update ProductoSugerido set ImagenProducto = replace(ImagenProducto, @BucketAntiguoQA, @BucketNuevoQA)
update ProductoSugerido set ImagenProducto = replace(ImagenProducto, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from Comunicado
update Comunicado set UrlImagen = replace(UrlImagen, @BucketAntiguoQA, @BucketNuevoQA)
update Comunicado set UrlImagen = replace(UrlImagen, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from EventoFestivo
update EventoFestivo set Personalizacion = replace(Personalizacion, @BucketAntiguoQA, @BucketNuevoQA)
update EventoFestivo set Personalizacion = replace(Personalizacion, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from Incentivo
update Incentivo set ArchivoPortada = replace(ArchivoPortada, @BucketAntiguoQA, @BucketNuevoQA)
update Incentivo set ArchivoPortada = replace(ArchivoPortada, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from ItemCarruselInicio
update ItemCarruselInicio set TextoLink = replace(TextoLink, @BucketAntiguoQA, @BucketNuevoQA)
update ItemCarruselInicio set TextoLink = replace(TextoLink, @BucketAntiguoPRD, @BucketNuevoPRD)
update ItemCarruselInicio set UrlImagenPrincipal = replace(UrlImagenPrincipal, @BucketAntiguoQA, @BucketNuevoQA)
update ItemCarruselInicio set UrlImagenPrincipal = replace(UrlImagenPrincipal, @BucketAntiguoPRD, @BucketNuevoPRD)
update ItemCarruselInicio set UrlImagenTitulo = replace(UrlImagenTitulo, @BucketAntiguoQA, @BucketNuevoQA)
update ItemCarruselInicio set UrlImagenTitulo = replace(UrlImagenTitulo, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from Permiso
update Permiso set UrlImagen = replace(UrlImagen, @BucketAntiguoQA, @BucketNuevoQA)
update Permiso set UrlImagen = replace(UrlImagen, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from ProductoCompartido
update ProductoCompartido set Detalle = replace(Detalle, @BucketAntiguoQA, @BucketNuevoQA)
update ProductoCompartido set Detalle = replace(Detalle, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from ProductoSugerido
update ProductoSugerido set ImagenProducto = replace(ImagenProducto, @BucketAntiguoQA, @BucketNuevoQA)
update ProductoSugerido set ImagenProducto = replace(ImagenProducto, @BucketAntiguoPRD, @BucketNuevoPRD)

--[Unete].[ArchivoCSS].[Url]
--[Unete].[Formulario].[LinkAceptoTerminosYCondiciones]
--[Unete].[SeccionAsesoriaItem].[UrlImagen]
--[Unete].[SeccionFooterItem].[UrlIcono]
--[Unete].[SeccionFooterItem].[UrlWeb]
--[Unete].[SeccionGananciaItem].[UrlImagen]
--[Unete].[SeccionIniciaNegocio].[UrlImagenFondo]
--[Unete].[SeccionInicio].[UrlImagenFondoMovil]
--[Unete].[SeccionInicio].[UrlImagenFondoWeb]
--[Unete].[SeccionNuestrosProductos].[UrlImagenCatalogo]
--[Unete].[SeccionNuestrosProductosItem].[UrlImagen]
--[Unete].[SeccionNuestrosProductosItem].[UrlImagenHover]
--[Unete].[SeccionTestimonio].[UrlBoton]

go

USE BelcorpEcuador
GO

declare @BucketAntiguoQA varchar(100) = 'd1y60eoca8fkyl.cloudfront.net/'
declare @BucketNuevoQA varchar(100) = 'S3.amazonaws.com/consultorasQAS/SomosBelcorp/'

declare @BucketAntiguoPRD varchar(100) = 'd1y60eoca8fkyl.cloudfront.net/'
declare @BucketNuevoPRD varchar(100) = 'S3.amazonaws.com/consultorasPRD/SomosBelcorp/'

--select * from ProductoSugerido
update ProductoSugerido set ImagenProducto = replace(ImagenProducto, @BucketAntiguoQA, @BucketNuevoQA)
update ProductoSugerido set ImagenProducto = replace(ImagenProducto, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from Comunicado
update Comunicado set UrlImagen = replace(UrlImagen, @BucketAntiguoQA, @BucketNuevoQA)
update Comunicado set UrlImagen = replace(UrlImagen, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from EventoFestivo
update EventoFestivo set Personalizacion = replace(Personalizacion, @BucketAntiguoQA, @BucketNuevoQA)
update EventoFestivo set Personalizacion = replace(Personalizacion, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from Incentivo
update Incentivo set ArchivoPortada = replace(ArchivoPortada, @BucketAntiguoQA, @BucketNuevoQA)
update Incentivo set ArchivoPortada = replace(ArchivoPortada, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from ItemCarruselInicio
update ItemCarruselInicio set TextoLink = replace(TextoLink, @BucketAntiguoQA, @BucketNuevoQA)
update ItemCarruselInicio set TextoLink = replace(TextoLink, @BucketAntiguoPRD, @BucketNuevoPRD)
update ItemCarruselInicio set UrlImagenPrincipal = replace(UrlImagenPrincipal, @BucketAntiguoQA, @BucketNuevoQA)
update ItemCarruselInicio set UrlImagenPrincipal = replace(UrlImagenPrincipal, @BucketAntiguoPRD, @BucketNuevoPRD)
update ItemCarruselInicio set UrlImagenTitulo = replace(UrlImagenTitulo, @BucketAntiguoQA, @BucketNuevoQA)
update ItemCarruselInicio set UrlImagenTitulo = replace(UrlImagenTitulo, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from Permiso
update Permiso set UrlImagen = replace(UrlImagen, @BucketAntiguoQA, @BucketNuevoQA)
update Permiso set UrlImagen = replace(UrlImagen, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from ProductoCompartido
update ProductoCompartido set Detalle = replace(Detalle, @BucketAntiguoQA, @BucketNuevoQA)
update ProductoCompartido set Detalle = replace(Detalle, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from ProductoSugerido
update ProductoSugerido set ImagenProducto = replace(ImagenProducto, @BucketAntiguoQA, @BucketNuevoQA)
update ProductoSugerido set ImagenProducto = replace(ImagenProducto, @BucketAntiguoPRD, @BucketNuevoPRD)

--[Unete].[ArchivoCSS].[Url]
--[Unete].[Formulario].[LinkAceptoTerminosYCondiciones]
--[Unete].[SeccionAsesoriaItem].[UrlImagen]
--[Unete].[SeccionFooterItem].[UrlIcono]
--[Unete].[SeccionFooterItem].[UrlWeb]
--[Unete].[SeccionGananciaItem].[UrlImagen]
--[Unete].[SeccionIniciaNegocio].[UrlImagenFondo]
--[Unete].[SeccionInicio].[UrlImagenFondoMovil]
--[Unete].[SeccionInicio].[UrlImagenFondoWeb]
--[Unete].[SeccionNuestrosProductos].[UrlImagenCatalogo]
--[Unete].[SeccionNuestrosProductosItem].[UrlImagen]
--[Unete].[SeccionNuestrosProductosItem].[UrlImagenHover]
--[Unete].[SeccionTestimonio].[UrlBoton]

go

USE BelcorpDominicana
GO

declare @BucketAntiguoQA varchar(100) = 'd1y60eoca8fkyl.cloudfront.net/'
declare @BucketNuevoQA varchar(100) = 'S3.amazonaws.com/consultorasQAS/SomosBelcorp/'

declare @BucketAntiguoPRD varchar(100) = 'd1y60eoca8fkyl.cloudfront.net/'
declare @BucketNuevoPRD varchar(100) = 'S3.amazonaws.com/consultorasPRD/SomosBelcorp/'

--select * from ProductoSugerido
update ProductoSugerido set ImagenProducto = replace(ImagenProducto, @BucketAntiguoQA, @BucketNuevoQA)
update ProductoSugerido set ImagenProducto = replace(ImagenProducto, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from Comunicado
update Comunicado set UrlImagen = replace(UrlImagen, @BucketAntiguoQA, @BucketNuevoQA)
update Comunicado set UrlImagen = replace(UrlImagen, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from EventoFestivo
update EventoFestivo set Personalizacion = replace(Personalizacion, @BucketAntiguoQA, @BucketNuevoQA)
update EventoFestivo set Personalizacion = replace(Personalizacion, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from Incentivo
update Incentivo set ArchivoPortada = replace(ArchivoPortada, @BucketAntiguoQA, @BucketNuevoQA)
update Incentivo set ArchivoPortada = replace(ArchivoPortada, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from ItemCarruselInicio
update ItemCarruselInicio set TextoLink = replace(TextoLink, @BucketAntiguoQA, @BucketNuevoQA)
update ItemCarruselInicio set TextoLink = replace(TextoLink, @BucketAntiguoPRD, @BucketNuevoPRD)
update ItemCarruselInicio set UrlImagenPrincipal = replace(UrlImagenPrincipal, @BucketAntiguoQA, @BucketNuevoQA)
update ItemCarruselInicio set UrlImagenPrincipal = replace(UrlImagenPrincipal, @BucketAntiguoPRD, @BucketNuevoPRD)
update ItemCarruselInicio set UrlImagenTitulo = replace(UrlImagenTitulo, @BucketAntiguoQA, @BucketNuevoQA)
update ItemCarruselInicio set UrlImagenTitulo = replace(UrlImagenTitulo, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from Permiso
update Permiso set UrlImagen = replace(UrlImagen, @BucketAntiguoQA, @BucketNuevoQA)
update Permiso set UrlImagen = replace(UrlImagen, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from ProductoCompartido
update ProductoCompartido set Detalle = replace(Detalle, @BucketAntiguoQA, @BucketNuevoQA)
update ProductoCompartido set Detalle = replace(Detalle, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from ProductoSugerido
update ProductoSugerido set ImagenProducto = replace(ImagenProducto, @BucketAntiguoQA, @BucketNuevoQA)
update ProductoSugerido set ImagenProducto = replace(ImagenProducto, @BucketAntiguoPRD, @BucketNuevoPRD)

--[Unete].[ArchivoCSS].[Url]
--[Unete].[Formulario].[LinkAceptoTerminosYCondiciones]
--[Unete].[SeccionAsesoriaItem].[UrlImagen]
--[Unete].[SeccionFooterItem].[UrlIcono]
--[Unete].[SeccionFooterItem].[UrlWeb]
--[Unete].[SeccionGananciaItem].[UrlImagen]
--[Unete].[SeccionIniciaNegocio].[UrlImagenFondo]
--[Unete].[SeccionInicio].[UrlImagenFondoMovil]
--[Unete].[SeccionInicio].[UrlImagenFondoWeb]
--[Unete].[SeccionNuestrosProductos].[UrlImagenCatalogo]
--[Unete].[SeccionNuestrosProductosItem].[UrlImagen]
--[Unete].[SeccionNuestrosProductosItem].[UrlImagenHover]
--[Unete].[SeccionTestimonio].[UrlBoton]

go

USE BelcorpCostaRica
GO

declare @BucketAntiguoQA varchar(100) = 'd1y60eoca8fkyl.cloudfront.net/'
declare @BucketNuevoQA varchar(100) = 'S3.amazonaws.com/consultorasQAS/SomosBelcorp/'

declare @BucketAntiguoPRD varchar(100) = 'd1y60eoca8fkyl.cloudfront.net/'
declare @BucketNuevoPRD varchar(100) = 'S3.amazonaws.com/consultorasPRD/SomosBelcorp/'

--select * from ProductoSugerido
update ProductoSugerido set ImagenProducto = replace(ImagenProducto, @BucketAntiguoQA, @BucketNuevoQA)
update ProductoSugerido set ImagenProducto = replace(ImagenProducto, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from Comunicado
update Comunicado set UrlImagen = replace(UrlImagen, @BucketAntiguoQA, @BucketNuevoQA)
update Comunicado set UrlImagen = replace(UrlImagen, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from EventoFestivo
update EventoFestivo set Personalizacion = replace(Personalizacion, @BucketAntiguoQA, @BucketNuevoQA)
update EventoFestivo set Personalizacion = replace(Personalizacion, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from Incentivo
update Incentivo set ArchivoPortada = replace(ArchivoPortada, @BucketAntiguoQA, @BucketNuevoQA)
update Incentivo set ArchivoPortada = replace(ArchivoPortada, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from ItemCarruselInicio
update ItemCarruselInicio set TextoLink = replace(TextoLink, @BucketAntiguoQA, @BucketNuevoQA)
update ItemCarruselInicio set TextoLink = replace(TextoLink, @BucketAntiguoPRD, @BucketNuevoPRD)
update ItemCarruselInicio set UrlImagenPrincipal = replace(UrlImagenPrincipal, @BucketAntiguoQA, @BucketNuevoQA)
update ItemCarruselInicio set UrlImagenPrincipal = replace(UrlImagenPrincipal, @BucketAntiguoPRD, @BucketNuevoPRD)
update ItemCarruselInicio set UrlImagenTitulo = replace(UrlImagenTitulo, @BucketAntiguoQA, @BucketNuevoQA)
update ItemCarruselInicio set UrlImagenTitulo = replace(UrlImagenTitulo, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from Permiso
update Permiso set UrlImagen = replace(UrlImagen, @BucketAntiguoQA, @BucketNuevoQA)
update Permiso set UrlImagen = replace(UrlImagen, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from ProductoCompartido
update ProductoCompartido set Detalle = replace(Detalle, @BucketAntiguoQA, @BucketNuevoQA)
update ProductoCompartido set Detalle = replace(Detalle, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from ProductoSugerido
update ProductoSugerido set ImagenProducto = replace(ImagenProducto, @BucketAntiguoQA, @BucketNuevoQA)
update ProductoSugerido set ImagenProducto = replace(ImagenProducto, @BucketAntiguoPRD, @BucketNuevoPRD)

--[Unete].[ArchivoCSS].[Url]
--[Unete].[Formulario].[LinkAceptoTerminosYCondiciones]
--[Unete].[SeccionAsesoriaItem].[UrlImagen]
--[Unete].[SeccionFooterItem].[UrlIcono]
--[Unete].[SeccionFooterItem].[UrlWeb]
--[Unete].[SeccionGananciaItem].[UrlImagen]
--[Unete].[SeccionIniciaNegocio].[UrlImagenFondo]
--[Unete].[SeccionInicio].[UrlImagenFondoMovil]
--[Unete].[SeccionInicio].[UrlImagenFondoWeb]
--[Unete].[SeccionNuestrosProductos].[UrlImagenCatalogo]
--[Unete].[SeccionNuestrosProductosItem].[UrlImagen]
--[Unete].[SeccionNuestrosProductosItem].[UrlImagenHover]
--[Unete].[SeccionTestimonio].[UrlBoton]

go

USE BelcorpChile
GO

declare @BucketAntiguoQA varchar(100) = 'd1y60eoca8fkyl.cloudfront.net/'
declare @BucketNuevoQA varchar(100) = 'S3.amazonaws.com/consultorasQAS/SomosBelcorp/'

declare @BucketAntiguoPRD varchar(100) = 'd1y60eoca8fkyl.cloudfront.net/'
declare @BucketNuevoPRD varchar(100) = 'S3.amazonaws.com/consultorasPRD/SomosBelcorp/'

--select * from ProductoSugerido
update ProductoSugerido set ImagenProducto = replace(ImagenProducto, @BucketAntiguoQA, @BucketNuevoQA)
update ProductoSugerido set ImagenProducto = replace(ImagenProducto, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from Comunicado
update Comunicado set UrlImagen = replace(UrlImagen, @BucketAntiguoQA, @BucketNuevoQA)
update Comunicado set UrlImagen = replace(UrlImagen, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from EventoFestivo
update EventoFestivo set Personalizacion = replace(Personalizacion, @BucketAntiguoQA, @BucketNuevoQA)
update EventoFestivo set Personalizacion = replace(Personalizacion, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from Incentivo
update Incentivo set ArchivoPortada = replace(ArchivoPortada, @BucketAntiguoQA, @BucketNuevoQA)
update Incentivo set ArchivoPortada = replace(ArchivoPortada, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from ItemCarruselInicio
update ItemCarruselInicio set TextoLink = replace(TextoLink, @BucketAntiguoQA, @BucketNuevoQA)
update ItemCarruselInicio set TextoLink = replace(TextoLink, @BucketAntiguoPRD, @BucketNuevoPRD)
update ItemCarruselInicio set UrlImagenPrincipal = replace(UrlImagenPrincipal, @BucketAntiguoQA, @BucketNuevoQA)
update ItemCarruselInicio set UrlImagenPrincipal = replace(UrlImagenPrincipal, @BucketAntiguoPRD, @BucketNuevoPRD)
update ItemCarruselInicio set UrlImagenTitulo = replace(UrlImagenTitulo, @BucketAntiguoQA, @BucketNuevoQA)
update ItemCarruselInicio set UrlImagenTitulo = replace(UrlImagenTitulo, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from Permiso
update Permiso set UrlImagen = replace(UrlImagen, @BucketAntiguoQA, @BucketNuevoQA)
update Permiso set UrlImagen = replace(UrlImagen, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from ProductoCompartido
update ProductoCompartido set Detalle = replace(Detalle, @BucketAntiguoQA, @BucketNuevoQA)
update ProductoCompartido set Detalle = replace(Detalle, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from ProductoSugerido
update ProductoSugerido set ImagenProducto = replace(ImagenProducto, @BucketAntiguoQA, @BucketNuevoQA)
update ProductoSugerido set ImagenProducto = replace(ImagenProducto, @BucketAntiguoPRD, @BucketNuevoPRD)

--[Unete].[ArchivoCSS].[Url]
--[Unete].[Formulario].[LinkAceptoTerminosYCondiciones]
--[Unete].[SeccionAsesoriaItem].[UrlImagen]
--[Unete].[SeccionFooterItem].[UrlIcono]
--[Unete].[SeccionFooterItem].[UrlWeb]
--[Unete].[SeccionGananciaItem].[UrlImagen]
--[Unete].[SeccionIniciaNegocio].[UrlImagenFondo]
--[Unete].[SeccionInicio].[UrlImagenFondoMovil]
--[Unete].[SeccionInicio].[UrlImagenFondoWeb]
--[Unete].[SeccionNuestrosProductos].[UrlImagenCatalogo]
--[Unete].[SeccionNuestrosProductosItem].[UrlImagen]
--[Unete].[SeccionNuestrosProductosItem].[UrlImagenHover]
--[Unete].[SeccionTestimonio].[UrlBoton]

go

USE BelcorpBolivia
GO

declare @BucketAntiguoQA varchar(100) = 'd1y60eoca8fkyl.cloudfront.net/'
declare @BucketNuevoQA varchar(100) = 'S3.amazonaws.com/consultorasQAS/SomosBelcorp/'

declare @BucketAntiguoPRD varchar(100) = 'd1y60eoca8fkyl.cloudfront.net/'
declare @BucketNuevoPRD varchar(100) = 'S3.amazonaws.com/consultorasPRD/SomosBelcorp/'

--select * from ProductoSugerido
update ProductoSugerido set ImagenProducto = replace(ImagenProducto, @BucketAntiguoQA, @BucketNuevoQA)
update ProductoSugerido set ImagenProducto = replace(ImagenProducto, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from Comunicado
update Comunicado set UrlImagen = replace(UrlImagen, @BucketAntiguoQA, @BucketNuevoQA)
update Comunicado set UrlImagen = replace(UrlImagen, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from EventoFestivo
update EventoFestivo set Personalizacion = replace(Personalizacion, @BucketAntiguoQA, @BucketNuevoQA)
update EventoFestivo set Personalizacion = replace(Personalizacion, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from Incentivo
update Incentivo set ArchivoPortada = replace(ArchivoPortada, @BucketAntiguoQA, @BucketNuevoQA)
update Incentivo set ArchivoPortada = replace(ArchivoPortada, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from ItemCarruselInicio
update ItemCarruselInicio set TextoLink = replace(TextoLink, @BucketAntiguoQA, @BucketNuevoQA)
update ItemCarruselInicio set TextoLink = replace(TextoLink, @BucketAntiguoPRD, @BucketNuevoPRD)
update ItemCarruselInicio set UrlImagenPrincipal = replace(UrlImagenPrincipal, @BucketAntiguoQA, @BucketNuevoQA)
update ItemCarruselInicio set UrlImagenPrincipal = replace(UrlImagenPrincipal, @BucketAntiguoPRD, @BucketNuevoPRD)
update ItemCarruselInicio set UrlImagenTitulo = replace(UrlImagenTitulo, @BucketAntiguoQA, @BucketNuevoQA)
update ItemCarruselInicio set UrlImagenTitulo = replace(UrlImagenTitulo, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from Permiso
update Permiso set UrlImagen = replace(UrlImagen, @BucketAntiguoQA, @BucketNuevoQA)
update Permiso set UrlImagen = replace(UrlImagen, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from ProductoCompartido
update ProductoCompartido set Detalle = replace(Detalle, @BucketAntiguoQA, @BucketNuevoQA)
update ProductoCompartido set Detalle = replace(Detalle, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from ProductoSugerido
update ProductoSugerido set ImagenProducto = replace(ImagenProducto, @BucketAntiguoQA, @BucketNuevoQA)
update ProductoSugerido set ImagenProducto = replace(ImagenProducto, @BucketAntiguoPRD, @BucketNuevoPRD)

--[Unete].[ArchivoCSS].[Url]
--[Unete].[Formulario].[LinkAceptoTerminosYCondiciones]
--[Unete].[SeccionAsesoriaItem].[UrlImagen]
--[Unete].[SeccionFooterItem].[UrlIcono]
--[Unete].[SeccionFooterItem].[UrlWeb]
--[Unete].[SeccionGananciaItem].[UrlImagen]
--[Unete].[SeccionIniciaNegocio].[UrlImagenFondo]
--[Unete].[SeccionInicio].[UrlImagenFondoMovil]
--[Unete].[SeccionInicio].[UrlImagenFondoWeb]
--[Unete].[SeccionNuestrosProductos].[UrlImagenCatalogo]
--[Unete].[SeccionNuestrosProductosItem].[UrlImagen]
--[Unete].[SeccionNuestrosProductosItem].[UrlImagenHover]
--[Unete].[SeccionTestimonio].[UrlBoton]

go

