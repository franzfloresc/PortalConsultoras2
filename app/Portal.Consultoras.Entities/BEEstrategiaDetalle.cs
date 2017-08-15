using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEEstrategiaDetalle
    {
        [DataMember]
        public int EstrategiaID { get; set; }
        [DataMember]
        public string ImgFondoDesktop { get; set; }
        [DataMember]
        public string ImgPrevDesktop { get; set; }
        [DataMember]
        public string ImgFichaDesktop { get; set; }
        [DataMember]
        public string UrlVideoDesktop { get; set; }
        [DataMember]
        public string ImgFondoMobile { get; set; }
        [DataMember]
        public string ImgFichaMobile { get; set; }
        [DataMember]
        public string UrlVideoMobile { get; set; }
        [DataMember]
        public string ImgFichaFondoDesktop { get; set; }
        [DataMember]
        public string ImgFichaFondoMobile { get; set; }
        [DataMember]
        public string ImgHomeDesktop { get; set; }
        [DataMember]
        public string ImgHomeMobile { get; set; }

        public BEEstrategiaDetalle(BEEstrategia estrategia)
        {
            EstrategiaID = estrategia.EstrategiaID;
            ImgFondoDesktop = estrategia.ImgFondoDesktop;
            ImgPrevDesktop = estrategia.ImgPrevDesktop;
            ImgFichaDesktop = estrategia.ImgFichaDesktop;
            UrlVideoDesktop = estrategia.UrlVideoDesktop;
            ImgFondoMobile = estrategia.ImgFondoMobile;
            ImgFichaMobile = estrategia.ImgFichaMobile;
            UrlVideoMobile = estrategia.UrlVideoMobile;
            ImgFichaFondoDesktop = estrategia.ImgFichaFondoDesktop;
            ImgFichaFondoMobile = estrategia.ImgFichaFondoMobile;
            ImgHomeDesktop = estrategia.ImgHomeDesktop;
            ImgHomeMobile = estrategia.ImgHomeMobile;
        }

        public BEEstrategiaDetalle()
        {
        }

        public BEEstrategiaDetalle(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "EstrategiaID") && row["EstrategiaID"] != DBNull.Value)
                EstrategiaID = Convert.ToInt32(row["EstrategiaID"]);
            if (DataRecord.HasColumn(row, "ImgFondoDesktop") && row["ImgFondoDesktop"] != DBNull.Value)
                ImgFondoDesktop = row["ImgFondoDesktop"].ToString();
            if (DataRecord.HasColumn(row, "ImgPrevDesktop") && row["ImgPrevDesktop"] != DBNull.Value)
                ImgPrevDesktop = row["ImgPrevDesktop"].ToString();
            if (DataRecord.HasColumn(row, "ImgFichaDesktop") && row["ImgFichaDesktop"] != DBNull.Value)
                ImgFichaDesktop = row["ImgFichaDesktop"].ToString();
            if (DataRecord.HasColumn(row, "UrlVideoDesktop") && row["UrlVideoDesktop"] != DBNull.Value)
                UrlVideoDesktop = row["UrlVideoDesktop"].ToString();
            if (DataRecord.HasColumn(row, "ImgFondoMobile") && row["ImgFondoMobile"] != DBNull.Value)
                ImgFondoMobile = row["ImgFondoMobile"].ToString();
            if (DataRecord.HasColumn(row, "ImgFichaMobile") && row["ImgFichaMobile"] != DBNull.Value)
                ImgFichaMobile = row["ImgFichaMobile"].ToString();
            if (DataRecord.HasColumn(row, "UrlVideoMobile") && row["UrlVideoMobile"] != DBNull.Value)
                UrlVideoMobile = row["UrlVideoMobile"].ToString();
            if (DataRecord.HasColumn(row, "ImgFichaFondoDesktop") && row["ImgFichaFondoDesktop"] != DBNull.Value)
                ImgFichaFondoDesktop = row["ImgFichaFondoDesktop"].ToString();
            if (DataRecord.HasColumn(row, "ImgFichaFondoMobile") && row["ImgFichaFondoMobile"] != DBNull.Value)
                ImgFichaFondoMobile = row["ImgFichaFondoMobile"].ToString();
            if (DataRecord.HasColumn(row, "ImgHomeDesktop") && row["ImgHomeDesktop"] != DBNull.Value)
                ImgHomeDesktop = row["ImgHomeDesktop"].ToString();
            if (DataRecord.HasColumn(row, "ImgHomeMobile") && row["ImgHomeMobile"] != DBNull.Value)
                ImgHomeMobile = row["ImgHomeMobile"].ToString();

        }
    }
}
