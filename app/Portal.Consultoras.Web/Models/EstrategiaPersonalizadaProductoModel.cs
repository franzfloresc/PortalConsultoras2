﻿using System;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    [Serializable]
    public class EstrategiaPersonalizadaProductoModel
    {
        public EstrategiaPersonalizadaProductoModel()
        {
            TipoEstrategiaDetalle = new EstrategiaDetalleModelo();
            ArrayContenidoSet = new List<string>();
            ListaDescripcionDetalle = new List<string>();
            Hermanos = new List<EstrategiaComponenteModel>();
            ListaPrecioNiveles = new List<string>();
            Condiciones = new List<EstrategiaPersonalizadaProductoModel>();
        }

        // Mejorar para solo utilizar un solo array de string
        public List<string> ArrayContenidoSet { get; set; }

        public int CampaniaID { get; set; }
        public string ClaseBloqueada { get; set; }
        public string ClaseEstrategia { get; set; }
        public string CodigoCategoria { get; set; }
        public string CodigoEstrategia { get; set; }
        public string CodigoProducto { get; set; }
        public string CodigoVariante { get; set; }
        public string CUV2 { get; set; }
        public string DescripcionCompleta { get; set; }
        public string DescripcionCortada { get; set; }
        // Es la descripcion extendida solo con 40 caracteres
        public string DescripcionDetalle { get; set; }

        public string DescripcionMarca { get; set; }
        public string DescripcionResumen { get; set; }
        public string DescripcionCategoria { get; set; }
        public bool EsMultimarca { get; set; }
        public bool EsOfertaIndependiente { get; set; }
        public bool EsSubcampania { get; set; }
        public int EstrategiaID { get; set; }
        public int FlagNueva { get; set; }
        public string FotoProducto01 { get; set; }
        public decimal Ganancia { get; set; }
        public string GananciaString { get; set; }
        public List<EstrategiaComponenteModel> Hermanos { get; set; }

        // se usa para filtrar los productos por categoria en ShowRoom
        public string ImagenProductoMini { get; set; }
        /// <summary>
        /// ImagenURL se usa para mostrar la imagen de fondo en los banner de los carrusel, Tabla: ConfiguracionPaisDatos
        /// </summary>
        public string ImagenURL { get; set; }
        public bool IsAgregado { get; set; }
        public List<string> ListaDescripcionDetalle { get; set; }
        public List<string> ListaPrecioNiveles { get; set; }

        public int MarcaID { get; set; }
        public MensajeProductoBloqueadoModel MensajeProductoBloqueado { get; set; }
        public int Posicion { get; set; }
        // se usa para el logo
        // Puede ser el nombre de un set, o la descripcion simple
        // Es la descripcion extendida, ya no se utiliza, revisar 
        public decimal Precio { get; set; }

        public decimal Precio2 { get; set; }
        public string PrecioTachado { get; set; }
        public string PrecioVenta { get; set; }
        public string TextoLibre { get; set; }
        public bool TienePaginaProducto { get; set; }
        public bool TienePaginaProductoMob { get; set; }
        /// <summary>
        /// 1: AGRÉGALO - No alterar cantidad, caso pack nuevas
        /// 2: AGRÉGALO - Si puede alterar cantidad
        /// 3: ELIGE TU OPCIÓN
        /// 4: ¿LO QUIERES?
        /// 5: ¿LO QUIERES? Inactivo
        /// 11: Banner Carrusel (MG, OPT, SR)
        /// </summary>
        public int TipoAccionAgregar { get; set; }

        public EstrategiaDetalleModelo TipoEstrategiaDetalle { get; set; }
        // es para los diferentes botones que sale en la seccion de agrega, elegir tono, ...
        public int TipoEstrategiaID { get; set; }
        
        public bool EsBannerProgNuevas { get; set; } // Se usa para mostrar carrusel en el carrusel de Ofertas
        public string CodigoPalanca { get; set; } // codigo donde se van a mostrar los productos

        public bool TieneStock { get; set; } //flag para controlar si el producto cuenta con stock
        public bool EsDuoPerfecto { get; set; }

        /// <summary>
        /// Calculo del factor cuadre
        /// </summary>
        public int CantidadPack { get; set; }

        // para elastic, devuelve un bool
        // true = MaterialGanancia == 1
        public bool MaterialGanancia { get; set; }

        /// <summary>
        /// Tipo Oferta Camino Brillante
        /// </summary>
        public int TipoOfertaCaminoBrillante { get; set; }

        public string CuvPromocion { get; set; }

        public bool EsPromocion { get; set; }

        public EstrategiaPersonalizadaProductoModel Promocion { get; set; }

        public List<EstrategiaPersonalizadaProductoModel> Condiciones { get; set; }
    }
}