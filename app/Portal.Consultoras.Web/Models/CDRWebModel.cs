using Portal.Consultoras.Common;
using Portal.Consultoras.Web.ServiceCDR;
using System;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    [Serializable]
    public class CDRWebModel
    {
        public int CDRWebID { get; set; }
        public int PedidoID { get; set; }
        public int PedidoNumero { get; set; }
        public int CampaniaID { get; set; }
        public int ConsultoraID { get; set; }
        public DateTime FechaRegistro { get; set; }
        public int Estado { get; set; }
        public DateTime? FechaCulminado { get; set; }
        public DateTime? FechaAtencion { get; set; }
        public decimal Importe { get; set; }
        public int CantidadDetalle { get; set; }
        public string NombreConsultora { get; set; }

        public string CodigoIso { get; set; }

        public string Simbolo { get; set; }
        public decimal ConsultoraSaldo { get; set; }

        public bool? TipoDespacho { get; set; }
        public decimal FleteDespacho { get; set; }
        public string MensajeDespacho { get; set; }

        public string Proceso { get; set; }

        public List<BECDRWebDetalle> ListaDetalle { get; set; }
        public string EstadoDescripcion
        {
            get
            {
                switch (Estado)
                {
                    case Constantes.EstadoCDRWeb.Pendiente: return "PENDIENTE";
                    case Constantes.EstadoCDRWeb.Enviado: return "ENVIADO";
                    case Constantes.EstadoCDRWeb.Observado: return "RECHAZADO";
                    case Constantes.EstadoCDRWeb.Aceptado: return "APROBADO";
                    default: return "";
                }
            }
        }

        public string ResumenResolucion
        {
            get
            {
                switch (Estado)
                {
                    case Constantes.EstadoCDRWeb.Pendiente: return "Pendiente";
                    case Constantes.EstadoCDRWeb.Enviado: return "En evaluación";
                    case Constantes.EstadoCDRWeb.Observado: return "Resuelve las observaciones y envía nuevamente la solicitud";
                    case Constantes.EstadoCDRWeb.Aceptado: return "Todos los productos fueron aprobados";
                    default: return "";
                }
            }
        }

        public int ZonaID { get; set; }
        public int PaisID { get; set; }
        public int RegionID { get; set; }

        public int CantidadAprobados { get; set; }
        public int CantidadRechazados { get; set; }
        public string OrigenCDRDetalle { get; set; }
        public string FormatoFechaCulminado { get; set; }
        public string FormatoCampaniaID { get; set; }

        public IEnumerable<CampaniaModel> lista { get; set; }
        public IEnumerable<PaisModel> listaPaises { get; set; }
        public IEnumerable<ZonaModel> listaZonas { get; set; }
        public IEnumerable<RegionModel> listaRegiones { get; set; }
        public IEnumerable<EstadoActividadModel> TiposConsultora { get; set; }
    }
}