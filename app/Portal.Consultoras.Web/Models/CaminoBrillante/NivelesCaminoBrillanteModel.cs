using System.Collections.Generic;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Web.Models.CaminoBrillante
{
    [DataContract]
    public class NivelesCaminoBrillanteModel
    {
        [DataMember(Name = "ISOPAIS")]
        public string IsoPais { get; set; }

        [DataMember(Name = "CODIGONIVEL")]
        public string CodigoNivel { get; set; }


        [DataMember(Name = "DESCRIPCIONNIVEL")]
        public string DescripcionNivel { get; set; }


        [DataMember(Name = "MONTOMINIMO")]
        public string MontoMinimo { get; set; }
        [DataMember(Name = "MONTOMAXIMO")]
        public string MontoMaximo { get; set; }
        [DataMember(Name = "BENEFICIO1")]
        public string Beneficio1 { get; set; }
        [DataMember(Name = "BENEFICIO2")]
        public string Beneficio2 { get; set; }
        [DataMember(Name = "BENEFICIO3")]
        public string Beneficio3 { get; set; }
        [DataMember(Name = "BENEFICIO4")]
        public string Beneficio4 { get; set; }
        [DataMember(Name = "BENEFICIO5")]
        public string Beneficio5 { get; set; }

        [DataMember(Name = "URLIMAGEN")]
        public string UrlImagenNivel { get; set; }

        [DataMember(Name = "BENEFICIOSNIVEL")]
        public List<BeneficiosNivelCaminoBrillanteModel> BeneficiosNivel { get; set; }
    }
}