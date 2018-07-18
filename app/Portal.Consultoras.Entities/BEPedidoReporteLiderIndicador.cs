using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEPedidoReporteLiderIndicador
    {
        [DataMember]
        public int PedidoWebEnProceso { get; set; }

        public BEPedidoReporteLiderIndicador()
        { }

        public BEPedidoReporteLiderIndicador(IDataRecord row)
        {
            PedidoWebEnProceso = row.ToInt32("PedidoWebEnProceso");
        }
    }
}
