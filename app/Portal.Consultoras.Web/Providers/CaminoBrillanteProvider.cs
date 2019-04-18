using System.Collections.Generic;
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

                /*
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
                */
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

        public List<BEConsultoraCaminoBrillante.BENivelConsultoraCaminoBrillante> GetNivelesHistoricosConsultora()
        {
            try
            {
                var consultoraCaminoBrillante = ResumenConsultoraCaminoBrillante();
                if (consultoraCaminoBrillante == null) return new List<BEConsultoraCaminoBrillante.BENivelConsultoraCaminoBrillante>();

                return consultoraCaminoBrillante.NivelConsultora == null ? new List<BEConsultoraCaminoBrillante.BENivelConsultoraCaminoBrillante>() 
                                : consultoraCaminoBrillante.NivelConsultora.ToList();
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, usuarioModel.CodigoConsultora, usuarioModel.CodigoISO);
                return null;
            }
        }

        public List<NivelCaminoBrillanteModel> GetNivelesCaminoBrillante(bool matchNivelConsultora = false)
        {
            try
            {
                var consultoraCaminoBrillante = ResumenConsultoraCaminoBrillante();
                if (consultoraCaminoBrillante == null) return new List<NivelCaminoBrillanteModel>();

                var result = Mapper.Map<List<NivelCaminoBrillanteModel>>(consultoraCaminoBrillante.Niveles.ToList());

                if (matchNivelConsultora) {
                    var nivelActualConsultora = GetNivelConsultoraCaminoBrillante();
                    if(nivelActualConsultora == null) return result;

                    int nivel = 0;
                    int nivelActual = 0;
                    if (int.TryParse(nivelActualConsultora.Nivel, out nivelActual)) {
                        result.Each(e => {
                            e.EsPasado = int.TryParse(e.CodigoNivel, out nivel) ? (nivel <= nivelActual) : false;
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

        public LogroCaminoBrillanteModel GetLogroCaminoBrillante(string key)
        {
            try
            {
                var consultoraCaminoBrillante = ResumenConsultoraCaminoBrillante();
                if (consultoraCaminoBrillante == null) return null;

                LogroCaminoBrillanteModel logro = null;

                if (key == Constantes.CaminoBrillante.Logros.RESUMEN) logro = Mapper.Map<LogroCaminoBrillanteModel>(consultoraCaminoBrillante.ResumenLogros);
                else if (consultoraCaminoBrillante.Logros != null) logro = Mapper.Map<LogroCaminoBrillanteModel>(consultoraCaminoBrillante.Logros.FirstOrDefault(e => e.Id == key));

                /*
                if (logro != null) {
                    foreach (var indicador in logro.Indicadores)
                    {
                        foreach (var medalla in indicador.Medallas)
                        {
                            switch (medalla.Tipo)
                            {
                                case Constantes.CaminoBrillante.Logros.Indicadores.Medallas.Codes.CIRC:
                                    medalla.UrlMedalla = Constantes.CaminoBrillante.Logros.Indicadores.Medallas.
                                    break;
                            }
                        }
                    }
                }
                */

                return logro;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, usuarioModel.CodigoConsultora, usuarioModel.CodigoISO);
                return null;
            }
        }

        public List<KitCaminoBrillanteModel> GetKitsCaminoBrillante()
        {
            try
            {
                var kits = sessionManager.GetKitCaminoBrillante();
                if (kits != null) return Mapper.Map<List<KitCaminoBrillanteModel>>(kits);

                int nivel = 0;
                var nivelConsultora = GetNivelConsultoraCaminoBrillante();
                if (nivelConsultora != null) {
                    Int32.TryParse(nivelConsultora.Nivel, out nivel);
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
                if (kits != null && kits.Any(e => e.FlagHistorico)) {
                    sessionManager.SetKitCaminoBrillante(kits);
                }
                return Mapper.Map<List<KitCaminoBrillanteModel>>(kits);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, usuarioModel.CodigoConsultora, usuarioModel.CodigoISO);
                return new List<KitCaminoBrillanteModel>();
            }
        }

        public List<DemostradorCaminoBrillanteModel> GetDesmostradoresCaminoBrillante()
        {
            try
            {
                var demostradores = sessionManager.GetDemostradoresCaminoBrillante();
                if (demostradores != null) return Mapper.Map<List<DemostradorCaminoBrillanteModel>>(demostradores);

                using (var svc = new PedidoServiceClient())
                {
                    demostradores = svc.GetDemostradoresCaminoBrillante(usuarioModel.PaisID, usuarioModel.CampaniaID).ToList();
                }

                if (demostradores != null)
                {
                    sessionManager.SetDemostradoresCaminoBrillante(demostradores);
                }

                return Mapper.Map<List<DemostradorCaminoBrillanteModel>>(demostradores);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, usuarioModel.CodigoConsultora, usuarioModel.CodigoISO);
                return new List<DemostradorCaminoBrillanteModel>();
            }
        }

        public bool TieneOfertasEspeciles(int nivelActual) {
            var informacion = ResumenConsultoraCaminoBrillante();
            return informacion.Niveles.Where(e => e.CodigoNivel == nivelActual.ToString()).Select(e => e.TieneOfertasEspeciales).FirstOrDefault();
        }

        public bool TieneOfertasEspeciales()
        {
            var nivelConsultora = GetNivelConsultoraCaminoBrillante();
            if (nivelConsultora == null) return false;

            var nivelesCaminoBrillante = GetNivelesCaminoBrillante();
            if (nivelesCaminoBrillante == null) return false;

            return nivelesCaminoBrillante.Where(e => e.CodigoNivel == nivelConsultora.Nivel)
                        .Select(e => e.TieneOfertasEspeciales).FirstOrDefault();
        }

        public bool ValidacionCaminoBrillante() {
            var informacion = ResumenConsultoraCaminoBrillante();
            if (informacion == null || informacion.NivelConsultora == null || informacion.NivelConsultora.Count() == 0) return false;
            return true;
        }

        public decimal? MontoFaltanteSiguienteNivel(out string nivelSiguiente) {
            nivelSiguiente = null;

            var nivelConsultora = GetNivelConsultoraCaminoBrillante();
            if (nivelConsultora == null) return null;

            var nivelesCaminoBrillante = GetNivelesCaminoBrillante();
            if (nivelesCaminoBrillante == null) return null;
            
            var nivelActual = nivelesCaminoBrillante.Where(e => e.CodigoNivel == nivelConsultora.Nivel).FirstOrDefault();
            if (nivelActual == null) return null;

            int idxNIvel = nivelesCaminoBrillante.IndexOf(nivelActual);
            if (idxNIvel + 1 > nivelesCaminoBrillante.Count) return null;

            var _nivelSiguiente = nivelesCaminoBrillante[idxNIvel + 1];

            var consultoraHistoricos = GetNivelesHistoricosConsultora();
            decimal _montoPedido = 0;
            var montoPedido = consultoraHistoricos.Where(e => decimal.TryParse(e.MontoPedido, out _montoPedido)).Sum(e => decimal.Parse(e.MontoPedido));
           
            decimal montoMinimo = 0;
            if (decimal.TryParse(_nivelSiguiente.MontoMinimo, out montoMinimo))
            {
                nivelSiguiente = _nivelSiguiente.CodigoNivel;
                return montoMinimo - montoPedido;
            }
            
            return null;

        }

    }
}