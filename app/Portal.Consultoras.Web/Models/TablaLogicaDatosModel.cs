using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models
{
    public class TablaLogicaDatosModel
    {
        public Int16 TablaLogicaDatosID { get; set; }
        public Int16 TablaLogicaID { get; set; }
        public string Codigo { get; set; }
        public string Descripcion { get; set; }
    }
}