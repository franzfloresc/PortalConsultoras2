using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEPedidoDescarga
    {
        [DataMember]
        public DateTime FechaHoraInicio { get; set; }

        [DataMember]
        public DateTime FechaHoraFin { get; set; }

        [DataMember]
        public String Estado { get; set; }

        [DataMember]
        public String Mensaje { get; set; }

        [DataMember]
        public int NumeroPedidosWeb { get; set; }

        [DataMember]
        public int NumeroPedidosDD { get; set; }

        [DataMember]
        public String TipoProceso { get; set; }

        [DataMember]
        public DateTime FechaFacturacion { get; set; }

        [DataMember]
        public int NroLote { get; set; }

        [DataMember]
        public Boolean Desmarcado { get; set; }
        [DataMember]
        public DateTime FechaProceso { get; set; }
        [DataMember]
        public DateTime FechaEnvio { get; set; }
        public BEPedidoDescarga()
        {
        }

        public BEPedidoDescarga(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "FechaHoraInicio") && row["FechaHoraInicio"] != DBNull.Value)
                FechaHoraInicio = Convert.ToDateTime(row["FechaHoraInicio"]);

            if (DataRecord.HasColumn(row, "FechaHoraFin") && row["FechaHoraFin"] != DBNull.Value)
                FechaHoraFin = Convert.ToDateTime(row["FechaHoraFin"]);

            if (DataRecord.HasColumn(row, "Estado") && row["Estado"] != DBNull.Value)
                Estado = row["Estado"].ToString();

            if (DataRecord.HasColumn(row, "Mensaje") && row["Mensaje"] != DBNull.Value)
                Mensaje = row["Mensaje"].ToString();

            if (DataRecord.HasColumn(row, "NumeroPedidosWeb") && row["NumeroPedidosWeb"] != DBNull.Value)
                NumeroPedidosWeb = Convert.ToInt32(row["NumeroPedidosWeb"]);

            if (DataRecord.HasColumn(row, "NumeroPedidosDD") && row["NumeroPedidosDD"] != DBNull.Value)
                NumeroPedidosDD = Convert.ToInt32(row["NumeroPedidosDD"]);

            if (DataRecord.HasColumn(row, "TipoProceso") && row["TipoProceso"] != DBNull.Value)
                TipoProceso = row["TipoProceso"].ToString();

            if (DataRecord.HasColumn(row, "FechaFacturacion") && row["FechaFacturacion"] != DBNull.Value)
                FechaFacturacion = Convert.ToDateTime(row["FechaFacturacion"].ToString());

            if (DataRecord.HasColumn(row, "NroLote") && row["NroLote"] != DBNull.Value)
                NroLote = Convert.ToInt32(row["NroLote"]);

            if (DataRecord.HasColumn(row, "Desmarcado") && row["Desmarcado"] != DBNull.Value)
                Desmarcado = Convert.ToBoolean(row["Desmarcado"]);

            if (DataRecord.HasColumn(row, "FechaProceso") && row["FechaProceso"] != DBNull.Value)
                FechaProceso = Convert.ToDateTime(row["FechaProceso"]);

            if (DataRecord.HasColumn(row, "FechaEnvio") && row["FechaEnvio"] != DBNull.Value)
                FechaEnvio = Convert.ToDateTime(row["FechaEnvio"]);

        }
    }
}
