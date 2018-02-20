using System.Collections.Generic;
using System.Threading.Tasks;
using AutoMapper;
using Portal.Consultoras.Web.Models.Estrategia;
using Portal.Consultoras.Web.ServiceSAC;

namespace Portal.Consultoras.Web.Providers
{
    public class UpSellingProvider
    {
        public async Task<IEnumerable<UpSellingModel>> ObtenerAsync(int paisId, string codigoCampana, bool incluirRegalos = false)
        {
            using (var sv = new SACServiceClient())
            {
                var upSellings = await sv.UpSellingObtenerAsync(paisId, codigoCampana, incluirRegalos);
                return Mapper.Map<IList<UpSelling>, IEnumerable<UpSellingModel>>(upSellings);
            }
        }

        public async Task<IEnumerable<UpSellingRegaloModel>> ObtenerRegalos(int paisId, int upSellingId)
        {
            using (var sv = new SACServiceClient())
            {
                var upSellings = await sv.UpSellingDetallesObtenerAsync(paisId, upSellingId);
                return Mapper.Map<IList<UpSellingDetalle>, IEnumerable<UpSellingRegaloModel>>(upSellings);
            }
        }
    }
}
