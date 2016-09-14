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
    public class BEPedidoRechazado
    {
        [DataMember]
        public string Pais { get; set; }
        [DataMember]
        public string Campania { get; set; }
        [DataMember]
        public string CodigoConsultora { get; set; }
        [DataMember]
        public string MotivoRechazo { get; set; }
        [DataMember]
        public string Valor { get; set; }

        public BEPedidoRechazado(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "Pais") && row["Pais"] != DBNull.Value)
                this.Pais = Convert.ToString(row["Pais"]);

            if (DataRecord.HasColumn(row, "Campania") && row["Campania"] != DBNull.Value)
                this.Campania = Convert.ToString(row["Campania"]);

            if (DataRecord.HasColumn(row, "CodigoConsultora") && row["CodigoConsultora"] != DBNull.Value)
                this.CodigoConsultora = Convert.ToString(row["CodigoConsultora"]);

            if (DataRecord.HasColumn(row, "MotivoRechazo") && row["MotivoRechazo"] != DBNull.Value)
                this.MotivoRechazo = Convert.ToString(row["MotivoRechazo"]);

            if (DataRecord.HasColumn(row, "Valor") && row["Valor"] != DBNull.Value)
                this.Valor = Convert.ToString(row["Valor"]);
        }
    }
}
