using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceODS;
using System.ComponentModel.DataAnnotations;

namespace Portal.Consultoras.Web.Models
{
    public class PedidoDetalleModel
    {
        public int CampaniaID { set; get; }
        public int PedidoID { set; get; }
        public Int16 PedidoDetalleID { set; get; }
        public byte MarcaID { set; get; }
        public int ConsultoraID { set; get; }
        public string ClienteID { set; get; }
        public int Estado { get; set; }
        public int Flag { get; set; }
        public int Stock { get; set; }
        public string ClienteDescripcion { set; get; }
        public bool IndicadorOfertaCUV  { get; set; } /*R20150701*/

        public string urlBanner_01 { get; set; }
        public string urlBanner_02 { get; set; }
        public string urlBanner_03 { get; set; }

        public string accionBanner_01 { get; set; }

        [Required(ErrorMessage = "Debe ingresar la Cantidad del Producto")]
        [Range(1, 99, ErrorMessage = "Debe ingresar un valor entre 1 y 99")]
        public string Cantidad { get; set; }
        public decimal PrecioUnidad { get; set; }
        public decimal ImporteTotal { get; set; }
        [Required(ErrorMessage = "Debe ingresar el CUV")]
        public string CUV { get; set; }
        [Required(ErrorMessage = "Debe ingresar el Producto")]
        public string DescripcionProd { get; set; }
        public int PaisID { get; set; }
        public string Nombre { get; set; }
        public string eMail { get; set; }

        public string CUVComplemento { get; set; }
        public byte MarcaIDComplemento { get; set; }
        public decimal PrecioUnidadComplemento { get; set; }
        public string IndicadorMontoMinimo { get; set; }

        public int Tipo { get; set; }
        public bool OfertaWeb { get; set; }

        public int MatrizOW { get; set; }
        public bool ObservacionRestrictiva { get; set; }
        public bool ObservacionInformativa { get; set; }
        public bool ErrorPROL { get; set; }
        public bool Reserva { get; set; }
        public string BotonPROL { get; set; }
        public string Simbolo { get; set; }
        public string Total { get; set; }
        public string Total_Minimo { get; set; }
        public string Total_Cliente { get; set; }
        public bool EsDiaPROL { get; set; }
        public bool EsModificacion { get; set; }
        public bool ZonaValida { get; set; }
        public int TipoOfertaSisID { get; set; }
        public int ConfiguracionOfertaID { get; set; }
        public int CantidadAnterior { get; set; }

        public string Registros { get; set; }
        public string RegistrosDe { get; set; }
        public string RegistrosTotal { get; set; }
        public string Pagina { get; set; }
        public string PaginaDe { get; set; }
        public string ClienteID_ { get; set; }

        public List<BEPedidoWebDetalle> ListaDetalle { get; set; }
        public List<ServiceSAC.BEProductoFaltante> ListaProductoFaltante { get; set; }
        public List<ServiceSAC.BEOfertaWeb> ListaOfertaWeb { get; set; }
        public List<ObservacionModel> ListaObservacionesPROL { get; set; }
        public List<PedidoActualizaModel> ListaPedidoActualizaModel { get; set; }
        public List<ServiceCliente.BECliente> DropDownListCliente { get; set; }
        public bool PROLSinStock { get; set; } //1510
        public int SubTipoOfertaSisID { get; set; } //1513
        public int ModificacionPedidoProl { get; set; }//CCSS_JZ_PROL
        /*R2469 - JICM - INI*/      
        public string DescripcionEstrategia { get; set; }
        public string Categoria { get; set; }
        public string DescripcionLarga { get; set; }
        /*R2469 - JICM - FIN*/
        /*R2621LR */
        public int FlagNueva { get; set; }
        public string MensajeError { get; set; }
        public bool ZonaNuevoPROLM { get; set; }//R2584

        public bool ValidacionInteractiva { get; set; } // R20150306
        public string MensajeValidacionInteractiva { get; set; } // R20150306

        public bool EsSugerido { get; set; }
        public bool EsKitNueva { get; set; }

        public string SobreNombre { get; set; }

        public decimal MontoAhorroCatalogo { get; set; }

        public decimal MontoAhorroRevista { get; set; }

        public decimal MontoDescuento { get; set; }

        public decimal MontoEscala { get; set; }

        public string DescripcionMarca { get; set; }
        public int LimiteVenta { get; set; }
        
        public string TotalSinDsctoFormato { get; set; }
        public string TotalConDsctoFormato { get; set; }

        public int OrigenPedidoWeb { get; set; }
    }

    [Serializable()]
    public class ProductoModel
    {
        public string CUV { get; set; }
        public string Descripcion { get; set; }
        public decimal PrecioCatalogo { get; set; }
        public string PrecioCatalogoString { get; set; }
        public int MarcaID { get; set; }
        public bool EstaEnRevista { get; set; }
        public bool TieneStock { get; set; }
        public bool EsExpoOferta { get; set; }
        public string CUVRevista { get; set; }
        public string CUVComplemento { get; set; }
        public string IndicadorMontoMinimo { get; set; }
        public int ConfiguracionOfertaID { get; set; }
        public int TipoOfertaSisID { get; set; }
        // 1522
        public string MensajeCUV { get; set; }
        public int? DesactivaRevistaGana { get; set; } //R2154
        //2140
        public string ObservacionCUV { get; set; }
        /*R2469 - JICM - INI*/       
        public string DescripcionMarca { get; set; }        
        public string DescripcionCategoria { get; set; }      
        public string DescripcionEstrategia { get; set; }
        /*R2469 - JICM - FIN*/
        public string FlagNueva { get; set; } // CGI(AHAA) - bug 2015000858
        public string TipoEstrategiaID { get; set; } // CGI(AHAA) - bug 2015000858

        public int LimiteVenta { get; set; }

        public string ImagenProductoSugerido { get; set; }

        public int TieneSugerido { get; set; }

        public string CodigoProducto { get; set; }

        public bool TieneStockPROL { get; set; }

        public decimal PrecioValorizado { get; set; }

        public string PrecioValorizadoString { get; set; }

        public string Simbolo { get; set; }

        public string Sello { get; set; }
        public bool IsAgregado { get; set; }
        public bool TieneOfertaEnRevista { get; set; }

        public bool TieneLanzamientoCatalogoPersonalizado { get; set; }

        public string TipoOfertaRevista { get; set; }
    }

    public class ObservacionModel
    {
        public string CUV { get; set; }
        public int Tipo { get; set; }
        public string Descripcion { get; set; }
        public int Caso { get; set; }
    }
}
