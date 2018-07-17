using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BECronogramaFIC
    {
        [DataMember]
        public string Zona { get; set; }
        [DataMember]
        public string Campania { get; set; }
        [DataMember]
        public string CodigoConsultora { get; set; }
        [DataMember]
        public DateTime? FechaFin { get; set; }
        [DataMember]
        public int CampaniaID { get; set; }
        [DataMember]
        public int ZonaID { get; set; }

        public BECronogramaFIC()
        { }

        public BECronogramaFIC(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "FechaFin") && row["FechaFin"].ToString() != "")
                FechaFin = Convert.ToDateTime(row["FechaFin"]);
            else
                FechaFin = null;

            if (DataRecord.HasColumn(row, "ZonaID"))
                ZonaID = Convert.ToInt32(row["ZonaID"]);
            if (DataRecord.HasColumn(row, "CampaniaID"))
                CampaniaID = Convert.ToInt32(row["CampaniaID"]);
            if (DataRecord.HasColumn(row, "CodigoZona"))
                Zona = Convert.ToString(row["CodigoZona"]);
            if (DataRecord.HasColumn(row, "CodigoCampania"))
                Campania = Convert.ToString(row["CodigoCampania"]);
            if (DataRecord.HasColumn(row, "CodigoConsultora"))
                CodigoConsultora = Convert.ToString(row["CodigoConsultora"]);
        }
    }
}
