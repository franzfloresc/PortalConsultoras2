using System.Collections.Generic;
using System.Linq;
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

        public IEnumerable<CampaniaModel> GetCampanias(int paisId, bool addSeleccionar = false)
        {
            IList<BECampania> lst = GetCampaniasEntidad(paisId, addSeleccionar);

            return Mapper.Map<IList<BECampania>, IEnumerable<CampaniaModel>>(lst);
        }

        public List<BECampania> GetCampaniasEntidad(int paisId, bool addSeleccionar = false)
        {
            List<BECampania> lst;
            using (var zs = new ZonificacionServiceClient())
            {
                lst = zs.SelectCampanias(paisId).ToList();
            }

            if (addSeleccionar)
            {
                lst.Insert(0, new BECampania() { CampaniaID = 0, Codigo = "-- Seleccionar --" });
            }

            return lst;
        }
    }
}
