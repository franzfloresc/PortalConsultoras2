using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServiceUsuario;
using Portal.Consultoras.Web.ServiceZonificacion;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.ServiceModel;
using System.Web;
using System.Web.Configuration;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class BienvenidaController : BaseController
    {
        public ActionResult Index()
        {
            //SessionKeys.ClearSessionResumenCampania();
            BEUsuario beusuario = new BEUsuario();
            BEPedidoWeb bePedidoWeb = new BEPedidoWeb();
            var model = new BienvenidaHomeModel();
            try
            {
                /* RQ 2532 EG */
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    bePedidoWeb = sv.GetPedidoWebByCampaniaConsultora(userData.PaisID, userData.CampaniaID, userData.ConsultoraID);
                    model.ListaEscalaDescuento = sv.GetEscalaDescuento(userData.PaisID).ToList() ?? new List<BEEscalaDescuento>();
                }

                int montoEscalaDescuento = 0;
                model.MontoAhorroCatalogo = 0;
                model.MontoAhorroRevista = 0;

                if (bePedidoWeb != null)
                {
                    model.MontoAhorroCatalogo = bePedidoWeb.MontoAhorroCatalogo; 
                    model.MontoAhorroRevista = bePedidoWeb.MontoAhorroRevista;
                    montoEscalaDescuento = Convert.ToInt32(bePedidoWeb.MontoEscala);
                }

                #region Rangos de Escala de Descuento

                var pos = -1;
                int nro = 4;
                var listaEscala = new List<BEEscalaDescuento>();
                var tamano = model.ListaEscalaDescuento.Count;

                for (int i = 0; i < tamano; i++)
                {
                    model.ListaEscalaDescuento[i].MontoDesde = i == 0 ? userData.MontoMinimo : model.ListaEscalaDescuento[i - 1].MontoHasta;

                    var objEscala = model.ListaEscalaDescuento[i];
                    if (objEscala.MontoDesde <= montoEscalaDescuento && montoEscalaDescuento < objEscala.MontoHasta)
                    {
                        model.ListaEscalaDescuento[i].Seleccionado = true;
                        pos = i;
                    }

                    if (i < nro)
                    {
                        listaEscala.Add(model.ListaEscalaDescuento[i]);
                    }
                }

                if (model.ListaEscalaDescuento.Count(x => x.Seleccionado) <= 1)
                {
                    if (model.ListaEscalaDescuento.Count(x => x.Seleccionado) == 1)
                    {
                        listaEscala = new List<BEEscalaDescuento>();

                        int posMin, posMax, tamX = tamano - 1;
                        posMax = tamX >= pos + nro - 1 ? (pos + nro - 1) : tamX;
                        posMin = posMax > (nro - 1) ? (posMax - (nro - 1)) : 0;

                        for (int i = posMin; i <= posMax; i++)
                        {
                            listaEscala.Add(model.ListaEscalaDescuento[i]);
                        }
                    }
                }
                model.ListaEscalaDescuento = listaEscala;
                #endregion Rangos de Escala de Descuento

                /* 1992 - Inicio */
                var datDescBoton = new List<BETablaLogicaDatos>();
                var datUrlBoton = new List<BETablaLogicaDatos>();
                var datGaBoton = new List<BETablaLogicaDatos>();
                var configCarouselLiquidacion = new List<BETablaLogicaDatos>();
                using (SACServiceClient sv = new SACServiceClient())
                {
                    datDescBoton = sv.GetTablaLogicaDatos(userData.PaisID, 48).ToList();
                    datUrlBoton = sv.GetTablaLogicaDatos(userData.PaisID, 49).ToList();
                    datGaBoton = sv.GetTablaLogicaDatos(userData.PaisID, 50).ToList();
                    configCarouselLiquidacion = sv.GetTablaLogicaDatos(userData.PaisID, 87).ToList();
                }
                /* 1992 - Fin */

                model.NombreCompleto = userData.NombreConsultora;
                model.EMail = userData.EMail;
                model.Telefono = userData.Telefono;
                model.Celular = userData.Celular;
                
                string carpetaPais = WebConfigurationManager.AppSettings["CarpetaImagenCompartirCatalogo"] + userData.CodigoISO;
                string nombreImagenCatalogo = WebConfigurationManager.AppSettings["NombreImagenCompartirCatalogo"];

                Session["PaisID"] = userData.PaisID;
                model.UrlImagenCompartirCatalogo = ConfigS3.GetUrlFileS3(carpetaPais,nombreImagenCatalogo, String.Empty);
                model.PrimeraVez = userData.CambioClave;
                model.Simbolo = userData.Simbolo;
                model.NombreConsultora = (string.IsNullOrEmpty(userData.Sobrenombre) ? userData.NombreConsultora : userData.Sobrenombre);
                model.PaisID = userData.PaisID;
                model.IndicadorContrato = userData.IndicadorContrato;
                model.CambioClave = userData.CambioClave;
                model.SobreNombre = string.IsNullOrEmpty(userData.Sobrenombre) ? userData.NombreConsultora : userData.Sobrenombre;
                model.CodigoConsultora = userData.CodigoConsultora;//1796
                model.CampaniaActual = userData.CampaniaID;//1796
                model.PrefijoPais = userData.CodigoISO;//1796
                model.CampanaInvitada = userData.CampanaInvitada; //1796
                model.InscritaFlexipago = userData.InscritaFlexipago; //1796
                model.InvitacionRechazada = userData.InvitacionRechazada; //1796
                /* 1992 - Inicio */
                model.BotonAction = (datUrlBoton.Count > 0) ? datUrlBoton[0].Descripcion.Split('/')[1].ToString() : "";
                model.CantProductosCarouselLiq = (configCarouselLiquidacion != null && configCarouselLiquidacion.Count > 0) ? Convert.ToInt32(configCarouselLiquidacion[0].Codigo) : 1;
                model.BotonController = (datUrlBoton.Count > 0) ? datUrlBoton[0].Descripcion.Split('/')[0].ToString() : "";
                model.BotonAnalytics = (datGaBoton.Count > 0) ? datGaBoton[0].Descripcion : ""; ;
                /* 1992 - Fin */
                //Inicio RQ2461
                model.UrlFlexipagoCL = ConfigurationManager.AppSettings.Get("rutaFlexipagoCL");
                /*RE2591 - CS(CGI) */
                if (userData.CodigoISO == "CL" || userData.CodigoISO == "CO")
                {
                    var tabla = new List<BETablaLogicaDatos>();
                    using (SACServiceClient sac = new SACServiceClient())
                    {
                        tabla = sac.GetTablaLogicaDatos(userData.PaisID, 60).ToList();
                        model.NroCampana = ((List<BETablaLogicaDatos>)tabla).Find(X => X.TablaLogicaDatosID == 6001).Codigo;

                        /* INICIO CAH - R20150931 */
                        if (userData.CodigoISO == "CL")
                        {
                            model.rutaChile = ConfigurationManager.AppSettings.Get("UrlPagoLineaChile");
                        }
                        else
                        {
                            model.rutaChile = string.Empty;
                        }
                        /* FIN CAH - R20150931 */
                    }
                }
                else
                {
                    model.NroCampana = "2";
                    model.rutaChile = string.Empty; // CAH - R20150931
                }
                //Fin RQ2461

                string nombreArchivoContrato = ConfigurationManager.AppSettings["Contrato_ActualizarDatos_" + userData.CodigoISO].ToString();//25332 EGL
                model.ContratoActualizarDatos = nombreArchivoContrato;//2532 EGL


                /* 2012 - Inicio */
                var parametro = userData.CodigoConsultora + "|" + DateTime.Now.ToShortDateString() + " 23:59:59" + "|" + userData.CodigoISO;
                var urlChile = Util.EncriptarQueryString(parametro);
                model.UrlChileEncriptada = urlChile;
                /* 2012 - Fin */

                if (Session["PrimeraVezSession"] != null && (int)Session["PrimeraVezSession"] == 0)
                {
                    model.PrimeraVezSession = 0;
                    Session["PrimeraVezSession"] = null;
                }
                else
                {
                    model.PrimeraVezSession = 1;
                }
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            if (userData.RolID == Constantes.Rol.Consultora)
            {
                return View("Index", model);
            }

            return View("IndexSAC", model);
        }

        /// <summary>
        /// GR-1125  Se obtienen los comunicados para mostrarlos en popUps a demanda.
        /// </summary>
        /// <returns></returns>
        public JsonResult ObtenerComunicadosPopUps()
        {
            int ComunicadoVisualizado = 0;
            List<BEComunicado> comunicados = new List<BEComunicado>();

            using (ServiceSAC.SACServiceClient sac = new ServiceSAC.SACServiceClient())
            {
                comunicados = sac.ObtenerComunicadoPorConsultora(UserData().PaisID, UserData().CodigoConsultora).ToList();

                if (comunicados != null)
                    ComunicadoVisualizado = 1;
            }

            ViewBag.VisualizoComunicadoConfigurable = ComunicadoVisualizado;

            return Json(new
            {
                success = true,
                data = comunicados.Where(c => String.IsNullOrEmpty(c.CodigoCampania) || Convert.ToInt32(c.CodigoCampania) == UserData().CampaniaID),
                codigoISO = UserData().CodigoISO,
                codigoCampania = UserData().CampaniaID,
                codigoConsultora = UserData().CodigoConsultora,
                comunicadoVisualizado = ComunicadoVisualizado,
                ipUsuario = UserData().IPUsuario
            },
            JsonRequestBehavior.AllowGet);
        }


        /* 1987 - inicio */

        public ActionResult ReporteSueniosNavidad()
        {
            if (!UsuarioModel.HasAcces(ViewBag.Permiso, "Bienvenida/ReporteSueniosNavidad"))
                return RedirectToAction("Index", "Bienvenida");

            var parametrizarCUVModel = new ParametrizarCUVModel()
            {
                listaCampania = new List<CampaniaModel>(),
                listaZonas = new List<ZonaModel>(),
                listaPaises = DropDowListPaises()
            };

            return View(parametrizarCUVModel);
        }

        private IEnumerable<PaisModel> DropDowListPaises()
        {
            List<BEPais> lst;
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                if (UserData().RolID == 2) lst = sv.SelectPaises().ToList();
                else
                {
                    lst = new List<BEPais>();
                    lst.Add(sv.SelectPais(UserData().PaisID));
                }
            }
            Mapper.CreateMap<BEPais, PaisModel>()
                    .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                    .ForMember(t => t.Nombre, f => f.MapFrom(c => c.Nombre))
                    .ForMember(t => t.NombreCorto, f => f.MapFrom(c => c.NombreCorto));

            return Mapper.Map<IList<BEPais>, IEnumerable<PaisModel>>(lst);
        }

        public ActionResult Consultar(string sidx, string sord, int page, int rows, string CampaniaID, string PaisID, string Consulta, string CodigoConsultora)
        {
            if (ModelState.IsValid)
            {
                List<BESuenioNavidad> lst;

                if (Consulta == "1")
                {
                    var entidad = new BESuenioNavidad();
                    entidad.PaisID = UserData().PaisID;
                    entidad.CampaniaID = Convert.ToInt32(CampaniaID);
                    entidad.CodigoConsultora = CodigoConsultora;

                    using (PedidoServiceClient sv = new PedidoServiceClient())
                    {
                        lst = sv.ListarSuenioNavidad(entidad).ToList();
                    }
                }
                else
                {
                    lst = new List<BESuenioNavidad>();
                }

                // Usamos el modelo para obtener los datos
                BEGrid grid = new BEGrid();
                grid.PageSize = rows;
                grid.CurrentPage = page;
                grid.SortColumn = sidx;
                grid.SortOrder = sord;
                //int buscar = int.Parse(txtBuscar);
                BEPager pag = new BEPager();
                IEnumerable<BESuenioNavidad> items = lst;

                #region Sort Section
                if (sord == "asc")
                {
                    switch (sidx)
                    {
                        case "CampaniaID":
                            items = lst.OrderBy(x => x.CampaniaID);
                            break;

                        case "Region":
                            items = lst.OrderBy(x => x.Region);
                            break;

                        case "Zona":
                            items = lst.OrderBy(x => x.Zona);
                            break;

                        case "Seccion":
                            items = lst.OrderBy(x => x.Seccion);
                            break;

                        case "CodigoConsultora":
                            items = lst.OrderBy(x => x.CodigoConsultora);
                            break;

                        case "Canal":
                            items = lst.OrderBy(x => x.Canal);
                            break;
                    }
                }
                else
                {
                    switch (sidx)
                    {
                        case "CampaniaID":
                            items = lst.OrderByDescending(x => x.CampaniaID);
                            break;

                        case "Region":
                            items = lst.OrderByDescending(x => x.Region);
                            break;

                        case "Zona":
                            items = lst.OrderByDescending(x => x.Zona);
                            break;

                        case "Seccion":
                            items = lst.OrderByDescending(x => x.Seccion);
                            break;

                        case "CodigoConsultora":
                            items = lst.OrderByDescending(x => x.CodigoConsultora);
                            break;

                        case "Canal":
                            items = lst.OrderByDescending(x => x.Canal);
                            break;
                    }
                }
                #endregion

                items = items.ToList().Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                pag = Util.PaginadorGenerico(grid, lst);

                // Creamos la estructura
                var data = new
                {
                    total = pag.PageCount,
                    page = pag.CurrentPage,
                    records = pag.RecordCount,
                    rows = from a in items
                           select new
                           {
                               a.CampaniaID,
                               cell = new string[]
                               {
                                   a.CampaniaID.ToString(),
                                   a.Region,
                                   a.Zona,
                                   a.Seccion,
                                   a.CodigoConsultora,
                                   a.NombreCompleto,
                                   (QuitarSaltos(a.Descripcion).Length > 100) ? QuitarSaltos(a.Descripcion).Substring(0, 100) : QuitarSaltos(a.Descripcion), // 2287
                                   QuitarSaltos(a.Descripcion), // 2287
                                   a.Canal
                               }
                           }
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            return RedirectToAction("ReporteSueniosNavidad", "Bienvenida");
        }

        /* 1987 - fin */

        /* 1987 - Inicio */

        [OutputCache(NoStore = true, Duration = 0, VaryByParam = "*")]
        private int ValidarSuenioNavidad()
        {
            int validacion;
            var entidad = new BESuenioNavidad();
            entidad.PaisID = UserData().PaisID;
            entidad.ConsultoraID = Convert.ToInt32(UserData().ConsultoraID);
            entidad.CampaniaID = UserData().CampaniaID;

            if (entidad.ConsultoraID == 0)
            {
                validacion = 1;
                return validacion;
            }

            if (Session["SuenioNavidad"] == null)
            {
                using (PedidoServiceClient svc = new PedidoServiceClient())
                {
                    validacion = svc.ValidarSuenioNavidad(entidad);
                }
                Session["SuenioNavidad"] = validacion;
            }
            else
            {
                validacion = 1;
            }

            return validacion;
        }

        /* 1987 - Fin */

        public string Version()
        {
            return "4.0";
        }

        public JsonResult AceptarContrato(bool checkAceptar)
        {
            try
            {
                if (checkAceptar == false)
                {
                    return Json(new
                    {
                        success = false,
                        message = "Debe marcar la aceptación del contrato.",
                        extra = ""
                    });
                }
                else
                {
                    int resultado;
                    using (UsuarioServiceClient svr = new UsuarioServiceClient())
                    {
                        resultado = svr.AceptarContratoAceptacion(UserData().PaisID, UserData().ConsultoraID, UserData().CodigoConsultora);
                    }

                    UserData().IndicadorContrato = 1;

                    string cadena = "<br /><br /> Por la presente se le comunica que usted ha indicado estar de acuerdo con el contrato. Se adjunta una copia del contrato firmado.";

                    string correoDestino = string.Empty;
                    if (UserData().EMail.Length > 0)
                    {
                        correoDestino = UserData().EMail;
                    }

                    string filePath = string.Empty;
                    filePath = Server.MapPath("~/Content/FAQ/Contrato_CO.pdf");
                    string indicadorEnvio = ConfigurationManager.AppSettings["indicadorContrato"].ToString();
                    if (indicadorEnvio == "1")
                    {
                        try
                        {
                            Util.EnviarMail3("no-responder@somosbelcorp.com", correoDestino, "Usted ha firmado el contrato con SomosBelcorp", cadena, true, string.Empty, filePath, UserData().NombreConsultora);
                        }
                        catch (Exception)
                        {
                            return Json(new
                            {
                                success = false,
                                message = "Se acepto el contrato pero no se pudo enviar correo electrónico.",
                                extra = "nocorreo"
                            });
                        }
                    }

                    return Json(new
                    {
                        success = true,
                        message = "Se Acepto la contrata",
                        extra = ""
                    });
                }
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Hubo un problema con el servicio, intente nuevamente",
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Hubo un problema con el servicio, intente nuevamente",
                    extra = ""
                });
            }
        }

        public JsonResult RegistrarDonacionConsultora(string CodigoISO, string CodigoConsultora, string Campania, int ComunicadoID)
        {
            try
            {
                using (ServiceSAC.SACServiceClient sac = new ServiceSAC.SACServiceClient())
                {
                    sac.InsertarDonacionConsultora(UserData().PaisID, CodigoISO, UserData().CodigoConsultora, Campania, UserData().IPUsuario);
                    sac.InsertarComunicadoVisualizado(UserData().PaisID, UserData().CodigoConsultora, ComunicadoID);
                }
                string mensaje = string.Format("¡Gracias por ayudar a la familia Ésika a reconstruir su vida! Tu donación será cargada a tu estado de cuenta de pedido de campaña {0}", Campania.Substring(4));

                return Json(new
                {
                    success = true,
                    message = mensaje
                });
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Hubo un problema con el servicio, intente nuevamente",
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Hubo un problema con el servicio, intente nuevamente",
                    extra = ""
                });
            }
        }

        /*GR-1209*/
        public JsonResult AceptarComunicadoVisualizacion(int ComunicadoID)
        {
            try
            {
                using (ServiceSAC.SACServiceClient sac = new ServiceSAC.SACServiceClient())
                {
                    sac.InsertarComunicadoVisualizado(UserData().PaisID, UserData().CodigoConsultora, ComunicadoID);
                }
                return Json(new
                {
                    success = true,
                    message = "",
                    extra = ""
                });
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Hubo un problema con el servicio, intente nuevamente",
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Hubo un problema con el servicio, intente nuevamente",
                    extra = ""
                });
            }
        }

        //1796 Inicio
        public ActionResult RedireccionarFlexipago()
        {
            string cc = UserData().CodigoConsultora;//1796
            int ca = UserData().CampaniaID;//1796
            string pp = UserData().CodigoISO;//1796
            string urlRedirect;
            //2461
            if (pp.ToString() == "CL")
            {
                urlRedirect = ConfigurationManager.AppSettings.Get("rutaFlexipagoCL") + "/index.html?PP=" + pp.ToString() + "&CC=" + cc.ToString() + "&CA=" + ca.ToString();
            }
            else
            {
                urlRedirect = "http://FLEXIPAGO.SOMOSBELCORP.COM/FlexipagoCO/index.html?PP=" + pp.ToString() + "&CC=" + cc.ToString() + "&CA=" + ca.ToString();
            }

            return Redirect(urlRedirect);
        }

        public ActionResult RechazarInvitacionFlex()
        {
            string cc = UserData().CodigoConsultora;//1796
            int ca = UserData().CampaniaID;//1796
            string pp = UserData().CodigoISO;//1796
            string urlRedirect = "http://FLEXIPAGO.SOMOSBELCORP.COM/FlexipagoCO/index.html?PP=" + pp.ToString() + "&CC=" + cc.ToString() + "&CA=" + ca.ToString();
            return Redirect(urlRedirect);
        }
        //1796 Fin

        // 1987 - Inicio
        public JsonResult RegistrarSuenioNavidad(string descripcion)
        {
            try
            {
                var entidad = new BESuenioNavidad();
                entidad.PaisID = UserData().PaisID;
                entidad.CampaniaID = UserData().CampaniaID;
                entidad.ConsultoraID = Convert.ToInt32(UserData().ConsultoraID);
                entidad.Descripcion = descripcion;
                entidad.Canal = "C";
                entidad.UsuarioCreacion = UserData().CodigoUsuario;

                using (PedidoServiceClient svc = new PedidoServiceClient())
                {
                    svc.RegistrarSuenioNavidad(entidad);
                }

                return Json(new
                {
                    success = true,
                    message = "Se registró el sueño de manera correcta.",
                    extra = ""
                });
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Hubo un problema con el servicio, intente nuevamente",
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Hubo un problema con el servicio, intente nuevamente",
                    extra = ""
                });
            }
        }
        // 1987 - Fin
        /*2116- inicio*/
        private int ValidarTiempo()
        {
            int validacion;

            using (UsuarioServiceClient sv = new UsuarioServiceClient())
            {
                validacion = sv.SelectTiempo(UserData().PaisID);
            }
            return validacion;
        }

        private int ValidarSegmento()
        {
            int validacion;

            using (UsuarioServiceClient sv = new UsuarioServiceClient())
            {
                validacion = sv.SelectSegmento(UserData().PaisID, UserData().SegmentoID);
            }
            return validacion;
        }

        private int ValidaDatosActualizados()
        {
            int validacion;

            using (UsuarioServiceClient sv = new UsuarioServiceClient())
            {
                validacion = sv.SelectDatosActualizados(UserData().PaisID, UserData().CodigoUsuario);
            }
            return validacion;
        }

        /*2116- fin*/
        /* 2287 - Inicio */

        public ActionResult ExportarExcelSueniosNavidad(int campaniaID, string codigoConsultora)
        {
            List<BESuenioNavidad> lst;
            var entidad = new BESuenioNavidad();
            entidad.PaisID = UserData().PaisID;
            entidad.CampaniaID = campaniaID;
            entidad.CodigoConsultora = codigoConsultora;

            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                lst = sv.ListarSuenioNavidad(entidad).ToList();
            }

            Dictionary<string, string> dic = new Dictionary<string, string>();
            dic.Add("Campaña", "CampaniaID");
            dic.Add("Región", "Region");
            dic.Add("Zona", "Zona");
            dic.Add("Sección", "Seccion");
            dic.Add("Código de Consultora", "CodigoConsultora");
            dic.Add("Nombre y Apellidos", "NombreCompleto");
            dic.Add("Descripción del sueño", "Descripcion");
            dic.Add("Canal", "Canal");

            Util.ExportToExcel("SueniosDeNavidad", lst, dic);
            return View();
        }

        public string QuitarSaltos(string valor)
        {
            return valor.Replace("\n", string.Empty).Replace("\"", string.Empty);
        }

        /* 2287 - Fin */

        /*Inicio Cambios_Landing_Comunidad*/

        public ActionResult Landing()
        {
            string nombreArchivoContrato = ConfigurationManager.AppSettings["Contrato_ActualizarDatos_" + UserData().CodigoISO].ToString(); //2532 EGL
            ViewBag.ContratoActualizarDatos = nombreArchivoContrato; //2532 EGL

            var newModel = new BienvenidosModel();

            var lst = new List<ServiceContenido.BEItemCarruselInicio>();
            var paisID = UserData().PaisID;
            using (ServiceContenido.ContenidoServiceClient sv = new ServiceContenido.ContenidoServiceClient())
            {
                lst = sv.GetItemCarruselInicio(paisID).ToList();
            }

            Mapper.CreateMap<ServiceContenido.BEItemCarruselInicio, ItemCarruselInicioModel>();
            newModel.ItemsCarruselInicio = Mapper.Map<List<ItemCarruselInicioModel>>(lst);

            BEUsuario beusuario = new BEUsuario();
            var actualizarDatos = new ActualizarDatosModel();
            try
            {
                using (UsuarioServiceClient sv = new UsuarioServiceClient())
                {
                    beusuario = sv.Select(UserData().PaisID, UserData().CodigoUsuario);
                }

                if (beusuario != null)
                {
                    actualizarDatos.NombreCompleto = beusuario.Nombre;
                    actualizarDatos.EMail = beusuario.EMail;
                    actualizarDatos.Telefono = beusuario.Telefono;
                    actualizarDatos.Celular = beusuario.Celular;
                    newModel.ActualizarDatos = actualizarDatos;
                }
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
            }

            return View(newModel);
        }

        [HttpPost]
        public JsonResult ValidarCorreoComunidad(string correo)
        {
            try
            {
                bool result = false;
                using (ServiceComunidad.ComunidadServiceClient sv = new ServiceComunidad.ComunidadServiceClient())
                {
                    result = sv.GetUsuarioByCorreo(new ServiceComunidad.BEUsuarioComunidad()
                    {
                        Correo = correo,
                    });
                }
                if (result)
                {
                    ServiceComunidad.BEUsuarioComunidad oBEUsuarioComunidad = null;
                    using (ServiceComunidad.ComunidadServiceClient sv = new ServiceComunidad.ComunidadServiceClient())
                    {
                        oBEUsuarioComunidad = sv.GetUsuarioInformacion(new ServiceComunidad.BEUsuarioComunidad()
                        {
                            UsuarioId = 0,
                            CodigoUsuario = correo,
                            Tipo = 4,
                            PaisId = UserData().PaisID
                        });
                    }

                    if (oBEUsuarioComunidad != null)
                    {
                        string[] parametros = new string[] { oBEUsuarioComunidad.UsuarioId.ToString(), "1", UserData().PaisID.ToString(), UserData().CodigoUsuario, UserData().CodigoConsultora };
                        string param_querystring = Util.EncriptarQueryString(parametros);
                        HttpRequestBase request = this.HttpContext.Request;
                        string pagina_confirmacion = Util.GetUrlHost(request) + "WebPages/ConfirmacionRegistroComunidad.aspx?data=" + param_querystring;

                        System.Text.StringBuilder sb = new System.Text.StringBuilder();
                        sb.Append("<html><head><title>Verificar Correo</title><meta http-equiv='Content-Type' content='text/html; charset=utf-8'>");
                        sb.Append("<script type='text/javascript'>function MM_swapImgRestore() { var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;}");
                        sb.Append("function MM_preloadImages() { var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array(); var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++) if (a[i].indexOf('#')!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}}");
                        sb.Append("function MM_findObj(n, d) { var p,i,x;  if(!d) d=document; if((p=n.indexOf('?'))>0&&parent.frames.length) { d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);} if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n]; for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document); if(!x && d.getElementById) x=d.getElementById(n); return x;}");
                        sb.Append("function MM_swapImage() { var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3) if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];} } </script></head>");
                        sb.Append("<body bgcolor='#FFFFFF' leftmargin='0' topmargin='0' marginwidth='0' marginheight='0' onLoad=\"MM_preloadImages('https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/Comunidad/hazclick_on.png')\">");
                        sb.Append("<table width='800' height='521' border='0' align='center' cellpadding='0' cellspacing='0' id='Table_01'>");
                        sb.Append("<tr>");
                        sb.Append("<td width='17px' bgcolor='#F6F6F6'></td>");
                        sb.Append("<td width='766px'><table id='Table_' width='766' height='521' border='0' cellpadding='0' cellspacing='0'>");
                        sb.Append("<tr>");
                        sb.Append("<td width='766' height='22' bgcolor='#F6F6F6'></td>");
                        sb.Append("</tr>");
                        sb.Append("<tr>");
                        sb.Append("<td width='766' height='419'><table id='Table_2' width='766' height='419' border='0' cellpadding='0' cellspacing='0'>");
                        sb.Append("<tr>");
                        sb.Append("<td width='198'><table id='Table_4' width='198' height='419' border='0' cellpadding='0' cellspacing='0'>");
                        sb.Append("<tr>");
                        sb.Append("<td width='198' height='119'><img src='https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/Comunidad/mail_menulat_01.gif' width='198' height='119' alt=''></td>");
                        sb.Append("</tr>");
                        sb.Append("<tr>");
                        sb.Append("<td width='198' height='73'><img src='https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/Comunidad/mail_menulat_02.gif' width='198' height='73' alt=''></td>");
                        sb.Append("</tr>");
                        sb.Append("<tr>");
                        sb.Append("<td width='198' height='139'><table id='Table_5' width='198' height='139' border='0' cellpadding='0' cellspacing='0'>");
                        sb.Append("<tr>");
                        sb.Append("<td width='18'></td>");
                        sb.Append("<td width='180'><table id='Table_6' width='180' height='139' border='0' cellpadding='0' cellspacing='0'>");
                        sb.Append("<tr>");
                        sb.Append("<td><table width='180' border='0' cellspacing='0' cellpadding='0'>");
                        sb.Append("<tr>");
                        sb.Append("<td width='20' height='28'><img src='https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/Comunidad/ico_com.gif' width='20' height='20'></td>");
                        sb.Append("<td width='5'></td>");
                        sb.Append("<td width='155'><font face='Arial,sans-serif' style='font-family: Arial,sans-serif; font-size: 9.5px; text-transform: uppercase;'><a href='#'><font color='#b03695'><span style='text-decoration:none;text-underline:none'>Bienvenida a tu comunidad</span></font></a></font></td>");
                        sb.Append("</tr>");
                        sb.Append("</table></td>");
                        sb.Append("</tr>");
                        sb.Append("<tr>");
                        sb.Append("<td><table width='180' border='0' cellspacing='0' cellpadding='0'>");
                        sb.Append("<tr>");
                        sb.Append("<td width='20' height='28'><img src='https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/Comunidad/ico_logra.gif' width='20' height='20'></td>");
                        sb.Append("<td width='5'></td>");
                        sb.Append("<td width='155'><font face='Arial,sans-serif' style='font-family: Arial,sans-serif; font-size: 9.5px; text-transform: uppercase;'><a href='#'><font color='#569898'><span style='text-decoration:none;text-underline:none'>Logra con tu belleza</span></font></a></font></td>");
                        sb.Append("</tr>");
                        sb.Append("</table></td>");
                        sb.Append("</tr>");
                        sb.Append("<tr>");
                        sb.Append("<td><table width='180' border='0' cellspacing='0' cellpadding='0'>");
                        sb.Append("<tr>");
                        sb.Append("<td width='20' height='28'><img src='https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/Comunidad/ico_neg.gif' width='20' height='20'></td>");
                        sb.Append("<td width='5'></td>");
                        sb.Append("<td width='155'><font face='Arial,sans-serif' style='font-family: Arial,sans-serif; font-size: 9.5px; text-transform: uppercase;'><a href='#'><font color='#a8cb30'><span style='text-decoration:none;text-underline:none'>Tu negocio</span></font></a></font></td>");
                        sb.Append("</tr>");
                        sb.Append("</table></td>");
                        sb.Append("</tr>");
                        sb.Append("<tr>");
                        sb.Append("<td><table width='180' border='0' cellspacing='0' cellpadding='0'>");
                        sb.Append("<tr>");
                        sb.Append("<td width='20' height='28'><img src='https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/Comunidad/ico_tusmarcas.gif' width='20' height='20'></td>");
                        sb.Append("<td width='5'></td>");
                        sb.Append("<td width='155'><font face='Arial,sans-serif' style='font-family: Arial,sans-serif; font-size: 9.5px; text-transform: uppercase;'><a href='#'><font color='#570064'><span style='text-decoration:none;text-underline:none'>Tus marcas y tus productos</span></font></a></font></td>");
                        sb.Append("</tr>");
                        sb.Append("</table></td>");
                        sb.Append("</tr>");
                        sb.Append("<tr>");
                        sb.Append("<td><table width='180' border='0' cellspacing='0' cellpadding='0'>");
                        sb.Append("<tr>");
                        sb.Append("<td width='20' height='27'><img src='https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/Comunidad/ico_cosas.gif' width='20' height='20'></td>");
                        sb.Append("<td width='5'></td>");
                        sb.Append("<td width='155' height='27'><font face='Arial,sans-serif' style='font-family: Arial,sans-serif; font-size: 9.5px; text-transform: uppercase;'><a href='#'><font color='#666696'><span style='text-decoration:none;text-underline:none'>Cosas de mujeres</span></font></a></font></td>");
                        sb.Append("</tr>");
                        sb.Append("</table></td>");
                        sb.Append("</tr>");
                        sb.Append("</table></td>");
                        sb.Append("</tr>");
                        sb.Append("</table></td>");
                        sb.Append("</tr>");
                        sb.Append("<tr>");
                        sb.Append("<td width='198'></td>");
                        sb.Append("</tr>");
                        sb.Append("</table></td>");
                        sb.Append("<td width='568'><table id='Table_3' width='568' height='419' border='0' cellpadding='0' cellspacing='0'>");
                        sb.Append("<tr>");
                        sb.Append(string.Format("<td width='568' height='197'><a href='{0}'><img src='https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/Comunidad/mail_derecho_01.jpg' width='568' height='197'></a></td>", pagina_confirmacion));
                        sb.Append("</tr>");
                        sb.Append("<tr>");
                        sb.Append("<td width='568' height='222' background='https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/Comunidad/bgmail01.jpg'><table width='568' border='0' cellspacing='0' cellpadding='0'>");
                        sb.Append("<tr>");
                        sb.Append("<td height='106'><table width='568' border='0' cellspacing='0' cellpadding='0'>");
                        sb.Append("<tr>");
                        sb.Append("<td width='31' height='106'>&nbsp;</td>");
                        sb.Append("<td width='466'><font face='Arial,sans-serif' style='font-family: Arial,sans-serif; font-size: 14px; color:#425363; line-height:1.2;'>¡Felicidades! ¡Ya eres Consultora Belcorp! De ahora en adelante, para llegar a tu comunidad tendrás que ingresar siempre a través de tu cuenta de Somos Belcorp(*).</font></td>");
                        sb.Append("<td>&nbsp;</td>");
                        sb.Append("</tr>");
                        sb.Append("</table></td>");
                        sb.Append("</tr>");
                        sb.Append("<tr>");
                        sb.Append("<td height='90'><table width='568' border='0' cellspacing='0' cellpadding='0'>");
                        sb.Append("<tr>");
                        sb.Append("<td width='31' height='90'>&nbsp;</td>");
                        sb.Append("<td width='412'><font face='Arial,sans-serif' style='font-family: Arial,sans-serif; font-size: 14px; color:#660066;line-height:1.2;'>Aprovecha al máximo tu comunidad</font><br>");
                        sb.Append("<font face='Arial,sans-serif' style='font-family: Arial,sans-serif; font-size: 14px; color:#425363; line-height:1.2;'>En la sección “Mi negocio” encontrarás todos los tips que <br>");
                        sb.Append("necesitas para hacer crecer tu negocio.</font></td>");
                        sb.Append("<td width='125'>&nbsp;</td>");
                        sb.Append("</tr>");
                        sb.Append("</table></td>");
                        sb.Append("</tr>");
                        sb.Append("<tr>");
                        sb.Append("<td height='26'>&nbsp;</td>");
                        sb.Append("</tr>");
                        sb.Append("</table></td>");
                        sb.Append("</tr>");
                        sb.Append("</table></td>");
                        sb.Append("</tr>");
                        sb.Append("</table></td>");
                        sb.Append("</tr>");
                        sb.Append("<tr>");
                        sb.Append("<td width='766' height='29' bgcolor='#768591'><table id='Table_7' width='766' height='29' border='0' cellpadding='0' cellspacing='0'>");
                        sb.Append("<tr>");
                        sb.Append("<td width='581' height='29'></td>");
                        sb.Append("<td width='91'><font face='Arial,sans-serif' style='font-family: Arial,sans-serif; font-size: 11px; color:#FFF; text-transform: uppercase;'>Siguenos en:</font></td>");
                        sb.Append("<td width='24'><a href='https://www.facebook.com/SomosBelcorpOficial?fref=ts' target='_blank'><img src='https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/Comunidad/socialbar_03.gif' width='24' height='29' alt=''></a></td>");
                        sb.Append("<td width='3'></td>");
                        sb.Append("<td width='23'><a href='https://www.youtube.com/user/somosbelcorp' target='_blank'><img src='https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/Comunidad/socialbar_05.gif' width='23' height='29' alt=''></a></td>");
                        sb.Append("<td width='44'></td>");
                        sb.Append("</tr>");
                        sb.Append("</table></td>");
                        sb.Append("</tr>");
                        sb.Append("<tr>");
                        sb.Append("<td height='51' bgcolor='#F6F6F6'><table width='766' border='0' cellspacing='0' cellpadding='0'>");
                        sb.Append("<tr>");
                        sb.Append("<td height='51'><table id='Table_8' width='766' height='51' border='0' cellpadding='0' cellspacing='0'>");
                        sb.Append("<tr>");
                        sb.Append("<td width='18'></td>");
                        sb.Append("<td width='373'><font face='Arial,sans-serif' style='font-family: Arial,sans-serif; font-size: 11px; color:#768591;'>¿No deseas recibir correos electrónicos de la Comunidad Somos Belcorp?</font></td>");
                        sb.Append("<td width='8'></td>");
                        sb.Append("<td width='101'><a href='#' onMouseOut='MM_swapImgRestore()' onMouseOver=\"MM_swapImage('Haz click','','https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/Comunidad/hazclick_on.png',1)\"><img src='https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/Comunidad/hazclick_off.png' width='101' height='21' id='Haz click'></a></td>");
                        sb.Append("<td width='266'></td>");
                        sb.Append("</tr>");
                        sb.Append("</table></td>");
                        sb.Append("</tr>");
                        sb.Append("</table></td>");
                        sb.Append("</tr>");
                        sb.Append("</table></td>");
                        sb.Append("<td width='17' bgcolor='#F6F6F6'></td>");
                        sb.Append("</tr>");
                        sb.Append("</table></body></html>");

                        Util.EnviarMail("comunidadsomosbelcorp@belcorp.biz", oBEUsuarioComunidad.Correo, "Bienvenida a la Comunidad SomosBelcorp", sb.ToString(), true, "Comunidad SomosBelcorp");

                        using (ServiceComunidad.ComunidadServiceClient sv = new ServiceComunidad.ComunidadServiceClient())
                        {
                            sv.UpdUsuarioCorreoEnviado(new ServiceComunidad.BEUsuarioComunidad()
                            {
                                UsuarioId = oBEUsuarioComunidad.UsuarioId,
                                Tipo = 1
                            });
                        }
                        UserData().EsUsuarioComunidad = true;

                        return Json(new
                        {
                            success = true,
                            message = "¡Tu correo ha sido validado con éxito! Por favor revisa tu correo y sigue los pasos indicados.",
                            extra = ""
                        }, JsonRequestBehavior.AllowGet);
                    }
                    else
                    {
                        return Json(new
                        {
                            success = false,
                            message = "Hubo un problema con el servicio, intente nuevamente",
                            extra = ""
                        }, JsonRequestBehavior.AllowGet);
                    }
                }
                else
                {
                    return Json(new
                    {
                        success = false,
                        message = "El correo electrónico que ingresaste no existe. Por favor, revisa e inténtalo de nuevo, o regístrate como nuevo miembro de la comunidad.",
                        extra = ""
                    }, JsonRequestBehavior.AllowGet);
                }
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Hubo un problema con el servicio, intente nuevamente",
                    extra = ""
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Hubo un problema con el servicio, intente nuevamente",
                    extra = ""
                }, JsonRequestBehavior.AllowGet);
            }
        }

        [HttpPost]
        public JsonResult RegistrarUsuarioComunidad(string usuario, string correo)
        {
            try
            {
                bool valida_usuario = false;
                bool valida_correo = false;

                using (ServiceComunidad.ComunidadServiceClient sv = new ServiceComunidad.ComunidadServiceClient())
                {
                    valida_usuario = sv.GetUsuarioByCodigo(new ServiceComunidad.BEUsuarioComunidad()
                    {
                        CodigoUsuario = usuario,
                    });

                    if (!valida_usuario)
                    {
                        valida_correo = sv.GetUsuarioByCorreo(new ServiceComunidad.BEUsuarioComunidad()
                        {
                            Correo = correo,
                        });
                    }
                }

                if (valida_usuario)
                {
                    return Json(new
                    {
                        success = false,
                        message = "El usuario ingresado ya está siendo usado.",
                        extra = ""
                    }, JsonRequestBehavior.AllowGet);
                }

                if (valida_correo)
                {
                    return Json(new
                    {
                        success = false,
                        message = "El correo ingresado ya está siendo usado.",
                        extra = ""
                    }, JsonRequestBehavior.AllowGet);
                }

                long UniqueId = -1;
                using (ServiceComunidad.ComunidadServiceClient sv = new ServiceComunidad.ComunidadServiceClient())
                {
                    UniqueId = sv.InsUsuarioRegistro(new ServiceComunidad.BEUsuarioComunidad()
                    {
                        CodigoUsuario = usuario,
                        Nombre = UserData().PrimerNombre,
                        Apellido = UserData().PrimerApellido,
                        Contrasenia = usuario,
                        Correo = correo,
                        PaisId = UserData().PaisID
                    });
                }

                if (UniqueId > 0)
                {
                    string[] parametros = new string[] { UniqueId.ToString(), "1", UserData().PaisID.ToString(), UserData().CodigoUsuario, UserData().CodigoConsultora };
                    string param_querystring = Util.EncriptarQueryString(parametros);
                    HttpRequestBase request = this.HttpContext.Request;
                    string pagina_confirmacion = Util.GetUrlHost(request) + "WebPages/ConfirmacionRegistroComunidad.aspx?data=" + param_querystring;

                    System.Text.StringBuilder sb = new System.Text.StringBuilder();
                    sb.Append("<html><head><title>mail_inscripcion</title><meta http-equiv='Content-Type' content='text/html; charset=utf-8'></head>");
                    sb.Append("<body bgcolor='#FFFFFF' leftmargin='0' topmargin='0' marginwidth='0' marginheight='0'>");
                    sb.Append("<table width='766' height='665' border='0' align='center' cellpadding='0' cellspacing='0' id='Table_01'>");
                    sb.Append("<tr><td><img src='https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/Comunidad/mail_verificacion_01.jpg' width='766' height='240' alt=''></td></tr>");
                    sb.Append("<tr><td><img src='https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/Comunidad/mail_verificacion_02.gif' width='766' height='142' alt=''></td></tr>");
                    sb.Append("<tr><td><img src='https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/Comunidad/mail_verificacion_03.jpg' width='766' height='153' alt=''></td></tr>");
                    sb.Append("<tr><td width='766' height='28'>&nbsp;</td></tr>");
                    sb.Append("<tr><td><table id='Table_' width='766' height='46' border='0' cellpadding='0' cellspacing='0'><tr><td width='259'>&nbsp;</td>");
                    sb.Append(string.Format("<td width='249'><a href='{0}'><img src='https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/Comunidad/bot_verifica.gif' width='249' height='46' alt=''></a></td>", pagina_confirmacion));
                    sb.Append("<td width='258'>&nbsp;</td></tr></table></td></tr>");
                    sb.Append("<tr><td width='766' height='56'>&nbsp;</td></tr></table></body></html>");

                    Util.EnviarMail("comunidadsomosbelcorp@belcorp.biz", correo, "Bienvenida a la Comunidad SomosBelcorp", sb.ToString(), true, "Comunidad SomosBelcorp");

                    using (ServiceComunidad.ComunidadServiceClient sv = new ServiceComunidad.ComunidadServiceClient())
                    {
                        sv.UpdUsuarioCorreoEnviado(new ServiceComunidad.BEUsuarioComunidad()
                        {
                            UsuarioId = UniqueId,
                            Tipo = 1
                        });
                    }

                    UserData().EsUsuarioComunidad = true;

                    return Json(new
                    {
                        success = true,
                        message = "¡Gracias por querer ser parte de nuestra comunidad! Para continuar con el proceso, sigue los pasos del correo que te hemos enviado.",
                        extra = ""
                    }, JsonRequestBehavior.AllowGet);
                }
                else
                {
                    return Json(new
                    {
                        success = false,
                        message = "Hubo un problema con el servicio, intente nuevamente",
                        extra = ""
                    }, JsonRequestBehavior.AllowGet);
                }
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Hubo un problema con el servicio, intente nuevamente",
                    extra = ""
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Hubo un problema con el servicio, intente nuevamente",
                    extra = ""
                }, JsonRequestBehavior.AllowGet);
            }
        }

        [HttpPost]
        public JsonResult ValidarUsuarioIngresado(string usuario)
        {
            bool result = false;
            using (ServiceComunidad.ComunidadServiceClient sv = new ServiceComunidad.ComunidadServiceClient())
            {
                result = sv.GetUsuarioByCodigo(new ServiceComunidad.BEUsuarioComunidad()
                {
                    CodigoUsuario = usuario,
                });
            }

            return Json(new
            {
                success = result,
            }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult ValidarCorreoIngresado(string correo)
        {
            bool result = false;
            using (ServiceComunidad.ComunidadServiceClient sv = new ServiceComunidad.ComunidadServiceClient())
            {
                result = sv.GetUsuarioByCorreo(new ServiceComunidad.BEUsuarioComunidad()
                {
                    Correo = correo,
                });
            }

            return Json(new
            {
                success = result,
            }, JsonRequestBehavior.AllowGet);
        }

        /*Fin Cambios_Landing_Comunidad*/

        #region ShowRoom

        [HttpPost]
        public JsonResult MostrarShowRoomPopup()
        {
            /* PCABRERA EPD-180 - INICIO */
            var userData = new UsuarioModel();

            try
            {
                userData = UserData();
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, string.Empty, string.Empty);
                return Json(new
                {
                    success = false,
                    message = "Hubo un problema con el servicio, intente nuevamente",
                    extra = ""
                }, JsonRequestBehavior.AllowGet);
            }
            /* PCABRERA EPD-180 - FIN */
            try
            {
                var paisesShowRoom = ConfigurationManager.AppSettings["PaisesShowRoom"];
                if (paisesShowRoom.Contains(userData.CodigoISO))
                {
                    if (!userData.CargoEntidadesShowRoom) throw new Exception("Ocurrió un error al intentar traer la información de los evento y consultora de ShowRoom.");
                    var beShowRoomConsultora = userData.BeShowRoomConsultora;
                    var beShowRoom = userData.BeShowRoom;

                    if (beShowRoomConsultora == null) beShowRoomConsultora = new BEShowRoomEventoConsultora();
                    if (beShowRoom == null) beShowRoom = new BEShowRoomEvento();

                    if (beShowRoom.Estado == 1)
                    {
                        bool mostrarShowRoomProductos = false;
                        var rutaShowRoomPopup = beShowRoom.RutaShowRoomPopup;
                        var fechaHoy = DateTime.Now.AddHours(userData.ZonaHoraria).Date;

                        int diasAntes = beShowRoom.DiasAntes;
                        int diasDespues = beShowRoom.DiasDespues;

                        if (fechaHoy >= userData.FechaInicioCampania.AddDays(-diasAntes).Date && fechaHoy <= userData.FechaInicioCampania.AddDays(diasDespues).Date)
                        {
                            rutaShowRoomPopup = Url.Action("Index", "ShowRoom");
                            mostrarShowRoomProductos = true;
                        }
                        if (fechaHoy > userData.FechaInicioCampania.AddDays(diasDespues).Date) beShowRoomConsultora.MostrarPopup = false;                        

                        return Json(new
                        {
                            success = true,
                            data = beShowRoomConsultora,
                            diaInicio = userData.FechaInicioCampania.AddDays(-diasAntes).Day,
                            diaFin = userData.FechaInicioCampania.Day,
                            mesFin = NombreMes(userData.FechaInicioCampania.Month),
                            nombre = string.IsNullOrEmpty(userData.Sobrenombre)
                                ? userData.NombreConsultora
                                : userData.Sobrenombre,
                            message = "ShowRoomConsultora encontrada",
                            evento = beShowRoom,
                            mostrarShowRoomProductos,
                            rutaShowRoomPopup
                        });
                    }
                    else
                    {
                        return Json(new
                        {
                            success = false,
                            data = "",
                            message = "ShowRoomEvento no encontrado"
                        });
                    }
                    
                }
                else
                {
                    return Json(new
                    {
                        success = false,
                        data = "",
                        message = "ShowRoomConsultora encontrada"
                    });
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Hubo un problema con el servicio, intente nuevamente",
                    extra = ""
                }, JsonRequestBehavior.AllowGet);
            }
        }

        [HttpPost]
        public JsonResult MostrarShowRoomBannerLateral()
        {
            try
            {
                var paisesShowRoom = ConfigurationManager.AppSettings["PaisesShowRoom"];
                if (paisesShowRoom.Contains(userData.CodigoISO))
                {
                    if (!userData.CargoEntidadesShowRoom) throw new Exception("Ocurrió un error al intentar traer la información de los evento y consultora de ShowRoom.");
                    var beShowRoomConsultora = userData.BeShowRoomConsultora;
                    var beShowRoom = userData.BeShowRoom;

                    if (beShowRoom == null)
                    {
                        beShowRoom = new BEShowRoomEvento();
                        beShowRoomConsultora = new BEShowRoomEventoConsultora();
                        Session["EsShowRoom"] = "0";
                    }
                    else
                    {
                        if (beShowRoomConsultora == null)
                        {
                            beShowRoomConsultora = new BEShowRoomEventoConsultora();
                            Session["EsShowRoom"] = "0";
                        }
                        else Session["EsShowRoom"] = "1";
                    }

                    if (beShowRoom.Estado == 1)
                    {
                        var rutaShowRoomBannerLateral = beShowRoom.RutaShowRoomBannerLateral;
                        bool mostrarShowRoomProductos = false;
                        var fechaHoy = DateTime.Now.AddHours(userData.ZonaHoraria).Date;
                        bool estaActivoLateral = true;

                        int diasAntes = beShowRoom.DiasAntes;
                        int diasDespues = beShowRoom.DiasDespues;

                        if (fechaHoy >= userData.FechaInicioCampania.AddDays(-diasAntes).Date && fechaHoy <= userData.FechaInicioCampania.AddDays(diasDespues).Date)
                        {
                            mostrarShowRoomProductos = true;
                            rutaShowRoomBannerLateral = Url.Action("Index", "ShowRoom");
                        }
                        if (fechaHoy > userData.FechaInicioCampania.AddDays(diasDespues).Date)
                            estaActivoLateral = false;

                        return Json(new
                        {
                            success = true,
                            data = beShowRoomConsultora,
                            message = "ShowRoomConsultora encontrada",
                            diasFaltantes = userData.FechaInicioCampania.Day - diasAntes,
                            mesFaltante = userData.FechaInicioCampania.Month,
                            anioFaltante = userData.FechaInicioCampania.Year,
                            evento = beShowRoom,
                            mostrarShowRoomProductos,
                            rutaShowRoomBannerLateral,
                            estaActivoLateral
                        });
                    }
                    else
                    {
                        Session["EsShowRoom"] = "0";

                        return Json(new
                        {
                            success = false,
                            data = "",
                            message = "ShowRoomEvento no encontrado"
                        });
                    }                    
                }
                else
                {
                    Session["EsShowRoom"] = "0";

                    return Json(new
                    {
                        success = false,
                        data = "",
                        message = "ShowRoomConsultora no encontrada"
                    });
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Hubo un problema con el servicio, intente nuevamente",
                    extra = ""
                }, JsonRequestBehavior.AllowGet);
            }
        }

        #endregion
    }
}