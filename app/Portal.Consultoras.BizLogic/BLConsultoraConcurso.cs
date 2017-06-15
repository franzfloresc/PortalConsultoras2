using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using Incentivos = Portal.Consultoras.Common.Constantes.Inventivo;

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
        public void ActualizarInsertarPuntosConcurso(int PaisID, string CodigoConsultora, string CodigoCampania, string CodigoConcursos, string PuntosConcurso)
        {
            DAConcurso DAConcurso = new DAConcurso(PaisID);
            DAConcurso.ActualizarInsertarPuntosConcurso(CodigoConsultora, CodigoCampania, CodigoConcursos, PuntosConcurso);
        }

        /// <summary>
        /// Obtener el puntaje del concurso que participa la consultora.
        /// </summary>
        /// <param name="PaisID"></param>
        /// <param name="CodigoCampania"></param>
        /// <param name="CodigoConsultora"></param>
        /// <param name="CodigoConcurso"></param>
        /// <returns></returns>
        public List<BEConsultoraConcurso> ObtenerPuntosXConsultoraConcurso(int PaisID, string CodigoCampania, string CodigoConsultora)
        {
            List<BEConsultoraConcurso> PuntosXConcurso = new List<BEConsultoraConcurso>();
            DAConcurso DAConcurso = new DAConcurso(PaisID);
            List<BEPremio> Premios = new List<BEPremio>();
            try
            {
                using (IDataReader reader = DAConcurso.ObtenerPuntosXConsultoraConcurso(CodigoCampania, CodigoConsultora))
                {
                    while (reader.Read())
                    {
                        PuntosXConcurso.Add(new BEConsultoraConcurso(reader));
                    }

                    if (PuntosXConcurso.Any() && reader.NextResult())
                    {
                        while (reader.Read())
                        {
                            Premios.Add(new BEPremio(reader));
                        }
                    }
                    foreach (var item in PuntosXConcurso)
                    {
                        item.Premios = Premios.Where(p => p.CodigoConcurso == item.CodigoConcurso).ToList();
                    }
                }
            }
            catch (System.Exception)
            {
                PuntosXConcurso.Add(new BEConsultoraConcurso
                {
                    CodigoCampania = CodigoCampania,
                    CodigoConcurso = "-1",
                    Mensaje = Incentivos.TextoNoTenemosConcurso
                });
            }

            if (!PuntosXConcurso.Any())
            {
                PuntosXConcurso.Add(new BEConsultoraConcurso
                {
                    CodigoCampania = CodigoCampania,
                    CodigoConcurso = "-1",
                    Mensaje = Incentivos.TextoNoTenemosConcurso
                });
            }
            else
            {
                // Cargar información de incentivos.
                foreach (var item in PuntosXConcurso)
                {
                    // Si el concurso tiene un solo premio y no ha llegado al puntaje minimo.
                    if (item.Premios.Count == 1 && item.Premios.Any(p => p.PuntajeMinimo < item.PuntajeTotal))
                    {
                        item.Premios.FirstOrDefault().Mensaje = string.Format(Incentivos.TextoTeFaltan, item.PuntosFaltantesSiguienteNivel);
                        break;
                    }
                    // Si el concurso tiene un solo premio y ha llegado al puntaje minimo.
                    if (item.Premios.Count == 1 && item.Premios.Any(p => item.PuntajeTotal > p.PuntajeMinimo))
                    {
                        item.Premios.FirstOrDefault().Mensaje = string.Format(Incentivos.TextoLlegasteAPuntosRequeridos, item.Premios.Select(p => p.PuntajeMinimo));
                        break;
                    }
                    if (item.Premios.Count > 1)
                    {
                        foreach (var premio in item.Premios)
                        {

                        }
                    }
                    // SI el concurso tiene mas premios 
                }
            }

            return PuntosXConcurso;
        }
    }
}
