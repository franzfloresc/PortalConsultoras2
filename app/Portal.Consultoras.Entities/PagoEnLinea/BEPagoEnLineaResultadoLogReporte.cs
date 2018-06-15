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

        public BEPagoEnLineaResultadoLogReporte(IDataRecord datarec)
        {
            if (DataRecord.HasColumn(datarec, "CampaniaId"))
                CampaniaId = Convert.ToInt32(datarec["CampaniaId"]);

            if (DataRecord.HasColumn(datarec, "NombreComercio"))
                NombreComercio = Convert.ToString(datarec["NombreComercio"]);

            if (DataRecord.HasColumn(datarec, "IdUnicoTransaccion"))
                IdUnicoTransaccion = Convert.ToString(datarec["IdUnicoTransaccion"]);

            if (DataRecord.HasColumn(datarec, "PagoEnLineaResultadoLogId"))
                PagoEnLineaResultadoLogId = Convert.ToInt32(datarec["PagoEnLineaResultadoLogId"]);

            if (DataRecord.HasColumn(datarec, "PrimerNombre"))
                PrimerNombre = Convert.ToString(datarec["PrimerNombre"]);

            if (DataRecord.HasColumn(datarec, "SegundoNombre"))
                SegundoNombre = Convert.ToString(datarec["SegundoNombre"]);

            if (DataRecord.HasColumn(datarec, "PrimerApellido"))
                PrimerApellido = Convert.ToString(datarec["PrimerApellido"]);

            if (DataRecord.HasColumn(datarec, "SegundoApellido"))
                SegundoApellido = Convert.ToString(datarec["SegundoApellido"]);

            if (DataRecord.HasColumn(datarec, "FechaCreacion"))
                FechaCreacion = Convert.ToDateTime(datarec["FechaCreacion"]);

            if (DataRecord.HasColumn(datarec, "CodigoConsultora"))
                CodigoConsultora = Convert.ToString(datarec["CodigoConsultora"]);

            if (DataRecord.HasColumn(datarec, "NumeroDocumento"))
                NumeroDocumento = Convert.ToString(datarec["NumeroDocumento"]);

            if (DataRecord.HasColumn(datarec, "Canal"))
                Canal = Convert.ToString(datarec["Canal"]);

            if (DataRecord.HasColumn(datarec, "Ciclo"))
                Ciclo = Convert.ToString(datarec["Ciclo"]);

            if (DataRecord.HasColumn(datarec, "ImporteAutorizado"))
                ImporteAutorizado = Convert.ToDecimal(datarec["ImporteAutorizado"]);

            if (DataRecord.HasColumn(datarec, "MontoGastosAdministrativos"))
                MontoGastosAdministrativos = Convert.ToDecimal(datarec["MontoGastosAdministrativos"]);

            if (DataRecord.HasColumn(datarec, "IVA"))
                IVA = Convert.ToDecimal(datarec["IVA"]);

            if (DataRecord.HasColumn(datarec, "MontoPago"))
                MontoPago = Convert.ToDecimal(datarec["MontoPago"]);

            if (DataRecord.HasColumn(datarec, "TicketId"))
                TicketId = Convert.ToString(datarec["TicketId"]);

            if (DataRecord.HasColumn(datarec, "CodigoRegion"))
                CodigoRegion = Convert.ToString(datarec["CodigoRegion"]);

            if (DataRecord.HasColumn(datarec, "CodigoZona"))
                CodigoZona = Convert.ToString(datarec["CodigoZona"]);

            if (DataRecord.HasColumn(datarec, "OrigenTarjeta"))
                OrigenTarjeta = Convert.ToString(datarec["OrigenTarjeta"]);

            if (DataRecord.HasColumn(datarec, "NumeroTarjeta"))
                NumeroTarjeta = Convert.ToString(datarec["NumeroTarjeta"]);

            if (DataRecord.HasColumn(datarec, "NumeroOrdenTienda"))
                NumeroOrdenTienda = Convert.ToString(datarec["NumeroOrdenTienda"]);

            if (DataRecord.HasColumn(datarec, "CodigoError"))
                CodigoError = Convert.ToString(datarec["CodigoError"]);

            if (DataRecord.HasColumn(datarec, "MensajeError"))
                MensajeError = Convert.ToString(datarec["MensajeError"]);

            if (DataRecord.HasColumn(datarec, "FechaTransaccion"))
                FechaTransaccion = Convert.ToDateTime(datarec["FechaTransaccion"]);
        }
    }
}
