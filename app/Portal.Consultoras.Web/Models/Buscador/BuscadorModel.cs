using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models.Buscador
{
    public class BuscadorModel
    {
        public string TextoBusqueda { get; set; }
        public int CantidadProductos { get; set; }
        // Agregar en el UserData
        public bool SuscripcionActiva { get; set; }
        public bool MDO { get; set; }
        public bool RD { get; set; }
        public bool RDI { get; set; }
        public bool RDR { get; set; }
        public int DiaFacturacion { get; set; }
    }
}
