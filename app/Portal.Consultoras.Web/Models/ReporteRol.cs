using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models
{
    public class ReporteRol
    {
        public string count { get; set; }
        public List<Data> data { get; set; }
        public LastKeyEvaluated lastKeyEvaluated { get; set; }
    }

    public class Data
    {
        public string FechaRegistro { get; set; }
        public string Usuario { get; set; }
        public string Pais { get; set; }
        public string Rol { get; set; }
        public string SolicitudId { get; set; }
        public string Pantalla { get; set; }
        public string Accion { get; set; }
        public string FechaExpiracion { get; set; }
    }

    public class LastKeyEvaluated
    {
        public string Usuario { get; set; }
        public string FechaRegistro { get; set; }
    }
}