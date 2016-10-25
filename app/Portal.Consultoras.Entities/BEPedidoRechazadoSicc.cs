using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEPedidoRechazadoSicc
    {
        [DataMember]
        public string Campania { get; set; }
        [DataMember]
        public string CodigoConsultora { get; set; }
        [DataMember]
        public string MotivoRechazo { get; set; }
        [DataMember]
        public string Valor { get; set; }

        public BEPedidoRechazadoSicc(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "Campania"))
                Campania = Convert.ToString(row["Campania"]);
            if (DataRecord.HasColumn(row, "CodigoConsultora"))
                CodigoConsultora = Convert.ToString(row["CodigoConsultora"]);
            if (DataRecord.HasColumn(row, "MotivoRechazo"))
                MotivoRechazo = Convert.ToString(row["MotivoRechazo"]);
            if (DataRecord.HasColumn(row, "Valor"))
                Valor = Convert.ToString(row["Valor"]);
        }
    }
}
