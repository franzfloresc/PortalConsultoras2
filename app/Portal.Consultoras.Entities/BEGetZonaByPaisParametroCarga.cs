using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEGetZonaByPaisParametroCarga
    {
        [DataMember]
        public int ZonaID { get; set; }

        [DataMember]
        public int RegionID { get; set; }

        [DataMember]
        public string Codigo { get; set; }

        [DataMember]
        public string Nombre { get; set; }

        [DataMember]
        public int CantidadDias { get; set; }

        public BEGetZonaByPaisParametroCarga() { }

        public BEGetZonaByPaisParametroCarga(IDataRecord row)
        {
            ZonaID = Convert.ToInt32(row["ZonaID"]);
            RegionID = Convert.ToInt32(row["RegionID"]);
            Codigo = Convert.ToString(row["Codigo"]);
            Nombre = Convert.ToString(row["Nombre"]);
            if (DataRecord.HasColumn(row, "CantidadDias"))
                CantidadDias = Convert.ToInt32(row["CantidadDias"]);
        }

    }
}
