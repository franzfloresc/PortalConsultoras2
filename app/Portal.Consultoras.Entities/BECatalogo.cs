using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BECatalogo
    {
        [DataMember]
        public int CampaniaID { get; set; }
        [DataMember]
        public int MarcaID { get; set; }
        [DataMember]
        public int PaisID { get; set; }
        [DataMember]
        public string Direccion { get; set; }

        public BECatalogo(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "CampaniaID"))
                CampaniaID = Convert.ToInt32(row["CampaniaID"]);
            if (DataRecord.HasColumn(row, "MarcaID"))
                MarcaID = Convert.ToInt16(row["MarcaID"]);
            if (DataRecord.HasColumn(row, "PaisID"))
                PaisID = Convert.ToInt16(row["PaisID"]);
            if (DataRecord.HasColumn(row, "Direccion"))
                Direccion = Convert.ToString(row["Direccion"]);
        }
    }
}
