using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models
{
    public class ConfirmarPosicionModelPrePostulante
    {
       

        public int id { get; set; }
        public decimal latitud { get; set; }
        public decimal longitud { get; set; }
        public string direccioncorrecta { get; set; }
        public string direccioncadena { get; set; }
        public string region { get; set; }
        public string comuna { get; set; }
        public string codregion { get; set; }
        public string codzona { get; set; }
        public string codseccion { get; set; }
        public string codTerritorio { get; set; }
        public string direccion { get; set; }

    }
}