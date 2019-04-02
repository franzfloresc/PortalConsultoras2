using System;
using System.Collections.Generic;
using System.Runtime.Serialization;
namespace Portal.Consultoras.Web.Models.CaminoBrillante
{
    [Serializable()]
    [DataContract]
    public class NivelesCaminoBrillanteModel
    {
        [DataMember]
        public string IsoPais { get; set; }
        [DataMember]
        public string CodigoNivel { get; set; }
        [DataMember]
        public string DescripcionNivel { get; set; }
        [DataMember]
        public string MontoMinimo { get; set; }
        [DataMember]
        public string MontoMaximo { get; set; }
        [DataMember]
        public string Beneficio1 { get; set; }
        [DataMember]
        public string Beneficio2 { get; set; }
        [DataMember]
        public string Beneficio3 { get; set; }
        [DataMember]
        public string Beneficio4 { get; set; }
        [DataMember]
        public string Beneficio5 { get; set; }
        [DataMember]
        public string UrlImagenNivel { get; set; }
        [DataMember]
        public List<BeneficiosNivelCaminoBrillanteModel> BeneficiosNivel { get; set; }
    }
}