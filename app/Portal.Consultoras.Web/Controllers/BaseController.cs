using Portal.Consultoras.Web.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using AutoMapper;
using Portal.Consultoras.Web.ServiceUsuario;
using Portal.Consultoras.Web.ServiceSAC;
using System.Web.Routing;
using System.Security.Claims;
using System.Configuration;
using Portal.Consultoras.Web.ServiceZonificacion;
using Portal.Consultoras.Web.ServiceContenido;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.ServicePedido;

namespace Portal.Consultoras.Web.Controllers
{
    public class BaseController : Controller
    {
        public UsuarioModel userData;

        protected override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            try
            {
                userData = UserData();
                base.OnActionExecuting(filterContext);
                if (Session["UserData"] != null)
                {
                    ViewBag.Permiso = BuildMenu();
                    //ViewBag.Servicio = BuildMenuService();
                    MenuBelcorpResponde();
                    ViewBag.ServiceController = ConfigurationManager.AppSettings["ServiceController"].ToString();
                    ViewBag.ServiceAction = ConfigurationManager.AppSettings["ServiceAction"].ToString();
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
            }
        }

        /*Inicio Cambios_Landing_Comunidad*/
        public List<PermisoModel> BuildMenu()
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
                    //Mapper.CreateMap<ServiceSeguridad.BEPermiso, PermisoModel>()
                    //    .ForMember(x => x.PermisoID, t => t.MapFrom(c => c.PermisoID))
                    //    .ForMember(x => x.RolId, t => t.MapFrom(c => c.RolId))
                    //    .ForMember(x => x.Descripcion, t => t.MapFrom(c => c.Descripcion))
                    //    .ForMember(x => x.IdPadre, t => t.MapFrom(c => c.IdPadre))
                    //    .ForMember(x => x.OrdenItem, t => t.MapFrom(c => c.OrdenItem))
                    //    .ForMember(x => x.UrlItem, t => t.MapFrom(c => c.UrlItem))
                    //    .ForMember(x => x.PaginaNueva, t => t.MapFrom(c => c.PaginaNueva))
                    //    .ForMember(x => x.RolId, t => t.MapFrom(c => c.RolId))
                    //    .ForMember(x => x.Mostrar, t => t.MapFrom(c => c.Mostrar))
                    //    .ForMember(x => x.Posicion, t => t.MapFrom(c => c.Posicion))
                    //    .ForMember(x => x.UrlImagen, t => t.MapFrom(c => c.UrlImagen))
                    //    .ForMember(x => x.EsMenuEspecial, t => t.MapFrom(c => c.EsMenuEspecial))
                    //    .ForMember(x => x.EsSoloImagen, t => t.MapFrom(c => c.EsSoloImagen))
                    //    .ForMember(x => x.EsServicios, t => t.MapFrom(c => c.EsServicios));
                        //.ForMember(x => x.EsDireccionExterior, t => t.MapFrom(c => c.UrlItem.ToLower().StartsWith("http")));

                    // Obtener la información del menu y crear la estructura básica
                    //List<PermisoModel> lstModel = Mapper.Map<IList<ServiceSeguridad.BEPermiso>, List<PermisoModel>>(lst);

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

                    //Mapper.CreateMap<ServicioCampaniaModel, PermisoModel>()
                    //    .ForMember(x => x.Descripcion, t => t.MapFrom(c => c.Descripcion))
                    //    .ForMember(x => x.UrlItem, t => t.MapFrom(c => c.Url))
                    //    .ForMember(x => x.PaginaNueva, t => t.MapFrom(c => true))
                    //    .ForMember(x => x.EsDireccionExterior, t => t.MapFrom(c => c.Url.ToLower().StartsWith("http")))
                    //    .ForMember(x => x.Mostrar, t => t.MapFrom(c => true));

                    //temp.AddRange(Mapper.Map<List<PermisoModel>>(servicios));
                }

                itemMenu.SubMenus = temp;
            }
        }

        /*Fin Cambios_Landing_Comunidad*/

        //RQ_PBS- R2161
        public List<ServicioCampaniaModel> BuildMenuService()
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
                ViewBag.ListaProductoFaltante = model.ModelPedido.ListaProductoFaltante;
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
                string displayTiempo = tiempo.ToString("hh:mm tt").Replace(".", "").Replace(" ", "");

                string TextoPromesa = ".</b></p>";
                string TextoNuevoProl = "<p>Revisa tus notificaciones o correo para comprobar que tu pedido esté completo.</p>";

                if (model.TipoCasoPromesa != "0")
                {
                    if (model.TipoCasoPromesa == "1" && model.DiasCasoPromesa != -1)
                    {
                        TextoPromesa = "</b> y recíbelo en " + model.DiasCasoPromesa + (model.DiasCasoPromesa == 1 ? " día" : " días") + ".</p>";
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
                    ViewBag.MensajeCierreCampania = "<p>Pasa o modifica tu pedido hasta el dia de <b>hoy a las  " + displayTiempo;
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
                
                return model;
                
                #endregion
            }
            else
            {
                #region else Session["UserData"] != null

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


                    BEPais PaisModel = lst.First(p => p.CodigoISO == Pais || p.CodigoISO != Pais);
                    if (PaisModel != null)
                        GetUserData(PaisModel.PaisID, Codigo, Tipo);
                }
                
                model = (UsuarioModel)Session["UserData"];
                if (model == null) return model;
                if(model != null) this.CargarEntidadesShowRoom(model);

                ViewBag.Usuario = "Hola, " + (string.IsNullOrEmpty(model.Sobrenombre) ? model.NombreConsultora : model.Sobrenombre);
                ViewBag.Rol = model.RolID;
                ViewBag.ListaProductoFaltante = model.ModelPedido.ListaProductoFaltante;
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
                string displayTiempo = tiempo.ToString("hh:mm tt").Replace(".", "").Replace(" ", "");

                string TextoPromesa = ".</b></p>";
                string TextoNuevoProl = "<p>Revisa tus notificaciones o correo para comprobar que tu pedido esté completo.</p>";

                if (model.TipoCasoPromesa != "0")
                {
                    if (model.TipoCasoPromesa == "1" && model.DiasCasoPromesa != -1)
                    {
                        TextoPromesa = "</b> y recíbelo en " + model.DiasCasoPromesa + (model.DiasCasoPromesa == 1 ? " día" : " días") + ".</p>";
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
                    ViewBag.MensajeCierreCampania = "<p>Pasa o modifica tu pedido hasta el dia de <b>hoy a las  " + displayTiempo;
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

                return model;

                #endregion
            }
        }

        public void SetUserData(UsuarioModel model)
        {
            Session["UserData"] = model;
        }

        public UsuarioModel GetUserData(int PaisID, string CodigoUsuario, int TipoUsuario)
        {
            UsuarioModel model = null;
            BEUsuario oBEUsuario = null;

            //r20151104
            string valores="";
            string[] arrValores;
            //r20151104

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
                model.PROLSinStock = oBEUsuario.PROLSinStock;//1510
                model.CampanaInvitada = oBEUsuario.CampanaInvitada; //1796
                model.InscritaFlexipago = oBEUsuario.InscritaFlexipago; //1796
                model.IndicadorFlexiPago = oBEUsuario.IndicadorFlexiPago; //1796
                model.InvitacionRechazada = oBEUsuario.InvitacionRechazada; //1796
                model.SegmentoConstancia = oBEUsuario.SegmentoConstancia;  //2469

                if (DateTime.Now.AddHours(oBEUsuario.ZonaHoraria) < oBEUsuario.FechaInicioFacturacion.AddDays(-oBEUsuario.DiasAntes))
                {
                    model.DiaPROL = false;
                    model.FechaFacturacion = oBEUsuario.FechaInicioFacturacion.AddDays(-oBEUsuario.DiasAntes);
                    if (oBEUsuario.DiasAntes == 0)
                        model.HoraFacturacion = oBEUsuario.HoraInicio;
                    else
                        model.HoraFacturacion = oBEUsuario.HoraInicioNoFacturable;
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
                    case Portal.Consultoras.Common.Constantes.Rol.Administrador:
                        model.FechaFinCampania = oBEUsuario.FechaFinFacturacion;
                        break;
                    case Portal.Consultoras.Common.Constantes.Rol.Consultora:
                        model.FechaFinCampania = oBEUsuario.FechaFinFacturacion;
                        break;

                }

                model.ZonaValida = oBEUsuario.ZonaValida;
                model.MontoMinimo = oBEUsuario.MontoMinimoPedido;
                model.MontoMaximo = oBEUsuario.MontoMaximoPedido;
                model.Simbolo = oBEUsuario.Simbolo;
                model.CodigoTerritorio = oBEUsuario.CodigoTerritorio;
                model.ModelPedido = GetModelPedidoAgotado(model.PaisID, model.CampaniaID, model.ZonaID);
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
                //Inicio ITG 1793 HFMG
                model.ConsultoraAsociada = oBEUsuario.ConsultoraAsociada;
                //Inicio ITG 1793 HFMG
                //CCSS_JZ_PROL
                //R 2319
                model.MenuNotificaciones = 1;// MenuNotificaciones(oBEUsuario);
                if (model.MenuNotificaciones == 1)
                {
                    model.TieneNotificaciones = TieneNotificaciones(oBEUsuario);
                }
                //RQ_NP - R2133
                model.NuevoPROL = oBEUsuario.NuevoPROL;
                //RQ_NP - R2133
                model.ZonaNuevoPROL = oBEUsuario.ZonaNuevoPROL;
                model.EMailActivo = oBEUsuario.EMailActivo;//2532 EGL
                model.EMail = oBEUsuario.EMail;//2532 EGL
                model.EsquemaDAConsultora = oBEUsuario.EsquemaDAConsultora;
                //RQ_FP - R2161

                if (oBEUsuario.CampaniaID != 0) {
                    valores = GetFechaPromesaEntrega(oBEUsuario.PaisID, oBEUsuario.CampaniaID, oBEUsuario.CodigoConsultora, oBEUsuario.FechaInicioFacturacion);
                    arrValores = valores.Split('|');
                    //model.FechaPromesaEntrega                    
                }

                List<TipoLinkModel> lista = GetLinksPorPais(model.PaisID);
                if (lista.Count > 0)
                {
                    model.UrlAyuda = lista.Find(x => x.TipoLinkID == 301).Url;
                    model.UrlCapedevi = lista.Find(x => x.TipoLinkID == 302).Url;
                    model.UrlTerminos = lista.Find(x => x.TipoLinkID == 303).Url;
                }
                /*Cambios_Landing_Comunidad*/
                model.EsUsuarioComunidad = EsUsuarioComunidad(oBEUsuario.PaisID, oBEUsuario.CodigoUsuario);
                /*RE2544 - CS*/
                model.SegmentoInternoID = oBEUsuario.SegmentoInternoID;
                model.ValidacionInteractiva = oBEUsuario.ValidacionInteractiva;
                model.MensajeValidacionInteractiva = oBEUsuario.MensajeValidacionInteractiva;

                // Pago Online CO - CL - PR
                model.IndicadorPagoOnline = model.PaisID == 4 || model.PaisID == 3 || model.PaisID == 12 ? 1: 0;
                model.UrlPagoOnline = model.PaisID == 4 ? "https://www.zonapagos.com/pagosn2/LoginCliente"
                    : model.PaisID == 3 ? "https://www.belcorpchile.cl/BotonesPagoRedireccion/PagoConsultora.aspx"
                    : model.PaisID == 12 ? "https://www.somosbelcorp.com/Paypal"
                    : "";

            }
            Session["UserData"] = model;

            return model;
        }

        public PedidoDetalleModel GetModelPedidoAgotado(int PaisID, int CampaniaID, int ZonaID)
        {
            List<ServiceSAC.BEProductoFaltante> olstProductoFaltante = new List<ServiceSAC.BEProductoFaltante>();
            using (ServiceSAC.SACServiceClient sv = new ServiceSAC.SACServiceClient())
            {
                olstProductoFaltante = sv.GetProductoFaltanteByCampaniaAndZonaID(PaisID, CampaniaID, ZonaID).ToList();
            }
            PedidoDetalleModel PedidoModelo = new PedidoDetalleModel();
            PedidoModelo.ListaProductoFaltante = olstProductoFaltante;
            //ViewBag.ModelPedido = PedidoModelo;
            return PedidoModelo;
        }

        public List<TipoLinkModel> GetLinksPorPais(int PaisID)
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

        public bool GetPermisoFlexipago(int PaisID, string PaisISO, string CodigoConsultora, int CampaniaID)
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

        public string NombreMes(int Mes)
        {
            string Result = string.Empty;
            switch (Mes)
            {
                case 1: Result = "Enero";
                    break;
                case 2: Result = "Febrero";
                    break;
                case 3: Result = "Marzo";
                    break;
                case 4: Result = "Abril";
                    break;
                case 5: Result = "Mayo";
                    break;
                case 6: Result = "Junio";
                    break;
                case 7: Result = "Julio";
                    break;
                case 8: Result = "Agosto";
                    break;
                case 9: Result = "Setiembre";
                    break;
                case 10: Result = "Octubre";
                    break;
                case 11: Result = "Noviembre";
                    break;
                case 12: Result = "Diciembre";
                    break;
            }
            return Result;
        }

        public string NombreCampania(string Campania)
        {
            string Result = Campania;
            try
            {
                if (Campania.Length == 6)
                {
                    // return Result = string.Format("C{0} - {1}", Campania.Substring(4, 2), Campania.Substring(0, 4)); -- 2205
                    return Result = string.Format("Campaña {0}", Campania.Substring(4, 2));
                }
            }
            catch { }
            return Result;
        }

        public string ConfigurarUrlServiceProl()
        {
            string ambiente = ConfigurationManager.AppSettings["Ambiente"];
            string pais = UserData().CodigoISO;
            return ConfigurarUrlServiceProl(ambiente, pais);
        }

        public string ConfigurarUrlServiceProl(string ambiente, string pais)
        {
            string key = ambiente.Trim().ToUpper() + "_Prol_" + pais.Trim().ToUpper();
            //string prueba = ConfigurationManager.AppSettings["QA_Prol_PE"];
            //string prueba2 = ConfigurationManager.AppSettings[key];
            return ConfigurationManager.AppSettings[key];
        }

        public string GetIPCliente()
        {
            string IP = string.Empty;
            try
            {
                IP = HttpContext.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];
            }
            catch { }
            return IP;
        }

        public void MenuBelcorpResponde()
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

        public string DevolverRolDescripcion(int PaisID, int RolID)
        {
            string Result = string.Empty;

            switch (RolID)
            {
                case 1:
                    Result = "Consultora";
                    break;
                case 2:
                    Result = "Administrador";
                    break;
                case 3:
                    Result = "Adm SAC";
                    break;
                case 4:
                    Result = "Adm Contenido";
                    break;
                case 5:
                    Result = "Procesar Pedidos";
                    break;
                case 6:
                    Result = "Call Center";
                    break;
                case 7:
                    Result = "SAC";
                    break;
                case 8:
                    Result = "Soporte";
                    break;
                case 9:
                    if (PaisID == 2)
                        Result = "Gerente Regional";
                    else
                        Result = "Soporte SAC";
                    break;
                case 10:
                    if (PaisID == 2)
                        Result = "Soporte SAC";
                    else if (PaisID == 3)
                        Result = "SAC 2";
                    else
                        Result = "CC y R. DD y WEB";
                    break;
                case 11:
                    Result = "SAC 2";
                    break;
                case 12:
                    Result = "Digital Pais";
                    break;
                default:
                    Result = "Otro";
                    break;
            }

            return Result;
        }
        //CCSS_JZ_PROL
        //RQ_NP - R2133
        public int MenuNotificaciones(BEUsuario oBEUsuario)
        {
            if (oBEUsuario.NuevoPROL && oBEUsuario.ZonaNuevoPROL)
                return 1;
            else
                return 0;
        }

        //CCSS_JZ_PROL
        public bool RegionPROL(string ISOPais, string CodRegion)
        {
            bool Result = false;
            string[] paises = ConfigurationManager.AppSettings["RegionesPROLv2"].Split(';');
            if (paises != null)
            {
                if (paises.Length != 0)
                {
                    foreach (string item in paises)
                    {
                        if (item.Contains(ISOPais))
                        {
                            if (item.Contains("ALL"))
                                Result = true;
                            else
                                Result = item.Contains(CodRegion);
                        }
                    }
                }
            }

            return Result;
        }
        //CCSS_JZ_PROL
        public int TieneNotificaciones(BEUsuario oBEUsuario)
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

        //RQ_FP - R2161
        //public DateTime GetFechaPromesaEntrega(int PaisId, int CampaniaId, string CodigoConsultora, DateTime FechaFact)
        public String GetFechaPromesaEntrega(int PaisId, int CampaniaId, string CodigoConsultora, DateTime FechaFact)
        {
            //DateTime Fecha = Convert.ToDateTime("2000-01-01");
            String Valores="";
            try
            {
                using (UsuarioServiceClient sv = new UsuarioServiceClient())
                {
                    Valores = sv.GetFechaPromesaCronogramaByCampania(PaisId, CampaniaId, CodigoConsultora, FechaFact);
                }
            }
            catch
            {

            }
            return Valores;
        }
        /*Inicio Cambios_Landing_Comunidad*/
        public bool EsUsuarioComunidad(int PaisId, string CodigoUsuario)
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
        /*Fin Cambios_Landing_Comunidad*/

        protected void CargarEntidadesShowRoom(UsuarioModel model)
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

                        if (model.BeShowRoom != null)
                        {
                            var carpetaPais = Globals.UrlMatriz + "/" + model.CodigoISO;

                            model.BeShowRoom.Imagen1 = string.IsNullOrEmpty(model.BeShowRoom.Imagen1)
                                ? "" : ConfigS3.GetUrlFileS3(carpetaPais, model.BeShowRoom.Imagen1, Globals.RutaImagenesMatriz + "/" + model.CodigoISO);
                            model.BeShowRoom.Imagen2 = string.IsNullOrEmpty(model.BeShowRoom.Imagen2)
                                ? "" : ConfigS3.GetUrlFileS3(carpetaPais, model.BeShowRoom.Imagen2, Globals.RutaImagenesMatriz + "/" + model.CodigoISO);
                            model.BeShowRoom.ImagenCabeceraProducto = string.IsNullOrEmpty(model.BeShowRoom.ImagenCabeceraProducto)
                                ? "" : ConfigS3.GetUrlFileS3(carpetaPais, model.BeShowRoom.ImagenCabeceraProducto, Globals.RutaImagenesMatriz + "/" + model.CodigoISO);
                            model.BeShowRoom.ImagenVentaSetPopup = string.IsNullOrEmpty(model.BeShowRoom.ImagenVentaSetPopup)
                                ? "" : ConfigS3.GetUrlFileS3(carpetaPais, model.BeShowRoom.ImagenVentaSetPopup, Globals.RutaImagenesMatriz + "/" + model.CodigoISO);
                            model.BeShowRoom.ImagenVentaTagLateral = string.IsNullOrEmpty(model.BeShowRoom.ImagenVentaTagLateral)
                                ? "" : ConfigS3.GetUrlFileS3(carpetaPais, model.BeShowRoom.ImagenVentaTagLateral, Globals.RutaImagenesMatriz + "/" + model.CodigoISO);
                            model.BeShowRoom.ImagenPestaniaShowRoom = string.IsNullOrEmpty(model.BeShowRoom.ImagenPestaniaShowRoom)
                                ? "" : ConfigS3.GetUrlFileS3(carpetaPais, model.BeShowRoom.ImagenPestaniaShowRoom, Globals.RutaImagenesMatriz + "/" + model.CodigoISO);
                            model.BeShowRoom.ImagenPreventaDigital = string.IsNullOrEmpty(model.BeShowRoom.ImagenPreventaDigital)
                                ? "" : ConfigS3.GetUrlFileS3(carpetaPais, model.BeShowRoom.ImagenPreventaDigital, Globals.RutaImagenesMatriz + "/" + model.CodigoISO);
                        }
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

        protected BEGrid SetGrid(string sidx, string sord, int page, int rows)
        {
            BEGrid grid = new BEGrid();
            grid.PageSize = rows <= 0 ? 10 : rows;
            grid.CurrentPage = page <= 0 ? 1 : page;
            grid.SortColumn = sidx ?? "";
            grid.SortOrder = sord ?? "asc";
            return grid;
        }
        
          protected Converter<decimal, string> CreateConverterDecimalToString(int paisID)
        {
            if (paisID == 4) return new Converter<decimal, string>(p => p.ToString("n0", new System.Globalization.CultureInfo("es-CO")));
            return new Converter<decimal, string>(p => p.ToString("n2", new System.Globalization.CultureInfo("es-PE")));
        }
    }
}
