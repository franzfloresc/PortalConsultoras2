using Portal.Consultoras.Data;
using Portal.Consultoras.Entities.Cupon;
using System.Collections.Generic;
using System.Data;

namespace Portal.Consultoras.BizLogic
{
    public class BLCuponConsultora
    {
        public BECuponConsultora GetCuponConsultoraByCodigoConsultoraCampaniaId(int paisID, BECuponConsultora cuponConsultora)
        {
            BECuponConsultora entidad = null;
            var DACuponConsultora = new DACuponConsultora(paisID);

            using (IDataReader reader = DACuponConsultora.GetCuponConsultoraByCodigoConsultoraCampaniaId(cuponConsultora))
                if (reader.Read())
                {
                    entidad = new BECuponConsultora(reader);
                }
            return entidad;
        }

        public void UpdateCuponConsultoraEstadoCupon(int paisId, BECuponConsultora cuponConsultora)
        {
            var DACuponConsultora = new DACuponConsultora(paisId);
            DACuponConsultora.UpdateCuponConsultoraEstadoCupon(cuponConsultora);
        }

        public void UpdateCuponConsultoraEnvioCorreo(int paisId, BECuponConsultora cuponConsultora)
        {
            var DACuponConsultora = new DACuponConsultora(paisId);
            DACuponConsultora.UpdateCuponConsultoraEnvioCorreo(cuponConsultora);
        }

        public void CrearCuponConsultora(int paisId, BECuponConsultora cuponConsultora)
        {
            var DACuponConsultora = new DACuponConsultora(paisId);
            DACuponConsultora.CrearCuponConsultora(cuponConsultora);
        }

        public void ActualizarCuponConsultora(int paisId, BECuponConsultora cuponConsultora)
        {
            var DACuponConsultora = new DACuponConsultora(paisId);
            DACuponConsultora.ActualizarCuponConsultora(cuponConsultora);
        }

        public List<BECuponConsultora> ListarCuponConsultorasPorCupon(int paisId, int cuponId)
        {
            List<BECuponConsultora> listaCuponConsultoras = new List<BECuponConsultora>();
            var DACuponConsultora = new DACuponConsultora(paisId);

            using (IDataReader reader = DACuponConsultora.ListarCuponConsultorasPorCupon(paisId, cuponId))
            {
                while (reader.Read())
                {
                    listaCuponConsultoras.Add(new BECuponConsultora(reader));
                }
            }

            return listaCuponConsultoras;
        }
    }
}
