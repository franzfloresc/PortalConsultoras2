using System.Collections.Generic;
using Portal.Consultoras.Web.Models.Common;

namespace Portal.Consultoras.Web.Models.Estrategia
{
    public class UpSellingModel :AuditoriaModel
    {
        public int UpSellingId { get; set; }

        public string CodigoCampana { get; set; }

        public decimal MontoMeta { get; set; }

        public string TextoMeta { get; set; }

        public string TextoMetaSecundario { get; set; }

        public string TextoGanaste { get; set; }

        public string TextoGanasteSecundario { get; set; }

        public bool Activo { get; set; }

        public List<UpSellingRegaloModel> Regalos { get; set; }
    }
}
