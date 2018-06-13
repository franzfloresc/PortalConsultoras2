using Portal.Consultoras.Web.ServicePedido;
using System;
using System.Collections.Generic;
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
        public bool IndicadorOfertaCUV { get; set; }

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
        public string DescripcionCortadaProd { get; set; }
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
        public List<PedidoWebDetalleModel> ListaDetalleFormato { get; set; }
        public List<ServiceSAC.BEProductoFaltante> ListaProductoFaltante { get; set; }
        public List<ServiceSAC.BEOfertaWeb> ListaOfertaWeb { get; set; }
        public List<ObservacionModel> ListaObservacionesPROL { get; set; }
        public List<PedidoActualizaModel> ListaPedidoActualizaModel { get; set; }
        public List<ServiceCliente.BECliente> DropDownListCliente { get; set; }
        public bool PROLSinStock { get; set; }
        public int SubTipoOfertaSisID { get; set; }
        public int ModificacionPedidoProl { get; set; }
        public string DescripcionEstrategia { get; set; }
        public string Categoria { get; set; }
        public string DescripcionLarga { get; set; }
        public int FlagNueva { get; set; }
        public string MensajeError { get; set; }
        public bool ZonaNuevoPROLM { get; set; }

        public bool ValidacionInteractiva { get; set; }
        public string MensajeValidacionInteractiva { get; set; }

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
    public class ProductoModel : CompartirRedesSocialesModel
    {
        public int ID { get; set; }
        public string CUV { get; set; }
        public string Descripcion { get; set; }
        public string DescripcionComercial { get; set; }
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
        public string MensajeCUV { get; set; }
        public int? DesactivaRevistaGana { get; set; }
        public string ObservacionCUV { get; set; }
        public string DescripcionMarca { get; set; }
        public string DescripcionCategoria { get; set; }
        public string DescripcionEstrategia { get; set; }
        public string FlagNueva { get; set; }
        public string TipoEstrategiaID { get; set; }

        public int LimiteVenta { get; set; }

        public string Imagen { get; set; }
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

        public string Volumen { get; set; }
        public bool EsMaquillaje { get; set; }
        public string ImagenBulk { get; set; }
        public string NombreBulk { get; set; }
        public List<ProductoModel> Hermanos { get; set; }
        public List<ProductoModel> Tonos { get; set; }

        public string CodigoIso { get; set; }
        public int Relevancia { get; set; }
        public string CodigoCategoria { get; set; }
        public string CodigoMarca { get; set; }
        public bool PaisEsikizado { get; set; }
        
        public string NombreComercial { get; set; }
        public string NombreComercialCorto { get; set; }

        public string TipoMeta { get; set; }
        public string MontoMeta { get; set; }
        public string MetaMontoStr { get; set; }
        public string CUVPedido { get; set; }
        public string CUVPedidoNombre { get; set; }
        public string CUVPedidoImagen { get; set; }
        public bool TipoCross { get; set; }

        public int Digitable { get; set; }
        public int Orden { get; set; }
        public string Grupo { get; set; }

        public int Cantidad { get; set; }
        public bool EsOfertaIndependiente { get; set; }

        public bool TieneRDC { get; set; }

        public int FactorCuadre { get; set; }

        public string ImagenProductoSugeridoSmall { get; set; }

        public string ImagenProductoSugeridoMedium { get; set; }

        public object Clone()
        {
            return this.MemberwiseClone();
        }
    }

    [Serializable]
    public class ObservacionModel
    {
        public string CUV { get; set; }
        public int Tipo { get; set; }
        public string Descripcion { get; set; }
        public int Caso { get; set; }
    }
}
