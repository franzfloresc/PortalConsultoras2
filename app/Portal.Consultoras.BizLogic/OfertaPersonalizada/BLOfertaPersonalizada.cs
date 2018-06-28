using Portal.Consultoras.Common;
using Portal.Consultoras.Data;
using Portal.Consultoras.Data.ServicePROLConsultas;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.ShowRoom;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;

namespace Portal.Consultoras.BizLogic.OfertaPersonalizada
{
    public class BLOfertaPersonalizada
    {
        public IList<BEShowRoomOferta> GetShowRoomOfertasConsultora(int paisID, int campaniaID, string codigoConsultora)
        {
            List<BEShowRoomOferta> showRoomOfertas;
            var da = new DAShowRoomEvento(paisID);

            using (var reader = da.GetShowRoomOfertasConsultoraPersonalizada(campaniaID, codigoConsultora))
            {
                showRoomOfertas = reader.MapToCollection<BEShowRoomOferta>();
            }
            return showRoomOfertas;
        }

        public List<BEShowRoomOferta> GetProductosCompraPorCompra(int paisId, int EventoID, int CampaniaID)
        {
            var lst = new List<BEShowRoomOferta>();
            var da = new DAShowRoomEvento(paisId);

            using (IDataReader reader = da.GetProductosCompraPorCompra(EventoID, CampaniaID))
                while (reader.Read())
                {
                    var entidad = new BEShowRoomOferta(reader);
                    lst.Add(entidad);
                }
            return lst;
        }

        public List<BEEstrategia> GetEstrategiaODD(int paisID, int codCampania, string codConsultora, DateTime fechaInicioFact)
        {
            var listaEstrategias = new List<BEEstrategia>();
            var daEstrategia = new DAEstrategia(paisID);

            using (var reader = daEstrategia.GetEstrategiaODD(codCampania, codConsultora, fechaInicioFact))
            {
                while (reader.Read())
                {
                    listaEstrategias.Add(new BEEstrategia(reader));
                }
            }

            var codigoIso = Util.GetPaisISO(paisID);
            var carpetaPais = Globals.UrlMatriz + "/" + codigoIso;

            listaEstrategias.ForEach(item =>
            {
                item.FotoProducto01 = ConfigS3.GetUrlFileS3(carpetaPais, item.FotoProducto01, carpetaPais);
            });

            return listaEstrategias;
        }
        
        public List<BEEstrategia> GetEstrategiasPedido(BEEstrategia entidad)
        {
            try
            {
                var estrategias = new List<BEEstrategia>();
                var daEstrategia = new DAEstrategia(entidad.PaisID);
                switch (entidad.CodigoTipoEstrategia)
                {
                    case Constantes.TipoEstrategiaCodigo.OfertaWeb:
                        using (var reader = daEstrategia.GetEstrategiaOfertaWeb(entidad))
                        {
                            while (reader.Read()) estrategias.Add(new BEEstrategia(reader));
                        }
                        break;
                    case Constantes.TipoEstrategiaCodigo.PackNuevas:
                        using (var reader = daEstrategia.GetEstrategiaPackNuevas(entidad))
                        {
                            while (reader.Read()) estrategias.Add(new BEEstrategia(reader));
                        }
                        break;
                    case Constantes.TipoEstrategiaCodigo.Lanzamiento:
                        using (var reader = daEstrategia.GetEstrategiaLanzamiento(entidad))
                        {
                            while (reader.Read()) estrategias.Add(new BEEstrategia(reader));
                        }
                        break;
                    case Constantes.TipoEstrategiaCodigo.OfertaParaTi:
                        using (var reader = daEstrategia.GetEstrategiaOfertaParaTi(entidad))
                        {
                            while (reader.Read()) estrategias.Add(new BEEstrategia(reader));
                        }
                        break;
                    case Constantes.TipoEstrategiaCodigo.RevistaDigital:
                        using (var reader = daEstrategia.GetEstrategiaRevistaDigital(entidad))
                        {
                            while (reader.Read()) estrategias.Add(new BEEstrategia(reader));
                        }
                        break;
                    case Constantes.TipoEstrategiaCodigo.GuiaDeNegocioDigitalizada:

                        // eliminar data de cache manager
                        // se puede enviar un parametro para no validar si existe data en cache
                        // crear un metodo en la BL que limpie cache x key (este metodo puede ser reutilizado por otro lado)
                        estrategias = (List<BEEstrategia>)CacheManager<BEEstrategia>.GetData(entidad.PaisID, ECacheItem.GNDEstrategia, entidad.CampaniaID.ToString());
                        if (estrategias == null || !estrategias.Any())
                        {
                            estrategias = new List<BEEstrategia>();
                            using (var reader = daEstrategia.GetEstrategiaGuiaDeNegocioDigitalizada(entidad))
                            {
                                while (reader.Read()) estrategias.Add(new BEEstrategia(reader));
                            }

                            CacheManager<BEEstrategia>.AddData(entidad.PaisID, ECacheItem.GNDEstrategia, entidad.CampaniaID.ToString(), estrategias);
                        }

                        break;
                    case Constantes.TipoEstrategiaCodigo.HerramientasVenta:

                        estrategias = (List<BEEstrategia>)CacheManager<BEEstrategia>.GetData(entidad.PaisID, ECacheItem.HVEstrategia, entidad.CampaniaID.ToString());
                        if (estrategias == null || !estrategias.Any())
                        {
                            estrategias = new List<BEEstrategia>();
                            using (var reader = daEstrategia.GetEstrategiaHerramientasVenta(entidad))
                            {
                                while (reader.Read()) estrategias.Add(new BEEstrategia(reader));
                            }

                            CacheManager<BEEstrategia>.AddData(entidad.PaisID, ECacheItem.HVEstrategia, entidad.CampaniaID.ToString(), estrategias);
                        }
                        break;
                    case Constantes.TipoEstrategiaCodigo.ShowRoom:
                        using (var reader = daEstrategia.GetEstrategiaShowRoom(entidad))
                        {
                            while (reader.Read()) estrategias.Add(new BEEstrategia(reader));
                        }
                        break;
                    case Constantes.TipoEstrategiaCodigo.LosMasVendidos:
                        using (var reader = daEstrategia.GetEstrategiaMasVendidos(entidad))
                        {
                            while (reader.Read()) estrategias.Add(new BEEstrategia(reader));
                        }
                        break;
                    default:
                        using (var reader = daEstrategia.GetEstrategiaPedido(entidad))
                        {
                            while (reader.Read()) estrategias.Add(new BEEstrategia(reader));
                        }
                        break;
                }

                var estrategiasResult = EstrategiasPedidoLimpiar(estrategias, entidad);
                return estrategiasResult;
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, entidad.ConsultoraID, entidad.PaisID.ToString());
                return new List<BEEstrategia>();
            }
        }

        private List<BEEstrategia> EstrategiasPedidoLimpiar(List<BEEstrategia> lista, BEEstrategia entidad)
        {
            var estrategiasResult = new List<BEEstrategia>();
            var codigoIso = Util.GetPaisISO(entidad.PaisID);
            var esFacturacion = false;
            if (entidad.ValidarPeriodoFacturacion)
            {
                var fechaHoy = DateTime.Now.AddHours(entidad.ZonaHoraria).Date;
                esFacturacion = fechaHoy >= entidad.FechaInicioFacturacion.Date;
            }

            if (esFacturacion)
            {
                var listaTieneStock = new List<Lista>();
                try
                {
                    var codigoSap = string.Join("|", lista.Where(e => !string.IsNullOrEmpty(e.CodigoProducto)).Select(e => e.CodigoProducto));
                    if (!string.IsNullOrEmpty(codigoSap))
                    {
                        using (var sv = new wsConsulta())
                        {
                            sv.Url = ConfigurationManager.AppSettings["RutaServicePROLConsultas"];
                            listaTieneStock = sv.ConsultaStock(codigoSap, codigoIso).ToList();
                        }
                    }
                }
                catch (Exception ex)
                {
                    LogManager.SaveLog(ex, entidad.ConsultoraID, entidad.PaisID.ToString());
                    listaTieneStock = new List<Lista>();
                }

                lista.ForEach(estrategia =>
                {
                    if (estrategia.Precio2 > 0)
                    {
                        var add = true;
                        if (estrategia.TipoEstrategiaImagenMostrar == Constantes.TipoEstrategia.OfertaParaTi)
                            add = listaTieneStock.Any(p => p.Codsap.ToString() == estrategia.CodigoProducto && p.estado == 1);

                        if (!add) return;

                        estrategiasResult.Add(estrategia);
                    }
                });
            }
            else estrategiasResult.AddRange(lista.Where(e => e.Precio2 > 0));

            var carpetaPais = Globals.UrlMatriz + "/" + codigoIso;
            estrategiasResult.ForEach(estrategia =>
            {
                if (estrategia.Precio <= estrategia.Precio2)
                    estrategia.Precio = Convert.ToDecimal(0.0);

                estrategia.CampaniaID = entidad.CampaniaID;
                estrategia.ImagenURL = ConfigS3.GetUrlFileS3(carpetaPais, estrategia.ImagenURL, carpetaPais);
                estrategia.Simbolo = entidad.Simbolo;
                estrategia.TieneStockProl = true;
                estrategia.PrecioString = Util.DecimalToStringFormat(estrategia.Precio2, codigoIso);
                estrategia.PrecioTachado = Util.DecimalToStringFormat(estrategia.Precio, codigoIso);
                estrategia.GananciaString = Util.DecimalToStringFormat(estrategia.Ganancia, codigoIso);
                //estrategia.FotoProducto01 = ConfigS3.GetUrlFileS3(carpetaPais, estrategia.FotoProducto01, carpetaPais);
                estrategia.CodigoEstrategia = Util.Trim(estrategia.CodigoEstrategia);
            });
            return estrategiasResult;
        }
    }
}
