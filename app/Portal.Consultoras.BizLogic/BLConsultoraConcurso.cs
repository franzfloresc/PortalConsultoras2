using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System.Collections.Generic;
using System.Data;
using System.Linq;

namespace Portal.Consultoras.BizLogic
{
    public class BLConsultoraConcurso
    {
        /// <summary>
        /// Concursos donde la consultora participa.
        /// </summary>
        /// <param name="PaisID"></param>
        /// <param name="CodigoCampania"></param>
        /// <param name="CodigoConsultora"></param>
        /// <param name="CodigoRegion"></param>
        /// <param name="CodigoZona"></param>
        /// <returns></returns>
        public IList<BEConsultoraConcurso> ObtenerConcursosXConsultora(int PaisID, string CodigoCampania, string CodigoConsultora, string CodigoRegion, string CodigoZona)
        {
            List<BEConsultoraConcurso> Concursos = new List<BEConsultoraConcurso>();
            var DAConcurso = new DAConcurso(PaisID);

            using (IDataReader reader = DAConcurso.ObtenerConcursosXConsultora(CodigoCampania, CodigoConsultora, CodigoRegion, CodigoZona))
                while (reader.Read())
                {
                    BEConsultoraConcurso Concurso = new BEConsultoraConcurso(reader);
                    Concursos.Add(Concurso);
                }

            return Concursos;
        }

        /// <summary>
        /// Actualizar o Insertar el puntaje del consurso que participa la consultora.
        /// </summary>
        /// <param name="PaisID"></param>
        /// <param name="CodigoConsultora"></param>
        /// <param name="CodigoCampania"></param>
        /// <param name="Puntos"></param>
        public void ActualizarInsertarPuntosConcurso(int PaisID, string CodigoConsultora, string CodigoCampania, int Puntos)
        {
            DAConcurso DAConcurso = new DAConcurso(PaisID);
            DAConcurso.ActualizarInsertarPuntosConcurso(CodigoConsultora, CodigoCampania, Puntos);
        }
        /// <summary>
        /// Obtener el puntaje del concurso que participa la consultora.
        /// </summary>
        /// <param name="PaisID"></param>
        /// <param name="CodigoCampania"></param>
        /// <param name="CodigoConsultora"></param>
        /// <param name="CodigoConcurso"></param>
        /// <returns></returns>
        public List<BEConsultoraConcurso> ObtenerPuntosXConsultoraConcurso(int PaisID, string CodigoCampania, string CodigoConsultora, string CodigoConcurso)
        {
            List<BEConsultoraConcurso> PuntosXConcurso = new List<BEConsultoraConcurso>();
            DAConcurso DAConcurso = new DAConcurso(PaisID);
            using (IDataReader reader = DAConcurso.ObtenerPuntosXConsultoraConcurso(CodigoCampania, CodigoConsultora, CodigoConcurso))
            {
                while (reader.Read())
                {
                    BEConsultoraConcurso Concurso = new BEConsultoraConcurso(reader);
                    PuntosXConcurso.Add(Concurso);
                }
            }
            return PuntosXConcurso;
        }
    }
}
