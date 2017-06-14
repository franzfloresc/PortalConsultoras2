using Portal.Consultoras.Data;
using Portal.Consultoras.Entities.Cupon;
using System.Collections.Generic;
using System.Data;

namespace Portal.Consultoras.BizLogic
{
    public class BLCupon
    {
        public void CrearCupon(BECupon cupon)
        {
            var DACupon = new DACupon();
            DACupon.CrearCupon(cupon);
        }

        public void ActualizarCupon(BECupon cupon)
        {
            var DACupon = new DACupon();
            DACupon.ActualizarCupon(cupon);
        }

        public List<BECupon> ListarCuponesPorCampania(int paisId, int campaniaId)
        {
            List<BECupon> listaCupones = new List<BECupon>();
            var DACupon = new DACupon();

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