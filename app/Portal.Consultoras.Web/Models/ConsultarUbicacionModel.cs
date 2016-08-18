using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models
{
    public class ConsultarUbicacionModel
    {
        public List<Tuple<decimal, decimal, string>> Puntos { get; set; }
        public string Vertices { get; set; }

        public int SolicitudPostulanteID { get; set; }

        public string Direccion { get; set; }

        public string NombreRegion { get; set; }

        public string NombreComuna { get; set; }

        public string Region { get; set; }
        public string Zona { get; set; }
        public string Seccion { get; set; }
        public string Territorio { get; set; }

        public ConsultarUbicacionModel()
        {
            Puntos = new List<Tuple<decimal, decimal, string>>();
        }
    }
}