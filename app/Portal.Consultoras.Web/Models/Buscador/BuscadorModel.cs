using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models.Buscador
{
    public class BuscadorModel
    {
        public UsuarioModel userData { get; set; }
        public RevistaDigitalModel revistaDigital { get; set; }
        public string TextoBusqueda { get; set; }
        public int CantidadProductos { get; set; }
    }
}
