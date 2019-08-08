using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Entities.ProlApi.Promocion
{
    public class PromocionResponse
    {
        public string cod_venta_promo { get; set; }
        public string cod_venta { get; set; }
        public string cod_catalogo { get; set; }
        public string pag_catalogo { get; set; }
        public int ind_promocion { get; set; }
        public decimal factor_cuadre { get; set; }
        public string msjError { get; set; }
    }
}
