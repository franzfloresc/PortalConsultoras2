using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEPagoEnLineaInfo
    {
        [DataMember]
        public decimal MontoSaldoActual { get; set; }
        [DataMember]
        public string Nombre { get; set; }
        [DataMember]
        public DateTime FechaConferencia { get; set; }

        public BEPagoEnLineaInfo() { }

        public BEPagoEnLineaInfo(IDataRecord row)
        {
            if (row.HasColumn("MontoSaldoActual") && row["MontoSaldoActual"] != DBNull.Value)
                MontoSaldoActual = Convert.ToDecimal(row["MontoSaldoActual"]);

            if (row.HasColumn("Nombre") && row["Nombre"] != DBNull.Value)
                Nombre = Convert.ToString(row["Nombre"]);

            if (row.HasColumn("FechaConferencia") && row["FechaConferencia"] != DBNull.Value)
                FechaConferencia = Convert.ToDateTime(row["FechaConferencia"]);
        }
    }
}