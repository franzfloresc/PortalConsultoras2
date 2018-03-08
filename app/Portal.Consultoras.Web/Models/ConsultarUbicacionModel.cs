using System;
using System.Collections.Generic;

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
        public bool ZonaPreferencial { get; set; }
        public string DireccionCadena { get; set; }
        public decimal? Latitud { get; set; }
        public decimal? Longitud { get; set; }
        public string FuenteIngreso { get; set; }
        public string SeccionOrigen { get; set; }
        public string ZonaOrigen { get; set; }

        public string NombreCompleto { get; set; }
        public string Celular { get; set; }
        public string ZonaSeccionRechazo { get; set; }
        public EditarDireccionModel EditarDireccionModel { get; set; }

        public ConsultarUbicacionModel()
        {
            Puntos = new List<Tuple<decimal, decimal, string>>();
            EditarDireccionModel = new EditarDireccionModel();
        }
    }
}