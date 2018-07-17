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
            if (DataRecord.HasColumn(row, "FechaHoraInicio"))
                FechaHoraInicio = Convert.ToDateTime(row["FechaHoraInicio"]);

            if (DataRecord.HasColumn(row, "FechaHoraFin"))
                FechaHoraFin = Convert.ToDateTime(row["FechaHoraFin"]);

            if (DataRecord.HasColumn(row, "Estado"))
                Estado = Convert.ToString(row["Estado"]);

            if (DataRecord.HasColumn(row, "Mensaje"))
                Mensaje = Convert.ToString(row["Mensaje"]);

            if (DataRecord.HasColumn(row, "NumeroPedidosWeb"))
                NumeroPedidosWeb = Convert.ToInt32(row["NumeroPedidosWeb"]);

            if (DataRecord.HasColumn(row, "NumeroPedidosDD"))
                NumeroPedidosDD = Convert.ToInt32(row["NumeroPedidosDD"]);

            if (DataRecord.HasColumn(row, "TipoProceso"))
                TipoProceso = Convert.ToString(row["TipoProceso"]);

            if (DataRecord.HasColumn(row, "FechaFacturacion"))
                FechaFacturacion = Convert.ToDateTime(row["FechaFacturacion"]);

            if (DataRecord.HasColumn(row, "NroLote"))
                NroLote = Convert.ToInt32(row["NroLote"]);

            if (DataRecord.HasColumn(row, "Desmarcado"))
                Desmarcado = Convert.ToBoolean(row["Desmarcado"]);

            if (DataRecord.HasColumn(row, "FechaProceso"))
                FechaProceso = Convert.ToDateTime(row["FechaProceso"]);

            if (DataRecord.HasColumn(row, "FechaEnvio"))
                FechaEnvio = Convert.ToDateTime(row["FechaEnvio"]);

        }
    }
}
