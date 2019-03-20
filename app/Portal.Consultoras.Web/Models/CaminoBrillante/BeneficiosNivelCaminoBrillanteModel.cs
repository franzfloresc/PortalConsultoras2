using System.Runtime.Serialization;
namespace Portal.Consultoras.Web.Models.CaminoBrillante
{
    [DataContract]
    public class BeneficiosNivelCaminoBrillanteModel
    {
        [DataMember]
        public int CodigoBeneficio { get; set; }
        [DataMember]
        public string Titulo { get; set; }
        [DataMember]
        public string Descripcion { get; set; }
        [DataMember]
        public string UrlImagen { get; set; }
    }
}