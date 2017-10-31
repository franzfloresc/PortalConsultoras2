using System.Collections.Generic;
using System.Threading.Tasks;
using AutoMapper;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Providers.Interfaces;
using Portal.Consultoras.Web.ServiceUsuario;

namespace Portal.Consultoras.Web.Providers
{
    public class ConfiguracionPaisProvider : IConfiguracionPaisProvider
    {
        public async Task<List<ConfiguracionPaisModel>> ObtenerAsync(BEConfiguracionPais configuracion)
        {
            using (var serviceClient = new UsuarioServiceClient())
            {
                var configuracionPaises = await serviceClient.GetConfiguracionPaisAsync(configuracion);
                if (configuracionPaises == null)
                    return null; //TODO: throw? new?

                return Mapper.Map<IList<ServiceUsuario.BEConfiguracionPais>, List<ConfiguracionPaisModel>>(configuracionPaises);
            }
        }
    }
}
