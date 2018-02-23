using Portal.Consultoras.Common;
using Portal.Consultoras.Data.ServicePROL;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.ReservaProl;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;

namespace Portal.Consultoras.BizLogic.Reserva
{
    public class BLReservaProl
    {
        #region Public Functions

        public int InsertarDesglose(BEInputReservaProl input)
        {
            try
            {
                TransferirDatos datos;
                using (var sv = new ServiceStockSsic())
                {
                    sv.Url = ConfigurationManager.AppSettings["Prol_" + input.PaisISO];
                    datos = sv.ObtenerExplotado(input.CodigoConsultora, input.CampaniaID.ToString(), input.PaisISO, input.CodigoZona);
                }
                if (datos == null) return -1;

                var bePedidoWebDetalleParametros = new BEPedidoWebDetalleParametros
                {
                    PaisId = input.PaisID,
                    CampaniaId = input.CampaniaID,
                    ConsultoraId = input.ConsultoraID,
                    Consultora = input.NombreConsultora,
                    EsBpt = input.EsOpt == 1,
                    CodigoPrograma = input.CodigoPrograma,
                    NumeroPedido = input.ConsecutivoNueva
                };
                var listPedidoWebDetalle = new BLPedidoWebDetalle().GetPedidoWebDetalleByCampania(bePedidoWebDetalleParametros).ToList();
                if (listPedidoWebDetalle.Count == 0) return 0;

                var listPedidoReserva = GetPedidoReserva(datos.data.Tables[0], listPedidoWebDetalle, input.CodigoUsuario);
                EjecutarReservaPortal(input, listPedidoReserva, listPedidoWebDetalle, false);
                return listPedidoWebDetalle[0].PedidoID;
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, input.CodigoConsultora, input.PaisISO);
                return -1;
            }
        }

        #endregion

        #region Protected Functions

        protected void UpdateMontosPedidoWeb(BEResultadoReservaProl resultado, BEInputReservaProl input)
        {
            BEPedidoWeb bePedidoWeb = new BEPedidoWeb
            {
                PaisID = input.PaisID,
                CampaniaID = input.CampaniaID,
                ConsultoraID = input.ConsultoraID,
                MontoAhorroCatalogo = resultado.MontoAhorroCatalogo,
                MontoAhorroRevista = resultado.MontoAhorroRevista,
                DescuentoProl = resultado.MontoDescuento,
                MontoEscala = resultado.MontoEscala
            };
            new BLPedidoWeb().UpdateMontosPedidoWeb(bePedidoWeb);
        }

        protected List<BEPedidoWebDetalle> GetPedidoReserva(RespuestaProl respuestaPROL, List<BEPedidoWebDetalle> listPedidoWebDetalle)
        {
            var listPedidoReserva = new List<BEPedidoWebDetalle>();
            if (respuestaPROL.ListaObservaciones != null)
            {
                foreach (var item in respuestaPROL.ListaObservaciones)
                {
                    listPedidoReserva.AddRange(listPedidoWebDetalle.Where(p => p.CUV == item.codvta).Select(pd => new BEPedidoWebDetalle
                    {
                        CampaniaID = pd.CampaniaID,
                        PedidoID = pd.PedidoID,
                        PedidoDetalleID = pd.PedidoDetalleID,
                        ObservacionPROL = item.observacion
                    }));
                }
            }
            return listPedidoReserva;
        }

        protected void EjecutarReservaPortal(BEInputReservaProl input, List<BEPedidoWebDetalle> listPedidoReserva, List<BEPedidoWebDetalle> listPedidoWebDetalle, bool version2, decimal montoTotalProl = 0, decimal descuentoProl = 0)
        {
            var bLPedidoWebDetalle = new BLPedidoWebDetalle();
            var estadoPedido = input.PROLSinStock ? Constantes.EstadoPedido.Pendiente : Constantes.EstadoPedido.Procesado;
            if (version2) bLPedidoWebDetalle.InsPedidoWebDetallePROLv2(input.PaisID, input.CampaniaID, input.PedidoID, estadoPedido, listPedidoReserva, false, input.CodigoUsuario, montoTotalProl, descuentoProl);
            else bLPedidoWebDetalle.InsPedidoWebDetallePROL(input.PaisID, input.CampaniaID, input.PedidoID, estadoPedido, listPedidoReserva, 0, input.CodigoUsuario, montoTotalProl, descuentoProl);

            decimal totalPedido = listPedidoWebDetalle.Sum(p => p.ImporteTotal);
            decimal gananciaEstimada = CalcularGananciaEstimada(input.PaisID, input.CampaniaID, input.PedidoID, totalPedido);
            new BLFactorGanancia().UpdatePedidoWebEstimadoGanancia(input.PaisID, input.CampaniaID, input.PedidoID, gananciaEstimada);
        }

        #endregion

        #region Private Functions

        private decimal CalcularGananciaEstimada(int paisId, int campaniaId, int pedidoId, decimal totalPedido)
        {
            var bLFactorGanancia = new BLFactorGanancia();
            decimal indicadorNumero;

            BEFactorGanancia factorGanancia = null;
            try
            {
                factorGanancia = bLFactorGanancia.GetFactorGananciaEscalaDescuento(totalPedido, paisId);
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, "", paisId.ToString());
            }
            decimal porcentajeGanancia = factorGanancia == null ? 0 : (factorGanancia.Porcentaje / 100);

            var productosIndicadorDscto = bLFactorGanancia.GetProductoComercialIndicadorDescuentoByPedidoWebDetalle(paisId, campaniaId, pedidoId).ToList();
            productosIndicadorDscto.ForEach(pid =>
            {
                string indicador = pid.IndicadorDscto.ToLower();

                if (indicador == " ") pid.MontoDscto = (pid.PrecioUnidad - pid.PrecioCatalogo2) * pid.Cantidad;
                else if (indicador == "c") pid.MontoDscto = (pid.PrecioUnidad * porcentajeGanancia) * pid.Cantidad;
                else if (decimal.TryParse(indicador, out indicadorNumero) && indicadorNumero.Between(0, 100))
                {
                    pid.MontoDscto = (pid.PrecioUnidad * (indicadorNumero / 100)) * pid.Cantidad;
                }
            });
            return productosIndicadorDscto.Sum(p => p.MontoDscto);
        }

        private List<BEPedidoWebDetalle> GetPedidoReserva(DataTable dtr, List<BEPedidoWebDetalle> listPedidoWebDetalle, string codigoUsuario)
        {
            var listPedidoReserva = new List<BEPedidoWebDetalle>();
            foreach (DataRow row in dtr.Rows)
            {
                var temp = listPedidoWebDetalle.Where(p => p.CUV == Convert.ToString(row.ItemArray.GetValue(0)));
                if (!temp.Any())
                {
                    listPedidoReserva.Add(new BEPedidoWebDetalle()
                    {
                        CampaniaID = listPedidoWebDetalle[0].CampaniaID,
                        PedidoID = listPedidoWebDetalle[0].PedidoID,
                        PedidoDetalleID = 0,
                        MarcaID = listPedidoWebDetalle[0].MarcaID,
                        ConsultoraID = listPedidoWebDetalle[0].ConsultoraID,
                        ClienteID = 0,
                        Cantidad = Convert.ToInt32(row.ItemArray.GetValue(3)),
                        PrecioUnidad = 0,
                        ImporteTotal = 0,
                        CUV = Convert.ToString(row.ItemArray.GetValue(0)),
                        OfertaWeb = false,
                        CUVPadre = "0",
                        CodigoUsuarioCreacion = codigoUsuario,
                        CodigoUsuarioModificacion = codigoUsuario
                    });
                }
            }
            return listPedidoReserva;
        }

        #endregion
    }
}
