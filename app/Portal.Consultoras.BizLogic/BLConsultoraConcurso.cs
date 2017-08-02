using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System.Collections.Generic;
using System;
using System.Data;
using System.Linq;
using Portal.Consultoras.Common;
using Incentivos = Portal.Consultoras.Common.Constantes.Incentivo;

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
            {
                while (reader.Read())
                {
                    BEConsultoraConcurso Concurso = new BEConsultoraConcurso(reader);
                    Concursos.Add(Concurso);
                }
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
        public void ActualizarInsertarPuntosConcurso(int PaisID, string CodigoConsultora, string CodigoCampania, string CodigoConcursos, string PuntosConcurso, string PuntosExigidosConcurso)
        {
            DAConcurso DAConcurso = new DAConcurso(PaisID);
            DAConcurso.ActualizarInsertarPuntosConcurso(CodigoConsultora, CodigoCampania, CodigoConcursos, PuntosConcurso, PuntosExigidosConcurso);
        }

        /// <summary>
        /// Obtener el puntaje del concurso que participa la consultora.
        /// </summary>
        /// <param name="PaisID"></param>
        /// <param name="CodigoCampania"></param>
        /// <param name="CodigoConsultora"></param>
        /// <param name="CodigoConcurso"></param>
        /// <returns></returns>
        public List<BEConsultoraConcurso> ObtenerPuntosXConsultoraConcurso(int paisID, string codigoCampania, string codigoConsultora)
        {
            List<BEConsultoraConcurso> puntosXConcurso = new List<BEConsultoraConcurso>();
            DAConcurso DAConcurso = new DAConcurso(paisID);

            try
            {
                DAConcurso.GenerarConcursoVigente(codigoConsultora, codigoCampania);
                
                using (IDataReader reader = DAConcurso.ObtenerPuntosXConsultoraConcurso(codigoCampania, codigoConsultora))
                {
                    puntosXConcurso = GetConcursos(reader);
                }
            }
            catch (Exception)
            {
                puntosXConcurso = new List<BEConsultoraConcurso>();
            }

            // Cargar información de incentivos.
            foreach (BEConsultoraConcurso concurso in puntosXConcurso)
            {
                if (!concurso.EsCampaniaAnterior) AjustarConcursoActual(concurso);
                else AjustarConcursoAnterior(concurso);
            }
            return puntosXConcurso;
        }

        /// <summary>
        /// Listar los concursos vigentes de la consultora.
        /// </summary>
        /// <param name="paisID"></param>
        /// <param name="codigoCampania"></param>
        /// <param name="codigoConsultora"></param>
        /// <returns></returns>
        public List<BEConsultoraConcurso> ListConcursosVigentes(int paisID, string codigoCampania, string codigoConsultora)
        {
            List<BEConsultoraConcurso> puntosXConcurso = new List<BEConsultoraConcurso>();
            DAConcurso DAConcurso = new DAConcurso(paisID);
            try
            {
                using (IDataReader reader = DAConcurso.ObtenerPuntosXConsultoraConcurso(codigoCampania, codigoConsultora))
                {
                    puntosXConcurso = GetConcursos(reader);
                }
            }
            catch (Exception ex) { LogManager.SaveLog(ex, codigoConsultora, paisID.ToString()); }
            
            return puntosXConcurso.Where(c => EsCampaniaVisible(c)).ToList();
        }

        /// <summary>
        /// Obtener el puntaje de los concursos de la campaña de la consultora.
        /// </summary>
        /// <param name="paisID"></param>
        /// <param name="codigoCampania"></param>
        /// <param name="codigoCampaniaActual"></param>
        /// <param name="codigoCampania"></param>
        /// <returns></returns>
        public List<BEConsultoraConcurso> ListConcursosByCampania(int paisID, string codigoCampaniaActual, string codigoCampania, string tipoConcurso, string codigoConsultora)
        {
            List<BEConsultoraConcurso> puntosXConcurso = new List<BEConsultoraConcurso>();
            DAConcurso DAConcurso = new DAConcurso(paisID);
            try
            {
                using (IDataReader reader = DAConcurso.ObtenerPuntosXConsultoraConcurso(codigoCampaniaActual, codigoConsultora))
                {
                    puntosXConcurso = GetConcursos(reader);
                }
                tipoConcurso = tipoConcurso.ToUpper();
                puntosXConcurso = puntosXConcurso.Where(c => c.CodigoCampania == codigoCampania && c.TipoConcurso.ToUpper() == tipoConcurso).ToList();
            }
            catch (Exception)
            {
                puntosXConcurso = new List<BEConsultoraConcurso>();
            }

            // Cargar información de incentivos.
            foreach (BEConsultoraConcurso concurso in puntosXConcurso)
            {
                if (!concurso.EsCampaniaAnterior) AjustarConcursoActual(concurso);
                else AjustarConcursoAnterior(concurso);
            }
            return puntosXConcurso;
        }

        private List<BEConsultoraConcurso> GetConcursos(IDataReader reader, bool loadPremios = true)
        {
            List<BEConsultoraConcurso> puntosXConcurso = new List<BEConsultoraConcurso>();
            List<BEPremio> premios = new List<BEPremio>();
            
            while (reader.Read()) puntosXConcurso.Add(new BEConsultoraConcurso(reader));
            if (loadPremios)
            {
                if (puntosXConcurso.Any() && reader.NextResult())
                {
                    while (reader.Read())
                    {
                        premios.Add(new BEPremio(reader));
                    }
                }
                foreach (var item in puntosXConcurso)
                {
                    item.Premios = premios.Where(p => p.CodigoConcurso == item.CodigoConcurso).ToList();
                }
            }
            
            return puntosXConcurso;
        }

        private void AjustarConcursoActual(BEConsultoraConcurso concurso)
        {
            foreach (BEPremio Premio in concurso.Premios)
            {
                Premio.Importante = 0;
                if (concurso.PuntajeTotal >= Premio.PuntajeMinimo)
                {
                    Premio.Mensaje = (concurso.NumeroNiveles > 1) ?
                      string.Format(Incentivos.LlegasteAPuntosRequeridosNivel, Premio.PuntajeMinimo, Premio.NumeroNivel) :
                        string.Format(Incentivos.LlegasteAPuntosRequeridos, Premio.PuntajeMinimo);
                    Premio.Importante = 1;
                }
                else if (concurso.PuntajeTotal < Premio.PuntajeMinimo)
                {
                    Premio.Mensaje = string.Format(Incentivos.TeFaltan, (Premio.PuntajeMinimo - concurso.PuntajeTotal));
                    Premio.Importante = 2;
                    concurso.Mensaje = concurso.NivelSiguiente > 1
                       ? (concurso.IndicadorPremioAcumulativo ? string.Format(Incentivos.PuedesLlevarAdicionalmentePremio, concurso.NivelSiguiente)
                                : string.Format(Incentivos.PuedesLlevarPremio, concurso.NivelSiguiente))
                        : string.Empty;
                }
            }

            // Quitar los premios de nivel inferior cuando no es acumulativo y alcanzo todos los niveles.
            if (!concurso.IndicadorPremioAcumulativo && !concurso.Premios.Any(p => p.PuntajeMinimo > concurso.PuntajeTotal))
            {
                concurso.Premios.RemoveAll(p => p.NumeroNivel < concurso.NivelAlcanzado);
                concurso.Premios = new List<BEPremio>{
                    new BEPremio
                    {
                        Codigo = concurso.Premios.FirstOrDefault() != null ? concurso.Premios.FirstOrDefault().Codigo : default(string),
                        CodigoConcurso = concurso.CodigoConcurso,
                        Importante = 1,
                        Descripcion = string.Join(", ", concurso.Premios.Select(p => p.Descripcion).ToArray()),
                        PuntajeMinimo = concurso.Premios.FirstOrDefault()!=null?concurso.Premios.FirstOrDefault().PuntajeMinimo:default(int),
                        NumeroNivel = concurso.NivelAlcanzado,
                        Mensaje = concurso.Premios.FirstOrDefault()!=null? concurso.Premios.FirstOrDefault().Mensaje: string.Empty
                    }
                };
            }
        }

        private void AjustarConcursoAnterior(BEConsultoraConcurso concurso)
        {
            if (!concurso.Premios.Any(p => p.PuntajeMinimo > concurso.PuntajeTotal)) // Alcanzo todos los niveles, quitar los premios para no acumulativos..
            {
                if (!concurso.IndicadorPremioAcumulativo)
                {
                    concurso.Premios.RemoveAll(p => p.NumeroNivel < concurso.NivelAlcanzado);
                    concurso.Premios = new List<BEPremio>{
                        new BEPremio
                        {
                            Importante = 1,
                            Descripcion = string.Join(", ", concurso.Premios.Select(p => p.Descripcion).ToArray()),
                            PuntajeMinimo = concurso.Premios.FirstOrDefault().PuntajeMinimo
                        }
                    };
                }
            }

            foreach (BEPremio Premio in concurso.Premios)
            {
                Premio.Importante = 0;
                if (concurso.PuntajeTotal < Premio.PuntajeMinimo && DateTime.Today <= concurso.FechaVentaRetail)
                {
                    Premio.Mensaje = string.Format(Incentivos.CompraENBelcenter, concurso.FechaVentaRetail.Day, Util.NombreMes(concurso.FechaVentaRetail.Month));
                    Premio.Importante = 2;
                }
                else if (concurso.PuntajeTotal >= Premio.PuntajeMinimo)
                {
                    Premio.Importante = 1;
                    Premio.Mensaje = concurso.IndicadorPremiacionPedido ?
                        (concurso.MontoPremiacionPedido > 1 ? string.Format(Incentivos.MontoPremiacion, concurso.Simbolo, concurso.MontoPremiacionPedido) : Incentivos.IndicadorPremiacion)
                        : (concurso.NumeroNiveles > 1 ?
                            string.Format(Incentivos.LlegasteAPuntosRequeridosNivel, Premio.PuntajeMinimo, Premio.NumeroNivel)
                            : string.Format(Incentivos.LlegasteAPuntosRequeridos, Premio.PuntajeMinimo));
                }
            }
            if (concurso.NivelAlcanzado == 0) concurso.NivelSiguiente = 1;
            concurso.Premios.RemoveAll(p => p.NumeroNivel > concurso.NivelSiguiente && concurso.NivelSiguiente != 0);
            if (concurso.FechaVentaRetail <= DateTime.Today) concurso.Premios.RemoveAll(p => p.PuntajeMinimo > concurso.PuntajeTotal);
        }

        private bool EsCampaniaVisible(BEConsultoraConcurso concurso)
        {
            if (concurso.Premios == null || concurso.Premios.Count == 0) return false;

            if (!concurso.EsCampaniaAnterior) return true;
            if (concurso.PuntajeTotal > concurso.Premios.First().PuntajeMinimo) return true;
            if (concurso.FechaVentaRetail >= DateTime.Today) return true;
            return false;
        }
    }
}
