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

        public List<BECupon> ListarCupones()
        {
            List<BECupon> listaCupones = new List<BECupon>();
            var DACupon = new DACupon();

            using (IDataReader reader = DACupon.ListarCupones())
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