using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    public class OfertaFlexipagoModel
    {
        public int OfertaProductoID { get; set; }
        public int CampaniaID { get; set; }
        public int PaisID { get; set; }
        public string LinksFlexipago { get; set; }
        public string UsuarioRegistro { get; set; }
        public string CUV { get; set; }
        public string Descripcion { get; set; }
        public decimal PrecioOferta { get; set; }
        public decimal PrecioNormal { get; set; }
        public int Stock { get; set; }
        public string ImagenProducto { get; set; }
        public string ImagenProductoAnterior { get; set; }
        public int Orden { get; set; }
        public int UnidadesPermitidas { get; set; }
        public string CodigoCampania { get; set; }
        public int FlagHabilitarProducto { get; set; }
        public int ConfiguracionOfertaID { get; set; }
        public int TipoOfertaSisID { get; set; }
        public int MarcaID { get; set; }
        public string DescripcionLegal { get; set; }
        public string CodigoSAP { get; set; }
        public string CategoriaID { get; set; }
        public string DescripcionMarca { get; set; }

        public decimal MontoTotal { get; set; }
        public decimal MontoPagado { get; set; }
        public decimal MontoPorCuota { get; set; }
        public decimal InteresePorCuota { get; set; }
        public decimal CuotaPendCampaniaActual { get; set; }
        public decimal CuotaPendCampaniaSiguiente { get; set; }
        public string Simbolo { get; set; }
        public decimal PedidoBase { get; set; }
        public decimal LineaCredito { get; set; }
        public decimal MontoMinimoFlexipago { get; set; }

        public string CodigoTipoOferta { get; set; }
        public IEnumerable<ConfiguracionOfertaModel> lstConfiguracionOferta { get; set; }
        public IEnumerable<PaisModel> lstPais { get; set; }
        public IEnumerable<CampaniaModel> lstCampania { get; set; }
    }
}