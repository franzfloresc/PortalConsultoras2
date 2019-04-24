﻿using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.SessionManager;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Portal.Consultoras.Web.ServiceUsuario;

namespace Portal.Consultoras.Web.Providers
{
    public class PedidoWebProvider
    {
        protected ISessionManager sessionManager;
        protected ConfiguracionManagerProvider _configuracionManager;

        public PedidoWebProvider() : this(SessionManager.SessionManager.Instance, new ConfiguracionManagerProvider())
        {
        }

        public PedidoWebProvider(ISessionManager sessionManager, ConfiguracionManagerProvider configuracionManagerProvider)
        {
            this.sessionManager = sessionManager;
            this._configuracionManager = configuracionManagerProvider;
        }

        /// <summary>
        /// Solo Obtiene resultado de dbo.PedidoWeb
        /// </summary>
        /// <param name="paisId"></param>
        /// <param name="campaniaId">Codigo Campaña: ejm 201901</param>
        /// <param name="consultoraId"></param>
        /// <returns></returns>
        public virtual BEPedidoWeb ObtenerPedidoWeb(int paisId, int campaniaId, long consultoraId)
        {
            var pedidoWeb = (BEPedidoWeb)null;

            try
            {
                pedidoWeb = sessionManager.GetPedidoWeb();

                if (pedidoWeb == null)
                    using (var pedidoServiceClient = new PedidoServiceClient())
                    {
                        pedidoWeb = pedidoServiceClient.GetPedidoWebByCampaniaConsultora(
                            paisId,
                            campaniaId,
                            consultoraId
                        );
                    }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, consultoraId.ToString(), paisId.ToString());
            }
            finally
            {
                pedidoWeb = pedidoWeb ?? new BEPedidoWeb();
                sessionManager.SetPedidoWeb(pedidoWeb);
            }

            return pedidoWeb;
        }

        #region PedidoWebDetalle - PedidoWebSet Agrupado

        public virtual List<BEPedidoWebDetalle> ObtenerPedidoWebDetalle(int esOpt)
        {
            var detallesPedidoWeb = (List<BEPedidoWebDetalle>)null;
            var userData = sessionManager.GetUserData();

            try
            {
                if (userData == null)
                {
                    return new List<BEPedidoWebDetalle>();
                }

                detallesPedidoWeb = sessionManager.GetDetallesPedido();
                if (detallesPedidoWeb == null)
                {
                    detallesPedidoWeb = ObtenerPedidoWebDetalleService(userData, false);
                    //using (var pedidoServiceClient = new PedidoServiceClient())
                    //{
                    //    var bePedidoWebDetalleParametros = new BEPedidoWebDetalleParametros
                    //    {
                    //        PaisId = userData.PaisID,
                    //        CampaniaId = userData.CampaniaID,
                    //        ConsultoraId = userData.ConsultoraID,
                    //        Consultora = userData.NombreConsultora,
                    //        CodigoPrograma = userData.CodigoPrograma,
                    //        NumeroPedido = userData.ConsecutivoNueva
                    //    };
                    //    detallesPedidoWeb = pedidoServiceClient.SelectByCampaniaWithLabelProgNuevas(bePedidoWebDetalleParametros).ToList();
                    //}
                }

                var pedidoValidado = sessionManager.GetPedidoValidado();
                var revistaDigital = sessionManager.GetRevistaDigital();
                var suscripcionActiva = (revistaDigital.EsSuscrita && revistaDigital.EsActiva);
                foreach (var item in detallesPedidoWeb)
                {
                    item.ClienteID = string.IsNullOrEmpty(item.Nombre) ? (short)0 : Convert.ToInt16(item.ClienteID);
                    item.Nombre = string.IsNullOrEmpty(item.Nombre) ? userData.NombreConsultora : item.Nombre;
                    item.DescripcionOferta = ObtenerDescripcionOferta(item, pedidoValidado, suscripcionActiva, userData.NuevasDescripcionesBuscador);
                }

                var observacionesProl = sessionManager.GetObservacionesProl();
                if (observacionesProl != null && detallesPedidoWeb.Count > 0)
                {
                    detallesPedidoWeb = PedidoConObservaciones(detallesPedidoWeb, observacionesProl);
                }

                userData.PedidoID = detallesPedidoWeb.Count > 0 ? detallesPedidoWeb[0].PedidoID : 0;
                sessionManager.SetUserData(userData);
                sessionManager.SetDetallesPedido(detallesPedidoWeb);
            }
            catch (Exception ex)
            {
                detallesPedidoWeb = detallesPedidoWeb ?? new List<BEPedidoWebDetalle>();
                sessionManager.SetDetallesPedido(detallesPedidoWeb);

                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return detallesPedidoWeb;
        }

        public virtual List<BEPedidoWebDetalle> ObtenerPedidoWebSetDetalleAgrupado(bool noSession = false)
        {
            var detallesPedidoWeb = (List<BEPedidoWebDetalle>)null;
            var userData = sessionManager.GetUserData();

            try
            {
                if (userData == null)
                {
                    return new List<BEPedidoWebDetalle>();
                }

                detallesPedidoWeb = sessionManager.GetDetallesPedidoSetAgrupado();

                if (detallesPedidoWeb == null || noSession)
                {
                    detallesPedidoWeb = ObtenerPedidoWebDetalleService(userData, true);
                    //using (var pedidoServiceClient = new PedidoServiceClient())
                    //{
                    //    var bePedidoWebDetalleParametros = new BEPedidoWebDetalleParametros
                    //    {
                    //        PaisId = userData.PaisID,
                    //        CampaniaId = userData.CampaniaID,
                    //        ConsultoraId = userData.ConsultoraID,
                    //        Consultora = userData.NombreConsultora,
                    //        CodigoPrograma = userData.CodigoPrograma,
                    //        NumeroPedido = userData.ConsecutivoNueva,
                    //        AgruparSet = true
                    //    };
                    //    detallesPedidoWeb = pedidoServiceClient.SelectByCampaniaWithLabelProgNuevas(bePedidoWebDetalleParametros).ToList();
                    //}
                }

                var pedidoValidado = sessionManager.GetPedidoValidado();
                var revistaDigital = sessionManager.GetRevistaDigital();
                var suscripcionActiva = (revistaDigital.EsSuscrita && revistaDigital.EsActiva);

                foreach (var item in detallesPedidoWeb)
                {
                    item.ClienteID = string.IsNullOrEmpty(item.Nombre) ? (short)0 : Convert.ToInt16(item.ClienteID);
                    item.Nombre = string.IsNullOrEmpty(item.Nombre) ? "Para mí" : item.Nombre;
                    item.DescripcionOferta = ObtenerDescripcionOferta(item, pedidoValidado, suscripcionActiva, userData.NuevasDescripcionesBuscador);
                }

                var observacionesProl = sessionManager.GetObservacionesProl();
                if (observacionesProl != null && detallesPedidoWeb.Count > 0)
                {
                    detallesPedidoWeb = PedidoConObservacionesAgrupado(detallesPedidoWeb, observacionesProl, userData.PaisID, userData.CampaniaID, userData.ConsultoraID, userData.PedidoID);
                }

                userData.PedidoID = detallesPedidoWeb.Count > 0 ? detallesPedidoWeb[0].PedidoID : 0;

                sessionManager.SetUserData(userData);

                sessionManager.SetDetallesPedidoSetAgrupado(detallesPedidoWeb);
            }
            catch (Exception ex)
            {
                detallesPedidoWeb = detallesPedidoWeb ?? new List<BEPedidoWebDetalle>();
                sessionManager.SetDetallesPedidoSetAgrupado(detallesPedidoWeb);

                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return detallesPedidoWeb;
        }

        private List<BEPedidoWebDetalle> PedidoConObservaciones(List<BEPedidoWebDetalle> pedido, List<ObservacionModel> observaciones)
        {
            var pedObs = pedido;
            var txtBuil = new StringBuilder();

            foreach (var item in pedObs)
            {
                item.Mensaje = string.Empty;
                var temp = observaciones.Where(o => o.CUV == item.CUV).ToList();
                if (temp.Count != 0)
                {
                    if (temp.Any(o => o.Caso == 0)) item.TipoObservacion = 0;
                    else item.TipoObservacion = temp[0].Tipo;

                    foreach (var ob in temp)
                    {
                        txtBuil.Append(ob.Descripcion + "<br/>");
                    }
                    item.Mensaje = txtBuil.ToString();
                    txtBuil.Clear();
                }
                else item.TipoObservacion = 0;
            }
            return pedObs.OrderByDescending(p => p.TipoObservacion).ToList();
        }

        private List<BEPedidoWebDetalle> PedidoConObservacionesAgrupado(List<BEPedidoWebDetalle> pedido, List<ObservacionModel> observaciones, int paisId, int campaniaId, long consultoraId, int pedidoId)
        {
            var pedObs = pedido;
            List<string> listaCUVsAEvaluar;
            var txtBuil = new StringBuilder();

            List<BEPedidoWebDetalle> cuvHijos = TraerHijosFaltantesEnObsPROL(pedido, paisId, campaniaId, consultoraId, pedidoId);

            foreach (var item in pedObs)
            {
                listaCUVsAEvaluar = new List<string>();
                item.Mensaje = string.Empty;

                if (cuvHijos.Any(x => x.SetID == item.SetID))
                {
                    listaCUVsAEvaluar.AddRange(cuvHijos.Where(x => x.SetID == item.SetID).Select(x => x.CUV));
                }
                else
                    listaCUVsAEvaluar.Add(item.CUV);

                var temp = observaciones.Where(o => listaCUVsAEvaluar.Contains(o.CUV)).ToList();


                if (temp.Count != 0)
                {
                    if (temp.Any(o => o.Caso == 0)) item.TipoObservacion = 0;
                    else item.TipoObservacion = temp[0].Tipo;

                    foreach (var ob in temp)
                    {
                        txtBuil.Append(ob.Descripcion + "<br/>");
                    }
                    item.Mensaje = txtBuil.ToString();
                    txtBuil.Clear();
                }
                else item.TipoObservacion = 0;
            }

            return pedObs.OrderByDescending(p => p.TipoObservacion).ToList();
        }

        private List<BEPedidoWebDetalle> TraerHijosFaltantesEnObsPROL(List<BEPedidoWebDetalle> pedido, int paisId, int campaniaId, long consultoraId, int pedidoId)
        {
            var idSetList = pedido.Where(x => x.SetID != 0).Select(x => x.SetID).ToList();
            var cuvHijos = new List<BEPedidoWebDetalle>();

            if (idSetList.Any())
            {
                using (var sv = new PedidoServiceClient())
                {
                    cuvHijos = sv.ObtenerCuvSetDetalle(paisId, campaniaId, consultoraId, pedidoId, String.Join(",", idSetList)).ToList();

                }
            }

            return cuvHijos;
        }

        private string ObtenerDescripcionOferta(BEPedidoWebDetalle item, bool pedidoValidado, bool suscripcion, Dictionary<string, string> lista)
        {
            var descripcion = "";

            descripcion = Util.obtenerNuevaDescripcionProductoDetalle(item.ConfiguracionOfertaID, pedidoValidado,
                item.FlagConsultoraOnline, item.OrigenPedidoWeb, lista, suscripcion, item.TipoEstrategiaCodigo, item.MarcaID,
                item.CodigoCatalago, item.DescripcionOferta, item.EsCuponNuevas, item.EsElecMultipleNuevas, item.EsPremioElectivo, item.EsCuponIndependiente);

            return descripcion;
        }

        private List<BEPedidoWebDetalle> ObtenerPedidoWebDetalleService(UsuarioModel userModel, bool agruparSet)
        {
            var bePedidoWebDetalleParametros = new BEPedidoWebDetalleParametros
            {
                PaisId = userModel.PaisID,
                CampaniaId = userModel.CampaniaID,
                ConsultoraId = userModel.ConsultoraID,
                Consultora = userModel.NombreConsultora,
                CodigoPrograma = userModel.CodigoPrograma,
                NumeroPedido = userModel.ConsecutivoNueva,
                AgruparSet = agruparSet
            };

            List<BEPedidoWebDetalle> detallesPedidoWeb;
            using (var pedidoServiceClient = new PedidoServiceClient())
            {
                detallesPedidoWeb = pedidoServiceClient.SelectByCampaniaWithLabelProgNuevas(bePedidoWebDetalleParametros).ToList();
            }
            return detallesPedidoWeb;
        }

        #endregion

        public virtual List<BEPedidoWebDetalle> GetDetallePedidoAgrupadoByCampania(int campaniaId)
        {
            List<BEPedidoWebDetalle> detallePedidoWeb;
            var userData = sessionManager.GetUserData();

            try
            {
                using (var pedidoServiceClient = new PedidoServiceClient())
                {

                    var bePedidoWebDetalleParametros = new BEPedidoWebDetalleParametros
                    {
                        PaisId = userData.PaisID,
                        CampaniaId = campaniaId,
                        ConsultoraId = userData.ConsultoraID,
                        Consultora = userData.NombreConsultora,
                        CodigoPrograma = userData.CodigoPrograma,
                        NumeroPedido = userData.ConsecutivoNueva,
                        AgruparSet = true
                    };

                    detallePedidoWeb = pedidoServiceClient.SelectByCampania(bePedidoWebDetalleParametros).ToList();
                }

                foreach (var item in detallePedidoWeb)
                {
                    item.ClienteID = string.IsNullOrEmpty(item.Nombre) ? (short)0 : Convert.ToInt16(item.ClienteID);
                    item.Nombre = string.IsNullOrEmpty(item.Nombre) ? "Para mí" : item.Nombre;
                }
            }
            catch (Exception ex)
            {
                detallePedidoWeb = new List<BEPedidoWebDetalle>();

                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return detallePedidoWeb;
        }

        public BEPedidoDetalleResult InsertPedidoDetalle(BEPedidoDetalle pedidoDetalle)
        {
            BEPedidoDetalleResult pedidoDetalleResult;
            using (var pedidoServiceClient = new PedidoServiceClient())
            {
                pedidoDetalleResult = pedidoServiceClient.InsertPedidoDetalle(pedidoDetalle);
            }

            return pedidoDetalleResult;
        }

        public BEPedidoDetalleResult UpdatePedidoDetalle(BEPedidoDetalle pedidoDetalle)
        {
            BEPedidoDetalleResult pedidoDetalleResult;
            using (var pedidoServiceClient = new PedidoServiceClient())
            {
                pedidoDetalleResult = pedidoServiceClient.UpdatePedidoDetalle(pedidoDetalle);
            }

            return pedidoDetalleResult;
        }

        public async Task<BEPedidoDetalleResult> EliminarPedidoDetalle(BEPedidoDetalle pedidoDetalle)
        {
            BEPedidoDetalleResult pedidoDetalleResult;
            using (var pedidoServiceClient = new PedidoServiceClient())
            {
                pedidoDetalleResult = await pedidoServiceClient.DeletePedidoAsync(pedidoDetalle);
            }

            return pedidoDetalleResult;
        }

        public async Task EliminarPedidoWebDetalle(BEPedidoWebDetalle pedidoDetalle)
        {
            using (var pedidoServiceClient = new PedidoServiceClient())
            {
                await pedidoServiceClient.DelPedidoWebDetalleAsync(pedidoDetalle);
            }
        }

        public bool EsHoraReserva(UsuarioModel usuario, DateTime fechaHora)
        {
            if (!usuario.DiaPROL)
                return false;

            var horaNow = new TimeSpan(fechaHora.Hour, fechaHora.Minute, 0);
            var esHorarioReserva = (fechaHora < usuario.FechaInicioCampania) ?
                (horaNow > usuario.HoraInicioPreReserva && horaNow < usuario.HoraFinPreReserva) :
                (horaNow > usuario.HoraInicioReserva && horaNow < usuario.HoraFinReserva);

            if (!esHorarioReserva)
                return false;

            if (usuario.CodigoISO != Constantes.CodigosISOPais.Peru)
                return (BuildFechaNoHabil(usuario) == 0);

            return true;
        }

        public int GetPedidoPendientes(UsuarioModel usuario)
        {
            if (_configuracionManager.GetMostrarPedidosPendientesFromConfig())
            {
                var paisesConsultoraOnline = _configuracionManager.GetPaisesConConsultoraOnlineFromConfig();
                if (paisesConsultoraOnline.Contains(usuario.CodigoISO)
                    && usuario.EsConsultora())
                {
                    using (var svc = new UsuarioServiceClient())
                    {
                        var cantPedidosPendientes = svc.GetCantidadSolicitudesPedido(usuario.PaisID, usuario.ConsultoraID, usuario.CampaniaID);

                        return cantPedidosPendientes;
                    }
                }
            }

            return 0;
        }

        private int BuildFechaNoHabil(UsuarioModel usuario)
        {
            var result = 0;
            if (usuario != null && usuario.RolID != 0)
            {
                using (var sv = new PedidoServiceClient())
                {
                    result = sv.GetFechaNoHabilFacturacion(usuario.PaisID, usuario.CodigoZona, DateTime.Today);
                }
            }

            return result;
        }

    }
}