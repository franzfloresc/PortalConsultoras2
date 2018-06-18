using Portal.Consultoras.Common;
using Portal.Consultoras.Data;
using Portal.Consultoras.Data.ServicePROLConsultas;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.CargaMasiva;
using Portal.Consultoras.Entities.Estrategia;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Transactions;

namespace Portal.Consultoras.BizLogic
{
    public class BLEstrategia : IEstrategiaBusinessLogic
    {
        public List<BEEstrategia> GetEstrategias(BEEstrategia entidad)
        {
            using (IDataReader reader = new DAEstrategia(entidad.PaisID).GetEstrategia(entidad))
            {
                return reader.MapToCollection<BEEstrategia>();
            }
        }

        public BEEstrategiaDetalle GetEstrategiaDetalle(int paisID, int estrategiaID)
        {
            BEEstrategiaDetalle estrategiaDetalle = new BEEstrategiaDetalle();
            var daEstrategia = new DAEstrategia(paisID);
            using (IDataReader reader = daEstrategia.GetEstrategiaDetalle(estrategiaID))
            {
                if (reader.Read())
                {
                    estrategiaDetalle = new BEEstrategiaDetalle(reader);
                }
            }
            return estrategiaDetalle;
        }

        public List<BEEstrategia> FiltrarEstrategia(BEEstrategia entidad)
        {
            List<BEEstrategia> listaEstrategias = new List<BEEstrategia>();

            var daEstrategia = new DAEstrategia(entidad.PaisID);
            using (IDataReader reader = daEstrategia.FiltrarEstrategia(entidad))
            {
                while (reader.Read())
                {

                    listaEstrategias.Add(new BEEstrategia(reader));
                }
            }
            foreach (var estrategia in listaEstrategias)
            {
                var estrategiaDetalle = GetEstrategiaDetalle(entidad.PaisID, estrategia.EstrategiaID);
                estrategia.FlagIndividual = estrategiaDetalle.FlagIndividual;
                estrategia.Slogan = estrategiaDetalle.Slogan;
                estrategia.ImgHomeDesktop = estrategiaDetalle.ImgHomeDesktop;
                estrategia.ImgFondoDesktop = estrategiaDetalle.ImgFondoDesktop;
                estrategia.ImgFichaDesktop = estrategiaDetalle.ImgFichaDesktop;
                estrategia.ImgFichaFondoDesktop = estrategiaDetalle.ImgFichaFondoDesktop;
                estrategia.UrlVideoDesktop = estrategiaDetalle.UrlVideoDesktop;
                estrategia.ImgHomeMobile = estrategiaDetalle.ImgHomeMobile;
                estrategia.ImgFondoMobile = estrategiaDetalle.ImgFondoMobile;
                estrategia.ImgFichaMobile = estrategiaDetalle.ImgFichaMobile;
                estrategia.ImgFichaFondoMobile = estrategiaDetalle.ImgFichaFondoMobile;
                estrategia.UrlVideoMobile = estrategiaDetalle.UrlVideoMobile;
            }
            return listaEstrategias;
        }

        public List<BEMatrizComercialImagen> GetImagenesByEstrategiaMatrizComercialImagen(BEEstrategia entidad, int pagina, int registros)
        {
            List<BEMatrizComercialImagen> listaImagenes = new List<BEMatrizComercialImagen>();

            var daEstrategia = new DAEstrategia(entidad.PaisID);
            using (IDataReader reader = daEstrategia.GetImagenesByEstrategiaMatrizComercialImagen(entidad, pagina, registros))
            {
                while (reader.Read())
                {
                    listaImagenes.Add(new BEMatrizComercialImagen(reader));
                }
            }
            return listaImagenes;
        }

        public List<BETallaColor> GetTallaColor(BETallaColor entidad)
        {
            var listaTallaColor = new List<BETallaColor>();
            var daEstrategia = new DAEstrategia(entidad.PaisID);
            using (IDataReader reader = daEstrategia.GetTallaColor(entidad))
            {
                while (reader.Read())
                {
                    listaTallaColor.Add(new BETallaColor(reader));
                }
            }
            return listaTallaColor;
        }

        public int InsertTallaColorCUV(BETallaColor entidad)
        {
            var daEstrategia = new DAEstrategia(entidad.PaisID);
            int result = daEstrategia.InsertTallaColorCUV(entidad);
            return result;
        }

        public List<BEEstrategia> GetOfertaByCUV(BEEstrategia entidad)
        {
            List<BEEstrategia> listaEstrategias = new List<BEEstrategia>();

            var daEstrategia = new DAEstrategia(entidad.PaisID);
            using (IDataReader reader = daEstrategia.GetOfertaByCUV(entidad))
            {
                while (reader.Read())
                {
                    listaEstrategias.Add(new BEEstrategia(reader));
                }
            }
            return listaEstrategias;
        }

        public int InsertEstrategia(BEEstrategia entidad)
        {
            var daEstrategia = new DAEstrategia(entidad.PaisID);
            int result = daEstrategia.InsertEstrategia(entidad);
            if (entidad.CodigoTipoEstrategia != null && entidad.CodigoTipoEstrategia.Equals(Constantes.TipoEstrategiaCodigo.Lanzamiento))
            {
                BEEstrategiaDetalle estrategiaDetalle = new BEEstrategiaDetalle(entidad) { EstrategiaID = result };
                daEstrategia.InsertEstrategiaDetalle(estrategiaDetalle);
            }
            return result;
        }

        public int DeshabilitarEstrategia(BEEstrategia entidad)
        {
            var daEstrategia = new DAEstrategia(entidad.PaisID);
            int result = daEstrategia.DeshabilitarEstrategia(entidad);
            return result;
        }

        public int EliminarEstrategia(BEEstrategia entidad)
        {
            try
            {
                var DAEstrategia = new DAEstrategia(entidad.PaisID);
                int result = DAEstrategia.EliminarEstrategia(entidad);
                return result;
            }
            catch (Exception) { throw; }
        }

        public int EliminarTallaColor(BETallaColor entidad)
        {
            var daEstrategia = new DAEstrategia(entidad.PaisID);
            int result = daEstrategia.EliminarTallaColor(entidad);
            return result;
        }

        public int ValidarCUVsRecomendados(BEEstrategia entidad)
        {
            var daEstrategia = new DAEstrategia(entidad.PaisID);
            int result = daEstrategia.ValidarCUVsRecomendados(entidad);
            return result;
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

        public List<BEEstrategia> FiltrarEstrategiaPedido(BEEstrategia entidad)
        {
            List<BEEstrategia> listaEstrategias = new List<BEEstrategia>();

            var daEstrategia = new DAEstrategia(entidad.PaisID);
            using (IDataReader reader = daEstrategia.FiltrarEstrategiaPedido(entidad))
            {
                while (reader.Read())
                {
                    listaEstrategias.Add(new BEEstrategia(reader));
                }
            }
            return listaEstrategias;
        }

        public string ValidarStockEstrategia(BEEstrategia entidad)
        {
            var daEstrategia = new DAEstrategia(entidad.PaisID);
            return daEstrategia.ValidarStockEstrategia(entidad);
        }

        public IList<BEConfiguracionValidacionZE> GetRegionZonaZE(int PaisID, int RegionID, int ZonaID)
        {
            var lista = new List<BEConfiguracionValidacionZE>();
            var daEstrategia = new DAEstrategia(PaisID);

            using (IDataReader reader = daEstrategia.GetRegionZonaZE(RegionID, ZonaID))
                while (reader.Read())
                {
                    var entidad = new BEConfiguracionValidacionZE(reader);
                    lista.Add(entidad);
                }

            return lista;
        }

        public string GetImagenOfertaPersonalizadaOF(int paisID, int campaniaID, string cuv)
        {
            var daEstrategia = new DAEstrategia(paisID);

            return daEstrategia.GetImagenOfertaPersonalizadaOF(campaniaID, cuv);
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

        public int ActivarDesactivarEstrategias(int paisID, String UsuarioModificacion, String EstrategiasActivas, String EstrategiasDesactivas)
        {
            var daEstrategia = new DAEstrategia(paisID);
            return daEstrategia.ActivarDesactivarEstrategias(UsuarioModificacion, EstrategiasActivas, EstrategiasDesactivas);
        }

        #region Producto Comentario

        public int InsertarProductoComentarioDetalle(int paisID, BEProductoComentarioDetalle entidad)
        {
            int result;
            var daEstrategia = new DAEstrategia(paisID);
            var oTransactionOptions =
                new TransactionOptions { IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted };

            try
            {
                using (TransactionScope oTransactionScope = new TransactionScope(TransactionScopeOption.Required, oTransactionOptions))
                {
                    if (entidad.ProdComentarioId == 0)
                    {
                        BEProductoComentario oProdComentario = new BEProductoComentario
                        {
                            CodigoSap = entidad.CodigoSap,
                            CodigoGenerico = entidad.CodigoGenerico
                        };
                        entidad.ProdComentarioId = daEstrategia.InsertarProductoComentario(oProdComentario);
                    }

                    result = daEstrategia.InsertarProductoComentarioDetalle(entidad);

                    oTransactionScope.Complete();
                }
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, "", paisID.ToString());
                throw;
            }

            return result;
        }

        public BEProductoComentario GetProductoComentarioByCodSap(int paisID, string codigoSap)
        {
            BEProductoComentario entidad = null;
            var daEstrategia = new DAEstrategia(paisID);

            using (var reader = daEstrategia.GetProductoComentarioByCodSap(codigoSap))
            {
                if (reader.Read())
                {
                    entidad = new BEProductoComentario(reader);
                }
            }

            return entidad;
        }

        public BEProductoComentarioDetalle GetUltimoProductoComentarioByCodigoSap(int paisID, string codigoSap)
        {
            BEProductoComentarioDetalle entidad = null;
            var daEstrategia = new DAEstrategia(paisID);

            using (var reader = daEstrategia.GetUltimoProductoComentarioByCodigoSap(codigoSap))
            {
                if (reader.Read())
                {
                    entidad = new BEProductoComentarioDetalle(reader);
                }
            }

            return entidad;
        }

        public List<BEProductoComentarioDetalle> GetListaProductoComentarioDetalleResumen(int paisID, BEProductoComentarioFilter filter)
        {
            var listaDetalle = new List<BEProductoComentarioDetalle>();
            var daEstrategia = new DAEstrategia(paisID);

            using (var reader = daEstrategia.GetListaProductoComentarioDetalleaResumen(filter))
            {
                while (reader.Read())
                {
                    listaDetalle.Add(new BEProductoComentarioDetalle(reader));
                }
            }

            return listaDetalle;
        }

        public List<BEProductoComentarioDetalle> GetListaProductoComentarioDetalleAprobar(int paisID, BEProductoComentarioFilter filter)
        {
            var listaDetalle = new List<BEProductoComentarioDetalle>();
            var daEstrategia = new DAEstrategia(paisID);

            using (var reader = daEstrategia.GetListaProductoComentarioDetalleAprobar(filter))
            {
                while (reader.Read())
                {
                    listaDetalle.Add(new BEProductoComentarioDetalle(reader));
                }
            }

            return listaDetalle;
        }

        public int AprobarProductoComentarioDetalle(int paisID, BEProductoComentarioDetalle entidad)
        {
            var daEstrategia = new DAEstrategia(paisID);

            var result = daEstrategia.AprobarProductoComentarioDetalle(entidad.ProdComentarioId, entidad.ProdComentarioDetalleId, entidad.Estado);

            return result;
        }

        #endregion

        public List<int> InsertarEstrategiaMasiva(BEEstrategiaMasiva entidad)
        {
            try
            {
                var DAEstrategia = new DAEstrategia(entidad.PaisID);
                List<int> result = DAEstrategia.InsertarEstrategiaMasiva(entidad);
                return result;
            }
            catch (Exception)
            {
                throw;
            }
        }

        public List<int> InsertarProductoShowroomMasiva(BEEstrategiaMasiva entidad)
        {
            try
            {
                var DAEstrategia = new DAEstrategia(entidad.PaisID);
                List<int> result = DAEstrategia.InsertarProductoShowroomMasiva(entidad);
                return result;
            }
            catch (Exception)
            {
                throw;
            }
        }
        
        public bool LimpiarCacheRedis(int paisID, string codigoTipoEstrategia,string campaniaID)
        {
            try
            {
                switch (codigoTipoEstrategia)
                {
                    case Constantes.TipoEstrategiaCodigo.GuiaDeNegocioDigitalizada:
                        CacheManager<BEEstrategia>.RemoveData(paisID, ECacheItem.GNDEstrategia, campaniaID);
                        break;
                    case Constantes.TipoEstrategiaCodigo.HerramientasVenta:
                        CacheManager<BEEstrategia>.RemoveData(paisID, ECacheItem.HVEstrategia, campaniaID);
                        break;
                }
                return true;
            }
            catch (Exception)
            {
                return false;
            }

        }

        public BEEstrategia GetEstrategiaProgramaNuevas(BEEstrategia entidad)
        {
            BEEstrategia data = new BEEstrategia();
            var da = new DAEstrategia(entidad.PaisID);
            using (IDataReader reader = da.GetEstrategiaProgramaNuevas(entidad))
                if (reader.Read())
                    data = new BEEstrategia(reader);

            return data;
        }

        public BEEstrategia GetEstrategiaPremiosTippingPoint(int paisID, string codigoPrograma, int anioCampana, string codigoNivel)
        {
            BEEstrategia result = new BEEstrategia();
            try
            {
                var da = new BLPremiosProgramaNuevas();
                var entidad = new BEPremiosProgramaNuevas { PaisID = paisID, CodigoPrograma = codigoPrograma, CodigoNivel = codigoNivel, AnioCampana = anioCampana };
                BEPremiosProgramaNuevas PremiosProgramaNuevas = da.GetPremiosProgramaNuevas(entidad);

                BEEstrategia estrategia = new BEEstrategia
                {
                    PaisID = paisID,
                    CodigoPrograma = PremiosProgramaNuevas == null ? "" : PremiosProgramaNuevas.CodigoPrograma,
                    CampaniaID = PremiosProgramaNuevas == null ? 0 : PremiosProgramaNuevas.AnioCampana,
                    CUV2 = PremiosProgramaNuevas == null ? "" : PremiosProgramaNuevas.CUV,
                    CodigoEstrategia = Constantes.TipoEstrategiaCodigo.IncentivosProgramaNuevas
                };
                result = GetEstrategiaProgramaNuevas(estrategia);
            }
            catch
            {
                result = new BEEstrategia();
            }
            return result;
        }

    }
}
