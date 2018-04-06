using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Portal.Consultoras.Web.Models.Common;

namespace Portal.Consultoras.Web.Models.Estrategia
{
    public class UpSellingRegaloModel : AuditoriaModel
    {
        public int UpSellingRegaloId { get; set; }

        public string CUV { get; set; }

        public string Nombre { get; set; }

        public string Descripcion { get; set; }

        public string Imagen { get; set; }

        public int Stock { get; set; }

        public int Orden { get; set; }

        public bool Activo { get; set; }

        public int UpSellingId { get; set; }

        public int StockActual { get; set; }
    }
}
