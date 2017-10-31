using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Web.Models
{
    public class ConfiguracionLogicaModel
    {
        public short TablaLogicaDatosID { get; set; }

        public short TablaLogicaID { get; set; }

        public string Codigo { get; set; }

        /// <summary>
        /// Descripcion
        /// </summary>
        public string Valor { get; set; }
    }
}
