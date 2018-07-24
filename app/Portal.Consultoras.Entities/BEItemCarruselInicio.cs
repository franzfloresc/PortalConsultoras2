using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEItemCarruselInicio
    {
        [DataMember]
        public int ItemCarruselInicioID { get; set; }

        [DataMember]
        public string UrlImagenPrincipal { get; set; }

        [DataMember]
        public string UrlImagenTitulo { get; set; }

        [DataMember]
        public string TextoDescripcion { get; set; }

        [DataMember]
        public string TextoLink { get; set; }

        [DataMember]
        public string UrlLink { get; set; }

        [DataMember]
        public bool EsVideo { get; set; }

        [DataMember]
        public string UrlLinkPrincipal { get; set; }

        [DataMember]
        public bool UrlLinkPrincipalExterno { get; set; }

        [DataMember]
        public string TextoDescripcion2 { get; set; }

        [DataMember]
        public int Orden { get; set; }

        [DataMember]
        public string NombreItem { get; set; }

        public BEItemCarruselInicio() { }
        public BEItemCarruselInicio(IDataRecord row)
        {
            
                ItemCarruselInicioID = row.ToInt32("ItemCarruselInicioID");

            
                UrlImagenPrincipal = row.ToString("UrlImagenPrincipal");

            
                UrlImagenTitulo = row.ToString("UrlImagenTitulo");

            
                TextoDescripcion = row.ToString("TextoDescripcion");

            
                TextoLink = row.ToString("TextoLink");

            
                UrlLink = row.ToString("UrlLink");

            
                EsVideo = row.ToBoolean("EsVideo");

            
                UrlLinkPrincipal = row.ToString("UrlLinkPrincipal");

            
                UrlLinkPrincipalExterno = row.ToBoolean("UrlLinkPrincipalExterno");

            
                TextoDescripcion2 = row.ToString("TextoDescripcion2");

            
                Orden = row.ToInt32("Orden");

            
                NombreItem = row.ToString("NombreItem");
        }
    }
}
