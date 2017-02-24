using Portal.Consultoras.Web.ServicePedido;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
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
        public int FlagNueva { get; set; }
        public int TipoEstrategiaImagenMostrar { get; set; }
        public bool TieneStockProl { get; set; }
        public int FlagMostrarImg { get; set; }
        public bool IsAgregado { get; set; }

        public string UrlCompartirFB { get; set; }
        public string CodigoEstrategia { get; set; }
        public List<BEEstrategiaProducto> EstrategiaProductos { get; set; }
    }
}