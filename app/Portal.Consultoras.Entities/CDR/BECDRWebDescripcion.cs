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
        public string EntidadSSIC { get; set; }
        [DataMember]
        public string Tipo { get; set; }
        [DataMember]
        public string Descripcion { get; set; }

        public BECDRWebDescripcion()
        { }

        public BECDRWebDescripcion(IDataRecord row)
        {
            if (row.HasColumn("CDRWebDescripcionID")) CDRWebDescripcionID = Convert.ToInt32(row["CDRWebDescripcionID"]);
            if (row.HasColumn("CodigoSSIC")) CodigoSSIC = Convert.ToString(row["CodigoSSIC"]);
            if (row.HasColumn("EntidadSSIC")) EntidadSSIC = Convert.ToString(row["EntidadSSIC"]);
            if (row.HasColumn("Tipo")) Tipo = Convert.ToString(row["Tipo"]);
            if (row.HasColumn("Descripcion")) Descripcion = Convert.ToString(row["Descripcion"]);            
        }
    }
}
