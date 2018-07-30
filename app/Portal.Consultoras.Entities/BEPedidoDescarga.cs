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
            FechaHoraInicio = row.ToDateTime("FechaHoraInicio");
            FechaHoraFin = row.ToDateTime("FechaHoraFin");
            Estado = row.ToString("Estado");
            Mensaje = row.ToString("Mensaje");
            NumeroPedidosWeb = row.ToInt32("NumeroPedidosWeb");
            NumeroPedidosDD = row.ToInt32("NumeroPedidosDD");
            TipoProceso = row.ToString("TipoProceso");
            FechaFacturacion = row.ToDateTime("FechaFacturacion");
            NroLote = row.ToInt32("NroLote");
            Desmarcado = row.ToBoolean("Desmarcado");
            FechaProceso = row.ToDateTime("FechaProceso");
            FechaEnvio = row.ToDateTime("FechaEnvio");
        }
    }
}
