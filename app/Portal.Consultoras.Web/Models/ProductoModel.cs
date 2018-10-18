using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models
{
    [Serializable]
    public class ProductoModel : CompartirRedesSocialesModel
    {
        public int Cantidad { get; set; }
        public string CodigoCategoria { get; set; }
        public string CodigoIso { get; set; }
        public string CodigoMarca { get; set; }
        public string CodigoProducto { get; set; }
        public int ConfiguracionOfertaID { get; set; }
        public string CUV { get; set; }
        public string CUVComplemento { get; set; }
        public string CUVPedido { get; set; }
        public string CUVPedidoImagen { get; set; }
        public string CUVPedidoNombre { get; set; }
        public string CUVRevista { get; set; }
        public int? DesactivaRevistaGana { get; set; }
        public string Descripcion { get; set; }
        public string DescripcionCategoria { get; set; }
        public string DescripcionComercial { get; set; }
        public string DescripcionEstrategia { get; set; }
        public string DescripcionMarca { get; set; }
        public int Digitable { get; set; }
        public bool EsExpoOferta { get; set; }
        public bool EsMaquillaje { get; set; }
        public bool EsOfertaIndependiente { get; set; }
        public bool EstaEnRevista { get; set; }
        public int FactorCuadre { get; set; }
        public string FlagNueva { get; set; }
        public string Grupo { get; set; }
        public List<ProductoModel> Hermanos { get; set; }
        public int ID { get; set; }
        public string Imagen { get; set; }
        public string ImagenBulk { get; set; }
        public string ImagenProductoSugerido { get; set; }
        public string ImagenProductoSugeridoMedium { get; set; }
        public string ImagenProductoSugeridoSmall { get; set; }
        public string IndicadorMontoMinimo { get; set; }
        public bool IsAgregado { get; set; }
        public int LimiteVenta { get; set; }
        public int MarcaID { get; set; }
        public string MensajeCUV { get; set; }
        public string MetaMontoStr { get; set; }
        public string MontoMeta { get; set; }
        public string NombreBulk { get; set; }
        public string NombreComercial { get; set; }
        public string NombreComercialCorto { get; set; }
        public string ObservacionCUV { get; set; }
        public int Orden { get; set; }
        public bool PaisEsikizado { get; set; }
        public decimal PrecioCatalogo { get; set; }
        public string PrecioCatalogoString { get; set; }
        public decimal PrecioValorizado { get; set; }
        public string PrecioValorizadoString { get; set; }
        public int Relevancia { get; set; }
        public string Sello { get; set; }
        public string Simbolo { get; set; }
        public bool TieneLanzamientoCatalogoPersonalizado { get; set; }
        public bool TieneOfertaEnRevista { get; set; }
        public bool TieneRDC { get; set; }
        public bool TieneStock { get; set; }
        public bool TieneStockPROL { get; set; }
        public int TieneSugerido { get; set; }
        public bool TipoCross { get; set; }
        public string TipoEstrategiaID { get; set; }
        public string TipoMeta { get; set; }
        public string TipoOfertaRevista { get; set; }
        public int TipoOfertaSisID { get; set; }
        public List<ProductoModel> Tonos { get; set; }
        public string Volumen { get; set; }
        public int EstrategiaID { get; set; }
        public object Clone()
        {
            return this.MemberwiseClone();
        }
    }
}