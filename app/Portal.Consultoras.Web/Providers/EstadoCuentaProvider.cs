using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.SessionManager;
using System;
using System.Collections.Generic;
using System.Linq;

namespace Portal.Consultoras.Web.Providers
{
    public class EstadoCuentaProvider
    {
        protected ISessionManager sessionManager;

        public EstadoCuentaProvider()
        {
            sessionManager = SessionManager.SessionManager.Instance;
        }

        public EstadoCuentaModel ObtenerUltimoMovimientoEstadoCuenta(int paisID, bool tienePagoEnLinea, long consultoraID, double zonaHoraria, string simbolo, string codigoISO)
        {
            var ultimoMovimiento = new EstadoCuentaModel
            {
                Glosa = ""
            };

            if (tienePagoEnLinea)
            {
                BEPagoEnLineaResultadoLog ultimoPagoEnLinea;
                using (PedidoServiceClient ps = new PedidoServiceClient())
                {
                    ultimoPagoEnLinea = ps.ObtenerUltimoPagoEnLineaByConsultoraId(paisID, consultoraID);
                }

                if (ultimoPagoEnLinea != null && ultimoPagoEnLinea.PagoEnLineaResultadoLogId != 0)
                {
                    var fechaUltimoPagoEnLinea = ultimoPagoEnLinea.FechaCreacion;
                    var fechaHoy = DateTime.Now.AddHours(zonaHoraria).Date;

                    if (fechaUltimoPagoEnLinea.ToString("dd/MM/yyyy") == fechaHoy.ToString("dd/MM/yyyy"))
                    {
                        ultimoMovimiento.Simbolo = simbolo;
                        ultimoMovimiento.Glosa = "PAGO EN LINEA";
                        ultimoMovimiento.Fecha = fechaUltimoPagoEnLinea;
                        ultimoMovimiento.FechaVencimiento = fechaUltimoPagoEnLinea.ToString("dd/MM/yyyy");
                        ultimoMovimiento.FechaVencimientoFormatDiaMes = Util.ObtenerFormatoDiaMes(ultimoPagoEnLinea.FechaCreacion);
                        ultimoMovimiento.TipoMovimiento = Constantes.EstadoCuentaTipoMovimiento.Abono;
                        ultimoMovimiento.Abono = ultimoPagoEnLinea.MontoPago;
                        ultimoMovimiento.Cargo = 0;
                        ultimoMovimiento.MontoPagar = Util.DecimalToStringFormat(ultimoMovimiento.Abono, codigoISO);
                    }
                }
            }

            return ultimoMovimiento;
        }

        public List<EstadoCuentaModel> ObtenerEstadoCuenta(long pConsultoraId = 0)
        {
            var lst = new List<EstadoCuentaModel>();

            var userSession = sessionManager.GetUserData();

            if (pConsultoraId == 0)
                pConsultoraId = userSession.ConsultoraID;

            if (sessionManager.GetListadoEstadoCuenta() == null)
            {
                var estadoCuenta = new List<BEEstadoCuenta>();
                try
                {
                    using (var client = new SACServiceClient())
                    {
                        estadoCuenta = client.GetEstadoCuentaConsultora(userSession.PaisID, pConsultoraId).ToList();
                    }
                }
                catch (Exception ex)
                {
                    LogManager.LogManager.LogErrorWebServicesBus(ex, userSession.CodigoConsultora, userSession.CodigoISO);
                }

                if (estadoCuenta.Count > 0)
                {
                    foreach (var ec in estadoCuenta)
                    {
                        lst.Add(new EstadoCuentaModel
                        {
                            Fecha = ec.FechaRegistro,
                            Glosa = ec.DescripcionOperacion,
                            Cargo = ec.Cargo,
                            Abono = ec.Abono
                        });
                    }

                    var monto = userSession.MontoDeuda;

                    lst.Add(new EstadoCuentaModel
                    {
                        Fecha = userSession.FechaLimPago,
                        Glosa = "MONTO A PAGAR",
                        Cargo = monto > 0 ? monto : 0,
                        Abono = monto < 0 ? 0 : monto
                    });
                }

                sessionManager.SetListadoEstadoCuenta(lst);
            }
            else
            {
                lst = sessionManager.GetListadoEstadoCuenta();
            }

            return lst;
        }

    }
}