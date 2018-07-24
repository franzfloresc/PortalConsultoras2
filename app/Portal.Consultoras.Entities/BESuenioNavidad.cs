using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BESuenioNavidad
    {
        [DataMember]
        public int PaisID { get; set; }
        [DataMember]
        public int ConsultoraID { get; set; }
        [DataMember]
        public int CampaniaID { get; set; }
        [DataMember]
        public string Region { get; set; }
        [DataMember]
        public string Zona { get; set; }
        [DataMember]
        public string Seccion { get; set; }
        [DataMember]
        public string CodigoConsultora { get; set; }
        [DataMember]
        public string NombreCompleto { get; set; }
        [DataMember]
        public string Descripcion { get; set; }
        [DataMember]
        public string Canal { get; set; }
        [DataMember]
        public string UsuarioCreacion { get; set; }

        public BESuenioNavidad(IDataRecord row)
        {
            CampaniaID = row.ToInt32("CampaniaID");
            Region = row.ToString("Region");
            Zona = row.ToString("Zona");
            Seccion = row.ToString("Seccion");
            CodigoConsultora = row.ToString("CodigoConsultora");
            NombreCompleto = row.ToString("NombreCompleto");
            Descripcion = row.ToString("Descripcion");
            Canal = row.ToString("Canal");
        }

    }
}
