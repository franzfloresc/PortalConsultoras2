using System.Collections.Generic;
using System.Threading.Tasks;
using AutoMapper;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceZonificacion;

namespace Portal.Consultoras.Web.Providers
{
    public class ZonificacionProvider
    {
        public async Task<IEnumerable<CampaniaModel>> ObtenerCampanias(int paisId)
        {
            IList<BECampania> campanias;
            using (var sv = new ZonificacionServiceClient())
            {
                campanias = await sv.SelectCampaniasAsync(paisId);
            }

            return Mapper.Map<IList<BECampania>, IEnumerable<CampaniaModel>>(campanias);
        }
    }
}
