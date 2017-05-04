using Portal.Consultoras.Common;
using Portal.Consultoras.Data;
using Portal.Consultoras.Data.ServicePROLConsultas;
using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;

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
                return listaEstrategias;
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
                return result;
            }
            catch (Exception) { throw; }
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

        public List<BEEstrategia> GetEstrategiasPedido(BEEstrategia entidad, int paisId, string codigoUsuario)
        {
            var usuario = new BLUsuario().GetSesionUsuario(paisId, codigoUsuario);
            var estrategiasResult = new List<BEEstrategia>();
            var estrategias = new List<BEEstrategia>();

            var daEstrategia = new DAEstrategia(entidad.PaisID);
            using (IDataReader reader = daEstrategia.GetEstrategiaPedido(entidad))
            {
                while (reader.Read())
                {
                    estrategias.Add(new BEEstrategia(reader));
                }
            }

            var fechaHoy = DateTime.Now.AddHours(usuario.ZonaHoraria).Date;
            var esFacturacion = fechaHoy >= usuario.FechaInicioFacturacion.Date;

            var carpetapais = Globals.UrlMatriz + "/" + usuario.CodigoISO;

            if (entidad.ValidarPeriodoFacturacion && esFacturacion)
            {
                /*Obtener si tiene stock de PROL por CodigoSAP*/
                var codigoSap = string.Join("|", estrategias.Where(e => !string.IsNullOrEmpty(e.CodigoProducto)).Select(e => e.CodigoProducto));

                var listaTieneStock = new List<Lista>();

                if (!string.IsNullOrEmpty(codigoSap) && entidad.ValidarStock)
                {
                    using (var sv = new wsConsulta())
                    {
                        sv.Url = ConfigurationManager.AppSettings["RutaServicePROLConsultas"];
                        listaTieneStock = sv.ConsultaStock(codigoSap, usuario.CodigoISO).ToList();
                    }
                }

                estrategias.ForEach(estrategia =>
                {
                    var add = true;
                    if (entidad.ValidarStock && estrategia.TipoEstrategiaImagenMostrar ==
                        Constantes.TipoEstrategia.OfertaParaTi)
                    {
                        add = listaTieneStock.Any(
                            p => p.Codsap.ToString() == estrategia.CodigoProducto && p.estado == 1);
                    }

                    if (!add) return;

                    //beEstrategia.FotoProducto01 = ConfigS3.GetUrlFileS3(carpetapais, beEstrategia.FotoProducto01, carpetapais);
                    estrategia.ImagenURL = ConfigS3.GetUrlFileS3(carpetapais, estrategia.ImagenURL, carpetapais);
                    estrategia.Simbolo = usuario.Simbolo;
                    estrategia.TieneStockProl = true;
                    estrategia.PrecioString = Util.DecimalToStringFormat(estrategia.Precio2, usuario.CodigoISO);
                    estrategia.PrecioTachado = Util.DecimalToStringFormat(estrategia.Precio, usuario.CodigoISO);

                    estrategiasResult.Add(estrategia);
                });
            }
            else
            {
                estrategias.ForEach(x =>
                {
                    //x.FotoProducto01 = x.FotoProducto01; //ConfigS3.GetUrlFileS3(carpetapais, x.FotoProducto01, carpetapais);
                    x.ImagenURL = ConfigS3.GetUrlFileS3(carpetapais, x.ImagenURL, carpetapais);
                    x.Simbolo = usuario.Simbolo;
                    x.TieneStockProl = true;
                    x.PrecioString = Util.DecimalToStringFormat(x.Precio2, usuario.CodigoISO);
                    x.PrecioTachado = Util.DecimalToStringFormat(x.Precio, usuario.CodigoISO);
                });

                estrategiasResult.AddRange(estrategias);
            }


            var carpetaPais = Globals.UrlMatriz + "/" + usuario.CodigoISO;
            estrategiasResult.ForEach(item =>
            {

                item.FotoProducto01 = ConfigS3.GetUrlFileS3(carpetaPais, item.FotoProducto01, carpetaPais);
                item.URLCompartir = Util.GetUrlCompartirFB(usuario.CodigoISO);
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

        public int GetCantidadOfertasParaTi(int paisId, int campaniaId, int tipoConfigurado)
        {
            try
            {
                var DAEstrategia = new DAEstrategia(paisId);
                int result = DAEstrategia.GetCantidadOfertasParaTi(campaniaId, tipoConfigurado);
                return result;
            }
            catch (Exception) { throw; }
        }

        public List<BEEstrategia> GetOfertasParaTiByTipoConfigurado(int paisId, int campaniaId, int tipoConfigurado)
        {
            try
            {
                List<BEEstrategia> listaEstrategias = new List<BEEstrategia>();

                var DAEstrategia = new DAEstrategia(paisId);
                using (IDataReader reader = DAEstrategia.GetOfertasParaTiByTipoConfigurado(campaniaId, tipoConfigurado))
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

        public int InsertEstrategiaOfertaParaTi(int paisId, List<BEEstrategia> lista, int campaniaId, string codigoUsuario)
        {
            var DAEstrategia = new DAEstrategia(paisId);
            return DAEstrategia.InsertEstrategiaOfertaParaTi(lista, campaniaId, codigoUsuario);
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

            var usuario = new BLUsuario().GetSesionUsuario(paisID, codConsultora);
            var carpetaPais = Globals.UrlMatriz + "/" + usuario.CodigoISO;

            listaEstrategias.ForEach(item =>
            {
                item.FotoProducto01 = ConfigS3.GetUrlFileS3(carpetaPais, item.FotoProducto01, carpetaPais);
                item.URLCompartir = Util.GetUrlCompartirFB(usuario.CodigoISO);
            });

            return listaEstrategias;
        }

        public int ActivarDesactivarEstrategias(int paisID, String UsuarioModificacion, String EstrategiasActivas, String EstrategiasDesactivas)
        {
            var DAEstrategia = new DAEstrategia(paisID);
            return DAEstrategia.ActivarDesactivarEstrategias(UsuarioModificacion, EstrategiasActivas, EstrategiasDesactivas);
        }

    }
}
