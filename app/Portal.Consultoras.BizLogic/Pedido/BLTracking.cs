using System;
using System.Collections.Generic;
using System.Data;
using System.Configuration;
using System.Linq;

using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.Pedido;
using Portal.Consultoras.Data;
using Portal.Consultoras.Common;

namespace Portal.Consultoras.BizLogic
{
    public class BLTracking : ITrackingBusinessLogic
    {
        public List<BETracking> GetPedidosByConsultora(int paisID, string codigoConsultora, int top)
        {
            var pedidos = new List<BETracking>();
            var DATracking = new DATracking(paisID);

            using (IDataReader reader = DATracking.GetPedidosByConsultora(codigoConsultora, top))
            {
                while (reader.Read())
                {
                    var entidad = new BETracking(reader);
                    entidad.PaisID = paisID;
                    pedidos.Add(entidad);
                }
            }

            return pedidos;
        }

        public BETracking GetPedidoByConsultoraAndCampania(int paisID, string codigoConsultora, int campania)
        {
            var pedido = new BETracking();
            var DATracking = new DATracking(paisID);

            using (IDataReader reader = DATracking.GetPedidoByConsultoraAndCampania(codigoConsultora, campania))
            {
                if (reader.Read())
                {
                    pedido = new BETracking(reader);
                    pedido.PaisID = paisID;
                }
            }

            return pedido;
        }

        public BETracking GetPedidoByConsultoraAndCampaniaAndNroPedido(int paisID, string codigoConsultora, int campania, string nroPedido)
        {
            var pedido = new BETracking();
            var DATracking = new DATracking(paisID);

            using (IDataReader reader = DATracking.GetPedidoByConsultoraAndCampaniaAndNroPedido(codigoConsultora, campania, nroPedido))
            {
                if (reader.Read())
                {
                    pedido = new BETracking(reader);
                    pedido.PaisID = paisID;
                }
            }
            return pedido;
        }

        public List<BETracking> GetTrackingByPedido(int paisID, string codigo, string campana, string nropedido)
        {
            var pedidos = new List<BETracking>();
            var DATracking = new DATracking(paisID);

            using (IDataReader reader = DATracking.GetTrackingByPedido(codigo, campana, nropedido))
            {
                while (reader.Read())
                {
                    var entidad = new BETracking(reader);
                    entidad.PaisID = paisID;
                    pedidos.Add(entidad);
                }
            }

            return pedidos;
        }

        public List<BENovedadTracking> GetNovedadesTracking(int paisID, string NumeroPedido)
        {
            var novedades = new List<BENovedadTracking>();
            var DATracking = new DATracking(paisID);

            using (IDataReader reader = DATracking.GetNovedadesTracking(NumeroPedido))
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
            var DATracking = new DATracking(paisID);

            int Result = 0;
            try
            {
                Result = DATracking.InsConfirmacionEntrega(oBEConfirmacionEntrega);

                if (ConfigurationManager.AppSettings["PaisLogConfirmacionEntrega"].Contains(oBEConfirmacionEntrega.PaisISO) &&
                    ConfigurationManager.AppSettings["SaveLogConfirmacionEntrega"] == "1")
                {
                    BELogConfirmacionEntrega oBELogConfirmacionEntrega = new BELogConfirmacionEntrega();
                    oBELogConfirmacionEntrega.LogTipoReg = 1;
                    oBELogConfirmacionEntrega.LogResult = Result;
                    oBELogConfirmacionEntrega.IdentificadorEntrega = oBEConfirmacionEntrega.IdentificadorEntrega;
                    oBELogConfirmacionEntrega.NumeroPedido = oBEConfirmacionEntrega.NumeroPedido;
                    oBELogConfirmacionEntrega.CodigoConsultora = oBEConfirmacionEntrega.CodigoConsultora;
                    oBELogConfirmacionEntrega.Fecha = oBEConfirmacionEntrega.Fecha;
                    oBELogConfirmacionEntrega.Latitud = oBEConfirmacionEntrega.Latitud;
                    oBELogConfirmacionEntrega.Longitud = oBEConfirmacionEntrega.Longitud;
                    oBELogConfirmacionEntrega.TipoEntrega = oBEConfirmacionEntrega.TipoEntrega;
                    oBELogConfirmacionEntrega.Novedad = oBEConfirmacionEntrega.Novedad;
                    oBELogConfirmacionEntrega.Observacion = oBEConfirmacionEntrega.Observacion;
                    oBELogConfirmacionEntrega.CodigoPlataforma = oBEConfirmacionEntrega.CodigoPlataforma;
                    oBELogConfirmacionEntrega.Foto1 = oBEConfirmacionEntrega.Foto1;
                    oBELogConfirmacionEntrega.Foto2 = oBEConfirmacionEntrega.Foto2;
                    oBELogConfirmacionEntrega.Foto3 = oBEConfirmacionEntrega.Foto3;
                    oBELogConfirmacionEntrega.Firma = oBEConfirmacionEntrega.Firma;

                    DATracking.InsLogConfirmacionEntrega(oBELogConfirmacionEntrega);
                }
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, "ConfirmacionEntrega", oBEConfirmacionEntrega.PaisISO);
            }

            return Result;
        }

        public int UpdConfirmacionEntrega(int paisID, BEConfirmacionEntrega oBEConfirmacionEntrega)
        {
            var DATracking = new DATracking(paisID);

            int Result = 0;
            try
            {
                Result = DATracking.UpdConfirmacionEntrega(oBEConfirmacionEntrega);

                if (ConfigurationManager.AppSettings["PaisLogConfirmacionEntrega"].Contains(oBEConfirmacionEntrega.PaisISO) &&
                    ConfigurationManager.AppSettings["SaveLogConfirmacionEntrega"] == "1")
                {
                    BELogConfirmacionEntrega oBELogConfirmacionEntrega = new BELogConfirmacionEntrega();
                    oBELogConfirmacionEntrega.LogTipoReg = 2;
                    oBELogConfirmacionEntrega.LogResult = Result;
                    oBELogConfirmacionEntrega.IdentificadorEntrega = oBEConfirmacionEntrega.IdentificadorEntrega;
                    oBELogConfirmacionEntrega.NumeroPedido = oBEConfirmacionEntrega.NumeroPedido;
                    oBELogConfirmacionEntrega.Fecha = oBEConfirmacionEntrega.Fecha;
                    oBELogConfirmacionEntrega.Foto1 = oBEConfirmacionEntrega.Foto1;
                    oBELogConfirmacionEntrega.Foto2 = oBEConfirmacionEntrega.Foto2;

                    DATracking.InsLogConfirmacionEntrega(oBELogConfirmacionEntrega);
                }
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, "ConfirmacionEntrega", oBEConfirmacionEntrega.PaisISO);
            }

            return Result;
        }

        public BENovedadFacturacion GetPedidoRechazadoByConsultora(int PaisID, string CampaniaId, string CodigoConsultora, DateTime Fecha)
        {
            BENovedadFacturacion entidad = null;
            var DATracking = new DATracking(PaisID);

            using (IDataReader reader = DATracking.GetPedidoRechazadoByConsultora(CampaniaId, CodigoConsultora, Fecha))
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
            var DATracking = new DATracking(PaisID);

            using (IDataReader reader = DATracking.GetPedidoAnuladoByConsultora(CampaniaId, CodigoConsultora, Fecha, NumeroPedido))
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
            var DATracking = new DATracking(paisID);

            int Result = 0;
            try
            {
                Result = DATracking.InsConfirmacionRecojo(oBEConfirmacionRecoja);
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, oBEConfirmacionRecoja.CodigoConsultora, paisID.ToString());
            }

            return Result;
        }


        public List<BEPostVenta> GetMisPostVentaByConsultora(int paisID, string codigoConsultora)
        {
            var recojos = new List<BEPostVenta>();
            var DATracking = new DATracking(paisID);

            using (IDataReader reader = DATracking.GetMisPostVentaByConsultora(codigoConsultora))
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
            var DATracking = new DATracking(paisID);

            using (IDataReader reader = DATracking.GetSeguimientoPostVenta(numeroRecojo, estadoRecojoID))
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
            var DATracking = new DATracking(paisID);

            using (IDataReader reader = DATracking.GetNovedadPostVenta(numeroRecojo))
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
            var pedidos = new List<BETracking>();
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

                    var lstDetalle = pedidosDetalle.Where(x => x.Campana == item.Campana).ToList();

                    foreach (var itemDet in lstDetalle)
                    {
                        itemDet.FechaFormatted = (itemDet.Fecha.HasValue ? (itemDet.Fecha.Value.TimeOfDay.TotalHours == 0 ? itemDet.Fecha.Value.ToString("dd/MM/yyyy") : itemDet.Fecha.Value.ToString()) : string.Empty);

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
                                    itemDet.FechaFormatted = (novedad.FechaNovedad.HasValue ? (novedad.FechaNovedad.Value.TimeOfDay.TotalHours == 0 ? novedad.FechaNovedad.Value.ToString("dd/MM/yyyy") : novedad.FechaNovedad.Value.ToString()) : string.Empty);
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
