using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Entities
{
    public class BELogActualizaciones
    {
        /// <summary>
        /// Fecha en formato ISO8601DateFormat
        /// </summary>
        public string FechaRegistro { get; set; }

        /// <summary>
        /// Código de Usuario
        /// </summary>
        public string Usuario { get; set; }

        /// <summary>
        /// Codigo de consultora
        /// </summary>
        public string CodigoConsultora { get; set; }

        /// <summary>
        /// Nombre del campo que se modifica
        /// </summary>
        public string CampoModificacion { get; set; }

        /// <summary>
        /// Valor actual o nuevo para el campomodificacion
        /// </summary>
        public string ValorActual { get; set; }

        /// <summary>
        /// Valor anterior para el campomodificacion
        /// </summary>
        public string ValorAnterior { get; set; }

        /// <summary>
        /// Nombre de Pantalla donde solicita la actualizacion
        /// </summary>
        public string Origen { get; set; }

        /// <summary>
        /// Identificador de Aplicación
        /// </summary>
        public string Aplicacion { get; set; }

        /// <summary>
        /// Código ISO del País
        /// </summary>
        public string Pais { get; set; }

        /// <summary>
        /// Código de Rol
        /// </summary>
        public string Rol { get; set; }

        /// <summary>
        /// Categoría del Dispositivo: WEB, MOBILE
        /// </summary>
        public string Dispositivo { get; set; }

        /// <summary>
        /// Indica la acción que se realizó
        /// M => Modificaciones
        /// C => Consultas
        /// </summary>
        public string Accion { get; set; }

        /// <summary>
        /// El Codigo de consultora consultado por el UsuarioLogueado
        /// </summary>
        public string UsuarioConsultado { get; set; }

        /// <summary>
        /// Parámetros extras, Array de { "clave": "valor" }
        /// </summary>
        public Dictionary<string, string> Extra { get; set; }

    }
}
