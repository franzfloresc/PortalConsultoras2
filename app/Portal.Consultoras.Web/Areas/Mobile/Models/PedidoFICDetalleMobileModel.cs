using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceODS;
using System.ComponentModel.DataAnnotations;
using Portal.Consultoras.Web.Models;

namespace Portal.Consultoras.Web.Areas.Mobile.Models
{
    public class PedidoFICDetalleMobileModel
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

        public string TotalCliente { get; set; }

        public string ClienteID_ { get; set; }

        public List<BEPedidoFICDetalle> ListaDetalle { get; set; }
        public List<ServiceSAC.BEProductoFaltante> ListaProductoFaltante { get; set; }
        public List<ServiceSAC.BEOfertaWeb> ListaOfertaWeb { get; set; }
        public List<ObservacionModel> ListaObservacionesPROL { get; set; }
        public List<PedidoActualizaModel> ListaPedidoActualizaModel { get; set; }
        


        ///////////////  Solo Mobile
        public List<BEEstrategia> ListaEstrategias { get; set; }

        public int PaisId { get; set; }

        public string TotalStr { get; set; }

        public string DescripcionTotal { get; set; }

        public decimal TotalMinimo { get; set; }
        public string TotalMinimoStr { get; set; }
        public string DescuentoStr { get; set; }
        public string MontoConDsctoStr { get; set; }

        public string DescripcionTotalMinimo { get; set; }

        public List<BEPedidoWebDetalle> ListaProductos { get; set; }

        public int CantidadProductos { get; set; }

        public string CampaniaActual { get; set; }

        public string CampaniaNro { get; set; }

        public string DescripcionCampaniaActual
        {
            get
            {
                return "C-" + (string.IsNullOrEmpty(CampaniaActual) ? "00" : CampaniaActual.Substring(CampaniaActual.Length - 2));
            }
        }

        public string CodigoISO { get; set; }

        public string CodigoIso { get; set; }

        public List<ServiceCliente.BECliente> ListaClientes { get; set; }

        public int ClienteId { get; set; }

        public decimal MontoAhorroCatalogo { get; set; }

        public decimal MontoAhorroRevista { get; set; }

        public string GananciaFormat { get; set; }

        public string FormatoMontoAhorroCatalogo { get; set; }

        public string FormatoMontoAhorroRevista { get; set; }

        public string NombreConsultora { get; set; }

        public int TieneCupon { get; set; }
        public bool EmailActivo { get; set; }
        public string EMail { get; set; }
        public string Celular { get; set; }

        public int TieneMasVendidos { get; set; }
        public int TieneOfertaLog { get; set; }
        public PartialSectionBpt PartialSectionBpt { get; set; }

        public bool MostrarPopupPrecargados { get; set; }


















        ///// <summary>
        ///// ///////////////////////////////   ORIGINAL
        ///// </summary>

        //public List<PedidoDetalleMobileDetalleModel> Detalle { get; set; }
        //public decimal Total { get; set; }

        //public string DescripcionTotal { get; set; }

        //public decimal TotalMinimo { get; set; }

        //public string DescripcionTotalMinimo { get; set; }

        //public decimal GanaciaEstimada { get; set; }
        //public string DescripcionGanaciaEstimada { get; set; }

        //public bool MostrarEscalaDescuento { get; set; }
        //public decimal MontoEscalaDescuento { get; set; }
        //public string DescripcionMontoEscalaDescuento { get; set; }
        //public int PorcentajeEscala { get; set; }      

        //public string Simbolo { get; set; }

        //public bool EliminadoTemporal { get; set; }

        //public int PaisID {get; set;}

        //public string CodigoISO { get; set; }

        //public string Email { get; set; }

        //public int ModificacionPedidoProl { get; set; }

        //public bool ModificaPedidoReservado { get; set; }

        //public string FlagValidacionPedido { get; set; }

        //public string BotonPROL { get; set; }

        //public string MensajeGuardarCO { get; set; }

        //public int EstadoPedido { get; set; }

        //public int CantidadProductos { get; set; }

        //public string CampaniaActual { get; set; }

        //public string DescripcionCampaniaActual
        //{
        //    get
        //    {
        //        return "C-" + (string.IsNullOrEmpty(CampaniaActual) ? "00" : CampaniaActual.Substring(CampaniaActual.Length - 2));
        //    }
        //}


        //public bool PedidoConProductosExceptuadosMontoMinimo { get; set; }

        //public bool PedidoConDescuentoCuv { get; set; }

        //public decimal SubTotal { get; set; }

        //public string DescripcionSubTotal { get; set; }

        //public decimal Descuento { get; set; }

        //public string DescripcionDescuento { get; set; }
        //public string MontoConDsctoStr { get; set; }

        //public decimal MontoAhorroCatalogo { get; set; }

        //public decimal MontoAhorroRevista { get; set; }

        //public string GananciaFormat { get; set; }

        //public string MensajeCierreCampania { get; set; }

        //public string FechaFacturacionPedido { get; set; }

        //public string HoraCierre { get; set; }

        //public string Prol { get; set; }
        //public string ProlTooltip { get; set; }

        //public void SetDetalleMobileFromDetalleWeb(List<BEPedidoWebDetalle> listDetalleWeb)
        //{
        //    this.Detalle = new List<PedidoDetalleMobileDetalleModel>();
        //    foreach(var detalleWeb in listDetalleWeb)
        //    {
        //        this.Detalle.Add(new PedidoDetalleMobileDetalleModel {
        //            PedidoDetalleID = detalleWeb.PedidoDetalleID,
        //            MarcaID = detalleWeb.MarcaID,
        //            Cantidad = detalleWeb.Cantidad,
        //            PrecioUnidad = detalleWeb.PrecioUnidad,
        //            ImporteTotal = detalleWeb.ImporteTotal,
        //            Nombre = detalleWeb.Nombre,
        //            Mensaje = detalleWeb.Mensaje,
        //            DescripcionProd = detalleWeb.DescripcionProd,
        //            CUV = detalleWeb.CUV,
        //            IndicadorMontoMinimo = detalleWeb.IndicadorMontoMinimo,
        //            TipoPedido = detalleWeb.TipoPedido,
        //            ConfiguracionOfertaID = detalleWeb.ConfiguracionOfertaID,
        //            IndicadorOfertaCUV = detalleWeb.IndicadorOfertaCUV,
        //            TipoObservacion = detalleWeb.TipoObservacion,
        //            EsBackOrder = detalleWeb.EsBackOrder,
        //            AceptoBackOrder = detalleWeb.AceptoBackOrder
        //        });
        //    }
        //}

        //public int OfertaFinal { get; set; }
        //public bool EsOfertaFinalZonaValida { get; set; }

        //public int OfertaFinalGanaMas { get; set; }
        //public bool EsOFGanaMasZonaValida { get; set; }

        //public List<BEEscalaDescuento> ListaParametriaOfertaFinal { get; set; }
        //public bool EsFacturacion { get; set; }
        //public bool EsConsultoraNueva { get; set; }
        //public Portal.Consultoras.Web.Models.BarraConsultoraModel DataBarra { get; set; }
        //public decimal MontoMinimo { get; set; }
        //public decimal MontoMaximo { get; set; }
        //public bool AutoReservar { get; set; }
        //public int TieneCupon { get; set; }
        //public bool EmailActivo { get; set; }
        //public string EMail { get; set; }
        //public string Celular { get; set; }

        //public bool MostrarPopupPrecargados { get; set; }
    }
}