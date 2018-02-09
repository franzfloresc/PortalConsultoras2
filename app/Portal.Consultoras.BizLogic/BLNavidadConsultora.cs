using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System.Collections.Generic;
using System.Data;

namespace Portal.Consultoras.BizLogic
{
    public class BLNavidadConsultora
    {
        public int InsertarNavidadConsultora(BENavidadConsultora entidad)
        {
            var daNavidadConsultora = new DANavidadConsultora(entidad.PaisId);
            var aviso = daNavidadConsultora.InsertarNavidadConsultora(entidad);
            return aviso;
        }

        public void EditarNavidadConsultora(BENavidadConsultora entidad)
        {
            var daNavidadConsultora = new DANavidadConsultora(entidad.PaisId);
            daNavidadConsultora.EditarNavidadConsultora(entidad);
            
        }

        public void EliminarNavidadConsultora(BENavidadConsultora entidad)
        {
            var daNavidadConsultora = new DANavidadConsultora(entidad.PaisId);
            daNavidadConsultora.EliminarNavidadConsultora(entidad);
        }

        public List<BENavidadConsultora> BuscarNavidadConsultora(BENavidadConsultora entidad)
        {
            var daNavidadConsultora = new DANavidadConsultora(entidad.PaisId);
            List<BENavidadConsultora> resultado = new List<BENavidadConsultora>();

            using (IDataReader reader = daNavidadConsultora.BuscarNavidadConsultora(entidad))
                while (reader.Read())
                {
                    resultado.Add(new BENavidadConsultora(reader));
                }
            return resultado;
        }

        public List<BENavidadConsultora> SeleccionarNavidadConsultora(BENavidadConsultora entidad)
        {
            var daNavidadConsultora = new DANavidadConsultora(entidad.PaisId);
            List<BENavidadConsultora> resultado = new List<BENavidadConsultora>();

            using (IDataReader reader = daNavidadConsultora.SeleccionarNavidadConsultora(entidad))
                while (reader.Read())
                {
                    resultado.Add(new BENavidadConsultora(reader));
                }
            return resultado;
        }

    }
}
