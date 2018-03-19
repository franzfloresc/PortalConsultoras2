using Portal.Consultoras.Web.ServiceSAC;
using System;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    public class SolicitudClienteConsultoraModel
    {
        public long SolicitudClienteId { get; set; }
        public string ConsultoraID { get; set; }
        public string Estado { get; set; }
        public DateTime FechaEjecucion { get; set; }
        public string FechaDescripcion { get; set; }
        public string NombreCliente { get; set; }
        public string EmailCliente { get; set; }
        public string TelefonoCliente { get; set; }
        public string Mensaje { get; set; }
        public string MensajeaCliente { get; set; }
        public int NumIteracion { get; set; }
        public List<BESolicitudClienteDetalle> lsProductosDetalle { get; set; }
        public int MarcaID { get; set; }
        public string MarcaNombre { get; set; }
        public string Campania { get; set; }
        public string CodigoUbigeo { get; set; }
        public string Asunto { get; set; }
    }
}