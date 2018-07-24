using Portal.Consultoras.Common;
using System;
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

        public BEMenuMobile() { }
        public BEMenuMobile(IDataRecord row)
        {
            MenuMobileID = Convert.ToInt32(row["MenuMobileID"]);
            Descripcion = Convert.ToString(row["Descripcion"]);
            MenuPadreID = Convert.ToInt32(row["MenuPadreID"]);
            OrdenItem = Convert.ToInt32(row["OrdenItem"]);
            UrlItem = row.ToString("UrlItem");
            UrlImagen = row.ToString("UrlImagen");
            PaginaNueva = Convert.ToBoolean(row["PaginaNueva"]);
            Posicion = Convert.ToString(row["Posicion"]);
            Version = Convert.ToString(row["Version"]);
            Codigo = row.ToString("Codigo");
        }
    }
}
