using Portal.Consultoras.Common;
using Portal.Consultoras.Web.ServicePedido;
using System;
using System.Collections.Generic;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Web.Models
{
    [Serializable]
    [DataContract(IsReference = true)]
    public class EstrategiaPedidoModel : CompartirRedesSocialesModel
    {
        public EstrategiaPedidoModel()
        {
            ListaOfertas = new List<EstrategiaPedidoModel>();
            ConfiguracionPaisDatos = new List<ConfiguracionPaisDatosModel>();
            ConfiguracionContenedor = new ConfiguracionSeccionHomeModel();
        }

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
        public List<EstrategiaComponenteModel> Hermanos { get; set; }
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
        
        #region Campos que vienen de ShowRoom 

        public string Agregado { get; set; }
        public decimal PrecioOferta { get; set; }
        public decimal PrecioValorizado { get; set; }
        public int Agotado { get; set; }      
        public string CodigoCampania { get; set; }

        public int TipoOfertaSisID { get; set; }
        public int ConfiguracionOfertaID { get; set; }
        public bool FlagHabilitarProducto { get; set; }
        public int Stock { get; set; }
        public int StockInicial { get; set; }
        public string CUV { get; set; }
        public string CodigoISO { get; set; }
        public string ImagenProducto { get; set; }
        public string ImagenProductoAnterior { get; set; }
        public string ImagenMiniAnterior { get; set; }
        public string ImagenMini { get; set; }
        public string Subtitulo { get; set; }
        public int UnidadesPermitidas { get; set; }
        public IList<EstrategiaPedidoModel> ListaOfertaShowRoom { get; set; }
        public IList<EstrategiaPedidoModel> ListaShowRoomCompraPorCompra { get; set; }
        public string DescripcionLegal { get; set; }
        public string CodigoCategoria { get; set; }
        public string TipNegocio { get; set; }
        public bool TieneCompraXcompra { get; set; }
        public string TextoCondicionCompraCpc { get; set; }
        public string TextoDescripcionLegalCpc { get; set; }
        public decimal Gana { get { return Math.Abs(PrecioValorizado - PrecioOferta); } }
        public string FormatoPrecioValorizado { get { return Util.DecimalToStringFormat(PrecioValorizado, CodigoISO); } }
        public string FormatoPrecioOferta { get { return Util.DecimalToStringFormat(PrecioOferta, CodigoISO); } }
        public string FormatoGana { get { return Util.DecimalToStringFormat(Gana, CodigoISO); } }
        public bool EMailActivo { get; set; }
        public string EMail { get; set; }
        public string Celular { get; set; }
        public bool Suscripcion { get; set; }
        public string UrlTerminosCondiciones { get; set; }
        public bool EsSubCampania { get; set; }
        public int UnidadesPermitidasRestantes { get; set; }
        public int TipoAccionAgregar { get; set; }
        #endregion

        public EstrategiaPedidoModel Clone()
        {
            return (EstrategiaPedidoModel)this.MemberwiseClone();
        }
        
        public string ImagenFondo1 { get; set; }
        public string ColorFondo1 { get; set; }
        public string ImagenBanner { get; set; }
        public string ImagenSoloHoy { get; set; }
        public string ImagenFondo2 { get; set; }
        public string ColorFondo2 { get; set; }
        public string NombreOferta { get; set; }
        public decimal PrecioCatalogo { get; set; }
        public string DescripcionOferta { get; set; }
        public bool TieneOfertaDelDia { get; set; }
        public List<EstrategiaPedidoModel> ListaOfertas { get; set; }

        public ConfiguracionSeccionHomeModel ConfiguracionContenedor { get; set; }

        public string PrecioOfertaFormat
        {
            get
            {
                return Util.DecimalToStringFormat(PrecioOferta, CodigoISO);
            }
        }
        public string PrecioCatalogoFormat
        {
            get
            {
                return Util.DecimalToStringFormat(PrecioCatalogo, CodigoISO);
            }
        }

        public string TipoEstrategiaDescripcion { get; set; }
        public short Position { get; set; }
        
        public IList<ConfiguracionPaisDatosModel> ConfiguracionPaisDatos { get; set; }
        public bool BloqueoProductoDigital { get; set; }
        public bool EsBannerProgNuevas { get; set; }
    }
}
