using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceContenido;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServiceUsuario;
using Portal.Consultoras.Web.ServiceZonificacion;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Security.Claims;
using System.Web;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class BaseController : Controller
    {
        #region Variables

        protected UsuarioModel userData;

        #endregion

        #region Constructor

        public BaseController()
        {
            userData = new UsuarioModel();
        }

        #endregion

        #region Overrides

        protected override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            try
            {
                userData = UserData();

                if (Session["UserData"] != null)
                {
                    ViewBag.Permiso = BuildMenu();
                    ViewBag.ServiceController = ConfigurationManager.AppSettings["ServiceController"].ToString();
                    ViewBag.ServiceAction = ConfigurationManager.AppSettings["ServiceAction"].ToString();
                    MenuBelcorpResponde();
                    ObtenerPedidoWeb();
                    ObtenerPedidoWebDetalle();
                }

                base.OnActionExecuting(filterContext);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
        }

        #endregion

        #region Métodos

        #region Pedido

        protected BEPedidoWeb ObtenerPedidoWeb()
        {
            BEPedidoWeb bePedidoWeb = new BEPedidoWeb();

            if (Session["PedidoWeb"] == null)
            {
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    bePedidoWeb = sv.GetPedidoWebByCampaniaConsultora(userData.PaisID, userData.CampaniaID, userData.ConsultoraID);
                }
            }
            else
            {
                bePedidoWeb = (BEPedidoWeb)Session["PedidoWeb"];
            }

            Session["PedidoWeb"] = bePedidoWeb ?? new BEPedidoWeb();
            return bePedidoWeb;
        }

        protected List<BEPedidoWebDetalle> ObtenerPedidoWebDetalle()
        {
            List<BEPedidoWebDetalle> olstPedidoWebDetalle = new List<BEPedidoWebDetalle>();

            if (Session["PedidoWebDetalle"] == null)
            {
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    olstPedidoWebDetalle = sv.SelectByCampania(userData.PaisID, userData.CampaniaID, userData.ConsultoraID, userData.NombreConsultora).ToList();
                }
            }
            else
            {
                olstPedidoWebDetalle = (List<BEPedidoWebDetalle>)Session["PedidoWebDetalle"];
            }

            if (Session["ObservacionesPROL"] != null)
            {
                List<ObservacionModel> Observaciones = (List<ObservacionModel>)Session["ObservacionesPROL"];
                if (Observaciones != null)
                {
                    olstPedidoWebDetalle = PedidoConObservaciones(olstPedidoWebDetalle, Observaciones);
                }
            }

            Session["PedidoWebDetalle"] = olstPedidoWebDetalle ?? new List<BEPedidoWebDetalle>();
            return olstPedidoWebDetalle;
        }

        protected List<BEPedidoWebDetalle> PedidoConObservaciones(List<BEPedidoWebDetalle> Pedido, List<ObservacionModel> Observaciones)
        {
            List<BEPedidoWebDetalle> PedObs = Pedido;

            if (userData.NuevoPROL && userData.ZonaNuevoPROL)
            {
                foreach (var item in PedObs)
                {
                    List<ObservacionModel> temp = Observaciones.Where(o => o.CUV == item.CUV).ToList();
                    if (temp != null && temp.Count != 0)
                    {
                        if (temp[0].Caso == 0)
                        {
                            item.ClaseFila = string.Empty;
                            item.TipoObservacion = 0;
                            item.Mensaje = string.Empty;
                        }
                        else
                        {
                            item.ClaseFila = temp[0].Tipo == 1 ? "f1" : "f2";
                            item.TipoObservacion = temp[0].Tipo;
                            item.Mensaje = string.Empty;
                        }
                        foreach (var ob in temp)
                        {
                            item.Mensaje += ob.Descripcion + "<br/>";
                        }
                    }
                    else
                    {
                        item.ClaseFila = string.Empty;
                        item.TipoObservacion = 0;
                        item.Mensaje = string.Empty;
                    }
                }
            }
            else
            {
                foreach (var item in PedObs)
                {
                    List<ObservacionModel> temp = Observaciones.Where(o => o.CUV == item.CUV).ToList();
                    if (temp != null && temp.Count != 0)
                    {
                        item.ClaseFila = temp[0].Tipo == 1 ? "f1" : "f2";
                        item.TipoObservacion = temp[0].Tipo;
                        item.Mensaje = string.Empty;
                        foreach (var ob in temp)
                        {
                            item.Mensaje += ob.Descripcion + "<br/>";
                        }
                    }
                    else
                    {
                        item.ClaseFila = string.Empty;
                        item.TipoObservacion = 0;
                        item.Mensaje = string.Empty;
                    }
                }
            }
            return PedObs.OrderByDescending(p => p.TipoObservacion).ToList();
        }

        #endregion

        #region Menú

        private List<PermisoModel> BuildMenu()
        {
            if (Session["UserData"] != null)
            {
                int PaisID = userData.PaisID;
                int RolID = userData.RolID;
                if (RolID != 0)
                {
                    IList<ServiceSeguridad.BEPermiso> lst = new List<ServiceSeguridad.BEPermiso>();
                    using (ServiceSeguridad.SeguridadServiceClient sv = new ServiceSeguridad.SeguridadServiceClient())
                    {
                        lst = sv.GetPermisosByRol(PaisID, RolID).ToList();
                    }
                    List<PermisoModel> lstModel = new List<PermisoModel>();
                    foreach (var permiso in lst)
                    {
                        lstModel.Add(new PermisoModel
                        {
                            PermisoID = permiso.PermisoID,
                            RolId = permiso.RolId,
                            Descripcion = permiso.Descripcion,
                            IdPadre = permiso.IdPadre,
                            OrdenItem = permiso.OrdenItem,
                            UrlItem = permiso.UrlItem,
                            PaginaNueva = permiso.PaginaNueva,
                            Mostrar = permiso.Mostrar,
                            Posicion = permiso.Posicion,
                            UrlImagen = permiso.UrlImagen,
                            EsMenuEspecial = permiso.EsMenuEspecial,
                            EsSoloImagen = permiso.EsSoloImagen,
                            EsServicios = permiso.EsServicios,
                            EsDireccionExterior = permiso.UrlItem.ToLower().StartsWith("http"),
                            DescripcionFormateada = Util.RemoveDiacritics(permiso.Descripcion.ToLower()).Replace(" ", "-")
                        });
                    }

                    // Separar los datos obtenidos y para generar el menú
                    List<PermisoModel> menu = SepararItemsMenu(lstModel);

                    return menu;
                }
                else
                    return new List<PermisoModel>();
            }
            else
                return new List<PermisoModel>();
        }

        private List<PermisoModel> SepararItemsMenu(List<PermisoModel> menuOriginal)
        {
            // Crear lista resultante
            var menu = new List<PermisoModel>();

            // Separar los items desde la raiz (0)
            SepararItemsMenu(ref menu, menuOriginal, 0);

            return menu;
        }

        private void SepararItemsMenu(ref List<PermisoModel> menu, List<PermisoModel> menuOriginal, int idPadre)
        {
            // Asignar los hijos
            menu = menuOriginal.Where(x => x.IdPadre == idPadre)
                .OrderBy(x => x.Posicion)
                .ToList();

            // Por cada uno buscar si se tienen hijos y agregarlos
            foreach (var itemMenu in menu)
            {
                var temp = new List<PermisoModel>();

                SepararItemsMenu(ref temp, menuOriginal, itemMenu.PermisoID);

                if (itemMenu.EsServicios)
                {
                    var servicios = BuildMenuService();

                    foreach (var progs in servicios)
                    {
                        temp.Add(new PermisoModel()
                        {
                            Descripcion = progs.Descripcion,
                            UrlItem = progs.Url,
                            PaginaNueva = true,
                            Mostrar = true,
                            EsDireccionExterior = progs.Url.ToLower().StartsWith("http")
                        });
                    }
                }

                itemMenu.SubMenus = temp;
            }
        }

        private List<ServicioCampaniaModel> BuildMenuService()
        {
            if (Session["UserData"] != null)
            {
                int Campaniaid = userData.CampaniaID;
                IList<ServiceSAC.BEServicioCampania> lstTemp_1 = new List<ServiceSAC.BEServicioCampania>();
                IList<ServiceSAC.BEServicioCampania> lstTemp_2 = new List<ServiceSAC.BEServicioCampania>();
                IList<ServiceSAC.BEServicioCampania> lst = new List<ServiceSAC.BEServicioCampania>();

                using (SACServiceClient sv = new SACServiceClient())
                {
                    lstTemp_1 = sv.GetServicioByCampaniaPais(userData.PaisID, userData.CampaniaID).ToList();
                }

                /*RE2544 - CS*/
                int SegmentoID;
                if (userData.CodigoISO == "VE")
                {
                    SegmentoID = userData.SegmentoID;
                }
                else
                {
                    SegmentoID = (userData.SegmentoInternoID == null) ? userData.SegmentoID : (int)userData.SegmentoInternoID;
                }
                int SegmentoServicio = userData.EsJoven == 1 ? 99 : SegmentoID;/*RE2544 - CS*/ //R2161

                lstTemp_2 = lstTemp_1.Where(p => p.ConfiguracionZona == string.Empty || p.ConfiguracionZona.Contains(userData.ZonaID.ToString())).ToList();
                lst = lstTemp_2.Where(p => p.Segmento == "-1" || p.Segmento == SegmentoServicio.ToString()).ToList();

                Mapper.CreateMap<ServiceSAC.BEServicioCampania, ServicioCampaniaModel>()
                        .ForMember(x => x.ServicioId, t => t.MapFrom(c => c.ServicioId))
                        .ForMember(x => x.Descripcion, t => t.MapFrom(c => c.Descripcion))
                        .ForMember(x => x.Url, t => t.MapFrom(c => c.Url));

                return Mapper.Map<IList<ServiceSAC.BEServicioCampania>, List<ServicioCampaniaModel>>(lst);
            }
            else
                return new List<ServicioCampaniaModel>();
        }

        #endregion

        #region UserData

        protected void SetUserData(UsuarioModel model)
        {
            Session["UserData"] = model;
        }

        public UsuarioModel UserData()
        {
            UsuarioModel model = new UsuarioModel();
            string Url = Request == null ? "" :
                (Request.Url.Scheme + "://" + Request.Url.Authority + (Request.ApplicationPath.ToString().Equals("/") ? "/" : (Request.ApplicationPath + "/")) + "WebPages/");

            if (Session["UserData"] != null)
            {
                #region  Session["UserData"] != null

                model = (UsuarioModel)Session["UserData"];
                this.CargarEntidadesShowRoom(model);

                ViewBag.Usuario = "Hola, " + (string.IsNullOrEmpty(model.Sobrenombre) ? model.NombreConsultora : model.Sobrenombre);
                ViewBag.Rol = model.RolID;
                ViewBag.ListaProductoFaltante = model.ListaProductoFaltante;
                ViewBag.Campania = NombreCampania(model.NombreCorto);
                ViewBag.CampaniaCodigo = model.CampaniaID;
                ViewBag.BanderaImagen = model.BanderaImagen;
                ViewBag.NombrePais = model.NombrePais;
                ViewBag.CambioClave = model.CambioClave;
                ViewBag.UrlAyuda = string.IsNullOrEmpty(model.UrlAyuda) ? string.Empty : model.UrlAyuda;
                ViewBag.UrlCapedevi = string.IsNullOrEmpty(model.UrlCapedevi) ? string.Empty : model.UrlCapedevi;
                ViewBag.UrlTerminos = string.IsNullOrEmpty(model.UrlTerminos) ? string.Empty : Url + model.UrlTerminos;
                ViewBag.CodigoZonaConsultora = model.CodigoZona;
                ViewBag.RolAnalytics = model.RolDescripcion;
                ViewBag.EdadAnalytics = Util.Edad(model.FechaNacimiento);
                ViewBag.ZonaAnalytics = model.CodigoZona;
                ViewBag.PaisAnalytics = model.CodigoISO;
                ViewBag.CodigoISODL = model.CodigoISO;
                ViewBag.MensajeAniversario = string.Empty;
                ViewBag.MensajeCumpleanos = string.Empty;
                ViewBag.IndicadorPermisoFIC = model.IndicadorPermisoFIC;
                ViewBag.IndicadorPermisoFlexipago = model.IndicadorPermisoFlexipago;
                ViewBag.HorasDuracionRestriccion = model.HorasDuracionRestriccion;

                ViewBag.RegionAnalytics = model.CodigorRegion;
                ViewBag.SegmentoAnalytics = model.Segmento != null && model.Segmento != "" ?
                    (string.IsNullOrEmpty(model.Segmento) ? string.Empty : model.Segmento.ToString().Trim()) : "(not available)";

                ViewBag.esConsultoraLiderAnalytics = model.esConsultoraLider == true ? "Socia" : model.RolDescripcion;
                ViewBag.SeccionAnalytics = model.SeccionAnalytics != null && model.SeccionAnalytics != "" ? model.SeccionAnalytics : "(not available)";
                ViewBag.CodigoConsultoraDL = model.CodigoConsultora != null && model.CodigoConsultora != "" ? model.CodigoConsultora : "(not available)";
                ViewBag.SegmentoConstancia = model.SegmentoConstancia != null && model.SegmentoConstancia != "" ? model.SegmentoConstancia.Trim() : "(not available)";
                ViewBag.DescripcionNivelAnalytics = model.DescripcionNivel != null && model.DescripcionNivel != "" ? model.DescripcionNivel : "(not available)";
                ViewBag.ConsultoraAsociada = model.ConsultoraAsociada;

                if (model.RolID == Portal.Consultoras.Common.Constantes.Rol.Consultora)
                {
                    if (model.ConsultoraNueva != Constantes.ConsultoraNueva.Sicc &&
                        model.ConsultoraNueva != Constantes.ConsultoraNueva.Fox)
                    {
                        if (model.NombreCorto != null &&
                            model.AnoCampaniaIngreso.Trim() != "")
                        {
                            int campaniaActual = int.Parse(model.NombreCorto);
                            int campaniaIngreso = int.Parse(model.AnoCampaniaIngreso);
                            int diferencia = campaniaActual - campaniaIngreso;
                            if (diferencia >= 12)
                            {
                                if (model.AnoCampaniaIngreso.Trim().EndsWith(model.NombreCorto.Trim().Substring(4)))
                                {
                                    ViewBag.MensajeAniversario = string.Format("!Feliz Aniversario {0}!", (string.IsNullOrEmpty(model.Sobrenombre) ? model.PrimerNombre + " " + model.PrimerApellido : model.Sobrenombre));
                                }
                            }
                        }
                    }

                    if (model.FechaNacimiento.Date != DateTime.Now.Date)
                    {
                        if (model.FechaNacimiento.Month == DateTime.Now.Month &&
                            model.FechaNacimiento.Day == DateTime.Now.Day)
                        {
                            ViewBag.MensajeCumpleanos = string.Format("!Feliz Cumpleaños {0}!", (string.IsNullOrEmpty(model.Sobrenombre) ? model.PrimerNombre + " " + model.PrimerApellido : model.Sobrenombre));
                        }
                    }
                }

                DateTime fechaHoy = DateTime.Now.AddHours(model.ZonaHoraria).Date;
                ViewBag.FechaActualPais = fechaHoy.ToShortDateString();
                ViewBag.Dias = fechaHoy >= model.FechaInicioCampania.Date && fechaHoy <= model.FechaFinCampania.Date ? 0 : (model.FechaInicioCampania.Subtract(DateTime.Now.AddHours(model.ZonaHoraria)).Days + 1);
                ViewBag.PeriodoAnalitycs = fechaHoy >= model.FechaInicioCampania.Date && fechaHoy <= model.FechaFinCampania.Date ? "Facturacion" : "Venta";

                DateTime FechaHoraActual = DateTime.Now.AddHours(model.ZonaHoraria);
                TimeSpan HoraCierrePortal = model.EsZonaDemAnti == 0 ? model.HoraCierreZonaNormal : model.HoraCierreZonaDemAnti;
                DateTime tiempo = DateTime.Today.Add(HoraCierrePortal);
                string displayTiempo = tiempo.ToShortTimeString().Replace(".", " ").Replace(" ", "").Insert(5, " ");

                string TextoPromesa = ".</b></p>";
                string TextoNuevoProl = "<p>Revisa tus notificaciones o correo y verifica que tu pedido esté completo.</p>";

                if (model.TipoCasoPromesa != "0")
                {
                    if (model.TipoCasoPromesa == "1" && model.DiasCasoPromesa != -1)
                    {
                        TextoPromesa = "</b> y recíbelo después de " + model.DiasCasoPromesa + (model.DiasCasoPromesa == 1 ? " día" : " días") + ".</p>";
                    }
                    else if (model.TipoCasoPromesa != "1" && model.DiasCasoPromesa != -1) //casos 2,3 y 4
                    {
                        model.FechaPromesaEntrega = FechaHoraActual.AddDays(model.DiasCasoPromesa);
                        TextoPromesa = "</b> y recíbelo el " + model.FechaPromesaEntrega.Day + " de " + NombreMes(model.FechaPromesaEntrega.Month) + ".</p>";
                    }
                }

                if (!model.DiaPROL)
                {
                    ViewBag.MensajeCierreCampania = "<p>Pasa tu pedido hasta el <b>" + model.FechaFacturacion.Day + " de " + NombreMes(model.FechaFacturacion.Month) + "</b> a las <b>" + displayTiempo;
                    if (model.ZonaValida)
                        ViewBag.MensajeCierreCampania = ViewBag.MensajeCierreCampania + TextoPromesa;
                    else
                        ViewBag.MensajeCierreCampania = ViewBag.MensajeCierreCampania + ".</b></p>";

                    if (model.NuevoPROL && model.ZonaNuevoPROL)
                        ViewBag.MensajeCierreCampania = ViewBag.MensajeCierreCampania + TextoNuevoProl;
                }
                else
                {
                    ViewBag.MensajeCierreCampania = "<p>Pasa o modifica tu pedido <b>hasta hoy a las " + displayTiempo;
                    if (model.ZonaValida)
                        ViewBag.MensajeCierreCampania = ViewBag.MensajeCierreCampania + TextoPromesa;
                    else
                        ViewBag.MensajeCierreCampania = ViewBag.MensajeCierreCampania + ".</b></p>";
                }

                ViewBag.QSBR = string.Format("NOMB={0}&PAIS={1}&CODI={2}&CORR={3}&TELF={4}", model.NombreConsultora.ToUpper(), model.CodigoISO, model.CodigoConsultora, model.EMail, model.Telefono.Trim() + (model.Celular.Trim() == string.Empty ? "" : "; " + model.Celular.Trim()));

                model.MenuNotificaciones = 1;
                ViewBag.TieneNotificaciones = model.TieneNotificaciones;
                ViewBag.TieneFechaPromesa = 0;
                ViewBag.MensajeFechaPromesa = string.Empty;
                ViewBag.DiaFechaPromesa = 0;
                ViewBag.EsUsuarioComunidad = model.EsUsuarioComunidad ? 1 : 0;
                ViewBag.NombreC = model.PrimerNombre;
                ViewBag.ApellidoC = model.PrimerApellido;
                ViewBag.CorreoC = model.EMail;
                ViewBag.Lider = model.Lider;
                ViewBag.PortalLideres = model.PortalLideres;
                ViewBag.LogOutComunidad = ConfigurationManager.AppSettings["URL_COM_LO"] + "&dest_url=" + ConfigurationManager.AppSettings["URL_SB"] + "/WebPages/ComunidadLogout.aspx";
                ViewBag.LogOutSB = ConfigurationManager.AppSettings["URL_SB"] + "/WebPages/ComunidadLogout.aspx";
                ViewBag.TokenAtento = ConfigurationManager.AppSettings["TokenAtento_" + model.CodigoISO];
                ViewBag.IdbelcorpChat = "belcorpChat" + model.CodigoISO;
                ViewBag.EstadoSimplificacionCUV = model.EstadoSimplificacionCUV;
                ViewBag.FormatDecimalPais = GetFormatDecimalPais(model.CodigoISO);

                return model;

                #endregion
            }
            else
            {
                #region Session["UserData"] == null

                ClaimsPrincipal claimsPrincipal = User as ClaimsPrincipal;
                Claim FederationClaimName = claimsPrincipal.FindFirst(ClaimTypes.Name);
                string claimUser = FederationClaimName == null ? "" : FederationClaimName.Value.ToUpper();
                string DomConsultora = ConfigurationManager.AppSettings.Get("DomConsultora") ?? "";
                string DomBelcorp = ConfigurationManager.AppSettings.Get("DomBelcorp") ?? "";

                string UserPortal = string.Empty;
                bool UsuarioSAC = false;
                int Tipo = 0;
                if (claimUser != "" && claimUser.Contains(DomConsultora))
                {
                    UserPortal = claimUser.Replace(DomConsultora + @"\", "");
                    Tipo = 1;
                }
                else
                    if (claimUser != "" && claimUser.Contains(DomBelcorp))
                    {
                        UserPortal = claimUser.Replace(DomBelcorp + @"\", "");
                        UsuarioSAC = true;
                        Tipo = 2;
                    }


                if (!string.IsNullOrEmpty(UserPortal))
                {
                    List<BEPais> lst = new List<BEPais>();

                    using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
                    {
                        lst = sv.SelectPaises().ToList();
                    }

                    string Pais = string.Empty;
                    string Codigo = string.Empty;

                    if (!UsuarioSAC)
                    {
                        Pais = UserPortal.Substring(0, 2);
                        Codigo = UserPortal.Replace(Pais, "");
                    }
                    else
                    {
                        Claim FederationClaimCountry = claimsPrincipal.FindFirst(ClaimTypes.Country);
                        Pais = FederationClaimCountry.Value.ToUpper();
                        Codigo = UserPortal;
                    }


                    BEPais PaisModel = lst.First(p => p.CodigoISO == Pais);
                    if (PaisModel != null)
                        GetUserData(PaisModel.PaisID, Codigo, Tipo);
                }

                model = (UsuarioModel)Session["UserData"];
                if (model == null) return model;
                this.CargarEntidadesShowRoom(model);

                ViewBag.Usuario = "Hola, " + (string.IsNullOrEmpty(model.Sobrenombre) ? model.NombreConsultora : model.Sobrenombre);
                ViewBag.Rol = model.RolID;
                ViewBag.ListaProductoFaltante = model.ListaProductoFaltante;
                ViewBag.Campania = NombreCampania(model.NombreCorto);
                ViewBag.CampaniaCodigo = model.CampaniaID;
                ViewBag.BanderaImagen = model.BanderaImagen;
                ViewBag.NombrePais = model.NombrePais;
                ViewBag.CambioClave = model.CambioClave;
                ViewBag.UrlAyuda = string.IsNullOrEmpty(model.UrlAyuda) ? string.Empty : model.UrlAyuda;
                ViewBag.UrlCapedevi = string.IsNullOrEmpty(model.UrlCapedevi) ? string.Empty : model.UrlCapedevi;
                ViewBag.UrlTerminos = string.IsNullOrEmpty(model.UrlTerminos) ? string.Empty : Url + model.UrlTerminos;
                ViewBag.CodigoZonaConsultora = model.CodigoZona;
                ViewBag.RolAnalytics = model.RolDescripcion;
                ViewBag.EdadAnalytics = Util.Edad(model.FechaNacimiento);
                ViewBag.ZonaAnalytics = model.CodigoZona;
                ViewBag.PaisAnalytics = model.CodigoISO;
                ViewBag.CodigoISODL = model.CodigoISO;
                ViewBag.MensajeAniversario = string.Empty;
                ViewBag.MensajeCumpleanos = string.Empty;
                ViewBag.IndicadorPermisoFIC = model.IndicadorPermisoFIC;
                ViewBag.IndicadorPermisoFlexipago = model.IndicadorPermisoFlexipago;
                ViewBag.HorasDuracionRestriccion = model.HorasDuracionRestriccion;

                ViewBag.SegmentoAnalytics = string.IsNullOrEmpty(model.Segmento) ? string.Empty : model.Segmento.ToString().Trim();
                ViewBag.CodigoConsultoraDL = model.CodigoConsultora;

                ViewBag.CampanaInvitada = model.CampanaInvitada;
                ViewBag.InscritaFlexipago = model.InscritaFlexipago;
                ViewBag.InvitacionRechazada = model.InvitacionRechazada;

                if (model.RolID == Portal.Consultoras.Common.Constantes.Rol.Consultora)
                {
                    if (model.ConsultoraNueva != Constantes.ConsultoraNueva.Sicc &&
                        model.ConsultoraNueva != Constantes.ConsultoraNueva.Fox)
                    {
                        if (model.NombreCorto != null &&
                            model.AnoCampaniaIngreso.Trim() != "")
                        {
                            int campaniaActual = int.Parse(model.NombreCorto);
                            int campaniaIngreso = int.Parse(model.AnoCampaniaIngreso);
                            int diferencia = campaniaActual - campaniaIngreso;
                            if (diferencia >= 12)
                            {
                                if (model.AnoCampaniaIngreso.Trim().EndsWith(model.NombreCorto.Trim().Substring(4)))
                                {
                                    ViewBag.MensajeAniversario = string.Format("!Feliz Aniversario {0}!", (string.IsNullOrEmpty(model.Sobrenombre) ? model.PrimerNombre + " " + model.PrimerApellido : model.Sobrenombre));
                                }
                            }
                        }
                    }

                    if (model.FechaNacimiento.Date != DateTime.Now.Date)
                    {
                        if (model.FechaNacimiento.Month == DateTime.Now.Month &&
                            model.FechaNacimiento.Day == DateTime.Now.Day)
                        {
                            ViewBag.MensajeCumpleanos = string.Format("!Feliz Cumpleaños {0}!", (string.IsNullOrEmpty(model.Sobrenombre) ? model.PrimerNombre + " " + model.PrimerApellido : model.Sobrenombre));
                        }
                    }
                }

                DateTime fechaHoy = DateTime.Now.AddHours(model.ZonaHoraria).Date;
                ViewBag.FechaActualPais = fechaHoy.ToShortDateString();
                ViewBag.Dias = fechaHoy >= model.FechaInicioCampania.Date && fechaHoy <= model.FechaFinCampania.Date ? 0 : (model.FechaInicioCampania.Subtract(DateTime.Now.AddHours(model.ZonaHoraria)).Days + 1);

                DateTime FechaHoraActual = DateTime.Now.AddHours(model.ZonaHoraria);
                TimeSpan HoraCierrePortal = model.EsZonaDemAnti == 0 ? model.HoraCierreZonaNormal : model.HoraCierreZonaDemAnti;
                DateTime tiempo = DateTime.Today.Add(HoraCierrePortal);
                string displayTiempo = tiempo.ToShortTimeString().Replace(".", " ").Replace(" ", "").Insert(5, " ");

                string TextoPromesa = ".</b></p>";
                string TextoNuevoProl = "<p>Revisa tus notificaciones o correo y verifica que tu pedido esté completo.</p>";

                if (model.TipoCasoPromesa != "0")
                {
                    if (model.TipoCasoPromesa == "1" && model.DiasCasoPromesa != -1)
                    {
                        TextoPromesa = "</b> y recíbelo después de " + model.DiasCasoPromesa + (model.DiasCasoPromesa == 1 ? " día" : " días") + ".</p>";
                    }
                    else if (model.TipoCasoPromesa != "1" && model.DiasCasoPromesa != -1) //casos 2,3 y 4
                    {
                        model.FechaPromesaEntrega = FechaHoraActual.AddDays(model.DiasCasoPromesa);
                        TextoPromesa = "</b> y recíbelo el " + model.FechaPromesaEntrega.Day + " de " + NombreMes(model.FechaPromesaEntrega.Month) + ".</p>";
                    }
                }

                if (!model.DiaPROL)
                {
                    ViewBag.MensajeCierreCampania = "<p>Pasa tu pedido hasta el <b>" + model.FechaFacturacion.Day + " de " + NombreMes(model.FechaFacturacion.Month) + "</b> a las <b>" + displayTiempo;
                    if (model.ZonaValida)
                        ViewBag.MensajeCierreCampania = ViewBag.MensajeCierreCampania + TextoPromesa;
                    else
                        ViewBag.MensajeCierreCampania = ViewBag.MensajeCierreCampania + ".</b></p>";

                    if (model.NuevoPROL && model.ZonaNuevoPROL)
                        ViewBag.MensajeCierreCampania = ViewBag.MensajeCierreCampania + TextoNuevoProl;
                }
                else
                {
                    ViewBag.MensajeCierreCampania = "<p>Pasa o modifica tu pedido <b>hasta hoy a las " + displayTiempo;
                    if (model.ZonaValida)
                        ViewBag.MensajeCierreCampania = ViewBag.MensajeCierreCampania + TextoPromesa;
                    else
                        ViewBag.MensajeCierreCampania = ViewBag.MensajeCierreCampania + ".</b></p>";
                }

                ViewBag.Permiso = BuildMenu();
                ViewBag.Servicio = BuildMenuService();
                MenuBelcorpResponde();
                ViewBag.ServiceController = ConfigurationManager.AppSettings["ServiceController"].ToString();
                ViewBag.ServiceAction = ConfigurationManager.AppSettings["ServiceAction"].ToString();
                ViewBag.QSBR = string.Format("NOMB={0}&PAIS={1}&CODI={2}&CORR={3}&TELF={4}", model.NombreConsultora.ToUpper(), model.CodigoISO, model.CodigoConsultora, model.EMail, model.Telefono.Trim() + (model.Celular.Trim() == string.Empty ? "" : "; " + model.Celular.Trim()));

                ViewBag.MenuNotificaciones = model.MenuNotificaciones;
                ViewBag.TieneNotificaciones = model.TieneNotificaciones;
                ViewBag.EsUsuarioComunidad = model.EsUsuarioComunidad ? 1 : 0;
                ViewBag.NombreC = model.PrimerNombre;
                ViewBag.ApellidoC = model.PrimerApellido;
                ViewBag.CorreoC = model.EMail;
                ViewBag.Lider = model.Lider;
                ViewBag.PortalLideres = model.PortalLideres;
                ViewBag.LogOutComunidad = ConfigurationManager.AppSettings["URL_COM_LO"] + "&dest_url=" + ConfigurationManager.AppSettings["URL_SB"] + "/WebPages/ComunidadLogout.aspx";
                ViewBag.LogOutSB = ConfigurationManager.AppSettings["URL_SB"] + "/WebPages/ComunidadLogout.aspx";
                ViewBag.TokenAtento = ConfigurationManager.AppSettings["TokenAtento_" + model.CodigoISO];
                ViewBag.IdbelcorpChat = "belcorpChat" + model.CodigoISO;
                ViewBag.EstadoSimplificacionCUV = model.EstadoSimplificacionCUV;

                ViewBag.FormatDecimalPais = GetFormatDecimalPais(model.CodigoISO);

                return model;

                #endregion
            }
        }

        private string GetFormatDecimalPais(string isoPais)
        {
            var listaPaises = ConfigurationManager.AppSettings["KeyPaisFormatDecimal"] ?? "";
            if (listaPaises == "") return ",|.|2";
            if (listaPaises.Contains(isoPais)) return ".||0";            
            return ",|.|2";
        }

        private UsuarioModel GetUserData(int PaisID, string CodigoUsuario, int TipoUsuario)
        {
            UsuarioModel model = null;
            BEUsuario oBEUsuario = null;

            using (UsuarioServiceClient sv = new UsuarioServiceClient())
            {
                oBEUsuario = sv.GetSesionUsuario(PaisID, CodigoUsuario);
            }
            if (oBEUsuario != null)
            {
                model = new UsuarioModel();
                model.NombrePais = oBEUsuario.NombrePais;
                model.PaisID = oBEUsuario.PaisID;
                model.CodigoISO = oBEUsuario.CodigoISO;
                model.CodigoFuente = oBEUsuario.CodigoFuente;
                model.RegionID = oBEUsuario.RegionID;
                model.CodigorRegion = oBEUsuario.CodigorRegion;
                model.ZonaID = oBEUsuario.ZonaID;
                model.CodigoZona = oBEUsuario.CodigoZona;
                model.ConsultoraID = oBEUsuario.ConsultoraID;
                model.CodigoUsuario = oBEUsuario.CodigoUsuario;
                model.CodigoConsultora = oBEUsuario.CodigoConsultora;
                model.ConsultoraNueva = oBEUsuario.ConsultoraNueva;
                model.NombreConsultora = oBEUsuario.Nombre;
                model.RolID = oBEUsuario.RolID;
                model.EMail = oBEUsuario.EMail;
                model.CampaniaID = oBEUsuario.CampaniaID;
                model.BanderaImagen = oBEUsuario.BanderaImagen;
                model.CambioClave = Convert.ToInt32(oBEUsuario.CambioClave);
                model.ConsultoraNueva = oBEUsuario.ConsultoraNueva;
                model.Telefono = oBEUsuario.Telefono;
                model.Celular = oBEUsuario.Celular;
                model.IndicadorDupla = oBEUsuario.IndicadorDupla;
                model.UsuarioPrueba = oBEUsuario.UsuarioPrueba;
                model.PasePedidoWeb = oBEUsuario.PasePedidoWeb;
                model.TipoOferta2 = oBEUsuario.TipoOferta2;
                model.CompraKitDupla = oBEUsuario.CompraKitDupla;
                model.CompraOfertaDupla = oBEUsuario.CompraOfertaDupla;
                model.CompraOfertaEspecial = oBEUsuario.CompraOfertaEspecial;
                model.IndicadorMeta = oBEUsuario.IndicadorMeta;
                model.ProgramaReconocimiento = oBEUsuario.ProgramaReconocimiento;
                model.NivelEducacion = oBEUsuario.NivelEducacion;
                model.SegmentoID = oBEUsuario.SegmentoID;
                model.FechaNacimiento = oBEUsuario.FechaNacimiento;
                model.Nivel = oBEUsuario.Nivel;
                model.FechaInicioCampania = oBEUsuario.FechaInicioFacturacion;
                model.HabilitarRestriccionHoraria = oBEUsuario.HabilitarRestriccionHoraria;
                model.IndicadorPermisoFIC = oBEUsuario.IndicadorPermisoFIC;
                model.HorasDuracionRestriccion = oBEUsuario.HorasDuracionRestriccion;
                model.EsJoven = oBEUsuario.EsJoven;
                model.PROLSinStock = oBEUsuario.PROLSinStock;
                model.CampanaInvitada = oBEUsuario.CampanaInvitada;
                model.InscritaFlexipago = oBEUsuario.InscritaFlexipago;
                model.IndicadorFlexiPago = oBEUsuario.IndicadorFlexiPago;
                model.InvitacionRechazada = oBEUsuario.InvitacionRechazada;
                model.SegmentoConstancia = oBEUsuario.SegmentoConstancia;

                if (DateTime.Now.AddHours(oBEUsuario.ZonaHoraria) < oBEUsuario.FechaInicioFacturacion.AddDays(-oBEUsuario.DiasAntes))
                {
                    model.DiaPROL = false;
                    model.FechaFacturacion = oBEUsuario.FechaInicioFacturacion.AddDays(-oBEUsuario.DiasAntes);
                    model.HoraFacturacion = oBEUsuario.DiasAntes == 0 ? oBEUsuario.HoraInicio : oBEUsuario.HoraInicioNoFacturable;
                }
                else
                {
                    model.DiaPROL = true;
                    model.FechaFacturacion = oBEUsuario.FechaFinFacturacion;
                    model.HoraFacturacion = oBEUsuario.HoraFin;
                }

                model.HoraInicioReserva = oBEUsuario.HoraInicio;
                model.HoraFinReserva = oBEUsuario.HoraFin;
                model.HoraInicioPreReserva = oBEUsuario.HoraInicioNoFacturable;
                model.HoraFinPreReserva = oBEUsuario.HoraCierreNoFacturable;
                model.DiasCampania = oBEUsuario.DiasAntes;
                model.HoraFinFacturacion = oBEUsuario.HoraFin;
                model.NombreCorto = oBEUsuario.CampaniaDescripcion;

                // OGA: agregado el campo para determinar el inicio del rango
                model.DiasAntes = oBEUsuario.DiasAntes;
                model.DiasDuracionCronograma = oBEUsuario.DiasDuracionCronograma;

                // OGA: se calcula el fin de campañia sumando el nº de dias que dura el cronograma
                switch (oBEUsuario.RolID)
                {
                    case Constantes.Rol.Administrador:
                        model.FechaFinCampania = oBEUsuario.FechaFinFacturacion;
                        break;
                    case Constantes.Rol.Consultora:
                        model.FechaFinCampania = oBEUsuario.FechaFinFacturacion;
                        break;
                }

                model.ZonaValida = oBEUsuario.ZonaValida;
                model.MontoMinimo = oBEUsuario.MontoMinimoPedido;
                model.MontoMaximo = oBEUsuario.MontoMaximoPedido;
                model.Simbolo = oBEUsuario.Simbolo;
                model.CodigoTerritorio = oBEUsuario.CodigoTerritorio;
                //model.ModelPedido = GetModelPedidoAgotado(model.PaisID, model.CampaniaID, model.ZonaID);
                model.HoraCierreZonaDemAnti = oBEUsuario.HoraCierreZonaDemAnti;
                model.HoraCierreZonaNormal = oBEUsuario.HoraCierreZonaNormal;
                model.ZonaHoraria = oBEUsuario.ZonaHoraria;
                model.TipoUsuario = TipoUsuario;
                model.EsZonaDemAnti = oBEUsuario.EsZonaDemAnti;
                model.Segmento = oBEUsuario.Segmento;
                model.Sobrenombre = oBEUsuario.Sobrenombre;
                model.SobrenombreOriginal = oBEUsuario.Sobrenombre;
                model.Direccion = oBEUsuario.Direccion;
                model.IPUsuario = GetIPCliente();
                model.AnoCampaniaIngreso = oBEUsuario.AnoCampaniaIngreso;
                model.PrimerNombre = oBEUsuario.PrimerNombre;
                model.PrimerApellido = oBEUsuario.PrimerApellido;
                model.IndicadorFlexiPago = oBEUsuario.IndicadorFlexiPago;
                model.IndicadorPermisoFlexipago = GetPermisoFlexipago(model.PaisID, model.CodigoISO, model.CodigoConsultora, model.CampaniaID);
                model.MostrarAyudaWebTraking = oBEUsuario.MostrarAyudaWebTraking;
                model.NroCampanias = oBEUsuario.NroCampanias;
                model.RolDescripcion = oBEUsuario.RolDescripcion;
                model.Lider = oBEUsuario.Lider;
                model.CampaniaInicioLider = oBEUsuario.CampaniaInicioLider;
                model.SeccionGestionLider = oBEUsuario.SeccionGestionLider;
                model.NivelLider = oBEUsuario.NivelLider;
                model.PortalLideres = oBEUsuario.PortalLideres;
                model.LogoLideres = oBEUsuario.LogoLideres;
                model.ConsultoraAsociada = oBEUsuario.ConsultoraAsociada;
                model.MenuNotificaciones = 1;
                if (model.MenuNotificaciones == 1)
                    model.TieneNotificaciones = TieneNotificaciones(oBEUsuario);
                model.NuevoPROL = oBEUsuario.NuevoPROL;
                model.ZonaNuevoPROL = oBEUsuario.ZonaNuevoPROL;
                model.EMailActivo = oBEUsuario.EMailActivo;
                model.EMail = oBEUsuario.EMail;
                model.EsquemaDAConsultora = oBEUsuario.EsquemaDAConsultora;

                List<TipoLinkModel> lista = GetLinksPorPais(model.PaisID);
                if (lista.Count > 0)
                {
                    model.UrlAyuda = lista.Find(x => x.TipoLinkID == 301).Url;
                    model.UrlCapedevi = lista.Find(x => x.TipoLinkID == 302).Url;
                    model.UrlTerminos = lista.Find(x => x.TipoLinkID == 303).Url;
                }

                model.EsUsuarioComunidad = EsUsuarioComunidad(oBEUsuario.PaisID, oBEUsuario.CodigoUsuario);
                model.SegmentoInternoID = oBEUsuario.SegmentoInternoID;
                model.ValidacionInteractiva = oBEUsuario.ValidacionInteractiva;
                model.MensajeValidacionInteractiva = oBEUsuario.MensajeValidacionInteractiva;

                // Pago Online CO - CL - PR
                model.IndicadorPagoOnline = model.PaisID == 4 || model.PaisID == 3 || model.PaisID == 12 ? 1 : 0;
                model.UrlPagoOnline = model.PaisID == 4 ? "https://www.zonapagos.com/pagosn2/LoginCliente"
                    : model.PaisID == 3 ? "https://www.belcorpchile.cl/BotonesPagoRedireccion/PagoConsultora.aspx"
                    : model.PaisID == 12 ? "https://www.somosbelcorp.com/Paypal"
                    : "";

                model.OfertaFinal = oBEUsuario.OfertaFinal;
                model.EsOfertaFinalZonaValida = oBEUsuario.EsOfertaFinalZonaValida;
            }
            Session["UserData"] = model;

            return model;
        }

        private List<BEProductoFaltante> GetProductosFaltantes(int PaisID, int CampaniaID, int ZonaID)
        {
            List<BEProductoFaltante> olstProductoFaltante = new List<BEProductoFaltante>();
            using (SACServiceClient sv = new SACServiceClient())
            {
                olstProductoFaltante = sv.GetProductoFaltanteByCampaniaAndZonaID(PaisID, CampaniaID, ZonaID).ToList();
            }
            return olstProductoFaltante;
        }

        private List<TipoLinkModel> GetLinksPorPais(int PaisID)
        {
            List<ServiceContenido.BETipoLink> listModel = new List<ServiceContenido.BETipoLink>();
            using (ServiceContenido.ContenidoServiceClient sv = new ServiceContenido.ContenidoServiceClient())
            {
                listModel = sv.GetLinksPorPais(PaisID).ToList();
            }

            Mapper.CreateMap<BETipoLink, TipoLinkModel>()
                  .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                  .ForMember(t => t.TipoLinkID, f => f.MapFrom(c => c.TipoLinkID))
                  .ForMember(t => t.Url, f => f.MapFrom(c => c.Url));

            return Mapper.Map<IList<BETipoLink>, List<TipoLinkModel>>(listModel);
        }

        private bool GetPermisoFlexipago(int PaisID, string PaisISO, string CodigoConsultora, int CampaniaID)
        {
            bool Result = false;
            string hasFlexipago = ConfigurationManager.AppSettings.Get("PaisesFlexipago") ?? string.Empty;
            if (hasFlexipago.Contains(PaisISO))
            {
                using (ServicePedido.PedidoServiceClient sv = new ServicePedido.PedidoServiceClient())
                {
                    Result = sv.GetPermisoFlexipago(PaisID, CodigoConsultora, CampaniaID);
                }
            }

            return Result;
        }

        private string NombreCampania(string Campania)
        {
            string Result = Campania;
            try
            {
                if (Campania.Length == 6)
                {
                    return Result = string.Format("Campaña {0}", Campania.Substring(4, 2));
                }
            }
            catch { }
            return Result;
        }

        private string GetIPCliente()
        {
            string IP = string.Empty;
            try
            {
                IP = HttpContext.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];
            }
            catch { }
            return IP;
        }

        private void MenuBelcorpResponde()
        {
            if (Session["UserData"] != null)
            {
                UsuarioModel model = userData;
                List<BEBelcorpResponde> lista = new List<BEBelcorpResponde>();
                using (ContenidoServiceClient sv = new ContenidoServiceClient())
                {
                    lista = sv.GetBelcorpResponde(model.PaisID).ToList();
                }

                if (lista.Count > 0)
                {
                    if (lista[0].ChatURL != "" && lista[0].ChatURL != null)
                    {
                        if (lista[0].ParametroPais && lista[0].ParametroCodigoConsultora)
                            lista[0].ChatURL = lista[0].ChatURL + "?PAIS=" + model.CodigoISO + "&CODI=" + model.CodigoConsultora;
                        if (lista[0].ParametroPais && !lista[0].ParametroCodigoConsultora)
                            lista[0].ChatURL = lista[0].ChatURL + "?PAIS=" + model.CodigoISO;
                        if (!lista[0].ParametroPais && lista[0].ParametroCodigoConsultora)
                            lista[0].ChatURL = lista[0].ChatURL + "?CODI=" + model.CodigoConsultora;
                    }
                }

                ViewBag.ListaBelcorpResponde = lista;
                ViewBag.CantidadListaBelcorpResponde = lista.Count;
            }
        }

        private bool EsUsuarioComunidad(int PaisId, string CodigoUsuario)
        {
            ServiceComunidad.BEUsuarioComunidad result = null;
            try
            {
                using (ServiceComunidad.ComunidadServiceClient sv = new ServiceComunidad.ComunidadServiceClient())
                {
                    result = sv.GetUsuarioInformacion(new ServiceComunidad.BEUsuarioComunidad()
                    {
                        PaisId = PaisId,
                        UsuarioId = 0,
                        CodigoUsuario = CodigoUsuario,
                        Tipo = 3
                    });
                }
            }
            catch
            {

            }

            return result == null ? false : true;
        }

        private int TieneNotificaciones(BEUsuario oBEUsuario)
        {
            int Tiene = 0;
            List<BENotificaciones> olstNotificaciones = new List<BENotificaciones>();
            using (UsuarioServiceClient sv = new UsuarioServiceClient())
            {
                olstNotificaciones = sv.GetNotificacionesConsultora(oBEUsuario.PaisID, oBEUsuario.ConsultoraID).ToList();
            }
            if (olstNotificaciones.Count != 0)
            {
                int Cantidad = olstNotificaciones.Count(p => p.Visualizado == false);
                if (Cantidad > 0)
                    Tiene = 1;
            }
            return Tiene;
        }

        private void CargarEntidadesShowRoom(UsuarioModel model)
        {
            if (model == null) return;
            if (model.CargoEntidadesShowRoom) return;

            var paisesShowRoom = ConfigurationManager.AppSettings["PaisesShowRoom"];
            if (paisesShowRoom.Contains(model.CodigoISO))
            {
                try
                {
                    using (PedidoServiceClient sv = new PedidoServiceClient())
                    {
                        model.BeShowRoomConsultora = sv.GetShowRoomConsultora(model.PaisID, model.CampaniaID, model.CodigoConsultora);
                        model.BeShowRoom = sv.GetShowRoomEventoByCampaniaID(model.PaisID, model.CampaniaID);
                    }
                    model.CargoEntidadesShowRoom = true;
                }
                catch (Exception ex)
                {
                    Portal.Consultoras.Common.LogManager.SaveLog(ex, model.CodigoConsultora, model.CodigoISO);
                    model.CargoEntidadesShowRoom = false;
                }
            }
            else
            {
                model.BeShowRoomConsultora = null;
                model.BeShowRoom = null;
                model.CargoEntidadesShowRoom = true;
            }
        }

        #endregion

        protected string NombreMes(int Mes)
        {
            string Result = string.Empty;
            switch (Mes)
            {
                case 1:
                    Result = "Enero";
                    break;
                case 2:
                    Result = "Febrero";
                    break;
                case 3:
                    Result = "Marzo";
                    break;
                case 4:
                    Result = "Abril";
                    break;
                case 5:
                    Result = "Mayo";
                    break;
                case 6:
                    Result = "Junio";
                    break;
                case 7:
                    Result = "Julio";
                    break;
                case 8:
                    Result = "Agosto";
                    break;
                case 9:
                    Result = "Setiembre";
                    break;
                case 10:
                    Result = "Octubre";
                    break;
                case 11:
                    Result = "Noviembre";
                    break;
                case 12:
                    Result = "Diciembre";
                    break;
            }
            return Result;
        }

        protected string ConfigurarUrlServiceProl()
        {
            string ambiente = ConfigurationManager.AppSettings["Ambiente"];
            string pais = UserData().CodigoISO;
            string key = ambiente.Trim().ToUpper() + "_Prol_" + pais.Trim().ToUpper();
            return ConfigurationManager.AppSettings[key];
        }

        protected BEGrid SetGrid(string sidx, string sord, int page, int rows)
        {
            BEGrid grid = new BEGrid();
            grid.PageSize = rows <= 0 ? 10 : rows;
            grid.CurrentPage = page <= 0 ? 1 : page;
            grid.SortColumn = sidx ?? "";
            grid.SortOrder = sord ?? "asc";
            return grid;
        }

        #endregion
    }
}
