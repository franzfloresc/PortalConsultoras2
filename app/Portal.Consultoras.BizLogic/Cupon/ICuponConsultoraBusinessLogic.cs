using System.Collections.Generic;
using Portal.Consultoras.Entities.Cupon;

namespace Portal.Consultoras.BizLogic
{
    public interface ICuponConsultoraBusinessLogic
    {
        void ActualizarCuponConsultora(int paisId, BECuponConsultora cuponConsultora);
        void CrearCuponConsultora(int paisId, BECuponConsultora cuponConsultora);
        BECuponConsultora GetCuponConsultoraByCodigoConsultoraCampaniaId(int paisID, BECuponConsultora cuponConsultora);
        void InsertarCuponConsultorasXML(int paisId, int cuponId, int campaniaId, List<BECuponConsultora> listaCuponConsultoras);
        List<BECuponConsultora> ListarCuponConsultorasPorCupon(int paisId, int cuponId);
        void UpdateCuponConsultoraEnvioCorreo(int paisId, BECuponConsultora cuponConsultora);
        void UpdateCuponConsultoraEstadoCupon(int paisId, BECuponConsultora cuponConsultora);
    }
}