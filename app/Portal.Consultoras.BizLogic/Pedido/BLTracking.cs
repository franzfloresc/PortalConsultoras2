using Portal.Consultoras.Common;
using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.Pedido;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;

namespace Portal.Consultoras.BizLogic
{
    public class BLTracking : ITrackingBusinessLogic
    {
        public List<BETracking> GetPedidosByConsultora(int paisID, string codigoConsultora, int top)
        {
            var pedidos = new List<BETracking>();
            var daTracking = new DATracking(paisID);

            using (IDataReader reader = daTracking.GetPedidosByConsultora(codigoConsultora, top))
            {
                while (reader.Read())
                {
                    var entidad = new BETracking(reader) {PaisID = paisID};
                    pedidos.Add(entidad);
                }
            }

            return pedidos;
        }

        public BETracking GetPedidoByConsultoraAndCampania(int paisID, string codigoConsultora, int campania)
        {
            var pedido = new BETracking();
            var daTracking = new DATracking(paisID);

            using (IDataReader reader = daTracking.GetPedidoByConsultoraAndCampania(codigoConsultora, campania))
            {
                if (reader.Read())
                {
                    pedido = new BETracking(reader) {PaisID = paisID};
                }
            }

            return pedido;
        }

        public BETracking GetPedidoByConsultoraAndCampaniaAndNroPedido(int paisID, string codigoConsultora, int campania, string nroPedido)
        {
            var pedido = new BETracking();
            var daTracking = new DATracking(paisID);

            using (IDataReader reader = daTracking.GetPedidoByConsultoraAndCampaniaAndNroPedido(codigoConsultora, campania, nroPedido))
            {
                if (reader.Read())
                {
                    pedido = new BETracking(reader) {PaisID = paisID};
                }
            }
            return pedido;
        }

        public List<BETracking> GetTrackingByPedido(int paisID, string codigo, string campana, string nropedido)
        {
            var pedidos = new List<BETracking>();
            var daTracking = new DATracking(paisID);

            using (IDataReader reader = daTracking.GetTrackingByPedido(codigo, campana, nropedido))
            {
                while (reader.Read())
                {
                    var entidad = new BETracking(reader) {PaisID = paisID};
                    pedidos.Add(entidad);
                }
            }

            return pedidos;
        }

        public List<BENovedadTracking> GetNovedadesTracking(int paisID, string NumeroPedido)
        {
            var novedades = new List<BENovedadTracking>();
            var daTracking = new DATracking(paisID);

            using (IDataReader reader = daTracking.GetNovedadesTracking(NumeroPedido))
            {
                while (reader.Read())
                {
                    var entidad = new BENovedadTracking(reader);
                    novedades.Add(entidad);
                }
            }

            return novedades;
        }

        public int InsConfirmacionEntrega(int paisID, BEConfirmacionEntrega oBEConfirmacionEntrega)
        {
            var daTracking = new DATracking(paisID);

            int result = 0;
            try
            {
                result = daTracking.InsConfirmacionEntrega(oBEConfirmacionEntrega);

                if (ConfigurationManager.AppSettings["PaisLogConfirmacionEntrega"].Contains(oBEConfirmacionEntrega.PaisISO) &&
                    ConfigurationManager.AppSettings["SaveLogConfirmacionEntrega"] == "1")
                {
                    BELogConfirmacionEntrega obeLogConfirmacionEntrega = new BELogConfirmacionEntrega
                    {
                        LogTipoReg = 1,
                        LogResult = result,
                        IdentificadorEntrega = oBEConfirmacionEntrega.IdentificadorEntrega,
                        NumeroPedido = oBEConfirmacionEntrega.NumeroPedido,
                        CodigoConsultora = oBEConfirmacionEntrega.CodigoConsultora,
                        Fecha = oBEConfirmacionEntrega.Fecha,
                        Latitud = oBEConfirmacionEntrega.Latitud,
                        Longitud = oBEConfirmacionEntrega.Longitud,
                        TipoEntrega = oBEConfirmacionEntrega.TipoEntrega,
                        Novedad = oBEConfirmacionEntrega.Novedad,
                        Observacion = oBEConfirmacionEntrega.Observacion,
                        CodigoPlataforma = oBEConfirmacionEntrega.CodigoPlataforma,
                        Foto1 = oBEConfirmacionEntrega.Foto1,
                        Foto2 = oBEConfirmacionEntrega.Foto2,
                        Foto3 = oBEConfirmacionEntrega.Foto3,
                        Firma = oBEConfirmacionEntrega.Firma
                    };

                    daTracking.InsLogConfirmacionEntrega(obeLogConfirmacionEntrega);
                }
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, "ConfirmacionEntrega", oBEConfirmacionEntrega.PaisISO);
            }

            return result;
        }

        public int UpdConfirmacionEntrega(int paisID, BEConfirmacionEntrega oBEConfirmacionEntrega)
        {
            var daTracking = new DATracking(paisID);

            int result = 0;
            try
            {
                result = daTracking.UpdConfirmacionEntrega(oBEConfirmacionEntrega);

                if (ConfigurationManager.AppSettings["PaisLogConfirmacionEntrega"].Contains(oBEConfirmacionEntrega.PaisISO) &&
                    ConfigurationManager.AppSettings["SaveLogConfirmacionEntrega"] == "1")
                {
                    BELogConfirmacionEntrega obeLogConfirmacionEntrega = new BELogConfirmacionEntrega
                    {
                        LogTipoReg = 2,
                        LogResult = result,
                        IdentificadorEntrega = oBEConfirmacionEntrega.IdentificadorEntrega,
                        NumeroPedido = oBEConfirmacionEntrega.NumeroPedido,
                        Fecha = oBEConfirmacionEntrega.Fecha,
                        Foto1 = oBEConfirmacionEntrega.Foto1,
                        Foto2 = oBEConfirmacionEntrega.Foto2
                    };

                    daTracking.InsLogConfirmacionEntrega(obeLogConfirmacionEntrega);
                }
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, "ConfirmacionEntrega", oBEConfirmacionEntrega.PaisISO);
            }

            return result;
        }

        public BENovedadFacturacion GetPedidoRechazadoByConsultora(int PaisID, string CampaniaId, string CodigoConsultora, DateTime Fecha)
        {
            BENovedadFacturacion entidad = null;
            var daTracking = new DATracking(PaisID);

            using (IDataReader reader = daTracking.GetPedidoRechazadoByConsultora(CampaniaId, CodigoConsultora, Fecha))
            {
                if (reader.Read())
                {
                    entidad = new BENovedadFacturacion(reader);
                }
            }

            return entidad;
        }

        public BENovedadFacturacion GetPedidoAnuladoByConsultora(int PaisID, string CampaniaId, string CodigoConsultora, DateTime Fecha, string NumeroPedido)
        {
            BENovedadFacturacion entidad = null;
            var daTracking = new DATracking(PaisID);

            using (IDataReader reader = daTracking.GetPedidoAnuladoByConsultora(CampaniaId, CodigoConsultora, Fecha, NumeroPedido))
            {
                if (reader.Read())
                {
                    entidad = new BENovedadFacturacion(reader);
                }
            }

            return entidad;
        }

        public int InsConfirmacionRecojo(int paisID, BEConfirmacionRecojo oBEConfirmacionRecoja)
        {
            var daTracking = new DATracking(paisID);

            int result = 0;
            try
            {
                result = daTracking.InsConfirmacionRecojo(oBEConfirmacionRecoja);
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, oBEConfirmacionRecoja.CodigoConsultora, paisID.ToString());
            }

            return result;
        }

        public List<BEPostVenta> GetMisPostVentaByConsultora(int paisID, string codigoConsultora)
        {
            var recojos = new List<BEPostVenta>();
            var daTracking = new DATracking(paisID);

            using (IDataReader reader = daTracking.GetMisPostVentaByConsultora(codigoConsultora))
            {
                while (reader.Read())
                {
                    var entidad = new BEPostVenta(reader);
                    recojos.Add(entidad);
                }
            }

            return recojos;
        }

        public List<BEPostVenta> GetSeguimientoPostVenta(int paisID, string numeroRecojo, int estadoRecojoID)
        {
            var recojos = new List<BEPostVenta>();
            var daTracking = new DATracking(paisID);

            using (IDataReader reader = daTracking.GetSeguimientoPostVenta(numeroRecojo, estadoRecojoID))
            {
                while (reader.Read())
                {
                    var entidad = new BEPostVenta(reader);
                    recojos.Add(entidad);
                }
            }

            return recojos;
        }

        public List<BEPostVenta> GetNovedadPostVenta(int paisID, string numeroRecojo)
        {
            var recojos = new List<BEPostVenta>();
            var daTracking = new DATracking(paisID);

            using (IDataReader reader = daTracking.GetNovedadPostVenta(numeroRecojo))
            {
                while (reader.Read())
                {
                    var entidad = new BEPostVenta(reader);
                    recojos.Add(entidad);
                }
            }

            return recojos;
        }

        public List<BETracking> GetTrackingPedidoByConsultora(int paisID, string codigoConsultora, int top)
        {
            List<BETracking> pedidos;
            var pedidosDetalle = new List<BETrackingDetalle>();
            var novedades = new List<BENovedadTracking>();
            var paisTracking = WebConfig.WebTrackingConfirmacion.Contains(Util.GetPaisISO(paisID));

            using (IDataReader reader = new DATracking(paisID).GetTrackingPedidoByConsultora(codigoConsultora, top))
            {
                pedidos = reader.MapToCollection<BETracking>();
                if (reader.NextResult()) pedidosDetalle = reader.MapToCollection<BETrackingDetalle>();

                foreach (var item in pedidos)
                {
                    if(paisTracking) novedades = GetNovedadesTracking(paisID, item.NumeroPedido);

                    var lstDetalle = pedidosDetalle.Where(x => x.Campana == item.Campana && x.NumeroPedido == item.NumeroPedido).ToList();

                    foreach (var itemDet in lstDetalle)
                    {
                        itemDet.FechaFormatted = (itemDet.Fecha.HasValue 
                            ? (itemDet.Fecha.Value.TimeOfDay.TotalHours.Equals(0)
                                ? itemDet.Fecha.Value.ToString("dd/MM/yyyy") 
                                : itemDet.Fecha.Value.ToString())
                            : string.Empty);

                        switch (itemDet.FechaFormatted)
                        {
                            case "":
                                break;
                            case "01/01/2001":
                                break;
                            case "02/01/2010":
                                break;
                            case "01/01/2010":
                                itemDet.Alcanzado = true;
                                var novedad = novedades.FirstOrDefault(p => p.TipoEntrega == "01");
                                if (novedad != null)
                                {
                                    itemDet.FechaFormatted = (novedad.FechaNovedad.HasValue 
                                        ? (novedad.FechaNovedad.Value.TimeOfDay.TotalHours.Equals(0)
                                            ? novedad.FechaNovedad.Value.ToString("dd/MM/yyyy")
                                            : novedad.FechaNovedad.Value.ToString()) 
                                        : string.Empty);
                                    itemDet.Fecha = novedad.FechaNovedad.Value;
                                }
                                break;
                            default:
                                itemDet.Alcanzado = true;
                                break;
                        }
                    }

                    item.Detalles = lstDetalle;
                }
            }

            return pedidos;
        }
    }
}
