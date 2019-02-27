using Portal.Consultoras.Common;
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
        public bool FlagIndividual { get; set; }
        [DataMember]
        public string Slogan { get; set; }

        [DataMember]
        public string ImgHomeDesktop { get; set; }
        [DataMember]
        public string ImgFondoDesktop { get; set; }
        [DataMember]
        public string ImgFichaDesktop { get; set; }  // es el sello
        [DataMember]
        public string ImgFichaFondoDesktop { get; set; }
        [DataMember]
        public string UrlVideoDesktop { get; set; }


        [DataMember]
        public string ImgHomeMobile { get; set; }
        [DataMember]
        public string ImgFondoMobile { get; set; }
        [DataMember]
        public string ImgFichaMobile { get; set; } // es el sello
        [DataMember]
        public string ImgFichaFondoMobile { get; set; }
        [DataMember]
        public string UrlVideoMobile { get; set; }
        [DataMember]
        public string ImgFondoApp { get; set; }
        [DataMember]
        public string ColorTextoApp { get; set; }

        public BEEstrategiaDetalle(BEEstrategia estrategia)
        {
            EstrategiaID = estrategia.EstrategiaID;
            FlagIndividual = estrategia.FlagIndividual;
            Slogan = estrategia.Slogan;
            ImgHomeDesktop = estrategia.ImgHomeDesktop;
            ImgFondoDesktop = estrategia.ImgFondoDesktop;
            ImgFichaDesktop = estrategia.ImgFichaDesktop;
            ImgFichaFondoDesktop = estrategia.ImgFichaFondoDesktop;
            UrlVideoDesktop = estrategia.UrlVideoDesktop;
            ImgHomeMobile = estrategia.ImgHomeMobile;
            ImgFondoMobile = estrategia.ImgFondoMobile;
            ImgFichaMobile = estrategia.ImgFichaMobile;
            ImgFichaFondoMobile = estrategia.ImgFichaFondoMobile;
            UrlVideoMobile = estrategia.UrlVideoMobile;
            ImgFondoApp = estrategia.ImgFondoApp;
            ColorTextoApp = estrategia.ColorTextoApp;
        }

        public BEEstrategiaDetalle()
        {
        }

        public BEEstrategiaDetalle(IDataRecord row)
        {
            EstrategiaID = DataRecord.GetColumn<int>(row, "EstrategiaID");
            FlagIndividual = DataRecord.GetColumn<bool>(row, "FlagIndividual");
            Slogan = DataRecord.GetColumn<string>(row, "Slogan");
            ImgHomeDesktop = DataRecord.GetColumn<string>(row, "ImgHomeDesktop");
            ImgFondoDesktop = DataRecord.GetColumn<string>(row, "ImgFondoDesktop");
            ImgFichaDesktop = DataRecord.GetColumn<string>(row, "ImgFichaDesktop");
            ImgFichaFondoDesktop = DataRecord.GetColumn<string>(row, "ImgFichaFondoDesktop");
            UrlVideoDesktop = DataRecord.GetColumn<string>(row, "UrlVideoDesktop");
            ImgHomeMobile = DataRecord.GetColumn<string>(row, "ImgHomeMobile");
            ImgFondoMobile = DataRecord.GetColumn<string>(row, "ImgFondoMobile");
            ImgFichaMobile = DataRecord.GetColumn<string>(row, "ImgFichaMobile");
            ImgFichaFondoMobile = DataRecord.GetColumn<string>(row, "ImgFichaFondoMobile");
            UrlVideoMobile = DataRecord.GetColumn<string>(row, "UrlVideoMobile");
            ImgFondoApp = DataRecord.GetColumn<string>(row, "ImgFondoApp");
            ColorTextoApp = DataRecord.GetColumn<string>(row, "ColorTextoApp");
        }
    }
}
