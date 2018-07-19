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

            ZonaID = row.ToInt32("ZonaID");
            CampaniaID = row.ToInt32("CampaniaID");
            Zona = row.ToString("CodigoZona");
            Campania = row.ToString("CodigoCampania");
            CodigoConsultora = row.ToString("CodigoConsultora");
        }
    }
}
