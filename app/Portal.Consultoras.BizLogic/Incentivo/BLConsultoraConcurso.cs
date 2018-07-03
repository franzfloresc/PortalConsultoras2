using Portal.Consultoras.Common;
using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.Incentivo;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Transactions;
using Incentivos = Portal.Consultoras.Common.Constantes.Incentivo;

namespace Portal.Consultoras.BizLogic
{
    public class BLConsultoraConcurso : IConsultoraConcursoBusinessLogic
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
        public IList<BEIncentivoConcurso> ObtenerConcursosXConsultora(int PaisID, string CodigoCampania, string CodigoConsultora, string CodigoRegion, string CodigoZona)
        {
            List<BEIncentivoConcurso> Concursos = new List<BEIncentivoConcurso>();

            var DAConcurso = new DAConcurso(PaisID);

            using (IDataReader reader = DAConcurso.ObtenerConcursosXConsultora(CodigoCampania, CodigoConsultora, CodigoRegion, CodigoZona))
            {
                Concursos.AddRange(reader.MapToCollection<BEIncentivoConcurso>());
            }

            using (IDataReader reader = DAConcurso.ObtenerProgramaNuevasXConsultora(CodigoConsultora, Convert.ToInt32(CodigoCampania), CodigoRegion, CodigoZona))
            {
                Concursos.AddRange(reader.MapToCollection<BEIncentivoConcurso>());
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
            TransactionOptions transOptions = new TransactionOptions { IsolationLevel = System.Transactions.IsolationLevel.ReadCommitted };

            using (TransactionScope transScope = new TransactionScope(TransactionScopeOption.Required, transOptions))
            {
                DAConcurso.ActualizarInsertarPuntosConcurso(CodigoConsultora, CodigoCampania, CodigoConcursos, PuntosConcurso, PuntosExigidosConcurso);
                transScope.Complete();
            }
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
            List<BEConsultoraConcurso> puntosXConcurso;
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
                DAConcurso.GenerarConcursoVigente(codigoConsultora, codigoCampania);
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
            List<BEConsultoraConcurso> puntosXConcurso;
            DAConcurso DAConcurso = new DAConcurso(paisID);
            try
            {
                DAConcurso.GenerarConcursoVigente(codigoConsultora, codigoCampaniaActual);
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

        /// <summary>
        /// Obtener los incentivos vigentes por consultora.
        /// </summary>
        /// <param name="PaisID"></param>
        /// /// <param name="CodigoConsultora"></param>
        /// <param name="CodigoCampania"></param>
        /// <returns></returns>
        public List<BEIncentivoConcurso> ObtenerIncentivosConsultora(int paisID, string codigoConsultora, int codigoCampania, long ConsultoraID,
            bool estrategia)
        {
            var incentivos = new List<BEIncentivoConcurso>();

            incentivos.AddRange(this.ObtenerIncentivosProgramaNuevasConsultora(paisID, codigoConsultora, codigoCampania, ConsultoraID));

            if (estrategia) incentivos.AddRange(this.ObtenerIncentivosConsultoraEstrategia(paisID, codigoConsultora, codigoCampania));
            else incentivos.AddRange(this.ObtenerIncentivosPuntosConsultora(paisID, codigoConsultora, codigoCampania));

            return incentivos;
        }

        /// <summary>
        /// Obtener los incentivos historicos por consultora.
        /// </summary>
        /// <param name="PaisID"></param>
        /// /// <param name="CodigoConsultora"></param>
        /// <param name="CodigoCampania"></param>
        /// <returns></returns>
        public List<BEIncentivoConcurso> ObtenerIncentivosHistorico(int paisID, string codigoConsultora, int codigoCampania)
        {
            List<BEIncentivoConcurso> incentivosConcursos;
            List<BEIncentivoNivel> incentivosNivel;
            List<BEIncentivoPremio> incentivosPremios = new List<BEIncentivoPremio>();

            DAConcurso DAConcurso = new DAConcurso(paisID);

            using (IDataReader reader = DAConcurso.ObtenerIncentivosHistorico(codigoConsultora, codigoCampania))
            {
                incentivosConcursos = reader.MapToCollection<BEIncentivoConcurso>();

                if (reader.NextResult())
                {
                    incentivosPremios = reader.MapToCollection<BEIncentivoPremio>();
                }

                foreach (var item in incentivosConcursos)
                {
                    incentivosNivel = new List<BEIncentivoNivel>();

                    incentivosNivel.Add(new BEIncentivoNivel()
                    {
                        CodigoConcurso = item.CodigoConcurso,
                        CodigoNivel = item.NivelAlcanzado,
                        PuntosNivel = item.PuntosNivel,
                        CodigoPremio = string.Join("\n", incentivosPremios.Where(p => p.CodigoConcurso == item.CodigoConcurso).Select(x => x.CodigoPremio)),
                        DescripcionPremio = string.Join("\n", incentivosPremios.Where(p => p.CodigoConcurso == item.CodigoConcurso).Select(x => x.DescripcionPremio))
                    });

                    item.Niveles = incentivosNivel;
                }
            }

            return incentivosConcursos;
        }

        #region private
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
            // Alcanzo todos los niveles, quitar los premios para no acumulativos..
            if (!concurso.IndicadorPremioAcumulativo && !concurso.Premios.Any(p => p.PuntajeMinimo > concurso.PuntajeTotal))
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

            foreach (BEPremio Premio in concurso.Premios)
            {
                Premio.Importante = 0;
                if (concurso.FechaVentaRetail.HasValue && concurso.PuntajeTotal < Premio.PuntajeMinimo && DateTime.Today <= concurso.FechaVentaRetail)
                {
                    Premio.Mensaje = string.Format(Incentivos.CompraENBelcenter, concurso.FechaVentaRetail.Value.Day, Util.NombreMesAbrev(concurso.FechaVentaRetail.Value.Month));
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

            concurso.IndicadorPremiacionPedido = concurso.Premios.Any();
        }

        private bool EsCampaniaVisible(BEConsultoraConcurso concurso)
        {
            if (concurso.Premios == null || concurso.Premios.Count == 0) return false;

            if (!concurso.EsCampaniaAnterior) return true;
            if (concurso.PuntajeTotal > concurso.Premios.First().PuntajeMinimo) return true;
            if (concurso.FechaVentaRetail >= DateTime.Today) return true;
            return false;
        }

        private List<BEIncentivoConcurso> ObtenerIncentivosPuntosConsultora(int paisID, string codigoConsultora, int codigoCampania)
        {
            List<BEIncentivoConcurso> incentivosConcursos;
            List<BEIncentivoNivel> incentivosNivel = new List<BEIncentivoNivel>();
            List<BEIncentivoPremio> incentivosPremios = new List<BEIncentivoPremio>();

            DAConcurso DAConcurso = new DAConcurso(paisID);

            DAConcurso.GenerarConcursoVigente(codigoConsultora, codigoCampania.ToString());

            using (IDataReader reader = DAConcurso.ObtenerIncentivosConsultora(codigoConsultora, codigoCampania))
            {
                incentivosConcursos = reader.MapToCollection<BEIncentivoConcurso>();

                if (reader.NextResult())
                {
                    incentivosNivel = reader.MapToCollection<BEIncentivoNivel>();

                    if (reader.NextResult())
                    {
                        incentivosPremios = reader.MapToCollection<BEIncentivoPremio>();
                    }

                    foreach (var item in incentivosNivel)
                    {
                        item.CodigoPremio = string.Join("\n", incentivosPremios.Where(p => p.CodigoConcurso == item.CodigoConcurso && p.CodigoNivel == item.CodigoNivel).Select(x => x.CodigoPremio));
                        item.DescripcionPremio = string.Join("\n", incentivosPremios.Where(p => p.CodigoConcurso == item.CodigoConcurso && p.CodigoNivel == item.CodigoNivel).Select(x => x.DescripcionPremio));
                        item.NumeroPremio = string.Join("\n", incentivosPremios.Where(p => p.CodigoConcurso == item.CodigoConcurso && p.CodigoNivel == item.CodigoNivel).Select(x => x.NumeroPremio));
                    }
                }

                foreach (var item in incentivosConcursos)
                {
                    item.Niveles = incentivosNivel.Where(p => p.CodigoConcurso == item.CodigoConcurso).ToList();
                }
            }

            return incentivosConcursos;
        }

        private List<BEIncentivoConcurso> ObtenerIncentivosProgramaNuevasConsultora(int paisID, string codigoConsultora, int codigoCampania, long ConsultoraID)
        {
            var incentivosConcursos = new List<BEIncentivoConcurso>();
            var incentivosNivel = new List<BEIncentivoProgramaNuevasNivel>();
            var incentivosPremios = new List<BEIncentivoProgramaNuevasPremio>();
            var incentivosCupon = new List<BEIncentivoProgramaNuevasCupon>();

            var paisISO = Util.GetPaisISO(paisID);

            using (var reader = new DAConcurso(paisID).ObtenerIncentivosProgramaNuevasConsultora(codigoConsultora, codigoCampania, ConsultoraID))
            {
                incentivosConcursos = reader.MapToCollection<BEIncentivoConcurso>();

                if (reader.NextResult())
                {
                    incentivosNivel = reader.MapToCollection<BEIncentivoProgramaNuevasNivel>();

                    if (reader.NextResult())
                    {
                        incentivosPremios = reader.MapToCollection<BEIncentivoProgramaNuevasPremio>();
                        foreach (var premio in incentivosPremios)
                        {
                            premio.ImagenURL = (string.IsNullOrEmpty(premio.ImagenURL) ? string.Empty : string.Format(Resources.IncentivoMessages.UrlImagenCUV, ConfigS3.GetUrlS3(string.Empty), paisISO, premio.ImagenURL));
                            premio.DescripcionProducto = premio.DescripcionProducto.Split('|')[0];
                        }

                        if (reader.NextResult())
                        {
                            incentivosCupon = reader.MapToCollection<BEIncentivoProgramaNuevasCupon>();
                            foreach (var cupon in incentivosCupon)
                            {
                                cupon.ImagenURL = (string.IsNullOrEmpty(cupon.ImagenURL) ? string.Empty : string.Format(Resources.IncentivoMessages.UrlImagenCUV, ConfigS3.GetUrlS3(string.Empty), paisISO, cupon.ImagenURL));
                                cupon.DescripcionProducto = cupon.DescripcionProducto.Split('|')[0];
                            }
                        }
                    }

                    foreach (var item in incentivosNivel)
                    {
                        item.PremiosProgramaNuevas = incentivosPremios.Where(p => p.CodigoConcurso == item.CodigoConcurso && p.CodigoNivel == item.CodigoNivel).ToList();
                        item.CuponesProgramaNuevas = incentivosCupon.Where(p => p.CodigoConcurso == item.CodigoConcurso && p.CodigoNivel == item.CodigoNivel).ToList();
                    }
                }

                foreach (var item in incentivosConcursos)
                {
                    item.NivelesProgramaNuevas = incentivosNivel.Where(p => p.CodigoConcurso == item.CodigoConcurso).ToList();

                    if (incentivosPremios.Any(p => p.CodigoConcurso == item.CodigoConcurso && p.CodigoNivel == item.CodigoNivelProgramaNuevas) && !string.IsNullOrEmpty(item.ArchivoBannerPremio))
                        item.UrlBannerPremiosProgramaNuevas = string.Format(Resources.IncentivoMessages.UrlBannerPremiosProgramaNuevas, ConfigS3.GetUrlS3(string.Empty), paisISO, Dictionaries.IncentivoProgramaNuevasNiveles[item.CodigoNivelProgramaNuevas], item.ArchivoBannerPremio);
                    if (incentivosCupon.Any(p => p.CodigoConcurso == item.CodigoConcurso && p.CodigoNivel == item.CodigoNivelProgramaNuevas) && !string.IsNullOrEmpty(item.ArchivoBannerCupon))
                        item.UrlBannerCuponesProgramaNuevas = string.Format(Resources.IncentivoMessages.UrlBannerCuponesProgramaNuevas, ConfigS3.GetUrlS3(string.Empty), paisISO, Dictionaries.IncentivoProgramaNuevasNiveles[item.CodigoNivelProgramaNuevas], item.ArchivoBannerCupon);
                }
            }

            return incentivosConcursos;
        }

        private List<BEIncentivoConcurso> ObtenerIncentivosConsultoraEstrategia(int paisID, string codigoConsultora, int codigoCampania)
        {
            List<BEIncentivoConcurso> incentivosConcursos;
            var incentivosNivel = new List<BEIncentivoNivel>();
            var incentivosPremios = new List<BEIncentivoPremio>();
            string paisISO = Util.GetPaisISO(paisID);

            var DAConcurso = new DAConcurso(paisID);

            DAConcurso.GenerarConcursoVigente(codigoConsultora, codigoCampania.ToString());

            using (var reader = DAConcurso.ObtenerIncentivosConsultoraEstrategia(codigoConsultora, codigoCampania))
            {
                incentivosConcursos = reader.MapToCollection<BEIncentivoConcurso>();

                if (reader.NextResult())
                {
                    incentivosNivel = reader.MapToCollection<BEIncentivoNivel>();

                    if (reader.NextResult())
                    {
                        incentivosPremios = reader.MapToCollection<BEIncentivoPremio>();
                        incentivosPremios.Update(x => x.ImagenPremio = (string.IsNullOrEmpty(x.ImagenPremio) ? string.Empty : string.Format(Resources.IncentivoMessages.UrlImagenCUV, ConfigS3.GetUrlS3(string.Empty), paisISO, x.ImagenPremio)));
                    }

                    foreach (var item in incentivosNivel)
                    {
                        item.Premios = incentivosPremios.Where(p => p.CodigoConcurso == item.CodigoConcurso && p.CodigoNivel == item.CodigoNivel).ToList();
                    }
                }

                foreach (var item in incentivosConcursos)
                {
                    item.Niveles = incentivosNivel.Where(p => p.CodigoConcurso == item.CodigoConcurso).ToList();
                }
            }

            return incentivosConcursos;
        }
        #endregion
    }
}
