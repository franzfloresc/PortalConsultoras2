using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using AutoMapper;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceZonificacion;

namespace Portal.Consultoras.Web.Providers
{
    public class ZonificacionProvider
    {
        public IEnumerable<CampaniaModel> ObtenerCampanias(int paisId)
        {
            IList<BECampania> campanias;
            using (var sv = new ZonificacionServiceClient())
            {
                campanias = sv.SelectCampanias(paisId);
            }

            return Mapper.Map<IList<BECampania>, IEnumerable<CampaniaModel>>(campanias);
        }
    }
}
