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
            CampaniaID = DbConvert.ToInt32(row["CampaniaID"]);
            GrupoBannerID = Convert.ToInt32(row["GrupoBannerID"]);
            TiempoRotacion = DbConvert.ToInt32(row["TiempoRotacion"]);
            Nombre = row["Nombre"].ToString();
            Dimension = row["Dimension"].ToString();
            Ancho = DbConvert.ToInt32(row["Ancho"]);
            Alto = DbConvert.ToInt32(row["Alto"]);
            if (DataRecord.HasColumn(row, "DimensionEsika"))
                DimensionEsika = row["DimensionEsika"].ToString();
            if (DataRecord.HasColumn(row, "DimensionEsika"))
                AnchoEsika = DbConvert.ToInt32(row["AnchoEsika"]);
            if (DataRecord.HasColumn(row, "DimensionEsika"))
                AltoEsika = DbConvert.ToInt32(row["AltoEsika"]);

            Consultoras = new BEGrupoConsultora[0];
        }
    }
}