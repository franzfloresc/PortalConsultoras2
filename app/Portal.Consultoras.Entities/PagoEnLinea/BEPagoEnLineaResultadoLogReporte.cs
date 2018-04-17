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
            if (DataRecord.HasColumn(datarec, "CampaniaId") && datarec["CampaniaId"] != DBNull.Value)
                CampaniaId = DbConvert.ToInt32(datarec["CampaniaId"]);

            if (DataRecord.HasColumn(datarec, "NombreComercio") && datarec["NombreComercio"] != DBNull.Value)
                NombreComercio = DbConvert.ToString(datarec["NombreComercio"]);

            if (DataRecord.HasColumn(datarec, "IdUnicoTransaccion") && datarec["IdUnicoTransaccion"] != DBNull.Value)
                IdUnicoTransaccion = DbConvert.ToString(datarec["IdUnicoTransaccion"]);

            if (DataRecord.HasColumn(datarec, "PagoEnLineaResultadoLogId") && datarec["PagoEnLineaResultadoLogId"] != DBNull.Value)
                PagoEnLineaResultadoLogId = DbConvert.ToInt32(datarec["PagoEnLineaResultadoLogId"]);

            if (DataRecord.HasColumn(datarec, "PrimerNombre") && datarec["PrimerNombre"] != DBNull.Value)
                PrimerNombre = DbConvert.ToString(datarec["PrimerNombre"]);

            if (DataRecord.HasColumn(datarec, "SegundoNombre") && datarec["SegundoNombre"] != DBNull.Value)
                SegundoNombre = DbConvert.ToString(datarec["SegundoNombre"]);

            if (DataRecord.HasColumn(datarec, "PrimerApellido") && datarec["PrimerApellido"] != DBNull.Value)
                PrimerApellido = DbConvert.ToString(datarec["PrimerApellido"]);

            if (DataRecord.HasColumn(datarec, "SegundoApellido") && datarec["SegundoApellido"] != DBNull.Value)
                SegundoApellido = DbConvert.ToString(datarec["SegundoApellido"]);

            if (DataRecord.HasColumn(datarec, "FechaCreacion") && datarec["FechaCreacion"] != DBNull.Value)
                FechaCreacion = DbConvert.ToDateTime(datarec["FechaCreacion"]);

            if (DataRecord.HasColumn(datarec, "CodigoConsultora") && datarec["CodigoConsultora"] != DBNull.Value)
                CodigoConsultora = DbConvert.ToString(datarec["CodigoConsultora"]);

            if (DataRecord.HasColumn(datarec, "NumeroDocumento") && datarec["NumeroDocumento"] != DBNull.Value)
                NumeroDocumento = DbConvert.ToString(datarec["NumeroDocumento"]);

            if (DataRecord.HasColumn(datarec, "Canal") && datarec["Canal"] != DBNull.Value)
                Canal = DbConvert.ToString(datarec["Canal"]);

            if (DataRecord.HasColumn(datarec, "Ciclo") && datarec["Ciclo"] != DBNull.Value)
                Ciclo = DbConvert.ToString(datarec["Ciclo"]);

            if (DataRecord.HasColumn(datarec, "ImporteAutorizado") && datarec["ImporteAutorizado"] != DBNull.Value)
                ImporteAutorizado = DbConvert.ToDecimal(datarec["ImporteAutorizado"]);

            if (DataRecord.HasColumn(datarec, "MontoGastosAdministrativos") && datarec["MontoGastosAdministrativos"] != DBNull.Value)
                MontoGastosAdministrativos = DbConvert.ToDecimal(datarec["MontoGastosAdministrativos"]);

            if (DataRecord.HasColumn(datarec, "IVA") && datarec["IVA"] != DBNull.Value)
                IVA = DbConvert.ToDecimal(datarec["IVA"]);

            if (DataRecord.HasColumn(datarec, "MontoPago") && datarec["MontoPago"] != DBNull.Value)
                MontoPago = DbConvert.ToDecimal(datarec["MontoPago"]);

            if (DataRecord.HasColumn(datarec, "TicketId") && datarec["TicketId"] != DBNull.Value)
                TicketId = DbConvert.ToString(datarec["TicketId"]);

            if (DataRecord.HasColumn(datarec, "CodigoRegion") && datarec["CodigoRegion"] != DBNull.Value)
                CodigoRegion = DbConvert.ToString(datarec["CodigoRegion"]);

            if (DataRecord.HasColumn(datarec, "CodigoZona") && datarec["CodigoZona"] != DBNull.Value)
                CodigoZona = DbConvert.ToString(datarec["CodigoZona"]);

            if (DataRecord.HasColumn(datarec, "OrigenTarjeta") && datarec["OrigenTarjeta"] != DBNull.Value)
                OrigenTarjeta = DbConvert.ToString(datarec["OrigenTarjeta"]);

            if (DataRecord.HasColumn(datarec, "NumeroTarjeta") && datarec["NumeroTarjeta"] != DBNull.Value)
                NumeroTarjeta = DbConvert.ToString(datarec["NumeroTarjeta"]);

            if (DataRecord.HasColumn(datarec, "NumeroOrdenTienda") && datarec["NumeroOrdenTienda"] != DBNull.Value)
                NumeroOrdenTienda = DbConvert.ToString(datarec["NumeroOrdenTienda"]);

            if (DataRecord.HasColumn(datarec, "CodigoError") && datarec["CodigoError"] != DBNull.Value)
                CodigoError = DbConvert.ToString(datarec["CodigoError"]);

            if (DataRecord.HasColumn(datarec, "MensajeError") && datarec["MensajeError"] != DBNull.Value)
                MensajeError = DbConvert.ToString(datarec["MensajeError"]);

            if (DataRecord.HasColumn(datarec, "FechaTransaccion") && datarec["FechaTransaccion"] != DBNull.Value)
                FechaTransaccion = DbConvert.ToDateTime(datarec["FechaTransaccion"]);
        }
    }
}
