using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models
{
    public class GestionaPostulanteModel
    {
        public int PrefijoISOPais { get; set; }

        public string FechaDesde { get; set; }

        public string FechaHasta { get; set; }

        public string Nombre { get; set; }

        public int Estado { get; set; }

        public string DocumentoIdentidad { get; set; }

        public string sidx { get; set; }

        public string sord { get; set; }

        public int page { get; set; }

        public int rows { get; set; }
    }
}