using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.ReservaProl;
using Portal.Consultoras.Data.ServicePROL;
using System.Configuration;
using Portal.Consultoras.Common;
using System.Text.RegularExpressions;

namespace Portal.Consultoras.BizLogic.Reserva
{
    public class BLReservaProl1 : BLReservaProl, IReservaExternaBL
    {
        public BEResultadoReservaProl ReservarPedido(BEInputReservaProl input, List<BEPedidoWebDetalle> olstPedidoWebDetalle)
        {
            var resultado = new BEResultadoReservaProl();
            string listaProductos = string.Join("|", olstPedidoWebDetalle.Select(x => x.CUV).ToArray());
            string listaCantidades = string.Join("|", olstPedidoWebDetalle.Select(x => x.Cantidad).ToArray());
            string listaRecuperacion = string.Join("|", olstPedidoWebDetalle.Select(x => Convert.ToInt32(x.AceptoBackOrder)).ToArray());
            
            RespuestaProl datos;
            using (var sv = new ServiceStockSsic())
            {
                sv.Url = ConfigurationManager.AppSettings["Prol_" + input.PaisISO];
                datos = sv.wsValidacionEstrategia(listaProductos, listaCantidades, listaRecuperacion, input.CodigoConsultora, input.MontoMinimo, input.CodigoZona, input.PaisISO, input.CampaniaID.ToString(), input.ConsultoraNueva, input.MontoMaximo, input.CodigosConcursos);
            }
            if (datos == null) return resultado;

            resultado.MontoAhorroCatalogo = datos.montoAhorroCatalogo.ToDecimalSecure();
            resultado.MontoAhorroRevista = datos.montoAhorroRevista.ToDecimalSecure();
            resultado.MontoGanancia = resultado.MontoAhorroCatalogo + resultado.MontoAhorroRevista;
            resultado.MontoDescuento = datos.montoDescuento.ToDecimalSecure();
            resultado.MontoEscala = datos.montoEscala.ToDecimalSecure();
            resultado.MontoTotal = olstPedidoWebDetalle.Sum(pd => pd.ImporteTotal) - resultado.MontoDescuento;
            resultado.UnidadesAgregadas = olstPedidoWebDetalle.Sum(pd => pd.Cantidad);
            resultado.CodigoMensaje = datos.codigoMensaje;
            this.UpdateMontosPedidoWeb(resultado, input);
            resultado.RefreshPedido = true;
            resultado.RefreshMontosProl = true;

            List<BEPedidoWebDetalle> lstPedidoWebDetalleBackOrder = new List<BEPedidoWebDetalle>();
            int validacionReemplazo = 0;

            if (!datos.codigoMensaje.Equals("00"))
            {
                foreach (var item in datos.ListaObservaciones)
                {
                    int tipoObs = Convert.ToInt32(item.cod_observacion);
                    string cuv = item.codvta;
                    string observacion = item.observacion.Replace("+", "");

                    if (tipoObs == 8)
                    {
                        lstPedidoWebDetalleBackOrder.AddRange(olstPedidoWebDetalle.Where(d => d.CUV == cuv));
                    }
                    else
                    {
                        if (tipoObs == 0) validacionReemplazo += 1;
                        else if (tipoObs == 95)
                        {
                            observacion = Regex.Replace(observacion, "(\\#.*\\#)", Util.DecimalToStringFormat(input.MontoMinimo, input.PaisISO));
                        }
                        resultado.ListPedidoObservacion.Add(new BEPedidoObservacion() { Caso = tipoObs, CUV = cuv, Tipo = 2, Descripcion = observacion });
                    }
                }
                resultado.Reserva = input.FechaHoraReserva && resultado.Informativas && !resultado.Restrictivas;
            }
            else resultado.Reserva = input.FechaHoraReserva;

            if (resultado.Reserva)
            {
                decimal montoTotalProl = datos.montototal.ToDecimalSecure();
                decimal descuentoProl = datos.montoDescuento.ToDecimalSecure();
                var listPedidoReserva = GetPedidoReserva(datos, olstPedidoWebDetalle);

                EjecutarReservaPortal(input, listPedidoReserva, olstPedidoWebDetalle, false, montoTotalProl, descuentoProl);
            }

            if (datos.ListaConcursoIncentivos != null)
            {
                resultado.ListaConcursosCodigos = string.Join("|", datos.ListaConcursoIncentivos.Select(i => i.codigoconcurso).ToArray());
                resultado.ListaConcursosPuntaje = string.Join("|", datos.ListaConcursoIncentivos.Select(i => i.puntajeconcurso.Split('|')[0]).ToArray());
                resultado.ListaConcursosPuntajeExigido = string.Join("|", datos.ListaConcursoIncentivos.Select(i => (i.puntajeconcurso.IndexOf('|') > -1 ? i.puntajeconcurso.Split('|')[1] : "0")).ToArray());
            }

            return resultado;
        }
    }
}
