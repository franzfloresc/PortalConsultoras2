using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServicePedidoRechazado;
using Portal.Consultoras.Web.ServiceUsuario;
using System;
using System.Collections.Generic;
using System.Linq;

namespace Portal.Consultoras.Web.Providers
{
    public class NotificacionProvider
    {
        public void CargarMensajesNotificacionesGPR(NotificacionesModel model, List<BELogGPRValidacion> logsGprValidacion, string codigoIso, string simbolo, decimal montoMinimo, decimal montoMaximo)
        {
            model.CuerpoDetalles = new List<string>();
            if (logsGprValidacion.Count == 0) return;

            var deuda = logsGprValidacion.Where(x => x.MotivoRechazo.Equals(Constantes.GPRMotivoRechazo.ActualizacionDeuda)).ToList();
            model.CuerpoMensaje1 = "Luego de haber revisado tu pedido, te informamos que este no se ha podido facturar por:";

            var items = logsGprValidacion.Where(l => l.MotivoRechazo.Equals(Constantes.GPRMotivoRechazo.MontoMinino)).ToList();
            if (items.Any() && deuda.Any())
            {
                model.CuerpoDetalles.Add(string.Format("No cumplir con el <b>monto mínimo</b> de {0} {1}", simbolo, Util.DecimalToStringFormat(montoMinimo, codigoIso)));
                model.CuerpoDetalles.Add(string.Format("Tener una <b>deuda</b> de {0} {1}", simbolo, Util.DecimalToStringFormat(deuda.FirstOrDefault().Valor, codigoIso)));
                model.CuerpoMensaje2 = "Te invitamos a <b>añadir</b> más productos, <b>cancelar</b> el saldo pendiente y <b>reservar</b> tu pedido el día de hoy para que sea facturado exitosamente.";
                model.MotivoRechazo = Constantes.GPRMotivoRechazo.Mostrar2OpcionesNotificacion;
                return;
            }
            if (items.Any())
            {
                model.CuerpoDetalles.Add(string.Format("No cumplir con el <b>monto mínimo</b> de  {0} {1}", simbolo, Util.DecimalToStringFormat(montoMinimo, codigoIso)));
                model.CuerpoMensaje2 = "Te invitamos a <b>añadir</b> más productos y <b>reservar</b> tu pedido el día de hoy para que sea facturado exitosamente.";
                model.MotivoRechazo = Constantes.GPRMotivoRechazo.MontoMinino;
                return;
            }

            items = logsGprValidacion.Where(l => l.MotivoRechazo.Contains(Constantes.GPRMotivoRechazo.MontoMaximo)).ToList();
            if (items.Any() && deuda.Any())
            {
                model.CuerpoDetalles.Add(string.Format("No cumplir con el <b>monto máximo</b> de {0} {1} ", simbolo, Util.DecimalToStringFormat(montoMaximo, codigoIso)));
                model.CuerpoDetalles.Add(string.Format("Tener una <b>deuda</b> de {0} {1} ", simbolo, Util.DecimalToStringFormat(deuda.FirstOrDefault().Valor, codigoIso)));
                model.CuerpoMensaje2 = "Te invitamos a <b>modificar</b> tu pedido, <b>cancelar</b> el saldo pendiente y <b>reservar</b> tu pedido el día de hoy para que sea facturado exitosamente.";
                model.MotivoRechazo = Constantes.GPRMotivoRechazo.Mostrar2OpcionesNotificacion;
                return;
            }
            if (items.Any())
            {
                model.CuerpoDetalles.Add(string.Format("No cumplir con el <b>monto máximo</b> de {0} {1}", simbolo, Util.DecimalToStringFormat(montoMaximo, codigoIso)));
                model.CuerpoMensaje2 = "Te invitamos a <b>modificar</b> y <b>reservar</b> tu pedido el día de hoy para que sea facturado exitosamente.";
                model.MotivoRechazo = Constantes.GPRMotivoRechazo.MontoMaximo;
                return;
            }
            items = logsGprValidacion.Where(l => l.MotivoRechazo.Contains(Constantes.GPRMotivoRechazo.ValidacionMontoMinimoStock)).ToList();
            if (items.Any() && deuda.Any())
            {
                model.CuerpoDetalles.Add("No cumplir con el <b>monto mínimo</b>");
                model.CuerpoDetalles.Add(string.Format("Tener una <b>deuda</b> de {0} {1}", simbolo, Util.DecimalToStringFormat(deuda.FirstOrDefault().Valor, codigoIso)));
                model.CuerpoMensaje2 = "Te invitamos a <b>añadir</b> más productos, <b>cancelar</b> el saldo pendiente y <b>reservar</b> tu pedido el día de hoy para que sea facturado exitosamente.";
                model.MotivoRechazo = Constantes.GPRMotivoRechazo.Mostrar2OpcionesNotificacion;
                return;
            }
            if (items.Any())
            {
                model.CuerpoDetalles.Add("No cumplir con el <b>monto mínimo</b>");
                model.CuerpoMensaje2 = "Te invitamos a <b>añadir</b> más productos y <b>reservar</b> tu pedido el día de hoy para que sea facturado exitosamente.";
                model.MotivoRechazo = Constantes.GPRMotivoRechazo.ValidacionMontoMinimoStock;
                return;
            }

            if (deuda.Any())
            {
                var item = deuda.FirstOrDefault();
                model.CuerpoDetalles.Add(string.Format("Tener una <b>deuda</b> de {0} {1}", simbolo, Util.DecimalToStringFormat(item.Valor, codigoIso)));
                model.CuerpoMensaje2 = "Te invitamos a <b>cancelar</b> el saldo pendiente y <b>reservar</b> tu pedido el día de hoy para que sea facturado exitosamente.";
                model.MotivoRechazo = Constantes.GPRMotivoRechazo.ActualizacionDeuda;
                model.Campania = item.Campania;
            }
        }

        public Converter<decimal, string> CreateConverterDecimalToString(int paisId)
        {
            if (paisId == 4) return new Converter<decimal, string>(p => p.ToString("n0", new System.Globalization.CultureInfo("es-CO")));
            return new Converter<decimal, string>(p => p.ToString("n2", new System.Globalization.CultureInfo("es-PE")));
        }

        public void GetNotificacionesValAutoProl(long procesoId, int tipoOrigen, int paisId, out List<BENotificacionesDetalle> lstObservaciones, out List<BENotificacionesDetallePedido> lstObservacionesPedido)
        {
            using (var service = new UsuarioServiceClient())
            {
                lstObservaciones = service.GetNotificacionesConsultoraDetalle(paisId, procesoId, tipoOrigen).ToList();
                lstObservacionesPedido = service.GetNotificacionesConsultoraDetallePedido(paisId, procesoId, tipoOrigen).ToList();
            }
            lstObservaciones = lstObservaciones.GroupBy(o => o.CUV).Select(g => g.First()).ToList();
        }
    }
}
