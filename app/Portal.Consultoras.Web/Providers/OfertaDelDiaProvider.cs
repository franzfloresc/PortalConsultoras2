﻿using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.LogManager;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.Estrategia.OfertaDelDia;
using Portal.Consultoras.Web.ServiceOferta;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.SessionManager;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Web.Providers
{
    public class OfertaDelDiaProvider : OfertaBaseProvider
    {
        protected ISessionManager sessionManager;
        protected ConfiguracionManagerProvider _configuracionManager;
        protected TablaLogicaProvider _tablaLogica;
        protected OfertaPersonalizadaProvider _ofertaPersonalizada;
        protected ConsultaProlProvider _consultaProlProvider;
        protected TablaLogicaProvider _tablaLogicaProvider;

        public OfertaDelDiaProvider()
        {
            sessionManager = SessionManager.SessionManager.Instance;
            _configuracionManager = new ConfiguracionManagerProvider();
            _tablaLogica = new TablaLogicaProvider();
            _ofertaPersonalizada = new OfertaPersonalizadaProvider();
            _consultaProlProvider = new ConsultaProlProvider();
            _tablaLogicaProvider = new TablaLogicaProvider();
        }

        public List<ServiceOferta.BEEstrategia> GetOfertas(UsuarioModel model)
        {
            List<ServiceOferta.BEEstrategia> ofertasDelDia = null;
            try
            {
                var entidad = new ServiceOferta.BEEstrategia
                {
                    PaisID = model.PaisID,
                    CampaniaID = model.CampaniaID,
                    ConsultoraID = model.GetCodigoConsultora(),
                    Zona = model.ZonaID.ToString(),
                    ZonaHoraria = model.ZonaHoraria,
                    FechaInicioFacturacion = model.FechaInicioCampania,
                    ValidarPeriodoFacturacion = true,
                    Simbolo = model.Simbolo,
                    CodigoTipoEstrategia = Constantes.TipoEstrategiaCodigo.OfertaDelDia
                };
              

                if (UsarMsPersonalizacion(model.CodigoISO, Constantes.TipoEstrategiaCodigo.OfertaDelDia))
                {
                    var diaInicio = DateTime.Now.Date.Subtract(model.FechaInicioCampania.Date).Days;

                    string pathOferta = string.Format(Constantes.PersonalizacionOfertasService.UrlObtenerOfertas,
                       model.CodigoISO,
                       Constantes.ConfiguracionPais.OfertaDelDia,
                       model.CampaniaID,
                       model.CodigoConsultora,
                       0, //materialGanancia
                       diaInicio,
                       model.CodigorRegion,
                        model.CodigoZona
                     );

                    ofertasDelDia = ObtenerEntidadOfertasDesdeApi(pathOferta, model.CodigoISO);
                    //var taskApi = Task.Run(() => ObtenerOfertasDesdeApi(pathOferta, model.CodigoISO));
                    //Task.WhenAll(taskApi);
                    //ofertasDelDia = taskApi.Result;
                }
                else
                {
                    using (var osc = new OfertaServiceClient())
                    {
                        ofertasDelDia = osc.GetEstrategiaODD(entidad, entidad.ConsultoraID, model.FechaInicioCampania.Date).ToList();
                    }
                }
            }
            catch (Exception ex)
            {
                Common.LogManager.SaveLog(ex, model.CodigoConsultora, model.PaisID.ToString());
                ofertasDelDia = new List<ServiceOferta.BEEstrategia>();
            }

            if (ofertasDelDia.Any())
            {
                ofertasDelDia.ForEach(x => x.TieneStock = true);
                if (GetValidarDiasAntesStock(model))
                {
                    ofertasDelDia = _consultaProlProvider.ActualizarEstrategiaStockPROL(ofertasDelDia, model.CodigoISO, model.CampaniaID, model.CodigoConsultora);
                }
            }

            return ofertasDelDia;
        }

        public TimeSpan CountdownOdd(UsuarioModel model)
        {
            DateTime hoy;
            DateTime d2;
            using (var svc = new SACServiceClient())
            {
                hoy = svc.GetFechaHoraPais(model.PaisID);
            }
            var d1 = new DateTime(hoy.Year, hoy.Month, hoy.Day, 0, 0, 0);

            if (model.EsDiasFacturacion)
            {
                var t1 = model.HoraCierreZonaNormal;
                d2 = new DateTime(hoy.Year, hoy.Month, hoy.Day, t1.Hours, t1.Minutes, t1.Seconds);
            }
            else
            {
                d2 = d1.AddDays(1);
            }
            var t2 = (d2 - hoy);
            return t2;
        }

        public bool NoMostrarBannerODD(string controller)
        {
            var controllerName = controller;
            switch (controllerName)
            {
                case "OfertaLiquidacion":
                    return true;
                case "CatalogoPersonalizado":
                    return true;
                case "ShowRoom":
                    return true;
                default:
                    return false;
            }
        }

        public string ObtenerUrlImagenOfertaDelDia(string codigoIso, int cantidadOfertas)
        {
            var imgSh = string.Format(_configuracionManager.GetConfiguracionManager("UrlImgSoloHoyODD"), codigoIso);
            var exte = imgSh.Split('.')[imgSh.Split('.').Length - 1];
            imgSh = imgSh.Substring(0, imgSh.Length - exte.Length - 1) + (cantidadOfertas > 1 ? "s" : "") + "." + exte;
            return imgSh;
        }

        public string ObtenerDescripcionOfertaDelDia(string descripcionCuv2)
        {
            var descripcionOdd = string.Empty;

            if (!string.IsNullOrWhiteSpace(descripcionCuv2))
            {
                var temp = descripcionCuv2.Split('|').ToList();
                temp = temp.Skip(1).ToList();

                var txtBuil = new StringBuilder();
                foreach (var item in temp)
                {
                    if (!string.IsNullOrEmpty(item))
                        txtBuil.Append(item.Trim() + "|");
                }

                descripcionOdd = txtBuil.ToString();
                descripcionOdd = descripcionOdd == string.Empty
                    ? string.Empty
                    : descripcionOdd.Substring(0, descripcionOdd.Length - 1);
                descripcionOdd = descripcionOdd.Replace("|", " +<br />");
                descripcionOdd = descripcionOdd.Replace("\\", "");
                descripcionOdd = descripcionOdd.Replace("(GRATIS)", "<b>GRATIS</b>");
            }

            return descripcionOdd;
        }

        public string ObtenerNombreOfertaDelDia(string descripcionCuv2)
        {
            var nombreOferta = string.Empty;

            if (!string.IsNullOrWhiteSpace(descripcionCuv2))
            {
                nombreOferta = descripcionCuv2.Split('|').First();
            }

            return nombreOferta;
        }

        public DataModel GetOfertaDelDiaConfiguracion(UsuarioModel usuario, bool origenBase = false)
        {
            var oddSession = sessionManager.OfertaDelDia.Estrategia;

            try
            {
                if (!usuario.EsConsultora())
                {
                    sessionManager.OfertaDelDia.Estrategia = new DataModel();
                    return new DataModel();
                }

                if (oddSession != null)
                {
                    if (!oddSession.TieneOfertaDelDia)
                        return oddSession;
                    
                    oddSession.TeQuedan = CountdownOdd(usuario);
                    oddSession.ImagenBanner = ConfigCdn.GetUrlFileCdnMatriz(usuario.CodigoISO, oddSession.ImagenBanner);

                    if (origenBase)
                    {
                        var listaEstrategiaBase = GetOfertas(usuario);
                        oddSession.ListaOferta = _ofertaPersonalizada.ConsultarEstrategiasModelFormato(listaEstrategiaBase, usuario.CodigoISO, usuario.CampaniaID, 2, usuario.esConsultoraLider, usuario.Simbolo);
                        AsignarPrimeraOferta(ref oddSession, usuario);
                    }


                    return oddSession;
                }                
                

                oddSession = new DataModel();
                oddSession.TieneOfertaDelDia = true;                

                var personalizacionesOdd = _tablaLogica.GetTablaLogicaDatos(usuario.PaisID, Constantes.TablaLogica.PersonalizacionODD);
                if (!personalizacionesOdd.Any())
                {
                    oddSession.TieneOfertaDelDia = false;
                    oddSession.ListaOferta = new List<EstrategiaPersonalizadaProductoModel>();
                }

                var listaEstrategia = GetOfertas(usuario);
                oddSession.ListaOferta = _ofertaPersonalizada.ConsultarEstrategiasModelFormato(listaEstrategia, usuario.CodigoISO, usuario.CampaniaID, 2, usuario.esConsultoraLider, usuario.Simbolo);

                if (!oddSession.ListaOferta.Any())
                {
                    oddSession.TieneOfertaDelDia = false;
                    oddSession.ListaOferta = new List<EstrategiaPersonalizadaProductoModel>();
                }

                if (!oddSession.TieneOfertaDelDia)
                {
                    sessionManager.OfertaDelDia.Estrategia = oddSession;
                    return oddSession;
                }                

                oddSession.TieneOfertas = oddSession.ListaOferta.Any();
                oddSession.TextoVerDetalle = oddSession.ListaOferta.Any() ? oddSession.ListaOferta.Count > 1 ? "VER MÁS OFERTAS" : "VER OFERTA" : "";

                var colorFondoBanner = personalizacionesOdd.FirstOrDefault(x => x.TablaLogicaDatosID == Constantes.TablaLogicaDato.PersonalizacionOdd.ColorFondoBanner) ?? new TablaLogicaDatosModel();
                var coloFondoDisplay = personalizacionesOdd.FirstOrDefault(x => x.TablaLogicaDatosID == Constantes.TablaLogicaDato.PersonalizacionOdd.ColorFondoDisplay) ?? new TablaLogicaDatosModel();

                oddSession.TeQuedan = CountdownOdd(usuario);

                oddSession.ColorFondo1 = colorFondoBanner.Codigo ?? string.Empty;
                oddSession.ColorFondo2 = coloFondoDisplay.Codigo ?? string.Empty;
                oddSession.ImagenSoloHoy = ObtenerUrlImagenOfertaDelDia(usuario.CodigoISO, oddSession.ListaOferta.Count);

                AsignarPrimeraOferta(ref oddSession, usuario);

            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, usuario.CodigoConsultora, usuario.CodigoISO);
                oddSession = new DataModel();
            }
            sessionManager.OfertaDelDia.Estrategia = oddSession;
            return oddSession;
        }

        private void AsignarPrimeraOferta(ref DataModel oddSession, UsuarioModel usuario)
        {
            var primeraOferta = oddSession.ListaOferta.FirstOrDefault();
            oddSession.EstrategiaID = primeraOferta.EstrategiaID;
            oddSession.ImagenBanner = primeraOferta.FotoProducto01;
            oddSession.NombreOferta = ObtenerNombreOfertaDelDia(primeraOferta.DescripcionCompleta);
            oddSession.PrecioOfertaFormat = Util.DecimalToStringFormat(primeraOferta.Precio2, usuario.CodigoISO);
        }

        public bool MostrarOfertaDelDia(UsuarioModel usuario)
        {
            var ofertaDelDiaConfi = GetOfertaDelDiaConfiguracion(usuario);
            return !(usuario.IndicadorGPRSB == 1 || usuario.CloseOfertaDelDia)
                            && ofertaDelDiaConfi.TieneOfertaDelDia
                            && ofertaDelDiaConfi.TeQuedan.TotalSeconds > 0;
        }

        public bool CumpleOfertaDelDia(UsuarioModel usuario, string controlador)
        {
            var result = false;

            if (!NoMostrarBannerODD(controlador))
            {
                var tieneOfertaDelDia = sessionManager.OfertaDelDia.Estrategia.TieneOfertaDelDia;
                result = (!tieneOfertaDelDia ||
                          (!usuario.ValidacionAbierta && usuario.EstadoPedido == 202 && usuario.IndicadorGPRSB == 2 || usuario.IndicadorGPRSB == 0)
                          ) && tieneOfertaDelDia;
            }

            return result;
        }

        public bool MostrarBannerSuperiorOdd(UsuarioModel usuario, string controlador)
        {
            var result = false;

            if (!NoMostrarBannerODD(controlador))
            {
                var tieneOfertaDelDia = sessionManager.OfertaDelDia.Estrategia.TieneOfertaDelDia;
                result = (!tieneOfertaDelDia ||
                          (!usuario.ValidacionAbierta && usuario.EstadoPedido == 202 && usuario.IndicadorGPRSB == 2 || usuario.IndicadorGPRSB == 0)
                          && !usuario.CloseOfertaDelDia) && tieneOfertaDelDia;
            }

            return result;
        }

        private bool GetValidarDiasAntesStock(UsuarioModel userData)
        {
            var validar = false;
            var lstTablaLogicaDatos = _tablaLogicaProvider.GetTablaLogicaDatos(userData.PaisID, Constantes.TablaLogica.StockDiasAntes, true);
            if (lstTablaLogicaDatos.Any())
            {
                var diasAntesStock = lstTablaLogicaDatos.FirstOrDefault().Valor;
                if (!string.IsNullOrEmpty(diasAntesStock))
                {
                    var iDiasAntesStock = int.Parse(diasAntesStock);
                    if (DateTime.Now.Date >= userData.FechaInicioCampania.AddDays(iDiasAntesStock))
                    {
                        validar = true;
                    }
                }
            }
            return validar;
        }
    }
}