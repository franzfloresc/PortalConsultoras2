using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEParametro
    {
        [DataMember]
        public int ParametroId { get; set; }
        [DataMember]
        public string Descripcion { get; set; }
        [DataMember]
        public string Abreviatura { get; set; }

        public BEParametro()
        {
        }

        public BEParametro(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "ParametroId") && row["ParametroId"] != DBNull.Value)
                ParametroId = Convert.ToInt32(row["ParametroId"]);
            if (DataRecord.HasColumn(row, "Descripcion") && row["Descripcion"] != DBNull.Value)
                Descripcion = Convert.ToString(row["Descripcion"]);
            if (DataRecord.HasColumn(row, "Abreviatura") && row["Abreviatura"] != DBNull.Value)
                Abreviatura = Convert.ToString(row["Abreviatura"]);
        }
    }
}
