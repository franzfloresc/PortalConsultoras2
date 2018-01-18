using Portal.Consultoras.Common;
using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using Portal.Consultoras.BizLogic.Pedido;

using System;
using System.Collections.Generic;
using System.Text;
using System.Transactions;
using System.Linq;

namespace Portal.Consultoras.BizLogic
{
    public class BLPedidoRechazado : IPedidoRechazadoBusinessLogic
    {
        public int InsertarPedidoRechazadoXML(string paisISO, List<BEPedidoRechazadoSicc> listBEPedidoRechazado)
        {           

            DAPedidoRechazado dAPedidoRechazado = null;
            try
            {
                int paisID = Util.GetPaisID(paisISO);
                if (paisID > 0) dAPedidoRechazado = new DAPedidoRechazado(paisID);
            }
            catch(Exception ex) { LogManager.SaveLog(ex, "", paisISO); }
            if (dAPedidoRechazado == null) return 0;
            
            try
            {
                string xml = CrearClienteXML(listBEPedidoRechazado);

                TransactionOptions transactionOptions = new TransactionOptions { IsolationLevel = IsolationLevel.RepeatableRead };
                using (TransactionScope transactionScope = new TransactionScope(TransactionScopeOption.Required, transactionOptions))
                {
                    dAPedidoRechazado.InsertarPedidoRechazadoXML("OK", string.Empty, xml);
                    transactionScope.Complete();
                }
                return 1;
            }
            catch (Exception ex) {
                try { dAPedidoRechazado.InsertarPedidoRechazadoXML("Error",  ex.Message + "(" + ex.StackTrace + ")", ""); }
                catch (Exception ex2)
                {
                    LogManager.SaveLog(ex, "", paisISO);
                    LogManager.SaveLog(ex2, "", paisISO);
                }                
            }
            return 0;
        }

        public void UpdatePedidoRechazadoVisualizado(int paisID, long logGPRValidacionId)
        {
            DAPedidoRechazado dAPedidoRechazado = new DAPedidoRechazado(paisID);
            dAPedidoRechazado.UpdatePedidoRechazadoVisualizado(logGPRValidacionId);
        }

        public List<BELogGPRValidacion> GetBELogGPRValidacionByGetLogGPRValidacionId(int paisID, long logGPRValidacionId, long ConsultoraID)
        {
            DALogGPRValidacion dALogGPRValidacion = new DALogGPRValidacion(paisID);
            return dALogGPRValidacion.GetByLogGPRValidacionId(logGPRValidacionId, ConsultoraID);
        }

        public List<BELogGPRValidacionDetalle> GetListBELogGPRValidacionDetalleBELogGPRValidacionByLogGPRValidacionId(int paisID, long logGPRValidacionId)
        {
            DALogGPRValidacionDetalle dALogGPRValidacionDetalle = new DALogGPRValidacionDetalle(paisID);
            return dALogGPRValidacionDetalle.GetListByLogGPRValidacionId(logGPRValidacionId);
        }

        public BEGPRBanner GetMotivoRechazo(BEGPRUsuario usuario)
        {
            var beGPRBanner = new BEGPRBanner();

            beGPRBanner.BannerUrl = Enumeradores.RechazoBannerUrl.Ninguna;

            if (usuario.IndicadorGPRSB == (int)Enumeradores.IndicadorGPR.SinAccion) return beGPRBanner;
            if (usuario.IndicadorGPRSB == (int)Enumeradores.IndicadorGPR.Descargado)
            {
                string CampaniaNro = (usuario.CampaniaID > 99999 ? usuario.CampaniaID.Substring(4, 2) : string.Empty);
                beGPRBanner.BannerTitulo = string.Format(Resources.MotivoRechazoMessages.FacturadoTitulo, CampaniaNro);
                beGPRBanner.BannerMensaje = Resources.MotivoRechazoMessages.FacturadoMensaje;
                beGPRBanner.MostrarBannerRechazo = true;
                return beGPRBanner;
            }
            beGPRBanner.BannerTitulo = Resources.MotivoRechazoMessages.RechazadoTitulo;

            var beProcesoPedidoRechazado = new BLProcesoPedidoRechazado().ObtenerProcesoPedidoRechazadoGPR(usuario.PaisID, usuario.CampaniaID, usuario.ConsultoraID);

            if (beProcesoPedidoRechazado.IdProcesoPedidoRechazado == 0) return beGPRBanner;

            List<BEPedidoRechazado> listaRechazo = beProcesoPedidoRechazado.olstBEPedidoRechazado != null ? beProcesoPedidoRechazado.olstBEPedidoRechazado : new List<BEPedidoRechazado>();
            if (listaRechazo.Any()) listaRechazo = listaRechazo.Where(r => r.Rechazado && !string.IsNullOrEmpty(r.MotivoRechazo)).ToList();
            else return beGPRBanner;

            BEPedidoRechazado pedidoRechazado = listaRechazo.FirstOrDefault(p => p.MotivoRechazo == Constantes.GPRMotivoRechazo.ActualizacionDeuda);
            if (pedidoRechazado != null && usuario.MontoDeuda > 0)
            {
                string montoDeuda = usuario.Simbolo + " " + Util.DecimalToStringFormat(pedidoRechazado.Valor, usuario.CodigoISO);
                beGPRBanner.BannerMensaje = string.Format(Resources.MotivoRechazoMessages.DeudaMensaje, montoDeuda);
                beGPRBanner.BannerUrl = Enumeradores.RechazoBannerUrl.Deuda;
                beGPRBanner.RechazadoXdeuda = true;
            }

            string mensajeParcial = null;
            if (listaRechazo.FirstOrDefault(p => p.MotivoRechazo == Constantes.GPRMotivoRechazo.MontoMinino) != null)
            {
                mensajeParcial = string.Format(Resources.MotivoRechazoMessages.MontoMinimoMensaje, usuario.Simbolo, Util.DecimalToStringFormat(usuario.MontoMinimoPedido, usuario.CodigoISO));
            }
            else if (listaRechazo.FirstOrDefault(p => p.MotivoRechazo == Constantes.GPRMotivoRechazo.MontoMaximo) != null)
            {
                mensajeParcial = string.Format(Resources.MotivoRechazoMessages.MontoMaximoMensaje, usuario.Simbolo, Util.DecimalToStringFormat(usuario.MontoMaximoPedido, usuario.CodigoISO));
            }
            else if (listaRechazo.FirstOrDefault(p => p.MotivoRechazo == Constantes.GPRMotivoRechazo.ValidacionMontoMinimoStock) != null)
            {
                mensajeParcial = Resources.MotivoRechazoMessages.StockMontoMinimo;
            }

            if (!string.IsNullOrEmpty(mensajeParcial))
            {
                beGPRBanner.BannerUrl = Enumeradores.RechazoBannerUrl.ModificaPedido;
                if (string.IsNullOrEmpty(beGPRBanner.BannerMensaje)) beGPRBanner.BannerMensaje = mensajeParcial;
                else beGPRBanner.BannerMensaje += " y " + mensajeParcial.ToLower(1);
            }
            if (!string.IsNullOrEmpty(beGPRBanner.BannerMensaje)) beGPRBanner.BannerMensaje += ".";

            if (!string.IsNullOrEmpty(beGPRBanner.BannerMensaje))
            {
                beGPRBanner.MostrarBannerRechazo = true;

                if (usuario.IndicadorGPRSB == (int)Enumeradores.IndicadorGPR.Rechazado && ((!usuario.ValidacionAbierta && usuario.EstadoPedido == 201) || usuario.ValidacionAbierta && usuario.EstadoPedido == 202))
                {
                    beGPRBanner.MostrarBannerRechazo = true;
                }
                else if (beGPRBanner.RechazadoXdeuda)
                {
                    beGPRBanner.MostrarBannerRechazo = true;
                }
                else
                {
                    beGPRBanner.MostrarBannerRechazo = (usuario.IndicadorGPRSB == (int)Enumeradores.IndicadorGPR.Descargado);
                }
            }

            return beGPRBanner;
        }

        #region Private Functions

        private string CrearClienteXML(List<BEPedidoRechazadoSicc> listPedidoRechazadoSicc)
        {
            StringBuilder sb = new StringBuilder();
            if (listPedidoRechazadoSicc == null || listPedidoRechazadoSicc.Count == 0) return "";

            foreach (BEPedidoRechazadoSicc pedidoRechazadoSicc in listPedidoRechazadoSicc)
            {
                string campania = pedidoRechazadoSicc.Campania;
                string codigoConsultora = pedidoRechazadoSicc.CodigoConsultora;
                string motivoRechazo = pedidoRechazadoSicc.MotivoRechazo;
                string valor = pedidoRechazadoSicc.Valor;
                string xml = "<PedidoRechazado Campania='{0}' CodigoConsultora='{1}' MotivoRechazo='{2}' Valor='{3}'/>";
                sb.Append(String.Format(xml, campania, codigoConsultora, motivoRechazo, valor));
            }
            return String.Format("<ROOT>{0}</ROOT>", sb.ToString());
        }

        #endregion
    }
}
