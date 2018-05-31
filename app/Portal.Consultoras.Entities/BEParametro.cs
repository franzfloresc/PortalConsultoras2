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
            if (DataRecord.HasColumn(row, "ParametroId"))
                ParametroId = Convert.ToInt32(row["ParametroId"]);
            if (DataRecord.HasColumn(row, "Descripcion"))
                Descripcion = Convert.ToString(row["Descripcion"]);
            if (DataRecord.HasColumn(row, "Abreviatura"))
                Abreviatura = Convert.ToString(row["Abreviatura"]);
        }
    }
}
