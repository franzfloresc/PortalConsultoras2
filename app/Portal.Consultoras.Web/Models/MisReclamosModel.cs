using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    public class MisReclamosModel
    {
        public int CDRWebID { get; set; }
        public int PedidoID { get; set; }
        public int NumeroPedido { get; set; }
        public int CampaniaID { get; set; }
        public List<CampaniaModel> ListaCampania { get; set; }
        public List<CampaniaModel> ListaPedido { get; set; }
        public string Campania { get; set; }
        public string EstadoSsic { get; set; }
        public string CUV { get; set; }
        public int Cantidad { get; set; }
        public string DescripcionProd { get; set; }
        public string EstadoSsic2 { get; set; }
        public string CUV2 { get; set; }
        public int Cantidad2 { get; set; }
        public string DescripcionProd2 { get; set; }
        public string DescripcionConfirma { get; set; }
        public string DescripcionConfirma2 { get; set; }
        public string Motivo { get; set; }
        public string Operacion { get; set; }
        public List<Campo> ListaMotivo { get; set; }
        public int CDRWebDetalleID { get; set; }

        public string Accion { get; set; }
        public string Email { get; set; }
        public string Telefono { get; set; }

        public List<CDRWebModel> ListaCDRWeb { get; set; }

        public decimal MontoMinimo { get; set; }

        public int TieneHistoricoCDR { get; set; }
        public string UrlPoliticaCdr { get; set; }
        public string MensajeGestionCdrInhabilitada { get; set; }

        public int limiteMinimoTelef { get; set; }
        public int limiteMaximoTelef { get; set; }

        public bool TieneCDRExpress { get; set; }
        public bool EsConsultoraNueva { get; set; }
        public bool? TipoDespacho { get; set; }
        public decimal FleteDespacho { get; set; }
        public string MensajeDespacho { get; set; }
        public bool EsMovilOrigen { get; set; }
        public bool EsMovilFin { get; set; }
        public MensajesCDRExpressModel MensajesExpress { get; set; }
    }
}