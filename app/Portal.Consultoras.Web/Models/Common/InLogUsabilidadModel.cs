using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models.Common
{
    public class InLogUsabilidadModel
    {
        public string Fecha { get; set; }

        /// <summary>
        /// Identificador de Aplicación
        /// </summary>
        public string Aplicacion { get; set; }

      
        /// <summary>
        /// Nombre de Pantalla - Opción
        /// </summary>
        public string PantallaOpcion { get; set; }

        /// <summary>
        /// Nombre de Acción de Opcion de Pantalla
        /// </summary>
        public string OpcionAccion { get; set; }

        /// <summary>
        /// Parámetros extras, Array de { "clave": "valor" }
        /// </summary>

        public Dictionary<string, string> Extra { get; set; }
    }
}