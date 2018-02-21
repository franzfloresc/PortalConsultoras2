using Portal.Consultoras.Entities;
using System.Collections.Generic;

namespace Portal.Consultoras.BizLogic
{
    public interface IComunicadoBusinessLogic
    {
        BEComunicado GetComunicadoByConsultora(int paisID, string CodigoConsultora);
        void InsertarComunicadoVisualizado(int PaisID, string CodigoConsultora, int ComunicadoID);
        void InsertarDonacionConsultora(int PaisId, string CodigoISO, string CodigoConsultora, string Campania, string IPUsuario);
        List<BEComunicado> ObtenerComunicadoPorConsultora(int paisID, string CodigoConsultora, short TipoDispositivo, string CodigoRegion, string CodigoZona, int IdEstadoActividad);
        void UpdComunicadoByConsultora(int paisID, string CodigoConsultora);
    }
}