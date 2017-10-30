using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEContenidoDato
    {
        [DataMember]
        public int CampaniaID { get; set; }

        [DataMember]
        public int PaisID { get; set; }

        [DataMember]
        public string ImagenFondo { get; set; }

        [DataMember]
        public string ImagenLogo { get; set; }

        public BEContenidoDato(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "CampaniaID"))
                CampaniaID = Convert.ToInt32(row["CampaniaID"]);
            if (DataRecord.HasColumn(row, "PaisID"))
                PaisID = Convert.ToInt32(row["PaisID"]);
            if (DataRecord.HasColumn(row, "ImagenFondo"))
                ImagenFondo = Convert.ToString(row["ImagenFondo"]);
            if (DataRecord.HasColumn(row, "ImagenLogo"))
                ImagenLogo = Convert.ToString(row["ImagenLogo"]);
        }
    }
}
