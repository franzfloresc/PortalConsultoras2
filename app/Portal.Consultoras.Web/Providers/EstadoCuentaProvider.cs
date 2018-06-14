using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServicePedido;
using System;

namespace Portal.Consultoras.Web.Providers
{
    public class EstadoCuentaProvider
    {
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
    }
}