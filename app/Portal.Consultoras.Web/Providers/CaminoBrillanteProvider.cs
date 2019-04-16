using System.Collections.Generic;
using Portal.Consultoras.Web.ServiceUsuario;
using System.Linq;
using System;
using Portal.Consultoras.Web.SessionManager;
using Portal.Consultoras.Web.Models;
using AutoMapper;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Common;

namespace Portal.Consultoras.Web.Providers
{
    public class CaminoBrillanteProvider
    {
        protected ISessionManager sessionManager = SessionManager.SessionManager.Instance;

        private UsuarioModel usuarioModel { get { return sessionManager.GetUserData(); } }
        private ServiceUsuario.BEUsuario _userData { get { return Mapper.Map<ServiceUsuario.BEUsuario>(usuarioModel); } }
        private string codigoNivel;

        public BEConsultoraCaminoBrillante ResumenConsultoraCaminoBrillante()
        {
            var resumen = sessionManager.GetConsultoraCaminoBrillante();
            if (resumen == null)
            {
                using (var svc = new UsuarioServiceClient())
                {
                    resumen = svc.GetConsultoraNivelCaminoBrillante(_userData);
                }
                sessionManager.SetConsultoraCaminoBrillante(resumen);

                if (resumen.Niveles != null)
                {
                    var nivelActualConsultora = GetNivelConsultoraCaminoBrillante();

                    int nivel = 0;
                    int nivelActual = 0;
                    int.TryParse(nivelActualConsultora.Nivel, out nivelActual);

                    foreach (var item in resumen.Niveles)
                    {
                        int.TryParse(item.CodigoNivel, out nivel);
                        item.UrlImagenNivel = Constantes.CaminoBrillante.Niveles.Iconos.Keys.Contains(item.CodigoNivel) ?
                                           Constantes.CaminoBrillante.Niveles.Iconos[item.CodigoNivel][nivel <= nivelActual ? 1 : 0] : string.Empty;
                    }
                }
            }
            return resumen;
        }

        public BENivelCaminoBrillante ObtenerNivelActualConsultora()
        {
            try
            {
                var oConsultora = ResumenConsultoraCaminoBrillante();
                if (oConsultora == null || oConsultora.NivelConsultora.Count() == 0 || oConsultora.Niveles.Count() == 0) return null;
                codigoNivel = oConsultora.NivelConsultora.Where(x => x.EsActual).Select(z => z.Nivel).FirstOrDefault();
                return oConsultora.Niveles.FirstOrDefault(x => x.CodigoNivel == codigoNivel);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, usuarioModel.CodigoConsultora, usuarioModel.CodigoISO);
                return null;
            }
        }

        public List<BENivelCaminoBrillante> GetNivelesCaminoBrillante()
        {
            try
            {
                var consultoraCaminoBrillante = ResumenConsultoraCaminoBrillante();
                if (consultoraCaminoBrillante == null) return new List<BENivelCaminoBrillante>();

                return consultoraCaminoBrillante.Niveles.ToList();
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, usuarioModel.CodigoConsultora, usuarioModel.CodigoISO);
                return new List<BENivelCaminoBrillante>();
            }
        }

        public BEConsultoraCaminoBrillante.BENivelConsultoraCaminoBrillante GetNivelConsultoraCaminoBrillante()
        {
            try
            {
                var consultoraCaminoBrillante = ResumenConsultoraCaminoBrillante();
                if (consultoraCaminoBrillante == null) return null;

                return consultoraCaminoBrillante.NivelConsultora.FirstOrDefault(x => x.EsActual);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, usuarioModel.CodigoConsultora, usuarioModel.CodigoISO);
                return null;
            }
        }

        public BELogroCaminoBrillante GetLogroCaminoBrillante(string key)
        {
            try
            {
                var consultoraCaminoBrillante = ResumenConsultoraCaminoBrillante();
                if (consultoraCaminoBrillante == null) return null;

                if (key == Constantes.CaminoBrillante.Logros.RESUMEN) return consultoraCaminoBrillante.ResumenLogros;
                if (consultoraCaminoBrillante.Logros == null) return null;

                return consultoraCaminoBrillante.Logros.FirstOrDefault(e => e.Id == key);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, usuarioModel.CodigoConsultora, usuarioModel.CodigoISO);
                return null;
            }
        }

        public List<BEKitCaminoBrillante> GetKitsCaminoBrillante()
        {
            try
            {
                var kits = sessionManager.GetKitCaminoBrillante();
                if (kits != null) return kits;

                int nivel = 0;
                var nivelConsultora = GetNivelConsultoraCaminoBrillante();
                if (nivelConsultora != null) {
                    Int32.TryParse(nivelConsultora.PeriodoCae, out nivel);
                }

                using (var svc = new PedidoServiceClient())
                {
                    var usuario = new ServicePedido.BEUsuario() {
                        PaisID = usuarioModel.PaisID,
                        CampaniaID = usuarioModel.CampaniaID,
                        ConsultoraID = usuarioModel.ConsultoraID,
                        CodigoConsultora = usuarioModel.CodigoConsultora
                    };
                    kits = svc.GetKitsCaminoBrillante(usuario, nivel).ToList();
                }
                if (kits != null && !kits.Any(e => e.FlagHistorico)) {
                    sessionManager.SetKitCaminoBrillante(kits);
                }
                return kits;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, usuarioModel.CodigoConsultora, usuarioModel.CodigoISO);
                return new List<BEKitCaminoBrillante>();
            }
        }

        public List<BEDesmostradoresCaminoBrillante> GetDesmostradoresCaminoBrillante()
        {
            try
            {
                var demostradores = sessionManager.GetDemostradoresCaminoBrillante();
                if (demostradores != null) return demostradores;

                using (var svc = new PedidoServiceClient())
                {
                    demostradores = svc.GetDemostradoresCaminoBrillante(usuarioModel.PaisID, usuarioModel.CampaniaID).ToList();
                }

                if (demostradores != null)
                {
                    sessionManager.SetDemostradoresCaminoBrillante(demostradores);
                }

                return demostradores;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, usuarioModel.CodigoConsultora, usuarioModel.CodigoISO);
                return new List<BEDesmostradoresCaminoBrillante>();
            }
        }

        public bool TieneOfertasEspeciles() {
            return true;
        }

        public bool ValidacionCaminoBrillante() {
            var informacion = ResumenConsultoraCaminoBrillante();
            if (informacion == null || informacion.NivelConsultora == null || informacion.NivelConsultora.Count() == 0) return false;
            return true;
        }

    }
}