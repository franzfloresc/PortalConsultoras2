﻿using Portal.Consultoras.Data;
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
                foreach (BEConsultoraConcurso Concurso in PuntosXConcurso)
                {
                    if (!Concurso.EsCampaniaAnterior) // Logica de la campania actual.
                    {
                        foreach (BEPremio Premio in Concurso.Premios)
                        {
                            Premio.Importante = 0;
                            if (Concurso.PuntajeTotal >= Premio.PuntajeMinimo)
                            {
                                Premio.Mensaje = string.Format(Incentivos.TextoLlegasteAPuntosRequeridos, Premio.PuntajeMinimo);
                                Premio.Importante = 1;
                            }
                            else if (Concurso.PuntajeTotal < Premio.PuntajeMinimo)
                            {
                                Premio.Descripcion = string.Format(Incentivos.TextoDescripcion, Premio.Descripcion, Premio.PuntajeMinimo).ToUpper();
                                Premio.Mensaje = string.Format(Incentivos.TextoTeFaltan, (Premio.PuntajeMinimo - Concurso.PuntajeTotal));
                                Premio.Importante = 2;
                            }
                        }
                    }
                    else // Logica de la campania anterior.
                    {
                        if (!Concurso.Premios.Any(p => p.PuntajeMinimo > Concurso.PuntajeTotal)) // Alcanzo todos los niveles.
                        {
                            if (!Concurso.IndicadorPremioAcumulativo)
                            {   // Quitar los premios para no acumulativos.
                                Concurso.Premios.RemoveAll(p => p.NumeroNivel < Concurso.NivelAlcanzado);
                                Concurso.Premios = new List<BEPremio>{
                                new BEPremio
                                    {
                                        Importante = 1,
                                        Descripcion = string.Join(", ", Concurso.Premios.Select(p => p.Descripcion).ToArray()),
                                        Mensaje = Concurso.IndicadorPremiacionPedido ? (Concurso.MontoPremiacionPedido > 1 ? Incentivos.TextoMontoPremiacion : Incentivos.TextoIndicadorPremiacion)
                                                                                 : string.Format(Incentivos.TextoMontoPremiacion, Concurso.MontoPremiacionPedido),
                                        PuntajeMinimo = Concurso.Premios.FirstOrDefault().PuntajeMinimo
                                    }
                                };
                            }
                        }

                        foreach (BEPremio Premio in Concurso.Premios)
                        {
                            Premio.Importante = 0;
                            if (Concurso.PuntajeTotal < Premio.PuntajeMinimo && DateTime.Today <= Concurso.FechaVentaRetail)
                            {
                                Premio.Mensaje = string.Format(Incentivos.TextoCompraENBelcenter, Concurso.FechaVentaRetail.Day, Util.NombreMes(Concurso.FechaVentaRetail.Month));
                                Premio.Descripcion = string.Format(Incentivos.TextoDescripcion, Premio.Descripcion, Premio.PuntajeMinimo).ToUpper();
                                Premio.Importante = 2;
                            }
                            else if (Concurso.PuntajeTotal >= Premio.PuntajeMinimo)
                            {
                                Premio.Importante = 1;
                                Premio.Mensaje = Concurso.IndicadorPremiacionPedido ?
                                    (Concurso.MontoPremiacionPedido > 1 ? string.Format(Incentivos.TextoMontoPremiacion, Concurso.MontoPremiacionPedido) : Incentivos.TextoIndicadorPremiacion)
                                    : string.Format(Incentivos.TextoLlegasteAPuntosRequeridos, Premio.PuntajeMinimo);
                            }
                        }
                        if (Concurso.NivelAlcanzado == 0) Concurso.NivelSiguiente = 1;
                        Concurso.Premios.RemoveAll(p => p.NumeroNivel > Concurso.NivelSiguiente);

                        if (Concurso.FechaVentaRetail <= DateTime.Today)
                            Concurso.Premios.RemoveAll(p => p.PuntajeMinimo > Concurso.PuntajeTotal);
                    }
                }
            }
            return PuntosXConcurso;
        }
    }
}
