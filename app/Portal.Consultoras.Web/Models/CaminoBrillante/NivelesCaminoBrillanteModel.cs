using System.Collections.Generic;
namespace Portal.Consultoras.Web.Models.CaminoBrillante
{
    public class NivelesCaminoBrillanteModel
    {
        public string IsoPais { get; set; }
        public string CodigoNivel { get; set; }
        public string DescripcionNivel { get; set; }
        public string MontoMinimo { get; set; }
        public string MontoMaximo { get; set; }
        public string Beneficio1 { get; set; }
        public string Beneficio2 { get; set; }
        public string Beneficio3 { get; set; }
        public string Beneficio4 { get; set; }
        public string Beneficio5 { get; set; }
        public string UrlImagenNivel { get; set; }
        public List<BeneficiosNivelCaminoBrillanteModel> BeneficiosNivel { get; set; }
    }
}