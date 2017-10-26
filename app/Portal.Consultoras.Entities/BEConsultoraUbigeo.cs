using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEConsultoraUbigeo
    {
        [DataMember]
        public long ConsultoraID { get; set; }
        [DataMember]
        public string CodigoConsultora { get; set; }
        [DataMember]
        public string CodigoUbigeo { get; set; }
        [DataMember]
        public string NombreCompleto { get; set; }
        [DataMember]
        public string Email { get; set; }

        public BEConsultoraUbigeo(BEConsultora entidad)
        {

            ConsultoraID = entidad.ConsultoraID;
            CodigoConsultora = entidad.Codigo;
            CodigoUbigeo = entidad.CodigoUbigeo;
            NombreCompleto = entidad.NombreCompleto;
            Email = entidad.Email;
        }

    }
}
