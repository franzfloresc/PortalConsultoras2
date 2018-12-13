using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AutoMapper;
using Portal.Consultoras.Common;
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

        public IEnumerable<PaisModel> GetPaises(int paisId, int rolId)
        {
            List<BEPais> lst;
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                lst = rolId == Constantes.Rol.Administrador
                    ? sv.SelectPaises().ToList()
                    : new List<BEPais> { sv.SelectPais(paisId) };
            }
            return Mapper.Map<IList<BEPais>, IEnumerable<PaisModel>>(lst);
        }

        public List<BEPais> GetPaisesEntidad()
        {
            List<BEPais> lst;
            using (var sv = new ZonificacionServiceClient())
            {
                lst = sv.SelectPaises().ToList();
            }
            return lst;
        }

        public BEPais GetPaisEntidad(int paisId)
        {
            List<BEPais> lst = GetPaisesEntidad();
            BEPais entidad = lst.FirstOrDefault(x => x.PaisID == paisId) ?? new BEPais();
            return entidad;
        }
    }
}
