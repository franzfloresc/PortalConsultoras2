using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;
using Portal.Consultoras.Common;

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
            if (DataRecord.HasColumn(row, "PedidoWebEnProceso"))
                PedidoWebEnProceso = Convert.ToInt32(row["PedidoWebEnProceso"]);
        }
    }
}
