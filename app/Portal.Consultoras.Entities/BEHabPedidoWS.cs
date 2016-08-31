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
    public class BEHabPedidoCabWS
    {
        [DataMember]
        public string CodigoPais { get; set; }
        [DataMember]
        public int Campania { get; set; }
        [DataMember]
        public string CodigoConsultora { get; set; }
        [DataMember]
        public string CodigoZona { get; set; }
        [DataMember]
        public DateTime FechaRegistro { get; set; }
        [DataMember]
        public decimal ImporteTotal { get; set; }
        [DataMember]
        public int PedidoId { get; set; }
        [DataMember]
        public List<BEHabPedidoDetWS> DetallePedido { get; set; }

        public BEHabPedidoCabWS()
        { }

        public BEHabPedidoCabWS(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "CodigoPais"))
                CodigoPais = Convert.ToString(row["CodigoPais"]);
            if (DataRecord.HasColumn(row, "Campania"))
                Campania = Convert.ToInt32(row["Campania"]);
            if (DataRecord.HasColumn(row, "CodigoConsultora"))
                CodigoConsultora = Convert.ToString(row["CodigoConsultora"]);
            if (DataRecord.HasColumn(row, "CodigoZona"))
                CodigoZona = Convert.ToString(row["CodigoZona"]);
            if (DataRecord.HasColumn(row, "FechaRegistro"))
                FechaRegistro = Convert.ToDateTime(row["FechaRegistro"]);
            if (DataRecord.HasColumn(row, "ImporteTotal"))
                ImporteTotal = Convert.ToDecimal(row["ImporteTotal"]);
            if (DataRecord.HasColumn(row, "PedidoId"))
                PedidoId = Convert.ToInt32(row["PedidoId"]);
        }
    }

    [DataContract]
    public class BEHabPedidoDetWS
    {
        [DataMember]
        public string CUV { get; set; }
        [DataMember]
        public int Cantidad { get; set; }

        public BEHabPedidoDetWS()
        { }

        public BEHabPedidoDetWS(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "CUV"))
                CUV = Convert.ToString(row["CUV"]);
            if (DataRecord.HasColumn(row, "Cantidad"))
                Cantidad = Convert.ToInt32(row["Cantidad"]);
        }
    }
}
