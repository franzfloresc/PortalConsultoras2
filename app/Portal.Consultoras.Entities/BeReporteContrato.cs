using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Entities
{
    public class BeReporteContrato
    {
        public int Registro { get; set; }
        public string CodigoConsultora { get; set; }
        public string NombreConsultora { get; set; }
        public string AceptoContrato { get; set; }
        public string FechaAceptacion { get; set; }
        public string Origen { get; set; }
        public string DireccionIP { get; set; }
        public string InformacionSOMobile { get; set; }
    }
}
