using OpenSource.Library.DataAccess;
using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEGrupoBanner
    {
        [DataMember]
        public int CampaniaID { get; set; }

        [DataMember]
        public int GrupoBannerID { get; set; }

        [DataMember]
        public int TiempoRotacion { get; set; }

        [DataMember]
        public BEGrupoConsultora[] Consultoras { get; set; }

        [DataMember]
        public string Nombre { get; set; }

        [DataMember]
        public string Dimension { get; set; }

        [DataMember]
        public int Ancho { get; set; }

        [DataMember]
        public int Alto { get; set; }

        [DataMember]
        public string DimensionEsika { get; set; }

        [DataMember]
        public int AnchoEsika { get; set; }

        [DataMember]
        public int AltoEsika { get; set; }


        public BEGrupoBanner()
        {
            Consultoras = new BEGrupoConsultora[0];
        }

        public BEGrupoBanner(IDataRecord row)
        {
            Nombre = Convert.ToString(row["Nombre"]);
            Dimension = Convert.ToString(row["Dimension"]);
            CampaniaID = row.ToInt32("CampaniaID");
            GrupoBannerID = row.ToInt32("GrupoBannerID");
            TiempoRotacion = row.ToInt32("TiempoRotacion");
            Ancho = row.ToInt32("Ancho");
            Alto = row.ToInt32("Alto");
            if (DataRecord.HasColumn(row, "DimensionEsika")) DimensionEsika = Convert.ToString(row["DimensionEsika"]);
            if (DataRecord.HasColumn(row, "DimensionEsika")) AnchoEsika = DbConvert.ToInt32(row["AnchoEsika"]);
            if (DataRecord.HasColumn(row, "DimensionEsika")) AltoEsika = DbConvert.ToInt32(row["AltoEsika"]);
            Consultoras = new BEGrupoConsultora[0];
        }
    }
}
