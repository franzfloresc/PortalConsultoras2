using System.Collections.Generic;
using Portal.Consultoras.Web.Models.Common;

namespace Portal.Consultoras.Web.Models.Estrategia
{
    public partial class UpSellingModel :AuditoriaModel
    {
        public UpSellingModel()
        {
            Regalos = new List<UpSellingRegaloModel>();
        }

        public int UpSellingId { get; set; }

        public string CodigoCampana { get; set; }
        
        public string TextoMetaPrincipal { get; set; }

        public string TextoInferior { get; set; }

        public string TextoGanastePrincipal { get; set; }

        public string TextoGanasteBoton { get; set; }

        public string TextoGanastePremio { get; set; }

        public string ImagenFondoPrincipalDesktop { get; set; }

        public string ImagenFondoPrincipalMobile { get; set; }

        public string ImagenFondoGanasteMobile { get; set; }

        public bool Activo { get; set; }

        public List<UpSellingRegaloModel> Regalos { get; set; }
    }
}
