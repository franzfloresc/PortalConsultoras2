using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.SessionManager;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Portal.Consultoras.Web.Providers
{
    public class PedidoWebProvider
    {
        protected ISessionManager sessionManager;
        protected ConfiguracionManagerProvider _configuracionManager;

        public PedidoWebProvider()
        {
            sessionManager = SessionManager.SessionManager.Instance;
            _configuracionManager = new ConfiguracionManagerProvider();
        }
        
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
                    using (var pedidoServiceClient = new PedidoServiceClient())
                    {
                        var bePedidoWebDetalleParametros = new BEPedidoWebDetalleParametros
                        {
                            PaisId = userData.PaisID,
                            CampaniaId = userData.CampaniaID,
                            ConsultoraId = userData.ConsultoraID,
                            Consultora = userData.NombreConsultora,
                            EsBpt = esOpt == 1, // ya no se utiliza en el sp, confirmar para no enviar el campo
                            CodigoPrograma = userData.CodigoPrograma,
                            NumeroPedido = userData.ConsecutivoNueva
                        };

                        detallesPedidoWeb = pedidoServiceClient.SelectByCampania(bePedidoWebDetalleParametros).ToList();
                    }
                }

                foreach (var item in detallesPedidoWeb)
                {
                    item.ClienteID = string.IsNullOrEmpty(item.Nombre) ? (short)0 : Convert.ToInt16(item.ClienteID);
                    item.Nombre = string.IsNullOrEmpty(item.Nombre) ? userData.NombreConsultora : item.Nombre;
                    item.DescripcionOferta = ObtenerDescripcionOferta(item);
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

        public virtual List<BEPedidoWebDetalle> ObtenerPedidoWebSetDetalleAgrupado(int esOpt)
        {
            var detallesPedidoWeb = (List<BEPedidoWebDetalle>)null;
            var userData = sessionManager.GetUserData();

            try
            {
                detallesPedidoWeb = sessionManager.GetDetallesPedidoSetAgrupado();

                if (detallesPedidoWeb == null)
                {
                    using (var pedidoServiceClient = new PedidoServiceClient())
                    {

                        var bePedidoWebDetalleParametros = new BEPedidoWebDetalleParametros
                        {
                            PaisId = userData.PaisID,
                            CampaniaId = userData.CampaniaID,
                            ConsultoraId = userData.ConsultoraID,
                            Consultora = userData.NombreConsultora,
                            EsBpt = esOpt == 1,
                            CodigoPrograma = userData.CodigoPrograma,
                            NumeroPedido = userData.ConsecutivoNueva,
                            AgruparSet = true
                        };

                        detallesPedidoWeb = pedidoServiceClient.SelectByCampania(bePedidoWebDetalleParametros).ToList();
                    }
                }

                foreach (var item in detallesPedidoWeb)
                {
                    item.ClienteID = string.IsNullOrEmpty(item.Nombre) ? (short)0 : Convert.ToInt16(item.ClienteID);
                    item.Nombre = string.IsNullOrEmpty(item.Nombre) ? userData.NombreConsultora : item.Nombre;
                    item.DescripcionOferta = ObtenerDescripcionOferta(item);
                }
                var observacionesProl = sessionManager.GetObservacionesProl();
                if (detallesPedidoWeb.Count > 0 && observacionesProl != null)
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
                sessionManager.SetDetallesPedido(detallesPedidoWeb);

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
            var nuevasObservaciones = new List<ObservacionModel>();

            List<BEPedidoWebDetalle> cuvHijos = TraerHijosFaltantesEnObsPROL(pedido, paisId, campaniaId, consultoraId, pedidoId);

            foreach (var item in pedObs)
            {
                listaCUVsAEvaluar = new List<string>();
                item.Mensaje = string.Empty;

                listaCUVsAEvaluar.Add(item.CUV);

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

            //sessionManager.SetObservacionesProl(null);

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

        private string ObtenerDescripcionOferta(BEPedidoWebDetalle item)
        {
            var descripcion = "";
            var pedidoValidado = sessionManager.GetPedidoValidado();

            if (pedidoValidado)
            {
                if (!string.IsNullOrWhiteSpace(item.DescripcionOferta))
                {
                    descripcion = (item.DescripcionOferta.Replace("[", "")).Replace("]", "");
                }
                else if (item.ConfiguracionOfertaID == Constantes.TipoOferta.Liquidacion)
                {
                    descripcion = "OFERTA LIQUIDACIÓN";
                }
                else if (item.ConfiguracionOfertaID == Constantes.TipoOferta.Flexipago)
                {
                    descripcion = "OFERTA FLEXIPAGO";
                }
                else
                {
                    descripcion = "";
                }
            }
            else
            {
                if (item.FlagConsultoraOnline)
                {
                    descripcion = "CLIENTE ONLINE";
                }
                else
                {
                    if (item.OrigenPedidoWeb == Constantes.OrigenPedidoWeb.DesktopPedidoOfertaFinal)
                    {
                        descripcion = "";
                    }
                    else if (item.OrigenPedidoWeb == Constantes.OrigenPedidoWeb.MobilePedidoOfertaFinal)
                    {
                        descripcion = "";
                    }
                    else if (!string.IsNullOrWhiteSpace(item.DescripcionOferta))
                    {
                        descripcion = item.DescripcionOferta;
                    }
                    else if (item.ConfiguracionOfertaID == Constantes.TipoOferta.Liquidacion)
                    {
                        descripcion = "OFERTA LIQUIDACIÓN";
                    }
                    else if (item.ConfiguracionOfertaID == Constantes.TipoOferta.Flexipago)
                    {
                        descripcion = "OFERTA FLEXIPAGO";
                    }
                    else if (item.TipoOfertaSisID == Constantes.ConfiguracionOferta.ShowRoom)
                    {
                        descripcion = "OFERTAS ESPECIALES GANA+";
                    }
                    else
                    {
                        descripcion = "";
                    }
                }
            }

            return descripcion;
        }
        
    }
}