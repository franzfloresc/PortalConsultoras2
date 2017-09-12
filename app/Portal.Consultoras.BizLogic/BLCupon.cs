using Portal.Consultoras.Data;
using Portal.Consultoras.Entities.Cupon;
using System.Collections.Generic;
using System.Data;

namespace Portal.Consultoras.BizLogic
{
    public class BLCupon
    {
        public void CrearCupon(int paisId, BECupon cupon)
        {
            var DACupon = new DACupon(paisId);
            DACupon.CrearCupon(cupon);
        }

        public void ActualizarCupon(int paisId, BECupon cupon)
        {
            var DACupon = new DACupon(paisId);
            DACupon.ActualizarCupon(cupon);
        }

        public List<BECupon> ListarCuponesPorCampania(int paisId, int campaniaId)
        {
            List<BECupon> listaCupones = new List<BECupon>();
            var DACupon = new DACupon(paisId);

            using (IDataReader reader = DACupon.ListarCuponesPorCampania(paisId, campaniaId))
            {
                while (reader.Read())
                {
                    listaCupones.Add(new BECupon(reader));
                }
            }

            return listaCupones;
        }
    }
}