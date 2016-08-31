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
            var _DANavidadConsultora = new DANavidadConsultora(entidad.PaisId);
            var aviso = _DANavidadConsultora.InsertarNavidadConsultora(entidad);
            return aviso;
        }

        public void EditarNavidadConsultora(BENavidadConsultora entidad)
        {
            var _DANavidadConsultora = new DANavidadConsultora(entidad.PaisId);
            _DANavidadConsultora.EditarNavidadConsultora(entidad);
            
        }

        public void EliminarNavidadConsultora(BENavidadConsultora entidad)
        {
            var _DANavidadConsultora = new DANavidadConsultora(entidad.PaisId);
            _DANavidadConsultora.EliminarNavidadConsultora(entidad);
        }

        public List<BENavidadConsultora> BuscarNavidadConsultora(BENavidadConsultora entidad)
        {
            var _DANavidadConsultora = new DANavidadConsultora(entidad.PaisId);
            List<BENavidadConsultora> resultado = new List<BENavidadConsultora>();

            using (IDataReader reader = _DANavidadConsultora.BuscarNavidadConsultora(entidad))
                while (reader.Read())
                {
                    resultado.Add(new BENavidadConsultora(reader));
                }
            return resultado;
        }

        public List<BENavidadConsultora> SeleccionarNavidadConsultora(BENavidadConsultora entidad)
        {
            var _DANavidadConsultora = new DANavidadConsultora(entidad.PaisId);
            List<BENavidadConsultora> resultado = new List<BENavidadConsultora>();

            using (IDataReader reader = _DANavidadConsultora.SeleccionarNavidadConsultora(entidad))
                while (reader.Read())
                {
                    resultado.Add(new BENavidadConsultora(reader));
                }
            return resultado;
        }

    }
}
