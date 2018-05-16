using Portal.Consultoras.Web.ServicePedido;
using System;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    [Serializable]
    public class EstrategiaPedidoModel
    {
        public int MarcaID { get; set; }
        public string ConsultoraID { get; set; }
        public int EstrategiaID { get; set; }
        public int PaisID { get; set; }
        public int CampaniaID { get; set; }
        public int CampaniaIDFin { get; set; }
        public int NumeroPedido { get; set; }
        public int TipoEstrategiaID { get; set; }
        public int Orden { get; set; }
        public int ID { get; set; }
        public decimal Precio { get; set; }
        public decimal Precio2 { get; set; }
        public decimal PrecioUnitario { get; set; }
        public string PrecioString { get; set; }
        public string PrecioTachado { get; set; }
        public string CUV1 { get; set; }
        public string CUV2 { get; set; }
        public string DescripcionCUV2 { get; set; }
        public string DescripcionResumen { get; set; } // Puede ser el nombre de un set, o la descripcion simple
        public string DescripcionDetalle { get; set; } // Es la descripcion extendida 
        public string DescripcionCortada { get; set; } // Es la descripcion extendida solo con 40 caracteres
        public int Activo { get; set; }
        public int LimiteVenta { get; set; }
        public string CodigoProducto { get; set; }
        public string ImagenURL { get; set; }
        public string FotoProducto01 { get; set; }
        public string FotoProducto02 { get; set; }
        public string FotoProducto03 { get; set; }
        public int EtiquetaID { get; set; }
        public int EtiquetaID2 { get; set; }
        public string EtiquetaDescripcion { get; set; }
        public string EtiquetaDescripcion2 { get; set; }
        public string TextoLibre { get; set; }
        public int Cantidad { get; set; }
        public string Zona { get; set; }
        public string UsuarioCreacion { get; set; }
        public string UsuarioModificacion { get; set; }
        public int FlagDescripcion { get; set; }
        public int FlagCEP { get; set; }
        public int FlagCEP2 { get; set; }
        public int FlagTextoLibre { get; set; }
        public int FlagCantidad { get; set; }
        public string ColorFondo { get; set; }
        public int FlagEstrella { get; set; }
        public string Simbolo { get; set; }
        public string TallaColor { get; set; }
        public string TipoTallaColor { get; set; }
        public int IndicadorMontoMinimo { get; set; }
        public int TipoOferta { get; set; }
        public string Mensaje { get; set; }
        public string DescripcionMarca { get; set; }
        public string DescripcionCategoria { get; set; }
        public string DescripcionEstrategia { get; set; }
        public string Descripcion { get; set; }
        public int FlagNueva { get; set; }
        public int TipoEstrategiaImagenMostrar { get; set; }
        public bool TieneStockProl { get; set; }
        public int FlagMostrarImg { get; set; }
        public bool IsAgregado { get; set; }
        public int TieneVariedad { get; set; }
        public int PuedeCambiarCantidad { get; set; }
        public int PuedeAgregar { get; set; }
        public int IsMobile { get; set; }
        
        public string CodigoEstrategia { get; set; }
        public List<BEEstrategiaProducto> EstrategiaProductos { get; set; }
        public List<ProductoModel> Hermanos { get; set; }
        public List<string> ListaDescripcionDetalle { get; set; }

        public int Origen { get; set; }
        public string OrigenUrl { get; set; }
        public string Codigo { get; set; }

        public bool PuedeVerDetalle { get; set; }
        public bool PuedeVerDetalleMob { get; set; }
        public string ClaseBloqueada { get; set; }
        public string UrlDetalle { get; set; }

        public EstrategiaDetalleModelo EstrategiaDetalle { get; set; }
        public TipoEstrategiaModelo TipoEstrategia { get; set; }

        public decimal Ganancia { get; set; }

        public string CodigoGenerico { get; set; }
        public int ProdComentarioId { get; set; }
        public int CantComenAprob { get; set; }
        public int CantComenRecom { get; set; }
        public int PromValorizado { get; set; }
        public EstrategiaProductoComentarioModel UltimoComentario { get; set; }
        public int Posicion { get; set; }
        public string GananciaString { get; set; }
        public bool EsOfertaIndependiente { get; set; }
        public string ImagenOfertaIndependiente { get; set; }
        public bool MostrarImgOfertaIndependiente { get; set; }
        public string Niveles { get; set; }

        public int FlagRevista { get; set; }
    }
}
