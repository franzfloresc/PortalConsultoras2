using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models
{
    public class PaisModel
    {
        public int PaisID { get; set; }
        public string CodigoISO { get; set; }
        public string Nombre { get; set; }
        public string NombreCorto { get; set; }
        public string NombreInterno { get; set; }
    }
}