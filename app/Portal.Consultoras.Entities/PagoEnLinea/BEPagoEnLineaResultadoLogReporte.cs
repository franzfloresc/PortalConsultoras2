using OpenSource.Library.DataAccess;
using Portal.Consultoras.Common;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Entities.PagoEnLinea
{
    [DataContract]
    public class BEPagoEnLineaResultadoLogReporte
    {
        [DataMember]
        public int CampaniaId { get; set; }
        [DataMember]
        public string NombreComercio { get; set; }
        [DataMember]
        public string IdUnicoTransaccion { get; set; }
        [DataMember]
        public int PagoEnLineaResultadoLogId { get; set; }
        [DataMember]
        public string PrimerNombre { get; set; }
        [DataMember]
        public string SegundoNombre { get; set; }
        [DataMember]
        public string PrimerApellido { get; set; }
        [DataMember]
        public string SegundoApellido { get; set; }
        [DataMember]
        public DateTime FechaCreacion { get; set; }
        [DataMember]
        public string CodigoConsultora { get; set; }
        [DataMember]
        public string NumeroDocumento { get; set; }
        [DataMember]
        public string Canal { get; set; }
        [DataMember]
        public string Ciclo { get; set; }
        [DataMember]
        public decimal ImporteAutorizado { get; set; }
        [DataMember]
        public decimal MontoGastosAdministrativos { get; set; }
        [DataMember]
        public decimal IVA { get; set; }
        [DataMember]
        public decimal MontoPago { get; set; }
        [DataMember]
        public string TicketId { get; set; }
        [DataMember]
        public string CodigoRegion { get; set; }
        [DataMember]
        public string CodigoZona { get; set; }
        [DataMember]
        public string OrigenTarjeta { get; set; }
        [DataMember]
        public string NumeroTarjeta { get; set; }
        [DataMember]
        public string NumeroOrdenTienda { get; set; }
        [DataMember]
        public string CodigoError { get; set; }
        [DataMember]
        public string MensajeError { get; set; }

        [DataMember]
        public string NombreCompleto { get; set; }
        [DataMember]
        public string FechaCreacionFormat { get; set; }
        [DataMember]
        public string FechaCreacionHoraFormat { get; set; }
        [DataMember]
        public DateTime FechaTransaccion { get; set; }
        [DataMember]
        public string FechaTransaccionFormat { get; set; }
        [DataMember]
        public string FechaTransaccionHoraFormat { get; set; }

        public BEPagoEnLineaResultadoLogReporte(IDataRecord row)
        {
            CampaniaId = row.ToInt32("CampaniaId");
            NombreComercio = row.ToString("NombreComercio");
            IdUnicoTransaccion = row.ToString("IdUnicoTransaccion");
            PagoEnLineaResultadoLogId = row.ToInt32("PagoEnLineaResultadoLogId");
            PrimerNombre = row.ToString("PrimerNombre");
            SegundoNombre = row.ToString("SegundoNombre");
            PrimerApellido = row.ToString("PrimerApellido");
            SegundoApellido = row.ToString("SegundoApellido");
            FechaCreacion = row.ToDateTime("FechaCreacion");
            CodigoConsultora = row.ToString("CodigoConsultora");
            NumeroDocumento = row.ToString("NumeroDocumento");
            Canal = row.ToString("Canal");
            Ciclo = row.ToString("Ciclo");
            ImporteAutorizado = row.ToDecimal("ImporteAutorizado");
            MontoGastosAdministrativos = row.ToDecimal("MontoGastosAdministrativos");
            IVA = row.ToDecimal("IVA");
            MontoPago = row.ToDecimal("MontoPago");
            TicketId = row.ToString("TicketId");
            CodigoRegion = row.ToString("CodigoRegion");
            CodigoZona = row.ToString("CodigoZona");
            OrigenTarjeta = row.ToString("OrigenTarjeta");
            NumeroTarjeta = row.ToString("NumeroTarjeta");
            NumeroOrdenTienda = row.ToString("NumeroOrdenTienda");
            CodigoError = row.ToString("CodigoError");
            MensajeError = row.ToString("MensajeError");
            FechaTransaccion = row.ToDateTime("FechaTransaccion");
        }
    }
}
