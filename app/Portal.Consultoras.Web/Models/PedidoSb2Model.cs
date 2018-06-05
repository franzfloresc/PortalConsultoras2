using Portal.Consultoras.Common;
using Portal.Consultoras.Web.ServiceCliente;
using Portal.Consultoras.Web.ServicePedido;
using System.Collections.Generic;
using BEPedidoWebDetalle = Portal.Consultoras.Web.ServicePedido.BEPedidoWebDetalle;

namespace Portal.Consultoras.Web.Models
{
    public class PedidoSb2Model
    {
        public string CodigoIso { get; set; }

        public bool EstadoSimplificacionCuv { get; set; }

        public string ErrorInsertarProducto { get; set; }

        public List<BEEstrategia> ListaEstrategias { get; set; }

        public bool ZonaNuevoProlM { get; set; }

        public int IndicadorFlexiPago { get; set; }

        public decimal LineaCredito { get; set; }

        public string FormatoLineaCredito
        {
            get
            {
                return Util.DecimalToStringFormat(Total, CodigoIso);
            }
        }

        public decimal PedidoBase { get; set; }

        public string FormatoPedidoBase
        {
            get
            {
                return Util.DecimalToStringFormat(Total, CodigoIso);
            }
        }

        public string FlagValidacionPedido { get; set; }

        public int EstadoPedido { get; set; }

        public string NombreConsultora { get; set; }

        public List<BEPedidoWebDetalle> PedidoWebDetalle { get; set; }

        public List<BEPedidoWebDetalle> ListaDetalle { get; set; }

        public int PaisID { get; set; }

        public string Simbolo { get; set; }

        public decimal Total { get; set; }

        public decimal TotalConDescuento { get; set; }

        public string FormatoTotal
        {
            get
            {
                return Util.DecimalToStringFormat(Total, CodigoIso);
            }
        }

        public string FormatoMontoGanancia
        {
            get
            {
                return Util.DecimalToStringFormat(MontoAhorroCatalogo + MontoAhorroRevista, CodigoIso);
            }
        }

        public string FormatoMontoEscala
        {
            get
            {
                return Util.DecimalToStringFormat(MontoEscala, CodigoIso);
            }
        }

        public string FormatoMontoDescuento
        {
            get
            {
                return Util.DecimalToStringFormat(MontoDescuento, CodigoIso);

            }
        }

        public string FormatoTotalConDescuento
        {
            get
            {
                return Util.DecimalToStringFormat(TotalConDescuento, CodigoIso);
            }
        }

        public string FormatoMontoAhorroCatalogo
        {
            get
            {
                return Util.DecimalToStringFormat(MontoAhorroCatalogo, CodigoIso);
            }
        }

        public string FormatoMontoAhorroRevista
        {
            get
            {
                return Util.DecimalToStringFormat(MontoAhorroRevista, CodigoIso);
            }
        }

        public string TotalCliente { get; set; }

        public string ClienteID_ { get; set; }

        public decimal MontoAhorroCatalogo { get; set; }

        public decimal MontoAhorroRevista { get; set; }

        public decimal MontoDescuento { get; set; }

        public decimal MontoEscala { get; set; }

        public string Prol { get; set; }

        public string ProlTooltip { get; set; }

        public string MensajeGuardarColombia { get; set; }

        public string Registros { get; set; }

        public string RegistrosDe { get; set; }

        public string RegistrosTotal { get; set; }

        public string Pagina { get; set; }

        public string PaginaDe { get; set; }

        public List<BECliente> ListaCliente { get; set; }

        public string SobreNombre { get; set; }

        public List<ObservacionModel> ListaObservacionesProl { get; set; }

        public string ErrorDelete { get; set; }

        public string CUVReco { get; set; }

        public bool EsSugerido { get; set; }

        public bool EsKitNueva { get; set; }

        public string Cantidad { get; set; }

        public string CUV { get; set; }

        public bool OfertaWeb { get; set; }

        public string ClienteDescripcion { get; set; }

        #region propiedades usadas para Validacion PROL

        public bool ObservacionRestrictiva { get; set; }

        public bool ErrorProl { get; set; }
        public bool AvisoProl { get; set; }

        public bool Reserva { get; set; }

        public bool ZonaValida { get; set; }

        public bool ValidacionInteractiva { get; set; }

        public string MensajeValidacionInteractiva { get; set; }

        public bool EsModificacion { get; set; }

        public bool EsDiaProl { get; set; }

        public bool ProlSinStock { get; set; }

        #endregion

        #region propiedades de userdata

        public string Campania { get; set; }

        public int CampaniaId { get; set; }

        public int Dias { get; set; }

        public string MensajeCierreCampania { get; set; }

        public string CodigoZona { get; set; }

        public string FechaFacturacionPedido { get; set; }

        #endregion

        #region  Campos que no se cargan a primera instancia en el index (POR VERIFICAR SI SE USAN O NO)

        public int Tipo { get; set; }

        public string CUVComplemento { get; set; }

        public byte MarcaIDComplemento { get; set; }

        public decimal PrecioUnidadComplemento { get; set; }

        public string IndicadorMontoMinimo { get; set; }

        public int TipoOfertaSisID { get; set; }

        public int ConfiguracionOfertaID { get; set; }

        public string DescripcionEstrategia { get; set; }

        public string DescripcionLarga { get; set; }

        public string DescripcionProd { get; set; }

        public int MarcaID { get; set; }

        public decimal PrecioUnidad { get; set; }

        public string ClienteID { set; get; }

        #endregion

        public string UrlBanner01 { get; set; }

        public string UrlBanner02 { get; set; }

        public string UrlBanner03 { get; set; }

        public string accionBanner_01 { get; set; }

        public List<PedidoWebDetalleModel> ListaDetalleModel { get; set; }

        public int TotalProductos { get; set; }

        public BarraConsultoraModel DataBarra { get; set; }

        public bool EsFacturacion { get; set; }

        public int OfertaFinal { get; set; }

        public bool EsOfertaFinalZonaValida { get; set; }

        public int OfertaFinalGanaMas { get; set; }

        public bool EsOFGanaMasZonaValida { get; set; }

        public string CodigoMensajeProl { get; set; }

        public decimal MontoMinimo { get; set; }

        public decimal MontoMaximo { get; set; }

        public string EsPais { get; set; }

        public List<BEEscalaDescuento> ListaParametriaOfertaFinal { get; set; }

        public bool EsConsultoraNueva { get; set; }

        public string AccionBoton { get; set; }

        public int OrigenPedidoWeb { get; set; }

        public int IndicadorGPRSB { get; set; }

        public string Celular { get; set; }
        public string EMail { get; set; }
        public bool EmailActivo { get; set; }
        public int TieneCupon { get; set; }

        public int CampaniaActual { get; set; }

        public int TieneMasVendidos { get; set; }
        public int TieneOfertaLog { get; set; }

        public PartialSectionBpt PartialSectionBpt { get; set; }

        public bool EsOfertaIndependiente { get; set; }

        public bool MostrarPopupPrecargados { get; set; }
    }
}