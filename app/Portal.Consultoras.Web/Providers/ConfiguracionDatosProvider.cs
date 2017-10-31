using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AutoMapper;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Providers.Interfaces;
using Portal.Consultoras.Web.ServiceSAC;

namespace Portal.Consultoras.Web.Providersx
{
    public class ConfiguracionDatosProvider : IConfiguracionDatosProvider
    {
        public async Task<IEnumerable<ConfiguracionLogicaModel>> ObtenerAsync(int paisId, params short[] keys)
        {
            var datos = new List<ConfiguracionLogicaModel>();
            foreach (var key in keys)
            {
                var dato = await ObtenerConfiguracionAppAsync(paisId, key);
                if (dato != null)
                    datos = datos.Concat(dato).ToList();
            }

            return datos;
        }

        private async Task<IEnumerable<ConfiguracionLogicaModel>> ObtenerConfiguracionAppAsync(int paisId, short key)
        {
            using (var cliente = new SACServiceClient())
            {
                var datos = await cliente.GetTablaLogicaDatosAsync(paisId, key);
                if (datos == null)
                    return new List<ConfiguracionLogicaModel>();

                var mapped = Mapper.Map<IEnumerable<BETablaLogicaDatos>, List<ConfiguracionLogicaModel>>(datos);

                return mapped ?? new List<ConfiguracionLogicaModel>();
            }
        }
    }
}
