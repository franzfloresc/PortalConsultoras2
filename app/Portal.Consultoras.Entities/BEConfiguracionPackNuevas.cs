using OpenSource.Library.DataAccess;
using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

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
            if (DataRecord.HasColumn(row, "CodigoPrograma"))
                CodigoPrograma = Convert.ToString(row["CodigoPrograma"]);
            if (DataRecord.HasColumn(row, "PedidoAsociado"))
                PedidoAsociado = Convert.ToString(row["PedidoAsociado"]);
        }
    }

}
