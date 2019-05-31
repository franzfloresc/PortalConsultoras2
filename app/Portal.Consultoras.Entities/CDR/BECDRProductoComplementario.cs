using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Entities.CDR
{
    public class BECDRProductoComplementario
    {
        public BECDRProductoComplementario()
        {
            Estado = 1;
        }
        public string CUV { get; set; }
        public string Descripcion { get; set; }
        public int Cantidad { get; set; }
        public int Estado { get; set; }
        public string Simbolo { get; set; }
        public decimal? Precio { get; set; }
        public string PrecioFormato { get; set; }
        public string CodigoMotivoRechazo { get; set; }
        public string Observacion { get; set; }
    }
}
