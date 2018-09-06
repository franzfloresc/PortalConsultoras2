using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;

namespace Portal.Consultoras.Web.Models.Common
{
    public class InLogUsabilidadModel
    {
        /// <summary>
        /// Fecha en formato long DateTime.Ticks
        /// </summary>
        public string Fecha { get; set; }

        /// <summary>
        /// Identificador de Aplicación
        /// </summary>
        public string Aplicacion { get; set; }

        /// <summary>
        /// Código ISO del País
        /// </summary>
        public string Pais { get; set; }

        /// <summary>
        /// Código de Región
        /// </summary>
        public string Region { get; set; }

        /// <summary>
        /// Código de Zona
        /// </summary>
        public string Zona { get; set; }

        /// <summary>
        /// Código de Sección
        /// </summary>
        public string Seccion { get; set; }

        /// <summary>
        /// Código de Rol
        /// </summary>
        public string Rol { get; set; }

        /// <summary>
        /// Código de Campaña
        /// </summary>
        public string Campania { get; set; }

        /// <summary>
        /// Código de Usuario
        /// </summary>
        public string Usuario { get; set; }

        /// <summary>
        /// Nombre de Pantalla - Opción
        /// </summary>
        public string PantallaOpcion { get; set; }

        /// <summary>
        /// Nombre de Acción de Opcion de Pantalla
        /// </summary>
        public string OpcionAccion { get; set; }

        /// <summary>
        /// Categoría del Dispositivo: WEB, MOBILE
        /// </summary>
        public string DispositivoCategoria { get; set; }

        /// <summary>
        /// Identificador del Dispositivo
        /// </summary>
        public string DispositivoID { get; set; }

        /// <summary>
        /// Numero de la versión de aplicación
        /// </summary>
        public string Version { get; set; }

        /// <summary>
        /// Parámetros extras, Array de { "clave": "valor" }
        /// </summary>
        public Dictionary<string, string> Extra { get; set; }

        [ScriptIgnore]
        public string JwtToken { get; set; }
        [ScriptIgnore]
        public string CodigoConsultora { get; set; }
        [ScriptIgnore]
        public string CodigoISO { get; set; }
    }


}