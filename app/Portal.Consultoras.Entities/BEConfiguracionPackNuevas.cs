using System;
using System.Data;
using System.Runtime.Serialization;
using OpenSource.Library.DataAccess;
using Portal.Consultoras.Common;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEConfiguracionPackNuevas
    {
        [DataMember]
        public int ConfiguracionPackID { get; set; }
        [DataMember]
        public string CodigoPrograma { get; set; }
        [DataMember]
        public string PedidoAsociado { get; set; }

        public BEConfiguracionPackNuevas(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "CodigoPrograma") && row["CodigoPrograma"] != DBNull.Value)
                CodigoPrograma = DbConvert.ToString(row["CodigoPrograma"]);
            if (DataRecord.HasColumn(row, "PedidoAsociado") && row["PedidoAsociado"] != DBNull.Value)
                PedidoAsociado = DbConvert.ToString(row["PedidoAsociado"]);
        }
    }

}
