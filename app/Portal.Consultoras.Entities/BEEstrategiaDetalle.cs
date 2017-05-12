using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

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
        }
    }
}
