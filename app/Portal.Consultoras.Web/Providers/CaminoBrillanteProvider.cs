﻿using System.Collections.Generic;
using Portal.Consultoras.Web.ServiceUsuario;
using System.Linq;
using System;
using Portal.Consultoras.Web.SessionManager;
using Portal.Consultoras.Web.Models;
using AutoMapper;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models.CaminoBrillante;

namespace Portal.Consultoras.Web.Providers
{
    public class CaminoBrillanteProvider
    {
        protected ISessionManager sessionManager = SessionManager.SessionManager.Instance;
        private UsuarioModel usuarioModel { get { return sessionManager.GetUserData(); } }

        /// <summary>
        /// Obtiene la escala de niveles del programa de Camino Brillante
        /// <paramref name="matchNivelConsultora"/>
        /// </summary>
        public List<NivelCaminoBrillanteModel> GetNivelesCaminoBrillante(bool matchNivelConsultora = false)
        {
            try
            {
                var consultoraCaminoBrillante = GetConsultoraNivelCaminoBrillante();
                if (consultoraCaminoBrillante == null) return new List<NivelCaminoBrillanteModel>();

                var result = Mapper.Map<List<NivelCaminoBrillanteModel>>(consultoraCaminoBrillante.Niveles.ToList());

                if (matchNivelConsultora)
                {
                    var nivelActualConsultora = GetNivelActualConsultora();
                    if (nivelActualConsultora == null) return result;

                    int nivel = 0;
                    int nivelActual = 0;
                    if (int.TryParse(nivelActualConsultora.Nivel, out nivelActual))
                    {
                        result.Each(e =>
                        {
                            if (int.TryParse(e.CodigoNivel, out nivel))
                            {
                                e.EsPasado = nivel <= nivelActual;
                                e.EsActual = nivel == nivelActual;
                            }
                        });
                    }
                }

                return result;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, usuarioModel.CodigoConsultora, usuarioModel.CodigoISO);
                return new List<NivelCaminoBrillanteModel>();
            }
        }

        /// <summary>
        /// Obtiene el Nivel Actual
        /// </summary>
        public NivelCaminoBrillanteModel GetNivelActual()
        {
            try
            {
                var oConsultora = GetConsultoraNivelCaminoBrillante();
                if (oConsultora == null || oConsultora.Niveles == null) return null;

                var codigoNivel = oConsultora.NivelConsultora.Where(x => x.EsActual).Select(z => z.Nivel).FirstOrDefault();
                return Mapper.Map<NivelCaminoBrillanteModel>(oConsultora.Niveles.FirstOrDefault(x => x.CodigoNivel == codigoNivel));
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, usuarioModel.CodigoConsultora, usuarioModel.CodigoISO);
                return null;
            }
        }

        /// <summary>
        /// Obtiene los niveles historico de los Consultora en el programa de Camino Brillante
        /// </summary>
        public List<BEConsultoraCaminoBrillante.BENivelConsultoraCaminoBrillante> GetNivelesHistoricosConsultora()
        {
            try
            {
                var consultoraCaminoBrillante = GetConsultoraNivelCaminoBrillante();
                if (consultoraCaminoBrillante == null) return new List<BEConsultoraCaminoBrillante.BENivelConsultoraCaminoBrillante>();

                return consultoraCaminoBrillante.NivelConsultora == null ? new List<BEConsultoraCaminoBrillante.BENivelConsultoraCaminoBrillante>()
                                : consultoraCaminoBrillante.NivelConsultora.ToList();
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, usuarioModel.CodigoConsultora, usuarioModel.CodigoISO);
                return new List<BEConsultoraCaminoBrillante.BENivelConsultoraCaminoBrillante>();
            }
        }

        /// <summary>
        /// Obtiene el nivel actual de la Consultora en el programa de Camino Brillante
        /// </summary>
        public BEConsultoraCaminoBrillante.BENivelConsultoraCaminoBrillante GetNivelActualConsultora()
        {
            try
            {
                var consultoraCaminoBrillante = GetConsultoraNivelCaminoBrillante();
                if (consultoraCaminoBrillante == null) return null;

                return consultoraCaminoBrillante.NivelConsultora.FirstOrDefault(x => x.EsActual);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, usuarioModel.CodigoConsultora, usuarioModel.CodigoISO);
                return null;
            }
        }

        /// <summary>
        /// Obtiene Logros Consultora
        /// </summary>
        public LogroCaminoBrillanteModel GetLogroCaminoBrillante(string key)
        {
            try
            {
                var consultoraCaminoBrillante = GetConsultoraNivelCaminoBrillante();
                if (consultoraCaminoBrillante == null) return null;

                if (key == Constantes.CaminoBrillante.Logros.RESUMEN) return Mapper.Map<LogroCaminoBrillanteModel>(consultoraCaminoBrillante.ResumenLogros);
                if (consultoraCaminoBrillante.Logros == null) return null;

                return Mapper.Map<LogroCaminoBrillanteModel>(consultoraCaminoBrillante.Logros.FirstOrDefault(e => e.Id == key));
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, usuarioModel.CodigoConsultora, usuarioModel.CodigoISO);
                return null;
            }
        }

        /// <summary>
        /// Obtiene Kits disponibles para la consultora
        /// </summary>
        public List<KitCaminoBrillanteModel> GetKitsCaminoBrillante()
        {
            try
            {
                var kits = sessionManager.GetKitCaminoBrillante();
                if (kits != null) return Format(Mapper.Map<List<KitCaminoBrillanteModel>>(kits));

                int nivel = 0;
                var nivelConsultora = GetNivelActualConsultora();
                if (nivelConsultora != null)
                {
                    int.TryParse(nivelConsultora.Nivel, out nivel);
                }

                using (var svc = new PedidoServiceClient())
                {
                    var usuario = new ServicePedido.BEUsuario()
                    {
                        PaisID = usuarioModel.PaisID,
                        CampaniaID = usuarioModel.CampaniaID,
                        ConsultoraID = usuarioModel.ConsultoraID,
                        CodigoConsultora = usuarioModel.CodigoConsultora,
                        NivelCaminoBrillante = usuarioModel.NivelCaminoBrillante,
                    };
                    kits = svc.GetKitsCaminoBrillante(usuario).ToList();
                }
                if (kits != null && kits.Any(e => e.FlagHistorico))
                {
                    sessionManager.SetKitCaminoBrillante(kits);
                }
                return Format(Mapper.Map<List<KitCaminoBrillanteModel>>(kits));
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, usuarioModel.CodigoConsultora, usuarioModel.CodigoISO);
                return new List<KitCaminoBrillanteModel>();
            }
        }

        /// <summary>
        /// Obtiene Demostradores disponibles para la consultora
        /// </summary>
        public List<DemostradorCaminoBrillanteModel> GetDesmostradoresCaminoBrillante()
        {
            try
            {
                var demostradores = sessionManager.GetDemostradoresCaminoBrillante();
                if (demostradores != null) return Format(Mapper.Map<List<DemostradorCaminoBrillanteModel>>(demostradores));

                int nivel = 0;
                var nivelConsultora = GetNivelActualConsultora();
                if (nivelConsultora != null)
                {
                    int.TryParse(nivelConsultora.Nivel, out nivel);
                }

                using (var svc = new PedidoServiceClient())
                {
                    var usuario = new ServicePedido.BEUsuario()
                    {
                        PaisID = usuarioModel.PaisID,
                        CampaniaID = usuarioModel.CampaniaID,
                        ConsultoraID = usuarioModel.ConsultoraID,
                        CodigoConsultora = usuarioModel.CodigoConsultora,
                        NivelCaminoBrillante = usuarioModel.NivelCaminoBrillante,
                    };

                    demostradores = svc.GetDemostradoresCaminoBrillante(usuario, "2", "").ToList();
                }

                sessionManager.SetDemostradoresCaminoBrillante(demostradores);

                return Format(Mapper.Map<List<DemostradorCaminoBrillanteModel>>(demostradores));
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, usuarioModel.CodigoConsultora, usuarioModel.CodigoISO);
                return new List<DemostradorCaminoBrillanteModel>();
            }
        }

        private List<DemostradorCaminoBrillanteModel> Format(List<DemostradorCaminoBrillanteModel> items)
        {
            if (items != null && usuarioModel != null) {
                items.Update(e => {
                    e.PaisISO = usuarioModel.CodigoISO;
                });
            }
            return items;
        }

        private List<KitCaminoBrillanteModel> Format(List<KitCaminoBrillanteModel> items)
        {
            if (items != null && usuarioModel != null)
            {
                items.Update(e => {
                    e.PaisISO = usuarioModel.CodigoISO;
                });
            }
            return items;
        }

        /// <summary>
        /// Obtiene el Flag si tiene ofertas especiales
        /// </summary>
        public bool TieneOfertasEspeciales()
        {
            return (GetNivelActual() ?? new NivelCaminoBrillanteModel()).TieneOfertasEspeciales;
        }

        /// <summary>
        /// Validación si puede acceder a Camino Brillante
        /// </summary>
        public bool ValidacionCaminoBrillante()
        {
            var informacion = GetConsultoraNivelCaminoBrillante();
            if (informacion == null || informacion.NivelConsultora == null || usuarioModel == null || !informacion.NivelConsultora.Any()) return false;
            return usuarioModel.CaminoBrillante;
        }

        public bool LoadCaminoBrillante() {
            try
            {
                var nivel = GetNivelActual();
                var userModel = usuarioModel;
                userModel.NivelCaminoBrillante = int.Parse(nivel.CodigoNivel);
                sessionManager.SetUserData(userModel);
            }
            catch (Exception ex)
            {
                //DesactivarCaminoBrillante();
                LogManager.LogManager.LogErrorWebServicesBus(ex, usuarioModel.CodigoConsultora, usuarioModel.CodigoISO);
                return false;
            }
            return true;
        }

        private BEConsultoraCaminoBrillante GetConsultoraNivelCaminoBrillante()
        {
            var resumen = sessionManager.GetConsultoraCaminoBrillante();
            if (resumen == null)
            {
                using (var svc = new UsuarioServiceClient())
                {
                    var beUsuario = Mapper.Map<ServiceUsuario.BEUsuario>(usuarioModel);
                    beUsuario.Zona = usuarioModel.CodigoZona;
                    beUsuario.Region = usuarioModel.CodigorRegion;
                    resumen = svc.GetConsultoraNivelCaminoBrillante(beUsuario);
                }                
                sessionManager.SetConsultoraCaminoBrillante(resumen);                
            }
            return resumen;
        }

    }
}