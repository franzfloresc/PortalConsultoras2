using System;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    [Serializable]
    public class FichaProductoDetalleModel
    {
        public FichaProductoDetalleModel()
        {
            ArrayContenidoSet = new List<string>();
        }

        public int CampaniaID { get; set; }
        public string CUV2 { get; set; }
        public int TipoImagenMostrar { get; set; } // puede controlarse con el codigo de tipo estrategia
        public string ClaseEstrategia { get; set; }
        public int Posicion { get; set; }
        public bool TieneVerDetalle { get; set; }
        public bool TienePaginaProducto { get; set; }
        public bool TienePaginaProductoMob { get; set; }
        public string FotoProducto01 { get; set; }
        public string ImagenURL { get; set; }
        public string DescripcionMarca { get; set; }
        public string DescripcionResumen { get; set; } // Puede ser el nombre de un set, o la descripcion simple
        public string DescripcionCortada { get; set; } // Es la descripcion extendida solo con 40 caracteres
        public string DescripcionDetalle { get; set; } // Es la descripcion extendida 
        public string DescripcionCompleta { get; set; }
        public string Simbolo { get; set; }
        public decimal Precio { get; set; }
        public decimal Precio2 { get; set; }
        public string PrecioTachado { get; set; }
        public string PrecioVenta { get; set; } // cambiar por PrecioVenta
        public int TipoAccionAgregar { get; set; } // es para los diferentes botones que sale en la seccion de agrega, elegir tono, ...
        public string ClaseBloqueada { get; set; }
        public bool ProductoPerdio { get; set; }
        public int FlagNueva { get; set; }
        public bool IsAgregado { get; set; }
        public string CodigoTipoOferta { get; set; }
        public string CodigoVariante { get; set; }        
        public List<string> ArrayContenidoSet { get; set; }
        public List<string> ListaDescripcionDetalle { get; set; }
        public string TextoLibre { get; set; }
        public int IndicadorMontoMinimo { get; set; }

        public int MarcaID { get; set; }
        public string UrlCompartir { get; set; }

        public List<ProductoModel> Hermanos { get; set; }
    }
}