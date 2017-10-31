using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Portal.Consultoras.Web.Models;

namespace Portal.Consultoras.Web.Providers.Interfaces
{
    public interface IConfiguracionPaisProvider
    {
        Task<List<ConfiguracionPaisModel>> ObtenerAsync(ServiceUsuario.BEConfiguracionPais configuracion);
    }
}
