using OpenSource.Library.DataAccess;
using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEFeErratas
    {
        [DataMember]
        public int FeErratasID { set; get; }
        [DataMember]
        public int PaisID { set; get; }
        [DataMember]
        public string PaisNombre { set; get; }
        [DataMember]
        public int CampaniaID { set; get; }
        [DataMember]
        public string NombreCorto { set; get; }
        [DataMember]
        public string Titulo { set; get; }
        [DataMember]
        public int Pagina { set; get; }
        [DataMember]
        public string Dice { set; get; }
        [DataMember]
        public string DebeDecir { set; get; }

        public BEFeErratas()
        { }

        public BEFeErratas(IDataRecord row)
        {
            FeErratasID = row.ToInt32("FeErratasID");
            PaisID = row.ToInt32("PaisID");
            PaisNombre = row.ToString("PaisNombre");
            CampaniaID = row.ToInt32("CampaniaID");
            NombreCorto = row.ToString("NombreCorto");
            Titulo = row.ToString("Titulo", string.Empty);
            Pagina = row.ToInt32("Pagina");
            Dice = row.ToString("Dice");
            DebeDecir = row.ToString("DebeDecir");
        }
    }
}
