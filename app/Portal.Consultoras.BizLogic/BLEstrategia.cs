using Portal.Consultoras.Common;
using Portal.Consultoras.Data;
using Portal.Consultoras.Data.ServicePROLConsultas;
using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Transactions;

namespace Portal.Consultoras.BizLogic
{
    public class BLEstrategia
    {
        public List<BEEstrategia> GetEstrategias(BEEstrategia entidad)
        {
            try
            {
                List<BEEstrategia> listaEstrategias = new List<BEEstrategia>();

                var DAEstrategia = new DAEstrategia(entidad.PaisID);
                using (IDataReader reader = DAEstrategia.GetEstrategia(entidad))
                {
                    while (reader.Read())
                    {
                        listaEstrategias.Add(new BEEstrategia(reader));
                    }
                }
                return listaEstrategias;
            }
            catch (Exception) { throw; }
        }

        public BEEstrategiaDetalle GetEstrategiaDetalle(int paisID, int estrategiaID)
        {
            BEEstrategiaDetalle estrategiaDetalle = new BEEstrategiaDetalle();
            var DAEstrategia = new DAEstrategia(paisID);
            using (IDataReader reader = DAEstrategia.GetEstrategiaDetalle(estrategiaID))
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
            try
            {
                List<BEEstrategia> listaEstrategias = new List<BEEstrategia>();

                var DAEstrategia = new DAEstrategia(entidad.PaisID);
                using (IDataReader reader = DAEstrategia.FiltrarEstrategia(entidad))
                {
                    while (reader.Read())
                    {

                        listaEstrategias.Add(new BEEstrategia(reader));
                    }
                }
                foreach (var estrategia in listaEstrategias)
                {
                    var estrategiaDetalle = GetEstrategiaDetalle(entidad.PaisID, estrategia.EstrategiaID);
                    estrategia.ImgFondoDesktop = estrategiaDetalle.ImgFondoDesktop;
                    estrategia.ImgPrevDesktop = estrategiaDetalle.ImgPrevDesktop;
                    estrategia.ImgFichaDesktop = estrategiaDetalle.ImgFichaDesktop;
                    estrategia.UrlVideoDesktop = estrategiaDetalle.UrlVideoDesktop;
                    estrategia.ImgFondoMobile = estrategiaDetalle.ImgFondoMobile;
                    estrategia.ImgFichaMobile = estrategiaDetalle.ImgFichaMobile;
                    estrategia.UrlVideoMobile = estrategiaDetalle.UrlVideoMobile;
                    estrategia.ImgFichaFondoDesktop = estrategiaDetalle.ImgFichaFondoDesktop;
                    estrategia.ImgFichaFondoMobile = estrategiaDetalle.ImgFichaFondoMobile;
                }
                return listaEstrategias;
            }
            catch (Exception) { throw; }
        }

        public List<BEMatrizComercialImagen> GetImagenesByEstrategiaMatrizComercialImagen(BEEstrategia entidad, int pagina, int registros)
        {
            try
            {
                List<BEMatrizComercialImagen> listaImagenes = new List<BEMatrizComercialImagen>();

                var DAEstrategia = new DAEstrategia(entidad.PaisID);
                using (IDataReader reader = DAEstrategia.GetImagenesByEstrategiaMatrizComercialImagen(entidad, pagina, registros))
                {
                    while (reader.Read())
                    {
                        listaImagenes.Add(new BEMatrizComercialImagen(reader));
                    }
                }
                return listaImagenes;
            }
            catch (Exception) { throw; }
        } 

        public List<BETallaColor> GetTallaColor(BETallaColor entidad)
        {
            try
            {
                var listaTallaColor = new List<BETallaColor>();
                var DAEstrategia = new DAEstrategia(entidad.PaisID);
                using (IDataReader reader = DAEstrategia.GetTallaColor(entidad))
                {
                    while (reader.Read())
                    {
                        listaTallaColor.Add(new BETallaColor(reader));
                    }
                }
                return listaTallaColor;
            }
            catch (Exception) { throw; }
        }

        public int InsertTallaColorCUV(BETallaColor entidad)
        {
            try
            {
                var DAEstrategia = new DAEstrategia(entidad.PaisID);
                int result = DAEstrategia.InsertTallaColorCUV(entidad);
                return result;
            }
            catch (Exception) { throw; }
        }

        public List<BEEstrategia> GetOfertaByCUV(BEEstrategia entidad)
        {
            try
            {
                List<BEEstrategia> listaEstrategias = new List<BEEstrategia>();

                var DAEstrategia = new DAEstrategia(entidad.PaisID);
                using (IDataReader reader = DAEstrategia.GetOfertaByCUV(entidad))
                {
                    while (reader.Read())
                    {
                        listaEstrategias.Add(new BEEstrategia(reader));
                    }
                }
                return listaEstrategias;
            }
            catch (Exception) { throw; }
        }

        public int InsertEstrategia(BEEstrategia entidad)
        {
            try
            {
                var DAEstrategia = new DAEstrategia(entidad.PaisID);
                int result = DAEstrategia.InsertEstrategia(entidad);
                // Solo para estrategia de lanzamiento se agrega el detalle de estrategia.
                if (entidad.CodigoTipoEstrategia != null && entidad.CodigoTipoEstrategia.Equals(Constantes.TipoEstrategiaCodigo.Lanzamiento))
                {
                    BEEstrategiaDetalle estrategiaDetalle = new BEEstrategiaDetalle(entidad);
                    estrategiaDetalle.EstrategiaID = result;
                    DAEstrategia.InsertEstrategiaDetalle(estrategiaDetalle);
                }
                return result;
            }
            catch (Exception)
            {
                throw;
            }
        }

        public int DeshabilitarEstrategia(BEEstrategia entidad)
        {
            try
            {
                var DAEstrategia = new DAEstrategia(entidad.PaisID);
                int result = DAEstrategia.DeshabilitarEstrategia(entidad);
                return result;
            }
            catch (Exception) { throw; }
        }

        public int EliminarTallaColor(BETallaColor entidad)
        {
            try
            {
                var DAEstrategia = new DAEstrategia(entidad.PaisID);
                int result = DAEstrategia.EliminarTallaColor(entidad);
                return result;
            }
            catch (Exception) { throw; }
        }

        public int ValidarCUVsRecomendados(BEEstrategia entidad)
        {
            try
            {
                var DAEstrategia = new DAEstrategia(entidad.PaisID);
                int result = DAEstrategia.ValidarCUVsRecomendados(entidad);
                return result;
            }
            catch (Exception) { throw; }
        }

        public List<BEEstrategia> GetEstrategiasPedido(BEEstrategia entidad)
        {
            var estrategiasResult = new List<BEEstrategia>();
            var estrategias = new List<BEEstrategia>();
            var codigoIso = Util.GetPaisISO(entidad.PaisID);

            var daEstrategia = new DAEstrategia(entidad.PaisID);
            using (var reader = daEstrategia.GetEstrategiaPedido(entidad))
            {
                while (reader.Read()) estrategias.Add(new BEEstrategia(reader));
            }

            var esFacturacion = false;
            if (entidad.ValidarPeriodoFacturacion)
            {
                var fechaHoy = DateTime.Now.AddHours(entidad.ZonaHoraria).Date;
                esFacturacion = fechaHoy >= entidad.FechaInicioFacturacion.Date;
            }

            if (esFacturacion)
            {
                /*Obtener si tiene stock de PROL por CodigoSAP*/
                var listaTieneStock = new List<Lista>();
                try
                {
                    var codigoSap = string.Join("|", estrategias.Where(e => !string.IsNullOrEmpty(e.CodigoProducto)).Select(e => e.CodigoProducto));
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

                estrategias.ForEach(estrategia =>
                {
                    if (estrategia.Precio2 > 0)
                    {
                        var add = true;
                        if (estrategia.TipoEstrategiaImagenMostrar ==
                            Constantes.TipoEstrategia.OfertaParaTi)
                        {
                        add = listaTieneStock.Any(p => p.Codsap.ToString() == estrategia.CodigoProducto && p.estado == 1);
                        }
                        if (!add) return;

                        if (estrategia.Precio >= estrategia.Precio2)
                            estrategia.Precio = Convert.ToDecimal(0.0);

                        estrategiasResult.Add(estrategia);
                    }
                });
            }
            else estrategiasResult.AddRange(estrategias);

            var carpetaPais = Globals.UrlMatriz + "/" + codigoIso; //pais ISO
            estrategiasResult.ForEach(estrategia =>
            {
                estrategia.ImagenURL = ConfigS3.GetUrlFileS3(carpetaPais, estrategia.ImagenURL, carpetaPais);
                estrategia.Simbolo = entidad.Simbolo;
                estrategia.TieneStockProl = true;
                estrategia.PrecioString = Util.DecimalToStringFormat(estrategia.Precio2, codigoIso);
                estrategia.PrecioTachado = Util.DecimalToStringFormat(estrategia.Precio, codigoIso);
                estrategia.FotoProducto01 = string.IsNullOrEmpty(estrategia.FotoProducto01) ? string.Empty : ConfigS3.GetUrlFileS3(carpetaPais, estrategia.FotoProducto01, carpetaPais);
                estrategia.URLCompartir = Util.GetUrlCompartirFB(codigoIso);
                estrategia.CodigoEstrategia = Util.Trim(estrategia.CodigoEstrategia);
            });
            return estrategiasResult;
        }

        public List<BEEstrategia> GetMasVendidos(BEEstrategia entidad)
        {
            var estrategiasResult = new List<BEEstrategia>();
            var estrategias = new List<BEEstrategia>();
            var codigoIso = Util.GetPaisISO(entidad.PaisID);

            var daEstrategia = new DAEstrategia(entidad.PaisID);
            using (var reader = daEstrategia.GetMasVendidos(entidad))
            {
                while (reader.Read()) estrategias.Add(new BEEstrategia(reader));
            }

            var esFacturacion = false;
            if (entidad.ValidarPeriodoFacturacion)
            {
                var fechaHoy = DateTime.Now.AddHours(entidad.ZonaHoraria).Date;
                esFacturacion = fechaHoy >= entidad.FechaInicioFacturacion.Date;
            }

            if (esFacturacion)
            {
                /*Obtener si tiene stock de PROL por CodigoSAP*/
                var listaTieneStock = new List<Lista>();
                try
                {
                    var codigoSap = string.Join("|", estrategias.Where(e => !string.IsNullOrEmpty(e.CodigoProducto)).Select(e => e.CodigoProducto));
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

                estrategias.ForEach(estrategia =>
                {
                    if (estrategia.Precio2 > 0)
                    {
                        var add = true;
                        if (estrategia.TipoEstrategiaImagenMostrar ==
                            Constantes.TipoEstrategia.OfertaParaTi)
                        {
                            add = listaTieneStock.Any(p => p.Codsap.ToString() == estrategia.CodigoProducto && p.estado == 1);
                        }
                        if (!add) return;

                        if (estrategia.Precio >= estrategia.Precio2)
                            estrategia.Precio = Convert.ToDecimal(0.0);

                        estrategiasResult.Add(estrategia);
                    }
                });
            }
            else estrategiasResult.AddRange(estrategias);

            var carpetaPais = Globals.UrlMatriz + "/" + codigoIso; //pais ISO
            estrategiasResult.ForEach(estrategia =>
            {
                estrategia.ImagenURL = ConfigS3.GetUrlFileS3(carpetaPais, estrategia.ImagenURL, carpetaPais);
                estrategia.Simbolo = entidad.Simbolo;
                estrategia.TieneStockProl = true;
                estrategia.PrecioString = Util.DecimalToStringFormat(estrategia.Precio2, codigoIso);
                estrategia.PrecioTachado = Util.DecimalToStringFormat(estrategia.Precio, codigoIso);
                estrategia.FotoProducto01 = string.IsNullOrEmpty(estrategia.FotoProducto01) ? string.Empty : ConfigS3.GetUrlFileS3(carpetaPais, estrategia.FotoProducto01, carpetaPais);
                estrategia.URLCompartir = Util.GetUrlCompartirFB(codigoIso);
                estrategia.CodigoEstrategia = Util.Trim(estrategia.CodigoEstrategia);
            });
            return estrategiasResult;
        }

        public List<BEEstrategia> FiltrarEstrategiaPedido(BEEstrategia entidad)
        {
            try
            {
                List<BEEstrategia> listaEstrategias = new List<BEEstrategia>();

                var DAEstrategia = new DAEstrategia(entidad.PaisID);
                using (IDataReader reader = DAEstrategia.FiltrarEstrategiaPedido(entidad))
                {
                    while (reader.Read())
                    {
                        listaEstrategias.Add(new BEEstrategia(reader));
                    }
                }
                return listaEstrategias;
            }
            catch (Exception) { throw; }
        }

        public string ValidarStockEstrategia(BEEstrategia entidad)
        {
            var DAEstrategia = new DAEstrategia(entidad.PaisID);
            return DAEstrategia.ValidarStockEstrategia(entidad);
        }
        // 1747 - Inicio
        public IList<BEConfiguracionValidacionZE> GetRegionZonaZE(int PaisID, int RegionID, int ZonaID)
        {
            var lista = new List<BEConfiguracionValidacionZE>();
            var DAEstrategia = new DAEstrategia(PaisID);

            using (IDataReader reader = DAEstrategia.GetRegionZonaZE(RegionID, ZonaID))
                while (reader.Read())
                {
                    var entidad = new BEConfiguracionValidacionZE(reader);
                    lista.Add(entidad);
                }

            return lista;
        }
        // 1747 - Fin

        public string GetImagenOfertaPersonalizadaOF(int paisID, int campaniaID, string cuv)
        {
            var imagen = string.Empty;
            var DAEstrategia = new DAEstrategia(paisID);

            return DAEstrategia.GetImagenOfertaPersonalizadaOF(campaniaID, cuv);
        }

        public int GetCantidadOfertasParaTi(int paisId, int campaniaId, int tipoConfigurado, int estrategiaId)
        {
            try
            {
                var DAEstrategia = new DAEstrategia(paisId);
                int result = DAEstrategia.GetCantidadOfertasParaTi(campaniaId, tipoConfigurado, estrategiaId);
                return result;
            }
            catch (Exception) { throw; }
        }

        public List<BEEstrategia> GetOfertasParaTiByTipoConfigurado(int paisId, int campaniaId, int tipoConfigurado, int estrategiaId)
        {
            try
            {
                List<BEEstrategia> listaEstrategias = new List<BEEstrategia>();

                var DAEstrategia = new DAEstrategia(paisId);
                using (IDataReader reader = DAEstrategia.GetOfertasParaTiByTipoConfigurado(campaniaId, tipoConfigurado, estrategiaId))
                {
                    while (reader.Read())
                    {
                        listaEstrategias.Add(new BEEstrategia(reader,  true));
                    }
                }
                return listaEstrategias;
            }
            catch (Exception) { throw; }
        }

        public int InsertEstrategiaTemporal(int paisId, List<BEEstrategia> lista, int campaniaId, string codigoUsuario)
        {
            var DAEstrategia = new DAEstrategia(paisId);
            return DAEstrategia.InsertEstrategiaTemporal(lista, campaniaId, codigoUsuario);
        }

        public int GetCantidadOfertasParaTiTemporal(int paisId, int campaniaId, int tipoConfigurado)
        {
            try
            {
                var DAEstrategia = new DAEstrategia(paisId);
                int result = DAEstrategia.GetCantidadOfertasParaTiTemporal(campaniaId, tipoConfigurado);
                return result;
            }
            catch (Exception) { throw; }
        }

        public List<BEEstrategia> GetOfertasParaTiByTipoConfiguradoTemporal(int paisId, int campaniaId, int tipoConfigurado)
        {
            try
            {
                List<BEEstrategia> listaEstrategias = new List<BEEstrategia>();

                var DAEstrategia = new DAEstrategia(paisId);
                using (IDataReader reader = DAEstrategia.GetOfertasParaTiByTipoConfiguradoTemporal(campaniaId, tipoConfigurado))
                {
                    while (reader.Read())
                    {
                        listaEstrategias.Add(new BEEstrategia(reader));
                    }
                }
                return listaEstrategias;
            }
            catch (Exception) { throw; }
        }

        public int DeleteEstrategiaTemporal(int paisId, int campaniaId)
        {
            try
            {
                var DAEstrategia = new DAEstrategia(paisId);
                int result = DAEstrategia.DeleteEstrategiaTemporal(campaniaId);
                return result;
            }
            catch (Exception) { throw; }
        }

        public int InsertEstrategiaOfertaParaTi(int paisId, List<BEEstrategia> lista, int campaniaId, string codigoUsuario, int estrategiaId)
        {
            var DAEstrategia = new DAEstrategia(paisId);
            return DAEstrategia.InsertEstrategiaOfertaParaTi(lista, campaniaId, codigoUsuario, estrategiaId);
        }

        /*PL20-1226*/
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
                item.FotoProducto01 = string.IsNullOrEmpty(item.FotoProducto01) ? string.Empty : ConfigS3.GetUrlFileS3(carpetaPais, item.FotoProducto01, carpetaPais);
                item.URLCompartir = Util.GetUrlCompartirFB(codigoIso);
            });

            return listaEstrategias;
        }

        public int ActivarDesactivarEstrategias(int paisID, String UsuarioModificacion, String EstrategiasActivas, String EstrategiasDesactivas)
        {
            var DAEstrategia = new DAEstrategia(paisID);
            return DAEstrategia.ActivarDesactivarEstrategias(UsuarioModificacion, EstrategiasActivas, EstrategiasDesactivas);
        }

        #region Producto Comentario

        public int InsertarProductoComentarioDetalle(int paisID, BEProductoComentarioDetalle entidad)
        {
            int result;
            var daEstrategia = new DAEstrategia(paisID);
            var oTransactionOptions = new TransactionOptions();
            oTransactionOptions.IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted;

            try
            {
                using (TransactionScope oTransactionScope = new TransactionScope(TransactionScopeOption.Required, oTransactionOptions))
                {
                    if (entidad.ProdComentarioId == 0)
                    {
                        BEProductoComentario oProdComentario = new BEProductoComentario();
                        oProdComentario.CodigoSap = entidad.CodigoSAP;
                        oProdComentario.CodigoGenerico = entidad.CodigoGenerico;
                        entidad.ProdComentarioId = daEstrategia.InsertarProductoComentario(oProdComentario);
                    }

                    result = daEstrategia.InsertarProductoComentarioDetalle(entidad);
                    if (result > 0)
                    {
                        daEstrategia.UpdCantidadProductoComentario(entidad.ProdComentarioId);
                    }
                    
                    oTransactionScope.Complete();
                }
            }

            catch (Exception ex)
            {
                throw;
            }

            return result;
        }

        public BEProductoComentario GetProductoComentarioByCodSap(int paisID, string codigoSAP)
        {
            BEProductoComentario entidad = null;
            var daEstrategia = new DAEstrategia(paisID);

            using (var reader = daEstrategia.GetProductoComentarioByCodSap(codigoSAP))
            {
                if (reader.Read())
                {
                    entidad = new BEProductoComentario(reader);
                }
            }

            return entidad;
        }

        //public List<BEProductoComentario> GetProductoComentarioResumenByListaCodSap(int paisID, string listaCod, string separador)
        //{
        //    List<BEProductoComentario> listaResumen = new List<BEProductoComentario>();
        //    var daEstrategia = new DAEstrategia(paisID);

        //    using (var reader = daEstrategia.GetProductoComentarioResumenByListaCodSap(listaCod, separador))
        //    {
        //        if (reader.Read())
        //        {
        //            listaResumen.Add(new BEProductoComentario(reader));
        //        }
        //    }

        //    return listaResumen;
        //}

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
            int result;
            var daEstrategia = new DAEstrategia(paisID);

            try
            {
                result = daEstrategia.AprobarProductoComentarioDetalle(entidad.ProdComentarioDetalleId);
                if (result > 0)
                {
                    daEstrategia.UpdAprobadosProductoComentario(entidad.ProdComentarioId, entidad.Recomendado);
                }
            }

            catch (Exception)
            {
                throw;
            }

            return result;
        }

        #endregion
    }
}
