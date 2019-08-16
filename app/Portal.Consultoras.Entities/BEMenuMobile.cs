using Portal.Consultoras.Common;
using System.Collections.Generic;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEMenuMobile
    {
        [DataMember]
        public int MenuMobileID { get; set; }

        [DataMember]
        public string Descripcion { get; set; }

        [DataMember]
        public int MenuPadreID { get; set; }

        [DataMember]
        public int OrdenItem { get; set; }

        [DataMember]
        public string UrlItem { get; set; }

        [DataMember]
        public string UrlImagen { get; set; }

        [DataMember]
        public bool PaginaNueva { get; set; }

        [DataMember]
        public string Posicion { get; set; }

        [DataMember]
        public string Version { get; set; }

        [DataMember]
        public string Codigo { get; set; }

        [DataMember]
        public BEMenuExtras Extras { get; set; }

        public BEMenuMobile() { }
        public BEMenuMobile(IDataRecord row)
        {
            MenuMobileID = row.ToInt32("MenuMobileID");
            Descripcion = row.ToString("Descripcion");
            MenuPadreID = row.ToInt32("MenuPadreID");
            OrdenItem = row.ToInt32("OrdenItem");
            UrlItem = row.ToString("UrlItem");
            UrlImagen = row.ToString("UrlImagen");
            PaginaNueva = row.ToBoolean("PaginaNueva");
            Posicion = row.ToString("Posicion");
            Version = row.ToString("Version");
            Codigo = row.ToString("Codigo");            
          
        }
    }

    [DataContract]
    public class BEMenuExtras {
        [DataMember]
        public List<BEMenuTag> Tags { get; set; }
    }

    [DataContract]
    public class BEMenuTag
    {
        [DataMember]
        public string Tag { get; set; }
        [DataMember]
        public int End { get; set; }
    }

}
