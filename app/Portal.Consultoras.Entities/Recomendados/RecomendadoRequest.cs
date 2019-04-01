using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Entities.Recomendados
{
    public class RecomendadoRequest
    {
        public string codigoConsultora { get; set; }
        public string codigoZona { get; set; }
        public string cuv { get; set; }
        public List<string> codigoProducto { get; set; }
        public int cantidadProductos { get; set; }
        public string personalizaciones { get; set; }
        public configuracion configuracion { get; set; }
    }

    public class configuracion
    {
        public string sociaEmpresaria { get; set; }
        public string suscripcionActiva { get; set; }
        public string mdo { get; set; }
        public string rd { get; set; }
        public string rdi { get; set; }
        public string rdr { get; set; }
        public int diaFacturacion { get; set; }
        public string mostrarProductoConsultado { get; set; }
    }
}
