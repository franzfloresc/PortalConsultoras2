using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.ProgramaNuevas;
using System.Collections.Generic;

namespace Portal.Consultoras.BizLogic
{
    public interface IConsultoraConcursoBusinessLogic
    {
        void ActualizarInsertarPuntosConcurso(int PaisID, string CodigoConsultora, string CodigoCampania, string CodigoConcursos, string PuntosConcurso, string PuntosExigidosConcurso);
        List<BEConsultoraConcurso> ListConcursosByCampania(int paisID, string codigoCampaniaActual, string codigoCampania, string tipoConcurso, string codigoConsultora);
        List<BEConsultoraConcurso> ListConcursosVigentes(int paisID, string codigoCampania, string codigoConsultora);
        IList<BEIncentivoConcurso> ObtenerConcursosXConsultora(BEProgramaNuevas usuario, string codigoRegion, string codigoZona);
        List<BEIncentivoConcurso> ObtenerIncentivosConsultora(int paisID, string codigoConsultora, int codigoCampania, long ConsultoraID, bool estrategia);
        List<BEIncentivoConcurso> ObtenerIncentivosHistorico(int paisID, string codigoConsultora, int codigoCampania);
        List<BEConsultoraConcurso> ObtenerPuntosXConsultoraConcurso(int paisID, string codigoCampania, string codigoConsultora);
    }
}