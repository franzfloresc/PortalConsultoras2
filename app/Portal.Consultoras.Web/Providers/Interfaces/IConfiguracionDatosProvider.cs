using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Portal.Consultoras.Web.Models;

namespace Portal.Consultoras.Web.Providers.Interfaces
{
    public interface IConfiguracionDatosProvider
    {
        /// <summary>
        /// Obtiene variables
        /// </summary>
        /// <param name="paisId">Pais Id</param>
        /// <param name="key">Llave de tabla logica</param>
        /// <returns>Lista de variables</returns>
        Task<IEnumerable<ConfiguracionLogicaModel>> ObtenerAsync(int paisId, params short[] keys);
    }
}
