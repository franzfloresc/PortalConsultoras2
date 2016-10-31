using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.CDR
{
    public class BECDRWebDescripcion
    {
        [DataMember]
        public int CDRWebDescripcionID { get; set; }
        [DataMember]
        public string CodigoSSIC { get; set; }
        [DataMember]
        public string Tipo { get; set; }
        [DataMember]
        public string Descripcion { get; set; }

        public BECDRWebDescripcion()
        { }

        public BECDRWebDescripcion(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "CDRWebDescripcionID")) CDRWebDescripcionID = Convert.ToInt32(row["CDRWebDescripcionID"]);
            if (DataRecord.HasColumn(row, "CodigoSSIC")) CodigoSSIC = Convert.ToString(row["CodigoSSIC"]);
            if (DataRecord.HasColumn(row, "Tipo")) Tipo = Convert.ToString(row["Tipo"]);
            if (DataRecord.HasColumn(row, "Descripcion")) Descripcion = Convert.ToString(row["Descripcion"]);
        }
    }
}
