USE BelcorpPeru
GO

declare @BucketAntiguoQA varchar(100) = 'cdn1-prd.somosbelcorp.com/'
declare @BucketNuevoQA varchar(100) = 'S3.amazonaws.com/consultorasPRD/SomosBelcorp/'

declare @BucketAntiguoPRD varchar(100) = 'cdn1-prd.somosbelcorp.com/'
declare @BucketNuevoPRD varchar(100) = 'S3.amazonaws.com/consultorasPRD/SomosBelcorp/'

--select * from CertificadoDigitalConfig
update CertificadoDigitalConfig set UrlFirma = replace(UrlFirma, @BucketAntiguoQA, @BucketNuevoQA)
update CertificadoDigitalConfig set UrlFirma = replace(UrlFirma, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from CertificadoDigitalLog
update CertificadoDigitalLog set UrlFirma = replace(UrlFirma, @BucketAntiguoQA, @BucketNuevoQA)
update CertificadoDigitalLog set UrlFirma = replace(UrlFirma, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from Comunicado
update Comunicado set UrlImagen = replace(UrlImagen, @BucketAntiguoQA, @BucketNuevoQA)
update Comunicado set UrlImagen = replace(UrlImagen, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from ConfiguracionPaisDatos
update ConfiguracionPaisDatos set Valor1 = replace(Valor1, @BucketAntiguoQA, @BucketNuevoQA)
update ConfiguracionPaisDatos set Valor1 = replace(Valor1, @BucketAntiguoPRD, @BucketNuevoPRD)

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

--select * from ProductoCompartido
update ProductoCompartido set Detalle = replace(Detalle, @BucketAntiguoQA, @BucketNuevoQA)
update ProductoCompartido set Detalle = replace(Detalle, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from ProductoSugerido
update ProductoSugerido set ImagenProducto = replace(ImagenProducto, @BucketAntiguoQA, @BucketNuevoQA)
update ProductoSugerido set ImagenProducto = replace(ImagenProducto, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from TablaLogicaDatos
update TablaLogicaDatos set Codigo = replace(Codigo, @BucketAntiguoQA, @BucketNuevoQA)
update TablaLogicaDatos set Codigo = replace(Codigo, @BucketAntiguoPRD, @BucketNuevoPRD)

update TablaLogicaDatos set Valor = replace(Valor, @BucketAntiguoQA, @BucketNuevoQA)
update TablaLogicaDatos set Valor = replace(Valor, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from UpSelling
update UpSelling set ImagenFondoGanasteMobile = replace(ImagenFondoGanasteMobile, @BucketAntiguoQA, @BucketNuevoQA)
update UpSelling set ImagenFondoGanasteMobile = replace(ImagenFondoGanasteMobile, @BucketAntiguoPRD, @BucketNuevoPRD)

update UpSelling set ImagenFondoPrincipalDesktop = replace(ImagenFondoPrincipalDesktop, @BucketAntiguoQA, @BucketNuevoQA)
update UpSelling set ImagenFondoPrincipalDesktop = replace(ImagenFondoPrincipalDesktop, @BucketAntiguoPRD, @BucketNuevoPRD)

update UpSelling set ImagenFondoPrincipalMobile = replace(ImagenFondoPrincipalMobile, @BucketAntiguoQA, @BucketNuevoQA)
update UpSelling set ImagenFondoPrincipalMobile = replace(ImagenFondoPrincipalMobile, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from UpSellingDetalle
update UpSellingDetalle set Imagen = replace(Imagen, @BucketAntiguoQA, @BucketNuevoQA)
update UpSellingDetalle set Imagen = replace(Imagen, @BucketAntiguoPRD, @BucketNuevoPRD)

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
--[Unete].[SeccionNuestrosProductosItem].[UrlImagenHover]
--[Unete].[SeccionTestimonio].[UrlBoton]

go

USE BelcorpMexico
GO

declare @BucketAntiguoQA varchar(100) = 'cdn1-prd.somosbelcorp.com/'
declare @BucketNuevoQA varchar(100) = 'S3.amazonaws.com/consultorasPRD/SomosBelcorp/'

declare @BucketAntiguoPRD varchar(100) = 'cdn1-prd.somosbelcorp.com/'
declare @BucketNuevoPRD varchar(100) = 'S3.amazonaws.com/consultorasPRD/SomosBelcorp/'

--select * from CertificadoDigitalConfig
update CertificadoDigitalConfig set UrlFirma = replace(UrlFirma, @BucketAntiguoQA, @BucketNuevoQA)
update CertificadoDigitalConfig set UrlFirma = replace(UrlFirma, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from CertificadoDigitalLog
update CertificadoDigitalLog set UrlFirma = replace(UrlFirma, @BucketAntiguoQA, @BucketNuevoQA)
update CertificadoDigitalLog set UrlFirma = replace(UrlFirma, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from Comunicado
update Comunicado set UrlImagen = replace(UrlImagen, @BucketAntiguoQA, @BucketNuevoQA)
update Comunicado set UrlImagen = replace(UrlImagen, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from ConfiguracionPaisDatos
update ConfiguracionPaisDatos set Valor1 = replace(Valor1, @BucketAntiguoQA, @BucketNuevoQA)
update ConfiguracionPaisDatos set Valor1 = replace(Valor1, @BucketAntiguoPRD, @BucketNuevoPRD)

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

--select * from ProductoCompartido
update ProductoCompartido set Detalle = replace(Detalle, @BucketAntiguoQA, @BucketNuevoQA)
update ProductoCompartido set Detalle = replace(Detalle, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from ProductoSugerido
update ProductoSugerido set ImagenProducto = replace(ImagenProducto, @BucketAntiguoQA, @BucketNuevoQA)
update ProductoSugerido set ImagenProducto = replace(ImagenProducto, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from TablaLogicaDatos
update TablaLogicaDatos set Codigo = replace(Codigo, @BucketAntiguoQA, @BucketNuevoQA)
update TablaLogicaDatos set Codigo = replace(Codigo, @BucketAntiguoPRD, @BucketNuevoPRD)

update TablaLogicaDatos set Valor = replace(Valor, @BucketAntiguoQA, @BucketNuevoQA)
update TablaLogicaDatos set Valor = replace(Valor, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from UpSelling
update UpSelling set ImagenFondoGanasteMobile = replace(ImagenFondoGanasteMobile, @BucketAntiguoQA, @BucketNuevoQA)
update UpSelling set ImagenFondoGanasteMobile = replace(ImagenFondoGanasteMobile, @BucketAntiguoPRD, @BucketNuevoPRD)

update UpSelling set ImagenFondoPrincipalDesktop = replace(ImagenFondoPrincipalDesktop, @BucketAntiguoQA, @BucketNuevoQA)
update UpSelling set ImagenFondoPrincipalDesktop = replace(ImagenFondoPrincipalDesktop, @BucketAntiguoPRD, @BucketNuevoPRD)

update UpSelling set ImagenFondoPrincipalMobile = replace(ImagenFondoPrincipalMobile, @BucketAntiguoQA, @BucketNuevoQA)
update UpSelling set ImagenFondoPrincipalMobile = replace(ImagenFondoPrincipalMobile, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from UpSellingDetalle
update UpSellingDetalle set Imagen = replace(Imagen, @BucketAntiguoQA, @BucketNuevoQA)
update UpSellingDetalle set Imagen = replace(Imagen, @BucketAntiguoPRD, @BucketNuevoPRD)

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
--[Unete].[SeccionNuestrosProductosItem].[UrlImagenHover]
--[Unete].[SeccionTestimonio].[UrlBoton]

go

USE BelcorpColombia
GO

declare @BucketAntiguoQA varchar(100) = 'cdn1-prd.somosbelcorp.com/'
declare @BucketNuevoQA varchar(100) = 'S3.amazonaws.com/consultorasPRD/SomosBelcorp/'

declare @BucketAntiguoPRD varchar(100) = 'cdn1-prd.somosbelcorp.com/'
declare @BucketNuevoPRD varchar(100) = 'S3.amazonaws.com/consultorasPRD/SomosBelcorp/'

--select * from CertificadoDigitalConfig
update CertificadoDigitalConfig set UrlFirma = replace(UrlFirma, @BucketAntiguoQA, @BucketNuevoQA)
update CertificadoDigitalConfig set UrlFirma = replace(UrlFirma, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from CertificadoDigitalLog
update CertificadoDigitalLog set UrlFirma = replace(UrlFirma, @BucketAntiguoQA, @BucketNuevoQA)
update CertificadoDigitalLog set UrlFirma = replace(UrlFirma, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from Comunicado
update Comunicado set UrlImagen = replace(UrlImagen, @BucketAntiguoQA, @BucketNuevoQA)
update Comunicado set UrlImagen = replace(UrlImagen, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from ConfiguracionPaisDatos
update ConfiguracionPaisDatos set Valor1 = replace(Valor1, @BucketAntiguoQA, @BucketNuevoQA)
update ConfiguracionPaisDatos set Valor1 = replace(Valor1, @BucketAntiguoPRD, @BucketNuevoPRD)

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

--select * from ProductoCompartido
update ProductoCompartido set Detalle = replace(Detalle, @BucketAntiguoQA, @BucketNuevoQA)
update ProductoCompartido set Detalle = replace(Detalle, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from ProductoSugerido
update ProductoSugerido set ImagenProducto = replace(ImagenProducto, @BucketAntiguoQA, @BucketNuevoQA)
update ProductoSugerido set ImagenProducto = replace(ImagenProducto, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from TablaLogicaDatos
update TablaLogicaDatos set Codigo = replace(Codigo, @BucketAntiguoQA, @BucketNuevoQA)
update TablaLogicaDatos set Codigo = replace(Codigo, @BucketAntiguoPRD, @BucketNuevoPRD)

update TablaLogicaDatos set Valor = replace(Valor, @BucketAntiguoQA, @BucketNuevoQA)
update TablaLogicaDatos set Valor = replace(Valor, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from UpSelling
update UpSelling set ImagenFondoGanasteMobile = replace(ImagenFondoGanasteMobile, @BucketAntiguoQA, @BucketNuevoQA)
update UpSelling set ImagenFondoGanasteMobile = replace(ImagenFondoGanasteMobile, @BucketAntiguoPRD, @BucketNuevoPRD)

update UpSelling set ImagenFondoPrincipalDesktop = replace(ImagenFondoPrincipalDesktop, @BucketAntiguoQA, @BucketNuevoQA)
update UpSelling set ImagenFondoPrincipalDesktop = replace(ImagenFondoPrincipalDesktop, @BucketAntiguoPRD, @BucketNuevoPRD)

update UpSelling set ImagenFondoPrincipalMobile = replace(ImagenFondoPrincipalMobile, @BucketAntiguoQA, @BucketNuevoQA)
update UpSelling set ImagenFondoPrincipalMobile = replace(ImagenFondoPrincipalMobile, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from UpSellingDetalle
update UpSellingDetalle set Imagen = replace(Imagen, @BucketAntiguoQA, @BucketNuevoQA)
update UpSellingDetalle set Imagen = replace(Imagen, @BucketAntiguoPRD, @BucketNuevoPRD)

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
--[Unete].[SeccionNuestrosProductosItem].[UrlImagenHover]
--[Unete].[SeccionTestimonio].[UrlBoton]

go

USE BelcorpSalvador
GO

declare @BucketAntiguoQA varchar(100) = 'cdn1-prd.somosbelcorp.com/'
declare @BucketNuevoQA varchar(100) = 'S3.amazonaws.com/consultorasPRD/SomosBelcorp/'

declare @BucketAntiguoPRD varchar(100) = 'cdn1-prd.somosbelcorp.com/'
declare @BucketNuevoPRD varchar(100) = 'S3.amazonaws.com/consultorasPRD/SomosBelcorp/'

--select * from CertificadoDigitalConfig
update CertificadoDigitalConfig set UrlFirma = replace(UrlFirma, @BucketAntiguoQA, @BucketNuevoQA)
update CertificadoDigitalConfig set UrlFirma = replace(UrlFirma, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from CertificadoDigitalLog
update CertificadoDigitalLog set UrlFirma = replace(UrlFirma, @BucketAntiguoQA, @BucketNuevoQA)
update CertificadoDigitalLog set UrlFirma = replace(UrlFirma, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from Comunicado
update Comunicado set UrlImagen = replace(UrlImagen, @BucketAntiguoQA, @BucketNuevoQA)
update Comunicado set UrlImagen = replace(UrlImagen, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from ConfiguracionPaisDatos
update ConfiguracionPaisDatos set Valor1 = replace(Valor1, @BucketAntiguoQA, @BucketNuevoQA)
update ConfiguracionPaisDatos set Valor1 = replace(Valor1, @BucketAntiguoPRD, @BucketNuevoPRD)

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

--select * from ProductoCompartido
update ProductoCompartido set Detalle = replace(Detalle, @BucketAntiguoQA, @BucketNuevoQA)
update ProductoCompartido set Detalle = replace(Detalle, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from ProductoSugerido
update ProductoSugerido set ImagenProducto = replace(ImagenProducto, @BucketAntiguoQA, @BucketNuevoQA)
update ProductoSugerido set ImagenProducto = replace(ImagenProducto, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from TablaLogicaDatos
update TablaLogicaDatos set Codigo = replace(Codigo, @BucketAntiguoQA, @BucketNuevoQA)
update TablaLogicaDatos set Codigo = replace(Codigo, @BucketAntiguoPRD, @BucketNuevoPRD)

update TablaLogicaDatos set Valor = replace(Valor, @BucketAntiguoQA, @BucketNuevoQA)
update TablaLogicaDatos set Valor = replace(Valor, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from UpSelling
update UpSelling set ImagenFondoGanasteMobile = replace(ImagenFondoGanasteMobile, @BucketAntiguoQA, @BucketNuevoQA)
update UpSelling set ImagenFondoGanasteMobile = replace(ImagenFondoGanasteMobile, @BucketAntiguoPRD, @BucketNuevoPRD)

update UpSelling set ImagenFondoPrincipalDesktop = replace(ImagenFondoPrincipalDesktop, @BucketAntiguoQA, @BucketNuevoQA)
update UpSelling set ImagenFondoPrincipalDesktop = replace(ImagenFondoPrincipalDesktop, @BucketAntiguoPRD, @BucketNuevoPRD)

update UpSelling set ImagenFondoPrincipalMobile = replace(ImagenFondoPrincipalMobile, @BucketAntiguoQA, @BucketNuevoQA)
update UpSelling set ImagenFondoPrincipalMobile = replace(ImagenFondoPrincipalMobile, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from UpSellingDetalle
update UpSellingDetalle set Imagen = replace(Imagen, @BucketAntiguoQA, @BucketNuevoQA)
update UpSellingDetalle set Imagen = replace(Imagen, @BucketAntiguoPRD, @BucketNuevoPRD)

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
--[Unete].[SeccionNuestrosProductosItem].[UrlImagenHover]
--[Unete].[SeccionTestimonio].[UrlBoton]

go

USE BelcorpPuertoRico
GO

declare @BucketAntiguoQA varchar(100) = 'cdn1-prd.somosbelcorp.com/'
declare @BucketNuevoQA varchar(100) = 'S3.amazonaws.com/consultorasPRD/SomosBelcorp/'

declare @BucketAntiguoPRD varchar(100) = 'cdn1-prd.somosbelcorp.com/'
declare @BucketNuevoPRD varchar(100) = 'S3.amazonaws.com/consultorasPRD/SomosBelcorp/'

--select * from CertificadoDigitalConfig
update CertificadoDigitalConfig set UrlFirma = replace(UrlFirma, @BucketAntiguoQA, @BucketNuevoQA)
update CertificadoDigitalConfig set UrlFirma = replace(UrlFirma, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from CertificadoDigitalLog
update CertificadoDigitalLog set UrlFirma = replace(UrlFirma, @BucketAntiguoQA, @BucketNuevoQA)
update CertificadoDigitalLog set UrlFirma = replace(UrlFirma, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from Comunicado
update Comunicado set UrlImagen = replace(UrlImagen, @BucketAntiguoQA, @BucketNuevoQA)
update Comunicado set UrlImagen = replace(UrlImagen, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from ConfiguracionPaisDatos
update ConfiguracionPaisDatos set Valor1 = replace(Valor1, @BucketAntiguoQA, @BucketNuevoQA)
update ConfiguracionPaisDatos set Valor1 = replace(Valor1, @BucketAntiguoPRD, @BucketNuevoPRD)

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

--select * from ProductoCompartido
update ProductoCompartido set Detalle = replace(Detalle, @BucketAntiguoQA, @BucketNuevoQA)
update ProductoCompartido set Detalle = replace(Detalle, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from ProductoSugerido
update ProductoSugerido set ImagenProducto = replace(ImagenProducto, @BucketAntiguoQA, @BucketNuevoQA)
update ProductoSugerido set ImagenProducto = replace(ImagenProducto, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from TablaLogicaDatos
update TablaLogicaDatos set Codigo = replace(Codigo, @BucketAntiguoQA, @BucketNuevoQA)
update TablaLogicaDatos set Codigo = replace(Codigo, @BucketAntiguoPRD, @BucketNuevoPRD)

update TablaLogicaDatos set Valor = replace(Valor, @BucketAntiguoQA, @BucketNuevoQA)
update TablaLogicaDatos set Valor = replace(Valor, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from UpSelling
update UpSelling set ImagenFondoGanasteMobile = replace(ImagenFondoGanasteMobile, @BucketAntiguoQA, @BucketNuevoQA)
update UpSelling set ImagenFondoGanasteMobile = replace(ImagenFondoGanasteMobile, @BucketAntiguoPRD, @BucketNuevoPRD)

update UpSelling set ImagenFondoPrincipalDesktop = replace(ImagenFondoPrincipalDesktop, @BucketAntiguoQA, @BucketNuevoQA)
update UpSelling set ImagenFondoPrincipalDesktop = replace(ImagenFondoPrincipalDesktop, @BucketAntiguoPRD, @BucketNuevoPRD)

update UpSelling set ImagenFondoPrincipalMobile = replace(ImagenFondoPrincipalMobile, @BucketAntiguoQA, @BucketNuevoQA)
update UpSelling set ImagenFondoPrincipalMobile = replace(ImagenFondoPrincipalMobile, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from UpSellingDetalle
update UpSellingDetalle set Imagen = replace(Imagen, @BucketAntiguoQA, @BucketNuevoQA)
update UpSellingDetalle set Imagen = replace(Imagen, @BucketAntiguoPRD, @BucketNuevoPRD)

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
--[Unete].[SeccionNuestrosProductosItem].[UrlImagenHover]
--[Unete].[SeccionTestimonio].[UrlBoton]

go

USE BelcorpPanama
GO

declare @BucketAntiguoQA varchar(100) = 'cdn1-prd.somosbelcorp.com/'
declare @BucketNuevoQA varchar(100) = 'S3.amazonaws.com/consultorasPRD/SomosBelcorp/'

declare @BucketAntiguoPRD varchar(100) = 'cdn1-prd.somosbelcorp.com/'
declare @BucketNuevoPRD varchar(100) = 'S3.amazonaws.com/consultorasPRD/SomosBelcorp/'

--select * from CertificadoDigitalConfig
update CertificadoDigitalConfig set UrlFirma = replace(UrlFirma, @BucketAntiguoQA, @BucketNuevoQA)
update CertificadoDigitalConfig set UrlFirma = replace(UrlFirma, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from CertificadoDigitalLog
update CertificadoDigitalLog set UrlFirma = replace(UrlFirma, @BucketAntiguoQA, @BucketNuevoQA)
update CertificadoDigitalLog set UrlFirma = replace(UrlFirma, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from Comunicado
update Comunicado set UrlImagen = replace(UrlImagen, @BucketAntiguoQA, @BucketNuevoQA)
update Comunicado set UrlImagen = replace(UrlImagen, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from ConfiguracionPaisDatos
update ConfiguracionPaisDatos set Valor1 = replace(Valor1, @BucketAntiguoQA, @BucketNuevoQA)
update ConfiguracionPaisDatos set Valor1 = replace(Valor1, @BucketAntiguoPRD, @BucketNuevoPRD)

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

--select * from ProductoCompartido
update ProductoCompartido set Detalle = replace(Detalle, @BucketAntiguoQA, @BucketNuevoQA)
update ProductoCompartido set Detalle = replace(Detalle, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from ProductoSugerido
update ProductoSugerido set ImagenProducto = replace(ImagenProducto, @BucketAntiguoQA, @BucketNuevoQA)
update ProductoSugerido set ImagenProducto = replace(ImagenProducto, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from TablaLogicaDatos
update TablaLogicaDatos set Codigo = replace(Codigo, @BucketAntiguoQA, @BucketNuevoQA)
update TablaLogicaDatos set Codigo = replace(Codigo, @BucketAntiguoPRD, @BucketNuevoPRD)

update TablaLogicaDatos set Valor = replace(Valor, @BucketAntiguoQA, @BucketNuevoQA)
update TablaLogicaDatos set Valor = replace(Valor, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from UpSelling
update UpSelling set ImagenFondoGanasteMobile = replace(ImagenFondoGanasteMobile, @BucketAntiguoQA, @BucketNuevoQA)
update UpSelling set ImagenFondoGanasteMobile = replace(ImagenFondoGanasteMobile, @BucketAntiguoPRD, @BucketNuevoPRD)

update UpSelling set ImagenFondoPrincipalDesktop = replace(ImagenFondoPrincipalDesktop, @BucketAntiguoQA, @BucketNuevoQA)
update UpSelling set ImagenFondoPrincipalDesktop = replace(ImagenFondoPrincipalDesktop, @BucketAntiguoPRD, @BucketNuevoPRD)

update UpSelling set ImagenFondoPrincipalMobile = replace(ImagenFondoPrincipalMobile, @BucketAntiguoQA, @BucketNuevoQA)
update UpSelling set ImagenFondoPrincipalMobile = replace(ImagenFondoPrincipalMobile, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from UpSellingDetalle
update UpSellingDetalle set Imagen = replace(Imagen, @BucketAntiguoQA, @BucketNuevoQA)
update UpSellingDetalle set Imagen = replace(Imagen, @BucketAntiguoPRD, @BucketNuevoPRD)

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
--[Unete].[SeccionNuestrosProductosItem].[UrlImagenHover]
--[Unete].[SeccionTestimonio].[UrlBoton]

go

USE BelcorpGuatemala
GO

declare @BucketAntiguoQA varchar(100) = 'cdn1-prd.somosbelcorp.com/'
declare @BucketNuevoQA varchar(100) = 'S3.amazonaws.com/consultorasPRD/SomosBelcorp/'

declare @BucketAntiguoPRD varchar(100) = 'cdn1-prd.somosbelcorp.com/'
declare @BucketNuevoPRD varchar(100) = 'S3.amazonaws.com/consultorasPRD/SomosBelcorp/'

--select * from CertificadoDigitalConfig
update CertificadoDigitalConfig set UrlFirma = replace(UrlFirma, @BucketAntiguoQA, @BucketNuevoQA)
update CertificadoDigitalConfig set UrlFirma = replace(UrlFirma, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from CertificadoDigitalLog
update CertificadoDigitalLog set UrlFirma = replace(UrlFirma, @BucketAntiguoQA, @BucketNuevoQA)
update CertificadoDigitalLog set UrlFirma = replace(UrlFirma, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from Comunicado
update Comunicado set UrlImagen = replace(UrlImagen, @BucketAntiguoQA, @BucketNuevoQA)
update Comunicado set UrlImagen = replace(UrlImagen, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from ConfiguracionPaisDatos
update ConfiguracionPaisDatos set Valor1 = replace(Valor1, @BucketAntiguoQA, @BucketNuevoQA)
update ConfiguracionPaisDatos set Valor1 = replace(Valor1, @BucketAntiguoPRD, @BucketNuevoPRD)

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

--select * from ProductoCompartido
update ProductoCompartido set Detalle = replace(Detalle, @BucketAntiguoQA, @BucketNuevoQA)
update ProductoCompartido set Detalle = replace(Detalle, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from ProductoSugerido
update ProductoSugerido set ImagenProducto = replace(ImagenProducto, @BucketAntiguoQA, @BucketNuevoQA)
update ProductoSugerido set ImagenProducto = replace(ImagenProducto, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from TablaLogicaDatos
update TablaLogicaDatos set Codigo = replace(Codigo, @BucketAntiguoQA, @BucketNuevoQA)
update TablaLogicaDatos set Codigo = replace(Codigo, @BucketAntiguoPRD, @BucketNuevoPRD)

update TablaLogicaDatos set Valor = replace(Valor, @BucketAntiguoQA, @BucketNuevoQA)
update TablaLogicaDatos set Valor = replace(Valor, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from UpSelling
update UpSelling set ImagenFondoGanasteMobile = replace(ImagenFondoGanasteMobile, @BucketAntiguoQA, @BucketNuevoQA)
update UpSelling set ImagenFondoGanasteMobile = replace(ImagenFondoGanasteMobile, @BucketAntiguoPRD, @BucketNuevoPRD)

update UpSelling set ImagenFondoPrincipalDesktop = replace(ImagenFondoPrincipalDesktop, @BucketAntiguoQA, @BucketNuevoQA)
update UpSelling set ImagenFondoPrincipalDesktop = replace(ImagenFondoPrincipalDesktop, @BucketAntiguoPRD, @BucketNuevoPRD)

update UpSelling set ImagenFondoPrincipalMobile = replace(ImagenFondoPrincipalMobile, @BucketAntiguoQA, @BucketNuevoQA)
update UpSelling set ImagenFondoPrincipalMobile = replace(ImagenFondoPrincipalMobile, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from UpSellingDetalle
update UpSellingDetalle set Imagen = replace(Imagen, @BucketAntiguoQA, @BucketNuevoQA)
update UpSellingDetalle set Imagen = replace(Imagen, @BucketAntiguoPRD, @BucketNuevoPRD)

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
--[Unete].[SeccionNuestrosProductosItem].[UrlImagenHover]
--[Unete].[SeccionTestimonio].[UrlBoton]

go

USE BelcorpEcuador
GO

declare @BucketAntiguoQA varchar(100) = 'cdn1-prd.somosbelcorp.com/'
declare @BucketNuevoQA varchar(100) = 'S3.amazonaws.com/consultorasPRD/SomosBelcorp/'

declare @BucketAntiguoPRD varchar(100) = 'cdn1-prd.somosbelcorp.com/'
declare @BucketNuevoPRD varchar(100) = 'S3.amazonaws.com/consultorasPRD/SomosBelcorp/'

--select * from CertificadoDigitalConfig
update CertificadoDigitalConfig set UrlFirma = replace(UrlFirma, @BucketAntiguoQA, @BucketNuevoQA)
update CertificadoDigitalConfig set UrlFirma = replace(UrlFirma, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from CertificadoDigitalLog
update CertificadoDigitalLog set UrlFirma = replace(UrlFirma, @BucketAntiguoQA, @BucketNuevoQA)
update CertificadoDigitalLog set UrlFirma = replace(UrlFirma, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from Comunicado
update Comunicado set UrlImagen = replace(UrlImagen, @BucketAntiguoQA, @BucketNuevoQA)
update Comunicado set UrlImagen = replace(UrlImagen, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from ConfiguracionPaisDatos
update ConfiguracionPaisDatos set Valor1 = replace(Valor1, @BucketAntiguoQA, @BucketNuevoQA)
update ConfiguracionPaisDatos set Valor1 = replace(Valor1, @BucketAntiguoPRD, @BucketNuevoPRD)

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

--select * from ProductoCompartido
update ProductoCompartido set Detalle = replace(Detalle, @BucketAntiguoQA, @BucketNuevoQA)
update ProductoCompartido set Detalle = replace(Detalle, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from ProductoSugerido
update ProductoSugerido set ImagenProducto = replace(ImagenProducto, @BucketAntiguoQA, @BucketNuevoQA)
update ProductoSugerido set ImagenProducto = replace(ImagenProducto, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from TablaLogicaDatos
update TablaLogicaDatos set Codigo = replace(Codigo, @BucketAntiguoQA, @BucketNuevoQA)
update TablaLogicaDatos set Codigo = replace(Codigo, @BucketAntiguoPRD, @BucketNuevoPRD)

update TablaLogicaDatos set Valor = replace(Valor, @BucketAntiguoQA, @BucketNuevoQA)
update TablaLogicaDatos set Valor = replace(Valor, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from UpSelling
update UpSelling set ImagenFondoGanasteMobile = replace(ImagenFondoGanasteMobile, @BucketAntiguoQA, @BucketNuevoQA)
update UpSelling set ImagenFondoGanasteMobile = replace(ImagenFondoGanasteMobile, @BucketAntiguoPRD, @BucketNuevoPRD)

update UpSelling set ImagenFondoPrincipalDesktop = replace(ImagenFondoPrincipalDesktop, @BucketAntiguoQA, @BucketNuevoQA)
update UpSelling set ImagenFondoPrincipalDesktop = replace(ImagenFondoPrincipalDesktop, @BucketAntiguoPRD, @BucketNuevoPRD)

update UpSelling set ImagenFondoPrincipalMobile = replace(ImagenFondoPrincipalMobile, @BucketAntiguoQA, @BucketNuevoQA)
update UpSelling set ImagenFondoPrincipalMobile = replace(ImagenFondoPrincipalMobile, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from UpSellingDetalle
update UpSellingDetalle set Imagen = replace(Imagen, @BucketAntiguoQA, @BucketNuevoQA)
update UpSellingDetalle set Imagen = replace(Imagen, @BucketAntiguoPRD, @BucketNuevoPRD)

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
--[Unete].[SeccionNuestrosProductosItem].[UrlImagenHover]
--[Unete].[SeccionTestimonio].[UrlBoton]

go

USE BelcorpDominicana
GO

declare @BucketAntiguoQA varchar(100) = 'cdn1-prd.somosbelcorp.com/'
declare @BucketNuevoQA varchar(100) = 'S3.amazonaws.com/consultorasPRD/SomosBelcorp/'

declare @BucketAntiguoPRD varchar(100) = 'cdn1-prd.somosbelcorp.com/'
declare @BucketNuevoPRD varchar(100) = 'S3.amazonaws.com/consultorasPRD/SomosBelcorp/'

--select * from CertificadoDigitalConfig
update CertificadoDigitalConfig set UrlFirma = replace(UrlFirma, @BucketAntiguoQA, @BucketNuevoQA)
update CertificadoDigitalConfig set UrlFirma = replace(UrlFirma, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from CertificadoDigitalLog
update CertificadoDigitalLog set UrlFirma = replace(UrlFirma, @BucketAntiguoQA, @BucketNuevoQA)
update CertificadoDigitalLog set UrlFirma = replace(UrlFirma, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from Comunicado
update Comunicado set UrlImagen = replace(UrlImagen, @BucketAntiguoQA, @BucketNuevoQA)
update Comunicado set UrlImagen = replace(UrlImagen, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from ConfiguracionPaisDatos
update ConfiguracionPaisDatos set Valor1 = replace(Valor1, @BucketAntiguoQA, @BucketNuevoQA)
update ConfiguracionPaisDatos set Valor1 = replace(Valor1, @BucketAntiguoPRD, @BucketNuevoPRD)

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

--select * from ProductoCompartido
update ProductoCompartido set Detalle = replace(Detalle, @BucketAntiguoQA, @BucketNuevoQA)
update ProductoCompartido set Detalle = replace(Detalle, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from ProductoSugerido
update ProductoSugerido set ImagenProducto = replace(ImagenProducto, @BucketAntiguoQA, @BucketNuevoQA)
update ProductoSugerido set ImagenProducto = replace(ImagenProducto, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from TablaLogicaDatos
update TablaLogicaDatos set Codigo = replace(Codigo, @BucketAntiguoQA, @BucketNuevoQA)
update TablaLogicaDatos set Codigo = replace(Codigo, @BucketAntiguoPRD, @BucketNuevoPRD)

update TablaLogicaDatos set Valor = replace(Valor, @BucketAntiguoQA, @BucketNuevoQA)
update TablaLogicaDatos set Valor = replace(Valor, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from UpSelling
update UpSelling set ImagenFondoGanasteMobile = replace(ImagenFondoGanasteMobile, @BucketAntiguoQA, @BucketNuevoQA)
update UpSelling set ImagenFondoGanasteMobile = replace(ImagenFondoGanasteMobile, @BucketAntiguoPRD, @BucketNuevoPRD)

update UpSelling set ImagenFondoPrincipalDesktop = replace(ImagenFondoPrincipalDesktop, @BucketAntiguoQA, @BucketNuevoQA)
update UpSelling set ImagenFondoPrincipalDesktop = replace(ImagenFondoPrincipalDesktop, @BucketAntiguoPRD, @BucketNuevoPRD)

update UpSelling set ImagenFondoPrincipalMobile = replace(ImagenFondoPrincipalMobile, @BucketAntiguoQA, @BucketNuevoQA)
update UpSelling set ImagenFondoPrincipalMobile = replace(ImagenFondoPrincipalMobile, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from UpSellingDetalle
update UpSellingDetalle set Imagen = replace(Imagen, @BucketAntiguoQA, @BucketNuevoQA)
update UpSellingDetalle set Imagen = replace(Imagen, @BucketAntiguoPRD, @BucketNuevoPRD)

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
--[Unete].[SeccionNuestrosProductosItem].[UrlImagenHover]
--[Unete].[SeccionTestimonio].[UrlBoton]

go

USE BelcorpCostaRica
GO

declare @BucketAntiguoQA varchar(100) = 'cdn1-prd.somosbelcorp.com/'
declare @BucketNuevoQA varchar(100) = 'S3.amazonaws.com/consultorasPRD/SomosBelcorp/'

declare @BucketAntiguoPRD varchar(100) = 'cdn1-prd.somosbelcorp.com/'
declare @BucketNuevoPRD varchar(100) = 'S3.amazonaws.com/consultorasPRD/SomosBelcorp/'

--select * from CertificadoDigitalConfig
update CertificadoDigitalConfig set UrlFirma = replace(UrlFirma, @BucketAntiguoQA, @BucketNuevoQA)
update CertificadoDigitalConfig set UrlFirma = replace(UrlFirma, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from CertificadoDigitalLog
update CertificadoDigitalLog set UrlFirma = replace(UrlFirma, @BucketAntiguoQA, @BucketNuevoQA)
update CertificadoDigitalLog set UrlFirma = replace(UrlFirma, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from Comunicado
update Comunicado set UrlImagen = replace(UrlImagen, @BucketAntiguoQA, @BucketNuevoQA)
update Comunicado set UrlImagen = replace(UrlImagen, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from ConfiguracionPaisDatos
update ConfiguracionPaisDatos set Valor1 = replace(Valor1, @BucketAntiguoQA, @BucketNuevoQA)
update ConfiguracionPaisDatos set Valor1 = replace(Valor1, @BucketAntiguoPRD, @BucketNuevoPRD)

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

--select * from ProductoCompartido
update ProductoCompartido set Detalle = replace(Detalle, @BucketAntiguoQA, @BucketNuevoQA)
update ProductoCompartido set Detalle = replace(Detalle, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from ProductoSugerido
update ProductoSugerido set ImagenProducto = replace(ImagenProducto, @BucketAntiguoQA, @BucketNuevoQA)
update ProductoSugerido set ImagenProducto = replace(ImagenProducto, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from TablaLogicaDatos
update TablaLogicaDatos set Codigo = replace(Codigo, @BucketAntiguoQA, @BucketNuevoQA)
update TablaLogicaDatos set Codigo = replace(Codigo, @BucketAntiguoPRD, @BucketNuevoPRD)

update TablaLogicaDatos set Valor = replace(Valor, @BucketAntiguoQA, @BucketNuevoQA)
update TablaLogicaDatos set Valor = replace(Valor, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from UpSelling
update UpSelling set ImagenFondoGanasteMobile = replace(ImagenFondoGanasteMobile, @BucketAntiguoQA, @BucketNuevoQA)
update UpSelling set ImagenFondoGanasteMobile = replace(ImagenFondoGanasteMobile, @BucketAntiguoPRD, @BucketNuevoPRD)

update UpSelling set ImagenFondoPrincipalDesktop = replace(ImagenFondoPrincipalDesktop, @BucketAntiguoQA, @BucketNuevoQA)
update UpSelling set ImagenFondoPrincipalDesktop = replace(ImagenFondoPrincipalDesktop, @BucketAntiguoPRD, @BucketNuevoPRD)

update UpSelling set ImagenFondoPrincipalMobile = replace(ImagenFondoPrincipalMobile, @BucketAntiguoQA, @BucketNuevoQA)
update UpSelling set ImagenFondoPrincipalMobile = replace(ImagenFondoPrincipalMobile, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from UpSellingDetalle
update UpSellingDetalle set Imagen = replace(Imagen, @BucketAntiguoQA, @BucketNuevoQA)
update UpSellingDetalle set Imagen = replace(Imagen, @BucketAntiguoPRD, @BucketNuevoPRD)

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
--[Unete].[SeccionNuestrosProductosItem].[UrlImagenHover]
--[Unete].[SeccionTestimonio].[UrlBoton]

go

USE BelcorpChile
GO

declare @BucketAntiguoQA varchar(100) = 'cdn1-prd.somosbelcorp.com/'
declare @BucketNuevoQA varchar(100) = 'S3.amazonaws.com/consultorasPRD/SomosBelcorp/'

declare @BucketAntiguoPRD varchar(100) = 'cdn1-prd.somosbelcorp.com/'
declare @BucketNuevoPRD varchar(100) = 'S3.amazonaws.com/consultorasPRD/SomosBelcorp/'

--select * from CertificadoDigitalConfig
update CertificadoDigitalConfig set UrlFirma = replace(UrlFirma, @BucketAntiguoQA, @BucketNuevoQA)
update CertificadoDigitalConfig set UrlFirma = replace(UrlFirma, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from CertificadoDigitalLog
update CertificadoDigitalLog set UrlFirma = replace(UrlFirma, @BucketAntiguoQA, @BucketNuevoQA)
update CertificadoDigitalLog set UrlFirma = replace(UrlFirma, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from Comunicado
update Comunicado set UrlImagen = replace(UrlImagen, @BucketAntiguoQA, @BucketNuevoQA)
update Comunicado set UrlImagen = replace(UrlImagen, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from ConfiguracionPaisDatos
update ConfiguracionPaisDatos set Valor1 = replace(Valor1, @BucketAntiguoQA, @BucketNuevoQA)
update ConfiguracionPaisDatos set Valor1 = replace(Valor1, @BucketAntiguoPRD, @BucketNuevoPRD)

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

--select * from ProductoCompartido
update ProductoCompartido set Detalle = replace(Detalle, @BucketAntiguoQA, @BucketNuevoQA)
update ProductoCompartido set Detalle = replace(Detalle, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from ProductoSugerido
update ProductoSugerido set ImagenProducto = replace(ImagenProducto, @BucketAntiguoQA, @BucketNuevoQA)
update ProductoSugerido set ImagenProducto = replace(ImagenProducto, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from TablaLogicaDatos
update TablaLogicaDatos set Codigo = replace(Codigo, @BucketAntiguoQA, @BucketNuevoQA)
update TablaLogicaDatos set Codigo = replace(Codigo, @BucketAntiguoPRD, @BucketNuevoPRD)

update TablaLogicaDatos set Valor = replace(Valor, @BucketAntiguoQA, @BucketNuevoQA)
update TablaLogicaDatos set Valor = replace(Valor, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from UpSelling
update UpSelling set ImagenFondoGanasteMobile = replace(ImagenFondoGanasteMobile, @BucketAntiguoQA, @BucketNuevoQA)
update UpSelling set ImagenFondoGanasteMobile = replace(ImagenFondoGanasteMobile, @BucketAntiguoPRD, @BucketNuevoPRD)

update UpSelling set ImagenFondoPrincipalDesktop = replace(ImagenFondoPrincipalDesktop, @BucketAntiguoQA, @BucketNuevoQA)
update UpSelling set ImagenFondoPrincipalDesktop = replace(ImagenFondoPrincipalDesktop, @BucketAntiguoPRD, @BucketNuevoPRD)

update UpSelling set ImagenFondoPrincipalMobile = replace(ImagenFondoPrincipalMobile, @BucketAntiguoQA, @BucketNuevoQA)
update UpSelling set ImagenFondoPrincipalMobile = replace(ImagenFondoPrincipalMobile, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from UpSellingDetalle
update UpSellingDetalle set Imagen = replace(Imagen, @BucketAntiguoQA, @BucketNuevoQA)
update UpSellingDetalle set Imagen = replace(Imagen, @BucketAntiguoPRD, @BucketNuevoPRD)

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
--[Unete].[SeccionNuestrosProductosItem].[UrlImagenHover]
--[Unete].[SeccionTestimonio].[UrlBoton]

go

USE BelcorpBolivia
GO

declare @BucketAntiguoQA varchar(100) = 'cdn1-prd.somosbelcorp.com/'
declare @BucketNuevoQA varchar(100) = 'S3.amazonaws.com/consultorasPRD/SomosBelcorp/'

declare @BucketAntiguoPRD varchar(100) = 'cdn1-prd.somosbelcorp.com/'
declare @BucketNuevoPRD varchar(100) = 'S3.amazonaws.com/consultorasPRD/SomosBelcorp/'

--select * from CertificadoDigitalConfig
update CertificadoDigitalConfig set UrlFirma = replace(UrlFirma, @BucketAntiguoQA, @BucketNuevoQA)
update CertificadoDigitalConfig set UrlFirma = replace(UrlFirma, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from CertificadoDigitalLog
update CertificadoDigitalLog set UrlFirma = replace(UrlFirma, @BucketAntiguoQA, @BucketNuevoQA)
update CertificadoDigitalLog set UrlFirma = replace(UrlFirma, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from Comunicado
update Comunicado set UrlImagen = replace(UrlImagen, @BucketAntiguoQA, @BucketNuevoQA)
update Comunicado set UrlImagen = replace(UrlImagen, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from ConfiguracionPaisDatos
update ConfiguracionPaisDatos set Valor1 = replace(Valor1, @BucketAntiguoQA, @BucketNuevoQA)
update ConfiguracionPaisDatos set Valor1 = replace(Valor1, @BucketAntiguoPRD, @BucketNuevoPRD)

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

--select * from ProductoCompartido
update ProductoCompartido set Detalle = replace(Detalle, @BucketAntiguoQA, @BucketNuevoQA)
update ProductoCompartido set Detalle = replace(Detalle, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from ProductoSugerido
update ProductoSugerido set ImagenProducto = replace(ImagenProducto, @BucketAntiguoQA, @BucketNuevoQA)
update ProductoSugerido set ImagenProducto = replace(ImagenProducto, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from TablaLogicaDatos
update TablaLogicaDatos set Codigo = replace(Codigo, @BucketAntiguoQA, @BucketNuevoQA)
update TablaLogicaDatos set Codigo = replace(Codigo, @BucketAntiguoPRD, @BucketNuevoPRD)

update TablaLogicaDatos set Valor = replace(Valor, @BucketAntiguoQA, @BucketNuevoQA)
update TablaLogicaDatos set Valor = replace(Valor, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from UpSelling
update UpSelling set ImagenFondoGanasteMobile = replace(ImagenFondoGanasteMobile, @BucketAntiguoQA, @BucketNuevoQA)
update UpSelling set ImagenFondoGanasteMobile = replace(ImagenFondoGanasteMobile, @BucketAntiguoPRD, @BucketNuevoPRD)

update UpSelling set ImagenFondoPrincipalDesktop = replace(ImagenFondoPrincipalDesktop, @BucketAntiguoQA, @BucketNuevoQA)
update UpSelling set ImagenFondoPrincipalDesktop = replace(ImagenFondoPrincipalDesktop, @BucketAntiguoPRD, @BucketNuevoPRD)

update UpSelling set ImagenFondoPrincipalMobile = replace(ImagenFondoPrincipalMobile, @BucketAntiguoQA, @BucketNuevoQA)
update UpSelling set ImagenFondoPrincipalMobile = replace(ImagenFondoPrincipalMobile, @BucketAntiguoPRD, @BucketNuevoPRD)

--select * from UpSellingDetalle
update UpSellingDetalle set Imagen = replace(Imagen, @BucketAntiguoQA, @BucketNuevoQA)
update UpSellingDetalle set Imagen = replace(Imagen, @BucketAntiguoPRD, @BucketNuevoPRD)

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
--[Unete].[SeccionNuestrosProductosItem].[UrlImagenHover]
--[Unete].[SeccionTestimonio].[UrlBoton]

go

