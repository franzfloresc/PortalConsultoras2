/// <reference path="../../../../../portalconsultoras/detalleestrategia/ficharesponsive/componentes/componentespresenter.js" />
/// <reference path="../../../../../portalconsultoras/detalleestrategia/ficharesponsive/componentes/componentesview.js" />


describe("DetalleEstrategia - FichaResponsive - Estrategia - ComponentesPresenter", function () {
   var errorMsg = '';
   var componentesView;
   var componentesPresenter;
   
   var estrategiaUnComponenteFactorCuadreIgualADos = function () {
      return {
         "CodigoVideo": null,
         "OrigenUrl": "1050101",
         "OrigenAgregar": 1050102,
         "OrigenAgregarCarrusel": 1050105,
         "CodigoUbigeoPortal": "",
         "Palanca": "Especiales",
         "TieneSession": true,
         "Campania": 201908,
         "Cuv": "31590",
         "EsEditable": false,
         "IsMobile": false,
         "TieneReloj": false,
         "TieneCompartir": true,
         "TieneCarrusel": true,
         "TeQuedan": 0,
         "ColorFondo1": null,
         "ConfiguracionContenedor": {},
         "BreadCrumbs": {
            "Visible": true,
            "TipoAccionNavegar": 1,
            "Inicio": {
               "Texto": "Inicio",
               "Url": "/Bienvenida"
            },
            "Ofertas": {
               "Texto": "Gana +",
               "Url": "/Ofertas"
            },
            "Palanca": {
               "Texto": "Especiales",
               "Url": "/ShowRoom"
            },
            "Producto": {
               "Texto": null,
               "Url": "#"
            }
         },
         "EsVC": false,
         "TipoAccionNavegar": 1,
         "NoEsCampaniaActual": false,
         "Error": false,
         "Cantidad": 1,
         "MostrarCliente": false,
         "MostrarAdicional": true,
         "MostrarFichaEnriquecida": true,
         "MostrarFichaResponsive": true,
         "ArrayContenidoSet": [],
         "CampaniaID": 201908,
         "ClaseBloqueada": "btn_desactivado_general",
         "ClaseEstrategia": "revistadigital-landing",
         "CodigoCategoria": null,
         "CodigoEstrategia": "030",
         "CodigoProducto": null,
         "CodigoVariante": "2003",
         "CUV2": "31590",
         "DescripcionCompleta": "Pack x 2 Twelve O'clock",
         "DescripcionCortada": "Pack x 2 Twelve O'clock",
         "DescripcionDetalle": "",
         "DescripcionMarca": "Cyzone",
         "DescripcionResumen": "",
         "DescripcionCategoria": null,
         "EsMultimarca": false,
         "EsOfertaIndependiente": false,
         "EsSubcampania": false,
         "EstrategiaID": 58371,
         "FlagNueva": 0,
         "FotoProducto01": "PE_201908_31590.jpg",
         "Ganancia": 41.9,
         "GananciaString": "41.90",
         "Hermanos": [
            {
               "Cantidad": 1,
               "CodigoProducto": null,
               "Cuv": "31305",
               "Descripcion": null,
               "DescripcionComercial": null,
               "DescripcionMarca": "Cyzone",
               "Digitable": 1,
               "FactorCuadre": 2,
               "Grupo": "1",
               "Id": 0,
               "IdMarca": 3,
               "Imagen": null,
               "ImagenBulk": "https://s3-sa-east-1.amazonaws.com/appcatalogo/PE/201910/C/productos/PE_200087598.jpg",
               "ImagenProductoSugerido": null,
               "NombreBulk": null,
               "NombreComercial": "Cy Twelve o'clock. Romantic Chic 10 g / .35 oz.",
               "Orden": 0,
               "PrecioCatalogo": 31.95,
               "PrecioCatalogoString": null,
               "DescripcionPlural": null,
               "DescripcionSingular": null,
               "Volumen": null,
               "Cabecera": {
                  "ContenidoNeto": "10.0 G",
                  "Dimensiones": "66.000 x 146.000 x 16.000 MM",
                  "TallaMedidas": ""
               },
               "Secciones": [
                  {
                     "Tipo": "02",
                     "Titulo": "Descubre más",
                     "Detalles": [
                        {
                           "Titulo": "CONOCE EL PRODUCTO",
                           "Descripcion": "Crea infinitos looks para resaltar tu mirada con el doceteto de sombras cy twelve o’clock. Su paleta tiene 12 tonos que se adaptan a cualquier ocasión. Los tonos más claros, por ejemplo, son perfectos como base para crear un maquillaje sofisticado y/o para looks naturales y elegantes. Los tonos más oscuros, dan profundidad y carácter a la mirada. Con tantas opciones no tendrás problema de elegir cómo quieres que se vean tus ojos hoy!<lt/>br<gt/><lt/>br<gt/>La paleta de sombras twelve o’ clock incluye dos pinceles aplicadores. Con uno puedes aplicarte la sombra por todo el párpado y con el otro difuminar o extender el color como si fuera un delineador.<lt/>br<gt/><lt/>br<gt/>Probar, jugar y divertirse creando looks es todo un arte; y las cy twelve o’clock te invitan a ser una artista. Por eso son nuestras favoritas!! Ponte creativa y prueba combinaciones que nunca creíste hacer. Este doceteto de sombras te da la libertad de crear y de lucir una mirada diferente cada día!!<lt/>br<gt/><lt/>br<gt/>Te preguntarás ¿Debería llevar mis sombras cy twelve o’clock siempre conmigo? Por supuesto!! Te aconsejamos llevar tu doceteto de sombras a todas partes. Su variedad hará que siempre encuentres el tono perfecto para la ocasión. No importa si es de día, de noche, sport o elegante, con este doceteto podrás crear el maquillaje de ojos perfecto.",
                           "Key": ""
                        },
                        {
                           "Titulo": "CÓMO Y CUÁNDO USARLAS",
                           "Descripcion": "El secreto para elegir qué tonos usarás para crear miles de miradas es tu Outfit. Lo creas o no, es importante que tu maquillaje de ojos combine a la perfección con tu ropa.<lt/>br<gt/>Hay mil formas de combinar tus tonos, aquí te enseñaremos los 3 pasos básicos al momento de maquillar tus ojos.<lt/>br<gt/><lt/>br<gt/>Primero: Luego de elegir tu outfit empieza eligiendo el tono claro que más se ajusta a él. Este tono iluminará tu mirada dándole una sensación de brillo. <lt/>br<gt/>Segundo: Usa los tonos medios de la paleta para resaltar. Este efecto puede hacer que tu mirada se vea más grande y atractiva. <lt/>br<gt/>Tercero: Para darle ese toque sensual y de profundidad a tu mirada, usa el tono oscuro en la parte superior del ojo o en el párpado inferior.",
                           "Key": ""
                        },
                        {
                           "Titulo": "MÁS DETALLES DEL PRODUCTO",
                           "Descripcion": "Las sombras para ojos cyº twelve o’clock tienen una capacidad de 10g/.35 oz.",
                           "Key": ""
                        }
                     ]
                  },
                  {
                     "Tipo": "01",
                     "Titulo": "Videos",
                     "Detalles": [
                        {
                           "Titulo": "",
                           "Descripcion": "",
                           "Key": "nhjMmGVmBdA"
                        },
                        {
                           "Titulo": "",
                           "Descripcion": "",
                           "Key": "15eaUErPC_7"
                        },
                        {
                           "Titulo": "",
                           "Descripcion": "",
                           "Key": "2MvJMcsGaaE"
                        },
                        {
                           "Titulo": "",
                           "Descripcion": "",
                           "Key": "TH5XfTtE7bg"
                        },
                        {
                           "Titulo": "",
                           "Descripcion": "",
                           "Key": "g7EvzAcWepM"
                        }
                     ]
                  }
               ],
               "Hermanos": [
                  {
                     "Cantidad": 1,
                     "CodigoProducto": null,
                     "Cuv": "31305",
                     "Descripcion": null,
                     "DescripcionComercial": null,
                     "DescripcionMarca": "Cyzone",
                     "Digitable": 1,
                     "FactorCuadre": 2,
                     "Grupo": "1",
                     "Id": 0,
                     "IdMarca": 3,
                     "Imagen": null,
                     "ImagenBulk": "https://s3-sa-east-1.amazonaws.com/appcatalogo/PE/201910/C/productos/bulk/PE_200087598_B.jpg",
                     "ImagenProductoSugerido": null,
                     "NombreBulk": "Romantic Chic",
                     "NombreComercial": "Cy Twelve o'clock. Romantic Chic 10 g / .35 oz.",
                     "Orden": 1,
                     "PrecioCatalogo": 31.95,
                     "PrecioCatalogoString": null,
                     "DescripcionPlural": null,
                     "DescripcionSingular": null,
                     "Volumen": "10 g / .35 oz.",
                     "Cabecera": null,
                     "Secciones": [],
                     "Hermanos": [],
                     "TieneDetalleSeccion": false,
                     "TieneStock": true,
                     "EstrategiaGrupoId": 0,
                     "TieneFichaEnriquecidaActiva": false
                  },
                  {
                     "Cantidad": 1,
                     "CodigoProducto": null,
                     "Cuv": "31593",
                     "Descripcion": null,
                     "DescripcionComercial": null,
                     "DescripcionMarca": "Cyzone",
                     "Digitable": 1,
                     "FactorCuadre": 2,
                     "Grupo": "1",
                     "Id": 0,
                     "IdMarca": 3,
                     "Imagen": null,
                     "ImagenBulk": "https://s3-sa-east-1.amazonaws.com/appcatalogo/PE/201910/C/productos/bulk/PE_200093810_B.jpg",
                     "ImagenProductoSugerido": null,
                     "NombreBulk": "Nude energy",
                     "NombreComercial": "Cy Twelve o'clock. Nude Energy 10 g / .35 oz.",
                     "Orden": 2,
                     "PrecioCatalogo": 31.95,
                     "PrecioCatalogoString": null,
                     "DescripcionPlural": null,
                     "DescripcionSingular": null,
                     "Volumen": "10 g / .35 oz.",
                     "Cabecera": null,
                     "Secciones": [],
                     "Hermanos": [],
                     "TieneDetalleSeccion": false,
                     "TieneStock": true,
                     "EstrategiaGrupoId": 0,
                     "TieneFichaEnriquecidaActiva": false
                  },
                  {
                     "Cantidad": 1,
                     "CodigoProducto": null,
                     "Cuv": "31306",
                     "Descripcion": null,
                     "DescripcionComercial": null,
                     "DescripcionMarca": "Cyzone",
                     "Digitable": 1,
                     "FactorCuadre": 2,
                     "Grupo": "1",
                     "Id": 0,
                     "IdMarca": 3,
                     "Imagen": null,
                     "ImagenBulk": "https://s3-sa-east-1.amazonaws.com/appcatalogo/PE/201910/C/productos/bulk/PE_200087599_B.jpg",
                     "ImagenProductoSugerido": null,
                     "NombreBulk": "Sexy Wishes",
                     "NombreComercial": "Cy Twelve o'clock. Sexy Wishes 10 g / .35 oz.",
                     "Orden": 3,
                     "PrecioCatalogo": 31.95,
                     "PrecioCatalogoString": null,
                     "DescripcionPlural": null,
                     "DescripcionSingular": null,
                     "Volumen": "10 g / .35 oz.",
                     "Cabecera": null,
                     "Secciones": [],
                     "Hermanos": [],
                     "TieneDetalleSeccion": false,
                     "TieneStock": true,
                     "EstrategiaGrupoId": 0,
                     "TieneFichaEnriquecidaActiva": false
                  },
                  {
                     "Cantidad": 1,
                     "CodigoProducto": null,
                     "Cuv": "31590",
                     "Descripcion": null,
                     "DescripcionComercial": null,
                     "DescripcionMarca": "Cyzone",
                     "Digitable": 1,
                     "FactorCuadre": 2,
                     "Grupo": "1",
                     "Id": 0,
                     "IdMarca": 3,
                     "Imagen": null,
                     "ImagenBulk": "https://s3-sa-east-1.amazonaws.com/appcatalogo/PE/201910/C/productos/bulk/PE_200093809_B.jpg",
                     "ImagenProductoSugerido": null,
                     "NombreBulk": "Urban chic",
                     "NombreComercial": "Cy Twelve o'clock. Urban chic 10 g / .35 oz.",
                     "Orden": 4,
                     "PrecioCatalogo": 31.95,
                     "PrecioCatalogoString": null,
                     "DescripcionPlural": null,
                     "DescripcionSingular": null,
                     "Volumen": "10 g / .35 oz.",
                     "Cabecera": null,
                     "Secciones": [],
                     "Hermanos": [],
                     "TieneDetalleSeccion": false,
                     "TieneStock": true,
                     "EstrategiaGrupoId": 0,
                     "TieneFichaEnriquecidaActiva": false
                  },
                  {
                     "Cantidad": 1,
                     "CodigoProducto": null,
                     "Cuv": "31301",
                     "Descripcion": null,
                     "DescripcionComercial": null,
                     "DescripcionMarca": "Cyzone",
                     "Digitable": 1,
                     "FactorCuadre": 2,
                     "Grupo": "1",
                     "Id": 0,
                     "IdMarca": 3,
                     "Imagen": null,
                     "ImagenBulk": "https://s3-sa-east-1.amazonaws.com/appcatalogo/PE/201910/C/productos/bulk/PE_200087597_B.jpg",
                     "ImagenProductoSugerido": null,
                     "NombreBulk": "Gala Time",
                     "NombreComercial": "Cy Twelve o'clock. Gala Time 10 g / .35 oz.",
                     "Orden": 5,
                     "PrecioCatalogo": 31.95,
                     "PrecioCatalogoString": null,
                     "DescripcionPlural": null,
                     "DescripcionSingular": null,
                     "Volumen": "10 g / .35 oz.",
                     "Cabecera": null,
                     "Secciones": [],
                     "Hermanos": [],
                     "TieneDetalleSeccion": false,
                     "TieneStock": true,
                     "EstrategiaGrupoId": 0,
                     "TieneFichaEnriquecidaActiva": false
                  },
                  {
                     "Cantidad": 1,
                     "CodigoProducto": null,
                     "Cuv": "31757",
                     "Descripcion": null,
                     "DescripcionComercial": null,
                     "DescripcionMarca": "Cyzone",
                     "Digitable": 1,
                     "FactorCuadre": 2,
                     "Grupo": "1",
                     "Id": 0,
                     "IdMarca": 3,
                     "Imagen": null,
                     "ImagenBulk": "https://s3-sa-east-1.amazonaws.com/appcatalogo/PE/201910/C/productos/bulk/PE_200096568_B.jpg",
                     "ImagenProductoSugerido": null,
                     "NombreBulk": "Color Fever",
                     "NombreComercial": "Cy Twelve o'clock. Color Fever 10 g / .35 oz.",
                     "Orden": 6,
                     "PrecioCatalogo": 31.95,
                     "PrecioCatalogoString": null,
                     "DescripcionPlural": null,
                     "DescripcionSingular": null,
                     "Volumen": "10 g / .35 oz.",
                     "Cabecera": null,
                     "Secciones": [],
                     "Hermanos": [],
                     "TieneDetalleSeccion": false,
                     "TieneStock": true,
                     "EstrategiaGrupoId": 0,
                     "TieneFichaEnriquecidaActiva": false
                  }
               ],
               "TieneDetalleSeccion": true,
               "TieneStock": true,
               "EstrategiaGrupoId": 0,
               "TieneFichaEnriquecidaActiva": false,
               "esCampaniaSiguiente": false
            }
         ],
         "ImagenProductoMini": null,
         "ImagenURL": "",
         "IsAgregado": false,
         "ListaDescripcionDetalle": [],
         "ListaPrecioNiveles": [],
         "MarcaID": 3,
         "MensajeProductoBloqueado": {
            "divId": null,
            "MensajeIconoSuperior": true,
            "BtnInscribirse": false,
            "MensajeTitulo": "A partir de la próxima campaña podrás disfrutar de esta y más ofertas.",
            "IsMobile": false,
            "MensajeTieneDudas": true,
            "MensajePopupPrimero": null,
            "MensajePopupSegundo": null,
            "MensajeBtnPopup": null,
            "IdPopup": null,
            "UrlBtnPopup": null
         },
         "Posicion": 0,
         "Precio": 105.8,
         "Precio2": 63.9,
         "PrecioTachado": "105.80",
         "PrecioVenta": "63.90",
         "TextoLibre": "",
         "TienePaginaProducto": false,
         "TienePaginaProductoMob": false,
         "TipoAccionAgregar": 3,
         "TipoEstrategiaDetalle": {
            "FlagIndividual": false,
            "Slogan": null,
            "ImgHomeDesktop": null,
            "ImgFondoDesktop": null,
            "ImgFichaDesktop": null,
            "ImgFichaFondoDesktop": null,
            "UrlVideoDesktop": null,
            "ImgHomeMobile": null,
            "ImgFondoMobile": null,
            "ImgFichaMobile": null,
            "ImgFichaFondoMobile": null,
            "UrlVideoMobile": null
         },
         "TipoEstrategiaID": 3027,
         "TipoEstrategiaImagenMostrar": 6,
         "EsBannerProgNuevas": false,
         "CodigoPalanca": "",
         "TieneStock": true,
         "EsDuoPerfecto": false,
         "CantidadPack": 2,
         "esCampaniaSiguiente": false,
         "ClaseBloqueadaRangos": "contenedor_rangos_desactivado",
         "RangoInputEnabled": "disabled",
         "esEditable": false,
         "setId": 0,
         "TipoPersonalizacion": "030"
      };

   };

   var estrategiaUnComponenteFactorCuadreIgualAUno = function () {
      return {
         "CodigoVideo": null,
         "OrigenUrl": "1050101",
         "OrigenAgregar": 1050102,
         "OrigenAgregarCarrusel": 1050105,
         "CodigoUbigeoPortal": "",
         "Palanca": "Especiales",
         "TieneSession": true,
         "Campania": 201908,
         "Cuv": "31590",
         "EsEditable": false,
         "IsMobile": false,
         "TieneReloj": false,
         "TieneCompartir": true,
         "TieneCarrusel": true,
         "TeQuedan": 0,
         "ColorFondo1": null,
         "ConfiguracionContenedor": {},
         "BreadCrumbs": {
            "Visible": true,
            "TipoAccionNavegar": 1,
            "Inicio": {
               "Texto": "Inicio",
               "Url": "/Bienvenida"
            },
            "Ofertas": {
               "Texto": "Gana +",
               "Url": "/Ofertas"
            },
            "Palanca": {
               "Texto": "Especiales",
               "Url": "/ShowRoom"
            },
            "Producto": {
               "Texto": null,
               "Url": "#"
            }
         },
         "EsVC": false,
         "TipoAccionNavegar": 1,
         "NoEsCampaniaActual": false,
         "Error": false,
         "Cantidad": 1,
         "MostrarCliente": false,
         "MostrarAdicional": true,
         "MostrarFichaEnriquecida": true,
         "MostrarFichaResponsive": true,
         "ArrayContenidoSet": [],
         "CampaniaID": 201908,
         "ClaseBloqueada": "btn_desactivado_general",
         "ClaseEstrategia": "revistadigital-landing",
         "CodigoCategoria": null,
         "CodigoEstrategia": "030",
         "CodigoProducto": null,
         "CodigoVariante": "2003",
         "CUV2": "31590",
         "DescripcionCompleta": "Pack x 2 Twelve O'clock",
         "DescripcionCortada": "Pack x 2 Twelve O'clock",
         "DescripcionDetalle": "",
         "DescripcionMarca": "Cyzone",
         "DescripcionResumen": "",
         "DescripcionCategoria": null,
         "EsMultimarca": false,
         "EsOfertaIndependiente": false,
         "EsSubcampania": false,
         "EstrategiaID": 58371,
         "FlagNueva": 0,
         "FotoProducto01": "PE_201908_31590.jpg",
         "Ganancia": 41.9,
         "GananciaString": "41.90",
         "Hermanos": [
            {
               "Cantidad": 1,
               "CodigoProducto": null,
               "Cuv": "31305",
               "Descripcion": null,
               "DescripcionComercial": null,
               "DescripcionMarca": "Cyzone",
               "Digitable": 1,
               "FactorCuadre": 1,
               "Grupo": "1",
               "Id": 0,
               "IdMarca": 3,
               "Imagen": null,
               "ImagenBulk": "https://s3-sa-east-1.amazonaws.com/appcatalogo/PE/201910/C/productos/PE_200087598.jpg",
               "ImagenProductoSugerido": null,
               "NombreBulk": null,
               "NombreComercial": "Cy Twelve o'clock. Romantic Chic 10 g / .35 oz.",
               "Orden": 0,
               "PrecioCatalogo": 31.95,
               "PrecioCatalogoString": null,
               "DescripcionPlural": null,
               "DescripcionSingular": null,
               "Volumen": null,
               "Cabecera": {
                  "ContenidoNeto": "10.0 G",
                  "Dimensiones": "66.000 x 146.000 x 16.000 MM",
                  "TallaMedidas": ""
               },
               "Secciones": [
                  {
                     "Tipo": "02",
                     "Titulo": "Descubre más",
                     "Detalles": [
                        {
                           "Titulo": "CONOCE EL PRODUCTO",
                           "Descripcion": "Crea infinitos looks para resaltar tu mirada con el doceteto de sombras cy twelve o’clock. Su paleta tiene 12 tonos que se adaptan a cualquier ocasión. Los tonos más claros, por ejemplo, son perfectos como base para crear un maquillaje sofisticado y/o para looks naturales y elegantes. Los tonos más oscuros, dan profundidad y carácter a la mirada. Con tantas opciones no tendrás problema de elegir cómo quieres que se vean tus ojos hoy!<lt/>br<gt/><lt/>br<gt/>La paleta de sombras twelve o’ clock incluye dos pinceles aplicadores. Con uno puedes aplicarte la sombra por todo el párpado y con el otro difuminar o extender el color como si fuera un delineador.<lt/>br<gt/><lt/>br<gt/>Probar, jugar y divertirse creando looks es todo un arte; y las cy twelve o’clock te invitan a ser una artista. Por eso son nuestras favoritas!! Ponte creativa y prueba combinaciones que nunca creíste hacer. Este doceteto de sombras te da la libertad de crear y de lucir una mirada diferente cada día!!<lt/>br<gt/><lt/>br<gt/>Te preguntarás ¿Debería llevar mis sombras cy twelve o’clock siempre conmigo? Por supuesto!! Te aconsejamos llevar tu doceteto de sombras a todas partes. Su variedad hará que siempre encuentres el tono perfecto para la ocasión. No importa si es de día, de noche, sport o elegante, con este doceteto podrás crear el maquillaje de ojos perfecto.",
                           "Key": ""
                        },
                        {
                           "Titulo": "CÓMO Y CUÁNDO USARLAS",
                           "Descripcion": "El secreto para elegir qué tonos usarás para crear miles de miradas es tu Outfit. Lo creas o no, es importante que tu maquillaje de ojos combine a la perfección con tu ropa.<lt/>br<gt/>Hay mil formas de combinar tus tonos, aquí te enseñaremos los 3 pasos básicos al momento de maquillar tus ojos.<lt/>br<gt/><lt/>br<gt/>Primero: Luego de elegir tu outfit empieza eligiendo el tono claro que más se ajusta a él. Este tono iluminará tu mirada dándole una sensación de brillo. <lt/>br<gt/>Segundo: Usa los tonos medios de la paleta para resaltar. Este efecto puede hacer que tu mirada se vea más grande y atractiva. <lt/>br<gt/>Tercero: Para darle ese toque sensual y de profundidad a tu mirada, usa el tono oscuro en la parte superior del ojo o en el párpado inferior.",
                           "Key": ""
                        },
                        {
                           "Titulo": "MÁS DETALLES DEL PRODUCTO",
                           "Descripcion": "Las sombras para ojos cyº twelve o’clock tienen una capacidad de 10g/.35 oz.",
                           "Key": ""
                        }
                     ]
                  },
                  {
                     "Tipo": "01",
                     "Titulo": "Videos",
                     "Detalles": [
                        {
                           "Titulo": "",
                           "Descripcion": "",
                           "Key": "nhjMmGVmBdA"
                        },
                        {
                           "Titulo": "",
                           "Descripcion": "",
                           "Key": "15eaUErPC_7"
                        },
                        {
                           "Titulo": "",
                           "Descripcion": "",
                           "Key": "2MvJMcsGaaE"
                        },
                        {
                           "Titulo": "",
                           "Descripcion": "",
                           "Key": "TH5XfTtE7bg"
                        },
                        {
                           "Titulo": "",
                           "Descripcion": "",
                           "Key": "g7EvzAcWepM"
                        }
                     ]
                  }
               ],
               "Hermanos": [
                  {
                     "Cantidad": 1,
                     "CodigoProducto": null,
                     "Cuv": "31305",
                     "Descripcion": null,
                     "DescripcionComercial": null,
                     "DescripcionMarca": "Cyzone",
                     "Digitable": 1,
                     "FactorCuadre": 1,
                     "Grupo": "1",
                     "Id": 0,
                     "IdMarca": 3,
                     "Imagen": null,
                     "ImagenBulk": "https://s3-sa-east-1.amazonaws.com/appcatalogo/PE/201910/C/productos/bulk/PE_200087598_B.jpg",
                     "ImagenProductoSugerido": null,
                     "NombreBulk": "Romantic Chic",
                     "NombreComercial": "Cy Twelve o'clock. Romantic Chic 10 g / .35 oz.",
                     "Orden": 1,
                     "PrecioCatalogo": 31.95,
                     "PrecioCatalogoString": null,
                     "DescripcionPlural": null,
                     "DescripcionSingular": null,
                     "Volumen": "10 g / .35 oz.",
                     "Cabecera": null,
                     "Secciones": [],
                     "Hermanos": [],
                     "TieneDetalleSeccion": false,
                     "TieneStock": true,
                     "EstrategiaGrupoId": 0,
                     "TieneFichaEnriquecidaActiva": false
                  },
                  {
                     "Cantidad": 1,
                     "CodigoProducto": null,
                     "Cuv": "31593",
                     "Descripcion": null,
                     "DescripcionComercial": null,
                     "DescripcionMarca": "Cyzone",
                     "Digitable": 1,
                     "FactorCuadre": 1,
                     "Grupo": "1",
                     "Id": 0,
                     "IdMarca": 3,
                     "Imagen": null,
                     "ImagenBulk": "https://s3-sa-east-1.amazonaws.com/appcatalogo/PE/201910/C/productos/bulk/PE_200093810_B.jpg",
                     "ImagenProductoSugerido": null,
                     "NombreBulk": "Nude energy",
                     "NombreComercial": "Cy Twelve o'clock. Nude Energy 10 g / .35 oz.",
                     "Orden": 2,
                     "PrecioCatalogo": 31.95,
                     "PrecioCatalogoString": null,
                     "DescripcionPlural": null,
                     "DescripcionSingular": null,
                     "Volumen": "10 g / .35 oz.",
                     "Cabecera": null,
                     "Secciones": [],
                     "Hermanos": [],
                     "TieneDetalleSeccion": false,
                     "TieneStock": true,
                     "EstrategiaGrupoId": 0,
                     "TieneFichaEnriquecidaActiva": false
                  },
               ],
               "TieneDetalleSeccion": true,
               "TieneStock": true,
               "EstrategiaGrupoId": 0,
               "TieneFichaEnriquecidaActiva": false,
               "esCampaniaSiguiente": false
            }
         ],
         "ImagenProductoMini": null,
         "ImagenURL": "",
         "IsAgregado": false,
         "ListaDescripcionDetalle": [],
         "ListaPrecioNiveles": [],
         "MarcaID": 3,
         "MensajeProductoBloqueado": {
            "divId": null,
            "MensajeIconoSuperior": true,
            "BtnInscribirse": false,
            "MensajeTitulo": "A partir de la próxima campaña podrás disfrutar de esta y más ofertas.",
            "IsMobile": false,
            "MensajeTieneDudas": true,
            "MensajePopupPrimero": null,
            "MensajePopupSegundo": null,
            "MensajeBtnPopup": null,
            "IdPopup": null,
            "UrlBtnPopup": null
         },
         "Posicion": 0,
         "Precio": 105.8,
         "Precio2": 63.9,
         "PrecioTachado": "105.80",
         "PrecioVenta": "63.90",
         "TextoLibre": "",
         "TienePaginaProducto": false,
         "TienePaginaProductoMob": false,
         "TipoAccionAgregar": 3,
         "TipoEstrategiaDetalle": {
            "FlagIndividual": false,
            "Slogan": null,
            "ImgHomeDesktop": null,
            "ImgFondoDesktop": null,
            "ImgFichaDesktop": null,
            "ImgFichaFondoDesktop": null,
            "UrlVideoDesktop": null,
            "ImgHomeMobile": null,
            "ImgFondoMobile": null,
            "ImgFichaMobile": null,
            "ImgFichaFondoMobile": null,
            "UrlVideoMobile": null
         },
         "TipoEstrategiaID": 3027,
         "TipoEstrategiaImagenMostrar": 6,
         "EsBannerProgNuevas": false,
         "CodigoPalanca": "",
         "TieneStock": true,
         "EsDuoPerfecto": false,
         "CantidadPack": 2,
         "esCampaniaSiguiente": false,
         "ClaseBloqueadaRangos": "contenedor_rangos_desactivado",
         "RangoInputEnabled": "disabled",
         "esEditable": false,
         "setId": 0,
         "TipoPersonalizacion": "030"
      };
   };

   beforeEach(function () {
      errorMsg = '';
      componentesView = sinon.stub(ComponentesView());
      componentesPresenter = ComponentesPresenter({
         componentesView: componentesView
      });
      //
      componentesView.renderComponente.returns(true);
      componentesView.showComponentTypesAndTones.returns(true);
      componentesView.showTypesAndTonesModal.returns(true);
      componentesView.setTitle.returns(true);
      componentesView.setSelectedQuantityText.returns(true);
      componentesView.showChooseIt.returns(true);
      componentesView.showChoosen.returns(true);
      componentesView.showQuantitySelector.returns(true);
      componentesView.showSelectedTypesOrTones.returns(true);
      componentesView.blockTypesOrTones.returns(true);
      componentesView.unblockTypesOrTones.returns(true);
      componentesView.unblockApplySelection.returns(true);
      componentesView.blockApplySelection.returns(true);
   });

   afterEach(function () {
      sinon.restore();
   });

   describe("Constructor", function () {
      it("throw an exception when config is undefined", function () {

         try {
            ComponentesPresenter(undefined);
         } catch (error) {
            errorMsg = error;
         }

         expect(errorMsg).to.have.string("config is null or undefined");
      });

      it("throw an exception when config is null", function () {

         try {
            ComponentesPresenter(null);
         } catch (error) {
            errorMsg = error;
         }

         expect(errorMsg).to.have.string("config is null or undefined");
      });

      it("throw an exception when config.componentesView is undefined", function () {

         try {
            ComponentesPresenter({
               componentesView: undefined
            });
         } catch (error) {
            errorMsg = error;
         }

         expect(errorMsg).to.have.string("config.componentesView is null or undefined");
      });

      it("throw an exception when config.componentesView is null", function () {

         try {
            ComponentesPresenter({
               componentesView: null
            });
         } catch (error) {
            errorMsg = error;
         }

         expect(errorMsg).to.have.string("config.componentesView is null or undefined");
      });
   });

   describe("onEstrategiaModelLoaded", function () {
      it("Show 'Elige 1 opción' when quantity of components is equals to 1", function () {
         // Arrange
         componentesPresenter.onEstrategiaModelLoaded(estrategiaUnComponenteFactorCuadreIgualAUno());

         //Act
         var selectComponentText = componentesPresenter.estrategiaModel().Hermanos[0].selectComponentText;

         // Assert
         expect(selectComponentText).to.have.string("Elige 1 opción");
      });

      it("Show 'Elige 2 opción' when quantity of components is equals to 2", function () {
         // Arrange
         componentesPresenter.onEstrategiaModelLoaded(estrategiaUnComponenteFactorCuadreIgualADos());

         //Act
         var selectComponentText = componentesPresenter.estrategiaModel().Hermanos[0].selectComponentText;

         // Assert
         expect(selectComponentText).to.have.string("Elige 2 opciones");
      });
   });

   describe("showTypesAndTonesModal", function () {
      beforeEach(function () {
         componentesPresenter.onEstrategiaModelLoaded(estrategiaUnComponenteFactorCuadreIgualADos());
      });

      it("throw an exception when component's cuv is null", function () {
         // Arrange
         var cuvComponent = null;

         //Act
         try {
            componentesPresenter.showTypesAndTonesModal(cuvComponent);
         } catch (error) {
            errorMsg = error;
         }

         // Assert
         expect(errorMsg).to.have.string("cuvComponente is null or undefined");
      });

      it("throw an exception when component's cuv is undefined", function () {
         // Arrange
         var cuvComponent = null;

         //Act
         try {
            componentesPresenter.showTypesAndTonesModal(cuvComponent);
         } catch (error) {
            errorMsg = error;
         }

         // Assert
         expect(errorMsg).to.have.string("cuvComponente is null or undefined");
      });

      it("throw an exception when component do not belong to strategy :P", function () {
         // Arrange
         var cuvComponent = "XXXXX";

         //Act
         try {
            componentesPresenter.showTypesAndTonesModal(cuvComponent);
         } catch (error) {
            errorMsg = error;
         }

         // Assert
         expect(errorMsg).to.have.string("estrategia no tiene componente seleccionado");
      });

      it("throw an exception when component do not belong to strategy -.-", function () {
         // Arrange
         var cuvComponent = "XXXXX";

         //Act
         try {
            componentesPresenter.showTypesAndTonesModal(cuvComponent);
         } catch (error) {
            errorMsg = error;
         }

         // Assert
         expect(errorMsg).to.have.string("estrategia no tiene componente seleccionado");
      });

      describe("when strategy has one component with FactorCuadre equals to one", function () {
         beforeEach(function () {
            componentesPresenter.onEstrategiaModelLoaded(estrategiaUnComponenteFactorCuadreIgualAUno());
         });

         it("return false when componentesView do not set title", function () {
            // Arrange
            var cuvComponent = "31305";
            componentesView.setTitle.returns(false);

            //Act
            var result = componentesPresenter.showTypesAndTonesModal(cuvComponent);


            // Assert
            expect(result).to.eql(false);
         });

         it("Show 'Elige 1 opción' when quantity of selected items is equals to 0", function () {
            // Arrange
            var cuvComponent = "31305";

            //Act
            var result = componentesPresenter.showTypesAndTonesModal(cuvComponent);
            var selectedTitle = componentesPresenter.estrategiaModel().Hermanos[0].selectComponentTitle;

            // Assert
            expect(result).to.eql(true);
            expect(selectedTitle).to.have.string("Elige 1 opción");
         });

         it("return false when componentesView do not set selected quantity's text", function () {
            // Arrange
            var cuvComponent = "31305";
            componentesView.setSelectedQuantityText.returns(false);

            //Act
            var result = componentesPresenter.showTypesAndTonesModal(cuvComponent);


            // Assert
            expect(result).to.eql(false);
         });


         it("Show '0 seleccionados' when quantity of selected items is equals to 0", function () {
            // Arrange
            var cuvComponent = "31305";

            //Act
            var result = componentesPresenter.showTypesAndTonesModal(cuvComponent);
            var selectedQuantityText = componentesPresenter.estrategiaModel().Hermanos[0].selectedQuantityText;

            // Assert
            expect(result).to.eql(true);
            expect(selectedQuantityText).to.have.string("0 Seleccionados");
         });

         it("return false when componentesView do not render component's tones/types", function () {
            // //Arrange
            var cuvComponent = "31305";
            componentesView.showComponentTypesAndTones.returns(false);

            // //Act
            var result = componentesPresenter.showTypesAndTonesModal(cuvComponent);

            //Assert
            expect(result).to.be.eql(false);
         });

         it("return true when component's tones/types are shown", function () {
            // //Arrange
            var cuvComponent = "31305";

            // //Act
            var result = componentesPresenter.showTypesAndTonesModal(cuvComponent);

            //Assert
            expect(result).to.be.eql(true);
         });
      });

      describe("when strategy has one component with FactorCuadre equals to two", function () {
         beforeEach(function () {
            componentesPresenter.onEstrategiaModelLoaded(estrategiaUnComponenteFactorCuadreIgualADos());
         });

         it("Show 'Elige 2 opciones' when quantity of components is equals to 2", function () {
            // Arrange
            var cuvComponent = "31305";

            //Act
            var result = componentesPresenter.showTypesAndTonesModal(cuvComponent);
            var selectedTitle = componentesPresenter.estrategiaModel().Hermanos[0].selectComponentTitle;

            // Assert
            expect(result).to.eql(true);
            expect(selectedTitle).to.have.string("Elige 2 opciones");
         });
      });
   });

   describe("addTypeOrTone", function () {
      it("throw exception when grupo is undefined", function () {
         // Arrange
         var grupo;

         //Act
         try {
            componentesPresenter.addTypeOrTone(grupo, null);
         } catch (error) {
            errorMsg = error;
         }

         // Assert
         expect(errorMsg).to.have.string("grupo is null or undefined");
      });

      it("throw exception when grupo is null", function () {
         // Arrange
         var grupo = null;

         //Act
         try {
            componentesPresenter.addTypeOrTone(grupo, null);
         } catch (error) {
            errorMsg = error;
         }

         // Assert
         expect(errorMsg).to.have.string("grupo is null or undefined");
      });

      it("throw exception when cuv is undefined", function () {
         // Arrange
         var grupo = "1";
         var cuv;

         //Act
         try {
            componentesPresenter.addTypeOrTone(grupo, cuv);
         } catch (error) {
            errorMsg = error;
         }

         // Assert
         expect(errorMsg).to.have.string("cuv is null or undefined");
      });

      it("throw exception when cuv is null", function () {
         // Arrange
         var grupo = "1";
         var cuv = null;

         //Act
         try {
            componentesPresenter.addTypeOrTone(grupo, cuv);
         } catch (error) {
            errorMsg = error;
         }

         // Assert
         expect(errorMsg).to.have.string("cuv is null or undefined");
      });

      describe("Given a component with FactorCuadre equals to 1", function () {
         beforeEach(function () {
            componentesPresenter.onEstrategiaModelLoaded(estrategiaUnComponenteFactorCuadreIgualAUno());
         });

         describe("and a type/tone is selected", function () {
            var grupo = "1";
            var cuv = "31593";

            it("should update selected quantity", function () {
               // Arrange
               componentesPresenter.addTypeOrTone(grupo, cuv);

               // Act
               var result = componentesPresenter.estrategiaModel().Hermanos[0].cantidadSeleccionados;

               // Assert
               expect(result).to.be.equal(1);
            });

            it("should return false when componentesView do not show 'Elegido' ", function () {
               // Arrange
               componentesView.showChoosen.returns(false);

               // Act
               var result = componentesPresenter.addTypeOrTone(grupo, cuv);

               // Assert
               expect(result).to.be.equal(false);
            });

            it("should return false when componentesView do not show selected types/tones", function () {
               // Arrange
               componentesView.showSelectedTypesOrTones.returns(false);

               // Act
               var result = componentesPresenter.addTypeOrTone(grupo, cuv);

               // Assert
               expect(result).to.be.eql(false);
            });

            it("should return false when componentesView do not update title", function () {
               // Arrange
               componentesView.setTitle.returns(false);

               // Act
               var result = componentesPresenter.addTypeOrTone(grupo, cuv);

               // Assert
               expect(result).to.be.eql(false);
            });

            it("should update title to 'Listo ya tienes tu opción' ", function () {
               // Arrange
               componentesPresenter.addTypeOrTone(grupo, cuv);

               // Act
               var result = componentesPresenter.estrategiaModel().Hermanos[0].selectComponentTitle;

               // Assert
               expect(result).to.be.eql("<h3>¡Listo! <span>ya tienes tu</span> opción</h3>");
            });

            it("should update selected quantity to '1 Seleccionado' ", function () {
               // Arrange
               componentesPresenter.addTypeOrTone(grupo, cuv);

               // Act
               var result = componentesPresenter.estrategiaModel().Hermanos[0].selectedQuantityText;

               // Assert
               expect(result).to.be.eql("1 Seleccionado");
            });

            it("should return false when componentesView do not activate 'Aplicar Selección'", function(){
               // Arrange
               componentesView.unblockApplySelection.returns(false);

               // Act
               var result = componentesPresenter.addTypeOrTone(grupo, cuv);

               // Assert
               expect(result).to.be.eql(false);
            });
         });
      });

      describe("Given a component with FactorCuadre equals to 2", function () {
         beforeEach(function () {
            componentesPresenter.onEstrategiaModelLoaded(estrategiaUnComponenteFactorCuadreIgualADos());
         });

         describe("and a type/tone is selected", function () {
            var grupo = "1";
            var cuv = "31593";

            beforeEach(function () {
               componentesPresenter.onEstrategiaModelLoaded(estrategiaUnComponenteFactorCuadreIgualADos());
            });

            it("should update selected quantity", function () {
               // Arrange
               componentesPresenter.addTypeOrTone(grupo, cuv);

               // Act
               var result = componentesPresenter.estrategiaModel().Hermanos[0].cantidadSeleccionados;

               // Assert
               expect(result).to.be.equal(1);
            });

            it("should return false when componentesView do not show quantity selector", function () {
               // Arrange
               componentesView.showQuantitySelector.returns(false);

               // Act
               var result = componentesPresenter.addTypeOrTone(grupo, cuv);

               // Assert
               expect(result).to.be.equal(false);
            });

            it("should return false when componentesView do not show selected types/tones", function () {
               // Arrange
               componentesView.showSelectedTypesOrTones.returns(false);

               // Act
               var result = componentesPresenter.addTypeOrTone(grupo, cuv);

               // Assert
               expect(result).to.be.eql(false);
            });

            it("should return false when componentesView do not update title", function () {
               // Arrange
               componentesView.setTitle.returns(false);

               // Act
               var result = componentesPresenter.addTypeOrTone(grupo, cuv);

               // Assert
               expect(result).to.be.eql(false);
            });

            it("should update title to 'TE FALTA 1 OPCIÓN' ", function () {
               // Arrange
               componentesPresenter.addTypeOrTone(grupo, cuv);

               // Act
               var result = componentesPresenter.estrategiaModel().Hermanos[0].selectComponentTitle;

               // Assert
               expect(result).to.be.eql("Te falta 1 opción");
            });

            it("should update selected quantity to '1 Seleccionado' ", function () {
               // Arrange
               componentesPresenter.addTypeOrTone(grupo, cuv);

               // Act
               var result = componentesPresenter.estrategiaModel().Hermanos[0].selectedQuantityText;

               // Assert
               expect(result).to.be.eql("1 Seleccionado");
            });

            it("should return false when componentesView do not disable 'Aplicar Selección'", function(){
               // Arrange
               componentesView.blockApplySelection.returns(false);

               // Act
               var result = componentesPresenter.addTypeOrTone(grupo, cuv);

               // Assert
               expect(result).to.be.eql(false);
            });
         });

         describe("and two type/tone are selected", function () {
            var grupo = "1";
            var cuv = "31593";

            beforeEach(function () {
               componentesPresenter.onEstrategiaModelLoaded(estrategiaUnComponenteFactorCuadreIgualADos());
               componentesPresenter.addTypeOrTone(grupo, cuv);
            });

            afterEach(function () {
               //sinon.restore();
            });

            it("should update selected quantity", function () {
               // Arrange
               componentesPresenter.addTypeOrTone(grupo, cuv);

               // Act
               var result = componentesPresenter.estrategiaModel().Hermanos[0].cantidadSeleccionados;

               // Assert
               expect(result).to.be.equal(2);
            });

            it("should return false when componentesView do not show quantity selector", function () {
               // Arrange
               componentesView.showQuantitySelector.returns(false);

               // Act
               var result = componentesPresenter.addTypeOrTone(grupo, cuv);

               // Assert
               expect(result).to.be.equal(false);
            });

            it("should return false when componentesView do not show selected types/tones", function () {
               // Arrange
               componentesView.showSelectedTypesOrTones.returns(false);

               // Act
               var result = componentesPresenter.addTypeOrTone(grupo, cuv);

               // Assert
               expect(result).to.be.eql(false);
            });

            it("should return false when componentesView do not update title", function () {
               // Arrange
               componentesView.setTitle.returns(false);

               // Act
               var result = componentesPresenter.addTypeOrTone(grupo, cuv);

               // Assert
               expect(result).to.be.eql(false);
            });

            it("should update title to 'Listo ya tienes tus 2 opciones' ", function () {
               // Arrange
               componentesPresenter.addTypeOrTone(grupo, cuv);

               // Act
               var result = componentesPresenter.estrategiaModel().Hermanos[0].selectComponentTitle;

               // Assert
               expect(result).to.be.eql("<h3>¡Listo! <span>ya tienes tus</span> 2 opciones</h3>");
            });

            it("should update selected quantity to '2 Seleccionado' ", function () {
               // Arrange
               componentesPresenter.addTypeOrTone(grupo, cuv);

               // Act
               var result = componentesPresenter.estrategiaModel().Hermanos[0].selectedQuantityText;

               // Assert
               expect(result).to.be.eql("2 Seleccionados");
            });

            it("should return false when componentesView do not disable types/tones", function () {
               // Arrange
               componentesPresenter.addTypeOrTone(grupo, cuv);

               // Act
               var result = componentesPresenter.estrategiaModel().Hermanos[0].selectedQuantityText;

               // Assert
               expect(result).to.be.eql("2 Seleccionados");
            });

            it("should return false when componentesView do not activate 'Aplicar Selección'", function(){
               // Arrange
               componentesView.unblockApplySelection.returns(false);

               // Act
               var result = componentesPresenter.addTypeOrTone(grupo, cuv);

               // Assert
               expect(result).to.be.eql(false);
            });

            it("should not increase selected quantity when adds more types/tones", function () {
               // Arrange
               componentesPresenter.addTypeOrTone(grupo, cuv);
               componentesPresenter.addTypeOrTone(grupo, cuv);
               componentesPresenter.addTypeOrTone(grupo, cuv);

               // Act
               var result = componentesPresenter.estrategiaModel().Hermanos[0].cantidadSeleccionados;

               // Assert
               expect(result).to.be.equal(2);
            });
         });
      });
   });

   describe("removeTypeOrTone", function () {
      it("throw exception when grupo is undefined", function () {
         // Arrange
         var grupo;

         //Act
         try {
            componentesPresenter.removeTypeOrTone(grupo, null);
         } catch (error) {
            errorMsg = error;
         }
         // Assert
         expect(errorMsg).to.have.string("grupo is null or undefined");
      });

      it("throw exception when grupo is null", function () {
         // Arrange
         var grupo = null;

         //Act
         try {
            componentesPresenter.removeTypeOrTone(grupo, null);
         } catch (error) {
            errorMsg = error;
         }

         // Assert
         expect(errorMsg).to.have.string("grupo is null or undefined");
      });

      it("throw exception when cuv is undefined", function () {
         // Arrange
         var grupo = "1";
         var cuv;

         //Act
         try {
            componentesPresenter.removeTypeOrTone(grupo, cuv);
         } catch (error) {
            errorMsg = error;
         }

         // Assert
         expect(errorMsg).to.have.string("cuv is null or undefined");
      });

      it("throw exception when cuv is null", function () {
         // Arrange
         var grupo = "1";
         var cuv = null;

         //Act
         try {
            componentesPresenter.removeTypeOrTone(grupo, cuv);
         } catch (error) {
            errorMsg = error;
         }

         // Assert
         expect(errorMsg).to.have.string("cuv is null or undefined");
      });

      describe("Given a component with FactorCuadre equals to 1", function () {

         beforeEach(function () {
            componentesPresenter.onEstrategiaModelLoaded(estrategiaUnComponenteFactorCuadreIgualAUno());
         });

         describe("and a type/tone is added", function () {

            var grupo = "1";
            var cuv = "31593";

            beforeEach(function () {
               componentesPresenter.addTypeOrTone(grupo, cuv);
            });

            describe("When one type/tone is removed", function () {
               beforeEach(function () {
               });

               it("should update selected quantity", function () {
                  // Arrange
                  componentesPresenter.removeTypeOrTone(grupo, cuv);
   
                  // Act
                  var result = componentesPresenter.estrategiaModel().Hermanos[0].cantidadSeleccionados;
   
                  // Assert
                  expect(result).to.be.equal(0);
               });

               it("should return false when componentesView do not show 'Eligelo'", function () {
                  // Arrange
                  componentesView.showChooseIt.returns(false);
   
                  // Act
                  var result = componentesPresenter.removeTypeOrTone(grupo, cuv);
   
                  // Assert
                  expect(result).to.be.equal(false);
               });

               it("should return false when componentesView do not render selected types/tones", function () {
                  // Arrange
                  componentesView.showSelectedTypesOrTones.returns(false);
   
                  // Act
                  var result = componentesPresenter.removeTypeOrTone(grupo, cuv);
   
                  // Assert
                  expect(result).to.be.eql(false);
               });

               it("should return false when componentesView do not render update title", function () {
                  // Arrange
                  componentesView.setTitle.returns(false);
   
                  // Act
                  var result = componentesPresenter.removeTypeOrTone(grupo, cuv);
   
                  // Assert
                  expect(result).to.be.eql(false);
               });

               it("should update title to 'Elige 1 OPCIÓN' ", function () {
                  // Arrange
                  componentesPresenter.removeTypeOrTone(grupo, cuv);
   
                  // Act
                  var result = componentesPresenter.estrategiaModel().Hermanos[0].selectComponentTitle;
   
                  // Assert
                  expect(result).to.be.eql("Elige 1 opción");
               });
   
               it("should update selected quantity to '0 Seleccionados' ", function () {
                  // Arrange
                  componentesPresenter.removeTypeOrTone(grupo, cuv);
   
                  // Act
                  var result = componentesPresenter.estrategiaModel().Hermanos[0].selectedQuantityText;
   
                  // Assert
                  expect(result).to.be.eql("0 Seleccionados");
               });

               it("should return false when componentesView do not enable types/tones", function () {
                  // Arrange
                  componentesView.unblockTypesOrTones.returns(false);
   
                  // Act
                  var result = componentesPresenter.removeTypeOrTone(grupo, cuv);
   
                  // Assert
                  expect(result).to.be.eql(false);
               });

               it("should return false when componentesView do not disable 'Aplicar Selección'", function(){
                  // Arrange
                  componentesView.blockApplySelection.returns(false);
   
                  // Act
                  var result = componentesPresenter.addTypeOrTone(grupo, cuv);
   
                  // Assert
                  expect(result).to.be.eql(false);
               });
            });
         });
      });

      describe("Given a component with FactorCuadre equals to 2", function () {

         beforeEach(function () {
            componentesPresenter.onEstrategiaModelLoaded(estrategiaUnComponenteFactorCuadreIgualADos());
         });

         describe("and two types/tones are added", function () {

            var grupo = "1";
            var cuv = "31593";

            beforeEach(function () {
               componentesPresenter.addTypeOrTone(grupo, cuv);
               componentesPresenter.addTypeOrTone(grupo, cuv);
            });

            describe("When one type/tone is removed", function () {
               beforeEach(function () {
               });

               it("should update selected quantity", function () {
                  // Arrange
                  componentesPresenter.removeTypeOrTone(grupo, cuv);
   
                  // Act
                  var result = componentesPresenter.estrategiaModel().Hermanos[0].cantidadSeleccionados;
   
                  // Assert
                  expect(result).to.be.equal(1);
               });

               it("should return false when componentesView do not render quantity selector", function () {
                  // Arrange
                  componentesView.showQuantitySelector.returns(false);
   
                  // Act
                  var result = componentesPresenter.removeTypeOrTone(grupo, cuv);
   
                  // Assert
                  expect(result).to.be.equal(false);
               });
   
               it("should return false when componentesView do not render selected types/tones", function () {
                  // Arrange
                  componentesView.showSelectedTypesOrTones.returns(false);
   
                  // Act
                  var result = componentesPresenter.removeTypeOrTone(grupo, cuv);
   
                  // Assert
                  expect(result).to.be.eql(false);
               });
   
               it("should return false when componentesView do not render update title", function () {
                  // Arrange
                  componentesView.setTitle.returns(false);
   
                  // Act
                  var result = componentesPresenter.removeTypeOrTone(grupo, cuv);
   
                  // Assert
                  expect(result).to.be.eql(false);
               });

               it("should update title to 'TE FALTA 1 OPCIÓN' ", function () {
                  // Arrange
                  componentesPresenter.removeTypeOrTone(grupo, cuv);
   
                  // Act
                  var result = componentesPresenter.estrategiaModel().Hermanos[0].selectComponentTitle;
   
                  // Assert
                  expect(result).to.be.eql("Te falta 1 opción");
               });
   
               it("should update selected quantity to '1 Seleccionado' ", function () {
                  // Arrange
                  componentesPresenter.removeTypeOrTone(grupo, cuv);
   
                  // Act
                  var result = componentesPresenter.estrategiaModel().Hermanos[0].selectedQuantityText;
   
                  // Assert
                  expect(result).to.be.eql("1 Seleccionado");
               });

               it("should return false when componentesView do not enable types/tones", function () {
                  // Arrange
                  componentesView.unblockTypesOrTones.returns(false);
   
                  // Act
                  var result = componentesPresenter.removeTypeOrTone(grupo, cuv);
   
                  // Assert
                  expect(result).to.be.eql(false);
               });
            });

            describe("When two type/tone are removed", function () {
               beforeEach(function () {
               });

               it("should update selected quantity", function () {
                  // Arrange
                  componentesPresenter.removeTypeOrTone(grupo, cuv);
                  componentesPresenter.removeTypeOrTone(grupo, cuv);
   
                  // Act
                  var result = componentesPresenter.estrategiaModel().Hermanos[0].cantidadSeleccionados;
   
                  // Assert
                  expect(result).to.be.equal(0);
               });

               it("should return false when componentesView do not render 'Eligelo' ", function () {
                  // Arrange
                  componentesView.showChooseIt.returns(false);
                  componentesPresenter.removeTypeOrTone(grupo, cuv);
   
                  // Act
                  var result = componentesPresenter.removeTypeOrTone(grupo, cuv);
   
                  // Assert
                  expect(result).to.be.equal(false);
               });

               it("should update title to 'TE FALTA 2 OPCIÓN' ", function () {
                  // Arrange
                  componentesPresenter.removeTypeOrTone(grupo, cuv);
                  componentesPresenter.removeTypeOrTone(grupo, cuv);
   
                  // Act
                  var result = componentesPresenter.estrategiaModel().Hermanos[0].selectComponentTitle;
   
                  // Assert
                  expect(result).to.be.eql("Elige 2 opciones");
               });

               it("should update selected quantity to '0 Seleccionado' ", function () {
                  // Arrange
                  componentesPresenter.removeTypeOrTone(grupo, cuv);
                  componentesPresenter.removeTypeOrTone(grupo, cuv);
   
                  // Act
                  var result = componentesPresenter.estrategiaModel().Hermanos[0].selectedQuantityText;
   
                  // Assert
                  expect(result).to.be.eql("0 Seleccionados");
               });

            });

         });
      });
   });

   describe("applySelected",function(){

      it("throw exception when grupo is undefined", function () {
         // Arrange
         var grupo;

         //Act
         try {
            componentesPresenter.removeTypeOrTone(grupo, null);
         } catch (error) {
            errorMsg = error;
         }

         // Assert
         expect(errorMsg).to.have.string("grupo is null or undefined");
      });
   });
});