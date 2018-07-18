using OpenSource.Library.DataAccess;
using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEBelcorpNoticia
    {
        [DataMember]
        public int BelcorpNoticiaID { set; get; }
        [DataMember]
        public int PaisID { set; get; }
        [DataMember]
        public string PaisNombre { set; get; }
        [DataMember]
        public int CampaniaID { set; get; }
        [DataMember]
        public string NombreCorto { set; get; }
        [DataMember]
        public long ConsultoraID { set; get; }
        [DataMember]
        public string Titulo { set; get; }
        [DataMember]
        public string ArchivoPortada { set; get; }
        [DataMember]
        public string UrlPDF { set; get; }

        public BEBelcorpNoticia()
        { }

        public BEBelcorpNoticia(IDataRecord row)
        {
            BelcorpNoticiaID = row.ToInt32("BelcorpNoticiaID");
            PaisID = row.ToInt32("PaisID");
            PaisNombre = row.ToString("Nombre");
            CampaniaID = row.ToInt32("CampaniaID");
            NombreCorto = row.ToString("NombreCorto");
            ConsultoraID = row.ToInt64("ConsultoraID");
            Titulo = row.ToString("Titulo");
            ArchivoPortada = row.ToString("ArchivoPortada");
            UrlPDF = row.ToString("UrlPDF");
        }
    }
}
