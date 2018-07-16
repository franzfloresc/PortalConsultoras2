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

            if (DataRecord.HasColumn(row, "CampaniaID")) CampaniaID = Convert.ToInt32(row["CampaniaID"]);
            if (DataRecord.HasColumn(row, "GrupoBannerID")) GrupoBannerID = Convert.ToInt32(row["GrupoBannerID"]);
            if (DataRecord.HasColumn(row, "TiempoRotacion")) TiempoRotacion = Convert.ToInt32(row["TiempoRotacion"]);
            if (DataRecord.HasColumn(row, "Ancho")) Ancho = Convert.ToInt32(row["Ancho"]);
            if (DataRecord.HasColumn(row, "Alto")) Alto = Convert.ToInt32(row["Alto"]);
            if (DataRecord.HasColumn(row, "DimensionEsika")) DimensionEsika = Convert.ToString(row["DimensionEsika"]);
            if (DataRecord.HasColumn(row, "DimensionEsika")) AnchoEsika = DbConvert.ToInt32(row["AnchoEsika"]);
            if (DataRecord.HasColumn(row, "DimensionEsika")) AltoEsika = DbConvert.ToInt32(row["AltoEsika"]);

            Consultoras = new BEGrupoConsultora[0];
        }
    }
}
