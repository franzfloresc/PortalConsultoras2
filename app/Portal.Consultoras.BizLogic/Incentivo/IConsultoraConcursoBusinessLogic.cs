﻿using System.Collections.Generic;
using Portal.Consultoras.Entities;

namespace Portal.Consultoras.BizLogic
{
    public interface IConsultoraConcursoBusinessLogic
    {
        void ActualizarInsertarPuntosConcurso(int PaisID, string CodigoConsultora, string CodigoCampania, string CodigoConcursos, string PuntosConcurso, string PuntosExigidosConcurso);
        List<BEConsultoraConcurso> ListConcursosByCampania(int paisID, string codigoCampaniaActual, string codigoCampania, string tipoConcurso, string codigoConsultora);
        List<BEConsultoraConcurso> ListConcursosVigentes(int paisID, string codigoCampania, string codigoConsultora);
        IList<BEIncentivoConcurso> ObtenerConcursosXConsultora(int PaisID, string CodigoCampania, string CodigoConsultora, string CodigoRegion, string CodigoZona);
        List<BEIncentivoConcurso> ObtenerIncentivosConsultora(int paisID, string codigoConsultora, int codigoCampania, long ConsultoraID);
        List<BEIncentivoConcurso> ObtenerIncentivosHistorico(int paisID, string codigoConsultora, int codigoCampania);
        List<BEConsultoraConcurso> ObtenerPuntosXConsultoraConcurso(int paisID, string codigoCampania, string codigoConsultora);
    }
}